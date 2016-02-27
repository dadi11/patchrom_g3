package com.android.server.display;

import android.content.Context;
import android.os.Handler;
import android.os.Trace;
import android.util.FloatProperty;
import android.util.IntProperty;
import android.util.Slog;
import android.view.Choreographer;
import android.view.Display;
import com.android.server.lights.Light;
import java.io.PrintWriter;

final class DisplayPowerState {
    public static final FloatProperty<DisplayPowerState> COLOR_FADE_LEVEL;
    private static boolean DEBUG = false;
    public static final IntProperty<DisplayPowerState> SCREEN_BRIGHTNESS;
    private static final String TAG = "DisplayPowerState";
    private final Light mBacklight;
    private final DisplayBlanker mBlanker;
    private final Choreographer mChoreographer;
    private Runnable mCleanListener;
    private final ColorFade mColorFade;
    private boolean mColorFadeDrawPending;
    private final Runnable mColorFadeDrawRunnable;
    private float mColorFadeLevel;
    private boolean mColorFadePrepared;
    private boolean mColorFadeReady;
    private final Handler mHandler;
    private final PhotonicModulator mPhotonicModulator;
    private int mScreenBrightness;
    private boolean mScreenReady;
    private int mScreenState;
    private boolean mScreenUpdatePending;
    private final Runnable mScreenUpdateRunnable;

    /* renamed from: com.android.server.display.DisplayPowerState.1 */
    static class C02051 extends FloatProperty<DisplayPowerState> {
        C02051(String x0) {
            super(x0);
        }

        public void setValue(DisplayPowerState object, float value) {
            object.setColorFadeLevel(value);
        }

        public Float get(DisplayPowerState object) {
            return Float.valueOf(object.getColorFadeLevel());
        }
    }

    /* renamed from: com.android.server.display.DisplayPowerState.2 */
    static class C02062 extends IntProperty<DisplayPowerState> {
        C02062(String x0) {
            super(x0);
        }

        public void setValue(DisplayPowerState object, int value) {
            object.setScreenBrightness(value);
        }

        public Integer get(DisplayPowerState object) {
            return Integer.valueOf(object.getScreenBrightness());
        }
    }

    /* renamed from: com.android.server.display.DisplayPowerState.3 */
    class C02073 implements Runnable {
        C02073() {
        }

        public void run() {
            int brightness = 0;
            DisplayPowerState.this.mScreenUpdatePending = false;
            if (DisplayPowerState.this.mScreenState != 1 && DisplayPowerState.this.mColorFadeLevel > 0.0f) {
                brightness = DisplayPowerState.this.mScreenBrightness;
            }
            if (DisplayPowerState.this.mPhotonicModulator.setState(DisplayPowerState.this.mScreenState, brightness)) {
                if (DisplayPowerState.DEBUG) {
                    Slog.d(DisplayPowerState.TAG, "Screen ready");
                }
                DisplayPowerState.this.mScreenReady = true;
                DisplayPowerState.this.invokeCleanListenerIfNeeded();
            } else if (DisplayPowerState.DEBUG) {
                Slog.d(DisplayPowerState.TAG, "Screen not ready");
            }
        }
    }

    /* renamed from: com.android.server.display.DisplayPowerState.4 */
    class C02084 implements Runnable {
        C02084() {
        }

        public void run() {
            DisplayPowerState.this.mColorFadeDrawPending = false;
            if (DisplayPowerState.this.mColorFadePrepared) {
                DisplayPowerState.this.mColorFade.draw(DisplayPowerState.this.mColorFadeLevel);
            }
            DisplayPowerState.this.mColorFadeReady = true;
            DisplayPowerState.this.invokeCleanListenerIfNeeded();
        }
    }

    private final class PhotonicModulator extends Thread {
        private static final int INITIAL_BACKLIGHT = -1;
        private static final int INITIAL_SCREEN_STATE = 1;
        private int mActualBacklight;
        private int mActualState;
        private boolean mChangeInProgress;
        private final Object mLock;
        private int mPendingBacklight;
        private int mPendingState;

        private PhotonicModulator() {
            this.mLock = new Object();
            this.mPendingState = INITIAL_SCREEN_STATE;
            this.mPendingBacklight = INITIAL_BACKLIGHT;
            this.mActualState = INITIAL_SCREEN_STATE;
            this.mActualBacklight = INITIAL_BACKLIGHT;
        }

        public boolean setState(int state, int backlight) {
            boolean z = true;
            synchronized (this.mLock) {
                if (!(state == this.mPendingState && backlight == this.mPendingBacklight)) {
                    if (DisplayPowerState.DEBUG) {
                        Slog.d(DisplayPowerState.TAG, "Requesting new screen state: state=" + Display.stateToString(state) + ", backlight=" + backlight);
                    }
                    this.mPendingState = state;
                    this.mPendingBacklight = backlight;
                    if (!this.mChangeInProgress) {
                        this.mChangeInProgress = true;
                        this.mLock.notifyAll();
                    }
                }
                if (this.mChangeInProgress) {
                    z = false;
                }
            }
            return z;
        }

        public void dump(PrintWriter pw) {
            synchronized (this.mLock) {
                pw.println();
                pw.println("Photonic Modulator State:");
                pw.println("  mPendingState=" + Display.stateToString(this.mPendingState));
                pw.println("  mPendingBacklight=" + this.mPendingBacklight);
                pw.println("  mActualState=" + Display.stateToString(this.mActualState));
                pw.println("  mActualBacklight=" + this.mActualBacklight);
                pw.println("  mChangeInProgress=" + this.mChangeInProgress);
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void run() {
            /*
            r10 = this;
            r5 = 1;
            r6 = 0;
        L_0x0002:
            r7 = r10.mLock;
            monitor-enter(r7);
            r2 = r10.mPendingState;	 Catch:{ all -> 0x0026 }
            r8 = r10.mActualState;	 Catch:{ all -> 0x0026 }
            if (r2 == r8) goto L_0x0029;
        L_0x000b:
            r3 = r5;
        L_0x000c:
            r0 = r10.mPendingBacklight;	 Catch:{ all -> 0x0026 }
            r8 = r10.mActualBacklight;	 Catch:{ all -> 0x0026 }
            if (r0 == r8) goto L_0x002b;
        L_0x0012:
            r1 = r5;
        L_0x0013:
            if (r3 != 0) goto L_0x002d;
        L_0x0015:
            if (r1 != 0) goto L_0x002d;
        L_0x0017:
            r8 = 0;
            r10.mChangeInProgress = r8;	 Catch:{ all -> 0x0026 }
            r8 = com.android.server.display.DisplayPowerState.this;	 Catch:{ all -> 0x0026 }
            r8.postScreenUpdateThreadSafe();	 Catch:{ all -> 0x0026 }
            r8 = r10.mLock;	 Catch:{ InterruptedException -> 0x0076 }
            r8.wait();	 Catch:{ InterruptedException -> 0x0076 }
        L_0x0024:
            monitor-exit(r7);	 Catch:{ all -> 0x0026 }
            goto L_0x0002;
        L_0x0026:
            r5 = move-exception;
            monitor-exit(r7);	 Catch:{ all -> 0x0026 }
            throw r5;
        L_0x0029:
            r3 = r6;
            goto L_0x000c;
        L_0x002b:
            r1 = r6;
            goto L_0x0013;
        L_0x002d:
            r10.mActualState = r2;	 Catch:{ all -> 0x0026 }
            r10.mActualBacklight = r0;	 Catch:{ all -> 0x0026 }
            monitor-exit(r7);	 Catch:{ all -> 0x0026 }
            r7 = com.android.server.display.DisplayPowerState.DEBUG;
            if (r7 == 0) goto L_0x005e;
        L_0x0038:
            r7 = "DisplayPowerState";
            r8 = new java.lang.StringBuilder;
            r8.<init>();
            r9 = "Updating screen state: state=";
            r8 = r8.append(r9);
            r9 = android.view.Display.stateToString(r2);
            r8 = r8.append(r9);
            r9 = ", backlight=";
            r8 = r8.append(r9);
            r8 = r8.append(r0);
            r8 = r8.toString();
            android.util.Slog.d(r7, r8);
        L_0x005e:
            r4 = android.view.Display.isSuspendedState(r2);
            if (r3 == 0) goto L_0x0069;
        L_0x0064:
            if (r4 != 0) goto L_0x0069;
        L_0x0066:
            r10.requestDisplayState(r2);
        L_0x0069:
            if (r1 == 0) goto L_0x006e;
        L_0x006b:
            r10.setBrightness(r0);
        L_0x006e:
            if (r3 == 0) goto L_0x0002;
        L_0x0070:
            if (r4 == 0) goto L_0x0002;
        L_0x0072:
            r10.requestDisplayState(r2);
            goto L_0x0002;
        L_0x0076:
            r8 = move-exception;
            goto L_0x0024;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.display.DisplayPowerState.PhotonicModulator.run():void");
        }

        private void requestDisplayState(int state) {
            Trace.traceBegin(131072, "requestDisplayState(" + Display.stateToString(state) + ")");
            try {
                DisplayPowerState.this.mBlanker.requestDisplayState(state);
            } finally {
                Trace.traceEnd(131072);
            }
        }

        private void setBrightness(int backlight) {
            Trace.traceBegin(131072, "setBrightness(" + backlight + ")");
            try {
                DisplayPowerState.this.mBacklight.setBrightness(backlight);
            } finally {
                Trace.traceEnd(131072);
            }
        }
    }

    static {
        DEBUG = false;
        COLOR_FADE_LEVEL = new C02051("electronBeamLevel");
        SCREEN_BRIGHTNESS = new C02062("screenBrightness");
    }

    public DisplayPowerState(DisplayBlanker blanker, Light backlight, ColorFade electronBeam) {
        this.mScreenUpdateRunnable = new C02073();
        this.mColorFadeDrawRunnable = new C02084();
        this.mHandler = new Handler(true);
        this.mChoreographer = Choreographer.getInstance();
        this.mBlanker = blanker;
        this.mBacklight = backlight;
        this.mColorFade = electronBeam;
        this.mPhotonicModulator = new PhotonicModulator();
        this.mPhotonicModulator.start();
        this.mScreenState = 2;
        this.mScreenBrightness = 255;
        scheduleScreenUpdate();
        this.mColorFadePrepared = false;
        this.mColorFadeLevel = 1.0f;
        this.mColorFadeReady = true;
    }

    public void setScreenState(int state) {
        if (this.mScreenState != state) {
            if (DEBUG) {
                Slog.d(TAG, "setScreenState: state=" + state);
            }
            this.mScreenState = state;
            this.mScreenReady = false;
            scheduleScreenUpdate();
        }
    }

    public int getScreenState() {
        return this.mScreenState;
    }

    public void setScreenBrightness(int brightness) {
        if (this.mScreenBrightness != brightness) {
            if (DEBUG) {
                Slog.d(TAG, "setScreenBrightness: brightness=" + brightness);
            }
            this.mScreenBrightness = brightness;
            if (this.mScreenState != 1) {
                this.mScreenReady = false;
                scheduleScreenUpdate();
            }
        }
    }

    public int getScreenBrightness() {
        return this.mScreenBrightness;
    }

    public boolean prepareColorFade(Context context, int mode) {
        if (this.mColorFade.prepare(context, mode)) {
            this.mColorFadePrepared = true;
            this.mColorFadeReady = false;
            scheduleColorFadeDraw();
            return true;
        }
        this.mColorFadePrepared = false;
        this.mColorFadeReady = true;
        return false;
    }

    public void dismissColorFade() {
        this.mColorFade.dismiss();
        this.mColorFadePrepared = false;
        this.mColorFadeReady = true;
    }

    public void setColorFadeLevel(float level) {
        if (this.mColorFadeLevel != level) {
            if (DEBUG) {
                Slog.d(TAG, "setColorFadeLevel: level=" + level);
            }
            this.mColorFadeLevel = level;
            if (this.mScreenState != 1) {
                this.mScreenReady = false;
                scheduleScreenUpdate();
            }
            if (this.mColorFadePrepared) {
                this.mColorFadeReady = false;
                scheduleColorFadeDraw();
            }
        }
    }

    public float getColorFadeLevel() {
        return this.mColorFadeLevel;
    }

    public boolean waitUntilClean(Runnable listener) {
        if (this.mScreenReady && this.mColorFadeReady) {
            this.mCleanListener = null;
            return true;
        }
        this.mCleanListener = listener;
        return false;
    }

    public void dump(PrintWriter pw) {
        pw.println();
        pw.println("Display Power State:");
        pw.println("  mScreenState=" + Display.stateToString(this.mScreenState));
        pw.println("  mScreenBrightness=" + this.mScreenBrightness);
        pw.println("  mScreenReady=" + this.mScreenReady);
        pw.println("  mScreenUpdatePending=" + this.mScreenUpdatePending);
        pw.println("  mColorFadePrepared=" + this.mColorFadePrepared);
        pw.println("  mColorFadeLevel=" + this.mColorFadeLevel);
        pw.println("  mColorFadeReady=" + this.mColorFadeReady);
        pw.println("  mColorFadeDrawPending=" + this.mColorFadeDrawPending);
        this.mPhotonicModulator.dump(pw);
        this.mColorFade.dump(pw);
    }

    private void scheduleScreenUpdate() {
        if (!this.mScreenUpdatePending) {
            this.mScreenUpdatePending = true;
            postScreenUpdateThreadSafe();
        }
    }

    private void postScreenUpdateThreadSafe() {
        this.mHandler.removeCallbacks(this.mScreenUpdateRunnable);
        this.mHandler.post(this.mScreenUpdateRunnable);
    }

    private void scheduleColorFadeDraw() {
        if (!this.mColorFadeDrawPending) {
            this.mColorFadeDrawPending = true;
            this.mChoreographer.postCallback(2, this.mColorFadeDrawRunnable, null);
        }
    }

    private void invokeCleanListenerIfNeeded() {
        Runnable listener = this.mCleanListener;
        if (listener != null && this.mScreenReady && this.mColorFadeReady) {
            this.mCleanListener = null;
            listener.run();
        }
    }
}
