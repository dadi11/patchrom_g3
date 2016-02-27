package android.hardware.camera2;

import android.os.Handler;
import java.util.List;

public abstract class CameraCaptureSession implements AutoCloseable {

    public static abstract class CaptureCallback {
        public static final int NO_FRAMES_CAPTURED = -1;

        public void onCaptureStarted(CameraCaptureSession session, CaptureRequest request, long timestamp, long frameNumber) {
            onCaptureStarted(session, request, timestamp);
        }

        public void onCaptureStarted(CameraCaptureSession session, CaptureRequest request, long timestamp) {
        }

        public void onCapturePartial(CameraCaptureSession session, CaptureRequest request, CaptureResult result) {
        }

        public void onCaptureProgressed(CameraCaptureSession session, CaptureRequest request, CaptureResult partialResult) {
        }

        public void onCaptureCompleted(CameraCaptureSession session, CaptureRequest request, TotalCaptureResult result) {
        }

        public void onCaptureFailed(CameraCaptureSession session, CaptureRequest request, CaptureFailure failure) {
        }

        public void onCaptureSequenceCompleted(CameraCaptureSession session, int sequenceId, long frameNumber) {
        }

        public void onCaptureSequenceAborted(CameraCaptureSession session, int sequenceId) {
        }
    }

    public static abstract class CaptureListener extends CaptureCallback {
    }

    public static abstract class StateCallback {
        public abstract void onConfigureFailed(CameraCaptureSession cameraCaptureSession);

        public abstract void onConfigured(CameraCaptureSession cameraCaptureSession);

        public void onReady(CameraCaptureSession session) {
        }

        public void onActive(CameraCaptureSession session) {
        }

        public void onClosed(CameraCaptureSession session) {
        }
    }

    public static abstract class StateListener extends StateCallback {
    }

    public abstract void abortCaptures() throws CameraAccessException;

    public abstract int capture(CaptureRequest captureRequest, CaptureCallback captureCallback, Handler handler) throws CameraAccessException;

    public abstract int captureBurst(List<CaptureRequest> list, CaptureCallback captureCallback, Handler handler) throws CameraAccessException;

    public abstract void close();

    public abstract CameraDevice getDevice();

    public abstract int setRepeatingBurst(List<CaptureRequest> list, CaptureCallback captureCallback, Handler handler) throws CameraAccessException;

    public abstract int setRepeatingRequest(CaptureRequest captureRequest, CaptureCallback captureCallback, Handler handler) throws CameraAccessException;

    public abstract void stopRepeating() throws CameraAccessException;
}
