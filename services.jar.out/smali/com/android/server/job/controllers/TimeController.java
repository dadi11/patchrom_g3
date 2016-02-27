package com.android.server.job.controllers;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.SystemClock;
import com.android.server.job.JobSchedulerService;
import com.android.server.job.StateChangedListener;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;

public class TimeController extends StateController {
    private static final String ACTION_JOB_DELAY_EXPIRED = "android.content.jobscheduler.JOB_DELAY_EXPIRED";
    private static final String ACTION_JOB_EXPIRED = "android.content.jobscheduler.JOB_DEADLINE_EXPIRED";
    private static final String TAG = "JobScheduler.Time";
    private static TimeController mSingleton;
    private final BroadcastReceiver mAlarmExpiredReceiver;
    private AlarmManager mAlarmService;
    private final PendingIntent mDeadlineExpiredAlarmIntent;
    private final PendingIntent mNextDelayExpiredAlarmIntent;
    private long mNextDelayExpiredElapsedMillis;
    private long mNextJobExpiredElapsedMillis;
    private final List<JobStatus> mTrackedJobs;

    /* renamed from: com.android.server.job.controllers.TimeController.1 */
    class C03341 extends BroadcastReceiver {
        C03341() {
        }

        public void onReceive(Context context, Intent intent) {
            if (TimeController.ACTION_JOB_EXPIRED.equals(intent.getAction())) {
                TimeController.this.checkExpiredDeadlinesAndResetAlarm();
            } else if (TimeController.ACTION_JOB_DELAY_EXPIRED.equals(intent.getAction())) {
                TimeController.this.checkExpiredDelaysAndResetAlarm();
            }
        }
    }

    public static synchronized TimeController get(JobSchedulerService jms) {
        TimeController timeController;
        synchronized (TimeController.class) {
            if (mSingleton == null) {
                mSingleton = new TimeController(jms, jms.getContext());
            }
            timeController = mSingleton;
        }
        return timeController;
    }

    private TimeController(StateChangedListener stateChangedListener, Context context) {
        super(stateChangedListener, context);
        this.mAlarmService = null;
        this.mTrackedJobs = new LinkedList();
        this.mAlarmExpiredReceiver = new C03341();
        this.mDeadlineExpiredAlarmIntent = PendingIntent.getBroadcast(this.mContext, 0, new Intent(ACTION_JOB_EXPIRED), 0);
        this.mNextDelayExpiredAlarmIntent = PendingIntent.getBroadcast(this.mContext, 0, new Intent(ACTION_JOB_DELAY_EXPIRED), 0);
        this.mNextJobExpiredElapsedMillis = JobStatus.NO_LATEST_RUNTIME;
        this.mNextDelayExpiredElapsedMillis = JobStatus.NO_LATEST_RUNTIME;
        IntentFilter intentFilter = new IntentFilter(ACTION_JOB_EXPIRED);
        intentFilter.addAction(ACTION_JOB_DELAY_EXPIRED);
        this.mContext.registerReceiver(this.mAlarmExpiredReceiver, intentFilter);
    }

    public synchronized void maybeStartTrackingJob(JobStatus job) {
        long j = JobStatus.NO_LATEST_RUNTIME;
        synchronized (this) {
            if (job.hasTimingDelayConstraint() || job.hasDeadlineConstraint()) {
                long earliestRunTime;
                maybeStopTrackingJob(job);
                boolean isInsert = false;
                ListIterator<JobStatus> it = this.mTrackedJobs.listIterator(this.mTrackedJobs.size());
                while (it.hasPrevious()) {
                    if (((JobStatus) it.previous()).getLatestRunTimeElapsed() < job.getLatestRunTimeElapsed()) {
                        isInsert = true;
                        break;
                    }
                }
                if (isInsert) {
                    it.next();
                }
                it.add(job);
                if (job.hasTimingDelayConstraint()) {
                    earliestRunTime = job.getEarliestRunTime();
                } else {
                    earliestRunTime = JobStatus.NO_LATEST_RUNTIME;
                }
                if (job.hasDeadlineConstraint()) {
                    j = job.getLatestRunTimeElapsed();
                }
                maybeUpdateAlarms(earliestRunTime, j);
            }
        }
    }

    public synchronized void maybeStopTrackingJob(JobStatus job) {
        if (this.mTrackedJobs.remove(job)) {
            checkExpiredDelaysAndResetAlarm();
            checkExpiredDeadlinesAndResetAlarm();
        }
    }

    private boolean canStopTrackingJob(JobStatus job) {
        return (!job.hasTimingDelayConstraint() || job.timeDelayConstraintSatisfied.get()) && (!job.hasDeadlineConstraint() || job.deadlineConstraintSatisfied.get());
    }

    private void ensureAlarmService() {
        if (this.mAlarmService == null) {
            this.mAlarmService = (AlarmManager) this.mContext.getSystemService("alarm");
        }
    }

    private synchronized void checkExpiredDeadlinesAndResetAlarm() {
        long nextExpiryTime = JobStatus.NO_LATEST_RUNTIME;
        long nowElapsedMillis = SystemClock.elapsedRealtime();
        Iterator<JobStatus> it = this.mTrackedJobs.iterator();
        while (it.hasNext()) {
            JobStatus job = (JobStatus) it.next();
            if (job.hasDeadlineConstraint()) {
                long jobDeadline = job.getLatestRunTimeElapsed();
                if (jobDeadline > nowElapsedMillis) {
                    nextExpiryTime = jobDeadline;
                    break;
                }
                job.deadlineConstraintSatisfied.set(true);
                this.mStateChangedListener.onRunJobNow(job);
                it.remove();
            }
        }
        setDeadlineExpiredAlarm(nextExpiryTime);
    }

    private synchronized void checkExpiredDelaysAndResetAlarm() {
        long nowElapsedMillis = SystemClock.elapsedRealtime();
        long nextDelayTime = JobStatus.NO_LATEST_RUNTIME;
        boolean ready = false;
        Iterator<JobStatus> it = this.mTrackedJobs.iterator();
        while (it.hasNext()) {
            JobStatus job = (JobStatus) it.next();
            if (job.hasTimingDelayConstraint()) {
                long jobDelayTime = job.getEarliestRunTime();
                if (jobDelayTime <= nowElapsedMillis) {
                    job.timeDelayConstraintSatisfied.set(true);
                    if (canStopTrackingJob(job)) {
                        it.remove();
                    }
                    if (job.isReady()) {
                        ready = true;
                    }
                } else if (nextDelayTime > jobDelayTime) {
                    nextDelayTime = jobDelayTime;
                }
            }
        }
        if (ready) {
            this.mStateChangedListener.onControllerStateChanged();
        }
        setDelayExpiredAlarm(nextDelayTime);
    }

    private void maybeUpdateAlarms(long delayExpiredElapsed, long deadlineExpiredElapsed) {
        if (delayExpiredElapsed < this.mNextDelayExpiredElapsedMillis) {
            setDelayExpiredAlarm(delayExpiredElapsed);
        }
        if (deadlineExpiredElapsed < this.mNextJobExpiredElapsedMillis) {
            setDeadlineExpiredAlarm(deadlineExpiredElapsed);
        }
    }

    private void setDelayExpiredAlarm(long alarmTimeElapsedMillis) {
        this.mNextDelayExpiredElapsedMillis = maybeAdjustAlarmTime(alarmTimeElapsedMillis);
        updateAlarmWithPendingIntent(this.mNextDelayExpiredAlarmIntent, this.mNextDelayExpiredElapsedMillis);
    }

    private void setDeadlineExpiredAlarm(long alarmTimeElapsedMillis) {
        this.mNextJobExpiredElapsedMillis = maybeAdjustAlarmTime(alarmTimeElapsedMillis);
        updateAlarmWithPendingIntent(this.mDeadlineExpiredAlarmIntent, this.mNextJobExpiredElapsedMillis);
    }

    private long maybeAdjustAlarmTime(long proposedAlarmTimeElapsedMillis) {
        long earliestWakeupTimeElapsed = SystemClock.elapsedRealtime();
        return proposedAlarmTimeElapsedMillis < earliestWakeupTimeElapsed ? earliestWakeupTimeElapsed : proposedAlarmTimeElapsedMillis;
    }

    private void updateAlarmWithPendingIntent(PendingIntent pi, long alarmTimeElapsed) {
        ensureAlarmService();
        if (alarmTimeElapsed == JobStatus.NO_LATEST_RUNTIME) {
            this.mAlarmService.cancel(pi);
        } else {
            this.mAlarmService.set(3, alarmTimeElapsed, pi);
        }
    }

    public void dumpControllerState(PrintWriter pw) {
        long nowElapsed = SystemClock.elapsedRealtime();
        pw.println("Alarms (" + SystemClock.elapsedRealtime() + ")");
        pw.println("Next delay alarm in " + ((this.mNextDelayExpiredElapsedMillis - nowElapsed) / 1000) + "s");
        pw.println("Next deadline alarm in " + ((this.mNextJobExpiredElapsedMillis - nowElapsed) / 1000) + "s");
        pw.println("Tracking:");
        for (JobStatus ts : this.mTrackedJobs) {
            pw.println(String.valueOf(ts.hashCode()).substring(0, 3) + ".." + ": (" + (ts.hasTimingDelayConstraint() ? Long.valueOf(ts.getEarliestRunTime()) : "N/A") + ", " + (ts.hasDeadlineConstraint() ? Long.valueOf(ts.getLatestRunTimeElapsed()) : "N/A") + ")");
        }
    }
}
