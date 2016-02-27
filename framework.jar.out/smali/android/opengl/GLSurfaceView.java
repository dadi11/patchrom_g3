package android.opengl;

import android.content.Context;
import android.os.SystemProperties;
import android.util.AttributeSet;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceHolder.Callback;
import android.view.SurfaceView;
import java.io.Writer;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.egl.EGLContext;
import javax.microedition.khronos.egl.EGLDisplay;
import javax.microedition.khronos.egl.EGLSurface;
import javax.microedition.khronos.opengles.GL;
import javax.microedition.khronos.opengles.GL10;

public class GLSurfaceView extends SurfaceView implements Callback {
    public static final int DEBUG_CHECK_GL_ERROR = 1;
    public static final int DEBUG_LOG_GL_CALLS = 2;
    private static final boolean LOG_ATTACH_DETACH = false;
    private static final boolean LOG_EGL = false;
    private static final boolean LOG_PAUSE_RESUME = false;
    private static final boolean LOG_RENDERER = false;
    private static final boolean LOG_RENDERER_DRAW_FRAME = false;
    private static final boolean LOG_SURFACE = false;
    private static final boolean LOG_THREADS = false;
    public static final int RENDERMODE_CONTINUOUSLY = 1;
    public static final int RENDERMODE_WHEN_DIRTY = 0;
    private static final String TAG = "GLSurfaceView";
    private static final GLThreadManager sGLThreadManager;
    private int mDebugFlags;
    private boolean mDetached;
    private EGLConfigChooser mEGLConfigChooser;
    private int mEGLContextClientVersion;
    private EGLContextFactory mEGLContextFactory;
    private EGLWindowSurfaceFactory mEGLWindowSurfaceFactory;
    private GLThread mGLThread;
    private GLWrapper mGLWrapper;
    private boolean mPreserveEGLContextOnPause;
    private Renderer mRenderer;
    private final WeakReference<GLSurfaceView> mThisWeakRef;

    public interface EGLConfigChooser {
        EGLConfig chooseConfig(EGL10 egl10, EGLDisplay eGLDisplay);
    }

    private abstract class BaseConfigChooser implements EGLConfigChooser {
        protected int[] mConfigSpec;

        abstract EGLConfig chooseConfig(EGL10 egl10, EGLDisplay eGLDisplay, EGLConfig[] eGLConfigArr);

        public BaseConfigChooser(int[] configSpec) {
            this.mConfigSpec = filterConfigSpec(configSpec);
        }

        public EGLConfig chooseConfig(EGL10 egl, EGLDisplay display) {
            int[] num_config = new int[GLSurfaceView.RENDERMODE_CONTINUOUSLY];
            if (egl.eglChooseConfig(display, this.mConfigSpec, null, GLSurfaceView.RENDERMODE_WHEN_DIRTY, num_config)) {
                int numConfigs = num_config[GLSurfaceView.RENDERMODE_WHEN_DIRTY];
                if (numConfigs <= 0) {
                    throw new IllegalArgumentException("No configs match configSpec");
                }
                EGLConfig[] configs = new EGLConfig[numConfigs];
                if (egl.eglChooseConfig(display, this.mConfigSpec, configs, numConfigs, num_config)) {
                    EGLConfig config = chooseConfig(egl, display, configs);
                    if (config != null) {
                        return config;
                    }
                    throw new IllegalArgumentException("No config chosen");
                }
                throw new IllegalArgumentException("eglChooseConfig#2 failed");
            }
            throw new IllegalArgumentException("eglChooseConfig failed");
        }

        private int[] filterConfigSpec(int[] configSpec) {
            if (GLSurfaceView.this.mEGLContextClientVersion != GLSurfaceView.DEBUG_LOG_GL_CALLS && GLSurfaceView.this.mEGLContextClientVersion != 3) {
                return configSpec;
            }
            int len = configSpec.length;
            int[] newConfigSpec = new int[(len + GLSurfaceView.DEBUG_LOG_GL_CALLS)];
            System.arraycopy(configSpec, GLSurfaceView.RENDERMODE_WHEN_DIRTY, newConfigSpec, GLSurfaceView.RENDERMODE_WHEN_DIRTY, len - 1);
            newConfigSpec[len - 1] = EGL14.EGL_RENDERABLE_TYPE;
            if (GLSurfaceView.this.mEGLContextClientVersion == GLSurfaceView.DEBUG_LOG_GL_CALLS) {
                newConfigSpec[len] = 4;
            } else {
                newConfigSpec[len] = 64;
            }
            newConfigSpec[len + GLSurfaceView.RENDERMODE_CONTINUOUSLY] = EGL14.EGL_NONE;
            return newConfigSpec;
        }
    }

    private class ComponentSizeChooser extends BaseConfigChooser {
        protected int mAlphaSize;
        protected int mBlueSize;
        protected int mDepthSize;
        protected int mGreenSize;
        protected int mRedSize;
        protected int mStencilSize;
        private int[] mValue;

        public ComponentSizeChooser(int redSize, int greenSize, int blueSize, int alphaSize, int depthSize, int stencilSize) {
            super(new int[]{EGL14.EGL_RED_SIZE, redSize, EGL14.EGL_GREEN_SIZE, greenSize, EGL14.EGL_BLUE_SIZE, blueSize, EGL14.EGL_ALPHA_SIZE, alphaSize, EGL14.EGL_DEPTH_SIZE, depthSize, EGL14.EGL_STENCIL_SIZE, stencilSize, EGL14.EGL_NONE});
            this.mValue = new int[GLSurfaceView.RENDERMODE_CONTINUOUSLY];
            this.mRedSize = redSize;
            this.mGreenSize = greenSize;
            this.mBlueSize = blueSize;
            this.mAlphaSize = alphaSize;
            this.mDepthSize = depthSize;
            this.mStencilSize = stencilSize;
        }

        public EGLConfig chooseConfig(EGL10 egl, EGLDisplay display, EGLConfig[] configs) {
            EGLConfig[] arr$ = configs;
            int len$ = arr$.length;
            for (int i$ = GLSurfaceView.RENDERMODE_WHEN_DIRTY; i$ < len$; i$ += GLSurfaceView.RENDERMODE_CONTINUOUSLY) {
                EGLConfig config = arr$[i$];
                int d = findConfigAttrib(egl, display, config, EGL14.EGL_DEPTH_SIZE, GLSurfaceView.RENDERMODE_WHEN_DIRTY);
                int s = findConfigAttrib(egl, display, config, EGL14.EGL_STENCIL_SIZE, GLSurfaceView.RENDERMODE_WHEN_DIRTY);
                if (d >= this.mDepthSize && s >= this.mStencilSize) {
                    int r = findConfigAttrib(egl, display, config, EGL14.EGL_RED_SIZE, GLSurfaceView.RENDERMODE_WHEN_DIRTY);
                    int g = findConfigAttrib(egl, display, config, EGL14.EGL_GREEN_SIZE, GLSurfaceView.RENDERMODE_WHEN_DIRTY);
                    int b = findConfigAttrib(egl, display, config, EGL14.EGL_BLUE_SIZE, GLSurfaceView.RENDERMODE_WHEN_DIRTY);
                    int a = findConfigAttrib(egl, display, config, EGL14.EGL_ALPHA_SIZE, GLSurfaceView.RENDERMODE_WHEN_DIRTY);
                    if (r == this.mRedSize && g == this.mGreenSize && b == this.mBlueSize && a == this.mAlphaSize) {
                        return config;
                    }
                }
            }
            return null;
        }

        private int findConfigAttrib(EGL10 egl, EGLDisplay display, EGLConfig config, int attribute, int defaultValue) {
            if (egl.eglGetConfigAttrib(display, config, attribute, this.mValue)) {
                return this.mValue[GLSurfaceView.RENDERMODE_WHEN_DIRTY];
            }
            return defaultValue;
        }
    }

    public interface EGLContextFactory {
        EGLContext createContext(EGL10 egl10, EGLDisplay eGLDisplay, EGLConfig eGLConfig);

        void destroyContext(EGL10 egl10, EGLDisplay eGLDisplay, EGLContext eGLContext);
    }

    private class DefaultContextFactory implements EGLContextFactory {
        private int EGL_CONTEXT_CLIENT_VERSION;

        private DefaultContextFactory() {
            this.EGL_CONTEXT_CLIENT_VERSION = EGLExt.EGL_CONTEXT_MAJOR_VERSION_KHR;
        }

        public EGLContext createContext(EGL10 egl, EGLDisplay display, EGLConfig config) {
            int[] attrib_list = new int[]{this.EGL_CONTEXT_CLIENT_VERSION, GLSurfaceView.this.mEGLContextClientVersion, EGL14.EGL_NONE};
            EGLContext eGLContext = EGL10.EGL_NO_CONTEXT;
            if (GLSurfaceView.this.mEGLContextClientVersion == 0) {
                attrib_list = null;
            }
            return egl.eglCreateContext(display, config, eGLContext, attrib_list);
        }

        public void destroyContext(EGL10 egl, EGLDisplay display, EGLContext context) {
            if (!egl.eglDestroyContext(display, context)) {
                Log.e("DefaultContextFactory", "display:" + display + " context: " + context);
                EglHelper.throwEglException("eglDestroyContex", egl.eglGetError());
            }
        }
    }

    public interface EGLWindowSurfaceFactory {
        EGLSurface createWindowSurface(EGL10 egl10, EGLDisplay eGLDisplay, EGLConfig eGLConfig, Object obj);

        void destroySurface(EGL10 egl10, EGLDisplay eGLDisplay, EGLSurface eGLSurface);
    }

    private static class DefaultWindowSurfaceFactory implements EGLWindowSurfaceFactory {
        private DefaultWindowSurfaceFactory() {
        }

        public EGLSurface createWindowSurface(EGL10 egl, EGLDisplay display, EGLConfig config, Object nativeWindow) {
            EGLSurface result = null;
            try {
                result = egl.eglCreateWindowSurface(display, config, nativeWindow, null);
            } catch (IllegalArgumentException e) {
                Log.e(GLSurfaceView.TAG, "eglCreateWindowSurface", e);
            }
            return result;
        }

        public void destroySurface(EGL10 egl, EGLDisplay display, EGLSurface surface) {
            egl.eglDestroySurface(display, surface);
        }
    }

    private static class EglHelper {
        EGL10 mEgl;
        EGLConfig mEglConfig;
        EGLContext mEglContext;
        EGLDisplay mEglDisplay;
        EGLSurface mEglSurface;
        private WeakReference<GLSurfaceView> mGLSurfaceViewWeakRef;

        public EglHelper(WeakReference<GLSurfaceView> glSurfaceViewWeakRef) {
            this.mGLSurfaceViewWeakRef = glSurfaceViewWeakRef;
        }

        public void start() {
            this.mEgl = (EGL10) EGLContext.getEGL();
            this.mEglDisplay = this.mEgl.eglGetDisplay(EGL10.EGL_DEFAULT_DISPLAY);
            if (this.mEglDisplay == EGL10.EGL_NO_DISPLAY) {
                throw new RuntimeException("eglGetDisplay failed");
            }
            if (this.mEgl.eglInitialize(this.mEglDisplay, new int[GLSurfaceView.DEBUG_LOG_GL_CALLS])) {
                GLSurfaceView view = (GLSurfaceView) this.mGLSurfaceViewWeakRef.get();
                if (view == null) {
                    this.mEglConfig = null;
                    this.mEglContext = null;
                } else {
                    this.mEglConfig = view.mEGLConfigChooser.chooseConfig(this.mEgl, this.mEglDisplay);
                    this.mEglContext = view.mEGLContextFactory.createContext(this.mEgl, this.mEglDisplay, this.mEglConfig);
                }
                if (this.mEglContext == null || this.mEglContext == EGL10.EGL_NO_CONTEXT) {
                    this.mEglContext = null;
                    throwEglException("createContext");
                }
                this.mEglSurface = null;
                return;
            }
            throw new RuntimeException("eglInitialize failed");
        }

        public boolean createSurface() {
            if (this.mEgl == null) {
                throw new RuntimeException("egl not initialized");
            } else if (this.mEglDisplay == null) {
                throw new RuntimeException("eglDisplay not initialized");
            } else if (this.mEglConfig == null) {
                throw new RuntimeException("mEglConfig not initialized");
            } else {
                destroySurfaceImp();
                GLSurfaceView view = (GLSurfaceView) this.mGLSurfaceViewWeakRef.get();
                if (view != null) {
                    this.mEglSurface = view.mEGLWindowSurfaceFactory.createWindowSurface(this.mEgl, this.mEglDisplay, this.mEglConfig, view.getHolder());
                } else {
                    this.mEglSurface = null;
                }
                if (this.mEglSurface == null || this.mEglSurface == EGL10.EGL_NO_SURFACE) {
                    if (this.mEgl.eglGetError() != EGL14.EGL_BAD_NATIVE_WINDOW) {
                        return GLSurfaceView.LOG_THREADS;
                    }
                    Log.e("EglHelper", "createWindowSurface returned EGL_BAD_NATIVE_WINDOW.");
                    return GLSurfaceView.LOG_THREADS;
                } else if (this.mEgl.eglMakeCurrent(this.mEglDisplay, this.mEglSurface, this.mEglSurface, this.mEglContext)) {
                    return true;
                } else {
                    logEglErrorAsWarning("EGLHelper", "eglMakeCurrent", this.mEgl.eglGetError());
                    return GLSurfaceView.LOG_THREADS;
                }
            }
        }

        GL createGL() {
            GL gl = this.mEglContext.getGL();
            GLSurfaceView view = (GLSurfaceView) this.mGLSurfaceViewWeakRef.get();
            if (view == null) {
                return gl;
            }
            if (view.mGLWrapper != null) {
                gl = view.mGLWrapper.wrap(gl);
            }
            if ((view.mDebugFlags & 3) == 0) {
                return gl;
            }
            int configFlags = GLSurfaceView.RENDERMODE_WHEN_DIRTY;
            Writer log = null;
            if ((view.mDebugFlags & GLSurfaceView.RENDERMODE_CONTINUOUSLY) != 0) {
                configFlags = GLSurfaceView.RENDERMODE_WHEN_DIRTY | GLSurfaceView.RENDERMODE_CONTINUOUSLY;
            }
            if ((view.mDebugFlags & GLSurfaceView.DEBUG_LOG_GL_CALLS) != 0) {
                log = new LogWriter();
            }
            return GLDebugHelper.wrap(gl, configFlags, log);
        }

        public int swap() {
            if (this.mEgl.eglSwapBuffers(this.mEglDisplay, this.mEglSurface)) {
                return GLES11.GL_CLIP_PLANE0;
            }
            return this.mEgl.eglGetError();
        }

        public void destroySurface() {
            destroySurfaceImp();
        }

        private void destroySurfaceImp() {
            if (this.mEglSurface != null && this.mEglSurface != EGL10.EGL_NO_SURFACE) {
                this.mEgl.eglMakeCurrent(this.mEglDisplay, EGL10.EGL_NO_SURFACE, EGL10.EGL_NO_SURFACE, EGL10.EGL_NO_CONTEXT);
                GLSurfaceView view = (GLSurfaceView) this.mGLSurfaceViewWeakRef.get();
                if (view != null) {
                    view.mEGLWindowSurfaceFactory.destroySurface(this.mEgl, this.mEglDisplay, this.mEglSurface);
                }
                this.mEglSurface = null;
            }
        }

        public void finish() {
            if (this.mEglContext != null) {
                GLSurfaceView view = (GLSurfaceView) this.mGLSurfaceViewWeakRef.get();
                if (view != null) {
                    view.mEGLContextFactory.destroyContext(this.mEgl, this.mEglDisplay, this.mEglContext);
                }
                this.mEglContext = null;
            }
            if (this.mEglDisplay != null) {
                this.mEgl.eglTerminate(this.mEglDisplay);
                this.mEglDisplay = null;
            }
        }

        private void throwEglException(String function) {
            throwEglException(function, this.mEgl.eglGetError());
        }

        public static void throwEglException(String function, int error) {
            throw new RuntimeException(formatEglError(function, error));
        }

        public static void logEglErrorAsWarning(String tag, String function, int error) {
            Log.w(tag, formatEglError(function, error));
        }

        public static String formatEglError(String function, int error) {
            return function + " failed: " + EGLLogWrapper.getErrorString(error);
        }
    }

    static class GLThread extends Thread {
        private EglHelper mEglHelper;
        private ArrayList<Runnable> mEventQueue;
        private boolean mExited;
        private boolean mFinishedCreatingEglSurface;
        private WeakReference<GLSurfaceView> mGLSurfaceViewWeakRef;
        private boolean mHasSurface;
        private boolean mHaveEglContext;
        private boolean mHaveEglSurface;
        private int mHeight;
        private boolean mPaused;
        private boolean mRenderComplete;
        private int mRenderMode;
        private boolean mRequestPaused;
        private boolean mRequestRender;
        private boolean mShouldExit;
        private boolean mShouldReleaseEglContext;
        private boolean mSizeChanged;
        private boolean mSurfaceIsBad;
        private boolean mWaitingForSurface;
        private int mWidth;

        GLThread(WeakReference<GLSurfaceView> glSurfaceViewWeakRef) {
            this.mEventQueue = new ArrayList();
            this.mSizeChanged = true;
            this.mWidth = GLSurfaceView.RENDERMODE_WHEN_DIRTY;
            this.mHeight = GLSurfaceView.RENDERMODE_WHEN_DIRTY;
            this.mRequestRender = true;
            this.mRenderMode = GLSurfaceView.RENDERMODE_CONTINUOUSLY;
            this.mGLSurfaceViewWeakRef = glSurfaceViewWeakRef;
        }

        public void run() {
            setName("GLThread " + getId());
            try {
                guardedRun();
            } catch (InterruptedException e) {
            } finally {
                GLSurfaceView.sGLThreadManager.threadExiting(this);
            }
        }

        private void stopEglSurfaceLocked() {
            if (this.mHaveEglSurface) {
                this.mHaveEglSurface = GLSurfaceView.LOG_THREADS;
                this.mEglHelper.destroySurface();
            }
        }

        private void stopEglContextLocked() {
            if (this.mHaveEglContext) {
                this.mEglHelper.finish();
                this.mHaveEglContext = GLSurfaceView.LOG_THREADS;
                GLSurfaceView.sGLThreadManager.releaseEglContextLocked(this);
            }
        }

        private void guardedRun() throws InterruptedException {
            this.mEglHelper = new EglHelper(this.mGLSurfaceViewWeakRef);
            this.mHaveEglContext = GLSurfaceView.LOG_THREADS;
            this.mHaveEglSurface = GLSurfaceView.LOG_THREADS;
            GL10 gl = null;
            boolean createEglContext = GLSurfaceView.LOG_THREADS;
            boolean createEglSurface = GLSurfaceView.LOG_THREADS;
            boolean createGlInterface = GLSurfaceView.LOG_THREADS;
            boolean lostEglContext = GLSurfaceView.LOG_THREADS;
            boolean sizeChanged = GLSurfaceView.LOG_THREADS;
            boolean wantRenderNotification = GLSurfaceView.LOG_THREADS;
            boolean doRenderNotification = GLSurfaceView.LOG_THREADS;
            boolean askedToReleaseEglContext = GLSurfaceView.LOG_THREADS;
            int w = GLSurfaceView.RENDERMODE_WHEN_DIRTY;
            int h = GLSurfaceView.RENDERMODE_WHEN_DIRTY;
            Runnable event = null;
            while (true) {
                synchronized (GLSurfaceView.sGLThreadManager) {
                    while (true) {
                        if (this.mShouldExit) {
                            synchronized (GLSurfaceView.sGLThreadManager) {
                                stopEglSurfaceLocked();
                                stopEglContextLocked();
                            }
                            return;
                        }
                        GLSurfaceView view;
                        if (this.mEventQueue.isEmpty()) {
                            boolean pausing = GLSurfaceView.LOG_THREADS;
                            if (this.mPaused != this.mRequestPaused) {
                                pausing = this.mRequestPaused;
                                this.mPaused = this.mRequestPaused;
                                GLSurfaceView.sGLThreadManager.notifyAll();
                            }
                            if (this.mShouldReleaseEglContext) {
                                stopEglSurfaceLocked();
                                stopEglContextLocked();
                                this.mShouldReleaseEglContext = GLSurfaceView.LOG_THREADS;
                                askedToReleaseEglContext = true;
                            }
                            if (lostEglContext) {
                                stopEglSurfaceLocked();
                                stopEglContextLocked();
                                lostEglContext = GLSurfaceView.LOG_THREADS;
                            }
                            if (pausing && this.mHaveEglSurface) {
                                stopEglSurfaceLocked();
                            }
                            if (pausing && this.mHaveEglContext) {
                                view = (GLSurfaceView) this.mGLSurfaceViewWeakRef.get();
                                if (!(view == null ? GLSurfaceView.LOG_THREADS : view.mPreserveEGLContextOnPause) || GLSurfaceView.sGLThreadManager.shouldReleaseEGLContextWhenPausing()) {
                                    stopEglContextLocked();
                                }
                            }
                            if (pausing && GLSurfaceView.sGLThreadManager.shouldTerminateEGLWhenPausing()) {
                                this.mEglHelper.finish();
                            }
                            if (!(this.mHasSurface || this.mWaitingForSurface)) {
                                if (this.mHaveEglSurface) {
                                    stopEglSurfaceLocked();
                                }
                                this.mWaitingForSurface = true;
                                this.mSurfaceIsBad = GLSurfaceView.LOG_THREADS;
                                GLSurfaceView.sGLThreadManager.notifyAll();
                            }
                            if (this.mHasSurface && this.mWaitingForSurface) {
                                this.mWaitingForSurface = GLSurfaceView.LOG_THREADS;
                                GLSurfaceView.sGLThreadManager.notifyAll();
                            }
                            if (doRenderNotification) {
                                wantRenderNotification = GLSurfaceView.LOG_THREADS;
                                doRenderNotification = GLSurfaceView.LOG_THREADS;
                                this.mRenderComplete = true;
                                GLSurfaceView.sGLThreadManager.notifyAll();
                            }
                            if (readyToDraw()) {
                                if (!this.mHaveEglContext) {
                                    if (askedToReleaseEglContext) {
                                        askedToReleaseEglContext = GLSurfaceView.LOG_THREADS;
                                    } else {
                                        if (GLSurfaceView.sGLThreadManager.tryAcquireEglContextLocked(this)) {
                                            this.mEglHelper.start();
                                            this.mHaveEglContext = true;
                                            createEglContext = true;
                                            GLSurfaceView.sGLThreadManager.notifyAll();
                                        }
                                    }
                                }
                                if (this.mHaveEglContext && !this.mHaveEglSurface) {
                                    this.mHaveEglSurface = true;
                                    createEglSurface = true;
                                    createGlInterface = true;
                                    sizeChanged = true;
                                }
                                if (this.mHaveEglSurface) {
                                    if (this.mSizeChanged) {
                                        sizeChanged = true;
                                        w = this.mWidth;
                                        h = this.mHeight;
                                        wantRenderNotification = true;
                                        createEglSurface = true;
                                        this.mSizeChanged = GLSurfaceView.LOG_THREADS;
                                    }
                                    this.mRequestRender = GLSurfaceView.LOG_THREADS;
                                    GLSurfaceView.sGLThreadManager.notifyAll();
                                }
                            }
                            GLSurfaceView.sGLThreadManager.wait();
                        } else {
                            event = (Runnable) this.mEventQueue.remove(GLSurfaceView.RENDERMODE_WHEN_DIRTY);
                        }
                        if (event != null) {
                            try {
                                event.run();
                                event = null;
                            } catch (RuntimeException t) {
                                GLSurfaceView.sGLThreadManager.releaseEglContextLocked(this);
                                throw t;
                            } catch (Throwable th) {
                                synchronized (GLSurfaceView.sGLThreadManager) {
                                }
                                stopEglSurfaceLocked();
                                stopEglContextLocked();
                            }
                        } else {
                            if (createEglSurface) {
                                if (this.mEglHelper.createSurface()) {
                                    synchronized (GLSurfaceView.sGLThreadManager) {
                                        this.mFinishedCreatingEglSurface = true;
                                        GLSurfaceView.sGLThreadManager.notifyAll();
                                    }
                                    createEglSurface = GLSurfaceView.LOG_THREADS;
                                } else {
                                    synchronized (GLSurfaceView.sGLThreadManager) {
                                        this.mFinishedCreatingEglSurface = true;
                                        this.mSurfaceIsBad = true;
                                        GLSurfaceView.sGLThreadManager.notifyAll();
                                    }
                                }
                            }
                            if (createGlInterface) {
                                gl = (GL10) this.mEglHelper.createGL();
                                GLSurfaceView.sGLThreadManager.checkGLDriver(gl);
                                createGlInterface = GLSurfaceView.LOG_THREADS;
                            }
                            if (createEglContext) {
                                view = (GLSurfaceView) this.mGLSurfaceViewWeakRef.get();
                                if (view != null) {
                                    view.mRenderer.onSurfaceCreated(gl, this.mEglHelper.mEglConfig);
                                }
                                createEglContext = GLSurfaceView.LOG_THREADS;
                            }
                            if (sizeChanged) {
                                view = (GLSurfaceView) this.mGLSurfaceViewWeakRef.get();
                                if (view != null) {
                                    view.mRenderer.onSurfaceChanged(gl, w, h);
                                }
                                sizeChanged = GLSurfaceView.LOG_THREADS;
                            }
                            view = (GLSurfaceView) this.mGLSurfaceViewWeakRef.get();
                            if (view != null) {
                                view.mRenderer.onDrawFrame(gl);
                            }
                            int swapError = this.mEglHelper.swap();
                            switch (swapError) {
                                case GLES11.GL_CLIP_PLANE0 /*12288*/:
                                    break;
                                case EGL14.EGL_CONTEXT_LOST /*12302*/:
                                    lostEglContext = true;
                                    break;
                                default:
                                    EglHelper.logEglErrorAsWarning("GLThread", "eglSwapBuffers", swapError);
                                    synchronized (GLSurfaceView.sGLThreadManager) {
                                        this.mSurfaceIsBad = true;
                                        GLSurfaceView.sGLThreadManager.notifyAll();
                                        break;
                                    }
                            }
                            if (wantRenderNotification) {
                                doRenderNotification = true;
                            }
                        }
                    }
                }
            }
        }

        public boolean ableToDraw() {
            return (this.mHaveEglContext && this.mHaveEglSurface && readyToDraw()) ? true : GLSurfaceView.LOG_THREADS;
        }

        private boolean readyToDraw() {
            return (this.mPaused || !this.mHasSurface || this.mSurfaceIsBad || this.mWidth <= 0 || this.mHeight <= 0 || !(this.mRequestRender || this.mRenderMode == GLSurfaceView.RENDERMODE_CONTINUOUSLY)) ? GLSurfaceView.LOG_THREADS : true;
        }

        public void setRenderMode(int renderMode) {
            if (renderMode < 0 || renderMode > GLSurfaceView.RENDERMODE_CONTINUOUSLY) {
                throw new IllegalArgumentException("renderMode");
            }
            synchronized (GLSurfaceView.sGLThreadManager) {
                this.mRenderMode = renderMode;
                GLSurfaceView.sGLThreadManager.notifyAll();
            }
        }

        public int getRenderMode() {
            int i;
            synchronized (GLSurfaceView.sGLThreadManager) {
                i = this.mRenderMode;
            }
            return i;
        }

        public void requestRender() {
            synchronized (GLSurfaceView.sGLThreadManager) {
                this.mRequestRender = true;
                GLSurfaceView.sGLThreadManager.notifyAll();
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void surfaceCreated() {
            /*
            r3 = this;
            r2 = android.opengl.GLSurfaceView.sGLThreadManager;
            monitor-enter(r2);
            r1 = 1;
            r3.mHasSurface = r1;	 Catch:{ all -> 0x002f }
            r1 = 0;
            r3.mFinishedCreatingEglSurface = r1;	 Catch:{ all -> 0x002f }
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ all -> 0x002f }
            r1.notifyAll();	 Catch:{ all -> 0x002f }
        L_0x0012:
            r1 = r3.mWaitingForSurface;	 Catch:{ all -> 0x002f }
            if (r1 == 0) goto L_0x0032;
        L_0x0016:
            r1 = r3.mFinishedCreatingEglSurface;	 Catch:{ all -> 0x002f }
            if (r1 != 0) goto L_0x0032;
        L_0x001a:
            r1 = r3.mExited;	 Catch:{ all -> 0x002f }
            if (r1 != 0) goto L_0x0032;
        L_0x001e:
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ InterruptedException -> 0x0026 }
            r1.wait();	 Catch:{ InterruptedException -> 0x0026 }
            goto L_0x0012;
        L_0x0026:
            r0 = move-exception;
            r1 = java.lang.Thread.currentThread();	 Catch:{ all -> 0x002f }
            r1.interrupt();	 Catch:{ all -> 0x002f }
            goto L_0x0012;
        L_0x002f:
            r1 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x002f }
            throw r1;
        L_0x0032:
            monitor-exit(r2);	 Catch:{ all -> 0x002f }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.opengl.GLSurfaceView.GLThread.surfaceCreated():void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void surfaceDestroyed() {
            /*
            r3 = this;
            r2 = android.opengl.GLSurfaceView.sGLThreadManager;
            monitor-enter(r2);
            r1 = 0;
            r3.mHasSurface = r1;	 Catch:{ all -> 0x0028 }
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ all -> 0x0028 }
            r1.notifyAll();	 Catch:{ all -> 0x0028 }
        L_0x000f:
            r1 = r3.mWaitingForSurface;	 Catch:{ all -> 0x0028 }
            if (r1 != 0) goto L_0x002b;
        L_0x0013:
            r1 = r3.mExited;	 Catch:{ all -> 0x0028 }
            if (r1 != 0) goto L_0x002b;
        L_0x0017:
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ InterruptedException -> 0x001f }
            r1.wait();	 Catch:{ InterruptedException -> 0x001f }
            goto L_0x000f;
        L_0x001f:
            r0 = move-exception;
            r1 = java.lang.Thread.currentThread();	 Catch:{ all -> 0x0028 }
            r1.interrupt();	 Catch:{ all -> 0x0028 }
            goto L_0x000f;
        L_0x0028:
            r1 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x0028 }
            throw r1;
        L_0x002b:
            monitor-exit(r2);	 Catch:{ all -> 0x0028 }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.opengl.GLSurfaceView.GLThread.surfaceDestroyed():void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onPause() {
            /*
            r3 = this;
            r2 = android.opengl.GLSurfaceView.sGLThreadManager;
            monitor-enter(r2);
            r1 = 1;
            r3.mRequestPaused = r1;	 Catch:{ all -> 0x0028 }
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ all -> 0x0028 }
            r1.notifyAll();	 Catch:{ all -> 0x0028 }
        L_0x000f:
            r1 = r3.mExited;	 Catch:{ all -> 0x0028 }
            if (r1 != 0) goto L_0x002b;
        L_0x0013:
            r1 = r3.mPaused;	 Catch:{ all -> 0x0028 }
            if (r1 != 0) goto L_0x002b;
        L_0x0017:
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ InterruptedException -> 0x001f }
            r1.wait();	 Catch:{ InterruptedException -> 0x001f }
            goto L_0x000f;
        L_0x001f:
            r0 = move-exception;
            r1 = java.lang.Thread.currentThread();	 Catch:{ all -> 0x0028 }
            r1.interrupt();	 Catch:{ all -> 0x0028 }
            goto L_0x000f;
        L_0x0028:
            r1 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x0028 }
            throw r1;
        L_0x002b:
            monitor-exit(r2);	 Catch:{ all -> 0x0028 }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.opengl.GLSurfaceView.GLThread.onPause():void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onResume() {
            /*
            r3 = this;
            r2 = android.opengl.GLSurfaceView.sGLThreadManager;
            monitor-enter(r2);
            r1 = 0;
            r3.mRequestPaused = r1;	 Catch:{ all -> 0x0032 }
            r1 = 1;
            r3.mRequestRender = r1;	 Catch:{ all -> 0x0032 }
            r1 = 0;
            r3.mRenderComplete = r1;	 Catch:{ all -> 0x0032 }
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ all -> 0x0032 }
            r1.notifyAll();	 Catch:{ all -> 0x0032 }
        L_0x0015:
            r1 = r3.mExited;	 Catch:{ all -> 0x0032 }
            if (r1 != 0) goto L_0x0035;
        L_0x0019:
            r1 = r3.mPaused;	 Catch:{ all -> 0x0032 }
            if (r1 == 0) goto L_0x0035;
        L_0x001d:
            r1 = r3.mRenderComplete;	 Catch:{ all -> 0x0032 }
            if (r1 != 0) goto L_0x0035;
        L_0x0021:
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ InterruptedException -> 0x0029 }
            r1.wait();	 Catch:{ InterruptedException -> 0x0029 }
            goto L_0x0015;
        L_0x0029:
            r0 = move-exception;
            r1 = java.lang.Thread.currentThread();	 Catch:{ all -> 0x0032 }
            r1.interrupt();	 Catch:{ all -> 0x0032 }
            goto L_0x0015;
        L_0x0032:
            r1 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x0032 }
            throw r1;
        L_0x0035:
            monitor-exit(r2);	 Catch:{ all -> 0x0032 }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.opengl.GLSurfaceView.GLThread.onResume():void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onWindowResize(int r4, int r5) {
            /*
            r3 = this;
            r2 = android.opengl.GLSurfaceView.sGLThreadManager;
            monitor-enter(r2);
            r3.mWidth = r4;	 Catch:{ all -> 0x003c }
            r3.mHeight = r5;	 Catch:{ all -> 0x003c }
            r1 = 1;
            r3.mSizeChanged = r1;	 Catch:{ all -> 0x003c }
            r1 = 1;
            r3.mRequestRender = r1;	 Catch:{ all -> 0x003c }
            r1 = 0;
            r3.mRenderComplete = r1;	 Catch:{ all -> 0x003c }
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ all -> 0x003c }
            r1.notifyAll();	 Catch:{ all -> 0x003c }
        L_0x0019:
            r1 = r3.mExited;	 Catch:{ all -> 0x003c }
            if (r1 != 0) goto L_0x003f;
        L_0x001d:
            r1 = r3.mPaused;	 Catch:{ all -> 0x003c }
            if (r1 != 0) goto L_0x003f;
        L_0x0021:
            r1 = r3.mRenderComplete;	 Catch:{ all -> 0x003c }
            if (r1 != 0) goto L_0x003f;
        L_0x0025:
            r1 = r3.ableToDraw();	 Catch:{ all -> 0x003c }
            if (r1 == 0) goto L_0x003f;
        L_0x002b:
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ InterruptedException -> 0x0033 }
            r1.wait();	 Catch:{ InterruptedException -> 0x0033 }
            goto L_0x0019;
        L_0x0033:
            r0 = move-exception;
            r1 = java.lang.Thread.currentThread();	 Catch:{ all -> 0x003c }
            r1.interrupt();	 Catch:{ all -> 0x003c }
            goto L_0x0019;
        L_0x003c:
            r1 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x003c }
            throw r1;
        L_0x003f:
            monitor-exit(r2);	 Catch:{ all -> 0x003c }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.opengl.GLSurfaceView.GLThread.onWindowResize(int, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void requestExitAndWait() {
            /*
            r3 = this;
            r2 = android.opengl.GLSurfaceView.sGLThreadManager;
            monitor-enter(r2);
            r1 = 1;
            r3.mShouldExit = r1;	 Catch:{ all -> 0x0024 }
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ all -> 0x0024 }
            r1.notifyAll();	 Catch:{ all -> 0x0024 }
        L_0x000f:
            r1 = r3.mExited;	 Catch:{ all -> 0x0024 }
            if (r1 != 0) goto L_0x0027;
        L_0x0013:
            r1 = android.opengl.GLSurfaceView.sGLThreadManager;	 Catch:{ InterruptedException -> 0x001b }
            r1.wait();	 Catch:{ InterruptedException -> 0x001b }
            goto L_0x000f;
        L_0x001b:
            r0 = move-exception;
            r1 = java.lang.Thread.currentThread();	 Catch:{ all -> 0x0024 }
            r1.interrupt();	 Catch:{ all -> 0x0024 }
            goto L_0x000f;
        L_0x0024:
            r1 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x0024 }
            throw r1;
        L_0x0027:
            monitor-exit(r2);	 Catch:{ all -> 0x0024 }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.opengl.GLSurfaceView.GLThread.requestExitAndWait():void");
        }

        public void requestReleaseEglContextLocked() {
            this.mShouldReleaseEglContext = true;
            GLSurfaceView.sGLThreadManager.notifyAll();
        }

        public void queueEvent(Runnable r) {
            if (r == null) {
                throw new IllegalArgumentException("r must not be null");
            }
            synchronized (GLSurfaceView.sGLThreadManager) {
                this.mEventQueue.add(r);
                GLSurfaceView.sGLThreadManager.notifyAll();
            }
        }
    }

    private static class GLThreadManager {
        private static String TAG = null;
        private static final int kGLES_20 = 131072;
        private static final String kMSM7K_RENDERER_PREFIX = "Q3Dimension MSM7500 ";
        private GLThread mEglOwner;
        private boolean mGLESDriverCheckComplete;
        private int mGLESVersion;
        private boolean mGLESVersionCheckComplete;
        private boolean mLimitedGLESContexts;
        private boolean mMultipleGLESContextsAllowed;

        private GLThreadManager() {
        }

        static {
            TAG = "GLThreadManager";
        }

        public synchronized void threadExiting(GLThread thread) {
            thread.mExited = true;
            if (this.mEglOwner == thread) {
                this.mEglOwner = null;
            }
            notifyAll();
        }

        public boolean tryAcquireEglContextLocked(GLThread thread) {
            if (this.mEglOwner == thread || this.mEglOwner == null) {
                this.mEglOwner = thread;
                notifyAll();
                return true;
            }
            checkGLESVersion();
            if (this.mMultipleGLESContextsAllowed) {
                return true;
            }
            if (this.mEglOwner != null) {
                this.mEglOwner.requestReleaseEglContextLocked();
            }
            return GLSurfaceView.LOG_THREADS;
        }

        public void releaseEglContextLocked(GLThread thread) {
            if (this.mEglOwner == thread) {
                this.mEglOwner = null;
            }
            notifyAll();
        }

        public synchronized boolean shouldReleaseEGLContextWhenPausing() {
            return this.mLimitedGLESContexts;
        }

        public synchronized boolean shouldTerminateEGLWhenPausing() {
            checkGLESVersion();
            return !this.mMultipleGLESContextsAllowed ? true : GLSurfaceView.LOG_THREADS;
        }

        public synchronized void checkGLDriver(GL10 gl) {
            boolean z = true;
            synchronized (this) {
                if (!this.mGLESDriverCheckComplete) {
                    checkGLESVersion();
                    String renderer = gl.glGetString(GLES20.GL_RENDERER);
                    if (this.mGLESVersion < kGLES_20) {
                        boolean z2;
                        if (renderer.startsWith(kMSM7K_RENDERER_PREFIX)) {
                            z2 = GLSurfaceView.LOG_THREADS;
                        } else {
                            z2 = true;
                        }
                        this.mMultipleGLESContextsAllowed = z2;
                        notifyAll();
                    }
                    if (this.mMultipleGLESContextsAllowed) {
                        z = GLSurfaceView.LOG_THREADS;
                    }
                    this.mLimitedGLESContexts = z;
                    this.mGLESDriverCheckComplete = true;
                }
            }
        }

        private void checkGLESVersion() {
            if (!this.mGLESVersionCheckComplete) {
                this.mGLESVersion = SystemProperties.getInt("ro.opengles.version", GLSurfaceView.RENDERMODE_WHEN_DIRTY);
                if (this.mGLESVersion >= kGLES_20) {
                    this.mMultipleGLESContextsAllowed = true;
                }
                this.mGLESVersionCheckComplete = true;
            }
        }
    }

    public interface GLWrapper {
        GL wrap(GL gl);
    }

    static class LogWriter extends Writer {
        private StringBuilder mBuilder;

        LogWriter() {
            this.mBuilder = new StringBuilder();
        }

        public void close() {
            flushBuilder();
        }

        public void flush() {
            flushBuilder();
        }

        public void write(char[] buf, int offset, int count) {
            for (int i = GLSurfaceView.RENDERMODE_WHEN_DIRTY; i < count; i += GLSurfaceView.RENDERMODE_CONTINUOUSLY) {
                char c = buf[offset + i];
                if (c == '\n') {
                    flushBuilder();
                } else {
                    this.mBuilder.append(c);
                }
            }
        }

        private void flushBuilder() {
            if (this.mBuilder.length() > 0) {
                Log.v(GLSurfaceView.TAG, this.mBuilder.toString());
                this.mBuilder.delete(GLSurfaceView.RENDERMODE_WHEN_DIRTY, this.mBuilder.length());
            }
        }
    }

    public interface Renderer {
        void onDrawFrame(GL10 gl10);

        void onSurfaceChanged(GL10 gl10, int i, int i2);

        void onSurfaceCreated(GL10 gl10, EGLConfig eGLConfig);
    }

    private class SimpleEGLConfigChooser extends ComponentSizeChooser {
        public SimpleEGLConfigChooser(boolean withDepthBuffer) {
            int i;
            if (withDepthBuffer) {
                i = 16;
            } else {
                i = GLSurfaceView.RENDERMODE_WHEN_DIRTY;
            }
            super(8, 8, 8, GLSurfaceView.RENDERMODE_WHEN_DIRTY, i, GLSurfaceView.RENDERMODE_WHEN_DIRTY);
        }
    }

    public GLSurfaceView(Context context) {
        super(context);
        this.mThisWeakRef = new WeakReference(this);
        init();
    }

    public GLSurfaceView(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.mThisWeakRef = new WeakReference(this);
        init();
    }

    protected void finalize() throws Throwable {
        try {
            if (this.mGLThread != null) {
                this.mGLThread.requestExitAndWait();
            }
            super.finalize();
        } catch (Throwable th) {
            super.finalize();
        }
    }

    private void init() {
        getHolder().addCallback(this);
    }

    public void setGLWrapper(GLWrapper glWrapper) {
        this.mGLWrapper = glWrapper;
    }

    public void setDebugFlags(int debugFlags) {
        this.mDebugFlags = debugFlags;
    }

    public int getDebugFlags() {
        return this.mDebugFlags;
    }

    public void setPreserveEGLContextOnPause(boolean preserveOnPause) {
        this.mPreserveEGLContextOnPause = preserveOnPause;
    }

    public boolean getPreserveEGLContextOnPause() {
        return this.mPreserveEGLContextOnPause;
    }

    public void setRenderer(Renderer renderer) {
        checkRenderThreadState();
        if (this.mEGLConfigChooser == null) {
            this.mEGLConfigChooser = new SimpleEGLConfigChooser(true);
        }
        if (this.mEGLContextFactory == null) {
            this.mEGLContextFactory = new DefaultContextFactory();
        }
        if (this.mEGLWindowSurfaceFactory == null) {
            this.mEGLWindowSurfaceFactory = new DefaultWindowSurfaceFactory();
        }
        this.mRenderer = renderer;
        this.mGLThread = new GLThread(this.mThisWeakRef);
        this.mGLThread.start();
    }

    public void setEGLContextFactory(EGLContextFactory factory) {
        checkRenderThreadState();
        this.mEGLContextFactory = factory;
    }

    public void setEGLWindowSurfaceFactory(EGLWindowSurfaceFactory factory) {
        checkRenderThreadState();
        this.mEGLWindowSurfaceFactory = factory;
    }

    public void setEGLConfigChooser(EGLConfigChooser configChooser) {
        checkRenderThreadState();
        this.mEGLConfigChooser = configChooser;
    }

    public void setEGLConfigChooser(boolean needDepth) {
        setEGLConfigChooser(new SimpleEGLConfigChooser(needDepth));
    }

    public void setEGLConfigChooser(int redSize, int greenSize, int blueSize, int alphaSize, int depthSize, int stencilSize) {
        setEGLConfigChooser(new ComponentSizeChooser(redSize, greenSize, blueSize, alphaSize, depthSize, stencilSize));
    }

    public void setEGLContextClientVersion(int version) {
        checkRenderThreadState();
        this.mEGLContextClientVersion = version;
    }

    public void setRenderMode(int renderMode) {
        this.mGLThread.setRenderMode(renderMode);
    }

    public int getRenderMode() {
        return this.mGLThread.getRenderMode();
    }

    public void requestRender() {
        this.mGLThread.requestRender();
    }

    public void surfaceCreated(SurfaceHolder holder) {
        this.mGLThread.surfaceCreated();
    }

    public void surfaceDestroyed(SurfaceHolder holder) {
        this.mGLThread.surfaceDestroyed();
    }

    public void surfaceChanged(SurfaceHolder holder, int format, int w, int h) {
        this.mGLThread.onWindowResize(w, h);
    }

    public void onPause() {
        this.mGLThread.onPause();
    }

    public void onResume() {
        this.mGLThread.onResume();
    }

    public void queueEvent(Runnable r) {
        this.mGLThread.queueEvent(r);
    }

    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        if (this.mDetached && this.mRenderer != null) {
            int renderMode = RENDERMODE_CONTINUOUSLY;
            if (this.mGLThread != null) {
                renderMode = this.mGLThread.getRenderMode();
            }
            this.mGLThread = new GLThread(this.mThisWeakRef);
            if (renderMode != RENDERMODE_CONTINUOUSLY) {
                this.mGLThread.setRenderMode(renderMode);
            }
            this.mGLThread.start();
        }
        this.mDetached = LOG_THREADS;
    }

    protected void onDetachedFromWindow() {
        if (this.mGLThread != null) {
            this.mGLThread.requestExitAndWait();
        }
        this.mDetached = true;
        super.onDetachedFromWindow();
    }

    private void checkRenderThreadState() {
        if (this.mGLThread != null) {
            throw new IllegalStateException("setRenderer has already been called for this instance.");
        }
    }

    static {
        sGLThreadManager = new GLThreadManager();
    }
}
