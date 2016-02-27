package com.android.internal.telephony;

import android.app.AppOpsManager;
import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteException;
import android.net.Uri;
import android.os.AsyncResult;
import android.os.Binder;
import android.os.Handler;
import android.os.Message;
import android.os.UserManager;
import android.provider.Telephony.Carriers;
import android.provider.Telephony.TextBasedSmsColumns;
import android.telephony.Rlog;
import android.telephony.SmsManager;
import android.telephony.SmsMessage;
import android.util.Log;
import com.android.internal.telephony.cdma.CdmaSmsBroadcastConfigInfo;
import com.android.internal.telephony.gsm.SmsBroadcastConfigInfo;
import com.android.internal.telephony.uicc.IccConstants;
import com.android.internal.telephony.uicc.IccFileHandler;
import com.android.internal.telephony.uicc.UiccController;
import com.android.internal.util.HexDump;
import com.google.android.mms.pdu.PduHeaders;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class IccSmsInterfaceManager {
    static final boolean DBG = true;
    private static final int EVENT_LOAD_DONE = 1;
    protected static final int EVENT_SET_BROADCAST_ACTIVATION_DONE = 3;
    protected static final int EVENT_SET_BROADCAST_CONFIG_DONE = 4;
    private static final int EVENT_UPDATE_DONE = 2;
    static final String LOG_TAG = "IccSmsInterfaceManager";
    private static final int SMS_CB_CODE_SCHEME_MAX = 255;
    private static final int SMS_CB_CODE_SCHEME_MIN = 0;
    protected final AppOpsManager mAppOps;
    private CdmaBroadcastRangeManager mCdmaBroadcastRangeManager;
    private CellBroadcastRangeManager mCellBroadcastRangeManager;
    protected final Context mContext;
    protected SMSDispatcher mDispatcher;
    protected Handler mHandler;
    protected final Object mLock;
    protected PhoneBase mPhone;
    private List<SmsRawData> mSms;
    protected boolean mSuccess;
    private final UserManager mUserManager;

    /* renamed from: com.android.internal.telephony.IccSmsInterfaceManager.1 */
    class C00111 extends Handler {
        C00111() {
        }

        public void handleMessage(Message msg) {
            boolean z = IccSmsInterfaceManager.DBG;
            AsyncResult ar;
            IccSmsInterfaceManager iccSmsInterfaceManager;
            switch (msg.what) {
                case IccSmsInterfaceManager.EVENT_LOAD_DONE /*1*/:
                    ar = (AsyncResult) msg.obj;
                    synchronized (IccSmsInterfaceManager.this.mLock) {
                        if (ar.exception != null) {
                            if (Rlog.isLoggable("SMS", IccSmsInterfaceManager.EVENT_SET_BROADCAST_ACTIVATION_DONE)) {
                                IccSmsInterfaceManager.this.log("Cannot load Sms records");
                            }
                            if (IccSmsInterfaceManager.this.mSms != null) {
                                IccSmsInterfaceManager.this.mSms.clear();
                            }
                            break;
                        }
                        IccSmsInterfaceManager.this.mSms = IccSmsInterfaceManager.this.buildValidRawData((ArrayList) ar.result);
                        IccSmsInterfaceManager.this.markMessagesAsRead((ArrayList) ar.result);
                        IccSmsInterfaceManager.this.mLock.notifyAll();
                        break;
                    }
                case IccSmsInterfaceManager.EVENT_UPDATE_DONE /*2*/:
                    ar = msg.obj;
                    synchronized (IccSmsInterfaceManager.this.mLock) {
                        iccSmsInterfaceManager = IccSmsInterfaceManager.this;
                        if (ar.exception != null) {
                            z = false;
                        }
                        iccSmsInterfaceManager.mSuccess = z;
                        IccSmsInterfaceManager.this.mLock.notifyAll();
                        break;
                    }
                case IccSmsInterfaceManager.EVENT_SET_BROADCAST_ACTIVATION_DONE /*3*/:
                case IccSmsInterfaceManager.EVENT_SET_BROADCAST_CONFIG_DONE /*4*/:
                    ar = (AsyncResult) msg.obj;
                    synchronized (IccSmsInterfaceManager.this.mLock) {
                        iccSmsInterfaceManager = IccSmsInterfaceManager.this;
                        if (ar.exception != null) {
                            z = false;
                        }
                        iccSmsInterfaceManager.mSuccess = z;
                        IccSmsInterfaceManager.this.mLock.notifyAll();
                        break;
                    }
                default:
            }
        }
    }

    class CdmaBroadcastRangeManager extends IntRangeManager {
        private ArrayList<CdmaSmsBroadcastConfigInfo> mConfigList;

        CdmaBroadcastRangeManager() {
            this.mConfigList = new ArrayList();
        }

        protected void startUpdate() {
            this.mConfigList.clear();
        }

        protected void addRange(int startId, int endId, boolean selected) {
            this.mConfigList.add(new CdmaSmsBroadcastConfigInfo(startId, endId, IccSmsInterfaceManager.EVENT_LOAD_DONE, selected));
        }

        protected boolean finishUpdate() {
            if (this.mConfigList.isEmpty()) {
                return IccSmsInterfaceManager.DBG;
            }
            return IccSmsInterfaceManager.this.setCdmaBroadcastConfig((CdmaSmsBroadcastConfigInfo[]) this.mConfigList.toArray(new CdmaSmsBroadcastConfigInfo[this.mConfigList.size()]));
        }
    }

    class CellBroadcastRangeManager extends IntRangeManager {
        private ArrayList<SmsBroadcastConfigInfo> mConfigList;

        CellBroadcastRangeManager() {
            this.mConfigList = new ArrayList();
        }

        protected void startUpdate() {
            this.mConfigList.clear();
        }

        protected void addRange(int startId, int endId, boolean selected) {
            this.mConfigList.add(new SmsBroadcastConfigInfo(startId, endId, 0, IccSmsInterfaceManager.SMS_CB_CODE_SCHEME_MAX, selected));
        }

        protected boolean finishUpdate() {
            if (this.mConfigList.isEmpty()) {
                return IccSmsInterfaceManager.DBG;
            }
            return IccSmsInterfaceManager.this.setCellBroadcastConfig((SmsBroadcastConfigInfo[]) this.mConfigList.toArray(new SmsBroadcastConfigInfo[this.mConfigList.size()]));
        }
    }

    private boolean isFailedOrDraft(android.content.ContentResolver r14, android.net.Uri r15) {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxRuntimeException: Can't find block by offset: 0x004e in list []
	at jadx.core.utils.BlockUtils.getBlockByOffset(BlockUtils.java:42)
	at jadx.core.dex.instructions.IfNode.initBlocks(IfNode.java:58)
	at jadx.core.dex.visitors.blocksmaker.BlockFinish.initBlocksInIfNodes(BlockFinish.java:48)
	at jadx.core.dex.visitors.blocksmaker.BlockFinish.visit(BlockFinish.java:33)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
        /*
        r13 = this;
        r12 = 1;
        r11 = 0;
        r8 = android.os.Binder.clearCallingIdentity();
        r6 = 0;
        r0 = 1;
        r2 = new java.lang.String[r0];	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r0 = 0;	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r1 = "type";	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r2[r0] = r1;	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r3 = 0;	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r4 = 0;	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r5 = 0;	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r0 = r14;	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r1 = r15;	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r6 = r0.query(r1, r2, r3, r4, r5);	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        if (r6 == 0) goto L_0x0037;	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
    L_0x001a:
        r0 = r6.moveToFirst();	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        if (r0 == 0) goto L_0x0037;	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
    L_0x0020:
        r0 = 0;	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r10 = r6.getInt(r0);	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r0 = 3;
        if (r10 == r0) goto L_0x002b;
    L_0x0028:
        r0 = 5;
        if (r10 != r0) goto L_0x0035;
    L_0x002b:
        r0 = r12;
    L_0x002c:
        if (r6 == 0) goto L_0x0031;
    L_0x002e:
        r6.close();
    L_0x0031:
        android.os.Binder.restoreCallingIdentity(r8);
    L_0x0034:
        return r0;
    L_0x0035:
        r0 = r11;
        goto L_0x002c;
    L_0x0037:
        if (r6 == 0) goto L_0x003c;
    L_0x0039:
        r6.close();
    L_0x003c:
        android.os.Binder.restoreCallingIdentity(r8);
    L_0x003f:
        r0 = r11;
        goto L_0x0034;
    L_0x0041:
        r7 = move-exception;
        r0 = "IccSmsInterfaceManager";	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        r1 = "[IccSmsInterfaceManager]isFailedOrDraft: query message type failed";	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        android.util.Log.e(r0, r1, r7);	 Catch:{ SQLiteException -> 0x0041, all -> 0x0052 }
        if (r6 == 0) goto L_0x004e;
    L_0x004b:
        r6.close();
    L_0x004e:
        android.os.Binder.restoreCallingIdentity(r8);
        goto L_0x003f;
    L_0x0052:
        r0 = move-exception;
        if (r6 == 0) goto L_0x0058;
    L_0x0055:
        r6.close();
    L_0x0058:
        android.os.Binder.restoreCallingIdentity(r8);
        throw r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.IccSmsInterfaceManager.isFailedOrDraft(android.content.ContentResolver, android.net.Uri):boolean");
    }

    protected IccSmsInterfaceManager(PhoneBase phone) {
        this.mLock = new Object();
        this.mCellBroadcastRangeManager = new CellBroadcastRangeManager();
        this.mCdmaBroadcastRangeManager = new CdmaBroadcastRangeManager();
        this.mHandler = new C00111();
        this.mPhone = phone;
        this.mContext = phone.getContext();
        this.mAppOps = (AppOpsManager) this.mContext.getSystemService("appops");
        this.mUserManager = (UserManager) this.mContext.getSystemService(Carriers.USER);
        this.mDispatcher = new ImsSMSDispatcher(phone, phone.mSmsStorageMonitor, phone.mSmsUsageMonitor);
    }

    protected void markMessagesAsRead(ArrayList<byte[]> messages) {
        if (messages != null) {
            IccFileHandler fh = this.mPhone.getIccFileHandler();
            if (fh != null) {
                int count = messages.size();
                for (int i = 0; i < count; i += EVENT_LOAD_DONE) {
                    byte[] ba = (byte[]) messages.get(i);
                    if (ba[0] == (byte) 3) {
                        int n = ba.length;
                        byte[] nba = new byte[(n - 1)];
                        System.arraycopy(ba, EVENT_LOAD_DONE, nba, 0, n - 1);
                        fh.updateEFLinearFixed(IccConstants.EF_SMS, i + EVENT_LOAD_DONE, makeSmsRecordData(EVENT_LOAD_DONE, nba), null, null);
                        if (Rlog.isLoggable("SMS", EVENT_SET_BROADCAST_ACTIVATION_DONE)) {
                            log("SMS " + (i + EVENT_LOAD_DONE) + " marked as read");
                        }
                    }
                }
            } else if (Rlog.isLoggable("SMS", EVENT_SET_BROADCAST_ACTIVATION_DONE)) {
                log("markMessagesAsRead - aborting, no icc card present.");
            }
        }
    }

    protected void updatePhoneObject(PhoneBase phone) {
        this.mPhone = phone;
        this.mDispatcher.updatePhoneObject(phone);
    }

    protected void enforceReceiveAndSend(String message) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.RECEIVE_SMS", message);
        this.mContext.enforceCallingOrSelfPermission("android.permission.SEND_SMS", message);
    }

    public boolean updateMessageOnIccEf(String callingPackage, int index, int status, byte[] pdu) {
        log("updateMessageOnIccEf: index=" + index + " status=" + status + " ==> " + "(" + Arrays.toString(pdu) + ")");
        enforceReceiveAndSend("Updating message on Icc");
        if (this.mAppOps.noteOp(22, Binder.getCallingUid(), callingPackage) != 0) {
            return false;
        }
        synchronized (this.mLock) {
            this.mSuccess = false;
            Message response = this.mHandler.obtainMessage(EVENT_UPDATE_DONE);
            if (status != 0) {
                IccFileHandler fh = this.mPhone.getIccFileHandler();
                if (fh == null) {
                    response.recycle();
                    boolean z = this.mSuccess;
                    return z;
                }
                fh.updateEFLinearFixed(IccConstants.EF_SMS, index, makeSmsRecordData(status, pdu), null, response);
            } else if (EVENT_LOAD_DONE == this.mPhone.getPhoneType()) {
                this.mPhone.mCi.deleteSmsOnSim(index, response);
            } else {
                this.mPhone.mCi.deleteSmsOnRuim(index, response);
            }
            try {
                this.mLock.wait();
            } catch (InterruptedException e) {
                log("interrupted while trying to update by index");
            }
            return this.mSuccess;
        }
    }

    public boolean copyMessageToIccEf(String callingPackage, int status, byte[] pdu, byte[] smsc) {
        log("copyMessageToIccEf: status=" + status + " ==> " + "pdu=(" + Arrays.toString(pdu) + "), smsc=(" + Arrays.toString(smsc) + ")");
        enforceReceiveAndSend("Copying message to Icc");
        if (this.mAppOps.noteOp(22, Binder.getCallingUid(), callingPackage) != 0) {
            return false;
        }
        synchronized (this.mLock) {
            this.mSuccess = false;
            Message response = this.mHandler.obtainMessage(EVENT_UPDATE_DONE);
            if (EVENT_LOAD_DONE == this.mPhone.getPhoneType()) {
                this.mPhone.mCi.writeSmsToSim(status, IccUtils.bytesToHexString(smsc), IccUtils.bytesToHexString(pdu), response);
            } else {
                this.mPhone.mCi.writeSmsToRuim(status, IccUtils.bytesToHexString(pdu), response);
            }
            try {
                this.mLock.wait();
            } catch (InterruptedException e) {
                log("interrupted while trying to update by index");
            }
        }
        return this.mSuccess;
    }

    public List<SmsRawData> getAllMessagesFromIccEf(String callingPackage) {
        log("getAllMessagesFromEF");
        this.mContext.enforceCallingOrSelfPermission("android.permission.RECEIVE_SMS", "Reading messages from Icc");
        if (this.mAppOps.noteOp(21, Binder.getCallingUid(), callingPackage) != 0) {
            return new ArrayList();
        }
        synchronized (this.mLock) {
            IccFileHandler fh = this.mPhone.getIccFileHandler();
            if (fh == null) {
                Rlog.e(LOG_TAG, "Cannot load Sms records. No icc card?");
                if (this.mSms != null) {
                    this.mSms.clear();
                    List<SmsRawData> list = this.mSms;
                    return list;
                }
            }
            fh.loadEFLinearFixedAll(IccConstants.EF_SMS, this.mHandler.obtainMessage(EVENT_LOAD_DONE));
            try {
                this.mLock.wait();
            } catch (InterruptedException e) {
                log("interrupted while trying to load from the Icc");
            }
            return this.mSms;
        }
    }

    public void sendData(String callingPackage, String destAddr, String scAddr, int destPort, byte[] data, PendingIntent sentIntent, PendingIntent deliveryIntent) {
        this.mPhone.getContext().enforceCallingPermission("android.permission.SEND_SMS", "Sending SMS message");
        if (Rlog.isLoggable("SMS", EVENT_UPDATE_DONE)) {
            log("sendData: destAddr=" + destAddr + " scAddr=" + scAddr + " destPort=" + destPort + " data='" + HexDump.toHexString(data) + "' sentIntent=" + sentIntent + " deliveryIntent=" + deliveryIntent);
        }
        if (this.mAppOps.noteOp(20, Binder.getCallingUid(), callingPackage) == 0) {
            this.mDispatcher.sendData(filterDestAddress(destAddr), scAddr, destPort, data, sentIntent, deliveryIntent);
        }
    }

    public void sendText(String callingPackage, String destAddr, String scAddr, String text, PendingIntent sentIntent, PendingIntent deliveryIntent) {
        this.mPhone.getContext().enforceCallingPermission("android.permission.SEND_SMS", "Sending SMS message");
        if (Rlog.isLoggable("SMS", EVENT_UPDATE_DONE)) {
            log("sendText: destAddr=" + destAddr + " scAddr=" + scAddr + " text='" + text + "' sentIntent=" + sentIntent + " deliveryIntent=" + deliveryIntent);
        }
        if (this.mAppOps.noteOp(20, Binder.getCallingUid(), callingPackage) == 0) {
            this.mDispatcher.sendText(filterDestAddress(destAddr), scAddr, text, sentIntent, deliveryIntent, null, callingPackage);
        }
    }

    public void injectSmsPdu(byte[] pdu, String format, PendingIntent receivedIntent) {
        enforceCarrierPrivilege();
        if (Rlog.isLoggable("SMS", EVENT_UPDATE_DONE)) {
            log("pdu: " + pdu + "\n format=" + format + "\n receivedIntent=" + receivedIntent);
        }
        this.mDispatcher.injectSmsPdu(pdu, format, receivedIntent);
    }

    public void sendMultipartText(String callingPackage, String destAddr, String scAddr, List<String> parts, List<PendingIntent> sentIntents, List<PendingIntent> deliveryIntents) {
        int i;
        this.mPhone.getContext().enforceCallingPermission("android.permission.SEND_SMS", "Sending SMS message");
        if (Rlog.isLoggable("SMS", EVENT_UPDATE_DONE)) {
            i = 0;
            for (String part : parts) {
                int i2 = i + EVENT_LOAD_DONE;
                log("sendMultipartText: destAddr=" + destAddr + ", srAddr=" + scAddr + ", part[" + i + "]=" + part);
                i = i2;
            }
        }
        if (this.mAppOps.noteOp(20, Binder.getCallingUid(), callingPackage) == 0) {
            destAddr = filterDestAddress(destAddr);
            if (parts.size() <= EVENT_LOAD_DONE || parts.size() >= 10 || SmsMessage.hasEmsSupport()) {
                this.mDispatcher.sendMultipartText(destAddr, scAddr, (ArrayList) parts, (ArrayList) sentIntents, (ArrayList) deliveryIntents, null, callingPackage);
                return;
            }
            i = 0;
            while (i < parts.size()) {
                String singlePart = (String) parts.get(i);
                if (SmsMessage.shouldAppendPageNumberAsPrefix()) {
                    singlePart = String.valueOf(i + EVENT_LOAD_DONE) + '/' + parts.size() + ' ' + singlePart;
                } else {
                    singlePart = singlePart.concat(' ' + String.valueOf(i + EVENT_LOAD_DONE) + '/' + parts.size());
                }
                PendingIntent singleSentIntent = null;
                if (sentIntents != null && sentIntents.size() > i) {
                    singleSentIntent = (PendingIntent) sentIntents.get(i);
                }
                PendingIntent singleDeliveryIntent = null;
                if (deliveryIntents != null && deliveryIntents.size() > i) {
                    singleDeliveryIntent = (PendingIntent) deliveryIntents.get(i);
                }
                this.mDispatcher.sendText(destAddr, scAddr, singlePart, singleSentIntent, singleDeliveryIntent, null, callingPackage);
                i += EVENT_LOAD_DONE;
            }
        }
    }

    public int getPremiumSmsPermission(String packageName) {
        return this.mDispatcher.getPremiumSmsPermission(packageName);
    }

    public void setPremiumSmsPermission(String packageName, int permission) {
        this.mDispatcher.setPremiumSmsPermission(packageName, permission);
    }

    protected ArrayList<SmsRawData> buildValidRawData(ArrayList<byte[]> messages) {
        int count = messages.size();
        ArrayList<SmsRawData> ret = new ArrayList(count);
        for (int i = 0; i < count; i += EVENT_LOAD_DONE) {
            if (((byte[]) messages.get(i))[0] == null) {
                ret.add(null);
            } else {
                ret.add(new SmsRawData((byte[]) messages.get(i)));
            }
        }
        return ret;
    }

    protected byte[] makeSmsRecordData(int status, byte[] pdu) {
        byte[] data;
        if (EVENT_LOAD_DONE == this.mPhone.getPhoneType()) {
            data = new byte[PduHeaders.ADDITIONAL_HEADERS];
        } else {
            data = new byte[SMS_CB_CODE_SCHEME_MAX];
        }
        data[0] = (byte) (status & 7);
        System.arraycopy(pdu, 0, data, EVENT_LOAD_DONE, pdu.length);
        for (int j = pdu.length + EVENT_LOAD_DONE; j < data.length; j += EVENT_LOAD_DONE) {
            data[j] = (byte) -1;
        }
        return data;
    }

    public boolean enableCellBroadcast(int messageIdentifier, int ranType) {
        return enableCellBroadcastRange(messageIdentifier, messageIdentifier, ranType);
    }

    public boolean disableCellBroadcast(int messageIdentifier, int ranType) {
        return disableCellBroadcastRange(messageIdentifier, messageIdentifier, ranType);
    }

    public boolean enableCellBroadcastRange(int startMessageId, int endMessageId, int ranType) {
        if (ranType == 0) {
            return enableGsmBroadcastRange(startMessageId, endMessageId);
        }
        if (ranType == EVENT_LOAD_DONE) {
            return enableCdmaBroadcastRange(startMessageId, endMessageId);
        }
        throw new IllegalArgumentException("Not a supportted RAN Type");
    }

    public boolean disableCellBroadcastRange(int startMessageId, int endMessageId, int ranType) {
        if (ranType == 0) {
            return disableGsmBroadcastRange(startMessageId, endMessageId);
        }
        if (ranType == EVENT_LOAD_DONE) {
            return disableCdmaBroadcastRange(startMessageId, endMessageId);
        }
        throw new IllegalArgumentException("Not a supportted RAN Type");
    }

    public synchronized boolean enableGsmBroadcastRange(int startMessageId, int endMessageId) {
        boolean z = false;
        synchronized (this) {
            log("enableGsmBroadcastRange");
            Context context = this.mPhone.getContext();
            context.enforceCallingPermission("android.permission.RECEIVE_SMS", "Enabling cell broadcast SMS");
            String client = context.getPackageManager().getNameForUid(Binder.getCallingUid());
            if (this.mCellBroadcastRangeManager.enableRange(startMessageId, endMessageId, client)) {
                log("Added GSM cell broadcast subscription for MID range " + startMessageId + " to " + endMessageId + " from client " + client);
                if (!this.mCellBroadcastRangeManager.isEmpty()) {
                    z = DBG;
                }
                setCellBroadcastActivation(z);
                z = DBG;
            } else {
                log("Failed to add GSM cell broadcast subscription for MID range " + startMessageId + " to " + endMessageId + " from client " + client);
            }
        }
        return z;
    }

    public synchronized boolean disableGsmBroadcastRange(int startMessageId, int endMessageId) {
        boolean z = false;
        synchronized (this) {
            log("disableGsmBroadcastRange");
            Context context = this.mPhone.getContext();
            context.enforceCallingPermission("android.permission.RECEIVE_SMS", "Disabling cell broadcast SMS");
            String client = context.getPackageManager().getNameForUid(Binder.getCallingUid());
            if (this.mCellBroadcastRangeManager.disableRange(startMessageId, endMessageId, client)) {
                log("Removed GSM cell broadcast subscription for MID range " + startMessageId + " to " + endMessageId + " from client " + client);
                if (!this.mCellBroadcastRangeManager.isEmpty()) {
                    z = DBG;
                }
                setCellBroadcastActivation(z);
                z = DBG;
            } else {
                log("Failed to remove GSM cell broadcast subscription for MID range " + startMessageId + " to " + endMessageId + " from client " + client);
            }
        }
        return z;
    }

    public synchronized boolean enableCdmaBroadcastRange(int startMessageId, int endMessageId) {
        boolean z = false;
        synchronized (this) {
            log("enableCdmaBroadcastRange");
            Context context = this.mPhone.getContext();
            context.enforceCallingPermission("android.permission.RECEIVE_SMS", "Enabling cdma broadcast SMS");
            String client = context.getPackageManager().getNameForUid(Binder.getCallingUid());
            if (this.mCdmaBroadcastRangeManager.enableRange(startMessageId, endMessageId, client)) {
                log("Added cdma broadcast subscription for MID range " + startMessageId + " to " + endMessageId + " from client " + client);
                if (!this.mCdmaBroadcastRangeManager.isEmpty()) {
                    z = DBG;
                }
                setCdmaBroadcastActivation(z);
                z = DBG;
            } else {
                log("Failed to add cdma broadcast subscription for MID range " + startMessageId + " to " + endMessageId + " from client " + client);
            }
        }
        return z;
    }

    public synchronized boolean disableCdmaBroadcastRange(int startMessageId, int endMessageId) {
        boolean z = false;
        synchronized (this) {
            log("disableCdmaBroadcastRange");
            Context context = this.mPhone.getContext();
            context.enforceCallingPermission("android.permission.RECEIVE_SMS", "Disabling cell broadcast SMS");
            String client = context.getPackageManager().getNameForUid(Binder.getCallingUid());
            if (this.mCdmaBroadcastRangeManager.disableRange(startMessageId, endMessageId, client)) {
                log("Removed cdma broadcast subscription for MID range " + startMessageId + " to " + endMessageId + " from client " + client);
                if (!this.mCdmaBroadcastRangeManager.isEmpty()) {
                    z = DBG;
                }
                setCdmaBroadcastActivation(z);
                z = DBG;
            } else {
                log("Failed to remove cdma broadcast subscription for MID range " + startMessageId + " to " + endMessageId + " from client " + client);
            }
        }
        return z;
    }

    private boolean setCellBroadcastConfig(SmsBroadcastConfigInfo[] configs) {
        log("Calling setGsmBroadcastConfig with " + configs.length + " configurations");
        synchronized (this.mLock) {
            Message response = this.mHandler.obtainMessage(EVENT_SET_BROADCAST_CONFIG_DONE);
            this.mSuccess = false;
            this.mPhone.mCi.setGsmBroadcastConfig(configs, response);
            try {
                this.mLock.wait();
            } catch (InterruptedException e) {
                log("interrupted while trying to set cell broadcast config");
            }
        }
        return this.mSuccess;
    }

    private boolean setCellBroadcastActivation(boolean activate) {
        log("Calling setCellBroadcastActivation(" + activate + ')');
        synchronized (this.mLock) {
            Message response = this.mHandler.obtainMessage(EVENT_SET_BROADCAST_ACTIVATION_DONE);
            this.mSuccess = false;
            this.mPhone.mCi.setGsmBroadcastActivation(activate, response);
            try {
                this.mLock.wait();
            } catch (InterruptedException e) {
                log("interrupted while trying to set cell broadcast activation");
            }
        }
        return this.mSuccess;
    }

    private boolean setCdmaBroadcastConfig(CdmaSmsBroadcastConfigInfo[] configs) {
        log("Calling setCdmaBroadcastConfig with " + configs.length + " configurations");
        synchronized (this.mLock) {
            Message response = this.mHandler.obtainMessage(EVENT_SET_BROADCAST_CONFIG_DONE);
            this.mSuccess = false;
            this.mPhone.mCi.setCdmaBroadcastConfig(configs, response);
            try {
                this.mLock.wait();
            } catch (InterruptedException e) {
                log("interrupted while trying to set cdma broadcast config");
            }
        }
        return this.mSuccess;
    }

    private boolean setCdmaBroadcastActivation(boolean activate) {
        log("Calling setCdmaBroadcastActivation(" + activate + ")");
        synchronized (this.mLock) {
            Message response = this.mHandler.obtainMessage(EVENT_SET_BROADCAST_ACTIVATION_DONE);
            this.mSuccess = false;
            this.mPhone.mCi.setCdmaBroadcastActivation(activate, response);
            try {
                this.mLock.wait();
            } catch (InterruptedException e) {
                log("interrupted while trying to set cdma broadcast activation");
            }
        }
        return this.mSuccess;
    }

    protected void log(String msg) {
        Log.d(LOG_TAG, "[IccSmsInterfaceManager] " + msg);
    }

    public boolean isImsSmsSupported() {
        return this.mDispatcher.isIms();
    }

    public String getImsSmsFormat() {
        return this.mDispatcher.getImsSmsFormat();
    }

    public void sendStoredText(String callingPkg, Uri messageUri, String scAddress, PendingIntent sentIntent, PendingIntent deliveryIntent) {
        this.mPhone.getContext().enforceCallingPermission("android.permission.SEND_SMS", "Sending SMS message");
        if (Rlog.isLoggable("SMS", EVENT_UPDATE_DONE)) {
            log("sendStoredText: scAddr=" + scAddress + " messageUri=" + messageUri + " sentIntent=" + sentIntent + " deliveryIntent=" + deliveryIntent);
        }
        if (this.mAppOps.noteOp(20, Binder.getCallingUid(), callingPkg) == 0) {
            ContentResolver resolver = this.mPhone.getContext().getContentResolver();
            if (isFailedOrDraft(resolver, messageUri)) {
                String[] textAndAddress = loadTextAndAddress(resolver, messageUri);
                if (textAndAddress == null) {
                    Log.e(LOG_TAG, "[IccSmsInterfaceManager]sendStoredText: can not load text");
                    returnUnspecifiedFailure(sentIntent);
                    return;
                }
                textAndAddress[EVENT_LOAD_DONE] = filterDestAddress(textAndAddress[EVENT_LOAD_DONE]);
                this.mDispatcher.sendText(textAndAddress[EVENT_LOAD_DONE], scAddress, textAndAddress[0], sentIntent, deliveryIntent, messageUri, callingPkg);
                return;
            }
            Log.e(LOG_TAG, "[IccSmsInterfaceManager]sendStoredText: not FAILED or DRAFT message");
            returnUnspecifiedFailure(sentIntent);
        }
    }

    public void sendStoredMultipartText(String callingPkg, Uri messageUri, String scAddress, List<PendingIntent> sentIntents, List<PendingIntent> deliveryIntents) {
        this.mPhone.getContext().enforceCallingPermission("android.permission.SEND_SMS", "Sending SMS message");
        if (this.mAppOps.noteOp(20, Binder.getCallingUid(), callingPkg) == 0) {
            ContentResolver resolver = this.mPhone.getContext().getContentResolver();
            if (isFailedOrDraft(resolver, messageUri)) {
                String[] textAndAddress = loadTextAndAddress(resolver, messageUri);
                if (textAndAddress == null) {
                    Log.e(LOG_TAG, "[IccSmsInterfaceManager]sendStoredMultipartText: can not load text");
                    returnUnspecifiedFailure((List) sentIntents);
                    return;
                }
                ArrayList<String> parts = SmsManager.getDefault().divideMessage(textAndAddress[0]);
                if (parts == null || parts.size() < EVENT_LOAD_DONE) {
                    Log.e(LOG_TAG, "[IccSmsInterfaceManager]sendStoredMultipartText: can not divide text");
                    returnUnspecifiedFailure((List) sentIntents);
                    return;
                }
                textAndAddress[EVENT_LOAD_DONE] = filterDestAddress(textAndAddress[EVENT_LOAD_DONE]);
                if (parts.size() <= EVENT_LOAD_DONE || parts.size() >= 10 || SmsMessage.hasEmsSupport()) {
                    this.mDispatcher.sendMultipartText(textAndAddress[EVENT_LOAD_DONE], scAddress, parts, (ArrayList) sentIntents, (ArrayList) deliveryIntents, messageUri, callingPkg);
                    return;
                }
                int i = 0;
                while (i < parts.size()) {
                    String singlePart = (String) parts.get(i);
                    if (SmsMessage.shouldAppendPageNumberAsPrefix()) {
                        singlePart = String.valueOf(i + EVENT_LOAD_DONE) + '/' + parts.size() + ' ' + singlePart;
                    } else {
                        singlePart = singlePart.concat(' ' + String.valueOf(i + EVENT_LOAD_DONE) + '/' + parts.size());
                    }
                    PendingIntent singleSentIntent = null;
                    if (sentIntents != null && sentIntents.size() > i) {
                        singleSentIntent = (PendingIntent) sentIntents.get(i);
                    }
                    PendingIntent singleDeliveryIntent = null;
                    if (deliveryIntents != null && deliveryIntents.size() > i) {
                        singleDeliveryIntent = (PendingIntent) deliveryIntents.get(i);
                    }
                    this.mDispatcher.sendText(textAndAddress[EVENT_LOAD_DONE], scAddress, singlePart, singleSentIntent, singleDeliveryIntent, messageUri, callingPkg);
                    i += EVENT_LOAD_DONE;
                }
                return;
            }
            Log.e(LOG_TAG, "[IccSmsInterfaceManager]sendStoredMultipartText: not FAILED or DRAFT message");
            returnUnspecifiedFailure((List) sentIntents);
        }
    }

    private String[] loadTextAndAddress(ContentResolver resolver, Uri messageUri) {
        long identity = Binder.clearCallingIdentity();
        Cursor cursor = null;
        String[] strArr;
        try {
            String[] strArr2 = new String[EVENT_UPDATE_DONE];
            strArr2[0] = TextBasedSmsColumns.BODY;
            strArr2[EVENT_LOAD_DONE] = TextBasedSmsColumns.ADDRESS;
            cursor = resolver.query(messageUri, strArr2, null, null, null);
            if (cursor == null || !cursor.moveToFirst()) {
                if (cursor != null) {
                    cursor.close();
                }
                Binder.restoreCallingIdentity(identity);
                return null;
            }
            strArr = new String[EVENT_UPDATE_DONE];
            strArr[0] = cursor.getString(0);
            strArr[EVENT_LOAD_DONE] = cursor.getString(EVENT_LOAD_DONE);
            return strArr;
        } catch (SQLiteException e) {
            strArr = LOG_TAG;
            Log.e(strArr, "[IccSmsInterfaceManager]loadText: query message text failed", e);
        } finally {
            if (cursor != null) {
                cursor.close();
            }
            Binder.restoreCallingIdentity(identity);
        }
    }

    private void returnUnspecifiedFailure(PendingIntent pi) {
        if (pi != null) {
            try {
                pi.send(EVENT_LOAD_DONE);
            } catch (CanceledException e) {
            }
        }
    }

    private void returnUnspecifiedFailure(List<PendingIntent> pis) {
        if (pis != null) {
            for (PendingIntent pi : pis) {
                returnUnspecifiedFailure(pi);
            }
        }
    }

    private void enforceCarrierPrivilege() {
        UiccController controller = UiccController.getInstance();
        if (controller == null || controller.getUiccCard(this.mPhone.getPhoneId()) == null) {
            throw new SecurityException("No Carrier Privilege: No UICC");
        } else if (controller.getUiccCard(this.mPhone.getPhoneId()).getCarrierPrivilegeStatusForCurrentTransaction(this.mContext.getPackageManager()) != EVENT_LOAD_DONE) {
            throw new SecurityException("No Carrier Privilege.");
        }
    }

    private String filterDestAddress(String destAddr) {
        String result = SmsNumberUtils.filterDestAddr(this.mPhone, destAddr);
        return result != null ? result : destAddr;
    }
}
