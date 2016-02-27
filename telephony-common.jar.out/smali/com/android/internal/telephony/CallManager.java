package com.android.internal.telephony;

import android.content.Context;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.telephony.TelephonyManager;
import com.android.internal.telephony.PhoneConstants.State;
import com.android.internal.telephony.imsphone.ImsPhone;
import com.android.internal.telephony.sip.SipPhone;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

public final class CallManager {
    private static final boolean DBG = true;
    private static final int EVENT_CALL_WAITING = 108;
    private static final int EVENT_CDMA_OTA_STATUS_CHANGE = 111;
    private static final int EVENT_DISCONNECT = 100;
    private static final int EVENT_DISPLAY_INFO = 109;
    private static final int EVENT_ECM_TIMER_RESET = 115;
    private static final int EVENT_INCOMING_RING = 104;
    private static final int EVENT_IN_CALL_VOICE_PRIVACY_OFF = 107;
    private static final int EVENT_IN_CALL_VOICE_PRIVACY_ON = 106;
    private static final int EVENT_MMI_COMPLETE = 114;
    private static final int EVENT_MMI_INITIATE = 113;
    private static final int EVENT_NEW_RINGING_CONNECTION = 102;
    private static final int EVENT_ONHOLD_TONE = 120;
    private static final int EVENT_POST_DIAL_CHARACTER = 119;
    private static final int EVENT_PRECISE_CALL_STATE_CHANGED = 101;
    private static final int EVENT_RESEND_INCALL_MUTE = 112;
    private static final int EVENT_RINGBACK_TONE = 105;
    private static final int EVENT_SERVICE_STATE_CHANGED = 118;
    private static final int EVENT_SIGNAL_INFO = 110;
    private static final int EVENT_SUBSCRIPTION_INFO_READY = 116;
    private static final int EVENT_SUPP_SERVICE_FAILED = 117;
    private static final int EVENT_TTY_MODE_RECEIVED = 122;
    private static final int EVENT_UNKNOWN_CONNECTION = 103;
    private static final CallManager INSTANCE;
    private static final String LOG_TAG = "CallManager";
    private static final boolean VDBG = false;
    private final ArrayList<Call> mBackgroundCalls;
    protected final RegistrantList mCallWaitingRegistrants;
    protected final RegistrantList mCdmaOtaStatusChangeRegistrants;
    private Phone mDefaultPhone;
    protected final RegistrantList mDisconnectRegistrants;
    protected final RegistrantList mDisplayInfoRegistrants;
    protected final RegistrantList mEcmTimerResetRegistrants;
    private final ArrayList<Connection> mEmptyConnections;
    private final ArrayList<Call> mForegroundCalls;
    private final HashMap<Phone, CallManagerHandler> mHandlerMap;
    protected final RegistrantList mInCallVoicePrivacyOffRegistrants;
    protected final RegistrantList mInCallVoicePrivacyOnRegistrants;
    protected final RegistrantList mIncomingRingRegistrants;
    protected final RegistrantList mMmiCompleteRegistrants;
    protected final RegistrantList mMmiInitiateRegistrants;
    protected final RegistrantList mMmiRegistrants;
    protected final RegistrantList mNewRingingConnectionRegistrants;
    protected final RegistrantList mOnHoldToneRegistrants;
    private final ArrayList<Phone> mPhones;
    protected final RegistrantList mPostDialCharacterRegistrants;
    protected final RegistrantList mPreciseCallStateRegistrants;
    protected final RegistrantList mResendIncallMuteRegistrants;
    protected final RegistrantList mRingbackToneRegistrants;
    private final ArrayList<Call> mRingingCalls;
    protected final RegistrantList mServiceStateChangedRegistrants;
    protected final RegistrantList mSignalInfoRegistrants;
    private boolean mSpeedUpAudioForMtCall;
    protected final RegistrantList mSubscriptionInfoReadyRegistrants;
    protected final RegistrantList mSuppServiceFailedRegistrants;
    protected final RegistrantList mTtyModeReceivedRegistrants;
    protected final RegistrantList mUnknownConnectionRegistrants;

    private class CallManagerHandler extends Handler {
        private CallManagerHandler() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case CallManager.EVENT_DISCONNECT /*100*/:
                    CallManager.this.mDisconnectRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_PRECISE_CALL_STATE_CHANGED /*101*/:
                    CallManager.this.mPreciseCallStateRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_NEW_RINGING_CONNECTION /*102*/:
                    Connection c = ((AsyncResult) msg.obj).result;
                    if (CallManager.this.getActiveFgCallState(c.getCall().getPhone().getSubId()).isDialing() || CallManager.this.hasMoreThanOneRingingCall()) {
                        try {
                            Rlog.d(CallManager.LOG_TAG, "silently drop incoming call: " + c.getCall());
                            c.getCall().hangup();
                            return;
                        } catch (CallStateException e) {
                            Rlog.w(CallManager.LOG_TAG, "new ringing connection", e);
                            return;
                        }
                    }
                    CallManager.this.mNewRingingConnectionRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_UNKNOWN_CONNECTION /*103*/:
                    CallManager.this.mUnknownConnectionRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_INCOMING_RING /*104*/:
                    if (!CallManager.this.hasActiveFgCall()) {
                        CallManager.this.mIncomingRingRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                    }
                case CallManager.EVENT_RINGBACK_TONE /*105*/:
                    CallManager.this.mRingbackToneRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_IN_CALL_VOICE_PRIVACY_ON /*106*/:
                    CallManager.this.mInCallVoicePrivacyOnRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_IN_CALL_VOICE_PRIVACY_OFF /*107*/:
                    CallManager.this.mInCallVoicePrivacyOffRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_CALL_WAITING /*108*/:
                    CallManager.this.mCallWaitingRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_DISPLAY_INFO /*109*/:
                    CallManager.this.mDisplayInfoRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_SIGNAL_INFO /*110*/:
                    CallManager.this.mSignalInfoRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_CDMA_OTA_STATUS_CHANGE /*111*/:
                    CallManager.this.mCdmaOtaStatusChangeRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_RESEND_INCALL_MUTE /*112*/:
                    CallManager.this.mResendIncallMuteRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_MMI_INITIATE /*113*/:
                    CallManager.this.mMmiInitiateRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_MMI_COMPLETE /*114*/:
                    CallManager.this.mMmiCompleteRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_ECM_TIMER_RESET /*115*/:
                    CallManager.this.mEcmTimerResetRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_SUBSCRIPTION_INFO_READY /*116*/:
                    CallManager.this.mSubscriptionInfoReadyRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_SUPP_SERVICE_FAILED /*117*/:
                    CallManager.this.mSuppServiceFailedRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_SERVICE_STATE_CHANGED /*118*/:
                    CallManager.this.mServiceStateChangedRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_POST_DIAL_CHARACTER /*119*/:
                    for (int i = 0; i < CallManager.this.mPostDialCharacterRegistrants.size(); i++) {
                        Message notifyMsg = ((Registrant) CallManager.this.mPostDialCharacterRegistrants.get(i)).messageForRegistrant();
                        notifyMsg.obj = msg.obj;
                        notifyMsg.arg1 = msg.arg1;
                        notifyMsg.sendToTarget();
                    }
                case CallManager.EVENT_ONHOLD_TONE /*120*/:
                    CallManager.this.mOnHoldToneRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                case CallManager.EVENT_TTY_MODE_RECEIVED /*122*/:
                    CallManager.this.mTtyModeReceivedRegistrants.notifyRegistrants((AsyncResult) msg.obj);
                default:
            }
        }
    }

    static {
        INSTANCE = new CallManager();
    }

    private CallManager() {
        this.mEmptyConnections = new ArrayList();
        this.mHandlerMap = new HashMap();
        this.mSpeedUpAudioForMtCall = false;
        this.mPreciseCallStateRegistrants = new RegistrantList();
        this.mNewRingingConnectionRegistrants = new RegistrantList();
        this.mIncomingRingRegistrants = new RegistrantList();
        this.mDisconnectRegistrants = new RegistrantList();
        this.mMmiRegistrants = new RegistrantList();
        this.mUnknownConnectionRegistrants = new RegistrantList();
        this.mRingbackToneRegistrants = new RegistrantList();
        this.mOnHoldToneRegistrants = new RegistrantList();
        this.mInCallVoicePrivacyOnRegistrants = new RegistrantList();
        this.mInCallVoicePrivacyOffRegistrants = new RegistrantList();
        this.mCallWaitingRegistrants = new RegistrantList();
        this.mDisplayInfoRegistrants = new RegistrantList();
        this.mSignalInfoRegistrants = new RegistrantList();
        this.mCdmaOtaStatusChangeRegistrants = new RegistrantList();
        this.mResendIncallMuteRegistrants = new RegistrantList();
        this.mMmiInitiateRegistrants = new RegistrantList();
        this.mMmiCompleteRegistrants = new RegistrantList();
        this.mEcmTimerResetRegistrants = new RegistrantList();
        this.mSubscriptionInfoReadyRegistrants = new RegistrantList();
        this.mSuppServiceFailedRegistrants = new RegistrantList();
        this.mServiceStateChangedRegistrants = new RegistrantList();
        this.mPostDialCharacterRegistrants = new RegistrantList();
        this.mTtyModeReceivedRegistrants = new RegistrantList();
        this.mPhones = new ArrayList();
        this.mRingingCalls = new ArrayList();
        this.mBackgroundCalls = new ArrayList();
        this.mForegroundCalls = new ArrayList();
        this.mDefaultPhone = null;
    }

    public static CallManager getInstance() {
        return INSTANCE;
    }

    private static Phone getPhoneBase(Phone phone) {
        if (phone instanceof PhoneProxy) {
            return phone.getForegroundCall().getPhone();
        }
        return phone;
    }

    public static boolean isSamePhone(Phone p1, Phone p2) {
        return getPhoneBase(p1) == getPhoneBase(p2) ? DBG : false;
    }

    public List<Phone> getAllPhones() {
        return Collections.unmodifiableList(this.mPhones);
    }

    private Phone getPhone(int subId) {
        Iterator i$ = this.mPhones.iterator();
        while (i$.hasNext()) {
            Phone phone = (Phone) i$.next();
            if (phone.getSubId() == subId && !(phone instanceof ImsPhone)) {
                return phone;
            }
        }
        return null;
    }

    public State getState() {
        State s = State.IDLE;
        Iterator i$ = this.mPhones.iterator();
        while (i$.hasNext()) {
            Phone phone = (Phone) i$.next();
            if (phone.getState() == State.RINGING) {
                s = State.RINGING;
            } else if (phone.getState() == State.OFFHOOK && s == State.IDLE) {
                s = State.OFFHOOK;
            }
        }
        return s;
    }

    public State getState(int subId) {
        State s = State.IDLE;
        Iterator i$ = this.mPhones.iterator();
        while (i$.hasNext()) {
            Phone phone = (Phone) i$.next();
            if (phone.getSubId() == subId) {
                if (phone.getState() == State.RINGING) {
                    s = State.RINGING;
                } else if (phone.getState() == State.OFFHOOK && s == State.IDLE) {
                    s = State.OFFHOOK;
                }
            }
        }
        return s;
    }

    public int getServiceState() {
        int resultState = 1;
        Iterator i$ = this.mPhones.iterator();
        while (i$.hasNext()) {
            int serviceState = ((Phone) i$.next()).getServiceState().getState();
            if (serviceState == 0) {
                return serviceState;
            }
            if (serviceState == 1) {
                if (resultState == 2 || resultState == 3) {
                    resultState = serviceState;
                }
            } else if (serviceState == 2 && resultState == 3) {
                resultState = serviceState;
            }
        }
        return resultState;
    }

    public int getServiceState(int subId) {
        int resultState = 1;
        Iterator i$ = this.mPhones.iterator();
        while (i$.hasNext()) {
            Phone phone = (Phone) i$.next();
            if (phone.getSubId() == subId) {
                int serviceState = phone.getServiceState().getState();
                if (serviceState == 0) {
                    return serviceState;
                }
                if (serviceState == 1) {
                    if (resultState == 2 || resultState == 3) {
                        resultState = serviceState;
                    }
                } else if (serviceState == 2 && resultState == 3) {
                    resultState = serviceState;
                }
            }
        }
        return resultState;
    }

    public Phone getPhoneInCall() {
        if (!getFirstActiveRingingCall().isIdle()) {
            return getFirstActiveRingingCall().getPhone();
        }
        if (getActiveFgCall().isIdle()) {
            return getFirstActiveBgCall().getPhone();
        }
        return getActiveFgCall().getPhone();
    }

    public Phone getPhoneInCall(int subId) {
        if (!getFirstActiveRingingCall(subId).isIdle()) {
            return getFirstActiveRingingCall(subId).getPhone();
        }
        if (getActiveFgCall(subId).isIdle()) {
            return getFirstActiveBgCall(subId).getPhone();
        }
        return getActiveFgCall(subId).getPhone();
    }

    public boolean registerPhone(Phone phone) {
        Phone basePhone = getPhoneBase(phone);
        if (basePhone == null || this.mPhones.contains(basePhone)) {
            return false;
        }
        Rlog.d(LOG_TAG, "registerPhone(" + phone.getPhoneName() + " " + phone + ")");
        if (this.mPhones.isEmpty()) {
            this.mDefaultPhone = basePhone;
        }
        this.mPhones.add(basePhone);
        this.mRingingCalls.add(basePhone.getRingingCall());
        this.mBackgroundCalls.add(basePhone.getBackgroundCall());
        this.mForegroundCalls.add(basePhone.getForegroundCall());
        registerForPhoneStates(basePhone);
        return DBG;
    }

    public void unregisterPhone(Phone phone) {
        Phone basePhone = getPhoneBase(phone);
        if (basePhone != null && this.mPhones.contains(basePhone)) {
            Rlog.d(LOG_TAG, "unregisterPhone(" + phone.getPhoneName() + " " + phone + ")");
            this.mPhones.remove(basePhone);
            this.mRingingCalls.remove(basePhone.getRingingCall());
            this.mBackgroundCalls.remove(basePhone.getBackgroundCall());
            this.mForegroundCalls.remove(basePhone.getForegroundCall());
            unregisterForPhoneStates(basePhone);
            if (basePhone != this.mDefaultPhone) {
                return;
            }
            if (this.mPhones.isEmpty()) {
                this.mDefaultPhone = null;
            } else {
                this.mDefaultPhone = (Phone) this.mPhones.get(0);
            }
        }
    }

    public Phone getDefaultPhone() {
        return this.mDefaultPhone;
    }

    public Phone getFgPhone() {
        return getActiveFgCall().getPhone();
    }

    public Phone getFgPhone(int subId) {
        return getActiveFgCall(subId).getPhone();
    }

    public Phone getBgPhone() {
        return getFirstActiveBgCall().getPhone();
    }

    public Phone getBgPhone(int subId) {
        return getFirstActiveBgCall(subId).getPhone();
    }

    public Phone getRingingPhone() {
        return getFirstActiveRingingCall().getPhone();
    }

    public Phone getRingingPhone(int subId) {
        return getFirstActiveRingingCall(subId).getPhone();
    }

    private Context getContext() {
        Phone defaultPhone = getDefaultPhone();
        return defaultPhone == null ? null : defaultPhone.getContext();
    }

    private void registerForPhoneStates(Phone phone) {
        if (((CallManagerHandler) this.mHandlerMap.get(phone)) != null) {
            Rlog.d(LOG_TAG, "This phone has already been registered.");
            return;
        }
        CallManagerHandler handler = new CallManagerHandler();
        this.mHandlerMap.put(phone, handler);
        phone.registerForPreciseCallStateChanged(handler, EVENT_PRECISE_CALL_STATE_CHANGED, null);
        phone.registerForDisconnect(handler, EVENT_DISCONNECT, null);
        phone.registerForNewRingingConnection(handler, EVENT_NEW_RINGING_CONNECTION, null);
        phone.registerForUnknownConnection(handler, EVENT_UNKNOWN_CONNECTION, null);
        phone.registerForIncomingRing(handler, EVENT_INCOMING_RING, null);
        phone.registerForRingbackTone(handler, EVENT_RINGBACK_TONE, null);
        phone.registerForInCallVoicePrivacyOn(handler, EVENT_IN_CALL_VOICE_PRIVACY_ON, null);
        phone.registerForInCallVoicePrivacyOff(handler, EVENT_IN_CALL_VOICE_PRIVACY_OFF, null);
        phone.registerForDisplayInfo(handler, EVENT_DISPLAY_INFO, null);
        phone.registerForSignalInfo(handler, EVENT_SIGNAL_INFO, null);
        phone.registerForResendIncallMute(handler, EVENT_RESEND_INCALL_MUTE, null);
        phone.registerForMmiInitiate(handler, EVENT_MMI_INITIATE, null);
        phone.registerForMmiComplete(handler, EVENT_MMI_COMPLETE, null);
        phone.registerForSuppServiceFailed(handler, EVENT_SUPP_SERVICE_FAILED, null);
        phone.registerForServiceStateChanged(handler, EVENT_SERVICE_STATE_CHANGED, null);
        if (phone.getPhoneType() == 1 || phone.getPhoneType() == 2 || phone.getPhoneType() == 5) {
            phone.setOnPostDialCharacter(handler, EVENT_POST_DIAL_CHARACTER, null);
        }
        if (phone.getPhoneType() == 2) {
            phone.registerForCdmaOtaStatusChange(handler, EVENT_CDMA_OTA_STATUS_CHANGE, null);
            phone.registerForSubscriptionInfoReady(handler, EVENT_SUBSCRIPTION_INFO_READY, null);
            phone.registerForCallWaiting(handler, EVENT_CALL_WAITING, null);
            phone.registerForEcmTimerReset(handler, EVENT_ECM_TIMER_RESET, null);
        }
        if (phone.getPhoneType() == 5) {
            phone.registerForOnHoldTone(handler, EVENT_ONHOLD_TONE, null);
            phone.registerForSuppServiceFailed(handler, EVENT_SUPP_SERVICE_FAILED, null);
            phone.registerForTtyModeReceived(handler, EVENT_TTY_MODE_RECEIVED, null);
        }
    }

    private void unregisterForPhoneStates(Phone phone) {
        CallManagerHandler handler = (CallManagerHandler) this.mHandlerMap.get(phone);
        if (handler != null) {
            Rlog.e(LOG_TAG, "Could not find Phone handler for unregistration");
            return;
        }
        this.mHandlerMap.remove(phone);
        phone.unregisterForPreciseCallStateChanged(handler);
        phone.unregisterForDisconnect(handler);
        phone.unregisterForNewRingingConnection(handler);
        phone.unregisterForUnknownConnection(handler);
        phone.unregisterForIncomingRing(handler);
        phone.unregisterForRingbackTone(handler);
        phone.unregisterForInCallVoicePrivacyOn(handler);
        phone.unregisterForInCallVoicePrivacyOff(handler);
        phone.unregisterForDisplayInfo(handler);
        phone.unregisterForSignalInfo(handler);
        phone.unregisterForResendIncallMute(handler);
        phone.unregisterForMmiInitiate(handler);
        phone.unregisterForMmiComplete(handler);
        phone.unregisterForSuppServiceFailed(handler);
        phone.unregisterForServiceStateChanged(handler);
        phone.unregisterForTtyModeReceived(handler);
        if (phone.getPhoneType() == 1 || phone.getPhoneType() == 2 || phone.getPhoneType() == 5) {
            phone.setOnPostDialCharacter(null, EVENT_POST_DIAL_CHARACTER, null);
        }
        if (phone.getPhoneType() == 2) {
            phone.unregisterForCdmaOtaStatusChange(handler);
            phone.unregisterForSubscriptionInfoReady(handler);
            phone.unregisterForCallWaiting(handler);
            phone.unregisterForEcmTimerReset(handler);
        }
        if (phone.getPhoneType() == 5) {
            phone.unregisterForOnHoldTone(handler);
            phone.unregisterForSuppServiceFailed(handler);
        }
    }

    public void acceptCall(Call ringingCall) throws CallStateException {
        boolean sameChannel = DBG;
        Phone ringingPhone = ringingCall.getPhone();
        if (hasActiveFgCall()) {
            Phone activePhone = getActiveFgCall().getPhone();
            boolean hasBgCall;
            if (activePhone.getBackgroundCall().isIdle()) {
                hasBgCall = false;
            } else {
                hasBgCall = DBG;
            }
            if (activePhone != ringingPhone) {
                sameChannel = false;
            }
            if (sameChannel && hasBgCall) {
                getActiveFgCall().hangup();
            } else if (!sameChannel && !hasBgCall) {
                activePhone.switchHoldingAndActive();
            } else if (!sameChannel && hasBgCall) {
                getActiveFgCall().hangup();
            }
        }
        ringingPhone.acceptCall(0);
    }

    public void rejectCall(Call ringingCall) throws CallStateException {
        ringingCall.getPhone().rejectCall();
    }

    public void switchHoldingAndActive(Call heldCall) throws CallStateException {
        Phone activePhone = null;
        Phone heldPhone = null;
        if (hasActiveFgCall()) {
            activePhone = getActiveFgCall().getPhone();
        }
        if (heldCall != null) {
            heldPhone = heldCall.getPhone();
        }
        if (activePhone != null) {
            activePhone.switchHoldingAndActive();
        }
        if (heldPhone != null && heldPhone != activePhone) {
            heldPhone.switchHoldingAndActive();
        }
    }

    public void hangupForegroundResumeBackground(Call heldCall) throws CallStateException {
        if (hasActiveFgCall()) {
            Phone foregroundPhone = getFgPhone();
            if (heldCall == null) {
                return;
            }
            if (foregroundPhone == heldCall.getPhone()) {
                getActiveFgCall().hangup();
                return;
            }
            getActiveFgCall().hangup();
            switchHoldingAndActive(heldCall);
        }
    }

    public boolean canConference(Call heldCall) {
        Phone activePhone = null;
        Phone heldPhone = null;
        if (hasActiveFgCall()) {
            activePhone = getActiveFgCall().getPhone();
        }
        if (heldCall != null) {
            heldPhone = heldCall.getPhone();
        }
        return heldPhone.getClass().equals(activePhone.getClass());
    }

    public boolean canConference(Call heldCall, int subId) {
        Phone activePhone = null;
        Phone heldPhone = null;
        if (hasActiveFgCall(subId)) {
            activePhone = getActiveFgCall(subId).getPhone();
        }
        if (heldCall != null) {
            heldPhone = heldCall.getPhone();
        }
        return heldPhone.getClass().equals(activePhone.getClass());
    }

    public void conference(Call heldCall) throws CallStateException {
        Phone fgPhone = getFgPhone(heldCall.getPhone().getSubId());
        if (fgPhone == null) {
            Rlog.d(LOG_TAG, "conference: fgPhone=null");
        } else if (fgPhone instanceof SipPhone) {
            ((SipPhone) fgPhone).conference(heldCall);
        } else if (canConference(heldCall)) {
            fgPhone.conference();
        } else {
            throw new CallStateException("Can't conference foreground and selected background call");
        }
    }

    public Connection dial(Phone phone, String dialString, int videoState) throws CallStateException {
        boolean z = DBG;
        Phone basePhone = getPhoneBase(phone);
        int subId = phone.getSubId();
        if (canDial(phone)) {
            if (hasActiveFgCall(subId)) {
                boolean hasBgCall;
                Phone activePhone = getActiveFgCall(subId).getPhone();
                if (activePhone.getBackgroundCall().isIdle()) {
                    hasBgCall = false;
                } else {
                    hasBgCall = DBG;
                }
                String str = LOG_TAG;
                StringBuilder append = new StringBuilder().append("hasBgCall: ").append(hasBgCall).append(" sameChannel:");
                if (activePhone != basePhone) {
                    z = false;
                }
                Rlog.d(str, append.append(z).toString());
                Phone vPhone = basePhone.getImsPhone();
                if (activePhone != basePhone && (vPhone == null || vPhone != activePhone)) {
                    if (hasBgCall) {
                        Rlog.d(LOG_TAG, "Hangup");
                        getActiveFgCall(subId).hangup();
                    } else {
                        Rlog.d(LOG_TAG, "Switch");
                        activePhone.switchHoldingAndActive();
                    }
                }
            }
            return basePhone.dial(dialString, videoState);
        } else if (basePhone.handleInCallMmiCommands(PhoneNumberUtils.stripSeparators(dialString))) {
            return null;
        } else {
            throw new CallStateException("cannot dial in current state");
        }
    }

    public Connection dial(Phone phone, String dialString, UUSInfo uusInfo, int videoState) throws CallStateException {
        return phone.dial(dialString, uusInfo, videoState);
    }

    public void clearDisconnected() {
        Iterator i$ = this.mPhones.iterator();
        while (i$.hasNext()) {
            ((Phone) i$.next()).clearDisconnected();
        }
    }

    public void clearDisconnected(int subId) {
        Iterator i$ = this.mPhones.iterator();
        while (i$.hasNext()) {
            Phone phone = (Phone) i$.next();
            if (phone.getSubId() == subId) {
                phone.clearDisconnected();
            }
        }
    }

    private boolean canDial(Phone phone) {
        int serviceState = phone.getServiceState().getState();
        int subId = phone.getSubId();
        boolean hasRingingCall = hasActiveRingingCall();
        Call.State fgCallState = getActiveFgCallState(subId);
        boolean result = (serviceState == 3 || hasRingingCall || !(fgCallState == Call.State.ACTIVE || fgCallState == Call.State.IDLE || fgCallState == Call.State.DISCONNECTED || fgCallState == Call.State.ALERTING)) ? false : DBG;
        if (!result) {
            Rlog.d(LOG_TAG, "canDial serviceState=" + serviceState + " hasRingingCall=" + hasRingingCall + " fgCallState=" + fgCallState);
        }
        return result;
    }

    public boolean canTransfer(Call heldCall) {
        Phone activePhone = null;
        Phone heldPhone = null;
        if (hasActiveFgCall()) {
            activePhone = getActiveFgCall().getPhone();
        }
        if (heldCall != null) {
            heldPhone = heldCall.getPhone();
        }
        return (heldPhone == activePhone && activePhone.canTransfer()) ? DBG : false;
    }

    public boolean canTransfer(Call heldCall, int subId) {
        Phone activePhone = null;
        Phone heldPhone = null;
        if (hasActiveFgCall(subId)) {
            activePhone = getActiveFgCall(subId).getPhone();
        }
        if (heldCall != null) {
            heldPhone = heldCall.getPhone();
        }
        return (heldPhone == activePhone && activePhone.canTransfer()) ? DBG : false;
    }

    public void explicitCallTransfer(Call heldCall) throws CallStateException {
        if (canTransfer(heldCall)) {
            heldCall.getPhone().explicitCallTransfer();
        }
    }

    public List<? extends MmiCode> getPendingMmiCodes(Phone phone) {
        Rlog.e(LOG_TAG, "getPendingMmiCodes not implemented");
        return null;
    }

    public boolean sendUssdResponse(Phone phone, String ussdMessge) {
        Rlog.e(LOG_TAG, "sendUssdResponse not implemented");
        return false;
    }

    public void setMute(boolean muted) {
        if (hasActiveFgCall()) {
            getActiveFgCall().getPhone().setMute(muted);
        }
    }

    public boolean getMute() {
        if (hasActiveFgCall()) {
            return getActiveFgCall().getPhone().getMute();
        }
        if (hasActiveBgCall()) {
            return getFirstActiveBgCall().getPhone().getMute();
        }
        return false;
    }

    public void setEchoSuppressionEnabled() {
        if (hasActiveFgCall()) {
            getActiveFgCall().getPhone().setEchoSuppressionEnabled();
        }
    }

    public boolean sendDtmf(char c) {
        if (!hasActiveFgCall()) {
            return false;
        }
        getActiveFgCall().getPhone().sendDtmf(c);
        return DBG;
    }

    public boolean startDtmf(char c) {
        if (!hasActiveFgCall()) {
            return false;
        }
        getActiveFgCall().getPhone().startDtmf(c);
        return DBG;
    }

    public void stopDtmf() {
        if (hasActiveFgCall()) {
            getFgPhone().stopDtmf();
        }
    }

    public boolean sendBurstDtmf(String dtmfString, int on, int off, Message onComplete) {
        if (!hasActiveFgCall()) {
            return false;
        }
        getActiveFgCall().getPhone().sendBurstDtmf(dtmfString, on, off, onComplete);
        return DBG;
    }

    public void registerForDisconnect(Handler h, int what, Object obj) {
        this.mDisconnectRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForDisconnect(Handler h) {
        this.mDisconnectRegistrants.remove(h);
    }

    public void registerForPreciseCallStateChanged(Handler h, int what, Object obj) {
        this.mPreciseCallStateRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForPreciseCallStateChanged(Handler h) {
        this.mPreciseCallStateRegistrants.remove(h);
    }

    public void registerForUnknownConnection(Handler h, int what, Object obj) {
        this.mUnknownConnectionRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForUnknownConnection(Handler h) {
        this.mUnknownConnectionRegistrants.remove(h);
    }

    public void registerForNewRingingConnection(Handler h, int what, Object obj) {
        this.mNewRingingConnectionRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForNewRingingConnection(Handler h) {
        this.mNewRingingConnectionRegistrants.remove(h);
    }

    public void registerForIncomingRing(Handler h, int what, Object obj) {
        this.mIncomingRingRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForIncomingRing(Handler h) {
        this.mIncomingRingRegistrants.remove(h);
    }

    public void registerForRingbackTone(Handler h, int what, Object obj) {
        this.mRingbackToneRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForRingbackTone(Handler h) {
        this.mRingbackToneRegistrants.remove(h);
    }

    public void registerForOnHoldTone(Handler h, int what, Object obj) {
        this.mOnHoldToneRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForOnHoldTone(Handler h) {
        this.mOnHoldToneRegistrants.remove(h);
    }

    public void registerForResendIncallMute(Handler h, int what, Object obj) {
        this.mResendIncallMuteRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForResendIncallMute(Handler h) {
        this.mResendIncallMuteRegistrants.remove(h);
    }

    public void registerForMmiInitiate(Handler h, int what, Object obj) {
        this.mMmiInitiateRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForMmiInitiate(Handler h) {
        this.mMmiInitiateRegistrants.remove(h);
    }

    public void registerForMmiComplete(Handler h, int what, Object obj) {
        this.mMmiCompleteRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForMmiComplete(Handler h) {
        this.mMmiCompleteRegistrants.remove(h);
    }

    public void registerForEcmTimerReset(Handler h, int what, Object obj) {
        this.mEcmTimerResetRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForEcmTimerReset(Handler h) {
        this.mEcmTimerResetRegistrants.remove(h);
    }

    public void registerForServiceStateChanged(Handler h, int what, Object obj) {
        this.mServiceStateChangedRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForServiceStateChanged(Handler h) {
        this.mServiceStateChangedRegistrants.remove(h);
    }

    public void registerForSuppServiceFailed(Handler h, int what, Object obj) {
        this.mSuppServiceFailedRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForSuppServiceFailed(Handler h) {
        this.mSuppServiceFailedRegistrants.remove(h);
    }

    public void registerForInCallVoicePrivacyOn(Handler h, int what, Object obj) {
        this.mInCallVoicePrivacyOnRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForInCallVoicePrivacyOn(Handler h) {
        this.mInCallVoicePrivacyOnRegistrants.remove(h);
    }

    public void registerForInCallVoicePrivacyOff(Handler h, int what, Object obj) {
        this.mInCallVoicePrivacyOffRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForInCallVoicePrivacyOff(Handler h) {
        this.mInCallVoicePrivacyOffRegistrants.remove(h);
    }

    public void registerForCallWaiting(Handler h, int what, Object obj) {
        this.mCallWaitingRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForCallWaiting(Handler h) {
        this.mCallWaitingRegistrants.remove(h);
    }

    public void registerForSignalInfo(Handler h, int what, Object obj) {
        this.mSignalInfoRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForSignalInfo(Handler h) {
        this.mSignalInfoRegistrants.remove(h);
    }

    public void registerForDisplayInfo(Handler h, int what, Object obj) {
        this.mDisplayInfoRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForDisplayInfo(Handler h) {
        this.mDisplayInfoRegistrants.remove(h);
    }

    public void registerForCdmaOtaStatusChange(Handler h, int what, Object obj) {
        this.mCdmaOtaStatusChangeRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForCdmaOtaStatusChange(Handler h) {
        this.mCdmaOtaStatusChangeRegistrants.remove(h);
    }

    public void registerForSubscriptionInfoReady(Handler h, int what, Object obj) {
        this.mSubscriptionInfoReadyRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForSubscriptionInfoReady(Handler h) {
        this.mSubscriptionInfoReadyRegistrants.remove(h);
    }

    public void registerForPostDialCharacter(Handler h, int what, Object obj) {
        this.mPostDialCharacterRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForPostDialCharacter(Handler h) {
        this.mPostDialCharacterRegistrants.remove(h);
    }

    public void registerForTtyModeReceived(Handler h, int what, Object obj) {
        this.mTtyModeReceivedRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForTtyModeReceived(Handler h) {
        this.mTtyModeReceivedRegistrants.remove(h);
    }

    public List<Call> getRingingCalls() {
        return Collections.unmodifiableList(this.mRingingCalls);
    }

    public List<Call> getForegroundCalls() {
        return Collections.unmodifiableList(this.mForegroundCalls);
    }

    public List<Call> getBackgroundCalls() {
        return Collections.unmodifiableList(this.mBackgroundCalls);
    }

    public boolean hasActiveFgCall() {
        return getFirstActiveCall(this.mForegroundCalls) != null ? DBG : false;
    }

    public boolean hasActiveFgCall(int subId) {
        return getFirstActiveCall(this.mForegroundCalls, subId) != null ? DBG : false;
    }

    public boolean hasActiveBgCall() {
        return getFirstActiveCall(this.mBackgroundCalls) != null ? DBG : false;
    }

    public boolean hasActiveBgCall(int subId) {
        return getFirstActiveCall(this.mBackgroundCalls, subId) != null ? DBG : false;
    }

    public boolean hasActiveRingingCall() {
        return getFirstActiveCall(this.mRingingCalls) != null ? DBG : false;
    }

    public boolean hasActiveRingingCall(int subId) {
        return getFirstActiveCall(this.mRingingCalls, subId) != null ? DBG : false;
    }

    public Call getActiveFgCall() {
        Call call = getFirstNonIdleCall(this.mForegroundCalls);
        if (call == null) {
            return this.mDefaultPhone == null ? null : this.mDefaultPhone.getForegroundCall();
        } else {
            return call;
        }
    }

    public Call getActiveFgCall(int subId) {
        Call call = getFirstNonIdleCall(this.mForegroundCalls, subId);
        if (call != null) {
            return call;
        }
        Phone phone = getPhone(subId);
        return phone == null ? null : phone.getForegroundCall();
    }

    private Call getFirstNonIdleCall(List<Call> calls) {
        Call result = null;
        for (Call call : calls) {
            if (!call.isIdle()) {
                return call;
            }
            if (call.getState() != Call.State.IDLE && result == null) {
                result = call;
            }
        }
        return result;
    }

    private Call getFirstNonIdleCall(List<Call> calls, int subId) {
        Call result = null;
        for (Call call : calls) {
            if (call.getPhone().getSubId() == subId || (call.getPhone() instanceof SipPhone)) {
                if (!call.isIdle()) {
                    return call;
                }
                if (call.getState() != Call.State.IDLE && result == null) {
                    result = call;
                }
            }
        }
        return result;
    }

    public Call getFirstActiveBgCall() {
        Call call = getFirstNonIdleCall(this.mBackgroundCalls);
        if (call == null) {
            return this.mDefaultPhone == null ? null : this.mDefaultPhone.getBackgroundCall();
        } else {
            return call;
        }
    }

    public Call getFirstActiveBgCall(int subId) {
        Phone phone = getPhone(subId);
        if (hasMoreThanOneHoldingCall(subId)) {
            return phone.getBackgroundCall();
        }
        Call call = getFirstNonIdleCall(this.mBackgroundCalls, subId);
        if (call != null) {
            return call;
        }
        return phone == null ? null : phone.getBackgroundCall();
    }

    public Call getFirstActiveRingingCall() {
        Call call = getFirstNonIdleCall(this.mRingingCalls);
        if (call == null) {
            return this.mDefaultPhone == null ? null : this.mDefaultPhone.getRingingCall();
        } else {
            return call;
        }
    }

    public Call getFirstActiveRingingCall(int subId) {
        Phone phone = getPhone(subId);
        Call call = getFirstNonIdleCall(this.mRingingCalls, subId);
        if (call == null) {
            return phone == null ? null : phone.getRingingCall();
        } else {
            return call;
        }
    }

    public Call.State getActiveFgCallState() {
        Call fgCall = getActiveFgCall();
        if (fgCall != null) {
            return fgCall.getState();
        }
        return Call.State.IDLE;
    }

    public Call.State getActiveFgCallState(int subId) {
        Call fgCall = getActiveFgCall(subId);
        if (fgCall != null) {
            return fgCall.getState();
        }
        return Call.State.IDLE;
    }

    public List<Connection> getFgCallConnections() {
        Call fgCall = getActiveFgCall();
        if (fgCall != null) {
            return fgCall.getConnections();
        }
        return this.mEmptyConnections;
    }

    public List<Connection> getFgCallConnections(int subId) {
        Call fgCall = getActiveFgCall(subId);
        if (fgCall != null) {
            return fgCall.getConnections();
        }
        return this.mEmptyConnections;
    }

    public List<Connection> getBgCallConnections() {
        Call bgCall = getFirstActiveBgCall();
        if (bgCall != null) {
            return bgCall.getConnections();
        }
        return this.mEmptyConnections;
    }

    public List<Connection> getBgCallConnections(int subId) {
        Call bgCall = getFirstActiveBgCall(subId);
        if (bgCall != null) {
            return bgCall.getConnections();
        }
        return this.mEmptyConnections;
    }

    public Connection getFgCallLatestConnection() {
        Call fgCall = getActiveFgCall();
        if (fgCall != null) {
            return fgCall.getLatestConnection();
        }
        return null;
    }

    public Connection getFgCallLatestConnection(int subId) {
        Call fgCall = getActiveFgCall(subId);
        if (fgCall != null) {
            return fgCall.getLatestConnection();
        }
        return null;
    }

    public boolean hasDisconnectedFgCall() {
        return getFirstCallOfState(this.mForegroundCalls, Call.State.DISCONNECTED) != null ? DBG : false;
    }

    public boolean hasDisconnectedFgCall(int subId) {
        return getFirstCallOfState(this.mForegroundCalls, Call.State.DISCONNECTED, subId) != null ? DBG : false;
    }

    public boolean hasDisconnectedBgCall() {
        return getFirstCallOfState(this.mBackgroundCalls, Call.State.DISCONNECTED) != null ? DBG : false;
    }

    public boolean hasDisconnectedBgCall(int subId) {
        return getFirstCallOfState(this.mBackgroundCalls, Call.State.DISCONNECTED, subId) != null ? DBG : false;
    }

    private Call getFirstActiveCall(ArrayList<Call> calls) {
        Iterator i$ = calls.iterator();
        while (i$.hasNext()) {
            Call call = (Call) i$.next();
            if (!call.isIdle()) {
                return call;
            }
        }
        return null;
    }

    private Call getFirstActiveCall(ArrayList<Call> calls, int subId) {
        Iterator i$ = calls.iterator();
        while (i$.hasNext()) {
            Call call = (Call) i$.next();
            if (!call.isIdle() && (call.getPhone().getSubId() == subId || (call.getPhone() instanceof SipPhone))) {
                return call;
            }
        }
        return null;
    }

    private Call getFirstCallOfState(ArrayList<Call> calls, Call.State state) {
        Iterator i$ = calls.iterator();
        while (i$.hasNext()) {
            Call call = (Call) i$.next();
            if (call.getState() == state) {
                return call;
            }
        }
        return null;
    }

    private Call getFirstCallOfState(ArrayList<Call> calls, Call.State state, int subId) {
        Iterator i$ = calls.iterator();
        while (i$.hasNext()) {
            Call call = (Call) i$.next();
            if (call.getState() == state || call.getPhone().getSubId() == subId) {
                return call;
            }
            if (call.getPhone() instanceof SipPhone) {
                return call;
            }
        }
        return null;
    }

    private boolean hasMoreThanOneRingingCall() {
        int count = 0;
        Iterator i$ = this.mRingingCalls.iterator();
        while (i$.hasNext()) {
            if (((Call) i$.next()).getState().isRinging()) {
                count++;
                if (count > 1) {
                    return DBG;
                }
            }
        }
        return false;
    }

    private boolean hasMoreThanOneRingingCall(int subId) {
        int count = 0;
        Iterator i$ = this.mRingingCalls.iterator();
        while (i$.hasNext()) {
            Call call = (Call) i$.next();
            if (call.getState().isRinging() && (call.getPhone().getSubId() == subId || (call.getPhone() instanceof SipPhone))) {
                count++;
                if (count > 1) {
                    return DBG;
                }
            }
        }
        return false;
    }

    private boolean hasMoreThanOneHoldingCall(int subId) {
        int count = 0;
        Iterator i$ = this.mBackgroundCalls.iterator();
        while (i$.hasNext()) {
            Call call = (Call) i$.next();
            if (call.getState() == Call.State.HOLDING && (call.getPhone().getSubId() == subId || (call.getPhone() instanceof SipPhone))) {
                count++;
                if (count > 1) {
                    return DBG;
                }
            }
        }
        return false;
    }

    public String toString() {
        StringBuilder b = new StringBuilder();
        for (int i = 0; i < TelephonyManager.getDefault().getPhoneCount(); i++) {
            b.append("CallManager {");
            b.append("\nstate = " + getState(i));
            Call call = getActiveFgCall(i);
            if (call != null) {
                b.append("\n- Foreground: " + getActiveFgCallState(i));
                b.append(" from " + call.getPhone());
                b.append("\n  Conn: ").append(getFgCallConnections(i));
            }
            call = getFirstActiveBgCall(i);
            if (call != null) {
                b.append("\n- Background: " + call.getState());
                b.append(" from " + call.getPhone());
                b.append("\n  Conn: ").append(getBgCallConnections(i));
            }
            call = getFirstActiveRingingCall(i);
            if (call != null) {
                b.append("\n- Ringing: " + call.getState());
                b.append(" from " + call.getPhone());
            }
        }
        for (Phone phone : getAllPhones()) {
            if (phone != null) {
                b.append("\nPhone: " + phone + ", name = " + phone.getPhoneName() + ", state = " + phone.getState());
                call = phone.getForegroundCall();
                if (call != null) {
                    b.append("\n- Foreground: ").append(call);
                }
                call = phone.getBackgroundCall();
                if (call != null) {
                    b.append(" Background: ").append(call);
                }
                call = phone.getRingingCall();
                if (call != null) {
                    b.append(" Ringing: ").append(call);
                }
            }
        }
        b.append("\n}");
        return b.toString();
    }
}
