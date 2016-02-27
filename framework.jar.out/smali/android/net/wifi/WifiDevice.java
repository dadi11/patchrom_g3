package android.net.wifi;

import android.net.ProxyInfo;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class WifiDevice implements Parcelable {
    private static final String AP_STA_CONNECTED_STR = "AP-STA-CONNECTED";
    private static final String AP_STA_DISCONNECTED_STR = "AP-STA-DISCONNECTED";
    public static final int BLACKLISTED = 2;
    public static final int CONNECTED = 1;
    public static final Creator<WifiDevice> CREATOR;
    public static final int DISCONNECTED = 0;
    public String deviceAddress;
    public String deviceName;
    public int deviceState;

    /* renamed from: android.net.wifi.WifiDevice.1 */
    static class C05351 implements Creator<WifiDevice> {
        C05351() {
        }

        public WifiDevice createFromParcel(Parcel in) {
            WifiDevice device = new WifiDevice();
            device.deviceAddress = in.readString();
            device.deviceName = in.readString();
            device.deviceState = in.readInt();
            return device;
        }

        public WifiDevice[] newArray(int size) {
            return new WifiDevice[size];
        }
    }

    public WifiDevice() {
        this.deviceAddress = ProxyInfo.LOCAL_EXCL_LIST;
        this.deviceName = ProxyInfo.LOCAL_EXCL_LIST;
        this.deviceState = 0;
    }

    public WifiDevice(String dataString) throws IllegalArgumentException {
        this.deviceAddress = ProxyInfo.LOCAL_EXCL_LIST;
        this.deviceName = ProxyInfo.LOCAL_EXCL_LIST;
        this.deviceState = 0;
        String[] tokens = dataString.split(" ");
        if (tokens.length < BLACKLISTED) {
            throw new IllegalArgumentException();
        }
        if (tokens[0].indexOf(AP_STA_CONNECTED_STR) != -1) {
            this.deviceState = CONNECTED;
        } else if (tokens[0].indexOf(AP_STA_DISCONNECTED_STR) != -1) {
            this.deviceState = 0;
        } else {
            throw new IllegalArgumentException();
        }
        this.deviceAddress = tokens[CONNECTED];
    }

    public boolean equals(Object obj) {
        if (obj == null || !(obj instanceof WifiDevice)) {
            return false;
        }
        WifiDevice other = (WifiDevice) obj;
        if (this.deviceAddress != null) {
            return this.deviceAddress.equals(other.deviceAddress);
        }
        if (other.deviceAddress == null) {
            return true;
        }
        return false;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(this.deviceAddress);
        dest.writeString(this.deviceName);
        dest.writeInt(this.deviceState);
    }

    static {
        CREATOR = new C05351();
    }
}
