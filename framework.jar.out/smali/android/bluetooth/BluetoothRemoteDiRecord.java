package android.bluetooth;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class BluetoothRemoteDiRecord implements Parcelable {
    public static final Creator<BluetoothRemoteDiRecord> CREATOR;
    private Object mObject;
    private int mProductId;
    private int mProductVersion;
    private int mSpecificationId;
    private int mVendorId;
    private int mVendorIdSource;

    /* renamed from: android.bluetooth.BluetoothRemoteDiRecord.1 */
    static class C00711 implements Creator<BluetoothRemoteDiRecord> {
        C00711() {
        }

        public BluetoothRemoteDiRecord createFromParcel(Parcel in) {
            return new BluetoothRemoteDiRecord(in.readInt(), in.readInt(), in.readInt(), in.readInt(), in.readInt());
        }

        public BluetoothRemoteDiRecord[] newArray(int size) {
            return new BluetoothRemoteDiRecord[size];
        }
    }

    public BluetoothRemoteDiRecord(int vendorId, int vendorIdSource, int productId, int productVersion, int specificationId) {
        this.mObject = new Object();
        this.mVendorId = vendorId;
        this.mVendorIdSource = vendorIdSource;
        this.mProductId = productId;
        this.mProductVersion = productVersion;
        this.mSpecificationId = specificationId;
    }

    public int getVendorId() {
        int i;
        synchronized (this.mObject) {
            i = this.mVendorId;
        }
        return i;
    }

    public int getVendorIdSource() {
        int i;
        synchronized (this.mObject) {
            i = this.mVendorIdSource;
        }
        return i;
    }

    public int getProductId() {
        int i;
        synchronized (this.mObject) {
            i = this.mProductId;
        }
        return i;
    }

    public int getProductVersion() {
        int i;
        synchronized (this.mObject) {
            i = this.mProductVersion;
        }
        return i;
    }

    public int getSpecificationId() {
        int i;
        synchronized (this.mObject) {
            i = this.mSpecificationId;
        }
        return i;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeInt(this.mVendorId);
        out.writeInt(this.mVendorIdSource);
        out.writeInt(this.mProductId);
        out.writeInt(this.mProductVersion);
        out.writeInt(this.mSpecificationId);
    }

    static {
        CREATOR = new C00711();
    }

    public int describeContents() {
        return 0;
    }
}
