package android.content.pm;

import android.os.Parcel;
import android.os.Parcelable.Creator;
import android.os.PatternMatcher;

public class PathPermission extends PatternMatcher {
    public static final Creator<PathPermission> CREATOR;
    private final String mReadPermission;
    private final String mWritePermission;

    /* renamed from: android.content.pm.PathPermission.1 */
    static class C01351 implements Creator<PathPermission> {
        C01351() {
        }

        public PathPermission createFromParcel(Parcel source) {
            return new PathPermission(source);
        }

        public PathPermission[] newArray(int size) {
            return new PathPermission[size];
        }
    }

    public PathPermission(String pattern, int type, String readPermission, String writePermission) {
        super(pattern, type);
        this.mReadPermission = readPermission;
        this.mWritePermission = writePermission;
    }

    public String getReadPermission() {
        return this.mReadPermission;
    }

    public String getWritePermission() {
        return this.mWritePermission;
    }

    public void writeToParcel(Parcel dest, int flags) {
        super.writeToParcel(dest, flags);
        dest.writeString(this.mReadPermission);
        dest.writeString(this.mWritePermission);
    }

    public PathPermission(Parcel src) {
        super(src);
        this.mReadPermission = src.readString();
        this.mWritePermission = src.readString();
    }

    static {
        CREATOR = new C01351();
    }
}
