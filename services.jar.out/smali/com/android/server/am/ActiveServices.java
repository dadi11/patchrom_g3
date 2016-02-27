package com.android.server.am;

import android.app.ActivityManager;
import android.app.ActivityManager.RunningServiceInfo;
import android.app.AppGlobals;
import android.app.IApplicationThread;
import android.app.IServiceConnection;
import android.app.Notification;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Intent;
import android.content.Intent.FilterComparison;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.EventLog;
import android.util.Slog;
import android.util.SparseArray;
import android.util.TimeUtils;
import com.android.internal.app.ProcessStats.ServiceState;
import com.android.internal.os.BatteryStatsImpl;
import com.android.internal.os.BatteryStatsImpl.Uid.Pkg.Serv;
import com.android.internal.os.TransferPipe;
import com.android.internal.util.FastPrintWriter;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public final class ActiveServices {
    static final int BG_START_TIMEOUT = 15000;
    static final boolean DEBUG_DELAYED_SERVICE = false;
    static final boolean DEBUG_DELAYED_STARTS = false;
    static final boolean DEBUG_MU = false;
    static final boolean DEBUG_SERVICE = false;
    static final boolean DEBUG_SERVICE_EXECUTING = false;
    static final int LAST_ANR_LIFETIME_DURATION_MSECS = 7200000;
    static final boolean LOG_SERVICE_START_STOP = false;
    static final int MAX_SERVICE_INACTIVITY = 1800000;
    static final int SERVICE_BACKGROUND_TIMEOUT = 200000;
    static final int SERVICE_MIN_RESTART_TIME_BETWEEN = 10000;
    static final int SERVICE_RESET_RUN_DURATION = 60000;
    static final int SERVICE_RESTART_DURATION = 1000;
    static final int SERVICE_RESTART_DURATION_FACTOR = 4;
    static final int SERVICE_TIMEOUT = 20000;
    static final String TAG = "ActivityManager";
    static final String TAG_MU = "ActivityManagerServiceMU";
    final ActivityManagerService mAm;
    final ArrayList<ServiceRecord> mDestroyingServices;
    String mLastAnrDump;
    final Runnable mLastAnrDumpClearer;
    final int mMaxStartingBackground;
    final ArrayList<ServiceRecord> mPendingServices;
    final ArrayList<ServiceRecord> mRestartingServices;
    final ArrayMap<IBinder, ArrayList<ConnectionRecord>> mServiceConnections;
    final SparseArray<ServiceMap> mServiceMap;

    /* renamed from: com.android.server.am.ActiveServices.1 */
    class C01211 implements Runnable {
        C01211() {
        }

        public void run() {
            synchronized (ActiveServices.this.mAm) {
                ActiveServices.this.mLastAnrDump = null;
            }
        }
    }

    static final class DelayingProcess extends ArrayList<ServiceRecord> {
        long timeoout;

        DelayingProcess() {
        }
    }

    private final class ServiceLookupResult {
        final String permission;
        final ServiceRecord record;

        ServiceLookupResult(ServiceRecord _record, String _permission) {
            this.record = _record;
            this.permission = _permission;
        }
    }

    class ServiceMap extends Handler {
        static final int MSG_BG_START_TIMEOUT = 1;
        final ArrayList<ServiceRecord> mDelayedStartList;
        final ArrayMap<FilterComparison, ServiceRecord> mServicesByIntent;
        final ArrayMap<ComponentName, ServiceRecord> mServicesByName;
        final ArrayList<ServiceRecord> mStartingBackground;
        final int mUserId;

        ServiceMap(Looper looper, int userId) {
            super(looper);
            this.mServicesByName = new ArrayMap();
            this.mServicesByIntent = new ArrayMap();
            this.mDelayedStartList = new ArrayList();
            this.mStartingBackground = new ArrayList();
            this.mUserId = userId;
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case MSG_BG_START_TIMEOUT /*1*/:
                    synchronized (ActiveServices.this.mAm) {
                        rescheduleDelayedStarts();
                        break;
                    }
                default:
            }
        }

        void ensureNotStartingBackground(ServiceRecord r) {
            if (this.mStartingBackground.remove(r)) {
                rescheduleDelayedStarts();
            }
            if (!this.mDelayedStartList.remove(r)) {
            }
        }

        void rescheduleDelayedStarts() {
            removeMessages(MSG_BG_START_TIMEOUT);
            long now = SystemClock.uptimeMillis();
            int i = 0;
            int N = this.mStartingBackground.size();
            while (i < N) {
                ServiceRecord r = (ServiceRecord) this.mStartingBackground.get(i);
                if (r.startingBgTimeout <= now) {
                    Slog.i(ActiveServices.TAG, "Waited long enough for: " + r);
                    this.mStartingBackground.remove(i);
                    N--;
                    i--;
                }
                i += MSG_BG_START_TIMEOUT;
            }
            while (this.mDelayedStartList.size() > 0 && this.mStartingBackground.size() < ActiveServices.this.mMaxStartingBackground) {
                r = (ServiceRecord) this.mDelayedStartList.remove(0);
                if (r.pendingStarts.size() <= 0) {
                    Slog.w(ActiveServices.TAG, "**** NO PENDING STARTS! " + r + " startReq=" + r.startRequested + " delayedStop=" + r.delayedStop);
                }
                r.delayed = ActiveServices.LOG_SERVICE_START_STOP;
                ActiveServices.this.startServiceInnerLocked(this, ((StartItem) r.pendingStarts.get(0)).intent, r, ActiveServices.LOG_SERVICE_START_STOP, true);
            }
            if (this.mStartingBackground.size() > 0) {
                long when;
                ServiceRecord next = (ServiceRecord) this.mStartingBackground.get(0);
                if (next.startingBgTimeout > now) {
                    when = next.startingBgTimeout;
                } else {
                    when = now;
                }
                sendMessageAtTime(obtainMessage(MSG_BG_START_TIMEOUT), when);
            }
            if (this.mStartingBackground.size() < ActiveServices.this.mMaxStartingBackground) {
                ActiveServices.this.mAm.backgroundServicesFinishedLocked(this.mUserId);
            }
        }
    }

    private class ServiceRestarter implements Runnable {
        private ServiceRecord mService;

        private ServiceRestarter() {
        }

        void setService(ServiceRecord service) {
            this.mService = service;
        }

        public void run() {
            synchronized (ActiveServices.this.mAm) {
                ActiveServices.this.performServiceRestartLocked(this.mService);
            }
        }
    }

    private final void realStartServiceLocked(com.android.server.am.ServiceRecord r11, com.android.server.am.ProcessRecord r12, boolean r13) throws android.os.RemoteException {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxRuntimeException: Incorrect nodes count for selectOther: B:27:0x00a6 in [B:26:0x009b, B:27:0x00a6, B:28:0x00a7]
	at jadx.core.utils.BlockUtils.selectOther(BlockUtils.java:53)
	at jadx.core.dex.instructions.IfNode.initBlocks(IfNode.java:62)
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
        r10 = this;
        r9 = 1;
        r4 = 0;
        r2 = 0;
        r0 = r12.thread;
        if (r0 != 0) goto L_0x000d;
    L_0x0007:
        r0 = new android.os.RemoteException;
        r0.<init>();
        throw r0;
    L_0x000d:
        r11.app = r12;
        r0 = android.os.SystemClock.uptimeMillis();
        r11.lastActivity = r0;
        r11.restartTime = r0;
        r0 = r12.services;
        r0.add(r11);
        r0 = "create";
        r10.bumpServiceExecutingLocked(r11, r13, r0);
        r0 = r10.mAm;
        r0.updateLruProcessLocked(r12, r2, r4);
        r0 = r10.mAm;
        r0.updateOomAdjLocked();
        r6 = 0;
        r0 = r11.stats;	 Catch:{ DeadObjectException -> 0x006d }
        r1 = r0.getBatteryStats();	 Catch:{ DeadObjectException -> 0x006d }
        monitor-enter(r1);	 Catch:{ DeadObjectException -> 0x006d }
        r0 = r11.stats;	 Catch:{ DeadObjectException -> 0x006d }
        r0.startLaunchedLocked();	 Catch:{ DeadObjectException -> 0x006d }
        monitor-exit(r1);	 Catch:{ DeadObjectException -> 0x006d }
        r0 = r10.mAm;	 Catch:{ DeadObjectException -> 0x006d }
        r1 = r11.serviceInfo;	 Catch:{ DeadObjectException -> 0x006d }
        r1 = r1.packageName;	 Catch:{ DeadObjectException -> 0x006d }
        r0.ensurePackageDexOpt(r1);	 Catch:{ DeadObjectException -> 0x006d }
        r0 = 7;	 Catch:{ DeadObjectException -> 0x006d }
        r12.forceProcessStateUpTo(r0);	 Catch:{ DeadObjectException -> 0x006d }
        r0 = r12.thread;	 Catch:{ DeadObjectException -> 0x006d }
        r1 = r11.serviceInfo;	 Catch:{ DeadObjectException -> 0x006d }
        r3 = r10.mAm;	 Catch:{ DeadObjectException -> 0x006d }
        r5 = r11.serviceInfo;	 Catch:{ DeadObjectException -> 0x006d }
        r5 = r5.applicationInfo;	 Catch:{ DeadObjectException -> 0x006d }
        r3 = r3.compatibilityInfoForPackageLocked(r5);	 Catch:{ DeadObjectException -> 0x006d }
        r5 = r12.repProcState;	 Catch:{ DeadObjectException -> 0x006d }
        r0.scheduleCreateService(r11, r1, r3, r5);	 Catch:{ DeadObjectException -> 0x006d }
        r11.postNotification();	 Catch:{ DeadObjectException -> 0x006d }
        r6 = 1;
        if (r6 != 0) goto L_0x00a7;
    L_0x005f:
        r0 = r12.services;
        r0.remove(r11);
        r11.app = r4;
        r10.scheduleServiceRestartLocked(r11, r2);
    L_0x0069:
        return;
    L_0x006a:
        r0 = move-exception;
        monitor-exit(r1);	 Catch:{ DeadObjectException -> 0x006d }
        throw r0;	 Catch:{ DeadObjectException -> 0x006d }
    L_0x006d:
        r7 = move-exception;
        r0 = "ActivityManager";	 Catch:{ all -> 0x0098 }
        r1 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0098 }
        r1.<init>();	 Catch:{ all -> 0x0098 }
        r3 = "Application dead when creating service ";	 Catch:{ all -> 0x0098 }
        r1 = r1.append(r3);	 Catch:{ all -> 0x0098 }
        r1 = r1.append(r11);	 Catch:{ all -> 0x0098 }
        r1 = r1.toString();	 Catch:{ all -> 0x0098 }
        android.util.Slog.w(r0, r1);	 Catch:{ all -> 0x0098 }
        r0 = r10.mAm;	 Catch:{ all -> 0x0098 }
        r0.appDiedLocked(r12);	 Catch:{ all -> 0x0098 }
        if (r6 != 0) goto L_0x00a7;
    L_0x008d:
        r0 = r12.services;
        r0.remove(r11);
        r11.app = r4;
        r10.scheduleServiceRestartLocked(r11, r2);
        goto L_0x0069;
    L_0x0098:
        r0 = move-exception;
        if (r6 != 0) goto L_0x00a6;
    L_0x009b:
        r0 = r12.services;
        r0.remove(r11);
        r11.app = r4;
        r10.scheduleServiceRestartLocked(r11, r2);
        goto L_0x0069;
    L_0x00a6:
        throw r0;
    L_0x00a7:
        r10.requestServiceBindingsLocked(r11, r13);
        r10.updateServiceClientActivitiesLocked(r12, r4, r9);
        r0 = r11.startRequested;
        if (r0 == 0) goto L_0x00cd;
    L_0x00b1:
        r0 = r11.callStart;
        if (r0 == 0) goto L_0x00cd;
    L_0x00b5:
        r0 = r11.pendingStarts;
        r0 = r0.size();
        if (r0 != 0) goto L_0x00cd;
    L_0x00bd:
        r8 = r11.pendingStarts;
        r0 = new com.android.server.am.ServiceRecord$StartItem;
        r3 = r11.makeNextStartId();
        r1 = r11;
        r5 = r4;
        r0.<init>(r1, r2, r3, r4, r5);
        r8.add(r0);
    L_0x00cd:
        r10.sendServiceArgsLocked(r11, r13, r9);
        r0 = r11.delayed;
        if (r0 == 0) goto L_0x00e1;
    L_0x00d4:
        r0 = r11.userId;
        r0 = r10.getServiceMap(r0);
        r0 = r0.mDelayedStartList;
        r0.remove(r11);
        r11.delayed = r2;
    L_0x00e1:
        r0 = r11.delayedStop;
        if (r0 == 0) goto L_0x0069;
    L_0x00e5:
        r11.delayedStop = r2;
        r0 = r11.startRequested;
        if (r0 == 0) goto L_0x0069;
    L_0x00eb:
        r10.stopServiceLocked(r11);
        goto L_0x0069;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActiveServices.realStartServiceLocked(com.android.server.am.ServiceRecord, com.android.server.am.ProcessRecord, boolean):void");
    }

    public ActiveServices(ActivityManagerService service) {
        this.mServiceMap = new SparseArray();
        this.mServiceConnections = new ArrayMap();
        this.mPendingServices = new ArrayList();
        this.mRestartingServices = new ArrayList();
        this.mDestroyingServices = new ArrayList();
        this.mLastAnrDumpClearer = new C01211();
        this.mAm = service;
        int maxBg = 0;
        try {
            maxBg = Integer.parseInt(SystemProperties.get("ro.config.max_starting_bg", "0"));
        } catch (RuntimeException e) {
        }
        if (maxBg <= 0) {
            maxBg = ActivityManager.isLowRamDeviceStatic() ? 1 : 8;
        }
        this.mMaxStartingBackground = maxBg;
    }

    ServiceRecord getServiceByName(ComponentName name, int callingUser) {
        return (ServiceRecord) getServiceMap(callingUser).mServicesByName.get(name);
    }

    boolean hasBackgroundServices(int callingUser) {
        ServiceMap smap = (ServiceMap) this.mServiceMap.get(callingUser);
        if (smap == null || smap.mStartingBackground.size() < this.mMaxStartingBackground) {
            return LOG_SERVICE_START_STOP;
        }
        return true;
    }

    private ServiceMap getServiceMap(int callingUser) {
        ServiceMap smap = (ServiceMap) this.mServiceMap.get(callingUser);
        if (smap != null) {
            return smap;
        }
        smap = new ServiceMap(this.mAm.mHandler.getLooper(), callingUser);
        this.mServiceMap.put(callingUser, smap);
        return smap;
    }

    ArrayMap<ComponentName, ServiceRecord> getServices(int callingUser) {
        return getServiceMap(callingUser).mServicesByName;
    }

    ComponentName startServiceLocked(IApplicationThread caller, Intent service, String resolvedType, int callingPid, int callingUid, int userId) {
        boolean callerFg;
        if (caller != null) {
            ProcessRecord callerApp = this.mAm.getRecordForAppLocked(caller);
            if (callerApp == null) {
                throw new SecurityException("Unable to find app for caller " + caller + " (pid=" + Binder.getCallingPid() + ") when starting service " + service);
            }
            callerFg = callerApp.setSchedGroup != 0 ? true : LOG_SERVICE_START_STOP;
        } else {
            callerFg = true;
        }
        ServiceLookupResult res = retrieveServiceLocked(service, resolvedType, callingPid, callingUid, userId, true, callerFg);
        if (res == null) {
            return null;
        }
        if (res.record == null) {
            return new ComponentName("!", res.permission != null ? res.permission : "private to package");
        }
        ServiceRecord r = res.record;
        if (this.mAm.getUserManagerLocked().exists(r.userId)) {
            ServiceMap smap;
            boolean addToStarting;
            NeededUriGrants neededGrants = this.mAm.checkGrantUriPermissionFromIntentLocked(callingUid, r.packageName, service, service.getFlags(), null, r.userId);
            if (unscheduleServiceRestartLocked(r, callingUid, LOG_SERVICE_START_STOP)) {
                r.lastActivity = SystemClock.uptimeMillis();
                r.startRequested = true;
                r.delayedStop = LOG_SERVICE_START_STOP;
                r.pendingStarts.add(new StartItem(r, LOG_SERVICE_START_STOP, r.makeNextStartId(), service, neededGrants));
                smap = getServiceMap(r.userId);
                addToStarting = LOG_SERVICE_START_STOP;
            } else {
                r.lastActivity = SystemClock.uptimeMillis();
                r.startRequested = true;
                r.delayedStop = LOG_SERVICE_START_STOP;
                r.pendingStarts.add(new StartItem(r, LOG_SERVICE_START_STOP, r.makeNextStartId(), service, neededGrants));
                smap = getServiceMap(r.userId);
                addToStarting = LOG_SERVICE_START_STOP;
            }
            if (!(callerFg || r.app != null || this.mAm.mStartedUsers.get(r.userId) == null)) {
                ProcessRecord proc = this.mAm.getProcessRecordLocked(r.processName, r.appInfo.uid, LOG_SERVICE_START_STOP);
                if (proc == null || proc.curProcState > 8) {
                    if (r.delayed) {
                        return r.name;
                    }
                    if (smap.mStartingBackground.size() >= this.mMaxStartingBackground) {
                        Slog.i(TAG, "Delaying start of: " + r);
                        smap.mDelayedStartList.add(r);
                        r.delayed = true;
                        return r.name;
                    }
                    addToStarting = true;
                } else if (proc.curProcState >= 7) {
                    addToStarting = true;
                }
            }
            return startServiceInnerLocked(smap, service, r, callerFg, addToStarting);
        }
        Slog.d(TAG, "Trying to start service with non-existent user! " + r.userId);
        return null;
    }

    ComponentName startServiceInnerLocked(ServiceMap smap, Intent service, ServiceRecord r, boolean callerFg, boolean addToStarting) {
        boolean first = true;
        ServiceState stracker = r.getTracker();
        if (stracker != null) {
            stracker.setStarted(true, this.mAm.mProcessStats.getMemFactorLocked(), r.lastActivity);
        }
        r.callStart = LOG_SERVICE_START_STOP;
        synchronized (r.stats.getBatteryStats()) {
            r.stats.startRunningLocked();
        }
        String error = bringUpServiceLocked(r, service.getFlags(), callerFg, LOG_SERVICE_START_STOP);
        if (error != null) {
            return new ComponentName("!!", error);
        }
        if (r.startRequested && addToStarting) {
            if (smap.mStartingBackground.size() != 0) {
                first = LOG_SERVICE_START_STOP;
            }
            smap.mStartingBackground.add(r);
            r.startingBgTimeout = SystemClock.uptimeMillis() + 15000;
            if (first) {
                smap.rescheduleDelayedStarts();
            }
        } else if (callerFg) {
            smap.ensureNotStartingBackground(r);
        }
        return r.name;
    }

    private void stopServiceLocked(ServiceRecord service) {
        if (service.delayed) {
            service.delayedStop = true;
            return;
        }
        synchronized (service.stats.getBatteryStats()) {
            service.stats.stopRunningLocked();
        }
        service.startRequested = LOG_SERVICE_START_STOP;
        if (service.tracker != null) {
            service.tracker.setStarted(LOG_SERVICE_START_STOP, this.mAm.mProcessStats.getMemFactorLocked(), SystemClock.uptimeMillis());
        }
        service.callStart = LOG_SERVICE_START_STOP;
        bringDownServiceIfNeededLocked(service, LOG_SERVICE_START_STOP, LOG_SERVICE_START_STOP);
    }

    int stopServiceLocked(IApplicationThread caller, Intent service, String resolvedType, int userId) {
        ProcessRecord callerApp = this.mAm.getRecordForAppLocked(caller);
        if (caller == null || callerApp != null) {
            ServiceLookupResult r = retrieveServiceLocked(service, resolvedType, Binder.getCallingPid(), Binder.getCallingUid(), userId, LOG_SERVICE_START_STOP, LOG_SERVICE_START_STOP);
            if (r == null) {
                return 0;
            }
            if (r.record == null) {
                return -1;
            }
            long origId = Binder.clearCallingIdentity();
            try {
                stopServiceLocked(r.record);
                return 1;
            } finally {
                Binder.restoreCallingIdentity(origId);
            }
        } else {
            throw new SecurityException("Unable to find app for caller " + caller + " (pid=" + Binder.getCallingPid() + ") when stopping service " + service);
        }
    }

    IBinder peekServiceLocked(Intent service, String resolvedType) {
        ServiceLookupResult r = retrieveServiceLocked(service, resolvedType, Binder.getCallingPid(), Binder.getCallingUid(), UserHandle.getCallingUserId(), LOG_SERVICE_START_STOP, LOG_SERVICE_START_STOP);
        if (r == null) {
            return null;
        }
        if (r.record == null) {
            throw new SecurityException("Permission Denial: Accessing service " + r.record.name + " from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + r.permission);
        }
        IntentBindRecord ib = (IntentBindRecord) r.record.bindings.get(r.record.intent);
        if (ib != null) {
            return ib.binder;
        }
        return null;
    }

    boolean stopServiceTokenLocked(ComponentName className, IBinder token, int startId) {
        ServiceRecord r = findServiceLocked(className, token, UserHandle.getCallingUserId());
        if (r == null) {
            return LOG_SERVICE_START_STOP;
        }
        if (startId >= 0) {
            StartItem si = r.findDeliveredStart(startId, LOG_SERVICE_START_STOP);
            if (si != null) {
                while (r.deliveredStarts.size() > 0) {
                    StartItem cur = (StartItem) r.deliveredStarts.remove(0);
                    cur.removeUriPermissionsLocked();
                    if (cur == si) {
                        break;
                    }
                }
            }
            if (r.getLastStartId() != startId) {
                return LOG_SERVICE_START_STOP;
            }
            if (r.deliveredStarts.size() > 0) {
                Slog.w(TAG, "stopServiceToken startId " + startId + " is last, but have " + r.deliveredStarts.size() + " remaining args");
            }
        }
        synchronized (r.stats.getBatteryStats()) {
            r.stats.stopRunningLocked();
        }
        r.startRequested = LOG_SERVICE_START_STOP;
        if (r.tracker != null) {
            r.tracker.setStarted(LOG_SERVICE_START_STOP, this.mAm.mProcessStats.getMemFactorLocked(), SystemClock.uptimeMillis());
        }
        r.callStart = LOG_SERVICE_START_STOP;
        long origId = Binder.clearCallingIdentity();
        bringDownServiceIfNeededLocked(r, LOG_SERVICE_START_STOP, LOG_SERVICE_START_STOP);
        Binder.restoreCallingIdentity(origId);
        return true;
    }

    public void setServiceForegroundLocked(ComponentName className, IBinder token, int id, Notification notification, boolean removeNotification) {
        int userId = UserHandle.getCallingUserId();
        long origId = Binder.clearCallingIdentity();
        try {
            ServiceRecord r = findServiceLocked(className, token, userId);
            if (r != null) {
                if (id == 0) {
                    if (r.isForeground) {
                        r.isForeground = LOG_SERVICE_START_STOP;
                        if (r.app != null) {
                            this.mAm.updateLruProcessLocked(r.app, LOG_SERVICE_START_STOP, null);
                            updateServiceForegroundLocked(r.app, true);
                        }
                    }
                    if (removeNotification) {
                        r.cancelNotification();
                        r.foregroundId = 0;
                        r.foregroundNoti = null;
                    } else if (r.appInfo.targetSdkVersion >= 21) {
                        r.stripForegroundServiceFlagFromNotification();
                    }
                } else if (notification == null) {
                    throw new IllegalArgumentException("null notification");
                } else {
                    if (r.foregroundId != id) {
                        r.cancelNotification();
                        r.foregroundId = id;
                    }
                    notification.flags |= 64;
                    r.foregroundNoti = notification;
                    r.isForeground = true;
                    r.postNotification();
                    if (r.app != null) {
                        updateServiceForegroundLocked(r.app, true);
                    }
                    getServiceMap(r.userId).ensureNotStartingBackground(r);
                }
            }
            Binder.restoreCallingIdentity(origId);
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(origId);
        }
    }

    private void updateServiceForegroundLocked(ProcessRecord proc, boolean oomAdj) {
        boolean anyForeground = LOG_SERVICE_START_STOP;
        for (int i = proc.services.size() - 1; i >= 0; i--) {
            if (((ServiceRecord) proc.services.valueAt(i)).isForeground) {
                anyForeground = true;
                break;
            }
        }
        this.mAm.updateProcessForegroundLocked(proc, anyForeground, oomAdj);
    }

    public void updateServiceConnectionActivitiesLocked(ProcessRecord clientProc) {
        ArraySet<ProcessRecord> updatedProcesses = null;
        for (int i = 0; i < clientProc.connections.size(); i++) {
            ProcessRecord proc = ((ConnectionRecord) clientProc.connections.valueAt(i)).binding.service.app;
            if (!(proc == null || proc == clientProc)) {
                if (updatedProcesses == null) {
                    updatedProcesses = new ArraySet();
                } else if (updatedProcesses.contains(proc)) {
                }
                updatedProcesses.add(proc);
                updateServiceClientActivitiesLocked(proc, null, LOG_SERVICE_START_STOP);
            }
        }
    }

    private boolean updateServiceClientActivitiesLocked(ProcessRecord proc, ConnectionRecord modCr, boolean updateLru) {
        if (modCr != null && modCr.binding.client != null && modCr.binding.client.activities.size() <= 0) {
            return LOG_SERVICE_START_STOP;
        }
        boolean anyClientActivities = LOG_SERVICE_START_STOP;
        for (int i = proc.services.size() - 1; i >= 0 && !anyClientActivities; i--) {
            ServiceRecord sr = (ServiceRecord) proc.services.valueAt(i);
            for (int conni = sr.connections.size() - 1; conni >= 0 && !anyClientActivities; conni--) {
                ArrayList<ConnectionRecord> clist = (ArrayList) sr.connections.valueAt(conni);
                for (int cri = clist.size() - 1; cri >= 0; cri--) {
                    ConnectionRecord cr = (ConnectionRecord) clist.get(cri);
                    if (cr.binding.client != null && cr.binding.client != proc && cr.binding.client.activities.size() > 0) {
                        anyClientActivities = true;
                        break;
                    }
                }
            }
        }
        if (anyClientActivities == proc.hasClientActivities) {
            return LOG_SERVICE_START_STOP;
        }
        proc.hasClientActivities = anyClientActivities;
        if (updateLru) {
            this.mAm.updateLruProcessLocked(proc, anyClientActivities, null);
        }
        return true;
    }

    int bindServiceLocked(IApplicationThread caller, IBinder token, Intent service, String resolvedType, IServiceConnection connection, int flags, int userId) {
        ProcessRecord callerApp = this.mAm.getRecordForAppLocked(caller);
        if (callerApp == null) {
            throw new SecurityException("Unable to find app for caller " + caller + " (pid=" + Binder.getCallingPid() + ") when binding service " + service);
        }
        ActivityRecord activity = null;
        if (token != null) {
            activity = ActivityRecord.isInStackLocked(token);
            if (activity == null) {
                Slog.w(TAG, "Binding with unknown activity: " + token);
                return 0;
            }
        }
        int clientLabel = 0;
        PendingIntent clientIntent = null;
        if (callerApp.info.uid == SERVICE_RESTART_DURATION) {
            try {
                clientIntent = (PendingIntent) service.getParcelableExtra("android.intent.extra.client_intent");
            } catch (RuntimeException e) {
            }
            if (clientIntent != null) {
                clientLabel = service.getIntExtra("android.intent.extra.client_label", 0);
                if (clientLabel != 0) {
                    service = service.cloneFilter();
                }
            }
        }
        if ((134217728 & flags) != 0) {
            this.mAm.enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "BIND_TREAT_LIKE_ACTIVITY");
        }
        boolean callerFg = callerApp.setSchedGroup != 0 ? true : LOG_SERVICE_START_STOP;
        ServiceLookupResult res = retrieveServiceLocked(service, resolvedType, Binder.getCallingPid(), Binder.getCallingUid(), userId, true, callerFg);
        if (res == null) {
            return 0;
        }
        if (res.record == null) {
            return -1;
        }
        ServiceRecord s = res.record;
        long origId = Binder.clearCallingIdentity();
        if (unscheduleServiceRestartLocked(s, callerApp.info.uid, LOG_SERVICE_START_STOP)) {
        }
        if ((flags & 1) != 0) {
            s.lastActivity = SystemClock.uptimeMillis();
            if (!s.hasAutoCreateConnections()) {
                ServiceState stracker = s.getTracker();
                if (stracker != null) {
                    stracker.setBound(true, this.mAm.mProcessStats.getMemFactorLocked(), s.lastActivity);
                }
            }
        }
        this.mAm.startAssociationLocked(callerApp.uid, callerApp.processName, s.appInfo.uid, s.name, s.processName);
        AppBindRecord b = s.retrieveAppBindingLocked(service, callerApp);
        ConnectionRecord c = new ConnectionRecord(b, activity, connection, flags, clientLabel, clientIntent);
        IBinder binder = connection.asBinder();
        ArrayList<ConnectionRecord> clist = (ArrayList) s.connections.get(binder);
        if (clist == null) {
            clist = new ArrayList();
            s.connections.put(binder, clist);
        }
        clist.add(c);
        b.connections.add(c);
        if (activity != null) {
            if (activity.connections == null) {
                activity.connections = new HashSet();
            }
            activity.connections.add(c);
        }
        b.client.connections.add(c);
        if ((c.flags & 8) != 0) {
            b.client.hasAboveClient = true;
        }
        if (s.app != null) {
            updateServiceClientActivitiesLocked(s.app, c, true);
        }
        clist = (ArrayList) this.mServiceConnections.get(binder);
        if (clist == null) {
            clist = new ArrayList();
            this.mServiceConnections.put(binder, clist);
        }
        clist.add(c);
        if ((flags & 1) != 0) {
            s.lastActivity = SystemClock.uptimeMillis();
            if (bringUpServiceLocked(s, service.getFlags(), callerFg, LOG_SERVICE_START_STOP) != null) {
                Binder.restoreCallingIdentity(origId);
                return 0;
            }
        }
        try {
            if (s.app != null) {
                if ((134217728 & flags) != 0) {
                    s.app.treatLikeActivity = true;
                }
                ActivityManagerService activityManagerService = this.mAm;
                ProcessRecord processRecord = s.app;
                boolean z = (s.app.hasClientActivities || s.app.treatLikeActivity) ? true : LOG_SERVICE_START_STOP;
                activityManagerService.updateLruProcessLocked(processRecord, z, b.client);
                this.mAm.updateOomAdjLocked(s.app);
            }
            if (s.app != null && b.intent.received) {
                c.conn.connected(s.name, b.intent.binder);
                if (b.intent.apps.size() == 1 && b.intent.doRebind) {
                    requestServiceBindingLocked(s, b.intent, callerFg, true);
                }
            } else if (!b.intent.requested) {
                requestServiceBindingLocked(s, b.intent, callerFg, LOG_SERVICE_START_STOP);
            }
        } catch (Throwable e2) {
            Slog.w(TAG, "Failure sending service " + s.shortName + " to connection " + c.conn.asBinder() + " (in " + c.binding.client.processName + ")", e2);
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(origId);
        }
        getServiceMap(s.userId).ensureNotStartingBackground(s);
        Binder.restoreCallingIdentity(origId);
        return 1;
    }

    void publishServiceLocked(ServiceRecord r, Intent intent, IBinder service) {
        long origId = Binder.clearCallingIdentity();
        if (r != null) {
            FilterComparison filter = new FilterComparison(intent);
            IntentBindRecord b = (IntentBindRecord) r.bindings.get(filter);
            if (!(b == null || b.received)) {
                b.binder = service;
                b.requested = true;
                b.received = true;
                for (int conni = r.connections.size() - 1; conni >= 0; conni--) {
                    ArrayList<ConnectionRecord> clist = (ArrayList) r.connections.valueAt(conni);
                    for (int i = 0; i < clist.size(); i++) {
                        ConnectionRecord c = (ConnectionRecord) clist.get(i);
                        if (filter.equals(c.binding.intent.intent)) {
                            try {
                                c.conn.connected(r.name, service);
                            } catch (Exception e) {
                                Slog.w(TAG, "Failure sending service " + r.name + " to connection " + c.conn.asBinder() + " (in " + c.binding.client.processName + ")", e);
                            } catch (Throwable th) {
                                Binder.restoreCallingIdentity(origId);
                            }
                        }
                    }
                }
            }
            serviceDoneExecutingLocked(r, this.mDestroyingServices.contains(r), LOG_SERVICE_START_STOP);
        }
        Binder.restoreCallingIdentity(origId);
    }

    boolean unbindServiceLocked(IServiceConnection connection) {
        IBinder binder = connection.asBinder();
        ArrayList<ConnectionRecord> clist = (ArrayList) this.mServiceConnections.get(binder);
        if (clist == null) {
            Slog.w(TAG, "Unbind failed: could not find connection for " + connection.asBinder());
            return LOG_SERVICE_START_STOP;
        }
        long origId = Binder.clearCallingIdentity();
        while (clist.size() > 0) {
            try {
                ConnectionRecord r = (ConnectionRecord) clist.get(0);
                removeConnectionLocked(r, null, null);
                if (clist.size() > 0 && clist.get(0) == r) {
                    Slog.wtf(TAG, "Connection " + r + " not removed for binder " + binder);
                    clist.remove(0);
                }
                if (r.binding.service.app != null) {
                    if ((r.flags & 134217728) != 0) {
                        boolean z;
                        r.binding.service.app.treatLikeActivity = true;
                        ActivityManagerService activityManagerService = this.mAm;
                        ProcessRecord processRecord = r.binding.service.app;
                        if (r.binding.service.app.hasClientActivities || r.binding.service.app.treatLikeActivity) {
                            z = true;
                        } else {
                            z = LOG_SERVICE_START_STOP;
                        }
                        activityManagerService.updateLruProcessLocked(processRecord, z, null);
                    }
                    this.mAm.updateOomAdjLocked(r.binding.service.app);
                }
            } finally {
                Binder.restoreCallingIdentity(origId);
            }
        }
        return true;
    }

    void unbindFinishedLocked(ServiceRecord r, Intent intent, boolean doRebind) {
        long origId = Binder.clearCallingIdentity();
        if (r != null) {
            try {
                IntentBindRecord b = (IntentBindRecord) r.bindings.get(new FilterComparison(intent));
                boolean inDestroying = this.mDestroyingServices.contains(r);
                if (b != null) {
                    if (b.apps.size() <= 0 || inDestroying) {
                        b.doRebind = true;
                    } else {
                        boolean inFg = LOG_SERVICE_START_STOP;
                        for (int i = b.apps.size() - 1; i >= 0; i--) {
                            ProcessRecord client = ((AppBindRecord) b.apps.valueAt(i)).client;
                            if (client != null && client.setSchedGroup != 0) {
                                inFg = true;
                                break;
                            }
                        }
                        requestServiceBindingLocked(r, b, inFg, true);
                    }
                }
                serviceDoneExecutingLocked(r, inDestroying, LOG_SERVICE_START_STOP);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(origId);
            }
        }
        Binder.restoreCallingIdentity(origId);
    }

    private final ServiceRecord findServiceLocked(ComponentName name, IBinder token, int userId) {
        IBinder r = getServiceByName(name, userId);
        return r == token ? r : null;
    }

    private ServiceLookupResult retrieveServiceLocked(Intent service, String resolvedType, int callingPid, int callingUid, int userId, boolean createIfNeeded, boolean callingFromFg) {
        ServiceRecord serviceRecord;
        userId = this.mAm.handleIncomingUser(callingPid, callingUid, userId, (boolean) LOG_SERVICE_START_STOP, 1, "service", null);
        ServiceMap smap = getServiceMap(userId);
        ComponentName comp = service.getComponent();
        if (comp != null) {
            serviceRecord = (ServiceRecord) smap.mServicesByName.get(comp);
        } else {
            serviceRecord = null;
        }
        if (serviceRecord == null) {
            serviceRecord = (ServiceRecord) smap.mServicesByIntent.get(new FilterComparison(service));
        }
        if (serviceRecord == null) {
            try {
                ResolveInfo rInfo = AppGlobals.getPackageManager().resolveService(service, resolvedType, DumpState.DUMP_PREFERRED_XML, userId);
                ServiceInfo serviceInfo = rInfo != null ? rInfo.serviceInfo : null;
                if (serviceInfo == null) {
                    Slog.w(TAG, "Unable to start service " + service + " U=" + userId + ": not found");
                    return null;
                }
                ComponentName name = new ComponentName(serviceInfo.applicationInfo.packageName, serviceInfo.name);
                if (userId > 0) {
                    if (this.mAm.isSingleton(serviceInfo.processName, serviceInfo.applicationInfo, serviceInfo.name, serviceInfo.flags)) {
                        if (this.mAm.isValidSingletonCall(callingUid, serviceInfo.applicationInfo.uid)) {
                            userId = 0;
                            smap = getServiceMap(0);
                        }
                    }
                    ServiceInfo serviceInfo2 = new ServiceInfo(serviceInfo);
                    serviceInfo2.applicationInfo = this.mAm.getAppInfoForUser(serviceInfo2.applicationInfo, userId);
                    serviceInfo = serviceInfo2;
                }
                ServiceRecord r = (ServiceRecord) smap.mServicesByName.get(name);
                if (r == null && createIfNeeded) {
                    try {
                        Serv ss;
                        FilterComparison filter = new FilterComparison(service.cloneFilter());
                        ActiveServices activeServices = this;
                        ServiceRestarter res = new ServiceRestarter();
                        BatteryStatsImpl stats = this.mAm.mBatteryStatsService.getActiveStatistics();
                        synchronized (stats) {
                            ss = stats.getServiceStatsLocked(serviceInfo.applicationInfo.uid, serviceInfo.packageName, serviceInfo.name);
                        }
                        serviceRecord = new ServiceRecord(this.mAm, ss, name, filter, serviceInfo, callingFromFg, res);
                        res.setService(serviceRecord);
                        smap.mServicesByName.put(name, serviceRecord);
                        smap.mServicesByIntent.put(filter, serviceRecord);
                        for (int i = this.mPendingServices.size() - 1; i >= 0; i--) {
                            ServiceRecord pr = (ServiceRecord) this.mPendingServices.get(i);
                            if (pr.serviceInfo.applicationInfo.uid == serviceInfo.applicationInfo.uid && pr.name.equals(name)) {
                                this.mPendingServices.remove(i);
                            }
                        }
                    } catch (RemoteException e) {
                        serviceRecord = r;
                    }
                } else {
                    serviceRecord = r;
                }
            } catch (RemoteException e2) {
            }
        }
        if (serviceRecord == null) {
            return null;
        }
        if (this.mAm.checkComponentPermission(serviceRecord.permission, callingPid, callingUid, serviceRecord.appInfo.uid, serviceRecord.exported) == 0) {
            if (this.mAm.mIntentFirewall.checkService(serviceRecord.name, service, callingUid, callingPid, resolvedType, serviceRecord.appInfo)) {
                return new ServiceLookupResult(serviceRecord, null);
            }
            return null;
        } else if (serviceRecord.exported) {
            Slog.w(TAG, "Permission Denial: Accessing service " + serviceRecord.name + " from pid=" + callingPid + ", uid=" + callingUid + " requires " + serviceRecord.permission);
            return new ServiceLookupResult(null, serviceRecord.permission);
        } else {
            Slog.w(TAG, "Permission Denial: Accessing service " + serviceRecord.name + " from pid=" + callingPid + ", uid=" + callingUid + " that is not exported from uid " + serviceRecord.appInfo.uid);
            return new ServiceLookupResult(null, "not exported from uid " + serviceRecord.appInfo.uid);
        }
    }

    private final void bumpServiceExecutingLocked(ServiceRecord r, boolean fg, String why) {
        long now = SystemClock.uptimeMillis();
        if (r.executeNesting == 0) {
            r.executeFg = fg;
            ServiceState stracker = r.getTracker();
            if (stracker != null) {
                stracker.setExecuting(true, this.mAm.mProcessStats.getMemFactorLocked(), now);
            }
            if (r.app != null) {
                r.app.executingServices.add(r);
                ProcessRecord processRecord = r.app;
                processRecord.execServicesFg |= fg;
                if (r.app.executingServices.size() == 1) {
                    scheduleServiceTimeoutLocked(r.app);
                }
            }
        } else if (!(r.app == null || !fg || r.app.execServicesFg)) {
            r.app.execServicesFg = true;
            scheduleServiceTimeoutLocked(r.app);
        }
        r.executeFg |= fg;
        r.executeNesting++;
        r.executingStart = now;
    }

    private final boolean requestServiceBindingLocked(ServiceRecord r, IntentBindRecord i, boolean execInFg, boolean rebind) {
        if (r.app == null || r.app.thread == null) {
            return LOG_SERVICE_START_STOP;
        }
        if ((!i.requested || rebind) && i.apps.size() > 0) {
            try {
                bumpServiceExecutingLocked(r, execInFg, "bind");
                r.app.forceProcessStateUpTo(7);
                r.app.thread.scheduleBindService(r, i.intent.getIntent(), rebind, r.app.repProcState);
                if (!rebind) {
                    i.requested = true;
                }
                i.hasBound = true;
                i.doRebind = LOG_SERVICE_START_STOP;
            } catch (RemoteException e) {
                return LOG_SERVICE_START_STOP;
            }
        }
        return true;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private final boolean scheduleServiceRestartLocked(com.android.server.am.ServiceRecord r27, boolean r28) {
        /*
        r26 = this;
        r5 = 0;
        r0 = r27;
        r0 = r0.userId;
        r20 = r0;
        r0 = r26;
        r1 = r20;
        r19 = r0.getServiceMap(r1);
        r0 = r19;
        r0 = r0.mServicesByName;
        r20 = r0;
        r0 = r27;
        r0 = r0.name;
        r21 = r0;
        r20 = r20.get(r21);
        r0 = r20;
        r1 = r27;
        if (r0 == r1) goto L_0x0062;
    L_0x0025:
        r0 = r19;
        r0 = r0.mServicesByName;
        r20 = r0;
        r0 = r27;
        r0 = r0.name;
        r21 = r0;
        r6 = r20.get(r21);
        r6 = (com.android.server.am.ServiceRecord) r6;
        r20 = "ActivityManager";
        r21 = new java.lang.StringBuilder;
        r21.<init>();
        r22 = "Attempting to schedule restart of ";
        r21 = r21.append(r22);
        r0 = r21;
        r1 = r27;
        r21 = r0.append(r1);
        r22 = " when found in map: ";
        r21 = r21.append(r22);
        r0 = r21;
        r21 = r0.append(r6);
        r21 = r21.toString();
        android.util.Slog.wtf(r20, r21);
        r20 = 0;
    L_0x0061:
        return r20;
    L_0x0062:
        r12 = android.os.SystemClock.uptimeMillis();
        r0 = r27;
        r0 = r0.serviceInfo;
        r20 = r0;
        r0 = r20;
        r0 = r0.applicationInfo;
        r20 = r0;
        r0 = r20;
        r0 = r0.flags;
        r20 = r0;
        r20 = r20 & 8;
        if (r20 != 0) goto L_0x02f9;
    L_0x007c:
        r10 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r16 = 60000; // 0xea60 float:8.4078E-41 double:2.9644E-319;
        r0 = r27;
        r0 = r0.deliveredStarts;
        r20 = r0;
        r4 = r20.size();
        if (r4 <= 0) goto L_0x0131;
    L_0x008d:
        r7 = r4 + -1;
    L_0x008f:
        if (r7 < 0) goto L_0x0128;
    L_0x0091:
        r0 = r27;
        r0 = r0.deliveredStarts;
        r20 = r0;
        r0 = r20;
        r18 = r0.get(r7);
        r18 = (com.android.server.am.ServiceRecord.StartItem) r18;
        r18.removeUriPermissionsLocked();
        r0 = r18;
        r0 = r0.intent;
        r20 = r0;
        if (r20 != 0) goto L_0x00ad;
    L_0x00aa:
        r7 = r7 + -1;
        goto L_0x008f;
    L_0x00ad:
        if (r28 == 0) goto L_0x00cb;
    L_0x00af:
        r0 = r18;
        r0 = r0.deliveryCount;
        r20 = r0;
        r21 = 3;
        r0 = r20;
        r1 = r21;
        if (r0 >= r1) goto L_0x00f8;
    L_0x00bd:
        r0 = r18;
        r0 = r0.doneExecutingCount;
        r20 = r0;
        r21 = 6;
        r0 = r20;
        r1 = r21;
        if (r0 >= r1) goto L_0x00f8;
    L_0x00cb:
        r0 = r27;
        r0 = r0.pendingStarts;
        r20 = r0;
        r21 = 0;
        r0 = r20;
        r1 = r21;
        r2 = r18;
        r0.add(r1, r2);
        r20 = android.os.SystemClock.uptimeMillis();
        r0 = r18;
        r0 = r0.deliveredTime;
        r22 = r0;
        r8 = r20 - r22;
        r20 = 2;
        r8 = r8 * r20;
        r20 = (r10 > r8 ? 1 : (r10 == r8 ? 0 : -1));
        if (r20 >= 0) goto L_0x00f1;
    L_0x00f0:
        r10 = r8;
    L_0x00f1:
        r20 = (r16 > r8 ? 1 : (r16 == r8 ? 0 : -1));
        if (r20 >= 0) goto L_0x00aa;
    L_0x00f5:
        r16 = r8;
        goto L_0x00aa;
    L_0x00f8:
        r20 = "ActivityManager";
        r21 = new java.lang.StringBuilder;
        r21.<init>();
        r22 = "Canceling start item ";
        r21 = r21.append(r22);
        r0 = r18;
        r0 = r0.intent;
        r22 = r0;
        r21 = r21.append(r22);
        r22 = " in service ";
        r21 = r21.append(r22);
        r0 = r27;
        r0 = r0.name;
        r22 = r0;
        r21 = r21.append(r22);
        r21 = r21.toString();
        android.util.Slog.w(r20, r21);
        r5 = 1;
        goto L_0x00aa;
    L_0x0128:
        r0 = r27;
        r0 = r0.deliveredStarts;
        r20 = r0;
        r20.clear();
    L_0x0131:
        r0 = r27;
        r0 = r0.totalRestartCount;
        r20 = r0;
        r20 = r20 + 1;
        r0 = r20;
        r1 = r27;
        r1.totalRestartCount = r0;
        r0 = r27;
        r0 = r0.restartDelay;
        r20 = r0;
        r22 = 0;
        r20 = (r20 > r22 ? 1 : (r20 == r22 ? 0 : -1));
        if (r20 != 0) goto L_0x02bb;
    L_0x014b:
        r0 = r27;
        r0 = r0.restartCount;
        r20 = r0;
        r20 = r20 + 1;
        r0 = r20;
        r1 = r27;
        r1.restartCount = r0;
        r0 = r27;
        r0.restartDelay = r10;
    L_0x015d:
        r0 = r27;
        r0 = r0.restartDelay;
        r20 = r0;
        r20 = r20 + r12;
        r0 = r20;
        r2 = r27;
        r2.nextRestartTime = r0;
    L_0x016b:
        r15 = 0;
        r0 = r26;
        r0 = r0.mRestartingServices;
        r20 = r0;
        r20 = r20.size();
        r7 = r20 + -1;
    L_0x0178:
        if (r7 < 0) goto L_0x01cd;
    L_0x017a:
        r0 = r26;
        r0 = r0.mRestartingServices;
        r20 = r0;
        r0 = r20;
        r14 = r0.get(r7);
        r14 = (com.android.server.am.ServiceRecord) r14;
        r0 = r27;
        if (r14 == r0) goto L_0x02f5;
    L_0x018c:
        r0 = r27;
        r0 = r0.nextRestartTime;
        r20 = r0;
        r0 = r14.nextRestartTime;
        r22 = r0;
        r24 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r22 = r22 - r24;
        r20 = (r20 > r22 ? 1 : (r20 == r22 ? 0 : -1));
        if (r20 < 0) goto L_0x02f5;
    L_0x019e:
        r0 = r27;
        r0 = r0.nextRestartTime;
        r20 = r0;
        r0 = r14.nextRestartTime;
        r22 = r0;
        r24 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r22 = r22 + r24;
        r20 = (r20 > r22 ? 1 : (r20 == r22 ? 0 : -1));
        if (r20 >= 0) goto L_0x02f5;
    L_0x01b0:
        r0 = r14.nextRestartTime;
        r20 = r0;
        r22 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r20 = r20 + r22;
        r0 = r20;
        r2 = r27;
        r2.nextRestartTime = r0;
        r0 = r27;
        r0 = r0.nextRestartTime;
        r20 = r0;
        r20 = r20 - r12;
        r0 = r20;
        r2 = r27;
        r2.restartDelay = r0;
        r15 = 1;
    L_0x01cd:
        if (r15 != 0) goto L_0x016b;
    L_0x01cf:
        r0 = r26;
        r0 = r0.mRestartingServices;
        r20 = r0;
        r0 = r20;
        r1 = r27;
        r20 = r0.contains(r1);
        if (r20 != 0) goto L_0x020b;
    L_0x01df:
        r20 = 0;
        r0 = r20;
        r1 = r27;
        r1.createdFromFg = r0;
        r0 = r26;
        r0 = r0.mRestartingServices;
        r20 = r0;
        r0 = r20;
        r1 = r27;
        r0.add(r1);
        r0 = r26;
        r0 = r0.mAm;
        r20 = r0;
        r0 = r20;
        r0 = r0.mProcessStats;
        r20 = r0;
        r20 = r20.getMemFactorLocked();
        r0 = r27;
        r1 = r20;
        r0.makeRestarting(r1, r12);
    L_0x020b:
        r27.cancelNotification();
        r0 = r26;
        r0 = r0.mAm;
        r20 = r0;
        r0 = r20;
        r0 = r0.mHandler;
        r20 = r0;
        r0 = r27;
        r0 = r0.restarter;
        r21 = r0;
        r20.removeCallbacks(r21);
        r0 = r26;
        r0 = r0.mAm;
        r20 = r0;
        r0 = r20;
        r0 = r0.mHandler;
        r20 = r0;
        r0 = r27;
        r0 = r0.restarter;
        r21 = r0;
        r0 = r27;
        r0 = r0.nextRestartTime;
        r22 = r0;
        r20.postAtTime(r21, r22);
        r20 = android.os.SystemClock.uptimeMillis();
        r0 = r27;
        r0 = r0.restartDelay;
        r22 = r0;
        r20 = r20 + r22;
        r0 = r20;
        r2 = r27;
        r2.nextRestartTime = r0;
        r20 = "ActivityManager";
        r21 = new java.lang.StringBuilder;
        r21.<init>();
        r22 = "Scheduling restart of crashed service ";
        r21 = r21.append(r22);
        r0 = r27;
        r0 = r0.shortName;
        r22 = r0;
        r21 = r21.append(r22);
        r22 = " in ";
        r21 = r21.append(r22);
        r0 = r27;
        r0 = r0.restartDelay;
        r22 = r0;
        r21 = r21.append(r22);
        r22 = "ms";
        r21 = r21.append(r22);
        r21 = r21.toString();
        android.util.Slog.w(r20, r21);
        r20 = 30035; // 0x7553 float:4.2088E-41 double:1.48393E-319;
        r21 = 3;
        r0 = r21;
        r0 = new java.lang.Object[r0];
        r21 = r0;
        r22 = 0;
        r0 = r27;
        r0 = r0.userId;
        r23 = r0;
        r23 = java.lang.Integer.valueOf(r23);
        r21[r22] = r23;
        r22 = 1;
        r0 = r27;
        r0 = r0.shortName;
        r23 = r0;
        r21[r22] = r23;
        r22 = 2;
        r0 = r27;
        r0 = r0.restartDelay;
        r24 = r0;
        r23 = java.lang.Long.valueOf(r24);
        r21[r22] = r23;
        android.util.EventLog.writeEvent(r20, r21);
        r20 = r5;
        goto L_0x0061;
    L_0x02bb:
        r0 = r27;
        r0 = r0.restartTime;
        r20 = r0;
        r20 = r20 + r16;
        r20 = (r12 > r20 ? 1 : (r12 == r20 ? 0 : -1));
        if (r20 <= 0) goto L_0x02d5;
    L_0x02c7:
        r20 = 1;
        r0 = r20;
        r1 = r27;
        r1.restartCount = r0;
        r0 = r27;
        r0.restartDelay = r10;
        goto L_0x015d;
    L_0x02d5:
        r0 = r27;
        r0 = r0.restartDelay;
        r20 = r0;
        r22 = 4;
        r20 = r20 * r22;
        r0 = r20;
        r2 = r27;
        r2.restartDelay = r0;
        r0 = r27;
        r0 = r0.restartDelay;
        r20 = r0;
        r20 = (r20 > r10 ? 1 : (r20 == r10 ? 0 : -1));
        if (r20 >= 0) goto L_0x015d;
    L_0x02ef:
        r0 = r27;
        r0.restartDelay = r10;
        goto L_0x015d;
    L_0x02f5:
        r7 = r7 + -1;
        goto L_0x0178;
    L_0x02f9:
        r0 = r27;
        r0 = r0.totalRestartCount;
        r20 = r0;
        r20 = r20 + 1;
        r0 = r20;
        r1 = r27;
        r1.totalRestartCount = r0;
        r20 = 0;
        r0 = r20;
        r1 = r27;
        r1.restartCount = r0;
        r20 = 0;
        r0 = r20;
        r2 = r27;
        r2.restartDelay = r0;
        r0 = r27;
        r0.nextRestartTime = r12;
        goto L_0x01cf;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActiveServices.scheduleServiceRestartLocked(com.android.server.am.ServiceRecord, boolean):boolean");
    }

    final void performServiceRestartLocked(ServiceRecord r) {
        if (this.mRestartingServices.contains(r)) {
            bringUpServiceLocked(r, r.intent.getIntent().getFlags(), r.createdFromFg, true);
        }
    }

    private final boolean unscheduleServiceRestartLocked(ServiceRecord r, int callingUid, boolean force) {
        if (!force && r.restartDelay == 0) {
            return LOG_SERVICE_START_STOP;
        }
        boolean removed = this.mRestartingServices.remove(r);
        if (removed || callingUid != r.appInfo.uid) {
            r.resetRestartCounter();
        }
        if (removed) {
            clearRestartingIfNeededLocked(r);
        }
        this.mAm.mHandler.removeCallbacks(r.restarter);
        return true;
    }

    private void clearRestartingIfNeededLocked(ServiceRecord r) {
        if (r.restartTracker != null) {
            boolean stillTracking = LOG_SERVICE_START_STOP;
            for (int i = this.mRestartingServices.size() - 1; i >= 0; i--) {
                if (((ServiceRecord) this.mRestartingServices.get(i)).restartTracker == r.restartTracker) {
                    stillTracking = true;
                    break;
                }
            }
            if (!stillTracking) {
                r.restartTracker.setRestarting(LOG_SERVICE_START_STOP, this.mAm.mProcessStats.getMemFactorLocked(), SystemClock.uptimeMillis());
                r.restartTracker = null;
            }
        }
    }

    private final String bringUpServiceLocked(ServiceRecord r, int intentFlags, boolean execInFg, boolean whileRestarting) {
        if (r.app != null && r.app.thread != null) {
            sendServiceArgsLocked(r, execInFg, LOG_SERVICE_START_STOP);
            return null;
        } else if (!whileRestarting && r.restartDelay > 0) {
            return null;
        } else {
            if (this.mRestartingServices.remove(r)) {
                clearRestartingIfNeededLocked(r);
            }
            if (r.delayed) {
                getServiceMap(r.userId).mDelayedStartList.remove(r);
                r.delayed = LOG_SERVICE_START_STOP;
            }
            String msg;
            if (this.mAm.mStartedUsers.get(r.userId) == null) {
                msg = "Unable to launch app " + r.appInfo.packageName + "/" + r.appInfo.uid + " for service " + r.intent.getIntent() + ": user " + r.userId + " is stopped";
                Slog.w(TAG, msg);
                bringDownServiceLocked(r);
                return msg;
            }
            ProcessRecord app;
            try {
                AppGlobals.getPackageManager().setPackageStoppedState(r.packageName, LOG_SERVICE_START_STOP, r.userId);
            } catch (RemoteException e) {
            } catch (IllegalArgumentException e2) {
                Slog.w(TAG, "Failed trying to unstop package " + r.packageName + ": " + e2);
            }
            boolean isolated = (r.serviceInfo.flags & 2) != 0 ? true : LOG_SERVICE_START_STOP;
            String procName = r.processName;
            if (isolated) {
                app = r.isolatedProc;
            } else {
                app = this.mAm.getProcessRecordLocked(procName, r.appInfo.uid, LOG_SERVICE_START_STOP);
                if (!(app == null || app.thread == null)) {
                    try {
                        app.addPackage(r.appInfo.packageName, r.appInfo.versionCode, this.mAm.mProcessStats);
                        realStartServiceLocked(r, app, execInFg);
                        return null;
                    } catch (RemoteException e3) {
                        Slog.w(TAG, "Exception when starting service " + r.shortName, e3);
                    }
                }
            }
            if (app == null) {
                app = this.mAm.startProcessLocked(procName, r.appInfo, true, intentFlags, "service", r.name, LOG_SERVICE_START_STOP, isolated, LOG_SERVICE_START_STOP);
                if (app == null) {
                    msg = "Unable to launch app " + r.appInfo.packageName + "/" + r.appInfo.uid + " for service " + r.intent.getIntent() + ": process is bad";
                    Slog.w(TAG, msg);
                    bringDownServiceLocked(r);
                    return msg;
                } else if (isolated) {
                    r.isolatedProc = app;
                }
            }
            if (!this.mPendingServices.contains(r)) {
                this.mPendingServices.add(r);
            }
            if (r.delayedStop) {
                r.delayedStop = LOG_SERVICE_START_STOP;
                if (r.startRequested) {
                    stopServiceLocked(r);
                }
            }
            return null;
        }
    }

    private final void requestServiceBindingsLocked(ServiceRecord r, boolean execInFg) {
        int i = r.bindings.size() - 1;
        while (i >= 0 && requestServiceBindingLocked(r, (IntentBindRecord) r.bindings.valueAt(i), execInFg, LOG_SERVICE_START_STOP)) {
            i--;
        }
    }

    private final void sendServiceArgsLocked(ServiceRecord r, boolean execInFg, boolean oomAdjusted) {
        int N = r.pendingStarts.size();
        if (N != 0) {
            while (r.pendingStarts.size() > 0) {
                try {
                    StartItem si = (StartItem) r.pendingStarts.remove(0);
                    if (si.intent != null || N <= 1) {
                        si.deliveredTime = SystemClock.uptimeMillis();
                        r.deliveredStarts.add(si);
                        si.deliveryCount++;
                        if (si.neededGrants != null) {
                            this.mAm.grantUriPermissionUncheckedFromIntentLocked(si.neededGrants, si.getUriPermissionsLocked());
                        }
                        bumpServiceExecutingLocked(r, execInFg, "start");
                        if (!oomAdjusted) {
                            oomAdjusted = true;
                            this.mAm.updateOomAdjLocked(r.app);
                        }
                        int flags = 0;
                        if (si.deliveryCount > 1) {
                            flags = 0 | 2;
                        }
                        if (si.doneExecutingCount > 0) {
                            flags |= 1;
                        }
                        r.app.thread.scheduleServiceArgs(r, si.taskRemoved, si.id, flags, si.intent);
                    }
                } catch (RemoteException e) {
                    return;
                } catch (Exception e2) {
                    Slog.w(TAG, "Unexpected exception", e2);
                    return;
                }
            }
        }
    }

    private final boolean isServiceNeeded(ServiceRecord r, boolean knowConn, boolean hasConn) {
        if (r.startRequested) {
            return true;
        }
        if (!knowConn) {
            hasConn = r.hasAutoCreateConnections();
        }
        if (hasConn) {
            return true;
        }
        return LOG_SERVICE_START_STOP;
    }

    private final void bringDownServiceIfNeededLocked(ServiceRecord r, boolean knowConn, boolean hasConn) {
        if (!isServiceNeeded(r, knowConn, hasConn) && !this.mPendingServices.contains(r)) {
            bringDownServiceLocked(r);
        }
    }

    private final void bringDownServiceLocked(ServiceRecord r) {
        int i;
        for (int conni = r.connections.size() - 1; conni >= 0; conni--) {
            ArrayList<ConnectionRecord> c = (ArrayList) r.connections.valueAt(conni);
            for (i = 0; i < c.size(); i++) {
                ConnectionRecord cr = (ConnectionRecord) c.get(i);
                cr.serviceDead = true;
                try {
                    cr.conn.connected(r.name, null);
                } catch (Exception e) {
                    Slog.w(TAG, "Failure disconnecting service " + r.name + " to connection " + ((ConnectionRecord) c.get(i)).conn.asBinder() + " (in " + ((ConnectionRecord) c.get(i)).binding.client.processName + ")", e);
                }
            }
        }
        if (!(r.app == null || r.app.thread == null)) {
            for (i = r.bindings.size() - 1; i >= 0; i--) {
                IntentBindRecord ibr = (IntentBindRecord) r.bindings.valueAt(i);
                if (ibr.hasBound) {
                    try {
                        bumpServiceExecutingLocked(r, LOG_SERVICE_START_STOP, "bring down unbind");
                        this.mAm.updateOomAdjLocked(r.app);
                        ibr.hasBound = LOG_SERVICE_START_STOP;
                        r.app.thread.scheduleUnbindService(r, ibr.intent.getIntent());
                    } catch (Exception e2) {
                        Slog.w(TAG, "Exception when unbinding service " + r.shortName, e2);
                        serviceProcessGoneLocked(r);
                    }
                }
            }
        }
        r.destroyTime = SystemClock.uptimeMillis();
        ServiceMap smap = getServiceMap(r.userId);
        smap.mServicesByName.remove(r.name);
        smap.mServicesByIntent.remove(r.intent);
        r.totalRestartCount = 0;
        unscheduleServiceRestartLocked(r, 0, true);
        for (i = this.mPendingServices.size() - 1; i >= 0; i--) {
            if (this.mPendingServices.get(i) == r) {
                this.mPendingServices.remove(i);
            }
        }
        r.cancelNotification();
        r.isForeground = LOG_SERVICE_START_STOP;
        r.foregroundId = 0;
        r.foregroundNoti = null;
        r.clearDeliveredStartsLocked();
        r.pendingStarts.clear();
        if (r.app != null) {
            synchronized (r.stats.getBatteryStats()) {
                r.stats.stopLaunchedLocked();
            }
            r.app.services.remove(r);
            if (r.app.thread != null) {
                updateServiceForegroundLocked(r.app, LOG_SERVICE_START_STOP);
                try {
                    bumpServiceExecutingLocked(r, LOG_SERVICE_START_STOP, "destroy");
                    this.mDestroyingServices.add(r);
                    r.destroying = true;
                    this.mAm.updateOomAdjLocked(r.app);
                    r.app.thread.scheduleStopService(r);
                } catch (Exception e22) {
                    Slog.w(TAG, "Exception when destroying service " + r.shortName, e22);
                    serviceProcessGoneLocked(r);
                }
            }
        }
        if (r.bindings.size() > 0) {
            r.bindings.clear();
        }
        if (r.restarter instanceof ServiceRestarter) {
            ((ServiceRestarter) r.restarter).setService(null);
        }
        int memFactor = this.mAm.mProcessStats.getMemFactorLocked();
        long now = SystemClock.uptimeMillis();
        if (r.tracker != null) {
            r.tracker.setStarted(LOG_SERVICE_START_STOP, memFactor, now);
            r.tracker.setBound(LOG_SERVICE_START_STOP, memFactor, now);
            if (r.executeNesting == 0) {
                r.tracker.clearCurrentOwner(r, LOG_SERVICE_START_STOP);
                r.tracker = null;
            }
        }
        smap.ensureNotStartingBackground(r);
    }

    void removeConnectionLocked(ConnectionRecord c, ProcessRecord skipApp, ActivityRecord skipAct) {
        IBinder binder = c.conn.asBinder();
        AppBindRecord b = c.binding;
        ServiceRecord s = b.service;
        ArrayList<ConnectionRecord> clist = (ArrayList) s.connections.get(binder);
        if (clist != null) {
            clist.remove(c);
            if (clist.size() == 0) {
                s.connections.remove(binder);
            }
        }
        b.connections.remove(c);
        if (!(c.activity == null || c.activity == skipAct || c.activity.connections == null)) {
            c.activity.connections.remove(c);
        }
        if (b.client != skipApp) {
            b.client.connections.remove(c);
            if ((c.flags & 8) != 0) {
                b.client.updateHasAboveClientLocked();
            }
            if (s.app != null) {
                updateServiceClientActivitiesLocked(s.app, c, true);
            }
        }
        clist = (ArrayList) this.mServiceConnections.get(binder);
        if (clist != null) {
            clist.remove(c);
            if (clist.size() == 0) {
                this.mServiceConnections.remove(binder);
            }
        }
        this.mAm.stopAssociationLocked(b.client.uid, b.client.processName, s.appInfo.uid, s.name);
        if (b.connections.size() == 0) {
            b.intent.apps.remove(b.client);
        }
        if (!c.serviceDead) {
            if (s.app != null && s.app.thread != null && b.intent.apps.size() == 0 && b.intent.hasBound) {
                try {
                    bumpServiceExecutingLocked(s, LOG_SERVICE_START_STOP, "unbind");
                    if (b.client != s.app && (c.flags & 32) == 0 && s.app.setProcState <= 8) {
                        this.mAm.updateLruProcessLocked(s.app, LOG_SERVICE_START_STOP, null);
                    }
                    this.mAm.updateOomAdjLocked(s.app);
                    b.intent.hasBound = LOG_SERVICE_START_STOP;
                    b.intent.doRebind = LOG_SERVICE_START_STOP;
                    s.app.thread.scheduleUnbindService(s, b.intent.intent.getIntent());
                } catch (Exception e) {
                    Slog.w(TAG, "Exception when unbinding service " + s.shortName, e);
                    serviceProcessGoneLocked(s);
                }
            }
            if ((c.flags & 1) != 0) {
                boolean hasAutoCreate = s.hasAutoCreateConnections();
                if (!(hasAutoCreate || s.tracker == null)) {
                    s.tracker.setBound(LOG_SERVICE_START_STOP, this.mAm.mProcessStats.getMemFactorLocked(), SystemClock.uptimeMillis());
                }
                bringDownServiceIfNeededLocked(s, true, hasAutoCreate);
            }
        }
    }

    void serviceDoneExecutingLocked(ServiceRecord r, int type, int startId, int res) {
        boolean inDestroying = this.mDestroyingServices.contains(r);
        if (r != null) {
            if (type == 1) {
                r.callStart = true;
                switch (res) {
                    case AppTransition.TRANSIT_NONE /*0*/:
                    case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                        r.findDeliveredStart(startId, true);
                        r.stopIfKilled = LOG_SERVICE_START_STOP;
                        break;
                    case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                        r.findDeliveredStart(startId, true);
                        if (r.getLastStartId() == startId) {
                            r.stopIfKilled = true;
                            break;
                        }
                        break;
                    case C0569H.REPORT_LOSING_FOCUS /*3*/:
                        StartItem si = r.findDeliveredStart(startId, LOG_SERVICE_START_STOP);
                        if (si != null) {
                            si.deliveryCount = 0;
                            si.doneExecutingCount++;
                            r.stopIfKilled = true;
                            break;
                        }
                        break;
                    case SERVICE_RESTART_DURATION /*1000*/:
                        r.findDeliveredStart(startId, true);
                        break;
                    default:
                        throw new IllegalArgumentException("Unknown service start result: " + res);
                }
                if (res == 0) {
                    r.callStart = LOG_SERVICE_START_STOP;
                }
            } else if (type == 2) {
                if (!inDestroying) {
                    Slog.wtfStack(TAG, "Service done with onDestroy, but not inDestroying: " + r);
                } else if (r.executeNesting != 1) {
                    Slog.wtfStack(TAG, "Service done with onDestroy, but executeNesting=" + r.executeNesting + ": " + r);
                    r.executeNesting = 1;
                }
            }
            long origId = Binder.clearCallingIdentity();
            serviceDoneExecutingLocked(r, inDestroying, inDestroying);
            Binder.restoreCallingIdentity(origId);
            return;
        }
        Slog.w(TAG, "Done executing unknown service from pid " + Binder.getCallingPid());
    }

    private void serviceProcessGoneLocked(ServiceRecord r) {
        if (r.tracker != null) {
            int memFactor = this.mAm.mProcessStats.getMemFactorLocked();
            long now = SystemClock.uptimeMillis();
            r.tracker.setExecuting(LOG_SERVICE_START_STOP, memFactor, now);
            r.tracker.setBound(LOG_SERVICE_START_STOP, memFactor, now);
            r.tracker.setStarted(LOG_SERVICE_START_STOP, memFactor, now);
        }
        serviceDoneExecutingLocked(r, true, true);
    }

    private void serviceDoneExecutingLocked(ServiceRecord r, boolean inDestroying, boolean finishing) {
        r.executeNesting--;
        if (r.executeNesting <= 0) {
            if (r.app != null) {
                r.app.execServicesFg = LOG_SERVICE_START_STOP;
                r.app.executingServices.remove(r);
                if (r.app.executingServices.size() == 0) {
                    this.mAm.mHandler.removeMessages(12, r.app);
                } else if (r.executeFg) {
                    for (int i = r.app.executingServices.size() - 1; i >= 0; i--) {
                        if (((ServiceRecord) r.app.executingServices.valueAt(i)).executeFg) {
                            r.app.execServicesFg = true;
                            break;
                        }
                    }
                }
                if (inDestroying) {
                    this.mDestroyingServices.remove(r);
                    r.bindings.clear();
                }
                this.mAm.updateOomAdjLocked(r.app);
            }
            r.executeFg = LOG_SERVICE_START_STOP;
            if (r.tracker != null) {
                r.tracker.setExecuting(LOG_SERVICE_START_STOP, this.mAm.mProcessStats.getMemFactorLocked(), SystemClock.uptimeMillis());
                if (finishing) {
                    r.tracker.clearCurrentOwner(r, LOG_SERVICE_START_STOP);
                    r.tracker = null;
                }
            }
            if (finishing) {
                if (!(r.app == null || r.app.persistent)) {
                    r.app.services.remove(r);
                }
                r.app = null;
            }
        }
    }

    boolean attachApplicationLocked(ProcessRecord proc, String processName) throws RemoteException {
        ServiceRecord sr;
        int i;
        boolean didSomething = LOG_SERVICE_START_STOP;
        if (this.mPendingServices.size() > 0) {
            sr = null;
            i = 0;
            while (i < this.mPendingServices.size()) {
                try {
                    sr = (ServiceRecord) this.mPendingServices.get(i);
                    if (proc == sr.isolatedProc || (proc.uid == sr.appInfo.uid && processName.equals(sr.processName))) {
                        this.mPendingServices.remove(i);
                        i--;
                        proc.addPackage(sr.appInfo.packageName, sr.appInfo.versionCode, this.mAm.mProcessStats);
                        realStartServiceLocked(sr, proc, sr.createdFromFg);
                        didSomething = true;
                    }
                    i++;
                } catch (RemoteException e) {
                    Slog.w(TAG, "Exception in new application when starting service " + sr.shortName, e);
                    throw e;
                }
            }
        }
        if (this.mRestartingServices.size() > 0) {
            for (i = 0; i < this.mRestartingServices.size(); i++) {
                sr = (ServiceRecord) this.mRestartingServices.get(i);
                if (proc == sr.isolatedProc || (proc.uid == sr.appInfo.uid && processName.equals(sr.processName))) {
                    this.mAm.mHandler.removeCallbacks(sr.restarter);
                    this.mAm.mHandler.post(sr.restarter);
                }
            }
        }
        return didSomething;
    }

    void processStartTimedOutLocked(ProcessRecord proc) {
        int i = 0;
        while (i < this.mPendingServices.size()) {
            ServiceRecord sr = (ServiceRecord) this.mPendingServices.get(i);
            if ((proc.uid == sr.appInfo.uid && proc.processName.equals(sr.processName)) || sr.isolatedProc == proc) {
                Slog.w(TAG, "Forcing bringing down service: " + sr);
                sr.isolatedProc = null;
                this.mPendingServices.remove(i);
                i--;
                bringDownServiceLocked(sr);
            }
            i++;
        }
    }

    private boolean collectForceStopServicesLocked(String name, int userId, boolean evenPersistent, boolean doit, ArrayMap<ComponentName, ServiceRecord> services, ArrayList<ServiceRecord> result) {
        boolean didSomething = LOG_SERVICE_START_STOP;
        for (int i = 0; i < services.size(); i++) {
            ServiceRecord service = (ServiceRecord) services.valueAt(i);
            if ((name == null || service.packageName.equals(name)) && (service.app == null || evenPersistent || !service.app.persistent)) {
                if (!doit) {
                    return true;
                }
                didSomething = true;
                Slog.i(TAG, "  Force stopping service " + service);
                if (service.app != null) {
                    service.app.removed = true;
                    if (!service.app.persistent) {
                        service.app.services.remove(service);
                    }
                }
                service.app = null;
                service.isolatedProc = null;
                result.add(service);
            }
        }
        return didSomething;
    }

    boolean forceStopLocked(String name, int userId, boolean evenPersistent, boolean doit) {
        int i;
        boolean didSomething = LOG_SERVICE_START_STOP;
        ArrayList<ServiceRecord> services = new ArrayList();
        if (userId == -1) {
            for (i = 0; i < this.mServiceMap.size(); i++) {
                didSomething |= collectForceStopServicesLocked(name, userId, evenPersistent, doit, ((ServiceMap) this.mServiceMap.valueAt(i)).mServicesByName, services);
                if (!doit && didSomething) {
                    return true;
                }
            }
        } else {
            ServiceMap smap = (ServiceMap) this.mServiceMap.get(userId);
            if (smap != null) {
                didSomething = collectForceStopServicesLocked(name, userId, evenPersistent, doit, smap.mServicesByName, services);
            }
        }
        int N = services.size();
        for (i = 0; i < N; i++) {
            bringDownServiceLocked((ServiceRecord) services.get(i));
        }
        return didSomething;
    }

    void cleanUpRemovedTaskLocked(TaskRecord tr, ComponentName component, Intent baseIntent) {
        int i;
        ArrayList<ServiceRecord> services = new ArrayList();
        ArrayMap<ComponentName, ServiceRecord> alls = getServices(tr.userId);
        for (i = 0; i < alls.size(); i++) {
            ServiceRecord sr = (ServiceRecord) alls.valueAt(i);
            if (sr.packageName.equals(component.getPackageName())) {
                services.add(sr);
            }
        }
        for (i = 0; i < services.size(); i++) {
            sr = (ServiceRecord) services.get(i);
            if (sr.startRequested) {
                if ((sr.serviceInfo.flags & 1) != 0) {
                    Slog.i(TAG, "Stopping service " + sr.shortName + ": remove task");
                    stopServiceLocked(sr);
                } else {
                    sr.pendingStarts.add(new StartItem(sr, true, sr.makeNextStartId(), baseIntent, null));
                    if (!(sr.app == null || sr.app.thread == null)) {
                        sendServiceArgsLocked(sr, true, LOG_SERVICE_START_STOP);
                    }
                }
            }
        }
    }

    final void killServicesLocked(ProcessRecord app, boolean allowRestart) {
        int i;
        for (i = app.services.size() - 1; i >= 0; i--) {
            ServiceRecord sr = (ServiceRecord) app.services.valueAt(i);
            synchronized (sr.stats.getBatteryStats()) {
                sr.stats.stopLaunchedLocked();
            }
            ProcessRecord processRecord = sr.app;
            if (!(r0 == app || sr.app == null)) {
                if (!sr.app.persistent) {
                    sr.app.services.remove(sr);
                }
            }
            sr.app = null;
            sr.isolatedProc = null;
            sr.executeNesting = 0;
            sr.forceClearTracker();
            if (this.mDestroyingServices.remove(sr)) {
            } else {
            }
            for (int bindingi = sr.bindings.size() - 1; bindingi >= 0; bindingi--) {
                IntentBindRecord b = (IntentBindRecord) sr.bindings.valueAt(bindingi);
                b.binder = null;
                b.hasBound = LOG_SERVICE_START_STOP;
                b.received = LOG_SERVICE_START_STOP;
                b.requested = LOG_SERVICE_START_STOP;
                for (int appi = b.apps.size() - 1; appi >= 0; appi--) {
                    ProcessRecord proc = (ProcessRecord) b.apps.keyAt(appi);
                    if (!(proc.killedByAm || proc.thread == null)) {
                        AppBindRecord abind = (AppBindRecord) b.apps.valueAt(appi);
                        boolean hasCreate = LOG_SERVICE_START_STOP;
                        for (int conni = abind.connections.size() - 1; conni >= 0; conni--) {
                            if ((((ConnectionRecord) abind.connections.valueAt(conni)).flags & 49) == 1) {
                                hasCreate = true;
                                break;
                            }
                        }
                        if (hasCreate) {
                        }
                    }
                }
            }
        }
        for (i = app.connections.size() - 1; i >= 0; i--) {
            removeConnectionLocked((ConnectionRecord) app.connections.valueAt(i), app, null);
        }
        updateServiceConnectionActivitiesLocked(app);
        app.connections.clear();
        ServiceMap smap = getServiceMap(app.userId);
        for (i = app.services.size() - 1; i >= 0; i--) {
            sr = (ServiceRecord) app.services.valueAt(i);
            if (!app.persistent) {
                app.services.removeAt(i);
            }
            ServiceRecord curRec = (ServiceRecord) smap.mServicesByName.get(sr.name);
            if (curRec == sr) {
                if (allowRestart) {
                    int i2 = sr.crashCount;
                    if (r0 >= 2) {
                        if ((sr.serviceInfo.applicationInfo.flags & 8) == 0) {
                            Slog.w(TAG, "Service crashed " + sr.crashCount + " times, stopping: " + sr);
                            Object[] objArr = new Object[SERVICE_RESTART_DURATION_FACTOR];
                            objArr[0] = Integer.valueOf(sr.userId);
                            objArr[1] = Integer.valueOf(sr.crashCount);
                            objArr[2] = sr.shortName;
                            objArr[3] = Integer.valueOf(app.pid);
                            EventLog.writeEvent(EventLogTags.AM_SERVICE_CRASHED_TOO_MUCH, objArr);
                            bringDownServiceLocked(sr);
                        }
                    }
                }
                if (allowRestart) {
                    boolean canceled = scheduleServiceRestartLocked(sr, true);
                    if (sr.startRequested && (sr.stopIfKilled || canceled)) {
                        if (sr.pendingStarts.size() == 0) {
                            sr.startRequested = LOG_SERVICE_START_STOP;
                            if (sr.tracker != null) {
                                sr.tracker.setStarted(LOG_SERVICE_START_STOP, this.mAm.mProcessStats.getMemFactorLocked(), SystemClock.uptimeMillis());
                            }
                            if (!sr.hasAutoCreateConnections()) {
                                bringDownServiceLocked(sr);
                            }
                        }
                    }
                } else {
                    bringDownServiceLocked(sr);
                }
            } else if (curRec != null) {
                Slog.wtf(TAG, "Service " + sr + " in process " + app + " not same as in map: " + curRec);
            }
        }
        if (!allowRestart) {
            ServiceRecord r;
            app.services.clear();
            for (i = this.mRestartingServices.size() - 1; i >= 0; i--) {
                r = (ServiceRecord) this.mRestartingServices.get(i);
                if (r.processName.equals(app.processName) && r.serviceInfo.applicationInfo.uid == app.info.uid) {
                    this.mRestartingServices.remove(i);
                    clearRestartingIfNeededLocked(r);
                }
            }
            for (i = this.mPendingServices.size() - 1; i >= 0; i--) {
                r = (ServiceRecord) this.mPendingServices.get(i);
                if (r.processName.equals(app.processName) && r.serviceInfo.applicationInfo.uid == app.info.uid) {
                    this.mPendingServices.remove(i);
                }
            }
        }
        i = this.mDestroyingServices.size();
        while (i > 0) {
            i--;
            sr = (ServiceRecord) this.mDestroyingServices.get(i);
            processRecord = sr.app;
            if (r0 == app) {
                sr.forceClearTracker();
                this.mDestroyingServices.remove(i);
            }
        }
        app.executingServices.clear();
    }

    RunningServiceInfo makeRunningServiceInfoLocked(ServiceRecord r) {
        RunningServiceInfo info = new RunningServiceInfo();
        info.service = r.name;
        if (r.app != null) {
            info.pid = r.app.pid;
        }
        info.uid = r.appInfo.uid;
        info.process = r.processName;
        info.foreground = r.isForeground;
        info.activeSince = r.createTime;
        info.started = r.startRequested;
        info.clientCount = r.connections.size();
        info.crashCount = r.crashCount;
        info.lastActivityTime = r.lastActivity;
        if (r.isForeground) {
            info.flags |= 2;
        }
        if (r.startRequested) {
            info.flags |= 1;
        }
        if (r.app != null && r.app.pid == ActivityManagerService.MY_PID) {
            info.flags |= SERVICE_RESTART_DURATION_FACTOR;
        }
        if (r.app != null && r.app.persistent) {
            info.flags |= 8;
        }
        loop0:
        for (int conni = r.connections.size() - 1; conni >= 0; conni--) {
            ArrayList<ConnectionRecord> connl = (ArrayList) r.connections.valueAt(conni);
            for (int i = 0; i < connl.size(); i++) {
                ConnectionRecord conn = (ConnectionRecord) connl.get(i);
                if (conn.clientLabel != 0) {
                    info.clientPackage = conn.binding.client.info.packageName;
                    info.clientLabel = conn.clientLabel;
                    break loop0;
                }
            }
        }
        return info;
    }

    List<RunningServiceInfo> getRunningServiceInfoLocked(int maxNum, int flags) {
        ArrayList<RunningServiceInfo> res = new ArrayList();
        int uid = Binder.getCallingUid();
        long ident = Binder.clearCallingIdentity();
        try {
            ArrayMap<ComponentName, ServiceRecord> alls;
            int i;
            ServiceRecord r;
            RunningServiceInfo info;
            if (ActivityManager.checkUidPermission("android.permission.INTERACT_ACROSS_USERS_FULL", uid) == 0) {
                int[] users = this.mAm.getUsersLocked();
                for (int ui = 0; ui < users.length && res.size() < maxNum; ui++) {
                    alls = getServices(users[ui]);
                    for (i = 0; i < alls.size() && res.size() < maxNum; i++) {
                        res.add(makeRunningServiceInfoLocked((ServiceRecord) alls.valueAt(i)));
                    }
                }
                for (i = 0; i < this.mRestartingServices.size() && res.size() < maxNum; i++) {
                    r = (ServiceRecord) this.mRestartingServices.get(i);
                    info = makeRunningServiceInfoLocked(r);
                    info.restarting = r.nextRestartTime;
                    res.add(info);
                }
            } else {
                int userId = UserHandle.getUserId(uid);
                alls = getServices(userId);
                for (i = 0; i < alls.size() && res.size() < maxNum; i++) {
                    res.add(makeRunningServiceInfoLocked((ServiceRecord) alls.valueAt(i)));
                }
                for (i = 0; i < this.mRestartingServices.size() && res.size() < maxNum; i++) {
                    r = (ServiceRecord) this.mRestartingServices.get(i);
                    if (r.userId == userId) {
                        info = makeRunningServiceInfoLocked(r);
                        info.restarting = r.nextRestartTime;
                        res.add(info);
                    }
                }
            }
            Binder.restoreCallingIdentity(ident);
            return res;
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public PendingIntent getRunningServiceControlPanelLocked(ComponentName name) {
        ServiceRecord r = getServiceByName(name, UserHandle.getUserId(Binder.getCallingUid()));
        if (r != null) {
            for (int conni = r.connections.size() - 1; conni >= 0; conni--) {
                ArrayList<ConnectionRecord> conn = (ArrayList) r.connections.valueAt(conni);
                for (int i = 0; i < conn.size(); i++) {
                    if (((ConnectionRecord) conn.get(i)).clientIntent != null) {
                        return ((ConnectionRecord) conn.get(i)).clientIntent;
                    }
                }
            }
        }
        return null;
    }

    void serviceTimeout(ProcessRecord proc) {
        String anrMessage = null;
        synchronized (this.mAm) {
            if (proc.executingServices.size() == 0 || proc.thread == null) {
                return;
            }
            long maxTime = SystemClock.uptimeMillis() - ((long) (proc.execServicesFg ? SERVICE_TIMEOUT : SERVICE_BACKGROUND_TIMEOUT));
            ServiceRecord timeout = null;
            long nextTime = 0;
            for (int i = proc.executingServices.size() - 1; i >= 0; i--) {
                ServiceRecord sr = (ServiceRecord) proc.executingServices.valueAt(i);
                if (sr.executingStart < maxTime) {
                    timeout = sr;
                    break;
                }
                if (sr.executingStart > nextTime) {
                    nextTime = sr.executingStart;
                }
            }
            if (timeout == null || !this.mAm.mLruProcesses.contains(proc)) {
                Message msg = this.mAm.mHandler.obtainMessage(12);
                msg.obj = proc;
                this.mAm.mHandler.sendMessageAtTime(msg, proc.execServicesFg ? 20000 + nextTime : 200000 + nextTime);
            } else {
                Slog.w(TAG, "Timeout executing service: " + timeout);
                Writer sw = new StringWriter();
                PrintWriter fastPrintWriter = new FastPrintWriter(sw, LOG_SERVICE_START_STOP, DumpState.DUMP_PREFERRED_XML);
                fastPrintWriter.println(timeout);
                timeout.dump(fastPrintWriter, "    ");
                fastPrintWriter.close();
                this.mLastAnrDump = sw.toString();
                this.mAm.mHandler.removeCallbacks(this.mLastAnrDumpClearer);
                this.mAm.mHandler.postDelayed(this.mLastAnrDumpClearer, 7200000);
                anrMessage = "executing service " + timeout.shortName;
            }
            if (anrMessage != null) {
                this.mAm.appNotResponding(proc, null, null, LOG_SERVICE_START_STOP, anrMessage);
            }
        }
    }

    void scheduleServiceTimeoutLocked(ProcessRecord proc) {
        if (proc.executingServices.size() != 0 && proc.thread != null) {
            long now = SystemClock.uptimeMillis();
            Message msg = this.mAm.mHandler.obtainMessage(12);
            msg.obj = proc;
            this.mAm.mHandler.sendMessageAtTime(msg, proc.execServicesFg ? 20000 + now : 200000 + now);
        }
    }

    void dumpServicesLocked(FileDescriptor fd, PrintWriter pw, String[] args, int opti, boolean dumpAll, boolean dumpClient, String dumpPackage) {
        int i;
        boolean needSep = LOG_SERVICE_START_STOP;
        boolean printedAnything = LOG_SERVICE_START_STOP;
        ItemMatcher matcher = new ItemMatcher();
        matcher.build(args, opti);
        pw.println("ACTIVITY MANAGER SERVICES (dumpsys activity services)");
        if (this.mLastAnrDump != null) {
            pw.println("  Last ANR service:");
            pw.print(this.mLastAnrDump);
            pw.println();
        }
        loop0:
        for (int user : this.mAm.getUsersLocked()) {
            int si;
            ServiceRecord r;
            ServiceMap smap = getServiceMap(user);
            boolean printed = LOG_SERVICE_START_STOP;
            if (smap.mServicesByName.size() > 0) {
                long nowReal = SystemClock.elapsedRealtime();
                needSep = LOG_SERVICE_START_STOP;
                si = 0;
                while (true) {
                    if (si >= smap.mServicesByName.size()) {
                        break;
                    }
                    r = (ServiceRecord) smap.mServicesByName.valueAt(si);
                    if (matcher.match(r, r.name)) {
                        if (dumpPackage != null) {
                            if (!dumpPackage.equals(r.appInfo.packageName)) {
                                continue;
                            }
                        }
                        if (!printed) {
                            if (printedAnything) {
                                pw.println();
                            }
                            pw.println("  User " + user + " active services:");
                            printed = true;
                        }
                        printedAnything = true;
                        if (needSep) {
                            pw.println();
                        }
                        pw.print("  * ");
                        pw.println(r);
                        if (!dumpAll) {
                            pw.print("    app=");
                            pw.println(r.app);
                            pw.print("    created=");
                            TimeUtils.formatDuration(r.createTime, nowReal, pw);
                            pw.print(" started=");
                            pw.print(r.startRequested);
                            pw.print(" connections=");
                            pw.println(r.connections.size());
                            if (r.connections.size() > 0) {
                                pw.println("    Connections:");
                                int conni = 0;
                                while (true) {
                                    if (conni >= r.connections.size()) {
                                        break;
                                    }
                                    ArrayList<ConnectionRecord> clist = (ArrayList) r.connections.valueAt(conni);
                                    for (i = 0; i < clist.size(); i++) {
                                        String toShortString;
                                        ConnectionRecord conn = (ConnectionRecord) clist.get(i);
                                        pw.print("      ");
                                        pw.print(conn.binding.intent.intent.getIntent().toShortString(LOG_SERVICE_START_STOP, LOG_SERVICE_START_STOP, LOG_SERVICE_START_STOP, LOG_SERVICE_START_STOP));
                                        pw.print(" -> ");
                                        ProcessRecord proc = conn.binding.client;
                                        if (proc != null) {
                                            toShortString = proc.toShortString();
                                        } else {
                                            toShortString = "null";
                                        }
                                        pw.println(toShortString);
                                    }
                                    conni++;
                                }
                            }
                        } else {
                            r.dump(pw, "    ");
                            needSep = true;
                        }
                        if (dumpClient && r.app != null) {
                            if (r.app.thread != null) {
                                pw.println("    Client:");
                                pw.flush();
                                TransferPipe tp;
                                try {
                                    tp = new TransferPipe();
                                    r.app.thread.dumpService(tp.getWriteFd().getFileDescriptor(), r, args);
                                    tp.setBufferPrefix("      ");
                                    tp.go(fd, 2000);
                                    tp.kill();
                                } catch (IOException e) {
                                    try {
                                        pw.println("      Failure while dumping the service: " + e);
                                    } catch (Exception e2) {
                                        Slog.w(TAG, "Exception in dumpServicesLocked", e2);
                                    }
                                } catch (RemoteException e3) {
                                    pw.println("      Got a RemoteException while dumping the service");
                                } catch (Throwable th) {
                                    break loop0;
                                    tp.kill();
                                }
                                needSep = true;
                            } else {
                                continue;
                            }
                        }
                    }
                    si++;
                }
                needSep |= printed;
            }
            printed = LOG_SERVICE_START_STOP;
            int SN = smap.mDelayedStartList.size();
            for (si = 0; si < SN; si++) {
                r = (ServiceRecord) smap.mDelayedStartList.get(si);
                if (matcher.match(r, r.name)) {
                    if (dumpPackage != null) {
                        if (!dumpPackage.equals(r.appInfo.packageName)) {
                        }
                    }
                    if (!printed) {
                        if (printedAnything) {
                            pw.println();
                        }
                        pw.println("  User " + user + " delayed start services:");
                        printed = true;
                    }
                    printedAnything = true;
                    pw.print("  * Delayed start ");
                    pw.println(r);
                }
            }
            printed = LOG_SERVICE_START_STOP;
            SN = smap.mStartingBackground.size();
            for (si = 0; si < SN; si++) {
                r = (ServiceRecord) smap.mStartingBackground.get(si);
                if (matcher.match(r, r.name)) {
                    if (dumpPackage != null) {
                        if (!dumpPackage.equals(r.appInfo.packageName)) {
                        }
                    }
                    if (!printed) {
                        if (printedAnything) {
                            pw.println();
                        }
                        pw.println("  User " + user + " starting in background:");
                        printed = true;
                    }
                    printedAnything = true;
                    pw.print("  * Starting bg ");
                    pw.println(r);
                }
            }
        }
        if (this.mPendingServices.size() > 0) {
            printed = LOG_SERVICE_START_STOP;
            i = 0;
            while (true) {
                if (i >= this.mPendingServices.size()) {
                    break;
                }
                r = (ServiceRecord) this.mPendingServices.get(i);
                if (matcher.match(r, r.name)) {
                    if (dumpPackage != null) {
                        if (!dumpPackage.equals(r.appInfo.packageName)) {
                        }
                    }
                    printedAnything = true;
                    if (!printed) {
                        if (needSep) {
                            pw.println();
                        }
                        needSep = true;
                        pw.println("  Pending services:");
                        printed = true;
                    }
                    pw.print("  * Pending ");
                    pw.println(r);
                    r.dump(pw, "    ");
                }
                i++;
            }
            needSep = true;
        }
        if (this.mRestartingServices.size() > 0) {
            printed = LOG_SERVICE_START_STOP;
            i = 0;
            while (true) {
                if (i >= this.mRestartingServices.size()) {
                    break;
                }
                r = (ServiceRecord) this.mRestartingServices.get(i);
                if (matcher.match(r, r.name)) {
                    if (dumpPackage != null) {
                        if (!dumpPackage.equals(r.appInfo.packageName)) {
                        }
                    }
                    printedAnything = true;
                    if (!printed) {
                        if (needSep) {
                            pw.println();
                        }
                        needSep = true;
                        pw.println("  Restarting services:");
                        printed = true;
                    }
                    pw.print("  * Restarting ");
                    pw.println(r);
                    r.dump(pw, "    ");
                }
                i++;
            }
            needSep = true;
        }
        if (this.mDestroyingServices.size() > 0) {
            printed = LOG_SERVICE_START_STOP;
            i = 0;
            while (true) {
                if (i >= this.mDestroyingServices.size()) {
                    break;
                }
                r = (ServiceRecord) this.mDestroyingServices.get(i);
                if (matcher.match(r, r.name)) {
                    if (dumpPackage != null) {
                        if (!dumpPackage.equals(r.appInfo.packageName)) {
                        }
                    }
                    printedAnything = true;
                    if (!printed) {
                        if (needSep) {
                            pw.println();
                        }
                        needSep = true;
                        pw.println("  Destroying services:");
                        printed = true;
                    }
                    pw.print("  * Destroy ");
                    pw.println(r);
                    r.dump(pw, "    ");
                }
                i++;
            }
            needSep = true;
        }
        if (dumpAll) {
            printed = LOG_SERVICE_START_STOP;
            int ic = 0;
            while (true) {
                if (ic >= this.mServiceConnections.size()) {
                    break;
                }
                ArrayList<ConnectionRecord> r2 = (ArrayList) this.mServiceConnections.valueAt(ic);
                for (i = 0; i < r2.size(); i++) {
                    ConnectionRecord cr = (ConnectionRecord) r2.get(i);
                    if (matcher.match(cr.binding.service, cr.binding.service.name)) {
                        if (dumpPackage != null) {
                            if (cr.binding.client != null) {
                                if (!dumpPackage.equals(cr.binding.client.info.packageName)) {
                                }
                            }
                        }
                        printedAnything = true;
                        if (!printed) {
                            if (needSep) {
                                pw.println();
                            }
                            needSep = true;
                            pw.println("  Connection bindings to services:");
                            printed = true;
                        }
                        pw.print("  * ");
                        pw.println(cr);
                        cr.dump(pw, "    ");
                    }
                }
                ic++;
            }
        }
        if (!printedAnything) {
            pw.println("  (nothing)");
        }
    }

    protected boolean dumpService(FileDescriptor fd, PrintWriter pw, String name, String[] args, int opti, boolean dumpAll) {
        int i;
        ArrayList<ServiceRecord> services = new ArrayList();
        synchronized (this.mAm) {
            int[] users = this.mAm.getUsersLocked();
            ServiceMap smap;
            ArrayMap<ComponentName, ServiceRecord> alls;
            if ("all".equals(name)) {
                for (int user : users) {
                    smap = (ServiceMap) this.mServiceMap.get(user);
                    if (smap != null) {
                        alls = smap.mServicesByName;
                        for (i = 0; i < alls.size(); i++) {
                            services.add((ServiceRecord) alls.valueAt(i));
                        }
                    }
                }
            } else {
                ComponentName componentName = name != null ? ComponentName.unflattenFromString(name) : null;
                int objectId = 0;
                if (componentName == null) {
                    try {
                        objectId = Integer.parseInt(name, 16);
                        name = null;
                        componentName = null;
                    } catch (RuntimeException e) {
                    }
                }
                for (int user2 : users) {
                    smap = (ServiceMap) this.mServiceMap.get(user2);
                    if (smap != null) {
                        alls = smap.mServicesByName;
                        for (i = 0; i < alls.size(); i++) {
                            ServiceRecord r1 = (ServiceRecord) alls.valueAt(i);
                            if (componentName != null) {
                                if (r1.name.equals(componentName)) {
                                    services.add(r1);
                                }
                            } else if (name != null) {
                                if (r1.name.flattenToString().contains(name)) {
                                    services.add(r1);
                                }
                            } else if (System.identityHashCode(r1) == objectId) {
                                services.add(r1);
                            }
                        }
                        continue;
                    }
                }
            }
        }
        if (services.size() <= 0) {
            return LOG_SERVICE_START_STOP;
        }
        boolean needSep = LOG_SERVICE_START_STOP;
        for (i = 0; i < services.size(); i++) {
            if (needSep) {
                pw.println();
            }
            needSep = true;
            dumpService("", fd, pw, (ServiceRecord) services.get(i), args, dumpAll);
        }
        return true;
    }

    private void dumpService(String prefix, FileDescriptor fd, PrintWriter pw, ServiceRecord r, String[] args, boolean dumpAll) {
        String innerPrefix = prefix + "  ";
        synchronized (this.mAm) {
            pw.print(prefix);
            pw.print("SERVICE ");
            pw.print(r.shortName);
            pw.print(" ");
            pw.print(Integer.toHexString(System.identityHashCode(r)));
            pw.print(" pid=");
            if (r.app != null) {
                pw.println(r.app.pid);
            } else {
                pw.println("(not running)");
            }
            if (dumpAll) {
                r.dump(pw, innerPrefix);
            }
        }
        if (r.app != null && r.app.thread != null) {
            pw.print(prefix);
            pw.println("  Client:");
            pw.flush();
            TransferPipe tp;
            try {
                tp = new TransferPipe();
                r.app.thread.dumpService(tp.getWriteFd().getFileDescriptor(), r, args);
                tp.setBufferPrefix(prefix + "    ");
                tp.go(fd);
                tp.kill();
            } catch (IOException e) {
                pw.println(prefix + "    Failure while dumping the service: " + e);
            } catch (RemoteException e2) {
                pw.println(prefix + "    Got a RemoteException while dumping the service");
            } catch (Throwable th) {
                tp.kill();
            }
        }
    }
}
