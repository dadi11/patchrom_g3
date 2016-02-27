package com.android.server.usage;

import android.app.usage.TimeSparseArray;
import android.util.AtomicFile;
import android.util.Slog;
import com.android.server.job.controllers.JobStatus;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

class UsageStatsDatabase {
    private static final String BAK_SUFFIX = ".bak";
    private static final String CHECKED_IN_SUFFIX = "-c";
    private static final int CURRENT_VERSION = 2;
    private static final boolean DEBUG = false;
    private static final String TAG = "UsageStatsDatabase";
    private final UnixCalendar mCal;
    private final File[] mIntervalDirs;
    private final Object mLock;
    private final TimeSparseArray<AtomicFile>[] mSortedStatFiles;
    private final File mVersionFile;

    /* renamed from: com.android.server.usage.UsageStatsDatabase.1 */
    class C05391 implements FilenameFilter {
        C05391() {
        }

        public boolean accept(File dir, String name) {
            return !name.endsWith(UsageStatsDatabase.BAK_SUFFIX) ? true : UsageStatsDatabase.DEBUG;
        }
    }

    public interface CheckinAction {
        boolean checkin(IntervalStats intervalStats);
    }

    interface StatCombiner<T> {
        void combine(IntervalStats intervalStats, boolean z, List<T> list);
    }

    public UsageStatsDatabase(File dir) {
        this.mLock = new Object();
        this.mIntervalDirs = new File[]{new File(dir, "daily"), new File(dir, "weekly"), new File(dir, "monthly"), new File(dir, "yearly")};
        this.mVersionFile = new File(dir, "version");
        this.mSortedStatFiles = new TimeSparseArray[this.mIntervalDirs.length];
        this.mCal = new UnixCalendar(0);
    }

    public void init(long currentTimeMillis) {
        synchronized (this.mLock) {
            File[] arr$ = this.mIntervalDirs;
            int len$ = arr$.length;
            int i$ = 0;
            while (i$ < len$) {
                File f = arr$[i$];
                f.mkdirs();
                if (f.exists()) {
                    i$++;
                } else {
                    throw new IllegalStateException("Failed to create directory " + f.getAbsolutePath());
                }
            }
            checkVersionLocked();
            indexFilesLocked();
            for (TimeSparseArray<AtomicFile> files : this.mSortedStatFiles) {
                int startIndex = files.closestIndexOnOrAfter(currentTimeMillis);
                if (startIndex >= 0) {
                    int i;
                    int fileCount = files.size();
                    for (i = startIndex; i < fileCount; i++) {
                        ((AtomicFile) files.valueAt(i)).delete();
                    }
                    for (i = startIndex; i < fileCount; i++) {
                        files.removeAt(i);
                    }
                }
            }
        }
    }

    public boolean checkinDailyFiles(CheckinAction checkinAction) {
        synchronized (this.mLock) {
            int i;
            TimeSparseArray<AtomicFile> files = this.mSortedStatFiles[0];
            int fileCount = files.size();
            int lastCheckin = -1;
            for (i = 0; i < fileCount - 1; i++) {
                if (((AtomicFile) files.valueAt(i)).getBaseFile().getPath().endsWith(CHECKED_IN_SUFFIX)) {
                    lastCheckin = i;
                }
            }
            int start = lastCheckin + 1;
            if (start == fileCount - 1) {
                return true;
            }
            try {
                IntervalStats stats = new IntervalStats();
                i = start;
                while (i < fileCount - 1) {
                    UsageStatsXml.read((AtomicFile) files.valueAt(i), stats);
                    if (checkinAction.checkin(stats)) {
                        i++;
                    } else {
                        return DEBUG;
                    }
                }
                i = start;
                while (i < fileCount - 1) {
                    AtomicFile file = (AtomicFile) files.valueAt(i);
                    File checkedInFile = new File(file.getBaseFile().getPath() + CHECKED_IN_SUFFIX);
                    if (file.getBaseFile().renameTo(checkedInFile)) {
                        files.setValueAt(i, new AtomicFile(checkedInFile));
                        i++;
                    } else {
                        Slog.e(TAG, "Failed to mark file " + file.getBaseFile().getPath() + " as checked-in");
                        return true;
                    }
                }
                return true;
            } catch (IOException e) {
                Slog.e(TAG, "Failed to check-in", e);
                return DEBUG;
            }
        }
    }

    private void indexFilesLocked() {
        FilenameFilter backupFileFilter = new C05391();
        for (int i = 0; i < this.mSortedStatFiles.length; i++) {
            if (this.mSortedStatFiles[i] == null) {
                this.mSortedStatFiles[i] = new TimeSparseArray();
            } else {
                this.mSortedStatFiles[i].clear();
            }
            File[] files = this.mIntervalDirs[i].listFiles(backupFileFilter);
            if (files != null) {
                for (File f : files) {
                    AtomicFile af = new AtomicFile(f);
                    this.mSortedStatFiles[i].put(UsageStatsXml.parseBeginTime(af), af);
                }
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void checkVersionLocked() {
        /*
        r11 = this;
        r7 = 0;
        r9 = 2;
        r1 = new java.io.BufferedReader;	 Catch:{ NumberFormatException -> 0x0067, IOException -> 0x006e }
        r5 = new java.io.FileReader;	 Catch:{ NumberFormatException -> 0x0067, IOException -> 0x006e }
        r6 = r11.mVersionFile;	 Catch:{ NumberFormatException -> 0x0067, IOException -> 0x006e }
        r5.<init>(r6);	 Catch:{ NumberFormatException -> 0x0067, IOException -> 0x006e }
        r1.<init>(r5);	 Catch:{ NumberFormatException -> 0x0067, IOException -> 0x006e }
        r5 = 0;
        r6 = r1.readLine();	 Catch:{ Throwable -> 0x0070, all -> 0x00b6 }
        r2 = java.lang.Integer.parseInt(r6);	 Catch:{ Throwable -> 0x0070, all -> 0x00b6 }
        if (r1 == 0) goto L_0x001e;
    L_0x0019:
        if (r7 == 0) goto L_0x006a;
    L_0x001b:
        r1.close();	 Catch:{ Throwable -> 0x0062 }
    L_0x001e:
        if (r2 == r9) goto L_0x0061;
    L_0x0020:
        r5 = "UsageStatsDatabase";
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r8 = "Upgrading from version ";
        r6 = r6.append(r8);
        r6 = r6.append(r2);
        r8 = " to ";
        r6 = r6.append(r8);
        r6 = r6.append(r9);
        r6 = r6.toString();
        android.util.Slog.i(r5, r6);
        r11.doUpgradeLocked(r2);
        r3 = new java.io.BufferedWriter;	 Catch:{ IOException -> 0x008c }
        r5 = new java.io.FileWriter;	 Catch:{ IOException -> 0x008c }
        r6 = r11.mVersionFile;	 Catch:{ IOException -> 0x008c }
        r5.<init>(r6);	 Catch:{ IOException -> 0x008c }
        r3.<init>(r5);	 Catch:{ IOException -> 0x008c }
        r5 = 0;
        r6 = 2;
        r6 = java.lang.Integer.toString(r6);	 Catch:{ Throwable -> 0x009e, all -> 0x00b4 }
        r3.write(r6);	 Catch:{ Throwable -> 0x009e, all -> 0x00b4 }
        if (r3 == 0) goto L_0x0061;
    L_0x005c:
        if (r7 == 0) goto L_0x009a;
    L_0x005e:
        r3.close();	 Catch:{ Throwable -> 0x0087 }
    L_0x0061:
        return;
    L_0x0062:
        r4 = move-exception;
        r5.addSuppressed(r4);	 Catch:{ NumberFormatException -> 0x0067, IOException -> 0x006e }
        goto L_0x001e;
    L_0x0067:
        r0 = move-exception;
    L_0x0068:
        r2 = 0;
        goto L_0x001e;
    L_0x006a:
        r1.close();	 Catch:{ NumberFormatException -> 0x0067, IOException -> 0x006e }
        goto L_0x001e;
    L_0x006e:
        r0 = move-exception;
        goto L_0x0068;
    L_0x0070:
        r5 = move-exception;
        throw r5;	 Catch:{ all -> 0x0072 }
    L_0x0072:
        r6 = move-exception;
        r10 = r6;
        r6 = r5;
        r5 = r10;
    L_0x0076:
        if (r1 == 0) goto L_0x007d;
    L_0x0078:
        if (r6 == 0) goto L_0x0083;
    L_0x007a:
        r1.close();	 Catch:{ Throwable -> 0x007e }
    L_0x007d:
        throw r5;	 Catch:{ NumberFormatException -> 0x0067, IOException -> 0x006e }
    L_0x007e:
        r4 = move-exception;
        r6.addSuppressed(r4);	 Catch:{ NumberFormatException -> 0x0067, IOException -> 0x006e }
        goto L_0x007d;
    L_0x0083:
        r1.close();	 Catch:{ NumberFormatException -> 0x0067, IOException -> 0x006e }
        goto L_0x007d;
    L_0x0087:
        r4 = move-exception;
        r5.addSuppressed(r4);	 Catch:{ IOException -> 0x008c }
        goto L_0x0061;
    L_0x008c:
        r0 = move-exception;
        r5 = "UsageStatsDatabase";
        r6 = "Failed to write new version";
        android.util.Slog.e(r5, r6);
        r5 = new java.lang.RuntimeException;
        r5.<init>(r0);
        throw r5;
    L_0x009a:
        r3.close();	 Catch:{ IOException -> 0x008c }
        goto L_0x0061;
    L_0x009e:
        r5 = move-exception;
        throw r5;	 Catch:{ all -> 0x00a0 }
    L_0x00a0:
        r6 = move-exception;
        r7 = r5;
        r5 = r6;
    L_0x00a3:
        if (r3 == 0) goto L_0x00aa;
    L_0x00a5:
        if (r7 == 0) goto L_0x00b0;
    L_0x00a7:
        r3.close();	 Catch:{ Throwable -> 0x00ab }
    L_0x00aa:
        throw r5;	 Catch:{ IOException -> 0x008c }
    L_0x00ab:
        r4 = move-exception;
        r7.addSuppressed(r4);	 Catch:{ IOException -> 0x008c }
        goto L_0x00aa;
    L_0x00b0:
        r3.close();	 Catch:{ IOException -> 0x008c }
        goto L_0x00aa;
    L_0x00b4:
        r5 = move-exception;
        goto L_0x00a3;
    L_0x00b6:
        r5 = move-exception;
        r6 = r7;
        goto L_0x0076;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.usage.UsageStatsDatabase.checkVersionLocked():void");
    }

    private void doUpgradeLocked(int thisVersion) {
        if (thisVersion < CURRENT_VERSION) {
            Slog.i(TAG, "Deleting all usage stats files");
            for (File listFiles : this.mIntervalDirs) {
                File[] files = listFiles.listFiles();
                if (files != null) {
                    for (File f : files) {
                        f.delete();
                    }
                }
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void onTimeChanged(long r20) {
        /*
        r19 = this;
        r0 = r19;
        r14 = r0.mLock;
        monitor-enter(r14);
        r0 = r19;
        r2 = r0.mSortedStatFiles;	 Catch:{ all -> 0x00c5 }
        r8 = r2.length;	 Catch:{ all -> 0x00c5 }
        r7 = 0;
    L_0x000b:
        if (r7 >= r8) goto L_0x00cf;
    L_0x000d:
        r5 = r2[r7];	 Catch:{ all -> 0x00c5 }
        r4 = r5.size();	 Catch:{ all -> 0x00c5 }
        r6 = 0;
    L_0x0014:
        if (r6 >= r4) goto L_0x00c8;
    L_0x0016:
        r3 = r5.valueAt(r6);	 Catch:{ all -> 0x00c5 }
        r3 = (android.util.AtomicFile) r3;	 Catch:{ all -> 0x00c5 }
        r16 = r5.keyAt(r6);	 Catch:{ all -> 0x00c5 }
        r12 = r16 + r20;
        r16 = 0;
        r11 = (r12 > r16 ? 1 : (r12 == r16 ? 0 : -1));
        if (r11 >= 0) goto L_0x0054;
    L_0x0028:
        r11 = "UsageStatsDatabase";
        r15 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00c5 }
        r15.<init>();	 Catch:{ all -> 0x00c5 }
        r16 = "Deleting file ";
        r15 = r15.append(r16);	 Catch:{ all -> 0x00c5 }
        r16 = r3.getBaseFile();	 Catch:{ all -> 0x00c5 }
        r16 = r16.getAbsolutePath();	 Catch:{ all -> 0x00c5 }
        r15 = r15.append(r16);	 Catch:{ all -> 0x00c5 }
        r16 = " for it is in the future now.";
        r15 = r15.append(r16);	 Catch:{ all -> 0x00c5 }
        r15 = r15.toString();	 Catch:{ all -> 0x00c5 }
        android.util.Slog.i(r11, r15);	 Catch:{ all -> 0x00c5 }
        r3.delete();	 Catch:{ all -> 0x00c5 }
    L_0x0051:
        r6 = r6 + 1;
        goto L_0x0014;
    L_0x0054:
        r11 = r3.openRead();	 Catch:{ IOException -> 0x00d4 }
        r11.close();	 Catch:{ IOException -> 0x00d4 }
    L_0x005b:
        r10 = java.lang.Long.toString(r12);	 Catch:{ all -> 0x00c5 }
        r11 = r3.getBaseFile();	 Catch:{ all -> 0x00c5 }
        r11 = r11.getName();	 Catch:{ all -> 0x00c5 }
        r15 = "-c";
        r11 = r11.endsWith(r15);	 Catch:{ all -> 0x00c5 }
        if (r11 == 0) goto L_0x0082;
    L_0x006f:
        r11 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00c5 }
        r11.<init>();	 Catch:{ all -> 0x00c5 }
        r11 = r11.append(r10);	 Catch:{ all -> 0x00c5 }
        r15 = "-c";
        r11 = r11.append(r15);	 Catch:{ all -> 0x00c5 }
        r10 = r11.toString();	 Catch:{ all -> 0x00c5 }
    L_0x0082:
        r9 = new java.io.File;	 Catch:{ all -> 0x00c5 }
        r11 = r3.getBaseFile();	 Catch:{ all -> 0x00c5 }
        r11 = r11.getParentFile();	 Catch:{ all -> 0x00c5 }
        r9.<init>(r11, r10);	 Catch:{ all -> 0x00c5 }
        r11 = "UsageStatsDatabase";
        r15 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00c5 }
        r15.<init>();	 Catch:{ all -> 0x00c5 }
        r16 = "Moving file ";
        r15 = r15.append(r16);	 Catch:{ all -> 0x00c5 }
        r16 = r3.getBaseFile();	 Catch:{ all -> 0x00c5 }
        r16 = r16.getAbsolutePath();	 Catch:{ all -> 0x00c5 }
        r15 = r15.append(r16);	 Catch:{ all -> 0x00c5 }
        r16 = " to ";
        r15 = r15.append(r16);	 Catch:{ all -> 0x00c5 }
        r16 = r9.getAbsolutePath();	 Catch:{ all -> 0x00c5 }
        r15 = r15.append(r16);	 Catch:{ all -> 0x00c5 }
        r15 = r15.toString();	 Catch:{ all -> 0x00c5 }
        android.util.Slog.i(r11, r15);	 Catch:{ all -> 0x00c5 }
        r11 = r3.getBaseFile();	 Catch:{ all -> 0x00c5 }
        r11.renameTo(r9);	 Catch:{ all -> 0x00c5 }
        goto L_0x0051;
    L_0x00c5:
        r11 = move-exception;
        monitor-exit(r14);	 Catch:{ all -> 0x00c5 }
        throw r11;
    L_0x00c8:
        r5.clear();	 Catch:{ all -> 0x00c5 }
        r7 = r7 + 1;
        goto L_0x000b;
    L_0x00cf:
        r19.indexFilesLocked();	 Catch:{ all -> 0x00c5 }
        monitor-exit(r14);	 Catch:{ all -> 0x00c5 }
        return;
    L_0x00d4:
        r11 = move-exception;
        goto L_0x005b;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.usage.UsageStatsDatabase.onTimeChanged(long):void");
    }

    public IntervalStats getLatestUsageStats(int intervalType) {
        synchronized (this.mLock) {
            if (intervalType >= 0) {
                if (intervalType < this.mIntervalDirs.length) {
                    int fileCount = this.mSortedStatFiles[intervalType].size();
                    if (fileCount == 0) {
                        return null;
                    }
                    try {
                        AtomicFile f = (AtomicFile) this.mSortedStatFiles[intervalType].valueAt(fileCount - 1);
                        IntervalStats stats = new IntervalStats();
                        UsageStatsXml.read(f, stats);
                        return stats;
                    } catch (IOException e) {
                        Slog.e(TAG, "Failed to read usage stats file", e);
                        return null;
                    }
                }
            }
            throw new IllegalArgumentException("Bad interval type " + intervalType);
        }
    }

    public long getLatestUsageStatsBeginTime(int intervalType) {
        long keyAt;
        synchronized (this.mLock) {
            if (intervalType >= 0) {
                if (intervalType < this.mIntervalDirs.length) {
                    int statsFileCount = this.mSortedStatFiles[intervalType].size();
                    if (statsFileCount > 0) {
                        keyAt = this.mSortedStatFiles[intervalType].keyAt(statsFileCount - 1);
                    } else {
                        keyAt = -1;
                    }
                }
            }
            throw new IllegalArgumentException("Bad interval type " + intervalType);
        }
        return keyAt;
    }

    public <T> List<T> queryUsageStats(int intervalType, long beginTime, long endTime, StatCombiner<T> combiner) {
        List<T> list;
        synchronized (this.mLock) {
            if (intervalType >= 0) {
                if (intervalType < this.mIntervalDirs.length) {
                    TimeSparseArray<AtomicFile> intervalStats = this.mSortedStatFiles[intervalType];
                    if (endTime <= beginTime) {
                        list = null;
                    } else {
                        int startIndex = intervalStats.closestIndexOnOrBefore(beginTime);
                        if (startIndex < 0) {
                            startIndex = 0;
                        }
                        int endIndex = intervalStats.closestIndexOnOrBefore(endTime);
                        if (endIndex < 0) {
                            list = null;
                        } else {
                            if (intervalStats.keyAt(endIndex) == endTime) {
                                endIndex--;
                                if (endIndex < 0) {
                                    list = null;
                                }
                            }
                            try {
                                IntervalStats stats = new IntervalStats();
                                list = new ArrayList();
                                for (int i = startIndex; i <= endIndex; i++) {
                                    UsageStatsXml.read((AtomicFile) intervalStats.valueAt(i), stats);
                                    if (beginTime < stats.endTime) {
                                        combiner.combine(stats, DEBUG, list);
                                    }
                                }
                            } catch (IOException e) {
                                Slog.e(TAG, "Failed to read usage stats file", e);
                                list = null;
                            }
                        }
                    }
                }
            }
            throw new IllegalArgumentException("Bad interval type " + intervalType);
        }
        return list;
    }

    public int findBestFitBucket(long beginTimeStamp, long endTimeStamp) {
        int bestBucket;
        synchronized (this.mLock) {
            bestBucket = -1;
            long smallestDiff = JobStatus.NO_LATEST_RUNTIME;
            for (int i = this.mSortedStatFiles.length - 1; i >= 0; i--) {
                int index = this.mSortedStatFiles[i].closestIndexOnOrBefore(beginTimeStamp);
                int size = this.mSortedStatFiles[i].size();
                if (index >= 0 && index < size) {
                    long diff = Math.abs(this.mSortedStatFiles[i].keyAt(index) - beginTimeStamp);
                    if (diff < smallestDiff) {
                        smallestDiff = diff;
                        bestBucket = i;
                    }
                }
            }
        }
        return bestBucket;
    }

    public void prune(long currentTimeMillis) {
        synchronized (this.mLock) {
            this.mCal.setTimeInMillis(currentTimeMillis);
            this.mCal.addYears(-3);
            pruneFilesOlderThan(this.mIntervalDirs[3], this.mCal.getTimeInMillis());
            this.mCal.setTimeInMillis(currentTimeMillis);
            this.mCal.addMonths(-6);
            pruneFilesOlderThan(this.mIntervalDirs[CURRENT_VERSION], this.mCal.getTimeInMillis());
            this.mCal.setTimeInMillis(currentTimeMillis);
            this.mCal.addWeeks(-4);
            pruneFilesOlderThan(this.mIntervalDirs[1], this.mCal.getTimeInMillis());
            this.mCal.setTimeInMillis(currentTimeMillis);
            this.mCal.addDays(-7);
            pruneFilesOlderThan(this.mIntervalDirs[0], this.mCal.getTimeInMillis());
        }
    }

    private static void pruneFilesOlderThan(File dir, long expiryTime) {
        File[] files = dir.listFiles();
        if (files != null) {
            for (File f : files) {
                File f2;
                String path = f2.getPath();
                if (path.endsWith(BAK_SUFFIX)) {
                    f2 = new File(path.substring(0, path.length() - BAK_SUFFIX.length()));
                }
                if (UsageStatsXml.parseBeginTime(f2) < expiryTime) {
                    new AtomicFile(f2).delete();
                }
            }
        }
    }

    public void putUsageStats(int intervalType, IntervalStats stats) throws IOException {
        synchronized (this.mLock) {
            if (intervalType >= 0) {
                if (intervalType < this.mIntervalDirs.length) {
                    AtomicFile f = (AtomicFile) this.mSortedStatFiles[intervalType].get(stats.beginTime);
                    if (f == null) {
                        f = new AtomicFile(new File(this.mIntervalDirs[intervalType], Long.toString(stats.beginTime)));
                        this.mSortedStatFiles[intervalType].put(stats.beginTime, f);
                    }
                    UsageStatsXml.write(f, stats);
                    stats.lastTimeSaved = f.getLastModifiedTime();
                }
            }
            throw new IllegalArgumentException("Bad interval type " + intervalType);
        }
    }
}
