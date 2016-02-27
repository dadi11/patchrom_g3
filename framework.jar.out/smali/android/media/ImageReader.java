package android.media;

import android.graphics.ImageFormat;
import android.media.Image.Plane;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.view.MotionEvent;
import android.view.Surface;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.RelativeLayout;
import android.widget.Toast;
import java.lang.ref.WeakReference;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.NioUtils;

public class ImageReader implements AutoCloseable {
    private static final int ACQUIRE_MAX_IMAGES = 2;
    private static final int ACQUIRE_NO_BUFS = 1;
    private static final int ACQUIRE_SUCCESS = 0;
    private final int mFormat;
    private final int mHeight;
    private OnImageAvailableListener mListener;
    private ListenerHandler mListenerHandler;
    private final Object mListenerLock;
    private final int mMaxImages;
    private long mNativeContext;
    private final int mNumPlanes;
    private final Surface mSurface;
    private final int mWidth;

    private final class ListenerHandler extends Handler {
        public ListenerHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            synchronized (ImageReader.this.mListenerLock) {
                OnImageAvailableListener listener = ImageReader.this.mListener;
            }
            if (listener != null) {
                listener.onImageAvailable(ImageReader.this);
            }
        }
    }

    public interface OnImageAvailableListener {
        void onImageAvailable(ImageReader imageReader);
    }

    private class SurfaceImage extends Image {
        private int mHeight;
        private boolean mIsImageValid;
        private long mLockedBuffer;
        private SurfacePlane[] mPlanes;
        private long mTimestamp;
        private int mWidth;

        private class SurfacePlane extends Plane {
            private ByteBuffer mBuffer;
            private final int mIndex;
            private final int mPixelStride;
            private final int mRowStride;

            private SurfacePlane(int index, int rowStride, int pixelStride) {
                this.mIndex = index;
                this.mRowStride = rowStride;
                this.mPixelStride = pixelStride;
            }

            public ByteBuffer getBuffer() {
                if (!SurfaceImage.this.isImageValid()) {
                    throw new IllegalStateException("Image is already released");
                } else if (this.mBuffer != null) {
                    return this.mBuffer;
                } else {
                    this.mBuffer = SurfaceImage.this.nativeImageGetBuffer(this.mIndex, ImageReader.this.mFormat);
                    return this.mBuffer.order(ByteOrder.nativeOrder());
                }
            }

            public int getPixelStride() {
                if (SurfaceImage.this.isImageValid()) {
                    return this.mPixelStride;
                }
                throw new IllegalStateException("Image is already released");
            }

            public int getRowStride() {
                if (SurfaceImage.this.isImageValid()) {
                    return this.mRowStride;
                }
                throw new IllegalStateException("Image is already released");
            }

            private void clearBuffer() {
                if (this.mBuffer != null) {
                    if (this.mBuffer.isDirect()) {
                        NioUtils.freeDirectBuffer(this.mBuffer);
                    }
                    this.mBuffer = null;
                }
            }
        }

        private native synchronized SurfacePlane nativeCreatePlane(int i, int i2);

        private native synchronized int nativeGetHeight();

        private native synchronized int nativeGetWidth();

        private native synchronized ByteBuffer nativeImageGetBuffer(int i, int i2);

        public SurfaceImage() {
            this.mHeight = -1;
            this.mWidth = -1;
            this.mIsImageValid = false;
        }

        public void close() {
            if (this.mIsImageValid) {
                ImageReader.this.releaseImage(this);
            }
        }

        public ImageReader getReader() {
            return ImageReader.this;
        }

        public int getFormat() {
            if (this.mIsImageValid) {
                return ImageReader.this.mFormat;
            }
            throw new IllegalStateException("Image is already released");
        }

        public int getWidth() {
            if (this.mIsImageValid) {
                if (this.mWidth == -1) {
                    this.mWidth = getFormat() == InputMethodManager.CONTROL_START_INITIAL ? ImageReader.this.getWidth() : nativeGetWidth();
                }
                return this.mWidth;
            }
            throw new IllegalStateException("Image is already released");
        }

        public int getHeight() {
            if (this.mIsImageValid) {
                if (this.mHeight == -1) {
                    this.mHeight = getFormat() == InputMethodManager.CONTROL_START_INITIAL ? ImageReader.this.getHeight() : nativeGetHeight();
                }
                return this.mHeight;
            }
            throw new IllegalStateException("Image is already released");
        }

        public long getTimestamp() {
            if (this.mIsImageValid) {
                return this.mTimestamp;
            }
            throw new IllegalStateException("Image is already released");
        }

        public Plane[] getPlanes() {
            if (this.mIsImageValid) {
                return (Plane[]) this.mPlanes.clone();
            }
            throw new IllegalStateException("Image is already released");
        }

        protected final void finalize() throws Throwable {
            try {
                close();
            } finally {
                super.finalize();
            }
        }

        private void setImageValid(boolean isValid) {
            this.mIsImageValid = isValid;
        }

        private boolean isImageValid() {
            return this.mIsImageValid;
        }

        private void clearSurfacePlanes() {
            if (this.mIsImageValid) {
                for (int i = 0; i < this.mPlanes.length; i += ImageReader.ACQUIRE_NO_BUFS) {
                    if (this.mPlanes[i] != null) {
                        this.mPlanes[i].clearBuffer();
                        this.mPlanes[i] = null;
                    }
                }
            }
        }

        private void createSurfacePlanes() {
            this.mPlanes = new SurfacePlane[ImageReader.this.mNumPlanes];
            for (int i = 0; i < ImageReader.this.mNumPlanes; i += ImageReader.ACQUIRE_NO_BUFS) {
                this.mPlanes[i] = nativeCreatePlane(i, ImageReader.this.mFormat);
            }
        }
    }

    private static native void nativeClassInit();

    private native synchronized void nativeClose();

    private native synchronized Surface nativeGetSurface();

    private native synchronized int nativeImageSetup(Image image);

    private native synchronized void nativeInit(Object obj, int i, int i2, int i3, int i4);

    private native synchronized void nativeReleaseImage(Image image);

    public static ImageReader newInstance(int width, int height, int format, int maxImages) {
        return new ImageReader(width, height, format, maxImages);
    }

    protected ImageReader(int width, int height, int format, int maxImages) {
        this.mListenerLock = new Object();
        this.mWidth = width;
        this.mHeight = height;
        this.mFormat = format;
        this.mMaxImages = maxImages;
        if (width < ACQUIRE_NO_BUFS || height < ACQUIRE_NO_BUFS) {
            throw new IllegalArgumentException("The image dimensions must be positive");
        } else if (this.mMaxImages < ACQUIRE_NO_BUFS) {
            throw new IllegalArgumentException("Maximum outstanding image count must be at least 1");
        } else if (format == 17) {
            throw new IllegalArgumentException("NV21 format is not supported");
        } else {
            this.mNumPlanes = getNumPlanesFromFormat();
            nativeInit(new WeakReference(this), width, height, format, maxImages);
            this.mSurface = nativeGetSurface();
        }
    }

    public int getWidth() {
        return this.mWidth;
    }

    public int getHeight() {
        return this.mHeight;
    }

    public int getImageFormat() {
        return this.mFormat;
    }

    public int getMaxImages() {
        return this.mMaxImages;
    }

    public Surface getSurface() {
        return this.mSurface;
    }

    public Image acquireLatestImage() {
        Image image = acquireNextImage();
        if (image == null) {
            return null;
        }
        while (true) {
            Image next = acquireNextImageNoThrowISE();
            if (next == null) {
                break;
            }
            try {
                image.close();
                image = next;
            } catch (Throwable th) {
                if (image != null) {
                    image.close();
                }
            }
        }
        Image result = image;
        image = null;
        if (image == null) {
            return result;
        }
        image.close();
        return result;
    }

    public Image acquireNextImageNoThrowISE() {
        SurfaceImage si = new SurfaceImage();
        return acquireNextSurfaceImage(si) == 0 ? si : null;
    }

    private int acquireNextSurfaceImage(SurfaceImage si) {
        int status = nativeImageSetup(si);
        switch (status) {
            case Toast.LENGTH_SHORT /*0*/:
                si.createSurfacePlanes();
                si.setImageValid(true);
                break;
            case ACQUIRE_NO_BUFS /*1*/:
            case ACQUIRE_MAX_IMAGES /*2*/:
                break;
            default:
                throw new AssertionError("Unknown nativeImageSetup return code " + status);
        }
        return status;
    }

    public Image acquireNextImage() {
        SurfaceImage si = new SurfaceImage();
        int status = acquireNextSurfaceImage(si);
        switch (status) {
            case Toast.LENGTH_SHORT /*0*/:
                return si;
            case ACQUIRE_NO_BUFS /*1*/:
                return null;
            case ACQUIRE_MAX_IMAGES /*2*/:
                Object[] objArr = new Object[ACQUIRE_NO_BUFS];
                objArr[0] = Integer.valueOf(this.mMaxImages);
                throw new IllegalStateException(String.format("maxImages (%d) has already been acquired, call #close before acquiring more.", objArr));
            default:
                throw new AssertionError("Unknown nativeImageSetup return code " + status);
        }
    }

    private void releaseImage(Image i) {
        if (i instanceof SurfaceImage) {
            SurfaceImage si = (SurfaceImage) i;
            if (si.getReader() != this) {
                throw new IllegalArgumentException("This image was not produced by this ImageReader");
            }
            si.clearSurfacePlanes();
            nativeReleaseImage(i);
            si.setImageValid(false);
            return;
        }
        throw new IllegalArgumentException("This image was not produced by an ImageReader");
    }

    public void setOnImageAvailableListener(OnImageAvailableListener listener, Handler handler) {
        synchronized (this.mListenerLock) {
            if (listener != null) {
                Looper looper = handler != null ? handler.getLooper() : Looper.myLooper();
                if (looper == null) {
                    throw new IllegalArgumentException("handler is null but the current thread is not a looper");
                }
                if (this.mListenerHandler == null || this.mListenerHandler.getLooper() != looper) {
                    this.mListenerHandler = new ListenerHandler(looper);
                }
                this.mListener = listener;
            } else {
                this.mListener = null;
                this.mListenerHandler = null;
            }
        }
    }

    public void close() {
        setOnImageAvailableListener(null, null);
        nativeClose();
    }

    protected void finalize() throws Throwable {
        try {
            close();
        } finally {
            super.finalize();
        }
    }

    private int getNumPlanesFromFormat() {
        switch (this.mFormat) {
            case ACQUIRE_NO_BUFS /*1*/:
            case ACQUIRE_MAX_IMAGES /*2*/:
            case SetDrawableParameters.TAG /*3*/:
            case ViewGroupAction.TAG /*4*/:
            case RelativeLayout.ALIGN_PARENT_START /*20*/:
            case AccessibilityNodeInfo.ACTION_LONG_CLICK /*32*/:
            case MotionEvent.AXIS_GENERIC_6 /*37*/:
            case InputMethodManager.CONTROL_START_INITIAL /*256*/:
            case ImageFormat.Y8 /*538982489*/:
            case ImageFormat.Y16 /*540422489*/:
                return ACQUIRE_NO_BUFS;
            case RelativeLayout.START_OF /*16*/:
                return ACQUIRE_MAX_IMAGES;
            case TextViewDrawableColorFilterAction.TAG /*17*/:
            case MotionEvent.AXIS_GENERIC_4 /*35*/:
            case ImageFormat.YV12 /*842094169*/:
                return 3;
            default:
                Object[] objArr = new Object[ACQUIRE_NO_BUFS];
                objArr[0] = Integer.valueOf(this.mFormat);
                throw new UnsupportedOperationException(String.format("Invalid format specified %d", objArr));
        }
    }

    private static void postEventFromNative(Object selfRef) {
        ImageReader ir = (ImageReader) ((WeakReference) selfRef).get();
        if (ir != null) {
            Handler handler;
            synchronized (ir.mListenerLock) {
                handler = ir.mListenerHandler;
            }
            if (handler != null) {
                handler.sendEmptyMessage(0);
            }
        }
    }

    static {
        System.loadLibrary("media_jni");
        nativeClassInit();
    }
}
