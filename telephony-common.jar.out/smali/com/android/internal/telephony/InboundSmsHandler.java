package com.android.internal.telephony;

import android.app.ActivityManagerNative;
import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences.Editor;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.pm.UserInfo;
import android.database.Cursor;
import android.database.SQLException;
import android.net.Uri;
import android.os.AsyncResult;
import android.os.Binder;
import android.os.Build;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.UserHandle;
import android.os.UserManager;
import android.preference.PreferenceManager;
import android.provider.Telephony.Carriers;
import android.provider.Telephony.CellBroadcasts;
import android.provider.Telephony.Sms;
import android.provider.Telephony.Sms.Inbox;
import android.provider.Telephony.Sms.Intents;
import android.provider.Telephony.TextBasedSmsColumns;
import android.provider.Telephony.ThreadsColumns;
import android.service.carrier.ICarrierMessagingCallback.Stub;
import android.service.carrier.ICarrierMessagingService;
import android.service.carrier.MessagePdu;
import android.telephony.CarrierMessagingServiceManager;
import android.telephony.Rlog;
import android.telephony.SmsManager;
import android.telephony.SmsMessage;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import com.android.internal.telephony.SmsHeader.ConcatRef;
import com.android.internal.telephony.SmsHeader.PortAddrs;
import com.android.internal.telephony.uicc.UiccCard;
import com.android.internal.telephony.uicc.UiccController;
import com.android.internal.util.HexDump;
import com.android.internal.util.State;
import com.android.internal.util.StateMachine;
import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public abstract class InboundSmsHandler extends StateMachine {
    static final int ADDRESS_COLUMN = 6;
    static final int COUNT_COLUMN = 5;
    static final int DATE_COLUMN = 3;
    protected static final boolean DBG = true;
    static final int DESTINATION_PORT_COLUMN = 2;
    static final int EVENT_BROADCAST_COMPLETE = 3;
    static final int EVENT_BROADCAST_SMS = 2;
    public static final int EVENT_INJECT_SMS = 8;
    public static final int EVENT_NEW_SMS = 1;
    static final int EVENT_RELEASE_WAKELOCK = 5;
    static final int EVENT_RETURN_TO_IDLE = 4;
    static final int EVENT_START_ACCEPTING_SMS = 6;
    static final int EVENT_UPDATE_PHONE_OBJECT = 7;
    static final int ID_COLUMN = 7;
    static final int PDU_COLUMN = 0;
    private static final String[] PDU_PROJECTION;
    private static final String[] PDU_SEQUENCE_PORT_PROJECTION;
    static final int REFERENCE_NUMBER_COLUMN = 4;
    static final String SELECT_BY_ID = "_id=?";
    static final String SELECT_BY_REFERENCE = "address=? AND reference_number=? AND count=?";
    static final int SEQUENCE_COLUMN = 1;
    private static final boolean VDBG = false;
    private static final int WAKELOCK_TIMEOUT = 3000;
    private static final Uri sRawUri;
    protected CellBroadcastHandler mCellBroadcastHandler;
    protected final Context mContext;
    final DefaultState mDefaultState;
    final DeliveringState mDeliveringState;
    final IdleState mIdleState;
    protected PhoneBase mPhone;
    private final ContentResolver mResolver;
    private final boolean mSmsReceiveDisabled;
    final StartupState mStartupState;
    protected SmsStorageMonitor mStorageMonitor;
    private UserManager mUserManager;
    final WaitingState mWaitingState;
    final WakeLock mWakeLock;
    private final WapPushOverSms mWapPush;

    private final class CarrierSmsFilter extends CarrierMessagingServiceManager {
        private final int mDestPort;
        private final byte[][] mPdus;
        private final SmsBroadcastReceiver mSmsBroadcastReceiver;
        private volatile CarrierSmsFilterCallback mSmsFilterCallback;
        private final String mSmsFormat;

        CarrierSmsFilter(byte[][] pdus, int destPort, String smsFormat, SmsBroadcastReceiver smsBroadcastReceiver) {
            this.mPdus = pdus;
            this.mDestPort = destPort;
            this.mSmsFormat = smsFormat;
            this.mSmsBroadcastReceiver = smsBroadcastReceiver;
        }

        void filterSms(String carrierPackageName, CarrierSmsFilterCallback smsFilterCallback) {
            this.mSmsFilterCallback = smsFilterCallback;
            if (bindToCarrierMessagingService(InboundSmsHandler.this.mContext, carrierPackageName)) {
                InboundSmsHandler.this.logv("bindService() for carrier messaging service succeeded");
                return;
            }
            InboundSmsHandler.this.loge("bindService() for carrier messaging service failed");
            smsFilterCallback.onFilterComplete(InboundSmsHandler.DBG);
        }

        protected void onServiceReady(ICarrierMessagingService carrierMessagingService) {
            try {
                carrierMessagingService.filterSms(new MessagePdu(Arrays.asList(this.mPdus)), this.mSmsFormat, this.mDestPort, InboundSmsHandler.this.mPhone.getSubId(), this.mSmsFilterCallback);
            } catch (RemoteException e) {
                InboundSmsHandler.this.loge("Exception filtering the SMS: " + e);
                this.mSmsFilterCallback.onFilterComplete(InboundSmsHandler.DBG);
            }
        }
    }

    private final class CarrierSmsFilterCallback extends Stub {
        private final CarrierSmsFilter mSmsFilter;

        CarrierSmsFilterCallback(CarrierSmsFilter smsFilter) {
            this.mSmsFilter = smsFilter;
        }

        public void onFilterComplete(boolean keepMessage) {
            this.mSmsFilter.disposeConnection(InboundSmsHandler.this.mContext);
            InboundSmsHandler.this.logv("onFilterComplete: keepMessage is " + keepMessage);
            if (keepMessage) {
                InboundSmsHandler.this.dispatchSmsDeliveryIntent(this.mSmsFilter.mPdus, this.mSmsFilter.mSmsFormat, this.mSmsFilter.mDestPort, this.mSmsFilter.mSmsBroadcastReceiver);
                return;
            }
            long token = Binder.clearCallingIdentity();
            try {
                InboundSmsHandler.this.deleteFromRawTable(this.mSmsFilter.mSmsBroadcastReceiver.mDeleteWhere, this.mSmsFilter.mSmsBroadcastReceiver.mDeleteWhereArgs);
                InboundSmsHandler.this.sendMessage(InboundSmsHandler.EVENT_BROADCAST_COMPLETE);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void onSendSmsComplete(int result, int messageRef) {
            InboundSmsHandler.this.loge("Unexpected onSendSmsComplete call with result: " + result);
        }

        public void onSendMultipartSmsComplete(int result, int[] messageRefs) {
            InboundSmsHandler.this.loge("Unexpected onSendMultipartSmsComplete call with result: " + result);
        }

        public void onSendMmsComplete(int result, byte[] sendConfPdu) {
            InboundSmsHandler.this.loge("Unexpected onSendMmsComplete call with result: " + result);
        }

        public void onDownloadMmsComplete(int result) {
            InboundSmsHandler.this.loge("Unexpected onDownloadMmsComplete call with result: " + result);
        }
    }

    class DefaultState extends State {
        DefaultState() {
        }

        public boolean processMessage(Message msg) {
            switch (msg.what) {
                case InboundSmsHandler.ID_COLUMN /*7*/:
                    InboundSmsHandler.this.onUpdatePhoneObject((PhoneBase) msg.obj);
                    break;
                default:
                    String errorText = "processMessage: unhandled message type " + msg.what + " currState=" + InboundSmsHandler.this.getCurrentState().getName();
                    if (!Build.IS_DEBUGGABLE) {
                        InboundSmsHandler.this.loge(errorText);
                        break;
                    }
                    InboundSmsHandler.this.loge("---- Dumping InboundSmsHandler ----");
                    InboundSmsHandler.this.loge("Total records=" + InboundSmsHandler.this.getLogRecCount());
                    for (int i = Math.max(InboundSmsHandler.this.getLogRecSize() - 20, InboundSmsHandler.PDU_COLUMN); i < InboundSmsHandler.this.getLogRecSize(); i += InboundSmsHandler.SEQUENCE_COLUMN) {
                        InboundSmsHandler.this.loge("Rec[%d]: %s\n" + i + InboundSmsHandler.this.getLogRec(i).toString());
                    }
                    InboundSmsHandler.this.loge("---- Dumped InboundSmsHandler ----");
                    throw new RuntimeException(errorText);
            }
            return InboundSmsHandler.DBG;
        }
    }

    class DeliveringState extends State {
        DeliveringState() {
        }

        public void enter() {
            InboundSmsHandler.this.log("entering Delivering state");
        }

        public void exit() {
            InboundSmsHandler.this.log("leaving Delivering state");
        }

        public boolean processMessage(Message msg) {
            InboundSmsHandler.this.log("DeliveringState.processMessage:" + msg.what);
            switch (msg.what) {
                case InboundSmsHandler.SEQUENCE_COLUMN /*1*/:
                    InboundSmsHandler.this.handleNewSms((AsyncResult) msg.obj);
                    InboundSmsHandler.this.sendMessage(InboundSmsHandler.REFERENCE_NUMBER_COLUMN);
                    return InboundSmsHandler.DBG;
                case InboundSmsHandler.EVENT_BROADCAST_SMS /*2*/:
                    if (InboundSmsHandler.this.processMessagePart((InboundSmsTracker) msg.obj)) {
                        InboundSmsHandler.this.transitionTo(InboundSmsHandler.this.mWaitingState);
                    }
                    return InboundSmsHandler.DBG;
                case InboundSmsHandler.REFERENCE_NUMBER_COLUMN /*4*/:
                    InboundSmsHandler.this.transitionTo(InboundSmsHandler.this.mIdleState);
                    return InboundSmsHandler.DBG;
                case InboundSmsHandler.EVENT_RELEASE_WAKELOCK /*5*/:
                    InboundSmsHandler.this.mWakeLock.release();
                    if (!InboundSmsHandler.this.mWakeLock.isHeld()) {
                        InboundSmsHandler.this.loge("mWakeLock released while delivering/broadcasting!");
                    }
                    return InboundSmsHandler.DBG;
                case InboundSmsHandler.EVENT_INJECT_SMS /*8*/:
                    InboundSmsHandler.this.handleInjectSms((AsyncResult) msg.obj);
                    InboundSmsHandler.this.sendMessage(InboundSmsHandler.REFERENCE_NUMBER_COLUMN);
                    return InboundSmsHandler.DBG;
                default:
                    return InboundSmsHandler.VDBG;
            }
        }
    }

    class IdleState extends State {
        IdleState() {
        }

        public void enter() {
            InboundSmsHandler.this.log("entering Idle state");
            InboundSmsHandler.this.sendMessageDelayed(InboundSmsHandler.EVENT_RELEASE_WAKELOCK, 3000);
        }

        public void exit() {
            InboundSmsHandler.this.mWakeLock.acquire();
            InboundSmsHandler.this.log("acquired wakelock, leaving Idle state");
        }

        public boolean processMessage(Message msg) {
            InboundSmsHandler.this.log("IdleState.processMessage:" + msg.what);
            InboundSmsHandler.this.log("Idle state processing message type " + msg.what);
            switch (msg.what) {
                case InboundSmsHandler.SEQUENCE_COLUMN /*1*/:
                case InboundSmsHandler.EVENT_BROADCAST_SMS /*2*/:
                case InboundSmsHandler.EVENT_INJECT_SMS /*8*/:
                    InboundSmsHandler.this.deferMessage(msg);
                    InboundSmsHandler.this.transitionTo(InboundSmsHandler.this.mDeliveringState);
                    return InboundSmsHandler.DBG;
                case InboundSmsHandler.REFERENCE_NUMBER_COLUMN /*4*/:
                    return InboundSmsHandler.DBG;
                case InboundSmsHandler.EVENT_RELEASE_WAKELOCK /*5*/:
                    InboundSmsHandler.this.mWakeLock.release();
                    if (InboundSmsHandler.this.mWakeLock.isHeld()) {
                        InboundSmsHandler.this.log("mWakeLock is still held after release");
                        return InboundSmsHandler.DBG;
                    }
                    InboundSmsHandler.this.log("mWakeLock released");
                    return InboundSmsHandler.DBG;
                default:
                    return InboundSmsHandler.VDBG;
            }
        }
    }

    private final class SmsBroadcastReceiver extends BroadcastReceiver {
        private long mBroadcastTimeNano;
        private final String mDeleteWhere;
        private final String[] mDeleteWhereArgs;

        SmsBroadcastReceiver(InboundSmsTracker tracker) {
            this.mDeleteWhere = tracker.getDeleteWhere();
            this.mDeleteWhereArgs = tracker.getDeleteWhereArgs();
            this.mBroadcastTimeNano = System.nanoTime();
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (action.equals(Intents.SMS_DELIVER_ACTION)) {
                intent.setAction(Intents.SMS_RECEIVED_ACTION);
                intent.setComponent(null);
                InboundSmsHandler.this.dispatchIntent(intent, "android.permission.RECEIVE_SMS", 16, this, UserHandle.ALL);
            } else if (action.equals(Intents.WAP_PUSH_DELIVER_ACTION)) {
                intent.setAction(Intents.WAP_PUSH_RECEIVED_ACTION);
                intent.setComponent(null);
                InboundSmsHandler.this.dispatchIntent(intent, "android.permission.RECEIVE_SMS", 16, this, UserHandle.OWNER);
            } else {
                if (!(Intents.DATA_SMS_RECEIVED_ACTION.equals(action) || Intents.SMS_RECEIVED_ACTION.equals(action) || Intents.DATA_SMS_RECEIVED_ACTION.equals(action) || Intents.WAP_PUSH_RECEIVED_ACTION.equals(action))) {
                    InboundSmsHandler.this.loge("unexpected BroadcastReceiver action: " + action);
                }
                int rc = getResultCode();
                if (rc == -1 || rc == InboundSmsHandler.SEQUENCE_COLUMN) {
                    InboundSmsHandler.this.log("successful broadcast, deleting from raw table.");
                } else {
                    InboundSmsHandler.this.loge("a broadcast receiver set the result code to " + rc + ", deleting from raw table anyway!");
                }
                InboundSmsHandler.this.deleteFromRawTable(this.mDeleteWhere, this.mDeleteWhereArgs);
                InboundSmsHandler.this.sendMessage(InboundSmsHandler.EVENT_BROADCAST_COMPLETE);
                int durationMillis = (int) ((System.nanoTime() - this.mBroadcastTimeNano) / 1000000);
                if (durationMillis >= 5000) {
                    InboundSmsHandler.this.loge("Slow ordered broadcast completion time: " + durationMillis + " ms");
                } else {
                    InboundSmsHandler.this.log("ordered broadcast completed in: " + durationMillis + " ms");
                }
            }
        }
    }

    class StartupState extends State {
        StartupState() {
        }

        public boolean processMessage(Message msg) {
            InboundSmsHandler.this.log("StartupState.processMessage:" + msg.what);
            switch (msg.what) {
                case InboundSmsHandler.SEQUENCE_COLUMN /*1*/:
                case InboundSmsHandler.EVENT_BROADCAST_SMS /*2*/:
                case InboundSmsHandler.EVENT_INJECT_SMS /*8*/:
                    InboundSmsHandler.this.deferMessage(msg);
                    return InboundSmsHandler.DBG;
                case InboundSmsHandler.EVENT_START_ACCEPTING_SMS /*6*/:
                    InboundSmsHandler.this.transitionTo(InboundSmsHandler.this.mIdleState);
                    return InboundSmsHandler.DBG;
                default:
                    return InboundSmsHandler.VDBG;
            }
        }
    }

    class WaitingState extends State {
        WaitingState() {
        }

        public boolean processMessage(Message msg) {
            InboundSmsHandler.this.log("WaitingState.processMessage:" + msg.what);
            switch (msg.what) {
                case InboundSmsHandler.EVENT_BROADCAST_SMS /*2*/:
                    InboundSmsHandler.this.deferMessage(msg);
                    return InboundSmsHandler.DBG;
                case InboundSmsHandler.EVENT_BROADCAST_COMPLETE /*3*/:
                    InboundSmsHandler.this.sendMessage(InboundSmsHandler.REFERENCE_NUMBER_COLUMN);
                    InboundSmsHandler.this.transitionTo(InboundSmsHandler.this.mDeliveringState);
                    return InboundSmsHandler.DBG;
                case InboundSmsHandler.REFERENCE_NUMBER_COLUMN /*4*/:
                    return InboundSmsHandler.DBG;
                default:
                    return InboundSmsHandler.VDBG;
            }
        }
    }

    protected abstract void acknowledgeLastIncomingSms(boolean z, int i, Message message);

    protected abstract int dispatchMessageRadioSpecific(SmsMessageBase smsMessageBase);

    protected abstract boolean is3gpp2();

    static {
        String[] strArr = new String[SEQUENCE_COLUMN];
        strArr[PDU_COLUMN] = "pdu";
        PDU_PROJECTION = strArr;
        strArr = new String[EVENT_BROADCAST_COMPLETE];
        strArr[PDU_COLUMN] = "pdu";
        strArr[SEQUENCE_COLUMN] = "sequence";
        strArr[EVENT_BROADCAST_SMS] = "destination_port";
        PDU_SEQUENCE_PORT_PROJECTION = strArr;
        sRawUri = Uri.withAppendedPath(Sms.CONTENT_URI, "raw");
    }

    protected InboundSmsHandler(String name, Context context, SmsStorageMonitor storageMonitor, PhoneBase phone, CellBroadcastHandler cellBroadcastHandler) {
        super(name);
        this.mDefaultState = new DefaultState();
        this.mStartupState = new StartupState();
        this.mIdleState = new IdleState();
        this.mDeliveringState = new DeliveringState();
        this.mWaitingState = new WaitingState();
        this.mContext = context;
        this.mStorageMonitor = storageMonitor;
        this.mPhone = phone;
        this.mCellBroadcastHandler = cellBroadcastHandler;
        this.mResolver = context.getContentResolver();
        this.mWapPush = new WapPushOverSms(context);
        this.mSmsReceiveDisabled = !TelephonyManager.from(this.mContext).getSmsReceiveCapableForPhone(this.mPhone.getPhoneId(), this.mContext.getResources().getBoolean(17956948)) ? DBG : VDBG;
        this.mWakeLock = ((PowerManager) this.mContext.getSystemService("power")).newWakeLock(SEQUENCE_COLUMN, name);
        this.mWakeLock.acquire();
        this.mUserManager = (UserManager) this.mContext.getSystemService(Carriers.USER);
        addState(this.mDefaultState);
        addState(this.mStartupState, this.mDefaultState);
        addState(this.mIdleState, this.mDefaultState);
        addState(this.mDeliveringState, this.mDefaultState);
        addState(this.mWaitingState, this.mDeliveringState);
        setInitialState(this.mStartupState);
        log("created InboundSmsHandler");
    }

    public void dispose() {
        quit();
    }

    public void updatePhoneObject(PhoneBase phone) {
        sendMessage(ID_COLUMN, phone);
    }

    protected void onQuitting() {
        this.mWapPush.dispose();
        while (this.mWakeLock.isHeld()) {
            this.mWakeLock.release();
        }
    }

    public PhoneBase getPhone() {
        return this.mPhone;
    }

    void handleNewSms(AsyncResult ar) {
        boolean handled = DBG;
        if (ar.exception != null) {
            loge("Exception processing incoming SMS: " + ar.exception);
            return;
        }
        int result;
        try {
            result = dispatchMessage(ar.result.mWrappedSmsMessage);
        } catch (RuntimeException ex) {
            loge("Exception dispatching message", ex);
            result = EVENT_BROADCAST_SMS;
        }
        if (result != -1) {
            if (result != SEQUENCE_COLUMN) {
                handled = VDBG;
            }
            notifyAndAcknowledgeLastIncomingSms(handled, result, null);
        }
    }

    void handleInjectSms(AsyncResult ar) {
        int result;
        PendingIntent receivedIntent = null;
        try {
            receivedIntent = (PendingIntent) ar.userObj;
            SmsMessage sms = ar.result;
            if (sms == null) {
                result = EVENT_BROADCAST_SMS;
            } else {
                result = dispatchMessage(sms.mWrappedSmsMessage);
            }
        } catch (RuntimeException ex) {
            loge("Exception dispatching message", ex);
            result = EVENT_BROADCAST_SMS;
        }
        if (receivedIntent != null) {
            try {
                receivedIntent.send(result);
            } catch (CanceledException e) {
            }
        }
    }

    public int dispatchMessage(SmsMessageBase smsb) {
        if (smsb == null) {
            loge("dispatchSmsMessage: message is null");
            return EVENT_BROADCAST_SMS;
        } else if (!this.mSmsReceiveDisabled) {
            return dispatchMessageRadioSpecific(smsb);
        } else {
            log("Received short message on device which doesn't support receiving SMS. Ignored.");
            return SEQUENCE_COLUMN;
        }
    }

    protected void onUpdatePhoneObject(PhoneBase phone) {
        this.mPhone = phone;
        this.mStorageMonitor = this.mPhone.mSmsStorageMonitor;
        log("onUpdatePhoneObject: phone=" + this.mPhone.getClass().getSimpleName());
    }

    void notifyAndAcknowledgeLastIncomingSms(boolean success, int result, Message response) {
        if (!success) {
            Intent intent = new Intent(Intents.SMS_REJECTED_ACTION);
            intent.putExtra("result", result);
            this.mContext.sendBroadcast(intent, "android.permission.RECEIVE_SMS");
        }
        acknowledgeLastIncomingSms(success, result, response);
    }

    protected int dispatchNormalMessage(SmsMessageBase sms) {
        InboundSmsTracker tracker;
        SmsHeader smsHeader = sms.getUserDataHeader();
        if (smsHeader == null || smsHeader.concatRef == null) {
            int destPort = -1;
            if (!(smsHeader == null || smsHeader.portAddrs == null)) {
                destPort = smsHeader.portAddrs.destPort;
                log("destination port: " + destPort);
            }
            tracker = new InboundSmsTracker(sms.getPdu(), sms.getTimestampMillis(), destPort, is3gpp2(), VDBG);
        } else {
            ConcatRef concatRef = smsHeader.concatRef;
            PortAddrs portAddrs = smsHeader.portAddrs;
            tracker = new InboundSmsTracker(sms.getPdu(), sms.getTimestampMillis(), portAddrs != null ? portAddrs.destPort : -1, is3gpp2(), sms.getOriginatingAddress(), concatRef.refNumber, concatRef.seqNumber, concatRef.msgCount, VDBG);
        }
        return addTrackerToRawTableAndSendMessage(tracker);
    }

    protected int addTrackerToRawTableAndSendMessage(InboundSmsTracker tracker) {
        switch (addTrackerToRawTable(tracker)) {
            case SEQUENCE_COLUMN /*1*/:
                sendMessage(EVENT_BROADCAST_SMS, tracker);
                return SEQUENCE_COLUMN;
            case EVENT_RELEASE_WAKELOCK /*5*/:
                return SEQUENCE_COLUMN;
            default:
                return EVENT_BROADCAST_SMS;
        }
    }

    boolean processMessagePart(InboundSmsTracker tracker) {
        byte[][] pdus;
        int messageCount = tracker.getMessageCount();
        int destPort = tracker.getDestPort();
        if (messageCount == SEQUENCE_COLUMN) {
            pdus = new byte[SEQUENCE_COLUMN][];
            pdus[PDU_COLUMN] = tracker.getPdu();
        } else {
            Cursor cursor = null;
            try {
                String address = tracker.getAddress();
                String refNumber = Integer.toString(tracker.getReferenceNumber());
                String count = Integer.toString(tracker.getMessageCount());
                String[] whereArgs = new String[EVENT_BROADCAST_COMPLETE];
                whereArgs[PDU_COLUMN] = address;
                whereArgs[SEQUENCE_COLUMN] = refNumber;
                whereArgs[EVENT_BROADCAST_SMS] = count;
                cursor = this.mResolver.query(sRawUri, PDU_SEQUENCE_PORT_PROJECTION, SELECT_BY_REFERENCE, whereArgs, null);
                if (cursor.getCount() >= messageCount) {
                    pdus = new byte[messageCount][];
                    while (cursor.moveToNext()) {
                        int index = cursor.getInt(SEQUENCE_COLUMN) - tracker.getIndexOffset();
                        pdus[index] = HexDump.hexStringToByteArray(cursor.getString(PDU_COLUMN));
                        if (index == 0 && !cursor.isNull(EVENT_BROADCAST_SMS)) {
                            int port = InboundSmsTracker.getRealDestPort(cursor.getInt(EVENT_BROADCAST_SMS));
                            if (port != -1) {
                                destPort = port;
                            }
                        }
                    }
                    if (cursor != null) {
                        cursor.close();
                    }
                } else if (cursor == null) {
                    return VDBG;
                } else {
                    cursor.close();
                    return VDBG;
                }
            } catch (Throwable e) {
                loge("Can't access multipart SMS database", e);
                if (cursor == null) {
                    return VDBG;
                }
                cursor.close();
                return VDBG;
            } catch (Throwable th) {
                if (cursor != null) {
                    cursor.close();
                }
            }
        }
        SmsBroadcastReceiver resultReceiver = new SmsBroadcastReceiver(tracker);
        if (destPort == SmsHeader.PORT_WAP_PUSH) {
            ByteArrayOutputStream output = new ByteArrayOutputStream();
            byte[][] arr$ = pdus;
            int len$ = arr$.length;
            for (int i$ = PDU_COLUMN; i$ < len$; i$ += SEQUENCE_COLUMN) {
                byte[] pdu = arr$[i$];
                if (!tracker.is3gpp2()) {
                    pdu = SmsMessage.createFromPdu(pdu, SmsMessage.FORMAT_3GPP).getUserData();
                }
                output.write(pdu, PDU_COLUMN, pdu.length);
            }
            int result = this.mWapPush.dispatchWapPdu(output.toByteArray(), resultReceiver, this);
            log("dispatchWapPdu() returned " + result);
            return result == -1 ? DBG : VDBG;
        } else {
            List<String> carrierPackages = null;
            UiccCard card = UiccController.getInstance().getUiccCard(this.mPhone.getPhoneId());
            if (card != null) {
                carrierPackages = card.getCarrierPackageNamesForIntent(this.mContext.getPackageManager(), new Intent("android.service.carrier.CarrierMessagingService"));
            } else {
                loge("UiccCard not initialized.");
            }
            List<String> systemPackages = getSystemAppForIntent(new Intent("android.service.carrier.CarrierMessagingService"));
            CarrierSmsFilter smsFilter;
            if (carrierPackages != null && carrierPackages.size() == SEQUENCE_COLUMN) {
                log("Found carrier package.");
                smsFilter = new CarrierSmsFilter(pdus, destPort, tracker.getFormat(), resultReceiver);
                smsFilter.filterSms((String) carrierPackages.get(PDU_COLUMN), new CarrierSmsFilterCallback(smsFilter));
            } else if (systemPackages == null || systemPackages.size() != SEQUENCE_COLUMN) {
                logv("Unable to find carrier package: " + carrierPackages + ", nor systemPackages: " + systemPackages);
                dispatchSmsDeliveryIntent(pdus, tracker.getFormat(), destPort, resultReceiver);
            } else {
                log("Found system package.");
                smsFilter = new CarrierSmsFilter(pdus, destPort, tracker.getFormat(), resultReceiver);
                smsFilter.filterSms((String) systemPackages.get(PDU_COLUMN), new CarrierSmsFilterCallback(smsFilter));
            }
            return DBG;
        }
    }

    private List<String> getSystemAppForIntent(Intent intent) {
        List<String> packages = new ArrayList();
        PackageManager packageManager = this.mContext.getPackageManager();
        String carrierFilterSmsPerm = "android.permission.CARRIER_FILTER_SMS";
        for (ResolveInfo info : packageManager.queryIntentServices(intent, PDU_COLUMN)) {
            if (info.serviceInfo == null) {
                loge("Can't get service information from " + info);
            } else {
                String packageName = info.serviceInfo.packageName;
                if (packageManager.checkPermission(carrierFilterSmsPerm, packageName) == 0) {
                    packages.add(packageName);
                    log("getSystemAppForIntent: added package " + packageName);
                }
            }
        }
        return packages;
    }

    protected void dispatchIntent(Intent intent, String permission, int appOp, BroadcastReceiver resultReceiver, UserHandle user) {
        intent.addFlags(134217728);
        SubscriptionManager.putPhoneIdAndSubIdExtra(intent, this.mPhone.getPhoneId());
        if (user.equals(UserHandle.ALL)) {
            int[] users = null;
            try {
                users = ActivityManagerNative.getDefault().getRunningUserIds();
            } catch (RemoteException e) {
            }
            if (users == null) {
                users = new int[SEQUENCE_COLUMN];
                users[PDU_COLUMN] = user.getIdentifier();
            }
            for (int i = users.length - 1; i >= 0; i--) {
                UserHandle targetUser = new UserHandle(users[i]);
                if (users[i] != 0) {
                    if (!this.mUserManager.hasUserRestriction("no_sms", targetUser)) {
                        UserInfo info = this.mUserManager.getUserInfo(users[i]);
                        if (info != null) {
                            if (info.isManagedProfile()) {
                            }
                        }
                    }
                }
                this.mContext.sendOrderedBroadcastAsUser(intent, targetUser, permission, appOp, users[i] == 0 ? resultReceiver : null, getHandler(), -1, null, null);
            }
            return;
        }
        this.mContext.sendOrderedBroadcastAsUser(intent, user, permission, appOp, resultReceiver, getHandler(), -1, null, null);
    }

    void deleteFromRawTable(String deleteWhere, String[] deleteWhereArgs) {
        int rows = this.mResolver.delete(sRawUri, deleteWhere, deleteWhereArgs);
        if (rows == 0) {
            loge("No rows were deleted from raw table!");
        } else {
            log("Deleted " + rows + " rows from raw table.");
        }
    }

    void dispatchSmsDeliveryIntent(byte[][] pdus, String format, int destPort, BroadcastReceiver resultReceiver) {
        Intent intent = new Intent();
        intent.putExtra("pdus", pdus);
        intent.putExtra(CellBroadcasts.MESSAGE_FORMAT, format);
        if (destPort == -1) {
            intent.setAction(Intents.SMS_DELIVER_ACTION);
            ComponentName componentName = SmsApplication.getDefaultSmsApplication(this.mContext, DBG);
            if (componentName != null) {
                intent.setComponent(componentName);
                log("Delivering SMS to: " + componentName.getPackageName() + " " + componentName.getClassName());
            } else {
                intent.setComponent(null);
            }
            if (SmsManager.getDefault().getAutoPersisting()) {
                Uri uri = writeInboxMessage(intent);
                if (uri != null) {
                    intent.putExtra("uri", uri.toString());
                }
            }
        } else {
            intent.setAction(Intents.DATA_SMS_RECEIVED_ACTION);
            intent.setData(Uri.parse("sms://localhost:" + destPort));
            intent.setComponent(null);
        }
        dispatchIntent(intent, "android.permission.RECEIVE_SMS", 16, resultReceiver, UserHandle.OWNER);
    }

    private int addTrackerToRawTable(InboundSmsTracker tracker) {
        if (tracker.getMessageCount() != SEQUENCE_COLUMN) {
            Cursor cursor = null;
            try {
                int sequence = tracker.getSequenceNumber();
                String address = tracker.getAddress();
                String refNumber = Integer.toString(tracker.getReferenceNumber());
                String count = Integer.toString(tracker.getMessageCount());
                String seqNumber = Integer.toString(sequence);
                String[] deleteWhereArgs = new String[EVENT_BROADCAST_COMPLETE];
                deleteWhereArgs[PDU_COLUMN] = address;
                deleteWhereArgs[SEQUENCE_COLUMN] = refNumber;
                deleteWhereArgs[EVENT_BROADCAST_SMS] = count;
                tracker.setDeleteWhere(SELECT_BY_REFERENCE, deleteWhereArgs);
                String[] strArr = new String[REFERENCE_NUMBER_COLUMN];
                strArr[PDU_COLUMN] = address;
                strArr[SEQUENCE_COLUMN] = refNumber;
                strArr[EVENT_BROADCAST_SMS] = count;
                strArr[EVENT_BROADCAST_COMPLETE] = seqNumber;
                cursor = this.mResolver.query(sRawUri, PDU_PROJECTION, "address=? AND reference_number=? AND count=? AND sequence=?", strArr, null);
                if (cursor.moveToNext()) {
                    loge("Discarding duplicate message segment, refNumber=" + refNumber + " seqNumber=" + seqNumber);
                    String oldPduString = cursor.getString(PDU_COLUMN);
                    byte[] pdu = tracker.getPdu();
                    byte[] oldPdu = HexDump.hexStringToByteArray(oldPduString);
                    if (!Arrays.equals(oldPdu, tracker.getPdu())) {
                        loge("Warning: dup message segment PDU of length " + pdu.length + " is different from existing PDU of length " + oldPdu.length);
                    }
                    if (cursor == null) {
                        return EVENT_RELEASE_WAKELOCK;
                    }
                    cursor.close();
                    return EVENT_RELEASE_WAKELOCK;
                }
                cursor.close();
                if (cursor != null) {
                    cursor.close();
                }
            } catch (SQLException e) {
                loge("Can't access multipart SMS database", e);
                if (cursor == null) {
                    return EVENT_BROADCAST_SMS;
                }
                cursor.close();
                return EVENT_BROADCAST_SMS;
            } catch (Throwable th) {
                if (cursor != null) {
                    cursor.close();
                }
            }
        }
        Uri newUri = this.mResolver.insert(sRawUri, tracker.getContentValues());
        log("URI of new row -> " + newUri);
        try {
            long rowId = ContentUris.parseId(newUri);
            if (tracker.getMessageCount() == SEQUENCE_COLUMN) {
                String str = SELECT_BY_ID;
                String[] strArr2 = new String[SEQUENCE_COLUMN];
                strArr2[PDU_COLUMN] = Long.toString(rowId);
                tracker.setDeleteWhere(str, strArr2);
            }
            return SEQUENCE_COLUMN;
        } catch (Exception e2) {
            loge("error parsing URI for new row: " + newUri, e2);
            return EVENT_BROADCAST_SMS;
        }
    }

    static boolean isCurrentFormat3gpp2() {
        return EVENT_BROADCAST_SMS == TelephonyManager.getDefault().getCurrentPhoneType() ? DBG : VDBG;
    }

    protected void storeVoiceMailCount() {
        String imsi = this.mPhone.getSubscriberId();
        int mwi = this.mPhone.getVoiceMessageCount();
        StringBuilder append = new StringBuilder().append("Storing Voice Mail Count = ").append(mwi).append(" for mVmCountKey = ");
        PhoneBase phoneBase = this.mPhone;
        append = append.append(PhoneBase.VM_COUNT).append(" vmId = ");
        phoneBase = this.mPhone;
        log(append.append(PhoneBase.VM_ID).append(" in preferences.").toString());
        Editor editor = PreferenceManager.getDefaultSharedPreferences(this.mContext).edit();
        PhoneBase phoneBase2 = this.mPhone;
        editor.putInt(PhoneBase.VM_COUNT, mwi);
        phoneBase2 = this.mPhone;
        editor.putString(PhoneBase.VM_ID, imsi);
        editor.commit();
    }

    protected void log(String s) {
        Rlog.d(getName(), s);
    }

    protected void loge(String s) {
        Rlog.e(getName(), s);
    }

    protected void loge(String s, Throwable e) {
        Rlog.e(getName(), s, e);
    }

    private Uri writeInboxMessage(Intent intent) {
        Uri uri = null;
        SmsMessage[] messages = Intents.getMessagesFromIntent(intent);
        if (messages == null || messages.length < SEQUENCE_COLUMN) {
            loge("Failed to parse SMS pdu");
        } else {
            SmsMessage[] arr$ = messages;
            int len$ = arr$.length;
            int i$ = PDU_COLUMN;
            while (i$ < len$) {
                try {
                    arr$[i$].getDisplayMessageBody();
                    i$ += SEQUENCE_COLUMN;
                } catch (NullPointerException e) {
                    loge("NPE inside SmsMessage");
                }
            }
            ContentValues values = parseSmsMessage(messages);
            long identity = Binder.clearCallingIdentity();
            try {
                uri = this.mContext.getContentResolver().insert(Inbox.CONTENT_URI, values);
            } catch (Exception e2) {
                loge("Failed to persist inbox message", e2);
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }
        return uri;
    }

    private static ContentValues parseSmsMessage(SmsMessage[] msgs) {
        int i = PDU_COLUMN;
        SmsMessage sms = msgs[PDU_COLUMN];
        ContentValues values = new ContentValues();
        values.put(TextBasedSmsColumns.ADDRESS, sms.getDisplayOriginatingAddress());
        values.put(TextBasedSmsColumns.BODY, buildMessageBodyFromPdus(msgs));
        values.put(TextBasedSmsColumns.DATE_SENT, Long.valueOf(sms.getTimestampMillis()));
        values.put(ThreadsColumns.DATE, Long.valueOf(System.currentTimeMillis()));
        values.put(TextBasedSmsColumns.PROTOCOL, Integer.valueOf(sms.getProtocolIdentifier()));
        values.put(SmsManager.MESSAGE_STATUS_SEEN, Integer.valueOf(PDU_COLUMN));
        values.put(SmsManager.MESSAGE_STATUS_READ, Integer.valueOf(PDU_COLUMN));
        String subject = sms.getPseudoSubject();
        if (!TextUtils.isEmpty(subject)) {
            values.put(TextBasedSmsColumns.SUBJECT, subject);
        }
        String str = TextBasedSmsColumns.REPLY_PATH_PRESENT;
        if (sms.isReplyPathPresent()) {
            i = SEQUENCE_COLUMN;
        }
        values.put(str, Integer.valueOf(i));
        values.put(TextBasedSmsColumns.SERVICE_CENTER, sms.getServiceCenterAddress());
        return values;
    }

    private static String buildMessageBodyFromPdus(SmsMessage[] msgs) {
        if (msgs.length == SEQUENCE_COLUMN) {
            return replaceFormFeeds(msgs[PDU_COLUMN].getDisplayMessageBody());
        }
        StringBuilder body = new StringBuilder();
        SmsMessage[] arr$ = msgs;
        int len$ = arr$.length;
        for (int i$ = PDU_COLUMN; i$ < len$; i$ += SEQUENCE_COLUMN) {
            body.append(arr$[i$].getDisplayMessageBody());
        }
        return replaceFormFeeds(body.toString());
    }

    private static String replaceFormFeeds(String s) {
        return s == null ? "" : s.replace('\f', '\n');
    }
}
