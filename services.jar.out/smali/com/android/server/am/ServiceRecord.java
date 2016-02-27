package com.android.server.am;

import android.app.INotificationManager;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.Intent.FilterComparison;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ServiceInfo;
import android.net.Uri;
import android.os.Binder;
import android.os.IBinder;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.util.ArrayMap;
import android.util.Slog;
import android.util.TimeUtils;
import com.android.internal.app.ProcessStats.ServiceState;
import com.android.internal.os.BatteryStatsImpl.Uid.Pkg.Serv;
import com.android.server.LocalServices;
import com.android.server.notification.NotificationManagerInternal;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

final class ServiceRecord extends Binder {
    static final int MAX_DELIVERY_COUNT = 3;
    static final int MAX_DONE_EXECUTING_COUNT = 6;
    final ActivityManagerService ams;
    ProcessRecord app;
    final ApplicationInfo appInfo;
    final ArrayMap<FilterComparison, IntentBindRecord> bindings;
    boolean callStart;
    final ArrayMap<IBinder, ArrayList<ConnectionRecord>> connections;
    int crashCount;
    final long createTime;
    boolean createdFromFg;
    boolean delayed;
    boolean delayedStop;
    final ArrayList<StartItem> deliveredStarts;
    long destroyTime;
    boolean destroying;
    boolean executeFg;
    int executeNesting;
    long executingStart;
    final boolean exported;
    int foregroundId;
    Notification foregroundNoti;
    final FilterComparison intent;
    boolean isForeground;
    ProcessRecord isolatedProc;
    long lastActivity;
    private int lastStartId;
    final ComponentName name;
    long nextRestartTime;
    final String packageName;
    final ArrayList<StartItem> pendingStarts;
    final String permission;
    final String processName;
    int restartCount;
    long restartDelay;
    long restartTime;
    ServiceState restartTracker;
    final Runnable restarter;
    final ServiceInfo serviceInfo;
    final String shortName;
    boolean startRequested;
    long startingBgTimeout;
    final Serv stats;
    boolean stopIfKilled;
    String stringName;
    int totalRestartCount;
    ServiceState tracker;
    final int userId;

    /* renamed from: com.android.server.am.ServiceRecord.1 */
    class C01471 implements Runnable {
        final /* synthetic */ int val$appPid;
        final /* synthetic */ int val$appUid;
        final /* synthetic */ int val$localForegroundId;
        final /* synthetic */ Notification val$localForegroundNoti;
        final /* synthetic */ String val$localPackageName;

        C01471(Notification notification, String str, int i, int i2, int i3) {
            this.val$localForegroundNoti = notification;
            this.val$localPackageName = str;
            this.val$appUid = i;
            this.val$appPid = i2;
            this.val$localForegroundId = i3;
        }

        public void run() {
            NotificationManagerInternal nm = (NotificationManagerInternal) LocalServices.getService(NotificationManagerInternal.class);
            if (nm != null) {
                try {
                    if (this.val$localForegroundNoti.icon == 0) {
                        this.val$localForegroundNoti.icon = ServiceRecord.this.appInfo.icon;
                        this.val$localForegroundNoti.contentView = null;
                        this.val$localForegroundNoti.bigContentView = null;
                        CharSequence appName = ServiceRecord.this.appInfo.loadLabel(ServiceRecord.this.ams.mContext.getPackageManager());
                        if (appName == null) {
                            appName = ServiceRecord.this.appInfo.packageName;
                        }
                        try {
                            Context ctx = ServiceRecord.this.ams.mContext.createPackageContext(ServiceRecord.this.appInfo.packageName, 0);
                            Intent runningIntent = new Intent("android.settings.APPLICATION_DETAILS_SETTINGS");
                            runningIntent.setData(Uri.fromParts("package", ServiceRecord.this.appInfo.packageName, null));
                            PendingIntent pi = PendingIntent.getActivity(ServiceRecord.this.ams.mContext, 0, runningIntent, 134217728);
                            this.val$localForegroundNoti.color = ServiceRecord.this.ams.mContext.getResources().getColor(17170521);
                            this.val$localForegroundNoti.setLatestEventInfo(ctx, ServiceRecord.this.ams.mContext.getString(17040506, new Object[]{appName}), ServiceRecord.this.ams.mContext.getString(17040507, new Object[]{appName}), pi);
                        } catch (NameNotFoundException e) {
                            this.val$localForegroundNoti.icon = 0;
                        }
                    }
                    if (this.val$localForegroundNoti.icon == 0) {
                        throw new RuntimeException("icon must be non-zero");
                    }
                    nm.enqueueNotification(this.val$localPackageName, this.val$localPackageName, this.val$appUid, this.val$appPid, null, this.val$localForegroundId, this.val$localForegroundNoti, new int[1], ServiceRecord.this.userId);
                } catch (RuntimeException e2) {
                    Slog.w("ActivityManager", "Error showing notification for service", e2);
                    ServiceRecord.this.ams.setServiceForeground(ServiceRecord.this.name, ServiceRecord.this, 0, null, true);
                    ServiceRecord.this.ams.crashApplication(this.val$appUid, this.val$appPid, this.val$localPackageName, "Bad notification for startForeground: " + e2);
                }
            }
        }
    }

    /* renamed from: com.android.server.am.ServiceRecord.2 */
    class C01482 implements Runnable {
        final /* synthetic */ int val$localForegroundId;
        final /* synthetic */ String val$localPackageName;

        C01482(String str, int i) {
            this.val$localPackageName = str;
            this.val$localForegroundId = i;
        }

        public void run() {
            INotificationManager inm = NotificationManager.getService();
            if (inm != null) {
                try {
                    inm.cancelNotificationWithTag(this.val$localPackageName, null, this.val$localForegroundId, ServiceRecord.this.userId);
                } catch (RuntimeException e) {
                    Slog.w("ActivityManager", "Error canceling notification for service", e);
                } catch (RemoteException e2) {
                }
            }
        }
    }

    /* renamed from: com.android.server.am.ServiceRecord.3 */
    class C01493 implements Runnable {
        final /* synthetic */ int val$localForegroundId;
        final /* synthetic */ String val$localPackageName;
        final /* synthetic */ int val$localUserId;

        C01493(String str, int i, int i2) {
            this.val$localPackageName = str;
            this.val$localForegroundId = i;
            this.val$localUserId = i2;
        }

        public void run() {
            NotificationManagerInternal nmi = (NotificationManagerInternal) LocalServices.getService(NotificationManagerInternal.class);
            if (nmi != null) {
                nmi.removeForegroundServiceFlagFromNotification(this.val$localPackageName, this.val$localForegroundId, this.val$localUserId);
            }
        }
    }

    static class StartItem {
        long deliveredTime;
        int deliveryCount;
        int doneExecutingCount;
        final int id;
        final Intent intent;
        final NeededUriGrants neededGrants;
        final ServiceRecord sr;
        String stringName;
        final boolean taskRemoved;
        UriPermissionOwner uriPermissions;

        StartItem(ServiceRecord _sr, boolean _taskRemoved, int _id, Intent _intent, NeededUriGrants _neededGrants) {
            this.sr = _sr;
            this.taskRemoved = _taskRemoved;
            this.id = _id;
            this.intent = _intent;
            this.neededGrants = _neededGrants;
        }

        UriPermissionOwner getUriPermissionsLocked() {
            if (this.uriPermissions == null) {
                this.uriPermissions = new UriPermissionOwner(this.sr.ams, this);
            }
            return this.uriPermissions;
        }

        void removeUriPermissionsLocked() {
            if (this.uriPermissions != null) {
                this.uriPermissions.removeUriPermissionsLocked();
                this.uriPermissions = null;
            }
        }

        public String toString() {
            if (this.stringName != null) {
                return this.stringName;
            }
            StringBuilder sb = new StringBuilder(DumpState.DUMP_PROVIDERS);
            sb.append("ServiceRecord{").append(Integer.toHexString(System.identityHashCode(this.sr))).append(' ').append(this.sr.shortName).append(" StartItem ").append(Integer.toHexString(System.identityHashCode(this))).append(" id=").append(this.id).append('}');
            String stringBuilder = sb.toString();
            this.stringName = stringBuilder;
            return stringBuilder;
        }
    }

    void dumpStartList(PrintWriter pw, String prefix, List<StartItem> list, long now) {
        int N = list.size();
        for (int i = 0; i < N; i++) {
            StartItem si = (StartItem) list.get(i);
            pw.print(prefix);
            pw.print("#");
            pw.print(i);
            pw.print(" id=");
            pw.print(si.id);
            if (now != 0) {
                pw.print(" dur=");
                TimeUtils.formatDuration(si.deliveredTime, now, pw);
            }
            if (si.deliveryCount != 0) {
                pw.print(" dc=");
                pw.print(si.deliveryCount);
            }
            if (si.doneExecutingCount != 0) {
                pw.print(" dxc=");
                pw.print(si.doneExecutingCount);
            }
            pw.println("");
            pw.print(prefix);
            pw.print("  intent=");
            if (si.intent != null) {
                pw.println(si.intent.toString());
            } else {
                pw.println("null");
            }
            if (si.neededGrants != null) {
                pw.print(prefix);
                pw.print("  neededGrants=");
                pw.println(si.neededGrants);
            }
            if (si.uriPermissions != null) {
                si.uriPermissions.dump(pw, prefix);
            }
        }
    }

    void dump(PrintWriter pw, String prefix) {
        int i;
        pw.print(prefix);
        pw.print("intent={");
        pw.print(this.intent.getIntent().toShortString(false, true, false, true));
        pw.println('}');
        pw.print(prefix);
        pw.print("packageName=");
        pw.println(this.packageName);
        pw.print(prefix);
        pw.print("processName=");
        pw.println(this.processName);
        if (this.permission != null) {
            pw.print(prefix);
            pw.print("permission=");
            pw.println(this.permission);
        }
        long now = SystemClock.uptimeMillis();
        long nowReal = SystemClock.elapsedRealtime();
        if (this.appInfo != null) {
            pw.print(prefix);
            pw.print("baseDir=");
            pw.println(this.appInfo.sourceDir);
            if (!Objects.equals(this.appInfo.sourceDir, this.appInfo.publicSourceDir)) {
                pw.print(prefix);
                pw.print("resDir=");
                pw.println(this.appInfo.publicSourceDir);
            }
            pw.print(prefix);
            pw.print("dataDir=");
            pw.println(this.appInfo.dataDir);
        }
        pw.print(prefix);
        pw.print("app=");
        pw.println(this.app);
        if (this.isolatedProc != null) {
            pw.print(prefix);
            pw.print("isolatedProc=");
            pw.println(this.isolatedProc);
        }
        if (this.delayed) {
            pw.print(prefix);
            pw.print("delayed=");
            pw.println(this.delayed);
        }
        if (this.isForeground || this.foregroundId != 0) {
            pw.print(prefix);
            pw.print("isForeground=");
            pw.print(this.isForeground);
            pw.print(" foregroundId=");
            pw.print(this.foregroundId);
            pw.print(" foregroundNoti=");
            pw.println(this.foregroundNoti);
        }
        pw.print(prefix);
        pw.print("createTime=");
        TimeUtils.formatDuration(this.createTime, nowReal, pw);
        pw.print(" startingBgTimeout=");
        TimeUtils.formatDuration(this.startingBgTimeout, now, pw);
        pw.println();
        pw.print(prefix);
        pw.print("lastActivity=");
        TimeUtils.formatDuration(this.lastActivity, now, pw);
        pw.print(" restartTime=");
        TimeUtils.formatDuration(this.restartTime, now, pw);
        pw.print(" createdFromFg=");
        pw.println(this.createdFromFg);
        if (this.startRequested || this.delayedStop || this.lastStartId != 0) {
            pw.print(prefix);
            pw.print("startRequested=");
            pw.print(this.startRequested);
            pw.print(" delayedStop=");
            pw.print(this.delayedStop);
            pw.print(" stopIfKilled=");
            pw.print(this.stopIfKilled);
            pw.print(" callStart=");
            pw.print(this.callStart);
            pw.print(" lastStartId=");
            pw.println(this.lastStartId);
        }
        if (this.executeNesting != 0) {
            pw.print(prefix);
            pw.print("executeNesting=");
            pw.print(this.executeNesting);
            pw.print(" executeFg=");
            pw.print(this.executeFg);
            pw.print(" executingStart=");
            TimeUtils.formatDuration(this.executingStart, now, pw);
            pw.println();
        }
        if (this.destroying || this.destroyTime != 0) {
            pw.print(prefix);
            pw.print("destroying=");
            pw.print(this.destroying);
            pw.print(" destroyTime=");
            TimeUtils.formatDuration(this.destroyTime, now, pw);
            pw.println();
        }
        if (!(this.crashCount == 0 && this.restartCount == 0 && this.restartDelay == 0 && this.nextRestartTime == 0)) {
            pw.print(prefix);
            pw.print("restartCount=");
            pw.print(this.restartCount);
            pw.print(" restartDelay=");
            TimeUtils.formatDuration(this.restartDelay, now, pw);
            pw.print(" nextRestartTime=");
            TimeUtils.formatDuration(this.nextRestartTime, now, pw);
            pw.print(" crashCount=");
            pw.println(this.crashCount);
        }
        if (this.deliveredStarts.size() > 0) {
            pw.print(prefix);
            pw.println("Delivered Starts:");
            dumpStartList(pw, prefix, this.deliveredStarts, now);
        }
        if (this.pendingStarts.size() > 0) {
            pw.print(prefix);
            pw.println("Pending Starts:");
            dumpStartList(pw, prefix, this.pendingStarts, 0);
        }
        if (this.bindings.size() > 0) {
            pw.print(prefix);
            pw.println("Bindings:");
            for (i = 0; i < this.bindings.size(); i++) {
                IntentBindRecord b = (IntentBindRecord) this.bindings.valueAt(i);
                pw.print(prefix);
                pw.print("* IntentBindRecord{");
                pw.print(Integer.toHexString(System.identityHashCode(b)));
                if ((b.collectFlags() & 1) != 0) {
                    pw.append(" CREATE");
                }
                pw.println("}:");
                b.dumpInService(pw, prefix + "  ");
            }
        }
        if (this.connections.size() > 0) {
            pw.print(prefix);
            pw.println("All Connections:");
            for (int conni = 0; conni < this.connections.size(); conni++) {
                ArrayList<ConnectionRecord> c = (ArrayList) this.connections.valueAt(conni);
                for (i = 0; i < c.size(); i++) {
                    pw.print(prefix);
                    pw.print("  ");
                    pw.println(c.get(i));
                }
            }
        }
    }

    ServiceRecord(ActivityManagerService ams, Serv servStats, ComponentName name, FilterComparison intent, ServiceInfo sInfo, boolean callerIsFg, Runnable restarter) {
        this.bindings = new ArrayMap();
        this.connections = new ArrayMap();
        this.deliveredStarts = new ArrayList();
        this.pendingStarts = new ArrayList();
        this.ams = ams;
        this.stats = servStats;
        this.name = name;
        this.shortName = name.flattenToShortString();
        this.intent = intent;
        this.serviceInfo = sInfo;
        this.appInfo = sInfo.applicationInfo;
        this.packageName = sInfo.applicationInfo.packageName;
        this.processName = sInfo.processName;
        this.permission = sInfo.permission;
        this.exported = sInfo.exported;
        this.restarter = restarter;
        this.createTime = SystemClock.elapsedRealtime();
        this.lastActivity = SystemClock.uptimeMillis();
        this.userId = UserHandle.getUserId(this.appInfo.uid);
        this.createdFromFg = callerIsFg;
    }

    public ServiceState getTracker() {
        if (this.tracker != null) {
            return this.tracker;
        }
        if ((this.serviceInfo.applicationInfo.flags & 8) == 0) {
            this.tracker = this.ams.mProcessStats.getServiceStateLocked(this.serviceInfo.packageName, this.serviceInfo.applicationInfo.uid, this.serviceInfo.applicationInfo.versionCode, this.serviceInfo.processName, this.serviceInfo.name);
            this.tracker.applyNewOwner(this);
        }
        return this.tracker;
    }

    public void forceClearTracker() {
        if (this.tracker != null) {
            this.tracker.clearCurrentOwner(this, true);
            this.tracker = null;
        }
    }

    public void makeRestarting(int memFactor, long now) {
        if (this.restartTracker == null) {
            if ((this.serviceInfo.applicationInfo.flags & 8) == 0) {
                this.restartTracker = this.ams.mProcessStats.getServiceStateLocked(this.serviceInfo.packageName, this.serviceInfo.applicationInfo.uid, this.serviceInfo.applicationInfo.versionCode, this.serviceInfo.processName, this.serviceInfo.name);
            }
            if (this.restartTracker == null) {
                return;
            }
        }
        this.restartTracker.setRestarting(true, memFactor, now);
    }

    public AppBindRecord retrieveAppBindingLocked(Intent intent, ProcessRecord app) {
        FilterComparison filter = new FilterComparison(intent);
        IntentBindRecord i = (IntentBindRecord) this.bindings.get(filter);
        if (i == null) {
            i = new IntentBindRecord(this, filter);
            this.bindings.put(filter, i);
        }
        AppBindRecord a = (AppBindRecord) i.apps.get(app);
        if (a != null) {
            return a;
        }
        a = new AppBindRecord(this, i, app);
        i.apps.put(app, a);
        return a;
    }

    public boolean hasAutoCreateConnections() {
        for (int conni = this.connections.size() - 1; conni >= 0; conni--) {
            ArrayList<ConnectionRecord> cr = (ArrayList) this.connections.valueAt(conni);
            for (int i = 0; i < cr.size(); i++) {
                if ((((ConnectionRecord) cr.get(i)).flags & 1) != 0) {
                    return true;
                }
            }
        }
        return false;
    }

    public void resetRestartCounter() {
        this.restartCount = 0;
        this.restartDelay = 0;
        this.restartTime = 0;
    }

    public StartItem findDeliveredStart(int id, boolean remove) {
        int N = this.deliveredStarts.size();
        int i = 0;
        while (i < N) {
            StartItem si = (StartItem) this.deliveredStarts.get(i);
            if (si.id != id) {
                i++;
            } else if (!remove) {
                return si;
            } else {
                this.deliveredStarts.remove(i);
                return si;
            }
        }
        return null;
    }

    public int getLastStartId() {
        return this.lastStartId;
    }

    public int makeNextStartId() {
        this.lastStartId++;
        if (this.lastStartId < 1) {
            this.lastStartId = 1;
        }
        return this.lastStartId;
    }

    public void postNotification() {
        int appUid = this.appInfo.uid;
        int appPid = this.app.pid;
        if (this.foregroundId != 0 && this.foregroundNoti != null) {
            String localPackageName = this.packageName;
            int localForegroundId = this.foregroundId;
            this.ams.mHandler.post(new C01471(this.foregroundNoti, localPackageName, appUid, appPid, localForegroundId));
        }
    }

    public void cancelNotification() {
        if (this.foregroundId != 0) {
            this.ams.mHandler.post(new C01482(this.packageName, this.foregroundId));
        }
    }

    public void stripForegroundServiceFlagFromNotification() {
        if (this.foregroundId != 0) {
            int localForegroundId = this.foregroundId;
            int localUserId = this.userId;
            this.ams.mHandler.post(new C01493(this.packageName, localForegroundId, localUserId));
        }
    }

    public void clearDeliveredStartsLocked() {
        for (int i = this.deliveredStarts.size() - 1; i >= 0; i--) {
            ((StartItem) this.deliveredStarts.get(i)).removeUriPermissionsLocked();
        }
        this.deliveredStarts.clear();
    }

    public String toString() {
        if (this.stringName != null) {
            return this.stringName;
        }
        StringBuilder sb = new StringBuilder(DumpState.DUMP_PROVIDERS);
        sb.append("ServiceRecord{").append(Integer.toHexString(System.identityHashCode(this))).append(" u").append(this.userId).append(' ').append(this.shortName).append('}');
        String stringBuilder = sb.toString();
        this.stringName = stringBuilder;
        return stringBuilder;
    }
}
