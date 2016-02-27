package android.view;

import android.content.Context;
import android.content.res.CompatibilityInfo.Translator;
import android.content.res.Configuration;
import android.graphics.Canvas;
import android.graphics.PixelFormat;
import android.graphics.PorterDuff.Mode;
import android.graphics.Rect;
import android.graphics.Region;
import android.graphics.Region.Op;
import android.os.Handler;
import android.os.Message;
import android.os.ParcelFileDescriptor;
import android.os.RemoteException;
import android.os.SystemClock;
import android.util.AttributeSet;
import android.util.Log;
import android.view.SurfaceHolder.Callback;
import android.view.SurfaceHolder.Callback2;
import android.view.ViewTreeObserver.OnPreDrawListener;
import android.view.ViewTreeObserver.OnScrollChangedListener;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityNodeInfo;
import com.android.internal.view.BaseIWindow;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.concurrent.locks.ReentrantLock;

public class SurfaceView extends View {
    private static final boolean DEBUG = false;
    static final int GET_NEW_SURFACE_MSG = 2;
    static final int KEEP_SCREEN_ON_MSG = 1;
    private static final String TAG = "SurfaceView";
    static final int UPDATE_WINDOW_MSG = 3;
    final ArrayList<Callback> mCallbacks;
    final Configuration mConfiguration;
    final Rect mContentInsets;
    private final OnPreDrawListener mDrawListener;
    boolean mDrawingStopped;
    int mFormat;
    private boolean mGlobalListenersAdded;
    final Handler mHandler;
    boolean mHaveFrame;
    int mHeight;
    boolean mIsCreating;
    long mLastLockTime;
    int mLastSurfaceHeight;
    int mLastSurfaceWidth;
    final LayoutParams mLayout;
    int mLeft;
    final int[] mLocation;
    final Surface mNewSurface;
    final Rect mOverscanInsets;
    boolean mReportDrawNeeded;
    int mRequestedFormat;
    int mRequestedHeight;
    boolean mRequestedVisible;
    int mRequestedWidth;
    final OnScrollChangedListener mScrollChangedListener;
    IWindowSession mSession;
    final Rect mStableInsets;
    final Surface mSurface;
    boolean mSurfaceCreated;
    final Rect mSurfaceFrame;
    private final SurfaceHolder mSurfaceHolder;
    final ReentrantLock mSurfaceLock;
    int mTop;
    private Translator mTranslator;
    boolean mUpdateWindowNeeded;
    boolean mViewVisibility;
    boolean mVisible;
    final Rect mVisibleInsets;
    int mWidth;
    final Rect mWinFrame;
    MyWindow mWindow;
    int mWindowType;
    boolean mWindowVisibility;

    /* renamed from: android.view.SurfaceView.1 */
    class C08321 extends Handler {
        C08321() {
        }

        public void handleMessage(Message msg) {
            boolean z = SurfaceView.DEBUG;
            switch (msg.what) {
                case SurfaceView.KEEP_SCREEN_ON_MSG /*1*/:
                    SurfaceView surfaceView = SurfaceView.this;
                    if (msg.arg1 != 0) {
                        z = true;
                    }
                    surfaceView.setKeepScreenOn(z);
                case SurfaceView.GET_NEW_SURFACE_MSG /*2*/:
                    SurfaceView.this.handleGetNewSurface();
                case SurfaceView.UPDATE_WINDOW_MSG /*3*/:
                    SurfaceView.this.updateWindow(SurfaceView.DEBUG, SurfaceView.DEBUG);
                default:
            }
        }
    }

    /* renamed from: android.view.SurfaceView.2 */
    class C08332 implements OnScrollChangedListener {
        C08332() {
        }

        public void onScrollChanged() {
            SurfaceView.this.updateWindow(SurfaceView.DEBUG, SurfaceView.DEBUG);
        }
    }

    /* renamed from: android.view.SurfaceView.3 */
    class C08343 implements OnPreDrawListener {
        C08343() {
        }

        public boolean onPreDraw() {
            boolean z;
            SurfaceView surfaceView = SurfaceView.this;
            if (SurfaceView.this.getWidth() <= 0 || SurfaceView.this.getHeight() <= 0) {
                z = SurfaceView.DEBUG;
            } else {
                z = true;
            }
            surfaceView.mHaveFrame = z;
            SurfaceView.this.updateWindow(SurfaceView.DEBUG, SurfaceView.DEBUG);
            return true;
        }
    }

    /* renamed from: android.view.SurfaceView.4 */
    class C08354 implements SurfaceHolder {
        private static final String LOG_TAG = "SurfaceHolder";

        C08354() {
        }

        public boolean isCreating() {
            return SurfaceView.this.mIsCreating;
        }

        public void addCallback(Callback callback) {
            synchronized (SurfaceView.this.mCallbacks) {
                if (!SurfaceView.this.mCallbacks.contains(callback)) {
                    SurfaceView.this.mCallbacks.add(callback);
                }
            }
        }

        public void removeCallback(Callback callback) {
            synchronized (SurfaceView.this.mCallbacks) {
                SurfaceView.this.mCallbacks.remove(callback);
            }
        }

        public void setFixedSize(int width, int height) {
            if (SurfaceView.this.mRequestedWidth != width || SurfaceView.this.mRequestedHeight != height) {
                SurfaceView.this.mRequestedWidth = width;
                SurfaceView.this.mRequestedHeight = height;
                SurfaceView.this.requestLayout();
            }
        }

        public void setSizeFromLayout() {
            if (SurfaceView.this.mRequestedWidth != -1 || SurfaceView.this.mRequestedHeight != -1) {
                SurfaceView surfaceView = SurfaceView.this;
                SurfaceView.this.mRequestedHeight = -1;
                surfaceView.mRequestedWidth = -1;
                SurfaceView.this.requestLayout();
            }
        }

        public void setFormat(int format) {
            if (format == -1) {
                format = 4;
            }
            SurfaceView.this.mRequestedFormat = format;
            if (SurfaceView.this.mWindow != null) {
                SurfaceView.this.updateWindow(SurfaceView.DEBUG, SurfaceView.DEBUG);
            }
        }

        @Deprecated
        public void setType(int type) {
        }

        public void setKeepScreenOn(boolean screenOn) {
            int i = SurfaceView.KEEP_SCREEN_ON_MSG;
            Message msg = SurfaceView.this.mHandler.obtainMessage(SurfaceView.KEEP_SCREEN_ON_MSG);
            if (!screenOn) {
                i = 0;
            }
            msg.arg1 = i;
            SurfaceView.this.mHandler.sendMessage(msg);
        }

        public Canvas lockCanvas() {
            return internalLockCanvas(null);
        }

        public Canvas lockCanvas(Rect inOutDirty) {
            return internalLockCanvas(inOutDirty);
        }

        private final Canvas internalLockCanvas(Rect dirty) {
            SurfaceView.this.mSurfaceLock.lock();
            Canvas c = null;
            if (!(SurfaceView.this.mDrawingStopped || SurfaceView.this.mWindow == null)) {
                try {
                    c = SurfaceView.this.mSurface.lockCanvas(dirty);
                } catch (Exception e) {
                    Log.e(LOG_TAG, "Exception locking surface", e);
                }
            }
            if (c != null) {
                SurfaceView.this.mLastLockTime = SystemClock.uptimeMillis();
                return c;
            }
            long now = SystemClock.uptimeMillis();
            long nextTime = SurfaceView.this.mLastLockTime + 100;
            if (nextTime > now) {
                try {
                    Thread.sleep(nextTime - now);
                } catch (InterruptedException e2) {
                }
                now = SystemClock.uptimeMillis();
            }
            SurfaceView.this.mLastLockTime = now;
            SurfaceView.this.mSurfaceLock.unlock();
            return null;
        }

        public void unlockCanvasAndPost(Canvas canvas) {
            SurfaceView.this.mSurface.unlockCanvasAndPost(canvas);
            SurfaceView.this.mSurfaceLock.unlock();
        }

        public Surface getSurface() {
            return SurfaceView.this.mSurface;
        }

        public Rect getSurfaceFrame() {
            return SurfaceView.this.mSurfaceFrame;
        }
    }

    private static class MyWindow extends BaseIWindow {
        int mCurHeight;
        int mCurWidth;
        private final WeakReference<SurfaceView> mSurfaceView;

        public MyWindow(SurfaceView surfaceView) {
            this.mCurWidth = -1;
            this.mCurHeight = -1;
            this.mSurfaceView = new WeakReference(surfaceView);
        }

        public void resized(Rect frame, Rect overscanInsets, Rect contentInsets, Rect visibleInsets, Rect stableInsets, boolean reportDraw, Configuration newConfig) {
            SurfaceView surfaceView = (SurfaceView) this.mSurfaceView.get();
            if (surfaceView != null) {
                surfaceView.mSurfaceLock.lock();
                if (reportDraw) {
                    try {
                        surfaceView.mUpdateWindowNeeded = true;
                        surfaceView.mReportDrawNeeded = true;
                        surfaceView.mHandler.sendEmptyMessage(SurfaceView.UPDATE_WINDOW_MSG);
                    } catch (Throwable th) {
                        surfaceView.mSurfaceLock.unlock();
                    }
                } else if (!(surfaceView.mWinFrame.width() == frame.width() && surfaceView.mWinFrame.height() == frame.height())) {
                    surfaceView.mUpdateWindowNeeded = true;
                    surfaceView.mHandler.sendEmptyMessage(SurfaceView.UPDATE_WINDOW_MSG);
                }
                surfaceView.mSurfaceLock.unlock();
            }
        }

        public void dispatchAppVisibility(boolean visible) {
        }

        public void dispatchGetNewSurface() {
            SurfaceView surfaceView = (SurfaceView) this.mSurfaceView.get();
            if (surfaceView != null) {
                surfaceView.mHandler.sendMessage(surfaceView.mHandler.obtainMessage(SurfaceView.GET_NEW_SURFACE_MSG));
            }
        }

        public void windowFocusChanged(boolean hasFocus, boolean touchEnabled) {
            Log.w(SurfaceView.TAG, "Unexpected focus in surface: focus=" + hasFocus + ", touchEnabled=" + touchEnabled);
        }

        public void executeCommand(String command, String parameters, ParcelFileDescriptor out) {
        }
    }

    public SurfaceView(Context context) {
        super(context);
        this.mCallbacks = new ArrayList();
        this.mLocation = new int[GET_NEW_SURFACE_MSG];
        this.mSurfaceLock = new ReentrantLock();
        this.mSurface = new Surface();
        this.mNewSurface = new Surface();
        this.mDrawingStopped = true;
        this.mLayout = new LayoutParams();
        this.mVisibleInsets = new Rect();
        this.mWinFrame = new Rect();
        this.mOverscanInsets = new Rect();
        this.mContentInsets = new Rect();
        this.mStableInsets = new Rect();
        this.mConfiguration = new Configuration();
        this.mWindowType = LayoutParams.TYPE_APPLICATION_MEDIA;
        this.mIsCreating = DEBUG;
        this.mHandler = new C08321();
        this.mScrollChangedListener = new C08332();
        this.mRequestedVisible = DEBUG;
        this.mWindowVisibility = DEBUG;
        this.mViewVisibility = DEBUG;
        this.mRequestedWidth = -1;
        this.mRequestedHeight = -1;
        this.mRequestedFormat = 4;
        this.mHaveFrame = DEBUG;
        this.mSurfaceCreated = DEBUG;
        this.mLastLockTime = 0;
        this.mVisible = DEBUG;
        this.mLeft = -1;
        this.mTop = -1;
        this.mWidth = -1;
        this.mHeight = -1;
        this.mFormat = -1;
        this.mSurfaceFrame = new Rect();
        this.mLastSurfaceWidth = -1;
        this.mLastSurfaceHeight = -1;
        this.mDrawListener = new C08343();
        this.mSurfaceHolder = new C08354();
        init();
    }

    public SurfaceView(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.mCallbacks = new ArrayList();
        this.mLocation = new int[GET_NEW_SURFACE_MSG];
        this.mSurfaceLock = new ReentrantLock();
        this.mSurface = new Surface();
        this.mNewSurface = new Surface();
        this.mDrawingStopped = true;
        this.mLayout = new LayoutParams();
        this.mVisibleInsets = new Rect();
        this.mWinFrame = new Rect();
        this.mOverscanInsets = new Rect();
        this.mContentInsets = new Rect();
        this.mStableInsets = new Rect();
        this.mConfiguration = new Configuration();
        this.mWindowType = LayoutParams.TYPE_APPLICATION_MEDIA;
        this.mIsCreating = DEBUG;
        this.mHandler = new C08321();
        this.mScrollChangedListener = new C08332();
        this.mRequestedVisible = DEBUG;
        this.mWindowVisibility = DEBUG;
        this.mViewVisibility = DEBUG;
        this.mRequestedWidth = -1;
        this.mRequestedHeight = -1;
        this.mRequestedFormat = 4;
        this.mHaveFrame = DEBUG;
        this.mSurfaceCreated = DEBUG;
        this.mLastLockTime = 0;
        this.mVisible = DEBUG;
        this.mLeft = -1;
        this.mTop = -1;
        this.mWidth = -1;
        this.mHeight = -1;
        this.mFormat = -1;
        this.mSurfaceFrame = new Rect();
        this.mLastSurfaceWidth = -1;
        this.mLastSurfaceHeight = -1;
        this.mDrawListener = new C08343();
        this.mSurfaceHolder = new C08354();
        init();
    }

    public SurfaceView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        this.mCallbacks = new ArrayList();
        this.mLocation = new int[GET_NEW_SURFACE_MSG];
        this.mSurfaceLock = new ReentrantLock();
        this.mSurface = new Surface();
        this.mNewSurface = new Surface();
        this.mDrawingStopped = true;
        this.mLayout = new LayoutParams();
        this.mVisibleInsets = new Rect();
        this.mWinFrame = new Rect();
        this.mOverscanInsets = new Rect();
        this.mContentInsets = new Rect();
        this.mStableInsets = new Rect();
        this.mConfiguration = new Configuration();
        this.mWindowType = LayoutParams.TYPE_APPLICATION_MEDIA;
        this.mIsCreating = DEBUG;
        this.mHandler = new C08321();
        this.mScrollChangedListener = new C08332();
        this.mRequestedVisible = DEBUG;
        this.mWindowVisibility = DEBUG;
        this.mViewVisibility = DEBUG;
        this.mRequestedWidth = -1;
        this.mRequestedHeight = -1;
        this.mRequestedFormat = 4;
        this.mHaveFrame = DEBUG;
        this.mSurfaceCreated = DEBUG;
        this.mLastLockTime = 0;
        this.mVisible = DEBUG;
        this.mLeft = -1;
        this.mTop = -1;
        this.mWidth = -1;
        this.mHeight = -1;
        this.mFormat = -1;
        this.mSurfaceFrame = new Rect();
        this.mLastSurfaceWidth = -1;
        this.mLastSurfaceHeight = -1;
        this.mDrawListener = new C08343();
        this.mSurfaceHolder = new C08354();
        init();
    }

    public SurfaceView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mCallbacks = new ArrayList();
        this.mLocation = new int[GET_NEW_SURFACE_MSG];
        this.mSurfaceLock = new ReentrantLock();
        this.mSurface = new Surface();
        this.mNewSurface = new Surface();
        this.mDrawingStopped = true;
        this.mLayout = new LayoutParams();
        this.mVisibleInsets = new Rect();
        this.mWinFrame = new Rect();
        this.mOverscanInsets = new Rect();
        this.mContentInsets = new Rect();
        this.mStableInsets = new Rect();
        this.mConfiguration = new Configuration();
        this.mWindowType = LayoutParams.TYPE_APPLICATION_MEDIA;
        this.mIsCreating = DEBUG;
        this.mHandler = new C08321();
        this.mScrollChangedListener = new C08332();
        this.mRequestedVisible = DEBUG;
        this.mWindowVisibility = DEBUG;
        this.mViewVisibility = DEBUG;
        this.mRequestedWidth = -1;
        this.mRequestedHeight = -1;
        this.mRequestedFormat = 4;
        this.mHaveFrame = DEBUG;
        this.mSurfaceCreated = DEBUG;
        this.mLastLockTime = 0;
        this.mVisible = DEBUG;
        this.mLeft = -1;
        this.mTop = -1;
        this.mWidth = -1;
        this.mHeight = -1;
        this.mFormat = -1;
        this.mSurfaceFrame = new Rect();
        this.mLastSurfaceWidth = -1;
        this.mLastSurfaceHeight = -1;
        this.mDrawListener = new C08343();
        this.mSurfaceHolder = new C08354();
        init();
    }

    private void init() {
        setWillNotDraw(true);
    }

    public SurfaceHolder getHolder() {
        return this.mSurfaceHolder;
    }

    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        this.mParent.requestTransparentRegion(this);
        this.mSession = getWindowSession();
        this.mLayout.token = getWindowToken();
        this.mLayout.setTitle(TAG);
        this.mViewVisibility = getVisibility() == 0 ? true : DEBUG;
        if (!this.mGlobalListenersAdded) {
            ViewTreeObserver observer = getViewTreeObserver();
            observer.addOnScrollChangedListener(this.mScrollChangedListener);
            observer.addOnPreDrawListener(this.mDrawListener);
            this.mGlobalListenersAdded = true;
        }
    }

    protected void onWindowVisibilityChanged(int visibility) {
        boolean z;
        boolean z2 = true;
        super.onWindowVisibilityChanged(visibility);
        if (visibility == 0) {
            z = true;
        } else {
            z = DEBUG;
        }
        this.mWindowVisibility = z;
        if (!(this.mWindowVisibility && this.mViewVisibility)) {
            z2 = DEBUG;
        }
        this.mRequestedVisible = z2;
        updateWindow(DEBUG, DEBUG);
    }

    public void setVisibility(int visibility) {
        boolean z;
        boolean newRequestedVisible;
        super.setVisibility(visibility);
        if (visibility == 0) {
            z = true;
        } else {
            z = DEBUG;
        }
        this.mViewVisibility = z;
        if (this.mWindowVisibility && this.mViewVisibility) {
            newRequestedVisible = true;
        } else {
            newRequestedVisible = DEBUG;
        }
        if (newRequestedVisible != this.mRequestedVisible) {
            requestLayout();
        }
        this.mRequestedVisible = newRequestedVisible;
        updateWindow(DEBUG, DEBUG);
    }

    protected void onDetachedFromWindow() {
        if (this.mGlobalListenersAdded) {
            ViewTreeObserver observer = getViewTreeObserver();
            observer.removeOnScrollChangedListener(this.mScrollChangedListener);
            observer.removeOnPreDrawListener(this.mDrawListener);
            this.mGlobalListenersAdded = DEBUG;
        }
        this.mRequestedVisible = DEBUG;
        updateWindow(DEBUG, DEBUG);
        this.mHaveFrame = DEBUG;
        if (this.mWindow != null) {
            try {
                this.mSession.remove(this.mWindow);
            } catch (RemoteException e) {
            }
            this.mWindow = null;
        }
        this.mSession = null;
        this.mLayout.token = null;
        super.onDetachedFromWindow();
    }

    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        setMeasuredDimension(this.mRequestedWidth >= 0 ? View.resolveSizeAndState(this.mRequestedWidth, widthMeasureSpec, 0) : View.getDefaultSize(0, widthMeasureSpec), this.mRequestedHeight >= 0 ? View.resolveSizeAndState(this.mRequestedHeight, heightMeasureSpec, 0) : View.getDefaultSize(0, heightMeasureSpec));
    }

    protected boolean setFrame(int left, int top, int right, int bottom) {
        boolean result = super.setFrame(left, top, right, bottom);
        updateWindow(DEBUG, DEBUG);
        return result;
    }

    public boolean gatherTransparentRegion(Region region) {
        if (this.mWindowType == LayoutParams.TYPE_APPLICATION_PANEL) {
            return super.gatherTransparentRegion(region);
        }
        boolean opaque = true;
        if ((this.mPrivateFlags & AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS) == 0) {
            opaque = super.gatherTransparentRegion(region);
        } else if (region != null) {
            int w = getWidth();
            int h = getHeight();
            if (w > 0 && h > 0) {
                getLocationInWindow(this.mLocation);
                int l = this.mLocation[0];
                int t = this.mLocation[KEEP_SCREEN_ON_MSG];
                region.op(l, t, l + w, t + h, Op.UNION);
            }
        }
        if (PixelFormat.formatHasAlpha(this.mRequestedFormat)) {
            return DEBUG;
        }
        return opaque;
    }

    public void draw(Canvas canvas) {
        if (this.mWindowType != LayoutParams.TYPE_APPLICATION_PANEL && (this.mPrivateFlags & AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS) == 0) {
            canvas.drawColor(0, Mode.CLEAR);
        }
        super.draw(canvas);
    }

    protected void dispatchDraw(Canvas canvas) {
        if (this.mWindowType != LayoutParams.TYPE_APPLICATION_PANEL && (this.mPrivateFlags & AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS) == AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS) {
            canvas.drawColor(0, Mode.CLEAR);
        }
        super.dispatchDraw(canvas);
    }

    public void setZOrderMediaOverlay(boolean isMediaOverlay) {
        this.mWindowType = isMediaOverlay ? LayoutParams.TYPE_APPLICATION_MEDIA_OVERLAY : LayoutParams.TYPE_APPLICATION_MEDIA;
    }

    public void setZOrderOnTop(boolean onTop) {
        if (onTop) {
            this.mWindowType = LayoutParams.TYPE_APPLICATION_PANEL;
            LayoutParams layoutParams = this.mLayout;
            layoutParams.flags |= AccessibilityNodeInfo.ACTION_SET_SELECTION;
            return;
        }
        this.mWindowType = LayoutParams.TYPE_APPLICATION_MEDIA;
        layoutParams = this.mLayout;
        layoutParams.flags &= -131073;
    }

    public void setSecure(boolean isSecure) {
        if (isSecure) {
            LayoutParams layoutParams = this.mLayout;
            layoutParams.flags |= AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD;
            return;
        }
        layoutParams = this.mLayout;
        layoutParams.flags &= -8193;
    }

    public void setWindowType(int type) {
        this.mWindowType = type;
    }

    protected void updateWindow(boolean force, boolean redrawNeeded) {
        if (this.mHaveFrame) {
            ViewRootImpl viewRoot = getViewRootImpl();
            if (viewRoot != null) {
                this.mTranslator = viewRoot.mTranslator;
            }
            if (this.mTranslator != null) {
                this.mSurface.setCompatibilityTranslator(this.mTranslator);
            }
            int myWidth = this.mRequestedWidth;
            if (myWidth <= 0) {
                myWidth = getWidth();
            }
            int myHeight = this.mRequestedHeight;
            if (myHeight <= 0) {
                myHeight = getHeight();
            }
            getLocationInWindow(this.mLocation);
            boolean creating = this.mWindow == null ? true : DEBUG;
            boolean formatChanged = this.mFormat != this.mRequestedFormat ? true : DEBUG;
            boolean sizeChanged = (this.mWidth == myWidth && this.mHeight == myHeight) ? DEBUG : true;
            boolean visibleChanged = this.mVisible != this.mRequestedVisible ? true : DEBUG;
            if (force || creating || formatChanged || sizeChanged || visibleChanged || this.mLeft != this.mLocation[0] || this.mTop != this.mLocation[KEEP_SCREEN_ON_MSG] || this.mUpdateWindowNeeded || this.mReportDrawNeeded || redrawNeeded) {
                try {
                    Callback[] arr$;
                    int len$;
                    int i$;
                    boolean visible = this.mRequestedVisible;
                    this.mVisible = visible;
                    this.mLeft = this.mLocation[0];
                    this.mTop = this.mLocation[KEEP_SCREEN_ON_MSG];
                    this.mWidth = myWidth;
                    this.mHeight = myHeight;
                    this.mFormat = this.mRequestedFormat;
                    this.mLayout.f95x = this.mLeft;
                    this.mLayout.f96y = this.mTop;
                    this.mLayout.width = getWidth();
                    this.mLayout.height = getHeight();
                    if (this.mTranslator != null) {
                        this.mTranslator.translateLayoutParamsInAppWindowToScreen(this.mLayout);
                    }
                    this.mLayout.format = this.mRequestedFormat;
                    LayoutParams layoutParams = this.mLayout;
                    layoutParams.flags |= 16920;
                    if (!getContext().getResources().getCompatibilityInfo().supportsScreen()) {
                        layoutParams = this.mLayout;
                        layoutParams.privateFlags |= AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
                    }
                    layoutParams = this.mLayout;
                    layoutParams.privateFlags |= 64;
                    if (this.mWindow == null) {
                        Display display = getDisplay();
                        this.mWindow = new MyWindow(this);
                        this.mLayout.type = this.mWindowType;
                        this.mLayout.gravity = 8388659;
                        this.mSession.addToDisplayWithoutInputChannel(this.mWindow, this.mWindow.mSeq, this.mLayout, this.mVisible ? 0 : 8, display.getDisplayId(), this.mContentInsets, this.mStableInsets);
                    }
                    this.mSurfaceLock.lock();
                    this.mUpdateWindowNeeded = DEBUG;
                    boolean reportDrawNeeded = this.mReportDrawNeeded;
                    this.mReportDrawNeeded = DEBUG;
                    this.mDrawingStopped = !visible ? true : DEBUG;
                    int relayoutResult = this.mSession.relayout(this.mWindow, this.mWindow.mSeq, this.mLayout, this.mWidth, this.mHeight, visible ? 0 : 8, GET_NEW_SURFACE_MSG, this.mWinFrame, this.mOverscanInsets, this.mContentInsets, this.mVisibleInsets, this.mStableInsets, this.mConfiguration, this.mNewSurface);
                    if ((relayoutResult & GET_NEW_SURFACE_MSG) != 0) {
                        this.mReportDrawNeeded = true;
                    }
                    this.mSurfaceFrame.left = 0;
                    this.mSurfaceFrame.top = 0;
                    if (this.mTranslator == null) {
                        this.mSurfaceFrame.right = this.mWinFrame.width();
                        this.mSurfaceFrame.bottom = this.mWinFrame.height();
                    } else {
                        float appInvertedScale = this.mTranslator.applicationInvertedScale;
                        this.mSurfaceFrame.right = (int) ((((float) this.mWinFrame.width()) * appInvertedScale) + 0.5f);
                        this.mSurfaceFrame.bottom = (int) ((((float) this.mWinFrame.height()) * appInvertedScale) + 0.5f);
                    }
                    int surfaceWidth = this.mSurfaceFrame.right;
                    int surfaceHeight = this.mSurfaceFrame.bottom;
                    boolean realSizeChanged = (this.mLastSurfaceWidth == surfaceWidth && this.mLastSurfaceHeight == surfaceHeight) ? DEBUG : true;
                    this.mLastSurfaceWidth = surfaceWidth;
                    this.mLastSurfaceHeight = surfaceHeight;
                    this.mSurfaceLock.unlock();
                    redrawNeeded |= creating | reportDrawNeeded;
                    Callback[] callbacks = null;
                    boolean surfaceChanged = (relayoutResult & 4) != 0 ? true : DEBUG;
                    if (this.mSurfaceCreated && (surfaceChanged || (!visible && visibleChanged))) {
                        this.mSurfaceCreated = DEBUG;
                        if (this.mSurface.isValid()) {
                            callbacks = getSurfaceCallbacks();
                            arr$ = callbacks;
                            len$ = arr$.length;
                            for (i$ = 0; i$ < len$; i$ += KEEP_SCREEN_ON_MSG) {
                                arr$[i$].surfaceDestroyed(this.mSurfaceHolder);
                            }
                        }
                    }
                    this.mSurface.transferFrom(this.mNewSurface);
                    if (visible && this.mSurface.isValid()) {
                        if (!this.mSurfaceCreated && (surfaceChanged || visibleChanged)) {
                            this.mSurfaceCreated = true;
                            this.mIsCreating = true;
                            if (callbacks == null) {
                                callbacks = getSurfaceCallbacks();
                            }
                            arr$ = callbacks;
                            len$ = arr$.length;
                            for (i$ = 0; i$ < len$; i$ += KEEP_SCREEN_ON_MSG) {
                                arr$[i$].surfaceCreated(this.mSurfaceHolder);
                            }
                        }
                        if (creating || formatChanged || sizeChanged || visibleChanged || realSizeChanged) {
                            if (callbacks == null) {
                                callbacks = getSurfaceCallbacks();
                            }
                            arr$ = callbacks;
                            len$ = arr$.length;
                            for (i$ = 0; i$ < len$; i$ += KEEP_SCREEN_ON_MSG) {
                                arr$[i$].surfaceChanged(this.mSurfaceHolder, this.mFormat, myWidth, myHeight);
                            }
                        }
                        if (redrawNeeded) {
                            if (callbacks == null) {
                                callbacks = getSurfaceCallbacks();
                            }
                            arr$ = callbacks;
                            len$ = arr$.length;
                            for (i$ = 0; i$ < len$; i$ += KEEP_SCREEN_ON_MSG) {
                                Callback c = arr$[i$];
                                if (c instanceof Callback2) {
                                    ((Callback2) c).surfaceRedrawNeeded(this.mSurfaceHolder);
                                }
                            }
                        }
                    }
                    this.mIsCreating = DEBUG;
                    if (redrawNeeded) {
                        this.mSession.finishDrawing(this.mWindow);
                    }
                    this.mSession.performDeferredDestroy(this.mWindow);
                } catch (RemoteException e) {
                } catch (Throwable th) {
                    this.mSurfaceLock.unlock();
                }
            }
        }
    }

    private Callback[] getSurfaceCallbacks() {
        Callback[] callbacks;
        synchronized (this.mCallbacks) {
            callbacks = new Callback[this.mCallbacks.size()];
            this.mCallbacks.toArray(callbacks);
        }
        return callbacks;
    }

    void handleGetNewSurface() {
        updateWindow(DEBUG, DEBUG);
    }

    public boolean isFixedSize() {
        return (this.mRequestedWidth == -1 && this.mRequestedHeight == -1) ? DEBUG : true;
    }
}
