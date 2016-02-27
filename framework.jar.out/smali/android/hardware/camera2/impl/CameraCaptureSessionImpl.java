package android.hardware.camera2.impl;

import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraCaptureSession;
import android.hardware.camera2.CameraCaptureSession.StateCallback;
import android.hardware.camera2.CameraDevice;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.dispatch.ArgumentReplacingDispatcher;
import android.hardware.camera2.dispatch.BroadcastDispatcher;
import android.hardware.camera2.dispatch.DuckTypingDispatcher;
import android.hardware.camera2.dispatch.HandlerDispatcher;
import android.hardware.camera2.dispatch.InvokeDispatcher;
import android.hardware.camera2.impl.CallbackProxies.DeviceCaptureCallbackProxy;
import android.hardware.camera2.impl.CallbackProxies.SessionStateCallbackProxy;
import android.hardware.camera2.impl.CameraDeviceImpl.CaptureCallback;
import android.hardware.camera2.impl.CameraDeviceImpl.StateCallbackKK;
import android.hardware.camera2.utils.TaskDrainer;
import android.hardware.camera2.utils.TaskDrainer.DrainListener;
import android.hardware.camera2.utils.TaskSingleDrainer;
import android.net.ProxyInfo;
import android.os.Handler;
import android.util.Log;
import android.view.Surface;
import com.android.internal.util.Preconditions;
import java.util.Arrays;
import java.util.List;

public class CameraCaptureSessionImpl extends CameraCaptureSession {
    private static final String TAG = "CameraCaptureSession";
    private static final boolean VERBOSE;
    private final TaskSingleDrainer mAbortDrainer;
    private volatile boolean mAborting;
    private boolean mClosed;
    private final boolean mConfigureSuccess;
    private final Handler mDeviceHandler;
    private final CameraDeviceImpl mDeviceImpl;
    private final int mId;
    private final String mIdString;
    private final TaskSingleDrainer mIdleDrainer;
    private final List<Surface> mOutputs;
    private final TaskDrainer<Integer> mSequenceDrainer;
    private boolean mSkipUnconfigure;
    private final StateCallback mStateCallback;
    private final Handler mStateHandler;
    private final TaskSingleDrainer mUnconfigureDrainer;

    /* renamed from: android.hardware.camera2.impl.CameraCaptureSessionImpl.1 */
    class C02211 extends CaptureCallback {
        C02211() {
        }

        public void onCaptureSequenceCompleted(CameraDevice camera, int sequenceId, long frameNumber) {
            CameraCaptureSessionImpl.this.finishPendingSequence(sequenceId);
        }

        public void onCaptureSequenceAborted(CameraDevice camera, int sequenceId) {
            CameraCaptureSessionImpl.this.finishPendingSequence(sequenceId);
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraCaptureSessionImpl.2 */
    class C02222 extends StateCallbackKK {
        private boolean mActive;
        private boolean mBusy;
        final /* synthetic */ CameraCaptureSession val$session;

        C02222(CameraCaptureSession cameraCaptureSession) {
            this.val$session = cameraCaptureSession;
            this.mBusy = false;
            this.mActive = false;
        }

        public void onOpened(CameraDevice camera) {
            throw new AssertionError("Camera must already be open before creating a session");
        }

        public void onDisconnected(CameraDevice camera) {
            if (CameraCaptureSessionImpl.VERBOSE) {
                Log.v(CameraCaptureSessionImpl.TAG, CameraCaptureSessionImpl.this.mIdString + "onDisconnected");
            }
            CameraCaptureSessionImpl.this.close();
        }

        public void onError(CameraDevice camera, int error) {
            Log.wtf(CameraCaptureSessionImpl.TAG, CameraCaptureSessionImpl.this.mIdString + "Got device error " + error);
        }

        public void onActive(CameraDevice camera) {
            CameraCaptureSessionImpl.this.mIdleDrainer.taskStarted();
            this.mActive = true;
            if (CameraCaptureSessionImpl.VERBOSE) {
                Log.v(CameraCaptureSessionImpl.TAG, CameraCaptureSessionImpl.this.mIdString + "onActive");
            }
            CameraCaptureSessionImpl.this.mStateCallback.onActive(this.val$session);
        }

        public void onIdle(CameraDevice camera) {
            if (CameraCaptureSessionImpl.VERBOSE) {
                Log.v(CameraCaptureSessionImpl.TAG, CameraCaptureSessionImpl.this.mIdString + "onIdle");
            }
            synchronized (this.val$session) {
                boolean isAborting = CameraCaptureSessionImpl.this.mAborting;
            }
            if (this.mBusy && isAborting) {
                CameraCaptureSessionImpl.this.mAbortDrainer.taskFinished();
                synchronized (this.val$session) {
                    CameraCaptureSessionImpl.this.mAborting = false;
                }
            }
            if (this.mActive) {
                CameraCaptureSessionImpl.this.mIdleDrainer.taskFinished();
            }
            this.mBusy = false;
            this.mActive = false;
            CameraCaptureSessionImpl.this.mStateCallback.onReady(this.val$session);
        }

        public void onBusy(CameraDevice camera) {
            this.mBusy = true;
            if (CameraCaptureSessionImpl.VERBOSE) {
                Log.v(CameraCaptureSessionImpl.TAG, CameraCaptureSessionImpl.this.mIdString + "onBusy");
            }
        }

        public void onUnconfigured(CameraDevice camera) {
            if (CameraCaptureSessionImpl.VERBOSE) {
                Log.v(CameraCaptureSessionImpl.TAG, CameraCaptureSessionImpl.this.mIdString + "onUnconfigured");
            }
            synchronized (this.val$session) {
                if (CameraCaptureSessionImpl.this.mClosed && CameraCaptureSessionImpl.this.mConfigureSuccess && !CameraCaptureSessionImpl.this.mSkipUnconfigure) {
                    CameraCaptureSessionImpl.this.mUnconfigureDrainer.taskFinished();
                }
            }
        }
    }

    private class AbortDrainListener implements DrainListener {
        private AbortDrainListener() {
        }

        public void onDrained() {
            if (CameraCaptureSessionImpl.VERBOSE) {
                Log.v(CameraCaptureSessionImpl.TAG, CameraCaptureSessionImpl.this.mIdString + "onAbortDrained");
            }
            synchronized (CameraCaptureSessionImpl.this) {
                CameraCaptureSessionImpl.this.mIdleDrainer.beginDrain();
            }
        }
    }

    private class IdleDrainListener implements DrainListener {
        private IdleDrainListener() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onDrained() {
            /*
            r6 = this;
            r1 = android.hardware.camera2.impl.CameraCaptureSessionImpl.VERBOSE;
            if (r1 == 0) goto L_0x0025;
        L_0x0006:
            r1 = "CameraCaptureSession";
            r2 = new java.lang.StringBuilder;
            r2.<init>();
            r3 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;
            r3 = r3.mIdString;
            r2 = r2.append(r3);
            r3 = "onIdleDrained";
            r2 = r2.append(r3);
            r2 = r2.toString();
            android.util.Log.v(r1, r2);
        L_0x0025:
            r1 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;
            r1 = r1.mDeviceImpl;
            r2 = r1.mInterfaceLock;
            monitor-enter(r2);
            r3 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x0094 }
            monitor-enter(r3);	 Catch:{ all -> 0x0094 }
            r1 = android.hardware.camera2.impl.CameraCaptureSessionImpl.VERBOSE;	 Catch:{ all -> 0x00b7 }
            if (r1 == 0) goto L_0x005f;
        L_0x0037:
            r1 = "CameraCaptureSession";
            r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00b7 }
            r4.<init>();	 Catch:{ all -> 0x00b7 }
            r5 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x00b7 }
            r5 = r5.mIdString;	 Catch:{ all -> 0x00b7 }
            r4 = r4.append(r5);	 Catch:{ all -> 0x00b7 }
            r5 = "Session drain complete, skip unconfigure: ";
            r4 = r4.append(r5);	 Catch:{ all -> 0x00b7 }
            r5 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x00b7 }
            r5 = r5.mSkipUnconfigure;	 Catch:{ all -> 0x00b7 }
            r4 = r4.append(r5);	 Catch:{ all -> 0x00b7 }
            r4 = r4.toString();	 Catch:{ all -> 0x00b7 }
            android.util.Log.v(r1, r4);	 Catch:{ all -> 0x00b7 }
        L_0x005f:
            r1 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x00b7 }
            r1 = r1.mSkipUnconfigure;	 Catch:{ all -> 0x00b7 }
            if (r1 == 0) goto L_0x0075;
        L_0x0067:
            r1 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x00b7 }
            r1 = r1.mStateCallback;	 Catch:{ all -> 0x00b7 }
            r4 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x00b7 }
            r1.onClosed(r4);	 Catch:{ all -> 0x00b7 }
            monitor-exit(r3);	 Catch:{ all -> 0x00b7 }
            monitor-exit(r2);	 Catch:{ all -> 0x0094 }
        L_0x0074:
            return;
        L_0x0075:
            r1 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x00b7 }
            r1 = r1.mUnconfigureDrainer;	 Catch:{ all -> 0x00b7 }
            r1.taskStarted();	 Catch:{ all -> 0x00b7 }
            r1 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ CameraAccessException -> 0x0097, IllegalStateException -> 0x00ba }
            r1 = r1.mDeviceImpl;	 Catch:{ CameraAccessException -> 0x0097, IllegalStateException -> 0x00ba }
            r4 = 0;
            r1.configureOutputsChecked(r4);	 Catch:{ CameraAccessException -> 0x0097, IllegalStateException -> 0x00ba }
        L_0x0088:
            r1 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x00b7 }
            r1 = r1.mUnconfigureDrainer;	 Catch:{ all -> 0x00b7 }
            r1.beginDrain();	 Catch:{ all -> 0x00b7 }
            monitor-exit(r3);	 Catch:{ all -> 0x00b7 }
            monitor-exit(r2);	 Catch:{ all -> 0x0094 }
            goto L_0x0074;
        L_0x0094:
            r1 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x0094 }
            throw r1;
        L_0x0097:
            r0 = move-exception;
            r1 = "CameraCaptureSession";
            r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00b7 }
            r4.<init>();	 Catch:{ all -> 0x00b7 }
            r5 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x00b7 }
            r5 = r5.mIdString;	 Catch:{ all -> 0x00b7 }
            r4 = r4.append(r5);	 Catch:{ all -> 0x00b7 }
            r5 = "Exception while configuring outputs: ";
            r4 = r4.append(r5);	 Catch:{ all -> 0x00b7 }
            r4 = r4.toString();	 Catch:{ all -> 0x00b7 }
            android.util.Log.e(r1, r4, r0);	 Catch:{ all -> 0x00b7 }
            goto L_0x0088;
        L_0x00b7:
            r1 = move-exception;
            monitor-exit(r3);	 Catch:{ all -> 0x00b7 }
            throw r1;	 Catch:{ all -> 0x0094 }
        L_0x00ba:
            r0 = move-exception;
            r1 = android.hardware.camera2.impl.CameraCaptureSessionImpl.VERBOSE;	 Catch:{ all -> 0x00b7 }
            if (r1 == 0) goto L_0x00df;
        L_0x00c1:
            r1 = "CameraCaptureSession";
            r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00b7 }
            r4.<init>();	 Catch:{ all -> 0x00b7 }
            r5 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x00b7 }
            r5 = r5.mIdString;	 Catch:{ all -> 0x00b7 }
            r4 = r4.append(r5);	 Catch:{ all -> 0x00b7 }
            r5 = "Camera was already closed or busy, skipping unconfigure";
            r4 = r4.append(r5);	 Catch:{ all -> 0x00b7 }
            r4 = r4.toString();	 Catch:{ all -> 0x00b7 }
            android.util.Log.v(r1, r4);	 Catch:{ all -> 0x00b7 }
        L_0x00df:
            r1 = android.hardware.camera2.impl.CameraCaptureSessionImpl.this;	 Catch:{ all -> 0x00b7 }
            r1 = r1.mUnconfigureDrainer;	 Catch:{ all -> 0x00b7 }
            r1.taskFinished();	 Catch:{ all -> 0x00b7 }
            goto L_0x0088;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.hardware.camera2.impl.CameraCaptureSessionImpl.IdleDrainListener.onDrained():void");
        }
    }

    private class SequenceDrainListener implements DrainListener {
        private SequenceDrainListener() {
        }

        public void onDrained() {
            if (CameraCaptureSessionImpl.VERBOSE) {
                Log.v(CameraCaptureSessionImpl.TAG, CameraCaptureSessionImpl.this.mIdString + "onSequenceDrained");
            }
            CameraCaptureSessionImpl.this.mAbortDrainer.beginDrain();
        }
    }

    private class UnconfigureDrainListener implements DrainListener {
        private UnconfigureDrainListener() {
        }

        public void onDrained() {
            if (CameraCaptureSessionImpl.VERBOSE) {
                Log.v(CameraCaptureSessionImpl.TAG, CameraCaptureSessionImpl.this.mIdString + "onUnconfigureDrained");
            }
            synchronized (CameraCaptureSessionImpl.this) {
                CameraCaptureSessionImpl.this.mStateCallback.onClosed(CameraCaptureSessionImpl.this);
            }
        }
    }

    static {
        VERBOSE = Log.isLoggable(TAG, 2);
    }

    CameraCaptureSessionImpl(int id, List<Surface> outputs, StateCallback callback, Handler stateHandler, CameraDeviceImpl deviceImpl, Handler deviceStateHandler, boolean configureSuccess) {
        this.mClosed = false;
        this.mSkipUnconfigure = false;
        if (outputs == null || outputs.isEmpty()) {
            throw new IllegalArgumentException("outputs must be a non-null, non-empty list");
        } else if (callback == null) {
            throw new IllegalArgumentException("callback must not be null");
        } else {
            this.mId = id;
            this.mIdString = String.format("Session %d: ", new Object[]{Integer.valueOf(this.mId)});
            this.mOutputs = outputs;
            this.mStateHandler = CameraDeviceImpl.checkHandler(stateHandler);
            this.mStateCallback = createUserStateCallbackProxy(this.mStateHandler, callback);
            this.mDeviceHandler = (Handler) Preconditions.checkNotNull(deviceStateHandler, "deviceStateHandler must not be null");
            this.mDeviceImpl = (CameraDeviceImpl) Preconditions.checkNotNull(deviceImpl, "deviceImpl must not be null");
            this.mSequenceDrainer = new TaskDrainer(this.mDeviceHandler, new SequenceDrainListener(), "seq");
            this.mIdleDrainer = new TaskSingleDrainer(this.mDeviceHandler, new IdleDrainListener(), "idle");
            this.mAbortDrainer = new TaskSingleDrainer(this.mDeviceHandler, new AbortDrainListener(), "abort");
            this.mUnconfigureDrainer = new TaskSingleDrainer(this.mDeviceHandler, new UnconfigureDrainListener(), "unconf");
            if (configureSuccess) {
                this.mStateCallback.onConfigured(this);
                if (VERBOSE) {
                    Log.v(TAG, this.mIdString + "Created session successfully");
                }
                this.mConfigureSuccess = true;
                return;
            }
            this.mStateCallback.onConfigureFailed(this);
            this.mClosed = true;
            Log.e(TAG, this.mIdString + "Failed to create capture session; configuration failed");
            this.mConfigureSuccess = false;
        }
    }

    public CameraDevice getDevice() {
        return this.mDeviceImpl;
    }

    public synchronized int capture(CaptureRequest request, CameraCaptureSession.CaptureCallback callback, Handler handler) throws CameraAccessException {
        if (request == null) {
            throw new IllegalArgumentException("request must not be null");
        }
        checkNotClosed();
        handler = CameraDeviceImpl.checkHandler(handler, callback);
        if (VERBOSE) {
            Log.v(TAG, this.mIdString + "capture - request " + request + ", callback " + callback + " handler " + handler);
        }
        return addPendingSequence(this.mDeviceImpl.capture(request, createCaptureCallbackProxy(handler, callback), this.mDeviceHandler));
    }

    public synchronized int captureBurst(List<CaptureRequest> requests, CameraCaptureSession.CaptureCallback callback, Handler handler) throws CameraAccessException {
        if (requests == null) {
            throw new IllegalArgumentException("requests must not be null");
        } else if (requests.isEmpty()) {
            throw new IllegalArgumentException("requests must have at least one element");
        } else {
            checkNotClosed();
            handler = CameraDeviceImpl.checkHandler(handler, callback);
            if (VERBOSE) {
                Log.v(TAG, this.mIdString + "captureBurst - requests " + Arrays.toString((CaptureRequest[]) requests.toArray(new CaptureRequest[0])) + ", callback " + callback + " handler " + handler);
            }
        }
        return addPendingSequence(this.mDeviceImpl.captureBurst(requests, createCaptureCallbackProxy(handler, callback), this.mDeviceHandler));
    }

    public synchronized int setRepeatingRequest(CaptureRequest request, CameraCaptureSession.CaptureCallback callback, Handler handler) throws CameraAccessException {
        if (request == null) {
            throw new IllegalArgumentException("request must not be null");
        }
        checkNotClosed();
        handler = CameraDeviceImpl.checkHandler(handler, callback);
        if (VERBOSE) {
            Log.v(TAG, this.mIdString + "setRepeatingRequest - request " + request + ", callback " + callback + " handler" + " " + handler);
        }
        return addPendingSequence(this.mDeviceImpl.setRepeatingRequest(request, createCaptureCallbackProxy(handler, callback), this.mDeviceHandler));
    }

    public synchronized int setRepeatingBurst(List<CaptureRequest> requests, CameraCaptureSession.CaptureCallback callback, Handler handler) throws CameraAccessException {
        if (requests == null) {
            throw new IllegalArgumentException("requests must not be null");
        } else if (requests.isEmpty()) {
            throw new IllegalArgumentException("requests must have at least one element");
        } else {
            checkNotClosed();
            handler = CameraDeviceImpl.checkHandler(handler, callback);
            if (VERBOSE) {
                Log.v(TAG, this.mIdString + "setRepeatingBurst - requests " + Arrays.toString((CaptureRequest[]) requests.toArray(new CaptureRequest[0])) + ", callback " + callback + " handler" + ProxyInfo.LOCAL_EXCL_LIST + handler);
            }
        }
        return addPendingSequence(this.mDeviceImpl.setRepeatingBurst(requests, createCaptureCallbackProxy(handler, callback), this.mDeviceHandler));
    }

    public synchronized void stopRepeating() throws CameraAccessException {
        checkNotClosed();
        if (VERBOSE) {
            Log.v(TAG, this.mIdString + "stopRepeating");
        }
        this.mDeviceImpl.stopRepeating();
    }

    public synchronized void abortCaptures() throws CameraAccessException {
        checkNotClosed();
        if (VERBOSE) {
            Log.v(TAG, this.mIdString + "abortCaptures");
        }
        if (this.mAborting) {
            Log.w(TAG, this.mIdString + "abortCaptures - Session is already aborting; doing nothing");
        } else {
            this.mAborting = true;
            this.mAbortDrainer.taskStarted();
            this.mDeviceImpl.flush();
        }
    }

    synchronized void replaceSessionClose() {
        if (VERBOSE) {
            Log.v(TAG, this.mIdString + "replaceSessionClose");
        }
        this.mSkipUnconfigure = true;
        close();
    }

    public synchronized void close() {
        if (!this.mClosed) {
            if (VERBOSE) {
                Log.v(TAG, this.mIdString + "close - first time");
            }
            this.mClosed = true;
            try {
                this.mDeviceImpl.stopRepeating();
            } catch (IllegalStateException e) {
                Log.w(TAG, this.mIdString + "The camera device was already closed: ", e);
                this.mStateCallback.onClosed(this);
            } catch (CameraAccessException e2) {
                Log.e(TAG, this.mIdString + "Exception while stopping repeating: ", e2);
            }
            this.mSequenceDrainer.beginDrain();
        } else if (VERBOSE) {
            Log.v(TAG, this.mIdString + "close - reentering");
        }
    }

    boolean isAborting() {
        return this.mAborting;
    }

    private StateCallback createUserStateCallbackProxy(Handler handler, StateCallback callback) {
        return new SessionStateCallbackProxy(new HandlerDispatcher(new InvokeDispatcher(callback), handler));
    }

    private CaptureCallback createCaptureCallbackProxy(Handler handler, CameraCaptureSession.CaptureCallback callback) {
        CaptureCallback localCallback = new C02211();
        if (callback == null) {
            return localCallback;
        }
        InvokeDispatcher<CaptureCallback> localSink = new InvokeDispatcher(localCallback);
        return new DeviceCaptureCallbackProxy(new BroadcastDispatcher(new ArgumentReplacingDispatcher(new DuckTypingDispatcher(new HandlerDispatcher(new InvokeDispatcher(callback), handler), CameraCaptureSession.CaptureCallback.class), 0, this), localSink));
    }

    StateCallbackKK getDeviceStateCallback() {
        return new C02222(this);
    }

    protected void finalize() throws Throwable {
        try {
            close();
        } finally {
            super.finalize();
        }
    }

    private void checkNotClosed() {
        if (this.mClosed) {
            throw new IllegalStateException("Session has been closed; further changes are illegal.");
        }
    }

    private int addPendingSequence(int sequenceId) {
        this.mSequenceDrainer.taskStarted(Integer.valueOf(sequenceId));
        return sequenceId;
    }

    private void finishPendingSequence(int sequenceId) {
        this.mSequenceDrainer.taskFinished(Integer.valueOf(sequenceId));
    }
}
