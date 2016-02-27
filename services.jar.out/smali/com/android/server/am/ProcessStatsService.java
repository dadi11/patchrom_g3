package com.android.server.am;

import android.os.Binder;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.ParcelFileDescriptor.AutoCloseInputStream;
import android.os.ParcelFileDescriptor.AutoCloseOutputStream;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.util.ArrayMap;
import android.util.AtomicFile;
import android.util.Slog;
import android.util.SparseArray;
import android.util.TimeUtils;
import com.android.internal.app.IProcessStats.Stub;
import com.android.internal.app.ProcessStats;
import com.android.internal.app.ProcessStats.PackageState;
import com.android.internal.app.ProcessStats.ProcessState;
import com.android.internal.app.ProcessStats.ServiceState;
import com.android.internal.os.BackgroundThread;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

public final class ProcessStatsService extends Stub {
    static final boolean DEBUG = false;
    static final int MAX_HISTORIC_STATES = 8;
    static final String STATE_FILE_CHECKIN_SUFFIX = ".ci";
    static final String STATE_FILE_PREFIX = "state-";
    static final String STATE_FILE_SUFFIX = ".bin";
    static final String TAG = "ProcessStatsService";
    static long WRITE_PERIOD;
    final ActivityManagerService mAm;
    final File mBaseDir;
    boolean mCommitPending;
    AtomicFile mFile;
    int mLastMemOnlyState;
    long mLastWriteTime;
    boolean mMemFactorLowered;
    Parcel mPendingWrite;
    boolean mPendingWriteCommitted;
    AtomicFile mPendingWriteFile;
    final Object mPendingWriteLock;
    ProcessStats mProcessStats;
    boolean mShuttingDown;
    final ReentrantLock mWriteLock;

    /* renamed from: com.android.server.am.ProcessStatsService.1 */
    class C01441 implements Runnable {
        C01441() {
        }

        public void run() {
            synchronized (ProcessStatsService.this.mAm) {
                if (ProcessStatsService.this.mProcessStats.evaluateSystemProperties(ProcessStatsService.DEBUG)) {
                    ProcessStats processStats = ProcessStatsService.this.mProcessStats;
                    processStats.mFlags |= 4;
                    ProcessStatsService.this.writeStateLocked(true, true);
                    ProcessStatsService.this.mProcessStats.evaluateSystemProperties(true);
                }
            }
        }
    }

    /* renamed from: com.android.server.am.ProcessStatsService.2 */
    class C01452 implements Runnable {
        C01452() {
        }

        public void run() {
            ProcessStatsService.this.performWriteState();
        }
    }

    /* renamed from: com.android.server.am.ProcessStatsService.3 */
    class C01463 extends Thread {
        final /* synthetic */ ParcelFileDescriptor[] val$fds;
        final /* synthetic */ byte[] val$outData;

        C01463(String x0, ParcelFileDescriptor[] parcelFileDescriptorArr, byte[] bArr) {
            this.val$fds = parcelFileDescriptorArr;
            this.val$outData = bArr;
            super(x0);
        }

        public void run() {
            FileOutputStream fout = new AutoCloseOutputStream(this.val$fds[1]);
            try {
                fout.write(this.val$outData);
                fout.close();
            } catch (IOException e) {
                Slog.w(ProcessStatsService.TAG, "Failure writing pipe", e);
            }
        }
    }

    static {
        WRITE_PERIOD = 1800000;
    }

    public ProcessStatsService(ActivityManagerService am, File file) {
        this.mLastMemOnlyState = -1;
        this.mWriteLock = new ReentrantLock();
        this.mPendingWriteLock = new Object();
        this.mAm = am;
        this.mBaseDir = file;
        this.mBaseDir.mkdirs();
        this.mProcessStats = new ProcessStats(true);
        updateFile();
        SystemProperties.addChangeCallback(new C01441());
    }

    public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
        try {
            return super.onTransact(code, data, reply, flags);
        } catch (RuntimeException e) {
            if (!(e instanceof SecurityException)) {
                Slog.wtf(TAG, "Process Stats Crash", e);
            }
            throw e;
        }
    }

    public ProcessState getProcessStateLocked(String packageName, int uid, int versionCode, String processName) {
        return this.mProcessStats.getProcessStateLocked(packageName, uid, versionCode, processName);
    }

    public ServiceState getServiceStateLocked(String packageName, int uid, int versionCode, String processName, String className) {
        return this.mProcessStats.getServiceStateLocked(packageName, uid, versionCode, processName, className);
    }

    public boolean isMemFactorLowered() {
        return this.mMemFactorLowered;
    }

    public boolean setMemFactorLocked(int memFactor, boolean screenOn, long now) {
        this.mMemFactorLowered = memFactor < this.mLastMemOnlyState ? true : DEBUG;
        this.mLastMemOnlyState = memFactor;
        if (screenOn) {
            memFactor += 4;
        }
        if (memFactor == this.mProcessStats.mMemFactor) {
            return DEBUG;
        }
        if (this.mProcessStats.mMemFactor != -1) {
            long[] jArr = this.mProcessStats.mMemFactorDurations;
            int i = this.mProcessStats.mMemFactor;
            jArr[i] = jArr[i] + (now - this.mProcessStats.mStartTime);
        }
        this.mProcessStats.mMemFactor = memFactor;
        this.mProcessStats.mStartTime = now;
        ArrayMap<String, SparseArray<SparseArray<PackageState>>> pmap = this.mProcessStats.mPackages.getMap();
        for (int ipkg = pmap.size() - 1; ipkg >= 0; ipkg--) {
            SparseArray<SparseArray<PackageState>> uids = (SparseArray) pmap.valueAt(ipkg);
            for (int iuid = uids.size() - 1; iuid >= 0; iuid--) {
                SparseArray<PackageState> vers = (SparseArray) uids.valueAt(iuid);
                for (int iver = vers.size() - 1; iver >= 0; iver--) {
                    ArrayMap<String, ServiceState> services = ((PackageState) vers.valueAt(iver)).mServices;
                    for (int isvc = services.size() - 1; isvc >= 0; isvc--) {
                        ServiceState service = (ServiceState) services.valueAt(isvc);
                        if (service.isRestarting()) {
                            service.setRestarting(true, memFactor, now);
                        } else if (service.isInUse()) {
                            if (service.mStartedState != -1) {
                                service.setStarted(true, memFactor, now);
                            }
                            if (service.mBoundState != -1) {
                                service.setBound(true, memFactor, now);
                            }
                            if (service.mExecState != -1) {
                                service.setExecuting(true, memFactor, now);
                            }
                        }
                    }
                }
            }
        }
        return true;
    }

    public int getMemFactorLocked() {
        return this.mProcessStats.mMemFactor != -1 ? this.mProcessStats.mMemFactor : 0;
    }

    public void addSysMemUsageLocked(long cachedMem, long freeMem, long zramMem, long kernelMem, long nativeMem) {
        this.mProcessStats.addSysMemUsage(cachedMem, freeMem, zramMem, kernelMem, nativeMem);
    }

    public boolean shouldWriteNowLocked(long now) {
        if (now <= this.mLastWriteTime + WRITE_PERIOD) {
            return DEBUG;
        }
        if (SystemClock.elapsedRealtime() <= this.mProcessStats.mTimePeriodStartRealtime + ProcessStats.COMMIT_PERIOD || SystemClock.uptimeMillis() <= this.mProcessStats.mTimePeriodStartUptime + ProcessStats.COMMIT_UPTIME_PERIOD) {
            return true;
        }
        this.mCommitPending = true;
        return true;
    }

    public void shutdownLocked() {
        Slog.w(TAG, "Writing process stats before shutdown...");
        ProcessStats processStats = this.mProcessStats;
        processStats.mFlags |= 2;
        writeStateSyncLocked();
        this.mShuttingDown = true;
    }

    public void writeStateAsyncLocked() {
        writeStateLocked(DEBUG);
    }

    public void writeStateSyncLocked() {
        writeStateLocked(true);
    }

    private void writeStateLocked(boolean sync) {
        if (!this.mShuttingDown) {
            boolean commitPending = this.mCommitPending;
            this.mCommitPending = DEBUG;
            writeStateLocked(sync, commitPending);
        }
    }

    public void writeStateLocked(boolean sync, boolean commit) {
        synchronized (this.mPendingWriteLock) {
            long now = SystemClock.uptimeMillis();
            if (this.mPendingWrite == null || !this.mPendingWriteCommitted) {
                this.mPendingWrite = Parcel.obtain();
                this.mProcessStats.mTimePeriodEndRealtime = SystemClock.elapsedRealtime();
                this.mProcessStats.mTimePeriodEndUptime = now;
                if (commit) {
                    ProcessStats processStats = this.mProcessStats;
                    processStats.mFlags |= 1;
                }
                this.mProcessStats.writeToParcel(this.mPendingWrite, 0);
                this.mPendingWriteFile = new AtomicFile(this.mFile.getBaseFile());
                this.mPendingWriteCommitted = commit;
            }
            if (commit) {
                this.mProcessStats.resetSafely();
                updateFile();
            }
            this.mLastWriteTime = SystemClock.uptimeMillis();
            Slog.i(TAG, "Prepared write state in " + (SystemClock.uptimeMillis() - now) + "ms");
            if (sync) {
                performWriteState();
                return;
            }
            BackgroundThread.getHandler().post(new C01452());
        }
    }

    private void updateFile() {
        this.mFile = new AtomicFile(new File(this.mBaseDir, STATE_FILE_PREFIX + this.mProcessStats.mTimePeriodStartClockStr + STATE_FILE_SUFFIX));
        this.mLastWriteTime = SystemClock.uptimeMillis();
    }

    void performWriteState() {
        synchronized (this.mPendingWriteLock) {
            Parcel data = this.mPendingWrite;
            AtomicFile file = this.mPendingWriteFile;
            this.mPendingWriteCommitted = DEBUG;
            if (data == null) {
                return;
            }
            this.mPendingWrite = null;
            this.mPendingWriteFile = null;
            this.mWriteLock.lock();
            FileOutputStream stream = null;
            try {
                stream = file.startWrite();
                stream.write(data.marshall());
                stream.flush();
                file.finishWrite(stream);
            } catch (IOException e) {
                Slog.w(TAG, "Error writing process statistics", e);
                file.failWrite(stream);
            } finally {
                data.recycle();
                trimHistoricStatesWriteLocked();
                this.mWriteLock.unlock();
            }
        }
    }

    boolean readLocked(ProcessStats stats, AtomicFile file) {
        try {
            FileInputStream stream = file.openRead();
            stats.read(stream);
            stream.close();
            if (stats.mReadError == null) {
                return true;
            }
            Slog.w(TAG, "Ignoring existing stats; " + stats.mReadError);
            return DEBUG;
        } catch (Throwable e) {
            stats.mReadError = "caught exception: " + e;
            Slog.e(TAG, "Error reading process statistics", e);
            return DEBUG;
        }
    }

    private ArrayList<String> getCommittedFiles(int minNum, boolean inclCurrent, boolean inclCheckedIn) {
        File[] files = this.mBaseDir.listFiles();
        if (files == null || files.length <= minNum) {
            return null;
        }
        ArrayList<String> filesArray = new ArrayList(files.length);
        String currentFile = this.mFile.getBaseFile().getPath();
        for (File file : files) {
            String fileStr = file.getPath();
            if ((inclCheckedIn || !fileStr.endsWith(STATE_FILE_CHECKIN_SUFFIX)) && (inclCurrent || !fileStr.equals(currentFile))) {
                filesArray.add(fileStr);
            }
        }
        Collections.sort(filesArray);
        return filesArray;
    }

    public void trimHistoricStatesWriteLocked() {
        ArrayList<String> filesArray = getCommittedFiles(MAX_HISTORIC_STATES, DEBUG, true);
        if (filesArray != null) {
            while (filesArray.size() > MAX_HISTORIC_STATES) {
                String file = (String) filesArray.remove(0);
                Slog.i(TAG, "Pruning old procstats: " + file);
                new File(file).delete();
            }
        }
    }

    boolean dumpFilteredProcessesCsvLocked(PrintWriter pw, String header, boolean sepScreenStates, int[] screenStates, boolean sepMemStates, int[] memStates, boolean sepProcStates, int[] procStates, long now, String reqPackage) {
        ArrayList<ProcessState> procs = this.mProcessStats.collectProcessesLocked(screenStates, memStates, procStates, procStates, now, reqPackage, DEBUG);
        if (procs.size() <= 0) {
            return DEBUG;
        }
        if (header != null) {
            pw.println(header);
        }
        ProcessStats.dumpProcessListCsv(pw, procs, sepScreenStates, screenStates, sepMemStates, memStates, sepProcStates, procStates, now);
        return true;
    }

    static int[] parseStateList(String[] states, int mult, String arg, boolean[] outSep, String[] outError) {
        int i;
        int[] iArr = null;
        ArrayList<Integer> res = new ArrayList();
        int lastPos = 0;
        for (i = 0; i <= arg.length(); i++) {
            char c;
            if (i < arg.length()) {
                c = arg.charAt(i);
            } else {
                c = '\u0000';
            }
            if (c == ',' || c == '+' || c == ' ' || c == '\u0000') {
                boolean isSep;
                if (c == ',') {
                    isSep = true;
                } else {
                    isSep = DEBUG;
                }
                if (lastPos != 0) {
                    if (!(c == '\u0000' || outSep[0] == isSep)) {
                        outError[0] = "inconsistent separators (can't mix ',' with '+')";
                        break;
                    }
                }
                outSep[0] = isSep;
                if (lastPos < i - 1) {
                    String str = arg.substring(lastPos, i);
                    for (int j = 0; j < states.length; j++) {
                        if (str.equals(states[j])) {
                            res.add(Integer.valueOf(j));
                            str = null;
                            break;
                        }
                    }
                    if (str != null) {
                        outError[0] = "invalid word \"" + str + "\"";
                        break;
                    }
                }
                lastPos = i + 1;
            }
        }
        iArr = new int[res.size()];
        for (i = 0; i < res.size(); i++) {
            iArr[i] = ((Integer) res.get(i)).intValue() * mult;
        }
        return iArr;
    }

    public byte[] getCurrentStats(List<ParcelFileDescriptor> historic) {
        int i;
        this.mAm.mContext.enforceCallingOrSelfPermission("android.permission.PACKAGE_USAGE_STATS", null);
        Parcel current = Parcel.obtain();
        synchronized (this.mAm) {
            long now = SystemClock.uptimeMillis();
            this.mProcessStats.mTimePeriodEndRealtime = SystemClock.elapsedRealtime();
            this.mProcessStats.mTimePeriodEndUptime = now;
            this.mProcessStats.writeToParcel(current, now, 0);
        }
        this.mWriteLock.lock();
        if (historic != null) {
            ArrayList<String> files;
            try {
                files = getCommittedFiles(0, DEBUG, true);
                if (files != null) {
                    i = files.size() - 1;
                    while (i >= 0) {
                        historic.add(ParcelFileDescriptor.open(new File((String) files.get(i)), 268435456));
                        i--;
                    }
                }
            } catch (IOException e) {
                Slog.w(TAG, "Failure opening procstat file " + ((String) files.get(i)), e);
            } catch (Throwable th) {
                this.mWriteLock.unlock();
            }
        }
        this.mWriteLock.unlock();
        return current.marshall();
    }

    public ParcelFileDescriptor getStatsOverTime(long minTime) {
        this.mAm.mContext.enforceCallingOrSelfPermission("android.permission.PACKAGE_USAGE_STATS", null);
        Parcel current = Parcel.obtain();
        synchronized (this.mAm) {
            long now = SystemClock.uptimeMillis();
            ProcessStats processStats = this.mProcessStats;
            processStats.mTimePeriodEndRealtime = SystemClock.elapsedRealtime();
            this.mProcessStats.mTimePeriodEndUptime = now;
            this.mProcessStats.writeToParcel(current, now, 0);
            long curTime = this.mProcessStats.mTimePeriodEndRealtime - this.mProcessStats.mTimePeriodStartRealtime;
        }
        this.mWriteLock.lock();
        if (curTime < minTime) {
            ArrayList<String> files = getCommittedFiles(0, DEBUG, true);
            if (files != null && files.size() > 0) {
                current.setDataPosition(0);
                ProcessStats stats = (ProcessStats) ProcessStats.CREATOR.createFromParcel(current);
                current.recycle();
                int i = files.size() - 1;
                while (i >= 0) {
                    if (stats.mTimePeriodEndRealtime - stats.mTimePeriodStartRealtime < minTime) {
                        AtomicFile file = new AtomicFile(new File((String) files.get(i)));
                        i--;
                        ProcessStats moreStats = new ProcessStats(DEBUG);
                        readLocked(moreStats, file);
                        if (moreStats.mReadError == null) {
                            stats.add(moreStats);
                            StringBuilder sb = new StringBuilder();
                            sb.append("Added stats: ");
                            sb.append(moreStats.mTimePeriodStartClockStr);
                            sb.append(", over ");
                            TimeUtils.formatDuration(moreStats.mTimePeriodEndRealtime - moreStats.mTimePeriodStartRealtime, sb);
                            Slog.i(TAG, sb.toString());
                        } else {
                            try {
                                Slog.w(TAG, "Failure reading " + ((String) files.get(i + 1)) + "; " + moreStats.mReadError);
                            } catch (IOException e) {
                                Slog.w(TAG, "Failed building output pipe", e);
                                return null;
                            } finally {
                                this.mWriteLock.unlock();
                            }
                        }
                    }
                }
                break;
                current = Parcel.obtain();
                stats.writeToParcel(current, 0);
            }
        }
        byte[] outData = current.marshall();
        current.recycle();
        ParcelFileDescriptor[] fds = ParcelFileDescriptor.createPipe();
        new C01463("ProcessStats pipe output", fds, outData).start();
        ParcelFileDescriptor parcelFileDescriptor = fds[0];
        this.mWriteLock.unlock();
        return parcelFileDescriptor;
    }

    public int getCurrentMemoryState() {
        int i;
        synchronized (this.mAm) {
            i = this.mLastMemOnlyState;
        }
        return i;
    }

    private void dumpAggregatedStats(PrintWriter pw, long aggregateHours, long now, String reqPackage, boolean isCompact, boolean dumpDetails, boolean dumpFullDetails, boolean dumpAll, boolean activeOnly) {
        ParcelFileDescriptor pfd = getStatsOverTime((((60 * aggregateHours) * 60) * 1000) - (ProcessStats.COMMIT_PERIOD / 2));
        if (pfd == null) {
            pw.println("Unable to build stats!");
            return;
        }
        ProcessStats stats = new ProcessStats(DEBUG);
        stats.read(new AutoCloseInputStream(pfd));
        if (stats.mReadError != null) {
            pw.print("Failure reading: ");
            pw.println(stats.mReadError);
        } else if (isCompact) {
            stats.dumpCheckinLocked(pw, reqPackage);
        } else if (dumpDetails || dumpFullDetails) {
            stats.dumpLocked(pw, reqPackage, now, !dumpFullDetails ? true : DEBUG, dumpAll, activeOnly);
        } else {
            stats.dumpSummaryLocked(pw, reqPackage, now, activeOnly);
        }
    }

    private static void dumpHelp(PrintWriter pw) {
        pw.println("Process stats (procstats) dump options:");
        pw.println("    [--checkin|-c|--csv] [--csv-screen] [--csv-proc] [--csv-mem]");
        pw.println("    [--details] [--full-details] [--current] [--hours N] [--last N]");
        pw.println("    [--max N] --active] [--commit] [--reset] [--clear] [--write] [-h]");
        pw.println("    [--start-testing] [--stop-testing] [<package.name>]");
        pw.println("  --checkin: perform a checkin: print and delete old committed states.");
        pw.println("  -c: print only state in checkin format.");
        pw.println("  --csv: output data suitable for putting in a spreadsheet.");
        pw.println("  --csv-screen: on, off.");
        pw.println("  --csv-mem: norm, mod, low, crit.");
        pw.println("  --csv-proc: pers, top, fore, vis, precept, backup,");
        pw.println("    service, home, prev, cached");
        pw.println("  --details: dump per-package details, not just summary.");
        pw.println("  --full-details: dump all timing and active state details.");
        pw.println("  --current: only dump current state.");
        pw.println("  --hours: aggregate over about N last hours.");
        pw.println("  --last: only show the last committed stats at index N (starting at 1).");
        pw.println("  --max: for -a, max num of historical batches to print.");
        pw.println("  --active: only show currently active processes/services.");
        pw.println("  --commit: commit current stats to disk and reset to start new stats.");
        pw.println("  --reset: reset current stats, without committing.");
        pw.println("  --clear: clear all stats; does both --reset and deletes old stats.");
        pw.println("  --write: write current in-memory stats to disk.");
        pw.println("  --read: replace current stats with last-written stats.");
        pw.println("  --start-testing: clear all stats and starting high frequency pss sampling.");
        pw.println("  --stop-testing: stop high frequency pss sampling.");
        pw.println("  -a: print everything.");
        pw.println("  -h: print this help text.");
        pw.println("  <package.name>: optional name of package to filter output by.");
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mAm.checkCallingPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump procstats from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " without permission " + "android.permission.DUMP");
            return;
        }
        long ident = Binder.clearCallingIdentity();
        try {
            dumpInner(fd, pw, args);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private void dumpInner(FileDescriptor fd, PrintWriter pw, String[] args) {
        int i;
        ArrayList<String> files;
        long now = SystemClock.uptimeMillis();
        boolean isCheckin = DEBUG;
        boolean isCompact = DEBUG;
        boolean isCsv = DEBUG;
        boolean currentOnly = DEBUG;
        boolean dumpDetails = DEBUG;
        boolean dumpFullDetails = DEBUG;
        boolean dumpAll = DEBUG;
        boolean quit = DEBUG;
        int aggregateHours = 0;
        int lastIndex = 0;
        int maxNum = 2;
        boolean activeOnly = DEBUG;
        String reqPackage = null;
        boolean csvSepScreenStats = DEBUG;
        int[] csvScreenStats = new int[]{0, 4};
        boolean csvSepMemStats = DEBUG;
        int[] csvMemStats = new int[]{3};
        boolean csvSepProcStats = true;
        int[] csvProcStats = ProcessStats.ALL_PROC_STATES;
        if (args != null) {
            i = 0;
            while (i < args.length) {
                String arg = args[i];
                if ("--checkin".equals(arg)) {
                    isCheckin = true;
                } else if ("-c".equals(arg)) {
                    isCompact = true;
                } else if ("--csv".equals(arg)) {
                    isCsv = true;
                } else if ("--csv-screen".equals(arg)) {
                    i++;
                    if (i >= args.length) {
                        pw.println("Error: argument required for --csv-screen");
                        dumpHelp(pw);
                        return;
                    }
                    sep = new boolean[1];
                    error = new String[1];
                    csvScreenStats = parseStateList(ProcessStats.ADJ_SCREEN_NAMES_CSV, 4, args[i], sep, error);
                    if (csvScreenStats == null) {
                        pw.println("Error in \"" + args[i] + "\": " + error[0]);
                        dumpHelp(pw);
                        return;
                    }
                    csvSepScreenStats = sep[0];
                } else if ("--csv-mem".equals(arg)) {
                    i++;
                    if (i >= args.length) {
                        pw.println("Error: argument required for --csv-mem");
                        dumpHelp(pw);
                        return;
                    }
                    sep = new boolean[1];
                    error = new String[1];
                    csvMemStats = parseStateList(ProcessStats.ADJ_MEM_NAMES_CSV, 1, args[i], sep, error);
                    if (csvMemStats == null) {
                        pw.println("Error in \"" + args[i] + "\": " + error[0]);
                        dumpHelp(pw);
                        return;
                    }
                    csvSepMemStats = sep[0];
                } else if ("--csv-proc".equals(arg)) {
                    i++;
                    if (i >= args.length) {
                        pw.println("Error: argument required for --csv-proc");
                        dumpHelp(pw);
                        return;
                    }
                    sep = new boolean[1];
                    error = new String[1];
                    csvProcStats = parseStateList(ProcessStats.STATE_NAMES_CSV, 1, args[i], sep, error);
                    if (csvProcStats == null) {
                        pw.println("Error in \"" + args[i] + "\": " + error[0]);
                        dumpHelp(pw);
                        return;
                    }
                    csvSepProcStats = sep[0];
                } else if ("--details".equals(arg)) {
                    dumpDetails = true;
                } else if ("--full-details".equals(arg)) {
                    dumpFullDetails = true;
                } else if ("--hours".equals(arg)) {
                    i++;
                    if (i >= args.length) {
                        pw.println("Error: argument required for --hours");
                        dumpHelp(pw);
                        return;
                    }
                    try {
                        aggregateHours = Integer.parseInt(args[i]);
                    } catch (NumberFormatException e) {
                        pw.println("Error: --hours argument not an int -- " + args[i]);
                        dumpHelp(pw);
                        return;
                    }
                } else if ("--last".equals(arg)) {
                    i++;
                    if (i >= args.length) {
                        pw.println("Error: argument required for --last");
                        dumpHelp(pw);
                        return;
                    }
                    try {
                        lastIndex = Integer.parseInt(args[i]);
                    } catch (NumberFormatException e2) {
                        pw.println("Error: --last argument not an int -- " + args[i]);
                        dumpHelp(pw);
                        return;
                    }
                } else if ("--max".equals(arg)) {
                    i++;
                    if (i >= args.length) {
                        pw.println("Error: argument required for --max");
                        dumpHelp(pw);
                        return;
                    }
                    try {
                        maxNum = Integer.parseInt(args[i]);
                    } catch (NumberFormatException e3) {
                        pw.println("Error: --max argument not an int -- " + args[i]);
                        dumpHelp(pw);
                        return;
                    }
                } else if ("--active".equals(arg)) {
                    activeOnly = true;
                    currentOnly = true;
                } else if ("--current".equals(arg)) {
                    currentOnly = true;
                } else if ("--commit".equals(arg)) {
                    synchronized (this.mAm) {
                        ProcessStats processStats = this.mProcessStats;
                        processStats.mFlags |= 1;
                        writeStateLocked(true, true);
                        pw.println("Process stats committed.");
                        quit = true;
                    }
                } else if ("--reset".equals(arg)) {
                    synchronized (this.mAm) {
                        this.mProcessStats.resetSafely();
                        pw.println("Process stats reset.");
                        quit = true;
                    }
                } else if ("--clear".equals(arg)) {
                    synchronized (this.mAm) {
                        this.mProcessStats.resetSafely();
                        files = getCommittedFiles(0, true, true);
                        if (files != null) {
                            for (int fi = 0; fi < files.size(); fi++) {
                                new File((String) files.get(fi)).delete();
                            }
                        }
                        pw.println("All process stats cleared.");
                        quit = true;
                    }
                } else if ("--write".equals(arg)) {
                    synchronized (this.mAm) {
                        writeStateSyncLocked();
                        pw.println("Process stats written.");
                        quit = true;
                    }
                } else if ("--read".equals(arg)) {
                    synchronized (this.mAm) {
                        readLocked(this.mProcessStats, this.mFile);
                        pw.println("Process stats read.");
                        quit = true;
                    }
                } else if ("--start-testing".equals(arg)) {
                    synchronized (this.mAm) {
                        this.mAm.setTestPssMode(true);
                        pw.println("Started high frequency sampling.");
                        quit = true;
                    }
                } else if ("--stop-testing".equals(arg)) {
                    synchronized (this.mAm) {
                        this.mAm.setTestPssMode(DEBUG);
                        pw.println("Stopped high frequency sampling.");
                        quit = true;
                    }
                } else if ("-h".equals(arg)) {
                    dumpHelp(pw);
                    return;
                } else if ("-a".equals(arg)) {
                    dumpDetails = true;
                    dumpAll = true;
                } else if (arg.length() <= 0 || arg.charAt(0) != '-') {
                    reqPackage = arg;
                    dumpDetails = true;
                } else {
                    pw.println("Unknown option: " + arg);
                    dumpHelp(pw);
                    return;
                }
                i++;
            }
        }
        if (!quit) {
            if (isCsv) {
                pw.print("Processes running summed over");
                if (!csvSepScreenStats) {
                    for (int printScreenLabelCsv : csvScreenStats) {
                        pw.print(" ");
                        ProcessStats.printScreenLabelCsv(pw, printScreenLabelCsv);
                    }
                }
                if (!csvSepMemStats) {
                    for (int printScreenLabelCsv2 : csvMemStats) {
                        pw.print(" ");
                        ProcessStats.printMemLabelCsv(pw, printScreenLabelCsv2);
                    }
                }
                if (!csvSepProcStats) {
                    for (int i2 : csvProcStats) {
                        pw.print(" ");
                        pw.print(ProcessStats.STATE_NAMES_CSV[i2]);
                    }
                }
                pw.println();
                synchronized (this.mAm) {
                    dumpFilteredProcessesCsvLocked(pw, null, csvSepScreenStats, csvScreenStats, csvSepMemStats, csvMemStats, csvSepProcStats, csvProcStats, now, reqPackage);
                }
            } else if (aggregateHours != 0) {
                pw.print("AGGREGATED OVER LAST ");
                pw.print(aggregateHours);
                pw.println(" HOURS:");
                dumpAggregatedStats(pw, (long) aggregateHours, now, reqPackage, isCompact, dumpDetails, dumpFullDetails, dumpAll, activeOnly);
            } else if (lastIndex > 0) {
                pw.print("LAST STATS AT INDEX ");
                pw.print(lastIndex);
                pw.println(":");
                files = getCommittedFiles(0, DEBUG, true);
                if (lastIndex >= files.size()) {
                    pw.print("Only have ");
                    pw.print(files.size());
                    pw.println(" data sets");
                    return;
                }
                r0 = new AtomicFile(new File((String) files.get(lastIndex)));
                processStats = new ProcessStats(DEBUG);
                readLocked(processStats, r0);
                if (processStats.mReadError != null) {
                    if (isCheckin || isCompact) {
                        pw.print("err,");
                    }
                    pw.print("Failure reading ");
                    pw.print((String) files.get(lastIndex));
                    pw.print("; ");
                    pw.println(processStats.mReadError);
                    return;
                }
                checkedIn = r0.getBaseFile().getPath().endsWith(STATE_FILE_CHECKIN_SUFFIX);
                if (isCheckin || isCompact) {
                    processStats.dumpCheckinLocked(pw, reqPackage);
                    return;
                }
                pw.print("COMMITTED STATS FROM ");
                pw.print(processStats.mTimePeriodStartClockStr);
                if (checkedIn) {
                    pw.print(" (checked in)");
                }
                pw.println(":");
                if (dumpDetails || dumpFullDetails) {
                    processStats.dumpLocked(pw, reqPackage, now, !dumpFullDetails ? true : DEBUG, dumpAll, activeOnly);
                    if (dumpAll) {
                        pw.print("  mFile=");
                        pw.println(this.mFile.getBaseFile());
                        return;
                    }
                    return;
                }
                processStats.dumpSummaryLocked(pw, reqPackage, now, activeOnly);
            } else {
                boolean sepNeeded = DEBUG;
                if (dumpAll || isCheckin) {
                    this.mWriteLock.lock();
                    try {
                        files = getCommittedFiles(0, DEBUG, !isCheckin ? true : DEBUG);
                        if (files != null) {
                            int start;
                            if (isCheckin) {
                                start = 0;
                            } else {
                                start = files.size() - maxNum;
                            }
                            if (start < 0) {
                                start = 0;
                            }
                            i = start;
                            while (i < files.size()) {
                                r0 = new AtomicFile(new File((String) files.get(i)));
                                processStats = new ProcessStats(DEBUG);
                                readLocked(processStats, r0);
                                if (processStats.mReadError != null) {
                                    if (isCheckin || isCompact) {
                                        pw.print("err,");
                                    }
                                    pw.print("Failure reading ");
                                    pw.print((String) files.get(i));
                                    pw.print("; ");
                                    pw.println(processStats.mReadError);
                                    new File((String) files.get(i)).delete();
                                } else {
                                    String fileStr = r0.getBaseFile().getPath();
                                    checkedIn = fileStr.endsWith(STATE_FILE_CHECKIN_SUFFIX);
                                    if (isCheckin || isCompact) {
                                        processStats.dumpCheckinLocked(pw, reqPackage);
                                    } else {
                                        if (sepNeeded) {
                                            pw.println();
                                        } else {
                                            sepNeeded = true;
                                        }
                                        pw.print("COMMITTED STATS FROM ");
                                        pw.print(processStats.mTimePeriodStartClockStr);
                                        if (checkedIn) {
                                            pw.print(" (checked in)");
                                        }
                                        pw.println(":");
                                        if (dumpFullDetails) {
                                            processStats.dumpLocked(pw, reqPackage, now, DEBUG, DEBUG, activeOnly);
                                        } else {
                                            processStats.dumpSummaryLocked(pw, reqPackage, now, activeOnly);
                                        }
                                    }
                                    if (isCheckin) {
                                        r0.getBaseFile().renameTo(new File(fileStr + STATE_FILE_CHECKIN_SUFFIX));
                                    }
                                }
                                i++;
                            }
                        }
                        this.mWriteLock.unlock();
                    } catch (Throwable th) {
                        this.mWriteLock.unlock();
                    }
                }
                if (!isCheckin) {
                    synchronized (this.mAm) {
                        if (isCompact) {
                            this.mProcessStats.dumpCheckinLocked(pw, reqPackage);
                        } else {
                            if (sepNeeded) {
                                pw.println();
                            }
                            pw.println("CURRENT STATS:");
                            if (dumpDetails || dumpFullDetails) {
                                this.mProcessStats.dumpLocked(pw, reqPackage, now, !dumpFullDetails ? true : DEBUG, dumpAll, activeOnly);
                                if (dumpAll) {
                                    pw.print("  mFile=");
                                    pw.println(this.mFile.getBaseFile());
                                }
                            } else {
                                this.mProcessStats.dumpSummaryLocked(pw, reqPackage, now, activeOnly);
                            }
                            sepNeeded = true;
                        }
                    }
                    if (!currentOnly) {
                        if (sepNeeded) {
                            pw.println();
                        }
                        pw.println("AGGREGATED OVER LAST 24 HOURS:");
                        dumpAggregatedStats(pw, 24, now, reqPackage, isCompact, dumpDetails, dumpFullDetails, dumpAll, activeOnly);
                        pw.println();
                        pw.println("AGGREGATED OVER LAST 3 HOURS:");
                        dumpAggregatedStats(pw, 3, now, reqPackage, isCompact, dumpDetails, dumpFullDetails, dumpAll, activeOnly);
                    }
                }
            }
        }
    }
}
