package android.hardware.camera2.utils;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class LongParcelable implements Parcelable {
    public static final Creator<LongParcelable> CREATOR;
    private long number;

    /* renamed from: android.hardware.camera2.utils.LongParcelable.1 */
    static class C02741 implements Creator<LongParcelable> {
        C02741() {
        }

        public LongParcelable createFromParcel(Parcel in) {
            return new LongParcelable(null);
        }

        public LongParcelable[] newArray(int size) {
            return new LongParcelable[size];
        }
    }

    public LongParcelable() {
        this.number = 0;
    }

    public LongParcelable(long number) {
        this.number = number;
    }

    static {
        CREATOR = new C02741();
    }

    private LongParcelable(Parcel in) {
        readFromParcel(in);
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeLong(this.number);
    }

    public void readFromParcel(Parcel in) {
        this.number = in.readLong();
    }

    public long getNumber() {
        return this.number;
    }

    public void setNumber(long number) {
        this.number = number;
    }
}
