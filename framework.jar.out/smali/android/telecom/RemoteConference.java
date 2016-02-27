package android.telecom;

import android.os.RemoteException;
import com.android.internal.telecom.IConnectionService;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.CopyOnWriteArraySet;

public final class RemoteConference {
    private final Set<Callback> mCallbacks;
    private final List<RemoteConnection> mChildConnections;
    private final List<RemoteConnection> mConferenceableConnections;
    private int mConnectionCapabilities;
    private final IConnectionService mConnectionService;
    private DisconnectCause mDisconnectCause;
    private final String mId;
    private int mState;
    private final List<RemoteConnection> mUnmodifiableChildConnections;
    private final List<RemoteConnection> mUnmodifiableConferenceableConnections;

    public static abstract class Callback {
        public void onStateChanged(RemoteConference conference, int oldState, int newState) {
        }

        public void onDisconnected(RemoteConference conference, DisconnectCause disconnectCause) {
        }

        public void onConnectionAdded(RemoteConference conference, RemoteConnection connection) {
        }

        public void onConnectionRemoved(RemoteConference conference, RemoteConnection connection) {
        }

        public void onConnectionCapabilitiesChanged(RemoteConference conference, int connectionCapabilities) {
        }

        public void onConferenceableConnectionsChanged(RemoteConference conference, List<RemoteConnection> list) {
        }

        public void onDestroyed(RemoteConference conference) {
        }
    }

    RemoteConference(String id, IConnectionService connectionService) {
        this.mCallbacks = new CopyOnWriteArraySet();
        this.mChildConnections = new CopyOnWriteArrayList();
        this.mUnmodifiableChildConnections = Collections.unmodifiableList(this.mChildConnections);
        this.mConferenceableConnections = new ArrayList();
        this.mUnmodifiableConferenceableConnections = Collections.unmodifiableList(this.mConferenceableConnections);
        this.mState = 1;
        this.mId = id;
        this.mConnectionService = connectionService;
    }

    String getId() {
        return this.mId;
    }

    void setDestroyed() {
        for (RemoteConnection connection : this.mChildConnections) {
            connection.setConference(null);
        }
        for (Callback c : this.mCallbacks) {
            c.onDestroyed(this);
        }
    }

    void setState(int newState) {
        if (newState != 4 && newState != 5 && newState != 6) {
            Log.m11w((Object) this, "Unsupported state transition for Conference call.", Connection.stateToString(newState));
        } else if (this.mState != newState) {
            int oldState = this.mState;
            this.mState = newState;
            for (Callback c : this.mCallbacks) {
                c.onStateChanged(this, oldState, newState);
            }
        }
    }

    void addConnection(RemoteConnection connection) {
        if (!this.mChildConnections.contains(connection)) {
            this.mChildConnections.add(connection);
            connection.setConference(this);
            for (Callback c : this.mCallbacks) {
                c.onConnectionAdded(this, connection);
            }
        }
    }

    void removeConnection(RemoteConnection connection) {
        if (this.mChildConnections.contains(connection)) {
            this.mChildConnections.remove(connection);
            connection.setConference(null);
            for (Callback c : this.mCallbacks) {
                c.onConnectionRemoved(this, connection);
            }
        }
    }

    void setConnectionCapabilities(int connectionCapabilities) {
        if (this.mConnectionCapabilities != connectionCapabilities) {
            this.mConnectionCapabilities = connectionCapabilities;
            for (Callback c : this.mCallbacks) {
                c.onConnectionCapabilitiesChanged(this, this.mConnectionCapabilities);
            }
        }
    }

    void setConferenceableConnections(List<RemoteConnection> conferenceableConnections) {
        this.mConferenceableConnections.clear();
        this.mConferenceableConnections.addAll(conferenceableConnections);
        for (Callback c : this.mCallbacks) {
            c.onConferenceableConnectionsChanged(this, this.mUnmodifiableConferenceableConnections);
        }
    }

    void setDisconnected(DisconnectCause disconnectCause) {
        if (this.mState != 6) {
            this.mDisconnectCause = disconnectCause;
            setState(6);
            for (Callback c : this.mCallbacks) {
                c.onDisconnected(this, disconnectCause);
            }
        }
    }

    public final List<RemoteConnection> getConnections() {
        return this.mUnmodifiableChildConnections;
    }

    public final int getState() {
        return this.mState;
    }

    @Deprecated
    public final int getCallCapabilities() {
        return getConnectionCapabilities();
    }

    public final int getConnectionCapabilities() {
        return this.mConnectionCapabilities;
    }

    public void disconnect() {
        try {
            this.mConnectionService.disconnect(this.mId);
        } catch (RemoteException e) {
        }
    }

    public void separate(RemoteConnection connection) {
        if (this.mChildConnections.contains(connection)) {
            try {
                this.mConnectionService.splitFromConference(connection.getId());
            } catch (RemoteException e) {
            }
        }
    }

    public void merge() {
        try {
            this.mConnectionService.mergeConference(this.mId);
        } catch (RemoteException e) {
        }
    }

    public void swap() {
        try {
            this.mConnectionService.swapConference(this.mId);
        } catch (RemoteException e) {
        }
    }

    public void hold() {
        try {
            this.mConnectionService.hold(this.mId);
        } catch (RemoteException e) {
        }
    }

    public void unhold() {
        try {
            this.mConnectionService.unhold(this.mId);
        } catch (RemoteException e) {
        }
    }

    public DisconnectCause getDisconnectCause() {
        return this.mDisconnectCause;
    }

    public void playDtmfTone(char digit) {
        try {
            this.mConnectionService.playDtmfTone(this.mId, digit);
        } catch (RemoteException e) {
        }
    }

    public void stopDtmfTone() {
        try {
            this.mConnectionService.stopDtmfTone(this.mId);
        } catch (RemoteException e) {
        }
    }

    public void setAudioState(AudioState state) {
        try {
            this.mConnectionService.onAudioStateChanged(this.mId, state);
        } catch (RemoteException e) {
        }
    }

    public List<RemoteConnection> getConferenceableConnections() {
        return this.mUnmodifiableConferenceableConnections;
    }

    public final void registerCallback(Callback callback) {
        this.mCallbacks.add(callback);
    }

    public final void unregisterCallback(Callback callback) {
        this.mCallbacks.remove(callback);
    }
}
