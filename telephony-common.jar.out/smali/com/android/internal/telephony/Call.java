package com.android.internal.telephony;

import android.telephony.Rlog;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduPersister;
import java.util.ArrayList;
import java.util.List;

public abstract class Call {
    protected final String LOG_TAG;
    public ArrayList<Connection> mConnections;
    protected boolean mIsGeneric;
    public State mState;

    /* renamed from: com.android.internal.telephony.Call.1 */
    static /* synthetic */ class C00071 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$DriverCall$State;

        static {
            $SwitchMap$com$android$internal$telephony$DriverCall$State = new int[com.android.internal.telephony.DriverCall.State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[com.android.internal.telephony.DriverCall.State.ACTIVE.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[com.android.internal.telephony.DriverCall.State.HOLDING.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[com.android.internal.telephony.DriverCall.State.DIALING.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[com.android.internal.telephony.DriverCall.State.ALERTING.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[com.android.internal.telephony.DriverCall.State.INCOMING.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[com.android.internal.telephony.DriverCall.State.WAITING.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
        }
    }

    public enum SrvccState {
        NONE,
        STARTED,
        COMPLETED,
        FAILED,
        CANCELED
    }

    public enum State {
        IDLE,
        ACTIVE,
        HOLDING,
        DIALING,
        ALERTING,
        INCOMING,
        WAITING,
        DISCONNECTED,
        DISCONNECTING;

        public boolean isAlive() {
            return (this == IDLE || this == DISCONNECTED || this == DISCONNECTING) ? false : true;
        }

        public boolean isRinging() {
            return this == INCOMING || this == WAITING;
        }

        public boolean isDialing() {
            return this == DIALING || this == ALERTING;
        }
    }

    public abstract List<Connection> getConnections();

    public abstract Phone getPhone();

    public abstract void hangup() throws CallStateException;

    public abstract boolean isMultiparty();

    public Call() {
        this.LOG_TAG = "Call";
        this.mState = State.IDLE;
        this.mConnections = new ArrayList();
        this.mIsGeneric = false;
    }

    public static State stateFromDCState(com.android.internal.telephony.DriverCall.State dcState) {
        switch (C00071.$SwitchMap$com$android$internal$telephony$DriverCall$State[dcState.ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return State.ACTIVE;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return State.HOLDING;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return State.DIALING;
            case CharacterSets.ISO_8859_1 /*4*/:
                return State.ALERTING;
            case CharacterSets.ISO_8859_2 /*5*/:
                return State.INCOMING;
            case CharacterSets.ISO_8859_3 /*6*/:
                return State.WAITING;
            default:
                throw new RuntimeException("illegal call state:" + dcState);
        }
    }

    public boolean hasConnection(Connection c) {
        return c.getCall() == this;
    }

    public boolean hasConnections() {
        List<Connection> connections = getConnections();
        if (connections != null && connections.size() > 0) {
            return true;
        }
        return false;
    }

    public State getState() {
        return this.mState;
    }

    public boolean isIdle() {
        return !getState().isAlive();
    }

    public Connection getEarliestConnection() {
        long time = Long.MAX_VALUE;
        Connection earliest = null;
        List<Connection> l = getConnections();
        if (l.size() == 0) {
            return null;
        }
        int s = l.size();
        for (int i = 0; i < s; i++) {
            Connection c = (Connection) l.get(i);
            long t = c.getCreateTime();
            if (t < time) {
                earliest = c;
                time = t;
            }
        }
        return earliest;
    }

    public long getEarliestCreateTime() {
        long time = Long.MAX_VALUE;
        List<Connection> l = getConnections();
        if (l.size() == 0) {
            return 0;
        }
        int s = l.size();
        for (int i = 0; i < s; i++) {
            long t = ((Connection) l.get(i)).getCreateTime();
            if (t < time) {
                time = t;
            }
        }
        return time;
    }

    public long getEarliestConnectTime() {
        long time = Long.MAX_VALUE;
        List<Connection> l = getConnections();
        if (l.size() == 0) {
            return 0;
        }
        int s = l.size();
        for (int i = 0; i < s; i++) {
            long t = ((Connection) l.get(i)).getConnectTime();
            if (t < time) {
                time = t;
            }
        }
        return time;
    }

    public boolean isDialingOrAlerting() {
        return getState().isDialing();
    }

    public boolean isRinging() {
        return getState().isRinging();
    }

    public Connection getLatestConnection() {
        List<Connection> l = getConnections();
        if (l.size() == 0) {
            return null;
        }
        long time = 0;
        Connection latest = null;
        int s = l.size();
        for (int i = 0; i < s; i++) {
            Connection c = (Connection) l.get(i);
            long t = c.getCreateTime();
            if (t > time) {
                latest = c;
                time = t;
            }
        }
        return latest;
    }

    public boolean isGeneric() {
        return this.mIsGeneric;
    }

    public void setGeneric(boolean generic) {
        this.mIsGeneric = generic;
    }

    public void hangupIfAlive() {
        if (getState().isAlive()) {
            try {
                hangup();
            } catch (CallStateException ex) {
                Rlog.w("Call", " hangupIfActive: caught " + ex);
            }
        }
    }
}
