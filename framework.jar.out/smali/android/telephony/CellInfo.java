package android.telephony;

import android.net.LinkQualityInfo;
import android.os.Environment;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public abstract class CellInfo implements Parcelable {
    public static final Creator<CellInfo> CREATOR;
    public static final int TIMESTAMP_TYPE_ANTENNA = 1;
    public static final int TIMESTAMP_TYPE_JAVA_RIL = 4;
    public static final int TIMESTAMP_TYPE_MODEM = 2;
    public static final int TIMESTAMP_TYPE_OEM_RIL = 3;
    public static final int TIMESTAMP_TYPE_UNKNOWN = 0;
    protected static final int TYPE_CDMA = 2;
    protected static final int TYPE_GSM = 1;
    protected static final int TYPE_LTE = 3;
    protected static final int TYPE_WCDMA = 4;
    private boolean mRegistered;
    private long mTimeStamp;
    private int mTimeStampType;

    /* renamed from: android.telephony.CellInfo.1 */
    static class C07681 implements Creator<CellInfo> {
        C07681() {
        }

        public CellInfo createFromParcel(Parcel in) {
            switch (in.readInt()) {
                case CellInfo.TYPE_GSM /*1*/:
                    return CellInfoGsm.createFromParcelBody(in);
                case CellInfo.TYPE_CDMA /*2*/:
                    return CellInfoCdma.createFromParcelBody(in);
                case CellInfo.TYPE_LTE /*3*/:
                    return CellInfoLte.createFromParcelBody(in);
                case CellInfo.TYPE_WCDMA /*4*/:
                    return CellInfoWcdma.createFromParcelBody(in);
                default:
                    throw new RuntimeException("Bad CellInfo Parcel");
            }
        }

        public CellInfo[] newArray(int size) {
            return new CellInfo[size];
        }
    }

    public abstract void writeToParcel(Parcel parcel, int i);

    protected CellInfo() {
        this.mRegistered = false;
        this.mTimeStampType = TIMESTAMP_TYPE_UNKNOWN;
        this.mTimeStamp = LinkQualityInfo.UNKNOWN_LONG;
    }

    protected CellInfo(CellInfo ci) {
        this.mRegistered = ci.mRegistered;
        this.mTimeStampType = ci.mTimeStampType;
        this.mTimeStamp = ci.mTimeStamp;
    }

    public boolean isRegistered() {
        return this.mRegistered;
    }

    public void setRegistered(boolean registered) {
        this.mRegistered = registered;
    }

    public long getTimeStamp() {
        return this.mTimeStamp;
    }

    public void setTimeStamp(long timeStamp) {
        this.mTimeStamp = timeStamp;
    }

    public int getTimeStampType() {
        return this.mTimeStampType;
    }

    public void setTimeStampType(int timeStampType) {
        if (timeStampType < 0 || timeStampType > TYPE_WCDMA) {
            this.mTimeStampType = TIMESTAMP_TYPE_UNKNOWN;
        } else {
            this.mTimeStampType = timeStampType;
        }
    }

    public int hashCode() {
        return (((this.mRegistered ? TIMESTAMP_TYPE_UNKNOWN : TYPE_GSM) * 31) + (((int) (this.mTimeStamp / 1000)) * 31)) + (this.mTimeStampType * 31);
    }

    public boolean equals(Object other) {
        boolean z = true;
        if (other == null) {
            return false;
        }
        if (this == other) {
            return true;
        }
        try {
            CellInfo o = (CellInfo) other;
            if (!(this.mRegistered == o.mRegistered && this.mTimeStamp == o.mTimeStamp && this.mTimeStampType == o.mTimeStampType)) {
                z = false;
            }
            return z;
        } catch (ClassCastException e) {
            return false;
        }
    }

    private static String timeStampTypeToString(int type) {
        switch (type) {
            case TYPE_GSM /*1*/:
                return "antenna";
            case TYPE_CDMA /*2*/:
                return "modem";
            case TYPE_LTE /*3*/:
                return "oem_ril";
            case TYPE_WCDMA /*4*/:
                return "java_ril";
            default:
                return Environment.MEDIA_UNKNOWN;
        }
    }

    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("mRegistered=").append(this.mRegistered ? "YES" : "NO");
        sb.append(" mTimeStampType=").append(timeStampTypeToString(this.mTimeStampType));
        sb.append(" mTimeStamp=").append(this.mTimeStamp).append("ns");
        return sb.toString();
    }

    public int describeContents() {
        return TIMESTAMP_TYPE_UNKNOWN;
    }

    protected void writeToParcel(Parcel dest, int flags, int type) {
        dest.writeInt(type);
        dest.writeInt(this.mRegistered ? TYPE_GSM : TIMESTAMP_TYPE_UNKNOWN);
        dest.writeInt(this.mTimeStampType);
        dest.writeLong(this.mTimeStamp);
    }

    protected CellInfo(Parcel in) {
        boolean z = true;
        if (in.readInt() != TYPE_GSM) {
            z = false;
        }
        this.mRegistered = z;
        this.mTimeStampType = in.readInt();
        this.mTimeStamp = in.readLong();
    }

    static {
        CREATOR = new C07681();
    }
}
