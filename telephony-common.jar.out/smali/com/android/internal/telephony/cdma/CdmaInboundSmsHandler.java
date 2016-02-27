package com.android.internal.telephony.cdma;

import android.content.Context;
import android.content.res.Resources;
import android.os.Message;
import android.os.SystemProperties;
import android.telephony.SmsCbMessage;
import com.android.internal.telephony.CellBroadcastHandler;
import com.android.internal.telephony.InboundSmsHandler;
import com.android.internal.telephony.InboundSmsTracker;
import com.android.internal.telephony.PhoneBase;
import com.android.internal.telephony.SmsConstants.MessageClass;
import com.android.internal.telephony.SmsMessageBase;
import com.android.internal.telephony.SmsStorageMonitor;
import com.android.internal.telephony.WspTypeDecoder;
import com.android.internal.telephony.cdma.sms.SmsEnvelope;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPersister;
import java.util.Arrays;

public class CdmaInboundSmsHandler extends InboundSmsHandler {
    private final boolean mCheckForDuplicatePortsInOmadmWapPush;
    private byte[] mLastAcknowledgedSmsFingerprint;
    private byte[] mLastDispatchedSmsFingerprint;
    private final CdmaServiceCategoryProgramHandler mServiceCategoryProgramHandler;
    private final CdmaSMSDispatcher mSmsDispatcher;

    private CdmaInboundSmsHandler(Context context, SmsStorageMonitor storageMonitor, PhoneBase phone, CdmaSMSDispatcher smsDispatcher) {
        super("CdmaInboundSmsHandler", context, storageMonitor, phone, CellBroadcastHandler.makeCellBroadcastHandler(context, phone));
        this.mCheckForDuplicatePortsInOmadmWapPush = Resources.getSystem().getBoolean(17956958);
        this.mSmsDispatcher = smsDispatcher;
        this.mServiceCategoryProgramHandler = CdmaServiceCategoryProgramHandler.makeScpHandler(context, phone.mCi);
        phone.mCi.setOnNewCdmaSms(getHandler(), 1, null);
    }

    protected void onQuitting() {
        this.mPhone.mCi.unSetOnNewCdmaSms(getHandler());
        this.mCellBroadcastHandler.dispose();
        log("unregistered for 3GPP2 SMS");
        super.onQuitting();
    }

    public static CdmaInboundSmsHandler makeInboundSmsHandler(Context context, SmsStorageMonitor storageMonitor, PhoneBase phone, CdmaSMSDispatcher smsDispatcher) {
        CdmaInboundSmsHandler handler = new CdmaInboundSmsHandler(context, storageMonitor, phone, smsDispatcher);
        handler.start();
        return handler;
    }

    private static boolean isInEmergencyCallMode() {
        return "true".equals(SystemProperties.get("ril.cdma.inecmmode", "false"));
    }

    protected boolean is3gpp2() {
        return true;
    }

    protected int dispatchMessageRadioSpecific(SmsMessageBase smsb) {
        if (isInEmergencyCallMode()) {
            return -1;
        }
        SmsMessage sms = (SmsMessage) smsb;
        if (1 == sms.getMessageType()) {
            log("Broadcast type message");
            SmsCbMessage cbMessage = sms.parseBroadcastSms();
            if (cbMessage != null) {
                this.mCellBroadcastHandler.dispatchSmsMessage(cbMessage);
                return 1;
            }
            loge("error trying to parse broadcast SMS");
            return 1;
        }
        this.mLastDispatchedSmsFingerprint = sms.getIncomingSmsFingerprint();
        if (this.mLastAcknowledgedSmsFingerprint != null && Arrays.equals(this.mLastDispatchedSmsFingerprint, this.mLastAcknowledgedSmsFingerprint)) {
            return 1;
        }
        sms.parseSms();
        int teleService = sms.getTeleService();
        switch (teleService) {
            case SmsEnvelope.TELESERVICE_WMT /*4098*/:
            case SmsEnvelope.TELESERVICE_WEMT /*4101*/:
                if (sms.isStatusReportMessage()) {
                    this.mSmsDispatcher.sendStatusReportMessage(sms);
                    return 1;
                }
                break;
            case SmsEnvelope.TELESERVICE_VMN /*4099*/:
            case SmsEnvelope.TELESERVICE_MWI /*262144*/:
                handleVoicemailTeleservice(sms);
                return 1;
            case SmsEnvelope.TELESERVICE_WAP /*4100*/:
                break;
            case SmsEnvelope.TELESERVICE_SCPT /*4102*/:
                this.mServiceCategoryProgramHandler.dispatchSmsMessage(sms);
                return 1;
            default:
                loge("unsupported teleservice 0x" + Integer.toHexString(teleService));
                return 4;
        }
        if (!this.mStorageMonitor.isStorageAvailable() && sms.getMessageClass() != MessageClass.CLASS_0) {
            return 3;
        }
        if (SmsEnvelope.TELESERVICE_WAP == teleService) {
            return processCdmaWapPdu(sms.getUserData(), sms.mMessageRef, sms.getOriginatingAddress(), sms.getTimestampMillis());
        }
        return dispatchNormalMessage(smsb);
    }

    protected void acknowledgeLastIncomingSms(boolean success, int result, Message response) {
        if (!isInEmergencyCallMode()) {
            int causeCode = resultToCause(result);
            this.mPhone.mCi.acknowledgeLastIncomingCdmaSms(success, causeCode, response);
            if (causeCode == 0) {
                this.mLastAcknowledgedSmsFingerprint = this.mLastDispatchedSmsFingerprint;
            }
            this.mLastDispatchedSmsFingerprint = null;
        }
    }

    protected void onUpdatePhoneObject(PhoneBase phone) {
        super.onUpdatePhoneObject(phone);
        this.mCellBroadcastHandler.updatePhoneObject(phone);
    }

    private static int resultToCause(int rc) {
        switch (rc) {
            case UiccCardApplication.AUTH_CONTEXT_UNDEFINED /*-1*/:
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return 0;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return 35;
            case CharacterSets.ISO_8859_1 /*4*/:
                return 4;
            default:
                return 96;
        }
    }

    private void handleVoicemailTeleservice(SmsMessage sms) {
        int voicemailCount = sms.getNumOfVoicemails();
        log("Voicemail count=" + voicemailCount);
        if (voicemailCount < 0) {
            voicemailCount = -1;
        } else if (voicemailCount > 99) {
            voicemailCount = 99;
        }
        this.mPhone.setVoiceMessageCount(voicemailCount);
        storeVoiceMailCount();
    }

    private int processCdmaWapPdu(byte[] pdu, int referenceNumber, String address, long timestamp) {
        int index = 0 + 1;
        int msgType = pdu[0] & PduHeaders.STORE_STATUS_ERROR_END;
        if (msgType != 0) {
            log("Received a WAP SMS which is not WDP. Discard.");
            int i = index;
            return 1;
        }
        i = index + 1;
        int totalSegments = pdu[index] & PduHeaders.STORE_STATUS_ERROR_END;
        index = i + 1;
        int segment = pdu[i] & PduHeaders.STORE_STATUS_ERROR_END;
        if (segment >= totalSegments) {
            loge("WDP bad segment #" + segment + " expecting 0-" + (totalSegments - 1));
            i = index;
            return 1;
        }
        byte[] userData;
        int sourcePort = 0;
        int destinationPort = 0;
        if (segment == 0) {
            i = index + 1;
            index = i + 1;
            sourcePort = ((pdu[index] & PduHeaders.STORE_STATUS_ERROR_END) << 8) | (pdu[i] & PduHeaders.STORE_STATUS_ERROR_END);
            i = index + 1;
            index = i + 1;
            destinationPort = ((pdu[index] & PduHeaders.STORE_STATUS_ERROR_END) << 8) | (pdu[i] & PduHeaders.STORE_STATUS_ERROR_END);
            if (this.mCheckForDuplicatePortsInOmadmWapPush && checkDuplicatePortOmadmWapPush(pdu, index)) {
                i = index + 4;
                log("Received WAP PDU. Type = " + msgType + ", originator = " + address + ", src-port = " + sourcePort + ", dst-port = " + destinationPort + ", ID = " + referenceNumber + ", segment# = " + segment + '/' + totalSegments);
                userData = new byte[(pdu.length - i)];
                System.arraycopy(pdu, i, userData, 0, pdu.length - i);
                return addTrackerToRawTableAndSendMessage(new InboundSmsTracker(userData, timestamp, destinationPort, true, address, referenceNumber, segment, totalSegments, true));
            }
        }
        i = index;
        log("Received WAP PDU. Type = " + msgType + ", originator = " + address + ", src-port = " + sourcePort + ", dst-port = " + destinationPort + ", ID = " + referenceNumber + ", segment# = " + segment + '/' + totalSegments);
        userData = new byte[(pdu.length - i)];
        System.arraycopy(pdu, i, userData, 0, pdu.length - i);
        return addTrackerToRawTableAndSendMessage(new InboundSmsTracker(userData, timestamp, destinationPort, true, address, referenceNumber, segment, totalSegments, true));
    }

    private static boolean checkDuplicatePortOmadmWapPush(byte[] origPdu, int index) {
        index += 4;
        byte[] omaPdu = new byte[(origPdu.length - index)];
        System.arraycopy(origPdu, index, omaPdu, 0, omaPdu.length);
        WspTypeDecoder pduDecoder = new WspTypeDecoder(omaPdu);
        if (!pduDecoder.decodeUintvarInteger(2) || !pduDecoder.decodeContentType(2 + pduDecoder.getDecodedDataLength())) {
            return false;
        }
        return WspTypeDecoder.CONTENT_TYPE_B_PUSH_SYNCML_NOTI.equals(pduDecoder.getValueString());
    }
}
