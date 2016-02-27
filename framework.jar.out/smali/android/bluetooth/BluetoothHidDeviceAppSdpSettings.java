package android.bluetooth;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class BluetoothHidDeviceAppSdpSettings implements Parcelable {
    public static final Creator<BluetoothHidDeviceAppSdpSettings> CREATOR;
    public final String description;
    public final byte[] descriptors;
    public final String name;
    public final String provider;
    public final byte subclass;

    /* renamed from: android.bluetooth.BluetoothHidDeviceAppSdpSettings.1 */
    static class C00611 implements Creator<BluetoothHidDeviceAppSdpSettings> {
        C00611() {
        }

        public BluetoothHidDeviceAppSdpSettings createFromParcel(Parcel in) {
            return new BluetoothHidDeviceAppSdpSettings(in.readString(), in.readString(), in.readString(), in.readByte(), in.createByteArray());
        }

        public BluetoothHidDeviceAppSdpSettings[] newArray(int size) {
            return new BluetoothHidDeviceAppSdpSettings[size];
        }
    }

    public BluetoothHidDeviceAppSdpSettings(String name, String description, String provider, byte subclass, byte[] descriptors) {
        this.name = name;
        this.description = description;
        this.provider = provider;
        this.subclass = subclass;
        this.descriptors = (byte[]) descriptors.clone();
    }

    public boolean equals(Object o) {
        if (o instanceof BluetoothHidDeviceAppSdpSettings) {
            BluetoothHidDeviceAppSdpSettings bluetoothHidDeviceAppSdpSettings = (BluetoothHidDeviceAppSdpSettings) o;
        }
        return false;
    }

    public int describeContents() {
        return 0;
    }

    static {
        CREATOR = new C00611();
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeString(this.name);
        out.writeString(this.description);
        out.writeString(this.provider);
        out.writeByte(this.subclass);
        out.writeByteArray(this.descriptors);
    }
}
