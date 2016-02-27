package android.net.wifi.p2p;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.Locale;

public class WifiP2pWfdInfo implements Parcelable {
    private static final int COUPLED_SINK_SUPPORT_AT_SINK = 8;
    private static final int COUPLED_SINK_SUPPORT_AT_SOURCE = 4;
    public static final Creator<WifiP2pWfdInfo> CREATOR;
    private static final int DEVICE_TYPE = 3;
    public static final int PRIMARY_SINK = 1;
    public static final int SECONDARY_SINK = 2;
    private static final int SESSION_AVAILABLE = 48;
    private static final int SESSION_AVAILABLE_BIT1 = 16;
    private static final int SESSION_AVAILABLE_BIT2 = 32;
    public static final int SOURCE_OR_PRIMARY_SINK = 3;
    private static final String TAG = "WifiP2pWfdInfo";
    public static final int WFD_SOURCE = 0;
    private int mCtrlPort;
    private int mDeviceInfo;
    private int mMaxThroughput;
    private boolean mWfdEnabled;

    /* renamed from: android.net.wifi.p2p.WifiP2pWfdInfo.1 */
    static class C05571 implements Creator<WifiP2pWfdInfo> {
        C05571() {
        }

        public WifiP2pWfdInfo createFromParcel(Parcel in) {
            WifiP2pWfdInfo device = new WifiP2pWfdInfo();
            device.readFromParcel(in);
            return device;
        }

        public WifiP2pWfdInfo[] newArray(int size) {
            return new WifiP2pWfdInfo[size];
        }
    }

    public WifiP2pWfdInfo(int devInfo, int ctrlPort, int maxTput) {
        this.mWfdEnabled = true;
        this.mDeviceInfo = devInfo;
        this.mCtrlPort = ctrlPort;
        this.mMaxThroughput = maxTput;
    }

    public boolean isWfdEnabled() {
        return this.mWfdEnabled;
    }

    public void setWfdEnabled(boolean enabled) {
        this.mWfdEnabled = enabled;
    }

    public int getDeviceType() {
        return this.mDeviceInfo & SOURCE_OR_PRIMARY_SINK;
    }

    public boolean setDeviceType(int deviceType) {
        if (deviceType < 0 || deviceType > SOURCE_OR_PRIMARY_SINK) {
            return false;
        }
        this.mDeviceInfo |= deviceType;
        return true;
    }

    public boolean isCoupledSinkSupportedAtSource() {
        return (this.mDeviceInfo & COUPLED_SINK_SUPPORT_AT_SINK) != 0;
    }

    public void setCoupledSinkSupportAtSource(boolean enabled) {
        if (enabled) {
            this.mDeviceInfo |= COUPLED_SINK_SUPPORT_AT_SINK;
        } else {
            this.mDeviceInfo &= -9;
        }
    }

    public boolean isCoupledSinkSupportedAtSink() {
        return (this.mDeviceInfo & COUPLED_SINK_SUPPORT_AT_SINK) != 0;
    }

    public void setCoupledSinkSupportAtSink(boolean enabled) {
        if (enabled) {
            this.mDeviceInfo |= COUPLED_SINK_SUPPORT_AT_SINK;
        } else {
            this.mDeviceInfo &= -9;
        }
    }

    public boolean isSessionAvailable() {
        return (this.mDeviceInfo & SESSION_AVAILABLE) != 0;
    }

    public void setSessionAvailable(boolean enabled) {
        if (enabled) {
            this.mDeviceInfo |= SESSION_AVAILABLE_BIT1;
            this.mDeviceInfo &= -33;
            return;
        }
        this.mDeviceInfo &= -49;
    }

    public int getControlPort() {
        return this.mCtrlPort;
    }

    public void setControlPort(int port) {
        this.mCtrlPort = port;
    }

    public void setMaxThroughput(int maxThroughput) {
        this.mMaxThroughput = maxThroughput;
    }

    public int getMaxThroughput() {
        return this.mMaxThroughput;
    }

    public String getDeviceInfoHex() {
        Object[] objArr = new Object[COUPLED_SINK_SUPPORT_AT_SOURCE];
        objArr[0] = Integer.valueOf(6);
        objArr[PRIMARY_SINK] = Integer.valueOf(this.mDeviceInfo);
        objArr[SECONDARY_SINK] = Integer.valueOf(this.mCtrlPort);
        objArr[SOURCE_OR_PRIMARY_SINK] = Integer.valueOf(this.mMaxThroughput);
        return String.format(Locale.US, "%04x%04x%04x%04x", objArr);
    }

    public String toString() {
        StringBuffer sbuf = new StringBuffer();
        sbuf.append("WFD enabled: ").append(this.mWfdEnabled);
        sbuf.append("WFD DeviceInfo: ").append(this.mDeviceInfo);
        sbuf.append("\n WFD CtrlPort: ").append(this.mCtrlPort);
        sbuf.append("\n WFD MaxThroughput: ").append(this.mMaxThroughput);
        return sbuf.toString();
    }

    public int describeContents() {
        return 0;
    }

    public WifiP2pWfdInfo(WifiP2pWfdInfo source) {
        if (source != null) {
            this.mWfdEnabled = source.mWfdEnabled;
            this.mDeviceInfo = source.mDeviceInfo;
            this.mCtrlPort = source.mCtrlPort;
            this.mMaxThroughput = source.mMaxThroughput;
        }
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mWfdEnabled ? PRIMARY_SINK : 0);
        dest.writeInt(this.mDeviceInfo);
        dest.writeInt(this.mCtrlPort);
        dest.writeInt(this.mMaxThroughput);
    }

    public void readFromParcel(Parcel in) {
        boolean z = true;
        if (in.readInt() != PRIMARY_SINK) {
            z = false;
        }
        this.mWfdEnabled = z;
        this.mDeviceInfo = in.readInt();
        this.mCtrlPort = in.readInt();
        this.mMaxThroughput = in.readInt();
    }

    static {
        CREATOR = new C05571();
    }
}
