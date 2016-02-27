package android.telephony;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.format.Time;
import com.android.internal.telephony.uicc.IccUtils;
import com.google.android.mms.pdu.CharacterSets;
import java.util.Arrays;

public class SmsCbEtwsInfo implements Parcelable {
    public static final Creator<SmsCbEtwsInfo> CREATOR;
    public static final int ETWS_WARNING_TYPE_EARTHQUAKE = 0;
    public static final int ETWS_WARNING_TYPE_EARTHQUAKE_AND_TSUNAMI = 2;
    public static final int ETWS_WARNING_TYPE_OTHER_EMERGENCY = 4;
    public static final int ETWS_WARNING_TYPE_TEST_MESSAGE = 3;
    public static final int ETWS_WARNING_TYPE_TSUNAMI = 1;
    public static final int ETWS_WARNING_TYPE_UNKNOWN = -1;
    private final boolean mActivatePopup;
    private final boolean mEmergencyUserAlert;
    private final byte[] mWarningSecurityInformation;
    private final int mWarningType;

    /* renamed from: android.telephony.SmsCbEtwsInfo.1 */
    static class C00031 implements Creator<SmsCbEtwsInfo> {
        C00031() {
        }

        public SmsCbEtwsInfo createFromParcel(Parcel in) {
            return new SmsCbEtwsInfo(in);
        }

        public SmsCbEtwsInfo[] newArray(int size) {
            return new SmsCbEtwsInfo[size];
        }
    }

    public SmsCbEtwsInfo(int warningType, boolean emergencyUserAlert, boolean activatePopup, byte[] warningSecurityInformation) {
        this.mWarningType = warningType;
        this.mEmergencyUserAlert = emergencyUserAlert;
        this.mActivatePopup = activatePopup;
        this.mWarningSecurityInformation = warningSecurityInformation;
    }

    SmsCbEtwsInfo(Parcel in) {
        boolean z;
        boolean z2 = true;
        this.mWarningType = in.readInt();
        if (in.readInt() != 0) {
            z = true;
        } else {
            z = false;
        }
        this.mEmergencyUserAlert = z;
        if (in.readInt() == 0) {
            z2 = false;
        }
        this.mActivatePopup = z2;
        this.mWarningSecurityInformation = in.createByteArray();
    }

    public void writeToParcel(Parcel dest, int flags) {
        int i;
        int i2 = ETWS_WARNING_TYPE_TSUNAMI;
        dest.writeInt(this.mWarningType);
        if (this.mEmergencyUserAlert) {
            i = ETWS_WARNING_TYPE_TSUNAMI;
        } else {
            i = ETWS_WARNING_TYPE_EARTHQUAKE;
        }
        dest.writeInt(i);
        if (!this.mActivatePopup) {
            i2 = ETWS_WARNING_TYPE_EARTHQUAKE;
        }
        dest.writeInt(i2);
        dest.writeByteArray(this.mWarningSecurityInformation);
    }

    public int getWarningType() {
        return this.mWarningType;
    }

    public boolean isEmergencyUserAlert() {
        return this.mEmergencyUserAlert;
    }

    public boolean isPopupAlert() {
        return this.mActivatePopup;
    }

    public long getPrimaryNotificationTimestamp() {
        if (this.mWarningSecurityInformation == null || this.mWarningSecurityInformation.length < 7) {
            return 0;
        }
        int year = IccUtils.gsmBcdByteToInt(this.mWarningSecurityInformation[ETWS_WARNING_TYPE_EARTHQUAKE]);
        int month = IccUtils.gsmBcdByteToInt(this.mWarningSecurityInformation[ETWS_WARNING_TYPE_TSUNAMI]);
        int day = IccUtils.gsmBcdByteToInt(this.mWarningSecurityInformation[ETWS_WARNING_TYPE_EARTHQUAKE_AND_TSUNAMI]);
        int hour = IccUtils.gsmBcdByteToInt(this.mWarningSecurityInformation[ETWS_WARNING_TYPE_TEST_MESSAGE]);
        int minute = IccUtils.gsmBcdByteToInt(this.mWarningSecurityInformation[ETWS_WARNING_TYPE_OTHER_EMERGENCY]);
        int second = IccUtils.gsmBcdByteToInt(this.mWarningSecurityInformation[5]);
        byte tzByte = this.mWarningSecurityInformation[6];
        int timezoneOffset = IccUtils.gsmBcdByteToInt((byte) (tzByte & -9));
        if ((tzByte & 8) != 0) {
            timezoneOffset = -timezoneOffset;
        }
        Time time = new Time("UTC");
        time.year = year + 2000;
        time.month = month + ETWS_WARNING_TYPE_UNKNOWN;
        time.monthDay = day;
        time.hour = hour;
        time.minute = minute;
        time.second = second;
        return time.toMillis(true) - ((long) (((timezoneOffset * 15) * 60) * CharacterSets.UCS2));
    }

    public byte[] getPrimaryNotificationSignature() {
        if (this.mWarningSecurityInformation == null || this.mWarningSecurityInformation.length < 50) {
            return null;
        }
        return Arrays.copyOfRange(this.mWarningSecurityInformation, 7, 50);
    }

    public String toString() {
        return "SmsCbEtwsInfo{warningType=" + this.mWarningType + ", emergencyUserAlert=" + this.mEmergencyUserAlert + ", activatePopup=" + this.mActivatePopup + '}';
    }

    public int describeContents() {
        return ETWS_WARNING_TYPE_EARTHQUAKE;
    }

    static {
        CREATOR = new C00031();
    }
}
