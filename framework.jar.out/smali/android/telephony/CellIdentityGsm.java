package android.telephony;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class CellIdentityGsm implements Parcelable {
    public static final Creator<CellIdentityGsm> CREATOR;
    private static final boolean DBG = false;
    private static final String LOG_TAG = "CellIdentityGsm";
    private final int mCid;
    private final int mLac;
    private final int mMcc;
    private final int mMnc;

    /* renamed from: android.telephony.CellIdentityGsm.1 */
    static class C07651 implements Creator<CellIdentityGsm> {
        C07651() {
        }

        public CellIdentityGsm createFromParcel(Parcel in) {
            return new CellIdentityGsm(null);
        }

        public CellIdentityGsm[] newArray(int size) {
            return new CellIdentityGsm[size];
        }
    }

    public CellIdentityGsm() {
        this.mMcc = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mMnc = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mLac = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mCid = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
    }

    public CellIdentityGsm(int mcc, int mnc, int lac, int cid) {
        this.mMcc = mcc;
        this.mMnc = mnc;
        this.mLac = lac;
        this.mCid = cid;
    }

    private CellIdentityGsm(CellIdentityGsm cid) {
        this.mMcc = cid.mMcc;
        this.mMnc = cid.mMnc;
        this.mLac = cid.mLac;
        this.mCid = cid.mCid;
    }

    CellIdentityGsm copy() {
        return new CellIdentityGsm(this);
    }

    public int getMcc() {
        return this.mMcc;
    }

    public int getMnc() {
        return this.mMnc;
    }

    public int getLac() {
        return this.mLac;
    }

    public int getCid() {
        return this.mCid;
    }

    @Deprecated
    public int getPsc() {
        return ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
    }

    public int hashCode() {
        return (((this.mMcc * 31) + (this.mMnc * 31)) + (this.mLac * 31)) + (this.mCid * 31);
    }

    public boolean equals(Object other) {
        if (!super.equals(other)) {
            return DBG;
        }
        try {
            CellIdentityGsm o = (CellIdentityGsm) other;
            if (this.mMcc == o.mMcc && this.mMnc == o.mMnc && this.mLac == o.mLac && this.mCid == o.mCid) {
                return true;
            }
            return DBG;
        } catch (ClassCastException e) {
            return DBG;
        }
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("CellIdentityGsm:{");
        sb.append(" mMcc=").append(this.mMcc);
        sb.append(" mMnc=").append(this.mMnc);
        sb.append(" mLac=").append(this.mLac);
        sb.append(" mCid=").append(this.mCid);
        sb.append("}");
        return sb.toString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mMcc);
        dest.writeInt(this.mMnc);
        dest.writeInt(this.mLac);
        dest.writeInt(this.mCid);
    }

    private CellIdentityGsm(Parcel in) {
        this.mMcc = in.readInt();
        this.mMnc = in.readInt();
        this.mLac = in.readInt();
        this.mCid = in.readInt();
    }

    static {
        CREATOR = new C07651();
    }

    private static void log(String s) {
        Rlog.m21w(LOG_TAG, s);
    }
}
