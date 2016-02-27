package com.android.server.net;

import android.app.Notification.Builder;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.LinkAddress;
import android.net.LinkProperties;
import android.net.NetworkInfo;
import android.net.NetworkInfo.DetailedState;
import android.net.NetworkInfo.State;
import android.os.INetworkManagementService;
import android.os.RemoteException;
import android.security.KeyStore;
import android.system.Os;
import android.text.TextUtils;
import android.util.Slog;
import com.android.internal.net.VpnConfig;
import com.android.internal.net.VpnProfile;
import com.android.internal.util.Preconditions;
import com.android.server.ConnectivityService;
import com.android.server.EventLogTags;
import com.android.server.SystemService;
import com.android.server.connectivity.Vpn;
import java.util.List;

public class LockdownVpnTracker {
    private static final String ACTION_LOCKDOWN_RESET = "com.android.server.action.LOCKDOWN_RESET";
    private static final String ACTION_VPN_SETTINGS = "android.net.vpn.SETTINGS";
    private static final String EXTRA_PICK_LOCKDOWN = "android.net.vpn.PICK_LOCKDOWN";
    private static final int MAX_ERROR_COUNT = 4;
    private static final int ROOT_UID = 0;
    private static final String TAG = "LockdownVpnTracker";
    private String mAcceptedEgressIface;
    private String mAcceptedIface;
    private List<LinkAddress> mAcceptedSourceAddr;
    private final PendingIntent mConfigIntent;
    private final ConnectivityService mConnService;
    private final Context mContext;
    private int mErrorCount;
    private final INetworkManagementService mNetService;
    private final VpnProfile mProfile;
    private final PendingIntent mResetIntent;
    private BroadcastReceiver mResetReceiver;
    private final Object mStateLock;
    private final Vpn mVpn;

    /* renamed from: com.android.server.net.LockdownVpnTracker.1 */
    class C03901 extends BroadcastReceiver {
        C03901() {
        }

        public void onReceive(Context context, Intent intent) {
            LockdownVpnTracker.this.reset();
        }
    }

    public static boolean isEnabled() {
        return KeyStore.getInstance().contains("LOCKDOWN_VPN");
    }

    public LockdownVpnTracker(Context context, INetworkManagementService netService, ConnectivityService connService, Vpn vpn, VpnProfile profile) {
        this.mStateLock = new Object();
        this.mResetReceiver = new C03901();
        this.mContext = (Context) Preconditions.checkNotNull(context);
        this.mNetService = (INetworkManagementService) Preconditions.checkNotNull(netService);
        this.mConnService = (ConnectivityService) Preconditions.checkNotNull(connService);
        this.mVpn = (Vpn) Preconditions.checkNotNull(vpn);
        this.mProfile = (VpnProfile) Preconditions.checkNotNull(profile);
        Intent configIntent = new Intent(ACTION_VPN_SETTINGS);
        configIntent.putExtra(EXTRA_PICK_LOCKDOWN, true);
        this.mConfigIntent = PendingIntent.getActivity(this.mContext, ROOT_UID, configIntent, ROOT_UID);
        Intent resetIntent = new Intent(ACTION_LOCKDOWN_RESET);
        resetIntent.addFlags(1073741824);
        this.mResetIntent = PendingIntent.getBroadcast(this.mContext, ROOT_UID, resetIntent, ROOT_UID);
    }

    private void handleStateChangedLocked() {
        boolean egressChanged;
        int egressType;
        NetworkInfo egressInfo = this.mConnService.getActiveNetworkInfoUnfiltered();
        LinkProperties egressProp = this.mConnService.getActiveLinkProperties();
        NetworkInfo vpnInfo = this.mVpn.getNetworkInfo();
        VpnConfig vpnConfig = this.mVpn.getLegacyVpnConfig();
        boolean egressDisconnected = egressInfo == null || State.DISCONNECTED.equals(egressInfo.getState());
        if (egressProp != null) {
            if (TextUtils.equals(this.mAcceptedEgressIface, egressProp.getInterfaceName())) {
                egressChanged = false;
                Slog.d(TAG, "handleStateChanged: egress=" + (egressInfo != null ? null : ConnectivityManager.getNetworkTypeName(egressInfo.getType())) + " " + this.mAcceptedEgressIface + "->" + (egressProp != null ? null : egressProp.getInterfaceName()));
                if (egressDisconnected || egressChanged) {
                    clearSourceRulesLocked();
                    this.mAcceptedEgressIface = null;
                    this.mVpn.stopLegacyVpnPrivileged();
                }
                if (egressDisconnected) {
                    egressType = egressInfo.getType();
                    if (vpnInfo.getDetailedState() == DetailedState.FAILED) {
                        EventLogTags.writeLockdownVpnError(egressType);
                    }
                    int i = this.mErrorCount;
                    if (r0 <= MAX_ERROR_COUNT) {
                        showNotification(17040737, 17303403);
                        return;
                    } else if (!egressInfo.isConnected() && !vpnInfo.isConnectedOrConnecting()) {
                        if (this.mProfile.isValidLockdownProfile()) {
                            Slog.d(TAG, "Active network connected; starting VPN");
                            EventLogTags.writeLockdownVpnConnecting(egressType);
                            showNotification(17040735, 17303403);
                            this.mAcceptedEgressIface = egressProp.getInterfaceName();
                            try {
                                this.mVpn.startLegacyVpnPrivileged(this.mProfile, KeyStore.getInstance(), egressProp);
                                return;
                            } catch (IllegalStateException e) {
                                this.mAcceptedEgressIface = null;
                                Slog.e(TAG, "Failed to start VPN", e);
                                showNotification(17040737, 17303403);
                                return;
                            }
                        }
                        Slog.e(TAG, "Invalid VPN profile; requires IP-based server and DNS");
                        showNotification(17040737, 17303403);
                        return;
                    } else if (vpnInfo.isConnected() && vpnConfig != null) {
                        String iface = vpnConfig.interfaze;
                        List<LinkAddress> sourceAddrs = vpnConfig.addresses;
                        if (TextUtils.equals(iface, this.mAcceptedIface)) {
                            if (sourceAddrs.equals(this.mAcceptedSourceAddr)) {
                                return;
                            }
                        }
                        Slog.d(TAG, "VPN connected using iface=" + iface + ", sourceAddr=" + sourceAddrs.toString());
                        EventLogTags.writeLockdownVpnConnected(egressType);
                        showNotification(17040736, 17303402);
                        try {
                            clearSourceRulesLocked();
                            this.mNetService.setFirewallInterfaceRule(iface, true);
                            for (LinkAddress addr : sourceAddrs) {
                                setFirewallEgressSourceRule(addr, true);
                            }
                            this.mNetService.setFirewallUidRule(ROOT_UID, true);
                            this.mNetService.setFirewallUidRule(Os.getuid(), true);
                            this.mErrorCount = ROOT_UID;
                            this.mAcceptedIface = iface;
                            this.mAcceptedSourceAddr = sourceAddrs;
                            this.mConnService.sendConnectedBroadcast(augmentNetworkInfo(egressInfo));
                            return;
                        } catch (RemoteException e2) {
                            throw new RuntimeException("Problem setting firewall rules", e2);
                        }
                    } else {
                        return;
                    }
                }
                hideNotification();
            }
        }
        egressChanged = true;
        if (egressInfo != null) {
        }
        if (egressProp != null) {
        }
        Slog.d(TAG, "handleStateChanged: egress=" + (egressInfo != null ? null : ConnectivityManager.getNetworkTypeName(egressInfo.getType())) + " " + this.mAcceptedEgressIface + "->" + (egressProp != null ? null : egressProp.getInterfaceName()));
        clearSourceRulesLocked();
        this.mAcceptedEgressIface = null;
        this.mVpn.stopLegacyVpnPrivileged();
        if (egressDisconnected) {
            egressType = egressInfo.getType();
            if (vpnInfo.getDetailedState() == DetailedState.FAILED) {
                EventLogTags.writeLockdownVpnError(egressType);
            }
            int i2 = this.mErrorCount;
            if (r0 <= MAX_ERROR_COUNT) {
                if (!egressInfo.isConnected()) {
                }
                if (vpnInfo.isConnected()) {
                    return;
                }
                return;
            }
            showNotification(17040737, 17303403);
            return;
        }
        hideNotification();
    }

    public void init() {
        synchronized (this.mStateLock) {
            initLocked();
        }
    }

    private void initLocked() {
        Slog.d(TAG, "initLocked()");
        this.mVpn.setEnableTeardown(false);
        this.mContext.registerReceiver(this.mResetReceiver, new IntentFilter(ACTION_LOCKDOWN_RESET), "android.permission.CONNECTIVITY_INTERNAL", null);
        try {
            this.mNetService.setFirewallEgressDestRule(this.mProfile.server, SystemService.PHASE_SYSTEM_SERVICES_READY, true);
            this.mNetService.setFirewallEgressDestRule(this.mProfile.server, 4500, true);
            this.mNetService.setFirewallEgressDestRule(this.mProfile.server, 1701, true);
            synchronized (this.mStateLock) {
                handleStateChangedLocked();
            }
        } catch (RemoteException e) {
            throw new RuntimeException("Problem setting firewall rules", e);
        }
    }

    public void shutdown() {
        synchronized (this.mStateLock) {
            shutdownLocked();
        }
    }

    private void shutdownLocked() {
        Slog.d(TAG, "shutdownLocked()");
        this.mAcceptedEgressIface = null;
        this.mErrorCount = ROOT_UID;
        this.mVpn.stopLegacyVpnPrivileged();
        try {
            this.mNetService.setFirewallEgressDestRule(this.mProfile.server, SystemService.PHASE_SYSTEM_SERVICES_READY, false);
            this.mNetService.setFirewallEgressDestRule(this.mProfile.server, 4500, false);
            this.mNetService.setFirewallEgressDestRule(this.mProfile.server, 1701, false);
            clearSourceRulesLocked();
            hideNotification();
            this.mContext.unregisterReceiver(this.mResetReceiver);
            this.mVpn.setEnableTeardown(true);
        } catch (RemoteException e) {
            throw new RuntimeException("Problem setting firewall rules", e);
        }
    }

    public void reset() {
        Slog.d(TAG, "reset()");
        synchronized (this.mStateLock) {
            shutdownLocked();
            initLocked();
            handleStateChangedLocked();
        }
    }

    private void clearSourceRulesLocked() {
        try {
            if (this.mAcceptedIface != null) {
                this.mNetService.setFirewallInterfaceRule(this.mAcceptedIface, false);
                this.mAcceptedIface = null;
            }
            if (this.mAcceptedSourceAddr != null) {
                for (LinkAddress addr : this.mAcceptedSourceAddr) {
                    setFirewallEgressSourceRule(addr, false);
                }
                this.mNetService.setFirewallUidRule(ROOT_UID, false);
                this.mNetService.setFirewallUidRule(Os.getuid(), false);
                this.mAcceptedSourceAddr = null;
            }
        } catch (RemoteException e) {
            throw new RuntimeException("Problem setting firewall rules", e);
        }
    }

    private void setFirewallEgressSourceRule(LinkAddress address, boolean allow) throws RemoteException {
        this.mNetService.setFirewallEgressSourceRule(address.getAddress().getHostAddress(), allow);
    }

    public void onNetworkInfoChanged() {
        synchronized (this.mStateLock) {
            handleStateChangedLocked();
        }
    }

    public void onVpnStateChanged(NetworkInfo info) {
        if (info.getDetailedState() == DetailedState.FAILED) {
            this.mErrorCount++;
        }
        synchronized (this.mStateLock) {
            handleStateChangedLocked();
        }
    }

    public NetworkInfo augmentNetworkInfo(NetworkInfo info) {
        if (!info.isConnected()) {
            return info;
        }
        NetworkInfo vpnInfo = this.mVpn.getNetworkInfo();
        NetworkInfo info2 = new NetworkInfo(info);
        info2.setDetailedState(vpnInfo.getDetailedState(), vpnInfo.getReason(), null);
        return info2;
    }

    private void showNotification(int titleRes, int iconRes) {
        NotificationManager.from(this.mContext).notify(TAG, ROOT_UID, new Builder(this.mContext).setWhen(0).setSmallIcon(iconRes).setContentTitle(this.mContext.getString(titleRes)).setContentText(this.mContext.getString(17040738)).setContentIntent(this.mConfigIntent).setPriority(-1).setOngoing(true).addAction(17302519, this.mContext.getString(17040741), this.mResetIntent).setColor(this.mContext.getResources().getColor(17170521)).build());
    }

    private void hideNotification() {
        NotificationManager.from(this.mContext).cancel(TAG, ROOT_UID);
    }
}
