package com.android.internal.telephony.cdma;

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
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppState;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.android.internal.telephony.uicc.UiccController;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;

public class CdmaConnection extends Connection {
    static final int EVENT_DTMF_DONE = 1;
    static final int EVENT_NEXT_POST_DIAL = 3;
    static final int EVENT_PAUSE_DONE = 2;
    static final int EVENT_WAKE_LOCK_TIMEOUT = 4;
    static final String LOG_TAG = "CdmaConnection";
    static final int PAUSE_DELAY_MILLIS = 2000;
    private static final boolean VDBG = false;
    static final int WAKE_LOCK_TIMEOUT_MILLIS = 60000;
    int mCause;
    long mDisconnectTime;
    boolean mDisconnected;
    Handler mHandler;
    int mIndex;
    int mNextPostDialChar;
    CdmaCallTracker mOwner;
    CdmaCall mParent;
    private WakeLock mPartialWakeLock;
    PostDialState mPostDialState;
    String mPostDialString;
    int mPreciseCause;

    /* renamed from: com.android.internal.telephony.cdma.CdmaConnection.1 */
    static /* synthetic */ class C00431 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$DriverCall$State;

        static {
            $SwitchMap$com$android$internal$telephony$DriverCall$State = new int[State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[State.ACTIVE.ordinal()] = CdmaConnection.EVENT_DTMF_DONE;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[State.DIALING.ordinal()] = CdmaConnection.EVENT_PAUSE_DONE;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[State.ALERTING.ordinal()] = CdmaConnection.EVENT_NEXT_POST_DIAL;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DriverCall$State[State.HOLDING.ordinal()] = CdmaConnection.EVENT_WAKE_LOCK_TIMEOUT;
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
                case CdmaConnection.EVENT_DTMF_DONE /*1*/:
                case CdmaConnection.EVENT_PAUSE_DONE /*2*/:
                case CdmaConnection.EVENT_NEXT_POST_DIAL /*3*/:
                    CdmaConnection.this.processNextPostDialChar();
                case CdmaConnection.EVENT_WAKE_LOCK_TIMEOUT /*4*/:
                    CdmaConnection.this.releaseWakeLock();
                default:
            }
        }
    }

    CdmaConnection(Context context, DriverCall dc, CdmaCallTracker ct, int index) {
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
        this.mIndex = index;
        this.mParent = parentFromDCState(dc.state);
        this.mParent.attach(this, dc);
    }

    CdmaConnection(Context context, String dialString, CdmaCallTracker ct, CdmaCall parent) {
        this.mCause = 0;
        this.mPostDialState = PostDialState.NOT_STARTED;
        this.mPreciseCause = 0;
        createWakeLock(context);
        acquireWakeLock();
        this.mOwner = ct;
        this.mHandler = new MyHandler(this.mOwner.getLooper());
        this.mDialString = dialString;
        Rlog.d(LOG_TAG, "[CDMAConn] CdmaConnection: dialString=" + dialString);
        dialString = formatDialString(dialString);
        Rlog.d(LOG_TAG, "[CDMAConn] CdmaConnection:formated dialString=" + dialString);
        this.mAddress = PhoneNumberUtils.extractNetworkPortionAlt(dialString);
        this.mPostDialString = PhoneNumberUtils.extractPostDialPortion(dialString);
        this.mIndex = -1;
        this.mIsIncoming = VDBG;
        this.mCnapName = null;
        this.mCnapNamePresentation = EVENT_DTMF_DONE;
        this.mNumberPresentation = EVENT_DTMF_DONE;
        this.mCreateTime = System.currentTimeMillis();
        if (parent != null) {
            this.mParent = parent;
            if (parent.mState == Call.State.ACTIVE) {
                parent.attachFake(this, Call.State.ACTIVE);
            } else {
                parent.attachFake(this, Call.State.DIALING);
            }
        }
    }

    CdmaConnection(Context context, CdmaCallWaitingNotification cw, CdmaCallTracker ct, CdmaCall parent) {
        this.mCause = 0;
        this.mPostDialState = PostDialState.NOT_STARTED;
        this.mPreciseCause = 0;
        createWakeLock(context);
        acquireWakeLock();
        this.mOwner = ct;
        this.mHandler = new MyHandler(this.mOwner.getLooper());
        this.mAddress = cw.number;
        this.mNumberPresentation = cw.numberPresentation;
        this.mCnapName = cw.name;
        this.mCnapNamePresentation = cw.namePresentation;
        this.mIndex = -1;
        this.mIsIncoming = true;
        this.mCreateTime = System.currentTimeMillis();
        this.mConnectTime = 0;
        this.mParent = parent;
        parent.attachFake(this, Call.State.WAITING);
    }

    public void dispose() {
    }

    static boolean equalsHandlesNulls(Object a, Object b) {
        if (a == null) {
            return b == null ? true : VDBG;
        } else {
            return a.equals(b);
        }
    }

    boolean compareTo(DriverCall c) {
        if (!this.mIsIncoming && !c.isMT) {
            return true;
        }
        String cAddress = PhoneNumberUtils.stringFromStringAndTOA(c.number, c.TOA);
        if (this.mIsIncoming == c.isMT && equalsHandlesNulls(this.mAddress, cAddress)) {
            return true;
        }
        return VDBG;
    }

    public String getOrigDialString() {
        return this.mDialString;
    }

    public CdmaCall getCall() {
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
            Rlog.w(LOG_TAG, "CdmaConnection.proceedAfterWaitChar(): Expected getPostDialState() to be WAIT but was " + this.mPostDialState);
            return;
        }
        setPostDialState(PostDialState.STARTED);
        processNextPostDialChar();
    }

    public void proceedAfterWildChar(String str) {
        if (this.mPostDialState != PostDialState.WILD) {
            Rlog.w(LOG_TAG, "CdmaConnection.proceedAfterWaitChar(): Expected getPostDialState() to be WILD but was " + this.mPostDialState);
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
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
                return EVENT_WAKE_LOCK_TIMEOUT;
            case CallFailCause.NO_CIRCUIT_AVAIL /*34*/:
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
            case CharacterSets.UCS2 /*1000*/:
                return 26;
            case CallFailCause.CDMA_DROP /*1001*/:
                return 27;
            case CallFailCause.CDMA_INTERCEPT /*1002*/:
                return 28;
            case CallFailCause.CDMA_REORDER /*1003*/:
                return 29;
            case CallFailCause.CDMA_SO_REJECT /*1004*/:
                return 30;
            case CallFailCause.CDMA_RETRY_ORDER /*1005*/:
                return 31;
            case CallFailCause.CDMA_ACCESS_FAILURE /*1006*/:
                return 32;
            case CallFailCause.CDMA_PREEMPTED /*1007*/:
                return 33;
            case CallFailCause.CDMA_NOT_EMERGENCY /*1008*/:
                return 34;
            case CallFailCause.CDMA_ACCESS_BLOCKED /*1009*/:
                return 35;
            default:
                CDMAPhone phone = this.mOwner.mPhone;
                int serviceState = phone.getServiceState().getState();
                UiccCardApplication app = UiccController.getInstance().getUiccCardApplication(phone.getPhoneId(), EVENT_PAUSE_DONE);
                AppState uiccAppState = app != null ? app.getState() : AppState.APPSTATE_UNKNOWN;
                if (serviceState == EVENT_NEXT_POST_DIAL) {
                    return 17;
                }
                if (serviceState == EVENT_DTMF_DONE || serviceState == EVENT_PAUSE_DONE) {
                    return 18;
                }
                if (phone.mCdmaSubscriptionSource == 0 && uiccAppState != AppState.APPSTATE_READY) {
                    return 19;
                }
                if (causeCode != 16) {
                    return 36;
                }
                return EVENT_PAUSE_DONE;
        }
    }

    void onRemoteDisconnect(int causeCode) {
        this.mPreciseCause = causeCode;
        onDisconnect(disconnectCauseFromCode(causeCode));
    }

    boolean onDisconnect(int cause) {
        boolean changed = VDBG;
        this.mCause = cause;
        if (!this.mDisconnected) {
            doDisconnect();
            this.mOwner.mPhone.notifyDisconnect(this);
            if (this.mParent != null) {
                changed = this.mParent.connectionDisconnected(this);
            }
        }
        releaseWakeLock();
        return changed;
    }

    void onLocalDisconnect() {
        if (!this.mDisconnected) {
            doDisconnect();
            if (this.mParent != null) {
                this.mParent.detach(this);
            }
        }
        releaseWakeLock();
    }

    boolean update(DriverCall dc) {
        boolean wasHolding;
        boolean changed = VDBG;
        boolean wasConnectingInOrOut = isConnectingInOrOut();
        if (getState() == Call.State.HOLDING) {
            wasHolding = true;
        } else {
            wasHolding = VDBG;
        }
        CdmaCall newParent = parentFromDCState(dc.state);
        log("parent= " + this.mParent + ", newParent= " + newParent);
        log(" mNumberConverted " + this.mNumberConverted);
        if (!(equalsHandlesNulls(this.mAddress, dc.number) || (this.mNumberConverted && equalsHandlesNulls(this.mConvertedNumber, dc.number)))) {
            log("update: phone # changed!");
            this.mAddress = dc.number;
            changed = true;
        }
        if (TextUtils.isEmpty(dc.name)) {
            if (!TextUtils.isEmpty(this.mCnapName)) {
                changed = true;
                this.mCnapName = "";
            }
        } else if (!dc.name.equals(this.mCnapName)) {
            changed = true;
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
            changed = true;
        } else {
            changed = (changed || this.mParent.update(this, dc)) ? true : VDBG;
        }
        log("Update, wasConnectingInOrOut=" + wasConnectingInOrOut + ", wasHolding=" + wasHolding + ", isConnectingInOrOut=" + isConnectingInOrOut() + ", changed=" + changed);
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

    int getCDMAIndex() throws CallStateException {
        if (this.mIndex >= 0) {
            return this.mIndex + EVENT_DTMF_DONE;
        }
        throw new CallStateException("CDMA connection index not assigned");
    }

    void onConnectedInOrOut() {
        this.mConnectTime = System.currentTimeMillis();
        this.mConnectTimeReal = SystemClock.elapsedRealtime();
        this.mDuration = 0;
        log("onConnectedInOrOut: connectTime=" + this.mConnectTime);
        if (this.mIsIncoming) {
            releaseWakeLock();
        } else {
            processNextPostDialChar();
        }
    }

    private void doDisconnect() {
        this.mIndex = -1;
        this.mDisconnectTime = System.currentTimeMillis();
        this.mDuration = SystemClock.elapsedRealtime() - this.mConnectTimeReal;
        this.mDisconnected = true;
        clearPostDialListeners();
    }

    void onStartedHolding() {
        this.mHoldingStartTime = SystemClock.elapsedRealtime();
    }

    private boolean processPostDialChar(char c) {
        if (PhoneNumberUtils.is12Key(c)) {
            this.mOwner.mCi.sendDtmf(c, this.mHandler.obtainMessage(EVENT_DTMF_DONE));
            return true;
        } else if (c == ',') {
            setPostDialState(PostDialState.PAUSE);
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(EVENT_PAUSE_DONE), 2000);
            return true;
        } else if (c == ';') {
            setPostDialState(PostDialState.WAIT);
            return true;
        } else if (c != 'N') {
            return VDBG;
        } else {
            setPostDialState(PostDialState.WILD);
            return true;
        }
    }

    public String getRemainingPostDialString() {
        if (this.mPostDialState == PostDialState.CANCELLED || this.mPostDialState == PostDialState.COMPLETE || this.mPostDialString == null || this.mPostDialString.length() <= this.mNextPostDialChar) {
            return "";
        }
        String subStr = this.mPostDialString.substring(this.mNextPostDialChar);
        if (subStr == null) {
            return subStr;
        }
        int wIndex = subStr.indexOf(59);
        int pIndex = subStr.indexOf(44);
        if (wIndex > 0 && (wIndex < pIndex || pIndex <= 0)) {
            return subStr.substring(0, wIndex);
        }
        if (pIndex > 0) {
            return subStr.substring(0, pIndex);
        }
        return subStr;
    }

    public void updateParent(CdmaCall oldParent, CdmaCall newParent) {
        if (newParent != oldParent) {
            if (oldParent != null) {
                oldParent.detach(this);
            }
            newParent.attachFake(this, Call.State.ACTIVE);
            this.mParent = newParent;
        }
    }

    protected void finalize() {
        if (this.mPartialWakeLock.isHeld()) {
            Rlog.e(LOG_TAG, "[CdmaConn] UNEXPECTED; mPartialWakeLock is held when finalizing.");
        }
        releaseWakeLock();
    }

    void processNextPostDialChar() {
        if (this.mPostDialState == PostDialState.CANCELLED) {
            releaseWakeLock();
            return;
        }
        char c;
        if (this.mPostDialString == null || this.mPostDialString.length() <= this.mNextPostDialChar) {
            setPostDialState(PostDialState.COMPLETE);
            releaseWakeLock();
            c = '\u0000';
        } else {
            setPostDialState(PostDialState.STARTED);
            String str = this.mPostDialString;
            int i = this.mNextPostDialChar;
            this.mNextPostDialChar = i + EVENT_DTMF_DONE;
            c = str.charAt(i);
            if (!processPostDialChar(c)) {
                this.mHandler.obtainMessage(EVENT_NEXT_POST_DIAL).sendToTarget();
                Rlog.e("CDMA", "processNextPostDialChar: c=" + c + " isn't valid!");
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

    private boolean isConnectingInOrOut() {
        return (this.mParent == null || this.mParent == this.mOwner.mRingingCall || this.mParent.mState == Call.State.DIALING || this.mParent.mState == Call.State.ALERTING) ? true : VDBG;
    }

    private CdmaCall parentFromDCState(State state) {
        switch (C00431.$SwitchMap$com$android$internal$telephony$DriverCall$State[state.ordinal()]) {
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
        if (s == PostDialState.STARTED || s == PostDialState.PAUSE) {
            synchronized (this.mPartialWakeLock) {
                if (this.mPartialWakeLock.isHeld()) {
                    this.mHandler.removeMessages(EVENT_WAKE_LOCK_TIMEOUT);
                } else {
                    acquireWakeLock();
                }
                this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(EVENT_WAKE_LOCK_TIMEOUT), 60000);
            }
        } else {
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

    private static boolean isPause(char c) {
        return c == ',' ? true : VDBG;
    }

    private static boolean isWait(char c) {
        return c == ';' ? true : VDBG;
    }

    private static int findNextPCharOrNonPOrNonWCharIndex(String phoneNumber, int currIndex) {
        boolean wMatched = isWait(phoneNumber.charAt(currIndex));
        int index = currIndex + EVENT_DTMF_DONE;
        int length = phoneNumber.length();
        while (index < length) {
            char cNext = phoneNumber.charAt(index);
            if (isWait(cNext)) {
                wMatched = true;
            }
            if (!isWait(cNext) && !isPause(cNext)) {
                break;
            }
            index += EVENT_DTMF_DONE;
        }
        if (index >= length || index <= currIndex + EVENT_DTMF_DONE || wMatched || !isPause(phoneNumber.charAt(currIndex))) {
            return index;
        }
        return currIndex + EVENT_DTMF_DONE;
    }

    private static char findPOrWCharToAppend(String phoneNumber, int currPwIndex, int nextNonPwCharIndex) {
        char ret = isPause(phoneNumber.charAt(currPwIndex)) ? ',' : ';';
        if (nextNonPwCharIndex > currPwIndex + EVENT_DTMF_DONE) {
            return ';';
        }
        return ret;
    }

    public static String formatDialString(String phoneNumber) {
        if (phoneNumber == null) {
            return null;
        }
        int length = phoneNumber.length();
        StringBuilder ret = new StringBuilder();
        int currIndex = 0;
        while (currIndex < length) {
            char c = phoneNumber.charAt(currIndex);
            if (!isPause(c) && !isWait(c)) {
                ret.append(c);
            } else if (currIndex < length - 1) {
                int nextIndex = findNextPCharOrNonPOrNonWCharIndex(phoneNumber, currIndex);
                if (nextIndex < length) {
                    ret.append(findPOrWCharToAppend(phoneNumber, currIndex, nextIndex));
                    if (nextIndex > currIndex + EVENT_DTMF_DONE) {
                        currIndex = nextIndex - 1;
                    }
                } else if (nextIndex == length) {
                    currIndex = length - 1;
                }
            }
            currIndex += EVENT_DTMF_DONE;
        }
        return PhoneNumberUtils.cdmaCheckAndProcessPlusCode(ret.toString());
    }

    private void log(String msg) {
        Rlog.d(LOG_TAG, "[CDMAConn] " + msg);
    }

    public int getNumberPresentation() {
        return this.mNumberPresentation;
    }

    public UUSInfo getUUSInfo() {
        return null;
    }

    public int getPreciseDisconnectCause() {
        return this.mPreciseCause;
    }

    public Connection getOrigConnection() {
        return null;
    }

    public boolean isMultiparty() {
        return VDBG;
    }
}
