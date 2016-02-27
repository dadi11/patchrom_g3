package com.android.internal.telephony.gsm;

import android.content.Context;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.Registrant;
import android.os.SystemClock;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.text.TextUtils;
import com.android.internal.telephony.Call;
import com.android.internal.telephony.CallStateException;
import com.android.internal.telephony.Connection;
import com.android.internal.telephony.Connection.PostDialState;
import com.android.internal.telephony.DriverCall;
import com.android.internal.telephony.DriverCall.State;
import com.android.internal.telephony.UUSInfo;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppState;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;

public class GsmConnection extends Connection {
    private static final boolean DBG = true;
    static final int EVENT_DTMF_DONE = 1;
    static final int EVENT_NEXT_POST_DIAL = 3;
    static final int EVENT_PAUSE_DONE = 2;
    static final int EVENT_WAKE_LOCK_TIMEOUT = 4;
    private static final String LOG_TAG = "GsmConnection";
    static final int PAUSE_DELAY_MILLIS = 3000;
    static final int WAKE_LOCK_TIMEOUT_MILLIS = 60000;
    int mCause;
    long mDisconnectTime;
    boolean mDisconnected;
    Handler mHandler;
    int mIndex;
    int mNextPostDialChar;
    Connection mOrigConnection;
    GsmCallTracker mOwner;
    GsmCall mParent;
    private WakeLock mPartialWakeLock;
    PostDialState mPostDialState;
    String mPostDialString;
    int mPreciseCause;
    UUSInfo mUusInfo;

    /* renamed from: com.android.internal.telephony.gsm.GsmConnection.1 */
    static /* synthetic */ class C00671 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$DriverCall$State;

        static {
            $SwitchMap$com$android$internal$telephony$DriverCall$State = new int[State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[State.ACTIVE.ordinal()] = GsmConnection.EVENT_DTMF_DONE;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[State.DIALING.ordinal()] = GsmConnection.EVENT_PAUSE_DONE;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[State.ALERTING.ordinal()] = GsmConnection.EVENT_NEXT_POST_DIAL;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[State.HOLDING.ordinal()] = GsmConnection.EVENT_WAKE_LOCK_TIMEOUT;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[State.INCOMING.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[State.WAITING.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
        }
    }

    class MyHandler extends Handler {
        MyHandler(Looper l) {
            super(l);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case GsmConnection.EVENT_DTMF_DONE /*1*/:
                case GsmConnection.EVENT_PAUSE_DONE /*2*/:
                case GsmConnection.EVENT_NEXT_POST_DIAL /*3*/:
                    GsmConnection.this.processNextPostDialChar();
                case GsmConnection.EVENT_WAKE_LOCK_TIMEOUT /*4*/:
                    GsmConnection.this.releaseWakeLock();
                default:
            }
        }
    }

    GsmConnection(Context context, DriverCall dc, GsmCallTracker ct, int index) {
        this.mCause = 0;
        this.mPostDialState = PostDialState.NOT_STARTED;
        this.mPreciseCause = 0;
        createWakeLock(context);
        acquireWakeLock();
        this.mOwner = ct;
        this.mHandler = new MyHandler(this.mOwner.getLooper());
        this.mAddress = dc.number;
        this.mIsIncoming = dc.isMT;
        this.mCreateTime = System.currentTimeMillis();
        this.mCnapName = dc.name;
        this.mCnapNamePresentation = dc.namePresentation;
        this.mNumberPresentation = dc.numberPresentation;
        this.mUusInfo = dc.uusInfo;
        this.mIndex = index;
        this.mParent = parentFromDCState(dc.state);
        this.mParent.attach(this, dc);
    }

    GsmConnection(Context context, String dialString, GsmCallTracker ct, GsmCall parent) {
        this.mCause = 0;
        this.mPostDialState = PostDialState.NOT_STARTED;
        this.mPreciseCause = 0;
        createWakeLock(context);
        acquireWakeLock();
        this.mOwner = ct;
        this.mHandler = new MyHandler(this.mOwner.getLooper());
        this.mDialString = dialString;
        this.mAddress = PhoneNumberUtils.extractNetworkPortionAlt(dialString);
        this.mPostDialString = PhoneNumberUtils.extractPostDialPortion(dialString);
        this.mIndex = -1;
        this.mIsIncoming = false;
        this.mCnapName = null;
        this.mCnapNamePresentation = EVENT_DTMF_DONE;
        this.mNumberPresentation = EVENT_DTMF_DONE;
        this.mCreateTime = System.currentTimeMillis();
        this.mParent = parent;
        parent.attachFake(this, Call.State.DIALING);
    }

    public void dispose() {
    }

    static boolean equalsHandlesNulls(Object a, Object b) {
        if (a == null) {
            return b == null ? DBG : false;
        } else {
            return a.equals(b);
        }
    }

    boolean compareTo(DriverCall c) {
        if ((!this.mIsIncoming && !c.isMT) || this.mOrigConnection != null) {
            return DBG;
        }
        String cAddress = PhoneNumberUtils.stringFromStringAndTOA(c.number, c.TOA);
        if (this.mIsIncoming == c.isMT && equalsHandlesNulls(this.mAddress, cAddress)) {
            return DBG;
        }
        return false;
    }

    public GsmCall getCall() {
        return this.mParent;
    }

    public long getDisconnectTime() {
        return this.mDisconnectTime;
    }

    public long getHoldDurationMillis() {
        if (getState() != Call.State.HOLDING) {
            return 0;
        }
        return SystemClock.elapsedRealtime() - this.mHoldingStartTime;
    }

    public int getDisconnectCause() {
        return this.mCause;
    }

    public Call.State getState() {
        if (this.mDisconnected) {
            return Call.State.DISCONNECTED;
        }
        return super.getState();
    }

    public void hangup() throws CallStateException {
        if (this.mDisconnected) {
            throw new CallStateException("disconnected");
        }
        this.mOwner.hangup(this);
    }

    public void separate() throws CallStateException {
        if (this.mDisconnected) {
            throw new CallStateException("disconnected");
        }
        this.mOwner.separate(this);
    }

    public PostDialState getPostDialState() {
        return this.mPostDialState;
    }

    public void proceedAfterWaitChar() {
        if (this.mPostDialState != PostDialState.WAIT) {
            Rlog.w(LOG_TAG, "GsmConnection.proceedAfterWaitChar(): Expected getPostDialState() to be WAIT but was " + this.mPostDialState);
            return;
        }
        setPostDialState(PostDialState.STARTED);
        processNextPostDialChar();
    }

    public void proceedAfterWildChar(String str) {
        if (this.mPostDialState != PostDialState.WILD) {
            Rlog.w(LOG_TAG, "GsmConnection.proceedAfterWaitChar(): Expected getPostDialState() to be WILD but was " + this.mPostDialState);
            return;
        }
        setPostDialState(PostDialState.STARTED);
        StringBuilder buf = new StringBuilder(str);
        buf.append(this.mPostDialString.substring(this.mNextPostDialChar));
        this.mPostDialString = buf.toString();
        this.mNextPostDialChar = 0;
        log("proceedAfterWildChar: new postDialString is " + this.mPostDialString);
        processNextPostDialChar();
    }

    public void cancelPostDial() {
        setPostDialState(PostDialState.CANCELLED);
    }

    void onHangupLocal() {
        this.mCause = EVENT_NEXT_POST_DIAL;
        this.mPreciseCause = 0;
    }

    int disconnectCauseFromCode(int causeCode) {
        switch (causeCode) {
            case EVENT_DTMF_DONE /*1*/:
                return 25;
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
                return EVENT_WAKE_LOCK_TIMEOUT;
            case CallFailCause.NO_CIRCUIT_AVAIL /*34*/:
            case CallFailCause.TEMPORARY_FAILURE /*41*/:
            case CallFailCause.SWITCHING_CONGESTION /*42*/:
            case CallFailCause.CHANNEL_NOT_AVAIL /*44*/:
            case CallFailCause.QOS_NOT_AVAIL /*49*/:
            case CallFailCause.BEARER_NOT_AVAIL /*58*/:
                return 5;
            case CallFailCause.ACM_LIMIT_EXCEEDED /*68*/:
                return 15;
            case CallFailCause.CALL_BARRED /*240*/:
                return 20;
            case CallFailCause.FDN_BLOCKED /*241*/:
                return 21;
            case CallFailCause.DIAL_MODIFIED_TO_USSD /*244*/:
                return 46;
            case CallFailCause.DIAL_MODIFIED_TO_SS /*245*/:
                return 47;
            case CallFailCause.DIAL_MODIFIED_TO_DIAL /*246*/:
                return 48;
            default:
                GSMPhone phone = this.mOwner.mPhone;
                int serviceState = phone.getServiceState().getState();
                UiccCardApplication cardApp = phone.getUiccCardApplication();
                AppState uiccAppState = cardApp != null ? cardApp.getState() : AppState.APPSTATE_UNKNOWN;
                if (serviceState == EVENT_NEXT_POST_DIAL) {
                    return 17;
                }
                if (serviceState == EVENT_DTMF_DONE || serviceState == EVENT_PAUSE_DONE) {
                    return 18;
                }
                if (uiccAppState != AppState.APPSTATE_READY) {
                    return 19;
                }
                if (causeCode == CallFailCause.ERROR_UNSPECIFIED) {
                    if (phone.mSST.mRestrictedState.isCsRestricted()) {
                        return 22;
                    }
                    if (phone.mSST.mRestrictedState.isCsEmergencyRestricted()) {
                        return 24;
                    }
                    if (phone.mSST.mRestrictedState.isCsNormalRestricted()) {
                        return 23;
                    }
                    return 36;
                } else if (causeCode == 16) {
                    return EVENT_PAUSE_DONE;
                } else {
                    return 36;
                }
        }
    }

    void onRemoteDisconnect(int causeCode) {
        this.mPreciseCause = causeCode;
        onDisconnect(disconnectCauseFromCode(causeCode));
    }

    boolean onDisconnect(int cause) {
        boolean changed = false;
        this.mCause = cause;
        if (!this.mDisconnected) {
            this.mIndex = -1;
            this.mDisconnectTime = System.currentTimeMillis();
            this.mDuration = SystemClock.elapsedRealtime() - this.mConnectTimeReal;
            this.mDisconnected = DBG;
            Rlog.d(LOG_TAG, "onDisconnect: cause=" + cause);
            this.mOwner.mPhone.notifyDisconnect(this);
            if (this.mParent != null) {
                changed = this.mParent.connectionDisconnected(this);
            }
            this.mOrigConnection = null;
        }
        clearPostDialListeners();
        releaseWakeLock();
        return changed;
    }

    boolean update(DriverCall dc) {
        boolean wasHolding;
        boolean z = DBG;
        boolean changed = false;
        boolean wasConnectingInOrOut = isConnectingInOrOut();
        if (getState() == Call.State.HOLDING) {
            wasHolding = DBG;
        } else {
            wasHolding = false;
        }
        GsmCall newParent = parentFromDCState(dc.state);
        if (this.mOrigConnection != null) {
            log("update: mOrigConnection is not null");
        } else {
            log(" mNumberConverted " + this.mNumberConverted);
            if (!(equalsHandlesNulls(this.mAddress, dc.number) || (this.mNumberConverted && equalsHandlesNulls(this.mConvertedNumber, dc.number)))) {
                log("update: phone # changed!");
                this.mAddress = dc.number;
                changed = DBG;
            }
        }
        if (TextUtils.isEmpty(dc.name)) {
            if (!TextUtils.isEmpty(this.mCnapName)) {
                changed = DBG;
                this.mCnapName = "";
            }
        } else if (!dc.name.equals(this.mCnapName)) {
            changed = DBG;
            this.mCnapName = dc.name;
        }
        log("--dssds----" + this.mCnapName);
        this.mCnapNamePresentation = dc.namePresentation;
        this.mNumberPresentation = dc.numberPresentation;
        if (newParent != this.mParent) {
            if (this.mParent != null) {
                this.mParent.detach(this);
            }
            newParent.attach(this, dc);
            this.mParent = newParent;
            changed = DBG;
        } else {
            changed = (changed || this.mParent.update(this, dc)) ? DBG : false;
        }
        StringBuilder append = new StringBuilder().append("update: parent=").append(this.mParent).append(", hasNewParent=");
        if (newParent == this.mParent) {
            z = false;
        }
        log(append.append(z).append(", wasConnectingInOrOut=").append(wasConnectingInOrOut).append(", wasHolding=").append(wasHolding).append(", isConnectingInOrOut=").append(isConnectingInOrOut()).append(", changed=").append(changed).toString());
        if (wasConnectingInOrOut && !isConnectingInOrOut()) {
            onConnectedInOrOut();
        }
        if (changed && !wasHolding && getState() == Call.State.HOLDING) {
            onStartedHolding();
        }
        return changed;
    }

    void fakeHoldBeforeDial() {
        if (this.mParent != null) {
            this.mParent.detach(this);
        }
        this.mParent = this.mOwner.mBackgroundCall;
        this.mParent.attachFake(this, Call.State.HOLDING);
        onStartedHolding();
    }

    int getGSMIndex() throws CallStateException {
        if (this.mIndex >= 0) {
            return this.mIndex + EVENT_DTMF_DONE;
        }
        throw new CallStateException("GSM index not yet assigned");
    }

    void onConnectedInOrOut() {
        this.mConnectTime = System.currentTimeMillis();
        this.mConnectTimeReal = SystemClock.elapsedRealtime();
        this.mDuration = 0;
        log("onConnectedInOrOut: connectTime=" + this.mConnectTime);
        if (!this.mIsIncoming) {
            processNextPostDialChar();
        }
        releaseWakeLock();
    }

    void onStartedHolding() {
        this.mHoldingStartTime = SystemClock.elapsedRealtime();
    }

    private boolean processPostDialChar(char c) {
        if (PhoneNumberUtils.is12Key(c)) {
            this.mOwner.mCi.sendDtmf(c, this.mHandler.obtainMessage(EVENT_DTMF_DONE));
            return DBG;
        } else if (c == ',') {
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(EVENT_PAUSE_DONE), 3000);
            return DBG;
        } else if (c == ';') {
            setPostDialState(PostDialState.WAIT);
            return DBG;
        } else if (c != 'N') {
            return false;
        } else {
            setPostDialState(PostDialState.WILD);
            return DBG;
        }
    }

    public String getRemainingPostDialString() {
        if (this.mPostDialState == PostDialState.CANCELLED || this.mPostDialState == PostDialState.COMPLETE || this.mPostDialString == null || this.mPostDialString.length() <= this.mNextPostDialChar) {
            return "";
        }
        return this.mPostDialString.substring(this.mNextPostDialChar);
    }

    protected void finalize() {
        if (this.mPartialWakeLock.isHeld()) {
            Rlog.e(LOG_TAG, "[GSMConn] UNEXPECTED; mPartialWakeLock is held when finalizing.");
        }
        clearPostDialListeners();
        releaseWakeLock();
    }

    private void processNextPostDialChar() {
        if (this.mPostDialState != PostDialState.CANCELLED) {
            char c;
            if (this.mPostDialString == null || this.mPostDialString.length() <= this.mNextPostDialChar) {
                setPostDialState(PostDialState.COMPLETE);
                c = '\u0000';
            } else {
                setPostDialState(PostDialState.STARTED);
                String str = this.mPostDialString;
                int i = this.mNextPostDialChar;
                this.mNextPostDialChar = i + EVENT_DTMF_DONE;
                c = str.charAt(i);
                if (!processPostDialChar(c)) {
                    this.mHandler.obtainMessage(EVENT_NEXT_POST_DIAL).sendToTarget();
                    Rlog.e("GSM", "processNextPostDialChar: c=" + c + " isn't valid!");
                    return;
                }
            }
            notifyPostDialListenersNextChar(c);
            Registrant postDialHandler = this.mOwner.mPhone.mPostDialHandler;
            if (postDialHandler != null) {
                Message notifyMessage = postDialHandler.messageForRegistrant();
                if (notifyMessage != null) {
                    PostDialState state = this.mPostDialState;
                    AsyncResult ar = AsyncResult.forMessage(notifyMessage);
                    ar.result = this;
                    ar.userObj = state;
                    notifyMessage.arg1 = c;
                    notifyMessage.sendToTarget();
                }
            }
        }
    }

    private boolean isConnectingInOrOut() {
        return (this.mParent == null || this.mParent == this.mOwner.mRingingCall || this.mParent.mState == Call.State.DIALING || this.mParent.mState == Call.State.ALERTING) ? DBG : false;
    }

    private GsmCall parentFromDCState(State state) {
        switch (C00671.$SwitchMap$com$android$internal$telephony$DriverCall$State[state.ordinal()]) {
            case EVENT_DTMF_DONE /*1*/:
            case EVENT_PAUSE_DONE /*2*/:
            case EVENT_NEXT_POST_DIAL /*3*/:
                return this.mOwner.mForegroundCall;
            case EVENT_WAKE_LOCK_TIMEOUT /*4*/:
                return this.mOwner.mBackgroundCall;
            case CharacterSets.ISO_8859_2 /*5*/:
            case CharacterSets.ISO_8859_3 /*6*/:
                return this.mOwner.mRingingCall;
            default:
                throw new RuntimeException("illegal call state: " + state);
        }
    }

    private void setPostDialState(PostDialState s) {
        if (this.mPostDialState != PostDialState.STARTED && s == PostDialState.STARTED) {
            acquireWakeLock();
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(EVENT_WAKE_LOCK_TIMEOUT), 60000);
        } else if (this.mPostDialState == PostDialState.STARTED && s != PostDialState.STARTED) {
            this.mHandler.removeMessages(EVENT_WAKE_LOCK_TIMEOUT);
            releaseWakeLock();
        }
        this.mPostDialState = s;
        notifyPostDialListeners();
    }

    private void createWakeLock(Context context) {
        this.mPartialWakeLock = ((PowerManager) context.getSystemService("power")).newWakeLock(EVENT_DTMF_DONE, LOG_TAG);
    }

    private void acquireWakeLock() {
        log("acquireWakeLock");
        this.mPartialWakeLock.acquire();
    }

    private void releaseWakeLock() {
        synchronized (this.mPartialWakeLock) {
            if (this.mPartialWakeLock.isHeld()) {
                log("releaseWakeLock");
                this.mPartialWakeLock.release();
            }
        }
    }

    private void log(String msg) {
        Rlog.d(LOG_TAG, "[GSMConn] " + msg);
    }

    public int getNumberPresentation() {
        return this.mNumberPresentation;
    }

    public UUSInfo getUUSInfo() {
        return this.mUusInfo;
    }

    public int getPreciseDisconnectCause() {
        return this.mPreciseCause;
    }

    public void migrateFrom(Connection c) {
        if (c != null) {
            super.migrateFrom(c);
            this.mUusInfo = c.getUUSInfo();
            setUserData(c.getUserData());
        }
    }

    public Connection getOrigConnection() {
        return this.mOrigConnection;
    }

    public boolean isMultiparty() {
        if (this.mOrigConnection != null) {
            return this.mOrigConnection.isMultiparty();
        }
        return false;
    }
}
