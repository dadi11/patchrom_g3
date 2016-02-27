package android.media;

import android.content.ContentResolver;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.BitmapFactory;
import android.graphics.BitmapFactory.Options;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Rect;
import android.media.MediaFile.MediaFileType;
import android.net.ProxyInfo;
import android.net.Uri;
import android.os.ParcelFileDescriptor;
import android.util.Log;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityNodeInfo;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.IOException;

public class ThumbnailUtils {
    private static final int MAX_NUM_PIXELS_MICRO_THUMBNAIL = 19200;
    private static final int MAX_NUM_PIXELS_THUMBNAIL = 196608;
    private static final int OPTIONS_NONE = 0;
    public static final int OPTIONS_RECYCLE_INPUT = 2;
    private static final int OPTIONS_SCALE_UP = 1;
    private static final String TAG = "ThumbnailUtils";
    public static final int TARGET_SIZE_MICRO_THUMBNAIL = 96;
    public static final int TARGET_SIZE_MINI_THUMBNAIL = 320;
    private static final int UNCONSTRAINED = -1;

    private static class SizedThumbnailBitmap {
        public Bitmap mBitmap;
        public byte[] mThumbnailData;
        public int mThumbnailHeight;
        public int mThumbnailWidth;

        private SizedThumbnailBitmap() {
        }
    }

    public static Bitmap createImageThumbnail(String filePath, int kind) {
        IOException ex;
        Throwable th;
        OutOfMemoryError oom;
        boolean wantMini = kind == OPTIONS_SCALE_UP;
        int targetSize = wantMini ? TARGET_SIZE_MINI_THUMBNAIL : TARGET_SIZE_MICRO_THUMBNAIL;
        int maxPixels = wantMini ? MAX_NUM_PIXELS_THUMBNAIL : MAX_NUM_PIXELS_MICRO_THUMBNAIL;
        SizedThumbnailBitmap sizedThumbnailBitmap = new SizedThumbnailBitmap();
        Bitmap bitmap = null;
        MediaFileType fileType = MediaFile.getFileType(filePath);
        if (fileType != null && fileType.fileType == 31) {
            createThumbnailFromEXIF(filePath, targetSize, maxPixels, sizedThumbnailBitmap);
            bitmap = sizedThumbnailBitmap.mBitmap;
        }
        if (bitmap == null) {
            FileInputStream stream = null;
            try {
                FileInputStream stream2 = new FileInputStream(filePath);
                try {
                    FileDescriptor fd = stream2.getFD();
                    Options options = new Options();
                    options.inSampleSize = OPTIONS_SCALE_UP;
                    options.inJustDecodeBounds = true;
                    BitmapFactory.decodeFileDescriptor(fd, null, options);
                    if (!options.mCancel && options.outWidth != UNCONSTRAINED && options.outHeight != UNCONSTRAINED) {
                        options.inSampleSize = computeSampleSize(options, targetSize, maxPixels);
                        options.inJustDecodeBounds = false;
                        options.inDither = false;
                        options.inPreferredConfig = Config.ARGB_8888;
                        bitmap = BitmapFactory.decodeFileDescriptor(fd, null, options);
                        if (stream2 != null) {
                            try {
                                stream2.close();
                            } catch (IOException ex2) {
                                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, ex2);
                            }
                        }
                    } else if (stream2 == null) {
                        return null;
                    } else {
                        try {
                            stream2.close();
                            return null;
                        } catch (IOException ex22) {
                            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, ex22);
                            return null;
                        }
                    }
                } catch (IOException e) {
                    ex22 = e;
                    stream = stream2;
                    try {
                        Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, ex22);
                        if (stream != null) {
                            try {
                                stream.close();
                            } catch (IOException ex222) {
                                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, ex222);
                            }
                        }
                        if (kind == 3) {
                            bitmap = extractThumbnail(bitmap, TARGET_SIZE_MICRO_THUMBNAIL, TARGET_SIZE_MICRO_THUMBNAIL, OPTIONS_RECYCLE_INPUT);
                        }
                        return bitmap;
                    } catch (Throwable th2) {
                        th = th2;
                        if (stream != null) {
                            try {
                                stream.close();
                            } catch (IOException ex2222) {
                                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, ex2222);
                            }
                        }
                        throw th;
                    }
                } catch (OutOfMemoryError e2) {
                    oom = e2;
                    stream = stream2;
                    Log.e(TAG, "Unable to decode file " + filePath + ". OutOfMemoryError.", oom);
                    if (stream != null) {
                        try {
                            stream.close();
                        } catch (IOException ex22222) {
                            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, ex22222);
                        }
                    }
                    if (kind == 3) {
                        bitmap = extractThumbnail(bitmap, TARGET_SIZE_MICRO_THUMBNAIL, TARGET_SIZE_MICRO_THUMBNAIL, OPTIONS_RECYCLE_INPUT);
                    }
                    return bitmap;
                } catch (Throwable th3) {
                    th = th3;
                    stream = stream2;
                    if (stream != null) {
                        stream.close();
                    }
                    throw th;
                }
            } catch (IOException e3) {
                ex22222 = e3;
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, ex22222);
                if (stream != null) {
                    stream.close();
                }
                if (kind == 3) {
                    bitmap = extractThumbnail(bitmap, TARGET_SIZE_MICRO_THUMBNAIL, TARGET_SIZE_MICRO_THUMBNAIL, OPTIONS_RECYCLE_INPUT);
                }
                return bitmap;
            } catch (OutOfMemoryError e4) {
                oom = e4;
                Log.e(TAG, "Unable to decode file " + filePath + ". OutOfMemoryError.", oom);
                if (stream != null) {
                    stream.close();
                }
                if (kind == 3) {
                    bitmap = extractThumbnail(bitmap, TARGET_SIZE_MICRO_THUMBNAIL, TARGET_SIZE_MICRO_THUMBNAIL, OPTIONS_RECYCLE_INPUT);
                }
                return bitmap;
            }
        }
        if (kind == 3) {
            bitmap = extractThumbnail(bitmap, TARGET_SIZE_MICRO_THUMBNAIL, TARGET_SIZE_MICRO_THUMBNAIL, OPTIONS_RECYCLE_INPUT);
        }
        return bitmap;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public static android.graphics.Bitmap createVideoThumbnail(java.lang.String r12, int r13) {
        /*
        r11 = 96;
        r10 = 1;
        r0 = 0;
        r4 = new android.media.MediaMetadataRetriever;
        r4.<init>();
        r4.setDataSource(r12);	 Catch:{ IllegalArgumentException -> 0x0019, RuntimeException -> 0x0020, all -> 0x0027 }
        r8 = -1;
        r0 = r4.getFrameAtTime(r8);	 Catch:{ IllegalArgumentException -> 0x0019, RuntimeException -> 0x0020, all -> 0x0027 }
        r4.release();	 Catch:{ RuntimeException -> 0x005e }
    L_0x0015:
        if (r0 != 0) goto L_0x002c;
    L_0x0017:
        r8 = 0;
    L_0x0018:
        return r8;
    L_0x0019:
        r8 = move-exception;
        r4.release();	 Catch:{ RuntimeException -> 0x001e }
        goto L_0x0015;
    L_0x001e:
        r8 = move-exception;
        goto L_0x0015;
    L_0x0020:
        r8 = move-exception;
        r4.release();	 Catch:{ RuntimeException -> 0x0025 }
        goto L_0x0015;
    L_0x0025:
        r8 = move-exception;
        goto L_0x0015;
    L_0x0027:
        r8 = move-exception;
        r4.release();	 Catch:{ RuntimeException -> 0x0060 }
    L_0x002b:
        throw r8;
    L_0x002c:
        if (r13 != r10) goto L_0x0055;
    L_0x002e:
        r7 = r0.getWidth();
        r2 = r0.getHeight();
        r3 = java.lang.Math.max(r7, r2);
        r8 = 512; // 0x200 float:7.175E-43 double:2.53E-321;
        if (r3 <= r8) goto L_0x0053;
    L_0x003e:
        r8 = 1140850688; // 0x44000000 float:512.0 double:5.63655132E-315;
        r9 = (float) r3;
        r5 = r8 / r9;
        r8 = (float) r7;
        r8 = r8 * r5;
        r6 = java.lang.Math.round(r8);
        r8 = (float) r2;
        r8 = r8 * r5;
        r1 = java.lang.Math.round(r8);
        r0 = android.graphics.Bitmap.createScaledBitmap(r0, r6, r1, r10);
    L_0x0053:
        r8 = r0;
        goto L_0x0018;
    L_0x0055:
        r8 = 3;
        if (r13 != r8) goto L_0x0053;
    L_0x0058:
        r8 = 2;
        r0 = extractThumbnail(r0, r11, r11, r8);
        goto L_0x0053;
    L_0x005e:
        r8 = move-exception;
        goto L_0x0015;
    L_0x0060:
        r9 = move-exception;
        goto L_0x002b;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.ThumbnailUtils.createVideoThumbnail(java.lang.String, int):android.graphics.Bitmap");
    }

    public static Bitmap extractThumbnail(Bitmap source, int width, int height) {
        return extractThumbnail(source, width, height, OPTIONS_NONE);
    }

    public static Bitmap extractThumbnail(Bitmap source, int width, int height, int options) {
        if (source == null) {
            return null;
        }
        float scale;
        if (source.getWidth() < source.getHeight()) {
            scale = ((float) width) / ((float) source.getWidth());
        } else {
            scale = ((float) height) / ((float) source.getHeight());
        }
        Matrix matrix = new Matrix();
        matrix.setScale(scale, scale);
        return transform(matrix, source, width, height, options | OPTIONS_SCALE_UP);
    }

    private static int computeSampleSize(Options options, int minSideLength, int maxNumOfPixels) {
        int initialSize = computeInitialSampleSize(options, minSideLength, maxNumOfPixels);
        if (initialSize > 8) {
            return ((initialSize + 7) / 8) * 8;
        }
        int roundedSize = OPTIONS_SCALE_UP;
        while (roundedSize < initialSize) {
            roundedSize <<= OPTIONS_SCALE_UP;
        }
        return roundedSize;
    }

    private static int computeInitialSampleSize(Options options, int minSideLength, int maxNumOfPixels) {
        double w = (double) options.outWidth;
        double h = (double) options.outHeight;
        int lowerBound = maxNumOfPixels == UNCONSTRAINED ? OPTIONS_SCALE_UP : (int) Math.ceil(Math.sqrt((w * h) / ((double) maxNumOfPixels)));
        int upperBound = minSideLength == UNCONSTRAINED ? AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS : (int) Math.min(Math.floor(w / ((double) minSideLength)), Math.floor(h / ((double) minSideLength)));
        if (upperBound < lowerBound) {
            return lowerBound;
        }
        if (maxNumOfPixels == UNCONSTRAINED && minSideLength == UNCONSTRAINED) {
            return OPTIONS_SCALE_UP;
        }
        if (minSideLength != UNCONSTRAINED) {
            return upperBound;
        }
        return lowerBound;
    }

    private static Bitmap makeBitmap(int minSideLength, int maxNumOfPixels, Uri uri, ContentResolver cr, ParcelFileDescriptor pfd, Options options) {
        if (pfd == null) {
            try {
                pfd = makeInputStream(uri, cr);
            } catch (OutOfMemoryError ex) {
                Log.e(TAG, "Got oom exception ", ex);
                return null;
            } finally {
                closeSilently(pfd);
            }
        }
        if (pfd == null) {
            closeSilently(pfd);
            return null;
        }
        if (options == null) {
            options = new Options();
        }
        FileDescriptor fd = pfd.getFileDescriptor();
        options.inSampleSize = OPTIONS_SCALE_UP;
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeFileDescriptor(fd, null, options);
        if (options.mCancel || options.outWidth == UNCONSTRAINED || options.outHeight == UNCONSTRAINED) {
            closeSilently(pfd);
            return null;
        }
        options.inSampleSize = computeSampleSize(options, minSideLength, maxNumOfPixels);
        options.inJustDecodeBounds = false;
        options.inDither = false;
        options.inPreferredConfig = Config.ARGB_8888;
        Bitmap b = BitmapFactory.decodeFileDescriptor(fd, null, options);
        closeSilently(pfd);
        return b;
    }

    private static void closeSilently(ParcelFileDescriptor c) {
        if (c != null) {
            try {
                c.close();
            } catch (Throwable th) {
            }
        }
    }

    private static ParcelFileDescriptor makeInputStream(Uri uri, ContentResolver cr) {
        try {
            return cr.openFileDescriptor(uri, "r");
        } catch (IOException e) {
            return null;
        }
    }

    private static Bitmap transform(Matrix scaler, Bitmap source, int targetWidth, int targetHeight, int options) {
        Bitmap b2;
        boolean scaleUp = (options & OPTIONS_SCALE_UP) != 0;
        boolean recycle = (options & OPTIONS_RECYCLE_INPUT) != 0;
        int deltaX = source.getWidth() - targetWidth;
        int deltaY = source.getHeight() - targetHeight;
        if (scaleUp || (deltaX >= 0 && deltaY >= 0)) {
            Bitmap b1;
            float bitmapWidthF = (float) source.getWidth();
            float bitmapHeightF = (float) source.getHeight();
            float scale;
            if (bitmapWidthF / bitmapHeightF > ((float) targetWidth) / ((float) targetHeight)) {
                scale = ((float) targetHeight) / bitmapHeightF;
                if (scale < 0.9f || scale > LayoutParams.BRIGHTNESS_OVERRIDE_FULL) {
                    scaler.setScale(scale, scale);
                } else {
                    scaler = null;
                }
            } else {
                scale = ((float) targetWidth) / bitmapWidthF;
                if (scale < 0.9f || scale > LayoutParams.BRIGHTNESS_OVERRIDE_FULL) {
                    scaler.setScale(scale, scale);
                } else {
                    scaler = null;
                }
            }
            if (scaler != null) {
                b1 = Bitmap.createBitmap(source, (int) OPTIONS_NONE, (int) OPTIONS_NONE, source.getWidth(), source.getHeight(), scaler, true);
            } else {
                b1 = source;
            }
            if (recycle && b1 != source) {
                source.recycle();
            }
            b2 = Bitmap.createBitmap(b1, Math.max(OPTIONS_NONE, b1.getWidth() - targetWidth) / OPTIONS_RECYCLE_INPUT, Math.max(OPTIONS_NONE, b1.getHeight() - targetHeight) / OPTIONS_RECYCLE_INPUT, targetWidth, targetHeight);
            if (b2 != b1 && (recycle || b1 != source)) {
                b1.recycle();
            }
        } else {
            b2 = Bitmap.createBitmap(targetWidth, targetHeight, Config.ARGB_8888);
            Canvas c = new Canvas(b2);
            int deltaXHalf = Math.max(OPTIONS_NONE, deltaX / OPTIONS_RECYCLE_INPUT);
            int deltaYHalf = Math.max(OPTIONS_NONE, deltaY / OPTIONS_RECYCLE_INPUT);
            Rect rect = new Rect(deltaXHalf, deltaYHalf, Math.min(targetWidth, source.getWidth()) + deltaXHalf, Math.min(targetHeight, source.getHeight()) + deltaYHalf);
            int dstX = (targetWidth - rect.width()) / OPTIONS_RECYCLE_INPUT;
            int dstY = (targetHeight - rect.height()) / OPTIONS_RECYCLE_INPUT;
            c.drawBitmap(source, rect, new Rect(dstX, dstY, targetWidth - dstX, targetHeight - dstY), null);
            if (recycle) {
                source.recycle();
            }
            c.setBitmap(null);
        }
        return b2;
    }

    private static void createThumbnailFromEXIF(String filePath, int targetSize, int maxPixels, SizedThumbnailBitmap sizedThumbBitmap) {
        IOException ex;
        Options exifOptions;
        int exifThumbWidth;
        if (filePath != null) {
            Options fullOptions;
            int fullThumbWidth;
            byte[] thumbData = null;
            try {
                ExifInterface exif = new ExifInterface(filePath);
                ExifInterface exifInterface;
                try {
                    thumbData = exif.getThumbnail();
                    exifInterface = exif;
                } catch (IOException e) {
                    ex = e;
                    exifInterface = exif;
                    Log.w(TAG, ex);
                    fullOptions = new Options();
                    exifOptions = new Options();
                    exifThumbWidth = OPTIONS_NONE;
                    if (thumbData != null) {
                        exifOptions.inJustDecodeBounds = true;
                        BitmapFactory.decodeByteArray(thumbData, OPTIONS_NONE, thumbData.length, exifOptions);
                        exifOptions.inSampleSize = computeSampleSize(exifOptions, targetSize, maxPixels);
                        exifThumbWidth = exifOptions.outWidth / exifOptions.inSampleSize;
                    }
                    fullOptions.inJustDecodeBounds = true;
                    BitmapFactory.decodeFile(filePath, fullOptions);
                    fullOptions.inSampleSize = computeSampleSize(fullOptions, targetSize, maxPixels);
                    fullThumbWidth = fullOptions.outWidth / fullOptions.inSampleSize;
                    if (thumbData != null) {
                    }
                    fullOptions.inJustDecodeBounds = false;
                    sizedThumbBitmap.mBitmap = BitmapFactory.decodeFile(filePath, fullOptions);
                    return;
                }
            } catch (IOException e2) {
                ex = e2;
                Log.w(TAG, ex);
                fullOptions = new Options();
                exifOptions = new Options();
                exifThumbWidth = OPTIONS_NONE;
                if (thumbData != null) {
                    exifOptions.inJustDecodeBounds = true;
                    BitmapFactory.decodeByteArray(thumbData, OPTIONS_NONE, thumbData.length, exifOptions);
                    exifOptions.inSampleSize = computeSampleSize(exifOptions, targetSize, maxPixels);
                    exifThumbWidth = exifOptions.outWidth / exifOptions.inSampleSize;
                }
                fullOptions.inJustDecodeBounds = true;
                BitmapFactory.decodeFile(filePath, fullOptions);
                fullOptions.inSampleSize = computeSampleSize(fullOptions, targetSize, maxPixels);
                fullThumbWidth = fullOptions.outWidth / fullOptions.inSampleSize;
                if (thumbData != null) {
                }
                fullOptions.inJustDecodeBounds = false;
                sizedThumbBitmap.mBitmap = BitmapFactory.decodeFile(filePath, fullOptions);
                return;
            }
            fullOptions = new Options();
            exifOptions = new Options();
            exifThumbWidth = OPTIONS_NONE;
            if (thumbData != null) {
                exifOptions.inJustDecodeBounds = true;
                BitmapFactory.decodeByteArray(thumbData, OPTIONS_NONE, thumbData.length, exifOptions);
                exifOptions.inSampleSize = computeSampleSize(exifOptions, targetSize, maxPixels);
                exifThumbWidth = exifOptions.outWidth / exifOptions.inSampleSize;
            }
            fullOptions.inJustDecodeBounds = true;
            BitmapFactory.decodeFile(filePath, fullOptions);
            fullOptions.inSampleSize = computeSampleSize(fullOptions, targetSize, maxPixels);
            fullThumbWidth = fullOptions.outWidth / fullOptions.inSampleSize;
            if (thumbData != null || exifThumbWidth < fullThumbWidth) {
                fullOptions.inJustDecodeBounds = false;
                sizedThumbBitmap.mBitmap = BitmapFactory.decodeFile(filePath, fullOptions);
                return;
            }
            int width = exifOptions.outWidth;
            int height = exifOptions.outHeight;
            exifOptions.inJustDecodeBounds = false;
            sizedThumbBitmap.mBitmap = BitmapFactory.decodeByteArray(thumbData, OPTIONS_NONE, thumbData.length, exifOptions);
            if (sizedThumbBitmap.mBitmap != null) {
                sizedThumbBitmap.mThumbnailData = thumbData;
                sizedThumbBitmap.mThumbnailWidth = width;
                sizedThumbBitmap.mThumbnailHeight = height;
            }
        }
    }
}
