package com.android.server.wm;

import android.content.Context;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.util.TimeUtils;
import android.view.WindowManagerPolicy;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import java.io.PrintWriter;
import java.util.ArrayList;

public class WindowAnimator {
    static final int KEYGUARD_ANIMATING_IN = 1;
    static final int KEYGUARD_ANIMATING_OUT = 3;
    private static final long KEYGUARD_ANIM_TIMEOUT_MS = 1000;
    static final int KEYGUARD_NOT_SHOWN = 0;
    static final int KEYGUARD_SHOWN = 2;
    private static final String TAG = "WindowAnimator";
    int mAboveUniverseLayer;
    private int mAnimTransactionSequence;
    boolean mAnimating;
    final Runnable mAnimationRunnable;
    int mBulkUpdateParams;
    final Context mContext;
    long mCurrentTime;
    SparseArray<DisplayContentsAnimator> mDisplayContentsAnimators;
    int mForceHiding;
    boolean mInitialized;
    boolean mKeyguardGoingAway;
    boolean mKeyguardGoingAwayDisableWindowAnimations;
    boolean mKeyguardGoingAwayToNotificationShade;
    Object mLastWindowFreezeSource;
    final WindowManagerPolicy mPolicy;
    Animation mPostKeyguardExitAnimation;
    final WindowManagerService mService;
    WindowStateAnimator mUniverseBackground;
    WindowState mWindowDetachedWallpaper;

    /* renamed from: com.android.server.wm.WindowAnimator.1 */
    class C05611 implements Runnable {
        C05611() {
        }

        public void run() {
            synchronized (WindowAnimator.this.mService.mWindowMap) {
                WindowAnimator.this.mService.mAnimationScheduled = false;
                WindowAnimator.this.animateLocked();
            }
        }
    }

    private class DisplayContentsAnimator {
        ScreenRotationAnimation mScreenRotationAnimation;

        private DisplayContentsAnimator() {
            this.mScreenRotationAnimation = null;
        }
    }

    private String forceHidingToString() {
        switch (this.mForceHiding) {
            case KEYGUARD_NOT_SHOWN /*0*/:
                return "KEYGUARD_NOT_SHOWN";
            case KEYGUARD_ANIMATING_IN /*1*/:
                return "KEYGUARD_ANIMATING_IN";
            case KEYGUARD_SHOWN /*2*/:
                return "KEYGUARD_SHOWN";
            case KEYGUARD_ANIMATING_OUT /*3*/:
                return "KEYGUARD_ANIMATING_OUT";
            default:
                return "KEYGUARD STATE UNKNOWN " + this.mForceHiding;
        }
    }

    WindowAnimator(WindowManagerService service) {
        this.mWindowDetachedWallpaper = null;
        this.mUniverseBackground = null;
        this.mAboveUniverseLayer = KEYGUARD_NOT_SHOWN;
        this.mBulkUpdateParams = KEYGUARD_NOT_SHOWN;
        this.mDisplayContentsAnimators = new SparseArray(KEYGUARD_SHOWN);
        this.mInitialized = false;
        this.mForceHiding = KEYGUARD_NOT_SHOWN;
        this.mService = service;
        this.mContext = service.mContext;
        this.mPolicy = service.mPolicy;
        this.mAnimationRunnable = new C05611();
    }

    void addDisplayLocked(int displayId) {
        getDisplayContentsAnimatorLocked(displayId);
        if (displayId == 0) {
            this.mInitialized = true;
        }
    }

    void removeDisplayLocked(int displayId) {
        DisplayContentsAnimator displayAnimator = (DisplayContentsAnimator) this.mDisplayContentsAnimators.get(displayId);
        if (!(displayAnimator == null || displayAnimator.mScreenRotationAnimation == null)) {
            displayAnimator.mScreenRotationAnimation.kill();
            displayAnimator.mScreenRotationAnimation = null;
        }
        this.mDisplayContentsAnimators.delete(displayId);
    }

    void hideWallpapersLocked(WindowState w) {
        WindowState wallpaperTarget = this.mService.mWallpaperTarget;
        WindowState lowerWallpaperTarget = this.mService.mLowerWallpaperTarget;
        ArrayList<WindowToken> wallpaperTokens = this.mService.mWallpaperTokens;
        if ((wallpaperTarget == w && lowerWallpaperTarget == null) || wallpaperTarget == null) {
            for (int i = wallpaperTokens.size() - 1; i >= 0; i--) {
                WindowToken token = (WindowToken) wallpaperTokens.get(i);
                for (int j = token.windows.size() - 1; j >= 0; j--) {
                    WindowState wallpaper = (WindowState) token.windows.get(j);
                    WindowStateAnimator winAnimator = wallpaper.mWinAnimator;
                    if (!winAnimator.mLastHidden) {
                        winAnimator.hide();
                        this.mService.dispatchWallpaperVisibility(wallpaper, false);
                        setPendingLayoutChanges(KEYGUARD_NOT_SHOWN, 4);
                    }
                }
                token.hidden = true;
            }
        }
    }

    private void updateAppWindowsLocked(int displayId) {
        ArrayList<TaskStack> stacks = this.mService.getDisplayContentLocked(displayId).getStacks();
        for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
            TaskStack stack = (TaskStack) stacks.get(stackNdx);
            ArrayList<Task> tasks = stack.getTasks();
            for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
                AppTokenList tokens = ((Task) tasks.get(taskNdx)).mAppTokens;
                for (int tokenNdx = tokens.size() - 1; tokenNdx >= 0; tokenNdx--) {
                    AppWindowAnimator appAnimator = ((AppWindowToken) tokens.get(tokenNdx)).mAppAnimator;
                    boolean wasAnimating = (appAnimator.animation == null || appAnimator.animation == AppWindowAnimator.sDummyAnimation) ? false : true;
                    if (appAnimator.stepAnimationLocked(this.mCurrentTime)) {
                        this.mAnimating = true;
                    } else if (wasAnimating) {
                        setAppLayoutChanges(appAnimator, 4, "appToken " + appAnimator.mAppToken + " done");
                    }
                }
            }
            AppTokenList exitingAppTokens = stack.mExitingAppTokens;
            int NEAT = exitingAppTokens.size();
            for (int i = KEYGUARD_NOT_SHOWN; i < NEAT; i += KEYGUARD_ANIMATING_IN) {
                appAnimator = ((AppWindowToken) exitingAppTokens.get(i)).mAppAnimator;
                wasAnimating = (appAnimator.animation == null || appAnimator.animation == AppWindowAnimator.sDummyAnimation) ? false : true;
                if (appAnimator.stepAnimationLocked(this.mCurrentTime)) {
                    this.mAnimating = true;
                } else if (wasAnimating) {
                    setAppLayoutChanges(appAnimator, 4, "exiting appToken " + appAnimator.mAppToken + " done");
                }
            }
        }
    }

    private boolean shouldForceHide(WindowState win) {
        WindowState imeTarget = this.mService.mInputMethodTarget;
        boolean showImeOverKeyguard;
        if (imeTarget == null || !imeTarget.isVisibleNow() || (imeTarget.getAttrs().flags & 524288) == 0) {
            showImeOverKeyguard = false;
        } else {
            showImeOverKeyguard = true;
        }
        WindowState winShowWhenLocked = (WindowState) this.mPolicy.getWinShowWhenLockedLw();
        AppWindowToken appShowWhenLocked = winShowWhenLocked == null ? null : winShowWhenLocked.mAppToken;
        boolean hideWhenLocked;
        if (((win.mIsImWindow || imeTarget == win) && showImeOverKeyguard) || (appShowWhenLocked != null && (appShowWhenLocked == win.mAppToken || (win.mAttrs.privateFlags & DumpState.DUMP_VERIFIERS) != 0))) {
            hideWhenLocked = false;
        } else {
            hideWhenLocked = true;
        }
        if ((this.mForceHiding != KEYGUARD_ANIMATING_IN || (win.mWinAnimator.isAnimating() && !hideWhenLocked)) && (this.mForceHiding != KEYGUARD_SHOWN || !hideWhenLocked)) {
            return false;
        }
        return true;
    }

    private void updateWindowsLocked(int displayId) {
        int i;
        WindowState win;
        WindowStateAnimator winAnimator;
        this.mAnimTransactionSequence += KEYGUARD_ANIMATING_IN;
        WindowList windows = this.mService.getWindowListLocked(displayId);
        if (this.mKeyguardGoingAway) {
            i = windows.size() - 1;
            while (i >= 0) {
                win = (WindowState) windows.get(i);
                if (this.mPolicy.isKeyguardHostWindow(win.mAttrs)) {
                    winAnimator = win.mWinAnimator;
                    if ((win.mAttrs.privateFlags & DumpState.DUMP_PREFERRED_XML) == 0) {
                        this.mKeyguardGoingAway = false;
                        winAnimator.clearAnimation();
                    } else if (!winAnimator.mAnimating) {
                        winAnimator.mAnimation = new AlphaAnimation(1.0f, 1.0f);
                        winAnimator.mAnimation.setDuration(KEYGUARD_ANIM_TIMEOUT_MS);
                        winAnimator.mAnimationIsEntrance = false;
                        winAnimator.mAnimationStartTime = -1;
                    }
                } else {
                    i--;
                }
            }
        }
        this.mForceHiding = KEYGUARD_NOT_SHOWN;
        boolean wallpaperInUnForceHiding = false;
        boolean startingInUnForceHiding = false;
        ArrayList<WindowStateAnimator> unForceHiding = null;
        WindowState wallpaper = null;
        for (i = windows.size() - 1; i >= 0; i--) {
            int i2;
            win = (WindowState) windows.get(i);
            winAnimator = win.mWinAnimator;
            int flags = win.mAttrs.flags;
            boolean canBeForceHidden = this.mPolicy.canBeForceHidden(win, win.mAttrs);
            boolean shouldBeForceHidden = shouldForceHide(win);
            if (winAnimator.mSurfaceControl != null) {
                boolean wasAnimating = winAnimator.mWasAnimating;
                boolean nowAnimating = winAnimator.stepAnimationLocked(this.mCurrentTime);
                this.mAnimating |= nowAnimating;
                if (wasAnimating && !winAnimator.mAnimating) {
                    WindowState windowState = this.mService.mWallpaperTarget;
                    if (r0 == win) {
                        this.mBulkUpdateParams |= KEYGUARD_SHOWN;
                        setPendingLayoutChanges(KEYGUARD_NOT_SHOWN, 4);
                        this.mService.debugLayoutRepeats("updateWindowsAndWallpaperLocked 2", getPendingLayoutChanges(KEYGUARD_NOT_SHOWN));
                    }
                }
                if (this.mPolicy.isForceHiding(win.mAttrs)) {
                    if (!wasAnimating && nowAnimating) {
                        this.mBulkUpdateParams |= 4;
                        setPendingLayoutChanges(displayId, 4);
                        this.mService.debugLayoutRepeats("updateWindowsAndWallpaperLocked 3", getPendingLayoutChanges(displayId));
                        this.mService.mFocusMayChange = true;
                    } else if (this.mKeyguardGoingAway && !nowAnimating) {
                        Slog.e(TAG, "Timeout waiting for animation to startup");
                        this.mPolicy.startKeyguardExitAnimation(0, 0);
                        this.mKeyguardGoingAway = false;
                    }
                    if (win.isReadyForDisplay()) {
                        if (!nowAnimating) {
                            this.mForceHiding = win.isDrawnLw() ? KEYGUARD_SHOWN : KEYGUARD_NOT_SHOWN;
                        } else if (winAnimator.mAnimationIsEntrance) {
                            this.mForceHiding = KEYGUARD_ANIMATING_IN;
                        } else {
                            this.mForceHiding = KEYGUARD_ANIMATING_OUT;
                        }
                    }
                } else if (canBeForceHidden) {
                    if (!shouldBeForceHidden) {
                        boolean applyExistingExitAnimation = (this.mPostKeyguardExitAnimation == null || winAnimator.mKeyguardGoingAwayAnimation || !win.hasDrawnLw() || win.mAttachedWindow != null || this.mForceHiding == 0) ? false : true;
                        if (!win.showLw(false, false) && !applyExistingExitAnimation) {
                        } else if (win.isVisibleNow()) {
                            if ((this.mBulkUpdateParams & 4) != 0 && win.mAttachedWindow == null) {
                                if (unForceHiding == null) {
                                    unForceHiding = new ArrayList();
                                }
                                unForceHiding.add(winAnimator);
                                if ((1048576 & flags) != 0) {
                                    wallpaperInUnForceHiding = true;
                                }
                                i2 = win.mAttrs.type;
                                if (r0 == KEYGUARD_ANIMATING_OUT) {
                                    startingInUnForceHiding = true;
                                }
                            } else if (applyExistingExitAnimation) {
                                winAnimator.setAnimation(this.mPolicy.createForceHideEnterAnimation(false, this.mKeyguardGoingAwayToNotificationShade), this.mPostKeyguardExitAnimation.getStartTime());
                                winAnimator.mKeyguardGoingAwayAnimation = true;
                            }
                            WindowState currentFocus = this.mService.mCurrentFocus;
                            if (currentFocus == null || currentFocus.mLayer < win.mLayer) {
                                this.mService.mFocusMayChange = true;
                            }
                        } else {
                            win.hideLw(false, false);
                        }
                    } else if (!win.hideLw(false, false)) {
                    }
                    if ((1048576 & flags) != 0) {
                        this.mBulkUpdateParams |= KEYGUARD_SHOWN;
                        setPendingLayoutChanges(KEYGUARD_NOT_SHOWN, 4);
                        this.mService.debugLayoutRepeats("updateWindowsAndWallpaperLocked 4", getPendingLayoutChanges(KEYGUARD_NOT_SHOWN));
                    }
                }
            } else if (canBeForceHidden) {
                if (shouldBeForceHidden) {
                    win.hideLw(false, false);
                } else {
                    win.showLw(false, false);
                }
            }
            AppWindowToken atoken = win.mAppToken;
            i2 = winAnimator.mDrawState;
            if (r0 == KEYGUARD_ANIMATING_OUT && ((atoken == null || atoken.allDrawn) && winAnimator.performShowLocked())) {
                setPendingLayoutChanges(displayId, 8);
                this.mService.debugLayoutRepeats("updateWindowsAndWallpaperLocked 5", getPendingLayoutChanges(displayId));
            }
            AppWindowAnimator appAnimator = winAnimator.mAppAnimator;
            if (!(appAnimator == null || appAnimator.thumbnail == null)) {
                if (appAnimator.thumbnailTransactionSeq != this.mAnimTransactionSequence) {
                    appAnimator.thumbnailTransactionSeq = this.mAnimTransactionSequence;
                    appAnimator.thumbnailLayer = KEYGUARD_NOT_SHOWN;
                }
                if (appAnimator.thumbnailLayer < winAnimator.mAnimLayer) {
                    appAnimator.thumbnailLayer = winAnimator.mAnimLayer;
                }
            }
            if (win.mIsWallpaper) {
                wallpaper = win;
            }
        }
        if (unForceHiding != null) {
            Animation a;
            if (!this.mKeyguardGoingAwayDisableWindowAnimations) {
                boolean first = true;
                for (i = unForceHiding.size() - 1; i >= 0; i--) {
                    winAnimator = (WindowStateAnimator) unForceHiding.get(i);
                    WindowManagerPolicy windowManagerPolicy = this.mPolicy;
                    boolean z = wallpaperInUnForceHiding && !startingInUnForceHiding;
                    a = windowManagerPolicy.createForceHideEnterAnimation(z, this.mKeyguardGoingAwayToNotificationShade);
                    if (a != null) {
                        winAnimator.setAnimation(a);
                        winAnimator.mKeyguardGoingAwayAnimation = true;
                        if (first) {
                            this.mPostKeyguardExitAnimation = a;
                            this.mPostKeyguardExitAnimation.setStartTime(this.mCurrentTime);
                            first = false;
                        }
                    }
                }
            } else if (this.mKeyguardGoingAway) {
                this.mPolicy.startKeyguardExitAnimation(this.mCurrentTime, 0);
                this.mKeyguardGoingAway = false;
            }
            if (!(wallpaperInUnForceHiding || wallpaper == null || this.mKeyguardGoingAwayDisableWindowAnimations)) {
                a = this.mPolicy.createForceHideWallpaperExitAnimation(this.mKeyguardGoingAwayToNotificationShade);
                if (a != null) {
                    wallpaper.mWinAnimator.setAnimation(a);
                }
            }
        }
        if (this.mPostKeyguardExitAnimation == null) {
            return;
        }
        if (this.mKeyguardGoingAway) {
            this.mPolicy.startKeyguardExitAnimation(this.mCurrentTime + this.mPostKeyguardExitAnimation.getStartOffset(), this.mPostKeyguardExitAnimation.getDuration());
            this.mKeyguardGoingAway = false;
            return;
        }
        if (this.mCurrentTime - this.mPostKeyguardExitAnimation.getStartTime() > this.mPostKeyguardExitAnimation.getDuration()) {
            this.mPostKeyguardExitAnimation = null;
        }
    }

    private void updateWallpaperLocked(int displayId) {
        this.mService.getDisplayContentLocked(displayId).resetAnimationBackgroundAnimator();
        WindowList windows = this.mService.getWindowListLocked(displayId);
        WindowState detachedWallpaper = null;
        for (int i = windows.size() - 1; i >= 0; i--) {
            WindowState win = (WindowState) windows.get(i);
            WindowStateAnimator winAnimator = win.mWinAnimator;
            if (winAnimator.mSurfaceControl != null) {
                int color;
                TaskStack stack;
                int flags = win.mAttrs.flags;
                if (winAnimator.mAnimating) {
                    if (winAnimator.mAnimation != null) {
                        if ((flags & 1048576) != 0 && winAnimator.mAnimation.getDetachWallpaper()) {
                            detachedWallpaper = win;
                        }
                        color = winAnimator.mAnimation.getBackgroundColor();
                        if (color != 0) {
                            stack = win.getStack();
                            if (stack != null) {
                                stack.setAnimationBackground(winAnimator, color);
                            }
                        }
                    }
                    this.mAnimating = true;
                }
                AppWindowAnimator appAnimator = winAnimator.mAppAnimator;
                if (!(appAnimator == null || appAnimator.animation == null || !appAnimator.animating)) {
                    if ((flags & 1048576) != 0 && appAnimator.animation.getDetachWallpaper()) {
                        detachedWallpaper = win;
                    }
                    color = appAnimator.animation.getBackgroundColor();
                    if (color != 0) {
                        stack = win.getStack();
                        if (stack != null) {
                            stack.setAnimationBackground(winAnimator, color);
                        }
                    }
                }
            }
        }
        if (this.mWindowDetachedWallpaper != detachedWallpaper) {
            this.mWindowDetachedWallpaper = detachedWallpaper;
            this.mBulkUpdateParams |= KEYGUARD_SHOWN;
        }
    }

    private void testTokenMayBeDrawnLocked(int displayId) {
        ArrayList<Task> tasks = this.mService.getDisplayContentLocked(displayId).getTasks();
        int numTasks = tasks.size();
        for (int taskNdx = KEYGUARD_NOT_SHOWN; taskNdx < numTasks; taskNdx += KEYGUARD_ANIMATING_IN) {
            AppTokenList tokens = ((Task) tasks.get(taskNdx)).mAppTokens;
            int numTokens = tokens.size();
            for (int tokenNdx = KEYGUARD_NOT_SHOWN; tokenNdx < numTokens; tokenNdx += KEYGUARD_ANIMATING_IN) {
                AppWindowToken wtoken = (AppWindowToken) tokens.get(tokenNdx);
                AppWindowAnimator appAnimator = wtoken.mAppAnimator;
                boolean allDrawn = wtoken.allDrawn;
                if (allDrawn != appAnimator.allDrawn) {
                    appAnimator.allDrawn = allDrawn;
                    if (allDrawn) {
                        if (appAnimator.freezingScreen) {
                            appAnimator.showAllWindowsLocked();
                            this.mService.unsetAppFreezingScreenLocked(wtoken, false, true);
                            setAppLayoutChanges(appAnimator, 4, "testTokenMayBeDrawnLocked: freezingScreen");
                        } else {
                            setAppLayoutChanges(appAnimator, 8, "testTokenMayBeDrawnLocked");
                            if (!this.mService.mOpeningApps.contains(wtoken)) {
                                this.mAnimating |= appAnimator.showAllWindowsLocked();
                            }
                        }
                    }
                }
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void animateLocked() {
        /*
        r22 = this;
        r0 = r22;
        r0 = r0.mInitialized;
        r19 = r0;
        if (r19 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r20 = android.os.SystemClock.uptimeMillis();
        r0 = r20;
        r2 = r22;
        r2.mCurrentTime = r0;
        r19 = 8;
        r0 = r19;
        r1 = r22;
        r1.mBulkUpdateParams = r0;
        r0 = r22;
        r0 = r0.mAnimating;
        r17 = r0;
        r19 = 0;
        r0 = r19;
        r1 = r22;
        r1.mAnimating = r0;
        android.view.SurfaceControl.openTransaction();
        android.view.SurfaceControl.setAnimationTransaction();
        r0 = r22;
        r0 = r0.mDisplayContentsAnimators;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r14 = r19.size();	 Catch:{ RuntimeException -> 0x00ff }
        r12 = 0;
    L_0x003a:
        if (r12 >= r14) goto L_0x015e;
    L_0x003c:
        r0 = r22;
        r0 = r0.mDisplayContentsAnimators;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r7 = r0.keyAt(r12);	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r22;
        r0.updateAppWindowsLocked(r7);	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r22;
        r0 = r0.mDisplayContentsAnimators;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r5 = r0.valueAt(r12);	 Catch:{ RuntimeException -> 0x00ff }
        r5 = (com.android.server.wm.WindowAnimator.DisplayContentsAnimator) r5;	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r5.mScreenRotationAnimation;	 Catch:{ RuntimeException -> 0x00ff }
        r16 = r0;
        if (r16 == 0) goto L_0x007f;
    L_0x0061:
        r19 = r16.isAnimating();	 Catch:{ RuntimeException -> 0x00ff }
        if (r19 == 0) goto L_0x007f;
    L_0x0067:
        r0 = r22;
        r0 = r0.mCurrentTime;	 Catch:{ RuntimeException -> 0x00ff }
        r20 = r0;
        r0 = r16;
        r1 = r20;
        r19 = r0.stepAnimationLocked(r1);	 Catch:{ RuntimeException -> 0x00ff }
        if (r19 == 0) goto L_0x00b2;
    L_0x0077:
        r19 = 1;
        r0 = r19;
        r1 = r22;
        r1.mAnimating = r0;	 Catch:{ RuntimeException -> 0x00ff }
    L_0x007f:
        r0 = r22;
        r0.updateWindowsLocked(r7);	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r22;
        r0.updateWallpaperLocked(r7);	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r18 = r0.getWindowListLocked(r7);	 Catch:{ RuntimeException -> 0x00ff }
        r4 = r18.size();	 Catch:{ RuntimeException -> 0x00ff }
        r13 = 0;
    L_0x009a:
        if (r13 >= r4) goto L_0x015a;
    L_0x009c:
        r0 = r18;
        r19 = r0.get(r13);	 Catch:{ RuntimeException -> 0x00ff }
        r19 = (com.android.server.wm.WindowState) r19;	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r19;
        r0 = r0.mWinAnimator;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r20 = 1;
        r19.prepareSurfaceLocked(r20);	 Catch:{ RuntimeException -> 0x00ff }
        r13 = r13 + 1;
        goto L_0x009a;
    L_0x00b2:
        r0 = r22;
        r0 = r0.mBulkUpdateParams;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r19 = r19 | 1;
        r0 = r19;
        r1 = r22;
        r1.mBulkUpdateParams = r0;	 Catch:{ RuntimeException -> 0x00ff }
        r16.kill();	 Catch:{ RuntimeException -> 0x00ff }
        r19 = 0;
        r0 = r19;
        r5.mScreenRotationAnimation = r0;	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r0 = r0.mAccessibilityController;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        if (r19 == 0) goto L_0x007f;
    L_0x00d7:
        if (r7 != 0) goto L_0x007f;
    L_0x00d9:
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r0 = r0.mAccessibilityController;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r20 = r0;
        r20 = r20.getDefaultDisplayContentLocked();	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r21 = r0;
        r0 = r21;
        r0 = r0.mRotation;	 Catch:{ RuntimeException -> 0x00ff }
        r21 = r0;
        r19.onRotationChangedLocked(r20, r21);	 Catch:{ RuntimeException -> 0x00ff }
        goto L_0x007f;
    L_0x00ff:
        r10 = move-exception;
        r19 = "WindowAnimator";
        r20 = "Unhandled exception in Window Manager";
        r0 = r19;
        r1 = r20;
        android.util.Slog.wtf(r0, r1, r10);	 Catch:{ all -> 0x0207 }
        android.view.SurfaceControl.closeTransaction();
    L_0x010e:
        r11 = 0;
        r0 = r22;
        r0 = r0.mService;
        r19 = r0;
        r0 = r19;
        r0 = r0.mDisplayContents;
        r19 = r0;
        r14 = r19.size();
        r8 = 0;
    L_0x0120:
        if (r8 >= r14) goto L_0x020c;
    L_0x0122:
        r0 = r22;
        r0 = r0.mService;
        r19 = r0;
        r0 = r19;
        r0 = r0.mDisplayContents;
        r19 = r0;
        r0 = r19;
        r6 = r0.valueAt(r8);
        r6 = (com.android.server.wm.DisplayContent) r6;
        r19 = r6.getDisplayId();
        r0 = r22;
        r1 = r19;
        r15 = r0.getPendingLayoutChanges(r1);
        r19 = r15 & 4;
        if (r19 == 0) goto L_0x0154;
    L_0x0146:
        r0 = r22;
        r0 = r0.mBulkUpdateParams;
        r19 = r0;
        r19 = r19 | 32;
        r0 = r19;
        r1 = r22;
        r1.mBulkUpdateParams = r0;
    L_0x0154:
        if (r15 == 0) goto L_0x0157;
    L_0x0156:
        r11 = 1;
    L_0x0157:
        r8 = r8 + 1;
        goto L_0x0120;
    L_0x015a:
        r12 = r12 + 1;
        goto L_0x003a;
    L_0x015e:
        r12 = 0;
    L_0x015f:
        if (r12 >= r14) goto L_0x01cb;
    L_0x0161:
        r0 = r22;
        r0 = r0.mDisplayContentsAnimators;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r7 = r0.keyAt(r12);	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r22;
        r0.testTokenMayBeDrawnLocked(r7);	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r22;
        r0 = r0.mDisplayContentsAnimators;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r19 = r0.valueAt(r12);	 Catch:{ RuntimeException -> 0x00ff }
        r19 = (com.android.server.wm.WindowAnimator.DisplayContentsAnimator) r19;	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r19;
        r0 = r0.mScreenRotationAnimation;	 Catch:{ RuntimeException -> 0x00ff }
        r16 = r0;
        if (r16 == 0) goto L_0x018b;
    L_0x0188:
        r16.updateSurfacesInTransaction();	 Catch:{ RuntimeException -> 0x00ff }
    L_0x018b:
        r0 = r22;
        r0 = r0.mAnimating;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r20 = r0;
        r0 = r20;
        r20 = r0.getDisplayContentLocked(r7);	 Catch:{ RuntimeException -> 0x00ff }
        r20 = r20.animateDimLayers();	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r19 | r20;
        r0 = r19;
        r1 = r22;
        r1.mAnimating = r0;	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r0 = r0.mAccessibilityController;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        if (r19 == 0) goto L_0x01c8;
    L_0x01b7:
        if (r7 != 0) goto L_0x01c8;
    L_0x01b9:
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r0 = r0.mAccessibilityController;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r19.drawMagnifiedRegionBorderIfNeededLocked();	 Catch:{ RuntimeException -> 0x00ff }
    L_0x01c8:
        r12 = r12 + 1;
        goto L_0x015f;
    L_0x01cb:
        r0 = r22;
        r0 = r0.mAnimating;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        if (r19 == 0) goto L_0x01dc;
    L_0x01d3:
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r19.scheduleAnimationLocked();	 Catch:{ RuntimeException -> 0x00ff }
    L_0x01dc:
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r19.setFocusedStackLayer();	 Catch:{ RuntimeException -> 0x00ff }
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r0 = r0.mWatermark;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        if (r19 == 0) goto L_0x0202;
    L_0x01f3:
        r0 = r22;
        r0 = r0.mService;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r0 = r19;
        r0 = r0.mWatermark;	 Catch:{ RuntimeException -> 0x00ff }
        r19 = r0;
        r19.drawIfNeeded();	 Catch:{ RuntimeException -> 0x00ff }
    L_0x0202:
        android.view.SurfaceControl.closeTransaction();
        goto L_0x010e;
    L_0x0207:
        r19 = move-exception;
        android.view.SurfaceControl.closeTransaction();
        throw r19;
    L_0x020c:
        r9 = 0;
        r0 = r22;
        r0 = r0.mBulkUpdateParams;
        r19 = r0;
        if (r19 == 0) goto L_0x021f;
    L_0x0215:
        r0 = r22;
        r0 = r0.mService;
        r19 = r0;
        r9 = r19.copyAnimToLayoutParamsLocked();
    L_0x021f:
        if (r11 != 0) goto L_0x0223;
    L_0x0221:
        if (r9 == 0) goto L_0x022c;
    L_0x0223:
        r0 = r22;
        r0 = r0.mService;
        r19 = r0;
        r19.requestTraversalLocked();
    L_0x022c:
        r0 = r22;
        r0 = r0.mAnimating;
        r19 = r0;
        if (r19 != 0) goto L_0x0008;
    L_0x0234:
        if (r17 == 0) goto L_0x0008;
    L_0x0236:
        r0 = r22;
        r0 = r0.mService;
        r19 = r0;
        r19.requestTraversalLocked();
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowAnimator.animateLocked():void");
    }

    static String bulkUpdateParamsToString(int bulkUpdateParams) {
        StringBuilder builder = new StringBuilder(DumpState.DUMP_PROVIDERS);
        if ((bulkUpdateParams & KEYGUARD_ANIMATING_IN) != 0) {
            builder.append(" UPDATE_ROTATION");
        }
        if ((bulkUpdateParams & KEYGUARD_SHOWN) != 0) {
            builder.append(" WALLPAPER_MAY_CHANGE");
        }
        if ((bulkUpdateParams & 4) != 0) {
            builder.append(" FORCE_HIDING_CHANGED");
        }
        if ((bulkUpdateParams & 8) != 0) {
            builder.append(" ORIENTATION_CHANGE_COMPLETE");
        }
        if ((bulkUpdateParams & 16) != 0) {
            builder.append(" TURN_ON_SCREEN");
        }
        return builder.toString();
    }

    public void dumpLocked(PrintWriter pw, String prefix, boolean dumpAll) {
        String subPrefix = "  " + prefix;
        String subSubPrefix = "  " + subPrefix;
        for (int i = KEYGUARD_NOT_SHOWN; i < this.mDisplayContentsAnimators.size(); i += KEYGUARD_ANIMATING_IN) {
            pw.print(prefix);
            pw.print("DisplayContentsAnimator #");
            pw.print(this.mDisplayContentsAnimators.keyAt(i));
            pw.println(":");
            DisplayContentsAnimator displayAnimator = (DisplayContentsAnimator) this.mDisplayContentsAnimators.valueAt(i);
            WindowList windows = this.mService.getWindowListLocked(this.mDisplayContentsAnimators.keyAt(i));
            int N = windows.size();
            for (int j = KEYGUARD_NOT_SHOWN; j < N; j += KEYGUARD_ANIMATING_IN) {
                WindowStateAnimator wanim = ((WindowState) windows.get(j)).mWinAnimator;
                pw.print(subPrefix);
                pw.print("Window #");
                pw.print(j);
                pw.print(": ");
                pw.println(wanim);
            }
            if (displayAnimator.mScreenRotationAnimation != null) {
                pw.print(subPrefix);
                pw.println("mScreenRotationAnimation:");
                displayAnimator.mScreenRotationAnimation.printTo(subSubPrefix, pw);
            } else if (dumpAll) {
                pw.print(subPrefix);
                pw.println("no ScreenRotationAnimation ");
            }
        }
        pw.println();
        if (dumpAll) {
            pw.print(prefix);
            pw.print("mAnimTransactionSequence=");
            pw.print(this.mAnimTransactionSequence);
            pw.print(" mForceHiding=");
            pw.println(forceHidingToString());
            pw.print(prefix);
            pw.print("mCurrentTime=");
            pw.println(TimeUtils.formatUptime(this.mCurrentTime));
        }
        if (this.mBulkUpdateParams != 0) {
            pw.print(prefix);
            pw.print("mBulkUpdateParams=0x");
            pw.print(Integer.toHexString(this.mBulkUpdateParams));
            pw.println(bulkUpdateParamsToString(this.mBulkUpdateParams));
        }
        if (this.mWindowDetachedWallpaper != null) {
            pw.print(prefix);
            pw.print("mWindowDetachedWallpaper=");
            pw.println(this.mWindowDetachedWallpaper);
        }
        if (this.mUniverseBackground != null) {
            pw.print(prefix);
            pw.print("mUniverseBackground=");
            pw.print(this.mUniverseBackground);
            pw.print(" mAboveUniverseLayer=");
            pw.println(this.mAboveUniverseLayer);
        }
    }

    int getPendingLayoutChanges(int displayId) {
        if (displayId < 0) {
            return KEYGUARD_NOT_SHOWN;
        }
        DisplayContent displayContent = this.mService.getDisplayContentLocked(displayId);
        if (displayContent != null) {
            return displayContent.pendingLayoutChanges;
        }
        return KEYGUARD_NOT_SHOWN;
    }

    void setPendingLayoutChanges(int displayId, int changes) {
        if (displayId >= 0) {
            DisplayContent displayContent = this.mService.getDisplayContentLocked(displayId);
            if (displayContent != null) {
                displayContent.pendingLayoutChanges |= changes;
            }
        }
    }

    void setAppLayoutChanges(AppWindowAnimator appAnimator, int changes, String s) {
        SparseIntArray displays = new SparseIntArray(KEYGUARD_SHOWN);
        WindowList windows = appAnimator.mAppToken.allAppWindows;
        for (int i = windows.size() - 1; i >= 0; i--) {
            int displayId = ((WindowState) windows.get(i)).getDisplayId();
            if (displayId >= 0 && displays.indexOfKey(displayId) < 0) {
                setPendingLayoutChanges(displayId, changes);
                this.mService.debugLayoutRepeats(s, getPendingLayoutChanges(displayId));
                displays.put(displayId, changes);
            }
        }
    }

    private DisplayContentsAnimator getDisplayContentsAnimatorLocked(int displayId) {
        DisplayContentsAnimator displayAnimator = (DisplayContentsAnimator) this.mDisplayContentsAnimators.get(displayId);
        if (displayAnimator != null) {
            return displayAnimator;
        }
        displayAnimator = new DisplayContentsAnimator();
        this.mDisplayContentsAnimators.put(displayId, displayAnimator);
        return displayAnimator;
    }

    void setScreenRotationAnimationLocked(int displayId, ScreenRotationAnimation animation) {
        if (displayId >= 0) {
            getDisplayContentsAnimatorLocked(displayId).mScreenRotationAnimation = animation;
        }
    }

    ScreenRotationAnimation getScreenRotationAnimationLocked(int displayId) {
        if (displayId < 0) {
            return null;
        }
        return getDisplayContentsAnimatorLocked(displayId).mScreenRotationAnimation;
    }
}
