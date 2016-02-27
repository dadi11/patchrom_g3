package android.telecom;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.CopyOnWriteArraySet;

public abstract class Conference implements IConferenceable {
    public static long CONNECT_TIME_NOT_SPECIFIED;
    private AudioState mAudioState;
    private final List<Connection> mChildConnections;
    private final List<Connection> mConferenceableConnections;
    private long mConnectTimeMillis;
    private int mConnectionCapabilities;
    private final android.telecom.Connection.Listener mConnectionDeathListener;
    private DisconnectCause mDisconnectCause;
    private String mDisconnectMessage;
    private final Set<Listener> mListeners;
    protected PhoneAccountHandle mPhoneAccount;
    private int mState;
    private final List<Connection> mUnmodifiableChildConnections;
    private final List<Connection> mUnmodifiableConferenceableConnections;

    /* renamed from: android.telecom.Conference.1 */
    class C07281 extends android.telecom.Connection.Listener {
        C07281() {
        }

        public void onDestroyed(Connection c) {
            if (Conference.this.mConferenceableConnections.remove(c)) {
                Conference.this.fireOnConferenceableConnectionsChanged();
            }
        }
    }

    public static abstract class Listener {
        public void onStateChanged(Conference conference, int oldState, int newState) {
        }

        public void onDisconnected(Conference conference, DisconnectCause disconnectCause) {
        }

        public void onConnectionAdded(Conference conference, Connection connection) {
        }

        public void onConnectionRemoved(Conference conference, Connection connection) {
        }

        public void onConferenceableConnectionsChanged(Conference conference, List<Connection> list) {
        }

        public void onDestroyed(Conference conference) {
        }

        public void onConnectionCapabilitiesChanged(Conference conference, int connectionCapabilities) {
        }
    }

    static {
        CONNECT_TIME_NOT_SPECIFIED = 0;
    }

    public Conference(PhoneAccountHandle phoneAccount) {
        this.mListeners = new CopyOnWriteArraySet();
        this.mChildConnections = new CopyOnWriteArrayList();
        this.mUnmodifiableChildConnections = Collections.unmodifiableList(this.mChildConnections);
        this.mConferenceableConnections = new ArrayList();
        this.mUnmodifiableConferenceableConnections = Collections.unmodifiableList(this.mConferenceableConnections);
        this.mState = 1;
        this.mConnectTimeMillis = CONNECT_TIME_NOT_SPECIFIED;
        this.mConnectionDeathListener = new C07281();
        this.mPhoneAccount = phoneAccount;
    }

    public final PhoneAccountHandle getPhoneAccountHandle() {
        return this.mPhoneAccount;
    }

    public final List<Connection> getConnections() {
        return this.mUnmodifiableChildConnections;
    }

    public final int getState() {
        return this.mState;
    }

    @Deprecated
    public final int getCapabilities() {
        return getConnectionCapabilities();
    }

    public final int getConnectionCapabilities() {
        return this.mConnectionCapabilities;
    }

    public static boolean can(int capabilities, int capability) {
        return (capabilities & capability) != 0;
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

    public final AudioState getAudioState() {
        return this.mAudioState;
    }

    public void onDisconnect() {
    }

    public void onSeparate(Connection connection) {
    }

    public void onMerge(Connection connection) {
    }

    public void onHold() {
    }

    public void onUnhold() {
    }

    public void onMerge() {
    }

    public void onSwap() {
    }

    public void onPlayDtmfTone(char c) {
    }

    public void onStopDtmfTone() {
    }

    public void onAudioStateChanged(AudioState state) {
    }

    public void onConnectionAdded(Connection connection) {
    }

    public final void setOnHold() {
        setState(5);
    }

    public final void setActive() {
        setState(4);
    }

    public final void setDisconnected(DisconnectCause disconnectCause) {
        this.mDisconnectCause = disconnectCause;
        setState(6);
        for (Listener l : this.mListeners) {
            l.onDisconnected(this, this.mDisconnectCause);
        }
    }

    public final DisconnectCause getDisconnectCause() {
        return this.mDisconnectCause;
    }

    @Deprecated
    public final void setCapabilities(int connectionCapabilities) {
        setConnectionCapabilities(connectionCapabilities);
    }

    public final void setConnectionCapabilities(int connectionCapabilities) {
        if (connectionCapabilities != this.mConnectionCapabilities) {
            this.mConnectionCapabilities = connectionCapabilities;
            for (Listener l : this.mListeners) {
                l.onConnectionCapabilitiesChanged(this, this.mConnectionCapabilities);
            }
        }
    }

    public final boolean addConnection(Connection connection) {
        if (connection == null || this.mChildConnections.contains(connection) || !connection.setConference(this)) {
            return false;
        }
        this.mChildConnections.add(connection);
        onConnectionAdded(connection);
        for (Listener l : this.mListeners) {
            l.onConnectionAdded(this, connection);
        }
        return true;
    }

    public final void removeConnection(Connection connection) {
        Log.m3d((Object) this, "removing %s from %s", connection, this.mChildConnections);
        if (connection != null && this.mChildConnections.remove(connection)) {
            connection.resetConference();
            for (Listener l : this.mListeners) {
                l.onConnectionRemoved(this, connection);
            }
        }
    }

    public final void setConferenceableConnections(List<Connection> conferenceableConnections) {
        clearConferenceableList();
        for (Connection c : conferenceableConnections) {
            if (!this.mConferenceableConnections.contains(c)) {
                c.addConnectionListener(this.mConnectionDeathListener);
                this.mConferenceableConnections.add(c);
            }
        }
        fireOnConferenceableConnectionsChanged();
    }

    private final void fireOnConferenceableConnectionsChanged() {
        for (Listener l : this.mListeners) {
            l.onConferenceableConnectionsChanged(this, getConferenceableConnections());
        }
    }

    public final List<Connection> getConferenceableConnections() {
        return this.mUnmodifiableConferenceableConnections;
    }

    public final void destroy() {
        Log.m3d((Object) this, "destroying conference : %s", this);
        for (Connection connection : this.mChildConnections) {
            Log.m3d((Object) this, "removing connection %s", connection);
            removeConnection(connection);
        }
        if (this.mState != 6) {
            Log.m3d((Object) this, "setting to disconnected", new Object[0]);
            setDisconnected(new DisconnectCause(2));
        }
        for (Listener l : this.mListeners) {
            l.onDestroyed(this);
        }
    }

    public final Conference addListener(Listener listener) {
        this.mListeners.add(listener);
        return this;
    }

    public final Conference removeListener(Listener listener) {
        this.mListeners.remove(listener);
        return this;
    }

    public Connection getPrimaryConnection() {
        if (this.mUnmodifiableChildConnections == null || this.mUnmodifiableChildConnections.isEmpty()) {
            return null;
        }
        return (Connection) this.mUnmodifiableChildConnections.get(0);
    }

    public void setConnectTimeMillis(long connectTimeMillis) {
        this.mConnectTimeMillis = connectTimeMillis;
    }

    public long getConnectTimeMillis() {
        return this.mConnectTimeMillis;
    }

    final void setAudioState(AudioState state) {
        Log.m3d((Object) this, "setAudioState %s", state);
        this.mAudioState = state;
        onAudioStateChanged(state);
    }

    private void setState(int newState) {
        if (newState != 4 && newState != 5 && newState != 6) {
            Log.m11w((Object) this, "Unsupported state transition for Conference call.", Connection.stateToString(newState));
        } else if (this.mState != newState) {
            int oldState = this.mState;
            this.mState = newState;
            for (Listener l : this.mListeners) {
                l.onStateChanged(this, oldState, newState);
            }
        }
    }

    private final void clearConferenceableList() {
        for (Connection c : this.mConferenceableConnections) {
            c.removeConnectionListener(this.mConnectionDeathListener);
        }
        this.mConferenceableConnections.clear();
    }
}
