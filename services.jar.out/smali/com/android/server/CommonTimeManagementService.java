package com.android.server;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.INetworkManagementEventObserver;
import android.net.InterfaceConfiguration;
import android.os.Binder;
import android.os.CommonTimeConfig;
import android.os.CommonTimeConfig.OnServerDiedListener;
import android.os.Handler;
import android.os.INetworkManagementService;
import android.os.INetworkManagementService.Stub;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemProperties;
import android.util.Log;
import com.android.server.net.BaseNetworkObserver;
import java.io.FileDescriptor;
import java.io.PrintWriter;

class CommonTimeManagementService extends Binder {
    private static final boolean ALLOW_WIFI;
    private static final String ALLOW_WIFI_PROP = "ro.common_time.allow_wifi";
    private static final boolean AUTO_DISABLE;
    private static final String AUTO_DISABLE_PROP = "ro.common_time.auto_disable";
    private static final byte BASE_SERVER_PRIO;
    private static final InterfaceScoreRule[] IFACE_SCORE_RULES;
    private static final int NATIVE_SERVICE_RECONNECT_TIMEOUT = 5000;
    private static final int NO_INTERFACE_TIMEOUT;
    private static final String NO_INTERFACE_TIMEOUT_PROP = "ro.common_time.no_iface_timeout";
    private static final String SERVER_PRIO_PROP = "ro.common_time.server_prio";
    private static final String TAG;
    private CommonTimeConfig mCTConfig;
    private OnServerDiedListener mCTServerDiedListener;
    private BroadcastReceiver mConnectivityMangerObserver;
    private final Context mContext;
    private String mCurIface;
    private boolean mDetectedAtStartup;
    private byte mEffectivePrio;
    private INetworkManagementEventObserver mIfaceObserver;
    private Object mLock;
    private INetworkManagementService mNetMgr;
    private Handler mNoInterfaceHandler;
    private Runnable mNoInterfaceRunnable;
    private Handler mReconnectHandler;
    private Runnable mReconnectRunnable;

    /* renamed from: com.android.server.CommonTimeManagementService.1 */
    class C00201 extends BaseNetworkObserver {
        C00201() {
        }

        public void interfaceStatusChanged(String iface, boolean up) {
            CommonTimeManagementService.this.reevaluateServiceState();
        }

        public void interfaceLinkStateChanged(String iface, boolean up) {
            CommonTimeManagementService.this.reevaluateServiceState();
        }

        public void interfaceAdded(String iface) {
            CommonTimeManagementService.this.reevaluateServiceState();
        }

        public void interfaceRemoved(String iface) {
            CommonTimeManagementService.this.reevaluateServiceState();
        }
    }

    /* renamed from: com.android.server.CommonTimeManagementService.2 */
    class C00212 extends BroadcastReceiver {
        C00212() {
        }

        public void onReceive(Context context, Intent intent) {
            CommonTimeManagementService.this.reevaluateServiceState();
        }
    }

    /* renamed from: com.android.server.CommonTimeManagementService.3 */
    class C00223 implements OnServerDiedListener {
        C00223() {
        }

        public void onServerDied() {
            CommonTimeManagementService.this.scheduleTimeConfigReconnect();
        }
    }

    /* renamed from: com.android.server.CommonTimeManagementService.4 */
    class C00234 implements Runnable {
        C00234() {
        }

        public void run() {
            CommonTimeManagementService.this.connectToTimeConfig();
        }
    }

    /* renamed from: com.android.server.CommonTimeManagementService.5 */
    class C00245 implements Runnable {
        C00245() {
        }

        public void run() {
            CommonTimeManagementService.this.handleNoInterfaceTimeout();
        }
    }

    private static class InterfaceScoreRule {
        public final String mPrefix;
        public final byte mScore;

        public InterfaceScoreRule(String prefix, byte score) {
            this.mPrefix = prefix;
            this.mScore = score;
        }
    }

    static {
        boolean z;
        TAG = CommonTimeManagementService.class.getSimpleName();
        if (SystemProperties.getInt(AUTO_DISABLE_PROP, 1) != 0) {
            z = true;
        } else {
            z = AUTO_DISABLE;
        }
        AUTO_DISABLE = z;
        if (SystemProperties.getInt(ALLOW_WIFI_PROP, NO_INTERFACE_TIMEOUT) != 0) {
            z = true;
        } else {
            z = AUTO_DISABLE;
        }
        ALLOW_WIFI = z;
        int tmp = SystemProperties.getInt(SERVER_PRIO_PROP, 1);
        NO_INTERFACE_TIMEOUT = SystemProperties.getInt(NO_INTERFACE_TIMEOUT_PROP, 60000);
        if (tmp < 1) {
            BASE_SERVER_PRIO = (byte) 1;
        } else if (tmp > 30) {
            BASE_SERVER_PRIO = (byte) 30;
        } else {
            BASE_SERVER_PRIO = (byte) tmp;
        }
        if (ALLOW_WIFI) {
            IFACE_SCORE_RULES = new InterfaceScoreRule[]{new InterfaceScoreRule("wlan", (byte) 1), new InterfaceScoreRule("eth", (byte) 2)};
            return;
        }
        IFACE_SCORE_RULES = new InterfaceScoreRule[]{new InterfaceScoreRule("eth", (byte) 2)};
    }

    public CommonTimeManagementService(Context context) {
        this.mReconnectHandler = new Handler();
        this.mNoInterfaceHandler = new Handler();
        this.mLock = new Object();
        this.mDetectedAtStartup = AUTO_DISABLE;
        this.mEffectivePrio = BASE_SERVER_PRIO;
        this.mIfaceObserver = new C00201();
        this.mConnectivityMangerObserver = new C00212();
        this.mCTServerDiedListener = new C00223();
        this.mReconnectRunnable = new C00234();
        this.mNoInterfaceRunnable = new C00245();
        this.mContext = context;
    }

    void systemRunning() {
        if (ServiceManager.checkService("common_time.config") == null) {
            Log.i(TAG, "No common time service detected on this platform.  Common time services will be unavailable.");
            return;
        }
        this.mDetectedAtStartup = true;
        this.mNetMgr = Stub.asInterface(ServiceManager.getService("network_management"));
        try {
            this.mNetMgr.registerObserver(this.mIfaceObserver);
        } catch (RemoteException e) {
        }
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.net.conn.CONNECTIVITY_CHANGE");
        this.mContext.registerReceiver(this.mConnectivityMangerObserver, filter);
        connectToTimeConfig();
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println(String.format("Permission Denial: can't dump CommonTimeManagement service from from pid=%d, uid=%d", new Object[]{Integer.valueOf(Binder.getCallingPid()), Integer.valueOf(Binder.getCallingUid())}));
        } else if (this.mDetectedAtStartup) {
            synchronized (this.mLock) {
                pw.println("Current Common Time Management Service Config:");
                String str = "  Native service     : %s";
                Object[] objArr = new Object[1];
                objArr[NO_INTERFACE_TIMEOUT] = this.mCTConfig == null ? "reconnecting" : "alive";
                pw.println(String.format(str, objArr));
                str = "  Bound interface    : %s";
                objArr = new Object[1];
                objArr[NO_INTERFACE_TIMEOUT] = this.mCurIface == null ? "unbound" : this.mCurIface;
                pw.println(String.format(str, objArr));
                str = "  Allow WiFi         : %s";
                objArr = new Object[1];
                objArr[NO_INTERFACE_TIMEOUT] = ALLOW_WIFI ? "yes" : "no";
                pw.println(String.format(str, objArr));
                str = "  Allow Auto Disable : %s";
                objArr = new Object[1];
                objArr[NO_INTERFACE_TIMEOUT] = AUTO_DISABLE ? "yes" : "no";
                pw.println(String.format(str, objArr));
                pw.println(String.format("  Server Priority    : %d", new Object[]{Byte.valueOf(this.mEffectivePrio)}));
                pw.println(String.format("  No iface timeout   : %d", new Object[]{Integer.valueOf(NO_INTERFACE_TIMEOUT)}));
            }
        } else {
            pw.println("Native Common Time service was not detected at startup.  Service is unavailable");
        }
    }

    private void cleanupTimeConfig() {
        this.mReconnectHandler.removeCallbacks(this.mReconnectRunnable);
        this.mNoInterfaceHandler.removeCallbacks(this.mNoInterfaceRunnable);
        if (this.mCTConfig != null) {
            this.mCTConfig.release();
            this.mCTConfig = null;
        }
    }

    private void connectToTimeConfig() {
        cleanupTimeConfig();
        try {
            synchronized (this.mLock) {
                this.mCTConfig = new CommonTimeConfig();
                this.mCTConfig.setServerDiedListener(this.mCTServerDiedListener);
                this.mCurIface = this.mCTConfig.getInterfaceBinding();
                this.mCTConfig.setAutoDisable(AUTO_DISABLE);
                this.mCTConfig.setMasterElectionPriority(this.mEffectivePrio);
            }
            if (NO_INTERFACE_TIMEOUT >= 0) {
                this.mNoInterfaceHandler.postDelayed(this.mNoInterfaceRunnable, (long) NO_INTERFACE_TIMEOUT);
            }
            reevaluateServiceState();
        } catch (RemoteException e) {
            scheduleTimeConfigReconnect();
        }
    }

    private void scheduleTimeConfigReconnect() {
        cleanupTimeConfig();
        Log.w(TAG, String.format("Native service died, will reconnect in %d mSec", new Object[]{Integer.valueOf(NATIVE_SERVICE_RECONNECT_TIMEOUT)}));
        this.mReconnectHandler.postDelayed(this.mReconnectRunnable, 5000);
    }

    private void handleNoInterfaceTimeout() {
        if (this.mCTConfig != null) {
            Log.i(TAG, "Timeout waiting for interface to come up.  Forcing networkless master mode.");
            if (-7 == this.mCTConfig.forceNetworklessMasterMode()) {
                scheduleTimeConfigReconnect();
            }
        }
    }

    private void reevaluateServiceState() {
        String bindIface = null;
        byte bestScore = (byte) -1;
        try {
            String[] ifaceList = this.mNetMgr.listInterfaces();
            if (ifaceList != null) {
                String[] strArr = ifaceList;
                int len$ = strArr.length;
                for (int i = NO_INTERFACE_TIMEOUT; i < len$; i++) {
                    String iface = strArr[i];
                    byte thisScore = (byte) -1;
                    InterfaceScoreRule[] arr$ = IFACE_SCORE_RULES;
                    int len$2 = arr$.length;
                    for (int i$ = NO_INTERFACE_TIMEOUT; i$ < len$2; i$++) {
                        InterfaceScoreRule r = arr$[i$];
                        if (iface.contains(r.mPrefix)) {
                            thisScore = r.mScore;
                            break;
                        }
                    }
                    if (thisScore > bestScore) {
                        InterfaceConfiguration config = this.mNetMgr.getInterfaceConfig(iface);
                        if (config != null && config.isActive()) {
                            bindIface = iface;
                            bestScore = thisScore;
                        }
                    }
                }
            }
        } catch (RemoteException e) {
            bindIface = null;
        }
        boolean doRebind = true;
        synchronized (this.mLock) {
            if (bindIface != null) {
                if (this.mCurIface == null) {
                    Log.e(TAG, String.format("Binding common time service to %s.", new Object[]{bindIface}));
                    this.mCurIface = bindIface;
                }
            }
            if (bindIface == null) {
                if (this.mCurIface != null) {
                    Log.e(TAG, "Unbinding common time service.");
                    this.mCurIface = null;
                }
            }
            if (bindIface != null) {
                if (this.mCurIface != null) {
                    if (!bindIface.equals(this.mCurIface)) {
                        String str = TAG;
                        r24 = new Object[2];
                        r24[NO_INTERFACE_TIMEOUT] = this.mCurIface;
                        r24[1] = bindIface;
                        Log.e(str, String.format("Switching common time service binding from %s to %s.", r24));
                        this.mCurIface = bindIface;
                    }
                }
            }
            doRebind = AUTO_DISABLE;
        }
        if (doRebind && this.mCTConfig != null) {
            byte newPrio;
            if (bestScore > null) {
                newPrio = (byte) (BASE_SERVER_PRIO * bestScore);
            } else {
                newPrio = BASE_SERVER_PRIO;
            }
            if (newPrio != this.mEffectivePrio) {
                this.mEffectivePrio = newPrio;
                this.mCTConfig.setMasterElectionPriority(this.mEffectivePrio);
            }
            if (this.mCTConfig.setNetworkBinding(this.mCurIface) != 0) {
                scheduleTimeConfigReconnect();
            } else if (NO_INTERFACE_TIMEOUT >= 0) {
                this.mNoInterfaceHandler.removeCallbacks(this.mNoInterfaceRunnable);
                if (this.mCurIface == null) {
                    this.mNoInterfaceHandler.postDelayed(this.mNoInterfaceRunnable, (long) NO_INTERFACE_TIMEOUT);
                }
            }
        }
    }
}
