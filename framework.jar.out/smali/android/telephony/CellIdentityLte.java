package android.telephony;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class CellIdentityLte implements Parcelable {
    public static final Creator<CellIdentityLte> CREATOR;
    private static final boolean DBG = false;
    private static final String LOG_TAG = "CellIdentityLte";
    private final int mCi;
    private final int mMcc;
    private final int mMnc;
    private final int mPci;
    private final int mTac;

    /* renamed from: android.telephony.CellIdentityLte.1 */
    static class C07661 implements Creator<CellIdentityLte> {
        C07661() {
        }

        public CellIdentityLte createFromParcel(Parcel in) {
            return new CellIdentityLte(null);
        }

        public CellIdentityLte[] newArray(int size) {
            return new CellIdentityLte[size];
        }
    }

    public CellIdentityLte() {
        this.mMcc = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mMnc = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mCi = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mPci = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mTac = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
    }

    public CellIdentityLte(int mcc, int mnc, int ci, int pci, int tac) {
        this.mMcc = mcc;
        this.mMnc = mnc;
        this.mCi = ci;
        this.mPci = pci;
        this.mTac = tac;
    }

    private CellIdentityLte(CellIdentityLte cid) {
        this.mMcc = cid.mMcc;
        this.mMnc = cid.mMnc;
        this.mCi = cid.mCi;
        this.mPci = cid.mPci;
        this.mTac = cid.mTac;
    }

    CellIdentityLte copy() {
        return new CellIdentityLte(this);
    }

    public int getMcc() {
        return this.mMcc;
    }

    public int getMnc() {
        return this.mMnc;
    }

    public int getCi() {
        return this.mCi;
    }

    public int getPci() {
        return this.mPci;
    }

    public int getTac() {
        return this.mTac;
    }

    public int hashCode() {
        return ((((this.mMcc * 31) + (this.mMnc * 31)) + (this.mCi * 31)) + (this.mPci * 31)) + (this.mTac * 31);
    }

    public boolean equals(Object other) {
        if (!super.equals(other)) {
            return DBG;
        }
        try {
            CellIdentityLte o = (CellIdentityLte) other;
            if (this.mMcc == o.mMcc && this.mMnc == o.mMnc && this.mCi == o.mCi && this.mPci == o.mPci && this.mTac == o.mTac) {
                return true;
            }
            return DBG;
        } catch (ClassCastException e) {
            return DBG;
        }
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("CellIdentityLte:{");
        sb.append(" mMcc=");
        sb.append(this.mMcc);
        sb.append(" mMnc=");
        sb.append(this.mMnc);
        sb.append(" mCi=");
        sb.append(this.mCi);
        sb.append(" mPci=");
        sb.append(this.mPci);
        sb.append(" mTac=");
        sb.append(this.mTac);
        sb.append("}");
        return sb.toString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mMcc);
        dest.writeInt(this.mMnc);
        dest.writeInt(this.mCi);
        dest.writeInt(this.mPci);
        dest.writeInt(this.mTac);
    }

    private CellIdentityLte(Parcel in) {
        this.mMcc = in.readInt();
        this.mMnc = in.readInt();
        this.mCi = in.readInt();
        this.mPci = in.readInt();
        this.mTac = in.readInt();
    }

    static {
        CREATOR = new C07661();
    }

    private static void log(String s) {
        Rlog.m21w(LOG_TAG, s);
    }
}
