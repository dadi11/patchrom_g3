package android.hardware.hdmi;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class HdmiHotplugEvent implements Parcelable {
    public static final Creator<HdmiHotplugEvent> CREATOR;
    private final boolean mConnected;
    private final int mPort;

    /* renamed from: android.hardware.hdmi.HdmiHotplugEvent.1 */
    static class C02841 implements Creator<HdmiHotplugEvent> {
        C02841() {
        }

        public HdmiHotplugEvent createFromParcel(Parcel p) {
            boolean connected = true;
            int port = p.readInt();
            if (p.readByte() != (byte) 1) {
                connected = false;
            }
            return new HdmiHotplugEvent(port, connected);
        }

        public HdmiHotplugEvent[] newArray(int size) {
            return new HdmiHotplugEvent[size];
        }
    }

    public HdmiHotplugEvent(int port, boolean connected) {
        this.mPort = port;
        this.mConnected = connected;
    }

    public int getPort() {
        return this.mPort;
    }

    public boolean isConnected() {
        return this.mConnected;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mPort);
        dest.writeByte((byte) (this.mConnected ? 1 : 0));
    }

    static {
        CREATOR = new C02841();
    }
}
