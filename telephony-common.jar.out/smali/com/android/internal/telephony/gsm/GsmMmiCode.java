package com.android.internal.telephony.gsm;

import android.content.Context;
import android.content.res.Resources;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.text.BidiFormatter;
import android.text.SpannableStringBuilder;
import android.text.TextDirectionHeuristics;
import android.text.TextUtils;
import com.android.internal.telephony.CallForwardInfo;
import com.android.internal.telephony.CommandException;
import com.android.internal.telephony.CommandException.Error;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.MmiCode;
import com.android.internal.telephony.MmiCode.State;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.cdma.SignalToneUtil;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.gsm.SsData.RequestType;
import com.android.internal.telephony.gsm.SsData.ServiceType;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppState;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPart;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class GsmMmiCode extends Handler implements MmiCode {
    static final String ACTION_ACTIVATE = "*";
    static final String ACTION_DEACTIVATE = "#";
    static final String ACTION_ERASURE = "##";
    static final String ACTION_INTERROGATE = "*#";
    static final String ACTION_REGISTER = "**";
    static final char END_OF_USSD_COMMAND = '#';
    static final int EVENT_GET_CLIR_COMPLETE = 2;
    static final int EVENT_QUERY_CF_COMPLETE = 3;
    static final int EVENT_QUERY_COMPLETE = 5;
    static final int EVENT_SET_CFF_COMPLETE = 6;
    static final int EVENT_SET_COMPLETE = 1;
    static final int EVENT_USSD_CANCEL_COMPLETE = 7;
    static final int EVENT_USSD_COMPLETE = 4;
    static final String LOG_TAG = "GsmMmiCode";
    static final int MATCH_GROUP_ACTION = 2;
    static final int MATCH_GROUP_DIALING_NUMBER = 12;
    static final int MATCH_GROUP_POUND_STRING = 1;
    static final int MATCH_GROUP_PWD_CONFIRM = 11;
    static final int MATCH_GROUP_SERVICE_CODE = 3;
    static final int MATCH_GROUP_SIA = 5;
    static final int MATCH_GROUP_SIB = 7;
    static final int MATCH_GROUP_SIC = 9;
    static final int MAX_LENGTH_SHORT_CODE = 2;
    static final String SC_BAIC = "35";
    static final String SC_BAICr = "351";
    static final String SC_BAOC = "33";
    static final String SC_BAOIC = "331";
    static final String SC_BAOICxH = "332";
    static final String SC_BA_ALL = "330";
    static final String SC_BA_MO = "333";
    static final String SC_BA_MT = "353";
    static final String SC_CFB = "67";
    static final String SC_CFNR = "62";
    static final String SC_CFNRy = "61";
    static final String SC_CFU = "21";
    static final String SC_CF_All = "002";
    static final String SC_CF_All_Conditional = "004";
    static final String SC_CLIP = "30";
    static final String SC_CLIR = "31";
    static final String SC_PIN = "04";
    static final String SC_PIN2 = "042";
    static final String SC_PUK = "05";
    static final String SC_PUK2 = "052";
    static final String SC_PWD = "03";
    static final String SC_WAIT = "43";
    static Pattern sPatternSuppService;
    private static String[] sTwoDigitNumberPattern;
    String mAction;
    Context mContext;
    String mDialingNumber;
    IccRecords mIccRecords;
    private boolean mIsCallFwdReg;
    private boolean mIsPendingUSSD;
    private boolean mIsSsInfo;
    private boolean mIsUssdRequest;
    CharSequence mMessage;
    GSMPhone mPhone;
    String mPoundString;
    String mPwd;
    String mSc;
    String mSia;
    String mSib;
    String mSic;
    State mState;
    UiccCardApplication mUiccApplication;

    /* renamed from: com.android.internal.telephony.gsm.GsmMmiCode.1 */
    static /* synthetic */ class C00681 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$gsm$SsData$RequestType;
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType;

        static {
            $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType = new int[ServiceType.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_CFU.ordinal()] = GsmMmiCode.MATCH_GROUP_POUND_STRING;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_CF_BUSY.ordinal()] = GsmMmiCode.MAX_LENGTH_SHORT_CODE;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_CF_NO_REPLY.ordinal()] = GsmMmiCode.MATCH_GROUP_SERVICE_CODE;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_CF_NOT_REACHABLE.ordinal()] = GsmMmiCode.EVENT_USSD_COMPLETE;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_CF_ALL.ordinal()] = GsmMmiCode.MATCH_GROUP_SIA;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_CF_ALL_CONDITIONAL.ordinal()] = GsmMmiCode.EVENT_SET_CFF_COMPLETE;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_CLIP.ordinal()] = GsmMmiCode.MATCH_GROUP_SIB;
            } catch (NoSuchFieldError e7) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_CLIR.ordinal()] = 8;
            } catch (NoSuchFieldError e8) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_WAIT.ordinal()] = GsmMmiCode.MATCH_GROUP_SIC;
            } catch (NoSuchFieldError e9) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_BAOC.ordinal()] = 10;
            } catch (NoSuchFieldError e10) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_BAOIC.ordinal()] = GsmMmiCode.MATCH_GROUP_PWD_CONFIRM;
            } catch (NoSuchFieldError e11) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_BAOIC_EXC_HOME.ordinal()] = GsmMmiCode.MATCH_GROUP_DIALING_NUMBER;
            } catch (NoSuchFieldError e12) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_BAIC.ordinal()] = 13;
            } catch (NoSuchFieldError e13) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_BAIC_ROAMING.ordinal()] = 14;
            } catch (NoSuchFieldError e14) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_ALL_BARRING.ordinal()] = 15;
            } catch (NoSuchFieldError e15) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_OUTGOING_BARRING.ordinal()] = 16;
            } catch (NoSuchFieldError e16) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[ServiceType.SS_INCOMING_BARRING.ordinal()] = 17;
            } catch (NoSuchFieldError e17) {
            }
            $SwitchMap$com$android$internal$telephony$gsm$SsData$RequestType = new int[RequestType.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$RequestType[RequestType.SS_ACTIVATION.ordinal()] = GsmMmiCode.MATCH_GROUP_POUND_STRING;
            } catch (NoSuchFieldError e18) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$RequestType[RequestType.SS_DEACTIVATION.ordinal()] = GsmMmiCode.MAX_LENGTH_SHORT_CODE;
            } catch (NoSuchFieldError e19) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$RequestType[RequestType.SS_REGISTRATION.ordinal()] = GsmMmiCode.MATCH_GROUP_SERVICE_CODE;
            } catch (NoSuchFieldError e20) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$RequestType[RequestType.SS_ERASURE.ordinal()] = GsmMmiCode.EVENT_USSD_COMPLETE;
            } catch (NoSuchFieldError e21) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$gsm$SsData$RequestType[RequestType.SS_INTERROGATION.ordinal()] = GsmMmiCode.MATCH_GROUP_SIA;
            } catch (NoSuchFieldError e22) {
            }
        }
    }

    static {
        sPatternSuppService = Pattern.compile("((\\*|#|\\*#|\\*\\*|##)(\\d{2,3})(\\*([^*#]*)(\\*([^*#]*)(\\*([^*#]*)(\\*([^*#]*))?)?)?)?#)(.*)");
    }

    static GsmMmiCode newFromDialString(String dialString, GSMPhone phone, UiccCardApplication app) {
        Matcher m = sPatternSuppService.matcher(dialString);
        GsmMmiCode ret;
        if (m.matches()) {
            ret = new GsmMmiCode(phone, app);
            ret.mPoundString = makeEmptyNull(m.group(MATCH_GROUP_POUND_STRING));
            ret.mAction = makeEmptyNull(m.group(MAX_LENGTH_SHORT_CODE));
            ret.mSc = makeEmptyNull(m.group(MATCH_GROUP_SERVICE_CODE));
            ret.mSia = makeEmptyNull(m.group(MATCH_GROUP_SIA));
            ret.mSib = makeEmptyNull(m.group(MATCH_GROUP_SIB));
            ret.mSic = makeEmptyNull(m.group(MATCH_GROUP_SIC));
            ret.mPwd = makeEmptyNull(m.group(MATCH_GROUP_PWD_CONFIRM));
            ret.mDialingNumber = makeEmptyNull(m.group(MATCH_GROUP_DIALING_NUMBER));
            if (ret.mDialingNumber == null || !ret.mDialingNumber.endsWith(ACTION_DEACTIVATE) || !dialString.endsWith(ACTION_DEACTIVATE)) {
                return ret;
            }
            ret = new GsmMmiCode(phone, app);
            ret.mPoundString = dialString;
            return ret;
        } else if (dialString.endsWith(ACTION_DEACTIVATE)) {
            ret = new GsmMmiCode(phone, app);
            ret.mPoundString = dialString;
            return ret;
        } else if (isTwoDigitShortCode(phone.getContext(), dialString)) {
            return null;
        } else {
            if (!isShortCode(dialString, phone)) {
                return null;
            }
            ret = new GsmMmiCode(phone, app);
            ret.mDialingNumber = dialString;
            return ret;
        }
    }

    static GsmMmiCode newNetworkInitiatedUssd(String ussdMessage, boolean isUssdRequest, GSMPhone phone, UiccCardApplication app) {
        GsmMmiCode ret = new GsmMmiCode(phone, app);
        ret.mMessage = ussdMessage;
        ret.mIsUssdRequest = isUssdRequest;
        if (isUssdRequest) {
            ret.mIsPendingUSSD = true;
            ret.mState = State.PENDING;
        } else {
            ret.mState = State.COMPLETE;
        }
        return ret;
    }

    static GsmMmiCode newFromUssdUserInput(String ussdMessge, GSMPhone phone, UiccCardApplication app) {
        GsmMmiCode ret = new GsmMmiCode(phone, app);
        ret.mMessage = ussdMessge;
        ret.mState = State.PENDING;
        ret.mIsPendingUSSD = true;
        return ret;
    }

    void processSsData(AsyncResult data) {
        Rlog.d(LOG_TAG, "In processSsData");
        this.mIsSsInfo = true;
        try {
            parseSsData(data.result);
        } catch (ClassCastException ex) {
            Rlog.e(LOG_TAG, "Class Cast Exception in parsing SS Data : " + ex);
        } catch (NullPointerException ex2) {
            Rlog.e(LOG_TAG, "Null Pointer Exception in parsing SS Data : " + ex2);
        }
    }

    void parseSsData(SsData ssData) {
        CommandException ex = CommandException.fromRilErrno(ssData.result);
        this.mSc = getScStringFromScType(ssData.serviceType);
        this.mAction = getActionStringFromReqType(ssData.requestType);
        Rlog.d(LOG_TAG, "parseSsData msc = " + this.mSc + ", action = " + this.mAction + ", ex = " + ex);
        switch (C00681.$SwitchMap$com$android$internal$telephony$gsm$SsData$RequestType[ssData.requestType.ordinal()]) {
            case MATCH_GROUP_POUND_STRING /*1*/:
            case MAX_LENGTH_SHORT_CODE /*2*/:
            case MATCH_GROUP_SERVICE_CODE /*3*/:
            case EVENT_USSD_COMPLETE /*4*/:
                if (ssData.result == 0 && ssData.serviceType.isTypeUnConditional()) {
                    boolean cffEnabled = (ssData.requestType == RequestType.SS_ACTIVATION || ssData.requestType == RequestType.SS_REGISTRATION) && isServiceClassVoiceorNone(ssData.serviceClass);
                    Rlog.d(LOG_TAG, "setVoiceCallForwardingFlag cffEnabled: " + cffEnabled);
                    if (this.mPhone.mIccRecords != null) {
                        this.mIccRecords.setVoiceCallForwardingFlag(MATCH_GROUP_POUND_STRING, cffEnabled, null);
                        Rlog.d(LOG_TAG, "setVoiceCallForwardingFlag done from SS Info.");
                    } else {
                        Rlog.e(LOG_TAG, "setVoiceCallForwardingFlag aborted. sim records is null.");
                    }
                }
                onSetComplete(null, new AsyncResult(null, ssData.cfInfo, ex));
            case MATCH_GROUP_SIA /*5*/:
                if (ssData.serviceType.isTypeClir()) {
                    Rlog.d(LOG_TAG, "CLIR INTERROGATION");
                    onGetClirComplete(new AsyncResult(null, ssData.ssInfo, ex));
                } else if (ssData.serviceType.isTypeCF()) {
                    Rlog.d(LOG_TAG, "CALL FORWARD INTERROGATION");
                    onQueryCfComplete(new AsyncResult(null, ssData.cfInfo, ex));
                } else {
                    onQueryComplete(new AsyncResult(null, ssData.ssInfo, ex));
                }
            default:
                Rlog.e(LOG_TAG, "Invaid requestType in SSData : " + ssData.requestType);
        }
    }

    private String getScStringFromScType(ServiceType sType) {
        switch (C00681.$SwitchMap$com$android$internal$telephony$gsm$SsData$ServiceType[sType.ordinal()]) {
            case MATCH_GROUP_POUND_STRING /*1*/:
                return SC_CFU;
            case MAX_LENGTH_SHORT_CODE /*2*/:
                return SC_CFB;
            case MATCH_GROUP_SERVICE_CODE /*3*/:
                return SC_CFNRy;
            case EVENT_USSD_COMPLETE /*4*/:
                return SC_CFNR;
            case MATCH_GROUP_SIA /*5*/:
                return SC_CF_All;
            case EVENT_SET_CFF_COMPLETE /*6*/:
                return SC_CF_All_Conditional;
            case MATCH_GROUP_SIB /*7*/:
                return SC_CLIP;
            case CharacterSets.ISO_8859_5 /*8*/:
                return SC_CLIR;
            case MATCH_GROUP_SIC /*9*/:
                return SC_WAIT;
            case CharacterSets.ISO_8859_7 /*10*/:
                return SC_BAOC;
            case MATCH_GROUP_PWD_CONFIRM /*11*/:
                return SC_BAOIC;
            case MATCH_GROUP_DIALING_NUMBER /*12*/:
                return SC_BAOICxH;
            case UserData.ASCII_CR_INDEX /*13*/:
                return SC_BAIC;
            case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                return SC_BAICr;
            case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                return SC_BA_ALL;
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
                return SC_BA_MO;
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
                return SC_BA_MT;
            default:
                return "";
        }
    }

    private String getActionStringFromReqType(RequestType rType) {
        switch (C00681.$SwitchMap$com$android$internal$telephony$gsm$SsData$RequestType[rType.ordinal()]) {
            case MATCH_GROUP_POUND_STRING /*1*/:
                return ACTION_ACTIVATE;
            case MAX_LENGTH_SHORT_CODE /*2*/:
                return ACTION_DEACTIVATE;
            case MATCH_GROUP_SERVICE_CODE /*3*/:
                return ACTION_REGISTER;
            case EVENT_USSD_COMPLETE /*4*/:
                return ACTION_ERASURE;
            case MATCH_GROUP_SIA /*5*/:
                return ACTION_INTERROGATE;
            default:
                return "";
        }
    }

    private boolean isServiceClassVoiceorNone(int serviceClass) {
        return (serviceClass & MATCH_GROUP_POUND_STRING) != 0 || serviceClass == 0;
    }

    private static String makeEmptyNull(String s) {
        if (s == null || s.length() != 0) {
            return s;
        }
        return null;
    }

    private static boolean isEmptyOrNull(CharSequence s) {
        return s == null || s.length() == 0;
    }

    private static int scToCallForwardReason(String sc) {
        if (sc == null) {
            throw new RuntimeException("invalid call forward sc");
        } else if (sc.equals(SC_CF_All)) {
            return EVENT_USSD_COMPLETE;
        } else {
            if (sc.equals(SC_CFU)) {
                return 0;
            }
            if (sc.equals(SC_CFB)) {
                return MATCH_GROUP_POUND_STRING;
            }
            if (sc.equals(SC_CFNR)) {
                return MATCH_GROUP_SERVICE_CODE;
            }
            if (sc.equals(SC_CFNRy)) {
                return MAX_LENGTH_SHORT_CODE;
            }
            if (sc.equals(SC_CF_All_Conditional)) {
                return MATCH_GROUP_SIA;
            }
            throw new RuntimeException("invalid call forward sc");
        }
    }

    private static int siToServiceClass(String si) {
        if (si == null || si.length() == 0) {
            return 0;
        }
        switch (Integer.parseInt(si, 10)) {
            case CharacterSets.ISO_8859_7 /*10*/:
                return 13;
            case MATCH_GROUP_PWD_CONFIRM /*11*/:
                return MATCH_GROUP_POUND_STRING;
            case MATCH_GROUP_DIALING_NUMBER /*12*/:
                return MATCH_GROUP_DIALING_NUMBER;
            case UserData.ASCII_CR_INDEX /*13*/:
                return EVENT_USSD_COMPLETE;
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
                return 8;
            case PduHeaders.MMS_VERSION_1_3 /*19*/:
                return MATCH_GROUP_SIA;
            case SmsHeader.ELT_ID_EXTENDED_OBJECT /*20*/:
                return 48;
            case SmsHeader.ELT_ID_REUSED_EXTENDED_OBJECT /*21*/:
                return PduHeaders.PREVIOUSLY_SENT_BY;
            case CallFailCause.NUMBER_CHANGED /*22*/:
                return 80;
            case SmsHeader.ELT_ID_STANDARD_WVG_OBJECT /*24*/:
                return 16;
            case SmsHeader.ELT_ID_CHARACTER_SIZE_WVG_OBJECT /*25*/:
                return 32;
            case SmsHeader.ELT_ID_EXTENDED_OBJECT_DATA_REQUEST_CMD /*26*/:
                return 17;
            case 99:
                return 64;
            default:
                throw new RuntimeException("unsupported MMI service code " + si);
        }
    }

    private static int siToTime(String si) {
        if (si == null || si.length() == 0) {
            return 0;
        }
        return Integer.parseInt(si, 10);
    }

    static boolean isServiceCodeCallForwarding(String sc) {
        return sc != null && (sc.equals(SC_CFU) || sc.equals(SC_CFB) || sc.equals(SC_CFNRy) || sc.equals(SC_CFNR) || sc.equals(SC_CF_All) || sc.equals(SC_CF_All_Conditional));
    }

    static boolean isServiceCodeCallBarring(String sc) {
        Resources resource = Resources.getSystem();
        if (sc != null) {
            String[] barringMMI = resource.getStringArray(17236022);
            if (barringMMI != null) {
                String[] arr$ = barringMMI;
                int len$ = arr$.length;
                for (int i$ = 0; i$ < len$; i$ += MATCH_GROUP_POUND_STRING) {
                    if (sc.equals(arr$[i$])) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    static String scToBarringFacility(String sc) {
        if (sc == null) {
            throw new RuntimeException("invalid call barring sc");
        } else if (sc.equals(SC_BAOC)) {
            return CommandsInterface.CB_FACILITY_BAOC;
        } else {
            if (sc.equals(SC_BAOIC)) {
                return CommandsInterface.CB_FACILITY_BAOIC;
            }
            if (sc.equals(SC_BAOICxH)) {
                return CommandsInterface.CB_FACILITY_BAOICxH;
            }
            if (sc.equals(SC_BAIC)) {
                return CommandsInterface.CB_FACILITY_BAIC;
            }
            if (sc.equals(SC_BAICr)) {
                return CommandsInterface.CB_FACILITY_BAICr;
            }
            if (sc.equals(SC_BA_ALL)) {
                return CommandsInterface.CB_FACILITY_BA_ALL;
            }
            if (sc.equals(SC_BA_MO)) {
                return CommandsInterface.CB_FACILITY_BA_MO;
            }
            if (sc.equals(SC_BA_MT)) {
                return CommandsInterface.CB_FACILITY_BA_MT;
            }
            throw new RuntimeException("invalid call barring sc");
        }
    }

    GsmMmiCode(GSMPhone phone, UiccCardApplication app) {
        super(phone.getHandler().getLooper());
        this.mState = State.PENDING;
        this.mIsSsInfo = false;
        this.mPhone = phone;
        this.mContext = phone.getContext();
        this.mUiccApplication = app;
        if (app != null) {
            this.mIccRecords = app.getIccRecords();
        }
    }

    public State getState() {
        return this.mState;
    }

    public CharSequence getMessage() {
        return this.mMessage;
    }

    public Phone getPhone() {
        return this.mPhone;
    }

    public void cancel() {
        if (this.mState != State.COMPLETE && this.mState != State.FAILED) {
            this.mState = State.CANCELLED;
            if (this.mIsPendingUSSD) {
                this.mPhone.mCi.cancelPendingUssd(obtainMessage(MATCH_GROUP_SIB, this));
            } else {
                this.mPhone.onMMIDone(this);
            }
        }
    }

    public boolean isCancelable() {
        return this.mIsPendingUSSD;
    }

    boolean isMMI() {
        return this.mPoundString != null;
    }

    boolean isShortCode() {
        return this.mPoundString == null && this.mDialingNumber != null && this.mDialingNumber.length() <= MAX_LENGTH_SHORT_CODE;
    }

    private static boolean isTwoDigitShortCode(Context context, String dialString) {
        Rlog.d(LOG_TAG, "isTwoDigitShortCode");
        if (dialString == null || dialString.length() > MAX_LENGTH_SHORT_CODE) {
            return false;
        }
        if (sTwoDigitNumberPattern == null) {
            sTwoDigitNumberPattern = context.getResources().getStringArray(17236010);
        }
        String[] arr$ = sTwoDigitNumberPattern;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += MATCH_GROUP_POUND_STRING) {
            String dialnumber = arr$[i$];
            Rlog.d(LOG_TAG, "Two Digit Number Pattern " + dialnumber);
            if (dialString.equals(dialnumber)) {
                Rlog.d(LOG_TAG, "Two Digit Number Pattern -true");
                return true;
            }
        }
        Rlog.d(LOG_TAG, "Two Digit Number Pattern -false");
        return false;
    }

    private static boolean isShortCode(String dialString, GSMPhone phone) {
        if (dialString == null || dialString.length() == 0 || PhoneNumberUtils.isLocalEmergencyNumber(phone.getContext(), dialString)) {
            return false;
        }
        return isShortCodeUSSD(dialString, phone);
    }

    private static boolean isShortCodeUSSD(String dialString, GSMPhone phone) {
        if (dialString == null || dialString.length() > MAX_LENGTH_SHORT_CODE || (!phone.isInCall() && dialString.length() == MAX_LENGTH_SHORT_CODE && dialString.charAt(0) == '1')) {
            return false;
        }
        return true;
    }

    boolean isPinPukCommand() {
        return this.mSc != null && (this.mSc.equals(SC_PIN) || this.mSc.equals(SC_PIN2) || this.mSc.equals(SC_PUK) || this.mSc.equals(SC_PUK2));
    }

    boolean isTemporaryModeCLIR() {
        return this.mSc != null && this.mSc.equals(SC_CLIR) && this.mDialingNumber != null && (isActivate() || isDeactivate());
    }

    int getCLIRMode() {
        if (this.mSc != null && this.mSc.equals(SC_CLIR)) {
            if (isActivate()) {
                return MAX_LENGTH_SHORT_CODE;
            }
            if (isDeactivate()) {
                return MATCH_GROUP_POUND_STRING;
            }
        }
        return 0;
    }

    boolean isActivate() {
        return this.mAction != null && this.mAction.equals(ACTION_ACTIVATE);
    }

    boolean isDeactivate() {
        return this.mAction != null && this.mAction.equals(ACTION_DEACTIVATE);
    }

    boolean isInterrogate() {
        return this.mAction != null && this.mAction.equals(ACTION_INTERROGATE);
    }

    boolean isRegister() {
        return this.mAction != null && this.mAction.equals(ACTION_REGISTER);
    }

    boolean isErasure() {
        return this.mAction != null && this.mAction.equals(ACTION_ERASURE);
    }

    public boolean isPendingUSSD() {
        return this.mIsPendingUSSD;
    }

    public boolean isUssdRequest() {
        return this.mIsUssdRequest;
    }

    public boolean isSsInfo() {
        return this.mIsSsInfo;
    }

    void processCode() {
        try {
            if (isShortCode()) {
                Rlog.d(LOG_TAG, "isShortCode");
                sendUssd(this.mDialingNumber);
            } else if (this.mDialingNumber != null) {
                throw new RuntimeException("Invalid or Unsupported MMI Code");
            } else if (this.mSc != null && this.mSc.equals(SC_CLIP)) {
                Rlog.d(LOG_TAG, "is CLIP");
                if (isInterrogate()) {
                    this.mPhone.mCi.queryCLIP(obtainMessage(MATCH_GROUP_SIA, this));
                    return;
                }
                throw new RuntimeException("Invalid or Unsupported MMI Code");
            } else if (this.mSc != null && this.mSc.equals(SC_CLIR)) {
                Rlog.d(LOG_TAG, "is CLIR");
                if (isActivate()) {
                    this.mPhone.mCi.setCLIR(MATCH_GROUP_POUND_STRING, obtainMessage(MATCH_GROUP_POUND_STRING, this));
                } else if (isDeactivate()) {
                    this.mPhone.mCi.setCLIR(MAX_LENGTH_SHORT_CODE, obtainMessage(MATCH_GROUP_POUND_STRING, this));
                } else if (isInterrogate()) {
                    this.mPhone.mCi.getCLIR(obtainMessage(MAX_LENGTH_SHORT_CODE, this));
                } else {
                    throw new RuntimeException("Invalid or Unsupported MMI Code");
                }
            } else if (isServiceCodeCallForwarding(this.mSc)) {
                Rlog.d(LOG_TAG, "is CF");
                String dialingNumber = this.mSia;
                serviceClass = siToServiceClass(this.mSib);
                int reason = scToCallForwardReason(this.mSc);
                int time = siToTime(this.mSic);
                if (isInterrogate()) {
                    this.mPhone.mCi.queryCallForwardStatus(reason, serviceClass, dialingNumber, obtainMessage(MATCH_GROUP_SERVICE_CODE, this));
                    return;
                }
                int cfAction;
                if (isActivate()) {
                    if (isEmptyOrNull(dialingNumber)) {
                        cfAction = MATCH_GROUP_POUND_STRING;
                        this.mIsCallFwdReg = false;
                    } else {
                        cfAction = MATCH_GROUP_SERVICE_CODE;
                        this.mIsCallFwdReg = true;
                    }
                } else if (isDeactivate()) {
                    cfAction = 0;
                } else if (isRegister()) {
                    cfAction = MATCH_GROUP_SERVICE_CODE;
                } else if (isErasure()) {
                    cfAction = EVENT_USSD_COMPLETE;
                } else {
                    throw new RuntimeException("invalid action");
                }
                int isSettingUnconditionalVoice = ((reason == 0 || reason == EVENT_USSD_COMPLETE) && ((serviceClass & MATCH_GROUP_POUND_STRING) != 0 || serviceClass == 0)) ? MATCH_GROUP_POUND_STRING : 0;
                int isEnableDesired = (cfAction == MATCH_GROUP_POUND_STRING || cfAction == MATCH_GROUP_SERVICE_CODE) ? MATCH_GROUP_POUND_STRING : 0;
                Rlog.d(LOG_TAG, "is CF setCallForward");
                this.mPhone.mCi.setCallForward(cfAction, reason, serviceClass, dialingNumber, time, obtainMessage(EVENT_SET_CFF_COMPLETE, isSettingUnconditionalVoice, isEnableDesired, this));
            } else if (isServiceCodeCallBarring(this.mSc)) {
                String password = this.mSia;
                serviceClass = siToServiceClass(this.mSib);
                facility = scToBarringFacility(this.mSc);
                if (isInterrogate()) {
                    this.mPhone.mCi.queryFacilityLock(facility, password, serviceClass, obtainMessage(MATCH_GROUP_SIA, this));
                } else if (isActivate() || isDeactivate()) {
                    this.mPhone.mCi.setFacilityLock(facility, isActivate(), password, serviceClass, obtainMessage(MATCH_GROUP_POUND_STRING, this));
                } else {
                    throw new RuntimeException("Invalid or Unsupported MMI Code");
                }
            } else if (this.mSc != null && this.mSc.equals(SC_PWD)) {
                String oldPwd = this.mSib;
                String newPwd = this.mSic;
                if (isActivate() || isRegister()) {
                    this.mAction = ACTION_REGISTER;
                    if (this.mSia == null) {
                        facility = CommandsInterface.CB_FACILITY_BA_ALL;
                    } else {
                        facility = scToBarringFacility(this.mSia);
                    }
                    if (newPwd.equals(this.mPwd)) {
                        this.mPhone.mCi.changeBarringPassword(facility, oldPwd, newPwd, obtainMessage(MATCH_GROUP_POUND_STRING, this));
                        return;
                    } else {
                        handlePasswordError(17039503);
                        return;
                    }
                }
                throw new RuntimeException("Invalid or Unsupported MMI Code");
            } else if (this.mSc != null && this.mSc.equals(SC_WAIT)) {
                serviceClass = siToServiceClass(this.mSia);
                if (isActivate() || isDeactivate()) {
                    this.mPhone.mCi.setCallWaiting(isActivate(), serviceClass, obtainMessage(MATCH_GROUP_POUND_STRING, this));
                } else if (isInterrogate()) {
                    this.mPhone.mCi.queryCallWaiting(serviceClass, obtainMessage(MATCH_GROUP_SIA, this));
                } else {
                    throw new RuntimeException("Invalid or Unsupported MMI Code");
                }
            } else if (isPinPukCommand()) {
                String oldPinOrPuk = this.mSia;
                String newPinOrPuk = this.mSib;
                int pinLen = newPinOrPuk.length();
                if (isRegister()) {
                    if (!newPinOrPuk.equals(this.mSic)) {
                        handlePasswordError(17039507);
                        return;
                    } else if (pinLen < EVENT_USSD_COMPLETE || pinLen > 8) {
                        handlePasswordError(17039508);
                        return;
                    } else if (this.mSc.equals(SC_PIN) && this.mUiccApplication != null && this.mUiccApplication.getState() == AppState.APPSTATE_PUK) {
                        handlePasswordError(17039510);
                        return;
                    } else if (this.mUiccApplication != null) {
                        Rlog.d(LOG_TAG, "process mmi service code using UiccApp sc=" + this.mSc);
                        if (this.mSc.equals(SC_PIN)) {
                            this.mUiccApplication.changeIccLockPassword(oldPinOrPuk, newPinOrPuk, obtainMessage(MATCH_GROUP_POUND_STRING, this));
                            return;
                        } else if (this.mSc.equals(SC_PIN2)) {
                            this.mUiccApplication.changeIccFdnPassword(oldPinOrPuk, newPinOrPuk, obtainMessage(MATCH_GROUP_POUND_STRING, this));
                            return;
                        } else if (this.mSc.equals(SC_PUK)) {
                            this.mUiccApplication.supplyPuk(oldPinOrPuk, newPinOrPuk, obtainMessage(MATCH_GROUP_POUND_STRING, this));
                            return;
                        } else if (this.mSc.equals(SC_PUK2)) {
                            this.mUiccApplication.supplyPuk2(oldPinOrPuk, newPinOrPuk, obtainMessage(MATCH_GROUP_POUND_STRING, this));
                            return;
                        } else {
                            throw new RuntimeException("uicc unsupported service code=" + this.mSc);
                        }
                    } else {
                        throw new RuntimeException("No application mUiccApplicaiton is null");
                    }
                }
                throw new RuntimeException("Ivalid register/action=" + this.mAction);
            } else if (this.mPoundString != null) {
                sendUssd(this.mPoundString);
            } else {
                throw new RuntimeException("Invalid or Unsupported MMI Code");
            }
        } catch (RuntimeException e) {
            this.mState = State.FAILED;
            this.mMessage = this.mContext.getText(17039496);
            this.mPhone.onMMIDone(this);
        }
    }

    private void handlePasswordError(int res) {
        this.mState = State.FAILED;
        StringBuilder sb = new StringBuilder(getScString());
        sb.append("\n");
        sb.append(this.mContext.getText(res));
        this.mMessage = sb;
        this.mPhone.onMMIDone(this);
    }

    void onUssdFinished(String ussdMessage, boolean isUssdRequest) {
        if (this.mState == State.PENDING) {
            if (ussdMessage == null) {
                this.mMessage = this.mContext.getText(17039504);
            } else {
                this.mMessage = ussdMessage;
            }
            this.mIsUssdRequest = isUssdRequest;
            if (!isUssdRequest) {
                this.mState = State.COMPLETE;
            }
            this.mPhone.onMMIDone(this);
        }
    }

    void onUssdFinishedError() {
        if (this.mState == State.PENDING) {
            this.mState = State.FAILED;
            this.mMessage = this.mContext.getText(17039496);
            this.mPhone.onMMIDone(this);
        }
    }

    void onUssdRelease() {
        if (this.mState == State.PENDING) {
            this.mState = State.COMPLETE;
            this.mMessage = null;
            this.mPhone.onMMIDone(this);
        }
    }

    void sendUssd(String ussdMessage) {
        this.mIsPendingUSSD = true;
        this.mPhone.mCi.sendUSSD(ussdMessage, obtainMessage(EVENT_USSD_COMPLETE, this));
    }

    public void handleMessage(Message msg) {
        AsyncResult ar;
        switch (msg.what) {
            case MATCH_GROUP_POUND_STRING /*1*/:
                onSetComplete(msg, (AsyncResult) msg.obj);
            case MAX_LENGTH_SHORT_CODE /*2*/:
                onGetClirComplete((AsyncResult) msg.obj);
            case MATCH_GROUP_SERVICE_CODE /*3*/:
                onQueryCfComplete((AsyncResult) msg.obj);
            case EVENT_USSD_COMPLETE /*4*/:
                ar = (AsyncResult) msg.obj;
                if (ar.exception != null) {
                    this.mState = State.FAILED;
                    this.mMessage = getErrorMessage(ar);
                    this.mPhone.onMMIDone(this);
                }
            case MATCH_GROUP_SIA /*5*/:
                onQueryComplete((AsyncResult) msg.obj);
            case EVENT_SET_CFF_COMPLETE /*6*/:
                ar = (AsyncResult) msg.obj;
                if (ar.exception == null && msg.arg1 == MATCH_GROUP_POUND_STRING) {
                    boolean cffEnabled = msg.arg2 == MATCH_GROUP_POUND_STRING;
                    if (this.mIccRecords != null) {
                        this.mIccRecords.setVoiceCallForwardingFlag(MATCH_GROUP_POUND_STRING, cffEnabled, this.mDialingNumber);
                    }
                }
                onSetComplete(msg, ar);
            case MATCH_GROUP_SIB /*7*/:
                this.mPhone.onMMIDone(this);
            default:
        }
    }

    private CharSequence getErrorMessage(AsyncResult ar) {
        if (ar.exception instanceof CommandException) {
            Error err = ((CommandException) ar.exception).getCommandError();
            if (err == Error.FDN_CHECK_FAILURE) {
                Rlog.i(LOG_TAG, "FDN_CHECK_FAILURE");
                return this.mContext.getText(17039497);
            } else if (err == Error.USSD_MODIFIED_TO_DIAL) {
                Rlog.i(LOG_TAG, "USSD_MODIFIED_TO_DIAL");
                return this.mContext.getText(17041065);
            } else if (err == Error.USSD_MODIFIED_TO_SS) {
                Rlog.i(LOG_TAG, "USSD_MODIFIED_TO_SS");
                return this.mContext.getText(17041066);
            } else if (err == Error.USSD_MODIFIED_TO_USSD) {
                Rlog.i(LOG_TAG, "USSD_MODIFIED_TO_USSD");
                return this.mContext.getText(17041067);
            } else if (err == Error.SS_MODIFIED_TO_DIAL) {
                Rlog.i(LOG_TAG, "SS_MODIFIED_TO_DIAL");
                return this.mContext.getText(17041068);
            } else if (err == Error.SS_MODIFIED_TO_USSD) {
                Rlog.i(LOG_TAG, "SS_MODIFIED_TO_USSD");
                return this.mContext.getText(17041069);
            } else if (err == Error.SS_MODIFIED_TO_SS) {
                Rlog.i(LOG_TAG, "SS_MODIFIED_TO_SS");
                return this.mContext.getText(17041070);
            }
        }
        return this.mContext.getText(17039496);
    }

    private CharSequence getScString() {
        if (this.mSc != null) {
            if (isServiceCodeCallBarring(this.mSc)) {
                return this.mContext.getText(17039521);
            }
            if (isServiceCodeCallForwarding(this.mSc)) {
                return this.mContext.getText(17039519);
            }
            if (this.mSc.equals(SC_CLIP)) {
                return this.mContext.getText(17039515);
            }
            if (this.mSc.equals(SC_CLIR)) {
                return this.mContext.getText(17039516);
            }
            if (this.mSc.equals(SC_PWD)) {
                return this.mContext.getText(17039522);
            }
            if (this.mSc.equals(SC_WAIT)) {
                return this.mContext.getText(17039520);
            }
            if (isPinPukCommand()) {
                return this.mContext.getText(17039523);
            }
        }
        return "";
    }

    private void onSetComplete(Message msg, AsyncResult ar) {
        StringBuilder sb = new StringBuilder(getScString());
        sb.append("\n");
        if (ar.exception != null) {
            this.mState = State.FAILED;
            if (ar.exception instanceof CommandException) {
                Error err = ((CommandException) ar.exception).getCommandError();
                if (err == Error.PASSWORD_INCORRECT) {
                    if (isPinPukCommand()) {
                        if (this.mSc.equals(SC_PUK) || this.mSc.equals(SC_PUK2)) {
                            sb.append(this.mContext.getText(17039506));
                        } else {
                            sb.append(this.mContext.getText(17039505));
                        }
                        int attemptsRemaining = msg.arg1;
                        if (attemptsRemaining <= 0) {
                            Rlog.d(LOG_TAG, "onSetComplete: PUK locked, cancel as lock screen will handle this");
                            this.mState = State.CANCELLED;
                        } else if (attemptsRemaining > 0) {
                            Rlog.d(LOG_TAG, "onSetComplete: attemptsRemaining=" + attemptsRemaining);
                            Resources resources = this.mContext.getResources();
                            Object[] objArr = new Object[MATCH_GROUP_POUND_STRING];
                            objArr[0] = Integer.valueOf(attemptsRemaining);
                            sb.append(resources.getQuantityString(18087936, attemptsRemaining, objArr));
                        }
                    } else {
                        sb.append(this.mContext.getText(17039503));
                    }
                } else if (err == Error.SIM_PUK2) {
                    sb.append(this.mContext.getText(17039505));
                    sb.append("\n");
                    sb.append(this.mContext.getText(17039511));
                } else if (err == Error.REQUEST_NOT_SUPPORTED) {
                    if (this.mSc.equals(SC_PIN)) {
                        sb.append(this.mContext.getText(17039512));
                    }
                } else if (err == Error.FDN_CHECK_FAILURE) {
                    Rlog.i(LOG_TAG, "FDN_CHECK_FAILURE");
                    sb.append(this.mContext.getText(17039497));
                } else {
                    sb.append(getErrorMessage(ar));
                }
            } else {
                sb.append(this.mContext.getText(17039496));
            }
        } else if (isActivate()) {
            this.mState = State.COMPLETE;
            if (this.mIsCallFwdReg) {
                sb.append(this.mContext.getText(17039501));
            } else {
                sb.append(this.mContext.getText(17039498));
            }
            if (this.mSc.equals(SC_CLIR)) {
                this.mPhone.saveClirSetting(MATCH_GROUP_POUND_STRING);
            }
        } else if (isDeactivate()) {
            this.mState = State.COMPLETE;
            sb.append(this.mContext.getText(17039500));
            if (this.mSc.equals(SC_CLIR)) {
                this.mPhone.saveClirSetting(MAX_LENGTH_SHORT_CODE);
            }
        } else if (isRegister()) {
            this.mState = State.COMPLETE;
            sb.append(this.mContext.getText(17039501));
        } else if (isErasure()) {
            this.mState = State.COMPLETE;
            sb.append(this.mContext.getText(17039502));
        } else {
            this.mState = State.FAILED;
            sb.append(this.mContext.getText(17039496));
        }
        this.mMessage = sb;
        this.mPhone.onMMIDone(this);
    }

    private void onGetClirComplete(AsyncResult ar) {
        StringBuilder sb = new StringBuilder(getScString());
        sb.append("\n");
        if (ar.exception == null) {
            int[] clirArgs = (int[]) ar.result;
            switch (clirArgs[MATCH_GROUP_POUND_STRING]) {
                case CharacterSets.ANY_CHARSET /*0*/:
                    sb.append(this.mContext.getText(17039534));
                    this.mState = State.COMPLETE;
                    break;
                case MATCH_GROUP_POUND_STRING /*1*/:
                    sb.append(this.mContext.getText(17039535));
                    this.mState = State.COMPLETE;
                    break;
                case MAX_LENGTH_SHORT_CODE /*2*/:
                    sb.append(this.mContext.getText(17039496));
                    this.mState = State.FAILED;
                    break;
                case MATCH_GROUP_SERVICE_CODE /*3*/:
                    switch (clirArgs[0]) {
                        case MATCH_GROUP_POUND_STRING /*1*/:
                            sb.append(this.mContext.getText(17039530));
                            break;
                        case MAX_LENGTH_SHORT_CODE /*2*/:
                            sb.append(this.mContext.getText(17039531));
                            break;
                        default:
                            sb.append(this.mContext.getText(17039530));
                            break;
                    }
                    this.mState = State.COMPLETE;
                    break;
                case EVENT_USSD_COMPLETE /*4*/:
                    switch (clirArgs[0]) {
                        case MATCH_GROUP_POUND_STRING /*1*/:
                            sb.append(this.mContext.getText(17039532));
                            break;
                        case MAX_LENGTH_SHORT_CODE /*2*/:
                            sb.append(this.mContext.getText(17039533));
                            break;
                        default:
                            sb.append(this.mContext.getText(17039533));
                            break;
                    }
                    this.mState = State.COMPLETE;
                    break;
                default:
                    break;
            }
        }
        this.mState = State.FAILED;
        sb.append(getErrorMessage(ar));
        this.mMessage = sb;
        this.mPhone.onMMIDone(this);
    }

    private CharSequence serviceClassToCFString(int serviceClass) {
        switch (serviceClass) {
            case MATCH_GROUP_POUND_STRING /*1*/:
                return this.mContext.getText(17039549);
            case MAX_LENGTH_SHORT_CODE /*2*/:
                return this.mContext.getText(17039550);
            case EVENT_USSD_COMPLETE /*4*/:
                return this.mContext.getText(17039551);
            case CharacterSets.ISO_8859_5 /*8*/:
                return this.mContext.getText(17039552);
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
                return this.mContext.getText(17039554);
            case UserData.PRINTABLE_ASCII_MIN_INDEX /*32*/:
                return this.mContext.getText(17039553);
            case CommandsInterface.SERVICE_CLASS_PACKET /*64*/:
                return this.mContext.getText(17039555);
            case PduPart.P_Q /*128*/:
                return this.mContext.getText(17039556);
            default:
                return null;
        }
    }

    private CharSequence makeCFQueryResultMessage(CallForwardInfo info, int serviceClassMask) {
        boolean needTimeTemplate;
        CharSequence template;
        String[] sources = new String[MATCH_GROUP_SERVICE_CODE];
        sources[0] = "{0}";
        sources[MATCH_GROUP_POUND_STRING] = "{1}";
        sources[MAX_LENGTH_SHORT_CODE] = "{2}";
        CharSequence[] destinations = new CharSequence[MATCH_GROUP_SERVICE_CODE];
        if (info.reason == MAX_LENGTH_SHORT_CODE) {
            needTimeTemplate = true;
        } else {
            needTimeTemplate = false;
        }
        if (info.status == MATCH_GROUP_POUND_STRING) {
            if (needTimeTemplate) {
                template = this.mContext.getText(17039573);
            } else {
                template = this.mContext.getText(17039572);
            }
        } else if (info.status == 0 && isEmptyOrNull(info.number)) {
            template = this.mContext.getText(17039571);
        } else if (needTimeTemplate) {
            template = this.mContext.getText(17039575);
        } else {
            template = this.mContext.getText(17039574);
        }
        destinations[0] = serviceClassToCFString(info.serviceClass & serviceClassMask);
        destinations[MATCH_GROUP_POUND_STRING] = formatLtr(PhoneNumberUtils.stringFromStringAndTOA(info.number, info.toa));
        destinations[MAX_LENGTH_SHORT_CODE] = Integer.toString(info.timeSeconds);
        if (info.reason == 0 && (info.serviceClass & serviceClassMask) == MATCH_GROUP_POUND_STRING) {
            boolean cffEnabled = info.status == MATCH_GROUP_POUND_STRING;
            if (this.mIccRecords != null) {
                this.mIccRecords.setVoiceCallForwardingFlag(MATCH_GROUP_POUND_STRING, cffEnabled, info.number);
            }
        }
        return TextUtils.replace(template, sources, destinations);
    }

    private String formatLtr(String str) {
        return str == null ? str : BidiFormatter.getInstance().unicodeWrap(str, TextDirectionHeuristics.LTR, true);
    }

    private void onQueryCfComplete(AsyncResult ar) {
        StringBuilder sb = new StringBuilder(getScString());
        sb.append("\n");
        if (ar.exception != null) {
            this.mState = State.FAILED;
            sb.append(getErrorMessage(ar));
        } else {
            CallForwardInfo[] infos = (CallForwardInfo[]) ar.result;
            if (infos.length == 0) {
                sb.append(this.mContext.getText(17039500));
                if (this.mIccRecords != null) {
                    this.mIccRecords.setVoiceCallForwardingFlag(MATCH_GROUP_POUND_STRING, false, null);
                }
            } else {
                SpannableStringBuilder tb = new SpannableStringBuilder();
                for (int serviceClassMask = MATCH_GROUP_POUND_STRING; serviceClassMask <= PduPart.P_Q; serviceClassMask <<= MATCH_GROUP_POUND_STRING) {
                    int s = infos.length;
                    for (int i = 0; i < s; i += MATCH_GROUP_POUND_STRING) {
                        if ((infos[i].serviceClass & serviceClassMask) != 0) {
                            tb.append(makeCFQueryResultMessage(infos[i], serviceClassMask));
                            tb.append("\n");
                        }
                    }
                }
                sb.append(tb);
            }
            this.mState = State.COMPLETE;
        }
        this.mMessage = sb;
        this.mPhone.onMMIDone(this);
    }

    private void onQueryComplete(AsyncResult ar) {
        StringBuilder sb = new StringBuilder(getScString());
        sb.append("\n");
        if (ar.exception != null) {
            this.mState = State.FAILED;
            sb.append(getErrorMessage(ar));
        } else {
            int[] ints = (int[]) ar.result;
            if (ints.length == 0) {
                sb.append(this.mContext.getText(17039496));
            } else if (ints[0] == 0) {
                sb.append(this.mContext.getText(17039500));
            } else if (this.mSc.equals(SC_WAIT)) {
                sb.append(createQueryCallWaitingResultMessage(ints[MATCH_GROUP_POUND_STRING]));
            } else if (isServiceCodeCallBarring(this.mSc)) {
                sb.append(createQueryCallBarringResultMessage(ints[0]));
            } else if (ints[0] == MATCH_GROUP_POUND_STRING) {
                sb.append(this.mContext.getText(17039498));
            } else {
                sb.append(this.mContext.getText(17039496));
            }
            this.mState = State.COMPLETE;
        }
        this.mMessage = sb;
        this.mPhone.onMMIDone(this);
    }

    private CharSequence createQueryCallWaitingResultMessage(int serviceClass) {
        StringBuilder sb = new StringBuilder(this.mContext.getText(17039499));
        for (int classMask = MATCH_GROUP_POUND_STRING; classMask <= PduPart.P_Q; classMask <<= MATCH_GROUP_POUND_STRING) {
            if ((classMask & serviceClass) != 0) {
                sb.append("\n");
                sb.append(serviceClassToCFString(classMask & serviceClass));
            }
        }
        return sb;
    }

    private CharSequence createQueryCallBarringResultMessage(int serviceClass) {
        StringBuilder sb = new StringBuilder(this.mContext.getText(17039499));
        for (int classMask = MATCH_GROUP_POUND_STRING; classMask <= PduPart.P_Q; classMask <<= MATCH_GROUP_POUND_STRING) {
            if ((classMask & serviceClass) != 0) {
                sb.append("\n");
                sb.append(serviceClassToCFString(classMask & serviceClass));
            }
        }
        return sb;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("GsmMmiCode {");
        sb.append("State=" + getState());
        if (this.mAction != null) {
            sb.append(" action=" + this.mAction);
        }
        if (this.mSc != null) {
            sb.append(" sc=" + this.mSc);
        }
        if (this.mSia != null) {
            sb.append(" sia=" + this.mSia);
        }
        if (this.mSib != null) {
            sb.append(" sib=" + this.mSib);
        }
        if (this.mSic != null) {
            sb.append(" sic=" + this.mSic);
        }
        if (this.mPoundString != null) {
            sb.append(" poundString=" + this.mPoundString);
        }
        if (this.mDialingNumber != null) {
            sb.append(" dialingNumber=" + this.mDialingNumber);
        }
        if (this.mPwd != null) {
            sb.append(" pwd=" + this.mPwd);
        }
        sb.append("}");
        return sb.toString();
    }
}
