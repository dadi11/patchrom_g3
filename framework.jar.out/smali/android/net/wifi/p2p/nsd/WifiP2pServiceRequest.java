package android.net.wifi.p2p.nsd;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.format.DateFormat;
import android.view.inputmethod.EditorInfo;
import android.widget.AppSecurityPermissions;
import java.util.Locale;

public class WifiP2pServiceRequest implements Parcelable {
    public static final Creator<WifiP2pServiceRequest> CREATOR;
    private int mLength;
    private int mProtocolType;
    private String mQuery;
    private int mTransId;

    /* renamed from: android.net.wifi.p2p.nsd.WifiP2pServiceRequest.1 */
    static class C05591 implements Creator<WifiP2pServiceRequest> {
        C05591() {
        }

        public WifiP2pServiceRequest createFromParcel(Parcel in) {
            return new WifiP2pServiceRequest(in.readInt(), in.readInt(), in.readString(), null);
        }

        public WifiP2pServiceRequest[] newArray(int size) {
            return new WifiP2pServiceRequest[size];
        }
    }

    protected WifiP2pServiceRequest(int protocolType, String query) {
        validateQuery(query);
        this.mProtocolType = protocolType;
        this.mQuery = query;
        if (query != null) {
            this.mLength = (query.length() / 2) + 2;
        } else {
            this.mLength = 2;
        }
    }

    private WifiP2pServiceRequest(int serviceType, int length, int transId, String query) {
        this.mProtocolType = serviceType;
        this.mLength = length;
        this.mTransId = transId;
        this.mQuery = query;
    }

    public int getTransactionId() {
        return this.mTransId;
    }

    public void setTransactionId(int id) {
        this.mTransId = id;
    }

    public String getSupplicantQuery() {
        StringBuffer sb = new StringBuffer();
        sb.append(String.format(Locale.US, "%02x", new Object[]{Integer.valueOf(this.mLength & EditorInfo.IME_MASK_ACTION)}));
        sb.append(String.format(Locale.US, "%02x", new Object[]{Integer.valueOf((this.mLength >> 8) & EditorInfo.IME_MASK_ACTION)}));
        sb.append(String.format(Locale.US, "%02x", new Object[]{Integer.valueOf(this.mProtocolType)}));
        sb.append(String.format(Locale.US, "%02x", new Object[]{Integer.valueOf(this.mTransId)}));
        if (this.mQuery != null) {
            sb.append(this.mQuery);
        }
        return sb.toString();
    }

    private void validateQuery(String query) {
        if (query != null) {
            if (query.length() % 2 == 1) {
                throw new IllegalArgumentException("query size is invalid. query=" + query);
            } else if (query.length() / 2 > AppSecurityPermissions.WHICH_ALL) {
                throw new IllegalArgumentException("query size is too large. len=" + query.length());
            } else {
                query = query.toLowerCase(Locale.ROOT);
                for (char c : query.toCharArray()) {
                    if ((c < '0' || c > '9') && (c < DateFormat.AM_PM || c > 'f')) {
                        throw new IllegalArgumentException("query should be hex string. query=" + query);
                    }
                }
            }
        }
    }

    public static WifiP2pServiceRequest newInstance(int protocolType, String queryData) {
        return new WifiP2pServiceRequest(protocolType, queryData);
    }

    public static WifiP2pServiceRequest newInstance(int protocolType) {
        return new WifiP2pServiceRequest(protocolType, null);
    }

    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (!(o instanceof WifiP2pServiceRequest)) {
            return false;
        }
        WifiP2pServiceRequest req = (WifiP2pServiceRequest) o;
        if (req.mProtocolType != this.mProtocolType || req.mLength != this.mLength) {
            return false;
        }
        if (req.mQuery == null && this.mQuery == null) {
            return true;
        }
        return req.mQuery != null ? req.mQuery.equals(this.mQuery) : false;
    }

    public int hashCode() {
        return ((((this.mProtocolType + 527) * 31) + this.mLength) * 31) + (this.mQuery == null ? 0 : this.mQuery.hashCode());
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mProtocolType);
        dest.writeInt(this.mLength);
        dest.writeInt(this.mTransId);
        dest.writeString(this.mQuery);
    }

    static {
        CREATOR = new C05591();
    }
}
