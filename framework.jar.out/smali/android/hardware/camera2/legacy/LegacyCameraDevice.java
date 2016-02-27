package android.hardware.camera2.legacy;

import android.graphics.ImageFormat;
import android.graphics.SurfaceTexture;
import android.hardware.Camera;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.ICameraDeviceCallbacks;
import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.impl.CaptureResultExtras;
import android.hardware.camera2.legacy.CameraDeviceState.CameraDeviceStateListener;
import android.hardware.camera2.legacy.LegacyExceptionUtils.BufferQueueAbandonedException;
import android.hardware.camera2.params.StreamConfigurationMap;
import android.hardware.camera2.utils.ArrayUtils;
import android.hardware.camera2.utils.CameraRuntimeException;
import android.hardware.camera2.utils.LongParcelable;
import android.os.ConditionVariable;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.RemoteException;
import android.util.Log;
import android.util.Pair;
import android.util.Size;
import android.view.Surface;
import android.widget.Toast;
import com.android.internal.util.Preconditions;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

public class LegacyCameraDevice implements AutoCloseable {
    private static final boolean DEBUG;
    public static final String DEBUG_PROP = "HAL1ShimLogging";
    private static final int GRALLOC_USAGE_HW_COMPOSER = 2048;
    private static final int GRALLOC_USAGE_HW_TEXTURE = 256;
    private static final int GRALLOC_USAGE_HW_VIDEO_ENCODER = 65536;
    private static final int GRALLOC_USAGE_RENDERSCRIPT = 1048576;
    private static final int GRALLOC_USAGE_SW_READ_OFTEN = 3;
    private static final int ILLEGAL_VALUE = -1;
    public static final int MAX_DIMEN_FOR_ROUNDING = 1080;
    private final String TAG;
    private final Handler mCallbackHandler;
    private final HandlerThread mCallbackHandlerThread;
    private final int mCameraId;
    private boolean mClosed;
    private List<Surface> mConfiguredSurfaces;
    private final ICameraDeviceCallbacks mDeviceCallbacks;
    private final CameraDeviceState mDeviceState;
    private final ConditionVariable mIdle;
    private final RequestThreadManager mRequestThreadManager;
    private final Handler mResultHandler;
    private final HandlerThread mResultThread;
    private final CameraDeviceStateListener mStateListener;
    private final CameraCharacteristics mStaticCharacteristics;

    /* renamed from: android.hardware.camera2.legacy.LegacyCameraDevice.1 */
    class C02601 implements CameraDeviceStateListener {

        /* renamed from: android.hardware.camera2.legacy.LegacyCameraDevice.1.1 */
        class C02561 implements Runnable {
            final /* synthetic */ int val$errorCode;
            final /* synthetic */ CaptureResultExtras val$extras;
            final /* synthetic */ RequestHolder val$holder;

            C02561(RequestHolder requestHolder, int i, CaptureResultExtras captureResultExtras) {
                this.val$holder = requestHolder;
                this.val$errorCode = i;
                this.val$extras = captureResultExtras;
            }

            public void run() {
                if (LegacyCameraDevice.DEBUG) {
                    Log.d(LegacyCameraDevice.this.TAG, "doing onError callback for request " + this.val$holder.getRequestId() + ", with error code " + this.val$errorCode);
                }
                try {
                    LegacyCameraDevice.this.mDeviceCallbacks.onDeviceError(this.val$errorCode, this.val$extras);
                } catch (RemoteException e) {
                    throw new IllegalStateException("Received remote exception during onCameraError callback: ", e);
                }
            }
        }

        /* renamed from: android.hardware.camera2.legacy.LegacyCameraDevice.1.2 */
        class C02572 implements Runnable {
            C02572() {
            }

            public void run() {
                if (LegacyCameraDevice.DEBUG) {
                    Log.d(LegacyCameraDevice.this.TAG, "doing onIdle callback.");
                }
                try {
                    LegacyCameraDevice.this.mDeviceCallbacks.onDeviceIdle();
                } catch (RemoteException e) {
                    throw new IllegalStateException("Received remote exception during onCameraIdle callback: ", e);
                }
            }
        }

        /* renamed from: android.hardware.camera2.legacy.LegacyCameraDevice.1.3 */
        class C02583 implements Runnable {
            final /* synthetic */ CaptureResultExtras val$extras;
            final /* synthetic */ RequestHolder val$holder;
            final /* synthetic */ long val$timestamp;

            C02583(RequestHolder requestHolder, CaptureResultExtras captureResultExtras, long j) {
                this.val$holder = requestHolder;
                this.val$extras = captureResultExtras;
                this.val$timestamp = j;
            }

            public void run() {
                if (LegacyCameraDevice.DEBUG) {
                    Log.d(LegacyCameraDevice.this.TAG, "doing onCaptureStarted callback for request " + this.val$holder.getRequestId());
                }
                try {
                    LegacyCameraDevice.this.mDeviceCallbacks.onCaptureStarted(this.val$extras, this.val$timestamp);
                } catch (RemoteException e) {
                    throw new IllegalStateException("Received remote exception during onCameraError callback: ", e);
                }
            }
        }

        /* renamed from: android.hardware.camera2.legacy.LegacyCameraDevice.1.4 */
        class C02594 implements Runnable {
            final /* synthetic */ CaptureResultExtras val$extras;
            final /* synthetic */ RequestHolder val$holder;
            final /* synthetic */ CameraMetadataNative val$result;

            C02594(RequestHolder requestHolder, CameraMetadataNative cameraMetadataNative, CaptureResultExtras captureResultExtras) {
                this.val$holder = requestHolder;
                this.val$result = cameraMetadataNative;
                this.val$extras = captureResultExtras;
            }

            public void run() {
                if (LegacyCameraDevice.DEBUG) {
                    Log.d(LegacyCameraDevice.this.TAG, "doing onCaptureResult callback for request " + this.val$holder.getRequestId());
                }
                try {
                    LegacyCameraDevice.this.mDeviceCallbacks.onResultReceived(this.val$result, this.val$extras);
                } catch (RemoteException e) {
                    throw new IllegalStateException("Received remote exception during onCameraError callback: ", e);
                }
            }
        }

        C02601() {
        }

        public void onError(int errorCode, RequestHolder holder) {
            if (LegacyCameraDevice.DEBUG) {
                Log.d(LegacyCameraDevice.this.TAG, "onError called, errorCode = " + errorCode);
            }
            switch (errorCode) {
                case Toast.LENGTH_SHORT /*0*/:
                case Toast.LENGTH_LONG /*1*/:
                case Action.MERGE_IGNORE /*2*/:
                    LegacyCameraDevice.this.mIdle.open();
                    if (LegacyCameraDevice.DEBUG) {
                        Log.d(LegacyCameraDevice.this.TAG, "onError - opening idle");
                        break;
                    }
                    break;
            }
            LegacyCameraDevice.this.mResultHandler.post(new C02561(holder, errorCode, LegacyCameraDevice.this.getExtrasFromRequest(holder)));
        }

        public void onConfiguring() {
            if (LegacyCameraDevice.DEBUG) {
                Log.d(LegacyCameraDevice.this.TAG, "doing onConfiguring callback.");
            }
        }

        public void onIdle() {
            if (LegacyCameraDevice.DEBUG) {
                Log.d(LegacyCameraDevice.this.TAG, "onIdle called");
            }
            LegacyCameraDevice.this.mIdle.open();
            LegacyCameraDevice.this.mResultHandler.post(new C02572());
        }

        public void onBusy() {
            LegacyCameraDevice.this.mIdle.close();
            if (LegacyCameraDevice.DEBUG) {
                Log.d(LegacyCameraDevice.this.TAG, "onBusy called");
            }
        }

        public void onCaptureStarted(RequestHolder holder, long timestamp) {
            LegacyCameraDevice.this.mResultHandler.post(new C02583(holder, LegacyCameraDevice.this.getExtrasFromRequest(holder), timestamp));
        }

        public void onCaptureResult(CameraMetadataNative result, RequestHolder holder) {
            LegacyCameraDevice.this.mResultHandler.post(new C02594(holder, result, LegacyCameraDevice.this.getExtrasFromRequest(holder)));
        }
    }

    private static native int nativeConfigureSurface(Surface surface, int i, int i2, int i3);

    private static native int nativeDetectSurfaceDimens(Surface surface, int[] iArr);

    private static native int nativeDetectSurfaceType(Surface surface);

    private static native int nativeDetectSurfaceUsageFlags(Surface surface);

    private static native int nativeDetectTextureDimens(SurfaceTexture surfaceTexture, int[] iArr);

    static native int nativeGetJpegFooterSize();

    private static native long nativeGetSurfaceId(Surface surface);

    private static native int nativeProduceFrame(Surface surface, byte[] bArr, int i, int i2, int i3);

    private static native int nativeSetNextTimestamp(Surface surface, long j);

    private static native int nativeSetSurfaceDimens(Surface surface, int i, int i2);

    private static native int nativeSetSurfaceFormat(Surface surface, int i);

    private static native int nativeSetSurfaceOrientation(Surface surface, int i, int i2);

    static {
        DEBUG = Log.isLoggable(DEBUG_PROP, GRALLOC_USAGE_SW_READ_OFTEN);
    }

    private CaptureResultExtras getExtrasFromRequest(RequestHolder holder) {
        if (holder == null) {
            return new CaptureResultExtras(ILLEGAL_VALUE, ILLEGAL_VALUE, ILLEGAL_VALUE, ILLEGAL_VALUE, -1, ILLEGAL_VALUE);
        }
        return new CaptureResultExtras(holder.getRequestId(), holder.getSubsequeceId(), 0, 0, holder.getFrameNumber(), 1);
    }

    static boolean needsConversion(Surface s) throws BufferQueueAbandonedException {
        int nativeType = detectSurfaceType(s);
        return (nativeType == 35 || nativeType == ImageFormat.YV12 || nativeType == 17) ? true : DEBUG;
    }

    public LegacyCameraDevice(int cameraId, Camera camera, CameraCharacteristics characteristics, ICameraDeviceCallbacks callbacks) {
        this.mDeviceState = new CameraDeviceState();
        this.mClosed = DEBUG;
        this.mIdle = new ConditionVariable(true);
        this.mResultThread = new HandlerThread("ResultThread");
        this.mCallbackHandlerThread = new HandlerThread("CallbackThread");
        this.mStateListener = new C02601();
        this.mCameraId = cameraId;
        this.mDeviceCallbacks = callbacks;
        this.TAG = String.format("CameraDevice-%d-LE", new Object[]{Integer.valueOf(this.mCameraId)});
        this.mResultThread.start();
        this.mResultHandler = new Handler(this.mResultThread.getLooper());
        this.mCallbackHandlerThread.start();
        this.mCallbackHandler = new Handler(this.mCallbackHandlerThread.getLooper());
        this.mDeviceState.setCameraDeviceCallbacks(this.mCallbackHandler, this.mStateListener);
        this.mStaticCharacteristics = characteristics;
        this.mRequestThreadManager = new RequestThreadManager(cameraId, camera, characteristics, this.mDeviceState);
        this.mRequestThreadManager.start();
    }

    public int configureOutputs(List<Surface> outputs) {
        List<Pair<Surface, Size>> sizedSurfaces = new ArrayList();
        if (outputs != null) {
            for (Surface output : outputs) {
                if (output == null) {
                    Log.e(this.TAG, "configureOutputs - null outputs are not allowed");
                    return -22;
                }
                StreamConfigurationMap streamConfigurations = (StreamConfigurationMap) this.mStaticCharacteristics.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP);
                try {
                    Size s = getSurfaceSize(output);
                    int surfaceType = detectSurfaceType(output);
                    boolean flexibleConsumer = isFlexibleConsumer(output);
                    Object[] sizes = streamConfigurations.getOutputSizes(surfaceType);
                    if (sizes == null) {
                        if (surfaceType >= 1 && surfaceType <= 5) {
                            sizes = streamConfigurations.getOutputSizes(35);
                        } else if (surfaceType == 33) {
                            sizes = streamConfigurations.getOutputSizes((int) GRALLOC_USAGE_HW_TEXTURE);
                        }
                    }
                    if (ArrayUtils.contains(sizes, (Object) s)) {
                        sizedSurfaces.add(new Pair(output, s));
                    } else {
                        if (flexibleConsumer) {
                            s = findClosestSize(s, sizes);
                            if (s != null) {
                                sizedSurfaces.add(new Pair(output, s));
                            }
                        }
                        String reason = sizes == null ? "format is invalid." : "size not in valid set: " + Arrays.toString(sizes);
                        Log.e(this.TAG, String.format("Surface with size (w=%d, h=%d) and format 0x%x is not valid, %s", new Object[]{Integer.valueOf(s.getWidth()), Integer.valueOf(s.getHeight()), Integer.valueOf(surfaceType), reason}));
                        return -22;
                    }
                } catch (BufferQueueAbandonedException e) {
                    Log.e(this.TAG, "Surface bufferqueue is abandoned, cannot configure as output: ", e);
                    return -22;
                }
            }
        }
        boolean success = DEBUG;
        if (this.mDeviceState.setConfiguring()) {
            this.mRequestThreadManager.configure(sizedSurfaces);
            success = this.mDeviceState.setIdle();
        }
        if (!success) {
            return -38;
        }
        this.mConfiguredSurfaces = outputs != null ? new ArrayList(outputs) : null;
        return 0;
    }

    public int submitRequestList(List<CaptureRequest> requestList, boolean repeating, LongParcelable frameNumber) {
        if (requestList == null || requestList.isEmpty()) {
            Log.e(this.TAG, "submitRequestList - Empty/null requests are not allowed");
            return -22;
        }
        List<Long> surfaceIds;
        if (this.mConfiguredSurfaces == null) {
            surfaceIds = new ArrayList();
        } else {
            surfaceIds = getSurfaceIds(this.mConfiguredSurfaces);
        }
        for (CaptureRequest request : requestList) {
            if (request.getTargets().isEmpty()) {
                Log.e(this.TAG, "submitRequestList - Each request must have at least one Surface target");
                return -22;
            }
            for (Surface surface : request.getTargets()) {
                if (surface == null) {
                    Log.e(this.TAG, "submitRequestList - Null Surface targets are not allowed");
                    return -22;
                } else if (this.mConfiguredSurfaces == null) {
                    Log.e(this.TAG, "submitRequestList - must configure  device with valid surfaces before submitting requests");
                    return -38;
                } else if (!containsSurfaceId(surface, surfaceIds)) {
                    Log.e(this.TAG, "submitRequestList - cannot use a surface that wasn't configured");
                    return -22;
                }
            }
        }
        this.mIdle.close();
        return this.mRequestThreadManager.submitCaptureRequests(requestList, repeating, frameNumber);
    }

    public int submitRequest(CaptureRequest request, boolean repeating, LongParcelable frameNumber) {
        ArrayList<CaptureRequest> requestList = new ArrayList();
        requestList.add(request);
        return submitRequestList(requestList, repeating, frameNumber);
    }

    public long cancelRequest(int requestId) {
        return this.mRequestThreadManager.cancelRepeating(requestId);
    }

    public void waitUntilIdle() {
        this.mIdle.block();
    }

    public long flush() {
        long lastFrame = this.mRequestThreadManager.flush();
        waitUntilIdle();
        return lastFrame;
    }

    public boolean isClosed() {
        return this.mClosed;
    }

    public void close() {
        this.mRequestThreadManager.quit();
        this.mCallbackHandlerThread.quitSafely();
        this.mResultThread.quitSafely();
        try {
            this.mCallbackHandlerThread.join();
        } catch (InterruptedException e) {
            Log.e(this.TAG, String.format("Thread %s (%d) interrupted while quitting.", new Object[]{this.mCallbackHandlerThread.getName(), Long.valueOf(this.mCallbackHandlerThread.getId())}));
        }
        try {
            this.mResultThread.join();
        } catch (InterruptedException e2) {
            Log.e(this.TAG, String.format("Thread %s (%d) interrupted while quitting.", new Object[]{this.mResultThread.getName(), Long.valueOf(this.mResultThread.getId())}));
        }
        this.mClosed = true;
    }

    protected void finalize() throws Throwable {
        try {
            close();
        } catch (CameraRuntimeException e) {
            Log.e(this.TAG, "Got error while trying to finalize, ignoring: " + e.getMessage());
        } finally {
            super.finalize();
        }
    }

    static long findEuclidDistSquare(Size a, Size b) {
        long d0 = (long) (a.getWidth() - b.getWidth());
        long d1 = (long) (a.getHeight() - b.getHeight());
        return (d0 * d0) + (d1 * d1);
    }

    static Size findClosestSize(Size size, Size[] supportedSizes) {
        if (size == null || supportedSizes == null) {
            return null;
        }
        Size bestSize = null;
        for (Size s : supportedSizes) {
            if (s.equals(size)) {
                return size;
            }
            if (s.getWidth() <= MAX_DIMEN_FOR_ROUNDING && (bestSize == null || findEuclidDistSquare(size, s) < findEuclidDistSquare(bestSize, s))) {
                bestSize = s;
            }
        }
        return bestSize;
    }

    public static Size getSurfaceSize(Surface surface) throws BufferQueueAbandonedException {
        Preconditions.checkNotNull(surface);
        int[] dimens = new int[2];
        LegacyExceptionUtils.throwOnError(nativeDetectSurfaceDimens(surface, dimens));
        return new Size(dimens[0], dimens[1]);
    }

    public static boolean isFlexibleConsumer(Surface output) {
        int usageFlags = detectSurfaceUsageFlags(output);
        return ((usageFlags & 1114112) != 0 || (usageFlags & 2307) == 0) ? DEBUG : true;
    }

    static int detectSurfaceUsageFlags(Surface surface) {
        Preconditions.checkNotNull(surface);
        return nativeDetectSurfaceUsageFlags(surface);
    }

    public static int detectSurfaceType(Surface surface) throws BufferQueueAbandonedException {
        Preconditions.checkNotNull(surface);
        return LegacyExceptionUtils.throwOnError(nativeDetectSurfaceType(surface));
    }

    static void configureSurface(Surface surface, int width, int height, int pixelFormat) throws BufferQueueAbandonedException {
        Preconditions.checkNotNull(surface);
        Preconditions.checkArgumentPositive(width, "width must be positive.");
        Preconditions.checkArgumentPositive(height, "height must be positive.");
        LegacyExceptionUtils.throwOnError(nativeConfigureSurface(surface, width, height, pixelFormat));
    }

    static void produceFrame(Surface surface, byte[] pixelBuffer, int width, int height, int pixelFormat) throws BufferQueueAbandonedException {
        Preconditions.checkNotNull(surface);
        Preconditions.checkNotNull(pixelBuffer);
        Preconditions.checkArgumentPositive(width, "width must be positive.");
        Preconditions.checkArgumentPositive(height, "height must be positive.");
        LegacyExceptionUtils.throwOnError(nativeProduceFrame(surface, pixelBuffer, width, height, pixelFormat));
    }

    static void setSurfaceFormat(Surface surface, int pixelFormat) throws BufferQueueAbandonedException {
        Preconditions.checkNotNull(surface);
        LegacyExceptionUtils.throwOnError(nativeSetSurfaceFormat(surface, pixelFormat));
    }

    static void setSurfaceDimens(Surface surface, int width, int height) throws BufferQueueAbandonedException {
        Preconditions.checkNotNull(surface);
        Preconditions.checkArgumentPositive(width, "width must be positive.");
        Preconditions.checkArgumentPositive(height, "height must be positive.");
        LegacyExceptionUtils.throwOnError(nativeSetSurfaceDimens(surface, width, height));
    }

    static long getSurfaceId(Surface surface) {
        Preconditions.checkNotNull(surface);
        return nativeGetSurfaceId(surface);
    }

    static List<Long> getSurfaceIds(Collection<Surface> surfaces) {
        if (surfaces == null) {
            throw new NullPointerException("Null argument surfaces");
        }
        List<Long> surfaceIds = new ArrayList();
        for (Surface s : surfaces) {
            long id = getSurfaceId(s);
            if (id == 0) {
                throw new IllegalStateException("Configured surface had null native GraphicBufferProducer pointer!");
            }
            surfaceIds.add(Long.valueOf(id));
        }
        return surfaceIds;
    }

    static boolean containsSurfaceId(Surface s, Collection<Long> ids) {
        return ids.contains(Long.valueOf(getSurfaceId(s)));
    }

    static void setSurfaceOrientation(Surface surface, int facing, int sensorOrientation) throws BufferQueueAbandonedException {
        Preconditions.checkNotNull(surface);
        LegacyExceptionUtils.throwOnError(nativeSetSurfaceOrientation(surface, facing, sensorOrientation));
    }

    static Size getTextureSize(SurfaceTexture surfaceTexture) throws BufferQueueAbandonedException {
        Preconditions.checkNotNull(surfaceTexture);
        int[] dimens = new int[2];
        LegacyExceptionUtils.throwOnError(nativeDetectTextureDimens(surfaceTexture, dimens));
        return new Size(dimens[0], dimens[1]);
    }

    static void setNextTimestamp(Surface surface, long timestamp) throws BufferQueueAbandonedException {
        Preconditions.checkNotNull(surface);
        LegacyExceptionUtils.throwOnError(nativeSetNextTimestamp(surface, timestamp));
    }
}
