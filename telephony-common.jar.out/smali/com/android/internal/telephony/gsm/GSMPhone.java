package com.android.internal.telephony.gsm;

import android.content.ContentValues;
import android.content.Context;
import android.content.SharedPreferences.Editor;
import android.database.SQLException;
import android.net.Uri;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.preference.PreferenceManager;
import android.provider.Settings.Global;
import android.provider.Telephony.Carriers;
import android.telephony.CellLocation;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Log;
import com.android.ims.ImsManager;
import com.android.internal.telephony.Call;
import com.android.internal.telephony.CallForwardInfo;
import com.android.internal.telephony.CallStateException;
import com.android.internal.telephony.CallTracker;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.Connection;
import com.android.internal.telephony.DctConstants.Activity;
import com.android.internal.telephony.DctConstants.State;
import com.android.internal.telephony.IccPhoneBookInterfaceManager;
import com.android.internal.telephony.MmiCode;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.Phone.DataActivityState;
import com.android.internal.telephony.Phone.SuppService;
import com.android.internal.telephony.PhoneBase;
import com.android.internal.telephony.PhoneConstants;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.android.internal.telephony.PhoneNotifier;
import com.android.internal.telephony.PhoneProxy;
import com.android.internal.telephony.PhoneSubInfo;
import com.android.internal.telephony.RadioNVItems;
import com.android.internal.telephony.ServiceStateTracker;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.UUSInfo;
import com.android.internal.telephony.cdma.sms.CdmaSmsAddress;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.dataconnection.DcTracker;
import com.android.internal.telephony.imsphone.ImsPhone;
import com.android.internal.telephony.test.SimulatedRadioControl;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.IccVmNotSupportedException;
import com.android.internal.telephony.uicc.IsimRecords;
import com.android.internal.telephony.uicc.IsimUiccRecords;
import com.android.internal.telephony.uicc.UiccCard;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class GSMPhone extends PhoneBase {
    public static final String CIPHERING_KEY = "ciphering_key";
    private static final boolean LOCAL_DEBUG = true;
    static final String LOG_TAG = "GSMPhone";
    private static final boolean VDBG = false;
    public static final String VM_NUMBER = "vm_number_key";
    public static final String VM_SIM_IMSI = "vm_sim_imsi_key";
    GsmCallTracker mCT;
    private final RegistrantList mEcmTimerResetRegistrants;
    private String mImei;
    private String mImeiSv;
    private IsimUiccRecords mIsimUiccRecords;
    ArrayList<GsmMmiCode> mPendingMMIs;
    Registrant mPostDialHandler;
    GsmServiceStateTracker mSST;
    SimPhoneBookInterfaceManager mSimPhoneBookIntManager;
    RegistrantList mSsnRegistrants;
    PhoneSubInfo mSubInfo;
    private String mVmNumber;

    /* renamed from: com.android.internal.telephony.gsm.GSMPhone.1 */
    static /* synthetic */ class C00661 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$DctConstants$Activity;
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$DctConstants$State;

        static {
            $SwitchMap$com$android$internal$telephony$DctConstants$Activity = new int[Activity.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$Activity[Activity.DATAIN.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$Activity[Activity.DATAOUT.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$Activity[Activity.DATAINANDOUT.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$Activity[Activity.DORMANT.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            $SwitchMap$com$android$internal$telephony$DctConstants$State = new int[State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.RETRYING.ordinal()] = 1;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.FAILED.ordinal()] = 2;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.IDLE.ordinal()] = 3;
            } catch (NoSuchFieldError e7) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.CONNECTED.ordinal()] = 4;
            } catch (NoSuchFieldError e8) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.DISCONNECTING.ordinal()] = 5;
            } catch (NoSuchFieldError e9) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.CONNECTING.ordinal()] = 6;
            } catch (NoSuchFieldError e10) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.SCANNING.ordinal()] = 7;
            } catch (NoSuchFieldError e11) {
            }
        }
    }

    private static class Cfu {
        final Message mOnComplete;
        final String mSetCfNumber;

        Cfu(String cfNumber, Message onComplete) {
            this.mSetCfNumber = cfNumber;
            this.mOnComplete = onComplete;
        }
    }

    public GSMPhone(Context context, CommandsInterface ci, PhoneNotifier notifier, boolean unitTestMode) {
        super("GSM", notifier, context, ci, unitTestMode);
        this.mPendingMMIs = new ArrayList();
        this.mSsnRegistrants = new RegistrantList();
        this.mEcmTimerResetRegistrants = new RegistrantList();
        if (ci instanceof SimulatedRadioControl) {
            this.mSimulatedRadioControl = (SimulatedRadioControl) ci;
        }
        this.mCi.setPhoneType(1);
        this.mCT = new GsmCallTracker(this);
        this.mSST = new GsmServiceStateTracker(this);
        this.mDcTracker = new DcTracker(this);
        if (!unitTestMode) {
            this.mSimPhoneBookIntManager = new SimPhoneBookInterfaceManager(this);
            this.mSubInfo = new PhoneSubInfo(this);
        }
        this.mCi.registerForAvailable(this, 1, null);
        this.mCi.registerForOffOrNotAvailable(this, 8, null);
        this.mCi.registerForOn(this, 5, null);
        this.mCi.setOnUSSD(this, 7, null);
        this.mCi.setOnSuppServiceNotification(this, 2, null);
        this.mSST.registerForNetworkAttached(this, 19, null);
        this.mCi.setOnSs(this, 36, null);
        setProperties();
    }

    public GSMPhone(Context context, CommandsInterface ci, PhoneNotifier notifier, int phoneId) {
        this(context, ci, notifier, VDBG, phoneId);
    }

    public GSMPhone(Context context, CommandsInterface ci, PhoneNotifier notifier, boolean unitTestMode, int phoneId) {
        super("GSM", notifier, context, ci, unitTestMode, phoneId);
        this.mPendingMMIs = new ArrayList();
        this.mSsnRegistrants = new RegistrantList();
        this.mEcmTimerResetRegistrants = new RegistrantList();
        if (ci instanceof SimulatedRadioControl) {
            this.mSimulatedRadioControl = (SimulatedRadioControl) ci;
        }
        this.mCi.setPhoneType(1);
        this.mCT = new GsmCallTracker(this);
        this.mSST = new GsmServiceStateTracker(this);
        this.mDcTracker = new DcTracker(this);
        if (!unitTestMode) {
            this.mSimPhoneBookIntManager = new SimPhoneBookInterfaceManager(this);
            this.mSubInfo = new PhoneSubInfo(this);
        }
        this.mCi.registerForAvailable(this, 1, null);
        this.mCi.registerForOffOrNotAvailable(this, 8, null);
        this.mCi.registerForOn(this, 5, null);
        this.mCi.setOnUSSD(this, 7, null);
        this.mCi.setOnSuppServiceNotification(this, 2, null);
        this.mSST.registerForNetworkAttached(this, 19, null);
        this.mCi.setOnSs(this, 36, null);
        setProperties();
        log("GSMPhone: constructor: sub = " + this.mPhoneId);
        setProperties();
    }

    protected void setProperties() {
        TelephonyManager.from(this.mContext).setPhoneType(getPhoneId(), 1);
    }

    public void dispose() {
        synchronized (PhoneProxy.lockForRadioTechnologyChange) {
            super.dispose();
            this.mCi.unregisterForAvailable(this);
            unregisterForSimRecordEvents();
            this.mCi.unregisterForOffOrNotAvailable(this);
            this.mCi.unregisterForOn(this);
            this.mSST.unregisterForNetworkAttached(this);
            this.mCi.unSetOnUSSD(this);
            this.mCi.unSetOnSuppServiceNotification(this);
            this.mCi.unSetOnSs(this);
            this.mPendingMMIs.clear();
            this.mCT.dispose();
            this.mDcTracker.dispose();
            this.mSST.dispose();
            this.mSimPhoneBookIntManager.dispose();
            this.mSubInfo.dispose();
        }
    }

    public void removeReferences() {
        Rlog.d(LOG_TAG, "removeReferences");
        this.mSimulatedRadioControl = null;
        this.mSimPhoneBookIntManager = null;
        this.mSubInfo = null;
        this.mCT = null;
        this.mSST = null;
        super.removeReferences();
    }

    protected void finalize() {
        Rlog.d(LOG_TAG, "GSMPhone finalized");
    }

    public ServiceState getServiceState() {
        if ((this.mSST == null || this.mSST.mSS.getState() != 0) && mImsPhone != null) {
            return ServiceState.mergeServiceStates(this.mSST == null ? new ServiceState() : this.mSST.mSS, mImsPhone.getServiceState());
        } else if (this.mSST != null) {
            return this.mSST.mSS;
        } else {
            return new ServiceState();
        }
    }

    public CellLocation getCellLocation() {
        return this.mSST.getCellLocation();
    }

    public PhoneConstants.State getState() {
        if (mImsPhone != null) {
            PhoneConstants.State imsState = mImsPhone.getState();
            if (imsState != PhoneConstants.State.IDLE) {
                return imsState;
            }
        }
        return this.mCT.mState;
    }

    public int getPhoneType() {
        return 1;
    }

    public ServiceStateTracker getServiceStateTracker() {
        return this.mSST;
    }

    public CallTracker getCallTracker() {
        return this.mCT;
    }

    private void updateVoiceMail() {
        int countVoiceMessages = 0;
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null) {
            countVoiceMessages = r.getVoiceMessageCount();
        }
        int countVoiceMessagesStored = getStoredVoiceMessageCount();
        if (countVoiceMessages == -1 && countVoiceMessagesStored != 0) {
            countVoiceMessages = countVoiceMessagesStored;
        }
        Rlog.d(LOG_TAG, "updateVoiceMail countVoiceMessages = " + countVoiceMessages + " subId " + getSubId());
        setVoiceMessageCount(countVoiceMessages);
    }

    public List<? extends MmiCode> getPendingMmiCodes() {
        return this.mPendingMMIs;
    }

    public DataState getDataConnectionState(String apnType) {
        DataState ret = DataState.DISCONNECTED;
        if (this.mSST == null) {
            return DataState.DISCONNECTED;
        }
        if (!apnType.equals("emergency") && this.mSST.getCurrentDataConnectionState() != 0) {
            return DataState.DISCONNECTED;
        }
        if (!this.mDcTracker.isApnTypeEnabled(apnType) || !this.mDcTracker.isApnTypeActive(apnType)) {
            return DataState.DISCONNECTED;
        }
        switch (C00661.$SwitchMap$com$android$internal$telephony$DctConstants$State[this.mDcTracker.getState(apnType).ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return DataState.DISCONNECTED;
            case CharacterSets.ISO_8859_1 /*4*/:
            case CharacterSets.ISO_8859_2 /*5*/:
                if (this.mCT.mState == PhoneConstants.State.IDLE || this.mSST.isConcurrentVoiceAndDataAllowed()) {
                    return DataState.CONNECTED;
                }
                return DataState.SUSPENDED;
            case CharacterSets.ISO_8859_3 /*6*/:
            case CharacterSets.ISO_8859_4 /*7*/:
                return DataState.CONNECTING;
            default:
                return ret;
        }
    }

    public DataActivityState getDataActivityState() {
        DataActivityState ret = DataActivityState.NONE;
        if (this.mSST.getCurrentDataConnectionState() != 0) {
            return ret;
        }
        switch (C00661.$SwitchMap$com$android$internal$telephony$DctConstants$Activity[this.mDcTracker.getActivity().ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return DataActivityState.DATAIN;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return DataActivityState.DATAOUT;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return DataActivityState.DATAINANDOUT;
            case CharacterSets.ISO_8859_1 /*4*/:
                return DataActivityState.DORMANT;
            default:
                return DataActivityState.NONE;
        }
    }

    void notifyPhoneStateChanged() {
        this.mNotifier.notifyPhoneState(this);
    }

    void notifyPreciseCallStateChanged() {
        super.notifyPreciseCallStateChangedP();
    }

    public void notifyNewRingingConnection(Connection c) {
        super.notifyNewRingingConnectionP(c);
    }

    void notifyDisconnect(Connection cn) {
        this.mDisconnectRegistrants.notifyResult(cn);
        this.mNotifier.notifyDisconnectCause(cn.getDisconnectCause(), cn.getPreciseDisconnectCause());
    }

    void notifyUnknownConnection(Connection cn) {
        this.mUnknownConnectionRegistrants.notifyResult(cn);
    }

    void notifySuppServiceFailed(SuppService code) {
        this.mSuppServiceFailedRegistrants.notifyResult(code);
    }

    void notifyServiceStateChanged(ServiceState ss) {
        super.notifyServiceStateChangedP(ss);
    }

    void notifyLocationChanged() {
        this.mNotifier.notifyCellLocation(this);
    }

    public void notifyCallForwardingIndicator() {
        this.mNotifier.notifyCallForwardingChanged(this);
    }

    public void setSystemProperty(String property, String value) {
        TelephonyManager.setTelephonyProperty(this.mPhoneId, property, value);
    }

    public void registerForSuppServiceNotification(Handler h, int what, Object obj) {
        this.mSsnRegistrants.addUnique(h, what, obj);
        if (this.mSsnRegistrants.size() == 1) {
            this.mCi.setSuppServiceNotifications(LOCAL_DEBUG, null);
        }
    }

    public void unregisterForSuppServiceNotification(Handler h) {
        this.mSsnRegistrants.remove(h);
        if (this.mSsnRegistrants.size() == 0) {
            this.mCi.setSuppServiceNotifications(VDBG, null);
        }
    }

    public void registerForSimRecordsLoaded(Handler h, int what, Object obj) {
        this.mSimRecordsLoadedRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForSimRecordsLoaded(Handler h) {
        this.mSimRecordsLoadedRegistrants.remove(h);
    }

    public void acceptCall(int videoState) throws CallStateException {
        ImsPhone imsPhone = mImsPhone;
        if (imsPhone == null || !imsPhone.getRingingCall().isRinging()) {
            this.mCT.acceptCall();
        } else {
            imsPhone.acceptCall(videoState);
        }
    }

    public void rejectCall() throws CallStateException {
        this.mCT.rejectCall();
    }

    public void switchHoldingAndActive() throws CallStateException {
        this.mCT.switchWaitingOrHoldingAndActive();
    }

    public boolean canConference() {
        boolean canImsConference = VDBG;
        if (mImsPhone != null) {
            canImsConference = mImsPhone.canConference();
        }
        return (this.mCT.canConference() || canImsConference) ? LOCAL_DEBUG : VDBG;
    }

    public boolean canDial() {
        return this.mCT.canDial();
    }

    public void conference() {
        if (mImsPhone == null || !mImsPhone.canConference()) {
            this.mCT.conference();
            return;
        }
        log("conference() - delegated to IMS phone");
        mImsPhone.conference();
    }

    public void clearDisconnected() {
        this.mCT.clearDisconnected();
    }

    public boolean canTransfer() {
        return this.mCT.canTransfer();
    }

    public void explicitCallTransfer() {
        this.mCT.explicitCallTransfer();
    }

    public GsmCall getForegroundCall() {
        return this.mCT.mForegroundCall;
    }

    public GsmCall getBackgroundCall() {
        return this.mCT.mBackgroundCall;
    }

    public Call getRingingCall() {
        ImsPhone imsPhone = mImsPhone;
        if (this.mCT.mRingingCall != null && this.mCT.mRingingCall.isRinging()) {
            return this.mCT.mRingingCall;
        }
        if (imsPhone != null) {
            return imsPhone.getRingingCall();
        }
        return this.mCT.mRingingCall;
    }

    private boolean handleCallDeflectionIncallSupplementaryService(String dialString) {
        if (dialString.length() > 1) {
            return VDBG;
        }
        if (getRingingCall().getState() != Call.State.IDLE) {
            Rlog.d(LOG_TAG, "MmiCode 0: rejectCall");
            try {
                this.mCT.rejectCall();
                return LOCAL_DEBUG;
            } catch (CallStateException e) {
                Rlog.d(LOG_TAG, "reject failed", e);
                notifySuppServiceFailed(SuppService.REJECT);
                return LOCAL_DEBUG;
            }
        } else if (getBackgroundCall().getState() == Call.State.IDLE) {
            return LOCAL_DEBUG;
        } else {
            Rlog.d(LOG_TAG, "MmiCode 0: hangupWaitingOrBackground");
            this.mCT.hangupWaitingOrBackground();
            return LOCAL_DEBUG;
        }
    }

    private boolean handleCallWaitingIncallSupplementaryService(String dialString) {
        int len = dialString.length();
        if (len > 2) {
            return VDBG;
        }
        GsmCall call = getForegroundCall();
        if (len > 1) {
            try {
                int callIndex = dialString.charAt(1) - 48;
                if (callIndex < 1 || callIndex > 7) {
                    return LOCAL_DEBUG;
                }
                Rlog.d(LOG_TAG, "MmiCode 1: hangupConnectionByIndex " + callIndex);
                this.mCT.hangupConnectionByIndex(call, callIndex);
                return LOCAL_DEBUG;
            } catch (CallStateException e) {
                Rlog.d(LOG_TAG, "hangup failed", e);
                notifySuppServiceFailed(SuppService.HANGUP);
                return LOCAL_DEBUG;
            }
        } else if (call.getState() != Call.State.IDLE) {
            Rlog.d(LOG_TAG, "MmiCode 1: hangup foreground");
            this.mCT.hangup(call);
            return LOCAL_DEBUG;
        } else {
            Rlog.d(LOG_TAG, "MmiCode 1: switchWaitingOrHoldingAndActive");
            this.mCT.switchWaitingOrHoldingAndActive();
            return LOCAL_DEBUG;
        }
    }

    private boolean handleCallHoldIncallSupplementaryService(String dialString) {
        int len = dialString.length();
        if (len > 2) {
            return VDBG;
        }
        GsmCall call = getForegroundCall();
        if (len > 1) {
            try {
                int callIndex = dialString.charAt(1) - 48;
                GsmConnection conn = this.mCT.getConnectionByIndex(call, callIndex);
                if (conn == null || callIndex < 1 || callIndex > 7) {
                    Rlog.d(LOG_TAG, "separate: invalid call index " + callIndex);
                    notifySuppServiceFailed(SuppService.SEPARATE);
                    return LOCAL_DEBUG;
                }
                Rlog.d(LOG_TAG, "MmiCode 2: separate call " + callIndex);
                this.mCT.separate(conn);
                return LOCAL_DEBUG;
            } catch (CallStateException e) {
                Rlog.d(LOG_TAG, "separate failed", e);
                notifySuppServiceFailed(SuppService.SEPARATE);
                return LOCAL_DEBUG;
            }
        }
        try {
            if (getRingingCall().getState() != Call.State.IDLE) {
                Rlog.d(LOG_TAG, "MmiCode 2: accept ringing call");
                this.mCT.acceptCall();
                return LOCAL_DEBUG;
            }
            Rlog.d(LOG_TAG, "MmiCode 2: switchWaitingOrHoldingAndActive");
            this.mCT.switchWaitingOrHoldingAndActive();
            return LOCAL_DEBUG;
        } catch (CallStateException e2) {
            Rlog.d(LOG_TAG, "switch failed", e2);
            notifySuppServiceFailed(SuppService.SWITCH);
            return LOCAL_DEBUG;
        }
    }

    private boolean handleMultipartyIncallSupplementaryService(String dialString) {
        if (dialString.length() > 1) {
            return VDBG;
        }
        Rlog.d(LOG_TAG, "MmiCode 3: merge calls");
        conference();
        return LOCAL_DEBUG;
    }

    private boolean handleEctIncallSupplementaryService(String dialString) {
        if (dialString.length() != 1) {
            return VDBG;
        }
        Rlog.d(LOG_TAG, "MmiCode 4: explicit call transfer");
        explicitCallTransfer();
        return LOCAL_DEBUG;
    }

    private boolean handleCcbsIncallSupplementaryService(String dialString) {
        if (dialString.length() > 1) {
            return VDBG;
        }
        Rlog.i(LOG_TAG, "MmiCode 5: CCBS not supported!");
        notifySuppServiceFailed(SuppService.UNKNOWN);
        return LOCAL_DEBUG;
    }

    public boolean handleInCallMmiCommands(String dialString) throws CallStateException {
        ImsPhone imsPhone = mImsPhone;
        if (imsPhone != null && imsPhone.getServiceState().getState() == 0) {
            return imsPhone.handleInCallMmiCommands(dialString);
        }
        if (!isInCall()) {
            return VDBG;
        }
        if (TextUtils.isEmpty(dialString)) {
            return VDBG;
        }
        switch (dialString.charAt(0)) {
            case '0':
                return handleCallDeflectionIncallSupplementaryService(dialString);
            case CallFailCause.QOS_NOT_AVAIL /*49*/:
                return handleCallWaitingIncallSupplementaryService(dialString);
            case '2':
                return handleCallHoldIncallSupplementaryService(dialString);
            case RadioNVItems.RIL_NV_CDMA_PRL_VERSION /*51*/:
                return handleMultipartyIncallSupplementaryService(dialString);
            case RadioNVItems.RIL_NV_CDMA_BC10 /*52*/:
                return handleEctIncallSupplementaryService(dialString);
            case RadioNVItems.RIL_NV_CDMA_BC14 /*53*/:
                return handleCcbsIncallSupplementaryService(dialString);
            default:
                return VDBG;
        }
    }

    boolean isInCall() {
        return (getForegroundCall().getState().isAlive() || getBackgroundCall().getState().isAlive() || getRingingCall().getState().isAlive()) ? LOCAL_DEBUG : VDBG;
    }

    public Connection dial(String dialString, int videoState) throws CallStateException {
        return dial(dialString, null, videoState);
    }

    public Connection dial(String dialString, UUSInfo uusInfo, int videoState) throws CallStateException {
        boolean imsUseEnabled;
        Object valueOf;
        ImsPhone imsPhone = mImsPhone;
        if (ImsManager.isVolteEnabledByPlatform(this.mContext) && ImsManager.isEnhanced4gLteModeSettingEnabledByUser(this.mContext) && ImsManager.isNonTtyOrTtyOnVolteEnabled(this.mContext)) {
            imsUseEnabled = LOCAL_DEBUG;
        } else {
            imsUseEnabled = VDBG;
        }
        if (!imsUseEnabled) {
            Rlog.w(LOG_TAG, "IMS is disabled: forced to CS");
        }
        String str = LOG_TAG;
        StringBuilder append = new StringBuilder().append("imsUseEnabled=").append(imsUseEnabled).append(", imsPhone=").append(imsPhone).append(", imsPhone.isVolteEnabled()=").append(imsPhone != null ? Boolean.valueOf(imsPhone.isVolteEnabled()) : "N/A").append(", imsPhone.getServiceState().getState()=");
        if (imsPhone != null) {
            valueOf = Integer.valueOf(imsPhone.getServiceState().getState());
        } else {
            valueOf = "N/A";
        }
        Rlog.d(str, append.append(valueOf).toString());
        if (imsUseEnabled && imsPhone != null && imsPhone.isVolteEnabled() && ((imsPhone.getServiceState().getState() == 0 && !PhoneNumberUtils.isEmergencyNumber(dialString)) || (PhoneNumberUtils.isEmergencyNumber(dialString) && this.mContext.getResources().getBoolean(17956994)))) {
            try {
                Rlog.d(LOG_TAG, "Trying IMS PS call");
                return imsPhone.dial(dialString, videoState);
            } catch (CallStateException e) {
                Rlog.d(LOG_TAG, "IMS PS call exception " + e + "imsUseEnabled =" + imsUseEnabled + ", imsPhone =" + imsPhone);
                if (!ImsPhone.CS_FALLBACK.equals(e.getMessage())) {
                    CallStateException ce = new CallStateException(e.getMessage());
                    ce.setStackTrace(e.getStackTrace());
                    throw ce;
                }
            }
        }
        Rlog.d(LOG_TAG, "Trying (non-IMS) CS call");
        return dialInternal(dialString, null, 0);
    }

    protected Connection dialInternal(String dialString, UUSInfo uusInfo, int videoState) throws CallStateException {
        String newDialString = PhoneNumberUtils.stripSeparators(dialString);
        if (handleInCallMmiCommands(newDialString)) {
            return null;
        }
        GsmMmiCode mmi = GsmMmiCode.newFromDialString(PhoneNumberUtils.extractNetworkPortionAlt(newDialString), this, (UiccCardApplication) this.mUiccApplication.get());
        Rlog.d(LOG_TAG, "dialing w/ mmi '" + mmi + "'...");
        if (mmi == null) {
            return this.mCT.dial(newDialString, uusInfo);
        }
        if (mmi.isTemporaryModeCLIR()) {
            return this.mCT.dial(mmi.mDialingNumber, mmi.getCLIRMode(), uusInfo);
        }
        this.mPendingMMIs.add(mmi);
        this.mMmiRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
        mmi.processCode();
        return null;
    }

    public boolean handlePinMmi(String dialString) {
        GsmMmiCode mmi = GsmMmiCode.newFromDialString(dialString, this, (UiccCardApplication) this.mUiccApplication.get());
        if (mmi == null || !mmi.isPinPukCommand()) {
            return VDBG;
        }
        this.mPendingMMIs.add(mmi);
        this.mMmiRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
        mmi.processCode();
        return LOCAL_DEBUG;
    }

    public void sendUssdResponse(String ussdMessge) {
        GsmMmiCode mmi = GsmMmiCode.newFromUssdUserInput(ussdMessge, this, (UiccCardApplication) this.mUiccApplication.get());
        this.mPendingMMIs.add(mmi);
        this.mMmiRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
        mmi.sendUssd(ussdMessge);
    }

    public void sendDtmf(char c) {
        if (!PhoneNumberUtils.is12Key(c)) {
            Rlog.e(LOG_TAG, "sendDtmf called with invalid character '" + c + "'");
        } else if (this.mCT.mState == PhoneConstants.State.OFFHOOK) {
            this.mCi.sendDtmf(c, null);
        }
    }

    public void startDtmf(char c) {
        if (PhoneNumberUtils.is12Key(c)) {
            this.mCi.startDtmf(c, null);
        } else {
            Rlog.e(LOG_TAG, "startDtmf called with invalid character '" + c + "'");
        }
    }

    public void stopDtmf() {
        this.mCi.stopDtmf(null);
    }

    public void sendBurstDtmf(String dtmfString) {
        Rlog.e(LOG_TAG, "[GSMPhone] sendBurstDtmf() is a CDMA method");
    }

    public void setRadioPower(boolean power) {
        this.mSST.setRadioPower(power);
    }

    private void storeVoiceMailNumber(String number) {
        Editor editor = PreferenceManager.getDefaultSharedPreferences(getContext()).edit();
        editor.putString(VM_NUMBER + getPhoneId(), number);
        editor.apply();
        setVmSimImsi(getSubscriberId());
    }

    public String getVoiceMailNumber() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        String number = r != null ? r.getVoiceMailNumber() : "";
        if (TextUtils.isEmpty(number)) {
            number = PreferenceManager.getDefaultSharedPreferences(getContext()).getString(VM_NUMBER + getPhoneId(), null);
        }
        if (!TextUtils.isEmpty(number)) {
            return number;
        }
        String[] listArray = getContext().getResources().getStringArray(17236028);
        if (listArray == null || listArray.length <= 0) {
            return number;
        }
        for (int i = 0; i < listArray.length; i++) {
            if (!TextUtils.isEmpty(listArray[i])) {
                String[] defaultVMNumberArray = listArray[i].split(";");
                if (defaultVMNumberArray != null && defaultVMNumberArray.length > 0) {
                    if (defaultVMNumberArray.length == 1) {
                        number = defaultVMNumberArray[0];
                    } else if (defaultVMNumberArray.length == 2 && !TextUtils.isEmpty(defaultVMNumberArray[1]) && defaultVMNumberArray[1].equalsIgnoreCase(getGroupIdLevel1())) {
                        return defaultVMNumberArray[0];
                    }
                }
            }
        }
        return number;
    }

    private String getVmSimImsi() {
        return PreferenceManager.getDefaultSharedPreferences(getContext()).getString(VM_SIM_IMSI + getPhoneId(), null);
    }

    private void setVmSimImsi(String imsi) {
        Editor editor = PreferenceManager.getDefaultSharedPreferences(getContext()).edit();
        editor.putString(VM_SIM_IMSI + getPhoneId(), imsi);
        editor.apply();
    }

    public String getVoiceMailAlphaTag() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        String ret = r != null ? r.getVoiceMailAlphaTag() : "";
        if (ret == null || ret.length() == 0) {
            return this.mContext.getText(17039364).toString();
        }
        return ret;
    }

    public String getDeviceId() {
        return this.mImei;
    }

    public String getDeviceSvn() {
        return this.mImeiSv;
    }

    public IsimRecords getIsimRecords() {
        return this.mIsimUiccRecords;
    }

    public String getImei() {
        return this.mImei;
    }

    public String getEsn() {
        Rlog.e(LOG_TAG, "[GSMPhone] getEsn() is a CDMA method");
        return "0";
    }

    public String getMeid() {
        Rlog.e(LOG_TAG, "[GSMPhone] getMeid() is a CDMA method");
        return "0";
    }

    public String getNai() {
        IccRecords r = this.mUiccController.getIccRecords(this.mPhoneId, 2);
        if (Log.isLoggable(LOG_TAG, 2)) {
            Rlog.v(LOG_TAG, "IccRecords is " + r);
        }
        return r != null ? r.getNAI() : null;
    }

    public String getSubscriberId() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        return r != null ? r.getIMSI() : null;
    }

    public String getGroupIdLevel1() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        return r != null ? r.getGid1() : null;
    }

    public String getLine1Number() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        return r != null ? r.getMsisdnNumber() : null;
    }

    public String getMsisdn() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        return r != null ? r.getMsisdnNumber() : null;
    }

    public String getLine1AlphaTag() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        return r != null ? r.getMsisdnAlphaTag() : null;
    }

    public boolean setLine1Number(String alphaTag, String number, Message onComplete) {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r == null) {
            return VDBG;
        }
        r.setMsisdnNumber(alphaTag, number, onComplete);
        return LOCAL_DEBUG;
    }

    public void setVoiceMailNumber(String alphaTag, String voiceMailNumber, Message onComplete) {
        this.mVmNumber = voiceMailNumber;
        Message resp = obtainMessage(20, 0, 0, onComplete);
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null) {
            r.setVoiceMailNumber(alphaTag, this.mVmNumber, resp);
        }
    }

    private boolean isValidCommandInterfaceCFReason(int commandInterfaceCFReason) {
        switch (commandInterfaceCFReason) {
            case CharacterSets.ANY_CHARSET /*0*/:
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
            case CharacterSets.ISO_8859_2 /*5*/:
                return LOCAL_DEBUG;
            default:
                return VDBG;
        }
    }

    public String getSystemProperty(String property, String defValue) {
        if (getUnitTestMode()) {
            return null;
        }
        return TelephonyManager.getTelephonyProperty(this.mPhoneId, property, defValue);
    }

    private boolean isValidCommandInterfaceCFAction(int commandInterfaceCFAction) {
        switch (commandInterfaceCFAction) {
            case CharacterSets.ANY_CHARSET /*0*/:
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
                return LOCAL_DEBUG;
            default:
                return VDBG;
        }
    }

    public void updateDataConnectionTracker() {
        ((DcTracker) this.mDcTracker).update();
    }

    protected boolean isCfEnable(int action) {
        return (action == 1 || action == 3) ? LOCAL_DEBUG : VDBG;
    }

    public void getCallForwardingOption(int commandInterfaceCFReason, Message onComplete) {
        ImsPhone imsPhone = mImsPhone;
        if (imsPhone != null && imsPhone.getServiceState().getState() == 0) {
            imsPhone.getCallForwardingOption(commandInterfaceCFReason, onComplete);
        } else if (isValidCommandInterfaceCFReason(commandInterfaceCFReason)) {
            Message resp;
            Rlog.d(LOG_TAG, "requesting call forwarding query.");
            if (commandInterfaceCFReason == 0) {
                resp = obtainMessage(13, onComplete);
            } else {
                resp = onComplete;
            }
            this.mCi.queryCallForwardStatus(commandInterfaceCFReason, 0, null, resp);
        }
    }

    public void setCallForwardingOption(int commandInterfaceCFAction, int commandInterfaceCFReason, String dialingNumber, int timerSeconds, Message onComplete) {
        ImsPhone imsPhone = mImsPhone;
        if (imsPhone != null && imsPhone.getServiceState().getState() == 0) {
            imsPhone.setCallForwardingOption(commandInterfaceCFAction, commandInterfaceCFReason, dialingNumber, timerSeconds, onComplete);
        } else if (isValidCommandInterfaceCFAction(commandInterfaceCFAction) && isValidCommandInterfaceCFReason(commandInterfaceCFReason)) {
            Message resp;
            if (commandInterfaceCFReason == 0) {
                int i;
                Cfu cfu = new Cfu(dialingNumber, onComplete);
                if (isCfEnable(commandInterfaceCFAction)) {
                    i = 1;
                } else {
                    i = 0;
                }
                resp = obtainMessage(12, i, 0, cfu);
            } else {
                resp = onComplete;
            }
            this.mCi.setCallForward(commandInterfaceCFAction, commandInterfaceCFReason, 1, dialingNumber, timerSeconds, resp);
        }
    }

    public void getOutgoingCallerIdDisplay(Message onComplete) {
        this.mCi.getCLIR(onComplete);
    }

    public void setOutgoingCallerIdDisplay(int commandInterfaceCLIRMode, Message onComplete) {
        this.mCi.setCLIR(commandInterfaceCLIRMode, obtainMessage(18, commandInterfaceCLIRMode, 0, onComplete));
    }

    public void getCallWaiting(Message onComplete) {
        ImsPhone imsPhone = mImsPhone;
        if (imsPhone == null || imsPhone.getServiceState().getState() != 0) {
            this.mCi.queryCallWaiting(0, onComplete);
        } else {
            imsPhone.getCallWaiting(onComplete);
        }
    }

    public void setCallWaiting(boolean enable, Message onComplete) {
        ImsPhone imsPhone = mImsPhone;
        if (imsPhone == null || imsPhone.getServiceState().getState() != 0) {
            this.mCi.setCallWaiting(enable, 1, onComplete);
        } else {
            imsPhone.setCallWaiting(enable, onComplete);
        }
    }

    public void getAvailableNetworks(Message response) {
        this.mCi.getAvailableNetworks(response);
    }

    public void getNeighboringCids(Message response) {
        this.mCi.getNeighboringCids(response);
    }

    public void setOnPostDialCharacter(Handler h, int what, Object obj) {
        this.mPostDialHandler = new Registrant(h, what, obj);
    }

    public void setUiTTYMode(int uiTtyMode, Message onComplete) {
        if (mImsPhone != null) {
            mImsPhone.setUiTTYMode(uiTtyMode, onComplete);
        }
    }

    public void setMute(boolean muted) {
        this.mCT.setMute(muted);
    }

    public boolean getMute() {
        return this.mCT.getMute();
    }

    public void getDataCallList(Message response) {
        this.mCi.getDataCallList(response);
    }

    public void updateServiceLocation() {
        this.mSST.enableSingleLocationUpdate();
    }

    public void enableLocationUpdates() {
        this.mSST.enableLocationUpdates();
    }

    public void disableLocationUpdates() {
        this.mSST.disableLocationUpdates();
    }

    public boolean getDataRoamingEnabled() {
        return this.mDcTracker.getDataOnRoamingEnabled();
    }

    public void setDataRoamingEnabled(boolean enable) {
        this.mDcTracker.setDataOnRoamingEnabled(enable);
    }

    public boolean getDataEnabled() {
        return this.mDcTracker.getDataEnabled();
    }

    public void setDataEnabled(boolean enable) {
        this.mDcTracker.setDataEnabled(enable);
    }

    void onMMIDone(GsmMmiCode mmi) {
        if (this.mPendingMMIs.remove(mmi) || mmi.isUssdRequest() || mmi.isSsInfo()) {
            this.mMmiCompleteRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
        }
    }

    private void onNetworkInitiatedUssd(GsmMmiCode mmi) {
        this.mMmiCompleteRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
    }

    private void onIncomingUSSD(int ussdMode, String ussdMessage) {
        boolean isUssdRequest;
        boolean isUssdError;
        boolean isUssdRelease = LOCAL_DEBUG;
        if (ussdMode == 1) {
            isUssdRequest = LOCAL_DEBUG;
        } else {
            isUssdRequest = VDBG;
        }
        if (ussdMode == 0 || ussdMode == 1) {
            isUssdError = VDBG;
        } else {
            isUssdError = LOCAL_DEBUG;
        }
        if (ussdMode != 2) {
            isUssdRelease = VDBG;
        }
        GsmMmiCode found = null;
        int s = this.mPendingMMIs.size();
        for (int i = 0; i < s; i++) {
            if (((GsmMmiCode) this.mPendingMMIs.get(i)).isPendingUSSD()) {
                found = (GsmMmiCode) this.mPendingMMIs.get(i);
                break;
            }
        }
        if (found != null) {
            if (isUssdRelease) {
                found.onUssdRelease();
            } else if (isUssdError) {
                found.onUssdFinishedError();
            } else {
                found.onUssdFinished(ussdMessage, isUssdRequest);
            }
        } else if (!isUssdError && ussdMessage != null) {
            onNetworkInitiatedUssd(GsmMmiCode.newNetworkInitiatedUssd(ussdMessage, isUssdRequest, this, (UiccCardApplication) this.mUiccApplication.get()));
        }
    }

    protected void syncClirSetting() {
        int clirSetting = PreferenceManager.getDefaultSharedPreferences(getContext()).getInt(PhoneBase.CLIR_KEY + getPhoneId(), -1);
        if (clirSetting >= 0) {
            this.mCi.setCLIR(clirSetting, null);
        }
    }

    public void handleMessage(Message msg) {
        switch (msg.what) {
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
                super.handleMessage(msg);
            default:
                if (this.mIsTheCurrentActivePhone) {
                    AsyncResult ar;
                    Message onComplete;
                    switch (msg.what) {
                        case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                            this.mCi.getBasebandVersion(obtainMessage(6));
                            this.mCi.getIMEI(obtainMessage(9));
                            this.mCi.getIMEISV(obtainMessage(10));
                            this.mCi.getRadioCapability(obtainMessage(35));
                            return;
                        case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                            ar = (AsyncResult) msg.obj;
                            SuppServiceNotification not = ar.result;
                            this.mSsnRegistrants.notifyRegistrants(ar);
                            return;
                        case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                            updateCurrentCarrierInProvider();
                            String imsi = getVmSimImsi();
                            String imsiFromSIM = getSubscriberId();
                            if (!(imsi == null || imsiFromSIM == null || imsiFromSIM.equals(imsi))) {
                                storeVoiceMailNumber(null);
                                setVmSimImsi(null);
                            }
                            this.mSimRecordsLoadedRegistrants.notifyRegistrants();
                            updateVoiceMail();
                            return;
                        case CharacterSets.ISO_8859_2 /*5*/:
                            return;
                        case CharacterSets.ISO_8859_3 /*6*/:
                            ar = msg.obj;
                            if (ar.exception == null) {
                                Rlog.d(LOG_TAG, "Baseband version: " + ar.result);
                                TelephonyManager.from(this.mContext).setBasebandVersionForPhone(getPhoneId(), (String) ar.result);
                                return;
                            }
                            return;
                        case CharacterSets.ISO_8859_4 /*7*/:
                            String[] ussdResult = (String[]) ((AsyncResult) msg.obj).result;
                            if (ussdResult.length > 1) {
                                try {
                                    onIncomingUSSD(Integer.parseInt(ussdResult[0]), ussdResult[1]);
                                    return;
                                } catch (NumberFormatException e) {
                                    Rlog.w(LOG_TAG, "error parsing USSD");
                                    return;
                                }
                            }
                            return;
                        case CharacterSets.ISO_8859_5 /*8*/:
                            for (int i = this.mPendingMMIs.size() - 1; i >= 0; i--) {
                                if (((GsmMmiCode) this.mPendingMMIs.get(i)).isPendingUSSD()) {
                                    ((GsmMmiCode) this.mPendingMMIs.get(i)).onUssdFinishedError();
                                }
                            }
                            ImsPhone imsPhone = mImsPhone;
                            if (imsPhone != null) {
                                imsPhone.getServiceState().setStateOff();
                            }
                            this.mRadioOffOrNotAvailableRegistrants.notifyRegistrants();
                            return;
                        case CharacterSets.ISO_8859_6 /*9*/:
                            ar = (AsyncResult) msg.obj;
                            if (ar.exception == null) {
                                this.mImei = (String) ar.result;
                                return;
                            }
                            return;
                        case CharacterSets.ISO_8859_7 /*10*/:
                            ar = (AsyncResult) msg.obj;
                            if (ar.exception == null) {
                                this.mImeiSv = (String) ar.result;
                                return;
                            }
                            return;
                        case CharacterSets.ISO_8859_9 /*12*/:
                            ar = (AsyncResult) msg.obj;
                            IccRecords r = (IccRecords) this.mIccRecords.get();
                            Cfu cfu = ar.userObj;
                            if (ar.exception == null && r != null) {
                                r.setVoiceCallForwardingFlag(1, msg.arg1 == 1 ? LOCAL_DEBUG : VDBG, cfu.mSetCfNumber);
                            }
                            if (cfu.mOnComplete != null) {
                                AsyncResult.forMessage(cfu.mOnComplete, ar.result, ar.exception);
                                cfu.mOnComplete.sendToTarget();
                                return;
                            }
                            return;
                        case UserData.ASCII_CR_INDEX /*13*/:
                            ar = (AsyncResult) msg.obj;
                            if (ar.exception == null) {
                                handleCfuQueryResult((CallForwardInfo[]) ar.result);
                            }
                            onComplete = (Message) ar.userObj;
                            if (onComplete != null) {
                                AsyncResult.forMessage(onComplete, ar.result, ar.exception);
                                onComplete.sendToTarget();
                                return;
                            }
                            return;
                        case PduHeaders.MMS_VERSION_1_2 /*18*/:
                            ar = (AsyncResult) msg.obj;
                            if (ar.exception == null) {
                                saveClirSetting(msg.arg1);
                            }
                            onComplete = (Message) ar.userObj;
                            if (onComplete != null) {
                                AsyncResult.forMessage(onComplete, ar.result, ar.exception);
                                onComplete.sendToTarget();
                                return;
                            }
                            return;
                        case PduHeaders.MMS_VERSION_1_3 /*19*/:
                            syncClirSetting();
                            return;
                        case SmsHeader.ELT_ID_EXTENDED_OBJECT /*20*/:
                            ar = (AsyncResult) msg.obj;
                            if (IccVmNotSupportedException.class.isInstance(ar.exception)) {
                                storeVoiceMailNumber(this.mVmNumber);
                                ar.exception = null;
                            }
                            onComplete = ar.userObj;
                            if (onComplete != null) {
                                AsyncResult.forMessage(onComplete, ar.result, ar.exception);
                                onComplete.sendToTarget();
                                return;
                            }
                            return;
                        case 28:
                            ar = (AsyncResult) msg.obj;
                            if (this.mSST.mSS.getIsManualSelection()) {
                                setNetworkSelectionModeAutomatic((Message) ar.result);
                                Rlog.d(LOG_TAG, "SET_NETWORK_SELECTION_AUTOMATIC: set to automatic");
                                return;
                            }
                            Rlog.d(LOG_TAG, "SET_NETWORK_SELECTION_AUTOMATIC: already automatic, ignore");
                            return;
                        case 29:
                            processIccRecordEvents(((Integer) ((AsyncResult) msg.obj).result).intValue());
                            return;
                        case CdmaSmsAddress.SMS_SUBADDRESS_MAX /*36*/:
                            ar = (AsyncResult) msg.obj;
                            Rlog.d(LOG_TAG, "Event EVENT_SS received");
                            new GsmMmiCode(this, (UiccCardApplication) this.mUiccApplication.get()).processSsData(ar);
                            return;
                        default:
                            super.handleMessage(msg);
                            return;
                    }
                }
                Rlog.e(LOG_TAG, "Received message " + msg + "[" + msg.what + "] while being destroyed. Ignoring.");
        }
    }

    protected UiccCardApplication getUiccCardApplication() {
        return this.mUiccController.getUiccCardApplication(this.mPhoneId, 1);
    }

    protected void onUpdateIccAvailability() {
        if (this.mUiccController != null) {
            UiccCardApplication newUiccApplication = this.mUiccController.getUiccCardApplication(this.mPhoneId, 3);
            IsimUiccRecords newIsimUiccRecords = null;
            if (newUiccApplication != null) {
                newIsimUiccRecords = (IsimUiccRecords) newUiccApplication.getIccRecords();
                log("New ISIM application found");
            }
            this.mIsimUiccRecords = newIsimUiccRecords;
            newUiccApplication = getUiccCardApplication();
            UiccCardApplication app = (UiccCardApplication) this.mUiccApplication.get();
            if (app != newUiccApplication) {
                if (app != null) {
                    log("Removing stale icc objects.");
                    if (this.mIccRecords.get() != null) {
                        unregisterForSimRecordEvents();
                        this.mSimPhoneBookIntManager.updateIccRecords(null);
                    }
                    this.mIccRecords.set(null);
                    this.mUiccApplication.set(null);
                }
                if (newUiccApplication != null) {
                    log("New Uicc application found");
                    this.mUiccApplication.set(newUiccApplication);
                    this.mIccRecords.set(newUiccApplication.getIccRecords());
                    registerForSimRecordEvents();
                    this.mSimPhoneBookIntManager.updateIccRecords((IccRecords) this.mIccRecords.get());
                }
            }
        }
    }

    private void processIccRecordEvents(int eventCode) {
        switch (eventCode) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                notifyCallForwardingIndicator();
            default:
        }
    }

    public boolean updateCurrentCarrierInProvider() {
        long currentDds = (long) SubscriptionManager.getDefaultDataSubId();
        String operatorNumeric = getOperatorNumeric();
        log("updateCurrentCarrierInProvider: mSubId = " + getSubId() + " currentDds = " + currentDds + " operatorNumeric = " + operatorNumeric);
        if (!TextUtils.isEmpty(operatorNumeric) && ((long) getSubId()) == currentDds) {
            try {
                Uri uri = Uri.withAppendedPath(Carriers.CONTENT_URI, Carriers.CURRENT);
                ContentValues map = new ContentValues();
                map.put(Carriers.NUMERIC, operatorNumeric);
                this.mContext.getContentResolver().insert(uri, map);
                return LOCAL_DEBUG;
            } catch (SQLException e) {
                Rlog.e(LOG_TAG, "Can't store current operator", e);
            }
        }
        return VDBG;
    }

    public void saveClirSetting(int commandInterfaceCLIRMode) {
        Editor editor = PreferenceManager.getDefaultSharedPreferences(getContext()).edit();
        editor.putInt(PhoneBase.CLIR_KEY + getPhoneId(), commandInterfaceCLIRMode);
        if (!editor.commit()) {
            Rlog.e(LOG_TAG, "failed to commit CLIR preference");
        }
    }

    private void handleCfuQueryResult(CallForwardInfo[] infos) {
        boolean z = VDBG;
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r == null) {
            return;
        }
        if (infos == null || infos.length == 0) {
            r.setVoiceCallForwardingFlag(1, VDBG, null);
            return;
        }
        int s = infos.length;
        for (int i = 0; i < s; i++) {
            if ((infos[i].serviceClass & 1) != 0) {
                if (infos[i].status == 1) {
                    z = LOCAL_DEBUG;
                }
                r.setVoiceCallForwardingFlag(1, z, infos[i].number);
                return;
            }
        }
    }

    public PhoneSubInfo getPhoneSubInfo() {
        return this.mSubInfo;
    }

    public IccPhoneBookInterfaceManager getIccPhoneBookInterfaceManager() {
        return this.mSimPhoneBookIntManager;
    }

    public void activateCellBroadcastSms(int activate, Message response) {
        Rlog.e(LOG_TAG, "[GSMPhone] activateCellBroadcastSms() is obsolete; use SmsManager");
        response.sendToTarget();
    }

    public void getCellBroadcastSmsConfig(Message response) {
        Rlog.e(LOG_TAG, "[GSMPhone] getCellBroadcastSmsConfig() is obsolete; use SmsManager");
        response.sendToTarget();
    }

    public void setCellBroadcastSmsConfig(int[] configValuesArray, Message response) {
        Rlog.e(LOG_TAG, "[GSMPhone] setCellBroadcastSmsConfig() is obsolete; use SmsManager");
        response.sendToTarget();
    }

    public boolean isCspPlmnEnabled() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        return r != null ? r.isCspPlmnEnabled() : VDBG;
    }

    boolean isManualNetSelAllowed() {
        int nwMode = Global.getInt(this.mContext.getContentResolver(), "preferred_network_mode" + getSubId(), Phone.PREFERRED_NT_MODE);
        Rlog.d(LOG_TAG, "isManualNetSelAllowed in mode = " + nwMode);
        if (isManualSelProhibitedInGlobalMode() && (nwMode == 10 || nwMode == 7)) {
            Rlog.d(LOG_TAG, "Manual selection not supported in mode = " + nwMode);
            return VDBG;
        }
        Rlog.d(LOG_TAG, "Manual selection is supported in mode = " + nwMode);
        return LOCAL_DEBUG;
    }

    private boolean isManualSelProhibitedInGlobalMode() {
        boolean isProhibited = VDBG;
        String configString = getContext().getResources().getString(17039435);
        if (!TextUtils.isEmpty(configString)) {
            String[] configArray = configString.split(";");
            if (configArray != null && ((configArray.length == 1 && configArray[0].equalsIgnoreCase("true")) || (configArray.length == 2 && !TextUtils.isEmpty(configArray[1]) && configArray[0].equalsIgnoreCase("true") && configArray[1].equalsIgnoreCase(getGroupIdLevel1())))) {
                isProhibited = LOCAL_DEBUG;
            }
        }
        Rlog.d(LOG_TAG, "isManualNetSelAllowedInGlobal in current carrier is " + isProhibited);
        return isProhibited;
    }

    private void registerForSimRecordEvents() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null) {
            r.registerForNetworkSelectionModeAutomatic(this, 28, null);
            r.registerForRecordsEvents(this, 29, null);
            r.registerForRecordsLoaded(this, 3, null);
        }
    }

    private void unregisterForSimRecordEvents() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null) {
            r.unregisterForNetworkSelectionModeAutomatic(this);
            r.unregisterForRecordsEvents(this);
            r.unregisterForRecordsLoaded(this);
        }
    }

    public void exitEmergencyCallbackMode() {
        if (mImsPhone != null) {
            mImsPhone.exitEmergencyCallbackMode();
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("GSMPhone extends:");
        super.dump(fd, pw, args);
        pw.println(" mCT=" + this.mCT);
        pw.println(" mSST=" + this.mSST);
        pw.println(" mPendingMMIs=" + this.mPendingMMIs);
        pw.println(" mSimPhoneBookIntManager=" + this.mSimPhoneBookIntManager);
        pw.println(" mSubInfo=" + this.mSubInfo);
        pw.println(" mVmNumber=" + this.mVmNumber);
    }

    public boolean setOperatorBrandOverride(String brand) {
        boolean z = VDBG;
        if (this.mUiccController != null) {
            UiccCard card = this.mUiccController.getUiccCard(getPhoneId());
            if (card != null) {
                z = card.setOperatorBrandOverride(brand);
                if (z) {
                    IccRecords iccRecords = (IccRecords) this.mIccRecords.get();
                    if (iccRecords != null) {
                        TelephonyManager.from(this.mContext).setSimOperatorNameForPhone(getPhoneId(), iccRecords.getServiceProviderName());
                    }
                    if (this.mSST != null) {
                        this.mSST.pollState();
                    }
                }
            }
        }
        return z;
    }

    public String getOperatorNumeric() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null) {
            return r.getOperatorNumeric();
        }
        return null;
    }

    public void registerForAllDataDisconnected(Handler h, int what, Object obj) {
        ((DcTracker) this.mDcTracker).registerForAllDataDisconnected(h, what, obj);
    }

    public void unregisterForAllDataDisconnected(Handler h) {
        ((DcTracker) this.mDcTracker).unregisterForAllDataDisconnected(h);
    }

    public void setInternalDataEnabled(boolean enable, Message onCompleteMsg) {
        ((DcTracker) this.mDcTracker).setInternalDataEnabled(enable, onCompleteMsg);
    }

    public boolean setInternalDataEnabledFlag(boolean enable) {
        return ((DcTracker) this.mDcTracker).setInternalDataEnabledFlag(enable);
    }

    public void notifyEcbmTimerReset(Boolean flag) {
        this.mEcmTimerResetRegistrants.notifyResult(flag);
    }

    public void registerForEcmTimerReset(Handler h, int what, Object obj) {
        this.mEcmTimerResetRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForEcmTimerReset(Handler h) {
        this.mEcmTimerResetRegistrants.remove(h);
    }

    public void setVoiceMessageWaiting(int line, int countWaiting) {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null) {
            r.setVoiceMessageWaiting(line, countWaiting);
        } else {
            log("SIM Records not found, MWI not updated");
        }
    }

    protected void log(String s) {
        Rlog.d(LOG_TAG, "[GSMPhone] " + s);
    }
}
