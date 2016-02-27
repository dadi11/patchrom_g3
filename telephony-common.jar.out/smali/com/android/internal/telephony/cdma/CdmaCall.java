package com.android.internal.telephony.cdma;

import com.android.internal.telephony.Call;
import com.android.internal.telephony.Call.State;
import com.android.internal.telephony.CallStateException;
import com.android.internal.telephony.Connection;
import com.android.internal.telephony.DriverCall;
import com.android.internal.telephony.Phone;
import java.util.List;

public final class CdmaCall extends Call {
    CdmaCallTracker mOwner;

    CdmaCall(CdmaCallTracker owner) {
        this.mOwner = owner;
    }

    public void dispose() {
    }

    public List<Connection> getConnections() {
        return this.mConnections;
    }

    public Phone getPhone() {
        return this.mOwner.mPhone;
    }

    public boolean isMultiparty() {
        return this.mConnections.size() > 1;
    }

    public void hangup() throws CallStateException {
        this.mOwner.hangup(this);
    }

    public String toString() {
        return this.mState.toString();
    }

    void attach(Connection conn, DriverCall dc) {
        this.mConnections.add(conn);
        this.mState = Call.stateFromDCState(dc.state);
    }

    void attachFake(Connection conn, State state) {
        this.mConnections.add(conn);
        this.mState = state;
    }

    boolean connectionDisconnected(CdmaConnection conn) {
        if (this.mState != State.DISCONNECTED) {
            boolean hasOnlyDisconnectedConnections = true;
            int s = this.mConnections.size();
            for (int i = 0; i < s; i++) {
                if (((Connection) this.mConnections.get(i)).getState() != State.DISCONNECTED) {
                    hasOnlyDisconnectedConnections = false;
                    break;
                }
            }
            if (hasOnlyDisconnectedConnections) {
                this.mState = State.DISCONNECTED;
                return true;
            }
        }
        return false;
    }

    void detach(CdmaConnection conn) {
        this.mConnections.remove(conn);
        if (this.mConnections.size() == 0) {
            this.mState = State.IDLE;
        }
    }

    boolean update(CdmaConnection conn, DriverCall dc) {
        State newState = Call.stateFromDCState(dc.state);
        if (newState == this.mState) {
            return false;
        }
        this.mState = newState;
        return true;
    }

    boolean isFull() {
        return this.mConnections.size() == 1;
    }

    void onHangupLocal() {
        int s = this.mConnections.size();
        for (int i = 0; i < s; i++) {
            ((CdmaConnection) this.mConnections.get(i)).onHangupLocal();
        }
        this.mState = State.DISCONNECTING;
    }

    void clearDisconnected() {
        for (int i = this.mConnections.size() - 1; i >= 0; i--) {
            if (((CdmaConnection) this.mConnections.get(i)).getState() == State.DISCONNECTED) {
                this.mConnections.remove(i);
            }
        }
        if (this.mConnections.size() == 0) {
            this.mState = State.IDLE;
        }
    }
}
