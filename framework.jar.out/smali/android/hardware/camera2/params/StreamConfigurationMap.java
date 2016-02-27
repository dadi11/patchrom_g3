package android.hardware.camera2.params;

import android.graphics.ImageFormat;
import android.graphics.PixelFormat;
import android.graphics.SurfaceTexture;
import android.hardware.camera2.legacy.LegacyCameraDevice;
import android.hardware.camera2.legacy.LegacyExceptionUtils.BufferQueueAbandonedException;
import android.hardware.camera2.utils.HashCodeHelpers;
import android.media.ImageReader;
import android.media.MediaCodec;
import android.media.MediaRecorder;
import android.renderscript.Allocation;
import android.util.Range;
import android.util.Size;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.inputmethod.InputMethodManager;
import com.android.internal.util.Preconditions;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Objects;
import java.util.Set;

public final class StreamConfigurationMap {
    private static final int DURATION_MIN_FRAME = 0;
    private static final int DURATION_STALL = 1;
    private static final int HAL_PIXEL_FORMAT_BLOB = 33;
    private static final int HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED = 34;
    private static final int HAL_PIXEL_FORMAT_RAW_OPAQUE = 36;
    private static final String TAG = "StreamConfigurationMap";
    private final StreamConfiguration[] mConfigurations;
    private final HighSpeedVideoConfiguration[] mHighSpeedVideoConfigurations;
    private final HashMap<Range<Integer>, Integer> mHighSpeedVideoFpsRangeMap;
    private final HashMap<Size, Integer> mHighSpeedVideoSizeMap;
    private final HashMap<Integer, Integer> mInputFormats;
    private final StreamConfigurationDuration[] mMinFrameDurations;
    private final HashMap<Integer, Integer> mOutputFormats;
    private final StreamConfigurationDuration[] mStallDurations;

    public StreamConfigurationMap(StreamConfiguration[] configurations, StreamConfigurationDuration[] minFrameDurations, StreamConfigurationDuration[] stallDurations, HighSpeedVideoConfiguration[] highSpeedVideoConfigurations) {
        int i$;
        this.mOutputFormats = new HashMap();
        this.mInputFormats = new HashMap();
        this.mHighSpeedVideoSizeMap = new HashMap();
        this.mHighSpeedVideoFpsRangeMap = new HashMap();
        this.mConfigurations = (StreamConfiguration[]) Preconditions.checkArrayElementsNotNull(configurations, "configurations");
        this.mMinFrameDurations = (StreamConfigurationDuration[]) Preconditions.checkArrayElementsNotNull(minFrameDurations, "minFrameDurations");
        this.mStallDurations = (StreamConfigurationDuration[]) Preconditions.checkArrayElementsNotNull(stallDurations, "stallDurations");
        if (highSpeedVideoConfigurations == null) {
            this.mHighSpeedVideoConfigurations = new HighSpeedVideoConfiguration[DURATION_MIN_FRAME];
        } else {
            this.mHighSpeedVideoConfigurations = (HighSpeedVideoConfiguration[]) Preconditions.checkArrayElementsNotNull(highSpeedVideoConfigurations, "highSpeedVideoConfigurations");
        }
        StreamConfiguration[] arr$ = configurations;
        int len$ = arr$.length;
        for (i$ = DURATION_MIN_FRAME; i$ < len$; i$ += DURATION_STALL) {
            StreamConfiguration config = arr$[i$];
            HashMap<Integer, Integer> map = config.isOutput() ? this.mOutputFormats : this.mInputFormats;
            Integer count = (Integer) map.get(Integer.valueOf(config.getFormat()));
            if (count == null) {
                count = Integer.valueOf(DURATION_MIN_FRAME);
            }
            map.put(Integer.valueOf(config.getFormat()), Integer.valueOf(count.intValue() + DURATION_STALL));
        }
        if (this.mOutputFormats.containsKey(Integer.valueOf(HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED))) {
            HighSpeedVideoConfiguration[] arr$2 = this.mHighSpeedVideoConfigurations;
            len$ = arr$2.length;
            for (i$ = DURATION_MIN_FRAME; i$ < len$; i$ += DURATION_STALL) {
                HighSpeedVideoConfiguration config2 = arr$2[i$];
                Size size = config2.getSize();
                Range<Integer> fpsRange = config2.getFpsRange();
                Integer fpsRangeCount = (Integer) this.mHighSpeedVideoSizeMap.get(size);
                if (fpsRangeCount == null) {
                    fpsRangeCount = Integer.valueOf(DURATION_MIN_FRAME);
                }
                this.mHighSpeedVideoSizeMap.put(size, Integer.valueOf(fpsRangeCount.intValue() + DURATION_STALL));
                Integer sizeCount = (Integer) this.mHighSpeedVideoFpsRangeMap.get(fpsRange);
                if (sizeCount == null) {
                    sizeCount = Integer.valueOf(DURATION_MIN_FRAME);
                }
                this.mHighSpeedVideoFpsRangeMap.put(fpsRange, Integer.valueOf(sizeCount.intValue() + DURATION_STALL));
            }
            return;
        }
        throw new AssertionError("At least one stream configuration for IMPLEMENTATION_DEFINED must exist");
    }

    public final int[] getOutputFormats() {
        return getPublicFormats(true);
    }

    public final int[] getInputFormats() {
        return getPublicFormats(false);
    }

    public Size[] getInputSizes(int format) {
        return getPublicFormatSizes(format, false);
    }

    public boolean isOutputSupportedFor(int format) {
        checkArgumentFormat(format);
        return getFormatsMap(true).containsKey(Integer.valueOf(imageFormatToInternal(format)));
    }

    public static <T> boolean isOutputSupportedFor(Class<T> klass) {
        Preconditions.checkNotNull(klass, "klass must not be null");
        if (klass == ImageReader.class || klass == MediaRecorder.class || klass == MediaCodec.class || klass == Allocation.class || klass == SurfaceHolder.class || klass == SurfaceTexture.class) {
            return true;
        }
        return false;
    }

    public boolean isOutputSupportedFor(Surface surface) {
        Preconditions.checkNotNull(surface, "surface must not be null");
        try {
            Size surfaceSize = LegacyCameraDevice.getSurfaceSize(surface);
            int surfaceFormat = LegacyCameraDevice.detectSurfaceType(surface);
            boolean isFlexible = LegacyCameraDevice.isFlexibleConsumer(surface);
            if (surfaceFormat >= DURATION_STALL && surfaceFormat <= 5) {
                surfaceFormat = HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED;
            }
            StreamConfiguration[] arr$ = this.mConfigurations;
            int len$ = arr$.length;
            for (int i$ = DURATION_MIN_FRAME; i$ < len$; i$ += DURATION_STALL) {
                StreamConfiguration config = arr$[i$];
                if (config.getFormat() == surfaceFormat && config.isOutput()) {
                    if (config.getSize().equals(surfaceSize)) {
                        return true;
                    }
                    if (isFlexible && config.getSize().getWidth() <= LegacyCameraDevice.MAX_DIMEN_FOR_ROUNDING) {
                        return true;
                    }
                }
            }
            return false;
        } catch (BufferQueueAbandonedException e) {
            throw new IllegalArgumentException("Abandoned surface", e);
        }
    }

    public <T> Size[] getOutputSizes(Class<T> klass) {
        if (ImageReader.class.isAssignableFrom(klass)) {
            return new Size[DURATION_MIN_FRAME];
        }
        if (isOutputSupportedFor((Class) klass)) {
            return getInternalFormatSizes(HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED, true);
        }
        return null;
    }

    public Size[] getOutputSizes(int format) {
        return getPublicFormatSizes(format, true);
    }

    public Size[] getHighSpeedVideoSizes() {
        Set<Size> keySet = this.mHighSpeedVideoSizeMap.keySet();
        return (Size[]) keySet.toArray(new Size[keySet.size()]);
    }

    public Range<Integer>[] getHighSpeedVideoFpsRangesFor(Size size) {
        Integer fpsRangeCount = (Integer) this.mHighSpeedVideoSizeMap.get(size);
        if (fpsRangeCount == null || fpsRangeCount.intValue() == 0) {
            Object[] objArr = new Object[DURATION_STALL];
            objArr[DURATION_MIN_FRAME] = size;
            throw new IllegalArgumentException(String.format("Size %s does not support high speed video recording", objArr));
        }
        Range<Integer>[] fpsRanges = new Range[fpsRangeCount.intValue()];
        HighSpeedVideoConfiguration[] arr$ = this.mHighSpeedVideoConfigurations;
        int len$ = arr$.length;
        int i$ = DURATION_MIN_FRAME;
        int i = DURATION_MIN_FRAME;
        while (i$ < len$) {
            int i2;
            HighSpeedVideoConfiguration config = arr$[i$];
            if (size.equals(config.getSize())) {
                i2 = i + DURATION_STALL;
                fpsRanges[i] = config.getFpsRange();
            } else {
                i2 = i;
            }
            i$ += DURATION_STALL;
            i = i2;
        }
        return fpsRanges;
    }

    public Range<Integer>[] getHighSpeedVideoFpsRanges() {
        Set<Range<Integer>> keySet = this.mHighSpeedVideoFpsRangeMap.keySet();
        return (Range[]) keySet.toArray(new Range[keySet.size()]);
    }

    public Size[] getHighSpeedVideoSizesFor(Range<Integer> fpsRange) {
        Integer sizeCount = (Integer) this.mHighSpeedVideoFpsRangeMap.get(fpsRange);
        if (sizeCount == null || sizeCount.intValue() == 0) {
            Object[] objArr = new Object[DURATION_STALL];
            objArr[DURATION_MIN_FRAME] = fpsRange;
            throw new IllegalArgumentException(String.format("FpsRange %s does not support high speed video recording", objArr));
        }
        Size[] sizes = new Size[sizeCount.intValue()];
        HighSpeedVideoConfiguration[] arr$ = this.mHighSpeedVideoConfigurations;
        int len$ = arr$.length;
        int i$ = DURATION_MIN_FRAME;
        int i = DURATION_MIN_FRAME;
        while (i$ < len$) {
            int i2;
            HighSpeedVideoConfiguration config = arr$[i$];
            if (fpsRange.equals(config.getFpsRange())) {
                i2 = i + DURATION_STALL;
                sizes[i] = config.getSize();
            } else {
                i2 = i;
            }
            i$ += DURATION_STALL;
            i = i2;
        }
        return sizes;
    }

    public long getOutputMinFrameDuration(int format, Size size) {
        Preconditions.checkNotNull(size, "size must not be null");
        checkArgumentFormatSupported(format, true);
        return getInternalFormatDuration(imageFormatToInternal(format), size, DURATION_MIN_FRAME);
    }

    public <T> long getOutputMinFrameDuration(Class<T> klass, Size size) {
        if (isOutputSupportedFor((Class) klass)) {
            return getInternalFormatDuration(HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED, size, DURATION_MIN_FRAME);
        }
        throw new IllegalArgumentException("klass was not supported");
    }

    public long getOutputStallDuration(int format, Size size) {
        checkArgumentFormatSupported(format, true);
        return getInternalFormatDuration(imageFormatToInternal(format), size, DURATION_STALL);
    }

    public <T> long getOutputStallDuration(Class<T> klass, Size size) {
        if (isOutputSupportedFor((Class) klass)) {
            return getInternalFormatDuration(HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED, size, DURATION_STALL);
        }
        throw new IllegalArgumentException("klass was not supported");
    }

    public boolean equals(Object obj) {
        boolean z = true;
        if (obj == null) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof StreamConfigurationMap)) {
            return false;
        }
        StreamConfigurationMap other = (StreamConfigurationMap) obj;
        if (!(Arrays.equals(this.mConfigurations, other.mConfigurations) && Arrays.equals(this.mMinFrameDurations, other.mMinFrameDurations) && Arrays.equals(this.mStallDurations, other.mStallDurations) && Arrays.equals(this.mHighSpeedVideoConfigurations, other.mHighSpeedVideoConfigurations))) {
            z = false;
        }
        return z;
    }

    public int hashCode() {
        return HashCodeHelpers.hashCode(this.mConfigurations, this.mMinFrameDurations, this.mStallDurations, this.mHighSpeedVideoConfigurations);
    }

    private int checkArgumentFormatSupported(int format, boolean output) {
        checkArgumentFormat(format);
        int[] formats = output ? getOutputFormats() : getInputFormats();
        for (int i = DURATION_MIN_FRAME; i < formats.length; i += DURATION_STALL) {
            if (format == formats[i]) {
                return format;
            }
        }
        Object[] objArr = new Object[DURATION_STALL];
        objArr[DURATION_MIN_FRAME] = Integer.valueOf(format);
        throw new IllegalArgumentException(String.format("format %x is not supported by this stream configuration map", objArr));
    }

    static int checkArgumentFormatInternal(int format) {
        switch (format) {
            case HAL_PIXEL_FORMAT_BLOB /*33*/:
            case HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED /*34*/:
            case HAL_PIXEL_FORMAT_RAW_OPAQUE /*36*/:
                return format;
            case InputMethodManager.CONTROL_START_INITIAL /*256*/:
                throw new IllegalArgumentException("ImageFormat.JPEG is an unknown internal format");
            default:
                return checkArgumentFormat(format);
        }
    }

    static int checkArgumentFormat(int format) {
        if (ImageFormat.isPublicFormat(format) || PixelFormat.isPublicFormat(format)) {
            return format;
        }
        Object[] objArr = new Object[DURATION_STALL];
        objArr[DURATION_MIN_FRAME] = Integer.valueOf(format);
        throw new IllegalArgumentException(String.format("format 0x%x was not defined in either ImageFormat or PixelFormat", objArr));
    }

    static int imageFormatToPublic(int format) {
        switch (format) {
            case HAL_PIXEL_FORMAT_BLOB /*33*/:
                return InputMethodManager.CONTROL_START_INITIAL;
            case HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED /*34*/:
                throw new IllegalArgumentException("IMPLEMENTATION_DEFINED must not leak to public API");
            case InputMethodManager.CONTROL_START_INITIAL /*256*/:
                throw new IllegalArgumentException("ImageFormat.JPEG is an unknown internal format");
            default:
                return format;
        }
    }

    static int[] imageFormatToPublic(int[] formats) {
        if (formats == null) {
            return null;
        }
        for (int i = DURATION_MIN_FRAME; i < formats.length; i += DURATION_STALL) {
            formats[i] = imageFormatToPublic(formats[i]);
        }
        return formats;
    }

    static int imageFormatToInternal(int format) {
        switch (format) {
            case HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED /*34*/:
                throw new IllegalArgumentException("IMPLEMENTATION_DEFINED is not allowed via public API");
            case InputMethodManager.CONTROL_START_INITIAL /*256*/:
                return HAL_PIXEL_FORMAT_BLOB;
            default:
                return format;
        }
    }

    public static int[] imageFormatToInternal(int[] formats) {
        if (formats == null) {
            return null;
        }
        for (int i = DURATION_MIN_FRAME; i < formats.length; i += DURATION_STALL) {
            formats[i] = imageFormatToInternal(formats[i]);
        }
        return formats;
    }

    private Size[] getPublicFormatSizes(int format, boolean output) {
        try {
            checkArgumentFormatSupported(format, output);
            return getInternalFormatSizes(imageFormatToInternal(format), output);
        } catch (IllegalArgumentException e) {
            return null;
        }
    }

    private Size[] getInternalFormatSizes(int format, boolean output) {
        Integer sizesCount = (Integer) getFormatsMap(output).get(Integer.valueOf(format));
        if (sizesCount == null) {
            throw new IllegalArgumentException("format not available");
        }
        int len = sizesCount.intValue();
        Size[] sizes = new Size[len];
        StreamConfiguration[] arr$ = this.mConfigurations;
        int len$ = arr$.length;
        int i$ = DURATION_MIN_FRAME;
        int sizeIndex = DURATION_MIN_FRAME;
        while (i$ < len$) {
            int sizeIndex2;
            StreamConfiguration config = arr$[i$];
            if (config.getFormat() == format && config.isOutput() == output) {
                sizeIndex2 = sizeIndex + DURATION_STALL;
                sizes[sizeIndex] = config.getSize();
            } else {
                sizeIndex2 = sizeIndex;
            }
            i$ += DURATION_STALL;
            sizeIndex = sizeIndex2;
        }
        if (sizeIndex == len) {
            return sizes;
        }
        throw new AssertionError("Too few sizes (expected " + len + ", actual " + sizeIndex + ")");
    }

    private int[] getPublicFormats(boolean output) {
        int[] formats = new int[getPublicFormatCount(output)];
        int i = DURATION_MIN_FRAME;
        for (Integer intValue : getFormatsMap(output).keySet()) {
            int format = intValue.intValue();
            if (!(format == HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED || format == HAL_PIXEL_FORMAT_RAW_OPAQUE)) {
                int i2 = i + DURATION_STALL;
                formats[i] = format;
                i = i2;
            }
        }
        if (formats.length == i) {
            return imageFormatToPublic(formats);
        }
        throw new AssertionError("Too few formats " + i + ", expected " + formats.length);
    }

    private HashMap<Integer, Integer> getFormatsMap(boolean output) {
        return output ? this.mOutputFormats : this.mInputFormats;
    }

    private long getInternalFormatDuration(int format, Size size, int duration) {
        if (arrayContains(getInternalFormatSizes(format, true), size)) {
            StreamConfigurationDuration[] arr$ = getDurations(duration);
            int len$ = arr$.length;
            for (int i$ = DURATION_MIN_FRAME; i$ < len$; i$ += DURATION_STALL) {
                StreamConfigurationDuration configurationDuration = arr$[i$];
                if (configurationDuration.getFormat() == format && configurationDuration.getWidth() == size.getWidth() && configurationDuration.getHeight() == size.getHeight()) {
                    return configurationDuration.getDuration();
                }
            }
            return 0;
        }
        throw new IllegalArgumentException("size was not supported");
    }

    private StreamConfigurationDuration[] getDurations(int duration) {
        switch (duration) {
            case DURATION_MIN_FRAME /*0*/:
                return this.mMinFrameDurations;
            case DURATION_STALL /*1*/:
                return this.mStallDurations;
            default:
                throw new IllegalArgumentException("duration was invalid");
        }
    }

    private int getPublicFormatCount(boolean output) {
        HashMap<Integer, Integer> formatsMap = getFormatsMap(output);
        int size = formatsMap.size();
        if (formatsMap.containsKey(Integer.valueOf(HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED))) {
            size--;
        }
        if (formatsMap.containsKey(Integer.valueOf(HAL_PIXEL_FORMAT_RAW_OPAQUE))) {
            return size - 1;
        }
        return size;
    }

    private static <T> boolean arrayContains(T[] array, T element) {
        if (array == null) {
            return false;
        }
        T[] arr$ = array;
        int len$ = arr$.length;
        for (int i$ = DURATION_MIN_FRAME; i$ < len$; i$ += DURATION_STALL) {
            if (Objects.equals(arr$[i$], element)) {
                return true;
            }
        }
        return false;
    }
}
