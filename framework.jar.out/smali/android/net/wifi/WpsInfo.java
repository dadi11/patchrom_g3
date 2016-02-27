package android.net.wifi;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class WpsInfo implements Parcelable {
    public static final Creator<WpsInfo> CREATOR;
    public static final int DISPLAY = 1;
    public static final int INVALID = 4;
    public static final int KEYPAD = 2;
    public static final int LABEL = 3;
    public static final int PBC = 0;
    public String BSSID;
    public String pin;
    public int setup;

    /* renamed from: android.net.wifi.WpsInfo.1 */
    static class C05481 implements Creator<WpsInfo> {
        C05481() {
        }

        public WpsInfo createFromParcel(Parcel in) {
            WpsInfo config = new WpsInfo();
            config.setup = in.readInt();
            config.BSSID = in.readString();
            config.pin = in.readString();
            return config;
        }

        public WpsInfo[] newArray(int size) {
            return new WpsInfo[size];
        }
    }

    public WpsInfo() {
        this.setup = INVALID;
        this.BSSID = null;
        this.pin = null;
    }

    public String toString() {
        StringBuffer sbuf = new StringBuffer();
        sbuf.append(" setup: ").append(this.setup);
        sbuf.append('\n');
        sbuf.append(" BSSID: ").append(this.BSSID);
        sbuf.append('\n');
        sbuf.append(" pin: ").append(this.pin);
        sbuf.append('\n');
        return sbuf.toString();
    }

    public int describeContents() {
        return 0;
    }

    public WpsInfo(WpsInfo source) {
        if (source != null) {
            this.setup = source.setup;
            this.BSSID = source.BSSID;
            this.pin = source.pin;
        }
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.setup);
        dest.writeString(this.BSSID);
        dest.writeString(this.pin);
    }

    static {
        CREATOR = new C05481();
    }
}
