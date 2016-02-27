package android.hardware.camera2.legacy;

import android.hardware.Camera;
import android.hardware.Camera.CameraInfo;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.ICameraDeviceCallbacks;
import android.hardware.camera2.ICameraDeviceUser;
import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.impl.CaptureResultExtras;
import android.hardware.camera2.utils.CameraBinderDecorator;
import android.hardware.camera2.utils.CameraRuntimeException;
import android.hardware.camera2.utils.LongParcelable;
import android.os.ConditionVariable;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.util.Log;
import android.util.SparseArray;
import android.view.Surface;
import android.webkit.WebViewClient;
import android.widget.ExpandableListView;
import java.util.ArrayList;
import java.util.List;

public class CameraDeviceUserShim implements ICameraDeviceUser {
    private static final boolean DEBUG;
    private static final int OPEN_CAMERA_TIMEOUT_MS = 5000;
    private static final String TAG = "CameraDeviceUserShim";
    private final CameraCallbackThread mCameraCallbacks;
    private final CameraCharacteristics mCameraCharacteristics;
    private final CameraLooper mCameraInit;
    private final Object mConfigureLock;
    private boolean mConfiguring;
    private final LegacyCameraDevice mLegacyDevice;
    private int mSurfaceIdCounter;
    private final SparseArray<Surface> mSurfaces;

    private static class CameraCallbackThread implements ICameraDeviceCallbacks {
        private static final int CAMERA_ERROR = 0;
        private static final int CAMERA_IDLE = 1;
        private static final int CAPTURE_STARTED = 2;
        private static final int RESULT_RECEIVED = 3;
        private final ICameraDeviceCallbacks mCallbacks;
        private Handler mHandler;
        private final HandlerThread mHandlerThread;

        private class CallbackHandler extends Handler {
            public CallbackHandler(Looper l) {
                super(l);
            }

            public void handleMessage(Message msg) {
                try {
                    switch (msg.what) {
                        case CameraCallbackThread.CAMERA_ERROR /*0*/:
                            CameraCallbackThread.this.mCallbacks.onDeviceError(msg.arg1, msg.obj);
                            return;
                        case CameraCallbackThread.CAMERA_IDLE /*1*/:
                            CameraCallbackThread.this.mCallbacks.onDeviceIdle();
                            return;
                        case CameraCallbackThread.CAPTURE_STARTED /*2*/:
                            CaptureResultExtras resultExtras = (CaptureResultExtras) msg.obj;
                            CameraCallbackThread.this.mCallbacks.onCaptureStarted(resultExtras, ((((long) msg.arg2) & ExpandableListView.PACKED_POSITION_VALUE_NULL) << 32) | (((long) msg.arg1) & ExpandableListView.PACKED_POSITION_VALUE_NULL));
                            return;
                        case CameraCallbackThread.RESULT_RECEIVED /*3*/:
                            Object[] resultArray = (Object[]) msg.obj;
                            CameraCallbackThread.this.mCallbacks.onResultReceived(resultArray[CameraCallbackThread.CAMERA_ERROR], (CaptureResultExtras) resultArray[CameraCallbackThread.CAMERA_IDLE]);
                            return;
                        default:
                            throw new IllegalArgumentException("Unknown callback message " + msg.what);
                    }
                } catch (RemoteException e) {
                    throw new IllegalStateException("Received remote exception during camera callback " + msg.what, e);
                }
                throw new IllegalStateException("Received remote exception during camera callback " + msg.what, e);
            }
        }

        public CameraCallbackThread(ICameraDeviceCallbacks callbacks) {
            this.mCallbacks = callbacks;
            this.mHandlerThread = new HandlerThread("LegacyCameraCallback");
            this.mHandlerThread.start();
        }

        public void close() {
            this.mHandlerThread.quitSafely();
        }

        public void onDeviceError(int errorCode, CaptureResultExtras resultExtras) {
            getHandler().sendMessage(getHandler().obtainMessage(CAMERA_ERROR, errorCode, CAMERA_ERROR, resultExtras));
        }

        public void onDeviceIdle() {
            getHandler().sendMessage(getHandler().obtainMessage(CAMERA_IDLE));
        }

        public void onCaptureStarted(CaptureResultExtras resultExtras, long timestamp) {
            getHandler().sendMessage(getHandler().obtainMessage(CAPTURE_STARTED, (int) (timestamp & ExpandableListView.PACKED_POSITION_VALUE_NULL), (int) ((timestamp >> 32) & ExpandableListView.PACKED_POSITION_VALUE_NULL), resultExtras));
        }

        public void onResultReceived(CameraMetadataNative result, CaptureResultExtras resultExtras) {
            Object[] resultArray = new Object[CAPTURE_STARTED];
            resultArray[CAMERA_ERROR] = result;
            resultArray[CAMERA_IDLE] = resultExtras;
            getHandler().sendMessage(getHandler().obtainMessage(RESULT_RECEIVED, resultArray));
        }

        public IBinder asBinder() {
            return null;
        }

        private Handler getHandler() {
            if (this.mHandler == null) {
                this.mHandler = new CallbackHandler(this.mHandlerThread.getLooper());
            }
            return this.mHandler;
        }
    }

    private static class CameraLooper implements Runnable, AutoCloseable {
        private final Camera mCamera;
        private final int mCameraId;
        private volatile int mInitErrors;
        private Looper mLooper;
        private final ConditionVariable mStartDone;
        private final Thread mThread;

        public CameraLooper(int cameraId) {
            this.mCamera = Camera.openUninitialized();
            this.mStartDone = new ConditionVariable();
            this.mCameraId = cameraId;
            this.mThread = new Thread(this);
            this.mThread.start();
        }

        public Camera getCamera() {
            return this.mCamera;
        }

        public void run() {
            Looper.prepare();
            this.mLooper = Looper.myLooper();
            this.mInitErrors = CameraDeviceUserShim.translateErrorsFromCamera1(this.mCamera.cameraInitUnspecified(this.mCameraId));
            this.mStartDone.open();
            Looper.loop();
        }

        public void close() {
            if (this.mLooper != null) {
                this.mLooper.quitSafely();
                try {
                    this.mThread.join();
                    this.mLooper = null;
                } catch (InterruptedException e) {
                    throw new AssertionError(e);
                }
            }
        }

        public int waitForOpen(int timeoutMs) {
            if (this.mStartDone.block((long) timeoutMs)) {
                return this.mInitErrors;
            }
            Log.e(CameraDeviceUserShim.TAG, "waitForOpen - Camera failed to open after timeout of 5000 ms");
            try {
                this.mCamera.release();
            } catch (RuntimeException e) {
                Log.e(CameraDeviceUserShim.TAG, "connectBinderShim - Failed to release camera after timeout ", e);
            }
            throw new CameraRuntimeException(3);
        }
    }

    static {
        DEBUG = Log.isLoggable(LegacyCameraDevice.DEBUG_PROP, 3);
    }

    protected CameraDeviceUserShim(int cameraId, LegacyCameraDevice legacyCamera, CameraCharacteristics characteristics, CameraLooper cameraInit, CameraCallbackThread cameraCallbacks) {
        this.mConfigureLock = new Object();
        this.mLegacyDevice = legacyCamera;
        this.mConfiguring = DEBUG;
        this.mSurfaces = new SparseArray();
        this.mCameraCharacteristics = characteristics;
        this.mCameraInit = cameraInit;
        this.mCameraCallbacks = cameraCallbacks;
        this.mSurfaceIdCounter = 0;
    }

    private static int translateErrorsFromCamera1(int errorCode) {
        switch (errorCode) {
            case WebViewClient.ERROR_FILE /*-13*/:
                return -1;
            default:
                return errorCode;
        }
    }

    public static CameraDeviceUserShim connectBinderShim(ICameraDeviceCallbacks callbacks, int cameraId) {
        if (DEBUG) {
            Log.d(TAG, "Opening shim Camera device");
        }
        CameraLooper init = new CameraLooper(cameraId);
        CameraCallbackThread threadCallbacks = new CameraCallbackThread(callbacks);
        int initErrors = init.waitForOpen(OPEN_CAMERA_TIMEOUT_MS);
        Camera legacyCamera = init.getCamera();
        CameraBinderDecorator.throwOnError(initErrors);
        legacyCamera.disableShutterSound();
        CameraInfo info = new CameraInfo();
        Camera.getCameraInfo(cameraId, info);
        try {
            CameraCharacteristics characteristics = LegacyMetadataMapper.createCharacteristics(legacyCamera.getParameters(), info);
            return new CameraDeviceUserShim(cameraId, new LegacyCameraDevice(cameraId, legacyCamera, characteristics, threadCallbacks), characteristics, init, threadCallbacks);
        } catch (RuntimeException e) {
            throw new CameraRuntimeException(3, "Unable to get initial parameters", e);
        }
    }

    public void disconnect() {
        if (DEBUG) {
            Log.d(TAG, "disconnect called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.w(TAG, "Cannot disconnect, device has already been closed.");
        }
        try {
            this.mLegacyDevice.close();
        } finally {
            this.mCameraInit.close();
            this.mCameraCallbacks.close();
        }
    }

    public int submitRequest(CaptureRequest request, boolean streaming, LongParcelable lastFrameNumber) {
        if (DEBUG) {
            Log.d(TAG, "submitRequest called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.e(TAG, "Cannot submit request, device has been closed.");
            return -19;
        }
        synchronized (this.mConfigureLock) {
            if (this.mConfiguring) {
                Log.e(TAG, "Cannot submit request, configuration change in progress.");
                return -38;
            }
            return this.mLegacyDevice.submitRequest(request, streaming, lastFrameNumber);
        }
    }

    public int submitRequestList(List<CaptureRequest> request, boolean streaming, LongParcelable lastFrameNumber) {
        if (DEBUG) {
            Log.d(TAG, "submitRequestList called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.e(TAG, "Cannot submit request list, device has been closed.");
            return -19;
        }
        synchronized (this.mConfigureLock) {
            if (this.mConfiguring) {
                Log.e(TAG, "Cannot submit request, configuration change in progress.");
                return -38;
            }
            return this.mLegacyDevice.submitRequestList(request, streaming, lastFrameNumber);
        }
    }

    public int cancelRequest(int requestId, LongParcelable lastFrameNumber) {
        if (DEBUG) {
            Log.d(TAG, "cancelRequest called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.e(TAG, "Cannot cancel request, device has been closed.");
            return -19;
        }
        synchronized (this.mConfigureLock) {
            if (this.mConfiguring) {
                Log.e(TAG, "Cannot cancel request, configuration change in progress.");
                return -38;
            }
            lastFrameNumber.setNumber(this.mLegacyDevice.cancelRequest(requestId));
            return 0;
        }
    }

    public int beginConfigure() {
        if (DEBUG) {
            Log.d(TAG, "beginConfigure called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.e(TAG, "Cannot begin configure, device has been closed.");
            return -19;
        }
        synchronized (this.mConfigureLock) {
            if (this.mConfiguring) {
                Log.e(TAG, "Cannot begin configure, configuration change already in progress.");
                return -38;
            }
            this.mConfiguring = true;
            return 0;
        }
    }

    public int endConfigure() {
        Throwable th;
        if (DEBUG) {
            Log.d(TAG, "endConfigure called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.e(TAG, "Cannot end configure, device has been closed.");
            return -19;
        }
        ArrayList<Surface> surfaces = null;
        synchronized (this.mConfigureLock) {
            try {
                if (this.mConfiguring) {
                    int numSurfaces = this.mSurfaces.size();
                    if (numSurfaces > 0) {
                        ArrayList<Surface> surfaces2 = new ArrayList();
                        int i = 0;
                        while (i < numSurfaces) {
                            try {
                                surfaces2.add(this.mSurfaces.valueAt(i));
                                i++;
                            } catch (Throwable th2) {
                                th = th2;
                                surfaces = surfaces2;
                            }
                        }
                        surfaces = surfaces2;
                    }
                    this.mConfiguring = DEBUG;
                    return this.mLegacyDevice.configureOutputs(surfaces);
                }
                Log.e(TAG, "Cannot end configure, no configuration change in progress.");
                return -38;
            } catch (Throwable th3) {
                th = th3;
                throw th;
            }
        }
    }

    public int deleteStream(int streamId) {
        if (DEBUG) {
            Log.d(TAG, "deleteStream called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.e(TAG, "Cannot delete stream, device has been closed.");
            return -19;
        }
        synchronized (this.mConfigureLock) {
            if (this.mConfiguring) {
                int index = this.mSurfaces.indexOfKey(streamId);
                if (index < 0) {
                    Log.e(TAG, "Cannot delete stream, stream id " + streamId + " doesn't exist.");
                    return -22;
                }
                this.mSurfaces.removeAt(index);
                return 0;
            }
            Log.e(TAG, "Cannot delete stream, beginConfigure hasn't been called yet.");
            return -38;
        }
    }

    public int createStream(int width, int height, int format, Surface surface) {
        if (DEBUG) {
            Log.d(TAG, "createStream called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.e(TAG, "Cannot create stream, device has been closed.");
            return -19;
        }
        synchronized (this.mConfigureLock) {
            if (this.mConfiguring) {
                int id = this.mSurfaceIdCounter + 1;
                this.mSurfaceIdCounter = id;
                this.mSurfaces.put(id, surface);
                return id;
            }
            Log.e(TAG, "Cannot create stream, beginConfigure hasn't been called yet.");
            return -38;
        }
    }

    public int createDefaultRequest(int templateId, CameraMetadataNative request) {
        if (DEBUG) {
            Log.d(TAG, "createDefaultRequest called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.e(TAG, "Cannot create default request, device has been closed.");
            return -19;
        }
        try {
            request.swap(LegacyMetadataMapper.createRequestTemplate(this.mCameraCharacteristics, templateId));
            return 0;
        } catch (IllegalArgumentException e) {
            Log.e(TAG, "createDefaultRequest - invalid templateId specified");
            return -22;
        }
    }

    public int getCameraInfo(CameraMetadataNative info) {
        if (DEBUG) {
            Log.d(TAG, "getCameraInfo called.");
        }
        Log.e(TAG, "getCameraInfo unimplemented.");
        return 0;
    }

    public int waitUntilIdle() throws RemoteException {
        if (DEBUG) {
            Log.d(TAG, "waitUntilIdle called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.e(TAG, "Cannot wait until idle, device has been closed.");
            return -19;
        }
        synchronized (this.mConfigureLock) {
            if (this.mConfiguring) {
                Log.e(TAG, "Cannot wait until idle, configuration change in progress.");
                return -38;
            }
            this.mLegacyDevice.waitUntilIdle();
            return 0;
        }
    }

    public int flush(LongParcelable lastFrameNumber) {
        if (DEBUG) {
            Log.d(TAG, "flush called.");
        }
        if (this.mLegacyDevice.isClosed()) {
            Log.e(TAG, "Cannot flush, device has been closed.");
            return -19;
        }
        synchronized (this.mConfigureLock) {
            if (this.mConfiguring) {
                Log.e(TAG, "Cannot flush, configuration change in progress.");
                return -38;
            }
            long lastFrame = this.mLegacyDevice.flush();
            if (lastFrameNumber != null) {
                lastFrameNumber.setNumber(lastFrame);
            }
            return 0;
        }
    }

    public IBinder asBinder() {
        return null;
    }
}
