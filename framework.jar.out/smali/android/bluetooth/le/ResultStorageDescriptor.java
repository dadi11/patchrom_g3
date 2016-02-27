package android.bluetooth.le;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class ResultStorageDescriptor implements Parcelable {
    public static final Creator<ResultStorageDescriptor> CREATOR;
    private int mLength;
    private int mOffset;
    private int mType;

    /* renamed from: android.bluetooth.le.ResultStorageDescriptor.1 */
    static class C00841 implements Creator<ResultStorageDescriptor> {
        C00841() {
        }

        public ResultStorageDescriptor createFromParcel(Parcel source) {
            return new ResultStorageDescriptor(null);
        }

        public ResultStorageDescriptor[] newArray(int size) {
            return new ResultStorageDescriptor[size];
        }
    }

    public int getType() {
        return this.mType;
    }

    public int getOffset() {
        return this.mOffset;
    }

    public int getLength() {
        return this.mLength;
    }

    public ResultStorageDescriptor(int type, int offset, int length) {
        this.mType = type;
        this.mOffset = offset;
        this.mLength = length;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mType);
        dest.writeInt(this.mOffset);
        dest.writeInt(this.mLength);
    }

    private ResultStorageDescriptor(Parcel in) {
        ReadFromParcel(in);
    }

    private void ReadFromParcel(Parcel in) {
        this.mType = in.readInt();
        this.mOffset = in.readInt();
        this.mLength = in.readInt();
    }

    static {
        CREATOR = new C00841();
    }
}
