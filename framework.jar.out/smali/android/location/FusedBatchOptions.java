package android.location;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class FusedBatchOptions implements Parcelable {
    public static final Creator<FusedBatchOptions> CREATOR;
    private volatile int mFlags;
    private volatile double mMaxPowerAllocationInMW;
    private volatile long mPeriodInNS;
    private volatile int mSourcesToUse;

    /* renamed from: android.location.FusedBatchOptions.1 */
    static class C03311 implements Creator<FusedBatchOptions> {
        C03311() {
        }

        public FusedBatchOptions createFromParcel(Parcel parcel) {
            FusedBatchOptions options = new FusedBatchOptions();
            options.setMaxPowerAllocationInMW(parcel.readDouble());
            options.setPeriodInNS(parcel.readLong());
            options.setSourceToUse(parcel.readInt());
            options.setFlag(parcel.readInt());
            return options;
        }

        public FusedBatchOptions[] newArray(int size) {
            return new FusedBatchOptions[size];
        }
    }

    public static final class BatchFlags {
        public static int CALLBACK_ON_LOCATION_FIX;
        public static int WAKEUP_ON_FIFO_FULL;

        static {
            WAKEUP_ON_FIFO_FULL = 1;
            CALLBACK_ON_LOCATION_FIX = 2;
        }
    }

    public static final class SourceTechnologies {
        public static int BLUETOOTH;
        public static int CELL;
        public static int GNSS;
        public static int SENSORS;
        public static int WIFI;

        static {
            GNSS = 1;
            WIFI = 2;
            SENSORS = 4;
            CELL = 8;
            BLUETOOTH = 16;
        }
    }

    public FusedBatchOptions() {
        this.mPeriodInNS = 0;
        this.mSourcesToUse = 0;
        this.mFlags = 0;
        this.mMaxPowerAllocationInMW = 0.0d;
    }

    public void setMaxPowerAllocationInMW(double value) {
        this.mMaxPowerAllocationInMW = value;
    }

    public double getMaxPowerAllocationInMW() {
        return this.mMaxPowerAllocationInMW;
    }

    public void setPeriodInNS(long value) {
        this.mPeriodInNS = value;
    }

    public long getPeriodInNS() {
        return this.mPeriodInNS;
    }

    public void setSourceToUse(int source) {
        this.mSourcesToUse |= source;
    }

    public void resetSourceToUse(int source) {
        this.mSourcesToUse &= source ^ -1;
    }

    public boolean isSourceToUseSet(int source) {
        return (this.mSourcesToUse & source) != 0;
    }

    public int getSourcesToUse() {
        return this.mSourcesToUse;
    }

    public void setFlag(int flag) {
        this.mFlags |= flag;
    }

    public void resetFlag(int flag) {
        this.mFlags &= flag ^ -1;
    }

    public boolean isFlagSet(int flag) {
        return (this.mFlags & flag) != 0;
    }

    public int getFlags() {
        return this.mFlags;
    }

    static {
        CREATOR = new C03311();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel parcel, int flags) {
        parcel.writeDouble(this.mMaxPowerAllocationInMW);
        parcel.writeLong(this.mPeriodInNS);
        parcel.writeInt(this.mSourcesToUse);
        parcel.writeInt(this.mFlags);
    }
}
