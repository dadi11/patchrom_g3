package com.android.server.net;

import android.app.IActivityManager;
import android.app.INotificationManager;
import android.app.IProcessObserver;
import android.app.Notification.Builder;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.UserInfo;
import android.content.res.Resources;
import android.net.ConnectivityManager;
import android.net.IConnectivityManager;
import android.net.INetworkManagementEventObserver;
import android.net.INetworkPolicyListener;
import android.net.INetworkPolicyManager.Stub;
import android.net.INetworkStatsService;
import android.net.LinkProperties;
import android.net.NetworkIdentity;
import android.net.NetworkInfo;
import android.net.NetworkPolicy;
import android.net.NetworkPolicyManager;
import android.net.NetworkQuotaInfo;
import android.net.NetworkState;
import android.net.NetworkTemplate;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiInfo;
import android.os.Binder;
import android.os.Environment;
import android.os.Handler;
import android.os.Handler.Callback;
import android.os.HandlerThread;
import android.os.INetworkManagementService;
import android.os.IPowerManager;
import android.os.Message;
import android.os.MessageQueue.IdleHandler;
import android.os.PowerManagerInternal;
import android.os.PowerManagerInternal.LowPowerModeListener;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.UserHandle;
import android.os.UserManager;
import android.provider.Settings.Secure;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.text.format.Formatter;
import android.text.format.Time;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.AtomicFile;
import android.util.Log;
import android.util.NtpTrustedTime;
import android.util.Pair;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseBooleanArray;
import android.util.SparseIntArray;
import android.util.TrustedTime;
import android.util.Xml;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.util.IndentingPrintWriter;
import com.android.internal.util.Preconditions;
import com.android.internal.util.XmlUtils;
import com.android.server.LocalServices;
import com.android.server.NetworkManagementService;
import com.android.server.SystemConfig;
import com.android.server.job.controllers.JobStatus;
import com.google.android.collect.Lists;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlSerializer;

public class NetworkPolicyManagerService extends Stub {
    private static final String ACTION_ALLOW_BACKGROUND = "com.android.server.net.action.ALLOW_BACKGROUND";
    private static final String ACTION_SNOOZE_WARNING = "com.android.server.net.action.SNOOZE_WARNING";
    private static final String ATTR_APP_ID = "appId";
    private static final String ATTR_CYCLE_DAY = "cycleDay";
    private static final String ATTR_CYCLE_TIMEZONE = "cycleTimezone";
    private static final String ATTR_INFERRED = "inferred";
    private static final String ATTR_LAST_LIMIT_SNOOZE = "lastLimitSnooze";
    private static final String ATTR_LAST_SNOOZE = "lastSnooze";
    private static final String ATTR_LAST_WARNING_SNOOZE = "lastWarningSnooze";
    private static final String ATTR_LIMIT_BYTES = "limitBytes";
    private static final String ATTR_METERED = "metered";
    private static final String ATTR_NETWORK_ID = "networkId";
    private static final String ATTR_NETWORK_TEMPLATE = "networkTemplate";
    private static final String ATTR_POLICY = "policy";
    private static final String ATTR_RESTRICT_BACKGROUND = "restrictBackground";
    private static final String ATTR_SUBSCRIBER_ID = "subscriberId";
    private static final String ATTR_UID = "uid";
    private static final String ATTR_VERSION = "version";
    private static final String ATTR_WARNING_BYTES = "warningBytes";
    private static final boolean LOGD = false;
    private static final boolean LOGV = false;
    private static final int MSG_ADVISE_PERSIST_THRESHOLD = 7;
    private static final int MSG_LIMIT_REACHED = 5;
    private static final int MSG_METERED_IFACES_CHANGED = 2;
    private static final int MSG_RESTRICT_BACKGROUND_CHANGED = 6;
    private static final int MSG_RULES_CHANGED = 1;
    private static final int MSG_SCREEN_ON_CHANGED = 8;
    private static final String TAG = "NetworkPolicy";
    private static final String TAG_ALLOW_BACKGROUND = "NetworkPolicy:allowBackground";
    private static final String TAG_APP_POLICY = "app-policy";
    private static final String TAG_NETWORK_POLICY = "network-policy";
    private static final String TAG_POLICY_LIST = "policy-list";
    private static final String TAG_UID_POLICY = "uid-policy";
    private static final long TIME_CACHE_MAX_AGE = 86400000;
    public static final int TYPE_LIMIT = 2;
    public static final int TYPE_LIMIT_SNOOZED = 3;
    public static final int TYPE_WARNING = 1;
    private static final int VERSION_ADDED_INFERRED = 7;
    private static final int VERSION_ADDED_METERED = 4;
    private static final int VERSION_ADDED_NETWORK_ID = 9;
    private static final int VERSION_ADDED_RESTRICT_BACKGROUND = 3;
    private static final int VERSION_ADDED_SNOOZE = 2;
    private static final int VERSION_ADDED_TIMEZONE = 6;
    private static final int VERSION_INIT = 1;
    private static final int VERSION_LATEST = 10;
    private static final int VERSION_SPLIT_SNOOZE = 5;
    private static final int VERSION_SWITCH_APP_ID = 8;
    private static final int VERSION_SWITCH_UID = 10;
    private final ArraySet<String> mActiveNotifs;
    private final IActivityManager mActivityManager;
    private INetworkManagementEventObserver mAlertObserver;
    private BroadcastReceiver mAllowReceiver;
    private IConnectivityManager mConnManager;
    private BroadcastReceiver mConnReceiver;
    private final Context mContext;
    private int mCurForegroundState;
    final Handler mHandler;
    private Callback mHandlerCallback;
    private final RemoteCallbackList<INetworkPolicyListener> mListeners;
    private ArraySet<String> mMeteredIfaces;
    private final INetworkManagementService mNetworkManager;
    final ArrayMap<NetworkTemplate, NetworkPolicy> mNetworkPolicy;
    final ArrayMap<NetworkPolicy, String[]> mNetworkRules;
    private final INetworkStatsService mNetworkStats;
    private INotificationManager mNotifManager;
    private final ArraySet<NetworkTemplate> mOverLimitNotified;
    private BroadcastReceiver mPackageReceiver;
    private final AtomicFile mPolicyFile;
    private final IPowerManager mPowerManager;
    private PowerManagerInternal mPowerManagerInternal;
    private final SparseBooleanArray mPowerSaveWhitelistAppIds;
    private IProcessObserver mProcessObserver;
    volatile boolean mRestrictBackground;
    volatile boolean mRestrictPower;
    final Object mRulesLock;
    volatile boolean mScreenOn;
    private BroadcastReceiver mScreenReceiver;
    private BroadcastReceiver mSnoozeWarningReceiver;
    private BroadcastReceiver mStatsReceiver;
    private final boolean mSuppressDefaultPolicy;
    private final TrustedTime mTime;
    final SparseArray<SparseIntArray> mUidPidState;
    final SparseIntArray mUidPolicy;
    private BroadcastReceiver mUidRemovedReceiver;
    final SparseIntArray mUidRules;
    final SparseIntArray mUidState;
    private BroadcastReceiver mUserReceiver;
    private BroadcastReceiver mWifiConfigReceiver;
    private BroadcastReceiver mWifiStateReceiver;

    /* renamed from: com.android.server.net.NetworkPolicyManagerService.1 */
    class C03911 implements LowPowerModeListener {
        C03911() {
        }

        public void onLowPowerModeChanged(boolean enabled) {
            synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                if (NetworkPolicyManagerService.this.mRestrictPower != enabled) {
                    NetworkPolicyManagerService.this.mRestrictPower = enabled;
                    NetworkPolicyManagerService.this.updateRulesForGlobalChangeLocked(true);
                }
            }
        }
    }

    /* renamed from: com.android.server.net.NetworkPolicyManagerService.2 */
    class C03922 extends IProcessObserver.Stub {
        C03922() {
        }

        public void onForegroundActivitiesChanged(int pid, int uid, boolean foregroundActivities) {
        }

        public void onProcessStateChanged(int pid, int uid, int procState) {
            synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                SparseIntArray pidState = (SparseIntArray) NetworkPolicyManagerService.this.mUidPidState.get(uid);
                if (pidState == null) {
                    pidState = new SparseIntArray(NetworkPolicyManagerService.VERSION_ADDED_SNOOZE);
                    NetworkPolicyManagerService.this.mUidPidState.put(uid, pidState);
                }
                pidState.put(pid, procState);
                NetworkPolicyManagerService.this.computeUidStateLocked(uid);
            }
        }

        public void onProcessDied(int pid, int uid) {
            synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                SparseIntArray pidState = (SparseIntArray) NetworkPolicyManagerService.this.mUidPidState.get(uid);
                if (pidState != null) {
                    pidState.delete(pid);
                    if (pidState.size() <= 0) {
                        NetworkPolicyManagerService.this.mUidPidState.remove(uid);
                    }
                    NetworkPolicyManagerService.this.computeUidStateLocked(uid);
                }
            }
        }
    }

    /* renamed from: com.android.server.net.NetworkPolicyManagerService.3 */
    class C03933 extends BroadcastReceiver {
        C03933() {
        }

        public void onReceive(Context context, Intent intent) {
            NetworkPolicyManagerService.this.mHandler.obtainMessage(NetworkPolicyManagerService.VERSION_SWITCH_APP_ID).sendToTarget();
        }
    }

    /* renamed from: com.android.server.net.NetworkPolicyManagerService.4 */
    class C03944 extends BroadcastReceiver {
        C03944() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            int uid = intent.getIntExtra("android.intent.extra.UID", -1);
            if (uid != -1 && "android.intent.action.PACKAGE_ADDED".equals(action)) {
                synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                    NetworkPolicyManagerService.this.updateRulesForUidLocked(uid);
                }
            }
        }
    }

    /* renamed from: com.android.server.net.NetworkPolicyManagerService.5 */
    class C03955 extends BroadcastReceiver {
        C03955() {
        }

        public void onReceive(Context context, Intent intent) {
            int uid = intent.getIntExtra("android.intent.extra.UID", -1);
            if (uid != -1) {
                synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                    NetworkPolicyManagerService.this.mUidPolicy.delete(uid);
                    NetworkPolicyManagerService.this.updateRulesForUidLocked(uid);
                    NetworkPolicyManagerService.this.writePolicyLocked();
                }
            }
        }
    }

    /* renamed from: com.android.server.net.NetworkPolicyManagerService.6 */
    class C03966 extends BroadcastReceiver {
        C03966() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            int userId = intent.getIntExtra("android.intent.extra.user_handle", -1);
            if (userId != -1) {
                synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                    NetworkPolicyManagerService.this.removePoliciesForUserLocked(userId);
                    NetworkPolicyManagerService.this.updateRulesForGlobalChangeLocked(true);
                }
            }
        }
    }

    /* renamed from: com.android.server.net.NetworkPolicyManagerService.7 */
    class C03977 extends BroadcastReceiver {
        C03977() {
        }

        public void onReceive(Context context, Intent intent) {
            NetworkPolicyManagerService.this.maybeRefreshTrustedTime();
            synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                NetworkPolicyManagerService.this.updateNetworkEnabledLocked();
                NetworkPolicyManagerService.this.updateNotificationsLocked();
            }
        }
    }

    /* renamed from: com.android.server.net.NetworkPolicyManagerService.8 */
    class C03988 extends BroadcastReceiver {
        C03988() {
        }

        public void onReceive(Context context, Intent intent) {
            NetworkPolicyManagerService.this.setRestrictBackground(NetworkPolicyManagerService.LOGV);
        }
    }

    /* renamed from: com.android.server.net.NetworkPolicyManagerService.9 */
    class C03999 extends BroadcastReceiver {
        C03999() {
        }

        public void onReceive(Context context, Intent intent) {
            NetworkPolicyManagerService.this.performSnooze((NetworkTemplate) intent.getParcelableExtra("android.net.NETWORK_TEMPLATE"), NetworkPolicyManagerService.VERSION_INIT);
        }
    }

    public NetworkPolicyManagerService(Context context, IActivityManager activityManager, IPowerManager powerManager, INetworkStatsService networkStats, INetworkManagementService networkManagement) {
        this(context, activityManager, powerManager, networkStats, networkManagement, NtpTrustedTime.getInstance(context), getSystemDir(), LOGV);
    }

    private static File getSystemDir() {
        return new File(Environment.getDataDirectory(), "system");
    }

    public NetworkPolicyManagerService(Context context, IActivityManager activityManager, IPowerManager powerManager, INetworkStatsService networkStats, INetworkManagementService networkManagement, TrustedTime time, File systemDir, boolean suppressDefaultPolicy) {
        this.mRulesLock = new Object();
        this.mNetworkPolicy = new ArrayMap();
        this.mNetworkRules = new ArrayMap();
        this.mUidPolicy = new SparseIntArray();
        this.mUidRules = new SparseIntArray();
        this.mPowerSaveWhitelistAppIds = new SparseBooleanArray();
        this.mMeteredIfaces = new ArraySet();
        this.mOverLimitNotified = new ArraySet();
        this.mActiveNotifs = new ArraySet();
        this.mUidState = new SparseIntArray();
        this.mUidPidState = new SparseArray();
        this.mCurForegroundState = VERSION_ADDED_SNOOZE;
        this.mListeners = new RemoteCallbackList();
        this.mProcessObserver = new C03922();
        this.mScreenReceiver = new C03933();
        this.mPackageReceiver = new C03944();
        this.mUidRemovedReceiver = new C03955();
        this.mUserReceiver = new C03966();
        this.mStatsReceiver = new C03977();
        this.mAllowReceiver = new C03988();
        this.mSnoozeWarningReceiver = new C03999();
        this.mWifiConfigReceiver = new BroadcastReceiver() {
            public void onReceive(Context context, Intent intent) {
                if (intent.getIntExtra("changeReason", 0) == NetworkPolicyManagerService.VERSION_INIT) {
                    WifiConfiguration config = (WifiConfiguration) intent.getParcelableExtra("wifiConfiguration");
                    if (config.SSID != null) {
                        NetworkTemplate template = NetworkTemplate.buildTemplateWifi(config.SSID);
                        synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                            if (NetworkPolicyManagerService.this.mNetworkPolicy.containsKey(template)) {
                                NetworkPolicyManagerService.this.mNetworkPolicy.remove(template);
                                NetworkPolicyManagerService.this.writePolicyLocked();
                            }
                        }
                    }
                }
            }
        };
        this.mWifiStateReceiver = new BroadcastReceiver() {
            public void onReceive(Context context, Intent intent) {
                if (((NetworkInfo) intent.getParcelableExtra("networkInfo")).isConnected()) {
                    WifiInfo info = (WifiInfo) intent.getParcelableExtra("wifiInfo");
                    boolean meteredHint = info.getMeteredHint();
                    NetworkTemplate template = NetworkTemplate.buildTemplateWifi(info.getSSID());
                    synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                        NetworkPolicy policy = (NetworkPolicy) NetworkPolicyManagerService.this.mNetworkPolicy.get(template);
                        if (policy == null && meteredHint) {
                            NetworkPolicyManagerService.this.addNetworkPolicyLocked(new NetworkPolicy(template, -1, "UTC", -1, -1, -1, -1, meteredHint, true));
                        } else if (policy != null) {
                            if (policy.inferred) {
                                policy.metered = meteredHint;
                                NetworkPolicyManagerService.this.updateNetworkRulesLocked();
                            }
                        }
                    }
                }
            }
        };
        this.mAlertObserver = new BaseNetworkObserver() {
            public void limitReached(String limitName, String iface) {
                NetworkPolicyManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", NetworkPolicyManagerService.TAG);
                if (!NetworkManagementService.LIMIT_GLOBAL_ALERT.equals(limitName)) {
                    NetworkPolicyManagerService.this.mHandler.obtainMessage(NetworkPolicyManagerService.VERSION_SPLIT_SNOOZE, iface).sendToTarget();
                }
            }
        };
        this.mConnReceiver = new BroadcastReceiver() {
            public void onReceive(Context context, Intent intent) {
                NetworkPolicyManagerService.this.maybeRefreshTrustedTime();
                synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                    NetworkPolicyManagerService.this.ensureActiveMobilePolicyLocked();
                    NetworkPolicyManagerService.this.normalizePoliciesLocked();
                    NetworkPolicyManagerService.this.updateNetworkEnabledLocked();
                    NetworkPolicyManagerService.this.updateNetworkRulesLocked();
                    NetworkPolicyManagerService.this.updateNotificationsLocked();
                }
            }
        };
        this.mHandlerCallback = new Callback() {
            public boolean handleMessage(Message msg) {
                int length;
                int i;
                INetworkPolicyListener listener;
                switch (msg.what) {
                    case NetworkPolicyManagerService.VERSION_INIT /*1*/:
                        int uid = msg.arg1;
                        int uidRules = msg.arg2;
                        length = NetworkPolicyManagerService.this.mListeners.beginBroadcast();
                        for (i = 0; i < length; i += NetworkPolicyManagerService.VERSION_INIT) {
                            listener = (INetworkPolicyListener) NetworkPolicyManagerService.this.mListeners.getBroadcastItem(i);
                            if (listener != null) {
                                try {
                                    listener.onUidRulesChanged(uid, uidRules);
                                } catch (RemoteException e) {
                                }
                            }
                        }
                        NetworkPolicyManagerService.this.mListeners.finishBroadcast();
                        return true;
                    case NetworkPolicyManagerService.VERSION_ADDED_SNOOZE /*2*/:
                        String[] meteredIfaces = (String[]) msg.obj;
                        length = NetworkPolicyManagerService.this.mListeners.beginBroadcast();
                        for (i = 0; i < length; i += NetworkPolicyManagerService.VERSION_INIT) {
                            listener = (INetworkPolicyListener) NetworkPolicyManagerService.this.mListeners.getBroadcastItem(i);
                            if (listener != null) {
                                try {
                                    listener.onMeteredIfacesChanged(meteredIfaces);
                                } catch (RemoteException e2) {
                                }
                            }
                        }
                        NetworkPolicyManagerService.this.mListeners.finishBroadcast();
                        return true;
                    case NetworkPolicyManagerService.VERSION_SPLIT_SNOOZE /*5*/:
                        String iface = msg.obj;
                        NetworkPolicyManagerService.this.maybeRefreshTrustedTime();
                        synchronized (NetworkPolicyManagerService.this.mRulesLock) {
                            if (NetworkPolicyManagerService.this.mMeteredIfaces.contains(iface)) {
                                try {
                                    NetworkPolicyManagerService.this.mNetworkStats.forceUpdate();
                                } catch (RemoteException e3) {
                                }
                                NetworkPolicyManagerService.this.updateNetworkEnabledLocked();
                                NetworkPolicyManagerService.this.updateNotificationsLocked();
                                break;
                            }
                            break;
                        }
                        return true;
                    case NetworkPolicyManagerService.VERSION_ADDED_TIMEZONE /*6*/:
                        boolean restrictBackground = msg.arg1 != 0 ? true : NetworkPolicyManagerService.LOGV;
                        length = NetworkPolicyManagerService.this.mListeners.beginBroadcast();
                        for (i = 0; i < length; i += NetworkPolicyManagerService.VERSION_INIT) {
                            listener = (INetworkPolicyListener) NetworkPolicyManagerService.this.mListeners.getBroadcastItem(i);
                            if (listener != null) {
                                try {
                                    listener.onRestrictBackgroundChanged(restrictBackground);
                                } catch (RemoteException e4) {
                                }
                            }
                        }
                        NetworkPolicyManagerService.this.mListeners.finishBroadcast();
                        return true;
                    case NetworkPolicyManagerService.VERSION_ADDED_INFERRED /*7*/:
                        try {
                            NetworkPolicyManagerService.this.mNetworkStats.advisePersistThreshold(((Long) msg.obj).longValue() / 1000);
                        } catch (RemoteException e5) {
                        }
                        return true;
                    case NetworkPolicyManagerService.VERSION_SWITCH_APP_ID /*8*/:
                        NetworkPolicyManagerService.this.updateScreenOn();
                        return true;
                    default:
                        return NetworkPolicyManagerService.LOGV;
                }
            }
        };
        this.mContext = (Context) Preconditions.checkNotNull(context, "missing context");
        this.mActivityManager = (IActivityManager) Preconditions.checkNotNull(activityManager, "missing activityManager");
        this.mPowerManager = (IPowerManager) Preconditions.checkNotNull(powerManager, "missing powerManager");
        this.mNetworkStats = (INetworkStatsService) Preconditions.checkNotNull(networkStats, "missing networkStats");
        this.mNetworkManager = (INetworkManagementService) Preconditions.checkNotNull(networkManagement, "missing networkManagement");
        this.mTime = (TrustedTime) Preconditions.checkNotNull(time, "missing TrustedTime");
        HandlerThread thread = new HandlerThread(TAG);
        thread.start();
        this.mHandler = new Handler(thread.getLooper(), this.mHandlerCallback);
        this.mSuppressDefaultPolicy = suppressDefaultPolicy;
        this.mPolicyFile = new AtomicFile(new File(systemDir, "netpolicy.xml"));
    }

    public void bindConnectivityManager(IConnectivityManager connManager) {
        this.mConnManager = (IConnectivityManager) Preconditions.checkNotNull(connManager, "missing IConnectivityManager");
    }

    public void bindNotificationManager(INotificationManager notifManager) {
        this.mNotifManager = (INotificationManager) Preconditions.checkNotNull(notifManager, "missing INotificationManager");
    }

    public void systemReady() {
        if (isBandwidthControlEnabled()) {
            PackageManager pm = this.mContext.getPackageManager();
            synchronized (this.mRulesLock) {
                ArraySet<String> allowPower = SystemConfig.getInstance().getAllowInPowerSave();
                for (int i = 0; i < allowPower.size(); i += VERSION_INIT) {
                    try {
                        ApplicationInfo ai = pm.getApplicationInfo((String) allowPower.valueAt(i), 0);
                        if ((ai.flags & VERSION_INIT) != 0) {
                            this.mPowerSaveWhitelistAppIds.put(UserHandle.getAppId(ai.uid), true);
                        }
                    } catch (NameNotFoundException e) {
                    }
                }
                this.mPowerManagerInternal = (PowerManagerInternal) LocalServices.getService(PowerManagerInternal.class);
                this.mPowerManagerInternal.registerLowPowerModeObserver(new C03911());
                this.mRestrictPower = this.mPowerManagerInternal.getLowPowerModeEnabled();
                readPolicyLocked();
                if (this.mRestrictBackground || this.mRestrictPower) {
                    updateRulesForGlobalChangeLocked(true);
                    updateNotificationsLocked();
                }
            }
            updateScreenOn();
            try {
                this.mActivityManager.registerProcessObserver(this.mProcessObserver);
                this.mNetworkManager.registerObserver(this.mAlertObserver);
            } catch (RemoteException e2) {
            }
            IntentFilter screenFilter = new IntentFilter();
            screenFilter.addAction("android.intent.action.SCREEN_ON");
            screenFilter.addAction("android.intent.action.SCREEN_OFF");
            this.mContext.registerReceiver(this.mScreenReceiver, screenFilter);
            IntentFilter connFilter = new IntentFilter("android.net.conn.CONNECTIVITY_CHANGE_IMMEDIATE");
            String str = "android.permission.CONNECTIVITY_INTERNAL";
            this.mContext.registerReceiver(this.mConnReceiver, connFilter, r22, this.mHandler);
            IntentFilter packageFilter = new IntentFilter();
            packageFilter.addAction("android.intent.action.PACKAGE_ADDED");
            packageFilter.addDataScheme("package");
            this.mContext.registerReceiver(this.mPackageReceiver, packageFilter, null, this.mHandler);
            this.mContext.registerReceiver(this.mUidRemovedReceiver, new IntentFilter("android.intent.action.UID_REMOVED"), null, this.mHandler);
            IntentFilter userFilter = new IntentFilter();
            userFilter.addAction("android.intent.action.USER_ADDED");
            userFilter.addAction("android.intent.action.USER_REMOVED");
            this.mContext.registerReceiver(this.mUserReceiver, userFilter, null, this.mHandler);
            IntentFilter statsFilter = new IntentFilter(NetworkStatsService.ACTION_NETWORK_STATS_UPDATED);
            str = "android.permission.READ_NETWORK_USAGE_HISTORY";
            this.mContext.registerReceiver(this.mStatsReceiver, statsFilter, r22, this.mHandler);
            IntentFilter allowFilter = new IntentFilter(ACTION_ALLOW_BACKGROUND);
            str = "android.permission.MANAGE_NETWORK_POLICY";
            this.mContext.registerReceiver(this.mAllowReceiver, allowFilter, r22, this.mHandler);
            IntentFilter snoozeWarningFilter = new IntentFilter(ACTION_SNOOZE_WARNING);
            str = "android.permission.MANAGE_NETWORK_POLICY";
            this.mContext.registerReceiver(this.mSnoozeWarningReceiver, snoozeWarningFilter, r22, this.mHandler);
            IntentFilter intentFilter = new IntentFilter("android.net.wifi.CONFIGURED_NETWORKS_CHANGE");
            this.mContext.registerReceiver(this.mWifiConfigReceiver, intentFilter, null, this.mHandler);
            IntentFilter wifiStateFilter = new IntentFilter("android.net.wifi.STATE_CHANGE");
            this.mContext.registerReceiver(this.mWifiStateReceiver, wifiStateFilter, null, this.mHandler);
            return;
        }
        Slog.w(TAG, "bandwidth controls disabled, unable to enforce policy");
    }

    void updateNotificationsLocked() {
        int i;
        ArraySet<String> beforeNotifs = new ArraySet(this.mActiveNotifs);
        this.mActiveNotifs.clear();
        long currentTime = currentTimeMillis();
        for (i = this.mNetworkPolicy.size() - 1; i >= 0; i--) {
            NetworkPolicy policy = (NetworkPolicy) this.mNetworkPolicy.valueAt(i);
            if (isTemplateRelevant(policy.template) && policy.hasCycle()) {
                long start = NetworkPolicyManager.computeLastCycleBoundary(currentTime, policy);
                long totalBytes = getTotalBytes(policy.template, start, currentTime);
                if (!policy.isOverLimit(totalBytes)) {
                    notifyUnderLimitLocked(policy.template);
                    if (policy.isOverWarning(totalBytes) && policy.lastWarningSnooze < start) {
                        enqueueNotification(policy, VERSION_INIT, totalBytes);
                    }
                } else if (policy.lastLimitSnooze >= start) {
                    enqueueNotification(policy, VERSION_ADDED_RESTRICT_BACKGROUND, totalBytes);
                } else {
                    enqueueNotification(policy, VERSION_ADDED_SNOOZE, totalBytes);
                    notifyOverLimitLocked(policy.template);
                }
            }
        }
        if (this.mRestrictBackground) {
            enqueueRestrictedNotification(TAG_ALLOW_BACKGROUND);
        }
        for (i = beforeNotifs.size() - 1; i >= 0; i--) {
            String tag = (String) beforeNotifs.valueAt(i);
            if (!this.mActiveNotifs.contains(tag)) {
                cancelNotification(tag);
            }
        }
    }

    private boolean isTemplateRelevant(NetworkTemplate template) {
        if (!template.isMatchRuleMobile()) {
            return true;
        }
        TelephonyManager tele = TelephonyManager.from(this.mContext);
        int[] arr$ = SubscriptionManager.from(this.mContext).getActiveSubscriptionIdList();
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += VERSION_INIT) {
            if (template.matches(new NetworkIdentity(0, 0, tele.getSubscriberId(arr$[i$]), null, LOGV))) {
                return true;
            }
        }
        return LOGV;
    }

    private void notifyOverLimitLocked(NetworkTemplate template) {
        if (!this.mOverLimitNotified.contains(template)) {
            this.mContext.startActivity(buildNetworkOverLimitIntent(template));
            this.mOverLimitNotified.add(template);
        }
    }

    private void notifyUnderLimitLocked(NetworkTemplate template) {
        this.mOverLimitNotified.remove(template);
    }

    private String buildNotificationTag(NetworkPolicy policy, int type) {
        return "NetworkPolicy:" + policy.template.hashCode() + ":" + type;
    }

    private void enqueueNotification(NetworkPolicy policy, int type, long totalBytes) {
        String tag = buildNotificationTag(policy, type);
        Builder builder = new Builder(this.mContext);
        builder.setOnlyAlertOnce(true);
        builder.setWhen(0);
        builder.setColor(this.mContext.getResources().getColor(17170521));
        Resources res = this.mContext.getResources();
        CharSequence title;
        CharSequence body;
        switch (type) {
            case VERSION_INIT /*1*/:
                title = res.getText(17040823);
                body = res.getString(17040824);
                builder.setSmallIcon(17301624);
                builder.setTicker(title);
                builder.setContentTitle(title);
                builder.setContentText(body);
                builder.setDeleteIntent(PendingIntent.getBroadcast(this.mContext, 0, buildSnoozeWarningIntent(policy.template), 134217728));
                builder.setContentIntent(PendingIntent.getActivity(this.mContext, 0, buildViewDataUsageIntent(policy.template), 134217728));
                break;
            case VERSION_ADDED_SNOOZE /*2*/:
                body = res.getText(17040829);
                int icon = 17303113;
                switch (policy.template.getMatchRule()) {
                    case VERSION_INIT /*1*/:
                        title = res.getText(17040827);
                        break;
                    case VERSION_ADDED_SNOOZE /*2*/:
                        title = res.getText(17040825);
                        break;
                    case VERSION_ADDED_RESTRICT_BACKGROUND /*3*/:
                        title = res.getText(17040826);
                        break;
                    case VERSION_ADDED_METERED /*4*/:
                        title = res.getText(17040828);
                        icon = 17301624;
                        break;
                    default:
                        title = null;
                        break;
                }
                builder.setOngoing(true);
                builder.setSmallIcon(icon);
                builder.setTicker(title);
                builder.setContentTitle(title);
                builder.setContentText(body);
                builder.setContentIntent(PendingIntent.getActivity(this.mContext, 0, buildNetworkOverLimitIntent(policy.template), 134217728));
                break;
            case VERSION_ADDED_RESTRICT_BACKGROUND /*3*/:
                Object[] objArr = new Object[VERSION_INIT];
                objArr[0] = Formatter.formatFileSize(this.mContext, totalBytes - policy.limitBytes);
                body = res.getString(17040834, objArr);
                switch (policy.template.getMatchRule()) {
                    case VERSION_INIT /*1*/:
                        title = res.getText(17040832);
                        break;
                    case VERSION_ADDED_SNOOZE /*2*/:
                        title = res.getText(17040830);
                        break;
                    case VERSION_ADDED_RESTRICT_BACKGROUND /*3*/:
                        title = res.getText(17040831);
                        break;
                    case VERSION_ADDED_METERED /*4*/:
                        title = res.getText(17040833);
                        break;
                    default:
                        title = null;
                        break;
                }
                builder.setOngoing(true);
                builder.setSmallIcon(17301624);
                builder.setTicker(title);
                builder.setContentTitle(title);
                builder.setContentText(body);
                builder.setContentIntent(PendingIntent.getActivity(this.mContext, 0, buildViewDataUsageIntent(policy.template), 134217728));
                break;
        }
        try {
            String packageName = this.mContext.getPackageName();
            String str = packageName;
            this.mNotifManager.enqueueNotificationWithTag(packageName, str, tag, 0, builder.getNotification(), new int[VERSION_INIT], 0);
            this.mActiveNotifs.add(tag);
        } catch (RemoteException e) {
        }
    }

    private void enqueueRestrictedNotification(String tag) {
        Resources res = this.mContext.getResources();
        Builder builder = new Builder(this.mContext);
        CharSequence title = res.getText(17040835);
        CharSequence body = res.getString(17040836);
        builder.setOnlyAlertOnce(true);
        builder.setOngoing(true);
        builder.setSmallIcon(17301624);
        builder.setTicker(title);
        builder.setContentTitle(title);
        builder.setContentText(body);
        builder.setColor(this.mContext.getResources().getColor(17170521));
        builder.setContentIntent(PendingIntent.getBroadcast(this.mContext, 0, buildAllowBackgroundDataIntent(), 134217728));
        try {
            String packageName = this.mContext.getPackageName();
            String str = packageName;
            String str2 = tag;
            this.mNotifManager.enqueueNotificationWithTag(packageName, str, str2, 0, builder.getNotification(), new int[VERSION_INIT], 0);
            this.mActiveNotifs.add(tag);
        } catch (RemoteException e) {
        }
    }

    private void cancelNotification(String tag) {
        try {
            this.mNotifManager.cancelNotificationWithTag(this.mContext.getPackageName(), tag, 0, 0);
        } catch (RemoteException e) {
        }
    }

    void updateNetworkEnabledLocked() {
        long currentTime = currentTimeMillis();
        for (int i = this.mNetworkPolicy.size() - 1; i >= 0; i--) {
            NetworkPolicy policy = (NetworkPolicy) this.mNetworkPolicy.valueAt(i);
            if (policy.limitBytes == -1 || !policy.hasCycle()) {
                setNetworkTemplateEnabled(policy.template, true);
            } else {
                long start = NetworkPolicyManager.computeLastCycleBoundary(currentTime, policy);
                boolean overLimitWithoutSnooze = (!policy.isOverLimit(getTotalBytes(policy.template, start, currentTime)) || policy.lastLimitSnooze >= start) ? LOGV : true;
                setNetworkTemplateEnabled(policy.template, !overLimitWithoutSnooze ? true : LOGV);
            }
        }
    }

    private void setNetworkTemplateEnabled(NetworkTemplate template, boolean enabled) {
    }

    void updateNetworkRulesLocked() {
        try {
            int i;
            NetworkPolicy policy;
            String iface;
            NetworkState[] states = this.mConnManager.getAllNetworkState();
            boolean powerSave = (!this.mRestrictPower || this.mRestrictBackground) ? LOGV : true;
            ArrayList<Pair<String, NetworkIdentity>> connIdents = new ArrayList(states.length);
            ArraySet<String> connIfaces = new ArraySet(states.length);
            NetworkState[] arr$ = states;
            int len$ = arr$.length;
            for (int i2 = 0; i2 < len$; i2 += VERSION_INIT) {
                NetworkState state = arr$[i2];
                if (state.networkInfo.isConnected()) {
                    NetworkIdentity ident = NetworkIdentity.buildNetworkIdentity(this.mContext, state);
                    String baseIface = state.linkProperties.getInterfaceName();
                    if (baseIface != null) {
                        connIdents.add(Pair.create(baseIface, ident));
                        if (powerSave) {
                            connIfaces.add(baseIface);
                        }
                    }
                    for (LinkProperties stackedLink : state.linkProperties.getStackedLinks()) {
                        String stackedIface = stackedLink.getInterfaceName();
                        if (stackedIface != null) {
                            connIdents.add(Pair.create(stackedIface, ident));
                            if (powerSave) {
                                connIfaces.add(stackedIface);
                            }
                        }
                    }
                }
            }
            this.mNetworkRules.clear();
            ArrayList<String> ifaceList = Lists.newArrayList();
            for (i = this.mNetworkPolicy.size() - 1; i >= 0; i--) {
                policy = (NetworkPolicy) this.mNetworkPolicy.valueAt(i);
                ifaceList.clear();
                for (int j = connIdents.size() - 1; j >= 0; j--) {
                    Pair<String, NetworkIdentity> ident2 = (Pair) connIdents.get(j);
                    if (policy.template.matches((NetworkIdentity) ident2.second)) {
                        ifaceList.add(ident2.first);
                    }
                }
                if (ifaceList.size() > 0) {
                    this.mNetworkRules.put(policy, (String[]) ifaceList.toArray(new String[ifaceList.size()]));
                }
            }
            long lowestRule = JobStatus.NO_LATEST_RUNTIME;
            ArraySet<String> arraySet = new ArraySet(states.length);
            long currentTime = currentTimeMillis();
            for (i = this.mNetworkRules.size() - 1; i >= 0; i--) {
                long start;
                long totalBytes;
                policy = (NetworkPolicy) this.mNetworkRules.keyAt(i);
                String[] ifaces = (String[]) this.mNetworkRules.valueAt(i);
                if (policy.hasCycle()) {
                    start = NetworkPolicyManager.computeLastCycleBoundary(currentTime, policy);
                    totalBytes = getTotalBytes(policy.template, start, currentTime);
                } else {
                    start = JobStatus.NO_LATEST_RUNTIME;
                    totalBytes = 0;
                }
                boolean hasWarning = policy.warningBytes != -1 ? true : LOGV;
                boolean hasLimit = policy.limitBytes != -1 ? true : LOGV;
                if (hasLimit || policy.metered) {
                    long quotaBytes;
                    if (!hasLimit) {
                        quotaBytes = JobStatus.NO_LATEST_RUNTIME;
                    } else if (policy.lastLimitSnooze >= start) {
                        quotaBytes = JobStatus.NO_LATEST_RUNTIME;
                    } else {
                        quotaBytes = Math.max(1, policy.limitBytes - totalBytes);
                    }
                    if (ifaces.length > VERSION_INIT) {
                        Slog.w(TAG, "shared quota unsupported; generating rule for each iface");
                    }
                    String[] arr$2 = ifaces;
                    len$ = arr$2.length;
                    for (int i$ = 0; i$ < len$; i$ += VERSION_INIT) {
                        iface = arr$2[i$];
                        removeInterfaceQuota(iface);
                        setInterfaceQuota(iface, quotaBytes);
                        arraySet.add(iface);
                        if (powerSave) {
                            connIfaces.remove(iface);
                        }
                    }
                }
                if (hasWarning && policy.warningBytes < lowestRule) {
                    lowestRule = policy.warningBytes;
                }
                if (hasLimit && policy.limitBytes < lowestRule) {
                    lowestRule = policy.limitBytes;
                }
            }
            for (i = connIfaces.size() - 1; i >= 0; i--) {
                iface = (String) connIfaces.valueAt(i);
                removeInterfaceQuota(iface);
                setInterfaceQuota(iface, JobStatus.NO_LATEST_RUNTIME);
                arraySet.add(iface);
            }
            this.mHandler.obtainMessage(VERSION_ADDED_INFERRED, Long.valueOf(lowestRule)).sendToTarget();
            for (i = this.mMeteredIfaces.size() - 1; i >= 0; i--) {
                iface = (String) this.mMeteredIfaces.valueAt(i);
                if (!arraySet.contains(iface)) {
                    removeInterfaceQuota(iface);
                }
            }
            this.mMeteredIfaces = arraySet;
            this.mHandler.obtainMessage(VERSION_ADDED_SNOOZE, (String[]) this.mMeteredIfaces.toArray(new String[this.mMeteredIfaces.size()])).sendToTarget();
        } catch (RemoteException e) {
        }
    }

    private void ensureActiveMobilePolicyLocked() {
        if (!this.mSuppressDefaultPolicy) {
            TelephonyManager tele = TelephonyManager.from(this.mContext);
            int[] arr$ = SubscriptionManager.from(this.mContext).getActiveSubscriptionIdList();
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += VERSION_INIT) {
                ensureActiveMobilePolicyLocked(tele.getSubscriberId(arr$[i$]));
            }
        }
    }

    private void ensureActiveMobilePolicyLocked(String subscriberId) {
        NetworkIdentity probeIdent = new NetworkIdentity(0, 0, subscriberId, null, LOGV);
        int i = this.mNetworkPolicy.size() - 1;
        while (i >= 0) {
            if (!((NetworkTemplate) this.mNetworkPolicy.keyAt(i)).matches(probeIdent)) {
                i--;
            } else {
                return;
            }
        }
        Slog.i(TAG, "No policy for subscriber " + NetworkIdentity.scrubSubscriberId(subscriberId) + "; generating default policy");
        long warningBytes = ((long) this.mContext.getResources().getInteger(17694832)) * 1048576;
        Time time = new Time();
        time.setToNow();
        addNetworkPolicyLocked(new NetworkPolicy(NetworkTemplate.buildTemplateMobileAll(subscriberId), time.monthDay, time.timezone, warningBytes, -1, -1, -1, true, true));
    }

    private void readPolicyLocked() {
        this.mNetworkPolicy.clear();
        this.mUidPolicy.clear();
        FileInputStream fis = null;
        try {
            fis = this.mPolicyFile.openRead();
            XmlPullParser in = Xml.newPullParser();
            in.setInput(fis, StandardCharsets.UTF_8.name());
            int version = VERSION_INIT;
            while (true) {
                int type = in.next();
                if (type != VERSION_INIT) {
                    String tag = in.getName();
                    if (type == VERSION_ADDED_SNOOZE) {
                        if (TAG_POLICY_LIST.equals(tag)) {
                            version = XmlUtils.readIntAttribute(in, ATTR_VERSION);
                            if (version >= VERSION_ADDED_RESTRICT_BACKGROUND) {
                                this.mRestrictBackground = XmlUtils.readBooleanAttribute(in, ATTR_RESTRICT_BACKGROUND);
                            } else {
                                this.mRestrictBackground = LOGV;
                            }
                        } else if (TAG_NETWORK_POLICY.equals(tag)) {
                            String networkId;
                            String cycleTimezone;
                            long lastLimitSnooze;
                            boolean metered;
                            long lastWarningSnooze;
                            boolean inferred;
                            int networkTemplate = XmlUtils.readIntAttribute(in, ATTR_NETWORK_TEMPLATE);
                            String subscriberId = in.getAttributeValue(null, ATTR_SUBSCRIBER_ID);
                            if (version >= VERSION_ADDED_NETWORK_ID) {
                                networkId = in.getAttributeValue(null, ATTR_NETWORK_ID);
                            } else {
                                networkId = null;
                            }
                            int cycleDay = XmlUtils.readIntAttribute(in, ATTR_CYCLE_DAY);
                            if (version >= VERSION_ADDED_TIMEZONE) {
                                cycleTimezone = in.getAttributeValue(null, ATTR_CYCLE_TIMEZONE);
                            } else {
                                cycleTimezone = "UTC";
                            }
                            long warningBytes = XmlUtils.readLongAttribute(in, ATTR_WARNING_BYTES);
                            long limitBytes = XmlUtils.readLongAttribute(in, ATTR_LIMIT_BYTES);
                            if (version >= VERSION_SPLIT_SNOOZE) {
                                lastLimitSnooze = XmlUtils.readLongAttribute(in, ATTR_LAST_LIMIT_SNOOZE);
                            } else if (version >= VERSION_ADDED_SNOOZE) {
                                lastLimitSnooze = XmlUtils.readLongAttribute(in, ATTR_LAST_SNOOZE);
                            } else {
                                lastLimitSnooze = -1;
                            }
                            if (version < VERSION_ADDED_METERED) {
                                switch (networkTemplate) {
                                    case VERSION_INIT /*1*/:
                                    case VERSION_ADDED_SNOOZE /*2*/:
                                    case VERSION_ADDED_RESTRICT_BACKGROUND /*3*/:
                                        metered = true;
                                        break;
                                    default:
                                        metered = LOGV;
                                        break;
                                }
                            }
                            metered = XmlUtils.readBooleanAttribute(in, ATTR_METERED);
                            if (version >= VERSION_SPLIT_SNOOZE) {
                                lastWarningSnooze = XmlUtils.readLongAttribute(in, ATTR_LAST_WARNING_SNOOZE);
                            } else {
                                lastWarningSnooze = -1;
                            }
                            if (version >= VERSION_ADDED_INFERRED) {
                                inferred = XmlUtils.readBooleanAttribute(in, ATTR_INFERRED);
                            } else {
                                inferred = LOGV;
                            }
                            NetworkTemplate template = new NetworkTemplate(networkTemplate, subscriberId, networkId);
                            ArrayMap arrayMap = this.mNetworkPolicy;
                            r30.put(template, new NetworkPolicy(template, cycleDay, cycleTimezone, warningBytes, limitBytes, lastWarningSnooze, lastLimitSnooze, metered, inferred));
                        } else if (TAG_UID_POLICY.equals(tag)) {
                            uid = XmlUtils.readIntAttribute(in, ATTR_UID);
                            policy = XmlUtils.readIntAttribute(in, ATTR_POLICY);
                            if (UserHandle.isApp(uid)) {
                                setUidPolicyUncheckedLocked(uid, policy, LOGV);
                            } else {
                                Slog.w(TAG, "unable to apply policy to UID " + uid + "; ignoring");
                            }
                        } else if (TAG_APP_POLICY.equals(tag)) {
                            int appId = XmlUtils.readIntAttribute(in, ATTR_APP_ID);
                            policy = XmlUtils.readIntAttribute(in, ATTR_POLICY);
                            uid = UserHandle.getUid(0, appId);
                            if (UserHandle.isApp(uid)) {
                                setUidPolicyUncheckedLocked(uid, policy, LOGV);
                            } else {
                                Slog.w(TAG, "unable to apply policy to UID " + uid + "; ignoring");
                            }
                        }
                    }
                } else {
                    return;
                }
            }
        } catch (FileNotFoundException e) {
            upgradeLegacyBackgroundData();
        } catch (Throwable e2) {
            Log.wtf(TAG, "problem reading network policy", e2);
        } catch (Throwable e22) {
            Log.wtf(TAG, "problem reading network policy", e22);
        } finally {
            IoUtils.closeQuietly(fis);
        }
    }

    private void upgradeLegacyBackgroundData() {
        boolean z = true;
        if (Secure.getInt(this.mContext.getContentResolver(), "background_data", VERSION_INIT) == VERSION_INIT) {
            z = LOGV;
        }
        this.mRestrictBackground = z;
        if (this.mRestrictBackground) {
            this.mContext.sendBroadcastAsUser(new Intent("android.net.conn.BACKGROUND_DATA_SETTING_CHANGED"), UserHandle.ALL);
        }
    }

    void writePolicyLocked() {
        FileOutputStream fos = null;
        try {
            int i;
            fos = this.mPolicyFile.startWrite();
            XmlSerializer out = new FastXmlSerializer();
            out.setOutput(fos, StandardCharsets.UTF_8.name());
            out.startDocument(null, Boolean.valueOf(true));
            out.startTag(null, TAG_POLICY_LIST);
            XmlUtils.writeIntAttribute(out, ATTR_VERSION, VERSION_SWITCH_UID);
            XmlUtils.writeBooleanAttribute(out, ATTR_RESTRICT_BACKGROUND, this.mRestrictBackground);
            for (i = 0; i < this.mNetworkPolicy.size(); i += VERSION_INIT) {
                NetworkPolicy policy = (NetworkPolicy) this.mNetworkPolicy.valueAt(i);
                NetworkTemplate template = policy.template;
                out.startTag(null, TAG_NETWORK_POLICY);
                XmlUtils.writeIntAttribute(out, ATTR_NETWORK_TEMPLATE, template.getMatchRule());
                String subscriberId = template.getSubscriberId();
                if (subscriberId != null) {
                    out.attribute(null, ATTR_SUBSCRIBER_ID, subscriberId);
                }
                String networkId = template.getNetworkId();
                if (networkId != null) {
                    out.attribute(null, ATTR_NETWORK_ID, networkId);
                }
                XmlUtils.writeIntAttribute(out, ATTR_CYCLE_DAY, policy.cycleDay);
                out.attribute(null, ATTR_CYCLE_TIMEZONE, policy.cycleTimezone);
                XmlUtils.writeLongAttribute(out, ATTR_WARNING_BYTES, policy.warningBytes);
                XmlUtils.writeLongAttribute(out, ATTR_LIMIT_BYTES, policy.limitBytes);
                XmlUtils.writeLongAttribute(out, ATTR_LAST_WARNING_SNOOZE, policy.lastWarningSnooze);
                XmlUtils.writeLongAttribute(out, ATTR_LAST_LIMIT_SNOOZE, policy.lastLimitSnooze);
                XmlUtils.writeBooleanAttribute(out, ATTR_METERED, policy.metered);
                XmlUtils.writeBooleanAttribute(out, ATTR_INFERRED, policy.inferred);
                out.endTag(null, TAG_NETWORK_POLICY);
            }
            for (i = 0; i < this.mUidPolicy.size(); i += VERSION_INIT) {
                int uid = this.mUidPolicy.keyAt(i);
                int policy2 = this.mUidPolicy.valueAt(i);
                if (policy2 != 0) {
                    out.startTag(null, TAG_UID_POLICY);
                    XmlUtils.writeIntAttribute(out, ATTR_UID, uid);
                    XmlUtils.writeIntAttribute(out, ATTR_POLICY, policy2);
                    out.endTag(null, TAG_UID_POLICY);
                }
            }
            out.endTag(null, TAG_POLICY_LIST);
            out.endDocument();
            this.mPolicyFile.finishWrite(fos);
        } catch (IOException e) {
            if (fos != null) {
                this.mPolicyFile.failWrite(fos);
            }
        }
    }

    public void setUidPolicy(int uid, int policy) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        if (UserHandle.isApp(uid)) {
            synchronized (this.mRulesLock) {
                if (this.mUidPolicy.get(uid, 0) != policy) {
                    setUidPolicyUncheckedLocked(uid, policy, true);
                }
            }
            return;
        }
        throw new IllegalArgumentException("cannot apply policy to UID " + uid);
    }

    public void addUidPolicy(int uid, int policy) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        if (UserHandle.isApp(uid)) {
            synchronized (this.mRulesLock) {
                int oldPolicy = this.mUidPolicy.get(uid, 0);
                policy |= oldPolicy;
                if (oldPolicy != policy) {
                    setUidPolicyUncheckedLocked(uid, policy, true);
                }
            }
            return;
        }
        throw new IllegalArgumentException("cannot apply policy to UID " + uid);
    }

    public void removeUidPolicy(int uid, int policy) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        if (UserHandle.isApp(uid)) {
            synchronized (this.mRulesLock) {
                int oldPolicy = this.mUidPolicy.get(uid, 0);
                policy = oldPolicy & (policy ^ -1);
                if (oldPolicy != policy) {
                    setUidPolicyUncheckedLocked(uid, policy, true);
                }
            }
            return;
        }
        throw new IllegalArgumentException("cannot apply policy to UID " + uid);
    }

    private void setUidPolicyUncheckedLocked(int uid, int policy, boolean persist) {
        this.mUidPolicy.put(uid, policy);
        updateRulesForUidLocked(uid);
        if (persist) {
            writePolicyLocked();
        }
    }

    public int getUidPolicy(int uid) {
        int i;
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        synchronized (this.mRulesLock) {
            i = this.mUidPolicy.get(uid, 0);
        }
        return i;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public int[] getUidsWithPolicy(int r8) {
        /*
        r7 = this;
        r4 = r7.mContext;
        r5 = "android.permission.MANAGE_NETWORK_POLICY";
        r6 = "NetworkPolicy";
        r4.enforceCallingOrSelfPermission(r5, r6);
        r4 = 0;
        r3 = new int[r4];
        r5 = r7.mRulesLock;
        monitor-enter(r5);
        r0 = 0;
    L_0x0010:
        r4 = r7.mUidPolicy;	 Catch:{ all -> 0x002f }
        r4 = r4.size();	 Catch:{ all -> 0x002f }
        if (r0 >= r4) goto L_0x002d;
    L_0x0018:
        r4 = r7.mUidPolicy;	 Catch:{ all -> 0x002f }
        r1 = r4.keyAt(r0);	 Catch:{ all -> 0x002f }
        r4 = r7.mUidPolicy;	 Catch:{ all -> 0x002f }
        r2 = r4.valueAt(r0);	 Catch:{ all -> 0x002f }
        if (r2 != r8) goto L_0x002a;
    L_0x0026:
        r3 = com.android.internal.util.ArrayUtils.appendInt(r3, r1);	 Catch:{ all -> 0x002f }
    L_0x002a:
        r0 = r0 + 1;
        goto L_0x0010;
    L_0x002d:
        monitor-exit(r5);	 Catch:{ all -> 0x002f }
        return r3;
    L_0x002f:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x002f }
        throw r4;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.net.NetworkPolicyManagerService.getUidsWithPolicy(int):int[]");
    }

    public int[] getPowerSaveAppIdWhitelist() {
        int[] appids;
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        synchronized (this.mRulesLock) {
            int size = this.mPowerSaveWhitelistAppIds.size();
            appids = new int[size];
            for (int i = 0; i < size; i += VERSION_INIT) {
                appids[i] = this.mPowerSaveWhitelistAppIds.keyAt(i);
            }
        }
        return appids;
    }

    void removePoliciesForUserLocked(int userId) {
        int[] uids = new int[0];
        for (int i = 0; i < this.mUidPolicy.size(); i += VERSION_INIT) {
            int uid = this.mUidPolicy.keyAt(i);
            if (UserHandle.getUserId(uid) == userId) {
                uids = ArrayUtils.appendInt(uids, uid);
            }
        }
        if (uids.length > 0) {
            int[] arr$ = uids;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += VERSION_INIT) {
                uid = arr$[i$];
                this.mUidPolicy.delete(uid);
                updateRulesForUidLocked(uid);
            }
            writePolicyLocked();
        }
    }

    public void registerListener(INetworkPolicyListener listener) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        this.mListeners.register(listener);
    }

    public void unregisterListener(INetworkPolicyListener listener) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
        this.mListeners.unregister(listener);
    }

    public void setNetworkPolicies(NetworkPolicy[] policies) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        maybeRefreshTrustedTime();
        synchronized (this.mRulesLock) {
            normalizePoliciesLocked(policies);
            updateNetworkEnabledLocked();
            updateNetworkRulesLocked();
            updateNotificationsLocked();
            writePolicyLocked();
        }
    }

    void addNetworkPolicyLocked(NetworkPolicy policy) {
        setNetworkPolicies((NetworkPolicy[]) ArrayUtils.appendElement(NetworkPolicy.class, getNetworkPolicies(), policy));
    }

    public NetworkPolicy[] getNetworkPolicies() {
        NetworkPolicy[] policies;
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        this.mContext.enforceCallingOrSelfPermission("android.permission.READ_PHONE_STATE", TAG);
        synchronized (this.mRulesLock) {
            int size = this.mNetworkPolicy.size();
            policies = new NetworkPolicy[size];
            for (int i = 0; i < size; i += VERSION_INIT) {
                policies[i] = (NetworkPolicy) this.mNetworkPolicy.valueAt(i);
            }
        }
        return policies;
    }

    private void normalizePoliciesLocked() {
        normalizePoliciesLocked(getNetworkPolicies());
    }

    private void normalizePoliciesLocked(NetworkPolicy[] policies) {
        String[] merged = TelephonyManager.from(this.mContext).getMergedSubscriberIds();
        this.mNetworkPolicy.clear();
        NetworkPolicy[] arr$ = policies;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += VERSION_INIT) {
            NetworkPolicy policy = arr$[i$];
            policy.template = NetworkTemplate.normalize(policy.template, merged);
            NetworkPolicy existing = (NetworkPolicy) this.mNetworkPolicy.get(policy.template);
            if (existing == null || existing.compareTo(policy) > 0) {
                if (existing != null) {
                    Slog.d(TAG, "Normalization replaced " + existing + " with " + policy);
                }
                this.mNetworkPolicy.put(policy.template, policy);
            }
        }
    }

    public void snoozeLimit(NetworkTemplate template) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        long token = Binder.clearCallingIdentity();
        try {
            performSnooze(template, VERSION_ADDED_SNOOZE);
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void performSnooze(android.net.NetworkTemplate r8, int r9) {
        /*
        r7 = this;
        r7.maybeRefreshTrustedTime();
        r0 = r7.currentTimeMillis();
        r4 = r7.mRulesLock;
        monitor-enter(r4);
        r3 = r7.mNetworkPolicy;	 Catch:{ all -> 0x002d }
        r2 = r3.get(r8);	 Catch:{ all -> 0x002d }
        r2 = (android.net.NetworkPolicy) r2;	 Catch:{ all -> 0x002d }
        if (r2 != 0) goto L_0x0030;
    L_0x0014:
        r3 = new java.lang.IllegalArgumentException;	 Catch:{ all -> 0x002d }
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x002d }
        r5.<init>();	 Catch:{ all -> 0x002d }
        r6 = "unable to find policy for ";
        r5 = r5.append(r6);	 Catch:{ all -> 0x002d }
        r5 = r5.append(r8);	 Catch:{ all -> 0x002d }
        r5 = r5.toString();	 Catch:{ all -> 0x002d }
        r3.<init>(r5);	 Catch:{ all -> 0x002d }
        throw r3;	 Catch:{ all -> 0x002d }
    L_0x002d:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x002d }
        throw r3;
    L_0x0030:
        switch(r9) {
            case 1: goto L_0x003b;
            case 2: goto L_0x004e;
            default: goto L_0x0033;
        };
    L_0x0033:
        r3 = new java.lang.IllegalArgumentException;	 Catch:{ all -> 0x002d }
        r5 = "unexpected type";
        r3.<init>(r5);	 Catch:{ all -> 0x002d }
        throw r3;	 Catch:{ all -> 0x002d }
    L_0x003b:
        r2.lastWarningSnooze = r0;	 Catch:{ all -> 0x002d }
    L_0x003d:
        r7.normalizePoliciesLocked();	 Catch:{ all -> 0x002d }
        r7.updateNetworkEnabledLocked();	 Catch:{ all -> 0x002d }
        r7.updateNetworkRulesLocked();	 Catch:{ all -> 0x002d }
        r7.updateNotificationsLocked();	 Catch:{ all -> 0x002d }
        r7.writePolicyLocked();	 Catch:{ all -> 0x002d }
        monitor-exit(r4);	 Catch:{ all -> 0x002d }
        return;
    L_0x004e:
        r2.lastLimitSnooze = r0;	 Catch:{ all -> 0x002d }
        goto L_0x003d;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.net.NetworkPolicyManagerService.performSnooze(android.net.NetworkTemplate, int):void");
    }

    public void setRestrictBackground(boolean restrictBackground) {
        int i;
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        maybeRefreshTrustedTime();
        synchronized (this.mRulesLock) {
            this.mRestrictBackground = restrictBackground;
            updateRulesForGlobalChangeLocked(LOGV);
            updateNotificationsLocked();
            writePolicyLocked();
        }
        Handler handler = this.mHandler;
        if (restrictBackground) {
            i = VERSION_INIT;
        } else {
            i = 0;
        }
        handler.obtainMessage(VERSION_ADDED_TIMEZONE, i, 0).sendToTarget();
    }

    public boolean getRestrictBackground() {
        boolean z;
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        synchronized (this.mRulesLock) {
            z = this.mRestrictBackground;
        }
        return z;
    }

    private NetworkPolicy findPolicyForNetworkLocked(NetworkIdentity ident) {
        for (int i = this.mNetworkPolicy.size() - 1; i >= 0; i--) {
            NetworkPolicy policy = (NetworkPolicy) this.mNetworkPolicy.valueAt(i);
            if (policy.template.matches(ident)) {
                return policy;
            }
        }
        return null;
    }

    public NetworkQuotaInfo getNetworkQuotaInfo(NetworkState state) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.ACCESS_NETWORK_STATE", TAG);
        long token = Binder.clearCallingIdentity();
        try {
            NetworkQuotaInfo networkQuotaInfoUnchecked = getNetworkQuotaInfoUnchecked(state);
            return networkQuotaInfoUnchecked;
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    private NetworkQuotaInfo getNetworkQuotaInfoUnchecked(NetworkState state) {
        NetworkIdentity ident = NetworkIdentity.buildNetworkIdentity(this.mContext, state);
        synchronized (this.mRulesLock) {
            NetworkPolicy policy = findPolicyForNetworkLocked(ident);
        }
        if (policy == null || !policy.hasCycle()) {
            return null;
        }
        long currentTime = currentTimeMillis();
        return new NetworkQuotaInfo(getTotalBytes(policy.template, NetworkPolicyManager.computeLastCycleBoundary(currentTime, policy), currentTime), policy.warningBytes != -1 ? policy.warningBytes : -1, policy.limitBytes != -1 ? policy.limitBytes : -1);
    }

    public boolean isNetworkMetered(NetworkState state) {
        NetworkIdentity ident = NetworkIdentity.buildNetworkIdentity(this.mContext, state);
        if (ident.getRoaming()) {
            return true;
        }
        synchronized (this.mRulesLock) {
            NetworkPolicy policy = findPolicyForNetworkLocked(ident);
        }
        if (policy != null) {
            return policy.metered;
        }
        int type = state.networkInfo.getType();
        if (ConnectivityManager.isNetworkTypeMobile(type) || type == VERSION_ADDED_TIMEZONE) {
            return true;
        }
        return LOGV;
    }

    protected void dump(FileDescriptor fd, PrintWriter writer, String[] args) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DUMP", TAG);
        IndentingPrintWriter fout = new IndentingPrintWriter(writer, "  ");
        ArraySet<String> argSet = new ArraySet(args.length);
        String[] arr$ = args;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += VERSION_INIT) {
            argSet.add(arr$[i$]);
        }
        synchronized (this.mRulesLock) {
            int i;
            if (argSet.contains("--unsnooze")) {
                for (i = this.mNetworkPolicy.size() - 1; i >= 0; i--) {
                    ((NetworkPolicy) this.mNetworkPolicy.valueAt(i)).clearSnooze();
                }
                normalizePoliciesLocked();
                updateNetworkEnabledLocked();
                updateNetworkRulesLocked();
                updateNotificationsLocked();
                writePolicyLocked();
                fout.println("Cleared snooze timestamps");
                return;
            }
            fout.print("Restrict background: ");
            fout.println(this.mRestrictBackground);
            fout.print("Restrict power: ");
            fout.println(this.mRestrictPower);
            fout.print("Current foreground state: ");
            fout.println(this.mCurForegroundState);
            fout.println("Network policies:");
            fout.increaseIndent();
            for (i = 0; i < this.mNetworkPolicy.size(); i += VERSION_INIT) {
                fout.println(((NetworkPolicy) this.mNetworkPolicy.valueAt(i)).toString());
            }
            fout.decreaseIndent();
            fout.print("Metered ifaces: ");
            fout.println(String.valueOf(this.mMeteredIfaces));
            fout.println("Policy for UIDs:");
            fout.increaseIndent();
            int size = this.mUidPolicy.size();
            for (i = 0; i < size; i += VERSION_INIT) {
                int uid = this.mUidPolicy.keyAt(i);
                int policy = this.mUidPolicy.valueAt(i);
                fout.print("UID=");
                fout.print(uid);
                fout.print(" policy=");
                NetworkPolicyManager.dumpPolicy(fout, policy);
                fout.println();
            }
            fout.decreaseIndent();
            size = this.mPowerSaveWhitelistAppIds.size();
            if (size > 0) {
                fout.println("Power save whitelist app ids:");
                fout.increaseIndent();
                for (i = 0; i < size; i += VERSION_INIT) {
                    fout.print("UID=");
                    fout.print(this.mPowerSaveWhitelistAppIds.keyAt(i));
                    fout.print(": ");
                    fout.print(this.mPowerSaveWhitelistAppIds.valueAt(i));
                    fout.println();
                }
                fout.decreaseIndent();
            }
            SparseBooleanArray knownUids = new SparseBooleanArray();
            collectKeys(this.mUidState, knownUids);
            collectKeys(this.mUidRules, knownUids);
            fout.println("Status for known UIDs:");
            fout.increaseIndent();
            size = knownUids.size();
            for (i = 0; i < size; i += VERSION_INIT) {
                uid = knownUids.keyAt(i);
                fout.print("UID=");
                fout.print(uid);
                int state = this.mUidState.get(uid, 13);
                fout.print(" state=");
                fout.print(state);
                fout.print(state <= this.mCurForegroundState ? " (fg)" : " (bg)");
                fout.print(" pids=");
                int foregroundIndex = this.mUidPidState.indexOfKey(uid);
                if (foregroundIndex < 0) {
                    fout.print("UNKNOWN");
                } else {
                    dumpSparseIntArray(fout, (SparseIntArray) this.mUidPidState.valueAt(foregroundIndex));
                }
                fout.print(" rules=");
                int rulesIndex = this.mUidRules.indexOfKey(uid);
                if (rulesIndex < 0) {
                    fout.print("UNKNOWN");
                } else {
                    NetworkPolicyManager.dumpRules(fout, this.mUidRules.valueAt(rulesIndex));
                }
                fout.println();
            }
            fout.decreaseIndent();
        }
    }

    public boolean isUidForeground(int uid) {
        boolean isUidForegroundLocked;
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_NETWORK_POLICY", TAG);
        synchronized (this.mRulesLock) {
            isUidForegroundLocked = isUidForegroundLocked(uid);
        }
        return isUidForegroundLocked;
    }

    boolean isUidForegroundLocked(int uid) {
        return (!this.mScreenOn || this.mUidState.get(uid, 13) > this.mCurForegroundState) ? LOGV : true;
    }

    void computeUidStateLocked(int uid) {
        SparseIntArray pidState = (SparseIntArray) this.mUidPidState.get(uid);
        int uidState = 13;
        if (pidState != null) {
            int size = pidState.size();
            for (int i = 0; i < size; i += VERSION_INIT) {
                int state = pidState.valueAt(i);
                if (state < uidState) {
                    uidState = state;
                }
            }
        }
        int oldUidState = this.mUidState.get(uid, 13);
        if (oldUidState != uidState) {
            boolean newForeground;
            this.mUidState.put(uid, uidState);
            boolean oldForeground = oldUidState <= this.mCurForegroundState ? true : LOGV;
            if (uidState <= this.mCurForegroundState) {
                newForeground = true;
            } else {
                newForeground = LOGV;
            }
            if (oldForeground != newForeground) {
                updateRulesForUidLocked(uid);
            }
        }
    }

    private void updateScreenOn() {
        synchronized (this.mRulesLock) {
            try {
                this.mScreenOn = this.mPowerManager.isInteractive();
            } catch (RemoteException e) {
            }
            updateRulesForScreenLocked();
        }
    }

    private void updateRulesForScreenLocked() {
        int size = this.mUidState.size();
        for (int i = 0; i < size; i += VERSION_INIT) {
            if (this.mUidState.valueAt(i) <= this.mCurForegroundState) {
                updateRulesForUidLocked(this.mUidState.keyAt(i));
            }
        }
    }

    void updateRulesForGlobalChangeLocked(boolean restrictedNetworksChanged) {
        PackageManager pm = this.mContext.getPackageManager();
        UserManager um = (UserManager) this.mContext.getSystemService("user");
        int i = (this.mRestrictBackground || !this.mRestrictPower) ? VERSION_ADDED_SNOOZE : VERSION_ADDED_RESTRICT_BACKGROUND;
        this.mCurForegroundState = i;
        List<UserInfo> users = um.getUsers();
        List<ApplicationInfo> apps = pm.getInstalledApplications(8704);
        for (UserInfo user : users) {
            for (ApplicationInfo app : apps) {
                updateRulesForUidLocked(UserHandle.getUid(user.id, app.uid));
            }
        }
        updateRulesForUidLocked(1013);
        updateRulesForUidLocked(1019);
        if (restrictedNetworksChanged) {
            normalizePoliciesLocked();
            updateNetworkRulesLocked();
        }
    }

    private static boolean isUidValidForRules(int uid) {
        if (uid == 1013 || uid == 1019 || UserHandle.isApp(uid)) {
            return true;
        }
        return LOGV;
    }

    void updateRulesForUidLocked(int uid) {
        boolean rejectMetered = LOGV;
        if (isUidValidForRules(uid)) {
            int uidPolicy = this.mUidPolicy.get(uid, 0);
            boolean uidForeground = isUidForegroundLocked(uid);
            int uidRules = 0;
            if (!uidForeground && (uidPolicy & VERSION_INIT) != 0) {
                uidRules = VERSION_INIT;
            } else if (this.mRestrictBackground) {
                if (!uidForeground) {
                    uidRules = VERSION_INIT;
                }
            } else if (this.mRestrictPower && !this.mPowerSaveWhitelistAppIds.get(UserHandle.getAppId(uid)) && !uidForeground && (uidPolicy & VERSION_ADDED_SNOOZE) == 0) {
                uidRules = VERSION_INIT;
            }
            if (uidRules == 0) {
                this.mUidRules.delete(uid);
            } else {
                this.mUidRules.put(uid, uidRules);
            }
            if ((uidRules & VERSION_INIT) != 0) {
                rejectMetered = true;
            }
            setUidNetworkRules(uid, rejectMetered);
            this.mHandler.obtainMessage(VERSION_INIT, uid, uidRules).sendToTarget();
            try {
                this.mNetworkStats.setUidForeground(uid, uidForeground);
            } catch (RemoteException e) {
            }
        }
    }

    private void setInterfaceQuota(String iface, long quotaBytes) {
        try {
            this.mNetworkManager.setInterfaceQuota(iface, quotaBytes);
        } catch (IllegalStateException e) {
            Log.wtf(TAG, "problem setting interface quota", e);
        } catch (RemoteException e2) {
        }
    }

    private void removeInterfaceQuota(String iface) {
        try {
            this.mNetworkManager.removeInterfaceQuota(iface);
        } catch (IllegalStateException e) {
            Log.wtf(TAG, "problem removing interface quota", e);
        } catch (RemoteException e2) {
        }
    }

    private void setUidNetworkRules(int uid, boolean rejectOnQuotaInterfaces) {
        try {
            this.mNetworkManager.setUidNetworkRules(uid, rejectOnQuotaInterfaces);
        } catch (IllegalStateException e) {
            Log.wtf(TAG, "problem setting uid rules", e);
        } catch (RemoteException e2) {
        }
    }

    private long getTotalBytes(NetworkTemplate template, long start, long end) {
        try {
            return this.mNetworkStats.getNetworkTotalBytes(template, start, end);
        } catch (RuntimeException e) {
            Slog.w(TAG, "problem reading network stats: " + e);
            return 0;
        } catch (RemoteException e2) {
            return 0;
        }
    }

    private boolean isBandwidthControlEnabled() {
        boolean isBandwidthControlEnabled;
        long token = Binder.clearCallingIdentity();
        try {
            isBandwidthControlEnabled = this.mNetworkManager.isBandwidthControlEnabled();
        } catch (RemoteException e) {
            isBandwidthControlEnabled = LOGV;
        } finally {
            Binder.restoreCallingIdentity(token);
        }
        return isBandwidthControlEnabled;
    }

    void maybeRefreshTrustedTime() {
        if (this.mTime.getCacheAge() > TIME_CACHE_MAX_AGE) {
            this.mTime.forceRefresh();
        }
    }

    private long currentTimeMillis() {
        return this.mTime.hasCache() ? this.mTime.currentTimeMillis() : System.currentTimeMillis();
    }

    private static Intent buildAllowBackgroundDataIntent() {
        return new Intent(ACTION_ALLOW_BACKGROUND);
    }

    private static Intent buildSnoozeWarningIntent(NetworkTemplate template) {
        Intent intent = new Intent(ACTION_SNOOZE_WARNING);
        intent.putExtra("android.net.NETWORK_TEMPLATE", template);
        return intent;
    }

    private static Intent buildNetworkOverLimitIntent(NetworkTemplate template) {
        Intent intent = new Intent();
        intent.setComponent(new ComponentName("com.android.systemui", "com.android.systemui.net.NetworkOverLimitActivity"));
        intent.addFlags(268435456);
        intent.putExtra("android.net.NETWORK_TEMPLATE", template);
        return intent;
    }

    private static Intent buildViewDataUsageIntent(NetworkTemplate template) {
        Intent intent = new Intent();
        intent.setComponent(new ComponentName("com.android.settings", "com.android.settings.Settings$DataUsageSummaryActivity"));
        intent.addFlags(268435456);
        intent.putExtra("android.net.NETWORK_TEMPLATE", template);
        return intent;
    }

    public void addIdleHandler(IdleHandler handler) {
        this.mHandler.getLooper().getQueue().addIdleHandler(handler);
    }

    private static void collectKeys(SparseIntArray source, SparseBooleanArray target) {
        int size = source.size();
        for (int i = 0; i < size; i += VERSION_INIT) {
            target.put(source.keyAt(i), true);
        }
    }

    private static void dumpSparseIntArray(PrintWriter fout, SparseIntArray value) {
        fout.print("[");
        int size = value.size();
        for (int i = 0; i < size; i += VERSION_INIT) {
            fout.print(value.keyAt(i) + "=" + value.valueAt(i));
            if (i < size - 1) {
                fout.print(",");
            }
        }
        fout.print("]");
    }
}
