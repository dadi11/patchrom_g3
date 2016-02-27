package com.android.server;

import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.ContentObserver;
import android.net.Uri;
import android.os.Binder;
import android.os.DropBoxManager.Entry;
import android.os.FileUtils;
import android.os.Handler;
import android.os.Message;
import android.os.StatFs;
import android.os.UserHandle;
import android.provider.Settings.Global;
import android.util.Slog;
import com.android.internal.os.IDropBoxManagerService.Stub;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.zip.GZIPOutputStream;

public final class DropBoxManagerService extends Stub {
    private static final int DEFAULT_AGE_SECONDS = 259200;
    private static final int DEFAULT_MAX_FILES = 1000;
    private static final int DEFAULT_QUOTA_KB = 5120;
    private static final int DEFAULT_QUOTA_PERCENT = 10;
    private static final int DEFAULT_RESERVE_PERCENT = 10;
    private static final int MSG_SEND_BROADCAST = 1;
    private static final boolean PROFILE_DUMP = false;
    private static final int QUOTA_RESCAN_MILLIS = 5000;
    private static final String TAG = "DropBoxManagerService";
    private FileList mAllFiles;
    private int mBlockSize;
    private volatile boolean mBooted;
    private int mCachedQuotaBlocks;
    private long mCachedQuotaUptimeMillis;
    private final ContentResolver mContentResolver;
    private final Context mContext;
    private final File mDropBoxDir;
    private HashMap<String, FileList> mFilesByTag;
    private final Handler mHandler;
    private final BroadcastReceiver mReceiver;
    private StatFs mStatFs;

    /* renamed from: com.android.server.DropBoxManagerService.1 */
    class C00361 extends BroadcastReceiver {

        /* renamed from: com.android.server.DropBoxManagerService.1.1 */
        class C00351 extends Thread {
            C00351() {
            }

            public void run() {
                try {
                    DropBoxManagerService.this.init();
                    DropBoxManagerService.this.trimToFit();
                } catch (IOException e) {
                    Slog.e(DropBoxManagerService.TAG, "Can't init", e);
                }
            }
        }

        C00361() {
        }

        public void onReceive(Context context, Intent intent) {
            if (intent == null || !"android.intent.action.BOOT_COMPLETED".equals(intent.getAction())) {
                DropBoxManagerService.this.mCachedQuotaUptimeMillis = 0;
                new C00351().start();
                return;
            }
            DropBoxManagerService.this.mBooted = true;
        }
    }

    /* renamed from: com.android.server.DropBoxManagerService.2 */
    class C00372 extends ContentObserver {
        final /* synthetic */ Context val$context;

        C00372(Handler x0, Context context) {
            this.val$context = context;
            super(x0);
        }

        public void onChange(boolean selfChange) {
            DropBoxManagerService.this.mReceiver.onReceive(this.val$context, (Intent) null);
        }
    }

    /* renamed from: com.android.server.DropBoxManagerService.3 */
    class C00383 extends Handler {
        C00383() {
        }

        public void handleMessage(Message msg) {
            if (msg.what == DropBoxManagerService.MSG_SEND_BROADCAST) {
                DropBoxManagerService.this.mContext.sendBroadcastAsUser((Intent) msg.obj, UserHandle.OWNER, "android.permission.READ_LOGS");
            }
        }
    }

    private static final class EntryFile implements Comparable<EntryFile> {
        public final int blocks;
        public final File file;
        public final int flags;
        public final String tag;
        public final long timestampMillis;

        public final int compareTo(EntryFile o) {
            if (this.timestampMillis < o.timestampMillis) {
                return -1;
            }
            if (this.timestampMillis > o.timestampMillis) {
                return DropBoxManagerService.MSG_SEND_BROADCAST;
            }
            if (this.file != null && o.file != null) {
                return this.file.compareTo(o.file);
            }
            if (o.file != null) {
                return -1;
            }
            if (this.file != null) {
                return DropBoxManagerService.MSG_SEND_BROADCAST;
            }
            if (this == o) {
                return 0;
            }
            if (hashCode() >= o.hashCode()) {
                return hashCode() > o.hashCode() ? DropBoxManagerService.MSG_SEND_BROADCAST : 0;
            } else {
                return -1;
            }
        }

        public EntryFile(File temp, File dir, String tag, long timestampMillis, int flags, int blockSize) throws IOException {
            if ((flags & DropBoxManagerService.MSG_SEND_BROADCAST) != 0) {
                throw new IllegalArgumentException();
            }
            this.tag = tag;
            this.timestampMillis = timestampMillis;
            this.flags = flags;
            this.file = new File(dir, Uri.encode(tag) + "@" + timestampMillis + ((flags & 2) != 0 ? ".txt" : ".dat") + ((flags & 4) != 0 ? ".gz" : ""));
            if (temp.renameTo(this.file)) {
                this.blocks = (int) (((this.file.length() + ((long) blockSize)) - 1) / ((long) blockSize));
                return;
            }
            throw new IOException("Can't rename " + temp + " to " + this.file);
        }

        public EntryFile(File dir, String tag, long timestampMillis) throws IOException {
            this.tag = tag;
            this.timestampMillis = timestampMillis;
            this.flags = DropBoxManagerService.MSG_SEND_BROADCAST;
            this.file = new File(dir, Uri.encode(tag) + "@" + timestampMillis + ".lost");
            this.blocks = 0;
            new FileOutputStream(this.file).close();
        }

        public EntryFile(File file, int blockSize) {
            this.file = file;
            this.blocks = (int) (((this.file.length() + ((long) blockSize)) - 1) / ((long) blockSize));
            String name = file.getName();
            int at = name.lastIndexOf(64);
            if (at < 0) {
                this.tag = null;
                this.timestampMillis = 0;
                this.flags = DropBoxManagerService.MSG_SEND_BROADCAST;
                return;
            }
            long millis;
            int flags = 0;
            this.tag = Uri.decode(name.substring(0, at));
            if (name.endsWith(".gz")) {
                flags = 0 | 4;
                name = name.substring(0, name.length() - 3);
            }
            if (name.endsWith(".lost")) {
                flags |= DropBoxManagerService.MSG_SEND_BROADCAST;
                name = name.substring(at + DropBoxManagerService.MSG_SEND_BROADCAST, name.length() - 5);
            } else if (name.endsWith(".txt")) {
                flags |= 2;
                name = name.substring(at + DropBoxManagerService.MSG_SEND_BROADCAST, name.length() - 4);
            } else if (name.endsWith(".dat")) {
                name = name.substring(at + DropBoxManagerService.MSG_SEND_BROADCAST, name.length() - 4);
            } else {
                this.flags = DropBoxManagerService.MSG_SEND_BROADCAST;
                this.timestampMillis = 0;
                return;
            }
            this.flags = flags;
            try {
                millis = Long.valueOf(name).longValue();
            } catch (NumberFormatException e) {
                millis = 0;
            }
            this.timestampMillis = millis;
        }

        public EntryFile(long millis) {
            this.tag = null;
            this.timestampMillis = millis;
            this.flags = DropBoxManagerService.MSG_SEND_BROADCAST;
            this.file = null;
            this.blocks = 0;
        }
    }

    private static final class FileList implements Comparable<FileList> {
        public int blocks;
        public final TreeSet<EntryFile> contents;

        private FileList() {
            this.blocks = 0;
            this.contents = new TreeSet();
        }

        public final int compareTo(FileList o) {
            if (this.blocks != o.blocks) {
                return o.blocks - this.blocks;
            }
            if (this == o) {
                return 0;
            }
            if (hashCode() < o.hashCode()) {
                return -1;
            }
            if (hashCode() > o.hashCode()) {
                return DropBoxManagerService.MSG_SEND_BROADCAST;
            }
            return 0;
        }
    }

    public DropBoxManagerService(Context context, File path) {
        this.mAllFiles = null;
        this.mFilesByTag = null;
        this.mStatFs = null;
        this.mBlockSize = 0;
        this.mCachedQuotaBlocks = 0;
        this.mCachedQuotaUptimeMillis = 0;
        this.mBooted = PROFILE_DUMP;
        this.mReceiver = new C00361();
        this.mDropBoxDir = path;
        this.mContext = context;
        this.mContentResolver = context.getContentResolver();
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.DEVICE_STORAGE_LOW");
        filter.addAction("android.intent.action.BOOT_COMPLETED");
        context.registerReceiver(this.mReceiver, filter);
        this.mContentResolver.registerContentObserver(Global.CONTENT_URI, true, new C00372(new Handler(), context));
        this.mHandler = new C00383();
    }

    public void stop() {
        this.mContext.unregisterReceiver(this.mReceiver);
    }

    public void add(Entry entry) {
        IOException e;
        Throwable th;
        File temp = null;
        OutputStream outputStream = null;
        String tag = entry.getTag();
        try {
            int flags = entry.getFlags();
            if ((flags & MSG_SEND_BROADCAST) != 0) {
                throw new IllegalArgumentException();
            }
            init();
            if (isTagEnabled(tag)) {
                long max = trimToFit();
                long lastTrim = System.currentTimeMillis();
                byte[] buffer = new byte[this.mBlockSize];
                InputStream input = entry.getInputStream();
                int read = 0;
                while (read < buffer.length) {
                    int n = input.read(buffer, read, buffer.length - read);
                    if (n <= 0) {
                        break;
                    }
                    read += n;
                }
                File file = new File(this.mDropBoxDir, "drop" + Thread.currentThread().getId() + ".tmp");
                try {
                    int bufferSize = this.mBlockSize;
                    if (bufferSize > 4096) {
                        bufferSize = DumpState.DUMP_VERSION;
                    }
                    if (bufferSize < 512) {
                        bufferSize = DumpState.DUMP_PREFERRED;
                    }
                    FileOutputStream foutput = new FileOutputStream(file);
                    OutputStream bufferedOutputStream = new BufferedOutputStream(foutput, bufferSize);
                    try {
                        if (read == buffer.length && (flags & 4) == 0) {
                            outputStream = new GZIPOutputStream(bufferedOutputStream);
                            flags |= 4;
                        } else {
                            outputStream = bufferedOutputStream;
                        }
                        do {
                            outputStream.write(buffer, 0, read);
                            long now = System.currentTimeMillis();
                            if (now - lastTrim > 30000) {
                                max = trimToFit();
                                lastTrim = now;
                            }
                            read = input.read(buffer);
                            if (read <= 0) {
                                FileUtils.sync(foutput);
                                outputStream.close();
                                outputStream = null;
                            } else {
                                outputStream.flush();
                            }
                            if (file.length() > max) {
                                Slog.w(TAG, "Dropping: " + tag + " (" + file.length() + " > " + max + " bytes)");
                                file.delete();
                                temp = null;
                                break;
                            }
                        } while (read > 0);
                        temp = file;
                        long time = createEntry(temp, tag, flags);
                        temp = null;
                        Intent dropboxIntent = new Intent("android.intent.action.DROPBOX_ENTRY_ADDED");
                        dropboxIntent.putExtra("tag", tag);
                        dropboxIntent.putExtra("time", time);
                        if (!this.mBooted) {
                            dropboxIntent.addFlags(1073741824);
                        }
                        this.mHandler.sendMessage(this.mHandler.obtainMessage(MSG_SEND_BROADCAST, dropboxIntent));
                        if (outputStream != null) {
                            try {
                                outputStream.close();
                            } catch (IOException e2) {
                            }
                        }
                        entry.close();
                        if (temp != null) {
                            temp.delete();
                        }
                    } catch (IOException e3) {
                        e = e3;
                        outputStream = bufferedOutputStream;
                        temp = file;
                        try {
                            Slog.e(TAG, "Can't write: " + tag, e);
                            if (outputStream != null) {
                                try {
                                    outputStream.close();
                                } catch (IOException e4) {
                                }
                            }
                            entry.close();
                            if (temp != null) {
                                temp.delete();
                            }
                        } catch (Throwable th2) {
                            th = th2;
                            if (outputStream != null) {
                                try {
                                    outputStream.close();
                                } catch (IOException e5) {
                                }
                            }
                            entry.close();
                            if (temp != null) {
                                temp.delete();
                            }
                            throw th;
                        }
                    } catch (Throwable th3) {
                        th = th3;
                        outputStream = bufferedOutputStream;
                        temp = file;
                        if (outputStream != null) {
                            outputStream.close();
                        }
                        entry.close();
                        if (temp != null) {
                            temp.delete();
                        }
                        throw th;
                    }
                } catch (IOException e6) {
                    e = e6;
                    temp = file;
                } catch (Throwable th4) {
                    th = th4;
                    temp = file;
                }
            } else {
                if (outputStream != null) {
                    try {
                        outputStream.close();
                    } catch (IOException e7) {
                    }
                }
                entry.close();
                if (temp != null) {
                    temp.delete();
                }
            }
        } catch (IOException e8) {
            e = e8;
            Slog.e(TAG, "Can't write: " + tag, e);
            if (outputStream != null) {
                outputStream.close();
            }
            entry.close();
            if (temp != null) {
                temp.delete();
            }
        }
    }

    public boolean isTagEnabled(String tag) {
        long token = Binder.clearCallingIdentity();
        try {
            boolean z = !"disabled".equals(Global.getString(this.mContentResolver, new StringBuilder().append("dropbox:").append(tag).toString())) ? true : PROFILE_DUMP;
            Binder.restoreCallingIdentity(token);
            return z;
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(token);
        }
    }

    public synchronized Entry getNextEntry(String tag, long millis) {
        Entry entry;
        if (this.mContext.checkCallingOrSelfPermission("android.permission.READ_LOGS") != 0) {
            throw new SecurityException("READ_LOGS permission required");
        }
        try {
            init();
            FileList list = tag == null ? this.mAllFiles : (FileList) this.mFilesByTag.get(tag);
            if (list == null) {
                entry = null;
            } else {
                for (EntryFile entry2 : list.contents.tailSet(new EntryFile(1 + millis))) {
                    if (entry2.tag != null) {
                        if ((entry2.flags & MSG_SEND_BROADCAST) != 0) {
                            entry = new Entry(entry2.tag, entry2.timestampMillis);
                            break;
                        }
                        try {
                            entry = new Entry(entry2.tag, entry2.timestampMillis, entry2.file, entry2.flags);
                            break;
                        } catch (IOException e) {
                            Slog.e(TAG, "Can't read: " + entry2.file, e);
                        }
                    }
                }
                entry = null;
            }
        } catch (IOException e2) {
            Slog.e(TAG, "Can't init", e2);
            entry = null;
        }
        return entry;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public synchronized void dump(java.io.FileDescriptor r32, java.io.PrintWriter r33, java.lang.String[] r34) {
        /*
        r31 = this;
        monitor-enter(r31);
        r0 = r31;
        r3 = r0.mContext;	 Catch:{ all -> 0x0069 }
        r4 = "android.permission.DUMP";
        r3 = r3.checkCallingOrSelfPermission(r4);	 Catch:{ all -> 0x0069 }
        if (r3 == 0) goto L_0x0016;
    L_0x000d:
        r3 = "Permission Denial: Can't dump DropBoxManagerService";
        r0 = r33;
        r0.println(r3);	 Catch:{ all -> 0x0069 }
    L_0x0014:
        monitor-exit(r31);
        return;
    L_0x0016:
        r31.init();	 Catch:{ IOException -> 0x0048 }
        r26 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r26.<init>();	 Catch:{ all -> 0x0069 }
        r14 = 0;
        r13 = 0;
        r27 = new java.util.ArrayList;	 Catch:{ all -> 0x0069 }
        r27.<init>();	 Catch:{ all -> 0x0069 }
        r17 = 0;
    L_0x0027:
        if (r34 == 0) goto L_0x00a8;
    L_0x0029:
        r0 = r34;
        r3 = r0.length;	 Catch:{ all -> 0x0069 }
        r0 = r17;
        if (r0 >= r3) goto L_0x00a8;
    L_0x0030:
        r3 = r34[r17];	 Catch:{ all -> 0x0069 }
        r4 = "-p";
        r3 = r3.equals(r4);	 Catch:{ all -> 0x0069 }
        if (r3 != 0) goto L_0x0044;
    L_0x003a:
        r3 = r34[r17];	 Catch:{ all -> 0x0069 }
        r4 = "--print";
        r3 = r3.equals(r4);	 Catch:{ all -> 0x0069 }
        if (r3 == 0) goto L_0x006c;
    L_0x0044:
        r14 = 1;
    L_0x0045:
        r17 = r17 + 1;
        goto L_0x0027;
    L_0x0048:
        r15 = move-exception;
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r3.<init>();	 Catch:{ all -> 0x0069 }
        r4 = "Can't initialize: ";
        r3 = r3.append(r4);	 Catch:{ all -> 0x0069 }
        r3 = r3.append(r15);	 Catch:{ all -> 0x0069 }
        r3 = r3.toString();	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r0.println(r3);	 Catch:{ all -> 0x0069 }
        r3 = "DropBoxManagerService";
        r4 = "Can't init";
        android.util.Slog.e(r3, r4, r15);	 Catch:{ all -> 0x0069 }
        goto L_0x0014;
    L_0x0069:
        r3 = move-exception;
        monitor-exit(r31);
        throw r3;
    L_0x006c:
        r3 = r34[r17];	 Catch:{ all -> 0x0069 }
        r4 = "-f";
        r3 = r3.equals(r4);	 Catch:{ all -> 0x0069 }
        if (r3 != 0) goto L_0x0080;
    L_0x0076:
        r3 = r34[r17];	 Catch:{ all -> 0x0069 }
        r4 = "--file";
        r3 = r3.equals(r4);	 Catch:{ all -> 0x0069 }
        if (r3 == 0) goto L_0x0082;
    L_0x0080:
        r13 = 1;
        goto L_0x0045;
    L_0x0082:
        r3 = r34[r17];	 Catch:{ all -> 0x0069 }
        r4 = "-";
        r3 = r3.startsWith(r4);	 Catch:{ all -> 0x0069 }
        if (r3 == 0) goto L_0x00a0;
    L_0x008c:
        r3 = "Unknown argument: ";
        r0 = r26;
        r3 = r0.append(r3);	 Catch:{ all -> 0x0069 }
        r4 = r34[r17];	 Catch:{ all -> 0x0069 }
        r3 = r3.append(r4);	 Catch:{ all -> 0x0069 }
        r4 = "\n";
        r3.append(r4);	 Catch:{ all -> 0x0069 }
        goto L_0x0045;
    L_0x00a0:
        r3 = r34[r17];	 Catch:{ all -> 0x0069 }
        r0 = r27;
        r0.add(r3);	 Catch:{ all -> 0x0069 }
        goto L_0x0045;
    L_0x00a8:
        r3 = "Drop box contents: ";
        r0 = r26;
        r3 = r0.append(r3);	 Catch:{ all -> 0x0069 }
        r0 = r31;
        r4 = r0.mAllFiles;	 Catch:{ all -> 0x0069 }
        r4 = r4.contents;	 Catch:{ all -> 0x0069 }
        r4 = r4.size();	 Catch:{ all -> 0x0069 }
        r3 = r3.append(r4);	 Catch:{ all -> 0x0069 }
        r4 = " entries\n";
        r3.append(r4);	 Catch:{ all -> 0x0069 }
        r3 = r27.isEmpty();	 Catch:{ all -> 0x0069 }
        if (r3 != 0) goto L_0x00f3;
    L_0x00c9:
        r3 = "Searching for:";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
        r18 = r27.iterator();	 Catch:{ all -> 0x0069 }
    L_0x00d4:
        r3 = r18.hasNext();	 Catch:{ all -> 0x0069 }
        if (r3 == 0) goto L_0x00ec;
    L_0x00da:
        r8 = r18.next();	 Catch:{ all -> 0x0069 }
        r8 = (java.lang.String) r8;	 Catch:{ all -> 0x0069 }
        r3 = " ";
        r0 = r26;
        r3 = r0.append(r3);	 Catch:{ all -> 0x0069 }
        r3.append(r8);	 Catch:{ all -> 0x0069 }
        goto L_0x00d4;
    L_0x00ec:
        r3 = "\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
    L_0x00f3:
        r25 = 0;
        r24 = r27.size();	 Catch:{ all -> 0x0069 }
        r29 = new android.text.format.Time;	 Catch:{ all -> 0x0069 }
        r29.<init>();	 Catch:{ all -> 0x0069 }
        r3 = "\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
        r0 = r31;
        r3 = r0.mAllFiles;	 Catch:{ all -> 0x0069 }
        r3 = r3.contents;	 Catch:{ all -> 0x0069 }
        r18 = r3.iterator();	 Catch:{ all -> 0x0069 }
    L_0x010f:
        r3 = r18.hasNext();	 Catch:{ all -> 0x0069 }
        if (r3 == 0) goto L_0x032e;
    L_0x0115:
        r16 = r18.next();	 Catch:{ all -> 0x0069 }
        r16 = (com.android.server.DropBoxManagerService.EntryFile) r16;	 Catch:{ all -> 0x0069 }
        r0 = r16;
        r4 = r0.timestampMillis;	 Catch:{ all -> 0x0069 }
        r0 = r29;
        r0.set(r4);	 Catch:{ all -> 0x0069 }
        r3 = "%Y-%m-%d %H:%M:%S";
        r0 = r29;
        r11 = r0.format(r3);	 Catch:{ all -> 0x0069 }
        r21 = 1;
        r17 = 0;
    L_0x0130:
        r0 = r17;
        r1 = r24;
        if (r0 >= r1) goto L_0x015a;
    L_0x0136:
        if (r21 == 0) goto L_0x015a;
    L_0x0138:
        r0 = r27;
        r1 = r17;
        r9 = r0.get(r1);	 Catch:{ all -> 0x0069 }
        r9 = (java.lang.String) r9;	 Catch:{ all -> 0x0069 }
        r3 = r11.contains(r9);	 Catch:{ all -> 0x0069 }
        if (r3 != 0) goto L_0x0152;
    L_0x0148:
        r0 = r16;
        r3 = r0.tag;	 Catch:{ all -> 0x0069 }
        r3 = r9.equals(r3);	 Catch:{ all -> 0x0069 }
        if (r3 == 0) goto L_0x0157;
    L_0x0152:
        r21 = 1;
    L_0x0154:
        r17 = r17 + 1;
        goto L_0x0130;
    L_0x0157:
        r21 = 0;
        goto L_0x0154;
    L_0x015a:
        if (r21 == 0) goto L_0x010f;
    L_0x015c:
        r25 = r25 + 1;
        if (r14 == 0) goto L_0x0167;
    L_0x0160:
        r3 = "========================================\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
    L_0x0167:
        r0 = r26;
        r3 = r0.append(r11);	 Catch:{ all -> 0x0069 }
        r4 = " ";
        r4 = r3.append(r4);	 Catch:{ all -> 0x0069 }
        r0 = r16;
        r3 = r0.tag;	 Catch:{ all -> 0x0069 }
        if (r3 != 0) goto L_0x018c;
    L_0x0179:
        r3 = "(no tag)";
    L_0x017b:
        r4.append(r3);	 Catch:{ all -> 0x0069 }
        r0 = r16;
        r3 = r0.file;	 Catch:{ all -> 0x0069 }
        if (r3 != 0) goto L_0x0191;
    L_0x0184:
        r3 = " (no file)\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
        goto L_0x010f;
    L_0x018c:
        r0 = r16;
        r3 = r0.tag;	 Catch:{ all -> 0x0069 }
        goto L_0x017b;
    L_0x0191:
        r0 = r16;
        r3 = r0.flags;	 Catch:{ all -> 0x0069 }
        r3 = r3 & 1;
        if (r3 == 0) goto L_0x01a2;
    L_0x0199:
        r3 = " (contents lost)\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
        goto L_0x010f;
    L_0x01a2:
        r3 = " (";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
        r0 = r16;
        r3 = r0.flags;	 Catch:{ all -> 0x0069 }
        r3 = r3 & 4;
        if (r3 == 0) goto L_0x01b8;
    L_0x01b1:
        r3 = "compressed ";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
    L_0x01b8:
        r0 = r16;
        r3 = r0.flags;	 Catch:{ all -> 0x0069 }
        r3 = r3 & 2;
        if (r3 == 0) goto L_0x0267;
    L_0x01c0:
        r3 = "text";
    L_0x01c2:
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
        r3 = ", ";
        r0 = r26;
        r3 = r0.append(r3);	 Catch:{ all -> 0x0069 }
        r0 = r16;
        r4 = r0.file;	 Catch:{ all -> 0x0069 }
        r4 = r4.length();	 Catch:{ all -> 0x0069 }
        r3 = r3.append(r4);	 Catch:{ all -> 0x0069 }
        r4 = " bytes)\n";
        r3.append(r4);	 Catch:{ all -> 0x0069 }
        if (r13 != 0) goto L_0x01ec;
    L_0x01e2:
        if (r14 == 0) goto L_0x0208;
    L_0x01e4:
        r0 = r16;
        r3 = r0.flags;	 Catch:{ all -> 0x0069 }
        r3 = r3 & 2;
        if (r3 != 0) goto L_0x0208;
    L_0x01ec:
        if (r14 != 0) goto L_0x01f5;
    L_0x01ee:
        r3 = "    ";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
    L_0x01f5:
        r0 = r16;
        r3 = r0.file;	 Catch:{ all -> 0x0069 }
        r3 = r3.getPath();	 Catch:{ all -> 0x0069 }
        r0 = r26;
        r3 = r0.append(r3);	 Catch:{ all -> 0x0069 }
        r4 = "\n";
        r3.append(r4);	 Catch:{ all -> 0x0069 }
    L_0x0208:
        r0 = r16;
        r3 = r0.flags;	 Catch:{ all -> 0x0069 }
        r3 = r3 & 2;
        if (r3 == 0) goto L_0x025c;
    L_0x0210:
        if (r14 != 0) goto L_0x0214;
    L_0x0212:
        if (r13 != 0) goto L_0x025c;
    L_0x0214:
        r12 = 0;
        r19 = 0;
        r2 = new android.os.DropBoxManager$Entry;	 Catch:{ IOException -> 0x0365, all -> 0x035e }
        r0 = r16;
        r3 = r0.tag;	 Catch:{ IOException -> 0x0365, all -> 0x035e }
        r0 = r16;
        r4 = r0.timestampMillis;	 Catch:{ IOException -> 0x0365, all -> 0x035e }
        r0 = r16;
        r6 = r0.file;	 Catch:{ IOException -> 0x0365, all -> 0x035e }
        r0 = r16;
        r7 = r0.flags;	 Catch:{ IOException -> 0x0365, all -> 0x035e }
        r2.<init>(r3, r4, r6, r7);	 Catch:{ IOException -> 0x0365, all -> 0x035e }
        if (r14 == 0) goto L_0x02d9;
    L_0x022e:
        r20 = new java.io.InputStreamReader;	 Catch:{ IOException -> 0x02f8 }
        r3 = r2.getInputStream();	 Catch:{ IOException -> 0x02f8 }
        r0 = r20;
        r0.<init>(r3);	 Catch:{ IOException -> 0x02f8 }
        r3 = 4096; // 0x1000 float:5.74E-42 double:2.0237E-320;
        r10 = new char[r3];	 Catch:{ IOException -> 0x0295, all -> 0x0361 }
        r23 = 0;
    L_0x023f:
        r0 = r20;
        r22 = r0.read(r10);	 Catch:{ IOException -> 0x0295, all -> 0x0361 }
        if (r22 > 0) goto L_0x026b;
    L_0x0247:
        if (r23 != 0) goto L_0x0250;
    L_0x0249:
        r3 = "\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ IOException -> 0x0295, all -> 0x0361 }
    L_0x0250:
        r19 = r20;
    L_0x0252:
        if (r2 == 0) goto L_0x0257;
    L_0x0254:
        r2.close();	 Catch:{ all -> 0x0069 }
    L_0x0257:
        if (r19 == 0) goto L_0x025c;
    L_0x0259:
        r19.close();	 Catch:{ IOException -> 0x0359 }
    L_0x025c:
        if (r14 == 0) goto L_0x010f;
    L_0x025e:
        r3 = "\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
        goto L_0x010f;
    L_0x0267:
        r3 = "data";
        goto L_0x01c2;
    L_0x026b:
        r3 = 0;
        r0 = r26;
        r1 = r22;
        r0.append(r10, r3, r1);	 Catch:{ IOException -> 0x0295, all -> 0x0361 }
        r3 = r22 + -1;
        r3 = r10[r3];	 Catch:{ IOException -> 0x0295, all -> 0x0361 }
        r4 = 10;
        if (r3 != r4) goto L_0x02d6;
    L_0x027b:
        r23 = 1;
    L_0x027d:
        r3 = r26.length();	 Catch:{ IOException -> 0x0295, all -> 0x0361 }
        r4 = 65536; // 0x10000 float:9.18355E-41 double:3.2379E-319;
        if (r3 <= r4) goto L_0x023f;
    L_0x0285:
        r3 = r26.toString();	 Catch:{ IOException -> 0x0295, all -> 0x0361 }
        r0 = r33;
        r0.write(r3);	 Catch:{ IOException -> 0x0295, all -> 0x0361 }
        r3 = 0;
        r0 = r26;
        r0.setLength(r3);	 Catch:{ IOException -> 0x0295, all -> 0x0361 }
        goto L_0x023f;
    L_0x0295:
        r15 = move-exception;
        r19 = r20;
    L_0x0298:
        r3 = "*** ";
        r0 = r26;
        r3 = r0.append(r3);	 Catch:{ all -> 0x031f }
        r4 = r15.toString();	 Catch:{ all -> 0x031f }
        r3 = r3.append(r4);	 Catch:{ all -> 0x031f }
        r4 = "\n";
        r3.append(r4);	 Catch:{ all -> 0x031f }
        r3 = "DropBoxManagerService";
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x031f }
        r4.<init>();	 Catch:{ all -> 0x031f }
        r5 = "Can't read: ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x031f }
        r0 = r16;
        r5 = r0.file;	 Catch:{ all -> 0x031f }
        r4 = r4.append(r5);	 Catch:{ all -> 0x031f }
        r4 = r4.toString();	 Catch:{ all -> 0x031f }
        android.util.Slog.e(r3, r4, r15);	 Catch:{ all -> 0x031f }
        if (r2 == 0) goto L_0x02ce;
    L_0x02cb:
        r2.close();	 Catch:{ all -> 0x0069 }
    L_0x02ce:
        if (r19 == 0) goto L_0x025c;
    L_0x02d0:
        r19.close();	 Catch:{ IOException -> 0x02d4 }
        goto L_0x025c;
    L_0x02d4:
        r3 = move-exception;
        goto L_0x025c;
    L_0x02d6:
        r23 = 0;
        goto L_0x027d;
    L_0x02d9:
        r3 = 70;
        r28 = r2.getText(r3);	 Catch:{ IOException -> 0x02f8 }
        r3 = "    ";
        r0 = r26;
        r0.append(r3);	 Catch:{ IOException -> 0x02f8 }
        if (r28 != 0) goto L_0x02fa;
    L_0x02e8:
        r3 = "[null]";
        r0 = r26;
        r0.append(r3);	 Catch:{ IOException -> 0x02f8 }
    L_0x02ef:
        r3 = "\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ IOException -> 0x02f8 }
        goto L_0x0252;
    L_0x02f8:
        r15 = move-exception;
        goto L_0x0298;
    L_0x02fa:
        r3 = r28.length();	 Catch:{ IOException -> 0x02f8 }
        r4 = 70;
        if (r3 != r4) goto L_0x032b;
    L_0x0302:
        r30 = 1;
    L_0x0304:
        r3 = r28.trim();	 Catch:{ IOException -> 0x02f8 }
        r4 = 10;
        r5 = 47;
        r3 = r3.replace(r4, r5);	 Catch:{ IOException -> 0x02f8 }
        r0 = r26;
        r0.append(r3);	 Catch:{ IOException -> 0x02f8 }
        if (r30 == 0) goto L_0x02ef;
    L_0x0317:
        r3 = " ...";
        r0 = r26;
        r0.append(r3);	 Catch:{ IOException -> 0x02f8 }
        goto L_0x02ef;
    L_0x031f:
        r3 = move-exception;
    L_0x0320:
        if (r2 == 0) goto L_0x0325;
    L_0x0322:
        r2.close();	 Catch:{ all -> 0x0069 }
    L_0x0325:
        if (r19 == 0) goto L_0x032a;
    L_0x0327:
        r19.close();	 Catch:{ IOException -> 0x035c }
    L_0x032a:
        throw r3;	 Catch:{ all -> 0x0069 }
    L_0x032b:
        r30 = 0;
        goto L_0x0304;
    L_0x032e:
        if (r25 != 0) goto L_0x0337;
    L_0x0330:
        r3 = "(No entries found.)\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
    L_0x0337:
        if (r34 == 0) goto L_0x033e;
    L_0x0339:
        r0 = r34;
        r3 = r0.length;	 Catch:{ all -> 0x0069 }
        if (r3 != 0) goto L_0x034e;
    L_0x033e:
        if (r14 != 0) goto L_0x0347;
    L_0x0340:
        r3 = "\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
    L_0x0347:
        r3 = "Usage: dumpsys dropbox [--print|--file] [YYYY-mm-dd] [HH:MM:SS] [tag]\n";
        r0 = r26;
        r0.append(r3);	 Catch:{ all -> 0x0069 }
    L_0x034e:
        r3 = r26.toString();	 Catch:{ all -> 0x0069 }
        r0 = r33;
        r0.write(r3);	 Catch:{ all -> 0x0069 }
        goto L_0x0014;
    L_0x0359:
        r3 = move-exception;
        goto L_0x025c;
    L_0x035c:
        r4 = move-exception;
        goto L_0x032a;
    L_0x035e:
        r3 = move-exception;
        r2 = r12;
        goto L_0x0320;
    L_0x0361:
        r3 = move-exception;
        r19 = r20;
        goto L_0x0320;
    L_0x0365:
        r15 = move-exception;
        r2 = r12;
        goto L_0x0298;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.DropBoxManagerService.dump(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String[]):void");
    }

    private synchronized void init() throws IOException {
        if (this.mStatFs == null) {
            if (this.mDropBoxDir.isDirectory() || this.mDropBoxDir.mkdirs()) {
                try {
                    this.mStatFs = new StatFs(this.mDropBoxDir.getPath());
                    this.mBlockSize = this.mStatFs.getBlockSize();
                } catch (IllegalArgumentException e) {
                    throw new IOException("Can't statfs: " + this.mDropBoxDir);
                }
            }
            throw new IOException("Can't mkdir: " + this.mDropBoxDir);
        }
        if (this.mAllFiles == null) {
            File[] files = this.mDropBoxDir.listFiles();
            if (files == null) {
                throw new IOException("Can't list files: " + this.mDropBoxDir);
            }
            this.mAllFiles = new FileList();
            this.mFilesByTag = new HashMap();
            File[] arr$ = files;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += MSG_SEND_BROADCAST) {
                File file = arr$[i$];
                if (file.getName().endsWith(".tmp")) {
                    Slog.i(TAG, "Cleaning temp file: " + file);
                    file.delete();
                } else {
                    EntryFile entry = new EntryFile(file, this.mBlockSize);
                    if (entry.tag == null) {
                        Slog.w(TAG, "Unrecognized file: " + file);
                    } else if (entry.timestampMillis == 0) {
                        Slog.w(TAG, "Invalid filename: " + file);
                        file.delete();
                    } else {
                        enrollEntry(entry);
                    }
                }
            }
        }
    }

    private synchronized void enrollEntry(EntryFile entry) {
        this.mAllFiles.contents.add(entry);
        FileList fileList = this.mAllFiles;
        fileList.blocks += entry.blocks;
        if (!(entry.tag == null || entry.file == null || entry.blocks <= 0)) {
            FileList tagFiles = (FileList) this.mFilesByTag.get(entry.tag);
            if (tagFiles == null) {
                tagFiles = new FileList();
                this.mFilesByTag.put(entry.tag, tagFiles);
            }
            tagFiles.contents.add(entry);
            tagFiles.blocks += entry.blocks;
        }
    }

    private synchronized long createEntry(File temp, String tag, int flags) throws IOException {
        long t;
        t = System.currentTimeMillis();
        SortedSet<EntryFile> tail = this.mAllFiles.contents.tailSet(new EntryFile(10000 + t));
        EntryFile[] future = null;
        if (!tail.isEmpty()) {
            future = (EntryFile[]) tail.toArray(new EntryFile[tail.size()]);
            tail.clear();
        }
        if (!this.mAllFiles.contents.isEmpty()) {
            t = Math.max(t, ((EntryFile) this.mAllFiles.contents.last()).timestampMillis + 1);
        }
        if (future != null) {
            EntryFile[] arr$ = future;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += MSG_SEND_BROADCAST) {
                EntryFile late = arr$[i$];
                FileList fileList = this.mAllFiles;
                fileList.blocks -= late.blocks;
                FileList tagFiles = (FileList) this.mFilesByTag.get(late.tag);
                if (tagFiles != null && tagFiles.contents.remove(late)) {
                    tagFiles.blocks -= late.blocks;
                }
                long t2;
                if ((late.flags & MSG_SEND_BROADCAST) == 0) {
                    t2 = t + 1;
                    enrollEntry(new EntryFile(late.file, this.mDropBoxDir, late.tag, t, late.flags, this.mBlockSize));
                    t = t2;
                } else {
                    t2 = t + 1;
                    enrollEntry(new EntryFile(this.mDropBoxDir, late.tag, t));
                    t = t2;
                }
            }
        }
        if (temp == null) {
            enrollEntry(new EntryFile(this.mDropBoxDir, tag, t));
        } else {
            enrollEntry(new EntryFile(temp, this.mDropBoxDir, tag, t, flags, this.mBlockSize));
        }
        return t;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private synchronized long trimToFit() {
        /*
        r32 = this;
        monitor-enter(r32);
        r0 = r32;
        r0 = r0.mContentResolver;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r27 = "dropbox_age_seconds";
        r28 = 259200; // 0x3f480 float:3.63217E-40 double:1.28062E-318;
        r6 = android.provider.Settings.Global.getInt(r26, r27, r28);	 Catch:{ all -> 0x0215 }
        r0 = r32;
        r0 = r0.mContentResolver;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r27 = "dropbox_max_files";
        r28 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r13 = android.provider.Settings.Global.getInt(r26, r27, r28);	 Catch:{ all -> 0x0215 }
        r26 = java.lang.System.currentTimeMillis();	 Catch:{ all -> 0x0215 }
        r0 = r6 * 1000;
        r28 = r0;
        r0 = r28;
        r0 = (long) r0;	 Catch:{ all -> 0x0215 }
        r28 = r0;
        r8 = r26 - r28;
    L_0x002d:
        r0 = r32;
        r0 = r0.mAllFiles;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r0 = r0.contents;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r26 = r26.isEmpty();	 Catch:{ all -> 0x0215 }
        if (r26 != 0) goto L_0x006d;
    L_0x003f:
        r0 = r32;
        r0 = r0.mAllFiles;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r0 = r0.contents;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r11 = r26.first();	 Catch:{ all -> 0x0215 }
        r11 = (com.android.server.DropBoxManagerService.EntryFile) r11;	 Catch:{ all -> 0x0215 }
        r0 = r11.timestampMillis;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r26 = (r26 > r8 ? 1 : (r26 == r8 ? 0 : -1));
        if (r26 <= 0) goto L_0x01a8;
    L_0x0059:
        r0 = r32;
        r0 = r0.mAllFiles;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r0 = r0.contents;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r26 = r26.size();	 Catch:{ all -> 0x0215 }
        r0 = r26;
        if (r0 >= r13) goto L_0x01a8;
    L_0x006d:
        r24 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0215 }
        r0 = r32;
        r0 = r0.mCachedQuotaUptimeMillis;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r28 = 5000; // 0x1388 float:7.006E-42 double:2.4703E-320;
        r26 = r26 + r28;
        r26 = (r24 > r26 ? 1 : (r24 == r26 ? 0 : -1));
        if (r26 <= 0) goto L_0x0100;
    L_0x007f:
        r0 = r32;
        r0 = r0.mContentResolver;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r27 = "dropbox_quota_percent";
        r28 = 10;
        r17 = android.provider.Settings.Global.getInt(r26, r27, r28);	 Catch:{ all -> 0x0215 }
        r0 = r32;
        r0 = r0.mContentResolver;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r27 = "dropbox_reserve_percent";
        r28 = 10;
        r18 = android.provider.Settings.Global.getInt(r26, r27, r28);	 Catch:{ all -> 0x0215 }
        r0 = r32;
        r0 = r0.mContentResolver;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r27 = "dropbox_quota_kb";
        r28 = 5120; // 0x1400 float:7.175E-42 double:2.5296E-320;
        r16 = android.provider.Settings.Global.getInt(r26, r27, r28);	 Catch:{ all -> 0x0215 }
        r0 = r32;
        r0 = r0.mStatFs;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r32;
        r0 = r0.mDropBoxDir;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r27 = r27.getPath();	 Catch:{ all -> 0x0215 }
        r26.restat(r27);	 Catch:{ all -> 0x0215 }
        r0 = r32;
        r0 = r0.mStatFs;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r7 = r26.getAvailableBlocks();	 Catch:{ all -> 0x0215 }
        r0 = r32;
        r0 = r0.mStatFs;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r26 = r26.getBlockCount();	 Catch:{ all -> 0x0215 }
        r26 = r26 * r18;
        r26 = r26 / 100;
        r15 = r7 - r26;
        r0 = r16;
        r0 = r0 * 1024;
        r26 = r0;
        r0 = r32;
        r0 = r0.mBlockSize;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r14 = r26 / r27;
        r26 = 0;
        r27 = r15 * r17;
        r27 = r27 / 100;
        r26 = java.lang.Math.max(r26, r27);	 Catch:{ all -> 0x0215 }
        r0 = r26;
        r26 = java.lang.Math.min(r14, r0);	 Catch:{ all -> 0x0215 }
        r0 = r26;
        r1 = r32;
        r1.mCachedQuotaBlocks = r0;	 Catch:{ all -> 0x0215 }
        r0 = r24;
        r2 = r32;
        r2.mCachedQuotaUptimeMillis = r0;	 Catch:{ all -> 0x0215 }
    L_0x0100:
        r0 = r32;
        r0 = r0.mAllFiles;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r0 = r0.blocks;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r32;
        r0 = r0.mCachedQuotaBlocks;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r0 = r26;
        r1 = r27;
        if (r0 <= r1) goto L_0x0193;
    L_0x0118:
        r0 = r32;
        r0 = r0.mAllFiles;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r0 = r0.blocks;	 Catch:{ all -> 0x0215 }
        r23 = r0;
        r19 = 0;
        r22 = new java.util.TreeSet;	 Catch:{ all -> 0x0215 }
        r0 = r32;
        r0 = r0.mFilesByTag;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r26 = r26.values();	 Catch:{ all -> 0x0215 }
        r0 = r22;
        r1 = r26;
        r0.<init>(r1);	 Catch:{ all -> 0x0215 }
        r12 = r22.iterator();	 Catch:{ all -> 0x0215 }
    L_0x013d:
        r26 = r12.hasNext();	 Catch:{ all -> 0x0215 }
        if (r26 == 0) goto L_0x0161;
    L_0x0143:
        r20 = r12.next();	 Catch:{ all -> 0x0215 }
        r20 = (com.android.server.DropBoxManagerService.FileList) r20;	 Catch:{ all -> 0x0215 }
        if (r19 <= 0) goto L_0x0218;
    L_0x014b:
        r0 = r20;
        r0 = r0.blocks;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r32;
        r0 = r0.mCachedQuotaBlocks;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r27 = r27 - r23;
        r27 = r27 / r19;
        r0 = r26;
        r1 = r27;
        if (r0 > r1) goto L_0x0218;
    L_0x0161:
        r0 = r32;
        r0 = r0.mCachedQuotaBlocks;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r26 = r26 - r23;
        r21 = r26 / r19;
        r12 = r22.iterator();	 Catch:{ all -> 0x0215 }
    L_0x016f:
        r26 = r12.hasNext();	 Catch:{ all -> 0x0215 }
        if (r26 == 0) goto L_0x0193;
    L_0x0175:
        r20 = r12.next();	 Catch:{ all -> 0x0215 }
        r20 = (com.android.server.DropBoxManagerService.FileList) r20;	 Catch:{ all -> 0x0215 }
        r0 = r32;
        r0 = r0.mAllFiles;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r0 = r0.blocks;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r32;
        r0 = r0.mCachedQuotaBlocks;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r0 = r26;
        r1 = r27;
        if (r0 >= r1) goto L_0x0224;
    L_0x0193:
        r0 = r32;
        r0 = r0.mCachedQuotaBlocks;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r32;
        r0 = r0.mBlockSize;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r26 = r26 * r27;
        r0 = r26;
        r0 = (long) r0;
        r26 = r0;
        monitor-exit(r32);
        return r26;
    L_0x01a8:
        r0 = r32;
        r0 = r0.mFilesByTag;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r11.tag;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r20 = r26.get(r27);	 Catch:{ all -> 0x0215 }
        r20 = (com.android.server.DropBoxManagerService.FileList) r20;	 Catch:{ all -> 0x0215 }
        if (r20 == 0) goto L_0x01da;
    L_0x01ba:
        r0 = r20;
        r0 = r0.contents;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r26 = r0.remove(r11);	 Catch:{ all -> 0x0215 }
        if (r26 == 0) goto L_0x01da;
    L_0x01c8:
        r0 = r20;
        r0 = r0.blocks;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r11.blocks;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r26 = r26 - r27;
        r0 = r26;
        r1 = r20;
        r1.blocks = r0;	 Catch:{ all -> 0x0215 }
    L_0x01da:
        r0 = r32;
        r0 = r0.mAllFiles;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r0 = r0.contents;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r26 = r0.remove(r11);	 Catch:{ all -> 0x0215 }
        if (r26 == 0) goto L_0x0206;
    L_0x01ee:
        r0 = r32;
        r0 = r0.mAllFiles;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r0 = r0.blocks;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r0 = r11.blocks;	 Catch:{ all -> 0x0215 }
        r28 = r0;
        r27 = r27 - r28;
        r0 = r27;
        r1 = r26;
        r1.blocks = r0;	 Catch:{ all -> 0x0215 }
    L_0x0206:
        r0 = r11.file;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        if (r26 == 0) goto L_0x002d;
    L_0x020c:
        r0 = r11.file;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r26.delete();	 Catch:{ all -> 0x0215 }
        goto L_0x002d;
    L_0x0215:
        r26 = move-exception;
        monitor-exit(r32);
        throw r26;
    L_0x0218:
        r0 = r20;
        r0 = r0.blocks;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r23 = r23 - r26;
        r19 = r19 + 1;
        goto L_0x013d;
    L_0x0224:
        r0 = r20;
        r0 = r0.blocks;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r1 = r21;
        if (r0 <= r1) goto L_0x016f;
    L_0x0230:
        r0 = r20;
        r0 = r0.contents;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r26 = r26.isEmpty();	 Catch:{ all -> 0x0215 }
        if (r26 != 0) goto L_0x016f;
    L_0x023c:
        r0 = r20;
        r0 = r0.contents;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r11 = r26.first();	 Catch:{ all -> 0x0215 }
        r11 = (com.android.server.DropBoxManagerService.EntryFile) r11;	 Catch:{ all -> 0x0215 }
        r0 = r20;
        r0 = r0.contents;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r26 = r0.remove(r11);	 Catch:{ all -> 0x0215 }
        if (r26 == 0) goto L_0x0268;
    L_0x0256:
        r0 = r20;
        r0 = r0.blocks;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r11.blocks;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r26 = r26 - r27;
        r0 = r26;
        r1 = r20;
        r1.blocks = r0;	 Catch:{ all -> 0x0215 }
    L_0x0268:
        r0 = r32;
        r0 = r0.mAllFiles;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r0 = r0.contents;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r26 = r0.remove(r11);	 Catch:{ all -> 0x0215 }
        if (r26 == 0) goto L_0x0294;
    L_0x027c:
        r0 = r32;
        r0 = r0.mAllFiles;	 Catch:{ all -> 0x0215 }
        r26 = r0;
        r0 = r26;
        r0 = r0.blocks;	 Catch:{ all -> 0x0215 }
        r27 = r0;
        r0 = r11.blocks;	 Catch:{ all -> 0x0215 }
        r28 = r0;
        r27 = r27 - r28;
        r0 = r27;
        r1 = r26;
        r1.blocks = r0;	 Catch:{ all -> 0x0215 }
    L_0x0294:
        r0 = r11.file;	 Catch:{ IOException -> 0x02c5 }
        r26 = r0;
        if (r26 == 0) goto L_0x02a1;
    L_0x029a:
        r0 = r11.file;	 Catch:{ IOException -> 0x02c5 }
        r26 = r0;
        r26.delete();	 Catch:{ IOException -> 0x02c5 }
    L_0x02a1:
        r26 = new com.android.server.DropBoxManagerService$EntryFile;	 Catch:{ IOException -> 0x02c5 }
        r0 = r32;
        r0 = r0.mDropBoxDir;	 Catch:{ IOException -> 0x02c5 }
        r27 = r0;
        r0 = r11.tag;	 Catch:{ IOException -> 0x02c5 }
        r28 = r0;
        r0 = r11.timestampMillis;	 Catch:{ IOException -> 0x02c5 }
        r30 = r0;
        r0 = r26;
        r1 = r27;
        r2 = r28;
        r3 = r30;
        r0.<init>(r1, r2, r3);	 Catch:{ IOException -> 0x02c5 }
        r0 = r32;
        r1 = r26;
        r0.enrollEntry(r1);	 Catch:{ IOException -> 0x02c5 }
        goto L_0x0224;
    L_0x02c5:
        r10 = move-exception;
        r26 = "DropBoxManagerService";
        r27 = "Can't write tombstone file";
        r0 = r26;
        r1 = r27;
        android.util.Slog.e(r0, r1, r10);	 Catch:{ all -> 0x0215 }
        goto L_0x0224;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.DropBoxManagerService.trimToFit():long");
    }
}
