package android.net.wifi.p2p.nsd;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.ArrayList;
import java.util.List;

public class WifiP2pServiceInfo implements Parcelable {
    public static final Creator<WifiP2pServiceInfo> CREATOR;
    public static final int SERVICE_TYPE_ALL = 0;
    public static final int SERVICE_TYPE_BONJOUR = 1;
    public static final int SERVICE_TYPE_UPNP = 2;
    public static final int SERVICE_TYPE_VENDOR_SPECIFIC = 255;
    public static final int SERVICE_TYPE_WS_DISCOVERY = 3;
    private List<String> mQueryList;

    /* renamed from: android.net.wifi.p2p.nsd.WifiP2pServiceInfo.1 */
    static class C05581 implements Creator<WifiP2pServiceInfo> {
        C05581() {
        }

        public WifiP2pServiceInfo createFromParcel(Parcel in) {
            List<String> data = new ArrayList();
            in.readStringList(data);
            return new WifiP2pServiceInfo(data);
        }

        public WifiP2pServiceInfo[] newArray(int size) {
            return new WifiP2pServiceInfo[size];
        }
    }

    protected WifiP2pServiceInfo(List<String> queryList) {
        if (queryList == null) {
            throw new IllegalArgumentException("query list cannot be null");
        }
        this.mQueryList = queryList;
    }

    public List<String> getSupplicantQueryList() {
        return this.mQueryList;
    }

    static String bin2HexStr(byte[] data) {
        StringBuffer sb = new StringBuffer();
        byte[] arr$ = data;
        int len$ = arr$.length;
        int i$ = SERVICE_TYPE_ALL;
        while (i$ < len$) {
            try {
                String s = Integer.toHexString(arr$[i$] & SERVICE_TYPE_VENDOR_SPECIFIC);
                if (s.length() == SERVICE_TYPE_BONJOUR) {
                    sb.append('0');
                }
                sb.append(s);
                i$ += SERVICE_TYPE_BONJOUR;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }
        return sb.toString();
    }

    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (!(o instanceof WifiP2pServiceInfo)) {
            return false;
        }
        return this.mQueryList.equals(((WifiP2pServiceInfo) o).mQueryList);
    }

    public int hashCode() {
        return (this.mQueryList == null ? SERVICE_TYPE_ALL : this.mQueryList.hashCode()) + 527;
    }

    public int describeContents() {
        return SERVICE_TYPE_ALL;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeStringList(this.mQueryList);
    }

    static {
        CREATOR = new C05581();
    }
}
