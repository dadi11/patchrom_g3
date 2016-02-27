package android.telephony;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class CellIdentityCdma implements Parcelable {
    public static final Creator<CellIdentityCdma> CREATOR;
    private static final boolean DBG = false;
    private static final String LOG_TAG = "CellSignalStrengthCdma";
    private final int mBasestationId;
    private final int mLatitude;
    private final int mLongitude;
    private final int mNetworkId;
    private final int mSystemId;

    /* renamed from: android.telephony.CellIdentityCdma.1 */
    static class C07641 implements Creator<CellIdentityCdma> {
        C07641() {
        }

        public CellIdentityCdma createFromParcel(Parcel in) {
            return new CellIdentityCdma(null);
        }

        public CellIdentityCdma[] newArray(int size) {
            return new CellIdentityCdma[size];
        }
    }

    public CellIdentityCdma() {
        this.mNetworkId = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mSystemId = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mBasestationId = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mLongitude = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mLatitude = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
    }

    public CellIdentityCdma(int nid, int sid, int bid, int lon, int lat) {
        this.mNetworkId = nid;
        this.mSystemId = sid;
        this.mBasestationId = bid;
        this.mLongitude = lon;
        this.mLatitude = lat;
    }

    private CellIdentityCdma(CellIdentityCdma cid) {
        this.mNetworkId = cid.mNetworkId;
        this.mSystemId = cid.mSystemId;
        this.mBasestationId = cid.mBasestationId;
        this.mLongitude = cid.mLongitude;
        this.mLatitude = cid.mLatitude;
    }

    CellIdentityCdma copy() {
        return new CellIdentityCdma(this);
    }

    public int getNetworkId() {
        return this.mNetworkId;
    }

    public int getSystemId() {
        return this.mSystemId;
    }

    public int getBasestationId() {
        return this.mBasestationId;
    }

    public int getLongitude() {
        return this.mLongitude;
    }

    public int getLatitude() {
        return this.mLatitude;
    }

    public int hashCode() {
        return ((((this.mNetworkId * 31) + (this.mSystemId * 31)) + (this.mBasestationId * 31)) + (this.mLatitude * 31)) + (this.mLongitude * 31);
    }

    public boolean equals(Object other) {
        if (!super.equals(other)) {
            return DBG;
        }
        try {
            CellIdentityCdma o = (CellIdentityCdma) other;
            if (this.mNetworkId == o.mNetworkId && this.mSystemId == o.mSystemId && this.mBasestationId == o.mBasestationId && this.mLatitude == o.mLatitude && this.mLongitude == o.mLongitude) {
                return true;
            }
            return DBG;
        } catch (ClassCastException e) {
            return DBG;
        }
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("CellIdentityCdma:{");
        sb.append(" mNetworkId=");
        sb.append(this.mNetworkId);
        sb.append(" mSystemId=");
        sb.append(this.mSystemId);
        sb.append(" mBasestationId=");
        sb.append(this.mBasestationId);
        sb.append(" mLongitude=");
        sb.append(this.mLongitude);
        sb.append(" mLatitude=");
        sb.append(this.mLatitude);
        sb.append("}");
        return sb.toString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mNetworkId);
        dest.writeInt(this.mSystemId);
        dest.writeInt(this.mBasestationId);
        dest.writeInt(this.mLongitude);
        dest.writeInt(this.mLatitude);
    }

    private CellIdentityCdma(Parcel in) {
        this.mNetworkId = in.readInt();
        this.mSystemId = in.readInt();
        this.mBasestationId = in.readInt();
        this.mLongitude = in.readInt();
        this.mLatitude = in.readInt();
    }

    static {
        CREATOR = new C07641();
    }

    private static void log(String s) {
        Rlog.m21w(LOG_TAG, s);
    }
}
