package android.location;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;
import android.widget.Toast;

public class GpsClock implements Parcelable {
    public static final Creator<GpsClock> CREATOR;
    private static final short HAS_BIAS = (short) 8;
    private static final short HAS_BIAS_UNCERTAINTY = (short) 16;
    private static final short HAS_DRIFT = (short) 32;
    private static final short HAS_DRIFT_UNCERTAINTY = (short) 64;
    private static final short HAS_FULL_BIAS = (short) 4;
    private static final short HAS_LEAP_SECOND = (short) 1;
    private static final short HAS_NO_FLAGS = (short) 0;
    private static final short HAS_TIME_UNCERTAINTY = (short) 2;
    private static final String TAG = "GpsClock";
    public static final byte TYPE_GPS_TIME = (byte) 2;
    public static final byte TYPE_LOCAL_HW_TIME = (byte) 1;
    public static final byte TYPE_UNKNOWN = (byte) 0;
    private double mBiasInNs;
    private double mBiasUncertaintyInNs;
    private double mDriftInNsPerSec;
    private double mDriftUncertaintyInNsPerSec;
    private short mFlags;
    private long mFullBiasInNs;
    private short mLeapSecond;
    private long mTimeInNs;
    private double mTimeUncertaintyInNs;
    private byte mType;

    /* renamed from: android.location.GpsClock.1 */
    static class C03351 implements Creator<GpsClock> {
        C03351() {
        }

        public GpsClock createFromParcel(Parcel parcel) {
            GpsClock gpsClock = new GpsClock();
            gpsClock.mFlags = (short) parcel.readInt();
            gpsClock.mLeapSecond = (short) parcel.readInt();
            gpsClock.mType = parcel.readByte();
            gpsClock.mTimeInNs = parcel.readLong();
            gpsClock.mTimeUncertaintyInNs = parcel.readDouble();
            gpsClock.mFullBiasInNs = parcel.readLong();
            gpsClock.mBiasInNs = parcel.readDouble();
            gpsClock.mBiasUncertaintyInNs = parcel.readDouble();
            gpsClock.mDriftInNsPerSec = parcel.readDouble();
            gpsClock.mDriftUncertaintyInNsPerSec = parcel.readDouble();
            return gpsClock;
        }

        public GpsClock[] newArray(int size) {
            return new GpsClock[size];
        }
    }

    GpsClock() {
        initialize();
    }

    public void set(GpsClock clock) {
        this.mFlags = clock.mFlags;
        this.mLeapSecond = clock.mLeapSecond;
        this.mType = clock.mType;
        this.mTimeInNs = clock.mTimeInNs;
        this.mTimeUncertaintyInNs = clock.mTimeUncertaintyInNs;
        this.mFullBiasInNs = clock.mFullBiasInNs;
        this.mBiasInNs = clock.mBiasInNs;
        this.mBiasUncertaintyInNs = clock.mBiasUncertaintyInNs;
        this.mDriftInNsPerSec = clock.mDriftInNsPerSec;
        this.mDriftUncertaintyInNsPerSec = clock.mDriftUncertaintyInNsPerSec;
    }

    public void reset() {
        initialize();
    }

    public byte getType() {
        return this.mType;
    }

    public void setType(byte value) {
        switch (value) {
            case Toast.LENGTH_SHORT /*0*/:
            case Toast.LENGTH_LONG /*1*/:
            case Action.MERGE_IGNORE /*2*/:
                this.mType = value;
            default:
                Log.d(TAG, "Sanitizing invalid 'type': " + value);
                this.mType = (byte) 0;
        }
    }

    private String getTypeString() {
        switch (this.mType) {
            case Toast.LENGTH_SHORT /*0*/:
                return "Unknown";
            case Toast.LENGTH_LONG /*1*/:
                return "LocalHwClock";
            case Action.MERGE_IGNORE /*2*/:
                return "GpsTime";
            default:
                return "<Invalid>";
        }
    }

    public boolean hasLeapSecond() {
        return isFlagSet(HAS_LEAP_SECOND);
    }

    public short getLeapSecond() {
        return this.mLeapSecond;
    }

    public void setLeapSecond(short leapSecond) {
        setFlag(HAS_LEAP_SECOND);
        this.mLeapSecond = leapSecond;
    }

    public void resetLeapSecond() {
        resetFlag(HAS_LEAP_SECOND);
        this.mLeapSecond = Short.MIN_VALUE;
    }

    public long getTimeInNs() {
        return this.mTimeInNs;
    }

    public void setTimeInNs(long timeInNs) {
        this.mTimeInNs = timeInNs;
    }

    public boolean hasTimeUncertaintyInNs() {
        return isFlagSet(HAS_TIME_UNCERTAINTY);
    }

    public double getTimeUncertaintyInNs() {
        return this.mTimeUncertaintyInNs;
    }

    public void setTimeUncertaintyInNs(double timeUncertaintyInNs) {
        setFlag(HAS_TIME_UNCERTAINTY);
        this.mTimeUncertaintyInNs = timeUncertaintyInNs;
    }

    public void resetTimeUncertaintyInNs() {
        resetFlag(HAS_TIME_UNCERTAINTY);
        this.mTimeUncertaintyInNs = Double.NaN;
    }

    public boolean hasFullBiasInNs() {
        return isFlagSet(HAS_FULL_BIAS);
    }

    public long getFullBiasInNs() {
        return this.mFullBiasInNs;
    }

    public void setFullBiasInNs(long value) {
        setFlag(HAS_FULL_BIAS);
        this.mFullBiasInNs = value;
    }

    public void resetFullBiasInNs() {
        resetFlag(HAS_FULL_BIAS);
        this.mFullBiasInNs = Long.MIN_VALUE;
    }

    public boolean hasBiasInNs() {
        return isFlagSet(HAS_BIAS);
    }

    public double getBiasInNs() {
        return this.mBiasInNs;
    }

    public void setBiasInNs(double biasInNs) {
        setFlag(HAS_BIAS);
        this.mBiasInNs = biasInNs;
    }

    public void resetBiasInNs() {
        resetFlag(HAS_BIAS);
        this.mBiasInNs = Double.NaN;
    }

    public boolean hasBiasUncertaintyInNs() {
        return isFlagSet(HAS_BIAS_UNCERTAINTY);
    }

    public double getBiasUncertaintyInNs() {
        return this.mBiasUncertaintyInNs;
    }

    public void setBiasUncertaintyInNs(double biasUncertaintyInNs) {
        setFlag(HAS_BIAS_UNCERTAINTY);
        this.mBiasUncertaintyInNs = biasUncertaintyInNs;
    }

    public void resetBiasUncertaintyInNs() {
        resetFlag(HAS_BIAS_UNCERTAINTY);
        this.mBiasUncertaintyInNs = Double.NaN;
    }

    public boolean hasDriftInNsPerSec() {
        return isFlagSet(HAS_DRIFT);
    }

    public double getDriftInNsPerSec() {
        return this.mDriftInNsPerSec;
    }

    public void setDriftInNsPerSec(double driftInNsPerSec) {
        setFlag(HAS_DRIFT);
        this.mDriftInNsPerSec = driftInNsPerSec;
    }

    public void resetDriftInNsPerSec() {
        resetFlag(HAS_DRIFT);
        this.mDriftInNsPerSec = Double.NaN;
    }

    public boolean hasDriftUncertaintyInNsPerSec() {
        return isFlagSet(HAS_DRIFT_UNCERTAINTY);
    }

    public double getDriftUncertaintyInNsPerSec() {
        return this.mDriftUncertaintyInNsPerSec;
    }

    public void setDriftUncertaintyInNsPerSec(double driftUncertaintyInNsPerSec) {
        setFlag(HAS_DRIFT_UNCERTAINTY);
        this.mDriftUncertaintyInNsPerSec = driftUncertaintyInNsPerSec;
    }

    public void resetDriftUncertaintyInNsPerSec() {
        resetFlag(HAS_DRIFT_UNCERTAINTY);
        this.mDriftUncertaintyInNsPerSec = Double.NaN;
    }

    static {
        CREATOR = new C03351();
    }

    public void writeToParcel(Parcel parcel, int flags) {
        parcel.writeInt(this.mFlags);
        parcel.writeInt(this.mLeapSecond);
        parcel.writeByte(this.mType);
        parcel.writeLong(this.mTimeInNs);
        parcel.writeDouble(this.mTimeUncertaintyInNs);
        parcel.writeLong(this.mFullBiasInNs);
        parcel.writeDouble(this.mBiasInNs);
        parcel.writeDouble(this.mBiasUncertaintyInNs);
        parcel.writeDouble(this.mDriftInNsPerSec);
        parcel.writeDouble(this.mDriftUncertaintyInNsPerSec);
    }

    public int describeContents() {
        return 0;
    }

    public String toString() {
        Double valueOf;
        Long valueOf2;
        Double d = null;
        String format = "   %-15s = %s\n";
        String formatWithUncertainty = "   %-15s = %-25s   %-26s = %s\n";
        StringBuilder builder = new StringBuilder("GpsClock:\n");
        builder.append(String.format("   %-15s = %s\n", new Object[]{"Type", getTypeString()}));
        String str = "   %-15s = %s\n";
        Object[] objArr = new Object[2];
        objArr[0] = "LeapSecond";
        objArr[1] = hasLeapSecond() ? Short.valueOf(this.mLeapSecond) : null;
        builder.append(String.format(str, objArr));
        str = "   %-15s = %-25s   %-26s = %s\n";
        objArr = new Object[4];
        objArr[0] = "TimeInNs";
        objArr[1] = Long.valueOf(this.mTimeInNs);
        objArr[2] = "TimeUncertaintyInNs";
        if (hasTimeUncertaintyInNs()) {
            valueOf = Double.valueOf(this.mTimeUncertaintyInNs);
        } else {
            valueOf = null;
        }
        objArr[3] = valueOf;
        builder.append(String.format(str, objArr));
        str = "   %-15s = %s\n";
        objArr = new Object[2];
        objArr[0] = "FullBiasInNs";
        if (hasFullBiasInNs()) {
            valueOf2 = Long.valueOf(this.mFullBiasInNs);
        } else {
            valueOf2 = null;
        }
        objArr[1] = valueOf2;
        builder.append(String.format(str, objArr));
        str = "   %-15s = %-25s   %-26s = %s\n";
        objArr = new Object[4];
        objArr[0] = "BiasInNs";
        if (hasBiasInNs()) {
            valueOf = Double.valueOf(this.mBiasInNs);
        } else {
            valueOf = null;
        }
        objArr[1] = valueOf;
        objArr[2] = "BiasUncertaintyInNs";
        objArr[3] = hasBiasUncertaintyInNs() ? Double.valueOf(this.mBiasUncertaintyInNs) : null;
        builder.append(String.format(str, objArr));
        str = "   %-15s = %-25s   %-26s = %s\n";
        objArr = new Object[4];
        objArr[0] = "DriftInNsPerSec";
        if (hasDriftInNsPerSec()) {
            valueOf = Double.valueOf(this.mDriftInNsPerSec);
        } else {
            valueOf = null;
        }
        objArr[1] = valueOf;
        objArr[2] = "DriftUncertaintyInNsPerSec";
        if (hasDriftUncertaintyInNsPerSec()) {
            d = Double.valueOf(this.mDriftUncertaintyInNsPerSec);
        }
        objArr[3] = d;
        builder.append(String.format(str, objArr));
        return builder.toString();
    }

    private void initialize() {
        this.mFlags = HAS_NO_FLAGS;
        resetLeapSecond();
        setType((byte) 0);
        setTimeInNs(Long.MIN_VALUE);
        resetTimeUncertaintyInNs();
        resetFullBiasInNs();
        resetBiasInNs();
        resetBiasUncertaintyInNs();
        resetDriftInNsPerSec();
        resetDriftUncertaintyInNsPerSec();
    }

    private void setFlag(short flag) {
        this.mFlags = (short) (this.mFlags | flag);
    }

    private void resetFlag(short flag) {
        this.mFlags = (short) (this.mFlags & (flag ^ -1));
    }

    private boolean isFlagSet(short flag) {
        return (this.mFlags & flag) == flag;
    }
}
