package android.telecom;

import android.net.Uri;
import android.os.Bundle;
import android.telecom.InCallService.VideoCall;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.CopyOnWriteArrayList;

public final class Call {
    public static final String AVAILABLE_PHONE_ACCOUNTS = "selectPhoneAccountAccounts";
    public static final int STATE_ACTIVE = 4;
    public static final int STATE_CONNECTING = 9;
    public static final int STATE_DIALING = 1;
    public static final int STATE_DISCONNECTED = 7;
    public static final int STATE_DISCONNECTING = 10;
    public static final int STATE_HOLDING = 3;
    public static final int STATE_NEW = 0;
    public static final int STATE_PRE_DIAL_WAIT = 8;
    public static final int STATE_RINGING = 2;
    private List<String> mCannedTextResponses;
    private final List<Call> mChildren;
    private boolean mChildrenCached;
    private final List<String> mChildrenIds;
    private final List<Call> mConferenceableCalls;
    private Details mDetails;
    private final InCallAdapter mInCallAdapter;
    private final List<Listener> mListeners;
    private String mParentId;
    private final Phone mPhone;
    private String mRemainingPostDialSequence;
    private int mState;
    private final String mTelecomCallId;
    private final List<Call> mUnmodifiableChildren;
    private final List<Call> mUnmodifiableConferenceableCalls;
    private VideoCall mVideoCall;

    public static class Details {
        public static final int CAPABILITY_DISCONNECT_FROM_CONFERENCE = 8192;
        public static final int CAPABILITY_GENERIC_CONFERENCE = 16384;
        public static final int CAPABILITY_HIGH_DEF_AUDIO = 1024;
        public static final int CAPABILITY_HOLD = 1;
        public static final int CAPABILITY_MANAGE_CONFERENCE = 128;
        public static final int CAPABILITY_MERGE_CONFERENCE = 4;
        public static final int CAPABILITY_MUTE = 64;
        public static final int CAPABILITY_RESPOND_VIA_TEXT = 32;
        public static final int CAPABILITY_SEPARATE_FROM_CONFERENCE = 4096;
        public static final int CAPABILITY_SPEED_UP_MT_AUDIO = 32768;
        public static final int CAPABILITY_SUPPORTS_VT_LOCAL = 256;
        public static final int CAPABILITY_SUPPORTS_VT_REMOTE = 512;
        public static final int CAPABILITY_SUPPORT_HOLD = 2;
        public static final int CAPABILITY_SWAP_CONFERENCE = 8;
        public static final int CAPABILITY_UNUSED = 16;
        public static final int CAPABILITY_VoWIFI = 2048;
        private final PhoneAccountHandle mAccountHandle;
        private final int mCallCapabilities;
        private final int mCallProperties;
        private final String mCallerDisplayName;
        private final int mCallerDisplayNamePresentation;
        private final long mConnectTimeMillis;
        private final DisconnectCause mDisconnectCause;
        private final Bundle mExtras;
        private final GatewayInfo mGatewayInfo;
        private final Uri mHandle;
        private final int mHandlePresentation;
        private final StatusHints mStatusHints;
        private final int mVideoState;

        public static boolean can(int capabilities, int capability) {
            return (capabilities & capability) != 0;
        }

        public boolean can(int capability) {
            return can(this.mCallCapabilities, capability);
        }

        public static String capabilitiesToString(int capabilities) {
            StringBuilder builder = new StringBuilder();
            builder.append("[Capabilities:");
            if (can(capabilities, CAPABILITY_HOLD)) {
                builder.append(" CAPABILITY_HOLD");
            }
            if (can(capabilities, CAPABILITY_SUPPORT_HOLD)) {
                builder.append(" CAPABILITY_SUPPORT_HOLD");
            }
            if (can(capabilities, CAPABILITY_MERGE_CONFERENCE)) {
                builder.append(" CAPABILITY_MERGE_CONFERENCE");
            }
            if (can(capabilities, CAPABILITY_SWAP_CONFERENCE)) {
                builder.append(" CAPABILITY_SWAP_CONFERENCE");
            }
            if (can(capabilities, CAPABILITY_RESPOND_VIA_TEXT)) {
                builder.append(" CAPABILITY_RESPOND_VIA_TEXT");
            }
            if (can(capabilities, CAPABILITY_MUTE)) {
                builder.append(" CAPABILITY_MUTE");
            }
            if (can(capabilities, CAPABILITY_MANAGE_CONFERENCE)) {
                builder.append(" CAPABILITY_MANAGE_CONFERENCE");
            }
            if (can(capabilities, CAPABILITY_SUPPORTS_VT_LOCAL)) {
                builder.append(" CAPABILITY_SUPPORTS_VT_LOCAL");
            }
            if (can(capabilities, CAPABILITY_SUPPORTS_VT_REMOTE)) {
                builder.append(" CAPABILITY_SUPPORTS_VT_REMOTE");
            }
            if (can(capabilities, CAPABILITY_HIGH_DEF_AUDIO)) {
                builder.append(" CAPABILITY_HIGH_DEF_AUDIO");
            }
            if (can(capabilities, CAPABILITY_VoWIFI)) {
                builder.append(" CAPABILITY_VoWIFI");
            }
            if (can(capabilities, CAPABILITY_GENERIC_CONFERENCE)) {
                builder.append(" CAPABILITY_GENERIC_CONFERENCE");
            }
            if (can(capabilities, CAPABILITY_SPEED_UP_MT_AUDIO)) {
                builder.append(" CAPABILITY_SPEED_UP_IMS_MT_AUDIO");
            }
            builder.append("]");
            return builder.toString();
        }

        public Uri getHandle() {
            return this.mHandle;
        }

        public int getHandlePresentation() {
            return this.mHandlePresentation;
        }

        public String getCallerDisplayName() {
            return this.mCallerDisplayName;
        }

        public int getCallerDisplayNamePresentation() {
            return this.mCallerDisplayNamePresentation;
        }

        public PhoneAccountHandle getAccountHandle() {
            return this.mAccountHandle;
        }

        public int getCallCapabilities() {
            return this.mCallCapabilities;
        }

        public int getCallProperties() {
            return this.mCallProperties;
        }

        public DisconnectCause getDisconnectCause() {
            return this.mDisconnectCause;
        }

        public long getConnectTimeMillis() {
            return this.mConnectTimeMillis;
        }

        public GatewayInfo getGatewayInfo() {
            return this.mGatewayInfo;
        }

        public int getVideoState() {
            return this.mVideoState;
        }

        public StatusHints getStatusHints() {
            return this.mStatusHints;
        }

        public Bundle getExtras() {
            return this.mExtras;
        }

        public boolean equals(Object o) {
            if (!(o instanceof Details)) {
                return false;
            }
            Details d = (Details) o;
            if (Objects.equals(this.mHandle, d.mHandle) && Objects.equals(Integer.valueOf(this.mHandlePresentation), Integer.valueOf(d.mHandlePresentation)) && Objects.equals(this.mCallerDisplayName, d.mCallerDisplayName) && Objects.equals(Integer.valueOf(this.mCallerDisplayNamePresentation), Integer.valueOf(d.mCallerDisplayNamePresentation)) && Objects.equals(this.mAccountHandle, d.mAccountHandle) && Objects.equals(Integer.valueOf(this.mCallCapabilities), Integer.valueOf(d.mCallCapabilities)) && Objects.equals(Integer.valueOf(this.mCallProperties), Integer.valueOf(d.mCallProperties)) && Objects.equals(this.mDisconnectCause, d.mDisconnectCause) && Objects.equals(Long.valueOf(this.mConnectTimeMillis), Long.valueOf(d.mConnectTimeMillis)) && Objects.equals(this.mGatewayInfo, d.mGatewayInfo) && Objects.equals(Integer.valueOf(this.mVideoState), Integer.valueOf(d.mVideoState)) && Objects.equals(this.mStatusHints, d.mStatusHints) && Objects.equals(this.mExtras, d.mExtras)) {
                return true;
            }
            return false;
        }

        public int hashCode() {
            return (((((((((((Objects.hashCode(this.mHandle) + Objects.hashCode(Integer.valueOf(this.mHandlePresentation))) + Objects.hashCode(this.mCallerDisplayName)) + Objects.hashCode(Integer.valueOf(this.mCallerDisplayNamePresentation))) + Objects.hashCode(this.mAccountHandle)) + Objects.hashCode(Integer.valueOf(this.mCallCapabilities))) + Objects.hashCode(Integer.valueOf(this.mCallProperties))) + Objects.hashCode(this.mDisconnectCause)) + Objects.hashCode(Long.valueOf(this.mConnectTimeMillis))) + Objects.hashCode(this.mGatewayInfo)) + Objects.hashCode(Integer.valueOf(this.mVideoState))) + Objects.hashCode(this.mStatusHints)) + Objects.hashCode(this.mExtras);
        }

        public Details(Uri handle, int handlePresentation, String callerDisplayName, int callerDisplayNamePresentation, PhoneAccountHandle accountHandle, int capabilities, int properties, DisconnectCause disconnectCause, long connectTimeMillis, GatewayInfo gatewayInfo, int videoState, StatusHints statusHints, Bundle extras) {
            this.mHandle = handle;
            this.mHandlePresentation = handlePresentation;
            this.mCallerDisplayName = callerDisplayName;
            this.mCallerDisplayNamePresentation = callerDisplayNamePresentation;
            this.mAccountHandle = accountHandle;
            this.mCallCapabilities = capabilities;
            this.mCallProperties = properties;
            this.mDisconnectCause = disconnectCause;
            this.mConnectTimeMillis = connectTimeMillis;
            this.mGatewayInfo = gatewayInfo;
            this.mVideoState = videoState;
            this.mStatusHints = statusHints;
            this.mExtras = extras;
        }
    }

    public static abstract class Listener {
        public void onStateChanged(Call call, int state) {
        }

        public void onParentChanged(Call call, Call parent) {
        }

        public void onChildrenChanged(Call call, List<Call> list) {
        }

        public void onDetailsChanged(Call call, Details details) {
        }

        public void onCannedTextResponsesLoaded(Call call, List<String> list) {
        }

        public void onPostDialWait(Call call, String remainingPostDialSequence) {
        }

        public void onVideoCallChanged(Call call, VideoCall videoCall) {
        }

        public void onCallDestroyed(Call call) {
        }

        public void onConferenceableCallsChanged(Call call, List<Call> list) {
        }
    }

    public String getRemainingPostDialSequence() {
        return this.mRemainingPostDialSequence;
    }

    public void answer(int videoState) {
        this.mInCallAdapter.answerCall(this.mTelecomCallId, videoState);
    }

    public void reject(boolean rejectWithMessage, String textMessage) {
        this.mInCallAdapter.rejectCall(this.mTelecomCallId, rejectWithMessage, textMessage);
    }

    public void disconnect() {
        this.mInCallAdapter.disconnectCall(this.mTelecomCallId);
    }

    public void hold() {
        this.mInCallAdapter.holdCall(this.mTelecomCallId);
    }

    public void unhold() {
        this.mInCallAdapter.unholdCall(this.mTelecomCallId);
    }

    public void playDtmfTone(char digit) {
        this.mInCallAdapter.playDtmfTone(this.mTelecomCallId, digit);
    }

    public void stopDtmfTone() {
        this.mInCallAdapter.stopDtmfTone(this.mTelecomCallId);
    }

    public void postDialContinue(boolean proceed) {
        this.mInCallAdapter.postDialContinue(this.mTelecomCallId, proceed);
    }

    public void phoneAccountSelected(PhoneAccountHandle accountHandle, boolean setDefault) {
        this.mInCallAdapter.phoneAccountSelected(this.mTelecomCallId, accountHandle, setDefault);
    }

    public void conference(Call callToConferenceWith) {
        if (callToConferenceWith != null) {
            this.mInCallAdapter.conference(this.mTelecomCallId, callToConferenceWith.mTelecomCallId);
        }
    }

    public void splitFromConference() {
        this.mInCallAdapter.splitFromConference(this.mTelecomCallId);
    }

    public void mergeConference() {
        this.mInCallAdapter.mergeConference(this.mTelecomCallId);
    }

    public void swapConference() {
        this.mInCallAdapter.swapConference(this.mTelecomCallId);
    }

    public Call getParent() {
        if (this.mParentId != null) {
            return this.mPhone.internalGetCallByTelecomId(this.mParentId);
        }
        return null;
    }

    public List<Call> getChildren() {
        if (!this.mChildrenCached) {
            this.mChildrenCached = true;
            this.mChildren.clear();
            for (String id : this.mChildrenIds) {
                Call call = this.mPhone.internalGetCallByTelecomId(id);
                if (call == null) {
                    this.mChildrenCached = false;
                } else {
                    this.mChildren.add(call);
                }
            }
        }
        return this.mUnmodifiableChildren;
    }

    public List<Call> getConferenceableCalls() {
        return this.mUnmodifiableConferenceableCalls;
    }

    public int getState() {
        return this.mState;
    }

    public List<String> getCannedTextResponses() {
        return this.mCannedTextResponses;
    }

    public VideoCall getVideoCall() {
        return this.mVideoCall;
    }

    public Details getDetails() {
        return this.mDetails;
    }

    public void addListener(Listener listener) {
        this.mListeners.add(listener);
    }

    public void removeListener(Listener listener) {
        if (listener != null) {
            this.mListeners.remove(listener);
        }
    }

    Call(Phone phone, String telecomCallId, InCallAdapter inCallAdapter) {
        this.mChildrenIds = new ArrayList();
        this.mChildren = new ArrayList();
        this.mUnmodifiableChildren = Collections.unmodifiableList(this.mChildren);
        this.mListeners = new CopyOnWriteArrayList();
        this.mConferenceableCalls = new ArrayList();
        this.mUnmodifiableConferenceableCalls = Collections.unmodifiableList(this.mConferenceableCalls);
        this.mParentId = null;
        this.mCannedTextResponses = null;
        this.mPhone = phone;
        this.mTelecomCallId = telecomCallId;
        this.mInCallAdapter = inCallAdapter;
        this.mState = STATE_NEW;
    }

    final String internalGetCallId() {
        return this.mTelecomCallId;
    }

    final void internalUpdate(ParcelableCall parcelableCall, Map<String, Call> callIdMap) {
        Details details = new Details(parcelableCall.getHandle(), parcelableCall.getHandlePresentation(), parcelableCall.getCallerDisplayName(), parcelableCall.getCallerDisplayNamePresentation(), parcelableCall.getAccountHandle(), parcelableCall.getCapabilities(), parcelableCall.getProperties(), parcelableCall.getDisconnectCause(), parcelableCall.getConnectTimeMillis(), parcelableCall.getGatewayInfo(), parcelableCall.getVideoState(), parcelableCall.getStatusHints(), parcelableCall.getExtras());
        boolean detailsChanged = !Objects.equals(this.mDetails, details);
        if (detailsChanged) {
            this.mDetails = details;
        }
        if (!(this.mCannedTextResponses != null || parcelableCall.getCannedSmsResponses() == null || parcelableCall.getCannedSmsResponses().isEmpty())) {
            this.mCannedTextResponses = Collections.unmodifiableList(parcelableCall.getCannedSmsResponses());
        }
        boolean videoCallChanged = !Objects.equals(this.mVideoCall, parcelableCall.getVideoCall());
        if (videoCallChanged) {
            this.mVideoCall = parcelableCall.getVideoCall();
        }
        int state = stateFromParcelableCallState(parcelableCall.getState());
        boolean stateChanged = this.mState != state;
        if (stateChanged) {
            this.mState = state;
        }
        String parentId = parcelableCall.getParentCallId();
        boolean parentChanged = !Objects.equals(this.mParentId, parentId);
        if (parentChanged) {
            this.mParentId = parentId;
        }
        boolean childrenChanged = !Objects.equals(parcelableCall.getChildCallIds(), this.mChildrenIds);
        if (childrenChanged) {
            this.mChildrenIds.clear();
            this.mChildrenIds.addAll(parcelableCall.getChildCallIds());
            this.mChildrenCached = false;
        }
        List<String> conferenceableCallIds = parcelableCall.getConferenceableCallIds();
        List<Call> arrayList = new ArrayList(conferenceableCallIds.size());
        for (String otherId : conferenceableCallIds) {
            if (callIdMap.containsKey(otherId)) {
                arrayList.add(callIdMap.get(otherId));
            }
        }
        if (!Objects.equals(this.mConferenceableCalls, arrayList)) {
            this.mConferenceableCalls.clear();
            this.mConferenceableCalls.addAll(arrayList);
            fireConferenceableCallsChanged();
        }
        if (stateChanged) {
            fireStateChanged(this.mState);
        }
        if (detailsChanged) {
            fireDetailsChanged(this.mDetails);
        }
        if (false) {
            fireCannedTextResponsesLoaded(this.mCannedTextResponses);
        }
        if (videoCallChanged) {
            fireVideoCallChanged(this.mVideoCall);
        }
        if (parentChanged) {
            fireParentChanged(getParent());
        }
        if (childrenChanged) {
            fireChildrenChanged(getChildren());
        }
        if (this.mState == STATE_DISCONNECTED) {
            fireCallDestroyed();
            this.mPhone.internalRemoveCall(this);
        }
    }

    final void internalSetPostDialWait(String remaining) {
        this.mRemainingPostDialSequence = remaining;
        firePostDialWait(this.mRemainingPostDialSequence);
    }

    final void internalSetDisconnected() {
        if (this.mState != STATE_DISCONNECTED) {
            this.mState = STATE_DISCONNECTED;
            fireStateChanged(this.mState);
            fireCallDestroyed();
            this.mPhone.internalRemoveCall(this);
        }
    }

    private void fireStateChanged(int newState) {
        for (Listener listener : this.mListeners) {
            listener.onStateChanged(this, newState);
        }
    }

    private void fireParentChanged(Call newParent) {
        for (Listener listener : this.mListeners) {
            listener.onParentChanged(this, newParent);
        }
    }

    private void fireChildrenChanged(List<Call> children) {
        for (Listener listener : this.mListeners) {
            listener.onChildrenChanged(this, children);
        }
    }

    private void fireDetailsChanged(Details details) {
        for (Listener listener : this.mListeners) {
            listener.onDetailsChanged(this, details);
        }
    }

    private void fireCannedTextResponsesLoaded(List<String> cannedTextResponses) {
        for (Listener listener : this.mListeners) {
            listener.onCannedTextResponsesLoaded(this, cannedTextResponses);
        }
    }

    private void fireVideoCallChanged(VideoCall videoCall) {
        for (Listener listener : this.mListeners) {
            listener.onVideoCallChanged(this, videoCall);
        }
    }

    private void firePostDialWait(String remainingPostDialSequence) {
        for (Listener listener : this.mListeners) {
            listener.onPostDialWait(this, remainingPostDialSequence);
        }
    }

    private void fireCallDestroyed() {
        for (Listener listener : this.mListeners) {
            listener.onCallDestroyed(this);
        }
    }

    private void fireConferenceableCallsChanged() {
        for (Listener listener : this.mListeners) {
            listener.onConferenceableCallsChanged(this, this.mUnmodifiableConferenceableCalls);
        }
    }

    private int stateFromParcelableCallState(int parcelableCallState) {
        switch (parcelableCallState) {
            case STATE_NEW /*0*/:
                return STATE_NEW;
            case STATE_DIALING /*1*/:
                return STATE_CONNECTING;
            case STATE_RINGING /*2*/:
                return STATE_PRE_DIAL_WAIT;
            case STATE_HOLDING /*3*/:
                return STATE_DIALING;
            case STATE_ACTIVE /*4*/:
                return STATE_RINGING;
            case ReflectionActionWithoutParams.TAG /*5*/:
                return STATE_ACTIVE;
            case SetEmptyView.TAG /*6*/:
                return STATE_HOLDING;
            case STATE_DISCONNECTED /*7*/:
                return STATE_DISCONNECTED;
            case STATE_PRE_DIAL_WAIT /*8*/:
                return STATE_DISCONNECTED;
            case STATE_CONNECTING /*9*/:
                return STATE_DISCONNECTING;
            default:
                Object[] objArr = new Object[STATE_DIALING];
                objArr[STATE_NEW] = Integer.valueOf(parcelableCallState);
                Log.wtf((Object) this, "Unrecognized CallState %s", objArr);
                return STATE_NEW;
        }
    }
}
