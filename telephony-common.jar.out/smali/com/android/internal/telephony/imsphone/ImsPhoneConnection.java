package com.android.internal.telephony.imsphone;

import android.content.Context;
import android.net.Uri;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.Registrant;
import android.os.SystemClock;
import android.telecom.Log;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import com.android.ims.ImsCall;
import com.android.ims.ImsCallProfile;
import com.android.ims.ImsException;
import com.android.internal.telephony.Call.State;
import com.android.internal.telephony.CallStateException;
import com.android.internal.telephony.Connection;
import com.android.internal.telephony.Connection.PostDialState;
import com.android.internal.telephony.UUSInfo;

public class ImsPhoneConnection extends Connection {
    private static final boolean DBG = true;
    private static final int EVENT_DTMF_DONE = 1;
    private static final int EVENT_NEXT_POST_DIAL = 3;
    private static final int EVENT_PAUSE_DONE = 2;
    private static final int EVENT_WAKE_LOCK_TIMEOUT = 4;
    private static final String LOG_TAG = "ImsPhoneConnection";
    private static final int PAUSE_DELAY_MILLIS = 3000;
    private static final int WAKE_LOCK_TIMEOUT_MILLIS = 60000;
    private int mCause;
    private long mConferenceConnectTime;
    private long mDisconnectTime;
    private boolean mDisconnected;
    private Handler mHandler;
    private ImsCall mImsCall;
    private int mNextPostDialChar;
    private ImsPhoneCallTracker mOwner;
    private ImsPhoneCall mParent;
    private WakeLock mPartialWakeLock;
    private PostDialState mPostDialState;
    private String mPostDialString;
    private UUSInfo mUusInfo;

    class MyHandler extends Handler {
        MyHandler(Looper l) {
            super(l);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case ImsPhoneConnection.EVENT_DTMF_DONE /*1*/:
                case ImsPhoneConnection.EVENT_PAUSE_DONE /*2*/:
                case ImsPhoneConnection.EVENT_NEXT_POST_DIAL /*3*/:
                    ImsPhoneConnection.this.processNextPostDialChar();
                case ImsPhoneConnection.EVENT_WAKE_LOCK_TIMEOUT /*4*/:
                    ImsPhoneConnection.this.releaseWakeLock();
                default:
            }
        }
    }

    ImsPhoneConnection(Context context, ImsCall imsCall, ImsPhoneCallTracker ct, ImsPhoneCall parent) {
        this.mCause = 0;
        this.mPostDialState = PostDialState.NOT_STARTED;
        this.mConferenceConnectTime = 0;
        createWakeLock(context);
        acquireWakeLock();
        this.mOwner = ct;
        this.mHandler = new MyHandler(this.mOwner.getLooper());
        this.mImsCall = imsCall;
        if (imsCall == null || imsCall.getCallProfile() == null) {
            this.mNumberPresentation = EVENT_NEXT_POST_DIAL;
            this.mCnapNamePresentation = EVENT_NEXT_POST_DIAL;
        } else {
            this.mAddress = imsCall.getCallProfile().getCallExtra("oi");
            this.mCnapName = imsCall.getCallProfile().getCallExtra("cna");
            this.mNumberPresentation = ImsCallProfile.OIRToPresentation(imsCall.getCallProfile().getCallExtraInt("oir"));
            this.mCnapNamePresentation = ImsCallProfile.OIRToPresentation(imsCall.getCallProfile().getCallExtraInt("cnap"));
            updateMediaCapabilities(imsCall);
        }
        this.mIsIncoming = DBG;
        this.mCreateTime = System.currentTimeMillis();
        this.mUusInfo = null;
        this.mParent = parent;
        this.mParent.attach(this, State.INCOMING);
    }

    ImsPhoneConnection(Context context, String dialString, ImsPhoneCallTracker ct, ImsPhoneCall parent) {
        this.mCause = 0;
        this.mPostDialState = PostDialState.NOT_STARTED;
        this.mConferenceConnectTime = 0;
        createWakeLock(context);
        acquireWakeLock();
        this.mOwner = ct;
        this.mHandler = new MyHandler(this.mOwner.getLooper());
        this.mDialString = dialString;
        this.mAddress = PhoneNumberUtils.extractNetworkPortionAlt(dialString);
        this.mPostDialString = PhoneNumberUtils.extractPostDialPortion(dialString);
        this.mIsIncoming = false;
        this.mCnapName = null;
        this.mCnapNamePresentation = EVENT_DTMF_DONE;
        this.mNumberPresentation = EVENT_DTMF_DONE;
        this.mCreateTime = System.currentTimeMillis();
        this.mParent = parent;
        parent.attachFake(this, State.DIALING);
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

    public String getOrigDialString() {
        return this.mDialString;
    }

    public ImsPhoneCall getCall() {
        return this.mParent;
    }

    public long getDisconnectTime() {
        return this.mDisconnectTime;
    }

    public long getHoldingStartTime() {
        return this.mHoldingStartTime;
    }

    public long getHoldDurationMillis() {
        if (getState() != State.HOLDING) {
            return 0;
        }
        return SystemClock.elapsedRealtime() - this.mHoldingStartTime;
    }

    public int getDisconnectCause() {
        return this.mCause;
    }

    public void setDisconnectCause(int cause) {
        this.mCause = cause;
    }

    public ImsPhoneCallTracker getOwner() {
        return this.mOwner;
    }

    public State getState() {
        if (this.mDisconnected) {
            return State.DISCONNECTED;
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
        throw new CallStateException("not supported");
    }

    public PostDialState getPostDialState() {
        return this.mPostDialState;
    }

    public void proceedAfterWaitChar() {
        if (this.mPostDialState != PostDialState.WAIT) {
            Rlog.w(LOG_TAG, "ImsPhoneConnection.proceedAfterWaitChar(): Expected getPostDialState() to be WAIT but was " + this.mPostDialState);
            return;
        }
        setPostDialState(PostDialState.STARTED);
        processNextPostDialChar();
    }

    public void proceedAfterWildChar(String str) {
        if (this.mPostDialState != PostDialState.WILD) {
            Rlog.w(LOG_TAG, "ImsPhoneConnection.proceedAfterWaitChar(): Expected getPostDialState() to be WILD but was " + this.mPostDialState);
            return;
        }
        setPostDialState(PostDialState.STARTED);
        StringBuilder buf = new StringBuilder(str);
        buf.append(this.mPostDialString.substring(this.mNextPostDialChar));
        this.mPostDialString = buf.toString();
        this.mNextPostDialChar = 0;
        Rlog.d(LOG_TAG, "proceedAfterWildChar: new postDialString is " + this.mPostDialString);
        processNextPostDialChar();
    }

    public void cancelPostDial() {
        setPostDialState(PostDialState.CANCELLED);
    }

    void onHangupLocal() {
        this.mCause = EVENT_NEXT_POST_DIAL;
    }

    public boolean onDisconnect(int cause) {
        Rlog.d(LOG_TAG, "onDisconnect: cause=" + cause);
        if (this.mCause != EVENT_NEXT_POST_DIAL) {
            this.mCause = cause;
        }
        return onDisconnect();
    }

    boolean onDisconnect() {
        boolean changed = false;
        if (!this.mDisconnected) {
            this.mDisconnectTime = System.currentTimeMillis();
            this.mDuration = SystemClock.elapsedRealtime() - this.mConnectTimeReal;
            this.mDisconnected = DBG;
            this.mOwner.mPhone.notifyDisconnect(this);
            if (this.mParent != null) {
                changed = this.mParent.connectionDisconnected(this);
            } else {
                Rlog.d(LOG_TAG, "onDisconnect: no parent");
            }
            if (this.mImsCall != null) {
                this.mImsCall.close();
            }
            this.mImsCall = null;
        }
        releaseWakeLock();
        return changed;
    }

    void onConnectedInOrOut() {
        this.mConnectTime = System.currentTimeMillis();
        this.mConnectTimeReal = SystemClock.elapsedRealtime();
        this.mDuration = 0;
        Rlog.d(LOG_TAG, "onConnectedInOrOut: connectTime=" + this.mConnectTime);
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
            this.mOwner.sendDtmf(c, this.mHandler.obtainMessage(EVENT_DTMF_DONE));
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
                    Rlog.e(LOG_TAG, "processNextPostDialChar: c=" + c + " isn't valid!");
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
        Rlog.d(LOG_TAG, "acquireWakeLock");
        this.mPartialWakeLock.acquire();
    }

    void releaseWakeLock() {
        synchronized (this.mPartialWakeLock) {
            if (this.mPartialWakeLock.isHeld()) {
                Rlog.d(LOG_TAG, "releaseWakeLock");
                this.mPartialWakeLock.release();
            }
        }
    }

    public int getNumberPresentation() {
        return this.mNumberPresentation;
    }

    public UUSInfo getUUSInfo() {
        return this.mUusInfo;
    }

    public Connection getOrigConnection() {
        return null;
    }

    public boolean isMultiparty() {
        return (this.mImsCall == null || !this.mImsCall.isMultiparty()) ? false : DBG;
    }

    ImsCall getImsCall() {
        return this.mImsCall;
    }

    void setImsCall(ImsCall imsCall) {
        this.mImsCall = imsCall;
    }

    void changeParent(ImsPhoneCall parent) {
        this.mParent = parent;
    }

    boolean update(ImsCall imsCall, State state) {
        if (state == State.ACTIVE) {
            if (this.mParent.getState().isRinging() || this.mParent.getState().isDialing()) {
                onConnectedInOrOut();
            }
            if (this.mParent.getState().isRinging() || this.mParent == this.mOwner.mBackgroundCall) {
                this.mParent.detach(this);
                this.mParent = this.mOwner.mForegroundCall;
                this.mParent.attach(this);
            }
        } else if (state == State.HOLDING) {
            onStartedHolding();
        }
        boolean updateParent = this.mParent.update(this, imsCall, state);
        boolean updateMediaCapabilities = updateMediaCapabilities(imsCall);
        if (updateParent || updateMediaCapabilities) {
            return DBG;
        }
        return false;
    }

    public int getPreciseDisconnectCause() {
        return 0;
    }

    public void onDisconnectConferenceParticipant(Uri endpoint) {
        ImsCall imsCall = getImsCall();
        if (imsCall != null) {
            try {
                String[] strArr = new String[EVENT_DTMF_DONE];
                strArr[0] = endpoint.toString();
                imsCall.removeParticipants(strArr);
            } catch (ImsException e) {
                Rlog.e(LOG_TAG, "onDisconnectConferenceParticipant: no session in place. Failed to disconnect endpoint = " + endpoint);
            }
        }
    }

    public void setConferenceConnectTime(long conferenceConnectTime) {
        this.mConferenceConnectTime = conferenceConnectTime;
    }

    public long getConferenceConnectTime() {
        return this.mConferenceConnectTime;
    }

    private boolean updateMediaCapabilities(ImsCall imsCall) {
        if (imsCall == null) {
            return false;
        }
        boolean changed = false;
        try {
            ImsCallProfile negotiatedCallProfile = imsCall.getCallProfile();
            ImsCallProfile localCallProfile = imsCall.getLocalCallProfile();
            ImsCallProfile remoteCallProfile = imsCall.getRemoteCallProfile();
            if (negotiatedCallProfile != null) {
                int newVideoState = ImsCallProfile.getVideoStateFromCallType(negotiatedCallProfile.mCallType);
                if (getVideoState() != newVideoState) {
                    setVideoState(newVideoState);
                    changed = DBG;
                }
            }
            if (localCallProfile != null) {
                boolean newLocalVideoCapable;
                if (localCallProfile.mCallType == EVENT_WAKE_LOCK_TIMEOUT) {
                    newLocalVideoCapable = DBG;
                } else {
                    newLocalVideoCapable = false;
                }
                if (isLocalVideoCapable() != newLocalVideoCapable) {
                    setLocalVideoCapable(newLocalVideoCapable);
                    changed = DBG;
                }
            }
            int newAudioQuality = getAudioQualityFromCallProfile(localCallProfile, remoteCallProfile);
            if (getAudioQuality() == newAudioQuality) {
                return changed;
            }
            setAudioQuality(newAudioQuality);
            return DBG;
        } catch (ImsException e) {
            return false;
        }
    }

    private int getAudioQualityFromCallProfile(ImsCallProfile localCallProfile, ImsCallProfile remoteCallProfile) {
        if (localCallProfile == null || remoteCallProfile == null || localCallProfile.mMediaProfile == null) {
            return EVENT_DTMF_DONE;
        }
        boolean isHighDef = ((localCallProfile.mMediaProfile.mAudioQuality == EVENT_PAUSE_DONE || localCallProfile.mMediaProfile.mAudioQuality == 6) && remoteCallProfile.mRestrictCause == 0) ? DBG : false;
        if (isHighDef) {
            return EVENT_PAUSE_DONE;
        }
        return EVENT_DTMF_DONE;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("[ImsPhoneConnection objId: ");
        sb.append(System.identityHashCode(this));
        sb.append(" address:");
        sb.append(Log.pii(getAddress()));
        sb.append(" ImsCall:");
        if (this.mImsCall == null) {
            sb.append("null");
        } else {
            sb.append(this.mImsCall);
        }
        sb.append("]");
        return sb.toString();
    }
}
