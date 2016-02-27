package android.telephony;

public class DisconnectCause {
    public static final int BUSY = 4;
    public static final int CALL_BARRED = 20;
    public static final int CDMA_ACCESS_BLOCKED = 35;
    public static final int CDMA_ACCESS_FAILURE = 32;
    public static final int CDMA_CALL_LOST = 41;
    public static final int CDMA_DROP = 27;
    public static final int CDMA_INTERCEPT = 28;
    public static final int CDMA_LOCKED_UNTIL_POWER_CYCLE = 26;
    public static final int CDMA_NOT_EMERGENCY = 34;
    public static final int CDMA_PREEMPTED = 33;
    public static final int CDMA_REORDER = 29;
    public static final int CDMA_RETRY_ORDER = 31;
    public static final int CDMA_SO_REJECT = 30;
    public static final int CONGESTION = 5;
    public static final int CS_RESTRICTED = 22;
    public static final int CS_RESTRICTED_EMERGENCY = 24;
    public static final int CS_RESTRICTED_NORMAL = 23;
    public static final int DIALED_MMI = 39;
    public static final int DIAL_MODIFIED_TO_DIAL = 48;
    public static final int DIAL_MODIFIED_TO_SS = 47;
    public static final int DIAL_MODIFIED_TO_USSD = 46;
    public static final int EMERGENCY_ONLY = 37;
    public static final int ERROR_UNSPECIFIED = 36;
    public static final int EXITED_ECM = 42;
    public static final int FDN_BLOCKED = 21;
    public static final int ICC_ERROR = 19;
    public static final int IMS_MERGED_SUCCESSFULLY = 45;
    public static final int INCOMING_MISSED = 1;
    public static final int INCOMING_REJECTED = 16;
    public static final int INVALID_CREDENTIALS = 10;
    public static final int INVALID_NUMBER = 7;
    public static final int LIMIT_EXCEEDED = 15;
    public static final int LOCAL = 3;
    public static final int LOST_SIGNAL = 14;
    public static final int MAXIMUM_VALID_VALUE = 48;
    public static final int MINIMUM_VALID_VALUE = 0;
    public static final int MMI = 6;
    public static final int NORMAL = 2;
    public static final int NOT_DISCONNECTED = 0;
    public static final int NOT_VALID = -1;
    public static final int NO_PHONE_NUMBER_SUPPLIED = 38;
    public static final int NUMBER_UNREACHABLE = 8;
    public static final int OUTGOING_CANCELED = 44;
    public static final int OUTGOING_FAILURE = 43;
    public static final int OUT_OF_NETWORK = 11;
    public static final int OUT_OF_SERVICE = 18;
    public static final int POWER_OFF = 17;
    public static final int SERVER_ERROR = 12;
    public static final int SERVER_UNREACHABLE = 9;
    public static final int TIMED_OUT = 13;
    public static final int UNOBTAINABLE_NUMBER = 25;
    public static final int VOICEMAIL_NUMBER_MISSING = 40;

    private DisconnectCause() {
    }

    public static String toString(int cause) {
        switch (cause) {
            case NOT_DISCONNECTED /*0*/:
                return "NOT_DISCONNECTED";
            case INCOMING_MISSED /*1*/:
                return "INCOMING_MISSED";
            case NORMAL /*2*/:
                return "NORMAL";
            case LOCAL /*3*/:
                return "LOCAL";
            case BUSY /*4*/:
                return "BUSY";
            case CONGESTION /*5*/:
                return "CONGESTION";
            case INVALID_NUMBER /*7*/:
                return "INVALID_NUMBER";
            case NUMBER_UNREACHABLE /*8*/:
                return "NUMBER_UNREACHABLE";
            case SERVER_UNREACHABLE /*9*/:
                return "SERVER_UNREACHABLE";
            case INVALID_CREDENTIALS /*10*/:
                return "INVALID_CREDENTIALS";
            case OUT_OF_NETWORK /*11*/:
                return "OUT_OF_NETWORK";
            case SERVER_ERROR /*12*/:
                return "SERVER_ERROR";
            case TIMED_OUT /*13*/:
                return "TIMED_OUT";
            case LOST_SIGNAL /*14*/:
                return "LOST_SIGNAL";
            case LIMIT_EXCEEDED /*15*/:
                return "LIMIT_EXCEEDED";
            case INCOMING_REJECTED /*16*/:
                return "INCOMING_REJECTED";
            case POWER_OFF /*17*/:
                return "POWER_OFF";
            case OUT_OF_SERVICE /*18*/:
                return "OUT_OF_SERVICE";
            case ICC_ERROR /*19*/:
                return "ICC_ERROR";
            case CALL_BARRED /*20*/:
                return "CALL_BARRED";
            case FDN_BLOCKED /*21*/:
                return "FDN_BLOCKED";
            case CS_RESTRICTED /*22*/:
                return "CS_RESTRICTED";
            case CS_RESTRICTED_NORMAL /*23*/:
                return "CS_RESTRICTED_NORMAL";
            case CS_RESTRICTED_EMERGENCY /*24*/:
                return "CS_RESTRICTED_EMERGENCY";
            case UNOBTAINABLE_NUMBER /*25*/:
                return "UNOBTAINABLE_NUMBER";
            case CDMA_LOCKED_UNTIL_POWER_CYCLE /*26*/:
                return "CDMA_LOCKED_UNTIL_POWER_CYCLE";
            case CDMA_DROP /*27*/:
                return "CDMA_DROP";
            case CDMA_INTERCEPT /*28*/:
                return "CDMA_INTERCEPT";
            case CDMA_REORDER /*29*/:
                return "CDMA_REORDER";
            case CDMA_SO_REJECT /*30*/:
                return "CDMA_SO_REJECT";
            case CDMA_RETRY_ORDER /*31*/:
                return "CDMA_RETRY_ORDER";
            case CDMA_ACCESS_FAILURE /*32*/:
                return "CDMA_ACCESS_FAILURE";
            case CDMA_PREEMPTED /*33*/:
                return "CDMA_PREEMPTED";
            case CDMA_NOT_EMERGENCY /*34*/:
                return "CDMA_NOT_EMERGENCY";
            case CDMA_ACCESS_BLOCKED /*35*/:
                return "CDMA_ACCESS_BLOCKED";
            case ERROR_UNSPECIFIED /*36*/:
                return "ERROR_UNSPECIFIED";
            case EMERGENCY_ONLY /*37*/:
                return "EMERGENCY_ONLY";
            case NO_PHONE_NUMBER_SUPPLIED /*38*/:
                return "NO_PHONE_NUMBER_SUPPLIED";
            case DIALED_MMI /*39*/:
                return "DIALED_MMI";
            case VOICEMAIL_NUMBER_MISSING /*40*/:
                return "VOICEMAIL_NUMBER_MISSING";
            case CDMA_CALL_LOST /*41*/:
                return "CDMA_CALL_LOST";
            case EXITED_ECM /*42*/:
                return "EXITED_ECM";
            case OUTGOING_FAILURE /*43*/:
                return "OUTGOING_FAILURE";
            case OUTGOING_CANCELED /*44*/:
                return "OUTGOING_CANCELED";
            case IMS_MERGED_SUCCESSFULLY /*45*/:
                return "IMS_MERGED_SUCCESSFULLY";
            case DIAL_MODIFIED_TO_USSD /*46*/:
                return "DIAL_MODIFIED_TO_USSD";
            case DIAL_MODIFIED_TO_SS /*47*/:
                return "DIAL_MODIFIED_TO_SS";
            case MAXIMUM_VALID_VALUE /*48*/:
                return "DIAL_MODIFIED_TO_DIAL";
            default:
                return "INVALID: " + cause;
        }
    }
}
