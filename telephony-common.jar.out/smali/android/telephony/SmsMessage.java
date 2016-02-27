package android.telephony;

import android.content.res.Resources;
import android.os.Binder;
import android.os.Parcel;
import android.text.TextUtils;
import com.android.internal.telephony.GsmAlphabet;
import com.android.internal.telephony.GsmAlphabet.TextEncodingDetails;
import com.android.internal.telephony.Sms7BitEncodingTranslator;
import com.android.internal.telephony.SmsMessageBase;
import com.android.internal.telephony.SmsMessageBase.SubmitPduBase;
import java.util.ArrayList;
import java.util.Arrays;

public class SmsMessage {
    public static final int ENCODING_16BIT = 3;
    public static final int ENCODING_7BIT = 1;
    public static final int ENCODING_8BIT = 2;
    public static final int ENCODING_KSC5601 = 4;
    public static final int ENCODING_UNKNOWN = 0;
    public static final String FORMAT_3GPP = "3gpp";
    public static final String FORMAT_3GPP2 = "3gpp2";
    private static final String LOG_TAG = "SmsMessage";
    public static final int MAX_USER_DATA_BYTES = 140;
    public static final int MAX_USER_DATA_BYTES_WITH_HEADER = 134;
    public static final int MAX_USER_DATA_SEPTETS = 160;
    public static final int MAX_USER_DATA_SEPTETS_WITH_HEADER = 153;
    private static boolean mIsNoEmsSupportConfigListLoaded;
    private static NoEmsSupportConfig[] mNoEmsSupportConfigList;
    private int mSubId;
    public SmsMessageBase mWrappedSmsMessage;

    /* renamed from: android.telephony.SmsMessage.1 */
    static /* synthetic */ class C00061 {
        static final /* synthetic */ int[] f0xf858d1e4;

        static {
            f0xf858d1e4 = new int[com.android.internal.telephony.SmsConstants.MessageClass.values().length];
            try {
                f0xf858d1e4[com.android.internal.telephony.SmsConstants.MessageClass.CLASS_0.ordinal()] = SmsMessage.ENCODING_7BIT;
            } catch (NoSuchFieldError e) {
            }
            try {
                f0xf858d1e4[com.android.internal.telephony.SmsConstants.MessageClass.CLASS_1.ordinal()] = SmsMessage.ENCODING_8BIT;
            } catch (NoSuchFieldError e2) {
            }
            try {
                f0xf858d1e4[com.android.internal.telephony.SmsConstants.MessageClass.CLASS_2.ordinal()] = SmsMessage.ENCODING_16BIT;
            } catch (NoSuchFieldError e3) {
            }
            try {
                f0xf858d1e4[com.android.internal.telephony.SmsConstants.MessageClass.CLASS_3.ordinal()] = SmsMessage.ENCODING_KSC5601;
            } catch (NoSuchFieldError e4) {
            }
        }
    }

    public enum MessageClass {
        UNKNOWN,
        CLASS_0,
        CLASS_1,
        CLASS_2,
        CLASS_3
    }

    private static class NoEmsSupportConfig {
        String mGid1;
        boolean mIsPrefix;
        String mOperatorNumber;

        public NoEmsSupportConfig(String[] config) {
            this.mOperatorNumber = config[SmsMessage.ENCODING_UNKNOWN];
            this.mIsPrefix = "prefix".equals(config[SmsMessage.ENCODING_7BIT]);
            this.mGid1 = config.length > SmsMessage.ENCODING_8BIT ? config[SmsMessage.ENCODING_8BIT] : null;
        }

        public String toString() {
            return "NoEmsSupportConfig { mOperatorNumber = " + this.mOperatorNumber + ", mIsPrefix = " + this.mIsPrefix + ", mGid1 = " + this.mGid1 + " }";
        }
    }

    public static class SubmitPdu {
        public byte[] encodedMessage;
        public byte[] encodedScAddress;

        public String toString() {
            return "SubmitPdu: encodedScAddress = " + Arrays.toString(this.encodedScAddress) + ", encodedMessage = " + Arrays.toString(this.encodedMessage);
        }

        protected SubmitPdu(SubmitPduBase spb) {
            this.encodedMessage = spb.encodedMessage;
            this.encodedScAddress = spb.encodedScAddress;
        }
    }

    public void setSubId(int subId) {
        this.mSubId = subId;
    }

    public int getSubId() {
        return this.mSubId;
    }

    private SmsMessage(SmsMessageBase smb) {
        this.mSubId = ENCODING_UNKNOWN;
        this.mWrappedSmsMessage = smb;
    }

    public static SmsMessage createFromPdu(byte[] pdu) {
        int activePhone = TelephonyManager.getDefault().getCurrentPhoneType();
        SmsMessage message = createFromPdu(pdu, ENCODING_8BIT == activePhone ? FORMAT_3GPP2 : FORMAT_3GPP);
        if (message != null && message.mWrappedSmsMessage != null) {
            return message;
        }
        return createFromPdu(pdu, ENCODING_8BIT == activePhone ? FORMAT_3GPP : FORMAT_3GPP2);
    }

    public static SmsMessage createFromPdu(byte[] pdu, String format) {
        SmsMessageBase wrappedMessage;
        if (FORMAT_3GPP2.equals(format)) {
            wrappedMessage = com.android.internal.telephony.cdma.SmsMessage.createFromPdu(pdu);
        } else if (FORMAT_3GPP.equals(format)) {
            wrappedMessage = com.android.internal.telephony.gsm.SmsMessage.createFromPdu(pdu);
        } else {
            Rlog.e(LOG_TAG, "createFromPdu(): unsupported message format " + format);
            return null;
        }
        return new SmsMessage(wrappedMessage);
    }

    public static SmsMessage newFromCMT(String[] lines) {
        return new SmsMessage(com.android.internal.telephony.gsm.SmsMessage.newFromCMT(lines));
    }

    public static SmsMessage newFromParcel(Parcel p) {
        return new SmsMessage(com.android.internal.telephony.cdma.SmsMessage.newFromParcel(p));
    }

    public static SmsMessage createFromEfRecord(int index, byte[] data) {
        SmsMessageBase wrappedMessage;
        if (isCdmaVoice()) {
            wrappedMessage = com.android.internal.telephony.cdma.SmsMessage.createFromEfRecord(index, data);
        } else {
            wrappedMessage = com.android.internal.telephony.gsm.SmsMessage.createFromEfRecord(index, data);
        }
        return wrappedMessage != null ? new SmsMessage(wrappedMessage) : null;
    }

    public static int getTPLayerLengthForPDU(String pdu) {
        if (isCdmaVoice()) {
            return com.android.internal.telephony.cdma.SmsMessage.getTPLayerLengthForPDU(pdu);
        }
        return com.android.internal.telephony.gsm.SmsMessage.getTPLayerLengthForPDU(pdu);
    }

    public static int[] calculateLength(CharSequence msgBody, boolean use7bitOnly) {
        TextEncodingDetails ted = useCdmaFormatForMoSms() ? com.android.internal.telephony.cdma.SmsMessage.calculateLength(msgBody, use7bitOnly, true) : com.android.internal.telephony.gsm.SmsMessage.calculateLength(msgBody, use7bitOnly);
        int[] ret = new int[ENCODING_KSC5601];
        ret[ENCODING_UNKNOWN] = ted.msgCount;
        ret[ENCODING_7BIT] = ted.codeUnitCount;
        ret[ENCODING_8BIT] = ted.codeUnitsRemaining;
        ret[ENCODING_16BIT] = ted.codeUnitSize;
        return ret;
    }

    public static ArrayList<String> fragmentText(String text) {
        int limit;
        TextEncodingDetails ted = useCdmaFormatForMoSms() ? com.android.internal.telephony.cdma.SmsMessage.calculateLength(text, false, true) : com.android.internal.telephony.gsm.SmsMessage.calculateLength(text, false);
        if (ted.codeUnitSize == ENCODING_7BIT) {
            int udhLength;
            if (ted.languageTable != 0 && ted.languageShiftTable != 0) {
                udhLength = 7;
            } else if (ted.languageTable == 0 && ted.languageShiftTable == 0) {
                udhLength = ENCODING_UNKNOWN;
            } else {
                udhLength = ENCODING_KSC5601;
            }
            if (ted.msgCount > ENCODING_7BIT) {
                udhLength += 6;
            }
            if (udhLength != 0) {
                udhLength += ENCODING_7BIT;
            }
            limit = 160 - udhLength;
        } else if (ted.msgCount > ENCODING_7BIT) {
            limit = MAX_USER_DATA_BYTES_WITH_HEADER;
            if (!hasEmsSupport() && ted.msgCount < 10) {
                limit = MAX_USER_DATA_BYTES_WITH_HEADER - 2;
            }
        } else {
            limit = MAX_USER_DATA_BYTES;
        }
        String newMsgBody = null;
        if (Resources.getSystem().getBoolean(17957008)) {
            newMsgBody = Sms7BitEncodingTranslator.translate(text);
        }
        if (TextUtils.isEmpty(newMsgBody)) {
            newMsgBody = text;
        }
        int pos = ENCODING_UNKNOWN;
        int textLen = newMsgBody.length();
        ArrayList<String> result = new ArrayList(ted.msgCount);
        while (pos < textLen) {
            int nextPos;
            if (ted.codeUnitSize != ENCODING_7BIT) {
                nextPos = pos + Math.min(limit / ENCODING_8BIT, textLen - pos);
            } else if (useCdmaFormatForMoSms() && ted.msgCount == ENCODING_7BIT) {
                nextPos = pos + Math.min(limit, textLen - pos);
            } else {
                nextPos = GsmAlphabet.findGsmSeptetLimitIndex(newMsgBody, pos, limit, ted.languageTable, ted.languageShiftTable);
            }
            if (nextPos <= pos || nextPos > textLen) {
                Rlog.e(LOG_TAG, "fragmentText failed (" + pos + " >= " + nextPos + " or " + nextPos + " >= " + textLen + ")");
                break;
            }
            result.add(newMsgBody.substring(pos, nextPos));
            pos = nextPos;
        }
        return result;
    }

    public static int[] calculateLength(String messageBody, boolean use7bitOnly) {
        return calculateLength((CharSequence) messageBody, use7bitOnly);
    }

    public static SubmitPdu getSubmitPdu(String scAddress, String destinationAddress, String message, boolean statusReportRequested) {
        SubmitPduBase spb;
        if (useCdmaFormatForMoSms()) {
            spb = com.android.internal.telephony.cdma.SmsMessage.getSubmitPdu(scAddress, destinationAddress, message, statusReportRequested, null);
        } else {
            spb = com.android.internal.telephony.gsm.SmsMessage.getSubmitPdu(scAddress, destinationAddress, message, statusReportRequested);
        }
        return new SubmitPdu(spb);
    }

    public static SubmitPdu getSubmitPdu(String scAddress, String destinationAddress, short destinationPort, byte[] data, boolean statusReportRequested) {
        SubmitPduBase spb;
        if (useCdmaFormatForMoSms()) {
            spb = com.android.internal.telephony.cdma.SmsMessage.getSubmitPdu(scAddress, destinationAddress, (int) destinationPort, data, statusReportRequested);
        } else {
            spb = com.android.internal.telephony.gsm.SmsMessage.getSubmitPdu(scAddress, destinationAddress, (int) destinationPort, data, statusReportRequested);
        }
        return new SubmitPdu(spb);
    }

    public String getServiceCenterAddress() {
        return this.mWrappedSmsMessage.getServiceCenterAddress();
    }

    public String getOriginatingAddress() {
        return this.mWrappedSmsMessage.getOriginatingAddress();
    }

    public String getDisplayOriginatingAddress() {
        return this.mWrappedSmsMessage.getDisplayOriginatingAddress();
    }

    public String getMessageBody() {
        return this.mWrappedSmsMessage.getMessageBody();
    }

    public MessageClass getMessageClass() {
        switch (C00061.f0xf858d1e4[this.mWrappedSmsMessage.getMessageClass().ordinal()]) {
            case ENCODING_7BIT /*1*/:
                return MessageClass.CLASS_0;
            case ENCODING_8BIT /*2*/:
                return MessageClass.CLASS_1;
            case ENCODING_16BIT /*3*/:
                return MessageClass.CLASS_2;
            case ENCODING_KSC5601 /*4*/:
                return MessageClass.CLASS_3;
            default:
                return MessageClass.UNKNOWN;
        }
    }

    public String getDisplayMessageBody() {
        return this.mWrappedSmsMessage.getDisplayMessageBody();
    }

    public String getPseudoSubject() {
        return this.mWrappedSmsMessage.getPseudoSubject();
    }

    public long getTimestampMillis() {
        return this.mWrappedSmsMessage.getTimestampMillis();
    }

    public boolean isEmail() {
        return this.mWrappedSmsMessage.isEmail();
    }

    public String getEmailBody() {
        return this.mWrappedSmsMessage.getEmailBody();
    }

    public String getEmailFrom() {
        return this.mWrappedSmsMessage.getEmailFrom();
    }

    public int getProtocolIdentifier() {
        return this.mWrappedSmsMessage.getProtocolIdentifier();
    }

    public boolean isReplace() {
        return this.mWrappedSmsMessage.isReplace();
    }

    public boolean isCphsMwiMessage() {
        return this.mWrappedSmsMessage.isCphsMwiMessage();
    }

    public boolean isMWIClearMessage() {
        return this.mWrappedSmsMessage.isMWIClearMessage();
    }

    public boolean isMWISetMessage() {
        return this.mWrappedSmsMessage.isMWISetMessage();
    }

    public boolean isMwiDontStore() {
        return this.mWrappedSmsMessage.isMwiDontStore();
    }

    public byte[] getUserData() {
        return this.mWrappedSmsMessage.getUserData();
    }

    public byte[] getPdu() {
        return this.mWrappedSmsMessage.getPdu();
    }

    @Deprecated
    public int getStatusOnSim() {
        return this.mWrappedSmsMessage.getStatusOnIcc();
    }

    public int getStatusOnIcc() {
        return this.mWrappedSmsMessage.getStatusOnIcc();
    }

    @Deprecated
    public int getIndexOnSim() {
        return this.mWrappedSmsMessage.getIndexOnIcc();
    }

    public int getIndexOnIcc() {
        return this.mWrappedSmsMessage.getIndexOnIcc();
    }

    public int getStatus() {
        return this.mWrappedSmsMessage.getStatus();
    }

    public boolean isStatusReportMessage() {
        return this.mWrappedSmsMessage.isStatusReportMessage();
    }

    public boolean isReplyPathPresent() {
        return this.mWrappedSmsMessage.isReplyPathPresent();
    }

    private static boolean useCdmaFormatForMoSms() {
        if (SmsManager.getDefault().isImsSmsSupported()) {
            return FORMAT_3GPP2.equals(SmsManager.getDefault().getImsSmsFormat());
        }
        return isCdmaVoice();
    }

    private static boolean isCdmaVoice() {
        return ENCODING_8BIT == TelephonyManager.getDefault().getCurrentPhoneType();
    }

    public static boolean hasEmsSupport() {
        if (!isNoEmsSupportConfigListExisted()) {
            return true;
        }
        long identity = Binder.clearCallingIdentity();
        try {
            String simOperator = TelephonyManager.getDefault().getSimOperatorNumeric();
            String gid = TelephonyManager.getDefault().getGroupIdLevel1();
            NoEmsSupportConfig[] arr$ = mNoEmsSupportConfigList;
            int len$ = arr$.length;
            for (int i$ = ENCODING_UNKNOWN; i$ < len$; i$ += ENCODING_7BIT) {
                NoEmsSupportConfig currentConfig = arr$[i$];
                if (simOperator.startsWith(currentConfig.mOperatorNumber) && (TextUtils.isEmpty(currentConfig.mGid1) || (!TextUtils.isEmpty(currentConfig.mGid1) && currentConfig.mGid1.equalsIgnoreCase(gid)))) {
                    return false;
                }
            }
            return true;
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
    }

    public static boolean shouldAppendPageNumberAsPrefix() {
        if (!isNoEmsSupportConfigListExisted()) {
            return false;
        }
        long identity = Binder.clearCallingIdentity();
        try {
            String simOperator = TelephonyManager.getDefault().getSimOperatorNumeric();
            String gid = TelephonyManager.getDefault().getGroupIdLevel1();
            NoEmsSupportConfig[] arr$ = mNoEmsSupportConfigList;
            int len$ = arr$.length;
            for (int i$ = ENCODING_UNKNOWN; i$ < len$; i$ += ENCODING_7BIT) {
                NoEmsSupportConfig currentConfig = arr$[i$];
                if (simOperator.startsWith(currentConfig.mOperatorNumber) && (TextUtils.isEmpty(currentConfig.mGid1) || (!TextUtils.isEmpty(currentConfig.mGid1) && currentConfig.mGid1.equalsIgnoreCase(gid)))) {
                    return currentConfig.mIsPrefix;
                }
            }
            return false;
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
    }

    static {
        mNoEmsSupportConfigList = null;
        mIsNoEmsSupportConfigListLoaded = false;
    }

    private static boolean isNoEmsSupportConfigListExisted() {
        if (!mIsNoEmsSupportConfigListLoaded) {
            Resources r = Resources.getSystem();
            if (r != null) {
                String[] listArray = r.getStringArray(17236026);
                if (listArray != null && listArray.length > 0) {
                    mNoEmsSupportConfigList = new NoEmsSupportConfig[listArray.length];
                    for (int i = ENCODING_UNKNOWN; i < listArray.length; i += ENCODING_7BIT) {
                        mNoEmsSupportConfigList[i] = new NoEmsSupportConfig(listArray[i].split(";"));
                    }
                }
                mIsNoEmsSupportConfigListLoaded = true;
            }
        }
        if (mNoEmsSupportConfigList == null || mNoEmsSupportConfigList.length == 0) {
            return false;
        }
        return true;
    }
}
