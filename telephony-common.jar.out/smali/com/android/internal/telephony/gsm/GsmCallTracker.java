package com.android.internal.telephony.gsm;

import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.os.SystemProperties;
import android.telephony.Rlog;
import android.telephony.TelephonyManager;
import android.telephony.gsm.GsmCellLocation;
import android.util.EventLog;
import com.android.internal.telephony.Call;
import com.android.internal.telephony.Call.SrvccState;
import com.android.internal.telephony.CallStateException;
import com.android.internal.telephony.CallTracker;
import com.android.internal.telephony.Connection;
import com.android.internal.telephony.EventLogTags;
import com.android.internal.telephony.Phone.SuppService;
import com.android.internal.telephony.PhoneConstants.State;
import com.android.internal.telephony.UUSInfo;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.imsphone.ImsPhone;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public final class GsmCallTracker extends CallTracker {
    private static final boolean DBG_POLL = false;
    static final String LOG_TAG = "GsmCallTracker";
    static final int MAX_CONNECTIONS = 7;
    static final int MAX_CONNECTIONS_PER_CALL = 5;
    private static final boolean REPEAT_POLLING = false;
    GsmCall mBackgroundCall;
    GsmConnection[] mConnections;
    boolean mDesiredMute;
    ArrayList<GsmConnection> mDroppedDuringPoll;
    GsmCall mForegroundCall;
    boolean mHangupPendingMO;
    GsmConnection mPendingMO;
    GSMPhone mPhone;
    GsmCall mRingingCall;
    SrvccState mSrvccState;
    State mState;
    RegistrantList mVoiceCallEndedRegistrants;
    RegistrantList mVoiceCallStartedRegistrants;

    GsmCallTracker(GSMPhone phone) {
        this.mConnections = new GsmConnection[MAX_CONNECTIONS];
        this.mVoiceCallEndedRegistrants = new RegistrantList();
        this.mVoiceCallStartedRegistrants = new RegistrantList();
        this.mDroppedDuringPoll = new ArrayList(MAX_CONNECTIONS);
        this.mRingingCall = new GsmCall(this);
        this.mForegroundCall = new GsmCall(this);
        this.mBackgroundCall = new GsmCall(this);
        this.mDesiredMute = DBG_POLL;
        this.mState = State.IDLE;
        this.mSrvccState = SrvccState.NONE;
        this.mPhone = phone;
        this.mCi = phone.mCi;
        this.mCi.registerForCallStateChanged(this, 2, null);
        this.mCi.registerForOn(this, 9, null);
        this.mCi.registerForNotAvailable(this, 10, null);
    }

    public void dispose() {
        Rlog.d(LOG_TAG, "GsmCallTracker dispose");
        this.mCi.unregisterForCallStateChanged(this);
        this.mCi.unregisterForOn(this);
        this.mCi.unregisterForNotAvailable(this);
        clearDisconnected();
    }

    protected void finalize() {
        Rlog.d(LOG_TAG, "GsmCallTracker finalized");
    }

    public void registerForVoiceCallStarted(Handler h, int what, Object obj) {
        this.mVoiceCallStartedRegistrants.add(new Registrant(h, what, obj));
    }

    public void unregisterForVoiceCallStarted(Handler h) {
        this.mVoiceCallStartedRegistrants.remove(h);
    }

    public void registerForVoiceCallEnded(Handler h, int what, Object obj) {
        this.mVoiceCallEndedRegistrants.add(new Registrant(h, what, obj));
    }

    public void unregisterForVoiceCallEnded(Handler h) {
        this.mVoiceCallEndedRegistrants.remove(h);
    }

    private void fakeHoldForegroundBeforeDial() {
        List<Connection> connCopy = (List) this.mForegroundCall.mConnections.clone();
        int s = connCopy.size();
        for (int i = 0; i < s; i++) {
            ((GsmConnection) connCopy.get(i)).fakeHoldBeforeDial();
        }
    }

    synchronized Connection dial(String dialString, int clirMode, UUSInfo uusInfo) throws CallStateException {
        clearDisconnected();
        if (canDial()) {
            String origNumber = dialString;
            dialString = convertNumberIfNecessary(this.mPhone, dialString);
            if (this.mForegroundCall.getState() == Call.State.ACTIVE) {
                switchWaitingOrHoldingAndActive();
                fakeHoldForegroundBeforeDial();
            }
            if (this.mForegroundCall.getState() != Call.State.IDLE) {
                throw new CallStateException("cannot dial in current state");
            }
            this.mPendingMO = new GsmConnection(this.mPhone.getContext(), checkForTestEmergencyNumber(dialString), this, this.mForegroundCall);
            this.mHangupPendingMO = DBG_POLL;
            if (this.mPendingMO.getAddress() == null || this.mPendingMO.getAddress().length() == 0 || this.mPendingMO.getAddress().indexOf(78) >= 0) {
                this.mPendingMO.mCause = MAX_CONNECTIONS;
                pollCallsWhenSafe();
            } else {
                setMute(DBG_POLL);
                this.mCi.dial(this.mPendingMO.getAddress(), clirMode, uusInfo, obtainCompleteMessage());
            }
            if (this.mNumberConverted) {
                this.mPendingMO.setConverted(origNumber);
                this.mNumberConverted = DBG_POLL;
            }
            updatePhoneState();
            this.mPhone.notifyPreciseCallStateChanged();
        } else {
            throw new CallStateException("cannot dial in current state");
        }
        return this.mPendingMO;
    }

    Connection dial(String dialString) throws CallStateException {
        return dial(dialString, 0, null);
    }

    Connection dial(String dialString, UUSInfo uusInfo) throws CallStateException {
        return dial(dialString, 0, uusInfo);
    }

    Connection dial(String dialString, int clirMode) throws CallStateException {
        return dial(dialString, clirMode, null);
    }

    void acceptCall() throws CallStateException {
        if (this.mRingingCall.getState() == Call.State.INCOMING) {
            Rlog.i("phone", "acceptCall: incoming...");
            setMute(DBG_POLL);
            this.mCi.acceptCall(obtainCompleteMessage());
        } else if (this.mRingingCall.getState() == Call.State.WAITING) {
            setMute(DBG_POLL);
            switchWaitingOrHoldingAndActive();
        } else {
            throw new CallStateException("phone not ringing");
        }
    }

    void rejectCall() throws CallStateException {
        if (this.mRingingCall.getState().isRinging()) {
            this.mCi.rejectCall(obtainCompleteMessage());
            return;
        }
        throw new CallStateException("phone not ringing");
    }

    void switchWaitingOrHoldingAndActive() throws CallStateException {
        if (this.mRingingCall.getState() == Call.State.INCOMING) {
            throw new CallStateException("cannot be in the incoming state");
        }
        this.mCi.switchWaitingOrHoldingAndActive(obtainCompleteMessage(8));
    }

    void conference() {
        this.mCi.conference(obtainCompleteMessage(11));
    }

    void explicitCallTransfer() {
        this.mCi.explicitCallTransfer(obtainCompleteMessage(13));
    }

    void clearDisconnected() {
        internalClearDisconnected();
        updatePhoneState();
        this.mPhone.notifyPreciseCallStateChanged();
    }

    boolean canConference() {
        return (this.mForegroundCall.getState() != Call.State.ACTIVE || this.mBackgroundCall.getState() != Call.State.HOLDING || this.mBackgroundCall.isFull() || this.mForegroundCall.isFull()) ? DBG_POLL : true;
    }

    boolean canDial() {
        return (this.mPhone.getServiceState().getState() == 3 || this.mPendingMO != null || this.mRingingCall.isRinging() || SystemProperties.get("ro.telephony.disable-call", "false").equals("true") || (this.mForegroundCall.getState().isAlive() && this.mBackgroundCall.getState().isAlive())) ? DBG_POLL : true;
    }

    boolean canTransfer() {
        return ((this.mForegroundCall.getState() == Call.State.ACTIVE || this.mForegroundCall.getState() == Call.State.ALERTING || this.mForegroundCall.getState() == Call.State.DIALING) && this.mBackgroundCall.getState() == Call.State.HOLDING) ? true : DBG_POLL;
    }

    private void internalClearDisconnected() {
        this.mRingingCall.clearDisconnected();
        this.mForegroundCall.clearDisconnected();
        this.mBackgroundCall.clearDisconnected();
    }

    private Message obtainCompleteMessage() {
        return obtainCompleteMessage(4);
    }

    private Message obtainCompleteMessage(int what) {
        this.mPendingOperations++;
        this.mLastRelevantPoll = null;
        this.mNeedsPoll = true;
        return obtainMessage(what);
    }

    private void operationComplete() {
        this.mPendingOperations--;
        if (this.mPendingOperations == 0 && this.mNeedsPoll) {
            this.mLastRelevantPoll = obtainMessage(1);
            this.mCi.getCurrentCalls(this.mLastRelevantPoll);
        } else if (this.mPendingOperations < 0) {
            Rlog.e(LOG_TAG, "GsmCallTracker.pendingOperations < 0");
            this.mPendingOperations = 0;
        }
    }

    private void updatePhoneState() {
        State oldState = this.mState;
        if (this.mRingingCall.isRinging()) {
            this.mState = State.RINGING;
        } else if (this.mPendingMO == null && this.mForegroundCall.isIdle() && this.mBackgroundCall.isIdle()) {
            ImsPhone imsPhone = (ImsPhone) this.mPhone.getImsPhone();
            if (this.mState == State.OFFHOOK && imsPhone != null) {
                imsPhone.callEndCleanupHandOverCallIfAny();
            }
            this.mState = State.IDLE;
        } else {
            this.mState = State.OFFHOOK;
        }
        if (this.mState == State.IDLE && oldState != this.mState) {
            this.mVoiceCallEndedRegistrants.notifyRegistrants(new AsyncResult(null, null, null));
        } else if (oldState == State.IDLE && oldState != this.mState) {
            this.mVoiceCallStartedRegistrants.notifyRegistrants(new AsyncResult(null, null, null));
        }
        if (this.mState != oldState) {
            this.mPhone.notifyPhoneStateChanged();
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    protected synchronized void handlePollCalls(android.os.AsyncResult r27) {
        /*
        r26 = this;
        monitor-enter(r26);
        r0 = r27;
        r0 = r0.exception;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        if (r21 != 0) goto L_0x00d3;
    L_0x0009:
        r0 = r27;
        r0 = r0.result;	 Catch:{ all -> 0x00ee }
        r19 = r0;
        r19 = (java.util.List) r19;	 Catch:{ all -> 0x00ee }
    L_0x0011:
        r17 = 0;
        r18 = 0;
        r12 = 0;
        r11 = 0;
        r16 = 0;
        r20 = 0;
        r14 = 0;
        r7 = 0;
        r9 = r19.size();	 Catch:{ all -> 0x00ee }
    L_0x0021:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r0 = r0.length;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        if (r14 >= r0) goto L_0x0258;
    L_0x0030:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r6 = r21[r14];	 Catch:{ all -> 0x00ee }
        r8 = 0;
        if (r7 >= r9) goto L_0x0051;
    L_0x003b:
        r0 = r19;
        r8 = r0.get(r7);	 Catch:{ all -> 0x00ee }
        r8 = (com.android.internal.telephony.DriverCall) r8;	 Catch:{ all -> 0x00ee }
        r0 = r8.index;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = r14 + 1;
        r0 = r21;
        r1 = r22;
        if (r0 != r1) goto L_0x00f1;
    L_0x004f:
        r7 = r7 + 1;
    L_0x0051:
        if (r6 != 0) goto L_0x01d7;
    L_0x0053:
        if (r8 == 0) goto L_0x01d7;
    L_0x0055:
        r0 = r26;
        r0 = r0.mPendingMO;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        if (r21 == 0) goto L_0x00fd;
    L_0x005d:
        r0 = r26;
        r0 = r0.mPendingMO;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r21 = r0.compareTo(r8);	 Catch:{ all -> 0x00ee }
        if (r21 == 0) goto L_0x00fd;
    L_0x006b:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r26;
        r0 = r0.mPendingMO;	 Catch:{ all -> 0x00ee }
        r22 = r0;
        r21[r14] = r22;	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mPendingMO;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r0.mIndex = r14;	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mPendingMO;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r0.update(r8);	 Catch:{ all -> 0x00ee }
        r21 = 0;
        r0 = r21;
        r1 = r26;
        r1.mPendingMO = r0;	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mHangupPendingMO;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        if (r21 == 0) goto L_0x0151;
    L_0x009e:
        r21 = 0;
        r0 = r21;
        r1 = r26;
        r1.mHangupPendingMO = r0;	 Catch:{ all -> 0x00ee }
        r21 = new java.lang.StringBuilder;	 Catch:{ CallStateException -> 0x00f4 }
        r21.<init>();	 Catch:{ CallStateException -> 0x00f4 }
        r22 = "poll: hangupPendingMO, hangup conn ";
        r21 = r21.append(r22);	 Catch:{ CallStateException -> 0x00f4 }
        r0 = r21;
        r21 = r0.append(r14);	 Catch:{ CallStateException -> 0x00f4 }
        r21 = r21.toString();	 Catch:{ CallStateException -> 0x00f4 }
        r0 = r26;
        r1 = r21;
        r0.log(r1);	 Catch:{ CallStateException -> 0x00f4 }
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ CallStateException -> 0x00f4 }
        r21 = r0;
        r21 = r21[r14];	 Catch:{ CallStateException -> 0x00f4 }
        r0 = r26;
        r1 = r21;
        r0.hangup(r1);	 Catch:{ CallStateException -> 0x00f4 }
    L_0x00d1:
        monitor-exit(r26);
        return;
    L_0x00d3:
        r0 = r27;
        r0 = r0.exception;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r26;
        r1 = r21;
        r21 = r0.isCommandExceptionRadioNotAvailable(r1);	 Catch:{ all -> 0x00ee }
        if (r21 == 0) goto L_0x00ea;
    L_0x00e3:
        r19 = new java.util.ArrayList;	 Catch:{ all -> 0x00ee }
        r19.<init>();	 Catch:{ all -> 0x00ee }
        goto L_0x0011;
    L_0x00ea:
        r26.pollCallsAfterDelay();	 Catch:{ all -> 0x00ee }
        goto L_0x00d1;
    L_0x00ee:
        r21 = move-exception;
        monitor-exit(r26);
        throw r21;
    L_0x00f1:
        r8 = 0;
        goto L_0x0051;
    L_0x00f4:
        r10 = move-exception;
        r21 = "GsmCallTracker";
        r22 = "unexpected error on hangup";
        android.telephony.Rlog.e(r21, r22);	 Catch:{ all -> 0x00ee }
        goto L_0x00d1;
    L_0x00fd:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = new com.android.internal.telephony.gsm.GsmConnection;	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mPhone;	 Catch:{ all -> 0x00ee }
        r23 = r0;
        r23 = r23.getContext();	 Catch:{ all -> 0x00ee }
        r0 = r22;
        r1 = r23;
        r2 = r26;
        r0.<init>(r1, r8, r2, r14);	 Catch:{ all -> 0x00ee }
        r21[r14] = r22;	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r13 = r0.getHoConnection(r8);	 Catch:{ all -> 0x00ee }
        if (r13 == 0) goto L_0x0156;
    L_0x0122:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r21 = r21[r14];	 Catch:{ all -> 0x00ee }
        r0 = r21;
        r0.migrateFrom(r13);	 Catch:{ all -> 0x00ee }
        r21 = r13.isMultiparty();	 Catch:{ all -> 0x00ee }
        if (r21 != 0) goto L_0x0140;
    L_0x0135:
        r0 = r26;
        r0 = r0.mHandoverConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r0.remove(r13);	 Catch:{ all -> 0x00ee }
    L_0x0140:
        r0 = r26;
        r0 = r0.mPhone;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r22 = r0;
        r22 = r22[r14];	 Catch:{ all -> 0x00ee }
        r21.notifyHandoverStateChanged(r22);	 Catch:{ all -> 0x00ee }
    L_0x0151:
        r12 = 1;
    L_0x0152:
        r14 = r14 + 1;
        goto L_0x0021;
    L_0x0156:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r21 = r21[r14];	 Catch:{ all -> 0x00ee }
        r21 = r21.getCall();	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mRingingCall;	 Catch:{ all -> 0x00ee }
        r22 = r0;
        r0 = r21;
        r1 = r22;
        if (r0 != r1) goto L_0x0177;
    L_0x016e:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r17 = r21[r14];	 Catch:{ all -> 0x00ee }
        goto L_0x0151;
    L_0x0177:
        r21 = "GsmCallTracker";
        r22 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00ee }
        r22.<init>();	 Catch:{ all -> 0x00ee }
        r23 = "Phantom call appeared ";
        r22 = r22.append(r23);	 Catch:{ all -> 0x00ee }
        r0 = r22;
        r22 = r0.append(r8);	 Catch:{ all -> 0x00ee }
        r22 = r22.toString();	 Catch:{ all -> 0x00ee }
        android.telephony.Rlog.i(r21, r22);	 Catch:{ all -> 0x00ee }
        r0 = r8.state;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = com.android.internal.telephony.DriverCall.State.ALERTING;	 Catch:{ all -> 0x00ee }
        r0 = r21;
        r1 = r22;
        if (r0 == r1) goto L_0x01cb;
    L_0x019d:
        r0 = r8.state;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = com.android.internal.telephony.DriverCall.State.DIALING;	 Catch:{ all -> 0x00ee }
        r0 = r21;
        r1 = r22;
        if (r0 == r1) goto L_0x01cb;
    L_0x01a9:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r21 = r21[r14];	 Catch:{ all -> 0x00ee }
        r21.onConnectedInOrOut();	 Catch:{ all -> 0x00ee }
        r0 = r8.state;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = com.android.internal.telephony.DriverCall.State.HOLDING;	 Catch:{ all -> 0x00ee }
        r0 = r21;
        r1 = r22;
        if (r0 != r1) goto L_0x01cb;
    L_0x01c0:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r21 = r21[r14];	 Catch:{ all -> 0x00ee }
        r21.onStartedHolding();	 Catch:{ all -> 0x00ee }
    L_0x01cb:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r18 = r21[r14];	 Catch:{ all -> 0x00ee }
        r20 = 1;
        goto L_0x0151;
    L_0x01d7:
        if (r6 == 0) goto L_0x01f2;
    L_0x01d9:
        if (r8 != 0) goto L_0x01f2;
    L_0x01db:
        r0 = r26;
        r0 = r0.mDroppedDuringPoll;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r0.add(r6);	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = 0;
        r21[r14] = r22;	 Catch:{ all -> 0x00ee }
        goto L_0x0152;
    L_0x01f2:
        if (r6 == 0) goto L_0x0247;
    L_0x01f4:
        if (r8 == 0) goto L_0x0247;
    L_0x01f6:
        r21 = r6.compareTo(r8);	 Catch:{ all -> 0x00ee }
        if (r21 != 0) goto L_0x0247;
    L_0x01fc:
        r0 = r26;
        r0 = r0.mDroppedDuringPoll;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r0.add(r6);	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = new com.android.internal.telephony.gsm.GsmConnection;	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mPhone;	 Catch:{ all -> 0x00ee }
        r23 = r0;
        r23 = r23.getContext();	 Catch:{ all -> 0x00ee }
        r0 = r22;
        r1 = r23;
        r2 = r26;
        r0.<init>(r1, r8, r2, r14);	 Catch:{ all -> 0x00ee }
        r21[r14] = r22;	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r21 = r21[r14];	 Catch:{ all -> 0x00ee }
        r21 = r21.getCall();	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mRingingCall;	 Catch:{ all -> 0x00ee }
        r22 = r0;
        r0 = r21;
        r1 = r22;
        if (r0 != r1) goto L_0x0244;
    L_0x023c:
        r0 = r26;
        r0 = r0.mConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r17 = r21[r14];	 Catch:{ all -> 0x00ee }
    L_0x0244:
        r12 = 1;
        goto L_0x0152;
    L_0x0247:
        if (r6 == 0) goto L_0x0152;
    L_0x0249:
        if (r8 == 0) goto L_0x0152;
    L_0x024b:
        r5 = r6.update(r8);	 Catch:{ all -> 0x00ee }
        if (r12 != 0) goto L_0x0253;
    L_0x0251:
        if (r5 == 0) goto L_0x0256;
    L_0x0253:
        r12 = 1;
    L_0x0254:
        goto L_0x0152;
    L_0x0256:
        r12 = 0;
        goto L_0x0254;
    L_0x0258:
        r0 = r26;
        r0 = r0.mPendingMO;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        if (r21 == 0) goto L_0x02a1;
    L_0x0260:
        r21 = "GsmCallTracker";
        r22 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00ee }
        r22.<init>();	 Catch:{ all -> 0x00ee }
        r23 = "Pending MO dropped before poll fg state:";
        r22 = r22.append(r23);	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mForegroundCall;	 Catch:{ all -> 0x00ee }
        r23 = r0;
        r23 = r23.getState();	 Catch:{ all -> 0x00ee }
        r22 = r22.append(r23);	 Catch:{ all -> 0x00ee }
        r22 = r22.toString();	 Catch:{ all -> 0x00ee }
        android.telephony.Rlog.d(r21, r22);	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mDroppedDuringPoll;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r26;
        r0 = r0.mPendingMO;	 Catch:{ all -> 0x00ee }
        r22 = r0;
        r21.add(r22);	 Catch:{ all -> 0x00ee }
        r21 = 0;
        r0 = r21;
        r1 = r26;
        r1.mPendingMO = r0;	 Catch:{ all -> 0x00ee }
        r21 = 0;
        r0 = r21;
        r1 = r26;
        r1.mHangupPendingMO = r0;	 Catch:{ all -> 0x00ee }
    L_0x02a1:
        if (r17 == 0) goto L_0x02b0;
    L_0x02a3:
        r0 = r26;
        r0 = r0.mPhone;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r1 = r17;
        r0.notifyNewRingingConnection(r1);	 Catch:{ all -> 0x00ee }
    L_0x02b0:
        r0 = r26;
        r0 = r0.mDroppedDuringPoll;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r21 = r21.size();	 Catch:{ all -> 0x00ee }
        r14 = r21 + -1;
    L_0x02bc:
        if (r14 < 0) goto L_0x036a;
    L_0x02be:
        r0 = r26;
        r0 = r0.mDroppedDuringPoll;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r6 = r0.get(r14);	 Catch:{ all -> 0x00ee }
        r6 = (com.android.internal.telephony.gsm.GsmConnection) r6;	 Catch:{ all -> 0x00ee }
        r21 = r6.isIncoming();	 Catch:{ all -> 0x00ee }
        if (r21 == 0) goto L_0x033a;
    L_0x02d2:
        r22 = r6.getConnectTime();	 Catch:{ all -> 0x00ee }
        r24 = 0;
        r21 = (r22 > r24 ? 1 : (r22 == r24 ? 0 : -1));
        if (r21 != 0) goto L_0x033a;
    L_0x02dc:
        r0 = r6.mCause;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = 3;
        r0 = r21;
        r1 = r22;
        if (r0 != r1) goto L_0x0338;
    L_0x02e8:
        r4 = 16;
    L_0x02ea:
        r21 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00ee }
        r21.<init>();	 Catch:{ all -> 0x00ee }
        r22 = "missed/rejected call, conn.cause=";
        r21 = r21.append(r22);	 Catch:{ all -> 0x00ee }
        r0 = r6.mCause;	 Catch:{ all -> 0x00ee }
        r22 = r0;
        r21 = r21.append(r22);	 Catch:{ all -> 0x00ee }
        r21 = r21.toString();	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r1 = r21;
        r0.log(r1);	 Catch:{ all -> 0x00ee }
        r21 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00ee }
        r21.<init>();	 Catch:{ all -> 0x00ee }
        r22 = "setting cause to ";
        r21 = r21.append(r22);	 Catch:{ all -> 0x00ee }
        r0 = r21;
        r21 = r0.append(r4);	 Catch:{ all -> 0x00ee }
        r21 = r21.toString();	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r1 = r21;
        r0.log(r1);	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mDroppedDuringPoll;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r0.remove(r14);	 Catch:{ all -> 0x00ee }
        r21 = r6.onDisconnect(r4);	 Catch:{ all -> 0x00ee }
        r11 = r11 | r21;
    L_0x0335:
        r14 = r14 + -1;
        goto L_0x02bc;
    L_0x0338:
        r4 = 1;
        goto L_0x02ea;
    L_0x033a:
        r0 = r6.mCause;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = 3;
        r0 = r21;
        r1 = r22;
        if (r0 == r1) goto L_0x0352;
    L_0x0346:
        r0 = r6.mCause;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = 7;
        r0 = r21;
        r1 = r22;
        if (r0 != r1) goto L_0x0335;
    L_0x0352:
        r0 = r26;
        r0 = r0.mDroppedDuringPoll;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r0.remove(r14);	 Catch:{ all -> 0x00ee }
        r0 = r6.mCause;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r21 = r6.onDisconnect(r0);	 Catch:{ all -> 0x00ee }
        r11 = r11 | r21;
        goto L_0x0335;
    L_0x036a:
        r0 = r26;
        r0 = r0.mHandoverConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r15 = r21.iterator();	 Catch:{ all -> 0x00ee }
    L_0x0374:
        r21 = r15.hasNext();	 Catch:{ all -> 0x00ee }
        if (r21 == 0) goto L_0x03b4;
    L_0x037a:
        r13 = r15.next();	 Catch:{ all -> 0x00ee }
        r13 = (com.android.internal.telephony.Connection) r13;	 Catch:{ all -> 0x00ee }
        r21 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00ee }
        r21.<init>();	 Catch:{ all -> 0x00ee }
        r22 = "handlePollCalls - disconnect hoConn= ";
        r21 = r21.append(r22);	 Catch:{ all -> 0x00ee }
        r22 = r13.toString();	 Catch:{ all -> 0x00ee }
        r21 = r21.append(r22);	 Catch:{ all -> 0x00ee }
        r21 = r21.toString();	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r1 = r21;
        r0.log(r1);	 Catch:{ all -> 0x00ee }
        r0 = r13;
        r0 = (com.android.internal.telephony.imsphone.ImsPhoneConnection) r0;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = -1;
        r21.onDisconnect(r22);	 Catch:{ all -> 0x00ee }
        r0 = r26;
        r0 = r0.mHandoverConnections;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r0.remove(r13);	 Catch:{ all -> 0x00ee }
        goto L_0x0374;
    L_0x03b4:
        r0 = r26;
        r0 = r0.mDroppedDuringPoll;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r21 = r21.size();	 Catch:{ all -> 0x00ee }
        if (r21 <= 0) goto L_0x03d3;
    L_0x03c0:
        r0 = r26;
        r0 = r0.mCi;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r22 = 5;
        r0 = r26;
        r1 = r22;
        r22 = r0.obtainNoPollCompleteMessage(r1);	 Catch:{ all -> 0x00ee }
        r21.getLastCallFailCause(r22);	 Catch:{ all -> 0x00ee }
    L_0x03d3:
        if (r16 == 0) goto L_0x03d8;
    L_0x03d5:
        r26.pollCallsAfterDelay();	 Catch:{ all -> 0x00ee }
    L_0x03d8:
        if (r17 != 0) goto L_0x03de;
    L_0x03da:
        if (r12 != 0) goto L_0x03de;
    L_0x03dc:
        if (r11 == 0) goto L_0x03e1;
    L_0x03de:
        r26.internalClearDisconnected();	 Catch:{ all -> 0x00ee }
    L_0x03e1:
        r26.updatePhoneState();	 Catch:{ all -> 0x00ee }
        if (r20 == 0) goto L_0x03f3;
    L_0x03e6:
        r0 = r26;
        r0 = r0.mPhone;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r0 = r21;
        r1 = r18;
        r0.notifyUnknownConnection(r1);	 Catch:{ all -> 0x00ee }
    L_0x03f3:
        if (r12 != 0) goto L_0x03f9;
    L_0x03f5:
        if (r17 != 0) goto L_0x03f9;
    L_0x03f7:
        if (r11 == 0) goto L_0x00d1;
    L_0x03f9:
        r0 = r26;
        r0 = r0.mPhone;	 Catch:{ all -> 0x00ee }
        r21 = r0;
        r21.notifyPreciseCallStateChanged();	 Catch:{ all -> 0x00ee }
        goto L_0x00d1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.gsm.GsmCallTracker.handlePollCalls(android.os.AsyncResult):void");
    }

    private void handleRadioNotAvailable() {
        pollCallsWhenSafe();
    }

    private void dumpState() {
        int i;
        Rlog.i(LOG_TAG, "Phone State:" + this.mState);
        Rlog.i(LOG_TAG, "Ringing call: " + this.mRingingCall.toString());
        List l = this.mRingingCall.getConnections();
        int s = l.size();
        for (i = 0; i < s; i++) {
            Rlog.i(LOG_TAG, l.get(i).toString());
        }
        Rlog.i(LOG_TAG, "Foreground call: " + this.mForegroundCall.toString());
        l = this.mForegroundCall.getConnections();
        s = l.size();
        for (i = 0; i < s; i++) {
            Rlog.i(LOG_TAG, l.get(i).toString());
        }
        Rlog.i(LOG_TAG, "Background call: " + this.mBackgroundCall.toString());
        l = this.mBackgroundCall.getConnections();
        s = l.size();
        for (i = 0; i < s; i++) {
            Rlog.i(LOG_TAG, l.get(i).toString());
        }
    }

    void hangup(GsmConnection conn) throws CallStateException {
        if (conn.mOwner != this) {
            throw new CallStateException("GsmConnection " + conn + "does not belong to GsmCallTracker " + this);
        }
        if (conn == this.mPendingMO) {
            log("hangup: set hangupPendingMO to true");
            this.mHangupPendingMO = true;
        } else {
            try {
                this.mCi.hangupConnection(conn.getGSMIndex(), obtainCompleteMessage());
            } catch (CallStateException e) {
                Rlog.w(LOG_TAG, "GsmCallTracker WARN: hangup() on absent connection " + conn);
            }
        }
        conn.onHangupLocal();
    }

    void separate(GsmConnection conn) throws CallStateException {
        if (conn.mOwner != this) {
            throw new CallStateException("GsmConnection " + conn + "does not belong to GsmCallTracker " + this);
        }
        try {
            this.mCi.separateConnection(conn.getGSMIndex(), obtainCompleteMessage(12));
        } catch (CallStateException e) {
            Rlog.w(LOG_TAG, "GsmCallTracker WARN: separate() on absent connection " + conn);
        }
    }

    void setMute(boolean mute) {
        this.mDesiredMute = mute;
        this.mCi.setMute(this.mDesiredMute, null);
    }

    boolean getMute() {
        return this.mDesiredMute;
    }

    void hangup(GsmCall call) throws CallStateException {
        if (call.getConnections().size() == 0) {
            throw new CallStateException("no connections in call");
        }
        if (call == this.mRingingCall) {
            log("(ringing) hangup waiting or background");
            this.mCi.hangupWaitingOrBackground(obtainCompleteMessage());
        } else if (call == this.mForegroundCall) {
            if (call.isDialingOrAlerting()) {
                log("(foregnd) hangup dialing or alerting...");
                hangup((GsmConnection) call.getConnections().get(0));
            } else if (this.mRingingCall.isRinging()) {
                log("hangup all conns in active/background call, without affecting ringing call");
                hangupAllConnections(call);
            } else {
                hangupForegroundResumeBackground();
            }
        } else if (call != this.mBackgroundCall) {
            throw new RuntimeException("GsmCall " + call + "does not belong to GsmCallTracker " + this);
        } else if (this.mRingingCall.isRinging()) {
            log("hangup all conns in background call");
            hangupAllConnections(call);
        } else {
            hangupWaitingOrBackground();
        }
        call.onHangupLocal();
        this.mPhone.notifyPreciseCallStateChanged();
    }

    void hangupWaitingOrBackground() {
        log("hangupWaitingOrBackground");
        this.mCi.hangupWaitingOrBackground(obtainCompleteMessage());
    }

    void hangupForegroundResumeBackground() {
        log("hangupForegroundResumeBackground");
        this.mCi.hangupForegroundResumeBackground(obtainCompleteMessage());
    }

    void hangupConnectionByIndex(GsmCall call, int index) throws CallStateException {
        int count = call.mConnections.size();
        for (int i = 0; i < count; i++) {
            if (((GsmConnection) call.mConnections.get(i)).getGSMIndex() == index) {
                this.mCi.hangupConnection(index, obtainCompleteMessage());
                return;
            }
        }
        throw new CallStateException("no gsm index found");
    }

    void hangupAllConnections(GsmCall call) {
        try {
            int count = call.mConnections.size();
            for (int i = 0; i < count; i++) {
                this.mCi.hangupConnection(((GsmConnection) call.mConnections.get(i)).getGSMIndex(), obtainCompleteMessage());
            }
        } catch (CallStateException ex) {
            Rlog.e(LOG_TAG, "hangupConnectionByIndex caught " + ex);
        }
    }

    GsmConnection getConnectionByIndex(GsmCall call, int index) throws CallStateException {
        int count = call.mConnections.size();
        for (int i = 0; i < count; i++) {
            GsmConnection cn = (GsmConnection) call.mConnections.get(i);
            if (cn.getGSMIndex() == index) {
                return cn;
            }
        }
        return null;
    }

    private SuppService getFailedService(int what) {
        switch (what) {
            case CharacterSets.ISO_8859_5 /*8*/:
                return SuppService.SWITCH;
            case CharacterSets.ISO_8859_8 /*11*/:
                return SuppService.CONFERENCE;
            case CharacterSets.ISO_8859_9 /*12*/:
                return SuppService.SEPARATE;
            case UserData.ASCII_CR_INDEX /*13*/:
                return SuppService.TRANSFER;
            default:
                return SuppService.UNKNOWN;
        }
    }

    public void handleMessage(Message msg) {
        if (this.mPhone.mIsTheCurrentActivePhone) {
            AsyncResult ar;
            switch (msg.what) {
                case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    ar = msg.obj;
                    if (msg == this.mLastRelevantPoll) {
                        this.mNeedsPoll = DBG_POLL;
                        this.mLastRelevantPoll = null;
                        handlePollCalls((AsyncResult) msg.obj);
                        return;
                    }
                    return;
                case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                    pollCallsWhenSafe();
                    return;
                case CharacterSets.ISO_8859_1 /*4*/:
                    ar = (AsyncResult) msg.obj;
                    operationComplete();
                    return;
                case MAX_CONNECTIONS_PER_CALL /*5*/:
                    int causeCode;
                    ar = (AsyncResult) msg.obj;
                    operationComplete();
                    if (ar.exception != null) {
                        causeCode = 16;
                        Rlog.i(LOG_TAG, "Exception during getLastCallFailCause, assuming normal disconnect");
                    } else {
                        causeCode = ((int[]) ar.result)[0];
                    }
                    if (causeCode == 34 || causeCode == 41 || causeCode == 42 || causeCode == 44 || causeCode == 49 || causeCode == 58 || causeCode == CallFailCause.ERROR_UNSPECIFIED) {
                        GsmCellLocation loc = (GsmCellLocation) this.mPhone.getCellLocation();
                        Object[] objArr = new Object[3];
                        objArr[0] = Integer.valueOf(causeCode);
                        objArr[1] = Integer.valueOf(loc != null ? loc.getCid() : -1);
                        objArr[2] = Integer.valueOf(TelephonyManager.getDefault().getNetworkType());
                        EventLog.writeEvent(EventLogTags.CALL_DROP, objArr);
                    }
                    int s = this.mDroppedDuringPoll.size();
                    for (int i = 0; i < s; i++) {
                        ((GsmConnection) this.mDroppedDuringPoll.get(i)).onRemoteDisconnect(causeCode);
                    }
                    updatePhoneState();
                    this.mPhone.notifyPreciseCallStateChanged();
                    this.mDroppedDuringPoll.clear();
                    return;
                case CharacterSets.ISO_8859_5 /*8*/:
                case CharacterSets.ISO_8859_8 /*11*/:
                case CharacterSets.ISO_8859_9 /*12*/:
                case UserData.ASCII_CR_INDEX /*13*/:
                    if (((AsyncResult) msg.obj).exception != null) {
                        this.mPhone.notifySuppServiceFailed(getFailedService(msg.what));
                    }
                    operationComplete();
                    return;
                case CharacterSets.ISO_8859_6 /*9*/:
                    handleRadioAvailable();
                    return;
                case CharacterSets.ISO_8859_7 /*10*/:
                    handleRadioNotAvailable();
                    return;
                default:
                    return;
            }
        }
        Rlog.e(LOG_TAG, "Received message " + msg + "[" + msg.what + "] while being destroyed. Ignoring.");
    }

    protected void log(String msg) {
        Rlog.d(LOG_TAG, "[GsmCallTracker] " + msg);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        int i;
        pw.println("GsmCallTracker extends:");
        super.dump(fd, pw, args);
        pw.println("mConnections: length=" + this.mConnections.length);
        for (i = 0; i < this.mConnections.length; i++) {
            pw.printf("  mConnections[%d]=%s\n", new Object[]{Integer.valueOf(i), this.mConnections[i]});
        }
        pw.println(" mVoiceCallEndedRegistrants=" + this.mVoiceCallEndedRegistrants);
        pw.println(" mVoiceCallStartedRegistrants=" + this.mVoiceCallStartedRegistrants);
        pw.println(" mDroppedDuringPoll: size=" + this.mDroppedDuringPoll.size());
        for (i = 0; i < this.mDroppedDuringPoll.size(); i++) {
            pw.printf("  mDroppedDuringPoll[%d]=%s\n", new Object[]{Integer.valueOf(i), this.mDroppedDuringPoll.get(i)});
        }
        pw.println(" mRingingCall=" + this.mRingingCall);
        pw.println(" mForegroundCall=" + this.mForegroundCall);
        pw.println(" mBackgroundCall=" + this.mBackgroundCall);
        pw.println(" mPendingMO=" + this.mPendingMO);
        pw.println(" mHangupPendingMO=" + this.mHangupPendingMO);
        pw.println(" mPhone=" + this.mPhone);
        pw.println(" mDesiredMute=" + this.mDesiredMute);
        pw.println(" mState=" + this.mState);
    }

    public State getState() {
        return this.mState;
    }
}
