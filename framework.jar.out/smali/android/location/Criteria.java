package android.location;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class Criteria implements Parcelable {
    public static final int ACCURACY_COARSE = 2;
    public static final int ACCURACY_FINE = 1;
    public static final int ACCURACY_HIGH = 3;
    public static final int ACCURACY_LOW = 1;
    public static final int ACCURACY_MEDIUM = 2;
    public static final Creator<Criteria> CREATOR;
    public static final int NO_REQUIREMENT = 0;
    public static final int POWER_HIGH = 3;
    public static final int POWER_LOW = 1;
    public static final int POWER_MEDIUM = 2;
    private boolean mAltitudeRequired;
    private int mBearingAccuracy;
    private boolean mBearingRequired;
    private boolean mCostAllowed;
    private int mHorizontalAccuracy;
    private int mPowerRequirement;
    private int mSpeedAccuracy;
    private boolean mSpeedRequired;
    private int mVerticalAccuracy;

    /* renamed from: android.location.Criteria.1 */
    static class C03301 implements Creator<Criteria> {
        C03301() {
        }

        public Criteria createFromParcel(Parcel in) {
            boolean z;
            boolean z2 = true;
            Criteria c = new Criteria();
            c.mHorizontalAccuracy = in.readInt();
            c.mVerticalAccuracy = in.readInt();
            c.mSpeedAccuracy = in.readInt();
            c.mBearingAccuracy = in.readInt();
            c.mPowerRequirement = in.readInt();
            if (in.readInt() != 0) {
                z = true;
            } else {
                z = false;
            }
            c.mAltitudeRequired = z;
            if (in.readInt() != 0) {
                z = true;
            } else {
                z = false;
            }
            c.mBearingRequired = z;
            if (in.readInt() != 0) {
                z = true;
            } else {
                z = false;
            }
            c.mSpeedRequired = z;
            if (in.readInt() == 0) {
                z2 = false;
            }
            c.mCostAllowed = z2;
            return c;
        }

        public Criteria[] newArray(int size) {
            return new Criteria[size];
        }
    }

    public Criteria() {
        this.mHorizontalAccuracy = NO_REQUIREMENT;
        this.mVerticalAccuracy = NO_REQUIREMENT;
        this.mSpeedAccuracy = NO_REQUIREMENT;
        this.mBearingAccuracy = NO_REQUIREMENT;
        this.mPowerRequirement = NO_REQUIREMENT;
        this.mAltitudeRequired = false;
        this.mBearingRequired = false;
        this.mSpeedRequired = false;
        this.mCostAllowed = false;
    }

    public Criteria(Criteria criteria) {
        this.mHorizontalAccuracy = NO_REQUIREMENT;
        this.mVerticalAccuracy = NO_REQUIREMENT;
        this.mSpeedAccuracy = NO_REQUIREMENT;
        this.mBearingAccuracy = NO_REQUIREMENT;
        this.mPowerRequirement = NO_REQUIREMENT;
        this.mAltitudeRequired = false;
        this.mBearingRequired = false;
        this.mSpeedRequired = false;
        this.mCostAllowed = false;
        this.mHorizontalAccuracy = criteria.mHorizontalAccuracy;
        this.mVerticalAccuracy = criteria.mVerticalAccuracy;
        this.mSpeedAccuracy = criteria.mSpeedAccuracy;
        this.mBearingAccuracy = criteria.mBearingAccuracy;
        this.mPowerRequirement = criteria.mPowerRequirement;
        this.mAltitudeRequired = criteria.mAltitudeRequired;
        this.mBearingRequired = criteria.mBearingRequired;
        this.mSpeedRequired = criteria.mSpeedRequired;
        this.mCostAllowed = criteria.mCostAllowed;
    }

    public void setHorizontalAccuracy(int accuracy) {
        if (accuracy < 0 || accuracy > POWER_HIGH) {
            throw new IllegalArgumentException("accuracy=" + accuracy);
        }
        this.mHorizontalAccuracy = accuracy;
    }

    public int getHorizontalAccuracy() {
        return this.mHorizontalAccuracy;
    }

    public void setVerticalAccuracy(int accuracy) {
        if (accuracy < 0 || accuracy > POWER_HIGH) {
            throw new IllegalArgumentException("accuracy=" + accuracy);
        }
        this.mVerticalAccuracy = accuracy;
    }

    public int getVerticalAccuracy() {
        return this.mVerticalAccuracy;
    }

    public void setSpeedAccuracy(int accuracy) {
        if (accuracy < 0 || accuracy > POWER_HIGH) {
            throw new IllegalArgumentException("accuracy=" + accuracy);
        }
        this.mSpeedAccuracy = accuracy;
    }

    public int getSpeedAccuracy() {
        return this.mSpeedAccuracy;
    }

    public void setBearingAccuracy(int accuracy) {
        if (accuracy < 0 || accuracy > POWER_HIGH) {
            throw new IllegalArgumentException("accuracy=" + accuracy);
        }
        this.mBearingAccuracy = accuracy;
    }

    public int getBearingAccuracy() {
        return this.mBearingAccuracy;
    }

    public void setAccuracy(int accuracy) {
        if (accuracy < 0 || accuracy > POWER_MEDIUM) {
            throw new IllegalArgumentException("accuracy=" + accuracy);
        } else if (accuracy == POWER_LOW) {
            this.mHorizontalAccuracy = POWER_HIGH;
        } else {
            this.mHorizontalAccuracy = POWER_LOW;
        }
    }

    public int getAccuracy() {
        if (this.mHorizontalAccuracy >= POWER_HIGH) {
            return POWER_LOW;
        }
        return POWER_MEDIUM;
    }

    public void setPowerRequirement(int level) {
        if (level < 0 || level > POWER_HIGH) {
            throw new IllegalArgumentException("level=" + level);
        }
        this.mPowerRequirement = level;
    }

    public int getPowerRequirement() {
        return this.mPowerRequirement;
    }

    public void setCostAllowed(boolean costAllowed) {
        this.mCostAllowed = costAllowed;
    }

    public boolean isCostAllowed() {
        return this.mCostAllowed;
    }

    public void setAltitudeRequired(boolean altitudeRequired) {
        this.mAltitudeRequired = altitudeRequired;
    }

    public boolean isAltitudeRequired() {
        return this.mAltitudeRequired;
    }

    public void setSpeedRequired(boolean speedRequired) {
        this.mSpeedRequired = speedRequired;
    }

    public boolean isSpeedRequired() {
        return this.mSpeedRequired;
    }

    public void setBearingRequired(boolean bearingRequired) {
        this.mBearingRequired = bearingRequired;
    }

    public boolean isBearingRequired() {
        return this.mBearingRequired;
    }

    static {
        CREATOR = new C03301();
    }

    public int describeContents() {
        return NO_REQUIREMENT;
    }

    public void writeToParcel(Parcel parcel, int flags) {
        int i;
        int i2 = POWER_LOW;
        parcel.writeInt(this.mHorizontalAccuracy);
        parcel.writeInt(this.mVerticalAccuracy);
        parcel.writeInt(this.mSpeedAccuracy);
        parcel.writeInt(this.mBearingAccuracy);
        parcel.writeInt(this.mPowerRequirement);
        if (this.mAltitudeRequired) {
            i = POWER_LOW;
        } else {
            i = NO_REQUIREMENT;
        }
        parcel.writeInt(i);
        if (this.mBearingRequired) {
            i = POWER_LOW;
        } else {
            i = NO_REQUIREMENT;
        }
        parcel.writeInt(i);
        if (this.mSpeedRequired) {
            i = POWER_LOW;
        } else {
            i = NO_REQUIREMENT;
        }
        parcel.writeInt(i);
        if (!this.mCostAllowed) {
            i2 = NO_REQUIREMENT;
        }
        parcel.writeInt(i2);
    }

    private static String powerToString(int power) {
        switch (power) {
            case NO_REQUIREMENT /*0*/:
                return "NO_REQ";
            case POWER_LOW /*1*/:
                return "LOW";
            case POWER_MEDIUM /*2*/:
                return "MEDIUM";
            case POWER_HIGH /*3*/:
                return "HIGH";
            default:
                return "???";
        }
    }

    private static String accuracyToString(int accuracy) {
        switch (accuracy) {
            case NO_REQUIREMENT /*0*/:
                return "---";
            case POWER_LOW /*1*/:
                return "LOW";
            case POWER_MEDIUM /*2*/:
                return "MEDIUM";
            case POWER_HIGH /*3*/:
                return "HIGH";
            default:
                return "???";
        }
    }

    public String toString() {
        StringBuilder s = new StringBuilder();
        s.append("Criteria[power=").append(powerToString(this.mPowerRequirement));
        s.append(" acc=").append(accuracyToString(this.mHorizontalAccuracy));
        s.append(']');
        return s.toString();
    }
}
