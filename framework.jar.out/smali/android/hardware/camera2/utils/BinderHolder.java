package android.hardware.camera2.utils;

import android.os.IBinder;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class BinderHolder implements Parcelable {
    public static final Creator<BinderHolder> CREATOR;
    private IBinder mBinder;

    /* renamed from: android.hardware.camera2.utils.BinderHolder.1 */
    static class C02721 implements Creator<BinderHolder> {
        C02721() {
        }

        public BinderHolder createFromParcel(Parcel in) {
            return new BinderHolder(null);
        }

        public BinderHolder[] newArray(int size) {
            return new BinderHolder[size];
        }
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeStrongBinder(this.mBinder);
    }

    public void readFromParcel(Parcel src) {
        this.mBinder = src.readStrongBinder();
    }

    static {
        CREATOR = new C02721();
    }

    public IBinder getBinder() {
        return this.mBinder;
    }

    public void setBinder(IBinder binder) {
        this.mBinder = binder;
    }

    public BinderHolder() {
        this.mBinder = null;
    }

    public BinderHolder(IBinder binder) {
        this.mBinder = null;
        this.mBinder = binder;
    }

    private BinderHolder(Parcel in) {
        this.mBinder = null;
        this.mBinder = in.readStrongBinder();
    }
}
