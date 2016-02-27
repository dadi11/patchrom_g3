package com.android.server.connectivity;

import android.content.Context;
import android.net.LinkAddress;
import android.net.LinkProperties;
import android.net.RouteInfo;
import android.os.Handler;
import android.os.INetworkManagementService;
import android.os.Message;
import android.os.RemoteException;
import android.util.Slog;
import com.android.server.net.BaseNetworkObserver;
import java.net.Inet4Address;

public class Nat464Xlat extends BaseNetworkObserver {
    private static final String CLAT_PREFIX = "v4-";
    private static final String TAG = "Nat464Xlat";
    private String mBaseIface;
    private final Handler mHandler;
    private String mIface;
    private boolean mIsRunning;
    private final INetworkManagementService mNMService;
    private final NetworkAgentInfo mNetwork;

    public Nat464Xlat(Context context, INetworkManagementService nmService, Handler handler, NetworkAgentInfo nai) {
        this.mNMService = nmService;
        this.mHandler = handler;
        this.mNetwork = nai;
    }

    public static boolean requiresClat(NetworkAgentInfo nai) {
        int netType = nai.networkInfo.getType();
        boolean connected = nai.networkInfo.isConnected();
        boolean hasIPv4Address;
        if (nai.linkProperties != null) {
            hasIPv4Address = nai.linkProperties.hasIPv4Address();
        } else {
            hasIPv4Address = false;
        }
        if (connected && !hasIPv4Address && (netType == 0 || netType == 1)) {
            return true;
        }
        return false;
    }

    public boolean isStarted() {
        return this.mIface != null;
    }

    private void clear() {
        this.mIface = null;
        this.mBaseIface = null;
        this.mIsRunning = false;
    }

    public void start() {
        Exception e;
        if (isStarted()) {
            Slog.e(TAG, "startClat: already started");
        } else if (this.mNetwork.linkProperties == null) {
            Slog.e(TAG, "startClat: Can't start clat with null LinkProperties");
        } else {
            try {
                this.mNMService.registerObserver(this);
                this.mBaseIface = this.mNetwork.linkProperties.getInterfaceName();
                if (this.mBaseIface == null) {
                    Slog.e(TAG, "startClat: Can't start clat on null interface");
                    return;
                }
                this.mIface = CLAT_PREFIX + this.mBaseIface;
                Slog.i(TAG, "Starting clatd on " + this.mBaseIface);
                try {
                    this.mNMService.startClatd(this.mBaseIface);
                } catch (RemoteException e2) {
                    e = e2;
                    Slog.e(TAG, "Error starting clatd: " + e);
                } catch (IllegalStateException e3) {
                    e = e3;
                    Slog.e(TAG, "Error starting clatd: " + e);
                }
            } catch (RemoteException e4) {
                Slog.e(TAG, "startClat: Can't register interface observer for clat on " + this.mNetwork);
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void stop() {
        /*
        r4 = this;
        r1 = r4.isStarted();
        if (r1 == 0) goto L_0x002f;
    L_0x0006:
        r1 = "Nat464Xlat";
        r2 = "Stopping clatd";
        android.util.Slog.i(r1, r2);
        r1 = r4.mNMService;	 Catch:{ RemoteException -> 0x0037, IllegalStateException -> 0x0015 }
        r2 = r4.mBaseIface;	 Catch:{ RemoteException -> 0x0037, IllegalStateException -> 0x0015 }
        r1.stopClatd(r2);	 Catch:{ RemoteException -> 0x0037, IllegalStateException -> 0x0015 }
    L_0x0014:
        return;
    L_0x0015:
        r0 = move-exception;
    L_0x0016:
        r1 = "Nat464Xlat";
        r2 = new java.lang.StringBuilder;
        r2.<init>();
        r3 = "Error stopping clatd: ";
        r2 = r2.append(r3);
        r2 = r2.append(r0);
        r2 = r2.toString();
        android.util.Slog.e(r1, r2);
        goto L_0x0014;
    L_0x002f:
        r1 = "Nat464Xlat";
        r2 = "clatd: already stopped";
        android.util.Slog.e(r1, r2);
        goto L_0x0014;
    L_0x0037:
        r0 = move-exception;
        goto L_0x0016;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.connectivity.Nat464Xlat.stop():void");
    }

    private void updateConnectivityService(LinkProperties lp) {
        Message msg = this.mHandler.obtainMessage(528387, lp);
        msg.replyTo = this.mNetwork.messenger;
        Slog.i(TAG, "sending message to ConnectivityService: " + msg);
        msg.sendToTarget();
    }

    public void fixupLinkProperties(LinkProperties oldLp) {
        if (this.mNetwork.clatd != null && this.mIsRunning && this.mNetwork.linkProperties != null && !this.mNetwork.linkProperties.getAllInterfaceNames().contains(this.mIface)) {
            Slog.d(TAG, "clatd running, updating NAI for " + this.mIface);
            for (LinkProperties stacked : oldLp.getStackedLinks()) {
                if (this.mIface.equals(stacked.getInterfaceName())) {
                    this.mNetwork.linkProperties.addStackedLink(stacked);
                    return;
                }
            }
        }
    }

    private LinkProperties makeLinkProperties(LinkAddress clatAddress) {
        LinkProperties stacked = new LinkProperties();
        stacked.setInterfaceName(this.mIface);
        stacked.addRoute(new RouteInfo(new LinkAddress(Inet4Address.ANY, 0), clatAddress.getAddress(), this.mIface));
        stacked.addLinkAddress(clatAddress);
        return stacked;
    }

    private LinkAddress getLinkAddress(String iface) {
        Exception e;
        try {
            return this.mNMService.getInterfaceConfig(iface).getLinkAddress();
        } catch (RemoteException e2) {
            e = e2;
            Slog.e(TAG, "Error getting link properties: " + e);
            return null;
        } catch (IllegalStateException e3) {
            e = e3;
            Slog.e(TAG, "Error getting link properties: " + e);
            return null;
        }
    }

    private void maybeSetIpv6NdOffload(String iface, boolean on) {
        Exception e;
        if (this.mNetwork.networkInfo.getType() == 1) {
            try {
                Slog.d(TAG, (on ? "En" : "Dis") + "abling ND offload on " + iface);
                this.mNMService.setInterfaceIpv6NdOffload(iface, on);
            } catch (RemoteException e2) {
                e = e2;
                Slog.w(TAG, "Changing IPv6 ND offload on " + iface + "failed: " + e);
            } catch (IllegalStateException e3) {
                e = e3;
                Slog.w(TAG, "Changing IPv6 ND offload on " + iface + "failed: " + e);
            }
        }
    }

    public void interfaceLinkStateChanged(String iface, boolean up) {
        if (isStarted() && up && this.mIface.equals(iface)) {
            Slog.i(TAG, "interface " + iface + " is up, mIsRunning " + this.mIsRunning + "->true");
            if (!this.mIsRunning) {
                LinkAddress clatAddress = getLinkAddress(iface);
                if (clatAddress != null) {
                    this.mIsRunning = true;
                    maybeSetIpv6NdOffload(this.mBaseIface, false);
                    LinkProperties lp = new LinkProperties(this.mNetwork.linkProperties);
                    lp.addStackedLink(makeLinkProperties(clatAddress));
                    Slog.i(TAG, "Adding stacked link " + this.mIface + " on top of " + this.mBaseIface);
                    updateConnectivityService(lp);
                }
            }
        }
    }

    public void interfaceRemoved(String iface) {
        if (isStarted() && this.mIface.equals(iface)) {
            Slog.i(TAG, "interface " + iface + " removed, mIsRunning " + this.mIsRunning + "->false");
            if (this.mIsRunning) {
                try {
                    this.mNMService.unregisterObserver(this);
                    this.mNMService.stopClatd(this.mBaseIface);
                } catch (RemoteException e) {
                } catch (IllegalStateException e2) {
                }
                maybeSetIpv6NdOffload(this.mBaseIface, true);
                LinkProperties lp = new LinkProperties(this.mNetwork.linkProperties);
                lp.removeStackedLink(this.mIface);
                clear();
                updateConnectivityService(lp);
            }
        }
    }
}
