package com.android.server.am;

import android.app.ActivityManager;
import android.app.AppGlobals;
import android.content.ComponentName;
import android.content.pm.IPackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.RemoteException;
import android.os.SystemClock;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.Slog;
import android.util.SparseArray;
import android.util.Xml;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.util.XmlUtils;
import com.android.server.job.controllers.JobStatus;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class TaskPersister {
    static final boolean DEBUG_PERSISTER = false;
    static final boolean DEBUG_RESTORER = false;
    private static final long FLUSH_QUEUE = -1;
    private static final String IMAGES_DIRNAME = "recent_images";
    static final String IMAGE_EXTENSION = ".png";
    private static final long INTER_WRITE_DELAY_MS = 500;
    private static final long MAX_INSTALL_WAIT_TIME = 86400000;
    private static final int MAX_WRITE_QUEUE_LENGTH = 6;
    private static final long PRE_TASK_DELAY_MS = 3000;
    private static final String RECENTS_FILENAME = "_task";
    private static final String RESTORED_TASKS_DIRNAME = "restored_recent_tasks";
    static final String TAG = "TaskPersister";
    private static final String TAG_TASK = "task";
    private static final String TASKS_DIRNAME = "recent_tasks";
    private static final String TASK_EXTENSION = ".xml";
    static File sImagesDir;
    static File sRestoredTasksDir;
    static File sTasksDir;
    private long mExpiredTasksCleanupTime;
    private final LazyTaskWriterThread mLazyTaskWriterThread;
    private long mNextWriteTime;
    private ArrayMap<String, List<List<OtherDeviceTask>>> mOtherDeviceTasksMap;
    private ArrayMap<String, Integer> mPackageUidMap;
    private final ActivityManagerService mService;
    private final ActivityStackSupervisor mStackSupervisor;
    ArrayList<WriteQueueItem> mWriteQueue;

    /* renamed from: com.android.server.am.TaskPersister.1 */
    class C01511 implements Comparator<TaskRecord> {
        C01511() {
        }

        public int compare(TaskRecord lhs, TaskRecord rhs) {
            long diff = rhs.mLastTimeMoved - lhs.mLastTimeMoved;
            if (diff < 0) {
                return -1;
            }
            if (diff > 0) {
                return 1;
            }
            return 0;
        }
    }

    private static class WriteQueueItem {
        private WriteQueueItem() {
        }
    }

    private static class ImageWriteQueueItem extends WriteQueueItem {
        final String mFilename;
        Bitmap mImage;

        ImageWriteQueueItem(String filename, Bitmap image) {
            super();
            this.mFilename = filename;
            this.mImage = image;
        }
    }

    private class LazyTaskWriterThread extends Thread {
        LazyTaskWriterThread(String name) {
            super(name);
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void run() {
            /*
            r28 = this;
            r16 = new android.util.ArraySet;
            r16.<init>();
        L_0x0005:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;
            r23 = r0;
            monitor-enter(r23);
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0087 }
            r22 = r0;
            r0 = r22;
            r0 = r0.mWriteQueue;	 Catch:{ all -> 0x0087 }
            r22 = r0;
            r17 = r22.isEmpty();	 Catch:{ all -> 0x0087 }
            monitor-exit(r23);	 Catch:{ all -> 0x0087 }
            if (r17 == 0) goto L_0x0098;
        L_0x001f:
            r16.clear();
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;
            r22 = r0;
            r23 = r22.mService;
            monitor-enter(r23);
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0113 }
            r22 = r0;
            r22 = r22.mService;	 Catch:{ all -> 0x0113 }
            r0 = r22;
            r0 = r0.mRecentTasks;	 Catch:{ all -> 0x0113 }
            r21 = r0;
            r22 = r21.size();	 Catch:{ all -> 0x0113 }
            r20 = r22 + -1;
        L_0x0043:
            if (r20 < 0) goto L_0x008a;
        L_0x0045:
            r0 = r21;
            r1 = r20;
            r19 = r0.get(r1);	 Catch:{ all -> 0x0113 }
            r19 = (com.android.server.am.TaskRecord) r19;	 Catch:{ all -> 0x0113 }
            r0 = r19;
            r0 = r0.isPersistable;	 Catch:{ all -> 0x0113 }
            r22 = r0;
            if (r22 != 0) goto L_0x005f;
        L_0x0057:
            r0 = r19;
            r0 = r0.inRecents;	 Catch:{ all -> 0x0113 }
            r22 = r0;
            if (r22 == 0) goto L_0x0084;
        L_0x005f:
            r0 = r19;
            r0 = r0.stack;	 Catch:{ all -> 0x0113 }
            r22 = r0;
            if (r22 == 0) goto L_0x0073;
        L_0x0067:
            r0 = r19;
            r0 = r0.stack;	 Catch:{ all -> 0x0113 }
            r22 = r0;
            r22 = r22.isHomeStack();	 Catch:{ all -> 0x0113 }
            if (r22 != 0) goto L_0x0084;
        L_0x0073:
            r0 = r19;
            r0 = r0.taskId;	 Catch:{ all -> 0x0113 }
            r22 = r0;
            r22 = java.lang.Integer.valueOf(r22);	 Catch:{ all -> 0x0113 }
            r0 = r16;
            r1 = r22;
            r0.add(r1);	 Catch:{ all -> 0x0113 }
        L_0x0084:
            r20 = r20 + -1;
            goto L_0x0043;
        L_0x0087:
            r22 = move-exception;
            monitor-exit(r23);	 Catch:{ all -> 0x0087 }
            throw r22;
        L_0x008a:
            monitor-exit(r23);	 Catch:{ all -> 0x0113 }
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;
            r22 = r0;
            r0 = r22;
            r1 = r16;
            r0.removeObsoleteFiles(r1);
        L_0x0098:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;
            r23 = r0;
            monitor-enter(r23);
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r24 = r22.mNextWriteTime;	 Catch:{ all -> 0x0190 }
            r26 = -1;
            r22 = (r24 > r26 ? 1 : (r24 == r26 ? 0 : -1));
            if (r22 == 0) goto L_0x00c4;
        L_0x00af:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r24 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0190 }
            r26 = 500; // 0x1f4 float:7.0E-43 double:2.47E-321;
            r24 = r24 + r26;
            r0 = r22;
            r1 = r24;
            r0.mNextWriteTime = r1;	 Catch:{ all -> 0x0190 }
        L_0x00c4:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r0 = r22;
            r0 = r0.mWriteQueue;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r22 = r22.isEmpty();	 Catch:{ all -> 0x0190 }
            if (r22 == 0) goto L_0x0116;
        L_0x00d6:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r24 = r22.mNextWriteTime;	 Catch:{ all -> 0x0190 }
            r26 = 0;
            r22 = (r24 > r26 ? 1 : (r24 == r26 ? 0 : -1));
            if (r22 == 0) goto L_0x00fe;
        L_0x00e6:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r24 = 0;
            r0 = r22;
            r1 = r24;
            r0.mNextWriteTime = r1;	 Catch:{ all -> 0x0190 }
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r22.notifyAll();	 Catch:{ all -> 0x0190 }
        L_0x00fe:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r22.removeExpiredTasksIfNeeded();	 Catch:{ all -> 0x0190 }
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ InterruptedException -> 0x0111 }
            r22 = r0;
            r22.wait();	 Catch:{ InterruptedException -> 0x0111 }
            goto L_0x00c4;
        L_0x0111:
            r22 = move-exception;
            goto L_0x00c4;
        L_0x0113:
            r22 = move-exception;
            monitor-exit(r23);	 Catch:{ all -> 0x0113 }
            throw r22;
        L_0x0116:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r0 = r22;
            r0 = r0.mWriteQueue;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r24 = 0;
            r0 = r22;
            r1 = r24;
            r13 = r0.remove(r1);	 Catch:{ all -> 0x0190 }
            r13 = (com.android.server.am.TaskPersister.WriteQueueItem) r13;	 Catch:{ all -> 0x0190 }
            r14 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0190 }
        L_0x0132:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ all -> 0x0190 }
            r22 = r0;
            r24 = r22.mNextWriteTime;	 Catch:{ all -> 0x0190 }
            r22 = (r14 > r24 ? 1 : (r14 == r24 ? 0 : -1));
            if (r22 >= 0) goto L_0x015e;
        L_0x0140:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ InterruptedException -> 0x0280 }
            r22 = r0;
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ InterruptedException -> 0x0280 }
            r24 = r0;
            r24 = r24.mNextWriteTime;	 Catch:{ InterruptedException -> 0x0280 }
            r24 = r24 - r14;
            r0 = r22;
            r1 = r24;
            r0.wait(r1);	 Catch:{ InterruptedException -> 0x0280 }
        L_0x0159:
            r14 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0190 }
            goto L_0x0132;
        L_0x015e:
            monitor-exit(r23);	 Catch:{ all -> 0x0190 }
            r0 = r13 instanceof com.android.server.am.TaskPersister.ImageWriteQueueItem;
            r22 = r0;
            if (r22 == 0) goto L_0x01bc;
        L_0x0165:
            r12 = r13;
            r12 = (com.android.server.am.TaskPersister.ImageWriteQueueItem) r12;
            r9 = r12.mFilename;
            r6 = r12.mImage;
            r10 = 0;
            r11 = new java.io.FileOutputStream;	 Catch:{ Exception -> 0x0193 }
            r22 = new java.io.File;	 Catch:{ Exception -> 0x0193 }
            r23 = com.android.server.am.TaskPersister.sImagesDir;	 Catch:{ Exception -> 0x0193 }
            r0 = r22;
            r1 = r23;
            r0.<init>(r1, r9);	 Catch:{ Exception -> 0x0193 }
            r0 = r22;
            r11.<init>(r0);	 Catch:{ Exception -> 0x0193 }
            r22 = android.graphics.Bitmap.CompressFormat.PNG;	 Catch:{ Exception -> 0x027c, all -> 0x0278 }
            r23 = 100;
            r0 = r22;
            r1 = r23;
            r6.compress(r0, r1, r11);	 Catch:{ Exception -> 0x027c, all -> 0x0278 }
            libcore.io.IoUtils.closeQuietly(r11);
            r10 = r11;
            goto L_0x0005;
        L_0x0190:
            r22 = move-exception;
            monitor-exit(r23);	 Catch:{ all -> 0x0190 }
            throw r22;
        L_0x0193:
            r7 = move-exception;
        L_0x0194:
            r22 = "TaskPersister";
            r23 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01b7 }
            r23.<init>();	 Catch:{ all -> 0x01b7 }
            r24 = "saveImage: unable to save ";
            r23 = r23.append(r24);	 Catch:{ all -> 0x01b7 }
            r0 = r23;
            r23 = r0.append(r9);	 Catch:{ all -> 0x01b7 }
            r23 = r23.toString();	 Catch:{ all -> 0x01b7 }
            r0 = r22;
            r1 = r23;
            android.util.Slog.e(r0, r1, r7);	 Catch:{ all -> 0x01b7 }
            libcore.io.IoUtils.closeQuietly(r10);
            goto L_0x0005;
        L_0x01b7:
            r22 = move-exception;
        L_0x01b8:
            libcore.io.IoUtils.closeQuietly(r10);
            throw r22;
        L_0x01bc:
            r0 = r13 instanceof com.android.server.am.TaskPersister.TaskWriteQueueItem;
            r22 = r0;
            if (r22 == 0) goto L_0x0005;
        L_0x01c2:
            r18 = 0;
            r13 = (com.android.server.am.TaskPersister.TaskWriteQueueItem) r13;
            r0 = r13.mTask;
            r19 = r0;
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;
            r22 = r0;
            r23 = r22.mService;
            monitor-enter(r23);
            r0 = r19;
            r0 = r0.inRecents;	 Catch:{ all -> 0x026d }
            r22 = r0;
            if (r22 == 0) goto L_0x01eb;
        L_0x01dd:
            r0 = r28;
            r0 = com.android.server.am.TaskPersister.this;	 Catch:{ IOException -> 0x0275, XmlPullParserException -> 0x0272 }
            r22 = r0;
            r0 = r22;
            r1 = r19;
            r18 = r0.saveToXml(r1);	 Catch:{ IOException -> 0x0275, XmlPullParserException -> 0x0272 }
        L_0x01eb:
            monitor-exit(r23);	 Catch:{ all -> 0x026d }
            if (r18 == 0) goto L_0x0005;
        L_0x01ee:
            r8 = 0;
            r4 = 0;
            r5 = new android.util.AtomicFile;	 Catch:{ IOException -> 0x0270 }
            r22 = new java.io.File;	 Catch:{ IOException -> 0x0270 }
            r23 = com.android.server.am.TaskPersister.sTasksDir;	 Catch:{ IOException -> 0x0270 }
            r24 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x0270 }
            r24.<init>();	 Catch:{ IOException -> 0x0270 }
            r0 = r19;
            r0 = r0.taskId;	 Catch:{ IOException -> 0x0270 }
            r25 = r0;
            r25 = java.lang.String.valueOf(r25);	 Catch:{ IOException -> 0x0270 }
            r24 = r24.append(r25);	 Catch:{ IOException -> 0x0270 }
            r25 = "_task";
            r24 = r24.append(r25);	 Catch:{ IOException -> 0x0270 }
            r25 = ".xml";
            r24 = r24.append(r25);	 Catch:{ IOException -> 0x0270 }
            r24 = r24.toString();	 Catch:{ IOException -> 0x0270 }
            r22.<init>(r23, r24);	 Catch:{ IOException -> 0x0270 }
            r0 = r22;
            r5.<init>(r0);	 Catch:{ IOException -> 0x0270 }
            r8 = r5.startWrite();	 Catch:{ IOException -> 0x023e }
            r22 = r18.toString();	 Catch:{ IOException -> 0x023e }
            r22 = r22.getBytes();	 Catch:{ IOException -> 0x023e }
            r0 = r22;
            r8.write(r0);	 Catch:{ IOException -> 0x023e }
            r22 = 10;
            r0 = r22;
            r8.write(r0);	 Catch:{ IOException -> 0x023e }
            r5.finishWrite(r8);	 Catch:{ IOException -> 0x023e }
            goto L_0x0005;
        L_0x023e:
            r7 = move-exception;
            r4 = r5;
        L_0x0240:
            if (r8 == 0) goto L_0x0245;
        L_0x0242:
            r4.failWrite(r8);
        L_0x0245:
            r22 = "TaskPersister";
            r23 = new java.lang.StringBuilder;
            r23.<init>();
            r24 = "Unable to open ";
            r23 = r23.append(r24);
            r0 = r23;
            r23 = r0.append(r4);
            r24 = " for persisting. ";
            r23 = r23.append(r24);
            r0 = r23;
            r23 = r0.append(r7);
            r23 = r23.toString();
            android.util.Slog.e(r22, r23);
            goto L_0x0005;
        L_0x026d:
            r22 = move-exception;
            monitor-exit(r23);	 Catch:{ all -> 0x026d }
            throw r22;
        L_0x0270:
            r7 = move-exception;
            goto L_0x0240;
        L_0x0272:
            r22 = move-exception;
            goto L_0x01eb;
        L_0x0275:
            r22 = move-exception;
            goto L_0x01eb;
        L_0x0278:
            r22 = move-exception;
            r10 = r11;
            goto L_0x01b8;
        L_0x027c:
            r7 = move-exception;
            r10 = r11;
            goto L_0x0194;
        L_0x0280:
            r22 = move-exception;
            goto L_0x0159;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.TaskPersister.LazyTaskWriterThread.run():void");
        }
    }

    private static class OtherDeviceTask implements Comparable<OtherDeviceTask> {
        final int mAffiliatedTaskId;
        final ComponentName mComponentName;
        final File mFile;
        final ArraySet<String> mLaunchPackages;
        final int mTaskId;

        private OtherDeviceTask(File file, ComponentName componentName, int taskId, int affiliatedTaskId, ArraySet<String> launchPackages) {
            this.mFile = file;
            this.mComponentName = componentName;
            this.mTaskId = taskId;
            if (affiliatedTaskId != -1) {
                taskId = affiliatedTaskId;
            }
            this.mAffiliatedTaskId = taskId;
            this.mLaunchPackages = launchPackages;
        }

        public int compareTo(OtherDeviceTask another) {
            return this.mTaskId - another.mTaskId;
        }

        static OtherDeviceTask createFromFile(File file) {
            String str;
            Reader reader;
            Exception e;
            Throwable th;
            Exception e2;
            if (file == null || !file.exists()) {
                return null;
            }
            BufferedReader bufferedReader = null;
            try {
                Reader bufferedReader2 = new BufferedReader(new FileReader(file));
                try {
                    int event;
                    XmlPullParser in = Xml.newPullParser();
                    in.setInput(bufferedReader2);
                    do {
                        event = in.next();
                        if (event == 1) {
                            break;
                        }
                    } while (event != 2);
                    if (event == 2) {
                        String name = in.getName();
                        if (TaskPersister.TAG_TASK.equals(name)) {
                            int j;
                            int outerDepth = in.getDepth();
                            ComponentName componentName = null;
                            int taskId = -1;
                            int taskAffiliation = -1;
                            for (j = in.getAttributeCount() - 1; j >= 0; j--) {
                                String attrName = in.getAttributeName(j);
                                String attrValue = in.getAttributeValue(j);
                                if ("real_activity".equals(attrName)) {
                                    componentName = ComponentName.unflattenFromString(attrValue);
                                } else if ("task_id".equals(attrName)) {
                                    taskId = Integer.valueOf(attrValue).intValue();
                                } else if ("task_affiliation".equals(attrName)) {
                                    taskAffiliation = Integer.valueOf(attrValue).intValue();
                                }
                            }
                            if (componentName == null || taskId == -1) {
                                IoUtils.closeQuietly(bufferedReader2);
                                return null;
                            }
                            ArraySet<String> launchPackages = null;
                            while (true) {
                                event = in.next();
                                if (event == 1 || (event == 3 && in.getDepth() >= outerDepth)) {
                                    break;
                                } else if (event == 2) {
                                    if ("activity".equals(in.getName())) {
                                        for (j = in.getAttributeCount() - 1; j >= 0; j--) {
                                            if ("launched_from_package".equals(in.getAttributeName(j))) {
                                                if (launchPackages == null) {
                                                    launchPackages = new ArraySet();
                                                }
                                                launchPackages.add(in.getAttributeValue(j));
                                            }
                                        }
                                    } else {
                                        XmlUtils.skipCurrentTag(in);
                                    }
                                }
                            }
                            OtherDeviceTask otherDeviceTask = new OtherDeviceTask(file, componentName, taskId, taskAffiliation, launchPackages);
                            IoUtils.closeQuietly(bufferedReader2);
                            return otherDeviceTask;
                        }
                        str = " name=";
                        Slog.wtf(TaskPersister.TAG, "createFromFile: Unknown xml event=" + event + r17 + name);
                    } else {
                        Slog.wtf(TaskPersister.TAG, "createFromFile: Unable to find start tag in file=" + file);
                    }
                    IoUtils.closeQuietly(bufferedReader2);
                    reader = bufferedReader2;
                } catch (IOException e3) {
                    e = e3;
                    bufferedReader = bufferedReader2;
                } catch (XmlPullParserException e4) {
                    e = e4;
                    bufferedReader = bufferedReader2;
                } catch (Throwable th2) {
                    th = th2;
                    reader = bufferedReader2;
                }
            } catch (IOException e5) {
                e = e5;
                e2 = e;
                try {
                    str = ". Error ";
                    Slog.wtf(TaskPersister.TAG, "Unable to parse " + file + r17, e2);
                    IoUtils.closeQuietly(bufferedReader);
                    return null;
                } catch (Throwable th3) {
                    th = th3;
                    IoUtils.closeQuietly(bufferedReader);
                    throw th;
                }
            } catch (XmlPullParserException e6) {
                e = e6;
                e2 = e;
                str = ". Error ";
                Slog.wtf(TaskPersister.TAG, "Unable to parse " + file + r17, e2);
                IoUtils.closeQuietly(bufferedReader);
                return null;
            }
            return null;
        }
    }

    private static class TaskWriteQueueItem extends WriteQueueItem {
        final TaskRecord mTask;

        TaskWriteQueueItem(TaskRecord task) {
            super();
            this.mTask = task;
        }
    }

    TaskPersister(File systemDir, ActivityStackSupervisor stackSupervisor) {
        this.mNextWriteTime = 0;
        this.mWriteQueue = new ArrayList();
        this.mOtherDeviceTasksMap = new ArrayMap(10);
        this.mExpiredTasksCleanupTime = JobStatus.NO_LATEST_RUNTIME;
        sTasksDir = new File(systemDir, TASKS_DIRNAME);
        if (!(sTasksDir.exists() || sTasksDir.mkdir())) {
            Slog.e(TAG, "Failure creating tasks directory " + sTasksDir);
        }
        sImagesDir = new File(systemDir, IMAGES_DIRNAME);
        if (!(sImagesDir.exists() || sImagesDir.mkdir())) {
            Slog.e(TAG, "Failure creating images directory " + sImagesDir);
        }
        sRestoredTasksDir = new File(systemDir, RESTORED_TASKS_DIRNAME);
        this.mStackSupervisor = stackSupervisor;
        this.mService = stackSupervisor.mService;
        this.mLazyTaskWriterThread = new LazyTaskWriterThread("LazyTaskWriterThread");
    }

    void startPersisting() {
        this.mLazyTaskWriterThread.start();
    }

    private void removeThumbnails(TaskRecord task) {
        String taskString = Integer.toString(task.taskId);
        for (int queueNdx = this.mWriteQueue.size() - 1; queueNdx >= 0; queueNdx--) {
            WriteQueueItem item = (WriteQueueItem) this.mWriteQueue.get(queueNdx);
            if ((item instanceof ImageWriteQueueItem) && ((ImageWriteQueueItem) item).mFilename.startsWith(taskString)) {
                this.mWriteQueue.remove(queueNdx);
            }
        }
    }

    private void yieldIfQueueTooDeep() {
        boolean stall = DEBUG_RESTORER;
        synchronized (this) {
            if (this.mNextWriteTime == FLUSH_QUEUE) {
                stall = true;
            }
        }
        if (stall) {
            Thread.yield();
        }
    }

    void wakeup(TaskRecord task, boolean flush) {
        synchronized (this) {
            if (task != null) {
                int queueNdx = this.mWriteQueue.size() - 1;
                while (queueNdx >= 0) {
                    WriteQueueItem item = (WriteQueueItem) this.mWriteQueue.get(queueNdx);
                    if ((item instanceof TaskWriteQueueItem) && ((TaskWriteQueueItem) item).mTask == task) {
                        if (!task.inRecents) {
                            removeThumbnails(task);
                        }
                        if (queueNdx < 0 && task.isPersistable) {
                            this.mWriteQueue.add(new TaskWriteQueueItem(task));
                        }
                    } else {
                        queueNdx--;
                    }
                }
                this.mWriteQueue.add(new TaskWriteQueueItem(task));
            } else {
                this.mWriteQueue.add(new WriteQueueItem());
            }
            if (flush || this.mWriteQueue.size() > MAX_WRITE_QUEUE_LENGTH) {
                this.mNextWriteTime = FLUSH_QUEUE;
            } else if (this.mNextWriteTime == 0) {
                this.mNextWriteTime = SystemClock.uptimeMillis() + PRE_TASK_DELAY_MS;
            }
            notifyAll();
        }
        yieldIfQueueTooDeep();
    }

    void flush() {
        synchronized (this) {
            this.mNextWriteTime = FLUSH_QUEUE;
            notifyAll();
            do {
                try {
                    wait();
                } catch (InterruptedException e) {
                }
            } while (this.mNextWriteTime == FLUSH_QUEUE);
        }
    }

    void saveImage(Bitmap image, String filename) {
        synchronized (this) {
            int queueNdx = this.mWriteQueue.size() - 1;
            while (queueNdx >= 0) {
                WriteQueueItem item = (WriteQueueItem) this.mWriteQueue.get(queueNdx);
                if (item instanceof ImageWriteQueueItem) {
                    ImageWriteQueueItem imageWriteQueueItem = (ImageWriteQueueItem) item;
                    if (imageWriteQueueItem.mFilename.equals(filename)) {
                        imageWriteQueueItem.mImage = image;
                        break;
                    }
                }
                queueNdx--;
            }
            if (queueNdx < 0) {
                this.mWriteQueue.add(new ImageWriteQueueItem(filename, image));
            }
            if (this.mWriteQueue.size() > MAX_WRITE_QUEUE_LENGTH) {
                this.mNextWriteTime = FLUSH_QUEUE;
            } else if (this.mNextWriteTime == 0) {
                this.mNextWriteTime = SystemClock.uptimeMillis() + PRE_TASK_DELAY_MS;
            }
            notifyAll();
        }
        yieldIfQueueTooDeep();
    }

    Bitmap getTaskDescriptionIcon(String filename) {
        Bitmap icon = getImageFromWriteQueue(filename);
        return icon != null ? icon : restoreImage(filename);
    }

    Bitmap getImageFromWriteQueue(String filename) {
        Bitmap bitmap;
        synchronized (this) {
            for (int queueNdx = this.mWriteQueue.size() - 1; queueNdx >= 0; queueNdx--) {
                WriteQueueItem item = (WriteQueueItem) this.mWriteQueue.get(queueNdx);
                if (item instanceof ImageWriteQueueItem) {
                    ImageWriteQueueItem imageWriteQueueItem = (ImageWriteQueueItem) item;
                    if (imageWriteQueueItem.mFilename.equals(filename)) {
                        bitmap = imageWriteQueueItem.mImage;
                        break;
                    }
                }
            }
            bitmap = null;
        }
        return bitmap;
    }

    private StringWriter saveToXml(TaskRecord task) throws IOException, XmlPullParserException {
        XmlSerializer xmlSerializer = new FastXmlSerializer();
        StringWriter stringWriter = new StringWriter();
        xmlSerializer.setOutput(stringWriter);
        xmlSerializer.startDocument(null, Boolean.valueOf(true));
        xmlSerializer.startTag(null, TAG_TASK);
        task.saveToXml(xmlSerializer);
        xmlSerializer.endTag(null, TAG_TASK);
        xmlSerializer.endDocument();
        xmlSerializer.flush();
        return stringWriter;
    }

    private String fileToString(File file) {
        String newline = System.lineSeparator();
        try {
            BufferedReader reader = new BufferedReader(new FileReader(file));
            StringBuffer sb = new StringBuffer(((int) file.length()) * 2);
            while (true) {
                String line = reader.readLine();
                if (line != null) {
                    sb.append(line + newline);
                } else {
                    reader.close();
                    return sb.toString();
                }
            }
        } catch (IOException e) {
            Slog.e(TAG, "Couldn't read file " + file.getName());
            return null;
        }
    }

    private TaskRecord taskIdToTask(int taskId, ArrayList<TaskRecord> tasks) {
        if (taskId < 0) {
            return null;
        }
        for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
            TaskRecord task = (TaskRecord) tasks.get(taskNdx);
            if (task.taskId == taskId) {
                return task;
            }
        }
        Slog.e(TAG, "Restore affiliation error looking for taskId=" + taskId);
        return null;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    java.util.ArrayList<com.android.server.am.TaskRecord> restoreTasksLocked() {
        /*
        r21 = this;
        r15 = new java.util.ArrayList;
        r15.<init>();
        r10 = new android.util.ArraySet;
        r10.<init>();
        r17 = sTasksDir;
        r9 = r17.listFiles();
        if (r9 != 0) goto L_0x002d;
    L_0x0012:
        r17 = "TaskPersister";
        r18 = new java.lang.StringBuilder;
        r18.<init>();
        r19 = "Unable to list files from ";
        r18 = r18.append(r19);
        r19 = sTasksDir;
        r18 = r18.append(r19);
        r18 = r18.toString();
        android.util.Slog.e(r17, r18);
    L_0x002c:
        return r15;
    L_0x002d:
        r14 = 0;
    L_0x002e:
        r0 = r9.length;
        r17 = r0;
        r0 = r17;
        if (r14 >= r0) goto L_0x01b2;
    L_0x0035:
        r12 = r9[r14];
        r7 = 0;
        r2 = 0;
        r8 = new java.io.BufferedReader;	 Catch:{ Exception -> 0x0213 }
        r17 = new java.io.FileReader;	 Catch:{ Exception -> 0x0213 }
        r0 = r17;
        r0.<init>(r12);	 Catch:{ Exception -> 0x0213 }
        r0 = r17;
        r8.<init>(r0);	 Catch:{ Exception -> 0x0213 }
        r5 = android.util.Xml.newPullParser();	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r5.setInput(r8);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
    L_0x004e:
        r4 = r5.next();	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r17 = 1;
        r0 = r17;
        if (r4 == r0) goto L_0x018b;
    L_0x0058:
        r17 = 3;
        r0 = r17;
        if (r4 == r0) goto L_0x018b;
    L_0x005e:
        r6 = r5.getName();	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r17 = 2;
        r0 = r17;
        if (r4 != r0) goto L_0x009f;
    L_0x0068:
        r17 = "task";
        r0 = r17;
        r17 = r0.equals(r6);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        if (r17 == 0) goto L_0x0163;
    L_0x0072:
        r0 = r21;
        r0 = r0.mStackSupervisor;	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r17 = r0;
        r0 = r17;
        r11 = com.android.server.am.TaskRecord.restoreFromXml(r5, r0);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        if (r11 == 0) goto L_0x0110;
    L_0x0080:
        r17 = 1;
        r0 = r17;
        r11.isPersistable = r0;	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r15.add(r11);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r13 = r11.taskId;	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r17 = java.lang.Integer.valueOf(r13);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r0 = r17;
        r10.add(r0);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r0 = r21;
        r0 = r0.mStackSupervisor;	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r17 = r0;
        r0 = r17;
        r0.setNextTaskId(r13);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
    L_0x009f:
        com.android.internal.util.XmlUtils.skipCurrentTag(r5);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        goto L_0x004e;
    L_0x00a3:
        r3 = move-exception;
        r7 = r8;
    L_0x00a5:
        r17 = "TaskPersister";
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0210 }
        r18.<init>();	 Catch:{ all -> 0x0210 }
        r19 = "Unable to parse ";
        r18 = r18.append(r19);	 Catch:{ all -> 0x0210 }
        r0 = r18;
        r18 = r0.append(r12);	 Catch:{ all -> 0x0210 }
        r19 = ". Error ";
        r18 = r18.append(r19);	 Catch:{ all -> 0x0210 }
        r18 = r18.toString();	 Catch:{ all -> 0x0210 }
        r0 = r17;
        r1 = r18;
        android.util.Slog.wtf(r0, r1, r3);	 Catch:{ all -> 0x0210 }
        r17 = "TaskPersister";
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0210 }
        r18.<init>();	 Catch:{ all -> 0x0210 }
        r19 = "Failing file: ";
        r18 = r18.append(r19);	 Catch:{ all -> 0x0210 }
        r0 = r21;
        r19 = r0.fileToString(r12);	 Catch:{ all -> 0x0210 }
        r18 = r18.append(r19);	 Catch:{ all -> 0x0210 }
        r18 = r18.toString();	 Catch:{ all -> 0x0210 }
        android.util.Slog.e(r17, r18);	 Catch:{ all -> 0x0210 }
        r2 = 1;
        libcore.io.IoUtils.closeQuietly(r7);
        if (r2 == 0) goto L_0x010c;
    L_0x00ed:
        r17 = "TaskPersister";
        r18 = new java.lang.StringBuilder;
        r18.<init>();
        r19 = "Deleting file=";
        r18 = r18.append(r19);
        r19 = r12.getName();
        r18 = r18.append(r19);
        r18 = r18.toString();
        android.util.Slog.d(r17, r18);
        r12.delete();
    L_0x010c:
        r14 = r14 + 1;
        goto L_0x002e;
    L_0x0110:
        r17 = "TaskPersister";
        r18 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r18.<init>();	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r19 = "Unable to restore taskFile=";
        r18 = r18.append(r19);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r0 = r18;
        r18 = r0.append(r12);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r19 = ": ";
        r18 = r18.append(r19);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r0 = r21;
        r19 = r0.fileToString(r12);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r18 = r18.append(r19);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r18 = r18.toString();	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        android.util.Slog.e(r17, r18);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        goto L_0x009f;
    L_0x013c:
        r17 = move-exception;
        r7 = r8;
    L_0x013e:
        libcore.io.IoUtils.closeQuietly(r7);
        if (r2 == 0) goto L_0x0162;
    L_0x0143:
        r18 = "TaskPersister";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "Deleting file=";
        r19 = r19.append(r20);
        r20 = r12.getName();
        r19 = r19.append(r20);
        r19 = r19.toString();
        android.util.Slog.d(r18, r19);
        r12.delete();
    L_0x0162:
        throw r17;
    L_0x0163:
        r17 = "TaskPersister";
        r18 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r18.<init>();	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r19 = "restoreTasksLocked Unknown xml event=";
        r18 = r18.append(r19);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r0 = r18;
        r18 = r0.append(r4);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r19 = " name=";
        r18 = r18.append(r19);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r0 = r18;
        r18 = r0.append(r6);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        r18 = r18.toString();	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        android.util.Slog.wtf(r17, r18);	 Catch:{ Exception -> 0x00a3, all -> 0x013c }
        goto L_0x009f;
    L_0x018b:
        libcore.io.IoUtils.closeQuietly(r8);
        if (r2 == 0) goto L_0x0216;
    L_0x0190:
        r17 = "TaskPersister";
        r18 = new java.lang.StringBuilder;
        r18.<init>();
        r19 = "Deleting file=";
        r18 = r18.append(r19);
        r19 = r12.getName();
        r18 = r18.append(r19);
        r18 = r18.toString();
        android.util.Slog.d(r17, r18);
        r12.delete();
        r7 = r8;
        goto L_0x010c;
    L_0x01b2:
        r0 = r21;
        r0.removeObsoleteFiles(r10);
        r17 = r15.size();
        r14 = r17 + -1;
    L_0x01bd:
        if (r14 < 0) goto L_0x01ea;
    L_0x01bf:
        r11 = r15.get(r14);
        r11 = (com.android.server.am.TaskRecord) r11;
        r0 = r11.mPrevAffiliateTaskId;
        r17 = r0;
        r0 = r21;
        r1 = r17;
        r17 = r0.taskIdToTask(r1, r15);
        r0 = r17;
        r11.setPrevAffiliate(r0);
        r0 = r11.mNextAffiliateTaskId;
        r17 = r0;
        r0 = r21;
        r1 = r17;
        r17 = r0.taskIdToTask(r1, r15);
        r0 = r17;
        r11.setNextAffiliate(r0);
        r14 = r14 + -1;
        goto L_0x01bd;
    L_0x01ea:
        r17 = r15.size();
        r0 = r17;
        r0 = new com.android.server.am.TaskRecord[r0];
        r16 = r0;
        r15.toArray(r16);
        r17 = new com.android.server.am.TaskPersister$1;
        r0 = r17;
        r1 = r21;
        r0.<init>();
        java.util.Arrays.sort(r16, r17);
        r15 = new java.util.ArrayList;
        r17 = java.util.Arrays.asList(r16);
        r0 = r17;
        r15.<init>(r0);
        goto L_0x002c;
    L_0x0210:
        r17 = move-exception;
        goto L_0x013e;
    L_0x0213:
        r3 = move-exception;
        goto L_0x00a5;
    L_0x0216:
        r7 = r8;
        goto L_0x010c;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.TaskPersister.restoreTasksLocked():java.util.ArrayList<com.android.server.am.TaskRecord>");
    }

    private static void removeObsoleteFiles(ArraySet<Integer> persistentTaskIds, File[] files) {
        if (files == null) {
            Slog.e(TAG, "File error accessing recents directory (too many files open?).");
            return;
        }
        for (File file : files) {
            String filename = file.getName();
            int taskIdEnd = filename.indexOf(95);
            if (taskIdEnd > 0) {
                try {
                    if (!persistentTaskIds.contains(Integer.valueOf(Integer.valueOf(filename.substring(0, taskIdEnd)).intValue()))) {
                        Slog.d(TAG, "removeObsoleteFile: deleting file=" + file.getName());
                        file.delete();
                    }
                } catch (Exception e) {
                    Slog.wtf(TAG, "removeObsoleteFile: Can't parse file=" + file.getName());
                    file.delete();
                }
            }
        }
    }

    private void removeObsoleteFiles(ArraySet<Integer> persistentTaskIds) {
        removeObsoleteFiles(persistentTaskIds, sTasksDir.listFiles());
        removeObsoleteFiles(persistentTaskIds, sImagesDir.listFiles());
    }

    static Bitmap restoreImage(String filename) {
        return BitmapFactory.decodeFile(sImagesDir + File.separator + filename);
    }

    void restoreTasksFromOtherDeviceLocked() {
        readOtherDeviceTasksFromDisk();
        addOtherDeviceTasksToRecentsLocked();
    }

    private void readOtherDeviceTasksFromDisk() {
        synchronized (this.mOtherDeviceTasksMap) {
            this.mOtherDeviceTasksMap.clear();
            this.mExpiredTasksCleanupTime = JobStatus.NO_LATEST_RUNTIME;
            if (sRestoredTasksDir.exists()) {
                File[] taskFiles = sRestoredTasksDir.listFiles();
                if (taskFiles != null) {
                    long earliestMtime = System.currentTimeMillis();
                    SparseArray<List<OtherDeviceTask>> tasksByAffiliateIds = new SparseArray(taskFiles.length);
                    int i = 0;
                    while (true) {
                        int length = taskFiles.length;
                        if (i >= r0) {
                            break;
                        }
                        File taskFile = taskFiles[i];
                        OtherDeviceTask task = OtherDeviceTask.createFromFile(taskFile);
                        if (task == null) {
                            taskFile.delete();
                        } else {
                            List<OtherDeviceTask> tasks = (List) tasksByAffiliateIds.get(task.mAffiliatedTaskId);
                            if (tasks == null) {
                                tasks = new ArrayList();
                                tasksByAffiliateIds.put(task.mAffiliatedTaskId, tasks);
                            }
                            tasks.add(task);
                            long taskMtime = taskFile.lastModified();
                            if (earliestMtime > taskMtime) {
                                earliestMtime = taskMtime;
                            }
                        }
                        i++;
                    }
                    if (tasksByAffiliateIds.size() > 0) {
                        for (i = 0; i < tasksByAffiliateIds.size(); i++) {
                            List<OtherDeviceTask> chain = (List) tasksByAffiliateIds.valueAt(i);
                            Collections.sort(chain);
                            String packageName = ((OtherDeviceTask) chain.get(chain.size() - 1)).mComponentName.getPackageName();
                            List<List<OtherDeviceTask>> chains = (List) this.mOtherDeviceTasksMap.get(packageName);
                            if (chains == null) {
                                chains = new ArrayList();
                                this.mOtherDeviceTasksMap.put(packageName, chains);
                            }
                            chains.add(chain);
                        }
                        this.mExpiredTasksCleanupTime = MAX_INSTALL_WAIT_TIME + earliestMtime;
                    }
                    return;
                }
            }
        }
    }

    private void removeExpiredTasksIfNeeded() {
        synchronized (this.mOtherDeviceTasksMap) {
            long now = System.currentTimeMillis();
            boolean noMoreTasks = this.mOtherDeviceTasksMap.isEmpty();
            if (!noMoreTasks) {
                if (now >= this.mExpiredTasksCleanupTime) {
                    long earliestNonExpiredMtime = now;
                    this.mExpiredTasksCleanupTime = JobStatus.NO_LATEST_RUNTIME;
                    for (int i = this.mOtherDeviceTasksMap.size() - 1; i >= 0; i--) {
                        List<List<OtherDeviceTask>> chains = (List) this.mOtherDeviceTasksMap.valueAt(i);
                        for (int j = chains.size() - 1; j >= 0; j--) {
                            int k;
                            List<OtherDeviceTask> chain = (List) chains.get(j);
                            boolean removeChain = true;
                            for (k = chain.size() - 1; k >= 0; k--) {
                                long taskLastModified = ((OtherDeviceTask) chain.get(k)).mFile.lastModified();
                                if (MAX_INSTALL_WAIT_TIME + taskLastModified > now) {
                                    if (earliestNonExpiredMtime > taskLastModified) {
                                        earliestNonExpiredMtime = taskLastModified;
                                    }
                                    removeChain = DEBUG_RESTORER;
                                }
                            }
                            if (removeChain) {
                                for (k = chain.size() - 1; k >= 0; k--) {
                                    ((OtherDeviceTask) chain.get(k)).mFile.delete();
                                }
                                chains.remove(j);
                            }
                        }
                        if (chains.isEmpty()) {
                            String packageName = (String) this.mOtherDeviceTasksMap.keyAt(i);
                            this.mOtherDeviceTasksMap.removeAt(i);
                        }
                    }
                    if (this.mOtherDeviceTasksMap.isEmpty()) {
                        this.mPackageUidMap = null;
                    } else {
                        this.mExpiredTasksCleanupTime = MAX_INSTALL_WAIT_TIME + earliestNonExpiredMtime;
                    }
                    return;
                }
            }
            if (noMoreTasks && this.mPackageUidMap != null) {
                this.mPackageUidMap = null;
            }
        }
    }

    void removeFromPackageCache(String packageName) {
        synchronized (this.mOtherDeviceTasksMap) {
            if (this.mPackageUidMap != null) {
                this.mPackageUidMap.remove(packageName);
            }
        }
    }

    private void addOtherDeviceTasksToRecentsLocked() {
        synchronized (this.mOtherDeviceTasksMap) {
            for (int i = this.mOtherDeviceTasksMap.size() - 1; i >= 0; i--) {
                addOtherDeviceTasksToRecentsLocked((String) this.mOtherDeviceTasksMap.keyAt(i));
            }
        }
    }

    void addOtherDeviceTasksToRecentsLocked(String packageName) {
        synchronized (this.mOtherDeviceTasksMap) {
            List<List<OtherDeviceTask>> chains = (List) this.mOtherDeviceTasksMap.get(packageName);
            if (chains == null) {
                return;
            }
            for (int i = chains.size() - 1; i >= 0; i--) {
                List<OtherDeviceTask> chain = (List) chains.get(i);
                if (canAddOtherDeviceTaskChain(chain)) {
                    int j;
                    List<TaskRecord> tasks = new ArrayList();
                    TaskRecord prev = null;
                    for (j = chain.size() - 1; j >= 0; j--) {
                        TaskRecord task = createTaskRecordLocked((OtherDeviceTask) chain.get(j));
                        if (task == null) {
                            break;
                        }
                        if (prev == null) {
                            task.mPrevAffiliate = null;
                            task.mPrevAffiliateTaskId = -1;
                            task.mAffiliatedTaskId = task.taskId;
                        } else {
                            prev.mNextAffiliate = task;
                            prev.mNextAffiliateTaskId = task.taskId;
                            task.mAffiliatedTaskId = prev.mAffiliatedTaskId;
                            task.mPrevAffiliate = prev;
                            task.mPrevAffiliateTaskId = prev.taskId;
                        }
                        prev = task;
                        tasks.add(0, task);
                    }
                    if (tasks.size() == chain.size() && ActivityManager.getMaxRecentTasksStatic() - this.mService.mRecentTasks.size() >= tasks.size()) {
                        this.mService.mRecentTasks.addAll(this.mService.mRecentTasks.size(), tasks);
                        for (int k = tasks.size() - 1; k >= 0; k--) {
                            wakeup((TaskRecord) tasks.get(k), DEBUG_RESTORER);
                        }
                    }
                    for (j = chain.size() - 1; j >= 0; j--) {
                        ((OtherDeviceTask) chain.get(j)).mFile.delete();
                    }
                    chains.remove(i);
                    if (chains.isEmpty()) {
                        this.mOtherDeviceTasksMap.remove(packageName);
                    }
                }
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private com.android.server.am.TaskRecord createTaskRecordLocked(com.android.server.am.TaskPersister.OtherDeviceTask r15) {
        /*
        r14 = this;
        r3 = r15.mFile;
        r7 = 0;
        r9 = 0;
        r8 = new java.io.BufferedReader;	 Catch:{ Exception -> 0x017e }
        r11 = new java.io.FileReader;	 Catch:{ Exception -> 0x017e }
        r11.<init>(r3);	 Catch:{ Exception -> 0x017e }
        r8.<init>(r11);	 Catch:{ Exception -> 0x017e }
        r5 = android.util.Xml.newPullParser();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r5.setInput(r8);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
    L_0x0015:
        r2 = r5.next();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = 1;
        if (r2 == r11) goto L_0x0177;
    L_0x001c:
        r11 = 3;
        if (r2 == r11) goto L_0x0177;
    L_0x001f:
        r6 = r5.getName();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = 2;
        if (r2 != r11) goto L_0x0107;
    L_0x0026:
        r11 = "task";
        r11 = r11.equals(r6);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        if (r11 == 0) goto L_0x014e;
    L_0x002e:
        r11 = r14.mStackSupervisor;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r14.mStackSupervisor;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.getNextTaskId();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r9 = com.android.server.am.TaskRecord.restoreFromXml(r5, r11, r12);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        if (r9 == 0) goto L_0x00e1;
    L_0x003c:
        r11 = 1;
        r9.isPersistable = r11;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = 1;
        r9.inRecents = r11;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = 0;
        r9.userId = r11;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = -1;
        r9.mAffiliatedTaskId = r11;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = -1;
        r9.mPrevAffiliateTaskId = r11;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = -1;
        r9.mNextAffiliateTaskId = r11;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = r14.mPackageUidMap;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r9.realActivity;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.getPackageName();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r10 = r11.get(r12);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r10 = (java.lang.Integer) r10;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        if (r10 != 0) goto L_0x0088;
    L_0x005e:
        r11 = "TaskPersister";
        r12 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12.<init>();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = "Can't find uid for task=";
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.append(r9);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = " in mPackageUidMap=";
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = r14.mPackageUidMap;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.toString();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        android.util.Slog.wtf(r11, r12);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = 0;
        libcore.io.IoUtils.closeQuietly(r8);
        r7 = r8;
    L_0x0087:
        return r11;
    L_0x0088:
        r11 = r10.intValue();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r9.mCallingUid = r11;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r9.effectiveUid = r11;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = r9.mActivities;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = r11.size();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r4 = r11 + -1;
    L_0x0098:
        if (r4 < 0) goto L_0x0107;
    L_0x009a:
        r11 = r9.mActivities;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r0 = r11.get(r4);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r0 = (com.android.server.am.ActivityRecord) r0;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = r14.mPackageUidMap;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r0.launchedFromPackage;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r10 = r11.get(r12);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r10 = (java.lang.Integer) r10;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        if (r10 != 0) goto L_0x00d8;
    L_0x00ae:
        r11 = "TaskPersister";
        r12 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12.<init>();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = "Can't find uid for activity=";
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.append(r0);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = " in mPackageUidMap=";
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = r14.mPackageUidMap;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.toString();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        android.util.Slog.wtf(r11, r12);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r11 = 0;
        libcore.io.IoUtils.closeQuietly(r8);
        r7 = r8;
        goto L_0x0087;
    L_0x00d8:
        r11 = r10.intValue();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r0.launchedFromUid = r11;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r4 = r4 + -1;
        goto L_0x0098;
    L_0x00e1:
        r11 = "TaskPersister";
        r12 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12.<init>();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = "Unable to create task for backed-up file=";
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.append(r3);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = ": ";
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = r14.fileToString(r3);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.toString();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        android.util.Slog.e(r11, r12);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
    L_0x0107:
        com.android.internal.util.XmlUtils.skipCurrentTag(r5);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        goto L_0x0015;
    L_0x010c:
        r1 = move-exception;
        r7 = r8;
    L_0x010e:
        r11 = "TaskPersister";
        r12 = new java.lang.StringBuilder;	 Catch:{ all -> 0x017c }
        r12.<init>();	 Catch:{ all -> 0x017c }
        r13 = "Unable to parse ";
        r12 = r12.append(r13);	 Catch:{ all -> 0x017c }
        r12 = r12.append(r3);	 Catch:{ all -> 0x017c }
        r13 = ". Error ";
        r12 = r12.append(r13);	 Catch:{ all -> 0x017c }
        r12 = r12.toString();	 Catch:{ all -> 0x017c }
        android.util.Slog.wtf(r11, r12, r1);	 Catch:{ all -> 0x017c }
        r11 = "TaskPersister";
        r12 = new java.lang.StringBuilder;	 Catch:{ all -> 0x017c }
        r12.<init>();	 Catch:{ all -> 0x017c }
        r13 = "Failing file: ";
        r12 = r12.append(r13);	 Catch:{ all -> 0x017c }
        r13 = r14.fileToString(r3);	 Catch:{ all -> 0x017c }
        r12 = r12.append(r13);	 Catch:{ all -> 0x017c }
        r12 = r12.toString();	 Catch:{ all -> 0x017c }
        android.util.Slog.e(r11, r12);	 Catch:{ all -> 0x017c }
        libcore.io.IoUtils.closeQuietly(r7);
    L_0x014b:
        r11 = r9;
        goto L_0x0087;
    L_0x014e:
        r11 = "TaskPersister";
        r12 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12.<init>();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = "createTaskRecordLocked Unknown xml event=";
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.append(r2);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r13 = " name=";
        r12 = r12.append(r13);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.append(r6);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        r12 = r12.toString();	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        android.util.Slog.wtf(r11, r12);	 Catch:{ Exception -> 0x010c, all -> 0x0171 }
        goto L_0x0107;
    L_0x0171:
        r11 = move-exception;
        r7 = r8;
    L_0x0173:
        libcore.io.IoUtils.closeQuietly(r7);
        throw r11;
    L_0x0177:
        libcore.io.IoUtils.closeQuietly(r8);
        r7 = r8;
        goto L_0x014b;
    L_0x017c:
        r11 = move-exception;
        goto L_0x0173;
    L_0x017e:
        r1 = move-exception;
        goto L_0x010e;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.TaskPersister.createTaskRecordLocked(com.android.server.am.TaskPersister$OtherDeviceTask):com.android.server.am.TaskRecord");
    }

    private boolean canAddOtherDeviceTaskChain(List<OtherDeviceTask> chain) {
        ArraySet<ComponentName> validComponents = new ArraySet();
        IPackageManager pm = AppGlobals.getPackageManager();
        for (int i = 0; i < chain.size(); i++) {
            OtherDeviceTask task = (OtherDeviceTask) chain.get(i);
            if (!task.mFile.exists()) {
                return DEBUG_RESTORER;
            }
            if (!isPackageInstalled(task.mComponentName.getPackageName())) {
                return DEBUG_RESTORER;
            }
            if (task.mLaunchPackages != null) {
                for (int j = task.mLaunchPackages.size() - 1; j >= 0; j--) {
                    if (!isPackageInstalled((String) task.mLaunchPackages.valueAt(j))) {
                        return DEBUG_RESTORER;
                    }
                }
            }
            if (!validComponents.contains(task.mComponentName)) {
                try {
                    if (pm.getActivityInfo(task.mComponentName, 0, 0) == null) {
                        return DEBUG_RESTORER;
                    }
                    validComponents.add(task.mComponentName);
                } catch (RemoteException e) {
                    return DEBUG_RESTORER;
                }
            }
        }
        return true;
    }

    private boolean isPackageInstalled(String packageName) {
        if (this.mPackageUidMap != null && this.mPackageUidMap.containsKey(packageName)) {
            return true;
        }
        try {
            int uid = AppGlobals.getPackageManager().getPackageUid(packageName, 0);
            if (uid == -1) {
                return DEBUG_RESTORER;
            }
            if (this.mPackageUidMap == null) {
                this.mPackageUidMap = new ArrayMap();
            }
            this.mPackageUidMap.put(packageName, Integer.valueOf(uid));
            return true;
        } catch (RemoteException e) {
            return DEBUG_RESTORER;
        }
    }
}
