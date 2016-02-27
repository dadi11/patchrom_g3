package android.media;

import android.content.ContentResolver;
import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.IBinder;
import java.io.FileDescriptor;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Map;
import java.util.Map.Entry;

public class MediaMetadataRetriever {
    private static final int EMBEDDED_PICTURE_TYPE_ANY = 65535;
    public static final int METADATA_KEY_ALBUM = 1;
    public static final int METADATA_KEY_ALBUMARTIST = 13;
    public static final int METADATA_KEY_ARTIST = 2;
    public static final int METADATA_KEY_AUTHOR = 3;
    public static final int METADATA_KEY_BITRATE = 20;
    public static final int METADATA_KEY_CD_TRACK_NUMBER = 0;
    public static final int METADATA_KEY_COMPILATION = 15;
    public static final int METADATA_KEY_COMPOSER = 4;
    public static final int METADATA_KEY_DATE = 5;
    public static final int METADATA_KEY_DISC_NUMBER = 14;
    public static final int METADATA_KEY_DURATION = 9;
    public static final int METADATA_KEY_GENRE = 6;
    public static final int METADATA_KEY_HAS_AUDIO = 16;
    public static final int METADATA_KEY_HAS_VIDEO = 17;
    public static final int METADATA_KEY_IS_DRM = 22;
    public static final int METADATA_KEY_LOCATION = 23;
    public static final int METADATA_KEY_MIMETYPE = 12;
    public static final int METADATA_KEY_NUM_TRACKS = 10;
    public static final int METADATA_KEY_TIMED_TEXT_LANGUAGES = 21;
    public static final int METADATA_KEY_TITLE = 7;
    public static final int METADATA_KEY_VIDEO_HEIGHT = 19;
    public static final int METADATA_KEY_VIDEO_ROTATION = 24;
    public static final int METADATA_KEY_VIDEO_WIDTH = 18;
    public static final int METADATA_KEY_WRITER = 11;
    public static final int METADATA_KEY_YEAR = 8;
    public static final int OPTION_CLOSEST = 3;
    public static final int OPTION_CLOSEST_SYNC = 2;
    public static final int OPTION_NEXT_SYNC = 1;
    public static final int OPTION_PREVIOUS_SYNC = 0;
    private long mNativeContext;

    private native Bitmap _getFrameAtTime(long j, int i);

    private native void _setDataSource(IBinder iBinder, String str, String[] strArr, String[] strArr2) throws IllegalArgumentException;

    private native byte[] getEmbeddedPicture(int i);

    private final native void native_finalize();

    private static native void native_init();

    private native void native_setup();

    public native String extractMetadata(int i);

    public native void release();

    public native void setDataSource(FileDescriptor fileDescriptor, long j, long j2) throws IllegalArgumentException;

    static {
        System.loadLibrary("media_jni");
        native_init();
    }

    public MediaMetadataRetriever() {
        native_setup();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void setDataSource(java.lang.String r13) throws java.lang.IllegalArgumentException {
        /*
        r12 = this;
        if (r13 != 0) goto L_0x0008;
    L_0x0002:
        r0 = new java.lang.IllegalArgumentException;
        r0.<init>();
        throw r0;
    L_0x0008:
        r8 = new java.io.FileInputStream;	 Catch:{ FileNotFoundException -> 0x002a, IOException -> 0x0035 }
        r8.<init>(r13);	 Catch:{ FileNotFoundException -> 0x002a, IOException -> 0x0035 }
        r10 = 0;
        r1 = r8.getFD();	 Catch:{ Throwable -> 0x003c, all -> 0x0053 }
        r2 = 0;
        r4 = 576460752303423487; // 0x7ffffffffffffff float:NaN double:3.7857669957336787E-270;
        r0 = r12;
        r0.setDataSource(r1, r2, r4);	 Catch:{ Throwable -> 0x003c, all -> 0x0053 }
        if (r8 == 0) goto L_0x0024;
    L_0x001f:
        if (r10 == 0) goto L_0x0031;
    L_0x0021:
        r8.close();	 Catch:{ Throwable -> 0x0025 }
    L_0x0024:
        return;
    L_0x0025:
        r9 = move-exception;
        r10.addSuppressed(r9);	 Catch:{ FileNotFoundException -> 0x002a, IOException -> 0x0035 }
        goto L_0x0024;
    L_0x002a:
        r6 = move-exception;
        r0 = new java.lang.IllegalArgumentException;
        r0.<init>();
        throw r0;
    L_0x0031:
        r8.close();	 Catch:{ FileNotFoundException -> 0x002a, IOException -> 0x0035 }
        goto L_0x0024;
    L_0x0035:
        r7 = move-exception;
        r0 = new java.lang.IllegalArgumentException;
        r0.<init>();
        throw r0;
    L_0x003c:
        r0 = move-exception;
        throw r0;	 Catch:{ all -> 0x003e }
    L_0x003e:
        r2 = move-exception;
        r11 = r2;
        r2 = r0;
        r0 = r11;
    L_0x0042:
        if (r8 == 0) goto L_0x0049;
    L_0x0044:
        if (r2 == 0) goto L_0x004f;
    L_0x0046:
        r8.close();	 Catch:{ Throwable -> 0x004a }
    L_0x0049:
        throw r0;	 Catch:{ FileNotFoundException -> 0x002a, IOException -> 0x0035 }
    L_0x004a:
        r9 = move-exception;
        r2.addSuppressed(r9);	 Catch:{ FileNotFoundException -> 0x002a, IOException -> 0x0035 }
        goto L_0x0049;
    L_0x004f:
        r8.close();	 Catch:{ FileNotFoundException -> 0x002a, IOException -> 0x0035 }
        goto L_0x0049;
    L_0x0053:
        r0 = move-exception;
        r2 = r10;
        goto L_0x0042;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.MediaMetadataRetriever.setDataSource(java.lang.String):void");
    }

    public void setDataSource(String uri, Map<String, String> headers) throws IllegalArgumentException {
        int i = METADATA_KEY_CD_TRACK_NUMBER;
        String[] keys = new String[headers.size()];
        String[] values = new String[headers.size()];
        for (Entry<String, String> entry : headers.entrySet()) {
            keys[i] = (String) entry.getKey();
            values[i] = (String) entry.getValue();
            i += OPTION_NEXT_SYNC;
        }
        _setDataSource(MediaHTTPService.createHttpServiceBinderIfNecessary(uri), uri, keys, values);
    }

    public void setDataSource(FileDescriptor fd) throws IllegalArgumentException {
        setDataSource(fd, 0, 576460752303423487L);
    }

    public void setDataSource(Context context, Uri uri) throws IllegalArgumentException, SecurityException {
        if (uri == null) {
            throw new IllegalArgumentException();
        }
        String scheme = uri.getScheme();
        if (scheme == null || scheme.equals(ContentResolver.SCHEME_FILE)) {
            setDataSource(uri.getPath());
            return;
        }
        AssetFileDescriptor fd = null;
        try {
            fd = context.getContentResolver().openAssetFileDescriptor(uri, "r");
            if (fd == null) {
                throw new IllegalArgumentException();
            }
            FileDescriptor descriptor = fd.getFileDescriptor();
            if (descriptor.valid()) {
                if (fd.getDeclaredLength() < 0) {
                    setDataSource(descriptor);
                } else {
                    setDataSource(descriptor, fd.getStartOffset(), fd.getDeclaredLength());
                }
                if (fd != null) {
                    try {
                        fd.close();
                        return;
                    } catch (IOException e) {
                        return;
                    }
                }
                return;
            }
            throw new IllegalArgumentException();
        } catch (FileNotFoundException e2) {
            throw new IllegalArgumentException();
        } catch (SecurityException e3) {
            if (fd != null) {
                try {
                    fd.close();
                } catch (IOException e4) {
                }
            }
            setDataSource(uri.toString());
        } catch (Throwable th) {
            if (fd != null) {
                try {
                    fd.close();
                } catch (IOException e5) {
                }
            }
        }
    }

    public Bitmap getFrameAtTime(long timeUs, int option) {
        if (option >= 0 && option <= OPTION_CLOSEST) {
            return _getFrameAtTime(timeUs, option);
        }
        throw new IllegalArgumentException("Unsupported option: " + option);
    }

    public Bitmap getFrameAtTime(long timeUs) {
        return getFrameAtTime(timeUs, OPTION_CLOSEST_SYNC);
    }

    public Bitmap getFrameAtTime() {
        return getFrameAtTime(-1, OPTION_CLOSEST_SYNC);
    }

    public byte[] getEmbeddedPicture() {
        return getEmbeddedPicture(EMBEDDED_PICTURE_TYPE_ANY);
    }

    protected void finalize() throws Throwable {
        try {
            native_finalize();
        } finally {
            super.finalize();
        }
    }
}
