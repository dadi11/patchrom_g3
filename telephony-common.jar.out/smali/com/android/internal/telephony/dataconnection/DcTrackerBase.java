package com.android.internal.telephony.dataconnection;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.ContentObserver;
import android.net.ConnectivityManager;
import android.net.LinkProperties;
import android.net.NetworkCapabilities;
import android.net.NetworkInfo;
import android.net.TrafficStats;
import android.os.AsyncResult;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Message;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.preference.PreferenceManager;
import android.provider.Settings.Global;
import android.provider.Settings.SettingNotFoundException;
import android.provider.Settings.System;
import android.telephony.Rlog;
import android.telephony.SubscriptionManager;
import android.telephony.SubscriptionManager.OnSubscriptionsChangedListener;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.EventLog;
import com.android.internal.telephony.DctConstants.Activity;
import com.android.internal.telephony.DctConstants.State;
import com.android.internal.telephony.EventLogTags;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.PhoneBase;
import com.android.internal.telephony.PhoneConstants;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.UiccController;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.AsyncChannel;
import com.google.android.mms.pdu.CharacterSets;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.PriorityQueue;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

public abstract class DcTrackerBase extends Handler {
    protected static final int APN_DELAY_DEFAULT_MILLIS = 20000;
    protected static final int APN_FAIL_FAST_DELAY_DEFAULT_MILLIS = 3000;
    protected static final String APN_RESTORE_DELAY_PROP_NAME = "android.telephony.apn-restore";
    protected static final int DATA_CONNECTION_ACTIVE_PH_LINK_DOWN = 1;
    protected static final int DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE = 0;
    protected static final int DATA_CONNECTION_ACTIVE_PH_LINK_UP = 2;
    protected static final int DATA_STALL_ALARM_AGGRESSIVE_DELAY_IN_MS_DEFAULT = 60000;
    protected static final int DATA_STALL_ALARM_NON_AGGRESSIVE_DELAY_IN_MS_DEFAULT = 360000;
    protected static final String DATA_STALL_ALARM_TAG_EXTRA = "data.stall.alram.tag";
    protected static final boolean DATA_STALL_NOT_SUSPECTED = false;
    protected static final int DATA_STALL_NO_RECV_POLL_LIMIT = 1;
    protected static final boolean DATA_STALL_SUSPECTED = true;
    protected static final boolean DBG = true;
    protected static final String DEBUG_PROV_APN_ALARM = "persist.debug.prov_apn_alarm";
    protected static final String DEFALUT_DATA_ON_BOOT_PROP = "net.def_data_on_boot";
    protected static final String DEFAULT_DATA_RETRY_CONFIG = "default_randomization=2000,5000,10000,20000,40000,80000:5000,160000:5000,320000:5000,640000:5000,1280000:5000,1800000:5000";
    protected static final int DEFAULT_MAX_PDP_RESET_FAIL = 3;
    private static final int DEFAULT_MDC_INITIAL_RETRY = 1;
    protected static final String INTENT_DATA_STALL_ALARM = "com.android.internal.telephony.data-stall";
    protected static final String INTENT_PROVISIONING_APN_ALARM = "com.android.internal.telephony.provisioning_apn_alarm";
    protected static final String INTENT_RECONNECT_ALARM = "com.android.internal.telephony.data-reconnect";
    protected static final String INTENT_RECONNECT_ALARM_EXTRA_REASON = "reconnect_alarm_extra_reason";
    protected static final String INTENT_RECONNECT_ALARM_EXTRA_TYPE = "reconnect_alarm_extra_type";
    protected static final String INTENT_RESTART_TRYSETUP_ALARM = "com.android.internal.telephony.data-restart-trysetup";
    protected static final String INTENT_RESTART_TRYSETUP_ALARM_EXTRA_TYPE = "restart_trysetup_alarm_extra_type";
    protected static final int NO_RECV_POLL_LIMIT = 24;
    protected static final String NULL_IP = "0.0.0.0";
    protected static final int NUMBER_SENT_PACKETS_OF_HANG = 10;
    protected static final int POLL_LONGEST_RTT = 120000;
    protected static final int POLL_NETSTAT_MILLIS = 1000;
    protected static final int POLL_NETSTAT_SCREEN_OFF_MILLIS = 600000;
    protected static final int POLL_NETSTAT_SLOW_MILLIS = 5000;
    protected static final int PROVISIONING_APN_ALARM_DELAY_IN_MS_DEFAULT = 900000;
    protected static final String PROVISIONING_APN_ALARM_TAG_EXTRA = "provisioning.apn.alarm.tag";
    protected static final boolean RADIO_TESTS = false;
    protected static final int RESTORE_DEFAULT_APN_DELAY = 60000;
    protected static final String SECONDARY_DATA_RETRY_CONFIG = "max_retries=3, 5000, 5000, 5000";
    protected static final boolean VDBG = false;
    protected static final boolean VDBG_STALL = true;
    static boolean mIsCleanupRequired;
    protected static int sEnableFailFastRefCounter;
    protected static boolean sPolicyDataEnabled;
    protected String RADIO_RESET_PROPERTY;
    protected ApnSetting mActiveApn;
    protected Activity mActivity;
    AlarmManager mAlarmManager;
    protected ArrayList<ApnSetting> mAllApnSettings;
    protected final ConcurrentHashMap<String, ApnContext> mApnContexts;
    protected HashMap<String, Integer> mApnToDataConnectionId;
    protected boolean mAutoAttachOnCreation;
    protected boolean mAutoAttachOnCreationConfig;
    protected int mCidActive;
    ConnectivityManager mCm;
    protected HashMap<Integer, DcAsyncChannel> mDataConnectionAcHashMap;
    protected Handler mDataConnectionTracker;
    protected HashMap<Integer, DataConnection> mDataConnections;
    private boolean[] mDataEnabled;
    protected Object mDataEnabledLock;
    private DataRoamingSettingObserver mDataRoamingSettingObserver;
    protected PendingIntent mDataStallAlarmIntent;
    protected int mDataStallAlarmTag;
    protected volatile boolean mDataStallDetectionEnabled;
    protected TxRxSum mDataStallTxRxSum;
    protected DcTesterFailBringUpAll mDcTesterFailBringUpAll;
    protected DcController mDcc;
    protected ApnSetting mEmergencyApn;
    private int mEnabledCount;
    protected volatile boolean mFailFast;
    protected AtomicReference<IccRecords> mIccRecords;
    protected boolean mInVoiceCall;
    protected BroadcastReceiver mIntentReceiver;
    protected boolean mInternalDataEnabled;
    protected boolean mIsDisposed;
    protected boolean mIsProvisioning;
    protected boolean mIsPsRestricted;
    protected boolean mIsScreenOn;
    protected boolean mIsWifiConnected;
    protected boolean mNetStatPollEnabled;
    protected int mNetStatPollPeriod;
    protected int mNoRecvPollCount;
    private final OnSubscriptionsChangedListener mOnSubscriptionsChangedListener;
    protected PhoneBase mPhone;
    private Runnable mPollNetStat;
    protected ApnSetting mPreferredApn;
    protected final PriorityQueue<ApnContext> mPrioritySortedApnContexts;
    protected PendingIntent mProvisioningApnAlarmIntent;
    protected int mProvisioningApnAlarmTag;
    protected String mProvisioningUrl;
    protected PendingIntent mReconnectIntent;
    protected AsyncChannel mReplyAc;
    protected String mRequestedApnType;
    protected ContentResolver mResolver;
    protected long mRxPkts;
    protected long mSentSinceLastRecv;
    protected State mState;
    private SubscriptionManager mSubscriptionManager;
    protected long mTxPkts;
    protected UiccController mUiccController;
    protected AtomicInteger mUniqueIdGenerator;
    protected boolean mUserDataEnabled;

    /* renamed from: com.android.internal.telephony.dataconnection.DcTrackerBase.1 */
    class C00581 implements Comparator<ApnContext> {
        C00581() {
        }

        public int compare(ApnContext c1, ApnContext c2) {
            return c2.priority - c1.priority;
        }
    }

    /* renamed from: com.android.internal.telephony.dataconnection.DcTrackerBase.2 */
    class C00592 extends BroadcastReceiver {
        C00592() {
        }

        public void onReceive(Context context, Intent intent) {
            boolean z = DcTrackerBase.VDBG_STALL;
            String action = intent.getAction();
            DcTrackerBase.this.log("onReceive: action=" + action);
            if (action.equals("android.intent.action.SCREEN_ON")) {
                DcTrackerBase.this.mIsScreenOn = DcTrackerBase.VDBG_STALL;
                DcTrackerBase.this.stopNetStatPoll();
                DcTrackerBase.this.startNetStatPoll();
                DcTrackerBase.this.restartDataStallAlarm();
            } else if (action.equals("android.intent.action.SCREEN_OFF")) {
                DcTrackerBase.this.mIsScreenOn = DcTrackerBase.VDBG;
                DcTrackerBase.this.stopNetStatPoll();
                DcTrackerBase.this.startNetStatPoll();
                DcTrackerBase.this.restartDataStallAlarm();
            } else if (action.startsWith(DcTrackerBase.INTENT_RECONNECT_ALARM)) {
                DcTrackerBase.this.log("Reconnect alarm. Previous state was " + DcTrackerBase.this.mState);
                DcTrackerBase.this.onActionIntentReconnectAlarm(intent);
            } else if (action.startsWith(DcTrackerBase.INTENT_RESTART_TRYSETUP_ALARM)) {
                DcTrackerBase.this.log("Restart trySetup alarm");
                DcTrackerBase.this.onActionIntentRestartTrySetupAlarm(intent);
            } else if (action.equals(DcTrackerBase.INTENT_DATA_STALL_ALARM)) {
                DcTrackerBase.this.onActionIntentDataStallAlarm(intent);
            } else if (action.equals(DcTrackerBase.INTENT_PROVISIONING_APN_ALARM)) {
                DcTrackerBase.this.onActionIntentProvisioningApnAlarm(intent);
            } else if (action.equals("android.net.wifi.STATE_CHANGE")) {
                NetworkInfo networkInfo = (NetworkInfo) intent.getParcelableExtra("networkInfo");
                DcTrackerBase dcTrackerBase = DcTrackerBase.this;
                if (networkInfo == null || !networkInfo.isConnected()) {
                    z = DcTrackerBase.VDBG;
                }
                dcTrackerBase.mIsWifiConnected = z;
                DcTrackerBase.this.log("NETWORK_STATE_CHANGED_ACTION: mIsWifiConnected=" + DcTrackerBase.this.mIsWifiConnected);
            } else if (action.equals("android.net.wifi.WIFI_STATE_CHANGED")) {
                boolean enabled;
                if (intent.getIntExtra("wifi_state", 4) == DcTrackerBase.DEFAULT_MAX_PDP_RESET_FAIL) {
                    enabled = DcTrackerBase.VDBG_STALL;
                } else {
                    enabled = DcTrackerBase.VDBG;
                }
                if (!enabled) {
                    DcTrackerBase.this.mIsWifiConnected = DcTrackerBase.VDBG;
                }
                DcTrackerBase.this.log("WIFI_STATE_CHANGED_ACTION: enabled=" + enabled + " mIsWifiConnected=" + DcTrackerBase.this.mIsWifiConnected);
            }
        }
    }

    /* renamed from: com.android.internal.telephony.dataconnection.DcTrackerBase.3 */
    class C00603 implements Runnable {
        C00603() {
        }

        public void run() {
            DcTrackerBase.this.updateDataActivity();
            if (DcTrackerBase.this.mIsScreenOn) {
                DcTrackerBase.this.mNetStatPollPeriod = Global.getInt(DcTrackerBase.this.mResolver, "pdp_watchdog_poll_interval_ms", DcTrackerBase.POLL_NETSTAT_MILLIS);
            } else {
                DcTrackerBase.this.mNetStatPollPeriod = Global.getInt(DcTrackerBase.this.mResolver, "pdp_watchdog_long_poll_interval_ms", DcTrackerBase.POLL_NETSTAT_SCREEN_OFF_MILLIS);
            }
            if (DcTrackerBase.this.mNetStatPollEnabled) {
                DcTrackerBase.this.mDataConnectionTracker.postDelayed(this, (long) DcTrackerBase.this.mNetStatPollPeriod);
            }
        }
    }

    /* renamed from: com.android.internal.telephony.dataconnection.DcTrackerBase.4 */
    class C00614 extends OnSubscriptionsChangedListener {
        C00614() {
        }

        public void onSubscriptionsChanged() {
            DcTrackerBase.this.log("SubscriptionListener.onSubscriptionInfoChanged");
            if (SubscriptionManager.isValidSubscriptionId(DcTrackerBase.this.mPhone.getSubId())) {
                if (DcTrackerBase.this.mDataRoamingSettingObserver != null) {
                    DcTrackerBase.this.mDataRoamingSettingObserver.unregister();
                }
                DcTrackerBase.this.mDataRoamingSettingObserver = new DataRoamingSettingObserver(DcTrackerBase.this.mPhone, DcTrackerBase.this.mPhone.getContext());
                DcTrackerBase.this.mDataRoamingSettingObserver.register();
            }
        }
    }

    /* renamed from: com.android.internal.telephony.dataconnection.DcTrackerBase.5 */
    static /* synthetic */ class C00625 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$DctConstants$State;

        static {
            $SwitchMap$com$android$internal$telephony$DctConstants$State = new int[State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.IDLE.ordinal()] = DcTrackerBase.DEFAULT_MDC_INITIAL_RETRY;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.RETRYING.ordinal()] = DcTrackerBase.DATA_CONNECTION_ACTIVE_PH_LINK_UP;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.CONNECTING.ordinal()] = DcTrackerBase.DEFAULT_MAX_PDP_RESET_FAIL;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.SCANNING.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.CONNECTED.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.DISCONNECTING.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
        }
    }

    private class DataRoamingSettingObserver extends ContentObserver {
        public DataRoamingSettingObserver(Handler handler, Context context) {
            super(handler);
            DcTrackerBase.this.mResolver = context.getContentResolver();
        }

        public void register() {
            String contentUri;
            if (TelephonyManager.getDefault().getSimCount() == DcTrackerBase.DEFAULT_MDC_INITIAL_RETRY) {
                contentUri = "data_roaming";
            } else {
                contentUri = "data_roaming" + DcTrackerBase.this.mPhone.getSubId();
            }
            DcTrackerBase.this.mResolver.registerContentObserver(Global.getUriFor(contentUri), DcTrackerBase.VDBG, this);
        }

        public void unregister() {
            DcTrackerBase.this.mResolver.unregisterContentObserver(this);
        }

        public void onChange(boolean selfChange) {
            if (DcTrackerBase.this.mPhone.getServiceState().getDataRoaming()) {
                DcTrackerBase.this.sendMessage(DcTrackerBase.this.obtainMessage(270347));
            }
        }
    }

    protected static class RecoveryAction {
        public static final int CLEANUP = 1;
        public static final int GET_DATA_CALL_LIST = 0;
        public static final int RADIO_RESTART = 3;
        public static final int RADIO_RESTART_WITH_PROP = 4;
        public static final int REREGISTER = 2;

        protected RecoveryAction() {
        }

        private static boolean isAggressiveRecovery(int value) {
            return (value == CLEANUP || value == REREGISTER || value == RADIO_RESTART || value == RADIO_RESTART_WITH_PROP) ? DcTrackerBase.VDBG_STALL : DcTrackerBase.VDBG;
        }
    }

    public class TxRxSum {
        public long rxPkts;
        public long txPkts;

        public TxRxSum() {
            reset();
        }

        public TxRxSum(long txPkts, long rxPkts) {
            this.txPkts = txPkts;
            this.rxPkts = rxPkts;
        }

        public TxRxSum(TxRxSum sum) {
            this.txPkts = sum.txPkts;
            this.rxPkts = sum.rxPkts;
        }

        public void reset() {
            this.txPkts = -1;
            this.rxPkts = -1;
        }

        public String toString() {
            return "{txSum=" + this.txPkts + " rxSum=" + this.rxPkts + "}";
        }

        public void updateTxRxSum() {
            this.txPkts = TrafficStats.getMobileTcpTxPackets();
            this.rxPkts = TrafficStats.getMobileTcpRxPackets();
        }
    }

    protected abstract void completeConnection(ApnContext apnContext);

    protected abstract State getOverallState();

    public abstract String[] getPcscfAddress(String str);

    public abstract State getState(String str);

    protected abstract void gotoIdleAndNotifyDataConnection(String str);

    protected abstract boolean isApnTypeAvailable(String str);

    protected abstract boolean isDataAllowed();

    public abstract boolean isDataPossible(String str);

    public abstract boolean isDisconnected();

    protected abstract boolean isPermanentFail(DcFailCause dcFailCause);

    protected abstract boolean isProvisioningApn(String str);

    protected abstract void log(String str);

    protected abstract void loge(String str);

    protected abstract boolean mvnoMatches(IccRecords iccRecords, String str, String str2);

    protected abstract void onCleanUpAllConnections(String str);

    protected abstract void onCleanUpConnection(boolean z, int i, String str);

    protected abstract void onDataSetupComplete(AsyncResult asyncResult);

    protected abstract void onDataSetupCompleteError(AsyncResult asyncResult);

    protected abstract void onDisconnectDcRetrying(int i, AsyncResult asyncResult);

    protected abstract void onDisconnectDone(int i, AsyncResult asyncResult);

    protected abstract void onRadioAvailable();

    protected abstract void onRadioOffOrNotAvailable();

    protected abstract void onRoamingOff();

    protected abstract void onRoamingOn();

    protected abstract boolean onTrySetupData(String str);

    protected abstract void onUpdateIcc();

    protected abstract void onVoiceCallEnded();

    protected abstract void onVoiceCallStarted();

    protected abstract void restartRadio();

    public abstract void setDataAllowed(boolean z, Message message);

    public abstract void setImsRegistrationState(boolean z);

    protected abstract void setState(State state);

    static {
        mIsCleanupRequired = VDBG;
        sPolicyDataEnabled = VDBG_STALL;
        sEnableFailFastRefCounter = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
    }

    protected int getInitialMaxRetry() {
        if (this.mFailFast) {
            return DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        }
        return Global.getInt(this.mResolver, "mdc_initial_max_retry", SystemProperties.getInt("mdc_initial_max_retry", DEFAULT_MDC_INITIAL_RETRY));
    }

    protected void onActionIntentReconnectAlarm(Intent intent) {
        String reason = intent.getStringExtra(INTENT_RECONNECT_ALARM_EXTRA_REASON);
        String apnType = intent.getStringExtra(INTENT_RECONNECT_ALARM_EXTRA_TYPE);
        int phoneSubId = this.mPhone.getSubId();
        int currSubId = intent.getIntExtra("subscription", -1);
        log("onActionIntentReconnectAlarm: currSubId = " + currSubId + " phoneSubId=" + phoneSubId);
        if (SubscriptionManager.isValidSubscriptionId(currSubId) && currSubId == phoneSubId) {
            ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnType);
            log("onActionIntentReconnectAlarm: mState=" + this.mState + " reason=" + reason + " apnType=" + apnType + " apnContext=" + apnContext + " mDataConnectionAsyncChannels=" + this.mDataConnectionAcHashMap);
            if (apnContext != null && apnContext.isEnabled()) {
                apnContext.setReason(reason);
                State apnContextState = apnContext.getState();
                log("onActionIntentReconnectAlarm: apnContext state=" + apnContextState);
                if (apnContextState == State.FAILED || apnContextState == State.IDLE) {
                    log("onActionIntentReconnectAlarm: state is FAILED|IDLE, disassociate");
                    DcAsyncChannel dcac = apnContext.getDcAc();
                    if (dcac != null) {
                        log("onActionIntentReconnectAlarm: tearDown apnContext=" + apnContext);
                        dcac.tearDown(apnContext, "", null);
                    }
                    apnContext.setDataConnectionAc(null);
                    apnContext.setState(State.IDLE);
                } else {
                    log("onActionIntentReconnectAlarm: keep associated");
                }
                sendMessage(obtainMessage(270339, apnContext));
                apnContext.setReconnectIntent(null);
                return;
            }
            return;
        }
        log("receive ReconnectAlarm but subId incorrect, ignore");
    }

    protected void onActionIntentRestartTrySetupAlarm(Intent intent) {
        String apnType = intent.getStringExtra(INTENT_RESTART_TRYSETUP_ALARM_EXTRA_TYPE);
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnType);
        log("onActionIntentRestartTrySetupAlarm: mState=" + this.mState + " apnType=" + apnType + " apnContext=" + apnContext + " mDataConnectionAsyncChannels=" + this.mDataConnectionAcHashMap);
        sendMessage(obtainMessage(270339, apnContext));
    }

    protected void onActionIntentDataStallAlarm(Intent intent) {
        log("onActionIntentDataStallAlarm: action=" + intent.getAction());
        Message msg = obtainMessage(270353, intent.getAction());
        msg.arg1 = intent.getIntExtra(DATA_STALL_ALARM_TAG_EXTRA, DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE);
        sendMessage(msg);
    }

    protected DcTrackerBase(PhoneBase phone) {
        this.mDataEnabledLock = new Object();
        this.mInternalDataEnabled = VDBG_STALL;
        this.mUserDataEnabled = VDBG_STALL;
        this.mDataEnabled = new boolean[NUMBER_SENT_PACKETS_OF_HANG];
        this.mEnabledCount = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        this.mRequestedApnType = "default";
        this.RADIO_RESET_PROPERTY = "gsm.radioreset";
        this.mIccRecords = new AtomicReference();
        this.mActivity = Activity.NONE;
        this.mState = State.IDLE;
        this.mDataConnectionTracker = null;
        this.mNetStatPollEnabled = VDBG;
        this.mDataStallTxRxSum = new TxRxSum(0, 0);
        this.mDataStallAlarmTag = (int) SystemClock.elapsedRealtime();
        this.mDataStallAlarmIntent = null;
        this.mNoRecvPollCount = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        this.mDataStallDetectionEnabled = VDBG_STALL;
        this.mFailFast = VDBG;
        this.mInVoiceCall = VDBG;
        this.mIsWifiConnected = VDBG;
        this.mReconnectIntent = null;
        this.mAutoAttachOnCreationConfig = VDBG;
        this.mAutoAttachOnCreation = VDBG;
        this.mIsScreenOn = VDBG_STALL;
        this.mUniqueIdGenerator = new AtomicInteger(DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE);
        this.mDataConnections = new HashMap();
        this.mDataConnectionAcHashMap = new HashMap();
        this.mApnToDataConnectionId = new HashMap();
        this.mApnContexts = new ConcurrentHashMap();
        this.mPrioritySortedApnContexts = new PriorityQueue(5, new C00581());
        this.mAllApnSettings = null;
        this.mPreferredApn = null;
        this.mIsPsRestricted = VDBG;
        this.mEmergencyApn = null;
        this.mIsDisposed = VDBG;
        this.mIsProvisioning = VDBG;
        this.mProvisioningUrl = null;
        this.mProvisioningApnAlarmIntent = null;
        this.mProvisioningApnAlarmTag = (int) SystemClock.elapsedRealtime();
        this.mReplyAc = new AsyncChannel();
        this.mIntentReceiver = new C00592();
        this.mPollNetStat = new C00603();
        this.mOnSubscriptionsChangedListener = new C00614();
        this.mPhone = phone;
        log("DCT.constructor");
        this.mResolver = this.mPhone.getContext().getContentResolver();
        this.mUiccController = UiccController.getInstance();
        this.mUiccController.registerForIccChanged(this, 270369, null);
        this.mAlarmManager = (AlarmManager) this.mPhone.getContext().getSystemService("alarm");
        this.mCm = (ConnectivityManager) this.mPhone.getContext().getSystemService("connectivity");
        int phoneSubId = this.mPhone.getSubId();
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.SCREEN_ON");
        filter.addAction("android.intent.action.SCREEN_OFF");
        filter.addAction("android.net.wifi.STATE_CHANGE");
        filter.addAction("android.net.wifi.WIFI_STATE_CHANGED");
        filter.addAction(INTENT_DATA_STALL_ALARM);
        filter.addAction(INTENT_PROVISIONING_APN_ALARM);
        this.mUserDataEnabled = getDataEnabled();
        this.mPhone.getContext().registerReceiver(this.mIntentReceiver, filter, null, this.mPhone);
        this.mDataEnabled[DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE] = SystemProperties.getBoolean(DEFALUT_DATA_ON_BOOT_PROP, VDBG_STALL);
        if (this.mDataEnabled[DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE]) {
            this.mEnabledCount += DEFAULT_MDC_INITIAL_RETRY;
        }
        this.mAutoAttachOnCreation = PreferenceManager.getDefaultSharedPreferences(this.mPhone.getContext()).getBoolean(PhoneBase.DATA_DISABLED_ON_BOOT_KEY, VDBG);
        this.mSubscriptionManager = SubscriptionManager.from(this.mPhone.getContext());
        this.mSubscriptionManager.addOnSubscriptionsChangedListener(this.mOnSubscriptionsChangedListener);
        HandlerThread dcHandlerThread = new HandlerThread("DcHandlerThread");
        dcHandlerThread.start();
        Handler dcHandler = new Handler(dcHandlerThread.getLooper());
        this.mDcc = DcController.makeDcc(this.mPhone, this, dcHandler);
        this.mDcTesterFailBringUpAll = new DcTesterFailBringUpAll(this.mPhone, dcHandler);
    }

    public void dispose() {
        log("DCT.dispose");
        for (DcAsyncChannel dcac : this.mDataConnectionAcHashMap.values()) {
            dcac.disconnect();
        }
        this.mDataConnectionAcHashMap.clear();
        this.mIsDisposed = VDBG_STALL;
        this.mPhone.getContext().unregisterReceiver(this.mIntentReceiver);
        this.mUiccController.unregisterForIccChanged(this);
        if (this.mDataRoamingSettingObserver != null) {
            this.mDataRoamingSettingObserver.unregister();
        }
        this.mSubscriptionManager.removeOnSubscriptionsChangedListener(this.mOnSubscriptionsChangedListener);
        this.mDcc.dispose();
        this.mDcTesterFailBringUpAll.dispose();
    }

    public long getSubId() {
        return (long) this.mPhone.getSubId();
    }

    public Activity getActivity() {
        return this.mActivity;
    }

    void setActivity(Activity activity) {
        log("setActivity = " + activity);
        this.mActivity = activity;
        this.mPhone.notifyDataActivity();
    }

    public void incApnRefCount(String name) {
    }

    public void decApnRefCount(String name) {
    }

    public boolean isApnSupported(String name) {
        return VDBG;
    }

    public int getApnPriority(String name) {
        return -1;
    }

    public boolean isApnTypeActive(String type) {
        if ("dun".equals(type)) {
            ApnSetting dunApn = fetchDunApn();
            if (dunApn != null) {
                if (this.mActiveApn == null || !dunApn.toString().equals(this.mActiveApn.toString())) {
                    return VDBG;
                }
                return VDBG_STALL;
            }
        }
        if (this.mActiveApn == null || !this.mActiveApn.canHandleType(type)) {
            return VDBG;
        }
        return VDBG_STALL;
    }

    protected ApnSetting fetchDunApn() {
        if (SystemProperties.getBoolean("net.tethering.noprovisioning", VDBG)) {
            log("fetchDunApn: net.tethering.noprovisioning=true ret: null");
            return null;
        }
        ApnSetting dunSetting;
        int bearer = -1;
        ApnSetting retDunSetting = null;
        IccRecords r = (IccRecords) this.mIccRecords.get();
        for (ApnSetting dunSetting2 : ApnSetting.arrayFromString(Global.getString(this.mResolver, "tether_dun_apn"))) {
            String operator = r != null ? r.getOperatorNumeric() : "";
            if (dunSetting2.bearer != 0) {
                if (bearer == -1) {
                    bearer = this.mPhone.getServiceState().getRilDataRadioTechnology();
                }
                if (dunSetting2.bearer != bearer) {
                    continue;
                }
            }
            if (!dunSetting2.numeric.equals(operator)) {
                continue;
            } else if (!dunSetting2.hasMvnoParams()) {
                return dunSetting2;
            } else {
                if (r != null && mvnoMatches(r, dunSetting2.mvnoType, dunSetting2.mvnoMatchData)) {
                    return dunSetting2;
                }
            }
        }
        String[] arr$ = this.mPhone.getContext().getResources().getStringArray(17235993);
        int len$ = arr$.length;
        for (int i$ = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE; i$ < len$; i$ += DEFAULT_MDC_INITIAL_RETRY) {
            dunSetting2 = ApnSetting.fromString(arr$[i$]);
            if (dunSetting2 != null) {
                if (dunSetting2.bearer != 0) {
                    if (bearer == -1) {
                        bearer = this.mPhone.getServiceState().getRilDataRadioTechnology();
                    }
                    if (dunSetting2.bearer != bearer) {
                        continue;
                    }
                }
                if (!dunSetting2.hasMvnoParams()) {
                    retDunSetting = dunSetting2;
                } else if (r != null && mvnoMatches(r, dunSetting2.mvnoType, dunSetting2.mvnoMatchData)) {
                    return dunSetting2;
                }
            }
        }
        return retDunSetting;
    }

    public boolean hasMatchedTetherApnSetting() {
        ApnSetting matched = fetchDunApn();
        log("hasMatchedTetherApnSetting: APN=" + matched);
        return matched != null ? VDBG_STALL : VDBG;
    }

    public String[] getActiveApnTypes() {
        if (this.mActiveApn != null) {
            return this.mActiveApn.types;
        }
        String[] result = new String[DEFAULT_MDC_INITIAL_RETRY];
        result[DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE] = "default";
        return result;
    }

    public String getActiveApnString(String apnType) {
        if (this.mActiveApn != null) {
            return this.mActiveApn.apn;
        }
        return null;
    }

    public void setDataOnRoamingEnabled(boolean enabled) {
        int phoneSubId = this.mPhone.getSubId();
        if (getDataOnRoamingEnabled() != enabled) {
            int roaming = enabled ? DEFAULT_MDC_INITIAL_RETRY : DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
            if (TelephonyManager.getDefault().getSimCount() == DEFAULT_MDC_INITIAL_RETRY) {
                Global.putInt(this.mResolver, "data_roaming", roaming);
            } else {
                Global.putInt(this.mResolver, "data_roaming" + phoneSubId, roaming);
            }
            this.mSubscriptionManager.setDataRoaming(roaming, phoneSubId);
            log("setDataOnRoamingEnabled: set phoneSubId=" + phoneSubId + " isRoaming=" + enabled);
            return;
        }
        log("setDataOnRoamingEnabled: unchanged phoneSubId=" + phoneSubId + " isRoaming=" + enabled);
    }

    public boolean getDataOnRoamingEnabled() {
        boolean isDataRoamingEnabled = "true".equalsIgnoreCase(SystemProperties.get("ro.com.android.dataroaming", "false"));
        int phoneSubId = this.mPhone.getSubId();
        try {
            if (TelephonyManager.getDefault().getSimCount() == DEFAULT_MDC_INITIAL_RETRY) {
                isDataRoamingEnabled = Global.getInt(this.mResolver, "data_roaming", isDataRoamingEnabled ? DEFAULT_MDC_INITIAL_RETRY : DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE) != 0 ? VDBG_STALL : VDBG;
            } else {
                isDataRoamingEnabled = TelephonyManager.getIntWithSubId(this.mResolver, "data_roaming", phoneSubId) != 0 ? VDBG_STALL : VDBG;
            }
        } catch (SettingNotFoundException snfe) {
            log("getDataOnRoamingEnabled: SettingNofFoundException snfe=" + snfe);
        }
        log("getDataOnRoamingEnabled: phoneSubId=" + phoneSubId + " isDataRoamingEnabled=" + isDataRoamingEnabled);
        return isDataRoamingEnabled;
    }

    public void setDataEnabled(boolean enable) {
        Message msg = obtainMessage(270366);
        msg.arg1 = enable ? DEFAULT_MDC_INITIAL_RETRY : DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        log("setDataEnabled: sendMessage: enable=" + enable);
        sendMessage(msg);
    }

    public boolean getDataEnabled() {
        boolean retVal = "true".equalsIgnoreCase(SystemProperties.get("ro.com.android.mobiledata", "true"));
        try {
            if (TelephonyManager.getDefault().getSimCount() == DEFAULT_MDC_INITIAL_RETRY) {
                retVal = Global.getInt(this.mResolver, "mobile_data", retVal ? DEFAULT_MDC_INITIAL_RETRY : DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE) != 0 ? VDBG_STALL : VDBG;
            } else {
                retVal = TelephonyManager.getIntWithSubId(this.mResolver, "mobile_data", this.mPhone.getSubId()) != 0 ? VDBG_STALL : VDBG;
            }
            log("getDataEnabled: getIntWithSubId retVal=" + retVal);
            return retVal;
        } catch (SettingNotFoundException e) {
            retVal = "true".equalsIgnoreCase(SystemProperties.get("ro.com.android.mobiledata", "true"));
            log("getDataEnabled: system property ro.com.android.mobiledata retVal=" + retVal);
            return retVal;
        }
    }

    public void handleMessage(Message msg) {
        boolean enabled;
        Bundle bundle;
        String apnType;
        switch (msg.what) {
            case 69636:
                log("DISCONNECTED_CONNECTED: msg=" + msg);
                DcAsyncChannel dcac = msg.obj;
                this.mDataConnectionAcHashMap.remove(Integer.valueOf(dcac.getDataConnectionIdSync()));
                dcac.disconnected();
            case 270336:
                this.mCidActive = msg.arg1;
                onDataSetupComplete((AsyncResult) msg.obj);
            case 270337:
                onRadioAvailable();
            case 270339:
                String reason = null;
                if (msg.obj instanceof String) {
                    reason = msg.obj;
                }
                onTrySetupData(reason);
            case 270342:
                onRadioOffOrNotAvailable();
            case 270343:
                onVoiceCallStarted();
            case 270344:
                onVoiceCallEnded();
            case 270347:
                onRoamingOn();
            case 270348:
                onRoamingOff();
            case 270349:
                onEnableApn(msg.arg1, msg.arg2);
            case 270351:
                log("DataConnectionTracker.handleMessage: EVENT_DISCONNECT_DONE msg=" + msg);
                onDisconnectDone(msg.arg1, (AsyncResult) msg.obj);
            case 270353:
                onDataStallAlarm(msg.arg1);
            case 270360:
                onCleanUpConnection(msg.arg1 == 0 ? VDBG : VDBG_STALL, msg.arg2, (String) msg.obj);
            case 270362:
                restartRadio();
            case 270363:
                onSetInternalDataEnabled(msg.arg1 == DEFAULT_MDC_INITIAL_RETRY ? VDBG_STALL : VDBG);
            case 270364:
                log("EVENT_RESET_DONE");
                onResetDone((AsyncResult) msg.obj);
            case 270365:
                onCleanUpAllConnections((String) msg.obj);
            case 270366:
                enabled = msg.arg1 == DEFAULT_MDC_INITIAL_RETRY ? VDBG_STALL : VDBG;
                log("CMD_SET_USER_DATA_ENABLE enabled=" + enabled);
                onSetUserDataEnabled(enabled);
            case 270367:
                boolean met = msg.arg1 == DEFAULT_MDC_INITIAL_RETRY ? VDBG_STALL : VDBG;
                log("CMD_SET_DEPENDENCY_MET met=" + met);
                bundle = msg.getData();
                if (bundle != null) {
                    apnType = (String) bundle.get("apnType");
                    if (apnType != null) {
                        onSetDependencyMet(apnType, met);
                    }
                }
            case 270368:
                onSetPolicyDataEnabled(msg.arg1 == DEFAULT_MDC_INITIAL_RETRY ? VDBG_STALL : VDBG);
            case 270369:
                onUpdateIcc();
            case 270370:
                log("DataConnectionTracker.handleMessage: EVENT_DISCONNECT_DC_RETRYING msg=" + msg);
                onDisconnectDcRetrying(msg.arg1, (AsyncResult) msg.obj);
            case 270371:
                onDataSetupCompleteError((AsyncResult) msg.obj);
            case 270372:
                sEnableFailFastRefCounter = (msg.arg1 == DEFAULT_MDC_INITIAL_RETRY ? DEFAULT_MDC_INITIAL_RETRY : -1) + sEnableFailFastRefCounter;
                log("CMD_SET_ENABLE_FAIL_FAST_MOBILE_DATA:  sEnableFailFastRefCounter=" + sEnableFailFastRefCounter);
                if (sEnableFailFastRefCounter < 0) {
                    loge("CMD_SET_ENABLE_FAIL_FAST_MOBILE_DATA: sEnableFailFastRefCounter:" + sEnableFailFastRefCounter + " < 0");
                    sEnableFailFastRefCounter = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
                }
                enabled = sEnableFailFastRefCounter > 0 ? VDBG_STALL : VDBG;
                log("CMD_SET_ENABLE_FAIL_FAST_MOBILE_DATA: enabled=" + enabled + " sEnableFailFastRefCounter=" + sEnableFailFastRefCounter);
                if (this.mFailFast != enabled) {
                    this.mFailFast = enabled;
                    this.mDataStallDetectionEnabled = !enabled ? VDBG_STALL : VDBG;
                    if (this.mDataStallDetectionEnabled && getOverallState() == State.CONNECTED && (!this.mInVoiceCall || this.mPhone.getServiceStateTracker().isConcurrentVoiceAndDataAllowed())) {
                        log("CMD_SET_ENABLE_FAIL_FAST_MOBILE_DATA: start data stall");
                        stopDataStallAlarm();
                        startDataStallAlarm(VDBG);
                        return;
                    }
                    log("CMD_SET_ENABLE_FAIL_FAST_MOBILE_DATA: stop data stall");
                    stopDataStallAlarm();
                }
            case 270373:
                bundle = msg.getData();
                if (bundle != null) {
                    try {
                        this.mProvisioningUrl = (String) bundle.get("provisioningUrl");
                    } catch (ClassCastException e) {
                        loge("CMD_ENABLE_MOBILE_PROVISIONING: provisioning url not a string" + e);
                        this.mProvisioningUrl = null;
                    }
                }
                if (TextUtils.isEmpty(this.mProvisioningUrl)) {
                    loge("CMD_ENABLE_MOBILE_PROVISIONING: provisioning url is empty, ignoring");
                    this.mIsProvisioning = VDBG;
                    this.mProvisioningUrl = null;
                    return;
                }
                loge("CMD_ENABLE_MOBILE_PROVISIONING: provisioningUrl=" + this.mProvisioningUrl);
                this.mIsProvisioning = VDBG_STALL;
                startProvisioningApnAlarm();
            case 270374:
                boolean isProvApn;
                int i;
                log("CMD_IS_PROVISIONING_APN");
                apnType = null;
                try {
                    bundle = msg.getData();
                    if (bundle != null) {
                        apnType = (String) bundle.get("apnType");
                    }
                    if (TextUtils.isEmpty(apnType)) {
                        loge("CMD_IS_PROVISIONING_APN: apnType is empty");
                        isProvApn = VDBG;
                    } else {
                        isProvApn = isProvisioningApn(apnType);
                    }
                } catch (ClassCastException e2) {
                    loge("CMD_IS_PROVISIONING_APN: NO provisioning url ignoring");
                    isProvApn = VDBG;
                }
                log("CMD_IS_PROVISIONING_APN: ret=" + isProvApn);
                AsyncChannel asyncChannel = this.mReplyAc;
                if (isProvApn) {
                    i = DEFAULT_MDC_INITIAL_RETRY;
                } else {
                    i = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
                }
                asyncChannel.replyToMessage(msg, 270374, i);
            case 270375:
                log("EVENT_PROVISIONING_APN_ALARM");
                ApnContext apnCtx = (ApnContext) this.mApnContexts.get("default");
                if (!apnCtx.isProvisioningApn() || !apnCtx.isConnectedOrConnecting()) {
                    log("EVENT_PROVISIONING_APN_ALARM: Not connected ignore");
                } else if (this.mProvisioningApnAlarmTag == msg.arg1) {
                    log("EVENT_PROVISIONING_APN_ALARM: Disconnecting");
                    this.mIsProvisioning = VDBG;
                    this.mProvisioningUrl = null;
                    stopProvisioningApnAlarm();
                    sendCleanUpConnection(VDBG_STALL, apnCtx);
                } else {
                    log("EVENT_PROVISIONING_APN_ALARM: ignore stale tag, mProvisioningApnAlarmTag:" + this.mProvisioningApnAlarmTag + " != arg1:" + msg.arg1);
                }
            case 270376:
                if (msg.arg1 == DEFAULT_MDC_INITIAL_RETRY) {
                    handleStartNetStatPoll((Activity) msg.obj);
                } else if (msg.arg1 == 0) {
                    handleStopNetStatPoll((Activity) msg.obj);
                }
            default:
                Rlog.e("DATA", "Unidentified event msg=" + msg);
        }
    }

    public boolean getAnyDataEnabled() {
        boolean result;
        synchronized (this.mDataEnabledLock) {
            result = (this.mInternalDataEnabled && this.mUserDataEnabled && sPolicyDataEnabled && this.mEnabledCount != 0) ? VDBG_STALL : VDBG;
        }
        if (!result) {
            log("getAnyDataEnabled " + result);
        }
        return result;
    }

    protected boolean isEmergency() {
        boolean result;
        synchronized (this.mDataEnabledLock) {
            result = (this.mPhone.isInEcm() || this.mPhone.isInEmergencyCall()) ? VDBG_STALL : VDBG;
        }
        log("isEmergency: result=" + result);
        return result;
    }

    protected int apnTypeToId(String type) {
        if (TextUtils.equals(type, "default")) {
            return DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        }
        if (TextUtils.equals(type, "mms")) {
            return DEFAULT_MDC_INITIAL_RETRY;
        }
        if (TextUtils.equals(type, "supl")) {
            return DATA_CONNECTION_ACTIVE_PH_LINK_UP;
        }
        if (TextUtils.equals(type, "dun")) {
            return DEFAULT_MAX_PDP_RESET_FAIL;
        }
        if (TextUtils.equals(type, "hipri")) {
            return 4;
        }
        if (TextUtils.equals(type, "ims")) {
            return 5;
        }
        if (TextUtils.equals(type, "fota")) {
            return 6;
        }
        if (TextUtils.equals(type, "cbs")) {
            return 7;
        }
        if (TextUtils.equals(type, "ia")) {
            return 8;
        }
        if (TextUtils.equals(type, "emergency")) {
            return 9;
        }
        return -1;
    }

    protected String apnIdToType(int id) {
        switch (id) {
            case DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE /*0*/:
                return "default";
            case DEFAULT_MDC_INITIAL_RETRY /*1*/:
                return "mms";
            case DATA_CONNECTION_ACTIVE_PH_LINK_UP /*2*/:
                return "supl";
            case DEFAULT_MAX_PDP_RESET_FAIL /*3*/:
                return "dun";
            case CharacterSets.ISO_8859_1 /*4*/:
                return "hipri";
            case CharacterSets.ISO_8859_2 /*5*/:
                return "ims";
            case CharacterSets.ISO_8859_3 /*6*/:
                return "fota";
            case CharacterSets.ISO_8859_4 /*7*/:
                return "cbs";
            case CharacterSets.ISO_8859_5 /*8*/:
                return "ia";
            case CharacterSets.ISO_8859_6 /*9*/:
                return "emergency";
            default:
                log("Unknown id (" + id + ") in apnIdToType");
                return "default";
        }
    }

    public LinkProperties getLinkProperties(String apnType) {
        if (isApnIdEnabled(apnTypeToId(apnType))) {
            return ((DcAsyncChannel) this.mDataConnectionAcHashMap.get(Integer.valueOf(DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE))).getLinkPropertiesSync();
        }
        return new LinkProperties();
    }

    public NetworkCapabilities getNetworkCapabilities(String apnType) {
        if (isApnIdEnabled(apnTypeToId(apnType))) {
            return ((DcAsyncChannel) this.mDataConnectionAcHashMap.get(Integer.valueOf(DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE))).getNetworkCapabilitiesSync();
        }
        return new NetworkCapabilities();
    }

    protected void notifyDataConnection(String reason) {
        for (int id = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE; id < NUMBER_SENT_PACKETS_OF_HANG; id += DEFAULT_MDC_INITIAL_RETRY) {
            if (this.mDataEnabled[id]) {
                this.mPhone.notifyDataConnection(reason, apnIdToType(id));
            }
        }
        notifyOffApnsOfAvailability(reason);
    }

    private void notifyApnIdUpToCurrent(String reason, int apnId) {
        switch (C00625.$SwitchMap$com$android$internal$telephony$DctConstants$State[this.mState.ordinal()]) {
            case DATA_CONNECTION_ACTIVE_PH_LINK_UP /*2*/:
            case DEFAULT_MAX_PDP_RESET_FAIL /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
                this.mPhone.notifyDataConnection(reason, apnIdToType(apnId), DataState.CONNECTING);
            case CharacterSets.ISO_8859_2 /*5*/:
            case CharacterSets.ISO_8859_3 /*6*/:
                this.mPhone.notifyDataConnection(reason, apnIdToType(apnId), DataState.CONNECTING);
                this.mPhone.notifyDataConnection(reason, apnIdToType(apnId), DataState.CONNECTED);
            default:
        }
    }

    private void notifyApnIdDisconnected(String reason, int apnId) {
        this.mPhone.notifyDataConnection(reason, apnIdToType(apnId), DataState.DISCONNECTED);
    }

    protected void notifyOffApnsOfAvailability(String reason) {
        log("notifyOffApnsOfAvailability - reason= " + reason);
        for (int id = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE; id < NUMBER_SENT_PACKETS_OF_HANG; id += DEFAULT_MDC_INITIAL_RETRY) {
            if (!isApnIdEnabled(id)) {
                notifyApnIdDisconnected(reason, id);
            }
        }
    }

    public boolean isApnTypeEnabled(String apnType) {
        if (apnType == null) {
            return VDBG;
        }
        return isApnIdEnabled(apnTypeToId(apnType));
    }

    protected synchronized boolean isApnIdEnabled(int id) {
        boolean z;
        if (id != -1) {
            z = this.mDataEnabled[id];
        } else {
            z = VDBG;
        }
        return z;
    }

    protected void setEnabled(int id, boolean enable) {
        log("setEnabled(" + id + ", " + enable + ") with old state = " + this.mDataEnabled[id] + " and enabledCount = " + this.mEnabledCount);
        Message msg = obtainMessage(270349);
        msg.arg1 = id;
        msg.arg2 = enable ? DEFAULT_MDC_INITIAL_RETRY : DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        sendMessage(msg);
    }

    protected void onEnableApn(int apnId, int enabled) {
        log("EVENT_APN_ENABLE_REQUEST apnId=" + apnId + ", apnType=" + apnIdToType(apnId) + ", enabled=" + enabled + ", dataEnabled = " + this.mDataEnabled[apnId] + ", enabledCount = " + this.mEnabledCount + ", isApnTypeActive = " + isApnTypeActive(apnIdToType(apnId)));
        if (enabled == DEFAULT_MDC_INITIAL_RETRY) {
            synchronized (this) {
                if (!this.mDataEnabled[apnId]) {
                    this.mDataEnabled[apnId] = VDBG_STALL;
                    this.mEnabledCount += DEFAULT_MDC_INITIAL_RETRY;
                }
            }
            String type = apnIdToType(apnId);
            if (isApnTypeActive(type)) {
                notifyApnIdUpToCurrent(Phone.REASON_APN_SWITCHED, apnId);
                return;
            }
            this.mRequestedApnType = type;
            onEnableNewApn();
            return;
        }
        boolean didDisable = VDBG;
        synchronized (this) {
            if (this.mDataEnabled[apnId]) {
                this.mDataEnabled[apnId] = VDBG;
                this.mEnabledCount--;
                didDisable = VDBG_STALL;
            }
        }
        if (didDisable) {
            if (this.mEnabledCount == 0 || apnId == DEFAULT_MAX_PDP_RESET_FAIL) {
                this.mRequestedApnType = "default";
                onCleanUpConnection(VDBG_STALL, apnId, Phone.REASON_DATA_DISABLED);
            }
            notifyApnIdDisconnected(Phone.REASON_DATA_DISABLED, apnId);
            if (this.mDataEnabled[DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE] == VDBG_STALL && !isApnTypeActive("default")) {
                this.mRequestedApnType = "default";
                onEnableNewApn();
            }
        }
    }

    protected void onEnableNewApn() {
    }

    protected void onResetDone(AsyncResult ar) {
        log("EVENT_RESET_DONE");
        String reason = null;
        if (ar.userObj instanceof String) {
            reason = ar.userObj;
        }
        gotoIdleAndNotifyDataConnection(reason);
    }

    public boolean setInternalDataEnabled(boolean enable) {
        log("setInternalDataEnabled(" + enable + ")");
        Message msg = obtainMessage(270363);
        msg.arg1 = enable ? DEFAULT_MDC_INITIAL_RETRY : DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        sendMessage(msg);
        return VDBG_STALL;
    }

    protected void onSetInternalDataEnabled(boolean enabled) {
        synchronized (this.mDataEnabledLock) {
            this.mInternalDataEnabled = enabled;
            if (enabled) {
                log("onSetInternalDataEnabled: changed to enabled, try to setup data call");
                onTrySetupData(Phone.REASON_DATA_ENABLED);
            } else {
                log("onSetInternalDataEnabled: changed to disabled, cleanUpAllConnections");
                cleanUpAllConnections(null);
            }
        }
    }

    public void cleanUpAllConnections(String cause) {
        Message msg = obtainMessage(270365);
        msg.obj = cause;
        sendMessage(msg);
    }

    protected void onSetUserDataEnabled(boolean enabled) {
        int i = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        synchronized (this.mDataEnabledLock) {
            if (this.mUserDataEnabled != enabled) {
                this.mUserDataEnabled = enabled;
                ContentResolver contentResolver;
                String str;
                if (TelephonyManager.getDefault().getSimCount() == DEFAULT_MDC_INITIAL_RETRY) {
                    contentResolver = this.mResolver;
                    str = "mobile_data";
                    if (enabled) {
                        i = DEFAULT_MDC_INITIAL_RETRY;
                    }
                    Global.putInt(contentResolver, str, i);
                } else {
                    int phoneSubId = this.mPhone.getSubId();
                    contentResolver = this.mResolver;
                    str = "mobile_data" + phoneSubId;
                    if (enabled) {
                        i = DEFAULT_MDC_INITIAL_RETRY;
                    }
                    Global.putInt(contentResolver, str, i);
                }
                if (!getDataOnRoamingEnabled() && this.mPhone.getServiceState().getDataRoaming() == VDBG_STALL) {
                    if (enabled) {
                        notifyOffApnsOfAvailability(Phone.REASON_ROAMING_ON);
                    } else {
                        notifyOffApnsOfAvailability(Phone.REASON_DATA_DISABLED);
                    }
                }
                if (enabled) {
                    onTrySetupData(Phone.REASON_DATA_ENABLED);
                } else {
                    onCleanUpAllConnections(Phone.REASON_DATA_SPECIFIC_DISABLED);
                }
            }
        }
    }

    protected void onSetDependencyMet(String apnType, boolean met) {
    }

    protected void onSetPolicyDataEnabled(boolean enabled) {
        synchronized (this.mDataEnabledLock) {
            boolean prevEnabled = getAnyDataEnabled();
            if (sPolicyDataEnabled != enabled) {
                sPolicyDataEnabled = enabled;
                if (prevEnabled != getAnyDataEnabled()) {
                    if (prevEnabled) {
                        onCleanUpAllConnections(Phone.REASON_DATA_SPECIFIC_DISABLED);
                    } else {
                        onTrySetupData(Phone.REASON_DATA_ENABLED);
                    }
                }
            }
        }
    }

    protected String getReryConfig(boolean forDefault) {
        int nt = this.mPhone.getServiceState().getNetworkType();
        if (nt == 4 || nt == 7 || nt == 5 || nt == 6 || nt == 12 || nt == 14) {
            return SystemProperties.get("ro.cdma.data_retry_config");
        }
        if (forDefault) {
            return SystemProperties.get("ro.gsm.data_retry_config");
        }
        return SystemProperties.get("ro.gsm.2nd_data_retry_config");
    }

    protected void resetPollStats() {
        this.mTxPkts = -1;
        this.mRxPkts = -1;
        this.mNetStatPollPeriod = POLL_NETSTAT_MILLIS;
    }

    void startNetStatPoll() {
        if (getOverallState() == State.CONNECTED && !this.mNetStatPollEnabled) {
            log("startNetStatPoll");
            resetPollStats();
            this.mNetStatPollEnabled = VDBG_STALL;
            this.mPollNetStat.run();
        }
        if (this.mPhone != null) {
            this.mPhone.notifyDataActivity();
        }
    }

    void stopNetStatPoll() {
        this.mNetStatPollEnabled = VDBG;
        removeCallbacks(this.mPollNetStat);
        log("stopNetStatPoll");
        if (this.mPhone != null) {
            this.mPhone.notifyDataActivity();
        }
    }

    public void sendStartNetStatPoll(Activity activity) {
        Message msg = obtainMessage(270376);
        msg.arg1 = DEFAULT_MDC_INITIAL_RETRY;
        msg.obj = activity;
        sendMessage(msg);
    }

    protected void handleStartNetStatPoll(Activity activity) {
        startNetStatPoll();
        startDataStallAlarm(VDBG);
        setActivity(activity);
    }

    public void sendStopNetStatPoll(Activity activity) {
        Message msg = obtainMessage(270376);
        msg.arg1 = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        msg.obj = activity;
        sendMessage(msg);
    }

    protected void handleStopNetStatPoll(Activity activity) {
        stopNetStatPoll();
        stopDataStallAlarm();
        setActivity(activity);
    }

    public void updateDataActivity() {
        TxRxSum preTxRxSum = new TxRxSum(this.mTxPkts, this.mRxPkts);
        TxRxSum curTxRxSum = new TxRxSum();
        curTxRxSum.updateTxRxSum();
        this.mTxPkts = curTxRxSum.txPkts;
        this.mRxPkts = curTxRxSum.rxPkts;
        if (!this.mNetStatPollEnabled) {
            return;
        }
        if (preTxRxSum.txPkts > 0 || preTxRxSum.rxPkts > 0) {
            Activity newActivity;
            long sent = this.mTxPkts - preTxRxSum.txPkts;
            long received = this.mRxPkts - preTxRxSum.rxPkts;
            if (sent > 0 && received > 0) {
                newActivity = Activity.DATAINANDOUT;
            } else if (sent > 0 && received == 0) {
                newActivity = Activity.DATAOUT;
            } else if (sent != 0 || received <= 0) {
                newActivity = this.mActivity == Activity.DORMANT ? this.mActivity : Activity.NONE;
            } else {
                newActivity = Activity.DATAIN;
            }
            if (this.mActivity != newActivity && this.mIsScreenOn) {
                this.mActivity = newActivity;
                this.mPhone.notifyDataActivity();
            }
        }
    }

    public int getRecoveryAction() {
        int action = System.getInt(this.mResolver, "radio.data.stall.recovery.action", DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE);
        log("getRecoveryAction: " + action);
        return action;
    }

    public void putRecoveryAction(int action) {
        System.putInt(this.mResolver, "radio.data.stall.recovery.action", action);
        log("putRecoveryAction: " + action);
    }

    protected boolean isConnected() {
        return VDBG;
    }

    protected void doRecovery() {
        if (getOverallState() == State.CONNECTED) {
            int recoveryAction = getRecoveryAction();
            switch (recoveryAction) {
                case DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE /*0*/:
                    EventLog.writeEvent(EventLogTags.DATA_STALL_RECOVERY_GET_DATA_CALL_LIST, this.mSentSinceLastRecv);
                    log("doRecovery() get data call list");
                    this.mPhone.mCi.getDataCallList(obtainMessage(270340));
                    putRecoveryAction(DEFAULT_MDC_INITIAL_RETRY);
                    break;
                case DEFAULT_MDC_INITIAL_RETRY /*1*/:
                    EventLog.writeEvent(EventLogTags.DATA_STALL_RECOVERY_CLEANUP, this.mSentSinceLastRecv);
                    log("doRecovery() cleanup all connections");
                    cleanUpAllConnections(Phone.REASON_PDP_RESET);
                    putRecoveryAction(DATA_CONNECTION_ACTIVE_PH_LINK_UP);
                    break;
                case DATA_CONNECTION_ACTIVE_PH_LINK_UP /*2*/:
                    EventLog.writeEvent(EventLogTags.DATA_STALL_RECOVERY_REREGISTER, this.mSentSinceLastRecv);
                    log("doRecovery() re-register");
                    this.mPhone.getServiceStateTracker().reRegisterNetwork(null);
                    putRecoveryAction(DEFAULT_MAX_PDP_RESET_FAIL);
                    break;
                case DEFAULT_MAX_PDP_RESET_FAIL /*3*/:
                    EventLog.writeEvent(EventLogTags.DATA_STALL_RECOVERY_RADIO_RESTART, this.mSentSinceLastRecv);
                    log("restarting radio");
                    putRecoveryAction(4);
                    restartRadio();
                    break;
                case CharacterSets.ISO_8859_1 /*4*/:
                    EventLog.writeEvent(EventLogTags.DATA_STALL_RECOVERY_RADIO_RESTART_WITH_PROP, -1);
                    log("restarting radio with gsm.radioreset to true");
                    SystemProperties.set(this.RADIO_RESET_PROPERTY, "true");
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                    }
                    restartRadio();
                    putRecoveryAction(DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE);
                    break;
                default:
                    throw new RuntimeException("doRecovery: Invalid recoveryAction=" + recoveryAction);
            }
            this.mSentSinceLastRecv = 0;
        }
    }

    private void updateDataStallInfo() {
        TxRxSum preTxRxSum = new TxRxSum(this.mDataStallTxRxSum);
        this.mDataStallTxRxSum.updateTxRxSum();
        log("updateDataStallInfo: mDataStallTxRxSum=" + this.mDataStallTxRxSum + " preTxRxSum=" + preTxRxSum);
        long sent = this.mDataStallTxRxSum.txPkts - preTxRxSum.txPkts;
        long received = this.mDataStallTxRxSum.rxPkts - preTxRxSum.rxPkts;
        if (sent > 0 && received > 0) {
            log("updateDataStallInfo: IN/OUT");
            this.mSentSinceLastRecv = 0;
            putRecoveryAction(DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE);
        } else if (sent > 0 && received == 0) {
            if (this.mPhone.getState() == PhoneConstants.State.IDLE) {
                this.mSentSinceLastRecv += sent;
            } else {
                this.mSentSinceLastRecv = 0;
            }
            log("updateDataStallInfo: OUT sent=" + sent + " mSentSinceLastRecv=" + this.mSentSinceLastRecv);
        } else if (sent != 0 || received <= 0) {
            log("updateDataStallInfo: NONE");
        } else {
            log("updateDataStallInfo: IN");
            this.mSentSinceLastRecv = 0;
            putRecoveryAction(DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE);
        }
    }

    protected void onDataStallAlarm(int tag) {
        if (this.mDataStallAlarmTag != tag) {
            log("onDataStallAlarm: ignore, tag=" + tag + " expecting " + this.mDataStallAlarmTag);
            return;
        }
        updateDataStallInfo();
        int hangWatchdogTrigger = Global.getInt(this.mResolver, "pdp_watchdog_trigger_packet_count", NUMBER_SENT_PACKETS_OF_HANG);
        boolean suspectedStall = VDBG;
        if (this.mSentSinceLastRecv >= ((long) hangWatchdogTrigger)) {
            log("onDataStallAlarm: tag=" + tag + " do recovery action=" + getRecoveryAction());
            suspectedStall = VDBG_STALL;
            sendMessage(obtainMessage(270354));
        } else {
            log("onDataStallAlarm: tag=" + tag + " Sent " + String.valueOf(this.mSentSinceLastRecv) + " pkts since last received, < watchdogTrigger=" + hangWatchdogTrigger);
        }
        startDataStallAlarm(suspectedStall);
    }

    protected void startDataStallAlarm(boolean suspectedStall) {
        int nextAction = getRecoveryAction();
        if (this.mDataStallDetectionEnabled && getOverallState() == State.CONNECTED) {
            int delayInMs;
            if (this.mIsScreenOn || suspectedStall || RecoveryAction.isAggressiveRecovery(nextAction)) {
                delayInMs = Global.getInt(this.mResolver, "data_stall_alarm_aggressive_delay_in_ms", RESTORE_DEFAULT_APN_DELAY);
            } else {
                delayInMs = Global.getInt(this.mResolver, "data_stall_alarm_non_aggressive_delay_in_ms", DATA_STALL_ALARM_NON_AGGRESSIVE_DELAY_IN_MS_DEFAULT);
            }
            this.mDataStallAlarmTag += DEFAULT_MDC_INITIAL_RETRY;
            log("startDataStallAlarm: tag=" + this.mDataStallAlarmTag + " delay=" + (delayInMs / POLL_NETSTAT_MILLIS) + "s");
            Intent intent = new Intent(INTENT_DATA_STALL_ALARM);
            intent.putExtra(DATA_STALL_ALARM_TAG_EXTRA, this.mDataStallAlarmTag);
            this.mDataStallAlarmIntent = PendingIntent.getBroadcast(this.mPhone.getContext(), DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE, intent, 134217728);
            this.mAlarmManager.set(DATA_CONNECTION_ACTIVE_PH_LINK_UP, SystemClock.elapsedRealtime() + ((long) delayInMs), this.mDataStallAlarmIntent);
            return;
        }
        log("startDataStallAlarm: NOT started, no connection tag=" + this.mDataStallAlarmTag);
    }

    protected void stopDataStallAlarm() {
        log("stopDataStallAlarm: current tag=" + this.mDataStallAlarmTag + " mDataStallAlarmIntent=" + this.mDataStallAlarmIntent);
        this.mDataStallAlarmTag += DEFAULT_MDC_INITIAL_RETRY;
        if (this.mDataStallAlarmIntent != null) {
            this.mAlarmManager.cancel(this.mDataStallAlarmIntent);
            this.mDataStallAlarmIntent = null;
        }
    }

    protected void restartDataStallAlarm() {
        if (!isConnected()) {
            return;
        }
        if (RecoveryAction.isAggressiveRecovery(getRecoveryAction())) {
            log("restartDataStallAlarm: action is pending. not resetting the alarm.");
            return;
        }
        log("restartDataStallAlarm: stop then start.");
        stopDataStallAlarm();
        startDataStallAlarm(VDBG);
    }

    protected void setInitialAttachApn() {
        ApnSetting iaApnSetting = null;
        ApnSetting defaultApnSetting = null;
        ApnSetting firstApnSetting = null;
        log("setInitialApn: E mPreferredApn=" + this.mPreferredApn);
        if (!(this.mAllApnSettings == null || this.mAllApnSettings.isEmpty())) {
            firstApnSetting = (ApnSetting) this.mAllApnSettings.get(DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE);
            log("setInitialApn: firstApnSetting=" + firstApnSetting);
            Iterator i$ = this.mAllApnSettings.iterator();
            while (i$.hasNext()) {
                ApnSetting apn = (ApnSetting) i$.next();
                if (ArrayUtils.contains(apn.types, "ia") && apn.carrierEnabled) {
                    log("setInitialApn: iaApnSetting=" + apn);
                    iaApnSetting = apn;
                    break;
                } else if (defaultApnSetting == null && apn.canHandleType("default")) {
                    log("setInitialApn: defaultApnSetting=" + apn);
                    defaultApnSetting = apn;
                }
            }
        }
        ApnSetting initialAttachApnSetting = null;
        if (iaApnSetting != null) {
            log("setInitialAttachApn: using iaApnSetting");
            initialAttachApnSetting = iaApnSetting;
        } else if (this.mPreferredApn != null) {
            log("setInitialAttachApn: using mPreferredApn");
            initialAttachApnSetting = this.mPreferredApn;
        } else if (defaultApnSetting != null) {
            log("setInitialAttachApn: using defaultApnSetting");
            initialAttachApnSetting = defaultApnSetting;
        } else if (firstApnSetting != null) {
            log("setInitialAttachApn: using firstApnSetting");
            initialAttachApnSetting = firstApnSetting;
        }
        if (initialAttachApnSetting == null) {
            log("setInitialAttachApn: X There in no available apn");
            return;
        }
        log("setInitialAttachApn: X selected Apn=" + initialAttachApnSetting);
        this.mPhone.mCi.setInitialAttachApn(initialAttachApnSetting.apn, initialAttachApnSetting.protocol, initialAttachApnSetting.authType, initialAttachApnSetting.user, initialAttachApnSetting.password, null);
    }

    protected void setDataProfilesAsNeeded() {
        log("setDataProfilesAsNeeded");
        if (this.mAllApnSettings != null && !this.mAllApnSettings.isEmpty()) {
            ArrayList<DataProfile> dps = new ArrayList();
            Iterator it = this.mAllApnSettings.iterator();
            while (it.hasNext()) {
                ApnSetting apn = (ApnSetting) it.next();
                if (apn.modemCognitive) {
                    DataProfile dp = new DataProfile(apn, this.mPhone.getServiceState().getDataRoaming());
                    boolean isDup = VDBG;
                    Iterator i$ = dps.iterator();
                    while (i$.hasNext()) {
                        if (dp.equals((DataProfile) i$.next())) {
                            isDup = VDBG_STALL;
                            break;
                        }
                    }
                    if (!isDup) {
                        dps.add(dp);
                    }
                }
            }
            if (dps.size() > 0) {
                this.mPhone.mCi.setDataProfile((DataProfile[]) dps.toArray(new DataProfile[DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE]), null);
            }
        }
    }

    protected void onActionIntentProvisioningApnAlarm(Intent intent) {
        log("onActionIntentProvisioningApnAlarm: action=" + intent.getAction());
        Message msg = obtainMessage(270375, intent.getAction());
        msg.arg1 = intent.getIntExtra(PROVISIONING_APN_ALARM_TAG_EXTRA, DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE);
        sendMessage(msg);
    }

    protected void startProvisioningApnAlarm() {
        int delayInMs = Global.getInt(this.mResolver, "provisioning_apn_alarm_delay_in_ms", PROVISIONING_APN_ALARM_DELAY_IN_MS_DEFAULT);
        if (Build.IS_DEBUGGABLE) {
            try {
                delayInMs = Integer.parseInt(System.getProperty(DEBUG_PROV_APN_ALARM, Integer.toString(delayInMs)));
            } catch (NumberFormatException e) {
                loge("startProvisioningApnAlarm: e=" + e);
            }
        }
        this.mProvisioningApnAlarmTag += DEFAULT_MDC_INITIAL_RETRY;
        log("startProvisioningApnAlarm: tag=" + this.mProvisioningApnAlarmTag + " delay=" + (delayInMs / POLL_NETSTAT_MILLIS) + "s");
        Intent intent = new Intent(INTENT_PROVISIONING_APN_ALARM);
        intent.putExtra(PROVISIONING_APN_ALARM_TAG_EXTRA, this.mProvisioningApnAlarmTag);
        this.mProvisioningApnAlarmIntent = PendingIntent.getBroadcast(this.mPhone.getContext(), DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE, intent, 134217728);
        this.mAlarmManager.set(DATA_CONNECTION_ACTIVE_PH_LINK_UP, SystemClock.elapsedRealtime() + ((long) delayInMs), this.mProvisioningApnAlarmIntent);
    }

    protected void stopProvisioningApnAlarm() {
        log("stopProvisioningApnAlarm: current tag=" + this.mProvisioningApnAlarmTag + " mProvsioningApnAlarmIntent=" + this.mProvisioningApnAlarmIntent);
        this.mProvisioningApnAlarmTag += DEFAULT_MDC_INITIAL_RETRY;
        if (this.mProvisioningApnAlarmIntent != null) {
            this.mAlarmManager.cancel(this.mProvisioningApnAlarmIntent);
            this.mProvisioningApnAlarmIntent = null;
        }
    }

    void sendCleanUpConnection(boolean tearDown, ApnContext apnContext) {
        int i;
        log("sendCleanUpConnection: tearDown=" + tearDown + " apnContext=" + apnContext);
        Message msg = obtainMessage(270360);
        if (tearDown) {
            i = DEFAULT_MDC_INITIAL_RETRY;
        } else {
            i = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        }
        msg.arg1 = i;
        msg.arg2 = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        msg.obj = apnContext;
        sendMessage(msg);
    }

    void sendRestartRadio() {
        log("sendRestartRadio:");
        sendMessage(obtainMessage(270362));
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("DcTrackerBase:");
        pw.println(" RADIO_TESTS=false");
        pw.println(" mInternalDataEnabled=" + this.mInternalDataEnabled);
        pw.println(" mUserDataEnabled=" + this.mUserDataEnabled);
        pw.println(" sPolicyDataEnabed=" + sPolicyDataEnabled);
        pw.println(" mDataEnabled:");
        int i = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE;
        while (true) {
            int length = this.mDataEnabled.length;
            if (i >= r0) {
                break;
            }
            Integer[] numArr = new Object[DATA_CONNECTION_ACTIVE_PH_LINK_UP];
            numArr[DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE] = Integer.valueOf(i);
            numArr[DEFAULT_MDC_INITIAL_RETRY] = Boolean.valueOf(this.mDataEnabled[i]);
            pw.printf("  mDataEnabled[%d]=%b\n", numArr);
            i += DEFAULT_MDC_INITIAL_RETRY;
        }
        pw.flush();
        pw.println(" mEnabledCount=" + this.mEnabledCount);
        pw.println(" mRequestedApnType=" + this.mRequestedApnType);
        pw.println(" mPhone=" + this.mPhone.getPhoneName());
        pw.println(" mActivity=" + this.mActivity);
        pw.println(" mState=" + this.mState);
        pw.println(" mTxPkts=" + this.mTxPkts);
        pw.println(" mRxPkts=" + this.mRxPkts);
        pw.println(" mNetStatPollPeriod=" + this.mNetStatPollPeriod);
        pw.println(" mNetStatPollEnabled=" + this.mNetStatPollEnabled);
        pw.println(" mDataStallTxRxSum=" + this.mDataStallTxRxSum);
        pw.println(" mDataStallAlarmTag=" + this.mDataStallAlarmTag);
        pw.println(" mDataStallDetectionEanbled=" + this.mDataStallDetectionEnabled);
        pw.println(" mSentSinceLastRecv=" + this.mSentSinceLastRecv);
        pw.println(" mNoRecvPollCount=" + this.mNoRecvPollCount);
        pw.println(" mResolver=" + this.mResolver);
        pw.println(" mIsWifiConnected=" + this.mIsWifiConnected);
        pw.println(" mReconnectIntent=" + this.mReconnectIntent);
        pw.println(" mCidActive=" + this.mCidActive);
        pw.println(" mAutoAttachOnCreation=" + this.mAutoAttachOnCreation);
        pw.println(" mIsScreenOn=" + this.mIsScreenOn);
        pw.println(" mUniqueIdGenerator=" + this.mUniqueIdGenerator);
        pw.flush();
        pw.println(" ***************************************");
        DcController dcc = this.mDcc;
        if (dcc != null) {
            dcc.dump(fd, pw, args);
        } else {
            pw.println(" mDcc=null");
        }
        pw.println(" ***************************************");
        if (this.mDataConnections != null) {
            Set<Entry<Integer, DataConnection>> mDcSet = this.mDataConnections.entrySet();
            pw.println(" mDataConnections: count=" + mDcSet.size());
            for (Entry<Integer, DataConnection> entry : mDcSet) {
                Object[] objArr = new Object[DEFAULT_MDC_INITIAL_RETRY];
                objArr[DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE] = entry.getKey();
                pw.printf(" *** mDataConnection[%d] \n", objArr);
                ((DataConnection) entry.getValue()).dump(fd, pw, args);
            }
        } else {
            pw.println("mDataConnections=null");
        }
        pw.println(" ***************************************");
        pw.flush();
        HashMap<String, Integer> apnToDcId = this.mApnToDataConnectionId;
        if (apnToDcId != null) {
            Set<Entry<String, Integer>> apnToDcIdSet = apnToDcId.entrySet();
            pw.println(" mApnToDataConnectonId size=" + apnToDcIdSet.size());
            for (Entry<String, Integer> entry2 : apnToDcIdSet) {
                objArr = new Object[DATA_CONNECTION_ACTIVE_PH_LINK_UP];
                objArr[DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE] = entry2.getKey();
                objArr[DEFAULT_MDC_INITIAL_RETRY] = entry2.getValue();
                pw.printf(" mApnToDataConnectonId[%s]=%d\n", objArr);
            }
        } else {
            pw.println("mApnToDataConnectionId=null");
        }
        pw.println(" ***************************************");
        pw.flush();
        ConcurrentHashMap<String, ApnContext> apnCtxs = this.mApnContexts;
        if (apnCtxs != null) {
            Set<Entry<String, ApnContext>> apnCtxsSet = apnCtxs.entrySet();
            pw.println(" mApnContexts size=" + apnCtxsSet.size());
            for (Entry<String, ApnContext> entry3 : apnCtxsSet) {
                ((ApnContext) entry3.getValue()).dump(fd, pw, args);
            }
            pw.println(" ***************************************");
        } else {
            pw.println(" mApnContexts=null");
        }
        pw.flush();
        pw.println(" mActiveApn=" + this.mActiveApn);
        ArrayList<ApnSetting> apnSettings = this.mAllApnSettings;
        if (apnSettings != null) {
            pw.println(" mAllApnSettings size=" + apnSettings.size());
            for (i = DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE; i < apnSettings.size(); i += DEFAULT_MDC_INITIAL_RETRY) {
                numArr = new Object[DATA_CONNECTION_ACTIVE_PH_LINK_UP];
                numArr[DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE] = Integer.valueOf(i);
                numArr[DEFAULT_MDC_INITIAL_RETRY] = apnSettings.get(i);
                pw.printf(" mAllApnSettings[%d]: %s\n", numArr);
            }
            pw.flush();
        } else {
            pw.println(" mAllApnSettings=null");
        }
        pw.println(" mPreferredApn=" + this.mPreferredApn);
        pw.println(" mIsPsRestricted=" + this.mIsPsRestricted);
        pw.println(" mIsDisposed=" + this.mIsDisposed);
        pw.println(" mIntentReceiver=" + this.mIntentReceiver);
        pw.println(" mDataRoamingSettingObserver=" + this.mDataRoamingSettingObserver);
        pw.flush();
    }
}
