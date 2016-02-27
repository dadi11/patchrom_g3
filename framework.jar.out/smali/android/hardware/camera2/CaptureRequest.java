package android.hardware.camera2;

import android.content.RestrictionsManager;
import android.graphics.Rect;
import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.impl.PublicKey;
import android.hardware.camera2.impl.SyntheticKey;
import android.hardware.camera2.params.ColorSpaceTransform;
import android.hardware.camera2.params.MeteringRectangle;
import android.hardware.camera2.params.RggbChannelVector;
import android.hardware.camera2.params.TonemapCurve;
import android.hardware.camera2.utils.HashCodeHelpers;
import android.hardware.camera2.utils.TypeReference;
import android.location.Location;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Range;
import android.util.Size;
import android.view.Surface;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;

public final class CaptureRequest extends CameraMetadata<Key<?>> implements Parcelable {
    @PublicKey
    public static final Key<Boolean> BLACK_LEVEL_LOCK;
    @PublicKey
    public static final Key<Integer> COLOR_CORRECTION_ABERRATION_MODE;
    @PublicKey
    public static final Key<RggbChannelVector> COLOR_CORRECTION_GAINS;
    @PublicKey
    public static final Key<Integer> COLOR_CORRECTION_MODE;
    @PublicKey
    public static final Key<ColorSpaceTransform> COLOR_CORRECTION_TRANSFORM;
    @PublicKey
    public static final Key<Integer> CONTROL_AE_ANTIBANDING_MODE;
    @PublicKey
    public static final Key<Integer> CONTROL_AE_EXPOSURE_COMPENSATION;
    @PublicKey
    public static final Key<Boolean> CONTROL_AE_LOCK;
    @PublicKey
    public static final Key<Integer> CONTROL_AE_MODE;
    @PublicKey
    public static final Key<Integer> CONTROL_AE_PRECAPTURE_TRIGGER;
    @PublicKey
    public static final Key<MeteringRectangle[]> CONTROL_AE_REGIONS;
    @PublicKey
    public static final Key<Range<Integer>> CONTROL_AE_TARGET_FPS_RANGE;
    @PublicKey
    public static final Key<Integer> CONTROL_AF_MODE;
    @PublicKey
    public static final Key<MeteringRectangle[]> CONTROL_AF_REGIONS;
    @PublicKey
    public static final Key<Integer> CONTROL_AF_TRIGGER;
    @PublicKey
    public static final Key<Boolean> CONTROL_AWB_LOCK;
    @PublicKey
    public static final Key<Integer> CONTROL_AWB_MODE;
    @PublicKey
    public static final Key<MeteringRectangle[]> CONTROL_AWB_REGIONS;
    @PublicKey
    public static final Key<Integer> CONTROL_CAPTURE_INTENT;
    @PublicKey
    public static final Key<Integer> CONTROL_EFFECT_MODE;
    @PublicKey
    public static final Key<Integer> CONTROL_MODE;
    @PublicKey
    public static final Key<Integer> CONTROL_SCENE_MODE;
    @PublicKey
    public static final Key<Integer> CONTROL_VIDEO_STABILIZATION_MODE;
    public static final Creator<CaptureRequest> CREATOR;
    @PublicKey
    public static final Key<Integer> EDGE_MODE;
    @PublicKey
    public static final Key<Integer> FLASH_MODE;
    @PublicKey
    public static final Key<Integer> HOT_PIXEL_MODE;
    public static final Key<double[]> JPEG_GPS_COORDINATES;
    @PublicKey
    @SyntheticKey
    public static final Key<Location> JPEG_GPS_LOCATION;
    public static final Key<String> JPEG_GPS_PROCESSING_METHOD;
    public static final Key<Long> JPEG_GPS_TIMESTAMP;
    @PublicKey
    public static final Key<Integer> JPEG_ORIENTATION;
    @PublicKey
    public static final Key<Byte> JPEG_QUALITY;
    @PublicKey
    public static final Key<Byte> JPEG_THUMBNAIL_QUALITY;
    @PublicKey
    public static final Key<Size> JPEG_THUMBNAIL_SIZE;
    public static final Key<Boolean> LED_TRANSMIT;
    @PublicKey
    public static final Key<Float> LENS_APERTURE;
    @PublicKey
    public static final Key<Float> LENS_FILTER_DENSITY;
    @PublicKey
    public static final Key<Float> LENS_FOCAL_LENGTH;
    @PublicKey
    public static final Key<Float> LENS_FOCUS_DISTANCE;
    @PublicKey
    public static final Key<Integer> LENS_OPTICAL_STABILIZATION_MODE;
    @PublicKey
    public static final Key<Integer> NOISE_REDUCTION_MODE;
    public static final Key<Integer> REQUEST_ID;
    @PublicKey
    public static final Key<Rect> SCALER_CROP_REGION;
    @PublicKey
    public static final Key<Long> SENSOR_EXPOSURE_TIME;
    @PublicKey
    public static final Key<Long> SENSOR_FRAME_DURATION;
    @PublicKey
    public static final Key<Integer> SENSOR_SENSITIVITY;
    @PublicKey
    public static final Key<int[]> SENSOR_TEST_PATTERN_DATA;
    @PublicKey
    public static final Key<Integer> SENSOR_TEST_PATTERN_MODE;
    @PublicKey
    public static final Key<Integer> SHADING_MODE;
    @PublicKey
    public static final Key<Integer> STATISTICS_FACE_DETECT_MODE;
    @PublicKey
    public static final Key<Boolean> STATISTICS_HOT_PIXEL_MAP_MODE;
    @PublicKey
    public static final Key<Integer> STATISTICS_LENS_SHADING_MAP_MODE;
    @PublicKey
    @SyntheticKey
    public static final Key<TonemapCurve> TONEMAP_CURVE;
    public static final Key<float[]> TONEMAP_CURVE_BLUE;
    public static final Key<float[]> TONEMAP_CURVE_GREEN;
    public static final Key<float[]> TONEMAP_CURVE_RED;
    @PublicKey
    public static final Key<Integer> TONEMAP_MODE;
    private final CameraMetadataNative mSettings;
    private final HashSet<Surface> mSurfaceSet;
    private Object mUserTag;

    /* renamed from: android.hardware.camera2.CaptureRequest.1 */
    static class C02151 implements Creator<CaptureRequest> {
        C02151() {
        }

        public CaptureRequest createFromParcel(Parcel in) {
            CaptureRequest request = new CaptureRequest();
            request.readFromParcel(in);
            return request;
        }

        public CaptureRequest[] newArray(int size) {
            return new CaptureRequest[size];
        }
    }

    /* renamed from: android.hardware.camera2.CaptureRequest.2 */
    static class C02162 extends TypeReference<Range<Integer>> {
        C02162() {
        }
    }

    public static final class Builder {
        private final CaptureRequest mRequest;

        public Builder(CameraMetadataNative template) {
            this.mRequest = new CaptureRequest(null);
        }

        public void addTarget(Surface outputTarget) {
            this.mRequest.mSurfaceSet.add(outputTarget);
        }

        public void removeTarget(Surface outputTarget) {
            this.mRequest.mSurfaceSet.remove(outputTarget);
        }

        public <T> void set(Key<T> key, T value) {
            this.mRequest.mSettings.set((Key) key, (Object) value);
        }

        public <T> T get(Key<T> key) {
            return this.mRequest.mSettings.get((Key) key);
        }

        public void setTag(Object tag) {
            this.mRequest.mUserTag = tag;
        }

        public CaptureRequest build() {
            return new CaptureRequest(null);
        }

        public boolean isEmpty() {
            return this.mRequest.mSettings.isEmpty();
        }
    }

    public static final class Key<T> {
        private final android.hardware.camera2.impl.CameraMetadataNative.Key<T> mKey;

        public Key(String name, Class<T> type) {
            this.mKey = new android.hardware.camera2.impl.CameraMetadataNative.Key(name, (Class) type);
        }

        public Key(String name, TypeReference<T> typeReference) {
            this.mKey = new android.hardware.camera2.impl.CameraMetadataNative.Key(name, (TypeReference) typeReference);
        }

        public String getName() {
            return this.mKey.getName();
        }

        public final int hashCode() {
            return this.mKey.hashCode();
        }

        public final boolean equals(Object o) {
            return (o instanceof Key) && ((Key) o).mKey.equals(this.mKey);
        }

        public android.hardware.camera2.impl.CameraMetadataNative.Key<T> getNativeKey() {
            return this.mKey;
        }

        Key(android.hardware.camera2.impl.CameraMetadataNative.Key<?> nativeKey) {
            this.mKey = nativeKey;
        }
    }

    private CaptureRequest() {
        this.mSettings = new CameraMetadataNative();
        this.mSurfaceSet = new HashSet();
    }

    private CaptureRequest(CaptureRequest source) {
        this.mSettings = new CameraMetadataNative(source.mSettings);
        this.mSurfaceSet = (HashSet) source.mSurfaceSet.clone();
        this.mUserTag = source.mUserTag;
    }

    private CaptureRequest(CameraMetadataNative settings) {
        this.mSettings = CameraMetadataNative.move(settings);
        this.mSurfaceSet = new HashSet();
    }

    public <T> T get(Key<T> key) {
        return this.mSettings.get((Key) key);
    }

    protected <T> T getProtected(Key<?> key) {
        return this.mSettings.get((Key) key);
    }

    protected Class<Key<?>> getKeyClass() {
        return Key.class;
    }

    public List<Key<?>> getKeys() {
        return super.getKeys();
    }

    public Object getTag() {
        return this.mUserTag;
    }

    public boolean equals(Object other) {
        return (other instanceof CaptureRequest) && equals((CaptureRequest) other);
    }

    private boolean equals(CaptureRequest other) {
        return other != null && Objects.equals(this.mUserTag, other.mUserTag) && this.mSurfaceSet.equals(other.mSurfaceSet) && this.mSettings.equals(other.mSettings);
    }

    public int hashCode() {
        return HashCodeHelpers.hashCode(this.mSettings, this.mSurfaceSet, this.mUserTag);
    }

    static {
        CREATOR = new C02151();
        COLOR_CORRECTION_MODE = new Key("android.colorCorrection.mode", Integer.TYPE);
        COLOR_CORRECTION_TRANSFORM = new Key("android.colorCorrection.transform", ColorSpaceTransform.class);
        COLOR_CORRECTION_GAINS = new Key("android.colorCorrection.gains", RggbChannelVector.class);
        COLOR_CORRECTION_ABERRATION_MODE = new Key("android.colorCorrection.aberrationMode", Integer.TYPE);
        CONTROL_AE_ANTIBANDING_MODE = new Key("android.control.aeAntibandingMode", Integer.TYPE);
        CONTROL_AE_EXPOSURE_COMPENSATION = new Key("android.control.aeExposureCompensation", Integer.TYPE);
        CONTROL_AE_LOCK = new Key("android.control.aeLock", Boolean.TYPE);
        CONTROL_AE_MODE = new Key("android.control.aeMode", Integer.TYPE);
        CONTROL_AE_REGIONS = new Key("android.control.aeRegions", MeteringRectangle[].class);
        CONTROL_AE_TARGET_FPS_RANGE = new Key("android.control.aeTargetFpsRange", new C02162());
        CONTROL_AE_PRECAPTURE_TRIGGER = new Key("android.control.aePrecaptureTrigger", Integer.TYPE);
        CONTROL_AF_MODE = new Key("android.control.afMode", Integer.TYPE);
        CONTROL_AF_REGIONS = new Key("android.control.afRegions", MeteringRectangle[].class);
        CONTROL_AF_TRIGGER = new Key("android.control.afTrigger", Integer.TYPE);
        CONTROL_AWB_LOCK = new Key("android.control.awbLock", Boolean.TYPE);
        CONTROL_AWB_MODE = new Key("android.control.awbMode", Integer.TYPE);
        CONTROL_AWB_REGIONS = new Key("android.control.awbRegions", MeteringRectangle[].class);
        CONTROL_CAPTURE_INTENT = new Key("android.control.captureIntent", Integer.TYPE);
        CONTROL_EFFECT_MODE = new Key("android.control.effectMode", Integer.TYPE);
        CONTROL_MODE = new Key("android.control.mode", Integer.TYPE);
        CONTROL_SCENE_MODE = new Key("android.control.sceneMode", Integer.TYPE);
        CONTROL_VIDEO_STABILIZATION_MODE = new Key("android.control.videoStabilizationMode", Integer.TYPE);
        EDGE_MODE = new Key("android.edge.mode", Integer.TYPE);
        FLASH_MODE = new Key("android.flash.mode", Integer.TYPE);
        HOT_PIXEL_MODE = new Key("android.hotPixel.mode", Integer.TYPE);
        JPEG_GPS_LOCATION = new Key("android.jpeg.gpsLocation", Location.class);
        JPEG_GPS_COORDINATES = new Key("android.jpeg.gpsCoordinates", double[].class);
        JPEG_GPS_PROCESSING_METHOD = new Key("android.jpeg.gpsProcessingMethod", String.class);
        JPEG_GPS_TIMESTAMP = new Key("android.jpeg.gpsTimestamp", Long.TYPE);
        JPEG_ORIENTATION = new Key("android.jpeg.orientation", Integer.TYPE);
        JPEG_QUALITY = new Key("android.jpeg.quality", Byte.TYPE);
        JPEG_THUMBNAIL_QUALITY = new Key("android.jpeg.thumbnailQuality", Byte.TYPE);
        JPEG_THUMBNAIL_SIZE = new Key("android.jpeg.thumbnailSize", Size.class);
        LENS_APERTURE = new Key("android.lens.aperture", Float.TYPE);
        LENS_FILTER_DENSITY = new Key("android.lens.filterDensity", Float.TYPE);
        LENS_FOCAL_LENGTH = new Key("android.lens.focalLength", Float.TYPE);
        LENS_FOCUS_DISTANCE = new Key("android.lens.focusDistance", Float.TYPE);
        LENS_OPTICAL_STABILIZATION_MODE = new Key("android.lens.opticalStabilizationMode", Integer.TYPE);
        NOISE_REDUCTION_MODE = new Key("android.noiseReduction.mode", Integer.TYPE);
        REQUEST_ID = new Key(RestrictionsManager.REQUEST_KEY_ID, Integer.TYPE);
        SCALER_CROP_REGION = new Key("android.scaler.cropRegion", Rect.class);
        SENSOR_EXPOSURE_TIME = new Key("android.sensor.exposureTime", Long.TYPE);
        SENSOR_FRAME_DURATION = new Key("android.sensor.frameDuration", Long.TYPE);
        SENSOR_SENSITIVITY = new Key("android.sensor.sensitivity", Integer.TYPE);
        SENSOR_TEST_PATTERN_DATA = new Key("android.sensor.testPatternData", int[].class);
        SENSOR_TEST_PATTERN_MODE = new Key("android.sensor.testPatternMode", Integer.TYPE);
        SHADING_MODE = new Key("android.shading.mode", Integer.TYPE);
        STATISTICS_FACE_DETECT_MODE = new Key("android.statistics.faceDetectMode", Integer.TYPE);
        STATISTICS_HOT_PIXEL_MAP_MODE = new Key("android.statistics.hotPixelMapMode", Boolean.TYPE);
        STATISTICS_LENS_SHADING_MAP_MODE = new Key("android.statistics.lensShadingMapMode", Integer.TYPE);
        TONEMAP_CURVE_BLUE = new Key("android.tonemap.curveBlue", float[].class);
        TONEMAP_CURVE_GREEN = new Key("android.tonemap.curveGreen", float[].class);
        TONEMAP_CURVE_RED = new Key("android.tonemap.curveRed", float[].class);
        TONEMAP_CURVE = new Key("android.tonemap.curve", TonemapCurve.class);
        TONEMAP_MODE = new Key("android.tonemap.mode", Integer.TYPE);
        LED_TRANSMIT = new Key("android.led.transmit", Boolean.TYPE);
        BLACK_LEVEL_LOCK = new Key("android.blackLevel.lock", Boolean.TYPE);
    }

    private void readFromParcel(Parcel in) {
        this.mSettings.readFromParcel(in);
        this.mSurfaceSet.clear();
        Parcelable[] parcelableArray = in.readParcelableArray(Surface.class.getClassLoader());
        if (parcelableArray != null) {
            for (Parcelable s : parcelableArray) {
                this.mSurfaceSet.add((Surface) s);
            }
        }
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        this.mSettings.writeToParcel(dest, flags);
        dest.writeParcelableArray((Parcelable[]) this.mSurfaceSet.toArray(new Surface[this.mSurfaceSet.size()]), flags);
    }

    public boolean containsTarget(Surface surface) {
        return this.mSurfaceSet.contains(surface);
    }

    public Collection<Surface> getTargets() {
        return Collections.unmodifiableCollection(this.mSurfaceSet);
    }
}
