package com.android.server;

import android.app.ActivityManagerNative;
import android.app.job.JobInfo.Builder;
import android.app.job.JobParameters;
import android.app.job.JobScheduler;
import android.app.job.JobService;
import android.content.ComponentName;
import android.content.Context;
import android.os.RemoteException;
import android.util.Slog;
import java.util.Calendar;

public class MountServiceIdler extends JobService {
    private static int MOUNT_JOB_ID = 0;
    private static final String TAG = "MountServiceIdler";
    private static ComponentName sIdleService;
    private Runnable mFinishCallback;
    private JobParameters mJobParams;
    private boolean mStarted;

    /* renamed from: com.android.server.MountServiceIdler.1 */
    class C00661 implements Runnable {
        C00661() {
        }

        public void run() {
            Slog.i(MountServiceIdler.TAG, "Got mount service completion callback");
            synchronized (MountServiceIdler.this.mFinishCallback) {
                if (MountServiceIdler.this.mStarted) {
                    MountServiceIdler.this.jobFinished(MountServiceIdler.this.mJobParams, false);
                    MountServiceIdler.this.mStarted = false;
                }
            }
            MountServiceIdler.scheduleIdlePass(MountServiceIdler.this);
        }
    }

    public MountServiceIdler() {
        this.mFinishCallback = new C00661();
    }

    static {
        sIdleService = new ComponentName("android", MountServiceIdler.class.getName());
        MOUNT_JOB_ID = 808;
    }

    public boolean onStartJob(JobParameters params) {
        try {
            ActivityManagerNative.getDefault().performIdleMaintenance();
        } catch (RemoteException e) {
        }
        this.mJobParams = params;
        MountService ms = MountService.sSelf;
        if (ms != null) {
            synchronized (this.mFinishCallback) {
                this.mStarted = true;
            }
            ms.runIdleMaintenance(this.mFinishCallback);
        }
        if (ms != null) {
            return true;
        }
        return false;
    }

    public boolean onStopJob(JobParameters params) {
        synchronized (this.mFinishCallback) {
            this.mStarted = false;
        }
        return false;
    }

    public static void scheduleIdlePass(Context context) {
        JobScheduler tm = (JobScheduler) context.getSystemService("jobscheduler");
        long timeToMidnight = tomorrowMidnight().getTimeInMillis() - System.currentTimeMillis();
        Builder builder = new Builder(MOUNT_JOB_ID, sIdleService);
        builder.setRequiresDeviceIdle(true);
        builder.setRequiresCharging(true);
        builder.setMinimumLatency(timeToMidnight);
        tm.schedule(builder.build());
    }

    private static Calendar tomorrowMidnight() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(System.currentTimeMillis());
        calendar.set(11, 3);
        calendar.set(12, 0);
        calendar.set(13, 0);
        calendar.set(14, 0);
        calendar.add(5, 1);
        return calendar;
    }
}
