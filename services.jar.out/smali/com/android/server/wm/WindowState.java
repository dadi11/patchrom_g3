package com.android.server.wm;

import android.app.AppOpsManager;
import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Matrix;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Region;
import android.os.Debug;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.util.Slog;
import android.util.TimeUtils;
import android.view.DisplayInfo;
import android.view.Gravity;
import android.view.IApplicationToken;
import android.view.IWindow;
import android.view.IWindowFocusObserver;
import android.view.IWindowId;
import android.view.IWindowId.Stub;
import android.view.InputChannel;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManagerPolicy;
import com.android.server.input.InputWindowHandle;
import com.android.server.voiceinteraction.SoundTriggerHelper;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.PrintWriter;

final class WindowState implements android.view.WindowManagerPolicy.WindowState {
    static final String TAG = "WindowState";
    boolean mAppFreezing;
    final int mAppOp;
    boolean mAppOpVisibility;
    AppWindowToken mAppToken;
    boolean mAttachedHidden;
    final WindowState mAttachedWindow;
    final LayoutParams mAttrs;
    final int mBaseLayer;
    final WindowList mChildWindows;
    final IWindow mClient;
    final Rect mCompatFrame;
    private boolean mConfigHasChanged;
    Configuration mConfiguration;
    final Rect mContainingFrame;
    boolean mContentChanged;
    final Rect mContentFrame;
    final Rect mContentInsets;
    boolean mContentInsetsChanged;
    final Context mContext;
    final DeathRecipient mDeathRecipient;
    final Rect mDecorFrame;
    boolean mDestroying;
    DisplayContent mDisplayContent;
    final Rect mDisplayFrame;
    boolean mEnforceSizeCompat;
    boolean mExiting;
    RemoteCallbackList<IWindowFocusObserver> mFocusCallbacks;
    final Rect mFrame;
    final Rect mGivenContentInsets;
    boolean mGivenInsetsPending;
    final Region mGivenTouchableRegion;
    final Rect mGivenVisibleInsets;
    float mGlobalScale;
    float mHScale;
    boolean mHasSurface;
    boolean mHaveFrame;
    InputChannel mInputChannel;
    final InputWindowHandle mInputWindowHandle;
    float mInvGlobalScale;
    final boolean mIsFloatingLayer;
    final boolean mIsImWindow;
    final boolean mIsWallpaper;
    final Rect mLastContentInsets;
    final Rect mLastFrame;
    int mLastFreezeDuration;
    float mLastHScale;
    final Rect mLastOverscanInsets;
    int mLastRequestedHeight;
    int mLastRequestedWidth;
    final Rect mLastStableInsets;
    final Rect mLastSystemDecorRect;
    CharSequence mLastTitle;
    float mLastVScale;
    final Rect mLastVisibleInsets;
    int mLayer;
    final boolean mLayoutAttached;
    boolean mLayoutNeeded;
    int mLayoutSeq;
    boolean mNotOnAppsDisplay;
    boolean mObscured;
    boolean mOrientationChanging;
    final Rect mOverscanFrame;
    final Rect mOverscanInsets;
    boolean mOverscanInsetsChanged;
    final int mOwnerUid;
    final Rect mParentFrame;
    final WindowManagerPolicy mPolicy;
    boolean mPolicyVisibility;
    boolean mPolicyVisibilityAfterAnim;
    boolean mRebuilding;
    boolean mRelayoutCalled;
    boolean mRemoveOnExit;
    boolean mRemoved;
    int mRequestedHeight;
    int mRequestedWidth;
    WindowToken mRootToken;
    int mSeq;
    final WindowManagerService mService;
    final Session mSession;
    private boolean mShowToOwnerOnly;
    final RectF mShownFrame;
    final Rect mStableFrame;
    final Rect mStableInsets;
    boolean mStableInsetsChanged;
    String mStringNameCache;
    final int mSubLayer;
    final Rect mSystemDecorRect;
    int mSystemUiVisibility;
    AppWindowToken mTargetAppToken;
    final Matrix mTmpMatrix;
    WindowToken mToken;
    int mTouchableInsets;
    boolean mTurnOnScreen;
    boolean mUnderStatusBar;
    float mVScale;
    int mViewVisibility;
    final Rect mVisibleFrame;
    final Rect mVisibleInsets;
    boolean mVisibleInsetsChanged;
    int mWallpaperDisplayOffsetX;
    int mWallpaperDisplayOffsetY;
    boolean mWallpaperVisible;
    float mWallpaperX;
    float mWallpaperXStep;
    float mWallpaperY;
    float mWallpaperYStep;
    boolean mWasExiting;
    final WindowStateAnimator mWinAnimator;
    final IWindowId mWindowId;
    int mXOffset;
    int mYOffset;

    /* renamed from: com.android.server.wm.WindowState.1 */
    class C05701 extends Stub {
        C05701() {
        }

        public void registerFocusObserver(IWindowFocusObserver observer) {
            WindowState.this.registerFocusObserver(observer);
        }

        public void unregisterFocusObserver(IWindowFocusObserver observer) {
            WindowState.this.unregisterFocusObserver(observer);
        }

        public boolean isFocused() {
            return WindowState.this.isFocused();
        }
    }

    /* renamed from: com.android.server.wm.WindowState.2 */
    class C05712 implements Runnable {
        final /* synthetic */ Rect val$contentInsets;
        final /* synthetic */ Rect val$frame;
        final /* synthetic */ Configuration val$newConfig;
        final /* synthetic */ Rect val$overscanInsets;
        final /* synthetic */ boolean val$reportDraw;
        final /* synthetic */ Rect val$stableInsets;
        final /* synthetic */ Rect val$visibleInsets;

        C05712(Rect rect, Rect rect2, Rect rect3, Rect rect4, Rect rect5, boolean z, Configuration configuration) {
            this.val$frame = rect;
            this.val$overscanInsets = rect2;
            this.val$contentInsets = rect3;
            this.val$visibleInsets = rect4;
            this.val$stableInsets = rect5;
            this.val$reportDraw = z;
            this.val$newConfig = configuration;
        }

        public void run() {
            try {
                WindowState.this.mClient.resized(this.val$frame, this.val$overscanInsets, this.val$contentInsets, this.val$visibleInsets, this.val$stableInsets, this.val$reportDraw, this.val$newConfig);
            } catch (RemoteException e) {
            }
        }
    }

    private class DeathRecipient implements android.os.IBinder.DeathRecipient {
        private DeathRecipient() {
        }

        public void binderDied() {
            try {
                synchronized (WindowState.this.mService.mWindowMap) {
                    WindowState win = WindowState.this.mService.windowForClientLocked(WindowState.this.mSession, WindowState.this.mClient, false);
                    Slog.i(WindowState.TAG, "WIN DEATH: " + win);
                    if (win != null) {
                        WindowState.this.mService.removeWindowLocked(WindowState.this.mSession, win);
                    } else if (WindowState.this.mHasSurface) {
                        Slog.e(WindowState.TAG, "!!! LEAK !!! Window removed but surface still valid.");
                        WindowState.this.mService.removeWindowLocked(WindowState.this.mSession, WindowState.this);
                    }
                }
            } catch (IllegalArgumentException e) {
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    WindowState(com.android.server.wm.WindowManagerService r16, com.android.server.wm.Session r17, android.view.IWindow r18, com.android.server.wm.WindowToken r19, com.android.server.wm.WindowState r20, int r21, int r22, android.view.WindowManager.LayoutParams r23, int r24, com.android.server.wm.DisplayContent r25) {
        /*
        r15 = this;
        r15.<init>();
        r12 = new android.view.WindowManager$LayoutParams;
        r12.<init>();
        r15.mAttrs = r12;
        r12 = new com.android.server.wm.WindowList;
        r12.<init>();
        r15.mChildWindows = r12;
        r12 = 1;
        r15.mPolicyVisibility = r12;
        r12 = 1;
        r15.mPolicyVisibilityAfterAnim = r12;
        r12 = 1;
        r15.mAppOpVisibility = r12;
        r12 = -1;
        r15.mLayoutSeq = r12;
        r12 = 0;
        r15.mConfiguration = r12;
        r12 = new android.graphics.RectF;
        r12.<init>();
        r15.mShownFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mVisibleInsets = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mLastVisibleInsets = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mContentInsets = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mLastContentInsets = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mOverscanInsets = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mLastOverscanInsets = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mStableInsets = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mLastStableInsets = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mGivenContentInsets = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mGivenVisibleInsets = r12;
        r12 = new android.graphics.Region;
        r12.<init>();
        r15.mGivenTouchableRegion = r12;
        r12 = 0;
        r15.mTouchableInsets = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mSystemDecorRect = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mLastSystemDecorRect = r12;
        r12 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r15.mGlobalScale = r12;
        r12 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r15.mInvGlobalScale = r12;
        r12 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r15.mHScale = r12;
        r12 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r15.mVScale = r12;
        r12 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r15.mLastHScale = r12;
        r12 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r15.mLastVScale = r12;
        r12 = new android.graphics.Matrix;
        r12.<init>();
        r15.mTmpMatrix = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mLastFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mCompatFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mContainingFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mParentFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mDisplayFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mOverscanFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mStableFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mDecorFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mContentFrame = r12;
        r12 = new android.graphics.Rect;
        r12.<init>();
        r15.mVisibleFrame = r12;
        r12 = -1082130432; // 0xffffffffbf800000 float:-1.0 double:NaN;
        r15.mWallpaperX = r12;
        r12 = -1082130432; // 0xffffffffbf800000 float:-1.0 double:NaN;
        r15.mWallpaperY = r12;
        r12 = -1082130432; // 0xffffffffbf800000 float:-1.0 double:NaN;
        r15.mWallpaperXStep = r12;
        r12 = -1082130432; // 0xffffffffbf800000 float:-1.0 double:NaN;
        r15.mWallpaperYStep = r12;
        r12 = -2147483648; // 0xffffffff80000000 float:-0.0 double:NaN;
        r15.mWallpaperDisplayOffsetX = r12;
        r12 = -2147483648; // 0xffffffff80000000 float:-0.0 double:NaN;
        r15.mWallpaperDisplayOffsetY = r12;
        r12 = 0;
        r15.mHasSurface = r12;
        r12 = 0;
        r15.mNotOnAppsDisplay = r12;
        r12 = 1;
        r15.mUnderStatusBar = r12;
        r0 = r16;
        r15.mService = r0;
        r0 = r17;
        r15.mSession = r0;
        r0 = r18;
        r15.mClient = r0;
        r0 = r21;
        r15.mAppOp = r0;
        r0 = r19;
        r15.mToken = r0;
        r0 = r17;
        r12 = r0.mUid;
        r15.mOwnerUid = r12;
        r12 = new com.android.server.wm.WindowState$1;
        r12.<init>();
        r15.mWindowId = r12;
        r12 = r15.mAttrs;
        r0 = r23;
        r12.copyFrom(r0);
        r0 = r24;
        r15.mViewVisibility = r0;
        r0 = r25;
        r15.mDisplayContent = r0;
        r12 = r15.mService;
        r12 = r12.mPolicy;
        r15.mPolicy = r12;
        r12 = r15.mService;
        r12 = r12.mContext;
        r15.mContext = r12;
        r7 = new com.android.server.wm.WindowState$DeathRecipient;
        r12 = 0;
        r7.<init>(r12);
        r0 = r22;
        r15.mSeq = r0;
        r12 = r15.mAttrs;
        r12 = r12.privateFlags;
        r12 = r12 & 128;
        if (r12 == 0) goto L_0x01ee;
    L_0x0160:
        r12 = 1;
    L_0x0161:
        r15.mEnforceSizeCompat = r12;
        r12 = r18.asBinder();	 Catch:{ RemoteException -> 0x01f1 }
        r13 = 0;
        r12.linkToDeath(r7, r13);	 Catch:{ RemoteException -> 0x01f1 }
        r15.mDeathRecipient = r7;
        r12 = r15.mAttrs;
        r12 = r12.type;
        r13 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        if (r12 < r13) goto L_0x023e;
    L_0x0175:
        r12 = r15.mAttrs;
        r12 = r12.type;
        r13 = 1999; // 0x7cf float:2.801E-42 double:9.876E-321;
        if (r12 > r13) goto L_0x023e;
    L_0x017d:
        r12 = r15.mPolicy;
        r0 = r20;
        r13 = r0.mAttrs;
        r13 = r13.type;
        r12 = r12.windowTypeToLayerLw(r13);
        r12 = r12 * 10000;
        r12 = r12 + 1000;
        r15.mBaseLayer = r12;
        r12 = r15.mPolicy;
        r0 = r23;
        r13 = r0.type;
        r12 = r12.subWindowTypeToLayerLw(r13);
        r15.mSubLayer = r12;
        r0 = r20;
        r15.mAttachedWindow = r0;
        r12 = r15.mAttachedWindow;
        r6 = r12.mChildWindows;
        r10 = r6.size();
        if (r10 != 0) goto L_0x0211;
    L_0x01a9:
        r6.add(r15);
    L_0x01ac:
        r12 = r15.mAttrs;
        r12 = r12.type;
        r13 = 1003; // 0x3eb float:1.406E-42 double:4.955E-321;
        if (r12 == r13) goto L_0x0235;
    L_0x01b4:
        r12 = 1;
    L_0x01b5:
        r15.mLayoutAttached = r12;
        r0 = r20;
        r12 = r0.mAttrs;
        r12 = r12.type;
        r13 = 2011; // 0x7db float:2.818E-42 double:9.936E-321;
        if (r12 == r13) goto L_0x01cb;
    L_0x01c1:
        r0 = r20;
        r12 = r0.mAttrs;
        r12 = r12.type;
        r13 = 2012; // 0x7dc float:2.82E-42 double:9.94E-321;
        if (r12 != r13) goto L_0x0238;
    L_0x01cb:
        r12 = 1;
    L_0x01cc:
        r15.mIsImWindow = r12;
        r0 = r20;
        r12 = r0.mAttrs;
        r12 = r12.type;
        r13 = 2013; // 0x7dd float:2.821E-42 double:9.946E-321;
        if (r12 != r13) goto L_0x023a;
    L_0x01d8:
        r12 = 1;
    L_0x01d9:
        r15.mIsWallpaper = r12;
        r12 = r15.mIsImWindow;
        if (r12 != 0) goto L_0x01e3;
    L_0x01df:
        r12 = r15.mIsWallpaper;
        if (r12 == 0) goto L_0x023c;
    L_0x01e3:
        r12 = 1;
    L_0x01e4:
        r15.mIsFloatingLayer = r12;
    L_0x01e6:
        r4 = r15;
    L_0x01e7:
        r12 = r4.mAttachedWindow;
        if (r12 == 0) goto L_0x0288;
    L_0x01eb:
        r4 = r4.mAttachedWindow;
        goto L_0x01e7;
    L_0x01ee:
        r12 = 0;
        goto L_0x0161;
    L_0x01f1:
        r8 = move-exception;
        r12 = 0;
        r15.mDeathRecipient = r12;
        r12 = 0;
        r15.mAttachedWindow = r12;
        r12 = 0;
        r15.mLayoutAttached = r12;
        r12 = 0;
        r15.mIsImWindow = r12;
        r12 = 0;
        r15.mIsWallpaper = r12;
        r12 = 0;
        r15.mIsFloatingLayer = r12;
        r12 = 0;
        r15.mBaseLayer = r12;
        r12 = 0;
        r15.mSubLayer = r12;
        r12 = 0;
        r15.mInputWindowHandle = r12;
        r12 = 0;
        r15.mWinAnimator = r12;
    L_0x0210:
        return;
    L_0x0211:
        r1 = 0;
        r9 = 0;
    L_0x0213:
        if (r9 >= r10) goto L_0x022b;
    L_0x0215:
        r12 = r6.get(r9);
        r12 = (com.android.server.wm.WindowState) r12;
        r5 = r12.mSubLayer;
        r12 = r15.mSubLayer;
        if (r12 < r5) goto L_0x0227;
    L_0x0221:
        r12 = r15.mSubLayer;
        if (r12 != r5) goto L_0x0232;
    L_0x0225:
        if (r5 >= 0) goto L_0x0232;
    L_0x0227:
        r6.add(r9, r15);
        r1 = 1;
    L_0x022b:
        if (r1 != 0) goto L_0x01ac;
    L_0x022d:
        r6.add(r15);
        goto L_0x01ac;
    L_0x0232:
        r9 = r9 + 1;
        goto L_0x0213;
    L_0x0235:
        r12 = 0;
        goto L_0x01b5;
    L_0x0238:
        r12 = 0;
        goto L_0x01cc;
    L_0x023a:
        r12 = 0;
        goto L_0x01d9;
    L_0x023c:
        r12 = 0;
        goto L_0x01e4;
    L_0x023e:
        r12 = r15.mPolicy;
        r0 = r23;
        r13 = r0.type;
        r12 = r12.windowTypeToLayerLw(r13);
        r12 = r12 * 10000;
        r12 = r12 + 1000;
        r15.mBaseLayer = r12;
        r12 = 0;
        r15.mSubLayer = r12;
        r12 = 0;
        r15.mAttachedWindow = r12;
        r12 = 0;
        r15.mLayoutAttached = r12;
        r12 = r15.mAttrs;
        r12 = r12.type;
        r13 = 2011; // 0x7db float:2.818E-42 double:9.936E-321;
        if (r12 == r13) goto L_0x0267;
    L_0x025f:
        r12 = r15.mAttrs;
        r12 = r12.type;
        r13 = 2012; // 0x7dc float:2.82E-42 double:9.94E-321;
        if (r12 != r13) goto L_0x0282;
    L_0x0267:
        r12 = 1;
    L_0x0268:
        r15.mIsImWindow = r12;
        r12 = r15.mAttrs;
        r12 = r12.type;
        r13 = 2013; // 0x7dd float:2.821E-42 double:9.946E-321;
        if (r12 != r13) goto L_0x0284;
    L_0x0272:
        r12 = 1;
    L_0x0273:
        r15.mIsWallpaper = r12;
        r12 = r15.mIsImWindow;
        if (r12 != 0) goto L_0x027d;
    L_0x0279:
        r12 = r15.mIsWallpaper;
        if (r12 == 0) goto L_0x0286;
    L_0x027d:
        r12 = 1;
    L_0x027e:
        r15.mIsFloatingLayer = r12;
        goto L_0x01e6;
    L_0x0282:
        r12 = 0;
        goto L_0x0268;
    L_0x0284:
        r12 = 0;
        goto L_0x0273;
    L_0x0286:
        r12 = 0;
        goto L_0x027e;
    L_0x0288:
        r3 = r4.mToken;
    L_0x028a:
        r12 = r3.appWindowToken;
        if (r12 != 0) goto L_0x029e;
    L_0x028e:
        r12 = r15.mService;
        r12 = r12.mTokenMap;
        r13 = r3.token;
        r11 = r12.get(r13);
        r11 = (com.android.server.wm.WindowToken) r11;
        if (r11 == 0) goto L_0x029e;
    L_0x029c:
        if (r3 != r11) goto L_0x02ec;
    L_0x029e:
        r15.mRootToken = r3;
        r12 = r3.appWindowToken;
        r15.mAppToken = r12;
        r12 = r15.mAppToken;
        if (r12 == 0) goto L_0x02b3;
    L_0x02a8:
        r2 = r15.getDisplayContent();
        r0 = r25;
        if (r0 == r2) goto L_0x02ee;
    L_0x02b0:
        r12 = 1;
    L_0x02b1:
        r15.mNotOnAppsDisplay = r12;
    L_0x02b3:
        r12 = new com.android.server.wm.WindowStateAnimator;
        r12.<init>(r15);
        r15.mWinAnimator = r12;
        r12 = r15.mWinAnimator;
        r0 = r23;
        r13 = r0.alpha;
        r12.mAlpha = r13;
        r12 = 0;
        r15.mRequestedWidth = r12;
        r12 = 0;
        r15.mRequestedHeight = r12;
        r12 = 0;
        r15.mLastRequestedWidth = r12;
        r12 = 0;
        r15.mLastRequestedHeight = r12;
        r12 = 0;
        r15.mXOffset = r12;
        r12 = 0;
        r15.mYOffset = r12;
        r12 = 0;
        r15.mLayer = r12;
        r13 = new com.android.server.input.InputWindowHandle;
        r12 = r15.mAppToken;
        if (r12 == 0) goto L_0x02f0;
    L_0x02dd:
        r12 = r15.mAppToken;
        r12 = r12.mInputApplicationHandle;
    L_0x02e1:
        r14 = r25.getDisplayId();
        r13.<init>(r12, r15, r14);
        r15.mInputWindowHandle = r13;
        goto L_0x0210;
    L_0x02ec:
        r3 = r11;
        goto L_0x028a;
    L_0x02ee:
        r12 = 0;
        goto L_0x02b1;
    L_0x02f0:
        r12 = 0;
        goto L_0x02e1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowState.<init>(com.android.server.wm.WindowManagerService, com.android.server.wm.Session, android.view.IWindow, com.android.server.wm.WindowToken, com.android.server.wm.WindowState, int, int, android.view.WindowManager$LayoutParams, int, com.android.server.wm.DisplayContent):void");
    }

    void attach() {
        this.mSession.windowAddedLocked();
    }

    public int getOwningUid() {
        return this.mOwnerUid;
    }

    public String getOwningPackage() {
        return this.mAttrs.packageName;
    }

    public void computeFrameLw(Rect pf, Rect df, Rect of, Rect cf, Rect vf, Rect dcf, Rect sf) {
        int w;
        int h;
        float x;
        float y;
        this.mHaveFrame = true;
        TaskStack stack = this.mAppToken != null ? getStack() : null;
        if (stack == null || stack.isFullscreen()) {
            this.mContainingFrame.set(pf);
        } else {
            getStackBounds(stack, this.mContainingFrame);
            if (this.mUnderStatusBar) {
                this.mContainingFrame.top = pf.top;
            }
        }
        this.mDisplayFrame.set(df);
        int pw = this.mContainingFrame.width();
        int ph = this.mContainingFrame.height();
        if ((this.mAttrs.flags & 16384) != 0) {
            if (this.mAttrs.width < 0) {
                w = pw;
            } else if (this.mEnforceSizeCompat) {
                w = (int) ((((float) this.mAttrs.width) * this.mGlobalScale) + 0.5f);
            } else {
                w = this.mAttrs.width;
            }
            if (this.mAttrs.height < 0) {
                h = ph;
            } else if (this.mEnforceSizeCompat) {
                h = (int) ((((float) this.mAttrs.height) * this.mGlobalScale) + 0.5f);
            } else {
                h = this.mAttrs.height;
            }
        } else {
            if (this.mAttrs.width == -1) {
                w = pw;
            } else if (this.mEnforceSizeCompat) {
                w = (int) ((((float) this.mRequestedWidth) * this.mGlobalScale) + 0.5f);
            } else {
                w = this.mRequestedWidth;
            }
            if (this.mAttrs.height == -1) {
                h = ph;
            } else if (this.mEnforceSizeCompat) {
                h = (int) ((((float) this.mRequestedHeight) * this.mGlobalScale) + 0.5f);
            } else {
                h = this.mRequestedHeight;
            }
        }
        if (!this.mParentFrame.equals(pf)) {
            this.mParentFrame.set(pf);
            this.mContentChanged = true;
        }
        if (!(this.mRequestedWidth == this.mLastRequestedWidth && this.mRequestedHeight == this.mLastRequestedHeight)) {
            this.mLastRequestedWidth = this.mRequestedWidth;
            this.mLastRequestedHeight = this.mRequestedHeight;
            this.mContentChanged = true;
        }
        this.mOverscanFrame.set(of);
        this.mContentFrame.set(cf);
        this.mVisibleFrame.set(vf);
        this.mDecorFrame.set(dcf);
        this.mStableFrame.set(sf);
        int fw = this.mFrame.width();
        int fh = this.mFrame.height();
        if (this.mEnforceSizeCompat) {
            x = ((float) this.mAttrs.x) * this.mGlobalScale;
            y = ((float) this.mAttrs.y) * this.mGlobalScale;
        } else {
            x = (float) this.mAttrs.x;
            y = (float) this.mAttrs.y;
        }
        Gravity.apply(this.mAttrs.gravity, w, h, this.mContainingFrame, (int) ((this.mAttrs.horizontalMargin * ((float) pw)) + x), (int) ((this.mAttrs.verticalMargin * ((float) ph)) + y), this.mFrame);
        Gravity.applyDisplay(this.mAttrs.gravity, df, this.mFrame);
        this.mContentFrame.set(Math.max(this.mContentFrame.left, this.mFrame.left), Math.max(this.mContentFrame.top, this.mFrame.top), Math.min(this.mContentFrame.right, this.mFrame.right), Math.min(this.mContentFrame.bottom, this.mFrame.bottom));
        this.mVisibleFrame.set(Math.max(this.mVisibleFrame.left, this.mFrame.left), Math.max(this.mVisibleFrame.top, this.mFrame.top), Math.min(this.mVisibleFrame.right, this.mFrame.right), Math.min(this.mVisibleFrame.bottom, this.mFrame.bottom));
        this.mStableFrame.set(Math.max(this.mStableFrame.left, this.mFrame.left), Math.max(this.mStableFrame.top, this.mFrame.top), Math.min(this.mStableFrame.right, this.mFrame.right), Math.min(this.mStableFrame.bottom, this.mFrame.bottom));
        this.mOverscanInsets.set(Math.max(this.mOverscanFrame.left - this.mFrame.left, 0), Math.max(this.mOverscanFrame.top - this.mFrame.top, 0), Math.max(this.mFrame.right - this.mOverscanFrame.right, 0), Math.max(this.mFrame.bottom - this.mOverscanFrame.bottom, 0));
        this.mContentInsets.set(this.mContentFrame.left - this.mFrame.left, this.mContentFrame.top - this.mFrame.top, this.mFrame.right - this.mContentFrame.right, this.mFrame.bottom - this.mContentFrame.bottom);
        this.mVisibleInsets.set(this.mVisibleFrame.left - this.mFrame.left, this.mVisibleFrame.top - this.mFrame.top, this.mFrame.right - this.mVisibleFrame.right, this.mFrame.bottom - this.mVisibleFrame.bottom);
        this.mStableInsets.set(Math.max(this.mStableFrame.left - this.mFrame.left, 0), Math.max(this.mStableFrame.top - this.mFrame.top, 0), Math.max(this.mFrame.right - this.mStableFrame.right, 0), Math.max(this.mFrame.bottom - this.mStableFrame.bottom, 0));
        this.mCompatFrame.set(this.mFrame);
        if (this.mEnforceSizeCompat) {
            this.mOverscanInsets.scale(this.mInvGlobalScale);
            this.mContentInsets.scale(this.mInvGlobalScale);
            this.mVisibleInsets.scale(this.mInvGlobalScale);
            this.mStableInsets.scale(this.mInvGlobalScale);
            this.mCompatFrame.scale(this.mInvGlobalScale);
        }
        if (!this.mIsWallpaper) {
            return;
        }
        if (fw != this.mFrame.width() || fh != this.mFrame.height()) {
            DisplayContent displayContent = getDisplayContent();
            if (displayContent != null) {
                DisplayInfo displayInfo = displayContent.getDisplayInfo();
                this.mService.updateWallpaperOffsetLocked(this, displayInfo.logicalWidth, displayInfo.logicalHeight, false);
            }
        }
    }

    public Rect getFrameLw() {
        return this.mFrame;
    }

    public RectF getShownFrameLw() {
        return this.mShownFrame;
    }

    public Rect getDisplayFrameLw() {
        return this.mDisplayFrame;
    }

    public Rect getOverscanFrameLw() {
        return this.mOverscanFrame;
    }

    public Rect getContentFrameLw() {
        return this.mContentFrame;
    }

    public Rect getVisibleFrameLw() {
        return this.mVisibleFrame;
    }

    public boolean getGivenInsetsPendingLw() {
        return this.mGivenInsetsPending;
    }

    public Rect getGivenContentInsetsLw() {
        return this.mGivenContentInsets;
    }

    public Rect getGivenVisibleInsetsLw() {
        return this.mGivenVisibleInsets;
    }

    public LayoutParams getAttrs() {
        return this.mAttrs;
    }

    public boolean getNeedsMenuLw(android.view.WindowManagerPolicy.WindowState bottom) {
        boolean z = true;
        int index = -1;
        android.view.WindowManagerPolicy.WindowState ws = this;
        WindowList windows = getWindowList();
        while (ws.mAttrs.needsMenuKey == 0) {
            if (ws == bottom) {
                return false;
            }
            if (index < 0) {
                index = windows.indexOf(ws);
            }
            index--;
            if (index < 0) {
                return false;
            }
            WindowState ws2 = (WindowState) windows.get(index);
        }
        if (ws.mAttrs.needsMenuKey != 1) {
            z = false;
        }
        return z;
    }

    public int getSystemUiVisibility() {
        return this.mSystemUiVisibility;
    }

    public int getSurfaceLayer() {
        return this.mLayer;
    }

    public IApplicationToken getAppToken() {
        return this.mAppToken != null ? this.mAppToken.appToken : null;
    }

    public boolean isVoiceInteraction() {
        return this.mAppToken != null ? this.mAppToken.voiceInteraction : false;
    }

    boolean setInsetsChanged() {
        int i;
        boolean z = this.mOverscanInsetsChanged;
        if (this.mLastOverscanInsets.equals(this.mOverscanInsets)) {
            i = 0;
        } else {
            i = 1;
        }
        this.mOverscanInsetsChanged = i | z;
        z = this.mContentInsetsChanged;
        if (this.mLastContentInsets.equals(this.mContentInsets)) {
            i = 0;
        } else {
            i = 1;
        }
        this.mContentInsetsChanged = i | z;
        z = this.mVisibleInsetsChanged;
        if (this.mLastVisibleInsets.equals(this.mVisibleInsets)) {
            i = 0;
        } else {
            i = 1;
        }
        this.mVisibleInsetsChanged = i | z;
        z = this.mStableInsetsChanged;
        if (this.mLastStableInsets.equals(this.mStableInsets)) {
            i = 0;
        } else {
            i = 1;
        }
        this.mStableInsetsChanged = i | z;
        if (this.mOverscanInsetsChanged || this.mContentInsetsChanged || this.mVisibleInsetsChanged) {
            return true;
        }
        return false;
    }

    public DisplayContent getDisplayContent() {
        if (this.mAppToken == null || this.mNotOnAppsDisplay) {
            return this.mDisplayContent;
        }
        TaskStack stack = getStack();
        return stack == null ? this.mDisplayContent : stack.getDisplayContent();
    }

    public int getDisplayId() {
        DisplayContent displayContent = getDisplayContent();
        if (displayContent == null) {
            return -1;
        }
        return displayContent.getDisplayId();
    }

    TaskStack getStack() {
        AppWindowToken wtoken = this.mAppToken == null ? this.mService.mFocusedApp : this.mAppToken;
        if (wtoken != null) {
            Task task = (Task) this.mService.mTaskIdToTask.get(wtoken.groupId);
            if (task == null) {
                Slog.e(TAG, "getStack: " + this + " couldn't find taskId=" + wtoken.groupId + " Callers=" + Debug.getCallers(4));
            } else if (task.mStack != null) {
                return task.mStack;
            } else {
                Slog.e(TAG, "getStack: mStack null for task=" + task);
            }
        }
        return this.mDisplayContent.getHomeStack();
    }

    void getStackBounds(Rect bounds) {
        getStackBounds(getStack(), bounds);
    }

    private void getStackBounds(TaskStack stack, Rect bounds) {
        if (stack != null) {
            stack.getBounds(bounds);
        } else {
            bounds.set(this.mFrame);
        }
    }

    public long getInputDispatchingTimeoutNanos() {
        return this.mAppToken != null ? this.mAppToken.inputDispatchingTimeoutNanos : 5000000000L;
    }

    public boolean hasAppShownWindows() {
        return this.mAppToken != null && (this.mAppToken.firstWindowDrawn || this.mAppToken.startingDisplayed);
    }

    boolean isIdentityMatrix(float dsdx, float dtdx, float dsdy, float dtdy) {
        if (dsdx < 0.99999f || dsdx > 1.00001f || dtdy < 0.99999f || dtdy > 1.00001f || dtdx < -1.0E-6f || dtdx > 1.0E-6f || dsdy < -1.0E-6f || dsdy > 1.0E-6f) {
            return false;
        }
        return true;
    }

    void prelayout() {
        if (this.mEnforceSizeCompat) {
            this.mGlobalScale = this.mService.mCompatibleScreenScale;
            this.mInvGlobalScale = 1.0f / this.mGlobalScale;
            return;
        }
        this.mInvGlobalScale = 1.0f;
        this.mGlobalScale = 1.0f;
    }

    public boolean isVisibleLw() {
        AppWindowToken atoken = this.mAppToken;
        return this.mHasSurface && this.mPolicyVisibility && !this.mAttachedHidden && !((atoken != null && atoken.hiddenRequested) || this.mExiting || this.mDestroying);
    }

    public boolean isVisibleOrBehindKeyguardLw() {
        boolean z = true;
        if (this.mRootToken.waitingToShow && this.mService.mAppTransition.isTransitionSet()) {
            return false;
        }
        AppWindowToken atoken = this.mAppToken;
        boolean animating = atoken != null ? atoken.mAppAnimator.animation != null : false;
        if (!this.mHasSurface || this.mDestroying || this.mExiting || (atoken != null ? !atoken.hiddenRequested : this.mPolicyVisibility) || ((this.mAttachedHidden || this.mViewVisibility != 0 || this.mRootToken.hidden) && this.mWinAnimator.mAnimation == null && !animating)) {
            z = false;
        }
        return z;
    }

    public boolean isWinVisibleLw() {
        AppWindowToken atoken = this.mAppToken;
        return this.mHasSurface && this.mPolicyVisibility && !this.mAttachedHidden && !((atoken != null && atoken.hiddenRequested && !atoken.mAppAnimator.animating) || this.mExiting || this.mDestroying);
    }

    boolean isVisibleNow() {
        return this.mHasSurface && this.mPolicyVisibility && !this.mAttachedHidden && !((this.mRootToken.hidden && this.mAttrs.type != 3) || this.mExiting || this.mDestroying);
    }

    boolean isPotentialDragTarget() {
        return (!isVisibleNow() || this.mRemoved || this.mInputChannel == null || this.mInputWindowHandle == null) ? false : true;
    }

    boolean isVisibleOrAdding() {
        AppWindowToken atoken = this.mAppToken;
        return (this.mHasSurface || (!this.mRelayoutCalled && this.mViewVisibility == 0)) && this.mPolicyVisibility && !this.mAttachedHidden && !((atoken != null && atoken.hiddenRequested) || this.mExiting || this.mDestroying);
    }

    boolean isOnScreen() {
        return this.mPolicyVisibility && isOnScreenIgnoringKeyguard();
    }

    boolean isOnScreenIgnoringKeyguard() {
        if (!this.mHasSurface || this.mDestroying) {
            return false;
        }
        AppWindowToken atoken = this.mAppToken;
        if (atoken != null) {
            if ((this.mAttachedHidden || atoken.hiddenRequested) && this.mWinAnimator.mAnimation == null && atoken.mAppAnimator.animation == null) {
                return false;
            }
            return true;
        } else if (this.mAttachedHidden && this.mWinAnimator.mAnimation == null) {
            return false;
        } else {
            return true;
        }
    }

    boolean isReadyForDisplay() {
        if ((this.mRootToken.waitingToShow && this.mService.mAppTransition.isTransitionSet()) || !this.mHasSurface || !this.mPolicyVisibility || this.mDestroying) {
            return false;
        }
        if ((this.mAttachedHidden || this.mViewVisibility != 0 || this.mRootToken.hidden) && this.mWinAnimator.mAnimation == null && (this.mAppToken == null || this.mAppToken.mAppAnimator.animation == null)) {
            return false;
        }
        return true;
    }

    boolean isReadyForDisplayIgnoringKeyguard() {
        if (this.mRootToken.waitingToShow && this.mService.mAppTransition.isTransitionSet()) {
            return false;
        }
        AppWindowToken atoken = this.mAppToken;
        if ((atoken == null && !this.mPolicyVisibility) || !this.mHasSurface || this.mDestroying) {
            return false;
        }
        if ((this.mAttachedHidden || this.mViewVisibility != 0 || this.mRootToken.hidden) && this.mWinAnimator.mAnimation == null && (atoken == null || atoken.mAppAnimator.animation == null || this.mWinAnimator.isDummyAnimation())) {
            return false;
        }
        return true;
    }

    public boolean isDisplayedLw() {
        AppWindowToken atoken = this.mAppToken;
        return isDrawnLw() && this.mPolicyVisibility && ((!this.mAttachedHidden && (atoken == null || !atoken.hiddenRequested)) || this.mWinAnimator.mAnimating || !(atoken == null || atoken.mAppAnimator.animation == null));
    }

    public boolean isAnimatingLw() {
        return (this.mWinAnimator.mAnimation == null && (this.mAppToken == null || this.mAppToken.mAppAnimator.animation == null)) ? false : true;
    }

    public boolean isGoneForLayoutLw() {
        AppWindowToken atoken = this.mAppToken;
        return this.mViewVisibility == 8 || !this.mRelayoutCalled || ((atoken == null && this.mRootToken.hidden) || ((atoken != null && (atoken.hiddenRequested || atoken.hidden)) || this.mAttachedHidden || ((this.mExiting && !isAnimatingLw()) || this.mDestroying)));
    }

    public boolean isDrawFinishedLw() {
        return this.mHasSurface && !this.mDestroying && (this.mWinAnimator.mDrawState == 2 || this.mWinAnimator.mDrawState == 3 || this.mWinAnimator.mDrawState == 4);
    }

    public boolean isDrawnLw() {
        return this.mHasSurface && !this.mDestroying && (this.mWinAnimator.mDrawState == 3 || this.mWinAnimator.mDrawState == 4);
    }

    boolean isOpaqueDrawn() {
        return (this.mAttrs.format == -1 || this.mAttrs.type == 2013) && isDrawnLw() && this.mWinAnimator.mAnimation == null && (this.mAppToken == null || this.mAppToken.mAppAnimator.animation == null);
    }

    boolean shouldAnimateMove() {
        return this.mContentChanged && !this.mExiting && !this.mWinAnimator.mLastHidden && this.mService.okToDisplay() && (!(this.mFrame.top == this.mLastFrame.top && this.mFrame.left == this.mLastFrame.left) && (this.mAttrs.privateFlags & 64) == 0 && (this.mAttachedWindow == null || !this.mAttachedWindow.shouldAnimateMove()));
    }

    boolean isFullscreen(int screenWidth, int screenHeight) {
        return this.mFrame.left <= 0 && this.mFrame.top <= 0 && this.mFrame.right >= screenWidth && this.mFrame.bottom >= screenHeight;
    }

    boolean isConfigChanged() {
        boolean configChanged = this.mConfiguration != this.mService.mCurConfiguration && (this.mConfiguration == null || this.mConfiguration.diff(this.mService.mCurConfiguration) != 0);
        if ((this.mAttrs.privateFlags & DumpState.DUMP_PREFERRED_XML) == 0) {
            return configChanged;
        }
        this.mConfigHasChanged |= configChanged;
        return this.mConfigHasChanged;
    }

    void removeLocked() {
        disposeInputChannel();
        if (this.mAttachedWindow != null) {
            this.mAttachedWindow.mChildWindows.remove(this);
        }
        this.mWinAnimator.destroyDeferredSurfaceLocked();
        this.mWinAnimator.destroySurfaceLocked();
        this.mSession.windowRemovedLocked();
        try {
            this.mClient.asBinder().unlinkToDeath(this.mDeathRecipient, 0);
        } catch (RuntimeException e) {
        }
    }

    void setConfiguration(Configuration newConfig) {
        this.mConfiguration = newConfig;
        this.mConfigHasChanged = false;
    }

    void setInputChannel(InputChannel inputChannel) {
        if (this.mInputChannel != null) {
            throw new IllegalStateException("Window already has an input channel.");
        }
        this.mInputChannel = inputChannel;
        this.mInputWindowHandle.inputChannel = inputChannel;
    }

    void disposeInputChannel() {
        if (this.mInputChannel != null) {
            this.mService.mInputManager.unregisterInputChannel(this.mInputChannel);
            this.mInputChannel.dispose();
            this.mInputChannel = null;
        }
        this.mInputWindowHandle.inputChannel = null;
    }

    public final boolean canReceiveKeys() {
        return isVisibleOrAdding() && this.mViewVisibility == 0 && (this.mAttrs.flags & 8) == 0;
    }

    public boolean hasDrawnLw() {
        return this.mWinAnimator.mDrawState == 4;
    }

    public boolean showLw(boolean doAnimation) {
        return showLw(doAnimation, true);
    }

    boolean showLw(boolean doAnimation, boolean requestAnim) {
        if (isHiddenFromUserLocked() || !this.mAppOpVisibility) {
            return false;
        }
        if (this.mPolicyVisibility && this.mPolicyVisibilityAfterAnim) {
            return false;
        }
        if (doAnimation) {
            if (!this.mService.okToDisplay()) {
                doAnimation = false;
            } else if (this.mPolicyVisibility && this.mWinAnimator.mAnimation == null) {
                doAnimation = false;
            }
        }
        this.mPolicyVisibility = true;
        this.mPolicyVisibilityAfterAnim = true;
        if (doAnimation) {
            this.mWinAnimator.applyAnimationLocked(1, true);
        }
        if (requestAnim) {
            this.mService.scheduleAnimationLocked();
        }
        return true;
    }

    public boolean hideLw(boolean doAnimation) {
        return hideLw(doAnimation, true);
    }

    boolean hideLw(boolean doAnimation, boolean requestAnim) {
        if (doAnimation && !this.mService.okToDisplay()) {
            doAnimation = false;
        }
        if (!(doAnimation ? this.mPolicyVisibilityAfterAnim : this.mPolicyVisibility)) {
            return false;
        }
        if (doAnimation) {
            this.mWinAnimator.applyAnimationLocked(2, false);
            if (this.mWinAnimator.mAnimation == null) {
                doAnimation = false;
            }
        }
        if (doAnimation) {
            this.mPolicyVisibilityAfterAnim = false;
        } else {
            this.mPolicyVisibilityAfterAnim = false;
            this.mPolicyVisibility = false;
            this.mService.enableScreenIfNeededLocked();
            if (this.mService.mCurrentFocus == this) {
                this.mService.mFocusMayChange = true;
            }
        }
        if (requestAnim) {
            this.mService.scheduleAnimationLocked();
        }
        return true;
    }

    public void setAppOpVisibilityLw(boolean state) {
        if (this.mAppOpVisibility != state) {
            this.mAppOpVisibility = state;
            if (state) {
                showLw(true, true);
            } else {
                hideLw(true, true);
            }
        }
    }

    public boolean isAlive() {
        return this.mClient.asBinder().isBinderAlive();
    }

    boolean isClosing() {
        return this.mExiting || this.mService.mClosingApps.contains(this.mAppToken);
    }

    public boolean isDefaultDisplay() {
        DisplayContent displayContent = getDisplayContent();
        if (displayContent == null) {
            return false;
        }
        return displayContent.isDefaultDisplay;
    }

    public void setShowToOwnerOnlyLocked(boolean showToOwnerOnly) {
        this.mShowToOwnerOnly = showToOwnerOnly;
    }

    boolean isHiddenFromUserLocked() {
        WindowState win = this;
        while (win.mAttachedWindow != null) {
            win = win.mAttachedWindow;
        }
        if (win.mAttrs.type < 2000 && win.mAppToken != null && win.mAppToken.showWhenLocked) {
            DisplayContent displayContent = win.getDisplayContent();
            if (displayContent == null) {
                return true;
            }
            DisplayInfo displayInfo = displayContent.getDisplayInfo();
            if (win.mFrame.left <= 0 && win.mFrame.top <= 0 && win.mFrame.right >= displayInfo.appWidth && win.mFrame.bottom >= displayInfo.appHeight) {
                return false;
            }
        }
        if (!win.mShowToOwnerOnly || this.mService.isCurrentProfileLocked(UserHandle.getUserId(win.mOwnerUid))) {
            return false;
        }
        return true;
    }

    private static void applyInsets(Region outRegion, Rect frame, Rect inset) {
        outRegion.set(frame.left + inset.left, frame.top + inset.top, frame.right - inset.right, frame.bottom - inset.bottom);
    }

    public void getTouchableRegion(Region outRegion) {
        Rect frame = this.mFrame;
        switch (this.mTouchableInsets) {
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                applyInsets(outRegion, frame, this.mGivenContentInsets);
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                applyInsets(outRegion, frame, this.mGivenVisibleInsets);
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
                outRegion.set(this.mGivenTouchableRegion);
                outRegion.translate(frame.left, frame.top);
            default:
                outRegion.set(frame);
        }
    }

    WindowList getWindowList() {
        DisplayContent displayContent = getDisplayContent();
        return displayContent == null ? null : displayContent.getWindowList();
    }

    public void reportFocusChangedSerialized(boolean focused, boolean inTouchMode) {
        try {
            this.mClient.windowFocusChanged(focused, inTouchMode);
        } catch (RemoteException e) {
        }
        if (this.mFocusCallbacks != null) {
            int N = this.mFocusCallbacks.beginBroadcast();
            for (int i = 0; i < N; i++) {
                IWindowFocusObserver obs = (IWindowFocusObserver) this.mFocusCallbacks.getBroadcastItem(i);
                if (focused) {
                    try {
                        obs.focusGained(this.mWindowId.asBinder());
                    } catch (RemoteException e2) {
                    }
                } else {
                    obs.focusLost(this.mWindowId.asBinder());
                }
            }
            this.mFocusCallbacks.finishBroadcast();
        }
    }

    void reportResized() {
        boolean reportDraw = true;
        try {
            boolean configChanged = isConfigChanged();
            setConfiguration(this.mService.mCurConfiguration);
            Rect frame = this.mFrame;
            Rect overscanInsets = this.mLastOverscanInsets;
            Rect contentInsets = this.mLastContentInsets;
            Rect visibleInsets = this.mLastVisibleInsets;
            Rect stableInsets = this.mLastStableInsets;
            if (this.mWinAnimator.mDrawState != 1) {
                reportDraw = false;
            }
            Configuration newConfig = configChanged ? this.mConfiguration : null;
            if (this.mAttrs.type == 3 || !(this.mClient instanceof IWindow.Stub)) {
                this.mClient.resized(frame, overscanInsets, contentInsets, visibleInsets, stableInsets, reportDraw, newConfig);
            } else {
                this.mService.mH.post(new C05712(frame, overscanInsets, contentInsets, visibleInsets, stableInsets, reportDraw, newConfig));
            }
            if (this.mService.mAccessibilityController != null && getDisplayId() == 0) {
                this.mService.mAccessibilityController.onSomeWindowResizedOrMovedLocked();
            }
            this.mOverscanInsetsChanged = false;
            this.mContentInsetsChanged = false;
            this.mVisibleInsetsChanged = false;
            this.mStableInsetsChanged = false;
            this.mWinAnimator.mSurfaceResized = false;
        } catch (RemoteException e) {
            this.mOrientationChanging = false;
            this.mLastFreezeDuration = (int) (SystemClock.elapsedRealtime() - this.mService.mDisplayFreezeTime);
            Slog.w(TAG, "Failed to report 'resized' to the client of " + this + ", removing this window.");
            this.mService.mPendingRemove.add(this);
            this.mService.requestTraversalLocked();
        }
    }

    public void registerFocusObserver(IWindowFocusObserver observer) {
        synchronized (this.mService.mWindowMap) {
            if (this.mFocusCallbacks == null) {
                this.mFocusCallbacks = new RemoteCallbackList();
            }
            this.mFocusCallbacks.register(observer);
        }
    }

    public void unregisterFocusObserver(IWindowFocusObserver observer) {
        synchronized (this.mService.mWindowMap) {
            if (this.mFocusCallbacks != null) {
                this.mFocusCallbacks.unregister(observer);
            }
        }
    }

    public boolean isFocused() {
        boolean z;
        synchronized (this.mService.mWindowMap) {
            z = this.mService.mCurrentFocus == this;
        }
        return z;
    }

    void dump(PrintWriter pw, String prefix, boolean dumpAll) {
        pw.print(prefix);
        pw.print("mDisplayId=");
        pw.print(getDisplayId());
        pw.print(" mSession=");
        pw.print(this.mSession);
        pw.print(" mClient=");
        pw.println(this.mClient.asBinder());
        pw.print(prefix);
        pw.print("mOwnerUid=");
        pw.print(this.mOwnerUid);
        pw.print(" mShowToOwnerOnly=");
        pw.print(this.mShowToOwnerOnly);
        pw.print(" package=");
        pw.print(this.mAttrs.packageName);
        pw.print(" appop=");
        pw.println(AppOpsManager.opToName(this.mAppOp));
        pw.print(prefix);
        pw.print("mAttrs=");
        pw.println(this.mAttrs);
        pw.print(prefix);
        pw.print("Requested w=");
        pw.print(this.mRequestedWidth);
        pw.print(" h=");
        pw.print(this.mRequestedHeight);
        pw.print(" mLayoutSeq=");
        pw.println(this.mLayoutSeq);
        if (!(this.mRequestedWidth == this.mLastRequestedWidth && this.mRequestedHeight == this.mLastRequestedHeight)) {
            pw.print(prefix);
            pw.print("LastRequested w=");
            pw.print(this.mLastRequestedWidth);
            pw.print(" h=");
            pw.println(this.mLastRequestedHeight);
        }
        if (this.mAttachedWindow != null || this.mLayoutAttached) {
            pw.print(prefix);
            pw.print("mAttachedWindow=");
            pw.print(this.mAttachedWindow);
            pw.print(" mLayoutAttached=");
            pw.println(this.mLayoutAttached);
        }
        if (this.mIsImWindow || this.mIsWallpaper || this.mIsFloatingLayer) {
            pw.print(prefix);
            pw.print("mIsImWindow=");
            pw.print(this.mIsImWindow);
            pw.print(" mIsWallpaper=");
            pw.print(this.mIsWallpaper);
            pw.print(" mIsFloatingLayer=");
            pw.print(this.mIsFloatingLayer);
            pw.print(" mWallpaperVisible=");
            pw.println(this.mWallpaperVisible);
        }
        if (dumpAll) {
            pw.print(prefix);
            pw.print("mBaseLayer=");
            pw.print(this.mBaseLayer);
            pw.print(" mSubLayer=");
            pw.print(this.mSubLayer);
            pw.print(" mAnimLayer=");
            pw.print(this.mLayer);
            pw.print("+");
            int i = this.mTargetAppToken != null ? this.mTargetAppToken.mAppAnimator.animLayerAdjustment : this.mAppToken != null ? this.mAppToken.mAppAnimator.animLayerAdjustment : 0;
            pw.print(i);
            pw.print("=");
            pw.print(this.mWinAnimator.mAnimLayer);
            pw.print(" mLastLayer=");
            pw.println(this.mWinAnimator.mLastLayer);
        }
        if (dumpAll) {
            pw.print(prefix);
            pw.print("mToken=");
            pw.println(this.mToken);
            pw.print(prefix);
            pw.print("mRootToken=");
            pw.println(this.mRootToken);
            if (this.mAppToken != null) {
                pw.print(prefix);
                pw.print("mAppToken=");
                pw.println(this.mAppToken);
            }
            if (this.mTargetAppToken != null) {
                pw.print(prefix);
                pw.print("mTargetAppToken=");
                pw.println(this.mTargetAppToken);
            }
            pw.print(prefix);
            pw.print("mViewVisibility=0x");
            pw.print(Integer.toHexString(this.mViewVisibility));
            pw.print(" mHaveFrame=");
            pw.print(this.mHaveFrame);
            pw.print(" mObscured=");
            pw.println(this.mObscured);
            pw.print(prefix);
            pw.print("mSeq=");
            pw.print(this.mSeq);
            pw.print(" mSystemUiVisibility=0x");
            pw.println(Integer.toHexString(this.mSystemUiVisibility));
        }
        if (!(this.mPolicyVisibility && this.mPolicyVisibilityAfterAnim && this.mAppOpVisibility && !this.mAttachedHidden)) {
            pw.print(prefix);
            pw.print("mPolicyVisibility=");
            pw.print(this.mPolicyVisibility);
            pw.print(" mPolicyVisibilityAfterAnim=");
            pw.print(this.mPolicyVisibilityAfterAnim);
            pw.print(" mAppOpVisibility=");
            pw.print(this.mAppOpVisibility);
            pw.print(" mAttachedHidden=");
            pw.println(this.mAttachedHidden);
        }
        if (!this.mRelayoutCalled || this.mLayoutNeeded) {
            pw.print(prefix);
            pw.print("mRelayoutCalled=");
            pw.print(this.mRelayoutCalled);
            pw.print(" mLayoutNeeded=");
            pw.println(this.mLayoutNeeded);
        }
        if (!(this.mXOffset == 0 && this.mYOffset == 0)) {
            pw.print(prefix);
            pw.print("Offsets x=");
            pw.print(this.mXOffset);
            pw.print(" y=");
            pw.println(this.mYOffset);
        }
        if (dumpAll) {
            pw.print(prefix);
            pw.print("mGivenContentInsets=");
            this.mGivenContentInsets.printShortString(pw);
            pw.print(" mGivenVisibleInsets=");
            this.mGivenVisibleInsets.printShortString(pw);
            pw.println();
            if (this.mTouchableInsets != 0 || this.mGivenInsetsPending) {
                pw.print(prefix);
                pw.print("mTouchableInsets=");
                pw.print(this.mTouchableInsets);
                pw.print(" mGivenInsetsPending=");
                pw.println(this.mGivenInsetsPending);
                Region region = new Region();
                getTouchableRegion(region);
                pw.print(prefix);
                pw.print("touchable region=");
                pw.println(region);
            }
            pw.print(prefix);
            pw.print("mConfiguration=");
            pw.println(this.mConfiguration);
        }
        pw.print(prefix);
        pw.print("mHasSurface=");
        pw.print(this.mHasSurface);
        pw.print(" mShownFrame=");
        this.mShownFrame.printShortString(pw);
        pw.print(" isReadyForDisplay()=");
        pw.println(isReadyForDisplay());
        if (dumpAll) {
            pw.print(prefix);
            pw.print("mFrame=");
            this.mFrame.printShortString(pw);
            pw.print(" last=");
            this.mLastFrame.printShortString(pw);
            pw.println();
            pw.print(prefix);
            pw.print("mSystemDecorRect=");
            this.mSystemDecorRect.printShortString(pw);
            pw.print(" last=");
            this.mLastSystemDecorRect.printShortString(pw);
            pw.println();
        }
        if (this.mEnforceSizeCompat) {
            pw.print(prefix);
            pw.print("mCompatFrame=");
            this.mCompatFrame.printShortString(pw);
            pw.println();
        }
        if (dumpAll) {
            pw.print(prefix);
            pw.print("Frames: containing=");
            this.mContainingFrame.printShortString(pw);
            pw.print(" parent=");
            this.mParentFrame.printShortString(pw);
            pw.println();
            pw.print(prefix);
            pw.print("    display=");
            this.mDisplayFrame.printShortString(pw);
            pw.print(" overscan=");
            this.mOverscanFrame.printShortString(pw);
            pw.println();
            pw.print(prefix);
            pw.print("    content=");
            this.mContentFrame.printShortString(pw);
            pw.print(" visible=");
            this.mVisibleFrame.printShortString(pw);
            pw.println();
            pw.print(prefix);
            pw.print("    decor=");
            this.mDecorFrame.printShortString(pw);
            pw.println();
            pw.print(prefix);
            pw.print("Cur insets: overscan=");
            this.mOverscanInsets.printShortString(pw);
            pw.print(" content=");
            this.mContentInsets.printShortString(pw);
            pw.print(" visible=");
            this.mVisibleInsets.printShortString(pw);
            pw.print(" stable=");
            this.mStableInsets.printShortString(pw);
            pw.println();
            pw.print(prefix);
            pw.print("Lst insets: overscan=");
            this.mLastOverscanInsets.printShortString(pw);
            pw.print(" content=");
            this.mLastContentInsets.printShortString(pw);
            pw.print(" visible=");
            this.mLastVisibleInsets.printShortString(pw);
            pw.print(" stable=");
            this.mLastStableInsets.printShortString(pw);
            pw.println();
        }
        pw.print(prefix);
        pw.print(this.mWinAnimator);
        pw.println(":");
        this.mWinAnimator.dump(pw, prefix + "  ", dumpAll);
        if (this.mExiting || this.mRemoveOnExit || this.mDestroying || this.mRemoved) {
            pw.print(prefix);
            pw.print("mExiting=");
            pw.print(this.mExiting);
            pw.print(" mRemoveOnExit=");
            pw.print(this.mRemoveOnExit);
            pw.print(" mDestroying=");
            pw.print(this.mDestroying);
            pw.print(" mRemoved=");
            pw.println(this.mRemoved);
        }
        if (this.mOrientationChanging || this.mAppFreezing || this.mTurnOnScreen) {
            pw.print(prefix);
            pw.print("mOrientationChanging=");
            pw.print(this.mOrientationChanging);
            pw.print(" mAppFreezing=");
            pw.print(this.mAppFreezing);
            pw.print(" mTurnOnScreen=");
            pw.println(this.mTurnOnScreen);
        }
        if (this.mLastFreezeDuration != 0) {
            pw.print(prefix);
            pw.print("mLastFreezeDuration=");
            TimeUtils.formatDuration((long) this.mLastFreezeDuration, pw);
            pw.println();
        }
        if (!(this.mHScale == 1.0f && this.mVScale == 1.0f)) {
            pw.print(prefix);
            pw.print("mHScale=");
            pw.print(this.mHScale);
            pw.print(" mVScale=");
            pw.println(this.mVScale);
        }
        if (!(this.mWallpaperX == -1.0f && this.mWallpaperY == -1.0f)) {
            pw.print(prefix);
            pw.print("mWallpaperX=");
            pw.print(this.mWallpaperX);
            pw.print(" mWallpaperY=");
            pw.println(this.mWallpaperY);
        }
        if (!(this.mWallpaperXStep == -1.0f && this.mWallpaperYStep == -1.0f)) {
            pw.print(prefix);
            pw.print("mWallpaperXStep=");
            pw.print(this.mWallpaperXStep);
            pw.print(" mWallpaperYStep=");
            pw.println(this.mWallpaperYStep);
        }
        if (this.mWallpaperDisplayOffsetX != SoundTriggerHelper.STATUS_ERROR || this.mWallpaperDisplayOffsetY != SoundTriggerHelper.STATUS_ERROR) {
            pw.print(prefix);
            pw.print("mWallpaperDisplayOffsetX=");
            pw.print(this.mWallpaperDisplayOffsetX);
            pw.print(" mWallpaperDisplayOffsetY=");
            pw.println(this.mWallpaperDisplayOffsetY);
        }
    }

    String makeInputChannelName() {
        return Integer.toHexString(System.identityHashCode(this)) + " " + this.mAttrs.getTitle();
    }

    public String toString() {
        CharSequence title = this.mAttrs.getTitle();
        if (title == null || title.length() <= 0) {
            title = this.mAttrs.packageName;
        }
        if (!(this.mStringNameCache != null && this.mLastTitle == title && this.mWasExiting == this.mExiting)) {
            this.mLastTitle = title;
            this.mWasExiting = this.mExiting;
            this.mStringNameCache = "Window{" + Integer.toHexString(System.identityHashCode(this)) + " u" + UserHandle.getUserId(this.mSession.mUid) + " " + this.mLastTitle + (this.mExiting ? " EXITING}" : "}");
        }
        return this.mStringNameCache;
    }
}
