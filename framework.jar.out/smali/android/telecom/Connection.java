package android.telecom;

import android.net.ProxyInfo;
import android.net.Uri;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.RemoteException;
import android.view.Surface;
import com.android.internal.telecom.IVideoCallback;
import com.android.internal.telecom.IVideoProvider;
import com.android.internal.telecom.IVideoProvider.Stub;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

public abstract class Connection implements IConferenceable {
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
    private static final boolean PII_DEBUG;
    public static final int STATE_ACTIVE = 4;
    public static final int STATE_DIALING = 3;
    public static final int STATE_DISCONNECTED = 6;
    public static final int STATE_HOLDING = 5;
    public static final int STATE_INITIALIZING = 0;
    public static final int STATE_NEW = 1;
    public static final int STATE_RINGING = 2;
    private Uri mAddress;
    private int mAddressPresentation;
    private boolean mAudioModeIsVoip;
    private AudioState mAudioState;
    private String mCallerDisplayName;
    private int mCallerDisplayNamePresentation;
    private Conference mConference;
    private final android.telecom.Conference.Listener mConferenceDeathListener;
    private final List<IConferenceable> mConferenceables;
    private int mConnectionCapabilities;
    private final Listener mConnectionDeathListener;
    private ConnectionService mConnectionService;
    private DisconnectCause mDisconnectCause;
    private final Set<Listener> mListeners;
    private boolean mRingbackRequested;
    private int mState;
    private StatusHints mStatusHints;
    private final List<IConferenceable> mUnmodifiableConferenceables;
    private VideoProvider mVideoProvider;
    private int mVideoState;

    public static abstract class Listener {
        public void onStateChanged(Connection c, int state) {
        }

        public void onAddressChanged(Connection c, Uri newAddress, int presentation) {
        }

        public void onCallerDisplayNameChanged(Connection c, String callerDisplayName, int presentation) {
        }

        public void onVideoStateChanged(Connection c, int videoState) {
        }

        public void onDisconnected(Connection c, DisconnectCause disconnectCause) {
        }

        public void onPostDialWait(Connection c, String remaining) {
        }

        public void onPostDialChar(Connection c, char nextChar) {
        }

        public void onRingbackRequested(Connection c, boolean ringback) {
        }

        public void onDestroyed(Connection c) {
        }

        public void onConnectionCapabilitiesChanged(Connection c, int capabilities) {
        }

        public void onVideoProviderChanged(Connection c, VideoProvider videoProvider) {
        }

        public void onAudioModeIsVoipChanged(Connection c, boolean isVoip) {
        }

        public void onStatusHintsChanged(Connection c, StatusHints statusHints) {
        }

        public void onConferenceablesChanged(Connection c, List<IConferenceable> list) {
        }

        public void onConferenceChanged(Connection c, Conference conference) {
        }

        public void onConferenceParticipantsChanged(Connection c, List<ConferenceParticipant> list) {
        }

        public void onConferenceStarted() {
        }
    }

    /* renamed from: android.telecom.Connection.1 */
    class C07301 extends Listener {
        C07301() {
        }

        public void onDestroyed(Connection c) {
            if (Connection.this.mConferenceables.remove(c)) {
                Connection.this.fireOnConferenceableConnectionsChanged();
            }
        }
    }

    /* renamed from: android.telecom.Connection.2 */
    class C07312 extends android.telecom.Conference.Listener {
        C07312() {
        }

        public void onDestroyed(Conference c) {
            if (Connection.this.mConferenceables.remove(c)) {
                Connection.this.fireOnConferenceableConnectionsChanged();
            }
        }
    }

    private static class FailureSignalingConnection extends Connection {
        private boolean mImmutable;

        public FailureSignalingConnection(DisconnectCause disconnectCause) {
            this.mImmutable = Connection.PII_DEBUG;
            setDisconnected(disconnectCause);
            this.mImmutable = true;
        }

        public void checkImmutable() {
            if (this.mImmutable) {
                throw new UnsupportedOperationException("Connection is immutable");
            }
        }
    }

    public static abstract class VideoProvider {
        private static final int MSG_REQUEST_CAMERA_CAPABILITIES = 9;
        private static final int MSG_REQUEST_CONNECTION_DATA_USAGE = 10;
        private static final int MSG_SEND_SESSION_MODIFY_REQUEST = 7;
        private static final int MSG_SEND_SESSION_MODIFY_RESPONSE = 8;
        private static final int MSG_SET_CAMERA = 2;
        private static final int MSG_SET_DEVICE_ORIENTATION = 5;
        private static final int MSG_SET_DISPLAY_SURFACE = 4;
        private static final int MSG_SET_PAUSE_IMAGE = 11;
        private static final int MSG_SET_PREVIEW_SURFACE = 3;
        private static final int MSG_SET_VIDEO_CALLBACK = 1;
        private static final int MSG_SET_ZOOM = 6;
        public static final int SESSION_EVENT_CAMERA_FAILURE = 5;
        public static final int SESSION_EVENT_CAMERA_READY = 6;
        public static final int SESSION_EVENT_RX_PAUSE = 1;
        public static final int SESSION_EVENT_RX_RESUME = 2;
        public static final int SESSION_EVENT_TX_START = 3;
        public static final int SESSION_EVENT_TX_STOP = 4;
        public static final int SESSION_MODIFY_REQUEST_FAIL = 2;
        public static final int SESSION_MODIFY_REQUEST_INVALID = 3;
        public static final int SESSION_MODIFY_REQUEST_SUCCESS = 1;
        private final VideoProviderBinder mBinder;
        private final VideoProviderHandler mMessageHandler;
        private IVideoCallback mVideoCallback;

        private final class VideoProviderBinder extends Stub {
            private VideoProviderBinder() {
            }

            public void setVideoCallback(IBinder videoCallbackBinder) {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.SESSION_MODIFY_REQUEST_SUCCESS, videoCallbackBinder).sendToTarget();
            }

            public void setCamera(String cameraId) {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.SESSION_MODIFY_REQUEST_FAIL, cameraId).sendToTarget();
            }

            public void setPreviewSurface(Surface surface) {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.SESSION_MODIFY_REQUEST_INVALID, surface).sendToTarget();
            }

            public void setDisplaySurface(Surface surface) {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.SESSION_EVENT_TX_STOP, surface).sendToTarget();
            }

            public void setDeviceOrientation(int rotation) {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.SESSION_EVENT_CAMERA_FAILURE, Integer.valueOf(rotation)).sendToTarget();
            }

            public void setZoom(float value) {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.SESSION_EVENT_CAMERA_READY, Float.valueOf(value)).sendToTarget();
            }

            public void sendSessionModifyRequest(VideoProfile requestProfile) {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.MSG_SEND_SESSION_MODIFY_REQUEST, requestProfile).sendToTarget();
            }

            public void sendSessionModifyResponse(VideoProfile responseProfile) {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.MSG_SEND_SESSION_MODIFY_RESPONSE, responseProfile).sendToTarget();
            }

            public void requestCameraCapabilities() {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.MSG_REQUEST_CAMERA_CAPABILITIES).sendToTarget();
            }

            public void requestCallDataUsage() {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.MSG_REQUEST_CONNECTION_DATA_USAGE).sendToTarget();
            }

            public void setPauseImage(String uri) {
                VideoProvider.this.mMessageHandler.obtainMessage(VideoProvider.MSG_SET_PAUSE_IMAGE, uri).sendToTarget();
            }
        }

        private final class VideoProviderHandler extends Handler {
            private VideoProviderHandler() {
            }

            public void handleMessage(Message msg) {
                switch (msg.what) {
                    case VideoProvider.SESSION_MODIFY_REQUEST_SUCCESS /*1*/:
                        VideoProvider.this.mVideoCallback = IVideoCallback.Stub.asInterface((IBinder) msg.obj);
                    case VideoProvider.SESSION_MODIFY_REQUEST_FAIL /*2*/:
                        VideoProvider.this.onSetCamera((String) msg.obj);
                    case VideoProvider.SESSION_MODIFY_REQUEST_INVALID /*3*/:
                        VideoProvider.this.onSetPreviewSurface((Surface) msg.obj);
                    case VideoProvider.SESSION_EVENT_TX_STOP /*4*/:
                        VideoProvider.this.onSetDisplaySurface((Surface) msg.obj);
                    case VideoProvider.SESSION_EVENT_CAMERA_FAILURE /*5*/:
                        VideoProvider.this.onSetDeviceOrientation(msg.arg1);
                    case VideoProvider.SESSION_EVENT_CAMERA_READY /*6*/:
                        VideoProvider.this.onSetZoom(((Float) msg.obj).floatValue());
                    case VideoProvider.MSG_SEND_SESSION_MODIFY_REQUEST /*7*/:
                        VideoProvider.this.onSendSessionModifyRequest((VideoProfile) msg.obj);
                    case VideoProvider.MSG_SEND_SESSION_MODIFY_RESPONSE /*8*/:
                        VideoProvider.this.onSendSessionModifyResponse((VideoProfile) msg.obj);
                    case VideoProvider.MSG_REQUEST_CAMERA_CAPABILITIES /*9*/:
                        VideoProvider.this.onRequestCameraCapabilities();
                    case VideoProvider.MSG_REQUEST_CONNECTION_DATA_USAGE /*10*/:
                        VideoProvider.this.onRequestConnectionDataUsage();
                    case VideoProvider.MSG_SET_PAUSE_IMAGE /*11*/:
                        VideoProvider.this.onSetPauseImage((String) msg.obj);
                    default:
                }
            }
        }

        public abstract void onRequestCameraCapabilities();

        public abstract void onRequestConnectionDataUsage();

        public abstract void onSendSessionModifyRequest(VideoProfile videoProfile);

        public abstract void onSendSessionModifyResponse(VideoProfile videoProfile);

        public abstract void onSetCamera(String str);

        public abstract void onSetDeviceOrientation(int i);

        public abstract void onSetDisplaySurface(Surface surface);

        public abstract void onSetPauseImage(String str);

        public abstract void onSetPreviewSurface(Surface surface);

        public abstract void onSetZoom(float f);

        public VideoProvider() {
            this.mMessageHandler = new VideoProviderHandler();
            this.mBinder = new VideoProviderBinder();
        }

        public final IVideoProvider getInterface() {
            return this.mBinder;
        }

        public void receiveSessionModifyRequest(VideoProfile videoProfile) {
            if (this.mVideoCallback != null) {
                try {
                    this.mVideoCallback.receiveSessionModifyRequest(videoProfile);
                } catch (RemoteException e) {
                }
            }
        }

        public void receiveSessionModifyResponse(int status, VideoProfile requestedProfile, VideoProfile responseProfile) {
            if (this.mVideoCallback != null) {
                try {
                    this.mVideoCallback.receiveSessionModifyResponse(status, requestedProfile, responseProfile);
                } catch (RemoteException e) {
                }
            }
        }

        public void handleCallSessionEvent(int event) {
            if (this.mVideoCallback != null) {
                try {
                    this.mVideoCallback.handleCallSessionEvent(event);
                } catch (RemoteException e) {
                }
            }
        }

        public void changePeerDimensions(int width, int height) {
            if (this.mVideoCallback != null) {
                try {
                    this.mVideoCallback.changePeerDimensions(width, height);
                } catch (RemoteException e) {
                }
            }
        }

        public void changeCallDataUsage(int dataUsage) {
            if (this.mVideoCallback != null) {
                try {
                    this.mVideoCallback.changeCallDataUsage(dataUsage);
                } catch (RemoteException e) {
                }
            }
        }

        public void changeCameraCapabilities(CameraCapabilities cameraCapabilities) {
            if (this.mVideoCallback != null) {
                try {
                    this.mVideoCallback.changeCameraCapabilities(cameraCapabilities);
                } catch (RemoteException e) {
                }
            }
        }
    }

    static {
        PII_DEBUG = Log.isLoggable(STATE_DIALING);
    }

    public static boolean can(int capabilities, int capability) {
        return (capabilities & capability) != 0 ? true : PII_DEBUG;
    }

    public boolean can(int capability) {
        return can(this.mConnectionCapabilities, capability);
    }

    public void removeCapability(int capability) {
        this.mConnectionCapabilities &= capability ^ -1;
    }

    public void addCapability(int capability) {
        this.mConnectionCapabilities |= capability;
    }

    public static String capabilitiesToString(int capabilities) {
        StringBuilder builder = new StringBuilder();
        builder.append("[Capabilities:");
        if (can(capabilities, STATE_NEW)) {
            builder.append(" CAPABILITY_HOLD");
        }
        if (can(capabilities, STATE_RINGING)) {
            builder.append(" CAPABILITY_SUPPORT_HOLD");
        }
        if (can(capabilities, STATE_ACTIVE)) {
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

    public Connection() {
        this.mConnectionDeathListener = new C07301();
        this.mConferenceDeathListener = new C07312();
        this.mListeners = Collections.newSetFromMap(new ConcurrentHashMap(CAPABILITY_SWAP_CONFERENCE, 0.9f, STATE_NEW));
        this.mConferenceables = new ArrayList();
        this.mUnmodifiableConferenceables = Collections.unmodifiableList(this.mConferenceables);
        this.mState = STATE_NEW;
        this.mRingbackRequested = PII_DEBUG;
    }

    public final Uri getAddress() {
        return this.mAddress;
    }

    public final int getAddressPresentation() {
        return this.mAddressPresentation;
    }

    public final String getCallerDisplayName() {
        return this.mCallerDisplayName;
    }

    public final int getCallerDisplayNamePresentation() {
        return this.mCallerDisplayNamePresentation;
    }

    public final int getState() {
        return this.mState;
    }

    public final int getVideoState() {
        return this.mVideoState;
    }

    public final AudioState getAudioState() {
        return this.mAudioState;
    }

    public final Conference getConference() {
        return this.mConference;
    }

    public final boolean isRingbackRequested() {
        return this.mRingbackRequested;
    }

    public final boolean getAudioModeIsVoip() {
        return this.mAudioModeIsVoip;
    }

    public final StatusHints getStatusHints() {
        return this.mStatusHints;
    }

    public final Connection addConnectionListener(Listener l) {
        this.mListeners.add(l);
        return this;
    }

    public final Connection removeConnectionListener(Listener l) {
        if (l != null) {
            this.mListeners.remove(l);
        }
        return this;
    }

    public final DisconnectCause getDisconnectCause() {
        return this.mDisconnectCause;
    }

    final void setAudioState(AudioState state) {
        checkImmutable();
        Object[] objArr = new Object[STATE_NEW];
        objArr[STATE_INITIALIZING] = state;
        Log.m3d((Object) this, "setAudioState %s", objArr);
        this.mAudioState = state;
        onAudioStateChanged(state);
    }

    public static String stateToString(int state) {
        switch (state) {
            case STATE_INITIALIZING /*0*/:
                return "STATE_INITIALIZING";
            case STATE_NEW /*1*/:
                return "STATE_NEW";
            case STATE_RINGING /*2*/:
                return "STATE_RINGING";
            case STATE_DIALING /*3*/:
                return "STATE_DIALING";
            case STATE_ACTIVE /*4*/:
                return "STATE_ACTIVE";
            case STATE_HOLDING /*5*/:
                return "STATE_HOLDING";
            case STATE_DISCONNECTED /*6*/:
                return "DISCONNECTED";
            default:
                Object[] objArr = new Object[STATE_NEW];
                objArr[STATE_INITIALIZING] = Integer.valueOf(state);
                Log.wtf((Object) Connection.class, "Unknown state %d", objArr);
                return "UNKNOWN";
        }
    }

    public final int getConnectionCapabilities() {
        return this.mConnectionCapabilities;
    }

    @Deprecated
    public final int getCallCapabilities() {
        return getConnectionCapabilities();
    }

    public final void setAddress(Uri address, int presentation) {
        checkImmutable();
        Object[] objArr = new Object[STATE_NEW];
        objArr[STATE_INITIALIZING] = address;
        Log.m3d((Object) this, "setAddress %s", objArr);
        this.mAddress = address;
        this.mAddressPresentation = presentation;
        for (Listener l : this.mListeners) {
            l.onAddressChanged(this, address, presentation);
        }
    }

    public final void setCallerDisplayName(String callerDisplayName, int presentation) {
        checkImmutable();
        Object[] objArr = new Object[STATE_NEW];
        objArr[STATE_INITIALIZING] = callerDisplayName;
        Log.m3d((Object) this, "setCallerDisplayName %s", objArr);
        this.mCallerDisplayName = callerDisplayName;
        this.mCallerDisplayNamePresentation = presentation;
        for (Listener l : this.mListeners) {
            l.onCallerDisplayNameChanged(this, callerDisplayName, presentation);
        }
    }

    public final void setVideoState(int videoState) {
        checkImmutable();
        Object[] objArr = new Object[STATE_NEW];
        objArr[STATE_INITIALIZING] = Integer.valueOf(videoState);
        Log.m3d((Object) this, "setVideoState %d", objArr);
        this.mVideoState = videoState;
        for (Listener l : this.mListeners) {
            l.onVideoStateChanged(this, this.mVideoState);
        }
    }

    public final void setActive() {
        checkImmutable();
        setRingbackRequested(PII_DEBUG);
        setState(STATE_ACTIVE);
    }

    public final void setRinging() {
        checkImmutable();
        setState(STATE_RINGING);
    }

    public final void setInitializing() {
        checkImmutable();
        setState(STATE_INITIALIZING);
    }

    public final void setInitialized() {
        checkImmutable();
        setState(STATE_NEW);
    }

    public final void setDialing() {
        checkImmutable();
        setState(STATE_DIALING);
    }

    public final void setOnHold() {
        checkImmutable();
        setState(STATE_HOLDING);
    }

    public final void setVideoProvider(VideoProvider videoProvider) {
        checkImmutable();
        this.mVideoProvider = videoProvider;
        for (Listener l : this.mListeners) {
            l.onVideoProviderChanged(this, videoProvider);
        }
    }

    public final VideoProvider getVideoProvider() {
        return this.mVideoProvider;
    }

    public final void setDisconnected(DisconnectCause disconnectCause) {
        checkImmutable();
        this.mDisconnectCause = disconnectCause;
        setState(STATE_DISCONNECTED);
        Object[] objArr = new Object[STATE_NEW];
        objArr[STATE_INITIALIZING] = disconnectCause;
        Log.m3d((Object) this, "Disconnected with cause %s", objArr);
        for (Listener l : this.mListeners) {
            l.onDisconnected(this, disconnectCause);
        }
    }

    public final void setPostDialWait(String remaining) {
        checkImmutable();
        for (Listener l : this.mListeners) {
            l.onPostDialWait(this, remaining);
        }
    }

    public final void setNextPostDialWaitChar(char nextChar) {
        checkImmutable();
        for (Listener l : this.mListeners) {
            l.onPostDialChar(this, nextChar);
        }
    }

    public final void setRingbackRequested(boolean ringback) {
        checkImmutable();
        if (this.mRingbackRequested != ringback) {
            this.mRingbackRequested = ringback;
            for (Listener l : this.mListeners) {
                l.onRingbackRequested(this, ringback);
            }
        }
    }

    @Deprecated
    public final void setCallCapabilities(int connectionCapabilities) {
        setConnectionCapabilities(connectionCapabilities);
    }

    public final void setConnectionCapabilities(int connectionCapabilities) {
        checkImmutable();
        if (this.mConnectionCapabilities != connectionCapabilities) {
            this.mConnectionCapabilities = connectionCapabilities;
            for (Listener l : this.mListeners) {
                l.onConnectionCapabilitiesChanged(this, this.mConnectionCapabilities);
            }
        }
    }

    public final void destroy() {
        for (Listener l : this.mListeners) {
            l.onDestroyed(this);
        }
    }

    public final void setAudioModeIsVoip(boolean isVoip) {
        checkImmutable();
        this.mAudioModeIsVoip = isVoip;
        for (Listener l : this.mListeners) {
            l.onAudioModeIsVoipChanged(this, isVoip);
        }
    }

    public final void setStatusHints(StatusHints statusHints) {
        checkImmutable();
        this.mStatusHints = statusHints;
        for (Listener l : this.mListeners) {
            l.onStatusHintsChanged(this, statusHints);
        }
    }

    public final void setConferenceableConnections(List<Connection> conferenceableConnections) {
        checkImmutable();
        clearConferenceableList();
        for (Connection c : conferenceableConnections) {
            if (!this.mConferenceables.contains(c)) {
                c.addConnectionListener(this.mConnectionDeathListener);
                this.mConferenceables.add(c);
            }
        }
        fireOnConferenceableConnectionsChanged();
    }

    public final void setConferenceables(List<IConferenceable> conferenceables) {
        clearConferenceableList();
        for (IConferenceable c : conferenceables) {
            if (!this.mConferenceables.contains(c)) {
                if (c instanceof Connection) {
                    ((Connection) c).addConnectionListener(this.mConnectionDeathListener);
                } else if (c instanceof Conference) {
                    ((Conference) c).addListener(this.mConferenceDeathListener);
                }
                this.mConferenceables.add(c);
            }
        }
        fireOnConferenceableConnectionsChanged();
    }

    public final List<IConferenceable> getConferenceables() {
        return this.mUnmodifiableConferenceables;
    }

    public final void setConnectionService(ConnectionService connectionService) {
        checkImmutable();
        if (this.mConnectionService != null) {
            Log.m5e((Object) this, new Exception(), "Trying to set ConnectionService on a connection which is already associated with another ConnectionService.", new Object[STATE_INITIALIZING]);
        } else {
            this.mConnectionService = connectionService;
        }
    }

    public final void unsetConnectionService(ConnectionService connectionService) {
        if (this.mConnectionService != connectionService) {
            Log.m5e((Object) this, new Exception(), "Trying to remove ConnectionService from a Connection that does not belong to the ConnectionService.", new Object[STATE_INITIALIZING]);
        } else {
            this.mConnectionService = null;
        }
    }

    public final ConnectionService getConnectionService() {
        return this.mConnectionService;
    }

    public final boolean setConference(Conference conference) {
        checkImmutable();
        if (this.mConference != null) {
            return PII_DEBUG;
        }
        this.mConference = conference;
        if (this.mConnectionService != null && this.mConnectionService.containsConference(conference)) {
            fireConferenceChanged();
        }
        return true;
    }

    public final void resetConference() {
        if (this.mConference != null) {
            Log.m3d((Object) this, "Conference reset", new Object[STATE_INITIALIZING]);
            this.mConference = null;
            fireConferenceChanged();
        }
    }

    public void onAudioStateChanged(AudioState state) {
    }

    public void onStateChanged(int state) {
    }

    public void onPlayDtmfTone(char c) {
    }

    public void onStopDtmfTone() {
    }

    public void onDisconnect() {
    }

    public void onDisconnectConferenceParticipant(Uri endpoint) {
    }

    public void onSeparate() {
    }

    public void onAbort() {
    }

    public void onHold() {
    }

    public void onUnhold() {
    }

    public void onAnswer(int videoState) {
    }

    public void onAnswer() {
        onAnswer(STATE_INITIALIZING);
    }

    public void onReject() {
    }

    public void onPostDialContinue(boolean proceed) {
    }

    static String toLogSafePhoneNumber(String number) {
        if (number == null) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
        if (PII_DEBUG) {
            return number;
        }
        StringBuilder builder = new StringBuilder();
        for (int i = STATE_INITIALIZING; i < number.length(); i += STATE_NEW) {
            char c = number.charAt(i);
            if (c == '-' || c == '@' || c == '.') {
                builder.append(c);
            } else {
                builder.append('x');
            }
        }
        return builder.toString();
    }

    private void setState(int state) {
        checkImmutable();
        if (this.mState == STATE_DISCONNECTED && this.mState != state) {
            Log.m3d((Object) this, "Connection already DISCONNECTED; cannot transition out of this state.", new Object[STATE_INITIALIZING]);
        } else if (this.mState != state) {
            Object[] objArr = new Object[STATE_NEW];
            objArr[STATE_INITIALIZING] = stateToString(state);
            Log.m3d((Object) this, "setState: %s", objArr);
            this.mState = state;
            onStateChanged(state);
            for (Listener l : this.mListeners) {
                l.onStateChanged(this, state);
            }
        }
    }

    public static Connection createFailedConnection(DisconnectCause disconnectCause) {
        return new FailureSignalingConnection(disconnectCause);
    }

    public void checkImmutable() {
    }

    public static Connection createCanceledConnection() {
        return new FailureSignalingConnection(new DisconnectCause(STATE_ACTIVE));
    }

    private final void fireOnConferenceableConnectionsChanged() {
        for (Listener l : this.mListeners) {
            l.onConferenceablesChanged(this, getConferenceables());
        }
    }

    private final void fireConferenceChanged() {
        for (Listener l : this.mListeners) {
            l.onConferenceChanged(this, this.mConference);
        }
    }

    private final void clearConferenceableList() {
        for (IConferenceable c : this.mConferenceables) {
            if (c instanceof Connection) {
                ((Connection) c).removeConnectionListener(this.mConnectionDeathListener);
            } else if (c instanceof Conference) {
                ((Conference) c).removeListener(this.mConferenceDeathListener);
            }
        }
        this.mConferenceables.clear();
    }

    protected final void updateConferenceParticipants(List<ConferenceParticipant> conferenceParticipants) {
        for (Listener l : this.mListeners) {
            l.onConferenceParticipantsChanged(this, conferenceParticipants);
        }
    }

    protected void notifyConferenceStarted() {
        for (Listener l : this.mListeners) {
            l.onConferenceStarted();
        }
    }
}
