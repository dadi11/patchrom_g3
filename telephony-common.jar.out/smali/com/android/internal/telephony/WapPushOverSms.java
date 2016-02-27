package com.android.internal.telephony;

import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.database.Cursor;
import android.database.DatabaseUtils;
import android.database.sqlite.SQLiteException;
import android.database.sqlite.SqliteWrapper;
import android.net.Uri;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;
import android.os.UserHandle;
import android.provider.Telephony.Mms;
import android.provider.Telephony.Mms.Inbox;
import android.provider.Telephony.Sms.Intents;
import android.provider.Telephony.TextBasedSmsColumns;
import android.telephony.Rlog;
import android.telephony.SmsManager;
import android.telephony.SubscriptionManager;
import android.util.Log;
import com.android.internal.telephony.IWapPushManager.Stub;
import com.android.internal.telephony.uicc.IccUtils;
import com.google.android.mms.ContentType;
import com.google.android.mms.pdu.DeliveryInd;
import com.google.android.mms.pdu.GenericPdu;
import com.google.android.mms.pdu.NotificationInd;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduParser;
import com.google.android.mms.pdu.PduPart;
import com.google.android.mms.pdu.PduPersister;
import com.google.android.mms.pdu.ReadOrigInd;

public class WapPushOverSms implements ServiceConnection {
    private static final boolean DBG = true;
    private static final String LOCATION_SELECTION = "m_type=? AND ct_l =?";
    private static final String TAG = "WAP PUSH";
    private static final String THREAD_ID_SELECTION = "m_id=? AND m_type=?";
    private final Context mContext;
    private volatile IWapPushManager mWapPushManager;

    public void onServiceConnected(ComponentName name, IBinder service) {
        this.mWapPushManager = Stub.asInterface(service);
        Rlog.v(TAG, "wappush manager connected to " + hashCode());
    }

    public void onServiceDisconnected(ComponentName name) {
        this.mWapPushManager = null;
        Rlog.v(TAG, "wappush manager disconnected.");
    }

    public WapPushOverSms(Context context) {
        this.mContext = context;
        Intent intent = new Intent(IWapPushManager.class.getName());
        ComponentName comp = intent.resolveSystemService(context.getPackageManager(), 0);
        intent.setComponent(comp);
        if (comp == null || !context.bindService(intent, this, 1)) {
            Rlog.e(TAG, "bindService() for wappush manager failed");
        } else {
            Rlog.v(TAG, "bindService() for wappush manager succeeded");
        }
    }

    void dispose() {
        if (this.mWapPushManager != null) {
            Rlog.v(TAG, "dispose: unbind wappush manager");
            this.mContext.unbindService(this);
            return;
        }
        Rlog.e(TAG, "dispose: not bound to a wappush manager");
    }

    public int dispatchWapPdu(byte[] pdu, BroadcastReceiver receiver, InboundSmsHandler handler) {
        ArrayIndexOutOfBoundsException aie;
        Rlog.d(TAG, "Rx: " + IccUtils.bytesToHexString(pdu));
        int index = 0 + 1;
        int index2;
        try {
            int transactionId = pdu[0] & PduHeaders.STORE_STATUS_ERROR_END;
            index2 = index + 1;
            try {
                int pduType = pdu[index] & PduHeaders.STORE_STATUS_ERROR_END;
                int phoneId = handler.getPhone().getPhoneId();
                if (!(pduType == 6 || pduType == 7)) {
                    index2 = this.mContext.getResources().getInteger(17694845);
                    if (index2 != -1) {
                        index = index2 + 1;
                        transactionId = pdu[index2] & PduHeaders.STORE_STATUS_ERROR_END;
                        index2 = index + 1;
                        pduType = pdu[index] & PduHeaders.STORE_STATUS_ERROR_END;
                        Rlog.d(TAG, "index = " + index2 + " PDU Type = " + pduType + " transactionID = " + transactionId);
                        if (!(pduType == 6 || pduType == 7)) {
                            Rlog.w(TAG, "Received non-PUSH WAP PDU. Type = " + pduType);
                            return 1;
                        }
                    }
                    Rlog.w(TAG, "Received non-PUSH WAP PDU. Type = " + pduType);
                    return 1;
                }
                WspTypeDecoder wspTypeDecoder = new WspTypeDecoder(pdu);
                if (wspTypeDecoder.decodeUintvarInteger(index2)) {
                    int headerLength = (int) wspTypeDecoder.getValue32();
                    index2 += wspTypeDecoder.getDecodedDataLength();
                    int headerStartIndex = index2;
                    if (wspTypeDecoder.decodeContentType(index2)) {
                        byte[] intentData;
                        int[] subIds;
                        int subId;
                        String wapAppId;
                        String contentType;
                        boolean processFurther;
                        IWapPushManager wapPushMan;
                        Intent intent;
                        int procRet;
                        String permission;
                        int appOp;
                        ComponentName componentName;
                        String mimeType = wspTypeDecoder.getValueString();
                        long binaryContentType = wspTypeDecoder.getValue32();
                        index2 += wspTypeDecoder.getDecodedDataLength();
                        byte[] header = new byte[headerLength];
                        System.arraycopy(pdu, headerStartIndex, header, 0, header.length);
                        if (mimeType != null) {
                            if (mimeType.equals(WspTypeDecoder.CONTENT_TYPE_B_PUSH_CO)) {
                                intentData = pdu;
                                if (SmsManager.getDefault().getAutoPersisting()) {
                                    subIds = SubscriptionManager.getSubId(phoneId);
                                    subId = (subIds != null || subIds.length <= 0) ? SmsManager.getDefaultSmsSubscriptionId() : subIds[0];
                                    writeInboxMessage(subId, intentData);
                                }
                                if (wspTypeDecoder.seekXWapApplicationId(index2, (index2 + headerLength) - 1)) {
                                    wspTypeDecoder.decodeXWapApplicationId((int) wspTypeDecoder.getValue32());
                                    wapAppId = wspTypeDecoder.getValueString();
                                    if (wapAppId == null) {
                                        wapAppId = Integer.toString((int) wspTypeDecoder.getValue32());
                                    }
                                    if (mimeType != null) {
                                        contentType = Long.toString(binaryContentType);
                                    } else {
                                        contentType = mimeType;
                                    }
                                    Rlog.v(TAG, "appid found: " + wapAppId + ":" + contentType);
                                    processFurther = DBG;
                                    try {
                                        wapPushMan = this.mWapPushManager;
                                        if (wapPushMan != null) {
                                            Rlog.w(TAG, "wap push manager not found!");
                                        } else {
                                            intent = new Intent();
                                            intent.putExtra("transactionId", transactionId);
                                            intent.putExtra("pduType", pduType);
                                            intent.putExtra("header", header);
                                            intent.putExtra("data", intentData);
                                            intent.putExtra("contentTypeParameters", wspTypeDecoder.getContentParameters());
                                            SubscriptionManager.putPhoneIdAndSubIdExtra(intent, phoneId);
                                            procRet = wapPushMan.processMessage(wapAppId, contentType, intent);
                                            Rlog.v(TAG, "procRet:" + procRet);
                                            if ((procRet & 1) > 0 && (WapPushManagerParams.FURTHER_PROCESSING & procRet) == 0) {
                                                processFurther = false;
                                            }
                                        }
                                        if (!processFurther) {
                                            return 1;
                                        }
                                    } catch (RemoteException e) {
                                        Rlog.w(TAG, "remote func failed...");
                                    }
                                }
                                Rlog.v(TAG, "fall back to existing handler");
                                if (mimeType != null) {
                                    Rlog.w(TAG, "Header Content-Type error.");
                                    return 2;
                                }
                                if (mimeType.equals(ContentType.MMS_MESSAGE)) {
                                    permission = "android.permission.RECEIVE_WAP_PUSH";
                                    appOp = 19;
                                } else {
                                    permission = "android.permission.RECEIVE_MMS";
                                    appOp = 18;
                                }
                                intent = new Intent(Intents.WAP_PUSH_DELIVER_ACTION);
                                intent.setType(mimeType);
                                intent.putExtra("transactionId", transactionId);
                                intent.putExtra("pduType", pduType);
                                intent.putExtra("header", header);
                                intent.putExtra("data", intentData);
                                intent.putExtra("contentTypeParameters", wspTypeDecoder.getContentParameters());
                                SubscriptionManager.putPhoneIdAndSubIdExtra(intent, phoneId);
                                componentName = SmsApplication.getDefaultMmsApplication(this.mContext, DBG);
                                if (componentName != null) {
                                    intent.setComponent(componentName);
                                    Rlog.v(TAG, "Delivering MMS to: " + componentName.getPackageName() + " " + componentName.getClassName());
                                }
                                handler.dispatchIntent(intent, permission, appOp, receiver, UserHandle.OWNER);
                                return -1;
                            }
                        }
                        int dataIndex = headerStartIndex + headerLength;
                        intentData = new byte[(pdu.length - dataIndex)];
                        System.arraycopy(pdu, dataIndex, intentData, 0, intentData.length);
                        if (SmsManager.getDefault().getAutoPersisting()) {
                            subIds = SubscriptionManager.getSubId(phoneId);
                            if (subIds != null) {
                            }
                            writeInboxMessage(subId, intentData);
                        }
                        if (wspTypeDecoder.seekXWapApplicationId(index2, (index2 + headerLength) - 1)) {
                            wspTypeDecoder.decodeXWapApplicationId((int) wspTypeDecoder.getValue32());
                            wapAppId = wspTypeDecoder.getValueString();
                            if (wapAppId == null) {
                                wapAppId = Integer.toString((int) wspTypeDecoder.getValue32());
                            }
                            if (mimeType != null) {
                                contentType = mimeType;
                            } else {
                                contentType = Long.toString(binaryContentType);
                            }
                            Rlog.v(TAG, "appid found: " + wapAppId + ":" + contentType);
                            processFurther = DBG;
                            wapPushMan = this.mWapPushManager;
                            if (wapPushMan != null) {
                                intent = new Intent();
                                intent.putExtra("transactionId", transactionId);
                                intent.putExtra("pduType", pduType);
                                intent.putExtra("header", header);
                                intent.putExtra("data", intentData);
                                intent.putExtra("contentTypeParameters", wspTypeDecoder.getContentParameters());
                                SubscriptionManager.putPhoneIdAndSubIdExtra(intent, phoneId);
                                procRet = wapPushMan.processMessage(wapAppId, contentType, intent);
                                Rlog.v(TAG, "procRet:" + procRet);
                                processFurther = false;
                            } else {
                                Rlog.w(TAG, "wap push manager not found!");
                            }
                            if (processFurther) {
                                return 1;
                            }
                        }
                        Rlog.v(TAG, "fall back to existing handler");
                        if (mimeType != null) {
                            if (mimeType.equals(ContentType.MMS_MESSAGE)) {
                                permission = "android.permission.RECEIVE_WAP_PUSH";
                                appOp = 19;
                            } else {
                                permission = "android.permission.RECEIVE_MMS";
                                appOp = 18;
                            }
                            intent = new Intent(Intents.WAP_PUSH_DELIVER_ACTION);
                            intent.setType(mimeType);
                            intent.putExtra("transactionId", transactionId);
                            intent.putExtra("pduType", pduType);
                            intent.putExtra("header", header);
                            intent.putExtra("data", intentData);
                            intent.putExtra("contentTypeParameters", wspTypeDecoder.getContentParameters());
                            SubscriptionManager.putPhoneIdAndSubIdExtra(intent, phoneId);
                            componentName = SmsApplication.getDefaultMmsApplication(this.mContext, DBG);
                            if (componentName != null) {
                                intent.setComponent(componentName);
                                Rlog.v(TAG, "Delivering MMS to: " + componentName.getPackageName() + " " + componentName.getClassName());
                            }
                            handler.dispatchIntent(intent, permission, appOp, receiver, UserHandle.OWNER);
                            return -1;
                        }
                        Rlog.w(TAG, "Header Content-Type error.");
                        return 2;
                    }
                    Rlog.w(TAG, "Received PDU. Header Content-Type error.");
                    return 2;
                }
                Rlog.w(TAG, "Received PDU. Header Length error.");
                return 2;
            } catch (ArrayIndexOutOfBoundsException e2) {
                aie = e2;
                Rlog.e(TAG, "ignoring dispatchWapPdu() array index exception: " + aie);
                return 2;
            }
        } catch (ArrayIndexOutOfBoundsException e3) {
            aie = e3;
            index2 = index;
            Rlog.e(TAG, "ignoring dispatchWapPdu() array index exception: " + aie);
            return 2;
        }
    }

    private static boolean shouldParseContentDisposition(int subId) {
        return SmsManager.getSmsManagerForSubscriptionId(subId).getCarrierConfigValues().getBoolean(SmsManager.MMS_CONFIG_SUPPORT_MMS_CONTENT_DISPOSITION, DBG);
    }

    private void writeInboxMessage(int subId, byte[] pushData) {
        GenericPdu pdu = new PduParser(pushData, shouldParseContentDisposition(subId)).parse();
        if (pdu == null) {
            Rlog.e(TAG, "Invalid PUSH PDU");
        }
        PduPersister persister = PduPersister.getPduPersister(this.mContext);
        int type = pdu.getMessageType();
        switch (type) {
            case PduPart.P_LEVEL /*130*/:
                NotificationInd nInd = (NotificationInd) pdu;
                Bundle configs = SmsManager.getSmsManagerForSubscriptionId(subId).getCarrierConfigValues();
                if (configs != null && configs.getBoolean(SmsManager.MMS_CONFIG_APPEND_TRANSACTION_ID, false)) {
                    byte[] contentLocation = nInd.getContentLocation();
                    if (61 == contentLocation[contentLocation.length - 1]) {
                        byte[] transactionId = nInd.getTransactionId();
                        byte[] contentLocationWithId = new byte[(contentLocation.length + transactionId.length)];
                        System.arraycopy(contentLocation, 0, contentLocationWithId, 0, contentLocation.length);
                        System.arraycopy(transactionId, 0, contentLocationWithId, contentLocation.length, transactionId.length);
                        nInd.setContentLocation(contentLocationWithId);
                    }
                }
                if (isDuplicateNotification(this.mContext, nInd)) {
                    Rlog.d(TAG, "Skip storing duplicate MMS WAP push notification ind: " + new String(nInd.getContentLocation()));
                    return;
                }
                if (persister.persist(pdu, Inbox.CONTENT_URI, DBG, DBG, null) == null) {
                    Rlog.e(TAG, "Failed to save MMS WAP push notification ind");
                }
            case PduPart.P_DEP_FILENAME /*134*/:
            case PduPart.P_PADDING /*136*/:
                long threadId = getDeliveryOrReadReportThreadId(this.mContext, pdu);
                if (threadId == -1) {
                    Rlog.e(TAG, "Failed to find delivery or read report's thread id");
                    return;
                }
                Uri uri = persister.persist(pdu, Inbox.CONTENT_URI, DBG, DBG, null);
                if (uri == null) {
                    Rlog.e(TAG, "Failed to persist delivery or read report");
                    return;
                }
                ContentValues values = new ContentValues(1);
                values.put(TextBasedSmsColumns.THREAD_ID, Long.valueOf(threadId));
                if (SqliteWrapper.update(this.mContext, this.mContext.getContentResolver(), uri, values, null, null) != 1) {
                    Rlog.e(TAG, "Failed to update delivery or read report thread id");
                }
            default:
                try {
                    Log.e(TAG, "Received unrecognized WAP Push PDU.");
                } catch (Throwable e) {
                    Log.e(TAG, "Failed to save MMS WAP push data: type=" + type, e);
                } catch (Throwable e2) {
                    Log.e(TAG, "Unexpected RuntimeException in persisting MMS WAP push data", e2);
                }
        }
    }

    private static long getDeliveryOrReadReportThreadId(Context context, GenericPdu pdu) {
        String messageId;
        if (pdu instanceof DeliveryInd) {
            messageId = new String(((DeliveryInd) pdu).getMessageId());
        } else if (pdu instanceof ReadOrigInd) {
            messageId = new String(((ReadOrigInd) pdu).getMessageId());
        } else {
            Rlog.e(TAG, "WAP Push data is neither delivery or read report type: " + pdu.getClass().getCanonicalName());
            return -1;
        }
        Cursor cursor = null;
        try {
            cursor = SqliteWrapper.query(context, context.getContentResolver(), Mms.CONTENT_URI, new String[]{TextBasedSmsColumns.THREAD_ID}, THREAD_ID_SELECTION, new String[]{DatabaseUtils.sqlEscapeString(messageId), Integer.toString(PduPart.P_Q)}, null);
            if (cursor == null || !cursor.moveToFirst()) {
                if (cursor != null) {
                    cursor.close();
                }
                return -1;
            }
            long j = cursor.getLong(0);
            if (cursor == null) {
                return j;
            }
            cursor.close();
            return j;
        } catch (SQLiteException e) {
            Rlog.e(TAG, "Failed to query delivery or read report thread id", e);
            if (cursor != null) {
                cursor.close();
            }
        } catch (Throwable th) {
            if (cursor != null) {
                cursor.close();
            }
        }
    }

    private static boolean isDuplicateNotification(Context context, NotificationInd nInd) {
        if (nInd.getContentLocation() != null) {
            String[] selectionArgs = new String[]{new String(nInd.getContentLocation())};
            Cursor cursor = null;
            try {
                cursor = SqliteWrapper.query(context, context.getContentResolver(), Mms.CONTENT_URI, new String[]{HbpcdLookup.ID}, LOCATION_SELECTION, new String[]{Integer.toString(PduPart.P_LEVEL), new String(rawLocation)}, null);
                if (cursor != null && cursor.getCount() > 0) {
                    if (cursor != null) {
                        cursor.close();
                    }
                    return DBG;
                } else if (cursor != null) {
                    cursor.close();
                }
            } catch (SQLiteException e) {
                Rlog.e(TAG, "failed to query existing notification ind", e);
                if (cursor != null) {
                    cursor.close();
                }
            } catch (Throwable th) {
                if (cursor != null) {
                    cursor.close();
                }
            }
        }
        return false;
    }
}
