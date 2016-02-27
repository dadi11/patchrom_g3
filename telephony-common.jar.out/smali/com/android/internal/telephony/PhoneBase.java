package com.android.internal.telephony;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.net.LinkProperties;
import android.net.NetworkCapabilities;
import android.net.wifi.WifiManager;
import android.os.AsyncResult;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.os.SystemProperties;
import android.preference.PreferenceManager;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.provider.Settings.SettingNotFoundException;
import android.telephony.CellIdentityCdma;
import android.telephony.CellInfo;
import android.telephony.CellInfoCdma;
import android.telephony.DataConnectionRealTimeInfo;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SignalStrength;
import android.telephony.SubscriptionManager;
import android.telephony.VoLteServiceState;
import android.text.TextUtils;
import com.android.ims.ImsManager;
import com.android.internal.telephony.Call.SrvccState;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.android.internal.telephony.PhoneConstants.State;
import com.android.internal.telephony.dataconnection.DcTrackerBase;
import com.android.internal.telephony.imsphone.ImsPhone;
import com.android.internal.telephony.test.SimulatedRadioControl;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppType;
import com.android.internal.telephony.uicc.IccFileHandler;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.IsimRecords;
import com.android.internal.telephony.uicc.UiccCard;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.android.internal.telephony.uicc.UiccController;
import com.android.internal.telephony.uicc.UsimServiceTable;
import com.google.android.mms.pdu.CharacterSets;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.concurrent.atomic.AtomicReference;

public abstract class PhoneBase extends Handler implements Phone {
    private static final String CDMA_NON_ROAMING_LIST_OVERRIDE_PREFIX = "cdma_non_roaming_list_";
    private static final String CDMA_ROAMING_LIST_OVERRIDE_PREFIX = "cdma_roaming_list_";
    public static final String CLIR_KEY = "clir_key";
    public static final String DATA_DISABLED_ON_BOOT_KEY = "disabled_on_boot_key";
    public static final String DNS_SERVER_CHECK_DISABLED_KEY = "dns_server_check_disabled_key";
    protected static final int EVENT_CALL_RING = 14;
    protected static final int EVENT_CALL_RING_CONTINUE = 15;
    protected static final int EVENT_CDMA_SUBSCRIPTION_SOURCE_CHANGED = 27;
    protected static final int EVENT_EMERGENCY_CALLBACK_MODE_ENTER = 25;
    protected static final int EVENT_EXIT_EMERGENCY_CALLBACK_RESPONSE = 26;
    protected static final int EVENT_GET_BASEBAND_VERSION_DONE = 6;
    protected static final int EVENT_GET_CALL_FORWARD_DONE = 13;
    protected static final int EVENT_GET_DEVICE_IDENTITY_DONE = 21;
    protected static final int EVENT_GET_IMEISV_DONE = 10;
    protected static final int EVENT_GET_IMEI_DONE = 9;
    protected static final int EVENT_GET_RADIO_CAPABILITY = 35;
    protected static final int EVENT_GET_SIM_STATUS_DONE = 11;
    protected static final int EVENT_ICC_CHANGED = 30;
    protected static final int EVENT_ICC_RECORD_EVENTS = 29;
    protected static final int EVENT_INITIATE_SILENT_REDIAL = 32;
    protected static final int EVENT_LAST = 36;
    protected static final int EVENT_MMI_DONE = 4;
    protected static final int EVENT_NV_READY = 23;
    protected static final int EVENT_RADIO_AVAILABLE = 1;
    protected static final int EVENT_RADIO_NOT_AVAILABLE = 33;
    protected static final int EVENT_RADIO_OFF_OR_NOT_AVAILABLE = 8;
    protected static final int EVENT_RADIO_ON = 5;
    protected static final int EVENT_REGISTERED_TO_NETWORK = 19;
    protected static final int EVENT_RUIM_RECORDS_LOADED = 22;
    protected static final int EVENT_SET_CALL_FORWARD_DONE = 12;
    protected static final int EVENT_SET_CLIR_COMPLETE = 18;
    protected static final int EVENT_SET_ENHANCED_VP = 24;
    protected static final int EVENT_SET_NETWORK_AUTOMATIC = 28;
    protected static final int EVENT_SET_NETWORK_AUTOMATIC_COMPLETE = 17;
    protected static final int EVENT_SET_NETWORK_MANUAL_COMPLETE = 16;
    protected static final int EVENT_SET_VM_NUMBER_DONE = 20;
    protected static final int EVENT_SIM_RECORDS_LOADED = 3;
    protected static final int EVENT_SRVCC_STATE_CHANGED = 31;
    protected static final int EVENT_SS = 36;
    protected static final int EVENT_SSN = 2;
    protected static final int EVENT_UNSOL_OEM_HOOK_RAW = 34;
    protected static final int EVENT_USSD = 7;
    private static final String GSM_NON_ROAMING_LIST_OVERRIDE_PREFIX = "gsm_non_roaming_list_";
    private static final String GSM_ROAMING_LIST_OVERRIDE_PREFIX = "gsm_roaming_list_";
    private static final String LOG_TAG = "PhoneBase";
    public static final String NETWORK_SELECTION_KEY = "network_selection_key";
    public static final String NETWORK_SELECTION_NAME_KEY = "network_selection_name_key";
    public static final String VM_COUNT = "vm_count_key";
    public static final String VM_ID = "vm_id_key";
    protected static ImsPhone mImsPhone;
    private final String mActionAttached;
    private final String mActionDetached;
    int mCallRingContinueToken;
    int mCallRingDelay;
    public CommandsInterface mCi;
    protected final Context mContext;
    public DcTrackerBase mDcTracker;
    protected final RegistrantList mDisconnectRegistrants;
    boolean mDnsCheckDisabled;
    boolean mDoesRilSendMultipleCallRing;
    protected final RegistrantList mHandoverRegistrants;
    public AtomicReference<IccRecords> mIccRecords;
    private BroadcastReceiver mImsIntentReceiver;
    private final Object mImsLock;
    private boolean mImsServiceReady;
    protected final RegistrantList mIncomingRingRegistrants;
    public boolean mIsTheCurrentActivePhone;
    boolean mIsVoiceCapable;
    protected Looper mLooper;
    protected final RegistrantList mMmiCompleteRegistrants;
    protected final RegistrantList mMmiRegistrants;
    private final String mName;
    protected final RegistrantList mNewRingingConnectionRegistrants;
    protected PhoneNotifier mNotifier;
    protected int mPhoneId;
    protected final RegistrantList mPreciseCallStateRegistrants;
    protected int mRadioAccessFamily;
    protected final RegistrantList mRadioOffOrNotAvailableRegistrants;
    protected final RegistrantList mServiceStateRegistrants;
    protected final RegistrantList mSimRecordsLoadedRegistrants;
    protected SimulatedRadioControl mSimulatedRadioControl;
    public SmsStorageMonitor mSmsStorageMonitor;
    public SmsUsageMonitor mSmsUsageMonitor;
    protected final RegistrantList mSuppServiceFailedRegistrants;
    private TelephonyTester mTelephonyTester;
    protected AtomicReference<UiccCardApplication> mUiccApplication;
    protected UiccController mUiccController;
    boolean mUnitTestMode;
    protected final RegistrantList mUnknownConnectionRegistrants;
    private int mVmCount;

    /* renamed from: com.android.internal.telephony.PhoneBase.1 */
    class C00131 extends BroadcastReceiver {
        C00131() {
        }

        public void onReceive(Context context, Intent intent) {
            Rlog.d(PhoneBase.LOG_TAG, "mImsIntentReceiver: action " + intent.getAction());
            if (intent.hasExtra("android:phone_id")) {
                int extraPhoneId = intent.getIntExtra("android:phone_id", -1);
                Rlog.d(PhoneBase.LOG_TAG, "mImsIntentReceiver: extraPhoneId = " + extraPhoneId);
                if (extraPhoneId == -1 || extraPhoneId != PhoneBase.this.getPhoneId()) {
                    return;
                }
            }
            if (intent.getAction().equals("com.android.ims.IMS_SERVICE_UP")) {
                PhoneBase.this.mImsServiceReady = true;
                PhoneBase.this.updateImsPhone();
            } else if (intent.getAction().equals("com.android.ims.IMS_SERVICE_DOWN")) {
                PhoneBase.this.mImsServiceReady = false;
                PhoneBase.this.updateImsPhone();
            }
        }
    }

    protected static class NetworkSelectMessage {
        public Message message;
        public String operatorAlphaLong;
        public String operatorNumeric;

        protected NetworkSelectMessage() {
        }
    }

    public abstract int getPhoneType();

    public abstract State getState();

    protected abstract void onUpdateIccAvailability();

    static {
        mImsPhone = null;
    }

    public String getPhoneName() {
        return this.mName;
    }

    public String getNai() {
        return null;
    }

    public String getActionDetached() {
        return this.mActionDetached;
    }

    public String getActionAttached() {
        return this.mActionAttached;
    }

    public void setSystemProperty(String property, String value) {
        if (!getUnitTestMode()) {
            SystemProperties.set(property, value);
        }
    }

    public String getSystemProperty(String property, String defValue) {
        if (getUnitTestMode()) {
            return null;
        }
        return SystemProperties.get(property, defValue);
    }

    protected PhoneBase(String name, PhoneNotifier notifier, Context context, CommandsInterface ci) {
        this(name, notifier, context, ci, false);
    }

    protected PhoneBase(String name, PhoneNotifier notifier, Context context, CommandsInterface ci, boolean unitTestMode) {
        this(name, notifier, context, ci, unitTestMode, Integer.MAX_VALUE);
    }

    protected PhoneBase(String name, PhoneNotifier notifier, Context context, CommandsInterface ci, boolean unitTestMode, int phoneId) {
        this.mImsIntentReceiver = new C00131();
        this.mVmCount = 0;
        this.mIsTheCurrentActivePhone = true;
        this.mIsVoiceCapable = true;
        this.mUiccController = null;
        this.mIccRecords = new AtomicReference();
        this.mUiccApplication = new AtomicReference();
        this.mImsLock = new Object();
        this.mImsServiceReady = false;
        this.mRadioAccessFamily = EVENT_RADIO_AVAILABLE;
        this.mPreciseCallStateRegistrants = new RegistrantList();
        this.mHandoverRegistrants = new RegistrantList();
        this.mNewRingingConnectionRegistrants = new RegistrantList();
        this.mIncomingRingRegistrants = new RegistrantList();
        this.mDisconnectRegistrants = new RegistrantList();
        this.mServiceStateRegistrants = new RegistrantList();
        this.mMmiCompleteRegistrants = new RegistrantList();
        this.mMmiRegistrants = new RegistrantList();
        this.mUnknownConnectionRegistrants = new RegistrantList();
        this.mSuppServiceFailedRegistrants = new RegistrantList();
        this.mRadioOffOrNotAvailableRegistrants = new RegistrantList();
        this.mSimRecordsLoadedRegistrants = new RegistrantList();
        this.mPhoneId = phoneId;
        this.mName = name;
        this.mNotifier = notifier;
        this.mContext = context;
        this.mLooper = Looper.myLooper();
        this.mCi = ci;
        this.mActionDetached = getClass().getPackage().getName() + ".action_detached";
        this.mActionAttached = getClass().getPackage().getName() + ".action_attached";
        if (Build.IS_DEBUGGABLE) {
            this.mTelephonyTester = new TelephonyTester(this);
        }
        setUnitTestMode(unitTestMode);
        this.mDnsCheckDisabled = PreferenceManager.getDefaultSharedPreferences(context).getBoolean(DNS_SERVER_CHECK_DISABLED_KEY, false);
        this.mCi.setOnCallRing(this, EVENT_CALL_RING, null);
        this.mIsVoiceCapable = this.mContext.getResources().getBoolean(17956946);
        this.mDoesRilSendMultipleCallRing = SystemProperties.getBoolean("ro.telephony.call_ring.multiple", true);
        Rlog.d(LOG_TAG, "mDoesRilSendMultipleCallRing=" + this.mDoesRilSendMultipleCallRing);
        this.mCallRingDelay = SystemProperties.getInt("ro.telephony.call_ring.delay", 3000);
        Rlog.d(LOG_TAG, "mCallRingDelay=" + this.mCallRingDelay);
        if (getPhoneType() != EVENT_RADIO_ON) {
            setPropertiesByCarrier();
            this.mSmsStorageMonitor = new SmsStorageMonitor(this);
            this.mSmsUsageMonitor = new SmsUsageMonitor(context);
            this.mUiccController = UiccController.getInstance();
            this.mUiccController.registerForIccChanged(this, EVENT_ICC_CHANGED, null);
            ImsManager imsManager = ImsManager.getInstance(this.mContext, getPhoneId());
            if (imsManager != null && imsManager.isServiceAvailable()) {
                this.mImsServiceReady = true;
                updateImsPhone();
            }
            IntentFilter filter = new IntentFilter();
            filter.addAction("com.android.ims.IMS_SERVICE_UP");
            filter.addAction("com.android.ims.IMS_SERVICE_DOWN");
            this.mContext.registerReceiver(this.mImsIntentReceiver, filter);
            this.mCi.registerForSrvccStateChanged(this, EVENT_SRVCC_STATE_CHANGED, null);
            this.mCi.setOnUnsolOemHookRaw(this, EVENT_UNSOL_OEM_HOOK_RAW, null);
        }
    }

    public void dispose() {
        synchronized (PhoneProxy.lockForRadioTechnologyChange) {
            this.mContext.unregisterReceiver(this.mImsIntentReceiver);
            this.mCi.unSetOnCallRing(this);
            this.mDcTracker.cleanUpAllConnections(null);
            this.mIsTheCurrentActivePhone = false;
            this.mSmsStorageMonitor.dispose();
            this.mSmsUsageMonitor.dispose();
            this.mUiccController.unregisterForIccChanged(this);
            this.mCi.unregisterForSrvccStateChanged(this);
            this.mCi.unSetOnUnsolOemHookRaw(this);
            if (this.mTelephonyTester != null) {
                this.mTelephonyTester.dispose();
            }
        }
    }

    public void removeReferences() {
        this.mSmsStorageMonitor = null;
        this.mSmsUsageMonitor = null;
        this.mIccRecords.set(null);
        this.mUiccApplication.set(null);
        this.mDcTracker = null;
        this.mUiccController = null;
        ImsPhone imsPhone = mImsPhone;
        if (imsPhone != null) {
            imsPhone.removeReferences();
            mImsPhone = null;
        }
    }

    public void handleMessage(Message msg) {
        switch (msg.what) {
            case EVENT_SET_NETWORK_MANUAL_COMPLETE /*16*/:
            case EVENT_SET_NETWORK_AUTOMATIC_COMPLETE /*17*/:
                handleSetSelectNetwork((AsyncResult) msg.obj);
            default:
                if (this.mIsTheCurrentActivePhone) {
                    AsyncResult ar;
                    switch (msg.what) {
                        case EVENT_CALL_RING /*14*/:
                            Rlog.d(LOG_TAG, "Event EVENT_CALL_RING Received state=" + getState());
                            if (msg.obj.exception == null) {
                                State state = getState();
                                if (this.mDoesRilSendMultipleCallRing || !(state == State.RINGING || state == State.IDLE)) {
                                    notifyIncomingRing();
                                    return;
                                }
                                this.mCallRingContinueToken += EVENT_RADIO_AVAILABLE;
                                sendIncomingCallRingNotification(this.mCallRingContinueToken);
                                return;
                            }
                            return;
                        case EVENT_CALL_RING_CONTINUE /*15*/:
                            Rlog.d(LOG_TAG, "Event EVENT_CALL_RING_CONTINUE Received stat=" + getState());
                            if (getState() == State.RINGING) {
                                sendIncomingCallRingNotification(msg.arg1);
                                return;
                            }
                            return;
                        case EVENT_ICC_CHANGED /*30*/:
                            onUpdateIccAvailability();
                            return;
                        case EVENT_SRVCC_STATE_CHANGED /*31*/:
                            ar = (AsyncResult) msg.obj;
                            if (ar.exception == null) {
                                handleSrvccStateChanged((int[]) ar.result);
                                return;
                            } else {
                                Rlog.e(LOG_TAG, "Srvcc exception: " + ar.exception);
                                return;
                            }
                        case EVENT_INITIATE_SILENT_REDIAL /*32*/:
                            Rlog.d(LOG_TAG, "Event EVENT_INITIATE_SILENT_REDIAL Received");
                            ar = (AsyncResult) msg.obj;
                            if (ar.exception == null && ar.result != null) {
                                String dialString = ar.result;
                                if (!TextUtils.isEmpty(dialString)) {
                                    try {
                                        dialInternal(dialString, null, 0);
                                        return;
                                    } catch (CallStateException e) {
                                        Rlog.e(LOG_TAG, "silent redial failed: " + e);
                                        return;
                                    }
                                }
                                return;
                            }
                            return;
                        case EVENT_UNSOL_OEM_HOOK_RAW /*34*/:
                            ar = (AsyncResult) msg.obj;
                            if (ar.exception == null) {
                                byte[] data = (byte[]) ar.result;
                                Rlog.d(LOG_TAG, "EVENT_UNSOL_OEM_HOOK_RAW data=" + IccUtils.bytesToHexString(data));
                                this.mNotifier.notifyOemHookRawEventForSubscriber(getSubId(), data);
                                return;
                            }
                            Rlog.e(LOG_TAG, "OEM hook raw exception: " + ar.exception);
                            return;
                        case EVENT_GET_RADIO_CAPABILITY /*35*/:
                            ar = (AsyncResult) msg.obj;
                            RadioCapability rc = ar.result;
                            if (ar.exception != null) {
                                Rlog.d(LOG_TAG, "get phone radio capability fail,no need to change mRadioAccessFamily");
                            } else {
                                this.mRadioAccessFamily = rc.getRadioAccessFamily();
                            }
                            Rlog.d(LOG_TAG, "EVENT_GET_RADIO_CAPABILITY :phone RAF : " + this.mRadioAccessFamily);
                            return;
                        default:
                            throw new RuntimeException("unexpected event not handled");
                    }
                }
                Rlog.e(LOG_TAG, "Received message " + msg + "[" + msg.what + "] while being destroyed. Ignoring.");
        }
    }

    private void handleSrvccStateChanged(int[] ret) {
        Rlog.d(LOG_TAG, "handleSrvccStateChanged");
        ArrayList<Connection> conn = null;
        ImsPhone imsPhone = mImsPhone;
        SrvccState srvccState = SrvccState.NONE;
        if (ret != null && ret.length != 0) {
            int state = ret[0];
            switch (state) {
                case CharacterSets.ANY_CHARSET /*0*/:
                    srvccState = SrvccState.STARTED;
                    if (imsPhone == null) {
                        Rlog.d(LOG_TAG, "HANDOVER_STARTED: mImsPhone null");
                        break;
                    }
                    conn = imsPhone.getHandoverConnection();
                    migrateFrom(imsPhone);
                    break;
                case EVENT_RADIO_AVAILABLE /*1*/:
                    srvccState = SrvccState.COMPLETED;
                    if (imsPhone == null) {
                        Rlog.d(LOG_TAG, "HANDOVER_COMPLETED: mImsPhone null");
                        break;
                    } else {
                        imsPhone.notifySrvccState(srvccState);
                        break;
                    }
                case EVENT_SSN /*2*/:
                case EVENT_SIM_RECORDS_LOADED /*3*/:
                    srvccState = SrvccState.FAILED;
                    break;
                default:
                    return;
            }
            getCallTracker().notifySrvccState(srvccState, conn);
            notifyVoLteServiceStateChanged(new VoLteServiceState(state));
        }
    }

    public Context getContext() {
        return this.mContext;
    }

    public void disableDnsCheck(boolean b) {
        this.mDnsCheckDisabled = b;
        Editor editor = PreferenceManager.getDefaultSharedPreferences(getContext()).edit();
        editor.putBoolean(DNS_SERVER_CHECK_DISABLED_KEY, b);
        editor.apply();
    }

    public boolean isDnsCheckDisabled() {
        return this.mDnsCheckDisabled;
    }

    public void registerForPreciseCallStateChanged(Handler h, int what, Object obj) {
        checkCorrectThread(h);
        this.mPreciseCallStateRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForPreciseCallStateChanged(Handler h) {
        this.mPreciseCallStateRegistrants.remove(h);
    }

    protected void notifyPreciseCallStateChangedP() {
        this.mPreciseCallStateRegistrants.notifyRegistrants(new AsyncResult(null, this, null));
        this.mNotifier.notifyPreciseCallState(this);
    }

    public void registerForHandoverStateChanged(Handler h, int what, Object obj) {
        checkCorrectThread(h);
        this.mHandoverRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForHandoverStateChanged(Handler h) {
        this.mHandoverRegistrants.remove(h);
    }

    public void notifyHandoverStateChanged(Connection cn) {
        this.mHandoverRegistrants.notifyRegistrants(new AsyncResult(null, cn, null));
    }

    public void migrateFrom(PhoneBase from) {
        migrate(this.mHandoverRegistrants, from.mHandoverRegistrants);
        migrate(this.mPreciseCallStateRegistrants, from.mPreciseCallStateRegistrants);
        migrate(this.mNewRingingConnectionRegistrants, from.mNewRingingConnectionRegistrants);
        migrate(this.mIncomingRingRegistrants, from.mIncomingRingRegistrants);
        migrate(this.mDisconnectRegistrants, from.mDisconnectRegistrants);
        migrate(this.mServiceStateRegistrants, from.mServiceStateRegistrants);
        migrate(this.mMmiCompleteRegistrants, from.mMmiCompleteRegistrants);
        migrate(this.mMmiRegistrants, from.mMmiRegistrants);
        migrate(this.mUnknownConnectionRegistrants, from.mUnknownConnectionRegistrants);
        migrate(this.mSuppServiceFailedRegistrants, from.mSuppServiceFailedRegistrants);
    }

    public void migrate(RegistrantList to, RegistrantList from) {
        from.removeCleared();
        int n = from.size();
        for (int i = 0; i < n; i += EVENT_RADIO_AVAILABLE) {
            to.add((Registrant) from.get(i));
        }
    }

    public void registerForUnknownConnection(Handler h, int what, Object obj) {
        checkCorrectThread(h);
        this.mUnknownConnectionRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForUnknownConnection(Handler h) {
        this.mUnknownConnectionRegistrants.remove(h);
    }

    public void registerForNewRingingConnection(Handler h, int what, Object obj) {
        checkCorrectThread(h);
        this.mNewRingingConnectionRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForNewRingingConnection(Handler h) {
        this.mNewRingingConnectionRegistrants.remove(h);
    }

    public void registerForInCallVoicePrivacyOn(Handler h, int what, Object obj) {
        this.mCi.registerForInCallVoicePrivacyOn(h, what, obj);
    }

    public void unregisterForInCallVoicePrivacyOn(Handler h) {
        this.mCi.unregisterForInCallVoicePrivacyOn(h);
    }

    public void registerForInCallVoicePrivacyOff(Handler h, int what, Object obj) {
        this.mCi.registerForInCallVoicePrivacyOff(h, what, obj);
    }

    public void unregisterForInCallVoicePrivacyOff(Handler h) {
        this.mCi.unregisterForInCallVoicePrivacyOff(h);
    }

    public void registerForIncomingRing(Handler h, int what, Object obj) {
        checkCorrectThread(h);
        this.mIncomingRingRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForIncomingRing(Handler h) {
        this.mIncomingRingRegistrants.remove(h);
    }

    public void registerForDisconnect(Handler h, int what, Object obj) {
        checkCorrectThread(h);
        this.mDisconnectRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForDisconnect(Handler h) {
        this.mDisconnectRegistrants.remove(h);
    }

    public void registerForSuppServiceFailed(Handler h, int what, Object obj) {
        checkCorrectThread(h);
        this.mSuppServiceFailedRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForSuppServiceFailed(Handler h) {
        this.mSuppServiceFailedRegistrants.remove(h);
    }

    public void registerForMmiInitiate(Handler h, int what, Object obj) {
        checkCorrectThread(h);
        this.mMmiRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForMmiInitiate(Handler h) {
        this.mMmiRegistrants.remove(h);
    }

    public void registerForMmiComplete(Handler h, int what, Object obj) {
        checkCorrectThread(h);
        this.mMmiCompleteRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForMmiComplete(Handler h) {
        checkCorrectThread(h);
        this.mMmiCompleteRegistrants.remove(h);
    }

    public void registerForSimRecordsLoaded(Handler h, int what, Object obj) {
        logUnexpectedCdmaMethodCall("registerForSimRecordsLoaded");
    }

    public void unregisterForSimRecordsLoaded(Handler h) {
        logUnexpectedCdmaMethodCall("unregisterForSimRecordsLoaded");
    }

    public void registerForTtyModeReceived(Handler h, int what, Object obj) {
    }

    public void unregisterForTtyModeReceived(Handler h) {
    }

    public void setNetworkSelectionModeAutomatic(Message response) {
        NetworkSelectMessage nsm = new NetworkSelectMessage();
        nsm.message = response;
        nsm.operatorNumeric = "";
        nsm.operatorAlphaLong = "";
        this.mCi.setNetworkSelectionModeAutomatic(obtainMessage(EVENT_SET_NETWORK_AUTOMATIC_COMPLETE, nsm));
        updateSavedNetworkOperator(nsm);
    }

    public void getNetworkSelectionMode(Message message) {
        this.mCi.getNetworkSelectionMode(message);
    }

    public void selectNetworkManually(OperatorInfo network, Message response) {
        NetworkSelectMessage nsm = new NetworkSelectMessage();
        nsm.message = response;
        nsm.operatorNumeric = network.getOperatorNumeric();
        nsm.operatorAlphaLong = network.getOperatorAlphaLong();
        this.mCi.setNetworkSelectionModeManual(network.getOperatorNumeric(), obtainMessage(EVENT_SET_NETWORK_MANUAL_COMPLETE, nsm));
        updateSavedNetworkOperator(nsm);
    }

    private void updateSavedNetworkOperator(NetworkSelectMessage nsm) {
        int subId = getSubId();
        if (SubscriptionManager.isValidSubscriptionId(subId)) {
            Editor editor = PreferenceManager.getDefaultSharedPreferences(getContext()).edit();
            editor.putString(NETWORK_SELECTION_KEY + subId, nsm.operatorNumeric);
            editor.putString(NETWORK_SELECTION_NAME_KEY + subId, nsm.operatorAlphaLong);
            if (!editor.commit()) {
                Rlog.e(LOG_TAG, "failed to commit network selection preference");
                return;
            }
            return;
        }
        Rlog.e(LOG_TAG, "Cannot update network selection preference due to invalid subId " + subId);
    }

    private void handleSetSelectNetwork(AsyncResult ar) {
        if (ar.userObj instanceof NetworkSelectMessage) {
            NetworkSelectMessage nsm = ar.userObj;
            if (nsm.message != null) {
                AsyncResult.forMessage(nsm.message, ar.result, ar.exception);
                nsm.message.sendToTarget();
                return;
            }
            return;
        }
        Rlog.e(LOG_TAG, "unexpected result from user object.");
    }

    private String getSavedNetworkSelection() {
        return PreferenceManager.getDefaultSharedPreferences(getContext()).getString(NETWORK_SELECTION_KEY + getSubId(), "");
    }

    public void restoreSavedNetworkSelection(Message response) {
        String networkSelection = getSavedNetworkSelection();
        if (TextUtils.isEmpty(networkSelection)) {
            this.mCi.setNetworkSelectionModeAutomatic(response);
        } else {
            this.mCi.setNetworkSelectionModeManual(networkSelection, response);
        }
    }

    public void setUnitTestMode(boolean f) {
        this.mUnitTestMode = f;
    }

    public boolean getUnitTestMode() {
        return this.mUnitTestMode;
    }

    protected void notifyDisconnectP(Connection cn) {
        this.mDisconnectRegistrants.notifyRegistrants(new AsyncResult(null, cn, null));
    }

    public void registerForServiceStateChanged(Handler h, int what, Object obj) {
        checkCorrectThread(h);
        this.mServiceStateRegistrants.add(h, what, obj);
    }

    public void unregisterForServiceStateChanged(Handler h) {
        this.mServiceStateRegistrants.remove(h);
    }

    public void registerForRingbackTone(Handler h, int what, Object obj) {
        this.mCi.registerForRingbackTone(h, what, obj);
    }

    public void unregisterForRingbackTone(Handler h) {
        this.mCi.unregisterForRingbackTone(h);
    }

    public void registerForOnHoldTone(Handler h, int what, Object obj) {
    }

    public void unregisterForOnHoldTone(Handler h) {
    }

    public void registerForResendIncallMute(Handler h, int what, Object obj) {
        this.mCi.registerForResendIncallMute(h, what, obj);
    }

    public void unregisterForResendIncallMute(Handler h) {
        this.mCi.unregisterForResendIncallMute(h);
    }

    public void setEchoSuppressionEnabled() {
    }

    protected void notifyServiceStateChangedP(ServiceState ss) {
        this.mServiceStateRegistrants.notifyRegistrants(new AsyncResult(null, ss, null));
        this.mNotifier.notifyServiceState(this);
    }

    public SimulatedRadioControl getSimulatedRadioControl() {
        return this.mSimulatedRadioControl;
    }

    private void checkCorrectThread(Handler h) {
        if (h.getLooper() != this.mLooper) {
            throw new RuntimeException("com.android.internal.telephony.Phone must be used from within one thread");
        }
    }

    private void setPropertiesByCarrier() {
        String carrier = SystemProperties.get("ro.carrier");
        if (carrier != null && carrier.length() != 0 && !"unknown".equals(carrier)) {
            CharSequence[] carrierLocales = this.mContext.getResources().getTextArray(17236043);
            for (int i = 0; i < carrierLocales.length; i += EVENT_SIM_RECORDS_LOADED) {
                if (carrier.equals(carrierLocales[i].toString())) {
                    Locale l = Locale.forLanguageTag(carrierLocales[i + EVENT_RADIO_AVAILABLE].toString().replace('_', '-'));
                    String country = l.getCountry();
                    MccTable.setSystemLocale(this.mContext, l.getLanguage(), country);
                    if (!country.isEmpty()) {
                        try {
                            Global.getInt(this.mContext.getContentResolver(), "wifi_country_code");
                            return;
                        } catch (SettingNotFoundException e) {
                            ((WifiManager) this.mContext.getSystemService("wifi")).setCountryCode(country, false);
                            return;
                        }
                    }
                    return;
                }
            }
        }
    }

    public IccFileHandler getIccFileHandler() {
        IccFileHandler fh;
        UiccCardApplication uiccApplication = (UiccCardApplication) this.mUiccApplication.get();
        if (uiccApplication == null) {
            Rlog.d(LOG_TAG, "getIccFileHandler: uiccApplication == null, return null");
            fh = null;
        } else {
            fh = uiccApplication.getIccFileHandler();
        }
        Rlog.d(LOG_TAG, "getIccFileHandler: fh=" + fh);
        return fh;
    }

    public Handler getHandler() {
        return this;
    }

    public void updatePhoneObject(int voiceRadioTech) {
        PhoneFactory.getDefaultPhone().updatePhoneObject(voiceRadioTech);
    }

    public ServiceStateTracker getServiceStateTracker() {
        return null;
    }

    public CallTracker getCallTracker() {
        return null;
    }

    public AppType getCurrentUiccAppType() {
        UiccCardApplication currentApp = (UiccCardApplication) this.mUiccApplication.get();
        if (currentApp != null) {
            return currentApp.getType();
        }
        return AppType.APPTYPE_UNKNOWN;
    }

    public IccCard getIccCard() {
        return null;
    }

    public String getIccSerialNumber() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        return r != null ? r.getIccId() : null;
    }

    public boolean getIccRecordsLoaded() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        return r != null ? r.getRecordsLoaded() : false;
    }

    public List<CellInfo> getAllCellInfo() {
        return privatizeCellInfoList(getServiceStateTracker().getAllCellInfo());
    }

    private List<CellInfo> privatizeCellInfoList(List<CellInfo> cellInfoList) {
        if (Secure.getInt(getContext().getContentResolver(), "location_mode", 0) != 0) {
            return cellInfoList;
        }
        ArrayList<CellInfo> privateCellInfoList = new ArrayList(cellInfoList.size());
        for (CellInfo c : cellInfoList) {
            if (c instanceof CellInfoCdma) {
                CellInfoCdma cellInfoCdma = (CellInfoCdma) c;
                CellIdentityCdma cellIdentity = cellInfoCdma.getCellIdentity();
                CellIdentityCdma maskedCellIdentity = new CellIdentityCdma(cellIdentity.getNetworkId(), cellIdentity.getSystemId(), cellIdentity.getBasestationId(), Integer.MAX_VALUE, Integer.MAX_VALUE);
                CellInfoCdma privateCellInfoCdma = new CellInfoCdma(cellInfoCdma);
                privateCellInfoCdma.setCellIdentity(maskedCellIdentity);
                privateCellInfoList.add(privateCellInfoCdma);
            } else {
                privateCellInfoList.add(c);
            }
        }
        return privateCellInfoList;
    }

    public void setCellInfoListRate(int rateInMillis) {
        this.mCi.setCellInfoListRate(rateInMillis, null);
    }

    public boolean getMessageWaitingIndicator() {
        return this.mVmCount != 0;
    }

    public boolean getCallForwardingIndicator() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        return r != null ? r.getVoiceCallForwardingFlag() : false;
    }

    public void queryCdmaRoamingPreference(Message response) {
        this.mCi.queryCdmaRoamingPreference(response);
    }

    public SignalStrength getSignalStrength() {
        ServiceStateTracker sst = getServiceStateTracker();
        if (sst == null) {
            return new SignalStrength();
        }
        return sst.getSignalStrength();
    }

    public void setCdmaRoamingPreference(int cdmaRoamingType, Message response) {
        this.mCi.setCdmaRoamingPreference(cdmaRoamingType, response);
    }

    public void setCdmaSubscription(int cdmaSubscriptionType, Message response) {
        this.mCi.setCdmaSubscriptionSource(cdmaSubscriptionType, response);
    }

    public void setPreferredNetworkType(int networkType, Message response) {
        this.mCi.setPreferredNetworkType(networkType, response);
    }

    public void getPreferredNetworkType(Message response) {
        this.mCi.getPreferredNetworkType(response);
    }

    public void getSmscAddress(Message result) {
        this.mCi.getSmscAddress(result);
    }

    public void setSmscAddress(String address, Message result) {
        this.mCi.setSmscAddress(address, result);
    }

    public void setTTYMode(int ttyMode, Message onComplete) {
        this.mCi.setTTYMode(ttyMode, onComplete);
    }

    public void setUiTTYMode(int uiTtyMode, Message onComplete) {
        Rlog.d(LOG_TAG, "unexpected setUiTTYMode method call");
    }

    public void queryTTYMode(Message onComplete) {
        this.mCi.queryTTYMode(onComplete);
    }

    public void enableEnhancedVoicePrivacy(boolean enable, Message onComplete) {
        logUnexpectedCdmaMethodCall("enableEnhancedVoicePrivacy");
    }

    public void getEnhancedVoicePrivacy(Message onComplete) {
        logUnexpectedCdmaMethodCall("getEnhancedVoicePrivacy");
    }

    public void setBandMode(int bandMode, Message response) {
        this.mCi.setBandMode(bandMode, response);
    }

    public void queryAvailableBandMode(Message response) {
        this.mCi.queryAvailableBandMode(response);
    }

    public void invokeOemRilRequestRaw(byte[] data, Message response) {
        this.mCi.invokeOemRilRequestRaw(data, response);
    }

    public void invokeOemRilRequestStrings(String[] strings, Message response) {
        this.mCi.invokeOemRilRequestStrings(strings, response);
    }

    public void nvReadItem(int itemID, Message response) {
        this.mCi.nvReadItem(itemID, response);
    }

    public void nvWriteItem(int itemID, String itemValue, Message response) {
        this.mCi.nvWriteItem(itemID, itemValue, response);
    }

    public void nvWriteCdmaPrl(byte[] preferredRoamingList, Message response) {
        this.mCi.nvWriteCdmaPrl(preferredRoamingList, response);
    }

    public void nvResetConfig(int resetType, Message response) {
        this.mCi.nvResetConfig(resetType, response);
    }

    public void notifyDataActivity() {
        this.mNotifier.notifyDataActivity(this);
    }

    public void notifyMessageWaitingIndicator() {
        if (this.mIsVoiceCapable) {
            this.mNotifier.notifyMessageWaitingChanged(this);
        }
    }

    public void notifyDataConnection(String reason, String apnType, DataState state) {
        this.mNotifier.notifyDataConnection(this, reason, apnType, state);
    }

    public void notifyDataConnection(String reason, String apnType) {
        this.mNotifier.notifyDataConnection(this, reason, apnType, getDataConnectionState(apnType));
    }

    public void notifyDataConnection(String reason) {
        String[] arr$ = getActiveApnTypes();
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += EVENT_RADIO_AVAILABLE) {
            String apnType = arr$[i$];
            this.mNotifier.notifyDataConnection(this, reason, apnType, getDataConnectionState(apnType));
        }
    }

    public void notifyOtaspChanged(int otaspMode) {
        this.mNotifier.notifyOtaspChanged(this, otaspMode);
    }

    public void notifySignalStrength() {
        this.mNotifier.notifySignalStrength(this);
    }

    public void notifyCellInfo(List<CellInfo> cellInfo) {
        this.mNotifier.notifyCellInfo(this, privatizeCellInfoList(cellInfo));
    }

    public void notifyDataConnectionRealTimeInfo(DataConnectionRealTimeInfo dcRtInfo) {
        this.mNotifier.notifyDataConnectionRealTimeInfo(this, dcRtInfo);
    }

    public void notifyVoLteServiceStateChanged(VoLteServiceState lteState) {
        this.mNotifier.notifyVoLteServiceStateChanged(this, lteState);
    }

    public boolean isInEmergencyCall() {
        return false;
    }

    public boolean isInEcm() {
        return false;
    }

    public int getVoiceMessageCount() {
        return this.mVmCount;
    }

    public void setVoiceMessageCount(int countWaiting) {
        this.mVmCount = countWaiting;
        notifyMessageWaitingIndicator();
    }

    protected int getStoredVoiceMessageCount() {
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(this.mContext);
        String subscriberId = sp.getString(VM_ID, null);
        String currentSubscriberId = getSubscriberId();
        Rlog.d(LOG_TAG, "Voicemail count retrieval for subscriberId = " + subscriberId + " current subscriberId = " + currentSubscriberId);
        if (subscriberId == null || currentSubscriberId == null || !currentSubscriberId.equals(subscriberId)) {
            return 0;
        }
        int countVoiceMessages = sp.getInt(VM_COUNT, 0);
        Rlog.d(LOG_TAG, "Voice Mail Count from preference = " + countVoiceMessages);
        return countVoiceMessages;
    }

    public int getCdmaEriIconIndex() {
        logUnexpectedCdmaMethodCall("getCdmaEriIconIndex");
        return -1;
    }

    public int getCdmaEriIconMode() {
        logUnexpectedCdmaMethodCall("getCdmaEriIconMode");
        return -1;
    }

    public String getCdmaEriText() {
        logUnexpectedCdmaMethodCall("getCdmaEriText");
        return "GSM nw, no ERI";
    }

    public String getCdmaMin() {
        logUnexpectedCdmaMethodCall("getCdmaMin");
        return null;
    }

    public boolean isMinInfoReady() {
        logUnexpectedCdmaMethodCall("isMinInfoReady");
        return false;
    }

    public String getCdmaPrlVersion() {
        logUnexpectedCdmaMethodCall("getCdmaPrlVersion");
        return null;
    }

    public void sendBurstDtmf(String dtmfString, int on, int off, Message onComplete) {
        logUnexpectedCdmaMethodCall("sendBurstDtmf");
    }

    public void exitEmergencyCallbackMode() {
        logUnexpectedCdmaMethodCall("exitEmergencyCallbackMode");
    }

    public void registerForCdmaOtaStatusChange(Handler h, int what, Object obj) {
        logUnexpectedCdmaMethodCall("registerForCdmaOtaStatusChange");
    }

    public void unregisterForCdmaOtaStatusChange(Handler h) {
        logUnexpectedCdmaMethodCall("unregisterForCdmaOtaStatusChange");
    }

    public void registerForSubscriptionInfoReady(Handler h, int what, Object obj) {
        logUnexpectedCdmaMethodCall("registerForSubscriptionInfoReady");
    }

    public void unregisterForSubscriptionInfoReady(Handler h) {
        logUnexpectedCdmaMethodCall("unregisterForSubscriptionInfoReady");
    }

    public boolean needsOtaServiceProvisioning() {
        return false;
    }

    public boolean isOtaSpNumber(String dialStr) {
        return false;
    }

    public void registerForCallWaiting(Handler h, int what, Object obj) {
        logUnexpectedCdmaMethodCall("registerForCallWaiting");
    }

    public void unregisterForCallWaiting(Handler h) {
        logUnexpectedCdmaMethodCall("unregisterForCallWaiting");
    }

    public void registerForEcmTimerReset(Handler h, int what, Object obj) {
        logUnexpectedCdmaMethodCall("registerForEcmTimerReset");
    }

    public void unregisterForEcmTimerReset(Handler h) {
        logUnexpectedCdmaMethodCall("unregisterForEcmTimerReset");
    }

    public void registerForSignalInfo(Handler h, int what, Object obj) {
        this.mCi.registerForSignalInfo(h, what, obj);
    }

    public void unregisterForSignalInfo(Handler h) {
        this.mCi.unregisterForSignalInfo(h);
    }

    public void registerForDisplayInfo(Handler h, int what, Object obj) {
        this.mCi.registerForDisplayInfo(h, what, obj);
    }

    public void unregisterForDisplayInfo(Handler h) {
        this.mCi.unregisterForDisplayInfo(h);
    }

    public void registerForNumberInfo(Handler h, int what, Object obj) {
        this.mCi.registerForNumberInfo(h, what, obj);
    }

    public void unregisterForNumberInfo(Handler h) {
        this.mCi.unregisterForNumberInfo(h);
    }

    public void registerForRedirectedNumberInfo(Handler h, int what, Object obj) {
        this.mCi.registerForRedirectedNumberInfo(h, what, obj);
    }

    public void unregisterForRedirectedNumberInfo(Handler h) {
        this.mCi.unregisterForRedirectedNumberInfo(h);
    }

    public void registerForLineControlInfo(Handler h, int what, Object obj) {
        this.mCi.registerForLineControlInfo(h, what, obj);
    }

    public void unregisterForLineControlInfo(Handler h) {
        this.mCi.unregisterForLineControlInfo(h);
    }

    public void registerFoT53ClirlInfo(Handler h, int what, Object obj) {
        this.mCi.registerFoT53ClirlInfo(h, what, obj);
    }

    public void unregisterForT53ClirInfo(Handler h) {
        this.mCi.unregisterForT53ClirInfo(h);
    }

    public void registerForT53AudioControlInfo(Handler h, int what, Object obj) {
        this.mCi.registerForT53AudioControlInfo(h, what, obj);
    }

    public void unregisterForT53AudioControlInfo(Handler h) {
        this.mCi.unregisterForT53AudioControlInfo(h);
    }

    public void setOnEcbModeExitResponse(Handler h, int what, Object obj) {
        logUnexpectedCdmaMethodCall("setOnEcbModeExitResponse");
    }

    public void unsetOnEcbModeExitResponse(Handler h) {
        logUnexpectedCdmaMethodCall("unsetOnEcbModeExitResponse");
    }

    public void registerForRadioOffOrNotAvailable(Handler h, int what, Object obj) {
        this.mRadioOffOrNotAvailableRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForRadioOffOrNotAvailable(Handler h) {
        this.mRadioOffOrNotAvailableRegistrants.remove(h);
    }

    public String[] getActiveApnTypes() {
        return this.mDcTracker.getActiveApnTypes();
    }

    public boolean hasMatchedTetherApnSetting() {
        return this.mDcTracker.hasMatchedTetherApnSetting();
    }

    public String getActiveApnHost(String apnType) {
        return this.mDcTracker.getActiveApnString(apnType);
    }

    public LinkProperties getLinkProperties(String apnType) {
        return this.mDcTracker.getLinkProperties(apnType);
    }

    public NetworkCapabilities getNetworkCapabilities(String apnType) {
        return this.mDcTracker.getNetworkCapabilities(apnType);
    }

    public boolean isDataConnectivityPossible() {
        return isDataConnectivityPossible("default");
    }

    public boolean isDataConnectivityPossible(String apnType) {
        return this.mDcTracker != null && this.mDcTracker.isDataPossible(apnType);
    }

    public void notifyNewRingingConnectionP(Connection cn) {
        if (this.mIsVoiceCapable) {
            this.mNewRingingConnectionRegistrants.notifyRegistrants(new AsyncResult(null, cn, null));
        }
    }

    private void notifyIncomingRing() {
        if (this.mIsVoiceCapable) {
            this.mIncomingRingRegistrants.notifyRegistrants(new AsyncResult(null, this, null));
        }
    }

    private void sendIncomingCallRingNotification(int token) {
        if (this.mIsVoiceCapable && !this.mDoesRilSendMultipleCallRing && token == this.mCallRingContinueToken) {
            Rlog.d(LOG_TAG, "Sending notifyIncomingRing");
            notifyIncomingRing();
            sendMessageDelayed(obtainMessage(EVENT_CALL_RING_CONTINUE, token, 0), (long) this.mCallRingDelay);
            return;
        }
        Rlog.d(LOG_TAG, "Ignoring ring notification request, mDoesRilSendMultipleCallRing=" + this.mDoesRilSendMultipleCallRing + " token=" + token + " mCallRingContinueToken=" + this.mCallRingContinueToken + " mIsVoiceCapable=" + this.mIsVoiceCapable);
    }

    public boolean isCspPlmnEnabled() {
        logUnexpectedGsmMethodCall("isCspPlmnEnabled");
        return false;
    }

    public IsimRecords getIsimRecords() {
        Rlog.e(LOG_TAG, "getIsimRecords() is only supported on LTE devices");
        return null;
    }

    public String getMsisdn() {
        logUnexpectedGsmMethodCall("getMsisdn");
        return null;
    }

    private static void logUnexpectedCdmaMethodCall(String name) {
        Rlog.e(LOG_TAG, "Error! " + name + "() in PhoneBase should not be " + "called, CDMAPhone inactive.");
    }

    public DataState getDataConnectionState() {
        return getDataConnectionState("default");
    }

    private static void logUnexpectedGsmMethodCall(String name) {
        Rlog.e(LOG_TAG, "Error! " + name + "() in PhoneBase should not be " + "called, GSMPhone inactive.");
    }

    public void notifyCallForwardingIndicator() {
        Rlog.e(LOG_TAG, "Error! This function should never be executed, inactive CDMAPhone.");
    }

    public void notifyDataConnectionFailed(String reason, String apnType) {
        this.mNotifier.notifyDataConnectionFailed(this, reason, apnType);
    }

    public void notifyPreciseDataConnectionFailed(String reason, String apnType, String apn, String failCause) {
        this.mNotifier.notifyPreciseDataConnectionFailed(this, reason, apnType, apn, failCause);
    }

    public int getLteOnCdmaMode() {
        return this.mCi.getLteOnCdmaMode();
    }

    public void setVoiceMessageWaiting(int line, int countWaiting) {
        Rlog.e(LOG_TAG, "Error! This function should never be executed, inactive Phone.");
    }

    public UsimServiceTable getUsimServiceTable() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        return r != null ? r.getUsimServiceTable() : null;
    }

    public UiccCard getUiccCard() {
        return this.mUiccController.getUiccCard(this.mPhoneId);
    }

    public String[] getPcscfAddress(String apnType) {
        return this.mDcTracker.getPcscfAddress(apnType);
    }

    public void setImsRegistrationState(boolean registered) {
        this.mDcTracker.setImsRegistrationState(registered);
    }

    public Phone getImsPhone() {
        return mImsPhone;
    }

    public ImsPhone relinquishOwnershipOfImsPhone() {
        ImsPhone imsPhone = null;
        synchronized (this.mImsLock) {
            if (mImsPhone == null) {
            } else {
                imsPhone = mImsPhone;
                mImsPhone = null;
                CallManager.getInstance().unregisterPhone(imsPhone);
                imsPhone.unregisterForSilentRedial(this);
            }
        }
        return imsPhone;
    }

    public void acquireOwnershipOfImsPhone(ImsPhone imsPhone) {
        synchronized (this.mImsLock) {
            if (imsPhone == null) {
                return;
            }
            if (mImsPhone != null) {
                Rlog.e(LOG_TAG, "acquireOwnershipOfImsPhone: non-null mImsPhone. Shouldn't happen - but disposing");
                mImsPhone.dispose();
            }
            mImsPhone = imsPhone;
            this.mImsServiceReady = true;
            mImsPhone.updateParentPhone(this);
            CallManager.getInstance().registerPhone(mImsPhone);
            mImsPhone.registerForSilentRedial(this, EVENT_INITIATE_SILENT_REDIAL, null);
        }
    }

    protected void updateImsPhone() {
        synchronized (this.mImsLock) {
            Rlog.d(LOG_TAG, "updateImsPhone mImsServiceReady=" + this.mImsServiceReady);
            if (this.mImsServiceReady && mImsPhone == null) {
                mImsPhone = PhoneFactory.makeImsPhone(this.mNotifier, this);
                CallManager.getInstance().registerPhone(mImsPhone);
                mImsPhone.registerForSilentRedial(this, EVENT_INITIATE_SILENT_REDIAL, null);
            } else if (!(this.mImsServiceReady || mImsPhone == null)) {
                CallManager.getInstance().unregisterPhone(mImsPhone);
                mImsPhone.unregisterForSilentRedial(this);
                mImsPhone.dispose();
                mImsPhone = null;
            }
        }
    }

    protected Connection dialInternal(String dialString, UUSInfo uusInfo, int videoState) throws CallStateException {
        return null;
    }

    public int getSubId() {
        return SubscriptionController.getInstance().getSubIdUsingPhoneId(this.mPhoneId);
    }

    public int getPhoneId() {
        return this.mPhoneId;
    }

    public int getVoicePhoneServiceState() {
        ImsPhone imsPhone = mImsPhone;
        if (imsPhone == null || imsPhone.getServiceState().getState() != 0) {
            return getServiceState().getState();
        }
        return 0;
    }

    public boolean setOperatorBrandOverride(String brand) {
        return false;
    }

    public boolean setRoamingOverride(List<String> gsmRoamingList, List<String> gsmNonRoamingList, List<String> cdmaRoamingList, List<String> cdmaNonRoamingList) {
        String iccId = getIccSerialNumber();
        if (TextUtils.isEmpty(iccId)) {
            return false;
        }
        setRoamingOverrideHelper(gsmRoamingList, GSM_ROAMING_LIST_OVERRIDE_PREFIX, iccId);
        setRoamingOverrideHelper(gsmNonRoamingList, GSM_NON_ROAMING_LIST_OVERRIDE_PREFIX, iccId);
        setRoamingOverrideHelper(cdmaRoamingList, CDMA_ROAMING_LIST_OVERRIDE_PREFIX, iccId);
        setRoamingOverrideHelper(cdmaNonRoamingList, CDMA_NON_ROAMING_LIST_OVERRIDE_PREFIX, iccId);
        ServiceStateTracker tracker = getServiceStateTracker();
        if (tracker != null) {
            tracker.pollState();
        }
        return true;
    }

    private void setRoamingOverrideHelper(List<String> list, String prefix, String iccId) {
        Editor spEditor = PreferenceManager.getDefaultSharedPreferences(this.mContext).edit();
        String key = prefix + iccId;
        if (list == null || list.isEmpty()) {
            spEditor.remove(key).commit();
        } else {
            spEditor.putStringSet(key, new HashSet(list)).commit();
        }
    }

    public boolean isMccMncMarkedAsRoaming(String mccMnc) {
        return getRoamingOverrideHelper(GSM_ROAMING_LIST_OVERRIDE_PREFIX, mccMnc);
    }

    public boolean isMccMncMarkedAsNonRoaming(String mccMnc) {
        return getRoamingOverrideHelper(GSM_NON_ROAMING_LIST_OVERRIDE_PREFIX, mccMnc);
    }

    public boolean isSidMarkedAsRoaming(int SID) {
        return getRoamingOverrideHelper(CDMA_ROAMING_LIST_OVERRIDE_PREFIX, Integer.toString(SID));
    }

    public boolean isSidMarkedAsNonRoaming(int SID) {
        return getRoamingOverrideHelper(CDMA_NON_ROAMING_LIST_OVERRIDE_PREFIX, Integer.toString(SID));
    }

    public boolean isImsRegistered() {
        ImsPhone imsPhone = mImsPhone;
        boolean isImsRegistered = false;
        if (imsPhone != null) {
            isImsRegistered = imsPhone.isImsRegistered();
        } else {
            ServiceStateTracker sst = getServiceStateTracker();
            if (sst != null) {
                isImsRegistered = sst.isImsRegistered();
            }
        }
        Rlog.d(LOG_TAG, "isImsRegistered =" + isImsRegistered);
        return isImsRegistered;
    }

    private boolean getRoamingOverrideHelper(String prefix, String key) {
        String iccId = getIccSerialNumber();
        if (TextUtils.isEmpty(iccId) || TextUtils.isEmpty(key)) {
            return false;
        }
        Set<String> value = PreferenceManager.getDefaultSharedPreferences(this.mContext).getStringSet(prefix + iccId, null);
        if (value != null) {
            return value.contains(key);
        }
        return false;
    }

    public boolean isRadioAvailable() {
        return this.mCi.getRadioState().isAvailable();
    }

    public void shutdownRadio() {
        getServiceStateTracker().requestShutdown();
    }

    public void setRadioCapability(RadioCapability rc, Message response) {
        this.mCi.setRadioCapability(rc, response);
    }

    public int getRadioAccessFamily() {
        return this.mRadioAccessFamily;
    }

    public int getSupportedRadioAccessFamily() {
        return this.mCi.getSupportedRadioAccessFamily();
    }

    public void registerForRadioCapabilityChanged(Handler h, int what, Object obj) {
        this.mCi.registerForRadioCapabilityChanged(h, what, obj);
    }

    public void unregisterForRadioCapabilityChanged(Handler h) {
        this.mCi.unregisterForRadioCapabilityChanged(this);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("PhoneBase: subId=" + getSubId());
        pw.println(" mPhoneId=" + this.mPhoneId);
        pw.println(" mCi=" + this.mCi);
        pw.println(" mDnsCheckDisabled=" + this.mDnsCheckDisabled);
        pw.println(" mDcTracker=" + this.mDcTracker);
        pw.println(" mDoesRilSendMultipleCallRing=" + this.mDoesRilSendMultipleCallRing);
        pw.println(" mCallRingContinueToken=" + this.mCallRingContinueToken);
        pw.println(" mCallRingDelay=" + this.mCallRingDelay);
        pw.println(" mIsTheCurrentActivePhone=" + this.mIsTheCurrentActivePhone);
        pw.println(" mIsVoiceCapable=" + this.mIsVoiceCapable);
        pw.println(" mIccRecords=" + this.mIccRecords.get());
        pw.println(" mUiccApplication=" + this.mUiccApplication.get());
        pw.println(" mSmsStorageMonitor=" + this.mSmsStorageMonitor);
        pw.println(" mSmsUsageMonitor=" + this.mSmsUsageMonitor);
        pw.flush();
        pw.println(" mLooper=" + this.mLooper);
        pw.println(" mContext=" + this.mContext);
        pw.println(" mNotifier=" + this.mNotifier);
        pw.println(" mSimulatedRadioControl=" + this.mSimulatedRadioControl);
        pw.println(" mUnitTestMode=" + this.mUnitTestMode);
        pw.println(" isDnsCheckDisabled()=" + isDnsCheckDisabled());
        pw.println(" getUnitTestMode()=" + getUnitTestMode());
        pw.println(" getState()=" + getState());
        pw.println(" getIccSerialNumber()=" + getIccSerialNumber());
        pw.println(" getIccRecordsLoaded()=" + getIccRecordsLoaded());
        pw.println(" getMessageWaitingIndicator()=" + getMessageWaitingIndicator());
        pw.println(" getCallForwardingIndicator()=" + getCallForwardingIndicator());
        pw.println(" isInEmergencyCall()=" + isInEmergencyCall());
        pw.flush();
        pw.println(" isInEcm()=" + isInEcm());
        pw.println(" getPhoneName()=" + getPhoneName());
        pw.println(" getPhoneType()=" + getPhoneType());
        pw.println(" getVoiceMessageCount()=" + getVoiceMessageCount());
        pw.println(" getActiveApnTypes()=" + getActiveApnTypes());
        pw.println(" isDataConnectivityPossible()=" + isDataConnectivityPossible());
        pw.println(" needsOtaServiceProvisioning=" + needsOtaServiceProvisioning());
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
        try {
            this.mDcTracker.dump(fd, pw, args);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
        try {
            getServiceStateTracker().dump(fd, pw, args);
        } catch (Exception e2) {
            e2.printStackTrace();
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
        try {
            getCallTracker().dump(fd, pw, args);
        } catch (Exception e22) {
            e22.printStackTrace();
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
        try {
            ((RIL) this.mCi).dump(fd, pw, args);
        } catch (Exception e222) {
            e222.printStackTrace();
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
    }
}
