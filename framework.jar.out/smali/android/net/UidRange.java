package android.net;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.UserHandle;

public final class UidRange implements Parcelable {
    public static final Creator<UidRange> CREATOR;
    public final int start;
    public final int stop;

    /* renamed from: android.net.UidRange.1 */
    static class C05081 implements Creator<UidRange> {
        C05081() {
        }

        public UidRange createFromParcel(Parcel in) {
            return new UidRange(in.readInt(), in.readInt());
        }

        public UidRange[] newArray(int size) {
            return new UidRange[size];
        }
    }

    public UidRange(int startUid, int stopUid) {
        if (startUid < 0) {
            throw new IllegalArgumentException("Invalid start UID.");
        } else if (stopUid < 0) {
            throw new IllegalArgumentException("Invalid stop UID.");
        } else if (startUid > stopUid) {
            throw new IllegalArgumentException("Invalid UID range.");
        } else {
            this.start = startUid;
            this.stop = stopUid;
        }
    }

    public static UidRange createForUser(int userId) {
        return new UidRange(userId * UserHandle.PER_USER_RANGE, ((userId + 1) * UserHandle.PER_USER_RANGE) - 1);
    }

    public int getStartUser() {
        return this.start / UserHandle.PER_USER_RANGE;
    }

    public int hashCode() {
        return ((this.start + 527) * 31) + this.stop;
    }

    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof UidRange)) {
            return false;
        }
        UidRange other = (UidRange) o;
        if (this.start == other.start && this.stop == other.stop) {
            return true;
        }
        return false;
    }

    public String toString() {
        return this.start + "-" + this.stop;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.start);
        dest.writeInt(this.stop);
    }

    static {
        CREATOR = new C05081();
    }
}
