package android.hardware.camera2.impl;

import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraCaptureSession;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraDevice;
import android.hardware.camera2.CameraDevice.StateCallback;
import android.hardware.camera2.CaptureFailure;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureRequest.Builder;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.ICameraDeviceCallbacks.Stub;
import android.hardware.camera2.ICameraDeviceUser;
import android.hardware.camera2.TotalCaptureResult;
import android.hardware.camera2.utils.CameraBinderDecorator;
import android.hardware.camera2.utils.CameraRuntimeException;
import android.hardware.camera2.utils.LongParcelable;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.RemoteException;
import android.util.Log;
import android.util.SparseArray;
import android.view.Surface;
import android.widget.Toast;
import java.util.AbstractMap.SimpleEntry;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;

public class CameraDeviceImpl extends CameraDevice {
    private static final int REQUEST_ID_NONE = -1;
    private final boolean DEBUG;
    private final String TAG;
    private final Runnable mCallOnActive;
    private final Runnable mCallOnBusy;
    private final Runnable mCallOnClosed;
    private final Runnable mCallOnDisconnected;
    private final Runnable mCallOnIdle;
    private final Runnable mCallOnOpened;
    private final Runnable mCallOnUnconfigured;
    private final CameraDeviceCallbacks mCallbacks;
    private final String mCameraId;
    private final SparseArray<CaptureCallbackHolder> mCaptureCallbackMap;
    private final CameraCharacteristics mCharacteristics;
    private volatile boolean mClosing;
    private final SparseArray<Surface> mConfiguredOutputs;
    private CameraCaptureSessionImpl mCurrentSession;
    private final StateCallback mDeviceCallback;
    private final Handler mDeviceHandler;
    private final List<SimpleEntry<Long, Integer>> mFrameNumberRequestPairs;
    private final FrameNumberTracker mFrameNumberTracker;
    private boolean mIdle;
    private boolean mInError;
    final Object mInterfaceLock;
    private int mNextSessionId;
    private ICameraDeviceUser mRemoteDevice;
    private int mRepeatingRequestId;
    private final ArrayList<Integer> mRepeatingRequestIdDeletedList;
    private volatile StateCallbackKK mSessionStateCallback;
    private final int mTotalPartialCount;

    public static abstract class CaptureCallback {
        public static final int NO_FRAMES_CAPTURED = -1;

        public void onCaptureStarted(CameraDevice camera, CaptureRequest request, long timestamp, long frameNumber) {
        }

        public void onCapturePartial(CameraDevice camera, CaptureRequest request, CaptureResult result) {
        }

        public void onCaptureProgressed(CameraDevice camera, CaptureRequest request, CaptureResult partialResult) {
        }

        public void onCaptureCompleted(CameraDevice camera, CaptureRequest request, TotalCaptureResult result) {
        }

        public void onCaptureFailed(CameraDevice camera, CaptureRequest request, CaptureFailure failure) {
        }

        public void onCaptureSequenceCompleted(CameraDevice camera, int sequenceId, long frameNumber) {
        }

        public void onCaptureSequenceAborted(CameraDevice camera, int sequenceId) {
        }
    }

    public static abstract class StateCallbackKK extends StateCallback {
        public void onUnconfigured(CameraDevice camera) {
        }

        public void onActive(CameraDevice camera) {
        }

        public void onBusy(CameraDevice camera) {
        }

        public void onIdle(CameraDevice camera) {
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.10 */
    class AnonymousClass10 implements Runnable {
        final /* synthetic */ SimpleEntry val$frameNumberRequestPair;
        final /* synthetic */ CaptureCallbackHolder val$holder;
        final /* synthetic */ int val$requestId;

        AnonymousClass10(int i, SimpleEntry simpleEntry, CaptureCallbackHolder captureCallbackHolder) {
            this.val$requestId = i;
            this.val$frameNumberRequestPair = simpleEntry;
            this.val$holder = captureCallbackHolder;
        }

        public void run() {
            if (!CameraDeviceImpl.this.isClosed()) {
                if (CameraDeviceImpl.this.DEBUG) {
                    Log.d(CameraDeviceImpl.this.TAG, String.format("fire sequence complete for request %d", new Object[]{Integer.valueOf(this.val$requestId)}));
                }
                long lastFrameNumber = ((Long) this.val$frameNumberRequestPair.getKey()).longValue();
                if (lastFrameNumber < -2147483648L || lastFrameNumber > 2147483647L) {
                    throw new AssertionError(lastFrameNumber + " cannot be cast to int");
                }
                this.val$holder.getCallback().onCaptureSequenceCompleted(CameraDeviceImpl.this, this.val$requestId, lastFrameNumber);
            }
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.1 */
    class C02231 implements Runnable {
        C02231() {
        }

        public void run() {
            synchronized (CameraDeviceImpl.this.mInterfaceLock) {
                if (CameraDeviceImpl.this.mRemoteDevice == null) {
                    return;
                }
                StateCallbackKK sessionCallback = CameraDeviceImpl.this.mSessionStateCallback;
                if (sessionCallback != null) {
                    sessionCallback.onOpened(CameraDeviceImpl.this);
                }
                CameraDeviceImpl.this.mDeviceCallback.onOpened(CameraDeviceImpl.this);
            }
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.2 */
    class C02242 implements Runnable {
        C02242() {
        }

        public void run() {
            synchronized (CameraDeviceImpl.this.mInterfaceLock) {
                if (CameraDeviceImpl.this.mRemoteDevice == null) {
                    return;
                }
                StateCallbackKK sessionCallback = CameraDeviceImpl.this.mSessionStateCallback;
                if (sessionCallback != null) {
                    sessionCallback.onUnconfigured(CameraDeviceImpl.this);
                }
            }
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.3 */
    class C02253 implements Runnable {
        C02253() {
        }

        public void run() {
            synchronized (CameraDeviceImpl.this.mInterfaceLock) {
                if (CameraDeviceImpl.this.mRemoteDevice == null) {
                    return;
                }
                StateCallbackKK sessionCallback = CameraDeviceImpl.this.mSessionStateCallback;
                if (sessionCallback != null) {
                    sessionCallback.onActive(CameraDeviceImpl.this);
                }
            }
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.4 */
    class C02264 implements Runnable {
        C02264() {
        }

        public void run() {
            synchronized (CameraDeviceImpl.this.mInterfaceLock) {
                if (CameraDeviceImpl.this.mRemoteDevice == null) {
                    return;
                }
                StateCallbackKK sessionCallback = CameraDeviceImpl.this.mSessionStateCallback;
                if (sessionCallback != null) {
                    sessionCallback.onBusy(CameraDeviceImpl.this);
                }
            }
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.5 */
    class C02275 implements Runnable {
        private boolean mClosedOnce;

        C02275() {
            this.mClosedOnce = false;
        }

        public void run() {
            if (this.mClosedOnce) {
                throw new AssertionError("Don't post #onClosed more than once");
            }
            synchronized (CameraDeviceImpl.this.mInterfaceLock) {
                StateCallbackKK sessionCallback = CameraDeviceImpl.this.mSessionStateCallback;
            }
            if (sessionCallback != null) {
                sessionCallback.onClosed(CameraDeviceImpl.this);
            }
            CameraDeviceImpl.this.mDeviceCallback.onClosed(CameraDeviceImpl.this);
            this.mClosedOnce = true;
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.6 */
    class C02286 implements Runnable {
        C02286() {
        }

        public void run() {
            synchronized (CameraDeviceImpl.this.mInterfaceLock) {
                if (CameraDeviceImpl.this.mRemoteDevice == null) {
                    return;
                }
                StateCallbackKK sessionCallback = CameraDeviceImpl.this.mSessionStateCallback;
                if (sessionCallback != null) {
                    sessionCallback.onIdle(CameraDeviceImpl.this);
                }
            }
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.7 */
    class C02297 implements Runnable {
        C02297() {
        }

        public void run() {
            synchronized (CameraDeviceImpl.this.mInterfaceLock) {
                if (CameraDeviceImpl.this.mRemoteDevice == null) {
                    return;
                }
                StateCallbackKK sessionCallback = CameraDeviceImpl.this.mSessionStateCallback;
                if (sessionCallback != null) {
                    sessionCallback.onDisconnected(CameraDeviceImpl.this);
                }
                CameraDeviceImpl.this.mDeviceCallback.onDisconnected(CameraDeviceImpl.this);
            }
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.8 */
    class C02308 implements Runnable {
        final /* synthetic */ int val$code;
        final /* synthetic */ boolean val$isError;

        C02308(boolean z, int i) {
            this.val$isError = z;
            this.val$code = i;
        }

        public void run() {
            if (this.val$isError) {
                CameraDeviceImpl.this.mDeviceCallback.onError(CameraDeviceImpl.this, this.val$code);
            } else {
                CameraDeviceImpl.this.mDeviceCallback.onDisconnected(CameraDeviceImpl.this);
            }
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.9 */
    class C02319 implements Runnable {
        final /* synthetic */ CaptureCallbackHolder val$holder;
        final /* synthetic */ long val$lastFrameNumber;
        final /* synthetic */ int val$requestId;

        C02319(int i, long j, CaptureCallbackHolder captureCallbackHolder) {
            this.val$requestId = i;
            this.val$lastFrameNumber = j;
            this.val$holder = captureCallbackHolder;
        }

        public void run() {
            if (!CameraDeviceImpl.this.isClosed()) {
                if (CameraDeviceImpl.this.DEBUG) {
                    Log.d(CameraDeviceImpl.this.TAG, String.format("early trigger sequence complete for request %d", new Object[]{Integer.valueOf(this.val$requestId)}));
                }
                if (this.val$lastFrameNumber < -2147483648L || this.val$lastFrameNumber > 2147483647L) {
                    throw new AssertionError(this.val$lastFrameNumber + " cannot be cast to int");
                }
                this.val$holder.getCallback().onCaptureSequenceAborted(CameraDeviceImpl.this, this.val$requestId);
            }
        }
    }

    public class CameraDeviceCallbacks extends Stub {
        public static final int ERROR_CAMERA_BUFFER = 5;
        public static final int ERROR_CAMERA_DEVICE = 1;
        public static final int ERROR_CAMERA_DISCONNECTED = 0;
        public static final int ERROR_CAMERA_REQUEST = 3;
        public static final int ERROR_CAMERA_RESULT = 4;
        public static final int ERROR_CAMERA_SERVICE = 2;

        /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.CameraDeviceCallbacks.1 */
        class C02321 implements Runnable {
            final /* synthetic */ int val$errorCode;

            C02321(int i) {
                this.val$errorCode = i;
            }

            public void run() {
                if (!CameraDeviceImpl.this.isClosed()) {
                    CameraDeviceImpl.this.mDeviceCallback.onError(CameraDeviceImpl.this, this.val$errorCode);
                }
            }
        }

        /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.CameraDeviceCallbacks.2 */
        class C02332 implements Runnable {
            final /* synthetic */ long val$frameNumber;
            final /* synthetic */ CaptureCallbackHolder val$holder;
            final /* synthetic */ CaptureResultExtras val$resultExtras;
            final /* synthetic */ long val$timestamp;

            C02332(CaptureCallbackHolder captureCallbackHolder, CaptureResultExtras captureResultExtras, long j, long j2) {
                this.val$holder = captureCallbackHolder;
                this.val$resultExtras = captureResultExtras;
                this.val$timestamp = j;
                this.val$frameNumber = j2;
            }

            public void run() {
                if (!CameraDeviceImpl.this.isClosed()) {
                    this.val$holder.getCallback().onCaptureStarted(CameraDeviceImpl.this, this.val$holder.getRequest(this.val$resultExtras.getSubsequenceId()), this.val$timestamp, this.val$frameNumber);
                }
            }
        }

        /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.CameraDeviceCallbacks.3 */
        class C02343 implements Runnable {
            final /* synthetic */ CaptureCallbackHolder val$holder;
            final /* synthetic */ CaptureRequest val$request;
            final /* synthetic */ CaptureResult val$resultAsCapture;

            C02343(CaptureCallbackHolder captureCallbackHolder, CaptureRequest captureRequest, CaptureResult captureResult) {
                this.val$holder = captureCallbackHolder;
                this.val$request = captureRequest;
                this.val$resultAsCapture = captureResult;
            }

            public void run() {
                if (!CameraDeviceImpl.this.isClosed()) {
                    this.val$holder.getCallback().onCaptureProgressed(CameraDeviceImpl.this, this.val$request, this.val$resultAsCapture);
                }
            }
        }

        /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.CameraDeviceCallbacks.4 */
        class C02354 implements Runnable {
            final /* synthetic */ CaptureCallbackHolder val$holder;
            final /* synthetic */ CaptureRequest val$request;
            final /* synthetic */ TotalCaptureResult val$resultAsCapture;

            C02354(CaptureCallbackHolder captureCallbackHolder, CaptureRequest captureRequest, TotalCaptureResult totalCaptureResult) {
                this.val$holder = captureCallbackHolder;
                this.val$request = captureRequest;
                this.val$resultAsCapture = totalCaptureResult;
            }

            public void run() {
                if (!CameraDeviceImpl.this.isClosed()) {
                    this.val$holder.getCallback().onCaptureCompleted(CameraDeviceImpl.this, this.val$request, this.val$resultAsCapture);
                }
            }
        }

        /* renamed from: android.hardware.camera2.impl.CameraDeviceImpl.CameraDeviceCallbacks.5 */
        class C02365 implements Runnable {
            final /* synthetic */ CaptureFailure val$failure;
            final /* synthetic */ CaptureCallbackHolder val$holder;
            final /* synthetic */ CaptureRequest val$request;

            C02365(CaptureCallbackHolder captureCallbackHolder, CaptureRequest captureRequest, CaptureFailure captureFailure) {
                this.val$holder = captureCallbackHolder;
                this.val$request = captureRequest;
                this.val$failure = captureFailure;
            }

            public void run() {
                if (!CameraDeviceImpl.this.isClosed()) {
                    this.val$holder.getCallback().onCaptureFailed(CameraDeviceImpl.this, this.val$request, this.val$failure);
                }
            }
        }

        public IBinder asBinder() {
            return this;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onDeviceError(int r8, android.hardware.camera2.impl.CaptureResultExtras r9) {
            /*
            r7 = this;
            r6 = 1;
            r1 = android.hardware.camera2.impl.CameraDeviceImpl.this;
            r1 = r1.DEBUG;
            if (r1 == 0) goto L_0x0042;
        L_0x0009:
            r1 = android.hardware.camera2.impl.CameraDeviceImpl.this;
            r1 = r1.TAG;
            r2 = "Device error received, code %d, frame number %d, request ID %d, subseq ID %d";
            r3 = 4;
            r3 = new java.lang.Object[r3];
            r4 = 0;
            r5 = java.lang.Integer.valueOf(r8);
            r3[r4] = r5;
            r4 = r9.getFrameNumber();
            r4 = java.lang.Long.valueOf(r4);
            r3[r6] = r4;
            r4 = 2;
            r5 = r9.getRequestId();
            r5 = java.lang.Integer.valueOf(r5);
            r3[r4] = r5;
            r4 = 3;
            r5 = r9.getSubsequenceId();
            r5 = java.lang.Integer.valueOf(r5);
            r3[r4] = r5;
            r2 = java.lang.String.format(r2, r3);
            android.util.Log.d(r1, r2);
        L_0x0042:
            r1 = android.hardware.camera2.impl.CameraDeviceImpl.this;
            r2 = r1.mInterfaceLock;
            monitor-enter(r2);
            r1 = android.hardware.camera2.impl.CameraDeviceImpl.this;	 Catch:{ all -> 0x0086 }
            r1 = r1.mRemoteDevice;	 Catch:{ all -> 0x0086 }
            if (r1 != 0) goto L_0x0051;
        L_0x004f:
            monitor-exit(r2);	 Catch:{ all -> 0x0086 }
        L_0x0050:
            return;
        L_0x0051:
            switch(r8) {
                case 0: goto L_0x0089;
                case 1: goto L_0x0070;
                case 2: goto L_0x0070;
                case 3: goto L_0x0099;
                case 4: goto L_0x0099;
                case 5: goto L_0x0099;
                default: goto L_0x0054;
            };	 Catch:{ all -> 0x0086 }
        L_0x0054:
            r1 = android.hardware.camera2.impl.CameraDeviceImpl.this;	 Catch:{ all -> 0x0086 }
            r1 = r1.TAG;	 Catch:{ all -> 0x0086 }
            r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0086 }
            r3.<init>();	 Catch:{ all -> 0x0086 }
            r4 = "Unknown error from camera device: ";
            r3 = r3.append(r4);	 Catch:{ all -> 0x0086 }
            r3 = r3.append(r8);	 Catch:{ all -> 0x0086 }
            r3 = r3.toString();	 Catch:{ all -> 0x0086 }
            android.util.Log.e(r1, r3);	 Catch:{ all -> 0x0086 }
        L_0x0070:
            r1 = android.hardware.camera2.impl.CameraDeviceImpl.this;	 Catch:{ all -> 0x0086 }
            r3 = 1;
            r1.mInError = r3;	 Catch:{ all -> 0x0086 }
            r0 = new android.hardware.camera2.impl.CameraDeviceImpl$CameraDeviceCallbacks$1;	 Catch:{ all -> 0x0086 }
            r0.<init>(r8);	 Catch:{ all -> 0x0086 }
            r1 = android.hardware.camera2.impl.CameraDeviceImpl.this;	 Catch:{ all -> 0x0086 }
            r1 = r1.mDeviceHandler;	 Catch:{ all -> 0x0086 }
            r1.post(r0);	 Catch:{ all -> 0x0086 }
        L_0x0084:
            monitor-exit(r2);	 Catch:{ all -> 0x0086 }
            goto L_0x0050;
        L_0x0086:
            r1 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x0086 }
            throw r1;
        L_0x0089:
            r1 = android.hardware.camera2.impl.CameraDeviceImpl.this;	 Catch:{ all -> 0x0086 }
            r1 = r1.mDeviceHandler;	 Catch:{ all -> 0x0086 }
            r3 = android.hardware.camera2.impl.CameraDeviceImpl.this;	 Catch:{ all -> 0x0086 }
            r3 = r3.mCallOnDisconnected;	 Catch:{ all -> 0x0086 }
            r1.post(r3);	 Catch:{ all -> 0x0086 }
            goto L_0x0084;
        L_0x0099:
            r7.onCaptureErrorLocked(r8, r9);	 Catch:{ all -> 0x0086 }
            goto L_0x0084;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.hardware.camera2.impl.CameraDeviceImpl.CameraDeviceCallbacks.onDeviceError(int, android.hardware.camera2.impl.CaptureResultExtras):void");
        }

        public void onDeviceIdle() {
            if (CameraDeviceImpl.this.DEBUG) {
                Log.d(CameraDeviceImpl.this.TAG, "Camera now idle");
            }
            synchronized (CameraDeviceImpl.this.mInterfaceLock) {
                if (CameraDeviceImpl.this.mRemoteDevice == null) {
                    return;
                }
                if (!CameraDeviceImpl.this.mIdle) {
                    CameraDeviceImpl.this.mDeviceHandler.post(CameraDeviceImpl.this.mCallOnIdle);
                }
                CameraDeviceImpl.this.mIdle = true;
            }
        }

        public void onCaptureStarted(CaptureResultExtras resultExtras, long timestamp) {
            int requestId = resultExtras.getRequestId();
            long frameNumber = resultExtras.getFrameNumber();
            if (CameraDeviceImpl.this.DEBUG) {
                Log.d(CameraDeviceImpl.this.TAG, "Capture started for id " + requestId + " frame number " + frameNumber);
            }
            synchronized (CameraDeviceImpl.this.mInterfaceLock) {
                if (CameraDeviceImpl.this.mRemoteDevice == null) {
                    return;
                }
                CaptureCallbackHolder holder = (CaptureCallbackHolder) CameraDeviceImpl.this.mCaptureCallbackMap.get(requestId);
                if (holder == null) {
                } else if (CameraDeviceImpl.this.isClosed()) {
                } else {
                    holder.getHandler().post(new C02332(holder, resultExtras, timestamp, frameNumber));
                }
            }
        }

        public void onResultReceived(CameraMetadataNative result, CaptureResultExtras resultExtras) throws RemoteException {
            int requestId = resultExtras.getRequestId();
            long frameNumber = resultExtras.getFrameNumber();
            if (CameraDeviceImpl.this.DEBUG) {
                Log.v(CameraDeviceImpl.this.TAG, "Received result frame " + frameNumber + " for id " + requestId);
            }
            synchronized (CameraDeviceImpl.this.mInterfaceLock) {
                if (CameraDeviceImpl.this.mRemoteDevice == null) {
                    return;
                }
                result.set(CameraCharacteristics.LENS_INFO_SHADING_MAP_SIZE, CameraDeviceImpl.this.getCharacteristics().get(CameraCharacteristics.LENS_INFO_SHADING_MAP_SIZE));
                CaptureCallbackHolder holder = (CaptureCallbackHolder) CameraDeviceImpl.this.mCaptureCallbackMap.get(requestId);
                boolean isPartialResult = resultExtras.getPartialResultCount() < CameraDeviceImpl.this.mTotalPartialCount;
                if (holder == null) {
                    if (CameraDeviceImpl.this.DEBUG) {
                        Log.d(CameraDeviceImpl.this.TAG, "holder is null, early return at frame " + frameNumber);
                    }
                    CameraDeviceImpl.this.mFrameNumberTracker.updateTracker(frameNumber, null, isPartialResult);
                } else if (CameraDeviceImpl.this.isClosed()) {
                    if (CameraDeviceImpl.this.DEBUG) {
                        Log.d(CameraDeviceImpl.this.TAG, "camera is closed, early return at frame " + frameNumber);
                    }
                    CameraDeviceImpl.this.mFrameNumberTracker.updateTracker(frameNumber, null, isPartialResult);
                } else {
                    Runnable resultDispatch;
                    CaptureResult finalResult;
                    CaptureRequest request = holder.getRequest(resultExtras.getSubsequenceId());
                    CaptureResult resultAsCapture;
                    if (isPartialResult) {
                        resultAsCapture = new CaptureResult(result, request, resultExtras);
                        resultDispatch = new C02343(holder, request, resultAsCapture);
                        finalResult = resultAsCapture;
                    } else {
                        resultAsCapture = new TotalCaptureResult(result, request, resultExtras, CameraDeviceImpl.this.mFrameNumberTracker.popPartialResults(frameNumber));
                        resultDispatch = new C02354(holder, request, resultAsCapture);
                        finalResult = resultAsCapture;
                    }
                    holder.getHandler().post(resultDispatch);
                    CameraDeviceImpl.this.mFrameNumberTracker.updateTracker(frameNumber, finalResult, isPartialResult);
                    if (!isPartialResult) {
                        CameraDeviceImpl.this.checkAndFireSequenceComplete();
                    }
                }
            }
        }

        private void onCaptureErrorLocked(int errorCode, CaptureResultExtras resultExtras) {
            int requestId = resultExtras.getRequestId();
            int subsequenceId = resultExtras.getSubsequenceId();
            long frameNumber = resultExtras.getFrameNumber();
            CaptureCallbackHolder holder = (CaptureCallbackHolder) CameraDeviceImpl.this.mCaptureCallbackMap.get(requestId);
            CaptureRequest request = holder.getRequest(subsequenceId);
            if (errorCode == ERROR_CAMERA_BUFFER) {
                String access$500 = CameraDeviceImpl.this.TAG;
                Object[] objArr = new Object[ERROR_CAMERA_DEVICE];
                objArr[ERROR_CAMERA_DISCONNECTED] = Long.valueOf(frameNumber);
                Log.e(access$500, String.format("Lost output buffer reported for frame %d", objArr));
                return;
            }
            boolean mayHaveBuffers = errorCode == ERROR_CAMERA_RESULT;
            int reason = (CameraDeviceImpl.this.mCurrentSession == null || !CameraDeviceImpl.this.mCurrentSession.isAborting()) ? ERROR_CAMERA_DISCONNECTED : ERROR_CAMERA_DEVICE;
            holder.getHandler().post(new C02365(holder, request, new CaptureFailure(request, reason, mayHaveBuffers, requestId, frameNumber)));
            if (CameraDeviceImpl.this.DEBUG) {
                access$500 = CameraDeviceImpl.this.TAG;
                objArr = new Object[ERROR_CAMERA_DEVICE];
                objArr[ERROR_CAMERA_DISCONNECTED] = Long.valueOf(frameNumber);
                Log.v(access$500, String.format("got error frame %d", objArr));
            }
            CameraDeviceImpl.this.mFrameNumberTracker.updateTracker(frameNumber, true);
            CameraDeviceImpl.this.checkAndFireSequenceComplete();
        }
    }

    static class CaptureCallbackHolder {
        private final CaptureCallback mCallback;
        private final Handler mHandler;
        private final boolean mRepeating;
        private final List<CaptureRequest> mRequestList;

        CaptureCallbackHolder(CaptureCallback callback, List<CaptureRequest> requestList, Handler handler, boolean repeating) {
            if (callback == null || handler == null) {
                throw new UnsupportedOperationException("Must have a valid handler and a valid callback");
            }
            this.mRepeating = repeating;
            this.mHandler = handler;
            this.mRequestList = new ArrayList(requestList);
            this.mCallback = callback;
        }

        public boolean isRepeating() {
            return this.mRepeating;
        }

        public CaptureCallback getCallback() {
            return this.mCallback;
        }

        public CaptureRequest getRequest(int subsequenceId) {
            if (subsequenceId >= this.mRequestList.size()) {
                throw new IllegalArgumentException(String.format("Requested subsequenceId %d is larger than request list size %d.", new Object[]{Integer.valueOf(subsequenceId), Integer.valueOf(this.mRequestList.size())}));
            } else if (subsequenceId >= 0) {
                return (CaptureRequest) this.mRequestList.get(subsequenceId);
            } else {
                throw new IllegalArgumentException(String.format("Requested subsequenceId %d is negative", new Object[]{Integer.valueOf(subsequenceId)}));
            }
        }

        public CaptureRequest getRequest() {
            return getRequest(0);
        }

        public Handler getHandler() {
            return this.mHandler;
        }
    }

    public class FrameNumberTracker {
        private long mCompletedFrameNumber;
        private final TreeSet<Long> mFutureErrorSet;
        private final HashMap<Long, List<CaptureResult>> mPartialResults;

        public FrameNumberTracker() {
            this.mCompletedFrameNumber = -1;
            this.mFutureErrorSet = new TreeSet();
            this.mPartialResults = new HashMap();
        }

        private void update() {
            Iterator<Long> iter = this.mFutureErrorSet.iterator();
            while (iter.hasNext() && ((Long) iter.next()).longValue() == this.mCompletedFrameNumber + 1) {
                this.mCompletedFrameNumber++;
                iter.remove();
            }
        }

        public void updateTracker(long frameNumber, boolean isError) {
            if (isError) {
                this.mFutureErrorSet.add(Long.valueOf(frameNumber));
            } else {
                if (frameNumber != this.mCompletedFrameNumber + 1) {
                    Log.e(CameraDeviceImpl.this.TAG, String.format("result frame number %d comes out of order, should be %d + 1", new Object[]{Long.valueOf(frameNumber), Long.valueOf(this.mCompletedFrameNumber)}));
                }
                this.mCompletedFrameNumber = frameNumber;
            }
            update();
        }

        public void updateTracker(long frameNumber, CaptureResult result, boolean partial) {
            if (!partial) {
                updateTracker(frameNumber, false);
            } else if (result != null) {
                List<CaptureResult> partials = (List) this.mPartialResults.get(Long.valueOf(frameNumber));
                if (partials == null) {
                    partials = new ArrayList();
                    this.mPartialResults.put(Long.valueOf(frameNumber), partials);
                }
                partials.add(result);
            }
        }

        public List<CaptureResult> popPartialResults(long frameNumber) {
            return (List) this.mPartialResults.remove(Long.valueOf(frameNumber));
        }

        public long getCompletedFrameNumber() {
            return this.mCompletedFrameNumber;
        }
    }

    public CameraDeviceImpl(String cameraId, StateCallback callback, Handler handler, CameraCharacteristics characteristics) {
        this.mInterfaceLock = new Object();
        this.mCallbacks = new CameraDeviceCallbacks();
        this.mClosing = false;
        this.mInError = false;
        this.mIdle = true;
        this.mCaptureCallbackMap = new SparseArray();
        this.mRepeatingRequestId = REQUEST_ID_NONE;
        this.mRepeatingRequestIdDeletedList = new ArrayList();
        this.mConfiguredOutputs = new SparseArray();
        this.mFrameNumberRequestPairs = new ArrayList();
        this.mFrameNumberTracker = new FrameNumberTracker();
        this.mNextSessionId = 0;
        this.mCallOnOpened = new C02231();
        this.mCallOnUnconfigured = new C02242();
        this.mCallOnActive = new C02253();
        this.mCallOnBusy = new C02264();
        this.mCallOnClosed = new C02275();
        this.mCallOnIdle = new C02286();
        this.mCallOnDisconnected = new C02297();
        if (cameraId == null || callback == null || handler == null || characteristics == null) {
            throw new IllegalArgumentException("Null argument given");
        }
        this.mCameraId = cameraId;
        this.mDeviceCallback = callback;
        this.mDeviceHandler = handler;
        this.mCharacteristics = characteristics;
        String tag = String.format("CameraDevice-JV-%s", new Object[]{this.mCameraId});
        if (tag.length() > 23) {
            tag = tag.substring(0, 23);
        }
        this.TAG = tag;
        this.DEBUG = Log.isLoggable(this.TAG, 3);
        Integer partialCount = (Integer) this.mCharacteristics.get(CameraCharacteristics.REQUEST_PARTIAL_RESULT_COUNT);
        if (partialCount == null) {
            this.mTotalPartialCount = 1;
        } else {
            this.mTotalPartialCount = partialCount.intValue();
        }
    }

    public CameraDeviceCallbacks getCallbacks() {
        return this.mCallbacks;
    }

    public void setRemoteDevice(ICameraDeviceUser remoteDevice) {
        synchronized (this.mInterfaceLock) {
            if (this.mInError) {
                return;
            }
            this.mRemoteDevice = (ICameraDeviceUser) CameraBinderDecorator.newInstance(remoteDevice);
            this.mDeviceHandler.post(this.mCallOnOpened);
            this.mDeviceHandler.post(this.mCallOnUnconfigured);
        }
    }

    public void setRemoteFailure(CameraRuntimeException failure) {
        int failureCode = 4;
        boolean failureIsError = true;
        switch (failure.getReason()) {
            case Toast.LENGTH_LONG /*1*/:
                failureCode = 3;
                break;
            case Action.MERGE_IGNORE /*2*/:
                failureIsError = false;
                break;
            case SetDrawableParameters.TAG /*3*/:
                failureCode = 4;
                break;
            case ViewGroupAction.TAG /*4*/:
                failureCode = 1;
                break;
            case ReflectionActionWithoutParams.TAG /*5*/:
                failureCode = 2;
                break;
            default:
                Log.wtf(this.TAG, "Unknown failure in opening camera device: " + failure.getReason());
                break;
        }
        int code = failureCode;
        boolean isError = failureIsError;
        synchronized (this.mInterfaceLock) {
            this.mInError = true;
            this.mDeviceHandler.post(new C02308(isError, code));
        }
    }

    public String getId() {
        return this.mCameraId;
    }

    public void configureOutputs(List<Surface> outputs) throws CameraAccessException {
        configureOutputsChecked(outputs);
    }

    public boolean configureOutputsChecked(List<Surface> outputs) throws CameraAccessException {
        if (outputs == null) {
            outputs = new ArrayList();
        }
        synchronized (this.mInterfaceLock) {
            checkIfCameraClosedOrInError();
            HashSet<Surface> addSet = new HashSet(outputs);
            List<Integer> deleteList = new ArrayList();
            for (int i = 0; i < this.mConfiguredOutputs.size(); i++) {
                int streamId = this.mConfiguredOutputs.keyAt(i);
                Surface s = (Surface) this.mConfiguredOutputs.valueAt(i);
                if (outputs.contains(s)) {
                    addSet.remove(s);
                } else {
                    deleteList.add(Integer.valueOf(streamId));
                }
            }
            this.mDeviceHandler.post(this.mCallOnBusy);
            stopRepeating();
            try {
                waitUntilIdle();
                this.mRemoteDevice.beginConfigure();
                for (Integer streamId2 : deleteList) {
                    this.mRemoteDevice.deleteStream(streamId2.intValue());
                    this.mConfiguredOutputs.delete(streamId2.intValue());
                }
                Iterator i$ = addSet.iterator();
                while (i$.hasNext()) {
                    s = (Surface) i$.next();
                    this.mConfiguredOutputs.put(this.mRemoteDevice.createStream(0, 0, 0, s), s);
                }
                try {
                    this.mRemoteDevice.endConfigure();
                    if (1 != null) {
                        if (outputs.size() > 0) {
                            this.mDeviceHandler.post(this.mCallOnIdle);
                        }
                    }
                    this.mDeviceHandler.post(this.mCallOnUnconfigured);
                } catch (IllegalArgumentException e) {
                    Log.w(this.TAG, "Stream configuration failed");
                    if (null != null) {
                        if (outputs.size() > 0) {
                            this.mDeviceHandler.post(this.mCallOnIdle);
                            return false;
                        }
                    }
                    this.mDeviceHandler.post(this.mCallOnUnconfigured);
                    return false;
                }
            } catch (RemoteException e2) {
                if (e2.getReason() == 4) {
                    throw new IllegalStateException("The camera is currently busy. You must wait until the previous operation completes.");
                }
                throw e2.asChecked();
            } catch (RemoteException e3) {
                if (null != null) {
                    if (outputs.size() > 0) {
                        this.mDeviceHandler.post(this.mCallOnIdle);
                        return false;
                    }
                }
                this.mDeviceHandler.post(this.mCallOnUnconfigured);
                return false;
            } catch (Throwable th) {
                if (null != null) {
                    if (outputs.size() > 0) {
                        this.mDeviceHandler.post(this.mCallOnIdle);
                    }
                }
                this.mDeviceHandler.post(this.mCallOnUnconfigured);
            }
        }
        return true;
    }

    public void createCaptureSession(List<Surface> outputs, CameraCaptureSession.StateCallback callback, Handler handler) throws CameraAccessException {
        synchronized (this.mInterfaceLock) {
            boolean configureSuccess;
            if (this.DEBUG) {
                Log.d(this.TAG, "createCaptureSession");
            }
            checkIfCameraClosedOrInError();
            if (this.mCurrentSession != null) {
                this.mCurrentSession.replaceSessionClose();
            }
            CameraAccessException pendingException = null;
            try {
                configureSuccess = configureOutputsChecked(outputs);
            } catch (CameraAccessException e) {
                configureSuccess = false;
                pendingException = e;
                if (this.DEBUG) {
                    Log.v(this.TAG, "createCaptureSession - failed with exception ", e);
                }
            }
            int i = this.mNextSessionId;
            this.mNextSessionId = i + 1;
            this.mCurrentSession = new CameraCaptureSessionImpl(i, outputs, callback, handler, this, this.mDeviceHandler, configureSuccess);
            if (pendingException != null) {
                throw pendingException;
            }
            this.mSessionStateCallback = this.mCurrentSession.getDeviceStateCallback();
        }
    }

    public void setSessionListener(StateCallbackKK sessionCallback) {
        synchronized (this.mInterfaceLock) {
            this.mSessionStateCallback = sessionCallback;
        }
    }

    public Builder createCaptureRequest(int templateType) throws CameraAccessException {
        Builder builder;
        synchronized (this.mInterfaceLock) {
            checkIfCameraClosedOrInError();
            CameraMetadataNative templatedRequest = new CameraMetadataNative();
            try {
                this.mRemoteDevice.createDefaultRequest(templateType, templatedRequest);
                builder = new Builder(templatedRequest);
            } catch (CameraRuntimeException e) {
                throw e.asChecked();
            } catch (RemoteException e2) {
                builder = null;
            }
        }
        return builder;
    }

    public int capture(CaptureRequest request, CaptureCallback callback, Handler handler) throws CameraAccessException {
        if (this.DEBUG) {
            Log.d(this.TAG, "calling capture");
        }
        List<CaptureRequest> requestList = new ArrayList();
        requestList.add(request);
        return submitCaptureRequest(requestList, callback, handler, false);
    }

    public int captureBurst(List<CaptureRequest> requests, CaptureCallback callback, Handler handler) throws CameraAccessException {
        if (requests != null && !requests.isEmpty()) {
            return submitCaptureRequest(requests, callback, handler, false);
        }
        throw new IllegalArgumentException("At least one request must be given");
    }

    private void checkEarlyTriggerSequenceComplete(int requestId, long lastFrameNumber) {
        if (lastFrameNumber == -1) {
            int index = this.mCaptureCallbackMap.indexOfKey(requestId);
            CaptureCallbackHolder holder = index >= 0 ? (CaptureCallbackHolder) this.mCaptureCallbackMap.valueAt(index) : null;
            if (holder != null) {
                this.mCaptureCallbackMap.removeAt(index);
                if (this.DEBUG) {
                    Log.v(this.TAG, String.format("remove holder for requestId %d, because lastFrame is %d.", new Object[]{Integer.valueOf(requestId), Long.valueOf(lastFrameNumber)}));
                }
            }
            if (holder != null) {
                if (this.DEBUG) {
                    Log.v(this.TAG, "immediately trigger onCaptureSequenceAborted because request did not reach HAL");
                }
                holder.getHandler().post(new C02319(requestId, lastFrameNumber, holder));
                return;
            }
            Log.w(this.TAG, String.format("did not register callback to request %d", new Object[]{Integer.valueOf(requestId)}));
            return;
        }
        this.mFrameNumberRequestPairs.add(new SimpleEntry(Long.valueOf(lastFrameNumber), Integer.valueOf(requestId)));
        checkAndFireSequenceComplete();
    }

    private int submitCaptureRequest(List<CaptureRequest> requestList, CaptureCallback callback, Handler handler, boolean repeating) throws CameraAccessException {
        int requestId;
        handler = checkHandler(handler, callback);
        for (CaptureRequest request : requestList) {
            if (request.getTargets().isEmpty()) {
                throw new IllegalArgumentException("Each request must have at least one Surface target");
            }
            for (Surface surface : request.getTargets()) {
                if (surface == null) {
                    throw new IllegalArgumentException("Null Surface targets are not allowed");
                }
            }
        }
        synchronized (this.mInterfaceLock) {
            checkIfCameraClosedOrInError();
            if (repeating) {
                stopRepeating();
            }
            LongParcelable lastFrameNumberRef = new LongParcelable();
            try {
                requestId = this.mRemoteDevice.submitRequestList(requestList, repeating, lastFrameNumberRef);
                if (this.DEBUG) {
                    Log.v(this.TAG, "last frame number " + lastFrameNumberRef.getNumber());
                }
                if (callback != null) {
                    this.mCaptureCallbackMap.put(requestId, new CaptureCallbackHolder(callback, requestList, handler, repeating));
                } else if (this.DEBUG) {
                    Log.d(this.TAG, "Listen for request " + requestId + " is null");
                }
                long lastFrameNumber = lastFrameNumberRef.getNumber();
                if (repeating) {
                    if (this.mRepeatingRequestId != REQUEST_ID_NONE) {
                        checkEarlyTriggerSequenceComplete(this.mRepeatingRequestId, lastFrameNumber);
                    }
                    this.mRepeatingRequestId = requestId;
                } else {
                    this.mFrameNumberRequestPairs.add(new SimpleEntry(Long.valueOf(lastFrameNumber), Integer.valueOf(requestId)));
                }
                if (this.mIdle) {
                    this.mDeviceHandler.post(this.mCallOnActive);
                }
                this.mIdle = false;
            } catch (CameraRuntimeException e) {
                throw e.asChecked();
            } catch (RemoteException e2) {
                requestId = REQUEST_ID_NONE;
            }
        }
        return requestId;
    }

    public int setRepeatingRequest(CaptureRequest request, CaptureCallback callback, Handler handler) throws CameraAccessException {
        List<CaptureRequest> requestList = new ArrayList();
        requestList.add(request);
        return submitCaptureRequest(requestList, callback, handler, true);
    }

    public int setRepeatingBurst(List<CaptureRequest> requests, CaptureCallback callback, Handler handler) throws CameraAccessException {
        if (requests != null && !requests.isEmpty()) {
            return submitCaptureRequest(requests, callback, handler, true);
        }
        throw new IllegalArgumentException("At least one request must be given");
    }

    public void stopRepeating() throws CameraAccessException {
        synchronized (this.mInterfaceLock) {
            checkIfCameraClosedOrInError();
            if (this.mRepeatingRequestId != REQUEST_ID_NONE) {
                int requestId = this.mRepeatingRequestId;
                this.mRepeatingRequestId = REQUEST_ID_NONE;
                if (this.mCaptureCallbackMap.get(requestId) != null) {
                    this.mRepeatingRequestIdDeletedList.add(Integer.valueOf(requestId));
                }
                try {
                    LongParcelable lastFrameNumberRef = new LongParcelable();
                    this.mRemoteDevice.cancelRequest(requestId, lastFrameNumberRef);
                    checkEarlyTriggerSequenceComplete(requestId, lastFrameNumberRef.getNumber());
                } catch (CameraRuntimeException e) {
                    throw e.asChecked();
                } catch (RemoteException e2) {
                    return;
                }
            }
        }
    }

    private void waitUntilIdle() throws CameraAccessException {
        synchronized (this.mInterfaceLock) {
            checkIfCameraClosedOrInError();
            if (this.mRepeatingRequestId != REQUEST_ID_NONE) {
                throw new IllegalStateException("Active repeating request ongoing");
            }
            try {
                this.mRemoteDevice.waitUntilIdle();
            } catch (CameraRuntimeException e) {
                throw e.asChecked();
            } catch (RemoteException e2) {
            }
        }
    }

    public void flush() throws CameraAccessException {
        synchronized (this.mInterfaceLock) {
            checkIfCameraClosedOrInError();
            this.mDeviceHandler.post(this.mCallOnBusy);
            if (this.mIdle) {
                this.mDeviceHandler.post(this.mCallOnIdle);
                return;
            }
            try {
                LongParcelable lastFrameNumberRef = new LongParcelable();
                this.mRemoteDevice.flush(lastFrameNumberRef);
                if (this.mRepeatingRequestId != REQUEST_ID_NONE) {
                    checkEarlyTriggerSequenceComplete(this.mRepeatingRequestId, lastFrameNumberRef.getNumber());
                    this.mRepeatingRequestId = REQUEST_ID_NONE;
                }
            } catch (CameraRuntimeException e) {
                throw e.asChecked();
            } catch (RemoteException e2) {
            }
        }
    }

    public void close() {
        synchronized (this.mInterfaceLock) {
            try {
                if (this.mRemoteDevice != null) {
                    this.mRemoteDevice.disconnect();
                }
            } catch (CameraRuntimeException e) {
                Log.e(this.TAG, "Exception while closing: ", e.asChecked());
            } catch (RemoteException e2) {
            }
            if (this.mRemoteDevice != null || this.mInError) {
                this.mDeviceHandler.post(this.mCallOnClosed);
            }
            this.mRemoteDevice = null;
            this.mInError = false;
        }
    }

    protected void finalize() throws Throwable {
        try {
            close();
        } finally {
            super.finalize();
        }
    }

    private void checkAndFireSequenceComplete() {
        long completedFrameNumber = this.mFrameNumberTracker.getCompletedFrameNumber();
        Iterator<SimpleEntry<Long, Integer>> iter = this.mFrameNumberRequestPairs.iterator();
        while (iter.hasNext()) {
            SimpleEntry<Long, Integer> frameNumberRequestPair = (SimpleEntry) iter.next();
            if (((Long) frameNumberRequestPair.getKey()).longValue() <= completedFrameNumber) {
                int requestId = ((Integer) frameNumberRequestPair.getValue()).intValue();
                synchronized (this.mInterfaceLock) {
                    if (this.mRemoteDevice == null) {
                        Log.w(this.TAG, "Camera closed while checking sequences");
                        return;
                    }
                    int index = this.mCaptureCallbackMap.indexOfKey(requestId);
                    CaptureCallbackHolder holder = index >= 0 ? (CaptureCallbackHolder) this.mCaptureCallbackMap.valueAt(index) : null;
                    if (holder != null) {
                        this.mCaptureCallbackMap.removeAt(index);
                        if (this.DEBUG) {
                            Log.v(this.TAG, String.format("remove holder for requestId %d, because lastFrame %d is <= %d", new Object[]{Integer.valueOf(requestId), frameNumberRequestPair.getKey(), Long.valueOf(completedFrameNumber)}));
                        }
                    }
                    iter.remove();
                    if (holder != null) {
                        holder.getHandler().post(new AnonymousClass10(requestId, frameNumberRequestPair, holder));
                    }
                }
            }
        }
    }

    static Handler checkHandler(Handler handler) {
        if (handler != null) {
            return handler;
        }
        Looper looper = Looper.myLooper();
        if (looper != null) {
            return new Handler(looper);
        }
        throw new IllegalArgumentException("No handler given, and current thread has no looper!");
    }

    static <T> Handler checkHandler(Handler handler, T callback) {
        if (callback != null) {
            return checkHandler(handler);
        }
        return handler;
    }

    private void checkIfCameraClosedOrInError() throws CameraAccessException {
        if (this.mInError) {
            throw new CameraAccessException(3, "The camera device has encountered a serious error");
        } else if (this.mRemoteDevice == null) {
            throw new IllegalStateException("CameraDevice was already closed");
        }
    }

    private boolean isClosed() {
        return this.mClosing;
    }

    private CameraCharacteristics getCharacteristics() {
        return this.mCharacteristics;
    }
}
