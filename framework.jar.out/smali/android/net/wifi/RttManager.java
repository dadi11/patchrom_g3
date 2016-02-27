package android.net.wifi;

import android.content.Context;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.RemoteException;
import android.util.Log;
import android.util.SparseArray;
import com.android.internal.util.AsyncChannel;
import java.util.concurrent.CountDownLatch;

public class RttManager {
    public static final int BASE = 160256;
    public static final int CMD_OP_ABORTED = 160260;
    public static final int CMD_OP_FAILED = 160258;
    public static final int CMD_OP_START_RANGING = 160256;
    public static final int CMD_OP_STOP_RANGING = 160257;
    public static final int CMD_OP_SUCCEEDED = 160259;
    private static final boolean DBG = false;
    public static final String DESCRIPTION_KEY = "android.net.wifi.RttManager.Description";
    private static final int INVALID_KEY = 0;
    public static final int REASON_INVALID_LISTENER = -3;
    public static final int REASON_INVALID_REQUEST = -4;
    public static final int REASON_NOT_AVAILABLE = -2;
    public static final int REASON_UNSPECIFIED = -1;
    public static final int RTT_CHANNEL_WIDTH_10 = 6;
    public static final int RTT_CHANNEL_WIDTH_160 = 3;
    public static final int RTT_CHANNEL_WIDTH_20 = 0;
    public static final int RTT_CHANNEL_WIDTH_40 = 1;
    public static final int RTT_CHANNEL_WIDTH_5 = 5;
    public static final int RTT_CHANNEL_WIDTH_80 = 2;
    public static final int RTT_CHANNEL_WIDTH_80P80 = 4;
    public static final int RTT_CHANNEL_WIDTH_UNSPECIFIED = -1;
    public static final int RTT_PEER_TYPE_AP = 1;
    public static final int RTT_PEER_TYPE_STA = 2;
    public static final int RTT_PEER_TYPE_UNSPECIFIED = 0;
    public static final int RTT_STATUS_ABORTED = 8;
    public static final int RTT_STATUS_FAILURE = 1;
    public static final int RTT_STATUS_FAIL_AP_ON_DIFF_CHANNEL = 6;
    public static final int RTT_STATUS_FAIL_NOT_SCHEDULED_YET = 4;
    public static final int RTT_STATUS_FAIL_NO_CAPABILITY = 7;
    public static final int RTT_STATUS_FAIL_NO_RSP = 2;
    public static final int RTT_STATUS_FAIL_REJECTED = 3;
    public static final int RTT_STATUS_FAIL_TM_TIMEOUT = 5;
    public static final int RTT_STATUS_SUCCESS = 0;
    public static final int RTT_TYPE_11_MC = 4;
    public static final int RTT_TYPE_11_V = 2;
    public static final int RTT_TYPE_ONE_SIDED = 1;
    public static final int RTT_TYPE_UNSPECIFIED = 0;
    private static final String TAG = "RttManager";
    private static AsyncChannel sAsyncChannel;
    private static CountDownLatch sConnected;
    private static HandlerThread sHandlerThread;
    private static int sListenerKey;
    private static final SparseArray sListenerMap;
    private static final Object sListenerMapLock;
    private static int sThreadRefCount;
    private static final Object sThreadRefLock;
    private Context mContext;
    private IRttManager mService;

    public class Capabilities {
        public int supportedPeerType;
        public int supportedType;
    }

    public static class ParcelableRttParams implements Parcelable {
        public static final Creator<ParcelableRttParams> CREATOR;
        public RttParams[] mParams;

        /* renamed from: android.net.wifi.RttManager.ParcelableRttParams.1 */
        static class C05231 implements Creator<ParcelableRttParams> {
            C05231() {
            }

            public ParcelableRttParams createFromParcel(Parcel in) {
                int num = in.readInt();
                if (num == 0) {
                    return new ParcelableRttParams(null);
                }
                RttParams[] params = new RttParams[num];
                for (int i = RttManager.RTT_TYPE_UNSPECIFIED; i < num; i += RttManager.RTT_TYPE_ONE_SIDED) {
                    params[i] = new RttParams();
                    params[i].deviceType = in.readInt();
                    params[i].requestType = in.readInt();
                    params[i].bssid = in.readString();
                    params[i].frequency = in.readInt();
                    params[i].channelWidth = in.readInt();
                    params[i].num_samples = in.readInt();
                    params[i].num_retries = in.readInt();
                }
                return new ParcelableRttParams(params);
            }

            public ParcelableRttParams[] newArray(int size) {
                return new ParcelableRttParams[size];
            }
        }

        ParcelableRttParams(RttParams[] params) {
            this.mParams = params;
        }

        public int describeContents() {
            return RttManager.RTT_TYPE_UNSPECIFIED;
        }

        public void writeToParcel(Parcel dest, int flags) {
            if (this.mParams != null) {
                dest.writeInt(this.mParams.length);
                RttParams[] arr$ = this.mParams;
                int len$ = arr$.length;
                for (int i$ = RttManager.RTT_TYPE_UNSPECIFIED; i$ < len$; i$ += RttManager.RTT_TYPE_ONE_SIDED) {
                    RttParams params = arr$[i$];
                    dest.writeInt(params.deviceType);
                    dest.writeInt(params.requestType);
                    dest.writeString(params.bssid);
                    dest.writeInt(params.frequency);
                    dest.writeInt(params.channelWidth);
                    dest.writeInt(params.num_samples);
                    dest.writeInt(params.num_retries);
                }
                return;
            }
            dest.writeInt(RttManager.RTT_TYPE_UNSPECIFIED);
        }

        static {
            CREATOR = new C05231();
        }
    }

    public static class ParcelableRttResults implements Parcelable {
        public static final Creator<ParcelableRttResults> CREATOR;
        public RttResult[] mResults;

        /* renamed from: android.net.wifi.RttManager.ParcelableRttResults.1 */
        static class C05241 implements Creator<ParcelableRttResults> {
            C05241() {
            }

            public ParcelableRttResults createFromParcel(Parcel in) {
                int num = in.readInt();
                if (num == 0) {
                    return new ParcelableRttResults(null);
                }
                RttResult[] results = new RttResult[num];
                for (int i = RttManager.RTT_TYPE_UNSPECIFIED; i < num; i += RttManager.RTT_TYPE_ONE_SIDED) {
                    results[i] = new RttResult();
                    results[i].bssid = in.readString();
                    results[i].status = in.readInt();
                    results[i].requestType = in.readInt();
                    results[i].ts = in.readLong();
                    results[i].rssi = in.readInt();
                    results[i].rssi_spread = in.readInt();
                    results[i].tx_rate = in.readInt();
                    results[i].rtt_ns = in.readLong();
                    results[i].rtt_sd_ns = in.readLong();
                    results[i].rtt_spread_ns = in.readLong();
                    results[i].distance_cm = in.readInt();
                    results[i].distance_sd_cm = in.readInt();
                    results[i].distance_spread_cm = in.readInt();
                }
                return new ParcelableRttResults(results);
            }

            public ParcelableRttResults[] newArray(int size) {
                return new ParcelableRttResults[size];
            }
        }

        public ParcelableRttResults(RttResult[] results) {
            this.mResults = results;
        }

        public int describeContents() {
            return RttManager.RTT_TYPE_UNSPECIFIED;
        }

        public void writeToParcel(Parcel dest, int flags) {
            if (this.mResults != null) {
                dest.writeInt(this.mResults.length);
                RttResult[] arr$ = this.mResults;
                int len$ = arr$.length;
                for (int i$ = RttManager.RTT_TYPE_UNSPECIFIED; i$ < len$; i$ += RttManager.RTT_TYPE_ONE_SIDED) {
                    RttResult result = arr$[i$];
                    dest.writeString(result.bssid);
                    dest.writeInt(result.status);
                    dest.writeInt(result.requestType);
                    dest.writeLong(result.ts);
                    dest.writeInt(result.rssi);
                    dest.writeInt(result.rssi_spread);
                    dest.writeInt(result.tx_rate);
                    dest.writeLong(result.rtt_ns);
                    dest.writeLong(result.rtt_sd_ns);
                    dest.writeLong(result.rtt_spread_ns);
                    dest.writeInt(result.distance_cm);
                    dest.writeInt(result.distance_sd_cm);
                    dest.writeInt(result.distance_spread_cm);
                }
                return;
            }
            dest.writeInt(RttManager.RTT_TYPE_UNSPECIFIED);
        }

        static {
            CREATOR = new C05241();
        }
    }

    public interface RttListener {
        void onAborted();

        void onFailure(int i, String str);

        void onSuccess(RttResult[] rttResultArr);
    }

    public static class RttParams {
        public String bssid;
        public int channelWidth;
        public int deviceType;
        public int frequency;
        public int num_retries;
        public int num_samples;
        public int requestType;
    }

    public static class RttResult {
        public String bssid;
        public int distance_cm;
        public int distance_sd_cm;
        public int distance_spread_cm;
        public int requestType;
        public int rssi;
        public int rssi_spread;
        public long rtt_ns;
        public long rtt_sd_ns;
        public long rtt_spread_ns;
        public int status;
        public long ts;
        public int tx_rate;
    }

    private static class ServiceHandler extends Handler {
        ServiceHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 69632:
                    if (msg.arg1 == 0) {
                        RttManager.sAsyncChannel.sendMessage(69633);
                    } else {
                        Log.e(RttManager.TAG, "Failed to set up channel connection");
                        RttManager.sAsyncChannel = null;
                    }
                    RttManager.sConnected.countDown();
                case 69634:
                case 69636:
                    Log.e(RttManager.TAG, "Channel connection lost");
                    RttManager.sAsyncChannel = null;
                    getLooper().quit();
                default:
                    Object listener = RttManager.getListener(msg.arg2);
                    if (listener != null) {
                        switch (msg.what) {
                            case RttManager.CMD_OP_FAILED /*160258*/:
                                reportFailure(listener, msg);
                                RttManager.removeListener(msg.arg2);
                            case RttManager.CMD_OP_SUCCEEDED /*160259*/:
                                reportSuccess(listener, msg);
                                RttManager.removeListener(msg.arg2);
                            case RttManager.CMD_OP_ABORTED /*160260*/:
                                ((RttListener) listener).onAborted();
                                RttManager.removeListener(msg.arg2);
                            default:
                        }
                    }
            }
        }

        void reportSuccess(Object listener, Message msg) {
            RttListener rttListener = (RttListener) listener;
            ((RttListener) listener).onSuccess(msg.obj.mResults);
        }

        void reportFailure(Object listener, Message msg) {
            RttListener rttListener = (RttListener) listener;
            ((RttListener) listener).onFailure(msg.arg1, msg.obj.getString(RttManager.DESCRIPTION_KEY));
        }
    }

    public Capabilities getCapabilities() {
        return new Capabilities();
    }

    public void startRanging(RttParams[] params, RttListener listener) {
        validateChannel();
        sAsyncChannel.sendMessage(CMD_OP_START_RANGING, RTT_TYPE_UNSPECIFIED, putListener(listener), new ParcelableRttParams(params));
    }

    public void stopRanging(RttListener listener) {
        validateChannel();
        sAsyncChannel.sendMessage(CMD_OP_STOP_RANGING, RTT_TYPE_UNSPECIFIED, removeListener((Object) listener));
    }

    static {
        sListenerKey = RTT_TYPE_ONE_SIDED;
        sListenerMap = new SparseArray();
        sListenerMapLock = new Object();
        sThreadRefLock = new Object();
    }

    public RttManager(Context context, IRttManager service) {
        this.mContext = context;
        this.mService = service;
        init();
    }

    private void init() {
        synchronized (sThreadRefLock) {
            int i = sThreadRefCount + RTT_TYPE_ONE_SIDED;
            sThreadRefCount = i;
            if (i == RTT_TYPE_ONE_SIDED) {
                Messenger messenger = null;
                try {
                    Log.d(TAG, "Get the messenger from " + this.mService);
                    messenger = this.mService.getMessenger();
                } catch (RemoteException e) {
                } catch (SecurityException e2) {
                }
                if (messenger == null) {
                    sAsyncChannel = null;
                    return;
                }
                sHandlerThread = new HandlerThread("WifiScanner");
                sAsyncChannel = new AsyncChannel();
                sConnected = new CountDownLatch(RTT_TYPE_ONE_SIDED);
                sHandlerThread.start();
                sAsyncChannel.connect(this.mContext, new ServiceHandler(sHandlerThread.getLooper()), messenger);
                try {
                    sConnected.await();
                } catch (InterruptedException e3) {
                    Log.e(TAG, "interrupted wait at init");
                }
            }
        }
    }

    private void validateChannel() {
        if (sAsyncChannel == null) {
            throw new IllegalStateException("No permission to access and change wifi or a bad initialization");
        }
    }

    private static int putListener(Object listener) {
        if (listener == null) {
            return RTT_TYPE_UNSPECIFIED;
        }
        int key;
        synchronized (sListenerMapLock) {
            do {
                key = sListenerKey;
                sListenerKey = key + RTT_TYPE_ONE_SIDED;
            } while (key == 0);
            sListenerMap.put(key, listener);
        }
        return key;
    }

    private static Object getListener(int key) {
        if (key == 0) {
            return null;
        }
        Object listener;
        synchronized (sListenerMapLock) {
            listener = sListenerMap.get(key);
        }
        return listener;
    }

    private static int getListenerKey(Object listener) {
        int i = RTT_TYPE_UNSPECIFIED;
        if (listener != null) {
            synchronized (sListenerMapLock) {
                int index = sListenerMap.indexOfValue(listener);
                if (index == RTT_CHANNEL_WIDTH_UNSPECIFIED) {
                } else {
                    i = sListenerMap.keyAt(index);
                }
            }
        }
        return i;
    }

    private static Object removeListener(int key) {
        if (key == 0) {
            return null;
        }
        Object listener;
        synchronized (sListenerMapLock) {
            listener = sListenerMap.get(key);
            sListenerMap.remove(key);
        }
        return listener;
    }

    private static int removeListener(Object listener) {
        int key = getListenerKey(listener);
        if (key != 0) {
            synchronized (sListenerMapLock) {
                sListenerMap.remove(key);
            }
        }
        return key;
    }
}
