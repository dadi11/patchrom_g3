package com.android.server.am;

import android.app.ActivityManager;
import android.content.IIntentReceiver;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.ResolveInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.util.EventLog;
import android.util.Slog;
import java.util.ArrayList;

public final class BroadcastQueue {
    static final int BROADCAST_INTENT_MSG = 200;
    static final int BROADCAST_TIMEOUT_MSG = 201;
    static final boolean DEBUG_BROADCAST = false;
    static final boolean DEBUG_BROADCAST_LIGHT = false;
    static final boolean DEBUG_MU = false;
    static final int MAX_BROADCAST_HISTORY;
    static final int MAX_BROADCAST_SUMMARY_HISTORY;
    static final String TAG = "BroadcastQueue";
    static final String TAG_MU = "ActivityManagerServiceMU";
    static ArrayList<String> quickbootWhiteList;
    final BroadcastRecord[] mBroadcastHistory;
    final Intent[] mBroadcastSummaryHistory;
    boolean mBroadcastsScheduled;
    final boolean mDelayBehindServices;
    final BroadcastHandler mHandler;
    final ArrayList<BroadcastRecord> mOrderedBroadcasts;
    final ArrayList<BroadcastRecord> mParallelBroadcasts;
    BroadcastRecord mPendingBroadcast;
    int mPendingBroadcastRecvIndex;
    boolean mPendingBroadcastTimeoutMessage;
    final String mQueueName;
    final ActivityManagerService mService;
    final long mTimeoutPeriod;

    private final class AppNotResponding implements Runnable {
        private final String mAnnotation;
        private final ProcessRecord mApp;

        public AppNotResponding(ProcessRecord app, String annotation) {
            this.mApp = app;
            this.mAnnotation = annotation;
        }

        public void run() {
            BroadcastQueue.this.mService.appNotResponding(this.mApp, null, null, BroadcastQueue.DEBUG_MU, this.mAnnotation);
        }
    }

    private final class BroadcastHandler extends Handler {
        public BroadcastHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case BroadcastQueue.BROADCAST_INTENT_MSG /*200*/:
                    BroadcastQueue.this.processNextBroadcast(true);
                case BroadcastQueue.BROADCAST_TIMEOUT_MSG /*201*/:
                    synchronized (BroadcastQueue.this.mService) {
                        BroadcastQueue.this.broadcastTimeoutLocked(true);
                        break;
                    }
                default:
            }
        }
    }

    static {
        int i;
        MAX_BROADCAST_HISTORY = ActivityManager.isLowRamDeviceStatic() ? 10 : 50;
        if (ActivityManager.isLowRamDeviceStatic()) {
            i = 25;
        } else {
            i = 300;
        }
        MAX_BROADCAST_SUMMARY_HISTORY = i;
        quickbootWhiteList = null;
    }

    BroadcastQueue(ActivityManagerService service, Handler handler, String name, long timeoutPeriod, boolean allowDelayBehindServices) {
        this.mParallelBroadcasts = new ArrayList();
        this.mOrderedBroadcasts = new ArrayList();
        this.mBroadcastHistory = new BroadcastRecord[MAX_BROADCAST_HISTORY];
        this.mBroadcastSummaryHistory = new Intent[MAX_BROADCAST_SUMMARY_HISTORY];
        this.mBroadcastsScheduled = DEBUG_MU;
        this.mPendingBroadcast = null;
        this.mService = service;
        this.mHandler = new BroadcastHandler(handler.getLooper());
        this.mQueueName = name;
        this.mTimeoutPeriod = timeoutPeriod;
        this.mDelayBehindServices = allowDelayBehindServices;
    }

    public boolean isPendingBroadcastProcessLocked(int pid) {
        return (this.mPendingBroadcast == null || this.mPendingBroadcast.curApp.pid != pid) ? DEBUG_MU : true;
    }

    public void enqueueParallelBroadcastLocked(BroadcastRecord r) {
        this.mParallelBroadcasts.add(r);
    }

    public void enqueueOrderedBroadcastLocked(BroadcastRecord r) {
        this.mOrderedBroadcasts.add(r);
    }

    public final boolean replaceParallelBroadcastLocked(BroadcastRecord r) {
        for (int i = this.mParallelBroadcasts.size() - 1; i >= 0; i--) {
            if (r.intent.filterEquals(((BroadcastRecord) this.mParallelBroadcasts.get(i)).intent)) {
                this.mParallelBroadcasts.set(i, r);
                return true;
            }
        }
        return DEBUG_MU;
    }

    public final boolean replaceOrderedBroadcastLocked(BroadcastRecord r) {
        for (int i = this.mOrderedBroadcasts.size() - 1; i > 0; i--) {
            if (r.intent.filterEquals(((BroadcastRecord) this.mOrderedBroadcasts.get(i)).intent)) {
                this.mOrderedBroadcasts.set(i, r);
                return true;
            }
        }
        return DEBUG_MU;
    }

    private final void processCurBroadcastLocked(BroadcastRecord r, ProcessRecord app) throws RemoteException {
        if (app.thread == null) {
            throw new RemoteException();
        }
        r.receiver = app.thread.asBinder();
        r.curApp = app;
        app.curReceiver = r;
        app.forceProcessStateUpTo(8);
        this.mService.updateLruProcessLocked(app, DEBUG_MU, null);
        this.mService.updateOomAdjLocked();
        r.intent.setComponent(r.curComponent);
        try {
            this.mService.ensurePackageDexOpt(r.intent.getComponent().getPackageName());
            app.thread.scheduleReceiver(new Intent(r.intent), r.curReceiver, this.mService.compatibilityInfoForPackageLocked(r.curReceiver.applicationInfo), r.resultCode, r.resultData, r.resultExtras, r.ordered, r.userId, app.repProcState);
            if (!true) {
                r.receiver = null;
                r.curApp = null;
                app.curReceiver = null;
            }
        } catch (Throwable th) {
            if (!DEBUG_MU) {
                r.receiver = null;
                r.curApp = null;
                app.curReceiver = null;
            }
        }
    }

    public boolean sendPendingBroadcastsLocked(ProcessRecord app) {
        BroadcastRecord br = this.mPendingBroadcast;
        if (br == null || br.curApp.pid != app.pid) {
            return DEBUG_MU;
        }
        try {
            this.mPendingBroadcast = null;
            processCurBroadcastLocked(br, app);
            return true;
        } catch (Exception e) {
            Slog.w(TAG, "Exception in new application when starting receiver " + br.curComponent.flattenToShortString(), e);
            logBroadcastReceiverDiscardLocked(br);
            finishReceiverLocked(br, br.resultCode, br.resultData, br.resultExtras, br.resultAbort, DEBUG_MU);
            scheduleBroadcastsLocked();
            br.state = MAX_BROADCAST_SUMMARY_HISTORY;
            throw new RuntimeException(e.getMessage());
        }
    }

    public void skipPendingBroadcastLocked(int pid) {
        BroadcastRecord br = this.mPendingBroadcast;
        if (br != null && br.curApp.pid == pid) {
            br.state = MAX_BROADCAST_SUMMARY_HISTORY;
            br.nextReceiver = this.mPendingBroadcastRecvIndex;
            this.mPendingBroadcast = null;
            scheduleBroadcastsLocked();
        }
    }

    public void skipCurrentReceiverLocked(ProcessRecord app) {
        boolean reschedule = DEBUG_MU;
        BroadcastRecord r = app.curReceiver;
        if (r != null && r.queue == this) {
            logBroadcastReceiverDiscardLocked(r);
            finishReceiverLocked(r, r.resultCode, r.resultData, r.resultExtras, r.resultAbort, DEBUG_MU);
            reschedule = true;
        }
        r = this.mPendingBroadcast;
        if (r != null && r.curApp == app) {
            logBroadcastReceiverDiscardLocked(r);
            finishReceiverLocked(r, r.resultCode, r.resultData, r.resultExtras, r.resultAbort, DEBUG_MU);
            reschedule = true;
        }
        if (reschedule) {
            scheduleBroadcastsLocked();
        }
    }

    public void scheduleBroadcastsLocked() {
        if (!this.mBroadcastsScheduled) {
            this.mHandler.sendMessage(this.mHandler.obtainMessage(BROADCAST_INTENT_MSG, this));
            this.mBroadcastsScheduled = true;
        }
    }

    public BroadcastRecord getMatchingOrderedReceiver(IBinder receiver) {
        if (this.mOrderedBroadcasts.size() > 0) {
            BroadcastRecord r = (BroadcastRecord) this.mOrderedBroadcasts.get(MAX_BROADCAST_SUMMARY_HISTORY);
            if (r != null && r.receiver == receiver) {
                return r;
            }
        }
        return null;
    }

    public boolean finishReceiverLocked(BroadcastRecord r, int resultCode, String resultData, Bundle resultExtras, boolean resultAbort, boolean waitForServices) {
        int state = r.state;
        ActivityInfo receiver = r.curReceiver;
        r.state = MAX_BROADCAST_SUMMARY_HISTORY;
        if (state == 0) {
            Slog.w(TAG, "finishReceiver [" + this.mQueueName + "] called but state is IDLE");
        }
        r.receiver = null;
        r.intent.setComponent(null);
        if (r.curApp != null && r.curApp.curReceiver == r) {
            r.curApp.curReceiver = null;
        }
        if (r.curFilter != null) {
            r.curFilter.receiverList.curBroadcast = null;
        }
        r.curFilter = null;
        r.curReceiver = null;
        r.curApp = null;
        this.mPendingBroadcast = null;
        r.resultCode = resultCode;
        r.resultData = resultData;
        r.resultExtras = resultExtras;
        if (resultAbort && (r.intent.getFlags() & 134217728) == 0) {
            r.resultAbort = resultAbort;
        } else {
            r.resultAbort = DEBUG_MU;
        }
        if (waitForServices && r.curComponent != null && r.queue.mDelayBehindServices && r.queue.mOrderedBroadcasts.size() > 0 && r.queue.mOrderedBroadcasts.get(MAX_BROADCAST_SUMMARY_HISTORY) == r) {
            ActivityInfo nextReceiver;
            if (r.nextReceiver < r.receivers.size()) {
                Object obj = r.receivers.get(r.nextReceiver);
                nextReceiver = obj instanceof ActivityInfo ? (ActivityInfo) obj : null;
            } else {
                nextReceiver = null;
            }
            if ((receiver == null || nextReceiver == null || receiver.applicationInfo.uid != nextReceiver.applicationInfo.uid || !receiver.processName.equals(nextReceiver.processName)) && this.mService.mServices.hasBackgroundServices(r.userId)) {
                Slog.i("ActivityManager", "Delay finish: " + r.curComponent.flattenToShortString());
                r.state = 4;
                return DEBUG_MU;
            }
        }
        r.curComponent = null;
        return (state == 1 || state == 3) ? true : DEBUG_MU;
    }

    public void backgroundServicesFinishedLocked(int userId) {
        if (this.mOrderedBroadcasts.size() > 0) {
            BroadcastRecord br = (BroadcastRecord) this.mOrderedBroadcasts.get(MAX_BROADCAST_SUMMARY_HISTORY);
            if (br.userId == userId && br.state == 4) {
                Slog.i("ActivityManager", "Resuming delayed broadcast");
                br.curComponent = null;
                br.state = MAX_BROADCAST_SUMMARY_HISTORY;
                processNextBroadcast(DEBUG_MU);
            }
        }
    }

    private static void performReceiveLocked(ProcessRecord app, IIntentReceiver receiver, Intent intent, int resultCode, String data, Bundle extras, boolean ordered, boolean sticky, int sendingUser) throws RemoteException {
        if (app == null) {
            receiver.performReceive(intent, resultCode, data, extras, ordered, sticky, sendingUser);
        } else if (app.thread != null) {
            app.thread.scheduleRegisteredReceiver(receiver, intent, resultCode, data, extras, ordered, sticky, sendingUser, app.repProcState);
        } else {
            throw new RemoteException("app.thread must not be null");
        }
    }

    private final void deliverToRegisteredReceiverLocked(BroadcastRecord r, BroadcastFilter filter, boolean ordered) {
        boolean skip = DEBUG_MU;
        if (!(filter.requiredPermission == null || this.mService.checkComponentPermission(filter.requiredPermission, r.callingPid, r.callingUid, -1, true) == 0)) {
            Slog.w(TAG, "Permission Denial: broadcasting " + r.intent.toString() + " from " + r.callerPackage + " (pid=" + r.callingPid + ", uid=" + r.callingUid + ")" + " requires " + filter.requiredPermission + " due to registered receiver " + filter);
            skip = true;
        }
        if (!(skip || r.requiredPermission == null || this.mService.checkComponentPermission(r.requiredPermission, filter.receiverList.pid, filter.receiverList.uid, -1, true) == 0)) {
            Slog.w(TAG, "Permission Denial: receiving " + r.intent.toString() + " to " + filter.receiverList.app + " (pid=" + filter.receiverList.pid + ", uid=" + filter.receiverList.uid + ")" + " requires " + r.requiredPermission + " due to sender " + r.callerPackage + " (uid " + r.callingUid + ")");
            skip = true;
        }
        if (!(r.appOp == -1 || this.mService.mAppOpsService.noteOperation(r.appOp, filter.receiverList.uid, filter.packageName) == 0)) {
            skip = true;
        }
        if (!skip) {
            skip = !this.mService.mIntentFirewall.checkBroadcast(r.intent, r.callingUid, r.callingPid, r.resolvedType, filter.receiverList.uid) ? true : DEBUG_MU;
        }
        if (filter.receiverList.app == null || filter.receiverList.app.crashing) {
            Slog.w(TAG, "Skipping deliver [" + this.mQueueName + "] " + r + " to " + filter.receiverList + ": process crashing");
            skip = true;
        }
        if (!skip) {
            if (ordered) {
                r.receiver = filter.receiverList.receiver.asBinder();
                r.curFilter = filter;
                filter.receiverList.curBroadcast = r;
                r.state = 2;
                if (filter.receiverList.app != null) {
                    r.curApp = filter.receiverList.app;
                    filter.receiverList.app.curReceiver = r;
                    this.mService.updateOomAdjLocked(r.curApp);
                }
            }
            try {
                performReceiveLocked(filter.receiverList.app, filter.receiverList.receiver, new Intent(r.intent), r.resultCode, r.resultData, r.resultExtras, r.ordered, r.initialSticky, r.userId);
                if (ordered) {
                    r.state = 3;
                }
            } catch (RemoteException e) {
                Slog.w(TAG, "Failure sending broadcast " + r.intent, e);
                if (ordered) {
                    r.receiver = null;
                    r.curFilter = null;
                    filter.receiverList.curBroadcast = null;
                    if (filter.receiverList.app != null) {
                        filter.receiverList.app.curReceiver = null;
                    }
                }
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    final void processNextBroadcast(boolean r42) {
        /*
        r41 = this;
        r0 = r41;
        r0 = r0.mService;
        r40 = r0;
        monitor-enter(r40);
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r4.updateCpuStats();	 Catch:{ all -> 0x0069 }
        if (r42 == 0) goto L_0x0015;
    L_0x0010:
        r4 = 0;
        r0 = r41;
        r0.mBroadcastsScheduled = r4;	 Catch:{ all -> 0x0069 }
    L_0x0015:
        r0 = r41;
        r4 = r0.mParallelBroadcasts;	 Catch:{ all -> 0x0069 }
        r4 = r4.size();	 Catch:{ all -> 0x0069 }
        if (r4 <= 0) goto L_0x006c;
    L_0x001f:
        r0 = r41;
        r4 = r0.mParallelBroadcasts;	 Catch:{ all -> 0x0069 }
        r6 = 0;
        r33 = r4.remove(r6);	 Catch:{ all -> 0x0069 }
        r33 = (com.android.server.am.BroadcastRecord) r33;	 Catch:{ all -> 0x0069 }
        r6 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r0.dispatchTime = r6;	 Catch:{ all -> 0x0069 }
        r6 = java.lang.System.currentTimeMillis();	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r0.dispatchClockTime = r6;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r4 = r0.receivers;	 Catch:{ all -> 0x0069 }
        r14 = r4.size();	 Catch:{ all -> 0x0069 }
        r20 = 0;
    L_0x0044:
        r0 = r20;
        if (r0 >= r14) goto L_0x0061;
    L_0x0048:
        r0 = r33;
        r4 = r0.receivers;	 Catch:{ all -> 0x0069 }
        r0 = r20;
        r37 = r4.get(r0);	 Catch:{ all -> 0x0069 }
        r37 = (com.android.server.am.BroadcastFilter) r37;	 Catch:{ all -> 0x0069 }
        r4 = 0;
        r0 = r41;
        r1 = r33;
        r2 = r37;
        r0.deliverToRegisteredReceiverLocked(r1, r2, r4);	 Catch:{ all -> 0x0069 }
        r20 = r20 + 1;
        goto L_0x0044;
    L_0x0061:
        r0 = r41;
        r1 = r33;
        r0.addBroadcastToHistoryLocked(r1);	 Catch:{ all -> 0x0069 }
        goto L_0x0015;
    L_0x0069:
        r4 = move-exception;
        monitor-exit(r40);	 Catch:{ all -> 0x0069 }
        throw r4;
    L_0x006c:
        r0 = r41;
        r4 = r0.mPendingBroadcast;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x00ea;
    L_0x0072:
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r6 = r4.mPidsSelfLocked;	 Catch:{ all -> 0x0069 }
        monitor-enter(r6);	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x009f }
        r4 = r4.mPidsSelfLocked;	 Catch:{ all -> 0x009f }
        r0 = r41;
        r7 = r0.mPendingBroadcast;	 Catch:{ all -> 0x009f }
        r7 = r7.curApp;	 Catch:{ all -> 0x009f }
        r7 = r7.pid;	 Catch:{ all -> 0x009f }
        r32 = r4.get(r7);	 Catch:{ all -> 0x009f }
        r32 = (com.android.server.am.ProcessRecord) r32;	 Catch:{ all -> 0x009f }
        if (r32 == 0) goto L_0x0095;
    L_0x008f:
        r0 = r32;
        r4 = r0.crashing;	 Catch:{ all -> 0x009f }
        if (r4 == 0) goto L_0x009c;
    L_0x0095:
        r23 = 1;
    L_0x0097:
        monitor-exit(r6);	 Catch:{ all -> 0x009f }
        if (r23 != 0) goto L_0x00a2;
    L_0x009a:
        monitor-exit(r40);	 Catch:{ all -> 0x0069 }
    L_0x009b:
        return;
    L_0x009c:
        r23 = 0;
        goto L_0x0097;
    L_0x009f:
        r4 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x009f }
        throw r4;	 Catch:{ all -> 0x0069 }
    L_0x00a2:
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "pending app  [";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r7 = r0.mQueueName;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = "]";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r7 = r0.mPendingBroadcast;	 Catch:{ all -> 0x0069 }
        r7 = r7.curApp;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " died before responding to broadcast";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r4 = r0.mPendingBroadcast;	 Catch:{ all -> 0x0069 }
        r6 = 0;
        r4.state = r6;	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r4 = r0.mPendingBroadcast;	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r6 = r0.mPendingBroadcastRecvIndex;	 Catch:{ all -> 0x0069 }
        r4.nextReceiver = r6;	 Catch:{ all -> 0x0069 }
        r4 = 0;
        r0 = r41;
        r0.mPendingBroadcast = r4;	 Catch:{ all -> 0x0069 }
    L_0x00ea:
        r25 = 0;
    L_0x00ec:
        r0 = r41;
        r4 = r0.mOrderedBroadcasts;	 Catch:{ all -> 0x0069 }
        r4 = r4.size();	 Catch:{ all -> 0x0069 }
        if (r4 != 0) goto L_0x0108;
    L_0x00f6:
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r4.scheduleAppGcsLocked();	 Catch:{ all -> 0x0069 }
        if (r25 == 0) goto L_0x0106;
    L_0x00ff:
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r4.updateOomAdjLocked();	 Catch:{ all -> 0x0069 }
    L_0x0106:
        monitor-exit(r40);	 Catch:{ all -> 0x0069 }
        goto L_0x009b;
    L_0x0108:
        r0 = r41;
        r4 = r0.mOrderedBroadcasts;	 Catch:{ all -> 0x0069 }
        r6 = 0;
        r33 = r4.get(r6);	 Catch:{ all -> 0x0069 }
        r33 = (com.android.server.am.BroadcastRecord) r33;	 Catch:{ all -> 0x0069 }
        r19 = 0;
        r0 = r33;
        r4 = r0.receivers;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x01e5;
    L_0x011b:
        r0 = r33;
        r4 = r0.receivers;	 Catch:{ all -> 0x0069 }
        r30 = r4.size();	 Catch:{ all -> 0x0069 }
    L_0x0123:
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r4 = r4.mProcessesReady;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x01dc;
    L_0x012b:
        r0 = r33;
        r6 = r0.dispatchTime;	 Catch:{ all -> 0x0069 }
        r8 = 0;
        r4 = (r6 > r8 ? 1 : (r6 == r8 ? 0 : -1));
        if (r4 <= 0) goto L_0x01dc;
    L_0x0135:
        r28 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0069 }
        if (r30 <= 0) goto L_0x01dc;
    L_0x013b:
        r0 = r33;
        r6 = r0.dispatchTime;	 Catch:{ all -> 0x0069 }
        r8 = 2;
        r0 = r41;
        r10 = r0.mTimeoutPeriod;	 Catch:{ all -> 0x0069 }
        r8 = r8 * r10;
        r0 = r30;
        r10 = (long) r0;	 Catch:{ all -> 0x0069 }
        r8 = r8 * r10;
        r6 = r6 + r8;
        r4 = (r28 > r6 ? 1 : (r28 == r6 ? 0 : -1));
        if (r4 <= 0) goto L_0x01dc;
    L_0x014f:
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Hung broadcast [";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r7 = r0.mQueueName;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = "] discarded after timeout failure:";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " now=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r28;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0069 }
        r7 = " dispatchTime=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r8 = r0.dispatchTime;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0069 }
        r7 = " startTime=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r8 = r0.receiverTime;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0069 }
        r7 = " intent=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.intent;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " numReceivers=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r30;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0069 }
        r7 = " nextReceiver=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.nextReceiver;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " state=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.state;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0069 }
        r4 = 0;
        r0 = r41;
        r0.broadcastTimeoutLocked(r4);	 Catch:{ all -> 0x0069 }
        r19 = 1;
        r4 = 0;
        r0 = r33;
        r0.state = r4;	 Catch:{ all -> 0x0069 }
    L_0x01dc:
        r0 = r33;
        r4 = r0.state;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x01e9;
    L_0x01e2:
        monitor-exit(r40);	 Catch:{ all -> 0x0069 }
        goto L_0x009b;
    L_0x01e5:
        r30 = 0;
        goto L_0x0123;
    L_0x01e9:
        r0 = r33;
        r4 = r0.receivers;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x01ff;
    L_0x01ef:
        r0 = r33;
        r4 = r0.nextReceiver;	 Catch:{ all -> 0x0069 }
        r0 = r30;
        if (r4 >= r0) goto L_0x01ff;
    L_0x01f7:
        r0 = r33;
        r4 = r0.resultAbort;	 Catch:{ all -> 0x0069 }
        if (r4 != 0) goto L_0x01ff;
    L_0x01fd:
        if (r19 == 0) goto L_0x0246;
    L_0x01ff:
        r0 = r33;
        r4 = r0.resultTo;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x0230;
    L_0x0205:
        r0 = r33;
        r4 = r0.callerApp;	 Catch:{ RemoteException -> 0x02bf }
        r0 = r33;
        r5 = r0.resultTo;	 Catch:{ RemoteException -> 0x02bf }
        r6 = new android.content.Intent;	 Catch:{ RemoteException -> 0x02bf }
        r0 = r33;
        r7 = r0.intent;	 Catch:{ RemoteException -> 0x02bf }
        r6.<init>(r7);	 Catch:{ RemoteException -> 0x02bf }
        r0 = r33;
        r7 = r0.resultCode;	 Catch:{ RemoteException -> 0x02bf }
        r0 = r33;
        r8 = r0.resultData;	 Catch:{ RemoteException -> 0x02bf }
        r0 = r33;
        r9 = r0.resultExtras;	 Catch:{ RemoteException -> 0x02bf }
        r10 = 0;
        r11 = 0;
        r0 = r33;
        r12 = r0.userId;	 Catch:{ RemoteException -> 0x02bf }
        performReceiveLocked(r4, r5, r6, r7, r8, r9, r10, r11, r12);	 Catch:{ RemoteException -> 0x02bf }
        r4 = 0;
        r0 = r33;
        r0.resultTo = r4;	 Catch:{ RemoteException -> 0x02bf }
    L_0x0230:
        r41.cancelBroadcastTimeoutLocked();	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r1 = r33;
        r0.addBroadcastToHistoryLocked(r1);	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r4 = r0.mOrderedBroadcasts;	 Catch:{ all -> 0x0069 }
        r6 = 0;
        r4.remove(r6);	 Catch:{ all -> 0x0069 }
        r33 = 0;
        r25 = 1;
    L_0x0246:
        if (r33 == 0) goto L_0x00ec;
    L_0x0248:
        r0 = r33;
        r0 = r0.nextReceiver;	 Catch:{ all -> 0x0069 }
        r34 = r0;
        r4 = r34 + 1;
        r0 = r33;
        r0.nextReceiver = r4;	 Catch:{ all -> 0x0069 }
        r6 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r0.receiverTime = r6;	 Catch:{ all -> 0x0069 }
        if (r34 != 0) goto L_0x026e;
    L_0x025e:
        r0 = r33;
        r6 = r0.receiverTime;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r0.dispatchTime = r6;	 Catch:{ all -> 0x0069 }
        r6 = java.lang.System.currentTimeMillis();	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r0.dispatchClockTime = r6;	 Catch:{ all -> 0x0069 }
    L_0x026e:
        r0 = r41;
        r4 = r0.mPendingBroadcastTimeoutMessage;	 Catch:{ all -> 0x0069 }
        if (r4 != 0) goto L_0x0285;
    L_0x0274:
        r0 = r33;
        r6 = r0.receiverTime;	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r8 = r0.mTimeoutPeriod;	 Catch:{ all -> 0x0069 }
        r38 = r6 + r8;
        r0 = r41;
        r1 = r38;
        r0.setBroadcastTimeoutLocked(r1);	 Catch:{ all -> 0x0069 }
    L_0x0285:
        r0 = r33;
        r4 = r0.receivers;	 Catch:{ all -> 0x0069 }
        r0 = r34;
        r27 = r4.get(r0);	 Catch:{ all -> 0x0069 }
        r0 = r27;
        r4 = r0 instanceof com.android.server.am.BroadcastFilter;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x02f3;
    L_0x0295:
        r0 = r27;
        r0 = (com.android.server.am.BroadcastFilter) r0;	 Catch:{ all -> 0x0069 }
        r18 = r0;
        r0 = r33;
        r4 = r0.ordered;	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r1 = r33;
        r2 = r18;
        r0.deliverToRegisteredReceiverLocked(r1, r2, r4);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r4 = r0.receiver;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x02b4;
    L_0x02ae:
        r0 = r33;
        r4 = r0.ordered;	 Catch:{ all -> 0x0069 }
        if (r4 != 0) goto L_0x02bc;
    L_0x02b4:
        r4 = 0;
        r0 = r33;
        r0.state = r4;	 Catch:{ all -> 0x0069 }
        r41.scheduleBroadcastsLocked();	 Catch:{ all -> 0x0069 }
    L_0x02bc:
        monitor-exit(r40);	 Catch:{ all -> 0x0069 }
        goto L_0x009b;
    L_0x02bf:
        r17 = move-exception;
        r4 = 0;
        r0 = r33;
        r0.resultTo = r4;	 Catch:{ all -> 0x0069 }
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Failure [";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r7 = r0.mQueueName;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = "] sending broadcast result of ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.intent;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        r0 = r17;
        android.util.Slog.w(r4, r6, r0);	 Catch:{ all -> 0x0069 }
        goto L_0x0230;
    L_0x02f3:
        r0 = r27;
        r0 = (android.content.pm.ResolveInfo) r0;	 Catch:{ all -> 0x0069 }
        r21 = r0;
        r16 = new android.content.ComponentName;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r4 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r4 = r4.applicationInfo;	 Catch:{ all -> 0x0069 }
        r4 = r4.packageName;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r6 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r6 = r6.name;	 Catch:{ all -> 0x0069 }
        r0 = r16;
        r0.<init>(r4, r6);	 Catch:{ all -> 0x0069 }
        r36 = 0;
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r6 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r5 = r6.permission;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r6 = r0.callingPid;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.callingUid;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r8 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r8 = r8.applicationInfo;	 Catch:{ all -> 0x0069 }
        r8 = r8.uid;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r9 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r9 = r9.exported;	 Catch:{ all -> 0x0069 }
        r31 = r4.checkComponentPermission(r5, r6, r7, r8, r9);	 Catch:{ all -> 0x0069 }
        if (r31 == 0) goto L_0x03b0;
    L_0x0336:
        r0 = r21;
        r4 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r4 = r4.exported;	 Catch:{ all -> 0x0069 }
        if (r4 != 0) goto L_0x056f;
    L_0x033e:
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Permission Denial: broadcasting ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.intent;	 Catch:{ all -> 0x0069 }
        r7 = r7.toString();	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " from ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.callerPackage;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " (pid=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.callingPid;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = ", uid=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.callingUid;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = ")";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " is not exported from uid ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r7 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r7 = r7.applicationInfo;	 Catch:{ all -> 0x0069 }
        r7 = r7.uid;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " due to receiver ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = r16.flattenToShortString();	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0069 }
    L_0x03ae:
        r36 = 1;
    L_0x03b0:
        r0 = r21;
        r4 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r4 = r4.applicationInfo;	 Catch:{ all -> 0x0069 }
        r4 = r4.uid;	 Catch:{ all -> 0x0069 }
        r6 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        if (r4 == r6) goto L_0x0434;
    L_0x03bc:
        r0 = r33;
        r4 = r0.requiredPermission;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x0434;
    L_0x03c2:
        r4 = android.app.AppGlobals.getPackageManager();	 Catch:{ RemoteException -> 0x05df }
        r0 = r33;
        r6 = r0.requiredPermission;	 Catch:{ RemoteException -> 0x05df }
        r0 = r21;
        r7 = r0.activityInfo;	 Catch:{ RemoteException -> 0x05df }
        r7 = r7.applicationInfo;	 Catch:{ RemoteException -> 0x05df }
        r7 = r7.packageName;	 Catch:{ RemoteException -> 0x05df }
        r31 = r4.checkPermission(r6, r7);	 Catch:{ RemoteException -> 0x05df }
    L_0x03d6:
        if (r31 == 0) goto L_0x0434;
    L_0x03d8:
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Permission Denial: receiving ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.intent;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " to ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = r16.flattenToShortString();	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " requires ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.requiredPermission;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " due to sender ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.callerPackage;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " (uid ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.callingUid;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = ")";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0069 }
        r36 = 1;
    L_0x0434:
        r0 = r33;
        r4 = r0.appOp;	 Catch:{ all -> 0x0069 }
        r6 = -1;
        if (r4 == r6) goto L_0x045b;
    L_0x043b:
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r4 = r4.mAppOpsService;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r6 = r0.appOp;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r7 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r7 = r7.applicationInfo;	 Catch:{ all -> 0x0069 }
        r7 = r7.uid;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r8 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r8 = r8.packageName;	 Catch:{ all -> 0x0069 }
        r26 = r4.noteOperation(r6, r7, r8);	 Catch:{ all -> 0x0069 }
        if (r26 == 0) goto L_0x045b;
    L_0x0459:
        r36 = 1;
    L_0x045b:
        if (r36 != 0) goto L_0x0483;
    L_0x045d:
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r4 = r4.mIntentFirewall;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r5 = r0.intent;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r6 = r0.callingUid;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.callingPid;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r8 = r0.resolvedType;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r9 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r9 = r9.applicationInfo;	 Catch:{ all -> 0x0069 }
        r9 = r9.uid;	 Catch:{ all -> 0x0069 }
        r4 = r4.checkBroadcast(r5, r6, r7, r8, r9);	 Catch:{ all -> 0x0069 }
        if (r4 != 0) goto L_0x05e4;
    L_0x0481:
        r36 = 1;
    L_0x0483:
        r24 = 0;
        r0 = r41;
        r4 = r0.mService;	 Catch:{ SecurityException -> 0x05e8 }
        r0 = r21;
        r6 = r0.activityInfo;	 Catch:{ SecurityException -> 0x05e8 }
        r6 = r6.processName;	 Catch:{ SecurityException -> 0x05e8 }
        r0 = r21;
        r7 = r0.activityInfo;	 Catch:{ SecurityException -> 0x05e8 }
        r7 = r7.applicationInfo;	 Catch:{ SecurityException -> 0x05e8 }
        r0 = r21;
        r8 = r0.activityInfo;	 Catch:{ SecurityException -> 0x05e8 }
        r8 = r8.name;	 Catch:{ SecurityException -> 0x05e8 }
        r0 = r21;
        r9 = r0.activityInfo;	 Catch:{ SecurityException -> 0x05e8 }
        r9 = r9.flags;	 Catch:{ SecurityException -> 0x05e8 }
        r24 = r4.isSingleton(r6, r7, r8, r9);	 Catch:{ SecurityException -> 0x05e8 }
    L_0x04a5:
        r0 = r21;
        r4 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r4 = r4.flags;	 Catch:{ all -> 0x0069 }
        r6 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r4 = r4 & r6;
        if (r4 == 0) goto L_0x04ea;
    L_0x04b0:
        r4 = "android.permission.INTERACT_ACROSS_USERS";
        r0 = r21;
        r6 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r6 = r6.applicationInfo;	 Catch:{ all -> 0x0069 }
        r6 = r6.uid;	 Catch:{ all -> 0x0069 }
        r4 = android.app.ActivityManager.checkUidPermission(r4, r6);	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x04ea;
    L_0x04c0:
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Permission Denial: Receiver ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = r16.flattenToShortString();	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " requests FLAG_SINGLE_USER, but app does not hold ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = "android.permission.INTERACT_ACROSS_USERS";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0069 }
        r36 = 1;
    L_0x04ea:
        r0 = r33;
        r4 = r0.curApp;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x0536;
    L_0x04f0:
        r0 = r33;
        r4 = r0.curApp;	 Catch:{ all -> 0x0069 }
        r4 = r4.crashing;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x0536;
    L_0x04f8:
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Skipping deliver ordered [";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r7 = r0.mQueueName;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = "] ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0069 }
        r7 = " to ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.curApp;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = ": process crashing";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0069 }
        r36 = 1;
    L_0x0536:
        if (r36 != 0) goto L_0x0558;
    L_0x0538:
        r22 = 0;
        r4 = android.app.AppGlobals.getPackageManager();	 Catch:{ Exception -> 0x05f6 }
        r0 = r21;
        r6 = r0.activityInfo;	 Catch:{ Exception -> 0x05f6 }
        r6 = r6.packageName;	 Catch:{ Exception -> 0x05f6 }
        r0 = r21;
        r7 = r0.activityInfo;	 Catch:{ Exception -> 0x05f6 }
        r7 = r7.applicationInfo;	 Catch:{ Exception -> 0x05f6 }
        r7 = r7.uid;	 Catch:{ Exception -> 0x05f6 }
        r7 = android.os.UserHandle.getUserId(r7);	 Catch:{ Exception -> 0x05f6 }
        r22 = r4.isPackageAvailable(r6, r7);	 Catch:{ Exception -> 0x05f6 }
    L_0x0554:
        if (r22 != 0) goto L_0x0558;
    L_0x0556:
        r36 = 1;
    L_0x0558:
        if (r36 == 0) goto L_0x0619;
    L_0x055a:
        r4 = 0;
        r0 = r33;
        r0.receiver = r4;	 Catch:{ all -> 0x0069 }
        r4 = 0;
        r0 = r33;
        r0.curFilter = r4;	 Catch:{ all -> 0x0069 }
        r4 = 0;
        r0 = r33;
        r0.state = r4;	 Catch:{ all -> 0x0069 }
        r41.scheduleBroadcastsLocked();	 Catch:{ all -> 0x0069 }
        monitor-exit(r40);	 Catch:{ all -> 0x0069 }
        goto L_0x009b;
    L_0x056f:
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Permission Denial: broadcasting ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.intent;	 Catch:{ all -> 0x0069 }
        r7 = r7.toString();	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " from ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.callerPackage;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " (pid=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.callingPid;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = ", uid=";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.callingUid;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = ")";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " requires ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r7 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r7 = r7.permission;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " due to receiver ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = r16.flattenToShortString();	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0069 }
        goto L_0x03ae;
    L_0x05df:
        r17 = move-exception;
        r31 = -1;
        goto L_0x03d6;
    L_0x05e4:
        r36 = 0;
        goto L_0x0483;
    L_0x05e8:
        r17 = move-exception;
        r4 = "BroadcastQueue";
        r6 = r17.getMessage();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0069 }
        r36 = 1;
        goto L_0x04a5;
    L_0x05f6:
        r17 = move-exception;
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Exception getting recipient info for ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r7 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r7 = r7.packageName;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        r0 = r17;
        android.util.Slog.w(r4, r6, r0);	 Catch:{ all -> 0x0069 }
        goto L_0x0554;
    L_0x0619:
        r4 = 1;
        r0 = r33;
        r0.state = r4;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r4 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r5 = r4.processName;	 Catch:{ all -> 0x0069 }
        r0 = r16;
        r1 = r33;
        r1.curComponent = r0;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r4 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r4 = r4.applicationInfo;	 Catch:{ all -> 0x0069 }
        r0 = r4.uid;	 Catch:{ all -> 0x0069 }
        r35 = r0;
        r0 = r33;
        r4 = r0.callingUid;	 Catch:{ all -> 0x0069 }
        r6 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        if (r4 == r6) goto L_0x065f;
    L_0x063c:
        if (r24 == 0) goto L_0x065f;
    L_0x063e:
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r6 = r0.callingUid;	 Catch:{ all -> 0x0069 }
        r0 = r35;
        r4 = r4.isValidSingletonCall(r6, r0);	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x065f;
    L_0x064e:
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r6 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r7 = 0;
        r4 = r4.getActivityInfoForUser(r6, r7);	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r0.activityInfo = r4;	 Catch:{ all -> 0x0069 }
    L_0x065f:
        r0 = r21;
        r4 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r0.curReceiver = r4;	 Catch:{ all -> 0x0069 }
        r4 = android.app.AppGlobals.getPackageManager();	 Catch:{ RemoteException -> 0x0837, IllegalArgumentException -> 0x06b7 }
        r0 = r33;
        r6 = r0.curComponent;	 Catch:{ RemoteException -> 0x0837, IllegalArgumentException -> 0x06b7 }
        r6 = r6.getPackageName();	 Catch:{ RemoteException -> 0x0837, IllegalArgumentException -> 0x06b7 }
        r7 = 0;
        r0 = r33;
        r8 = r0.callingUid;	 Catch:{ RemoteException -> 0x0837, IllegalArgumentException -> 0x06b7 }
        r8 = android.os.UserHandle.getUserId(r8);	 Catch:{ RemoteException -> 0x0837, IllegalArgumentException -> 0x06b7 }
        r4.setPackageStoppedState(r6, r7, r8);	 Catch:{ RemoteException -> 0x0837, IllegalArgumentException -> 0x06b7 }
    L_0x067f:
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r6 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r6 = r6.applicationInfo;	 Catch:{ all -> 0x0069 }
        r6 = r6.uid;	 Catch:{ all -> 0x0069 }
        r7 = 0;
        r15 = r4.getProcessRecordLocked(r5, r6, r7);	 Catch:{ all -> 0x0069 }
        if (r15 == 0) goto L_0x0704;
    L_0x0692:
        r4 = r15.thread;	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x0704;
    L_0x0696:
        r0 = r21;
        r4 = r0.activityInfo;	 Catch:{ RemoteException -> 0x06e5, RuntimeException -> 0x07ce }
        r4 = r4.packageName;	 Catch:{ RemoteException -> 0x06e5, RuntimeException -> 0x07ce }
        r0 = r21;
        r6 = r0.activityInfo;	 Catch:{ RemoteException -> 0x06e5, RuntimeException -> 0x07ce }
        r6 = r6.applicationInfo;	 Catch:{ RemoteException -> 0x06e5, RuntimeException -> 0x07ce }
        r6 = r6.versionCode;	 Catch:{ RemoteException -> 0x06e5, RuntimeException -> 0x07ce }
        r0 = r41;
        r7 = r0.mService;	 Catch:{ RemoteException -> 0x06e5, RuntimeException -> 0x07ce }
        r7 = r7.mProcessStats;	 Catch:{ RemoteException -> 0x06e5, RuntimeException -> 0x07ce }
        r15.addPackage(r4, r6, r7);	 Catch:{ RemoteException -> 0x06e5, RuntimeException -> 0x07ce }
        r0 = r41;
        r1 = r33;
        r0.processCurBroadcastLocked(r1, r15);	 Catch:{ RemoteException -> 0x06e5, RuntimeException -> 0x07ce }
        monitor-exit(r40);	 Catch:{ all -> 0x0069 }
        goto L_0x009b;
    L_0x06b7:
        r17 = move-exception;
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Failed trying to unstop package ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.curComponent;	 Catch:{ all -> 0x0069 }
        r7 = r7.getPackageName();	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = ": ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r17;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0069 }
        goto L_0x067f;
    L_0x06e5:
        r17 = move-exception;
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Exception when sending broadcast to ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.curComponent;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        r0 = r17;
        android.util.Slog.w(r4, r6, r0);	 Catch:{ all -> 0x0069 }
    L_0x0704:
        r4 = "sys.quickboot.enable";
        r6 = 0;
        r4 = android.os.SystemProperties.getInt(r4, r6);	 Catch:{ all -> 0x0069 }
        r6 = 1;
        if (r4 != r6) goto L_0x0729;
    L_0x070e:
        r4 = "sys.quickboot.poweron";
        r6 = 0;
        r4 = android.os.SystemProperties.getInt(r4, r6);	 Catch:{ all -> 0x0069 }
        if (r4 != 0) goto L_0x0729;
    L_0x0717:
        r4 = r41.getWhiteList();	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r6 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r6 = r6.applicationInfo;	 Catch:{ all -> 0x0069 }
        r6 = r6.packageName;	 Catch:{ all -> 0x0069 }
        r4 = r4.contains(r6);	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x075e;
    L_0x0729:
        r0 = r41;
        r4 = r0.mService;	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r6 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r6 = r6.applicationInfo;	 Catch:{ all -> 0x0069 }
        r7 = 1;
        r0 = r33;
        r8 = r0.intent;	 Catch:{ all -> 0x0069 }
        r8 = r8.getFlags();	 Catch:{ all -> 0x0069 }
        r8 = r8 | 4;
        r9 = "broadcast";
        r0 = r33;
        r10 = r0.curComponent;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r11 = r0.intent;	 Catch:{ all -> 0x0069 }
        r11 = r11.getFlags();	 Catch:{ all -> 0x0069 }
        r12 = 33554432; // 0x2000000 float:9.403955E-38 double:1.6578092E-316;
        r11 = r11 & r12;
        if (r11 == 0) goto L_0x0825;
    L_0x0751:
        r11 = 1;
    L_0x0752:
        r12 = 0;
        r13 = 0;
        r4 = r4.startProcessLocked(r5, r6, r7, r8, r9, r10, r11, r12, r13);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r0.curApp = r4;	 Catch:{ all -> 0x0069 }
        if (r4 != 0) goto L_0x0828;
    L_0x075e:
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Unable to launch app ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r7 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r7 = r7.applicationInfo;	 Catch:{ all -> 0x0069 }
        r7 = r7.packageName;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = "/";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r21;
        r7 = r0.activityInfo;	 Catch:{ all -> 0x0069 }
        r7 = r7.applicationInfo;	 Catch:{ all -> 0x0069 }
        r7 = r7.uid;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " for broadcast ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.intent;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = ": process is bad";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r1 = r33;
        r0.logBroadcastReceiverDiscardLocked(r1);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r8 = r0.resultCode;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r9 = r0.resultData;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r10 = r0.resultExtras;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r11 = r0.resultAbort;	 Catch:{ all -> 0x0069 }
        r12 = 0;
        r6 = r41;
        r7 = r33;
        r6.finishReceiverLocked(r7, r8, r9, r10, r11, r12);	 Catch:{ all -> 0x0069 }
        r41.scheduleBroadcastsLocked();	 Catch:{ all -> 0x0069 }
        r4 = 0;
        r0 = r33;
        r0.state = r4;	 Catch:{ all -> 0x0069 }
        monitor-exit(r40);	 Catch:{ all -> 0x0069 }
        goto L_0x009b;
    L_0x07ce:
        r17 = move-exception;
        r4 = "BroadcastQueue";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r6.<init>();	 Catch:{ all -> 0x0069 }
        r7 = "Failed sending broadcast to ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.curComponent;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r7 = " with ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.intent;	 Catch:{ all -> 0x0069 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x0069 }
        r6 = r6.toString();	 Catch:{ all -> 0x0069 }
        r0 = r17;
        android.util.Slog.wtf(r4, r6, r0);	 Catch:{ all -> 0x0069 }
        r0 = r41;
        r1 = r33;
        r0.logBroadcastReceiverDiscardLocked(r1);	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r6 = r0.resultCode;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r7 = r0.resultData;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r8 = r0.resultExtras;	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r9 = r0.resultAbort;	 Catch:{ all -> 0x0069 }
        r10 = 0;
        r4 = r41;
        r5 = r33;
        r4.finishReceiverLocked(r5, r6, r7, r8, r9, r10);	 Catch:{ all -> 0x0069 }
        r41.scheduleBroadcastsLocked();	 Catch:{ all -> 0x0069 }
        r4 = 0;
        r0 = r33;
        r0.state = r4;	 Catch:{ all -> 0x0069 }
        monitor-exit(r40);	 Catch:{ all -> 0x0069 }
        goto L_0x009b;
    L_0x0825:
        r11 = 0;
        goto L_0x0752;
    L_0x0828:
        r0 = r33;
        r1 = r41;
        r1.mPendingBroadcast = r0;	 Catch:{ all -> 0x0069 }
        r0 = r34;
        r1 = r41;
        r1.mPendingBroadcastRecvIndex = r0;	 Catch:{ all -> 0x0069 }
        monitor-exit(r40);	 Catch:{ all -> 0x0069 }
        goto L_0x009b;
    L_0x0837:
        r4 = move-exception;
        goto L_0x067f;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.BroadcastQueue.processNextBroadcast(boolean):void");
    }

    private ArrayList<String> getWhiteList() {
        if (quickbootWhiteList == null) {
            quickbootWhiteList = new ArrayList();
            quickbootWhiteList.add("com.android.deskclock");
            quickbootWhiteList.add("com.qapp.quickboot");
        }
        return quickbootWhiteList;
    }

    final void setBroadcastTimeoutLocked(long timeoutTime) {
        if (!this.mPendingBroadcastTimeoutMessage) {
            this.mHandler.sendMessageAtTime(this.mHandler.obtainMessage(BROADCAST_TIMEOUT_MSG, this), timeoutTime);
            this.mPendingBroadcastTimeoutMessage = true;
        }
    }

    final void cancelBroadcastTimeoutLocked() {
        if (this.mPendingBroadcastTimeoutMessage) {
            this.mHandler.removeMessages(BROADCAST_TIMEOUT_MSG, this);
            this.mPendingBroadcastTimeoutMessage = DEBUG_MU;
        }
    }

    final void broadcastTimeoutLocked(boolean fromMsg) {
        if (fromMsg) {
            this.mPendingBroadcastTimeoutMessage = DEBUG_MU;
        }
        if (this.mOrderedBroadcasts.size() != 0) {
            long now = SystemClock.uptimeMillis();
            BroadcastRecord r = (BroadcastRecord) this.mOrderedBroadcasts.get(MAX_BROADCAST_SUMMARY_HISTORY);
            if (fromMsg) {
                if (this.mService.mDidDexOpt) {
                    this.mService.mDidDexOpt = DEBUG_MU;
                    setBroadcastTimeoutLocked(SystemClock.uptimeMillis() + this.mTimeoutPeriod);
                    return;
                } else if (this.mService.mProcessesReady) {
                    long timeoutTime = r.receiverTime + this.mTimeoutPeriod;
                    if (timeoutTime > now) {
                        setBroadcastTimeoutLocked(timeoutTime);
                        return;
                    }
                } else {
                    return;
                }
            }
            BroadcastRecord br = (BroadcastRecord) this.mOrderedBroadcasts.get(MAX_BROADCAST_SUMMARY_HISTORY);
            if (br.state == 4) {
                Slog.i("ActivityManager", "Waited long enough for: " + (br.curComponent != null ? br.curComponent.flattenToShortString() : "(null)"));
                br.curComponent = null;
                br.state = MAX_BROADCAST_SUMMARY_HISTORY;
                processNextBroadcast(DEBUG_MU);
                return;
            }
            Slog.w(TAG, "Timeout of broadcast " + r + " - receiver=" + r.receiver + ", started " + (now - r.receiverTime) + "ms ago");
            r.receiverTime = now;
            r.anrCount++;
            if (r.nextReceiver <= 0) {
                Slog.w(TAG, "Timeout on receiver with nextReceiver <= 0");
                return;
            }
            ProcessRecord app = null;
            String anrMessage = null;
            BroadcastFilter curReceiver = r.receivers.get(r.nextReceiver - 1);
            Slog.w(TAG, "Receiver during timeout: " + curReceiver);
            logBroadcastReceiverDiscardLocked(r);
            if (curReceiver instanceof BroadcastFilter) {
                BroadcastFilter bf = curReceiver;
                if (!(bf.receiverList.pid == 0 || bf.receiverList.pid == ActivityManagerService.MY_PID)) {
                    synchronized (this.mService.mPidsSelfLocked) {
                        app = (ProcessRecord) this.mService.mPidsSelfLocked.get(bf.receiverList.pid);
                    }
                }
            } else {
                app = r.curApp;
            }
            if (app != null) {
                anrMessage = "Broadcast of " + r.intent.toString();
            }
            if (this.mPendingBroadcast == r) {
                this.mPendingBroadcast = null;
            }
            finishReceiverLocked(r, r.resultCode, r.resultData, r.resultExtras, r.resultAbort, DEBUG_MU);
            scheduleBroadcastsLocked();
            if (anrMessage != null) {
                this.mHandler.post(new AppNotResponding(app, anrMessage));
            }
        }
    }

    private final void addBroadcastToHistoryLocked(BroadcastRecord r) {
        if (r.callingUid >= 0) {
            System.arraycopy(this.mBroadcastHistory, MAX_BROADCAST_SUMMARY_HISTORY, this.mBroadcastHistory, 1, MAX_BROADCAST_HISTORY - 1);
            r.finishTime = SystemClock.uptimeMillis();
            this.mBroadcastHistory[MAX_BROADCAST_SUMMARY_HISTORY] = r;
            System.arraycopy(this.mBroadcastSummaryHistory, MAX_BROADCAST_SUMMARY_HISTORY, this.mBroadcastSummaryHistory, 1, MAX_BROADCAST_SUMMARY_HISTORY - 1);
            this.mBroadcastSummaryHistory[MAX_BROADCAST_SUMMARY_HISTORY] = r.intent;
        }
    }

    final void logBroadcastReceiverDiscardLocked(BroadcastRecord r) {
        if (r.nextReceiver > 0) {
            BroadcastFilter curReceiver = r.receivers.get(r.nextReceiver - 1);
            if (curReceiver instanceof BroadcastFilter) {
                BroadcastFilter bf = curReceiver;
                EventLog.writeEvent(EventLogTags.AM_BROADCAST_DISCARD_FILTER, new Object[]{Integer.valueOf(bf.owningUserId), Integer.valueOf(System.identityHashCode(r)), r.intent.getAction(), Integer.valueOf(r.nextReceiver - 1), Integer.valueOf(System.identityHashCode(bf))});
                return;
            }
            ResolveInfo ri = (ResolveInfo) curReceiver;
            EventLog.writeEvent(EventLogTags.AM_BROADCAST_DISCARD_APP, new Object[]{Integer.valueOf(UserHandle.getUserId(ri.activityInfo.applicationInfo.uid)), Integer.valueOf(System.identityHashCode(r)), r.intent.getAction(), Integer.valueOf(r.nextReceiver - 1), ri.toString()});
            return;
        }
        Slog.w(TAG, "Discarding broadcast before first receiver is invoked: " + r);
        EventLog.writeEvent(EventLogTags.AM_BROADCAST_DISCARD_APP, new Object[]{Integer.valueOf(-1), Integer.valueOf(System.identityHashCode(r)), r.intent.getAction(), Integer.valueOf(r.nextReceiver), "NONE"});
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    final boolean dumpLocked(java.io.FileDescriptor r13, java.io.PrintWriter r14, java.lang.String[] r15, int r16, boolean r17, java.lang.String r18, boolean r19) {
        /*
        r12 = this;
        r7 = r12.mParallelBroadcasts;
        r7 = r7.size();
        if (r7 > 0) goto L_0x0014;
    L_0x0008:
        r7 = r12.mOrderedBroadcasts;
        r7 = r7.size();
        if (r7 > 0) goto L_0x0014;
    L_0x0010:
        r7 = r12.mPendingBroadcast;
        if (r7 == 0) goto L_0x0150;
    L_0x0014:
        r5 = 0;
        r7 = r12.mParallelBroadcasts;
        r7 = r7.size();
        r3 = r7 + -1;
    L_0x001d:
        if (r3 < 0) goto L_0x008c;
    L_0x001f:
        r7 = r12.mParallelBroadcasts;
        r1 = r7.get(r3);
        r1 = (com.android.server.am.BroadcastRecord) r1;
        if (r18 == 0) goto L_0x0036;
    L_0x0029:
        r7 = r1.callerPackage;
        r0 = r18;
        r7 = r0.equals(r7);
        if (r7 != 0) goto L_0x0036;
    L_0x0033:
        r3 = r3 + -1;
        goto L_0x001d;
    L_0x0036:
        if (r5 != 0) goto L_0x005e;
    L_0x0038:
        if (r19 == 0) goto L_0x003d;
    L_0x003a:
        r14.println();
    L_0x003d:
        r19 = 1;
        r5 = 1;
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "  Active broadcasts [";
        r7 = r7.append(r8);
        r8 = r12.mQueueName;
        r7 = r7.append(r8);
        r8 = "]:";
        r7 = r7.append(r8);
        r7 = r7.toString();
        r14.println(r7);
    L_0x005e:
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "  Active Broadcast ";
        r7 = r7.append(r8);
        r8 = r12.mQueueName;
        r7 = r7.append(r8);
        r8 = " #";
        r7 = r7.append(r8);
        r7 = r7.append(r3);
        r8 = ":";
        r7 = r7.append(r8);
        r7 = r7.toString();
        r14.println(r7);
        r7 = "    ";
        r1.dump(r14, r7);
        goto L_0x0033;
    L_0x008c:
        r5 = 0;
        r19 = 1;
        r7 = r12.mOrderedBroadcasts;
        r7 = r7.size();
        r3 = r7 + -1;
    L_0x0097:
        if (r3 < 0) goto L_0x010e;
    L_0x0099:
        r7 = r12.mOrderedBroadcasts;
        r1 = r7.get(r3);
        r1 = (com.android.server.am.BroadcastRecord) r1;
        if (r18 == 0) goto L_0x00b0;
    L_0x00a3:
        r7 = r1.callerPackage;
        r0 = r18;
        r7 = r0.equals(r7);
        if (r7 != 0) goto L_0x00b0;
    L_0x00ad:
        r3 = r3 + -1;
        goto L_0x0097;
    L_0x00b0:
        if (r5 != 0) goto L_0x00d8;
    L_0x00b2:
        if (r19 == 0) goto L_0x00b7;
    L_0x00b4:
        r14.println();
    L_0x00b7:
        r19 = 1;
        r5 = 1;
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "  Active ordered broadcasts [";
        r7 = r7.append(r8);
        r8 = r12.mQueueName;
        r7 = r7.append(r8);
        r8 = "]:";
        r7 = r7.append(r8);
        r7 = r7.toString();
        r14.println(r7);
    L_0x00d8:
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "  Active Ordered Broadcast ";
        r7 = r7.append(r8);
        r8 = r12.mQueueName;
        r7 = r7.append(r8);
        r8 = " #";
        r7 = r7.append(r8);
        r7 = r7.append(r3);
        r8 = ":";
        r7 = r7.append(r8);
        r7 = r7.toString();
        r14.println(r7);
        r7 = r12.mOrderedBroadcasts;
        r7 = r7.get(r3);
        r7 = (com.android.server.am.BroadcastRecord) r7;
        r8 = "    ";
        r7.dump(r14, r8);
        goto L_0x00ad;
    L_0x010e:
        if (r18 == 0) goto L_0x0120;
    L_0x0110:
        r7 = r12.mPendingBroadcast;
        if (r7 == 0) goto L_0x0150;
    L_0x0114:
        r7 = r12.mPendingBroadcast;
        r7 = r7.callerPackage;
        r0 = r18;
        r7 = r0.equals(r7);
        if (r7 == 0) goto L_0x0150;
    L_0x0120:
        if (r19 == 0) goto L_0x0125;
    L_0x0122:
        r14.println();
    L_0x0125:
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "  Pending broadcast [";
        r7 = r7.append(r8);
        r8 = r12.mQueueName;
        r7 = r7.append(r8);
        r8 = "]:";
        r7 = r7.append(r8);
        r7 = r7.toString();
        r14.println(r7);
        r7 = r12.mPendingBroadcast;
        if (r7 == 0) goto L_0x016d;
    L_0x0147:
        r7 = r12.mPendingBroadcast;
        r8 = "    ";
        r7.dump(r14, r8);
    L_0x014e:
        r19 = 1;
    L_0x0150:
        r5 = 0;
        r3 = 0;
    L_0x0152:
        r7 = MAX_BROADCAST_HISTORY;
        if (r3 >= r7) goto L_0x015c;
    L_0x0156:
        r7 = r12.mBroadcastHistory;
        r6 = r7[r3];
        if (r6 != 0) goto L_0x0173;
    L_0x015c:
        if (r18 != 0) goto L_0x016c;
    L_0x015e:
        if (r17 == 0) goto L_0x0162;
    L_0x0160:
        r3 = 0;
        r5 = 0;
    L_0x0162:
        r7 = MAX_BROADCAST_SUMMARY_HISTORY;
        if (r3 >= r7) goto L_0x016c;
    L_0x0166:
        r7 = r12.mBroadcastSummaryHistory;
        r4 = r7[r3];
        if (r4 != 0) goto L_0x022c;
    L_0x016c:
        return r19;
    L_0x016d:
        r7 = "    (null)";
        r14.println(r7);
        goto L_0x014e;
    L_0x0173:
        if (r18 == 0) goto L_0x0182;
    L_0x0175:
        r7 = r6.callerPackage;
        r0 = r18;
        r7 = r0.equals(r7);
        if (r7 != 0) goto L_0x0182;
    L_0x017f:
        r3 = r3 + 1;
        goto L_0x0152;
    L_0x0182:
        if (r5 != 0) goto L_0x01aa;
    L_0x0184:
        if (r19 == 0) goto L_0x0189;
    L_0x0186:
        r14.println();
    L_0x0189:
        r19 = 1;
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "  Historical broadcasts [";
        r7 = r7.append(r8);
        r8 = r12.mQueueName;
        r7 = r7.append(r8);
        r8 = "]:";
        r7 = r7.append(r8);
        r7 = r7.toString();
        r14.println(r7);
        r5 = 1;
    L_0x01aa:
        if (r17 == 0) goto L_0x01d8;
    L_0x01ac:
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "  Historical Broadcast ";
        r7 = r7.append(r8);
        r8 = r12.mQueueName;
        r7 = r7.append(r8);
        r8 = " #";
        r7 = r7.append(r8);
        r7 = r7.toString();
        r14.print(r7);
        r14.print(r3);
        r7 = ":";
        r14.println(r7);
        r7 = "    ";
        r6.dump(r14, r7);
        goto L_0x017f;
    L_0x01d8:
        r7 = "  #";
        r14.print(r7);
        r14.print(r3);
        r7 = ": ";
        r14.print(r7);
        r14.println(r6);
        r7 = "    ";
        r14.print(r7);
        r7 = r6.intent;
        r8 = 0;
        r9 = 1;
        r10 = 1;
        r11 = 0;
        r7 = r7.toShortString(r8, r9, r10, r11);
        r14.println(r7);
        r7 = r6.targetComp;
        if (r7 == 0) goto L_0x0216;
    L_0x01fe:
        r7 = r6.targetComp;
        r8 = r6.intent;
        r8 = r8.getComponent();
        if (r7 == r8) goto L_0x0216;
    L_0x0208:
        r7 = "    targetComp: ";
        r14.print(r7);
        r7 = r6.targetComp;
        r7 = r7.toShortString();
        r14.println(r7);
    L_0x0216:
        r7 = r6.intent;
        r2 = r7.getExtras();
        if (r2 == 0) goto L_0x017f;
    L_0x021e:
        r7 = "    extras: ";
        r14.print(r7);
        r7 = r2.toString();
        r14.println(r7);
        goto L_0x017f;
    L_0x022c:
        if (r5 != 0) goto L_0x0254;
    L_0x022e:
        if (r19 == 0) goto L_0x0233;
    L_0x0230:
        r14.println();
    L_0x0233:
        r19 = 1;
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "  Historical broadcasts summary [";
        r7 = r7.append(r8);
        r8 = r12.mQueueName;
        r7 = r7.append(r8);
        r8 = "]:";
        r7 = r7.append(r8);
        r7 = r7.toString();
        r14.println(r7);
        r5 = 1;
    L_0x0254:
        if (r17 != 0) goto L_0x0261;
    L_0x0256:
        r7 = 50;
        if (r3 < r7) goto L_0x0261;
    L_0x025a:
        r7 = "  ...";
        r14.println(r7);
        goto L_0x016c;
    L_0x0261:
        r7 = "  #";
        r14.print(r7);
        r14.print(r3);
        r7 = ": ";
        r14.print(r7);
        r7 = 0;
        r8 = 1;
        r9 = 1;
        r10 = 0;
        r7 = r4.toShortString(r7, r8, r9, r10);
        r14.println(r7);
        r2 = r4.getExtras();
        if (r2 == 0) goto L_0x028b;
    L_0x027f:
        r7 = "    extras: ";
        r14.print(r7);
        r7 = r2.toString();
        r14.println(r7);
    L_0x028b:
        r3 = r3 + 1;
        goto L_0x0162;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.BroadcastQueue.dumpLocked(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String[], int, boolean, java.lang.String, boolean):boolean");
    }
}
