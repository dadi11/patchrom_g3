package com.android.internal.telephony.imsphone;

import android.content.Context;
import android.content.res.Resources;
import android.os.AsyncResult;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.text.SpannableStringBuilder;
import android.text.TextUtils;
import com.android.ims.ImsException;
import com.android.ims.ImsSsInfo;
import com.android.internal.telephony.CallForwardInfo;
import com.android.internal.telephony.CallStateException;
import com.android.internal.telephony.CommandException;
import com.android.internal.telephony.CommandException.Error;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.MmiCode;
import com.android.internal.telephony.MmiCode.State;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.uicc.IccRecords;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPart;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class ImsPhoneMmiCode extends Handler implements MmiCode {
    private static final String ACTION_ACTIVATE = "*";
    private static final String ACTION_DEACTIVATE = "#";
    private static final String ACTION_ERASURE = "##";
    private static final String ACTION_INTERROGATE = "*#";
    private static final String ACTION_REGISTER = "**";
    private static final int CLIR_DEFAULT = 0;
    private static final int CLIR_INVOCATION = 1;
    private static final int CLIR_NOT_PROVISIONED = 0;
    private static final int CLIR_PRESENTATION_ALLOWED_TEMPORARY = 4;
    private static final int CLIR_PRESENTATION_RESTRICTED_TEMPORARY = 3;
    private static final int CLIR_PROVISIONED_PERMANENT = 1;
    private static final int CLIR_SUPPRESSION = 2;
    private static final char END_OF_USSD_COMMAND = '#';
    private static final int EVENT_GET_CLIR_COMPLETE = 6;
    private static final int EVENT_QUERY_CF_COMPLETE = 1;
    private static final int EVENT_QUERY_COMPLETE = 3;
    private static final int EVENT_SET_CFF_COMPLETE = 4;
    private static final int EVENT_SET_COMPLETE = 0;
    private static final int EVENT_SUPP_SVC_QUERY_COMPLETE = 7;
    private static final int EVENT_USSD_CANCEL_COMPLETE = 5;
    private static final int EVENT_USSD_COMPLETE = 2;
    static final String LOG_TAG = "ImsPhoneMmiCode";
    private static final int MATCH_GROUP_ACTION = 2;
    private static final int MATCH_GROUP_DIALING_NUMBER = 12;
    private static final int MATCH_GROUP_POUND_STRING = 1;
    private static final int MATCH_GROUP_PWD_CONFIRM = 11;
    private static final int MATCH_GROUP_SERVICE_CODE = 3;
    private static final int MATCH_GROUP_SIA = 5;
    private static final int MATCH_GROUP_SIB = 7;
    private static final int MATCH_GROUP_SIC = 9;
    private static final int MAX_LENGTH_SHORT_CODE = 2;
    private static final int NUM_PRESENTATION_ALLOWED = 0;
    private static final int NUM_PRESENTATION_RESTRICTED = 1;
    private static final String SC_BAIC = "35";
    private static final String SC_BAICa = "157";
    private static final String SC_BAICr = "351";
    private static final String SC_BAOC = "33";
    private static final String SC_BAOIC = "331";
    private static final String SC_BAOICxH = "332";
    private static final String SC_BA_ALL = "330";
    private static final String SC_BA_MO = "333";
    private static final String SC_BA_MT = "353";
    private static final String SC_BS_MT = "156";
    private static final String SC_CFB = "67";
    private static final String SC_CFNR = "62";
    private static final String SC_CFNRy = "61";
    private static final String SC_CFU = "21";
    private static final String SC_CF_All = "002";
    private static final String SC_CF_All_Conditional = "004";
    private static final String SC_CLIP = "30";
    private static final String SC_CLIR = "31";
    private static final String SC_CNAP = "300";
    private static final String SC_COLP = "76";
    private static final String SC_COLR = "77";
    private static final String SC_PIN = "04";
    private static final String SC_PIN2 = "042";
    private static final String SC_PUK = "05";
    private static final String SC_PUK2 = "052";
    private static final String SC_PWD = "03";
    private static final String SC_WAIT = "43";
    public static final String UT_BUNDLE_KEY_CLIR = "queryClir";
    public static final String UT_BUNDLE_KEY_SSINFO = "imsSsInfo";
    private static Pattern sPatternSuppService;
    private static String[] sTwoDigitNumberPattern;
    private String mAction;
    private Context mContext;
    private String mDialingNumber;
    private IccRecords mIccRecords;
    private boolean mIsCallFwdReg;
    private boolean mIsPendingUSSD;
    private boolean mIsUssdRequest;
    private CharSequence mMessage;
    private ImsPhone mPhone;
    private String mPoundString;
    private String mPwd;
    private String mSc;
    private String mSia;
    private String mSib;
    private String mSic;
    private State mState;

    static {
        sPatternSuppService = Pattern.compile("((\\*|#|\\*#|\\*\\*|##)(\\d{2,3})(\\*([^*#]*)(\\*([^*#]*)(\\*([^*#]*)(\\*([^*#]*))?)?)?)?#)(.*)");
    }

    static ImsPhoneMmiCode newFromDialString(String dialString, ImsPhone phone) {
        Matcher m = sPatternSuppService.matcher(dialString);
        ImsPhoneMmiCode ret;
        if (m.matches()) {
            ret = new ImsPhoneMmiCode(phone);
            ret.mPoundString = makeEmptyNull(m.group(NUM_PRESENTATION_RESTRICTED));
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
            ret = new ImsPhoneMmiCode(phone);
            ret.mPoundString = dialString;
            return ret;
        } else if (dialString.endsWith(ACTION_DEACTIVATE)) {
            ret = new ImsPhoneMmiCode(phone);
            ret.mPoundString = dialString;
            return ret;
        } else if (isTwoDigitShortCode(phone.getContext(), dialString)) {
            return null;
        } else {
            if (!isShortCode(dialString, phone)) {
                return null;
            }
            ret = new ImsPhoneMmiCode(phone);
            ret.mDialingNumber = dialString;
            return ret;
        }
    }

    static ImsPhoneMmiCode newNetworkInitiatedUssd(String ussdMessage, boolean isUssdRequest, ImsPhone phone) {
        ImsPhoneMmiCode ret = new ImsPhoneMmiCode(phone);
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

    static ImsPhoneMmiCode newFromUssdUserInput(String ussdMessge, ImsPhone phone) {
        ImsPhoneMmiCode ret = new ImsPhoneMmiCode(phone);
        ret.mMessage = ussdMessge;
        ret.mState = State.PENDING;
        ret.mIsPendingUSSD = true;
        return ret;
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
            return EVENT_SET_CFF_COMPLETE;
        } else {
            if (sc.equals(SC_CFU)) {
                return NUM_PRESENTATION_ALLOWED;
            }
            if (sc.equals(SC_CFB)) {
                return NUM_PRESENTATION_RESTRICTED;
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
            return NUM_PRESENTATION_ALLOWED;
        }
        switch (Integer.parseInt(si, 10)) {
            case CharacterSets.ISO_8859_7 /*10*/:
                return 13;
            case MATCH_GROUP_PWD_CONFIRM /*11*/:
                return NUM_PRESENTATION_RESTRICTED;
            case MATCH_GROUP_DIALING_NUMBER /*12*/:
                return MATCH_GROUP_DIALING_NUMBER;
            case UserData.ASCII_CR_INDEX /*13*/:
                return EVENT_SET_CFF_COMPLETE;
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
            return NUM_PRESENTATION_ALLOWED;
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
                for (int i$ = NUM_PRESENTATION_ALLOWED; i$ < len$; i$ += NUM_PRESENTATION_RESTRICTED) {
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

    ImsPhoneMmiCode(ImsPhone phone) {
        super(phone.getHandler().getLooper());
        this.mState = State.PENDING;
        this.mPhone = phone;
        this.mContext = phone.getContext();
        this.mIccRecords = (IccRecords) this.mPhone.mDefaultPhone.mIccRecords.get();
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
                this.mPhone.cancelUSSD();
            } else {
                this.mPhone.onMMIDone(this);
            }
        }
    }

    public boolean isCancelable() {
        return this.mIsPendingUSSD;
    }

    String getDialingNumber() {
        return this.mDialingNumber;
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
        for (int i$ = NUM_PRESENTATION_ALLOWED; i$ < len$; i$ += NUM_PRESENTATION_RESTRICTED) {
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

    private static boolean isShortCode(String dialString, ImsPhone phone) {
        if (dialString == null || dialString.length() == 0 || PhoneNumberUtils.isLocalEmergencyNumber(phone.getContext(), dialString)) {
            return false;
        }
        return isShortCodeUSSD(dialString, phone);
    }

    private static boolean isShortCodeUSSD(String dialString, ImsPhone phone) {
        if (dialString == null || dialString.length() > MAX_LENGTH_SHORT_CODE || (!phone.isInCall() && dialString.length() == MAX_LENGTH_SHORT_CODE && dialString.charAt(NUM_PRESENTATION_ALLOWED) == '1')) {
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
                return NUM_PRESENTATION_RESTRICTED;
            }
        }
        return NUM_PRESENTATION_ALLOWED;
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

    boolean isSupportedOverImsPhone() {
        if (isShortCode()) {
            return true;
        }
        if (this.mDialingNumber != null) {
            return false;
        }
        if (isServiceCodeCallForwarding(this.mSc) || isServiceCodeCallBarring(this.mSc) || ((this.mSc != null && this.mSc.equals(SC_WAIT)) || ((this.mSc != null && this.mSc.equals(SC_CLIR)) || ((this.mSc != null && this.mSc.equals(SC_CLIP)) || ((this.mSc != null && this.mSc.equals(SC_COLR)) || ((this.mSc != null && this.mSc.equals(SC_COLP)) || ((this.mSc != null && this.mSc.equals(SC_BS_MT)) || (this.mSc != null && this.mSc.equals(SC_BAICa))))))))) {
            int serviceClass = siToServiceClass(this.mSib);
            if (serviceClass == 0 || serviceClass == NUM_PRESENTATION_RESTRICTED) {
                return true;
            }
            return false;
        } else if (isPinPukCommand() || (this.mSc != null && (this.mSc.equals(SC_PWD) || this.mSc.equals(SC_CLIP) || this.mSc.equals(SC_CLIR)))) {
            return false;
        } else {
            if (this.mPoundString == null) {
                return false;
            }
            return true;
        }
    }

    void processCode() throws CallStateException {
        int isEnableDesired = NUM_PRESENTATION_ALLOWED;
        try {
            if (isShortCode()) {
                Rlog.d(LOG_TAG, "isShortCode");
                Rlog.d(LOG_TAG, "Sending short code '" + this.mDialingNumber + "' over CS pipe.");
                throw new CallStateException(ImsPhone.CS_FALLBACK);
            } else if (isServiceCodeCallForwarding(this.mSc)) {
                Rlog.d(LOG_TAG, "is CF");
                String dialingNumber = this.mSia;
                int reason = scToCallForwardReason(this.mSc);
                int time = siToTime(this.mSic);
                if (isInterrogate()) {
                    this.mPhone.getCallForwardingOption(reason, obtainMessage(NUM_PRESENTATION_RESTRICTED, this));
                    return;
                }
                int cfAction;
                int isSettingUnconditional;
                if (isActivate()) {
                    if (isEmptyOrNull(dialingNumber)) {
                        cfAction = NUM_PRESENTATION_RESTRICTED;
                        this.mIsCallFwdReg = false;
                    } else {
                        cfAction = MATCH_GROUP_SERVICE_CODE;
                        this.mIsCallFwdReg = true;
                    }
                } else if (isDeactivate()) {
                    cfAction = NUM_PRESENTATION_ALLOWED;
                } else if (isRegister()) {
                    cfAction = MATCH_GROUP_SERVICE_CODE;
                } else if (isErasure()) {
                    cfAction = EVENT_SET_CFF_COMPLETE;
                } else {
                    throw new RuntimeException("invalid action");
                }
                if (reason == 0 || reason == EVENT_SET_CFF_COMPLETE) {
                    isSettingUnconditional = NUM_PRESENTATION_RESTRICTED;
                } else {
                    isSettingUnconditional = NUM_PRESENTATION_ALLOWED;
                }
                if (cfAction == NUM_PRESENTATION_RESTRICTED || cfAction == MATCH_GROUP_SERVICE_CODE) {
                    isEnableDesired = NUM_PRESENTATION_RESTRICTED;
                }
                Rlog.d(LOG_TAG, "is CF setCallForward");
                this.mPhone.setCallForwardingOption(cfAction, reason, dialingNumber, time, obtainMessage(EVENT_SET_CFF_COMPLETE, isSettingUnconditional, isEnableDesired, this));
            } else if (isServiceCodeCallBarring(this.mSc)) {
                String password = this.mSia;
                String facility = scToBarringFacility(this.mSc);
                if (isInterrogate()) {
                    this.mPhone.getCallBarring(facility, obtainMessage(MATCH_GROUP_SIB, this));
                } else if (isActivate() || isDeactivate()) {
                    this.mPhone.setCallBarring(facility, isActivate(), password, obtainMessage(NUM_PRESENTATION_ALLOWED, this));
                } else {
                    throw new RuntimeException("Invalid or Unsupported MMI Code");
                }
            } else if (this.mSc == null || !this.mSc.equals(SC_CLIR)) {
                if (this.mSc == null || !this.mSc.equals(SC_CLIP)) {
                    if (this.mSc == null || !this.mSc.equals(SC_COLP)) {
                        if (this.mSc == null || !this.mSc.equals(SC_COLR)) {
                            if (this.mSc != null && this.mSc.equals(SC_BS_MT)) {
                                try {
                                    if (isInterrogate()) {
                                        this.mPhone.mCT.getUtInterface().queryCallBarring(10, obtainMessage(MATCH_GROUP_SIB, this));
                                    } else if (isActivate() || isDeactivate()) {
                                        processIcbMmiCodeForUpdate();
                                    }
                                } catch (ImsException e) {
                                    Rlog.d(LOG_TAG, "Could not get UT handle for ICB.");
                                }
                            } else if (this.mSc != null && this.mSc.equals(SC_BAICa)) {
                                try {
                                    if (isInterrogate()) {
                                        this.mPhone.mCT.getUtInterface().queryCallBarring(EVENT_GET_CLIR_COMPLETE, obtainMessage(MATCH_GROUP_SIB, this));
                                    }
                                } catch (ImsException e2) {
                                    Rlog.d(LOG_TAG, "Could not get UT handle for ICBa.");
                                }
                            } else if (this.mSc == null || !this.mSc.equals(SC_WAIT)) {
                                if (this.mPoundString != null) {
                                    Rlog.d(LOG_TAG, "Sending pound string '" + this.mDialingNumber + "' over CS pipe.");
                                    throw new CallStateException(ImsPhone.CS_FALLBACK);
                                }
                                throw new RuntimeException("Invalid or Unsupported MMI Code");
                            } else if (isActivate() || isDeactivate()) {
                                this.mPhone.setCallWaiting(isActivate(), obtainMessage(NUM_PRESENTATION_ALLOWED, this));
                            } else if (isInterrogate()) {
                                this.mPhone.getCallWaiting(obtainMessage(MATCH_GROUP_SERVICE_CODE, this));
                            } else {
                                throw new RuntimeException("Invalid or Unsupported MMI Code");
                            }
                        } else if (isActivate()) {
                            try {
                                this.mPhone.mCT.getUtInterface().updateCOLR(NUM_PRESENTATION_ALLOWED, obtainMessage(NUM_PRESENTATION_ALLOWED, this));
                            } catch (ImsException e3) {
                                Rlog.d(LOG_TAG, "Could not get UT handle for updateCOLR.");
                            }
                        } else if (isDeactivate()) {
                            try {
                                this.mPhone.mCT.getUtInterface().updateCOLR(NUM_PRESENTATION_RESTRICTED, obtainMessage(NUM_PRESENTATION_ALLOWED, this));
                            } catch (ImsException e4) {
                                Rlog.d(LOG_TAG, "Could not get UT handle for updateCOLR.");
                            }
                        } else if (isInterrogate()) {
                            try {
                                this.mPhone.mCT.getUtInterface().queryCOLR(obtainMessage(MATCH_GROUP_SIB, this));
                            } catch (ImsException e5) {
                                Rlog.d(LOG_TAG, "Could not get UT handle for queryCOLR.");
                            }
                        } else {
                            throw new RuntimeException("Invalid or Unsupported MMI Code");
                        }
                    } else if (isInterrogate()) {
                        try {
                            this.mPhone.mCT.getUtInterface().queryCOLP(obtainMessage(MATCH_GROUP_SIB, this));
                        } catch (ImsException e6) {
                            Rlog.d(LOG_TAG, "Could not get UT handle for queryCOLP.");
                        }
                    } else if (isActivate() || isDeactivate()) {
                        try {
                            this.mPhone.mCT.getUtInterface().updateCOLP(isActivate(), obtainMessage(NUM_PRESENTATION_ALLOWED, this));
                        } catch (ImsException e7) {
                            Rlog.d(LOG_TAG, "Could not get UT handle for updateCOLP.");
                        }
                    } else {
                        throw new RuntimeException("Invalid or Unsupported MMI Code");
                    }
                } else if (isInterrogate()) {
                    try {
                        this.mPhone.mCT.getUtInterface().queryCLIP(obtainMessage(MATCH_GROUP_SIB, this));
                    } catch (ImsException e8) {
                        Rlog.d(LOG_TAG, "Could not get UT handle for queryCLIP.");
                    }
                } else if (isActivate() || isDeactivate()) {
                    try {
                        this.mPhone.mCT.getUtInterface().updateCLIP(isActivate(), obtainMessage(NUM_PRESENTATION_ALLOWED, this));
                    } catch (ImsException e9) {
                        Rlog.d(LOG_TAG, "Could not get UT handle for updateCLIP.");
                    }
                } else {
                    throw new RuntimeException("Invalid or Unsupported MMI Code");
                }
            } else if (isActivate()) {
                try {
                    this.mPhone.mCT.getUtInterface().updateCLIR(NUM_PRESENTATION_RESTRICTED, obtainMessage(NUM_PRESENTATION_ALLOWED, this));
                } catch (ImsException e10) {
                    Rlog.d(LOG_TAG, "Could not get UT handle for updateCLIR.");
                }
            } else if (isDeactivate()) {
                try {
                    this.mPhone.mCT.getUtInterface().updateCLIR(MAX_LENGTH_SHORT_CODE, obtainMessage(NUM_PRESENTATION_ALLOWED, this));
                } catch (ImsException e11) {
                    Rlog.d(LOG_TAG, "Could not get UT handle for updateCLIR.");
                }
            } else if (isInterrogate()) {
                try {
                    this.mPhone.mCT.getUtInterface().queryCLIR(obtainMessage(EVENT_GET_CLIR_COMPLETE, this));
                } catch (ImsException e12) {
                    Rlog.d(LOG_TAG, "Could not get UT handle for queryCLIR.");
                }
            } else {
                throw new RuntimeException("Invalid or Unsupported MMI Code");
            }
        } catch (RuntimeException e13) {
            this.mState = State.FAILED;
            this.mMessage = this.mContext.getText(17039496);
            this.mPhone.onMMIDone(this);
        }
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

    void sendUssd(String ussdMessage) {
        this.mIsPendingUSSD = true;
        this.mPhone.sendUSSD(ussdMessage, obtainMessage(MAX_LENGTH_SHORT_CODE, this));
    }

    public void handleMessage(Message msg) {
        AsyncResult ar;
        switch (msg.what) {
            case NUM_PRESENTATION_ALLOWED /*0*/:
                onSetComplete(msg, (AsyncResult) msg.obj);
            case NUM_PRESENTATION_RESTRICTED /*1*/:
                onQueryCfComplete((AsyncResult) msg.obj);
            case MAX_LENGTH_SHORT_CODE /*2*/:
                ar = (AsyncResult) msg.obj;
                if (ar.exception != null) {
                    this.mState = State.FAILED;
                    this.mMessage = getErrorMessage(ar);
                    this.mPhone.onMMIDone(this);
                }
            case MATCH_GROUP_SERVICE_CODE /*3*/:
                onQueryComplete((AsyncResult) msg.obj);
            case EVENT_SET_CFF_COMPLETE /*4*/:
                ar = (AsyncResult) msg.obj;
                if (ar.exception == null && msg.arg1 == NUM_PRESENTATION_RESTRICTED) {
                    boolean cffEnabled = msg.arg2 == NUM_PRESENTATION_RESTRICTED;
                    if (this.mIccRecords != null) {
                        this.mIccRecords.setVoiceCallForwardingFlag(NUM_PRESENTATION_RESTRICTED, cffEnabled, this.mDialingNumber);
                    }
                }
                onSetComplete(msg, ar);
            case MATCH_GROUP_SIA /*5*/:
                this.mPhone.onMMIDone(this);
            case EVENT_GET_CLIR_COMPLETE /*6*/:
                onQueryClirComplete((AsyncResult) msg.obj);
            case MATCH_GROUP_SIB /*7*/:
                onSuppSvcQueryComplete((AsyncResult) msg.obj);
            default:
        }
    }

    private void processIcbMmiCodeForUpdate() {
        String dialingNumber = this.mSia;
        String[] icbNum = null;
        if (dialingNumber != null) {
            icbNum = dialingNumber.split("\\$");
        }
        try {
            this.mPhone.mCT.getUtInterface().updateCallBarring(10, isActivate(), obtainMessage(MATCH_GROUP_SIB, this), icbNum);
        } catch (ImsException e) {
            Rlog.d(LOG_TAG, "Could not get UT handle for updating ICB.");
        }
    }

    private CharSequence getErrorMessage(AsyncResult ar) {
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
            if (this.mSc.equals(SC_PWD)) {
                return this.mContext.getText(17039522);
            }
            if (this.mSc.equals(SC_WAIT)) {
                return this.mContext.getText(17039520);
            }
            if (this.mSc.equals(SC_CLIP)) {
                return this.mContext.getText(17039515);
            }
            if (this.mSc.equals(SC_CLIR)) {
                return this.mContext.getText(17039516);
            }
            if (this.mSc.equals(SC_COLP)) {
                return this.mContext.getText(17039517);
            }
            if (this.mSc.equals(SC_COLR)) {
                return this.mContext.getText(17039518);
            }
        }
        return "";
    }

    private void onSetComplete(Message msg, AsyncResult ar) {
        StringBuilder sb = new StringBuilder(getScString());
        sb.append("\n");
        if (ar.exception != null) {
            this.mState = State.FAILED;
            if (!(ar.exception instanceof CommandException)) {
                ImsException error = ar.exception;
                if (error.getMessage() != null) {
                    sb.append(error.getMessage());
                } else {
                    sb.append(getErrorMessage(ar));
                }
            } else if (((CommandException) ar.exception).getCommandError() == Error.PASSWORD_INCORRECT) {
                sb.append(this.mContext.getText(17039503));
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
        } else if (isDeactivate()) {
            this.mState = State.COMPLETE;
            sb.append(this.mContext.getText(17039500));
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

    private CharSequence serviceClassToCFString(int serviceClass) {
        switch (serviceClass) {
            case NUM_PRESENTATION_RESTRICTED /*1*/:
                return this.mContext.getText(17039549);
            case MAX_LENGTH_SHORT_CODE /*2*/:
                return this.mContext.getText(17039550);
            case EVENT_SET_CFF_COMPLETE /*4*/:
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
        sources[NUM_PRESENTATION_ALLOWED] = "{0}";
        sources[NUM_PRESENTATION_RESTRICTED] = "{1}";
        sources[MAX_LENGTH_SHORT_CODE] = "{2}";
        CharSequence[] destinations = new CharSequence[MATCH_GROUP_SERVICE_CODE];
        if (info.reason == MAX_LENGTH_SHORT_CODE) {
            needTimeTemplate = true;
        } else {
            needTimeTemplate = false;
        }
        if (info.status == NUM_PRESENTATION_RESTRICTED) {
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
        destinations[NUM_PRESENTATION_ALLOWED] = serviceClassToCFString(info.serviceClass & serviceClassMask);
        destinations[NUM_PRESENTATION_RESTRICTED] = PhoneNumberUtils.stringFromStringAndTOA(info.number, info.toa);
        destinations[MAX_LENGTH_SHORT_CODE] = Integer.toString(info.timeSeconds);
        if (info.reason == 0 && (info.serviceClass & serviceClassMask) == NUM_PRESENTATION_RESTRICTED) {
            boolean cffEnabled = info.status == NUM_PRESENTATION_RESTRICTED;
            if (this.mIccRecords != null) {
                this.mIccRecords.setVoiceCallForwardingFlag(NUM_PRESENTATION_RESTRICTED, cffEnabled, info.number);
            }
        }
        return TextUtils.replace(template, sources, destinations);
    }

    private void onQueryCfComplete(AsyncResult ar) {
        StringBuilder sb = new StringBuilder(getScString());
        sb.append("\n");
        if (ar.exception != null) {
            this.mState = State.FAILED;
            if (ar.exception instanceof ImsException) {
                ImsException error = ar.exception;
                if (error.getMessage() != null) {
                    sb.append(error.getMessage());
                } else {
                    sb.append(getErrorMessage(ar));
                }
            } else {
                sb.append(getErrorMessage(ar));
            }
        } else {
            CallForwardInfo[] infos = (CallForwardInfo[]) ar.result;
            if (infos.length == 0) {
                sb.append(this.mContext.getText(17039500));
                if (this.mIccRecords != null) {
                    this.mIccRecords.setVoiceCallForwardingFlag(NUM_PRESENTATION_RESTRICTED, false, null);
                }
            } else {
                SpannableStringBuilder tb = new SpannableStringBuilder();
                for (int serviceClassMask = NUM_PRESENTATION_RESTRICTED; serviceClassMask <= PduPart.P_Q; serviceClassMask <<= NUM_PRESENTATION_RESTRICTED) {
                    int s = infos.length;
                    for (int i = NUM_PRESENTATION_ALLOWED; i < s; i += NUM_PRESENTATION_RESTRICTED) {
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

    private void onSuppSvcQueryComplete(AsyncResult ar) {
        StringBuilder sb = new StringBuilder(getScString());
        sb.append("\n");
        if (ar.exception != null) {
            this.mState = State.FAILED;
            if (ar.exception instanceof ImsException) {
                ImsException error = ar.exception;
                if (error.getMessage() != null) {
                    sb.append(error.getMessage());
                } else {
                    sb.append(getErrorMessage(ar));
                }
            } else {
                sb.append(getErrorMessage(ar));
            }
        } else {
            this.mState = State.FAILED;
            if (ar.result instanceof Bundle) {
                Rlog.d(LOG_TAG, "Received CLIP/COLP/COLR Response.");
                ImsSsInfo ssInfo = (ImsSsInfo) ar.result.getParcelable(UT_BUNDLE_KEY_SSINFO);
                if (ssInfo != null) {
                    Rlog.d(LOG_TAG, "ImsSsInfo mStatus = " + ssInfo.mStatus);
                    if (ssInfo.mStatus == 0) {
                        sb.append(this.mContext.getText(17039500));
                        this.mState = State.COMPLETE;
                    } else if (ssInfo.mStatus == NUM_PRESENTATION_RESTRICTED) {
                        sb.append(this.mContext.getText(17039498));
                        this.mState = State.COMPLETE;
                    } else {
                        sb.append(this.mContext.getText(17039496));
                    }
                } else {
                    sb.append(this.mContext.getText(17039496));
                }
            } else {
                Rlog.d(LOG_TAG, "Received Call Barring Response.");
                if (((int[]) ar.result)[NUM_PRESENTATION_ALLOWED] == NUM_PRESENTATION_RESTRICTED) {
                    sb.append(this.mContext.getText(17039498));
                    this.mState = State.COMPLETE;
                } else {
                    sb.append(this.mContext.getText(17039500));
                    this.mState = State.COMPLETE;
                }
            }
        }
        this.mMessage = sb;
        this.mPhone.onMMIDone(this);
    }

    private void onQueryClirComplete(AsyncResult ar) {
        StringBuilder sb = new StringBuilder(getScString());
        sb.append("\n");
        this.mState = State.FAILED;
        if (ar.exception == null) {
            int[] clirInfo = ar.result.getIntArray(UT_BUNDLE_KEY_CLIR);
            Rlog.d(LOG_TAG, "CLIR param n=" + clirInfo[NUM_PRESENTATION_ALLOWED] + " m=" + clirInfo[NUM_PRESENTATION_RESTRICTED]);
            switch (clirInfo[NUM_PRESENTATION_RESTRICTED]) {
                case NUM_PRESENTATION_ALLOWED /*0*/:
                    sb.append(this.mContext.getText(17039534));
                    this.mState = State.COMPLETE;
                    break;
                case NUM_PRESENTATION_RESTRICTED /*1*/:
                    sb.append(this.mContext.getText(17039535));
                    this.mState = State.COMPLETE;
                    break;
                case MATCH_GROUP_SERVICE_CODE /*3*/:
                    switch (clirInfo[NUM_PRESENTATION_ALLOWED]) {
                        case NUM_PRESENTATION_ALLOWED /*0*/:
                            sb.append(this.mContext.getText(17039530));
                            this.mState = State.COMPLETE;
                            break;
                        case NUM_PRESENTATION_RESTRICTED /*1*/:
                            sb.append(this.mContext.getText(17039530));
                            this.mState = State.COMPLETE;
                            break;
                        case MAX_LENGTH_SHORT_CODE /*2*/:
                            sb.append(this.mContext.getText(17039531));
                            this.mState = State.COMPLETE;
                            break;
                        default:
                            sb.append(this.mContext.getText(17039496));
                            this.mState = State.FAILED;
                            break;
                    }
                case EVENT_SET_CFF_COMPLETE /*4*/:
                    switch (clirInfo[NUM_PRESENTATION_ALLOWED]) {
                        case NUM_PRESENTATION_ALLOWED /*0*/:
                            sb.append(this.mContext.getText(17039533));
                            this.mState = State.COMPLETE;
                            break;
                        case NUM_PRESENTATION_RESTRICTED /*1*/:
                            sb.append(this.mContext.getText(17039532));
                            this.mState = State.COMPLETE;
                            break;
                        case MAX_LENGTH_SHORT_CODE /*2*/:
                            sb.append(this.mContext.getText(17039533));
                            this.mState = State.COMPLETE;
                            break;
                        default:
                            sb.append(this.mContext.getText(17039496));
                            this.mState = State.FAILED;
                            break;
                    }
                default:
                    sb.append(this.mContext.getText(17039496));
                    this.mState = State.FAILED;
                    break;
            }
        } else if (ar.exception instanceof ImsException) {
            ImsException error = ar.exception;
            if (error.getMessage() != null) {
                sb.append(error.getMessage());
            } else {
                sb.append(getErrorMessage(ar));
            }
        }
        this.mMessage = sb;
        this.mPhone.onMMIDone(this);
    }

    private void onQueryComplete(AsyncResult ar) {
        StringBuilder sb = new StringBuilder(getScString());
        sb.append("\n");
        if (ar.exception != null) {
            this.mState = State.FAILED;
            if (ar.exception instanceof ImsException) {
                ImsException error = ar.exception;
                if (error.getMessage() != null) {
                    sb.append(error.getMessage());
                } else {
                    sb.append(getErrorMessage(ar));
                }
            } else {
                sb.append(getErrorMessage(ar));
            }
        } else {
            int[] ints = (int[]) ar.result;
            if (ints.length == 0) {
                sb.append(this.mContext.getText(17039496));
            } else if (ints[NUM_PRESENTATION_ALLOWED] == 0) {
                sb.append(this.mContext.getText(17039500));
            } else if (this.mSc.equals(SC_WAIT)) {
                sb.append(createQueryCallWaitingResultMessage(ints[NUM_PRESENTATION_RESTRICTED]));
            } else if (ints[NUM_PRESENTATION_ALLOWED] == NUM_PRESENTATION_RESTRICTED) {
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
        for (int classMask = NUM_PRESENTATION_RESTRICTED; classMask <= PduPart.P_Q; classMask <<= NUM_PRESENTATION_RESTRICTED) {
            if ((classMask & serviceClass) != 0) {
                sb.append("\n");
                sb.append(serviceClassToCFString(classMask & serviceClass));
            }
        }
        return sb;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("ImsPhoneMmiCode {");
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
