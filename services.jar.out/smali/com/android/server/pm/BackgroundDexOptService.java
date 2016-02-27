package com.android.server.pm;

import android.app.job.JobInfo.Builder;
import android.app.job.JobParameters;
import android.app.job.JobScheduler;
import android.app.job.JobService;
import android.content.ComponentName;
import android.content.Context;
import android.os.ServiceManager;
import android.util.ArraySet;
import android.util.Log;
import java.util.Iterator;
import java.util.concurrent.atomic.AtomicBoolean;

public class BackgroundDexOptService extends JobService {
    static final int BACKGROUND_DEXOPT_JOB = 800;
    static final String TAG = "BackgroundDexOptService";
    private static ComponentName sDexoptServiceName;
    static final ArraySet<String> sFailedPackageNames;
    final AtomicBoolean mIdleTime;

    /* renamed from: com.android.server.pm.BackgroundDexOptService.1 */
    class C04401 extends Thread {
        final /* synthetic */ JobParameters val$jobParams;
        final /* synthetic */ ArraySet val$pkgs;
        final /* synthetic */ PackageManagerService val$pm;

        C04401(String x0, ArraySet arraySet, PackageManagerService packageManagerService, JobParameters jobParameters) {
            this.val$pkgs = arraySet;
            this.val$pm = packageManagerService;
            this.val$jobParams = jobParameters;
            super(x0);
        }

        public void run() {
            Iterator i$ = this.val$pkgs.iterator();
            while (i$.hasNext()) {
                String pkg = (String) i$.next();
                if (!BackgroundDexOptService.this.mIdleTime.get()) {
                    BackgroundDexOptService.schedule(BackgroundDexOptService.this);
                    return;
                } else if (!(BackgroundDexOptService.sFailedPackageNames.contains(pkg) || this.val$pm.performDexOpt(pkg, null, true))) {
                    BackgroundDexOptService.sFailedPackageNames.add(pkg);
                }
            }
            BackgroundDexOptService.this.jobFinished(this.val$jobParams, false);
        }
    }

    public BackgroundDexOptService() {
        this.mIdleTime = new AtomicBoolean(false);
    }

    static {
        sDexoptServiceName = new ComponentName("android", BackgroundDexOptService.class.getName());
        sFailedPackageNames = new ArraySet();
    }

    public static void schedule(Context context) {
        ((JobScheduler) context.getSystemService("jobscheduler")).schedule(new Builder(BACKGROUND_DEXOPT_JOB, sDexoptServiceName).setRequiresDeviceIdle(true).setRequiresCharging(true).build());
    }

    public boolean onStartJob(JobParameters params) {
        Log.i(TAG, "onIdleStart");
        PackageManagerService pm = (PackageManagerService) ServiceManager.getService("package");
        if (pm.isStorageLow()) {
            return false;
        }
        ArraySet<String> pkgs = pm.getPackagesThatNeedDexOpt();
        if (pkgs == null) {
            return false;
        }
        JobParameters jobParams = params;
        this.mIdleTime.set(true);
        new C04401("BackgroundDexOptService_DexOpter", pkgs, pm, jobParams).start();
        return true;
    }

    public boolean onStopJob(JobParameters params) {
        Log.i(TAG, "onIdleStop");
        this.mIdleTime.set(false);
        return false;
    }
}
