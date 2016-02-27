package com.android.internal.telephony.cdma;

import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.os.SystemProperties;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import com.android.internal.telephony.Call;
import com.android.internal.telephony.CallStateException;
import com.android.internal.telephony.CallTracker;
import com.android.internal.telephony.Connection;
import com.android.internal.telephony.DriverCall;
import com.android.internal.telephony.PhoneConstants.State;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.imsphone.ImsPhone;
import com.android.internal.telephony.imsphone.ImsPhoneConnection;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public final class CdmaCallTracker extends CallTracker {
    private static final boolean DBG_POLL = false;
    static final String LOG_TAG = "CdmaCallTracker";
    static final int MAX_CONNECTIONS = 8;
    static final int MAX_CONNECTIONS_PER_CALL = 1;
    private static final boolean REPEAT_POLLING = false;
    private int m3WayCallFlashDelay;
    CdmaCall mBackgroundCall;
    RegistrantList mCallWaitingRegistrants;
    CdmaConnection[] mConnections;
    boolean mDesiredMute;
    ArrayList<CdmaConnection> mDroppedDuringPoll;
    CdmaCall mForegroundCall;
    boolean mHangupPendingMO;
    private boolean mIsEcmTimerCanceled;
    boolean mIsInEmergencyCall;
    int mPendingCallClirMode;
    boolean mPendingCallInEcm;
    CdmaConnection mPendingMO;
    CDMAPhone mPhone;
    CdmaCall mRingingCall;
    State mState;
    RegistrantList mVoiceCallEndedRegistrants;
    RegistrantList mVoiceCallStartedRegistrants;

    /* renamed from: com.android.internal.telephony.cdma.CdmaCallTracker.1 */
    class C00421 implements Runnable {
        C00421() {
        }

        public void run() {
            if (CdmaCallTracker.this.mPendingMO != null) {
                CdmaCallTracker.this.mCi.sendCDMAFeatureCode(CdmaCallTracker.this.mPendingMO.getAddress(), CdmaCallTracker.this.obtainMessage(16));
            }
        }
    }

    CdmaCallTracker(CDMAPhone phone) {
        this.mConnections = new CdmaConnection[MAX_CONNECTIONS];
        this.mVoiceCallEndedRegistrants = new RegistrantList();
        this.mVoiceCallStartedRegistrants = new RegistrantList();
        this.mCallWaitingRegistrants = new RegistrantList();
        this.mDroppedDuringPoll = new ArrayList(MAX_CONNECTIONS);
        this.mRingingCall = new CdmaCall(this);
        this.mForegroundCall = new CdmaCall(this);
        this.mBackgroundCall = new CdmaCall(this);
        this.mPendingCallInEcm = DBG_POLL;
        this.mIsInEmergencyCall = DBG_POLL;
        this.mDesiredMute = DBG_POLL;
        this.mState = State.IDLE;
        this.mIsEcmTimerCanceled = DBG_POLL;
        this.m3WayCallFlashDelay = 0;
        this.mPhone = phone;
        this.mCi = phone.mCi;
        this.mCi.registerForCallStateChanged(this, 2, null);
        this.mCi.registerForOn(this, 9, null);
        this.mCi.registerForNotAvailable(this, 10, null);
        this.mCi.registerForCallWaitingInfo(this, 15, null);
        this.mForegroundCall.setGeneric(DBG_POLL);
    }

    public void dispose() {
        Rlog.d(LOG_TAG, "CdmaCallTracker dispose");
        this.mCi.unregisterForLineControlInfo(this);
        this.mCi.unregisterForCallStateChanged(this);
        this.mCi.unregisterForOn(this);
        this.mCi.unregisterForNotAvailable(this);
        this.mCi.unregisterForCallWaitingInfo(this);
        clearDisconnected();
    }

    protected void finalize() {
        Rlog.d(LOG_TAG, "CdmaCallTracker finalized");
    }

    public void registerForVoiceCallStarted(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mVoiceCallStartedRegistrants.add(r);
        if (this.mState != State.IDLE) {
            r.notifyRegistrant(new AsyncResult(null, null, null));
        }
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

    public void registerForCallWaiting(Handler h, int what, Object obj) {
        this.mCallWaitingRegistrants.add(new Registrant(h, what, obj));
    }

    public void unregisterForCallWaiting(Handler h) {
        this.mCallWaitingRegistrants.remove(h);
    }

    Connection dial(String dialString, int clirMode) throws CallStateException {
        clearDisconnected();
        if (canDial()) {
            TelephonyManager tm = (TelephonyManager) this.mPhone.getContext().getSystemService("phone");
            String origNumber = dialString;
            String operatorIsoContry = tm.getNetworkCountryIsoForPhone(this.mPhone.getPhoneId());
            String simIsoContry = tm.getSimCountryIsoForPhone(this.mPhone.getPhoneId());
            boolean internationalRoaming = (TextUtils.isEmpty(operatorIsoContry) || TextUtils.isEmpty(simIsoContry) || simIsoContry.equals(operatorIsoContry)) ? DBG_POLL : true;
            if (internationalRoaming) {
                if ("us".equals(simIsoContry)) {
                    internationalRoaming = (!internationalRoaming || "vi".equals(operatorIsoContry)) ? DBG_POLL : true;
                } else if ("vi".equals(simIsoContry)) {
                    internationalRoaming = (!internationalRoaming || "us".equals(operatorIsoContry)) ? DBG_POLL : true;
                }
            }
            if (internationalRoaming) {
                dialString = convertNumberIfNecessary(this.mPhone, dialString);
            }
            boolean isPhoneInEcmMode = SystemProperties.get("ril.cdma.inecmmode", "false").equals("true");
            boolean isEmergencyCall = PhoneNumberUtils.isLocalEmergencyNumber(this.mPhone.getContext(), dialString);
            if (isPhoneInEcmMode && isEmergencyCall) {
                handleEcmTimer(MAX_CONNECTIONS_PER_CALL);
            }
            this.mForegroundCall.setGeneric(DBG_POLL);
            if (this.mForegroundCall.getState() == Call.State.ACTIVE) {
                return dialThreeWay(dialString);
            }
            this.mPendingMO = new CdmaConnection(this.mPhone.getContext(), checkForTestEmergencyNumber(dialString), this, this.mForegroundCall);
            this.mHangupPendingMO = DBG_POLL;
            if (this.mPendingMO.getAddress() == null || this.mPendingMO.getAddress().length() == 0 || this.mPendingMO.getAddress().indexOf(78) >= 0) {
                this.mPendingMO.mCause = 7;
                pollCallsWhenSafe();
            } else {
                setMute(DBG_POLL);
                disableDataCallInEmergencyCall(dialString);
                if (!isPhoneInEcmMode || (isPhoneInEcmMode && isEmergencyCall)) {
                    this.mCi.dial(this.mPendingMO.getAddress(), clirMode, obtainCompleteMessage());
                } else {
                    this.mPhone.exitEmergencyCallbackMode();
                    this.mPhone.setOnEcbModeExitResponse(this, 14, null);
                    this.mPendingCallClirMode = clirMode;
                    this.mPendingCallInEcm = true;
                }
            }
            if (this.mNumberConverted) {
                this.mPendingMO.setConverted(origNumber);
                this.mNumberConverted = DBG_POLL;
            }
            updatePhoneState();
            this.mPhone.notifyPreciseCallStateChanged();
            return this.mPendingMO;
        }
        throw new CallStateException("cannot dial in current state");
    }

    Connection dial(String dialString) throws CallStateException {
        return dial(dialString, 0);
    }

    private Connection dialThreeWay(String dialString) {
        if (this.mForegroundCall.isIdle()) {
            return null;
        }
        disableDataCallInEmergencyCall(dialString);
        this.mPendingMO = new CdmaConnection(this.mPhone.getContext(), checkForTestEmergencyNumber(dialString), this, this.mForegroundCall);
        this.m3WayCallFlashDelay = this.mPhone.getContext().getResources().getInteger(17694847);
        if (this.m3WayCallFlashDelay > 0) {
            this.mCi.sendCDMAFeatureCode("", obtainMessage(20));
        } else {
            this.mCi.sendCDMAFeatureCode(this.mPendingMO.getAddress(), obtainMessage(16));
        }
        return this.mPendingMO;
    }

    void acceptCall() throws CallStateException {
        if (this.mRingingCall.getState() == Call.State.INCOMING) {
            Rlog.i("phone", "acceptCall: incoming...");
            setMute(DBG_POLL);
            this.mCi.acceptCall(obtainCompleteMessage());
        } else if (this.mRingingCall.getState() == Call.State.WAITING) {
            CdmaConnection cwConn = (CdmaConnection) this.mRingingCall.getLatestConnection();
            cwConn.updateParent(this.mRingingCall, this.mForegroundCall);
            cwConn.onConnectedInOrOut();
            updatePhoneState();
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
        } else if (this.mForegroundCall.getConnections().size() > MAX_CONNECTIONS_PER_CALL) {
            flashAndSetGenericTrue();
        } else {
            this.mCi.sendCDMAFeatureCode("", obtainMessage(MAX_CONNECTIONS));
        }
    }

    void conference() {
        flashAndSetGenericTrue();
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
        boolean ret;
        boolean z = true;
        int serviceState = this.mPhone.getServiceState().getState();
        String disableCall = SystemProperties.get("ro.telephony.disable-call", "false");
        if (serviceState == 3 || this.mPendingMO != null || this.mRingingCall.isRinging() || disableCall.equals("true") || (this.mForegroundCall.getState().isAlive() && this.mForegroundCall.getState() != Call.State.ACTIVE && this.mBackgroundCall.getState().isAlive())) {
            ret = DBG_POLL;
        } else {
            ret = true;
        }
        if (!ret) {
            boolean z2;
            String str = "canDial is false\n((serviceState=%d) != ServiceState.STATE_POWER_OFF)::=%s\n&& pendingMO == null::=%s\n&& !ringingCall.isRinging()::=%s\n&& !disableCall.equals(\"true\")::=%s\n&& (!foregroundCall.getState().isAlive()::=%s\n   || foregroundCall.getState() == CdmaCall.State.ACTIVE::=%s\n   ||!backgroundCall.getState().isAlive())::=%s)";
            Object[] objArr = new Object[MAX_CONNECTIONS];
            objArr[0] = Integer.valueOf(serviceState);
            if (serviceState != 3) {
                z2 = true;
            } else {
                z2 = DBG_POLL;
            }
            objArr[MAX_CONNECTIONS_PER_CALL] = Boolean.valueOf(z2);
            if (this.mPendingMO == null) {
                z2 = true;
            } else {
                z2 = DBG_POLL;
            }
            objArr[2] = Boolean.valueOf(z2);
            if (this.mRingingCall.isRinging()) {
                z2 = DBG_POLL;
            } else {
                z2 = true;
            }
            objArr[3] = Boolean.valueOf(z2);
            if (disableCall.equals("true")) {
                z2 = DBG_POLL;
            } else {
                z2 = true;
            }
            objArr[4] = Boolean.valueOf(z2);
            if (this.mForegroundCall.getState().isAlive()) {
                z2 = DBG_POLL;
            } else {
                z2 = true;
            }
            objArr[5] = Boolean.valueOf(z2);
            if (this.mForegroundCall.getState() == Call.State.ACTIVE) {
                z2 = true;
            } else {
                z2 = DBG_POLL;
            }
            objArr[6] = Boolean.valueOf(z2);
            if (this.mBackgroundCall.getState().isAlive()) {
                z = DBG_POLL;
            }
            objArr[7] = Boolean.valueOf(z);
            log(String.format(str, objArr));
        }
        return ret;
    }

    boolean canTransfer() {
        Rlog.e(LOG_TAG, "canTransfer: not possible in CDMA");
        return DBG_POLL;
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
        this.mPendingOperations += MAX_CONNECTIONS_PER_CALL;
        this.mLastRelevantPoll = null;
        this.mNeedsPoll = true;
        return obtainMessage(what);
    }

    private void operationComplete() {
        this.mPendingOperations--;
        if (this.mPendingOperations == 0 && this.mNeedsPoll) {
            this.mLastRelevantPoll = obtainMessage(MAX_CONNECTIONS_PER_CALL);
            this.mCi.getCurrentCalls(this.mLastRelevantPoll);
        } else if (this.mPendingOperations < 0) {
            Rlog.e(LOG_TAG, "CdmaCallTracker.pendingOperations < 0");
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
        log("update phone state, old=" + oldState + " new=" + this.mState);
        if (this.mState != oldState) {
            this.mPhone.notifyPhoneStateChanged();
        }
    }

    protected void handlePollCalls(AsyncResult ar) {
        List polledCalls;
        int i;
        if (ar.exception == null) {
            polledCalls = ar.result;
        } else {
            if (isCommandExceptionRadioNotAvailable(ar.exception)) {
                polledCalls = new ArrayList();
            } else {
                pollCallsAfterDelay();
                return;
            }
        }
        Connection newRinging = null;
        Connection newUnknown = null;
        boolean hasNonHangupStateChanged = DBG_POLL;
        boolean hasAnyCallDisconnected = DBG_POLL;
        boolean unknownConnectionAppeared = DBG_POLL;
        int curDC = 0;
        int dcSize = polledCalls.size();
        for (i = 0; i < this.mConnections.length; i += MAX_CONNECTIONS_PER_CALL) {
            Connection hoConnection;
            Connection conn = this.mConnections[i];
            DriverCall dc = null;
            if (curDC < dcSize) {
                dc = (DriverCall) polledCalls.get(curDC);
                int i2 = dc.index;
                if (r0 == i + MAX_CONNECTIONS_PER_CALL) {
                    curDC += MAX_CONNECTIONS_PER_CALL;
                } else {
                    dc = null;
                }
            }
            if (conn == null && dc != null) {
                if (this.mPendingMO != null) {
                    if (this.mPendingMO.compareTo(dc)) {
                        this.mConnections[i] = this.mPendingMO;
                        this.mPendingMO.mIndex = i;
                        this.mPendingMO.update(dc);
                        this.mPendingMO = null;
                        if (this.mHangupPendingMO) {
                            this.mHangupPendingMO = DBG_POLL;
                            if (this.mIsEcmTimerCanceled) {
                                handleEcmTimer(0);
                            }
                            try {
                                log("poll: hangupPendingMO, hangup conn " + i);
                                hangup(this.mConnections[i]);
                                return;
                            } catch (CallStateException e) {
                                Rlog.e(LOG_TAG, "unexpected error on hangup");
                                return;
                            }
                        }
                        hasNonHangupStateChanged = true;
                    }
                }
                log("pendingMo=" + this.mPendingMO + ", dc=" + dc);
                this.mConnections[i] = new CdmaConnection(this.mPhone.getContext(), dc, this, i);
                hoConnection = getHoConnection(dc);
                if (hoConnection != null) {
                    this.mConnections[i].migrateFrom(hoConnection);
                    this.mHandoverConnections.remove(hoConnection);
                    this.mPhone.notifyHandoverStateChanged(this.mConnections[i]);
                } else {
                    newRinging = checkMtFindNewRinging(dc, i);
                    if (newRinging == null) {
                        unknownConnectionAppeared = true;
                        newUnknown = this.mConnections[i];
                    }
                }
                checkAndEnableDataCallAfterEmergencyCallDropped();
                hasNonHangupStateChanged = true;
            } else if (conn != null && dc == null) {
                int n;
                int count = this.mForegroundCall.mConnections.size();
                for (n = 0; n < count; n += MAX_CONNECTIONS_PER_CALL) {
                    log("adding fgCall cn " + n + " to droppedDuringPoll");
                    this.mDroppedDuringPoll.add((CdmaConnection) this.mForegroundCall.mConnections.get(n));
                }
                count = this.mRingingCall.mConnections.size();
                for (n = 0; n < count; n += MAX_CONNECTIONS_PER_CALL) {
                    log("adding rgCall cn " + n + " to droppedDuringPoll");
                    this.mDroppedDuringPoll.add((CdmaConnection) this.mRingingCall.mConnections.get(n));
                }
                this.mForegroundCall.setGeneric(DBG_POLL);
                this.mRingingCall.setGeneric(DBG_POLL);
                if (this.mIsEcmTimerCanceled) {
                    handleEcmTimer(0);
                }
                checkAndEnableDataCallAfterEmergencyCallDropped();
                this.mConnections[i] = null;
            } else if (!(conn == null || dc == null)) {
                if (conn.isIncoming() != dc.isMT) {
                    boolean z = dc.isMT;
                    if (r0 == MAX_CONNECTIONS_PER_CALL) {
                        this.mDroppedDuringPoll.add(conn);
                        newRinging = checkMtFindNewRinging(dc, i);
                        if (newRinging == null) {
                            unknownConnectionAppeared = true;
                            newUnknown = conn;
                        }
                        checkAndEnableDataCallAfterEmergencyCallDropped();
                    } else {
                        Rlog.e(LOG_TAG, "Error in RIL, Phantom call appeared " + dc);
                    }
                } else {
                    hasNonHangupStateChanged = (hasNonHangupStateChanged || conn.update(dc)) ? true : DBG_POLL;
                }
            }
        }
        if (this.mPendingMO != null) {
            Rlog.d(LOG_TAG, "Pending MO dropped before poll fg state:" + this.mForegroundCall.getState());
            this.mDroppedDuringPoll.add(this.mPendingMO);
            this.mPendingMO = null;
            this.mHangupPendingMO = DBG_POLL;
            if (this.mPendingCallInEcm) {
                this.mPendingCallInEcm = DBG_POLL;
            }
        }
        if (newRinging != null) {
            this.mPhone.notifyNewRingingConnection(newRinging);
        }
        for (i = this.mDroppedDuringPoll.size() - 1; i >= 0; i--) {
            CdmaConnection conn2 = (CdmaConnection) this.mDroppedDuringPoll.get(i);
            if (conn2.isIncoming() && conn2.getConnectTime() == 0) {
                int cause;
                i2 = conn2.mCause;
                if (r0 == 3) {
                    cause = 16;
                } else {
                    cause = MAX_CONNECTIONS_PER_CALL;
                }
                log("missed/rejected call, conn.cause=" + conn2.mCause);
                log("setting cause to " + cause);
                this.mDroppedDuringPoll.remove(i);
                hasAnyCallDisconnected |= conn2.onDisconnect(cause);
            } else {
                i2 = conn2.mCause;
                if (r0 != 3) {
                    i2 = conn2.mCause;
                    if (r0 != 7) {
                    }
                }
                this.mDroppedDuringPoll.remove(i);
                hasAnyCallDisconnected |= conn2.onDisconnect(conn2.mCause);
            }
        }
        Iterator i$ = this.mHandoverConnections.iterator();
        while (i$.hasNext()) {
            hoConnection = (Connection) i$.next();
            log("handlePollCalls - disconnect hoConn= " + hoConnection.toString());
            ((ImsPhoneConnection) hoConnection).onDisconnect(-1);
            this.mHandoverConnections.remove(hoConnection);
        }
        if (this.mDroppedDuringPoll.size() > 0) {
            this.mCi.getLastCallFailCause(obtainNoPollCompleteMessage(5));
        }
        if (DBG_POLL) {
            pollCallsAfterDelay();
        }
        if (newRinging != null || hasNonHangupStateChanged || hasAnyCallDisconnected) {
            internalClearDisconnected();
        }
        updatePhoneState();
        if (unknownConnectionAppeared) {
            this.mPhone.notifyUnknownConnection(newUnknown);
        }
        if (hasNonHangupStateChanged || newRinging != null || hasAnyCallDisconnected) {
            this.mPhone.notifyPreciseCallStateChanged();
        }
    }

    void hangup(CdmaConnection conn) throws CallStateException {
        if (conn.mOwner != this) {
            throw new CallStateException("CdmaConnection " + conn + "does not belong to CdmaCallTracker " + this);
        }
        if (conn == this.mPendingMO) {
            log("hangup: set hangupPendingMO to true");
            this.mHangupPendingMO = true;
        } else if (conn.getCall() == this.mRingingCall && this.mRingingCall.getState() == Call.State.WAITING) {
            conn.onLocalDisconnect();
            updatePhoneState();
            this.mPhone.notifyPreciseCallStateChanged();
            return;
        } else {
            try {
                this.mCi.hangupConnection(conn.getCDMAIndex(), obtainCompleteMessage());
            } catch (CallStateException e) {
                Rlog.w(LOG_TAG, "CdmaCallTracker WARN: hangup() on absent connection " + conn);
            }
        }
        conn.onHangupLocal();
    }

    void separate(CdmaConnection conn) throws CallStateException {
        if (conn.mOwner != this) {
            throw new CallStateException("CdmaConnection " + conn + "does not belong to CdmaCallTracker " + this);
        }
        try {
            this.mCi.separateConnection(conn.getCDMAIndex(), obtainCompleteMessage(12));
        } catch (CallStateException e) {
            Rlog.w(LOG_TAG, "CdmaCallTracker WARN: separate() on absent connection " + conn);
        }
    }

    void setMute(boolean mute) {
        this.mDesiredMute = mute;
        this.mCi.setMute(this.mDesiredMute, null);
    }

    boolean getMute() {
        return this.mDesiredMute;
    }

    void hangup(CdmaCall call) throws CallStateException {
        if (call.getConnections().size() == 0) {
            throw new CallStateException("no connections in call");
        }
        if (call == this.mRingingCall) {
            log("(ringing) hangup waiting or background");
            this.mCi.hangupWaitingOrBackground(obtainCompleteMessage());
        } else if (call == this.mForegroundCall) {
            if (call.isDialingOrAlerting()) {
                log("(foregnd) hangup dialing or alerting...");
                hangup((CdmaConnection) call.getConnections().get(0));
            } else {
                hangupForegroundResumeBackground();
            }
        } else if (call != this.mBackgroundCall) {
            throw new RuntimeException("CdmaCall " + call + "does not belong to CdmaCallTracker " + this);
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

    void hangupConnectionByIndex(CdmaCall call, int index) throws CallStateException {
        int count = call.mConnections.size();
        for (int i = 0; i < count; i += MAX_CONNECTIONS_PER_CALL) {
            if (((CdmaConnection) call.mConnections.get(i)).getCDMAIndex() == index) {
                this.mCi.hangupConnection(index, obtainCompleteMessage());
                return;
            }
        }
        throw new CallStateException("no gsm index found");
    }

    void hangupAllConnections(CdmaCall call) {
        try {
            int count = call.mConnections.size();
            for (int i = 0; i < count; i += MAX_CONNECTIONS_PER_CALL) {
                this.mCi.hangupConnection(((CdmaConnection) call.mConnections.get(i)).getCDMAIndex(), obtainCompleteMessage());
            }
        } catch (CallStateException ex) {
            Rlog.e(LOG_TAG, "hangupConnectionByIndex caught " + ex);
        }
    }

    CdmaConnection getConnectionByIndex(CdmaCall call, int index) throws CallStateException {
        int count = call.mConnections.size();
        for (int i = 0; i < count; i += MAX_CONNECTIONS_PER_CALL) {
            CdmaConnection cn = (CdmaConnection) call.mConnections.get(i);
            if (cn.getCDMAIndex() == index) {
                return cn;
            }
        }
        return null;
    }

    private void flashAndSetGenericTrue() {
        this.mCi.sendCDMAFeatureCode("", obtainMessage(MAX_CONNECTIONS));
        this.mForegroundCall.setGeneric(true);
        this.mPhone.notifyPreciseCallStateChanged();
    }

    private void handleRadioNotAvailable() {
        pollCallsWhenSafe();
    }

    private void notifyCallWaitingInfo(CdmaCallWaitingNotification obj) {
        if (this.mCallWaitingRegistrants != null) {
            this.mCallWaitingRegistrants.notifyRegistrants(new AsyncResult(null, obj, null));
        }
    }

    private void handleCallWaitingInfo(CdmaCallWaitingNotification cw) {
        if (this.mForegroundCall.mConnections.size() > MAX_CONNECTIONS_PER_CALL) {
            this.mForegroundCall.setGeneric(true);
        }
        this.mRingingCall.setGeneric(DBG_POLL);
        CdmaConnection cdmaConnection = new CdmaConnection(this.mPhone.getContext(), cw, this, this.mRingingCall);
        updatePhoneState();
        notifyCallWaitingInfo(cw);
    }

    public void handleMessage(Message msg) {
        if (this.mPhone.mIsTheCurrentActivePhone) {
            AsyncResult ar;
            switch (msg.what) {
                case MAX_CONNECTIONS_PER_CALL /*1*/:
                    Rlog.d(LOG_TAG, "Event EVENT_POLL_CALLS_RESULT Received");
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
                    operationComplete();
                    return;
                case CharacterSets.ISO_8859_2 /*5*/:
                    int causeCode;
                    ar = (AsyncResult) msg.obj;
                    operationComplete();
                    if (ar.exception != null) {
                        causeCode = 16;
                        Rlog.i(LOG_TAG, "Exception during getLastCallFailCause, assuming normal disconnect");
                    } else {
                        causeCode = ((int[]) ar.result)[0];
                    }
                    int s = this.mDroppedDuringPoll.size();
                    for (int i = 0; i < s; i += MAX_CONNECTIONS_PER_CALL) {
                        ((CdmaConnection) this.mDroppedDuringPoll.get(i)).onRemoteDisconnect(causeCode);
                    }
                    updatePhoneState();
                    this.mPhone.notifyPreciseCallStateChanged();
                    this.mDroppedDuringPoll.clear();
                    return;
                case MAX_CONNECTIONS /*8*/:
                    return;
                case CharacterSets.ISO_8859_6 /*9*/:
                    handleRadioAvailable();
                    return;
                case CharacterSets.ISO_8859_7 /*10*/:
                    handleRadioNotAvailable();
                    return;
                case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                    if (this.mPendingCallInEcm) {
                        this.mCi.dial(this.mPendingMO.getAddress(), this.mPendingCallClirMode, obtainCompleteMessage());
                        this.mPendingCallInEcm = DBG_POLL;
                    }
                    this.mPhone.unsetOnEcbModeExitResponse(this);
                    return;
                case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        handleCallWaitingInfo((CdmaCallWaitingNotification) ar.result);
                        Rlog.d(LOG_TAG, "Event EVENT_CALL_WAITING_INFO_CDMA Received");
                        return;
                    }
                    return;
                case PduHeaders.MMS_VERSION_1_0 /*16*/:
                    if (((AsyncResult) msg.obj).exception == null) {
                        this.mPendingMO.onConnectedInOrOut();
                        this.mPendingMO = null;
                        return;
                    }
                    return;
                case SmsHeader.ELT_ID_EXTENDED_OBJECT /*20*/:
                    if (((AsyncResult) msg.obj).exception == null) {
                        postDelayed(new C00421(), (long) this.m3WayCallFlashDelay);
                        return;
                    }
                    this.mPendingMO = null;
                    Rlog.w(LOG_TAG, "exception happened on Blank Flash for 3-way call");
                    return;
                default:
                    throw new RuntimeException("unexpected event not handled");
            }
        }
        Rlog.w(LOG_TAG, "Ignoring events received on inactive CdmaPhone");
    }

    private void handleEcmTimer(int action) {
        this.mPhone.handleTimerInEmergencyCallbackMode(action);
        switch (action) {
            case CharacterSets.ANY_CHARSET /*0*/:
                this.mIsEcmTimerCanceled = DBG_POLL;
            case MAX_CONNECTIONS_PER_CALL /*1*/:
                this.mIsEcmTimerCanceled = true;
            default:
                Rlog.e(LOG_TAG, "handleEcmTimer, unsupported action " + action);
        }
    }

    private void disableDataCallInEmergencyCall(String dialString) {
        if (PhoneNumberUtils.isLocalEmergencyNumber(this.mPhone.getContext(), dialString)) {
            log("disableDataCallInEmergencyCall");
            this.mIsInEmergencyCall = true;
            this.mPhone.mDcTracker.setInternalDataEnabled(DBG_POLL);
        }
    }

    private void checkAndEnableDataCallAfterEmergencyCallDropped() {
        if (this.mIsInEmergencyCall) {
            this.mIsInEmergencyCall = DBG_POLL;
            String inEcm = SystemProperties.get("ril.cdma.inecmmode", "false");
            log("checkAndEnableDataCallAfterEmergencyCallDropped,inEcm=" + inEcm);
            if (inEcm.compareTo("false") == 0) {
                this.mPhone.mDcTracker.setInternalDataEnabled(true);
            }
        }
    }

    private Connection checkMtFindNewRinging(DriverCall dc, int i) {
        if (this.mConnections[i].getCall() == this.mRingingCall) {
            Connection newRinging = this.mConnections[i];
            log("Notify new ring " + dc);
            return newRinging;
        }
        Rlog.e(LOG_TAG, "Phantom call appeared " + dc);
        if (dc.state == DriverCall.State.ALERTING || dc.state == DriverCall.State.DIALING) {
            return null;
        }
        this.mConnections[i].onConnectedInOrOut();
        if (dc.state != DriverCall.State.HOLDING) {
            return null;
        }
        this.mConnections[i].onStartedHolding();
        return null;
    }

    boolean isInEmergencyCall() {
        return this.mIsInEmergencyCall;
    }

    protected void log(String msg) {
        Rlog.d(LOG_TAG, "[CdmaCallTracker] " + msg);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        int i;
        pw.println("GsmCallTracker extends:");
        super.dump(fd, pw, args);
        pw.println("droppedDuringPoll: length=" + this.mConnections.length);
        for (i = 0; i < this.mConnections.length; i += MAX_CONNECTIONS_PER_CALL) {
            pw.printf(" mConnections[%d]=%s\n", new Object[]{Integer.valueOf(i), this.mConnections[i]});
        }
        pw.println(" mVoiceCallEndedRegistrants=" + this.mVoiceCallEndedRegistrants);
        pw.println(" mVoiceCallStartedRegistrants=" + this.mVoiceCallStartedRegistrants);
        pw.println(" mCallWaitingRegistrants=" + this.mCallWaitingRegistrants);
        pw.println("droppedDuringPoll: size=" + this.mDroppedDuringPoll.size());
        for (i = 0; i < this.mDroppedDuringPoll.size(); i += MAX_CONNECTIONS_PER_CALL) {
            pw.printf(" mDroppedDuringPoll[%d]=%s\n", new Object[]{Integer.valueOf(i), this.mDroppedDuringPoll.get(i)});
        }
        pw.println(" mRingingCall=" + this.mRingingCall);
        pw.println(" mForegroundCall=" + this.mForegroundCall);
        pw.println(" mBackgroundCall=" + this.mBackgroundCall);
        pw.println(" mPendingMO=" + this.mPendingMO);
        pw.println(" mHangupPendingMO=" + this.mHangupPendingMO);
        pw.println(" mPendingCallInEcm=" + this.mPendingCallInEcm);
        pw.println(" mIsInEmergencyCall=" + this.mIsInEmergencyCall);
        pw.println(" mPhone=" + this.mPhone);
        pw.println(" mDesiredMute=" + this.mDesiredMute);
        pw.println(" mPendingCallClirMode=" + this.mPendingCallClirMode);
        pw.println(" mState=" + this.mState);
        pw.println(" mIsEcmTimerCanceled=" + this.mIsEcmTimerCanceled);
    }

    public State getState() {
        return this.mState;
    }
}
