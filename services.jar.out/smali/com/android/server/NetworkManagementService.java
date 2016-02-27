package com.android.server;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.INetworkManagementEventObserver;
import android.net.InterfaceConfiguration;
import android.net.IpPrefix;
import android.net.LinkAddress;
import android.net.Network;
import android.net.NetworkStats;
import android.net.NetworkUtils;
import android.net.RouteInfo;
import android.net.UidRange;
import android.net.wifi.WifiConfiguration;
import android.os.Binder;
import android.os.Handler;
import android.os.INetworkActivityListener;
import android.os.INetworkManagementService.Stub;
import android.os.Looper;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.telephony.DataConnectionRealTimeInfo;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.util.Slog;
import android.util.SparseBooleanArray;
import com.android.internal.app.IBatteryStats;
import com.android.internal.net.NetworkStatsFactory;
import com.android.internal.util.Preconditions;
import com.android.server.NativeDaemonConnector.Command;
import com.android.server.NativeDaemonConnector.SensitiveArg;
import com.android.server.Watchdog.Monitor;
import com.android.server.net.LockdownVpnTracker;
import com.android.server.voiceinteraction.DatabaseHelper.SoundModelContract;
import com.android.server.wm.WindowManagerService.C0569H;
import com.google.android.collect.Maps;
import java.io.File;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.InterfaceAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.NoSuchElementException;
import java.util.StringTokenizer;
import java.util.concurrent.CountDownLatch;

public class NetworkManagementService extends Stub implements Monitor {
    static final int DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO = 1;
    private static final boolean DBG = false;
    public static final String LIMIT_GLOBAL_ALERT = "globalAlert";
    private static final int MAX_UID_RANGES_PER_COMMAND = 10;
    private static final String NETD_SOCKET_NAME = "netd";
    private static final String NETD_TAG = "NetdConnector";
    private static final String TAG = "NetworkManagementService";
    private HashMap<String, Long> mActiveAlerts;
    private HashMap<String, IdleTimerParams> mActiveIdleTimers;
    private HashMap<String, Long> mActiveQuotas;
    private volatile boolean mBandwidthControlEnabled;
    private IBatteryStats mBatteryStats;
    private CountDownLatch mConnectedSignal;
    private final NativeDaemonConnector mConnector;
    private final Context mContext;
    private final Handler mDaemonHandler;
    private final Handler mFgHandler;
    private volatile boolean mFirewallEnabled;
    private Object mIdleTimerLock;
    private int mLastPowerStateFromRadio;
    private boolean mMobileActivityFromRadio;
    private boolean mNetworkActive;
    private final RemoteCallbackList<INetworkActivityListener> mNetworkActivityListeners;
    private final RemoteCallbackList<INetworkManagementEventObserver> mObservers;
    private final PhoneStateListener mPhoneStateListener;
    private Object mQuotaLock;
    private final NetworkStatsFactory mStatsFactory;
    private final Thread mThread;
    private SparseBooleanArray mUidRejectOnQuota;

    /* renamed from: com.android.server.NetworkManagementService.1 */
    class C00671 extends PhoneStateListener {
        C00671(int x0, Looper x1) {
            super(x0, x1);
        }

        public void onDataConnectionRealTimeInfoChanged(DataConnectionRealTimeInfo dcRtInfo) {
            NetworkManagementService.this.notifyInterfaceClassActivity(0, dcRtInfo.getDcPowerState(), dcRtInfo.getTime(), true);
        }
    }

    /* renamed from: com.android.server.NetworkManagementService.2 */
    class C00682 implements Runnable {
        final /* synthetic */ int val$type;

        C00682(int i) {
            this.val$type = i;
        }

        public void run() {
            NetworkManagementService.this.notifyInterfaceClassActivity(this.val$type, DataConnectionRealTimeInfo.DC_POWER_STATE_HIGH, SystemClock.elapsedRealtimeNanos(), NetworkManagementService.DBG);
        }
    }

    /* renamed from: com.android.server.NetworkManagementService.3 */
    class C00693 implements Runnable {
        final /* synthetic */ IdleTimerParams val$params;

        C00693(IdleTimerParams idleTimerParams) {
            this.val$params = idleTimerParams;
        }

        public void run() {
            NetworkManagementService.this.notifyInterfaceClassActivity(this.val$params.type, DataConnectionRealTimeInfo.DC_POWER_STATE_LOW, SystemClock.elapsedRealtimeNanos(), NetworkManagementService.DBG);
        }
    }

    private static class IdleTimerParams {
        public int networkCount;
        public final int timeout;
        public final int type;

        IdleTimerParams(int timeout, int type) {
            this.timeout = timeout;
            this.type = type;
            this.networkCount = NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO;
        }
    }

    private class NetdCallbackReceiver implements INativeDaemonConnectorCallbacks {

        /* renamed from: com.android.server.NetworkManagementService.NetdCallbackReceiver.1 */
        class C00701 implements Runnable {
            C00701() {
            }

            public void run() {
                NetworkManagementService.this.prepareNativeDaemon();
            }
        }

        private NetdCallbackReceiver() {
        }

        public void onDaemonConnected() {
            if (NetworkManagementService.this.mConnectedSignal != null) {
                NetworkManagementService.this.mConnectedSignal.countDown();
                NetworkManagementService.this.mConnectedSignal = null;
                return;
            }
            NetworkManagementService.this.mFgHandler.post(new C00701());
        }

        public boolean onCheckHoldWakeLock(int code) {
            return code == NetdResponseCode.InterfaceClassActivity ? true : NetworkManagementService.DBG;
        }

        public boolean onEvent(int code, String raw, String[] cooked) {
            Object[] objArr = new Object[NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
            objArr[0] = raw;
            String errorMessage = String.format("Invalid event from daemon (%s)", objArr);
            switch (code) {
                case NetdResponseCode.InterfaceChange /*600*/:
                    if (cooked.length < 4 || !cooked[NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO].equals("Iface")) {
                        throw new IllegalStateException(errorMessage);
                    } else if (cooked[2].equals("added")) {
                        NetworkManagementService.this.notifyInterfaceAdded(cooked[3]);
                        return true;
                    } else if (cooked[2].equals("removed")) {
                        NetworkManagementService.this.notifyInterfaceRemoved(cooked[3]);
                        return true;
                    } else if (cooked[2].equals("changed") && cooked.length == 5) {
                        NetworkManagementService.this.notifyInterfaceStatusChanged(cooked[3], cooked[4].equals("up"));
                        return true;
                    } else if (cooked[2].equals("linkstate") && cooked.length == 5) {
                        NetworkManagementService.this.notifyInterfaceLinkStateChanged(cooked[3], cooked[4].equals("up"));
                        return true;
                    } else {
                        throw new IllegalStateException(errorMessage);
                    }
                case NetdResponseCode.BandwidthControl /*601*/:
                    if (cooked.length < 5 || !cooked[NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO].equals("limit")) {
                        throw new IllegalStateException(errorMessage);
                    } else if (cooked[2].equals("alert")) {
                        NetworkManagementService.this.notifyLimitReached(cooked[3], cooked[4]);
                        return true;
                    } else {
                        throw new IllegalStateException(errorMessage);
                    }
                case NetdResponseCode.InterfaceClassActivity /*613*/:
                    if (cooked.length < 4 || !cooked[NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO].equals("IfaceClass")) {
                        throw new IllegalStateException(errorMessage);
                    }
                    long timestampNanos = 0;
                    if (cooked.length == 5) {
                        try {
                            timestampNanos = Long.parseLong(cooked[4]);
                        } catch (NumberFormatException e) {
                        }
                    } else {
                        timestampNanos = SystemClock.elapsedRealtimeNanos();
                    }
                    NetworkManagementService.this.notifyInterfaceClassActivity(Integer.parseInt(cooked[3]), cooked[2].equals("active") ? DataConnectionRealTimeInfo.DC_POWER_STATE_HIGH : DataConnectionRealTimeInfo.DC_POWER_STATE_LOW, timestampNanos, NetworkManagementService.DBG);
                    return true;
                case NetdResponseCode.InterfaceAddressChange /*614*/:
                    if (cooked.length < 7 || !cooked[NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO].equals("Address")) {
                        throw new IllegalStateException(errorMessage);
                    }
                    String iface = cooked[4];
                    try {
                        LinkAddress address = new LinkAddress(cooked[3], Integer.parseInt(cooked[5]), Integer.parseInt(cooked[6]));
                        if (cooked[2].equals("updated")) {
                            NetworkManagementService.this.notifyAddressUpdated(iface, address);
                        } else {
                            NetworkManagementService.this.notifyAddressRemoved(iface, address);
                        }
                        return true;
                    } catch (NumberFormatException e2) {
                        throw new IllegalStateException(errorMessage, e2);
                    } catch (IllegalArgumentException e3) {
                        throw new IllegalStateException(errorMessage, e3);
                    }
                case NetdResponseCode.InterfaceDnsServerInfo /*615*/:
                    if (cooked.length == 6 && cooked[NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO].equals("DnsInfo") && cooked[2].equals("servers")) {
                        try {
                            NetworkManagementService.this.notifyInterfaceDnsServerInfo(cooked[3], Long.parseLong(cooked[4]), cooked[5].split(","));
                        } catch (NumberFormatException e4) {
                            throw new IllegalStateException(errorMessage);
                        }
                    }
                    return true;
                case NetdResponseCode.RouteChange /*616*/:
                    if (!cooked[NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO].equals("Route") || cooked.length < 6) {
                        throw new IllegalStateException(errorMessage);
                    }
                    String via = null;
                    String dev = null;
                    boolean valid = true;
                    for (int i = 4; i + NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO < cooked.length && valid; i += 2) {
                        if (cooked[i].equals("dev")) {
                            if (dev == null) {
                                dev = cooked[i + NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
                            } else {
                                valid = NetworkManagementService.DBG;
                            }
                        } else if (!cooked[i].equals("via")) {
                            valid = NetworkManagementService.DBG;
                        } else if (via == null) {
                            via = cooked[i + NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
                        } else {
                            valid = NetworkManagementService.DBG;
                        }
                    }
                    if (valid) {
                        InetAddress gateway = null;
                        if (via != null) {
                            try {
                                gateway = InetAddress.parseNumericAddress(via);
                            } catch (IllegalArgumentException e5) {
                            }
                        }
                        NetworkManagementService.this.notifyRouteChange(cooked[2], new RouteInfo(new IpPrefix(cooked[3]), gateway, dev));
                        return true;
                    }
                    throw new IllegalStateException(errorMessage);
                case NetdResponseCode.InterfaceMessage /*617*/:
                    if (cooked.length < 3 || !cooked[NetworkManagementService.DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO].equals("IfaceMessage")) {
                        throw new IllegalStateException(errorMessage);
                    }
                    Slog.d(NetworkManagementService.TAG, "onEvent: " + raw);
                    if (cooked[4] != null) {
                        NetworkManagementService.this.notifyInterfaceMessage(cooked[3] + " " + cooked[4]);
                    } else {
                        NetworkManagementService.this.notifyInterfaceMessage(cooked[3]);
                    }
                    return true;
                default:
                    return NetworkManagementService.DBG;
            }
        }
    }

    class NetdResponseCode {
        public static final int BandwidthControl = 601;
        public static final int ClatdStatusResult = 223;
        public static final int DnsProxyQueryResult = 222;
        public static final int InterfaceAddressChange = 614;
        public static final int InterfaceChange = 600;
        public static final int InterfaceClassActivity = 613;
        public static final int InterfaceDnsServerInfo = 615;
        public static final int InterfaceGetCfgResult = 213;
        public static final int InterfaceListResult = 110;
        public static final int InterfaceMessage = 617;
        public static final int InterfaceRxCounterResult = 216;
        public static final int InterfaceTxCounterResult = 217;
        public static final int IpFwdStatusResult = 211;
        public static final int QuotaCounterResult = 220;
        public static final int RouteChange = 616;
        public static final int SoftapStatusResult = 214;
        public static final int TetherDnsFwdTgtListResult = 112;
        public static final int TetherInterfaceListResult = 111;
        public static final int TetherStatusResult = 210;
        public static final int TetheringStatsListResult = 114;
        public static final int TetheringStatsResult = 221;
        public static final int TtyListResult = 113;
        public static final int V6RtrAdvResult = 227;

        NetdResponseCode() {
        }
    }

    private NetworkManagementService(Context context, String socket) {
        this.mConnectedSignal = new CountDownLatch(DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO);
        this.mObservers = new RemoteCallbackList();
        this.mStatsFactory = new NetworkStatsFactory();
        this.mQuotaLock = new Object();
        this.mActiveQuotas = Maps.newHashMap();
        this.mActiveAlerts = Maps.newHashMap();
        this.mUidRejectOnQuota = new SparseBooleanArray();
        this.mIdleTimerLock = new Object();
        this.mActiveIdleTimers = Maps.newHashMap();
        this.mMobileActivityFromRadio = DBG;
        this.mLastPowerStateFromRadio = DataConnectionRealTimeInfo.DC_POWER_STATE_LOW;
        this.mNetworkActivityListeners = new RemoteCallbackList();
        this.mContext = context;
        this.mFgHandler = new Handler(FgThread.get().getLooper());
        if ("simulator".equals(SystemProperties.get("ro.product.device"))) {
            this.mConnector = null;
            this.mThread = null;
            this.mDaemonHandler = null;
            this.mPhoneStateListener = null;
            return;
        }
        this.mConnector = new NativeDaemonConnector(new NetdCallbackReceiver(), socket, MAX_UID_RANGES_PER_COMMAND, NETD_TAG, HdmiCecKeycode.UI_SOUND_PRESENTATION_SELECT_AUDIO_AUTO_EQUALIZER, null, FgThread.get().getLooper());
        this.mThread = new Thread(this.mConnector, NETD_TAG);
        this.mDaemonHandler = new Handler(FgThread.get().getLooper());
        this.mPhoneStateListener = new C00671(Integer.MAX_VALUE, this.mDaemonHandler.getLooper());
        TelephonyManager tm = (TelephonyManager) context.getSystemService("phone");
        if (tm != null) {
            tm.listen(this.mPhoneStateListener, DumpState.DUMP_INSTALLS);
        }
        Watchdog.getInstance().addMonitor(this);
    }

    static NetworkManagementService create(Context context, String socket) throws InterruptedException {
        NetworkManagementService service = new NetworkManagementService(context, socket);
        CountDownLatch connectedSignal = service.mConnectedSignal;
        service.mThread.start();
        connectedSignal.await();
        return service;
    }

    public static NetworkManagementService create(Context context) throws InterruptedException {
        return create(context, NETD_SOCKET_NAME);
    }

    public void systemReady() {
        prepareNativeDaemon();
    }

    private IBatteryStats getBatteryStats() {
        IBatteryStats iBatteryStats;
        synchronized (this) {
            if (this.mBatteryStats != null) {
                iBatteryStats = this.mBatteryStats;
            } else {
                this.mBatteryStats = IBatteryStats.Stub.asInterface(ServiceManager.getService("batterystats"));
                iBatteryStats = this.mBatteryStats;
            }
        }
        return iBatteryStats;
    }

    public void registerObserver(INetworkManagementEventObserver observer) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        this.mObservers.register(observer);
    }

    public void unregisterObserver(INetworkManagementEventObserver observer) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        this.mObservers.unregister(observer);
    }

    private void notifyInterfaceStatusChanged(String iface, boolean up) {
        int length = this.mObservers.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).interfaceStatusChanged(iface, up);
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            } catch (Throwable th) {
                this.mObservers.finishBroadcast();
            }
        }
        this.mObservers.finishBroadcast();
    }

    private void notifyInterfaceLinkStateChanged(String iface, boolean up) {
        int length = this.mObservers.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).interfaceLinkStateChanged(iface, up);
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            } catch (Throwable th) {
                this.mObservers.finishBroadcast();
            }
        }
        this.mObservers.finishBroadcast();
    }

    private void notifyInterfaceAdded(String iface) {
        int length = this.mObservers.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).interfaceAdded(iface);
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            } catch (Throwable th) {
                this.mObservers.finishBroadcast();
            }
        }
        this.mObservers.finishBroadcast();
    }

    private void notifyInterfaceRemoved(String iface) {
        this.mActiveAlerts.remove(iface);
        this.mActiveQuotas.remove(iface);
        int length = this.mObservers.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).interfaceRemoved(iface);
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            } catch (Throwable th) {
                this.mObservers.finishBroadcast();
            }
        }
        this.mObservers.finishBroadcast();
    }

    private void notifyLimitReached(String limitName, String iface) {
        int length = this.mObservers.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).limitReached(limitName, iface);
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            } catch (Throwable th) {
                this.mObservers.finishBroadcast();
            }
        }
        this.mObservers.finishBroadcast();
    }

    private void notifyInterfaceClassActivity(int type, int powerState, long tsNanos, boolean fromRadio) {
        boolean isActive = true;
        boolean isMobile = ConnectivityManager.isNetworkTypeMobile(type);
        if (isMobile) {
            if (fromRadio) {
                this.mMobileActivityFromRadio = true;
            } else if (this.mMobileActivityFromRadio) {
                powerState = this.mLastPowerStateFromRadio;
            }
            if (this.mLastPowerStateFromRadio != powerState) {
                this.mLastPowerStateFromRadio = powerState;
                try {
                    getBatteryStats().noteMobileRadioPowerState(powerState, tsNanos);
                } catch (RemoteException e) {
                }
            }
        }
        if (!(powerState == DataConnectionRealTimeInfo.DC_POWER_STATE_MEDIUM || powerState == DataConnectionRealTimeInfo.DC_POWER_STATE_HIGH)) {
            isActive = DBG;
        }
        if (!(isMobile && !fromRadio && this.mMobileActivityFromRadio)) {
            int length = this.mObservers.beginBroadcast();
            for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
                try {
                    ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).interfaceClassDataActivityChanged(Integer.toString(type), isActive, tsNanos);
                } catch (RemoteException e2) {
                } catch (RuntimeException e3) {
                } catch (Throwable th) {
                    this.mObservers.finishBroadcast();
                }
            }
            this.mObservers.finishBroadcast();
        }
        boolean report = DBG;
        synchronized (this.mIdleTimerLock) {
            if (this.mActiveIdleTimers.isEmpty()) {
                isActive = true;
            }
            if (this.mNetworkActive != isActive) {
                this.mNetworkActive = isActive;
                report = isActive;
            }
        }
        if (report) {
            reportNetworkActive();
        }
    }

    private void notifyInterfaceMessage(String message) {
        int length = this.mObservers.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).interfaceMessageRecevied(message);
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            }
        }
        this.mObservers.finishBroadcast();
    }

    private void prepareNativeDaemon() {
        this.mBandwidthControlEnabled = DBG;
        if (new File("/proc/net/xt_qtaguid/ctrl").exists()) {
            Slog.d(TAG, "enabling bandwidth control");
            try {
                Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
                objArr[0] = "enable";
                this.mConnector.execute("bandwidth", objArr);
                this.mBandwidthControlEnabled = true;
            } catch (NativeDaemonConnectorException e) {
                Log.wtf(TAG, "problem enabling bandwidth controls", e);
            }
        } else {
            Slog.d(TAG, "not enabling bandwidth control");
        }
        SystemProperties.set("net.qtaguid_enabled", this.mBandwidthControlEnabled ? "1" : "0");
        if (this.mBandwidthControlEnabled) {
            try {
                getBatteryStats().noteNetworkStatsEnabled();
            } catch (RemoteException e2) {
            }
        }
        synchronized (this.mQuotaLock) {
            int size = this.mActiveQuotas.size();
            if (size > 0) {
                Slog.d(TAG, "pushing " + size + " active quota rules");
                HashMap<String, Long> activeQuotas = this.mActiveQuotas;
                this.mActiveQuotas = Maps.newHashMap();
                for (Entry<String, Long> entry : activeQuotas.entrySet()) {
                    setInterfaceQuota((String) entry.getKey(), ((Long) entry.getValue()).longValue());
                }
            }
            size = this.mActiveAlerts.size();
            if (size > 0) {
                Slog.d(TAG, "pushing " + size + " active alert rules");
                HashMap<String, Long> activeAlerts = this.mActiveAlerts;
                this.mActiveAlerts = Maps.newHashMap();
                for (Entry<String, Long> entry2 : activeAlerts.entrySet()) {
                    setInterfaceAlert((String) entry2.getKey(), ((Long) entry2.getValue()).longValue());
                }
            }
            size = this.mUidRejectOnQuota.size();
            if (size > 0) {
                Slog.d(TAG, "pushing " + size + " active uid rules");
                SparseBooleanArray uidRejectOnQuota = this.mUidRejectOnQuota;
                this.mUidRejectOnQuota = new SparseBooleanArray();
                for (int i = 0; i < uidRejectOnQuota.size(); i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
                    setUidNetworkRules(uidRejectOnQuota.keyAt(i), uidRejectOnQuota.valueAt(i));
                }
            }
        }
        boolean z = (this.mFirewallEnabled || LockdownVpnTracker.isEnabled()) ? true : DBG;
        setFirewallEnabled(z);
    }

    private void notifyAddressUpdated(String iface, LinkAddress address) {
        int length = this.mObservers.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).addressUpdated(iface, address);
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            } catch (Throwable th) {
                this.mObservers.finishBroadcast();
            }
        }
        this.mObservers.finishBroadcast();
    }

    private void notifyAddressRemoved(String iface, LinkAddress address) {
        int length = this.mObservers.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).addressRemoved(iface, address);
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            } catch (Throwable th) {
                this.mObservers.finishBroadcast();
            }
        }
        this.mObservers.finishBroadcast();
    }

    private void notifyInterfaceDnsServerInfo(String iface, long lifetime, String[] addresses) {
        int length = this.mObservers.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).interfaceDnsServerInfo(iface, lifetime, addresses);
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            } catch (Throwable th) {
                this.mObservers.finishBroadcast();
            }
        }
        this.mObservers.finishBroadcast();
    }

    private void notifyRouteChange(String action, RouteInfo route) {
        int length = this.mObservers.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                if (action.equals("updated")) {
                    ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).routeUpdated(route);
                } else {
                    ((INetworkManagementEventObserver) this.mObservers.getBroadcastItem(i)).routeRemoved(route);
                }
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            } catch (Throwable th) {
                this.mObservers.finishBroadcast();
            }
        }
        this.mObservers.finishBroadcast();
    }

    public String[] listInterfaces() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
            objArr[0] = "list";
            return NativeDaemonEvent.filterMessageList(this.mConnector.executeForList("interface", objArr), NetdResponseCode.InterfaceListResult);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void addUpstreamV6Interface(String iface) throws RemoteException {
        this.mContext.enforceCallingOrSelfPermission("android.permission.ACCESS_NETWORK_STATE", TAG);
        Slog.d(TAG, "addUpstreamInterface(" + iface + ")");
        try {
            Command cmd = new Command("tether", "interface", "add_upstream");
            cmd.appendArg(iface);
            this.mConnector.execute(cmd);
        } catch (NativeDaemonConnectorException e) {
            throw new RemoteException("Cannot add upstream interface");
        }
    }

    public void removeUpstreamV6Interface(String iface) throws RemoteException {
        this.mContext.enforceCallingOrSelfPermission("android.permission.ACCESS_NETWORK_STATE", TAG);
        Slog.d(TAG, "removeUpstreamInterface(" + iface + ")");
        try {
            Command cmd = new Command("tether", "interface", "remove_upstream");
            cmd.appendArg(iface);
            this.mConnector.execute(cmd);
        } catch (NativeDaemonConnectorException e) {
            throw new RemoteException("Cannot remove upstream interface");
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.net.InterfaceConfiguration getInterfaceConfig(java.lang.String r15) {
        /*
        r14 = this;
        r9 = r14.mContext;
        r10 = "android.permission.CONNECTIVITY_INTERNAL";
        r11 = "NetworkManagementService";
        r9.enforceCallingOrSelfPermission(r10, r11);
        r9 = r14.mConnector;	 Catch:{ NativeDaemonConnectorException -> 0x007a }
        r10 = "interface";
        r11 = 2;
        r11 = new java.lang.Object[r11];	 Catch:{ NativeDaemonConnectorException -> 0x007a }
        r12 = 0;
        r13 = "getcfg";
        r11[r12] = r13;	 Catch:{ NativeDaemonConnectorException -> 0x007a }
        r12 = 1;
        r11[r12] = r15;	 Catch:{ NativeDaemonConnectorException -> 0x007a }
        r3 = r9.execute(r10, r11);	 Catch:{ NativeDaemonConnectorException -> 0x007a }
        r9 = 213; // 0xd5 float:2.98E-43 double:1.05E-321;
        r3.checkCode(r9);
        r8 = new java.util.StringTokenizer;
        r9 = r3.getMessage();
        r8.<init>(r9);
        r1 = new android.net.InterfaceConfiguration;	 Catch:{ NoSuchElementException -> 0x0060 }
        r1.<init>();	 Catch:{ NoSuchElementException -> 0x0060 }
        r9 = " ";
        r9 = r8.nextToken(r9);	 Catch:{ NoSuchElementException -> 0x0060 }
        r1.setHardwareAddress(r9);	 Catch:{ NoSuchElementException -> 0x0060 }
        r0 = 0;
        r7 = 0;
        r9 = r8.nextToken();	 Catch:{ IllegalArgumentException -> 0x0080 }
        r0 = android.net.NetworkUtils.numericToInetAddress(r9);	 Catch:{ IllegalArgumentException -> 0x0080 }
    L_0x0042:
        r9 = r8.nextToken();	 Catch:{ NumberFormatException -> 0x0089 }
        r7 = java.lang.Integer.parseInt(r9);	 Catch:{ NumberFormatException -> 0x0089 }
    L_0x004a:
        r9 = new android.net.LinkAddress;	 Catch:{ NoSuchElementException -> 0x0060 }
        r9.<init>(r0, r7);	 Catch:{ NoSuchElementException -> 0x0060 }
        r1.setLinkAddress(r9);	 Catch:{ NoSuchElementException -> 0x0060 }
    L_0x0052:
        r9 = r8.hasMoreTokens();	 Catch:{ NoSuchElementException -> 0x0060 }
        if (r9 == 0) goto L_0x0092;
    L_0x0058:
        r9 = r8.nextToken();	 Catch:{ NoSuchElementException -> 0x0060 }
        r1.setFlag(r9);	 Catch:{ NoSuchElementException -> 0x0060 }
        goto L_0x0052;
    L_0x0060:
        r6 = move-exception;
        r9 = new java.lang.IllegalStateException;
        r10 = new java.lang.StringBuilder;
        r10.<init>();
        r11 = "Invalid response from daemon: ";
        r10 = r10.append(r11);
        r10 = r10.append(r3);
        r10 = r10.toString();
        r9.<init>(r10);
        throw r9;
    L_0x007a:
        r2 = move-exception;
        r9 = r2.rethrowAsParcelableException();
        throw r9;
    L_0x0080:
        r4 = move-exception;
        r9 = "NetworkManagementService";
        r10 = "Failed to parse ipaddr";
        android.util.Slog.e(r9, r10, r4);	 Catch:{ NoSuchElementException -> 0x0060 }
        goto L_0x0042;
    L_0x0089:
        r5 = move-exception;
        r9 = "NetworkManagementService";
        r10 = "Failed to parse prefixLength";
        android.util.Slog.e(r9, r10, r5);	 Catch:{ NoSuchElementException -> 0x0060 }
        goto L_0x004a;
    L_0x0092:
        return r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.NetworkManagementService.getInterfaceConfig(java.lang.String):android.net.InterfaceConfiguration");
    }

    public void setInterfaceConfig(String iface, InterfaceConfiguration cfg) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        LinkAddress linkAddr = cfg.getLinkAddress();
        if (linkAddr == null || linkAddr.getAddress() == null) {
            throw new IllegalStateException("Null LinkAddress given");
        }
        Command cmd = new Command("interface", "setcfg", iface, linkAddr.getAddress().getHostAddress(), Integer.valueOf(linkAddr.getPrefixLength()));
        for (String flag : cfg.getFlags()) {
            cmd.appendArg(flag);
        }
        try {
            this.mConnector.execute(cmd);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setInterfaceDown(String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        InterfaceConfiguration ifcg = getInterfaceConfig(iface);
        ifcg.setInterfaceDown();
        setInterfaceConfig(iface, ifcg);
    }

    public void setInterfaceUp(String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        InterfaceConfiguration ifcg = getInterfaceConfig(iface);
        ifcg.setInterfaceUp();
        setInterfaceConfig(iface, ifcg);
    }

    public void setInterfaceIpv6PrivacyExtensions(String iface, boolean enable) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            NativeDaemonConnector nativeDaemonConnector = this.mConnector;
            String str = "interface";
            Object[] objArr = new Object[3];
            objArr[0] = "ipv6privacyextensions";
            objArr[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO] = iface;
            objArr[2] = enable ? "enable" : "disable";
            nativeDaemonConnector.execute(str, objArr);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void clearInterfaceAddresses(String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("interface", "clearaddrs", iface);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void enableIpv6(String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("interface", "ipv6", iface, "enable");
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void disableIpv6(String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("interface", "ipv6", iface, "disable");
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setInterfaceIpv6NdOffload(String iface, boolean enable) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            NativeDaemonConnector nativeDaemonConnector = this.mConnector;
            String str = "interface";
            Object[] objArr = new Object[3];
            objArr[0] = "ipv6ndoffload";
            objArr[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO] = iface;
            objArr[2] = enable ? "enable" : "disable";
            nativeDaemonConnector.execute(str, objArr);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void addRoute(int netId, RouteInfo route) {
        modifyRoute("add", "" + netId, route);
    }

    public void removeRoute(int netId, RouteInfo route) {
        modifyRoute("remove", "" + netId, route);
    }

    private void modifyRoute(String action, String netId, RouteInfo route) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        Command cmd = new Command("network", "route", action, netId);
        cmd.appendArg(route.getInterface());
        cmd.appendArg(route.getDestination().toString());
        switch (route.getType()) {
            case DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO /*1*/:
                if (route.hasGateway()) {
                    cmd.appendArg(route.getGateway().getHostAddress());
                    break;
                }
                break;
            case C0569H.FINISHED_STARTING /*7*/:
                cmd.appendArg("unreachable");
                break;
            case C0569H.REPORT_APPLICATION_TOKEN_DRAWN /*9*/:
                cmd.appendArg("throw");
                break;
        }
        try {
            this.mConnector.execute(cmd);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private java.util.ArrayList<java.lang.String> readRouteList(java.lang.String r9) {
        /*
        r8 = this;
        r1 = 0;
        r4 = new java.util.ArrayList;
        r4.<init>();
        r2 = new java.io.FileInputStream;	 Catch:{ IOException -> 0x004a, all -> 0x003c }
        r2.<init>(r9);	 Catch:{ IOException -> 0x004a, all -> 0x003c }
        r3 = new java.io.DataInputStream;	 Catch:{ IOException -> 0x002a, all -> 0x0047 }
        r3.<init>(r2);	 Catch:{ IOException -> 0x002a, all -> 0x0047 }
        r0 = new java.io.BufferedReader;	 Catch:{ IOException -> 0x002a, all -> 0x0047 }
        r6 = new java.io.InputStreamReader;	 Catch:{ IOException -> 0x002a, all -> 0x0047 }
        r6.<init>(r3);	 Catch:{ IOException -> 0x002a, all -> 0x0047 }
        r0.<init>(r6);	 Catch:{ IOException -> 0x002a, all -> 0x0047 }
    L_0x001a:
        r5 = r0.readLine();	 Catch:{ IOException -> 0x002a, all -> 0x0047 }
        if (r5 == 0) goto L_0x0032;
    L_0x0020:
        r6 = r5.length();	 Catch:{ IOException -> 0x002a, all -> 0x0047 }
        if (r6 == 0) goto L_0x0032;
    L_0x0026:
        r4.add(r5);	 Catch:{ IOException -> 0x002a, all -> 0x0047 }
        goto L_0x001a;
    L_0x002a:
        r6 = move-exception;
        r1 = r2;
    L_0x002c:
        if (r1 == 0) goto L_0x0031;
    L_0x002e:
        r1.close();	 Catch:{ IOException -> 0x0043 }
    L_0x0031:
        return r4;
    L_0x0032:
        if (r2 == 0) goto L_0x004c;
    L_0x0034:
        r2.close();	 Catch:{ IOException -> 0x0039 }
        r1 = r2;
        goto L_0x0031;
    L_0x0039:
        r6 = move-exception;
        r1 = r2;
        goto L_0x0031;
    L_0x003c:
        r6 = move-exception;
    L_0x003d:
        if (r1 == 0) goto L_0x0042;
    L_0x003f:
        r1.close();	 Catch:{ IOException -> 0x0045 }
    L_0x0042:
        throw r6;
    L_0x0043:
        r6 = move-exception;
        goto L_0x0031;
    L_0x0045:
        r7 = move-exception;
        goto L_0x0042;
    L_0x0047:
        r6 = move-exception;
        r1 = r2;
        goto L_0x003d;
    L_0x004a:
        r6 = move-exception;
        goto L_0x002c;
    L_0x004c:
        r1 = r2;
        goto L_0x0031;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.NetworkManagementService.readRouteList(java.lang.String):java.util.ArrayList<java.lang.String>");
    }

    public RouteInfo[] getRoutes(String interfaceName) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        ArrayList<RouteInfo> routes = new ArrayList();
        Iterator i$ = readRouteList("/proc/net/route").iterator();
        while (i$.hasNext()) {
            String dest;
            String gate;
            String s = (String) i$.next();
            String[] fields = s.split("\t");
            int length = fields.length;
            if (r0 > 7) {
                if (interfaceName.equals(fields[0])) {
                    dest = fields[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
                    gate = fields[2];
                    String flags = fields[3];
                    String mask = fields[7];
                    try {
                        routes.add(new RouteInfo(new LinkAddress(NetworkUtils.intToInetAddress((int) Long.parseLong(dest, 16)), NetworkUtils.netmaskIntToPrefixLength((int) Long.parseLong(mask, 16))), NetworkUtils.intToInetAddress((int) Long.parseLong(gate, 16))));
                    } catch (Exception e) {
                        Log.e(TAG, "Error parsing route " + s + " : " + e);
                    }
                }
            }
        }
        i$ = readRouteList("/proc/net/ipv6_route").iterator();
        while (i$.hasNext()) {
            s = (String) i$.next();
            fields = s.split("\\s+");
            length = fields.length;
            if (r0 > 9) {
                if (interfaceName.equals(fields[9].trim())) {
                    dest = fields[0];
                    String prefix = fields[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
                    gate = fields[4];
                    try {
                        routes.add(new RouteInfo(new LinkAddress(NetworkUtils.hexToInet6Address(dest), Integer.parseInt(prefix, 16)), NetworkUtils.hexToInet6Address(gate)));
                    } catch (Exception e2) {
                        Log.e(TAG, "Error parsing route " + s + " : " + e2);
                    }
                }
            }
        }
        return (RouteInfo[]) routes.toArray(new RouteInfo[routes.size()]);
    }

    public void setMtu(String iface, int mtu) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            NativeDaemonEvent event = this.mConnector.execute("interface", "setmtu", iface, Integer.valueOf(mtu));
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void shutdown() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.SHUTDOWN", TAG);
        Slog.d(TAG, "Shutting down");
    }

    public boolean getIpForwardingEnabled() throws IllegalStateException {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
            objArr[0] = "status";
            NativeDaemonEvent event = this.mConnector.execute("ipfwd", objArr);
            event.checkCode(NetdResponseCode.IpFwdStatusResult);
            return event.getMessage().endsWith("enabled");
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setIpForwardingEnabled(boolean enable) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            NativeDaemonConnector nativeDaemonConnector = this.mConnector;
            String str = "ipfwd";
            Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
            objArr[0] = enable ? "enable" : "disable";
            nativeDaemonConnector.execute(str, objArr);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void startTethering(String[] dhcpRange) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
        objArr[0] = "start";
        Command cmd = new Command("tether", objArr);
        String[] arr$ = dhcpRange;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            cmd.appendArg(arr$[i$]);
        }
        try {
            this.mConnector.execute(cmd);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void stopTethering() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
            objArr[0] = "stop";
            this.mConnector.execute("tether", objArr);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public boolean isTetheringStarted() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
            objArr[0] = "status";
            NativeDaemonEvent event = this.mConnector.execute("tether", objArr);
            event.checkCode(NetdResponseCode.TetherStatusResult);
            return event.getMessage().endsWith("started");
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void tetherInterface(String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("tether", "interface", "add", iface);
            List<RouteInfo> routes = new ArrayList();
            routes.add(new RouteInfo(getInterfaceConfig(iface).getLinkAddress(), null, iface));
            addInterfaceToLocalNetwork(iface, routes);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void untetherInterface(String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("tether", "interface", "remove", iface);
            removeInterfaceFromLocalNetwork(iface);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public String[] listTetheredInterfaces() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            return NativeDaemonEvent.filterMessageList(this.mConnector.executeForList("tether", "interface", "list"), NetdResponseCode.TetherInterfaceListResult);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setDnsForwarders(Network network, String[] dns) {
        int netId;
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        if (network != null) {
            netId = network.netId;
        } else {
            netId = 0;
        }
        Command cmd = new Command("tether", "dns", "set", Integer.valueOf(netId));
        String[] arr$ = dns;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            cmd.appendArg(NetworkUtils.numericToInetAddress(arr$[i$]).getHostAddress());
        }
        try {
            this.mConnector.execute(cmd);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public String[] getDnsForwarders() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            return NativeDaemonEvent.filterMessageList(this.mConnector.executeForList("tether", "dns", "list"), HdmiCecKeycode.UI_BROADCAST_DIGITAL_CABLE);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    private List<InterfaceAddress> excludeLinkLocal(List<InterfaceAddress> addresses) {
        ArrayList<InterfaceAddress> filtered = new ArrayList(addresses.size());
        for (InterfaceAddress ia : addresses) {
            if (!ia.getAddress().isLinkLocalAddress()) {
                filtered.add(ia);
            }
        }
        return filtered;
    }

    private void modifyNat(String action, String internalInterface, String externalInterface) throws SocketException {
        Command cmd = new Command("nat", action, internalInterface, externalInterface);
        NetworkInterface internalNetworkInterface = NetworkInterface.getByName(internalInterface);
        if (internalNetworkInterface == null) {
            cmd.appendArg("0");
        } else {
            List<InterfaceAddress> interfaceAddresses = excludeLinkLocal(internalNetworkInterface.getInterfaceAddresses());
            cmd.appendArg(Integer.valueOf(interfaceAddresses.size()));
            for (InterfaceAddress ia : interfaceAddresses) {
                cmd.appendArg(NetworkUtils.getNetworkPart(ia.getAddress(), ia.getNetworkPrefixLength()).getHostAddress() + "/" + ia.getNetworkPrefixLength());
            }
        }
        try {
            this.mConnector.execute(cmd);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void enableNat(String internalInterface, String externalInterface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            modifyNat("enable", internalInterface, externalInterface);
        } catch (SocketException e) {
            throw new IllegalStateException(e);
        }
    }

    public void disableNat(String internalInterface, String externalInterface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            modifyNat("disable", internalInterface, externalInterface);
        } catch (SocketException e) {
            throw new IllegalStateException(e);
        }
    }

    public String[] listTtys() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            return NativeDaemonEvent.filterMessageList(this.mConnector.executeForList("list_ttys", new Object[0]), HdmiCecKeycode.CEC_KEYCODE_F1_BLUE);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void attachPppd(String tty, String localAddr, String remoteAddr, String dns1Addr, String dns2Addr) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("pppd", "attach", tty, NetworkUtils.numericToInetAddress(localAddr).getHostAddress(), NetworkUtils.numericToInetAddress(remoteAddr).getHostAddress(), NetworkUtils.numericToInetAddress(dns1Addr).getHostAddress(), NetworkUtils.numericToInetAddress(dns2Addr).getHostAddress());
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void detachPppd(String tty) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("pppd", "detach", tty);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void startAccessPoint(WifiConfiguration wifiConfig, String wlanIface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            if (this.mContext.getResources().getBoolean(17956887)) {
                wifiFirmwareReload(wlanIface, "AP");
            }
            if (wifiConfig == null) {
                this.mConnector.execute("softap", "set", wlanIface);
            } else {
                this.mConnector.execute("softap", "set", wlanIface, wifiConfig.SSID, "broadcast", "6", getSecurityType(wifiConfig), new SensitiveArg(wifiConfig.preSharedKey));
            }
            Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
            objArr[0] = "startap";
            this.mConnector.execute("softap", objArr);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    private static String getSecurityType(WifiConfiguration wifiConfig) {
        switch (wifiConfig.getAuthType()) {
            case DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO /*1*/:
                return "wpa-psk";
            case C0569H.DO_TRAVERSAL /*4*/:
                return "wpa2-psk";
            default:
                return "open";
        }
    }

    public void wifiFirmwareReload(String wlanIface, String mode) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("softap", "fwreload", wlanIface, mode);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void stopAccessPoint(String wlanIface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
            objArr[0] = "stopap";
            this.mConnector.execute("softap", objArr);
            wifiFirmwareReload(wlanIface, "STA");
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setAccessPoint(WifiConfiguration wifiConfig, String wlanIface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        if (wifiConfig == null) {
            try {
                this.mConnector.execute("softap", "set", wlanIface);
                return;
            } catch (NativeDaemonConnectorException e) {
                throw e.rethrowAsParcelableException();
            }
        }
        this.mConnector.execute("softap", "set", wlanIface, wifiConfig.SSID, "broadcast", "6", getSecurityType(wifiConfig), new SensitiveArg(wifiConfig.preSharedKey));
    }

    public void addIdleTimer(String iface, int timeout, int type) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        synchronized (this.mIdleTimerLock) {
            IdleTimerParams params = (IdleTimerParams) this.mActiveIdleTimers.get(iface);
            if (params != null) {
                params.networkCount += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO;
                return;
            }
            try {
                this.mConnector.execute("idletimer", "add", iface, Integer.toString(timeout), Integer.toString(type));
                this.mActiveIdleTimers.put(iface, new IdleTimerParams(timeout, type));
                if (ConnectivityManager.isNetworkTypeMobile(type)) {
                    this.mNetworkActive = DBG;
                }
                this.mDaemonHandler.post(new C00682(type));
            } catch (NativeDaemonConnectorException e) {
                throw e.rethrowAsParcelableException();
            }
        }
    }

    public void removeIdleTimer(String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        synchronized (this.mIdleTimerLock) {
            IdleTimerParams params = (IdleTimerParams) this.mActiveIdleTimers.get(iface);
            if (params != null) {
                int i = params.networkCount - 1;
                params.networkCount = i;
                if (i <= 0) {
                    try {
                        this.mConnector.execute("idletimer", "remove", iface, Integer.toString(params.timeout), Integer.toString(params.type));
                        this.mActiveIdleTimers.remove(iface);
                        this.mDaemonHandler.post(new C00693(params));
                        return;
                    } catch (NativeDaemonConnectorException e) {
                        throw e.rethrowAsParcelableException();
                    }
                }
            }
        }
    }

    public NetworkStats getNetworkStatsSummaryDev() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            return this.mStatsFactory.readNetworkStatsSummaryDev();
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    public NetworkStats getNetworkStatsSummaryXt() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            return this.mStatsFactory.readNetworkStatsSummaryXt();
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    public NetworkStats getNetworkStatsDetail() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            return this.mStatsFactory.readNetworkStatsDetail(-1, null, -1, null);
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    public void setInterfaceQuota(String iface, long quotaBytes) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        if (this.mBandwidthControlEnabled) {
            synchronized (this.mQuotaLock) {
                if (this.mActiveQuotas.containsKey(iface)) {
                    throw new IllegalStateException("iface " + iface + " already has quota");
                }
                try {
                    this.mConnector.execute("bandwidth", "setiquota", iface, Long.valueOf(quotaBytes));
                    this.mActiveQuotas.put(iface, Long.valueOf(quotaBytes));
                } catch (NativeDaemonConnectorException e) {
                    throw e.rethrowAsParcelableException();
                }
            }
        }
    }

    public void removeInterfaceQuota(String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        if (this.mBandwidthControlEnabled) {
            synchronized (this.mQuotaLock) {
                if (this.mActiveQuotas.containsKey(iface)) {
                    this.mActiveQuotas.remove(iface);
                    this.mActiveAlerts.remove(iface);
                    try {
                        this.mConnector.execute("bandwidth", "removeiquota", iface);
                        return;
                    } catch (NativeDaemonConnectorException e) {
                        throw e.rethrowAsParcelableException();
                    }
                }
            }
        }
    }

    public void setInterfaceAlert(String iface, long alertBytes) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        if (!this.mBandwidthControlEnabled) {
            return;
        }
        if (this.mActiveQuotas.containsKey(iface)) {
            synchronized (this.mQuotaLock) {
                if (this.mActiveAlerts.containsKey(iface)) {
                    throw new IllegalStateException("iface " + iface + " already has alert");
                }
                try {
                    this.mConnector.execute("bandwidth", "setinterfacealert", iface, Long.valueOf(alertBytes));
                    this.mActiveAlerts.put(iface, Long.valueOf(alertBytes));
                } catch (NativeDaemonConnectorException e) {
                    throw e.rethrowAsParcelableException();
                }
            }
            return;
        }
        throw new IllegalStateException("setting alert requires existing quota on iface");
    }

    public void removeInterfaceAlert(String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        if (this.mBandwidthControlEnabled) {
            synchronized (this.mQuotaLock) {
                if (this.mActiveAlerts.containsKey(iface)) {
                    try {
                        this.mConnector.execute("bandwidth", "removeinterfacealert", iface);
                        this.mActiveAlerts.remove(iface);
                        return;
                    } catch (NativeDaemonConnectorException e) {
                        throw e.rethrowAsParcelableException();
                    }
                }
            }
        }
    }

    public void setGlobalAlert(long alertBytes) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        if (this.mBandwidthControlEnabled) {
            try {
                this.mConnector.execute("bandwidth", "setglobalalert", Long.valueOf(alertBytes));
            } catch (NativeDaemonConnectorException e) {
                throw e.rethrowAsParcelableException();
            }
        }
    }

    public void setUidNetworkRules(int uid, boolean rejectOnQuotaInterfaces) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        if (this.mBandwidthControlEnabled) {
            synchronized (this.mQuotaLock) {
                if (this.mUidRejectOnQuota.get(uid, DBG) == rejectOnQuotaInterfaces) {
                    return;
                }
                try {
                    NativeDaemonConnector nativeDaemonConnector = this.mConnector;
                    String str = "bandwidth";
                    Object[] objArr = new Object[2];
                    objArr[0] = rejectOnQuotaInterfaces ? "addnaughtyapps" : "removenaughtyapps";
                    objArr[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO] = Integer.valueOf(uid);
                    nativeDaemonConnector.execute(str, objArr);
                    if (rejectOnQuotaInterfaces) {
                        this.mUidRejectOnQuota.put(uid, true);
                    } else {
                        this.mUidRejectOnQuota.delete(uid);
                    }
                } catch (NativeDaemonConnectorException e) {
                    throw e.rethrowAsParcelableException();
                }
            }
        }
    }

    public boolean isBandwidthControlEnabled() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        return this.mBandwidthControlEnabled;
    }

    public NetworkStats getNetworkStatsUidDetail(int uid) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            return this.mStatsFactory.readNetworkStatsDetail(uid, null, -1, null);
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    public NetworkStats getNetworkStatsTethering() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        NetworkStats stats = new NetworkStats(SystemClock.elapsedRealtime(), DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO);
        NativeDaemonEvent event;
        try {
            Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
            objArr[0] = "gettetherstats";
            NativeDaemonEvent[] arr$ = this.mConnector.executeForList("bandwidth", objArr);
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
                event = arr$[i$];
                if (event.getCode() == HdmiCecKeycode.CEC_KEYCODE_F2_RED) {
                    StringTokenizer tok = new StringTokenizer(event.getMessage());
                    String ifaceIn = tok.nextToken();
                    String ifaceOut = tok.nextToken();
                    NetworkStats.Entry entry = new NetworkStats.Entry();
                    entry.iface = ifaceOut;
                    entry.uid = -5;
                    entry.set = 0;
                    entry.tag = 0;
                    entry.rxBytes = Long.parseLong(tok.nextToken());
                    entry.rxPackets = Long.parseLong(tok.nextToken());
                    entry.txBytes = Long.parseLong(tok.nextToken());
                    entry.txPackets = Long.parseLong(tok.nextToken());
                    stats.combineValues(entry);
                }
            }
            return stats;
        } catch (NoSuchElementException e) {
            throw new IllegalStateException("problem parsing tethering stats: " + event);
        } catch (NumberFormatException e2) {
            throw new IllegalStateException("problem parsing tethering stats: " + event);
        } catch (NativeDaemonConnectorException e3) {
            throw e3.rethrowAsParcelableException();
        }
    }

    public void setDnsServersForNetwork(int netId, String[] servers, String domains) {
        Command cmd;
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        if (servers.length > 0) {
            String str = "resolver";
            Object[] objArr = new Object[3];
            objArr[0] = "setnetdns";
            objArr[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO] = Integer.valueOf(netId);
            if (domains == null) {
                domains = "";
            }
            objArr[2] = domains;
            cmd = new Command(str, objArr);
            String[] arr$ = servers;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
                InetAddress a = NetworkUtils.numericToInetAddress(arr$[i$]);
                if (!a.isAnyLocalAddress()) {
                    cmd.appendArg(a.getHostAddress());
                }
            }
        } else {
            cmd = new Command("resolver", "clearnetdns", Integer.valueOf(netId));
        }
        try {
            this.mConnector.execute(cmd);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void addVpnUidRanges(int netId, UidRange[] ranges) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        Object[] argv = new Object[13];
        argv[0] = SoundModelContract.KEY_USERS;
        argv[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO] = "add";
        argv[2] = Integer.valueOf(netId);
        int argc = 3;
        for (int i = 0; i < ranges.length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            int argc2 = argc + DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO;
            argv[argc] = ranges[i].toString();
            if (i == ranges.length - 1 || argc2 == argv.length) {
                try {
                    this.mConnector.execute("network", Arrays.copyOf(argv, argc2));
                    argc = 3;
                } catch (NativeDaemonConnectorException e) {
                    throw e.rethrowAsParcelableException();
                }
            }
            argc = argc2;
        }
    }

    public void removeVpnUidRanges(int netId, UidRange[] ranges) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        Object[] argv = new Object[13];
        argv[0] = SoundModelContract.KEY_USERS;
        argv[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO] = "remove";
        argv[2] = Integer.valueOf(netId);
        int argc = 3;
        for (int i = 0; i < ranges.length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            int argc2 = argc + DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO;
            argv[argc] = ranges[i].toString();
            if (i == ranges.length - 1 || argc2 == argv.length) {
                try {
                    this.mConnector.execute("network", Arrays.copyOf(argv, argc2));
                    argc = 3;
                } catch (NativeDaemonConnectorException e) {
                    throw e.rethrowAsParcelableException();
                }
            }
            argc = argc2;
        }
    }

    public void flushNetworkDnsCache(int netId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("resolver", "flushnet", Integer.valueOf(netId));
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setFirewallEnabled(boolean enabled) {
        enforceSystemUid();
        try {
            NativeDaemonConnector nativeDaemonConnector = this.mConnector;
            String str = "firewall";
            Object[] objArr = new Object[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO];
            objArr[0] = enabled ? "enable" : "disable";
            nativeDaemonConnector.execute(str, objArr);
            this.mFirewallEnabled = enabled;
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public boolean isFirewallEnabled() {
        enforceSystemUid();
        return this.mFirewallEnabled;
    }

    public void setFirewallInterfaceRule(String iface, boolean allow) {
        enforceSystemUid();
        Preconditions.checkState(this.mFirewallEnabled);
        String rule = allow ? "allow" : "deny";
        try {
            this.mConnector.execute("firewall", "set_interface_rule", iface, rule);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setFirewallEgressSourceRule(String addr, boolean allow) {
        enforceSystemUid();
        Preconditions.checkState(this.mFirewallEnabled);
        String rule = allow ? "allow" : "deny";
        try {
            this.mConnector.execute("firewall", "set_egress_source_rule", addr, rule);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setFirewallEgressDestRule(String addr, int port, boolean allow) {
        enforceSystemUid();
        Preconditions.checkState(this.mFirewallEnabled);
        String rule = allow ? "allow" : "deny";
        try {
            this.mConnector.execute("firewall", "set_egress_dest_rule", addr, Integer.valueOf(port), rule);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setFirewallUidRule(int uid, boolean allow) {
        enforceSystemUid();
        Preconditions.checkState(this.mFirewallEnabled);
        String rule = allow ? "allow" : "deny";
        try {
            this.mConnector.execute("firewall", "set_uid_rule", Integer.valueOf(uid), rule);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    private static void enforceSystemUid() {
        if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            throw new SecurityException("Only available to AID_SYSTEM");
        }
    }

    public void startClatd(String interfaceName) throws IllegalStateException {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("clatd", "start", interfaceName);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void stopClatd(String interfaceName) throws IllegalStateException {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("clatd", "stop", interfaceName);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public boolean isClatdStarted(String interfaceName) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            NativeDaemonEvent event = this.mConnector.execute("clatd", "status", interfaceName);
            event.checkCode(NetdResponseCode.ClatdStatusResult);
            return event.getMessage().endsWith("started");
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void registerNetworkActivityListener(INetworkActivityListener listener) {
        this.mNetworkActivityListeners.register(listener);
    }

    public void unregisterNetworkActivityListener(INetworkActivityListener listener) {
        this.mNetworkActivityListeners.unregister(listener);
    }

    public boolean isNetworkActive() {
        boolean z;
        synchronized (this.mNetworkActivityListeners) {
            z = (this.mNetworkActive || this.mActiveIdleTimers.isEmpty()) ? true : DBG;
        }
        return z;
    }

    private void reportNetworkActive() {
        int length = this.mNetworkActivityListeners.beginBroadcast();
        for (int i = 0; i < length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            try {
                ((INetworkActivityListener) this.mNetworkActivityListeners.getBroadcastItem(i)).onNetworkActive();
            } catch (RemoteException e) {
            } catch (RuntimeException e2) {
            } catch (Throwable th) {
                this.mNetworkActivityListeners.finishBroadcast();
            }
        }
        this.mNetworkActivityListeners.finishBroadcast();
    }

    public void monitor() {
        if (this.mConnector != null) {
            this.mConnector.monitor();
        }
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DUMP", TAG);
        pw.println("NetworkManagementService NativeDaemonConnector Log:");
        this.mConnector.dump(fd, pw, args);
        pw.println();
        pw.print("Bandwidth control enabled: ");
        pw.println(this.mBandwidthControlEnabled);
        pw.print("mMobileActivityFromRadio=");
        pw.print(this.mMobileActivityFromRadio);
        pw.print(" mLastPowerStateFromRadio=");
        pw.println(this.mLastPowerStateFromRadio);
        pw.print("mNetworkActive=");
        pw.println(this.mNetworkActive);
        synchronized (this.mQuotaLock) {
            pw.print("Active quota ifaces: ");
            pw.println(this.mActiveQuotas.toString());
            pw.print("Active alert ifaces: ");
            pw.println(this.mActiveAlerts.toString());
        }
        synchronized (this.mUidRejectOnQuota) {
            pw.print("UID reject on quota ifaces: [");
            int size = this.mUidRejectOnQuota.size();
            for (int i = 0; i < size; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
                pw.print(this.mUidRejectOnQuota.keyAt(i));
                if (i < size - 1) {
                    pw.print(",");
                }
            }
            pw.println("]");
        }
        synchronized (this.mIdleTimerLock) {
            pw.println("Idle timers:");
            for (Entry<String, IdleTimerParams> ent : this.mActiveIdleTimers.entrySet()) {
                pw.print("  ");
                pw.print((String) ent.getKey());
                pw.println(":");
                IdleTimerParams params = (IdleTimerParams) ent.getValue();
                pw.print("    timeout=");
                pw.print(params.timeout);
                pw.print(" type=");
                pw.print(params.type);
                pw.print(" networkCount=");
                pw.println(params.networkCount);
            }
        }
        pw.print("Firewall enabled: ");
        pw.println(this.mFirewallEnabled);
    }

    public void createPhysicalNetwork(int netId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("network", "create", Integer.valueOf(netId));
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void createVirtualNetwork(int netId, boolean hasDNS, boolean secure) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            NativeDaemonConnector nativeDaemonConnector = this.mConnector;
            String str = "network";
            Object[] objArr = new Object[5];
            objArr[0] = "create";
            objArr[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO] = Integer.valueOf(netId);
            objArr[2] = "vpn";
            objArr[3] = hasDNS ? "1" : "0";
            objArr[4] = secure ? "1" : "0";
            nativeDaemonConnector.execute(str, objArr);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void removeNetwork(int netId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("network", "destroy", Integer.valueOf(netId));
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void addInterfaceToNetwork(String iface, int netId) {
        modifyInterfaceInNetwork("add", "" + netId, iface);
    }

    public void removeInterfaceFromNetwork(String iface, int netId) {
        modifyInterfaceInNetwork("remove", "" + netId, iface);
    }

    private void modifyInterfaceInNetwork(String action, String netId, String iface) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("network", "interface", action, netId, iface);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void addLegacyRouteForNetId(int netId, RouteInfo routeInfo, int uid) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        Command cmd = new Command("network", "route", "legacy", Integer.valueOf(uid), "add", Integer.valueOf(netId));
        LinkAddress la = routeInfo.getDestinationLinkAddress();
        cmd.appendArg(routeInfo.getInterface());
        cmd.appendArg(la.getAddress().getHostAddress() + "/" + la.getPrefixLength());
        if (routeInfo.hasGateway()) {
            cmd.appendArg(routeInfo.getGateway().getHostAddress());
        }
        try {
            this.mConnector.execute(cmd);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setDefaultNetId(int netId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("network", "default", "set", Integer.valueOf(netId));
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void clearDefaultNetId() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("network", "default", "clear");
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setPermission(String permission, int[] uids) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        Object[] argv = new Object[14];
        argv[0] = "permission";
        argv[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO] = "user";
        argv[2] = "set";
        argv[3] = permission;
        int argc = 4;
        for (int i = 0; i < uids.length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            int argc2 = argc + DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO;
            argv[argc] = Integer.valueOf(uids[i]);
            if (i == uids.length - 1 || argc2 == argv.length) {
                try {
                    this.mConnector.execute("network", Arrays.copyOf(argv, argc2));
                    argc = 4;
                } catch (NativeDaemonConnectorException e) {
                    throw e.rethrowAsParcelableException();
                }
            }
            argc = argc2;
        }
    }

    public void clearPermission(int[] uids) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        Object[] argv = new Object[13];
        argv[0] = "permission";
        argv[DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO] = "user";
        argv[2] = "clear";
        int argc = 3;
        for (int i = 0; i < uids.length; i += DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO) {
            int argc2 = argc + DAEMON_MSG_MOBILE_CONN_REAL_TIME_INFO;
            argv[argc] = Integer.valueOf(uids[i]);
            if (i == uids.length - 1 || argc2 == argv.length) {
                try {
                    this.mConnector.execute("network", Arrays.copyOf(argv, argc2));
                    argc = 3;
                } catch (NativeDaemonConnectorException e) {
                    throw e.rethrowAsParcelableException();
                }
            }
            argc = argc2;
        }
    }

    public void allowProtect(int uid) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("network", "protect", "allow", Integer.valueOf(uid));
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void denyProtect(int uid) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        try {
            this.mConnector.execute("network", "protect", "deny", Integer.valueOf(uid));
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void addInterfaceToLocalNetwork(String iface, List<RouteInfo> routes) {
        modifyInterfaceInNetwork("add", "local", iface);
        for (RouteInfo route : routes) {
            if (!route.isDefaultRoute()) {
                modifyRoute("add", "local", route);
            }
        }
    }

    public void removeInterfaceFromLocalNetwork(String iface) {
        modifyInterfaceInNetwork("remove", "local", iface);
    }
}
