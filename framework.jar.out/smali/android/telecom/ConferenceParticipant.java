package android.telecom;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class ConferenceParticipant implements Parcelable {
    public static final Creator<ConferenceParticipant> CREATOR;
    private final String mDisplayName;
    private final Uri mEndpoint;
    private final Uri mHandle;
    private final int mState;

    /* renamed from: android.telecom.ConferenceParticipant.1 */
    static class C07291 implements Creator<ConferenceParticipant> {
        C07291() {
        }

        public ConferenceParticipant createFromParcel(Parcel source) {
            ClassLoader classLoader = ParcelableCall.class.getClassLoader();
            return new ConferenceParticipant((Uri) source.readParcelable(classLoader), source.readString(), (Uri) source.readParcelable(classLoader), source.readInt());
        }

        public ConferenceParticipant[] newArray(int size) {
            return new ConferenceParticipant[size];
        }
    }

    public ConferenceParticipant(Uri handle, String displayName, Uri endpoint, int state) {
        this.mHandle = handle;
        this.mDisplayName = displayName;
        this.mEndpoint = endpoint;
        this.mState = state;
    }

    static {
        CREATOR = new C07291();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeParcelable(this.mHandle, 0);
        dest.writeString(this.mDisplayName);
        dest.writeParcelable(this.mEndpoint, 0);
        dest.writeInt(this.mState);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("[ConferenceParticipant Handle: ");
        sb.append(this.mHandle);
        sb.append(" DisplayName: ");
        sb.append(this.mDisplayName);
        sb.append(" Endpoint: ");
        sb.append(this.mEndpoint);
        sb.append(" State: ");
        sb.append(this.mState);
        sb.append("]");
        return sb.toString();
    }

    public Uri getHandle() {
        return this.mHandle;
    }

    public String getDisplayName() {
        return this.mDisplayName;
    }

    public Uri getEndpoint() {
        return this.mEndpoint;
    }

    public int getState() {
        return this.mState;
    }
}
