package com.android.server;

import android.app.AlarmManager;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.app.PendingIntent.OnFinished;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.database.ContentObserver;
import android.net.ConnectivityManager;
import android.net.IConnectivityManager.Stub;
import android.net.INetworkManagementEventObserver;
import android.net.INetworkPolicyListener;
import android.net.INetworkPolicyManager;
import android.net.INetworkStatsService;
import android.net.LinkProperties;
import android.net.LinkProperties.CompareResult;
import android.net.MobileDataStateTracker;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.NetworkConfig;
import android.net.NetworkInfo;
import android.net.NetworkInfo.DetailedState;
import android.net.NetworkInfo.State;
import android.net.NetworkMisc;
import android.net.NetworkQuotaInfo;
import android.net.NetworkRequest;
import android.net.NetworkState;
import android.net.NetworkStateTracker;
import android.net.NetworkUtils;
import android.net.ProxyInfo;
import android.net.RouteInfo;
import android.net.SamplingDataTracker;
import android.net.SamplingDataTracker.SamplingSnapshot;
import android.net.UidRange;
import android.net.Uri;
import android.net.wifi.WifiDevice;
import android.os.Binder;
import android.os.Bundle;
import android.os.FileUtils;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.INetworkManagementService;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.os.ParcelFileDescriptor;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.os.UserManager;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.security.KeyStore;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.util.Xml;
import com.android.internal.annotations.GuardedBy;
import com.android.internal.app.IBatteryStats;
import com.android.internal.net.LegacyVpnInfo;
import com.android.internal.net.NetworkStatsFactory;
import com.android.internal.net.VpnConfig;
import com.android.internal.net.VpnProfile;
import com.android.internal.util.AsyncChannel;
import com.android.internal.util.IndentingPrintWriter;
import com.android.internal.util.XmlUtils;
import com.android.server.am.BatteryStatsService;
import com.android.server.connectivity.DataConnectionStats;
import com.android.server.connectivity.Nat464Xlat;
import com.android.server.connectivity.NetworkAgentInfo;
import com.android.server.connectivity.NetworkMonitor;
import com.android.server.connectivity.PacManager;
import com.android.server.connectivity.PermissionMonitor;
import com.android.server.connectivity.Tethering;
import com.android.server.connectivity.Vpn;
import com.android.server.net.BaseNetworkObserver;
import com.android.server.net.LockdownVpnTracker;
import com.android.server.wm.WindowManagerService.C0569H;
import com.google.android.collect.Lists;
import com.google.android.collect.Sets;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicInteger;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

public class ConnectivityService extends Stub implements OnFinished {
    private static final String ACTION_PKT_CNT_SAMPLE_INTERVAL_ELAPSED = "android.net.ConnectivityService.action.PKT_CNT_SAMPLE_INTERVAL_ELAPSED";
    private static final String ATTR_MCC = "mcc";
    private static final String ATTR_MNC = "mnc";
    private static final boolean DBG = true;
    private static final int DEFAULT_FAIL_FAST_TIME_MS = 60000;
    private static final int DEFAULT_SAMPLING_INTERVAL_IN_SECONDS = 720;
    private static final int DEFAULT_START_SAMPLING_INTERVAL_IN_SECONDS = 60;
    private static final String DEFAULT_TCP_BUFFER_SIZES = "4096,87380,110208,4096,16384,110208";
    private static final int DISABLED = 0;
    private static final int ENABLED = 1;
    private static final int EVENT_APPLY_GLOBAL_HTTP_PROXY = 9;
    private static final int EVENT_CHANGE_MOBILE_DATA_ENABLED = 2;
    private static final int EVENT_CLEAR_NET_TRANSITION_WAKELOCK = 8;
    private static final int EVENT_ENABLE_FAIL_FAST_MOBILE_DATA = 14;
    private static final int EVENT_EXPIRE_NET_TRANSITION_WAKELOCK = 24;
    private static final int EVENT_PROXY_HAS_CHANGED = 16;
    private static final int EVENT_REGISTER_NETWORK_AGENT = 18;
    private static final int EVENT_REGISTER_NETWORK_FACTORY = 17;
    private static final int EVENT_REGISTER_NETWORK_LISTENER = 21;
    private static final int EVENT_REGISTER_NETWORK_REQUEST = 19;
    private static final int EVENT_REGISTER_NETWORK_REQUEST_WITH_INTENT = 26;
    private static final int EVENT_RELEASE_NETWORK_REQUEST = 22;
    private static final int EVENT_RELEASE_NETWORK_REQUEST_WITH_INTENT = 27;
    private static final int EVENT_SAMPLE_INTERVAL_ELAPSED = 15;
    private static final int EVENT_SEND_STICKY_BROADCAST_INTENT = 11;
    private static final int EVENT_SET_DEPENDENCY_MET = 10;
    private static final int EVENT_SYSTEM_READY = 25;
    private static final int EVENT_TIMEOUT_NETWORK_REQUEST = 20;
    private static final int EVENT_UNREGISTER_NETWORK_FACTORY = 23;
    private static final String FAIL_FAST_TIME_MS = "persist.radio.fail_fast_time_ms";
    private static final int INET_CONDITION_LOG_MAX_SIZE = 15;
    private static final boolean LOGD_RULES = false;
    private static final int MAX_NET_ID = 65535;
    private static final int MIN_NET_ID = 100;
    private static final String NETWORK_RESTORE_DELAY_PROP_NAME = "android.telephony.apn-restore";
    private static final String NOTIFICATION_ID = "CaptivePortal.Notification";
    private static final int PROVISIONING = 2;
    private static final String PROVISIONING_URL_PATH = "/data/misc/radio/provisioning_urls.xml";
    private static final int REDIRECTED_PROVISIONING = 1;
    private static final int RESTORE_DEFAULT_NETWORK_DELAY = 60000;
    private static final boolean SAMPLE_DBG = false;
    private static final int SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE = 0;
    private static final String TAG = "ConnectivityService";
    private static final String TAG_PROVISIONING_URL = "provisioningUrl";
    private static final String TAG_PROVISIONING_URLS = "provisioningUrls";
    private static final String TAG_REDIRECTED_URL = "redirectedUrl";
    private static final boolean VDBG = false;
    private static ConnectivityService sServiceInstance;
    AlarmManager mAlarmManager;
    private Context mContext;
    private String mCurrentTcpBufferSizes;
    private INetworkManagementEventObserver mDataActivityObserver;
    private DataConnectionStats mDataConnectionStats;
    private InetAddress mDefaultDns;
    private int mDefaultInetConditionPublished;
    private volatile ProxyInfo mDefaultProxy;
    private boolean mDefaultProxyDisabled;
    private final NetworkRequest mDefaultRequest;
    private Object mDnsLock;
    private AtomicInteger mEnableFailFastMobileDataTag;
    private ProxyInfo mGlobalProxy;
    private final InternalHandler mHandler;
    private ArrayList mInetLog;
    private Intent mInitialBroadcast;
    private volatile boolean mIsNotificationVisible;
    private KeyStore mKeyStore;
    private LegacyTypeTracker mLegacyTypeTracker;
    private boolean mLockdownEnabled;
    private LockdownVpnTracker mLockdownTracker;
    private HashSet<String> mMeteredIfaces;
    NetworkConfig[] mNetConfigs;
    private NetworkStateTracker[] mNetTrackers;
    private WakeLock mNetTransitionWakeLock;
    private String mNetTransitionWakeLockCausedBy;
    private int mNetTransitionWakeLockSerialNumber;
    private int mNetTransitionWakeLockTimeout;
    private INetworkManagementService mNetd;
    private final HashMap<Messenger, NetworkAgentInfo> mNetworkAgentInfos;
    private final HashMap<Messenger, NetworkFactoryInfo> mNetworkFactoryInfos;
    private final SparseArray<NetworkAgentInfo> mNetworkForNetId;
    private final SparseArray<NetworkAgentInfo> mNetworkForRequestId;
    private int mNetworkPreference;
    private final HashMap<NetworkRequest, NetworkRequestInfo> mNetworkRequests;
    int mNetworksDefined;
    private int mNextNetId;
    private int mNextNetworkRequestId;
    private int mNumDnsEntries;
    private PacManager mPacManager;
    private final WakeLock mPendingIntentWakeLock;
    private final PermissionMonitor mPermissionMonitor;
    private INetworkPolicyListener mPolicyListener;
    private INetworkPolicyManager mPolicyManager;
    List mProtectedNetworks;
    private final File mProvisioningUrlFile;
    private Object mProxyLock;
    private final int mReleasePendingIntentDelayMs;
    private Object mRulesLock;
    private PendingIntent mSampleIntervalElapsedIntent;
    private SettingsObserver mSettingsObserver;
    private INetworkStatsService mStatsService;
    private boolean mSystemReady;
    TelephonyManager mTelephonyManager;
    private boolean mTestMode;
    private Tethering mTethering;
    private final NetworkStateTrackerHandler mTrackerHandler;
    private SparseIntArray mUidRules;
    private BroadcastReceiver mUserIntentReceiver;
    private UserManager mUserManager;
    private BroadcastReceiver mUserPresentReceiver;
    @GuardedBy("mVpns")
    private final SparseArray<Vpn> mVpns;

    /* renamed from: com.android.server.ConnectivityService.1 */
    class C00251 extends BroadcastReceiver {
        C00251() {
        }

        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals(ConnectivityService.ACTION_PKT_CNT_SAMPLE_INTERVAL_ELAPSED)) {
                ConnectivityService.this.mHandler.sendMessage(ConnectivityService.this.mHandler.obtainMessage(ConnectivityService.INET_CONDITION_LOG_MAX_SIZE));
            }
        }
    }

    /* renamed from: com.android.server.ConnectivityService.2 */
    class C00262 extends BaseNetworkObserver {
        C00262() {
        }

        public void interfaceClassDataActivityChanged(String label, boolean active, long tsNanos) {
            ConnectivityService.this.sendDataActivityBroadcast(Integer.parseInt(label), active, tsNanos);
        }
    }

    /* renamed from: com.android.server.ConnectivityService.3 */
    class C00273 extends INetworkPolicyListener.Stub {
        C00273() {
        }

        public void onUidRulesChanged(int uid, int uidRules) {
            synchronized (ConnectivityService.this.mRulesLock) {
                if (ConnectivityService.this.mUidRules.get(uid, ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE) == uidRules) {
                    return;
                }
                ConnectivityService.this.mUidRules.put(uid, uidRules);
            }
        }

        public void onMeteredIfacesChanged(String[] meteredIfaces) {
            synchronized (ConnectivityService.this.mRulesLock) {
                ConnectivityService.this.mMeteredIfaces.clear();
                String[] arr$ = meteredIfaces;
                int len$ = arr$.length;
                for (int i$ = ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i$ < len$; i$ += ConnectivityService.REDIRECTED_PROVISIONING) {
                    ConnectivityService.this.mMeteredIfaces.add(arr$[i$]);
                }
            }
        }

        public void onRestrictBackgroundChanged(boolean restrictBackground) {
        }
    }

    /* renamed from: com.android.server.ConnectivityService.4 */
    class C00284 extends BroadcastReceiver {
        C00284() {
        }

        public void onReceive(Context context, Intent intent) {
            if (ConnectivityService.this.updateLockdownVpn()) {
                ConnectivityService.this.mContext.unregisterReceiver(this);
            }
        }
    }

    /* renamed from: com.android.server.ConnectivityService.5 */
    class C00295 extends BroadcastReceiver {
        C00295() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            int userId = intent.getIntExtra("android.intent.extra.user_handle", -10000);
            if (userId != -10000) {
                if ("android.intent.action.USER_STARTING".equals(action)) {
                    ConnectivityService.this.onUserStart(userId);
                } else if ("android.intent.action.USER_STOPPING".equals(action)) {
                    ConnectivityService.this.onUserStop(userId);
                }
            }
        }
    }

    private class InternalHandler extends Handler {
        public InternalHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            boolean met = ConnectivityService.DBG;
            switch (msg.what) {
                case ConnectivityService.EVENT_CLEAR_NET_TRANSITION_WAKELOCK /*8*/:
                case ConnectivityService.EVENT_EXPIRE_NET_TRANSITION_WAKELOCK /*24*/:
                    synchronized (ConnectivityService.this) {
                        if (msg.arg1 == ConnectivityService.this.mNetTransitionWakeLockSerialNumber && ConnectivityService.this.mNetTransitionWakeLock.isHeld()) {
                            ConnectivityService.this.mNetTransitionWakeLock.release();
                            String causedBy = ConnectivityService.this.mNetTransitionWakeLockCausedBy;
                            if (msg.what == ConnectivityService.EVENT_EXPIRE_NET_TRANSITION_WAKELOCK) {
                                ConnectivityService.log("Failed to find a new network - expiring NetTransition Wakelock");
                                return;
                            }
                            StringBuilder append = new StringBuilder().append("NetTransition Wakelock (");
                            if (causedBy == null) {
                                causedBy = "unknown";
                            }
                            ConnectivityService.log(append.append(causedBy).append(" cleared because we found a replacement network").toString());
                            return;
                        }
                    }
                case ConnectivityService.EVENT_APPLY_GLOBAL_HTTP_PROXY /*9*/:
                    ConnectivityService.this.handleDeprecatedGlobalHttpProxy();
                case ConnectivityService.EVENT_SET_DEPENDENCY_MET /*10*/:
                    if (msg.arg1 != ConnectivityService.REDIRECTED_PROVISIONING) {
                        met = ConnectivityService.SAMPLE_DBG;
                    }
                    ConnectivityService.this.handleSetDependencyMet(msg.arg2, met);
                case ConnectivityService.EVENT_SEND_STICKY_BROADCAST_INTENT /*11*/:
                    ConnectivityService.this.sendStickyBroadcast(msg.obj);
                case ConnectivityService.EVENT_ENABLE_FAIL_FAST_MOBILE_DATA /*14*/:
                    int tag = ConnectivityService.this.mEnableFailFastMobileDataTag.get();
                    if (msg.arg1 == tag) {
                        MobileDataStateTracker mobileDst = ConnectivityService.this.mNetTrackers[ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE];
                        if (mobileDst != null) {
                            mobileDst.setEnableFailFastMobileData(msg.arg2);
                            return;
                        }
                        return;
                    }
                    ConnectivityService.log("EVENT_ENABLE_FAIL_FAST_MOBILE_DATA: stale arg1:" + msg.arg1 + " != tag:" + tag);
                case ConnectivityService.INET_CONDITION_LOG_MAX_SIZE /*15*/:
                    ConnectivityService.this.handleNetworkSamplingTimeout();
                case ConnectivityService.EVENT_PROXY_HAS_CHANGED /*16*/:
                    ConnectivityService.this.handleApplyDefaultProxy((ProxyInfo) msg.obj);
                case ConnectivityService.EVENT_REGISTER_NETWORK_FACTORY /*17*/:
                    ConnectivityService.this.handleRegisterNetworkFactory((NetworkFactoryInfo) msg.obj);
                case ConnectivityService.EVENT_REGISTER_NETWORK_AGENT /*18*/:
                    ConnectivityService.this.handleRegisterNetworkAgent((NetworkAgentInfo) msg.obj);
                case ConnectivityService.EVENT_REGISTER_NETWORK_REQUEST /*19*/:
                case ConnectivityService.EVENT_REGISTER_NETWORK_LISTENER /*21*/:
                    ConnectivityService.this.handleRegisterNetworkRequest(msg);
                case ConnectivityService.EVENT_RELEASE_NETWORK_REQUEST /*22*/:
                    ConnectivityService.this.handleReleaseNetworkRequest((NetworkRequest) msg.obj, msg.arg1);
                case ConnectivityService.EVENT_UNREGISTER_NETWORK_FACTORY /*23*/:
                    ConnectivityService.this.handleUnregisterNetworkFactory((Messenger) msg.obj);
                case ConnectivityService.EVENT_SYSTEM_READY /*25*/:
                    for (NetworkAgentInfo nai : ConnectivityService.this.mNetworkAgentInfos.values()) {
                        nai.networkMonitor.systemReady = ConnectivityService.DBG;
                    }
                case ConnectivityService.EVENT_REGISTER_NETWORK_REQUEST_WITH_INTENT /*26*/:
                    ConnectivityService.this.handleRegisterNetworkRequestWithIntent(msg);
                case ConnectivityService.EVENT_RELEASE_NETWORK_REQUEST_WITH_INTENT /*27*/:
                    ConnectivityService.this.handleReleaseNetworkRequestWithIntent((PendingIntent) msg.obj, msg.arg1);
                default:
            }
        }
    }

    private class LegacyTypeTracker {
        private static final boolean DBG = true;
        private static final String TAG = "CSLegacyTypeTracker";
        private static final boolean VDBG = false;
        private ArrayList<NetworkAgentInfo>[] mTypeLists;

        public LegacyTypeTracker() {
            this.mTypeLists = new ArrayList[ConnectivityService.EVENT_REGISTER_NETWORK_AGENT];
        }

        public void addSupportedType(int type) {
            if (this.mTypeLists[type] != null) {
                throw new IllegalStateException("legacy list for type " + type + "already initialized");
            }
            this.mTypeLists[type] = new ArrayList();
        }

        public boolean isTypeSupported(int type) {
            return (!ConnectivityManager.isNetworkTypeValid(type) || this.mTypeLists[type] == null) ? ConnectivityService.SAMPLE_DBG : DBG;
        }

        public NetworkAgentInfo getNetworkForType(int type) {
            if (!isTypeSupported(type) || this.mTypeLists[type].isEmpty()) {
                return null;
            }
            return (NetworkAgentInfo) this.mTypeLists[type].get(ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
        }

        private void maybeLogBroadcast(NetworkAgentInfo nai, boolean connected, int type) {
            log("Sending " + (connected ? "connected" : "disconnected") + " broadcast for type " + type + " " + nai.name() + " isDefaultNetwork=" + ConnectivityService.this.isDefaultNetwork(nai));
        }

        public void add(int type, NetworkAgentInfo nai) {
            if (isTypeSupported(type)) {
                ArrayList<NetworkAgentInfo> list = this.mTypeLists[type];
                if (list.contains(nai)) {
                    ConnectivityService.loge("Attempting to register duplicate agent for type " + type + ": " + nai);
                    return;
                }
                list.add(nai);
                if (list.size() == ConnectivityService.REDIRECTED_PROVISIONING || ConnectivityService.this.isDefaultNetwork(nai)) {
                    maybeLogBroadcast(nai, DBG, type);
                    ConnectivityService.this.sendLegacyNetworkBroadcast(nai, DBG, type);
                }
            }
        }

        public void remove(int type, NetworkAgentInfo nai) {
            ArrayList<NetworkAgentInfo> list = this.mTypeLists[type];
            if (list != null && !list.isEmpty()) {
                boolean wasFirstNetwork = ((NetworkAgentInfo) list.get(ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE)).equals(nai);
                if (list.remove(nai)) {
                    if (wasFirstNetwork || ConnectivityService.this.isDefaultNetwork(nai)) {
                        maybeLogBroadcast(nai, ConnectivityService.SAMPLE_DBG, type);
                        ConnectivityService.this.sendLegacyNetworkBroadcast(nai, ConnectivityService.SAMPLE_DBG, type);
                    }
                    if (!list.isEmpty() && wasFirstNetwork) {
                        log("Other network available for type " + type + ", sending connected broadcast");
                        maybeLogBroadcast((NetworkAgentInfo) list.get(ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE), ConnectivityService.SAMPLE_DBG, type);
                        ConnectivityService.this.sendLegacyNetworkBroadcast((NetworkAgentInfo) list.get(ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE), ConnectivityService.SAMPLE_DBG, type);
                    }
                }
            }
        }

        public void remove(NetworkAgentInfo nai) {
            for (int type = ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; type < this.mTypeLists.length; type += ConnectivityService.REDIRECTED_PROVISIONING) {
                remove(type, nai);
            }
        }

        private String naiToString(NetworkAgentInfo nai) {
            return (nai != null ? nai.name() : "null") + " " + (nai.networkInfo != null ? nai.networkInfo.getState() + "/" + nai.networkInfo.getDetailedState() : "???/???");
        }

        public void dump(IndentingPrintWriter pw) {
            for (int type = ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; type < this.mTypeLists.length; type += ConnectivityService.REDIRECTED_PROVISIONING) {
                if (this.mTypeLists[type] != null) {
                    pw.print(type + " ");
                    pw.increaseIndent();
                    if (this.mTypeLists[type].size() == 0) {
                        pw.println("none");
                    }
                    Iterator i$ = this.mTypeLists[type].iterator();
                    while (i$.hasNext()) {
                        pw.println(naiToString((NetworkAgentInfo) i$.next()));
                    }
                    pw.decreaseIndent();
                }
            }
        }

        private void log(String s) {
            Slog.d(TAG, s);
        }
    }

    private enum NascentState {
        JUST_VALIDATED,
        NOT_JUST_VALIDATED
    }

    private static class NetworkFactoryInfo {
        public final AsyncChannel asyncChannel;
        public final Messenger messenger;
        public final String name;

        public NetworkFactoryInfo(String name, Messenger messenger, AsyncChannel asyncChannel) {
            this.name = name;
            this.messenger = messenger;
            this.asyncChannel = asyncChannel;
        }
    }

    private class NetworkRequestInfo implements DeathRecipient {
        static final boolean LISTEN = false;
        static final boolean REQUEST = true;
        final boolean isRequest;
        private final IBinder mBinder;
        final PendingIntent mPendingIntent;
        boolean mPendingIntentSent;
        final int mPid;
        final int mUid;
        final Messenger messenger;
        final NetworkRequest request;

        NetworkRequestInfo(NetworkRequest r, PendingIntent pi, boolean isRequest) {
            this.request = r;
            this.mPendingIntent = pi;
            this.messenger = null;
            this.mBinder = null;
            this.mPid = Binder.getCallingPid();
            this.mUid = Binder.getCallingUid();
            this.isRequest = isRequest;
        }

        NetworkRequestInfo(Messenger m, NetworkRequest r, IBinder binder, boolean isRequest) {
            this.messenger = m;
            this.request = r;
            this.mBinder = binder;
            this.mPid = Binder.getCallingPid();
            this.mUid = Binder.getCallingUid();
            this.isRequest = isRequest;
            this.mPendingIntent = null;
            try {
                this.mBinder.linkToDeath(this, ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
            } catch (RemoteException e) {
                binderDied();
            }
        }

        void unlinkDeathRecipient() {
            if (this.mBinder != null) {
                this.mBinder.unlinkToDeath(this, ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
            }
        }

        public void binderDied() {
            ConnectivityService.log("ConnectivityService NetworkRequestInfo binderDied(" + this.request + ", " + this.mBinder + ")");
            ConnectivityService.this.releaseNetworkRequest(this.request);
        }

        public String toString() {
            return (this.isRequest ? "Request" : "Listen") + " from uid/pid:" + this.mUid + "/" + this.mPid + " for " + this.request + (this.mPendingIntent == null ? "" : " to trigger " + this.mPendingIntent);
        }
    }

    private class NetworkStateTrackerHandler extends Handler {
        public NetworkStateTrackerHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            NetworkAgentInfo nai;
            switch (msg.what) {
                case 69632:
                    ConnectivityService.this.handleAsyncChannelHalfConnect(msg);
                case 69635:
                    nai = (NetworkAgentInfo) ConnectivityService.this.mNetworkAgentInfos.get(msg.replyTo);
                    if (nai != null) {
                        nai.asyncChannel.disconnect();
                    }
                case 69636:
                    ConnectivityService.this.handleAsyncChannelDisconnected(msg);
                case 458752:
                    NetworkInfo info = (NetworkInfo) msg.obj;
                    State state = info.getState();
                    if (state == State.CONNECTED || state == State.DISCONNECTED || state == State.SUSPENDED) {
                        ConnectivityService.log("ConnectivityChange for " + info.getTypeName() + ": " + state + "/" + info.getDetailedState());
                    }
                    EventLogTags.writeConnectivityStateChanged(info.getType(), info.getSubtype(), info.getDetailedState().ordinal());
                    if (info.isConnectedToProvisioningNetwork()) {
                        ConnectivityService.log("EVENT_STATE_CHANGED: connected to provisioning network, lp=" + ConnectivityService.this.getLinkPropertiesForType(info.getType()));
                    } else if (!(state == State.DISCONNECTED || state == State.SUSPENDED || state != State.CONNECTED)) {
                    }
                    ConnectivityService.this.notifyLockdownVpn(null);
                case 458753:
                    NetworkInfo networkInfo = (NetworkInfo) msg.obj;
                case 528385:
                    nai = (NetworkAgentInfo) ConnectivityService.this.mNetworkAgentInfos.get(msg.replyTo);
                    if (nai == null) {
                        ConnectivityService.loge("EVENT_NETWORK_INFO_CHANGED from unknown NetworkAgent");
                    } else {
                        ConnectivityService.this.updateNetworkInfo(nai, msg.obj);
                    }
                case 528386:
                    nai = (NetworkAgentInfo) ConnectivityService.this.mNetworkAgentInfos.get(msg.replyTo);
                    if (nai == null) {
                        ConnectivityService.loge("EVENT_NETWORK_CAPABILITIES_CHANGED from unknown NetworkAgent");
                    } else {
                        ConnectivityService.this.updateCapabilities(nai, (NetworkCapabilities) msg.obj);
                    }
                case 528387:
                    nai = (NetworkAgentInfo) ConnectivityService.this.mNetworkAgentInfos.get(msg.replyTo);
                    if (nai == null) {
                        ConnectivityService.loge("NetworkAgent not found for EVENT_NETWORK_PROPERTIES_CHANGED");
                        return;
                    }
                    LinkProperties oldLp = nai.linkProperties;
                    synchronized (nai) {
                        nai.linkProperties = (LinkProperties) msg.obj;
                        break;
                    }
                    if (nai.created) {
                        ConnectivityService.this.updateLinkProperties(nai, oldLp);
                    }
                case 528388:
                    nai = (NetworkAgentInfo) ConnectivityService.this.mNetworkAgentInfos.get(msg.replyTo);
                    if (nai == null) {
                        ConnectivityService.loge("EVENT_NETWORK_SCORE_CHANGED from unknown NetworkAgent");
                        return;
                    }
                    Integer score = msg.obj;
                    if (score != null) {
                        ConnectivityService.this.updateNetworkScore(nai, score.intValue());
                    }
                case 528389:
                    nai = (NetworkAgentInfo) ConnectivityService.this.mNetworkAgentInfos.get(msg.replyTo);
                    if (nai == null) {
                        ConnectivityService.loge("EVENT_UID_RANGES_ADDED from unknown NetworkAgent");
                        return;
                    }
                    try {
                        ConnectivityService.this.mNetd.addVpnUidRanges(nai.network.netId, (UidRange[]) msg.obj);
                    } catch (Exception e) {
                        ConnectivityService.loge("Exception in addVpnUidRanges: " + e);
                    }
                case 528390:
                    nai = (NetworkAgentInfo) ConnectivityService.this.mNetworkAgentInfos.get(msg.replyTo);
                    if (nai == null) {
                        ConnectivityService.loge("EVENT_UID_RANGES_REMOVED from unknown NetworkAgent");
                        return;
                    }
                    try {
                        ConnectivityService.this.mNetd.removeVpnUidRanges(nai.network.netId, (UidRange[]) msg.obj);
                    } catch (Exception e2) {
                        ConnectivityService.loge("Exception in removeVpnUidRanges: " + e2);
                    }
                case 528392:
                    nai = (NetworkAgentInfo) ConnectivityService.this.mNetworkAgentInfos.get(msg.replyTo);
                    if (nai == null) {
                        ConnectivityService.loge("EVENT_SET_EXPLICITLY_SELECTED from unknown NetworkAgent");
                        return;
                    }
                    if (nai.created && !nai.networkMisc.explicitlySelected) {
                        ConnectivityService.loge("ERROR: created network explicitly selected.");
                    }
                    nai.networkMisc.explicitlySelected = ConnectivityService.DBG;
                case NetworkMonitor.EVENT_NETWORK_TESTED /*532482*/:
                    nai = (NetworkAgentInfo) msg.obj;
                    if (ConnectivityService.this.isLiveNetworkAgent(nai, "EVENT_NETWORK_VALIDATED")) {
                        int i;
                        boolean valid = msg.arg1 == 0 ? ConnectivityService.DBG : ConnectivityService.SAMPLE_DBG;
                        nai.lastValidated = valid;
                        if (valid) {
                            ConnectivityService.log("Validated " + nai.name());
                            if (!nai.everValidated) {
                                nai.everValidated = ConnectivityService.DBG;
                                ConnectivityService.this.rematchNetworkAndRequests(nai, NascentState.JUST_VALIDATED, ReapUnvalidatedNetworks.REAP);
                                ConnectivityService.this.sendUpdatedScoreToFactories(nai);
                            }
                        }
                        ConnectivityService.this.updateInetCondition(nai);
                        AsyncChannel asyncChannel = nai.asyncChannel;
                        if (valid) {
                            i = ConnectivityService.REDIRECTED_PROVISIONING;
                        } else {
                            i = ConnectivityService.PROVISIONING;
                        }
                        asyncChannel.sendMessage(528391, i, ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, null);
                    }
                case NetworkMonitor.EVENT_NETWORK_LINGER_COMPLETE /*532485*/:
                    nai = (NetworkAgentInfo) msg.obj;
                    if (ConnectivityService.this.isLiveNetworkAgent(nai, "EVENT_NETWORK_LINGER_COMPLETE")) {
                        ConnectivityService.this.handleLingerComplete(nai);
                    }
                case NetworkMonitor.EVENT_PROVISIONING_NOTIFICATION /*532490*/:
                    if (msg.arg1 == 0) {
                        ConnectivityService.this.setProvNotificationVisibleIntent(ConnectivityService.SAMPLE_DBG, msg.arg2, ConnectivityService.SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, null, null);
                        return;
                    }
                    synchronized (ConnectivityService.this.mNetworkForNetId) {
                        nai = (NetworkAgentInfo) ConnectivityService.this.mNetworkForNetId.get(msg.arg2);
                        break;
                    }
                    if (nai == null) {
                        ConnectivityService.loge("EVENT_PROVISIONING_NOTIFICATION from unknown NetworkMonitor");
                    } else {
                        ConnectivityService.this.setProvNotificationVisibleIntent(ConnectivityService.DBG, msg.arg2, nai.networkInfo.getType(), nai.networkInfo.getExtraInfo(), (PendingIntent) msg.obj);
                    }
                default:
            }
        }
    }

    private enum ReapUnvalidatedNetworks {
        REAP,
        DONT_REAP
    }

    private static class SettingsObserver extends ContentObserver {
        private Handler mHandler;
        private int mWhat;

        SettingsObserver(Handler handler, int what) {
            super(handler);
            this.mHandler = handler;
            this.mWhat = what;
        }

        void observe(Context context) {
            context.getContentResolver().registerContentObserver(Global.getUriFor("http_proxy"), ConnectivityService.SAMPLE_DBG, this);
        }

        public void onChange(boolean selfChange) {
            this.mHandler.obtainMessage(this.mWhat).sendToTarget();
        }
    }

    public ConnectivityService(Context context, INetworkManagementService netManager, INetworkStatsService statsService, INetworkPolicyManager policyManager) {
        int i$;
        this.mVpns = new SparseArray();
        this.mRulesLock = new Object();
        this.mUidRules = new SparseIntArray();
        this.mMeteredIfaces = Sets.newHashSet();
        this.mDefaultInetConditionPublished = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
        this.mDnsLock = new Object();
        this.mNetTransitionWakeLockCausedBy = "";
        this.mDefaultProxy = null;
        this.mProxyLock = new Object();
        this.mDefaultProxyDisabled = SAMPLE_DBG;
        this.mGlobalProxy = null;
        this.mPacManager = null;
        this.mEnableFailFastMobileDataTag = new AtomicInteger(SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
        this.mNextNetId = MIN_NET_ID;
        this.mNextNetworkRequestId = REDIRECTED_PROVISIONING;
        this.mLegacyTypeTracker = new LegacyTypeTracker();
        this.mDataActivityObserver = new C00262();
        this.mPolicyListener = new C00273();
        this.mUserPresentReceiver = new C00284();
        this.mIsNotificationVisible = SAMPLE_DBG;
        this.mProvisioningUrlFile = new File(PROVISIONING_URL_PATH);
        this.mUserIntentReceiver = new C00295();
        this.mNetworkFactoryInfos = new HashMap();
        this.mNetworkRequests = new HashMap();
        this.mNetworkForRequestId = new SparseArray();
        this.mNetworkForNetId = new SparseArray();
        this.mNetworkAgentInfos = new HashMap();
        log("ConnectivityService starting up");
        NetworkCapabilities netCap = new NetworkCapabilities();
        netCap.addCapability(12);
        netCap.addCapability(13);
        this.mDefaultRequest = new NetworkRequest(netCap, -1, nextNetworkRequestId());
        this.mNetworkRequests.put(this.mDefaultRequest, new NetworkRequestInfo(null, this.mDefaultRequest, new Binder(), DBG));
        HandlerThread handlerThread = new HandlerThread("ConnectivityServiceThread");
        handlerThread.start();
        this.mHandler = new InternalHandler(handlerThread.getLooper());
        this.mTrackerHandler = new NetworkStateTrackerHandler(handlerThread.getLooper());
        if (TextUtils.isEmpty(SystemProperties.get("net.hostname"))) {
            String id = Secure.getString(context.getContentResolver(), "android_id");
            if (id != null && id.length() > 0) {
                SystemProperties.set("net.hostname", new String("android-").concat(id));
            }
        }
        String dns = Global.getString(context.getContentResolver(), "default_dns_server");
        if (dns == null || dns.length() == 0) {
            dns = context.getResources().getString(17039404);
        }
        try {
            this.mDefaultDns = NetworkUtils.numericToInetAddress(dns);
        } catch (IllegalArgumentException e) {
            loge("Error setting defaultDns using " + dns);
        }
        this.mReleasePendingIntentDelayMs = Secure.getInt(context.getContentResolver(), "connectivity_release_pending_intent_delay_ms", 5000);
        this.mContext = (Context) checkNotNull(context, "missing Context");
        this.mNetd = (INetworkManagementService) checkNotNull(netManager, "missing INetworkManagementService");
        this.mStatsService = (INetworkStatsService) checkNotNull(statsService, "missing INetworkStatsService");
        this.mPolicyManager = (INetworkPolicyManager) checkNotNull(policyManager, "missing INetworkPolicyManager");
        this.mKeyStore = KeyStore.getInstance();
        this.mTelephonyManager = (TelephonyManager) this.mContext.getSystemService("phone");
        try {
            this.mPolicyManager.registerListener(this.mPolicyListener);
        } catch (RemoteException e2) {
            loge("unable to register INetworkPolicyListener" + e2.toString());
        }
        PowerManager powerManager = (PowerManager) context.getSystemService("power");
        this.mNetTransitionWakeLock = powerManager.newWakeLock(REDIRECTED_PROVISIONING, TAG);
        this.mNetTransitionWakeLockTimeout = this.mContext.getResources().getInteger(17694733);
        this.mPendingIntentWakeLock = powerManager.newWakeLock(REDIRECTED_PROVISIONING, TAG);
        this.mNetTrackers = new NetworkStateTracker[EVENT_REGISTER_NETWORK_AGENT];
        this.mNetConfigs = new NetworkConfig[EVENT_REGISTER_NETWORK_AGENT];
        boolean wifiOnly = (SystemProperties.getBoolean("ro.radio.noril", SAMPLE_DBG) || SystemProperties.getBoolean("persist.radio.noril", SAMPLE_DBG)) ? DBG : SAMPLE_DBG;
        log("wifiOnly=" + wifiOnly);
        String[] arr$ = context.getResources().getStringArray(17235981);
        int len$ = arr$.length;
        for (i$ = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i$ < len$; i$ += REDIRECTED_PROVISIONING) {
            try {
                NetworkConfig n = new NetworkConfig(arr$[i$]);
                if (n.type > EVENT_REGISTER_NETWORK_FACTORY) {
                    loge("Error in networkAttributes - ignoring attempt to define type " + n.type);
                } else {
                    if (wifiOnly) {
                        if (ConnectivityManager.isNetworkTypeMobile(n.type)) {
                            log("networkAttributes - ignoring mobile as this dev is wifiOnly " + n.type);
                        }
                    }
                    if (this.mNetConfigs[n.type] != null) {
                        loge("Error in networkAttributes - ignoring attempt to redefine type " + n.type);
                    } else {
                        this.mLegacyTypeTracker.addSupportedType(n.type);
                        this.mNetConfigs[n.type] = n;
                        this.mNetworksDefined += REDIRECTED_PROVISIONING;
                    }
                }
            } catch (Exception e3) {
            }
        }
        if (this.mNetConfigs[EVENT_REGISTER_NETWORK_FACTORY] == null) {
            this.mLegacyTypeTracker.addSupportedType(EVENT_REGISTER_NETWORK_FACTORY);
            this.mNetworksDefined += REDIRECTED_PROVISIONING;
        }
        this.mProtectedNetworks = new ArrayList();
        int[] arr$2 = context.getResources().getIntArray(17235982);
        len$ = arr$2.length;
        for (i$ = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i$ < len$; i$ += REDIRECTED_PROVISIONING) {
            int p = arr$2[i$];
            if (this.mNetConfigs[p] == null || this.mProtectedNetworks.contains(Integer.valueOf(p))) {
                loge("Ignoring protectedNetwork " + p);
            } else {
                this.mProtectedNetworks.add(Integer.valueOf(p));
            }
        }
        boolean z = (SystemProperties.get("cm.test.mode").equals("true") && SystemProperties.get("ro.build.type").equals("eng")) ? DBG : SAMPLE_DBG;
        this.mTestMode = z;
        this.mTethering = new Tethering(this.mContext, this.mNetd, statsService, this.mHandler.getLooper());
        this.mPermissionMonitor = new PermissionMonitor(this.mContext, this.mNetd);
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.USER_STARTING");
        intentFilter.addAction("android.intent.action.USER_STOPPING");
        this.mContext.registerReceiverAsUser(this.mUserIntentReceiver, UserHandle.ALL, intentFilter, null, null);
        try {
            this.mNetd.registerObserver(this.mTethering);
            this.mNetd.registerObserver(this.mDataActivityObserver);
        } catch (RemoteException e22) {
            loge("Error registering observer :" + e22);
        }
        this.mInetLog = new ArrayList();
        this.mSettingsObserver = new SettingsObserver(this.mHandler, EVENT_APPLY_GLOBAL_HTTP_PROXY);
        this.mSettingsObserver.observe(this.mContext);
        this.mDataConnectionStats = new DataConnectionStats(this.mContext);
        this.mDataConnectionStats.startMonitoring();
        this.mAlarmManager = (AlarmManager) this.mContext.getSystemService("alarm");
        IntentFilter filter = new IntentFilter();
        filter.addAction(ACTION_PKT_CNT_SAMPLE_INTERVAL_ELAPSED);
        this.mContext.registerReceiver(new C00251(), new IntentFilter(filter));
        this.mPacManager = new PacManager(this.mContext, this.mHandler, EVENT_PROXY_HAS_CHANGED);
        this.mUserManager = (UserManager) context.getSystemService("user");
    }

    private synchronized int nextNetworkRequestId() {
        int i;
        i = this.mNextNetworkRequestId;
        this.mNextNetworkRequestId = i + REDIRECTED_PROVISIONING;
        return i;
    }

    private void assignNextNetId(NetworkAgentInfo nai) {
        synchronized (this.mNetworkForNetId) {
            for (int i = MIN_NET_ID; i <= MAX_NET_ID; i += REDIRECTED_PROVISIONING) {
                int netId = this.mNextNetId;
                int i2 = this.mNextNetId + REDIRECTED_PROVISIONING;
                this.mNextNetId = i2;
                if (i2 > MAX_NET_ID) {
                    this.mNextNetId = MIN_NET_ID;
                }
                if (this.mNetworkForNetId.get(netId) == null) {
                    nai.network = new Network(netId);
                    this.mNetworkForNetId.put(netId, nai);
                    return;
                }
            }
            throw new IllegalStateException("No free netIds");
        }
    }

    private boolean teardown(NetworkStateTracker netTracker) {
        if (!netTracker.teardown()) {
            return SAMPLE_DBG;
        }
        netTracker.setTeardownRequested(DBG);
        return DBG;
    }

    private NetworkState getFilteredNetworkState(int networkType, int uid) {
        LinkProperties lp;
        Throwable th;
        NetworkCapabilities nc;
        NetworkInfo info = null;
        LinkProperties lp2 = null;
        NetworkCapabilities nc2 = null;
        Network network = null;
        String subscriberId = null;
        if (this.mLegacyTypeTracker.isTypeSupported(networkType)) {
            NetworkAgentInfo nai = this.mLegacyTypeTracker.getNetworkForType(networkType);
            if (nai != null) {
                synchronized (nai) {
                    try {
                        Network network2;
                        NetworkInfo info2 = new NetworkInfo(nai.networkInfo);
                        try {
                            lp = new LinkProperties(nai.linkProperties);
                        } catch (Throwable th2) {
                            th = th2;
                            info = info2;
                            throw th;
                        }
                        try {
                            nc = new NetworkCapabilities(nai.networkCapabilities);
                        } catch (Throwable th3) {
                            th = th3;
                            lp2 = lp;
                            info = info2;
                            throw th;
                        }
                        try {
                            network2 = new Network(nai.network);
                        } catch (Throwable th4) {
                            th = th4;
                            nc2 = nc;
                            lp2 = lp;
                            info = info2;
                            throw th;
                        }
                        try {
                            subscriberId = nai.networkMisc != null ? nai.networkMisc.subscriberId : null;
                            info2.setType(networkType);
                            network = network2;
                            nc2 = nc;
                            lp2 = lp;
                            info = info2;
                        } catch (Throwable th5) {
                            th = th5;
                            network = network2;
                            nc2 = nc;
                            lp2 = lp;
                            info = info2;
                            throw th;
                        }
                    } catch (Throwable th6) {
                        th = th6;
                        throw th;
                    }
                }
            }
            info = new NetworkInfo(networkType, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, ConnectivityManager.getNetworkTypeName(networkType), "");
            info.setDetailedState(DetailedState.DISCONNECTED, null, null);
            info.setIsAvailable(DBG);
            lp2 = new LinkProperties();
            nc2 = new NetworkCapabilities();
            network = null;
            info = getFilteredNetworkInfo(info, lp2, uid);
        }
        return new NetworkState(info, lp2, nc2, network, subscriberId, null);
    }

    private NetworkAgentInfo getNetworkAgentInfoForNetwork(Network network) {
        if (network == null) {
            return null;
        }
        NetworkAgentInfo networkAgentInfo;
        synchronized (this.mNetworkForNetId) {
            networkAgentInfo = (NetworkAgentInfo) this.mNetworkForNetId.get(network.netId);
        }
        return networkAgentInfo;
    }

    private Network[] getVpnUnderlyingNetworks(int uid) {
        if (!this.mLockdownEnabled) {
            int user = UserHandle.getUserId(uid);
            synchronized (this.mVpns) {
                Vpn vpn = (Vpn) this.mVpns.get(user);
                if (vpn == null || !vpn.appliesToUid(uid)) {
                } else {
                    Network[] underlyingNetworks = vpn.getUnderlyingNetworks();
                    return underlyingNetworks;
                }
            }
        }
        return null;
    }

    private NetworkState getUnfilteredActiveNetworkState(int uid) {
        LinkProperties lp;
        Throwable th;
        NetworkCapabilities nc;
        Network network;
        NetworkInfo info = null;
        LinkProperties lp2 = null;
        NetworkCapabilities nc2 = null;
        Network network2 = null;
        String subscriberId = null;
        NetworkAgentInfo nai = (NetworkAgentInfo) this.mNetworkForRequestId.get(this.mDefaultRequest.requestId);
        Network[] networks = getVpnUnderlyingNetworks(uid);
        if (networks != null) {
            if (networks.length > 0) {
                nai = getNetworkAgentInfoForNetwork(networks[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE]);
            } else {
                nai = null;
            }
        }
        if (nai != null) {
            synchronized (nai) {
                try {
                    NetworkInfo info2 = new NetworkInfo(nai.networkInfo);
                    try {
                        lp = new LinkProperties(nai.linkProperties);
                    } catch (Throwable th2) {
                        th = th2;
                        info = info2;
                        throw th;
                    }
                    try {
                        nc = new NetworkCapabilities(nai.networkCapabilities);
                    } catch (Throwable th3) {
                        th = th3;
                        lp2 = lp;
                        info = info2;
                        throw th;
                    }
                    try {
                        network = new Network(nai.network);
                    } catch (Throwable th4) {
                        th = th4;
                        nc2 = nc;
                        lp2 = lp;
                        info = info2;
                        throw th;
                    }
                    try {
                        if (nai.networkMisc != null) {
                            subscriberId = nai.networkMisc.subscriberId;
                        } else {
                            subscriberId = null;
                        }
                        network2 = network;
                        nc2 = nc;
                        lp2 = lp;
                        info = info2;
                    } catch (Throwable th5) {
                        th = th5;
                        network2 = network;
                        nc2 = nc;
                        lp2 = lp;
                        info = info2;
                        throw th;
                    }
                } catch (Throwable th6) {
                    th = th6;
                    throw th;
                }
            }
        }
        return new NetworkState(info, lp2, nc2, network2, subscriberId, null);
    }

    private boolean isNetworkWithLinkPropertiesBlocked(LinkProperties lp, int uid) {
        String iface = lp == null ? "" : lp.getInterfaceName();
        synchronized (this.mRulesLock) {
            boolean networkCostly = this.mMeteredIfaces.contains(iface);
            int uidRules = this.mUidRules.get(uid, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
        }
        if (!networkCostly || (uidRules & REDIRECTED_PROVISIONING) == 0) {
            return SAMPLE_DBG;
        }
        return DBG;
    }

    private NetworkInfo getFilteredNetworkInfo(NetworkInfo info, LinkProperties lp, int uid) {
        if (info != null && isNetworkWithLinkPropertiesBlocked(lp, uid)) {
            NetworkInfo info2 = new NetworkInfo(info);
            info2.setDetailedState(DetailedState.BLOCKED, null, null);
            log("returning Blocked NetworkInfo for ifname=" + lp.getInterfaceName() + ", uid=" + uid);
            info = info2;
        }
        if (info == null || this.mLockdownTracker == null) {
            return info;
        }
        info = this.mLockdownTracker.augmentNetworkInfo(info);
        log("returning Locked NetworkInfo");
        return info;
    }

    public NetworkInfo getActiveNetworkInfo() {
        enforceAccessPermission();
        int uid = Binder.getCallingUid();
        NetworkState state = getUnfilteredActiveNetworkState(uid);
        return getFilteredNetworkInfo(state.networkInfo, state.linkProperties, uid);
    }

    private NetworkInfo getProvisioningNetworkInfo() {
        enforceAccessPermission();
        NetworkInfo provNi = null;
        NetworkInfo[] arr$ = getAllNetworkInfo();
        int len$ = arr$.length;
        for (int i$ = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i$ < len$; i$ += REDIRECTED_PROVISIONING) {
            NetworkInfo ni = arr$[i$];
            if (ni.isConnectedToProvisioningNetwork()) {
                provNi = ni;
                break;
            }
        }
        log("getProvisioningNetworkInfo: X provNi=" + provNi);
        return provNi;
    }

    public NetworkInfo getProvisioningOrActiveNetworkInfo() {
        enforceAccessPermission();
        NetworkInfo provNi = getProvisioningNetworkInfo();
        if (provNi == null) {
            provNi = getActiveNetworkInfo();
        }
        log("getProvisioningOrActiveNetworkInfo: X provNi=" + provNi);
        return provNi;
    }

    public NetworkInfo getActiveNetworkInfoUnfiltered() {
        enforceAccessPermission();
        return getUnfilteredActiveNetworkState(Binder.getCallingUid()).networkInfo;
    }

    public NetworkInfo getActiveNetworkInfoForUid(int uid) {
        enforceConnectivityInternalPermission();
        NetworkState state = getUnfilteredActiveNetworkState(uid);
        return getFilteredNetworkInfo(state.networkInfo, state.linkProperties, uid);
    }

    public NetworkInfo getNetworkInfo(int networkType) {
        enforceAccessPermission();
        int uid = Binder.getCallingUid();
        if (getVpnUnderlyingNetworks(uid) != null) {
            NetworkState state = getUnfilteredActiveNetworkState(uid);
            if (state.networkInfo != null && state.networkInfo.getType() == networkType) {
                return getFilteredNetworkInfo(state.networkInfo, state.linkProperties, uid);
            }
        }
        return getFilteredNetworkState(networkType, uid).networkInfo;
    }

    public NetworkInfo getNetworkInfoForNetwork(Network network) {
        enforceAccessPermission();
        int uid = Binder.getCallingUid();
        NetworkInfo info = null;
        NetworkAgentInfo nai = getNetworkAgentInfoForNetwork(network);
        if (nai != null) {
            synchronized (nai) {
                try {
                    NetworkInfo info2 = new NetworkInfo(nai.networkInfo);
                    try {
                        info = getFilteredNetworkInfo(info2, nai.linkProperties, uid);
                    } catch (Throwable th) {
                        Throwable th2 = th;
                        info = info2;
                        throw th2;
                    }
                } catch (Throwable th3) {
                    th2 = th3;
                    throw th2;
                }
            }
        }
        return info;
    }

    public NetworkInfo[] getAllNetworkInfo() {
        enforceAccessPermission();
        ArrayList<NetworkInfo> result = Lists.newArrayList();
        for (int networkType = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; networkType <= EVENT_REGISTER_NETWORK_FACTORY; networkType += REDIRECTED_PROVISIONING) {
            NetworkInfo info = getNetworkInfo(networkType);
            if (info != null) {
                result.add(info);
            }
        }
        return (NetworkInfo[]) result.toArray(new NetworkInfo[result.size()]);
    }

    public Network getNetworkForType(int networkType) {
        enforceAccessPermission();
        int uid = Binder.getCallingUid();
        NetworkState state = getFilteredNetworkState(networkType, uid);
        if (isNetworkWithLinkPropertiesBlocked(state.linkProperties, uid)) {
            return null;
        }
        return state.network;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.net.Network[] getAllNetworks() {
        /*
        r5 = this;
        r5.enforceAccessPermission();
        r1 = new java.util.ArrayList;
        r1.<init>();
        r3 = r5.mNetworkForNetId;
        monitor-enter(r3);
        r0 = 0;
    L_0x000c:
        r2 = r5.mNetworkForNetId;	 Catch:{ all -> 0x0037 }
        r2 = r2.size();	 Catch:{ all -> 0x0037 }
        if (r0 >= r2) goto L_0x0029;
    L_0x0014:
        r4 = new android.net.Network;	 Catch:{ all -> 0x0037 }
        r2 = r5.mNetworkForNetId;	 Catch:{ all -> 0x0037 }
        r2 = r2.valueAt(r0);	 Catch:{ all -> 0x0037 }
        r2 = (com.android.server.connectivity.NetworkAgentInfo) r2;	 Catch:{ all -> 0x0037 }
        r2 = r2.network;	 Catch:{ all -> 0x0037 }
        r4.<init>(r2);	 Catch:{ all -> 0x0037 }
        r1.add(r4);	 Catch:{ all -> 0x0037 }
        r0 = r0 + 1;
        goto L_0x000c;
    L_0x0029:
        monitor-exit(r3);	 Catch:{ all -> 0x0037 }
        r2 = r1.size();
        r2 = new android.net.Network[r2];
        r2 = r1.toArray(r2);
        r2 = (android.net.Network[]) r2;
        return r2;
    L_0x0037:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0037 }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.ConnectivityService.getAllNetworks():android.net.Network[]");
    }

    private NetworkCapabilities getNetworkCapabilitiesAndValidation(NetworkAgentInfo nai) {
        if (nai != null) {
            synchronized (nai) {
                if (nai.created) {
                    NetworkCapabilities nc = new NetworkCapabilities(nai.networkCapabilities);
                    if (nai.lastValidated) {
                        nc.addCapability(EVENT_PROXY_HAS_CHANGED);
                    } else {
                        nc.removeCapability(EVENT_PROXY_HAS_CHANGED);
                    }
                    return nc;
                }
            }
        }
        return null;
    }

    public NetworkCapabilities[] getDefaultNetworkCapabilitiesForUser(int userId) {
        enforceAccessPermission();
        HashMap<Network, NetworkCapabilities> result = new HashMap();
        NetworkAgentInfo nai = getDefaultNetwork();
        NetworkCapabilities nc = getNetworkCapabilitiesAndValidation(getDefaultNetwork());
        if (nc != null) {
            result.put(nai.network, nc);
        }
        if (!this.mLockdownEnabled) {
            synchronized (this.mVpns) {
                Vpn vpn = (Vpn) this.mVpns.get(userId);
                if (vpn != null) {
                    Network[] networks = vpn.getUnderlyingNetworks();
                    if (networks != null) {
                        Network[] arr$ = networks;
                        int len$ = arr$.length;
                        for (int i$ = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i$ < len$; i$ += REDIRECTED_PROVISIONING) {
                            nai = getNetworkAgentInfoForNetwork(arr$[i$]);
                            nc = getNetworkCapabilitiesAndValidation(nai);
                            if (nc != null) {
                                result.put(nai.network, nc);
                            }
                        }
                    }
                }
            }
        }
        return (NetworkCapabilities[]) result.values().toArray(new NetworkCapabilities[result.size()]);
    }

    public boolean isNetworkSupported(int networkType) {
        enforceAccessPermission();
        return this.mLegacyTypeTracker.isTypeSupported(networkType);
    }

    public LinkProperties getActiveLinkProperties() {
        enforceAccessPermission();
        return getUnfilteredActiveNetworkState(Binder.getCallingUid()).linkProperties;
    }

    public LinkProperties getLinkPropertiesForType(int networkType) {
        enforceAccessPermission();
        NetworkAgentInfo nai = this.mLegacyTypeTracker.getNetworkForType(networkType);
        if (nai == null) {
            return null;
        }
        LinkProperties linkProperties;
        synchronized (nai) {
            linkProperties = new LinkProperties(nai.linkProperties);
        }
        return linkProperties;
    }

    public LinkProperties getLinkProperties(Network network) {
        enforceAccessPermission();
        NetworkAgentInfo nai = getNetworkAgentInfoForNetwork(network);
        if (nai == null) {
            return null;
        }
        LinkProperties linkProperties;
        synchronized (nai) {
            linkProperties = new LinkProperties(nai.linkProperties);
        }
        return linkProperties;
    }

    public NetworkCapabilities getNetworkCapabilities(Network network) {
        enforceAccessPermission();
        NetworkAgentInfo nai = getNetworkAgentInfoForNetwork(network);
        if (nai == null) {
            return null;
        }
        NetworkCapabilities networkCapabilities;
        synchronized (nai) {
            networkCapabilities = new NetworkCapabilities(nai.networkCapabilities);
        }
        return networkCapabilities;
    }

    public NetworkState[] getAllNetworkState() {
        enforceConnectivityInternalPermission();
        ArrayList<NetworkState> result = Lists.newArrayList();
        Network[] arr$ = getAllNetworks();
        int len$ = arr$.length;
        for (int i$ = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i$ < len$; i$ += REDIRECTED_PROVISIONING) {
            Network network = arr$[i$];
            NetworkAgentInfo nai = getNetworkAgentInfoForNetwork(network);
            if (nai != null) {
                synchronized (nai) {
                    String subscriberId;
                    if (nai.networkMisc != null) {
                        subscriberId = nai.networkMisc.subscriberId;
                    } else {
                        subscriberId = null;
                    }
                    result.add(new NetworkState(nai.networkInfo, nai.linkProperties, nai.networkCapabilities, network, subscriberId, null));
                }
            }
        }
        return (NetworkState[]) result.toArray(new NetworkState[result.size()]);
    }

    public NetworkQuotaInfo getActiveNetworkQuotaInfo() {
        enforceAccessPermission();
        int uid = Binder.getCallingUid();
        long token = Binder.clearCallingIdentity();
        try {
            NetworkState state = getUnfilteredActiveNetworkState(uid);
            if (state.networkInfo != null) {
                try {
                    NetworkQuotaInfo networkQuotaInfo = this.mPolicyManager.getNetworkQuotaInfo(state);
                    return networkQuotaInfo;
                } catch (RemoteException e) {
                }
            }
            Binder.restoreCallingIdentity(token);
            return null;
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public boolean isActiveNetworkMetered() {
        enforceAccessPermission();
        int uid = Binder.getCallingUid();
        long token = Binder.clearCallingIdentity();
        try {
            boolean isActiveNetworkMeteredUnchecked = isActiveNetworkMeteredUnchecked(uid);
            return isActiveNetworkMeteredUnchecked;
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    private boolean isActiveNetworkMeteredUnchecked(int uid) {
        NetworkState state = getUnfilteredActiveNetworkState(uid);
        if (state.networkInfo != null) {
            try {
                return this.mPolicyManager.isNetworkMetered(state);
            } catch (RemoteException e) {
            }
        }
        return SAMPLE_DBG;
    }

    public boolean requestRouteToHostAddress(int networkType, byte[] hostAddress) {
        boolean z = SAMPLE_DBG;
        enforceChangePermission();
        if (this.mProtectedNetworks.contains(Integer.valueOf(networkType))) {
            enforceConnectivityInternalPermission();
        }
        try {
            InetAddress addr = InetAddress.getByAddress(hostAddress);
            if (ConnectivityManager.isNetworkTypeValid(networkType)) {
                NetworkAgentInfo nai = this.mLegacyTypeTracker.getNetworkForType(networkType);
                if (nai != null) {
                    DetailedState netState;
                    synchronized (nai) {
                        netState = nai.networkInfo.getDetailedState();
                    }
                    if (netState == DetailedState.CONNECTED || netState == DetailedState.CAPTIVE_PORTAL_CHECK) {
                        int uid = Binder.getCallingUid();
                        long token = Binder.clearCallingIdentity();
                        try {
                            LinkProperties lp;
                            int netId;
                            synchronized (nai) {
                                lp = nai.linkProperties;
                                netId = nai.network.netId;
                            }
                            z = addLegacyRouteToHost(lp, addr, netId, uid);
                            log("requestRouteToHostAddress ok=" + z);
                        } finally {
                            Binder.restoreCallingIdentity(token);
                        }
                    }
                } else if (this.mLegacyTypeTracker.isTypeSupported(networkType)) {
                    log("requestRouteToHostAddress on down network: " + networkType);
                } else {
                    log("requestRouteToHostAddress on unsupported network: " + networkType);
                }
            } else {
                log("requestRouteToHostAddress on invalid network: " + networkType);
            }
        } catch (UnknownHostException e) {
            log("requestRouteToHostAddress got " + e.toString());
        }
        return z;
    }

    private boolean addLegacyRouteToHost(LinkProperties lp, InetAddress addr, int netId, int uid) {
        RouteInfo bestRoute = RouteInfo.selectBestRoute(lp.getAllRoutes(), addr);
        if (bestRoute == null) {
            bestRoute = RouteInfo.makeHostRoute(addr, lp.getInterfaceName());
        } else {
            String iface = bestRoute.getInterface();
            if (bestRoute.getGateway().equals(addr)) {
                bestRoute = RouteInfo.makeHostRoute(addr, iface);
            } else {
                bestRoute = RouteInfo.makeHostRoute(addr, bestRoute.getGateway(), iface);
            }
        }
        log("Adding " + bestRoute + " for interface " + bestRoute.getInterface());
        try {
            this.mNetd.addLegacyRouteForNetId(netId, bestRoute, uid);
            return DBG;
        } catch (Exception e) {
            loge("Exception trying to add a route: " + e);
            return SAMPLE_DBG;
        }
    }

    public void setDataDependency(int networkType, boolean met) {
        enforceConnectivityInternalPermission();
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_SET_DEPENDENCY_MET, met ? REDIRECTED_PROVISIONING : SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, networkType));
    }

    private void handleSetDependencyMet(int networkType, boolean met) {
        if (this.mNetTrackers[networkType] != null) {
            log("handleSetDependencyMet(" + networkType + ", " + met + ")");
            this.mNetTrackers[networkType].setDependencyMet(met);
        }
    }

    private void enforceInternetPermission() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.INTERNET", TAG);
    }

    private void enforceAccessPermission() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.ACCESS_NETWORK_STATE", TAG);
    }

    private void enforceChangePermission() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CHANGE_NETWORK_STATE", TAG);
    }

    private void enforceTetherAccessPermission() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.ACCESS_NETWORK_STATE", TAG);
    }

    private void enforceConnectivityInternalPermission() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", TAG);
    }

    public void sendConnectedBroadcast(NetworkInfo info) {
        enforceConnectivityInternalPermission();
        sendGeneralBroadcast(info, "android.net.conn.CONNECTIVITY_CHANGE_IMMEDIATE");
        sendGeneralBroadcast(info, "android.net.conn.CONNECTIVITY_CHANGE");
    }

    private void sendInetConditionBroadcast(NetworkInfo info) {
        sendGeneralBroadcast(info, "android.net.conn.INET_CONDITION_ACTION");
    }

    private Intent makeGeneralIntent(NetworkInfo info, String bcastType) {
        if (this.mLockdownTracker != null) {
            info = this.mLockdownTracker.augmentNetworkInfo(info);
        }
        Intent intent = new Intent(bcastType);
        intent.putExtra("networkInfo", new NetworkInfo(info));
        intent.putExtra("networkType", info.getType());
        if (info.isFailover()) {
            intent.putExtra("isFailover", DBG);
            info.setFailover(SAMPLE_DBG);
        }
        if (info.getReason() != null) {
            intent.putExtra("reason", info.getReason());
        }
        if (info.getExtraInfo() != null) {
            intent.putExtra("extraInfo", info.getExtraInfo());
        }
        intent.putExtra("inetCondition", this.mDefaultInetConditionPublished);
        return intent;
    }

    private void sendGeneralBroadcast(NetworkInfo info, String bcastType) {
        sendStickyBroadcast(makeGeneralIntent(info, bcastType));
    }

    private void sendDataActivityBroadcast(int deviceType, boolean active, long tsNanos) {
        Intent intent = new Intent("android.net.conn.DATA_ACTIVITY_CHANGE");
        intent.putExtra("deviceType", deviceType);
        intent.putExtra("isActive", active);
        intent.putExtra("tsNanos", tsNanos);
        long ident = Binder.clearCallingIdentity();
        try {
            this.mContext.sendOrderedBroadcastAsUser(intent, UserHandle.ALL, "android.permission.RECEIVE_DATA_ACTIVITY_CHANGE", null, null, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, null, null);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private void sendStickyBroadcast(Intent intent) {
        synchronized (this) {
            if (!this.mSystemReady) {
                this.mInitialBroadcast = new Intent(intent);
            }
            intent.addFlags(67108864);
            log("sendStickyBroadcast: action=" + intent.getAction());
            long ident = Binder.clearCallingIdentity();
            if ("android.net.conn.CONNECTIVITY_CHANGE".equals(intent.getAction())) {
                try {
                    NetworkInfo ni = (NetworkInfo) intent.getParcelableExtra("networkInfo");
                    BatteryStatsService.getService().noteConnectivityChanged(intent.getIntExtra("networkType", -1), ni != null ? ni.getState().toString() : "?");
                } catch (RemoteException e) {
                }
            }
            try {
                this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    void systemReady() {
        Intent intent = new Intent(ACTION_PKT_CNT_SAMPLE_INTERVAL_ELAPSED);
        intent.setPackage(this.mContext.getPackageName());
        this.mSampleIntervalElapsedIntent = PendingIntent.getBroadcast(this.mContext, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, intent, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
        setAlarm(RESTORE_DEFAULT_NETWORK_DELAY, this.mSampleIntervalElapsedIntent);
        loadGlobalProxy();
        synchronized (this) {
            this.mSystemReady = DBG;
            if (this.mInitialBroadcast != null) {
                this.mContext.sendStickyBroadcastAsUser(this.mInitialBroadcast, UserHandle.ALL);
                this.mInitialBroadcast = null;
            }
        }
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_APPLY_GLOBAL_HTTP_PROXY));
        if (!updateLockdownVpn()) {
            this.mContext.registerReceiver(this.mUserPresentReceiver, new IntentFilter("android.intent.action.USER_PRESENT"));
        }
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_SYSTEM_READY));
        this.mPermissionMonitor.startMonitoring();
    }

    public void captivePortalCheckCompleted(NetworkInfo info, boolean isCaptivePortal) {
        enforceConnectivityInternalPermission();
        log("captivePortalCheckCompleted: ni=" + info + " captive=" + isCaptivePortal);
    }

    private void setupDataActivityTracking(NetworkAgentInfo networkAgent) {
        int timeout;
        String iface = networkAgent.linkProperties.getInterfaceName();
        int type = -1;
        if (networkAgent.networkCapabilities.hasTransport(SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE)) {
            timeout = Global.getInt(this.mContext.getContentResolver(), "data_activity_timeout_mobile", 5);
            type = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
        } else if (networkAgent.networkCapabilities.hasTransport(REDIRECTED_PROVISIONING)) {
            timeout = Global.getInt(this.mContext.getContentResolver(), "data_activity_timeout_wifi", SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
            type = REDIRECTED_PROVISIONING;
        } else {
            timeout = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
        }
        if (timeout > 0 && iface != null && type != -1) {
            try {
                this.mNetd.addIdleTimer(iface, timeout, type);
            } catch (Exception e) {
                loge("Exception in setupDataActivityTracking " + e);
            }
        }
    }

    private void removeDataActivityTracking(NetworkAgentInfo networkAgent) {
        String iface = networkAgent.linkProperties.getInterfaceName();
        NetworkCapabilities caps = networkAgent.networkCapabilities;
        if (iface == null) {
            return;
        }
        if (caps.hasTransport(SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE) || caps.hasTransport(REDIRECTED_PROVISIONING)) {
            try {
                this.mNetd.removeIdleTimer(iface);
            } catch (Exception e) {
                loge("Exception in removeDataActivityTracking " + e);
            }
        }
    }

    private void updateMtu(LinkProperties newLp, LinkProperties oldLp) {
        String iface = newLp.getInterfaceName();
        int mtu = newLp.getMtu();
        if (oldLp != null && newLp.isIdenticalMtu(oldLp)) {
            return;
        }
        if (!LinkProperties.isValidMtu(mtu, newLp.hasGlobalIPv6Address())) {
            loge("Unexpected mtu value: " + mtu + ", " + iface);
        } else if (TextUtils.isEmpty(iface)) {
            loge("Setting MTU size with null iface.");
        } else {
            try {
                log("Setting MTU size: " + iface + ", " + mtu);
                this.mNetd.setMtu(iface, mtu);
            } catch (Exception e) {
                Slog.e(TAG, "exception in setMtu()" + e);
            }
        }
    }

    private void updateTcpBufferSizes(NetworkAgentInfo nai) {
        if (isDefaultNetwork(nai)) {
            String tcpBufferSizes = nai.linkProperties.getTcpBufferSizes();
            String[] values = null;
            if (tcpBufferSizes != null) {
                values = tcpBufferSizes.split(",");
            }
            if (values == null || values.length != 6) {
                log("Invalid tcpBufferSizes string: " + tcpBufferSizes + ", using defaults");
                tcpBufferSizes = DEFAULT_TCP_BUFFER_SIZES;
                values = tcpBufferSizes.split(",");
            }
            if (!tcpBufferSizes.equals(this.mCurrentTcpBufferSizes)) {
                try {
                    Slog.d(TAG, "Setting tx/rx TCP buffers to " + tcpBufferSizes);
                    String prefix = "/sys/kernel/ipv4/tcp_";
                    FileUtils.stringToFile("/sys/kernel/ipv4/tcp_rmem_min", values[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE]);
                    FileUtils.stringToFile("/sys/kernel/ipv4/tcp_rmem_def", values[REDIRECTED_PROVISIONING]);
                    FileUtils.stringToFile("/sys/kernel/ipv4/tcp_rmem_max", values[PROVISIONING]);
                    FileUtils.stringToFile("/sys/kernel/ipv4/tcp_wmem_min", values[3]);
                    FileUtils.stringToFile("/sys/kernel/ipv4/tcp_wmem_def", values[4]);
                    FileUtils.stringToFile("/sys/kernel/ipv4/tcp_wmem_max", values[5]);
                    this.mCurrentTcpBufferSizes = tcpBufferSizes;
                } catch (IOException e) {
                    loge("Can't set TCP buffer sizes:" + e);
                }
                String defaultRwndKey = "net.tcp.default_init_rwnd";
                Integer rwndValue = Integer.valueOf(Global.getInt(this.mContext.getContentResolver(), "tcp_default_init_rwnd", SystemProperties.getInt("net.tcp.default_init_rwnd", SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE)));
                String sysctlKey = "sys.sysctl.tcp_def_init_rwnd";
                if (rwndValue.intValue() != 0) {
                    SystemProperties.set("sys.sysctl.tcp_def_init_rwnd", rwndValue.toString());
                }
            }
        }
    }

    private void flushVmDnsCache() {
        Intent intent = new Intent("android.intent.action.CLEAR_DNS_CACHE");
        intent.addFlags(536870912);
        intent.addFlags(67108864);
        long ident = Binder.clearCallingIdentity();
        try {
            this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public int getRestoreDefaultNetworkDelay(int networkType) {
        String restoreDefaultNetworkDelayStr = SystemProperties.get(NETWORK_RESTORE_DELAY_PROP_NAME);
        if (!(restoreDefaultNetworkDelayStr == null || restoreDefaultNetworkDelayStr.length() == 0)) {
            try {
                return Integer.valueOf(restoreDefaultNetworkDelayStr).intValue();
            } catch (NumberFormatException e) {
            }
        }
        if (networkType > EVENT_REGISTER_NETWORK_FACTORY || this.mNetConfigs[networkType] == null) {
            return RESTORE_DEFAULT_NETWORK_DELAY;
        }
        return this.mNetConfigs[networkType].restoreTime;
    }

    protected void dump(FileDescriptor fd, PrintWriter writer, String[] args) {
        IndentingPrintWriter pw = new IndentingPrintWriter(writer, "  ");
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump ConnectivityService from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            return;
        }
        int i;
        pw.println("NetworkFactories for:");
        pw.increaseIndent();
        for (NetworkFactoryInfo nfi : this.mNetworkFactoryInfos.values()) {
            pw.println(nfi.name);
        }
        pw.decreaseIndent();
        pw.println();
        NetworkAgentInfo defaultNai = (NetworkAgentInfo) this.mNetworkForRequestId.get(this.mDefaultRequest.requestId);
        pw.print("Active default network: ");
        if (defaultNai == null) {
            pw.println("none");
        } else {
            pw.println(defaultNai.network.netId);
        }
        pw.println();
        pw.println("Current Networks:");
        pw.increaseIndent();
        for (NetworkAgentInfo nai : this.mNetworkAgentInfos.values()) {
            pw.println(nai.toString());
            pw.increaseIndent();
            pw.println("Requests:");
            pw.increaseIndent();
            for (i = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i < nai.networkRequests.size(); i += REDIRECTED_PROVISIONING) {
                pw.println(((NetworkRequest) nai.networkRequests.valueAt(i)).toString());
            }
            pw.decreaseIndent();
            pw.println("Lingered:");
            pw.increaseIndent();
            Iterator i$ = nai.networkLingered.iterator();
            while (i$.hasNext()) {
                pw.println(((NetworkRequest) i$.next()).toString());
            }
            pw.decreaseIndent();
            pw.decreaseIndent();
        }
        pw.decreaseIndent();
        pw.println();
        pw.println("Network Requests:");
        pw.increaseIndent();
        for (NetworkRequestInfo nri : this.mNetworkRequests.values()) {
            pw.println(nri.toString());
        }
        pw.println();
        pw.decreaseIndent();
        pw.println("mLegacyTypeTracker:");
        pw.increaseIndent();
        this.mLegacyTypeTracker.dump(pw);
        pw.decreaseIndent();
        pw.println();
        synchronized (this) {
            pw.println("NetworkTransitionWakeLock is currently " + (this.mNetTransitionWakeLock.isHeld() ? "" : "not ") + "held.");
            pw.println("It was last requested for " + this.mNetTransitionWakeLockCausedBy);
        }
        pw.println();
        this.mTethering.dump(fd, pw, args);
        if (this.mInetLog != null) {
            pw.println();
            pw.println("Inet condition reports:");
            pw.increaseIndent();
            for (i = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i < this.mInetLog.size(); i += REDIRECTED_PROVISIONING) {
                pw.println(this.mInetLog.get(i));
            }
            pw.decreaseIndent();
        }
    }

    private boolean isLiveNetworkAgent(NetworkAgentInfo nai, String msg) {
        if (nai.network == null) {
            return SAMPLE_DBG;
        }
        NetworkAgentInfo officialNai = getNetworkAgentInfoForNetwork(nai.network);
        if (officialNai != null && officialNai.equals(nai)) {
            return DBG;
        }
        if (officialNai == null) {
            return SAMPLE_DBG;
        }
        loge(msg + " - isLiveNetworkAgent found mismatched netId: " + officialNai + " - " + nai);
        return SAMPLE_DBG;
    }

    private boolean isRequest(NetworkRequest request) {
        return ((NetworkRequestInfo) this.mNetworkRequests.get(request)).isRequest;
    }

    private void unlinger(NetworkAgentInfo nai) {
        if (nai.everValidated) {
            nai.networkLingered.clear();
            nai.networkMonitor.sendMessage(NetworkMonitor.CMD_NETWORK_CONNECTED);
        }
    }

    private void handleAsyncChannelHalfConnect(Message msg) {
        AsyncChannel ac = msg.obj;
        NetworkAgentInfo nai;
        if (this.mNetworkFactoryInfos.containsKey(msg.replyTo)) {
            if (msg.arg1 == 0) {
                for (NetworkRequestInfo nri : this.mNetworkRequests.values()) {
                    if (nri.isRequest) {
                        nai = (NetworkAgentInfo) this.mNetworkForRequestId.get(nri.request.requestId);
                        ac.sendMessage(536576, nai != null ? nai.getCurrentScore() : SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, nri.request);
                    }
                }
                return;
            }
            loge("Error connecting NetworkFactory");
            this.mNetworkFactoryInfos.remove(msg.obj);
        } else if (!this.mNetworkAgentInfos.containsKey(msg.replyTo)) {
        } else {
            if (msg.arg1 == 0) {
                ((NetworkAgentInfo) this.mNetworkAgentInfos.get(msg.replyTo)).asyncChannel.sendMessage(69633);
                return;
            }
            loge("Error connecting NetworkAgent");
            nai = (NetworkAgentInfo) this.mNetworkAgentInfos.remove(msg.replyTo);
            if (nai != null) {
                synchronized (this.mNetworkForNetId) {
                    this.mNetworkForNetId.remove(nai.network.netId);
                }
                this.mLegacyTypeTracker.remove(nai);
            }
        }
    }

    private void handleAsyncChannelDisconnected(Message msg) {
        NetworkAgentInfo nai = (NetworkAgentInfo) this.mNetworkAgentInfos.get(msg.replyTo);
        if (nai != null) {
            log(nai.name() + " got DISCONNECTED, was satisfying " + nai.networkRequests.size());
            if (nai.created) {
                try {
                    this.mNetd.removeNetwork(nai.network.netId);
                } catch (Exception e) {
                    loge("Exception removing network: " + e);
                }
            }
            if (nai.networkInfo.isConnected()) {
                nai.networkInfo.setDetailedState(DetailedState.DISCONNECTED, null, null);
            }
            if (isDefaultNetwork(nai)) {
                this.mDefaultInetConditionPublished = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
            }
            notifyIfacesChanged();
            notifyNetworkCallbacks(nai, 524292);
            nai.networkMonitor.sendMessage(NetworkMonitor.CMD_NETWORK_DISCONNECTED);
            this.mNetworkAgentInfos.remove(msg.replyTo);
            updateClat(null, nai.linkProperties, nai);
            this.mLegacyTypeTracker.remove(nai);
            synchronized (this.mNetworkForNetId) {
                this.mNetworkForNetId.remove(nai.network.netId);
            }
            ArrayList<NetworkAgentInfo> toActivate = new ArrayList();
            for (int i = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i < nai.networkRequests.size(); i += REDIRECTED_PROVISIONING) {
                NetworkRequest request = (NetworkRequest) nai.networkRequests.valueAt(i);
                NetworkAgentInfo currentNetwork = (NetworkAgentInfo) this.mNetworkForRequestId.get(request.requestId);
                if (currentNetwork != null && currentNetwork.network.netId == nai.network.netId) {
                    log("Checking for replacement network to handle request " + request);
                    this.mNetworkForRequestId.remove(request.requestId);
                    sendUpdatedScoreToFactories(request, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
                    NetworkAgentInfo alternative = null;
                    for (NetworkAgentInfo existing : this.mNetworkAgentInfos.values()) {
                        if (existing.satisfies(request) && (alternative == null || alternative.getCurrentScore() < existing.getCurrentScore())) {
                            alternative = existing;
                        }
                    }
                    if (alternative != null) {
                        log(" found replacement in " + alternative.name());
                        if (!toActivate.contains(alternative)) {
                            toActivate.add(alternative);
                        }
                    }
                }
            }
            if (nai.networkRequests.get(this.mDefaultRequest.requestId) != null) {
                removeDataActivityTracking(nai);
                notifyLockdownVpn(nai);
                requestNetworkTransitionWakelock(nai.name());
            }
            Iterator i$ = toActivate.iterator();
            while (i$.hasNext()) {
                NetworkAgentInfo networkToActivate = (NetworkAgentInfo) i$.next();
                unlinger(networkToActivate);
                rematchNetworkAndRequests(networkToActivate, NascentState.NOT_JUST_VALIDATED, ReapUnvalidatedNetworks.DONT_REAP);
            }
        }
        NetworkFactoryInfo nfi = (NetworkFactoryInfo) this.mNetworkFactoryInfos.remove(msg.replyTo);
        if (nfi != null) {
            log("unregisterNetworkFactory for " + nfi.name);
        }
    }

    private NetworkRequestInfo findExistingNetworkRequestInfo(PendingIntent pendingIntent) {
        Intent intent = pendingIntent.getIntent();
        for (Entry<NetworkRequest, NetworkRequestInfo> entry : this.mNetworkRequests.entrySet()) {
            PendingIntent existingPendingIntent = ((NetworkRequestInfo) entry.getValue()).mPendingIntent;
            if (existingPendingIntent != null && existingPendingIntent.getIntent().filterEquals(intent)) {
                return (NetworkRequestInfo) entry.getValue();
            }
        }
        return null;
    }

    private void handleRegisterNetworkRequestWithIntent(Message msg) {
        NetworkRequestInfo nri = (NetworkRequestInfo) msg.obj;
        NetworkRequestInfo existingRequest = findExistingNetworkRequestInfo(nri.mPendingIntent);
        if (existingRequest != null) {
            log("Replacing " + existingRequest.request + " with " + nri.request + " because their intents matched.");
            handleReleaseNetworkRequest(existingRequest.request, getCallingUid());
        }
        handleRegisterNetworkRequest(msg);
    }

    private void handleRegisterNetworkRequest(Message msg) {
        NetworkRequestInfo nri = (NetworkRequestInfo) msg.obj;
        this.mNetworkRequests.put(nri.request, nri);
        NetworkAgentInfo bestNetwork = null;
        for (NetworkAgentInfo network : this.mNetworkAgentInfos.values()) {
            log("handleRegisterNetworkRequest checking " + network.name());
            if (network.satisfies(nri.request)) {
                log("apparently satisfied.  currentScore=" + network.getCurrentScore());
                if (!nri.isRequest) {
                    network.addRequest(nri.request);
                    notifyNetworkCallback(network, nri);
                } else if (bestNetwork == null || bestNetwork.getCurrentScore() < network.getCurrentScore()) {
                    bestNetwork = network;
                }
            }
        }
        if (bestNetwork != null) {
            log("using " + bestNetwork.name());
            unlinger(bestNetwork);
            bestNetwork.addRequest(nri.request);
            this.mNetworkForRequestId.put(nri.request.requestId, bestNetwork);
            notifyNetworkCallback(bestNetwork, nri);
            if (nri.request.legacyType != -1) {
                this.mLegacyTypeTracker.add(nri.request.legacyType, bestNetwork);
            }
        }
        if (nri.isRequest) {
            log("sending new NetworkRequest to factories");
            int score = bestNetwork == null ? SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE : bestNetwork.getCurrentScore();
            for (NetworkFactoryInfo nfi : this.mNetworkFactoryInfos.values()) {
                nfi.asyncChannel.sendMessage(536576, score, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, nri.request);
            }
        }
    }

    private void handleReleaseNetworkRequestWithIntent(PendingIntent pendingIntent, int callingUid) {
        NetworkRequestInfo nri = findExistingNetworkRequestInfo(pendingIntent);
        if (nri != null) {
            handleReleaseNetworkRequest(nri.request, callingUid);
        }
    }

    private boolean unneeded(NetworkAgentInfo nai) {
        if (!nai.created || nai.isVPN()) {
            return SAMPLE_DBG;
        }
        boolean unneeded = DBG;
        if (nai.everValidated) {
            for (int i = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i < nai.networkRequests.size() && unneeded; i += REDIRECTED_PROVISIONING) {
                NetworkRequest nr = (NetworkRequest) nai.networkRequests.valueAt(i);
                try {
                    if (isRequest(nr)) {
                        unneeded = SAMPLE_DBG;
                    }
                } catch (Exception e) {
                    loge("Request " + nr + " not found in mNetworkRequests.");
                    loge("  it came from request list  of " + nai.name());
                }
            }
            return unneeded;
        }
        for (NetworkRequestInfo nri : this.mNetworkRequests.values()) {
            if (nri.isRequest && nai.satisfies(nri.request)) {
                if (nai.networkRequests.get(nri.request.requestId) != null || ((NetworkAgentInfo) this.mNetworkForRequestId.get(nri.request.requestId)).getCurrentScore() < nai.getCurrentScoreAsValidated()) {
                    return SAMPLE_DBG;
                }
            }
        }
        return DBG;
    }

    private void handleReleaseNetworkRequest(NetworkRequest request, int callingUid) {
        NetworkRequestInfo nri = (NetworkRequestInfo) this.mNetworkRequests.get(request);
        if (nri == null) {
            return;
        }
        if (ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE == callingUid || nri.mUid == callingUid) {
            log("releasing NetworkRequest " + request);
            nri.unlinkDeathRecipient();
            this.mNetworkRequests.remove(request);
            NetworkAgentInfo nai;
            if (nri.isRequest) {
                boolean wasKept = SAMPLE_DBG;
                for (NetworkAgentInfo nai2 : this.mNetworkAgentInfos.values()) {
                    if (nai2.networkRequests.get(nri.request.requestId) != null) {
                        nai2.networkRequests.remove(nri.request.requestId);
                        log(" Removing from current network " + nai2.name() + ", leaving " + nai2.networkRequests.size() + " requests.");
                        if (unneeded(nai2)) {
                            log("no live requests for " + nai2.name() + "; disconnecting");
                            teardownUnneededNetwork(nai2);
                        } else {
                            wasKept |= REDIRECTED_PROVISIONING;
                        }
                    }
                }
                nai2 = (NetworkAgentInfo) this.mNetworkForRequestId.get(nri.request.requestId);
                if (nai2 != null) {
                    this.mNetworkForRequestId.remove(nri.request.requestId);
                }
                if (!(nri.request.legacyType == -1 || nai2 == null)) {
                    boolean doRemove = DBG;
                    if (wasKept) {
                        for (int i = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i < nai2.networkRequests.size(); i += REDIRECTED_PROVISIONING) {
                            NetworkRequest otherRequest = (NetworkRequest) nai2.networkRequests.valueAt(i);
                            if (otherRequest.legacyType == nri.request.legacyType && isRequest(otherRequest)) {
                                log(" still have other legacy request - leaving");
                                doRemove = SAMPLE_DBG;
                            }
                        }
                    }
                    if (doRemove) {
                        this.mLegacyTypeTracker.remove(nri.request.legacyType, nai2);
                    }
                }
                for (NetworkFactoryInfo nfi : this.mNetworkFactoryInfos.values()) {
                    nfi.asyncChannel.sendMessage(536577, nri.request);
                }
            } else {
                for (NetworkAgentInfo nai22 : this.mNetworkAgentInfos.values()) {
                    nai22.networkRequests.remove(nri.request.requestId);
                }
            }
            callCallbackForRequest(nri, null, 524296);
            return;
        }
        log("Attempt to release unowned NetworkRequest " + request);
    }

    public List<WifiDevice> getTetherConnectedSta() {
        if (isTetheringSupported()) {
            return this.mTethering.getTetherConnectedSta();
        }
        return null;
    }

    public int tether(String iface) {
        ConnectivityManager.enforceTetherChangePermission(this.mContext);
        if (isTetheringSupported()) {
            return this.mTethering.tether(iface);
        }
        return 3;
    }

    public int untether(String iface) {
        ConnectivityManager.enforceTetherChangePermission(this.mContext);
        if (isTetheringSupported()) {
            return this.mTethering.untether(iface);
        }
        return 3;
    }

    public int getLastTetherError(String iface) {
        enforceTetherAccessPermission();
        if (isTetheringSupported()) {
            return this.mTethering.getLastTetherError(iface);
        }
        return 3;
    }

    public String[] getTetherableUsbRegexs() {
        enforceTetherAccessPermission();
        if (isTetheringSupported()) {
            return this.mTethering.getTetherableUsbRegexs();
        }
        return new String[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE];
    }

    public String[] getTetherableWifiRegexs() {
        enforceTetherAccessPermission();
        if (isTetheringSupported()) {
            return this.mTethering.getTetherableWifiRegexs();
        }
        return new String[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE];
    }

    public String[] getTetherableBluetoothRegexs() {
        enforceTetherAccessPermission();
        if (isTetheringSupported()) {
            return this.mTethering.getTetherableBluetoothRegexs();
        }
        return new String[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE];
    }

    public int setUsbTethering(boolean enable) {
        ConnectivityManager.enforceTetherChangePermission(this.mContext);
        if (isTetheringSupported()) {
            return this.mTethering.setUsbTethering(enable);
        }
        return 3;
    }

    public String[] getTetherableIfaces() {
        enforceTetherAccessPermission();
        return this.mTethering.getTetherableIfaces();
    }

    public String[] getTetheredIfaces() {
        enforceTetherAccessPermission();
        return this.mTethering.getTetheredIfaces();
    }

    public String[] getTetheringErroredIfaces() {
        enforceTetherAccessPermission();
        return this.mTethering.getErroredIfaces();
    }

    public String[] getTetheredDhcpRanges() {
        enforceConnectivityInternalPermission();
        return this.mTethering.getTetheredDhcpRanges();
    }

    public boolean isTetheringSupported() {
        int defaultVal;
        boolean tetherEnabledInSettings;
        enforceTetherAccessPermission();
        if (SystemProperties.get("ro.tether.denied").equals("true")) {
            defaultVal = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
        } else {
            defaultVal = REDIRECTED_PROVISIONING;
        }
        if (Global.getInt(this.mContext.getContentResolver(), "tether_supported", defaultVal) == 0 || this.mUserManager.hasUserRestriction("no_config_tethering")) {
            tetherEnabledInSettings = SAMPLE_DBG;
        } else {
            tetherEnabledInSettings = DBG;
        }
        if (!tetherEnabledInSettings || ((this.mTethering.getTetherableUsbRegexs().length == 0 && this.mTethering.getTetherableWifiRegexs().length == 0 && this.mTethering.getTetherableBluetoothRegexs().length == 0) || this.mTethering.getUpstreamIfaceTypes().length == 0)) {
            return SAMPLE_DBG;
        }
        return DBG;
    }

    private void requestNetworkTransitionWakelock(String forWhom) {
        int i;
        Throwable th;
        synchronized (this) {
            try {
                if (this.mNetTransitionWakeLock.isHeld()) {
                    return;
                }
                int serialNum = this.mNetTransitionWakeLockSerialNumber + REDIRECTED_PROVISIONING;
                this.mNetTransitionWakeLockSerialNumber = serialNum;
                try {
                    this.mNetTransitionWakeLock.acquire();
                    this.mNetTransitionWakeLockCausedBy = forWhom;
                    this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(EVENT_EXPIRE_NET_TRANSITION_WAKELOCK, serialNum, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE), (long) this.mNetTransitionWakeLockTimeout);
                    i = serialNum;
                } catch (Throwable th2) {
                    th = th2;
                    i = serialNum;
                    throw th;
                }
            } catch (Throwable th3) {
                th = th3;
                throw th;
            }
        }
    }

    public void reportInetCondition(int networkType, int percentage) {
        NetworkAgentInfo nai = this.mLegacyTypeTracker.getNetworkForType(networkType);
        if (nai != null) {
            boolean isGood = percentage > 50 ? DBG : SAMPLE_DBG;
            if (isGood != nai.lastValidated) {
                if (isGood) {
                    log("reportInetCondition: type=" + networkType + " ok, revalidate");
                }
                reportBadNetwork(nai.network);
            }
        }
    }

    public void reportBadNetwork(Network network) {
        enforceAccessPermission();
        enforceInternetPermission();
        if (network != null) {
            int uid = Binder.getCallingUid();
            NetworkAgentInfo nai = getNetworkAgentInfoForNetwork(network);
            if (nai != null) {
                log("reportBadNetwork(" + nai.name() + ") by " + uid);
                synchronized (nai) {
                    if (!nai.created) {
                    } else if (isNetworkWithLinkPropertiesBlocked(nai.linkProperties, uid)) {
                    } else {
                        nai.networkMonitor.sendMessage(NetworkMonitor.CMD_FORCE_REEVALUATION, uid);
                    }
                }
            }
        }
    }

    public ProxyInfo getDefaultProxy() {
        ProxyInfo ret;
        synchronized (this.mProxyLock) {
            ret = this.mGlobalProxy;
            if (ret == null && !this.mDefaultProxyDisabled) {
                ret = this.mDefaultProxy;
            }
        }
        return ret;
    }

    private ProxyInfo canonicalizeProxyInfo(ProxyInfo proxy) {
        if (proxy == null || !TextUtils.isEmpty(proxy.getHost())) {
            return proxy;
        }
        if (proxy.getPacFileUrl() == null || Uri.EMPTY.equals(proxy.getPacFileUrl())) {
            return null;
        }
        return proxy;
    }

    private boolean proxyInfoEqual(ProxyInfo a, ProxyInfo b) {
        a = canonicalizeProxyInfo(a);
        b = canonicalizeProxyInfo(b);
        return (Objects.equals(a, b) && (a == null || Objects.equals(a.getHost(), b.getHost()))) ? DBG : SAMPLE_DBG;
    }

    public void setGlobalProxy(ProxyInfo proxyProperties) {
        enforceConnectivityInternalPermission();
        synchronized (this.mProxyLock) {
            if (proxyProperties == this.mGlobalProxy) {
            } else if (proxyProperties != null && proxyProperties.equals(this.mGlobalProxy)) {
            } else if (this.mGlobalProxy == null || !this.mGlobalProxy.equals(proxyProperties)) {
                String host = "";
                int port = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
                String exclList = "";
                String pacFileUrl = "";
                if (proxyProperties == null || (TextUtils.isEmpty(proxyProperties.getHost()) && Uri.EMPTY.equals(proxyProperties.getPacFileUrl()))) {
                    this.mGlobalProxy = null;
                } else if (proxyProperties.isValid()) {
                    this.mGlobalProxy = new ProxyInfo(proxyProperties);
                    host = this.mGlobalProxy.getHost();
                    port = this.mGlobalProxy.getPort();
                    exclList = this.mGlobalProxy.getExclusionListAsString();
                    if (!Uri.EMPTY.equals(proxyProperties.getPacFileUrl())) {
                        pacFileUrl = proxyProperties.getPacFileUrl().toString();
                    }
                } else {
                    log("Invalid proxy properties, ignoring: " + proxyProperties.toString());
                    return;
                }
                ContentResolver res = this.mContext.getContentResolver();
                long token = Binder.clearCallingIdentity();
                try {
                    Global.putString(res, "global_http_proxy_host", host);
                    Global.putInt(res, "global_http_proxy_port", port);
                    Global.putString(res, "global_http_proxy_exclusion_list", exclList);
                    Global.putString(res, "global_proxy_pac_url", pacFileUrl);
                    if (this.mGlobalProxy == null) {
                        proxyProperties = this.mDefaultProxy;
                    }
                    sendProxyBroadcast(proxyProperties);
                } finally {
                    Binder.restoreCallingIdentity(token);
                }
            }
        }
    }

    private void loadGlobalProxy() {
        ContentResolver res = this.mContext.getContentResolver();
        String host = Global.getString(res, "global_http_proxy_host");
        int port = Global.getInt(res, "global_http_proxy_port", SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
        String exclList = Global.getString(res, "global_http_proxy_exclusion_list");
        String pacFileUrl = Global.getString(res, "global_proxy_pac_url");
        if (!TextUtils.isEmpty(host) || !TextUtils.isEmpty(pacFileUrl)) {
            ProxyInfo proxyProperties;
            if (TextUtils.isEmpty(pacFileUrl)) {
                proxyProperties = new ProxyInfo(host, port, exclList);
            } else {
                proxyProperties = new ProxyInfo(pacFileUrl);
            }
            if (proxyProperties.isValid()) {
                synchronized (this.mProxyLock) {
                    this.mGlobalProxy = proxyProperties;
                }
                return;
            }
            log("Invalid proxy properties, ignoring: " + proxyProperties.toString());
        }
    }

    public ProxyInfo getGlobalProxy() {
        ProxyInfo proxyInfo;
        synchronized (this.mProxyLock) {
            proxyInfo = this.mGlobalProxy;
        }
        return proxyInfo;
    }

    private void handleApplyDefaultProxy(ProxyInfo proxy) {
        if (proxy != null && TextUtils.isEmpty(proxy.getHost()) && Uri.EMPTY.equals(proxy.getPacFileUrl())) {
            proxy = null;
        }
        synchronized (this.mProxyLock) {
            if (this.mDefaultProxy != null && this.mDefaultProxy.equals(proxy)) {
            } else if (this.mDefaultProxy == proxy) {
            } else {
                if (proxy != null) {
                    if (!proxy.isValid()) {
                        log("Invalid proxy properties, ignoring: " + proxy.toString());
                        return;
                    }
                }
                if (this.mGlobalProxy == null || proxy == null || Uri.EMPTY.equals(proxy.getPacFileUrl()) || !proxy.getPacFileUrl().equals(this.mGlobalProxy.getPacFileUrl())) {
                    this.mDefaultProxy = proxy;
                    if (this.mGlobalProxy != null) {
                        return;
                    }
                    if (!this.mDefaultProxyDisabled) {
                        sendProxyBroadcast(proxy);
                    }
                    return;
                }
                this.mGlobalProxy = proxy;
                sendProxyBroadcast(this.mGlobalProxy);
            }
        }
    }

    private void updateProxy(LinkProperties newLp, LinkProperties oldLp, NetworkAgentInfo nai) {
        ProxyInfo oldProxyInfo = null;
        ProxyInfo newProxyInfo = newLp == null ? null : newLp.getHttpProxy();
        if (oldLp != null) {
            oldProxyInfo = oldLp.getHttpProxy();
        }
        if (!proxyInfoEqual(newProxyInfo, oldProxyInfo)) {
            sendProxyBroadcast(getDefaultProxy());
        }
    }

    private void handleDeprecatedGlobalHttpProxy() {
        String proxy = Global.getString(this.mContext.getContentResolver(), "http_proxy");
        if (!TextUtils.isEmpty(proxy)) {
            String[] data = proxy.split(":");
            if (data.length != 0) {
                String proxyHost = data[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE];
                int proxyPort = 8080;
                if (data.length > REDIRECTED_PROVISIONING) {
                    try {
                        proxyPort = Integer.parseInt(data[REDIRECTED_PROVISIONING]);
                    } catch (NumberFormatException e) {
                        return;
                    }
                }
                setGlobalProxy(new ProxyInfo(data[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE], proxyPort, ""));
            }
        }
    }

    private void sendProxyBroadcast(ProxyInfo proxy) {
        if (proxy == null) {
            proxy = new ProxyInfo("", SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, "");
        }
        if (!this.mPacManager.setCurrentProxyScriptUrl(proxy)) {
            log("sending Proxy Broadcast for " + proxy);
            Intent intent = new Intent("android.intent.action.PROXY_CHANGE");
            intent.addFlags(603979776);
            intent.putExtra("android.intent.extra.PROXY_INFO", proxy);
            long ident = Binder.clearCallingIdentity();
            try {
                this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    private static void log(String s) {
        Slog.d(TAG, s);
    }

    private static void loge(String s) {
        Slog.e(TAG, s);
    }

    private static <T> T checkNotNull(T value, String message) {
        if (value != null) {
            return value;
        }
        throw new NullPointerException(message);
    }

    public boolean prepareVpn(String oldPackage, String newPackage) {
        boolean prepare;
        throwIfLockdownEnabled();
        int user = UserHandle.getUserId(Binder.getCallingUid());
        synchronized (this.mVpns) {
            prepare = ((Vpn) this.mVpns.get(user)).prepare(oldPackage, newPackage);
        }
        return prepare;
    }

    public void setVpnPackageAuthorization(boolean authorized) {
        int user = UserHandle.getUserId(Binder.getCallingUid());
        synchronized (this.mVpns) {
            ((Vpn) this.mVpns.get(user)).setPackageAuthorization(authorized);
        }
    }

    public ParcelFileDescriptor establishVpn(VpnConfig config) {
        ParcelFileDescriptor establish;
        throwIfLockdownEnabled();
        int user = UserHandle.getUserId(Binder.getCallingUid());
        synchronized (this.mVpns) {
            establish = ((Vpn) this.mVpns.get(user)).establish(config);
        }
        return establish;
    }

    public void startLegacyVpn(VpnProfile profile) {
        throwIfLockdownEnabled();
        LinkProperties egress = getActiveLinkProperties();
        if (egress == null) {
            throw new IllegalStateException("Missing active network connection");
        }
        int user = UserHandle.getUserId(Binder.getCallingUid());
        synchronized (this.mVpns) {
            ((Vpn) this.mVpns.get(user)).startLegacyVpn(profile, this.mKeyStore, egress);
        }
    }

    public LegacyVpnInfo getLegacyVpnInfo() {
        LegacyVpnInfo legacyVpnInfo;
        throwIfLockdownEnabled();
        int user = UserHandle.getUserId(Binder.getCallingUid());
        synchronized (this.mVpns) {
            legacyVpnInfo = ((Vpn) this.mVpns.get(user)).getLegacyVpnInfo();
        }
        return legacyVpnInfo;
    }

    public VpnConfig getVpnConfig() {
        VpnConfig vpnConfig;
        int user = UserHandle.getUserId(Binder.getCallingUid());
        synchronized (this.mVpns) {
            vpnConfig = ((Vpn) this.mVpns.get(user)).getVpnConfig();
        }
        return vpnConfig;
    }

    public boolean updateLockdownVpn() {
        if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            Slog.w(TAG, "Lockdown VPN only available to AID_SYSTEM");
            return SAMPLE_DBG;
        }
        this.mLockdownEnabled = LockdownVpnTracker.isEnabled();
        if (!this.mLockdownEnabled) {
            setLockdownTracker(null);
        } else if (this.mKeyStore.isUnlocked()) {
            String profileName = new String(this.mKeyStore.get("LOCKDOWN_VPN"));
            VpnProfile profile = VpnProfile.decode(profileName, this.mKeyStore.get("VPN_" + profileName));
            int user = UserHandle.getUserId(Binder.getCallingUid());
            synchronized (this.mVpns) {
                setLockdownTracker(new LockdownVpnTracker(this.mContext, this.mNetd, this, (Vpn) this.mVpns.get(user), profile));
            }
        } else {
            Slog.w(TAG, "KeyStore locked; unable to create LockdownTracker");
            return SAMPLE_DBG;
        }
        return DBG;
    }

    private void setLockdownTracker(LockdownVpnTracker tracker) {
        LockdownVpnTracker existing = this.mLockdownTracker;
        this.mLockdownTracker = null;
        if (existing != null) {
            existing.shutdown();
        }
        if (tracker != null) {
            try {
                this.mNetd.setFirewallEnabled(DBG);
                this.mNetd.setFirewallInterfaceRule("lo", DBG);
                this.mLockdownTracker = tracker;
                this.mLockdownTracker.init();
                return;
            } catch (RemoteException e) {
                return;
            }
        }
        this.mNetd.setFirewallEnabled(SAMPLE_DBG);
    }

    private void throwIfLockdownEnabled() {
        if (this.mLockdownEnabled) {
            throw new IllegalStateException("Unavailable in lockdown mode");
        }
    }

    public void supplyMessenger(int networkType, Messenger messenger) {
        enforceConnectivityInternalPermission();
        if (ConnectivityManager.isNetworkTypeValid(networkType) && this.mNetTrackers[networkType] != null) {
            this.mNetTrackers[networkType].supplyMessenger(messenger);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public int findConnectionTypeForIface(java.lang.String r7) {
        /*
        r6 = this;
        r3 = -1;
        r6.enforceConnectivityInternalPermission();
        r4 = android.text.TextUtils.isEmpty(r7);
        if (r4 == 0) goto L_0x000b;
    L_0x000a:
        return r3;
    L_0x000b:
        r4 = r6.mNetworkForNetId;
        monitor-enter(r4);
        r0 = 0;
    L_0x000f:
        r5 = r6.mNetworkForNetId;	 Catch:{ all -> 0x0039 }
        r5 = r5.size();	 Catch:{ all -> 0x0039 }
        if (r0 >= r5) goto L_0x003f;
    L_0x0017:
        r5 = r6.mNetworkForNetId;	 Catch:{ all -> 0x0039 }
        r2 = r5.valueAt(r0);	 Catch:{ all -> 0x0039 }
        r2 = (com.android.server.connectivity.NetworkAgentInfo) r2;	 Catch:{ all -> 0x0039 }
        r1 = r2.linkProperties;	 Catch:{ all -> 0x0039 }
        if (r1 == 0) goto L_0x003c;
    L_0x0023:
        r5 = r1.getInterfaceName();	 Catch:{ all -> 0x0039 }
        r5 = r7.equals(r5);	 Catch:{ all -> 0x0039 }
        if (r5 == 0) goto L_0x003c;
    L_0x002d:
        r5 = r2.networkInfo;	 Catch:{ all -> 0x0039 }
        if (r5 == 0) goto L_0x003c;
    L_0x0031:
        r3 = r2.networkInfo;	 Catch:{ all -> 0x0039 }
        r3 = r3.getType();	 Catch:{ all -> 0x0039 }
        monitor-exit(r4);	 Catch:{ all -> 0x0039 }
        goto L_0x000a;
    L_0x0039:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0039 }
        throw r3;
    L_0x003c:
        r0 = r0 + 1;
        goto L_0x000f;
    L_0x003f:
        monitor-exit(r4);	 Catch:{ all -> 0x0039 }
        goto L_0x000a;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.ConnectivityService.findConnectionTypeForIface(java.lang.String):int");
    }

    private void setEnableFailFastMobileData(int enabled) {
        int tag;
        if (enabled == REDIRECTED_PROVISIONING) {
            tag = this.mEnableFailFastMobileDataTag.incrementAndGet();
        } else {
            tag = this.mEnableFailFastMobileDataTag.get();
        }
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_ENABLE_FAIL_FAST_MOBILE_DATA, tag, enabled));
    }

    public int checkMobileProvisioning(int suggestedTimeOutMs) {
        return -1;
    }

    private void setProvNotificationVisible(boolean visible, int networkType, String action) {
        log("setProvNotificationVisible: E visible=" + visible + " networkType=" + networkType + " action=" + action);
        int id = 65536 + (networkType + REDIRECTED_PROVISIONING);
        setProvNotificationVisibleIntent(visible, id, networkType, null, PendingIntent.getBroadcast(this.mContext, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, new Intent(action), SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE));
    }

    private void setProvNotificationVisibleIntent(boolean visible, int id, int networkType, String extraInfo, PendingIntent intent) {
        log("setProvNotificationVisibleIntent: E visible=" + visible + " networkType=" + networkType + " extraInfo=" + extraInfo);
        Resources r = Resources.getSystem();
        NotificationManager notificationManager = (NotificationManager) this.mContext.getSystemService("notification");
        if (visible) {
            CharSequence title;
            CharSequence details;
            int icon;
            Notification notification = new Notification();
            Object[] objArr;
            switch (networkType) {
                case SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE /*0*/:
                case C0569H.ADD_STARTING /*5*/:
                    objArr = new Object[REDIRECTED_PROVISIONING];
                    objArr[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE] = Integer.valueOf(SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
                    title = r.getString(17040582, objArr);
                    details = this.mTelephonyManager.getNetworkOperatorName();
                    icon = 17303117;
                    break;
                case REDIRECTED_PROVISIONING /*1*/:
                    objArr = new Object[REDIRECTED_PROVISIONING];
                    objArr[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE] = Integer.valueOf(SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
                    title = r.getString(17040581, objArr);
                    objArr = new Object[REDIRECTED_PROVISIONING];
                    objArr[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE] = extraInfo;
                    details = r.getString(17040583, objArr);
                    icon = 17303121;
                    break;
                default:
                    objArr = new Object[REDIRECTED_PROVISIONING];
                    objArr[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE] = Integer.valueOf(SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
                    title = r.getString(17040582, objArr);
                    objArr = new Object[REDIRECTED_PROVISIONING];
                    objArr[SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE] = extraInfo;
                    details = r.getString(17040583, objArr);
                    icon = 17303117;
                    break;
            }
            notification.when = 0;
            notification.icon = icon;
            notification.flags = EVENT_PROXY_HAS_CHANGED;
            notification.tickerText = title;
            notification.color = this.mContext.getResources().getColor(17170521);
            notification.setLatestEventInfo(this.mContext, title, details, notification.contentIntent);
            notification.contentIntent = intent;
            try {
                notificationManager.notify(NOTIFICATION_ID, id, notification);
            } catch (NullPointerException npe) {
                loge("setNotificaitionVisible: visible notificationManager npe=" + npe);
                npe.printStackTrace();
            }
        } else {
            try {
                notificationManager.cancel(NOTIFICATION_ID, id);
            } catch (NullPointerException npe2) {
                loge("setNotificaitionVisible: cancel notificationManager npe=" + npe2);
                npe2.printStackTrace();
            }
        }
        this.mIsNotificationVisible = visible;
    }

    private String getProvisioningUrlBaseFromFile(int type) {
        String tagType;
        XmlPullParserException e;
        IOException e2;
        Throwable th;
        String str = null;
        FileReader fileReader = null;
        Configuration config = this.mContext.getResources().getConfiguration();
        switch (type) {
            case REDIRECTED_PROVISIONING /*1*/:
                tagType = TAG_REDIRECTED_URL;
                break;
            case PROVISIONING /*2*/:
                tagType = TAG_PROVISIONING_URL;
                break;
            default:
                throw new RuntimeException("getProvisioningUrlBaseFromFile: Unexpected parameter " + type);
        }
        try {
            FileReader fileReader2 = new FileReader(this.mProvisioningUrlFile);
            try {
                XmlPullParser parser = Xml.newPullParser();
                parser.setInput(fileReader2);
                XmlUtils.beginDocument(parser, TAG_PROVISIONING_URLS);
                while (true) {
                    XmlUtils.nextElement(parser);
                    String element = parser.getName();
                    if (element == null) {
                        if (fileReader2 != null) {
                            try {
                                fileReader2.close();
                            } catch (IOException e3) {
                            }
                        }
                        fileReader = fileReader2;
                    } else if (element.equals(tagType)) {
                        String mcc = parser.getAttributeValue(null, ATTR_MCC);
                        if (mcc != null) {
                            try {
                                if (Integer.parseInt(mcc) == config.mcc) {
                                    String mnc = parser.getAttributeValue(null, ATTR_MNC);
                                    if (mnc != null && Integer.parseInt(mnc) == config.mnc) {
                                        parser.next();
                                        if (parser.getEventType() == 4) {
                                            str = parser.getText();
                                            if (fileReader2 != null) {
                                                try {
                                                    fileReader2.close();
                                                } catch (IOException e4) {
                                                }
                                            }
                                            fileReader = fileReader2;
                                        }
                                    }
                                } else {
                                    continue;
                                }
                            } catch (NumberFormatException e5) {
                                loge("NumberFormatException in getProvisioningUrlBaseFromFile: " + e5);
                            }
                        } else {
                            continue;
                        }
                    }
                    return str;
                }
            } catch (FileNotFoundException e6) {
                fileReader = fileReader2;
            } catch (XmlPullParserException e7) {
                e = e7;
                fileReader = fileReader2;
            } catch (IOException e8) {
                e2 = e8;
                fileReader = fileReader2;
            } catch (Throwable th2) {
                th = th2;
                fileReader = fileReader2;
            }
        } catch (FileNotFoundException e9) {
            try {
                loge("Carrier Provisioning Urls file not found");
                if (fileReader != null) {
                    try {
                        fileReader.close();
                    } catch (IOException e10) {
                    }
                }
                return str;
            } catch (Throwable th3) {
                th = th3;
                if (fileReader != null) {
                    try {
                        fileReader.close();
                    } catch (IOException e11) {
                    }
                }
                throw th;
            }
        } catch (XmlPullParserException e12) {
            e = e12;
            loge("Xml parser exception reading Carrier Provisioning Urls file: " + e);
            if (fileReader != null) {
                try {
                    fileReader.close();
                } catch (IOException e13) {
                }
            }
            return str;
        } catch (IOException e14) {
            e2 = e14;
            loge("I/O exception reading Carrier Provisioning Urls file: " + e2);
            if (fileReader != null) {
                try {
                    fileReader.close();
                } catch (IOException e15) {
                }
            }
            return str;
        }
    }

    public String getMobileRedirectedProvisioningUrl() {
        enforceConnectivityInternalPermission();
        String url = getProvisioningUrlBaseFromFile(REDIRECTED_PROVISIONING);
        if (TextUtils.isEmpty(url)) {
            return this.mContext.getResources().getString(17039407);
        }
        return url;
    }

    public String getMobileProvisioningUrl() {
        enforceConnectivityInternalPermission();
        String url = getProvisioningUrlBaseFromFile(PROVISIONING);
        if (TextUtils.isEmpty(url)) {
            url = this.mContext.getResources().getString(17039406);
            log("getMobileProvisioningUrl: mobile_provisioining_url from resource =" + url);
        } else {
            log("getMobileProvisioningUrl: mobile_provisioning_url from File =" + url);
        }
        if (TextUtils.isEmpty(url)) {
            return url;
        }
        String phoneNumber = this.mTelephonyManager.getLine1Number();
        if (TextUtils.isEmpty(phoneNumber)) {
            phoneNumber = "0000000000";
        }
        return String.format(url, new Object[]{this.mTelephonyManager.getSimSerialNumber(), this.mTelephonyManager.getDeviceId(), phoneNumber});
    }

    public void setProvisioningNotificationVisible(boolean visible, int networkType, String action) {
        enforceConnectivityInternalPermission();
        long ident = Binder.clearCallingIdentity();
        try {
            setProvNotificationVisible(visible, networkType, action);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void setAirplaneMode(boolean enable) {
        enforceConnectivityInternalPermission();
        long ident = Binder.clearCallingIdentity();
        try {
            Global.putInt(this.mContext.getContentResolver(), "airplane_mode_on", enable ? REDIRECTED_PROVISIONING : SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
            Intent intent = new Intent("android.intent.action.AIRPLANE_MODE");
            intent.putExtra("state", enable);
            this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private void onUserStart(int userId) {
        synchronized (this.mVpns) {
            if (((Vpn) this.mVpns.get(userId)) != null) {
                loge("Starting user already has a VPN");
                return;
            }
            this.mVpns.put(userId, new Vpn(this.mHandler.getLooper(), this.mContext, this.mNetd, this, userId));
        }
    }

    private void onUserStop(int userId) {
        synchronized (this.mVpns) {
            if (((Vpn) this.mVpns.get(userId)) == null) {
                loge("Stopping user has no VPN");
                return;
            }
            this.mVpns.delete(userId);
        }
    }

    private void handleNetworkSamplingTimeout() {
        int i$;
        Map<String, SamplingSnapshot> mapIfaceToSample = new HashMap();
        NetworkStateTracker[] arr$ = this.mNetTrackers;
        int len$ = arr$.length;
        for (i$ = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i$ < len$; i$ += REDIRECTED_PROVISIONING) {
            NetworkStateTracker tracker = arr$[i$];
            if (tracker != null) {
                String ifaceName = tracker.getNetworkInterfaceName();
                if (ifaceName != null) {
                    mapIfaceToSample.put(ifaceName, null);
                }
            }
        }
        SamplingDataTracker.getSamplingSnapshots(mapIfaceToSample);
        arr$ = this.mNetTrackers;
        len$ = arr$.length;
        for (i$ = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i$ < len$; i$ += REDIRECTED_PROVISIONING) {
            tracker = arr$[i$];
            if (tracker != null) {
                SamplingSnapshot ss = (SamplingSnapshot) mapIfaceToSample.get(tracker.getNetworkInterfaceName());
                if (ss != null) {
                    tracker.stopSampling(ss);
                    tracker.startSampling(ss);
                }
            }
        }
        setAlarm(Global.getInt(this.mContext.getContentResolver(), "connectivity_sampling_interval_in_seconds", DEFAULT_SAMPLING_INTERVAL_IN_SECONDS) * ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, this.mSampleIntervalElapsedIntent);
    }

    void setAlarm(int timeoutInMilliseconds, PendingIntent intent) {
        int alarmType;
        long wakeupTime = SystemClock.elapsedRealtime() + ((long) timeoutInMilliseconds);
        if (Resources.getSystem().getBoolean(17957002)) {
            alarmType = PROVISIONING;
        } else {
            alarmType = 3;
        }
        this.mAlarmManager.set(alarmType, wakeupTime, intent);
    }

    public NetworkRequest requestNetwork(NetworkCapabilities networkCapabilities, Messenger messenger, int timeoutMs, IBinder binder, int legacyType) {
        NetworkCapabilities networkCapabilities2 = new NetworkCapabilities(networkCapabilities);
        enforceNetworkRequestPermissions(networkCapabilities2);
        enforceMeteredApnPolicy(networkCapabilities2);
        if (timeoutMs < 0 || timeoutMs > 6000000) {
            throw new IllegalArgumentException("Bad timeout specified");
        }
        NetworkRequest networkRequest = new NetworkRequest(networkCapabilities2, legacyType, nextNetworkRequestId());
        log("requestNetwork for " + networkRequest);
        NetworkRequestInfo nri = new NetworkRequestInfo(messenger, networkRequest, binder, DBG);
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_REGISTER_NETWORK_REQUEST, nri));
        if (timeoutMs > 0) {
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(EVENT_TIMEOUT_NETWORK_REQUEST, nri), (long) timeoutMs);
        }
        return networkRequest;
    }

    private void enforceNetworkRequestPermissions(NetworkCapabilities networkCapabilities) {
        if (networkCapabilities.hasCapability(13)) {
            enforceChangePermission();
        } else {
            enforceConnectivityInternalPermission();
        }
    }

    private void enforceMeteredApnPolicy(NetworkCapabilities networkCapabilities) {
        if (!networkCapabilities.hasCapability(EVENT_SEND_STICKY_BROADCAST_INTENT)) {
            int uidRules;
            int uid = Binder.getCallingUid();
            synchronized (this.mRulesLock) {
                uidRules = this.mUidRules.get(uid, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE);
            }
            if ((uidRules & REDIRECTED_PROVISIONING) != 0) {
                networkCapabilities.addCapability(EVENT_SEND_STICKY_BROADCAST_INTENT);
            }
        }
    }

    public NetworkRequest pendingRequestForNetwork(NetworkCapabilities networkCapabilities, PendingIntent operation) {
        checkNotNull(operation, "PendingIntent cannot be null.");
        NetworkCapabilities networkCapabilities2 = new NetworkCapabilities(networkCapabilities);
        enforceNetworkRequestPermissions(networkCapabilities2);
        enforceMeteredApnPolicy(networkCapabilities2);
        NetworkRequest networkRequest = new NetworkRequest(networkCapabilities2, -1, nextNetworkRequestId());
        log("pendingRequest for " + networkRequest + " to trigger " + operation);
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_REGISTER_NETWORK_REQUEST_WITH_INTENT, new NetworkRequestInfo(networkRequest, operation, DBG)));
        return networkRequest;
    }

    private void releasePendingNetworkRequestWithDelay(PendingIntent operation) {
        this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(EVENT_RELEASE_NETWORK_REQUEST_WITH_INTENT, getCallingUid(), SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, operation), (long) this.mReleasePendingIntentDelayMs);
    }

    public void releasePendingNetworkRequest(PendingIntent operation) {
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_RELEASE_NETWORK_REQUEST_WITH_INTENT, getCallingUid(), SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, operation));
    }

    public NetworkRequest listenForNetwork(NetworkCapabilities networkCapabilities, Messenger messenger, IBinder binder) {
        enforceAccessPermission();
        NetworkRequest networkRequest = new NetworkRequest(new NetworkCapabilities(networkCapabilities), -1, nextNetworkRequestId());
        log("listenForNetwork for " + networkRequest);
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_REGISTER_NETWORK_LISTENER, new NetworkRequestInfo(messenger, networkRequest, binder, SAMPLE_DBG)));
        return networkRequest;
    }

    public void pendingListenForNetwork(NetworkCapabilities networkCapabilities, PendingIntent operation) {
    }

    public void releaseNetworkRequest(NetworkRequest networkRequest) {
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_RELEASE_NETWORK_REQUEST, getCallingUid(), SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, networkRequest));
    }

    public void registerNetworkFactory(Messenger messenger, String name) {
        enforceConnectivityInternalPermission();
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_REGISTER_NETWORK_FACTORY, new NetworkFactoryInfo(name, messenger, new AsyncChannel())));
    }

    private void handleRegisterNetworkFactory(NetworkFactoryInfo nfi) {
        log("Got NetworkFactory Messenger for " + nfi.name);
        this.mNetworkFactoryInfos.put(nfi.messenger, nfi);
        nfi.asyncChannel.connect(this.mContext, this.mTrackerHandler, nfi.messenger);
    }

    public void unregisterNetworkFactory(Messenger messenger) {
        enforceConnectivityInternalPermission();
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_UNREGISTER_NETWORK_FACTORY, messenger));
    }

    private void handleUnregisterNetworkFactory(Messenger messenger) {
        NetworkFactoryInfo nfi = (NetworkFactoryInfo) this.mNetworkFactoryInfos.remove(messenger);
        if (nfi == null) {
            loge("Failed to find Messenger in unregisterNetworkFactory");
        } else {
            log("unregisterNetworkFactory for " + nfi.name);
        }
    }

    private NetworkAgentInfo getDefaultNetwork() {
        return (NetworkAgentInfo) this.mNetworkForRequestId.get(this.mDefaultRequest.requestId);
    }

    private boolean isDefaultNetwork(NetworkAgentInfo nai) {
        return nai == getDefaultNetwork() ? DBG : SAMPLE_DBG;
    }

    public void registerNetworkAgent(Messenger messenger, NetworkInfo networkInfo, LinkProperties linkProperties, NetworkCapabilities networkCapabilities, int currentScore, NetworkMisc networkMisc) {
        enforceConnectivityInternalPermission();
        NetworkAgentInfo nai = new NetworkAgentInfo(messenger, new AsyncChannel(), new NetworkInfo(networkInfo), new LinkProperties(linkProperties), new NetworkCapabilities(networkCapabilities), currentScore, this.mContext, this.mTrackerHandler, new NetworkMisc(networkMisc), this.mDefaultRequest);
        synchronized (this) {
            nai.networkMonitor.systemReady = this.mSystemReady;
        }
        log("registerNetworkAgent " + nai);
        this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_REGISTER_NETWORK_AGENT, nai));
    }

    private void handleRegisterNetworkAgent(NetworkAgentInfo na) {
        this.mNetworkAgentInfos.put(na.messenger, na);
        assignNextNetId(na);
        na.asyncChannel.connect(this.mContext, this.mTrackerHandler, na.messenger);
        NetworkInfo networkInfo = na.networkInfo;
        na.networkInfo = null;
        updateNetworkInfo(na, networkInfo);
    }

    private void updateLinkProperties(NetworkAgentInfo networkAgent, LinkProperties oldLp) {
        LinkProperties newLp = networkAgent.linkProperties;
        int netId = networkAgent.network.netId;
        if (networkAgent.clatd != null) {
            networkAgent.clatd.fixupLinkProperties(oldLp);
        }
        updateInterfaces(newLp, oldLp, netId);
        updateMtu(newLp, oldLp);
        updateTcpBufferSizes(networkAgent);
        LinkProperties linkProperties = oldLp;
        updateDnses(newLp, linkProperties, netId, updateRoutes(newLp, oldLp, netId), networkAgent.networkCapabilities.hasCapability(12));
        updateClat(newLp, oldLp, networkAgent);
        if (isDefaultNetwork(networkAgent)) {
            handleApplyDefaultProxy(newLp.getHttpProxy());
        } else {
            updateProxy(newLp, oldLp, networkAgent);
        }
        if (!Objects.equals(newLp, oldLp)) {
            notifyIfacesChanged();
            notifyNetworkCallbacks(networkAgent, 524295);
        }
    }

    private void updateClat(LinkProperties newLp, LinkProperties oldLp, NetworkAgentInfo nai) {
        boolean wasRunningClat = (nai.clatd == null || !nai.clatd.isStarted()) ? SAMPLE_DBG : DBG;
        boolean shouldRunClat = Nat464Xlat.requiresClat(nai);
        if (!wasRunningClat && shouldRunClat) {
            nai.clatd = new Nat464Xlat(this.mContext, this.mNetd, this.mTrackerHandler, nai);
            nai.clatd.start();
        } else if (wasRunningClat && !shouldRunClat) {
            nai.clatd.stop();
        }
    }

    private void updateInterfaces(LinkProperties newLp, LinkProperties oldLp, int netId) {
        CompareResult<String> interfaceDiff = new CompareResult();
        if (oldLp != null) {
            interfaceDiff = oldLp.compareAllInterfaceNames(newLp);
        } else if (newLp != null) {
            interfaceDiff.added = newLp.getAllInterfaceNames();
        }
        for (String iface : interfaceDiff.added) {
            try {
                log("Adding iface " + iface + " to network " + netId);
                this.mNetd.addInterfaceToNetwork(iface, netId);
            } catch (Exception e) {
                loge("Exception adding interface: " + e);
            }
        }
        for (String iface2 : interfaceDiff.removed) {
            try {
                log("Removing iface " + iface2 + " from network " + netId);
                this.mNetd.removeInterfaceFromNetwork(iface2, netId);
            } catch (Exception e2) {
                loge("Exception removing interface: " + e2);
            }
        }
    }

    private boolean updateRoutes(LinkProperties newLp, LinkProperties oldLp, int netId) {
        CompareResult<RouteInfo> routeDiff = new CompareResult();
        if (oldLp != null) {
            routeDiff = oldLp.compareAllRoutes(newLp);
        } else if (newLp != null) {
            routeDiff.added = newLp.getAllRoutes();
        }
        for (RouteInfo route : routeDiff.added) {
            if (!route.hasGateway()) {
                log("Adding Route [" + route + "] to network " + netId);
                try {
                    this.mNetd.addRoute(netId, route);
                } catch (Exception e) {
                    if (route.getDestination().getAddress() instanceof Inet4Address) {
                        loge("Exception in addRoute for non-gateway: " + e);
                    }
                }
            }
        }
        for (RouteInfo route2 : routeDiff.added) {
            if (route2.hasGateway()) {
                log("Adding Route [" + route2 + "] to network " + netId);
                try {
                    this.mNetd.addRoute(netId, route2);
                } catch (Exception e2) {
                    if (route2.getGateway() instanceof Inet4Address) {
                        loge("Exception in addRoute for gateway: " + e2);
                    }
                }
            }
        }
        for (RouteInfo route22 : routeDiff.removed) {
            log("Removing Route [" + route22 + "] from network " + netId);
            try {
                this.mNetd.removeRoute(netId, route22);
            } catch (Exception e22) {
                loge("Exception in removeRoute: " + e22);
            }
        }
        return (routeDiff.added.isEmpty() && routeDiff.removed.isEmpty()) ? SAMPLE_DBG : DBG;
    }

    private void updateDnses(LinkProperties newLp, LinkProperties oldLp, int netId, boolean flush, boolean useDefaultDns) {
        if (oldLp == null || !newLp.isIdenticalDnses(oldLp)) {
            Collection<InetAddress> dnses = newLp.getDnsServers();
            if (dnses.size() == 0 && this.mDefaultDns != null && useDefaultDns) {
                dnses = new ArrayList();
                dnses.add(this.mDefaultDns);
                loge("no dns provided for netId " + netId + ", so using defaults");
            }
            log("Setting Dns servers for network " + netId + " to " + dnses);
            try {
                this.mNetd.setDnsServersForNetwork(netId, NetworkUtils.makeStrings(dnses), newLp.getDomains());
            } catch (Exception e) {
                loge("Exception in setDnsServersForNetwork: " + e);
            }
            NetworkAgentInfo defaultNai = (NetworkAgentInfo) this.mNetworkForRequestId.get(this.mDefaultRequest.requestId);
            if (defaultNai != null && defaultNai.network.netId == netId) {
                setDefaultDnsSystemProperties(dnses);
            }
            flushVmDnsCache();
        } else if (flush) {
            try {
                this.mNetd.flushNetworkDnsCache(netId);
            } catch (Exception e2) {
                loge("Exception in flushNetworkDnsCache: " + e2);
            }
            flushVmDnsCache();
        }
    }

    private void setDefaultDnsSystemProperties(Collection<InetAddress> dnses) {
        int last = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
        for (InetAddress dns : dnses) {
            last += REDIRECTED_PROVISIONING;
            SystemProperties.set("net.dns" + last, dns.getHostAddress());
        }
        for (int i = last + REDIRECTED_PROVISIONING; i <= this.mNumDnsEntries; i += REDIRECTED_PROVISIONING) {
            SystemProperties.set("net.dns" + i, "");
        }
        this.mNumDnsEntries = last;
    }

    private void updateCapabilities(NetworkAgentInfo networkAgent, NetworkCapabilities networkCapabilities) {
        if (!Objects.equals(networkAgent.networkCapabilities, networkCapabilities)) {
            synchronized (networkAgent) {
                networkAgent.networkCapabilities = networkCapabilities;
            }
            rematchAllNetworksAndRequests(networkAgent, networkAgent.getCurrentScore());
            notifyNetworkCallbacks(networkAgent, 524294);
        }
    }

    private void sendUpdatedScoreToFactories(NetworkAgentInfo nai) {
        for (int i = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i < nai.networkRequests.size(); i += REDIRECTED_PROVISIONING) {
            NetworkRequest nr = (NetworkRequest) nai.networkRequests.valueAt(i);
            if (isRequest(nr)) {
                sendUpdatedScoreToFactories(nr, nai.getCurrentScore());
            }
        }
    }

    private void sendUpdatedScoreToFactories(NetworkRequest networkRequest, int score) {
        for (NetworkFactoryInfo nfi : this.mNetworkFactoryInfos.values()) {
            nfi.asyncChannel.sendMessage(536576, score, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, networkRequest);
        }
    }

    private void sendPendingIntentForRequest(NetworkRequestInfo nri, NetworkAgentInfo networkAgent, int notificationType) {
        if (notificationType == 524290 && !nri.mPendingIntentSent) {
            Intent intent = new Intent();
            intent.putExtra("android.net.extra.NETWORK", networkAgent.network);
            intent.putExtra("android.net.extra.NETWORK_REQUEST", nri.request);
            nri.mPendingIntentSent = DBG;
            sendIntent(nri.mPendingIntent, intent);
        }
    }

    private void sendIntent(PendingIntent pendingIntent, Intent intent) {
        this.mPendingIntentWakeLock.acquire();
        try {
            log("Sending " + pendingIntent);
            pendingIntent.send(this.mContext, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE, intent, this, null);
        } catch (CanceledException e) {
            log(pendingIntent + " was not sent, it had been canceled.");
            this.mPendingIntentWakeLock.release();
            releasePendingNetworkRequest(pendingIntent);
        }
    }

    public void onSendFinished(PendingIntent pendingIntent, Intent intent, int resultCode, String resultData, Bundle resultExtras) {
        log("Finished sending " + pendingIntent);
        this.mPendingIntentWakeLock.release();
        releasePendingNetworkRequestWithDelay(pendingIntent);
    }

    private void callCallbackForRequest(NetworkRequestInfo nri, NetworkAgentInfo networkAgent, int notificationType) {
        if (nri.messenger != null) {
            Bundle bundle = new Bundle();
            bundle.putParcelable(NetworkRequest.class.getSimpleName(), new NetworkRequest(nri.request));
            Message msg = Message.obtain();
            if (!(notificationType == 524293 || notificationType == 524296)) {
                bundle.putParcelable(Network.class.getSimpleName(), networkAgent.network);
            }
            switch (notificationType) {
                case 524291:
                    msg.arg1 = 30000;
                    break;
                case 524294:
                    bundle.putParcelable(NetworkCapabilities.class.getSimpleName(), new NetworkCapabilities(networkAgent.networkCapabilities));
                    break;
                case 524295:
                    bundle.putParcelable(LinkProperties.class.getSimpleName(), new LinkProperties(networkAgent.linkProperties));
                    break;
            }
            msg.what = notificationType;
            msg.setData(bundle);
            try {
                nri.messenger.send(msg);
            } catch (RemoteException e) {
                loge("RemoteException caught trying to send a callback msg for " + nri.request);
            }
        }
    }

    private void teardownUnneededNetwork(NetworkAgentInfo nai) {
        for (int i = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i < nai.networkRequests.size(); i += REDIRECTED_PROVISIONING) {
            NetworkRequest nr = (NetworkRequest) nai.networkRequests.valueAt(i);
            if (isRequest(nr)) {
                loge("Dead network still had at least " + nr);
                break;
            }
        }
        nai.asyncChannel.disconnect();
    }

    private void handleLingerComplete(NetworkAgentInfo oldNetwork) {
        if (oldNetwork == null) {
            loge("Unknown NetworkAgentInfo in handleLingerComplete");
            return;
        }
        log("handleLingerComplete for " + oldNetwork.name());
        teardownUnneededNetwork(oldNetwork);
    }

    private void makeDefault(NetworkAgentInfo newNetwork) {
        log("Switching to new default network: " + newNetwork);
        setupDataActivityTracking(newNetwork);
        try {
            this.mNetd.setDefaultNetId(newNetwork.network.netId);
        } catch (Exception e) {
            loge("Exception setting default network :" + e);
        }
        notifyLockdownVpn(newNetwork);
        handleApplyDefaultProxy(newNetwork.linkProperties.getHttpProxy());
        updateTcpBufferSizes(newNetwork);
        setDefaultDnsSystemProperties(newNetwork.linkProperties.getDnsServers());
    }

    private void rematchNetworkAndRequests(NetworkAgentInfo newNetwork, NascentState nascent, ReapUnvalidatedNetworks reapUnvalidatedNetworks) {
        if (newNetwork.created) {
            NetworkAgentInfo nai;
            if (nascent == NascentState.JUST_VALIDATED && !newNetwork.everValidated) {
                loge("ERROR: nascent network not validated.");
            }
            boolean keep = newNetwork.isVPN();
            boolean isNewDefault = SAMPLE_DBG;
            NetworkAgentInfo oldDefaultNetwork = null;
            log("rematching " + newNetwork.name());
            ArrayList<NetworkAgentInfo> affectedNetworks = new ArrayList();
            for (NetworkRequestInfo nri : this.mNetworkRequests.values()) {
                NetworkAgentInfo currentNetwork = (NetworkAgentInfo) this.mNetworkForRequestId.get(nri.request.requestId);
                if (newNetwork == currentNetwork) {
                    log("Network " + newNetwork.name() + " was already satisfying" + " request " + nri.request.requestId + ". No change.");
                    keep = DBG;
                } else {
                    if (newNetwork.satisfies(nri.request)) {
                        if (!nri.isRequest) {
                            newNetwork.addRequest(nri.request);
                        } else if (currentNetwork == null || currentNetwork.getCurrentScore() < newNetwork.getCurrentScore()) {
                            if (currentNetwork != null) {
                                log("   accepting network in place of " + currentNetwork.name());
                                currentNetwork.networkRequests.remove(nri.request.requestId);
                                currentNetwork.networkLingered.add(nri.request);
                                affectedNetworks.add(currentNetwork);
                            } else {
                                log("   accepting network in place of null");
                            }
                            unlinger(newNetwork);
                            this.mNetworkForRequestId.put(nri.request.requestId, newNetwork);
                            newNetwork.addRequest(nri.request);
                            keep = DBG;
                            sendUpdatedScoreToFactories(nri.request, newNetwork.getCurrentScore());
                            if (this.mDefaultRequest.requestId == nri.request.requestId) {
                                isNewDefault = DBG;
                                oldDefaultNetwork = currentNetwork;
                            }
                        }
                    }
                }
            }
            Iterator i$ = affectedNetworks.iterator();
            while (i$.hasNext()) {
                nai = (NetworkAgentInfo) i$.next();
                if (nai.everValidated && unneeded(nai)) {
                    nai.networkMonitor.sendMessage(NetworkMonitor.CMD_NETWORK_LINGER);
                    notifyNetworkCallbacks(nai, 524291);
                } else {
                    unlinger(nai);
                }
            }
            if (keep) {
                if (isNewDefault) {
                    makeDefault(newNetwork);
                    synchronized (this) {
                        if (this.mNetTransitionWakeLock.isHeld()) {
                            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(EVENT_CLEAR_NET_TRANSITION_WAKELOCK, this.mNetTransitionWakeLockSerialNumber, SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE), 1000);
                        }
                    }
                }
                notifyNetworkCallbacks(newNetwork, 524290);
                if (isNewDefault) {
                    if (oldDefaultNetwork != null) {
                        this.mLegacyTypeTracker.remove(oldDefaultNetwork.networkInfo.getType(), oldDefaultNetwork);
                    }
                    this.mDefaultInetConditionPublished = newNetwork.everValidated ? MIN_NET_ID : SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
                    this.mLegacyTypeTracker.add(newNetwork.networkInfo.getType(), newNetwork);
                    notifyLockdownVpn(newNetwork);
                }
                try {
                    IBatteryStats bs = BatteryStatsService.getService();
                    int type = newNetwork.networkInfo.getType();
                    String baseIface = newNetwork.linkProperties.getInterfaceName();
                    bs.noteNetworkInterfaceType(baseIface, type);
                    for (LinkProperties stacked : newNetwork.linkProperties.getStackedLinks()) {
                        String stackedIface = stacked.getInterfaceName();
                        bs.noteNetworkInterfaceType(stackedIface, type);
                        NetworkStatsFactory.noteStackedIface(stackedIface, baseIface);
                    }
                } catch (RemoteException e) {
                }
                int i = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
                while (true) {
                    if (i >= newNetwork.networkRequests.size()) {
                        break;
                    }
                    NetworkRequest nr = (NetworkRequest) newNetwork.networkRequests.valueAt(i);
                    int i2 = nr.legacyType;
                    if (r0 != -1 && isRequest(nr)) {
                        this.mLegacyTypeTracker.add(nr.legacyType, newNetwork);
                    }
                    i += REDIRECTED_PROVISIONING;
                }
                if (newNetwork.isVPN()) {
                    this.mLegacyTypeTracker.add(EVENT_REGISTER_NETWORK_FACTORY, newNetwork);
                }
            } else if (nascent == NascentState.JUST_VALIDATED) {
                log("Validated network turns out to be unwanted.  Tear it down.");
                teardownUnneededNetwork(newNetwork);
            }
            if (reapUnvalidatedNetworks == ReapUnvalidatedNetworks.REAP) {
                for (NetworkAgentInfo nai2 : this.mNetworkAgentInfos.values()) {
                    if (!nai2.everValidated && unneeded(nai2)) {
                        log("Reaping " + nai2.name());
                        teardownUnneededNetwork(nai2);
                    }
                }
            }
        }
    }

    private void rematchAllNetworksAndRequests(NetworkAgentInfo changed, int oldScore) {
        if (changed == null || oldScore >= changed.getCurrentScore()) {
            Iterator i = this.mNetworkAgentInfos.values().iterator();
            while (i.hasNext()) {
                rematchNetworkAndRequests((NetworkAgentInfo) i.next(), NascentState.NOT_JUST_VALIDATED, i.hasNext() ? ReapUnvalidatedNetworks.DONT_REAP : ReapUnvalidatedNetworks.REAP);
            }
            return;
        }
        rematchNetworkAndRequests(changed, NascentState.NOT_JUST_VALIDATED, ReapUnvalidatedNetworks.REAP);
    }

    private void updateInetCondition(NetworkAgentInfo nai) {
        if (nai.everValidated && isDefaultNetwork(nai)) {
            int newInetCondition = nai.lastValidated ? MIN_NET_ID : SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
            if (newInetCondition != this.mDefaultInetConditionPublished) {
                this.mDefaultInetConditionPublished = newInetCondition;
                sendInetConditionBroadcast(nai.networkInfo);
            }
        }
    }

    private void notifyLockdownVpn(NetworkAgentInfo nai) {
        if (this.mLockdownTracker == null) {
            return;
        }
        if (nai == null || !nai.isVPN()) {
            this.mLockdownTracker.onNetworkInfoChanged();
        } else {
            this.mLockdownTracker.onVpnStateChanged(nai.networkInfo);
        }
    }

    private void updateNetworkInfo(NetworkAgentInfo networkAgent, NetworkInfo newInfo) {
        State state = newInfo.getState();
        synchronized (networkAgent) {
            NetworkInfo oldInfo = networkAgent.networkInfo;
            networkAgent.networkInfo = newInfo;
        }
        notifyLockdownVpn(networkAgent);
        if (oldInfo == null || oldInfo.getState() != state) {
            log(networkAgent.name() + " EVENT_NETWORK_INFO_CHANGED, going from " + (oldInfo == null ? "null" : oldInfo.getState()) + " to " + state);
            if (state == State.CONNECTED && !networkAgent.created) {
                try {
                    if (networkAgent.isVPN()) {
                        boolean z;
                        boolean z2;
                        INetworkManagementService iNetworkManagementService = this.mNetd;
                        int i = networkAgent.network.netId;
                        if (networkAgent.linkProperties.getDnsServers().isEmpty()) {
                            z = SAMPLE_DBG;
                        } else {
                            z = DBG;
                        }
                        if (networkAgent.networkMisc == null || !networkAgent.networkMisc.allowBypass) {
                            z2 = DBG;
                        } else {
                            z2 = SAMPLE_DBG;
                        }
                        iNetworkManagementService.createVirtualNetwork(i, z, z2);
                    } else {
                        this.mNetd.createPhysicalNetwork(networkAgent.network.netId);
                    }
                    networkAgent.created = DBG;
                    updateLinkProperties(networkAgent, null);
                    notifyIfacesChanged();
                    notifyNetworkCallbacks(networkAgent, 524289);
                    networkAgent.networkMonitor.sendMessage(NetworkMonitor.CMD_NETWORK_CONNECTED);
                    if (networkAgent.isVPN()) {
                        synchronized (this.mProxyLock) {
                            if (!this.mDefaultProxyDisabled) {
                                this.mDefaultProxyDisabled = DBG;
                                if (this.mGlobalProxy == null && this.mDefaultProxy != null) {
                                    sendProxyBroadcast(null);
                                }
                            }
                        }
                    }
                    rematchNetworkAndRequests(networkAgent, NascentState.NOT_JUST_VALIDATED, ReapUnvalidatedNetworks.REAP);
                } catch (Exception e) {
                    loge("Error creating network " + networkAgent.network.netId + ": " + e.getMessage());
                }
            } else if (state == State.DISCONNECTED || state == State.SUSPENDED) {
                networkAgent.asyncChannel.disconnect();
                if (networkAgent.isVPN()) {
                    synchronized (this.mProxyLock) {
                        if (this.mDefaultProxyDisabled) {
                            this.mDefaultProxyDisabled = SAMPLE_DBG;
                            if (this.mGlobalProxy == null && this.mDefaultProxy != null) {
                                sendProxyBroadcast(this.mDefaultProxy);
                            }
                        }
                    }
                }
            }
        }
    }

    private void updateNetworkScore(NetworkAgentInfo nai, int score) {
        log("updateNetworkScore for " + nai.name() + " to " + score);
        if (score < 0) {
            loge("updateNetworkScore for " + nai.name() + " got a negative score (" + score + ").  Bumping score to min of 0");
            score = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE;
        }
        int oldScore = nai.getCurrentScore();
        nai.setCurrentScore(score);
        rematchAllNetworksAndRequests(nai, oldScore);
        sendUpdatedScoreToFactories(nai);
    }

    protected void notifyNetworkCallback(NetworkAgentInfo nai, NetworkRequestInfo nri) {
        if (nri.mPendingIntent == null) {
            callCallbackForRequest(nri, nai, 524290);
        } else {
            sendPendingIntentForRequest(nri, nai, 524290);
        }
    }

    private void sendLegacyNetworkBroadcast(NetworkAgentInfo nai, boolean connected, int type) {
        NetworkInfo info = new NetworkInfo(nai.networkInfo);
        info.setType(type);
        if (connected) {
            info.setDetailedState(DetailedState.CONNECTED, null, info.getExtraInfo());
            sendConnectedBroadcast(info);
            return;
        }
        info.setDetailedState(DetailedState.DISCONNECTED, null, info.getExtraInfo());
        Intent intent = new Intent("android.net.conn.CONNECTIVITY_CHANGE");
        intent.putExtra("networkInfo", info);
        intent.putExtra("networkType", info.getType());
        if (info.isFailover()) {
            intent.putExtra("isFailover", DBG);
            nai.networkInfo.setFailover(SAMPLE_DBG);
        }
        if (info.getReason() != null) {
            intent.putExtra("reason", info.getReason());
        }
        if (info.getExtraInfo() != null) {
            intent.putExtra("extraInfo", info.getExtraInfo());
        }
        NetworkAgentInfo newDefaultAgent = null;
        if (nai.networkRequests.get(this.mDefaultRequest.requestId) != null) {
            newDefaultAgent = (NetworkAgentInfo) this.mNetworkForRequestId.get(this.mDefaultRequest.requestId);
            if (newDefaultAgent != null) {
                intent.putExtra("otherNetwork", newDefaultAgent.networkInfo);
            } else {
                intent.putExtra("noConnectivity", DBG);
            }
        }
        intent.putExtra("inetCondition", this.mDefaultInetConditionPublished);
        Intent immediateIntent = new Intent(intent);
        immediateIntent.setAction("android.net.conn.CONNECTIVITY_CHANGE_IMMEDIATE");
        sendStickyBroadcast(immediateIntent);
        sendStickyBroadcast(intent);
        if (newDefaultAgent != null) {
            sendConnectedBroadcast(newDefaultAgent.networkInfo);
        }
    }

    protected void notifyNetworkCallbacks(NetworkAgentInfo networkAgent, int notifyType) {
        log("notifyType " + notifyTypeToName(notifyType) + " for " + networkAgent.name());
        for (int i = SAMPLE_INTERVAL_ELAPSED_REQUEST_CODE; i < networkAgent.networkRequests.size(); i += REDIRECTED_PROVISIONING) {
            NetworkRequestInfo nri = (NetworkRequestInfo) this.mNetworkRequests.get((NetworkRequest) networkAgent.networkRequests.valueAt(i));
            if (nri.mPendingIntent == null) {
                callCallbackForRequest(nri, networkAgent, notifyType);
            } else {
                sendPendingIntentForRequest(nri, networkAgent, notifyType);
            }
        }
    }

    private String notifyTypeToName(int notifyType) {
        switch (notifyType) {
            case 524289:
                return "PRECHECK";
            case 524290:
                return "AVAILABLE";
            case 524291:
                return "LOSING";
            case 524292:
                return "LOST";
            case 524293:
                return "UNAVAILABLE";
            case 524294:
                return "CAP_CHANGED";
            case 524295:
                return "IP_CHANGED";
            case 524296:
                return "RELEASED";
            default:
                return "UNKNOWN";
        }
    }

    private void notifyIfacesChanged() {
        try {
            this.mStatsService.forceUpdateIfaces();
        } catch (Exception e) {
        }
    }

    public boolean addVpnAddress(String address, int prefixLength) {
        boolean addAddress;
        throwIfLockdownEnabled();
        int user = UserHandle.getUserId(Binder.getCallingUid());
        synchronized (this.mVpns) {
            addAddress = ((Vpn) this.mVpns.get(user)).addAddress(address, prefixLength);
        }
        return addAddress;
    }

    public boolean removeVpnAddress(String address, int prefixLength) {
        boolean removeAddress;
        throwIfLockdownEnabled();
        int user = UserHandle.getUserId(Binder.getCallingUid());
        synchronized (this.mVpns) {
            removeAddress = ((Vpn) this.mVpns.get(user)).removeAddress(address, prefixLength);
        }
        return removeAddress;
    }

    public boolean setUnderlyingNetworksForVpn(Network[] networks) {
        boolean underlyingNetworks;
        throwIfLockdownEnabled();
        int user = UserHandle.getUserId(Binder.getCallingUid());
        synchronized (this.mVpns) {
            underlyingNetworks = ((Vpn) this.mVpns.get(user)).setUnderlyingNetworks(networks);
        }
        return underlyingNetworks;
    }
}
