package com.android.server.wm;

import android.content.Context;
import android.graphics.PixelFormat;
import android.graphics.Point;
import android.graphics.PointF;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Region;
import android.os.RemoteException;
import android.os.UserHandle;
import android.util.Slog;
import android.view.DisplayInfo;
import android.view.MagnificationSpec;
import android.view.Surface.OutOfResourcesException;
import android.view.SurfaceControl;
import android.view.SurfaceSession;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManagerPolicy;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.AnimationUtils;
import android.view.animation.Transformation;
import com.android.server.voiceinteraction.SoundTriggerHelper;
import java.io.PrintWriter;
import java.util.ArrayList;

class WindowStateAnimator {
    static final int COMMIT_DRAW_PENDING = 2;
    static final int DRAW_PENDING = 1;
    static final int HAS_DRAWN = 4;
    static final int NO_SURFACE = 0;
    static final int READY_TO_SHOW = 3;
    private static final int SYSTEM_UI_FLAGS_LAYOUT_STABLE_FULLSCREEN = 1280;
    static final String TAG = "WindowStateAnimator";
    float mAlpha;
    int mAnimDh;
    int mAnimDw;
    int mAnimLayer;
    boolean mAnimateMove;
    boolean mAnimating;
    Animation mAnimation;
    boolean mAnimationIsEntrance;
    long mAnimationStartTime;
    final WindowAnimator mAnimator;
    AppWindowAnimator mAppAnimator;
    final WindowStateAnimator mAttachedWinAnimator;
    int mAttrType;
    Rect mClipRect;
    final Context mContext;
    int mDrawState;
    float mDsDx;
    float mDsDy;
    float mDtDx;
    float mDtDy;
    boolean mEnterAnimationPending;
    boolean mEnteringAnimation;
    boolean mFullyTransparent;
    boolean mHasClipRect;
    boolean mHasLocalTransformation;
    boolean mHasTransformation;
    boolean mHaveMatrix;
    final boolean mIsWallpaper;
    boolean mKeyguardGoingAwayAnimation;
    float mLastAlpha;
    long mLastAnimationTime;
    Rect mLastClipRect;
    float mLastDsDx;
    float mLastDsDy;
    float mLastDtDx;
    float mLastDtDy;
    boolean mLastHidden;
    int mLastLayer;
    boolean mLocalAnimating;
    SurfaceControl mPendingDestroySurface;
    final WindowManagerPolicy mPolicy;
    final WindowManagerService mService;
    final Session mSession;
    float mShownAlpha;
    float mSurfaceAlpha;
    SurfaceControl mSurfaceControl;
    boolean mSurfaceDestroyDeferred;
    float mSurfaceH;
    int mSurfaceLayer;
    boolean mSurfaceResized;
    boolean mSurfaceShown;
    float mSurfaceW;
    float mSurfaceX;
    float mSurfaceY;
    Rect mTmpClipRect;
    final Transformation mTransformation;
    final Transformation mUniverseTransform;
    boolean mWasAnimating;
    final WindowState mWin;

    static class SurfaceTrace extends SurfaceControl {
        private static final String SURFACE_TAG = "SurfaceTrace";
        private static final boolean logSurfaceTrace = false;
        static final ArrayList<SurfaceTrace> sSurfaces;
        private float mDsdx;
        private float mDsdy;
        private float mDtdx;
        private float mDtdy;
        private boolean mIsOpaque;
        private int mLayer;
        private int mLayerStack;
        private final String mName;
        private final PointF mPosition;
        private boolean mShown;
        private final Point mSize;
        private float mSurfaceTraceAlpha;
        private final Rect mWindowCrop;

        static {
            sSurfaces = new ArrayList();
        }

        public SurfaceTrace(SurfaceSession s, String name, int w, int h, int format, int flags) throws OutOfResourcesException {
            super(s, name, w, h, format, flags);
            this.mSurfaceTraceAlpha = 0.0f;
            this.mPosition = new PointF();
            this.mSize = new Point();
            this.mWindowCrop = new Rect();
            this.mShown = false;
            if (name == null) {
                name = "Not named";
            }
            this.mName = name;
            this.mSize.set(w, h);
            synchronized (sSurfaces) {
                sSurfaces.add(WindowStateAnimator.NO_SURFACE, this);
            }
        }

        public void setAlpha(float alpha) {
            if (this.mSurfaceTraceAlpha != alpha) {
                this.mSurfaceTraceAlpha = alpha;
            }
            super.setAlpha(alpha);
        }

        public void setLayer(int zorder) {
            if (zorder != this.mLayer) {
                this.mLayer = zorder;
            }
            super.setLayer(zorder);
            synchronized (sSurfaces) {
                sSurfaces.remove(this);
                int i = sSurfaces.size() - 1;
                while (i >= 0 && ((SurfaceTrace) sSurfaces.get(i)).mLayer >= zorder) {
                    i--;
                }
                sSurfaces.add(i + WindowStateAnimator.DRAW_PENDING, this);
            }
        }

        public void setPosition(float x, float y) {
            if (!(x == this.mPosition.x && y == this.mPosition.y)) {
                this.mPosition.set(x, y);
            }
            super.setPosition(x, y);
        }

        public void setSize(int w, int h) {
            if (!(w == this.mSize.x && h == this.mSize.y)) {
                this.mSize.set(w, h);
            }
            super.setSize(w, h);
        }

        public void setWindowCrop(Rect crop) {
            if (!(crop == null || crop.equals(this.mWindowCrop))) {
                this.mWindowCrop.set(crop);
            }
            super.setWindowCrop(crop);
        }

        public void setLayerStack(int layerStack) {
            if (layerStack != this.mLayerStack) {
                this.mLayerStack = layerStack;
            }
            super.setLayerStack(layerStack);
        }

        public void setOpaque(boolean isOpaque) {
            if (isOpaque != this.mIsOpaque) {
                this.mIsOpaque = isOpaque;
            }
            super.setOpaque(isOpaque);
        }

        public void setMatrix(float dsdx, float dtdx, float dsdy, float dtdy) {
            if (!(dsdx == this.mDsdx && dtdx == this.mDtdx && dsdy == this.mDsdy && dtdy == this.mDtdy)) {
                this.mDsdx = dsdx;
                this.mDtdx = dtdx;
                this.mDsdy = dsdy;
                this.mDtdy = dtdy;
            }
            super.setMatrix(dsdx, dtdx, dsdy, dtdy);
        }

        public void hide() {
            if (this.mShown) {
                this.mShown = false;
            }
            super.hide();
        }

        public void show() {
            if (!this.mShown) {
                this.mShown = true;
            }
            super.show();
        }

        public void destroy() {
            super.destroy();
            synchronized (sSurfaces) {
                sSurfaces.remove(this);
            }
        }

        public void release() {
            super.release();
            synchronized (sSurfaces) {
                sSurfaces.remove(this);
            }
        }

        static void dumpAllSurfaces(PrintWriter pw, String header) {
            synchronized (sSurfaces) {
                int N = sSurfaces.size();
                if (N <= 0) {
                    return;
                }
                if (header != null) {
                    pw.println(header);
                }
                pw.println("WINDOW MANAGER SURFACES (dumpsys window surfaces)");
                for (int i = WindowStateAnimator.NO_SURFACE; i < N; i += WindowStateAnimator.DRAW_PENDING) {
                    SurfaceTrace s = (SurfaceTrace) sSurfaces.get(i);
                    pw.print("  Surface #");
                    pw.print(i);
                    pw.print(": #");
                    pw.print(Integer.toHexString(System.identityHashCode(s)));
                    pw.print(" ");
                    pw.println(s.mName);
                    pw.print("    mLayerStack=");
                    pw.print(s.mLayerStack);
                    pw.print(" mLayer=");
                    pw.println(s.mLayer);
                    pw.print("    mShown=");
                    pw.print(s.mShown);
                    pw.print(" mAlpha=");
                    pw.print(s.mSurfaceTraceAlpha);
                    pw.print(" mIsOpaque=");
                    pw.println(s.mIsOpaque);
                    pw.print("    mPosition=");
                    pw.print(s.mPosition.x);
                    pw.print(",");
                    pw.print(s.mPosition.y);
                    pw.print(" mSize=");
                    pw.print(s.mSize.x);
                    pw.print("x");
                    pw.println(s.mSize.y);
                    pw.print("    mCrop=");
                    s.mWindowCrop.printShortString(pw);
                    pw.println();
                    pw.print("    Transform: (");
                    pw.print(s.mDsdx);
                    pw.print(", ");
                    pw.print(s.mDtdx);
                    pw.print(", ");
                    pw.print(s.mDsdy);
                    pw.print(", ");
                    pw.print(s.mDtdy);
                    pw.println(")");
                }
            }
        }

        public String toString() {
            return "Surface " + Integer.toHexString(System.identityHashCode(this)) + " " + this.mName + " (" + this.mLayerStack + "): shown=" + this.mShown + " layer=" + this.mLayer + " alpha=" + this.mSurfaceTraceAlpha + " " + this.mPosition.x + "," + this.mPosition.y + " " + this.mSize.x + "x" + this.mSize.y + " crop=" + this.mWindowCrop.toShortString() + " opaque=" + this.mIsOpaque + " (" + this.mDsdx + "," + this.mDtdx + "," + this.mDsdy + "," + this.mDtdy + ")";
        }
    }

    String drawStateToString() {
        switch (this.mDrawState) {
            case NO_SURFACE /*0*/:
                return "NO_SURFACE";
            case DRAW_PENDING /*1*/:
                return "DRAW_PENDING";
            case COMMIT_DRAW_PENDING /*2*/:
                return "COMMIT_DRAW_PENDING";
            case READY_TO_SHOW /*3*/:
                return "READY_TO_SHOW";
            case HAS_DRAWN /*4*/:
                return "HAS_DRAWN";
            default:
                return Integer.toString(this.mDrawState);
        }
    }

    public WindowStateAnimator(WindowState win) {
        AppWindowAnimator appWindowAnimator = null;
        this.mUniverseTransform = new Transformation();
        this.mTransformation = new Transformation();
        this.mShownAlpha = 0.0f;
        this.mAlpha = 0.0f;
        this.mLastAlpha = 0.0f;
        this.mClipRect = new Rect();
        this.mTmpClipRect = new Rect();
        this.mLastClipRect = new Rect();
        this.mAnimateMove = false;
        this.mDsDx = 1.0f;
        this.mDtDx = 0.0f;
        this.mDsDy = 0.0f;
        this.mDtDy = 1.0f;
        this.mLastDsDx = 1.0f;
        this.mLastDtDx = 0.0f;
        this.mLastDsDy = 0.0f;
        this.mLastDtDy = 1.0f;
        WindowManagerService service = win.mService;
        this.mService = service;
        this.mAnimator = service.mAnimator;
        this.mPolicy = service.mPolicy;
        this.mContext = service.mContext;
        DisplayContent displayContent = win.getDisplayContent();
        if (displayContent != null) {
            DisplayInfo displayInfo = displayContent.getDisplayInfo();
            this.mAnimDw = displayInfo.appWidth;
            this.mAnimDh = displayInfo.appHeight;
        } else {
            Slog.w(TAG, "WindowStateAnimator ctor: Display has been removed");
        }
        this.mWin = win;
        this.mAttachedWinAnimator = win.mAttachedWindow == null ? null : win.mAttachedWindow.mWinAnimator;
        if (win.mAppToken != null) {
            appWindowAnimator = win.mAppToken.mAppAnimator;
        }
        this.mAppAnimator = appWindowAnimator;
        this.mSession = win.mSession;
        this.mAttrType = win.mAttrs.type;
        this.mIsWallpaper = win.mIsWallpaper;
    }

    public void setAnimation(Animation anim, long startTime) {
        this.mAnimating = false;
        this.mLocalAnimating = false;
        this.mAnimation = anim;
        this.mAnimation.restrictDuration(10000);
        this.mAnimation.scaleCurrentDuration(this.mService.getWindowAnimationScaleLocked());
        this.mTransformation.clear();
        this.mTransformation.setAlpha(this.mLastHidden ? 0.0f : 1.0f);
        this.mHasLocalTransformation = true;
        this.mAnimationStartTime = startTime;
    }

    public void setAnimation(Animation anim) {
        setAnimation(anim, -1);
    }

    public void clearAnimation() {
        if (this.mAnimation != null) {
            this.mAnimating = true;
            this.mLocalAnimating = false;
            this.mAnimation.cancel();
            this.mAnimation = null;
            this.mKeyguardGoingAwayAnimation = false;
        }
    }

    boolean isAnimating() {
        return this.mAnimation != null || (!(this.mAttachedWinAnimator == null || this.mAttachedWinAnimator.mAnimation == null) || (this.mAppAnimator != null && (this.mAppAnimator.animation != null || this.mAppAnimator.mAppToken.inPendingTransaction)));
    }

    boolean isDummyAnimation() {
        return this.mAppAnimator != null && this.mAppAnimator.animation == AppWindowAnimator.sDummyAnimation;
    }

    boolean isWindowAnimating() {
        return this.mAnimation != null;
    }

    void cancelExitAnimationForNextAnimationLocked() {
        if (this.mAnimation != null) {
            this.mAnimation.cancel();
            this.mAnimation = null;
            this.mLocalAnimating = false;
            destroySurfaceLocked();
        }
    }

    private boolean stepAnimation(long currentTime) {
        if (this.mAnimation == null || !this.mLocalAnimating) {
            return false;
        }
        this.mTransformation.clear();
        return this.mAnimation.getTransformation(currentTime, this.mTransformation);
    }

    boolean stepAnimationLocked(long currentTime) {
        this.mWasAnimating = this.mAnimating;
        DisplayContent displayContent = this.mWin.getDisplayContent();
        if (displayContent != null && this.mService.okToDisplay()) {
            if (this.mWin.isDrawnLw() && this.mAnimation != null) {
                this.mHasTransformation = true;
                this.mHasLocalTransformation = true;
                if (!this.mLocalAnimating) {
                    long j;
                    DisplayInfo displayInfo = displayContent.getDisplayInfo();
                    if (this.mAnimateMove) {
                        this.mAnimateMove = false;
                        this.mAnimation.initialize(this.mWin.mFrame.width(), this.mWin.mFrame.height(), this.mAnimDw, this.mAnimDh);
                    } else {
                        this.mAnimation.initialize(this.mWin.mFrame.width(), this.mWin.mFrame.height(), displayInfo.appWidth, displayInfo.appHeight);
                    }
                    this.mAnimDw = displayInfo.appWidth;
                    this.mAnimDh = displayInfo.appHeight;
                    Animation animation = this.mAnimation;
                    if (this.mAnimationStartTime != -1) {
                        j = this.mAnimationStartTime;
                    } else {
                        j = currentTime;
                    }
                    animation.setStartTime(j);
                    this.mLocalAnimating = true;
                    this.mAnimating = true;
                }
                if (this.mAnimation != null && this.mLocalAnimating) {
                    this.mLastAnimationTime = currentTime;
                    if (stepAnimation(currentTime)) {
                        return true;
                    }
                }
            }
            this.mHasLocalTransformation = false;
            if ((!this.mLocalAnimating || this.mAnimationIsEntrance) && this.mAppAnimator != null && this.mAppAnimator.animation != null) {
                this.mAnimating = true;
                this.mHasTransformation = true;
                this.mTransformation.clear();
                return false;
            } else if (this.mHasTransformation) {
                this.mAnimating = true;
            } else if (isAnimating()) {
                this.mAnimating = true;
            }
        } else if (this.mAnimation != null) {
            this.mAnimating = true;
        }
        if (!this.mAnimating && !this.mLocalAnimating) {
            return false;
        }
        this.mAnimating = false;
        this.mKeyguardGoingAwayAnimation = false;
        this.mLocalAnimating = false;
        if (this.mAnimation != null) {
            this.mAnimation.cancel();
            this.mAnimation = null;
        }
        if (this.mAnimator.mWindowDetachedWallpaper == this.mWin) {
            this.mAnimator.mWindowDetachedWallpaper = null;
        }
        this.mAnimLayer = this.mWin.mLayer;
        if (this.mWin.mIsImWindow) {
            this.mAnimLayer += this.mService.mInputMethodAnimLayerAdjustment;
        } else if (this.mIsWallpaper) {
            this.mAnimLayer += this.mService.mWallpaperAnimLayerAdjustment;
        }
        this.mHasTransformation = false;
        this.mHasLocalTransformation = false;
        if (this.mWin.mPolicyVisibility != this.mWin.mPolicyVisibilityAfterAnim) {
            this.mWin.mPolicyVisibility = this.mWin.mPolicyVisibilityAfterAnim;
            if (displayContent != null) {
                displayContent.layoutNeeded = true;
            }
            if (!this.mWin.mPolicyVisibility) {
                if (this.mService.mCurrentFocus == this.mWin) {
                    this.mService.mFocusMayChange = true;
                }
                this.mService.enableScreenIfNeededLocked();
            }
        }
        this.mTransformation.clear();
        if (this.mDrawState == HAS_DRAWN && this.mWin.mAttrs.type == READY_TO_SHOW && this.mWin.mAppToken != null && this.mWin.mAppToken.firstWindowDrawn && this.mWin.mAppToken.startingData != null) {
            this.mService.mFinishedStarting.add(this.mWin.mAppToken);
            this.mService.mH.sendEmptyMessage(7);
        } else if (this.mAttrType == 2000 && this.mWin.mPolicyVisibility && displayContent != null) {
            displayContent.layoutNeeded = true;
        }
        finishExit();
        int displayId = this.mWin.getDisplayId();
        this.mAnimator.setPendingLayoutChanges(displayId, 8);
        this.mService.debugLayoutRepeats(TAG, this.mAnimator.getPendingLayoutChanges(displayId));
        if (this.mWin.mAppToken != null) {
            this.mWin.mAppToken.updateReportedVisibilityLocked();
        }
        return false;
    }

    void finishExit() {
        int N = this.mWin.mChildWindows.size();
        for (int i = NO_SURFACE; i < N; i += DRAW_PENDING) {
            ((WindowState) this.mWin.mChildWindows.get(i)).mWinAnimator.finishExit();
        }
        if (this.mEnteringAnimation && this.mWin.mAppToken == null) {
            try {
                this.mEnteringAnimation = false;
                this.mWin.mClient.dispatchWindowShown();
            } catch (RemoteException e) {
            }
        }
        if (!(isWindowAnimating() || this.mService.mAccessibilityController == null || this.mWin.getDisplayId() != 0)) {
            this.mService.mAccessibilityController.onSomeWindowResizedOrMovedLocked();
        }
        if (this.mWin.mExiting && !isWindowAnimating()) {
            if (this.mSurfaceControl != null) {
                this.mService.mDestroySurface.add(this.mWin);
                this.mWin.mDestroying = true;
                hide();
            }
            this.mWin.mExiting = false;
            if (this.mWin.mRemoveOnExit) {
                this.mService.mPendingRemove.add(this.mWin);
                this.mWin.mRemoveOnExit = false;
            }
            this.mAnimator.hideWallpapersLocked(this.mWin);
        }
    }

    void hide() {
        if (!this.mLastHidden) {
            this.mLastHidden = true;
            if (this.mSurfaceControl != null) {
                this.mSurfaceShown = false;
                try {
                    this.mSurfaceControl.hide();
                } catch (RuntimeException e) {
                    Slog.w(TAG, "Exception hiding surface in " + this.mWin);
                }
            }
        }
    }

    boolean finishDrawingLocked() {
        boolean startingWindow;
        if (this.mWin.mAttrs.type == READY_TO_SHOW) {
            startingWindow = true;
        } else {
            startingWindow = false;
        }
        if (this.mDrawState != DRAW_PENDING) {
            return false;
        }
        this.mDrawState = COMMIT_DRAW_PENDING;
        return true;
    }

    boolean commitFinishDrawingLocked(long currentTime) {
        if (this.mDrawState != COMMIT_DRAW_PENDING && this.mDrawState != READY_TO_SHOW) {
            return false;
        }
        this.mDrawState = READY_TO_SHOW;
        AppWindowToken atoken = this.mWin.mAppToken;
        if (atoken == null || atoken.allDrawn || this.mWin.mAttrs.type == READY_TO_SHOW) {
            return performShowLocked();
        }
        return false;
    }

    SurfaceControl createSurfaceLocked() {
        WindowState w = this.mWin;
        if (this.mSurfaceControl == null) {
            int width;
            int height;
            this.mDrawState = DRAW_PENDING;
            if (w.mAppToken != null) {
                if (w.mAppToken.mAppAnimator.animation == null) {
                    w.mAppToken.allDrawn = false;
                    w.mAppToken.deferClearAllDrawn = false;
                } else {
                    w.mAppToken.deferClearAllDrawn = true;
                }
            }
            this.mService.makeWindowFreezingScreenIfNeededLocked(w);
            int flags = HAS_DRAWN;
            LayoutParams attrs = w.mAttrs;
            if ((attrs.flags & DumpState.DUMP_INSTALLS) != 0) {
                flags = HAS_DRAWN | DumpState.DUMP_PROVIDERS;
            }
            if (this.mService.isScreenCaptureDisabledLocked(UserHandle.getUserId(this.mWin.mOwnerUid))) {
                flags |= DumpState.DUMP_PROVIDERS;
            }
            boolean consumingNavBar = (attrs.flags & SoundTriggerHelper.STATUS_ERROR) != 0 && (attrs.systemUiVisibility & DumpState.DUMP_PREFERRED) == 0 && (attrs.systemUiVisibility & COMMIT_DRAW_PENDING) == 0;
            DisplayContent displayContent = w.getDisplayContent();
            int defaultWidth = DRAW_PENDING;
            int defaultHeight = DRAW_PENDING;
            if (displayContent != null) {
                DisplayInfo displayInfo = displayContent.getDisplayInfo();
                defaultWidth = consumingNavBar ? displayInfo.logicalWidth : displayInfo.appWidth;
                defaultHeight = consumingNavBar ? displayInfo.logicalHeight : displayInfo.appHeight;
            }
            if ((attrs.flags & 16384) != 0) {
                width = w.mRequestedWidth;
                height = w.mRequestedHeight;
            } else {
                width = consumingNavBar ? defaultWidth : w.mCompatFrame.width();
                if (consumingNavBar) {
                    height = defaultHeight;
                } else {
                    height = w.mCompatFrame.height();
                }
            }
            if (width <= 0) {
                width = defaultWidth;
            }
            if (height <= 0) {
                height = defaultHeight;
            }
            width += attrs.surfaceInsets.left + attrs.surfaceInsets.right;
            height += attrs.surfaceInsets.top + attrs.surfaceInsets.bottom;
            float left = ((float) (w.mFrame.left + w.mXOffset)) - ((float) attrs.surfaceInsets.left);
            float top = ((float) (w.mFrame.top + w.mYOffset)) - ((float) attrs.surfaceInsets.top);
            this.mSurfaceShown = false;
            this.mSurfaceLayer = NO_SURFACE;
            this.mSurfaceAlpha = 0.0f;
            this.mSurfaceX = 0.0f;
            this.mSurfaceY = 0.0f;
            w.mLastSystemDecorRect.set(NO_SURFACE, NO_SURFACE, NO_SURFACE, NO_SURFACE);
            this.mLastClipRect.set(NO_SURFACE, NO_SURFACE, NO_SURFACE, NO_SURFACE);
            try {
                this.mSurfaceW = (float) width;
                this.mSurfaceH = (float) height;
                int format = (attrs.flags & 16777216) != 0 ? -3 : attrs.format;
                if (!PixelFormat.formatHasAlpha(attrs.format) && attrs.surfaceInsets.left == 0 && attrs.surfaceInsets.top == 0 && attrs.surfaceInsets.right == 0 && attrs.surfaceInsets.bottom == 0) {
                    flags |= DumpState.DUMP_PREFERRED_XML;
                }
                this.mSurfaceControl = new SurfaceControl(this.mSession.mSurfaceSession, attrs.getTitle().toString(), width, height, format, flags);
                w.mHasSurface = true;
                SurfaceControl.openTransaction();
                try {
                    this.mSurfaceX = left;
                    this.mSurfaceY = top;
                    this.mSurfaceControl.setPosition(left, top);
                    this.mSurfaceLayer = this.mAnimLayer;
                    if (displayContent != null) {
                        this.mSurfaceControl.setLayerStack(displayContent.getDisplay().getLayerStack());
                    }
                    this.mSurfaceControl.setLayer(this.mAnimLayer);
                    this.mSurfaceControl.setAlpha(0.0f);
                    this.mSurfaceShown = false;
                } catch (RuntimeException e) {
                    Slog.w(TAG, "Error creating surface in " + w, e);
                    this.mService.reclaimSomeSurfaceMemoryLocked(this, "create-init", true);
                } catch (Throwable th) {
                    SurfaceControl.closeTransaction();
                }
                this.mLastHidden = true;
                SurfaceControl.closeTransaction();
            } catch (OutOfResourcesException e2) {
                w.mHasSurface = false;
                Slog.w(TAG, "OutOfResourcesException creating surface");
                this.mService.reclaimSomeSurfaceMemoryLocked(this, "create", true);
                this.mDrawState = NO_SURFACE;
                return null;
            } catch (Exception e3) {
                w.mHasSurface = false;
                Slog.e(TAG, "Exception creating surface", e3);
                this.mDrawState = NO_SURFACE;
                return null;
            }
        }
        return this.mSurfaceControl;
    }

    void destroySurfaceLocked() {
        if (this.mWin.mAppToken != null && this.mWin == this.mWin.mAppToken.startingWindow) {
            this.mWin.mAppToken.startingDisplayed = false;
        }
        if (this.mSurfaceControl != null) {
            int i = this.mWin.mChildWindows.size();
            while (i > 0) {
                i--;
                ((WindowState) this.mWin.mChildWindows.get(i)).mAttachedHidden = true;
            }
            try {
                if (!this.mSurfaceDestroyDeferred) {
                    this.mSurfaceControl.destroy();
                } else if (!(this.mSurfaceControl == null || this.mPendingDestroySurface == this.mSurfaceControl)) {
                    if (this.mPendingDestroySurface != null) {
                        this.mPendingDestroySurface.destroy();
                    }
                    this.mPendingDestroySurface = this.mSurfaceControl;
                }
                this.mAnimator.hideWallpapersLocked(this.mWin);
            } catch (RuntimeException e) {
                Slog.w(TAG, "Exception thrown when destroying Window " + this + " surface " + this.mSurfaceControl + " session " + this.mSession + ": " + e.toString());
            }
            this.mSurfaceShown = false;
            this.mSurfaceControl = null;
            this.mWin.mHasSurface = false;
            this.mDrawState = NO_SURFACE;
        }
    }

    void destroyDeferredSurfaceLocked() {
        try {
            if (this.mPendingDestroySurface != null) {
                this.mPendingDestroySurface.destroy();
                this.mAnimator.hideWallpapersLocked(this.mWin);
            }
        } catch (RuntimeException e) {
            Slog.w(TAG, "Exception thrown when destroying Window " + this + " surface " + this.mPendingDestroySurface + " session " + this.mSession + ": " + e.toString());
        }
        this.mSurfaceDestroyDeferred = false;
        this.mPendingDestroySurface = null;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void computeShownFrameLocked() {
        /*
        r28 = this;
        r0 = r28;
        r13 = r0.mHasLocalTransformation;
        r0 = r28;
        r0 = r0.mAttachedWinAnimator;
        r23 = r0;
        if (r23 == 0) goto L_0x04b1;
    L_0x000c:
        r0 = r28;
        r0 = r0.mAttachedWinAnimator;
        r23 = r0;
        r0 = r23;
        r0 = r0.mHasLocalTransformation;
        r23 = r0;
        if (r23 == 0) goto L_0x04b1;
    L_0x001a:
        r0 = r28;
        r0 = r0.mAttachedWinAnimator;
        r23 = r0;
        r0 = r23;
        r7 = r0.mTransformation;
    L_0x0024:
        r0 = r28;
        r0 = r0.mAppAnimator;
        r23 = r0;
        if (r23 == 0) goto L_0x04b4;
    L_0x002c:
        r0 = r28;
        r0 = r0.mAppAnimator;
        r23 = r0;
        r0 = r23;
        r0 = r0.hasTransformation;
        r23 = r0;
        if (r23 == 0) goto L_0x04b4;
    L_0x003a:
        r0 = r28;
        r0 = r0.mAppAnimator;
        r23 = r0;
        r0 = r23;
        r5 = r0.transformation;
    L_0x0044:
        r0 = r28;
        r0 = r0.mService;
        r23 = r0;
        r0 = r23;
        r0 = r0.mWallpaperTarget;
        r19 = r0;
        r0 = r28;
        r0 = r0.mIsWallpaper;
        r23 = r0;
        if (r23 == 0) goto L_0x00ba;
    L_0x0058:
        if (r19 == 0) goto L_0x00ba;
    L_0x005a:
        r0 = r28;
        r0 = r0.mService;
        r23 = r0;
        r0 = r23;
        r0 = r0.mAnimateWallpaperWithTarget;
        r23 = r0;
        if (r23 == 0) goto L_0x00ba;
    L_0x0068:
        r0 = r19;
        r0 = r0.mWinAnimator;
        r18 = r0;
        r0 = r18;
        r0 = r0.mHasLocalTransformation;
        r23 = r0;
        if (r23 == 0) goto L_0x008e;
    L_0x0076:
        r0 = r18;
        r0 = r0.mAnimation;
        r23 = r0;
        if (r23 == 0) goto L_0x008e;
    L_0x007e:
        r0 = r18;
        r0 = r0.mAnimation;
        r23 = r0;
        r23 = r23.getDetachWallpaper();
        if (r23 != 0) goto L_0x008e;
    L_0x008a:
        r0 = r18;
        r7 = r0.mTransformation;
    L_0x008e:
        r0 = r19;
        r0 = r0.mAppToken;
        r23 = r0;
        if (r23 != 0) goto L_0x04b7;
    L_0x0096:
        r20 = 0;
    L_0x0098:
        if (r20 == 0) goto L_0x00ba;
    L_0x009a:
        r0 = r20;
        r0 = r0.hasTransformation;
        r23 = r0;
        if (r23 == 0) goto L_0x00ba;
    L_0x00a2:
        r0 = r20;
        r0 = r0.animation;
        r23 = r0;
        if (r23 == 0) goto L_0x00ba;
    L_0x00aa:
        r0 = r20;
        r0 = r0.animation;
        r23 = r0;
        r23 = r23.getDetachWallpaper();
        if (r23 != 0) goto L_0x00ba;
    L_0x00b6:
        r0 = r20;
        r5 = r0.transformation;
    L_0x00ba:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r8 = r23.getDisplayId();
        r0 = r28;
        r0 = r0.mAnimator;
        r23 = r0;
        r0 = r23;
        r12 = r0.getScreenRotationAnimationLocked(r8);
        if (r12 == 0) goto L_0x04c5;
    L_0x00d2:
        r23 = r12.isAnimating();
        if (r23 == 0) goto L_0x04c5;
    L_0x00d8:
        r11 = 1;
    L_0x00d9:
        if (r13 != 0) goto L_0x00e1;
    L_0x00db:
        if (r7 != 0) goto L_0x00e1;
    L_0x00dd:
        if (r5 != 0) goto L_0x00e1;
    L_0x00df:
        if (r11 == 0) goto L_0x04d2;
    L_0x00e1:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r9 = r0.mFrame;
        r0 = r28;
        r0 = r0.mService;
        r23 = r0;
        r0 = r23;
        r15 = r0.mTmpFloats;
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mTmpMatrix;
        r16 = r0;
        if (r11 == 0) goto L_0x04cd;
    L_0x0103:
        r23 = r12.isRotating();
        if (r23 == 0) goto L_0x04cd;
    L_0x0109:
        r23 = r9.width();
        r0 = r23;
        r0 = (float) r0;
        r17 = r0;
        r23 = r9.height();
        r0 = r23;
        r10 = (float) r0;
        r23 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r23 = (r17 > r23 ? 1 : (r17 == r23 ? 0 : -1));
        if (r23 < 0) goto L_0x04c8;
    L_0x011f:
        r23 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r23 = (r10 > r23 ? 1 : (r10 == r23 ? 0 : -1));
        if (r23 < 0) goto L_0x04c8;
    L_0x0125:
        r23 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r24 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r24 = r24 / r17;
        r23 = r23 + r24;
        r24 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r25 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r25 = r25 / r10;
        r24 = r24 + r25;
        r25 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r25 = r17 / r25;
        r26 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r26 = r10 / r26;
        r0 = r16;
        r1 = r23;
        r2 = r24;
        r3 = r25;
        r4 = r26;
        r0.setScale(r1, r2, r3, r4);
    L_0x014a:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mGlobalScale;
        r23 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r24 = r0;
        r0 = r24;
        r0 = r0.mGlobalScale;
        r24 = r0;
        r0 = r16;
        r1 = r23;
        r2 = r24;
        r0.postScale(r1, r2);
        if (r13 == 0) goto L_0x017e;
    L_0x016d:
        r0 = r28;
        r0 = r0.mTransformation;
        r23 = r0;
        r23 = r23.getMatrix();
        r0 = r16;
        r1 = r23;
        r0.postConcat(r1);
    L_0x017e:
        r0 = r9.left;
        r23 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r24 = r0;
        r0 = r24;
        r0 = r0.mXOffset;
        r24 = r0;
        r23 = r23 + r24;
        r0 = r23;
        r0 = (float) r0;
        r23 = r0;
        r0 = r9.top;
        r24 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r25 = r0;
        r0 = r25;
        r0 = r0.mYOffset;
        r25 = r0;
        r24 = r24 + r25;
        r0 = r24;
        r0 = (float) r0;
        r24 = r0;
        r0 = r16;
        r1 = r23;
        r2 = r24;
        r0.postTranslate(r1, r2);
        if (r7 == 0) goto L_0x01c2;
    L_0x01b7:
        r23 = r7.getMatrix();
        r0 = r16;
        r1 = r23;
        r0.postConcat(r1);
    L_0x01c2:
        if (r5 == 0) goto L_0x01cf;
    L_0x01c4:
        r23 = r5.getMatrix();
        r0 = r16;
        r1 = r23;
        r0.postConcat(r1);
    L_0x01cf:
        r0 = r28;
        r0 = r0.mAnimator;
        r23 = r0;
        r0 = r23;
        r0 = r0.mUniverseBackground;
        r23 = r0;
        if (r23 == 0) goto L_0x01fa;
    L_0x01dd:
        r0 = r28;
        r0 = r0.mAnimator;
        r23 = r0;
        r0 = r23;
        r0 = r0.mUniverseBackground;
        r23 = r0;
        r0 = r23;
        r0 = r0.mUniverseTransform;
        r23 = r0;
        r23 = r23.getMatrix();
        r0 = r16;
        r1 = r23;
        r0.postConcat(r1);
    L_0x01fa:
        if (r11 == 0) goto L_0x020b;
    L_0x01fc:
        r23 = r12.getEnterTransformation();
        r23 = r23.getMatrix();
        r0 = r16;
        r1 = r23;
        r0.postConcat(r1);
    L_0x020b:
        r0 = r28;
        r0 = r0.mService;
        r23 = r0;
        r0 = r23;
        r0 = r0.mAccessibilityController;
        r23 = r0;
        if (r23 == 0) goto L_0x025b;
    L_0x0219:
        if (r8 != 0) goto L_0x025b;
    L_0x021b:
        r0 = r28;
        r0 = r0.mService;
        r23 = r0;
        r0 = r23;
        r0 = r0.mAccessibilityController;
        r23 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r24 = r0;
        r14 = r23.getMagnificationSpecForWindowLocked(r24);
        if (r14 == 0) goto L_0x025b;
    L_0x0233:
        r23 = r14.isNop();
        if (r23 != 0) goto L_0x025b;
    L_0x0239:
        r0 = r14.scale;
        r23 = r0;
        r0 = r14.scale;
        r24 = r0;
        r0 = r16;
        r1 = r23;
        r2 = r24;
        r0.postScale(r1, r2);
        r0 = r14.offsetX;
        r23 = r0;
        r0 = r14.offsetY;
        r24 = r0;
        r0 = r16;
        r1 = r23;
        r2 = r24;
        r0.postTranslate(r1, r2);
    L_0x025b:
        r23 = 1;
        r0 = r23;
        r1 = r28;
        r1.mHaveMatrix = r0;
        r0 = r16;
        r0.getValues(r15);
        r23 = 0;
        r23 = r15[r23];
        r0 = r23;
        r1 = r28;
        r1.mDsDx = r0;
        r23 = 3;
        r23 = r15[r23];
        r0 = r23;
        r1 = r28;
        r1.mDtDx = r0;
        r23 = 1;
        r23 = r15[r23];
        r0 = r23;
        r1 = r28;
        r1.mDsDy = r0;
        r23 = 4;
        r23 = r15[r23];
        r0 = r23;
        r1 = r28;
        r1.mDtDy = r0;
        r23 = 2;
        r21 = r15[r23];
        r23 = 5;
        r22 = r15[r23];
        r17 = r9.width();
        r10 = r9.height();
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mShownFrame;
        r23 = r0;
        r0 = r17;
        r0 = (float) r0;
        r24 = r0;
        r24 = r24 + r21;
        r0 = (float) r10;
        r25 = r0;
        r25 = r25 + r22;
        r0 = r23;
        r1 = r21;
        r2 = r22;
        r3 = r24;
        r4 = r25;
        r0.set(r1, r2, r3, r4);
        r0 = r28;
        r0 = r0.mAlpha;
        r23 = r0;
        r0 = r23;
        r1 = r28;
        r1.mShownAlpha = r0;
        r23 = 0;
        r0 = r23;
        r1 = r28;
        r1.mHasClipRect = r0;
        r0 = r28;
        r0 = r0.mService;
        r23 = r0;
        r0 = r23;
        r0 = r0.mLimitedAlphaCompositing;
        r23 = r0;
        if (r23 == 0) goto L_0x033d;
    L_0x02e7:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mAttrs;
        r23 = r0;
        r0 = r23;
        r0 = r0.format;
        r23 = r0;
        r23 = android.graphics.PixelFormat.formatHasAlpha(r23);
        if (r23 == 0) goto L_0x033d;
    L_0x02ff:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r28;
        r0 = r0.mDsDx;
        r24 = r0;
        r0 = r28;
        r0 = r0.mDtDx;
        r25 = r0;
        r0 = r28;
        r0 = r0.mDsDy;
        r26 = r0;
        r0 = r28;
        r0 = r0.mDtDy;
        r27 = r0;
        r23 = r23.isIdentityMatrix(r24, r25, r26, r27);
        if (r23 == 0) goto L_0x04b0;
    L_0x0323:
        r0 = r9.left;
        r23 = r0;
        r0 = r23;
        r0 = (float) r0;
        r23 = r0;
        r23 = (r21 > r23 ? 1 : (r21 == r23 ? 0 : -1));
        if (r23 != 0) goto L_0x04b0;
    L_0x0330:
        r0 = r9.top;
        r23 = r0;
        r0 = r23;
        r0 = (float) r0;
        r23 = r0;
        r23 = (r22 > r23 ? 1 : (r22 == r23 ? 0 : -1));
        if (r23 != 0) goto L_0x04b0;
    L_0x033d:
        if (r13 == 0) goto L_0x0357;
    L_0x033f:
        r0 = r28;
        r0 = r0.mShownAlpha;
        r23 = r0;
        r0 = r28;
        r0 = r0.mTransformation;
        r24 = r0;
        r24 = r24.getAlpha();
        r23 = r23 * r24;
        r0 = r23;
        r1 = r28;
        r1.mShownAlpha = r0;
    L_0x0357:
        if (r7 == 0) goto L_0x036b;
    L_0x0359:
        r0 = r28;
        r0 = r0.mShownAlpha;
        r23 = r0;
        r24 = r7.getAlpha();
        r23 = r23 * r24;
        r0 = r23;
        r1 = r28;
        r1.mShownAlpha = r0;
    L_0x036b:
        if (r5 == 0) goto L_0x0466;
    L_0x036d:
        r0 = r28;
        r0 = r0.mShownAlpha;
        r23 = r0;
        r24 = r5.getAlpha();
        r23 = r23 * r24;
        r0 = r23;
        r1 = r28;
        r1.mShownAlpha = r0;
        r23 = r5.hasClipRect();
        if (r23 == 0) goto L_0x0466;
    L_0x0385:
        r0 = r28;
        r0 = r0.mClipRect;
        r23 = r0;
        r24 = r5.getClipRect();
        r23.set(r24);
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mHScale;
        r23 = r0;
        r24 = 0;
        r23 = (r23 > r24 ? 1 : (r23 == r24 ? 0 : -1));
        if (r23 <= 0) goto L_0x03f8;
    L_0x03a4:
        r0 = r28;
        r0 = r0.mClipRect;
        r23 = r0;
        r0 = r23;
        r0 = r0.left;
        r24 = r0;
        r0 = r24;
        r0 = (float) r0;
        r24 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r25 = r0;
        r0 = r25;
        r0 = r0.mHScale;
        r25 = r0;
        r24 = r24 / r25;
        r0 = r24;
        r0 = (int) r0;
        r24 = r0;
        r0 = r24;
        r1 = r23;
        r1.left = r0;
        r0 = r28;
        r0 = r0.mClipRect;
        r23 = r0;
        r0 = r23;
        r0 = r0.right;
        r24 = r0;
        r0 = r24;
        r0 = (float) r0;
        r24 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r25 = r0;
        r0 = r25;
        r0 = r0.mHScale;
        r25 = r0;
        r24 = r24 / r25;
        r0 = r24;
        r0 = (int) r0;
        r24 = r0;
        r0 = r24;
        r1 = r23;
        r1.right = r0;
    L_0x03f8:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mVScale;
        r23 = r0;
        r24 = 0;
        r23 = (r23 > r24 ? 1 : (r23 == r24 ? 0 : -1));
        if (r23 <= 0) goto L_0x045e;
    L_0x040a:
        r0 = r28;
        r0 = r0.mClipRect;
        r23 = r0;
        r0 = r23;
        r0 = r0.top;
        r24 = r0;
        r0 = r24;
        r0 = (float) r0;
        r24 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r25 = r0;
        r0 = r25;
        r0 = r0.mVScale;
        r25 = r0;
        r24 = r24 / r25;
        r0 = r24;
        r0 = (int) r0;
        r24 = r0;
        r0 = r24;
        r1 = r23;
        r1.top = r0;
        r0 = r28;
        r0 = r0.mClipRect;
        r23 = r0;
        r0 = r23;
        r0 = r0.bottom;
        r24 = r0;
        r0 = r24;
        r0 = (float) r0;
        r24 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r25 = r0;
        r0 = r25;
        r0 = r0.mVScale;
        r25 = r0;
        r24 = r24 / r25;
        r0 = r24;
        r0 = (int) r0;
        r24 = r0;
        r0 = r24;
        r1 = r23;
        r1.bottom = r0;
    L_0x045e:
        r23 = 1;
        r0 = r23;
        r1 = r28;
        r1.mHasClipRect = r0;
    L_0x0466:
        r0 = r28;
        r0 = r0.mAnimator;
        r23 = r0;
        r0 = r23;
        r0 = r0.mUniverseBackground;
        r23 = r0;
        if (r23 == 0) goto L_0x0498;
    L_0x0474:
        r0 = r28;
        r0 = r0.mShownAlpha;
        r23 = r0;
        r0 = r28;
        r0 = r0.mAnimator;
        r24 = r0;
        r0 = r24;
        r0 = r0.mUniverseBackground;
        r24 = r0;
        r0 = r24;
        r0 = r0.mUniverseTransform;
        r24 = r0;
        r24 = r24.getAlpha();
        r23 = r23 * r24;
        r0 = r23;
        r1 = r28;
        r1.mShownAlpha = r0;
    L_0x0498:
        if (r11 == 0) goto L_0x04b0;
    L_0x049a:
        r0 = r28;
        r0 = r0.mShownAlpha;
        r23 = r0;
        r24 = r12.getEnterTransformation();
        r24 = r24.getAlpha();
        r23 = r23 * r24;
        r0 = r23;
        r1 = r28;
        r1.mShownAlpha = r0;
    L_0x04b0:
        return;
    L_0x04b1:
        r7 = 0;
        goto L_0x0024;
    L_0x04b4:
        r5 = 0;
        goto L_0x0044;
    L_0x04b7:
        r0 = r19;
        r0 = r0.mAppToken;
        r23 = r0;
        r0 = r23;
        r0 = r0.mAppAnimator;
        r20 = r0;
        goto L_0x0098;
    L_0x04c5:
        r11 = 0;
        goto L_0x00d9;
    L_0x04c8:
        r16.reset();
        goto L_0x014a;
    L_0x04cd:
        r16.reset();
        goto L_0x014a;
    L_0x04d2:
        r0 = r28;
        r0 = r0.mIsWallpaper;
        r23 = r0;
        if (r23 == 0) goto L_0x04ee;
    L_0x04da:
        r0 = r28;
        r0 = r0.mService;
        r23 = r0;
        r0 = r23;
        r0 = r0.mInnerFields;
        r23 = r0;
        r0 = r23;
        r0 = r0.mWallpaperActionPending;
        r23 = r0;
        if (r23 != 0) goto L_0x04b0;
    L_0x04ee:
        r0 = r28;
        r0 = r0.mAnimator;
        r23 = r0;
        r0 = r23;
        r0 = r0.mUniverseBackground;
        r23 = r0;
        if (r23 == 0) goto L_0x06bf;
    L_0x04fc:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mAttrs;
        r23 = r0;
        r0 = r23;
        r0 = r0.type;
        r23 = r0;
        r24 = 2025; // 0x7e9 float:2.838E-42 double:1.0005E-320;
        r0 = r23;
        r1 = r24;
        if (r0 == r1) goto L_0x06bf;
    L_0x0516:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mBaseLayer;
        r23 = r0;
        r0 = r28;
        r0 = r0.mAnimator;
        r24 = r0;
        r0 = r24;
        r0 = r0.mAboveUniverseLayer;
        r24 = r0;
        r0 = r23;
        r1 = r24;
        if (r0 >= r1) goto L_0x06bf;
    L_0x0534:
        r6 = 1;
    L_0x0535:
        r14 = 0;
        r0 = r28;
        r0 = r0.mService;
        r23 = r0;
        r0 = r23;
        r0 = r0.mAccessibilityController;
        r23 = r0;
        if (r23 == 0) goto L_0x055c;
    L_0x0544:
        if (r8 != 0) goto L_0x055c;
    L_0x0546:
        r0 = r28;
        r0 = r0.mService;
        r23 = r0;
        r0 = r23;
        r0 = r0.mAccessibilityController;
        r23 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r24 = r0;
        r14 = r23.getMagnificationSpecForWindowLocked(r24);
    L_0x055c:
        if (r6 != 0) goto L_0x0560;
    L_0x055e:
        if (r14 == 0) goto L_0x06c2;
    L_0x0560:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r9 = r0.mFrame;
        r0 = r28;
        r0 = r0.mService;
        r23 = r0;
        r0 = r23;
        r15 = r0.mTmpFloats;
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mTmpMatrix;
        r16 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mGlobalScale;
        r23 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r24 = r0;
        r0 = r24;
        r0 = r0.mGlobalScale;
        r24 = r0;
        r0 = r16;
        r1 = r23;
        r2 = r24;
        r0.setScale(r1, r2);
        r0 = r9.left;
        r23 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r24 = r0;
        r0 = r24;
        r0 = r0.mXOffset;
        r24 = r0;
        r23 = r23 + r24;
        r0 = r23;
        r0 = (float) r0;
        r23 = r0;
        r0 = r9.top;
        r24 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r25 = r0;
        r0 = r25;
        r0 = r0.mYOffset;
        r25 = r0;
        r24 = r24 + r25;
        r0 = r24;
        r0 = (float) r0;
        r24 = r0;
        r0 = r16;
        r1 = r23;
        r2 = r24;
        r0.postTranslate(r1, r2);
        if (r6 == 0) goto L_0x05f7;
    L_0x05da:
        r0 = r28;
        r0 = r0.mAnimator;
        r23 = r0;
        r0 = r23;
        r0 = r0.mUniverseBackground;
        r23 = r0;
        r0 = r23;
        r0 = r0.mUniverseTransform;
        r23 = r0;
        r23 = r23.getMatrix();
        r0 = r16;
        r1 = r23;
        r0.postConcat(r1);
    L_0x05f7:
        if (r14 == 0) goto L_0x0621;
    L_0x05f9:
        r23 = r14.isNop();
        if (r23 != 0) goto L_0x0621;
    L_0x05ff:
        r0 = r14.scale;
        r23 = r0;
        r0 = r14.scale;
        r24 = r0;
        r0 = r16;
        r1 = r23;
        r2 = r24;
        r0.postScale(r1, r2);
        r0 = r14.offsetX;
        r23 = r0;
        r0 = r14.offsetY;
        r24 = r0;
        r0 = r16;
        r1 = r23;
        r2 = r24;
        r0.postTranslate(r1, r2);
    L_0x0621:
        r0 = r16;
        r0.getValues(r15);
        r23 = 1;
        r0 = r23;
        r1 = r28;
        r1.mHaveMatrix = r0;
        r23 = 0;
        r23 = r15[r23];
        r0 = r23;
        r1 = r28;
        r1.mDsDx = r0;
        r23 = 3;
        r23 = r15[r23];
        r0 = r23;
        r1 = r28;
        r1.mDtDx = r0;
        r23 = 1;
        r23 = r15[r23];
        r0 = r23;
        r1 = r28;
        r1.mDsDy = r0;
        r23 = 4;
        r23 = r15[r23];
        r0 = r23;
        r1 = r28;
        r1.mDtDy = r0;
        r23 = 2;
        r21 = r15[r23];
        r23 = 5;
        r22 = r15[r23];
        r17 = r9.width();
        r10 = r9.height();
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mShownFrame;
        r23 = r0;
        r0 = r17;
        r0 = (float) r0;
        r24 = r0;
        r24 = r24 + r21;
        r0 = (float) r10;
        r25 = r0;
        r25 = r25 + r22;
        r0 = r23;
        r1 = r21;
        r2 = r22;
        r3 = r24;
        r4 = r25;
        r0.set(r1, r2, r3, r4);
        r0 = r28;
        r0 = r0.mAlpha;
        r23 = r0;
        r0 = r23;
        r1 = r28;
        r1.mShownAlpha = r0;
        if (r6 == 0) goto L_0x04b0;
    L_0x0699:
        r0 = r28;
        r0 = r0.mShownAlpha;
        r23 = r0;
        r0 = r28;
        r0 = r0.mAnimator;
        r24 = r0;
        r0 = r24;
        r0 = r0.mUniverseBackground;
        r24 = r0;
        r0 = r24;
        r0 = r0.mUniverseTransform;
        r24 = r0;
        r24 = r24.getAlpha();
        r23 = r23 * r24;
        r0 = r23;
        r1 = r28;
        r1.mShownAlpha = r0;
        goto L_0x04b0;
    L_0x06bf:
        r6 = 0;
        goto L_0x0535;
    L_0x06c2:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mShownFrame;
        r23 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r24 = r0;
        r0 = r24;
        r0 = r0.mFrame;
        r24 = r0;
        r23.set(r24);
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mXOffset;
        r23 = r0;
        if (r23 != 0) goto L_0x06f9;
    L_0x06eb:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mYOffset;
        r23 = r0;
        if (r23 == 0) goto L_0x072a;
    L_0x06f9:
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mShownFrame;
        r23 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r24 = r0;
        r0 = r24;
        r0 = r0.mXOffset;
        r24 = r0;
        r0 = r24;
        r0 = (float) r0;
        r24 = r0;
        r0 = r28;
        r0 = r0.mWin;
        r25 = r0;
        r0 = r25;
        r0 = r0.mYOffset;
        r25 = r0;
        r0 = r25;
        r0 = (float) r0;
        r25 = r0;
        r23.offset(r24, r25);
    L_0x072a:
        r0 = r28;
        r0 = r0.mAlpha;
        r23 = r0;
        r0 = r23;
        r1 = r28;
        r1.mShownAlpha = r0;
        r23 = 0;
        r0 = r23;
        r1 = r28;
        r1.mHaveMatrix = r0;
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mGlobalScale;
        r23 = r0;
        r0 = r23;
        r1 = r28;
        r1.mDsDx = r0;
        r23 = 0;
        r0 = r23;
        r1 = r28;
        r1.mDtDx = r0;
        r23 = 0;
        r0 = r23;
        r1 = r28;
        r1.mDsDy = r0;
        r0 = r28;
        r0 = r0.mWin;
        r23 = r0;
        r0 = r23;
        r0 = r0.mGlobalScale;
        r23 = r0;
        r0 = r23;
        r1 = r28;
        r1.mDtDy = r0;
        if (r5 != 0) goto L_0x04b0;
    L_0x0774:
        r23 = 0;
        r0 = r23;
        r1 = r28;
        r1.mHasClipRect = r0;
        r0 = r28;
        r0 = r0.mClipRect;
        r23 = r0;
        r23.setEmpty();
        goto L_0x04b0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowStateAnimator.computeShownFrameLocked():void");
    }

    void applyDecorRect(Rect decorRect) {
        WindowState w = this.mWin;
        int left = w.mXOffset + w.mFrame.left;
        int top = w.mYOffset + w.mFrame.top;
        w.mSystemDecorRect.set(NO_SURFACE, NO_SURFACE, w.mFrame.width(), w.mFrame.height());
        w.mSystemDecorRect.intersect(decorRect.left - left, decorRect.top - top, decorRect.right - left, decorRect.bottom - top);
        if (w.mEnforceSizeCompat && w.mInvGlobalScale != 1.0f) {
            float scale = w.mInvGlobalScale;
            w.mSystemDecorRect.left = (int) ((((float) w.mSystemDecorRect.left) * scale) - 0.5f);
            w.mSystemDecorRect.top = (int) ((((float) w.mSystemDecorRect.top) * scale) - 0.5f);
            w.mSystemDecorRect.right = (int) ((((float) (w.mSystemDecorRect.right + DRAW_PENDING)) * scale) - 0.5f);
            w.mSystemDecorRect.bottom = (int) ((((float) (w.mSystemDecorRect.bottom + DRAW_PENDING)) * scale) - 0.5f);
        }
    }

    void updateSurfaceWindowCrop(boolean recoveringMemory) {
        WindowState w = this.mWin;
        DisplayContent displayContent = w.getDisplayContent();
        if (displayContent != null) {
            if ((w.mAttrs.flags & 16384) != 0) {
                w.mSystemDecorRect.set(NO_SURFACE, NO_SURFACE, w.mRequestedWidth, w.mRequestedHeight);
            } else if (!w.isDefaultDisplay()) {
                DisplayInfo displayInfo = displayContent.getDisplayInfo();
                w.mSystemDecorRect.set(NO_SURFACE, NO_SURFACE, w.mCompatFrame.width(), w.mCompatFrame.height());
                w.mSystemDecorRect.intersect(-w.mCompatFrame.left, -w.mCompatFrame.top, displayInfo.logicalWidth - w.mCompatFrame.left, displayInfo.logicalHeight - w.mCompatFrame.top);
            } else if (w.mLayer >= this.mService.mSystemDecorLayer) {
                if (this.mAnimator.mUniverseBackground == null) {
                    w.mSystemDecorRect.set(NO_SURFACE, NO_SURFACE, w.mCompatFrame.width(), w.mCompatFrame.height());
                } else {
                    applyDecorRect(this.mService.mScreenRect);
                }
            } else if (w.mAttrs.type == 2025 || w.mDecorFrame.isEmpty()) {
                w.mSystemDecorRect.set(NO_SURFACE, NO_SURFACE, w.mCompatFrame.width(), w.mCompatFrame.height());
            } else if (w.mAttrs.type == 2013 && this.mAnimator.mAnimating) {
                this.mTmpClipRect.set(w.mSystemDecorRect);
                applyDecorRect(w.mDecorFrame);
                w.mSystemDecorRect.union(this.mTmpClipRect);
            } else {
                applyDecorRect(w.mDecorFrame);
            }
            Rect clipRect = this.mTmpClipRect;
            clipRect.set(w.mSystemDecorRect);
            LayoutParams attrs = w.mAttrs;
            clipRect.left -= attrs.surfaceInsets.left;
            clipRect.top -= attrs.surfaceInsets.top;
            clipRect.right += attrs.surfaceInsets.right;
            clipRect.bottom += attrs.surfaceInsets.bottom;
            if (this.mHasClipRect && (w.mAttrs.flags & 65536) != 0) {
                if ((w.mSystemUiVisibility & SYSTEM_UI_FLAGS_LAYOUT_STABLE_FULLSCREEN) == SYSTEM_UI_FLAGS_LAYOUT_STABLE_FULLSCREEN || (w.mAttrs.flags & SoundTriggerHelper.STATUS_ERROR) != 0) {
                    clipRect.intersect(this.mClipRect);
                } else {
                    int offsetTop = Math.max(clipRect.top, w.mContentInsets.top);
                    clipRect.offset(NO_SURFACE, -offsetTop);
                    clipRect.intersect(this.mClipRect);
                    clipRect.offset(NO_SURFACE, offsetTop);
                }
            }
            clipRect.offset(attrs.surfaceInsets.left, attrs.surfaceInsets.top);
            if (!clipRect.equals(this.mLastClipRect)) {
                this.mLastClipRect.set(clipRect);
                try {
                    this.mSurfaceControl.setWindowCrop(clipRect);
                } catch (RuntimeException e) {
                    Slog.w(TAG, "Error setting crop surface of " + w + " crop=" + clipRect.toShortString(), e);
                    if (!recoveringMemory) {
                        this.mService.reclaimSomeSurfaceMemoryLocked(this, "crop", true);
                    }
                }
            }
        }
    }

    void setSurfaceBoundariesLocked(boolean recoveringMemory) {
        int width;
        int height;
        boolean surfaceMoved;
        boolean surfaceResized;
        TaskStack stack;
        WindowState w = this.mWin;
        if ((w.mAttrs.flags & 16384) != 0) {
            width = w.mRequestedWidth;
            height = w.mRequestedHeight;
        } else {
            width = w.mCompatFrame.width();
            height = w.mCompatFrame.height();
        }
        if (width < DRAW_PENDING) {
            width = DRAW_PENDING;
        }
        if (height < DRAW_PENDING) {
            height = DRAW_PENDING;
        }
        float left = w.mShownFrame.left;
        float top = w.mShownFrame.top;
        LayoutParams attrs = w.getAttrs();
        int displayId = w.getDisplayId();
        float scale = 1.0f;
        if (this.mService.mAccessibilityController != null && displayId == 0) {
            MagnificationSpec spec = this.mService.mAccessibilityController.getMagnificationSpecForWindowLocked(w);
            if (!(spec == null || spec.isNop())) {
                scale = spec.scale;
            }
        }
        width = (int) (((float) width) + (((float) (attrs.surfaceInsets.left + attrs.surfaceInsets.right)) * scale));
        height = (int) (((float) height) + (((float) (attrs.surfaceInsets.top + attrs.surfaceInsets.bottom)) * scale));
        left -= ((float) attrs.surfaceInsets.left) * scale;
        top -= ((float) attrs.surfaceInsets.top) * scale;
        if (this.mSurfaceX == left) {
            if (this.mSurfaceY == top) {
                surfaceMoved = false;
                if (surfaceMoved) {
                    this.mSurfaceX = left;
                    this.mSurfaceY = top;
                    try {
                        this.mSurfaceControl.setPosition(left, top);
                    } catch (RuntimeException e) {
                        Slog.w(TAG, "Error positioning surface of " + w + " pos=(" + left + "," + top + ")", e);
                        if (!recoveringMemory) {
                            this.mService.reclaimSomeSurfaceMemoryLocked(this, "position", true);
                        }
                    }
                }
                if (this.mSurfaceW == ((float) width)) {
                    if (this.mSurfaceH == ((float) height)) {
                        surfaceResized = false;
                        if (surfaceResized) {
                            this.mSurfaceW = (float) width;
                            this.mSurfaceH = (float) height;
                            this.mSurfaceResized = true;
                            try {
                                this.mSurfaceControl.setSize(width, height);
                                this.mAnimator.setPendingLayoutChanges(w.getDisplayId(), HAS_DRAWN);
                                if ((w.mAttrs.flags & COMMIT_DRAW_PENDING) != 0) {
                                    stack = w.getStack();
                                    if (stack != null) {
                                        stack.startDimmingIfNeeded(this);
                                    }
                                }
                            } catch (RuntimeException e2) {
                                Slog.e(TAG, "Error resizing surface of " + w + " size=(" + width + "x" + height + ")", e2);
                                if (!recoveringMemory) {
                                    this.mService.reclaimSomeSurfaceMemoryLocked(this, "size", true);
                                }
                            }
                        }
                        updateSurfaceWindowCrop(recoveringMemory);
                    }
                }
                surfaceResized = true;
                if (surfaceResized) {
                    this.mSurfaceW = (float) width;
                    this.mSurfaceH = (float) height;
                    this.mSurfaceResized = true;
                    this.mSurfaceControl.setSize(width, height);
                    this.mAnimator.setPendingLayoutChanges(w.getDisplayId(), HAS_DRAWN);
                    if ((w.mAttrs.flags & COMMIT_DRAW_PENDING) != 0) {
                        stack = w.getStack();
                        if (stack != null) {
                            stack.startDimmingIfNeeded(this);
                        }
                    }
                }
                updateSurfaceWindowCrop(recoveringMemory);
            }
        }
        surfaceMoved = true;
        if (surfaceMoved) {
            this.mSurfaceX = left;
            this.mSurfaceY = top;
            this.mSurfaceControl.setPosition(left, top);
        }
        if (this.mSurfaceW == ((float) width)) {
            if (this.mSurfaceH == ((float) height)) {
                surfaceResized = false;
                if (surfaceResized) {
                    this.mSurfaceW = (float) width;
                    this.mSurfaceH = (float) height;
                    this.mSurfaceResized = true;
                    this.mSurfaceControl.setSize(width, height);
                    this.mAnimator.setPendingLayoutChanges(w.getDisplayId(), HAS_DRAWN);
                    if ((w.mAttrs.flags & COMMIT_DRAW_PENDING) != 0) {
                        stack = w.getStack();
                        if (stack != null) {
                            stack.startDimmingIfNeeded(this);
                        }
                    }
                }
                updateSurfaceWindowCrop(recoveringMemory);
            }
        }
        surfaceResized = true;
        if (surfaceResized) {
            this.mSurfaceW = (float) width;
            this.mSurfaceH = (float) height;
            this.mSurfaceResized = true;
            this.mSurfaceControl.setSize(width, height);
            this.mAnimator.setPendingLayoutChanges(w.getDisplayId(), HAS_DRAWN);
            if ((w.mAttrs.flags & COMMIT_DRAW_PENDING) != 0) {
                stack = w.getStack();
                if (stack != null) {
                    stack.startDimmingIfNeeded(this);
                }
            }
        }
        updateSurfaceWindowCrop(recoveringMemory);
    }

    public void prepareSurfaceLocked(boolean recoveringMemory) {
        WindowState w = this.mWin;
        if (this.mSurfaceControl != null) {
            boolean displayed = false;
            computeShownFrameLocked();
            setSurfaceBoundariesLocked(recoveringMemory);
            if (this.mIsWallpaper && !this.mWin.mWallpaperVisible) {
                hide();
            } else if (w.mAttachedHidden || !w.isOnScreen()) {
                hide();
                this.mAnimator.hideWallpapersLocked(w);
                if (w.mOrientationChanging) {
                    w.mOrientationChanging = false;
                }
            } else if (this.mLastLayer == this.mAnimLayer && this.mLastAlpha == this.mShownAlpha && this.mLastDsDx == this.mDsDx && this.mLastDtDx == this.mDtDx && this.mLastDsDy == this.mDsDy && this.mLastDtDy == this.mDtDy && w.mLastHScale == w.mHScale && w.mLastVScale == w.mVScale && !this.mLastHidden) {
                displayed = true;
            } else {
                displayed = true;
                this.mLastAlpha = this.mShownAlpha;
                this.mLastLayer = this.mAnimLayer;
                this.mLastDsDx = this.mDsDx;
                this.mLastDtDx = this.mDtDx;
                this.mLastDsDy = this.mDsDy;
                this.mLastDtDy = this.mDtDy;
                w.mLastHScale = w.mHScale;
                w.mLastVScale = w.mVScale;
                if (this.mSurfaceControl != null) {
                    try {
                        this.mSurfaceAlpha = this.mShownAlpha;
                        this.mSurfaceControl.setAlpha(this.mShownAlpha);
                        this.mSurfaceLayer = this.mAnimLayer;
                        this.mSurfaceControl.setLayer(this.mAnimLayer);
                        this.mSurfaceControl.setMatrix(this.mDsDx * w.mHScale, this.mDtDx * w.mVScale, this.mDsDy * w.mHScale, this.mDtDy * w.mVScale);
                        if (this.mLastHidden && this.mDrawState == HAS_DRAWN) {
                            if (showSurfaceRobustlyLocked()) {
                                this.mLastHidden = false;
                                if (this.mIsWallpaper) {
                                    this.mService.dispatchWallpaperVisibility(w, true);
                                }
                                this.mAnimator.setPendingLayoutChanges(w.getDisplayId(), 8);
                            } else {
                                w.mOrientationChanging = false;
                            }
                        }
                        if (this.mSurfaceControl != null) {
                            w.mToken.hasVisible = true;
                        }
                    } catch (RuntimeException e) {
                        Slog.w(TAG, "Error updating surface in " + w, e);
                        if (!recoveringMemory) {
                            this.mService.reclaimSomeSurfaceMemoryLocked(this, "update", true);
                        }
                    }
                }
            }
            if (displayed) {
                if (w.mOrientationChanging) {
                    if (w.isDrawnLw()) {
                        w.mOrientationChanging = false;
                    } else {
                        WindowAnimator windowAnimator = this.mAnimator;
                        windowAnimator.mBulkUpdateParams &= -9;
                        this.mAnimator.mLastWindowFreezeSource = w;
                    }
                }
                w.mToken.hasVisible = true;
            }
        } else if (w.mOrientationChanging) {
            w.mOrientationChanging = false;
        }
    }

    void setTransparentRegionHintLocked(Region region) {
        if (this.mSurfaceControl == null) {
            Slog.w(TAG, "setTransparentRegionHint: null mSurface after mHasSurface true");
            return;
        }
        SurfaceControl.openTransaction();
        try {
            this.mSurfaceControl.setTransparentRegionHint(region);
        } finally {
            SurfaceControl.closeTransaction();
        }
    }

    void setWallpaperOffset(RectF shownFrame) {
        LayoutParams attrs = this.mWin.getAttrs();
        int left = ((int) shownFrame.left) - attrs.surfaceInsets.left;
        int top = ((int) shownFrame.top) - attrs.surfaceInsets.top;
        if (this.mSurfaceX != ((float) left) || this.mSurfaceY != ((float) top)) {
            this.mSurfaceX = (float) left;
            this.mSurfaceY = (float) top;
            if (!this.mAnimating) {
                SurfaceControl.openTransaction();
                try {
                    this.mSurfaceControl.setPosition((float) (this.mWin.mFrame.left + left), (float) (this.mWin.mFrame.top + top));
                    updateSurfaceWindowCrop(false);
                } catch (RuntimeException e) {
                    Slog.w(TAG, "Error positioning surface of " + this.mWin + " pos=(" + left + "," + top + ")", e);
                } finally {
                    SurfaceControl.closeTransaction();
                }
            }
        }
    }

    void setOpaqueLocked(boolean isOpaque) {
        if (this.mSurfaceControl != null) {
            SurfaceControl.openTransaction();
            try {
                this.mSurfaceControl.setOpaque(isOpaque);
            } finally {
                SurfaceControl.closeTransaction();
            }
        }
    }

    boolean performShowLocked() {
        if (this.mWin.isHiddenFromUserLocked() || this.mDrawState != READY_TO_SHOW || !this.mWin.isReadyForDisplayIgnoringKeyguard()) {
            return false;
        }
        this.mService.enableScreenIfNeededLocked();
        applyEnterAnimationLocked();
        this.mLastAlpha = -1.0f;
        this.mDrawState = HAS_DRAWN;
        this.mService.scheduleAnimationLocked();
        int i = this.mWin.mChildWindows.size();
        while (i > 0) {
            i--;
            WindowState c = (WindowState) this.mWin.mChildWindows.get(i);
            if (c.mAttachedHidden) {
                c.mAttachedHidden = false;
                if (c.mWinAnimator.mSurfaceControl != null) {
                    c.mWinAnimator.performShowLocked();
                    DisplayContent displayContent = c.getDisplayContent();
                    if (displayContent != null) {
                        displayContent.layoutNeeded = true;
                    }
                }
            }
        }
        if (!(this.mWin.mAttrs.type == READY_TO_SHOW || this.mWin.mAppToken == null)) {
            this.mWin.mAppToken.firstWindowDrawn = true;
            if (this.mWin.mAppToken.startingData != null) {
                clearAnimation();
                this.mService.mFinishedStarting.add(this.mWin.mAppToken);
                this.mService.mH.sendEmptyMessage(7);
            }
            this.mWin.mAppToken.updateReportedVisibilityLocked();
        }
        return true;
    }

    boolean showSurfaceRobustlyLocked() {
        try {
            if (this.mSurfaceControl == null) {
                return true;
            }
            this.mSurfaceShown = true;
            this.mSurfaceControl.show();
            if (!this.mWin.mTurnOnScreen) {
                return true;
            }
            this.mWin.mTurnOnScreen = false;
            WindowAnimator windowAnimator = this.mAnimator;
            windowAnimator.mBulkUpdateParams |= 16;
            return true;
        } catch (RuntimeException e) {
            Slog.w(TAG, "Failure showing surface " + this.mSurfaceControl + " in " + this.mWin, e);
            this.mService.reclaimSomeSurfaceMemoryLocked(this, "show", true);
            return false;
        }
    }

    void applyEnterAnimationLocked() {
        int transit;
        if (this.mEnterAnimationPending) {
            this.mEnterAnimationPending = false;
            transit = DRAW_PENDING;
        } else {
            transit = READY_TO_SHOW;
        }
        applyAnimationLocked(transit, true);
        if (this.mService.mAccessibilityController != null && this.mWin.getDisplayId() == 0) {
            this.mService.mAccessibilityController.onWindowTransitionLocked(this.mWin, transit);
        }
    }

    boolean applyAnimationLocked(int transit, boolean isEntrance) {
        if ((!this.mLocalAnimating || this.mAnimationIsEntrance != isEntrance) && !this.mKeyguardGoingAwayAnimation) {
            if (this.mService.okToDisplay()) {
                int anim = this.mPolicy.selectAnimationLw(this.mWin, transit);
                int attr = -1;
                Animation a = null;
                if (anim == 0) {
                    switch (transit) {
                        case DRAW_PENDING /*1*/:
                            attr = NO_SURFACE;
                            break;
                        case COMMIT_DRAW_PENDING /*2*/:
                            attr = DRAW_PENDING;
                            break;
                        case READY_TO_SHOW /*3*/:
                            attr = COMMIT_DRAW_PENDING;
                            break;
                        case HAS_DRAWN /*4*/:
                            attr = READY_TO_SHOW;
                            break;
                    }
                    if (attr >= 0) {
                        a = this.mService.mAppTransition.loadAnimationAttr(this.mWin.mAttrs, attr);
                    }
                } else if (anim != -1) {
                    a = AnimationUtils.loadAnimation(this.mContext, anim);
                } else {
                    a = null;
                }
                if (a != null) {
                    setAnimation(a);
                    this.mAnimationIsEntrance = isEntrance;
                }
            } else {
                clearAnimation();
            }
            if (this.mAnimation == null) {
                return false;
            }
            return true;
        } else if (this.mAnimation == null || !this.mKeyguardGoingAwayAnimation || transit != 5) {
            return true;
        } else {
            applyFadeoutDuringKeyguardExitAnimation();
            return true;
        }
    }

    private void applyFadeoutDuringKeyguardExitAnimation() {
        long startTime = this.mAnimation.getStartTime();
        long duration = this.mAnimation.getDuration();
        long elapsed = this.mLastAnimationTime - startTime;
        long fadeDuration = duration - elapsed;
        if (fadeDuration > 0) {
            AnimationSet newAnimation = new AnimationSet(false);
            newAnimation.setDuration(duration);
            newAnimation.setStartTime(startTime);
            newAnimation.addAnimation(this.mAnimation);
            Animation fadeOut = AnimationUtils.loadAnimation(this.mContext, 17432593);
            fadeOut.setDuration(fadeDuration);
            fadeOut.setStartOffset(elapsed);
            newAnimation.addAnimation(fadeOut);
            newAnimation.initialize(this.mWin.mFrame.width(), this.mWin.mFrame.height(), this.mAnimDw, this.mAnimDh);
            this.mAnimation = newAnimation;
        }
    }

    public void dump(PrintWriter pw, String prefix, boolean dumpAll) {
        if (this.mAnimating || this.mLocalAnimating || this.mAnimationIsEntrance || this.mAnimation != null) {
            pw.print(prefix);
            pw.print("mAnimating=");
            pw.print(this.mAnimating);
            pw.print(" mLocalAnimating=");
            pw.print(this.mLocalAnimating);
            pw.print(" mAnimationIsEntrance=");
            pw.print(this.mAnimationIsEntrance);
            pw.print(" mAnimation=");
            pw.println(this.mAnimation);
        }
        if (this.mHasTransformation || this.mHasLocalTransformation) {
            pw.print(prefix);
            pw.print("XForm: has=");
            pw.print(this.mHasTransformation);
            pw.print(" hasLocal=");
            pw.print(this.mHasLocalTransformation);
            pw.print(" ");
            this.mTransformation.printShortString(pw);
            pw.println();
        }
        if (this.mSurfaceControl != null) {
            if (dumpAll) {
                pw.print(prefix);
                pw.print("mSurface=");
                pw.println(this.mSurfaceControl);
                pw.print(prefix);
                pw.print("mDrawState=");
                pw.print(drawStateToString());
                pw.print(" mLastHidden=");
                pw.println(this.mLastHidden);
            }
            pw.print(prefix);
            pw.print("Surface: shown=");
            pw.print(this.mSurfaceShown);
            pw.print(" layer=");
            pw.print(this.mSurfaceLayer);
            pw.print(" alpha=");
            pw.print(this.mSurfaceAlpha);
            pw.print(" rect=(");
            pw.print(this.mSurfaceX);
            pw.print(",");
            pw.print(this.mSurfaceY);
            pw.print(") ");
            pw.print(this.mSurfaceW);
            pw.print(" x ");
            pw.println(this.mSurfaceH);
        }
        if (this.mPendingDestroySurface != null) {
            pw.print(prefix);
            pw.print("mPendingDestroySurface=");
            pw.println(this.mPendingDestroySurface);
        }
        if (this.mSurfaceResized || this.mSurfaceDestroyDeferred) {
            pw.print(prefix);
            pw.print("mSurfaceResized=");
            pw.print(this.mSurfaceResized);
            pw.print(" mSurfaceDestroyDeferred=");
            pw.println(this.mSurfaceDestroyDeferred);
        }
        if (this.mWin.mAttrs.type == 2025) {
            pw.print(prefix);
            pw.print("mUniverseTransform=");
            this.mUniverseTransform.printShortString(pw);
            pw.println();
        }
        if (!(this.mShownAlpha == 1.0f && this.mAlpha == 1.0f && this.mLastAlpha == 1.0f)) {
            pw.print(prefix);
            pw.print("mShownAlpha=");
            pw.print(this.mShownAlpha);
            pw.print(" mAlpha=");
            pw.print(this.mAlpha);
            pw.print(" mLastAlpha=");
            pw.println(this.mLastAlpha);
        }
        if (this.mHaveMatrix || this.mWin.mGlobalScale != 1.0f) {
            pw.print(prefix);
            pw.print("mGlobalScale=");
            pw.print(this.mWin.mGlobalScale);
            pw.print(" mDsDx=");
            pw.print(this.mDsDx);
            pw.print(" mDtDx=");
            pw.print(this.mDtDx);
            pw.print(" mDsDy=");
            pw.print(this.mDsDy);
            pw.print(" mDtDy=");
            pw.println(this.mDtDy);
        }
    }

    public String toString() {
        StringBuffer sb = new StringBuffer("WindowStateAnimator{");
        sb.append(Integer.toHexString(System.identityHashCode(this)));
        sb.append(' ');
        sb.append(this.mWin.mAttrs.getTitle());
        sb.append('}');
        return sb.toString();
    }

    void updateFullyTransparent(LayoutParams attrs) {
        boolean fullyTransparent = (attrs.privateFlags & 268435456) != 0;
        if (fullyTransparent != this.mFullyTransparent && this.mSurfaceControl != null) {
            SurfaceControl.openTransaction();
            try {
                this.mSurfaceControl.setTransparent(fullyTransparent);
            } catch (RuntimeException e) {
                Slog.w(TAG, "Error toggling transparency. ", e);
            } finally {
                SurfaceControl.closeTransaction();
                this.mFullyTransparent = fullyTransparent;
            }
        }
    }
}
