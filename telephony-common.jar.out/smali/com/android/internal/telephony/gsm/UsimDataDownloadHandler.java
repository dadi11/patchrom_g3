package com.android.internal.telephony.gsm;

import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.cat.ComprehensionTlvTag;
import com.android.internal.telephony.uicc.IccIoResult;
import com.android.internal.telephony.uicc.IccUtils;
import com.android.internal.telephony.uicc.UsimServiceTable;
import com.android.internal.telephony.uicc.UsimServiceTable.UsimService;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPart;

public class UsimDataDownloadHandler extends Handler {
    private static final int BER_SMS_PP_DOWNLOAD_TAG = 209;
    private static final int DEV_ID_NETWORK = 131;
    private static final int DEV_ID_UICC = 129;
    private static final int EVENT_SEND_ENVELOPE_RESPONSE = 2;
    private static final int EVENT_START_DATA_DOWNLOAD = 1;
    private static final int EVENT_WRITE_SMS_COMPLETE = 3;
    private static final String TAG = "UsimDataDownloadHandler";
    private final CommandsInterface mCi;

    public UsimDataDownloadHandler(CommandsInterface commandsInterface) {
        this.mCi = commandsInterface;
    }

    int handleUsimDataDownload(UsimServiceTable ust, SmsMessage smsMessage) {
        if (ust == null || !ust.isAvailable(UsimService.DATA_DL_VIA_SMS_PP)) {
            Rlog.d(TAG, "DATA_DL_VIA_SMS_PP service not available, storing message to UICC.");
            this.mCi.writeSmsToSim(EVENT_WRITE_SMS_COMPLETE, IccUtils.bytesToHexString(PhoneNumberUtils.networkPortionToCalledPartyBCDWithLength(smsMessage.getServiceCenterAddress())), IccUtils.bytesToHexString(smsMessage.getPdu()), obtainMessage(EVENT_WRITE_SMS_COMPLETE));
            return -1;
        }
        Rlog.d(TAG, "Received SMS-PP data download, sending to UICC.");
        return startDataDownload(smsMessage);
    }

    public int startDataDownload(SmsMessage smsMessage) {
        if (sendMessage(obtainMessage(EVENT_START_DATA_DOWNLOAD, smsMessage))) {
            return -1;
        }
        Rlog.e(TAG, "startDataDownload failed to send message to start data download.");
        return EVENT_SEND_ENVELOPE_RESPONSE;
    }

    private void handleDataDownload(SmsMessage smsMessage) {
        int i;
        int dcs = smsMessage.getDataCodingScheme();
        int pid = smsMessage.getProtocolIdentifier();
        byte[] pdu = smsMessage.getPdu();
        int scAddressLength = pdu[0] & PduHeaders.STORE_STATUS_ERROR_END;
        int tpduIndex = scAddressLength + EVENT_START_DATA_DOWNLOAD;
        int tpduLength = pdu.length - tpduIndex;
        int bodyLength = getEnvelopeBodyLength(scAddressLength, tpduLength);
        byte[] envelope = new byte[((bodyLength + EVENT_START_DATA_DOWNLOAD) + (bodyLength > 127 ? EVENT_SEND_ENVELOPE_RESPONSE : EVENT_START_DATA_DOWNLOAD))];
        int index = 0 + EVENT_START_DATA_DOWNLOAD;
        envelope[0] = (byte) -47;
        if (bodyLength > 127) {
            i = index + EVENT_START_DATA_DOWNLOAD;
            envelope[index] = (byte) -127;
        } else {
            i = index;
        }
        index = i + EVENT_START_DATA_DOWNLOAD;
        envelope[i] = (byte) bodyLength;
        i = index + EVENT_START_DATA_DOWNLOAD;
        envelope[index] = (byte) (ComprehensionTlvTag.DEVICE_IDENTITIES.value() | PduPart.P_Q);
        index = i + EVENT_START_DATA_DOWNLOAD;
        envelope[i] = (byte) 2;
        i = index + EVENT_START_DATA_DOWNLOAD;
        envelope[index] = (byte) -125;
        index = i + EVENT_START_DATA_DOWNLOAD;
        envelope[i] = (byte) -127;
        if (scAddressLength != 0) {
            i = index + EVENT_START_DATA_DOWNLOAD;
            envelope[index] = (byte) ComprehensionTlvTag.ADDRESS.value();
            index = i + EVENT_START_DATA_DOWNLOAD;
            envelope[i] = (byte) scAddressLength;
            System.arraycopy(pdu, EVENT_START_DATA_DOWNLOAD, envelope, index, scAddressLength);
            i = index + scAddressLength;
        } else {
            i = index;
        }
        index = i + EVENT_START_DATA_DOWNLOAD;
        envelope[i] = (byte) (ComprehensionTlvTag.SMS_TPDU.value() | PduPart.P_Q);
        if (tpduLength > 127) {
            i = index + EVENT_START_DATA_DOWNLOAD;
            envelope[index] = (byte) -127;
        } else {
            i = index;
        }
        index = i + EVENT_START_DATA_DOWNLOAD;
        envelope[i] = (byte) tpduLength;
        System.arraycopy(pdu, tpduIndex, envelope, index, tpduLength);
        if (index + tpduLength != envelope.length) {
            Rlog.e(TAG, "startDataDownload() calculated incorrect envelope length, aborting.");
            acknowledgeSmsWithError(PduHeaders.STORE_STATUS_ERROR_END);
            return;
        }
        String encodedEnvelope = IccUtils.bytesToHexString(envelope);
        CommandsInterface commandsInterface = this.mCi;
        Object obj = new int[EVENT_SEND_ENVELOPE_RESPONSE];
        obj[0] = dcs;
        obj[EVENT_START_DATA_DOWNLOAD] = pid;
        commandsInterface.sendEnvelopeWithStatus(encodedEnvelope, obtainMessage(EVENT_SEND_ENVELOPE_RESPONSE, obj));
    }

    private static int getEnvelopeBodyLength(int scAddressLength, int tpduLength) {
        int length = (tpduLength + 5) + (tpduLength > 127 ? EVENT_SEND_ENVELOPE_RESPONSE : EVENT_START_DATA_DOWNLOAD);
        if (scAddressLength != 0) {
            return (length + EVENT_SEND_ENVELOPE_RESPONSE) + scAddressLength;
        }
        return length;
    }

    private void sendSmsAckForEnvelopeResponse(IccIoResult response, int dcs, int pid) {
        boolean success;
        int sw1 = response.sw1;
        int sw2 = response.sw2;
        if ((sw1 == PduPart.P_SECURE && sw2 == 0) || sw1 == PduPart.P_SEC) {
            Rlog.d(TAG, "USIM data download succeeded: " + response.toString());
            success = true;
        } else if (sw1 == PduPart.P_CREATION_DATE && sw2 == 0) {
            Rlog.e(TAG, "USIM data download failed: Toolkit busy");
            acknowledgeSmsWithError(CommandsInterface.GSM_SMS_FAIL_CAUSE_USIM_APP_TOOLKIT_BUSY);
            return;
        } else if (sw1 == 98 || sw1 == 99) {
            Rlog.e(TAG, "USIM data download failed: " + response.toString());
            success = false;
        } else {
            Rlog.e(TAG, "Unexpected SW1/SW2 response from UICC: " + response.toString());
            success = false;
        }
        byte[] responseBytes = response.payload;
        if (responseBytes != null && responseBytes.length != 0) {
            byte[] smsAckPdu;
            int i;
            int i2;
            if (success) {
                smsAckPdu = new byte[(responseBytes.length + 5)];
                i = 0 + EVENT_START_DATA_DOWNLOAD;
                smsAckPdu[0] = (byte) 0;
                i2 = i + EVENT_START_DATA_DOWNLOAD;
                smsAckPdu[i] = (byte) 7;
            } else {
                smsAckPdu = new byte[(responseBytes.length + 6)];
                i = 0 + EVENT_START_DATA_DOWNLOAD;
                smsAckPdu[0] = (byte) 0;
                i2 = i + EVENT_START_DATA_DOWNLOAD;
                smsAckPdu[i] = (byte) -43;
                i = i2 + EVENT_START_DATA_DOWNLOAD;
                smsAckPdu[i2] = (byte) 7;
                i2 = i;
            }
            i = i2 + EVENT_START_DATA_DOWNLOAD;
            smsAckPdu[i2] = (byte) pid;
            i2 = i + EVENT_START_DATA_DOWNLOAD;
            smsAckPdu[i] = (byte) dcs;
            if (is7bitDcs(dcs)) {
                i = i2 + EVENT_START_DATA_DOWNLOAD;
                smsAckPdu[i2] = (byte) ((responseBytes.length * 8) / 7);
                i2 = i;
            } else {
                i = i2 + EVENT_START_DATA_DOWNLOAD;
                smsAckPdu[i2] = (byte) responseBytes.length;
                i2 = i;
            }
            System.arraycopy(responseBytes, 0, smsAckPdu, i2, responseBytes.length);
            this.mCi.acknowledgeIncomingGsmSmsWithPdu(success, IccUtils.bytesToHexString(smsAckPdu), null);
        } else if (success) {
            this.mCi.acknowledgeLastIncomingGsmSms(true, 0, null);
        } else {
            acknowledgeSmsWithError(CommandsInterface.GSM_SMS_FAIL_CAUSE_USIM_DATA_DOWNLOAD_ERROR);
        }
    }

    private void acknowledgeSmsWithError(int cause) {
        this.mCi.acknowledgeLastIncomingGsmSms(false, cause, null);
    }

    private static boolean is7bitDcs(int dcs) {
        return (dcs & PduPart.P_DEP_COMMENT) == 0 || (dcs & CallFailCause.DIAL_MODIFIED_TO_USSD) == CallFailCause.CALL_BARRED;
    }

    public void handleMessage(Message msg) {
        AsyncResult ar;
        switch (msg.what) {
            case EVENT_START_DATA_DOWNLOAD /*1*/:
                handleDataDownload((SmsMessage) msg.obj);
            case EVENT_SEND_ENVELOPE_RESPONSE /*2*/:
                ar = msg.obj;
                if (ar.exception != null) {
                    Rlog.e(TAG, "UICC Send Envelope failure, exception: " + ar.exception);
                    acknowledgeSmsWithError(CommandsInterface.GSM_SMS_FAIL_CAUSE_USIM_DATA_DOWNLOAD_ERROR);
                    return;
                }
                int[] dcsPid = (int[]) ar.userObj;
                sendSmsAckForEnvelopeResponse((IccIoResult) ar.result, dcsPid[0], dcsPid[EVENT_START_DATA_DOWNLOAD]);
            case EVENT_WRITE_SMS_COMPLETE /*3*/:
                ar = (AsyncResult) msg.obj;
                if (ar.exception == null) {
                    Rlog.d(TAG, "Successfully wrote SMS-PP message to UICC");
                    this.mCi.acknowledgeLastIncomingGsmSms(true, 0, null);
                    return;
                }
                Rlog.d(TAG, "Failed to write SMS-PP message to UICC", ar.exception);
                this.mCi.acknowledgeLastIncomingGsmSms(false, PduHeaders.STORE_STATUS_ERROR_END, null);
            default:
                Rlog.e(TAG, "Ignoring unexpected message, what=" + msg.what);
        }
    }
}
