package android.telecom;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.ArrayList;
import java.util.List;

public final class ParcelableConference implements Parcelable {
    public static final Creator<ParcelableConference> CREATOR;
    private long mConnectTimeMillis;
    private int mConnectionCapabilities;
    private List<String> mConnectionIds;
    private PhoneAccountHandle mPhoneAccount;
    private int mState;

    /* renamed from: android.telecom.ParcelableConference.1 */
    static class C07491 implements Creator<ParcelableConference> {
        C07491() {
        }

        public ParcelableConference createFromParcel(Parcel source) {
            ClassLoader classLoader = ParcelableConference.class.getClassLoader();
            PhoneAccountHandle phoneAccount = (PhoneAccountHandle) source.readParcelable(classLoader);
            int state = source.readInt();
            int capabilities = source.readInt();
            List<String> connectionIds = new ArrayList(2);
            source.readList(connectionIds, classLoader);
            return new ParcelableConference(phoneAccount, state, capabilities, connectionIds, source.readLong());
        }

        public ParcelableConference[] newArray(int size) {
            return new ParcelableConference[size];
        }
    }

    public ParcelableConference(PhoneAccountHandle phoneAccount, int state, int connectionCapabilities, List<String> connectionIds) {
        this.mPhoneAccount = phoneAccount;
        this.mState = state;
        this.mConnectionCapabilities = connectionCapabilities;
        this.mConnectionIds = connectionIds;
        this.mConnectTimeMillis = Conference.CONNECT_TIME_NOT_SPECIFIED;
    }

    public ParcelableConference(PhoneAccountHandle phoneAccount, int state, int connectionCapabilities, List<String> connectionIds, long connectTimeMillis) {
        this(phoneAccount, state, connectionCapabilities, connectionIds);
        this.mConnectTimeMillis = connectTimeMillis;
    }

    public String toString() {
        return new StringBuffer().append("account: ").append(this.mPhoneAccount).append(", state: ").append(Connection.stateToString(this.mState)).append(", capabilities: ").append(Connection.capabilitiesToString(this.mConnectionCapabilities)).append(", connectTime: ").append(this.mConnectTimeMillis).append(", children: ").append(this.mConnectionIds).toString();
    }

    public PhoneAccountHandle getPhoneAccount() {
        return this.mPhoneAccount;
    }

    public int getState() {
        return this.mState;
    }

    public int getConnectionCapabilities() {
        return this.mConnectionCapabilities;
    }

    public List<String> getConnectionIds() {
        return this.mConnectionIds;
    }

    public long getConnectTimeMillis() {
        return this.mConnectTimeMillis;
    }

    static {
        CREATOR = new C07491();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel destination, int flags) {
        destination.writeParcelable(this.mPhoneAccount, 0);
        destination.writeInt(this.mState);
        destination.writeInt(this.mConnectionCapabilities);
        destination.writeList(this.mConnectionIds);
        destination.writeLong(this.mConnectTimeMillis);
    }
}
