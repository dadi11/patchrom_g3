package com.android.internal.telephony;

import android.app.ActivityThread;
import android.app.PendingIntent;
import android.content.Context;
import android.net.Uri;
import android.os.Binder;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.telephony.Rlog;
import android.telephony.SubscriptionInfo;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import com.android.internal.telephony.ISms.Stub;
import java.util.List;

public class UiccSmsController extends Stub {
    static final String LOG_TAG = "RIL_UiccSmsController";
    protected Phone[] mPhone;

    protected UiccSmsController(Phone[] phone) {
        this.mPhone = phone;
        if (ServiceManager.getService("isms") == null) {
            ServiceManager.addService("isms", this);
        }
    }

    public boolean updateMessageOnIccEf(String callingPackage, int index, int status, byte[] pdu) throws RemoteException {
        return updateMessageOnIccEfForSubscriber(getPreferredSmsSubscription(), callingPackage, index, status, pdu);
    }

    public boolean updateMessageOnIccEfForSubscriber(int subId, String callingPackage, int index, int status, byte[] pdu) throws RemoteException {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            return iccSmsIntMgr.updateMessageOnIccEf(callingPackage, index, status, pdu);
        }
        Rlog.e(LOG_TAG, "updateMessageOnIccEf iccSmsIntMgr is null for Subscription: " + subId);
        return false;
    }

    public boolean copyMessageToIccEf(String callingPackage, int status, byte[] pdu, byte[] smsc) throws RemoteException {
        return copyMessageToIccEfForSubscriber(getPreferredSmsSubscription(), callingPackage, status, pdu, smsc);
    }

    public boolean copyMessageToIccEfForSubscriber(int subId, String callingPackage, int status, byte[] pdu, byte[] smsc) throws RemoteException {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            return iccSmsIntMgr.copyMessageToIccEf(callingPackage, status, pdu, smsc);
        }
        Rlog.e(LOG_TAG, "copyMessageToIccEf iccSmsIntMgr is null for Subscription: " + subId);
        return false;
    }

    public List<SmsRawData> getAllMessagesFromIccEf(String callingPackage) throws RemoteException {
        return getAllMessagesFromIccEfForSubscriber(getPreferredSmsSubscription(), callingPackage);
    }

    public List<SmsRawData> getAllMessagesFromIccEfForSubscriber(int subId, String callingPackage) throws RemoteException {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            return iccSmsIntMgr.getAllMessagesFromIccEf(callingPackage);
        }
        Rlog.e(LOG_TAG, "getAllMessagesFromIccEf iccSmsIntMgr is null for Subscription: " + subId);
        return null;
    }

    public void sendData(String callingPackage, String destAddr, String scAddr, int destPort, byte[] data, PendingIntent sentIntent, PendingIntent deliveryIntent) {
        sendDataForSubscriber(getPreferredSmsSubscription(), callingPackage, destAddr, scAddr, destPort, data, sentIntent, deliveryIntent);
    }

    public void sendDataForSubscriber(int subId, String callingPackage, String destAddr, String scAddr, int destPort, byte[] data, PendingIntent sentIntent, PendingIntent deliveryIntent) {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            iccSmsIntMgr.sendData(callingPackage, destAddr, scAddr, destPort, data, sentIntent, deliveryIntent);
        } else {
            Rlog.e(LOG_TAG, "sendText iccSmsIntMgr is null for Subscription: " + subId);
        }
    }

    public void sendText(String callingPackage, String destAddr, String scAddr, String text, PendingIntent sentIntent, PendingIntent deliveryIntent) {
        sendTextForSubscriber(getPreferredSmsSubscription(), callingPackage, destAddr, scAddr, text, sentIntent, deliveryIntent);
    }

    public void sendTextForSubscriber(int subId, String callingPackage, String destAddr, String scAddr, String text, PendingIntent sentIntent, PendingIntent deliveryIntent) {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            iccSmsIntMgr.sendText(callingPackage, destAddr, scAddr, text, sentIntent, deliveryIntent);
        } else {
            Rlog.e(LOG_TAG, "sendText iccSmsIntMgr is null for Subscription: " + subId);
        }
    }

    public void sendMultipartText(String callingPackage, String destAddr, String scAddr, List<String> parts, List<PendingIntent> sentIntents, List<PendingIntent> deliveryIntents) throws RemoteException {
        sendMultipartTextForSubscriber(getPreferredSmsSubscription(), callingPackage, destAddr, scAddr, parts, sentIntents, deliveryIntents);
    }

    public void sendMultipartTextForSubscriber(int subId, String callingPackage, String destAddr, String scAddr, List<String> parts, List<PendingIntent> sentIntents, List<PendingIntent> deliveryIntents) throws RemoteException {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            iccSmsIntMgr.sendMultipartText(callingPackage, destAddr, scAddr, parts, sentIntents, deliveryIntents);
        } else {
            Rlog.e(LOG_TAG, "sendMultipartText iccSmsIntMgr is null for Subscription: " + subId);
        }
    }

    public boolean enableCellBroadcast(int messageIdentifier, int ranType) throws RemoteException {
        return enableCellBroadcastForSubscriber(getPreferredSmsSubscription(), messageIdentifier, ranType);
    }

    public boolean enableCellBroadcastForSubscriber(int subId, int messageIdentifier, int ranType) throws RemoteException {
        return enableCellBroadcastRangeForSubscriber(subId, messageIdentifier, messageIdentifier, ranType);
    }

    public boolean enableCellBroadcastRange(int startMessageId, int endMessageId, int ranType) throws RemoteException {
        return enableCellBroadcastRangeForSubscriber(getPreferredSmsSubscription(), startMessageId, endMessageId, ranType);
    }

    public boolean enableCellBroadcastRangeForSubscriber(int subId, int startMessageId, int endMessageId, int ranType) throws RemoteException {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            return iccSmsIntMgr.enableCellBroadcastRange(startMessageId, endMessageId, ranType);
        }
        Rlog.e(LOG_TAG, "enableCellBroadcast iccSmsIntMgr is null for Subscription: " + subId);
        return false;
    }

    public boolean disableCellBroadcast(int messageIdentifier, int ranType) throws RemoteException {
        return disableCellBroadcastForSubscriber(getPreferredSmsSubscription(), messageIdentifier, ranType);
    }

    public boolean disableCellBroadcastForSubscriber(int subId, int messageIdentifier, int ranType) throws RemoteException {
        return disableCellBroadcastRangeForSubscriber(subId, messageIdentifier, messageIdentifier, ranType);
    }

    public boolean disableCellBroadcastRange(int startMessageId, int endMessageId, int ranType) throws RemoteException {
        return disableCellBroadcastRangeForSubscriber(getPreferredSmsSubscription(), startMessageId, endMessageId, ranType);
    }

    public boolean disableCellBroadcastRangeForSubscriber(int subId, int startMessageId, int endMessageId, int ranType) throws RemoteException {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            return iccSmsIntMgr.disableCellBroadcastRange(startMessageId, endMessageId, ranType);
        }
        Rlog.e(LOG_TAG, "disableCellBroadcast iccSmsIntMgr is null for Subscription:" + subId);
        return false;
    }

    public int getPremiumSmsPermission(String packageName) {
        return getPremiumSmsPermissionForSubscriber(getPreferredSmsSubscription(), packageName);
    }

    public int getPremiumSmsPermissionForSubscriber(int subId, String packageName) {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            return iccSmsIntMgr.getPremiumSmsPermission(packageName);
        }
        Rlog.e(LOG_TAG, "getPremiumSmsPermission iccSmsIntMgr is null");
        return 0;
    }

    public void setPremiumSmsPermission(String packageName, int permission) {
        setPremiumSmsPermissionForSubscriber(getPreferredSmsSubscription(), packageName, permission);
    }

    public void setPremiumSmsPermissionForSubscriber(int subId, String packageName, int permission) {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            iccSmsIntMgr.setPremiumSmsPermission(packageName, permission);
        } else {
            Rlog.e(LOG_TAG, "setPremiumSmsPermission iccSmsIntMgr is null");
        }
    }

    public boolean isImsSmsSupported() {
        return isImsSmsSupportedForSubscriber(getPreferredSmsSubscription());
    }

    public boolean isImsSmsSupportedForSubscriber(int subId) {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            return iccSmsIntMgr.isImsSmsSupported();
        }
        Rlog.e(LOG_TAG, "isImsSmsSupported iccSmsIntMgr is null");
        return false;
    }

    public boolean isSmsSimPickActivityNeeded(int subId) {
        Context context = ActivityThread.currentApplication().getApplicationContext();
        TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService("phone");
        long identity = Binder.clearCallingIdentity();
        try {
            List<SubscriptionInfo> subInfoList = SubscriptionManager.from(context).getActiveSubscriptionInfoList();
            if (subInfoList == null) {
                return false;
            }
            int subInfoLength = subInfoList.size();
            for (int i = 0; i < subInfoLength; i++) {
                SubscriptionInfo sir = (SubscriptionInfo) subInfoList.get(i);
                if (sir != null && sir.getSubscriptionId() == subId) {
                    return false;
                }
            }
            if (subInfoLength <= 0 || telephonyManager.getSimCount() <= 1) {
                return false;
            }
            return true;
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
    }

    public String getImsSmsFormat() {
        return getImsSmsFormatForSubscriber(getPreferredSmsSubscription());
    }

    public String getImsSmsFormatForSubscriber(int subId) {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            return iccSmsIntMgr.getImsSmsFormat();
        }
        Rlog.e(LOG_TAG, "getImsSmsFormat iccSmsIntMgr is null");
        return null;
    }

    public void injectSmsPdu(byte[] pdu, String format, PendingIntent receivedIntent) {
        injectSmsPdu(SubscriptionManager.getDefaultSmsSubId(), pdu, format, receivedIntent);
    }

    public void injectSmsPdu(int subId, byte[] pdu, String format, PendingIntent receivedIntent) {
        getIccSmsInterfaceManager(subId).injectSmsPdu(pdu, format, receivedIntent);
    }

    private IccSmsInterfaceManager getIccSmsInterfaceManager(int subId) {
        int phoneId = SubscriptionController.getInstance().getPhoneId(subId);
        if (!SubscriptionManager.isValidPhoneId(phoneId) || phoneId == Integer.MAX_VALUE) {
            phoneId = 0;
        }
        try {
            return ((PhoneProxy) this.mPhone[phoneId]).getIccSmsInterfaceManager();
        } catch (NullPointerException e) {
            Rlog.e(LOG_TAG, "Exception is :" + e.toString() + " For subscription :" + subId);
            e.printStackTrace();
            return null;
        } catch (ArrayIndexOutOfBoundsException e2) {
            Rlog.e(LOG_TAG, "Exception is :" + e2.toString() + " For subscription :" + subId);
            e2.printStackTrace();
            return null;
        }
    }

    public int getPreferredSmsSubscription() {
        return SubscriptionController.getInstance().getDefaultSmsSubId();
    }

    public boolean isSMSPromptEnabled() {
        return PhoneFactory.isSMSPromptEnabled();
    }

    public void sendStoredText(int subId, String callingPkg, Uri messageUri, String scAddress, PendingIntent sentIntent, PendingIntent deliveryIntent) throws RemoteException {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            iccSmsIntMgr.sendStoredText(callingPkg, messageUri, scAddress, sentIntent, deliveryIntent);
        } else {
            Rlog.e(LOG_TAG, "sendStoredText iccSmsIntMgr is null for subscription: " + subId);
        }
    }

    public void sendStoredMultipartText(int subId, String callingPkg, Uri messageUri, String scAddress, List<PendingIntent> sentIntents, List<PendingIntent> deliveryIntents) throws RemoteException {
        IccSmsInterfaceManager iccSmsIntMgr = getIccSmsInterfaceManager(subId);
        if (iccSmsIntMgr != null) {
            iccSmsIntMgr.sendStoredMultipartText(callingPkg, messageUri, scAddress, sentIntents, deliveryIntents);
        } else {
            Rlog.e(LOG_TAG, "sendStoredMultipartText iccSmsIntMgr is null for subscription: " + subId);
        }
    }
}
