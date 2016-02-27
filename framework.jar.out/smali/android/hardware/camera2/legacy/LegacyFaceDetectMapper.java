package android.hardware.camera2.legacy;

import android.graphics.Rect;
import android.hardware.Camera;
import android.hardware.Camera.Face;
import android.hardware.Camera.FaceDetectionListener;
import android.hardware.Camera.Parameters;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.legacy.ParameterUtils.ZoomData;
import android.hardware.camera2.utils.ListUtils;
import android.hardware.camera2.utils.ParamsUtils;
import android.util.Log;
import android.widget.Toast;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.Preconditions;
import java.util.ArrayList;
import java.util.List;

public class LegacyFaceDetectMapper {
    private static String TAG;
    private static final boolean VERBOSE;
    private final Camera mCamera;
    private boolean mFaceDetectEnabled;
    private boolean mFaceDetectReporting;
    private boolean mFaceDetectScenePriority;
    private final boolean mFaceDetectSupported;
    private Face[] mFaces;
    private Face[] mFacesPrev;
    private final Object mLock;

    /* renamed from: android.hardware.camera2.legacy.LegacyFaceDetectMapper.1 */
    class C02611 implements FaceDetectionListener {
        C02611() {
        }

        public void onFaceDetection(Face[] faces, Camera camera) {
            int lengthFaces = faces == null ? 0 : faces.length;
            synchronized (LegacyFaceDetectMapper.this.mLock) {
                if (LegacyFaceDetectMapper.this.mFaceDetectEnabled) {
                    LegacyFaceDetectMapper.this.mFaces = faces;
                } else if (lengthFaces > 0) {
                    Log.d(LegacyFaceDetectMapper.TAG, "onFaceDetection - Ignored some incoming faces sinceface detection was disabled");
                }
            }
            if (LegacyFaceDetectMapper.VERBOSE) {
                Log.v(LegacyFaceDetectMapper.TAG, "onFaceDetection - read " + lengthFaces + " faces");
            }
        }
    }

    static {
        TAG = "LegacyFaceDetectMapper";
        VERBOSE = Log.isLoggable(TAG, 2);
    }

    public LegacyFaceDetectMapper(Camera camera, CameraCharacteristics characteristics) {
        this.mFaceDetectEnabled = false;
        this.mFaceDetectScenePriority = false;
        this.mFaceDetectReporting = false;
        this.mLock = new Object();
        this.mCamera = (Camera) Preconditions.checkNotNull(camera, "camera must not be null");
        Preconditions.checkNotNull(characteristics, "characteristics must not be null");
        this.mFaceDetectSupported = ArrayUtils.contains((int[]) characteristics.get(CameraCharacteristics.STATISTICS_INFO_AVAILABLE_FACE_DETECT_MODES), 1);
        if (this.mFaceDetectSupported) {
            this.mCamera.setFaceDetectionListener(new C02611());
        }
    }

    public void processFaceDetectMode(CaptureRequest captureRequest, Parameters parameters) {
        boolean z = true;
        Preconditions.checkNotNull(captureRequest, "captureRequest must not be null");
        int fdMode = ((Integer) ParamsUtils.getOrDefault(captureRequest, CaptureRequest.STATISTICS_FACE_DETECT_MODE, Integer.valueOf(0))).intValue();
        if (fdMode == 0 || this.mFaceDetectSupported) {
            int sceneMode = ((Integer) ParamsUtils.getOrDefault(captureRequest, CaptureRequest.CONTROL_SCENE_MODE, Integer.valueOf(0))).intValue();
            if (sceneMode != 1 || this.mFaceDetectSupported) {
                boolean enableFaceDetect;
                switch (fdMode) {
                    case Toast.LENGTH_SHORT /*0*/:
                    case Toast.LENGTH_LONG /*1*/:
                        break;
                    case Action.MERGE_IGNORE /*2*/:
                        Log.w(TAG, "processFaceDetectMode - statistics.faceDetectMode == FULL unsupported, downgrading to SIMPLE");
                        break;
                    default:
                        Log.w(TAG, "processFaceDetectMode - ignoring unknown statistics.faceDetectMode = " + fdMode);
                        return;
                }
                if (fdMode != 0 || sceneMode == 1) {
                    enableFaceDetect = true;
                } else {
                    enableFaceDetect = false;
                }
                synchronized (this.mLock) {
                    if (enableFaceDetect != this.mFaceDetectEnabled) {
                        boolean z2;
                        if (enableFaceDetect) {
                            this.mCamera.startFaceDetection();
                            if (VERBOSE) {
                                Log.v(TAG, "processFaceDetectMode - start face detection");
                            }
                        } else {
                            this.mCamera.stopFaceDetection();
                            if (VERBOSE) {
                                Log.v(TAG, "processFaceDetectMode - stop face detection");
                            }
                            this.mFaces = null;
                        }
                        this.mFaceDetectEnabled = enableFaceDetect;
                        if (sceneMode == 1) {
                            z2 = true;
                        } else {
                            z2 = false;
                        }
                        this.mFaceDetectScenePriority = z2;
                        if (fdMode == 0) {
                            z = false;
                        }
                        this.mFaceDetectReporting = z;
                    }
                }
                return;
            }
            Log.w(TAG, "processFaceDetectMode - ignoring control.sceneMode == FACE_PRIORITY; face detection is not available");
            return;
        }
        Log.w(TAG, "processFaceDetectMode - Ignoring statistics.faceDetectMode; face detection is not available");
    }

    public void mapResultFaces(CameraMetadataNative result, LegacyRequest legacyRequest) {
        int fdMode;
        Preconditions.checkNotNull(result, "result must not be null");
        Preconditions.checkNotNull(legacyRequest, "legacyRequest must not be null");
        synchronized (this.mLock) {
            Face[] faces;
            fdMode = this.mFaceDetectReporting ? 1 : 0;
            if (this.mFaceDetectReporting) {
                faces = this.mFaces;
            } else {
                faces = null;
            }
            boolean fdScenePriority = this.mFaceDetectScenePriority;
            Face[] previousFaces = this.mFacesPrev;
            this.mFacesPrev = faces;
        }
        CameraCharacteristics characteristics = legacyRequest.characteristics;
        Rect activeArray = (Rect) characteristics.get(CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE);
        ZoomData zoomData = ParameterUtils.convertScalerCropRegion(activeArray, (Rect) legacyRequest.captureRequest.get(CaptureRequest.SCALER_CROP_REGION), legacyRequest.previewSize, legacyRequest.parameters);
        List<android.hardware.camera2.params.Face> convertedFaces = new ArrayList();
        if (faces != null) {
            for (Face face : faces) {
                if (face != null) {
                    convertedFaces.add(ParameterUtils.convertFaceFromLegacy(face, activeArray, zoomData));
                } else {
                    Log.w(TAG, "mapResultFaces - read NULL face from camera1 device");
                }
            }
        }
        if (VERBOSE && previousFaces != faces) {
            Log.v(TAG, "mapResultFaces - changed to " + ListUtils.listToString(convertedFaces));
        }
        result.set(CaptureResult.STATISTICS_FACES, convertedFaces.toArray(new android.hardware.camera2.params.Face[0]));
        result.set(CaptureResult.STATISTICS_FACE_DETECT_MODE, Integer.valueOf(fdMode));
        if (fdScenePriority) {
            result.set(CaptureResult.CONTROL_SCENE_MODE, Integer.valueOf(1));
        }
    }
}
