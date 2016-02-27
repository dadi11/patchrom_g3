package android.hardware.camera2.legacy;

import android.graphics.ImageFormat;
import android.graphics.Rect;
import android.hardware.Camera;
import android.hardware.Camera.CameraInfo;
import android.hardware.Camera.Parameters;
import android.hardware.Camera.Size;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraCharacteristics.Key;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.params.MeteringRectangle;
import android.hardware.camera2.params.StreamConfiguration;
import android.hardware.camera2.params.StreamConfigurationDuration;
import android.hardware.camera2.utils.ArrayUtils;
import android.hardware.camera2.utils.ListUtils;
import android.hardware.camera2.utils.ParamsUtils;
import android.hardware.camera2.utils.SizeAreaComparator;
import android.net.wifi.WifiEnterpriseConfig;
import android.util.Log;
import android.util.Range;
import android.util.SizeF;
import com.android.internal.util.Preconditions;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class LegacyMetadataMapper {
    private static final long APPROXIMATE_CAPTURE_DELAY_MS = 200;
    private static final long APPROXIMATE_JPEG_ENCODE_TIME_MS = 600;
    private static final long APPROXIMATE_SENSOR_AREA_PX = 8388608;
    public static final int HAL_PIXEL_FORMAT_BGRA_8888 = 5;
    public static final int HAL_PIXEL_FORMAT_BLOB = 33;
    public static final int HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED = 34;
    public static final int HAL_PIXEL_FORMAT_RGBA_8888 = 1;
    private static final float LENS_INFO_MINIMUM_FOCUS_DISTANCE_FIXED_FOCUS = 0.0f;
    static final boolean LIE_ABOUT_AE_MAX_REGIONS = false;
    static final boolean LIE_ABOUT_AE_STATE = false;
    static final boolean LIE_ABOUT_AF = false;
    static final boolean LIE_ABOUT_AF_MAX_REGIONS = false;
    static final boolean LIE_ABOUT_AWB = false;
    static final boolean LIE_ABOUT_AWB_STATE = false;
    private static final long NS_PER_MS = 1000000;
    private static final int REQUEST_MAX_NUM_INPUT_STREAMS_COUNT = 0;
    private static final int REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC = 3;
    private static final int REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL = 1;
    private static final int REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW = 0;
    private static final int REQUEST_PIPELINE_MAX_DEPTH_HAL1 = 3;
    private static final int REQUEST_PIPELINE_MAX_DEPTH_OURS = 3;
    private static final String TAG = "LegacyMetadataMapper";
    static final int UNKNOWN_MODE = -1;
    private static final boolean VERBOSE;
    private static final int[] sAllowedTemplates;
    private static final int[] sEffectModes;
    private static final String[] sLegacyEffectMode;
    private static final String[] sLegacySceneModes;
    private static final int[] sSceneModes;

    static {
        VERBOSE = Log.isLoggable(TAG, 2);
        sLegacySceneModes = new String[]{Parameters.WHITE_BALANCE_AUTO, Parameters.SCENE_MODE_ACTION, Parameters.SCENE_MODE_PORTRAIT, Parameters.SCENE_MODE_LANDSCAPE, Parameters.SCENE_MODE_NIGHT, Parameters.SCENE_MODE_NIGHT_PORTRAIT, Parameters.SCENE_MODE_THEATRE, Parameters.SCENE_MODE_BEACH, Parameters.SCENE_MODE_SNOW, Parameters.SCENE_MODE_SUNSET, Parameters.SCENE_MODE_STEADYPHOTO, Parameters.SCENE_MODE_FIREWORKS, Parameters.SCENE_MODE_SPORTS, Parameters.SCENE_MODE_PARTY, Parameters.SCENE_MODE_CANDLELIGHT, Parameters.SCENE_MODE_BARCODE, Parameters.SCENE_MODE_HDR};
        sSceneModes = new int[]{REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW, 2, REQUEST_PIPELINE_MAX_DEPTH_OURS, 4, HAL_PIXEL_FORMAT_BGRA_8888, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18};
        sLegacyEffectMode = new String[]{Parameters.EFFECT_NONE, Parameters.EFFECT_MONO, Parameters.EFFECT_NEGATIVE, Parameters.EFFECT_SOLARIZE, Parameters.EFFECT_SEPIA, Parameters.EFFECT_POSTERIZE, Parameters.EFFECT_WHITEBOARD, Parameters.EFFECT_BLACKBOARD, Parameters.EFFECT_AQUA};
        sEffectModes = new int[]{REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW, REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL, 2, REQUEST_PIPELINE_MAX_DEPTH_OURS, 4, HAL_PIXEL_FORMAT_BGRA_8888, 6, 7, 8};
        sAllowedTemplates = new int[]{REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL, 2, REQUEST_PIPELINE_MAX_DEPTH_OURS};
    }

    public static CameraCharacteristics createCharacteristics(Parameters parameters, CameraInfo info) {
        Preconditions.checkNotNull(parameters, "parameters must not be null");
        Preconditions.checkNotNull(info, "info must not be null");
        String paramStr = parameters.flatten();
        android.hardware.CameraInfo outerInfo = new android.hardware.CameraInfo();
        outerInfo.info = info;
        return createCharacteristics(paramStr, outerInfo);
    }

    public static CameraCharacteristics createCharacteristics(String parameters, android.hardware.CameraInfo info) {
        Preconditions.checkNotNull(parameters, "parameters must not be null");
        Preconditions.checkNotNull(info, "info must not be null");
        Preconditions.checkNotNull(info.info, "info.info must not be null");
        CameraMetadataNative m = new CameraMetadataNative();
        mapCharacteristicsFromInfo(m, info.info);
        Parameters params = Camera.getEmptyParameters();
        params.unflatten(parameters);
        mapCharacteristicsFromParameters(m, params);
        if (VERBOSE) {
            Log.v(TAG, "createCharacteristics metadata:");
            Log.v(TAG, "--------------------------------------------------- (start)");
            m.dumpToLog();
            Log.v(TAG, "--------------------------------------------------- (end)");
        }
        return new CameraCharacteristics(m);
    }

    private static void mapCharacteristicsFromInfo(CameraMetadataNative m, CameraInfo i) {
        m.set(CameraCharacteristics.LENS_FACING, Integer.valueOf(i.facing == 0 ? REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL : REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
        m.set(CameraCharacteristics.SENSOR_ORIENTATION, Integer.valueOf(i.orientation));
    }

    private static void mapCharacteristicsFromParameters(CameraMetadataNative m, Parameters p) {
        Key key = CameraCharacteristics.COLOR_CORRECTION_AVAILABLE_ABERRATION_MODES;
        Object obj = new int[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
        obj[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL;
        m.set(key, obj);
        mapControlAe(m, p);
        mapControlAf(m, p);
        mapControlAwb(m, p);
        mapControlOther(m, p);
        mapLens(m, p);
        mapFlash(m, p);
        mapJpeg(m, p);
        key = CameraCharacteristics.NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES;
        obj = new int[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
        obj[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL;
        m.set(key, obj);
        mapScaler(m, p);
        mapSensor(m, p);
        mapStatistics(m, p);
        mapSync(m, p);
        m.set(CameraCharacteristics.INFO_SUPPORTED_HARDWARE_LEVEL, Integer.valueOf(2));
        mapScalerStreamConfigs(m, p);
        mapRequest(m, p);
    }

    private static void mapScalerStreamConfigs(CameraMetadataNative m, Parameters p) {
        ArrayList<StreamConfiguration> availableStreamConfigs = new ArrayList();
        List<Size> previewSizes = p.getSupportedPreviewSizes();
        appendStreamConfig(availableStreamConfigs, HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED, previewSizes);
        appendStreamConfig(availableStreamConfigs, 35, previewSizes);
        for (Integer intValue : p.getSupportedPreviewFormats()) {
            int format = intValue.intValue();
            if (ImageFormat.isPublicFormat(format) && format != 17) {
                appendStreamConfig(availableStreamConfigs, format, previewSizes);
            } else if (VERBOSE) {
                String str = TAG;
                Object[] objArr = new Object[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
                objArr[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = Integer.valueOf(format);
                Log.v(str, String.format("mapStreamConfigs - Skipping format %x", objArr));
            }
        }
        List<Size> jpegSizes = p.getSupportedPictureSizes();
        appendStreamConfig(availableStreamConfigs, HAL_PIXEL_FORMAT_BLOB, p.getSupportedPictureSizes());
        m.set(CameraCharacteristics.SCALER_AVAILABLE_STREAM_CONFIGURATIONS, availableStreamConfigs.toArray(new StreamConfiguration[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW]));
        m.set(CameraCharacteristics.SCALER_AVAILABLE_MIN_FRAME_DURATIONS, new StreamConfigurationDuration[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW]);
        Object jpegStalls = new StreamConfigurationDuration[jpegSizes.size()];
        int i = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
        long longestStallDuration = -1;
        for (Size s : jpegSizes) {
            long stallDuration = calculateJpegStallDuration(s);
            int i2 = i + REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL;
            jpegStalls[i] = new StreamConfigurationDuration(HAL_PIXEL_FORMAT_BLOB, s.width, s.height, stallDuration);
            if (longestStallDuration < stallDuration) {
                longestStallDuration = stallDuration;
            }
            i = i2;
        }
        m.set(CameraCharacteristics.SCALER_AVAILABLE_STALL_DURATIONS, jpegStalls);
        m.set(CameraCharacteristics.SENSOR_INFO_MAX_FRAME_DURATION, Long.valueOf(longestStallDuration));
    }

    private static void mapControlAe(CameraMetadataNative m, Parameters p) {
        List<String> antiBandingModes = p.getSupportedAntibanding();
        if (antiBandingModes == null || antiBandingModes.size() <= 0) {
            Object obj = new int[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW];
            m.set(CameraCharacteristics.CONTROL_AE_AVAILABLE_ANTIBANDING_MODES, obj);
        } else {
            int[] modes = new int[antiBandingModes.size()];
            int j = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
            for (String mode : antiBandingModes) {
                String mode2;
                int convertedMode = convertAntiBandingMode(mode2);
                if (VERBOSE && convertedMode == UNKNOWN_MODE) {
                    String str = TAG;
                    StringBuilder append = new StringBuilder().append("Antibanding mode ");
                    if (mode2 == null) {
                        mode2 = WifiEnterpriseConfig.EMPTY_VALUE;
                    }
                    Log.v(str, append.append(mode2).append(" not supported, skipping...").toString());
                } else {
                    int j2 = j + REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL;
                    modes[j] = convertedMode;
                    j = j2;
                }
            }
            m.set(CameraCharacteristics.CONTROL_AE_AVAILABLE_ANTIBANDING_MODES, Arrays.copyOf(modes, j));
        }
        List<int[]> fpsRanges = p.getSupportedPreviewFpsRange();
        if (fpsRanges == null) {
            throw new AssertionError("Supported FPS ranges cannot be null.");
        }
        int rangesSize = fpsRanges.size();
        if (rangesSize <= 0) {
            throw new AssertionError("At least one FPS range must be supported.");
        }
        Object ranges = new Range[rangesSize];
        int i = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
        for (int[] r : fpsRanges) {
            int i2 = i + REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL;
            ranges[i] = Range.create(Integer.valueOf(r[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW]), Integer.valueOf(r[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL]));
            i = i2;
        }
        m.set(CameraCharacteristics.CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES, ranges);
        List<String> flashModes = p.getSupportedFlashModes();
        String[] flashModeStrings = new String[HAL_PIXEL_FORMAT_BGRA_8888];
        flashModeStrings[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = Parameters.ZSL_OFF;
        flashModeStrings[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL] = Parameters.WHITE_BALANCE_AUTO;
        flashModeStrings[2] = Parameters.ZSL_ON;
        flashModeStrings[REQUEST_PIPELINE_MAX_DEPTH_OURS] = Parameters.FLASH_MODE_RED_EYE;
        flashModeStrings[4] = Parameters.FLASH_MODE_TORCH;
        int i3 = 4;
        Object aeAvail = ArrayUtils.convertStringListToIntArray(flashModes, flashModeStrings, new int[]{REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL, 2, REQUEST_PIPELINE_MAX_DEPTH_OURS, 4});
        if (aeAvail == null || aeAvail.length == 0) {
            aeAvail = new int[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
            aeAvail[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL;
        }
        m.set(CameraCharacteristics.CONTROL_AE_AVAILABLE_MODES, aeAvail);
        int min = p.getMinExposureCompensation();
        int max = p.getMaxExposureCompensation();
        m.set(CameraCharacteristics.CONTROL_AE_COMPENSATION_RANGE, Range.create(Integer.valueOf(min), Integer.valueOf(max)));
        float step = p.getExposureCompensationStep();
        m.set(CameraCharacteristics.CONTROL_AE_COMPENSATION_STEP, ParamsUtils.createRational(step));
    }

    private static void mapControlAf(CameraMetadataNative m, Parameters p) {
        List<Integer> afAvail = ArrayUtils.convertStringListToIntList(p.getSupportedFocusModes(), new String[]{Parameters.WHITE_BALANCE_AUTO, Parameters.FOCUS_MODE_CONTINUOUS_PICTURE, Parameters.FOCUS_MODE_CONTINUOUS_VIDEO, Parameters.FOCUS_MODE_EDOF, Parameters.FOCUS_MODE_INFINITY, Parameters.FOCUS_MODE_MACRO, Parameters.FOCUS_MODE_FIXED}, new int[]{REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL, 4, REQUEST_PIPELINE_MAX_DEPTH_OURS, HAL_PIXEL_FORMAT_BGRA_8888, REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW, 2, REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW});
        if (afAvail == null || afAvail.size() == 0) {
            Log.w(TAG, "No AF modes supported (HAL bug); defaulting to AF_MODE_OFF only");
            afAvail = new ArrayList(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL);
            afAvail.add(Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
        }
        m.set(CameraCharacteristics.CONTROL_AF_AVAILABLE_MODES, ArrayUtils.toIntArray(afAvail));
        if (VERBOSE) {
            Log.v(TAG, "mapControlAf - control.afAvailableModes set to " + ListUtils.listToString(afAvail));
        }
    }

    private static void mapControlAwb(CameraMetadataNative m, Parameters p) {
        List<Integer> awbAvail = ArrayUtils.convertStringListToIntList(p.getSupportedWhiteBalance(), new String[]{Parameters.WHITE_BALANCE_AUTO, Parameters.WHITE_BALANCE_INCANDESCENT, Parameters.WHITE_BALANCE_FLUORESCENT, Parameters.WHITE_BALANCE_WARM_FLUORESCENT, Parameters.WHITE_BALANCE_DAYLIGHT, Parameters.WHITE_BALANCE_CLOUDY_DAYLIGHT, Parameters.WHITE_BALANCE_TWILIGHT, Parameters.WHITE_BALANCE_SHADE}, new int[]{REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL, 2, REQUEST_PIPELINE_MAX_DEPTH_OURS, 4, HAL_PIXEL_FORMAT_BGRA_8888, 6, 7, 8});
        if (awbAvail == null || awbAvail.size() == 0) {
            Log.w(TAG, "No AWB modes supported (HAL bug); defaulting to AWB_MODE_AUTO only");
            awbAvail = new ArrayList(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL);
            awbAvail.add(Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL));
        }
        m.set(CameraCharacteristics.CONTROL_AWB_AVAILABLE_MODES, ArrayUtils.toIntArray(awbAvail));
        if (VERBOSE) {
            Log.v(TAG, "mapControlAwb - control.awbAvailableModes set to " + ListUtils.listToString(awbAvail));
        }
    }

    private static void mapControlOther(CameraMetadataNative m, Parameters p) {
        Object stabModes;
        Object supportedEffectModes;
        if (p.isVideoStabilizationSupported()) {
            stabModes = new int[]{REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW, REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL};
        } else {
            stabModes = new int[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
            stabModes[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
        }
        m.set(CameraCharacteristics.CONTROL_AVAILABLE_VIDEO_STABILIZATION_MODES, stabModes);
        Object maxRegions = new int[REQUEST_PIPELINE_MAX_DEPTH_OURS];
        maxRegions[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = p.getMaxNumMeteringAreas();
        maxRegions[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL] = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
        maxRegions[2] = p.getMaxNumFocusAreas();
        m.set(CameraCharacteristics.CONTROL_MAX_REGIONS, maxRegions);
        List<String> effectModes = p.getSupportedColorEffects();
        if (effectModes == null) {
            supportedEffectModes = new int[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW];
        } else {
            supportedEffectModes = ArrayUtils.convertStringListToIntArray(effectModes, sLegacyEffectMode, sEffectModes);
        }
        m.set(CameraCharacteristics.CONTROL_AVAILABLE_EFFECTS, supportedEffectModes);
        List<Integer> supportedSceneModes = ArrayUtils.convertStringListToIntList(p.getSupportedSceneModes(), sLegacySceneModes, sSceneModes);
        if (supportedSceneModes == null) {
            supportedSceneModes = new ArrayList();
            supportedSceneModes.add(Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
        }
        if (p.getMaxNumDetectedFaces() > 0) {
            supportedSceneModes.add(Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL));
        }
        m.set(CameraCharacteristics.CONTROL_AVAILABLE_SCENE_MODES, ArrayUtils.toIntArray(supportedSceneModes));
    }

    private static void mapLens(CameraMetadataNative m, Parameters p) {
        if (VERBOSE) {
            Log.v(TAG, "mapLens - focus-mode='" + p.getFocusMode() + "'");
        }
        if (Parameters.FOCUS_MODE_FIXED.equals(p.getFocusMode())) {
            m.set(CameraCharacteristics.LENS_INFO_MINIMUM_FOCUS_DISTANCE, Float.valueOf(LENS_INFO_MINIMUM_FOCUS_DISTANCE_FIXED_FOCUS));
            if (VERBOSE) {
                Log.v(TAG, "mapLens - lens.info.minimumFocusDistance = 0");
            }
        } else if (VERBOSE) {
            Log.v(TAG, "mapLens - lens.info.minimumFocusDistance is unknown");
        }
        Object focalLengths = new float[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
        focalLengths[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = p.getFocalLength();
        m.set(CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS, focalLengths);
    }

    private static void mapFlash(CameraMetadataNative m, Parameters p) {
        boolean flashAvailable = LIE_ABOUT_AWB_STATE;
        List<String> supportedFlashModes = p.getSupportedFlashModes();
        if (supportedFlashModes != null) {
            flashAvailable = !ListUtils.listElementsEqualTo(supportedFlashModes, Parameters.ZSL_OFF) ? true : LIE_ABOUT_AWB_STATE;
        }
        m.set(CameraCharacteristics.FLASH_INFO_AVAILABLE, Boolean.valueOf(flashAvailable));
    }

    private static void mapJpeg(CameraMetadataNative m, Parameters p) {
        List<Size> thumbnailSizes = p.getSupportedJpegThumbnailSizes();
        if (thumbnailSizes != null) {
            Object sizes = ParameterUtils.convertSizeListToArray(thumbnailSizes);
            Arrays.sort(sizes, new SizeAreaComparator());
            m.set(CameraCharacteristics.JPEG_AVAILABLE_THUMBNAIL_SIZES, sizes);
        }
    }

    private static void mapRequest(CameraMetadataNative m, Parameters p) {
        Object capabilities = new int[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
        capabilities[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
        m.set(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES, capabilities);
        Key<?>[] availableKeys = new Key[HAL_PIXEL_FORMAT_BLOB];
        availableKeys[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = CameraCharacteristics.COLOR_CORRECTION_AVAILABLE_ABERRATION_MODES;
        availableKeys[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL] = CameraCharacteristics.CONTROL_AE_AVAILABLE_ANTIBANDING_MODES;
        availableKeys[2] = CameraCharacteristics.CONTROL_AE_AVAILABLE_MODES;
        availableKeys[REQUEST_PIPELINE_MAX_DEPTH_OURS] = CameraCharacteristics.CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES;
        availableKeys[4] = CameraCharacteristics.CONTROL_AE_COMPENSATION_RANGE;
        availableKeys[HAL_PIXEL_FORMAT_BGRA_8888] = CameraCharacteristics.CONTROL_AE_COMPENSATION_STEP;
        availableKeys[6] = CameraCharacteristics.CONTROL_AF_AVAILABLE_MODES;
        availableKeys[7] = CameraCharacteristics.CONTROL_AVAILABLE_EFFECTS;
        availableKeys[8] = CameraCharacteristics.CONTROL_AVAILABLE_SCENE_MODES;
        availableKeys[9] = CameraCharacteristics.CONTROL_AVAILABLE_VIDEO_STABILIZATION_MODES;
        availableKeys[10] = CameraCharacteristics.CONTROL_AWB_AVAILABLE_MODES;
        availableKeys[11] = CameraCharacteristics.CONTROL_MAX_REGIONS;
        availableKeys[12] = CameraCharacteristics.FLASH_INFO_AVAILABLE;
        availableKeys[13] = CameraCharacteristics.INFO_SUPPORTED_HARDWARE_LEVEL;
        availableKeys[14] = CameraCharacteristics.JPEG_AVAILABLE_THUMBNAIL_SIZES;
        availableKeys[15] = CameraCharacteristics.LENS_FACING;
        availableKeys[16] = CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS;
        availableKeys[17] = CameraCharacteristics.NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES;
        availableKeys[18] = CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES;
        availableKeys[19] = CameraCharacteristics.REQUEST_MAX_NUM_OUTPUT_STREAMS;
        availableKeys[20] = CameraCharacteristics.REQUEST_PARTIAL_RESULT_COUNT;
        availableKeys[21] = CameraCharacteristics.REQUEST_PIPELINE_MAX_DEPTH;
        availableKeys[22] = CameraCharacteristics.SCALER_AVAILABLE_MAX_DIGITAL_ZOOM;
        availableKeys[23] = CameraCharacteristics.SCALER_CROPPING_TYPE;
        availableKeys[24] = CameraCharacteristics.SENSOR_AVAILABLE_TEST_PATTERN_MODES;
        availableKeys[25] = CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE;
        availableKeys[26] = CameraCharacteristics.SENSOR_INFO_PHYSICAL_SIZE;
        availableKeys[27] = CameraCharacteristics.SENSOR_INFO_PIXEL_ARRAY_SIZE;
        availableKeys[28] = CameraCharacteristics.SENSOR_INFO_TIMESTAMP_SOURCE;
        availableKeys[29] = CameraCharacteristics.SENSOR_ORIENTATION;
        availableKeys[30] = CameraCharacteristics.STATISTICS_INFO_AVAILABLE_FACE_DETECT_MODES;
        availableKeys[31] = CameraCharacteristics.STATISTICS_INFO_MAX_FACE_COUNT;
        availableKeys[32] = CameraCharacteristics.SYNC_MAX_LATENCY;
        List<Key<?>> characteristicsKeys = new ArrayList(Arrays.asList(availableKeys));
        if (m.get(CameraCharacteristics.LENS_INFO_MINIMUM_FOCUS_DISTANCE) != null) {
            characteristicsKeys.add(CameraCharacteristics.LENS_INFO_MINIMUM_FOCUS_DISTANCE);
        }
        m.set(CameraCharacteristics.REQUEST_AVAILABLE_CHARACTERISTICS_KEYS, getTagsForKeys((Key[]) characteristicsKeys.toArray(new Key[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW])));
        ArrayList<CaptureRequest.Key<?>> availableKeys2 = new ArrayList(Arrays.asList(new CaptureRequest.Key[]{CaptureRequest.COLOR_CORRECTION_ABERRATION_MODE, CaptureRequest.CONTROL_AE_ANTIBANDING_MODE, CaptureRequest.CONTROL_AE_EXPOSURE_COMPENSATION, CaptureRequest.CONTROL_AE_LOCK, CaptureRequest.CONTROL_AE_MODE, CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE, CaptureRequest.CONTROL_AF_MODE, CaptureRequest.CONTROL_AF_TRIGGER, CaptureRequest.CONTROL_AWB_LOCK, CaptureRequest.CONTROL_AWB_MODE, CaptureRequest.CONTROL_CAPTURE_INTENT, CaptureRequest.CONTROL_EFFECT_MODE, CaptureRequest.CONTROL_MODE, CaptureRequest.CONTROL_SCENE_MODE, CaptureRequest.CONTROL_VIDEO_STABILIZATION_MODE, CaptureRequest.FLASH_MODE, CaptureRequest.JPEG_GPS_COORDINATES, CaptureRequest.JPEG_GPS_PROCESSING_METHOD, CaptureRequest.JPEG_GPS_TIMESTAMP, CaptureRequest.JPEG_ORIENTATION, CaptureRequest.JPEG_QUALITY, CaptureRequest.JPEG_THUMBNAIL_QUALITY, CaptureRequest.JPEG_THUMBNAIL_SIZE, CaptureRequest.LENS_FOCAL_LENGTH, CaptureRequest.NOISE_REDUCTION_MODE, CaptureRequest.SCALER_CROP_REGION, CaptureRequest.STATISTICS_FACE_DETECT_MODE}));
        if (p.getMaxNumMeteringAreas() > 0) {
            availableKeys2.add(CaptureRequest.CONTROL_AE_REGIONS);
        }
        if (p.getMaxNumFocusAreas() > 0) {
            availableKeys2.add(CaptureRequest.CONTROL_AF_REGIONS);
        }
        CaptureRequest.Key[] availableRequestKeys = new CaptureRequest.Key[availableKeys2.size()];
        availableKeys2.toArray(availableRequestKeys);
        m.set(CameraCharacteristics.REQUEST_AVAILABLE_REQUEST_KEYS, getTagsForKeys(availableRequestKeys));
        List<CaptureResult.Key<?>> availableKeys3 = new ArrayList(Arrays.asList(new CaptureResult.Key[]{CaptureResult.COLOR_CORRECTION_ABERRATION_MODE, CaptureResult.CONTROL_AE_ANTIBANDING_MODE, CaptureResult.CONTROL_AE_EXPOSURE_COMPENSATION, CaptureResult.CONTROL_AE_LOCK, CaptureResult.CONTROL_AE_MODE, CaptureResult.CONTROL_AF_MODE, CaptureResult.CONTROL_AF_STATE, CaptureResult.CONTROL_AWB_MODE, CaptureResult.CONTROL_AWB_LOCK, CaptureResult.CONTROL_MODE, CaptureResult.FLASH_MODE, CaptureResult.JPEG_GPS_COORDINATES, CaptureResult.JPEG_GPS_PROCESSING_METHOD, CaptureResult.JPEG_GPS_TIMESTAMP, CaptureResult.JPEG_ORIENTATION, CaptureResult.JPEG_QUALITY, CaptureResult.JPEG_THUMBNAIL_QUALITY, CaptureResult.LENS_FOCAL_LENGTH, CaptureResult.NOISE_REDUCTION_MODE, CaptureResult.REQUEST_PIPELINE_DEPTH, CaptureResult.SCALER_CROP_REGION, CaptureResult.SENSOR_TIMESTAMP, CaptureResult.STATISTICS_FACE_DETECT_MODE}));
        if (p.getMaxNumMeteringAreas() > 0) {
            availableKeys3.add(CaptureResult.CONTROL_AE_REGIONS);
        }
        if (p.getMaxNumFocusAreas() > 0) {
            availableKeys3.add(CaptureResult.CONTROL_AF_REGIONS);
        }
        CaptureResult.Key[] availableResultKeys = new CaptureResult.Key[availableKeys3.size()];
        availableKeys3.toArray(availableResultKeys);
        m.set(CameraCharacteristics.REQUEST_AVAILABLE_RESULT_KEYS, getTagsForKeys(availableResultKeys));
        m.set(CameraCharacteristics.REQUEST_MAX_NUM_OUTPUT_STREAMS, new int[]{REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW, REQUEST_PIPELINE_MAX_DEPTH_OURS, REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL});
        m.set(CameraCharacteristics.REQUEST_MAX_NUM_INPUT_STREAMS, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
        m.set(CameraCharacteristics.REQUEST_PARTIAL_RESULT_COUNT, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL));
        m.set(CameraCharacteristics.REQUEST_PIPELINE_MAX_DEPTH, Byte.valueOf((byte) 6));
    }

    private static void mapScaler(CameraMetadataNative m, Parameters p) {
        m.set(CameraCharacteristics.SCALER_AVAILABLE_MAX_DIGITAL_ZOOM, Float.valueOf(ParameterUtils.getMaxZoomRatio(p)));
        m.set(CameraCharacteristics.SCALER_CROPPING_TYPE, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
    }

    private static void mapSensor(CameraMetadataNative m, Parameters p) {
        Object largestJpegSize = ParameterUtils.getLargestSupportedJpegSizeByArea(p);
        m.set(CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE, ParamsUtils.createRect((android.util.Size) largestJpegSize));
        Key key = CameraCharacteristics.SENSOR_AVAILABLE_TEST_PATTERN_MODES;
        Object obj = new int[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
        obj[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
        m.set(key, obj);
        m.set(CameraCharacteristics.SENSOR_INFO_PIXEL_ARRAY_SIZE, largestJpegSize);
        float focalLength = p.getFocalLength();
        float width = (float) Math.abs(((double) (2.0f * focalLength)) * Math.tan(((((double) p.getHorizontalViewAngle()) * 3.141592653589793d) / 180.0d) / 2.0d));
        m.set(CameraCharacteristics.SENSOR_INFO_PHYSICAL_SIZE, new SizeF(width, (float) Math.abs(((double) (2.0f * focalLength)) * Math.tan(((((double) p.getVerticalViewAngle()) * 3.141592653589793d) / 180.0d) / 2.0d))));
        m.set(CameraCharacteristics.SENSOR_INFO_TIMESTAMP_SOURCE, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
    }

    private static void mapStatistics(CameraMetadataNative m, Parameters p) {
        Object fdModes;
        if (p.getMaxNumDetectedFaces() > 0) {
            fdModes = new int[]{REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW, REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL};
        } else {
            fdModes = new int[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
            fdModes[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
        }
        m.set(CameraCharacteristics.STATISTICS_INFO_AVAILABLE_FACE_DETECT_MODES, fdModes);
        m.set(CameraCharacteristics.STATISTICS_INFO_MAX_FACE_COUNT, Integer.valueOf(p.getMaxNumDetectedFaces()));
    }

    private static void mapSync(CameraMetadataNative m, Parameters p) {
        m.set(CameraCharacteristics.SYNC_MAX_LATENCY, Integer.valueOf(UNKNOWN_MODE));
    }

    private static void appendStreamConfig(ArrayList<StreamConfiguration> configs, int format, List<Size> sizes) {
        for (Size size : sizes) {
            configs.add(new StreamConfiguration(format, size.width, size.height, LIE_ABOUT_AWB_STATE));
        }
    }

    static int convertSceneModeFromLegacy(String mode) {
        if (mode == null) {
            return REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
        }
        int index = ArrayUtils.getArrayIndex(sLegacySceneModes, (Object) mode);
        if (index < 0) {
            return UNKNOWN_MODE;
        }
        return sSceneModes[index];
    }

    static String convertSceneModeToLegacy(int mode) {
        if (mode == REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL) {
            return Parameters.WHITE_BALANCE_AUTO;
        }
        int index = ArrayUtils.getArrayIndex(sSceneModes, mode);
        if (index < 0) {
            return null;
        }
        return sLegacySceneModes[index];
    }

    static int convertEffectModeFromLegacy(String mode) {
        if (mode == null) {
            return REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
        }
        int index = ArrayUtils.getArrayIndex(sLegacyEffectMode, (Object) mode);
        if (index < 0) {
            return UNKNOWN_MODE;
        }
        return sEffectModes[index];
    }

    static String convertEffectModeToLegacy(int mode) {
        int index = ArrayUtils.getArrayIndex(sEffectModes, mode);
        if (index < 0) {
            return null;
        }
        return sLegacyEffectMode[index];
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private static int convertAntiBandingMode(java.lang.String r6) {
        /*
        r4 = 3;
        r3 = 2;
        r2 = 1;
        r1 = 0;
        r0 = -1;
        if (r6 != 0) goto L_0x0008;
    L_0x0007:
        return r0;
    L_0x0008:
        r5 = r6.hashCode();
        switch(r5) {
            case 109935: goto L_0x002c;
            case 1628397: goto L_0x0037;
            case 1658188: goto L_0x0041;
            case 3005871: goto L_0x004b;
            default: goto L_0x000f;
        };
    L_0x000f:
        r5 = r0;
    L_0x0010:
        switch(r5) {
            case 0: goto L_0x0055;
            case 1: goto L_0x0057;
            case 2: goto L_0x0059;
            case 3: goto L_0x005b;
            default: goto L_0x0013;
        };
    L_0x0013:
        r1 = "LegacyMetadataMapper";
        r2 = new java.lang.StringBuilder;
        r2.<init>();
        r3 = "convertAntiBandingMode - Unknown antibanding mode ";
        r2 = r2.append(r3);
        r2 = r2.append(r6);
        r2 = r2.toString();
        android.util.Log.w(r1, r2);
        goto L_0x0007;
    L_0x002c:
        r5 = "off";
        r5 = r6.equals(r5);
        if (r5 == 0) goto L_0x000f;
    L_0x0035:
        r5 = r1;
        goto L_0x0010;
    L_0x0037:
        r5 = "50hz";
        r5 = r6.equals(r5);
        if (r5 == 0) goto L_0x000f;
    L_0x003f:
        r5 = r2;
        goto L_0x0010;
    L_0x0041:
        r5 = "60hz";
        r5 = r6.equals(r5);
        if (r5 == 0) goto L_0x000f;
    L_0x0049:
        r5 = r3;
        goto L_0x0010;
    L_0x004b:
        r5 = "auto";
        r5 = r6.equals(r5);
        if (r5 == 0) goto L_0x000f;
    L_0x0053:
        r5 = r4;
        goto L_0x0010;
    L_0x0055:
        r0 = r1;
        goto L_0x0007;
    L_0x0057:
        r0 = r2;
        goto L_0x0007;
    L_0x0059:
        r0 = r3;
        goto L_0x0007;
    L_0x005b:
        r0 = r4;
        goto L_0x0007;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.hardware.camera2.legacy.LegacyMetadataMapper.convertAntiBandingMode(java.lang.String):int");
    }

    static int convertAntiBandingModeOrDefault(String mode) {
        int antiBandingMode = convertAntiBandingMode(mode);
        if (antiBandingMode == UNKNOWN_MODE) {
            return REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
        }
        return antiBandingMode;
    }

    private static int[] convertAeFpsRangeToLegacy(Range<Integer> fpsRange) {
        return new int[]{((Integer) fpsRange.getLower()).intValue(), ((Integer) fpsRange.getUpper()).intValue()};
    }

    private static long calculateJpegStallDuration(Size size) {
        return ((((long) size.width) * ((long) size.height)) * 71) + 200000000;
    }

    public static void convertRequestMetadata(LegacyRequest request) {
        LegacyRequestMapper.convertRequestMetadata(request);
    }

    public static CameraMetadataNative createRequestTemplate(CameraCharacteristics c, int templateId) {
        if (ArrayUtils.contains(sAllowedTemplates, templateId)) {
            int captureIntent;
            int afMode;
            Object obj;
            CameraMetadataNative m = new CameraMetadataNative();
            m.set(CaptureRequest.CONTROL_AWB_MODE, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL));
            m.set(CaptureRequest.CONTROL_AE_ANTIBANDING_MODE, Integer.valueOf(REQUEST_PIPELINE_MAX_DEPTH_OURS));
            m.set(CaptureRequest.CONTROL_AE_EXPOSURE_COMPENSATION, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
            m.set(CaptureRequest.CONTROL_AE_LOCK, Boolean.valueOf(LIE_ABOUT_AWB_STATE));
            m.set(CaptureRequest.CONTROL_AE_PRECAPTURE_TRIGGER, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
            m.set(CaptureRequest.CONTROL_AF_TRIGGER, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
            m.set(CaptureRequest.CONTROL_AWB_MODE, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL));
            m.set(CaptureRequest.CONTROL_AWB_LOCK, Boolean.valueOf(LIE_ABOUT_AWB_STATE));
            Rect activeArray = (Rect) c.get(CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE);
            Object activeRegions = new MeteringRectangle[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
            activeRegions[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW] = new MeteringRectangle(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW, REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW, activeArray.width() + UNKNOWN_MODE, activeArray.height() + UNKNOWN_MODE, REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW);
            m.set(CaptureRequest.CONTROL_AE_REGIONS, activeRegions);
            m.set(CaptureRequest.CONTROL_AWB_REGIONS, activeRegions);
            m.set(CaptureRequest.CONTROL_AF_REGIONS, activeRegions);
            switch (templateId) {
                case REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL /*1*/:
                    captureIntent = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL;
                    break;
                case Action.MERGE_IGNORE /*2*/:
                    captureIntent = 2;
                    break;
                case REQUEST_PIPELINE_MAX_DEPTH_OURS /*3*/:
                    captureIntent = REQUEST_PIPELINE_MAX_DEPTH_OURS;
                    break;
                default:
                    throw new AssertionError("Impossible; keep in sync with sAllowedTemplates");
            }
            m.set(CaptureRequest.CONTROL_CAPTURE_INTENT, Integer.valueOf(captureIntent));
            m.set(CaptureRequest.CONTROL_AE_MODE, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL));
            m.set(CaptureRequest.CONTROL_MODE, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL));
            Float minimumFocusDistance = (Float) c.get(CameraCharacteristics.LENS_INFO_MINIMUM_FOCUS_DISTANCE);
            if (minimumFocusDistance == null || minimumFocusDistance.floatValue() != LENS_INFO_MINIMUM_FOCUS_DISTANCE_FIXED_FOCUS) {
                afMode = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL;
                if (templateId == REQUEST_PIPELINE_MAX_DEPTH_OURS || templateId == 4) {
                    if (ArrayUtils.contains((int[]) c.get(CameraCharacteristics.CONTROL_AF_AVAILABLE_MODES), (int) REQUEST_PIPELINE_MAX_DEPTH_OURS)) {
                        afMode = REQUEST_PIPELINE_MAX_DEPTH_OURS;
                    }
                } else if (templateId == REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL || templateId == 2) {
                    if (ArrayUtils.contains((int[]) c.get(CameraCharacteristics.CONTROL_AF_AVAILABLE_MODES), 4)) {
                        afMode = 4;
                    }
                }
            } else {
                afMode = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW;
            }
            if (VERBOSE) {
                Log.v(TAG, "createRequestTemplate (templateId=" + templateId + ")," + " afMode=" + afMode + ", minimumFocusDistance=" + minimumFocusDistance);
            }
            m.set(CaptureRequest.CONTROL_AF_MODE, Integer.valueOf(afMode));
            Range[] availableFpsRange = (Range[]) c.get(CameraCharacteristics.CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES);
            Object bestRange = availableFpsRange[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW];
            Range[] arr$ = availableFpsRange;
            int len$ = arr$.length;
            for (int i$ = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW; i$ < len$; i$ += REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL) {
                Range<Integer> r = arr$[i$];
                if (((Integer) bestRange.getUpper()).intValue() < ((Integer) r.getUpper()).intValue()) {
                    bestRange = r;
                } else if (bestRange.getUpper() == r.getUpper() && ((Integer) bestRange.getLower()).intValue() < ((Integer) r.getLower()).intValue()) {
                    Range<Integer> bestRange2 = r;
                }
            }
            m.set(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE, bestRange);
            m.set(CaptureRequest.CONTROL_SCENE_MODE, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
            m.set(CaptureRequest.STATISTICS_FACE_DETECT_MODE, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
            m.set(CaptureRequest.FLASH_MODE, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW));
            m.set(CaptureRequest.NOISE_REDUCTION_MODE, Integer.valueOf(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL));
            CameraMetadataNative cameraMetadataNative = m;
            cameraMetadataNative.set(CaptureRequest.LENS_FOCAL_LENGTH, Float.valueOf(((float[]) c.get(CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS))[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW]));
            android.util.Size[] sizes = (android.util.Size[]) c.get(CameraCharacteristics.JPEG_AVAILABLE_THUMBNAIL_SIZES);
            CaptureRequest.Key key = CaptureRequest.JPEG_THUMBNAIL_SIZE;
            if (sizes.length > REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL) {
                obj = sizes[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL];
            } else {
                obj = sizes[REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW];
            }
            m.set(key, obj);
            return m;
        }
        throw new IllegalArgumentException("templateId out of range");
    }

    private static int[] getTagsForKeys(Key<?>[] keys) {
        int[] tags = new int[keys.length];
        for (int i = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW; i < keys.length; i += REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL) {
            tags[i] = keys[i].getNativeKey().getTag();
        }
        return tags;
    }

    private static int[] getTagsForKeys(CaptureRequest.Key<?>[] keys) {
        int[] tags = new int[keys.length];
        for (int i = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW; i < keys.length; i += REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL) {
            tags[i] = keys[i].getNativeKey().getTag();
        }
        return tags;
    }

    private static int[] getTagsForKeys(CaptureResult.Key<?>[] keys) {
        int[] tags = new int[keys.length];
        for (int i = REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW; i < keys.length; i += REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL) {
            tags[i] = keys[i].getNativeKey().getTag();
        }
        return tags;
    }

    static String convertAfModeToLegacy(int mode, List<String> supportedFocusModes) {
        if (supportedFocusModes == null || supportedFocusModes.isEmpty()) {
            Log.w(TAG, "No focus modes supported; API1 bug");
            return null;
        }
        String param = null;
        switch (mode) {
            case REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW /*0*/:
                if (!supportedFocusModes.contains(Parameters.FOCUS_MODE_FIXED)) {
                    param = Parameters.FOCUS_MODE_INFINITY;
                    break;
                }
                param = Parameters.FOCUS_MODE_FIXED;
                break;
            case REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_PROC_STALL /*1*/:
                param = Parameters.WHITE_BALANCE_AUTO;
                break;
            case Action.MERGE_IGNORE /*2*/:
                param = Parameters.FOCUS_MODE_MACRO;
                break;
            case REQUEST_PIPELINE_MAX_DEPTH_OURS /*3*/:
                param = Parameters.FOCUS_MODE_CONTINUOUS_VIDEO;
                break;
            case ViewGroupAction.TAG /*4*/:
                param = Parameters.FOCUS_MODE_CONTINUOUS_PICTURE;
                break;
            case HAL_PIXEL_FORMAT_BGRA_8888 /*5*/:
                param = Parameters.FOCUS_MODE_EDOF;
                break;
        }
        if (supportedFocusModes.contains(param)) {
            return param;
        }
        String defaultMode = (String) supportedFocusModes.get(REQUEST_MAX_NUM_OUTPUT_STREAMS_COUNT_RAW);
        Log.w(TAG, String.format("convertAfModeToLegacy - ignoring unsupported mode %d, defaulting to %s", new Object[]{Integer.valueOf(mode), defaultMode}));
        return defaultMode;
    }
}
