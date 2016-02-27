package com.android.internal.telephony.uicc;

import android.app.ActivityManagerNative;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.CommandsInterface.RadioState;
import com.android.internal.telephony.IccCard;
import com.android.internal.telephony.IccCardConstants.State;
import com.android.internal.telephony.MccTable;
import com.android.internal.telephony.cdma.CdmaSubscriptionSourceManager;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppState;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppType;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.PersoSubState;
import com.android.internal.telephony.uicc.IccCardStatus.CardState;
import com.android.internal.telephony.uicc.IccCardStatus.PinState;
import java.io.FileDescriptor;
import java.io.PrintWriter;

public class IccCardProxy extends Handler implements IccCard {
    public static final String ACTION_INTERNAL_SIM_STATE_CHANGED = "android.intent.action.internal_sim_state_changed";
    private static final boolean DBG = true;
    private static final int EVENT_APP_READY = 6;
    private static final int EVENT_CARRIER_PRIVILIGES_LOADED = 503;
    private static final int EVENT_CDMA_SUBSCRIPTION_SOURCE_CHANGED = 11;
    private static final int EVENT_ICC_ABSENT = 4;
    private static final int EVENT_ICC_CHANGED = 3;
    private static final int EVENT_ICC_LOCKED = 5;
    private static final int EVENT_ICC_RECORD_EVENTS = 500;
    private static final int EVENT_IMSI_READY = 8;
    private static final int EVENT_NETWORK_LOCKED = 9;
    private static final int EVENT_RADIO_OFF_OR_UNAVAILABLE = 1;
    private static final int EVENT_RADIO_ON = 2;
    private static final int EVENT_RECORDS_LOADED = 7;
    private static final int EVENT_SUBSCRIPTION_ACTIVATED = 501;
    private static final int EVENT_SUBSCRIPTION_DEACTIVATED = 502;
    private static final String LOG_TAG = "IccCardProxy";
    private RegistrantList mAbsentRegistrants;
    private CdmaSubscriptionSourceManager mCdmaSSM;
    private CommandsInterface mCi;
    private Context mContext;
    private int mCurrentAppType;
    private State mExternalState;
    private IccRecords mIccRecords;
    private boolean mInitialized;
    private final Object mLock;
    private RegistrantList mNetworkLockedRegistrants;
    private Integer mPhoneId;
    private RegistrantList mPinLockedRegistrants;
    private boolean mQuietMode;
    private boolean mRadioOn;
    private TelephonyManager mTelephonyManager;
    private UiccCardApplication mUiccApplication;
    private UiccCard mUiccCard;
    private UiccController mUiccController;

    /* renamed from: com.android.internal.telephony.uicc.IccCardProxy.1 */
    static /* synthetic */ class C00841 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$IccCardConstants$State;
        static final /* synthetic */ int[] f10xec503f36;

        static {
            $SwitchMap$com$android$internal$telephony$IccCardConstants$State = new int[State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$IccCardConstants$State[State.ABSENT.ordinal()] = IccCardProxy.EVENT_RADIO_OFF_OR_UNAVAILABLE;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$IccCardConstants$State[State.PIN_REQUIRED.ordinal()] = IccCardProxy.EVENT_RADIO_ON;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$IccCardConstants$State[State.PUK_REQUIRED.ordinal()] = IccCardProxy.EVENT_ICC_CHANGED;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$IccCardConstants$State[State.NETWORK_LOCKED.ordinal()] = IccCardProxy.EVENT_ICC_ABSENT;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$IccCardConstants$State[State.READY.ordinal()] = IccCardProxy.EVENT_ICC_LOCKED;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$IccCardConstants$State[State.NOT_READY.ordinal()] = IccCardProxy.EVENT_APP_READY;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$IccCardConstants$State[State.PERM_DISABLED.ordinal()] = IccCardProxy.EVENT_RECORDS_LOADED;
            } catch (NoSuchFieldError e7) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$IccCardConstants$State[State.CARD_IO_ERROR.ordinal()] = IccCardProxy.EVENT_IMSI_READY;
            } catch (NoSuchFieldError e8) {
            }
            f10xec503f36 = new int[AppState.values().length];
            try {
                f10xec503f36[AppState.APPSTATE_UNKNOWN.ordinal()] = IccCardProxy.EVENT_RADIO_OFF_OR_UNAVAILABLE;
            } catch (NoSuchFieldError e9) {
            }
            try {
                f10xec503f36[AppState.APPSTATE_DETECTED.ordinal()] = IccCardProxy.EVENT_RADIO_ON;
            } catch (NoSuchFieldError e10) {
            }
            try {
                f10xec503f36[AppState.APPSTATE_PIN.ordinal()] = IccCardProxy.EVENT_ICC_CHANGED;
            } catch (NoSuchFieldError e11) {
            }
            try {
                f10xec503f36[AppState.APPSTATE_PUK.ordinal()] = IccCardProxy.EVENT_ICC_ABSENT;
            } catch (NoSuchFieldError e12) {
            }
            try {
                f10xec503f36[AppState.APPSTATE_SUBSCRIPTION_PERSO.ordinal()] = IccCardProxy.EVENT_ICC_LOCKED;
            } catch (NoSuchFieldError e13) {
            }
            try {
                f10xec503f36[AppState.APPSTATE_READY.ordinal()] = IccCardProxy.EVENT_APP_READY;
            } catch (NoSuchFieldError e14) {
            }
        }
    }

    public IccCardProxy(Context context, CommandsInterface ci, int phoneId) {
        this.mPhoneId = null;
        this.mLock = new Object();
        this.mAbsentRegistrants = new RegistrantList();
        this.mPinLockedRegistrants = new RegistrantList();
        this.mNetworkLockedRegistrants = new RegistrantList();
        this.mCurrentAppType = EVENT_RADIO_OFF_OR_UNAVAILABLE;
        this.mUiccController = null;
        this.mUiccCard = null;
        this.mUiccApplication = null;
        this.mIccRecords = null;
        this.mCdmaSSM = null;
        this.mRadioOn = false;
        this.mQuietMode = false;
        this.mInitialized = false;
        this.mExternalState = State.UNKNOWN;
        log("ctor: ci=" + ci + " phoneId=" + phoneId);
        this.mContext = context;
        this.mCi = ci;
        this.mPhoneId = Integer.valueOf(phoneId);
        this.mTelephonyManager = (TelephonyManager) this.mContext.getSystemService("phone");
        this.mCdmaSSM = CdmaSubscriptionSourceManager.getInstance(context, ci, this, EVENT_CDMA_SUBSCRIPTION_SOURCE_CHANGED, null);
        this.mUiccController = UiccController.getInstance();
        this.mUiccController.registerForIccChanged(this, EVENT_ICC_CHANGED, null);
        ci.registerForOn(this, EVENT_RADIO_ON, null);
        ci.registerForOffOrNotAvailable(this, EVENT_RADIO_OFF_OR_UNAVAILABLE, null);
        resetProperties();
        setExternalState(State.NOT_READY, false);
    }

    public void dispose() {
        synchronized (this.mLock) {
            log("Disposing");
            this.mUiccController.unregisterForIccChanged(this);
            this.mUiccController = null;
            this.mCi.unregisterForOn(this);
            this.mCi.unregisterForOffOrNotAvailable(this);
            this.mCdmaSSM.dispose(this);
        }
    }

    public void setVoiceRadioTech(int radioTech) {
        synchronized (this.mLock) {
            log("Setting radio tech " + ServiceState.rilRadioTechnologyToString(radioTech));
            if (ServiceState.isGsm(radioTech)) {
                this.mCurrentAppType = EVENT_RADIO_OFF_OR_UNAVAILABLE;
            } else {
                this.mCurrentAppType = EVENT_RADIO_ON;
            }
            updateQuietMode();
        }
    }

    private void updateQuietMode() {
        boolean newQuietMode = false;
        synchronized (this.mLock) {
            boolean isLteOnCdmaMode;
            boolean oldQuietMode = this.mQuietMode;
            int cdmaSource = -1;
            if (TelephonyManager.getLteOnCdmaModeStatic() == EVENT_RADIO_OFF_OR_UNAVAILABLE) {
                isLteOnCdmaMode = DBG;
            } else {
                isLteOnCdmaMode = false;
            }
            if (this.mCurrentAppType == EVENT_RADIO_OFF_OR_UNAVAILABLE) {
                newQuietMode = false;
                log("updateQuietMode: 3GPP subscription -> newQuietMode=" + false);
            } else {
                if (isLteOnCdmaMode) {
                    log("updateQuietMode: is cdma/lte device, force IccCardProxy into 3gpp mode");
                    this.mCurrentAppType = EVENT_RADIO_OFF_OR_UNAVAILABLE;
                }
                cdmaSource = this.mCdmaSSM != null ? this.mCdmaSSM.getCdmaSubscriptionSource() : -1;
                if (cdmaSource == EVENT_RADIO_OFF_OR_UNAVAILABLE && this.mCurrentAppType == EVENT_RADIO_ON && !isLteOnCdmaMode) {
                    newQuietMode = DBG;
                }
                log("updateQuietMode: cdmaSource=" + cdmaSource + " mCurrentAppType=" + this.mCurrentAppType + " isLteOnCdmaMode=" + isLteOnCdmaMode + " newQuietMode=" + newQuietMode);
            }
            if (!this.mQuietMode && newQuietMode == DBG) {
                log("Switching to QuietMode.");
                setExternalState(State.READY);
                this.mQuietMode = newQuietMode;
            } else if (this.mQuietMode != DBG || newQuietMode) {
                log("updateQuietMode: no changes don't setExternalState");
            } else {
                log("updateQuietMode: Switching out from QuietMode. Force broadcast of current state=" + this.mExternalState);
                this.mQuietMode = newQuietMode;
                setExternalState(this.mExternalState, DBG);
            }
            log("updateQuietMode: QuietMode is " + this.mQuietMode + " (app_type=" + this.mCurrentAppType + " isLteOnCdmaMode=" + isLteOnCdmaMode + " cdmaSource=" + cdmaSource + ")");
            this.mInitialized = DBG;
            sendMessage(obtainMessage(EVENT_ICC_CHANGED));
        }
    }

    public void handleMessage(Message msg) {
        switch (msg.what) {
            case EVENT_RADIO_OFF_OR_UNAVAILABLE /*1*/:
                this.mRadioOn = false;
                if (RadioState.RADIO_UNAVAILABLE == this.mCi.getRadioState()) {
                    setExternalState(State.NOT_READY);
                }
            case EVENT_RADIO_ON /*2*/:
                this.mRadioOn = DBG;
                if (!this.mInitialized) {
                    updateQuietMode();
                }
            case EVENT_ICC_CHANGED /*3*/:
                if (this.mInitialized) {
                    updateIccAvailability();
                }
            case EVENT_ICC_ABSENT /*4*/:
                this.mAbsentRegistrants.notifyRegistrants();
                setExternalState(State.ABSENT);
            case EVENT_ICC_LOCKED /*5*/:
                processLockedState();
            case EVENT_APP_READY /*6*/:
                setExternalState(State.READY);
            case EVENT_RECORDS_LOADED /*7*/:
                if (this.mIccRecords != null) {
                    String operator = this.mIccRecords.getOperatorNumeric();
                    log("operator=" + operator + " mPhoneId=" + this.mPhoneId);
                    if (operator != null) {
                        log("update icc_operator_numeric=" + operator);
                        this.mTelephonyManager.setSimOperatorNumericForPhone(this.mPhoneId.intValue(), operator);
                        String countryCode = operator.substring(0, EVENT_ICC_CHANGED);
                        if (countryCode != null) {
                            this.mTelephonyManager.setSimCountryIsoForPhone(this.mPhoneId.intValue(), MccTable.countryCodeForMcc(Integer.parseInt(countryCode)));
                        } else {
                            loge("EVENT_RECORDS_LOADED Country code is null");
                        }
                    } else {
                        loge("EVENT_RECORDS_LOADED Operator name is null");
                    }
                }
                if (this.mUiccCard == null || this.mUiccCard.areCarrierPriviligeRulesLoaded()) {
                    onRecordsLoaded();
                } else {
                    this.mUiccCard.registerForCarrierPrivilegeRulesLoaded(this, EVENT_CARRIER_PRIVILIGES_LOADED, null);
                }
            case EVENT_IMSI_READY /*8*/:
                broadcastIccStateChangedIntent("IMSI", null);
            case EVENT_NETWORK_LOCKED /*9*/:
                this.mNetworkLockedRegistrants.notifyRegistrants();
                setExternalState(State.NETWORK_LOCKED);
            case EVENT_CDMA_SUBSCRIPTION_SOURCE_CHANGED /*11*/:
                updateQuietMode();
            case EVENT_ICC_RECORD_EVENTS /*500*/:
                if (this.mCurrentAppType == EVENT_RADIO_OFF_OR_UNAVAILABLE && this.mIccRecords != null && ((Integer) msg.obj.result).intValue() == EVENT_RADIO_ON) {
                    this.mTelephonyManager.setSimOperatorNameForPhone(this.mPhoneId.intValue(), this.mIccRecords.getServiceProviderName());
                }
            case EVENT_SUBSCRIPTION_ACTIVATED /*501*/:
                log("EVENT_SUBSCRIPTION_ACTIVATED");
                onSubscriptionActivated();
            case EVENT_SUBSCRIPTION_DEACTIVATED /*502*/:
                log("EVENT_SUBSCRIPTION_DEACTIVATED");
                onSubscriptionDeactivated();
            case EVENT_CARRIER_PRIVILIGES_LOADED /*503*/:
                log("EVENT_CARRIER_PRIVILEGES_LOADED");
                if (this.mUiccCard != null) {
                    this.mUiccCard.unregisterForCarrierPrivilegeRulesLoaded(this);
                }
                onRecordsLoaded();
            default:
                loge("Unhandled message with number: " + msg.what);
        }
    }

    private void onSubscriptionActivated() {
        updateIccAvailability();
        updateStateProperty();
    }

    private void onSubscriptionDeactivated() {
        resetProperties();
        updateIccAvailability();
        updateStateProperty();
    }

    private void onRecordsLoaded() {
        broadcastInternalIccStateChangedIntent("LOADED", null);
    }

    private void updateIccAvailability() {
        synchronized (this.mLock) {
            UiccCard newCard = this.mUiccController.getUiccCard(this.mPhoneId.intValue());
            CardState state = CardState.CARDSTATE_ABSENT;
            UiccCardApplication newApp = null;
            IccRecords newRecords = null;
            if (newCard != null) {
                state = newCard.getCardState();
                newApp = newCard.getApplication(this.mCurrentAppType);
                if (newApp != null) {
                    newRecords = newApp.getIccRecords();
                }
            }
            if (!(this.mIccRecords == newRecords && this.mUiccApplication == newApp && this.mUiccCard == newCard)) {
                log("Icc changed. Reregestering.");
                unregisterUiccCardEvents();
                this.mUiccCard = newCard;
                this.mUiccApplication = newApp;
                this.mIccRecords = newRecords;
                registerUiccCardEvents();
            }
            updateExternalState();
        }
    }

    void resetProperties() {
        if (this.mCurrentAppType == EVENT_RADIO_OFF_OR_UNAVAILABLE) {
            log("update icc_operator_numeric=");
            this.mTelephonyManager.setSimOperatorNumericForPhone(this.mPhoneId.intValue(), "");
            this.mTelephonyManager.setSimCountryIsoForPhone(this.mPhoneId.intValue(), "");
            this.mTelephonyManager.setSimOperatorNameForPhone(this.mPhoneId.intValue(), "");
        }
    }

    private void HandleDetectedState() {
    }

    private void updateExternalState() {
        if (this.mUiccCard == null || this.mUiccCard.getCardState() == CardState.CARDSTATE_ABSENT) {
            if (this.mRadioOn) {
                setExternalState(State.ABSENT);
            } else {
                setExternalState(State.NOT_READY);
            }
        } else if (this.mUiccCard.getCardState() == CardState.CARDSTATE_ERROR) {
            setExternalState(State.CARD_IO_ERROR);
        } else if (this.mUiccApplication == null) {
            setExternalState(State.NOT_READY);
        } else {
            switch (C00841.f10xec503f36[this.mUiccApplication.getState().ordinal()]) {
                case EVENT_RADIO_OFF_OR_UNAVAILABLE /*1*/:
                    setExternalState(State.UNKNOWN);
                case EVENT_RADIO_ON /*2*/:
                    HandleDetectedState();
                case EVENT_ICC_CHANGED /*3*/:
                    setExternalState(State.PIN_REQUIRED);
                case EVENT_ICC_ABSENT /*4*/:
                    setExternalState(State.PUK_REQUIRED);
                case EVENT_ICC_LOCKED /*5*/:
                    if (this.mUiccApplication.getPersoSubState() == PersoSubState.PERSOSUBSTATE_SIM_NETWORK) {
                        setExternalState(State.NETWORK_LOCKED);
                    } else {
                        setExternalState(State.UNKNOWN);
                    }
                case EVENT_APP_READY /*6*/:
                    setExternalState(State.READY);
                default:
            }
        }
    }

    private void registerUiccCardEvents() {
        if (this.mUiccCard != null) {
            this.mUiccCard.registerForAbsent(this, EVENT_ICC_ABSENT, null);
        }
        if (this.mUiccApplication != null) {
            this.mUiccApplication.registerForReady(this, EVENT_APP_READY, null);
            this.mUiccApplication.registerForLocked(this, EVENT_ICC_LOCKED, null);
            this.mUiccApplication.registerForNetworkLocked(this, EVENT_NETWORK_LOCKED, null);
        }
        if (this.mIccRecords != null) {
            this.mIccRecords.registerForImsiReady(this, EVENT_IMSI_READY, null);
            this.mIccRecords.registerForRecordsLoaded(this, EVENT_RECORDS_LOADED, null);
            this.mIccRecords.registerForRecordsEvents(this, EVENT_ICC_RECORD_EVENTS, null);
        }
    }

    private void unregisterUiccCardEvents() {
        if (this.mUiccCard != null) {
            this.mUiccCard.unregisterForAbsent(this);
        }
        if (this.mUiccApplication != null) {
            this.mUiccApplication.unregisterForReady(this);
        }
        if (this.mUiccApplication != null) {
            this.mUiccApplication.unregisterForLocked(this);
        }
        if (this.mUiccApplication != null) {
            this.mUiccApplication.unregisterForNetworkLocked(this);
        }
        if (this.mIccRecords != null) {
            this.mIccRecords.unregisterForImsiReady(this);
        }
        if (this.mIccRecords != null) {
            this.mIccRecords.unregisterForRecordsLoaded(this);
        }
        if (this.mIccRecords != null) {
            this.mIccRecords.unregisterForRecordsEvents(this);
        }
    }

    private void updateStateProperty() {
        this.mTelephonyManager.setSimStateForPhone(this.mPhoneId.intValue(), getState().toString());
    }

    private void broadcastIccStateChangedIntent(String value, String reason) {
        synchronized (this.mLock) {
            if (this.mPhoneId == null || !SubscriptionManager.isValidSlotId(this.mPhoneId.intValue())) {
                loge("broadcastIccStateChangedIntent: mPhoneId=" + this.mPhoneId + " is invalid; Return!!");
            } else if (this.mQuietMode) {
                log("broadcastIccStateChangedIntent: QuietMode NOT Broadcasting intent ACTION_SIM_STATE_CHANGED  value=" + value + " reason=" + reason);
            } else {
                Intent intent = new Intent("android.intent.action.SIM_STATE_CHANGED");
                intent.addFlags(67108864);
                intent.putExtra("phoneName", "Phone");
                intent.putExtra("ss", value);
                intent.putExtra("reason", reason);
                SubscriptionManager.putPhoneIdAndSubIdExtra(intent, this.mPhoneId.intValue());
                log("broadcastIccStateChangedIntent intent ACTION_SIM_STATE_CHANGED value=" + value + " reason=" + reason + " for mPhoneId=" + this.mPhoneId);
                ActivityManagerNative.broadcastStickyIntent(intent, "android.permission.READ_PHONE_STATE", -1);
            }
        }
    }

    private void broadcastInternalIccStateChangedIntent(String value, String reason) {
        synchronized (this.mLock) {
            if (this.mPhoneId == null) {
                loge("broadcastInternalIccStateChangedIntent: Card Index is not set; Return!!");
                return;
            }
            Intent intent = new Intent(ACTION_INTERNAL_SIM_STATE_CHANGED);
            intent.addFlags(603979776);
            intent.putExtra("phoneName", "Phone");
            intent.putExtra("ss", value);
            intent.putExtra("reason", reason);
            intent.putExtra("phone", this.mPhoneId);
            log("Sending intent ACTION_INTERNAL_SIM_STATE_CHANGED for mPhoneId : " + this.mPhoneId);
            ActivityManagerNative.broadcastStickyIntent(intent, null, -1);
        }
    }

    private void setExternalState(State newState, boolean override) {
        synchronized (this.mLock) {
            if (this.mPhoneId == null || !SubscriptionManager.isValidSlotId(this.mPhoneId.intValue())) {
                loge("setExternalState: mPhoneId=" + this.mPhoneId + " is invalid; Return!!");
            } else if (override || newState != this.mExternalState) {
                this.mExternalState = newState;
                loge("setExternalState: set mPhoneId=" + this.mPhoneId + " mExternalState=" + this.mExternalState);
                this.mTelephonyManager.setSimStateForPhone(this.mPhoneId.intValue(), getState().toString());
                if ("LOCKED".equals(getIccStateIntentString(this.mExternalState))) {
                    broadcastInternalIccStateChangedIntent(getIccStateIntentString(this.mExternalState), getIccStateReason(this.mExternalState));
                } else {
                    broadcastIccStateChangedIntent(getIccStateIntentString(this.mExternalState), getIccStateReason(this.mExternalState));
                }
                if (State.ABSENT == this.mExternalState) {
                    this.mAbsentRegistrants.notifyRegistrants();
                }
            } else {
                loge("setExternalState: !override and newstate unchanged from " + newState);
            }
        }
    }

    private void processLockedState() {
        synchronized (this.mLock) {
            if (this.mUiccApplication == null) {
            } else if (this.mUiccApplication.getPin1State() == PinState.PINSTATE_ENABLED_PERM_BLOCKED) {
                setExternalState(State.PERM_DISABLED);
            } else {
                switch (C00841.f10xec503f36[this.mUiccApplication.getState().ordinal()]) {
                    case EVENT_ICC_CHANGED /*3*/:
                        this.mPinLockedRegistrants.notifyRegistrants();
                        setExternalState(State.PIN_REQUIRED);
                        break;
                    case EVENT_ICC_ABSENT /*4*/:
                        setExternalState(State.PUK_REQUIRED);
                        break;
                }
            }
        }
    }

    private void setExternalState(State newState) {
        setExternalState(newState, false);
    }

    public boolean getIccRecordsLoaded() {
        boolean recordsLoaded;
        synchronized (this.mLock) {
            if (this.mIccRecords != null) {
                recordsLoaded = this.mIccRecords.getRecordsLoaded();
            } else {
                recordsLoaded = false;
            }
        }
        return recordsLoaded;
    }

    private String getIccStateIntentString(State state) {
        switch (C00841.$SwitchMap$com$android$internal$telephony$IccCardConstants$State[state.ordinal()]) {
            case EVENT_RADIO_OFF_OR_UNAVAILABLE /*1*/:
                return "ABSENT";
            case EVENT_RADIO_ON /*2*/:
                return "LOCKED";
            case EVENT_ICC_CHANGED /*3*/:
                return "LOCKED";
            case EVENT_ICC_ABSENT /*4*/:
                return "LOCKED";
            case EVENT_ICC_LOCKED /*5*/:
                return "READY";
            case EVENT_APP_READY /*6*/:
                return "NOT_READY";
            case EVENT_RECORDS_LOADED /*7*/:
                return "LOCKED";
            case EVENT_IMSI_READY /*8*/:
                return "CARD_IO_ERROR";
            default:
                return "UNKNOWN";
        }
    }

    private String getIccStateReason(State state) {
        switch (C00841.$SwitchMap$com$android$internal$telephony$IccCardConstants$State[state.ordinal()]) {
            case EVENT_RADIO_ON /*2*/:
                return "PIN";
            case EVENT_ICC_CHANGED /*3*/:
                return "PUK";
            case EVENT_ICC_ABSENT /*4*/:
                return "NETWORK";
            case EVENT_RECORDS_LOADED /*7*/:
                return "PERM_DISABLED";
            case EVENT_IMSI_READY /*8*/:
                return "CARD_IO_ERROR";
            default:
                return null;
        }
    }

    public State getState() {
        State state;
        synchronized (this.mLock) {
            state = this.mExternalState;
        }
        return state;
    }

    public IccRecords getIccRecords() {
        IccRecords iccRecords;
        synchronized (this.mLock) {
            iccRecords = this.mIccRecords;
        }
        return iccRecords;
    }

    public IccFileHandler getIccFileHandler() {
        IccFileHandler iccFileHandler;
        synchronized (this.mLock) {
            if (this.mUiccApplication != null) {
                iccFileHandler = this.mUiccApplication.getIccFileHandler();
            } else {
                iccFileHandler = null;
            }
        }
        return iccFileHandler;
    }

    public void registerForAbsent(Handler h, int what, Object obj) {
        synchronized (this.mLock) {
            Registrant r = new Registrant(h, what, obj);
            this.mAbsentRegistrants.add(r);
            if (getState() == State.ABSENT) {
                r.notifyRegistrant();
            }
        }
    }

    public void unregisterForAbsent(Handler h) {
        synchronized (this.mLock) {
            this.mAbsentRegistrants.remove(h);
        }
    }

    public void registerForNetworkLocked(Handler h, int what, Object obj) {
        synchronized (this.mLock) {
            Registrant r = new Registrant(h, what, obj);
            this.mNetworkLockedRegistrants.add(r);
            if (getState() == State.NETWORK_LOCKED) {
                r.notifyRegistrant();
            }
        }
    }

    public void unregisterForNetworkLocked(Handler h) {
        synchronized (this.mLock) {
            this.mNetworkLockedRegistrants.remove(h);
        }
    }

    public void registerForLocked(Handler h, int what, Object obj) {
        synchronized (this.mLock) {
            Registrant r = new Registrant(h, what, obj);
            this.mPinLockedRegistrants.add(r);
            if (getState().isPinLocked()) {
                r.notifyRegistrant();
            }
        }
    }

    public void unregisterForLocked(Handler h) {
        synchronized (this.mLock) {
            this.mPinLockedRegistrants.remove(h);
        }
    }

    public void supplyPin(String pin, Message onComplete) {
        synchronized (this.mLock) {
            if (this.mUiccApplication != null) {
                this.mUiccApplication.supplyPin(pin, onComplete);
            } else if (onComplete != null) {
                AsyncResult.forMessage(onComplete).exception = new RuntimeException("ICC card is absent.");
                onComplete.sendToTarget();
                return;
            }
        }
    }

    public void supplyPuk(String puk, String newPin, Message onComplete) {
        synchronized (this.mLock) {
            if (this.mUiccApplication != null) {
                this.mUiccApplication.supplyPuk(puk, newPin, onComplete);
            } else if (onComplete != null) {
                AsyncResult.forMessage(onComplete).exception = new RuntimeException("ICC card is absent.");
                onComplete.sendToTarget();
                return;
            }
        }
    }

    public void supplyPin2(String pin2, Message onComplete) {
        synchronized (this.mLock) {
            if (this.mUiccApplication != null) {
                this.mUiccApplication.supplyPin2(pin2, onComplete);
            } else if (onComplete != null) {
                AsyncResult.forMessage(onComplete).exception = new RuntimeException("ICC card is absent.");
                onComplete.sendToTarget();
                return;
            }
        }
    }

    public void supplyPuk2(String puk2, String newPin2, Message onComplete) {
        synchronized (this.mLock) {
            if (this.mUiccApplication != null) {
                this.mUiccApplication.supplyPuk2(puk2, newPin2, onComplete);
            } else if (onComplete != null) {
                AsyncResult.forMessage(onComplete).exception = new RuntimeException("ICC card is absent.");
                onComplete.sendToTarget();
                return;
            }
        }
    }

    public void supplyNetworkDepersonalization(String pin, Message onComplete) {
        synchronized (this.mLock) {
            if (this.mUiccApplication != null) {
                this.mUiccApplication.supplyNetworkDepersonalization(pin, onComplete);
            } else if (onComplete != null) {
                AsyncResult.forMessage(onComplete).exception = new RuntimeException("CommandsInterface is not set.");
                onComplete.sendToTarget();
                return;
            }
        }
    }

    public boolean getIccLockEnabled() {
        boolean booleanValue;
        synchronized (this.mLock) {
            booleanValue = Boolean.valueOf(this.mUiccApplication != null ? this.mUiccApplication.getIccLockEnabled() : false).booleanValue();
        }
        return booleanValue;
    }

    public boolean getIccFdnEnabled() {
        boolean booleanValue;
        synchronized (this.mLock) {
            booleanValue = Boolean.valueOf(this.mUiccApplication != null ? this.mUiccApplication.getIccFdnEnabled() : false).booleanValue();
        }
        return booleanValue;
    }

    public boolean getIccFdnAvailable() {
        return this.mUiccApplication != null ? this.mUiccApplication.getIccFdnAvailable() : false;
    }

    public boolean getIccPin2Blocked() {
        return Boolean.valueOf(this.mUiccApplication != null ? this.mUiccApplication.getIccPin2Blocked() : false).booleanValue();
    }

    public boolean getIccPuk2Blocked() {
        return Boolean.valueOf(this.mUiccApplication != null ? this.mUiccApplication.getIccPuk2Blocked() : false).booleanValue();
    }

    public void setIccLockEnabled(boolean enabled, String password, Message onComplete) {
        synchronized (this.mLock) {
            if (this.mUiccApplication != null) {
                this.mUiccApplication.setIccLockEnabled(enabled, password, onComplete);
            } else if (onComplete != null) {
                AsyncResult.forMessage(onComplete).exception = new RuntimeException("ICC card is absent.");
                onComplete.sendToTarget();
                return;
            }
        }
    }

    public void setIccFdnEnabled(boolean enabled, String password, Message onComplete) {
        synchronized (this.mLock) {
            if (this.mUiccApplication != null) {
                this.mUiccApplication.setIccFdnEnabled(enabled, password, onComplete);
            } else if (onComplete != null) {
                AsyncResult.forMessage(onComplete).exception = new RuntimeException("ICC card is absent.");
                onComplete.sendToTarget();
                return;
            }
        }
    }

    public void changeIccLockPassword(String oldPassword, String newPassword, Message onComplete) {
        synchronized (this.mLock) {
            if (this.mUiccApplication != null) {
                this.mUiccApplication.changeIccLockPassword(oldPassword, newPassword, onComplete);
            } else if (onComplete != null) {
                AsyncResult.forMessage(onComplete).exception = new RuntimeException("ICC card is absent.");
                onComplete.sendToTarget();
                return;
            }
        }
    }

    public void changeIccFdnPassword(String oldPassword, String newPassword, Message onComplete) {
        synchronized (this.mLock) {
            if (this.mUiccApplication != null) {
                this.mUiccApplication.changeIccFdnPassword(oldPassword, newPassword, onComplete);
            } else if (onComplete != null) {
                AsyncResult.forMessage(onComplete).exception = new RuntimeException("ICC card is absent.");
                onComplete.sendToTarget();
                return;
            }
        }
    }

    public String getServiceProviderName() {
        String serviceProviderName;
        synchronized (this.mLock) {
            if (this.mIccRecords != null) {
                serviceProviderName = this.mIccRecords.getServiceProviderName();
            } else {
                serviceProviderName = null;
            }
        }
        return serviceProviderName;
    }

    public boolean isApplicationOnIcc(AppType type) {
        boolean booleanValue;
        synchronized (this.mLock) {
            booleanValue = Boolean.valueOf(this.mUiccCard != null ? this.mUiccCard.isApplicationOnIcc(type) : false).booleanValue();
        }
        return booleanValue;
    }

    public boolean hasIccCard() {
        boolean z;
        synchronized (this.mLock) {
            if (this.mUiccCard == null || this.mUiccCard.getCardState() == CardState.CARDSTATE_ABSENT) {
                z = false;
            } else {
                z = DBG;
            }
        }
        return z;
    }

    private void setSystemProperty(String property, String value) {
        TelephonyManager.setTelephonyProperty(this.mPhoneId.intValue(), property, value);
    }

    public IccRecords getIccRecord() {
        return this.mIccRecords;
    }

    private void log(String s) {
        Rlog.d(LOG_TAG, s);
    }

    private void loge(String msg) {
        Rlog.e(LOG_TAG, msg);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        int i;
        pw.println("IccCardProxy: " + this);
        pw.println(" mContext=" + this.mContext);
        pw.println(" mCi=" + this.mCi);
        pw.println(" mAbsentRegistrants: size=" + this.mAbsentRegistrants.size());
        for (i = 0; i < this.mAbsentRegistrants.size(); i += EVENT_RADIO_OFF_OR_UNAVAILABLE) {
            pw.println("  mAbsentRegistrants[" + i + "]=" + ((Registrant) this.mAbsentRegistrants.get(i)).getHandler());
        }
        pw.println(" mPinLockedRegistrants: size=" + this.mPinLockedRegistrants.size());
        for (i = 0; i < this.mPinLockedRegistrants.size(); i += EVENT_RADIO_OFF_OR_UNAVAILABLE) {
            pw.println("  mPinLockedRegistrants[" + i + "]=" + ((Registrant) this.mPinLockedRegistrants.get(i)).getHandler());
        }
        pw.println(" mNetworkLockedRegistrants: size=" + this.mNetworkLockedRegistrants.size());
        for (i = 0; i < this.mNetworkLockedRegistrants.size(); i += EVENT_RADIO_OFF_OR_UNAVAILABLE) {
            pw.println("  mNetworkLockedRegistrants[" + i + "]=" + ((Registrant) this.mNetworkLockedRegistrants.get(i)).getHandler());
        }
        pw.println(" mCurrentAppType=" + this.mCurrentAppType);
        pw.println(" mUiccController=" + this.mUiccController);
        pw.println(" mUiccCard=" + this.mUiccCard);
        pw.println(" mUiccApplication=" + this.mUiccApplication);
        pw.println(" mIccRecords=" + this.mIccRecords);
        pw.println(" mCdmaSSM=" + this.mCdmaSSM);
        pw.println(" mRadioOn=" + this.mRadioOn);
        pw.println(" mQuietMode=" + this.mQuietMode);
        pw.println(" mInitialized=" + this.mInitialized);
        pw.println(" mExternalState=" + this.mExternalState);
        pw.flush();
    }
}
