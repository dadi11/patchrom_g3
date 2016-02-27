package com.android.internal.telephony;

import android.content.Context;
import android.content.res.Resources;
import android.hardware.display.DisplayManager;
import android.hardware.display.DisplayManager.DisplayListener;
import android.net.ConnectivityManager;
import android.net.LocalSocket;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.Message;
import android.os.Parcel;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.SystemProperties;
import android.telephony.CellInfo;
import android.telephony.NeighboringCellInfo;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.telephony.SignalStrength;
import android.telephony.SmsMessage;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Base64;
import android.util.SparseArray;
import android.view.Display;
import com.android.internal.telephony.CommandException.Error;
import com.android.internal.telephony.CommandsInterface.RadioState;
import com.android.internal.telephony.cdma.CdmaCallWaitingNotification;
import com.android.internal.telephony.cdma.CdmaInformationRecords;
import com.android.internal.telephony.cdma.CdmaInformationRecords.CdmaDisplayInfoRec;
import com.android.internal.telephony.cdma.CdmaInformationRecords.CdmaLineControlInfoRec;
import com.android.internal.telephony.cdma.CdmaInformationRecords.CdmaNumberInfoRec;
import com.android.internal.telephony.cdma.CdmaInformationRecords.CdmaRedirectingNumberInfoRec;
import com.android.internal.telephony.cdma.CdmaInformationRecords.CdmaSignalInfoRec;
import com.android.internal.telephony.cdma.CdmaInformationRecords.CdmaT53AudioControlInfoRec;
import com.android.internal.telephony.cdma.CdmaInformationRecords.CdmaT53ClirInfoRec;
import com.android.internal.telephony.cdma.CdmaSmsBroadcastConfigInfo;
import com.android.internal.telephony.cdma.SignalToneUtil;
import com.android.internal.telephony.cdma.sms.CdmaSmsAddress;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.dataconnection.DataCallResponse;
import com.android.internal.telephony.dataconnection.DataProfile;
import com.android.internal.telephony.dataconnection.DcFailCause;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.gsm.SmsBroadcastConfigInfo;
import com.android.internal.telephony.gsm.SsData;
import com.android.internal.telephony.gsm.SuppServiceNotification;
import com.android.internal.telephony.uicc.IccCardApplicationStatus;
import com.android.internal.telephony.uicc.IccCardStatus;
import com.android.internal.telephony.uicc.IccIoResult;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.IccRefreshResponse;
import com.android.internal.telephony.uicc.IccUtils;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPart;
import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.concurrent.atomic.AtomicBoolean;

public class RIL extends BaseCommands implements CommandsInterface {
    private static final int CDMA_BROADCAST_SMS_NO_OF_SERVICE_CATEGORIES = 31;
    private static final int CDMA_BSI_NO_OF_INTS_STRUCT = 3;
    private static final int DEFAULT_WAKE_LOCK_TIMEOUT = 60000;
    static final int EVENT_SEND = 1;
    static final int EVENT_WAKE_LOCK_TIMEOUT = 2;
    static final int RESPONSE_SOLICITED = 0;
    static final int RESPONSE_UNSOLICITED = 1;
    static final boolean RILJ_LOGD = true;
    static final boolean RILJ_LOGV = false;
    static final String RILJ_LOG_TAG = "RILJ";
    static final int RIL_MAX_COMMAND_BYTES = 8192;
    static final String[] SOCKET_NAME_RIL;
    static final int SOCKET_OPEN_RETRY_MILLIS = 4000;
    Display mDefaultDisplay;
    int mDefaultDisplayState;
    private final DisplayListener mDisplayListener;
    protected Integer mInstanceId;
    Object mLastNITZTimeInfo;
    protected int mQANElements;
    RILReceiver mReceiver;
    Thread mReceiverThread;
    SparseArray<RILRequest> mRequestList;
    RILSender mSender;
    HandlerThread mSenderThread;
    LocalSocket mSocket;
    private Handler mSupportedRafHandler;
    AtomicBoolean mTestingEmergencyCall;
    WakeLock mWakeLock;
    int mWakeLockCount;
    final int mWakeLockTimeout;

    /* renamed from: com.android.internal.telephony.RIL.1 */
    class C00151 implements DisplayListener {
        C00151() {
        }

        public void onDisplayAdded(int displayId) {
        }

        public void onDisplayRemoved(int displayId) {
        }

        public void onDisplayChanged(int displayId) {
            if (displayId == 0) {
                RIL.this.updateScreenState();
            }
        }
    }

    /* renamed from: com.android.internal.telephony.RIL.2 */
    class C00162 extends Handler {
        C00162() {
        }

        public void handleMessage(Message msg) {
            AsyncResult ar = msg.obj;
            RadioCapability rc = ar.result;
            if (ar.exception != null) {
                RIL.this.riljLog("Get supported radio access family fail");
                return;
            }
            RIL.this.mSupportedRaf = rc.getRadioAccessFamily();
            RIL.this.riljLog("Supported radio access family=" + RIL.this.mSupportedRaf);
        }
    }

    class RILReceiver implements Runnable {
        byte[] buffer;

        RILReceiver() {
            this.buffer = new byte[RIL.RIL_MAX_COMMAND_BYTES];
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void run() {
            /*
            r18 = this;
            r9 = 0;
            r10 = "rild";
        L_0x0003:
            r11 = 0;
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ Throwable -> 0x0198 }
            r15 = r15.mInstanceId;	 Catch:{ Throwable -> 0x0198 }
            if (r15 == 0) goto L_0x0018;
        L_0x000c:
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ Throwable -> 0x0198 }
            r15 = r15.mInstanceId;	 Catch:{ Throwable -> 0x0198 }
            r15 = r15.intValue();	 Catch:{ Throwable -> 0x0198 }
            if (r15 != 0) goto L_0x011c;
        L_0x0018:
            r15 = com.android.internal.telephony.RIL.SOCKET_NAME_RIL;	 Catch:{ Throwable -> 0x0198 }
            r16 = 0;
            r10 = r15[r16];	 Catch:{ Throwable -> 0x0198 }
        L_0x001e:
            r12 = new android.net.LocalSocket;	 Catch:{ IOException -> 0x0132 }
            r12.<init>();	 Catch:{ IOException -> 0x0132 }
            r6 = new android.net.LocalSocketAddress;	 Catch:{ IOException -> 0x022b }
            r15 = android.net.LocalSocketAddress.Namespace.RESERVED;	 Catch:{ IOException -> 0x022b }
            r6.<init>(r10, r15);	 Catch:{ IOException -> 0x022b }
            r12.connect(r6);	 Catch:{ IOException -> 0x022b }
            r9 = 0;
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ Throwable -> 0x0107 }
            r15.mSocket = r12;	 Catch:{ Throwable -> 0x0107 }
            r15 = "RILJ";
            r16 = new java.lang.StringBuilder;	 Catch:{ Throwable -> 0x0107 }
            r16.<init>();	 Catch:{ Throwable -> 0x0107 }
            r17 = "(";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r0 = r18;
            r0 = com.android.internal.telephony.RIL.this;	 Catch:{ Throwable -> 0x0107 }
            r17 = r0;
            r0 = r17;
            r0 = r0.mInstanceId;	 Catch:{ Throwable -> 0x0107 }
            r17 = r0;
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r17 = ") Connected to '";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r0 = r16;
            r16 = r0.append(r10);	 Catch:{ Throwable -> 0x0107 }
            r17 = "' socket";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r16 = r16.toString();	 Catch:{ Throwable -> 0x0107 }
            android.telephony.Rlog.i(r15, r16);	 Catch:{ Throwable -> 0x0107 }
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ Throwable -> 0x0107 }
            r16 = "qcomdsds";
            r15 = r15.needsOldRilFeature(r16);	 Catch:{ Throwable -> 0x0107 }
            if (r15 == 0) goto L_0x0090;
        L_0x0076:
            r13 = "SUB1";
            r2 = r13.getBytes();	 Catch:{ Throwable -> 0x0107 }
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ IOException -> 0x019b, RuntimeException -> 0x01a7 }
            r15 = r15.mSocket;	 Catch:{ IOException -> 0x019b, RuntimeException -> 0x01a7 }
            r15 = r15.getOutputStream();	 Catch:{ IOException -> 0x019b, RuntimeException -> 0x01a7 }
            r15.write(r2);	 Catch:{ IOException -> 0x019b, RuntimeException -> 0x01a7 }
            r15 = "RILJ";
            r16 = "Data sent!!";
            android.telephony.Rlog.i(r15, r16);	 Catch:{ IOException -> 0x019b, RuntimeException -> 0x01a7 }
        L_0x0090:
            r7 = 0;
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            r15 = r15.mSocket;	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            r5 = r15.getInputStream();	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
        L_0x009b:
            r0 = r18;
            r15 = r0.buffer;	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            r7 = com.android.internal.telephony.RIL.readRilMessage(r5, r15);	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            if (r7 >= 0) goto L_0x01b3;
        L_0x00a5:
            r15 = "RILJ";
            r16 = new java.lang.StringBuilder;	 Catch:{ Throwable -> 0x0107 }
            r16.<init>();	 Catch:{ Throwable -> 0x0107 }
            r17 = "(";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r0 = r18;
            r0 = com.android.internal.telephony.RIL.this;	 Catch:{ Throwable -> 0x0107 }
            r17 = r0;
            r0 = r17;
            r0 = r0.mInstanceId;	 Catch:{ Throwable -> 0x0107 }
            r17 = r0;
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r17 = ") Disconnected from '";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r0 = r16;
            r16 = r0.append(r10);	 Catch:{ Throwable -> 0x0107 }
            r17 = "' socket";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r16 = r16.toString();	 Catch:{ Throwable -> 0x0107 }
            android.telephony.Rlog.i(r15, r16);	 Catch:{ Throwable -> 0x0107 }
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ Throwable -> 0x0107 }
            r16 = com.android.internal.telephony.CommandsInterface.RadioState.RADIO_UNAVAILABLE;	 Catch:{ Throwable -> 0x0107 }
            r15.setRadioState(r16);	 Catch:{ Throwable -> 0x0107 }
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ IOException -> 0x0228 }
            r15 = r15.mSocket;	 Catch:{ IOException -> 0x0228 }
            r15.close();	 Catch:{ IOException -> 0x0228 }
        L_0x00ed:
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ Throwable -> 0x0107 }
            r16 = 0;
            r0 = r16;
            r15.mSocket = r0;	 Catch:{ Throwable -> 0x0107 }
            com.android.internal.telephony.RILRequest.resetSerial();	 Catch:{ Throwable -> 0x0107 }
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ Throwable -> 0x0107 }
            r16 = 1;
            r17 = 0;
            r15.clearRequestList(r16, r17);	 Catch:{ Throwable -> 0x0107 }
            goto L_0x0003;
        L_0x0107:
            r14 = move-exception;
            r11 = r12;
        L_0x0109:
            r15 = "RILJ";
            r16 = "Uncaught exception";
            r0 = r16;
            android.telephony.Rlog.e(r15, r0, r14);
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;
            r16 = -1;
            r15.notifyRegistrantsRilConnectionChanged(r16);
            return;
        L_0x011c:
            r15 = com.android.internal.telephony.RIL.SOCKET_NAME_RIL;	 Catch:{ Throwable -> 0x0198 }
            r0 = r18;
            r0 = com.android.internal.telephony.RIL.this;	 Catch:{ Throwable -> 0x0198 }
            r16 = r0;
            r0 = r16;
            r0 = r0.mInstanceId;	 Catch:{ Throwable -> 0x0198 }
            r16 = r0;
            r16 = r16.intValue();	 Catch:{ Throwable -> 0x0198 }
            r10 = r15[r16];	 Catch:{ Throwable -> 0x0198 }
            goto L_0x001e;
        L_0x0132:
            r3 = move-exception;
        L_0x0133:
            if (r11 == 0) goto L_0x0138;
        L_0x0135:
            r11.close();	 Catch:{ IOException -> 0x0222 }
        L_0x0138:
            r15 = 8;
            if (r9 != r15) goto L_0x0171;
        L_0x013c:
            r15 = "RILJ";
            r16 = new java.lang.StringBuilder;	 Catch:{ Throwable -> 0x0198 }
            r16.<init>();	 Catch:{ Throwable -> 0x0198 }
            r17 = "Couldn't find '";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0198 }
            r0 = r16;
            r16 = r0.append(r10);	 Catch:{ Throwable -> 0x0198 }
            r17 = "' socket after ";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0198 }
            r0 = r16;
            r16 = r0.append(r9);	 Catch:{ Throwable -> 0x0198 }
            r17 = " times, continuing to retry silently";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0198 }
            r16 = r16.toString();	 Catch:{ Throwable -> 0x0198 }
            android.telephony.Rlog.e(r15, r16);	 Catch:{ Throwable -> 0x0198 }
        L_0x0168:
            r16 = 4000; // 0xfa0 float:5.605E-42 double:1.9763E-320;
            java.lang.Thread.sleep(r16);	 Catch:{ InterruptedException -> 0x0225 }
        L_0x016d:
            r9 = r9 + 1;
            goto L_0x0003;
        L_0x0171:
            if (r9 < 0) goto L_0x0168;
        L_0x0173:
            r15 = 8;
            if (r9 >= r15) goto L_0x0168;
        L_0x0177:
            r15 = "RILJ";
            r16 = new java.lang.StringBuilder;	 Catch:{ Throwable -> 0x0198 }
            r16.<init>();	 Catch:{ Throwable -> 0x0198 }
            r17 = "Couldn't find '";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0198 }
            r0 = r16;
            r16 = r0.append(r10);	 Catch:{ Throwable -> 0x0198 }
            r17 = "' socket; retrying after timeout";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0198 }
            r16 = r16.toString();	 Catch:{ Throwable -> 0x0198 }
            android.telephony.Rlog.i(r15, r16);	 Catch:{ Throwable -> 0x0198 }
            goto L_0x0168;
        L_0x0198:
            r14 = move-exception;
            goto L_0x0109;
        L_0x019b:
            r3 = move-exception;
            r15 = "RILJ";
            r16 = "IOException";
            r0 = r16;
            android.telephony.Rlog.e(r15, r0, r3);	 Catch:{ Throwable -> 0x0107 }
            goto L_0x0090;
        L_0x01a7:
            r4 = move-exception;
            r15 = "RILJ";
            r16 = "Uncaught exception ";
            r0 = r16;
            android.telephony.Rlog.e(r15, r0, r4);	 Catch:{ Throwable -> 0x0107 }
            goto L_0x0090;
        L_0x01b3:
            r8 = android.os.Parcel.obtain();	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            r0 = r18;
            r15 = r0.buffer;	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            r16 = 0;
            r0 = r16;
            r8.unmarshall(r15, r0, r7);	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            r15 = 0;
            r8.setDataPosition(r15);	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            r0 = r18;
            r15 = com.android.internal.telephony.RIL.this;	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            r15.processResponse(r8);	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            r8.recycle();	 Catch:{ IOException -> 0x01d2, Throwable -> 0x01f7 }
            goto L_0x009b;
        L_0x01d2:
            r3 = move-exception;
            r15 = "RILJ";
            r16 = new java.lang.StringBuilder;	 Catch:{ Throwable -> 0x0107 }
            r16.<init>();	 Catch:{ Throwable -> 0x0107 }
            r17 = "'";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r0 = r16;
            r16 = r0.append(r10);	 Catch:{ Throwable -> 0x0107 }
            r17 = "' socket closed";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r16 = r16.toString();	 Catch:{ Throwable -> 0x0107 }
            r0 = r16;
            android.telephony.Rlog.i(r15, r0, r3);	 Catch:{ Throwable -> 0x0107 }
            goto L_0x00a5;
        L_0x01f7:
            r14 = move-exception;
            r15 = "RILJ";
            r16 = new java.lang.StringBuilder;	 Catch:{ Throwable -> 0x0107 }
            r16.<init>();	 Catch:{ Throwable -> 0x0107 }
            r17 = "Uncaught exception read length=";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r0 = r16;
            r16 = r0.append(r7);	 Catch:{ Throwable -> 0x0107 }
            r17 = "Exception:";
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r17 = r14.toString();	 Catch:{ Throwable -> 0x0107 }
            r16 = r16.append(r17);	 Catch:{ Throwable -> 0x0107 }
            r16 = r16.toString();	 Catch:{ Throwable -> 0x0107 }
            android.telephony.Rlog.e(r15, r16);	 Catch:{ Throwable -> 0x0107 }
            goto L_0x00a5;
        L_0x0222:
            r15 = move-exception;
            goto L_0x0138;
        L_0x0225:
            r15 = move-exception;
            goto L_0x016d;
        L_0x0228:
            r15 = move-exception;
            goto L_0x00ed;
        L_0x022b:
            r3 = move-exception;
            r11 = r12;
            goto L_0x0133;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.RIL.RILReceiver.run():void");
        }
    }

    class RILSender extends Handler implements Runnable {
        byte[] dataLength;

        public RILSender(Looper looper) {
            super(looper);
            this.dataLength = new byte[4];
        }

        public void run() {
        }

        public void handleMessage(Message msg) {
            RILRequest rr = (RILRequest) msg.obj;
            switch (msg.what) {
                case RIL.RESPONSE_UNSOLICITED /*1*/:
                    try {
                        LocalSocket s = RIL.this.mSocket;
                        if (s == null) {
                            rr.onError(RIL.RESPONSE_UNSOLICITED, null);
                            rr.release();
                            RIL.this.decrementWakeLock();
                            return;
                        }
                        synchronized (RIL.this.mRequestList) {
                            RIL.this.mRequestList.append(rr.mSerial, rr);
                            break;
                        }
                        byte[] data = rr.mParcel.marshall();
                        rr.mParcel.recycle();
                        rr.mParcel = null;
                        if (data.length > RIL.RIL_MAX_COMMAND_BYTES) {
                            throw new RuntimeException("Parcel larger than max bytes allowed! " + data.length);
                        }
                        byte[] bArr = this.dataLength;
                        this.dataLength[RIL.RESPONSE_UNSOLICITED] = (byte) 0;
                        bArr[RIL.RESPONSE_SOLICITED] = (byte) 0;
                        this.dataLength[RIL.EVENT_WAKE_LOCK_TIMEOUT] = (byte) ((data.length >> 8) & PduHeaders.STORE_STATUS_ERROR_END);
                        this.dataLength[RIL.CDMA_BSI_NO_OF_INTS_STRUCT] = (byte) (data.length & PduHeaders.STORE_STATUS_ERROR_END);
                        s.getOutputStream().write(this.dataLength);
                        s.getOutputStream().write(data);
                    } catch (IOException ex) {
                        Rlog.e(RIL.RILJ_LOG_TAG, "IOException", ex);
                        if (RIL.this.findAndRemoveRequestFromList(rr.mSerial) != null) {
                            rr.onError(RIL.RESPONSE_UNSOLICITED, null);
                            rr.release();
                            RIL.this.decrementWakeLock();
                        }
                    } catch (RuntimeException exc) {
                        Rlog.e(RIL.RILJ_LOG_TAG, "Uncaught exception ", exc);
                        if (RIL.this.findAndRemoveRequestFromList(rr.mSerial) != null) {
                            rr.onError(RIL.EVENT_WAKE_LOCK_TIMEOUT, null);
                            rr.release();
                            RIL.this.decrementWakeLock();
                        }
                    }
                case RIL.EVENT_WAKE_LOCK_TIMEOUT /*2*/:
                    synchronized (RIL.this.mRequestList) {
                        if (RIL.this.clearWakeLock()) {
                            int count = RIL.this.mRequestList.size();
                            Rlog.d(RIL.RILJ_LOG_TAG, "WAKE_LOCK_TIMEOUT  mRequestList=" + count);
                            for (int i = RIL.RESPONSE_SOLICITED; i < count; i += RIL.RESPONSE_UNSOLICITED) {
                                rr = (RILRequest) RIL.this.mRequestList.valueAt(i);
                                Rlog.d(RIL.RILJ_LOG_TAG, i + ": [" + rr.mSerial + "] " + RIL.requestToString(rr.mRequest));
                            }
                        }
                        break;
                    }
                default:
            }
        }
    }

    static {
        String[] strArr = new String[CDMA_BSI_NO_OF_INTS_STRUCT];
        strArr[RESPONSE_SOLICITED] = "rild";
        strArr[RESPONSE_UNSOLICITED] = "rild2";
        strArr[EVENT_WAKE_LOCK_TIMEOUT] = "rild3";
        SOCKET_NAME_RIL = strArr;
    }

    private static int readRilMessage(InputStream is, byte[] buffer) throws IOException {
        int offset = RESPONSE_SOLICITED;
        int remaining = 4;
        do {
            int countRead = is.read(buffer, offset, remaining);
            if (countRead < 0) {
                Rlog.e(RILJ_LOG_TAG, "Hit EOS reading message length");
                return -1;
            }
            offset += countRead;
            remaining -= countRead;
        } while (remaining > 0);
        int messageLength = ((((buffer[RESPONSE_SOLICITED] & PduHeaders.STORE_STATUS_ERROR_END) << 24) | ((buffer[RESPONSE_UNSOLICITED] & PduHeaders.STORE_STATUS_ERROR_END) << 16)) | ((buffer[EVENT_WAKE_LOCK_TIMEOUT] & PduHeaders.STORE_STATUS_ERROR_END) << 8)) | (buffer[CDMA_BSI_NO_OF_INTS_STRUCT] & PduHeaders.STORE_STATUS_ERROR_END);
        offset = RESPONSE_SOLICITED;
        remaining = messageLength;
        do {
            countRead = is.read(buffer, offset, remaining);
            if (countRead < 0) {
                Rlog.e(RILJ_LOG_TAG, "Hit EOS reading message.  messageLength=" + messageLength + " remaining=" + remaining);
                return -1;
            }
            offset += countRead;
            remaining -= countRead;
        } while (remaining > 0);
        return messageLength;
    }

    public RIL(Context context, int preferredNetworkType, int cdmaSubscription) {
        this(context, preferredNetworkType, cdmaSubscription, null);
    }

    public RIL(Context context, int preferredNetworkType, int cdmaSubscription, Integer instanceId) {
        super(context);
        this.mDefaultDisplayState = RESPONSE_SOLICITED;
        this.mRequestList = new SparseArray();
        this.mTestingEmergencyCall = new AtomicBoolean(RILJ_LOGV);
        this.mQANElements = 4;
        this.mDisplayListener = new C00151();
        this.mSupportedRafHandler = new C00162();
        riljLog("RIL(context, preferredNetworkType=" + preferredNetworkType + " cdmaSubscription=" + cdmaSubscription + ")");
        this.mContext = context;
        this.mCdmaSubscription = cdmaSubscription;
        this.mPreferredNetworkType = preferredNetworkType;
        this.mPhoneType = RESPONSE_SOLICITED;
        this.mInstanceId = instanceId;
        this.mWakeLock = ((PowerManager) context.getSystemService("power")).newWakeLock(RESPONSE_UNSOLICITED, RILJ_LOG_TAG);
        this.mWakeLock.setReferenceCounted(RILJ_LOGV);
        this.mWakeLockTimeout = SystemProperties.getInt("ro.ril.wake_lock_timeout", DEFAULT_WAKE_LOCK_TIMEOUT);
        this.mWakeLockCount = RESPONSE_SOLICITED;
        this.mSenderThread = new HandlerThread("RILSender" + this.mInstanceId);
        this.mSenderThread.start();
        this.mSender = new RILSender(this.mSenderThread.getLooper());
        if (((ConnectivityManager) context.getSystemService("connectivity")).isNetworkSupported(RESPONSE_SOLICITED)) {
            riljLog("Starting RILReceiver" + this.mInstanceId);
            this.mReceiver = new RILReceiver();
            this.mReceiverThread = new Thread(this.mReceiver, "RILReceiver" + this.mInstanceId);
            this.mReceiverThread.start();
            DisplayManager dm = (DisplayManager) context.getSystemService("display");
            this.mDefaultDisplay = dm.getDisplay(RESPONSE_SOLICITED);
            dm.registerDisplayListener(this.mDisplayListener, null);
        } else {
            riljLog("Not starting RILReceiver: wifi-only");
        }
        TelephonyDevController tdc = TelephonyDevController.getInstance();
        TelephonyDevController.registerRIL(this);
    }

    public void getVoiceRadioTechnology(Message result) {
        RILRequest rr = RILRequest.obtain(108, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getImsRegistrationState(Message result) {
        RILRequest rr = RILRequest.obtain(112, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setOnNITZTime(Handler h, int what, Object obj) {
        super.setOnNITZTime(h, what, obj);
        if (this.mLastNITZTimeInfo != null) {
            this.mNITZTimeRegistrant.notifyRegistrant(new AsyncResult(null, this.mLastNITZTimeInfo, null));
        }
    }

    public void getIccCardStatus(Message result) {
        RILRequest rr = RILRequest.obtain(RESPONSE_UNSOLICITED, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setUiccSubscription(int slotId, int appIndex, int subId, int subStatus, Message result) {
        RILRequest rr = RILRequest.obtain(122, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " slot: " + slotId + " appIndex: " + appIndex + " subId: " + subId + " subStatus: " + subStatus);
        rr.mParcel.writeInt(slotId);
        rr.mParcel.writeInt(appIndex);
        rr.mParcel.writeInt(subId);
        rr.mParcel.writeInt(subStatus);
        send(rr);
    }

    public void setDataAllowed(boolean allowed, Message result) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(123, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        Parcel parcel = rr.mParcel;
        if (!allowed) {
            i = RESPONSE_SOLICITED;
        }
        parcel.writeInt(i);
        send(rr);
    }

    public void supplyIccPin(String pin, Message result) {
        supplyIccPinForApp(pin, null, result);
    }

    public void supplyIccPinForApp(String pin, String aid, Message result) {
        int i = EVENT_WAKE_LOCK_TIMEOUT;
        RILRequest rr = RILRequest.obtain(EVENT_WAKE_LOCK_TIMEOUT, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        boolean oldRil = needsOldRilFeature("facilitylock");
        Parcel parcel = rr.mParcel;
        if (oldRil) {
            i = RESPONSE_UNSOLICITED;
        }
        parcel.writeInt(i);
        rr.mParcel.writeString(pin);
        if (!oldRil) {
            rr.mParcel.writeString(aid);
        }
        send(rr);
    }

    public void supplyIccPuk(String puk, String newPin, Message result) {
        supplyIccPukForApp(puk, newPin, null, result);
    }

    public void supplyIccPukForApp(String puk, String newPin, String aid, Message result) {
        int i = CDMA_BSI_NO_OF_INTS_STRUCT;
        RILRequest rr = RILRequest.obtain(CDMA_BSI_NO_OF_INTS_STRUCT, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        boolean oldRil = needsOldRilFeature("facilitylock");
        Parcel parcel = rr.mParcel;
        if (oldRil) {
            i = EVENT_WAKE_LOCK_TIMEOUT;
        }
        parcel.writeInt(i);
        rr.mParcel.writeString(puk);
        rr.mParcel.writeString(newPin);
        if (!oldRil) {
            rr.mParcel.writeString(aid);
        }
        send(rr);
    }

    public void supplyIccPin2(String pin, Message result) {
        supplyIccPin2ForApp(pin, null, result);
    }

    public void supplyIccPin2ForApp(String pin, String aid, Message result) {
        RILRequest rr = RILRequest.obtain(4, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        boolean oldRil = needsOldRilFeature("facilitylock");
        rr.mParcel.writeInt(oldRil ? RESPONSE_UNSOLICITED : EVENT_WAKE_LOCK_TIMEOUT);
        rr.mParcel.writeString(pin);
        if (!oldRil) {
            rr.mParcel.writeString(aid);
        }
        send(rr);
    }

    public void supplyIccPuk2(String puk2, String newPin2, Message result) {
        supplyIccPuk2ForApp(puk2, newPin2, null, result);
    }

    public void supplyIccPuk2ForApp(String puk, String newPin2, String aid, Message result) {
        RILRequest rr = RILRequest.obtain(5, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        boolean oldRil = needsOldRilFeature("facilitylock");
        rr.mParcel.writeInt(oldRil ? EVENT_WAKE_LOCK_TIMEOUT : CDMA_BSI_NO_OF_INTS_STRUCT);
        rr.mParcel.writeString(puk);
        rr.mParcel.writeString(newPin2);
        if (!oldRil) {
            rr.mParcel.writeString(aid);
        }
        send(rr);
    }

    public void changeIccPin(String oldPin, String newPin, Message result) {
        changeIccPinForApp(oldPin, newPin, null, result);
    }

    public void changeIccPinForApp(String oldPin, String newPin, String aid, Message result) {
        RILRequest rr = RILRequest.obtain(6, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        boolean oldRil = needsOldRilFeature("facilitylock");
        rr.mParcel.writeInt(oldRil ? EVENT_WAKE_LOCK_TIMEOUT : CDMA_BSI_NO_OF_INTS_STRUCT);
        rr.mParcel.writeString(oldPin);
        rr.mParcel.writeString(newPin);
        if (!oldRil) {
            rr.mParcel.writeString(aid);
        }
        send(rr);
    }

    public void changeIccPin2(String oldPin2, String newPin2, Message result) {
        changeIccPin2ForApp(oldPin2, newPin2, null, result);
    }

    public void changeIccPin2ForApp(String oldPin2, String newPin2, String aid, Message result) {
        RILRequest rr = RILRequest.obtain(7, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        boolean oldRil = needsOldRilFeature("facilitylock");
        rr.mParcel.writeInt(oldRil ? EVENT_WAKE_LOCK_TIMEOUT : CDMA_BSI_NO_OF_INTS_STRUCT);
        rr.mParcel.writeString(oldPin2);
        rr.mParcel.writeString(newPin2);
        if (!oldRil) {
            rr.mParcel.writeString(aid);
        }
        send(rr);
    }

    public void changeBarringPassword(String facility, String oldPwd, String newPwd, Message result) {
        RILRequest rr = RILRequest.obtain(44, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        rr.mParcel.writeInt(CDMA_BSI_NO_OF_INTS_STRUCT);
        rr.mParcel.writeString(facility);
        rr.mParcel.writeString(oldPwd);
        rr.mParcel.writeString(newPwd);
        send(rr);
    }

    public void supplyNetworkDepersonalization(String netpin, Message result) {
        RILRequest rr = RILRequest.obtain(8, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeString(netpin);
        send(rr);
    }

    public void getCurrentCalls(Message result) {
        RILRequest rr = RILRequest.obtain(9, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    @Deprecated
    public void getPDPContextList(Message result) {
        getDataCallList(result);
    }

    public void getDataCallList(Message result) {
        RILRequest rr = RILRequest.obtain(57, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void dial(String address, int clirMode, Message result) {
        dial(address, clirMode, null, result);
    }

    public void dial(String address, int clirMode, UUSInfo uusInfo, Message result) {
        RILRequest rr = RILRequest.obtain(10, result);
        rr.mParcel.writeString(address);
        rr.mParcel.writeInt(clirMode);
        if (uusInfo == null) {
            rr.mParcel.writeInt(RESPONSE_SOLICITED);
        } else {
            rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
            rr.mParcel.writeInt(uusInfo.getType());
            rr.mParcel.writeInt(uusInfo.getDcs());
            rr.mParcel.writeByteArray(uusInfo.getUserData());
        }
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getIMSI(Message result) {
        getIMSIForApp(null, result);
    }

    public void getIMSIForApp(String aid, Message result) {
        RILRequest rr = RILRequest.obtain(11, result);
        boolean skipNullAid = needsOldRilFeature("skipnullaid");
        boolean writeAidOnly = needsOldRilFeature("writeaidonly");
        if (!(writeAidOnly || (aid == null && skipNullAid))) {
            rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
            rr.mParcel.writeString(aid);
        }
        if (writeAidOnly) {
            rr.mParcel.writeString(aid);
        }
        riljLog(rr.serialString() + "> getIMSI: " + requestToString(rr.mRequest) + " aid: " + aid);
        send(rr);
    }

    public void getIMEI(Message result) {
        RILRequest rr = RILRequest.obtain(38, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getIMEISV(Message result) {
        RILRequest rr = RILRequest.obtain(39, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void hangupConnection(int gsmIndex, Message result) {
        riljLog("hangupConnection: gsmIndex=" + gsmIndex);
        RILRequest rr = RILRequest.obtain(12, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + gsmIndex);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(gsmIndex);
        send(rr);
    }

    public void hangupWaitingOrBackground(Message result) {
        RILRequest rr = RILRequest.obtain(13, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void hangupForegroundResumeBackground(Message result) {
        RILRequest rr = RILRequest.obtain(14, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void switchWaitingOrHoldingAndActive(Message result) {
        RILRequest rr = RILRequest.obtain(15, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void conference(Message result) {
        RILRequest rr = RILRequest.obtain(16, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setPreferredVoicePrivacy(boolean enable, Message result) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(82, result);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        Parcel parcel = rr.mParcel;
        if (!enable) {
            i = RESPONSE_SOLICITED;
        }
        parcel.writeInt(i);
        send(rr);
    }

    public void getPreferredVoicePrivacy(Message result) {
        send(RILRequest.obtain(83, result));
    }

    public void separateConnection(int gsmIndex, Message result) {
        RILRequest rr = RILRequest.obtain(52, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + gsmIndex);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(gsmIndex);
        send(rr);
    }

    public void acceptCall(Message result) {
        RILRequest rr = RILRequest.obtain(40, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void rejectCall(Message result) {
        RILRequest rr = RILRequest.obtain(17, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void explicitCallTransfer(Message result) {
        RILRequest rr = RILRequest.obtain(72, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getLastCallFailCause(Message result) {
        RILRequest rr = RILRequest.obtain(18, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    @Deprecated
    public void getLastPdpFailCause(Message result) {
        getLastDataCallFailCause(result);
    }

    public void getLastDataCallFailCause(Message result) {
        RILRequest rr = RILRequest.obtain(56, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setMute(boolean enableMute, Message response) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(53, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + enableMute);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        Parcel parcel = rr.mParcel;
        if (!enableMute) {
            i = RESPONSE_SOLICITED;
        }
        parcel.writeInt(i);
        send(rr);
    }

    public void getMute(Message response) {
        RILRequest rr = RILRequest.obtain(54, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getSignalStrength(Message result) {
        RILRequest rr = RILRequest.obtain(19, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getVoiceRegistrationState(Message result) {
        RILRequest rr = RILRequest.obtain(20, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getDataRegistrationState(Message result) {
        RILRequest rr = RILRequest.obtain(21, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getOperator(Message result) {
        RILRequest rr = RILRequest.obtain(22, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getHardwareConfig(Message result) {
        RILRequest rr = RILRequest.obtain(124, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void sendDtmf(char c, Message result) {
        RILRequest rr = RILRequest.obtain(24, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        rr.mParcel.writeString(Character.toString(c));
        send(rr);
    }

    public void startDtmf(char c, Message result) {
        RILRequest rr = RILRequest.obtain(49, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        rr.mParcel.writeString(Character.toString(c));
        send(rr);
    }

    public void stopDtmf(Message result) {
        RILRequest rr = RILRequest.obtain(50, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void sendBurstDtmf(String dtmfString, int on, int off, Message result) {
        RILRequest rr = RILRequest.obtain(85, result);
        rr.mParcel.writeInt(CDMA_BSI_NO_OF_INTS_STRUCT);
        rr.mParcel.writeString(dtmfString);
        rr.mParcel.writeString(Integer.toString(on));
        rr.mParcel.writeString(Integer.toString(off));
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " : " + dtmfString);
        send(rr);
    }

    private void constructGsmSendSmsRilRequest(RILRequest rr, String smscPDU, String pdu) {
        rr.mParcel.writeInt(EVENT_WAKE_LOCK_TIMEOUT);
        rr.mParcel.writeString(smscPDU);
        rr.mParcel.writeString(pdu);
    }

    public void sendSMS(String smscPDU, String pdu, Message result) {
        RILRequest rr = RILRequest.obtain(25, result);
        constructGsmSendSmsRilRequest(rr, smscPDU, pdu);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void sendSMSExpectMore(String smscPDU, String pdu, Message result) {
        RILRequest rr = RILRequest.obtain(26, result);
        constructGsmSendSmsRilRequest(rr, smscPDU, pdu);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    private void constructCdmaSendSmsRilRequest(RILRequest rr, byte[] pdu) {
        DataInputStream dis = new DataInputStream(new ByteArrayInputStream(pdu));
        try {
            int i;
            rr.mParcel.writeInt(dis.readInt());
            rr.mParcel.writeByte((byte) dis.readInt());
            rr.mParcel.writeInt(dis.readInt());
            rr.mParcel.writeInt(dis.read());
            rr.mParcel.writeInt(dis.read());
            rr.mParcel.writeInt(dis.read());
            rr.mParcel.writeInt(dis.read());
            int address_nbr_of_digits = (byte) dis.read();
            rr.mParcel.writeByte((byte) address_nbr_of_digits);
            for (i = RESPONSE_SOLICITED; i < address_nbr_of_digits; i += RESPONSE_UNSOLICITED) {
                rr.mParcel.writeByte(dis.readByte());
            }
            rr.mParcel.writeInt(dis.read());
            rr.mParcel.writeByte((byte) dis.read());
            int subaddr_nbr_of_digits = (byte) dis.read();
            rr.mParcel.writeByte((byte) subaddr_nbr_of_digits);
            for (i = RESPONSE_SOLICITED; i < subaddr_nbr_of_digits; i += RESPONSE_UNSOLICITED) {
                rr.mParcel.writeByte(dis.readByte());
            }
            int bearerDataLength = dis.read();
            rr.mParcel.writeInt(bearerDataLength);
            for (i = RESPONSE_SOLICITED; i < bearerDataLength; i += RESPONSE_UNSOLICITED) {
                rr.mParcel.writeByte(dis.readByte());
            }
        } catch (IOException ex) {
            riljLog("sendSmsCdma: conversion from input stream to object failed: " + ex);
        }
    }

    public void sendCdmaSms(byte[] pdu, Message result) {
        RILRequest rr = RILRequest.obtain(87, result);
        constructCdmaSendSmsRilRequest(rr, pdu);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void sendImsGsmSms(String smscPDU, String pdu, int retry, int messageRef, Message result) {
        RILRequest rr = RILRequest.obtain(113, result);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeByte((byte) retry);
        rr.mParcel.writeInt(messageRef);
        constructGsmSendSmsRilRequest(rr, smscPDU, pdu);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void sendImsCdmaSms(byte[] pdu, int retry, int messageRef, Message result) {
        RILRequest rr = RILRequest.obtain(113, result);
        rr.mParcel.writeInt(EVENT_WAKE_LOCK_TIMEOUT);
        rr.mParcel.writeByte((byte) retry);
        rr.mParcel.writeInt(messageRef);
        constructCdmaSendSmsRilRequest(rr, pdu);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void deleteSmsOnSim(int index, Message response) {
        RILRequest rr = RILRequest.obtain(64, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(index);
        send(rr);
    }

    public void deleteSmsOnRuim(int index, Message response) {
        RILRequest rr = RILRequest.obtain(97, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(index);
        send(rr);
    }

    public void writeSmsToSim(int status, String smsc, String pdu, Message response) {
        status = translateStatus(status);
        RILRequest rr = RILRequest.obtain(63, response);
        rr.mParcel.writeInt(status);
        rr.mParcel.writeString(pdu);
        rr.mParcel.writeString(smsc);
        send(rr);
    }

    public void writeSmsToRuim(int status, String pdu, Message response) {
        status = translateStatus(status);
        RILRequest rr = RILRequest.obtain(96, response);
        rr.mParcel.writeInt(status);
        rr.mParcel.writeString(pdu);
        send(rr);
    }

    private int translateStatus(int status) {
        switch (status & 7) {
            case CDMA_BSI_NO_OF_INTS_STRUCT /*3*/:
                return RESPONSE_SOLICITED;
            case CharacterSets.ISO_8859_2 /*5*/:
                return CDMA_BSI_NO_OF_INTS_STRUCT;
            case CharacterSets.ISO_8859_4 /*7*/:
                return EVENT_WAKE_LOCK_TIMEOUT;
            default:
                return RESPONSE_UNSOLICITED;
        }
    }

    public void setupDataCall(String radioTechnology, String profile, String apn, String user, String password, String authType, String protocol, Message result) {
        RILRequest rr = RILRequest.obtain(27, result);
        rr.mParcel.writeInt(7);
        rr.mParcel.writeString(radioTechnology);
        rr.mParcel.writeString(profile);
        rr.mParcel.writeString(apn);
        rr.mParcel.writeString(user);
        rr.mParcel.writeString(password);
        rr.mParcel.writeString(authType);
        rr.mParcel.writeString(protocol);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + radioTechnology + " " + profile + " " + apn + " " + user + " " + password + " " + authType + " " + protocol);
        send(rr);
    }

    public void deactivateDataCall(int cid, int reason, Message result) {
        RILRequest rr = RILRequest.obtain(41, result);
        rr.mParcel.writeInt(EVENT_WAKE_LOCK_TIMEOUT);
        rr.mParcel.writeString(Integer.toString(cid));
        rr.mParcel.writeString(Integer.toString(reason));
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + cid + " " + reason);
        send(rr);
    }

    public void setRadioPower(boolean on, Message result) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(23, result);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        Parcel parcel = rr.mParcel;
        if (!on) {
            i = RESPONSE_SOLICITED;
        }
        parcel.writeInt(i);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + (on ? " on" : " off"));
        send(rr);
    }

    public void requestShutdown(Message result) {
        RILRequest rr = RILRequest.obtain(PduPart.P_DISPOSITION_ATTACHMENT, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setSuppServiceNotifications(boolean enable, Message result) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(62, result);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        Parcel parcel = rr.mParcel;
        if (!enable) {
            i = RESPONSE_SOLICITED;
        }
        parcel.writeInt(i);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void acknowledgeLastIncomingGsmSms(boolean success, int cause, Message result) {
        RILRequest rr = RILRequest.obtain(37, result);
        rr.mParcel.writeInt(EVENT_WAKE_LOCK_TIMEOUT);
        rr.mParcel.writeInt(success ? RESPONSE_UNSOLICITED : RESPONSE_SOLICITED);
        rr.mParcel.writeInt(cause);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + success + " " + cause);
        send(rr);
    }

    public void acknowledgeLastIncomingCdmaSms(boolean success, int cause, Message result) {
        RILRequest rr = RILRequest.obtain(88, result);
        rr.mParcel.writeInt(success ? RESPONSE_SOLICITED : RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(cause);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + success + " " + cause);
        send(rr);
    }

    public void acknowledgeIncomingGsmSmsWithPdu(boolean success, String ackPdu, Message result) {
        RILRequest rr = RILRequest.obtain(CharacterSets.UTF_8, result);
        rr.mParcel.writeInt(EVENT_WAKE_LOCK_TIMEOUT);
        rr.mParcel.writeString(success ? "1" : "0");
        rr.mParcel.writeString(ackPdu);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + ' ' + success + " [" + ackPdu + ']');
        send(rr);
    }

    public void iccIO(int command, int fileid, String path, int p1, int p2, int p3, String data, String pin2, Message result) {
        iccIOForApp(command, fileid, path, p1, p2, p3, data, pin2, null, result);
    }

    public void iccIOForApp(int command, int fileid, String path, int p1, int p2, int p3, String data, String pin2, String aid, Message result) {
        RILRequest rr = RILRequest.obtain(28, result);
        rr.mParcel.writeInt(command);
        rr.mParcel.writeInt(fileid);
        rr.mParcel.writeString(path);
        rr.mParcel.writeInt(p1);
        rr.mParcel.writeInt(p2);
        rr.mParcel.writeInt(p3);
        rr.mParcel.writeString(data);
        rr.mParcel.writeString(pin2);
        rr.mParcel.writeString(aid);
        riljLog(rr.serialString() + "> iccIO: " + requestToString(rr.mRequest) + " 0x" + Integer.toHexString(command) + " 0x" + Integer.toHexString(fileid) + " " + " path: " + path + "," + p1 + "," + p2 + "," + p3 + " aid: " + aid);
        send(rr);
    }

    public void getCLIR(Message result) {
        RILRequest rr = RILRequest.obtain(CDMA_BROADCAST_SMS_NO_OF_SERVICE_CATEGORIES, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setCLIR(int clirMode, Message result) {
        RILRequest rr = RILRequest.obtain(32, result);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(clirMode);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + clirMode);
        send(rr);
    }

    public void queryCallWaiting(int serviceClass, Message response) {
        RILRequest rr = RILRequest.obtain(35, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(serviceClass);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + serviceClass);
        send(rr);
    }

    public void setCallWaiting(boolean enable, int serviceClass, Message response) {
        RILRequest rr = RILRequest.obtain(36, response);
        rr.mParcel.writeInt(EVENT_WAKE_LOCK_TIMEOUT);
        rr.mParcel.writeInt(enable ? RESPONSE_UNSOLICITED : RESPONSE_SOLICITED);
        rr.mParcel.writeInt(serviceClass);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + enable + ", " + serviceClass);
        send(rr);
    }

    public void setNetworkSelectionModeAutomatic(Message response) {
        RILRequest rr = RILRequest.obtain(46, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setNetworkSelectionModeManual(String operatorNumeric, Message response) {
        RILRequest rr = RILRequest.obtain(47, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + operatorNumeric);
        rr.mParcel.writeString(operatorNumeric);
        send(rr);
    }

    public void getNetworkSelectionMode(Message response) {
        RILRequest rr = RILRequest.obtain(45, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getAvailableNetworks(Message response) {
        RILRequest rr = RILRequest.obtain(48, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setCallForward(int action, int cfReason, int serviceClass, String number, int timeSeconds, Message response) {
        RILRequest rr = RILRequest.obtain(34, response);
        rr.mParcel.writeInt(action);
        rr.mParcel.writeInt(cfReason);
        rr.mParcel.writeInt(serviceClass);
        rr.mParcel.writeInt(PhoneNumberUtils.toaFromString(number));
        rr.mParcel.writeString(number);
        rr.mParcel.writeInt(timeSeconds);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + action + " " + cfReason + " " + serviceClass + timeSeconds);
        send(rr);
    }

    public void queryCallForwardStatus(int cfReason, int serviceClass, String number, Message response) {
        RILRequest rr = RILRequest.obtain(33, response);
        rr.mParcel.writeInt(EVENT_WAKE_LOCK_TIMEOUT);
        rr.mParcel.writeInt(cfReason);
        rr.mParcel.writeInt(serviceClass);
        rr.mParcel.writeInt(PhoneNumberUtils.toaFromString(number));
        rr.mParcel.writeString(number);
        rr.mParcel.writeInt(RESPONSE_SOLICITED);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + cfReason + " " + serviceClass);
        send(rr);
    }

    public void queryCLIP(Message response) {
        RILRequest rr = RILRequest.obtain(55, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getBasebandVersion(Message response) {
        RILRequest rr = RILRequest.obtain(51, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void queryFacilityLock(String facility, String password, int serviceClass, Message response) {
        queryFacilityLockForApp(facility, password, serviceClass, null, response);
    }

    public void queryFacilityLockForApp(String facility, String password, int serviceClass, String appId, Message response) {
        RILRequest rr = RILRequest.obtain(42, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        boolean oldRil = needsOldRilFeature("facilitylock");
        rr.mParcel.writeInt(oldRil ? CDMA_BSI_NO_OF_INTS_STRUCT : 4);
        rr.mParcel.writeString(facility);
        rr.mParcel.writeString(password);
        rr.mParcel.writeString(Integer.toString(serviceClass));
        if (!oldRil) {
            rr.mParcel.writeString(appId);
        }
        send(rr);
    }

    public void setFacilityLock(String facility, boolean lockState, String password, int serviceClass, Message response) {
        setFacilityLockForApp(facility, lockState, password, serviceClass, null, response);
    }

    public void setFacilityLockForApp(String facility, boolean lockState, String password, int serviceClass, String appId, Message response) {
        RILRequest rr = RILRequest.obtain(43, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " [" + facility + " " + lockState + " " + serviceClass + " " + appId + "]");
        boolean oldRil = needsOldRilFeature("facilitylock");
        rr.mParcel.writeInt(oldRil ? 4 : 5);
        rr.mParcel.writeString(facility);
        rr.mParcel.writeString(lockState ? "1" : "0");
        rr.mParcel.writeString(password);
        rr.mParcel.writeString(Integer.toString(serviceClass));
        if (!oldRil) {
            rr.mParcel.writeString(appId);
        }
        send(rr);
    }

    public void sendUSSD(String ussdString, Message response) {
        RILRequest rr = RILRequest.obtain(29, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + "*******");
        rr.mParcel.writeString(ussdString);
        send(rr);
    }

    public void cancelPendingUssd(Message response) {
        RILRequest rr = RILRequest.obtain(30, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void resetRadio(Message result) {
        RILRequest rr = RILRequest.obtain(58, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void invokeOemRilRequestRaw(byte[] data, Message response) {
        RILRequest rr = RILRequest.obtain(59, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + "[" + IccUtils.bytesToHexString(data) + "]");
        rr.mParcel.writeByteArray(data);
        send(rr);
    }

    public void invokeOemRilRequestStrings(String[] strings, Message response) {
        RILRequest rr = RILRequest.obtain(60, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        rr.mParcel.writeStringArray(strings);
        send(rr);
    }

    public void setBandMode(int bandMode, Message response) {
        RILRequest rr = RILRequest.obtain(65, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(bandMode);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + bandMode);
        send(rr);
    }

    public void queryAvailableBandMode(Message response) {
        RILRequest rr = RILRequest.obtain(66, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void sendTerminalResponse(String contents, Message response) {
        RILRequest rr = RILRequest.obtain(70, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        rr.mParcel.writeString(contents);
        send(rr);
    }

    public void sendEnvelope(String contents, Message response) {
        RILRequest rr = RILRequest.obtain(69, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        rr.mParcel.writeString(contents);
        send(rr);
    }

    public void sendEnvelopeWithStatus(String contents, Message response) {
        RILRequest rr = RILRequest.obtain(107, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + '[' + contents + ']');
        rr.mParcel.writeString(contents);
        send(rr);
    }

    public void handleCallSetupRequestFromSim(boolean accept, Message response) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(71, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        int[] param = new int[RESPONSE_UNSOLICITED];
        if (!accept) {
            i = RESPONSE_SOLICITED;
        }
        param[RESPONSE_SOLICITED] = i;
        rr.mParcel.writeIntArray(param);
        send(rr);
    }

    public void setPreferredNetworkType(int networkType, Message response) {
        RILRequest rr = RILRequest.obtain(73, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(networkType);
        this.mPreferredNetworkType = networkType;
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " : " + networkType);
        send(rr);
    }

    public void getPreferredNetworkType(Message response) {
        RILRequest rr = RILRequest.obtain(74, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getNeighboringCids(Message response) {
        RILRequest rr = RILRequest.obtain(75, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setLocationUpdates(boolean enable, Message response) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(76, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        Parcel parcel = rr.mParcel;
        if (!enable) {
            i = RESPONSE_SOLICITED;
        }
        parcel.writeInt(i);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + ": " + enable);
        send(rr);
    }

    public void getSmscAddress(Message result) {
        RILRequest rr = RILRequest.obtain(100, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setSmscAddress(String address, Message result) {
        RILRequest rr = RILRequest.obtain(101, result);
        rr.mParcel.writeString(address);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " : " + address);
        send(rr);
    }

    public void reportSmsMemoryStatus(boolean available, Message result) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(102, result);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        Parcel parcel = rr.mParcel;
        if (!available) {
            i = RESPONSE_SOLICITED;
        }
        parcel.writeInt(i);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + ": " + available);
        send(rr);
    }

    public void reportStkServiceIsRunning(Message result) {
        RILRequest rr = RILRequest.obtain(103, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getGsmBroadcastConfig(Message response) {
        RILRequest rr = RILRequest.obtain(89, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setGsmBroadcastConfig(SmsBroadcastConfigInfo[] config, Message response) {
        int i;
        RILRequest rr = RILRequest.obtain(90, response);
        int numOfConfig = config.length;
        rr.mParcel.writeInt(numOfConfig);
        for (i = RESPONSE_SOLICITED; i < numOfConfig; i += RESPONSE_UNSOLICITED) {
            int i2;
            rr.mParcel.writeInt(config[i].getFromServiceId());
            rr.mParcel.writeInt(config[i].getToServiceId());
            rr.mParcel.writeInt(config[i].getFromCodeScheme());
            rr.mParcel.writeInt(config[i].getToCodeScheme());
            Parcel parcel = rr.mParcel;
            if (config[i].isSelected()) {
                i2 = RESPONSE_UNSOLICITED;
            } else {
                i2 = RESPONSE_SOLICITED;
            }
            parcel.writeInt(i2);
        }
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " with " + numOfConfig + " configs : ");
        for (i = RESPONSE_SOLICITED; i < numOfConfig; i += RESPONSE_UNSOLICITED) {
            riljLog(config[i].toString());
        }
        send(rr);
    }

    public void setGsmBroadcastActivation(boolean activate, Message response) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(91, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        Parcel parcel = rr.mParcel;
        if (activate) {
            i = RESPONSE_SOLICITED;
        }
        parcel.writeInt(i);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    private void updateScreenState() {
        int oldState = this.mDefaultDisplayState;
        this.mDefaultDisplayState = this.mDefaultDisplay.getState();
        if (this.mDefaultDisplayState == oldState) {
            return;
        }
        if (oldState != EVENT_WAKE_LOCK_TIMEOUT && this.mDefaultDisplayState == EVENT_WAKE_LOCK_TIMEOUT) {
            sendScreenState(RILJ_LOGD);
        } else if ((oldState == EVENT_WAKE_LOCK_TIMEOUT || oldState == 0) && this.mDefaultDisplayState != EVENT_WAKE_LOCK_TIMEOUT) {
            sendScreenState(RILJ_LOGV);
        }
    }

    protected void sendScreenState(boolean on) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(61, null);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        Parcel parcel = rr.mParcel;
        if (!on) {
            i = RESPONSE_SOLICITED;
        }
        parcel.writeInt(i);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + ": " + on);
        send(rr);
    }

    protected void onRadioAvailable() {
        updateScreenState();
    }

    protected RadioState getRadioStateFromInt(int stateInt) {
        switch (stateInt) {
            case RESPONSE_SOLICITED /*0*/:
                return RadioState.RADIO_OFF;
            case RESPONSE_UNSOLICITED /*1*/:
                return RadioState.RADIO_UNAVAILABLE;
            case EVENT_WAKE_LOCK_TIMEOUT /*2*/:
            case CDMA_BSI_NO_OF_INTS_STRUCT /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
            case CharacterSets.ISO_8859_2 /*5*/:
            case CharacterSets.ISO_8859_3 /*6*/:
            case CharacterSets.ISO_8859_4 /*7*/:
            case CharacterSets.ISO_8859_5 /*8*/:
            case CharacterSets.ISO_8859_6 /*9*/:
            case CharacterSets.ISO_8859_7 /*10*/:
                return RadioState.RADIO_ON;
            default:
                throw new RuntimeException("Unrecognized RIL_RadioState: " + stateInt);
        }
    }

    protected void switchToRadioState(RadioState newState) {
        setRadioState(newState);
    }

    private void acquireWakeLock() {
        synchronized (this.mWakeLock) {
            this.mWakeLock.acquire();
            this.mWakeLockCount += RESPONSE_UNSOLICITED;
            this.mSender.removeMessages(EVENT_WAKE_LOCK_TIMEOUT);
            this.mSender.sendMessageDelayed(this.mSender.obtainMessage(EVENT_WAKE_LOCK_TIMEOUT), (long) this.mWakeLockTimeout);
        }
    }

    private void decrementWakeLock() {
        synchronized (this.mWakeLock) {
            if (this.mWakeLockCount > RESPONSE_UNSOLICITED) {
                this.mWakeLockCount--;
            } else {
                this.mWakeLockCount = RESPONSE_SOLICITED;
                this.mWakeLock.release();
                this.mSender.removeMessages(EVENT_WAKE_LOCK_TIMEOUT);
            }
        }
    }

    private boolean clearWakeLock() {
        boolean z = RILJ_LOGV;
        synchronized (this.mWakeLock) {
            if (this.mWakeLockCount != 0 || this.mWakeLock.isHeld()) {
                Rlog.d(RILJ_LOG_TAG, "NOTE: mWakeLockCount is " + this.mWakeLockCount + "at time of clearing");
                this.mWakeLockCount = RESPONSE_SOLICITED;
                this.mWakeLock.release();
                this.mSender.removeMessages(EVENT_WAKE_LOCK_TIMEOUT);
                z = RILJ_LOGD;
            }
        }
        return z;
    }

    protected void send(RILRequest rr) {
        if (this.mSocket == null) {
            rr.onError(RESPONSE_UNSOLICITED, null);
            rr.release();
            return;
        }
        Message msg = this.mSender.obtainMessage(RESPONSE_UNSOLICITED, rr);
        acquireWakeLock();
        msg.sendToTarget();
    }

    protected void processResponse(Parcel p) {
        int type = p.readInt();
        if (type == RESPONSE_UNSOLICITED) {
            processUnsolicited(p);
        } else if (type == 0) {
            RILRequest rr = processSolicited(p);
            if (rr != null) {
                rr.release();
                decrementWakeLock();
            }
        }
    }

    protected void clearRequestList(int error, boolean loggable) {
        synchronized (this.mRequestList) {
            int count = this.mRequestList.size();
            if (loggable) {
                Rlog.d(RILJ_LOG_TAG, "clearRequestList  mWakeLockCount=" + this.mWakeLockCount + " mRequestList=" + count);
            }
            for (int i = RESPONSE_SOLICITED; i < count; i += RESPONSE_UNSOLICITED) {
                RILRequest rr = (RILRequest) this.mRequestList.valueAt(i);
                if (loggable) {
                    Rlog.d(RILJ_LOG_TAG, i + ": [" + rr.mSerial + "] " + requestToString(rr.mRequest));
                }
                rr.onError(error, null);
                rr.release();
                decrementWakeLock();
            }
            this.mRequestList.clear();
        }
    }

    protected RILRequest findAndRemoveRequestFromList(int serial) {
        RILRequest rr;
        synchronized (this.mRequestList) {
            rr = (RILRequest) this.mRequestList.get(serial);
            if (rr != null) {
                this.mRequestList.remove(serial);
            }
        }
        return rr;
    }

    protected RILRequest processSolicited(Parcel p) {
        int serial = p.readInt();
        int error = p.readInt();
        RILRequest rr = findAndRemoveRequestFromList(serial);
        if (rr == null) {
            Rlog.w(RILJ_LOG_TAG, "Unexpected solicited response! sn: " + serial + " error: " + error);
            return null;
        }
        Object ret = null;
        if (error == 0 || p.dataAvail() > 0) {
            try {
                switch (rr.mRequest) {
                    case RESPONSE_UNSOLICITED /*1*/:
                        ret = responseIccCardStatus(p);
                        break;
                    case EVENT_WAKE_LOCK_TIMEOUT /*2*/:
                        ret = responseInts(p);
                        break;
                    case CDMA_BSI_NO_OF_INTS_STRUCT /*3*/:
                        ret = responseInts(p);
                        break;
                    case CharacterSets.ISO_8859_1 /*4*/:
                        ret = responseInts(p);
                        break;
                    case CharacterSets.ISO_8859_2 /*5*/:
                        ret = responseInts(p);
                        break;
                    case CharacterSets.ISO_8859_3 /*6*/:
                        ret = responseInts(p);
                        break;
                    case CharacterSets.ISO_8859_4 /*7*/:
                        ret = responseInts(p);
                        break;
                    case CharacterSets.ISO_8859_5 /*8*/:
                        ret = responseInts(p);
                        break;
                    case CharacterSets.ISO_8859_6 /*9*/:
                        ret = responseCallList(p);
                        break;
                    case CharacterSets.ISO_8859_7 /*10*/:
                        ret = responseVoid(p);
                        break;
                    case CharacterSets.ISO_8859_8 /*11*/:
                        ret = responseString(p);
                        break;
                    case CharacterSets.ISO_8859_9 /*12*/:
                        ret = responseVoid(p);
                        break;
                    case UserData.ASCII_CR_INDEX /*13*/:
                        ret = responseVoid(p);
                        break;
                    case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                        if (this.mTestingEmergencyCall.getAndSet(RILJ_LOGV) && this.mEmergencyCallbackModeRegistrant != null) {
                            riljLog("testing emergency call, notify ECM Registrants");
                            this.mEmergencyCallbackModeRegistrant.notifyRegistrant();
                        }
                        ret = responseVoid(p);
                        break;
                    case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                        ret = responseVoid(p);
                        break;
                    case PduHeaders.MMS_VERSION_1_0 /*16*/:
                        ret = responseVoid(p);
                        break;
                    case PduHeaders.MMS_VERSION_1_1 /*17*/:
                        ret = responseVoid(p);
                        break;
                    case PduHeaders.MMS_VERSION_1_2 /*18*/:
                        ret = responseInts(p);
                        break;
                    case PduHeaders.MMS_VERSION_1_3 /*19*/:
                        ret = responseSignalStrength(p);
                        break;
                    case SmsHeader.ELT_ID_EXTENDED_OBJECT /*20*/:
                        ret = responseStrings(p);
                        break;
                    case SmsHeader.ELT_ID_REUSED_EXTENDED_OBJECT /*21*/:
                        ret = responseStrings(p);
                        break;
                    case CallFailCause.NUMBER_CHANGED /*22*/:
                        ret = responseStrings(p);
                        break;
                    case SmsHeader.ELT_ID_OBJECT_DISTR_INDICATOR /*23*/:
                        ret = responseVoid(p);
                        break;
                    case SmsHeader.ELT_ID_STANDARD_WVG_OBJECT /*24*/:
                        ret = responseVoid(p);
                        break;
                    case SmsHeader.ELT_ID_CHARACTER_SIZE_WVG_OBJECT /*25*/:
                        ret = responseSMS(p);
                        break;
                    case SmsHeader.ELT_ID_EXTENDED_OBJECT_DATA_REQUEST_CMD /*26*/:
                        ret = responseSMS(p);
                        break;
                    case 27:
                        ret = responseSetupDataCall(p);
                        break;
                    case 28:
                        ret = responseICC_IO(p);
                        break;
                    case 29:
                        ret = responseVoid(p);
                        break;
                    case CallFailCause.STATUS_ENQUIRY /*30*/:
                        ret = responseVoid(p);
                        break;
                    case CDMA_BROADCAST_SMS_NO_OF_SERVICE_CATEGORIES /*31*/:
                        ret = responseInts(p);
                        break;
                    case UserData.PRINTABLE_ASCII_MIN_INDEX /*32*/:
                        ret = responseVoid(p);
                        break;
                    case SmsHeader.ELT_ID_HYPERLINK_FORMAT_ELEMENT /*33*/:
                        ret = responseCallForward(p);
                        break;
                    case CallFailCause.NO_CIRCUIT_AVAIL /*34*/:
                        ret = responseVoid(p);
                        break;
                    case SmsHeader.ELT_ID_ENHANCED_VOICE_MAIL_INFORMATION /*35*/:
                        ret = responseInts(p);
                        break;
                    case CdmaSmsAddress.SMS_SUBADDRESS_MAX /*36*/:
                        ret = responseVoid(p);
                        break;
                    case SmsHeader.ELT_ID_NATIONAL_LANGUAGE_LOCKING_SHIFT /*37*/:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_MIP_PROFILE_HA_SPI /*38*/:
                        ret = responseString(p);
                        break;
                    case RadioNVItems.RIL_NV_MIP_PROFILE_AAA_SPI /*39*/:
                        ret = responseString(p);
                        break;
                    case RadioNVItems.RIL_NV_MIP_PROFILE_MN_HA_SS /*40*/:
                        ret = responseVoid(p);
                        break;
                    case CallFailCause.TEMPORARY_FAILURE /*41*/:
                        ret = responseVoid(p);
                        break;
                    case CallFailCause.SWITCHING_CONGESTION /*42*/:
                        ret = responseInts(p);
                        break;
                    case 43:
                        ret = responseInts(p);
                        break;
                    case CallFailCause.CHANNEL_NOT_AVAIL /*44*/:
                        ret = responseVoid(p);
                        break;
                    case 45:
                        ret = responseInts(p);
                        break;
                    case 46:
                        ret = responseVoid(p);
                        break;
                    case WspTypeDecoder.PARAMETER_ID_X_WAP_APPLICATION_ID /*47*/:
                        ret = responseVoid(p);
                        break;
                    case 48:
                        ret = responseOperatorInfos(p);
                        break;
                    case CallFailCause.QOS_NOT_AVAIL /*49*/:
                        ret = responseVoid(p);
                        break;
                    case 50:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_CDMA_PRL_VERSION /*51*/:
                        ret = responseString(p);
                        break;
                    case RadioNVItems.RIL_NV_CDMA_BC10 /*52*/:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_CDMA_BC14 /*53*/:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_CDMA_SO68 /*54*/:
                        ret = responseInts(p);
                        break;
                    case RadioNVItems.RIL_NV_CDMA_SO73_COP0 /*55*/:
                        ret = responseInts(p);
                        break;
                    case RadioNVItems.RIL_NV_CDMA_SO73_COP1TO7 /*56*/:
                        ret = responseInts(p);
                        break;
                    case RadioNVItems.RIL_NV_CDMA_1X_ADVANCED_ENABLED /*57*/:
                        ret = responseDataCallList(p);
                        break;
                    case CallFailCause.BEARER_NOT_AVAIL /*58*/:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_CDMA_EHRPD_FORCED /*59*/:
                        ret = responseRaw(p);
                        break;
                    case 60:
                        ret = responseStrings(p);
                        break;
                    case 61:
                        ret = responseVoid(p);
                        break;
                    case 62:
                        ret = responseVoid(p);
                        break;
                    case SignalToneUtil.IS95_CONST_IR_SIG_TONE_NO_TONE /*63*/:
                        ret = responseInts(p);
                        break;
                    case CommandsInterface.SERVICE_CLASS_PACKET /*64*/:
                        ret = responseVoid(p);
                        break;
                    case 65:
                        ret = responseVoid(p);
                        break;
                    case 66:
                        ret = responseInts(p);
                        break;
                    case 67:
                        ret = responseString(p);
                        break;
                    case CallFailCause.ACM_LIMIT_EXCEEDED /*68*/:
                        ret = responseVoid(p);
                        break;
                    case 69:
                        ret = responseString(p);
                        break;
                    case 70:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_BAND_ENABLE_25 /*71*/:
                        ret = responseInts(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_BAND_ENABLE_26 /*72*/:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_BAND_ENABLE_41 /*73*/:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_SCAN_PRIORITY_25 /*74*/:
                        ret = responseGetPreferredNetworkType(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_SCAN_PRIORITY_26 /*75*/:
                        ret = responseCellList(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_SCAN_PRIORITY_41 /*76*/:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_HIDDEN_BAND_PRIORITY_25 /*77*/:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_HIDDEN_BAND_PRIORITY_26 /*78*/:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_HIDDEN_BAND_PRIORITY_41 /*79*/:
                        ret = responseInts(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_NEXT_SCAN /*80*/:
                        ret = responseVoid(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_BSR_TIMER /*81*/:
                        ret = responseInts(p);
                        break;
                    case RadioNVItems.RIL_NV_LTE_BSR_MAX_TIME /*82*/:
                        ret = responseVoid(p);
                        break;
                    case 83:
                        ret = responseInts(p);
                        break;
                    case 84:
                        ret = responseVoid(p);
                        break;
                    case 85:
                        ret = responseVoid(p);
                        break;
                    case 86:
                        ret = responseVoid(p);
                        break;
                    case 87:
                        ret = responseSMS(p);
                        break;
                    case 88:
                        ret = responseVoid(p);
                        break;
                    case 89:
                        ret = responseGmsBroadcastConfig(p);
                        break;
                    case 90:
                        ret = responseVoid(p);
                        break;
                    case 91:
                        ret = responseVoid(p);
                        break;
                    case 92:
                        ret = responseCdmaBroadcastConfig(p);
                        break;
                    case 93:
                        ret = responseVoid(p);
                        break;
                    case 94:
                        ret = responseVoid(p);
                        break;
                    case 95:
                        ret = responseStrings(p);
                        break;
                    case CommandsInterface.CDMA_SMS_FAIL_CAUSE_ENCODING_PROBLEM /*96*/:
                        ret = responseInts(p);
                        break;
                    case 97:
                        ret = responseVoid(p);
                        break;
                    case 98:
                        ret = responseStrings(p);
                        break;
                    case 99:
                        ret = responseVoid(p);
                        break;
                    case IccRecords.EVENT_GET_ICC_RECORD_DONE /*100*/:
                        ret = responseString(p);
                        break;
                    case 101:
                        ret = responseVoid(p);
                        break;
                    case 102:
                        ret = responseVoid(p);
                        break;
                    case 103:
                        ret = responseVoid(p);
                        break;
                    case 104:
                        ret = responseInts(p);
                        break;
                    case 105:
                        ret = responseString(p);
                        break;
                    case CharacterSets.UTF_8 /*106*/:
                        ret = responseVoid(p);
                        break;
                    case 107:
                        ret = responseICC_IO(p);
                        break;
                    case 108:
                        ret = responseInts(p);
                        break;
                    case 109:
                        ret = responseCellInfoList(p);
                        break;
                    case 110:
                        ret = responseVoid(p);
                        break;
                    case 111:
                        ret = responseVoid(p);
                        break;
                    case 112:
                        ret = responseInts(p);
                        break;
                    case 113:
                        ret = responseSMS(p);
                        break;
                    case 114:
                        ret = responseICC_IO(p);
                        break;
                    case 115:
                        ret = responseInts(p);
                        break;
                    case 116:
                        ret = responseVoid(p);
                        break;
                    case 117:
                        ret = responseICC_IO(p);
                        break;
                    case 118:
                        ret = responseString(p);
                        break;
                    case 119:
                        ret = responseVoid(p);
                        break;
                    case 120:
                        ret = responseVoid(p);
                        break;
                    case 121:
                        ret = responseVoid(p);
                        break;
                    case 122:
                        ret = responseVoid(p);
                        break;
                    case 123:
                        ret = responseVoid(p);
                        break;
                    case 124:
                        ret = responseHardwareConfig(p);
                        break;
                    case 125:
                        ret = responseICC_IOBase64(p);
                        break;
                    case PduPart.P_Q /*128*/:
                        ret = responseVoid(p);
                        break;
                    case PduPart.P_DISPOSITION_ATTACHMENT /*129*/:
                        ret = responseVoid(p);
                        break;
                    case PduPart.P_LEVEL /*130*/:
                        ret = responseRadioCapability(p);
                        break;
                    case PduPart.P_TYPE /*131*/:
                        ret = responseRadioCapability(p);
                        break;
                    default:
                        throw new RuntimeException("Unrecognized solicited response: " + rr.mRequest);
                }
            } catch (Throwable tr) {
                Rlog.w(RILJ_LOG_TAG, rr.serialString() + "< " + requestToString(rr.mRequest) + " exception, possible invalid RIL response", tr);
                if (rr.mResult == null) {
                    return rr;
                }
                AsyncResult.forMessage(rr.mResult, null, tr);
                rr.mResult.sendToTarget();
                return rr;
            }
        }
        if (rr.mRequest == PduPart.P_DISPOSITION_ATTACHMENT) {
            riljLog("Response to RIL_REQUEST_SHUTDOWN received. Error is " + error + " Setting Radio State to Unavailable regardless of error.");
            setRadioState(RadioState.RADIO_UNAVAILABLE);
        }
        switch (rr.mRequest) {
            case CDMA_BSI_NO_OF_INTS_STRUCT /*3*/:
            case CharacterSets.ISO_8859_2 /*5*/:
                if (this.mIccStatusChangedRegistrants != null) {
                    riljLog("ON enter sim puk fakeSimStatusChanged: reg count=" + this.mIccStatusChangedRegistrants.size());
                    this.mIccStatusChangedRegistrants.notifyRegistrants();
                    break;
                }
                break;
        }
        if (error != 0) {
            switch (rr.mRequest) {
                case EVENT_WAKE_LOCK_TIMEOUT /*2*/:
                case CharacterSets.ISO_8859_1 /*4*/:
                case CharacterSets.ISO_8859_3 /*6*/:
                case CharacterSets.ISO_8859_4 /*7*/:
                case 43:
                    if (this.mIccStatusChangedRegistrants != null) {
                        riljLog("ON some errors fakeSimStatusChanged: reg count=" + this.mIccStatusChangedRegistrants.size());
                        this.mIccStatusChangedRegistrants.notifyRegistrants();
                        break;
                    }
                    break;
            }
            rr.onError(error, ret);
            return rr;
        }
        riljLog(rr.serialString() + "< " + requestToString(rr.mRequest) + " " + retToString(rr.mRequest, ret));
        if (rr.mResult == null) {
            return rr;
        }
        AsyncResult.forMessage(rr.mResult, ret, null);
        rr.mResult.sendToTarget();
        return rr;
    }

    static String retToString(int req, Object ret) {
        if (ret == null) {
            return "";
        }
        switch (req) {
            case CharacterSets.ISO_8859_8 /*11*/:
            case RadioNVItems.RIL_NV_MIP_PROFILE_HA_SPI /*38*/:
            case RadioNVItems.RIL_NV_MIP_PROFILE_AAA_SPI /*39*/:
            case 115:
            case 117:
                return "";
            default:
                int length;
                StringBuilder sb;
                int i;
                int i2;
                if (ret instanceof int[]) {
                    int[] intArray = (int[]) ret;
                    length = intArray.length;
                    sb = new StringBuilder("{");
                    if (length > 0) {
                        i = RESPONSE_SOLICITED + RESPONSE_UNSOLICITED;
                        sb.append(intArray[RESPONSE_SOLICITED]);
                        while (i < length) {
                            i2 = i + RESPONSE_UNSOLICITED;
                            sb.append(", ").append(intArray[i]);
                            i = i2;
                        }
                    }
                    sb.append("}");
                    return sb.toString();
                } else if (ret instanceof String[]) {
                    String[] strings = (String[]) ret;
                    length = strings.length;
                    sb = new StringBuilder("{");
                    if (length > 0) {
                        i = RESPONSE_SOLICITED + RESPONSE_UNSOLICITED;
                        sb.append(strings[RESPONSE_SOLICITED]);
                        while (i < length) {
                            i2 = i + RESPONSE_UNSOLICITED;
                            sb.append(", ").append(strings[i]);
                            i = i2;
                        }
                    }
                    sb.append("}");
                    return sb.toString();
                } else if (req == 9) {
                    ArrayList<DriverCall> calls = (ArrayList) ret;
                    sb = new StringBuilder(" ");
                    i$ = calls.iterator();
                    while (i$.hasNext()) {
                        sb.append("[").append((DriverCall) i$.next()).append("] ");
                    }
                    return sb.toString();
                } else if (req == 75) {
                    ArrayList<NeighboringCellInfo> cells = (ArrayList) ret;
                    sb = new StringBuilder(" ");
                    i$ = cells.iterator();
                    while (i$.hasNext()) {
                        sb.append((NeighboringCellInfo) i$.next()).append(" ");
                    }
                    return sb.toString();
                } else if (req != 124) {
                    return ret.toString();
                } else {
                    ArrayList<HardwareConfig> hwcfgs = (ArrayList) ret;
                    sb = new StringBuilder(" ");
                    i$ = hwcfgs.iterator();
                    while (i$.hasNext()) {
                        sb.append("[").append((HardwareConfig) i$.next()).append("] ");
                    }
                    return sb.toString();
                }
        }
    }

    protected void processUnsolicited(Parcel p) {
        Object responseVoid;
        int response = p.readInt();
        switch (response) {
            case CharacterSets.UCS2 /*1000*/:
                responseVoid = responseVoid(p);
                break;
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_DROP /*1001*/:
                responseVoid = responseVoid(p);
                break;
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_INTERCEPT /*1002*/:
                responseVoid = responseVoid(p);
                break;
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_REORDER /*1003*/:
                responseVoid = responseString(p);
                break;
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_SO_REJECT /*1004*/:
                responseVoid = responseString(p);
                break;
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_RETRY_ORDER /*1005*/:
                responseVoid = responseInts(p);
                break;
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_ACCESS_FAILURE /*1006*/:
                responseVoid = responseStrings(p);
                break;
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_NOT_EMERGENCY /*1008*/:
                responseVoid = responseString(p);
                break;
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_ACCESS_BLOCKED /*1009*/:
                responseVoid = responseSignalStrength(p);
                break;
            case 1010:
                responseVoid = responseDataCallList(p);
                break;
            case 1011:
                responseVoid = responseSuppServiceNotification(p);
                break;
            case 1012:
                responseVoid = responseVoid(p);
                break;
            case 1013:
                responseVoid = responseString(p);
                break;
            case 1014:
                responseVoid = responseString(p);
                break;
            case CharacterSets.UTF_16 /*1015*/:
                responseVoid = responseInts(p);
                break;
            case 1016:
                responseVoid = responseVoid(p);
                break;
            case 1017:
                responseVoid = responseSimRefresh(p);
                break;
            case 1018:
                responseVoid = responseCallRing(p);
                break;
            case 1019:
                responseVoid = responseVoid(p);
                break;
            case 1020:
                responseVoid = responseCdmaSms(p);
                break;
            case 1021:
                responseVoid = responseRaw(p);
                break;
            case 1022:
                responseVoid = responseVoid(p);
                break;
            case 1023:
                responseVoid = responseInts(p);
                break;
            case 1024:
                responseVoid = responseVoid(p);
                break;
            case 1025:
                responseVoid = responseCdmaCallWaiting(p);
                break;
            case 1026:
                responseVoid = responseInts(p);
                break;
            case 1027:
                responseVoid = responseCdmaInformationRecord(p);
                break;
            case 1028:
                responseVoid = responseRaw(p);
                break;
            case 1029:
                responseVoid = responseInts(p);
                break;
            case 1030:
                responseVoid = responseVoid(p);
                break;
            case 1031:
                responseVoid = responseInts(p);
                break;
            case 1032:
                responseVoid = responseInts(p);
                break;
            case 1033:
                responseVoid = responseVoid(p);
                break;
            case 1034:
                responseVoid = responseInts(p);
                break;
            case 1035:
                responseVoid = responseInts(p);
                break;
            case 1036:
                responseVoid = responseCellInfoList(p);
                break;
            case 1037:
                responseVoid = responseVoid(p);
                break;
            case 1038:
                responseVoid = responseInts(p);
                break;
            case 1039:
                responseVoid = responseInts(p);
                break;
            case 1040:
                responseVoid = responseHardwareConfig(p);
                break;
            case 1042:
                responseVoid = responseRadioCapability(p);
                break;
            case 1043:
                responseVoid = responseSsData(p);
                break;
            case 1044:
                responseVoid = responseString(p);
                break;
            default:
                try {
                    throw new RuntimeException("Unrecognized unsol response: " + response);
                } catch (Throwable tr) {
                    Rlog.e(RILJ_LOG_TAG, "Exception processing unsol response: " + response + "Exception:" + tr.toString());
                    return;
                }
        }
        SmsMessage sms;
        int length;
        switch (response) {
            case CharacterSets.UCS2 /*1000*/:
                RadioState newState = getRadioStateFromInt(p.readInt());
                unsljLogMore(response, newState.toString());
                switchToRadioState(newState);
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_DROP /*1001*/:
                unsljLog(response);
                this.mCallStateRegistrants.notifyRegistrants(new AsyncResult(null, null, null));
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_INTERCEPT /*1002*/:
                unsljLog(response);
                this.mVoiceNetworkStateRegistrants.notifyRegistrants(new AsyncResult(null, null, null));
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_REORDER /*1003*/:
                unsljLog(response);
                String[] a = new String[EVENT_WAKE_LOCK_TIMEOUT];
                a[RESPONSE_UNSOLICITED] = (String) responseVoid;
                sms = SmsMessage.newFromCMT(a);
                if (this.mGsmSmsRegistrant != null) {
                    this.mGsmSmsRegistrant.notifyRegistrant(new AsyncResult(null, sms, null));
                }
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_SO_REJECT /*1004*/:
                unsljLogRet(response, responseVoid);
                if (this.mSmsStatusRegistrant != null) {
                    this.mSmsStatusRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_RETRY_ORDER /*1005*/:
                unsljLogRet(response, responseVoid);
                Object smsIndex = (int[]) responseVoid;
                length = smsIndex.length;
                if (r0 != RESPONSE_UNSOLICITED) {
                    riljLog(" NEW_SMS_ON_SIM ERROR with wrong length " + smsIndex.length);
                } else if (this.mSmsOnSimRegistrant != null) {
                    this.mSmsOnSimRegistrant.notifyRegistrant(new AsyncResult(null, smsIndex, null));
                }
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_ACCESS_FAILURE /*1006*/:
                String[] resp = (String[]) responseVoid;
                length = resp.length;
                if (r0 < EVENT_WAKE_LOCK_TIMEOUT) {
                    resp = new String[EVENT_WAKE_LOCK_TIMEOUT];
                    resp[RESPONSE_SOLICITED] = ((String[]) responseVoid)[RESPONSE_SOLICITED];
                    resp[RESPONSE_UNSOLICITED] = null;
                }
                unsljLogMore(response, resp[RESPONSE_SOLICITED]);
                if (this.mUSSDRegistrant != null) {
                    this.mUSSDRegistrant.notifyRegistrant(new AsyncResult(null, resp, null));
                }
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_NOT_EMERGENCY /*1008*/:
                unsljLogRet(response, responseVoid);
                long nitzReceiveTime = p.readLong();
                Object result = new Object[EVENT_WAKE_LOCK_TIMEOUT];
                result[RESPONSE_SOLICITED] = responseVoid;
                result[RESPONSE_UNSOLICITED] = Long.valueOf(nitzReceiveTime);
                if (SystemProperties.getBoolean("telephony.test.ignore.nitz", RILJ_LOGV)) {
                    riljLog("ignoring UNSOL_NITZ_TIME_RECEIVED");
                    return;
                }
                if (this.mNITZTimeRegistrant != null) {
                    this.mNITZTimeRegistrant.notifyRegistrant(new AsyncResult(null, result, null));
                }
                this.mLastNITZTimeInfo = result;
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_ACCESS_BLOCKED /*1009*/:
                if (this.mSignalStrengthRegistrant != null) {
                    this.mSignalStrengthRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case 1010:
                unsljLogRet(response, responseVoid);
                if (needsOldRilFeature("skipbrokendatacall")) {
                    if ("IP".equals(((DataCallResponse) ((ArrayList) responseVoid).get(RESPONSE_SOLICITED)).type)) {
                        return;
                    }
                }
                this.mDataNetworkStateRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
            case 1011:
                unsljLogRet(response, responseVoid);
                if (this.mSsnRegistrant != null) {
                    this.mSsnRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case 1012:
                unsljLog(response);
                if (this.mCatSessionEndRegistrant != null) {
                    this.mCatSessionEndRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case 1013:
                unsljLog(response);
                if (this.mCatProCmdRegistrant != null) {
                    this.mCatProCmdRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case 1014:
                unsljLog(response);
                if (this.mCatEventRegistrant != null) {
                    this.mCatEventRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case CharacterSets.UTF_16 /*1015*/:
                unsljLogRet(response, responseVoid);
                if (this.mCatCallSetUpRegistrant != null) {
                    this.mCatCallSetUpRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case 1016:
                unsljLog(response);
                if (this.mIccSmsFullRegistrant != null) {
                    this.mIccSmsFullRegistrant.notifyRegistrant();
                }
            case 1017:
                unsljLogRet(response, responseVoid);
                if (this.mIccRefreshRegistrants != null) {
                    this.mIccRefreshRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1018:
                unsljLogRet(response, responseVoid);
                if (this.mRingRegistrant != null) {
                    this.mRingRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case 1019:
                unsljLog(response);
                if (this.mIccStatusChangedRegistrants != null) {
                    this.mIccStatusChangedRegistrants.notifyRegistrants();
                }
            case 1020:
                unsljLog(response);
                sms = (SmsMessage) responseVoid;
                if (this.mCdmaSmsRegistrant != null) {
                    this.mCdmaSmsRegistrant.notifyRegistrant(new AsyncResult(null, sms, null));
                }
            case 1021:
                unsljLogvRet(response, IccUtils.bytesToHexString((byte[]) responseVoid));
                if (this.mGsmBroadcastSmsRegistrant != null) {
                    this.mGsmBroadcastSmsRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case 1022:
                unsljLog(response);
                if (this.mIccSmsFullRegistrant != null) {
                    this.mIccSmsFullRegistrant.notifyRegistrant();
                }
            case 1023:
                unsljLogvRet(response, responseVoid);
                if (this.mRestrictedStateRegistrant != null) {
                    this.mRestrictedStateRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case 1024:
                unsljLog(response);
                if (this.mEmergencyCallbackModeRegistrant != null) {
                    this.mEmergencyCallbackModeRegistrant.notifyRegistrant();
                }
            case 1025:
                unsljLogRet(response, responseVoid);
                if (this.mCallWaitingInfoRegistrants != null) {
                    this.mCallWaitingInfoRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1026:
                unsljLogRet(response, responseVoid);
                if (this.mOtaProvisionRegistrants != null) {
                    this.mOtaProvisionRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1027:
                try {
                    Iterator i$ = ((ArrayList) responseVoid).iterator();
                    while (i$.hasNext()) {
                        CdmaInformationRecords rec = (CdmaInformationRecords) i$.next();
                        unsljLogRet(response, rec);
                        notifyRegistrantsCdmaInfoRec(rec);
                    }
                } catch (ClassCastException e) {
                    Rlog.e(RILJ_LOG_TAG, "Unexpected exception casting to listInfoRecs", e);
                }
            case 1028:
                unsljLogvRet(response, IccUtils.bytesToHexString((byte[]) responseVoid));
                if (this.mUnsolOemHookRawRegistrant != null) {
                    this.mUnsolOemHookRawRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case 1029:
                unsljLogvRet(response, responseVoid);
                if (this.mRingbackToneRegistrants != null) {
                    this.mRingbackToneRegistrants.notifyRegistrants(new AsyncResult(null, Boolean.valueOf(((int[]) ((int[]) responseVoid))[RESPONSE_SOLICITED] == RESPONSE_UNSOLICITED ? RILJ_LOGD : RILJ_LOGV), null));
                }
            case 1030:
                unsljLogRet(response, responseVoid);
                if (this.mResendIncallMuteRegistrants != null) {
                    this.mResendIncallMuteRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1031:
                unsljLogRet(response, responseVoid);
                if (this.mCdmaSubscriptionChangedRegistrants != null) {
                    this.mCdmaSubscriptionChangedRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1032:
                unsljLogRet(response, responseVoid);
                if (this.mCdmaPrlChangedRegistrants != null) {
                    this.mCdmaPrlChangedRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1033:
                unsljLogRet(response, responseVoid);
                if (this.mExitEmergencyCallbackModeRegistrants != null) {
                    this.mExitEmergencyCallbackModeRegistrants.notifyRegistrants(new AsyncResult(null, null, null));
                }
            case 1034:
                unsljLogRet(response, responseVoid);
                getRadioCapability(this.mSupportedRafHandler.obtainMessage());
                setRadioPower(RILJ_LOGV, null);
                setPreferredNetworkType(this.mPreferredNetworkType, null);
                setCdmaSubscriptionSource(this.mCdmaSubscription, null);
                setCellInfoListRate(Integer.MAX_VALUE, null);
                notifyRegistrantsRilConnectionChanged(((int[]) responseVoid)[RESPONSE_SOLICITED]);
            case 1035:
                unsljLogRet(response, responseVoid);
                if (this.mVoiceRadioTechChangedRegistrants != null) {
                    this.mVoiceRadioTechChangedRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1036:
                unsljLogRet(response, responseVoid);
                if (this.mRilCellInfoListRegistrants != null) {
                    this.mRilCellInfoListRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1037:
                unsljLog(response);
                this.mImsNetworkStateChangedRegistrants.notifyRegistrants(new AsyncResult(null, null, null));
            case 1038:
                unsljLogRet(response, responseVoid);
                if (this.mSubscriptionStatusRegistrants != null) {
                    this.mSubscriptionStatusRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1039:
                unsljLogRet(response, responseVoid);
                if (this.mSrvccStateRegistrants != null) {
                    this.mSrvccStateRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1040:
                unsljLogRet(response, responseVoid);
                if (this.mHardwareConfigChangeRegistrants != null) {
                    this.mHardwareConfigChangeRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1042:
                unsljLogRet(response, responseVoid);
                if (this.mPhoneRadioCapabilityChangedRegistrants != null) {
                    this.mPhoneRadioCapabilityChangedRegistrants.notifyRegistrants(new AsyncResult(null, responseVoid, null));
                }
            case 1043:
                unsljLogRet(response, responseVoid);
                if (this.mSsRegistrant != null) {
                    this.mSsRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            case 1044:
                unsljLogRet(response, responseVoid);
                if (this.mCatCcAlphaRegistrant != null) {
                    this.mCatCcAlphaRegistrant.notifyRegistrant(new AsyncResult(null, responseVoid, null));
                }
            default:
        }
    }

    protected void notifyRegistrantsRilConnectionChanged(int rilVer) {
        this.mRilVersion = rilVer;
        if (this.mRilConnectedRegistrants != null) {
            this.mRilConnectedRegistrants.notifyRegistrants(new AsyncResult(null, new Integer(rilVer), null));
        }
    }

    protected Object responseInts(Parcel p) {
        int numInts = p.readInt();
        int[] response = new int[numInts];
        for (int i = RESPONSE_SOLICITED; i < numInts; i += RESPONSE_UNSOLICITED) {
            response[i] = p.readInt();
        }
        return response;
    }

    protected Object responseVoid(Parcel p) {
        return null;
    }

    protected Object responseCallForward(Parcel p) {
        int numInfos = p.readInt();
        CallForwardInfo[] infos = new CallForwardInfo[numInfos];
        for (int i = RESPONSE_SOLICITED; i < numInfos; i += RESPONSE_UNSOLICITED) {
            infos[i] = new CallForwardInfo();
            infos[i].status = p.readInt();
            infos[i].reason = p.readInt();
            infos[i].serviceClass = p.readInt();
            infos[i].toa = p.readInt();
            infos[i].number = p.readString();
            infos[i].timeSeconds = p.readInt();
        }
        return infos;
    }

    protected Object responseSuppServiceNotification(Parcel p) {
        SuppServiceNotification notification = new SuppServiceNotification();
        notification.notificationType = p.readInt();
        notification.code = p.readInt();
        notification.index = p.readInt();
        notification.type = p.readInt();
        notification.number = p.readString();
        return notification;
    }

    protected Object responseCdmaSms(Parcel p) {
        return SmsMessage.newFromParcel(p);
    }

    protected Object responseString(Parcel p) {
        return p.readString();
    }

    protected Object responseStrings(Parcel p) {
        return p.readStringArray();
    }

    protected Object responseRaw(Parcel p) {
        return p.createByteArray();
    }

    protected Object responseSMS(Parcel p) {
        return new SmsResponse(p.readInt(), p.readString(), p.readInt());
    }

    protected Object responseICC_IO(Parcel p) {
        return new IccIoResult(p.readInt(), p.readInt(), p.readString());
    }

    private Object responseICC_IOBase64(Parcel p) {
        return new IccIoResult(p.readInt(), p.readInt(), Base64.decode(p.readString(), RESPONSE_SOLICITED));
    }

    public boolean needsOldRilFeature(String feature) {
        String[] arr$ = SystemProperties.get("ro.telephony.ril.config", "").split(",");
        int len$ = arr$.length;
        for (int i$ = RESPONSE_SOLICITED; i$ < len$; i$ += RESPONSE_UNSOLICITED) {
            if (arr$[i$].equals(feature)) {
                return RILJ_LOGD;
            }
        }
        return RILJ_LOGV;
    }

    protected Object responseIccCardStatus(Parcel p) {
        boolean oldRil = needsOldRilFeature("icccardstatus");
        IccCardStatus cardStatus = new IccCardStatus();
        cardStatus.setCardState(p.readInt());
        cardStatus.setUniversalPinState(p.readInt());
        cardStatus.mGsmUmtsSubscriptionAppIndex = p.readInt();
        cardStatus.mCdmaSubscriptionAppIndex = p.readInt();
        if (!oldRil) {
            cardStatus.mImsSubscriptionAppIndex = p.readInt();
        }
        int numApplications = p.readInt();
        if (numApplications > 8) {
            numApplications = 8;
        }
        cardStatus.mApplications = new IccCardApplicationStatus[numApplications];
        for (int i = RESPONSE_SOLICITED; i < numApplications; i += RESPONSE_UNSOLICITED) {
            IccCardApplicationStatus appStatus = new IccCardApplicationStatus();
            appStatus.app_type = appStatus.AppTypeFromRILInt(p.readInt());
            appStatus.app_state = appStatus.AppStateFromRILInt(p.readInt());
            appStatus.perso_substate = appStatus.PersoSubstateFromRILInt(p.readInt());
            appStatus.aid = p.readString();
            appStatus.app_label = p.readString();
            appStatus.pin1_replaced = p.readInt();
            appStatus.pin1 = appStatus.PinStateFromRILInt(p.readInt());
            appStatus.pin2 = appStatus.PinStateFromRILInt(p.readInt());
            cardStatus.mApplications[i] = appStatus;
        }
        return cardStatus;
    }

    protected Object responseSimRefresh(Parcel p) {
        IccRefreshResponse response = new IccRefreshResponse();
        response.refreshResult = p.readInt();
        response.efId = p.readInt();
        response.aid = p.readString();
        return response;
    }

    protected Object responseCallList(Parcel p) {
        int num = p.readInt();
        ArrayList<DriverCall> response = new ArrayList(num);
        for (int i = RESPONSE_SOLICITED; i < num; i += RESPONSE_UNSOLICITED) {
            boolean z;
            DriverCall dc = new DriverCall();
            dc.state = DriverCall.stateFromCLCC(p.readInt());
            dc.index = p.readInt();
            dc.TOA = p.readInt();
            if (p.readInt() != 0) {
                z = RILJ_LOGD;
            } else {
                z = RILJ_LOGV;
            }
            dc.isMpty = z;
            if (p.readInt() != 0) {
                z = RILJ_LOGD;
            } else {
                z = RILJ_LOGV;
            }
            dc.isMT = z;
            dc.als = p.readInt();
            if (p.readInt() == 0) {
                z = RILJ_LOGV;
            } else {
                z = RILJ_LOGD;
            }
            dc.isVoice = z;
            if (p.readInt() != 0) {
                z = RILJ_LOGD;
            } else {
                z = RILJ_LOGV;
            }
            dc.isVoicePrivacy = z;
            dc.number = p.readString();
            dc.numberPresentation = DriverCall.presentationFromCLIP(p.readInt());
            dc.name = p.readString();
            dc.namePresentation = DriverCall.presentationFromCLIP(p.readInt());
            if (p.readInt() == RESPONSE_UNSOLICITED) {
                dc.uusInfo = new UUSInfo();
                dc.uusInfo.setType(p.readInt());
                dc.uusInfo.setDcs(p.readInt());
                dc.uusInfo.setUserData(p.createByteArray());
                Object[] objArr = new Object[CDMA_BSI_NO_OF_INTS_STRUCT];
                objArr[RESPONSE_SOLICITED] = Integer.valueOf(dc.uusInfo.getType());
                objArr[RESPONSE_UNSOLICITED] = Integer.valueOf(dc.uusInfo.getDcs());
                objArr[EVENT_WAKE_LOCK_TIMEOUT] = Integer.valueOf(dc.uusInfo.getUserData().length);
                riljLogv(String.format("Incoming UUS : type=%d, dcs=%d, length=%d", objArr));
                riljLogv("Incoming UUS : data (string)=" + new String(dc.uusInfo.getUserData()));
                riljLogv("Incoming UUS : data (hex): " + IccUtils.bytesToHexString(dc.uusInfo.getUserData()));
            } else {
                riljLogv("Incoming UUS : NOT present!");
            }
            dc.number = PhoneNumberUtils.stringFromStringAndTOA(dc.number, dc.TOA);
            response.add(dc);
            if (dc.isVoicePrivacy) {
                this.mVoicePrivacyOnRegistrants.notifyRegistrants();
                riljLog("InCall VoicePrivacy is enabled");
            } else {
                this.mVoicePrivacyOffRegistrants.notifyRegistrants();
                riljLog("InCall VoicePrivacy is disabled");
            }
        }
        Collections.sort(response);
        if (num == 0 && this.mTestingEmergencyCall.getAndSet(RILJ_LOGV) && this.mEmergencyCallbackModeRegistrant != null) {
            riljLog("responseCallList: call ended, testing emergency call, notify ECM Registrants");
            this.mEmergencyCallbackModeRegistrant.notifyRegistrant();
        }
        return response;
    }

    protected DataCallResponse getDataCallResponse(Parcel p, int version) {
        DataCallResponse dataCall = new DataCallResponse();
        dataCall.version = version;
        String addresses;
        if (version < 5) {
            dataCall.cid = p.readInt();
            dataCall.active = p.readInt();
            dataCall.type = p.readString();
            if (version < 4 || needsOldRilFeature("datacallapn")) {
                p.readString();
            }
            addresses = p.readString();
            if (!TextUtils.isEmpty(addresses)) {
                dataCall.addresses = addresses.split(" ");
            }
            dataCall.ifname = Resources.getSystem().getString(17039402);
        } else {
            dataCall.status = p.readInt();
            if (needsOldRilFeature("usehcradio")) {
                dataCall.suggestedRetryTime = -1;
            } else {
                dataCall.suggestedRetryTime = p.readInt();
            }
            dataCall.cid = p.readInt();
            dataCall.active = p.readInt();
            dataCall.type = p.readString();
            dataCall.ifname = p.readString();
            if (dataCall.status == DcFailCause.NONE.getErrorCode() && TextUtils.isEmpty(dataCall.ifname)) {
                throw new RuntimeException("getDataCallResponse, no ifname");
            }
            addresses = p.readString();
            if (!TextUtils.isEmpty(addresses)) {
                dataCall.addresses = addresses.split(" ");
            }
            String dnses = p.readString();
            if (!TextUtils.isEmpty(dnses)) {
                dataCall.dnses = dnses.split(" ");
            }
            String gateways = p.readString();
            if (!TextUtils.isEmpty(gateways)) {
                dataCall.gateways = gateways.split(" ");
            }
            if (version >= 10) {
                String pcscf = p.readString();
                if (!TextUtils.isEmpty(pcscf)) {
                    dataCall.pcscf = pcscf.split(" ");
                }
            }
            if (version >= 11) {
                dataCall.mtu = p.readInt();
            }
        }
        return dataCall;
    }

    protected Object responseDataCallList(Parcel p) {
        int ver = needsOldRilFeature("datacall") ? CDMA_BSI_NO_OF_INTS_STRUCT : p.readInt();
        int num = p.readInt();
        riljLog("responseDataCallList ver=" + ver + " num=" + num);
        ArrayList<DataCallResponse> response = new ArrayList(num);
        for (int i = RESPONSE_SOLICITED; i < num; i += RESPONSE_UNSOLICITED) {
            response.add(getDataCallResponse(p, ver));
        }
        return response;
    }

    protected Object responseSetupDataCall(Parcel p) {
        int ver = needsOldRilFeature("datacall") ? CDMA_BSI_NO_OF_INTS_STRUCT : p.readInt();
        int num = p.readInt();
        if (ver < 5) {
            DataCallResponse dataCall = new DataCallResponse();
            dataCall.version = ver;
            dataCall.cid = Integer.parseInt(p.readString());
            dataCall.ifname = p.readString();
            if (TextUtils.isEmpty(dataCall.ifname)) {
                throw new RuntimeException("RIL_REQUEST_SETUP_DATA_CALL response, no ifname");
            }
            String addresses = p.readString();
            if (!TextUtils.isEmpty(addresses)) {
                dataCall.addresses = addresses.split(" ");
            }
            if (num >= 4) {
                String dnses = p.readString();
                riljLog("responseSetupDataCall got dnses=" + dnses);
                if (!TextUtils.isEmpty(dnses)) {
                    dataCall.dnses = dnses.split(" ");
                }
            }
            if (num >= 5) {
                String gateways = p.readString();
                riljLog("responseSetupDataCall got gateways=" + gateways);
                if (!TextUtils.isEmpty(gateways)) {
                    dataCall.gateways = gateways.split(" ");
                }
            }
            if (num < 6) {
                return dataCall;
            }
            String pcscf = p.readString();
            riljLog("responseSetupDataCall got pcscf=" + pcscf);
            if (TextUtils.isEmpty(pcscf)) {
                return dataCall;
            }
            dataCall.pcscf = pcscf.split(" ");
            return dataCall;
        } else if (num == RESPONSE_UNSOLICITED) {
            return getDataCallResponse(p, ver);
        } else {
            throw new RuntimeException("RIL_REQUEST_SETUP_DATA_CALL response expecting 1 RIL_Data_Call_response_v5 got " + num);
        }
    }

    protected Object responseOperatorInfos(Parcel p) {
        String[] strings = (String[]) responseStrings(p);
        if (strings.length % this.mQANElements != 0) {
            throw new RuntimeException("RIL_REQUEST_QUERY_AVAILABLE_NETWORKS: invalid response. Got " + strings.length + " strings, expected multiple of " + this.mQANElements);
        }
        ArrayList<OperatorInfo> ret = new ArrayList(strings.length / this.mQANElements);
        int i = RESPONSE_SOLICITED;
        while (i < strings.length) {
            ret.add(new OperatorInfo(strings[i + RESPONSE_SOLICITED], strings[i + RESPONSE_UNSOLICITED], strings[i + EVENT_WAKE_LOCK_TIMEOUT], strings[i + CDMA_BSI_NO_OF_INTS_STRUCT]));
            i += this.mQANElements;
        }
        return ret;
    }

    protected Object responseCellList(Parcel p) {
        int num = p.readInt();
        ArrayList<NeighboringCellInfo> response = new ArrayList();
        int radioType = ((TelephonyManager) this.mContext.getSystemService("phone")).getDataNetworkType(SubscriptionManager.getSubId(this.mInstanceId.intValue())[RESPONSE_SOLICITED]);
        if (radioType != 0) {
            for (int i = RESPONSE_SOLICITED; i < num; i += RESPONSE_UNSOLICITED) {
                response.add(new NeighboringCellInfo(p.readInt(), p.readString(), radioType));
            }
        }
        return response;
    }

    protected Object responseGetPreferredNetworkType(Parcel p) {
        int[] response = (int[]) responseInts(p);
        if (response.length >= RESPONSE_UNSOLICITED) {
            this.mPreferredNetworkType = response[RESPONSE_SOLICITED];
        }
        return response;
    }

    protected Object responseGmsBroadcastConfig(Parcel p) {
        int num = p.readInt();
        ArrayList<SmsBroadcastConfigInfo> response = new ArrayList(num);
        for (int i = RESPONSE_SOLICITED; i < num; i += RESPONSE_UNSOLICITED) {
            response.add(new SmsBroadcastConfigInfo(p.readInt(), p.readInt(), p.readInt(), p.readInt(), p.readInt() == RESPONSE_UNSOLICITED ? RILJ_LOGD : RILJ_LOGV));
        }
        return response;
    }

    protected Object responseCdmaBroadcastConfig(Parcel p) {
        int[] response;
        int numServiceCategories = p.readInt();
        int i;
        if (numServiceCategories == 0) {
            response = new int[94];
            response[RESPONSE_SOLICITED] = CDMA_BROADCAST_SMS_NO_OF_SERVICE_CATEGORIES;
            for (i = RESPONSE_UNSOLICITED; i < 94; i += CDMA_BSI_NO_OF_INTS_STRUCT) {
                response[i + RESPONSE_SOLICITED] = i / CDMA_BSI_NO_OF_INTS_STRUCT;
                response[i + RESPONSE_UNSOLICITED] = RESPONSE_UNSOLICITED;
                response[i + EVENT_WAKE_LOCK_TIMEOUT] = RESPONSE_SOLICITED;
            }
        } else {
            int numInts = (numServiceCategories * CDMA_BSI_NO_OF_INTS_STRUCT) + RESPONSE_UNSOLICITED;
            response = new int[numInts];
            response[RESPONSE_SOLICITED] = numServiceCategories;
            for (i = RESPONSE_UNSOLICITED; i < numInts; i += RESPONSE_UNSOLICITED) {
                response[i] = p.readInt();
            }
        }
        return response;
    }

    protected Object responseSignalStrength(Parcel p) {
        return SignalStrength.makeSignalStrengthFromRilParcel(p);
    }

    protected ArrayList<CdmaInformationRecords> responseCdmaInformationRecord(Parcel p) {
        int numberOfInfoRecs = p.readInt();
        ArrayList<CdmaInformationRecords> response = new ArrayList(numberOfInfoRecs);
        for (int i = RESPONSE_SOLICITED; i < numberOfInfoRecs; i += RESPONSE_UNSOLICITED) {
            response.add(new CdmaInformationRecords(p));
        }
        return response;
    }

    protected Object responseCdmaCallWaiting(Parcel p) {
        CdmaCallWaitingNotification notification = new CdmaCallWaitingNotification();
        notification.number = p.readString();
        notification.numberPresentation = CdmaCallWaitingNotification.presentationFromCLIP(p.readInt());
        notification.name = p.readString();
        notification.namePresentation = notification.numberPresentation;
        notification.isPresent = p.readInt();
        notification.signalType = p.readInt();
        notification.alertPitch = p.readInt();
        notification.signal = p.readInt();
        notification.numberType = p.readInt();
        notification.numberPlan = p.readInt();
        return notification;
    }

    protected Object responseCallRing(Parcel p) {
        return new char[]{(char) p.readInt(), (char) p.readInt(), (char) p.readInt(), (char) p.readInt()};
    }

    protected void notifyRegistrantsCdmaInfoRec(CdmaInformationRecords infoRec) {
        if (infoRec.record instanceof CdmaDisplayInfoRec) {
            if (this.mDisplayInfoRegistrants != null) {
                unsljLogRet(1027, infoRec.record);
                this.mDisplayInfoRegistrants.notifyRegistrants(new AsyncResult(null, infoRec.record, null));
            }
        } else if (infoRec.record instanceof CdmaSignalInfoRec) {
            if (this.mSignalInfoRegistrants != null) {
                unsljLogRet(1027, infoRec.record);
                this.mSignalInfoRegistrants.notifyRegistrants(new AsyncResult(null, infoRec.record, null));
            }
        } else if (infoRec.record instanceof CdmaNumberInfoRec) {
            if (this.mNumberInfoRegistrants != null) {
                unsljLogRet(1027, infoRec.record);
                this.mNumberInfoRegistrants.notifyRegistrants(new AsyncResult(null, infoRec.record, null));
            }
        } else if (infoRec.record instanceof CdmaRedirectingNumberInfoRec) {
            if (this.mRedirNumInfoRegistrants != null) {
                unsljLogRet(1027, infoRec.record);
                this.mRedirNumInfoRegistrants.notifyRegistrants(new AsyncResult(null, infoRec.record, null));
            }
        } else if (infoRec.record instanceof CdmaLineControlInfoRec) {
            if (this.mLineControlInfoRegistrants != null) {
                unsljLogRet(1027, infoRec.record);
                this.mLineControlInfoRegistrants.notifyRegistrants(new AsyncResult(null, infoRec.record, null));
            }
        } else if (infoRec.record instanceof CdmaT53ClirInfoRec) {
            if (this.mT53ClirInfoRegistrants != null) {
                unsljLogRet(1027, infoRec.record);
                this.mT53ClirInfoRegistrants.notifyRegistrants(new AsyncResult(null, infoRec.record, null));
            }
        } else if ((infoRec.record instanceof CdmaT53AudioControlInfoRec) && this.mT53AudCntrlInfoRegistrants != null) {
            unsljLogRet(1027, infoRec.record);
            this.mT53AudCntrlInfoRegistrants.notifyRegistrants(new AsyncResult(null, infoRec.record, null));
        }
    }

    protected ArrayList<CellInfo> responseCellInfoList(Parcel p) {
        int numberOfInfoRecs = p.readInt();
        ArrayList<CellInfo> response = new ArrayList(numberOfInfoRecs);
        for (int i = RESPONSE_SOLICITED; i < numberOfInfoRecs; i += RESPONSE_UNSOLICITED) {
            response.add((CellInfo) CellInfo.CREATOR.createFromParcel(p));
        }
        return response;
    }

    private Object responseHardwareConfig(Parcel p) {
        int num = p.readInt();
        ArrayList<HardwareConfig> response = new ArrayList(num);
        for (int i = RESPONSE_SOLICITED; i < num; i += RESPONSE_UNSOLICITED) {
            HardwareConfig hw;
            int type = p.readInt();
            switch (type) {
                case RESPONSE_SOLICITED /*0*/:
                    hw = new HardwareConfig(type);
                    hw.assignModem(p.readString(), p.readInt(), p.readInt(), p.readInt(), p.readInt(), p.readInt(), p.readInt());
                    break;
                case RESPONSE_UNSOLICITED /*1*/:
                    hw = new HardwareConfig(type);
                    hw.assignSim(p.readString(), p.readInt(), p.readString());
                    break;
                default:
                    throw new RuntimeException("RIL_REQUEST_GET_HARDWARE_CONFIG invalid hardward type:" + type);
            }
            response.add(hw);
        }
        return response;
    }

    private Object responseRadioCapability(Parcel p) {
        int version = p.readInt();
        int session = p.readInt();
        int phase = p.readInt();
        int rat = p.readInt();
        String logicModemUuid = p.readString();
        int status = p.readInt();
        riljLog("responseRadioCapability: version= " + version + ", session=" + session + ", phase=" + phase + ", rat=" + rat + ", logicModemUuid=" + logicModemUuid + ", status=" + status);
        return new RadioCapability(this.mInstanceId.intValue(), session, phase, rat, logicModemUuid, status);
    }

    static String requestToString(int request) {
        switch (request) {
            case RESPONSE_UNSOLICITED /*1*/:
                return "GET_SIM_STATUS";
            case EVENT_WAKE_LOCK_TIMEOUT /*2*/:
                return "ENTER_SIM_PIN";
            case CDMA_BSI_NO_OF_INTS_STRUCT /*3*/:
                return "ENTER_SIM_PUK";
            case CharacterSets.ISO_8859_1 /*4*/:
                return "ENTER_SIM_PIN2";
            case CharacterSets.ISO_8859_2 /*5*/:
                return "ENTER_SIM_PUK2";
            case CharacterSets.ISO_8859_3 /*6*/:
                return "CHANGE_SIM_PIN";
            case CharacterSets.ISO_8859_4 /*7*/:
                return "CHANGE_SIM_PIN2";
            case CharacterSets.ISO_8859_5 /*8*/:
                return "ENTER_NETWORK_DEPERSONALIZATION";
            case CharacterSets.ISO_8859_6 /*9*/:
                return "GET_CURRENT_CALLS";
            case CharacterSets.ISO_8859_7 /*10*/:
                return "DIAL";
            case CharacterSets.ISO_8859_8 /*11*/:
                return "GET_IMSI";
            case CharacterSets.ISO_8859_9 /*12*/:
                return "HANGUP";
            case UserData.ASCII_CR_INDEX /*13*/:
                return "HANGUP_WAITING_OR_BACKGROUND";
            case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                return "HANGUP_FOREGROUND_RESUME_BACKGROUND";
            case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                return "REQUEST_SWITCH_WAITING_OR_HOLDING_AND_ACTIVE";
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
                return "CONFERENCE";
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
                return "UDUB";
            case PduHeaders.MMS_VERSION_1_2 /*18*/:
                return "LAST_CALL_FAIL_CAUSE";
            case PduHeaders.MMS_VERSION_1_3 /*19*/:
                return "SIGNAL_STRENGTH";
            case SmsHeader.ELT_ID_EXTENDED_OBJECT /*20*/:
                return "VOICE_REGISTRATION_STATE";
            case SmsHeader.ELT_ID_REUSED_EXTENDED_OBJECT /*21*/:
                return "DATA_REGISTRATION_STATE";
            case CallFailCause.NUMBER_CHANGED /*22*/:
                return "OPERATOR";
            case SmsHeader.ELT_ID_OBJECT_DISTR_INDICATOR /*23*/:
                return "RADIO_POWER";
            case SmsHeader.ELT_ID_STANDARD_WVG_OBJECT /*24*/:
                return "DTMF";
            case SmsHeader.ELT_ID_CHARACTER_SIZE_WVG_OBJECT /*25*/:
                return "SEND_SMS";
            case SmsHeader.ELT_ID_EXTENDED_OBJECT_DATA_REQUEST_CMD /*26*/:
                return "SEND_SMS_EXPECT_MORE";
            case 27:
                return "SETUP_DATA_CALL";
            case 28:
                return "SIM_IO";
            case 29:
                return "SEND_USSD";
            case CallFailCause.STATUS_ENQUIRY /*30*/:
                return "CANCEL_USSD";
            case CDMA_BROADCAST_SMS_NO_OF_SERVICE_CATEGORIES /*31*/:
                return "GET_CLIR";
            case UserData.PRINTABLE_ASCII_MIN_INDEX /*32*/:
                return "SET_CLIR";
            case SmsHeader.ELT_ID_HYPERLINK_FORMAT_ELEMENT /*33*/:
                return "QUERY_CALL_FORWARD_STATUS";
            case CallFailCause.NO_CIRCUIT_AVAIL /*34*/:
                return "SET_CALL_FORWARD";
            case SmsHeader.ELT_ID_ENHANCED_VOICE_MAIL_INFORMATION /*35*/:
                return "QUERY_CALL_WAITING";
            case CdmaSmsAddress.SMS_SUBADDRESS_MAX /*36*/:
                return "SET_CALL_WAITING";
            case SmsHeader.ELT_ID_NATIONAL_LANGUAGE_LOCKING_SHIFT /*37*/:
                return "SMS_ACKNOWLEDGE";
            case RadioNVItems.RIL_NV_MIP_PROFILE_HA_SPI /*38*/:
                return "GET_IMEI";
            case RadioNVItems.RIL_NV_MIP_PROFILE_AAA_SPI /*39*/:
                return "GET_IMEISV";
            case RadioNVItems.RIL_NV_MIP_PROFILE_MN_HA_SS /*40*/:
                return "ANSWER";
            case CallFailCause.TEMPORARY_FAILURE /*41*/:
                return "DEACTIVATE_DATA_CALL";
            case CallFailCause.SWITCHING_CONGESTION /*42*/:
                return "QUERY_FACILITY_LOCK";
            case 43:
                return "SET_FACILITY_LOCK";
            case CallFailCause.CHANNEL_NOT_AVAIL /*44*/:
                return "CHANGE_BARRING_PASSWORD";
            case 45:
                return "QUERY_NETWORK_SELECTION_MODE";
            case 46:
                return "SET_NETWORK_SELECTION_AUTOMATIC";
            case WspTypeDecoder.PARAMETER_ID_X_WAP_APPLICATION_ID /*47*/:
                return "SET_NETWORK_SELECTION_MANUAL";
            case 48:
                return "QUERY_AVAILABLE_NETWORKS ";
            case CallFailCause.QOS_NOT_AVAIL /*49*/:
                return "DTMF_START";
            case 50:
                return "DTMF_STOP";
            case RadioNVItems.RIL_NV_CDMA_PRL_VERSION /*51*/:
                return "BASEBAND_VERSION";
            case RadioNVItems.RIL_NV_CDMA_BC10 /*52*/:
                return "SEPARATE_CONNECTION";
            case RadioNVItems.RIL_NV_CDMA_BC14 /*53*/:
                return "SET_MUTE";
            case RadioNVItems.RIL_NV_CDMA_SO68 /*54*/:
                return "GET_MUTE";
            case RadioNVItems.RIL_NV_CDMA_SO73_COP0 /*55*/:
                return "QUERY_CLIP";
            case RadioNVItems.RIL_NV_CDMA_SO73_COP1TO7 /*56*/:
                return "LAST_DATA_CALL_FAIL_CAUSE";
            case RadioNVItems.RIL_NV_CDMA_1X_ADVANCED_ENABLED /*57*/:
                return "DATA_CALL_LIST";
            case CallFailCause.BEARER_NOT_AVAIL /*58*/:
                return "RESET_RADIO";
            case RadioNVItems.RIL_NV_CDMA_EHRPD_FORCED /*59*/:
                return "OEM_HOOK_RAW";
            case 60:
                return "OEM_HOOK_STRINGS";
            case 61:
                return "SCREEN_STATE";
            case 62:
                return "SET_SUPP_SVC_NOTIFICATION";
            case SignalToneUtil.IS95_CONST_IR_SIG_TONE_NO_TONE /*63*/:
                return "WRITE_SMS_TO_SIM";
            case CommandsInterface.SERVICE_CLASS_PACKET /*64*/:
                return "DELETE_SMS_ON_SIM";
            case 65:
                return "SET_BAND_MODE";
            case 66:
                return "QUERY_AVAILABLE_BAND_MODE";
            case 67:
                return "REQUEST_STK_GET_PROFILE";
            case CallFailCause.ACM_LIMIT_EXCEEDED /*68*/:
                return "REQUEST_STK_SET_PROFILE";
            case 69:
                return "REQUEST_STK_SEND_ENVELOPE_COMMAND";
            case 70:
                return "REQUEST_STK_SEND_TERMINAL_RESPONSE";
            case RadioNVItems.RIL_NV_LTE_BAND_ENABLE_25 /*71*/:
                return "REQUEST_STK_HANDLE_CALL_SETUP_REQUESTED_FROM_SIM";
            case RadioNVItems.RIL_NV_LTE_BAND_ENABLE_26 /*72*/:
                return "REQUEST_EXPLICIT_CALL_TRANSFER";
            case RadioNVItems.RIL_NV_LTE_BAND_ENABLE_41 /*73*/:
                return "REQUEST_SET_PREFERRED_NETWORK_TYPE";
            case RadioNVItems.RIL_NV_LTE_SCAN_PRIORITY_25 /*74*/:
                return "REQUEST_GET_PREFERRED_NETWORK_TYPE";
            case RadioNVItems.RIL_NV_LTE_SCAN_PRIORITY_26 /*75*/:
                return "REQUEST_GET_NEIGHBORING_CELL_IDS";
            case RadioNVItems.RIL_NV_LTE_SCAN_PRIORITY_41 /*76*/:
                return "REQUEST_SET_LOCATION_UPDATES";
            case RadioNVItems.RIL_NV_LTE_HIDDEN_BAND_PRIORITY_25 /*77*/:
                return "RIL_REQUEST_CDMA_SET_SUBSCRIPTION_SOURCE";
            case RadioNVItems.RIL_NV_LTE_HIDDEN_BAND_PRIORITY_26 /*78*/:
                return "RIL_REQUEST_CDMA_SET_ROAMING_PREFERENCE";
            case RadioNVItems.RIL_NV_LTE_HIDDEN_BAND_PRIORITY_41 /*79*/:
                return "RIL_REQUEST_CDMA_QUERY_ROAMING_PREFERENCE";
            case RadioNVItems.RIL_NV_LTE_NEXT_SCAN /*80*/:
                return "RIL_REQUEST_SET_TTY_MODE";
            case RadioNVItems.RIL_NV_LTE_BSR_TIMER /*81*/:
                return "RIL_REQUEST_QUERY_TTY_MODE";
            case RadioNVItems.RIL_NV_LTE_BSR_MAX_TIME /*82*/:
                return "RIL_REQUEST_CDMA_SET_PREFERRED_VOICE_PRIVACY_MODE";
            case 83:
                return "RIL_REQUEST_CDMA_QUERY_PREFERRED_VOICE_PRIVACY_MODE";
            case 84:
                return "RIL_REQUEST_CDMA_FLASH";
            case 85:
                return "RIL_REQUEST_CDMA_BURST_DTMF";
            case 86:
                return "RIL_REQUEST_CDMA_VALIDATE_AND_WRITE_AKEY";
            case 87:
                return "RIL_REQUEST_CDMA_SEND_SMS";
            case 88:
                return "RIL_REQUEST_CDMA_SMS_ACKNOWLEDGE";
            case 89:
                return "RIL_REQUEST_GSM_GET_BROADCAST_CONFIG";
            case 90:
                return "RIL_REQUEST_GSM_SET_BROADCAST_CONFIG";
            case 91:
                return "RIL_REQUEST_GSM_BROADCAST_ACTIVATION";
            case 92:
                return "RIL_REQUEST_CDMA_GET_BROADCAST_CONFIG";
            case 93:
                return "RIL_REQUEST_CDMA_SET_BROADCAST_CONFIG";
            case 94:
                return "RIL_REQUEST_CDMA_BROADCAST_ACTIVATION";
            case 95:
                return "RIL_REQUEST_CDMA_SUBSCRIPTION";
            case CommandsInterface.CDMA_SMS_FAIL_CAUSE_ENCODING_PROBLEM /*96*/:
                return "RIL_REQUEST_CDMA_WRITE_SMS_TO_RUIM";
            case 97:
                return "RIL_REQUEST_CDMA_DELETE_SMS_ON_RUIM";
            case 98:
                return "RIL_REQUEST_DEVICE_IDENTITY";
            case 99:
                return "REQUEST_EXIT_EMERGENCY_CALLBACK_MODE";
            case IccRecords.EVENT_GET_ICC_RECORD_DONE /*100*/:
                return "RIL_REQUEST_GET_SMSC_ADDRESS";
            case 101:
                return "RIL_REQUEST_SET_SMSC_ADDRESS";
            case 102:
                return "RIL_REQUEST_REPORT_SMS_MEMORY_STATUS";
            case 103:
                return "RIL_REQUEST_REPORT_STK_SERVICE_IS_RUNNING";
            case 104:
                return "RIL_REQUEST_CDMA_GET_SUBSCRIPTION_SOURCE";
            case 105:
                return "RIL_REQUEST_ISIM_AUTHENTICATION";
            case CharacterSets.UTF_8 /*106*/:
                return "RIL_REQUEST_ACKNOWLEDGE_INCOMING_GSM_SMS_WITH_PDU";
            case 107:
                return "RIL_REQUEST_STK_SEND_ENVELOPE_WITH_STATUS";
            case 108:
                return "RIL_REQUEST_VOICE_RADIO_TECH";
            case 109:
                return "RIL_REQUEST_GET_CELL_INFO_LIST";
            case 110:
                return "RIL_REQUEST_SET_CELL_INFO_LIST_RATE";
            case 111:
                return "RIL_REQUEST_SET_INITIAL_ATTACH_APN";
            case 112:
                return "RIL_REQUEST_IMS_REGISTRATION_STATE";
            case 113:
                return "RIL_REQUEST_IMS_SEND_SMS";
            case 114:
                return "RIL_REQUEST_SIM_TRANSMIT_APDU_BASIC";
            case 115:
                return "RIL_REQUEST_SIM_OPEN_CHANNEL";
            case 116:
                return "RIL_REQUEST_SIM_CLOSE_CHANNEL";
            case 117:
                return "RIL_REQUEST_SIM_TRANSMIT_APDU_CHANNEL";
            case 118:
                return "RIL_REQUEST_NV_READ_ITEM";
            case 119:
                return "RIL_REQUEST_NV_WRITE_ITEM";
            case 120:
                return "RIL_REQUEST_NV_WRITE_CDMA_PRL";
            case 121:
                return "RIL_REQUEST_NV_RESET_CONFIG";
            case 122:
                return "RIL_REQUEST_SET_UICC_SUBSCRIPTION";
            case 123:
                return "RIL_REQUEST_ALLOW_DATA";
            case 124:
                return "GET_HARDWARE_CONFIG";
            case 125:
                return "RIL_REQUEST_SIM_AUTHENTICATION";
            case PduPart.P_Q /*128*/:
                return "RIL_REQUEST_SET_DATA_PROFILE";
            case PduPart.P_DISPOSITION_ATTACHMENT /*129*/:
                return "RIL_REQUEST_SHUTDOWN";
            case PduPart.P_LEVEL /*130*/:
                return "RIL_REQUEST_GET_RADIO_CAPABILITY";
            case PduPart.P_TYPE /*131*/:
                return "RIL_REQUEST_SET_RADIO_CAPABILITY";
            default:
                return "<unknown request>";
        }
    }

    static String responseToString(int request) {
        switch (request) {
            case CharacterSets.UCS2 /*1000*/:
                return "UNSOL_RESPONSE_RADIO_STATE_CHANGED";
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_DROP /*1001*/:
                return "UNSOL_RESPONSE_CALL_STATE_CHANGED";
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_INTERCEPT /*1002*/:
                return "UNSOL_RESPONSE_VOICE_NETWORK_STATE_CHANGED";
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_REORDER /*1003*/:
                return "UNSOL_RESPONSE_NEW_SMS";
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_SO_REJECT /*1004*/:
                return "UNSOL_RESPONSE_NEW_SMS_STATUS_REPORT";
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_RETRY_ORDER /*1005*/:
                return "UNSOL_RESPONSE_NEW_SMS_ON_SIM";
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_ACCESS_FAILURE /*1006*/:
                return "UNSOL_ON_USSD";
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_PREEMPTED /*1007*/:
                return "UNSOL_ON_USSD_REQUEST";
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_NOT_EMERGENCY /*1008*/:
                return "UNSOL_NITZ_TIME_RECEIVED";
            case com.android.internal.telephony.cdma.CallFailCause.CDMA_ACCESS_BLOCKED /*1009*/:
                return "UNSOL_SIGNAL_STRENGTH";
            case 1010:
                return "UNSOL_DATA_CALL_LIST_CHANGED";
            case 1011:
                return "UNSOL_SUPP_SVC_NOTIFICATION";
            case 1012:
                return "UNSOL_STK_SESSION_END";
            case 1013:
                return "UNSOL_STK_PROACTIVE_COMMAND";
            case 1014:
                return "UNSOL_STK_EVENT_NOTIFY";
            case CharacterSets.UTF_16 /*1015*/:
                return "UNSOL_STK_CALL_SETUP";
            case 1016:
                return "UNSOL_SIM_SMS_STORAGE_FULL";
            case 1017:
                return "UNSOL_SIM_REFRESH";
            case 1018:
                return "UNSOL_CALL_RING";
            case 1019:
                return "UNSOL_RESPONSE_SIM_STATUS_CHANGED";
            case 1020:
                return "UNSOL_RESPONSE_CDMA_NEW_SMS";
            case 1021:
                return "UNSOL_RESPONSE_NEW_BROADCAST_SMS";
            case 1022:
                return "UNSOL_CDMA_RUIM_SMS_STORAGE_FULL";
            case 1023:
                return "UNSOL_RESTRICTED_STATE_CHANGED";
            case 1024:
                return "UNSOL_ENTER_EMERGENCY_CALLBACK_MODE";
            case 1025:
                return "UNSOL_CDMA_CALL_WAITING";
            case 1026:
                return "UNSOL_CDMA_OTA_PROVISION_STATUS";
            case 1027:
                return "UNSOL_CDMA_INFO_REC";
            case 1028:
                return "UNSOL_OEM_HOOK_RAW";
            case 1029:
                return "UNSOL_RINGBACK_TONE";
            case 1030:
                return "UNSOL_RESEND_INCALL_MUTE";
            case 1031:
                return "CDMA_SUBSCRIPTION_SOURCE_CHANGED";
            case 1032:
                return "UNSOL_CDMA_PRL_CHANGED";
            case 1033:
                return "UNSOL_EXIT_EMERGENCY_CALLBACK_MODE";
            case 1034:
                return "UNSOL_RIL_CONNECTED";
            case 1035:
                return "UNSOL_VOICE_RADIO_TECH_CHANGED";
            case 1036:
                return "UNSOL_CELL_INFO_LIST";
            case 1037:
                return "UNSOL_RESPONSE_IMS_NETWORK_STATE_CHANGED";
            case 1038:
                return "RIL_UNSOL_UICC_SUBSCRIPTION_STATUS_CHANGED";
            case 1039:
                return "UNSOL_SRVCC_STATE_NOTIFY";
            case 1040:
                return "RIL_UNSOL_HARDWARE_CONFIG_CHANGED";
            case 1042:
                return "RIL_UNSOL_RADIO_CAPABILITY";
            case 1043:
                return "UNSOL_ON_SS";
            case 1044:
                return "UNSOL_STK_CC_ALPHA_NOTIFY";
            default:
                return "<unknown response>";
        }
    }

    protected void riljLog(String msg) {
        Rlog.d(RILJ_LOG_TAG, msg + (this.mInstanceId != null ? " [SUB" + this.mInstanceId + "]" : ""));
    }

    protected void riljLogv(String msg) {
        Rlog.v(RILJ_LOG_TAG, msg + (this.mInstanceId != null ? " [SUB" + this.mInstanceId + "]" : ""));
    }

    protected void unsljLog(int response) {
        riljLog("[UNSL]< " + responseToString(response));
    }

    protected void unsljLogMore(int response, String more) {
        riljLog("[UNSL]< " + responseToString(response) + " " + more);
    }

    protected void unsljLogRet(int response, Object ret) {
        riljLog("[UNSL]< " + responseToString(response) + " " + retToString(response, ret));
    }

    protected void unsljLogvRet(int response, Object ret) {
        riljLogv("[UNSL]< " + responseToString(response) + " " + retToString(response, ret));
    }

    private Object responseSsData(Parcel p) {
        SsData ssData = new SsData();
        ssData.serviceType = ssData.ServiceTypeFromRILInt(p.readInt());
        ssData.requestType = ssData.RequestTypeFromRILInt(p.readInt());
        ssData.teleserviceType = ssData.TeleserviceTypeFromRILInt(p.readInt());
        ssData.serviceClass = p.readInt();
        ssData.result = p.readInt();
        int num = p.readInt();
        int i;
        if (ssData.serviceType.isTypeCF() && ssData.requestType.isTypeInterrogation()) {
            ssData.cfInfo = new CallForwardInfo[num];
            for (i = RESPONSE_SOLICITED; i < num; i += RESPONSE_UNSOLICITED) {
                ssData.cfInfo[i] = new CallForwardInfo();
                ssData.cfInfo[i].status = p.readInt();
                ssData.cfInfo[i].reason = p.readInt();
                ssData.cfInfo[i].serviceClass = p.readInt();
                ssData.cfInfo[i].toa = p.readInt();
                ssData.cfInfo[i].number = p.readString();
                ssData.cfInfo[i].timeSeconds = p.readInt();
                riljLog("[SS Data] CF Info " + i + " : " + ssData.cfInfo[i]);
            }
        } else {
            ssData.ssInfo = new int[num];
            for (i = RESPONSE_SOLICITED; i < num; i += RESPONSE_UNSOLICITED) {
                ssData.ssInfo[i] = p.readInt();
                riljLog("[SS Data] SS Info " + i + " : " + ssData.ssInfo[i]);
            }
        }
        return ssData;
    }

    public void getDeviceIdentity(Message response) {
        RILRequest rr = RILRequest.obtain(98, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getCDMASubscription(Message response) {
        RILRequest rr = RILRequest.obtain(95, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setPhoneType(int phoneType) {
        riljLog("setPhoneType=" + phoneType + " old value=" + this.mPhoneType);
        this.mPhoneType = phoneType;
    }

    public void queryCdmaRoamingPreference(Message response) {
        RILRequest rr = RILRequest.obtain(79, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setCdmaRoamingPreference(int cdmaRoamingType, Message response) {
        RILRequest rr = RILRequest.obtain(78, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(cdmaRoamingType);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " : " + cdmaRoamingType);
        send(rr);
    }

    public void setCdmaSubscriptionSource(int cdmaSubscription, Message response) {
        RILRequest rr = RILRequest.obtain(77, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(cdmaSubscription);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " : " + cdmaSubscription);
        send(rr);
    }

    public void getCdmaSubscriptionSource(Message response) {
        RILRequest rr = RILRequest.obtain(104, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void queryTTYMode(Message response) {
        RILRequest rr = RILRequest.obtain(81, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setTTYMode(int ttyMode, Message response) {
        RILRequest rr = RILRequest.obtain(80, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(ttyMode);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " : " + ttyMode);
        send(rr);
    }

    public void sendCDMAFeatureCode(String FeatureCode, Message response) {
        RILRequest rr = RILRequest.obtain(84, response);
        rr.mParcel.writeString(FeatureCode);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " : " + FeatureCode);
        send(rr);
    }

    public void getCdmaBroadcastConfig(Message response) {
        send(RILRequest.obtain(92, response));
    }

    public void setCdmaBroadcastConfig(CdmaSmsBroadcastConfigInfo[] configs, Message response) {
        RILRequest rr = RILRequest.obtain(93, response);
        ArrayList<CdmaSmsBroadcastConfigInfo> processedConfigs = new ArrayList();
        CdmaSmsBroadcastConfigInfo[] arr$ = configs;
        int len$ = arr$.length;
        for (int i$ = RESPONSE_SOLICITED; i$ < len$; i$ += RESPONSE_UNSOLICITED) {
            int i;
            CdmaSmsBroadcastConfigInfo config = arr$[i$];
            for (i = config.getFromServiceCategory(); i <= config.getToServiceCategory(); i += RESPONSE_UNSOLICITED) {
                processedConfigs.add(new CdmaSmsBroadcastConfigInfo(i, i, config.getLanguage(), config.isSelected()));
            }
        }
        CdmaSmsBroadcastConfigInfo[] rilConfigs = (CdmaSmsBroadcastConfigInfo[]) processedConfigs.toArray(configs);
        rr.mParcel.writeInt(rilConfigs.length);
        for (i = RESPONSE_SOLICITED; i < rilConfigs.length; i += RESPONSE_UNSOLICITED) {
            rr.mParcel.writeInt(rilConfigs[i].getFromServiceCategory());
            rr.mParcel.writeInt(rilConfigs[i].getLanguage());
            rr.mParcel.writeInt(rilConfigs[i].isSelected() ? RESPONSE_UNSOLICITED : RESPONSE_SOLICITED);
        }
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " with " + rilConfigs.length + " configs : ");
        for (i = RESPONSE_SOLICITED; i < rilConfigs.length; i += RESPONSE_UNSOLICITED) {
            riljLog(rilConfigs[i].toString());
        }
        send(rr);
    }

    public void setCdmaBroadcastActivation(boolean activate, Message response) {
        int i = RESPONSE_UNSOLICITED;
        RILRequest rr = RILRequest.obtain(94, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        Parcel parcel = rr.mParcel;
        if (activate) {
            i = RESPONSE_SOLICITED;
        }
        parcel.writeInt(i);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void exitEmergencyCallbackMode(Message response) {
        RILRequest rr = RILRequest.obtain(99, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void requestIsimAuthentication(String nonce, Message response) {
        RILRequest rr = RILRequest.obtain(105, response);
        rr.mParcel.writeString(nonce);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void requestIccSimAuthentication(int authContext, String data, String aid, Message response) {
        RILRequest rr = RILRequest.obtain(125, response);
        rr.mParcel.writeInt(authContext);
        rr.mParcel.writeString(data);
        rr.mParcel.writeString(aid);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void getCellInfoList(Message result) {
        RILRequest rr = RILRequest.obtain(109, result);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setCellInfoListRate(int rateInMillis, Message response) {
        riljLog("setCellInfoListRate: " + rateInMillis);
        RILRequest rr = RILRequest.obtain(110, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(rateInMillis);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void setInitialAttachApn(String apn, String protocol, int authType, String username, String password, Message result) {
        RILRequest rr = RILRequest.obtain(111, null);
        riljLog("Set RIL_REQUEST_SET_INITIAL_ATTACH_APN");
        rr.mParcel.writeString(apn);
        rr.mParcel.writeString(protocol);
        rr.mParcel.writeInt(authType);
        rr.mParcel.writeString(username);
        rr.mParcel.writeString(password);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + ", apn:" + apn + ", protocol:" + protocol + ", authType:" + authType + ", username:" + username + ", password:" + password);
        send(rr);
    }

    public void setDataProfile(DataProfile[] dps, Message result) {
        riljLog("Set RIL_REQUEST_SET_DATA_PROFILE");
        RILRequest rr = RILRequest.obtain(PduPart.P_Q, null);
        DataProfile.toParcel(rr.mParcel, dps);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " with " + dps + " Data Profiles : ");
        for (int i = RESPONSE_SOLICITED; i < dps.length; i += RESPONSE_UNSOLICITED) {
            riljLog(dps[i].toString());
        }
        send(rr);
    }

    public void testingEmergencyCall() {
        riljLog("testingEmergencyCall");
        this.mTestingEmergencyCall.set(RILJ_LOGD);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("RIL: " + this);
        pw.println(" mSocket=" + this.mSocket);
        pw.println(" mSenderThread=" + this.mSenderThread);
        pw.println(" mSender=" + this.mSender);
        pw.println(" mReceiverThread=" + this.mReceiverThread);
        pw.println(" mReceiver=" + this.mReceiver);
        pw.println(" mWakeLock=" + this.mWakeLock);
        pw.println(" mWakeLockTimeout=" + this.mWakeLockTimeout);
        synchronized (this.mRequestList) {
            synchronized (this.mWakeLock) {
                pw.println(" mWakeLockCount=" + this.mWakeLockCount);
            }
            int count = this.mRequestList.size();
            pw.println(" mRequestList count=" + count);
            for (int i = RESPONSE_SOLICITED; i < count; i += RESPONSE_UNSOLICITED) {
                RILRequest rr = (RILRequest) this.mRequestList.valueAt(i);
                pw.println("  [" + rr.mSerial + "] " + requestToString(rr.mRequest));
            }
        }
        pw.println(" mLastNITZTimeInfo=" + this.mLastNITZTimeInfo);
        pw.println(" mTestingEmergencyCall=" + this.mTestingEmergencyCall.get());
    }

    public void iccOpenLogicalChannel(String AID, Message response) {
        if (this.mRilVersion >= 10) {
            RILRequest rr = RILRequest.obtain(115, response);
            rr.mParcel.writeString(AID);
            riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
            send(rr);
        } else if (response != null) {
            AsyncResult.forMessage(response, null, new CommandException(Error.REQUEST_NOT_SUPPORTED));
            response.sendToTarget();
        }
    }

    public void iccCloseLogicalChannel(int channel, Message response) {
        RILRequest rr = RILRequest.obtain(116, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(channel);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }

    public void iccTransmitApduLogicalChannel(int channel, int cla, int instruction, int p1, int p2, int p3, String data, Message response) {
        if (this.mRilVersion < 10) {
            if (response != null) {
                AsyncResult.forMessage(response, null, new CommandException(Error.REQUEST_NOT_SUPPORTED));
                response.sendToTarget();
            }
        } else if (channel <= 0) {
            throw new RuntimeException("Invalid channel in iccTransmitApduLogicalChannel: " + channel);
        } else {
            iccTransmitApduHelper(117, channel, cla, instruction, p1, p2, p3, data, response);
        }
    }

    public void iccTransmitApduBasicChannel(int cla, int instruction, int p1, int p2, int p3, String data, Message response) {
        iccTransmitApduHelper(114, RESPONSE_SOLICITED, cla, instruction, p1, p2, p3, data, response);
    }

    private void iccTransmitApduHelper(int rilCommand, int channel, int cla, int instruction, int p1, int p2, int p3, String data, Message response) {
        if (this.mRilVersion >= 10) {
            RILRequest rr = RILRequest.obtain(rilCommand, response);
            rr.mParcel.writeInt(channel);
            rr.mParcel.writeInt(cla);
            rr.mParcel.writeInt(instruction);
            rr.mParcel.writeInt(p1);
            rr.mParcel.writeInt(p2);
            rr.mParcel.writeInt(p3);
            rr.mParcel.writeString(data);
            riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
            send(rr);
        } else if (response != null) {
            AsyncResult.forMessage(response, null, new CommandException(Error.REQUEST_NOT_SUPPORTED));
            response.sendToTarget();
        }
    }

    public void nvReadItem(int itemID, Message response) {
        RILRequest rr = RILRequest.obtain(118, response);
        rr.mParcel.writeInt(itemID);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + ' ' + itemID);
        send(rr);
    }

    public void nvWriteItem(int itemID, String itemValue, Message response) {
        RILRequest rr = RILRequest.obtain(119, response);
        rr.mParcel.writeInt(itemID);
        rr.mParcel.writeString(itemValue);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + ' ' + itemID + ": " + itemValue);
        send(rr);
    }

    public void nvWriteCdmaPrl(byte[] preferredRoamingList, Message response) {
        RILRequest rr = RILRequest.obtain(120, response);
        rr.mParcel.writeByteArray(preferredRoamingList);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " (" + preferredRoamingList.length + " bytes)");
        send(rr);
    }

    public void nvResetConfig(int resetType, Message response) {
        RILRequest rr = RILRequest.obtain(121, response);
        rr.mParcel.writeInt(RESPONSE_UNSOLICITED);
        rr.mParcel.writeInt(resetType);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + ' ' + resetType);
        send(rr);
    }

    public void setRadioCapability(RadioCapability rc, Message response) {
        RILRequest rr = RILRequest.obtain(PduPart.P_TYPE, response);
        rr.mParcel.writeInt(rc.getVersion());
        rr.mParcel.writeInt(rc.getSession());
        rr.mParcel.writeInt(rc.getPhase());
        rr.mParcel.writeInt(rc.getRadioAccessFamily());
        rr.mParcel.writeString(rc.getLogicalModemUuid());
        rr.mParcel.writeInt(rc.getStatus());
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest) + " " + rc.toString());
        send(rr);
    }

    public void getRadioCapability(Message response) {
        RILRequest rr = RILRequest.obtain(PduPart.P_LEVEL, response);
        riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));
        send(rr);
    }
}
