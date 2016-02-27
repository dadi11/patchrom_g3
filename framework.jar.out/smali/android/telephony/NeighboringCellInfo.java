package android.telephony;

import android.net.wifi.WifiEnterpriseConfig;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.widget.Toast;

public class NeighboringCellInfo implements Parcelable {
    public static final Creator<NeighboringCellInfo> CREATOR;
    public static final int UNKNOWN_CID = -1;
    public static final int UNKNOWN_RSSI = 99;
    private int mCid;
    private int mLac;
    private int mNetworkType;
    private int mPsc;
    private int mRssi;

    /* renamed from: android.telephony.NeighboringCellInfo.1 */
    static class C07791 implements Creator<NeighboringCellInfo> {
        C07791() {
        }

        public NeighboringCellInfo createFromParcel(Parcel in) {
            return new NeighboringCellInfo(in);
        }

        public NeighboringCellInfo[] newArray(int size) {
            return new NeighboringCellInfo[size];
        }
    }

    @Deprecated
    public NeighboringCellInfo() {
        this.mRssi = UNKNOWN_RSSI;
        this.mLac = UNKNOWN_CID;
        this.mCid = UNKNOWN_CID;
        this.mPsc = UNKNOWN_CID;
        this.mNetworkType = 0;
    }

    @Deprecated
    public NeighboringCellInfo(int rssi, int cid) {
        this.mRssi = rssi;
        this.mCid = cid;
    }

    public NeighboringCellInfo(int rssi, String location, int radioType) {
        this.mRssi = rssi;
        this.mNetworkType = 0;
        this.mPsc = UNKNOWN_CID;
        this.mLac = UNKNOWN_CID;
        this.mCid = UNKNOWN_CID;
        int l = location.length();
        if (l <= 8) {
            if (l < 8) {
                for (int i = 0; i < 8 - l; i++) {
                    location = WifiEnterpriseConfig.ENGINE_DISABLE + location;
                }
            }
            switch (radioType) {
                case Toast.LENGTH_LONG /*1*/:
                case Action.MERGE_IGNORE /*2*/:
                    try {
                        this.mNetworkType = radioType;
                        if (!location.equalsIgnoreCase("FFFFFFFF")) {
                            this.mCid = Integer.valueOf(location.substring(4), 16).intValue();
                            this.mLac = Integer.valueOf(location.substring(0, 4), 16).intValue();
                            return;
                        }
                        return;
                    } catch (NumberFormatException e) {
                        this.mPsc = UNKNOWN_CID;
                        this.mLac = UNKNOWN_CID;
                        this.mCid = UNKNOWN_CID;
                        this.mNetworkType = 0;
                    }
                case SetDrawableParameters.TAG /*3*/:
                case SetPendingIntentTemplate.TAG /*8*/:
                case SetOnClickFillInIntent.TAG /*9*/:
                case SetRemoteViewsAdapterIntent.TAG /*10*/:
                    this.mNetworkType = radioType;
                    this.mPsc = Integer.valueOf(location, 16).intValue();
                    return;
                default:
                    return;
            }
            this.mPsc = UNKNOWN_CID;
            this.mLac = UNKNOWN_CID;
            this.mCid = UNKNOWN_CID;
            this.mNetworkType = 0;
        }
    }

    public NeighboringCellInfo(Parcel in) {
        this.mRssi = in.readInt();
        this.mLac = in.readInt();
        this.mCid = in.readInt();
        this.mPsc = in.readInt();
        this.mNetworkType = in.readInt();
    }

    public int getRssi() {
        return this.mRssi;
    }

    public int getLac() {
        return this.mLac;
    }

    public int getCid() {
        return this.mCid;
    }

    public int getPsc() {
        return this.mPsc;
    }

    public int getNetworkType() {
        return this.mNetworkType;
    }

    @Deprecated
    public void setCid(int cid) {
        this.mCid = cid;
    }

    @Deprecated
    public void setRssi(int rssi) {
        this.mRssi = rssi;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        if (this.mPsc != UNKNOWN_CID) {
            sb.append(Integer.toHexString(this.mPsc)).append("@").append(this.mRssi == UNKNOWN_RSSI ? "-" : Integer.valueOf(this.mRssi));
        } else if (!(this.mLac == UNKNOWN_CID || this.mCid == UNKNOWN_CID)) {
            sb.append(Integer.toHexString(this.mLac)).append(Integer.toHexString(this.mCid)).append("@").append(this.mRssi == UNKNOWN_RSSI ? "-" : Integer.valueOf(this.mRssi));
        }
        sb.append("]");
        return sb.toString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mRssi);
        dest.writeInt(this.mLac);
        dest.writeInt(this.mCid);
        dest.writeInt(this.mPsc);
        dest.writeInt(this.mNetworkType);
    }

    static {
        CREATOR = new C07791();
    }
}
