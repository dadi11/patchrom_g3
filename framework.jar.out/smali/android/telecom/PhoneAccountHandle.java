package android.telecom;

import android.content.ComponentName;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.Process;
import android.os.UserHandle;
import java.util.Objects;

public class PhoneAccountHandle implements Parcelable {
    public static final Creator<PhoneAccountHandle> CREATOR;
    private final ComponentName mComponentName;
    private final String mId;
    private final UserHandle mUserHandle;

    /* renamed from: android.telecom.PhoneAccountHandle.1 */
    static class C07521 implements Creator<PhoneAccountHandle> {
        C07521() {
        }

        public PhoneAccountHandle createFromParcel(Parcel in) {
            return new PhoneAccountHandle(null);
        }

        public PhoneAccountHandle[] newArray(int size) {
            return new PhoneAccountHandle[size];
        }
    }

    public PhoneAccountHandle(ComponentName componentName, String id) {
        this(componentName, id, Process.myUserHandle());
    }

    public PhoneAccountHandle(ComponentName componentName, String id, UserHandle userHandle) {
        this.mComponentName = componentName;
        this.mId = id;
        this.mUserHandle = userHandle;
    }

    public ComponentName getComponentName() {
        return this.mComponentName;
    }

    public String getId() {
        return this.mId;
    }

    public UserHandle getUserHandle() {
        return this.mUserHandle;
    }

    public int hashCode() {
        return Objects.hash(new Object[]{this.mComponentName, this.mId, this.mUserHandle});
    }

    public String toString() {
        return this.mComponentName + ", " + Log.pii(this.mId) + ", " + this.mUserHandle;
    }

    public boolean equals(Object other) {
        return other != null && (other instanceof PhoneAccountHandle) && Objects.equals(((PhoneAccountHandle) other).getComponentName(), getComponentName()) && Objects.equals(((PhoneAccountHandle) other).getId(), getId()) && Objects.equals(((PhoneAccountHandle) other).getUserHandle(), getUserHandle());
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        this.mComponentName.writeToParcel(out, flags);
        out.writeString(this.mId);
        this.mUserHandle.writeToParcel(out, flags);
    }

    static {
        CREATOR = new C07521();
    }

    private PhoneAccountHandle(Parcel in) {
        this((ComponentName) ComponentName.CREATOR.createFromParcel(in), in.readString(), (UserHandle) UserHandle.CREATOR.createFromParcel(in));
    }
}
