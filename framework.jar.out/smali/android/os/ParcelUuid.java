package android.os;

import android.os.Parcelable.Creator;
import java.util.UUID;

public final class ParcelUuid implements Parcelable {
    public static final Creator<ParcelUuid> CREATOR;
    private final UUID mUuid;

    /* renamed from: android.os.ParcelUuid.1 */
    static class C06011 implements Creator<ParcelUuid> {
        C06011() {
        }

        public ParcelUuid createFromParcel(Parcel source) {
            return new ParcelUuid(new UUID(source.readLong(), source.readLong()));
        }

        public ParcelUuid[] newArray(int size) {
            return new ParcelUuid[size];
        }
    }

    public ParcelUuid(UUID uuid) {
        this.mUuid = uuid;
    }

    public static ParcelUuid fromString(String uuid) {
        return new ParcelUuid(UUID.fromString(uuid));
    }

    public UUID getUuid() {
        return this.mUuid;
    }

    public String toString() {
        return this.mUuid.toString();
    }

    public int hashCode() {
        return this.mUuid.hashCode();
    }

    public boolean equals(Object object) {
        if (object == null) {
            return false;
        }
        if (this == object) {
            return true;
        }
        if (!(object instanceof ParcelUuid)) {
            return false;
        }
        return this.mUuid.equals(((ParcelUuid) object).mUuid);
    }

    static {
        CREATOR = new C06011();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeLong(this.mUuid.getMostSignificantBits());
        dest.writeLong(this.mUuid.getLeastSignificantBits());
    }
}
