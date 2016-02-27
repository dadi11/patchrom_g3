package com.android.internal.telephony;

import android.content.Context;
import android.content.Intent;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.telephony.RadioAccessFamily;
import android.telephony.Rlog;
import android.telephony.TelephonyManager;
import com.android.internal.telephony.dataconnection.DctController;
import com.android.internal.telephony.uicc.UiccController;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;

public class ProxyController {
    private static final int EVENT_APPLY_RC_RESPONSE = 3;
    private static final int EVENT_FINISH_RC_RESPONSE = 4;
    private static final int EVENT_NOTIFICATION_RC_CHANGED = 1;
    private static final int EVENT_START_RC_RESPONSE = 2;
    static final String LOG_TAG = "ProxyController";
    private static final int SET_RC_STATUS_APPLYING = 3;
    private static final int SET_RC_STATUS_FAIL = 5;
    private static final int SET_RC_STATUS_IDLE = 0;
    private static final int SET_RC_STATUS_STARTED = 2;
    private static final int SET_RC_STATUS_STARTING = 1;
    private static final int SET_RC_STATUS_SUCCESS = 4;
    private static final int SET_RC_TIMEOUT_WAITING_MSEC = 45000;
    private static ProxyController sProxyController;
    private CommandsInterface[] mCi;
    private Context mContext;
    private DctController mDctController;
    private Handler mHandler;
    private String[] mLogicalModemIds;
    private int[] mNewRadioAccessFamily;
    private int[] mOldRadioAccessFamily;
    private PhoneSubInfoController mPhoneSubInfoController;
    private PhoneProxy[] mProxyPhones;
    private int mRadioAccessFamilyStatusCounter;
    private int mRadioCapabilitySessionId;
    private int[] mSetRadioAccessFamilyStatus;
    RadioCapabilityRunnable mSetRadioCapabilityRunnable;
    private UiccController mUiccController;
    private UiccPhoneBookController mUiccPhoneBookController;
    private UiccSmsController mUiccSmsController;
    private AtomicInteger mUniqueIdGenerator;
    WakeLock mWakeLock;

    /* renamed from: com.android.internal.telephony.ProxyController.1 */
    class C00141 extends Handler {
        C00141() {
        }

        public void handleMessage(Message msg) {
            ProxyController.this.logd("handleMessage msg.what=" + msg.what);
            switch (msg.what) {
                case ProxyController.SET_RC_STATUS_STARTING /*1*/:
                    ProxyController.this.onNotificationRadioCapabilityChanged(msg);
                case ProxyController.SET_RC_STATUS_STARTED /*2*/:
                    ProxyController.this.onStartRadioCapabilityResponse(msg);
                case ProxyController.SET_RC_STATUS_APPLYING /*3*/:
                    ProxyController.this.onApplyRadioCapabilityResponse(msg);
                case ProxyController.SET_RC_STATUS_SUCCESS /*4*/:
                    ProxyController.this.onFinishRadioCapabilityResponse(msg);
                default:
            }
        }
    }

    private class RadioCapabilityRunnable implements Runnable {
        private int mSessionId;

        public void setTimeoutState(int sessionId) {
            this.mSessionId = sessionId;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void run() {
            /*
            r6 = this;
            r2 = r6.mSessionId;
            r3 = com.android.internal.telephony.ProxyController.this;
            r3 = r3.mRadioCapabilitySessionId;
            if (r2 == r3) goto L_0x0035;
        L_0x000a:
            r2 = com.android.internal.telephony.ProxyController.this;
            r3 = new java.lang.StringBuilder;
            r3.<init>();
            r4 = "RadioCapability timeout: Ignore mSessionId=";
            r3 = r3.append(r4);
            r4 = r6.mSessionId;
            r3 = r3.append(r4);
            r4 = "!= mRadioCapabilitySessionId=";
            r3 = r3.append(r4);
            r4 = com.android.internal.telephony.ProxyController.this;
            r4 = r4.mRadioCapabilitySessionId;
            r3 = r3.append(r4);
            r3 = r3.toString();
            r2.logd(r3);
        L_0x0034:
            return;
        L_0x0035:
            r2 = com.android.internal.telephony.ProxyController.this;
            r3 = r2.mSetRadioAccessFamilyStatus;
            monitor-enter(r3);
            r0 = 0;
        L_0x003d:
            r2 = com.android.internal.telephony.ProxyController.this;	 Catch:{ all -> 0x008a }
            r2 = r2.mProxyPhones;	 Catch:{ all -> 0x008a }
            r2 = r2.length;	 Catch:{ all -> 0x008a }
            if (r0 >= r2) goto L_0x0073;
        L_0x0046:
            r2 = com.android.internal.telephony.ProxyController.this;	 Catch:{ all -> 0x008a }
            r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x008a }
            r4.<init>();	 Catch:{ all -> 0x008a }
            r5 = "RadioCapability timeout: mSetRadioAccessFamilyStatus[";
            r4 = r4.append(r5);	 Catch:{ all -> 0x008a }
            r4 = r4.append(r0);	 Catch:{ all -> 0x008a }
            r5 = "]=";
            r4 = r4.append(r5);	 Catch:{ all -> 0x008a }
            r5 = com.android.internal.telephony.ProxyController.this;	 Catch:{ all -> 0x008a }
            r5 = r5.mSetRadioAccessFamilyStatus;	 Catch:{ all -> 0x008a }
            r5 = r5[r0];	 Catch:{ all -> 0x008a }
            r4 = r4.append(r5);	 Catch:{ all -> 0x008a }
            r4 = r4.toString();	 Catch:{ all -> 0x008a }
            r2.logd(r4);	 Catch:{ all -> 0x008a }
            r0 = r0 + 1;
            goto L_0x003d;
        L_0x0073:
            r2 = com.android.internal.telephony.ProxyController.this;	 Catch:{ all -> 0x008a }
            r2 = r2.mUniqueIdGenerator;	 Catch:{ all -> 0x008a }
            r1 = r2.getAndIncrement();	 Catch:{ all -> 0x008a }
            r2 = com.android.internal.telephony.ProxyController.this;	 Catch:{ all -> 0x008a }
            r4 = 2;
            r2.issueFinish(r4, r1);	 Catch:{ all -> 0x008a }
            r2 = com.android.internal.telephony.ProxyController.this;	 Catch:{ all -> 0x008a }
            r2.completeRadioCapabilityTransaction();	 Catch:{ all -> 0x008a }
            monitor-exit(r3);	 Catch:{ all -> 0x008a }
            goto L_0x0034;
        L_0x008a:
            r2 = move-exception;
            monitor-exit(r3);	 Catch:{ all -> 0x008a }
            throw r2;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.ProxyController.RadioCapabilityRunnable.run():void");
        }
    }

    public static ProxyController getInstance(Context context, PhoneProxy[] phoneProxy, UiccController uiccController, CommandsInterface[] ci) {
        if (sProxyController == null) {
            sProxyController = new ProxyController(context, phoneProxy, uiccController, ci);
        }
        return sProxyController;
    }

    public static ProxyController getInstance() {
        return sProxyController;
    }

    private ProxyController(Context context, PhoneProxy[] phoneProxy, UiccController uiccController, CommandsInterface[] ci) {
        int i;
        this.mUniqueIdGenerator = new AtomicInteger(new Random().nextInt());
        this.mHandler = new C00141();
        logd("Constructor - Enter");
        this.mContext = context;
        this.mProxyPhones = phoneProxy;
        this.mUiccController = uiccController;
        this.mCi = ci;
        this.mDctController = DctController.makeDctController(phoneProxy);
        this.mUiccPhoneBookController = new UiccPhoneBookController(this.mProxyPhones);
        this.mPhoneSubInfoController = new PhoneSubInfoController(this.mProxyPhones);
        this.mUiccSmsController = new UiccSmsController(this.mProxyPhones);
        this.mSetRadioAccessFamilyStatus = new int[this.mProxyPhones.length];
        this.mNewRadioAccessFamily = new int[this.mProxyPhones.length];
        this.mOldRadioAccessFamily = new int[this.mProxyPhones.length];
        this.mLogicalModemIds = new String[this.mProxyPhones.length];
        for (i = SET_RC_STATUS_IDLE; i < this.mProxyPhones.length; i += SET_RC_STATUS_STARTING) {
            this.mLogicalModemIds[i] = Integer.toString(i);
        }
        this.mSetRadioCapabilityRunnable = new RadioCapabilityRunnable();
        this.mWakeLock = ((PowerManager) context.getSystemService("power")).newWakeLock(SET_RC_STATUS_STARTING, LOG_TAG);
        this.mWakeLock.setReferenceCounted(false);
        clearTransaction();
        for (i = SET_RC_STATUS_IDLE; i < this.mProxyPhones.length; i += SET_RC_STATUS_STARTING) {
            this.mProxyPhones[i].registerForRadioCapabilityChanged(this.mHandler, SET_RC_STATUS_STARTING, null);
        }
        logd("Constructor - Exit");
    }

    public void updateDataConnectionTracker(int sub) {
        this.mProxyPhones[sub].updateDataConnectionTracker();
    }

    public void enableDataConnectivity(int sub) {
        this.mProxyPhones[sub].setInternalDataEnabled(true);
    }

    public void disableDataConnectivity(int sub, Message dataCleanedUpMsg) {
        this.mProxyPhones[sub].setInternalDataEnabled(false, dataCleanedUpMsg);
    }

    public void updateCurrentCarrierInProvider(int sub) {
        this.mProxyPhones[sub].updateCurrentCarrierInProvider();
    }

    public void registerForAllDataDisconnected(int subId, Handler h, int what, Object obj) {
        int phoneId = SubscriptionController.getInstance().getPhoneId(subId);
        if (phoneId >= 0 && phoneId < TelephonyManager.getDefault().getPhoneCount()) {
            this.mProxyPhones[phoneId].registerForAllDataDisconnected(h, what, obj);
        }
    }

    public void unregisterForAllDataDisconnected(int subId, Handler h) {
        int phoneId = SubscriptionController.getInstance().getPhoneId(subId);
        if (phoneId >= 0 && phoneId < TelephonyManager.getDefault().getPhoneCount()) {
            this.mProxyPhones[phoneId].unregisterForAllDataDisconnected(h);
        }
    }

    public boolean isDataDisconnected(int subId) {
        int phoneId = SubscriptionController.getInstance().getPhoneId(subId);
        if (phoneId < 0 || phoneId >= TelephonyManager.getDefault().getPhoneCount()) {
            return false;
        }
        return ((PhoneBase) this.mProxyPhones[phoneId].getActivePhone()).mDcTracker.isDisconnected();
    }

    public int getRadioAccessFamily(int phoneId) {
        if (phoneId >= this.mProxyPhones.length) {
            return SET_RC_STATUS_STARTING;
        }
        return this.mProxyPhones[phoneId].getRadioAccessFamily();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean setRadioCapability(android.telephony.RadioAccessFamily[] r13) {
        /*
        r12 = this;
        r0 = 0;
        r10 = 1;
        r2 = r13.length;
        r3 = r12.mProxyPhones;
        r3 = r3.length;
        if (r2 == r3) goto L_0x0010;
    L_0x0008:
        r0 = new java.lang.RuntimeException;
        r2 = "Length of input rafs must equal to total phone count";
        r0.<init>(r2);
        throw r0;
    L_0x0010:
        r2 = r12.mSetRadioAccessFamilyStatus;
        monitor-enter(r2);
        r8 = 0;
    L_0x0014:
        r3 = r12.mProxyPhones;	 Catch:{ all -> 0x0142 }
        r3 = r3.length;	 Catch:{ all -> 0x0142 }
        if (r8 >= r3) goto L_0x0064;
    L_0x0019:
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0142 }
        r3.<init>();	 Catch:{ all -> 0x0142 }
        r4 = "setRadioCapability: mSetRadioAccessFamilyStatus[";
        r3 = r3.append(r4);	 Catch:{ all -> 0x0142 }
        r3 = r3.append(r8);	 Catch:{ all -> 0x0142 }
        r4 = "]=";
        r3 = r3.append(r4);	 Catch:{ all -> 0x0142 }
        r4 = r12.mSetRadioAccessFamilyStatus;	 Catch:{ all -> 0x0142 }
        r4 = r4[r8];	 Catch:{ all -> 0x0142 }
        r3 = r3.append(r4);	 Catch:{ all -> 0x0142 }
        r3 = r3.toString();	 Catch:{ all -> 0x0142 }
        r12.logd(r3);	 Catch:{ all -> 0x0142 }
        r3 = r12.mSetRadioAccessFamilyStatus;	 Catch:{ all -> 0x0142 }
        r3 = r3[r8];	 Catch:{ all -> 0x0142 }
        if (r3 == 0) goto L_0x0061;
    L_0x0043:
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0142 }
        r3.<init>();	 Catch:{ all -> 0x0142 }
        r4 = "setRadioCapability: Phone[";
        r3 = r3.append(r4);	 Catch:{ all -> 0x0142 }
        r3 = r3.append(r8);	 Catch:{ all -> 0x0142 }
        r4 = "] is not idle. Rejecting request.";
        r3 = r3.append(r4);	 Catch:{ all -> 0x0142 }
        r3 = r3.toString();	 Catch:{ all -> 0x0142 }
        r12.loge(r3);	 Catch:{ all -> 0x0142 }
        monitor-exit(r2);	 Catch:{ all -> 0x0142 }
    L_0x0060:
        return r0;
    L_0x0061:
        r8 = r8 + 1;
        goto L_0x0014;
    L_0x0064:
        monitor-exit(r2);	 Catch:{ all -> 0x0142 }
        r12.clearTransaction();
        r0 = r12.mUniqueIdGenerator;
        r0 = r0.getAndIncrement();
        r12.mRadioCapabilitySessionId = r0;
        r0 = r12.mWakeLock;
        r0.acquire();
        r0 = r12.mSetRadioCapabilityRunnable;
        r2 = r12.mRadioCapabilitySessionId;
        r0.setTimeoutState(r2);
        r0 = r12.mHandler;
        r2 = r12.mSetRadioCapabilityRunnable;
        r4 = 45000; // 0xafc8 float:6.3058E-41 double:2.2233E-319;
        r0.postDelayed(r2, r4);
        r11 = r12.mSetRadioAccessFamilyStatus;
        monitor-enter(r11);
        r0 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0149 }
        r0.<init>();	 Catch:{ all -> 0x0149 }
        r2 = "setRadioCapability: new request session id=";
        r0 = r0.append(r2);	 Catch:{ all -> 0x0149 }
        r2 = r12.mRadioCapabilitySessionId;	 Catch:{ all -> 0x0149 }
        r0 = r0.append(r2);	 Catch:{ all -> 0x0149 }
        r0 = r0.toString();	 Catch:{ all -> 0x0149 }
        r12.logd(r0);	 Catch:{ all -> 0x0149 }
        r0 = r13.length;	 Catch:{ all -> 0x0149 }
        r12.mRadioAccessFamilyStatusCounter = r0;	 Catch:{ all -> 0x0149 }
        r8 = 0;
    L_0x00a5:
        r0 = r13.length;	 Catch:{ all -> 0x0149 }
        if (r8 >= r0) goto L_0x0145;
    L_0x00a8:
        r0 = r13[r8];	 Catch:{ all -> 0x0149 }
        r1 = r0.getPhoneId();	 Catch:{ all -> 0x0149 }
        r0 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0149 }
        r0.<init>();	 Catch:{ all -> 0x0149 }
        r2 = "setRadioCapability: phoneId=";
        r0 = r0.append(r2);	 Catch:{ all -> 0x0149 }
        r0 = r0.append(r1);	 Catch:{ all -> 0x0149 }
        r2 = " status=STARTING";
        r0 = r0.append(r2);	 Catch:{ all -> 0x0149 }
        r0 = r0.toString();	 Catch:{ all -> 0x0149 }
        r12.logd(r0);	 Catch:{ all -> 0x0149 }
        r0 = r12.mSetRadioAccessFamilyStatus;	 Catch:{ all -> 0x0149 }
        r2 = 1;
        r0[r1] = r2;	 Catch:{ all -> 0x0149 }
        r0 = r12.mOldRadioAccessFamily;	 Catch:{ all -> 0x0149 }
        r2 = r12.mProxyPhones;	 Catch:{ all -> 0x0149 }
        r2 = r2[r1];	 Catch:{ all -> 0x0149 }
        r2 = r2.getRadioAccessFamily();	 Catch:{ all -> 0x0149 }
        r0[r1] = r2;	 Catch:{ all -> 0x0149 }
        r0 = r13[r8];	 Catch:{ all -> 0x0149 }
        r9 = r0.getRadioAccessFamily();	 Catch:{ all -> 0x0149 }
        r0 = r12.mNewRadioAccessFamily;	 Catch:{ all -> 0x0149 }
        r0[r1] = r9;	 Catch:{ all -> 0x0149 }
        r0 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0149 }
        r0.<init>();	 Catch:{ all -> 0x0149 }
        r2 = "setRadioCapability: mOldRadioAccessFamily[";
        r0 = r0.append(r2);	 Catch:{ all -> 0x0149 }
        r0 = r0.append(r1);	 Catch:{ all -> 0x0149 }
        r2 = "]=";
        r0 = r0.append(r2);	 Catch:{ all -> 0x0149 }
        r2 = r12.mOldRadioAccessFamily;	 Catch:{ all -> 0x0149 }
        r2 = r2[r1];	 Catch:{ all -> 0x0149 }
        r0 = r0.append(r2);	 Catch:{ all -> 0x0149 }
        r0 = r0.toString();	 Catch:{ all -> 0x0149 }
        r12.logd(r0);	 Catch:{ all -> 0x0149 }
        r0 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0149 }
        r0.<init>();	 Catch:{ all -> 0x0149 }
        r2 = "setRadioCapability: mNewRadioAccessFamily[";
        r0 = r0.append(r2);	 Catch:{ all -> 0x0149 }
        r0 = r0.append(r1);	 Catch:{ all -> 0x0149 }
        r2 = "]=";
        r0 = r0.append(r2);	 Catch:{ all -> 0x0149 }
        r2 = r12.mNewRadioAccessFamily;	 Catch:{ all -> 0x0149 }
        r2 = r2[r1];	 Catch:{ all -> 0x0149 }
        r0 = r0.append(r2);	 Catch:{ all -> 0x0149 }
        r0 = r0.toString();	 Catch:{ all -> 0x0149 }
        r12.logd(r0);	 Catch:{ all -> 0x0149 }
        r2 = r12.mRadioCapabilitySessionId;	 Catch:{ all -> 0x0149 }
        r3 = 1;
        r0 = r12.mOldRadioAccessFamily;	 Catch:{ all -> 0x0149 }
        r4 = r0[r1];	 Catch:{ all -> 0x0149 }
        r0 = r12.mLogicalModemIds;	 Catch:{ all -> 0x0149 }
        r5 = r0[r1];	 Catch:{ all -> 0x0149 }
        r6 = 0;
        r7 = 2;
        r0 = r12;
        r0.sendRadioCapabilityRequest(r1, r2, r3, r4, r5, r6, r7);	 Catch:{ all -> 0x0149 }
        r8 = r8 + 1;
        goto L_0x00a5;
    L_0x0142:
        r0 = move-exception;
        monitor-exit(r2);	 Catch:{ all -> 0x0142 }
        throw r0;
    L_0x0145:
        monitor-exit(r11);	 Catch:{ all -> 0x0149 }
        r0 = r10;
        goto L_0x0060;
    L_0x0149:
        r0 = move-exception;
        monitor-exit(r11);	 Catch:{ all -> 0x0149 }
        throw r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.ProxyController.setRadioCapability(android.telephony.RadioAccessFamily[]):boolean");
    }

    private void onStartRadioCapabilityResponse(Message msg) {
        synchronized (this.mSetRadioAccessFamilyStatus) {
            RadioCapability rc = ((AsyncResult) msg.obj).result;
            if (rc == null || rc.getSession() != this.mRadioCapabilitySessionId) {
                logd("onStartRadioCapabilityResponse: Ignore session=" + this.mRadioCapabilitySessionId + " rc=" + rc);
                return;
            }
            this.mRadioAccessFamilyStatusCounter--;
            int id = rc.getPhoneId();
            if (((AsyncResult) msg.obj).exception != null) {
                logd("onStartRadioCapabilityResponse: Error response session=" + rc.getSession());
                logd("onStartRadioCapabilityResponse: phoneId=" + id + " status=FAIL");
                this.mSetRadioAccessFamilyStatus[id] = SET_RC_STATUS_FAIL;
            } else {
                logd("onStartRadioCapabilityResponse: phoneId=" + id + " status=STARTED");
                this.mSetRadioAccessFamilyStatus[id] = SET_RC_STATUS_STARTED;
            }
            if (this.mRadioAccessFamilyStatusCounter == 0) {
                resetRadioAccessFamilyStatusCounter();
                boolean success = checkAllRadioCapabilitySuccess();
                logd("onStartRadioCapabilityResponse: success=" + success);
                if (success) {
                    for (int i = SET_RC_STATUS_IDLE; i < this.mProxyPhones.length; i += SET_RC_STATUS_STARTING) {
                        sendRadioCapabilityRequest(i, this.mRadioCapabilitySessionId, SET_RC_STATUS_STARTED, this.mNewRadioAccessFamily[i], this.mLogicalModemIds[i], SET_RC_STATUS_IDLE, SET_RC_STATUS_APPLYING);
                        logd("onStartRadioCapabilityResponse: phoneId=" + i + " status=APPLYING");
                        this.mSetRadioAccessFamilyStatus[i] = SET_RC_STATUS_APPLYING;
                    }
                } else {
                    issueFinish(SET_RC_STATUS_STARTED, this.mRadioCapabilitySessionId);
                }
            }
        }
    }

    private void onApplyRadioCapabilityResponse(Message msg) {
        RadioCapability rc = ((AsyncResult) msg.obj).result;
        if (rc == null || rc.getSession() != this.mRadioCapabilitySessionId) {
            logd("onApplyRadioCapabilityResponse: Ignore session=" + this.mRadioCapabilitySessionId + " rc=" + rc);
            return;
        }
        logd("onApplyRadioCapabilityResponse: rc=" + rc);
        if (((AsyncResult) msg.obj).exception != null) {
            synchronized (this.mSetRadioAccessFamilyStatus) {
                logd("onApplyRadioCapabilityResponse: Error response session=" + rc.getSession());
                int id = rc.getPhoneId();
                logd("onApplyRadioCapabilityResponse: phoneId=" + id + " status=FAIL");
                this.mSetRadioAccessFamilyStatus[id] = SET_RC_STATUS_FAIL;
            }
            return;
        }
        logd("onApplyRadioCapabilityResponse: Valid start expecting notification rc=" + rc);
    }

    private void onNotificationRadioCapabilityChanged(Message msg) {
        RadioCapability rc = ((AsyncResult) msg.obj).result;
        if (rc == null || rc.getSession() != this.mRadioCapabilitySessionId) {
            logd("onNotificationRadioCapabilityChanged: Ignore session=" + this.mRadioCapabilitySessionId + " rc=" + rc);
            return;
        }
        synchronized (this.mSetRadioAccessFamilyStatus) {
            logd("onNotificationRadioCapabilityChanged: rc=" + rc);
            if (rc.getSession() != this.mRadioCapabilitySessionId) {
                logd("onNotificationRadioCapabilityChanged: Ignore session=" + this.mRadioCapabilitySessionId + " rc=" + rc);
                return;
            }
            int id = rc.getPhoneId();
            if (((AsyncResult) msg.obj).exception != null || rc.getStatus() == SET_RC_STATUS_STARTED) {
                logd("onNotificationRadioCapabilityChanged: phoneId=" + id + " status=FAIL");
                this.mSetRadioAccessFamilyStatus[id] = SET_RC_STATUS_FAIL;
            } else {
                logd("onNotificationRadioCapabilityChanged: phoneId=" + id + " status=SUCCESS");
                this.mSetRadioAccessFamilyStatus[id] = SET_RC_STATUS_SUCCESS;
            }
            this.mRadioAccessFamilyStatusCounter--;
            if (this.mRadioAccessFamilyStatusCounter == 0) {
                int status;
                logd("onNotificationRadioCapabilityChanged: removing callback from handler");
                this.mHandler.removeCallbacks(this.mSetRadioCapabilityRunnable);
                resetRadioAccessFamilyStatusCounter();
                boolean success = checkAllRadioCapabilitySuccess();
                logd("onNotificationRadioCapabilityChanged: APPLY URC success=" + success);
                if (success) {
                    status = SET_RC_STATUS_STARTING;
                } else {
                    status = SET_RC_STATUS_STARTED;
                }
                issueFinish(status, this.mRadioCapabilitySessionId);
            }
        }
    }

    void onFinishRadioCapabilityResponse(Message msg) {
        RadioCapability rc = ((AsyncResult) msg.obj).result;
        if (rc == null || rc.getSession() != this.mRadioCapabilitySessionId) {
            logd("onFinishRadioCapabilityResponse: Ignore session=" + this.mRadioCapabilitySessionId + " rc=" + rc);
            return;
        }
        synchronized (this.mSetRadioAccessFamilyStatus) {
            logd(" onFinishRadioCapabilityResponse mRadioAccessFamilyStatusCounter=" + this.mRadioAccessFamilyStatusCounter);
            this.mRadioAccessFamilyStatusCounter--;
            if (this.mRadioAccessFamilyStatusCounter == 0) {
                completeRadioCapabilityTransaction();
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void issueFinish(int r11, int r12) {
        /*
        r10 = this;
        r9 = 5;
        r8 = r10.mSetRadioAccessFamilyStatus;
        monitor-enter(r8);
        r1 = 0;
    L_0x0005:
        r0 = r10.mProxyPhones;	 Catch:{ all -> 0x009c }
        r0 = r0.length;	 Catch:{ all -> 0x009c }
        if (r1 >= r0) goto L_0x009f;
    L_0x000a:
        r0 = r10.mSetRadioAccessFamilyStatus;	 Catch:{ all -> 0x009c }
        r0 = r0[r1];	 Catch:{ all -> 0x009c }
        if (r0 == r9) goto L_0x0071;
    L_0x0010:
        r0 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009c }
        r0.<init>();	 Catch:{ all -> 0x009c }
        r2 = "issueFinish: phoneId=";
        r0 = r0.append(r2);	 Catch:{ all -> 0x009c }
        r0 = r0.append(r1);	 Catch:{ all -> 0x009c }
        r2 = " sessionId=";
        r0 = r0.append(r2);	 Catch:{ all -> 0x009c }
        r0 = r0.append(r12);	 Catch:{ all -> 0x009c }
        r2 = " status=";
        r0 = r0.append(r2);	 Catch:{ all -> 0x009c }
        r0 = r0.append(r11);	 Catch:{ all -> 0x009c }
        r0 = r0.toString();	 Catch:{ all -> 0x009c }
        r10.logd(r0);	 Catch:{ all -> 0x009c }
        r3 = 4;
        r0 = r10.mOldRadioAccessFamily;	 Catch:{ all -> 0x009c }
        r4 = r0[r1];	 Catch:{ all -> 0x009c }
        r0 = r10.mLogicalModemIds;	 Catch:{ all -> 0x009c }
        r5 = r0[r1];	 Catch:{ all -> 0x009c }
        r7 = 4;
        r0 = r10;
        r2 = r12;
        r6 = r11;
        r0.sendRadioCapabilityRequest(r1, r2, r3, r4, r5, r6, r7);	 Catch:{ all -> 0x009c }
        r0 = 2;
        if (r11 != r0) goto L_0x006e;
    L_0x004d:
        r0 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009c }
        r0.<init>();	 Catch:{ all -> 0x009c }
        r2 = "issueFinish: phoneId: ";
        r0 = r0.append(r2);	 Catch:{ all -> 0x009c }
        r0 = r0.append(r1);	 Catch:{ all -> 0x009c }
        r2 = " status: FAIL";
        r0 = r0.append(r2);	 Catch:{ all -> 0x009c }
        r0 = r0.toString();	 Catch:{ all -> 0x009c }
        r10.logd(r0);	 Catch:{ all -> 0x009c }
        r0 = r10.mSetRadioAccessFamilyStatus;	 Catch:{ all -> 0x009c }
        r2 = 5;
        r0[r1] = r2;	 Catch:{ all -> 0x009c }
    L_0x006e:
        r1 = r1 + 1;
        goto L_0x0005;
    L_0x0071:
        r0 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009c }
        r0.<init>();	 Catch:{ all -> 0x009c }
        r2 = "issueFinish: Ignore already FAIL, Phone";
        r0 = r0.append(r2);	 Catch:{ all -> 0x009c }
        r0 = r0.append(r1);	 Catch:{ all -> 0x009c }
        r2 = " sessionId=";
        r0 = r0.append(r2);	 Catch:{ all -> 0x009c }
        r0 = r0.append(r12);	 Catch:{ all -> 0x009c }
        r2 = " status=";
        r0 = r0.append(r2);	 Catch:{ all -> 0x009c }
        r0 = r0.append(r11);	 Catch:{ all -> 0x009c }
        r0 = r0.toString();	 Catch:{ all -> 0x009c }
        r10.logd(r0);	 Catch:{ all -> 0x009c }
        goto L_0x006e;
    L_0x009c:
        r0 = move-exception;
        monitor-exit(r8);	 Catch:{ all -> 0x009c }
        throw r0;
    L_0x009f:
        monitor-exit(r8);	 Catch:{ all -> 0x009c }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.ProxyController.issueFinish(int, int):void");
    }

    private void completeRadioCapabilityTransaction() {
        Intent intent;
        boolean success = checkAllRadioCapabilitySuccess();
        logd("onFinishRadioCapabilityResponse: success=" + success);
        if (success) {
            ArrayList<RadioAccessFamily> phoneRAFList = new ArrayList();
            for (int i = SET_RC_STATUS_IDLE; i < this.mProxyPhones.length; i += SET_RC_STATUS_STARTING) {
                int raf = this.mProxyPhones[i].getRadioAccessFamily();
                logd("radioAccessFamily[" + i + "]=" + raf);
                phoneRAFList.add(new RadioAccessFamily(i, raf));
            }
            intent = new Intent("android.intent.action.ACTION_SET_RADIO_CAPABILITY_DONE");
            intent.putParcelableArrayListExtra("rafs", phoneRAFList);
        } else {
            intent = new Intent("android.intent.action.ACTION_SET_RADIO_CAPABILITY_FAILED");
        }
        clearTransaction();
        this.mContext.sendBroadcast(intent);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void clearTransaction() {
        /*
        r4 = this;
        r1 = "clearTransaction";
        r4.logd(r1);
        r2 = r4.mSetRadioAccessFamilyStatus;
        monitor-enter(r2);
        r0 = 0;
    L_0x0009:
        r1 = r4.mProxyPhones;	 Catch:{ all -> 0x004b }
        r1 = r1.length;	 Catch:{ all -> 0x004b }
        if (r0 >= r1) goto L_0x003c;
    L_0x000e:
        r1 = new java.lang.StringBuilder;	 Catch:{ all -> 0x004b }
        r1.<init>();	 Catch:{ all -> 0x004b }
        r3 = "clearTransaction: phoneId=";
        r1 = r1.append(r3);	 Catch:{ all -> 0x004b }
        r1 = r1.append(r0);	 Catch:{ all -> 0x004b }
        r3 = " status=IDLE";
        r1 = r1.append(r3);	 Catch:{ all -> 0x004b }
        r1 = r1.toString();	 Catch:{ all -> 0x004b }
        r4.logd(r1);	 Catch:{ all -> 0x004b }
        r1 = r4.mSetRadioAccessFamilyStatus;	 Catch:{ all -> 0x004b }
        r3 = 0;
        r1[r0] = r3;	 Catch:{ all -> 0x004b }
        r1 = r4.mOldRadioAccessFamily;	 Catch:{ all -> 0x004b }
        r3 = 0;
        r1[r0] = r3;	 Catch:{ all -> 0x004b }
        r1 = r4.mNewRadioAccessFamily;	 Catch:{ all -> 0x004b }
        r3 = 0;
        r1[r0] = r3;	 Catch:{ all -> 0x004b }
        r0 = r0 + 1;
        goto L_0x0009;
    L_0x003c:
        r1 = r4.mWakeLock;	 Catch:{ all -> 0x004b }
        r1 = r1.isHeld();	 Catch:{ all -> 0x004b }
        if (r1 == 0) goto L_0x0049;
    L_0x0044:
        r1 = r4.mWakeLock;	 Catch:{ all -> 0x004b }
        r1.release();	 Catch:{ all -> 0x004b }
    L_0x0049:
        monitor-exit(r2);	 Catch:{ all -> 0x004b }
        return;
    L_0x004b:
        r1 = move-exception;
        monitor-exit(r2);	 Catch:{ all -> 0x004b }
        throw r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.ProxyController.clearTransaction():void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private boolean checkAllRadioCapabilitySuccess() {
        /*
        r4 = this;
        r2 = r4.mSetRadioAccessFamilyStatus;
        monitor-enter(r2);
        r0 = 0;
    L_0x0004:
        r1 = r4.mProxyPhones;	 Catch:{ all -> 0x0019 }
        r1 = r1.length;	 Catch:{ all -> 0x0019 }
        if (r0 >= r1) goto L_0x0016;
    L_0x0009:
        r1 = r4.mSetRadioAccessFamilyStatus;	 Catch:{ all -> 0x0019 }
        r1 = r1[r0];	 Catch:{ all -> 0x0019 }
        r3 = 5;
        if (r1 != r3) goto L_0x0013;
    L_0x0010:
        r1 = 0;
        monitor-exit(r2);	 Catch:{ all -> 0x0019 }
    L_0x0012:
        return r1;
    L_0x0013:
        r0 = r0 + 1;
        goto L_0x0004;
    L_0x0016:
        r1 = 1;
        monitor-exit(r2);	 Catch:{ all -> 0x0019 }
        goto L_0x0012;
    L_0x0019:
        r1 = move-exception;
        monitor-exit(r2);	 Catch:{ all -> 0x0019 }
        throw r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.ProxyController.checkAllRadioCapabilitySuccess():boolean");
    }

    private void resetRadioAccessFamilyStatusCounter() {
        this.mRadioAccessFamilyStatusCounter = this.mProxyPhones.length;
    }

    private void sendRadioCapabilityRequest(int phoneId, int sessionId, int rcPhase, int radioFamily, String logicalModemId, int status, int eventId) {
        this.mProxyPhones[phoneId].setRadioCapability(new RadioCapability(phoneId, sessionId, rcPhase, radioFamily, logicalModemId, status), this.mHandler.obtainMessage(eventId));
    }

    private void logd(String string) {
        Rlog.d(LOG_TAG, string);
    }

    private void loge(String string) {
        Rlog.e(LOG_TAG, string);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        try {
            this.mDctController.dump(fd, pw, args);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
