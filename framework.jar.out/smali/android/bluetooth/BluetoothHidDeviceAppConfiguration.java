package android.bluetooth;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.Random;

public final class BluetoothHidDeviceAppConfiguration implements Parcelable {
    public static final Creator<BluetoothHidDeviceAppConfiguration> CREATOR;
    private final long mHash;

    /* renamed from: android.bluetooth.BluetoothHidDeviceAppConfiguration.1 */
    static class C00591 implements Creator<BluetoothHidDeviceAppConfiguration> {
        C00591() {
        }

        public BluetoothHidDeviceAppConfiguration createFromParcel(Parcel in) {
            return new BluetoothHidDeviceAppConfiguration(in.readLong());
        }

        public BluetoothHidDeviceAppConfiguration[] newArray(int size) {
            return new BluetoothHidDeviceAppConfiguration[size];
        }
    }

    BluetoothHidDeviceAppConfiguration() {
        this.mHash = new Random().nextLong();
    }

    BluetoothHidDeviceAppConfiguration(long hash) {
        this.mHash = hash;
    }

    public boolean equals(Object o) {
        if (!(o instanceof BluetoothHidDeviceAppConfiguration)) {
            return false;
        }
        if (this.mHash == ((BluetoothHidDeviceAppConfiguration) o).mHash) {
            return true;
        }
        return false;
    }

    public int describeContents() {
        return 0;
    }

    static {
        CREATOR = new C00591();
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeLong(this.mHash);
    }
}
