package android.telephony;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class CellInfoLte extends CellInfo implements Parcelable {
    public static final Creator<CellInfoLte> CREATOR;
    private static final boolean DBG = false;
    private static final String LOG_TAG = "CellInfoLte";
    private CellIdentityLte mCellIdentityLte;
    private CellSignalStrengthLte mCellSignalStrengthLte;

    /* renamed from: android.telephony.CellInfoLte.1 */
    static class C07711 implements Creator<CellInfoLte> {
        C07711() {
        }

        public CellInfoLte createFromParcel(Parcel in) {
            in.readInt();
            return CellInfoLte.createFromParcelBody(in);
        }

        public CellInfoLte[] newArray(int size) {
            return new CellInfoLte[size];
        }
    }

    public CellInfoLte() {
        this.mCellIdentityLte = new CellIdentityLte();
        this.mCellSignalStrengthLte = new CellSignalStrengthLte();
    }

    public CellInfoLte(CellInfoLte ci) {
        super((CellInfo) ci);
        this.mCellIdentityLte = ci.mCellIdentityLte.copy();
        this.mCellSignalStrengthLte = ci.mCellSignalStrengthLte.copy();
    }

    public CellIdentityLte getCellIdentity() {
        return this.mCellIdentityLte;
    }

    public void setCellIdentity(CellIdentityLte cid) {
        this.mCellIdentityLte = cid;
    }

    public CellSignalStrengthLte getCellSignalStrength() {
        return this.mCellSignalStrengthLte;
    }

    public void setCellSignalStrength(CellSignalStrengthLte css) {
        this.mCellSignalStrengthLte = css;
    }

    public int hashCode() {
        return (super.hashCode() + this.mCellIdentityLte.hashCode()) + this.mCellSignalStrengthLte.hashCode();
    }

    public boolean equals(Object other) {
        if (!super.equals(other)) {
            return DBG;
        }
        try {
            CellInfoLte o = (CellInfoLte) other;
            if (this.mCellIdentityLte.equals(o.mCellIdentityLte) && this.mCellSignalStrengthLte.equals(o.mCellSignalStrengthLte)) {
                return true;
            }
            return DBG;
        } catch (ClassCastException e) {
            return DBG;
        }
    }

    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("CellInfoLte:{");
        sb.append(super.toString());
        sb.append(" ").append(this.mCellIdentityLte);
        sb.append(" ").append(this.mCellSignalStrengthLte);
        sb.append("}");
        return sb.toString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        super.writeToParcel(dest, flags, 3);
        this.mCellIdentityLte.writeToParcel(dest, flags);
        this.mCellSignalStrengthLte.writeToParcel(dest, flags);
    }

    private CellInfoLte(Parcel in) {
        super(in);
        this.mCellIdentityLte = (CellIdentityLte) CellIdentityLte.CREATOR.createFromParcel(in);
        this.mCellSignalStrengthLte = (CellSignalStrengthLte) CellSignalStrengthLte.CREATOR.createFromParcel(in);
    }

    static {
        CREATOR = new C07711();
    }

    protected static CellInfoLte createFromParcelBody(Parcel in) {
        return new CellInfoLte(in);
    }

    private static void log(String s) {
        Rlog.m21w(LOG_TAG, s);
    }
}
