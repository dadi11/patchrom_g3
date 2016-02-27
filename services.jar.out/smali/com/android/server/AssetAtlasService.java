package com.android.server;

import android.content.Context;
import android.content.pm.PackageManager.NameNotFoundException;
import android.graphics.Atlas;
import android.graphics.Atlas.Entry;
import android.graphics.Atlas.Type;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable.ConstantState;
import android.os.Environment;
import android.os.Process;
import android.os.RemoteException;
import android.os.SystemProperties;
import android.util.Log;
import android.util.LongSparseArray;
import android.view.GraphicBuffer;
import android.view.IAssetAtlas.Stub;
import com.android.server.voiceinteraction.SoundTriggerHelper;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;

public class AssetAtlasService extends Stub {
    public static final String ASSET_ATLAS_SERVICE = "assetatlas";
    private static final int ATLAS_MAP_ENTRY_FIELD_COUNT = 4;
    private static final boolean DEBUG_ATLAS = true;
    private static final boolean DEBUG_ATLAS_TEXTURE = false;
    private static final int GRAPHIC_BUFFER_USAGE = 256;
    private static final String LOG_TAG = "AssetAtlas";
    private static final int MAX_SIZE = 2048;
    private static final int MIN_SIZE = 768;
    private static final float PACKING_THRESHOLD = 0.8f;
    private static final int STEP = 64;
    private long[] mAtlasMap;
    private final AtomicBoolean mAtlasReady;
    private GraphicBuffer mBuffer;
    private final Context mContext;
    private final String mVersionName;

    /* renamed from: com.android.server.AssetAtlasService.1 */
    class C00051 implements Comparator<Bitmap> {
        C00051() {
        }

        public int compare(Bitmap b1, Bitmap b2) {
            if (b1.getWidth() == b2.getWidth()) {
                return b2.getHeight() - b1.getHeight();
            }
            return b2.getWidth() - b1.getWidth();
        }
    }

    /* renamed from: com.android.server.AssetAtlasService.2 */
    static class C00062 implements Comparator<WorkerResult> {
        C00062() {
        }

        public int compare(WorkerResult r1, WorkerResult r2) {
            int delta = r2.count - r1.count;
            return delta != 0 ? delta : (r1.width * r1.height) - (r2.width * r2.height);
        }
    }

    private static class ComputeWorker implements Runnable {
        private final List<Bitmap> mBitmaps;
        private final int mEnd;
        private final List<WorkerResult> mResults;
        private final CountDownLatch mSignal;
        private final int mStart;
        private final int mStep;
        private final int mThreshold;

        ComputeWorker(int start, int end, int step, List<Bitmap> bitmaps, int pixelCount, List<WorkerResult> results, CountDownLatch signal) {
            this.mStart = start;
            this.mEnd = end;
            this.mStep = step;
            this.mBitmaps = bitmaps;
            this.mResults = results;
            this.mSignal = signal;
            int threshold = (int) (((float) pixelCount) * AssetAtlasService.PACKING_THRESHOLD);
            while (threshold > 4194304) {
                threshold >>= 1;
            }
            this.mThreshold = threshold;
        }

        public void run() {
            Log.d(AssetAtlasService.LOG_TAG, "Running " + Thread.currentThread().getName());
            Entry entry = new Entry();
            for (Type type : Type.values()) {
                int width = this.mStart;
                while (width < this.mEnd) {
                    for (int height = AssetAtlasService.MIN_SIZE; height < AssetAtlasService.MAX_SIZE; height += AssetAtlasService.STEP) {
                        if (width * height > this.mThreshold) {
                            int count = packBitmaps(type, width, height, entry);
                            if (count > 0) {
                                this.mResults.add(new WorkerResult(type, width, height, count));
                                if (count == this.mBitmaps.size()) {
                                    break;
                                }
                            } else {
                                continue;
                            }
                        }
                    }
                    width += this.mStep;
                }
            }
            if (this.mSignal != null) {
                this.mSignal.countDown();
            }
        }

        private int packBitmaps(Type type, int width, int height, Entry entry) {
            int total = 0;
            Atlas atlas = new Atlas(type, width, height);
            int count = this.mBitmaps.size();
            for (int i = 0; i < count; i++) {
                Bitmap bitmap = (Bitmap) this.mBitmaps.get(i);
                if (atlas.pack(bitmap.getWidth(), bitmap.getHeight(), entry) != null) {
                    total++;
                }
            }
            return total;
        }
    }

    private static class Configuration {
        final int count;
        final int flags;
        final int height;
        final Type type;
        final int width;

        Configuration(Type type, int width, int height, int count) {
            this(type, width, height, count, 2);
        }

        Configuration(Type type, int width, int height, int count, int flags) {
            this.type = type;
            this.width = width;
            this.height = height;
            this.count = count;
            this.flags = flags;
        }

        public String toString() {
            return this.type.toString() + " (" + this.width + "x" + this.height + ") flags=0x" + Integer.toHexString(this.flags) + " count=" + this.count;
        }
    }

    private class Renderer implements Runnable {
        private Bitmap mAtlasBitmap;
        private final ArrayList<Bitmap> mBitmaps;
        private long mNativeBitmap;
        private final int mPixelCount;

        Renderer(ArrayList<Bitmap> bitmaps, int pixelCount) {
            this.mBitmaps = bitmaps;
            this.mPixelCount = pixelCount;
        }

        public void run() {
            Configuration config = AssetAtlasService.this.chooseConfiguration(this.mBitmaps, this.mPixelCount, AssetAtlasService.this.mVersionName);
            Log.d(AssetAtlasService.LOG_TAG, "Loaded configuration: " + config);
            if (config != null) {
                AssetAtlasService.this.mBuffer = GraphicBuffer.create(config.width, config.height, 1, AssetAtlasService.GRAPHIC_BUFFER_USAGE);
                if (AssetAtlasService.this.mBuffer != null) {
                    if (renderAtlas(AssetAtlasService.this.mBuffer, new Atlas(config.type, config.width, config.height, config.flags), config.count)) {
                        AssetAtlasService.this.mAtlasReady.set(AssetAtlasService.DEBUG_ATLAS);
                    }
                }
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private boolean renderAtlas(android.view.GraphicBuffer r28, android.graphics.Atlas r29, int r30) {
            /*
            r27 = this;
            r16 = new android.graphics.Paint;
            r16.<init>();
            r22 = new android.graphics.PorterDuffXfermode;
            r23 = android.graphics.PorterDuff.Mode.SRC;
            r22.<init>(r23);
            r0 = r16;
            r1 = r22;
            r0.setXfermode(r1);
            r22 = r28.getWidth();
            r23 = r28.getHeight();
            r0 = r27;
            r1 = r22;
            r2 = r23;
            r6 = r0.acquireCanvas(r1, r2);
            if (r6 != 0) goto L_0x002a;
        L_0x0027:
            r18 = 0;
        L_0x0029:
            return r18;
        L_0x002a:
            r12 = new android.graphics.Atlas$Entry;
            r12.<init>();
            r0 = r27;
            r0 = com.android.server.AssetAtlasService.this;
            r22 = r0;
            r23 = r30 * 4;
            r0 = r23;
            r0 = new long[r0];
            r23 = r0;
            r22.mAtlasMap = r23;
            r0 = r27;
            r0 = com.android.server.AssetAtlasService.this;
            r22 = r0;
            r4 = r22.mAtlasMap;
            r14 = 0;
            r18 = 0;
            r20 = java.lang.System.nanoTime();	 Catch:{ all -> 0x018f }
            r0 = r27;
            r0 = r0.mBitmaps;	 Catch:{ all -> 0x018f }
            r22 = r0;
            r7 = r22.size();	 Catch:{ all -> 0x018f }
            r13 = 0;
            r15 = r14;
        L_0x005d:
            if (r13 >= r7) goto L_0x0097;
        L_0x005f:
            r0 = r27;
            r0 = r0.mBitmaps;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r0 = r22;
            r5 = r0.get(r13);	 Catch:{ all -> 0x0196 }
            r5 = (android.graphics.Bitmap) r5;	 Catch:{ all -> 0x0196 }
            r22 = r5.getWidth();	 Catch:{ all -> 0x0196 }
            r23 = r5.getHeight();	 Catch:{ all -> 0x0196 }
            r0 = r29;
            r1 = r22;
            r2 = r23;
            r22 = r0.pack(r1, r2, r12);	 Catch:{ all -> 0x0196 }
            if (r22 == 0) goto L_0x0186;
        L_0x0081:
            r0 = r27;
            r0 = com.android.server.AssetAtlasService.this;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r22 = r22.mAtlasMap;	 Catch:{ all -> 0x0196 }
            r0 = r22;
            r0 = r0.length;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r0 = r22;
            if (r15 < r0) goto L_0x010b;
        L_0x0094:
            com.android.server.AssetAtlasService.deleteDataFile();	 Catch:{ all -> 0x0196 }
        L_0x0097:
            r8 = java.lang.System.nanoTime();	 Catch:{ all -> 0x0196 }
            r0 = r27;
            r0 = r0.mNativeBitmap;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r24 = 0;
            r22 = (r22 > r24 ? 1 : (r22 == r24 ? 0 : -1));
            if (r22 == 0) goto L_0x00b5;
        L_0x00a7:
            r0 = r27;
            r0 = r0.mNativeBitmap;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r0 = r28;
            r1 = r22;
            r18 = com.android.server.AssetAtlasService.nUploadAtlas(r0, r1);	 Catch:{ all -> 0x0196 }
        L_0x00b5:
            r10 = java.lang.System.nanoTime();	 Catch:{ all -> 0x0196 }
            r22 = r8 - r20;
            r0 = r22;
            r0 = (float) r0;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r23 = 1148846080; // 0x447a0000 float:1000.0 double:5.676053805E-315;
            r22 = r22 / r23;
            r23 = 1148846080; // 0x447a0000 float:1000.0 double:5.676053805E-315;
            r17 = r22 / r23;
            r22 = r10 - r8;
            r0 = r22;
            r0 = (float) r0;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r23 = 1148846080; // 0x447a0000 float:1000.0 double:5.676053805E-315;
            r22 = r22 / r23;
            r23 = 1148846080; // 0x447a0000 float:1000.0 double:5.676053805E-315;
            r19 = r22 / r23;
            r22 = "AssetAtlas";
            r23 = "Rendered atlas in %.2fms (%.2f+%.2fms)";
            r24 = 3;
            r0 = r24;
            r0 = new java.lang.Object[r0];	 Catch:{ all -> 0x0196 }
            r24 = r0;
            r25 = 0;
            r26 = r17 + r19;
            r26 = java.lang.Float.valueOf(r26);	 Catch:{ all -> 0x0196 }
            r24[r25] = r26;	 Catch:{ all -> 0x0196 }
            r25 = 1;
            r26 = java.lang.Float.valueOf(r17);	 Catch:{ all -> 0x0196 }
            r24[r25] = r26;	 Catch:{ all -> 0x0196 }
            r25 = 2;
            r26 = java.lang.Float.valueOf(r19);	 Catch:{ all -> 0x0196 }
            r24[r25] = r26;	 Catch:{ all -> 0x0196 }
            r23 = java.lang.String.format(r23, r24);	 Catch:{ all -> 0x0196 }
            android.util.Log.d(r22, r23);	 Catch:{ all -> 0x0196 }
            r0 = r27;
            r0.releaseCanvas(r6);
            goto L_0x0029;
        L_0x010b:
            r6.save();	 Catch:{ all -> 0x0196 }
            r0 = r12.x;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r0 = r22;
            r0 = (float) r0;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r0 = r12.y;	 Catch:{ all -> 0x0196 }
            r23 = r0;
            r0 = r23;
            r0 = (float) r0;	 Catch:{ all -> 0x0196 }
            r23 = r0;
            r0 = r22;
            r1 = r23;
            r6.translate(r0, r1);	 Catch:{ all -> 0x0196 }
            r0 = r12.rotated;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            if (r22 == 0) goto L_0x0146;
        L_0x012d:
            r22 = r5.getHeight();	 Catch:{ all -> 0x0196 }
            r0 = r22;
            r0 = (float) r0;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r23 = 0;
            r0 = r22;
            r1 = r23;
            r6.translate(r0, r1);	 Catch:{ all -> 0x0196 }
            r22 = 1119092736; // 0x42b40000 float:90.0 double:5.529052754E-315;
            r0 = r22;
            r6.rotate(r0);	 Catch:{ all -> 0x0196 }
        L_0x0146:
            r22 = 0;
            r23 = 0;
            r24 = 0;
            r0 = r22;
            r1 = r23;
            r2 = r24;
            r6.drawBitmap(r5, r0, r1, r2);	 Catch:{ all -> 0x0196 }
            r6.restore();	 Catch:{ all -> 0x0196 }
            r14 = r15 + 1;
            r0 = r5.mNativeBitmap;	 Catch:{ all -> 0x018f }
            r22 = r0;
            r4[r15] = r22;	 Catch:{ all -> 0x018f }
            r15 = r14 + 1;
            r0 = r12.x;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r0 = r22;
            r0 = (long) r0;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            r4[r14] = r22;	 Catch:{ all -> 0x0196 }
            r14 = r15 + 1;
            r0 = r12.y;	 Catch:{ all -> 0x018f }
            r22 = r0;
            r0 = r22;
            r0 = (long) r0;	 Catch:{ all -> 0x018f }
            r22 = r0;
            r4[r15] = r22;	 Catch:{ all -> 0x018f }
            r15 = r14 + 1;
            r0 = r12.rotated;	 Catch:{ all -> 0x0196 }
            r22 = r0;
            if (r22 == 0) goto L_0x018c;
        L_0x0182:
            r22 = 1;
        L_0x0184:
            r4[r14] = r22;	 Catch:{ all -> 0x0196 }
        L_0x0186:
            r14 = r15;
            r13 = r13 + 1;
            r15 = r14;
            goto L_0x005d;
        L_0x018c:
            r22 = 0;
            goto L_0x0184;
        L_0x018f:
            r22 = move-exception;
        L_0x0190:
            r0 = r27;
            r0.releaseCanvas(r6);
            throw r22;
        L_0x0196:
            r22 = move-exception;
            r14 = r15;
            goto L_0x0190;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.AssetAtlasService.Renderer.renderAtlas(android.view.GraphicBuffer, android.graphics.Atlas, int):boolean");
        }

        private Canvas acquireCanvas(int width, int height) {
            Canvas canvas = new Canvas();
            this.mNativeBitmap = AssetAtlasService.nAcquireAtlasCanvas(canvas, width, height);
            return canvas;
        }

        private void releaseCanvas(Canvas canvas) {
            AssetAtlasService.nReleaseAtlasCanvas(canvas, this.mNativeBitmap);
        }
    }

    private static class WorkerResult {
        int count;
        int height;
        Type type;
        int width;

        WorkerResult(Type type, int width, int height, int count) {
            this.type = type;
            this.width = width;
            this.height = height;
            this.count = count;
        }

        public String toString() {
            return String.format("%s %dx%d", new Object[]{this.type.toString(), Integer.valueOf(this.width), Integer.valueOf(this.height)});
        }
    }

    private static native long nAcquireAtlasCanvas(Canvas canvas, int i, int i2);

    private static native void nReleaseAtlasCanvas(Canvas canvas, long j);

    private static native boolean nUploadAtlas(GraphicBuffer graphicBuffer, long j);

    public AssetAtlasService(Context context) {
        this.mAtlasReady = new AtomicBoolean(DEBUG_ATLAS_TEXTURE);
        this.mContext = context;
        this.mVersionName = queryVersionName(context);
        Collection<Bitmap> bitmaps = new HashSet(300);
        int totalPixelCount = 0;
        LongSparseArray<ConstantState> drawables = context.getResources().getPreloadedDrawables();
        int i = 0;
        while (i < drawables.size()) {
            try {
                totalPixelCount += ((ConstantState) drawables.valueAt(i)).addAtlasableBitmaps(bitmaps);
                i++;
            } catch (Throwable t) {
                Log.e(LOG_TAG, "Failed to fetch preloaded drawable state", t);
            }
        }
        ArrayList<Bitmap> sortedBitmaps = new ArrayList(bitmaps);
        Collections.sort(sortedBitmaps, new C00051());
        new Thread(new Renderer(sortedBitmaps, totalPixelCount)).start();
    }

    private static String queryVersionName(Context context) {
        try {
            return context.getPackageManager().getPackageInfo(context.getPackageName(), 0).versionName;
        } catch (NameNotFoundException e) {
            Log.w(LOG_TAG, "Could not get package info", e);
            return null;
        }
    }

    public void systemRunning() {
    }

    public boolean isCompatible(int ppid) {
        return ppid == Process.myPpid() ? DEBUG_ATLAS : DEBUG_ATLAS_TEXTURE;
    }

    public GraphicBuffer getBuffer() throws RemoteException {
        return this.mAtlasReady.get() ? this.mBuffer : null;
    }

    public long[] getMap() throws RemoteException {
        return this.mAtlasReady.get() ? this.mAtlasMap : null;
    }

    private static Configuration computeBestConfiguration(ArrayList<Bitmap> bitmaps, int pixelCount) {
        Log.d(LOG_TAG, "Computing best atlas configuration...");
        long begin = System.nanoTime();
        List<WorkerResult> results = Collections.synchronizedList(new ArrayList());
        int cpuCount = Runtime.getRuntime().availableProcessors();
        if (cpuCount == 1) {
            new ComputeWorker(MIN_SIZE, MAX_SIZE, STEP, bitmaps, pixelCount, results, null).run();
        } else {
            int start = MIN_SIZE;
            int end = 2048 - ((cpuCount - 1) * STEP);
            int step = cpuCount * STEP;
            CountDownLatch signal = new CountDownLatch(cpuCount);
            int i = 0;
            while (i < cpuCount) {
                int i2 = i + 1;
                new Thread(new ComputeWorker(start, end, step, bitmaps, pixelCount, results, signal), "Atlas Worker #" + r19).start();
                i++;
                start += STEP;
                end += STEP;
            }
            try {
                signal.await(10, TimeUnit.SECONDS);
            } catch (InterruptedException e) {
                Log.w(LOG_TAG, "Could not complete configuration computation");
                return null;
            }
        }
        Collections.sort(results, new C00062());
        float delay = ((((float) (System.nanoTime() - begin)) / 1000.0f) / 1000.0f) / 1000.0f;
        Log.d(LOG_TAG, String.format("Found best atlas configuration in %.2fs", new Object[]{Float.valueOf(delay)}));
        WorkerResult result = (WorkerResult) results.get(0);
        return new Configuration(result.type, result.width, result.height, result.count);
    }

    private static File getDataFile() {
        return new File(new File(Environment.getDataDirectory(), "system"), "framework_atlas.config");
    }

    private static void deleteDataFile() {
        Log.w(LOG_TAG, "Current configuration inconsistent with assets list");
        if (!getDataFile().delete()) {
            Log.w(LOG_TAG, "Could not delete the current configuration");
        }
    }

    private File getFrameworkResourcesFile() {
        return new File(this.mContext.getApplicationInfo().sourceDir);
    }

    private Configuration chooseConfiguration(ArrayList<Bitmap> bitmaps, int pixelCount, String versionName) {
        Configuration config = null;
        File dataFile = getDataFile();
        if (dataFile.exists()) {
            config = readConfiguration(dataFile, versionName);
        }
        if (config == null) {
            config = computeBestConfiguration(bitmaps, pixelCount);
            if (config != null) {
                writeConfiguration(config, dataFile, versionName);
            }
        }
        return config;
    }

    private void writeConfiguration(Configuration config, File file, String versionName) {
        FileNotFoundException e;
        Throwable th;
        IOException e2;
        BufferedWriter writer = null;
        try {
            BufferedWriter writer2 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file)));
            try {
                writer2.write(getBuildIdentifier(versionName));
                writer2.newLine();
                writer2.write(config.type.toString());
                writer2.newLine();
                writer2.write(String.valueOf(config.width));
                writer2.newLine();
                writer2.write(String.valueOf(config.height));
                writer2.newLine();
                writer2.write(String.valueOf(config.count));
                writer2.newLine();
                writer2.write(String.valueOf(config.flags));
                writer2.newLine();
                if (writer2 != null) {
                    try {
                        writer2.close();
                        writer = writer2;
                        return;
                    } catch (IOException e3) {
                        writer = writer2;
                        return;
                    }
                }
            } catch (FileNotFoundException e4) {
                e = e4;
                writer = writer2;
                try {
                    Log.w(LOG_TAG, "Could not write " + file, e);
                    if (writer != null) {
                        try {
                            writer.close();
                        } catch (IOException e5) {
                        }
                    }
                } catch (Throwable th2) {
                    th = th2;
                    if (writer != null) {
                        try {
                            writer.close();
                        } catch (IOException e6) {
                        }
                    }
                    throw th;
                }
            } catch (IOException e7) {
                e2 = e7;
                writer = writer2;
                Log.w(LOG_TAG, "Could not write " + file, e2);
                if (writer != null) {
                    try {
                        writer.close();
                    } catch (IOException e8) {
                    }
                }
            } catch (Throwable th3) {
                th = th3;
                writer = writer2;
                if (writer != null) {
                    writer.close();
                }
                throw th;
            }
        } catch (FileNotFoundException e9) {
            e = e9;
            Log.w(LOG_TAG, "Could not write " + file, e);
            if (writer != null) {
                writer.close();
            }
        } catch (IOException e10) {
            e2 = e10;
            Log.w(LOG_TAG, "Could not write " + file, e2);
            if (writer != null) {
                writer.close();
            }
        }
    }

    private Configuration readConfiguration(File file, String versionName) {
        Configuration config;
        IllegalArgumentException e;
        Throwable th;
        FileNotFoundException e2;
        IOException e3;
        BufferedReader reader = null;
        try {
            BufferedReader reader2 = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
            try {
                if (checkBuildIdentifier(reader2, versionName)) {
                    config = new Configuration(Type.valueOf(reader2.readLine()), readInt(reader2, MIN_SIZE, MAX_SIZE), readInt(reader2, MIN_SIZE, MAX_SIZE), readInt(reader2, 0, Integer.MAX_VALUE), readInt(reader2, SoundTriggerHelper.STATUS_ERROR, Integer.MAX_VALUE));
                } else {
                    config = null;
                }
                if (reader2 != null) {
                    try {
                        reader2.close();
                        reader = reader2;
                        return config;
                    } catch (IOException e4) {
                        reader = reader2;
                        return config;
                    }
                }
                return config;
            } catch (IllegalArgumentException e5) {
                e = e5;
                reader = reader2;
                try {
                    Log.w(LOG_TAG, "Invalid parameter value in " + file, e);
                    if (reader != null) {
                        try {
                            reader.close();
                            return null;
                        } catch (IOException e6) {
                            return null;
                        }
                    }
                    return null;
                } catch (Throwable th2) {
                    th = th2;
                    if (reader != null) {
                        try {
                            reader.close();
                        } catch (IOException e7) {
                        }
                    }
                    throw th;
                }
            } catch (FileNotFoundException e8) {
                e2 = e8;
                reader = reader2;
                Log.w(LOG_TAG, "Could not read " + file, e2);
                if (reader != null) {
                    try {
                        reader.close();
                        return null;
                    } catch (IOException e9) {
                        return null;
                    }
                }
                return null;
            } catch (IOException e10) {
                e3 = e10;
                reader = reader2;
                Log.w(LOG_TAG, "Could not read " + file, e3);
                if (reader != null) {
                    try {
                        reader.close();
                        return null;
                    } catch (IOException e11) {
                        return null;
                    }
                }
                return null;
            } catch (Throwable th3) {
                th = th3;
                reader = reader2;
                if (reader != null) {
                    reader.close();
                }
                throw th;
            }
        } catch (IllegalArgumentException e12) {
            e = e12;
            Log.w(LOG_TAG, "Invalid parameter value in " + file, e);
            if (reader != null) {
                reader.close();
                return null;
            }
            return null;
        } catch (FileNotFoundException e13) {
            e2 = e13;
            Log.w(LOG_TAG, "Could not read " + file, e2);
            if (reader != null) {
                reader.close();
                return null;
            }
            return null;
        } catch (IOException e14) {
            e3 = e14;
            Log.w(LOG_TAG, "Could not read " + file, e3);
            if (reader != null) {
                reader.close();
                return null;
            }
            return null;
        }
    }

    private static int readInt(BufferedReader reader, int min, int max) throws IOException {
        return Math.max(min, Math.min(max, Integer.parseInt(reader.readLine())));
    }

    private boolean checkBuildIdentifier(BufferedReader reader, String versionName) throws IOException {
        return getBuildIdentifier(versionName).equals(reader.readLine());
    }

    private String getBuildIdentifier(String versionName) {
        return SystemProperties.get("ro.build.fingerprint", "") + '/' + versionName + '/' + String.valueOf(getFrameworkResourcesFile().length());
    }
}
