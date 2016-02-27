package com.android.internal.telephony;

import android.app.PendingIntent;
import android.content.Context;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.os.SystemClock;
import android.preference.PreferenceManager;
import android.provider.Telephony.BaseMmsColumns;
import android.telephony.CellInfo;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SignalStrength;
import android.telephony.SubscriptionManager;
import android.telephony.SubscriptionManager.OnSubscriptionsChangedListener;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Pair;
import android.util.TimeUtils;
import com.android.internal.telephony.dataconnection.DcTrackerBase;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppState;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.android.internal.telephony.uicc.UiccController;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public abstract class ServiceStateTracker extends Handler {
    protected static final String ACTION_RADIO_OFF = "android.intent.action.ACTION_RADIO_OFF";
    protected static final boolean DBG = true;
    public static final int DEFAULT_GPRS_CHECK_PERIOD_MILLIS = 60000;
    protected static final int EVENT_CDMA_PRL_VERSION_CHANGED = 40;
    protected static final int EVENT_CDMA_SUBSCRIPTION_SOURCE_CHANGED = 39;
    protected static final int EVENT_CHANGE_IMS_STATE = 45;
    protected static final int EVENT_CHECK_REPORT_GPRS = 22;
    protected static final int EVENT_ERI_FILE_LOADED = 36;
    protected static final int EVENT_GET_CELL_INFO_LIST = 43;
    protected static final int EVENT_GET_LOC_DONE = 15;
    protected static final int EVENT_GET_LOC_DONE_CDMA = 31;
    protected static final int EVENT_GET_PREFERRED_NETWORK_TYPE = 19;
    protected static final int EVENT_GET_SIGNAL_STRENGTH = 3;
    protected static final int EVENT_GET_SIGNAL_STRENGTH_CDMA = 29;
    public static final int EVENT_ICC_CHANGED = 42;
    protected static final int EVENT_IMS_STATE_CHANGED = 46;
    protected static final int EVENT_IMS_STATE_DONE = 47;
    protected static final int EVENT_LOCATION_UPDATES_ENABLED = 18;
    protected static final int EVENT_NETWORK_STATE_CHANGED = 2;
    protected static final int EVENT_NETWORK_STATE_CHANGED_CDMA = 30;
    protected static final int EVENT_NITZ_TIME = 11;
    protected static final int EVENT_NV_LOADED = 33;
    protected static final int EVENT_NV_READY = 35;
    protected static final int EVENT_OTA_PROVISION_STATUS_CHANGE = 37;
    protected static final int EVENT_POLL_SIGNAL_STRENGTH = 10;
    protected static final int EVENT_POLL_SIGNAL_STRENGTH_CDMA = 28;
    protected static final int EVENT_POLL_STATE_CDMA_SUBSCRIPTION = 34;
    protected static final int EVENT_POLL_STATE_GPRS = 5;
    protected static final int EVENT_POLL_STATE_NETWORK_SELECTION_MODE = 14;
    protected static final int EVENT_POLL_STATE_OPERATOR = 6;
    protected static final int EVENT_POLL_STATE_OPERATOR_CDMA = 25;
    protected static final int EVENT_POLL_STATE_REGISTRATION = 4;
    protected static final int EVENT_POLL_STATE_REGISTRATION_CDMA = 24;
    protected static final int EVENT_RADIO_AVAILABLE = 13;
    protected static final int EVENT_RADIO_ON = 41;
    protected static final int EVENT_RADIO_STATE_CHANGED = 1;
    protected static final int EVENT_RESET_PREFERRED_NETWORK_TYPE = 21;
    protected static final int EVENT_RESTRICTED_STATE_CHANGED = 23;
    protected static final int EVENT_RUIM_READY = 26;
    protected static final int EVENT_RUIM_RECORDS_LOADED = 27;
    protected static final int EVENT_SET_PREFERRED_NETWORK_TYPE = 20;
    protected static final int EVENT_SET_RADIO_POWER_OFF = 38;
    protected static final int EVENT_SIGNAL_STRENGTH_UPDATE = 12;
    protected static final int EVENT_SIM_READY = 17;
    protected static final int EVENT_SIM_RECORDS_LOADED = 16;
    protected static final int EVENT_UNSOL_CELL_INFO_LIST = 44;
    protected static final String[] GMT_COUNTRY_CODES;
    private static final long LAST_CELL_INFO_LIST_MAX_AGE_MS = 2000;
    private static final String LOG_TAG = "SST";
    public static final int OTASP_NEEDED = 2;
    public static final int OTASP_NOT_NEEDED = 3;
    public static final int OTASP_UNINITIALIZED = 0;
    public static final int OTASP_UNKNOWN = 1;
    protected static final int POLL_PERIOD_MILLIS = 20000;
    protected static final String PROP_FORCE_ROAMING = "telephony.test.forceRoaming";
    protected static final String REGISTRATION_DENIED_AUTH = "Authentication Failure";
    protected static final String REGISTRATION_DENIED_GEN = "General";
    protected static final String TIMEZONE_PROPERTY = "persist.sys.timezone";
    protected static final boolean VDBG = false;
    protected boolean mAlarmSwitch;
    protected RegistrantList mAttachedRegistrants;
    protected final CellInfo mCellInfo;
    protected CommandsInterface mCi;
    protected String mCurPlmn;
    protected boolean mCurShowPlmn;
    protected boolean mCurShowSpn;
    protected String mCurSpn;
    protected RegistrantList mDataRegStateOrRatChangedRegistrants;
    protected RegistrantList mDataRoamingOffRegistrants;
    protected RegistrantList mDataRoamingOnRegistrants;
    protected boolean mDesiredPowerState;
    protected RegistrantList mDetachedRegistrants;
    protected boolean mDeviceShuttingDown;
    protected boolean mDontPollSignalStrength;
    protected IccRecords mIccRecords;
    private boolean mImsRegistered;
    protected boolean mImsRegistrationOnOff;
    protected IntentFilter mIntentFilter;
    protected List<CellInfo> mLastCellInfoList;
    protected long mLastCellInfoListTime;
    private SignalStrength mLastSignalStrength;
    protected RegistrantList mNetworkAttachedRegistrants;
    protected ServiceState mNewSS;
    protected final SstSubscriptionsChangedListener mOnSubscriptionsChangedListener;
    protected boolean mPendingRadioPowerOffAfterDataOff;
    protected int mPendingRadioPowerOffAfterDataOffTag;
    protected PhoneBase mPhoneBase;
    protected int[] mPollingContext;
    protected boolean mPowerOffDelayNeed;
    protected RegistrantList mPsRestrictDisabledRegistrants;
    protected RegistrantList mPsRestrictEnabledRegistrants;
    protected PendingIntent mRadioOffIntent;
    public RestrictedState mRestrictedState;
    public ServiceState mSS;
    protected SignalStrength mSignalStrength;
    protected boolean mSpnUpdatePending;
    protected SubscriptionController mSubscriptionController;
    protected SubscriptionManager mSubscriptionManager;
    protected UiccCardApplication mUiccApplcation;
    protected UiccController mUiccController;
    protected boolean mVoiceCapable;
    protected RegistrantList mVoiceRoamingOffRegistrants;
    protected RegistrantList mVoiceRoamingOnRegistrants;
    private boolean mWantContinuousLocationUpdates;
    private boolean mWantSingleLocationUpdate;

    private class CellInfoResult {
        List<CellInfo> list;
        Object lockObj;

        private CellInfoResult() {
            this.lockObj = new Object();
        }
    }

    protected class SstSubscriptionsChangedListener extends OnSubscriptionsChangedListener {
        public final AtomicInteger mPreviousSubId;

        protected SstSubscriptionsChangedListener() {
            this.mPreviousSubId = new AtomicInteger(-1);
        }

        public void onSubscriptionsChanged() {
            ServiceStateTracker.this.log("SubscriptionListener.onSubscriptionInfoChanged");
            int subId = ServiceStateTracker.this.mPhoneBase.getSubId();
            if (this.mPreviousSubId.getAndSet(subId) != subId && SubscriptionManager.isValidSubscriptionId(subId)) {
                Context context = ServiceStateTracker.this.mPhoneBase.getContext();
                ServiceStateTracker.this.mCi.setPreferredNetworkType(PhoneFactory.calculatePreferredNetworkType(context, subId), null);
                ServiceStateTracker.this.mPhoneBase.notifyCallForwardingIndicator();
                if (!context.getResources().getBoolean(17956952)) {
                    ServiceStateTracker.this.mPhoneBase.restoreSavedNetworkSelection(null);
                }
                ServiceStateTracker.this.mPhoneBase.setSystemProperty("gsm.network.type", ServiceState.rilRadioTechnologyToString(ServiceStateTracker.this.mSS.getRilDataRadioTechnology()));
                if (ServiceStateTracker.this.mSpnUpdatePending) {
                    ServiceStateTracker.this.mSubscriptionController.setPlmnSpn(ServiceStateTracker.this.mPhoneBase.getPhoneId(), ServiceStateTracker.this.mCurShowPlmn, ServiceStateTracker.this.mCurPlmn, ServiceStateTracker.this.mCurShowSpn, ServiceStateTracker.this.mCurSpn);
                    ServiceStateTracker.this.mSpnUpdatePending = false;
                }
                SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(context);
                String oldNetworkSelectionName = sp.getString(PhoneBase.NETWORK_SELECTION_NAME_KEY, "");
                String oldNetworkSelection = sp.getString(PhoneBase.NETWORK_SELECTION_KEY, "");
                if (!TextUtils.isEmpty(oldNetworkSelectionName) || !TextUtils.isEmpty(oldNetworkSelection)) {
                    Editor editor = sp.edit();
                    editor.putString(PhoneBase.NETWORK_SELECTION_NAME_KEY + subId, oldNetworkSelectionName);
                    editor.putString(PhoneBase.NETWORK_SELECTION_KEY + subId, oldNetworkSelection);
                    editor.remove(PhoneBase.NETWORK_SELECTION_NAME_KEY);
                    editor.remove(PhoneBase.NETWORK_SELECTION_KEY);
                    editor.commit();
                }
            }
        }
    }

    public abstract int getCurrentDataConnectionState();

    protected abstract Phone getPhone();

    protected abstract void handlePollStateResult(int i, AsyncResult asyncResult);

    protected abstract void hangupAndPowerOff();

    public abstract boolean isConcurrentVoiceAndDataAllowed();

    protected abstract void log(String str);

    protected abstract void loge(String str);

    protected abstract void onUpdateIccAvailability();

    public abstract void pollState();

    public abstract void setImsRegistrationState(boolean z);

    protected abstract void setPowerStateToDesired();

    protected abstract void setRoamingType(ServiceState serviceState);

    protected abstract void updateSpnDisplay();

    static {
        String[] strArr = new String[EVENT_SET_PREFERRED_NETWORK_TYPE];
        strArr[OTASP_UNINITIALIZED] = "bf";
        strArr[OTASP_UNKNOWN] = "ci";
        strArr[OTASP_NEEDED] = "eh";
        strArr[OTASP_NOT_NEEDED] = "fo";
        strArr[EVENT_POLL_STATE_REGISTRATION] = "gb";
        strArr[EVENT_POLL_STATE_GPRS] = "gh";
        strArr[EVENT_POLL_STATE_OPERATOR] = "gm";
        strArr[7] = "gn";
        strArr[8] = "gw";
        strArr[9] = "ie";
        strArr[EVENT_POLL_SIGNAL_STRENGTH] = "lr";
        strArr[EVENT_NITZ_TIME] = "is";
        strArr[EVENT_SIGNAL_STRENGTH_UPDATE] = "ma";
        strArr[EVENT_RADIO_AVAILABLE] = "ml";
        strArr[EVENT_POLL_STATE_NETWORK_SELECTION_MODE] = "mr";
        strArr[EVENT_GET_LOC_DONE] = "pt";
        strArr[EVENT_SIM_RECORDS_LOADED] = "sl";
        strArr[EVENT_SIM_READY] = "sn";
        strArr[EVENT_LOCATION_UPDATES_ENABLED] = BaseMmsColumns.STATUS;
        strArr[EVENT_GET_PREFERRED_NETWORK_TYPE] = "tg";
        GMT_COUNTRY_CODES = strArr;
    }

    protected ServiceStateTracker(PhoneBase phoneBase, CommandsInterface ci, CellInfo cellInfo) {
        this.mUiccController = null;
        this.mUiccApplcation = null;
        this.mIccRecords = null;
        this.mSS = new ServiceState();
        this.mNewSS = new ServiceState();
        this.mLastCellInfoList = null;
        this.mSignalStrength = new SignalStrength();
        this.mRestrictedState = new RestrictedState();
        this.mDontPollSignalStrength = false;
        this.mVoiceRoamingOnRegistrants = new RegistrantList();
        this.mVoiceRoamingOffRegistrants = new RegistrantList();
        this.mDataRoamingOnRegistrants = new RegistrantList();
        this.mDataRoamingOffRegistrants = new RegistrantList();
        this.mAttachedRegistrants = new RegistrantList();
        this.mDetachedRegistrants = new RegistrantList();
        this.mDataRegStateOrRatChangedRegistrants = new RegistrantList();
        this.mNetworkAttachedRegistrants = new RegistrantList();
        this.mPsRestrictEnabledRegistrants = new RegistrantList();
        this.mPsRestrictDisabledRegistrants = new RegistrantList();
        this.mPendingRadioPowerOffAfterDataOff = false;
        this.mPendingRadioPowerOffAfterDataOffTag = OTASP_UNINITIALIZED;
        this.mImsRegistrationOnOff = false;
        this.mAlarmSwitch = false;
        this.mIntentFilter = null;
        this.mRadioOffIntent = null;
        this.mPowerOffDelayNeed = DBG;
        this.mDeviceShuttingDown = false;
        this.mSpnUpdatePending = false;
        this.mCurSpn = null;
        this.mCurPlmn = null;
        this.mCurShowPlmn = false;
        this.mCurShowSpn = false;
        this.mImsRegistered = false;
        this.mOnSubscriptionsChangedListener = new SstSubscriptionsChangedListener();
        this.mLastSignalStrength = null;
        this.mPhoneBase = phoneBase;
        this.mCellInfo = cellInfo;
        this.mCi = ci;
        this.mVoiceCapable = this.mPhoneBase.getContext().getResources().getBoolean(17956946);
        this.mUiccController = UiccController.getInstance();
        this.mUiccController.registerForIccChanged(this, EVENT_ICC_CHANGED, null);
        this.mCi.setOnSignalStrengthUpdate(this, EVENT_SIGNAL_STRENGTH_UPDATE, null);
        this.mCi.registerForCellInfoList(this, EVENT_UNSOL_CELL_INFO_LIST, null);
        this.mSubscriptionController = SubscriptionController.getInstance();
        this.mSubscriptionManager = SubscriptionManager.from(phoneBase.getContext());
        this.mSubscriptionManager.addOnSubscriptionsChangedListener(this.mOnSubscriptionsChangedListener);
        this.mPhoneBase.setSystemProperty("gsm.network.type", ServiceState.rilRadioTechnologyToString(OTASP_UNINITIALIZED));
        this.mCi.registerForImsNetworkStateChanged(this, EVENT_IMS_STATE_CHANGED, null);
    }

    void requestShutdown() {
        if (this.mDeviceShuttingDown != DBG) {
            this.mDeviceShuttingDown = DBG;
            this.mDesiredPowerState = false;
            setPowerStateToDesired();
        }
    }

    public void dispose() {
        this.mCi.unSetOnSignalStrengthUpdate(this);
        this.mUiccController.unregisterForIccChanged(this);
        this.mCi.unregisterForCellInfoList(this);
        this.mSubscriptionManager.removeOnSubscriptionsChangedListener(this.mOnSubscriptionsChangedListener);
    }

    public boolean getDesiredPowerState() {
        return this.mDesiredPowerState;
    }

    protected boolean notifySignalStrength() {
        boolean notified = false;
        synchronized (this.mCellInfo) {
            if (!this.mSignalStrength.equals(this.mLastSignalStrength)) {
                try {
                    this.mPhoneBase.notifySignalStrength();
                    notified = DBG;
                } catch (NullPointerException ex) {
                    loge("updateSignalStrength() Phone already destroyed: " + ex + "SignalStrength not notified");
                }
            }
        }
        return notified;
    }

    protected void notifyDataRegStateRilRadioTechnologyChanged() {
        int rat = this.mSS.getRilDataRadioTechnology();
        int drs = this.mSS.getDataRegState();
        log("notifyDataRegStateRilRadioTechnologyChanged: drs=" + drs + " rat=" + rat);
        this.mPhoneBase.setSystemProperty("gsm.network.type", ServiceState.rilRadioTechnologyToString(rat));
        this.mDataRegStateOrRatChangedRegistrants.notifyResult(new Pair(Integer.valueOf(drs), Integer.valueOf(rat)));
    }

    protected void useDataRegStateForDataOnlyDevices() {
        if (!this.mVoiceCapable) {
            log("useDataRegStateForDataOnlyDevice: VoiceRegState=" + this.mNewSS.getVoiceRegState() + " DataRegState=" + this.mNewSS.getDataRegState());
            this.mNewSS.setVoiceRegState(this.mNewSS.getDataRegState());
        }
    }

    protected void updatePhoneObject() {
        if (this.mPhoneBase.getContext().getResources().getBoolean(17957007)) {
            boolean isRegistered = (this.mSS.getVoiceRegState() == 0 || this.mSS.getVoiceRegState() == OTASP_NEEDED) ? DBG : false;
            if (isRegistered) {
                this.mPhoneBase.updatePhoneObject(this.mSS.getRilVoiceRadioTechnology());
            } else {
                Rlog.d(LOG_TAG, "updatePhoneObject: Ignore update");
            }
        }
    }

    public void registerForVoiceRoamingOn(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mVoiceRoamingOnRegistrants.add(r);
        if (this.mSS.getVoiceRoaming()) {
            r.notifyRegistrant();
        }
    }

    public void unregisterForVoiceRoamingOn(Handler h) {
        this.mVoiceRoamingOnRegistrants.remove(h);
    }

    public void registerForVoiceRoamingOff(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mVoiceRoamingOffRegistrants.add(r);
        if (!this.mSS.getVoiceRoaming()) {
            r.notifyRegistrant();
        }
    }

    public void unregisterForVoiceRoamingOff(Handler h) {
        this.mVoiceRoamingOffRegistrants.remove(h);
    }

    public void registerForDataRoamingOn(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mDataRoamingOnRegistrants.add(r);
        if (this.mSS.getDataRoaming()) {
            r.notifyRegistrant();
        }
    }

    public void unregisterForDataRoamingOn(Handler h) {
        this.mDataRoamingOnRegistrants.remove(h);
    }

    public void registerForDataRoamingOff(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mDataRoamingOffRegistrants.add(r);
        if (!this.mSS.getDataRoaming()) {
            r.notifyRegistrant();
        }
    }

    public void unregisterForDataRoamingOff(Handler h) {
        this.mDataRoamingOffRegistrants.remove(h);
    }

    public void reRegisterNetwork(Message onComplete) {
        this.mCi.getPreferredNetworkType(obtainMessage(EVENT_GET_PREFERRED_NETWORK_TYPE, onComplete));
    }

    public void setRadioPower(boolean power) {
        this.mDesiredPowerState = power;
        setPowerStateToDesired();
    }

    public void enableSingleLocationUpdate() {
        if (!this.mWantSingleLocationUpdate && !this.mWantContinuousLocationUpdates) {
            this.mWantSingleLocationUpdate = DBG;
            this.mCi.setLocationUpdates(DBG, obtainMessage(EVENT_LOCATION_UPDATES_ENABLED));
        }
    }

    public void enableLocationUpdates() {
        if (!this.mWantSingleLocationUpdate && !this.mWantContinuousLocationUpdates) {
            this.mWantContinuousLocationUpdates = DBG;
            this.mCi.setLocationUpdates(DBG, obtainMessage(EVENT_LOCATION_UPDATES_ENABLED));
        }
    }

    protected void disableSingleLocationUpdate() {
        this.mWantSingleLocationUpdate = false;
        if (!this.mWantSingleLocationUpdate && !this.mWantContinuousLocationUpdates) {
            this.mCi.setLocationUpdates(false, null);
        }
    }

    public void disableLocationUpdates() {
        this.mWantContinuousLocationUpdates = false;
        if (!this.mWantSingleLocationUpdate && !this.mWantContinuousLocationUpdates) {
            this.mCi.setLocationUpdates(false, null);
        }
    }

    public void handleMessage(Message msg) {
        AsyncResult ar;
        switch (msg.what) {
            case EVENT_SET_RADIO_POWER_OFF /*38*/:
                synchronized (this) {
                    if (!this.mPendingRadioPowerOffAfterDataOff || msg.arg1 != this.mPendingRadioPowerOffAfterDataOffTag) {
                        log("EVENT_SET_RADIO_OFF is stale arg1=" + msg.arg1 + "!= tag=" + this.mPendingRadioPowerOffAfterDataOffTag);
                        break;
                    }
                    log("EVENT_SET_RADIO_OFF, turn radio off now.");
                    hangupAndPowerOff();
                    this.mPendingRadioPowerOffAfterDataOffTag += OTASP_UNKNOWN;
                    this.mPendingRadioPowerOffAfterDataOff = false;
                    break;
                }
            case EVENT_ICC_CHANGED /*42*/:
                onUpdateIccAvailability();
            case EVENT_GET_CELL_INFO_LIST /*43*/:
                ar = msg.obj;
                CellInfoResult result = ar.userObj;
                synchronized (result.lockObj) {
                    if (ar.exception == null) {
                        result.list = (List) ar.result;
                        break;
                    } else {
                        log("EVENT_GET_CELL_INFO_LIST: error ret null, e=" + ar.exception);
                        result.list = null;
                    }
                    this.mLastCellInfoListTime = SystemClock.elapsedRealtime();
                    this.mLastCellInfoList = result.list;
                    result.lockObj.notify();
                    break;
                }
            case EVENT_UNSOL_CELL_INFO_LIST /*44*/:
                ar = (AsyncResult) msg.obj;
                if (ar.exception != null) {
                    log("EVENT_UNSOL_CELL_INFO_LIST: error ignoring, e=" + ar.exception);
                    return;
                }
                List<CellInfo> list = ar.result;
                log("EVENT_UNSOL_CELL_INFO_LIST: size=" + list.size() + " list=" + list);
                this.mLastCellInfoListTime = SystemClock.elapsedRealtime();
                this.mLastCellInfoList = list;
                this.mPhoneBase.notifyCellInfo(list);
            case EVENT_IMS_STATE_CHANGED /*46*/:
                this.mCi.getImsRegistrationState(obtainMessage(EVENT_IMS_STATE_DONE));
            case EVENT_IMS_STATE_DONE /*47*/:
                ar = (AsyncResult) msg.obj;
                if (ar.exception == null) {
                    this.mImsRegistered = ((int[]) ((int[]) ar.result))[OTASP_UNINITIALIZED] == OTASP_UNKNOWN ? DBG : false;
                }
            default:
                log("Unhandled message with number: " + msg.what);
        }
    }

    public void registerForDataConnectionAttached(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mAttachedRegistrants.add(r);
        if (getCurrentDataConnectionState() == 0) {
            r.notifyRegistrant();
        }
    }

    public void unregisterForDataConnectionAttached(Handler h) {
        this.mAttachedRegistrants.remove(h);
    }

    public void registerForDataConnectionDetached(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mDetachedRegistrants.add(r);
        if (getCurrentDataConnectionState() != 0) {
            r.notifyRegistrant();
        }
    }

    public void unregisterForDataConnectionDetached(Handler h) {
        this.mDetachedRegistrants.remove(h);
    }

    public void registerForDataRegStateOrRatChanged(Handler h, int what, Object obj) {
        this.mDataRegStateOrRatChangedRegistrants.add(new Registrant(h, what, obj));
        notifyDataRegStateRilRadioTechnologyChanged();
    }

    public void unregisterForDataRegStateOrRatChanged(Handler h) {
        this.mDataRegStateOrRatChangedRegistrants.remove(h);
    }

    public void registerForNetworkAttached(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mNetworkAttachedRegistrants.add(r);
        if (this.mSS.getVoiceRegState() == 0) {
            r.notifyRegistrant();
        }
    }

    public void unregisterForNetworkAttached(Handler h) {
        this.mNetworkAttachedRegistrants.remove(h);
    }

    public void registerForPsRestrictedEnabled(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mPsRestrictEnabledRegistrants.add(r);
        if (this.mRestrictedState.isPsRestricted()) {
            r.notifyRegistrant();
        }
    }

    public void unregisterForPsRestrictedEnabled(Handler h) {
        this.mPsRestrictEnabledRegistrants.remove(h);
    }

    public void registerForPsRestrictedDisabled(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mPsRestrictDisabledRegistrants.add(r);
        if (this.mRestrictedState.isPsRestricted()) {
            r.notifyRegistrant();
        }
    }

    public void unregisterForPsRestrictedDisabled(Handler h) {
        this.mPsRestrictDisabledRegistrants.remove(h);
    }

    public void powerOffRadioSafely(DcTrackerBase dcTracker) {
        synchronized (this) {
            if (!this.mPendingRadioPowerOffAfterDataOff) {
                String[] networkNotClearData = this.mPhoneBase.getContext().getResources().getStringArray(17236030);
                String currentNetwork = this.mSS.getOperatorNumeric();
                if (!(networkNotClearData == null || currentNetwork == null)) {
                    for (int i = OTASP_UNINITIALIZED; i < networkNotClearData.length; i += OTASP_UNKNOWN) {
                        if (currentNetwork.equals(networkNotClearData[i])) {
                            log("Not disconnecting data for " + currentNetwork);
                            hangupAndPowerOff();
                            return;
                        }
                    }
                }
                if (dcTracker.isDisconnected()) {
                    dcTracker.cleanUpAllConnections(Phone.REASON_RADIO_TURNED_OFF);
                    log("Data disconnected, turn off radio right away.");
                    hangupAndPowerOff();
                } else {
                    dcTracker.cleanUpAllConnections(Phone.REASON_RADIO_TURNED_OFF);
                    Message msg = Message.obtain(this);
                    msg.what = EVENT_SET_RADIO_POWER_OFF;
                    int i2 = this.mPendingRadioPowerOffAfterDataOffTag + OTASP_UNKNOWN;
                    this.mPendingRadioPowerOffAfterDataOffTag = i2;
                    msg.arg1 = i2;
                    if (sendMessageDelayed(msg, 30000)) {
                        log("Wait upto 30s for data to disconnect, then turn off radio.");
                        this.mPendingRadioPowerOffAfterDataOff = DBG;
                    } else {
                        log("Cannot send delayed Msg, turn off radio right away.");
                        hangupAndPowerOff();
                    }
                }
            }
        }
    }

    public boolean processPendingRadioPowerOffAfterDataOff() {
        boolean z = false;
        synchronized (this) {
            if (this.mPendingRadioPowerOffAfterDataOff) {
                log("Process pending request to turn radio off.");
                this.mPendingRadioPowerOffAfterDataOffTag += OTASP_UNKNOWN;
                hangupAndPowerOff();
                this.mPendingRadioPowerOffAfterDataOff = false;
                z = DBG;
            }
        }
        return z;
    }

    protected boolean onSignalStrengthResult(AsyncResult ar, boolean isGsm) {
        SignalStrength oldSignalStrength = this.mSignalStrength;
        if (ar.exception != null || ar.result == null) {
            log("onSignalStrengthResult() Exception from RIL : " + ar.exception);
            this.mSignalStrength = new SignalStrength(isGsm);
        } else {
            this.mSignalStrength = (SignalStrength) ar.result;
            this.mSignalStrength.validateInput();
            this.mSignalStrength.setGsm(isGsm);
        }
        return notifySignalStrength();
    }

    protected void cancelPollState() {
        this.mPollingContext = new int[OTASP_UNKNOWN];
    }

    protected boolean shouldFixTimeZoneNow(PhoneBase phoneBase, String operatorNumeric, String prevOperatorNumeric, boolean needToFixTimeZone) {
        try {
            int prevMcc;
            boolean retVal;
            int mcc = Integer.parseInt(operatorNumeric.substring(OTASP_UNINITIALIZED, OTASP_NOT_NEEDED));
            try {
                prevMcc = Integer.parseInt(prevOperatorNumeric.substring(OTASP_UNINITIALIZED, OTASP_NOT_NEEDED));
            } catch (Exception e) {
                prevMcc = mcc + OTASP_UNKNOWN;
            }
            boolean iccCardExist = false;
            if (this.mUiccApplcation != null) {
                if (this.mUiccApplcation.getState() != AppState.APPSTATE_UNKNOWN) {
                    iccCardExist = DBG;
                } else {
                    iccCardExist = false;
                }
            }
            if ((!iccCardExist || mcc == prevMcc) && !needToFixTimeZone) {
                retVal = false;
            } else {
                retVal = DBG;
            }
            log("shouldFixTimeZoneNow: retVal=" + retVal + " iccCardExist=" + iccCardExist + " operatorNumeric=" + operatorNumeric + " mcc=" + mcc + " prevOperatorNumeric=" + prevOperatorNumeric + " prevMcc=" + prevMcc + " needToFixTimeZone=" + needToFixTimeZone + " ltod=" + TimeUtils.logTimeOfDay(System.currentTimeMillis()));
            return retVal;
        } catch (Exception e2) {
            log("shouldFixTimeZoneNow: no mcc, operatorNumeric=" + operatorNumeric + " retVal=false");
            return false;
        }
    }

    public String getSystemProperty(String property, String defValue) {
        return TelephonyManager.getTelephonyProperty(this.mPhoneBase.getPhoneId(), property, defValue);
    }

    public List<CellInfo> getAllCellInfo() {
        List<CellInfo> list = null;
        CellInfoResult result = new CellInfoResult();
        if (this.mCi.getRilVersion() < 8) {
            log("SST.getAllCellInfo(): not implemented");
            result.list = null;
        } else if (!isCallerOnDifferentThread()) {
            log("SST.getAllCellInfo(): return last, same thread can't block");
            result.list = this.mLastCellInfoList;
        } else if (SystemClock.elapsedRealtime() - this.mLastCellInfoListTime > LAST_CELL_INFO_LIST_MAX_AGE_MS) {
            Message msg = obtainMessage(EVENT_GET_CELL_INFO_LIST, result);
            synchronized (result.lockObj) {
                result.list = null;
                this.mCi.getCellInfoList(msg);
                try {
                    result.lockObj.wait(5000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        } else {
            log("SST.getAllCellInfo(): return last, back to back calls");
            result.list = this.mLastCellInfoList;
        }
        synchronized (result.lockObj) {
            if (result.list != null) {
                log("SST.getAllCellInfo(): X size=" + result.list.size() + " list=" + result.list);
                list = result.list;
            } else {
                log("SST.getAllCellInfo(): X size=0 list=null");
            }
        }
        return list;
    }

    public SignalStrength getSignalStrength() {
        SignalStrength signalStrength;
        synchronized (this.mCellInfo) {
            signalStrength = this.mSignalStrength;
        }
        return signalStrength;
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("ServiceStateTracker:");
        pw.println(" mSS=" + this.mSS);
        pw.println(" mNewSS=" + this.mNewSS);
        pw.println(" mCellInfo=" + this.mCellInfo);
        pw.println(" mRestrictedState=" + this.mRestrictedState);
        pw.println(" mPollingContext=" + this.mPollingContext);
        pw.println(" mDesiredPowerState=" + this.mDesiredPowerState);
        pw.println(" mDontPollSignalStrength=" + this.mDontPollSignalStrength);
        pw.println(" mPendingRadioPowerOffAfterDataOff=" + this.mPendingRadioPowerOffAfterDataOff);
        pw.println(" mPendingRadioPowerOffAfterDataOffTag=" + this.mPendingRadioPowerOffAfterDataOffTag);
        pw.flush();
    }

    public boolean isImsRegistered() {
        return this.mImsRegistered;
    }

    protected void checkCorrectThread() {
        if (Thread.currentThread() != getLooper().getThread()) {
            throw new RuntimeException("ServiceStateTracker must be used from within one thread");
        }
    }

    protected boolean isCallerOnDifferentThread() {
        return Thread.currentThread() != getLooper().getThread() ? DBG : false;
    }

    protected void updateCarrierMccMncConfiguration(String newOp, String oldOp, Context context) {
        if ((newOp == null && !TextUtils.isEmpty(oldOp)) || (newOp != null && !newOp.equals(oldOp))) {
            log("update mccmnc=" + newOp + " fromServiceState=true");
            MccTable.updateMccMncConfiguration(context, newOp, DBG);
        }
    }

    protected boolean inSameCountry(String operatorNumeric) {
        if (TextUtils.isEmpty(operatorNumeric) || operatorNumeric.length() < EVENT_POLL_STATE_GPRS) {
            return false;
        }
        String homeNumeric = getHomeOperatorNumeric();
        if (TextUtils.isEmpty(homeNumeric) || homeNumeric.length() < EVENT_POLL_STATE_GPRS) {
            return false;
        }
        String networkMCC = operatorNumeric.substring(OTASP_UNINITIALIZED, OTASP_NOT_NEEDED);
        String homeMCC = homeNumeric.substring(OTASP_UNINITIALIZED, OTASP_NOT_NEEDED);
        String networkCountry = MccTable.countryCodeForMcc(Integer.parseInt(networkMCC));
        String homeCountry = MccTable.countryCodeForMcc(Integer.parseInt(homeMCC));
        if (networkCountry.isEmpty() || homeCountry.isEmpty()) {
            return false;
        }
        boolean inSameCountry = homeCountry.equals(networkCountry);
        if (inSameCountry) {
            return inSameCountry;
        }
        if ("us".equals(homeCountry) && "vi".equals(networkCountry)) {
            return DBG;
        }
        if ("vi".equals(homeCountry) && "us".equals(networkCountry)) {
            return DBG;
        }
        return inSameCountry;
    }

    protected String getHomeOperatorNumeric() {
        return ((TelephonyManager) this.mPhoneBase.getContext().getSystemService("phone")).getSimOperatorNumericForPhone(this.mPhoneBase.getPhoneId());
    }

    protected int getPhoneId() {
        return this.mPhoneBase.getPhoneId();
    }
}
