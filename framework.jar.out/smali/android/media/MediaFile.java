package android.media;

import android.content.ClipDescription;
import android.media.DecoderCapabilities.AudioDecoder;
import android.media.DecoderCapabilities.VideoDecoder;
import android.mtp.MtpConstants;
import android.opengl.EGL14;
import android.opengl.GLES11;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

public class MediaFile {
    public static final int FILE_TYPE_3GPA = 301;
    public static final int FILE_TYPE_3GPP = 23;
    public static final int FILE_TYPE_3GPP2 = 24;
    public static final int FILE_TYPE_AAC = 8;
    public static final int FILE_TYPE_AC3 = 302;
    public static final int FILE_TYPE_AMR = 4;
    public static final int FILE_TYPE_APE = 306;
    public static final int FILE_TYPE_ASF = 26;
    public static final int FILE_TYPE_AVI = 29;
    public static final int FILE_TYPE_AWB = 5;
    public static final int FILE_TYPE_BMP = 34;
    public static final int FILE_TYPE_DASH = 45;
    public static final int FILE_TYPE_DIVX = 201;
    public static final int FILE_TYPE_DTS = 300;
    public static final int FILE_TYPE_EC3 = 305;
    public static final int FILE_TYPE_FL = 51;
    public static final int FILE_TYPE_FLAC = 10;
    public static final int FILE_TYPE_FLV = 202;
    public static final int FILE_TYPE_GIF = 32;
    public static final int FILE_TYPE_HTML = 101;
    public static final int FILE_TYPE_HTTPLIVE = 44;
    public static final int FILE_TYPE_IMY = 13;
    public static final int FILE_TYPE_JPEG = 31;
    public static final int FILE_TYPE_M3U = 41;
    public static final int FILE_TYPE_M4A = 2;
    public static final int FILE_TYPE_M4V = 22;
    public static final int FILE_TYPE_MID = 11;
    public static final int FILE_TYPE_MKA = 9;
    public static final int FILE_TYPE_MKV = 27;
    public static final int FILE_TYPE_MP2PS = 200;
    public static final int FILE_TYPE_MP2TS = 28;
    public static final int FILE_TYPE_MP3 = 1;
    public static final int FILE_TYPE_MP4 = 21;
    public static final int FILE_TYPE_MS_EXCEL = 105;
    public static final int FILE_TYPE_MS_POWERPOINT = 106;
    public static final int FILE_TYPE_MS_WORD = 104;
    public static final int FILE_TYPE_OGG = 7;
    public static final int FILE_TYPE_PCM = 304;
    public static final int FILE_TYPE_PDF = 102;
    public static final int FILE_TYPE_PLS = 42;
    public static final int FILE_TYPE_PNG = 33;
    public static final int FILE_TYPE_QCP = 303;
    public static final int FILE_TYPE_SMF = 12;
    public static final int FILE_TYPE_TEXT = 100;
    public static final int FILE_TYPE_WAV = 3;
    public static final int FILE_TYPE_WBMP = 35;
    public static final int FILE_TYPE_WEBM = 30;
    public static final int FILE_TYPE_WEBP = 36;
    public static final int FILE_TYPE_WMA = 6;
    public static final int FILE_TYPE_WMV = 25;
    public static final int FILE_TYPE_WPL = 43;
    public static final int FILE_TYPE_XML = 103;
    public static final int FILE_TYPE_ZIP = 107;
    private static final int FIRST_AUDIO_FILE_TYPE = 1;
    private static final int FIRST_AUDIO_FILE_TYPE_EXT = 300;
    private static final int FIRST_DRM_FILE_TYPE = 51;
    private static final int FIRST_IMAGE_FILE_TYPE = 31;
    private static final int FIRST_MIDI_FILE_TYPE = 11;
    private static final int FIRST_PLAYLIST_FILE_TYPE = 41;
    private static final int FIRST_VIDEO_FILE_TYPE = 21;
    private static final int FIRST_VIDEO_FILE_TYPE2 = 200;
    private static final int LAST_AUDIO_FILE_TYPE = 10;
    private static final int LAST_AUDIO_FILE_TYPE_EXT = 306;
    private static final int LAST_DRM_FILE_TYPE = 51;
    private static final int LAST_IMAGE_FILE_TYPE = 36;
    private static final int LAST_MIDI_FILE_TYPE = 13;
    private static final int LAST_PLAYLIST_FILE_TYPE = 45;
    private static final int LAST_VIDEO_FILE_TYPE = 30;
    private static final int LAST_VIDEO_FILE_TYPE2 = 202;
    private static final HashMap<String, MediaFileType> sFileTypeMap;
    private static final HashMap<String, Integer> sFileTypeToFormatMap;
    private static final HashMap<Integer, String> sFormatToMimeTypeMap;
    private static final HashMap<String, Integer> sMimeTypeMap;
    private static final HashMap<String, Integer> sMimeTypeToFormatMap;

    public static class MediaFileType {
        public final int fileType;
        public final String mimeType;

        MediaFileType(int fileType, String mimeType) {
            this.fileType = fileType;
            this.mimeType = mimeType;
        }
    }

    static {
        sFileTypeMap = new HashMap();
        sMimeTypeMap = new HashMap();
        sFileTypeToFormatMap = new HashMap();
        sMimeTypeToFormatMap = new HashMap();
        sFormatToMimeTypeMap = new HashMap();
        addFileType("MP3", FIRST_AUDIO_FILE_TYPE, MediaFormat.MIMETYPE_AUDIO_MPEG, EGL14.EGL_BAD_MATCH);
        addFileType("MP3D", FIRST_AUDIO_FILE_TYPE, "audio/mp3d", EGL14.EGL_BAD_MATCH);
        addFileType("MPGA", FIRST_AUDIO_FILE_TYPE, MediaFormat.MIMETYPE_AUDIO_MPEG, EGL14.EGL_BAD_MATCH);
        addFileType("M4A", FILE_TYPE_M4A, "audio/m4a", EGL14.EGL_BAD_NATIVE_WINDOW);
        addFileType("M4A", FILE_TYPE_M4A, MediaFormat.MIMETYPE_AUDIO_AAC, EGL14.EGL_BAD_NATIVE_WINDOW);
        addFileType("M4A", FILE_TYPE_M4A, "audio/mp4", EGL14.EGL_BAD_NATIVE_WINDOW);
        addFileType("WAV", FILE_TYPE_WAV, "audio/wav", EGL14.EGL_BAD_DISPLAY);
        addFileType("WAV", FILE_TYPE_WAV, "audio/x-wav", EGL14.EGL_BAD_DISPLAY);
        addFileType("AMR", FILE_TYPE_AMR, "audio/amr");
        addFileType("AWB", FILE_TYPE_AWB, MediaFormat.MIMETYPE_AUDIO_AMR_WB);
        if (isWMAEnabled()) {
            addFileType("WMA", FILE_TYPE_WMA, "audio/x-ms-wma", MtpConstants.FORMAT_WMA);
        }
        addFileType("OGG", FILE_TYPE_OGG, "audio/ogg", MtpConstants.FORMAT_OGG);
        addFileType("OGG", FILE_TYPE_OGG, "application/ogg", MtpConstants.FORMAT_OGG);
        addFileType("OGA", FILE_TYPE_OGG, "application/ogg", MtpConstants.FORMAT_OGG);
        addFileType("AAC", FILE_TYPE_AAC, "audio/aac", MtpConstants.FORMAT_AAC);
        addFileType("AAC", FILE_TYPE_AAC, "audio/aac-adts", MtpConstants.FORMAT_AAC);
        addFileType("MKA", FILE_TYPE_MKA, "audio/x-matroska");
        addFileType("3G2", FILE_TYPE_3GPP2, "audio/3gpp2", MtpConstants.FORMAT_3GP_CONTAINER);
        addFileType("MID", FIRST_MIDI_FILE_TYPE, "audio/midi");
        addFileType("MIDI", FIRST_MIDI_FILE_TYPE, "audio/midi");
        addFileType("XMF", FIRST_MIDI_FILE_TYPE, "audio/midi");
        addFileType("RTTTL", FIRST_MIDI_FILE_TYPE, "audio/midi");
        addFileType("SMF", FILE_TYPE_SMF, "audio/sp-midi");
        addFileType("IMY", LAST_MIDI_FILE_TYPE, "audio/imelody");
        addFileType("RTX", FIRST_MIDI_FILE_TYPE, "audio/midi");
        addFileType("OTA", FIRST_MIDI_FILE_TYPE, "audio/midi");
        addFileType("MXMF", FIRST_MIDI_FILE_TYPE, "audio/midi");
        addFileType("MPEG", FIRST_VIDEO_FILE_TYPE, "video/mpeg", EGL14.EGL_BAD_NATIVE_WINDOW);
        addFileType("MPG", FIRST_VIDEO_FILE_TYPE, "video/mpeg", EGL14.EGL_BAD_NATIVE_WINDOW);
        addFileType("MP4", FIRST_VIDEO_FILE_TYPE, "video/mp4", EGL14.EGL_BAD_NATIVE_WINDOW);
        addFileType("M4V", FILE_TYPE_M4V, "video/mp4", EGL14.EGL_BAD_NATIVE_WINDOW);
        addFileType("3GP", FILE_TYPE_3GPP, MediaFormat.MIMETYPE_VIDEO_H263, MtpConstants.FORMAT_3GP_CONTAINER);
        addFileType("3GPP", FILE_TYPE_3GPP, MediaFormat.MIMETYPE_VIDEO_H263, MtpConstants.FORMAT_3GP_CONTAINER);
        addFileType("3G2", FILE_TYPE_3GPP2, "video/3gpp2", MtpConstants.FORMAT_3GP_CONTAINER);
        addFileType("3GPP2", FILE_TYPE_3GPP2, "video/3gpp2", MtpConstants.FORMAT_3GP_CONTAINER);
        addFileType("MKV", FILE_TYPE_MKV, "video/x-matroska");
        addFileType("WEBM", LAST_VIDEO_FILE_TYPE, "video/webm");
        addFileType("TS", FILE_TYPE_MP2TS, "video/mp2ts");
        addFileType("AVI", FILE_TYPE_AVI, "video/avi");
        if (isWMVEnabled()) {
            addFileType("WMV", FILE_TYPE_WMV, "video/x-ms-wmv", MtpConstants.FORMAT_WMV);
            addFileType("ASF", FILE_TYPE_ASF, "video/x-ms-asf");
        }
        addFileType("JPG", FIRST_IMAGE_FILE_TYPE, "image/jpeg", MtpConstants.FORMAT_EXIF_JPEG);
        addFileType("JPEG", FIRST_IMAGE_FILE_TYPE, "image/jpeg", MtpConstants.FORMAT_EXIF_JPEG);
        addFileType("GIF", FILE_TYPE_GIF, "image/gif", MtpConstants.FORMAT_GIF);
        addFileType("PNG", FILE_TYPE_PNG, "image/png", MtpConstants.FORMAT_PNG);
        addFileType("BMP", FILE_TYPE_BMP, "image/bmp", MtpConstants.FORMAT_BMP);
        addFileType("BMP", FILE_TYPE_BMP, "image/x-ms-bmp", MtpConstants.FORMAT_BMP);
        addFileType("WBMP", FILE_TYPE_WBMP, "image/vnd.wap.wbmp");
        addFileType("WEBP", LAST_IMAGE_FILE_TYPE, "image/webp");
        addFileType("M3U", FIRST_PLAYLIST_FILE_TYPE, "audio/x-mpegurl", MtpConstants.FORMAT_M3U_PLAYLIST);
        addFileType("M3U", FIRST_PLAYLIST_FILE_TYPE, "application/x-mpegurl", MtpConstants.FORMAT_M3U_PLAYLIST);
        addFileType("PLS", FILE_TYPE_PLS, "audio/x-scpls", MtpConstants.FORMAT_PLS_PLAYLIST);
        addFileType("WPL", FILE_TYPE_WPL, "application/vnd.ms-wpl", MtpConstants.FORMAT_WPL_PLAYLIST);
        addFileType("M3U8", FILE_TYPE_HTTPLIVE, "application/vnd.apple.mpegurl");
        addFileType("M3U8", FILE_TYPE_HTTPLIVE, "audio/mpegurl");
        addFileType("M3U8", FILE_TYPE_HTTPLIVE, "audio/x-mpegurl");
        addFileType("MPD", LAST_PLAYLIST_FILE_TYPE, "application/dash+xml");
        addFileType("FL", LAST_DRM_FILE_TYPE, "application/x-android-drm-fl");
        addFileType("TXT", FILE_TYPE_TEXT, ClipDescription.MIMETYPE_TEXT_PLAIN, GLES11.GL_CLIP_PLANE4);
        addFileType("HTM", FILE_TYPE_HTML, ClipDescription.MIMETYPE_TEXT_HTML, GLES11.GL_CLIP_PLANE5);
        addFileType("HTML", FILE_TYPE_HTML, ClipDescription.MIMETYPE_TEXT_HTML, GLES11.GL_CLIP_PLANE5);
        addFileType("PDF", FILE_TYPE_PDF, "application/pdf");
        addFileType("DOC", FILE_TYPE_MS_WORD, "application/msword", MtpConstants.FORMAT_MS_WORD_DOCUMENT);
        addFileType("XLS", FILE_TYPE_MS_EXCEL, "application/vnd.ms-excel", MtpConstants.FORMAT_MS_EXCEL_SPREADSHEET);
        addFileType("PPT", FILE_TYPE_MS_POWERPOINT, "application/mspowerpoint", MtpConstants.FORMAT_MS_POWERPOINT_PRESENTATION);
        addFileType("FLAC", LAST_AUDIO_FILE_TYPE, MediaFormat.MIMETYPE_AUDIO_FLAC, MtpConstants.FORMAT_FLAC);
        addFileType("ZIP", FILE_TYPE_ZIP, "application/zip");
        addFileType("MPG", FIRST_VIDEO_FILE_TYPE2, "video/mp2p");
        addFileType("MPEG", FIRST_VIDEO_FILE_TYPE2, "video/mp2p");
        addFileType("DIVX", FILE_TYPE_DIVX, "video/divx");
        addFileType("QCP", FILE_TYPE_QCP, MediaFormat.MIMETYPE_AUDIO_QCELP);
        addFileType("AC3", FILE_TYPE_AC3, MediaFormat.MIMETYPE_AUDIO_AC3);
        addFileType("EC3", FILE_TYPE_EC3, MediaFormat.MIMETYPE_AUDIO_EAC3);
        addFileType("FLV", LAST_VIDEO_FILE_TYPE2, "video/x-flv");
        addFileType("APE", LAST_AUDIO_FILE_TYPE_EXT, "audio/x-ape");
    }

    static void addFileType(String extension, int fileType, String mimeType) {
        sFileTypeMap.put(extension, new MediaFileType(fileType, mimeType));
        sMimeTypeMap.put(mimeType, Integer.valueOf(fileType));
    }

    static void addFileType(String extension, int fileType, String mimeType, int mtpFormatCode) {
        addFileType(extension, fileType, mimeType);
        sFileTypeToFormatMap.put(extension, Integer.valueOf(mtpFormatCode));
        sMimeTypeToFormatMap.put(mimeType, Integer.valueOf(mtpFormatCode));
        sFormatToMimeTypeMap.put(Integer.valueOf(mtpFormatCode), mimeType);
    }

    private static boolean isWMAEnabled() {
        List<AudioDecoder> decoders = DecoderCapabilities.getAudioDecoders();
        int count = decoders.size();
        for (int i = 0; i < count; i += FIRST_AUDIO_FILE_TYPE) {
            if (((AudioDecoder) decoders.get(i)) == AudioDecoder.AUDIO_DECODER_WMA) {
                return true;
            }
        }
        return false;
    }

    private static boolean isWMVEnabled() {
        List<VideoDecoder> decoders = DecoderCapabilities.getVideoDecoders();
        int count = decoders.size();
        for (int i = 0; i < count; i += FIRST_AUDIO_FILE_TYPE) {
            if (((VideoDecoder) decoders.get(i)) == VideoDecoder.VIDEO_DECODER_WMV) {
                return true;
            }
        }
        return false;
    }

    public static boolean isAudioFileType(int fileType) {
        if (fileType >= FIRST_AUDIO_FILE_TYPE && fileType <= LAST_AUDIO_FILE_TYPE) {
            return true;
        }
        if (fileType < FIRST_MIDI_FILE_TYPE || fileType > LAST_MIDI_FILE_TYPE) {
            return fileType >= FIRST_AUDIO_FILE_TYPE_EXT && fileType <= LAST_AUDIO_FILE_TYPE_EXT;
        } else {
            return true;
        }
    }

    public static boolean isVideoFileType(int fileType) {
        return (fileType >= FIRST_VIDEO_FILE_TYPE && fileType <= LAST_VIDEO_FILE_TYPE) || (fileType >= FIRST_VIDEO_FILE_TYPE2 && fileType <= LAST_VIDEO_FILE_TYPE2);
    }

    public static boolean isImageFileType(int fileType) {
        return fileType >= FIRST_IMAGE_FILE_TYPE && fileType <= LAST_IMAGE_FILE_TYPE;
    }

    public static boolean isPlayListFileType(int fileType) {
        return fileType >= FIRST_PLAYLIST_FILE_TYPE && fileType <= LAST_PLAYLIST_FILE_TYPE;
    }

    public static boolean isDrmFileType(int fileType) {
        return fileType >= LAST_DRM_FILE_TYPE && fileType <= LAST_DRM_FILE_TYPE;
    }

    public static MediaFileType getFileType(String path) {
        int lastDot = path.lastIndexOf(46);
        if (lastDot < 0) {
            return null;
        }
        return (MediaFileType) sFileTypeMap.get(path.substring(lastDot + FIRST_AUDIO_FILE_TYPE).toUpperCase(Locale.ROOT));
    }

    public static boolean isMimeTypeMedia(String mimeType) {
        int fileType = getFileTypeForMimeType(mimeType);
        return isAudioFileType(fileType) || isVideoFileType(fileType) || isImageFileType(fileType) || isPlayListFileType(fileType);
    }

    public static String getFileTitle(String path) {
        int lastSlash = path.lastIndexOf(47);
        if (lastSlash >= 0) {
            lastSlash += FIRST_AUDIO_FILE_TYPE;
            if (lastSlash < path.length()) {
                path = path.substring(lastSlash);
            }
        }
        int lastDot = path.lastIndexOf(46);
        if (lastDot > 0) {
            return path.substring(0, lastDot);
        }
        return path;
    }

    public static int getFileTypeForMimeType(String mimeType) {
        Integer value = (Integer) sMimeTypeMap.get(mimeType);
        return value == null ? 0 : value.intValue();
    }

    public static String getMimeTypeForFile(String path) {
        MediaFileType mediaFileType = getFileType(path);
        return mediaFileType == null ? null : mediaFileType.mimeType;
    }

    public static int getFormatCode(String fileName, String mimeType) {
        Integer value;
        if (mimeType != null) {
            value = (Integer) sMimeTypeToFormatMap.get(mimeType);
            if (value != null) {
                return value.intValue();
            }
        }
        int lastDot = fileName.lastIndexOf(46);
        if (lastDot > 0) {
            value = (Integer) sFileTypeToFormatMap.get(fileName.substring(lastDot + FIRST_AUDIO_FILE_TYPE).toUpperCase(Locale.ROOT));
            if (value != null) {
                return value.intValue();
            }
        }
        return GLES11.GL_CLIP_PLANE0;
    }

    public static String getMimeTypeForFormatCode(int formatCode) {
        return (String) sFormatToMimeTypeMap.get(Integer.valueOf(formatCode));
    }
}
