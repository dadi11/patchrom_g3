package android.telephony;

import android.content.pm.PackageManager;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class CellSignalStrengthWcdma extends CellSignalStrength implements Parcelable {
    public static final Creator<CellSignalStrengthWcdma> CREATOR;
    private static final boolean DBG = false;
    private static final String LOG_TAG = "CellSignalStrengthWcdma";
    private static final int WCDMA_SIGNAL_STRENGTH_GOOD = 8;
    private static final int WCDMA_SIGNAL_STRENGTH_GREAT = 12;
    private static final int WCDMA_SIGNAL_STRENGTH_MODERATE = 5;
    private int mBitErrorRate;
    private int mSignalStrength;

    /* renamed from: android.telephony.CellSignalStrengthWcdma.1 */
    static class C07761 implements Creator<CellSignalStrengthWcdma> {
        C07761() {
        }

        public CellSignalStrengthWcdma createFromParcel(Parcel in) {
            return new CellSignalStrengthWcdma(null);
        }

        public CellSignalStrengthWcdma[] newArray(int size) {
            return new CellSignalStrengthWcdma[size];
        }
    }

    public CellSignalStrengthWcdma() {
        setDefaultValues();
    }

    public CellSignalStrengthWcdma(int ss, int ber) {
        initialize(ss, ber);
    }

    public CellSignalStrengthWcdma(CellSignalStrengthWcdma s) {
        copyFrom(s);
    }

    public void initialize(int ss, int ber) {
        this.mSignalStrength = ss;
        this.mBitErrorRate = ber;
    }

    protected void copyFrom(CellSignalStrengthWcdma s) {
        this.mSignalStrength = s.mSignalStrength;
        this.mBitErrorRate = s.mBitErrorRate;
    }

    public CellSignalStrengthWcdma copy() {
        return new CellSignalStrengthWcdma(this);
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
        if (asu >= WCDMA_SIGNAL_STRENGTH_GREAT) {
            return 4;
        }
        if (asu >= WCDMA_SIGNAL_STRENGTH_GOOD) {
            return 3;
        }
        if (asu >= WCDMA_SIGNAL_STRENGTH_MODERATE) {
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
            CellSignalStrengthWcdma s = (CellSignalStrengthWcdma) o;
            if (o != null && this.mSignalStrength == s.mSignalStrength && this.mBitErrorRate == s.mBitErrorRate) {
                return true;
            }
            return DBG;
        } catch (ClassCastException e) {
            return DBG;
        }
    }

    public String toString() {
        return "CellSignalStrengthWcdma: ss=" + this.mSignalStrength + " ber=" + this.mBitErrorRate;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mSignalStrength);
        dest.writeInt(this.mBitErrorRate);
    }

    private CellSignalStrengthWcdma(Parcel in) {
        this.mSignalStrength = in.readInt();
        this.mBitErrorRate = in.readInt();
    }

    public int describeContents() {
        return 0;
    }

    static {
        CREATOR = new C07761();
    }

    private static void log(String s) {
        Rlog.m21w(LOG_TAG, s);
    }
}
