package android.content.pm;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.UserHandle;

public class PackageStats implements Parcelable {
    public static final Creator<PackageStats> CREATOR;
    public long cacheSize;
    public long codeSize;
    public long dataSize;
    public long externalCacheSize;
    public long externalCodeSize;
    public long externalDataSize;
    public long externalMediaSize;
    public long externalObbSize;
    public String packageName;
    public int userHandle;

    /* renamed from: android.content.pm.PackageStats.1 */
    static class C01321 implements Creator<PackageStats> {
        C01321() {
        }

        public PackageStats createFromParcel(Parcel in) {
            return new PackageStats(in);
        }

        public PackageStats[] newArray(int size) {
            return new PackageStats[size];
        }
    }

    static {
        CREATOR = new C01321();
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("PackageStats{");
        sb.append(Integer.toHexString(System.identityHashCode(this)));
        sb.append(" ");
        sb.append(this.packageName);
        if (this.codeSize != 0) {
            sb.append(" code=");
            sb.append(this.codeSize);
        }
        if (this.dataSize != 0) {
            sb.append(" data=");
            sb.append(this.dataSize);
        }
        if (this.cacheSize != 0) {
            sb.append(" cache=");
            sb.append(this.cacheSize);
        }
        if (this.externalCodeSize != 0) {
            sb.append(" extCode=");
            sb.append(this.externalCodeSize);
        }
        if (this.externalDataSize != 0) {
            sb.append(" extData=");
            sb.append(this.externalDataSize);
        }
        if (this.externalCacheSize != 0) {
            sb.append(" extCache=");
            sb.append(this.externalCacheSize);
        }
        if (this.externalMediaSize != 0) {
            sb.append(" media=");
            sb.append(this.externalMediaSize);
        }
        if (this.externalObbSize != 0) {
            sb.append(" obb=");
            sb.append(this.externalObbSize);
        }
        sb.append("}");
        return sb.toString();
    }

    public PackageStats(String pkgName) {
        this.packageName = pkgName;
        this.userHandle = UserHandle.myUserId();
    }

    public PackageStats(String pkgName, int userHandle) {
        this.packageName = pkgName;
        this.userHandle = userHandle;
    }

    public PackageStats(Parcel source) {
        this.packageName = source.readString();
        this.userHandle = source.readInt();
        this.codeSize = source.readLong();
        this.dataSize = source.readLong();
        this.cacheSize = source.readLong();
        this.externalCodeSize = source.readLong();
        this.externalDataSize = source.readLong();
        this.externalCacheSize = source.readLong();
        this.externalMediaSize = source.readLong();
        this.externalObbSize = source.readLong();
    }

    public PackageStats(PackageStats pStats) {
        this.packageName = pStats.packageName;
        this.userHandle = pStats.userHandle;
        this.codeSize = pStats.codeSize;
        this.dataSize = pStats.dataSize;
        this.cacheSize = pStats.cacheSize;
        this.externalCodeSize = pStats.externalCodeSize;
        this.externalDataSize = pStats.externalDataSize;
        this.externalCacheSize = pStats.externalCacheSize;
        this.externalMediaSize = pStats.externalMediaSize;
        this.externalObbSize = pStats.externalObbSize;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int parcelableFlags) {
        dest.writeString(this.packageName);
        dest.writeInt(this.userHandle);
        dest.writeLong(this.codeSize);
        dest.writeLong(this.dataSize);
        dest.writeLong(this.cacheSize);
        dest.writeLong(this.externalCodeSize);
        dest.writeLong(this.externalDataSize);
        dest.writeLong(this.externalCacheSize);
        dest.writeLong(this.externalMediaSize);
        dest.writeLong(this.externalObbSize);
    }
}
