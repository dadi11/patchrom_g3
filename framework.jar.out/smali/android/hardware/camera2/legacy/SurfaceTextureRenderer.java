package android.hardware.camera2.legacy;

import android.graphics.ImageFormat;
import android.graphics.Matrix.ScaleToFit;
import android.graphics.RectF;
import android.graphics.SurfaceTexture;
import android.hardware.camera2.legacy.LegacyExceptionUtils.BufferQueueAbandonedException;
import android.opengl.EGL14;
import android.opengl.EGLConfig;
import android.opengl.EGLContext;
import android.opengl.EGLDisplay;
import android.opengl.EGLSurface;
import android.opengl.GLES11;
import android.opengl.GLES11Ext;
import android.opengl.GLES20;
import android.opengl.Matrix;
import android.os.Environment;
import android.os.SystemProperties;
import android.text.format.Time;
import android.util.Log;
import android.util.Pair;
import android.util.Size;
import android.view.Surface;
import android.view.WindowManager.LayoutParams;
import java.io.File;
import java.nio.Buffer;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class SurfaceTextureRenderer {
    private static final boolean DEBUG;
    private static final int EGL_COLOR_BITLENGTH = 8;
    private static final int EGL_RECORDABLE_ANDROID = 12610;
    private static final int FLIP_TYPE_BOTH = 3;
    private static final int FLIP_TYPE_HORIZONTAL = 1;
    private static final int FLIP_TYPE_NONE = 0;
    private static final int FLIP_TYPE_VERTICAL = 2;
    private static final int FLOAT_SIZE_BYTES = 4;
    private static final String FRAGMENT_SHADER = "#extension GL_OES_EGL_image_external : require\nprecision mediump float;\nvarying vec2 vTextureCoord;\nuniform samplerExternalOES sTexture;\nvoid main() {\n  gl_FragColor = texture2D(sTexture, vTextureCoord);\n}\n";
    private static final int GLES_VERSION = 2;
    private static final int GL_MATRIX_SIZE = 16;
    private static final String LEGACY_PERF_PROPERTY = "persist.camera.legacy_perf";
    private static final int PBUFFER_PIXEL_BYTES = 4;
    private static final String TAG;
    private static final int TRIANGLE_VERTICES_DATA_POS_OFFSET = 0;
    private static final int TRIANGLE_VERTICES_DATA_STRIDE_BYTES = 20;
    private static final int TRIANGLE_VERTICES_DATA_UV_OFFSET = 3;
    private static final int VERTEX_POS_SIZE = 3;
    private static final String VERTEX_SHADER = "uniform mat4 uMVPMatrix;\nuniform mat4 uSTMatrix;\nattribute vec4 aPosition;\nattribute vec4 aTextureCoord;\nvarying vec2 vTextureCoord;\nvoid main() {\n  gl_Position = uMVPMatrix * aPosition;\n  vTextureCoord = (uSTMatrix * aTextureCoord).xy;\n}\n";
    private static final int VERTEX_UV_SIZE = 2;
    private static final float[] sBothFlipTriangleVertices;
    private static final float[] sHorizontalFlipTriangleVertices;
    private static final float[] sRegularTriangleVertices;
    private static final float[] sVerticalFlipTriangleVertices;
    private FloatBuffer mBothFlipTriangleVertices;
    private EGLConfig mConfigs;
    private List<EGLSurfaceHolder> mConversionSurfaces;
    private EGLContext mEGLContext;
    private EGLDisplay mEGLDisplay;
    private final int mFacing;
    private FloatBuffer mHorizontalFlipTriangleVertices;
    private float[] mMVPMatrix;
    private ByteBuffer mPBufferPixels;
    private PerfMeasurement mPerfMeasurer;
    private int mProgram;
    private FloatBuffer mRegularTriangleVertices;
    private float[] mSTMatrix;
    private volatile SurfaceTexture mSurfaceTexture;
    private List<EGLSurfaceHolder> mSurfaces;
    private int mTextureID;
    private FloatBuffer mVerticalFlipTriangleVertices;
    private int maPositionHandle;
    private int maTextureHandle;
    private int muMVPMatrixHandle;
    private int muSTMatrixHandle;

    private class EGLSurfaceHolder {
        EGLSurface eglSurface;
        int height;
        Surface surface;
        int width;

        private EGLSurfaceHolder() {
        }
    }

    static {
        TAG = SurfaceTextureRenderer.class.getSimpleName();
        DEBUG = Log.isLoggable(LegacyCameraDevice.DEBUG_PROP, VERTEX_POS_SIZE);
        sHorizontalFlipTriangleVertices = new float[]{LayoutParams.BRIGHTNESS_OVERRIDE_NONE, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, 0.0f, 0.0f, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL};
        sVerticalFlipTriangleVertices = new float[]{LayoutParams.BRIGHTNESS_OVERRIDE_NONE, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, 0.0f, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, 0.0f, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f};
        sBothFlipTriangleVertices = new float[]{LayoutParams.BRIGHTNESS_OVERRIDE_NONE, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, 0.0f, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, 0.0f, 0.0f};
        sRegularTriangleVertices = new float[]{LayoutParams.BRIGHTNESS_OVERRIDE_NONE, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, 0.0f, 0.0f, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_NONE, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL};
    }

    public SurfaceTextureRenderer(int facing) {
        this.mEGLDisplay = EGL14.EGL_NO_DISPLAY;
        this.mEGLContext = EGL14.EGL_NO_CONTEXT;
        this.mSurfaces = new ArrayList();
        this.mConversionSurfaces = new ArrayList();
        this.mMVPMatrix = new float[GL_MATRIX_SIZE];
        this.mSTMatrix = new float[GL_MATRIX_SIZE];
        this.mTextureID = TRIANGLE_VERTICES_DATA_POS_OFFSET;
        this.mPerfMeasurer = null;
        this.mFacing = facing;
        this.mRegularTriangleVertices = ByteBuffer.allocateDirect(sRegularTriangleVertices.length * PBUFFER_PIXEL_BYTES).order(ByteOrder.nativeOrder()).asFloatBuffer();
        this.mRegularTriangleVertices.put(sRegularTriangleVertices).position(TRIANGLE_VERTICES_DATA_POS_OFFSET);
        this.mHorizontalFlipTriangleVertices = ByteBuffer.allocateDirect(sHorizontalFlipTriangleVertices.length * PBUFFER_PIXEL_BYTES).order(ByteOrder.nativeOrder()).asFloatBuffer();
        this.mHorizontalFlipTriangleVertices.put(sHorizontalFlipTriangleVertices).position(TRIANGLE_VERTICES_DATA_POS_OFFSET);
        this.mVerticalFlipTriangleVertices = ByteBuffer.allocateDirect(sVerticalFlipTriangleVertices.length * PBUFFER_PIXEL_BYTES).order(ByteOrder.nativeOrder()).asFloatBuffer();
        this.mVerticalFlipTriangleVertices.put(sVerticalFlipTriangleVertices).position(TRIANGLE_VERTICES_DATA_POS_OFFSET);
        this.mBothFlipTriangleVertices = ByteBuffer.allocateDirect(sBothFlipTriangleVertices.length * PBUFFER_PIXEL_BYTES).order(ByteOrder.nativeOrder()).asFloatBuffer();
        this.mBothFlipTriangleVertices.put(sBothFlipTriangleVertices).position(TRIANGLE_VERTICES_DATA_POS_OFFSET);
        Matrix.setIdentityM(this.mSTMatrix, TRIANGLE_VERTICES_DATA_POS_OFFSET);
    }

    private int loadShader(int shaderType, String source) {
        int shader = GLES20.glCreateShader(shaderType);
        checkGlError("glCreateShader type=" + shaderType);
        GLES20.glShaderSource(shader, source);
        GLES20.glCompileShader(shader);
        int[] compiled = new int[FLIP_TYPE_HORIZONTAL];
        GLES20.glGetShaderiv(shader, GLES20.GL_COMPILE_STATUS, compiled, TRIANGLE_VERTICES_DATA_POS_OFFSET);
        if (compiled[TRIANGLE_VERTICES_DATA_POS_OFFSET] != 0) {
            return shader;
        }
        Log.e(TAG, "Could not compile shader " + shaderType + ":");
        Log.e(TAG, " " + GLES20.glGetShaderInfoLog(shader));
        GLES20.glDeleteShader(shader);
        throw new IllegalStateException("Could not compile shader " + shaderType);
    }

    private int createProgram(String vertexSource, String fragmentSource) {
        int vertexShader = loadShader(GLES20.GL_VERTEX_SHADER, vertexSource);
        if (vertexShader == 0) {
            return TRIANGLE_VERTICES_DATA_POS_OFFSET;
        }
        int pixelShader = loadShader(GLES20.GL_FRAGMENT_SHADER, fragmentSource);
        if (pixelShader == 0) {
            return TRIANGLE_VERTICES_DATA_POS_OFFSET;
        }
        int program = GLES20.glCreateProgram();
        checkGlError("glCreateProgram");
        if (program == 0) {
            Log.e(TAG, "Could not create program");
        }
        GLES20.glAttachShader(program, vertexShader);
        checkGlError("glAttachShader");
        GLES20.glAttachShader(program, pixelShader);
        checkGlError("glAttachShader");
        GLES20.glLinkProgram(program);
        int[] linkStatus = new int[FLIP_TYPE_HORIZONTAL];
        GLES20.glGetProgramiv(program, GLES20.GL_LINK_STATUS, linkStatus, TRIANGLE_VERTICES_DATA_POS_OFFSET);
        if (linkStatus[TRIANGLE_VERTICES_DATA_POS_OFFSET] == FLIP_TYPE_HORIZONTAL) {
            return program;
        }
        Log.e(TAG, "Could not link program: ");
        Log.e(TAG, GLES20.glGetProgramInfoLog(program));
        GLES20.glDeleteProgram(program);
        throw new IllegalStateException("Could not link program");
    }

    private void drawFrame(SurfaceTexture st, int width, int height, int flipType) {
        checkGlError("onDrawFrame start");
        st.getTransformMatrix(this.mSTMatrix);
        Matrix.setIdentityM(this.mMVPMatrix, TRIANGLE_VERTICES_DATA_POS_OFFSET);
        try {
            Size dimens = LegacyCameraDevice.getTextureSize(st);
            float texWidth = (float) dimens.getWidth();
            float texHeight = (float) dimens.getHeight();
            if (texWidth <= 0.0f || texHeight <= 0.0f) {
                throw new IllegalStateException("Illegal intermediate texture with dimension of 0");
            }
            Buffer triangleVertices;
            RectF intermediate = new RectF(0.0f, 0.0f, texWidth, texHeight);
            RectF output = new RectF(0.0f, 0.0f, (float) width, (float) height);
            android.graphics.Matrix boxingXform = new android.graphics.Matrix();
            boxingXform.setRectToRect(output, intermediate, ScaleToFit.CENTER);
            boxingXform.mapRect(output);
            float scaleX = intermediate.width() / output.width();
            float scaleY = intermediate.height() / output.height();
            Matrix.scaleM(this.mMVPMatrix, TRIANGLE_VERTICES_DATA_POS_OFFSET, scaleX, scaleY, LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
            if (DEBUG) {
                Log.d(TAG, "Scaling factors (S_x = " + scaleX + ",S_y = " + scaleY + ") used for " + width + "x" + height + " surface, intermediate buffer size is " + texWidth + "x" + texHeight);
            }
            GLES20.glViewport(TRIANGLE_VERTICES_DATA_POS_OFFSET, TRIANGLE_VERTICES_DATA_POS_OFFSET, width, height);
            if (DEBUG) {
                GLES20.glClearColor(LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
                GLES20.glClear(16640);
            }
            GLES20.glUseProgram(this.mProgram);
            checkGlError("glUseProgram");
            GLES20.glActiveTexture(GLES20.GL_TEXTURE0);
            GLES20.glBindTexture(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, this.mTextureID);
            switch (flipType) {
                case FLIP_TYPE_HORIZONTAL /*1*/:
                    triangleVertices = this.mHorizontalFlipTriangleVertices;
                    break;
                case VERTEX_UV_SIZE /*2*/:
                    triangleVertices = this.mVerticalFlipTriangleVertices;
                    break;
                case VERTEX_POS_SIZE /*3*/:
                    triangleVertices = this.mBothFlipTriangleVertices;
                    break;
                default:
                    triangleVertices = this.mRegularTriangleVertices;
                    break;
            }
            triangleVertices.position(TRIANGLE_VERTICES_DATA_POS_OFFSET);
            GLES20.glVertexAttribPointer(this.maPositionHandle, (int) VERTEX_POS_SIZE, (int) GLES20.GL_FLOAT, (boolean) DEBUG, (int) TRIANGLE_VERTICES_DATA_STRIDE_BYTES, triangleVertices);
            checkGlError("glVertexAttribPointer maPosition");
            GLES20.glEnableVertexAttribArray(this.maPositionHandle);
            checkGlError("glEnableVertexAttribArray maPositionHandle");
            triangleVertices.position(VERTEX_POS_SIZE);
            GLES20.glVertexAttribPointer(this.maTextureHandle, (int) VERTEX_UV_SIZE, (int) GLES20.GL_FLOAT, (boolean) DEBUG, (int) TRIANGLE_VERTICES_DATA_STRIDE_BYTES, triangleVertices);
            checkGlError("glVertexAttribPointer maTextureHandle");
            GLES20.glEnableVertexAttribArray(this.maTextureHandle);
            checkGlError("glEnableVertexAttribArray maTextureHandle");
            GLES20.glUniformMatrix4fv(this.muMVPMatrixHandle, FLIP_TYPE_HORIZONTAL, DEBUG, this.mMVPMatrix, TRIANGLE_VERTICES_DATA_POS_OFFSET);
            GLES20.glUniformMatrix4fv(this.muSTMatrixHandle, FLIP_TYPE_HORIZONTAL, DEBUG, this.mSTMatrix, TRIANGLE_VERTICES_DATA_POS_OFFSET);
            GLES20.glDrawArrays(5, TRIANGLE_VERTICES_DATA_POS_OFFSET, PBUFFER_PIXEL_BYTES);
            checkGlError("glDrawArrays");
        } catch (BufferQueueAbandonedException e) {
            throw new IllegalStateException("Surface abandoned, skipping drawFrame...", e);
        }
    }

    private void initializeGLState() {
        this.mProgram = createProgram(VERTEX_SHADER, FRAGMENT_SHADER);
        if (this.mProgram == 0) {
            throw new IllegalStateException("failed creating program");
        }
        this.maPositionHandle = GLES20.glGetAttribLocation(this.mProgram, "aPosition");
        checkGlError("glGetAttribLocation aPosition");
        if (this.maPositionHandle == -1) {
            throw new IllegalStateException("Could not get attrib location for aPosition");
        }
        this.maTextureHandle = GLES20.glGetAttribLocation(this.mProgram, "aTextureCoord");
        checkGlError("glGetAttribLocation aTextureCoord");
        if (this.maTextureHandle == -1) {
            throw new IllegalStateException("Could not get attrib location for aTextureCoord");
        }
        this.muMVPMatrixHandle = GLES20.glGetUniformLocation(this.mProgram, "uMVPMatrix");
        checkGlError("glGetUniformLocation uMVPMatrix");
        if (this.muMVPMatrixHandle == -1) {
            throw new IllegalStateException("Could not get attrib location for uMVPMatrix");
        }
        this.muSTMatrixHandle = GLES20.glGetUniformLocation(this.mProgram, "uSTMatrix");
        checkGlError("glGetUniformLocation uSTMatrix");
        if (this.muSTMatrixHandle == -1) {
            throw new IllegalStateException("Could not get attrib location for uSTMatrix");
        }
        int[] textures = new int[FLIP_TYPE_HORIZONTAL];
        GLES20.glGenTextures(FLIP_TYPE_HORIZONTAL, textures, TRIANGLE_VERTICES_DATA_POS_OFFSET);
        this.mTextureID = textures[TRIANGLE_VERTICES_DATA_POS_OFFSET];
        GLES20.glBindTexture(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, this.mTextureID);
        checkGlError("glBindTexture mTextureID");
        GLES20.glTexParameterf(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, GLES20.GL_TEXTURE_MIN_FILTER, 9728.0f);
        GLES20.glTexParameterf(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, GLES20.GL_TEXTURE_MAG_FILTER, 9729.0f);
        GLES20.glTexParameteri(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameteri(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE);
        checkGlError("glTexParameter");
    }

    private int getTextureId() {
        return this.mTextureID;
    }

    private void clearState() {
        this.mSurfaces.clear();
        this.mConversionSurfaces.clear();
        this.mPBufferPixels = null;
        if (this.mSurfaceTexture != null) {
            this.mSurfaceTexture.release();
        }
        this.mSurfaceTexture = null;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void configureEGLContext() {
        /*
        r19 = this;
        r2 = 0;
        r2 = android.opengl.EGL14.eglGetDisplay(r2);
        r0 = r19;
        r0.mEGLDisplay = r2;
        r0 = r19;
        r2 = r0.mEGLDisplay;
        r4 = android.opengl.EGL14.EGL_NO_DISPLAY;
        if (r2 != r4) goto L_0x0019;
    L_0x0011:
        r2 = new java.lang.IllegalStateException;
        r4 = "No EGL14 display";
        r2.<init>(r4);
        throw r2;
    L_0x0019:
        r2 = 2;
        r0 = new int[r2];
        r18 = r0;
        r0 = r19;
        r2 = r0.mEGLDisplay;
        r4 = 0;
        r6 = 1;
        r0 = r18;
        r1 = r18;
        r2 = android.opengl.EGL14.eglInitialize(r2, r0, r4, r1, r6);
        if (r2 != 0) goto L_0x0036;
    L_0x002e:
        r2 = new java.lang.IllegalStateException;
        r4 = "Cannot initialize EGL14";
        r2.<init>(r4);
        throw r2;
    L_0x0036:
        r2 = 13;
        r3 = new int[r2];
        r3 = {12324, 8, 12323, 8, 12322, 8, 12352, 4, 12610, 1, 12339, 5, 12344};
        r2 = 1;
        r5 = new android.opengl.EGLConfig[r2];
        r2 = 1;
        r8 = new int[r2];
        r0 = r19;
        r2 = r0.mEGLDisplay;
        r4 = 0;
        r6 = 0;
        r7 = r5.length;
        r9 = 0;
        android.opengl.EGL14.eglChooseConfig(r2, r3, r4, r5, r6, r7, r8, r9);
        r2 = "eglCreateContext RGB888+recordable ES2";
        r0 = r19;
        r0.checkEglError(r2);
        r2 = 0;
        r2 = r8[r2];
        if (r2 != 0) goto L_0x007d;
    L_0x005a:
        r2 = TAG;
        r4 = "eglChooseConfig returned no configs, retrying without EGL_RECORDABLE_ANDROID";
        android.util.Log.w(r2, r4);
        r2 = 11;
        r10 = new int[r2];
        r10 = {12324, 8, 12323, 8, 12322, 8, 12352, 4, 12339, 5, 12344};
        r0 = r19;
        r9 = r0.mEGLDisplay;
        r11 = 0;
        r13 = 0;
        r14 = r5.length;
        r16 = 0;
        r12 = r5;
        r15 = r8;
        android.opengl.EGL14.eglChooseConfig(r9, r10, r11, r12, r13, r14, r15, r16);
        r2 = "eglCreateContext RGB888 ES2";
        r0 = r19;
        r0.checkEglError(r2);
    L_0x007d:
        r2 = 0;
        r2 = r5[r2];
        r0 = r19;
        r0.mConfigs = r2;
        r2 = 3;
        r0 = new int[r2];
        r17 = r0;
        r17 = {12440, 2, 12344};
        r0 = r19;
        r2 = r0.mEGLDisplay;
        r4 = 0;
        r4 = r5[r4];
        r6 = android.opengl.EGL14.EGL_NO_CONTEXT;
        r7 = 0;
        r0 = r17;
        r2 = android.opengl.EGL14.eglCreateContext(r2, r4, r6, r0, r7);
        r0 = r19;
        r0.mEGLContext = r2;
        r2 = "eglCreateContext";
        r0 = r19;
        r0.checkEglError(r2);
        r0 = r19;
        r2 = r0.mEGLContext;
        r4 = android.opengl.EGL14.EGL_NO_CONTEXT;
        if (r2 != r4) goto L_0x00b7;
    L_0x00af:
        r2 = new java.lang.IllegalStateException;
        r4 = "No EGLContext could be made";
        r2.<init>(r4);
        throw r2;
    L_0x00b7:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.hardware.camera2.legacy.SurfaceTextureRenderer.configureEGLContext():void");
    }

    private void configureEGLOutputSurfaces(Collection<EGLSurfaceHolder> surfaces) {
        if (surfaces == null || surfaces.size() == 0) {
            throw new IllegalStateException("No Surfaces were provided to draw to");
        }
        int[] surfaceAttribs = new int[FLIP_TYPE_HORIZONTAL];
        surfaceAttribs[TRIANGLE_VERTICES_DATA_POS_OFFSET] = EGL14.EGL_NONE;
        for (EGLSurfaceHolder holder : surfaces) {
            holder.eglSurface = EGL14.eglCreateWindowSurface(this.mEGLDisplay, this.mConfigs, holder.surface, surfaceAttribs, TRIANGLE_VERTICES_DATA_POS_OFFSET);
            checkEglError("eglCreateWindowSurface");
        }
    }

    private void configureEGLPbufferSurfaces(Collection<EGLSurfaceHolder> surfaces) {
        if (surfaces == null || surfaces.size() == 0) {
            throw new IllegalStateException("No Surfaces were provided to draw to");
        }
        int maxLength = TRIANGLE_VERTICES_DATA_POS_OFFSET;
        for (EGLSurfaceHolder holder : surfaces) {
            int length = holder.width * holder.height;
            if (length > maxLength) {
                maxLength = length;
            }
            holder.eglSurface = EGL14.eglCreatePbufferSurface(this.mEGLDisplay, this.mConfigs, new int[]{EGL14.EGL_WIDTH, holder.width, EGL14.EGL_HEIGHT, holder.height, EGL14.EGL_NONE}, TRIANGLE_VERTICES_DATA_POS_OFFSET);
            checkEglError("eglCreatePbufferSurface");
        }
        this.mPBufferPixels = ByteBuffer.allocateDirect(maxLength * PBUFFER_PIXEL_BYTES).order(ByteOrder.nativeOrder());
    }

    private void releaseEGLContext() {
        if (this.mEGLDisplay != EGL14.EGL_NO_DISPLAY) {
            EGL14.eglMakeCurrent(this.mEGLDisplay, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
            dumpGlTiming();
            if (this.mSurfaces != null) {
                for (EGLSurfaceHolder holder : this.mSurfaces) {
                    if (holder.eglSurface != null) {
                        EGL14.eglDestroySurface(this.mEGLDisplay, holder.eglSurface);
                    }
                }
            }
            if (this.mConversionSurfaces != null) {
                for (EGLSurfaceHolder holder2 : this.mConversionSurfaces) {
                    if (holder2.eglSurface != null) {
                        EGL14.eglDestroySurface(this.mEGLDisplay, holder2.eglSurface);
                    }
                }
            }
            EGL14.eglDestroyContext(this.mEGLDisplay, this.mEGLContext);
            EGL14.eglReleaseThread();
            EGL14.eglTerminate(this.mEGLDisplay);
        }
        this.mConfigs = null;
        this.mEGLDisplay = EGL14.EGL_NO_DISPLAY;
        this.mEGLContext = EGL14.EGL_NO_CONTEXT;
        clearState();
    }

    private void makeCurrent(EGLSurface surface) {
        EGL14.eglMakeCurrent(this.mEGLDisplay, surface, surface, this.mEGLContext);
        checkEglError("makeCurrent");
    }

    private boolean swapBuffers(EGLSurface surface) {
        boolean result = EGL14.eglSwapBuffers(this.mEGLDisplay, surface);
        checkEglError("swapBuffers");
        return result;
    }

    private void checkEglError(String msg) {
        int error = EGL14.eglGetError();
        if (error != GLES11.GL_CLIP_PLANE0) {
            throw new IllegalStateException(msg + ": EGL error: 0x" + Integer.toHexString(error));
        }
    }

    private void checkGlError(String msg) {
        int error = GLES20.glGetError();
        if (error != 0) {
            throw new IllegalStateException(msg + ": GLES20 error: 0x" + Integer.toHexString(error));
        }
    }

    private void dumpGlTiming() {
        if (this.mPerfMeasurer != null) {
            File legacyStorageDir = new File(Environment.getExternalStorageDirectory(), "CameraLegacy");
            if (legacyStorageDir.exists() || legacyStorageDir.mkdirs()) {
                Object[] objArr;
                StringBuilder path = new StringBuilder(legacyStorageDir.getPath());
                path.append(File.separator);
                path.append("durations_");
                Time now = new Time();
                now.setToNow();
                path.append(now.format2445());
                path.append("_S");
                for (EGLSurfaceHolder surface : this.mSurfaces) {
                    objArr = new Object[VERTEX_UV_SIZE];
                    objArr[TRIANGLE_VERTICES_DATA_POS_OFFSET] = Integer.valueOf(surface.width);
                    objArr[FLIP_TYPE_HORIZONTAL] = Integer.valueOf(surface.height);
                    path.append(String.format("_%d_%d", objArr));
                }
                path.append("_C");
                for (EGLSurfaceHolder surface2 : this.mConversionSurfaces) {
                    objArr = new Object[VERTEX_UV_SIZE];
                    objArr[TRIANGLE_VERTICES_DATA_POS_OFFSET] = Integer.valueOf(surface2.width);
                    objArr[FLIP_TYPE_HORIZONTAL] = Integer.valueOf(surface2.height);
                    path.append(String.format("_%d_%d", objArr));
                }
                path.append(".txt");
                this.mPerfMeasurer.dumpPerformanceData(path.toString());
                return;
            }
            Log.e(TAG, "Failed to create directory for data dump");
        }
    }

    private void setupGlTiming() {
        if (PerfMeasurement.isGlTimingSupported()) {
            Log.d(TAG, "Enabling GL performance measurement");
            this.mPerfMeasurer = new PerfMeasurement();
            return;
        }
        Log.d(TAG, "GL performance measurement not supported on this device");
        this.mPerfMeasurer = null;
    }

    private void beginGlTiming() {
        if (this.mPerfMeasurer != null) {
            this.mPerfMeasurer.startTimer();
        }
    }

    private void addGlTimestamp(long timestamp) {
        if (this.mPerfMeasurer != null) {
            this.mPerfMeasurer.addTimestamp(timestamp);
        }
    }

    private void endGlTiming() {
        if (this.mPerfMeasurer != null) {
            this.mPerfMeasurer.stopTimer();
        }
    }

    public SurfaceTexture getSurfaceTexture() {
        return this.mSurfaceTexture;
    }

    public void configureSurfaces(Collection<Pair<Surface, Size>> surfaces) {
        releaseEGLContext();
        if (surfaces == null || surfaces.size() == 0) {
            Log.w(TAG, "No output surfaces configured for GL drawing.");
            return;
        }
        for (Pair<Surface, Size> p : surfaces) {
            Surface s = p.first;
            Size surfaceSize = p.second;
            try {
                EGLSurfaceHolder holder = new EGLSurfaceHolder();
                holder.surface = s;
                holder.width = surfaceSize.getWidth();
                holder.height = surfaceSize.getHeight();
                if (LegacyCameraDevice.needsConversion(s)) {
                    LegacyCameraDevice.setSurfaceFormat(s, ImageFormat.YV12);
                    this.mConversionSurfaces.add(holder);
                } else {
                    this.mSurfaces.add(holder);
                }
            } catch (BufferQueueAbandonedException e) {
                Log.w(TAG, "Surface abandoned, skipping configuration... ", e);
            }
        }
        configureEGLContext();
        if (this.mSurfaces.size() > 0) {
            configureEGLOutputSurfaces(this.mSurfaces);
        }
        if (this.mConversionSurfaces.size() > 0) {
            configureEGLPbufferSurfaces(this.mConversionSurfaces);
        }
        makeCurrent(this.mSurfaces.size() > 0 ? ((EGLSurfaceHolder) this.mSurfaces.get(TRIANGLE_VERTICES_DATA_POS_OFFSET)).eglSurface : ((EGLSurfaceHolder) this.mConversionSurfaces.get(TRIANGLE_VERTICES_DATA_POS_OFFSET)).eglSurface);
        initializeGLState();
        this.mSurfaceTexture = new SurfaceTexture(getTextureId());
        if (SystemProperties.getBoolean(LEGACY_PERF_PROPERTY, DEBUG)) {
            setupGlTiming();
        }
    }

    public void drawIntoSurfaces(CaptureCollector targetCollector) {
        if ((this.mSurfaces != null && this.mSurfaces.size() != 0) || (this.mConversionSurfaces != null && this.mConversionSurfaces.size() != 0)) {
            boolean doTiming = targetCollector.hasPendingPreviewCaptures();
            checkGlError("before updateTexImage");
            if (doTiming) {
                beginGlTiming();
            }
            this.mSurfaceTexture.updateTexImage();
            long timestamp = this.mSurfaceTexture.getTimestamp();
            Pair<RequestHolder, Long> captureHolder = targetCollector.previewCaptured(timestamp);
            if (captureHolder == null) {
                if (DEBUG) {
                    Log.d(TAG, "Dropping preview frame.");
                }
                if (doTiming) {
                    endGlTiming();
                    return;
                }
                return;
            }
            Collection<Surface> targetSurfaces = captureHolder.first.getHolderTargets();
            if (doTiming) {
                addGlTimestamp(timestamp);
            }
            List<Long> targetSurfaceIds = LegacyCameraDevice.getSurfaceIds(targetSurfaces);
            for (EGLSurfaceHolder holder : this.mSurfaces) {
                if (LegacyCameraDevice.containsSurfaceId(holder.surface, targetSurfaceIds)) {
                    try {
                        LegacyCameraDevice.setSurfaceDimens(holder.surface, holder.width, holder.height);
                        makeCurrent(holder.eglSurface);
                        LegacyCameraDevice.setNextTimestamp(holder.surface, ((Long) captureHolder.second).longValue());
                        drawFrame(this.mSurfaceTexture, holder.width, holder.height, this.mFacing == 0 ? FLIP_TYPE_HORIZONTAL : TRIANGLE_VERTICES_DATA_POS_OFFSET);
                        swapBuffers(holder.eglSurface);
                    } catch (BufferQueueAbandonedException e) {
                        Log.w(TAG, "Surface abandoned, dropping frame. ", e);
                    }
                }
            }
            for (EGLSurfaceHolder holder2 : this.mConversionSurfaces) {
                if (LegacyCameraDevice.containsSurfaceId(holder2.surface, targetSurfaceIds)) {
                    makeCurrent(holder2.eglSurface);
                    drawFrame(this.mSurfaceTexture, holder2.width, holder2.height, this.mFacing == 0 ? VERTEX_POS_SIZE : VERTEX_UV_SIZE);
                    this.mPBufferPixels.clear();
                    GLES20.glReadPixels(TRIANGLE_VERTICES_DATA_POS_OFFSET, TRIANGLE_VERTICES_DATA_POS_OFFSET, holder2.width, holder2.height, GLES20.GL_RGBA, GLES20.GL_UNSIGNED_BYTE, this.mPBufferPixels);
                    checkGlError("glReadPixels");
                    try {
                        int format = LegacyCameraDevice.detectSurfaceType(holder2.surface);
                        LegacyCameraDevice.setSurfaceDimens(holder2.surface, holder2.width, holder2.height);
                        LegacyCameraDevice.setNextTimestamp(holder2.surface, ((Long) captureHolder.second).longValue());
                        LegacyCameraDevice.produceFrame(holder2.surface, this.mPBufferPixels.array(), holder2.width, holder2.height, format);
                    } catch (BufferQueueAbandonedException e2) {
                        Log.w(TAG, "Surface abandoned, dropping frame. ", e2);
                    }
                }
            }
            targetCollector.previewProduced();
            if (doTiming) {
                endGlTiming();
            }
        }
    }

    public void cleanupEGLContext() {
        releaseEGLContext();
    }

    public void flush() {
        Log.e(TAG, "Flush not yet implemented.");
    }
}
