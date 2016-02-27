package com.android.server.job;

import android.app.job.JobInfo;
import android.app.job.JobInfo.Builder;
import android.content.ComponentName;
import android.content.Context;
import android.os.Environment;
import android.os.Handler;
import android.os.PersistableBundle;
import android.os.SystemClock;
import android.os.UserHandle;
import android.util.ArraySet;
import android.util.AtomicFile;
import android.util.Pair;
import android.util.Slog;
import android.util.Xml;
import com.android.internal.util.FastXmlSerializer;
import com.android.server.IoThread;
import com.android.server.job.controllers.JobStatus;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class JobStore {
    private static final boolean DEBUG = false;
    private static final int JOBS_FILE_VERSION = 0;
    private static final int MAX_OPS_BEFORE_WRITE = 1;
    private static final String TAG = "JobStore";
    private static final String XML_TAG_EXTRAS = "extras";
    private static final String XML_TAG_ONEOFF = "one-off";
    private static final String XML_TAG_PARAMS_CONSTRAINTS = "constraints";
    private static final String XML_TAG_PERIODIC = "periodic";
    private static JobStore sSingleton;
    private static final Object sSingletonLock;
    final Context mContext;
    private int mDirtyOperations;
    private final Handler mIoHandler;
    final ArraySet<JobStatus> mJobSet;
    private final AtomicFile mJobsFile;

    private class ReadJobMapFromDiskRunnable implements Runnable {
        private final ArraySet<JobStatus> jobSet;

        ReadJobMapFromDiskRunnable(ArraySet<JobStatus> jobSet) {
            this.jobSet = jobSet;
        }

        public void run() {
            try {
                FileInputStream fis = JobStore.this.mJobsFile.openRead();
                synchronized (JobStore.this) {
                    List<JobStatus> jobs = readJobMapImpl(fis);
                    if (jobs != null) {
                        for (int i = JobStore.JOBS_FILE_VERSION; i < jobs.size(); i += JobStore.MAX_OPS_BEFORE_WRITE) {
                            this.jobSet.add(jobs.get(i));
                        }
                    }
                }
                fis.close();
            } catch (FileNotFoundException e) {
            } catch (XmlPullParserException e2) {
            } catch (IOException e3) {
            }
        }

        private List<JobStatus> readJobMapImpl(FileInputStream fis) throws XmlPullParserException, IOException {
            XmlPullParser parser = Xml.newPullParser();
            parser.setInput(fis, StandardCharsets.UTF_8.name());
            int eventType = parser.getEventType();
            while (eventType != 2 && eventType != JobStore.MAX_OPS_BEFORE_WRITE) {
                eventType = parser.next();
                Slog.d(JobStore.TAG, "Start tag: " + parser.getName());
            }
            if (eventType == JobStore.MAX_OPS_BEFORE_WRITE) {
                return null;
            }
            if (!"job-info".equals(parser.getName())) {
                return null;
            }
            List<JobStatus> jobs = new ArrayList();
            try {
                if (Integer.valueOf(parser.getAttributeValue(null, "version")).intValue() != 0) {
                    Slog.d(JobStore.TAG, "Invalid version number, aborting jobs file read.");
                    return null;
                }
                eventType = parser.next();
                do {
                    if (eventType == 2) {
                        if ("job".equals(parser.getName())) {
                            JobStatus persistedJob = restoreJobFromXml(parser);
                            if (persistedJob != null) {
                                jobs.add(persistedJob);
                            } else {
                                Slog.d(JobStore.TAG, "Error reading job from file.");
                            }
                        }
                    }
                    eventType = parser.next();
                } while (eventType != JobStore.MAX_OPS_BEFORE_WRITE);
                return jobs;
            } catch (NumberFormatException e) {
                Slog.e(JobStore.TAG, "Invalid version number, aborting jobs file read.");
                return null;
            }
        }

        private JobStatus restoreJobFromXml(XmlPullParser parser) throws XmlPullParserException, IOException {
            try {
                int eventType;
                Builder jobBuilder = buildBuilderFromXml(parser);
                jobBuilder.setPersisted(true);
                int uid = Integer.valueOf(parser.getAttributeValue(null, "uid")).intValue();
                do {
                    eventType = parser.next();
                } while (eventType == 4);
                if (eventType != 2 || !JobStore.XML_TAG_PARAMS_CONSTRAINTS.equals(parser.getName())) {
                    return null;
                }
                try {
                    buildConstraintsFromXml(jobBuilder, parser);
                    parser.next();
                    do {
                        eventType = parser.next();
                    } while (eventType == 4);
                    if (eventType != 2) {
                        return null;
                    }
                    try {
                        Pair<Long, Long> runtimes = buildExecutionTimesFromXml(parser);
                        if (JobStore.XML_TAG_PERIODIC.equals(parser.getName())) {
                            try {
                                jobBuilder.setPeriodic(Long.valueOf(parser.getAttributeValue(null, "period")).longValue());
                            } catch (NumberFormatException e) {
                                Slog.d(JobStore.TAG, "Error reading periodic execution criteria, skipping.");
                                return null;
                            }
                        } else if (!JobStore.XML_TAG_ONEOFF.equals(parser.getName())) {
                            return null;
                        } else {
                            try {
                                if (((Long) runtimes.first).longValue() != 0) {
                                    jobBuilder.setMinimumLatency(((Long) runtimes.first).longValue() - SystemClock.elapsedRealtime());
                                }
                                if (((Long) runtimes.second).longValue() != JobStatus.NO_LATEST_RUNTIME) {
                                    jobBuilder.setOverrideDeadline(((Long) runtimes.second).longValue() - SystemClock.elapsedRealtime());
                                }
                            } catch (NumberFormatException e2) {
                                Slog.d(JobStore.TAG, "Error reading job execution criteria, skipping.");
                                return null;
                            }
                        }
                        maybeBuildBackoffPolicyFromXml(jobBuilder, parser);
                        parser.nextTag();
                        do {
                            eventType = parser.next();
                        } while (eventType == 4);
                        if (eventType != 2 || !JobStore.XML_TAG_EXTRAS.equals(parser.getName())) {
                            return null;
                        }
                        jobBuilder.setExtras(PersistableBundle.restoreFromXml(parser));
                        parser.nextTag();
                        return new JobStatus(jobBuilder.build(), uid, ((Long) runtimes.first).longValue(), ((Long) runtimes.second).longValue());
                    } catch (NumberFormatException e3) {
                        return null;
                    }
                } catch (NumberFormatException e4) {
                    Slog.d(JobStore.TAG, "Error reading constraints, skipping.");
                    return null;
                }
            } catch (NumberFormatException e5) {
                Slog.e(JobStore.TAG, "Error parsing job's required fields, skipping");
                return null;
            }
        }

        private Builder buildBuilderFromXml(XmlPullParser parser) throws NumberFormatException {
            return new Builder(Integer.valueOf(parser.getAttributeValue(null, "jobid")).intValue(), new ComponentName(parser.getAttributeValue(null, "package"), parser.getAttributeValue(null, "class")));
        }

        private void buildConstraintsFromXml(Builder jobBuilder, XmlPullParser parser) {
            if (parser.getAttributeValue(null, "unmetered") != null) {
                jobBuilder.setRequiredNetworkType(2);
            }
            if (parser.getAttributeValue(null, "connectivity") != null) {
                jobBuilder.setRequiredNetworkType(JobStore.MAX_OPS_BEFORE_WRITE);
            }
            if (parser.getAttributeValue(null, "idle") != null) {
                jobBuilder.setRequiresDeviceIdle(true);
            }
            if (parser.getAttributeValue(null, "charging") != null) {
                jobBuilder.setRequiresCharging(true);
            }
        }

        private void maybeBuildBackoffPolicyFromXml(Builder jobBuilder, XmlPullParser parser) {
            String val = parser.getAttributeValue(null, "initial-backoff");
            if (val != null) {
                jobBuilder.setBackoffCriteria(Long.valueOf(val).longValue(), Integer.valueOf(parser.getAttributeValue(null, "backoff-policy")).intValue());
            }
        }

        private Pair<Long, Long> buildExecutionTimesFromXml(XmlPullParser parser) throws NumberFormatException {
            long nowWallclock = System.currentTimeMillis();
            long nowElapsed = SystemClock.elapsedRealtime();
            long earliestRunTimeElapsed = 0;
            long latestRunTimeElapsed = JobStatus.NO_LATEST_RUNTIME;
            String val = parser.getAttributeValue(null, "deadline");
            if (val != null) {
                latestRunTimeElapsed = nowElapsed + Math.max(Long.valueOf(val).longValue() - nowWallclock, 0);
            }
            val = parser.getAttributeValue(null, "delay");
            if (val != null) {
                earliestRunTimeElapsed = nowElapsed + Math.max(Long.valueOf(val).longValue() - nowWallclock, 0);
            }
            return Pair.create(Long.valueOf(earliestRunTimeElapsed), Long.valueOf(latestRunTimeElapsed));
        }
    }

    private class WriteJobsMapToDiskRunnable implements Runnable {
        private WriteJobsMapToDiskRunnable() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void run() {
            /*
            r13 = this;
            r10 = android.os.SystemClock.elapsedRealtime();
            r9 = new java.util.ArrayList;
            r9.<init>();
            r12 = com.android.server.job.JobStore.this;
            monitor-enter(r12);
            r0 = 0;
        L_0x000d:
            r2 = com.android.server.job.JobStore.this;	 Catch:{ all -> 0x0041 }
            r2 = r2.mJobSet;	 Catch:{ all -> 0x0041 }
            r2 = r2.size();	 Catch:{ all -> 0x0041 }
            if (r0 >= r2) goto L_0x003c;
        L_0x0017:
            r2 = com.android.server.job.JobStore.this;	 Catch:{ all -> 0x0041 }
            r2 = r2.mJobSet;	 Catch:{ all -> 0x0041 }
            r8 = r2.valueAt(r0);	 Catch:{ all -> 0x0041 }
            r8 = (com.android.server.job.controllers.JobStatus) r8;	 Catch:{ all -> 0x0041 }
            r1 = new com.android.server.job.controllers.JobStatus;	 Catch:{ all -> 0x0041 }
            r2 = r8.getJob();	 Catch:{ all -> 0x0041 }
            r3 = r8.getUid();	 Catch:{ all -> 0x0041 }
            r4 = r8.getEarliestRunTime();	 Catch:{ all -> 0x0041 }
            r6 = r8.getLatestRunTimeElapsed();	 Catch:{ all -> 0x0041 }
            r1.<init>(r2, r3, r4, r6);	 Catch:{ all -> 0x0041 }
            r9.add(r1);	 Catch:{ all -> 0x0041 }
            r0 = r0 + 1;
            goto L_0x000d;
        L_0x003c:
            monitor-exit(r12);	 Catch:{ all -> 0x0041 }
            r13.writeJobsMapImpl(r9);
            return;
        L_0x0041:
            r2 = move-exception;
            monitor-exit(r12);	 Catch:{ all -> 0x0041 }
            throw r2;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.job.JobStore.WriteJobsMapToDiskRunnable.run():void");
        }

        private void writeJobsMapImpl(List<JobStatus> jobList) {
            try {
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                XmlSerializer out = new FastXmlSerializer();
                out.setOutput(baos, StandardCharsets.UTF_8.name());
                out.startDocument(null, Boolean.valueOf(true));
                out.setFeature("http://xmlpull.org/v1/doc/features.html#indent-output", true);
                out.startTag(null, "job-info");
                out.attribute(null, "version", Integer.toString(JobStore.JOBS_FILE_VERSION));
                for (int i = JobStore.JOBS_FILE_VERSION; i < jobList.size(); i += JobStore.MAX_OPS_BEFORE_WRITE) {
                    JobStatus jobStatus = (JobStatus) jobList.get(i);
                    out.startTag(null, "job");
                    addIdentifierAttributesToJobTag(out, jobStatus);
                    writeConstraintsToXml(out, jobStatus);
                    writeExecutionCriteriaToXml(out, jobStatus);
                    writeBundleToXml(jobStatus.getExtras(), out);
                    out.endTag(null, "job");
                }
                out.endTag(null, "job-info");
                out.endDocument();
                FileOutputStream fos = JobStore.this.mJobsFile.startWrite();
                fos.write(baos.toByteArray());
                JobStore.this.mJobsFile.finishWrite(fos);
                JobStore.this.mDirtyOperations = JobStore.JOBS_FILE_VERSION;
            } catch (IOException e) {
            } catch (XmlPullParserException e2) {
            }
        }

        private void addIdentifierAttributesToJobTag(XmlSerializer out, JobStatus jobStatus) throws IOException {
            out.attribute(null, "jobid", Integer.toString(jobStatus.getJobId()));
            out.attribute(null, "package", jobStatus.getServiceComponent().getPackageName());
            out.attribute(null, "class", jobStatus.getServiceComponent().getClassName());
            out.attribute(null, "uid", Integer.toString(jobStatus.getUid()));
        }

        private void writeBundleToXml(PersistableBundle extras, XmlSerializer out) throws IOException, XmlPullParserException {
            out.startTag(null, JobStore.XML_TAG_EXTRAS);
            extras.saveToXml(out);
            out.endTag(null, JobStore.XML_TAG_EXTRAS);
        }

        private void writeConstraintsToXml(XmlSerializer out, JobStatus jobStatus) throws IOException {
            out.startTag(null, JobStore.XML_TAG_PARAMS_CONSTRAINTS);
            if (jobStatus.hasUnmeteredConstraint()) {
                out.attribute(null, "unmetered", Boolean.toString(true));
            }
            if (jobStatus.hasConnectivityConstraint()) {
                out.attribute(null, "connectivity", Boolean.toString(true));
            }
            if (jobStatus.hasIdleConstraint()) {
                out.attribute(null, "idle", Boolean.toString(true));
            }
            if (jobStatus.hasChargingConstraint()) {
                out.attribute(null, "charging", Boolean.toString(true));
            }
            out.endTag(null, JobStore.XML_TAG_PARAMS_CONSTRAINTS);
        }

        private void writeExecutionCriteriaToXml(XmlSerializer out, JobStatus jobStatus) throws IOException {
            JobInfo job = jobStatus.getJob();
            if (jobStatus.getJob().isPeriodic()) {
                out.startTag(null, JobStore.XML_TAG_PERIODIC);
                out.attribute(null, "period", Long.toString(job.getIntervalMillis()));
            } else {
                out.startTag(null, JobStore.XML_TAG_ONEOFF);
            }
            if (jobStatus.hasDeadlineConstraint()) {
                out.attribute(null, "deadline", Long.toString(System.currentTimeMillis() + (jobStatus.getLatestRunTimeElapsed() - SystemClock.elapsedRealtime())));
            }
            if (jobStatus.hasTimingDelayConstraint()) {
                out.attribute(null, "delay", Long.toString(System.currentTimeMillis() + (jobStatus.getEarliestRunTime() - SystemClock.elapsedRealtime())));
            }
            if (!(jobStatus.getJob().getInitialBackoffMillis() == 30000 && jobStatus.getJob().getBackoffPolicy() == JobStore.MAX_OPS_BEFORE_WRITE)) {
                out.attribute(null, "backoff-policy", Integer.toString(job.getBackoffPolicy()));
                out.attribute(null, "initial-backoff", Long.toString(job.getInitialBackoffMillis()));
            }
            if (job.isPeriodic()) {
                out.endTag(null, JobStore.XML_TAG_PERIODIC);
            } else {
                out.endTag(null, JobStore.XML_TAG_ONEOFF);
            }
        }
    }

    static {
        sSingletonLock = new Object();
    }

    static JobStore initAndGet(JobSchedulerService jobManagerService) {
        JobStore jobStore;
        synchronized (sSingletonLock) {
            if (sSingleton == null) {
                sSingleton = new JobStore(jobManagerService.getContext(), Environment.getDataDirectory());
            }
            jobStore = sSingleton;
        }
        return jobStore;
    }

    public static JobStore initAndGetForTesting(Context context, File dataDir) {
        JobStore jobStoreUnderTest = new JobStore(context, dataDir);
        jobStoreUnderTest.clear();
        return jobStoreUnderTest;
    }

    private JobStore(Context context, File dataDir) {
        this.mIoHandler = IoThread.getHandler();
        this.mContext = context;
        this.mDirtyOperations = JOBS_FILE_VERSION;
        File jobDir = new File(new File(dataDir, "system"), "job");
        jobDir.mkdirs();
        this.mJobsFile = new AtomicFile(new File(jobDir, "jobs.xml"));
        this.mJobSet = new ArraySet();
        readJobMapFromDisk(this.mJobSet);
    }

    public boolean add(JobStatus jobStatus) {
        boolean replaced = this.mJobSet.remove(jobStatus);
        this.mJobSet.add(jobStatus);
        if (jobStatus.isPersisted()) {
            maybeWriteStatusToDiskAsync();
        }
        return replaced;
    }

    public boolean containsJobIdForUid(int jobId, int uId) {
        for (int i = this.mJobSet.size() - 1; i >= 0; i--) {
            JobStatus ts = (JobStatus) this.mJobSet.valueAt(i);
            if (ts.getUid() == uId && ts.getJobId() == jobId) {
                return true;
            }
        }
        return DEBUG;
    }

    boolean containsJob(JobStatus jobStatus) {
        return this.mJobSet.contains(jobStatus);
    }

    public int size() {
        return this.mJobSet.size();
    }

    public boolean remove(JobStatus jobStatus) {
        boolean removed = this.mJobSet.remove(jobStatus);
        if (!removed) {
            return DEBUG;
        }
        if (!jobStatus.isPersisted()) {
            return removed;
        }
        maybeWriteStatusToDiskAsync();
        return removed;
    }

    public void clear() {
        this.mJobSet.clear();
        maybeWriteStatusToDiskAsync();
    }

    public List<JobStatus> getJobsByUser(int userHandle) {
        List<JobStatus> matchingJobs = new ArrayList();
        Iterator<JobStatus> it = this.mJobSet.iterator();
        while (it.hasNext()) {
            JobStatus ts = (JobStatus) it.next();
            if (UserHandle.getUserId(ts.getUid()) == userHandle) {
                matchingJobs.add(ts);
            }
        }
        return matchingJobs;
    }

    public List<JobStatus> getJobsByUid(int uid) {
        List<JobStatus> matchingJobs = new ArrayList();
        Iterator<JobStatus> it = this.mJobSet.iterator();
        while (it.hasNext()) {
            JobStatus ts = (JobStatus) it.next();
            if (ts.getUid() == uid) {
                matchingJobs.add(ts);
            }
        }
        return matchingJobs;
    }

    public JobStatus getJobByUidAndJobId(int uid, int jobId) {
        Iterator<JobStatus> it = this.mJobSet.iterator();
        while (it.hasNext()) {
            JobStatus ts = (JobStatus) it.next();
            if (ts.getUid() == uid && ts.getJobId() == jobId) {
                return ts;
            }
        }
        return null;
    }

    public ArraySet<JobStatus> getJobs() {
        return this.mJobSet;
    }

    private void maybeWriteStatusToDiskAsync() {
        this.mDirtyOperations += MAX_OPS_BEFORE_WRITE;
        if (this.mDirtyOperations >= MAX_OPS_BEFORE_WRITE) {
            this.mIoHandler.post(new WriteJobsMapToDiskRunnable());
        }
    }

    public void readJobMapFromDisk(ArraySet<JobStatus> jobSet) {
        new ReadJobMapFromDiskRunnable(jobSet).run();
    }
}
