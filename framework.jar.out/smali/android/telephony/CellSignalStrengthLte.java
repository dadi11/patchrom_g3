package android.telephony;

import android.content.pm.PackageManager;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.view.KeyEvent;

public final class CellSignalStrengthLte extends CellSignalStrength implements Parcelable {
    public static final Creator<CellSignalStrengthLte> CREATOR;
    private static final boolean DBG = false;
    private static final String LOG_TAG = "CellSignalStrengthLte";
    private int mCqi;
    private int mRsrp;
    private int mRsrq;
    private int mRssnr;
    private int mSignalStrength;
    private int mTimingAdvance;

    /* renamed from: android.telephony.CellSignalStrengthLte.1 */
    static class C07751 implements Creator<CellSignalStrengthLte> {
        C07751() {
        }

        public CellSignalStrengthLte createFromParcel(Parcel in) {
            return new CellSignalStrengthLte(null);
        }

        public CellSignalStrengthLte[] newArray(int size) {
            return new CellSignalStrengthLte[size];
        }
    }

    public CellSignalStrengthLte() {
        setDefaultValues();
    }

    public CellSignalStrengthLte(int signalStrength, int rsrp, int rsrq, int rssnr, int cqi, int timingAdvance) {
        initialize(signalStrength, rsrp, rsrq, rssnr, cqi, timingAdvance);
    }

    public CellSignalStrengthLte(CellSignalStrengthLte s) {
        copyFrom(s);
    }

    public void initialize(int lteSignalStrength, int rsrp, int rsrq, int rssnr, int cqi, int timingAdvance) {
        this.mSignalStrength = lteSignalStrength;
        this.mRsrp = rsrp;
        this.mRsrq = rsrq;
        this.mRssnr = rssnr;
        this.mCqi = cqi;
        this.mTimingAdvance = timingAdvance;
    }

    public void initialize(SignalStrength ss, int timingAdvance) {
        this.mSignalStrength = ss.getLteSignalStrength();
        this.mRsrp = ss.getLteRsrp();
        this.mRsrq = ss.getLteRsrq();
        this.mRssnr = ss.getLteRssnr();
        this.mCqi = ss.getLteCqi();
        this.mTimingAdvance = timingAdvance;
    }

    protected void copyFrom(CellSignalStrengthLte s) {
        this.mSignalStrength = s.mSignalStrength;
        this.mRsrp = s.mRsrp;
        this.mRsrq = s.mRsrq;
        this.mRssnr = s.mRssnr;
        this.mCqi = s.mCqi;
        this.mTimingAdvance = s.mTimingAdvance;
    }

    public CellSignalStrengthLte copy() {
        return new CellSignalStrengthLte(this);
    }

    public void setDefaultValues() {
        this.mSignalStrength = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mRsrp = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mRsrq = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mRssnr = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mCqi = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mTimingAdvance = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
    }

    public int getLevel() {
        int levelRsrp;
        int levelRssnr;
        if (this.mRsrp == ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED) {
            levelRsrp = 0;
        } else if (this.mRsrp >= -95) {
            levelRsrp = 4;
        } else if (this.mRsrp >= PackageManager.INSTALL_PARSE_FAILED_CERTIFICATE_ENCODING) {
            levelRsrp = 3;
        } else if (this.mRsrp >= PackageManager.INSTALL_FAILED_ABORTED) {
            levelRsrp = 2;
        } else {
            levelRsrp = 1;
        }
        if (this.mRssnr == ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED) {
            levelRssnr = 0;
        } else if (this.mRssnr >= 45) {
            levelRssnr = 4;
        } else if (this.mRssnr >= 10) {
            levelRssnr = 3;
        } else if (this.mRssnr >= -30) {
            levelRssnr = 2;
        } else {
            levelRssnr = 1;
        }
        if (this.mRsrp == ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED) {
            return levelRssnr;
        }
        if (this.mRssnr == ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED) {
            return levelRsrp;
        }
        return levelRssnr < levelRsrp ? levelRssnr : levelRsrp;
    }

    public int getDbm() {
        return this.mRsrp;
    }

    public int getAsuLevel() {
        int lteDbm = getDbm();
        if (lteDbm <= -140) {
            return 0;
        }
        if (lteDbm >= -43) {
            return 97;
        }
        return lteDbm + KeyEvent.KEYCODE_F10;
    }

    public int getTimingAdvance() {
        return this.mTimingAdvance;
    }

    public int hashCode() {
        return (((((this.mSignalStrength * 31) + (this.mRsrp * 31)) + (this.mRsrq * 31)) + (this.mRssnr * 31)) + (this.mCqi * 31)) + (this.mTimingAdvance * 31);
    }

    public boolean equals(Object o) {
        try {
            CellSignalStrengthLte s = (CellSignalStrengthLte) o;
            if (o != null && this.mSignalStrength == s.mSignalStrength && this.mRsrp == s.mRsrp && this.mRsrq == s.mRsrq && this.mRssnr == s.mRssnr && this.mCqi == s.mCqi && this.mTimingAdvance == s.mTimingAdvance) {
                return true;
            }
            return DBG;
        } catch (ClassCastException e) {
            return DBG;
        }
    }

    public String toString() {
        return "CellSignalStrengthLte: ss=" + this.mSignalStrength + " rsrp=" + this.mRsrp + " rsrq=" + this.mRsrq + " rssnr=" + this.mRssnr + " cqi=" + this.mCqi + " ta=" + this.mTimingAdvance;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mSignalStrength);
        dest.writeInt(this.mRsrp * -1);
        dest.writeInt(this.mRsrq * -1);
        dest.writeInt(this.mRssnr);
        dest.writeInt(this.mCqi);
        dest.writeInt(this.mTimingAdvance);
    }

    private CellSignalStrengthLte(Parcel in) {
        this.mSignalStrength = in.readInt();
        this.mRsrp = in.readInt() * -1;
        this.mRsrq = in.readInt() * -1;
        this.mRssnr = in.readInt();
        this.mCqi = in.readInt();
        this.mTimingAdvance = in.readInt();
    }

    public int describeContents() {
        return 0;
    }

    static {
        CREATOR = new C07751();
    }

    private static void log(String s) {
        Rlog.m21w(LOG_TAG, s);
    }
}
