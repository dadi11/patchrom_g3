package com.android.internal.telephony.cdma;

import android.app.ActivityManagerNative;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences.Editor;
import android.database.SQLException;
import android.net.Uri;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.Registrant;
import android.os.RegistrantList;
import android.os.SystemProperties;
import android.preference.PreferenceManager;
import android.provider.Settings.Secure;
import android.provider.Telephony.Carriers;
import android.telephony.CellLocation;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.telephony.cdma.CdmaCellLocation;
import android.text.TextUtils;
import android.util.Log;
import com.android.ims.ImsManager;
import com.android.internal.telephony.Call;
import com.android.internal.telephony.CallStateException;
import com.android.internal.telephony.CallTracker;
import com.android.internal.telephony.CommandException;
import com.android.internal.telephony.CommandException.Error;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.Connection;
import com.android.internal.telephony.DctConstants.Activity;
import com.android.internal.telephony.DctConstants.State;
import com.android.internal.telephony.IccPhoneBookInterfaceManager;
import com.android.internal.telephony.MccTable;
import com.android.internal.telephony.MmiCode;
import com.android.internal.telephony.Phone.DataActivityState;
import com.android.internal.telephony.PhoneBase;
import com.android.internal.telephony.PhoneConstants;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.android.internal.telephony.PhoneNotifier;
import com.android.internal.telephony.PhoneProxy;
import com.android.internal.telephony.PhoneSubInfo;
import com.android.internal.telephony.ServiceStateTracker;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.SubscriptionController;
import com.android.internal.telephony.UUSInfo;
import com.android.internal.telephony.dataconnection.DcTracker;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.imsphone.ImsPhone;
import com.android.internal.telephony.uicc.IccException;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.UiccCard;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CDMAPhone extends PhoneBase {
    static final int CANCEL_ECM_TIMER = 1;
    private static final boolean DBG = true;
    private static final int DEFAULT_ECM_EXIT_TIMER_VALUE = 300000;
    private static final int INVALID_SYSTEM_SELECTION_CODE = -1;
    private static final String IS683A_FEATURE_CODE = "*228";
    private static final int IS683A_FEATURE_CODE_NUM_DIGITS = 4;
    private static final int IS683A_SYS_SEL_CODE_NUM_DIGITS = 2;
    private static final int IS683A_SYS_SEL_CODE_OFFSET = 4;
    private static final int IS683_CONST_1900MHZ_A_BLOCK = 2;
    private static final int IS683_CONST_1900MHZ_B_BLOCK = 3;
    private static final int IS683_CONST_1900MHZ_C_BLOCK = 4;
    private static final int IS683_CONST_1900MHZ_D_BLOCK = 5;
    private static final int IS683_CONST_1900MHZ_E_BLOCK = 6;
    private static final int IS683_CONST_1900MHZ_F_BLOCK = 7;
    private static final int IS683_CONST_800MHZ_A_BAND = 0;
    private static final int IS683_CONST_800MHZ_B_BAND = 1;
    static final String LOG_TAG = "CDMAPhone";
    static String PROPERTY_CDMA_HOME_OPERATOR_NUMERIC = null;
    static final int RESTART_ECM_TIMER = 0;
    private static final boolean VDBG = false;
    private static final String VM_NUMBER_CDMA = "vm_number_key_cdma";
    private static Pattern pOtaSpNumSchema;
    CdmaCallTracker mCT;
    protected String mCarrierOtaSpNumSchema;
    CdmaSubscriptionSourceManager mCdmaSSM;
    int mCdmaSubscriptionSource;
    private Registrant mEcmExitRespRegistrant;
    private final RegistrantList mEcmTimerResetRegistrants;
    private final RegistrantList mEriFileLoadedRegistrants;
    EriManager mEriManager;
    private String mEsn;
    private Runnable mExitEcmRunnable;
    protected String mImei;
    protected String mImeiSv;
    protected boolean mIsPhoneInEcmState;
    private String mMeid;
    ArrayList<CdmaMmiCode> mPendingMmis;
    Registrant mPostDialHandler;
    RuimPhoneBookInterfaceManager mRuimPhoneBookInterfaceManager;
    CdmaServiceStateTracker mSST;
    PhoneSubInfo mSubInfo;
    private String mVmNumber;
    WakeLock mWakeLock;

    /* renamed from: com.android.internal.telephony.cdma.CDMAPhone.1 */
    class C00401 implements Runnable {
        C00401() {
        }

        public void run() {
            CDMAPhone.this.exitEmergencyCallbackMode();
        }
    }

    /* renamed from: com.android.internal.telephony.cdma.CDMAPhone.2 */
    static /* synthetic */ class C00412 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$DctConstants$Activity;
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$DctConstants$State;

        static {
            $SwitchMap$com$android$internal$telephony$DctConstants$State = new int[State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.RETRYING.ordinal()] = CDMAPhone.IS683_CONST_800MHZ_B_BAND;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.FAILED.ordinal()] = CDMAPhone.IS683_CONST_1900MHZ_A_BLOCK;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.IDLE.ordinal()] = CDMAPhone.IS683_CONST_1900MHZ_B_BLOCK;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.CONNECTED.ordinal()] = CDMAPhone.IS683_CONST_1900MHZ_C_BLOCK;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.DISCONNECTING.ordinal()] = CDMAPhone.IS683_CONST_1900MHZ_D_BLOCK;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.CONNECTING.ordinal()] = CDMAPhone.IS683_CONST_1900MHZ_E_BLOCK;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.SCANNING.ordinal()] = CDMAPhone.IS683_CONST_1900MHZ_F_BLOCK;
            } catch (NoSuchFieldError e7) {
            }
            $SwitchMap$com$android$internal$telephony$DctConstants$Activity = new int[Activity.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$Activity[Activity.DATAIN.ordinal()] = CDMAPhone.IS683_CONST_800MHZ_B_BAND;
            } catch (NoSuchFieldError e8) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$Activity[Activity.DATAOUT.ordinal()] = CDMAPhone.IS683_CONST_1900MHZ_A_BLOCK;
            } catch (NoSuchFieldError e9) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$Activity[Activity.DATAINANDOUT.ordinal()] = CDMAPhone.IS683_CONST_1900MHZ_B_BLOCK;
            } catch (NoSuchFieldError e10) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$Activity[Activity.DORMANT.ordinal()] = CDMAPhone.IS683_CONST_1900MHZ_C_BLOCK;
            } catch (NoSuchFieldError e11) {
            }
        }
    }

    static {
        PROPERTY_CDMA_HOME_OPERATOR_NUMERIC = "ro.cdma.home.operator.numeric";
        pOtaSpNumSchema = Pattern.compile("[,\\s]+");
    }

    public CDMAPhone(Context context, CommandsInterface ci, PhoneNotifier notifier, int phoneId) {
        super("CDMA", notifier, context, ci, VDBG, phoneId);
        this.mVmNumber = null;
        this.mPendingMmis = new ArrayList();
        this.mCdmaSubscriptionSource = INVALID_SYSTEM_SELECTION_CODE;
        this.mEriFileLoadedRegistrants = new RegistrantList();
        this.mEcmTimerResetRegistrants = new RegistrantList();
        this.mExitEcmRunnable = new C00401();
        initSstIcc();
        init(context, notifier);
    }

    protected void initSstIcc() {
        this.mSST = new CdmaServiceStateTracker(this);
    }

    protected void init(Context context, PhoneNotifier notifier) {
        this.mCi.setPhoneType(IS683_CONST_1900MHZ_A_BLOCK);
        this.mCT = new CdmaCallTracker(this);
        this.mCdmaSSM = CdmaSubscriptionSourceManager.getInstance(context, this.mCi, this, 27, null);
        this.mDcTracker = new DcTracker(this);
        this.mRuimPhoneBookInterfaceManager = new RuimPhoneBookInterfaceManager(this);
        this.mSubInfo = new PhoneSubInfo(this);
        this.mEriManager = new EriManager(this, context, RESTART_ECM_TIMER);
        this.mCi.registerForAvailable(this, IS683_CONST_800MHZ_B_BAND, null);
        this.mCi.registerForOffOrNotAvailable(this, 8, null);
        this.mCi.registerForOn(this, IS683_CONST_1900MHZ_D_BLOCK, null);
        this.mCi.setOnSuppServiceNotification(this, IS683_CONST_1900MHZ_A_BLOCK, null);
        this.mSST.registerForNetworkAttached(this, 19, null);
        this.mCi.setEmergencyCallbackMode(this, 25, null);
        this.mCi.registerForExitEmergencyCallbackMode(this, 26, null);
        this.mWakeLock = ((PowerManager) context.getSystemService("power")).newWakeLock(IS683_CONST_800MHZ_B_BAND, LOG_TAG);
        TelephonyManager tm = TelephonyManager.from(this.mContext);
        tm.setPhoneType(getPhoneId(), IS683_CONST_1900MHZ_A_BLOCK);
        this.mIsPhoneInEcmState = SystemProperties.get("ril.cdma.inecmmode", "false").equals("true");
        if (this.mIsPhoneInEcmState) {
            this.mCi.exitEmergencyCallbackMode(obtainMessage(26));
        }
        this.mCarrierOtaSpNumSchema = tm.getOtaSpNumberSchemaForPhone(getPhoneId(), "");
        String operatorAlpha = SystemProperties.get("ro.cdma.home.operator.alpha");
        String operatorNumeric = SystemProperties.get(PROPERTY_CDMA_HOME_OPERATOR_NUMERIC);
        log("init: operatorAlpha='" + operatorAlpha + "' operatorNumeric='" + operatorNumeric + "'");
        if (this.mUiccController.getUiccCardApplication(this.mPhoneId, IS683_CONST_800MHZ_B_BAND) == null) {
            log("init: APP_FAM_3GPP == NULL");
            if (!TextUtils.isEmpty(operatorAlpha)) {
                log("init: set 'gsm.sim.operator.alpha' to operator='" + operatorAlpha + "'");
                tm.setSimOperatorNameForPhone(this.mPhoneId, operatorAlpha);
            }
            if (!TextUtils.isEmpty(operatorNumeric)) {
                log("init: set 'gsm.sim.operator.numeric' to operator='" + operatorNumeric + "'");
                log("update icc_operator_numeric=" + operatorNumeric);
                tm.setSimOperatorNumericForPhone(this.mPhoneId, operatorNumeric);
                SubscriptionController.getInstance().setMccMnc(operatorNumeric, getSubId());
            }
            setIsoCountryProperty(operatorNumeric);
        }
        updateCurrentCarrierInProvider(operatorNumeric);
    }

    public void dispose() {
        synchronized (PhoneProxy.lockForRadioTechnologyChange) {
            super.dispose();
            log("dispose");
            unregisterForRuimRecordEvents();
            this.mCi.unregisterForAvailable(this);
            this.mCi.unregisterForOffOrNotAvailable(this);
            this.mCi.unregisterForOn(this);
            this.mSST.unregisterForNetworkAttached(this);
            this.mCi.unSetOnSuppServiceNotification(this);
            this.mCi.unregisterForExitEmergencyCallbackMode(this);
            removeCallbacks(this.mExitEcmRunnable);
            this.mPendingMmis.clear();
            this.mCT.dispose();
            this.mDcTracker.dispose();
            this.mSST.dispose();
            this.mCdmaSSM.dispose(this);
            this.mRuimPhoneBookInterfaceManager.dispose();
            this.mSubInfo.dispose();
            this.mEriManager.dispose();
        }
    }

    public void removeReferences() {
        log("removeReferences");
        this.mRuimPhoneBookInterfaceManager = null;
        this.mSubInfo = null;
        this.mCT = null;
        this.mSST = null;
        this.mEriManager = null;
        this.mExitEcmRunnable = null;
        super.removeReferences();
    }

    protected void finalize() {
        Rlog.d(LOG_TAG, "CDMAPhone finalized");
        if (this.mWakeLock.isHeld()) {
            Rlog.e(LOG_TAG, "UNEXPECTED; mWakeLock is held when finalizing.");
            this.mWakeLock.release();
        }
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

    public CallTracker getCallTracker() {
        return this.mCT;
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

    public ServiceStateTracker getServiceStateTracker() {
        return this.mSST;
    }

    public int getPhoneType() {
        return IS683_CONST_1900MHZ_A_BLOCK;
    }

    public boolean canTransfer() {
        Rlog.e(LOG_TAG, "canTransfer: not possible in CDMA");
        return VDBG;
    }

    public Call getRingingCall() {
        ImsPhone imPhone = mImsPhone;
        if (this.mCT.mRingingCall != null && this.mCT.mRingingCall.isRinging()) {
            return this.mCT.mRingingCall;
        }
        if (imPhone != null) {
            return imPhone.getRingingCall();
        }
        return this.mCT.mRingingCall;
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

    public void conference() {
        if (mImsPhone == null || !mImsPhone.canConference()) {
            Rlog.e(LOG_TAG, "conference: not possible in CDMA");
            return;
        }
        log("conference() - delegated to IMS phone");
        mImsPhone.conference();
    }

    public void enableEnhancedVoicePrivacy(boolean enable, Message onComplete) {
        this.mCi.setPreferredVoicePrivacy(enable, onComplete);
    }

    public void getEnhancedVoicePrivacy(Message onComplete) {
        this.mCi.getPreferredVoicePrivacy(onComplete);
    }

    public void clearDisconnected() {
        this.mCT.clearDisconnected();
    }

    public DataActivityState getDataActivityState() {
        DataActivityState ret = DataActivityState.NONE;
        if (this.mSST.getCurrentDataConnectionState() != 0) {
            return ret;
        }
        switch (C00412.$SwitchMap$com$android$internal$telephony$DctConstants$Activity[this.mDcTracker.getActivity().ordinal()]) {
            case IS683_CONST_800MHZ_B_BAND /*1*/:
                return DataActivityState.DATAIN;
            case IS683_CONST_1900MHZ_A_BLOCK /*2*/:
                return DataActivityState.DATAOUT;
            case IS683_CONST_1900MHZ_B_BLOCK /*3*/:
                return DataActivityState.DATAINANDOUT;
            case IS683_CONST_1900MHZ_C_BLOCK /*4*/:
                return DataActivityState.DORMANT;
            default:
                return DataActivityState.NONE;
        }
    }

    public Connection dial(String dialString, int videoState) throws CallStateException {
        Object valueOf;
        ImsPhone imsPhone = mImsPhone;
        boolean imsUseEnabled = (ImsManager.isVolteEnabledByPlatform(this.mContext) && ImsManager.isEnhanced4gLteModeSettingEnabledByUser(this.mContext) && ImsManager.isNonTtyOrTtyOnVolteEnabled(this.mContext)) ? DBG : VDBG;
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
        return dialInternal(dialString, null, videoState);
    }

    protected Connection dialInternal(String dialString, UUSInfo uusInfo, int videoState) throws CallStateException {
        return this.mCT.dial(PhoneNumberUtils.stripSeparators(dialString));
    }

    public Connection dial(String dialString, UUSInfo uusInfo, int videoState) throws CallStateException {
        throw new CallStateException("Sending UUS information NOT supported in CDMA!");
    }

    public List<? extends MmiCode> getPendingMmiCodes() {
        return this.mPendingMmis;
    }

    public void registerForSuppServiceNotification(Handler h, int what, Object obj) {
        Rlog.e(LOG_TAG, "method registerForSuppServiceNotification is NOT supported in CDMA!");
    }

    public CdmaCall getBackgroundCall() {
        return this.mCT.mBackgroundCall;
    }

    public boolean handleInCallMmiCommands(String dialString) {
        Rlog.e(LOG_TAG, "method handleInCallMmiCommands is NOT supported in CDMA!");
        return VDBG;
    }

    boolean isInCall() {
        return (getForegroundCall().getState().isAlive() || getBackgroundCall().getState().isAlive() || getRingingCall().getState().isAlive()) ? DBG : VDBG;
    }

    public void unregisterForSuppServiceNotification(Handler h) {
        Rlog.e(LOG_TAG, "method unregisterForSuppServiceNotification is NOT supported in CDMA!");
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

    public String getIccSerialNumber() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r == null) {
            r = this.mUiccController.getIccRecords(this.mPhoneId, IS683_CONST_800MHZ_B_BAND);
        }
        return r != null ? r.getIccId() : null;
    }

    public String getLine1Number() {
        return this.mSST.getMdnNumber();
    }

    public String getCdmaPrlVersion() {
        return this.mSST.getPrlVersion();
    }

    public String getCdmaMin() {
        return this.mSST.getCdmaMin();
    }

    public boolean isMinInfoReady() {
        return this.mSST.isMinInfoReady();
    }

    public void getCallWaiting(Message onComplete) {
        this.mCi.queryCallWaiting(IS683_CONST_800MHZ_B_BAND, onComplete);
    }

    public void setRadioPower(boolean power) {
        this.mSST.setRadioPower(power);
    }

    public String getEsn() {
        return this.mEsn;
    }

    public String getMeid() {
        return this.mMeid;
    }

    public String getNai() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (Log.isLoggable(LOG_TAG, IS683_CONST_1900MHZ_A_BLOCK)) {
            Rlog.v(LOG_TAG, "IccRecords is " + r);
        }
        return r != null ? r.getNAI() : null;
    }

    public String getDeviceId() {
        String id = getMeid();
        if (id != null && !id.matches("^0*$")) {
            return id;
        }
        Rlog.d(LOG_TAG, "getDeviceId(): MEID is not initialized use ESN");
        return getEsn();
    }

    public String getDeviceSvn() {
        Rlog.d(LOG_TAG, "getDeviceSvn(): return 0");
        return "0";
    }

    public String getSubscriberId() {
        return this.mSST.getImsi();
    }

    public String getGroupIdLevel1() {
        Rlog.e(LOG_TAG, "GID1 is not available in CDMA");
        return null;
    }

    public String getImei() {
        Rlog.e(LOG_TAG, "getImei() called for CDMAPhone");
        return this.mImei;
    }

    public boolean canConference() {
        if (mImsPhone != null && mImsPhone.canConference()) {
            return DBG;
        }
        Rlog.e(LOG_TAG, "canConference: not possible in CDMA");
        return VDBG;
    }

    public CellLocation getCellLocation() {
        CdmaCellLocation loc = this.mSST.mCellLoc;
        if (Secure.getInt(getContext().getContentResolver(), "location_mode", RESTART_ECM_TIMER) != 0) {
            return loc;
        }
        CdmaCellLocation privateLoc = new CdmaCellLocation();
        privateLoc.setCellLocationData(loc.getBaseStationId(), Integer.MAX_VALUE, Integer.MAX_VALUE, loc.getSystemId(), loc.getNetworkId());
        return privateLoc;
    }

    public CdmaCall getForegroundCall() {
        return this.mCT.mForegroundCall;
    }

    public void setOnPostDialCharacter(Handler h, int what, Object obj) {
        this.mPostDialHandler = new Registrant(h, what, obj);
    }

    public boolean handlePinMmi(String dialString) {
        CdmaMmiCode mmi = CdmaMmiCode.newFromDialString(dialString, this, (UiccCardApplication) this.mUiccApplication.get());
        if (mmi == null) {
            Rlog.e(LOG_TAG, "Mmi is NULL!");
            return VDBG;
        } else if (mmi.isPinPukCommand()) {
            this.mPendingMmis.add(mmi);
            this.mMmiRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
            mmi.processCode();
            return DBG;
        } else {
            Rlog.e(LOG_TAG, "Unrecognized mmi!");
            return VDBG;
        }
    }

    void onMMIDone(CdmaMmiCode mmi) {
        if (this.mPendingMmis.remove(mmi)) {
            this.mMmiCompleteRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
        }
    }

    public boolean setLine1Number(String alphaTag, String number, Message onComplete) {
        Rlog.e(LOG_TAG, "setLine1Number: not possible in CDMA");
        return VDBG;
    }

    public void setCallWaiting(boolean enable, Message onComplete) {
        Rlog.e(LOG_TAG, "method setCallWaiting is NOT supported in CDMA!");
    }

    public void updateServiceLocation() {
        this.mSST.enableSingleLocationUpdate();
    }

    public void setDataRoamingEnabled(boolean enable) {
        this.mDcTracker.setDataOnRoamingEnabled(enable);
    }

    public void registerForCdmaOtaStatusChange(Handler h, int what, Object obj) {
        this.mCi.registerForCdmaOtaProvision(h, what, obj);
    }

    public void unregisterForCdmaOtaStatusChange(Handler h) {
        this.mCi.unregisterForCdmaOtaProvision(h);
    }

    public void registerForSubscriptionInfoReady(Handler h, int what, Object obj) {
        this.mSST.registerForSubscriptionInfoReady(h, what, obj);
    }

    public void unregisterForSubscriptionInfoReady(Handler h) {
        this.mSST.unregisterForSubscriptionInfoReady(h);
    }

    public void setOnEcbModeExitResponse(Handler h, int what, Object obj) {
        this.mEcmExitRespRegistrant = new Registrant(h, what, obj);
    }

    public void unsetOnEcbModeExitResponse(Handler h) {
        this.mEcmExitRespRegistrant.clear();
    }

    public void registerForCallWaiting(Handler h, int what, Object obj) {
        this.mCT.registerForCallWaiting(h, what, obj);
    }

    public void unregisterForCallWaiting(Handler h) {
        this.mCT.unregisterForCallWaiting(h);
    }

    public void getNeighboringCids(Message response) {
        if (response != null) {
            AsyncResult.forMessage(response).exception = new CommandException(Error.REQUEST_NOT_SUPPORTED);
            response.sendToTarget();
        }
    }

    public DataState getDataConnectionState(String apnType) {
        DataState ret = DataState.DISCONNECTED;
        if (this.mSST != null) {
            if (this.mSST.getCurrentDataConnectionState() == 0) {
                if (this.mDcTracker.isApnTypeEnabled(apnType) && this.mDcTracker.isApnTypeActive(apnType)) {
                    switch (C00412.$SwitchMap$com$android$internal$telephony$DctConstants$State[this.mDcTracker.getState(apnType).ordinal()]) {
                        case IS683_CONST_800MHZ_B_BAND /*1*/:
                        case IS683_CONST_1900MHZ_A_BLOCK /*2*/:
                        case IS683_CONST_1900MHZ_B_BLOCK /*3*/:
                            ret = DataState.DISCONNECTED;
                            break;
                        case IS683_CONST_1900MHZ_C_BLOCK /*4*/:
                        case IS683_CONST_1900MHZ_D_BLOCK /*5*/:
                            if (this.mCT.mState != PhoneConstants.State.IDLE && !this.mSST.isConcurrentVoiceAndDataAllowed()) {
                                ret = DataState.SUSPENDED;
                                break;
                            }
                            ret = DataState.CONNECTED;
                            break;
                            break;
                        case IS683_CONST_1900MHZ_E_BLOCK /*6*/:
                        case IS683_CONST_1900MHZ_F_BLOCK /*7*/:
                            ret = DataState.CONNECTING;
                            break;
                        default:
                            break;
                    }
                }
                ret = DataState.DISCONNECTED;
            } else {
                ret = DataState.DISCONNECTED;
            }
        } else {
            ret = DataState.DISCONNECTED;
        }
        log("getDataConnectionState apnType=" + apnType + " ret=" + ret);
        return ret;
    }

    public void sendUssdResponse(String ussdMessge) {
        Rlog.e(LOG_TAG, "sendUssdResponse: not possible in CDMA");
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

    public void sendBurstDtmf(String dtmfString, int on, int off, Message onComplete) {
        boolean check = DBG;
        for (int itr = RESTART_ECM_TIMER; itr < dtmfString.length(); itr += IS683_CONST_800MHZ_B_BAND) {
            if (!PhoneNumberUtils.is12Key(dtmfString.charAt(itr))) {
                Rlog.e(LOG_TAG, "sendDtmf called with invalid character '" + dtmfString.charAt(itr) + "'");
                check = VDBG;
                break;
            }
        }
        if (this.mCT.mState == PhoneConstants.State.OFFHOOK && check) {
            this.mCi.sendBurstDtmf(dtmfString, on, off, onComplete);
        }
    }

    public void getAvailableNetworks(Message response) {
        Rlog.e(LOG_TAG, "getAvailableNetworks: not possible in CDMA");
    }

    public void setOutgoingCallerIdDisplay(int commandInterfaceCLIRMode, Message onComplete) {
        Rlog.e(LOG_TAG, "setOutgoingCallerIdDisplay: not possible in CDMA");
    }

    public void enableLocationUpdates() {
        this.mSST.enableLocationUpdates();
    }

    public void disableLocationUpdates() {
        this.mSST.disableLocationUpdates();
    }

    public void getDataCallList(Message response) {
        this.mCi.getDataCallList(response);
    }

    public boolean getDataRoamingEnabled() {
        return this.mDcTracker.getDataOnRoamingEnabled();
    }

    public void setDataEnabled(boolean enable) {
        this.mDcTracker.setDataEnabled(enable);
    }

    public boolean getDataEnabled() {
        return this.mDcTracker.getDataEnabled();
    }

    public void setVoiceMailNumber(String alphaTag, String voiceMailNumber, Message onComplete) {
        this.mVmNumber = voiceMailNumber;
        Message resp = obtainMessage(20, RESTART_ECM_TIMER, RESTART_ECM_TIMER, onComplete);
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null) {
            r.setVoiceMailNumber(alphaTag, this.mVmNumber, resp);
        }
    }

    public String getVoiceMailNumber() {
        String number = PreferenceManager.getDefaultSharedPreferences(getContext()).getString(VM_NUMBER_CDMA + getPhoneId(), null);
        if (TextUtils.isEmpty(number)) {
            String[] listArray = getContext().getResources().getStringArray(17236028);
            if (listArray != null && listArray.length > 0) {
                for (int i = RESTART_ECM_TIMER; i < listArray.length; i += IS683_CONST_800MHZ_B_BAND) {
                    if (!TextUtils.isEmpty(listArray[i])) {
                        String[] defaultVMNumberArray = listArray[i].split(";");
                        if (defaultVMNumberArray != null && defaultVMNumberArray.length > 0) {
                            if (defaultVMNumberArray.length != IS683_CONST_800MHZ_B_BAND) {
                                if (defaultVMNumberArray.length == IS683_CONST_1900MHZ_A_BLOCK && !TextUtils.isEmpty(defaultVMNumberArray[IS683_CONST_800MHZ_B_BAND]) && defaultVMNumberArray[IS683_CONST_800MHZ_B_BAND].equalsIgnoreCase(getGroupIdLevel1())) {
                                    number = defaultVMNumberArray[RESTART_ECM_TIMER];
                                    break;
                                }
                            }
                            number = defaultVMNumberArray[RESTART_ECM_TIMER];
                        }
                    }
                }
            }
        }
        if (!TextUtils.isEmpty(number)) {
            return number;
        }
        if (getContext().getResources().getBoolean(17956954)) {
            return getLine1Number();
        }
        return "*86";
    }

    private void updateVoiceMail() {
        setVoiceMessageCount(getStoredVoiceMessageCount());
    }

    public String getVoiceMailAlphaTag() {
        String ret = "";
        if (ret == null || ret.length() == 0) {
            return this.mContext.getText(17039364).toString();
        }
        return ret;
    }

    public void getCallForwardingOption(int commandInterfaceCFReason, Message onComplete) {
        Rlog.e(LOG_TAG, "getCallForwardingOption: not possible in CDMA");
    }

    public void setCallForwardingOption(int commandInterfaceCFAction, int commandInterfaceCFReason, String dialingNumber, int timerSeconds, Message onComplete) {
        Rlog.e(LOG_TAG, "setCallForwardingOption: not possible in CDMA");
    }

    public void getOutgoingCallerIdDisplay(Message onComplete) {
        Rlog.e(LOG_TAG, "getOutgoingCallerIdDisplay: not possible in CDMA");
    }

    public boolean getCallForwardingIndicator() {
        Rlog.e(LOG_TAG, "getCallForwardingIndicator: not possible in CDMA");
        return VDBG;
    }

    public void explicitCallTransfer() {
        Rlog.e(LOG_TAG, "explicitCallTransfer: not possible in CDMA");
    }

    public String getLine1AlphaTag() {
        Rlog.e(LOG_TAG, "getLine1AlphaTag: not possible in CDMA");
        return null;
    }

    void notifyPhoneStateChanged() {
        this.mNotifier.notifyPhoneState(this);
    }

    void notifyPreciseCallStateChanged() {
        super.notifyPreciseCallStateChangedP();
    }

    void notifyServiceStateChanged(ServiceState ss) {
        super.notifyServiceStateChangedP(ss);
    }

    void notifyLocationChanged() {
        this.mNotifier.notifyCellLocation(this);
    }

    public void notifyNewRingingConnection(Connection c) {
        super.notifyNewRingingConnectionP(c);
    }

    void notifyDisconnect(Connection cn) {
        this.mDisconnectRegistrants.notifyResult(cn);
        this.mNotifier.notifyDisconnectCause(cn.getDisconnectCause(), cn.getPreciseDisconnectCause());
    }

    void notifyUnknownConnection(Connection connection) {
        this.mUnknownConnectionRegistrants.notifyResult(connection);
    }

    public boolean isInEmergencyCall() {
        return this.mCT.isInEmergencyCall();
    }

    public boolean isInEcm() {
        return this.mIsPhoneInEcmState;
    }

    void sendEmergencyCallbackModeChange() {
        Intent intent = new Intent("android.intent.action.EMERGENCY_CALLBACK_MODE_CHANGED");
        intent.putExtra("phoneinECMState", this.mIsPhoneInEcmState);
        SubscriptionManager.putPhoneIdAndSubIdExtra(intent, getPhoneId());
        ActivityManagerNative.broadcastStickyIntent(intent, null, INVALID_SYSTEM_SELECTION_CODE);
        Rlog.d(LOG_TAG, "sendEmergencyCallbackModeChange");
    }

    public void exitEmergencyCallbackMode() {
        if (this.mWakeLock.isHeld()) {
            this.mWakeLock.release();
        }
        this.mCi.exitEmergencyCallbackMode(obtainMessage(26));
    }

    private void handleEnterEmergencyCallbackMode(Message msg) {
        Rlog.d(LOG_TAG, "handleEnterEmergencyCallbackMode,mIsPhoneInEcmState= " + this.mIsPhoneInEcmState);
        if (!this.mIsPhoneInEcmState) {
            this.mIsPhoneInEcmState = DBG;
            sendEmergencyCallbackModeChange();
            setSystemProperty("ril.cdma.inecmmode", "true");
            postDelayed(this.mExitEcmRunnable, SystemProperties.getLong("ro.cdma.ecmexittimer", 300000));
            this.mWakeLock.acquire();
        }
    }

    private void handleExitEmergencyCallbackMode(Message msg) {
        AsyncResult ar = msg.obj;
        Rlog.d(LOG_TAG, "handleExitEmergencyCallbackMode,ar.exception , mIsPhoneInEcmState " + ar.exception + this.mIsPhoneInEcmState);
        removeCallbacks(this.mExitEcmRunnable);
        if (this.mEcmExitRespRegistrant != null) {
            this.mEcmExitRespRegistrant.notifyRegistrant(ar);
        }
        if (ar.exception == null) {
            if (this.mIsPhoneInEcmState) {
                this.mIsPhoneInEcmState = VDBG;
                setSystemProperty("ril.cdma.inecmmode", "false");
            }
            sendEmergencyCallbackModeChange();
            this.mDcTracker.setInternalDataEnabled(DBG);
        }
    }

    void handleTimerInEmergencyCallbackMode(int action) {
        switch (action) {
            case RESTART_ECM_TIMER /*0*/:
                postDelayed(this.mExitEcmRunnable, SystemProperties.getLong("ro.cdma.ecmexittimer", 300000));
                this.mEcmTimerResetRegistrants.notifyResult(Boolean.FALSE);
            case IS683_CONST_800MHZ_B_BAND /*1*/:
                removeCallbacks(this.mExitEcmRunnable);
                this.mEcmTimerResetRegistrants.notifyResult(Boolean.TRUE);
            default:
                Rlog.e(LOG_TAG, "handleTimerInEmergencyCallbackMode, unsupported action " + action);
        }
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

    public void handleMessage(Message msg) {
        switch (msg.what) {
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
                super.handleMessage(msg);
            default:
                if (this.mIsTheCurrentActivePhone) {
                    AsyncResult ar;
                    switch (msg.what) {
                        case IS683_CONST_800MHZ_B_BAND /*1*/:
                            this.mCi.getBasebandVersion(obtainMessage(IS683_CONST_1900MHZ_E_BLOCK));
                            this.mCi.getDeviceIdentity(obtainMessage(21));
                            this.mCi.getRadioCapability(obtainMessage(35));
                            return;
                        case IS683_CONST_1900MHZ_A_BLOCK /*2*/:
                            Rlog.d(LOG_TAG, "Event EVENT_SSN Received");
                            return;
                        case IS683_CONST_1900MHZ_D_BLOCK /*5*/:
                            Rlog.d(LOG_TAG, "Event EVENT_RADIO_ON Received");
                            handleCdmaSubscriptionSource(this.mCdmaSSM.getCdmaSubscriptionSource());
                            return;
                        case IS683_CONST_1900MHZ_E_BLOCK /*6*/:
                            ar = msg.obj;
                            if (ar.exception == null) {
                                Rlog.d(LOG_TAG, "Baseband version: " + ar.result);
                                TelephonyManager.from(this.mContext).setBasebandVersionForPhone(getPhoneId(), (String) ar.result);
                                return;
                            }
                            return;
                        case CharacterSets.ISO_8859_5 /*8*/:
                            Rlog.d(LOG_TAG, "Event EVENT_RADIO_OFF_OR_NOT_AVAILABLE Received");
                            ImsPhone imsPhone = mImsPhone;
                            if (imsPhone != null) {
                                imsPhone.getServiceState().setStateOff();
                                return;
                            }
                            return;
                        case PduHeaders.MMS_VERSION_1_3 /*19*/:
                            Rlog.d(LOG_TAG, "Event EVENT_REGISTERED_TO_NETWORK Received");
                            return;
                        case SmsHeader.ELT_ID_EXTENDED_OBJECT /*20*/:
                            ar = (AsyncResult) msg.obj;
                            if (IccException.class.isInstance(ar.exception)) {
                                storeVoiceMailNumber(this.mVmNumber);
                                ar.exception = null;
                            }
                            Message onComplete = ar.userObj;
                            if (onComplete != null) {
                                AsyncResult.forMessage(onComplete, ar.result, ar.exception);
                                onComplete.sendToTarget();
                                return;
                            }
                            return;
                        case SmsHeader.ELT_ID_REUSED_EXTENDED_OBJECT /*21*/:
                            ar = (AsyncResult) msg.obj;
                            if (ar.exception == null) {
                                String[] respId = (String[]) ar.result;
                                this.mImei = respId[RESTART_ECM_TIMER];
                                this.mImeiSv = respId[IS683_CONST_800MHZ_B_BAND];
                                this.mEsn = respId[IS683_CONST_1900MHZ_A_BLOCK];
                                this.mMeid = respId[IS683_CONST_1900MHZ_B_BLOCK];
                                return;
                            }
                            return;
                        case CallFailCause.NUMBER_CHANGED /*22*/:
                            Rlog.d(LOG_TAG, "Event EVENT_RUIM_RECORDS_LOADED Received");
                            updateCurrentCarrierInProvider();
                            log("notifyMessageWaitingChanged");
                            this.mNotifier.notifyMessageWaitingChanged(this);
                            updateVoiceMail();
                            return;
                        case SmsHeader.ELT_ID_OBJECT_DISTR_INDICATOR /*23*/:
                            Rlog.d(LOG_TAG, "Event EVENT_NV_READY Received");
                            prepareEri();
                            log("notifyMessageWaitingChanged");
                            this.mNotifier.notifyMessageWaitingChanged(this);
                            updateVoiceMail();
                            return;
                        case SmsHeader.ELT_ID_CHARACTER_SIZE_WVG_OBJECT /*25*/:
                            handleEnterEmergencyCallbackMode(msg);
                            return;
                        case SmsHeader.ELT_ID_EXTENDED_OBJECT_DATA_REQUEST_CMD /*26*/:
                            handleExitEmergencyCallbackMode(msg);
                            return;
                        case 27:
                            Rlog.d(LOG_TAG, "EVENT_CDMA_SUBSCRIPTION_SOURCE_CHANGED");
                            handleCdmaSubscriptionSource(this.mCdmaSSM.getCdmaSubscriptionSource());
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
        return this.mUiccController.getUiccCardApplication(this.mPhoneId, IS683_CONST_1900MHZ_A_BLOCK);
    }

    protected void onUpdateIccAvailability() {
        if (this.mUiccController != null) {
            UiccCardApplication newUiccApplication = getUiccCardApplication();
            if (newUiccApplication == null) {
                log("can't find 3GPP2 application; trying APP_FAM_3GPP");
                newUiccApplication = this.mUiccController.getUiccCardApplication(this.mPhoneId, IS683_CONST_800MHZ_B_BAND);
            }
            UiccCardApplication app = (UiccCardApplication) this.mUiccApplication.get();
            if (app != newUiccApplication) {
                if (app != null) {
                    log("Removing stale icc objects.");
                    if (this.mIccRecords.get() != null) {
                        unregisterForRuimRecordEvents();
                    }
                    this.mIccRecords.set(null);
                    this.mUiccApplication.set(null);
                }
                if (newUiccApplication != null) {
                    log("New Uicc application found");
                    this.mUiccApplication.set(newUiccApplication);
                    this.mIccRecords.set(newUiccApplication.getIccRecords());
                    registerForRuimRecordEvents();
                }
            }
        }
    }

    private void handleCdmaSubscriptionSource(int newSubscriptionSource) {
        if (newSubscriptionSource != this.mCdmaSubscriptionSource) {
            this.mCdmaSubscriptionSource = newSubscriptionSource;
            if (newSubscriptionSource == IS683_CONST_800MHZ_B_BAND) {
                sendMessage(obtainMessage(23));
            }
        }
    }

    public PhoneSubInfo getPhoneSubInfo() {
        return this.mSubInfo;
    }

    public IccPhoneBookInterfaceManager getIccPhoneBookInterfaceManager() {
        return this.mRuimPhoneBookInterfaceManager;
    }

    public void registerForEriFileLoaded(Handler h, int what, Object obj) {
        this.mEriFileLoadedRegistrants.add(new Registrant(h, what, obj));
    }

    public void unregisterForEriFileLoaded(Handler h) {
        this.mEriFileLoadedRegistrants.remove(h);
    }

    public void setSystemProperty(String property, String value) {
        super.setSystemProperty(property, value);
    }

    public String getSystemProperty(String property, String defValue) {
        return super.getSystemProperty(property, defValue);
    }

    public void activateCellBroadcastSms(int activate, Message response) {
        Rlog.e(LOG_TAG, "[CDMAPhone] activateCellBroadcastSms() is obsolete; use SmsManager");
        response.sendToTarget();
    }

    public void getCellBroadcastSmsConfig(Message response) {
        Rlog.e(LOG_TAG, "[CDMAPhone] getCellBroadcastSmsConfig() is obsolete; use SmsManager");
        response.sendToTarget();
    }

    public void setCellBroadcastSmsConfig(int[] configValuesArray, Message response) {
        Rlog.e(LOG_TAG, "[CDMAPhone] setCellBroadcastSmsConfig() is obsolete; use SmsManager");
        response.sendToTarget();
    }

    public boolean needsOtaServiceProvisioning() {
        return this.mSST.getOtasp() != IS683_CONST_1900MHZ_B_BLOCK ? DBG : VDBG;
    }

    private static boolean isIs683OtaSpDialStr(String dialStr) {
        if (dialStr.length() != IS683_CONST_1900MHZ_C_BLOCK) {
            switch (extractSelCodeFromOtaSpNum(dialStr)) {
                case RESTART_ECM_TIMER /*0*/:
                case IS683_CONST_800MHZ_B_BAND /*1*/:
                case IS683_CONST_1900MHZ_A_BLOCK /*2*/:
                case IS683_CONST_1900MHZ_B_BLOCK /*3*/:
                case IS683_CONST_1900MHZ_C_BLOCK /*4*/:
                case IS683_CONST_1900MHZ_D_BLOCK /*5*/:
                case IS683_CONST_1900MHZ_E_BLOCK /*6*/:
                case IS683_CONST_1900MHZ_F_BLOCK /*7*/:
                    return DBG;
                default:
                    return VDBG;
            }
        } else if (dialStr.equals(IS683A_FEATURE_CODE)) {
            return DBG;
        } else {
            return VDBG;
        }
    }

    private static int extractSelCodeFromOtaSpNum(String dialStr) {
        int dialStrLen = dialStr.length();
        int sysSelCodeInt = INVALID_SYSTEM_SELECTION_CODE;
        if (dialStr.regionMatches(RESTART_ECM_TIMER, IS683A_FEATURE_CODE, RESTART_ECM_TIMER, IS683_CONST_1900MHZ_C_BLOCK) && dialStrLen >= IS683_CONST_1900MHZ_E_BLOCK) {
            sysSelCodeInt = Integer.parseInt(dialStr.substring(IS683_CONST_1900MHZ_C_BLOCK, IS683_CONST_1900MHZ_E_BLOCK));
        }
        Rlog.d(LOG_TAG, "extractSelCodeFromOtaSpNum " + sysSelCodeInt);
        return sysSelCodeInt;
    }

    private static boolean checkOtaSpNumBasedOnSysSelCode(int sysSelCodeInt, String[] sch) {
        try {
            int selRc = Integer.parseInt(sch[IS683_CONST_800MHZ_B_BAND]);
            int i = RESTART_ECM_TIMER;
            while (i < selRc) {
                if (!(TextUtils.isEmpty(sch[i + IS683_CONST_1900MHZ_A_BLOCK]) || TextUtils.isEmpty(sch[i + IS683_CONST_1900MHZ_B_BLOCK]))) {
                    int selMin = Integer.parseInt(sch[i + IS683_CONST_1900MHZ_A_BLOCK]);
                    int selMax = Integer.parseInt(sch[i + IS683_CONST_1900MHZ_B_BLOCK]);
                    if (sysSelCodeInt >= selMin && sysSelCodeInt <= selMax) {
                        return DBG;
                    }
                }
                i += IS683_CONST_800MHZ_B_BAND;
            }
            return VDBG;
        } catch (NumberFormatException ex) {
            Rlog.e(LOG_TAG, "checkOtaSpNumBasedOnSysSelCode, error", ex);
            return VDBG;
        }
    }

    private boolean isCarrierOtaSpNum(String dialStr) {
        boolean isOtaSpNum = VDBG;
        int sysSelCodeInt = extractSelCodeFromOtaSpNum(dialStr);
        if (sysSelCodeInt == INVALID_SYSTEM_SELECTION_CODE) {
            return RESTART_ECM_TIMER;
        }
        if (TextUtils.isEmpty(this.mCarrierOtaSpNumSchema)) {
            Rlog.d(LOG_TAG, "isCarrierOtaSpNum,ota schema pattern empty");
        } else {
            Matcher m = pOtaSpNumSchema.matcher(this.mCarrierOtaSpNumSchema);
            Rlog.d(LOG_TAG, "isCarrierOtaSpNum,schema" + this.mCarrierOtaSpNumSchema);
            if (m.find()) {
                String[] sch = pOtaSpNumSchema.split(this.mCarrierOtaSpNumSchema);
                if (TextUtils.isEmpty(sch[RESTART_ECM_TIMER]) || !sch[RESTART_ECM_TIMER].equals("SELC")) {
                    if (TextUtils.isEmpty(sch[RESTART_ECM_TIMER]) || !sch[RESTART_ECM_TIMER].equals("FC")) {
                        Rlog.d(LOG_TAG, "isCarrierOtaSpNum,ota schema not supported" + sch[RESTART_ECM_TIMER]);
                    } else {
                        if (dialStr.regionMatches(RESTART_ECM_TIMER, sch[IS683_CONST_1900MHZ_A_BLOCK], RESTART_ECM_TIMER, Integer.parseInt(sch[IS683_CONST_800MHZ_B_BAND]))) {
                            isOtaSpNum = DBG;
                        } else {
                            Rlog.d(LOG_TAG, "isCarrierOtaSpNum,not otasp number");
                        }
                    }
                } else if (sysSelCodeInt != INVALID_SYSTEM_SELECTION_CODE) {
                    isOtaSpNum = checkOtaSpNumBasedOnSysSelCode(sysSelCodeInt, sch);
                } else {
                    Rlog.d(LOG_TAG, "isCarrierOtaSpNum,sysSelCodeInt is invalid");
                }
            } else {
                Rlog.d(LOG_TAG, "isCarrierOtaSpNum,ota schema pattern not right" + this.mCarrierOtaSpNumSchema);
            }
        }
        return isOtaSpNum;
    }

    public boolean isOtaSpNumber(String dialStr) {
        boolean isOtaSpNum = VDBG;
        String dialableStr = PhoneNumberUtils.extractNetworkPortionAlt(dialStr);
        if (dialableStr != null) {
            isOtaSpNum = isIs683OtaSpDialStr(dialableStr);
            if (!isOtaSpNum) {
                isOtaSpNum = isCarrierOtaSpNum(dialableStr);
            }
        }
        Rlog.d(LOG_TAG, "isOtaSpNumber " + isOtaSpNum);
        return isOtaSpNum;
    }

    public int getCdmaEriIconIndex() {
        return getServiceState().getCdmaEriIconIndex();
    }

    public int getCdmaEriIconMode() {
        return getServiceState().getCdmaEriIconMode();
    }

    public String getCdmaEriText() {
        return this.mEriManager.getCdmaEriText(getServiceState().getCdmaRoamingIndicator(), getServiceState().getCdmaDefaultRoamingIndicator());
    }

    private void storeVoiceMailNumber(String number) {
        Editor editor = PreferenceManager.getDefaultSharedPreferences(getContext()).edit();
        editor.putString(VM_NUMBER_CDMA + getPhoneId(), number);
        editor.apply();
    }

    protected void setIsoCountryProperty(String operatorNumeric) {
        TelephonyManager tm = TelephonyManager.from(this.mContext);
        if (TextUtils.isEmpty(operatorNumeric)) {
            log("setIsoCountryProperty: clear 'gsm.sim.operator.iso-country'");
            tm.setSimCountryIsoForPhone(this.mPhoneId, "");
            return;
        }
        String iso = "";
        try {
            iso = MccTable.countryCodeForMcc(Integer.parseInt(operatorNumeric.substring(RESTART_ECM_TIMER, IS683_CONST_1900MHZ_B_BLOCK)));
        } catch (NumberFormatException ex) {
            loge("setIsoCountryProperty: countryCodeForMcc error", ex);
        } catch (StringIndexOutOfBoundsException ex2) {
            loge("setIsoCountryProperty: countryCodeForMcc error", ex2);
        }
        log("setIsoCountryProperty: set 'gsm.sim.operator.iso-country' to iso=" + iso);
        tm.setSimCountryIsoForPhone(this.mPhoneId, iso);
    }

    boolean updateCurrentCarrierInProvider(String operatorNumeric) {
        log("CDMAPhone: updateCurrentCarrierInProvider called");
        if (TextUtils.isEmpty(operatorNumeric)) {
            return VDBG;
        }
        try {
            Uri uri = Uri.withAppendedPath(Carriers.CONTENT_URI, Carriers.CURRENT);
            ContentValues map = new ContentValues();
            map.put(Carriers.NUMERIC, operatorNumeric);
            log("updateCurrentCarrierInProvider from system: numeric=" + operatorNumeric);
            getContext().getContentResolver().insert(uri, map);
            log("update mccmnc=" + operatorNumeric);
            MccTable.updateMccMncConfiguration(this.mContext, operatorNumeric, VDBG);
            return DBG;
        } catch (SQLException e) {
            Rlog.e(LOG_TAG, "Can't store current operator", e);
            return VDBG;
        }
    }

    boolean updateCurrentCarrierInProvider() {
        return DBG;
    }

    public void prepareEri() {
        if (this.mEriManager == null) {
            Rlog.e(LOG_TAG, "PrepareEri: Trying to access stale objects");
            return;
        }
        this.mEriManager.loadEriFile();
        if (this.mEriManager.isEriFileLoaded()) {
            log("ERI read, notify registrants");
            this.mEriFileLoadedRegistrants.notifyRegistrants();
        }
    }

    public boolean isEriFileLoaded() {
        return this.mEriManager.isEriFileLoaded();
    }

    protected void registerForRuimRecordEvents() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null) {
            r.registerForRecordsLoaded(this, 22, null);
        }
    }

    protected void unregisterForRuimRecordEvents() {
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null) {
            r.unregisterForRecordsLoaded(this);
        }
    }

    public void setVoiceMessageWaiting(int line, int countWaiting) {
        setVoiceMessageCount(countWaiting);
    }

    protected void log(String s) {
        Rlog.d(LOG_TAG, s);
    }

    protected void loge(String s, Exception e) {
        Rlog.e(LOG_TAG, s, e);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("CDMAPhone extends:");
        super.dump(fd, pw, args);
        pw.println(" mVmNumber=" + this.mVmNumber);
        pw.println(" mCT=" + this.mCT);
        pw.println(" mSST=" + this.mSST);
        pw.println(" mCdmaSSM=" + this.mCdmaSSM);
        pw.println(" mPendingMmis=" + this.mPendingMmis);
        pw.println(" mRuimPhoneBookInterfaceManager=" + this.mRuimPhoneBookInterfaceManager);
        pw.println(" mCdmaSubscriptionSource=" + this.mCdmaSubscriptionSource);
        pw.println(" mSubInfo=" + this.mSubInfo);
        pw.println(" mEriManager=" + this.mEriManager);
        pw.println(" mWakeLock=" + this.mWakeLock);
        pw.println(" mIsPhoneInEcmState=" + this.mIsPhoneInEcmState);
        pw.println(" mCarrierOtaSpNumSchema=" + this.mCarrierOtaSpNumSchema);
        pw.println(" getCdmaEriIconIndex()=" + getCdmaEriIconIndex());
        pw.println(" getCdmaEriIconMode()=" + getCdmaEriIconMode());
        pw.println(" getCdmaEriText()=" + getCdmaEriText());
        pw.println(" isMinInfoReady()=" + isMinInfoReady());
        pw.println(" isCspPlmnEnabled()=" + isCspPlmnEnabled());
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
                        TelephonyManager.from(this.mContext).setSimOperatorNameForPhone(this.mPhoneId, iccRecords.getServiceProviderName());
                    }
                    if (this.mSST != null) {
                        this.mSST.pollState();
                    }
                }
            }
        }
        return z;
    }
}
