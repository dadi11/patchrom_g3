package com.android.server.job;

import android.app.AppGlobals;
import android.app.job.IJobScheduler.Stub;
import android.app.job.JobInfo;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.IPackageManager;
import android.content.pm.ServiceInfo;
import android.os.Binder;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.UserHandle;
import android.util.ArraySet;
import android.util.Slog;
import android.util.SparseArray;
import com.android.internal.app.IBatteryStats;
import com.android.server.SystemService;
import com.android.server.job.controllers.BatteryController;
import com.android.server.job.controllers.ConnectivityController;
import com.android.server.job.controllers.IdleController;
import com.android.server.job.controllers.JobStatus;
import com.android.server.job.controllers.StateController;
import com.android.server.job.controllers.TimeController;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class JobSchedulerService extends SystemService implements StateChangedListener, JobCompletedListener {
    static final boolean DEBUG = false;
    private static final int MAX_JOB_CONTEXTS_COUNT = 3;
    static final int MIN_CHARGING_COUNT = 1;
    static final int MIN_CONNECTIVITY_COUNT = 2;
    static final int MIN_IDLE_COUNT = 1;
    static final int MIN_READY_JOBS_COUNT = 2;
    static final int MSG_CHECK_JOB = 1;
    static final int MSG_JOB_EXPIRED = 0;
    static final String TAG = "JobSchedulerService";
    final List<JobServiceContext> mActiveServices;
    IBatteryStats mBatteryStats;
    private final BroadcastReceiver mBroadcastReceiver;
    List<StateController> mControllers;
    final JobHandler mHandler;
    final JobSchedulerStub mJobSchedulerStub;
    final JobStore mJobs;
    final ArrayList<JobStatus> mPendingJobs;
    boolean mReadyToRock;
    final ArrayList<Integer> mStartedUsers;

    /* renamed from: com.android.server.job.JobSchedulerService.1 */
    class C03321 extends BroadcastReceiver {
        C03321() {
        }

        public void onReceive(Context context, Intent intent) {
            Slog.d(JobSchedulerService.TAG, "Receieved: " + intent.getAction());
            if ("android.intent.action.PACKAGE_REMOVED".equals(intent.getAction())) {
                if (!intent.getBooleanExtra("android.intent.extra.REPLACING", JobSchedulerService.DEBUG)) {
                    JobSchedulerService.this.cancelJobsForUid(intent.getIntExtra("android.intent.extra.UID", -1));
                }
            } else if ("android.intent.action.USER_REMOVED".equals(intent.getAction())) {
                JobSchedulerService.this.cancelJobsForUser(intent.getIntExtra("android.intent.extra.user_handle", JobSchedulerService.MSG_JOB_EXPIRED));
            }
        }
    }

    private class JobHandler extends Handler {
        public JobHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message message) {
            synchronized (JobSchedulerService.this.mJobs) {
                if (JobSchedulerService.this.mReadyToRock) {
                    switch (message.what) {
                        case JobSchedulerService.MSG_JOB_EXPIRED /*0*/:
                            synchronized (JobSchedulerService.this.mJobs) {
                                JobStatus runNow = message.obj;
                                if (!(runNow == null || JobSchedulerService.this.mPendingJobs.contains(runNow) || !JobSchedulerService.this.mJobs.containsJob(runNow))) {
                                    JobSchedulerService.this.mPendingJobs.add(runNow);
                                }
                                queueReadyJobsForExecutionLockedH();
                                break;
                            }
                            break;
                        case JobSchedulerService.MSG_CHECK_JOB /*1*/:
                            synchronized (JobSchedulerService.this.mJobs) {
                                maybeQueueReadyJobsForExecutionLockedH();
                                break;
                            }
                            break;
                    }
                    maybeRunPendingJobsH();
                    removeMessages(JobSchedulerService.MSG_CHECK_JOB);
                    return;
                }
            }
        }

        private void queueReadyJobsForExecutionLockedH() {
            ArraySet<JobStatus> jobs = JobSchedulerService.this.mJobs.getJobs();
            for (int i = JobSchedulerService.MSG_JOB_EXPIRED; i < jobs.size(); i += JobSchedulerService.MSG_CHECK_JOB) {
                JobStatus job = (JobStatus) jobs.valueAt(i);
                if (isReadyToBeExecutedLocked(job)) {
                    JobSchedulerService.this.mPendingJobs.add(job);
                } else if (isReadyToBeCancelledLocked(job)) {
                    JobSchedulerService.this.stopJobOnServiceContextLocked(job);
                }
            }
        }

        private void maybeQueueReadyJobsForExecutionLockedH() {
            int i;
            int chargingCount = JobSchedulerService.MSG_JOB_EXPIRED;
            int idleCount = JobSchedulerService.MSG_JOB_EXPIRED;
            int backoffCount = JobSchedulerService.MSG_JOB_EXPIRED;
            int connectivityCount = JobSchedulerService.MSG_JOB_EXPIRED;
            List<JobStatus> runnableJobs = new ArrayList();
            ArraySet<JobStatus> jobs = JobSchedulerService.this.mJobs.getJobs();
            for (i = JobSchedulerService.MSG_JOB_EXPIRED; i < jobs.size(); i += JobSchedulerService.MSG_CHECK_JOB) {
                JobStatus job = (JobStatus) jobs.valueAt(i);
                if (isReadyToBeExecutedLocked(job)) {
                    if (job.getNumFailures() > 0) {
                        backoffCount += JobSchedulerService.MSG_CHECK_JOB;
                    }
                    if (job.hasIdleConstraint()) {
                        idleCount += JobSchedulerService.MSG_CHECK_JOB;
                    }
                    if (job.hasConnectivityConstraint() || job.hasUnmeteredConstraint()) {
                        connectivityCount += JobSchedulerService.MSG_CHECK_JOB;
                    }
                    if (job.hasChargingConstraint()) {
                        chargingCount += JobSchedulerService.MSG_CHECK_JOB;
                    }
                    runnableJobs.add(job);
                } else if (isReadyToBeCancelledLocked(job)) {
                    JobSchedulerService.this.stopJobOnServiceContextLocked(job);
                }
            }
            if (backoffCount > 0 || idleCount >= JobSchedulerService.MSG_CHECK_JOB || connectivityCount >= JobSchedulerService.MIN_READY_JOBS_COUNT || chargingCount >= JobSchedulerService.MSG_CHECK_JOB || runnableJobs.size() >= JobSchedulerService.MIN_READY_JOBS_COUNT) {
                for (i = JobSchedulerService.MSG_JOB_EXPIRED; i < runnableJobs.size(); i += JobSchedulerService.MSG_CHECK_JOB) {
                    JobSchedulerService.this.mPendingJobs.add(runnableJobs.get(i));
                }
            }
        }

        private boolean isReadyToBeExecutedLocked(JobStatus job) {
            return (!JobSchedulerService.this.mStartedUsers.contains(Integer.valueOf(job.getUserId())) || !job.isReady() || JobSchedulerService.this.mPendingJobs.contains(job) || JobSchedulerService.this.isCurrentlyActiveLocked(job)) ? JobSchedulerService.DEBUG : true;
        }

        private boolean isReadyToBeCancelledLocked(JobStatus job) {
            return (job.isReady() || !JobSchedulerService.this.isCurrentlyActiveLocked(job)) ? JobSchedulerService.DEBUG : true;
        }

        private void maybeRunPendingJobsH() {
            synchronized (JobSchedulerService.this.mJobs) {
                Iterator<JobStatus> it = JobSchedulerService.this.mPendingJobs.iterator();
                while (it.hasNext()) {
                    JobStatus nextPending = (JobStatus) it.next();
                    JobServiceContext availableContext = null;
                    for (int i = JobSchedulerService.MSG_JOB_EXPIRED; i < JobSchedulerService.this.mActiveServices.size(); i += JobSchedulerService.MSG_CHECK_JOB) {
                        JobServiceContext jsc = (JobServiceContext) JobSchedulerService.this.mActiveServices.get(i);
                        JobStatus running = jsc.getRunningJob();
                        if (running != null && running.matches(nextPending.getUid(), nextPending.getJobId())) {
                            availableContext = null;
                            break;
                        }
                        if (jsc.isAvailable()) {
                            availableContext = jsc;
                        }
                    }
                    if (availableContext != null) {
                        if (!availableContext.executeRunnableJob(nextPending)) {
                            JobSchedulerService.this.mJobs.remove(nextPending);
                        }
                        it.remove();
                    }
                }
            }
        }
    }

    final class JobSchedulerStub extends Stub {
        private final SparseArray<Boolean> mPersistCache;

        JobSchedulerStub() {
            this.mPersistCache = new SparseArray();
        }

        private void enforceValidJobRequest(int uid, JobInfo job) {
            IPackageManager pm = AppGlobals.getPackageManager();
            ComponentName service = job.getService();
            try {
                ServiceInfo si = pm.getServiceInfo(service, JobSchedulerService.MSG_JOB_EXPIRED, UserHandle.getUserId(uid));
                if (si == null) {
                    throw new IllegalArgumentException("No such service " + service);
                } else if (si.applicationInfo.uid != uid) {
                    throw new IllegalArgumentException("uid " + uid + " cannot schedule job in " + service.getPackageName());
                } else if (!"android.permission.BIND_JOB_SERVICE".equals(si.permission)) {
                    throw new IllegalArgumentException("Scheduled service " + service + " does not require android.permission.BIND_JOB_SERVICE permission");
                }
            } catch (RemoteException e) {
            }
        }

        private boolean canPersistJobs(int pid, int uid) {
            boolean canPersist;
            synchronized (this.mPersistCache) {
                Boolean cached = (Boolean) this.mPersistCache.get(uid);
                if (cached != null) {
                    canPersist = cached.booleanValue();
                } else {
                    canPersist = JobSchedulerService.this.getContext().checkPermission("android.permission.RECEIVE_BOOT_COMPLETED", pid, uid) == 0 ? true : JobSchedulerService.DEBUG;
                    this.mPersistCache.put(uid, Boolean.valueOf(canPersist));
                }
            }
            return canPersist;
        }

        public int schedule(JobInfo job) throws RemoteException {
            int pid = Binder.getCallingPid();
            int uid = Binder.getCallingUid();
            enforceValidJobRequest(uid, job);
            if (!job.isPersisted() || canPersistJobs(pid, uid)) {
                long ident = Binder.clearCallingIdentity();
                try {
                    int schedule = JobSchedulerService.this.schedule(job, uid);
                    return schedule;
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            } else {
                throw new IllegalArgumentException("Error: requested job be persisted without holding RECEIVE_BOOT_COMPLETED permission.");
            }
        }

        public List<JobInfo> getAllPendingJobs() throws RemoteException {
            int uid = Binder.getCallingUid();
            long ident = Binder.clearCallingIdentity();
            try {
                List<JobInfo> pendingJobs = JobSchedulerService.this.getPendingJobs(uid);
                return pendingJobs;
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void cancelAll() throws RemoteException {
            int uid = Binder.getCallingUid();
            long ident = Binder.clearCallingIdentity();
            try {
                JobSchedulerService.this.cancelJobsForUid(uid);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void cancel(int jobId) throws RemoteException {
            int uid = Binder.getCallingUid();
            long ident = Binder.clearCallingIdentity();
            try {
                JobSchedulerService.this.cancelJob(uid, jobId);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            JobSchedulerService.this.getContext().enforceCallingOrSelfPermission("android.permission.DUMP", JobSchedulerService.TAG);
            long identityToken = Binder.clearCallingIdentity();
            try {
                JobSchedulerService.this.dumpInternal(pw);
            } finally {
                Binder.restoreCallingIdentity(identityToken);
            }
        }
    }

    public void onStartUser(int userHandle) {
        this.mStartedUsers.add(Integer.valueOf(userHandle));
        this.mHandler.obtainMessage(MSG_CHECK_JOB).sendToTarget();
    }

    public void onStopUser(int userHandle) {
        this.mStartedUsers.remove(Integer.valueOf(userHandle));
    }

    public int schedule(JobInfo job, int uId) {
        JobStatus jobStatus = new JobStatus(job, uId);
        cancelJob(uId, job.getId());
        startTrackingJob(jobStatus);
        this.mHandler.obtainMessage(MSG_CHECK_JOB).sendToTarget();
        return MSG_CHECK_JOB;
    }

    public List<JobInfo> getPendingJobs(int uid) {
        ArrayList<JobInfo> outList = new ArrayList();
        synchronized (this.mJobs) {
            ArraySet<JobStatus> jobs = this.mJobs.getJobs();
            for (int i = MSG_JOB_EXPIRED; i < jobs.size(); i += MSG_CHECK_JOB) {
                JobStatus job = (JobStatus) jobs.valueAt(i);
                if (job.getUid() == uid) {
                    outList.add(job.getJob());
                }
            }
        }
        return outList;
    }

    private void cancelJobsForUser(int userHandle) {
        synchronized (this.mJobs) {
            List<JobStatus> jobsForUser = this.mJobs.getJobsByUser(userHandle);
        }
        for (int i = MSG_JOB_EXPIRED; i < jobsForUser.size(); i += MSG_CHECK_JOB) {
            cancelJobImpl((JobStatus) jobsForUser.get(i));
        }
    }

    public void cancelJobsForUid(int uid) {
        synchronized (this.mJobs) {
            List<JobStatus> jobsForUid = this.mJobs.getJobsByUid(uid);
        }
        for (int i = MSG_JOB_EXPIRED; i < jobsForUid.size(); i += MSG_CHECK_JOB) {
            cancelJobImpl((JobStatus) jobsForUid.get(i));
        }
    }

    public void cancelJob(int uid, int jobId) {
        synchronized (this.mJobs) {
            JobStatus toCancel = this.mJobs.getJobByUidAndJobId(uid, jobId);
        }
        if (toCancel != null) {
            cancelJobImpl(toCancel);
        }
    }

    private void cancelJobImpl(JobStatus cancelled) {
        stopTrackingJob(cancelled);
        synchronized (this.mJobs) {
            this.mPendingJobs.remove(cancelled);
            stopJobOnServiceContextLocked(cancelled);
        }
    }

    public JobSchedulerService(Context context) {
        super(context);
        this.mActiveServices = new ArrayList();
        this.mPendingJobs = new ArrayList();
        this.mStartedUsers = new ArrayList();
        this.mBroadcastReceiver = new C03321();
        this.mControllers = new ArrayList();
        this.mControllers.add(ConnectivityController.get(this));
        this.mControllers.add(TimeController.get(this));
        this.mControllers.add(IdleController.get(this));
        this.mControllers.add(BatteryController.get(this));
        this.mHandler = new JobHandler(context.getMainLooper());
        this.mJobSchedulerStub = new JobSchedulerStub();
        this.mJobs = JobStore.initAndGet(this);
    }

    public void onStart() {
        publishBinderService("jobscheduler", this.mJobSchedulerStub);
    }

    public void onBootPhase(int phase) {
        if (SystemService.PHASE_SYSTEM_SERVICES_READY == phase) {
            IntentFilter filter = new IntentFilter("android.intent.action.PACKAGE_REMOVED");
            filter.addDataScheme("package");
            getContext().registerReceiverAsUser(this.mBroadcastReceiver, UserHandle.ALL, filter, null, null);
            getContext().registerReceiverAsUser(this.mBroadcastReceiver, UserHandle.ALL, new IntentFilter("android.intent.action.USER_REMOVED"), null, null);
        } else if (phase == NetdResponseCode.InterfaceChange) {
            synchronized (this.mJobs) {
                int i;
                this.mReadyToRock = true;
                this.mBatteryStats = IBatteryStats.Stub.asInterface(ServiceManager.getService("batterystats"));
                for (i = MSG_JOB_EXPIRED; i < MAX_JOB_CONTEXTS_COUNT; i += MSG_CHECK_JOB) {
                    this.mActiveServices.add(new JobServiceContext(this, this.mBatteryStats, getContext().getMainLooper()));
                }
                ArraySet<JobStatus> jobs = this.mJobs.getJobs();
                for (i = MSG_JOB_EXPIRED; i < jobs.size(); i += MSG_CHECK_JOB) {
                    JobStatus job = (JobStatus) jobs.valueAt(i);
                    for (int controller = MSG_JOB_EXPIRED; controller < this.mControllers.size(); controller += MSG_CHECK_JOB) {
                        ((StateController) this.mControllers.get(controller)).maybeStartTrackingJob(job);
                    }
                }
                this.mHandler.obtainMessage(MSG_CHECK_JOB).sendToTarget();
            }
        }
    }

    private void startTrackingJob(JobStatus jobStatus) {
        synchronized (this.mJobs) {
            boolean update = this.mJobs.add(jobStatus);
            boolean rocking = this.mReadyToRock;
        }
        if (rocking) {
            for (int i = MSG_JOB_EXPIRED; i < this.mControllers.size(); i += MSG_CHECK_JOB) {
                StateController controller = (StateController) this.mControllers.get(i);
                if (update) {
                    controller.maybeStopTrackingJob(jobStatus);
                }
                controller.maybeStartTrackingJob(jobStatus);
            }
        }
    }

    private boolean stopTrackingJob(JobStatus jobStatus) {
        boolean removed;
        synchronized (this.mJobs) {
            removed = this.mJobs.remove(jobStatus);
            boolean rocking = this.mReadyToRock;
        }
        if (removed && rocking) {
            for (int i = MSG_JOB_EXPIRED; i < this.mControllers.size(); i += MSG_CHECK_JOB) {
                ((StateController) this.mControllers.get(i)).maybeStopTrackingJob(jobStatus);
            }
        }
        return removed;
    }

    private boolean stopJobOnServiceContextLocked(JobStatus job) {
        int i = MSG_JOB_EXPIRED;
        while (i < this.mActiveServices.size()) {
            JobServiceContext jsc = (JobServiceContext) this.mActiveServices.get(i);
            JobStatus executing = jsc.getRunningJob();
            if (executing == null || !executing.matches(job.getUid(), job.getJobId())) {
                i += MSG_CHECK_JOB;
            } else {
                jsc.cancelExecutingJob();
                return true;
            }
        }
        return DEBUG;
    }

    private boolean isCurrentlyActiveLocked(JobStatus job) {
        for (int i = MSG_JOB_EXPIRED; i < this.mActiveServices.size(); i += MSG_CHECK_JOB) {
            JobStatus running = ((JobServiceContext) this.mActiveServices.get(i)).getRunningJob();
            if (running != null && running.matches(job.getUid(), job.getJobId())) {
                return true;
            }
        }
        return DEBUG;
    }

    private JobStatus getRescheduleJobForFailure(JobStatus failureToReschedule) {
        long delayMillis;
        long elapsedNowMillis = SystemClock.elapsedRealtime();
        JobInfo job = failureToReschedule.getJob();
        long initialBackoffMillis = job.getInitialBackoffMillis();
        int backoffAttempts = failureToReschedule.getNumFailures() + MSG_CHECK_JOB;
        switch (job.getBackoffPolicy()) {
            case MSG_JOB_EXPIRED /*0*/:
                delayMillis = initialBackoffMillis * ((long) backoffAttempts);
                break;
            default:
                delayMillis = (long) Math.scalb((float) initialBackoffMillis, backoffAttempts - 1);
                break;
        }
        return new JobStatus(failureToReschedule, elapsedNowMillis + Math.min(delayMillis, 18000000), (long) JobStatus.NO_LATEST_RUNTIME, backoffAttempts);
    }

    private JobStatus getRescheduleJobForPeriodic(JobStatus periodicToReschedule) {
        long elapsedNow = SystemClock.elapsedRealtime();
        long newEarliestRunTimeElapsed = elapsedNow + Math.max(periodicToReschedule.getLatestRunTimeElapsed() - elapsedNow, 0);
        return new JobStatus(periodicToReschedule, newEarliestRunTimeElapsed, newEarliestRunTimeElapsed + periodicToReschedule.getJob().getIntervalMillis(), (int) MSG_JOB_EXPIRED);
    }

    public void onJobCompleted(JobStatus jobStatus, boolean needsReschedule) {
        if (stopTrackingJob(jobStatus)) {
            if (needsReschedule) {
                startTrackingJob(getRescheduleJobForFailure(jobStatus));
            } else if (jobStatus.getJob().isPeriodic()) {
                startTrackingJob(getRescheduleJobForPeriodic(jobStatus));
            }
            this.mHandler.obtainMessage(MSG_CHECK_JOB).sendToTarget();
        }
    }

    public void onControllerStateChanged() {
        this.mHandler.obtainMessage(MSG_CHECK_JOB).sendToTarget();
    }

    public void onRunJobNow(JobStatus jobStatus) {
        this.mHandler.obtainMessage(MSG_JOB_EXPIRED, jobStatus).sendToTarget();
    }

    void dumpInternal(PrintWriter pw) {
        long now = SystemClock.elapsedRealtime();
        synchronized (this.mJobs) {
            int i;
            pw.print("Started users: ");
            for (i = MSG_JOB_EXPIRED; i < this.mStartedUsers.size(); i += MSG_CHECK_JOB) {
                pw.print("u" + this.mStartedUsers.get(i) + " ");
            }
            pw.println();
            pw.println("Registered jobs:");
            if (this.mJobs.size() > 0) {
                ArraySet<JobStatus> jobs = this.mJobs.getJobs();
                for (i = MSG_JOB_EXPIRED; i < jobs.size(); i += MSG_CHECK_JOB) {
                    ((JobStatus) jobs.valueAt(i)).dump(pw, "  ");
                }
            } else {
                pw.println("  None.");
            }
            for (i = MSG_JOB_EXPIRED; i < this.mControllers.size(); i += MSG_CHECK_JOB) {
                pw.println();
                ((StateController) this.mControllers.get(i)).dumpControllerState(pw);
            }
            pw.println();
            pw.println("Pending:");
            for (i = MSG_JOB_EXPIRED; i < this.mPendingJobs.size(); i += MSG_CHECK_JOB) {
                pw.println(((JobStatus) this.mPendingJobs.get(i)).hashCode());
            }
            pw.println();
            pw.println("Active jobs:");
            for (i = MSG_JOB_EXPIRED; i < this.mActiveServices.size(); i += MSG_CHECK_JOB) {
                JobServiceContext jsc = (JobServiceContext) this.mActiveServices.get(i);
                if (!jsc.isAvailable()) {
                    long timeout = jsc.getTimeoutElapsed();
                    pw.print("Running for: ");
                    pw.print((now - jsc.getExecutionStartTimeElapsed()) / 1000);
                    pw.print("s timeout=");
                    pw.print(timeout);
                    pw.print(" fromnow=");
                    pw.println(timeout - now);
                    jsc.getRunningJob().dump(pw, "  ");
                }
            }
            pw.println();
            pw.print("mReadyToRock=");
            pw.println(this.mReadyToRock);
        }
        pw.println();
    }
}
