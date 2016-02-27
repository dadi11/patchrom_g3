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
import java.util.ArrayList;
import java.util.Iterator;

public class IdleController extends StateController {
    private static final String ACTION_TRIGGER_IDLE = "com.android.server.task.controllers.IdleController.ACTION_TRIGGER_IDLE";
    private static final long IDLE_WINDOW_SLOP = 300000;
    private static final long INACTIVITY_IDLE_THRESHOLD = 4260000;
    private static final String TAG = "IdleController";
    private static volatile IdleController sController;
    private static Object sCreationLock;
    IdlenessTracker mIdleTracker;
    final ArrayList<JobStatus> mTrackedTasks;

    class IdlenessTracker extends BroadcastReceiver {
        private AlarmManager mAlarm;
        boolean mIdle;
        private PendingIntent mIdleTriggerIntent;

        public IdlenessTracker() {
            this.mAlarm = (AlarmManager) IdleController.this.mContext.getSystemService("alarm");
            this.mIdleTriggerIntent = PendingIntent.getBroadcast(IdleController.this.mContext, 0, new Intent(IdleController.ACTION_TRIGGER_IDLE).setPackage("android").setFlags(1073741824), 0);
            this.mIdle = false;
        }

        public boolean isIdle() {
            return this.mIdle;
        }

        public void startTracking() {
            IntentFilter filter = new IntentFilter();
            filter.addAction("android.intent.action.SCREEN_ON");
            filter.addAction("android.intent.action.SCREEN_OFF");
            filter.addAction("android.intent.action.DREAMING_STARTED");
            filter.addAction("android.intent.action.DREAMING_STOPPED");
            filter.addAction(IdleController.ACTION_TRIGGER_IDLE);
            IdleController.this.mContext.registerReceiver(this, filter);
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (action.equals("android.intent.action.SCREEN_ON") || action.equals("android.intent.action.DREAMING_STOPPED")) {
                if (this.mIdle) {
                    this.mAlarm.cancel(this.mIdleTriggerIntent);
                    this.mIdle = false;
                    IdleController.this.reportNewIdleState(this.mIdle);
                }
            } else if (action.equals("android.intent.action.SCREEN_OFF") || action.equals("android.intent.action.DREAMING_STARTED")) {
                this.mAlarm.setWindow(2, SystemClock.elapsedRealtime() + IdleController.INACTIVITY_IDLE_THRESHOLD, IdleController.IDLE_WINDOW_SLOP, this.mIdleTriggerIntent);
            } else if (action.equals(IdleController.ACTION_TRIGGER_IDLE) && !this.mIdle) {
                this.mIdle = true;
                IdleController.this.reportNewIdleState(this.mIdle);
            }
        }
    }

    static {
        sCreationLock = new Object();
    }

    public static IdleController get(JobSchedulerService service) {
        IdleController idleController;
        synchronized (sCreationLock) {
            if (sController == null) {
                sController = new IdleController(service, service.getContext());
            }
            idleController = sController;
        }
        return idleController;
    }

    private IdleController(StateChangedListener stateChangedListener, Context context) {
        super(stateChangedListener, context);
        this.mTrackedTasks = new ArrayList();
        initIdleStateTracking();
    }

    public void maybeStartTrackingJob(JobStatus taskStatus) {
        if (taskStatus.hasIdleConstraint()) {
            synchronized (this.mTrackedTasks) {
                this.mTrackedTasks.add(taskStatus);
                taskStatus.idleConstraintSatisfied.set(this.mIdleTracker.isIdle());
            }
        }
    }

    public void maybeStopTrackingJob(JobStatus taskStatus) {
        synchronized (this.mTrackedTasks) {
            this.mTrackedTasks.remove(taskStatus);
        }
    }

    void reportNewIdleState(boolean isIdle) {
        synchronized (this.mTrackedTasks) {
            Iterator i$ = this.mTrackedTasks.iterator();
            while (i$.hasNext()) {
                ((JobStatus) i$.next()).idleConstraintSatisfied.set(isIdle);
            }
        }
        this.mStateChangedListener.onControllerStateChanged();
    }

    private void initIdleStateTracking() {
        this.mIdleTracker = new IdlenessTracker();
        this.mIdleTracker.startTracking();
    }

    public void dumpControllerState(PrintWriter pw) {
        synchronized (this.mTrackedTasks) {
            pw.print("Idle: ");
            pw.println(this.mIdleTracker.isIdle() ? "true" : "false");
            pw.println(this.mTrackedTasks.size());
            for (int i = 0; i < this.mTrackedTasks.size(); i++) {
                JobStatus js = (JobStatus) this.mTrackedTasks.get(i);
                pw.print("  ");
                pw.print(String.valueOf(js.hashCode()).substring(0, 3));
                pw.println("..");
            }
        }
    }
}
