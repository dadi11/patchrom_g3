package android.telephony;

import android.content.pm.PackageManager;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class CellSignalStrengthGsm extends CellSignalStrength implements Parcelable {
    public static final Creator<CellSignalStrengthGsm> CREATOR;
    private static final boolean DBG = false;
    private static final int GSM_SIGNAL_STRENGTH_GOOD = 8;
    private static final int GSM_SIGNAL_STRENGTH_GREAT = 12;
    private static final int GSM_SIGNAL_STRENGTH_MODERATE = 5;
    private static final String LOG_TAG = "CellSignalStrengthGsm";
    private int mBitErrorRate;
    private int mSignalStrength;

    /* renamed from: android.telephony.CellSignalStrengthGsm.1 */
    static class C07741 implements Creator<CellSignalStrengthGsm> {
        C07741() {
        }

        public CellSignalStrengthGsm createFromParcel(Parcel in) {
            return new CellSignalStrengthGsm(null);
        }

        public CellSignalStrengthGsm[] newArray(int size) {
            return new CellSignalStrengthGsm[size];
        }
    }

    public CellSignalStrengthGsm() {
        setDefaultValues();
    }

    public CellSignalStrengthGsm(int ss, int ber) {
        initialize(ss, ber);
    }

    public CellSignalStrengthGsm(CellSignalStrengthGsm s) {
        copyFrom(s);
    }

    public void initialize(int ss, int ber) {
        this.mSignalStrength = ss;
        this.mBitErrorRate = ber;
    }

    protected void copyFrom(CellSignalStrengthGsm s) {
        this.mSignalStrength = s.mSignalStrength;
        this.mBitErrorRate = s.mBitErrorRate;
    }

    public CellSignalStrengthGsm copy() {
        return new CellSignalStrengthGsm(this);
    }

    public void setDefaultValues() {
        this.mSignalStrength = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mBitErrorRate = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
    }

    public int getLevel() {
        int asu = this.mSignalStrength;
        if (asu <= 2 || asu == 99) {
            return 0;
        }
        if (asu >= GSM_SIGNAL_STRENGTH_GREAT) {
            return 4;
        }
        if (asu >= GSM_SIGNAL_STRENGTH_GOOD) {
            return 3;
        }
        if (asu >= GSM_SIGNAL_STRENGTH_MODERATE) {
            return 2;
        }
        return 1;
    }

    public int getDbm() {
        int asu;
        int level = this.mSignalStrength;
        if (level == 99) {
            asu = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        } else {
            asu = level;
        }
        if (asu != ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED) {
            return (asu * 2) + PackageManager.INSTALL_FAILED_NO_MATCHING_ABIS;
        }
        return ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
    }

    public int getAsuLevel() {
        return this.mSignalStrength;
    }

    public int hashCode() {
        return (this.mSignalStrength * 31) + (this.mBitErrorRate * 31);
    }

    public boolean equals(Object o) {
        try {
            CellSignalStrengthGsm s = (CellSignalStrengthGsm) o;
            if (o != null && this.mSignalStrength == s.mSignalStrength && this.mBitErrorRate == s.mBitErrorRate) {
                return true;
            }
            return DBG;
        } catch (ClassCastException e) {
            return DBG;
        }
    }

    public String toString() {
        return "CellSignalStrengthGsm: ss=" + this.mSignalStrength + " ber=" + this.mBitErrorRate;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mSignalStrength);
        dest.writeInt(this.mBitErrorRate);
    }

    private CellSignalStrengthGsm(Parcel in) {
        this.mSignalStrength = in.readInt();
        this.mBitErrorRate = in.readInt();
    }

    public int describeContents() {
        return 0;
    }

    static {
        CREATOR = new C07741();
    }

    private static void log(String s) {
        Rlog.m21w(LOG_TAG, s);
    }
}
