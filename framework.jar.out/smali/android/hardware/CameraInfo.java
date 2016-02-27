package android.hardware;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class CameraInfo implements Parcelable {
    public static final Creator<CameraInfo> CREATOR;
    public android.hardware.Camera.CameraInfo info;

    /* renamed from: android.hardware.CameraInfo.1 */
    static class C02071 implements Creator<CameraInfo> {
        C02071() {
        }

        public CameraInfo createFromParcel(Parcel in) {
            CameraInfo info = new CameraInfo();
            info.readFromParcel(in);
            return info;
        }

        public CameraInfo[] newArray(int size) {
            return new CameraInfo[size];
        }
    }

    public CameraInfo() {
        this.info = new android.hardware.Camera.CameraInfo();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeInt(this.info.facing);
        out.writeInt(this.info.orientation);
    }

    public void readFromParcel(Parcel in) {
        this.info.facing = in.readInt();
        this.info.orientation = in.readInt();
    }

    static {
        CREATOR = new C02071();
    }
}
