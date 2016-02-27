package com.android.server.storage;

import android.app.Notification;
import android.app.Notification.BigTextStyle;
import android.app.Notification.Builder;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.IPackageDataObserver.Stub;
import android.content.pm.IPackageManager;
import android.os.Binder;
import android.os.Environment;
import android.os.FileObserver;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.StatFs;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.storage.StorageManager;
import android.text.format.Formatter;
import android.util.EventLog;
import android.util.Slog;
import android.util.TimeUtils;
import com.android.server.EventLogTags;
import com.android.server.SystemService;
import com.android.server.location.LocationFudger;
import com.android.server.pm.PackageManagerService;
import dalvik.system.VMRuntime;
import java.io.File;
import java.io.FileDescriptor;
import java.io.PrintWriter;

public class DeviceStorageMonitorService extends SystemService {
    private static final File CACHE_PATH;
    private static final File DATA_PATH;
    static final boolean DEBUG = false;
    private static final long DEFAULT_CHECK_INTERVAL = 60000;
    private static final long DEFAULT_DISK_FREE_CHANGE_REPORTING_THRESHOLD = 2097152;
    private static final int DEFAULT_FREE_STORAGE_LOG_INTERVAL_IN_MINUTES = 720;
    static final int DEVICE_MEMORY_WHAT = 1;
    private static final int LOW_MEMORY_NOTIFICATION_ID = 1;
    private static final int MONITOR_INTERVAL = 1;
    static final String SERVICE = "devicestoragemonitor";
    private static final File SYSTEM_PATH;
    static final String TAG = "DeviceStorageMonitorService";
    private static final int _FALSE = 0;
    private static final int _TRUE = 1;
    static final boolean localLOGV = false;
    private CacheFileDeletedObserver mCacheFileDeletedObserver;
    private final StatFs mCacheFileStats;
    private CachePackageDataObserver mClearCacheObserver;
    boolean mClearSucceeded;
    boolean mClearingCache;
    private final StatFs mDataFileStats;
    private long mFreeMem;
    private long mFreeMemAfterLastCacheClear;
    private final Handler mHandler;
    private final boolean mIsBootImageOnDisk;
    private long mLastReportedFreeMem;
    private long mLastReportedFreeMemTime;
    private final DeviceStorageMonitorInternal mLocalService;
    boolean mLowMemFlag;
    private long mMemCacheStartTrimThreshold;
    private long mMemCacheTrimToThreshold;
    private boolean mMemFullFlag;
    private long mMemFullThreshold;
    long mMemLowThreshold;
    private final IBinder mRemoteService;
    private final ContentResolver mResolver;
    private final Intent mStorageFullIntent;
    private final Intent mStorageLowIntent;
    private final Intent mStorageNotFullIntent;
    private final Intent mStorageOkIntent;
    private final StatFs mSystemFileStats;
    private long mThreadStartTime;
    private final long mTotalMemory;

    /* renamed from: com.android.server.storage.DeviceStorageMonitorService.1 */
    class C05131 extends Handler {
        C05131() {
        }

        public void handleMessage(Message msg) {
            boolean z = true;
            if (msg.what != DeviceStorageMonitorService._TRUE) {
                Slog.e(DeviceStorageMonitorService.TAG, "Will not process invalid message");
                return;
            }
            DeviceStorageMonitorService deviceStorageMonitorService = DeviceStorageMonitorService.this;
            if (msg.arg1 != DeviceStorageMonitorService._TRUE) {
                z = DeviceStorageMonitorService.DEBUG;
            }
            deviceStorageMonitorService.checkMemory(z);
        }
    }

    /* renamed from: com.android.server.storage.DeviceStorageMonitorService.2 */
    class C05142 implements DeviceStorageMonitorInternal {
        C05142() {
        }

        public void checkMemory() {
            DeviceStorageMonitorService.this.postCheckMemoryMsg(true, 0);
        }

        public boolean isMemoryLow() {
            return (DeviceStorageMonitorService.this.mLowMemFlag || !DeviceStorageMonitorService.this.mIsBootImageOnDisk) ? true : DeviceStorageMonitorService.DEBUG;
        }

        public long getMemoryLowThreshold() {
            return DeviceStorageMonitorService.this.mMemLowThreshold;
        }
    }

    /* renamed from: com.android.server.storage.DeviceStorageMonitorService.3 */
    class C05153 extends Binder {
        C05153() {
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (DeviceStorageMonitorService.this.getContext().checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump devicestoragemonitor from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            } else {
                DeviceStorageMonitorService.this.dumpImpl(pw);
            }
        }
    }

    private static class CacheFileDeletedObserver extends FileObserver {
        public CacheFileDeletedObserver() {
            super(Environment.getDownloadCacheDirectory().getAbsolutePath(), DumpState.DUMP_PREFERRED);
        }

        public void onEvent(int event, String path) {
            EventLogTags.writeCacheFileDeleted(path);
        }
    }

    private class CachePackageDataObserver extends Stub {
        private CachePackageDataObserver() {
        }

        public void onRemoveCompleted(String packageName, boolean succeeded) {
            DeviceStorageMonitorService.this.mClearSucceeded = succeeded;
            DeviceStorageMonitorService.this.mClearingCache = DeviceStorageMonitorService.DEBUG;
            DeviceStorageMonitorService.this.postCheckMemoryMsg(DeviceStorageMonitorService.DEBUG, 0);
        }
    }

    static {
        DATA_PATH = Environment.getDataDirectory();
        SYSTEM_PATH = Environment.getRootDirectory();
        CACHE_PATH = Environment.getDownloadCacheDirectory();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void restatDataDir() {
        /*
        r22 = this;
        r0 = r22;
        r7 = r0.mDataFileStats;	 Catch:{ IllegalArgumentException -> 0x0147 }
        r18 = DATA_PATH;	 Catch:{ IllegalArgumentException -> 0x0147 }
        r18 = r18.getAbsolutePath();	 Catch:{ IllegalArgumentException -> 0x0147 }
        r0 = r18;
        r7.restat(r0);	 Catch:{ IllegalArgumentException -> 0x0147 }
        r0 = r22;
        r7 = r0.mDataFileStats;	 Catch:{ IllegalArgumentException -> 0x0147 }
        r7 = r7.getAvailableBlocks();	 Catch:{ IllegalArgumentException -> 0x0147 }
        r0 = (long) r7;	 Catch:{ IllegalArgumentException -> 0x0147 }
        r18 = r0;
        r0 = r22;
        r7 = r0.mDataFileStats;	 Catch:{ IllegalArgumentException -> 0x0147 }
        r7 = r7.getBlockSize();	 Catch:{ IllegalArgumentException -> 0x0147 }
        r0 = (long) r7;	 Catch:{ IllegalArgumentException -> 0x0147 }
        r20 = r0;
        r18 = r18 * r20;
        r0 = r18;
        r2 = r22;
        r2.mFreeMem = r0;	 Catch:{ IllegalArgumentException -> 0x0147 }
    L_0x002d:
        r7 = "debug.freemem";
        r6 = android.os.SystemProperties.get(r7);
        r7 = "";
        r7 = r7.equals(r6);
        if (r7 != 0) goto L_0x0045;
    L_0x003b:
        r18 = java.lang.Long.parseLong(r6);
        r0 = r18;
        r2 = r22;
        r2.mFreeMem = r0;
    L_0x0045:
        r0 = r22;
        r7 = r0.mResolver;
        r18 = "sys_free_storage_log_interval";
        r20 = 720; // 0x2d0 float:1.009E-42 double:3.557E-321;
        r0 = r18;
        r1 = r20;
        r18 = android.provider.Settings.Global.getLong(r7, r0, r1);
        r20 = 60;
        r18 = r18 * r20;
        r20 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r10 = r18 * r20;
        r4 = android.os.SystemClock.elapsedRealtime();
        r0 = r22;
        r0 = r0.mLastReportedFreeMemTime;
        r18 = r0;
        r20 = 0;
        r7 = (r18 > r20 ? 1 : (r18 == r20 ? 0 : -1));
        if (r7 == 0) goto L_0x0079;
    L_0x006d:
        r0 = r22;
        r0 = r0.mLastReportedFreeMemTime;
        r18 = r0;
        r18 = r4 - r18;
        r7 = (r18 > r10 ? 1 : (r18 == r10 ? 0 : -1));
        if (r7 < 0) goto L_0x00fc;
    L_0x0079:
        r0 = r22;
        r0.mLastReportedFreeMemTime = r4;
        r14 = -1;
        r12 = -1;
        r0 = r22;
        r7 = r0.mSystemFileStats;	 Catch:{ IllegalArgumentException -> 0x0144 }
        r18 = SYSTEM_PATH;	 Catch:{ IllegalArgumentException -> 0x0144 }
        r18 = r18.getAbsolutePath();	 Catch:{ IllegalArgumentException -> 0x0144 }
        r0 = r18;
        r7.restat(r0);	 Catch:{ IllegalArgumentException -> 0x0144 }
        r0 = r22;
        r7 = r0.mSystemFileStats;	 Catch:{ IllegalArgumentException -> 0x0144 }
        r7 = r7.getAvailableBlocks();	 Catch:{ IllegalArgumentException -> 0x0144 }
        r0 = (long) r7;	 Catch:{ IllegalArgumentException -> 0x0144 }
        r18 = r0;
        r0 = r22;
        r7 = r0.mSystemFileStats;	 Catch:{ IllegalArgumentException -> 0x0144 }
        r7 = r7.getBlockSize();	 Catch:{ IllegalArgumentException -> 0x0144 }
        r0 = (long) r7;
        r20 = r0;
        r14 = r18 * r20;
    L_0x00a8:
        r0 = r22;
        r7 = r0.mCacheFileStats;	 Catch:{ IllegalArgumentException -> 0x0142 }
        r18 = CACHE_PATH;	 Catch:{ IllegalArgumentException -> 0x0142 }
        r18 = r18.getAbsolutePath();	 Catch:{ IllegalArgumentException -> 0x0142 }
        r0 = r18;
        r7.restat(r0);	 Catch:{ IllegalArgumentException -> 0x0142 }
        r0 = r22;
        r7 = r0.mCacheFileStats;	 Catch:{ IllegalArgumentException -> 0x0142 }
        r7 = r7.getAvailableBlocks();	 Catch:{ IllegalArgumentException -> 0x0142 }
        r0 = (long) r7;	 Catch:{ IllegalArgumentException -> 0x0142 }
        r18 = r0;
        r0 = r22;
        r7 = r0.mCacheFileStats;	 Catch:{ IllegalArgumentException -> 0x0142 }
        r7 = r7.getBlockSize();	 Catch:{ IllegalArgumentException -> 0x0142 }
        r0 = (long) r7;
        r20 = r0;
        r12 = r18 * r20;
    L_0x00cf:
        r7 = 2746; // 0xaba float:3.848E-42 double:1.3567E-320;
        r18 = 3;
        r0 = r18;
        r0 = new java.lang.Object[r0];
        r18 = r0;
        r19 = 0;
        r0 = r22;
        r0 = r0.mFreeMem;
        r20 = r0;
        r20 = java.lang.Long.valueOf(r20);
        r18[r19] = r20;
        r19 = 1;
        r20 = java.lang.Long.valueOf(r14);
        r18[r19] = r20;
        r19 = 2;
        r20 = java.lang.Long.valueOf(r12);
        r18[r19] = r20;
        r0 = r18;
        android.util.EventLog.writeEvent(r7, r0);
    L_0x00fc:
        r0 = r22;
        r7 = r0.mResolver;
        r18 = "disk_free_change_reporting_threshold";
        r20 = 2097152; // 0x200000 float:2.938736E-39 double:1.0361308E-317;
        r0 = r18;
        r1 = r20;
        r16 = android.provider.Settings.Global.getLong(r7, r0, r1);
        r0 = r22;
        r0 = r0.mFreeMem;
        r18 = r0;
        r0 = r22;
        r0 = r0.mLastReportedFreeMem;
        r20 = r0;
        r8 = r18 - r20;
        r7 = (r8 > r16 ? 1 : (r8 == r16 ? 0 : -1));
        if (r7 > 0) goto L_0x0128;
    L_0x011f:
        r0 = r16;
        r0 = -r0;
        r18 = r0;
        r7 = (r8 > r18 ? 1 : (r8 == r18 ? 0 : -1));
        if (r7 >= 0) goto L_0x0141;
    L_0x0128:
        r0 = r22;
        r0 = r0.mFreeMem;
        r18 = r0;
        r0 = r18;
        r2 = r22;
        r2.mLastReportedFreeMem = r0;
        r7 = 2744; // 0xab8 float:3.845E-42 double:1.3557E-320;
        r0 = r22;
        r0 = r0.mFreeMem;
        r18 = r0;
        r0 = r18;
        android.util.EventLog.writeEvent(r7, r0);
    L_0x0141:
        return;
    L_0x0142:
        r7 = move-exception;
        goto L_0x00cf;
    L_0x0144:
        r7 = move-exception;
        goto L_0x00a8;
    L_0x0147:
        r7 = move-exception;
        goto L_0x002d;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.storage.DeviceStorageMonitorService.restatDataDir():void");
    }

    private void clearCache() {
        if (this.mClearCacheObserver == null) {
            this.mClearCacheObserver = new CachePackageDataObserver();
        }
        this.mClearingCache = true;
        try {
            IPackageManager.Stub.asInterface(ServiceManager.getService("package")).freeStorageAndNotify(this.mMemCacheTrimToThreshold, this.mClearCacheObserver);
        } catch (RemoteException e) {
            Slog.w(TAG, "Failed to get handle for PackageManger Exception: " + e);
            this.mClearingCache = DEBUG;
            this.mClearSucceeded = DEBUG;
        }
    }

    void checkMemory(boolean checkCache) {
        if (!this.mClearingCache) {
            restatDataDir();
            if (this.mFreeMem >= this.mMemLowThreshold) {
                this.mFreeMemAfterLastCacheClear = this.mFreeMem;
                if (this.mLowMemFlag) {
                    Slog.i(TAG, "Memory available. Cancelling notification");
                    cancelNotification();
                    this.mLowMemFlag = DEBUG;
                }
            } else if (!checkCache) {
                this.mFreeMemAfterLastCacheClear = this.mFreeMem;
                if (!this.mLowMemFlag) {
                    Slog.i(TAG, "Running low on memory. Sending notification");
                    sendNotification();
                    this.mLowMemFlag = true;
                }
            } else if (this.mFreeMem < this.mMemCacheStartTrimThreshold && this.mFreeMemAfterLastCacheClear - this.mFreeMem >= (this.mMemLowThreshold - this.mMemCacheStartTrimThreshold) / 4) {
                this.mThreadStartTime = System.currentTimeMillis();
                this.mClearSucceeded = DEBUG;
                clearCache();
            }
            if (!(this.mLowMemFlag || this.mIsBootImageOnDisk)) {
                Slog.i(TAG, "No boot image on disk due to lack of space. Sending notification");
                sendNotification();
            }
            if (this.mFreeMem < this.mMemFullThreshold) {
                if (!this.mMemFullFlag) {
                    sendFullNotification();
                    this.mMemFullFlag = true;
                }
            } else if (this.mMemFullFlag) {
                cancelFullNotification();
                this.mMemFullFlag = DEBUG;
            }
        } else if (System.currentTimeMillis() - this.mThreadStartTime > LocationFudger.FASTEST_INTERVAL_MS) {
            Slog.w(TAG, "Thread that clears cache file seems to run for ever");
        }
        postCheckMemoryMsg(true, DEFAULT_CHECK_INTERVAL);
    }

    void postCheckMemoryMsg(boolean clearCache, long delay) {
        int i;
        this.mHandler.removeMessages(_TRUE);
        Handler handler = this.mHandler;
        Handler handler2 = this.mHandler;
        if (clearCache) {
            i = _TRUE;
        } else {
            i = _FALSE;
        }
        handler.sendMessageDelayed(handler2.obtainMessage(_TRUE, i, _FALSE), delay);
    }

    public DeviceStorageMonitorService(Context context) {
        super(context);
        this.mLowMemFlag = DEBUG;
        this.mMemFullFlag = DEBUG;
        this.mThreadStartTime = -1;
        this.mClearSucceeded = DEBUG;
        this.mHandler = new C05131();
        this.mLocalService = new C05142();
        this.mRemoteService = new C05153();
        this.mLastReportedFreeMemTime = 0;
        this.mResolver = context.getContentResolver();
        this.mIsBootImageOnDisk = isBootImageOnDisk();
        this.mDataFileStats = new StatFs(DATA_PATH.getAbsolutePath());
        this.mSystemFileStats = new StatFs(SYSTEM_PATH.getAbsolutePath());
        this.mCacheFileStats = new StatFs(CACHE_PATH.getAbsolutePath());
        this.mTotalMemory = ((long) this.mDataFileStats.getBlockCount()) * ((long) this.mDataFileStats.getBlockSize());
        this.mStorageLowIntent = new Intent("android.intent.action.DEVICE_STORAGE_LOW");
        this.mStorageLowIntent.addFlags(67108864);
        this.mStorageOkIntent = new Intent("android.intent.action.DEVICE_STORAGE_OK");
        this.mStorageOkIntent.addFlags(67108864);
        this.mStorageFullIntent = new Intent("android.intent.action.DEVICE_STORAGE_FULL");
        this.mStorageFullIntent.addFlags(67108864);
        this.mStorageNotFullIntent = new Intent("android.intent.action.DEVICE_STORAGE_NOT_FULL");
        this.mStorageNotFullIntent.addFlags(67108864);
    }

    private static boolean isBootImageOnDisk() {
        String[] arr$ = PackageManagerService.getAllDexCodeInstructionSets();
        int len$ = arr$.length;
        for (int i$ = _FALSE; i$ < len$; i$ += _TRUE) {
            if (!VMRuntime.isBootClassPathOnDisk(arr$[i$])) {
                return DEBUG;
            }
        }
        return true;
    }

    public void onStart() {
        StorageManager sm = StorageManager.from(getContext());
        this.mMemLowThreshold = sm.getStorageLowBytes(DATA_PATH);
        this.mMemFullThreshold = sm.getStorageFullBytes(DATA_PATH);
        this.mMemCacheStartTrimThreshold = ((this.mMemLowThreshold * 3) + this.mMemFullThreshold) / 4;
        this.mMemCacheTrimToThreshold = this.mMemLowThreshold + ((this.mMemLowThreshold - this.mMemCacheStartTrimThreshold) * 2);
        this.mFreeMemAfterLastCacheClear = this.mTotalMemory;
        checkMemory(true);
        this.mCacheFileDeletedObserver = new CacheFileDeletedObserver();
        this.mCacheFileDeletedObserver.startWatching();
        publishBinderService(SERVICE, this.mRemoteService);
        publishLocalService(DeviceStorageMonitorInternal.class, this.mLocalService);
    }

    void dumpImpl(PrintWriter pw) {
        Context context = getContext();
        pw.println("Current DeviceStorageMonitor state:");
        pw.print("  mFreeMem=");
        pw.print(Formatter.formatFileSize(context, this.mFreeMem));
        pw.print(" mTotalMemory=");
        pw.println(Formatter.formatFileSize(context, this.mTotalMemory));
        pw.print("  mFreeMemAfterLastCacheClear=");
        pw.println(Formatter.formatFileSize(context, this.mFreeMemAfterLastCacheClear));
        pw.print("  mLastReportedFreeMem=");
        pw.print(Formatter.formatFileSize(context, this.mLastReportedFreeMem));
        pw.print(" mLastReportedFreeMemTime=");
        TimeUtils.formatDuration(this.mLastReportedFreeMemTime, SystemClock.elapsedRealtime(), pw);
        pw.println();
        pw.print("  mLowMemFlag=");
        pw.print(this.mLowMemFlag);
        pw.print(" mMemFullFlag=");
        pw.println(this.mMemFullFlag);
        pw.print(" mIsBootImageOnDisk=");
        pw.print(this.mIsBootImageOnDisk);
        pw.print("  mClearSucceeded=");
        pw.print(this.mClearSucceeded);
        pw.print(" mClearingCache=");
        pw.println(this.mClearingCache);
        pw.print("  mMemLowThreshold=");
        pw.print(Formatter.formatFileSize(context, this.mMemLowThreshold));
        pw.print(" mMemFullThreshold=");
        pw.println(Formatter.formatFileSize(context, this.mMemFullThreshold));
        pw.print("  mMemCacheStartTrimThreshold=");
        pw.print(Formatter.formatFileSize(context, this.mMemCacheStartTrimThreshold));
        pw.print(" mMemCacheTrimToThreshold=");
        pw.println(Formatter.formatFileSize(context, this.mMemCacheTrimToThreshold));
    }

    private void sendNotification() {
        Context context = getContext();
        EventLog.writeEvent(EventLogTags.LOW_STORAGE, this.mFreeMem);
        Intent lowMemIntent = new Intent(Environment.isExternalStorageEmulated() ? "android.settings.INTERNAL_STORAGE_SETTINGS" : "android.intent.action.MANAGE_PACKAGE_STORAGE");
        lowMemIntent.putExtra("memory", this.mFreeMem);
        lowMemIntent.addFlags(268435456);
        NotificationManager mNotificationMgr = (NotificationManager) context.getSystemService("notification");
        CharSequence title = context.getText(17040503);
        CharSequence details = context.getText(this.mIsBootImageOnDisk ? 17040504 : 17040505);
        Notification notification = new Builder(context).setSmallIcon(17303114).setTicker(title).setColor(context.getResources().getColor(17170521)).setContentTitle(title).setContentText(details).setContentIntent(PendingIntent.getActivityAsUser(context, _FALSE, lowMemIntent, _FALSE, null, UserHandle.CURRENT)).setStyle(new BigTextStyle().bigText(details)).setVisibility(_TRUE).setCategory("sys").build();
        notification.flags |= 32;
        mNotificationMgr.notifyAsUser(null, _TRUE, notification, UserHandle.ALL);
        context.sendStickyBroadcastAsUser(this.mStorageLowIntent, UserHandle.ALL);
    }

    private void cancelNotification() {
        Context context = getContext();
        ((NotificationManager) context.getSystemService("notification")).cancelAsUser(null, _TRUE, UserHandle.ALL);
        context.removeStickyBroadcastAsUser(this.mStorageLowIntent, UserHandle.ALL);
        context.sendBroadcastAsUser(this.mStorageOkIntent, UserHandle.ALL);
    }

    private void sendFullNotification() {
        getContext().sendStickyBroadcastAsUser(this.mStorageFullIntent, UserHandle.ALL);
    }

    private void cancelFullNotification() {
        getContext().removeStickyBroadcastAsUser(this.mStorageFullIntent, UserHandle.ALL);
        getContext().sendBroadcastAsUser(this.mStorageNotFullIntent, UserHandle.ALL);
    }
}
