package android.media.audiofx;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.util.Log;
import java.lang.ref.WeakReference;

public class Visualizer {
    public static final int ALREADY_EXISTS = -2;
    public static final int ERROR = -1;
    public static final int ERROR_BAD_VALUE = -4;
    public static final int ERROR_DEAD_OBJECT = -7;
    public static final int ERROR_INVALID_OPERATION = -5;
    public static final int ERROR_NO_INIT = -3;
    public static final int ERROR_NO_MEMORY = -6;
    public static final int MEASUREMENT_MODE_NONE = 0;
    public static final int MEASUREMENT_MODE_PEAK_RMS = 1;
    private static final int NATIVE_EVENT_FFT_CAPTURE = 1;
    private static final int NATIVE_EVENT_PCM_CAPTURE = 0;
    private static final int NATIVE_EVENT_SERVER_DIED = 2;
    public static final int SCALING_MODE_AS_PLAYED = 1;
    public static final int SCALING_MODE_NORMALIZED = 0;
    public static final int STATE_ENABLED = 2;
    public static final int STATE_INITIALIZED = 1;
    public static final int STATE_UNINITIALIZED = 0;
    public static final int SUCCESS = 0;
    private static final String TAG = "Visualizer-JAVA";
    private OnDataCaptureListener mCaptureListener;
    private int mId;
    private long mJniData;
    private final Object mListenerLock;
    private NativeEventHandler mNativeEventHandler;
    private long mNativeVisualizer;
    private OnServerDiedListener mServerDiedListener;
    private int mState;
    private final Object mStateLock;

    public static final class MeasurementPeakRms {
        public int mPeak;
        public int mRms;
    }

    private class NativeEventHandler extends Handler {
        private Visualizer mVisualizer;

        public NativeEventHandler(Visualizer v, Looper looper) {
            super(looper);
            this.mVisualizer = v;
        }

        private void handleCaptureMessage(Message msg) {
            synchronized (Visualizer.this.mListenerLock) {
                OnDataCaptureListener l = this.mVisualizer.mCaptureListener;
            }
            if (l != null) {
                byte[] data = (byte[]) msg.obj;
                int samplingRate = msg.arg1;
                switch (msg.what) {
                    case Visualizer.SUCCESS /*0*/:
                        l.onWaveFormDataCapture(this.mVisualizer, data, samplingRate);
                    case Visualizer.STATE_INITIALIZED /*1*/:
                        l.onFftDataCapture(this.mVisualizer, data, samplingRate);
                    default:
                        Log.e(Visualizer.TAG, "Unknown native event in handleCaptureMessge: " + msg.what);
                }
            }
        }

        private void handleServerDiedMessage(Message msg) {
            synchronized (Visualizer.this.mListenerLock) {
                OnServerDiedListener l = this.mVisualizer.mServerDiedListener;
            }
            if (l != null) {
                l.onServerDied();
            }
        }

        public void handleMessage(Message msg) {
            if (this.mVisualizer != null) {
                switch (msg.what) {
                    case Visualizer.SUCCESS /*0*/:
                    case Visualizer.STATE_INITIALIZED /*1*/:
                        handleCaptureMessage(msg);
                    case Visualizer.STATE_ENABLED /*2*/:
                        handleServerDiedMessage(msg);
                    default:
                        Log.e(Visualizer.TAG, "Unknown native event: " + msg.what);
                }
            }
        }
    }

    public interface OnDataCaptureListener {
        void onFftDataCapture(Visualizer visualizer, byte[] bArr, int i);

        void onWaveFormDataCapture(Visualizer visualizer, byte[] bArr, int i);
    }

    public interface OnServerDiedListener {
        void onServerDied();
    }

    public static native int[] getCaptureSizeRange();

    public static native int getMaxCaptureRate();

    private final native void native_finalize();

    private final native int native_getCaptureSize();

    private final native boolean native_getEnabled();

    private final native int native_getFft(byte[] bArr);

    private final native int native_getMeasurementMode();

    private final native int native_getPeakRms(MeasurementPeakRms measurementPeakRms);

    private final native int native_getSamplingRate();

    private final native int native_getScalingMode();

    private final native int native_getWaveForm(byte[] bArr);

    private static final native void native_init();

    private final native void native_release();

    private final native int native_setCaptureSize(int i);

    private final native int native_setEnabled(boolean z);

    private final native int native_setMeasurementMode(int i);

    private final native int native_setPeriodicCapture(int i, boolean z, boolean z2);

    private final native int native_setScalingMode(int i);

    private final native int native_setup(Object obj, int i, int[] iArr);

    static {
        System.loadLibrary("audioeffect_jni");
        native_init();
    }

    public Visualizer(int audioSession) throws UnsupportedOperationException, RuntimeException {
        this.mState = SUCCESS;
        this.mStateLock = new Object();
        this.mListenerLock = new Object();
        this.mNativeEventHandler = null;
        this.mCaptureListener = null;
        this.mServerDiedListener = null;
        int[] id = new int[STATE_INITIALIZED];
        synchronized (this.mStateLock) {
            this.mState = SUCCESS;
            int result = native_setup(new WeakReference(this), audioSession, id);
            if (result == 0 || result == ALREADY_EXISTS) {
                this.mId = id[SUCCESS];
                if (native_getEnabled()) {
                    this.mState = STATE_ENABLED;
                } else {
                    this.mState = STATE_INITIALIZED;
                }
            } else {
                Log.e(TAG, "Error code " + result + " when initializing Visualizer.");
                switch (result) {
                    case ERROR_INVALID_OPERATION /*-5*/:
                        throw new UnsupportedOperationException("Effect library not loaded");
                    default:
                        throw new RuntimeException("Cannot initialize Visualizer engine, error: " + result);
                }
            }
        }
    }

    public void release() {
        synchronized (this.mStateLock) {
            native_release();
            this.mState = SUCCESS;
        }
    }

    protected void finalize() {
        native_finalize();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public int setEnabled(boolean r6) throws java.lang.IllegalStateException {
        /*
        r5 = this;
        r1 = 2;
        r2 = 1;
        r3 = r5.mStateLock;
        monitor-enter(r3);
        r4 = r5.mState;	 Catch:{ all -> 0x0025 }
        if (r4 != 0) goto L_0x0028;
    L_0x0009:
        r1 = new java.lang.IllegalStateException;	 Catch:{ all -> 0x0025 }
        r2 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0025 }
        r2.<init>();	 Catch:{ all -> 0x0025 }
        r4 = "setEnabled() called in wrong state: ";
        r2 = r2.append(r4);	 Catch:{ all -> 0x0025 }
        r4 = r5.mState;	 Catch:{ all -> 0x0025 }
        r2 = r2.append(r4);	 Catch:{ all -> 0x0025 }
        r2 = r2.toString();	 Catch:{ all -> 0x0025 }
        r1.<init>(r2);	 Catch:{ all -> 0x0025 }
        throw r1;	 Catch:{ all -> 0x0025 }
    L_0x0025:
        r1 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0025 }
        throw r1;
    L_0x0028:
        r0 = 0;
        if (r6 == 0) goto L_0x002f;
    L_0x002b:
        r4 = r5.mState;	 Catch:{ all -> 0x0025 }
        if (r4 == r2) goto L_0x0035;
    L_0x002f:
        if (r6 != 0) goto L_0x003f;
    L_0x0031:
        r4 = r5.mState;	 Catch:{ all -> 0x0025 }
        if (r4 != r1) goto L_0x003f;
    L_0x0035:
        r0 = r5.native_setEnabled(r6);	 Catch:{ all -> 0x0025 }
        if (r0 != 0) goto L_0x003f;
    L_0x003b:
        if (r6 == 0) goto L_0x0041;
    L_0x003d:
        r5.mState = r1;	 Catch:{ all -> 0x0025 }
    L_0x003f:
        monitor-exit(r3);	 Catch:{ all -> 0x0025 }
        return r0;
    L_0x0041:
        r1 = r2;
        goto L_0x003d;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.audiofx.Visualizer.setEnabled(boolean):int");
    }

    public boolean getEnabled() {
        boolean native_getEnabled;
        synchronized (this.mStateLock) {
            if (this.mState == 0) {
                throw new IllegalStateException("getEnabled() called in wrong state: " + this.mState);
            }
            native_getEnabled = native_getEnabled();
        }
        return native_getEnabled;
    }

    public int setCaptureSize(int size) throws IllegalStateException {
        int native_setCaptureSize;
        synchronized (this.mStateLock) {
            if (this.mState != STATE_INITIALIZED) {
                throw new IllegalStateException("setCaptureSize() called in wrong state: " + this.mState);
            }
            native_setCaptureSize = native_setCaptureSize(size);
        }
        return native_setCaptureSize;
    }

    public int getCaptureSize() throws IllegalStateException {
        int native_getCaptureSize;
        synchronized (this.mStateLock) {
            if (this.mState == 0) {
                throw new IllegalStateException("getCaptureSize() called in wrong state: " + this.mState);
            }
            native_getCaptureSize = native_getCaptureSize();
        }
        return native_getCaptureSize;
    }

    public int setScalingMode(int mode) throws IllegalStateException {
        int native_setScalingMode;
        synchronized (this.mStateLock) {
            if (this.mState == 0) {
                throw new IllegalStateException("setScalingMode() called in wrong state: " + this.mState);
            }
            native_setScalingMode = native_setScalingMode(mode);
        }
        return native_setScalingMode;
    }

    public int getScalingMode() throws IllegalStateException {
        int native_getScalingMode;
        synchronized (this.mStateLock) {
            if (this.mState == 0) {
                throw new IllegalStateException("getScalingMode() called in wrong state: " + this.mState);
            }
            native_getScalingMode = native_getScalingMode();
        }
        return native_getScalingMode;
    }

    public int setMeasurementMode(int mode) throws IllegalStateException {
        int native_setMeasurementMode;
        synchronized (this.mStateLock) {
            if (this.mState == 0) {
                throw new IllegalStateException("setMeasurementMode() called in wrong state: " + this.mState);
            }
            native_setMeasurementMode = native_setMeasurementMode(mode);
        }
        return native_setMeasurementMode;
    }

    public int getMeasurementMode() throws IllegalStateException {
        int native_getMeasurementMode;
        synchronized (this.mStateLock) {
            if (this.mState == 0) {
                throw new IllegalStateException("getMeasurementMode() called in wrong state: " + this.mState);
            }
            native_getMeasurementMode = native_getMeasurementMode();
        }
        return native_getMeasurementMode;
    }

    public int getSamplingRate() throws IllegalStateException {
        int native_getSamplingRate;
        synchronized (this.mStateLock) {
            if (this.mState == 0) {
                throw new IllegalStateException("getSamplingRate() called in wrong state: " + this.mState);
            }
            native_getSamplingRate = native_getSamplingRate();
        }
        return native_getSamplingRate;
    }

    public int getWaveForm(byte[] waveform) throws IllegalStateException {
        int native_getWaveForm;
        synchronized (this.mStateLock) {
            if (this.mState != STATE_ENABLED) {
                throw new IllegalStateException("getWaveForm() called in wrong state: " + this.mState);
            }
            native_getWaveForm = native_getWaveForm(waveform);
        }
        return native_getWaveForm;
    }

    public int getFft(byte[] fft) throws IllegalStateException {
        int native_getFft;
        synchronized (this.mStateLock) {
            if (this.mState != STATE_ENABLED) {
                throw new IllegalStateException("getFft() called in wrong state: " + this.mState);
            }
            native_getFft = native_getFft(fft);
        }
        return native_getFft;
    }

    public int getMeasurementPeakRms(MeasurementPeakRms measurement) {
        if (measurement == null) {
            Log.e(TAG, "Cannot store measurements in a null object");
            return ERROR_BAD_VALUE;
        }
        int native_getPeakRms;
        synchronized (this.mStateLock) {
            if (this.mState != STATE_ENABLED) {
                throw new IllegalStateException("getMeasurementPeakRms() called in wrong state: " + this.mState);
            }
            native_getPeakRms = native_getPeakRms(measurement);
        }
        return native_getPeakRms;
    }

    public int setDataCaptureListener(OnDataCaptureListener listener, int rate, boolean waveform, boolean fft) {
        synchronized (this.mListenerLock) {
            this.mCaptureListener = listener;
        }
        if (listener == null) {
            waveform = false;
            fft = false;
        }
        int status = native_setPeriodicCapture(rate, waveform, fft);
        if (status != 0 || listener == null || this.mNativeEventHandler != null) {
            return status;
        }
        Looper looper = Looper.myLooper();
        if (looper != null) {
            this.mNativeEventHandler = new NativeEventHandler(this, looper);
            return status;
        }
        looper = Looper.getMainLooper();
        if (looper != null) {
            this.mNativeEventHandler = new NativeEventHandler(this, looper);
            return status;
        }
        this.mNativeEventHandler = null;
        return ERROR_NO_INIT;
    }

    public int setServerDiedListener(OnServerDiedListener listener) {
        synchronized (this.mListenerLock) {
            this.mServerDiedListener = listener;
        }
        return SUCCESS;
    }

    private static void postEventFromNative(Object effect_ref, int what, int arg1, int arg2, Object obj) {
        Visualizer visu = (Visualizer) ((WeakReference) effect_ref).get();
        if (visu != null && visu.mNativeEventHandler != null) {
            visu.mNativeEventHandler.sendMessage(visu.mNativeEventHandler.obtainMessage(what, arg1, arg2, obj));
        }
    }
}
