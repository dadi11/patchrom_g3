package com.android.internal.telephony.sip;

import android.content.Context;
import android.media.AudioManager;
import android.net.LinkProperties;
import android.net.rtp.AudioGroup;
import android.net.sip.SipAudioCall;
import android.net.sip.SipAudioCall.Listener;
import android.net.sip.SipErrorCode;
import android.net.sip.SipException;
import android.net.sip.SipManager;
import android.net.sip.SipProfile;
import android.net.sip.SipProfile.Builder;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.telephony.CellLocation;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SignalStrength;
import android.text.TextUtils;
import com.android.internal.telephony.Call;
import com.android.internal.telephony.Call.State;
import com.android.internal.telephony.CallStateException;
import com.android.internal.telephony.Connection;
import com.android.internal.telephony.IccCard;
import com.android.internal.telephony.IccPhoneBookInterfaceManager;
import com.android.internal.telephony.OperatorInfo;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.Phone.DataActivityState;
import com.android.internal.telephony.PhoneConstants;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.android.internal.telephony.PhoneNotifier;
import com.android.internal.telephony.PhoneSubInfo;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.SubscriptionInfoUpdater;
import com.android.internal.telephony.UUSInfo;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.uicc.IccFileHandler;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduPersister;
import java.text.ParseException;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;

public class SipPhone extends SipPhoneBase {
    private static final boolean DBG = true;
    private static final String LOG_TAG = "SipPhone";
    private static final int TIMEOUT_ANSWER_CALL = 8;
    private static final int TIMEOUT_HOLD_CALL = 15;
    private static final int TIMEOUT_MAKE_CALL = 15;
    private static final boolean VDBG = false;
    private SipCall mBackgroundCall;
    private SipCall mForegroundCall;
    private SipProfile mProfile;
    private SipCall mRingingCall;
    private SipManager mSipManager;

    private abstract class SipAudioCallAdapter extends Listener {
        private static final boolean SACA_DBG = true;
        private static final String SACA_TAG = "SipAudioCallAdapter";

        protected abstract void onCallEnded(int i);

        protected abstract void onError(int i);

        private SipAudioCallAdapter() {
        }

        public void onCallEnded(SipAudioCall call) {
            log("onCallEnded: call=" + call);
            onCallEnded(call.isInCall() ? 2 : 1);
        }

        public void onCallBusy(SipAudioCall call) {
            log("onCallBusy: call=" + call);
            onCallEnded(4);
        }

        public void onError(SipAudioCall call, int errorCode, String errorMessage) {
            log("onError: call=" + call + " code=" + SipErrorCode.toString(errorCode) + ": " + errorMessage);
            switch (errorCode) {
                case -12:
                    onError(9);
                case -11:
                    onError(11);
                case -10:
                    onError(14);
                case -8:
                    onError(10);
                case -7:
                    onError(SipPhone.TIMEOUT_ANSWER_CALL);
                case -6:
                    onError(7);
                case -5:
                case SubscriptionInfoUpdater.SIM_REPOSITION /*-3*/:
                    onError(13);
                case SubscriptionInfoUpdater.SIM_NEW /*-2*/:
                    onError(12);
                default:
                    onError(36);
            }
        }

        private void log(String s) {
            Rlog.d(SACA_TAG, s);
        }
    }

    private class SipCall extends SipCallBase {
        private static final boolean SC_DBG = true;
        private static final String SC_TAG = "SipCall";
        private static final boolean SC_VDBG = false;

        private SipCall() {
        }

        void reset() {
            log("reset");
            this.mConnections.clear();
            setState(State.IDLE);
        }

        void switchWith(SipCall that) {
            log("switchWith");
            synchronized (SipPhone.class) {
                SipCall tmp = new SipCall();
                tmp.takeOver(this);
                takeOver(that);
                that.takeOver(tmp);
            }
        }

        private void takeOver(SipCall that) {
            log("takeOver");
            this.mConnections = that.mConnections;
            this.mState = that.mState;
            Iterator i$ = this.mConnections.iterator();
            while (i$.hasNext()) {
                ((SipConnection) ((Connection) i$.next())).changeOwner(this);
            }
        }

        public Phone getPhone() {
            return SipPhone.this;
        }

        public List<Connection> getConnections() {
            List list;
            synchronized (SipPhone.class) {
                list = this.mConnections;
            }
            return list;
        }

        Connection dial(String originalNumber) throws SipException {
            log("dial: num=" + "xxx");
            String calleeSipUri = originalNumber;
            if (!calleeSipUri.contains("@")) {
                calleeSipUri = SipPhone.this.mProfile.getUriString().replaceFirst(Pattern.quote(SipPhone.this.mProfile.getUserName() + "@"), calleeSipUri + "@");
            }
            try {
                SipConnection c = new SipConnection(this, new Builder(calleeSipUri).build(), originalNumber);
                c.dial();
                this.mConnections.add(c);
                setState(State.DIALING);
                return c;
            } catch (ParseException e) {
                throw new SipException("dial", e);
            }
        }

        public void hangup() throws CallStateException {
            synchronized (SipPhone.class) {
                if (this.mState.isAlive()) {
                    log("hangup: call " + getState() + ": " + this + " on phone " + getPhone());
                    setState(State.DISCONNECTING);
                    CallStateException excp = null;
                    Iterator i$ = this.mConnections.iterator();
                    while (i$.hasNext()) {
                        try {
                            ((Connection) i$.next()).hangup();
                        } catch (CallStateException e) {
                            excp = e;
                        }
                    }
                    if (excp != null) {
                        throw excp;
                    }
                }
                log("hangup: dead call " + getState() + ": " + this + " on phone " + getPhone());
            }
        }

        SipConnection initIncomingCall(SipAudioCall sipAudioCall, boolean makeCallWait) {
            SipConnection c = new SipConnection(SipPhone.this, this, sipAudioCall.getPeerProfile());
            this.mConnections.add(c);
            State newState = makeCallWait ? State.WAITING : State.INCOMING;
            c.initIncomingCall(sipAudioCall, newState);
            setState(newState);
            SipPhone.this.notifyNewRingingConnectionP(c);
            return c;
        }

        void rejectCall() throws CallStateException {
            log("rejectCall:");
            hangup();
        }

        void acceptCall() throws CallStateException {
            log("acceptCall: accepting");
            if (this != SipPhone.this.mRingingCall) {
                throw new CallStateException("acceptCall() in a non-ringing call");
            } else if (this.mConnections.size() != 1) {
                throw new CallStateException("acceptCall() in a conf call");
            } else {
                ((SipConnection) this.mConnections.get(0)).acceptCall();
            }
        }

        private boolean isSpeakerOn() {
            return Boolean.valueOf(((AudioManager) SipPhone.this.mContext.getSystemService("audio")).isSpeakerphoneOn()).booleanValue();
        }

        void setAudioGroupMode() {
            AudioGroup audioGroup = getAudioGroup();
            if (audioGroup == null) {
                log("setAudioGroupMode: audioGroup == null ignore");
                return;
            }
            int mode = audioGroup.getMode();
            if (this.mState == State.HOLDING) {
                audioGroup.setMode(0);
            } else if (getMute()) {
                audioGroup.setMode(1);
            } else if (isSpeakerOn()) {
                audioGroup.setMode(3);
            } else {
                audioGroup.setMode(2);
            }
            log(String.format("setAudioGroupMode change: %d --> %d", new Object[]{Integer.valueOf(mode), Integer.valueOf(audioGroup.getMode())}));
        }

        void hold() throws CallStateException {
            log("hold:");
            setState(State.HOLDING);
            Iterator i$ = this.mConnections.iterator();
            while (i$.hasNext()) {
                ((SipConnection) ((Connection) i$.next())).hold();
            }
            setAudioGroupMode();
        }

        void unhold() throws CallStateException {
            log("unhold:");
            setState(State.ACTIVE);
            AudioGroup audioGroup = new AudioGroup();
            Iterator i$ = this.mConnections.iterator();
            while (i$.hasNext()) {
                ((SipConnection) ((Connection) i$.next())).unhold(audioGroup);
            }
            setAudioGroupMode();
        }

        void setMute(boolean muted) {
            log("setMute: muted=" + muted);
            Iterator i$ = this.mConnections.iterator();
            while (i$.hasNext()) {
                ((SipConnection) ((Connection) i$.next())).setMute(muted);
            }
        }

        boolean getMute() {
            boolean ret = false;
            if (!this.mConnections.isEmpty()) {
                ret = ((SipConnection) this.mConnections.get(0)).getMute();
            }
            log("getMute: ret=" + ret);
            return ret;
        }

        void merge(SipCall that) throws CallStateException {
            log("merge:");
            AudioGroup audioGroup = getAudioGroup();
            for (Connection conn : (Connection[]) that.mConnections.toArray(new Connection[that.mConnections.size()])) {
                SipConnection conn2 = (SipConnection) conn;
                add(conn2);
                if (conn2.getState() == State.HOLDING) {
                    conn2.unhold(audioGroup);
                }
            }
            that.setState(State.IDLE);
        }

        private void add(SipConnection conn) {
            log("add:");
            SipCall call = conn.getCall();
            if (call != this) {
                if (call != null) {
                    call.mConnections.remove(conn);
                }
                this.mConnections.add(conn);
                conn.changeOwner(this);
            }
        }

        void sendDtmf(char c) {
            log("sendDtmf: c=" + c);
            AudioGroup audioGroup = getAudioGroup();
            if (audioGroup == null) {
                log("sendDtmf: audioGroup == null, ignore c=" + c);
            } else {
                audioGroup.sendDtmf(convertDtmf(c));
            }
        }

        private int convertDtmf(char c) {
            int code = c - 48;
            if (code >= 0 && code <= 9) {
                return code;
            }
            switch (c) {
                case SmsHeader.ELT_ID_ENHANCED_VOICE_MAIL_INFORMATION /*35*/:
                    return 11;
                case CallFailCause.SWITCHING_CONGESTION /*42*/:
                    return 10;
                case 'A':
                    return 12;
                case 'B':
                    return 13;
                case 'C':
                    return 14;
                case CallFailCause.ACM_LIMIT_EXCEEDED /*68*/:
                    return SipPhone.TIMEOUT_MAKE_CALL;
                default:
                    throw new IllegalArgumentException("invalid DTMF char: " + c);
            }
        }

        protected void setState(State newState) {
            if (this.mState != newState) {
                log("setState: cur state" + this.mState + " --> " + newState + ": " + this + ": on phone " + getPhone() + " " + this.mConnections.size());
                if (newState == State.ALERTING) {
                    this.mState = newState;
                    SipPhone.this.startRingbackTone();
                } else if (this.mState == State.ALERTING) {
                    SipPhone.this.stopRingbackTone();
                }
                this.mState = newState;
                SipPhone.this.updatePhoneState();
                SipPhone.this.notifyPreciseCallStateChanged();
            }
        }

        void onConnectionStateChanged(SipConnection conn) {
            log("onConnectionStateChanged: conn=" + conn);
            if (this.mState != State.ACTIVE) {
                setState(conn.getState());
            }
        }

        void onConnectionEnded(SipConnection conn) {
            log("onConnectionEnded: conn=" + conn);
            if (this.mState != State.DISCONNECTED) {
                boolean allConnectionsDisconnected = SC_DBG;
                log("---check connections: " + this.mConnections.size());
                Iterator i$ = this.mConnections.iterator();
                while (i$.hasNext()) {
                    Connection c = (Connection) i$.next();
                    log("   state=" + c.getState() + ": " + c);
                    if (c.getState() != State.DISCONNECTED) {
                        allConnectionsDisconnected = false;
                        break;
                    }
                }
                if (allConnectionsDisconnected) {
                    setState(State.DISCONNECTED);
                }
            }
            SipPhone.this.notifyDisconnectP(conn);
        }

        private AudioGroup getAudioGroup() {
            if (this.mConnections.isEmpty()) {
                return null;
            }
            return ((SipConnection) this.mConnections.get(0)).getAudioGroup();
        }

        private void log(String s) {
            Rlog.d(SC_TAG, s);
        }
    }

    private class SipConnection extends SipConnectionBase {
        private static final boolean SCN_DBG = true;
        private static final String SCN_TAG = "SipConnection";
        private SipAudioCallAdapter mAdapter;
        private boolean mIncoming;
        private String mOriginalNumber;
        private SipCall mOwner;
        private SipProfile mPeer;
        private SipAudioCall mSipAudioCall;
        private State mState;

        /* renamed from: com.android.internal.telephony.sip.SipPhone.SipConnection.1 */
        class C00821 extends SipAudioCallAdapter {
            C00821() {
                super(null);
            }

            protected void onCallEnded(int cause) {
                if (SipConnection.this.getDisconnectCause() != 3) {
                    SipConnection.this.setDisconnectCause(cause);
                }
                synchronized (SipPhone.class) {
                    String sessionState;
                    SipConnection.this.setState(State.DISCONNECTED);
                    SipAudioCall sipAudioCall = SipConnection.this.mSipAudioCall;
                    SipConnection.this.mSipAudioCall = null;
                    if (sipAudioCall == null) {
                        sessionState = "";
                    } else {
                        sessionState = sipAudioCall.getState() + ", ";
                    }
                    SipConnection.this.log("[SipAudioCallAdapter] onCallEnded: " + SipConnection.this.mPeer.getUriString() + ": " + sessionState + "cause: " + SipConnection.this.getDisconnectCause() + ", on phone " + SipConnection.this.getPhone());
                    if (sipAudioCall != null) {
                        sipAudioCall.setListener(null);
                        sipAudioCall.close();
                    }
                    SipConnection.this.mOwner.onConnectionEnded(SipConnection.this);
                }
            }

            public void onCallEstablished(SipAudioCall call) {
                onChanged(call);
                if (SipConnection.this.mState == State.ACTIVE) {
                    call.startAudio();
                }
            }

            public void onCallHeld(SipAudioCall call) {
                onChanged(call);
                if (SipConnection.this.mState == State.HOLDING) {
                    call.startAudio();
                }
            }

            public void onChanged(SipAudioCall call) {
                synchronized (SipPhone.class) {
                    State newState = SipPhone.getCallStateFrom(call);
                    if (SipConnection.this.mState == newState) {
                        return;
                    }
                    if (newState == State.INCOMING) {
                        SipConnection.this.setState(SipConnection.this.mOwner.getState());
                    } else {
                        if (SipConnection.this.mOwner == SipPhone.this.mRingingCall) {
                            if (SipPhone.this.mRingingCall.getState() == State.WAITING) {
                                try {
                                    SipPhone.this.switchHoldingAndActive();
                                } catch (CallStateException e) {
                                    onCallEnded(3);
                                    return;
                                }
                            }
                            SipPhone.this.mForegroundCall.switchWith(SipPhone.this.mRingingCall);
                        }
                        SipConnection.this.setState(newState);
                    }
                    SipConnection.this.mOwner.onConnectionStateChanged(SipConnection.this);
                    SipConnection.this.log("onChanged: " + SipConnection.this.mPeer.getUriString() + ": " + SipConnection.this.mState + " on phone " + SipConnection.this.getPhone());
                }
            }

            protected void onError(int cause) {
                SipConnection.this.log("onError: " + cause);
                onCallEnded(cause);
            }
        }

        public SipConnection(SipCall owner, SipProfile callee, String originalNumber) {
            super(originalNumber);
            this.mState = State.IDLE;
            this.mIncoming = false;
            this.mAdapter = new C00821();
            this.mOwner = owner;
            this.mPeer = callee;
            this.mOriginalNumber = originalNumber;
        }

        public SipConnection(SipPhone sipPhone, SipCall owner, SipProfile callee) {
            this(owner, callee, sipPhone.getUriString(callee));
        }

        public String getCnapName() {
            String displayName = this.mPeer.getDisplayName();
            return TextUtils.isEmpty(displayName) ? null : displayName;
        }

        public int getNumberPresentation() {
            return 1;
        }

        void initIncomingCall(SipAudioCall sipAudioCall, State newState) {
            setState(newState);
            this.mSipAudioCall = sipAudioCall;
            sipAudioCall.setListener(this.mAdapter);
            this.mIncoming = SCN_DBG;
        }

        void acceptCall() throws CallStateException {
            try {
                this.mSipAudioCall.answerCall(SipPhone.TIMEOUT_ANSWER_CALL);
            } catch (SipException e) {
                throw new CallStateException("acceptCall(): " + e);
            }
        }

        void changeOwner(SipCall owner) {
            this.mOwner = owner;
        }

        AudioGroup getAudioGroup() {
            if (this.mSipAudioCall == null) {
                return null;
            }
            return this.mSipAudioCall.getAudioGroup();
        }

        void dial() throws SipException {
            setState(State.DIALING);
            this.mSipAudioCall = SipPhone.this.mSipManager.makeAudioCall(SipPhone.this.mProfile, this.mPeer, null, SipPhone.TIMEOUT_MAKE_CALL);
            this.mSipAudioCall.setListener(this.mAdapter);
        }

        void hold() throws CallStateException {
            setState(State.HOLDING);
            try {
                this.mSipAudioCall.holdCall(SipPhone.TIMEOUT_MAKE_CALL);
            } catch (SipException e) {
                throw new CallStateException("hold(): " + e);
            }
        }

        void unhold(AudioGroup audioGroup) throws CallStateException {
            this.mSipAudioCall.setAudioGroup(audioGroup);
            setState(State.ACTIVE);
            try {
                this.mSipAudioCall.continueCall(SipPhone.TIMEOUT_MAKE_CALL);
            } catch (SipException e) {
                throw new CallStateException("unhold(): " + e);
            }
        }

        void setMute(boolean muted) {
            if (this.mSipAudioCall != null && muted != this.mSipAudioCall.isMuted()) {
                log("setState: prev muted=" + (!muted ? SCN_DBG : false) + " new muted=" + muted);
                this.mSipAudioCall.toggleMute();
            }
        }

        boolean getMute() {
            return this.mSipAudioCall == null ? false : this.mSipAudioCall.isMuted();
        }

        protected void setState(State state) {
            if (state != this.mState) {
                super.setState(state);
                this.mState = state;
            }
        }

        public State getState() {
            return this.mState;
        }

        public boolean isIncoming() {
            return this.mIncoming;
        }

        public String getAddress() {
            return this.mOriginalNumber;
        }

        public SipCall getCall() {
            return this.mOwner;
        }

        protected Phone getPhone() {
            return this.mOwner.getPhone();
        }

        public void hangup() throws CallStateException {
            int i = 3;
            synchronized (SipPhone.class) {
                log("hangup: conn=" + this.mPeer.getUriString() + ": " + this.mState + ": on phone " + getPhone().getPhoneName());
                if (this.mState.isAlive()) {
                    try {
                        SipAudioCall sipAudioCall = this.mSipAudioCall;
                        if (sipAudioCall != null) {
                            sipAudioCall.setListener(null);
                            sipAudioCall.endCall();
                        }
                        SipAudioCallAdapter sipAudioCallAdapter = this.mAdapter;
                        if (this.mState == State.INCOMING || this.mState == State.WAITING) {
                            i = 16;
                        }
                        sipAudioCallAdapter.onCallEnded(i);
                    } catch (SipException e) {
                        throw new CallStateException("hangup(): " + e);
                    } catch (Throwable th) {
                        SipAudioCallAdapter sipAudioCallAdapter2 = this.mAdapter;
                        if (this.mState == State.INCOMING || this.mState == State.WAITING) {
                            i = 16;
                        }
                        sipAudioCallAdapter2.onCallEnded(i);
                    }
                }
            }
        }

        public void separate() throws CallStateException {
            synchronized (SipPhone.class) {
                SipCall call = getPhone() == SipPhone.this ? (SipCall) SipPhone.this.getBackgroundCall() : (SipCall) SipPhone.this.getForegroundCall();
                if (call.getState() != State.IDLE) {
                    throw new CallStateException("cannot put conn back to a call in non-idle state: " + call.getState());
                }
                log("separate: conn=" + this.mPeer.getUriString() + " from " + this.mOwner + " back to " + call);
                Phone originalPhone = getPhone();
                AudioGroup audioGroup = call.getAudioGroup();
                call.add(this);
                this.mSipAudioCall.setAudioGroup(audioGroup);
                originalPhone.switchHoldingAndActive();
                call = (SipCall) SipPhone.this.getForegroundCall();
                this.mSipAudioCall.startAudio();
                call.onConnectionStateChanged(this);
            }
        }

        private void log(String s) {
            Rlog.d(SCN_TAG, s);
        }
    }

    public /* bridge */ /* synthetic */ void activateCellBroadcastSms(int i, Message message) {
        super.activateCellBroadcastSms(i, message);
    }

    public /* bridge */ /* synthetic */ boolean canDial() {
        return super.canDial();
    }

    public /* bridge */ /* synthetic */ Connection dial(String str, UUSInfo uUSInfo, int i) throws CallStateException {
        return super.dial(str, uUSInfo, i);
    }

    public /* bridge */ /* synthetic */ boolean disableDataConnectivity() {
        return super.disableDataConnectivity();
    }

    public /* bridge */ /* synthetic */ void disableLocationUpdates() {
        super.disableLocationUpdates();
    }

    public /* bridge */ /* synthetic */ boolean enableDataConnectivity() {
        return super.enableDataConnectivity();
    }

    public /* bridge */ /* synthetic */ void enableLocationUpdates() {
        super.enableLocationUpdates();
    }

    public /* bridge */ /* synthetic */ void getAvailableNetworks(Message message) {
        super.getAvailableNetworks(message);
    }

    public /* bridge */ /* synthetic */ boolean getCallForwardingIndicator() {
        return super.getCallForwardingIndicator();
    }

    public /* bridge */ /* synthetic */ void getCallForwardingOption(int i, Message message) {
        super.getCallForwardingOption(i, message);
    }

    public /* bridge */ /* synthetic */ void getCellBroadcastSmsConfig(Message message) {
        super.getCellBroadcastSmsConfig(message);
    }

    public /* bridge */ /* synthetic */ CellLocation getCellLocation() {
        return super.getCellLocation();
    }

    public /* bridge */ /* synthetic */ List getCurrentDataConnectionList() {
        return super.getCurrentDataConnectionList();
    }

    public /* bridge */ /* synthetic */ DataActivityState getDataActivityState() {
        return super.getDataActivityState();
    }

    public /* bridge */ /* synthetic */ void getDataCallList(Message message) {
        super.getDataCallList(message);
    }

    public /* bridge */ /* synthetic */ DataState getDataConnectionState() {
        return super.getDataConnectionState();
    }

    public /* bridge */ /* synthetic */ DataState getDataConnectionState(String str) {
        return super.getDataConnectionState(str);
    }

    public /* bridge */ /* synthetic */ boolean getDataEnabled() {
        return super.getDataEnabled();
    }

    public /* bridge */ /* synthetic */ boolean getDataRoamingEnabled() {
        return super.getDataRoamingEnabled();
    }

    public /* bridge */ /* synthetic */ String getDeviceId() {
        return super.getDeviceId();
    }

    public /* bridge */ /* synthetic */ String getDeviceSvn() {
        return super.getDeviceSvn();
    }

    public /* bridge */ /* synthetic */ String getEsn() {
        return super.getEsn();
    }

    public /* bridge */ /* synthetic */ String getGroupIdLevel1() {
        return super.getGroupIdLevel1();
    }

    public /* bridge */ /* synthetic */ IccCard getIccCard() {
        return super.getIccCard();
    }

    public /* bridge */ /* synthetic */ IccFileHandler getIccFileHandler() {
        return super.getIccFileHandler();
    }

    public /* bridge */ /* synthetic */ IccPhoneBookInterfaceManager getIccPhoneBookInterfaceManager() {
        return super.getIccPhoneBookInterfaceManager();
    }

    public /* bridge */ /* synthetic */ boolean getIccRecordsLoaded() {
        return super.getIccRecordsLoaded();
    }

    public /* bridge */ /* synthetic */ String getIccSerialNumber() {
        return super.getIccSerialNumber();
    }

    public /* bridge */ /* synthetic */ String getImei() {
        return super.getImei();
    }

    public /* bridge */ /* synthetic */ String getLine1AlphaTag() {
        return super.getLine1AlphaTag();
    }

    public /* bridge */ /* synthetic */ String getLine1Number() {
        return super.getLine1Number();
    }

    public /* bridge */ /* synthetic */ LinkProperties getLinkProperties(String str) {
        return super.getLinkProperties(str);
    }

    public /* bridge */ /* synthetic */ String getMeid() {
        return super.getMeid();
    }

    public /* bridge */ /* synthetic */ boolean getMessageWaitingIndicator() {
        return super.getMessageWaitingIndicator();
    }

    public /* bridge */ /* synthetic */ void getNeighboringCids(Message message) {
        super.getNeighboringCids(message);
    }

    public /* bridge */ /* synthetic */ List getPendingMmiCodes() {
        return super.getPendingMmiCodes();
    }

    public /* bridge */ /* synthetic */ PhoneSubInfo getPhoneSubInfo() {
        return super.getPhoneSubInfo();
    }

    public /* bridge */ /* synthetic */ int getPhoneType() {
        return super.getPhoneType();
    }

    public /* bridge */ /* synthetic */ SignalStrength getSignalStrength() {
        return super.getSignalStrength();
    }

    public /* bridge */ /* synthetic */ PhoneConstants.State getState() {
        return super.getState();
    }

    public /* bridge */ /* synthetic */ String getSubscriberId() {
        return super.getSubscriberId();
    }

    public /* bridge */ /* synthetic */ String getVoiceMailAlphaTag() {
        return super.getVoiceMailAlphaTag();
    }

    public /* bridge */ /* synthetic */ String getVoiceMailNumber() {
        return super.getVoiceMailNumber();
    }

    public /* bridge */ /* synthetic */ boolean handleInCallMmiCommands(String str) {
        return super.handleInCallMmiCommands(str);
    }

    public /* bridge */ /* synthetic */ boolean handlePinMmi(String str) {
        return super.handlePinMmi(str);
    }

    public /* bridge */ /* synthetic */ boolean isDataConnectivityPossible() {
        return super.isDataConnectivityPossible();
    }

    public /* bridge */ /* synthetic */ boolean needsOtaServiceProvisioning() {
        return super.needsOtaServiceProvisioning();
    }

    public /* bridge */ /* synthetic */ void notifyCallForwardingIndicator() {
        super.notifyCallForwardingIndicator();
    }

    public /* bridge */ /* synthetic */ void registerForRingbackTone(Handler handler, int i, Object obj) {
        super.registerForRingbackTone(handler, i, obj);
    }

    public /* bridge */ /* synthetic */ void registerForSuppServiceNotification(Handler handler, int i, Object obj) {
        super.registerForSuppServiceNotification(handler, i, obj);
    }

    public /* bridge */ /* synthetic */ void saveClirSetting(int i) {
        super.saveClirSetting(i);
    }

    public /* bridge */ /* synthetic */ void selectNetworkManually(OperatorInfo operatorInfo, Message message) {
        super.selectNetworkManually(operatorInfo, message);
    }

    public /* bridge */ /* synthetic */ void sendUssdResponse(String str) {
        super.sendUssdResponse(str);
    }

    public /* bridge */ /* synthetic */ void setCallForwardingOption(int i, int i2, String str, int i3, Message message) {
        super.setCallForwardingOption(i, i2, str, i3, message);
    }

    public /* bridge */ /* synthetic */ void setCellBroadcastSmsConfig(int[] iArr, Message message) {
        super.setCellBroadcastSmsConfig(iArr, message);
    }

    public /* bridge */ /* synthetic */ void setDataEnabled(boolean z) {
        super.setDataEnabled(z);
    }

    public /* bridge */ /* synthetic */ void setDataRoamingEnabled(boolean z) {
        super.setDataRoamingEnabled(z);
    }

    public /* bridge */ /* synthetic */ boolean setLine1Number(String str, String str2, Message message) {
        return super.setLine1Number(str, str2, message);
    }

    public /* bridge */ /* synthetic */ void setNetworkSelectionModeAutomatic(Message message) {
        super.setNetworkSelectionModeAutomatic(message);
    }

    public /* bridge */ /* synthetic */ void setOnPostDialCharacter(Handler handler, int i, Object obj) {
        super.setOnPostDialCharacter(handler, i, obj);
    }

    public /* bridge */ /* synthetic */ void setRadioPower(boolean z) {
        super.setRadioPower(z);
    }

    public /* bridge */ /* synthetic */ void setVoiceMailNumber(String str, String str2, Message message) {
        super.setVoiceMailNumber(str, str2, message);
    }

    public /* bridge */ /* synthetic */ void unregisterForRingbackTone(Handler handler) {
        super.unregisterForRingbackTone(handler);
    }

    public /* bridge */ /* synthetic */ void unregisterForSuppServiceNotification(Handler handler) {
        super.unregisterForSuppServiceNotification(handler);
    }

    public /* bridge */ /* synthetic */ void updateServiceLocation() {
        super.updateServiceLocation();
    }

    SipPhone(Context context, PhoneNotifier notifier, SipProfile profile) {
        super("SIP:" + profile.getUriString(), context, notifier);
        this.mRingingCall = new SipCall();
        this.mForegroundCall = new SipCall();
        this.mBackgroundCall = new SipCall();
        log("new SipPhone: " + profile.getUriString());
        this.mRingingCall = new SipCall();
        this.mForegroundCall = new SipCall();
        this.mBackgroundCall = new SipCall();
        this.mProfile = profile;
        this.mSipManager = SipManager.newInstance(context);
    }

    public boolean equals(Object o) {
        if (o == this) {
            return DBG;
        }
        if (!(o instanceof SipPhone)) {
            return false;
        }
        return this.mProfile.getUriString().equals(((SipPhone) o).mProfile.getUriString());
    }

    public String getSipUri() {
        return this.mProfile.getUriString();
    }

    public boolean equals(SipPhone phone) {
        return getSipUri().equals(phone.getSipUri());
    }

    public Connection takeIncomingCall(Object incomingCall) {
        synchronized (SipPhone.class) {
            if (!(incomingCall instanceof SipAudioCall)) {
                log("takeIncomingCall: ret=null, not a SipAudioCall");
                return null;
            } else if (this.mRingingCall.getState().isAlive()) {
                log("takeIncomingCall: ret=null, ringingCall not alive");
                return null;
            } else if (this.mForegroundCall.getState().isAlive() && this.mBackgroundCall.getState().isAlive()) {
                log("takeIncomingCall: ret=null, foreground and background both alive");
                return null;
            } else {
                try {
                    SipAudioCall sipAudioCall = (SipAudioCall) incomingCall;
                    log("takeIncomingCall: taking call from: " + sipAudioCall.getPeerProfile().getUriString());
                    if (sipAudioCall.getLocalProfile().getUriString().equals(this.mProfile.getUriString())) {
                        Connection connection = this.mRingingCall.initIncomingCall(sipAudioCall, this.mForegroundCall.getState().isAlive());
                        if (sipAudioCall.getState() != 3) {
                            log("    takeIncomingCall: call cancelled !!");
                            this.mRingingCall.reset();
                            connection = null;
                        }
                        return connection;
                    }
                } catch (Exception e) {
                    log("    takeIncomingCall: exception e=" + e);
                    this.mRingingCall.reset();
                }
                log("takeIncomingCall: NOT taking !!");
                return null;
            }
        }
    }

    public void acceptCall(int videoState) throws CallStateException {
        synchronized (SipPhone.class) {
            if (this.mRingingCall.getState() == State.INCOMING || this.mRingingCall.getState() == State.WAITING) {
                log("acceptCall: accepting");
                this.mRingingCall.setMute(false);
                this.mRingingCall.acceptCall();
            } else {
                log("acceptCall: throw CallStateException(\"phone not ringing\")");
                throw new CallStateException("phone not ringing");
            }
        }
    }

    public void rejectCall() throws CallStateException {
        synchronized (SipPhone.class) {
            if (this.mRingingCall.getState().isRinging()) {
                log("rejectCall: rejecting");
                this.mRingingCall.rejectCall();
            } else {
                log("rejectCall: throw CallStateException(\"phone not ringing\")");
                throw new CallStateException("phone not ringing");
            }
        }
    }

    public Connection dial(String dialString, int videoState) throws CallStateException {
        Connection dialInternal;
        synchronized (SipPhone.class) {
            dialInternal = dialInternal(dialString, videoState);
        }
        return dialInternal;
    }

    private Connection dialInternal(String dialString, int videoState) throws CallStateException {
        log("dialInternal: dialString=" + "xxxxxx");
        clearDisconnected();
        if (canDial()) {
            if (this.mForegroundCall.getState() == State.ACTIVE) {
                switchHoldingAndActive();
            }
            if (this.mForegroundCall.getState() != State.IDLE) {
                throw new CallStateException("cannot dial in current state");
            }
            this.mForegroundCall.setMute(false);
            try {
                return this.mForegroundCall.dial(dialString);
            } catch (SipException e) {
                loge("dialInternal: ", e);
                throw new CallStateException("dial error: " + e);
            }
        }
        throw new CallStateException("dialInternal: cannot dial in current state");
    }

    public void switchHoldingAndActive() throws CallStateException {
        log("dialInternal: switch fg and bg");
        synchronized (SipPhone.class) {
            this.mForegroundCall.switchWith(this.mBackgroundCall);
            if (this.mBackgroundCall.getState().isAlive()) {
                this.mBackgroundCall.hold();
            }
            if (this.mForegroundCall.getState().isAlive()) {
                this.mForegroundCall.unhold();
            }
        }
    }

    public boolean canConference() {
        log("canConference: ret=true");
        return DBG;
    }

    public void conference() throws CallStateException {
        synchronized (SipPhone.class) {
            if (this.mForegroundCall.getState() == State.ACTIVE && this.mForegroundCall.getState() == State.ACTIVE) {
                log("conference: merge fg & bg");
                this.mForegroundCall.merge(this.mBackgroundCall);
            } else {
                throw new CallStateException("wrong state to merge calls: fg=" + this.mForegroundCall.getState() + ", bg=" + this.mBackgroundCall.getState());
            }
        }
    }

    public void conference(Call that) throws CallStateException {
        synchronized (SipPhone.class) {
            if (that instanceof SipCall) {
                this.mForegroundCall.merge((SipCall) that);
            } else {
                throw new CallStateException("expect " + SipCall.class + ", cannot merge with " + that.getClass());
            }
        }
    }

    public boolean canTransfer() {
        return false;
    }

    public void explicitCallTransfer() {
    }

    public void clearDisconnected() {
        synchronized (SipPhone.class) {
            this.mRingingCall.clearDisconnected();
            this.mForegroundCall.clearDisconnected();
            this.mBackgroundCall.clearDisconnected();
            updatePhoneState();
            notifyPreciseCallStateChanged();
        }
    }

    public void sendDtmf(char c) {
        if (!PhoneNumberUtils.is12Key(c)) {
            loge("sendDtmf called with invalid character '" + c + "'");
        } else if (this.mForegroundCall.getState().isAlive()) {
            synchronized (SipPhone.class) {
                this.mForegroundCall.sendDtmf(c);
            }
        }
    }

    public void startDtmf(char c) {
        if (PhoneNumberUtils.is12Key(c)) {
            sendDtmf(c);
        } else {
            loge("startDtmf called with invalid character '" + c + "'");
        }
    }

    public void stopDtmf() {
    }

    public void sendBurstDtmf(String dtmfString) {
        loge("sendBurstDtmf() is a CDMA method");
    }

    public void getOutgoingCallerIdDisplay(Message onComplete) {
        AsyncResult.forMessage(onComplete, null, null);
        onComplete.sendToTarget();
    }

    public void setOutgoingCallerIdDisplay(int commandInterfaceCLIRMode, Message onComplete) {
        AsyncResult.forMessage(onComplete, null, null);
        onComplete.sendToTarget();
    }

    public void getCallWaiting(Message onComplete) {
        AsyncResult.forMessage(onComplete, null, null);
        onComplete.sendToTarget();
    }

    public void setCallWaiting(boolean enable, Message onComplete) {
        loge("call waiting not supported");
    }

    public void setEchoSuppressionEnabled() {
        synchronized (SipPhone.class) {
            if (((AudioManager) this.mContext.getSystemService("audio")).getParameters("ec_supported").contains("off")) {
                this.mForegroundCall.setAudioGroupMode();
            }
        }
    }

    public void setMute(boolean muted) {
        synchronized (SipPhone.class) {
            this.mForegroundCall.setMute(muted);
        }
    }

    public boolean getMute() {
        return this.mForegroundCall.getState().isAlive() ? this.mForegroundCall.getMute() : this.mBackgroundCall.getMute();
    }

    public Call getForegroundCall() {
        return this.mForegroundCall;
    }

    public Call getBackgroundCall() {
        return this.mBackgroundCall;
    }

    public Call getRingingCall() {
        return this.mRingingCall;
    }

    public ServiceState getServiceState() {
        return super.getServiceState();
    }

    private String getUriString(SipProfile p) {
        return p.getUserName() + "@" + getSipDomain(p);
    }

    private String getSipDomain(SipProfile p) {
        String domain = p.getSipDomain();
        if (domain.endsWith(":5060")) {
            return domain.substring(0, domain.length() - 5);
        }
        return domain;
    }

    private static State getCallStateFrom(SipAudioCall sipAudioCall) {
        if (sipAudioCall.isOnHold()) {
            return State.HOLDING;
        }
        int sessionState = sipAudioCall.getState();
        switch (sessionState) {
            case CharacterSets.ANY_CHARSET /*0*/:
                return State.IDLE;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
                return State.INCOMING;
            case CharacterSets.ISO_8859_2 /*5*/:
                return State.DIALING;
            case CharacterSets.ISO_8859_3 /*6*/:
                return State.ALERTING;
            case CharacterSets.ISO_8859_4 /*7*/:
                return State.DISCONNECTING;
            case TIMEOUT_ANSWER_CALL /*8*/:
                return State.ACTIVE;
            default:
                slog("illegal connection state: " + sessionState);
                return State.DISCONNECTED;
        }
    }

    private void log(String s) {
        Rlog.d(LOG_TAG, s);
    }

    private static void slog(String s) {
        Rlog.d(LOG_TAG, s);
    }

    private void loge(String s) {
        Rlog.e(LOG_TAG, s);
    }

    private void loge(String s, Exception e) {
        Rlog.e(LOG_TAG, s, e);
    }
}
