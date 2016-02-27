package com.android.internal.telephony.gsm;

import android.content.res.Resources;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.text.TextUtils;
import android.text.format.Time;
import com.android.internal.telephony.EncodeException;
import com.android.internal.telephony.GsmAlphabet;
import com.android.internal.telephony.GsmAlphabet.TextEncodingDetails;
import com.android.internal.telephony.Sms7BitEncodingTranslator;
import com.android.internal.telephony.SmsConstants.MessageClass;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.SmsHeader.PortAddrs;
import com.android.internal.telephony.SmsMessageBase;
import com.android.internal.telephony.SmsMessageBase.SubmitPduBase;
import com.android.internal.telephony.uicc.IccUtils;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPart;
import com.google.android.mms.pdu.PduPersister;
import java.io.ByteArrayOutputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;

public class SmsMessage extends SmsMessageBase {
    static final String LOG_TAG = "SmsMessage";
    private static final boolean VDBG = false;
    private int mDataCodingScheme;
    private boolean mIsStatusReportMessage;
    private int mMti;
    private int mProtocolIdentifier;
    private GsmSmsAddress mRecipientAddress;
    private boolean mReplyPathPresent;
    private int mStatus;
    private int mVoiceMailCount;
    private MessageClass messageClass;

    private static class PduParser {
        int mCur;
        byte[] mPdu;
        byte[] mUserData;
        SmsHeader mUserDataHeader;
        int mUserDataSeptetPadding;

        PduParser(byte[] pdu) {
            this.mPdu = pdu;
            this.mCur = 0;
            this.mUserDataSeptetPadding = 0;
        }

        String getSCAddress() {
            String ret;
            int len = getByte();
            if (len == 0) {
                ret = null;
            } else {
                try {
                    ret = PhoneNumberUtils.calledPartyBCDToString(this.mPdu, this.mCur, len);
                } catch (RuntimeException tr) {
                    Rlog.d(SmsMessage.LOG_TAG, "invalid SC address: ", tr);
                    ret = null;
                }
            }
            this.mCur += len;
            return ret;
        }

        int getByte() {
            byte[] bArr = this.mPdu;
            int i = this.mCur;
            this.mCur = i + 1;
            return bArr[i] & PduHeaders.STORE_STATUS_ERROR_END;
        }

        GsmSmsAddress getAddress() {
            int lengthBytes = (((this.mPdu[this.mCur] & PduHeaders.STORE_STATUS_ERROR_END) + 1) / 2) + 2;
            try {
                GsmSmsAddress ret = new GsmSmsAddress(this.mPdu, this.mCur, lengthBytes);
                this.mCur += lengthBytes;
                return ret;
            } catch (ParseException e) {
                throw new RuntimeException(e.getMessage());
            }
        }

        long getSCTimestampMillis() {
            byte[] bArr = this.mPdu;
            int i = this.mCur;
            this.mCur = i + 1;
            int year = IccUtils.gsmBcdByteToInt(bArr[i]);
            bArr = this.mPdu;
            i = this.mCur;
            this.mCur = i + 1;
            int month = IccUtils.gsmBcdByteToInt(bArr[i]);
            bArr = this.mPdu;
            i = this.mCur;
            this.mCur = i + 1;
            int day = IccUtils.gsmBcdByteToInt(bArr[i]);
            bArr = this.mPdu;
            i = this.mCur;
            this.mCur = i + 1;
            int hour = IccUtils.gsmBcdByteToInt(bArr[i]);
            bArr = this.mPdu;
            i = this.mCur;
            this.mCur = i + 1;
            int minute = IccUtils.gsmBcdByteToInt(bArr[i]);
            bArr = this.mPdu;
            i = this.mCur;
            this.mCur = i + 1;
            int second = IccUtils.gsmBcdByteToInt(bArr[i]);
            bArr = this.mPdu;
            i = this.mCur;
            this.mCur = i + 1;
            byte tzByte = bArr[i];
            int timezoneOffset = IccUtils.gsmBcdByteToInt((byte) (tzByte & -9));
            if ((tzByte & 8) != 0) {
                timezoneOffset = -timezoneOffset;
            }
            Time time = new Time("UTC");
            time.year = year >= 90 ? year + 1900 : year + 2000;
            time.month = month - 1;
            time.monthDay = day;
            time.hour = hour;
            time.minute = minute;
            time.second = second;
            return time.toMillis(true) - ((long) (((timezoneOffset * 15) * 60) * CharacterSets.UCS2));
        }

        int constructUserData(boolean hasUserDataHeader, boolean dataInSeptets) {
            int i;
            int bufferLen;
            int offset = this.mCur;
            int offset2 = offset + 1;
            int userDataLength = this.mPdu[offset] & PduHeaders.STORE_STATUS_ERROR_END;
            int headerSeptets = 0;
            int userDataHeaderLength = 0;
            if (hasUserDataHeader) {
                offset = offset2 + 1;
                userDataHeaderLength = this.mPdu[offset2] & PduHeaders.STORE_STATUS_ERROR_END;
                byte[] udh = new byte[userDataHeaderLength];
                System.arraycopy(this.mPdu, offset, udh, 0, userDataHeaderLength);
                this.mUserDataHeader = SmsHeader.fromByteArray(udh);
                offset += userDataHeaderLength;
                int headerBits = (userDataHeaderLength + 1) * 8;
                headerSeptets = headerBits / 7;
                if (headerBits % 7 > 0) {
                    i = 1;
                } else {
                    i = 0;
                }
                headerSeptets += i;
                this.mUserDataSeptetPadding = (headerSeptets * 7) - headerBits;
            } else {
                offset = offset2;
            }
            if (dataInSeptets) {
                bufferLen = this.mPdu.length - offset;
            } else {
                if (hasUserDataHeader) {
                    i = userDataHeaderLength + 1;
                } else {
                    i = 0;
                }
                bufferLen = userDataLength - i;
                if (bufferLen < 0) {
                    bufferLen = 0;
                }
            }
            this.mUserData = new byte[bufferLen];
            System.arraycopy(this.mPdu, offset, this.mUserData, 0, this.mUserData.length);
            this.mCur = offset;
            if (!dataInSeptets) {
                return this.mUserData.length;
            }
            int count = userDataLength - headerSeptets;
            if (count < 0) {
                return 0;
            }
            return count;
        }

        byte[] getUserData() {
            return this.mUserData;
        }

        SmsHeader getUserDataHeader() {
            return this.mUserDataHeader;
        }

        String getUserDataGSM7Bit(int septetCount, int languageTable, int languageShiftTable) {
            String ret = GsmAlphabet.gsm7BitPackedToString(this.mPdu, this.mCur, septetCount, this.mUserDataSeptetPadding, languageTable, languageShiftTable);
            this.mCur += (septetCount * 7) / 8;
            return ret;
        }

        String getUserDataGSM8bit(int byteCount) {
            String ret = GsmAlphabet.gsm8BitUnpackedToString(this.mPdu, this.mCur, byteCount);
            this.mCur += byteCount;
            return ret;
        }

        String getUserDataUCS2(int byteCount) {
            String ret;
            try {
                ret = new String(this.mPdu, this.mCur, byteCount, CharacterSets.MIMENAME_UTF_16);
            } catch (UnsupportedEncodingException ex) {
                ret = "";
                Rlog.e(SmsMessage.LOG_TAG, "implausible UnsupportedEncodingException", ex);
            }
            this.mCur += byteCount;
            return ret;
        }

        String getUserDataKSC5601(int byteCount) {
            String ret;
            try {
                ret = new String(this.mPdu, this.mCur, byteCount, "KSC5601");
            } catch (UnsupportedEncodingException ex) {
                ret = "";
                Rlog.e(SmsMessage.LOG_TAG, "implausible UnsupportedEncodingException", ex);
            }
            this.mCur += byteCount;
            return ret;
        }

        boolean moreDataPresent() {
            return this.mPdu.length > this.mCur;
        }
    }

    public static class SubmitPdu extends SubmitPduBase {
    }

    public SmsMessage() {
        this.mReplyPathPresent = false;
        this.mIsStatusReportMessage = false;
        this.mVoiceMailCount = 0;
    }

    public static SmsMessage createFromPdu(byte[] pdu) {
        try {
            SmsMessage msg = new SmsMessage();
            msg.parsePdu(pdu);
            return msg;
        } catch (RuntimeException ex) {
            Rlog.e(LOG_TAG, "SMS PDU parsing failed: ", ex);
            return null;
        } catch (OutOfMemoryError e) {
            Rlog.e(LOG_TAG, "SMS PDU parsing failed with out of memory: ", e);
            return null;
        }
    }

    public boolean isTypeZero() {
        return this.mProtocolIdentifier == 64;
    }

    public static SmsMessage newFromCMT(String[] lines) {
        try {
            SmsMessage msg = new SmsMessage();
            msg.parsePdu(IccUtils.hexStringToBytes(lines[1]));
            return msg;
        } catch (RuntimeException ex) {
            Rlog.e(LOG_TAG, "SMS PDU parsing failed: ", ex);
            return null;
        }
    }

    public static SmsMessage newFromCDS(String line) {
        try {
            SmsMessage msg = new SmsMessage();
            msg.parsePdu(IccUtils.hexStringToBytes(line));
            return msg;
        } catch (RuntimeException ex) {
            Rlog.e(LOG_TAG, "CDS SMS PDU parsing failed: ", ex);
            return null;
        }
    }

    public static SmsMessage createFromEfRecord(int index, byte[] data) {
        try {
            SmsMessage msg = new SmsMessage();
            msg.mIndexOnIcc = index;
            if ((data[0] & 1) == 0) {
                Rlog.w(LOG_TAG, "SMS parsing failed: Trying to parse a free record");
                return null;
            }
            msg.mStatusOnIcc = data[0] & 7;
            int size = data.length - 1;
            byte[] pdu = new byte[size];
            System.arraycopy(data, 1, pdu, 0, size);
            msg.parsePdu(pdu);
            return msg;
        } catch (RuntimeException ex) {
            Rlog.e(LOG_TAG, "SMS PDU parsing failed: ", ex);
            return null;
        }
    }

    public static int getTPLayerLengthForPDU(String pdu) {
        return ((pdu.length() / 2) - Integer.parseInt(pdu.substring(0, 2), 16)) - 1;
    }

    public static SubmitPdu getSubmitPdu(String scAddress, String destinationAddress, String message, boolean statusReportRequested, byte[] header) {
        return getSubmitPdu(scAddress, destinationAddress, message, statusReportRequested, header, 0, 0, 0);
    }

    public static SubmitPdu getSubmitPdu(String scAddress, String destinationAddress, String message, boolean statusReportRequested, byte[] header, int encoding, int languageTable, int languageShiftTable) {
        if (message == null || destinationAddress == null) {
            return null;
        }
        byte[] userData;
        if (encoding == 0) {
            TextEncodingDetails ted = calculateLength(message, false);
            encoding = ted.codeUnitSize;
            languageTable = ted.languageTable;
            languageShiftTable = ted.languageShiftTable;
            if (encoding == 1 && !(languageTable == 0 && languageShiftTable == 0)) {
                SmsHeader smsHeader;
                if (header != null) {
                    smsHeader = SmsHeader.fromByteArray(header);
                    if (!(smsHeader.languageTable == languageTable && smsHeader.languageShiftTable == languageShiftTable)) {
                        Rlog.w(LOG_TAG, "Updating language table in SMS header: " + smsHeader.languageTable + " -> " + languageTable + ", " + smsHeader.languageShiftTable + " -> " + languageShiftTable);
                        smsHeader.languageTable = languageTable;
                        smsHeader.languageShiftTable = languageShiftTable;
                        header = SmsHeader.toByteArray(smsHeader);
                    }
                } else {
                    smsHeader = new SmsHeader();
                    smsHeader.languageTable = languageTable;
                    smsHeader.languageShiftTable = languageShiftTable;
                    header = SmsHeader.toByteArray(smsHeader);
                }
            }
        }
        SubmitPdu ret = new SubmitPdu();
        ByteArrayOutputStream bo = getSubmitPduHead(scAddress, destinationAddress, (byte) ((header != null ? 64 : 0) | 1), statusReportRequested, ret);
        if (encoding == 1) {
            try {
                userData = GsmAlphabet.stringToGsm7BitPackedWithHeader(message, header, languageTable, languageShiftTable);
            } catch (EncodeException e) {
                try {
                    userData = encodeUCS2(message, header);
                    encoding = 3;
                } catch (UnsupportedEncodingException uex) {
                    Rlog.e(LOG_TAG, "Implausible UnsupportedEncodingException ", uex);
                    return null;
                }
            }
        }
        try {
            userData = encodeUCS2(message, header);
        } catch (UnsupportedEncodingException uex2) {
            Rlog.e(LOG_TAG, "Implausible UnsupportedEncodingException ", uex2);
            return null;
        }
        if (encoding == 1) {
            if ((userData[0] & PduHeaders.STORE_STATUS_ERROR_END) > PduHeaders.PREVIOUSLY_SENT_BY) {
                Rlog.e(LOG_TAG, "Message too long (" + (userData[0] & PduHeaders.STORE_STATUS_ERROR_END) + " septets)");
                return null;
            }
            bo.write(0);
        } else if ((userData[0] & PduHeaders.STORE_STATUS_ERROR_END) > PduPart.P_DEP_COMMENT) {
            Rlog.e(LOG_TAG, "Message too long (" + (userData[0] & PduHeaders.STORE_STATUS_ERROR_END) + " bytes)");
            return null;
        } else {
            bo.write(8);
        }
        bo.write(userData, 0, userData.length);
        ret.encodedMessage = bo.toByteArray();
        return ret;
    }

    private static byte[] encodeUCS2(String message, byte[] header) throws UnsupportedEncodingException {
        byte[] userData;
        byte[] textPart = message.getBytes("utf-16be");
        if (header != null) {
            userData = new byte[((header.length + textPart.length) + 1)];
            userData[0] = (byte) header.length;
            System.arraycopy(header, 0, userData, 1, header.length);
            System.arraycopy(textPart, 0, userData, header.length + 1, textPart.length);
        } else {
            userData = textPart;
        }
        byte[] ret = new byte[(userData.length + 1)];
        ret[0] = (byte) (userData.length & PduHeaders.STORE_STATUS_ERROR_END);
        System.arraycopy(userData, 0, ret, 1, userData.length);
        return ret;
    }

    public static SubmitPdu getSubmitPdu(String scAddress, String destinationAddress, String message, boolean statusReportRequested) {
        return getSubmitPdu(scAddress, destinationAddress, message, statusReportRequested, null);
    }

    public static SubmitPdu getSubmitPdu(String scAddress, String destinationAddress, int destinationPort, byte[] data, boolean statusReportRequested) {
        PortAddrs portAddrs = new PortAddrs();
        portAddrs.destPort = destinationPort;
        portAddrs.origPort = 0;
        portAddrs.areEightBits = false;
        SmsHeader smsHeader = new SmsHeader();
        smsHeader.portAddrs = portAddrs;
        byte[] smsHeaderData = SmsHeader.toByteArray(smsHeader);
        if ((data.length + smsHeaderData.length) + 1 > PduPart.P_DEP_COMMENT) {
            Rlog.e(LOG_TAG, "SMS data message may only contain " + ((140 - smsHeaderData.length) - 1) + " bytes");
            return null;
        }
        SubmitPdu ret = new SubmitPdu();
        ByteArrayOutputStream bo = getSubmitPduHead(scAddress, destinationAddress, (byte) 65, statusReportRequested, ret);
        bo.write(4);
        bo.write((data.length + smsHeaderData.length) + 1);
        bo.write(smsHeaderData.length);
        bo.write(smsHeaderData, 0, smsHeaderData.length);
        bo.write(data, 0, data.length);
        ret.encodedMessage = bo.toByteArray();
        return ret;
    }

    private static ByteArrayOutputStream getSubmitPduHead(String scAddress, String destinationAddress, byte mtiByte, boolean statusReportRequested, SubmitPdu ret) {
        int i;
        ByteArrayOutputStream bo = new ByteArrayOutputStream(PduHeaders.RECOMMENDED_RETRIEVAL_MODE);
        if (scAddress == null) {
            ret.encodedScAddress = null;
        } else {
            ret.encodedScAddress = PhoneNumberUtils.networkPortionToCalledPartyBCDWithLength(scAddress);
        }
        if (statusReportRequested) {
            mtiByte = (byte) (mtiByte | 32);
        }
        bo.write(mtiByte);
        bo.write(0);
        byte[] daBytes = PhoneNumberUtils.networkPortionToCalledPartyBCD(destinationAddress);
        int length = (daBytes.length - 1) * 2;
        if ((daBytes[daBytes.length - 1] & CallFailCause.CALL_BARRED) == CallFailCause.CALL_BARRED) {
            i = 1;
        } else {
            i = 0;
        }
        bo.write(length - i);
        bo.write(daBytes, 0, daBytes.length);
        bo.write(0);
        return bo;
    }

    public static TextEncodingDetails calculateLength(CharSequence msgBody, boolean use7bitOnly) {
        CharSequence newMsgBody = null;
        if (Resources.getSystem().getBoolean(17957008)) {
            newMsgBody = Sms7BitEncodingTranslator.translate(msgBody);
        }
        if (TextUtils.isEmpty(newMsgBody)) {
            newMsgBody = msgBody;
        }
        TextEncodingDetails ted = GsmAlphabet.countGsmSeptets(newMsgBody, use7bitOnly);
        if (ted == null) {
            ted = new TextEncodingDetails();
            int octets = newMsgBody.length() * 2;
            ted.codeUnitCount = newMsgBody.length();
            if (octets > PduPart.P_DEP_COMMENT) {
                int max_user_data_bytes_with_header = PduPart.P_DEP_FILENAME;
                if (!android.telephony.SmsMessage.hasEmsSupport() && octets <= 1188) {
                    max_user_data_bytes_with_header = PduPart.P_DEP_FILENAME - 2;
                }
                ted.msgCount = ((max_user_data_bytes_with_header - 1) + octets) / max_user_data_bytes_with_header;
                ted.codeUnitsRemaining = ((ted.msgCount * max_user_data_bytes_with_header) - octets) / 2;
            } else {
                ted.msgCount = 1;
                ted.codeUnitsRemaining = (140 - octets) / 2;
            }
            ted.codeUnitSize = 3;
        }
        return ted;
    }

    public int getProtocolIdentifier() {
        return this.mProtocolIdentifier;
    }

    int getDataCodingScheme() {
        return this.mDataCodingScheme;
    }

    public boolean isReplace() {
        return (this.mProtocolIdentifier & PduPart.P_CONTENT_ID) == 64 && (this.mProtocolIdentifier & 63) > 0 && (this.mProtocolIdentifier & 63) < 8;
    }

    public boolean isCphsMwiMessage() {
        return ((GsmSmsAddress) this.mOriginatingAddress).isCphsVoiceMessageClear() || ((GsmSmsAddress) this.mOriginatingAddress).isCphsVoiceMessageSet();
    }

    public boolean isMWIClearMessage() {
        if (this.mIsMwi && !this.mMwiSense) {
            return true;
        }
        boolean z = this.mOriginatingAddress != null && ((GsmSmsAddress) this.mOriginatingAddress).isCphsVoiceMessageClear();
        return z;
    }

    public boolean isMWISetMessage() {
        if (this.mIsMwi && this.mMwiSense) {
            return true;
        }
        boolean z = this.mOriginatingAddress != null && ((GsmSmsAddress) this.mOriginatingAddress).isCphsVoiceMessageSet();
        return z;
    }

    public boolean isMwiDontStore() {
        if (this.mIsMwi && this.mMwiDontStore) {
            return true;
        }
        if (isCphsMwiMessage() && " ".equals(getMessageBody())) {
            return true;
        }
        return false;
    }

    public int getStatus() {
        return this.mStatus;
    }

    public boolean isStatusReportMessage() {
        return this.mIsStatusReportMessage;
    }

    public boolean isReplyPathPresent() {
        return this.mReplyPathPresent;
    }

    private void parsePdu(byte[] pdu) {
        int firstByte;
        this.mPdu = pdu;
        PduParser p = new PduParser(pdu);
        this.mScAddress = p.getSCAddress();
        if (this.mScAddress != null) {
            firstByte = p.getByte();
            this.mMti = firstByte & 3;
        } else {
            firstByte = p.getByte();
            this.mMti = firstByte & 3;
        }
        switch (this.mMti) {
            case CharacterSets.ANY_CHARSET /*0*/:
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                parseSmsDeliver(p, firstByte);
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                parseSmsSubmit(p, firstByte);
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                parseSmsStatusReport(p, firstByte);
            default:
                throw new RuntimeException("Unsupported message type");
        }
    }

    private void parseSmsStatusReport(PduParser p, int firstByte) {
        boolean hasUserDataHeader = true;
        this.mIsStatusReportMessage = true;
        this.mMessageRef = p.getByte();
        this.mRecipientAddress = p.getAddress();
        this.mScTimeMillis = p.getSCTimestampMillis();
        p.getSCTimestampMillis();
        this.mStatus = p.getByte();
        if (p.moreDataPresent()) {
            int extraParams = p.getByte();
            int moreExtraParams = extraParams;
            while ((moreExtraParams & PduPart.P_Q) != 0) {
                moreExtraParams = p.getByte();
            }
            if ((extraParams & 120) == 0) {
                if ((extraParams & 1) != 0) {
                    this.mProtocolIdentifier = p.getByte();
                }
                if ((extraParams & 2) != 0) {
                    this.mDataCodingScheme = p.getByte();
                }
                if ((extraParams & 4) != 0) {
                    if ((firstByte & 64) != 64) {
                        hasUserDataHeader = false;
                    }
                    parseUserData(p, hasUserDataHeader);
                }
            }
        }
    }

    private void parseSmsDeliver(PduParser p, int firstByte) {
        boolean z;
        if ((firstByte & PduPart.P_Q) == PduPart.P_Q) {
            z = true;
        } else {
            z = false;
        }
        this.mReplyPathPresent = z;
        this.mOriginatingAddress = p.getAddress();
        if (this.mOriginatingAddress != null) {
            this.mProtocolIdentifier = p.getByte();
            this.mDataCodingScheme = p.getByte();
            this.mScTimeMillis = p.getSCTimestampMillis();
        } else {
            this.mProtocolIdentifier = p.getByte();
            this.mDataCodingScheme = p.getByte();
            this.mScTimeMillis = p.getSCTimestampMillis();
        }
        parseUserData(p, (firstByte & 64) == 64);
    }

    private void parseSmsSubmit(PduParser p, int firstByte) {
        boolean z;
        int validityPeriodFormat;
        int validityPeriodLength;
        boolean hasUserDataHeader;
        if ((firstByte & PduPart.P_Q) == PduPart.P_Q) {
            z = true;
        } else {
            z = false;
        }
        this.mReplyPathPresent = z;
        this.mMessageRef = p.getByte();
        this.mRecipientAddress = p.getAddress();
        if (this.mRecipientAddress != null) {
            this.mProtocolIdentifier = p.getByte();
            this.mDataCodingScheme = p.getByte();
            validityPeriodFormat = (firstByte >> 3) & 3;
        } else {
            this.mProtocolIdentifier = p.getByte();
            this.mDataCodingScheme = p.getByte();
            validityPeriodFormat = (firstByte >> 3) & 3;
        }
        if (validityPeriodFormat == 0) {
            validityPeriodLength = 0;
        } else if (2 == validityPeriodFormat) {
            validityPeriodLength = 1;
        } else {
            validityPeriodLength = 7;
        }
        while (true) {
            int validityPeriodLength2 = validityPeriodLength - 1;
            if (validityPeriodLength <= 0) {
                break;
            }
            p.getByte();
            validityPeriodLength = validityPeriodLength2;
        }
        if ((firstByte & 64) == 64) {
            hasUserDataHeader = true;
        } else {
            hasUserDataHeader = false;
        }
        parseUserData(p, hasUserDataHeader);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void parseUserData(com.android.internal.telephony.gsm.SmsMessage.PduParser r13, boolean r14) {
        /*
        r12 = this;
        r3 = 0;
        r8 = 0;
        r2 = 0;
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 128;
        if (r9 != 0) goto L_0x0101;
    L_0x0009:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 32;
        if (r9 == 0) goto L_0x00bb;
    L_0x000f:
        r8 = 1;
    L_0x0010:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 16;
        if (r9 == 0) goto L_0x00be;
    L_0x0016:
        r3 = 1;
    L_0x0017:
        if (r8 == 0) goto L_0x00c1;
    L_0x0019:
        r9 = "SmsMessage";
        r10 = new java.lang.StringBuilder;
        r10.<init>();
        r11 = "4 - Unsupported SMS data coding scheme (compression) ";
        r10 = r10.append(r11);
        r11 = r12.mDataCodingScheme;
        r11 = r11 & 255;
        r10 = r10.append(r11);
        r10 = r10.toString();
        android.telephony.Rlog.w(r9, r10);
    L_0x0035:
        r9 = 1;
        if (r2 != r9) goto L_0x020c;
    L_0x0038:
        r9 = 1;
    L_0x0039:
        r1 = r13.constructUserData(r14, r9);
        r9 = r13.getUserData();
        r12.mUserData = r9;
        r9 = r13.getUserDataHeader();
        r12.mUserDataHeader = r9;
        if (r14 == 0) goto L_0x024d;
    L_0x004b:
        r9 = r12.mUserDataHeader;
        r9 = r9.specialSmsMsgList;
        r9 = r9.size();
        if (r9 == 0) goto L_0x024d;
    L_0x0055:
        r9 = r12.mUserDataHeader;
        r9 = r9.specialSmsMsgList;
        r4 = r9.iterator();
    L_0x005d:
        r9 = r4.hasNext();
        if (r9 == 0) goto L_0x024d;
    L_0x0063:
        r5 = r4.next();
        r5 = (com.android.internal.telephony.SmsHeader.SpecialSmsMsg) r5;
        r9 = r5.msgIndType;
        r6 = r9 & 255;
        if (r6 == 0) goto L_0x0073;
    L_0x006f:
        r9 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
        if (r6 != r9) goto L_0x0233;
    L_0x0073:
        r9 = 1;
        r12.mIsMwi = r9;
        r9 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
        if (r6 != r9) goto L_0x020f;
    L_0x007a:
        r9 = 0;
        r12.mMwiDontStore = r9;
    L_0x007d:
        r9 = r5.msgCount;
        r9 = r9 & 255;
        r12.mVoiceMailCount = r9;
        r9 = r12.mVoiceMailCount;
        if (r9 <= 0) goto L_0x022e;
    L_0x0087:
        r9 = 1;
        r12.mMwiSense = r9;
    L_0x008a:
        r9 = "SmsMessage";
        r10 = new java.lang.StringBuilder;
        r10.<init>();
        r11 = "MWI in TP-UDH for Vmail. Msg Ind = ";
        r10 = r10.append(r11);
        r10 = r10.append(r6);
        r11 = " Dont store = ";
        r10 = r10.append(r11);
        r11 = r12.mMwiDontStore;
        r10 = r10.append(r11);
        r11 = " Vmail count = ";
        r10 = r10.append(r11);
        r11 = r12.mVoiceMailCount;
        r10 = r10.append(r11);
        r10 = r10.toString();
        android.telephony.Rlog.w(r9, r10);
        goto L_0x005d;
    L_0x00bb:
        r8 = 0;
        goto L_0x0010;
    L_0x00be:
        r3 = 0;
        goto L_0x0017;
    L_0x00c1:
        r9 = r12.mDataCodingScheme;
        r9 = r9 >> 2;
        r9 = r9 & 3;
        switch(r9) {
            case 0: goto L_0x00cc;
            case 1: goto L_0x00d2;
            case 2: goto L_0x00cf;
            case 3: goto L_0x00e2;
            default: goto L_0x00ca;
        };
    L_0x00ca:
        goto L_0x0035;
    L_0x00cc:
        r2 = 1;
        goto L_0x0035;
    L_0x00cf:
        r2 = 3;
        goto L_0x0035;
    L_0x00d2:
        r7 = android.content.res.Resources.getSystem();
        r9 = 17957003; // 0x112008b float:2.6816354E-38 double:8.8719383E-317;
        r9 = r7.getBoolean(r9);
        if (r9 == 0) goto L_0x00e2;
    L_0x00df:
        r2 = 2;
        goto L_0x0035;
    L_0x00e2:
        r9 = "SmsMessage";
        r10 = new java.lang.StringBuilder;
        r10.<init>();
        r11 = "1 - Unsupported SMS data coding scheme ";
        r10 = r10.append(r11);
        r11 = r12.mDataCodingScheme;
        r11 = r11 & 255;
        r10 = r10.append(r11);
        r10 = r10.toString();
        android.telephony.Rlog.w(r9, r10);
        r2 = 2;
        goto L_0x0035;
    L_0x0101:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 240;
        r10 = 240; // 0xf0 float:3.36E-43 double:1.186E-321;
        if (r9 != r10) goto L_0x0117;
    L_0x0109:
        r3 = 1;
        r8 = 0;
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 4;
        if (r9 != 0) goto L_0x0114;
    L_0x0111:
        r2 = 1;
        goto L_0x0035;
    L_0x0114:
        r2 = 2;
        goto L_0x0035;
    L_0x0117:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 240;
        r10 = 192; // 0xc0 float:2.69E-43 double:9.5E-322;
        if (r9 == r10) goto L_0x012f;
    L_0x011f:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 240;
        r10 = 208; // 0xd0 float:2.91E-43 double:1.03E-321;
        if (r9 == r10) goto L_0x012f;
    L_0x0127:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 240;
        r10 = 224; // 0xe0 float:3.14E-43 double:1.107E-321;
        if (r9 != r10) goto L_0x01bf;
    L_0x012f:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 240;
        r10 = 224; // 0xe0 float:3.14E-43 double:1.107E-321;
        if (r9 != r10) goto L_0x0194;
    L_0x0137:
        r2 = 3;
    L_0x0138:
        r8 = 0;
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 8;
        r10 = 8;
        if (r9 != r10) goto L_0x0196;
    L_0x0141:
        r0 = 1;
    L_0x0142:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 3;
        if (r9 != 0) goto L_0x019e;
    L_0x0148:
        r9 = 1;
        r12.mIsMwi = r9;
        r12.mMwiSense = r0;
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 240;
        r10 = 192; // 0xc0 float:2.69E-43 double:9.5E-322;
        if (r9 != r10) goto L_0x0198;
    L_0x0155:
        r9 = 1;
    L_0x0156:
        r12.mMwiDontStore = r9;
        r9 = 1;
        if (r0 != r9) goto L_0x019a;
    L_0x015b:
        r9 = -1;
        r12.mVoiceMailCount = r9;
    L_0x015e:
        r9 = "SmsMessage";
        r10 = new java.lang.StringBuilder;
        r10.<init>();
        r11 = "MWI in DCS for Vmail. DCS = ";
        r10 = r10.append(r11);
        r11 = r12.mDataCodingScheme;
        r11 = r11 & 255;
        r10 = r10.append(r11);
        r11 = " Dont store = ";
        r10 = r10.append(r11);
        r11 = r12.mMwiDontStore;
        r10 = r10.append(r11);
        r11 = " vmail count = ";
        r10 = r10.append(r11);
        r11 = r12.mVoiceMailCount;
        r10 = r10.append(r11);
        r10 = r10.toString();
        android.telephony.Rlog.w(r9, r10);
        goto L_0x0035;
    L_0x0194:
        r2 = 1;
        goto L_0x0138;
    L_0x0196:
        r0 = 0;
        goto L_0x0142;
    L_0x0198:
        r9 = 0;
        goto L_0x0156;
    L_0x019a:
        r9 = 0;
        r12.mVoiceMailCount = r9;
        goto L_0x015e;
    L_0x019e:
        r9 = 0;
        r12.mIsMwi = r9;
        r9 = "SmsMessage";
        r10 = new java.lang.StringBuilder;
        r10.<init>();
        r11 = "MWI in DCS for fax/email/other: ";
        r10 = r10.append(r11);
        r11 = r12.mDataCodingScheme;
        r11 = r11 & 255;
        r10 = r10.append(r11);
        r10 = r10.toString();
        android.telephony.Rlog.w(r9, r10);
        goto L_0x0035;
    L_0x01bf:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 192;
        r10 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
        if (r9 != r10) goto L_0x01ee;
    L_0x01c7:
        r9 = r12.mDataCodingScheme;
        r10 = 132; // 0x84 float:1.85E-43 double:6.5E-322;
        if (r9 != r10) goto L_0x01d0;
    L_0x01cd:
        r2 = 4;
        goto L_0x0035;
    L_0x01d0:
        r9 = "SmsMessage";
        r10 = new java.lang.StringBuilder;
        r10.<init>();
        r11 = "5 - Unsupported SMS data coding scheme ";
        r10 = r10.append(r11);
        r11 = r12.mDataCodingScheme;
        r11 = r11 & 255;
        r10 = r10.append(r11);
        r10 = r10.toString();
        android.telephony.Rlog.w(r9, r10);
        goto L_0x0035;
    L_0x01ee:
        r9 = "SmsMessage";
        r10 = new java.lang.StringBuilder;
        r10.<init>();
        r11 = "3 - Unsupported SMS data coding scheme ";
        r10 = r10.append(r11);
        r11 = r12.mDataCodingScheme;
        r11 = r11 & 255;
        r10 = r10.append(r11);
        r10 = r10.toString();
        android.telephony.Rlog.w(r9, r10);
        goto L_0x0035;
    L_0x020c:
        r9 = 0;
        goto L_0x0039;
    L_0x020f:
        r9 = r12.mMwiDontStore;
        if (r9 != 0) goto L_0x007d;
    L_0x0213:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 240;
        r10 = 208; // 0xd0 float:2.91E-43 double:1.03E-321;
        if (r9 == r10) goto L_0x0223;
    L_0x021b:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 240;
        r10 = 224; // 0xe0 float:3.14E-43 double:1.107E-321;
        if (r9 != r10) goto L_0x0229;
    L_0x0223:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 3;
        if (r9 == 0) goto L_0x007d;
    L_0x0229:
        r9 = 1;
        r12.mMwiDontStore = r9;
        goto L_0x007d;
    L_0x022e:
        r9 = 0;
        r12.mMwiSense = r9;
        goto L_0x008a;
    L_0x0233:
        r9 = "SmsMessage";
        r10 = new java.lang.StringBuilder;
        r10.<init>();
        r11 = "TP_UDH fax/email/extended msg/multisubscriber profile. Msg Ind = ";
        r10 = r10.append(r11);
        r10 = r10.append(r6);
        r10 = r10.toString();
        android.telephony.Rlog.w(r9, r10);
        goto L_0x005d;
    L_0x024d:
        switch(r2) {
            case 0: goto L_0x025e;
            case 1: goto L_0x027a;
            case 2: goto L_0x0262;
            case 3: goto L_0x0293;
            case 4: goto L_0x029a;
            default: goto L_0x0250;
        };
    L_0x0250:
        r9 = r12.mMessageBody;
        if (r9 == 0) goto L_0x0257;
    L_0x0254:
        r12.parseMessageBody();
    L_0x0257:
        if (r3 != 0) goto L_0x02a1;
    L_0x0259:
        r9 = com.android.internal.telephony.SmsConstants.MessageClass.UNKNOWN;
        r12.messageClass = r9;
    L_0x025d:
        return;
    L_0x025e:
        r9 = 0;
        r12.mMessageBody = r9;
        goto L_0x0250;
    L_0x0262:
        r7 = android.content.res.Resources.getSystem();
        r9 = 17957003; // 0x112008b float:2.6816354E-38 double:8.8719383E-317;
        r9 = r7.getBoolean(r9);
        if (r9 == 0) goto L_0x0276;
    L_0x026f:
        r9 = r13.getUserDataGSM8bit(r1);
        r12.mMessageBody = r9;
        goto L_0x0250;
    L_0x0276:
        r9 = 0;
        r12.mMessageBody = r9;
        goto L_0x0250;
    L_0x027a:
        if (r14 == 0) goto L_0x028e;
    L_0x027c:
        r9 = r12.mUserDataHeader;
        r9 = r9.languageTable;
        r10 = r9;
    L_0x0281:
        if (r14 == 0) goto L_0x0291;
    L_0x0283:
        r9 = r12.mUserDataHeader;
        r9 = r9.languageShiftTable;
    L_0x0287:
        r9 = r13.getUserDataGSM7Bit(r1, r10, r9);
        r12.mMessageBody = r9;
        goto L_0x0250;
    L_0x028e:
        r9 = 0;
        r10 = r9;
        goto L_0x0281;
    L_0x0291:
        r9 = 0;
        goto L_0x0287;
    L_0x0293:
        r9 = r13.getUserDataUCS2(r1);
        r12.mMessageBody = r9;
        goto L_0x0250;
    L_0x029a:
        r9 = r13.getUserDataKSC5601(r1);
        r12.mMessageBody = r9;
        goto L_0x0250;
    L_0x02a1:
        r9 = r12.mDataCodingScheme;
        r9 = r9 & 3;
        switch(r9) {
            case 0: goto L_0x02a9;
            case 1: goto L_0x02ae;
            case 2: goto L_0x02b3;
            case 3: goto L_0x02b8;
            default: goto L_0x02a8;
        };
    L_0x02a8:
        goto L_0x025d;
    L_0x02a9:
        r9 = com.android.internal.telephony.SmsConstants.MessageClass.CLASS_0;
        r12.messageClass = r9;
        goto L_0x025d;
    L_0x02ae:
        r9 = com.android.internal.telephony.SmsConstants.MessageClass.CLASS_1;
        r12.messageClass = r9;
        goto L_0x025d;
    L_0x02b3:
        r9 = com.android.internal.telephony.SmsConstants.MessageClass.CLASS_2;
        r12.messageClass = r9;
        goto L_0x025d;
    L_0x02b8:
        r9 = com.android.internal.telephony.SmsConstants.MessageClass.CLASS_3;
        r12.messageClass = r9;
        goto L_0x025d;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.gsm.SmsMessage.parseUserData(com.android.internal.telephony.gsm.SmsMessage$PduParser, boolean):void");
    }

    public MessageClass getMessageClass() {
        return this.messageClass;
    }

    boolean isUsimDataDownload() {
        return this.messageClass == MessageClass.CLASS_2 && (this.mProtocolIdentifier == 127 || this.mProtocolIdentifier == 124);
    }

    public int getNumOfVoicemails() {
        if (!this.mIsMwi && isCphsMwiMessage()) {
            if (this.mOriginatingAddress == null || !((GsmSmsAddress) this.mOriginatingAddress).isCphsVoiceMessageSet()) {
                this.mVoiceMailCount = 0;
            } else {
                this.mVoiceMailCount = PduHeaders.STORE_STATUS_ERROR_END;
            }
            Rlog.v(LOG_TAG, "CPHS voice mail message");
        }
        return this.mVoiceMailCount;
    }
}
