package android.net;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.SystemClock;
import android.provider.Settings.Global;
import android.util.Log;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketTimeoutException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;

public final class DnsPinger extends Handler {
    private static final int ACTION_CANCEL_ALL_PINGS = 327683;
    private static final int ACTION_LISTEN_FOR_RESPONSE = 327682;
    private static final int ACTION_PING_DNS = 327681;
    private static final int BASE = 327680;
    private static final boolean DBG = false;
    public static final int DNS_PING_RESULT = 327680;
    private static final int DNS_PORT = 53;
    private static final int RECEIVE_POLL_INTERVAL_MS = 200;
    public static final int SOCKET_EXCEPTION = -2;
    private static final int SOCKET_TIMEOUT_MS = 1;
    public static final int TIMEOUT = -1;
    private static final byte[] mDnsQuery;
    private static final AtomicInteger sCounter;
    private static final Random sRandom;
    private String TAG;
    private List<ActivePing> mActivePings;
    private final int mConnectionType;
    private ConnectivityManager mConnectivityManager;
    private final Context mContext;
    private AtomicInteger mCurrentToken;
    private final ArrayList<InetAddress> mDefaultDns;
    private int mEventCounter;
    private final Handler mTarget;

    private class ActivePing {
        int internalId;
        short packetId;
        Integer result;
        DatagramSocket socket;
        long start;
        int timeout;

        private ActivePing() {
            this.start = SystemClock.elapsedRealtime();
        }
    }

    private class DnsArg {
        InetAddress dns;
        int seq;

        DnsArg(InetAddress d, int s) {
            this.dns = d;
            this.seq = s;
        }
    }

    static {
        sRandom = new Random();
        sCounter = new AtomicInteger();
        mDnsQuery = new byte[]{(byte) 0, (byte) 0, (byte) 1, (byte) 0, (byte) 0, (byte) 1, (byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 0, (byte) 3, (byte) 119, (byte) 119, (byte) 119, (byte) 6, (byte) 103, (byte) 111, (byte) 111, (byte) 103, (byte) 108, (byte) 101, (byte) 3, (byte) 99, (byte) 111, (byte) 109, (byte) 0, (byte) 0, (byte) 1, (byte) 0, (byte) 1};
    }

    public DnsPinger(Context context, String TAG, Looper looper, Handler target, int connectionType) {
        super(looper);
        this.mConnectivityManager = null;
        this.mCurrentToken = new AtomicInteger();
        this.mActivePings = new ArrayList();
        this.TAG = TAG;
        this.mContext = context;
        this.mTarget = target;
        this.mConnectionType = connectionType;
        if (ConnectivityManager.isNetworkTypeValid(connectionType)) {
            this.mDefaultDns = new ArrayList();
            this.mDefaultDns.add(getDefaultDns());
            this.mEventCounter = 0;
            return;
        }
        throw new IllegalArgumentException("Invalid connectionType in constructor: " + connectionType);
    }

    public void handleMessage(Message msg) {
        switch (msg.what) {
            case ACTION_PING_DNS /*327681*/:
                DnsArg dnsArg = msg.obj;
                if (dnsArg.seq == this.mCurrentToken.get()) {
                    try {
                        ActivePing newActivePing = new ActivePing(null);
                        InetAddress dnsAddress = dnsArg.dns;
                        newActivePing.internalId = msg.arg1;
                        newActivePing.timeout = msg.arg2;
                        newActivePing.socket = new DatagramSocket();
                        newActivePing.socket.setSoTimeout(SOCKET_TIMEOUT_MS);
                        try {
                            newActivePing.socket.setNetworkInterface(NetworkInterface.getByName(getCurrentLinkProperties().getInterfaceName()));
                        } catch (Exception e) {
                            loge("sendDnsPing::Error binding to socket " + e);
                        }
                        newActivePing.packetId = (short) sRandom.nextInt();
                        byte[] buf = (byte[]) mDnsQuery.clone();
                        buf[0] = (byte) (newActivePing.packetId >> 8);
                        buf[SOCKET_TIMEOUT_MS] = (byte) newActivePing.packetId;
                        DatagramPacket packet = new DatagramPacket(buf, buf.length, dnsAddress, DNS_PORT);
                        newActivePing.socket.send(packet);
                        this.mActivePings.add(newActivePing);
                        this.mEventCounter += SOCKET_TIMEOUT_MS;
                        sendMessageDelayed(obtainMessage(ACTION_LISTEN_FOR_RESPONSE, this.mEventCounter, 0), 200);
                    } catch (IOException e2) {
                        sendResponse(msg.arg1, -9999, SOCKET_EXCEPTION);
                    }
                }
            case ACTION_LISTEN_FOR_RESPONSE /*327682*/:
                if (msg.arg1 == this.mEventCounter) {
                    ActivePing curPing;
                    for (ActivePing curPing2 : this.mActivePings) {
                        try {
                            byte[] responseBuf = new byte[2];
                            DatagramPacket replyPacket = new DatagramPacket(responseBuf, 2);
                            curPing2.socket.receive(replyPacket);
                            if (responseBuf[0] == ((byte) (curPing2.packetId >> 8)) && responseBuf[SOCKET_TIMEOUT_MS] == ((byte) curPing2.packetId)) {
                                curPing2.result = Integer.valueOf((int) (SystemClock.elapsedRealtime() - curPing2.start));
                            }
                        } catch (SocketTimeoutException e3) {
                        } catch (Exception e4) {
                            curPing2.result = Integer.valueOf(SOCKET_EXCEPTION);
                        }
                    }
                    Iterator<ActivePing> iter = this.mActivePings.iterator();
                    while (iter.hasNext()) {
                        curPing2 = (ActivePing) iter.next();
                        if (curPing2.result != null) {
                            sendResponse(curPing2.internalId, curPing2.packetId, curPing2.result.intValue());
                            curPing2.socket.close();
                            iter.remove();
                        } else {
                            if (SystemClock.elapsedRealtime() > curPing2.start + ((long) curPing2.timeout)) {
                                sendResponse(curPing2.internalId, curPing2.packetId, TIMEOUT);
                                curPing2.socket.close();
                                iter.remove();
                            }
                        }
                    }
                    if (!this.mActivePings.isEmpty()) {
                        sendMessageDelayed(obtainMessage(ACTION_LISTEN_FOR_RESPONSE, this.mEventCounter, 0), 200);
                    }
                }
            case ACTION_CANCEL_ALL_PINGS /*327683*/:
                for (ActivePing activePing : this.mActivePings) {
                    activePing.socket.close();
                }
                this.mActivePings.clear();
            default:
        }
    }

    public List<InetAddress> getDnsList() {
        LinkProperties curLinkProps = getCurrentLinkProperties();
        if (curLinkProps == null) {
            loge("getCurLinkProperties:: LP for type" + this.mConnectionType + " is null!");
            return this.mDefaultDns;
        }
        Collection<InetAddress> dnses = curLinkProps.getDnsServers();
        if (dnses != null && dnses.size() != 0) {
            return new ArrayList(dnses);
        }
        loge("getDns::LinkProps has null dns - returning default");
        return this.mDefaultDns;
    }

    public int pingDnsAsync(InetAddress dns, int timeout, int delay) {
        int id = sCounter.incrementAndGet();
        sendMessageDelayed(obtainMessage(ACTION_PING_DNS, id, timeout, new DnsArg(dns, this.mCurrentToken.get())), (long) delay);
        return id;
    }

    public void cancelPings() {
        this.mCurrentToken.incrementAndGet();
        obtainMessage(ACTION_CANCEL_ALL_PINGS).sendToTarget();
    }

    private void sendResponse(int internalId, int externalId, int responseVal) {
        this.mTarget.sendMessage(obtainMessage(DNS_PING_RESULT, internalId, responseVal));
    }

    private LinkProperties getCurrentLinkProperties() {
        if (this.mConnectivityManager == null) {
            this.mConnectivityManager = (ConnectivityManager) this.mContext.getSystemService(Context.CONNECTIVITY_SERVICE);
        }
        return this.mConnectivityManager.getLinkProperties(this.mConnectionType);
    }

    private InetAddress getDefaultDns() {
        String dns = Global.getString(this.mContext.getContentResolver(), "default_dns_server");
        if (dns == null || dns.length() == 0) {
            dns = this.mContext.getResources().getString(17039404);
        }
        try {
            return NetworkUtils.numericToInetAddress(dns);
        } catch (IllegalArgumentException e) {
            loge("getDefaultDns::malformed default dns address");
            return null;
        }
    }

    private void log(String s) {
        Log.d(this.TAG, s);
    }

    private void loge(String s) {
        Log.e(this.TAG, s);
    }
}
