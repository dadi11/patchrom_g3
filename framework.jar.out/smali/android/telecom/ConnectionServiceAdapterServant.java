package android.telecom;

import android.net.Uri;
import android.os.Handler;
import android.os.Message;
import android.os.RemoteException;
import com.android.internal.os.SomeArgs;
import com.android.internal.telecom.IConnectionServiceAdapter;
import com.android.internal.telecom.IConnectionServiceAdapter.Stub;
import com.android.internal.telecom.IVideoProvider;
import com.android.internal.telecom.RemoteServiceCallback;
import java.util.List;

final class ConnectionServiceAdapterServant {
    private static final int MSG_ADD_CONFERENCE_CALL = 10;
    private static final int MSG_ADD_EXISTING_CONNECTION = 21;
    private static final int MSG_HANDLE_CREATE_CONNECTION_COMPLETE = 1;
    private static final int MSG_ON_POST_DIAL_CHAR = 22;
    private static final int MSG_ON_POST_DIAL_WAIT = 12;
    private static final int MSG_QUERY_REMOTE_CALL_SERVICES = 13;
    private static final int MSG_REMOVE_CALL = 11;
    private static final int MSG_SET_ACTIVE = 2;
    private static final int MSG_SET_ADDRESS = 18;
    private static final int MSG_SET_CALLER_DISPLAY_NAME = 19;
    private static final int MSG_SET_CONFERENCEABLE_CONNECTIONS = 20;
    private static final int MSG_SET_CONNECTION_CAPABILITIES = 8;
    private static final int MSG_SET_DIALING = 4;
    private static final int MSG_SET_DISCONNECTED = 5;
    private static final int MSG_SET_IS_CONFERENCED = 9;
    private static final int MSG_SET_IS_VOIP_AUDIO_MODE = 16;
    private static final int MSG_SET_ON_HOLD = 6;
    private static final int MSG_SET_RINGBACK_REQUESTED = 7;
    private static final int MSG_SET_RINGING = 3;
    private static final int MSG_SET_STATUS_HINTS = 17;
    private static final int MSG_SET_VIDEO_CALL_PROVIDER = 15;
    private static final int MSG_SET_VIDEO_STATE = 14;
    private final IConnectionServiceAdapter mDelegate;
    private final Handler mHandler;
    private final IConnectionServiceAdapter mStub;

    /* renamed from: android.telecom.ConnectionServiceAdapterServant.1 */
    class C07431 extends Handler {
        C07431() {
        }

        public void handleMessage(Message msg) {
            try {
                internalHandleMessage(msg);
            } catch (RemoteException e) {
            }
        }

        private void internalHandleMessage(Message msg) throws RemoteException {
            boolean z = true;
            SomeArgs args;
            IConnectionServiceAdapter access$000;
            String str;
            switch (msg.what) {
                case ConnectionServiceAdapterServant.MSG_HANDLE_CREATE_CONNECTION_COMPLETE /*1*/:
                    args = msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.handleCreateConnectionComplete((String) args.arg1, (ConnectionRequest) args.arg2, (ParcelableConnection) args.arg3);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_SET_ACTIVE /*2*/:
                    ConnectionServiceAdapterServant.this.mDelegate.setActive((String) msg.obj);
                case ConnectionServiceAdapterServant.MSG_SET_RINGING /*3*/:
                    ConnectionServiceAdapterServant.this.mDelegate.setRinging((String) msg.obj);
                case ConnectionServiceAdapterServant.MSG_SET_DIALING /*4*/:
                    ConnectionServiceAdapterServant.this.mDelegate.setDialing((String) msg.obj);
                case ConnectionServiceAdapterServant.MSG_SET_DISCONNECTED /*5*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.setDisconnected((String) args.arg1, (DisconnectCause) args.arg2);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_SET_ON_HOLD /*6*/:
                    ConnectionServiceAdapterServant.this.mDelegate.setOnHold((String) msg.obj);
                case ConnectionServiceAdapterServant.MSG_SET_RINGBACK_REQUESTED /*7*/:
                    access$000 = ConnectionServiceAdapterServant.this.mDelegate;
                    str = (String) msg.obj;
                    if (msg.arg1 != ConnectionServiceAdapterServant.MSG_HANDLE_CREATE_CONNECTION_COMPLETE) {
                        z = false;
                    }
                    access$000.setRingbackRequested(str, z);
                case ConnectionServiceAdapterServant.MSG_SET_CONNECTION_CAPABILITIES /*8*/:
                    ConnectionServiceAdapterServant.this.mDelegate.setConnectionCapabilities((String) msg.obj, msg.arg1);
                case ConnectionServiceAdapterServant.MSG_SET_IS_CONFERENCED /*9*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.setIsConferenced((String) args.arg1, (String) args.arg2);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_ADD_CONFERENCE_CALL /*10*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.addConferenceCall((String) args.arg1, (ParcelableConference) args.arg2);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_REMOVE_CALL /*11*/:
                    ConnectionServiceAdapterServant.this.mDelegate.removeCall((String) msg.obj);
                case ConnectionServiceAdapterServant.MSG_ON_POST_DIAL_WAIT /*12*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.onPostDialWait((String) args.arg1, (String) args.arg2);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_QUERY_REMOTE_CALL_SERVICES /*13*/:
                    ConnectionServiceAdapterServant.this.mDelegate.queryRemoteConnectionServices((RemoteServiceCallback) msg.obj);
                case ConnectionServiceAdapterServant.MSG_SET_VIDEO_STATE /*14*/:
                    ConnectionServiceAdapterServant.this.mDelegate.setVideoState((String) msg.obj, msg.arg1);
                case ConnectionServiceAdapterServant.MSG_SET_VIDEO_CALL_PROVIDER /*15*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.setVideoProvider((String) args.arg1, (IVideoProvider) args.arg2);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_SET_IS_VOIP_AUDIO_MODE /*16*/:
                    access$000 = ConnectionServiceAdapterServant.this.mDelegate;
                    str = (String) msg.obj;
                    if (msg.arg1 != ConnectionServiceAdapterServant.MSG_HANDLE_CREATE_CONNECTION_COMPLETE) {
                        z = false;
                    }
                    access$000.setIsVoipAudioMode(str, z);
                case ConnectionServiceAdapterServant.MSG_SET_STATUS_HINTS /*17*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.setStatusHints((String) args.arg1, (StatusHints) args.arg2);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_SET_ADDRESS /*18*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.setAddress((String) args.arg1, (Uri) args.arg2, args.argi1);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_SET_CALLER_DISPLAY_NAME /*19*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.setCallerDisplayName((String) args.arg1, (String) args.arg2, args.argi1);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_SET_CONFERENCEABLE_CONNECTIONS /*20*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.setConferenceableConnections((String) args.arg1, (List) args.arg2);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_ADD_EXISTING_CONNECTION /*21*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.addExistingConnection((String) args.arg1, (ParcelableConnection) args.arg2);
                    } finally {
                        args.recycle();
                    }
                case ConnectionServiceAdapterServant.MSG_ON_POST_DIAL_CHAR /*22*/:
                    args = (SomeArgs) msg.obj;
                    try {
                        ConnectionServiceAdapterServant.this.mDelegate.onPostDialChar((String) args.arg1, (char) args.argi1);
                    } finally {
                        args.recycle();
                    }
                default:
            }
        }
    }

    /* renamed from: android.telecom.ConnectionServiceAdapterServant.2 */
    class C07442 extends Stub {
        C07442() {
        }

        public void handleCreateConnectionComplete(String id, ConnectionRequest request, ParcelableConnection connection) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = id;
            args.arg2 = request;
            args.arg3 = connection;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_HANDLE_CREATE_CONNECTION_COMPLETE, args).sendToTarget();
        }

        public void setActive(String connectionId) {
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_ACTIVE, connectionId).sendToTarget();
        }

        public void setRinging(String connectionId) {
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_RINGING, connectionId).sendToTarget();
        }

        public void setDialing(String connectionId) {
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_DIALING, connectionId).sendToTarget();
        }

        public void setDisconnected(String connectionId, DisconnectCause disconnectCause) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = connectionId;
            args.arg2 = disconnectCause;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_DISCONNECTED, args).sendToTarget();
        }

        public void setOnHold(String connectionId) {
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_ON_HOLD, connectionId).sendToTarget();
        }

        public void setRingbackRequested(String connectionId, boolean ringback) {
            int i;
            Handler access$100 = ConnectionServiceAdapterServant.this.mHandler;
            if (ringback) {
                i = ConnectionServiceAdapterServant.MSG_HANDLE_CREATE_CONNECTION_COMPLETE;
            } else {
                i = 0;
            }
            access$100.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_RINGBACK_REQUESTED, i, 0, connectionId).sendToTarget();
        }

        public void setConnectionCapabilities(String connectionId, int connectionCapabilities) {
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_CONNECTION_CAPABILITIES, connectionCapabilities, 0, connectionId).sendToTarget();
        }

        public void setIsConferenced(String callId, String conferenceCallId) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = callId;
            args.arg2 = conferenceCallId;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_IS_CONFERENCED, args).sendToTarget();
        }

        public void addConferenceCall(String callId, ParcelableConference parcelableConference) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = callId;
            args.arg2 = parcelableConference;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_ADD_CONFERENCE_CALL, args).sendToTarget();
        }

        public void removeCall(String connectionId) {
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_REMOVE_CALL, connectionId).sendToTarget();
        }

        public void onPostDialWait(String connectionId, String remainingDigits) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = connectionId;
            args.arg2 = remainingDigits;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_ON_POST_DIAL_WAIT, args).sendToTarget();
        }

        public void onPostDialChar(String connectionId, char nextChar) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = connectionId;
            args.argi1 = nextChar;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_ON_POST_DIAL_CHAR, args).sendToTarget();
        }

        public void queryRemoteConnectionServices(RemoteServiceCallback callback) {
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_QUERY_REMOTE_CALL_SERVICES, callback).sendToTarget();
        }

        public void setVideoState(String connectionId, int videoState) {
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_VIDEO_STATE, videoState, 0, connectionId).sendToTarget();
        }

        public void setVideoProvider(String connectionId, IVideoProvider videoProvider) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = connectionId;
            args.arg2 = videoProvider;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_VIDEO_CALL_PROVIDER, args).sendToTarget();
        }

        public final void setIsVoipAudioMode(String connectionId, boolean isVoip) {
            int i;
            Handler access$100 = ConnectionServiceAdapterServant.this.mHandler;
            if (isVoip) {
                i = ConnectionServiceAdapterServant.MSG_HANDLE_CREATE_CONNECTION_COMPLETE;
            } else {
                i = 0;
            }
            access$100.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_IS_VOIP_AUDIO_MODE, i, 0, connectionId).sendToTarget();
        }

        public final void setStatusHints(String connectionId, StatusHints statusHints) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = connectionId;
            args.arg2 = statusHints;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_STATUS_HINTS, args).sendToTarget();
        }

        public final void setAddress(String connectionId, Uri address, int presentation) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = connectionId;
            args.arg2 = address;
            args.argi1 = presentation;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_ADDRESS, args).sendToTarget();
        }

        public final void setCallerDisplayName(String connectionId, String callerDisplayName, int presentation) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = connectionId;
            args.arg2 = callerDisplayName;
            args.argi1 = presentation;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_CALLER_DISPLAY_NAME, args).sendToTarget();
        }

        public final void setConferenceableConnections(String connectionId, List<String> conferenceableConnectionIds) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = connectionId;
            args.arg2 = conferenceableConnectionIds;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_SET_CONFERENCEABLE_CONNECTIONS, args).sendToTarget();
        }

        public final void addExistingConnection(String connectionId, ParcelableConnection connection) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = connectionId;
            args.arg2 = connection;
            ConnectionServiceAdapterServant.this.mHandler.obtainMessage(ConnectionServiceAdapterServant.MSG_ADD_EXISTING_CONNECTION, args).sendToTarget();
        }
    }

    public ConnectionServiceAdapterServant(IConnectionServiceAdapter delegate) {
        this.mHandler = new C07431();
        this.mStub = new C07442();
        this.mDelegate = delegate;
    }

    public IConnectionServiceAdapter getStub() {
        return this.mStub;
    }
}
