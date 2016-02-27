package android.os;

import android.os.Parcelable.Creator;

public class BatteryProperty implements Parcelable {
    public static final Creator<BatteryProperty> CREATOR;
    private long mValueLong;

    /* renamed from: android.os.BatteryProperty.1 */
    static class C05791 implements Creator<BatteryProperty> {
        C05791() {
        }

        public BatteryProperty createFromParcel(Parcel p) {
            return new BatteryProperty(null);
        }

        public BatteryProperty[] newArray(int size) {
            return new BatteryProperty[size];
        }
    }

    public BatteryProperty() {
        this.mValueLong = Long.MIN_VALUE;
    }

    public long getLong() {
        return this.mValueLong;
    }

    private BatteryProperty(Parcel p) {
        readFromParcel(p);
    }

    public void readFromParcel(Parcel p) {
        this.mValueLong = p.readLong();
    }

    public void writeToParcel(Parcel p, int flags) {
        p.writeLong(this.mValueLong);
    }

    static {
        CREATOR = new C05791();
    }

    public int describeContents() {
        return 0;
    }
}
