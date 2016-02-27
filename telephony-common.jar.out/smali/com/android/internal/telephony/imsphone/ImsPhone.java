package com.android.internal.telephony.imsphone;

import android.app.ActivityManagerNative;
import android.content.Context;
import android.content.Intent;
import android.net.LinkProperties;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.Registrant;
import android.os.RegistrantList;
import android.os.SystemProperties;
import android.telephony.CellLocation;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SignalStrength;
import android.telephony.SubscriptionManager;
import android.text.TextUtils;
import com.android.ims.ImsCallForwardInfo;
import com.android.ims.ImsEcbmStateListener;
import com.android.ims.ImsException;
import com.android.ims.ImsReasonInfo;
import com.android.ims.ImsSsInfo;
import com.android.internal.telephony.Call.SrvccState;
import com.android.internal.telephony.Call.State;
import com.android.internal.telephony.CallForwardInfo;
import com.android.internal.telephony.CallStateException;
import com.android.internal.telephony.CallTracker;
import com.android.internal.telephony.CommandException;
import com.android.internal.telephony.CommandException.Error;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.Connection;
import com.android.internal.telephony.IccCard;
import com.android.internal.telephony.IccPhoneBookInterfaceManager;
import com.android.internal.telephony.OperatorInfo;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.Phone.DataActivityState;
import com.android.internal.telephony.Phone.SuppService;
import com.android.internal.telephony.PhoneBase;
import com.android.internal.telephony.PhoneConstants;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.android.internal.telephony.PhoneNotifier;
import com.android.internal.telephony.PhoneSubInfo;
import com.android.internal.telephony.RadioNVItems;
import com.android.internal.telephony.UUSInfo;
import com.android.internal.telephony.cdma.CDMAPhone;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.gsm.GSMPhone;
import com.android.internal.telephony.uicc.IccFileHandler;
import com.android.internal.telephony.uicc.IccRecords;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduPersister;
import java.util.ArrayList;
import java.util.List;

public class ImsPhone extends ImsPhoneBase {
    static final int CANCEL_ECM_TIMER = 1;
    public static final String CS_FALLBACK = "cs_fallback";
    private static final boolean DBG = true;
    private static final int DEFAULT_ECM_EXIT_TIMER_VALUE = 300000;
    protected static final int EVENT_GET_CALL_BARRING_DONE = 38;
    protected static final int EVENT_GET_CALL_WAITING_DONE = 40;
    protected static final int EVENT_SET_CALL_BARRING_DONE = 37;
    protected static final int EVENT_SET_CALL_WAITING_DONE = 39;
    private static final String LOG_TAG = "ImsPhone";
    static final int RESTART_ECM_TIMER = 0;
    private static final boolean VDBG = false;
    ImsPhoneCallTracker mCT;
    PhoneBase mDefaultPhone;
    private Registrant mEcmExitRespRegistrant;
    private Runnable mExitEcmRunnable;
    ImsEcbmStateListener mImsEcbmStateListener;
    private boolean mImsRegistered;
    protected boolean mIsPhoneInEcmState;
    private String mLastDialString;
    ArrayList<ImsPhoneMmiCode> mPendingMMIs;
    Registrant mPostDialHandler;
    ServiceState mSS;
    private final RegistrantList mSilentRedialRegistrants;
    WakeLock mWakeLock;

    /* renamed from: com.android.internal.telephony.imsphone.ImsPhone.1 */
    class C00731 implements Runnable {
        C00731() {
        }

        public void run() {
            ImsPhone.this.exitEmergencyCallbackMode();
        }
    }

    /* renamed from: com.android.internal.telephony.imsphone.ImsPhone.2 */
    class C00742 extends ImsEcbmStateListener {
        C00742() {
        }

        public void onECBMEntered() {
            Rlog.d(ImsPhone.LOG_TAG, "onECBMEntered");
            ImsPhone.this.handleEnterEmergencyCallbackMode();
        }

        public void onECBMExited() {
            Rlog.d(ImsPhone.LOG_TAG, "onECBMExited");
            ImsPhone.this.handleExitEmergencyCallbackMode();
        }
    }

    private static class Cf {
        final boolean mIsCfu;
        final Message mOnComplete;
        final String mSetCfNumber;

        Cf(String cfNumber, boolean isCfu, Message onComplete) {
            this.mSetCfNumber = cfNumber;
            this.mIsCfu = isCfu;
            this.mOnComplete = onComplete;
        }
    }

    public /* bridge */ /* synthetic */ void activateCellBroadcastSms(int i, Message message) {
        super.activateCellBroadcastSms(i, message);
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

    public /* bridge */ /* synthetic */ List getAllCellInfo() {
        return super.getAllCellInfo();
    }

    public /* bridge */ /* synthetic */ void getAvailableNetworks(Message message) {
        super.getAvailableNetworks(message);
    }

    public /* bridge */ /* synthetic */ boolean getCallForwardingIndicator() {
        return super.getCallForwardingIndicator();
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

    public /* bridge */ /* synthetic */ void getOutgoingCallerIdDisplay(Message message) {
        super.getOutgoingCallerIdDisplay(message);
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

    public /* bridge */ /* synthetic */ String getSubscriberId() {
        return super.getSubscriberId();
    }

    public /* bridge */ /* synthetic */ String getVoiceMailAlphaTag() {
        return super.getVoiceMailAlphaTag();
    }

    public /* bridge */ /* synthetic */ String getVoiceMailNumber() {
        return super.getVoiceMailNumber();
    }

    public /* bridge */ /* synthetic */ boolean handlePinMmi(String str) {
        return super.handlePinMmi(str);
    }

    public /* bridge */ /* synthetic */ boolean isDataConnectivityPossible() {
        return super.isDataConnectivityPossible();
    }

    public /* bridge */ /* synthetic */ void migrateFrom(PhoneBase phoneBase) {
        super.migrateFrom(phoneBase);
    }

    public /* bridge */ /* synthetic */ boolean needsOtaServiceProvisioning() {
        return super.needsOtaServiceProvisioning();
    }

    public /* bridge */ /* synthetic */ void notifyCallForwardingIndicator() {
        super.notifyCallForwardingIndicator();
    }

    public /* bridge */ /* synthetic */ void onTtyModeReceived(int i) {
        super.onTtyModeReceived(i);
    }

    public /* bridge */ /* synthetic */ void registerForOnHoldTone(Handler handler, int i, Object obj) {
        super.registerForOnHoldTone(handler, i, obj);
    }

    public /* bridge */ /* synthetic */ void registerForRingbackTone(Handler handler, int i, Object obj) {
        super.registerForRingbackTone(handler, i, obj);
    }

    public /* bridge */ /* synthetic */ void registerForSuppServiceNotification(Handler handler, int i, Object obj) {
        super.registerForSuppServiceNotification(handler, i, obj);
    }

    public /* bridge */ /* synthetic */ void registerForTtyModeReceived(Handler handler, int i, Object obj) {
        super.registerForTtyModeReceived(handler, i, obj);
    }

    public /* bridge */ /* synthetic */ void saveClirSetting(int i) {
        super.saveClirSetting(i);
    }

    public /* bridge */ /* synthetic */ void selectNetworkManually(OperatorInfo operatorInfo, Message message) {
        super.selectNetworkManually(operatorInfo, message);
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

    public /* bridge */ /* synthetic */ void setOutgoingCallerIdDisplay(int i, Message message) {
        super.setOutgoingCallerIdDisplay(i, message);
    }

    public /* bridge */ /* synthetic */ void setRadioPower(boolean z) {
        super.setRadioPower(z);
    }

    public /* bridge */ /* synthetic */ void setVoiceMailNumber(String str, String str2, Message message) {
        super.setVoiceMailNumber(str, str2, message);
    }

    public /* bridge */ /* synthetic */ void unregisterForOnHoldTone(Handler handler) {
        super.unregisterForOnHoldTone(handler);
    }

    public /* bridge */ /* synthetic */ void unregisterForRingbackTone(Handler handler) {
        super.unregisterForRingbackTone(handler);
    }

    public /* bridge */ /* synthetic */ void unregisterForSuppServiceNotification(Handler handler) {
        super.unregisterForSuppServiceNotification(handler);
    }

    public /* bridge */ /* synthetic */ void unregisterForTtyModeReceived(Handler handler) {
        super.unregisterForTtyModeReceived(handler);
    }

    public /* bridge */ /* synthetic */ void updateServiceLocation() {
        super.updateServiceLocation();
    }

    ImsPhone(Context context, PhoneNotifier notifier, Phone defaultPhone) {
        super(LOG_TAG, context, notifier);
        this.mPendingMMIs = new ArrayList();
        this.mSS = new ServiceState();
        this.mSilentRedialRegistrants = new RegistrantList();
        this.mImsRegistered = false;
        this.mExitEcmRunnable = new C00731();
        this.mImsEcbmStateListener = new C00742();
        this.mDefaultPhone = (PhoneBase) defaultPhone;
        this.mCT = new ImsPhoneCallTracker(this);
        this.mSS.setStateOff();
        this.mPhoneId = this.mDefaultPhone.getPhoneId();
        this.mIsPhoneInEcmState = SystemProperties.getBoolean("ril.cdma.inecmmode", false);
        this.mWakeLock = ((PowerManager) context.getSystemService("power")).newWakeLock(CANCEL_ECM_TIMER, LOG_TAG);
        this.mWakeLock.setReferenceCounted(false);
    }

    public void updateParentPhone(PhoneBase parentPhone) {
        this.mDefaultPhone = parentPhone;
        this.mPhoneId = this.mDefaultPhone.getPhoneId();
    }

    public void dispose() {
        Rlog.d(LOG_TAG, "dispose");
        this.mPendingMMIs.clear();
        this.mCT.dispose();
    }

    public Phone getImsPhone() {
        return null;
    }

    public void removeReferences() {
        Rlog.d(LOG_TAG, "removeReferences");
        super.removeReferences();
        this.mCT = null;
        this.mSS = null;
    }

    public ServiceState getServiceState() {
        return this.mSS;
    }

    void setServiceState(int state) {
        this.mSS.setState(state);
    }

    public CallTracker getCallTracker() {
        return this.mCT;
    }

    public List<? extends ImsPhoneMmiCode> getPendingMmiCodes() {
        return this.mPendingMMIs;
    }

    public void acceptCall(int videoState) throws CallStateException {
        this.mCT.acceptCall(videoState);
    }

    public void rejectCall() throws CallStateException {
        this.mCT.rejectCall();
    }

    public void switchHoldingAndActive() throws CallStateException {
        this.mCT.switchWaitingOrHoldingAndActive();
    }

    public boolean canConference() {
        return this.mCT.canConference();
    }

    public boolean canDial() {
        return this.mCT.canDial();
    }

    public void conference() {
        this.mCT.conference();
    }

    public void clearDisconnected() {
        this.mCT.clearDisconnected();
    }

    public boolean canTransfer() {
        return this.mCT.canTransfer();
    }

    public void explicitCallTransfer() {
        this.mCT.explicitCallTransfer();
    }

    public ImsPhoneCall getForegroundCall() {
        return this.mCT.mForegroundCall;
    }

    public ImsPhoneCall getBackgroundCall() {
        return this.mCT.mBackgroundCall;
    }

    public ImsPhoneCall getRingingCall() {
        return this.mCT.mRingingCall;
    }

    private boolean handleCallDeflectionIncallSupplementaryService(String dialString) {
        if (dialString.length() > CANCEL_ECM_TIMER) {
            return false;
        }
        if (getRingingCall().getState() != State.IDLE) {
            Rlog.d(LOG_TAG, "MmiCode 0: rejectCall");
            try {
                this.mCT.rejectCall();
                return DBG;
            } catch (CallStateException e) {
                Rlog.d(LOG_TAG, "reject failed", e);
                notifySuppServiceFailed(SuppService.REJECT);
                return DBG;
            }
        } else if (getBackgroundCall().getState() == State.IDLE) {
            return DBG;
        } else {
            Rlog.d(LOG_TAG, "MmiCode 0: hangupWaitingOrBackground");
            try {
                this.mCT.hangup(getBackgroundCall());
                return DBG;
            } catch (CallStateException e2) {
                Rlog.d(LOG_TAG, "hangup failed", e2);
                return DBG;
            }
        }
    }

    private boolean handleCallWaitingIncallSupplementaryService(String dialString) {
        int len = dialString.length();
        if (len > 2) {
            return false;
        }
        ImsPhoneCall call = getForegroundCall();
        if (len > CANCEL_ECM_TIMER) {
            try {
                Rlog.d(LOG_TAG, "not support 1X SEND");
                notifySuppServiceFailed(SuppService.HANGUP);
                return DBG;
            } catch (CallStateException e) {
                Rlog.d(LOG_TAG, "hangup failed", e);
                notifySuppServiceFailed(SuppService.HANGUP);
                return DBG;
            }
        } else if (call.getState() != State.IDLE) {
            Rlog.d(LOG_TAG, "MmiCode 1: hangup foreground");
            this.mCT.hangup(call);
            return DBG;
        } else {
            Rlog.d(LOG_TAG, "MmiCode 1: switchWaitingOrHoldingAndActive");
            this.mCT.switchWaitingOrHoldingAndActive();
            return DBG;
        }
    }

    private boolean handleCallHoldIncallSupplementaryService(String dialString) {
        int len = dialString.length();
        if (len > 2) {
            return false;
        }
        ImsPhoneCall call = getForegroundCall();
        if (len > CANCEL_ECM_TIMER) {
            Rlog.d(LOG_TAG, "separate not supported");
            notifySuppServiceFailed(SuppService.SEPARATE);
            return DBG;
        }
        try {
            if (getRingingCall().getState() != State.IDLE) {
                Rlog.d(LOG_TAG, "MmiCode 2: accept ringing call");
                this.mCT.acceptCall(2);
                return DBG;
            }
            Rlog.d(LOG_TAG, "MmiCode 2: switchWaitingOrHoldingAndActive");
            this.mCT.switchWaitingOrHoldingAndActive();
            return DBG;
        } catch (CallStateException e) {
            Rlog.d(LOG_TAG, "switch failed", e);
            notifySuppServiceFailed(SuppService.SWITCH);
            return DBG;
        }
    }

    private boolean handleMultipartyIncallSupplementaryService(String dialString) {
        if (dialString.length() > CANCEL_ECM_TIMER) {
            return false;
        }
        Rlog.d(LOG_TAG, "MmiCode 3: merge calls");
        conference();
        return DBG;
    }

    private boolean handleEctIncallSupplementaryService(String dialString) {
        if (dialString.length() != CANCEL_ECM_TIMER) {
            return false;
        }
        Rlog.d(LOG_TAG, "MmiCode 4: not support explicit call transfer");
        notifySuppServiceFailed(SuppService.TRANSFER);
        return DBG;
    }

    private boolean handleCcbsIncallSupplementaryService(String dialString) {
        if (dialString.length() > CANCEL_ECM_TIMER) {
            return false;
        }
        Rlog.i(LOG_TAG, "MmiCode 5: CCBS not supported!");
        notifySuppServiceFailed(SuppService.UNKNOWN);
        return DBG;
    }

    public boolean handleInCallMmiCommands(String dialString) {
        if (!isInCall()) {
            return false;
        }
        if (TextUtils.isEmpty(dialString)) {
            return false;
        }
        switch (dialString.charAt(0)) {
            case '0':
                return handleCallDeflectionIncallSupplementaryService(dialString);
            case CallFailCause.QOS_NOT_AVAIL /*49*/:
                return handleCallWaitingIncallSupplementaryService(dialString);
            case '2':
                return handleCallHoldIncallSupplementaryService(dialString);
            case RadioNVItems.RIL_NV_CDMA_PRL_VERSION /*51*/:
                return handleMultipartyIncallSupplementaryService(dialString);
            case RadioNVItems.RIL_NV_CDMA_BC10 /*52*/:
                return handleEctIncallSupplementaryService(dialString);
            case RadioNVItems.RIL_NV_CDMA_BC14 /*53*/:
                return handleCcbsIncallSupplementaryService(dialString);
            default:
                return false;
        }
    }

    boolean isInCall() {
        return (getForegroundCall().getState().isAlive() || getBackgroundCall().getState().isAlive() || getRingingCall().getState().isAlive()) ? DBG : false;
    }

    void notifyNewRingingConnection(Connection c) {
        this.mDefaultPhone.notifyNewRingingConnectionP(c);
    }

    public Connection dial(String dialString, int videoState) throws CallStateException {
        return dialInternal(dialString, videoState);
    }

    protected Connection dialInternal(String dialString, int videoState) throws CallStateException {
        String newDialString = PhoneNumberUtils.stripSeparators(dialString);
        if (handleInCallMmiCommands(newDialString)) {
            return null;
        }
        if (this.mDefaultPhone.getPhoneType() == 2) {
            return this.mCT.dial(dialString, videoState);
        }
        ImsPhoneMmiCode mmi = ImsPhoneMmiCode.newFromDialString(PhoneNumberUtils.extractNetworkPortionAlt(newDialString), this);
        Rlog.d(LOG_TAG, "dialing w/ mmi '" + mmi + "'...");
        if (mmi == null) {
            return this.mCT.dial(dialString, videoState);
        }
        if (mmi.isTemporaryModeCLIR()) {
            return this.mCT.dial(mmi.getDialingNumber(), mmi.getCLIRMode(), videoState);
        }
        if (mmi.isSupportedOverImsPhone()) {
            this.mPendingMMIs.add(mmi);
            this.mMmiRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
            mmi.processCode();
            return null;
        }
        throw new CallStateException(CS_FALLBACK);
    }

    public void sendDtmf(char c) {
        if (!PhoneNumberUtils.is12Key(c)) {
            Rlog.e(LOG_TAG, "sendDtmf called with invalid character '" + c + "'");
        } else if (this.mCT.mState == PhoneConstants.State.OFFHOOK) {
            this.mCT.sendDtmf(c, null);
        }
    }

    public void startDtmf(char c) {
        if (PhoneNumberUtils.is12Key(c) || (c >= 'A' && c <= 'D')) {
            this.mCT.startDtmf(c);
        } else {
            Rlog.e(LOG_TAG, "startDtmf called with invalid character '" + c + "'");
        }
    }

    public void stopDtmf() {
        this.mCT.stopDtmf();
    }

    public void setOnPostDialCharacter(Handler h, int what, Object obj) {
        this.mPostDialHandler = new Registrant(h, what, obj);
    }

    void notifyIncomingRing() {
        Rlog.d(LOG_TAG, "notifyIncomingRing");
        sendMessage(obtainMessage(14, new AsyncResult(null, null, null)));
    }

    public void setMute(boolean muted) {
        this.mCT.setMute(muted);
    }

    public void setUiTTYMode(int uiTtyMode, Message onComplete) {
        this.mCT.setUiTTYMode(uiTtyMode, onComplete);
    }

    public boolean getMute() {
        return this.mCT.getMute();
    }

    public PhoneConstants.State getState() {
        return this.mCT.mState;
    }

    private boolean isValidCommandInterfaceCFReason(int commandInterfaceCFReason) {
        switch (commandInterfaceCFReason) {
            case CharacterSets.ANY_CHARSET /*0*/:
            case CANCEL_ECM_TIMER /*1*/:
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
            case CharacterSets.ISO_8859_2 /*5*/:
                return DBG;
            default:
                return false;
        }
    }

    private boolean isValidCommandInterfaceCFAction(int commandInterfaceCFAction) {
        switch (commandInterfaceCFAction) {
            case CharacterSets.ANY_CHARSET /*0*/:
            case CANCEL_ECM_TIMER /*1*/:
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
                return DBG;
            default:
                return false;
        }
    }

    private boolean isCfEnable(int action) {
        return (action == CANCEL_ECM_TIMER || action == 3) ? DBG : false;
    }

    private int getConditionFromCFReason(int reason) {
        switch (reason) {
            case CharacterSets.ANY_CHARSET /*0*/:
                return 0;
            case CANCEL_ECM_TIMER /*1*/:
                return CANCEL_ECM_TIMER;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return 2;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return 3;
            case CharacterSets.ISO_8859_1 /*4*/:
                return 4;
            case CharacterSets.ISO_8859_2 /*5*/:
                return 5;
            default:
                return -1;
        }
    }

    private int getCFReasonFromCondition(int condition) {
        switch (condition) {
            case CharacterSets.ANY_CHARSET /*0*/:
                return 0;
            case CANCEL_ECM_TIMER /*1*/:
                return CANCEL_ECM_TIMER;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return 2;
            case CharacterSets.ISO_8859_1 /*4*/:
                return 4;
            case CharacterSets.ISO_8859_2 /*5*/:
                return 5;
            default:
                return 3;
        }
    }

    private int getActionFromCFAction(int action) {
        switch (action) {
            case CharacterSets.ANY_CHARSET /*0*/:
                return 0;
            case CANCEL_ECM_TIMER /*1*/:
                return CANCEL_ECM_TIMER;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return 3;
            case CharacterSets.ISO_8859_1 /*4*/:
                return 4;
            default:
                return -1;
        }
    }

    public void getCallForwardingOption(int commandInterfaceCFReason, Message onComplete) {
        Rlog.d(LOG_TAG, "getCallForwardingOption reason=" + commandInterfaceCFReason);
        if (isValidCommandInterfaceCFReason(commandInterfaceCFReason)) {
            Rlog.d(LOG_TAG, "requesting call forwarding query.");
            try {
                this.mCT.getUtInterface().queryCallForward(getConditionFromCFReason(commandInterfaceCFReason), null, obtainMessage(13, onComplete));
            } catch (Throwable e) {
                sendErrorResponse(onComplete, e);
            }
        } else if (onComplete != null) {
            sendErrorResponse(onComplete);
        }
    }

    public void setCallForwardingOption(int commandInterfaceCFAction, int commandInterfaceCFReason, String dialingNumber, int timerSeconds, Message onComplete) {
        int i = CANCEL_ECM_TIMER;
        Rlog.d(LOG_TAG, "setCallForwardingOption action=" + commandInterfaceCFAction + ", reason=" + commandInterfaceCFReason);
        if (isValidCommandInterfaceCFAction(commandInterfaceCFAction) && isValidCommandInterfaceCFReason(commandInterfaceCFReason)) {
            Cf cf = new Cf(dialingNumber, commandInterfaceCFReason == 0 ? DBG : false, onComplete);
            if (!isCfEnable(commandInterfaceCFAction)) {
                i = 0;
            }
            Message resp = obtainMessage(12, i, 0, cf);
            try {
                this.mCT.getUtInterface().updateCallForward(getActionFromCFAction(commandInterfaceCFAction), getConditionFromCFReason(commandInterfaceCFReason), dialingNumber, timerSeconds, onComplete);
            } catch (Throwable e) {
                sendErrorResponse(onComplete, e);
            }
        } else if (onComplete != null) {
            sendErrorResponse(onComplete);
        }
    }

    public void getCallWaiting(Message onComplete) {
        Rlog.d(LOG_TAG, "getCallWaiting");
        try {
            this.mCT.getUtInterface().queryCallWaiting(obtainMessage(EVENT_GET_CALL_WAITING_DONE, onComplete));
        } catch (Throwable e) {
            sendErrorResponse(onComplete, e);
        }
    }

    public void setCallWaiting(boolean enable, Message onComplete) {
        Rlog.d(LOG_TAG, "setCallWaiting enable=" + enable);
        try {
            this.mCT.getUtInterface().updateCallWaiting(enable, obtainMessage(EVENT_SET_CALL_WAITING_DONE, onComplete));
        } catch (Throwable e) {
            sendErrorResponse(onComplete, e);
        }
    }

    private int getCBTypeFromFacility(String facility) {
        if (CommandsInterface.CB_FACILITY_BAOC.equals(facility)) {
            return 2;
        }
        if (CommandsInterface.CB_FACILITY_BAOIC.equals(facility)) {
            return 3;
        }
        if (CommandsInterface.CB_FACILITY_BAOICxH.equals(facility)) {
            return 4;
        }
        if (CommandsInterface.CB_FACILITY_BAIC.equals(facility)) {
            return CANCEL_ECM_TIMER;
        }
        if (CommandsInterface.CB_FACILITY_BAICr.equals(facility)) {
            return 5;
        }
        if (CommandsInterface.CB_FACILITY_BA_ALL.equals(facility)) {
            return 7;
        }
        if (CommandsInterface.CB_FACILITY_BA_MO.equals(facility)) {
            return 8;
        }
        if (CommandsInterface.CB_FACILITY_BA_MT.equals(facility)) {
            return 9;
        }
        return 0;
    }

    void getCallBarring(String facility, Message onComplete) {
        Rlog.d(LOG_TAG, "getCallBarring facility=" + facility);
        try {
            this.mCT.getUtInterface().queryCallBarring(getCBTypeFromFacility(facility), obtainMessage(EVENT_GET_CALL_BARRING_DONE, onComplete));
        } catch (Throwable e) {
            sendErrorResponse(onComplete, e);
        }
    }

    void setCallBarring(String facility, boolean lockState, String password, Message onComplete) {
        Rlog.d(LOG_TAG, "setCallBarring facility=" + facility + ", lockState=" + lockState);
        try {
            this.mCT.getUtInterface().updateCallBarring(getCBTypeFromFacility(facility), lockState, obtainMessage(EVENT_SET_CALL_BARRING_DONE, onComplete), null);
        } catch (Throwable e) {
            sendErrorResponse(onComplete, e);
        }
    }

    public void sendUssdResponse(String ussdMessge) {
        Rlog.d(LOG_TAG, "sendUssdResponse");
        ImsPhoneMmiCode mmi = ImsPhoneMmiCode.newFromUssdUserInput(ussdMessge, this);
        this.mPendingMMIs.add(mmi);
        this.mMmiRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
        mmi.sendUssd(ussdMessge);
    }

    void sendUSSD(String ussdString, Message response) {
        this.mCT.sendUSSD(ussdString, response);
    }

    void cancelUSSD() {
        this.mCT.cancelUSSD();
    }

    void sendErrorResponse(Message onComplete) {
        Rlog.d(LOG_TAG, "sendErrorResponse");
        if (onComplete != null) {
            AsyncResult.forMessage(onComplete, null, new CommandException(Error.GENERIC_FAILURE));
            onComplete.sendToTarget();
        }
    }

    void sendErrorResponse(Message onComplete, Throwable e) {
        Rlog.d(LOG_TAG, "sendErrorResponse");
        if (onComplete != null) {
            AsyncResult.forMessage(onComplete, null, getCommandException(e));
            onComplete.sendToTarget();
        }
    }

    void sendErrorResponse(Message onComplete, ImsReasonInfo reasonInfo) {
        Rlog.d(LOG_TAG, "sendErrorResponse reasonCode=" + reasonInfo.getCode());
        if (onComplete != null) {
            AsyncResult.forMessage(onComplete, null, getCommandException(reasonInfo.getCode()));
            onComplete.sendToTarget();
        }
    }

    CommandException getCommandException(int code) {
        Rlog.d(LOG_TAG, "getCommandException code=" + code);
        Error error = Error.GENERIC_FAILURE;
        switch (code) {
            case 801:
                error = Error.REQUEST_NOT_SUPPORTED;
                break;
            case 821:
                error = Error.PASSWORD_INCORRECT;
                break;
        }
        return new CommandException(error);
    }

    CommandException getCommandException(Throwable e) {
        if (e instanceof ImsException) {
            return getCommandException(((ImsException) e).getCode());
        }
        Rlog.d(LOG_TAG, "getCommandException generic failure");
        return new CommandException(Error.GENERIC_FAILURE);
    }

    private void onNetworkInitiatedUssd(ImsPhoneMmiCode mmi) {
        Rlog.d(LOG_TAG, "onNetworkInitiatedUssd");
        this.mMmiCompleteRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
    }

    void onIncomingUSSD(int ussdMode, String ussdMessage) {
        boolean isUssdRequest;
        boolean isUssdError = DBG;
        Rlog.d(LOG_TAG, "onIncomingUSSD ussdMode=" + ussdMode);
        if (ussdMode == CANCEL_ECM_TIMER) {
            isUssdRequest = DBG;
        } else {
            isUssdRequest = false;
        }
        if (ussdMode == 0 || ussdMode == CANCEL_ECM_TIMER) {
            isUssdError = false;
        }
        ImsPhoneMmiCode found = null;
        int s = this.mPendingMMIs.size();
        for (int i = 0; i < s; i += CANCEL_ECM_TIMER) {
            if (((ImsPhoneMmiCode) this.mPendingMMIs.get(i)).isPendingUSSD()) {
                found = (ImsPhoneMmiCode) this.mPendingMMIs.get(i);
                break;
            }
        }
        if (found != null) {
            if (isUssdError) {
                found.onUssdFinishedError();
            } else {
                found.onUssdFinished(ussdMessage, isUssdRequest);
            }
        } else if (!isUssdError && ussdMessage != null) {
            onNetworkInitiatedUssd(ImsPhoneMmiCode.newNetworkInitiatedUssd(ussdMessage, isUssdRequest, this));
        }
    }

    void onMMIDone(ImsPhoneMmiCode mmi) {
        if (this.mPendingMMIs.remove(mmi) || mmi.isUssdRequest()) {
            this.mMmiCompleteRegistrants.notifyRegistrants(new AsyncResult(null, mmi, null));
        }
    }

    public ArrayList<Connection> getHandoverConnection() {
        ArrayList<Connection> connList = new ArrayList();
        connList.addAll(getForegroundCall().mConnections);
        connList.addAll(getBackgroundCall().mConnections);
        connList.addAll(getRingingCall().mConnections);
        return connList.size() > 0 ? connList : null;
    }

    public void notifySrvccState(SrvccState state) {
        this.mCT.notifySrvccState(state);
    }

    void initiateSilentRedial() {
        AsyncResult ar = new AsyncResult(null, this.mLastDialString, null);
        if (ar != null) {
            this.mSilentRedialRegistrants.notifyRegistrants(ar);
        }
    }

    public void registerForSilentRedial(Handler h, int what, Object obj) {
        this.mSilentRedialRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForSilentRedial(Handler h) {
        this.mSilentRedialRegistrants.remove(h);
    }

    public int getSubId() {
        return this.mDefaultPhone.getSubId();
    }

    public int getPhoneId() {
        return this.mDefaultPhone.getPhoneId();
    }

    private IccRecords getIccRecords() {
        return (IccRecords) this.mDefaultPhone.mIccRecords.get();
    }

    private CallForwardInfo getCallForwardInfo(ImsCallForwardInfo info) {
        CallForwardInfo cfInfo = new CallForwardInfo();
        cfInfo.status = info.mStatus;
        cfInfo.reason = getCFReasonFromCondition(info.mCondition);
        cfInfo.serviceClass = CANCEL_ECM_TIMER;
        cfInfo.toa = info.mToA;
        cfInfo.number = info.mNumber;
        cfInfo.timeSeconds = info.mTimeSeconds;
        return cfInfo;
    }

    private CallForwardInfo[] handleCfQueryResult(ImsCallForwardInfo[] infos) {
        CallForwardInfo[] cfInfos = null;
        if (!(infos == null || infos.length == 0)) {
            cfInfos = new CallForwardInfo[infos.length];
        }
        IccRecords r = getIccRecords();
        if (infos != null && infos.length != 0) {
            int s = infos.length;
            for (int i = 0; i < s; i += CANCEL_ECM_TIMER) {
                if (infos[i].mCondition == 0 && r != null) {
                    boolean z;
                    if (infos[i].mStatus == CANCEL_ECM_TIMER) {
                        z = DBG;
                    } else {
                        z = false;
                    }
                    r.setVoiceCallForwardingFlag(CANCEL_ECM_TIMER, z, infos[i].mNumber);
                }
                cfInfos[i] = getCallForwardInfo(infos[i]);
            }
        } else if (r != null) {
            r.setVoiceCallForwardingFlag(CANCEL_ECM_TIMER, false, null);
        }
        return cfInfos;
    }

    private int[] handleCbQueryResult(ImsSsInfo[] infos) {
        int[] cbInfos = new int[CANCEL_ECM_TIMER];
        cbInfos[0] = 0;
        if (infos[0].mStatus == CANCEL_ECM_TIMER) {
            cbInfos[0] = CANCEL_ECM_TIMER;
        }
        return cbInfos;
    }

    private int[] handleCwQueryResult(ImsSsInfo[] infos) {
        int[] cwInfos = new int[2];
        cwInfos[0] = 0;
        if (infos[0].mStatus == CANCEL_ECM_TIMER) {
            cwInfos[0] = CANCEL_ECM_TIMER;
            cwInfos[CANCEL_ECM_TIMER] = CANCEL_ECM_TIMER;
        }
        return cwInfos;
    }

    private void sendResponse(Message onComplete, Object result, Throwable e) {
        if (onComplete != null) {
            if (e == null) {
                AsyncResult.forMessage(onComplete, result, null);
            } else if (e instanceof ImsException) {
                AsyncResult.forMessage(onComplete, result, (ImsException) e);
            } else {
                AsyncResult.forMessage(onComplete, result, getCommandException(e));
            }
            onComplete.sendToTarget();
        }
    }

    public void handleMessage(Message msg) {
        AsyncResult ar = msg.obj;
        Rlog.d(LOG_TAG, "handleMessage what=" + msg.what);
        switch (msg.what) {
            case CharacterSets.ISO_8859_9 /*12*/:
                IccRecords r = getIccRecords();
                Cf cf = ar.userObj;
                if (cf.mIsCfu && ar.exception == null && r != null) {
                    r.setVoiceCallForwardingFlag(CANCEL_ECM_TIMER, msg.arg1 == CANCEL_ECM_TIMER ? DBG : false, cf.mSetCfNumber);
                }
                sendResponse(cf.mOnComplete, null, ar.exception);
            case UserData.ASCII_CR_INDEX /*13*/:
                CallForwardInfo[] cfInfos = null;
                if (ar.exception == null) {
                    cfInfos = handleCfQueryResult((ImsCallForwardInfo[]) ar.result);
                }
                sendResponse((Message) ar.userObj, cfInfos, ar.exception);
            case EVENT_SET_CALL_BARRING_DONE /*37*/:
            case EVENT_SET_CALL_WAITING_DONE /*39*/:
                sendResponse((Message) ar.userObj, null, ar.exception);
            case EVENT_GET_CALL_BARRING_DONE /*38*/:
            case EVENT_GET_CALL_WAITING_DONE /*40*/:
                int[] ssInfos = null;
                if (ar.exception == null) {
                    if (msg.what == EVENT_GET_CALL_BARRING_DONE) {
                        ssInfos = handleCbQueryResult((ImsSsInfo[]) ar.result);
                    } else if (msg.what == EVENT_GET_CALL_WAITING_DONE) {
                        ssInfos = handleCwQueryResult((ImsSsInfo[]) ar.result);
                    }
                }
                sendResponse((Message) ar.userObj, ssInfos, ar.exception);
            default:
                super.handleMessage(msg);
        }
    }

    public boolean isInEmergencyCall() {
        return this.mCT.isInEmergencyCall();
    }

    public boolean isInEcm() {
        return this.mIsPhoneInEcmState;
    }

    void sendEmergencyCallbackModeChange() {
        Intent intent = new Intent("android.intent.action.EMERGENCY_CALLBACK_MODE_CHANGED");
        intent.putExtra("phoneinECMState", this.mIsPhoneInEcmState);
        SubscriptionManager.putPhoneIdAndSubIdExtra(intent, getPhoneId());
        ActivityManagerNative.broadcastStickyIntent(intent, null, -1);
        Rlog.d(LOG_TAG, "sendEmergencyCallbackModeChange");
    }

    public void exitEmergencyCallbackMode() {
        if (this.mWakeLock.isHeld()) {
            this.mWakeLock.release();
        }
        Rlog.d(LOG_TAG, "exitEmergencyCallbackMode()");
        try {
            this.mCT.getEcbmInterface().exitEmergencyCallbackMode();
        } catch (ImsException e) {
            e.printStackTrace();
        }
    }

    private void handleEnterEmergencyCallbackMode() {
        Rlog.d(LOG_TAG, "handleEnterEmergencyCallbackMode,mIsPhoneInEcmState= " + this.mIsPhoneInEcmState);
        if (!this.mIsPhoneInEcmState) {
            this.mIsPhoneInEcmState = DBG;
            sendEmergencyCallbackModeChange();
            setSystemProperty("ril.cdma.inecmmode", "true");
            postDelayed(this.mExitEcmRunnable, SystemProperties.getLong("ro.cdma.ecmexittimer", 300000));
            this.mWakeLock.acquire();
        }
    }

    private void handleExitEmergencyCallbackMode() {
        Rlog.d(LOG_TAG, "handleExitEmergencyCallbackMode: mIsPhoneInEcmState = " + this.mIsPhoneInEcmState);
        removeCallbacks(this.mExitEcmRunnable);
        if (this.mEcmExitRespRegistrant != null) {
            this.mEcmExitRespRegistrant.notifyResult(Boolean.TRUE);
        }
        if (this.mIsPhoneInEcmState) {
            this.mIsPhoneInEcmState = false;
            setSystemProperty("ril.cdma.inecmmode", "false");
        }
        sendEmergencyCallbackModeChange();
    }

    void handleTimerInEmergencyCallbackMode(int action) {
        switch (action) {
            case CharacterSets.ANY_CHARSET /*0*/:
                postDelayed(this.mExitEcmRunnable, SystemProperties.getLong("ro.cdma.ecmexittimer", 300000));
                if (this.mDefaultPhone.getPhoneType() == CANCEL_ECM_TIMER) {
                    ((GSMPhone) this.mDefaultPhone).notifyEcbmTimerReset(Boolean.FALSE);
                } else {
                    ((CDMAPhone) this.mDefaultPhone).notifyEcbmTimerReset(Boolean.FALSE);
                }
            case CANCEL_ECM_TIMER /*1*/:
                removeCallbacks(this.mExitEcmRunnable);
                if (this.mDefaultPhone.getPhoneType() == CANCEL_ECM_TIMER) {
                    ((GSMPhone) this.mDefaultPhone).notifyEcbmTimerReset(Boolean.TRUE);
                } else {
                    ((CDMAPhone) this.mDefaultPhone).notifyEcbmTimerReset(Boolean.TRUE);
                }
            default:
                Rlog.e(LOG_TAG, "handleTimerInEmergencyCallbackMode, unsupported action " + action);
        }
    }

    public void setOnEcbModeExitResponse(Handler h, int what, Object obj) {
        this.mEcmExitRespRegistrant = new Registrant(h, what, obj);
    }

    public void unsetOnEcbModeExitResponse(Handler h) {
        this.mEcmExitRespRegistrant.clear();
    }

    public boolean isVolteEnabled() {
        return this.mCT.isVolteEnabled();
    }

    public boolean isVtEnabled() {
        return this.mCT.isVtEnabled();
    }

    public Phone getDefaultPhone() {
        return this.mDefaultPhone;
    }

    public boolean isImsRegistered() {
        return this.mImsRegistered;
    }

    public void setImsRegistered(boolean value) {
        this.mImsRegistered = value;
    }

    public void callEndCleanupHandOverCallIfAny() {
        this.mCT.callEndCleanupHandOverCallIfAny();
    }
}
