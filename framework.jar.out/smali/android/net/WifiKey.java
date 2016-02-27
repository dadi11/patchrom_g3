package android.net;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.Objects;
import java.util.regex.Pattern;

public class WifiKey implements Parcelable {
    private static final Pattern BSSID_PATTERN;
    public static final Creator<WifiKey> CREATOR;
    private static final Pattern SSID_PATTERN;
    public final String bssid;
    public final String ssid;

    /* renamed from: android.net.WifiKey.1 */
    static class C05111 implements Creator<WifiKey> {
        C05111() {
        }

        public WifiKey createFromParcel(Parcel in) {
            return new WifiKey(null);
        }

        public WifiKey[] newArray(int size) {
            return new WifiKey[size];
        }
    }

    static {
        SSID_PATTERN = Pattern.compile("(\".*\")|(0x[\\p{XDigit}]+)");
        BSSID_PATTERN = Pattern.compile("([\\p{XDigit}]{2}:){5}[\\p{XDigit}]{2}");
        CREATOR = new C05111();
    }

    public WifiKey(String ssid, String bssid) {
        if (!SSID_PATTERN.matcher(ssid).matches()) {
            throw new IllegalArgumentException("Invalid ssid: " + ssid);
        } else if (BSSID_PATTERN.matcher(bssid).matches()) {
            this.ssid = ssid;
            this.bssid = bssid;
        } else {
            throw new IllegalArgumentException("Invalid bssid: " + bssid);
        }
    }

    private WifiKey(Parcel in) {
        this.ssid = in.readString();
        this.bssid = in.readString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeString(this.ssid);
        out.writeString(this.bssid);
    }

    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        WifiKey wifiKey = (WifiKey) o;
        if (Objects.equals(this.ssid, wifiKey.ssid) && Objects.equals(this.bssid, wifiKey.bssid)) {
            return true;
        }
        return false;
    }

    public int hashCode() {
        return Objects.hash(new Object[]{this.ssid, this.bssid});
    }

    public String toString() {
        return "WifiKey[SSID=" + this.ssid + ",BSSID=" + this.bssid + "]";
    }
}
