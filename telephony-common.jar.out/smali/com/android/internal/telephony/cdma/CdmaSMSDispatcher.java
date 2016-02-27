package com.android.internal.telephony.cdma;

import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.content.Intent;
import android.net.Uri;
import android.os.Message;
import android.os.SystemProperties;
import android.provider.Telephony.CellBroadcasts;
import android.telephony.Rlog;
import android.telephony.SmsMessage;
import com.android.internal.telephony.GsmAlphabet.TextEncodingDetails;
import com.android.internal.telephony.ImsSMSDispatcher;
import com.android.internal.telephony.PhoneBase;
import com.android.internal.telephony.PhoneConstants.State;
import com.android.internal.telephony.SMSDispatcher;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.SmsUsageMonitor;
import com.android.internal.telephony.cdma.SmsMessage.SubmitPdu;
import com.android.internal.telephony.cdma.sms.UserData;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

public class CdmaSMSDispatcher extends SMSDispatcher {
    private static final String TAG = "CdmaSMSDispatcher";
    private static final boolean VDBG = false;

    public CdmaSMSDispatcher(PhoneBase phone, SmsUsageMonitor usageMonitor, ImsSMSDispatcher imsSMSDispatcher) {
        super(phone, usageMonitor, imsSMSDispatcher);
        Rlog.d(TAG, "CdmaSMSDispatcher created");
    }

    protected String getFormat() {
        return SmsMessage.FORMAT_3GPP2;
    }

    void sendStatusReportMessage(SmsMessage sms) {
        sendMessage(obtainMessage(10, sms));
    }

    protected void handleStatusReport(Object o) {
        if (o instanceof SmsMessage) {
            handleCdmaStatusReport((SmsMessage) o);
        } else {
            Rlog.e(TAG, "handleStatusReport() called for object type " + o.getClass().getName());
        }
    }

    void handleCdmaStatusReport(SmsMessage sms) {
        int count = this.deliveryPendingList.size();
        for (int i = 0; i < count; i++) {
            SmsTracker tracker = (SmsTracker) this.deliveryPendingList.get(i);
            if (tracker.mMessageRef == sms.mMessageRef) {
                this.deliveryPendingList.remove(i);
                tracker.updateSentMessageStatus(this.mContext, 0);
                PendingIntent intent = tracker.mDeliveryIntent;
                Intent fillIn = new Intent();
                fillIn.putExtra("pdu", sms.getPdu());
                fillIn.putExtra(CellBroadcasts.MESSAGE_FORMAT, getFormat());
                try {
                    intent.send(this.mContext, -1, fillIn);
                    return;
                } catch (CanceledException e) {
                    return;
                }
            }
        }
    }

    protected void sendData(String destAddr, String scAddr, int destPort, byte[] data, PendingIntent sentIntent, PendingIntent deliveryIntent) {
        SmsTracker tracker = getSmsTracker(getSmsTrackerMap(destAddr, scAddr, destPort, data, SmsMessage.getSubmitPdu(scAddr, destAddr, destPort, data, deliveryIntent != null)), sentIntent, deliveryIntent, getFormat(), null, false, null, false);
        String carrierPackage = getCarrierAppPackageName();
        if (carrierPackage != null) {
            Rlog.d(TAG, "Found carrier package.");
            SmsSender dataSmsSender = new DataSmsSender(tracker);
            dataSmsSender.sendSmsByCarrierApp(carrierPackage, new SmsSenderCallback(dataSmsSender));
            return;
        }
        Rlog.v(TAG, "No carrier package.");
        sendSubmitPdu(tracker);
    }

    protected void sendText(String destAddr, String scAddr, String text, PendingIntent sentIntent, PendingIntent deliveryIntent, Uri messageUri, String callingPkg) {
        SubmitPdu pdu = SmsMessage.getSubmitPdu(scAddr, destAddr, text, deliveryIntent != null, null);
        if (pdu != null) {
            SmsTracker tracker = getSmsTracker(getSmsTrackerMap(destAddr, scAddr, text, pdu), sentIntent, deliveryIntent, getFormat(), messageUri, false, text, true);
            String carrierPackage = getCarrierAppPackageName();
            if (carrierPackage != null) {
                Rlog.d(TAG, "Found carrier package.");
                TextSmsSender smsSender = new TextSmsSender(tracker);
                smsSender.sendSmsByCarrierApp(carrierPackage, new SmsSenderCallback(smsSender));
                return;
            }
            Rlog.v(TAG, "No carrier package.");
            sendSubmitPdu(tracker);
            return;
        }
        Rlog.e(TAG, "CdmaSMSDispatcher.sendText(): getSubmitPdu() returned null");
    }

    protected void injectSmsPdu(byte[] pdu, String format, PendingIntent receivedIntent) {
        throw new IllegalStateException("This method must be called only on ImsSMSDispatcher");
    }

    protected TextEncodingDetails calculateLength(CharSequence messageBody, boolean use7bitOnly) {
        return SmsMessage.calculateLength(messageBody, use7bitOnly, false);
    }

    protected SmsTracker getNewSubmitPduTracker(String destinationAddress, String scAddress, String message, SmsHeader smsHeader, int encoding, PendingIntent sentIntent, PendingIntent deliveryIntent, boolean lastPart, AtomicInteger unsentPartCount, AtomicBoolean anyPartFailed, Uri messageUri, String fullMessageText) {
        UserData uData = new UserData();
        uData.payloadStr = message;
        uData.userDataHeader = smsHeader;
        if (encoding == 1) {
            uData.msgEncoding = 9;
        } else {
            uData.msgEncoding = 4;
        }
        uData.msgEncodingSet = true;
        boolean z = deliveryIntent != null && lastPart;
        return getSmsTracker(getSmsTrackerMap(destinationAddress, scAddress, message, SmsMessage.getSubmitPdu(destinationAddress, uData, z)), sentIntent, deliveryIntent, getFormat(), unsentPartCount, anyPartFailed, messageUri, smsHeader, false, fullMessageText, true);
    }

    protected void sendSubmitPdu(SmsTracker tracker) {
        if (SystemProperties.getBoolean("ril.cdma.inecmmode", false)) {
            tracker.onFailed(this.mContext, 4, 0);
        } else {
            sendRawPdu(tracker);
        }
    }

    protected void sendSms(SmsTracker tracker) {
        byte[] pdu = (byte[]) tracker.mData.get("pdu");
        Rlog.d(TAG, "sendSms:  isIms()=" + isIms() + " mRetryCount=" + tracker.mRetryCount + " mImsRetry=" + tracker.mImsRetry + " mMessageRef=" + tracker.mMessageRef + " SS=" + this.mPhone.getServiceState().getState());
        sendSmsByPstn(tracker);
    }

    protected void sendSmsByPstn(SmsTracker tracker) {
        boolean imsSmsDisabled = false;
        int ss = this.mPhone.getServiceState().getState();
        if (isIms() || ss == 0) {
            Message reply = obtainMessage(2, tracker);
            byte[] pdu = (byte[]) tracker.mData.get("pdu");
            int currentDataNetwork = this.mPhone.getServiceState().getDataNetworkType();
            if ((currentDataNetwork == 14 || (currentDataNetwork == 13 && !this.mPhone.getServiceStateTracker().isConcurrentVoiceAndDataAllowed())) && this.mPhone.getServiceState().getVoiceNetworkType() == 7 && ((CDMAPhone) this.mPhone).mCT.mState != State.IDLE) {
                imsSmsDisabled = true;
            }
            if ((tracker.mImsRetry != 0 || isIms()) && !imsSmsDisabled) {
                this.mCi.sendImsCdmaSms(pdu, tracker.mImsRetry, tracker.mMessageRef, reply);
                tracker.mImsRetry++;
                return;
            }
            this.mCi.sendCdmaSms(pdu, reply);
            return;
        }
        tracker.onFailed(this.mContext, SMSDispatcher.getNotInServiceError(ss), 0);
    }
}
