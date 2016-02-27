package com.android.internal.telephony;

import android.app.ActivityManagerNative;
import android.content.Context;
import android.content.Intent;
import android.net.LinkProperties;
import android.net.NetworkCapabilities;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.SystemProperties;
import android.telephony.CellInfo;
import android.telephony.CellLocation;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SignalStrength;
import android.telephony.SubscriptionManager;
import com.android.internal.telephony.Phone.DataActivityState;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.android.internal.telephony.PhoneConstants.State;
import com.android.internal.telephony.cdma.CDMALTEPhone;
import com.android.internal.telephony.dataconnection.DctController;
import com.android.internal.telephony.gsm.GSMPhone;
import com.android.internal.telephony.imsphone.ImsPhone;
import com.android.internal.telephony.test.SimulatedRadioControl;
import com.android.internal.telephony.uicc.IccCardProxy;
import com.android.internal.telephony.uicc.IccFileHandler;
import com.android.internal.telephony.uicc.IsimRecords;
import com.android.internal.telephony.uicc.UiccCard;
import com.android.internal.telephony.uicc.UsimServiceTable;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.List;

public class PhoneProxy extends Handler implements Phone {
    private static final int EVENT_RADIO_ON = 2;
    private static final int EVENT_REQUEST_VOICE_RADIO_TECH_DONE = 3;
    private static final int EVENT_RIL_CONNECTED = 4;
    private static final int EVENT_SIM_RECORDS_LOADED = 6;
    private static final int EVENT_UPDATE_PHONE_OBJECT = 5;
    private static final int EVENT_VOICE_RADIO_TECH_CHANGED = 1;
    private static final String LOG_TAG = "PhoneProxy";
    public static final Object lockForRadioTechnologyChange;
    private Phone mActivePhone;
    private CommandsInterface mCommandsInterface;
    private IccCardProxy mIccCardProxy;
    private IccPhoneBookInterfaceManagerProxy mIccPhoneBookInterfaceManagerProxy;
    private IccSmsInterfaceManager mIccSmsInterfaceManager;
    private int mPhoneId;
    private PhoneSubInfoProxy mPhoneSubInfoProxy;
    private boolean mResetModemOnRadioTechnologyChange;
    private int mRilVersion;

    static {
        lockForRadioTechnologyChange = new Object();
    }

    public PhoneProxy(PhoneBase phone) {
        this.mResetModemOnRadioTechnologyChange = false;
        this.mPhoneId = 0;
        this.mActivePhone = phone;
        this.mResetModemOnRadioTechnologyChange = SystemProperties.getBoolean("persist.radio.reset_on_switch", false);
        this.mIccPhoneBookInterfaceManagerProxy = new IccPhoneBookInterfaceManagerProxy(phone.getIccPhoneBookInterfaceManager());
        this.mPhoneSubInfoProxy = new PhoneSubInfoProxy(phone.getPhoneSubInfo());
        this.mCommandsInterface = ((PhoneBase) this.mActivePhone).mCi;
        this.mCommandsInterface.registerForRilConnected(this, EVENT_RIL_CONNECTED, null);
        this.mCommandsInterface.registerForOn(this, EVENT_RADIO_ON, null);
        this.mCommandsInterface.registerForVoiceRadioTechChanged(this, EVENT_VOICE_RADIO_TECH_CHANGED, null);
        this.mPhoneId = phone.getPhoneId();
        this.mIccSmsInterfaceManager = new IccSmsInterfaceManager((PhoneBase) this.mActivePhone);
        this.mIccCardProxy = new IccCardProxy(this.mActivePhone.getContext(), this.mCommandsInterface, this.mActivePhone.getPhoneId());
        if (phone.getPhoneType() == EVENT_VOICE_RADIO_TECH_CHANGED) {
            this.mIccCardProxy.setVoiceRadioTech(EVENT_REQUEST_VOICE_RADIO_TECH_DONE);
        } else if (phone.getPhoneType() == EVENT_RADIO_ON) {
            this.mIccCardProxy.setVoiceRadioTech(EVENT_SIM_RECORDS_LOADED);
        }
    }

    public void handleMessage(Message msg) {
        AsyncResult ar = msg.obj;
        switch (msg.what) {
            case EVENT_VOICE_RADIO_TECH_CHANGED /*1*/:
            case EVENT_REQUEST_VOICE_RADIO_TECH_DONE /*3*/:
                String what = msg.what == EVENT_VOICE_RADIO_TECH_CHANGED ? "EVENT_VOICE_RADIO_TECH_CHANGED" : "EVENT_REQUEST_VOICE_RADIO_TECH_DONE";
                if (ar.exception == null) {
                    if (ar.result != null && ((int[]) ar.result).length != 0) {
                        int newVoiceTech = ((int[]) ar.result)[0];
                        logd(what + ": newVoiceTech=" + newVoiceTech);
                        phoneObjectUpdater(newVoiceTech);
                        break;
                    }
                    loge(what + ": has no tech!");
                    break;
                }
                loge(what + ": exception=" + ar.exception);
                break;
                break;
            case EVENT_RADIO_ON /*2*/:
                this.mCommandsInterface.getVoiceRadioTechnology(obtainMessage(EVENT_REQUEST_VOICE_RADIO_TECH_DONE));
                break;
            case EVENT_RIL_CONNECTED /*4*/:
                if (ar.exception == null && ar.result != null) {
                    this.mRilVersion = ((Integer) ar.result).intValue();
                    break;
                }
                logd("Unexpected exception on EVENT_RIL_CONNECTED");
                this.mRilVersion = -1;
                break;
                break;
            case EVENT_UPDATE_PHONE_OBJECT /*5*/:
                phoneObjectUpdater(msg.arg1);
                break;
            case EVENT_SIM_RECORDS_LOADED /*6*/:
                if (!this.mActivePhone.getContext().getResources().getBoolean(17957007)) {
                    this.mCommandsInterface.getVoiceRadioTechnology(obtainMessage(EVENT_REQUEST_VOICE_RADIO_TECH_DONE));
                    break;
                }
                break;
            default:
                loge("Error! This handler was not registered for this message type. Message: " + msg.what);
                break;
        }
        super.handleMessage(msg);
    }

    private static void logd(String msg) {
        Rlog.d(LOG_TAG, "[PhoneProxy] " + msg);
    }

    private void loge(String msg) {
        Rlog.e(LOG_TAG, "[PhoneProxy] " + msg);
    }

    private void phoneObjectUpdater(int newVoiceRadioTech) {
        logd("phoneObjectUpdater: newVoiceRadioTech=" + newVoiceRadioTech);
        if (this.mActivePhone != null) {
            if (newVoiceRadioTech == 14 || newVoiceRadioTech == 0) {
                int volteReplacementRat = this.mActivePhone.getContext().getResources().getInteger(17694819);
                logd("phoneObjectUpdater: volteReplacementRat=" + volteReplacementRat);
                if (volteReplacementRat != 0) {
                    newVoiceRadioTech = volteReplacementRat;
                }
            }
            if (this.mRilVersion != EVENT_SIM_RECORDS_LOADED || getLteOnCdmaMode() != EVENT_VOICE_RADIO_TECH_CHANGED) {
                boolean matchCdma = ServiceState.isCdma(newVoiceRadioTech);
                boolean matchGsm = ServiceState.isGsm(newVoiceRadioTech);
                if ((matchCdma && this.mActivePhone.getPhoneType() == EVENT_RADIO_ON) || (matchGsm && this.mActivePhone.getPhoneType() == EVENT_VOICE_RADIO_TECH_CHANGED)) {
                    logd("phoneObjectUpdater: No change ignore, newVoiceRadioTech=" + newVoiceRadioTech + " mActivePhone=" + this.mActivePhone.getPhoneName());
                    return;
                } else if (!(matchCdma || matchGsm)) {
                    loge("phoneObjectUpdater: newVoiceRadioTech=" + newVoiceRadioTech + " doesn't match either CDMA or GSM - error! No phone change");
                    return;
                }
            } else if (this.mActivePhone.getPhoneType() == EVENT_RADIO_ON) {
                logd("phoneObjectUpdater: LTE ON CDMA property is set. Use CDMA Phone newVoiceRadioTech=" + newVoiceRadioTech + " mActivePhone=" + this.mActivePhone.getPhoneName());
                return;
            } else {
                logd("phoneObjectUpdater: LTE ON CDMA property is set. Switch to CDMALTEPhone newVoiceRadioTech=" + newVoiceRadioTech + " mActivePhone=" + this.mActivePhone.getPhoneName());
                newVoiceRadioTech = EVENT_SIM_RECORDS_LOADED;
            }
        }
        if (newVoiceRadioTech == 0) {
            logd("phoneObjectUpdater: Unknown rat ignore,  newVoiceRadioTech=Unknown. mActivePhone=" + this.mActivePhone.getPhoneName());
            return;
        }
        boolean oldPowerState = false;
        if (this.mResetModemOnRadioTechnologyChange && this.mCommandsInterface.getRadioState().isOn()) {
            oldPowerState = true;
            logd("phoneObjectUpdater: Setting Radio Power to Off");
            this.mCommandsInterface.setRadioPower(false, null);
        }
        deleteAndCreatePhone(newVoiceRadioTech);
        if (this.mResetModemOnRadioTechnologyChange && oldPowerState) {
            logd("phoneObjectUpdater: Resetting Radio");
            this.mCommandsInterface.setRadioPower(oldPowerState, null);
        }
        this.mIccSmsInterfaceManager.updatePhoneObject((PhoneBase) this.mActivePhone);
        this.mIccPhoneBookInterfaceManagerProxy.setmIccPhoneBookInterfaceManager(this.mActivePhone.getIccPhoneBookInterfaceManager());
        this.mPhoneSubInfoProxy.setmPhoneSubInfo(this.mActivePhone.getPhoneSubInfo());
        this.mCommandsInterface = ((PhoneBase) this.mActivePhone).mCi;
        this.mIccCardProxy.setVoiceRadioTech(newVoiceRadioTech);
        Intent intent = new Intent("android.intent.action.RADIO_TECHNOLOGY");
        intent.addFlags(536870912);
        intent.putExtra("phoneName", this.mActivePhone.getPhoneName());
        SubscriptionManager.putPhoneIdAndSubIdExtra(intent, this.mPhoneId);
        ActivityManagerNative.broadcastStickyIntent(intent, null, -1);
        DctController.getInstance().updatePhoneObject(this);
    }

    private void deleteAndCreatePhone(int newVoiceRadioTech) {
        String outgoingPhoneName = "Unknown";
        Phone oldPhone = this.mActivePhone;
        ImsPhone imsPhone = null;
        if (oldPhone != null) {
            outgoingPhoneName = ((PhoneBase) oldPhone).getPhoneName();
            oldPhone.unregisterForSimRecordsLoaded(this);
        }
        logd("Switching Voice Phone : " + outgoingPhoneName + " >>> " + (ServiceState.isGsm(newVoiceRadioTech) ? "GSM" : "CDMA"));
        if (ServiceState.isCdma(newVoiceRadioTech)) {
            this.mActivePhone = PhoneFactory.getCdmaPhone(this.mPhoneId);
        } else if (ServiceState.isGsm(newVoiceRadioTech)) {
            this.mActivePhone = PhoneFactory.getGsmPhone(this.mPhoneId);
        } else {
            loge("deleteAndCreatePhone: newVoiceRadioTech=" + newVoiceRadioTech + " is not CDMA or GSM (error) - aborting!");
            return;
        }
        if (oldPhone != null) {
            imsPhone = oldPhone.relinquishOwnershipOfImsPhone();
        }
        if (this.mActivePhone != null) {
            CallManager.getInstance().registerPhone(this.mActivePhone);
            if (imsPhone != null) {
                this.mActivePhone.acquireOwnershipOfImsPhone(imsPhone);
            }
            this.mActivePhone.registerForSimRecordsLoaded(this, EVENT_SIM_RECORDS_LOADED, null);
        }
        if (oldPhone != null) {
            CallManager.getInstance().unregisterPhone(oldPhone);
            logd("Disposing old phone..");
            oldPhone.dispose();
        }
    }

    public IccSmsInterfaceManager getIccSmsInterfaceManager() {
        return this.mIccSmsInterfaceManager;
    }

    public PhoneSubInfoProxy getPhoneSubInfoProxy() {
        return this.mPhoneSubInfoProxy;
    }

    public IccPhoneBookInterfaceManagerProxy getIccPhoneBookInterfaceManagerProxy() {
        return this.mIccPhoneBookInterfaceManagerProxy;
    }

    public IccFileHandler getIccFileHandler() {
        return ((PhoneBase) this.mActivePhone).getIccFileHandler();
    }

    public void updatePhoneObject(int voiceRadioTech) {
        logd("updatePhoneObject: radioTechnology=" + voiceRadioTech);
        sendMessage(obtainMessage(EVENT_UPDATE_PHONE_OBJECT, voiceRadioTech, 0, null));
    }

    public ServiceState getServiceState() {
        return this.mActivePhone.getServiceState();
    }

    public CellLocation getCellLocation() {
        return this.mActivePhone.getCellLocation();
    }

    public List<CellInfo> getAllCellInfo() {
        return this.mActivePhone.getAllCellInfo();
    }

    public void setCellInfoListRate(int rateInMillis) {
        this.mActivePhone.setCellInfoListRate(rateInMillis);
    }

    public DataState getDataConnectionState() {
        return this.mActivePhone.getDataConnectionState("default");
    }

    public DataState getDataConnectionState(String apnType) {
        return this.mActivePhone.getDataConnectionState(apnType);
    }

    public DataActivityState getDataActivityState() {
        return this.mActivePhone.getDataActivityState();
    }

    public Context getContext() {
        return this.mActivePhone.getContext();
    }

    public void disableDnsCheck(boolean b) {
        this.mActivePhone.disableDnsCheck(b);
    }

    public boolean isDnsCheckDisabled() {
        return this.mActivePhone.isDnsCheckDisabled();
    }

    public State getState() {
        return this.mActivePhone.getState();
    }

    public String getPhoneName() {
        return this.mActivePhone.getPhoneName();
    }

    public int getPhoneType() {
        return this.mActivePhone.getPhoneType();
    }

    public String[] getActiveApnTypes() {
        return this.mActivePhone.getActiveApnTypes();
    }

    public boolean hasMatchedTetherApnSetting() {
        return this.mActivePhone.hasMatchedTetherApnSetting();
    }

    public String getActiveApnHost(String apnType) {
        return this.mActivePhone.getActiveApnHost(apnType);
    }

    public LinkProperties getLinkProperties(String apnType) {
        return this.mActivePhone.getLinkProperties(apnType);
    }

    public NetworkCapabilities getNetworkCapabilities(String apnType) {
        return this.mActivePhone.getNetworkCapabilities(apnType);
    }

    public SignalStrength getSignalStrength() {
        return this.mActivePhone.getSignalStrength();
    }

    public void registerForUnknownConnection(Handler h, int what, Object obj) {
        this.mActivePhone.registerForUnknownConnection(h, what, obj);
    }

    public void unregisterForUnknownConnection(Handler h) {
        this.mActivePhone.unregisterForUnknownConnection(h);
    }

    public void registerForHandoverStateChanged(Handler h, int what, Object obj) {
        this.mActivePhone.registerForHandoverStateChanged(h, what, obj);
    }

    public void unregisterForHandoverStateChanged(Handler h) {
        this.mActivePhone.unregisterForHandoverStateChanged(h);
    }

    public void registerForPreciseCallStateChanged(Handler h, int what, Object obj) {
        this.mActivePhone.registerForPreciseCallStateChanged(h, what, obj);
    }

    public void unregisterForPreciseCallStateChanged(Handler h) {
        this.mActivePhone.unregisterForPreciseCallStateChanged(h);
    }

    public void registerForNewRingingConnection(Handler h, int what, Object obj) {
        this.mActivePhone.registerForNewRingingConnection(h, what, obj);
    }

    public void unregisterForNewRingingConnection(Handler h) {
        this.mActivePhone.unregisterForNewRingingConnection(h);
    }

    public void registerForIncomingRing(Handler h, int what, Object obj) {
        this.mActivePhone.registerForIncomingRing(h, what, obj);
    }

    public void unregisterForIncomingRing(Handler h) {
        this.mActivePhone.unregisterForIncomingRing(h);
    }

    public void registerForDisconnect(Handler h, int what, Object obj) {
        this.mActivePhone.registerForDisconnect(h, what, obj);
    }

    public void unregisterForDisconnect(Handler h) {
        this.mActivePhone.unregisterForDisconnect(h);
    }

    public void registerForMmiInitiate(Handler h, int what, Object obj) {
        this.mActivePhone.registerForMmiInitiate(h, what, obj);
    }

    public void unregisterForMmiInitiate(Handler h) {
        this.mActivePhone.unregisterForMmiInitiate(h);
    }

    public void registerForMmiComplete(Handler h, int what, Object obj) {
        this.mActivePhone.registerForMmiComplete(h, what, obj);
    }

    public void unregisterForMmiComplete(Handler h) {
        this.mActivePhone.unregisterForMmiComplete(h);
    }

    public List<? extends MmiCode> getPendingMmiCodes() {
        return this.mActivePhone.getPendingMmiCodes();
    }

    public void sendUssdResponse(String ussdMessge) {
        this.mActivePhone.sendUssdResponse(ussdMessge);
    }

    public void registerForServiceStateChanged(Handler h, int what, Object obj) {
        this.mActivePhone.registerForServiceStateChanged(h, what, obj);
    }

    public void unregisterForServiceStateChanged(Handler h) {
        this.mActivePhone.unregisterForServiceStateChanged(h);
    }

    public void registerForSuppServiceNotification(Handler h, int what, Object obj) {
        this.mActivePhone.registerForSuppServiceNotification(h, what, obj);
    }

    public void unregisterForSuppServiceNotification(Handler h) {
        this.mActivePhone.unregisterForSuppServiceNotification(h);
    }

    public void registerForSuppServiceFailed(Handler h, int what, Object obj) {
        this.mActivePhone.registerForSuppServiceFailed(h, what, obj);
    }

    public void unregisterForSuppServiceFailed(Handler h) {
        this.mActivePhone.unregisterForSuppServiceFailed(h);
    }

    public void registerForInCallVoicePrivacyOn(Handler h, int what, Object obj) {
        this.mActivePhone.registerForInCallVoicePrivacyOn(h, what, obj);
    }

    public void unregisterForInCallVoicePrivacyOn(Handler h) {
        this.mActivePhone.unregisterForInCallVoicePrivacyOn(h);
    }

    public void registerForInCallVoicePrivacyOff(Handler h, int what, Object obj) {
        this.mActivePhone.registerForInCallVoicePrivacyOff(h, what, obj);
    }

    public void unregisterForInCallVoicePrivacyOff(Handler h) {
        this.mActivePhone.unregisterForInCallVoicePrivacyOff(h);
    }

    public void registerForCdmaOtaStatusChange(Handler h, int what, Object obj) {
        this.mActivePhone.registerForCdmaOtaStatusChange(h, what, obj);
    }

    public void unregisterForCdmaOtaStatusChange(Handler h) {
        this.mActivePhone.unregisterForCdmaOtaStatusChange(h);
    }

    public void registerForSubscriptionInfoReady(Handler h, int what, Object obj) {
        this.mActivePhone.registerForSubscriptionInfoReady(h, what, obj);
    }

    public void unregisterForSubscriptionInfoReady(Handler h) {
        this.mActivePhone.unregisterForSubscriptionInfoReady(h);
    }

    public void registerForEcmTimerReset(Handler h, int what, Object obj) {
        this.mActivePhone.registerForEcmTimerReset(h, what, obj);
    }

    public void unregisterForEcmTimerReset(Handler h) {
        this.mActivePhone.unregisterForEcmTimerReset(h);
    }

    public void registerForRingbackTone(Handler h, int what, Object obj) {
        this.mActivePhone.registerForRingbackTone(h, what, obj);
    }

    public void unregisterForRingbackTone(Handler h) {
        this.mActivePhone.unregisterForRingbackTone(h);
    }

    public void registerForOnHoldTone(Handler h, int what, Object obj) {
        this.mActivePhone.registerForOnHoldTone(h, what, obj);
    }

    public void unregisterForOnHoldTone(Handler h) {
        this.mActivePhone.unregisterForOnHoldTone(h);
    }

    public void registerForResendIncallMute(Handler h, int what, Object obj) {
        this.mActivePhone.registerForResendIncallMute(h, what, obj);
    }

    public void unregisterForResendIncallMute(Handler h) {
        this.mActivePhone.unregisterForResendIncallMute(h);
    }

    public void registerForSimRecordsLoaded(Handler h, int what, Object obj) {
        this.mActivePhone.registerForSimRecordsLoaded(h, what, obj);
    }

    public void unregisterForSimRecordsLoaded(Handler h) {
        this.mActivePhone.unregisterForSimRecordsLoaded(h);
    }

    public void registerForTtyModeReceived(Handler h, int what, Object obj) {
        this.mActivePhone.registerForTtyModeReceived(h, what, obj);
    }

    public void unregisterForTtyModeReceived(Handler h) {
        this.mActivePhone.unregisterForTtyModeReceived(h);
    }

    public boolean getIccRecordsLoaded() {
        return this.mIccCardProxy.getIccRecordsLoaded();
    }

    public IccCard getIccCard() {
        return this.mIccCardProxy;
    }

    public void acceptCall(int videoState) throws CallStateException {
        this.mActivePhone.acceptCall(videoState);
    }

    public void rejectCall() throws CallStateException {
        this.mActivePhone.rejectCall();
    }

    public void switchHoldingAndActive() throws CallStateException {
        this.mActivePhone.switchHoldingAndActive();
    }

    public boolean canConference() {
        return this.mActivePhone.canConference();
    }

    public void conference() throws CallStateException {
        this.mActivePhone.conference();
    }

    public void enableEnhancedVoicePrivacy(boolean enable, Message onComplete) {
        this.mActivePhone.enableEnhancedVoicePrivacy(enable, onComplete);
    }

    public void getEnhancedVoicePrivacy(Message onComplete) {
        this.mActivePhone.getEnhancedVoicePrivacy(onComplete);
    }

    public boolean canTransfer() {
        return this.mActivePhone.canTransfer();
    }

    public void explicitCallTransfer() throws CallStateException {
        this.mActivePhone.explicitCallTransfer();
    }

    public void clearDisconnected() {
        this.mActivePhone.clearDisconnected();
    }

    public Call getForegroundCall() {
        return this.mActivePhone.getForegroundCall();
    }

    public Call getBackgroundCall() {
        return this.mActivePhone.getBackgroundCall();
    }

    public Call getRingingCall() {
        return this.mActivePhone.getRingingCall();
    }

    public Connection dial(String dialString, int videoState) throws CallStateException {
        return this.mActivePhone.dial(dialString, videoState);
    }

    public Connection dial(String dialString, UUSInfo uusInfo, int videoState) throws CallStateException {
        return this.mActivePhone.dial(dialString, uusInfo, videoState);
    }

    public boolean handlePinMmi(String dialString) {
        return this.mActivePhone.handlePinMmi(dialString);
    }

    public boolean handleInCallMmiCommands(String command) throws CallStateException {
        return this.mActivePhone.handleInCallMmiCommands(command);
    }

    public void sendDtmf(char c) {
        this.mActivePhone.sendDtmf(c);
    }

    public void startDtmf(char c) {
        this.mActivePhone.startDtmf(c);
    }

    public void stopDtmf() {
        this.mActivePhone.stopDtmf();
    }

    public void setRadioPower(boolean power) {
        this.mActivePhone.setRadioPower(power);
    }

    public boolean getMessageWaitingIndicator() {
        return this.mActivePhone.getMessageWaitingIndicator();
    }

    public boolean getCallForwardingIndicator() {
        return this.mActivePhone.getCallForwardingIndicator();
    }

    public String getLine1Number() {
        return this.mActivePhone.getLine1Number();
    }

    public String getCdmaMin() {
        return this.mActivePhone.getCdmaMin();
    }

    public boolean isMinInfoReady() {
        return this.mActivePhone.isMinInfoReady();
    }

    public String getCdmaPrlVersion() {
        return this.mActivePhone.getCdmaPrlVersion();
    }

    public String getLine1AlphaTag() {
        return this.mActivePhone.getLine1AlphaTag();
    }

    public boolean setLine1Number(String alphaTag, String number, Message onComplete) {
        return this.mActivePhone.setLine1Number(alphaTag, number, onComplete);
    }

    public String getVoiceMailNumber() {
        return this.mActivePhone.getVoiceMailNumber();
    }

    public int getVoiceMessageCount() {
        return this.mActivePhone.getVoiceMessageCount();
    }

    public String getVoiceMailAlphaTag() {
        return this.mActivePhone.getVoiceMailAlphaTag();
    }

    public void setVoiceMailNumber(String alphaTag, String voiceMailNumber, Message onComplete) {
        this.mActivePhone.setVoiceMailNumber(alphaTag, voiceMailNumber, onComplete);
    }

    public void getCallForwardingOption(int commandInterfaceCFReason, Message onComplete) {
        this.mActivePhone.getCallForwardingOption(commandInterfaceCFReason, onComplete);
    }

    public void setCallForwardingOption(int commandInterfaceCFReason, int commandInterfaceCFAction, String dialingNumber, int timerSeconds, Message onComplete) {
        this.mActivePhone.setCallForwardingOption(commandInterfaceCFReason, commandInterfaceCFAction, dialingNumber, timerSeconds, onComplete);
    }

    public void getOutgoingCallerIdDisplay(Message onComplete) {
        this.mActivePhone.getOutgoingCallerIdDisplay(onComplete);
    }

    public void setOutgoingCallerIdDisplay(int commandInterfaceCLIRMode, Message onComplete) {
        this.mActivePhone.setOutgoingCallerIdDisplay(commandInterfaceCLIRMode, onComplete);
    }

    public void getCallWaiting(Message onComplete) {
        this.mActivePhone.getCallWaiting(onComplete);
    }

    public void setCallWaiting(boolean enable, Message onComplete) {
        this.mActivePhone.setCallWaiting(enable, onComplete);
    }

    public void getAvailableNetworks(Message response) {
        this.mActivePhone.getAvailableNetworks(response);
    }

    public void setNetworkSelectionModeAutomatic(Message response) {
        this.mActivePhone.setNetworkSelectionModeAutomatic(response);
    }

    public void getNetworkSelectionMode(Message response) {
        this.mActivePhone.getNetworkSelectionMode(response);
    }

    public void selectNetworkManually(OperatorInfo network, Message response) {
        this.mActivePhone.selectNetworkManually(network, response);
    }

    public void setPreferredNetworkType(int networkType, Message response) {
        this.mActivePhone.setPreferredNetworkType(networkType, response);
    }

    public void getPreferredNetworkType(Message response) {
        this.mActivePhone.getPreferredNetworkType(response);
    }

    public void getNeighboringCids(Message response) {
        this.mActivePhone.getNeighboringCids(response);
    }

    public void setOnPostDialCharacter(Handler h, int what, Object obj) {
        this.mActivePhone.setOnPostDialCharacter(h, what, obj);
    }

    public void setMute(boolean muted) {
        this.mActivePhone.setMute(muted);
    }

    public boolean getMute() {
        return this.mActivePhone.getMute();
    }

    public void setEchoSuppressionEnabled() {
        this.mActivePhone.setEchoSuppressionEnabled();
    }

    public void invokeOemRilRequestRaw(byte[] data, Message response) {
        this.mActivePhone.invokeOemRilRequestRaw(data, response);
    }

    public void invokeOemRilRequestStrings(String[] strings, Message response) {
        this.mActivePhone.invokeOemRilRequestStrings(strings, response);
    }

    public void getDataCallList(Message response) {
        this.mActivePhone.getDataCallList(response);
    }

    public void updateServiceLocation() {
        this.mActivePhone.updateServiceLocation();
    }

    public void enableLocationUpdates() {
        this.mActivePhone.enableLocationUpdates();
    }

    public void disableLocationUpdates() {
        this.mActivePhone.disableLocationUpdates();
    }

    public void setUnitTestMode(boolean f) {
        this.mActivePhone.setUnitTestMode(f);
    }

    public boolean getUnitTestMode() {
        return this.mActivePhone.getUnitTestMode();
    }

    public void setBandMode(int bandMode, Message response) {
        this.mActivePhone.setBandMode(bandMode, response);
    }

    public void queryAvailableBandMode(Message response) {
        this.mActivePhone.queryAvailableBandMode(response);
    }

    public boolean getDataRoamingEnabled() {
        return this.mActivePhone.getDataRoamingEnabled();
    }

    public void setDataRoamingEnabled(boolean enable) {
        this.mActivePhone.setDataRoamingEnabled(enable);
    }

    public boolean getDataEnabled() {
        return this.mActivePhone.getDataEnabled();
    }

    public void setDataEnabled(boolean enable) {
        this.mActivePhone.setDataEnabled(enable);
    }

    public void queryCdmaRoamingPreference(Message response) {
        this.mActivePhone.queryCdmaRoamingPreference(response);
    }

    public void setCdmaRoamingPreference(int cdmaRoamingType, Message response) {
        this.mActivePhone.setCdmaRoamingPreference(cdmaRoamingType, response);
    }

    public void setCdmaSubscription(int cdmaSubscriptionType, Message response) {
        this.mActivePhone.setCdmaSubscription(cdmaSubscriptionType, response);
    }

    public SimulatedRadioControl getSimulatedRadioControl() {
        return this.mActivePhone.getSimulatedRadioControl();
    }

    public boolean isDataConnectivityPossible() {
        return this.mActivePhone.isDataConnectivityPossible("default");
    }

    public boolean isDataConnectivityPossible(String apnType) {
        return this.mActivePhone.isDataConnectivityPossible(apnType);
    }

    public String getDeviceId() {
        return this.mActivePhone.getDeviceId();
    }

    public String getDeviceSvn() {
        return this.mActivePhone.getDeviceSvn();
    }

    public String getSubscriberId() {
        return this.mActivePhone.getSubscriberId();
    }

    public String getGroupIdLevel1() {
        return this.mActivePhone.getGroupIdLevel1();
    }

    public String getIccSerialNumber() {
        return this.mActivePhone.getIccSerialNumber();
    }

    public String getEsn() {
        return this.mActivePhone.getEsn();
    }

    public String getMeid() {
        return this.mActivePhone.getMeid();
    }

    public String getMsisdn() {
        return this.mActivePhone.getMsisdn();
    }

    public String getImei() {
        return this.mActivePhone.getImei();
    }

    public String getNai() {
        return this.mActivePhone.getNai();
    }

    public PhoneSubInfo getPhoneSubInfo() {
        return this.mActivePhone.getPhoneSubInfo();
    }

    public IccPhoneBookInterfaceManager getIccPhoneBookInterfaceManager() {
        return this.mActivePhone.getIccPhoneBookInterfaceManager();
    }

    public void setUiTTYMode(int uiTtyMode, Message onComplete) {
        this.mActivePhone.setUiTTYMode(uiTtyMode, onComplete);
    }

    public void setTTYMode(int ttyMode, Message onComplete) {
        this.mActivePhone.setTTYMode(ttyMode, onComplete);
    }

    public void queryTTYMode(Message onComplete) {
        this.mActivePhone.queryTTYMode(onComplete);
    }

    public void activateCellBroadcastSms(int activate, Message response) {
        this.mActivePhone.activateCellBroadcastSms(activate, response);
    }

    public void getCellBroadcastSmsConfig(Message response) {
        this.mActivePhone.getCellBroadcastSmsConfig(response);
    }

    public void setCellBroadcastSmsConfig(int[] configValuesArray, Message response) {
        this.mActivePhone.setCellBroadcastSmsConfig(configValuesArray, response);
    }

    public void notifyDataActivity() {
        this.mActivePhone.notifyDataActivity();
    }

    public void getSmscAddress(Message result) {
        this.mActivePhone.getSmscAddress(result);
    }

    public void setSmscAddress(String address, Message result) {
        this.mActivePhone.setSmscAddress(address, result);
    }

    public int getCdmaEriIconIndex() {
        return this.mActivePhone.getCdmaEriIconIndex();
    }

    public String getCdmaEriText() {
        return this.mActivePhone.getCdmaEriText();
    }

    public int getCdmaEriIconMode() {
        return this.mActivePhone.getCdmaEriIconMode();
    }

    public Phone getActivePhone() {
        return this.mActivePhone;
    }

    public void sendBurstDtmf(String dtmfString, int on, int off, Message onComplete) {
        this.mActivePhone.sendBurstDtmf(dtmfString, on, off, onComplete);
    }

    public void exitEmergencyCallbackMode() {
        this.mActivePhone.exitEmergencyCallbackMode();
    }

    public boolean needsOtaServiceProvisioning() {
        return this.mActivePhone.needsOtaServiceProvisioning();
    }

    public boolean isOtaSpNumber(String dialStr) {
        return this.mActivePhone.isOtaSpNumber(dialStr);
    }

    public void registerForCallWaiting(Handler h, int what, Object obj) {
        this.mActivePhone.registerForCallWaiting(h, what, obj);
    }

    public void unregisterForCallWaiting(Handler h) {
        this.mActivePhone.unregisterForCallWaiting(h);
    }

    public void registerForSignalInfo(Handler h, int what, Object obj) {
        this.mActivePhone.registerForSignalInfo(h, what, obj);
    }

    public void unregisterForSignalInfo(Handler h) {
        this.mActivePhone.unregisterForSignalInfo(h);
    }

    public void registerForDisplayInfo(Handler h, int what, Object obj) {
        this.mActivePhone.registerForDisplayInfo(h, what, obj);
    }

    public void unregisterForDisplayInfo(Handler h) {
        this.mActivePhone.unregisterForDisplayInfo(h);
    }

    public void registerForNumberInfo(Handler h, int what, Object obj) {
        this.mActivePhone.registerForNumberInfo(h, what, obj);
    }

    public void unregisterForNumberInfo(Handler h) {
        this.mActivePhone.unregisterForNumberInfo(h);
    }

    public void registerForRedirectedNumberInfo(Handler h, int what, Object obj) {
        this.mActivePhone.registerForRedirectedNumberInfo(h, what, obj);
    }

    public void unregisterForRedirectedNumberInfo(Handler h) {
        this.mActivePhone.unregisterForRedirectedNumberInfo(h);
    }

    public void registerForLineControlInfo(Handler h, int what, Object obj) {
        this.mActivePhone.registerForLineControlInfo(h, what, obj);
    }

    public void unregisterForLineControlInfo(Handler h) {
        this.mActivePhone.unregisterForLineControlInfo(h);
    }

    public void registerFoT53ClirlInfo(Handler h, int what, Object obj) {
        this.mActivePhone.registerFoT53ClirlInfo(h, what, obj);
    }

    public void unregisterForT53ClirInfo(Handler h) {
        this.mActivePhone.unregisterForT53ClirInfo(h);
    }

    public void registerForT53AudioControlInfo(Handler h, int what, Object obj) {
        this.mActivePhone.registerForT53AudioControlInfo(h, what, obj);
    }

    public void unregisterForT53AudioControlInfo(Handler h) {
        this.mActivePhone.unregisterForT53AudioControlInfo(h);
    }

    public void registerForRadioOffOrNotAvailable(Handler h, int what, Object obj) {
        this.mActivePhone.registerForRadioOffOrNotAvailable(h, what, obj);
    }

    public void unregisterForRadioOffOrNotAvailable(Handler h) {
        this.mActivePhone.unregisterForRadioOffOrNotAvailable(h);
    }

    public void setOnEcbModeExitResponse(Handler h, int what, Object obj) {
        this.mActivePhone.setOnEcbModeExitResponse(h, what, obj);
    }

    public void unsetOnEcbModeExitResponse(Handler h) {
        this.mActivePhone.unsetOnEcbModeExitResponse(h);
    }

    public boolean isCspPlmnEnabled() {
        return this.mActivePhone.isCspPlmnEnabled();
    }

    public IsimRecords getIsimRecords() {
        return this.mActivePhone.getIsimRecords();
    }

    public int getLteOnCdmaMode() {
        return this.mActivePhone.getLteOnCdmaMode();
    }

    public void setVoiceMessageWaiting(int line, int countWaiting) {
        this.mActivePhone.setVoiceMessageWaiting(line, countWaiting);
    }

    public UsimServiceTable getUsimServiceTable() {
        return this.mActivePhone.getUsimServiceTable();
    }

    public UiccCard getUiccCard() {
        return this.mActivePhone.getUiccCard();
    }

    public void nvReadItem(int itemID, Message response) {
        this.mActivePhone.nvReadItem(itemID, response);
    }

    public void nvWriteItem(int itemID, String itemValue, Message response) {
        this.mActivePhone.nvWriteItem(itemID, itemValue, response);
    }

    public void nvWriteCdmaPrl(byte[] preferredRoamingList, Message response) {
        this.mActivePhone.nvWriteCdmaPrl(preferredRoamingList, response);
    }

    public void nvResetConfig(int resetType, Message response) {
        this.mActivePhone.nvResetConfig(resetType, response);
    }

    public void dispose() {
        if (this.mActivePhone != null) {
            this.mActivePhone.unregisterForSimRecordsLoaded(this);
        }
        this.mCommandsInterface.unregisterForOn(this);
        this.mCommandsInterface.unregisterForVoiceRadioTechChanged(this);
        this.mCommandsInterface.unregisterForRilConnected(this);
    }

    public void removeReferences() {
        this.mActivePhone = null;
        this.mCommandsInterface = null;
    }

    public boolean updateCurrentCarrierInProvider() {
        if (this.mActivePhone instanceof CDMALTEPhone) {
            return ((CDMALTEPhone) this.mActivePhone).updateCurrentCarrierInProvider();
        }
        if (this.mActivePhone instanceof GSMPhone) {
            return ((GSMPhone) this.mActivePhone).updateCurrentCarrierInProvider();
        }
        loge("Phone object is not MultiSim. This should not hit!!!!");
        return false;
    }

    public void updateDataConnectionTracker() {
        logd("Updating Data Connection Tracker");
        if (this.mActivePhone instanceof CDMALTEPhone) {
            ((CDMALTEPhone) this.mActivePhone).updateDataConnectionTracker();
        } else if (this.mActivePhone instanceof GSMPhone) {
            ((GSMPhone) this.mActivePhone).updateDataConnectionTracker();
        } else {
            loge("Phone object is not MultiSim. This should not hit!!!!");
        }
    }

    public void setInternalDataEnabled(boolean enable) {
        setInternalDataEnabled(enable, null);
    }

    public boolean setInternalDataEnabledFlag(boolean enable) {
        if (this.mActivePhone instanceof CDMALTEPhone) {
            return ((CDMALTEPhone) this.mActivePhone).setInternalDataEnabledFlag(enable);
        }
        if (this.mActivePhone instanceof GSMPhone) {
            return ((GSMPhone) this.mActivePhone).setInternalDataEnabledFlag(enable);
        }
        loge("Phone object is not MultiSim. This should not hit!!!!");
        return false;
    }

    public void setInternalDataEnabled(boolean enable, Message onCompleteMsg) {
        if (this.mActivePhone instanceof CDMALTEPhone) {
            ((CDMALTEPhone) this.mActivePhone).setInternalDataEnabled(enable, onCompleteMsg);
        } else if (this.mActivePhone instanceof GSMPhone) {
            ((GSMPhone) this.mActivePhone).setInternalDataEnabled(enable, onCompleteMsg);
        } else {
            loge("Phone object is not MultiSim. This should not hit!!!!");
        }
    }

    public void registerForAllDataDisconnected(Handler h, int what, Object obj) {
        if (this.mActivePhone instanceof CDMALTEPhone) {
            ((CDMALTEPhone) this.mActivePhone).registerForAllDataDisconnected(h, what, obj);
        } else if (this.mActivePhone instanceof GSMPhone) {
            ((GSMPhone) this.mActivePhone).registerForAllDataDisconnected(h, what, obj);
        } else {
            loge("Phone object is not MultiSim. This should not hit!!!!");
        }
    }

    public void unregisterForAllDataDisconnected(Handler h) {
        if (this.mActivePhone instanceof CDMALTEPhone) {
            ((CDMALTEPhone) this.mActivePhone).unregisterForAllDataDisconnected(h);
        } else if (this.mActivePhone instanceof GSMPhone) {
            ((GSMPhone) this.mActivePhone).unregisterForAllDataDisconnected(h);
        } else {
            loge("Phone object is not MultiSim. This should not hit!!!!");
        }
    }

    public int getSubId() {
        return this.mActivePhone.getSubId();
    }

    public int getPhoneId() {
        return this.mActivePhone.getPhoneId();
    }

    public String[] getPcscfAddress(String apnType) {
        return this.mActivePhone.getPcscfAddress(apnType);
    }

    public void setImsRegistrationState(boolean registered) {
        logd("setImsRegistrationState - registered: " + registered);
        this.mActivePhone.setImsRegistrationState(registered);
        if (this.mActivePhone.getPhoneName().equals("GSM")) {
            this.mActivePhone.getServiceStateTracker().setImsRegistrationState(registered);
        } else if (this.mActivePhone.getPhoneName().equals("CDMA")) {
            this.mActivePhone.getServiceStateTracker().setImsRegistrationState(registered);
        }
    }

    public Phone getImsPhone() {
        return this.mActivePhone.getImsPhone();
    }

    public ImsPhone relinquishOwnershipOfImsPhone() {
        return null;
    }

    public void acquireOwnershipOfImsPhone(ImsPhone imsPhone) {
    }

    public int getVoicePhoneServiceState() {
        return this.mActivePhone.getVoicePhoneServiceState();
    }

    public boolean setOperatorBrandOverride(String brand) {
        return this.mActivePhone.setOperatorBrandOverride(brand);
    }

    public boolean setRoamingOverride(List<String> gsmRoamingList, List<String> gsmNonRoamingList, List<String> cdmaRoamingList, List<String> cdmaNonRoamingList) {
        return this.mActivePhone.setRoamingOverride(gsmRoamingList, gsmNonRoamingList, cdmaRoamingList, cdmaNonRoamingList);
    }

    public boolean isRadioAvailable() {
        return this.mCommandsInterface.getRadioState().isAvailable();
    }

    public void shutdownRadio() {
        this.mActivePhone.shutdownRadio();
    }

    public void setRadioCapability(RadioCapability rc, Message response) {
        this.mActivePhone.setRadioCapability(rc, response);
    }

    public int getRadioAccessFamily() {
        return this.mActivePhone.getRadioAccessFamily();
    }

    public int getSupportedRadioAccessFamily() {
        return this.mCommandsInterface.getSupportedRadioAccessFamily();
    }

    public void registerForRadioCapabilityChanged(Handler h, int what, Object obj) {
        this.mActivePhone.registerForRadioCapabilityChanged(h, what, obj);
    }

    public void unregisterForRadioCapabilityChanged(Handler h) {
        this.mActivePhone.unregisterForRadioCapabilityChanged(h);
    }

    public IccCardProxy getPhoneIccCardProxy() {
        return this.mIccCardProxy;
    }

    public boolean isImsRegistered() {
        return this.mActivePhone.isImsRegistered();
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        try {
            ((PhoneBase) this.mActivePhone).dump(fd, pw, args);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
        try {
            this.mPhoneSubInfoProxy.dump(fd, pw, args);
        } catch (Exception e2) {
            e2.printStackTrace();
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
        try {
            this.mIccCardProxy.dump(fd, pw, args);
        } catch (Exception e22) {
            e22.printStackTrace();
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
    }
}
