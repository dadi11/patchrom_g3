package com.android.server.job;

import android.app.ActivityManager;
import android.app.job.IJobCallback.Stub;
import android.app.job.IJobService;
import android.app.job.JobParameters;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.WorkSource;
import android.util.Slog;
import com.android.internal.annotations.GuardedBy;
import com.android.internal.app.IBatteryStats;
import com.android.server.job.controllers.JobStatus;
import java.util.concurrent.atomic.AtomicBoolean;

public class JobServiceContext extends Stub implements ServiceConnection {
    private static final boolean DEBUG = false;
    private static final long EXECUTING_TIMESLICE_MILLIS = 60000;
    private static final int MSG_CALLBACK = 1;
    private static final int MSG_CANCEL = 3;
    private static final int MSG_SERVICE_BOUND = 2;
    private static final int MSG_SHUTDOWN_EXECUTION = 4;
    private static final int MSG_TIMEOUT = 0;
    private static final long OP_TIMEOUT_MILLIS = 8000;
    private static final String TAG = "JobServiceContext";
    static final int VERB_BINDING = 0;
    static final int VERB_EXECUTING = 2;
    static final int VERB_FINISHED = 4;
    static final int VERB_STARTING = 1;
    static final int VERB_STOPPING = 3;
    private static final String[] VERB_STRINGS;
    private static final int defaultMaxActiveJobsPerService;
    @GuardedBy("mLock")
    private boolean mAvailable;
    private final IBatteryStats mBatteryStats;
    private final Handler mCallbackHandler;
    private AtomicBoolean mCancelled;
    private final JobCompletedListener mCompletedListener;
    private final Context mContext;
    private long mExecutionStartTimeElapsed;
    private final Object mLock;
    private JobParameters mParams;
    private JobStatus mRunningJob;
    private long mTimeoutElapsed;
    int mVerb;
    private WakeLock mWakeLock;
    IJobService service;

    private class JobServiceHandler extends Handler {
        JobServiceHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message message) {
            boolean workOngoing = true;
            switch (message.what) {
                case JobServiceContext.VERB_BINDING /*0*/:
                    handleOpTimeoutH();
                case JobServiceContext.VERB_STARTING /*1*/:
                    JobServiceContext.this.removeOpTimeOut();
                    if (JobServiceContext.this.mVerb == JobServiceContext.VERB_STARTING) {
                        if (message.arg2 != JobServiceContext.VERB_STARTING) {
                            workOngoing = JobServiceContext.DEBUG;
                        }
                        handleStartedH(workOngoing);
                    } else if (JobServiceContext.this.mVerb == JobServiceContext.VERB_EXECUTING || JobServiceContext.this.mVerb == JobServiceContext.VERB_STOPPING) {
                        boolean reschedule;
                        if (message.arg2 == JobServiceContext.VERB_STARTING) {
                            reschedule = true;
                        } else {
                            reschedule = JobServiceContext.DEBUG;
                        }
                        handleFinishedH(reschedule);
                    }
                case JobServiceContext.VERB_EXECUTING /*2*/:
                    JobServiceContext.this.removeOpTimeOut();
                    handleServiceBoundH();
                case JobServiceContext.VERB_STOPPING /*3*/:
                    handleCancelH();
                case JobServiceContext.VERB_FINISHED /*4*/:
                    closeAndCleanupJobH(true);
                default:
                    Slog.e(JobServiceContext.TAG, "Unrecognised message: " + message);
            }
        }

        private void handleServiceBoundH() {
            if (JobServiceContext.this.mVerb != 0) {
                Slog.e(JobServiceContext.TAG, "Sending onStartJob for a job that isn't pending. " + JobServiceContext.VERB_STRINGS[JobServiceContext.this.mVerb]);
                closeAndCleanupJobH(JobServiceContext.DEBUG);
            } else if (JobServiceContext.this.mCancelled.get()) {
                closeAndCleanupJobH(true);
            } else {
                try {
                    JobServiceContext.this.mVerb = JobServiceContext.VERB_STARTING;
                    JobServiceContext.this.scheduleOpTimeOut();
                    JobServiceContext.this.service.startJob(JobServiceContext.this.mParams);
                } catch (RemoteException e) {
                    Slog.e(JobServiceContext.TAG, "Error sending onStart message to '" + JobServiceContext.this.mRunningJob.getServiceComponent().getShortClassName() + "' ", e);
                }
            }
        }

        private void handleStartedH(boolean workOngoing) {
            switch (JobServiceContext.this.mVerb) {
                case JobServiceContext.VERB_STARTING /*1*/:
                    JobServiceContext.this.mVerb = JobServiceContext.VERB_EXECUTING;
                    if (!workOngoing) {
                        handleFinishedH(JobServiceContext.DEBUG);
                    } else if (JobServiceContext.this.mCancelled.get()) {
                        handleCancelH();
                    } else {
                        JobServiceContext.this.scheduleOpTimeOut();
                    }
                default:
                    Slog.e(JobServiceContext.TAG, "Handling started job but job wasn't starting! Was " + JobServiceContext.VERB_STRINGS[JobServiceContext.this.mVerb] + ".");
            }
        }

        private void handleFinishedH(boolean reschedule) {
            switch (JobServiceContext.this.mVerb) {
                case JobServiceContext.VERB_EXECUTING /*2*/:
                case JobServiceContext.VERB_STOPPING /*3*/:
                    closeAndCleanupJobH(reschedule);
                default:
                    Slog.e(JobServiceContext.TAG, "Got an execution complete message for a job that wasn't beingexecuted. Was " + JobServiceContext.VERB_STRINGS[JobServiceContext.this.mVerb] + ".");
            }
        }

        private void handleCancelH() {
            if (JobServiceContext.this.mRunningJob != null) {
                switch (JobServiceContext.this.mVerb) {
                    case JobServiceContext.VERB_BINDING /*0*/:
                    case JobServiceContext.VERB_STARTING /*1*/:
                        JobServiceContext.this.mCancelled.set(true);
                    case JobServiceContext.VERB_EXECUTING /*2*/:
                        if (!hasMessages(JobServiceContext.VERB_STARTING)) {
                            sendStopMessageH();
                        }
                    case JobServiceContext.VERB_STOPPING /*3*/:
                    default:
                        Slog.e(JobServiceContext.TAG, "Cancelling a job without a valid verb: " + JobServiceContext.this.mVerb);
                }
            }
        }

        private void handleOpTimeoutH() {
            switch (JobServiceContext.this.mVerb) {
                case JobServiceContext.VERB_BINDING /*0*/:
                    Slog.e(JobServiceContext.TAG, "Time-out while trying to bind " + JobServiceContext.this.mRunningJob.toShortString() + ", dropping.");
                    closeAndCleanupJobH(JobServiceContext.DEBUG);
                case JobServiceContext.VERB_STARTING /*1*/:
                    Slog.e(JobServiceContext.TAG, "No response from client for onStartJob '" + JobServiceContext.this.mRunningJob.toShortString());
                    closeAndCleanupJobH(JobServiceContext.DEBUG);
                case JobServiceContext.VERB_EXECUTING /*2*/:
                    Slog.i(JobServiceContext.TAG, "Client timed out while executing (no jobFinished received). sending onStop. " + JobServiceContext.this.mRunningJob.toShortString());
                    sendStopMessageH();
                case JobServiceContext.VERB_STOPPING /*3*/:
                    Slog.e(JobServiceContext.TAG, "No response from client for onStopJob, '" + JobServiceContext.this.mRunningJob.toShortString());
                    closeAndCleanupJobH(true);
                default:
                    Slog.e(JobServiceContext.TAG, "Handling timeout for an invalid job state: " + JobServiceContext.this.mRunningJob.toShortString() + ", dropping.");
                    closeAndCleanupJobH(JobServiceContext.DEBUG);
            }
        }

        private void sendStopMessageH() {
            JobServiceContext.this.removeOpTimeOut();
            if (JobServiceContext.this.mVerb != JobServiceContext.VERB_EXECUTING) {
                Slog.e(JobServiceContext.TAG, "Sending onStopJob for a job that isn't started. " + JobServiceContext.this.mRunningJob);
                closeAndCleanupJobH(JobServiceContext.DEBUG);
                return;
            }
            try {
                JobServiceContext.this.mVerb = JobServiceContext.VERB_STOPPING;
                JobServiceContext.this.scheduleOpTimeOut();
                JobServiceContext.this.service.stopJob(JobServiceContext.this.mParams);
            } catch (RemoteException e) {
                Slog.e(JobServiceContext.TAG, "Error sending onStopJob to client.", e);
                closeAndCleanupJobH(JobServiceContext.DEBUG);
            }
        }

        private void closeAndCleanupJobH(boolean reschedule) {
            synchronized (JobServiceContext.this.mLock) {
                if (JobServiceContext.this.mVerb == JobServiceContext.VERB_FINISHED) {
                    return;
                }
                JobStatus completedJob = JobServiceContext.this.mRunningJob;
                try {
                    JobServiceContext.this.mBatteryStats.noteJobFinish(JobServiceContext.this.mRunningJob.getName(), JobServiceContext.this.mRunningJob.getUid());
                } catch (RemoteException e) {
                }
                if (JobServiceContext.this.mWakeLock != null) {
                    JobServiceContext.this.mWakeLock.release();
                }
                JobServiceContext.this.mContext.unbindService(JobServiceContext.this);
                JobServiceContext.this.mWakeLock = null;
                JobServiceContext.this.mRunningJob = null;
                JobServiceContext.this.mParams = null;
                JobServiceContext.this.mVerb = JobServiceContext.VERB_FINISHED;
                JobServiceContext.this.mCancelled.set(JobServiceContext.DEBUG);
                JobServiceContext.this.service = null;
                JobServiceContext.this.mAvailable = true;
                JobServiceContext.this.removeOpTimeOut();
                removeMessages(JobServiceContext.VERB_STARTING);
                removeMessages(JobServiceContext.VERB_EXECUTING);
                removeMessages(JobServiceContext.VERB_STOPPING);
                removeMessages(JobServiceContext.VERB_FINISHED);
                JobServiceContext.this.mCompletedListener.onJobCompleted(completedJob, reschedule);
            }
        }
    }

    static {
        defaultMaxActiveJobsPerService = ActivityManager.isLowRamDeviceStatic() ? VERB_STARTING : VERB_STOPPING;
        VERB_STRINGS = new String[]{"VERB_BINDING", "VERB_STARTING", "VERB_EXECUTING", "VERB_STOPPING", "VERB_FINISHED"};
    }

    JobServiceContext(JobSchedulerService service, IBatteryStats batteryStats, Looper looper) {
        this(service.getContext(), batteryStats, service, looper);
    }

    JobServiceContext(Context context, IBatteryStats batteryStats, JobCompletedListener completedListener, Looper looper) {
        this.mCancelled = new AtomicBoolean();
        this.mLock = new Object();
        this.mContext = context;
        this.mBatteryStats = batteryStats;
        this.mCallbackHandler = new JobServiceHandler(looper);
        this.mCompletedListener = completedListener;
        this.mAvailable = true;
    }

    boolean executeRunnableJob(JobStatus job) {
        synchronized (this.mLock) {
            if (this.mAvailable) {
                this.mRunningJob = job;
                this.mParams = new JobParameters(this, job.getJobId(), job.getExtras(), !job.isConstraintsSatisfied() ? true : DEBUG);
                this.mExecutionStartTimeElapsed = SystemClock.elapsedRealtime();
                this.mVerb = VERB_BINDING;
                scheduleOpTimeOut();
                if (this.mContext.bindServiceAsUser(new Intent().setComponent(job.getServiceComponent()), this, 5, new UserHandle(job.getUserId()))) {
                    try {
                        this.mBatteryStats.noteJobStart(job.getName(), job.getUid());
                    } catch (RemoteException e) {
                    }
                    this.mAvailable = DEBUG;
                    return true;
                }
                this.mRunningJob = null;
                this.mParams = null;
                this.mExecutionStartTimeElapsed = 0;
                this.mVerb = VERB_FINISHED;
                removeOpTimeOut();
                return DEBUG;
            }
            Slog.e(TAG, "Starting new runnable but context is unavailable > Error.");
            return DEBUG;
        }
    }

    JobStatus getRunningJob() {
        JobStatus jobStatus;
        synchronized (this.mLock) {
            jobStatus = this.mRunningJob;
        }
        return jobStatus;
    }

    void cancelExecutingJob() {
        this.mCallbackHandler.obtainMessage(VERB_STOPPING).sendToTarget();
    }

    boolean isAvailable() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mAvailable;
        }
        return z;
    }

    long getExecutionStartTimeElapsed() {
        return this.mExecutionStartTimeElapsed;
    }

    long getTimeoutElapsed() {
        return this.mTimeoutElapsed;
    }

    public void jobFinished(int jobId, boolean reschedule) {
        if (verifyCallingUid()) {
            this.mCallbackHandler.obtainMessage(VERB_STARTING, jobId, reschedule ? VERB_STARTING : VERB_BINDING).sendToTarget();
        }
    }

    public void acknowledgeStopMessage(int jobId, boolean reschedule) {
        if (verifyCallingUid()) {
            this.mCallbackHandler.obtainMessage(VERB_STARTING, jobId, reschedule ? VERB_STARTING : VERB_BINDING).sendToTarget();
        }
    }

    public void acknowledgeStartMessage(int jobId, boolean ongoing) {
        if (verifyCallingUid()) {
            this.mCallbackHandler.obtainMessage(VERB_STARTING, jobId, ongoing ? VERB_STARTING : VERB_BINDING).sendToTarget();
        }
    }

    public void onServiceConnected(ComponentName name, IBinder service) {
        if (name.equals(this.mRunningJob.getServiceComponent())) {
            this.service = IJobService.Stub.asInterface(service);
            this.mWakeLock = ((PowerManager) this.mContext.getSystemService("power")).newWakeLock(VERB_STARTING, this.mRunningJob.getTag());
            this.mWakeLock.setWorkSource(new WorkSource(this.mRunningJob.getUid()));
            this.mWakeLock.setReferenceCounted(DEBUG);
            this.mWakeLock.acquire();
            this.mCallbackHandler.obtainMessage(VERB_EXECUTING).sendToTarget();
            return;
        }
        this.mCallbackHandler.obtainMessage(VERB_FINISHED).sendToTarget();
    }

    public void onServiceDisconnected(ComponentName name) {
        this.mCallbackHandler.obtainMessage(VERB_FINISHED).sendToTarget();
    }

    private boolean verifyCallingUid() {
        if (this.mRunningJob == null || Binder.getCallingUid() != this.mRunningJob.getUid()) {
            return DEBUG;
        }
        return true;
    }

    private void scheduleOpTimeOut() {
        removeOpTimeOut();
        long timeoutMillis = this.mVerb == VERB_EXECUTING ? EXECUTING_TIMESLICE_MILLIS : OP_TIMEOUT_MILLIS;
        this.mCallbackHandler.sendMessageDelayed(this.mCallbackHandler.obtainMessage(VERB_BINDING), timeoutMillis);
        this.mTimeoutElapsed = SystemClock.elapsedRealtime() + timeoutMillis;
    }

    private void removeOpTimeOut() {
        this.mCallbackHandler.removeMessages(VERB_BINDING);
    }
}
