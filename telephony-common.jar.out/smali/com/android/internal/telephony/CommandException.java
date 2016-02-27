package com.android.internal.telephony;

import android.telephony.Rlog;
import com.android.internal.telephony.cdma.SignalToneUtil;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPersister;

public class CommandException extends RuntimeException {
    private Error mError;

    public enum Error {
        INVALID_RESPONSE,
        RADIO_NOT_AVAILABLE,
        GENERIC_FAILURE,
        PASSWORD_INCORRECT,
        SIM_PIN2,
        SIM_PUK2,
        REQUEST_NOT_SUPPORTED,
        OP_NOT_ALLOWED_DURING_VOICE_CALL,
        OP_NOT_ALLOWED_BEFORE_REG_NW,
        SMS_FAIL_RETRY,
        SIM_ABSENT,
        SUBSCRIPTION_NOT_AVAILABLE,
        MODE_NOT_SUPPORTED,
        FDN_CHECK_FAILURE,
        ILLEGAL_SIM_OR_ME,
        MISSING_RESOURCE,
        NO_SUCH_ELEMENT,
        SUBSCRIPTION_NOT_SUPPORTED,
        DIAL_MODIFIED_TO_USSD,
        DIAL_MODIFIED_TO_SS,
        DIAL_MODIFIED_TO_DIAL,
        USSD_MODIFIED_TO_DIAL,
        USSD_MODIFIED_TO_SS,
        USSD_MODIFIED_TO_USSD,
        SS_MODIFIED_TO_DIAL,
        SS_MODIFIED_TO_USSD,
        SS_MODIFIED_TO_SS
    }

    public CommandException(Error e) {
        super(e.toString());
        this.mError = e;
    }

    public static CommandException fromRilErrno(int ril_errno) {
        switch (ril_errno) {
            case UiccCardApplication.AUTH_CONTEXT_UNDEFINED /*-1*/:
                return new CommandException(Error.INVALID_RESPONSE);
            case CharacterSets.ANY_CHARSET /*0*/:
                return null;
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return new CommandException(Error.RADIO_NOT_AVAILABLE);
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return new CommandException(Error.GENERIC_FAILURE);
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return new CommandException(Error.PASSWORD_INCORRECT);
            case CharacterSets.ISO_8859_1 /*4*/:
                return new CommandException(Error.SIM_PIN2);
            case CharacterSets.ISO_8859_2 /*5*/:
                return new CommandException(Error.SIM_PUK2);
            case CharacterSets.ISO_8859_3 /*6*/:
                return new CommandException(Error.REQUEST_NOT_SUPPORTED);
            case CharacterSets.ISO_8859_5 /*8*/:
                return new CommandException(Error.OP_NOT_ALLOWED_DURING_VOICE_CALL);
            case CharacterSets.ISO_8859_6 /*9*/:
                return new CommandException(Error.OP_NOT_ALLOWED_BEFORE_REG_NW);
            case CharacterSets.ISO_8859_7 /*10*/:
                return new CommandException(Error.SMS_FAIL_RETRY);
            case CharacterSets.ISO_8859_8 /*11*/:
                return new CommandException(Error.SIM_ABSENT);
            case CharacterSets.ISO_8859_9 /*12*/:
                return new CommandException(Error.SUBSCRIPTION_NOT_AVAILABLE);
            case UserData.ASCII_CR_INDEX /*13*/:
                return new CommandException(Error.MODE_NOT_SUPPORTED);
            case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                return new CommandException(Error.FDN_CHECK_FAILURE);
            case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                return new CommandException(Error.ILLEGAL_SIM_OR_ME);
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
                return new CommandException(Error.MISSING_RESOURCE);
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
                return new CommandException(Error.NO_SUCH_ELEMENT);
            case PduHeaders.MMS_VERSION_1_2 /*18*/:
                return new CommandException(Error.DIAL_MODIFIED_TO_USSD);
            case PduHeaders.MMS_VERSION_1_3 /*19*/:
                return new CommandException(Error.DIAL_MODIFIED_TO_SS);
            case SmsHeader.ELT_ID_EXTENDED_OBJECT /*20*/:
                return new CommandException(Error.DIAL_MODIFIED_TO_DIAL);
            case SmsHeader.ELT_ID_REUSED_EXTENDED_OBJECT /*21*/:
                return new CommandException(Error.USSD_MODIFIED_TO_DIAL);
            case CallFailCause.NUMBER_CHANGED /*22*/:
                return new CommandException(Error.USSD_MODIFIED_TO_SS);
            case SmsHeader.ELT_ID_OBJECT_DISTR_INDICATOR /*23*/:
                return new CommandException(Error.USSD_MODIFIED_TO_USSD);
            case SmsHeader.ELT_ID_STANDARD_WVG_OBJECT /*24*/:
                return new CommandException(Error.SS_MODIFIED_TO_DIAL);
            case SmsHeader.ELT_ID_CHARACTER_SIZE_WVG_OBJECT /*25*/:
                return new CommandException(Error.SS_MODIFIED_TO_USSD);
            case SmsHeader.ELT_ID_EXTENDED_OBJECT_DATA_REQUEST_CMD /*26*/:
                return new CommandException(Error.SUBSCRIPTION_NOT_SUPPORTED);
            case 27:
                return new CommandException(Error.SS_MODIFIED_TO_SS);
            default:
                Rlog.e("GSM", "Unrecognized RIL errno " + ril_errno);
                return new CommandException(Error.INVALID_RESPONSE);
        }
    }

    public Error getCommandError() {
        return this.mError;
    }
}
