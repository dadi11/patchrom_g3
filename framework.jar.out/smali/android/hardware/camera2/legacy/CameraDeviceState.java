package android.hardware.camera2.legacy;

import android.hardware.camera2.impl.CameraMetadataNative;
import android.os.Handler;
import android.util.Log;

public class CameraDeviceState {
    private static final boolean DEBUG;
    public static final int NO_CAPTURE_ERROR = -1;
    private static final int STATE_CAPTURING = 4;
    private static final int STATE_CONFIGURING = 2;
    private static final int STATE_ERROR = 0;
    private static final int STATE_IDLE = 3;
    private static final int STATE_UNCONFIGURED = 1;
    private static final String TAG = "CameraDeviceState";
    private static final String[] sStateNames;
    private int mCurrentError;
    private Handler mCurrentHandler;
    private CameraDeviceStateListener mCurrentListener;
    private RequestHolder mCurrentRequest;
    private int mCurrentState;

    /* renamed from: android.hardware.camera2.legacy.CameraDeviceState.1 */
    class C02471 implements Runnable {
        final /* synthetic */ int val$captureError;
        final /* synthetic */ RequestHolder val$request;

        C02471(int i, RequestHolder requestHolder) {
            this.val$captureError = i;
            this.val$request = requestHolder;
        }

        public void run() {
            CameraDeviceState.this.mCurrentListener.onError(this.val$captureError, this.val$request);
        }
    }

    /* renamed from: android.hardware.camera2.legacy.CameraDeviceState.2 */
    class C02482 implements Runnable {
        final /* synthetic */ RequestHolder val$request;
        final /* synthetic */ CameraMetadataNative val$result;

        C02482(CameraMetadataNative cameraMetadataNative, RequestHolder requestHolder) {
            this.val$result = cameraMetadataNative;
            this.val$request = requestHolder;
        }

        public void run() {
            CameraDeviceState.this.mCurrentListener.onCaptureResult(this.val$result, this.val$request);
        }
    }

    /* renamed from: android.hardware.camera2.legacy.CameraDeviceState.3 */
    class C02493 implements Runnable {
        C02493() {
        }

        public void run() {
            CameraDeviceState.this.mCurrentListener.onBusy();
        }
    }

    /* renamed from: android.hardware.camera2.legacy.CameraDeviceState.4 */
    class C02504 implements Runnable {
        C02504() {
        }

        public void run() {
            CameraDeviceState.this.mCurrentListener.onError(CameraDeviceState.this.mCurrentError, CameraDeviceState.this.mCurrentRequest);
        }
    }

    /* renamed from: android.hardware.camera2.legacy.CameraDeviceState.5 */
    class C02515 implements Runnable {
        C02515() {
        }

        public void run() {
            CameraDeviceState.this.mCurrentListener.onConfiguring();
        }
    }

    /* renamed from: android.hardware.camera2.legacy.CameraDeviceState.6 */
    class C02526 implements Runnable {
        C02526() {
        }

        public void run() {
            CameraDeviceState.this.mCurrentListener.onIdle();
        }
    }

    /* renamed from: android.hardware.camera2.legacy.CameraDeviceState.7 */
    class C02537 implements Runnable {
        final /* synthetic */ int val$error;

        C02537(int i) {
            this.val$error = i;
        }

        public void run() {
            CameraDeviceState.this.mCurrentListener.onError(this.val$error, CameraDeviceState.this.mCurrentRequest);
        }
    }

    /* renamed from: android.hardware.camera2.legacy.CameraDeviceState.8 */
    class C02548 implements Runnable {
        final /* synthetic */ long val$timestamp;

        C02548(long j) {
            this.val$timestamp = j;
        }

        public void run() {
            CameraDeviceState.this.mCurrentListener.onCaptureStarted(CameraDeviceState.this.mCurrentRequest, this.val$timestamp);
        }
    }

    public interface CameraDeviceStateListener {
        void onBusy();

        void onCaptureResult(CameraMetadataNative cameraMetadataNative, RequestHolder requestHolder);

        void onCaptureStarted(RequestHolder requestHolder, long j);

        void onConfiguring();

        void onError(int i, RequestHolder requestHolder);

        void onIdle();
    }

    public CameraDeviceState() {
        this.mCurrentState = STATE_UNCONFIGURED;
        this.mCurrentError = NO_CAPTURE_ERROR;
        this.mCurrentRequest = null;
        this.mCurrentHandler = null;
        this.mCurrentListener = null;
    }

    static {
        DEBUG = Log.isLoggable(LegacyCameraDevice.DEBUG_PROP, STATE_IDLE);
        sStateNames = new String[]{"ERROR", "UNCONFIGURED", "CONFIGURING", "IDLE", "CAPTURING"};
    }

    public synchronized void setError(int error) {
        this.mCurrentError = error;
        doStateTransition(STATE_ERROR);
    }

    public synchronized boolean setConfiguring() {
        doStateTransition(STATE_CONFIGURING);
        return this.mCurrentError == NO_CAPTURE_ERROR ? true : DEBUG;
    }

    public synchronized boolean setIdle() {
        doStateTransition(STATE_IDLE);
        return this.mCurrentError == NO_CAPTURE_ERROR ? true : DEBUG;
    }

    public synchronized boolean setCaptureStart(RequestHolder request, long timestamp, int captureError) {
        this.mCurrentRequest = request;
        doStateTransition(STATE_CAPTURING, timestamp, captureError);
        return this.mCurrentError == NO_CAPTURE_ERROR ? true : DEBUG;
    }

    public synchronized boolean setCaptureResult(RequestHolder request, CameraMetadataNative result, int captureError) {
        boolean z = true;
        synchronized (this) {
            if (this.mCurrentState != STATE_CAPTURING) {
                Log.e(TAG, "Cannot receive result while in state: " + this.mCurrentState);
                this.mCurrentError = STATE_UNCONFIGURED;
                doStateTransition(STATE_ERROR);
                if (this.mCurrentError != NO_CAPTURE_ERROR) {
                    z = DEBUG;
                }
            } else {
                if (!(this.mCurrentHandler == null || this.mCurrentListener == null)) {
                    if (captureError != NO_CAPTURE_ERROR) {
                        this.mCurrentHandler.post(new C02471(captureError, request));
                    } else {
                        this.mCurrentHandler.post(new C02482(result, request));
                    }
                }
                if (this.mCurrentError != NO_CAPTURE_ERROR) {
                    z = DEBUG;
                }
            }
        }
        return z;
    }

    public synchronized void setCameraDeviceCallbacks(Handler handler, CameraDeviceStateListener listener) {
        this.mCurrentHandler = handler;
        this.mCurrentListener = listener;
    }

    private void doStateTransition(int newState) {
        doStateTransition(newState, 0, NO_CAPTURE_ERROR);
    }

    private void doStateTransition(int newState, long timestamp, int error) {
        if (newState != this.mCurrentState) {
            String stateName = "UNKNOWN";
            if (newState >= 0 && newState < sStateNames.length) {
                stateName = sStateNames[newState];
            }
            Log.i(TAG, "Legacy camera service transitioning to state " + stateName);
        }
        if (!(newState == 0 || newState == STATE_IDLE || this.mCurrentState == newState || this.mCurrentHandler == null || this.mCurrentListener == null)) {
            this.mCurrentHandler.post(new C02493());
        }
        switch (newState) {
            case STATE_ERROR /*0*/:
                if (!(this.mCurrentState == 0 || this.mCurrentHandler == null || this.mCurrentListener == null)) {
                    this.mCurrentHandler.post(new C02504());
                }
                this.mCurrentState = STATE_ERROR;
            case STATE_CONFIGURING /*2*/:
                if (this.mCurrentState == STATE_UNCONFIGURED || this.mCurrentState == STATE_IDLE) {
                    if (!(this.mCurrentState == STATE_CONFIGURING || this.mCurrentHandler == null || this.mCurrentListener == null)) {
                        this.mCurrentHandler.post(new C02515());
                    }
                    this.mCurrentState = STATE_CONFIGURING;
                    return;
                }
                Log.e(TAG, "Cannot call configure while in state: " + this.mCurrentState);
                this.mCurrentError = STATE_UNCONFIGURED;
                doStateTransition(STATE_ERROR);
            case STATE_IDLE /*3*/:
                if (this.mCurrentState == STATE_IDLE) {
                    return;
                }
                if (this.mCurrentState == STATE_CONFIGURING || this.mCurrentState == STATE_CAPTURING) {
                    if (!(this.mCurrentState == STATE_IDLE || this.mCurrentHandler == null || this.mCurrentListener == null)) {
                        this.mCurrentHandler.post(new C02526());
                    }
                    this.mCurrentState = STATE_IDLE;
                    return;
                }
                Log.e(TAG, "Cannot call idle while in state: " + this.mCurrentState);
                this.mCurrentError = STATE_UNCONFIGURED;
                doStateTransition(STATE_ERROR);
            case STATE_CAPTURING /*4*/:
                if (this.mCurrentState == STATE_IDLE || this.mCurrentState == STATE_CAPTURING) {
                    if (!(this.mCurrentHandler == null || this.mCurrentListener == null)) {
                        if (error != NO_CAPTURE_ERROR) {
                            this.mCurrentHandler.post(new C02537(error));
                        } else {
                            this.mCurrentHandler.post(new C02548(timestamp));
                        }
                    }
                    this.mCurrentState = STATE_CAPTURING;
                    return;
                }
                Log.e(TAG, "Cannot call capture while in state: " + this.mCurrentState);
                this.mCurrentError = STATE_UNCONFIGURED;
                doStateTransition(STATE_ERROR);
            default:
                throw new IllegalStateException("Transition to unknown state: " + newState);
        }
    }
}
