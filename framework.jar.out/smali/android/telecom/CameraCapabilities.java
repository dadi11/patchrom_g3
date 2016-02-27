package android.telecom;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class CameraCapabilities implements Parcelable {
    public static final Creator<CameraCapabilities> CREATOR;
    private final int mHeight;
    private final float mMaxZoom;
    private final int mWidth;
    private final boolean mZoomSupported;

    /* renamed from: android.telecom.CameraCapabilities.1 */
    static class C07271 implements Creator<CameraCapabilities> {
        C07271() {
        }

        public CameraCapabilities createFromParcel(Parcel source) {
            return new CameraCapabilities(source.readByte() != null, source.readFloat(), source.readInt(), source.readInt());
        }

        public CameraCapabilities[] newArray(int size) {
            return new CameraCapabilities[size];
        }
    }

    public CameraCapabilities(boolean zoomSupported, float maxZoom, int width, int height) {
        this.mZoomSupported = zoomSupported;
        this.mMaxZoom = maxZoom;
        this.mWidth = width;
        this.mHeight = height;
    }

    static {
        CREATOR = new C07271();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeByte((byte) (isZoomSupported() ? 1 : 0));
        dest.writeFloat(getMaxZoom());
        dest.writeInt(getWidth());
        dest.writeInt(getHeight());
    }

    public boolean isZoomSupported() {
        return this.mZoomSupported;
    }

    public float getMaxZoom() {
        return this.mMaxZoom;
    }

    public int getWidth() {
        return this.mWidth;
    }

    public int getHeight() {
        return this.mHeight;
    }
}
