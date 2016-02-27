package android.media;

import android.bluetooth.BluetoothHealth;
import android.mtp.MtpConstants;
import android.net.LinkQualityInfo;
import android.opengl.GLES10;
import android.opengl.GLES20;
import android.os.Process;
import android.os.UserHandle;
import android.text.format.DateUtils;
import android.util.Log;
import android.util.Pair;
import android.util.Range;
import android.util.Rational;
import android.util.Size;
import android.view.KeyEvent;
import android.view.SurfaceControl;
import android.view.Window;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManagerPolicy;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.RelativeLayout;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public final class MediaCodecInfo {
    private static final Range<Integer> BITRATE_RANGE;
    private static final int ERROR_NONE_SUPPORTED = 4;
    private static final int ERROR_UNRECOGNIZED = 1;
    private static final int ERROR_UNSUPPORTED = 2;
    private static final Range<Integer> FRAME_RATE_RANGE;
    private static final Range<Integer> POSITIVE_INTEGERS;
    private static final Range<Long> POSITIVE_LONGS;
    private static final Range<Rational> POSITIVE_RATIONALS;
    private static final Range<Integer> SIZE_RANGE;
    private Map<String, CodecCapabilities> mCaps;
    private boolean mIsEncoder;
    private String mName;

    public static final class AudioCapabilities {
        private static final int MAX_INPUT_CHANNEL_COUNT = 30;
        private static final String TAG = "AudioCapabilities";
        private Range<Integer> mBitrateRange;
        private int mMaxInputChannelCount;
        private CodecCapabilities mParent;
        private Range<Integer>[] mSampleRateRanges;
        private int[] mSampleRates;

        public Range<Integer> getBitrateRange() {
            return this.mBitrateRange;
        }

        public int[] getSupportedSampleRates() {
            return Arrays.copyOf(this.mSampleRates, this.mSampleRates.length);
        }

        public Range<Integer>[] getSupportedSampleRateRanges() {
            return (Range[]) Arrays.copyOf(this.mSampleRateRanges, this.mSampleRateRanges.length);
        }

        public int getMaxInputChannelCount() {
            return this.mMaxInputChannelCount;
        }

        private AudioCapabilities() {
        }

        public static AudioCapabilities create(MediaFormat info, CodecCapabilities parent) {
            AudioCapabilities caps = new AudioCapabilities();
            caps.init(info, parent);
            return caps;
        }

        public void init(MediaFormat info, CodecCapabilities parent) {
            this.mParent = parent;
            initWithPlatformLimits();
            applyLevelLimits();
            parseFromInfo(info);
        }

        private void initWithPlatformLimits() {
            this.mBitrateRange = Range.create(Integer.valueOf(0), Integer.valueOf(ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED));
            this.mMaxInputChannelCount = MAX_INPUT_CHANNEL_COUNT;
            Range[] rangeArr = new Range[MediaCodecInfo.ERROR_UNRECOGNIZED];
            rangeArr[0] = Range.create(Integer.valueOf(8000), Integer.valueOf(96000));
            this.mSampleRateRanges = rangeArr;
            this.mSampleRates = null;
        }

        private boolean supports(Integer sampleRate, Integer inputChannels) {
            if (inputChannels != null && (inputChannels.intValue() < MediaCodecInfo.ERROR_UNRECOGNIZED || inputChannels.intValue() > this.mMaxInputChannelCount)) {
                return false;
            }
            if (sampleRate == null || Utils.binarySearchDistinctRanges(this.mSampleRateRanges, sampleRate) >= 0) {
                return true;
            }
            return false;
        }

        public boolean isSampleRateSupported(int sampleRate) {
            return supports(Integer.valueOf(sampleRate), null);
        }

        private void limitSampleRates(int[] rates) {
            Arrays.sort(rates);
            ArrayList<Range<Integer>> ranges = new ArrayList();
            int[] arr$ = rates;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += MediaCodecInfo.ERROR_UNRECOGNIZED) {
                int rate = arr$[i$];
                if (supports(Integer.valueOf(rate), null)) {
                    ranges.add(Range.create(Integer.valueOf(rate), Integer.valueOf(rate)));
                }
            }
            this.mSampleRateRanges = (Range[]) ranges.toArray(new Range[ranges.size()]);
            createDiscreteSampleRates();
        }

        private void createDiscreteSampleRates() {
            this.mSampleRates = new int[this.mSampleRateRanges.length];
            for (int i = 0; i < this.mSampleRateRanges.length; i += MediaCodecInfo.ERROR_UNRECOGNIZED) {
                this.mSampleRates[i] = ((Integer) this.mSampleRateRanges[i].getLower()).intValue();
            }
        }

        private void limitSampleRates(Range<Integer>[] rateRanges) {
            Utils.sortDistinctRanges(rateRanges);
            this.mSampleRateRanges = Utils.intersectSortedDistinctRanges(this.mSampleRateRanges, rateRanges);
            Range[] arr$ = this.mSampleRateRanges;
            int len$ = arr$.length;
            int i$ = 0;
            while (i$ < len$) {
                Range<Integer> range = arr$[i$];
                if (((Integer) range.getLower()).equals(range.getUpper())) {
                    i$ += MediaCodecInfo.ERROR_UNRECOGNIZED;
                } else {
                    this.mSampleRates = null;
                    return;
                }
            }
            createDiscreteSampleRates();
        }

        private void applyLevelLimits() {
            int[] sampleRates = null;
            Range<Integer> sampleRateRange = null;
            Range<Integer> bitRates = null;
            int maxChannels = 0;
            String mime = this.mParent.getMimeType();
            if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_MPEG)) {
                sampleRates = new int[]{8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000};
                bitRates = Range.create(Integer.valueOf(8000), Integer.valueOf(320000));
                maxChannels = MediaCodecInfo.ERROR_UNSUPPORTED;
            } else if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_AMR_NB)) {
                sampleRates = new int[MediaCodecInfo.ERROR_UNRECOGNIZED];
                sampleRates[0] = 8000;
                bitRates = Range.create(Integer.valueOf(4750), Integer.valueOf(12200));
                maxChannels = MediaCodecInfo.ERROR_UNRECOGNIZED;
            } else if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_AMR_WB)) {
                sampleRates = new int[MediaCodecInfo.ERROR_UNRECOGNIZED];
                sampleRates[0] = 16000;
                bitRates = Range.create(Integer.valueOf(6600), Integer.valueOf(23850));
                maxChannels = MediaCodecInfo.ERROR_UNRECOGNIZED;
            } else if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_AAC)) {
                sampleRates = new int[]{7350, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000, 64000, 88200, 96000};
                bitRates = Range.create(Integer.valueOf(8000), Integer.valueOf(510000));
                maxChannels = 48;
            } else if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_VORBIS)) {
                bitRates = Range.create(Integer.valueOf(32000), Integer.valueOf(500000));
                sampleRateRange = Range.create(Integer.valueOf(8000), Integer.valueOf(192000));
                maxChannels = EditorInfo.IME_MASK_ACTION;
            } else if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_OPUS)) {
                bitRates = Range.create(Integer.valueOf(BluetoothHealth.HEALTH_OPERATION_SUCCESS), Integer.valueOf(510000));
                sampleRates = new int[]{8000, 12000, 16000, 24000, 48000};
                maxChannels = EditorInfo.IME_MASK_ACTION;
            } else if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_RAW)) {
                sampleRateRange = Range.create(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(96000));
                bitRates = Range.create(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(10000000));
                maxChannels = 8;
            } else if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_FLAC)) {
                sampleRateRange = Range.create(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(655350));
                maxChannels = EditorInfo.IME_MASK_ACTION;
            } else if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_G711_ALAW) || mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_G711_MLAW)) {
                sampleRates = new int[MediaCodecInfo.ERROR_UNRECOGNIZED];
                sampleRates[0] = 8000;
                bitRates = Range.create(Integer.valueOf(64000), Integer.valueOf(64000));
            } else if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_MSGSM)) {
                sampleRates = new int[MediaCodecInfo.ERROR_UNRECOGNIZED];
                sampleRates[0] = 8000;
                bitRates = Range.create(Integer.valueOf(13000), Integer.valueOf(13000));
                maxChannels = MediaCodecInfo.ERROR_UNRECOGNIZED;
            } else {
                Log.w(TAG, "Unsupported mime " + mime);
                CodecCapabilities codecCapabilities = this.mParent;
                codecCapabilities.mError |= MediaCodecInfo.ERROR_UNSUPPORTED;
            }
            if (sampleRates != null) {
                limitSampleRates(sampleRates);
            } else if (sampleRateRange != null) {
                Range[] rangeArr = new Range[MediaCodecInfo.ERROR_UNRECOGNIZED];
                rangeArr[0] = sampleRateRange;
                limitSampleRates(rangeArr);
            }
            applyLimits(maxChannels, bitRates);
        }

        private void applyLimits(int maxInputChannels, Range<Integer> bitRates) {
            this.mMaxInputChannelCount = ((Integer) Range.create(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(this.mMaxInputChannelCount)).clamp(Integer.valueOf(maxInputChannels))).intValue();
            if (bitRates != null) {
                this.mBitrateRange = this.mBitrateRange.intersect(bitRates);
            }
        }

        private void parseFromInfo(MediaFormat info) {
            int maxInputChannels = MAX_INPUT_CHANNEL_COUNT;
            Range<Integer> bitRates = MediaCodecInfo.POSITIVE_INTEGERS;
            if (info.containsKey("sample-rate-ranges")) {
                String[] rateStrings = info.getString("sample-rate-ranges").split(",");
                Range[] rateRanges = new Range[rateStrings.length];
                for (int i = 0; i < rateStrings.length; i += MediaCodecInfo.ERROR_UNRECOGNIZED) {
                    rateRanges[i] = Utils.parseIntRange(rateStrings[i], null);
                }
                limitSampleRates(rateRanges);
            }
            if (info.containsKey("max-channel-count")) {
                maxInputChannels = Utils.parseIntSafely(info.getString("max-channel-count"), MAX_INPUT_CHANNEL_COUNT);
            }
            if (info.containsKey("bitrate-range")) {
                bitRates = bitRates.intersect(Utils.parseIntRange(info.getString("bitrate-range"), bitRates));
            }
            applyLimits(maxInputChannels, bitRates);
        }

        public void setDefaultFormat(MediaFormat format) {
            if (((Integer) this.mBitrateRange.getLower()).equals(this.mBitrateRange.getUpper())) {
                format.setInteger(MediaFormat.KEY_BIT_RATE, ((Integer) this.mBitrateRange.getLower()).intValue());
            }
            if (this.mMaxInputChannelCount == MediaCodecInfo.ERROR_UNRECOGNIZED) {
                format.setInteger(MediaFormat.KEY_CHANNEL_COUNT, MediaCodecInfo.ERROR_UNRECOGNIZED);
            }
            if (this.mSampleRates != null && this.mSampleRates.length == MediaCodecInfo.ERROR_UNRECOGNIZED) {
                format.setInteger(MediaFormat.KEY_SAMPLE_RATE, this.mSampleRates[0]);
            }
        }

        public boolean supportsFormat(MediaFormat format) {
            Map<String, Object> map = format.getMap();
            if (supports((Integer) map.get(MediaFormat.KEY_SAMPLE_RATE), (Integer) map.get(MediaFormat.KEY_CHANNEL_COUNT))) {
                return true;
            }
            return false;
        }
    }

    public static final class CodecCapabilities {
        public static final int COLOR_Format12bitRGB444 = 3;
        public static final int COLOR_Format16bitARGB1555 = 5;
        public static final int COLOR_Format16bitARGB4444 = 4;
        public static final int COLOR_Format16bitBGR565 = 7;
        public static final int COLOR_Format16bitRGB565 = 6;
        public static final int COLOR_Format18BitBGR666 = 41;
        public static final int COLOR_Format18bitARGB1665 = 9;
        public static final int COLOR_Format18bitRGB666 = 8;
        public static final int COLOR_Format19bitARGB1666 = 10;
        public static final int COLOR_Format24BitABGR6666 = 43;
        public static final int COLOR_Format24BitARGB6666 = 42;
        public static final int COLOR_Format24bitARGB1887 = 13;
        public static final int COLOR_Format24bitBGR888 = 12;
        public static final int COLOR_Format24bitRGB888 = 11;
        public static final int COLOR_Format25bitARGB1888 = 14;
        public static final int COLOR_Format32bitARGB8888 = 16;
        public static final int COLOR_Format32bitBGRA8888 = 15;
        public static final int COLOR_Format8bitRGB332 = 2;
        public static final int COLOR_FormatCbYCrY = 27;
        public static final int COLOR_FormatCrYCbY = 28;
        public static final int COLOR_FormatL16 = 36;
        public static final int COLOR_FormatL2 = 33;
        public static final int COLOR_FormatL24 = 37;
        public static final int COLOR_FormatL32 = 38;
        public static final int COLOR_FormatL4 = 34;
        public static final int COLOR_FormatL8 = 35;
        public static final int COLOR_FormatMonochrome = 1;
        public static final int COLOR_FormatRawBayer10bit = 31;
        public static final int COLOR_FormatRawBayer8bit = 30;
        public static final int COLOR_FormatRawBayer8bitcompressed = 32;
        public static final int COLOR_FormatSurface = 2130708361;
        public static final int COLOR_FormatYCbYCr = 25;
        public static final int COLOR_FormatYCrYCb = 26;
        public static final int COLOR_FormatYUV411PackedPlanar = 18;
        public static final int COLOR_FormatYUV411Planar = 17;
        public static final int COLOR_FormatYUV420Flexible = 2135033992;
        public static final int COLOR_FormatYUV420PackedPlanar = 20;
        public static final int COLOR_FormatYUV420PackedSemiPlanar = 39;
        public static final int COLOR_FormatYUV420Planar = 19;
        public static final int COLOR_FormatYUV420SemiPlanar = 21;
        public static final int COLOR_FormatYUV422PackedPlanar = 23;
        public static final int COLOR_FormatYUV422PackedSemiPlanar = 40;
        public static final int COLOR_FormatYUV422Planar = 22;
        public static final int COLOR_FormatYUV422SemiPlanar = 24;
        public static final int COLOR_FormatYUV444Interleaved = 29;
        public static final int COLOR_QCOM_FormatYUV420SemiPlanar = 2141391872;
        public static final int COLOR_TI_FormatYUV420PackedSemiPlanar = 2130706688;
        public static final String FEATURE_AdaptivePlayback = "adaptive-playback";
        public static final String FEATURE_SecurePlayback = "secure-playback";
        public static final String FEATURE_TunneledPlayback = "tunneled-playback";
        private static final String TAG = "CodecCapabilities";
        private static final Feature[] decoderFeatures;
        public int[] colorFormats;
        private AudioCapabilities mAudioCaps;
        private MediaFormat mCapabilitiesInfo;
        private MediaFormat mDefaultFormat;
        private EncoderCapabilities mEncoderCaps;
        int mError;
        private int mFlagsRequired;
        private int mFlagsSupported;
        private int mFlagsVerified;
        private String mMime;
        private VideoCapabilities mVideoCaps;
        public CodecProfileLevel[] profileLevels;

        public final boolean isFeatureSupported(String name) {
            return checkFeature(name, this.mFlagsSupported);
        }

        public final boolean isFeatureRequired(String name) {
            return checkFeature(name, this.mFlagsRequired);
        }

        static {
            Feature[] featureArr = new Feature[COLOR_Format12bitRGB444];
            featureArr[0] = new Feature(FEATURE_AdaptivePlayback, COLOR_FormatMonochrome, true);
            featureArr[COLOR_FormatMonochrome] = new Feature(FEATURE_SecurePlayback, COLOR_Format8bitRGB332, false);
            featureArr[COLOR_Format8bitRGB332] = new Feature(FEATURE_TunneledPlayback, COLOR_Format16bitARGB4444, false);
            decoderFeatures = featureArr;
        }

        public String[] validFeatures() {
            Feature[] features = getValidFeatures();
            String[] res = new String[features.length];
            for (int i = 0; i < res.length; i += COLOR_FormatMonochrome) {
                res[i] = features[i].mName;
            }
            return res;
        }

        private Feature[] getValidFeatures() {
            if (isEncoder()) {
                return new Feature[0];
            }
            return decoderFeatures;
        }

        private boolean checkFeature(String name, int flags) {
            Feature[] arr$ = getValidFeatures();
            int len$ = arr$.length;
            int i$ = 0;
            while (i$ < len$) {
                Feature feat = arr$[i$];
                if (!feat.mName.equals(name)) {
                    i$ += COLOR_FormatMonochrome;
                } else if ((feat.mValue & flags) != 0) {
                    return true;
                } else {
                    return false;
                }
            }
            return false;
        }

        public boolean isRegular() {
            Feature[] arr$ = getValidFeatures();
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += COLOR_FormatMonochrome) {
                Feature feat = arr$[i$];
                if (!feat.mDefault && isFeatureRequired(feat.mName)) {
                    return false;
                }
            }
            return true;
        }

        public final boolean isFormatSupported(MediaFormat format) {
            Map<String, Object> map = format.getMap();
            String mime = (String) map.get(MediaFormat.KEY_MIME);
            if (mime != null && !this.mMime.equalsIgnoreCase(mime)) {
                return false;
            }
            Feature[] arr$ = getValidFeatures();
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += COLOR_FormatMonochrome) {
                Feature feat = arr$[i$];
                Integer yesNo = (Integer) map.get(MediaFormat.KEY_FEATURE_ + feat.mName);
                if (yesNo != null) {
                    if (yesNo.intValue() == COLOR_FormatMonochrome && !isFeatureSupported(feat.mName)) {
                        return false;
                    }
                    if (yesNo.intValue() == 0 && isFeatureRequired(feat.mName)) {
                        return false;
                    }
                }
            }
            if (this.mAudioCaps != null && !this.mAudioCaps.supportsFormat(format)) {
                return false;
            }
            if (this.mVideoCaps != null && !this.mVideoCaps.supportsFormat(format)) {
                return false;
            }
            if (this.mEncoderCaps == null || this.mEncoderCaps.supportsFormat(format)) {
                return true;
            }
            return false;
        }

        public MediaFormat getDefaultFormat() {
            return this.mDefaultFormat;
        }

        public String getMimeType() {
            return this.mMime;
        }

        private boolean isAudio() {
            return this.mAudioCaps != null;
        }

        public AudioCapabilities getAudioCapabilities() {
            return this.mAudioCaps;
        }

        private boolean isEncoder() {
            return this.mEncoderCaps != null;
        }

        public EncoderCapabilities getEncoderCapabilities() {
            return this.mEncoderCaps;
        }

        private boolean isVideo() {
            return this.mVideoCaps != null;
        }

        public VideoCapabilities getVideoCapabilities() {
            return this.mVideoCaps;
        }

        public CodecCapabilities dup() {
            return new CodecCapabilities((CodecProfileLevel[]) Arrays.copyOf(this.profileLevels, this.profileLevels.length), Arrays.copyOf(this.colorFormats, this.colorFormats.length), isEncoder(), this.mFlagsVerified, this.mDefaultFormat, this.mCapabilitiesInfo);
        }

        public static CodecCapabilities createFromProfileLevel(String mime, int profile, int level) {
            CodecProfileLevel pl = new CodecProfileLevel();
            pl.profile = profile;
            pl.level = level;
            MediaFormat defaultFormat = new MediaFormat();
            defaultFormat.setString(MediaFormat.KEY_MIME, mime);
            CodecProfileLevel[] codecProfileLevelArr = new CodecProfileLevel[COLOR_FormatMonochrome];
            codecProfileLevelArr[0] = pl;
            CodecCapabilities ret = new CodecCapabilities(codecProfileLevelArr, new int[0], true, 0, defaultFormat, new MediaFormat());
            if (ret.mError != 0) {
                return null;
            }
            return ret;
        }

        CodecCapabilities(CodecProfileLevel[] profLevs, int[] colFmts, boolean encoder, int flags, Map<String, Object> defaultFormatMap, Map<String, Object> capabilitiesMap) {
            this(profLevs, colFmts, encoder, flags, new MediaFormat(defaultFormatMap), new MediaFormat(capabilitiesMap));
        }

        CodecCapabilities(CodecProfileLevel[] profLevs, int[] colFmts, boolean encoder, int flags, MediaFormat defaultFormat, MediaFormat info) {
            Map<String, Object> map = info.getMap();
            this.profileLevels = profLevs;
            this.colorFormats = colFmts;
            this.mFlagsVerified = flags;
            this.mDefaultFormat = defaultFormat;
            this.mCapabilitiesInfo = info;
            this.mMime = this.mDefaultFormat.getString(MediaFormat.KEY_MIME);
            if (this.mMime.toLowerCase().startsWith("audio/")) {
                this.mAudioCaps = AudioCapabilities.create(info, this);
                this.mAudioCaps.setDefaultFormat(this.mDefaultFormat);
            } else if (this.mMime.toLowerCase().startsWith("video/")) {
                this.mVideoCaps = VideoCapabilities.create(info, this);
            }
            if (encoder) {
                this.mEncoderCaps = EncoderCapabilities.create(info, this);
                this.mEncoderCaps.setDefaultFormat(this.mDefaultFormat);
            }
            Feature[] arr$ = getValidFeatures();
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += COLOR_FormatMonochrome) {
                Feature feat = arr$[i$];
                String key = MediaFormat.KEY_FEATURE_ + feat.mName;
                Integer yesNo = (Integer) map.get(key);
                if (yesNo != null) {
                    if (yesNo.intValue() > 0) {
                        this.mFlagsRequired |= feat.mValue;
                    }
                    this.mFlagsSupported |= feat.mValue;
                    this.mDefaultFormat.setInteger(key, COLOR_FormatMonochrome);
                }
            }
        }
    }

    public static final class CodecProfileLevel {
        public static final int AACObjectELD = 39;
        public static final int AACObjectERLC = 17;
        public static final int AACObjectHE = 5;
        public static final int AACObjectHE_PS = 29;
        public static final int AACObjectLC = 2;
        public static final int AACObjectLD = 23;
        public static final int AACObjectLTP = 4;
        public static final int AACObjectMain = 1;
        public static final int AACObjectSSR = 3;
        public static final int AACObjectScalable = 6;
        public static final int AVCLevel1 = 1;
        public static final int AVCLevel11 = 4;
        public static final int AVCLevel12 = 8;
        public static final int AVCLevel13 = 16;
        public static final int AVCLevel1b = 2;
        public static final int AVCLevel2 = 32;
        public static final int AVCLevel21 = 64;
        public static final int AVCLevel22 = 128;
        public static final int AVCLevel3 = 256;
        public static final int AVCLevel31 = 512;
        public static final int AVCLevel32 = 1024;
        public static final int AVCLevel4 = 2048;
        public static final int AVCLevel41 = 4096;
        public static final int AVCLevel42 = 8192;
        public static final int AVCLevel5 = 16384;
        public static final int AVCLevel51 = 32768;
        public static final int AVCLevel52 = 65536;
        public static final int AVCProfileBaseline = 1;
        public static final int AVCProfileExtended = 4;
        public static final int AVCProfileHigh = 8;
        public static final int AVCProfileHigh10 = 16;
        public static final int AVCProfileHigh422 = 32;
        public static final int AVCProfileHigh444 = 64;
        public static final int AVCProfileMain = 2;
        public static final int H263Level10 = 1;
        public static final int H263Level20 = 2;
        public static final int H263Level30 = 4;
        public static final int H263Level40 = 8;
        public static final int H263Level45 = 16;
        public static final int H263Level50 = 32;
        public static final int H263Level60 = 64;
        public static final int H263Level70 = 128;
        public static final int H263ProfileBackwardCompatible = 4;
        public static final int H263ProfileBaseline = 1;
        public static final int H263ProfileH320Coding = 2;
        public static final int H263ProfileHighCompression = 32;
        public static final int H263ProfileHighLatency = 256;
        public static final int H263ProfileISWV2 = 8;
        public static final int H263ProfileISWV3 = 16;
        public static final int H263ProfileInterlace = 128;
        public static final int H263ProfileInternet = 64;
        public static final int HEVCHighTierLevel1 = 2;
        public static final int HEVCHighTierLevel2 = 8;
        public static final int HEVCHighTierLevel21 = 32;
        public static final int HEVCHighTierLevel3 = 128;
        public static final int HEVCHighTierLevel31 = 512;
        public static final int HEVCHighTierLevel4 = 2048;
        public static final int HEVCHighTierLevel41 = 8192;
        public static final int HEVCHighTierLevel5 = 32768;
        public static final int HEVCHighTierLevel51 = 131072;
        public static final int HEVCHighTierLevel52 = 524288;
        public static final int HEVCHighTierLevel6 = 2097152;
        public static final int HEVCHighTierLevel61 = 8388608;
        public static final int HEVCHighTierLevel62 = 33554432;
        public static final int HEVCMainTierLevel1 = 1;
        public static final int HEVCMainTierLevel2 = 4;
        public static final int HEVCMainTierLevel21 = 16;
        public static final int HEVCMainTierLevel3 = 64;
        public static final int HEVCMainTierLevel31 = 256;
        public static final int HEVCMainTierLevel4 = 1024;
        public static final int HEVCMainTierLevel41 = 4096;
        public static final int HEVCMainTierLevel5 = 16384;
        public static final int HEVCMainTierLevel51 = 65536;
        public static final int HEVCMainTierLevel52 = 262144;
        public static final int HEVCMainTierLevel6 = 1048576;
        public static final int HEVCMainTierLevel61 = 4194304;
        public static final int HEVCMainTierLevel62 = 16777216;
        public static final int HEVCProfileMain = 1;
        public static final int HEVCProfileMain10 = 2;
        public static final int MPEG4Level0 = 1;
        public static final int MPEG4Level0b = 2;
        public static final int MPEG4Level1 = 4;
        public static final int MPEG4Level2 = 8;
        public static final int MPEG4Level3 = 16;
        public static final int MPEG4Level4 = 32;
        public static final int MPEG4Level4a = 64;
        public static final int MPEG4Level5 = 128;
        public static final int MPEG4ProfileAdvancedCoding = 4096;
        public static final int MPEG4ProfileAdvancedCore = 8192;
        public static final int MPEG4ProfileAdvancedRealTime = 1024;
        public static final int MPEG4ProfileAdvancedScalable = 16384;
        public static final int MPEG4ProfileAdvancedSimple = 32768;
        public static final int MPEG4ProfileBasicAnimated = 256;
        public static final int MPEG4ProfileCore = 4;
        public static final int MPEG4ProfileCoreScalable = 2048;
        public static final int MPEG4ProfileHybrid = 512;
        public static final int MPEG4ProfileMain = 8;
        public static final int MPEG4ProfileNbit = 16;
        public static final int MPEG4ProfileScalableTexture = 32;
        public static final int MPEG4ProfileSimple = 1;
        public static final int MPEG4ProfileSimpleFBA = 128;
        public static final int MPEG4ProfileSimpleFace = 64;
        public static final int MPEG4ProfileSimpleScalable = 2;
        public static final int VP8Level_Version0 = 1;
        public static final int VP8Level_Version1 = 2;
        public static final int VP8Level_Version2 = 4;
        public static final int VP8Level_Version3 = 8;
        public static final int VP8ProfileMain = 1;
        public int level;
        public int profile;
    }

    public static final class EncoderCapabilities {
        public static final int BITRATE_MODE_CBR = 2;
        public static final int BITRATE_MODE_CQ = 0;
        public static final int BITRATE_MODE_VBR = 1;
        private static final Feature[] bitrates;
        private int mBitControl;
        private Range<Integer> mComplexityRange;
        private Integer mDefaultComplexity;
        private Integer mDefaultQuality;
        private CodecCapabilities mParent;
        private Range<Integer> mQualityRange;
        private String mQualityScale;

        public Range<Integer> getQualityRange() {
            return this.mQualityRange;
        }

        public Range<Integer> getComplexityRange() {
            return this.mComplexityRange;
        }

        static {
            bitrates = new Feature[]{new Feature("VBR", BITRATE_MODE_VBR, true), new Feature("CBR", BITRATE_MODE_CBR, false), new Feature("CQ", BITRATE_MODE_CQ, false)};
        }

        private static int parseBitrateMode(String mode) {
            Feature[] arr$ = bitrates;
            int len$ = arr$.length;
            for (int i$ = BITRATE_MODE_CQ; i$ < len$; i$ += BITRATE_MODE_VBR) {
                Feature feat = arr$[i$];
                if (feat.mName.equalsIgnoreCase(mode)) {
                    return feat.mValue;
                }
            }
            return BITRATE_MODE_CQ;
        }

        public boolean isBitrateModeSupported(int mode) {
            Feature[] arr$ = bitrates;
            int len$ = arr$.length;
            int i$ = BITRATE_MODE_CQ;
            while (i$ < len$) {
                if (mode != arr$[i$].mValue) {
                    i$ += BITRATE_MODE_VBR;
                } else if ((this.mBitControl & (BITRATE_MODE_VBR << mode)) != 0) {
                    return true;
                } else {
                    return false;
                }
            }
            return false;
        }

        private EncoderCapabilities() {
        }

        public static EncoderCapabilities create(MediaFormat info, CodecCapabilities parent) {
            EncoderCapabilities caps = new EncoderCapabilities();
            caps.init(info, parent);
            return caps;
        }

        public void init(MediaFormat info, CodecCapabilities parent) {
            this.mParent = parent;
            this.mComplexityRange = Range.create(Integer.valueOf(BITRATE_MODE_CQ), Integer.valueOf(BITRATE_MODE_CQ));
            this.mQualityRange = Range.create(Integer.valueOf(BITRATE_MODE_CQ), Integer.valueOf(BITRATE_MODE_CQ));
            this.mBitControl = BITRATE_MODE_CBR;
            applyLevelLimits();
            parseFromInfo(info);
        }

        private void applyLevelLimits() {
            String mime = this.mParent.getMimeType();
            if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_FLAC)) {
                this.mComplexityRange = Range.create(Integer.valueOf(BITRATE_MODE_CQ), Integer.valueOf(8));
                this.mBitControl = BITRATE_MODE_VBR;
            } else if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_AMR_NB) || mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_AMR_WB) || mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_G711_ALAW) || mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_G711_MLAW) || mime.equalsIgnoreCase(MediaFormat.MIMETYPE_AUDIO_MSGSM)) {
                this.mBitControl = MediaCodecInfo.ERROR_NONE_SUPPORTED;
            }
        }

        private void parseFromInfo(MediaFormat info) {
            Map<String, Object> map = info.getMap();
            if (info.containsKey("complexity-range")) {
                this.mComplexityRange = Utils.parseIntRange(info.getString("complexity-range"), this.mComplexityRange);
            }
            if (info.containsKey("quality-range")) {
                this.mQualityRange = Utils.parseIntRange(info.getString("quality-range"), this.mQualityRange);
            }
            if (info.containsKey("feature-bitrate-control")) {
                String[] arr$ = info.getString("feature-bitrate-control").split(",");
                int len$ = arr$.length;
                for (int i$ = BITRATE_MODE_CQ; i$ < len$; i$ += BITRATE_MODE_VBR) {
                    this.mBitControl |= parseBitrateMode(arr$[i$]);
                }
            }
            try {
                this.mDefaultComplexity = Integer.valueOf(Integer.parseInt((String) map.get("complexity-default")));
            } catch (NumberFormatException e) {
            }
            try {
                this.mDefaultQuality = Integer.valueOf(Integer.parseInt((String) map.get("quality-default")));
            } catch (NumberFormatException e2) {
            }
            this.mQualityScale = (String) map.get("quality-scale");
        }

        private boolean supports(Integer complexity, Integer quality, Integer profile) {
            boolean ok = true;
            if (!(BITRATE_MODE_VBR == null || complexity == null)) {
                ok = this.mComplexityRange.contains(complexity);
            }
            if (ok && quality != null) {
                ok = this.mQualityRange.contains(quality);
            }
            if (!ok || profile == null) {
                return ok;
            }
            CodecProfileLevel[] arr$ = this.mParent.profileLevels;
            int len$ = arr$.length;
            for (int i$ = BITRATE_MODE_CQ; i$ < len$; i$ += BITRATE_MODE_VBR) {
                if (arr$[i$].profile == profile.intValue()) {
                    profile = null;
                    break;
                }
            }
            return profile == null;
        }

        public void setDefaultFormat(MediaFormat format) {
            if (!(((Integer) this.mQualityRange.getUpper()).equals(this.mQualityRange.getLower()) || this.mDefaultQuality == null)) {
                format.setInteger(MediaFormat.KEY_QUALITY, this.mDefaultQuality.intValue());
            }
            if (!(((Integer) this.mComplexityRange.getUpper()).equals(this.mComplexityRange.getLower()) || this.mDefaultComplexity == null)) {
                format.setInteger(MediaFormat.KEY_COMPLEXITY, this.mDefaultComplexity.intValue());
            }
            Feature[] arr$ = bitrates;
            int len$ = arr$.length;
            for (int i$ = BITRATE_MODE_CQ; i$ < len$; i$ += BITRATE_MODE_VBR) {
                Feature feat = arr$[i$];
                if ((this.mBitControl & (BITRATE_MODE_VBR << feat.mValue)) != 0) {
                    format.setInteger(MediaFormat.KEY_BITRATE_MODE, feat.mValue);
                    return;
                }
            }
        }

        public boolean supportsFormat(MediaFormat format) {
            Map<String, Object> map = format.getMap();
            String mime = this.mParent.getMimeType();
            Integer mode = (Integer) map.get(MediaFormat.KEY_BITRATE_MODE);
            if (mode != null && !isBitrateModeSupported(mode.intValue())) {
                return false;
            }
            Integer complexity = (Integer) map.get(MediaFormat.KEY_COMPLEXITY);
            if (MediaFormat.MIMETYPE_AUDIO_FLAC.equalsIgnoreCase(mime)) {
                Integer flacComplexity = (Integer) map.get(MediaFormat.KEY_FLAC_COMPRESSION_LEVEL);
                if (complexity == null) {
                    complexity = flacComplexity;
                } else if (!(flacComplexity == null || complexity.equals(flacComplexity))) {
                    throw new IllegalArgumentException("conflicting values for complexity and flac-compression-level");
                }
            }
            Integer profile = (Integer) map.get(MediaFormat.KEY_PROFILE);
            if (MediaFormat.MIMETYPE_AUDIO_AAC.equalsIgnoreCase(mime)) {
                Integer aacProfile = (Integer) map.get(MediaFormat.KEY_AAC_PROFILE);
                if (profile == null) {
                    profile = aacProfile;
                } else if (!(aacProfile == null || aacProfile.equals(profile))) {
                    throw new IllegalArgumentException("conflicting values for profile and aac-profile");
                }
            }
            return supports(complexity, (Integer) map.get(MediaFormat.KEY_QUALITY), profile);
        }
    }

    private static class Feature {
        public boolean mDefault;
        public String mName;
        public int mValue;

        public Feature(String name, int value, boolean def) {
            this.mName = name;
            this.mValue = value;
            this.mDefault = def;
        }
    }

    public static final class VideoCapabilities {
        private static final String TAG = "VideoCapabilities";
        private Range<Rational> mAspectRatioRange;
        private Range<Integer> mBitrateRange;
        private Range<Rational> mBlockAspectRatioRange;
        private Range<Integer> mBlockCountRange;
        private int mBlockHeight;
        private int mBlockWidth;
        private Range<Long> mBlocksPerSecondRange;
        private Range<Integer> mFrameRateRange;
        private int mHeightAlignment;
        private Range<Integer> mHeightRange;
        private Range<Integer> mHorizontalBlockRange;
        private CodecCapabilities mParent;
        private int mSmallerDimensionUpperLimit;
        private Range<Integer> mVerticalBlockRange;
        private int mWidthAlignment;
        private Range<Integer> mWidthRange;

        public Range<Integer> getBitrateRange() {
            return this.mBitrateRange;
        }

        public Range<Integer> getSupportedWidths() {
            return this.mWidthRange;
        }

        public Range<Integer> getSupportedHeights() {
            return this.mHeightRange;
        }

        public int getWidthAlignment() {
            return this.mWidthAlignment;
        }

        public int getHeightAlignment() {
            return this.mHeightAlignment;
        }

        public int getSmallerDimensionUpperLimit() {
            return this.mSmallerDimensionUpperLimit;
        }

        public Range<Integer> getSupportedFrameRates() {
            return this.mFrameRateRange;
        }

        public Range<Integer> getSupportedWidthsFor(int height) {
            try {
                Range<Integer> range = this.mWidthRange;
                if (this.mHeightRange.contains(Integer.valueOf(height)) && height % this.mHeightAlignment == 0) {
                    int heightInBlocks = Utils.divUp(height, this.mBlockHeight);
                    range = range.intersect(Integer.valueOf(((Math.max(Utils.divUp(((Integer) this.mBlockCountRange.getLower()).intValue(), heightInBlocks), (int) Math.ceil(((Rational) this.mBlockAspectRatioRange.getLower()).doubleValue() * ((double) heightInBlocks))) - 1) * this.mBlockWidth) + this.mWidthAlignment), Integer.valueOf(this.mBlockWidth * Math.min(((Integer) this.mBlockCountRange.getUpper()).intValue() / heightInBlocks, (int) (((Rational) this.mBlockAspectRatioRange.getUpper()).doubleValue() * ((double) heightInBlocks)))));
                    if (height > this.mSmallerDimensionUpperLimit) {
                        range = range.intersect(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(this.mSmallerDimensionUpperLimit));
                    }
                    return range.intersect(Integer.valueOf((int) Math.ceil(((Rational) this.mAspectRatioRange.getLower()).doubleValue() * ((double) height))), Integer.valueOf((int) (((Rational) this.mAspectRatioRange.getUpper()).doubleValue() * ((double) height))));
                }
                throw new IllegalArgumentException("unsupported height");
            } catch (IllegalArgumentException e) {
                Log.w(TAG, "could not get supported widths for " + height, e);
                throw new IllegalArgumentException("unsupported height");
            }
        }

        public Range<Integer> getSupportedHeightsFor(int width) {
            try {
                Range<Integer> range = this.mHeightRange;
                if (this.mWidthRange.contains(Integer.valueOf(width)) && width % this.mWidthAlignment == 0) {
                    int widthInBlocks = Utils.divUp(width, this.mBlockWidth);
                    range = range.intersect(Integer.valueOf(((Math.max(Utils.divUp(((Integer) this.mBlockCountRange.getLower()).intValue(), widthInBlocks), (int) Math.ceil(((double) widthInBlocks) / ((Rational) this.mBlockAspectRatioRange.getUpper()).doubleValue())) - 1) * this.mBlockHeight) + this.mHeightAlignment), Integer.valueOf(this.mBlockHeight * Math.min(((Integer) this.mBlockCountRange.getUpper()).intValue() / widthInBlocks, (int) (((double) widthInBlocks) / ((Rational) this.mBlockAspectRatioRange.getLower()).doubleValue()))));
                    if (width > this.mSmallerDimensionUpperLimit) {
                        range = range.intersect(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(this.mSmallerDimensionUpperLimit));
                    }
                    return range.intersect(Integer.valueOf((int) Math.ceil(((double) width) / ((Rational) this.mAspectRatioRange.getUpper()).doubleValue())), Integer.valueOf((int) (((double) width) / ((Rational) this.mAspectRatioRange.getLower()).doubleValue())));
                }
                throw new IllegalArgumentException("unsupported width");
            } catch (IllegalArgumentException e) {
                Log.w(TAG, "could not get supported heights for " + width, e);
                throw new IllegalArgumentException("unsupported width");
            }
        }

        public Range<Double> getSupportedFrameRatesFor(int width, int height) {
            Range<Integer> range = this.mHeightRange;
            if (supports(Integer.valueOf(width), Integer.valueOf(height), null)) {
                int blockCount = Utils.divUp(width, this.mBlockWidth) * Utils.divUp(height, this.mBlockHeight);
                return Range.create(Double.valueOf(Math.max(((double) ((Long) this.mBlocksPerSecondRange.getLower()).longValue()) / ((double) blockCount), (double) ((Integer) this.mFrameRateRange.getLower()).intValue())), Double.valueOf(Math.min(((double) ((Long) this.mBlocksPerSecondRange.getUpper()).longValue()) / ((double) blockCount), (double) ((Integer) this.mFrameRateRange.getUpper()).intValue())));
            }
            throw new IllegalArgumentException("unsupported size");
        }

        public boolean areSizeAndRateSupported(int width, int height, double frameRate) {
            return supports(Integer.valueOf(width), Integer.valueOf(height), Double.valueOf(frameRate));
        }

        public boolean isSizeSupported(int width, int height) {
            return supports(Integer.valueOf(width), Integer.valueOf(height), null);
        }

        private boolean supports(Integer width, Integer height, Number rate) {
            boolean ok = true;
            if (!(MediaCodecInfo.ERROR_UNRECOGNIZED == null || width == null)) {
                ok = this.mWidthRange.contains(width) && width.intValue() % this.mWidthAlignment == 0;
            }
            if (ok && height != null) {
                if (this.mHeightRange.contains(height) && height.intValue() % this.mHeightAlignment == 0) {
                    ok = true;
                } else {
                    ok = false;
                }
            }
            if (ok && rate != null) {
                ok = this.mFrameRateRange.contains(Utils.intRangeFor(rate.doubleValue()));
            }
            if (!ok || height == null || width == null) {
                return ok;
            }
            if (Math.min(height.intValue(), width.intValue()) <= this.mSmallerDimensionUpperLimit) {
                ok = true;
            } else {
                ok = false;
            }
            int widthInBlocks = Utils.divUp(width.intValue(), this.mBlockWidth);
            int heightInBlocks = Utils.divUp(height.intValue(), this.mBlockHeight);
            int blockCount = widthInBlocks * heightInBlocks;
            if (ok && this.mBlockCountRange.contains(Integer.valueOf(blockCount)) && this.mBlockAspectRatioRange.contains(new Rational(widthInBlocks, heightInBlocks)) && this.mAspectRatioRange.contains(new Rational(width.intValue(), height.intValue()))) {
                ok = true;
            } else {
                ok = false;
            }
            if (!ok || rate == null) {
                return ok;
            }
            return this.mBlocksPerSecondRange.contains(Utils.longRangeFor(((double) blockCount) * rate.doubleValue()));
        }

        public boolean supportsFormat(MediaFormat format) {
            Map<String, Object> map = format.getMap();
            return supports((Integer) map.get(MediaFormat.KEY_WIDTH), (Integer) map.get(MediaFormat.KEY_HEIGHT), (Number) map.get(MediaFormat.KEY_FRAME_RATE));
        }

        private VideoCapabilities() {
        }

        public static VideoCapabilities create(MediaFormat info, CodecCapabilities parent) {
            VideoCapabilities caps = new VideoCapabilities();
            caps.init(info, parent);
            return caps;
        }

        public void init(MediaFormat info, CodecCapabilities parent) {
            this.mParent = parent;
            initWithPlatformLimits();
            applyLevelLimits();
            parseFromInfo(info);
            updateLimits();
        }

        public Size getBlockSize() {
            return new Size(this.mBlockWidth, this.mBlockHeight);
        }

        public Range<Integer> getBlockCountRange() {
            return this.mBlockCountRange;
        }

        public Range<Long> getBlocksPerSecondRange() {
            return this.mBlocksPerSecondRange;
        }

        public Range<Rational> getAspectRatioRange(boolean blocks) {
            return blocks ? this.mBlockAspectRatioRange : this.mAspectRatioRange;
        }

        private void initWithPlatformLimits() {
            this.mBitrateRange = MediaCodecInfo.BITRATE_RANGE;
            this.mWidthRange = MediaCodecInfo.SIZE_RANGE;
            this.mHeightRange = MediaCodecInfo.SIZE_RANGE;
            this.mFrameRateRange = MediaCodecInfo.FRAME_RATE_RANGE;
            this.mHorizontalBlockRange = MediaCodecInfo.SIZE_RANGE;
            this.mVerticalBlockRange = MediaCodecInfo.SIZE_RANGE;
            this.mBlockCountRange = MediaCodecInfo.POSITIVE_INTEGERS;
            this.mBlocksPerSecondRange = MediaCodecInfo.POSITIVE_LONGS;
            this.mBlockAspectRatioRange = MediaCodecInfo.POSITIVE_RATIONALS;
            this.mAspectRatioRange = MediaCodecInfo.POSITIVE_RATIONALS;
            this.mWidthAlignment = MediaCodecInfo.ERROR_UNSUPPORTED;
            this.mHeightAlignment = MediaCodecInfo.ERROR_UNSUPPORTED;
            this.mBlockWidth = MediaCodecInfo.ERROR_UNSUPPORTED;
            this.mBlockHeight = MediaCodecInfo.ERROR_UNSUPPORTED;
            this.mSmallerDimensionUpperLimit = ((Integer) MediaCodecInfo.SIZE_RANGE.getUpper()).intValue();
        }

        private void parseFromInfo(MediaFormat info) {
            Map<String, Object> map = info.getMap();
            Size size = new Size(this.mBlockWidth, this.mBlockHeight);
            Size alignment = new Size(this.mWidthAlignment, this.mHeightAlignment);
            Range<Integer> widths = null;
            Range<Integer> heights = null;
            Size blockSize = Utils.parseSize(map.get("block-size"), size);
            alignment = Utils.parseSize(map.get("alignment"), alignment);
            Range<Integer> counts = Utils.parseIntRange(map.get("block-count-range"), null);
            Range blockRates = Utils.parseLongRange(map.get("blocks-per-second-range"), null);
            Object o = map.get("size-range");
            Pair<Size, Size> sizeRange = Utils.parseSizeRange(o);
            if (sizeRange != null) {
                try {
                    widths = Range.create(Integer.valueOf(((Size) sizeRange.first).getWidth()), Integer.valueOf(((Size) sizeRange.second).getWidth()));
                    heights = Range.create(Integer.valueOf(((Size) sizeRange.first).getHeight()), Integer.valueOf(((Size) sizeRange.second).getHeight()));
                } catch (IllegalArgumentException e) {
                    Log.w(TAG, "could not parse size range '" + o + "'");
                    widths = null;
                    heights = null;
                }
            }
            if (Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED).equals(map.get("feature-can-swap-width-height"))) {
                if (widths != null) {
                    this.mSmallerDimensionUpperLimit = Math.min(((Integer) widths.getUpper()).intValue(), ((Integer) heights.getUpper()).intValue());
                    heights = widths.extend(heights);
                    widths = heights;
                } else {
                    Log.w(TAG, "feature can-swap-width-height is best used with size-range");
                    this.mSmallerDimensionUpperLimit = Math.min(((Integer) this.mWidthRange.getUpper()).intValue(), ((Integer) this.mHeightRange.getUpper()).intValue());
                    Range extend = this.mWidthRange.extend(this.mHeightRange);
                    this.mHeightRange = extend;
                    this.mWidthRange = extend;
                }
            }
            Range<Rational> ratios = Utils.parseRationalRange(map.get("block-aspect-ratio-range"), null);
            Range<Rational> blockRatios = Utils.parseRationalRange(map.get("pixel-aspect-ratio-range"), null);
            Range<Integer> frameRates = Utils.parseIntRange(map.get("frame-rate-range"), null);
            if (frameRates != null) {
                try {
                    frameRates = frameRates.intersect(MediaCodecInfo.FRAME_RATE_RANGE);
                } catch (IllegalArgumentException e2) {
                    Log.w(TAG, "frame rate range (" + frameRates + ") is out of limits: " + MediaCodecInfo.FRAME_RATE_RANGE);
                    frameRates = null;
                }
            }
            Range<Integer> bitRates = Utils.parseIntRange(map.get("bitrate-range"), null);
            if (bitRates != null) {
                try {
                    bitRates = bitRates.intersect(MediaCodecInfo.BITRATE_RANGE);
                } catch (IllegalArgumentException e3) {
                    Log.w(TAG, "bitrate range (" + bitRates + ") is out of limits: " + MediaCodecInfo.BITRATE_RANGE);
                    bitRates = null;
                }
            }
            MediaCodecInfo.checkPowerOfTwo(blockSize.getWidth(), "block-size width must be power of two");
            MediaCodecInfo.checkPowerOfTwo(blockSize.getHeight(), "block-size height must be power of two");
            MediaCodecInfo.checkPowerOfTwo(alignment.getWidth(), "alignment width must be power of two");
            MediaCodecInfo.checkPowerOfTwo(alignment.getHeight(), "alignment height must be power of two");
            applyMacroBlockLimits(ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED, ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED, ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED, LinkQualityInfo.UNKNOWN_LONG, blockSize.getWidth(), blockSize.getHeight(), alignment.getWidth(), alignment.getHeight());
            if ((this.mParent.mError & MediaCodecInfo.ERROR_UNSUPPORTED) != 0) {
                if (widths != null) {
                    this.mWidthRange = MediaCodecInfo.SIZE_RANGE.intersect(widths);
                }
                if (heights != null) {
                    this.mHeightRange = MediaCodecInfo.SIZE_RANGE.intersect(heights);
                }
                if (counts != null) {
                    this.mBlockCountRange = MediaCodecInfo.POSITIVE_INTEGERS.intersect(Utils.factorRange((Range) counts, ((this.mBlockWidth * this.mBlockHeight) / blockSize.getWidth()) / blockSize.getHeight()));
                }
                if (blockRates != null) {
                    this.mBlocksPerSecondRange = MediaCodecInfo.POSITIVE_LONGS.intersect(Utils.factorRange(blockRates, (long) (((this.mBlockWidth * this.mBlockHeight) / blockSize.getWidth()) / blockSize.getHeight())));
                }
                if (blockRatios != null) {
                    this.mBlockAspectRatioRange = MediaCodecInfo.POSITIVE_RATIONALS.intersect(Utils.scaleRange(blockRatios, this.mBlockHeight / blockSize.getHeight(), this.mBlockWidth / blockSize.getWidth()));
                }
                if (ratios != null) {
                    this.mAspectRatioRange = MediaCodecInfo.POSITIVE_RATIONALS.intersect(ratios);
                }
                if (frameRates != null) {
                    this.mFrameRateRange = MediaCodecInfo.FRAME_RATE_RANGE.intersect(frameRates);
                }
                if (bitRates != null) {
                    this.mBitrateRange = MediaCodecInfo.BITRATE_RANGE.intersect(bitRates);
                }
            } else {
                if (widths != null) {
                    this.mWidthRange = this.mWidthRange.intersect(widths);
                }
                if (heights != null) {
                    this.mHeightRange = this.mHeightRange.intersect(heights);
                }
                if (counts != null) {
                    this.mBlockCountRange = this.mBlockCountRange.intersect(Utils.factorRange((Range) counts, ((this.mBlockWidth * this.mBlockHeight) / blockSize.getWidth()) / blockSize.getHeight()));
                }
                if (blockRates != null) {
                    this.mBlocksPerSecondRange = this.mBlocksPerSecondRange.intersect(Utils.factorRange(blockRates, (long) (((this.mBlockWidth * this.mBlockHeight) / blockSize.getWidth()) / blockSize.getHeight())));
                }
                if (blockRatios != null) {
                    this.mBlockAspectRatioRange = this.mBlockAspectRatioRange.intersect(Utils.scaleRange(blockRatios, this.mBlockHeight / blockSize.getHeight(), this.mBlockWidth / blockSize.getWidth()));
                }
                if (ratios != null) {
                    this.mAspectRatioRange = this.mAspectRatioRange.intersect(ratios);
                }
                if (frameRates != null) {
                    this.mFrameRateRange = this.mFrameRateRange.intersect(frameRates);
                }
                if (bitRates != null) {
                    this.mBitrateRange = this.mBitrateRange.intersect(bitRates);
                }
            }
            updateLimits();
        }

        private void applyBlockLimits(int blockWidth, int blockHeight, Range<Integer> counts, Range<Long> rates, Range<Rational> ratios) {
            MediaCodecInfo.checkPowerOfTwo(blockWidth, "blockWidth must be a power of two");
            MediaCodecInfo.checkPowerOfTwo(blockHeight, "blockHeight must be a power of two");
            int newBlockWidth = Math.max(blockWidth, this.mBlockWidth);
            int newBlockHeight = Math.max(blockHeight, this.mBlockHeight);
            int factor = ((newBlockWidth * newBlockHeight) / this.mBlockWidth) / this.mBlockHeight;
            if (factor != MediaCodecInfo.ERROR_UNRECOGNIZED) {
                this.mBlockCountRange = Utils.factorRange(this.mBlockCountRange, factor);
                this.mBlocksPerSecondRange = Utils.factorRange(this.mBlocksPerSecondRange, (long) factor);
                this.mBlockAspectRatioRange = Utils.scaleRange(this.mBlockAspectRatioRange, newBlockHeight / this.mBlockHeight, newBlockWidth / this.mBlockWidth);
                this.mHorizontalBlockRange = Utils.factorRange(this.mHorizontalBlockRange, newBlockWidth / this.mBlockWidth);
                this.mVerticalBlockRange = Utils.factorRange(this.mVerticalBlockRange, newBlockHeight / this.mBlockHeight);
            }
            factor = ((newBlockWidth * newBlockHeight) / blockWidth) / blockHeight;
            if (factor != MediaCodecInfo.ERROR_UNRECOGNIZED) {
                counts = Utils.factorRange((Range) counts, factor);
                rates = Utils.factorRange((Range) rates, (long) factor);
                ratios = Utils.scaleRange(ratios, newBlockHeight / blockHeight, newBlockWidth / blockWidth);
            }
            this.mBlockCountRange = this.mBlockCountRange.intersect(counts);
            this.mBlocksPerSecondRange = this.mBlocksPerSecondRange.intersect(rates);
            this.mBlockAspectRatioRange = this.mBlockAspectRatioRange.intersect(ratios);
            this.mBlockWidth = newBlockWidth;
            this.mBlockHeight = newBlockHeight;
        }

        private void applyAlignment(int widthAlignment, int heightAlignment) {
            MediaCodecInfo.checkPowerOfTwo(widthAlignment, "widthAlignment must be a power of two");
            MediaCodecInfo.checkPowerOfTwo(heightAlignment, "heightAlignment must be a power of two");
            if (widthAlignment > this.mBlockWidth || heightAlignment > this.mBlockHeight) {
                applyBlockLimits(Math.max(widthAlignment, this.mBlockWidth), Math.max(heightAlignment, this.mBlockHeight), MediaCodecInfo.POSITIVE_INTEGERS, MediaCodecInfo.POSITIVE_LONGS, MediaCodecInfo.POSITIVE_RATIONALS);
            }
            this.mWidthAlignment = Math.max(widthAlignment, this.mWidthAlignment);
            this.mHeightAlignment = Math.max(heightAlignment, this.mHeightAlignment);
            this.mWidthRange = Utils.alignRange(this.mWidthRange, this.mWidthAlignment);
            this.mHeightRange = Utils.alignRange(this.mHeightRange, this.mHeightAlignment);
        }

        private void updateLimits() {
            this.mHorizontalBlockRange = this.mHorizontalBlockRange.intersect(Utils.factorRange(this.mWidthRange, this.mBlockWidth));
            this.mHorizontalBlockRange = this.mHorizontalBlockRange.intersect(Range.create(Integer.valueOf(((Integer) this.mBlockCountRange.getLower()).intValue() / ((Integer) this.mVerticalBlockRange.getUpper()).intValue()), Integer.valueOf(((Integer) this.mBlockCountRange.getUpper()).intValue() / ((Integer) this.mVerticalBlockRange.getLower()).intValue())));
            this.mVerticalBlockRange = this.mVerticalBlockRange.intersect(Utils.factorRange(this.mHeightRange, this.mBlockHeight));
            this.mVerticalBlockRange = this.mVerticalBlockRange.intersect(Range.create(Integer.valueOf(((Integer) this.mBlockCountRange.getLower()).intValue() / ((Integer) this.mHorizontalBlockRange.getUpper()).intValue()), Integer.valueOf(((Integer) this.mBlockCountRange.getUpper()).intValue() / ((Integer) this.mHorizontalBlockRange.getLower()).intValue())));
            this.mBlockCountRange = this.mBlockCountRange.intersect(Range.create(Integer.valueOf(((Integer) this.mVerticalBlockRange.getLower()).intValue() * ((Integer) this.mHorizontalBlockRange.getLower()).intValue()), Integer.valueOf(((Integer) this.mVerticalBlockRange.getUpper()).intValue() * ((Integer) this.mHorizontalBlockRange.getUpper()).intValue())));
            this.mBlockAspectRatioRange = this.mBlockAspectRatioRange.intersect(new Rational(((Integer) this.mHorizontalBlockRange.getLower()).intValue(), ((Integer) this.mVerticalBlockRange.getUpper()).intValue()), new Rational(((Integer) this.mHorizontalBlockRange.getUpper()).intValue(), ((Integer) this.mVerticalBlockRange.getLower()).intValue()));
            this.mWidthRange = this.mWidthRange.intersect(Integer.valueOf(((((Integer) this.mHorizontalBlockRange.getLower()).intValue() - 1) * this.mBlockWidth) + this.mWidthAlignment), Integer.valueOf(((Integer) this.mHorizontalBlockRange.getUpper()).intValue() * this.mBlockWidth));
            this.mHeightRange = this.mHeightRange.intersect(Integer.valueOf(((((Integer) this.mVerticalBlockRange.getLower()).intValue() - 1) * this.mBlockHeight) + this.mHeightAlignment), Integer.valueOf(((Integer) this.mVerticalBlockRange.getUpper()).intValue() * this.mBlockHeight));
            this.mAspectRatioRange = this.mAspectRatioRange.intersect(new Rational(((Integer) this.mWidthRange.getLower()).intValue(), ((Integer) this.mHeightRange.getUpper()).intValue()), new Rational(((Integer) this.mWidthRange.getUpper()).intValue(), ((Integer) this.mHeightRange.getLower()).intValue()));
            this.mSmallerDimensionUpperLimit = Math.min(this.mSmallerDimensionUpperLimit, Math.min(((Integer) this.mWidthRange.getUpper()).intValue(), ((Integer) this.mHeightRange.getUpper()).intValue()));
            this.mBlocksPerSecondRange = this.mBlocksPerSecondRange.intersect(Long.valueOf(((long) ((Integer) this.mBlockCountRange.getLower()).intValue()) * ((long) ((Integer) this.mFrameRateRange.getLower()).intValue())), Long.valueOf(((long) ((Integer) this.mBlockCountRange.getUpper()).intValue()) * ((long) ((Integer) this.mFrameRateRange.getUpper()).intValue())));
            this.mFrameRateRange = this.mFrameRateRange.intersect(Integer.valueOf((int) (((Long) this.mBlocksPerSecondRange.getLower()).longValue() / ((long) ((Integer) this.mBlockCountRange.getUpper()).intValue()))), Integer.valueOf((int) (((double) ((Long) this.mBlocksPerSecondRange.getUpper()).longValue()) / ((double) ((Integer) this.mBlockCountRange.getLower()).intValue()))));
        }

        private void applyMacroBlockLimits(int maxHorizontalBlocks, int maxVerticalBlocks, int maxBlocks, long maxBlocksPerSecond, int blockWidth, int blockHeight, int widthAlignment, int heightAlignment) {
            applyAlignment(widthAlignment, heightAlignment);
            applyBlockLimits(blockWidth, blockHeight, Range.create(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(maxBlocks)), Range.create(Long.valueOf(1), Long.valueOf(maxBlocksPerSecond)), Range.create(new Rational(MediaCodecInfo.ERROR_UNRECOGNIZED, maxVerticalBlocks), new Rational(maxHorizontalBlocks, MediaCodecInfo.ERROR_UNRECOGNIZED)));
            this.mHorizontalBlockRange = this.mHorizontalBlockRange.intersect(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(maxHorizontalBlocks / (this.mBlockWidth / blockWidth)));
            this.mVerticalBlockRange = this.mVerticalBlockRange.intersect(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(maxVerticalBlocks / (this.mBlockHeight / blockHeight)));
        }

        private void applyLevelLimits() {
            int maxBps;
            int errors = MediaCodecInfo.ERROR_NONE_SUPPORTED;
            CodecProfileLevel[] profileLevels = this.mParent.profileLevels;
            String mime = this.mParent.getMimeType();
            int maxBlocks;
            int maxBlocksPerSecond;
            CodecProfileLevel[] arr$;
            int len$;
            int i$;
            CodecProfileLevel profileLevel;
            int MBPS;
            int FS;
            int BR;
            boolean supported;
            int maxLengthInBlocks;
            if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_VIDEO_AVC)) {
                maxBlocks = 99;
                maxBlocksPerSecond = 1485;
                maxBps = 64000;
                int maxDPBBlocks = 396;
                arr$ = profileLevels;
                len$ = arr$.length;
                for (i$ = 0; i$ < len$; i$ += MediaCodecInfo.ERROR_UNRECOGNIZED) {
                    profileLevel = arr$[i$];
                    MBPS = 0;
                    FS = 0;
                    BR = 0;
                    int DPB = 0;
                    supported = true;
                    switch (profileLevel.level) {
                        case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                            MBPS = 1485;
                            FS = 99;
                            BR = 64;
                            DPB = 396;
                            break;
                        case MediaCodecInfo.ERROR_UNSUPPORTED /*2*/:
                            MBPS = 1485;
                            FS = 99;
                            BR = AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
                            DPB = 396;
                            break;
                        case MediaCodecInfo.ERROR_NONE_SUPPORTED /*4*/:
                            MBPS = 3000;
                            FS = 396;
                            BR = KeyEvent.KEYCODE_BUTTON_5;
                            DPB = MediaPlayer.MEDIA_INFO_TIMED_TEXT_ERROR;
                            break;
                        case SetPendingIntentTemplate.TAG /*8*/:
                            MBPS = BluetoothHealth.HEALTH_OPERATION_SUCCESS;
                            FS = 396;
                            BR = 384;
                            DPB = 2376;
                            break;
                        case RelativeLayout.START_OF /*16*/:
                            MBPS = 11880;
                            FS = 396;
                            BR = GLES20.GL_SRC_COLOR;
                            DPB = 2376;
                            break;
                        case AccessibilityNodeInfo.ACTION_LONG_CLICK /*32*/:
                            MBPS = 11880;
                            FS = 396;
                            BR = LayoutParams.TYPE_STATUS_BAR;
                            DPB = 2376;
                            break;
                        case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                            MBPS = 19800;
                            FS = 792;
                            BR = 4000;
                            DPB = 4752;
                            break;
                        case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                            MBPS = 20250;
                            FS = 1620;
                            BR = 4000;
                            DPB = 8100;
                            break;
                        case InputMethodManager.CONTROL_START_INITIAL /*256*/:
                            MBPS = 40500;
                            FS = 1620;
                            BR = Window.PROGRESS_END;
                            DPB = 8100;
                            break;
                        case AccessibilityNodeInfo.ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY /*512*/:
                            MBPS = 108000;
                            FS = 3600;
                            BR = 14000;
                            DPB = 18000;
                            break;
                        case AccessibilityNodeInfo.ACTION_NEXT_HTML_ELEMENT /*1024*/:
                            MBPS = 216000;
                            FS = DateUtils.FORMAT_CAP_NOON_MIDNIGHT;
                            BR = Window.PROGRESS_SECONDARY_START;
                            DPB = MtpConstants.DEVICE_PROPERTY_UNDEFINED;
                            break;
                        case AccessibilityNodeInfo.ACTION_PREVIOUS_HTML_ELEMENT /*2048*/:
                            MBPS = 245760;
                            FS = AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD;
                            BR = Window.PROGRESS_SECONDARY_START;
                            DPB = AccessibilityNodeInfo.ACTION_PASTE;
                            break;
                        case AccessibilityNodeInfo.ACTION_SCROLL_FORWARD /*4096*/:
                            MBPS = 245760;
                            FS = AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD;
                            BR = Process.FIRST_SHARED_APPLICATION_GID;
                            DPB = AccessibilityNodeInfo.ACTION_PASTE;
                            break;
                        case AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD /*8192*/:
                            MBPS = 522240;
                            FS = GLES10.GL_TEXTURE_ENV_MODE;
                            BR = Process.FIRST_SHARED_APPLICATION_GID;
                            DPB = GLES20.GL_STENCIL_BACK_FUNC;
                            break;
                        case AccessibilityNodeInfo.ACTION_COPY /*16384*/:
                            MBPS = 589824;
                            FS = 22080;
                            BR = 135000;
                            DPB = 110400;
                            break;
                        case AccessibilityNodeInfo.ACTION_PASTE /*32768*/:
                            MBPS = SurfaceControl.FX_SURFACE_MASK;
                            FS = 36864;
                            BR = 240000;
                            DPB = 184320;
                            break;
                        case AccessibilityNodeInfo.ACTION_CUT /*65536*/:
                            MBPS = 2073600;
                            FS = 36864;
                            BR = 240000;
                            DPB = 184320;
                            break;
                        default:
                            Log.w(TAG, "Unrecognized level " + profileLevel.level + " for " + mime);
                            errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                            break;
                    }
                    switch (profileLevel.profile) {
                        case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                        case MediaCodecInfo.ERROR_UNSUPPORTED /*2*/:
                            break;
                        case MediaCodecInfo.ERROR_NONE_SUPPORTED /*4*/:
                        case AccessibilityNodeInfo.ACTION_LONG_CLICK /*32*/:
                        case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                            Log.w(TAG, "Unsupported profile " + profileLevel.profile + " for " + mime);
                            errors |= MediaCodecInfo.ERROR_UNSUPPORTED;
                            supported = false;
                            break;
                        case SetPendingIntentTemplate.TAG /*8*/:
                            BR *= 1250;
                            break;
                        case RelativeLayout.START_OF /*16*/:
                            BR *= 3000;
                            break;
                        default:
                            Log.w(TAG, "Unrecognized profile " + profileLevel.profile + " for " + mime);
                            errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                            BR *= LayoutParams.TYPE_APPLICATION_PANEL;
                            break;
                    }
                    BR *= LayoutParams.TYPE_APPLICATION_PANEL;
                    if (supported) {
                        errors &= -5;
                    }
                    maxBlocksPerSecond = Math.max(MBPS, maxBlocksPerSecond);
                    maxBlocks = Math.max(FS, maxBlocks);
                    maxBps = Math.max(BR, maxBps);
                    maxDPBBlocks = Math.max(maxDPBBlocks, DPB);
                }
                maxLengthInBlocks = (int) Math.sqrt((double) (maxBlocks * 8));
                applyMacroBlockLimits(maxLengthInBlocks, maxLengthInBlocks, maxBlocks, (long) maxBlocksPerSecond, 16, 16, MediaCodecInfo.ERROR_UNRECOGNIZED, MediaCodecInfo.ERROR_UNRECOGNIZED);
            } else {
                int maxWidth;
                int maxHeight;
                int maxRate;
                int FR;
                int W;
                int H;
                if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_VIDEO_MPEG4)) {
                    maxWidth = 11;
                    maxHeight = 9;
                    maxRate = 15;
                    maxBlocks = 99;
                    maxBlocksPerSecond = 1485;
                    maxBps = 64000;
                    arr$ = profileLevels;
                    len$ = arr$.length;
                    for (i$ = 0; i$ < len$; i$ += MediaCodecInfo.ERROR_UNRECOGNIZED) {
                        profileLevel = arr$[i$];
                        MBPS = 0;
                        FS = 0;
                        BR = 0;
                        FR = 0;
                        W = 0;
                        H = 0;
                        supported = true;
                        switch (profileLevel.profile) {
                            case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                                switch (profileLevel.level) {
                                    case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                                        FR = 15;
                                        W = 11;
                                        H = 9;
                                        MBPS = 1485;
                                        FS = 99;
                                        BR = 64;
                                        break;
                                    case MediaCodecInfo.ERROR_UNSUPPORTED /*2*/:
                                        FR = 30;
                                        W = 11;
                                        H = 9;
                                        MBPS = 1485;
                                        FS = 99;
                                        BR = AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
                                        break;
                                    case MediaCodecInfo.ERROR_NONE_SUPPORTED /*4*/:
                                        FR = 30;
                                        W = 11;
                                        H = 9;
                                        MBPS = 1485;
                                        FS = 99;
                                        BR = 64;
                                        break;
                                    case SetPendingIntentTemplate.TAG /*8*/:
                                        FR = 30;
                                        W = 22;
                                        H = 18;
                                        MBPS = 5940;
                                        FS = 396;
                                        BR = AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
                                        break;
                                    case RelativeLayout.START_OF /*16*/:
                                        FR = 30;
                                        W = 22;
                                        H = 18;
                                        MBPS = 11880;
                                        FS = 396;
                                        BR = 384;
                                        break;
                                    case AccessibilityNodeInfo.ACTION_LONG_CLICK /*32*/:
                                    case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                                    case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                                        FR = 30;
                                        W = 22;
                                        H = 18;
                                        MBPS = 11880;
                                        FS = 396;
                                        BR = 384;
                                        supported = false;
                                        break;
                                    default:
                                        Log.w(TAG, "Unrecognized profile/level " + profileLevel.profile + "/" + profileLevel.level + " for " + mime);
                                        errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                                        break;
                                }
                            case MediaCodecInfo.ERROR_UNSUPPORTED /*2*/:
                            case MediaCodecInfo.ERROR_NONE_SUPPORTED /*4*/:
                            case SetPendingIntentTemplate.TAG /*8*/:
                            case RelativeLayout.START_OF /*16*/:
                            case AccessibilityNodeInfo.ACTION_LONG_CLICK /*32*/:
                            case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                            case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                            case InputMethodManager.CONTROL_START_INITIAL /*256*/:
                            case AccessibilityNodeInfo.ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY /*512*/:
                            case AccessibilityNodeInfo.ACTION_NEXT_HTML_ELEMENT /*1024*/:
                            case AccessibilityNodeInfo.ACTION_PREVIOUS_HTML_ELEMENT /*2048*/:
                            case AccessibilityNodeInfo.ACTION_SCROLL_FORWARD /*4096*/:
                            case AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD /*8192*/:
                            case AccessibilityNodeInfo.ACTION_COPY /*16384*/:
                                Log.i(TAG, "Unsupported profile " + profileLevel.profile + " for " + mime);
                                errors |= MediaCodecInfo.ERROR_UNSUPPORTED;
                                supported = false;
                                break;
                            case AccessibilityNodeInfo.ACTION_PASTE /*32768*/:
                                switch (profileLevel.level) {
                                    case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                                    case MediaCodecInfo.ERROR_NONE_SUPPORTED /*4*/:
                                        FR = 30;
                                        W = 11;
                                        H = 9;
                                        MBPS = 2970;
                                        FS = 99;
                                        BR = AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
                                        break;
                                    case SetPendingIntentTemplate.TAG /*8*/:
                                        FR = 30;
                                        W = 22;
                                        H = 18;
                                        MBPS = 5940;
                                        FS = 396;
                                        BR = 384;
                                        break;
                                    case RelativeLayout.START_OF /*16*/:
                                        FR = 30;
                                        W = 22;
                                        H = 18;
                                        MBPS = 11880;
                                        FS = 396;
                                        BR = GLES20.GL_SRC_COLOR;
                                        break;
                                    case AccessibilityNodeInfo.ACTION_LONG_CLICK /*32*/:
                                    case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                                        FR = 30;
                                        W = 44;
                                        H = 36;
                                        MBPS = 23760;
                                        FS = 792;
                                        BR = 3000;
                                        break;
                                    case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                                        FR = 30;
                                        W = 45;
                                        H = 36;
                                        MBPS = 48600;
                                        FS = 1620;
                                        BR = 8000;
                                        break;
                                    default:
                                        Log.w(TAG, "Unrecognized profile/level " + profileLevel.profile + "/" + profileLevel.level + " for " + mime);
                                        errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                                        break;
                                }
                            default:
                                Log.w(TAG, "Unrecognized profile " + profileLevel.profile + " for " + mime);
                                errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                                break;
                        }
                        if (supported) {
                            errors &= -5;
                        }
                        maxBlocksPerSecond = Math.max(MBPS, maxBlocksPerSecond);
                        maxBlocks = Math.max(FS, maxBlocks);
                        maxBps = Math.max(BR * LayoutParams.TYPE_APPLICATION_PANEL, maxBps);
                        maxWidth = Math.max(W, maxWidth);
                        maxHeight = Math.max(H, maxHeight);
                        maxRate = Math.max(FR, maxRate);
                    }
                    applyMacroBlockLimits(maxWidth, maxHeight, maxBlocks, (long) maxBlocksPerSecond, 16, 16, MediaCodecInfo.ERROR_UNRECOGNIZED, MediaCodecInfo.ERROR_UNRECOGNIZED);
                    this.mFrameRateRange = this.mFrameRateRange.intersect(Integer.valueOf(12), Integer.valueOf(maxRate));
                } else {
                    if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_VIDEO_H263)) {
                        maxWidth = 11;
                        maxHeight = 9;
                        maxRate = 15;
                        maxBlocks = 99;
                        maxBlocksPerSecond = 1485;
                        maxBps = 64000;
                        arr$ = profileLevels;
                        len$ = arr$.length;
                        for (i$ = 0; i$ < len$; i$ += MediaCodecInfo.ERROR_UNRECOGNIZED) {
                            profileLevel = arr$[i$];
                            MBPS = 0;
                            BR = 0;
                            FR = 0;
                            W = 0;
                            H = 0;
                            switch (profileLevel.level) {
                                case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                                    FR = 15;
                                    W = 11;
                                    H = 9;
                                    BR = MediaCodecInfo.ERROR_UNRECOGNIZED;
                                    MBPS = 15 * 99;
                                    break;
                                case MediaCodecInfo.ERROR_UNSUPPORTED /*2*/:
                                    FR = 30;
                                    W = 22;
                                    H = 18;
                                    BR = MediaCodecInfo.ERROR_UNSUPPORTED;
                                    MBPS = 30 * 396;
                                    break;
                                case MediaCodecInfo.ERROR_NONE_SUPPORTED /*4*/:
                                    FR = 30;
                                    W = 22;
                                    H = 18;
                                    BR = 6;
                                    MBPS = 30 * 396;
                                    break;
                                case SetPendingIntentTemplate.TAG /*8*/:
                                    FR = 30;
                                    W = 22;
                                    H = 18;
                                    BR = 32;
                                    MBPS = 30 * 396;
                                    break;
                                case RelativeLayout.START_OF /*16*/:
                                    FR = 30;
                                    W = 11;
                                    H = 9;
                                    BR = MediaCodecInfo.ERROR_UNSUPPORTED;
                                    MBPS = 30 * 99;
                                    break;
                                case AccessibilityNodeInfo.ACTION_LONG_CLICK /*32*/:
                                    FR = 60;
                                    W = 22;
                                    H = 18;
                                    BR = 64;
                                    MBPS = 396 * 50;
                                    break;
                                case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                                    FR = 60;
                                    W = 45;
                                    H = 18;
                                    BR = AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
                                    MBPS = 810 * 50;
                                    break;
                                case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                                    FR = 60;
                                    W = 45;
                                    H = 36;
                                    BR = InputMethodManager.CONTROL_START_INITIAL;
                                    MBPS = 1620 * 50;
                                    break;
                                default:
                                    Log.w(TAG, "Unrecognized profile/level " + profileLevel.profile + "/" + profileLevel.level + " for " + mime);
                                    errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                                    break;
                            }
                            switch (profileLevel.profile) {
                                case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                                case MediaCodecInfo.ERROR_UNSUPPORTED /*2*/:
                                case MediaCodecInfo.ERROR_NONE_SUPPORTED /*4*/:
                                case SetPendingIntentTemplate.TAG /*8*/:
                                case RelativeLayout.START_OF /*16*/:
                                case AccessibilityNodeInfo.ACTION_LONG_CLICK /*32*/:
                                case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                                case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                                case InputMethodManager.CONTROL_START_INITIAL /*256*/:
                                    break;
                                default:
                                    Log.w(TAG, "Unrecognized profile " + profileLevel.profile + " for " + mime);
                                    errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                                    break;
                            }
                            errors &= -5;
                            maxBlocksPerSecond = Math.max(MBPS, maxBlocksPerSecond);
                            maxBlocks = Math.max(W * H, maxBlocks);
                            maxBps = Math.max(64000 * BR, maxBps);
                            maxWidth = Math.max(W, maxWidth);
                            maxHeight = Math.max(H, maxHeight);
                            maxRate = Math.max(FR, maxRate);
                        }
                        applyMacroBlockLimits(maxWidth, maxHeight, maxBlocks, (long) maxBlocksPerSecond, 16, 16, MediaCodecInfo.ERROR_UNRECOGNIZED, MediaCodecInfo.ERROR_UNRECOGNIZED);
                        this.mFrameRateRange = Range.create(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(maxRate));
                    } else {
                        if (!mime.equalsIgnoreCase(MediaFormat.MIMETYPE_VIDEO_VP8)) {
                            if (!mime.equalsIgnoreCase(MediaFormat.MIMETYPE_VIDEO_VP9)) {
                                if (mime.equalsIgnoreCase(MediaFormat.MIMETYPE_VIDEO_HEVC)) {
                                    maxBlocks = 36864;
                                    maxBlocksPerSecond = 36864 * 15;
                                    maxBps = 128000;
                                    arr$ = profileLevels;
                                    len$ = arr$.length;
                                    for (i$ = 0; i$ < len$; i$ += MediaCodecInfo.ERROR_UNRECOGNIZED) {
                                        profileLevel = arr$[i$];
                                        double FR2 = 0.0d;
                                        FS = 0;
                                        BR = 0;
                                        switch (profileLevel.level) {
                                            case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                                            case MediaCodecInfo.ERROR_UNSUPPORTED /*2*/:
                                                FR2 = 15.0d;
                                                FS = 36864;
                                                BR = AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
                                                break;
                                            case MediaCodecInfo.ERROR_NONE_SUPPORTED /*4*/:
                                            case SetPendingIntentTemplate.TAG /*8*/:
                                                FR2 = 30.0d;
                                                FS = 122880;
                                                BR = 1500;
                                                break;
                                            case RelativeLayout.START_OF /*16*/:
                                            case AccessibilityNodeInfo.ACTION_LONG_CLICK /*32*/:
                                                FR2 = 30.0d;
                                                FS = 245760;
                                                BR = 3000;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                                            case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                                                FR2 = 30.0d;
                                                FS = 552960;
                                                BR = BluetoothHealth.HEALTH_OPERATION_SUCCESS;
                                                break;
                                            case InputMethodManager.CONTROL_START_INITIAL /*256*/:
                                            case AccessibilityNodeInfo.ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY /*512*/:
                                                FR2 = 33.75d;
                                                FS = SurfaceControl.FX_SURFACE_MASK;
                                                BR = Window.PROGRESS_END;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_NEXT_HTML_ELEMENT /*1024*/:
                                                FR2 = 30.0d;
                                                FS = 2228224;
                                                BR = 12000;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_PREVIOUS_HTML_ELEMENT /*2048*/:
                                                FR2 = 30.0d;
                                                FS = 2228224;
                                                BR = Window.PROGRESS_SECONDARY_END;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_SCROLL_FORWARD /*4096*/:
                                                FR2 = 60.0d;
                                                FS = 2228224;
                                                BR = Window.PROGRESS_SECONDARY_START;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD /*8192*/:
                                                FR2 = 60.0d;
                                                FS = 2228224;
                                                BR = Process.FIRST_SHARED_APPLICATION_GID;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_COPY /*16384*/:
                                                FR2 = 30.0d;
                                                FS = 8912896;
                                                BR = 25000;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_PASTE /*32768*/:
                                                FR2 = 30.0d;
                                                FS = 8912896;
                                                BR = UserHandle.PER_USER_RANGE;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_CUT /*65536*/:
                                                FR2 = 60.0d;
                                                FS = 8912896;
                                                BR = 40000;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_SET_SELECTION /*131072*/:
                                                FR2 = 60.0d;
                                                FS = 8912896;
                                                BR = 160000;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_EXPAND /*262144*/:
                                                FR2 = 120.0d;
                                                FS = 8912896;
                                                BR = 60000;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_COLLAPSE /*524288*/:
                                                FR2 = 120.0d;
                                                FS = 8912896;
                                                BR = 240000;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_DISMISS /*1048576*/:
                                                FR2 = 30.0d;
                                                FS = 35651584;
                                                BR = 60000;
                                                break;
                                            case AccessibilityNodeInfo.ACTION_SET_TEXT /*2097152*/:
                                                FR2 = 30.0d;
                                                FS = 35651584;
                                                BR = 240000;
                                                break;
                                            case AccessibilityEvent.TYPE_WINDOWS_CHANGED /*4194304*/:
                                                FR2 = 60.0d;
                                                FS = 35651584;
                                                BR = 120000;
                                                break;
                                            case LayoutParams.FLAG_SPLIT_TOUCH /*8388608*/:
                                                FR2 = 60.0d;
                                                FS = 35651584;
                                                BR = 480000;
                                                break;
                                            case WindowManagerPolicy.FLAG_INJECTED /*16777216*/:
                                                FR2 = 120.0d;
                                                FS = 35651584;
                                                BR = 240000;
                                                break;
                                            case EditorInfo.IME_FLAG_NO_FULLSCREEN /*33554432*/:
                                                FR2 = 120.0d;
                                                FS = 35651584;
                                                BR = 800000;
                                                break;
                                            default:
                                                Log.w(TAG, "Unrecognized level " + profileLevel.level + " for " + mime);
                                                errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                                                break;
                                        }
                                        switch (profileLevel.profile) {
                                            case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                                            case MediaCodecInfo.ERROR_UNSUPPORTED /*2*/:
                                                break;
                                            default:
                                                Log.w(TAG, "Unrecognized profile " + profileLevel.profile + " for " + mime);
                                                errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                                                break;
                                        }
                                        errors &= -5;
                                        maxBlocksPerSecond = Math.max((int) (((double) FS) * FR2), maxBlocksPerSecond);
                                        maxBlocks = Math.max(FS, maxBlocks);
                                        maxBps = Math.max(BR * LayoutParams.TYPE_APPLICATION_PANEL, maxBps);
                                    }
                                    maxLengthInBlocks = (int) Math.sqrt((double) (maxBlocks * 8));
                                    maxBlocks = Utils.divUp(maxBlocks, 64);
                                    maxBlocksPerSecond = Utils.divUp(maxBlocksPerSecond, 64);
                                    maxLengthInBlocks = Utils.divUp(maxLengthInBlocks, 8);
                                    applyMacroBlockLimits(maxLengthInBlocks, maxLengthInBlocks, maxBlocks, (long) maxBlocksPerSecond, 8, 8, MediaCodecInfo.ERROR_UNRECOGNIZED, MediaCodecInfo.ERROR_UNRECOGNIZED);
                                } else {
                                    Log.w(TAG, "Unsupported mime " + mime);
                                    maxBps = 64000;
                                    errors = MediaCodecInfo.ERROR_NONE_SUPPORTED | MediaCodecInfo.ERROR_UNSUPPORTED;
                                }
                            }
                        }
                        maxBlocks = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
                        maxBps = 100000000;
                        arr$ = profileLevels;
                        len$ = arr$.length;
                        for (i$ = 0; i$ < len$; i$ += MediaCodecInfo.ERROR_UNRECOGNIZED) {
                            profileLevel = arr$[i$];
                            switch (profileLevel.level) {
                                case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                                case MediaCodecInfo.ERROR_UNSUPPORTED /*2*/:
                                case MediaCodecInfo.ERROR_NONE_SUPPORTED /*4*/:
                                case SetPendingIntentTemplate.TAG /*8*/:
                                    break;
                                default:
                                    Log.w(TAG, "Unrecognized level " + profileLevel.level + " for " + mime);
                                    errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                                    break;
                            }
                            switch (profileLevel.profile) {
                                case MediaCodecInfo.ERROR_UNRECOGNIZED /*1*/:
                                    break;
                                default:
                                    Log.w(TAG, "Unrecognized profile " + profileLevel.profile + " for " + mime);
                                    errors |= MediaCodecInfo.ERROR_UNRECOGNIZED;
                                    break;
                            }
                            errors &= -5;
                        }
                        int blockSize = mime.equalsIgnoreCase(MediaFormat.MIMETYPE_VIDEO_VP8) ? 16 : 8;
                        applyMacroBlockLimits(32767, 32767, maxBlocks, (long) ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED, blockSize, blockSize, MediaCodecInfo.ERROR_UNRECOGNIZED, MediaCodecInfo.ERROR_UNRECOGNIZED);
                    }
                }
            }
            this.mBitrateRange = Range.create(Integer.valueOf(MediaCodecInfo.ERROR_UNRECOGNIZED), Integer.valueOf(maxBps));
            CodecCapabilities codecCapabilities = this.mParent;
            codecCapabilities.mError |= errors;
        }
    }

    MediaCodecInfo(String name, boolean isEncoder, CodecCapabilities[] caps) {
        this.mName = name;
        this.mIsEncoder = isEncoder;
        this.mCaps = new HashMap();
        CodecCapabilities[] arr$ = caps;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += ERROR_UNRECOGNIZED) {
            CodecCapabilities c = arr$[i$];
            this.mCaps.put(c.getMimeType(), c);
        }
    }

    public final String getName() {
        return this.mName;
    }

    public final boolean isEncoder() {
        return this.mIsEncoder;
    }

    public final String[] getSupportedTypes() {
        Set<String> typeSet = this.mCaps.keySet();
        String[] types = (String[]) typeSet.toArray(new String[typeSet.size()]);
        Arrays.sort(types);
        return types;
    }

    private static int checkPowerOfTwo(int value, String message) {
        if (((value - 1) & value) == 0) {
            return value;
        }
        throw new IllegalArgumentException(message);
    }

    static {
        POSITIVE_INTEGERS = Range.create(Integer.valueOf(ERROR_UNRECOGNIZED), Integer.valueOf(ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED));
        POSITIVE_LONGS = Range.create(Long.valueOf(1), Long.valueOf(LinkQualityInfo.UNKNOWN_LONG));
        POSITIVE_RATIONALS = Range.create(new Rational(ERROR_UNRECOGNIZED, ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED), new Rational(ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED, ERROR_UNRECOGNIZED));
        SIZE_RANGE = Range.create(Integer.valueOf(ERROR_UNRECOGNIZED), Integer.valueOf(AccessibilityNodeInfo.ACTION_PASTE));
        FRAME_RATE_RANGE = Range.create(Integer.valueOf(0), Integer.valueOf(960));
        BITRATE_RANGE = Range.create(Integer.valueOf(0), Integer.valueOf(500000000));
    }

    public final CodecCapabilities getCapabilitiesForType(String type) {
        CodecCapabilities caps = (CodecCapabilities) this.mCaps.get(type);
        if (caps != null) {
            return caps.dup();
        }
        throw new IllegalArgumentException("codec does not support type");
    }

    public MediaCodecInfo makeRegular() {
        ArrayList<CodecCapabilities> caps = new ArrayList();
        for (CodecCapabilities c : this.mCaps.values()) {
            if (c.isRegular()) {
                caps.add(c);
            }
        }
        if (caps.size() == 0) {
            return null;
        }
        return caps.size() != this.mCaps.size() ? new MediaCodecInfo(this.mName, this.mIsEncoder, (CodecCapabilities[]) caps.toArray(new CodecCapabilities[caps.size()])) : this;
    }
}
