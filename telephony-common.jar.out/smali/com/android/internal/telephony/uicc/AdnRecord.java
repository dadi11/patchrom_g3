package com.android.internal.telephony.uicc;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.text.TextUtils;
import com.android.internal.telephony.GsmAlphabet;
import com.google.android.mms.pdu.PduHeaders;
import java.util.Arrays;

public class AdnRecord implements Parcelable {
    static final int ADN_BCD_NUMBER_LENGTH = 0;
    static final int ADN_CAPABILITY_ID = 12;
    static final int ADN_DIALING_NUMBER_END = 11;
    static final int ADN_DIALING_NUMBER_START = 2;
    static final int ADN_EXTENSION_ID = 13;
    static final int ADN_TON_AND_NPI = 1;
    public static final Creator<AdnRecord> CREATOR;
    static final int EXT_RECORD_LENGTH_BYTES = 13;
    static final int EXT_RECORD_TYPE_ADDITIONAL_DATA = 2;
    static final int EXT_RECORD_TYPE_MASK = 3;
    static final int FOOTER_SIZE_BYTES = 14;
    static final String LOG_TAG = "AdnRecord";
    static final int MAX_EXT_CALLED_PARTY_LENGTH = 10;
    static final int MAX_NUMBER_SIZE_BYTES = 11;
    String mAlphaTag;
    int mEfid;
    String[] mEmails;
    int mExtRecord;
    String mNumber;
    int mRecordNumber;

    /* renamed from: com.android.internal.telephony.uicc.AdnRecord.1 */
    static class C00831 implements Creator<AdnRecord> {
        C00831() {
        }

        public AdnRecord createFromParcel(Parcel source) {
            return new AdnRecord(source.readInt(), source.readInt(), source.readString(), source.readString(), source.readStringArray());
        }

        public AdnRecord[] newArray(int size) {
            return new AdnRecord[size];
        }
    }

    static {
        CREATOR = new C00831();
    }

    public AdnRecord(byte[] record) {
        this((int) ADN_BCD_NUMBER_LENGTH, (int) ADN_BCD_NUMBER_LENGTH, record);
    }

    public AdnRecord(int efid, int recordNumber, byte[] record) {
        this.mAlphaTag = null;
        this.mNumber = null;
        this.mExtRecord = PduHeaders.STORE_STATUS_ERROR_END;
        this.mEfid = efid;
        this.mRecordNumber = recordNumber;
        parseRecord(record);
    }

    public AdnRecord(String alphaTag, String number) {
        this(ADN_BCD_NUMBER_LENGTH, ADN_BCD_NUMBER_LENGTH, alphaTag, number);
    }

    public AdnRecord(String alphaTag, String number, String[] emails) {
        this(ADN_BCD_NUMBER_LENGTH, ADN_BCD_NUMBER_LENGTH, alphaTag, number, emails);
    }

    public AdnRecord(int efid, int recordNumber, String alphaTag, String number, String[] emails) {
        this.mAlphaTag = null;
        this.mNumber = null;
        this.mExtRecord = PduHeaders.STORE_STATUS_ERROR_END;
        this.mEfid = efid;
        this.mRecordNumber = recordNumber;
        this.mAlphaTag = alphaTag;
        this.mNumber = number;
        this.mEmails = emails;
    }

    public AdnRecord(int efid, int recordNumber, String alphaTag, String number) {
        this.mAlphaTag = null;
        this.mNumber = null;
        this.mExtRecord = PduHeaders.STORE_STATUS_ERROR_END;
        this.mEfid = efid;
        this.mRecordNumber = recordNumber;
        this.mAlphaTag = alphaTag;
        this.mNumber = number;
        this.mEmails = null;
    }

    public String getAlphaTag() {
        return this.mAlphaTag;
    }

    public String getNumber() {
        return this.mNumber;
    }

    public String[] getEmails() {
        return this.mEmails;
    }

    public void setEmails(String[] emails) {
        this.mEmails = emails;
    }

    public String toString() {
        return "ADN Record '" + this.mAlphaTag + "' '" + this.mNumber + " " + this.mEmails + "'";
    }

    public boolean isEmpty() {
        return TextUtils.isEmpty(this.mAlphaTag) && TextUtils.isEmpty(this.mNumber) && this.mEmails == null;
    }

    public boolean hasExtendedRecord() {
        return (this.mExtRecord == 0 || this.mExtRecord == PduHeaders.STORE_STATUS_ERROR_END) ? false : true;
    }

    private static boolean stringCompareNullEqualsEmpty(String s1, String s2) {
        if (s1 == s2) {
            return true;
        }
        if (s1 == null) {
            s1 = "";
        }
        if (s2 == null) {
            s2 = "";
        }
        return s1.equals(s2);
    }

    public boolean isEqual(AdnRecord adn) {
        return stringCompareNullEqualsEmpty(this.mAlphaTag, adn.mAlphaTag) && stringCompareNullEqualsEmpty(this.mNumber, adn.mNumber) && Arrays.equals(this.mEmails, adn.mEmails);
    }

    public int describeContents() {
        return ADN_BCD_NUMBER_LENGTH;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mEfid);
        dest.writeInt(this.mRecordNumber);
        dest.writeString(this.mAlphaTag);
        dest.writeString(this.mNumber);
        dest.writeStringArray(this.mEmails);
    }

    public byte[] buildAdnString(int recordSize) {
        int footerOffset = recordSize - 14;
        byte[] adnString = new byte[recordSize];
        for (int i = ADN_BCD_NUMBER_LENGTH; i < recordSize; i += ADN_TON_AND_NPI) {
            adnString[i] = (byte) -1;
        }
        if (TextUtils.isEmpty(this.mNumber)) {
            Rlog.w(LOG_TAG, "[buildAdnString] Empty dialing number");
            return adnString;
        } else if (this.mNumber.length() > 20) {
            Rlog.w(LOG_TAG, "[buildAdnString] Max length of dialing number is 20");
            return null;
        } else if (this.mAlphaTag == null || this.mAlphaTag.length() <= footerOffset) {
            byte[] bcdNumber = PhoneNumberUtils.numberToCalledPartyBCD(this.mNumber);
            System.arraycopy(bcdNumber, ADN_BCD_NUMBER_LENGTH, adnString, footerOffset + ADN_TON_AND_NPI, bcdNumber.length);
            adnString[footerOffset + ADN_BCD_NUMBER_LENGTH] = (byte) bcdNumber.length;
            adnString[footerOffset + ADN_CAPABILITY_ID] = (byte) -1;
            adnString[footerOffset + EXT_RECORD_LENGTH_BYTES] = (byte) -1;
            if (TextUtils.isEmpty(this.mAlphaTag)) {
                return adnString;
            }
            byte[] byteTag = GsmAlphabet.stringToGsm8BitPacked(this.mAlphaTag);
            System.arraycopy(byteTag, ADN_BCD_NUMBER_LENGTH, adnString, ADN_BCD_NUMBER_LENGTH, byteTag.length);
            return adnString;
        } else {
            Rlog.w(LOG_TAG, "[buildAdnString] Max length of tag is " + footerOffset);
            return null;
        }
    }

    public void appendExtRecord(byte[] extRecord) {
        try {
            if (extRecord.length == EXT_RECORD_LENGTH_BYTES && (extRecord[ADN_BCD_NUMBER_LENGTH] & EXT_RECORD_TYPE_MASK) == EXT_RECORD_TYPE_ADDITIONAL_DATA && (extRecord[ADN_TON_AND_NPI] & PduHeaders.STORE_STATUS_ERROR_END) <= MAX_EXT_CALLED_PARTY_LENGTH) {
                this.mNumber += PhoneNumberUtils.calledPartyBCDFragmentToString(extRecord, EXT_RECORD_TYPE_ADDITIONAL_DATA, extRecord[ADN_TON_AND_NPI] & PduHeaders.STORE_STATUS_ERROR_END);
            }
        } catch (RuntimeException ex) {
            Rlog.w(LOG_TAG, "Error parsing AdnRecord ext record", ex);
        }
    }

    private void parseRecord(byte[] record) {
        try {
            this.mAlphaTag = IccUtils.adnStringFieldToString(record, ADN_BCD_NUMBER_LENGTH, record.length - 14);
            int footerOffset = record.length - 14;
            int numberLength = record[footerOffset] & PduHeaders.STORE_STATUS_ERROR_END;
            if (numberLength > MAX_NUMBER_SIZE_BYTES) {
                this.mNumber = "";
                return;
            }
            this.mNumber = PhoneNumberUtils.calledPartyBCDToString(record, footerOffset + ADN_TON_AND_NPI, numberLength);
            this.mExtRecord = record[record.length - 1] & PduHeaders.STORE_STATUS_ERROR_END;
            this.mEmails = null;
        } catch (RuntimeException ex) {
            Rlog.w(LOG_TAG, "Error parsing AdnRecord", ex);
            this.mNumber = "";
            this.mAlphaTag = "";
            this.mEmails = null;
        }
    }
}
