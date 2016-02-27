package android.telecom;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import com.android.internal.telecom.IVideoProvider;
import com.android.internal.telecom.IVideoProvider.Stub;
import java.util.ArrayList;
import java.util.List;

public final class ParcelableConnection implements Parcelable {
    public static final Creator<ParcelableConnection> CREATOR;
    private final Uri mAddress;
    private final int mAddressPresentation;
    private final String mCallerDisplayName;
    private final int mCallerDisplayNamePresentation;
    private final List<String> mConferenceableConnectionIds;
    private final int mConnectionCapabilities;
    private final DisconnectCause mDisconnectCause;
    private final boolean mIsVoipAudioMode;
    private final PhoneAccountHandle mPhoneAccount;
    private final boolean mRingbackRequested;
    private final int mState;
    private final StatusHints mStatusHints;
    private final IVideoProvider mVideoProvider;
    private final int mVideoState;

    /* renamed from: android.telecom.ParcelableConnection.1 */
    static class C07501 implements Creator<ParcelableConnection> {
        C07501() {
        }

        public ParcelableConnection createFromParcel(Parcel source) {
            ClassLoader classLoader = ParcelableConnection.class.getClassLoader();
            PhoneAccountHandle phoneAccount = (PhoneAccountHandle) source.readParcelable(classLoader);
            int state = source.readInt();
            int capabilities = source.readInt();
            Uri address = (Uri) source.readParcelable(classLoader);
            int addressPresentation = source.readInt();
            String callerDisplayName = source.readString();
            int callerDisplayNamePresentation = source.readInt();
            IVideoProvider videoCallProvider = Stub.asInterface(source.readStrongBinder());
            int videoState = source.readInt();
            boolean ringbackRequested = source.readByte() == 1;
            boolean audioModeIsVoip = source.readByte() == 1;
            StatusHints statusHints = (StatusHints) source.readParcelable(classLoader);
            DisconnectCause disconnectCause = (DisconnectCause) source.readParcelable(classLoader);
            List<String> conferenceableConnectionIds = new ArrayList();
            source.readStringList(conferenceableConnectionIds);
            return new ParcelableConnection(phoneAccount, state, capabilities, address, addressPresentation, callerDisplayName, callerDisplayNamePresentation, videoCallProvider, videoState, ringbackRequested, audioModeIsVoip, statusHints, disconnectCause, conferenceableConnectionIds);
        }

        public ParcelableConnection[] newArray(int size) {
            return new ParcelableConnection[size];
        }
    }

    public ParcelableConnection(PhoneAccountHandle phoneAccount, int state, int capabilities, Uri address, int addressPresentation, String callerDisplayName, int callerDisplayNamePresentation, IVideoProvider videoProvider, int videoState, boolean ringbackRequested, boolean isVoipAudioMode, StatusHints statusHints, DisconnectCause disconnectCause, List<String> conferenceableConnectionIds) {
        this.mPhoneAccount = phoneAccount;
        this.mState = state;
        this.mConnectionCapabilities = capabilities;
        this.mAddress = address;
        this.mAddressPresentation = addressPresentation;
        this.mCallerDisplayName = callerDisplayName;
        this.mCallerDisplayNamePresentation = callerDisplayNamePresentation;
        this.mVideoProvider = videoProvider;
        this.mVideoState = videoState;
        this.mRingbackRequested = ringbackRequested;
        this.mIsVoipAudioMode = isVoipAudioMode;
        this.mStatusHints = statusHints;
        this.mDisconnectCause = disconnectCause;
        this.mConferenceableConnectionIds = conferenceableConnectionIds;
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

    public Uri getHandle() {
        return this.mAddress;
    }

    public int getHandlePresentation() {
        return this.mAddressPresentation;
    }

    public String getCallerDisplayName() {
        return this.mCallerDisplayName;
    }

    public int getCallerDisplayNamePresentation() {
        return this.mCallerDisplayNamePresentation;
    }

    public IVideoProvider getVideoProvider() {
        return this.mVideoProvider;
    }

    public int getVideoState() {
        return this.mVideoState;
    }

    public boolean isRingbackRequested() {
        return this.mRingbackRequested;
    }

    public boolean getIsVoipAudioMode() {
        return this.mIsVoipAudioMode;
    }

    public final StatusHints getStatusHints() {
        return this.mStatusHints;
    }

    public final DisconnectCause getDisconnectCause() {
        return this.mDisconnectCause;
    }

    public final List<String> getConferenceableConnectionIds() {
        return this.mConferenceableConnectionIds;
    }

    public String toString() {
        return "ParcelableConnection [act:" + this.mPhoneAccount + ", state:" + this.mState + ", capabilities:" + Connection.capabilitiesToString(this.mConnectionCapabilities);
    }

    static {
        CREATOR = new C07501();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel destination, int flags) {
        int i;
        int i2 = 1;
        destination.writeParcelable(this.mPhoneAccount, 0);
        destination.writeInt(this.mState);
        destination.writeInt(this.mConnectionCapabilities);
        destination.writeParcelable(this.mAddress, 0);
        destination.writeInt(this.mAddressPresentation);
        destination.writeString(this.mCallerDisplayName);
        destination.writeInt(this.mCallerDisplayNamePresentation);
        destination.writeStrongBinder(this.mVideoProvider != null ? this.mVideoProvider.asBinder() : null);
        destination.writeInt(this.mVideoState);
        if (this.mRingbackRequested) {
            i = 1;
        } else {
            i = 0;
        }
        destination.writeByte((byte) i);
        if (!this.mIsVoipAudioMode) {
            i2 = 0;
        }
        destination.writeByte((byte) i2);
        destination.writeParcelable(this.mStatusHints, 0);
        destination.writeParcelable(this.mDisconnectCause, 0);
        destination.writeStringList(this.mConferenceableConnectionIds);
    }
}
