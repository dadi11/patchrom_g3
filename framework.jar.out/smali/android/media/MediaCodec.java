package android.media;

import android.graphics.Rect;
import android.media.Image.Plane;
import android.net.ProxyInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.view.KeyEvent;
import android.view.Surface;
import android.view.WindowManager.LayoutParams;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.NioUtils;
import java.nio.ReadOnlyBufferException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

public final class MediaCodec {
    public static final int BUFFER_FLAG_CODEC_CONFIG = 2;
    public static final int BUFFER_FLAG_END_OF_STREAM = 4;
    public static final int BUFFER_FLAG_KEY_FRAME = 1;
    public static final int BUFFER_FLAG_SYNC_FRAME = 1;
    private static final int CB_ERROR = 3;
    private static final int CB_INPUT_AVAILABLE = 1;
    private static final int CB_OUTPUT_AVAILABLE = 2;
    private static final int CB_OUTPUT_FORMAT_CHANGE = 4;
    public static final int CONFIGURE_FLAG_ENCODE = 1;
    public static final int CRYPTO_MODE_AES_CTR = 1;
    public static final int CRYPTO_MODE_UNENCRYPTED = 0;
    private static final int EVENT_CALLBACK = 1;
    private static final int EVENT_SET_CALLBACK = 2;
    public static final int INFO_OUTPUT_BUFFERS_CHANGED = -3;
    public static final int INFO_OUTPUT_FORMAT_CHANGED = -2;
    public static final int INFO_TRY_AGAIN_LATER = -1;
    public static final String PARAMETER_KEY_REQUEST_SYNC_FRAME = "request-sync";
    public static final String PARAMETER_KEY_SUSPEND = "drop-input-frames";
    public static final String PARAMETER_KEY_VIDEO_BITRATE = "video-bitrate";
    public static final int VIDEO_SCALING_MODE_SCALE_TO_FIT = 1;
    public static final int VIDEO_SCALING_MODE_SCALE_TO_FIT_WITH_CROPPING = 2;
    private final Object mBufferLock;
    private ByteBuffer[] mCachedInputBuffers;
    private ByteBuffer[] mCachedOutputBuffers;
    private Callback mCallback;
    private final BufferMap mDequeuedInputBuffers;
    private final BufferMap mDequeuedOutputBuffers;
    private EventHandler mEventHandler;
    private long mNativeContext;

    public static final class BufferInfo {
        public int flags;
        public int offset;
        public long presentationTimeUs;
        public int size;

        public void set(int newOffset, int newSize, long newTimeUs, int newFlags) {
            this.offset = newOffset;
            this.size = newSize;
            this.presentationTimeUs = newTimeUs;
            this.flags = newFlags;
        }
    }

    private static class BufferMap {
        private final Map<Integer, CodecBuffer> mMap;

        private static class CodecBuffer {
            private ByteBuffer mByteBuffer;
            private Image mImage;

            private CodecBuffer() {
            }

            public void free() {
                if (this.mByteBuffer != null) {
                    NioUtils.freeDirectBuffer(this.mByteBuffer);
                    this.mByteBuffer = null;
                }
                if (this.mImage != null) {
                    this.mImage.close();
                    this.mImage = null;
                }
            }

            public void setImage(Image image) {
                free();
                this.mImage = image;
            }

            public void setByteBuffer(ByteBuffer buffer) {
                free();
                this.mByteBuffer = buffer;
            }
        }

        private BufferMap() {
            this.mMap = new HashMap();
        }

        public void remove(int index) {
            CodecBuffer buffer = (CodecBuffer) this.mMap.get(Integer.valueOf(index));
            if (buffer != null) {
                buffer.free();
                this.mMap.remove(Integer.valueOf(index));
            }
        }

        public void put(int index, ByteBuffer newBuffer) {
            CodecBuffer buffer = (CodecBuffer) this.mMap.get(Integer.valueOf(index));
            if (buffer == null) {
                buffer = new CodecBuffer();
                this.mMap.put(Integer.valueOf(index), buffer);
            }
            buffer.setByteBuffer(newBuffer);
        }

        public void put(int index, Image newImage) {
            CodecBuffer buffer = (CodecBuffer) this.mMap.get(Integer.valueOf(index));
            if (buffer == null) {
                buffer = new CodecBuffer();
                this.mMap.put(Integer.valueOf(index), buffer);
            }
            buffer.setImage(newImage);
        }

        public void clear() {
            for (CodecBuffer buffer : this.mMap.values()) {
                buffer.free();
            }
            this.mMap.clear();
        }
    }

    public static abstract class Callback {
        public abstract void onError(MediaCodec mediaCodec, CodecException codecException);

        public abstract void onInputBufferAvailable(MediaCodec mediaCodec, int i);

        public abstract void onOutputBufferAvailable(MediaCodec mediaCodec, int i, BufferInfo bufferInfo);

        public abstract void onOutputFormatChanged(MediaCodec mediaCodec, MediaFormat mediaFormat);
    }

    public static final class CodecException extends IllegalStateException {
        private static final int ACTION_RECOVERABLE = 2;
        private static final int ACTION_TRANSIENT = 1;
        private final int mActionCode;
        private final String mDiagnosticInfo;
        private final int mErrorCode;

        CodecException(int errorCode, int actionCode, String detailMessage) {
            super(detailMessage);
            this.mErrorCode = errorCode;
            this.mActionCode = actionCode;
            this.mDiagnosticInfo = "android.media.MediaCodec.error_" + (errorCode < 0 ? "neg_" : ProxyInfo.LOCAL_EXCL_LIST) + Math.abs(errorCode);
        }

        public boolean isTransient() {
            return this.mActionCode == ACTION_TRANSIENT;
        }

        public boolean isRecoverable() {
            return this.mActionCode == ACTION_RECOVERABLE;
        }

        public int getErrorCode() {
            return this.mErrorCode;
        }

        public String getDiagnosticInfo() {
            return this.mDiagnosticInfo;
        }
    }

    public static final class CryptoException extends RuntimeException {
        public static final int ERROR_INSUFFICIENT_OUTPUT_PROTECTION = 4;
        public static final int ERROR_KEY_EXPIRED = 2;
        public static final int ERROR_NO_KEY = 1;
        public static final int ERROR_RESOURCE_BUSY = 3;
        private int mErrorCode;

        public CryptoException(int errorCode, String detailMessage) {
            super(detailMessage);
            this.mErrorCode = errorCode;
        }

        public int getErrorCode() {
            return this.mErrorCode;
        }
    }

    public static final class CryptoInfo {
        public byte[] iv;
        public byte[] key;
        public int mode;
        public int[] numBytesOfClearData;
        public int[] numBytesOfEncryptedData;
        public int numSubSamples;

        public void set(int newNumSubSamples, int[] newNumBytesOfClearData, int[] newNumBytesOfEncryptedData, byte[] newKey, byte[] newIV, int newMode) {
            this.numSubSamples = newNumSubSamples;
            this.numBytesOfClearData = newNumBytesOfClearData;
            this.numBytesOfEncryptedData = newNumBytesOfEncryptedData;
            this.key = newKey;
            this.iv = newIV;
            this.mode = newMode;
        }

        public String toString() {
            int i;
            StringBuilder builder = new StringBuilder();
            builder.append(this.numSubSamples + " subsamples, key [");
            String hexdigits = "0123456789abcdef";
            for (i = MediaCodec.CRYPTO_MODE_UNENCRYPTED; i < this.key.length; i += MediaCodec.VIDEO_SCALING_MODE_SCALE_TO_FIT) {
                builder.append(hexdigits.charAt((this.key[i] & LayoutParams.SOFT_INPUT_MASK_ADJUST) >> MediaCodec.CB_OUTPUT_FORMAT_CHANGE));
                builder.append(hexdigits.charAt(this.key[i] & 15));
            }
            builder.append("], iv [");
            for (i = MediaCodec.CRYPTO_MODE_UNENCRYPTED; i < this.key.length; i += MediaCodec.VIDEO_SCALING_MODE_SCALE_TO_FIT) {
                builder.append(hexdigits.charAt((this.iv[i] & LayoutParams.SOFT_INPUT_MASK_ADJUST) >> MediaCodec.CB_OUTPUT_FORMAT_CHANGE));
                builder.append(hexdigits.charAt(this.iv[i] & 15));
            }
            builder.append("], clear ");
            builder.append(Arrays.toString(this.numBytesOfClearData));
            builder.append(", encrypted ");
            builder.append(Arrays.toString(this.numBytesOfEncryptedData));
            return builder.toString();
        }
    }

    private class EventHandler extends Handler {
        private MediaCodec mCodec;

        public EventHandler(MediaCodec codec, Looper looper) {
            super(looper);
            this.mCodec = codec;
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case MediaCodec.VIDEO_SCALING_MODE_SCALE_TO_FIT /*1*/:
                    handleCallback(msg);
                case MediaCodec.VIDEO_SCALING_MODE_SCALE_TO_FIT_WITH_CROPPING /*2*/:
                    MediaCodec.this.mCallback = (Callback) msg.obj;
                default:
            }
        }

        private void handleCallback(Message msg) {
            if (MediaCodec.this.mCallback != null) {
                int index;
                switch (msg.arg1) {
                    case MediaCodec.VIDEO_SCALING_MODE_SCALE_TO_FIT /*1*/:
                        index = msg.arg2;
                        synchronized (MediaCodec.this.mBufferLock) {
                            MediaCodec.this.validateInputByteBuffer(MediaCodec.this.mCachedInputBuffers, index);
                            break;
                        }
                        MediaCodec.this.mCallback.onInputBufferAvailable(this.mCodec, index);
                    case MediaCodec.VIDEO_SCALING_MODE_SCALE_TO_FIT_WITH_CROPPING /*2*/:
                        index = msg.arg2;
                        BufferInfo info = msg.obj;
                        synchronized (MediaCodec.this.mBufferLock) {
                            MediaCodec.this.validateOutputByteBuffer(MediaCodec.this.mCachedOutputBuffers, index, info);
                            break;
                        }
                        MediaCodec.this.mCallback.onOutputBufferAvailable(this.mCodec, index, info);
                    case MediaCodec.CB_ERROR /*3*/:
                        MediaCodec.this.mCallback.onError(this.mCodec, (CodecException) msg.obj);
                    case MediaCodec.CB_OUTPUT_FORMAT_CHANGE /*4*/:
                        synchronized (MediaCodec.this.mBufferLock) {
                            MediaCodec.this.cacheBuffers(false);
                            break;
                        }
                        MediaCodec.this.mCallback.onOutputFormatChanged(this.mCodec, new MediaFormat((Map) msg.obj));
                    default:
                }
            }
        }
    }

    public static class MediaImage extends Image {
        private static final int TYPE_YUV = 1;
        private final ByteBuffer mBuffer;
        private final int mFormat;
        private final int mHeight;
        private final ByteBuffer mInfo;
        private final boolean mIsReadOnly;
        private boolean mIsValid;
        private final Plane[] mPlanes;
        private long mTimestamp;
        private final int mWidth;
        private final int mXOffset;
        private final int mYOffset;

        private class MediaPlane extends Plane {
            private final int mColInc;
            private final ByteBuffer mData;
            private final int mRowInc;

            public MediaPlane(ByteBuffer buffer, int rowInc, int colInc) {
                this.mData = buffer;
                this.mRowInc = rowInc;
                this.mColInc = colInc;
            }

            public int getRowStride() {
                MediaImage.this.checkValid();
                return this.mRowInc;
            }

            public int getPixelStride() {
                MediaImage.this.checkValid();
                return this.mColInc;
            }

            public ByteBuffer getBuffer() {
                MediaImage.this.checkValid();
                return this.mData;
            }
        }

        public int getFormat() {
            checkValid();
            return this.mFormat;
        }

        public int getHeight() {
            checkValid();
            return this.mHeight;
        }

        public int getWidth() {
            checkValid();
            return this.mWidth;
        }

        public long getTimestamp() {
            checkValid();
            return this.mTimestamp;
        }

        public Plane[] getPlanes() {
            checkValid();
            return (Plane[]) Arrays.copyOf(this.mPlanes, this.mPlanes.length);
        }

        public void close() {
            if (this.mIsValid) {
                NioUtils.freeDirectBuffer(this.mBuffer);
                this.mIsValid = false;
            }
        }

        public void setCropRect(Rect cropRect) {
            if (this.mIsReadOnly) {
                throw new ReadOnlyBufferException();
            }
            super.setCropRect(cropRect);
        }

        private void checkValid() {
            if (!this.mIsValid) {
                throw new IllegalStateException("Image is already released");
            }
        }

        private int readInt(ByteBuffer buffer, boolean asLong) {
            if (asLong) {
                return (int) buffer.getLong();
            }
            return buffer.getInt();
        }

        public MediaImage(ByteBuffer buffer, ByteBuffer info, boolean readOnly, long timestamp, int xOffset, int yOffset, Rect cropRect) {
            this.mFormat = 35;
            this.mTimestamp = timestamp;
            this.mIsValid = true;
            this.mIsReadOnly = buffer.isReadOnly();
            this.mBuffer = buffer.duplicate();
            this.mXOffset = xOffset;
            this.mYOffset = yOffset;
            this.mInfo = info;
            if (info.remaining() == 80 || info.remaining() == KeyEvent.KEYCODE_NUMPAD_SUBTRACT || info.remaining() == KeyEvent.KEYCODE_NUMPAD_ENTER) {
                boolean sizeIsLong = info.remaining() != 80;
                int type = readInt(info, info.remaining() == KeyEvent.KEYCODE_NUMPAD_ENTER);
                if (type != TYPE_YUV) {
                    throw new UnsupportedOperationException("unsupported type: " + type);
                }
                int numPlanes = readInt(info, sizeIsLong);
                if (numPlanes != MediaCodec.CB_ERROR) {
                    throw new RuntimeException("unexpected number of planes: " + numPlanes);
                }
                this.mWidth = readInt(info, sizeIsLong);
                this.mHeight = readInt(info, sizeIsLong);
                if (this.mWidth < TYPE_YUV || this.mHeight < TYPE_YUV) {
                    throw new UnsupportedOperationException("unsupported size: " + this.mWidth + "x" + this.mHeight);
                }
                int bitDepth = readInt(info, sizeIsLong);
                if (bitDepth != 8) {
                    throw new UnsupportedOperationException("unsupported bit depth: " + bitDepth);
                }
                this.mPlanes = new MediaPlane[numPlanes];
                int ix = MediaCodec.CRYPTO_MODE_UNENCRYPTED;
                while (ix < numPlanes) {
                    int planeOffset = readInt(info, sizeIsLong);
                    int colInc = readInt(info, sizeIsLong);
                    int rowInc = readInt(info, sizeIsLong);
                    int horiz = readInt(info, sizeIsLong);
                    int vert = readInt(info, sizeIsLong);
                    if (horiz == vert) {
                        if (horiz == (ix == 0 ? TYPE_YUV : MediaCodec.VIDEO_SCALING_MODE_SCALE_TO_FIT_WITH_CROPPING)) {
                            buffer.clear();
                            buffer.position(((this.mBuffer.position() + planeOffset) + ((xOffset / horiz) * colInc)) + ((yOffset / vert) * rowInc));
                            buffer.limit(((buffer.position() + Utils.divUp(bitDepth, 8)) + (((this.mHeight / vert) + MediaCodec.INFO_TRY_AGAIN_LATER) * rowInc)) + (((this.mWidth / horiz) + MediaCodec.INFO_TRY_AGAIN_LATER) * colInc));
                            this.mPlanes[ix] = new MediaPlane(buffer.slice(), rowInc, colInc);
                            ix += TYPE_YUV;
                        }
                    }
                    throw new UnsupportedOperationException("unexpected subsampling: " + horiz + "x" + vert + " on plane " + ix);
                }
                if (cropRect == null) {
                    Rect rect = new Rect(MediaCodec.CRYPTO_MODE_UNENCRYPTED, MediaCodec.CRYPTO_MODE_UNENCRYPTED, this.mWidth, this.mHeight);
                }
                cropRect.offset(-xOffset, -yOffset);
                super.setCropRect(cropRect);
                return;
            }
            throw new UnsupportedOperationException("unsupported info length: " + info.remaining());
        }
    }

    private final native ByteBuffer getBuffer(boolean z, int i);

    private final native ByteBuffer[] getBuffers(boolean z);

    private final native Map<String, Object> getFormatNative(boolean z);

    private final native Image getImage(boolean z, int i);

    private final native Map<String, Object> getOutputFormatNative(int i);

    private final native void native_configure(String[] strArr, Object[] objArr, Surface surface, MediaCrypto mediaCrypto, int i);

    private final native int native_dequeueInputBuffer(long j);

    private final native int native_dequeueOutputBuffer(BufferInfo bufferInfo, long j);

    private final native void native_finalize();

    private final native void native_flush();

    private static final native void native_init();

    private final native void native_queueInputBuffer(int i, int i2, int i3, long j, int i4) throws CryptoException;

    private final native void native_queueSecureInputBuffer(int i, int i2, CryptoInfo cryptoInfo, long j, int i3) throws CryptoException;

    private final native void native_release();

    private final native void native_reset();

    private final native void native_setCallback(Callback callback);

    private final native void native_setup(String str, boolean z, boolean z2);

    private final native void native_start();

    private final native void native_stop();

    private final native void releaseOutputBuffer(int i, boolean z, boolean z2, long j);

    private final native void setParameters(String[] strArr, Object[] objArr);

    public final native Surface createInputSurface();

    public final native String getName();

    public final native void setVideoScalingMode(int i);

    public final native void signalEndOfInputStream();

    public static MediaCodec createDecoderByType(String type) throws IOException {
        return new MediaCodec(type, true, false);
    }

    public static MediaCodec createEncoderByType(String type) throws IOException {
        return new MediaCodec(type, true, true);
    }

    public static MediaCodec createByCodecName(String name) throws IOException {
        return new MediaCodec(name, false, false);
    }

    private MediaCodec(String name, boolean nameIsType, boolean encoder) {
        this.mDequeuedInputBuffers = new BufferMap();
        this.mDequeuedOutputBuffers = new BufferMap();
        Looper looper = Looper.myLooper();
        if (looper != null) {
            this.mEventHandler = new EventHandler(this, looper);
        } else {
            looper = Looper.getMainLooper();
            if (looper != null) {
                this.mEventHandler = new EventHandler(this, looper);
            } else {
                this.mEventHandler = null;
            }
        }
        this.mBufferLock = new Object();
        native_setup(name, nameIsType, encoder);
    }

    protected void finalize() {
        native_finalize();
    }

    public final void reset() {
        freeAllTrackedBuffers();
        native_reset();
    }

    public final void release() {
        freeAllTrackedBuffers();
        native_release();
    }

    public void configure(MediaFormat format, Surface surface, MediaCrypto crypto, int flags) {
        Map<String, Object> formatMap = format.getMap();
        String[] keys = null;
        Object[] values = null;
        if (format != null) {
            keys = new String[formatMap.size()];
            values = new Object[formatMap.size()];
            int i = CRYPTO_MODE_UNENCRYPTED;
            for (Entry<String, Object> entry : formatMap.entrySet()) {
                if (((String) entry.getKey()).equals(MediaFormat.KEY_AUDIO_SESSION_ID)) {
                    try {
                        int sessionId = ((Integer) entry.getValue()).intValue();
                        keys[i] = "audio-hw-sync";
                        values[i] = Integer.valueOf(AudioSystem.getAudioHwSyncForSession(sessionId));
                    } catch (Exception e) {
                        throw new IllegalArgumentException("Wrong Session ID Parameter!");
                    }
                }
                keys[i] = (String) entry.getKey();
                values[i] = entry.getValue();
                i += VIDEO_SCALING_MODE_SCALE_TO_FIT;
            }
        }
        native_configure(keys, values, surface, crypto, flags);
    }

    public final void start() {
        native_start();
        synchronized (this.mBufferLock) {
            cacheBuffers(true);
            cacheBuffers(false);
        }
    }

    public final void stop() {
        native_stop();
        freeAllTrackedBuffers();
        if (this.mEventHandler != null) {
            this.mEventHandler.removeMessages(VIDEO_SCALING_MODE_SCALE_TO_FIT);
            this.mEventHandler.removeMessages(VIDEO_SCALING_MODE_SCALE_TO_FIT_WITH_CROPPING);
        }
    }

    public final void flush() {
        synchronized (this.mBufferLock) {
            invalidateByteBuffers(this.mCachedInputBuffers);
            invalidateByteBuffers(this.mCachedOutputBuffers);
            this.mDequeuedInputBuffers.clear();
            this.mDequeuedOutputBuffers.clear();
        }
        native_flush();
    }

    public final void queueInputBuffer(int index, int offset, int size, long presentationTimeUs, int flags) throws CryptoException {
        RuntimeException e;
        synchronized (this.mBufferLock) {
            invalidateByteBuffer(this.mCachedInputBuffers, index);
            this.mDequeuedInputBuffers.remove(index);
        }
        try {
            native_queueInputBuffer(index, offset, size, presentationTimeUs, flags);
        } catch (CryptoException e2) {
            e = e2;
            revalidateByteBuffer(this.mCachedInputBuffers, index);
            throw e;
        } catch (IllegalStateException e3) {
            e = e3;
            revalidateByteBuffer(this.mCachedInputBuffers, index);
            throw e;
        }
    }

    public final void queueSecureInputBuffer(int index, int offset, CryptoInfo info, long presentationTimeUs, int flags) throws CryptoException {
        RuntimeException e;
        synchronized (this.mBufferLock) {
            invalidateByteBuffer(this.mCachedInputBuffers, index);
            this.mDequeuedInputBuffers.remove(index);
        }
        try {
            native_queueSecureInputBuffer(index, offset, info, presentationTimeUs, flags);
        } catch (CryptoException e2) {
            e = e2;
            revalidateByteBuffer(this.mCachedInputBuffers, index);
            throw e;
        } catch (IllegalStateException e3) {
            e = e3;
            revalidateByteBuffer(this.mCachedInputBuffers, index);
            throw e;
        }
    }

    public final int dequeueInputBuffer(long timeoutUs) {
        int res = native_dequeueInputBuffer(timeoutUs);
        if (res >= 0) {
            synchronized (this.mBufferLock) {
                validateInputByteBuffer(this.mCachedInputBuffers, res);
            }
        }
        return res;
    }

    public final int dequeueOutputBuffer(BufferInfo info, long timeoutUs) {
        int res = native_dequeueOutputBuffer(info, timeoutUs);
        synchronized (this.mBufferLock) {
            if (res == INFO_OUTPUT_BUFFERS_CHANGED) {
                cacheBuffers(false);
            } else if (res >= 0) {
                validateOutputByteBuffer(this.mCachedOutputBuffers, res, info);
            }
        }
        return res;
    }

    public final void releaseOutputBuffer(int index, boolean render) {
        synchronized (this.mBufferLock) {
            invalidateByteBuffer(this.mCachedOutputBuffers, index);
            this.mDequeuedOutputBuffers.remove(index);
        }
        releaseOutputBuffer(index, render, false, 0);
    }

    public final void releaseOutputBuffer(int index, long renderTimestampNs) {
        synchronized (this.mBufferLock) {
            invalidateByteBuffer(this.mCachedOutputBuffers, index);
            this.mDequeuedOutputBuffers.remove(index);
        }
        releaseOutputBuffer(index, true, true, renderTimestampNs);
    }

    public final MediaFormat getOutputFormat() {
        return new MediaFormat(getFormatNative(false));
    }

    public final MediaFormat getInputFormat() {
        return new MediaFormat(getFormatNative(true));
    }

    public final MediaFormat getOutputFormat(int index) {
        return new MediaFormat(getOutputFormatNative(index));
    }

    private final void invalidateByteBuffer(ByteBuffer[] buffers, int index) {
        if (buffers != null && index >= 0 && index < buffers.length) {
            ByteBuffer buffer = buffers[index];
            if (buffer != null) {
                buffer.setAccessible(false);
            }
        }
    }

    private final void validateInputByteBuffer(ByteBuffer[] buffers, int index) {
        if (buffers != null && index >= 0 && index < buffers.length) {
            ByteBuffer buffer = buffers[index];
            if (buffer != null) {
                buffer.setAccessible(true);
                buffer.clear();
            }
        }
    }

    private final void revalidateByteBuffer(ByteBuffer[] buffers, int index) {
        synchronized (this.mBufferLock) {
            if (buffers != null && index >= 0) {
                if (index < buffers.length) {
                    ByteBuffer buffer = buffers[index];
                    if (buffer != null) {
                        buffer.setAccessible(true);
                    }
                }
            }
        }
    }

    private final void validateOutputByteBuffer(ByteBuffer[] buffers, int index, BufferInfo info) {
        if (buffers != null && index >= 0 && index < buffers.length) {
            ByteBuffer buffer = buffers[index];
            if (buffer != null) {
                buffer.setAccessible(true);
                buffer.limit(info.offset + info.size).position(info.offset);
            }
        }
    }

    private final void invalidateByteBuffers(ByteBuffer[] buffers) {
        if (buffers != null) {
            ByteBuffer[] arr$ = buffers;
            int len$ = arr$.length;
            for (int i$ = CRYPTO_MODE_UNENCRYPTED; i$ < len$; i$ += VIDEO_SCALING_MODE_SCALE_TO_FIT) {
                ByteBuffer buffer = arr$[i$];
                if (buffer != null) {
                    buffer.setAccessible(false);
                }
            }
        }
    }

    private final void freeByteBuffer(ByteBuffer buffer) {
        if (buffer != null) {
            NioUtils.freeDirectBuffer(buffer);
        }
    }

    private final void freeByteBuffers(ByteBuffer[] buffers) {
        if (buffers != null) {
            ByteBuffer[] arr$ = buffers;
            int len$ = arr$.length;
            for (int i$ = CRYPTO_MODE_UNENCRYPTED; i$ < len$; i$ += VIDEO_SCALING_MODE_SCALE_TO_FIT) {
                freeByteBuffer(arr$[i$]);
            }
        }
    }

    private final void freeAllTrackedBuffers() {
        synchronized (this.mBufferLock) {
            freeByteBuffers(this.mCachedInputBuffers);
            freeByteBuffers(this.mCachedOutputBuffers);
            this.mCachedInputBuffers = null;
            this.mCachedOutputBuffers = null;
            this.mDequeuedInputBuffers.clear();
            this.mDequeuedOutputBuffers.clear();
        }
    }

    private final void cacheBuffers(boolean input) {
        ByteBuffer[] byteBufferArr = null;
        try {
            byteBufferArr = getBuffers(input);
            invalidateByteBuffers(byteBufferArr);
        } catch (IllegalStateException e) {
        }
        if (input) {
            this.mCachedInputBuffers = byteBufferArr;
        } else {
            this.mCachedOutputBuffers = byteBufferArr;
        }
    }

    public ByteBuffer[] getInputBuffers() {
        if (this.mCachedInputBuffers != null) {
            return this.mCachedInputBuffers;
        }
        throw new IllegalStateException();
    }

    public ByteBuffer[] getOutputBuffers() {
        if (this.mCachedOutputBuffers != null) {
            return this.mCachedOutputBuffers;
        }
        throw new IllegalStateException();
    }

    public ByteBuffer getInputBuffer(int index) {
        ByteBuffer newBuffer = getBuffer(true, index);
        synchronized (this.mBufferLock) {
            invalidateByteBuffer(this.mCachedInputBuffers, index);
            this.mDequeuedInputBuffers.put(index, newBuffer);
        }
        return newBuffer;
    }

    public Image getInputImage(int index) {
        Image newImage = getImage(true, index);
        synchronized (this.mBufferLock) {
            invalidateByteBuffer(this.mCachedInputBuffers, index);
            this.mDequeuedInputBuffers.put(index, newImage);
        }
        return newImage;
    }

    public ByteBuffer getOutputBuffer(int index) {
        ByteBuffer newBuffer = getBuffer(false, index);
        synchronized (this.mBufferLock) {
            invalidateByteBuffer(this.mCachedOutputBuffers, index);
            this.mDequeuedOutputBuffers.put(index, newBuffer);
        }
        return newBuffer;
    }

    public Image getOutputImage(int index) {
        Image newImage = getImage(false, index);
        synchronized (this.mBufferLock) {
            invalidateByteBuffer(this.mCachedOutputBuffers, index);
            this.mDequeuedOutputBuffers.put(index, newImage);
        }
        return newImage;
    }

    public final void setParameters(Bundle params) {
        if (params != null) {
            String[] keys = new String[params.size()];
            Object[] values = new Object[params.size()];
            int i = CRYPTO_MODE_UNENCRYPTED;
            for (String key : params.keySet()) {
                keys[i] = key;
                values[i] = params.get(key);
                i += VIDEO_SCALING_MODE_SCALE_TO_FIT;
            }
            setParameters(keys, values);
        }
    }

    public void setCallback(Callback cb) {
        if (this.mEventHandler != null) {
            this.mEventHandler.sendMessage(this.mEventHandler.obtainMessage(VIDEO_SCALING_MODE_SCALE_TO_FIT_WITH_CROPPING, CRYPTO_MODE_UNENCRYPTED, CRYPTO_MODE_UNENCRYPTED, cb));
            native_setCallback(cb);
        }
    }

    private void postEventFromNative(int what, int arg1, int arg2, Object obj) {
        if (this.mEventHandler != null) {
            this.mEventHandler.sendMessage(this.mEventHandler.obtainMessage(what, arg1, arg2, obj));
        }
    }

    public MediaCodecInfo getCodecInfo() {
        return MediaCodecList.getInfoFor(getName());
    }

    static {
        System.loadLibrary("media_jni");
        native_init();
    }
}
