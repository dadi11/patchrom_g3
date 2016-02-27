package com.android.server.wm;

import android.animation.ValueAnimator;
import android.app.ActivityManagerNative;
import android.app.AppOpsManager;
import android.app.AppOpsManager.OnOpChangedInternalListener;
import android.app.IActivityManager;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.CompatibilityInfo;
import android.content.res.Configuration;
import android.database.ContentObserver;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Point;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Region;
import android.graphics.Region.Op;
import android.hardware.display.DisplayManager;
import android.hardware.display.DisplayManagerInternal;
import android.net.Uri;
import android.os.Binder;
import android.os.Build;
import android.os.Bundle;
import android.os.Debug;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.IRemoteCallback;
import android.os.Looper;
import android.os.Message;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.PowerManagerInternal;
import android.os.PowerManagerInternal.LowPowerModeListener;
import android.os.Process;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.SystemService;
import android.os.Trace;
import android.os.UserHandle;
import android.os.WorkSource;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.util.ArraySet;
import android.util.DisplayMetrics;
import android.util.EventLog;
import android.util.Log;
import android.util.Pair;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.util.TimeUtils;
import android.util.TypedValue;
import android.view.Choreographer;
import android.view.Display;
import android.view.DisplayInfo;
import android.view.IApplicationToken;
import android.view.IInputFilter;
import android.view.IOnKeyguardExitResult;
import android.view.IRotationWatcher;
import android.view.IWindow;
import android.view.IWindowId;
import android.view.IWindowManager.Stub;
import android.view.IWindowSession;
import android.view.IWindowSessionCallback;
import android.view.InputChannel;
import android.view.InputDevice;
import android.view.InputEventReceiver;
import android.view.InputEventReceiver.Factory;
import android.view.MagnificationSpec;
import android.view.Surface;
import android.view.Surface.OutOfResourcesException;
import android.view.SurfaceControl;
import android.view.SurfaceSession;
import android.view.View;
import android.view.WindowContentFrameStats;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManagerInternal;
import android.view.WindowManagerInternal.MagnificationCallbacks;
import android.view.WindowManagerInternal.WindowsForAccessibilityCallback;
import android.view.WindowManagerPolicy;
import android.view.WindowManagerPolicy.FakeWindow;
import android.view.WindowManagerPolicy.OnKeyguardExitResult;
import android.view.WindowManagerPolicy.PointerEventListener;
import android.view.WindowManagerPolicy.WindowManagerFuncs;
import android.view.animation.Animation;
import android.view.animation.Transformation;
import com.android.internal.R;
import com.android.internal.app.IBatteryStats;
import com.android.internal.policy.PolicyManager;
import com.android.internal.util.FastPrintWriter;
import com.android.internal.view.IInputContext;
import com.android.internal.view.IInputMethodClient;
import com.android.internal.view.IInputMethodManager;
import com.android.internal.view.WindowManagerPolicyThread;
import com.android.server.AttributeCache;
import com.android.server.AttributeCache.Entry;
import com.android.server.DisplayThread;
import com.android.server.EventLogTags;
import com.android.server.LocalServices;
import com.android.server.UiThread;
import com.android.server.Watchdog;
import com.android.server.Watchdog.Monitor;
import com.android.server.am.BatteryStatsService;
import com.android.server.input.InputManagerService;
import com.android.server.power.ShutdownThread;
import com.android.server.voiceinteraction.SoundTriggerHelper;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.Socket;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

public class WindowManagerService extends Stub implements Monitor, WindowManagerFuncs {
    static final int ADJUST_WALLPAPER_LAYERS_CHANGED = 2;
    static final int ADJUST_WALLPAPER_VISIBILITY_CHANGED = 4;
    private static final int BOOT_ANIMATION_POLL_INTERVAL = 200;
    private static final String BOOT_ANIMATION_SERVICE = "bootanim";
    static final boolean CUSTOM_SCREEN_ROTATION = true;
    static final boolean DEBUG = false;
    static final boolean DEBUG_ADD_REMOVE = false;
    static final boolean DEBUG_ANIM = false;
    static final boolean DEBUG_APP_ORIENTATION = false;
    static final boolean DEBUG_APP_TRANSITIONS = false;
    static final boolean DEBUG_BOOT = false;
    static final boolean DEBUG_CONFIGURATION = false;
    static final boolean DEBUG_DISPLAY = false;
    static final boolean DEBUG_DRAG = false;
    static final boolean DEBUG_FOCUS = false;
    static final boolean DEBUG_FOCUS_LIGHT = false;
    static final boolean DEBUG_INPUT = false;
    static final boolean DEBUG_INPUT_METHOD = false;
    static final boolean DEBUG_KEYGUARD = false;
    static final boolean DEBUG_LAYERS = false;
    static final boolean DEBUG_LAYOUT = false;
    static final boolean DEBUG_LAYOUT_REPEATS = true;
    static final boolean DEBUG_ORIENTATION = false;
    static final boolean DEBUG_REORDER = false;
    static final boolean DEBUG_RESIZE = false;
    static final boolean DEBUG_SCREENSHOT = false;
    static final boolean DEBUG_SCREEN_ON = false;
    static final boolean DEBUG_STACK = false;
    static final boolean DEBUG_STARTING_WINDOW = false;
    static final boolean DEBUG_SURFACE_TRACE = false;
    static final boolean DEBUG_TASK_MOVEMENT = false;
    static final boolean DEBUG_TOKEN_MOVEMENT = false;
    static final boolean DEBUG_VISIBILITY = false;
    static final boolean DEBUG_WALLPAPER = false;
    static final boolean DEBUG_WALLPAPER_LIGHT = false;
    static final boolean DEBUG_WINDOW_MOVEMENT = false;
    static final boolean DEBUG_WINDOW_TRACE = false;
    static final int DEFAULT_FADE_IN_OUT_DURATION = 400;
    static final long DEFAULT_INPUT_DISPATCHING_TIMEOUT_NANOS = 5000000000L;
    private static final String DENSITY_OVERRIDE = "ro.config.density_override";
    static final int FREEZE_LAYER = 2000001;
    static final boolean HIDE_STACK_CRAWLS = true;
    private static final int INPUT_DEVICES_READY_FOR_SAFE_MODE_DETECTION_TIMEOUT_MILLIS = 1000;
    static final int LAST_ANR_LIFETIME_DURATION_MSECS = 7200000;
    static final int LAYER_OFFSET_BLUR = 2;
    static final int LAYER_OFFSET_DIM = 1;
    static final int LAYER_OFFSET_FOCUSED_STACK = 1;
    static final int LAYER_OFFSET_THUMBNAIL = 4;
    static final int LAYOUT_REPEAT_THRESHOLD = 4;
    static final int MASK_LAYER = 2000000;
    static final int MAX_ANIMATION_DURATION = 10000;
    private static final int MAX_SCREENSHOT_RETRIES = 3;
    static final boolean PROFILE_ORIENTATION = false;
    private static final String PROPERTY_EMULATOR_CIRCULAR = "ro.emulator.circular";
    static final boolean SHOW_LIGHT_TRANSACTIONS = false;
    static final boolean SHOW_SURFACE_ALLOC = false;
    static final boolean SHOW_TRANSACTIONS = false;
    private static final String SIZE_OVERRIDE = "ro.config.size_override";
    public static final float STACK_WEIGHT_MAX = 0.8f;
    public static final float STACK_WEIGHT_MIN = 0.2f;
    private static final String SYSTEM_DEBUGGABLE = "ro.debuggable";
    private static final String SYSTEM_SECURE = "ro.secure";
    private static final int SYSTEM_UI_FLAGS_LAYOUT_STABLE_FULLSCREEN = 1280;
    static final String TAG = "WindowManager";
    static final int TYPE_LAYER_MULTIPLIER = 10000;
    static final int TYPE_LAYER_OFFSET = 1000;
    static final int UPDATE_FOCUS_NORMAL = 0;
    static final int UPDATE_FOCUS_PLACING_SURFACES = 2;
    static final int UPDATE_FOCUS_WILL_ASSIGN_LAYERS = 1;
    static final int UPDATE_FOCUS_WILL_PLACE_SURFACES = 3;
    static final int WALLPAPER_DRAW_NORMAL = 0;
    static final int WALLPAPER_DRAW_PENDING = 1;
    static final long WALLPAPER_DRAW_PENDING_TIMEOUT_DURATION = 1000;
    static final int WALLPAPER_DRAW_TIMEOUT = 2;
    static final long WALLPAPER_TIMEOUT = 150;
    static final long WALLPAPER_TIMEOUT_RECOVERY = 10000;
    static final int WINDOW_FREEZE_TIMEOUT_DURATION = 2000;
    static final int WINDOW_LAYER_MULTIPLIER = 5;
    static final boolean localLOGV = false;
    AccessibilityController mAccessibilityController;
    final IActivityManager mActivityManager;
    final boolean mAllowBootMessages;
    boolean mAllowTheaterModeWakeFromLayout;
    boolean mAltOrientation;
    boolean mAnimateWallpaperWithTarget;
    boolean mAnimationScheduled;
    boolean mAnimationsDisabled;
    final WindowAnimator mAnimator;
    float mAnimatorDurationScaleSetting;
    final AppOpsManager mAppOps;
    final AppTransition mAppTransition;
    int mAppsFreezingScreen;
    final IBatteryStats mBatteryStats;
    boolean mBootAnimationStopped;
    final BroadcastReceiver mBroadcastReceiver;
    final Choreographer mChoreographer;
    CircularDisplayMask mCircularDisplayMask;
    boolean mClientFreezingScreen;
    final ArraySet<AppWindowToken> mClosingApps;
    final DisplayMetrics mCompatDisplayMetrics;
    float mCompatibleScreenScale;
    final Context mContext;
    Configuration mCurConfiguration;
    WindowState mCurrentFocus;
    int[] mCurrentProfileIds;
    int mCurrentUserId;
    int mDeferredRotationPauseCount;
    final ArrayList<WindowState> mDestroySurface;
    SparseArray<DisplayContent> mDisplayContents;
    boolean mDisplayEnabled;
    long mDisplayFreezeTime;
    boolean mDisplayFrozen;
    final DisplayManager mDisplayManager;
    final DisplayManagerInternal mDisplayManagerInternal;
    final DisplayMetrics mDisplayMetrics;
    boolean mDisplayReady;
    final DisplaySettings mDisplaySettings;
    final Display[] mDisplays;
    DragState mDragState;
    EmulatorDisplayOverlay mEmulatorDisplayOverlay;
    int mEnterAnimId;
    private boolean mEventDispatchingEnabled;
    int mExitAnimId;
    final ArrayList<FakeWindowImpl> mFakeWindows;
    final ArrayList<AppWindowToken> mFinishedStarting;
    boolean mFocusMayChange;
    AppWindowToken mFocusedApp;
    FocusedStackFrame mFocusedStackFrame;
    int mFocusedStackLayer;
    boolean mForceDisplayEnabled;
    ArrayList<WindowState> mForceRemoves;
    int mForcedAppOrientation;
    final SurfaceSession mFxSession;
    final C0569H mH;
    boolean mHardKeyboardAvailable;
    OnHardKeyboardStatusChangeListener mHardKeyboardStatusChangeListener;
    final boolean mHasPermanentDpad;
    final boolean mHaveInputMethods;
    Session mHoldingScreenOn;
    WakeLock mHoldingScreenWakeLock;
    private boolean mInLayout;
    boolean mInTouchMode;
    final LayoutFields mInnerFields;
    final InputManagerService mInputManager;
    int mInputMethodAnimLayerAdjustment;
    final ArrayList<WindowState> mInputMethodDialogs;
    IInputMethodManager mInputMethodManager;
    WindowState mInputMethodTarget;
    boolean mInputMethodTargetWaitingAnim;
    WindowState mInputMethodWindow;
    final InputMonitor mInputMonitor;
    boolean mIsTouchDevice;
    private final KeyguardDisableHandler mKeyguardDisableHandler;
    private boolean mKeyguardWaitingForActivityDrawn;
    String mLastANRState;
    int mLastDisplayFreezeDuration;
    Object mLastFinishedFreezeSource;
    WindowState mLastFocus;
    int mLastKeyguardForcedOrientation;
    int mLastStatusBarVisibility;
    int mLastWallpaperDisplayOffsetX;
    int mLastWallpaperDisplayOffsetY;
    long mLastWallpaperTimeoutTime;
    float mLastWallpaperX;
    float mLastWallpaperXStep;
    float mLastWallpaperY;
    float mLastWallpaperYStep;
    int mLastWindowForcedOrientation;
    private int mLayoutRepeatCount;
    int mLayoutSeq;
    final boolean mLimitedAlphaCompositing;
    ArrayList<WindowState> mLosingFocus;
    WindowState mLowerWallpaperTarget;
    final boolean mOnlyCore;
    final ArraySet<AppWindowToken> mOpeningApps;
    final ArrayList<WindowState> mPendingRemove;
    WindowState[] mPendingRemoveTmp;
    final ArraySet<TaskStack> mPendingStacksRemove;
    private final PointerEventDispatcher mPointerEventDispatcher;
    final WindowManagerPolicy mPolicy;
    PowerManager mPowerManager;
    PowerManagerInternal mPowerManagerInternal;
    final DisplayMetrics mRealDisplayMetrics;
    WindowState[] mRebuildTmp;
    final ArrayList<WindowState> mRelayoutWhileAnimating;
    final ArrayList<WindowState> mResizingWindows;
    int mRotation;
    ArrayList<RotationWatcher> mRotationWatchers;
    boolean mSafeMode;
    SparseArray<Boolean> mScreenCaptureDisabled;
    private final WakeLock mScreenFrozenLock;
    final Rect mScreenRect;
    final ArraySet<Session> mSessions;
    SettingsObserver mSettingsObserver;
    boolean mShowImeWithHardKeyboard;
    boolean mShowingBootMessages;
    boolean mSkipAppTransitionAnimation;
    SparseArray<TaskStack> mStackIdToStack;
    boolean mStartingIconInTransition;
    StrictModeFlash mStrictModeFlash;
    boolean mSystemBooted;
    int mSystemDecorLayer;
    SparseArray<Task> mTaskIdToTask;
    final Configuration mTempConfiguration;
    private WindowContentFrameStats mTempWindowRenderStats;
    final Rect mTmpContentRect;
    final DisplayMetrics mTmpDisplayMetrics;
    final float[] mTmpFloats;
    final HashMap<IBinder, WindowToken> mTokenMap;
    private int mTransactionSequence;
    float mTransitionAnimationScaleSetting;
    boolean mTraversalScheduled;
    boolean mTurnOnScreen;
    WindowState mUpperWallpaperTarget;
    private ViewServer mViewServer;
    boolean mWaitingForConfig;
    ArrayList<WindowState> mWaitingForDrawn;
    Runnable mWaitingForDrawnCallback;
    WindowState mWaitingOnWallpaper;
    int mWallpaperAnimLayerAdjustment;
    int mWallpaperDrawState;
    WindowState mWallpaperTarget;
    final ArrayList<WindowToken> mWallpaperTokens;
    Watermark mWatermark;
    float mWindowAnimationScaleSetting;
    private final ArrayList<WindowChangeListener> mWindowChangeListeners;
    final HashMap<IBinder, WindowState> mWindowMap;
    private boolean mWindowsChanged;
    boolean mWindowsFreezingScreen;

    public interface OnHardKeyboardStatusChangeListener {
        void onHardKeyboardStatusChange(boolean z);
    }

    public interface WindowChangeListener {
        void focusChanged();

        void windowsChanged();
    }

    /* renamed from: com.android.server.wm.WindowManagerService.1 */
    class C05621 extends BroadcastReceiver {
        C05621() {
        }

        public void onReceive(Context context, Intent intent) {
            if ("android.app.action.DEVICE_POLICY_MANAGER_STATE_CHANGED".equals(intent.getAction())) {
                WindowManagerService.this.mKeyguardDisableHandler.sendEmptyMessage(WindowManagerService.UPDATE_FOCUS_WILL_PLACE_SURFACES);
            }
        }
    }

    /* renamed from: com.android.server.wm.WindowManagerService.2 */
    static class C05632 implements Runnable {
        final /* synthetic */ Context val$context;
        final /* synthetic */ boolean val$haveInputMethods;
        final /* synthetic */ WindowManagerService[] val$holder;
        final /* synthetic */ InputManagerService val$im;
        final /* synthetic */ boolean val$onlyCore;
        final /* synthetic */ boolean val$showBootMsgs;

        C05632(WindowManagerService[] windowManagerServiceArr, Context context, InputManagerService inputManagerService, boolean z, boolean z2, boolean z3) {
            this.val$holder = windowManagerServiceArr;
            this.val$context = context;
            this.val$im = inputManagerService;
            this.val$haveInputMethods = z;
            this.val$showBootMsgs = z2;
            this.val$onlyCore = z3;
        }

        public void run() {
            this.val$holder[WindowManagerService.WALLPAPER_DRAW_NORMAL] = new WindowManagerService(this.val$im, this.val$haveInputMethods, this.val$showBootMsgs, this.val$onlyCore, null);
        }
    }

    /* renamed from: com.android.server.wm.WindowManagerService.3 */
    class C05643 implements Runnable {
        C05643() {
        }

        public void run() {
            WindowManagerPolicyThread.set(Thread.currentThread(), Looper.myLooper());
            WindowManagerService.this.mPolicy.init(WindowManagerService.this.mContext, WindowManagerService.this, WindowManagerService.this);
            WindowManagerService.this.mAnimator.mAboveUniverseLayer = (WindowManagerService.this.mPolicy.getAboveUniverseLayer() * WindowManagerService.TYPE_LAYER_MULTIPLIER) + WindowManagerService.TYPE_LAYER_OFFSET;
        }
    }

    /* renamed from: com.android.server.wm.WindowManagerService.4 */
    class C05654 implements LowPowerModeListener {
        C05654() {
        }

        public void onLowPowerModeChanged(boolean enabled) {
            synchronized (WindowManagerService.this.mWindowMap) {
                if (WindowManagerService.this.mAnimationsDisabled != enabled) {
                    WindowManagerService.this.mAnimationsDisabled = enabled;
                    WindowManagerService.this.dispatchNewAnimatorScaleLocked(null);
                }
            }
        }
    }

    /* renamed from: com.android.server.wm.WindowManagerService.5 */
    class C05665 extends OnOpChangedInternalListener {
        C05665() {
        }

        public void onOpChanged(int op, String packageName) {
            WindowManagerService.this.updateAppOpsState();
        }
    }

    /* renamed from: com.android.server.wm.WindowManagerService.6 */
    class C05676 implements OnKeyguardExitResult {
        final /* synthetic */ IOnKeyguardExitResult val$callback;

        C05676(IOnKeyguardExitResult iOnKeyguardExitResult) {
            this.val$callback = iOnKeyguardExitResult;
        }

        public void onKeyguardExitResult(boolean success) {
            try {
                this.val$callback.onKeyguardExitResult(success);
            } catch (RemoteException e) {
            }
        }
    }

    /* renamed from: com.android.server.wm.WindowManagerService.7 */
    class C05687 implements DeathRecipient {
        final /* synthetic */ IBinder val$watcherBinder;

        C05687(IBinder iBinder) {
            this.val$watcherBinder = iBinder;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void binderDied() {
            /*
            r6 = this;
            r3 = com.android.server.wm.WindowManagerService.this;
            r4 = r3.mWindowMap;
            monitor-enter(r4);
            r1 = 0;
        L_0x0006:
            r3 = com.android.server.wm.WindowManagerService.this;	 Catch:{ all -> 0x0041 }
            r3 = r3.mRotationWatchers;	 Catch:{ all -> 0x0041 }
            r3 = r3.size();	 Catch:{ all -> 0x0041 }
            if (r1 >= r3) goto L_0x003f;
        L_0x0010:
            r5 = r6.val$watcherBinder;	 Catch:{ all -> 0x0041 }
            r3 = com.android.server.wm.WindowManagerService.this;	 Catch:{ all -> 0x0041 }
            r3 = r3.mRotationWatchers;	 Catch:{ all -> 0x0041 }
            r3 = r3.get(r1);	 Catch:{ all -> 0x0041 }
            r3 = (com.android.server.wm.WindowManagerService.RotationWatcher) r3;	 Catch:{ all -> 0x0041 }
            r3 = r3.watcher;	 Catch:{ all -> 0x0041 }
            r3 = r3.asBinder();	 Catch:{ all -> 0x0041 }
            if (r5 != r3) goto L_0x003c;
        L_0x0024:
            r3 = com.android.server.wm.WindowManagerService.this;	 Catch:{ all -> 0x0041 }
            r3 = r3.mRotationWatchers;	 Catch:{ all -> 0x0041 }
            r2 = r3.remove(r1);	 Catch:{ all -> 0x0041 }
            r2 = (com.android.server.wm.WindowManagerService.RotationWatcher) r2;	 Catch:{ all -> 0x0041 }
            r3 = r2.watcher;	 Catch:{ all -> 0x0041 }
            r0 = r3.asBinder();	 Catch:{ all -> 0x0041 }
            if (r0 == 0) goto L_0x003a;
        L_0x0036:
            r3 = 0;
            r0.unlinkToDeath(r6, r3);	 Catch:{ all -> 0x0041 }
        L_0x003a:
            r1 = r1 + -1;
        L_0x003c:
            r1 = r1 + 1;
            goto L_0x0006;
        L_0x003f:
            monitor-exit(r4);	 Catch:{ all -> 0x0041 }
            return;
        L_0x0041:
            r3 = move-exception;
            monitor-exit(r4);	 Catch:{ all -> 0x0041 }
            throw r3;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.7.binderDied():void");
        }
    }

    final class DragInputEventReceiver extends InputEventReceiver {
        public DragInputEventReceiver(InputChannel inputChannel, Looper looper) {
            super(inputChannel, looper);
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onInputEvent(android.view.InputEvent r10) {
            /*
            r9 = this;
            r3 = 0;
            r7 = r10 instanceof android.view.MotionEvent;	 Catch:{ Exception -> 0x004c }
            if (r7 == 0) goto L_0x0037;
        L_0x0005:
            r7 = r10.getSource();	 Catch:{ Exception -> 0x004c }
            r7 = r7 & 2;
            if (r7 == 0) goto L_0x0037;
        L_0x000d:
            r7 = com.android.server.wm.WindowManagerService.this;	 Catch:{ Exception -> 0x004c }
            r7 = r7.mDragState;	 Catch:{ Exception -> 0x004c }
            if (r7 == 0) goto L_0x0037;
        L_0x0013:
            r0 = r10;
            r0 = (android.view.MotionEvent) r0;	 Catch:{ Exception -> 0x004c }
            r4 = r0;
            r2 = 0;
            r5 = r4.getRawX();	 Catch:{ Exception -> 0x004c }
            r6 = r4.getRawY();	 Catch:{ Exception -> 0x004c }
            r7 = r4.getAction();	 Catch:{ Exception -> 0x004c }
            switch(r7) {
                case 0: goto L_0x0027;
                case 1: goto L_0x0058;
                case 2: goto L_0x003b;
                case 3: goto L_0x006f;
                default: goto L_0x0027;
            };	 Catch:{ Exception -> 0x004c }
        L_0x0027:
            if (r2 == 0) goto L_0x0036;
        L_0x0029:
            r7 = com.android.server.wm.WindowManagerService.this;	 Catch:{ Exception -> 0x004c }
            r8 = r7.mWindowMap;	 Catch:{ Exception -> 0x004c }
            monitor-enter(r8);	 Catch:{ Exception -> 0x004c }
            r7 = com.android.server.wm.WindowManagerService.this;	 Catch:{ all -> 0x0071 }
            r7 = r7.mDragState;	 Catch:{ all -> 0x0071 }
            r7.endDragLw();	 Catch:{ all -> 0x0071 }
            monitor-exit(r8);	 Catch:{ all -> 0x0071 }
        L_0x0036:
            r3 = 1;
        L_0x0037:
            r9.finishInputEvent(r10, r3);
        L_0x003a:
            return;
        L_0x003b:
            r7 = com.android.server.wm.WindowManagerService.this;	 Catch:{ Exception -> 0x004c }
            r8 = r7.mWindowMap;	 Catch:{ Exception -> 0x004c }
            monitor-enter(r8);	 Catch:{ Exception -> 0x004c }
            r7 = com.android.server.wm.WindowManagerService.this;	 Catch:{ all -> 0x0049 }
            r7 = r7.mDragState;	 Catch:{ all -> 0x0049 }
            r7.notifyMoveLw(r5, r6);	 Catch:{ all -> 0x0049 }
            monitor-exit(r8);	 Catch:{ all -> 0x0049 }
            goto L_0x0027;
        L_0x0049:
            r7 = move-exception;
            monitor-exit(r8);	 Catch:{ all -> 0x0049 }
            throw r7;	 Catch:{ Exception -> 0x004c }
        L_0x004c:
            r1 = move-exception;
            r7 = "WindowManager";
            r8 = "Exception caught by drag handleMotion";
            android.util.Slog.e(r7, r8, r1);	 Catch:{ all -> 0x006a }
            r9.finishInputEvent(r10, r3);
            goto L_0x003a;
        L_0x0058:
            r7 = com.android.server.wm.WindowManagerService.this;	 Catch:{ Exception -> 0x004c }
            r8 = r7.mWindowMap;	 Catch:{ Exception -> 0x004c }
            monitor-enter(r8);	 Catch:{ Exception -> 0x004c }
            r7 = com.android.server.wm.WindowManagerService.this;	 Catch:{ all -> 0x0067 }
            r7 = r7.mDragState;	 Catch:{ all -> 0x0067 }
            r2 = r7.notifyDropLw(r5, r6);	 Catch:{ all -> 0x0067 }
            monitor-exit(r8);	 Catch:{ all -> 0x0067 }
            goto L_0x0027;
        L_0x0067:
            r7 = move-exception;
            monitor-exit(r8);	 Catch:{ all -> 0x0067 }
            throw r7;	 Catch:{ Exception -> 0x004c }
        L_0x006a:
            r7 = move-exception;
            r9.finishInputEvent(r10, r3);
            throw r7;
        L_0x006f:
            r2 = 1;
            goto L_0x0027;
        L_0x0071:
            r7 = move-exception;
            monitor-exit(r8);	 Catch:{ all -> 0x0071 }
            throw r7;	 Catch:{ Exception -> 0x004c }
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.DragInputEventReceiver.onInputEvent(android.view.InputEvent):void");
        }
    }

    /* renamed from: com.android.server.wm.WindowManagerService.H */
    final class C0569H extends Handler {
        public static final int ADD_STARTING = 5;
        public static final int ALL_WINDOWS_DRAWN = 33;
        public static final int APP_FREEZE_TIMEOUT = 17;
        public static final int APP_TRANSITION_TIMEOUT = 13;
        public static final int BOOT_TIMEOUT = 23;
        public static final int CHECK_IF_BOOT_ANIMATION_FINISHED = 37;
        public static final int CLIENT_FREEZE_TIMEOUT = 30;
        public static final int DO_ANIMATION_CALLBACK = 26;
        public static final int DO_DISPLAY_ADDED = 27;
        public static final int DO_DISPLAY_CHANGED = 29;
        public static final int DO_DISPLAY_REMOVED = 28;
        public static final int DO_TRAVERSAL = 4;
        public static final int DRAG_END_TIMEOUT = 21;
        public static final int DRAG_START_TIMEOUT = 20;
        public static final int ENABLE_SCREEN = 16;
        public static final int FINISHED_STARTING = 7;
        public static final int FORCE_GC = 15;
        public static final int NEW_ANIMATOR_SCALE = 34;
        public static final int NOTIFY_ACTIVITY_DRAWN = 32;
        public static final int PERSIST_ANIMATION_SCALE = 14;
        public static final int REMOVE_STARTING = 6;
        public static final int REPORT_APPLICATION_TOKEN_DRAWN = 9;
        public static final int REPORT_APPLICATION_TOKEN_WINDOWS = 8;
        public static final int REPORT_FOCUS_CHANGE = 2;
        public static final int REPORT_HARD_KEYBOARD_STATUS_CHANGE = 22;
        public static final int REPORT_LOSING_FOCUS = 3;
        public static final int REPORT_WINDOWS_CHANGE = 19;
        public static final int RESET_ANR_MESSAGE = 38;
        public static final int SEND_NEW_CONFIGURATION = 18;
        public static final int SHOW_CIRCULAR_DISPLAY_MASK = 35;
        public static final int SHOW_EMULATOR_DISPLAY_OVERLAY = 36;
        public static final int SHOW_STRICT_MODE_VIOLATION = 25;
        public static final int TAP_OUTSIDE_STACK = 31;
        public static final int WAITING_FOR_DRAWN_TIMEOUT = 24;
        public static final int WALLPAPER_DRAW_PENDING_TIMEOUT = 39;
        public static final int WINDOW_FREEZE_TIMEOUT = 11;

        C0569H() {
        }

        public void handleMessage(Message msg) {
            int i;
            int N;
            AppWindowToken wtoken;
            View view;
            IBinder token;
            IBinder win;
            Runnable callback;
            switch (msg.what) {
                case REPORT_FOCUS_CHANGE /*2*/:
                    AccessibilityController accessibilityController = null;
                    synchronized (WindowManagerService.this.mWindowMap) {
                        if (WindowManagerService.this.mAccessibilityController != null && WindowManagerService.this.getDefaultDisplayContentLocked().getDisplayId() == 0) {
                            accessibilityController = WindowManagerService.this.mAccessibilityController;
                        }
                        WindowState lastFocus = WindowManagerService.this.mLastFocus;
                        WindowState newFocus = WindowManagerService.this.mCurrentFocus;
                        if (lastFocus == newFocus) {
                            return;
                        }
                        WindowManagerService.this.mLastFocus = newFocus;
                        if (!(newFocus == null || lastFocus == null || newFocus.isDisplayedLw())) {
                            WindowManagerService.this.mLosingFocus.add(lastFocus);
                            lastFocus = null;
                        }
                        if (accessibilityController != null) {
                            accessibilityController.onWindowFocusChangedNotLocked();
                        }
                        if (newFocus != null) {
                            newFocus.reportFocusChangedSerialized(WindowManagerService.HIDE_STACK_CRAWLS, WindowManagerService.this.mInTouchMode);
                            WindowManagerService.this.notifyFocusChanged();
                        }
                        if (lastFocus != null) {
                            lastFocus.reportFocusChangedSerialized(WindowManagerService.SHOW_TRANSACTIONS, WindowManagerService.this.mInTouchMode);
                            return;
                        }
                        return;
                    }
                case REPORT_LOSING_FOCUS /*3*/:
                    ArrayList<WindowState> losers;
                    synchronized (WindowManagerService.this.mWindowMap) {
                        losers = WindowManagerService.this.mLosingFocus;
                        WindowManagerService.this.mLosingFocus = new ArrayList();
                        break;
                    }
                    N = losers.size();
                    for (i = WindowManagerService.WALLPAPER_DRAW_NORMAL; i < N; i += WindowManagerService.WALLPAPER_DRAW_PENDING) {
                        ((WindowState) losers.get(i)).reportFocusChangedSerialized(WindowManagerService.SHOW_TRANSACTIONS, WindowManagerService.this.mInTouchMode);
                    }
                    return;
                case DO_TRAVERSAL /*4*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        WindowManagerService.this.mTraversalScheduled = WindowManagerService.SHOW_TRANSACTIONS;
                        WindowManagerService.this.performLayoutAndPlaceSurfacesLocked();
                        break;
                    }
                    return;
                case ADD_STARTING /*5*/:
                    wtoken = msg.obj;
                    StartingData sd = wtoken.startingData;
                    if (sd != null) {
                        view = null;
                        try {
                            view = WindowManagerService.this.mPolicy.addStartingWindow(wtoken.token, sd.pkg, sd.theme, sd.compatInfo, sd.nonLocalizedLabel, sd.labelRes, sd.icon, sd.logo, sd.windowFlags);
                        } catch (Throwable e) {
                            Slog.w(WindowManagerService.TAG, "Exception when adding starting window", e);
                        }
                        if (view != null) {
                            boolean abort = WindowManagerService.SHOW_TRANSACTIONS;
                            synchronized (WindowManagerService.this.mWindowMap) {
                                if (!wtoken.removed && wtoken.startingData != null) {
                                    wtoken.startingView = view;
                                    break;
                                } else if (wtoken.startingWindow != null) {
                                    wtoken.startingWindow = null;
                                    wtoken.startingData = null;
                                    abort = WindowManagerService.HIDE_STACK_CRAWLS;
                                }
                                break;
                            }
                            if (abort) {
                                try {
                                    WindowManagerService.this.mPolicy.removeStartingWindow(wtoken.token, view);
                                    return;
                                } catch (Throwable e2) {
                                    Slog.w(WindowManagerService.TAG, "Exception when removing starting window", e2);
                                    return;
                                }
                            }
                            return;
                        }
                        return;
                    }
                    return;
                case REMOVE_STARTING /*6*/:
                    wtoken = (AppWindowToken) msg.obj;
                    token = null;
                    view = null;
                    synchronized (WindowManagerService.this.mWindowMap) {
                        if (wtoken.startingWindow != null) {
                            view = wtoken.startingView;
                            token = wtoken.token;
                            wtoken.startingData = null;
                            wtoken.startingView = null;
                            wtoken.startingWindow = null;
                            wtoken.startingDisplayed = WindowManagerService.SHOW_TRANSACTIONS;
                        }
                        break;
                    }
                    if (view != null) {
                        try {
                            WindowManagerService.this.mPolicy.removeStartingWindow(token, view);
                            return;
                        } catch (Throwable e22) {
                            Slog.w(WindowManagerService.TAG, "Exception when removing starting window", e22);
                            return;
                        }
                    }
                    return;
                case FINISHED_STARTING /*7*/:
                    while (true) {
                        synchronized (WindowManagerService.this.mWindowMap) {
                            N = WindowManagerService.this.mFinishedStarting.size();
                            if (N > 0) {
                                wtoken = (AppWindowToken) WindowManagerService.this.mFinishedStarting.remove(N - 1);
                                if (wtoken.startingWindow == null) {
                                } else {
                                    view = wtoken.startingView;
                                    token = wtoken.token;
                                    wtoken.startingData = null;
                                    wtoken.startingView = null;
                                    wtoken.startingWindow = null;
                                    wtoken.startingDisplayed = WindowManagerService.SHOW_TRANSACTIONS;
                                    try {
                                        WindowManagerService.this.mPolicy.removeStartingWindow(token, view);
                                    } catch (Throwable e222) {
                                        Slog.w(WindowManagerService.TAG, "Exception when removing starting window", e222);
                                    }
                                }
                                break;
                            }
                            return;
                            break;
                        }
                    }
                case REPORT_APPLICATION_TOKEN_WINDOWS /*8*/:
                    wtoken = (AppWindowToken) msg.obj;
                    boolean nowVisible = msg.arg1 != 0 ? WindowManagerService.HIDE_STACK_CRAWLS : WindowManagerService.SHOW_TRANSACTIONS;
                    if (msg.arg2 != 0) {
                    }
                    if (nowVisible) {
                        try {
                            wtoken.appToken.windowsVisible();
                            return;
                        } catch (RemoteException e3) {
                            return;
                        }
                    }
                    wtoken.appToken.windowsGone();
                    return;
                case REPORT_APPLICATION_TOKEN_DRAWN /*9*/:
                    try {
                        ((AppWindowToken) msg.obj).appToken.windowsDrawn();
                        return;
                    } catch (RemoteException e4) {
                        return;
                    }
                case WINDOW_FREEZE_TIMEOUT /*11*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        Slog.w(WindowManagerService.TAG, "Window freeze timeout expired.");
                        WindowList windows = WindowManagerService.this.getDefaultWindowListLocked();
                        i = windows.size();
                        while (i > 0) {
                            i--;
                            WindowState w = (WindowState) windows.get(i);
                            if (w.mOrientationChanging) {
                                w.mOrientationChanging = WindowManagerService.SHOW_TRANSACTIONS;
                                w.mLastFreezeDuration = (int) (SystemClock.elapsedRealtime() - WindowManagerService.this.mDisplayFreezeTime);
                                Slog.w(WindowManagerService.TAG, "Force clearing orientation change: " + w);
                            }
                        }
                        WindowManagerService.this.performLayoutAndPlaceSurfacesLocked();
                        break;
                    }
                    return;
                case APP_TRANSITION_TIMEOUT /*13*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        if (!(!WindowManagerService.this.mAppTransition.isTransitionSet() && WindowManagerService.this.mOpeningApps.isEmpty() && WindowManagerService.this.mClosingApps.isEmpty())) {
                            WindowManagerService.this.mAppTransition.setTimeout();
                            WindowManagerService.this.performLayoutAndPlaceSurfacesLocked();
                        }
                        break;
                    }
                    return;
                case PERSIST_ANIMATION_SCALE /*14*/:
                    Global.putFloat(WindowManagerService.this.mContext.getContentResolver(), "window_animation_scale", WindowManagerService.this.mWindowAnimationScaleSetting);
                    Global.putFloat(WindowManagerService.this.mContext.getContentResolver(), "transition_animation_scale", WindowManagerService.this.mTransitionAnimationScaleSetting);
                    Global.putFloat(WindowManagerService.this.mContext.getContentResolver(), "animator_duration_scale", WindowManagerService.this.mAnimatorDurationScaleSetting);
                    return;
                case FORCE_GC /*15*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        if (WindowManagerService.this.mAnimator.mAnimating || WindowManagerService.this.mAnimationScheduled) {
                            sendEmptyMessageDelayed(FORCE_GC, 2000);
                            return;
                        } else if (WindowManagerService.this.mDisplayFrozen) {
                            return;
                        } else {
                            Runtime.getRuntime().gc();
                            return;
                        }
                    }
                case ENABLE_SCREEN /*16*/:
                    WindowManagerService.this.performEnableScreen();
                    return;
                case APP_FREEZE_TIMEOUT /*17*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        Slog.w(WindowManagerService.TAG, "App freeze timeout expired.");
                        int numStacks = WindowManagerService.this.mStackIdToStack.size();
                        for (int stackNdx = WindowManagerService.WALLPAPER_DRAW_NORMAL; stackNdx < numStacks; stackNdx += WindowManagerService.WALLPAPER_DRAW_PENDING) {
                            ArrayList<Task> tasks = ((TaskStack) WindowManagerService.this.mStackIdToStack.valueAt(stackNdx)).getTasks();
                            for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
                                AppTokenList tokens = ((Task) tasks.get(taskNdx)).mAppTokens;
                                for (int tokenNdx = tokens.size() - 1; tokenNdx >= 0; tokenNdx--) {
                                    AppWindowToken tok = (AppWindowToken) tokens.get(tokenNdx);
                                    if (tok.mAppAnimator.freezingScreen) {
                                        Slog.w(WindowManagerService.TAG, "Force clearing freeze: " + tok);
                                        WindowManagerService.this.unsetAppFreezingScreenLocked(tok, WindowManagerService.HIDE_STACK_CRAWLS, WindowManagerService.HIDE_STACK_CRAWLS);
                                    }
                                }
                            }
                        }
                        break;
                    }
                    return;
                case SEND_NEW_CONFIGURATION /*18*/:
                    removeMessages(SEND_NEW_CONFIGURATION);
                    WindowManagerService.this.sendNewConfiguration();
                    return;
                case REPORT_WINDOWS_CHANGE /*19*/:
                    if (WindowManagerService.this.mWindowsChanged) {
                        synchronized (WindowManagerService.this.mWindowMap) {
                            WindowManagerService.this.mWindowsChanged = WindowManagerService.SHOW_TRANSACTIONS;
                            break;
                        }
                        WindowManagerService.this.notifyWindowsChanged();
                        return;
                    }
                    return;
                case DRAG_START_TIMEOUT /*20*/:
                    win = msg.obj;
                    synchronized (WindowManagerService.this.mWindowMap) {
                        if (WindowManagerService.this.mDragState != null) {
                            WindowManagerService.this.mDragState.unregister();
                            WindowManagerService.this.mInputMonitor.updateInputWindowsLw(WindowManagerService.HIDE_STACK_CRAWLS);
                            WindowManagerService.this.mDragState.reset();
                            WindowManagerService.this.mDragState = null;
                        }
                        break;
                    }
                    return;
                case DRAG_END_TIMEOUT /*21*/:
                    win = (IBinder) msg.obj;
                    synchronized (WindowManagerService.this.mWindowMap) {
                        if (WindowManagerService.this.mDragState != null) {
                            WindowManagerService.this.mDragState.mDragResult = WindowManagerService.SHOW_TRANSACTIONS;
                            WindowManagerService.this.mDragState.endDragLw();
                        }
                        break;
                    }
                    return;
                case REPORT_HARD_KEYBOARD_STATUS_CHANGE /*22*/:
                    WindowManagerService.this.notifyHardKeyboardStatusChange();
                    return;
                case BOOT_TIMEOUT /*23*/:
                    WindowManagerService.this.performBootTimeout();
                    return;
                case WAITING_FOR_DRAWN_TIMEOUT /*24*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        Slog.w(WindowManagerService.TAG, "Timeout waiting for drawn: undrawn=" + WindowManagerService.this.mWaitingForDrawn);
                        WindowManagerService.this.mWaitingForDrawn.clear();
                        callback = WindowManagerService.this.mWaitingForDrawnCallback;
                        WindowManagerService.this.mWaitingForDrawnCallback = null;
                        break;
                    }
                    if (callback != null) {
                        callback.run();
                        return;
                    }
                    return;
                case SHOW_STRICT_MODE_VIOLATION /*25*/:
                    WindowManagerService.this.showStrictModeViolation(msg.arg1, msg.arg2);
                    return;
                case DO_ANIMATION_CALLBACK /*26*/:
                    try {
                        ((IRemoteCallback) msg.obj).sendResult(null);
                        return;
                    } catch (RemoteException e5) {
                        return;
                    }
                case DO_DISPLAY_ADDED /*27*/:
                    WindowManagerService.this.handleDisplayAdded(msg.arg1);
                    return;
                case DO_DISPLAY_REMOVED /*28*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        WindowManagerService.this.handleDisplayRemovedLocked(msg.arg1);
                        break;
                    }
                    return;
                case DO_DISPLAY_CHANGED /*29*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        WindowManagerService.this.handleDisplayChangedLocked(msg.arg1);
                        break;
                    }
                    return;
                case CLIENT_FREEZE_TIMEOUT /*30*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        if (WindowManagerService.this.mClientFreezingScreen) {
                            WindowManagerService.this.mClientFreezingScreen = WindowManagerService.SHOW_TRANSACTIONS;
                            WindowManagerService.this.mLastFinishedFreezeSource = "client-timeout";
                            WindowManagerService.this.stopFreezingDisplayLocked();
                        }
                        break;
                    }
                    return;
                case NOTIFY_ACTIVITY_DRAWN /*32*/:
                    try {
                        WindowManagerService.this.mActivityManager.notifyActivityDrawn((IBinder) msg.obj);
                        return;
                    } catch (RemoteException e6) {
                        return;
                    }
                case ALL_WINDOWS_DRAWN /*33*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        callback = WindowManagerService.this.mWaitingForDrawnCallback;
                        WindowManagerService.this.mWaitingForDrawnCallback = null;
                        break;
                    }
                    if (callback != null) {
                        callback.run();
                        break;
                    }
                    break;
                case NEW_ANIMATOR_SCALE /*34*/:
                    break;
                case SHOW_CIRCULAR_DISPLAY_MASK /*35*/:
                    WindowManagerService.this.showCircularMask(msg.arg1 == WindowManagerService.WALLPAPER_DRAW_PENDING ? WindowManagerService.HIDE_STACK_CRAWLS : WindowManagerService.SHOW_TRANSACTIONS);
                    return;
                case SHOW_EMULATOR_DISPLAY_OVERLAY /*36*/:
                    WindowManagerService.this.showEmulatorDisplayOverlay();
                    return;
                case CHECK_IF_BOOT_ANIMATION_FINISHED /*37*/:
                    boolean bootAnimationComplete;
                    synchronized (WindowManagerService.this.mWindowMap) {
                        bootAnimationComplete = WindowManagerService.this.checkBootAnimationCompleteLocked();
                        break;
                    }
                    if (bootAnimationComplete) {
                        WindowManagerService.this.performEnableScreen();
                        return;
                    }
                    return;
                case RESET_ANR_MESSAGE /*38*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        WindowManagerService.this.mLastANRState = null;
                        break;
                    }
                    return;
                case WALLPAPER_DRAW_PENDING_TIMEOUT /*39*/:
                    synchronized (WindowManagerService.this.mWindowMap) {
                        if (WindowManagerService.this.mWallpaperDrawState == WindowManagerService.WALLPAPER_DRAW_PENDING) {
                            WindowManagerService.this.mWallpaperDrawState = REPORT_FOCUS_CHANGE;
                            WindowManagerService.this.performLayoutAndPlaceSurfacesLocked();
                        }
                        break;
                    }
                    return;
                default:
                    return;
            }
            float scale = WindowManagerService.this.getCurrentAnimatorScale();
            ValueAnimator.setDurationScale(scale);
            Session session = msg.obj;
            if (session != null) {
                try {
                    session.mCallback.onAnimatorScaleChanged(scale);
                    return;
                } catch (RemoteException e7) {
                    return;
                }
            }
            ArrayList<IWindowSessionCallback> callbacks = new ArrayList();
            synchronized (WindowManagerService.this.mWindowMap) {
                i = WindowManagerService.WALLPAPER_DRAW_NORMAL;
                while (true) {
                    if (i < WindowManagerService.this.mSessions.size()) {
                        callbacks.add(((Session) WindowManagerService.this.mSessions.valueAt(i)).mCallback);
                        i += WindowManagerService.WALLPAPER_DRAW_PENDING;
                    }
                }
            }
            for (i = WindowManagerService.WALLPAPER_DRAW_NORMAL; i < callbacks.size(); i += WindowManagerService.WALLPAPER_DRAW_PENDING) {
                try {
                    ((IWindowSessionCallback) callbacks.get(i)).onAnimatorScaleChanged(scale);
                } catch (RemoteException e8) {
                }
            }
        }
    }

    class LayoutFields {
        static final int SET_FORCE_HIDING_CHANGED = 4;
        static final int SET_ORIENTATION_CHANGE_COMPLETE = 8;
        static final int SET_TURN_ON_SCREEN = 16;
        static final int SET_UPDATE_ROTATION = 1;
        static final int SET_WALLPAPER_ACTION_PENDING = 32;
        static final int SET_WALLPAPER_MAY_CHANGE = 2;
        private float mButtonBrightness;
        boolean mDisplayHasContent;
        private Session mHoldScreen;
        Object mLastWindowFreezeSource;
        boolean mObscureApplicationContentOnSecondaryDisplays;
        private boolean mObscured;
        boolean mOrientationChangeComplete;
        float mPreferredRefreshRate;
        private float mScreenBrightness;
        private boolean mSyswin;
        private boolean mUpdateRotation;
        private long mUserActivityTimeout;
        boolean mWallpaperActionPending;
        boolean mWallpaperForceHidingChanged;
        boolean mWallpaperMayChange;

        LayoutFields() {
            this.mWallpaperForceHidingChanged = WindowManagerService.SHOW_TRANSACTIONS;
            this.mWallpaperMayChange = WindowManagerService.SHOW_TRANSACTIONS;
            this.mOrientationChangeComplete = WindowManagerService.HIDE_STACK_CRAWLS;
            this.mLastWindowFreezeSource = null;
            this.mHoldScreen = null;
            this.mObscured = WindowManagerService.SHOW_TRANSACTIONS;
            this.mSyswin = WindowManagerService.SHOW_TRANSACTIONS;
            this.mScreenBrightness = -1.0f;
            this.mButtonBrightness = -1.0f;
            this.mUserActivityTimeout = -1;
            this.mUpdateRotation = WindowManagerService.SHOW_TRANSACTIONS;
            this.mWallpaperActionPending = WindowManagerService.SHOW_TRANSACTIONS;
            this.mDisplayHasContent = WindowManagerService.SHOW_TRANSACTIONS;
            this.mObscureApplicationContentOnSecondaryDisplays = WindowManagerService.SHOW_TRANSACTIONS;
            this.mPreferredRefreshRate = 0.0f;
        }
    }

    private final class LocalService extends WindowManagerInternal {
        private LocalService() {
        }

        public void requestTraversalFromDisplayManager() {
            WindowManagerService.this.requestTraversal();
        }

        public void setMagnificationSpec(MagnificationSpec spec) {
            synchronized (WindowManagerService.this.mWindowMap) {
                if (WindowManagerService.this.mAccessibilityController != null) {
                    WindowManagerService.this.mAccessibilityController.setMagnificationSpecLocked(spec);
                } else {
                    throw new IllegalStateException("Magnification callbacks not set!");
                }
            }
            if (Binder.getCallingPid() != Process.myPid()) {
                spec.recycle();
            }
        }

        public MagnificationSpec getCompatibleMagnificationSpecForWindow(IBinder windowToken) {
            synchronized (WindowManagerService.this.mWindowMap) {
                WindowState windowState = (WindowState) WindowManagerService.this.mWindowMap.get(windowToken);
                if (windowState == null) {
                    return null;
                }
                MagnificationSpec spec = null;
                if (WindowManagerService.this.mAccessibilityController != null) {
                    spec = WindowManagerService.this.mAccessibilityController.getMagnificationSpecForWindowLocked(windowState);
                }
                if ((spec == null || spec.isNop()) && windowState.mGlobalScale == 1.0f) {
                    return null;
                }
                spec = spec == null ? MagnificationSpec.obtain() : MagnificationSpec.obtain(spec);
                spec.scale *= windowState.mGlobalScale;
                return spec;
            }
        }

        public void setMagnificationCallbacks(MagnificationCallbacks callbacks) {
            synchronized (WindowManagerService.this.mWindowMap) {
                if (WindowManagerService.this.mAccessibilityController == null) {
                    WindowManagerService.this.mAccessibilityController = new AccessibilityController(WindowManagerService.this);
                }
                WindowManagerService.this.mAccessibilityController.setMagnificationCallbacksLocked(callbacks);
                if (!WindowManagerService.this.mAccessibilityController.hasCallbacksLocked()) {
                    WindowManagerService.this.mAccessibilityController = null;
                }
            }
        }

        public void setWindowsForAccessibilityCallback(WindowsForAccessibilityCallback callback) {
            synchronized (WindowManagerService.this.mWindowMap) {
                if (WindowManagerService.this.mAccessibilityController == null) {
                    WindowManagerService.this.mAccessibilityController = new AccessibilityController(WindowManagerService.this);
                }
                WindowManagerService.this.mAccessibilityController.setWindowsForAccessibilityCallback(callback);
                if (!WindowManagerService.this.mAccessibilityController.hasCallbacksLocked()) {
                    WindowManagerService.this.mAccessibilityController = null;
                }
            }
        }

        public void setInputFilter(IInputFilter filter) {
            WindowManagerService.this.mInputManager.setInputFilter(filter);
        }

        public IBinder getFocusedWindowToken() {
            IBinder asBinder;
            synchronized (WindowManagerService.this.mWindowMap) {
                WindowState windowState = WindowManagerService.this.getFocusedWindowLocked();
                if (windowState != null) {
                    asBinder = windowState.mClient.asBinder();
                } else {
                    asBinder = null;
                }
            }
            return asBinder;
        }

        public boolean isKeyguardLocked() {
            return WindowManagerService.this.isKeyguardLocked();
        }

        public void showGlobalActions() {
            WindowManagerService.this.showGlobalActions();
        }

        public void getWindowFrame(IBinder token, Rect outBounds) {
            synchronized (WindowManagerService.this.mWindowMap) {
                WindowState windowState = (WindowState) WindowManagerService.this.mWindowMap.get(token);
                if (windowState != null) {
                    outBounds.set(windowState.mFrame);
                } else {
                    outBounds.setEmpty();
                }
            }
        }

        public void waitForAllWindowsDrawn(Runnable callback, long timeout) {
            synchronized (WindowManagerService.this.mWindowMap) {
                WindowManagerService.this.mWaitingForDrawnCallback = callback;
                WindowList windows = WindowManagerService.this.getDefaultWindowListLocked();
                for (int winNdx = windows.size() - 1; winNdx >= 0; winNdx--) {
                    WindowState win = (WindowState) windows.get(winNdx);
                    if (win.isVisibleLw() && (win.mAppToken != null || WindowManagerService.this.mPolicy.isForceHiding(win.mAttrs))) {
                        win.mWinAnimator.mDrawState = WindowManagerService.WALLPAPER_DRAW_PENDING;
                        win.mLastContentInsets.set(-1, -1, -1, -1);
                        WindowManagerService.this.mWaitingForDrawn.add(win);
                    }
                }
                WindowManagerService.this.requestTraversalLocked();
            }
            WindowManagerService.this.mH.removeMessages(24);
            if (WindowManagerService.this.mWaitingForDrawn.isEmpty()) {
                callback.run();
                return;
            }
            WindowManagerService.this.mH.sendEmptyMessageDelayed(24, timeout);
            WindowManagerService.this.checkDrawnWindowsLocked();
        }

        public void addWindowToken(IBinder token, int type) {
            WindowManagerService.this.addWindowToken(token, type);
        }

        public void removeWindowToken(IBinder token, boolean removeWindows) {
            synchronized (WindowManagerService.this.mWindowMap) {
                if (removeWindows) {
                    WindowToken wtoken = (WindowToken) WindowManagerService.this.mTokenMap.remove(token);
                    if (wtoken != null) {
                        wtoken.removeAllWindows();
                    }
                }
                WindowManagerService.this.removeWindowToken(token);
            }
        }
    }

    class RotationWatcher {
        DeathRecipient deathRecipient;
        IRotationWatcher watcher;

        RotationWatcher(IRotationWatcher w, DeathRecipient d) {
            this.watcher = w;
            this.deathRecipient = d;
        }
    }

    private final class SettingsObserver extends ContentObserver {
        private final Uri mDisplayInversionEnabledUri;
        private final Uri mShowImeWithHardKeyboardUri;

        public SettingsObserver() {
            super(new Handler());
            this.mShowImeWithHardKeyboardUri = Secure.getUriFor("show_ime_with_hard_keyboard");
            this.mDisplayInversionEnabledUri = Secure.getUriFor("accessibility_display_inversion_enabled");
            ContentResolver resolver = WindowManagerService.this.mContext.getContentResolver();
            resolver.registerContentObserver(this.mShowImeWithHardKeyboardUri, WindowManagerService.SHOW_TRANSACTIONS, this);
            resolver.registerContentObserver(this.mDisplayInversionEnabledUri, WindowManagerService.SHOW_TRANSACTIONS, this);
        }

        public void onChange(boolean selfChange, Uri uri) {
            if (this.mShowImeWithHardKeyboardUri.equals(uri)) {
                WindowManagerService.this.updateShowImeWithHardKeyboard();
            } else if (this.mDisplayInversionEnabledUri.equals(uri)) {
                WindowManagerService.this.updateCircularDisplayMaskIfNeeded();
            }
        }
    }

    private final void performLayoutAndPlaceSurfacesLockedInner(boolean r55) {
        /* JADX: method processing error */
/*
        Error: java.lang.OutOfMemoryError: Java heap space
	at java.util.Arrays.copyOf(Arrays.java:3181)
	at java.util.ArrayList.grow(ArrayList.java:261)
	at java.util.ArrayList.ensureExplicitCapacity(ArrayList.java:235)
	at java.util.ArrayList.ensureCapacityInternal(ArrayList.java:227)
	at java.util.ArrayList.add(ArrayList.java:458)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:447)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
	at jadx.core.utils.BlockUtils.collectWhileDominates(BlockUtils.java:448)
*/
        /*
        r54 = this;
        r6 = android.os.SystemClock.uptimeMillis();
        r44 = 0;
        r0 = r54;
        r4 = r0.mFocusMayChange;
        if (r4 == 0) goto L_0x001c;
    L_0x000c:
        r4 = 0;
        r0 = r54;
        r0.mFocusMayChange = r4;
        r4 = 3;
        r49 = 0;
        r0 = r54;
        r1 = r49;
        r44 = r0.updateFocusedWindowLocked(r4, r1);
    L_0x001c:
        r0 = r54;
        r4 = r0.mDisplayContents;
        r34 = r4.size();
        r24 = 0;
    L_0x0026:
        r0 = r24;
        r1 = r34;
        if (r0 >= r1) goto L_0x005c;
    L_0x002c:
        r0 = r54;
        r4 = r0.mDisplayContents;
        r0 = r24;
        r20 = r4.valueAt(r0);
        r20 = (com.android.server.wm.DisplayContent) r20;
        r0 = r20;
        r4 = r0.mExitingTokens;
        r4 = r4.size();
        r30 = r4 + -1;
    L_0x0042:
        if (r30 < 0) goto L_0x0059;
    L_0x0044:
        r0 = r20;
        r4 = r0.mExitingTokens;
        r0 = r30;
        r4 = r4.get(r0);
        r4 = (com.android.server.wm.WindowToken) r4;
        r49 = 0;
        r0 = r49;
        r4.hasVisible = r0;
        r30 = r30 + -1;
        goto L_0x0042;
    L_0x0059:
        r24 = r24 + 1;
        goto L_0x0026;
    L_0x005c:
        r0 = r54;
        r4 = r0.mStackIdToStack;
        r4 = r4.size();
        r39 = r4 + -1;
    L_0x0066:
        if (r39 < 0) goto L_0x0096;
    L_0x0068:
        r0 = r54;
        r4 = r0.mStackIdToStack;
        r0 = r39;
        r4 = r4.valueAt(r0);
        r4 = (com.android.server.wm.TaskStack) r4;
        r0 = r4.mExitingAppTokens;
        r27 = r0;
        r4 = r27.size();
        r42 = r4 + -1;
    L_0x007e:
        if (r42 < 0) goto L_0x0093;
    L_0x0080:
        r0 = r27;
        r1 = r42;
        r4 = r0.get(r1);
        r4 = (com.android.server.wm.AppWindowToken) r4;
        r49 = 0;
        r0 = r49;
        r4.hasVisible = r0;
        r42 = r42 + -1;
        goto L_0x007e;
    L_0x0093:
        r39 = r39 + -1;
        goto L_0x0066;
    L_0x0096:
        r0 = r54;
        r4 = r0.mInnerFields;
        r49 = 0;
        r0 = r49;
        r4.mHoldScreen = r0;
        r0 = r54;
        r4 = r0.mInnerFields;
        r49 = -1082130432; // 0xffffffffbf800000 float:-1.0 double:NaN;
        r0 = r49;
        r4.mScreenBrightness = r0;
        r0 = r54;
        r4 = r0.mInnerFields;
        r49 = -1082130432; // 0xffffffffbf800000 float:-1.0 double:NaN;
        r0 = r49;
        r4.mButtonBrightness = r0;
        r0 = r54;
        r4 = r0.mInnerFields;
        r50 = -1;
        r0 = r50;
        r4.mUserActivityTimeout = r0;
        r0 = r54;
        r4 = r0.mInnerFields;
        r49 = 0;
        r0 = r49;
        r4.mObscureApplicationContentOnSecondaryDisplays = r0;
        r0 = r54;
        r4 = r0.mTransactionSequence;
        r4 = r4 + 1;
        r0 = r54;
        r0.mTransactionSequence = r4;
        r15 = r54.getDefaultDisplayContentLocked();
        r17 = r15.getDisplayInfo();
        r0 = r17;
        r0 = r0.logicalWidth;
        r16 = r0;
        r0 = r17;
        r14 = r0.logicalHeight;
        android.view.SurfaceControl.openTransaction();
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mWatermark;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x00fa;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x00f1:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mWatermark;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r16;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.positionSurface(r0, r14);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x00fa:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mStrictModeFlash;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x0109;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0100:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mStrictModeFlash;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r16;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.positionSurface(r0, r14);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0109:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mCircularDisplayMask;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x0120;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x010f:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mCircularDisplayMask;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.mRotation;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r16;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.positionSurface(r0, r14, r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0120:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mEmulatorDisplayOverlay;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x0137;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0126:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mEmulatorDisplayOverlay;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.mRotation;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r16;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.positionSurface(r0, r14, r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0137:
        r29 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r24 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x013b:
        r0 = r24;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r34;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r0 >= r1) goto L_0x0618;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0141:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mDisplayContents;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r24;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r20 = r4.valueAt(r0);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r20 = (com.android.server.wm.DisplayContent) r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r43 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r48 = r20.getWindowList();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r22 = r20.getDisplayInfo();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r21 = r20.getDisplayId();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r22;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.logicalWidth;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r25 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r22;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.logicalHeight;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r19 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r22;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r8 = r0.appWidth;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r22;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r9 = r0.appHeight;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r21 != 0) goto L_0x01ea;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0171:
        r32 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0173:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mInnerFields;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.mDisplayHasContent = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mInnerFields;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.mPreferredRefreshRate = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r36 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0189:
        r36 = r36 + 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = 6;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r36;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r0 <= r4) goto L_0x01ed;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0190:
        r4 = "WindowManager";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = "Animation repeat aborted after too many iterations";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        android.util.Slog.w(r4, r0);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.layoutNeeded = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x019e:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mInnerFields;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.mObscured = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mInnerFields;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.mSyswin = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r20.resetDimming();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mLosingFocus;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.isEmpty();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != 0) goto L_0x0406;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x01c1:
        r37 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x01c3:
        r10 = r48.size();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r30 = r10 + -1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x01c9:
        if (r30 < 0) goto L_0x05d7;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x01cb:
        r0 = r48;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r30;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r5 = r0.get(r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r5 = (com.android.server.wm.WindowState) r5;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r38 = r5.getStack();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r38 != 0) goto L_0x040a;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x01db:
        r4 = r5.getAttrs();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.type;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 2030; // 0x7ee float:2.845E-42 double:1.003E-320;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == r0) goto L_0x040a;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x01e7:
        r30 = r30 + -1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        goto L_0x01c9;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x01ea:
        r32 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        goto L_0x0173;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x01ed:
        r4 = "On entry to LockedInner";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.debugLayoutRepeats(r4, r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 & 4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x0218;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0204:
        r4 = r54.adjustWallpaperWindowsLocked();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 & 2;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x0218;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x020c:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r48;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.assignLayersLocked(r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.layoutNeeded = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0218:
        if (r32 == 0) goto L_0x023b;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x021a:
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 & 2;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x023b;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0222:
        r4 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.updateOrientationFromAppTokensLocked(r4);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x023b;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x022b:
        r4 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.layoutNeeded = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mH;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 18;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.sendEmptyMessage(r0);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x023b:
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 & 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x0248;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0243:
        r4 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.layoutNeeded = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0248:
        r4 = 4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r36;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r0 >= r4) goto L_0x02c8;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x024d:
        r4 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r36;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r0 != r4) goto L_0x02c6;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0252:
        r4 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0253:
        r49 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r2 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.performLayoutLockedInner(r1, r4, r2);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x025e:
        r4 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.pendingLayoutChanges = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = new java.lang.StringBuilder;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.<init>();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = "loop number ";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.append(r0);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.mLayoutRepeatCount;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.append(r0);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.toString();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.debugLayoutRepeats(r4, r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r32 == 0) goto L_0x03fe;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x028f:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mPolicy;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r25;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r19;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.beginPostLayoutPolicyLw(r0, r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r48.size();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r30 = r4 + -1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x02a0:
        if (r30 < 0) goto L_0x03db;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x02a2:
        r0 = r48;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r30;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r5 = r0.get(r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r5 = (com.android.server.wm.WindowState) r5;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r5.mHasSurface;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x02c3;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x02b0:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mPolicy;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r5.mAttrs;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r5.mAttachedWindow;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r50 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r50;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.applyPostLayoutPolicyLw(r5, r0, r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x02c3:
        r30 = r30 + -1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        goto L_0x02a0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x02c6:
        r4 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        goto L_0x0253;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x02c8:
        r4 = "WindowManager";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = "Layout repeat skipped after too many iterations";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        android.util.Slog.w(r4, r0);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        goto L_0x025e;
    L_0x02d2:
        r26 = move-exception;
        r4 = "WindowManager";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = "Unhandled exception in Window Manager";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r26;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        android.util.Slog.wtf(r4, r0, r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        android.view.SurfaceControl.closeTransaction();
    L_0x02e1:
        r18 = r15.getWindowList();
        r0 = r54;
        r4 = r0.mAppTransition;
        r4 = r4.isReady();
        if (r4 == 0) goto L_0x030a;
    L_0x02ef:
        r4 = r15.pendingLayoutChanges;
        r0 = r54;
        r1 = r18;
        r49 = r0.handleAppTransitionReadyLocked(r1);
        r4 = r4 | r49;
        r15.pendingLayoutChanges = r4;
        r4 = "after handleAppTransitionReadyLocked";
        r0 = r15.pendingLayoutChanges;
        r49 = r0;
        r0 = r54;
        r1 = r49;
        r0.debugLayoutRepeats(r4, r1);
    L_0x030a:
        r0 = r54;
        r4 = r0.mAnimator;
        r4 = r4.mAnimating;
        if (r4 != 0) goto L_0x0333;
    L_0x0312:
        r0 = r54;
        r4 = r0.mAppTransition;
        r4 = r4.isRunning();
        if (r4 == 0) goto L_0x0333;
    L_0x031c:
        r4 = r15.pendingLayoutChanges;
        r49 = r54.handleAnimatingStoppedAndTransitionLocked();
        r4 = r4 | r49;
        r15.pendingLayoutChanges = r4;
        r4 = "after handleAnimStopAndXitionLock";
        r0 = r15.pendingLayoutChanges;
        r49 = r0;
        r0 = r54;
        r1 = r49;
        r0.debugLayoutRepeats(r4, r1);
    L_0x0333:
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mWallpaperForceHidingChanged;
        if (r4 == 0) goto L_0x035c;
    L_0x033b:
        r4 = r15.pendingLayoutChanges;
        if (r4 != 0) goto L_0x035c;
    L_0x033f:
        r0 = r54;
        r4 = r0.mAppTransition;
        r4 = r4.isReady();
        if (r4 != 0) goto L_0x035c;
    L_0x0349:
        r4 = r15.pendingLayoutChanges;
        r4 = r4 | 1;
        r15.pendingLayoutChanges = r4;
        r4 = "after animateAwayWallpaperLocked";
        r0 = r15.pendingLayoutChanges;
        r49 = r0;
        r0 = r54;
        r1 = r49;
        r0.debugLayoutRepeats(r4, r1);
    L_0x035c:
        r0 = r54;
        r4 = r0.mInnerFields;
        r49 = 0;
        r0 = r49;
        r4.mWallpaperForceHidingChanged = r0;
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mWallpaperMayChange;
        if (r4 == 0) goto L_0x0381;
    L_0x036e:
        r4 = r15.pendingLayoutChanges;
        r4 = r4 | 4;
        r15.pendingLayoutChanges = r4;
        r4 = "WallpaperMayChange";
        r0 = r15.pendingLayoutChanges;
        r49 = r0;
        r0 = r54;
        r1 = r49;
        r0.debugLayoutRepeats(r4, r1);
    L_0x0381:
        r0 = r54;
        r4 = r0.mFocusMayChange;
        if (r4 == 0) goto L_0x03a1;
    L_0x0387:
        r4 = 0;
        r0 = r54;
        r0.mFocusMayChange = r4;
        r4 = 2;
        r49 = 0;
        r0 = r54;
        r1 = r49;
        r4 = r0.updateFocusedWindowLocked(r4, r1);
        if (r4 == 0) goto L_0x03a1;
    L_0x0399:
        r44 = 1;
        r4 = r15.pendingLayoutChanges;
        r4 = r4 | 8;
        r15.pendingLayoutChanges = r4;
    L_0x03a1:
        r4 = r54.needsLayout();
        if (r4 == 0) goto L_0x03ba;
    L_0x03a7:
        r4 = r15.pendingLayoutChanges;
        r4 = r4 | 1;
        r15.pendingLayoutChanges = r4;
        r4 = "mLayoutNeeded";
        r0 = r15.pendingLayoutChanges;
        r49 = r0;
        r0 = r54;
        r1 = r49;
        r0.debugLayoutRepeats(r4, r1);
    L_0x03ba:
        r0 = r54;
        r4 = r0.mResizingWindows;
        r4 = r4.size();
        r30 = r4 + -1;
    L_0x03c4:
        if (r30 < 0) goto L_0x063f;
    L_0x03c6:
        r0 = r54;
        r4 = r0.mResizingWindows;
        r0 = r30;
        r46 = r4.get(r0);
        r46 = (com.android.server.wm.WindowState) r46;
        r0 = r46;
        r4 = r0.mAppFreezing;
        if (r4 == 0) goto L_0x0631;
    L_0x03d8:
        r30 = r30 + -1;
        goto L_0x03c4;
    L_0x03db:
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.mPolicy;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r49.finishPostLayoutPolicyLw();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 | r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.pendingLayoutChanges = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = "after finishPostLayoutPolicyLw";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.debugLayoutRepeats(r4, r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x03fe:
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != 0) goto L_0x0189;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0404:
        goto L_0x019e;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0406:
        r37 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        goto L_0x01c3;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x040a:
        r4 = r5.mObscured;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.mInnerFields;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r49.mObscured;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == r0) goto L_0x05c9;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x041a:
        r35 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x041c:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mInnerFields;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.mObscured;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r5.mObscured = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mInnerFields;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.mObscured;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != 0) goto L_0x0435;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0430:
        r4 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.handleNotObscuredLocked(r5, r6, r8, r9);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0435:
        if (r38 == 0) goto L_0x0442;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0437:
        r4 = r38.testDimmingTag();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != 0) goto L_0x0442;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x043d:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.handleFlagDimBehind(r5);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0442:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.handlePrivateFlagFullyTransparent(r5);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r32 == 0) goto L_0x045a;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0449:
        if (r35 == 0) goto L_0x045a;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x044b:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mWallpaperTarget;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != r5) goto L_0x045a;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0451:
        r4 = r5.isVisibleLw();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x045a;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0457:
        r54.updateWallpaperVisibilityLocked();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x045a:
        r0 = r5.mWinAnimator;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r47 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r5.mHasSurface;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x04d3;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0462:
        r4 = r5.shouldAnimateMove();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x04d3;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0468:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mContext;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 17432707; // 0x10a0083 float:2.5346964E-38 double:8.6129016E-317;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r11 = android.view.animation.AnimationUtils.loadAnimation(r4, r0);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r47;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.setAnimation(r11);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r5.mLastFrame;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.left;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r5.mFrame;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.left;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 - r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r47;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.mAnimDw = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r5.mLastFrame;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.top;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r5.mFrame;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.top;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 - r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r47;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.mAnimDh = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r47;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.mAnimateMove = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mAccessibilityController;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x04b6;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x04ad:
        if (r21 != 0) goto L_0x04b6;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x04af:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mAccessibilityController;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.onSomeWindowResizedOrMovedLocked();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x04b6:
        r4 = r5.mClient;	 Catch:{ RemoteException -> 0x09f8 }
        r0 = r5.mFrame;	 Catch:{ RemoteException -> 0x09f8 }
        r49 = r0;	 Catch:{ RemoteException -> 0x09f8 }
        r0 = r49;	 Catch:{ RemoteException -> 0x09f8 }
        r0 = r0.left;	 Catch:{ RemoteException -> 0x09f8 }
        r49 = r0;	 Catch:{ RemoteException -> 0x09f8 }
        r0 = r5.mFrame;	 Catch:{ RemoteException -> 0x09f8 }
        r50 = r0;	 Catch:{ RemoteException -> 0x09f8 }
        r0 = r50;	 Catch:{ RemoteException -> 0x09f8 }
        r0 = r0.top;	 Catch:{ RemoteException -> 0x09f8 }
        r50 = r0;	 Catch:{ RemoteException -> 0x09f8 }
        r0 = r49;	 Catch:{ RemoteException -> 0x09f8 }
        r1 = r50;	 Catch:{ RemoteException -> 0x09f8 }
        r4.moved(r0, r1);	 Catch:{ RemoteException -> 0x09f8 }
    L_0x04d3:
        r4 = 0;
        r5.mContentChanged = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r5.mHasSurface;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x04da:
        r4 = r5.isHiddenFromUserLocked();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != 0) goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x04e0:
        r0 = r47;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r13 = r0.commitFinishDrawingLocked(r6);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r32 == 0) goto L_0x053a;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x04e8:
        if (r13 == 0) goto L_0x053a;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x04ea:
        r4 = r5.mAttrs;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.type;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 2023; // 0x7e7 float:2.835E-42 double:9.995E-321;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != r0) goto L_0x050d;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x04f4:
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 | 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.pendingLayoutChanges = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = "dream and commitFinishDrawingLocked true";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.debugLayoutRepeats(r4, r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x050d:
        r4 = r5.mAttrs;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.flags;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 1048576; // 0x100000 float:1.469368E-39 double:5.180654E-318;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 & r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x053a;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0517:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mInnerFields;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.mWallpaperMayChange = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 | 4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.pendingLayoutChanges = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = "wallpaper and commitFinishDrawingLocked true";	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.pendingLayoutChanges;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.debugLayoutRepeats(r4, r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x053a:
        r0 = r47;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r55;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.setSurfaceBoundariesLocked(r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r12 = r5.mAppToken;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r12 == 0) goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0545:
        r4 = r12.allDrawn;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x054f;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0549:
        r4 = r12.mAppAnimator;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.freezingScreen;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x054f:
        r0 = r12.lastTransactionSequence;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r50 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mTransactionSequence;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = (long) r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r52 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = (r50 > r52 ? 1 : (r50 == r52 ? 0 : -1));	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x0571;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x055e:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mTransactionSequence;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = (long) r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r50 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r50;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r12.lastTransactionSequence = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r12.numDrawnWindows = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r12.numInterestingWindows = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = 0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r12.startingDisplayed = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0571:
        r4 = r5.isOnScreenIgnoringKeyguard();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != 0) goto L_0x0581;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0577:
        r0 = r47;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mAttrType;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != r0) goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0581:
        r4 = r5.mExiting;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != 0) goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0585:
        r4 = r5.mDestroying;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != 0) goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0589:
        r4 = r12.startingWindow;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r5 == r4) goto L_0x05cd;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x058d:
        r4 = r12.mAppAnimator;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4.freezingScreen;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x0597;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0593:
        r4 = r5.mAppFreezing;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 != 0) goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0597:
        r4 = r12.numInterestingWindows;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 + 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r12.numInterestingWindows = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r5.isDrawnLw();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x05a3:
        r4 = r12.numDrawnWindows;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r4 + 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r12.numDrawnWindows = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r43 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x05ab:
        if (r32 == 0) goto L_0x05bd;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x05ad:
        if (r37 == 0) goto L_0x05bd;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x05af:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mCurrentFocus;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r5 != r4) goto L_0x05bd;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x05b5:
        r4 = r5.isDisplayedLw();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x05bd;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x05bb:
        r29 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x05bd:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.updateResizingWindows(r5);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        goto L_0x01e7;
    L_0x05c4:
        r4 = move-exception;
        android.view.SurfaceControl.closeTransaction();
        throw r4;
    L_0x05c9:
        r35 = 0;
        goto L_0x041c;
    L_0x05cd:
        r4 = r5.isDrawnLw();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r4 == 0) goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x05d3:
        r4 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r12.startingDisplayed = r4;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        goto L_0x05ab;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x05d7:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mDisplayManagerInternal;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.mInnerFields;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.mDisplayHasContent;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.mInnerFields;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r50 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r50;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r0.mPreferredRefreshRate;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r50 = r0;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r51 = 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r21;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r2 = r50;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r3 = r51;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.setDisplayProperties(r0, r1, r2, r3);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r21;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.getDisplayContentLocked(r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.stopDimmingIfNeeded();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        if (r43 == 0) goto L_0x0614;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x060d:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r1 = r20;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0.updateAllDrawnLocked(r1);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0614:
        r24 = r24 + 1;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        goto L_0x013b;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0618:
        if (r29 == 0) goto L_0x0625;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x061a:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mH;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r49 = 3;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r0 = r49;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.sendEmptyMessage(r0);	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
    L_0x0625:
        r0 = r54;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4 = r0.mDisplayManagerInternal;	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        r4.performTraversalInTransactionFromWindowManager();	 Catch:{ RuntimeException -> 0x02d2, all -> 0x05c4 }
        android.view.SurfaceControl.closeTransaction();
        goto L_0x02e1;
    L_0x0631:
        r46.reportResized();
        r0 = r54;
        r4 = r0.mResizingWindows;
        r0 = r30;
        r4.remove(r0);
        goto L_0x03d8;
    L_0x063f:
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mOrientationChangeComplete;
        if (r4 == 0) goto L_0x066a;
    L_0x0647:
        r0 = r54;
        r4 = r0.mWindowsFreezingScreen;
        if (r4 == 0) goto L_0x0667;
    L_0x064d:
        r4 = 0;
        r0 = r54;
        r0.mWindowsFreezingScreen = r4;
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mLastWindowFreezeSource;
        r0 = r54;
        r0.mLastFinishedFreezeSource = r4;
        r0 = r54;
        r4 = r0.mH;
        r49 = 11;
        r0 = r49;
        r4.removeMessages(r0);
    L_0x0667:
        r54.stopFreezingDisplayLocked();
    L_0x066a:
        r45 = 0;
        r0 = r54;
        r4 = r0.mDestroySurface;
        r30 = r4.size();
        if (r30 <= 0) goto L_0x06b0;
    L_0x0676:
        r30 = r30 + -1;
        r0 = r54;
        r4 = r0.mDestroySurface;
        r0 = r30;
        r46 = r4.get(r0);
        r46 = (com.android.server.wm.WindowState) r46;
        r4 = 0;
        r0 = r46;
        r0.mDestroying = r4;
        r0 = r54;
        r4 = r0.mInputMethodWindow;
        r0 = r46;
        if (r4 != r0) goto L_0x0696;
    L_0x0691:
        r4 = 0;
        r0 = r54;
        r0.mInputMethodWindow = r4;
    L_0x0696:
        r0 = r54;
        r4 = r0.mWallpaperTarget;
        r0 = r46;
        if (r0 != r4) goto L_0x06a0;
    L_0x069e:
        r45 = 1;
    L_0x06a0:
        r0 = r46;
        r4 = r0.mWinAnimator;
        r4.destroySurfaceLocked();
        if (r30 > 0) goto L_0x0676;
    L_0x06a9:
        r0 = r54;
        r4 = r0.mDestroySurface;
        r4.clear();
    L_0x06b0:
        r24 = 0;
    L_0x06b2:
        r0 = r24;
        r1 = r34;
        if (r0 >= r1) goto L_0x0702;
    L_0x06b8:
        r0 = r54;
        r4 = r0.mDisplayContents;
        r0 = r24;
        r20 = r4.valueAt(r0);
        r20 = (com.android.server.wm.DisplayContent) r20;
        r0 = r20;
        r0 = r0.mExitingTokens;
        r28 = r0;
        r4 = r28.size();
        r30 = r4 + -1;
    L_0x06d0:
        if (r30 < 0) goto L_0x06ff;
    L_0x06d2:
        r0 = r28;
        r1 = r30;
        r41 = r0.get(r1);
        r41 = (com.android.server.wm.WindowToken) r41;
        r0 = r41;
        r4 = r0.hasVisible;
        if (r4 != 0) goto L_0x06fc;
    L_0x06e2:
        r0 = r28;
        r1 = r30;
        r0.remove(r1);
        r0 = r41;
        r4 = r0.windowType;
        r49 = 2013; // 0x7dd float:2.821E-42 double:9.946E-321;
        r0 = r49;
        if (r4 != r0) goto L_0x06fc;
    L_0x06f3:
        r0 = r54;
        r4 = r0.mWallpaperTokens;
        r0 = r41;
        r4.remove(r0);
    L_0x06fc:
        r30 = r30 + -1;
        goto L_0x06d0;
    L_0x06ff:
        r24 = r24 + 1;
        goto L_0x06b2;
    L_0x0702:
        r0 = r54;
        r4 = r0.mStackIdToStack;
        r4 = r4.size();
        r39 = r4 + -1;
    L_0x070c:
        if (r39 < 0) goto L_0x07a3;
    L_0x070e:
        r0 = r54;
        r4 = r0.mStackIdToStack;
        r0 = r39;
        r4 = r4.valueAt(r0);
        r4 = (com.android.server.wm.TaskStack) r4;
        r0 = r4.mExitingAppTokens;
        r27 = r0;
        r4 = r27.size();
        r30 = r4 + -1;
    L_0x0724:
        if (r30 < 0) goto L_0x079f;
    L_0x0726:
        r0 = r27;
        r1 = r30;
        r41 = r0.get(r1);
        r41 = (com.android.server.wm.AppWindowToken) r41;
        r0 = r41;
        r4 = r0.hasVisible;
        if (r4 != 0) goto L_0x079c;
    L_0x0736:
        r0 = r54;
        r4 = r0.mClosingApps;
        r0 = r41;
        r4 = r4.contains(r0);
        if (r4 != 0) goto L_0x079c;
    L_0x0742:
        r0 = r41;
        r4 = r0.mDeferRemoval;
        if (r4 == 0) goto L_0x0752;
    L_0x0748:
        r0 = r41;
        r4 = r0.allAppWindows;
        r4 = r4.isEmpty();
        if (r4 == 0) goto L_0x079c;
    L_0x0752:
        r0 = r41;
        r4 = r0.mAppAnimator;
        r4.clearAnimation();
        r0 = r41;
        r4 = r0.mAppAnimator;
        r49 = 0;
        r0 = r49;
        r4.animating = r0;
        r0 = r54;
        r1 = r41;
        r0.removeAppFromTaskLocked(r1);
        r0 = r27;
        r1 = r30;
        r0.remove(r1);
        r0 = r54;
        r4 = r0.mTaskIdToTask;
        r0 = r41;
        r0 = r0.groupId;
        r49 = r0;
        r0 = r49;
        r40 = r4.get(r0);
        r40 = (com.android.server.wm.Task) r40;
        if (r40 == 0) goto L_0x079c;
    L_0x0785:
        r0 = r40;
        r4 = r0.mDeferRemoval;
        if (r4 == 0) goto L_0x079c;
    L_0x078b:
        r0 = r40;
        r4 = r0.mAppTokens;
        r4 = r4.isEmpty();
        if (r4 == 0) goto L_0x079c;
    L_0x0795:
        r0 = r54;
        r1 = r40;
        r0.removeTaskLocked(r1);
    L_0x079c:
        r30 = r30 + -1;
        goto L_0x0724;
    L_0x079f:
        r39 = r39 + -1;
        goto L_0x070c;
    L_0x07a3:
        r0 = r54;
        r4 = r0.mAnimator;
        r4 = r4.mAnimating;
        if (r4 != 0) goto L_0x07dc;
    L_0x07ab:
        r0 = r54;
        r4 = r0.mRelayoutWhileAnimating;
        r4 = r4.size();
        if (r4 <= 0) goto L_0x07dc;
    L_0x07b5:
        r0 = r54;
        r4 = r0.mRelayoutWhileAnimating;
        r4 = r4.size();
        r33 = r4 + -1;
    L_0x07bf:
        if (r33 < 0) goto L_0x07d5;
    L_0x07c1:
        r0 = r54;	 Catch:{ RemoteException -> 0x09f5 }
        r4 = r0.mRelayoutWhileAnimating;	 Catch:{ RemoteException -> 0x09f5 }
        r0 = r33;	 Catch:{ RemoteException -> 0x09f5 }
        r4 = r4.get(r0);	 Catch:{ RemoteException -> 0x09f5 }
        r4 = (com.android.server.wm.WindowState) r4;	 Catch:{ RemoteException -> 0x09f5 }
        r4 = r4.mClient;	 Catch:{ RemoteException -> 0x09f5 }
        r4.doneAnimating();	 Catch:{ RemoteException -> 0x09f5 }
    L_0x07d2:
        r33 = r33 + -1;
        goto L_0x07bf;
    L_0x07d5:
        r0 = r54;
        r4 = r0.mRelayoutWhileAnimating;
        r4.clear();
    L_0x07dc:
        if (r45 == 0) goto L_0x07e7;
    L_0x07de:
        r4 = r15.pendingLayoutChanges;
        r4 = r4 | 4;
        r15.pendingLayoutChanges = r4;
        r4 = 1;
        r15.layoutNeeded = r4;
    L_0x07e7:
        r24 = 0;
    L_0x07e9:
        r0 = r24;
        r1 = r34;
        if (r0 >= r1) goto L_0x0809;
    L_0x07ef:
        r0 = r54;
        r4 = r0.mDisplayContents;
        r0 = r24;
        r20 = r4.valueAt(r0);
        r20 = (com.android.server.wm.DisplayContent) r20;
        r0 = r20;
        r4 = r0.pendingLayoutChanges;
        if (r4 == 0) goto L_0x0806;
    L_0x0801:
        r4 = 1;
        r0 = r20;
        r0.layoutNeeded = r4;
    L_0x0806:
        r24 = r24 + 1;
        goto L_0x07e9;
    L_0x0809:
        r0 = r54;
        r4 = r0.mInputMonitor;
        r49 = 1;
        r0 = r49;
        r4.updateInputWindowsLw(r0);
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mHoldScreen;
        r0 = r54;
        r0.setHoldScreenLocked(r4);
        r0 = r54;
        r4 = r0.mDisplayFrozen;
        if (r4 != 0) goto L_0x0888;
    L_0x0827:
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mScreenBrightness;
        r49 = 0;
        r4 = (r4 > r49 ? 1 : (r4 == r49 ? 0 : -1));
        if (r4 < 0) goto L_0x0843;
    L_0x0835:
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mScreenBrightness;
        r49 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r4 = (r4 > r49 ? 1 : (r4 == r49 ? 0 : -1));
        if (r4 <= 0) goto L_0x095a;
    L_0x0843:
        r0 = r54;
        r4 = r0.mPowerManagerInternal;
        r49 = -1;
        r0 = r49;
        r4.setScreenBrightnessOverrideFromWindowManager(r0);
    L_0x084e:
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mButtonBrightness;
        r49 = 0;
        r4 = (r4 > r49 ? 1 : (r4 == r49 ? 0 : -1));
        if (r4 < 0) goto L_0x086a;
    L_0x085c:
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mButtonBrightness;
        r49 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        r4 = (r4 > r49 ? 1 : (r4 == r49 ? 0 : -1));
        if (r4 <= 0) goto L_0x0977;
    L_0x086a:
        r0 = r54;
        r4 = r0.mPowerManagerInternal;
        r49 = -1;
        r0 = r49;
        r4.setButtonBrightnessOverrideFromWindowManager(r0);
    L_0x0875:
        r0 = r54;
        r4 = r0.mPowerManagerInternal;
        r0 = r54;
        r0 = r0.mInnerFields;
        r49 = r0;
        r50 = r49.mUserActivityTimeout;
        r0 = r50;
        r4.setUserActivityTimeoutOverrideFromWindowManager(r0);
    L_0x0888:
        r0 = r54;
        r4 = r0.mTurnOnScreen;
        if (r4 == 0) goto L_0x08bc;
    L_0x088e:
        r0 = r54;
        r4 = r0.mAllowTheaterModeWakeFromLayout;
        if (r4 != 0) goto L_0x08aa;
    L_0x0894:
        r0 = r54;
        r4 = r0.mContext;
        r4 = r4.getContentResolver();
        r49 = "theater_mode_on";
        r50 = 0;
        r0 = r49;
        r1 = r50;
        r4 = android.provider.Settings.Global.getInt(r4, r0, r1);
        if (r4 != 0) goto L_0x08b7;
    L_0x08aa:
        r0 = r54;
        r4 = r0.mPowerManager;
        r50 = android.os.SystemClock.uptimeMillis();
        r0 = r50;
        r4.wakeUp(r0);
    L_0x08b7:
        r4 = 0;
        r0 = r54;
        r0.mTurnOnScreen = r4;
    L_0x08bc:
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mUpdateRotation;
        if (r4 == 0) goto L_0x08da;
    L_0x08c6:
        r4 = 0;
        r0 = r54;
        r4 = r0.updateRotationUncheckedLocked(r4);
        if (r4 == 0) goto L_0x0994;
    L_0x08cf:
        r0 = r54;
        r4 = r0.mH;
        r49 = 18;
        r0 = r49;
        r4.sendEmptyMessage(r0);
    L_0x08da:
        r0 = r54;
        r4 = r0.mWaitingForDrawnCallback;
        if (r4 != 0) goto L_0x08f6;
    L_0x08e0:
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mOrientationChangeComplete;
        if (r4 == 0) goto L_0x08f9;
    L_0x08e8:
        r4 = r15.layoutNeeded;
        if (r4 != 0) goto L_0x08f9;
    L_0x08ec:
        r0 = r54;
        r4 = r0.mInnerFields;
        r4 = r4.mUpdateRotation;
        if (r4 != 0) goto L_0x08f9;
    L_0x08f6:
        r54.checkDrawnWindowsLocked();
    L_0x08f9:
        r0 = r54;
        r4 = r0.mPendingRemove;
        r10 = r4.size();
        if (r10 <= 0) goto L_0x09c0;
    L_0x0903:
        r0 = r54;
        r4 = r0.mPendingRemoveTmp;
        r4 = r4.length;
        if (r4 >= r10) goto L_0x0912;
    L_0x090a:
        r4 = r10 + 10;
        r4 = new com.android.server.wm.WindowState[r4];
        r0 = r54;
        r0.mPendingRemoveTmp = r4;
    L_0x0912:
        r0 = r54;
        r4 = r0.mPendingRemove;
        r0 = r54;
        r0 = r0.mPendingRemoveTmp;
        r49 = r0;
        r0 = r49;
        r4.toArray(r0);
        r0 = r54;
        r4 = r0.mPendingRemove;
        r4.clear();
        r23 = new com.android.server.wm.DisplayContentList;
        r23.<init>();
        r30 = 0;
    L_0x092f:
        r0 = r30;
        if (r0 >= r10) goto L_0x09a1;
    L_0x0933:
        r0 = r54;
        r4 = r0.mPendingRemoveTmp;
        r5 = r4[r30];
        r4 = r5.mSession;
        r0 = r54;
        r0.removeWindowInnerLocked(r4, r5);
        r20 = r5.getDisplayContent();
        if (r20 == 0) goto L_0x0957;
    L_0x0946:
        r0 = r23;
        r1 = r20;
        r4 = r0.contains(r1);
        if (r4 != 0) goto L_0x0957;
    L_0x0950:
        r0 = r23;
        r1 = r20;
        r0.add(r1);
    L_0x0957:
        r30 = r30 + 1;
        goto L_0x092f;
    L_0x095a:
        r0 = r54;
        r4 = r0.mPowerManagerInternal;
        r0 = r54;
        r0 = r0.mInnerFields;
        r49 = r0;
        r49 = r49.mScreenBrightness;
        r0 = r54;
        r1 = r49;
        r49 = r0.toBrightnessOverride(r1);
        r0 = r49;
        r4.setScreenBrightnessOverrideFromWindowManager(r0);
        goto L_0x084e;
    L_0x0977:
        r0 = r54;
        r4 = r0.mPowerManagerInternal;
        r0 = r54;
        r0 = r0.mInnerFields;
        r49 = r0;
        r49 = r49.mButtonBrightness;
        r0 = r54;
        r1 = r49;
        r49 = r0.toBrightnessOverride(r1);
        r0 = r49;
        r4.setButtonBrightnessOverrideFromWindowManager(r0);
        goto L_0x0875;
    L_0x0994:
        r0 = r54;
        r4 = r0.mInnerFields;
        r49 = 0;
        r0 = r49;
        r4.mUpdateRotation = r0;
        goto L_0x08da;
    L_0x09a1:
        r31 = r23.iterator();
    L_0x09a5:
        r4 = r31.hasNext();
        if (r4 == 0) goto L_0x09c0;
    L_0x09ab:
        r20 = r31.next();
        r20 = (com.android.server.wm.DisplayContent) r20;
        r4 = r20.getWindowList();
        r0 = r54;
        r0.assignLayersLocked(r4);
        r4 = 1;
        r0 = r20;
        r0.layoutNeeded = r4;
        goto L_0x09a5;
    L_0x09c0:
        r0 = r54;
        r4 = r0.mDisplayContents;
        r4 = r4.size();
        r24 = r4 + -1;
    L_0x09ca:
        if (r24 < 0) goto L_0x09de;
    L_0x09cc:
        r0 = r54;
        r4 = r0.mDisplayContents;
        r0 = r24;
        r4 = r4.valueAt(r0);
        r4 = (com.android.server.wm.DisplayContent) r4;
        r4.checkForDeferredActions();
        r24 = r24 + -1;
        goto L_0x09ca;
    L_0x09de:
        if (r44 == 0) goto L_0x09eb;
    L_0x09e0:
        r0 = r54;
        r4 = r0.mInputMonitor;
        r49 = 0;
        r0 = r49;
        r4.updateInputWindowsLw(r0);
    L_0x09eb:
        r54.setFocusedStackFrame();
        r54.enableScreenIfNeededLocked();
        r54.scheduleAnimationLocked();
        return;
    L_0x09f5:
        r4 = move-exception;
        goto L_0x07d2;
    L_0x09f8:
        r4 = move-exception;
        goto L_0x04d3;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.performLayoutAndPlaceSurfacesLockedInner(boolean):void");
    }

    public static WindowManagerService main(Context context, InputManagerService im, boolean haveInputMethods, boolean showBootMsgs, boolean onlyCore) {
        WindowManagerService[] holder = new WindowManagerService[WALLPAPER_DRAW_PENDING];
        DisplayThread.getHandler().runWithScissors(new C05632(holder, context, im, haveInputMethods, showBootMsgs, onlyCore), 0);
        return holder[WALLPAPER_DRAW_NORMAL];
    }

    private void initPolicy() {
        UiThread.getHandler().runWithScissors(new C05643(), 0);
    }

    private WindowManagerService(Context context, InputManagerService inputManager, boolean haveInputMethods, boolean showBootMsgs, boolean onlyCore) {
        this.mBroadcastReceiver = new C05621();
        int[] iArr = new int[WALLPAPER_DRAW_PENDING];
        iArr[WALLPAPER_DRAW_NORMAL] = WALLPAPER_DRAW_NORMAL;
        this.mCurrentProfileIds = iArr;
        this.mPolicy = PolicyManager.makeNewWindowManager();
        this.mSessions = new ArraySet();
        this.mWindowMap = new HashMap();
        this.mTokenMap = new HashMap();
        this.mFinishedStarting = new ArrayList();
        this.mFakeWindows = new ArrayList();
        this.mResizingWindows = new ArrayList();
        this.mPendingRemove = new ArrayList();
        this.mPendingStacksRemove = new ArraySet();
        this.mPendingRemoveTmp = new WindowState[20];
        this.mDestroySurface = new ArrayList();
        this.mLosingFocus = new ArrayList();
        this.mWaitingForDrawn = new ArrayList();
        this.mRelayoutWhileAnimating = new ArrayList();
        this.mRebuildTmp = new WindowState[20];
        this.mScreenCaptureDisabled = new SparseArray();
        this.mTmpFloats = new float[9];
        this.mTmpContentRect = new Rect();
        this.mDisplayEnabled = SHOW_TRANSACTIONS;
        this.mSystemBooted = SHOW_TRANSACTIONS;
        this.mForceDisplayEnabled = SHOW_TRANSACTIONS;
        this.mShowingBootMessages = SHOW_TRANSACTIONS;
        this.mBootAnimationStopped = SHOW_TRANSACTIONS;
        this.mDisplayContents = new SparseArray(WALLPAPER_DRAW_TIMEOUT);
        this.mRotation = WALLPAPER_DRAW_NORMAL;
        this.mForcedAppOrientation = -1;
        this.mAltOrientation = SHOW_TRANSACTIONS;
        this.mRotationWatchers = new ArrayList();
        this.mSystemDecorLayer = WALLPAPER_DRAW_NORMAL;
        this.mScreenRect = new Rect();
        this.mTraversalScheduled = SHOW_TRANSACTIONS;
        this.mDisplayFrozen = SHOW_TRANSACTIONS;
        this.mDisplayFreezeTime = 0;
        this.mLastDisplayFreezeDuration = WALLPAPER_DRAW_NORMAL;
        this.mLastFinishedFreezeSource = null;
        this.mWaitingForConfig = SHOW_TRANSACTIONS;
        this.mWindowsFreezingScreen = SHOW_TRANSACTIONS;
        this.mClientFreezingScreen = SHOW_TRANSACTIONS;
        this.mAppsFreezingScreen = WALLPAPER_DRAW_NORMAL;
        this.mLastWindowForcedOrientation = -1;
        this.mLastKeyguardForcedOrientation = WINDOW_LAYER_MULTIPLIER;
        this.mLayoutSeq = WALLPAPER_DRAW_NORMAL;
        this.mLastStatusBarVisibility = WALLPAPER_DRAW_NORMAL;
        this.mCurConfiguration = new Configuration();
        this.mStartingIconInTransition = SHOW_TRANSACTIONS;
        this.mSkipAppTransitionAnimation = SHOW_TRANSACTIONS;
        this.mOpeningApps = new ArraySet();
        this.mClosingApps = new ArraySet();
        this.mDisplayMetrics = new DisplayMetrics();
        this.mRealDisplayMetrics = new DisplayMetrics();
        this.mTmpDisplayMetrics = new DisplayMetrics();
        this.mCompatDisplayMetrics = new DisplayMetrics();
        this.mH = new C0569H();
        this.mChoreographer = Choreographer.getInstance();
        this.mCurrentFocus = null;
        this.mLastFocus = null;
        this.mInputMethodTarget = null;
        this.mInputMethodWindow = null;
        this.mInputMethodDialogs = new ArrayList();
        this.mWallpaperTokens = new ArrayList();
        this.mWallpaperTarget = null;
        this.mLowerWallpaperTarget = null;
        this.mUpperWallpaperTarget = null;
        this.mLastWallpaperX = -1.0f;
        this.mLastWallpaperY = -1.0f;
        this.mLastWallpaperXStep = -1.0f;
        this.mLastWallpaperYStep = -1.0f;
        this.mLastWallpaperDisplayOffsetX = SoundTriggerHelper.STATUS_ERROR;
        this.mLastWallpaperDisplayOffsetY = SoundTriggerHelper.STATUS_ERROR;
        this.mWallpaperDrawState = WALLPAPER_DRAW_NORMAL;
        this.mFocusedApp = null;
        this.mWindowAnimationScaleSetting = 0.75f;
        this.mTransitionAnimationScaleSetting = 0.75f;
        this.mAnimatorDurationScaleSetting = 0.75f;
        this.mAnimationsDisabled = SHOW_TRANSACTIONS;
        this.mDragState = null;
        this.mInnerFields = new LayoutFields();
        this.mTaskIdToTask = new SparseArray();
        this.mStackIdToStack = new SparseArray();
        this.mWindowChangeListeners = new ArrayList();
        this.mWindowsChanged = SHOW_TRANSACTIONS;
        this.mTempConfiguration = new Configuration();
        this.mInputMonitor = new InputMonitor(this);
        this.mInLayout = SHOW_TRANSACTIONS;
        this.mContext = context;
        this.mHaveInputMethods = haveInputMethods;
        this.mAllowBootMessages = showBootMsgs;
        this.mOnlyCore = onlyCore;
        this.mLimitedAlphaCompositing = context.getResources().getBoolean(17956878);
        this.mHasPermanentDpad = context.getResources().getBoolean(17956988);
        this.mInTouchMode = context.getResources().getBoolean(17957014);
        this.mInputManager = inputManager;
        this.mDisplayManagerInternal = (DisplayManagerInternal) LocalServices.getService(DisplayManagerInternal.class);
        this.mDisplaySettings = new DisplaySettings();
        this.mDisplaySettings.readSettingsLocked();
        LocalServices.addService(WindowManagerPolicy.class, this.mPolicy);
        this.mPointerEventDispatcher = new PointerEventDispatcher(this.mInputManager.monitorInput(TAG));
        this.mFxSession = new SurfaceSession();
        this.mDisplayManager = (DisplayManager) context.getSystemService("display");
        this.mDisplays = this.mDisplayManager.getDisplays();
        Display[] arr$ = this.mDisplays;
        int len$ = arr$.length;
        for (int i$ = WALLPAPER_DRAW_NORMAL; i$ < len$; i$ += WALLPAPER_DRAW_PENDING) {
            createDisplayContentLocked(arr$[i$]);
        }
        this.mKeyguardDisableHandler = new KeyguardDisableHandler(this.mContext, this.mPolicy);
        this.mPowerManager = (PowerManager) context.getSystemService("power");
        this.mPowerManagerInternal = (PowerManagerInternal) LocalServices.getService(PowerManagerInternal.class);
        this.mPowerManagerInternal.registerLowPowerModeObserver(new C05654());
        this.mAnimationsDisabled = this.mPowerManagerInternal.getLowPowerModeEnabled();
        this.mScreenFrozenLock = this.mPowerManager.newWakeLock(WALLPAPER_DRAW_PENDING, "SCREEN_FROZEN");
        this.mScreenFrozenLock.setReferenceCounted(SHOW_TRANSACTIONS);
        this.mAppTransition = new AppTransition(context, this.mH);
        this.mActivityManager = ActivityManagerNative.getDefault();
        this.mBatteryStats = BatteryStatsService.getService();
        this.mAppOps = (AppOpsManager) context.getSystemService("appops");
        OnOpChangedInternalListener opListener = new C05665();
        this.mAppOps.startWatchingMode(24, null, opListener);
        this.mAppOps.startWatchingMode(45, null, opListener);
        this.mWindowAnimationScaleSetting = Global.getFloat(context.getContentResolver(), "window_animation_scale", this.mWindowAnimationScaleSetting);
        this.mTransitionAnimationScaleSetting = Global.getFloat(context.getContentResolver(), "transition_animation_scale", this.mTransitionAnimationScaleSetting);
        setAnimatorDurationScale(Global.getFloat(context.getContentResolver(), "animator_duration_scale", this.mAnimatorDurationScaleSetting));
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.app.action.DEVICE_POLICY_MANAGER_STATE_CHANGED");
        this.mContext.registerReceiver(this.mBroadcastReceiver, filter);
        this.mSettingsObserver = new SettingsObserver();
        updateShowImeWithHardKeyboard();
        this.mHoldingScreenWakeLock = this.mPowerManager.newWakeLock(536870922, TAG);
        this.mHoldingScreenWakeLock.setReferenceCounted(SHOW_TRANSACTIONS);
        this.mAnimator = new WindowAnimator(this);
        this.mAllowTheaterModeWakeFromLayout = context.getResources().getBoolean(17956912);
        LocalServices.addService(WindowManagerInternal.class, new LocalService());
        initPolicy();
        Watchdog.getInstance().addMonitor(this);
        SurfaceControl.openTransaction();
        try {
            createWatermarkInTransaction();
            this.mFocusedStackFrame = new FocusedStackFrame(getDefaultDisplayContentLocked().getDisplay(), this.mFxSession);
            updateCircularDisplayMaskIfNeeded();
            showEmulatorDisplayOverlayIfNeeded();
        } finally {
            SurfaceControl.closeTransaction();
        }
    }

    public InputMonitor getInputMonitor() {
        return this.mInputMonitor;
    }

    public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
        try {
            return super.onTransact(code, data, reply, flags);
        } catch (RuntimeException e) {
            if (!(e instanceof SecurityException)) {
                Slog.wtf(TAG, "Window Manager Crash", e);
            }
            throw e;
        }
    }

    private void placeWindowAfter(WindowState pos, WindowState window) {
        WindowList windows = pos.getWindowList();
        int i = windows.indexOf(pos);
        Slog.v(TAG, "Adding window " + window + " at " + (i + WALLPAPER_DRAW_PENDING) + " of " + windows.size() + " (after " + pos + ")");
        windows.add(i + WALLPAPER_DRAW_PENDING, window);
        this.mWindowsChanged = HIDE_STACK_CRAWLS;
    }

    private void placeWindowBefore(WindowState pos, WindowState window) {
        WindowList windows = pos.getWindowList();
        int i = windows.indexOf(pos);
        Slog.v(TAG, "Adding window " + window + " at " + i + " of " + windows.size() + " (before " + pos + ")");
        if (i < 0) {
            Slog.w(TAG, "placeWindowBefore: Unable to find " + pos + " in " + windows);
            i = WALLPAPER_DRAW_NORMAL;
        }
        windows.add(i, window);
        this.mWindowsChanged = HIDE_STACK_CRAWLS;
    }

    private int findIdxBasedOnAppTokens(WindowState win) {
        WindowList windows = win.getWindowList();
        for (int j = windows.size() - 1; j >= 0; j--) {
            if (((WindowState) windows.get(j)).mAppToken == win.mAppToken) {
                return j;
            }
        }
        return -1;
    }

    WindowList getTokenWindowsOnDisplay(WindowToken token, DisplayContent displayContent) {
        WindowList windowList = new WindowList();
        int count = token.windows.size();
        for (int i = WALLPAPER_DRAW_NORMAL; i < count; i += WALLPAPER_DRAW_PENDING) {
            WindowState win = (WindowState) token.windows.get(i);
            if (win.getDisplayContent() == displayContent) {
                windowList.add(win);
            }
        }
        return windowList;
    }

    private int indexOfWinInWindowList(WindowState targetWin, WindowList windows) {
        for (int i = windows.size() - 1; i >= 0; i--) {
            WindowState w = (WindowState) windows.get(i);
            if (w == targetWin) {
                return i;
            }
            if (!w.mChildWindows.isEmpty() && indexOfWinInWindowList(targetWin, w.mChildWindows) >= 0) {
                return i;
            }
        }
        return -1;
    }

    private int addAppWindowToListLocked(WindowState win) {
        IWindow client = win.mClient;
        WindowToken token = win.mToken;
        DisplayContent displayContent = win.getDisplayContent();
        if (displayContent == null) {
            return WALLPAPER_DRAW_NORMAL;
        }
        WindowList windows = win.getWindowList();
        int N = windows.size();
        WindowList tokenWindowList = getTokenWindowsOnDisplay(token, displayContent);
        int windowListPos = tokenWindowList.size();
        if (tokenWindowList.isEmpty()) {
            AppTokenList tokens;
            WindowState pos = null;
            ArrayList<Task> tasks = displayContent.getTasks();
            int tokenNdx = -1;
            int taskNdx = tasks.size() - 1;
            while (taskNdx >= 0) {
                tokens = ((Task) tasks.get(taskNdx)).mAppTokens;
                tokenNdx = tokens.size() - 1;
                while (tokenNdx >= 0) {
                    WindowToken t = (AppWindowToken) tokens.get(tokenNdx);
                    if (t == token) {
                        tokenNdx--;
                        if (tokenNdx < 0) {
                            taskNdx--;
                            if (taskNdx >= 0) {
                                tokenNdx = ((Task) tasks.get(taskNdx)).mAppTokens.size() - 1;
                            }
                        }
                        if (tokenNdx >= 0) {
                            break;
                        }
                        taskNdx--;
                    } else {
                        tokenWindowList = getTokenWindowsOnDisplay(t, displayContent);
                        if (!t.sendingToBottom && tokenWindowList.size() > 0) {
                            pos = (WindowState) tokenWindowList.get(WALLPAPER_DRAW_NORMAL);
                        }
                        tokenNdx--;
                    }
                }
                if (tokenNdx >= 0) {
                    break;
                }
                taskNdx--;
            }
            WindowToken atoken;
            if (pos != null) {
                atoken = (WindowToken) this.mTokenMap.get(pos.mClient.asBinder());
                if (atoken != null) {
                    tokenWindowList = getTokenWindowsOnDisplay(atoken, displayContent);
                    if (tokenWindowList.size() > 0) {
                        WindowState bottom = (WindowState) tokenWindowList.get(WALLPAPER_DRAW_NORMAL);
                        if (bottom.mSubLayer < 0) {
                            pos = bottom;
                        }
                    }
                }
                placeWindowBefore(pos, win);
                return WALLPAPER_DRAW_NORMAL;
            }
            for (taskNdx = 
            /* Method generation error in method: com.android.server.wm.WindowManagerService.addAppWindowToListLocked(com.android.server.wm.WindowState):int
jadx.core.utils.exceptions.CodegenException: Error generate insn: PHI: (r17_5 'taskNdx' int) = (r17_3 'taskNdx' int), (r17_1 'taskNdx' int) binds: {(r17_3 'taskNdx' int)=B:71:0x0159, (r17_1 'taskNdx' int)=B:70:0x0159} in method: com.android.server.wm.WindowManagerService.addAppWindowToListLocked(com.android.server.wm.WindowState):int
	at jadx.core.codegen.InsnGen.makeInsn(InsnGen.java:225)
	at jadx.core.codegen.RegionGen.makeLoop(RegionGen.java:184)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:61)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeRegionIndent(RegionGen.java:93)
	at jadx.core.codegen.RegionGen.makeIf(RegionGen.java:118)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:57)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.MethodGen.addInstructions(MethodGen.java:177)
	at jadx.core.codegen.ClassGen.addMethod(ClassGen.java:324)
	at jadx.core.codegen.ClassGen.addMethods(ClassGen.java:263)
	at jadx.core.codegen.ClassGen.addClassBody(ClassGen.java:226)
	at jadx.core.codegen.ClassGen.addClassCode(ClassGen.java:116)
	at jadx.core.codegen.ClassGen.makeClass(ClassGen.java:81)
	at jadx.core.codegen.CodeGen.visit(CodeGen.java:19)
	at jadx.core.ProcessClass.process(ProcessClass.java:43)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
Caused by: jadx.core.utils.exceptions.CodegenException: Unknown instruction: PHI in method: com.android.server.wm.WindowManagerService.addAppWindowToListLocked(com.android.server.wm.WindowState):int
	at jadx.core.codegen.InsnGen.makeInsnBody(InsnGen.java:512)
	at jadx.core.codegen.InsnGen.makeInsn(InsnGen.java:219)
	... 30 more
 */

            private void addFreeWindowToListLocked(WindowState win) {
                WindowList windows = win.getWindowList();
                int myLayer = win.mBaseLayer;
                int i = windows.size() - 1;
                while (i >= 0 && ((WindowState) windows.get(i)).mBaseLayer > myLayer) {
                    i--;
                }
                windows.add(i + WALLPAPER_DRAW_PENDING, win);
                this.mWindowsChanged = HIDE_STACK_CRAWLS;
            }

            private void addAttachedWindowToListLocked(WindowState win, boolean addToToken) {
                WindowToken token = win.mToken;
                DisplayContent displayContent = win.getDisplayContent();
                if (displayContent != null) {
                    int i;
                    WindowState attached = win.mAttachedWindow;
                    WindowList tokenWindowList = getTokenWindowsOnDisplay(token, displayContent);
                    int NA = tokenWindowList.size();
                    int sublayer = win.mSubLayer;
                    int largestSublayer = SoundTriggerHelper.STATUS_ERROR;
                    WindowState windowWithLargestSublayer = null;
                    for (i = WALLPAPER_DRAW_NORMAL; i < NA; i += WALLPAPER_DRAW_PENDING) {
                        WindowState w = (WindowState) tokenWindowList.get(i);
                        int wSublayer = w.mSubLayer;
                        if (wSublayer >= largestSublayer) {
                            largestSublayer = wSublayer;
                            windowWithLargestSublayer = w;
                        }
                        if (sublayer < 0) {
                            if (wSublayer >= sublayer) {
                                if (addToToken) {
                                    token.windows.add(i, win);
                                }
                                if (wSublayer >= 0) {
                                    w = attached;
                                }
                                placeWindowBefore(w, win);
                                if (i < NA) {
                                    if (addToToken) {
                                        token.windows.add(win);
                                    }
                                    if (sublayer < 0) {
                                        placeWindowBefore(attached, win);
                                        return;
                                    }
                                    if (largestSublayer < 0) {
                                        windowWithLargestSublayer = attached;
                                    }
                                    placeWindowAfter(windowWithLargestSublayer, win);
                                }
                            }
                        } else if (wSublayer > sublayer) {
                            if (addToToken) {
                                token.windows.add(i, win);
                            }
                            placeWindowBefore(w, win);
                            if (i < NA) {
                                if (addToToken) {
                                    token.windows.add(win);
                                }
                                if (sublayer < 0) {
                                    if (largestSublayer < 0) {
                                        windowWithLargestSublayer = attached;
                                    }
                                    placeWindowAfter(windowWithLargestSublayer, win);
                                }
                                placeWindowBefore(attached, win);
                                return;
                            }
                        }
                    }
                    if (i < NA) {
                        if (addToToken) {
                            token.windows.add(win);
                        }
                        if (sublayer < 0) {
                            placeWindowBefore(attached, win);
                            return;
                        }
                        if (largestSublayer < 0) {
                            windowWithLargestSublayer = attached;
                        }
                        placeWindowAfter(windowWithLargestSublayer, win);
                    }
                }
            }

            private void addWindowToListInOrderLocked(WindowState win, boolean addToToken) {
                if (win.mAttachedWindow == null) {
                    WindowToken token = win.mToken;
                    int tokenWindowsPos = WALLPAPER_DRAW_NORMAL;
                    if (token.appWindowToken != null) {
                        tokenWindowsPos = addAppWindowToListLocked(win);
                    } else {
                        addFreeWindowToListLocked(win);
                    }
                    if (addToToken) {
                        token.windows.add(tokenWindowsPos, win);
                    }
                } else {
                    addAttachedWindowToListLocked(win, addToToken);
                }
                if (win.mAppToken != null && addToToken) {
                    win.mAppToken.allAppWindows.add(win);
                }
            }

            static boolean canBeImeTarget(WindowState w) {
                int fl = w.mAttrs.flags & 131080;
                if (fl == 0 || fl == 131080 || w.mAttrs.type == UPDATE_FOCUS_WILL_PLACE_SURFACES) {
                    return w.isVisibleOrAdding();
                }
                return SHOW_TRANSACTIONS;
            }

            int findDesiredInputMethodWindowIndexLocked(boolean willMove) {
                WindowState curTarget;
                int highestPos;
                int pos;
                WindowList windows = getDefaultWindowListLocked();
                WindowState w = null;
                int i = windows.size() - 1;
                while (i >= 0) {
                    WindowState win = (WindowState) windows.get(i);
                    AppWindowToken token;
                    WindowState highestTarget;
                    WindowList curWindows;
                    if (canBeImeTarget(win)) {
                        w = win;
                        if (!willMove && w.mAttrs.type == UPDATE_FOCUS_WILL_PLACE_SURFACES && i > 0) {
                            WindowState wb = (WindowState) windows.get(i - 1);
                            if (wb.mAppToken == w.mAppToken && canBeImeTarget(wb)) {
                                i--;
                                w = wb;
                            }
                        }
                        curTarget = this.mInputMethodTarget;
                        if (curTarget == null && curTarget.isDisplayedLw() && curTarget.isClosing() && (w == null || curTarget.mWinAnimator.mAnimLayer > w.mWinAnimator.mAnimLayer)) {
                            return windows.indexOf(curTarget) + WALLPAPER_DRAW_PENDING;
                        }
                        if (willMove && w != null) {
                            token = curTarget != null ? null : curTarget.mAppToken;
                            if (token != null) {
                                highestTarget = null;
                                highestPos = WALLPAPER_DRAW_NORMAL;
                                if (token.mAppAnimator.animating || token.mAppAnimator.animation != null) {
                                    curWindows = curTarget.getWindowList();
                                    for (pos = curWindows.indexOf(curTarget); pos >= 0; pos--) {
                                        win = (WindowState) curWindows.get(pos);
                                        if (win.mAppToken == token) {
                                            break;
                                        }
                                        if (!win.mRemoved && (highestTarget == null || win.mWinAnimator.mAnimLayer > highestTarget.mWinAnimator.mAnimLayer)) {
                                            highestTarget = win;
                                            highestPos = pos;
                                        }
                                    }
                                }
                                if (highestTarget != null) {
                                    if (this.mAppTransition.isTransitionSet()) {
                                        this.mInputMethodTargetWaitingAnim = HIDE_STACK_CRAWLS;
                                        this.mInputMethodTarget = highestTarget;
                                        return highestPos + WALLPAPER_DRAW_PENDING;
                                    } else if (highestTarget.mWinAnimator.isAnimating() && highestTarget.mWinAnimator.mAnimLayer > w.mWinAnimator.mAnimLayer) {
                                        this.mInputMethodTargetWaitingAnim = HIDE_STACK_CRAWLS;
                                        this.mInputMethodTarget = highestTarget;
                                        return highestPos + WALLPAPER_DRAW_PENDING;
                                    }
                                }
                            }
                        }
                        if (w == null) {
                            if (willMove) {
                                this.mInputMethodTarget = w;
                                this.mInputMethodTargetWaitingAnim = SHOW_TRANSACTIONS;
                                if (w.mAppToken == null) {
                                    setInputMethodAnimLayerAdjustment(w.mAppToken.mAppAnimator.animLayerAdjustment);
                                } else {
                                    setInputMethodAnimLayerAdjustment(WALLPAPER_DRAW_NORMAL);
                                }
                            }
                            return i + WALLPAPER_DRAW_PENDING;
                        }
                        if (willMove) {
                            this.mInputMethodTarget = null;
                            setInputMethodAnimLayerAdjustment(WALLPAPER_DRAW_NORMAL);
                        }
                        return -1;
                    }
                    i--;
                }
                curTarget = this.mInputMethodTarget;
                if (curTarget == null) {
                }
                if (curTarget != null) {
                }
                if (token != null) {
                    highestTarget = null;
                    highestPos = WALLPAPER_DRAW_NORMAL;
                    curWindows = curTarget.getWindowList();
                    while (pos >= 0) {
                        win = (WindowState) curWindows.get(pos);
                        if (win.mAppToken == token) {
                            highestTarget = win;
                            highestPos = pos;
                        } else {
                            break;
                            if (highestTarget != null) {
                                if (this.mAppTransition.isTransitionSet()) {
                                    this.mInputMethodTargetWaitingAnim = HIDE_STACK_CRAWLS;
                                    this.mInputMethodTarget = highestTarget;
                                    return highestPos + WALLPAPER_DRAW_PENDING;
                                }
                                this.mInputMethodTargetWaitingAnim = HIDE_STACK_CRAWLS;
                                this.mInputMethodTarget = highestTarget;
                                return highestPos + WALLPAPER_DRAW_PENDING;
                            }
                        }
                    }
                    if (highestTarget != null) {
                        if (this.mAppTransition.isTransitionSet()) {
                            this.mInputMethodTargetWaitingAnim = HIDE_STACK_CRAWLS;
                            this.mInputMethodTarget = highestTarget;
                            return highestPos + WALLPAPER_DRAW_PENDING;
                        }
                        this.mInputMethodTargetWaitingAnim = HIDE_STACK_CRAWLS;
                        this.mInputMethodTarget = highestTarget;
                        return highestPos + WALLPAPER_DRAW_PENDING;
                    }
                }
                if (w == null) {
                    if (willMove) {
                        this.mInputMethodTarget = null;
                        setInputMethodAnimLayerAdjustment(WALLPAPER_DRAW_NORMAL);
                    }
                    return -1;
                }
                if (willMove) {
                    this.mInputMethodTarget = w;
                    this.mInputMethodTargetWaitingAnim = SHOW_TRANSACTIONS;
                    if (w.mAppToken == null) {
                        setInputMethodAnimLayerAdjustment(WALLPAPER_DRAW_NORMAL);
                    } else {
                        setInputMethodAnimLayerAdjustment(w.mAppToken.mAppAnimator.animLayerAdjustment);
                    }
                }
                return i + WALLPAPER_DRAW_PENDING;
            }

            void addInputMethodWindowToListLocked(WindowState win) {
                int pos = findDesiredInputMethodWindowIndexLocked(HIDE_STACK_CRAWLS);
                if (pos >= 0) {
                    win.mTargetAppToken = this.mInputMethodTarget.mAppToken;
                    getDefaultWindowListLocked().add(pos, win);
                    this.mWindowsChanged = HIDE_STACK_CRAWLS;
                    moveInputMethodDialogsLocked(pos + WALLPAPER_DRAW_PENDING);
                    return;
                }
                win.mTargetAppToken = null;
                addWindowToListInOrderLocked(win, HIDE_STACK_CRAWLS);
                moveInputMethodDialogsLocked(pos);
            }

            void setInputMethodAnimLayerAdjustment(int adj) {
                this.mInputMethodAnimLayerAdjustment = adj;
                WindowState imw = this.mInputMethodWindow;
                if (imw != null) {
                    imw.mWinAnimator.mAnimLayer = imw.mLayer + adj;
                    int wi = imw.mChildWindows.size();
                    while (wi > 0) {
                        wi--;
                        WindowState cw = (WindowState) imw.mChildWindows.get(wi);
                        cw.mWinAnimator.mAnimLayer = cw.mLayer + adj;
                    }
                }
                int di = this.mInputMethodDialogs.size();
                while (di > 0) {
                    di--;
                    imw = (WindowState) this.mInputMethodDialogs.get(di);
                    imw.mWinAnimator.mAnimLayer = imw.mLayer + adj;
                }
            }

            private int tmpRemoveWindowLocked(int interestingPos, WindowState win) {
                WindowList windows = win.getWindowList();
                int wpos = windows.indexOf(win);
                if (wpos >= 0) {
                    if (wpos < interestingPos) {
                        interestingPos--;
                    }
                    windows.remove(wpos);
                    this.mWindowsChanged = HIDE_STACK_CRAWLS;
                    int NC = win.mChildWindows.size();
                    while (NC > 0) {
                        NC--;
                        int cpos = windows.indexOf((WindowState) win.mChildWindows.get(NC));
                        if (cpos >= 0) {
                            if (cpos < interestingPos) {
                                interestingPos--;
                            }
                            windows.remove(cpos);
                        }
                    }
                }
                return interestingPos;
            }

            private void reAddWindowToListInOrderLocked(WindowState win) {
                addWindowToListInOrderLocked(win, SHOW_TRANSACTIONS);
                WindowList windows = win.getWindowList();
                int wpos = windows.indexOf(win);
                if (wpos >= 0) {
                    windows.remove(wpos);
                    this.mWindowsChanged = HIDE_STACK_CRAWLS;
                    reAddWindowLocked(wpos, win);
                }
            }

            void logWindowList(WindowList windows, String prefix) {
                int N = windows.size();
                while (N > 0) {
                    N--;
                    Slog.v(TAG, prefix + "#" + N + ": " + windows.get(N));
                }
            }

            void moveInputMethodDialogsLocked(int pos) {
                int i;
                ArrayList<WindowState> dialogs = this.mInputMethodDialogs;
                WindowList windows = getDefaultWindowListLocked();
                int N = dialogs.size();
                for (i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                    pos = tmpRemoveWindowLocked(pos, (WindowState) dialogs.get(i));
                }
                if (pos >= 0) {
                    AppWindowToken targetAppToken = this.mInputMethodTarget.mAppToken;
                    if (this.mInputMethodWindow != null) {
                        while (pos < windows.size()) {
                            WindowState wp = (WindowState) windows.get(pos);
                            if (wp != this.mInputMethodWindow && wp.mAttachedWindow != this.mInputMethodWindow) {
                                break;
                            }
                            pos += WALLPAPER_DRAW_PENDING;
                        }
                    }
                    for (i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                        WindowState win = (WindowState) dialogs.get(i);
                        win.mTargetAppToken = targetAppToken;
                        pos = reAddWindowLocked(pos, win);
                    }
                    return;
                }
                for (i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                    win = (WindowState) dialogs.get(i);
                    win.mTargetAppToken = null;
                    reAddWindowToListInOrderLocked(win);
                }
            }

            boolean moveInputMethodWindowsIfNeededLocked(boolean needAssignLayers) {
                WindowState firstImWin = null;
                WindowState imWin = this.mInputMethodWindow;
                int DN = this.mInputMethodDialogs.size();
                if (imWin == null && DN == 0) {
                    return SHOW_TRANSACTIONS;
                }
                WindowList windows = getDefaultWindowListLocked();
                int imPos = findDesiredInputMethodWindowIndexLocked(HIDE_STACK_CRAWLS);
                if (imPos >= 0) {
                    WindowState baseImWin;
                    int N = windows.size();
                    if (imPos < N) {
                        firstImWin = (WindowState) windows.get(imPos);
                    }
                    if (imWin != null) {
                        baseImWin = imWin;
                    } else {
                        baseImWin = (WindowState) this.mInputMethodDialogs.get(WALLPAPER_DRAW_NORMAL);
                    }
                    if (baseImWin.mChildWindows.size() > 0) {
                        WindowState cw = (WindowState) baseImWin.mChildWindows.get(WALLPAPER_DRAW_NORMAL);
                        if (cw.mSubLayer < 0) {
                            baseImWin = cw;
                        }
                    }
                    if (firstImWin == baseImWin) {
                        int pos = imPos + WALLPAPER_DRAW_PENDING;
                        while (pos < N && ((WindowState) windows.get(pos)).mIsImWindow) {
                            pos += WALLPAPER_DRAW_PENDING;
                        }
                        pos += WALLPAPER_DRAW_PENDING;
                        while (pos < N && !((WindowState) windows.get(pos)).mIsImWindow) {
                            pos += WALLPAPER_DRAW_PENDING;
                        }
                        if (pos >= N) {
                            if (imWin != null) {
                                imWin.mTargetAppToken = this.mInputMethodTarget.mAppToken;
                            }
                            return SHOW_TRANSACTIONS;
                        }
                    }
                    if (imWin != null) {
                        imPos = tmpRemoveWindowLocked(imPos, imWin);
                        imWin.mTargetAppToken = this.mInputMethodTarget.mAppToken;
                        reAddWindowLocked(imPos, imWin);
                        if (DN > 0) {
                            moveInputMethodDialogsLocked(imPos + WALLPAPER_DRAW_PENDING);
                        }
                    } else {
                        moveInputMethodDialogsLocked(imPos);
                    }
                } else if (imWin != null) {
                    tmpRemoveWindowLocked(WALLPAPER_DRAW_NORMAL, imWin);
                    imWin.mTargetAppToken = null;
                    reAddWindowToListInOrderLocked(imWin);
                    if (DN > 0) {
                        moveInputMethodDialogsLocked(-1);
                    }
                } else {
                    moveInputMethodDialogsLocked(-1);
                }
                if (needAssignLayers) {
                    assignLayersLocked(windows);
                }
                return HIDE_STACK_CRAWLS;
            }

            final boolean isWallpaperVisible(WindowState wallpaperTarget) {
                return ((wallpaperTarget == null || (wallpaperTarget.mObscured && (wallpaperTarget.mAppToken == null || wallpaperTarget.mAppToken.mAppAnimator.animation == null))) && this.mUpperWallpaperTarget == null && this.mLowerWallpaperTarget == null) ? SHOW_TRANSACTIONS : HIDE_STACK_CRAWLS;
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            int adjustWallpaperWindowsLocked() {
                /*
                r36 = this;
                r0 = r36;
                r0 = r0.mInnerFields;
                r33 = r0;
                r34 = 0;
                r0 = r34;
                r1 = r33;
                r1.mWallpaperMayChange = r0;
                r22 = 0;
                r33 = r36.getDefaultDisplayContentLocked();
                r8 = r33.getDisplayInfo();
                r9 = r8.logicalWidth;
                r7 = r8.logicalHeight;
                r32 = r36.getDefaultWindowListLocked();
                r3 = r32.size();
                r28 = 0;
                r12 = 0;
                r11 = 0;
                r25 = 0;
                r24 = 0;
                r31 = -1;
                r14 = r3;
            L_0x002f:
                if (r14 <= 0) goto L_0x00f2;
            L_0x0031:
                r14 = r14 + -1;
                r0 = r32;
                r28 = r0.get(r14);
                r28 = (com.android.server.wm.WindowState) r28;
                r0 = r28;
                r0 = r0.mAttrs;
                r33 = r0;
                r0 = r33;
                r0 = r0.type;
                r33 = r0;
                r34 = 2013; // 0x7dd float:2.821E-42 double:9.946E-321;
                r0 = r33;
                r1 = r34;
                if (r0 != r1) goto L_0x0056;
            L_0x004f:
                if (r25 != 0) goto L_0x002f;
            L_0x0051:
                r25 = r28;
                r24 = r14;
                goto L_0x002f;
            L_0x0056:
                r25 = 0;
                r0 = r36;
                r0 = r0.mAnimator;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWindowDetachedWallpaper;
                r33 = r0;
                r0 = r28;
                r1 = r33;
                if (r0 == r1) goto L_0x0094;
            L_0x006a:
                r0 = r28;
                r0 = r0.mAppToken;
                r33 = r0;
                if (r33 == 0) goto L_0x0094;
            L_0x0072:
                r0 = r28;
                r0 = r0.mAppToken;
                r33 = r0;
                r0 = r33;
                r0 = r0.hidden;
                r33 = r0;
                if (r33 == 0) goto L_0x0094;
            L_0x0080:
                r0 = r28;
                r0 = r0.mAppToken;
                r33 = r0;
                r0 = r33;
                r0 = r0.mAppAnimator;
                r33 = r0;
                r0 = r33;
                r0 = r0.animation;
                r33 = r0;
                if (r33 == 0) goto L_0x002f;
            L_0x0094:
                r0 = r28;
                r0 = r0.mAttrs;
                r33 = r0;
                r0 = r33;
                r0 = r0.flags;
                r33 = r0;
                r34 = 1048576; // 0x100000 float:1.469368E-39 double:5.180654E-318;
                r33 = r33 & r34;
                if (r33 != 0) goto L_0x00bc;
            L_0x00a6:
                r0 = r28;
                r0 = r0.mAppToken;
                r33 = r0;
                if (r33 == 0) goto L_0x0370;
            L_0x00ae:
                r0 = r28;
                r0 = r0.mWinAnimator;
                r33 = r0;
                r0 = r33;
                r0 = r0.mKeyguardGoingAwayAnimation;
                r33 = r0;
                if (r33 == 0) goto L_0x0370;
            L_0x00bc:
                r13 = 1;
            L_0x00bd:
                if (r13 == 0) goto L_0x0373;
            L_0x00bf:
                r33 = r28.isOnScreen();
                if (r33 == 0) goto L_0x0373;
            L_0x00c5:
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r1 = r28;
                if (r0 == r1) goto L_0x00d7;
            L_0x00d1:
                r33 = r28.isDrawFinishedLw();
                if (r33 == 0) goto L_0x0373;
            L_0x00d7:
                r12 = r28;
                r11 = r14;
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r28;
                r1 = r33;
                if (r0 != r1) goto L_0x00f2;
            L_0x00e6:
                r0 = r28;
                r0 = r0.mWinAnimator;
                r33 = r0;
                r33 = r33.isAnimating();
                if (r33 != 0) goto L_0x002f;
            L_0x00f2:
                if (r12 != 0) goto L_0x00fa;
            L_0x00f4:
                if (r31 < 0) goto L_0x00fa;
            L_0x00f6:
                r12 = r28;
                r11 = r31;
            L_0x00fa:
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                if (r0 == r12) goto L_0x03a9;
            L_0x0104:
                r0 = r36;
                r0 = r0.mLowerWallpaperTarget;
                r33 = r0;
                if (r33 == 0) goto L_0x0116;
            L_0x010c:
                r0 = r36;
                r0 = r0.mLowerWallpaperTarget;
                r33 = r0;
                r0 = r33;
                if (r0 == r12) goto L_0x03a9;
            L_0x0116:
                r33 = 0;
                r0 = r33;
                r1 = r36;
                r1.mLowerWallpaperTarget = r0;
                r33 = 0;
                r0 = r33;
                r1 = r36;
                r1.mUpperWallpaperTarget = r0;
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r20 = r0;
                r0 = r36;
                r0.mWallpaperTarget = r12;
                r22 = 1;
                if (r12 == 0) goto L_0x0168;
            L_0x0134:
                if (r20 == 0) goto L_0x0168;
            L_0x0136:
                r17 = r20.isAnimatingLw();
                r10 = r12.isAnimatingLw();
                if (r10 == 0) goto L_0x0168;
            L_0x0140:
                if (r17 == 0) goto L_0x0168;
            L_0x0142:
                r0 = r32;
                r1 = r20;
                r18 = r0.indexOf(r1);
                if (r18 < 0) goto L_0x0168;
            L_0x014c:
                r0 = r12.mAppToken;
                r33 = r0;
                if (r33 == 0) goto L_0x0389;
            L_0x0152:
                r0 = r12.mAppToken;
                r33 = r0;
                r0 = r33;
                r0 = r0.hiddenRequested;
                r33 = r0;
                if (r33 == 0) goto L_0x0389;
            L_0x015e:
                r0 = r20;
                r1 = r36;
                r1.mWallpaperTarget = r0;
                r12 = r20;
                r11 = r18;
            L_0x0168:
                if (r12 == 0) goto L_0x03e1;
            L_0x016a:
                r27 = 1;
            L_0x016c:
                if (r27 == 0) goto L_0x020e;
            L_0x016e:
                r0 = r36;
                r27 = r0.isWallpaperVisible(r12);
                r0 = r36;
                r0 = r0.mLowerWallpaperTarget;
                r33 = r0;
                if (r33 != 0) goto L_0x03e5;
            L_0x017c:
                r0 = r12.mAppToken;
                r33 = r0;
                if (r33 == 0) goto L_0x03e5;
            L_0x0182:
                r0 = r12.mAppToken;
                r33 = r0;
                r0 = r33;
                r0 = r0.mAppAnimator;
                r33 = r0;
                r0 = r33;
                r0 = r0.animLayerAdjustment;
                r33 = r0;
            L_0x0192:
                r0 = r33;
                r1 = r36;
                r1.mWallpaperAnimLayerAdjustment = r0;
                r0 = r36;
                r0 = r0.mPolicy;
                r33 = r0;
                r33 = r33.getMaxWallpaperLayer();
                r0 = r33;
                r0 = r0 * 10000;
                r33 = r0;
                r0 = r33;
                r0 = r0 + 1000;
                r16 = r0;
            L_0x01ae:
                if (r11 <= 0) goto L_0x020e;
            L_0x01b0:
                r33 = r11 + -1;
                r30 = r32.get(r33);
                r30 = (com.android.server.wm.WindowState) r30;
                r0 = r30;
                r0 = r0.mBaseLayer;
                r33 = r0;
                r0 = r33;
                r1 = r16;
                if (r0 >= r1) goto L_0x03e9;
            L_0x01c4:
                r0 = r30;
                r0 = r0.mAttachedWindow;
                r33 = r0;
                r0 = r33;
                if (r0 == r12) goto L_0x03e9;
            L_0x01ce:
                r0 = r12.mAttachedWindow;
                r33 = r0;
                if (r33 == 0) goto L_0x01e4;
            L_0x01d4:
                r0 = r30;
                r0 = r0.mAttachedWindow;
                r33 = r0;
                r0 = r12.mAttachedWindow;
                r34 = r0;
                r0 = r33;
                r1 = r34;
                if (r0 == r1) goto L_0x03e9;
            L_0x01e4:
                r0 = r30;
                r0 = r0.mAttrs;
                r33 = r0;
                r0 = r33;
                r0 = r0.type;
                r33 = r0;
                r34 = 3;
                r0 = r33;
                r1 = r34;
                if (r0 != r1) goto L_0x020e;
            L_0x01f8:
                r0 = r12.mToken;
                r33 = r0;
                if (r33 == 0) goto L_0x020e;
            L_0x01fe:
                r0 = r30;
                r0 = r0.mToken;
                r33 = r0;
                r0 = r12.mToken;
                r34 = r0;
                r0 = r33;
                r1 = r34;
                if (r0 == r1) goto L_0x03e9;
            L_0x020e:
                if (r12 != 0) goto L_0x03ef;
            L_0x0210:
                if (r25 == 0) goto L_0x03ef;
            L_0x0212:
                r12 = r25;
                r11 = r24 + 1;
            L_0x0216:
                if (r27 == 0) goto L_0x02d0;
            L_0x0218:
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWallpaperX;
                r33 = r0;
                r34 = 0;
                r33 = (r33 > r34 ? 1 : (r33 == r34 ? 0 : -1));
                if (r33 < 0) goto L_0x024e;
            L_0x022a:
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWallpaperX;
                r33 = r0;
                r0 = r33;
                r1 = r36;
                r1.mLastWallpaperX = r0;
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWallpaperXStep;
                r33 = r0;
                r0 = r33;
                r1 = r36;
                r1.mLastWallpaperXStep = r0;
            L_0x024e:
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWallpaperY;
                r33 = r0;
                r34 = 0;
                r33 = (r33 > r34 ? 1 : (r33 == r34 ? 0 : -1));
                if (r33 < 0) goto L_0x0284;
            L_0x0260:
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWallpaperY;
                r33 = r0;
                r0 = r33;
                r1 = r36;
                r1.mLastWallpaperY = r0;
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWallpaperYStep;
                r33 = r0;
                r0 = r33;
                r1 = r36;
                r1.mLastWallpaperYStep = r0;
            L_0x0284:
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWallpaperDisplayOffsetX;
                r33 = r0;
                r34 = -2147483648; // 0xffffffff80000000 float:-0.0 double:NaN;
                r0 = r33;
                r1 = r34;
                if (r0 == r1) goto L_0x02aa;
            L_0x0298:
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWallpaperDisplayOffsetX;
                r33 = r0;
                r0 = r33;
                r1 = r36;
                r1.mLastWallpaperDisplayOffsetX = r0;
            L_0x02aa:
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWallpaperDisplayOffsetY;
                r33 = r0;
                r34 = -2147483648; // 0xffffffff80000000 float:-0.0 double:NaN;
                r0 = r33;
                r1 = r34;
                if (r0 == r1) goto L_0x02d0;
            L_0x02be:
                r0 = r36;
                r0 = r0.mWallpaperTarget;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWallpaperDisplayOffsetY;
                r33 = r0;
                r0 = r33;
                r1 = r36;
                r1.mLastWallpaperDisplayOffsetY = r0;
            L_0x02d0:
                r4 = 0;
                r0 = r36;
                r0 = r0.mWallpaperTokens;
                r33 = r0;
                r5 = r33.size();
            L_0x02db:
                if (r5 <= 0) goto L_0x0467;
            L_0x02dd:
                r5 = r5 + -1;
                r0 = r36;
                r0 = r0.mWallpaperTokens;
                r33 = r0;
                r0 = r33;
                r23 = r0.get(r5);
                r23 = (com.android.server.wm.WindowToken) r23;
                r0 = r23;
                r0 = r0.hidden;
                r33 = r0;
                r0 = r33;
                r1 = r27;
                if (r0 != r1) goto L_0x0311;
            L_0x02f9:
                r4 = r4 | 4;
                if (r27 != 0) goto L_0x03ff;
            L_0x02fd:
                r33 = 1;
            L_0x02ff:
                r0 = r33;
                r1 = r23;
                r1.hidden = r0;
                r33 = r36.getDefaultDisplayContentLocked();
                r34 = 1;
                r0 = r34;
                r1 = r33;
                r1.layoutNeeded = r0;
            L_0x0311:
                r0 = r23;
                r0 = r0.windows;
                r33 = r0;
                r6 = r33.size();
            L_0x031b:
                if (r6 <= 0) goto L_0x02db;
            L_0x031d:
                r6 = r6 + -1;
                r0 = r23;
                r0 = r0.windows;
                r33 = r0;
                r0 = r33;
                r29 = r0.get(r6);
                r29 = (com.android.server.wm.WindowState) r29;
                if (r27 == 0) goto L_0x033a;
            L_0x032f:
                r33 = 0;
                r0 = r36;
                r1 = r29;
                r2 = r33;
                r0.updateWallpaperOffsetLocked(r1, r9, r7, r2);
            L_0x033a:
                r0 = r36;
                r1 = r29;
                r2 = r27;
                r0.dispatchWallpaperVisibility(r1, r2);
                r0 = r29;
                r0 = r0.mWinAnimator;
                r33 = r0;
                r0 = r29;
                r0 = r0.mLayer;
                r34 = r0;
                r0 = r36;
                r0 = r0.mWallpaperAnimLayerAdjustment;
                r35 = r0;
                r34 = r34 + r35;
                r0 = r34;
                r1 = r33;
                r1.mAnimLayer = r0;
                r0 = r29;
                if (r0 != r12) goto L_0x0406;
            L_0x0361:
                r11 = r11 + -1;
                if (r11 <= 0) goto L_0x0403;
            L_0x0365:
                r33 = r11 + -1;
                r33 = r32.get(r33);
                r33 = (com.android.server.wm.WindowState) r33;
                r12 = r33;
            L_0x036f:
                goto L_0x031b;
            L_0x0370:
                r13 = 0;
                goto L_0x00bd;
            L_0x0373:
                r0 = r36;
                r0 = r0.mAnimator;
                r33 = r0;
                r0 = r33;
                r0 = r0.mWindowDetachedWallpaper;
                r33 = r0;
                r0 = r28;
                r1 = r33;
                if (r0 != r1) goto L_0x002f;
            L_0x0385:
                r31 = r14;
                goto L_0x002f;
            L_0x0389:
                r0 = r18;
                if (r11 <= r0) goto L_0x039d;
            L_0x038d:
                r0 = r36;
                r0.mUpperWallpaperTarget = r12;
                r0 = r20;
                r1 = r36;
                r1.mLowerWallpaperTarget = r0;
                r12 = r20;
                r11 = r18;
                goto L_0x0168;
            L_0x039d:
                r0 = r20;
                r1 = r36;
                r1.mUpperWallpaperTarget = r0;
                r0 = r36;
                r0.mLowerWallpaperTarget = r12;
                goto L_0x0168;
            L_0x03a9:
                r0 = r36;
                r0 = r0.mLowerWallpaperTarget;
                r33 = r0;
                if (r33 == 0) goto L_0x0168;
            L_0x03b1:
                r0 = r36;
                r0 = r0.mLowerWallpaperTarget;
                r33 = r0;
                r33 = r33.isAnimatingLw();
                if (r33 == 0) goto L_0x03c9;
            L_0x03bd:
                r0 = r36;
                r0 = r0.mUpperWallpaperTarget;
                r33 = r0;
                r33 = r33.isAnimatingLw();
                if (r33 != 0) goto L_0x0168;
            L_0x03c9:
                r33 = 0;
                r0 = r33;
                r1 = r36;
                r1.mLowerWallpaperTarget = r0;
                r33 = 0;
                r0 = r33;
                r1 = r36;
                r1.mUpperWallpaperTarget = r0;
                r0 = r36;
                r0.mWallpaperTarget = r12;
                r22 = 1;
                goto L_0x0168;
            L_0x03e1:
                r27 = 0;
                goto L_0x016c;
            L_0x03e5:
                r33 = 0;
                goto L_0x0192;
            L_0x03e9:
                r12 = r30;
                r11 = r11 + -1;
                goto L_0x01ae;
            L_0x03ef:
                if (r11 <= 0) goto L_0x03fd;
            L_0x03f1:
                r33 = r11 + -1;
                r33 = r32.get(r33);
                r33 = (com.android.server.wm.WindowState) r33;
                r12 = r33;
            L_0x03fb:
                goto L_0x0216;
            L_0x03fd:
                r12 = 0;
                goto L_0x03fb;
            L_0x03ff:
                r33 = 0;
                goto L_0x02ff;
            L_0x0403:
                r12 = 0;
                goto L_0x036f;
            L_0x0406:
                r0 = r32;
                r1 = r29;
                r19 = r0.indexOf(r1);
                if (r19 < 0) goto L_0x0425;
            L_0x0410:
                r0 = r32;
                r1 = r19;
                r0.remove(r1);
                r33 = 1;
                r0 = r33;
                r1 = r36;
                r1.mWindowsChanged = r0;
                r0 = r19;
                if (r0 >= r11) goto L_0x0425;
            L_0x0423:
                r11 = r11 + -1;
            L_0x0425:
                r15 = 0;
                if (r27 == 0) goto L_0x0454;
            L_0x0428:
                if (r12 == 0) goto L_0x0454;
            L_0x042a:
                r0 = r12.mAttrs;
                r33 = r0;
                r0 = r33;
                r0 = r0.type;
                r26 = r0;
                r0 = r12.mAttrs;
                r33 = r0;
                r0 = r33;
                r0 = r0.privateFlags;
                r21 = r0;
                r0 = r21;
                r0 = r0 & 1024;
                r33 = r0;
                if (r33 != 0) goto L_0x044e;
            L_0x0446:
                r33 = 2029; // 0x7ed float:2.843E-42 double:1.0025E-320;
                r0 = r26;
                r1 = r33;
                if (r0 != r1) goto L_0x0454;
            L_0x044e:
                r0 = r32;
                r15 = r0.indexOf(r12);
            L_0x0454:
                r0 = r32;
                r1 = r29;
                r0.add(r15, r1);
                r33 = 1;
                r0 = r33;
                r1 = r36;
                r1.mWindowsChanged = r0;
                r4 = r4 | 2;
                goto L_0x031b;
            L_0x0467:
                if (r22 == 0) goto L_0x0469;
            L_0x0469:
                return r4;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.adjustWallpaperWindowsLocked():int");
            }

            void setWallpaperAnimLayerAdjustmentLocked(int adj) {
                this.mWallpaperAnimLayerAdjustment = adj;
                int curTokenIndex = this.mWallpaperTokens.size();
                while (curTokenIndex > 0) {
                    curTokenIndex--;
                    WindowToken token = (WindowToken) this.mWallpaperTokens.get(curTokenIndex);
                    int curWallpaperIndex = token.windows.size();
                    while (curWallpaperIndex > 0) {
                        curWallpaperIndex--;
                        WindowState wallpaper = (WindowState) token.windows.get(curWallpaperIndex);
                        wallpaper.mWinAnimator.mAnimLayer = wallpaper.mLayer + adj;
                    }
                }
            }

            boolean updateWallpaperOffsetLocked(WindowState wallpaperWin, int dw, int dh, boolean sync) {
                boolean rawChanged = SHOW_TRANSACTIONS;
                float wpx = this.mLastWallpaperX >= 0.0f ? this.mLastWallpaperX : 0.5f;
                float wpxs = this.mLastWallpaperXStep >= 0.0f ? this.mLastWallpaperXStep : -1.0f;
                int availw = (wallpaperWin.mFrame.right - wallpaperWin.mFrame.left) - dw;
                int offset = availw > 0 ? -((int) ((((float) availw) * wpx) + 0.5f)) : WALLPAPER_DRAW_NORMAL;
                if (this.mLastWallpaperDisplayOffsetX != SoundTriggerHelper.STATUS_ERROR) {
                    offset += this.mLastWallpaperDisplayOffsetX;
                }
                boolean changed = wallpaperWin.mXOffset != offset ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                if (changed) {
                    wallpaperWin.mXOffset = offset;
                }
                if (!(wallpaperWin.mWallpaperX == wpx && wallpaperWin.mWallpaperXStep == wpxs)) {
                    wallpaperWin.mWallpaperX = wpx;
                    wallpaperWin.mWallpaperXStep = wpxs;
                    rawChanged = HIDE_STACK_CRAWLS;
                }
                float wpy = this.mLastWallpaperY >= 0.0f ? this.mLastWallpaperY : 0.5f;
                float wpys = this.mLastWallpaperYStep >= 0.0f ? this.mLastWallpaperYStep : -1.0f;
                int availh = (wallpaperWin.mFrame.bottom - wallpaperWin.mFrame.top) - dh;
                offset = availh > 0 ? -((int) ((((float) availh) * wpy) + 0.5f)) : WALLPAPER_DRAW_NORMAL;
                if (this.mLastWallpaperDisplayOffsetY != SoundTriggerHelper.STATUS_ERROR) {
                    offset += this.mLastWallpaperDisplayOffsetY;
                }
                if (wallpaperWin.mYOffset != offset) {
                    changed = HIDE_STACK_CRAWLS;
                    wallpaperWin.mYOffset = offset;
                }
                if (!(wallpaperWin.mWallpaperY == wpy && wallpaperWin.mWallpaperYStep == wpys)) {
                    wallpaperWin.mWallpaperY = wpy;
                    wallpaperWin.mWallpaperYStep = wpys;
                    rawChanged = HIDE_STACK_CRAWLS;
                }
                if (rawChanged && (wallpaperWin.mAttrs.privateFlags & LAYOUT_REPEAT_THRESHOLD) != 0) {
                    if (sync) {
                        try {
                            this.mWaitingOnWallpaper = wallpaperWin;
                        } catch (RemoteException e) {
                        }
                    }
                    wallpaperWin.mClient.dispatchWallpaperOffsets(wallpaperWin.mWallpaperX, wallpaperWin.mWallpaperY, wallpaperWin.mWallpaperXStep, wallpaperWin.mWallpaperYStep, sync);
                    if (sync && this.mWaitingOnWallpaper != null) {
                        long start = SystemClock.uptimeMillis();
                        if (this.mLastWallpaperTimeoutTime + WALLPAPER_TIMEOUT_RECOVERY < start) {
                            try {
                                this.mWindowMap.wait(WALLPAPER_TIMEOUT);
                            } catch (InterruptedException e2) {
                            }
                            if (WALLPAPER_TIMEOUT + start < SystemClock.uptimeMillis()) {
                                Slog.i(TAG, "Timeout waiting for wallpaper to offset: " + wallpaperWin);
                                this.mLastWallpaperTimeoutTime = start;
                            }
                        }
                        this.mWaitingOnWallpaper = null;
                    }
                }
                return changed;
            }

            void wallpaperOffsetsComplete(IBinder window) {
                synchronized (this.mWindowMap) {
                    if (this.mWaitingOnWallpaper != null && this.mWaitingOnWallpaper.mClient.asBinder() == window) {
                        this.mWaitingOnWallpaper = null;
                        this.mWindowMap.notifyAll();
                    }
                }
            }

            void updateWallpaperOffsetLocked(WindowState changingTarget, boolean sync) {
                DisplayContent displayContent = changingTarget.getDisplayContent();
                if (displayContent != null) {
                    DisplayInfo displayInfo = displayContent.getDisplayInfo();
                    int dw = displayInfo.logicalWidth;
                    int dh = displayInfo.logicalHeight;
                    WindowState target = this.mWallpaperTarget;
                    if (target != null) {
                        if (target.mWallpaperX >= 0.0f) {
                            this.mLastWallpaperX = target.mWallpaperX;
                        } else if (changingTarget.mWallpaperX >= 0.0f) {
                            this.mLastWallpaperX = changingTarget.mWallpaperX;
                        }
                        if (target.mWallpaperY >= 0.0f) {
                            this.mLastWallpaperY = target.mWallpaperY;
                        } else if (changingTarget.mWallpaperY >= 0.0f) {
                            this.mLastWallpaperY = changingTarget.mWallpaperY;
                        }
                        if (target.mWallpaperDisplayOffsetX != SoundTriggerHelper.STATUS_ERROR) {
                            this.mLastWallpaperDisplayOffsetX = target.mWallpaperDisplayOffsetX;
                        } else if (changingTarget.mWallpaperDisplayOffsetX != SoundTriggerHelper.STATUS_ERROR) {
                            this.mLastWallpaperDisplayOffsetX = changingTarget.mWallpaperDisplayOffsetX;
                        }
                        if (target.mWallpaperDisplayOffsetY != SoundTriggerHelper.STATUS_ERROR) {
                            this.mLastWallpaperDisplayOffsetY = target.mWallpaperDisplayOffsetY;
                        } else if (changingTarget.mWallpaperDisplayOffsetY != SoundTriggerHelper.STATUS_ERROR) {
                            this.mLastWallpaperDisplayOffsetY = changingTarget.mWallpaperDisplayOffsetY;
                        }
                        if (target.mWallpaperXStep >= 0.0f) {
                            this.mLastWallpaperXStep = target.mWallpaperXStep;
                        } else if (changingTarget.mWallpaperXStep >= 0.0f) {
                            this.mLastWallpaperXStep = changingTarget.mWallpaperXStep;
                        }
                        if (target.mWallpaperYStep >= 0.0f) {
                            this.mLastWallpaperYStep = target.mWallpaperYStep;
                        } else if (changingTarget.mWallpaperYStep >= 0.0f) {
                            this.mLastWallpaperYStep = changingTarget.mWallpaperYStep;
                        }
                    }
                    int curTokenIndex = this.mWallpaperTokens.size();
                    while (curTokenIndex > 0) {
                        curTokenIndex--;
                        WindowToken token = (WindowToken) this.mWallpaperTokens.get(curTokenIndex);
                        int curWallpaperIndex = token.windows.size();
                        while (curWallpaperIndex > 0) {
                            curWallpaperIndex--;
                            WindowState wallpaper = (WindowState) token.windows.get(curWallpaperIndex);
                            if (updateWallpaperOffsetLocked(wallpaper, dw, dh, sync)) {
                                WindowStateAnimator winAnimator = wallpaper.mWinAnimator;
                                winAnimator.computeShownFrameLocked();
                                winAnimator.setWallpaperOffset(wallpaper.mShownFrame);
                                sync = SHOW_TRANSACTIONS;
                            }
                        }
                    }
                }
            }

            void dispatchWallpaperVisibility(WindowState wallpaper, boolean visible) {
                if (wallpaper.mWallpaperVisible != visible) {
                    wallpaper.mWallpaperVisible = visible;
                    try {
                        wallpaper.mClient.dispatchAppVisibility(visible);
                    } catch (RemoteException e) {
                    }
                }
            }

            void updateWallpaperVisibilityLocked() {
                boolean visible = isWallpaperVisible(this.mWallpaperTarget);
                DisplayContent displayContent = this.mWallpaperTarget.getDisplayContent();
                if (displayContent != null) {
                    DisplayInfo displayInfo = displayContent.getDisplayInfo();
                    int dw = displayInfo.logicalWidth;
                    int dh = displayInfo.logicalHeight;
                    int curTokenIndex = this.mWallpaperTokens.size();
                    while (curTokenIndex > 0) {
                        curTokenIndex--;
                        WindowToken token = (WindowToken) this.mWallpaperTokens.get(curTokenIndex);
                        if (token.hidden == visible) {
                            boolean z;
                            if (visible) {
                                z = SHOW_TRANSACTIONS;
                            } else {
                                z = HIDE_STACK_CRAWLS;
                            }
                            token.hidden = z;
                            getDefaultDisplayContentLocked().layoutNeeded = HIDE_STACK_CRAWLS;
                        }
                        int curWallpaperIndex = token.windows.size();
                        while (curWallpaperIndex > 0) {
                            curWallpaperIndex--;
                            WindowState wallpaper = (WindowState) token.windows.get(curWallpaperIndex);
                            if (visible) {
                                updateWallpaperOffsetLocked(wallpaper, dw, dh, SHOW_TRANSACTIONS);
                            }
                            dispatchWallpaperVisibility(wallpaper, visible);
                        }
                    }
                }
            }

            public int addWindow(Session session, IWindow client, int seq, LayoutParams attrs, int viewVisibility, int displayId, Rect outContentInsets, Rect outStableInsets, InputChannel outInputChannel) {
                int[] appOp = new int[WALLPAPER_DRAW_PENDING];
                int res = this.mPolicy.checkAddPermission(attrs, appOp);
                if (res != 0) {
                    return res;
                }
                boolean reportNewConfig = SHOW_TRANSACTIONS;
                WindowState attachedWindow = null;
                int type = attrs.type;
                synchronized (this.mWindowMap) {
                    WindowState win;
                    try {
                        if (this.mDisplayReady) {
                            DisplayContent displayContent = getDisplayContentLocked(displayId);
                            if (displayContent == null) {
                                Slog.w(TAG, "Attempted to add window to a display that does not exist: " + displayId + ".  Aborting.");
                                return -9;
                            } else if (!displayContent.hasAccess(session.mUid)) {
                                Slog.w(TAG, "Attempted to add window to a display for which the application does not have access: " + displayId + ".  Aborting.");
                                return -9;
                            } else if (this.mWindowMap.containsKey(client.asBinder())) {
                                Slog.w(TAG, "Window " + client + " is already added");
                                return -5;
                            } else {
                                if (type >= TYPE_LAYER_OFFSET && type <= 1999) {
                                    attachedWindow = windowForClientLocked(null, attrs.token, (boolean) SHOW_TRANSACTIONS);
                                    if (attachedWindow == null) {
                                        Slog.w(TAG, "Attempted to add window with token that is not a window: " + attrs.token + ".  Aborting.");
                                        return -2;
                                    } else if (attachedWindow.mAttrs.type >= TYPE_LAYER_OFFSET && attachedWindow.mAttrs.type <= 1999) {
                                        Slog.w(TAG, "Attempted to add window with token that is a sub-window: " + attrs.token + ".  Aborting.");
                                        return -2;
                                    }
                                }
                                if (type != 2030 || displayContent.isPrivate()) {
                                    boolean addToken = SHOW_TRANSACTIONS;
                                    WindowToken token = (WindowToken) this.mTokenMap.get(attrs.token);
                                    if (token == null) {
                                        if (type >= WALLPAPER_DRAW_PENDING && type <= 99) {
                                            Slog.w(TAG, "Attempted to add application window with unknown token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        } else if (type == 2011) {
                                            Slog.w(TAG, "Attempted to add input method window with unknown token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        } else if (type == 2031) {
                                            Slog.w(TAG, "Attempted to add voice interaction window with unknown token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        } else if (type == 2013) {
                                            Slog.w(TAG, "Attempted to add wallpaper window with unknown token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        } else if (type == 2023) {
                                            Slog.w(TAG, "Attempted to add Dream window with unknown token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        } else if (type == 2032) {
                                            Slog.w(TAG, "Attempted to add Accessibility overlay window with unknown token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        } else {
                                            token = new WindowToken(this, attrs.token, -1, SHOW_TRANSACTIONS);
                                            addToken = HIDE_STACK_CRAWLS;
                                        }
                                    } else if (type >= WALLPAPER_DRAW_PENDING && type <= 99) {
                                        AppWindowToken atoken = token.appWindowToken;
                                        if (atoken == null) {
                                            Slog.w(TAG, "Attempted to add window with non-application token " + token + ".  Aborting.");
                                            return -3;
                                        } else if (atoken.removed) {
                                            Slog.w(TAG, "Attempted to add window with exiting application token " + token + ".  Aborting.");
                                            return -4;
                                        } else if (type == UPDATE_FOCUS_WILL_PLACE_SURFACES && atoken.firstWindowDrawn) {
                                            return -6;
                                        }
                                    } else if (type == 2011) {
                                        if (token.windowType != 2011) {
                                            Slog.w(TAG, "Attempted to add input method window with bad token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        }
                                    } else if (type == 2031) {
                                        if (token.windowType != 2031) {
                                            Slog.w(TAG, "Attempted to add voice interaction window with bad token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        }
                                    } else if (type == 2013) {
                                        if (token.windowType != 2013) {
                                            Slog.w(TAG, "Attempted to add wallpaper window with bad token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        }
                                    } else if (type == 2023) {
                                        if (token.windowType != 2023) {
                                            Slog.w(TAG, "Attempted to add Dream window with bad token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        }
                                    } else if (type == 2032) {
                                        if (token.windowType != 2032) {
                                            Slog.w(TAG, "Attempted to add Accessibility overlay window with bad token " + attrs.token + ".  Aborting.");
                                            return -1;
                                        }
                                    } else if (token.appWindowToken != null) {
                                        Slog.w(TAG, "Non-null appWindowToken for system window of type=" + type);
                                        attrs.token = null;
                                        token = new WindowToken(this, null, -1, SHOW_TRANSACTIONS);
                                        addToken = HIDE_STACK_CRAWLS;
                                    }
                                    win = new WindowState(this, session, client, token, attachedWindow, appOp[WALLPAPER_DRAW_NORMAL], seq, attrs, viewVisibility, displayContent);
                                    if (win.mDeathRecipient == null) {
                                        Slog.w(TAG, "Adding window client " + client.asBinder() + " that is dead, aborting.");
                                        return -4;
                                    } else if (win.getDisplayContent() == null) {
                                        Slog.w(TAG, "Adding window to Display that has been removed.");
                                        return -9;
                                    } else {
                                        this.mPolicy.adjustWindowParamsLw(win.mAttrs);
                                        win.setShowToOwnerOnlyLocked(this.mPolicy.checkShowToOwnerOnly(attrs));
                                        res = this.mPolicy.prepareAddWindowLw(win, attrs);
                                        if (res != 0) {
                                            return res;
                                        }
                                        if (outInputChannel != null && (attrs.inputFeatures & WALLPAPER_DRAW_TIMEOUT) == 0) {
                                            InputChannel[] inputChannels = InputChannel.openInputChannelPair(win.makeInputChannelName());
                                            win.setInputChannel(inputChannels[WALLPAPER_DRAW_NORMAL]);
                                            inputChannels[WALLPAPER_DRAW_PENDING].transferTo(outInputChannel);
                                            this.mInputManager.registerInputChannel(win.mInputChannel, win.mInputWindowHandle);
                                        }
                                        res = WALLPAPER_DRAW_NORMAL;
                                        long origId = Binder.clearCallingIdentity();
                                        if (addToken) {
                                            this.mTokenMap.put(attrs.token, token);
                                        }
                                        win.attach();
                                        this.mWindowMap.put(client.asBinder(), win);
                                        if (!(win.mAppOp == -1 || this.mAppOps.startOpNoThrow(win.mAppOp, win.getOwningUid(), win.getOwningPackage()) == 0)) {
                                            win.setAppOpVisibilityLw(SHOW_TRANSACTIONS);
                                        }
                                        if (type == UPDATE_FOCUS_WILL_PLACE_SURFACES && token.appWindowToken != null) {
                                            token.appWindowToken.startingWindow = win;
                                        }
                                        boolean imMayMove = HIDE_STACK_CRAWLS;
                                        if (type == 2011) {
                                            win.mGivenInsetsPending = HIDE_STACK_CRAWLS;
                                            this.mInputMethodWindow = win;
                                            addInputMethodWindowToListLocked(win);
                                            imMayMove = SHOW_TRANSACTIONS;
                                        } else if (type == 2012) {
                                            this.mInputMethodDialogs.add(win);
                                            addWindowToListInOrderLocked(win, HIDE_STACK_CRAWLS);
                                            moveInputMethodDialogsLocked(findDesiredInputMethodWindowIndexLocked(HIDE_STACK_CRAWLS));
                                            imMayMove = SHOW_TRANSACTIONS;
                                        } else {
                                            addWindowToListInOrderLocked(win, HIDE_STACK_CRAWLS);
                                            if (type == 2013) {
                                                this.mLastWallpaperTimeoutTime = 0;
                                                displayContent.pendingLayoutChanges |= LAYOUT_REPEAT_THRESHOLD;
                                            } else if ((attrs.flags & 1048576) != 0) {
                                                displayContent.pendingLayoutChanges |= LAYOUT_REPEAT_THRESHOLD;
                                            } else if (this.mWallpaperTarget != null && this.mWallpaperTarget.mLayer >= win.mBaseLayer) {
                                                displayContent.pendingLayoutChanges |= LAYOUT_REPEAT_THRESHOLD;
                                            }
                                        }
                                        WindowStateAnimator winAnimator = win.mWinAnimator;
                                        winAnimator.mEnterAnimationPending = HIDE_STACK_CRAWLS;
                                        winAnimator.mEnteringAnimation = HIDE_STACK_CRAWLS;
                                        if (displayContent.isDefaultDisplay) {
                                            this.mPolicy.getInsetHintLw(win.mAttrs, outContentInsets, outStableInsets);
                                        } else {
                                            outContentInsets.setEmpty();
                                            outStableInsets.setEmpty();
                                        }
                                        if (this.mInTouchMode) {
                                            res = WALLPAPER_DRAW_NORMAL | WALLPAPER_DRAW_PENDING;
                                        }
                                        if (win.mAppToken == null || !win.mAppToken.clientHidden) {
                                            res |= WALLPAPER_DRAW_TIMEOUT;
                                        }
                                        this.mInputMonitor.setUpdateInputWindowsNeededLw();
                                        boolean focusChanged = SHOW_TRANSACTIONS;
                                        if (win.canReceiveKeys()) {
                                            focusChanged = updateFocusedWindowLocked(WALLPAPER_DRAW_PENDING, SHOW_TRANSACTIONS);
                                            if (focusChanged) {
                                                imMayMove = SHOW_TRANSACTIONS;
                                            }
                                        }
                                        if (imMayMove) {
                                            moveInputMethodWindowsIfNeededLocked(SHOW_TRANSACTIONS);
                                        }
                                        assignLayersLocked(displayContent.getWindowList());
                                        if (focusChanged) {
                                            this.mInputMonitor.setInputFocusLw(this.mCurrentFocus, SHOW_TRANSACTIONS);
                                        }
                                        this.mInputMonitor.updateInputWindowsLw(SHOW_TRANSACTIONS);
                                        if (win.isVisibleOrAdding() && updateOrientationFromAppTokensLocked(SHOW_TRANSACTIONS)) {
                                            reportNewConfig = HIDE_STACK_CRAWLS;
                                        }
                                        if (reportNewConfig) {
                                            sendNewConfiguration();
                                        }
                                        Binder.restoreCallingIdentity(origId);
                                        return res;
                                    }
                                }
                                Slog.w(TAG, "Attempted to add private presentation window to a non-private display.  Aborting.");
                                return -8;
                            }
                        }
                        throw new IllegalStateException("Display has not been initialialized");
                    } catch (Throwable th) {
                        Throwable th2 = th;
                        win = null;
                        try {
                        } catch (Throwable th3) {
                            th2 = th3;
                            throw th2;
                        }
                        throw th2;
                    }
                }
            }

            boolean isScreenCaptureDisabledLocked(int userId) {
                Boolean disabled = (Boolean) this.mScreenCaptureDisabled.get(userId);
                if (disabled == null) {
                    return SHOW_TRANSACTIONS;
                }
                return disabled.booleanValue();
            }

            public void setScreenCaptureDisabled(int userId, boolean disabled) {
                if (Binder.getCallingUid() != TYPE_LAYER_OFFSET) {
                    throw new SecurityException("Only system can call setScreenCaptureDisabled.");
                }
                synchronized (this.mWindowMap) {
                    this.mScreenCaptureDisabled.put(userId, Boolean.valueOf(disabled));
                }
            }

            public void removeWindow(Session session, IWindow client) {
                synchronized (this.mWindowMap) {
                    WindowState win = windowForClientLocked(session, client, (boolean) SHOW_TRANSACTIONS);
                    if (win == null) {
                        return;
                    }
                    removeWindowLocked(session, win);
                }
            }

            public void removeWindowLocked(Session session, WindowState win) {
                long origId;
                boolean wasVisible;
                if (win.mAttrs.type == UPDATE_FOCUS_WILL_PLACE_SURFACES) {
                    origId = Binder.clearCallingIdentity();
                    win.disposeInputChannel();
                    wasVisible = SHOW_TRANSACTIONS;
                } else {
                    origId = Binder.clearCallingIdentity();
                    win.disposeInputChannel();
                    wasVisible = SHOW_TRANSACTIONS;
                }
                if (win.mHasSurface && okToDisplay()) {
                    wasVisible = win.isWinVisibleLw();
                    if (wasVisible) {
                        int transit = WALLPAPER_DRAW_TIMEOUT;
                        if (win.mAttrs.type == UPDATE_FOCUS_WILL_PLACE_SURFACES) {
                            transit = WINDOW_LAYER_MULTIPLIER;
                        }
                        if (win.mWinAnimator.applyAnimationLocked(transit, SHOW_TRANSACTIONS)) {
                            win.mExiting = HIDE_STACK_CRAWLS;
                        }
                        if (this.mAccessibilityController != null && win.getDisplayId() == 0) {
                            this.mAccessibilityController.onWindowTransitionLocked(win, transit);
                        }
                    }
                    if (win.mExiting || win.mWinAnimator.isAnimating()) {
                        win.mExiting = HIDE_STACK_CRAWLS;
                        win.mRemoveOnExit = HIDE_STACK_CRAWLS;
                        DisplayContent displayContent = win.getDisplayContent();
                        if (displayContent != null) {
                            displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                        }
                        boolean focusChanged = updateFocusedWindowLocked(UPDATE_FOCUS_WILL_PLACE_SURFACES, SHOW_TRANSACTIONS);
                        performLayoutAndPlaceSurfacesLocked();
                        if (win.mAppToken != null) {
                            win.mAppToken.updateReportedVisibilityLocked();
                        }
                        if (focusChanged) {
                            this.mInputMonitor.updateInputWindowsLw(SHOW_TRANSACTIONS);
                        }
                        Binder.restoreCallingIdentity(origId);
                        return;
                    }
                }
                removeWindowInnerLocked(session, win);
                if (wasVisible && updateOrientationFromAppTokensLocked(SHOW_TRANSACTIONS)) {
                    this.mH.sendEmptyMessage(18);
                }
                updateFocusedWindowLocked(WALLPAPER_DRAW_NORMAL, HIDE_STACK_CRAWLS);
                Binder.restoreCallingIdentity(origId);
            }

            void removeWindowInnerLocked(Session session, WindowState win) {
                if (!win.mRemoved) {
                    for (int i = win.mChildWindows.size() - 1; i >= 0; i--) {
                        WindowState cwin = (WindowState) win.mChildWindows.get(i);
                        Slog.w(TAG, "Force-removing child win " + cwin + " from container " + win);
                        removeWindowInnerLocked(cwin.mSession, cwin);
                    }
                    win.mRemoved = HIDE_STACK_CRAWLS;
                    if (this.mInputMethodTarget == win) {
                        moveInputMethodWindowsIfNeededLocked(SHOW_TRANSACTIONS);
                    }
                    this.mPolicy.removeWindowLw(win);
                    win.removeLocked();
                    this.mWindowMap.remove(win.mClient.asBinder());
                    if (win.mAppOp != -1) {
                        this.mAppOps.finishOp(win.mAppOp, win.getOwningUid(), win.getOwningPackage());
                    }
                    this.mPendingRemove.remove(win);
                    this.mResizingWindows.remove(win);
                    this.mWindowsChanged = HIDE_STACK_CRAWLS;
                    if (this.mInputMethodWindow == win) {
                        this.mInputMethodWindow = null;
                    } else if (win.mAttrs.type == 2012) {
                        this.mInputMethodDialogs.remove(win);
                    }
                    WindowToken token = win.mToken;
                    AppWindowToken atoken = win.mAppToken;
                    token.windows.remove(win);
                    if (atoken != null) {
                        atoken.allAppWindows.remove(win);
                    }
                    if (token.windows.size() == 0) {
                        if (!token.explicit) {
                            this.mTokenMap.remove(token.token);
                        } else if (atoken != null) {
                            atoken.firstWindowDrawn = SHOW_TRANSACTIONS;
                        }
                    }
                    if (atoken != null) {
                        if (atoken.startingWindow == win) {
                            scheduleRemoveStartingWindowLocked(atoken);
                        } else if (atoken.allAppWindows.size() == 0 && atoken.startingData != null) {
                            atoken.startingData = null;
                        } else if (atoken.allAppWindows.size() == WALLPAPER_DRAW_PENDING && atoken.startingView != null) {
                            scheduleRemoveStartingWindowLocked(atoken);
                        }
                    }
                    DisplayContent defaultDisplayContentLocked;
                    if (win.mAttrs.type == 2013) {
                        this.mLastWallpaperTimeoutTime = 0;
                        defaultDisplayContentLocked = getDefaultDisplayContentLocked();
                        defaultDisplayContentLocked.pendingLayoutChanges |= LAYOUT_REPEAT_THRESHOLD;
                    } else if ((win.mAttrs.flags & 1048576) != 0) {
                        defaultDisplayContentLocked = getDefaultDisplayContentLocked();
                        defaultDisplayContentLocked.pendingLayoutChanges |= LAYOUT_REPEAT_THRESHOLD;
                    }
                    WindowList windows = win.getWindowList();
                    if (windows != null) {
                        windows.remove(win);
                        if (!this.mInLayout) {
                            assignLayersLocked(windows);
                            DisplayContent displayContent = win.getDisplayContent();
                            if (displayContent != null) {
                                displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                            }
                            performLayoutAndPlaceSurfacesLocked();
                            if (win.mAppToken != null) {
                                win.mAppToken.updateReportedVisibilityLocked();
                            }
                        }
                    }
                    this.mInputMonitor.updateInputWindowsLw(HIDE_STACK_CRAWLS);
                }
            }

            public void updateAppOpsState() {
                synchronized (this.mWindowMap) {
                    int numDisplays = this.mDisplayContents.size();
                    for (int displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                        WindowList windows = ((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).getWindowList();
                        int numWindows = windows.size();
                        for (int winNdx = WALLPAPER_DRAW_NORMAL; winNdx < numWindows; winNdx += WALLPAPER_DRAW_PENDING) {
                            WindowState win = (WindowState) windows.get(winNdx);
                            if (win.mAppOp != -1) {
                                boolean z;
                                if (this.mAppOps.checkOpNoThrow(win.mAppOp, win.getOwningUid(), win.getOwningPackage()) == 0) {
                                    z = HIDE_STACK_CRAWLS;
                                } else {
                                    z = SHOW_TRANSACTIONS;
                                }
                                win.setAppOpVisibilityLw(z);
                            }
                        }
                    }
                }
            }

            static void logSurface(WindowState w, String msg, RuntimeException where) {
                String str = "  SURFACE " + msg + ": " + w;
                if (where != null) {
                    Slog.i(TAG, str, where);
                } else {
                    Slog.i(TAG, str);
                }
            }

            static void logSurface(SurfaceControl s, String title, String msg, RuntimeException where) {
                String str = "  SURFACE " + s + ": " + msg + " / " + title;
                if (where != null) {
                    Slog.i(TAG, str, where);
                } else {
                    Slog.i(TAG, str);
                }
            }

            void setTransparentRegionWindow(Session session, IWindow client, Region region) {
                long origId = Binder.clearCallingIdentity();
                try {
                    synchronized (this.mWindowMap) {
                        WindowState w = windowForClientLocked(session, client, (boolean) SHOW_TRANSACTIONS);
                        if (w != null && w.mHasSurface) {
                            w.mWinAnimator.setTransparentRegionHintLocked(region);
                        }
                    }
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }

            void setInsetsWindow(Session session, IWindow client, int touchableInsets, Rect contentInsets, Rect visibleInsets, Region touchableRegion) {
                long origId = Binder.clearCallingIdentity();
                try {
                    synchronized (this.mWindowMap) {
                        WindowState w = windowForClientLocked(session, client, (boolean) SHOW_TRANSACTIONS);
                        if (w != null) {
                            w.mGivenInsetsPending = SHOW_TRANSACTIONS;
                            w.mGivenContentInsets.set(contentInsets);
                            w.mGivenVisibleInsets.set(visibleInsets);
                            w.mGivenTouchableRegion.set(touchableRegion);
                            w.mTouchableInsets = touchableInsets;
                            if (w.mGlobalScale != 1.0f) {
                                w.mGivenContentInsets.scale(w.mGlobalScale);
                                w.mGivenVisibleInsets.scale(w.mGlobalScale);
                                w.mGivenTouchableRegion.scale(w.mGlobalScale);
                            }
                            DisplayContent displayContent = w.getDisplayContent();
                            if (displayContent != null) {
                                displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                            }
                            performLayoutAndPlaceSurfacesLocked();
                        }
                    }
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }

            public void getWindowDisplayFrame(Session session, IWindow client, Rect outDisplayFrame) {
                synchronized (this.mWindowMap) {
                    WindowState win = windowForClientLocked(session, client, (boolean) SHOW_TRANSACTIONS);
                    if (win == null) {
                        outDisplayFrame.setEmpty();
                        return;
                    }
                    outDisplayFrame.set(win.mDisplayFrame);
                }
            }

            public void setWindowWallpaperPositionLocked(WindowState window, float x, float y, float xStep, float yStep) {
                if (window.mWallpaperX != x || window.mWallpaperY != y) {
                    window.mWallpaperX = x;
                    window.mWallpaperY = y;
                    window.mWallpaperXStep = xStep;
                    window.mWallpaperYStep = yStep;
                    updateWallpaperOffsetLocked(window, HIDE_STACK_CRAWLS);
                }
            }

            void wallpaperCommandComplete(IBinder window, Bundle result) {
                synchronized (this.mWindowMap) {
                    if (this.mWaitingOnWallpaper != null && this.mWaitingOnWallpaper.mClient.asBinder() == window) {
                        this.mWaitingOnWallpaper = null;
                        this.mWindowMap.notifyAll();
                    }
                }
            }

            public void setWindowWallpaperDisplayOffsetLocked(WindowState window, int x, int y) {
                if (window.mWallpaperDisplayOffsetX != x || window.mWallpaperDisplayOffsetY != y) {
                    window.mWallpaperDisplayOffsetX = x;
                    window.mWallpaperDisplayOffsetY = y;
                    updateWallpaperOffsetLocked(window, HIDE_STACK_CRAWLS);
                }
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public android.os.Bundle sendWindowWallpaperCommandLocked(com.android.server.wm.WindowState r13, java.lang.String r14, int r15, int r16, int r17, android.os.Bundle r18, boolean r19) {
                /*
                r12 = this;
                r0 = r12.mWallpaperTarget;
                if (r13 == r0) goto L_0x000c;
            L_0x0004:
                r0 = r12.mLowerWallpaperTarget;
                if (r13 == r0) goto L_0x000c;
            L_0x0008:
                r0 = r12.mUpperWallpaperTarget;
                if (r13 != r0) goto L_0x0046;
            L_0x000c:
                r9 = r19;
                r0 = r12.mWallpaperTokens;
                r7 = r0.size();
            L_0x0014:
                if (r7 <= 0) goto L_0x0044;
            L_0x0016:
                r7 = r7 + -1;
                r0 = r12.mWallpaperTokens;
                r10 = r0.get(r7);
                r10 = (com.android.server.wm.WindowToken) r10;
                r0 = r10.windows;
                r8 = r0.size();
            L_0x0026:
                if (r8 <= 0) goto L_0x0014;
            L_0x0028:
                r8 = r8 + -1;
                r0 = r10.windows;
                r11 = r0.get(r8);
                r11 = (com.android.server.wm.WindowState) r11;
                r0 = r11.mClient;	 Catch:{ RemoteException -> 0x0048 }
                r1 = r14;
                r2 = r15;
                r3 = r16;
                r4 = r17;
                r5 = r18;
                r6 = r19;
                r0.dispatchWallpaperCommand(r1, r2, r3, r4, r5, r6);	 Catch:{ RemoteException -> 0x0048 }
                r19 = 0;
                goto L_0x0026;
            L_0x0044:
                if (r9 == 0) goto L_0x0046;
            L_0x0046:
                r0 = 0;
                return r0;
            L_0x0048:
                r0 = move-exception;
                goto L_0x0026;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.sendWindowWallpaperCommandLocked(com.android.server.wm.WindowState, java.lang.String, int, int, int, android.os.Bundle, boolean):android.os.Bundle");
            }

            public void setUniverseTransformLocked(WindowState window, float alpha, float offx, float offy, float dsdx, float dtdx, float dsdy, float dtdy) {
                Transformation transform = window.mWinAnimator.mUniverseTransform;
                transform.setAlpha(alpha);
                Matrix matrix = transform.getMatrix();
                matrix.getValues(this.mTmpFloats);
                this.mTmpFloats[WALLPAPER_DRAW_TIMEOUT] = offx;
                this.mTmpFloats[WINDOW_LAYER_MULTIPLIER] = offy;
                this.mTmpFloats[WALLPAPER_DRAW_NORMAL] = dsdx;
                this.mTmpFloats[UPDATE_FOCUS_WILL_PLACE_SURFACES] = dtdx;
                this.mTmpFloats[WALLPAPER_DRAW_PENDING] = dsdy;
                this.mTmpFloats[LAYOUT_REPEAT_THRESHOLD] = dtdy;
                matrix.setValues(this.mTmpFloats);
                DisplayContent displayContent = window.getDisplayContent();
                if (displayContent != null) {
                    DisplayInfo displayInfo = displayContent.getDisplayInfo();
                    RectF dispRect = new RectF(0.0f, 0.0f, (float) displayInfo.logicalWidth, (float) displayInfo.logicalHeight);
                    matrix.mapRect(dispRect);
                    window.mGivenTouchableRegion.set(WALLPAPER_DRAW_NORMAL, WALLPAPER_DRAW_NORMAL, displayInfo.logicalWidth, displayInfo.logicalHeight);
                    window.mGivenTouchableRegion.op((int) dispRect.left, (int) dispRect.top, (int) dispRect.right, (int) dispRect.bottom, Op.DIFFERENCE);
                    window.mTouchableInsets = UPDATE_FOCUS_WILL_PLACE_SURFACES;
                    displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                    performLayoutAndPlaceSurfacesLocked();
                }
            }

            public void onRectangleOnScreenRequested(IBinder token, Rect rectangle) {
                synchronized (this.mWindowMap) {
                    if (this.mAccessibilityController != null) {
                        WindowState window = (WindowState) this.mWindowMap.get(token);
                        if (window != null && window.getDisplayId() == 0) {
                            this.mAccessibilityController.onRectangleOnScreenRequestedLocked(rectangle);
                        }
                    }
                }
            }

            public IWindowId getWindowId(IBinder token) {
                IWindowId iWindowId;
                synchronized (this.mWindowMap) {
                    WindowState window = (WindowState) this.mWindowMap.get(token);
                    iWindowId = window != null ? window.mWindowId : null;
                }
                return iWindowId;
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public int relayoutWindow(com.android.server.wm.Session r37, android.view.IWindow r38, int r39, android.view.WindowManager.LayoutParams r40, int r41, int r42, int r43, int r44, android.graphics.Rect r45, android.graphics.Rect r46, android.graphics.Rect r47, android.graphics.Rect r48, android.graphics.Rect r49, android.content.res.Configuration r50, android.view.Surface r51) {
                /*
                r36 = this;
                r27 = 0;
                r24 = 0;
                r0 = r36;
                r0 = r0.mContext;
                r32 = r0;
                r33 = "android.permission.STATUS_BAR";
                r32 = r32.checkCallingOrSelfPermission(r33);
                if (r32 != 0) goto L_0x0032;
            L_0x0012:
                r14 = 1;
            L_0x0013:
                r20 = android.os.Binder.clearCallingIdentity();
                r0 = r36;
                r0 = r0.mWindowMap;
                r33 = r0;
                monitor-enter(r33);
                r32 = 0;
                r0 = r36;
                r1 = r37;
                r2 = r38;
                r3 = r32;
                r30 = r0.windowForClientLocked(r1, r2, r3);	 Catch:{ all -> 0x00e4 }
                if (r30 != 0) goto L_0x0034;
            L_0x002e:
                r32 = 0;
                monitor-exit(r33);	 Catch:{ all -> 0x00e4 }
            L_0x0031:
                return r32;
            L_0x0032:
                r14 = 0;
                goto L_0x0013;
            L_0x0034:
                r0 = r30;
                r0 = r0.mWinAnimator;	 Catch:{ all -> 0x00e4 }
                r31 = r0;
                r32 = 8;
                r0 = r43;
                r1 = r32;
                if (r0 == r1) goto L_0x006e;
            L_0x0042:
                r0 = r30;
                r0 = r0.mRequestedWidth;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r41;
                if (r0 != r1) goto L_0x005a;
            L_0x004e:
                r0 = r30;
                r0 = r0.mRequestedHeight;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r42;
                if (r0 == r1) goto L_0x006e;
            L_0x005a:
                r32 = 1;
                r0 = r32;
                r1 = r30;
                r1.mLayoutNeeded = r0;	 Catch:{ all -> 0x00e4 }
                r0 = r41;
                r1 = r30;
                r1.mRequestedWidth = r0;	 Catch:{ all -> 0x00e4 }
                r0 = r42;
                r1 = r30;
                r1.mRequestedHeight = r0;	 Catch:{ all -> 0x00e4 }
            L_0x006e:
                if (r40 == 0) goto L_0x007d;
            L_0x0070:
                r0 = r36;
                r0 = r0.mPolicy;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r40;
                r0.adjustWindowParamsLw(r1);	 Catch:{ all -> 0x00e4 }
            L_0x007d:
                r26 = 0;
                if (r40 == 0) goto L_0x009c;
            L_0x0081:
                r0 = r40;
                r0 = r0.systemUiVisibility;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r40;
                r0 = r0.subtreeSystemUiVisibility;	 Catch:{ all -> 0x00e4 }
                r34 = r0;
                r26 = r32 | r34;
                r32 = 67043328; // 0x3ff0000 float:1.4987553E-36 double:3.3123805E-316;
                r32 = r32 & r26;
                if (r32 == 0) goto L_0x009c;
            L_0x0095:
                if (r14 != 0) goto L_0x009c;
            L_0x0097:
                r32 = -67043329; // 0xfffffffffc00ffff float:-2.679225E36 double:NaN;
                r26 = r26 & r32;
            L_0x009c:
                if (r40 == 0) goto L_0x00b0;
            L_0x009e:
                r0 = r30;
                r0 = r0.mSeq;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r39;
                r1 = r32;
                if (r0 != r1) goto L_0x00b0;
            L_0x00aa:
                r0 = r26;
                r1 = r30;
                r1.mSystemUiVisibility = r0;	 Catch:{ all -> 0x00e4 }
            L_0x00b0:
                r32 = r44 & 2;
                if (r32 == 0) goto L_0x00e7;
            L_0x00b4:
                r32 = 1;
            L_0x00b6:
                r0 = r32;
                r1 = r31;
                r1.mSurfaceDestroyDeferred = r0;	 Catch:{ all -> 0x00e4 }
                r7 = 0;
                r12 = 0;
                if (r40 == 0) goto L_0x011e;
            L_0x00c0:
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.type;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r40;
                r0 = r0.type;	 Catch:{ all -> 0x00e4 }
                r34 = r0;
                r0 = r32;
                r1 = r34;
                if (r0 == r1) goto L_0x00ea;
            L_0x00d8:
                r32 = new java.lang.IllegalArgumentException;	 Catch:{ all -> 0x00e4 }
                r34 = "Window type can not be changed after the window is added.";
                r0 = r32;
                r1 = r34;
                r0.<init>(r1);	 Catch:{ all -> 0x00e4 }
                throw r32;	 Catch:{ all -> 0x00e4 }
            L_0x00e4:
                r32 = move-exception;
                monitor-exit(r33);	 Catch:{ all -> 0x00e4 }
                throw r32;
            L_0x00e7:
                r32 = 0;
                goto L_0x00b6;
            L_0x00ea:
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.flags;	 Catch:{ all -> 0x00e4 }
                r34 = r0;
                r0 = r40;
                r0 = r0.flags;	 Catch:{ all -> 0x00e4 }
                r35 = r0;
                r12 = r34 ^ r35;
                r0 = r32;
                r0.flags = r12;	 Catch:{ all -> 0x00e4 }
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r40;
                r7 = r0.copyFrom(r1);	 Catch:{ all -> 0x00e4 }
                r0 = r7 & 16385;
                r32 = r0;
                if (r32 == 0) goto L_0x011e;
            L_0x0116:
                r32 = 1;
                r0 = r32;
                r1 = r30;
                r1.mLayoutNeeded = r0;	 Catch:{ all -> 0x00e4 }
            L_0x011e:
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.privateFlags;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0 & 128;
                r32 = r0;
                if (r32 == 0) goto L_0x04d5;
            L_0x0132:
                r32 = 1;
            L_0x0134:
                r0 = r32;
                r1 = r30;
                r1.mEnforceSizeCompat = r0;	 Catch:{ all -> 0x00e4 }
                r0 = r7 & 128;
                r32 = r0;
                if (r32 == 0) goto L_0x014c;
            L_0x0140:
                r0 = r40;
                r0 = r0.alpha;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r31;
                r1.mAlpha = r0;	 Catch:{ all -> 0x00e4 }
            L_0x014c:
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.flags;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0 & 16384;
                r32 = r0;
                if (r32 == 0) goto L_0x04d9;
            L_0x0160:
                r23 = 1;
            L_0x0162:
                if (r23 == 0) goto L_0x04e5;
            L_0x0164:
                r0 = r40;
                r0 = r0.width;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r41;
                if (r0 == r1) goto L_0x04dd;
            L_0x0170:
                r0 = r40;
                r0 = r0.width;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = (float) r0;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r41;
                r0 = (float) r0;	 Catch:{ all -> 0x00e4 }
                r34 = r0;
                r32 = r32 / r34;
            L_0x0182:
                r0 = r32;
                r1 = r30;
                r1.mHScale = r0;	 Catch:{ all -> 0x00e4 }
                r0 = r40;
                r0 = r0.height;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r42;
                if (r0 == r1) goto L_0x04e1;
            L_0x0194:
                r0 = r40;
                r0 = r0.height;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = (float) r0;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r42;
                r0 = (float) r0;	 Catch:{ all -> 0x00e4 }
                r34 = r0;
                r32 = r32 / r34;
            L_0x01a6:
                r0 = r32;
                r1 = r30;
                r1.mVScale = r0;	 Catch:{ all -> 0x00e4 }
            L_0x01ac:
                r32 = 131080; // 0x20008 float:1.83682E-40 double:6.4762E-319;
                r32 = r32 & r12;
                if (r32 == 0) goto L_0x04f5;
            L_0x01b3:
                r15 = 1;
            L_0x01b4:
                r17 = r30.isDefaultDisplay();	 Catch:{ all -> 0x00e4 }
                if (r17 == 0) goto L_0x04f8;
            L_0x01ba:
                r0 = r30;
                r0 = r0.mViewVisibility;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r43;
                if (r0 != r1) goto L_0x01d2;
            L_0x01c6:
                r32 = r12 & 8;
                if (r32 != 0) goto L_0x01d2;
            L_0x01ca:
                r0 = r30;
                r0 = r0.mRelayoutCalled;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 != 0) goto L_0x04f8;
            L_0x01d2:
                r13 = 1;
            L_0x01d3:
                r0 = r30;
                r0 = r0.mViewVisibility;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r43;
                if (r0 == r1) goto L_0x04fb;
            L_0x01df:
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.flags;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r34 = 1048576; // 0x100000 float:1.469368E-39 double:5.180654E-318;
                r32 = r32 & r34;
                if (r32 == 0) goto L_0x04fb;
            L_0x01f1:
                r29 = 1;
            L_0x01f3:
                r32 = 1048576; // 0x100000 float:1.469368E-39 double:5.180654E-318;
                r32 = r32 & r12;
                if (r32 == 0) goto L_0x04ff;
            L_0x01f9:
                r32 = 1;
            L_0x01fb:
                r29 = r29 | r32;
                r32 = 1;
                r0 = r32;
                r1 = r30;
                r1.mRelayoutCalled = r0;	 Catch:{ all -> 0x00e4 }
                r0 = r30;
                r0 = r0.mViewVisibility;	 Catch:{ all -> 0x00e4 }
                r19 = r0;
                r0 = r43;
                r1 = r30;
                r1.mViewVisibility = r0;	 Catch:{ all -> 0x00e4 }
                if (r43 != 0) goto L_0x055e;
            L_0x0213:
                r0 = r30;
                r0 = r0.mAppToken;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 == 0) goto L_0x0229;
            L_0x021b:
                r0 = r30;
                r0 = r0.mAppToken;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.clientHidden;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 != 0) goto L_0x055e;
            L_0x0229:
                r32 = r30.isVisibleLw();	 Catch:{ all -> 0x00e4 }
                if (r32 != 0) goto L_0x0503;
            L_0x022f:
                r27 = 1;
            L_0x0231:
                r0 = r30;
                r0 = r0.mExiting;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 == 0) goto L_0x0244;
            L_0x0239:
                r31.cancelExitAnimationForNextAnimationLocked();	 Catch:{ all -> 0x00e4 }
                r32 = 0;
                r0 = r32;
                r1 = r30;
                r1.mExiting = r0;	 Catch:{ all -> 0x00e4 }
            L_0x0244:
                r0 = r30;
                r0 = r0.mDestroying;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 == 0) goto L_0x0261;
            L_0x024c:
                r32 = 0;
                r0 = r32;
                r1 = r30;
                r1.mDestroying = r0;	 Catch:{ all -> 0x00e4 }
                r0 = r36;
                r0 = r0.mDestroySurface;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r30;
                r0.remove(r1);	 Catch:{ all -> 0x00e4 }
            L_0x0261:
                r32 = 8;
                r0 = r19;
                r1 = r32;
                if (r0 != r1) goto L_0x0271;
            L_0x0269:
                r32 = 1;
                r0 = r32;
                r1 = r31;
                r1.mEnterAnimationPending = r0;	 Catch:{ all -> 0x00e4 }
            L_0x0271:
                r32 = 1;
                r0 = r32;
                r1 = r31;
                r1.mEnteringAnimation = r0;	 Catch:{ all -> 0x00e4 }
                if (r27 == 0) goto L_0x02d9;
            L_0x027b:
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.softInputMode;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0 & 240;
                r32 = r0;
                r34 = 16;
                r0 = r32;
                r1 = r34;
                if (r0 != r1) goto L_0x029d;
            L_0x0295:
                r32 = 1;
                r0 = r32;
                r1 = r30;
                r1.mLayoutNeeded = r0;	 Catch:{ all -> 0x00e4 }
            L_0x029d:
                r32 = r30.isDrawnLw();	 Catch:{ all -> 0x00e4 }
                if (r32 == 0) goto L_0x02ac;
            L_0x02a3:
                r32 = r36.okToDisplay();	 Catch:{ all -> 0x00e4 }
                if (r32 == 0) goto L_0x02ac;
            L_0x02a9:
                r31.applyEnterAnimationLocked();	 Catch:{ all -> 0x00e4 }
            L_0x02ac:
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.flags;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r34 = 2097152; // 0x200000 float:2.938736E-39 double:1.0361308E-317;
                r32 = r32 & r34;
                if (r32 == 0) goto L_0x02c6;
            L_0x02be:
                r32 = 1;
                r0 = r32;
                r1 = r30;
                r1.mTurnOnScreen = r0;	 Catch:{ all -> 0x00e4 }
            L_0x02c6:
                r32 = r30.isConfigChanged();	 Catch:{ all -> 0x00e4 }
                if (r32 == 0) goto L_0x02d9;
            L_0x02cc:
                r0 = r36;
                r0 = r0.mCurConfiguration;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r50;
                r1 = r32;
                r0.setTo(r1);	 Catch:{ all -> 0x00e4 }
            L_0x02d9:
                r32 = r7 & 8;
                if (r32 == 0) goto L_0x02e4;
            L_0x02dd:
                r31.destroySurfaceLocked();	 Catch:{ all -> 0x00e4 }
                r27 = 1;
                r24 = 1;
            L_0x02e4:
                r0 = r30;
                r0 = r0.mHasSurface;	 Catch:{ Exception -> 0x050c }
                r32 = r0;
                if (r32 != 0) goto L_0x02ee;
            L_0x02ec:
                r24 = 1;
            L_0x02ee:
                r25 = r31.createSurfaceLocked();	 Catch:{ Exception -> 0x050c }
                if (r25 == 0) goto L_0x0507;
            L_0x02f4:
                r0 = r51;
                r1 = r25;
                r0.copyFrom(r1);	 Catch:{ Exception -> 0x050c }
            L_0x02fb:
                if (r27 == 0) goto L_0x02ff;
            L_0x02fd:
                r13 = r17;
            L_0x02ff:
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.type;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r34 = 2011; // 0x7db float:2.818E-42 double:9.936E-321;
                r0 = r32;
                r1 = r34;
                if (r0 != r1) goto L_0x0322;
            L_0x0313:
                r0 = r36;
                r0 = r0.mInputMethodWindow;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 != 0) goto L_0x0322;
            L_0x031b:
                r0 = r30;
                r1 = r36;
                r1.mInputMethodWindow = r0;	 Catch:{ all -> 0x00e4 }
                r15 = 1;
            L_0x0322:
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.type;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r34 = 1;
                r0 = r32;
                r1 = r34;
                if (r0 != r1) goto L_0x0385;
            L_0x0336:
                r0 = r30;
                r0 = r0.mAppToken;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 == 0) goto L_0x0385;
            L_0x033e:
                r0 = r30;
                r0 = r0.mAppToken;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.startingWindow;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 == 0) goto L_0x0385;
            L_0x034c:
                r18 = 4718593; // 0x480001 float:6.612157E-39 double:2.3312947E-317;
                r0 = r30;
                r0 = r0.mAppToken;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.startingWindow;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r22 = r0;
                r0 = r22;
                r0 = r0.flags;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r34 = -4718594; // 0xffffffffffb7fffe float:NaN double:NaN;
                r32 = r32 & r34;
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r34 = r0;
                r0 = r34;
                r0 = r0.flags;	 Catch:{ all -> 0x00e4 }
                r34 = r0;
                r35 = 4718593; // 0x480001 float:6.612157E-39 double:2.3312947E-317;
                r34 = r34 & r35;
                r32 = r32 | r34;
                r0 = r32;
                r1 = r22;
                r1.flags = r0;	 Catch:{ all -> 0x00e4 }
            L_0x0385:
                if (r13 == 0) goto L_0x0398;
            L_0x0387:
                r32 = 3;
                r34 = 0;
                r0 = r36;
                r1 = r32;
                r2 = r34;
                r32 = r0.updateFocusedWindowLocked(r1, r2);	 Catch:{ all -> 0x00e4 }
                if (r32 == 0) goto L_0x0398;
            L_0x0397:
                r15 = 0;
            L_0x0398:
                if (r15 == 0) goto L_0x03b3;
            L_0x039a:
                r32 = 0;
                r0 = r36;
                r1 = r32;
                r32 = r0.moveInputMethodWindowsIfNeededLocked(r1);	 Catch:{ all -> 0x00e4 }
                if (r32 != 0) goto L_0x03a8;
            L_0x03a6:
                if (r27 == 0) goto L_0x03b3;
            L_0x03a8:
                r32 = r30.getWindowList();	 Catch:{ all -> 0x00e4 }
                r0 = r36;
                r1 = r32;
                r0.assignLayersLocked(r1);	 Catch:{ all -> 0x00e4 }
            L_0x03b3:
                if (r29 == 0) goto L_0x03c7;
            L_0x03b5:
                r32 = r36.getDefaultDisplayContentLocked();	 Catch:{ all -> 0x00e4 }
                r0 = r32;
                r0 = r0.pendingLayoutChanges;	 Catch:{ all -> 0x00e4 }
                r34 = r0;
                r34 = r34 | 4;
                r0 = r34;
                r1 = r32;
                r1.pendingLayoutChanges = r0;	 Catch:{ all -> 0x00e4 }
            L_0x03c7:
                r9 = r30.getDisplayContent();	 Catch:{ all -> 0x00e4 }
                if (r9 == 0) goto L_0x03d3;
            L_0x03cd:
                r32 = 1;
                r0 = r32;
                r9.layoutNeeded = r0;	 Catch:{ all -> 0x00e4 }
            L_0x03d3:
                r32 = r44 & 1;
                if (r32 == 0) goto L_0x0628;
            L_0x03d7:
                r32 = 1;
            L_0x03d9:
                r0 = r32;
                r1 = r30;
                r1.mGivenInsetsPending = r0;	 Catch:{ all -> 0x00e4 }
                r32 = 0;
                r0 = r36;
                r1 = r32;
                r8 = r0.updateOrientationFromAppTokensLocked(r1);	 Catch:{ all -> 0x00e4 }
                r36.performLayoutAndPlaceSurfacesLocked();	 Catch:{ all -> 0x00e4 }
                if (r27 == 0) goto L_0x0411;
            L_0x03ee:
                r0 = r30;
                r0 = r0.mIsWallpaper;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 == 0) goto L_0x0411;
            L_0x03f6:
                r10 = r36.getDefaultDisplayInfoLocked();	 Catch:{ all -> 0x00e4 }
                r0 = r10.logicalWidth;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r10.logicalHeight;	 Catch:{ all -> 0x00e4 }
                r34 = r0;
                r35 = 0;
                r0 = r36;
                r1 = r30;
                r2 = r32;
                r3 = r34;
                r4 = r35;
                r0.updateWallpaperOffsetLocked(r1, r2, r3, r4);	 Catch:{ all -> 0x00e4 }
            L_0x0411:
                r0 = r30;
                r0 = r0.mAppToken;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 == 0) goto L_0x0422;
            L_0x0419:
                r0 = r30;
                r0 = r0.mAppToken;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r32.updateReportedVisibilityLocked();	 Catch:{ all -> 0x00e4 }
            L_0x0422:
                r0 = r30;
                r0 = r0.mCompatFrame;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r45;
                r1 = r32;
                r0.set(r1);	 Catch:{ all -> 0x00e4 }
                r0 = r30;
                r0 = r0.mOverscanInsets;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r46;
                r1 = r32;
                r0.set(r1);	 Catch:{ all -> 0x00e4 }
                r0 = r30;
                r0 = r0.mContentInsets;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r47;
                r1 = r32;
                r0.set(r1);	 Catch:{ all -> 0x00e4 }
                r0 = r30;
                r0 = r0.mVisibleInsets;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r48;
                r1 = r32;
                r0.set(r1);	 Catch:{ all -> 0x00e4 }
                r0 = r30;
                r0 = r0.mStableInsets;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r49;
                r1 = r32;
                r0.set(r1);	 Catch:{ all -> 0x00e4 }
                r0 = r36;
                r0 = r0.mInTouchMode;	 Catch:{ all -> 0x00e4 }
                r16 = r0;
                r0 = r36;
                r0 = r0.mAnimator;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.mAnimating;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 == 0) goto L_0x062c;
            L_0x0477:
                r0 = r30;
                r0 = r0.mWinAnimator;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r32 = r32.isAnimating();	 Catch:{ all -> 0x00e4 }
                if (r32 == 0) goto L_0x062c;
            L_0x0483:
                r6 = 1;
            L_0x0484:
                if (r6 == 0) goto L_0x04a3;
            L_0x0486:
                r0 = r36;
                r0 = r0.mRelayoutWhileAnimating;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r30;
                r32 = r0.contains(r1);	 Catch:{ all -> 0x00e4 }
                if (r32 != 0) goto L_0x04a3;
            L_0x0496:
                r0 = r36;
                r0 = r0.mRelayoutWhileAnimating;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r30;
                r0.add(r1);	 Catch:{ all -> 0x00e4 }
            L_0x04a3:
                r0 = r36;
                r0 = r0.mInputMonitor;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r34 = 1;
                r0 = r32;
                r1 = r34;
                r0.updateInputWindowsLw(r1);	 Catch:{ all -> 0x00e4 }
                monitor-exit(r33);	 Catch:{ all -> 0x00e4 }
                if (r8 == 0) goto L_0x04b8;
            L_0x04b5:
                r36.sendNewConfiguration();
            L_0x04b8:
                android.os.Binder.restoreCallingIdentity(r20);
                if (r16 == 0) goto L_0x062f;
            L_0x04bd:
                r32 = 1;
                r33 = r32;
            L_0x04c1:
                if (r27 == 0) goto L_0x0635;
            L_0x04c3:
                r32 = 2;
            L_0x04c5:
                r33 = r33 | r32;
                if (r24 == 0) goto L_0x0639;
            L_0x04c9:
                r32 = 4;
            L_0x04cb:
                r33 = r33 | r32;
                if (r6 == 0) goto L_0x063d;
            L_0x04cf:
                r32 = 8;
            L_0x04d1:
                r32 = r32 | r33;
                goto L_0x0031;
            L_0x04d5:
                r32 = 0;
                goto L_0x0134;
            L_0x04d9:
                r23 = 0;
                goto L_0x0162;
            L_0x04dd:
                r32 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
                goto L_0x0182;
            L_0x04e1:
                r32 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
                goto L_0x01a6;
            L_0x04e5:
                r32 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
                r0 = r32;
                r1 = r30;
                r1.mVScale = r0;	 Catch:{ all -> 0x00e4 }
                r0 = r32;
                r1 = r30;
                r1.mHScale = r0;	 Catch:{ all -> 0x00e4 }
                goto L_0x01ac;
            L_0x04f5:
                r15 = 0;
                goto L_0x01b4;
            L_0x04f8:
                r13 = 0;
                goto L_0x01d3;
            L_0x04fb:
                r29 = 0;
                goto L_0x01f3;
            L_0x04ff:
                r32 = 0;
                goto L_0x01fb;
            L_0x0503:
                r27 = 0;
                goto L_0x0231;
            L_0x0507:
                r51.release();	 Catch:{ Exception -> 0x050c }
                goto L_0x02fb;
            L_0x050c:
                r11 = move-exception;
                r0 = r36;
                r0 = r0.mInputMonitor;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r34 = 1;
                r0 = r32;
                r1 = r34;
                r0.updateInputWindowsLw(r1);	 Catch:{ all -> 0x00e4 }
                r32 = "WindowManager";
                r34 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00e4 }
                r34.<init>();	 Catch:{ all -> 0x00e4 }
                r35 = "Exception thrown when creating surface for client ";
                r34 = r34.append(r35);	 Catch:{ all -> 0x00e4 }
                r0 = r34;
                r1 = r38;
                r34 = r0.append(r1);	 Catch:{ all -> 0x00e4 }
                r35 = " (";
                r34 = r34.append(r35);	 Catch:{ all -> 0x00e4 }
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r35 = r0;
                r35 = r35.getTitle();	 Catch:{ all -> 0x00e4 }
                r34 = r34.append(r35);	 Catch:{ all -> 0x00e4 }
                r35 = ")";
                r34 = r34.append(r35);	 Catch:{ all -> 0x00e4 }
                r34 = r34.toString();	 Catch:{ all -> 0x00e4 }
                r0 = r32;
                r1 = r34;
                android.util.Slog.w(r0, r1, r11);	 Catch:{ all -> 0x00e4 }
                android.os.Binder.restoreCallingIdentity(r20);	 Catch:{ all -> 0x00e4 }
                r32 = 0;
                monitor-exit(r33);	 Catch:{ all -> 0x00e4 }
                goto L_0x0031;
            L_0x055e:
                r32 = 0;
                r0 = r32;
                r1 = r31;
                r1.mEnterAnimationPending = r0;	 Catch:{ all -> 0x00e4 }
                r32 = 0;
                r0 = r32;
                r1 = r31;
                r1.mEnteringAnimation = r0;	 Catch:{ all -> 0x00e4 }
                r0 = r31;
                r0 = r0.mSurfaceControl;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 == 0) goto L_0x05d3;
            L_0x0576:
                r0 = r30;
                r0 = r0.mExiting;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 != 0) goto L_0x05d3;
            L_0x057e:
                r24 = 1;
                r28 = 2;
                r0 = r30;
                r0 = r0.mAttrs;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r0 = r0.type;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r34 = 3;
                r0 = r32;
                r1 = r34;
                if (r0 != r1) goto L_0x0598;
            L_0x0596:
                r28 = 5;
            L_0x0598:
                r32 = r30.isWinVisibleLw();	 Catch:{ all -> 0x00e4 }
                if (r32 == 0) goto L_0x05d8;
            L_0x059e:
                r32 = 0;
                r0 = r31;
                r1 = r28;
                r2 = r32;
                r32 = r0.applyAnimationLocked(r1, r2);	 Catch:{ all -> 0x00e4 }
                if (r32 == 0) goto L_0x05d8;
            L_0x05ac:
                r13 = r17;
                r32 = 1;
                r0 = r32;
                r1 = r30;
                r1.mExiting = r0;	 Catch:{ all -> 0x00e4 }
            L_0x05b6:
                r0 = r36;
                r0 = r0.mAccessibilityController;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                if (r32 == 0) goto L_0x05d3;
            L_0x05be:
                r32 = r30.getDisplayId();	 Catch:{ all -> 0x00e4 }
                if (r32 != 0) goto L_0x05d3;
            L_0x05c4:
                r0 = r36;
                r0 = r0.mAccessibilityController;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r30;
                r2 = r28;
                r0.onWindowTransitionLocked(r1, r2);	 Catch:{ all -> 0x00e4 }
            L_0x05d3:
                r51.release();	 Catch:{ all -> 0x00e4 }
                goto L_0x0385;
            L_0x05d8:
                r0 = r30;
                r0 = r0.mWinAnimator;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r32 = r32.isAnimating();	 Catch:{ all -> 0x00e4 }
                if (r32 == 0) goto L_0x05ed;
            L_0x05e4:
                r32 = 1;
                r0 = r32;
                r1 = r30;
                r1.mExiting = r0;	 Catch:{ all -> 0x00e4 }
                goto L_0x05b6;
            L_0x05ed:
                r0 = r36;
                r0 = r0.mWallpaperTarget;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r30;
                r1 = r32;
                if (r0 != r1) goto L_0x0610;
            L_0x05f9:
                r32 = 1;
                r0 = r32;
                r1 = r30;
                r1.mExiting = r0;	 Catch:{ all -> 0x00e4 }
                r0 = r30;
                r0 = r0.mWinAnimator;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r34 = 1;
                r0 = r34;
                r1 = r32;
                r1.mAnimating = r0;	 Catch:{ all -> 0x00e4 }
                goto L_0x05b6;
            L_0x0610:
                r0 = r36;
                r0 = r0.mInputMethodWindow;	 Catch:{ all -> 0x00e4 }
                r32 = r0;
                r0 = r32;
                r1 = r30;
                if (r0 != r1) goto L_0x0624;
            L_0x061c:
                r32 = 0;
                r0 = r32;
                r1 = r36;
                r1.mInputMethodWindow = r0;	 Catch:{ all -> 0x00e4 }
            L_0x0624:
                r31.destroySurfaceLocked();	 Catch:{ all -> 0x00e4 }
                goto L_0x05b6;
            L_0x0628:
                r32 = 0;
                goto L_0x03d9;
            L_0x062c:
                r6 = 0;
                goto L_0x0484;
            L_0x062f:
                r32 = 0;
                r33 = r32;
                goto L_0x04c1;
            L_0x0635:
                r32 = 0;
                goto L_0x04c5;
            L_0x0639:
                r32 = 0;
                goto L_0x04cb;
            L_0x063d:
                r32 = 0;
                goto L_0x04d1;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.relayoutWindow(com.android.server.wm.Session, android.view.IWindow, int, android.view.WindowManager$LayoutParams, int, int, int, int, android.graphics.Rect, android.graphics.Rect, android.graphics.Rect, android.graphics.Rect, android.graphics.Rect, android.content.res.Configuration, android.view.Surface):int");
            }

            public void performDeferredDestroyWindow(Session session, IWindow client) {
                long origId = Binder.clearCallingIdentity();
                try {
                    synchronized (this.mWindowMap) {
                        WindowState win = windowForClientLocked(session, client, (boolean) SHOW_TRANSACTIONS);
                        if (win == null) {
                            return;
                        }
                        win.mWinAnimator.destroyDeferredSurfaceLocked();
                        Binder.restoreCallingIdentity(origId);
                    }
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }

            public boolean outOfMemoryWindow(Session session, IWindow client) {
                boolean z = SHOW_TRANSACTIONS;
                long origId = Binder.clearCallingIdentity();
                try {
                    synchronized (this.mWindowMap) {
                        WindowState win = windowForClientLocked(session, client, (boolean) SHOW_TRANSACTIONS);
                        if (win == null) {
                        } else {
                            z = reclaimSomeSurfaceMemoryLocked(win.mWinAnimator, "from-client", SHOW_TRANSACTIONS);
                            Binder.restoreCallingIdentity(origId);
                        }
                    }
                    return z;
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }

            public void finishDrawingWindow(Session session, IWindow client) {
                long origId = Binder.clearCallingIdentity();
                try {
                    synchronized (this.mWindowMap) {
                        WindowState win = windowForClientLocked(session, client, (boolean) SHOW_TRANSACTIONS);
                        if (win != null && win.mWinAnimator.finishDrawingLocked()) {
                            if ((win.mAttrs.flags & 1048576) != 0) {
                                DisplayContent defaultDisplayContentLocked = getDefaultDisplayContentLocked();
                                defaultDisplayContentLocked.pendingLayoutChanges |= LAYOUT_REPEAT_THRESHOLD;
                            }
                            DisplayContent displayContent = win.getDisplayContent();
                            if (displayContent != null) {
                                displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                            }
                            requestTraversalLocked();
                        }
                    }
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }

            private boolean applyAnimationLocked(AppWindowToken atoken, LayoutParams lp, int transit, boolean enter, boolean isVoiceInteraction) {
                if (okToDisplay()) {
                    DisplayInfo displayInfo = getDefaultDisplayInfoLocked();
                    int width = displayInfo.appWidth;
                    int height = displayInfo.appHeight;
                    WindowState win = atoken.findMainWindow();
                    Rect containingFrame = new Rect(WALLPAPER_DRAW_NORMAL, WALLPAPER_DRAW_NORMAL, width, height);
                    Rect contentInsets = new Rect();
                    boolean isFullScreen = HIDE_STACK_CRAWLS;
                    if (win != null) {
                        if (win.mContainingFrame != null) {
                            containingFrame.set(win.mContainingFrame);
                        }
                        if (win.mContentInsets != null) {
                            contentInsets.set(win.mContentInsets);
                        }
                        isFullScreen = ((win.mSystemUiVisibility & SYSTEM_UI_FLAGS_LAYOUT_STABLE_FULLSCREEN) == SYSTEM_UI_FLAGS_LAYOUT_STABLE_FULLSCREEN || (win.mAttrs.flags & SoundTriggerHelper.STATUS_ERROR) != 0) ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                    }
                    if (atoken.mLaunchTaskBehind) {
                        enter = SHOW_TRANSACTIONS;
                    }
                    Animation a = this.mAppTransition.loadAnimation(lp, transit, enter, width, height, this.mCurConfiguration.orientation, containingFrame, contentInsets, isFullScreen, isVoiceInteraction);
                    if (a != null) {
                        atoken.mAppAnimator.setAnimation(a, width, height);
                    }
                } else {
                    atoken.mAppAnimator.clearAnimation();
                }
                if (atoken.mAppAnimator.animation != null) {
                    return HIDE_STACK_CRAWLS;
                }
                return SHOW_TRANSACTIONS;
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public void validateAppTokens(int r20, java.util.List<com.android.server.wm.TaskGroup> r21) {
                /*
                r19 = this;
                r0 = r19;
                r0 = r0.mWindowMap;
                r16 = r0;
                monitor-enter(r16);
                r15 = r21.size();	 Catch:{ all -> 0x0053 }
                r7 = r15 + -1;
                if (r7 >= 0) goto L_0x001a;
            L_0x000f:
                r15 = "WindowManager";
                r17 = "validateAppTokens: empty task list";
                r0 = r17;
                android.util.Slog.w(r15, r0);	 Catch:{ all -> 0x0053 }
                monitor-exit(r16);	 Catch:{ all -> 0x0053 }
            L_0x0019:
                return;
            L_0x001a:
                r15 = 0;
                r0 = r21;
                r9 = r0.get(r15);	 Catch:{ all -> 0x0053 }
                r9 = (com.android.server.wm.TaskGroup) r9;	 Catch:{ all -> 0x0053 }
                r10 = r9.taskId;	 Catch:{ all -> 0x0053 }
                r0 = r19;
                r15 = r0.mTaskIdToTask;	 Catch:{ all -> 0x0053 }
                r8 = r15.get(r10);	 Catch:{ all -> 0x0053 }
                r8 = (com.android.server.wm.Task) r8;	 Catch:{ all -> 0x0053 }
                r3 = r8.getDisplayContent();	 Catch:{ all -> 0x0053 }
                if (r3 != 0) goto L_0x0056;
            L_0x0035:
                r15 = "WindowManager";
                r17 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0053 }
                r17.<init>();	 Catch:{ all -> 0x0053 }
                r18 = "validateAppTokens: no Display for taskId=";
                r17 = r17.append(r18);	 Catch:{ all -> 0x0053 }
                r0 = r17;
                r17 = r0.append(r10);	 Catch:{ all -> 0x0053 }
                r17 = r17.toString();	 Catch:{ all -> 0x0053 }
                r0 = r17;
                android.util.Slog.w(r15, r0);	 Catch:{ all -> 0x0053 }
                monitor-exit(r16);	 Catch:{ all -> 0x0053 }
                goto L_0x0019;
            L_0x0053:
                r15 = move-exception;
                monitor-exit(r16);	 Catch:{ all -> 0x0053 }
                throw r15;
            L_0x0056:
                r0 = r19;
                r15 = r0.mStackIdToStack;	 Catch:{ all -> 0x0053 }
                r0 = r20;
                r15 = r15.get(r0);	 Catch:{ all -> 0x0053 }
                r15 = (com.android.server.wm.TaskStack) r15;	 Catch:{ all -> 0x0053 }
                r5 = r15.getTasks();	 Catch:{ all -> 0x0053 }
                r15 = r5.size();	 Catch:{ all -> 0x0053 }
                r11 = r15 + -1;
            L_0x006c:
                if (r11 < 0) goto L_0x00ce;
            L_0x006e:
                if (r7 < 0) goto L_0x00ce;
            L_0x0070:
                r15 = r5.get(r11);	 Catch:{ all -> 0x0053 }
                r15 = (com.android.server.wm.Task) r15;	 Catch:{ all -> 0x0053 }
                r6 = r15.mAppTokens;	 Catch:{ all -> 0x0053 }
                r0 = r21;
                r9 = r0.get(r7);	 Catch:{ all -> 0x0053 }
                r9 = (com.android.server.wm.TaskGroup) r9;	 Catch:{ all -> 0x0053 }
                r13 = r9.tokens;	 Catch:{ all -> 0x0053 }
                r4 = r3;
                r0 = r19;
                r15 = r0.mTaskIdToTask;	 Catch:{ all -> 0x0053 }
                r15 = r15.get(r10);	 Catch:{ all -> 0x0053 }
                r15 = (com.android.server.wm.Task) r15;	 Catch:{ all -> 0x0053 }
                r3 = r15.getDisplayContent();	 Catch:{ all -> 0x0053 }
                if (r3 == r4) goto L_0x009f;
            L_0x0093:
                r15 = "WindowManager";
                r17 = "validateAppTokens: displayContent changed in TaskGroup list!";
                r0 = r17;
                android.util.Slog.w(r15, r0);	 Catch:{ all -> 0x0053 }
                monitor-exit(r16);	 Catch:{ all -> 0x0053 }
                goto L_0x0019;
            L_0x009f:
                r15 = r6.size();	 Catch:{ all -> 0x0053 }
                r12 = r15 + -1;
                r15 = r9.tokens;	 Catch:{ all -> 0x0053 }
                r15 = r15.size();	 Catch:{ all -> 0x0053 }
                r14 = r15 + -1;
            L_0x00ad:
                if (r12 < 0) goto L_0x00ca;
            L_0x00af:
                if (r14 < 0) goto L_0x00ca;
            L_0x00b1:
                r2 = r6.get(r12);	 Catch:{ all -> 0x0053 }
                r2 = (com.android.server.wm.AppWindowToken) r2;	 Catch:{ all -> 0x0053 }
                r15 = r2.removed;	 Catch:{ all -> 0x0053 }
                if (r15 == 0) goto L_0x00be;
            L_0x00bb:
                r12 = r12 + -1;
                goto L_0x00ad;
            L_0x00be:
                r15 = r13.get(r14);	 Catch:{ all -> 0x0053 }
                r0 = r2.token;	 Catch:{ all -> 0x0053 }
                r17 = r0;
                r0 = r17;
                if (r15 == r0) goto L_0x012f;
            L_0x00ca:
                if (r12 >= 0) goto L_0x00ce;
            L_0x00cc:
                if (r14 < 0) goto L_0x0135;
            L_0x00ce:
                if (r11 >= 0) goto L_0x00d2;
            L_0x00d0:
                if (r7 < 0) goto L_0x012c;
            L_0x00d2:
                r15 = "WindowManager";
                r17 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0053 }
                r17.<init>();	 Catch:{ all -> 0x0053 }
                r18 = "validateAppTokens: Mismatch! ActivityManager=";
                r17 = r17.append(r18);	 Catch:{ all -> 0x0053 }
                r0 = r17;
                r1 = r21;
                r17 = r0.append(r1);	 Catch:{ all -> 0x0053 }
                r17 = r17.toString();	 Catch:{ all -> 0x0053 }
                r0 = r17;
                android.util.Slog.w(r15, r0);	 Catch:{ all -> 0x0053 }
                r15 = "WindowManager";
                r17 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0053 }
                r17.<init>();	 Catch:{ all -> 0x0053 }
                r18 = "validateAppTokens: Mismatch! WindowManager=";
                r17 = r17.append(r18);	 Catch:{ all -> 0x0053 }
                r0 = r17;
                r17 = r0.append(r5);	 Catch:{ all -> 0x0053 }
                r17 = r17.toString();	 Catch:{ all -> 0x0053 }
                r0 = r17;
                android.util.Slog.w(r15, r0);	 Catch:{ all -> 0x0053 }
                r15 = "WindowManager";
                r17 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0053 }
                r17.<init>();	 Catch:{ all -> 0x0053 }
                r18 = "validateAppTokens: Mismatch! Callers=";
                r17 = r17.append(r18);	 Catch:{ all -> 0x0053 }
                r18 = 4;
                r18 = android.os.Debug.getCallers(r18);	 Catch:{ all -> 0x0053 }
                r17 = r17.append(r18);	 Catch:{ all -> 0x0053 }
                r17 = r17.toString();	 Catch:{ all -> 0x0053 }
                r0 = r17;
                android.util.Slog.w(r15, r0);	 Catch:{ all -> 0x0053 }
            L_0x012c:
                monitor-exit(r16);	 Catch:{ all -> 0x0053 }
                goto L_0x0019;
            L_0x012f:
                r12 = r12 + -1;
                r14 = r14 + -1;
                goto L_0x00ad;
            L_0x0135:
                r11 = r11 + -1;
                r7 = r7 + -1;
                goto L_0x006c;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.validateAppTokens(int, java.util.List):void");
            }

            public void validateStackOrder(Integer[] remoteStackIds) {
            }

            boolean checkCallingPermission(String permission, String func) {
                if (Binder.getCallingPid() == Process.myPid() || this.mContext.checkCallingPermission(permission) == 0) {
                    return HIDE_STACK_CRAWLS;
                }
                Slog.w(TAG, "Permission Denial: " + func + " from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + permission);
                return SHOW_TRANSACTIONS;
            }

            boolean okToDisplay() {
                return (!this.mDisplayFrozen && this.mDisplayEnabled && this.mPolicy.isScreenOn()) ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
            }

            AppWindowToken findAppWindowToken(IBinder token) {
                WindowToken wtoken = (WindowToken) this.mTokenMap.get(token);
                if (wtoken == null) {
                    return null;
                }
                return wtoken.appWindowToken;
            }

            public void addWindowToken(IBinder token, int type) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "addWindowToken()")) {
                    synchronized (this.mWindowMap) {
                        if (((WindowToken) this.mTokenMap.get(token)) != null) {
                            Slog.w(TAG, "Attempted to add existing input method token: " + token);
                            return;
                        }
                        WindowToken wtoken = new WindowToken(this, token, type, HIDE_STACK_CRAWLS);
                        this.mTokenMap.put(token, wtoken);
                        if (type == 2013) {
                            this.mWallpaperTokens.add(wtoken);
                        }
                        return;
                    }
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public void removeWindowToken(IBinder token) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "removeWindowToken()")) {
                    long origId = Binder.clearCallingIdentity();
                    synchronized (this.mWindowMap) {
                        DisplayContent displayContent = null;
                        WindowToken wtoken = (WindowToken) this.mTokenMap.remove(token);
                        if (wtoken != null) {
                            boolean delayed = SHOW_TRANSACTIONS;
                            if (!wtoken.hidden) {
                                int N = wtoken.windows.size();
                                boolean changed = SHOW_TRANSACTIONS;
                                for (int i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                                    WindowState win = (WindowState) wtoken.windows.get(i);
                                    displayContent = win.getDisplayContent();
                                    if (win.mWinAnimator.isAnimating()) {
                                        delayed = HIDE_STACK_CRAWLS;
                                    }
                                    if (win.isVisibleNow()) {
                                        win.mWinAnimator.applyAnimationLocked(WALLPAPER_DRAW_TIMEOUT, SHOW_TRANSACTIONS);
                                        if (this.mAccessibilityController != null && win.isDefaultDisplay()) {
                                            this.mAccessibilityController.onWindowTransitionLocked(win, WALLPAPER_DRAW_TIMEOUT);
                                        }
                                        changed = HIDE_STACK_CRAWLS;
                                        if (displayContent != null) {
                                            displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                                        }
                                    }
                                }
                                wtoken.hidden = HIDE_STACK_CRAWLS;
                                if (changed) {
                                    performLayoutAndPlaceSurfacesLocked();
                                    updateFocusedWindowLocked(WALLPAPER_DRAW_NORMAL, SHOW_TRANSACTIONS);
                                }
                                if (delayed) {
                                    if (displayContent != null) {
                                        displayContent.mExitingTokens.add(wtoken);
                                    }
                                } else if (wtoken.windowType == 2013) {
                                    this.mWallpaperTokens.remove(wtoken);
                                }
                            }
                            this.mInputMonitor.updateInputWindowsLw(HIDE_STACK_CRAWLS);
                        } else {
                            Slog.w(TAG, "Attempted to remove non-existing token: " + token);
                        }
                    }
                    Binder.restoreCallingIdentity(origId);
                    return;
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            private Task createTask(int taskId, int stackId, int userId, AppWindowToken atoken) {
                boolean z = HIDE_STACK_CRAWLS;
                TaskStack stack = (TaskStack) this.mStackIdToStack.get(stackId);
                if (stack == null) {
                    throw new IllegalArgumentException("addAppToken: invalid stackId=" + stackId);
                }
                Object[] objArr = new Object[WALLPAPER_DRAW_TIMEOUT];
                objArr[WALLPAPER_DRAW_NORMAL] = Integer.valueOf(taskId);
                objArr[WALLPAPER_DRAW_PENDING] = Integer.valueOf(stackId);
                EventLog.writeEvent(EventLogTags.WM_TASK_CREATED, objArr);
                Task task = new Task(atoken, stack, userId);
                this.mTaskIdToTask.put(taskId, task);
                if (atoken.mLaunchTaskBehind) {
                    z = SHOW_TRANSACTIONS;
                }
                stack.addTask(task, z);
                return task;
            }

            public void addAppToken(int addPos, IApplicationToken token, int taskId, int stackId, int requestedOrientation, boolean fullscreen, boolean showWhenLocked, int userId, int configChanges, boolean voiceInteraction, boolean launchTaskBehind) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "addAppToken()")) {
                    long inputDispatchingTimeoutNanos;
                    try {
                        inputDispatchingTimeoutNanos = token.getKeyDispatchingTimeout() * 1000000;
                    } catch (RemoteException ex) {
                        Slog.w(TAG, "Could not get dispatching timeout.", ex);
                        inputDispatchingTimeoutNanos = DEFAULT_INPUT_DISPATCHING_TIMEOUT_NANOS;
                    }
                    synchronized (this.mWindowMap) {
                        if (findAppWindowToken(token.asBinder()) != null) {
                            Slog.w(TAG, "Attempted to add existing app token: " + token);
                            return;
                        }
                        AppWindowToken atoken = new AppWindowToken(this, token, voiceInteraction);
                        atoken.inputDispatchingTimeoutNanos = inputDispatchingTimeoutNanos;
                        atoken.groupId = taskId;
                        atoken.appFullscreen = fullscreen;
                        atoken.showWhenLocked = showWhenLocked;
                        atoken.requestedOrientation = requestedOrientation;
                        atoken.layoutConfigChanges = (configChanges & 1152) != 0 ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                        atoken.mLaunchTaskBehind = launchTaskBehind;
                        Slog.v(TAG, "addAppToken: " + atoken + " to stack=" + stackId + " task=" + taskId + " at " + addPos);
                        Task task = (Task) this.mTaskIdToTask.get(taskId);
                        if (task == null) {
                            createTask(taskId, stackId, userId, atoken);
                        } else {
                            task.addAppToken(addPos, atoken);
                        }
                        this.mTokenMap.put(token.asBinder(), atoken);
                        atoken.hidden = HIDE_STACK_CRAWLS;
                        atoken.hiddenRequested = HIDE_STACK_CRAWLS;
                        return;
                    }
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public void setAppGroupId(IBinder token, int groupId) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "setAppGroupId()")) {
                    synchronized (this.mWindowMap) {
                        AppWindowToken atoken = findAppWindowToken(token);
                        if (atoken == null) {
                            Slog.w(TAG, "Attempted to set group id of non-existing app token: " + token);
                            return;
                        }
                        Task oldTask = (Task) this.mTaskIdToTask.get(atoken.groupId);
                        oldTask.removeAppToken(atoken);
                        atoken.groupId = groupId;
                        Task newTask = (Task) this.mTaskIdToTask.get(groupId);
                        if (newTask == null) {
                            newTask = createTask(groupId, oldTask.mStack.mStackId, oldTask.mUserId, atoken);
                        } else {
                            newTask.mAppTokens.add(atoken);
                        }
                        return;
                    }
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public int getOrientationLocked() {
                if (this.mDisplayFrozen) {
                    int i = this.mLastWindowForcedOrientation;
                    if (r0 != -1) {
                        return this.mLastWindowForcedOrientation;
                    }
                }
                WindowList windows = getDefaultWindowListLocked();
                int pos = windows.size() - 1;
                while (pos >= 0) {
                    int req;
                    WindowState win = (WindowState) windows.get(pos);
                    pos--;
                    if (win.mAppToken != null) {
                        break;
                    } else if (win.isVisibleLw() && win.mPolicyVisibilityAfterAnim) {
                        req = win.mAttrs.screenOrientation;
                        if (!(req == -1 || req == UPDATE_FOCUS_WILL_PLACE_SURFACES)) {
                            if (this.mPolicy.isKeyguardHostWindow(win.mAttrs)) {
                                this.mLastKeyguardForcedOrientation = req;
                            }
                            this.mLastWindowForcedOrientation = req;
                            return req;
                        }
                    }
                }
                this.mLastWindowForcedOrientation = -1;
                if (this.mPolicy.isKeyguardLocked()) {
                    AppWindowToken appShowWhenLocked;
                    WindowState winShowWhenLocked = (WindowState) this.mPolicy.getWinShowWhenLockedLw();
                    if (winShowWhenLocked == null) {
                        appShowWhenLocked = null;
                    } else {
                        appShowWhenLocked = winShowWhenLocked.mAppToken;
                    }
                    if (appShowWhenLocked == null) {
                        return this.mLastKeyguardForcedOrientation;
                    }
                    req = appShowWhenLocked.requestedOrientation;
                    if (req == UPDATE_FOCUS_WILL_PLACE_SURFACES) {
                        return this.mLastKeyguardForcedOrientation;
                    }
                    return req;
                }
                int lastOrientation = -1;
                boolean findingBehind = SHOW_TRANSACTIONS;
                boolean lastFullscreen = SHOW_TRANSACTIONS;
                ArrayList<Task> tasks = getDefaultDisplayContentLocked().getTasks();
                for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
                    AppTokenList tokens = ((Task) tasks.get(taskNdx)).mAppTokens;
                    int firstToken = tokens.size() - 1;
                    for (int tokenNdx = firstToken; tokenNdx >= 0; tokenNdx--) {
                        AppWindowToken atoken = (AppWindowToken) tokens.get(tokenNdx);
                        if (findingBehind || atoken.hidden || !atoken.hiddenRequested) {
                            if (tokenNdx == firstToken && lastOrientation != UPDATE_FOCUS_WILL_PLACE_SURFACES && lastFullscreen) {
                                return lastOrientation;
                            }
                            if (!(atoken.hiddenRequested || atoken.willBeHidden)) {
                                if (tokenNdx == 0) {
                                    lastOrientation = atoken.requestedOrientation;
                                }
                                int or = atoken.requestedOrientation;
                                lastFullscreen = atoken.appFullscreen;
                                if (lastFullscreen && or != UPDATE_FOCUS_WILL_PLACE_SURFACES) {
                                    return or;
                                }
                                if (or != -1 && or != UPDATE_FOCUS_WILL_PLACE_SURFACES) {
                                    return or;
                                }
                                findingBehind |= or == UPDATE_FOCUS_WILL_PLACE_SURFACES ? WALLPAPER_DRAW_PENDING : WALLPAPER_DRAW_NORMAL;
                            }
                        }
                    }
                }
                return this.mForcedAppOrientation;
            }

            public Configuration updateOrientationFromAppTokens(Configuration currentConfig, IBinder freezeThisOneIfNeeded) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "updateOrientationFromAppTokens()")) {
                    Configuration config;
                    long ident = Binder.clearCallingIdentity();
                    synchronized (this.mWindowMap) {
                        config = updateOrientationFromAppTokensLocked(currentConfig, freezeThisOneIfNeeded);
                    }
                    Binder.restoreCallingIdentity(ident);
                    return config;
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            private Configuration updateOrientationFromAppTokensLocked(Configuration currentConfig, IBinder freezeThisOneIfNeeded) {
                if (updateOrientationFromAppTokensLocked(SHOW_TRANSACTIONS)) {
                    if (freezeThisOneIfNeeded != null) {
                        AppWindowToken atoken = findAppWindowToken(freezeThisOneIfNeeded);
                        if (atoken != null) {
                            startAppFreezingScreenLocked(atoken);
                        }
                    }
                    return computeNewConfigurationLocked();
                } else if (currentConfig == null) {
                    return null;
                } else {
                    this.mTempConfiguration.setToDefaults();
                    this.mTempConfiguration.fontScale = currentConfig.fontScale;
                    if (!computeScreenConfigurationLocked(this.mTempConfiguration) || currentConfig.diff(this.mTempConfiguration) == 0) {
                        return null;
                    }
                    this.mWaitingForConfig = HIDE_STACK_CRAWLS;
                    DisplayContent displayContent = getDefaultDisplayContentLocked();
                    displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                    int[] anim = new int[WALLPAPER_DRAW_TIMEOUT];
                    if (displayContent.isDimming()) {
                        anim[WALLPAPER_DRAW_PENDING] = WALLPAPER_DRAW_NORMAL;
                        anim[WALLPAPER_DRAW_NORMAL] = WALLPAPER_DRAW_NORMAL;
                    } else {
                        this.mPolicy.selectRotationAnimationLw(anim);
                    }
                    startFreezingDisplayLocked(SHOW_TRANSACTIONS, anim[WALLPAPER_DRAW_NORMAL], anim[WALLPAPER_DRAW_PENDING]);
                    return new Configuration(this.mTempConfiguration);
                }
            }

            boolean updateOrientationFromAppTokensLocked(boolean inTransaction) {
                long ident = Binder.clearCallingIdentity();
                try {
                    int req = getOrientationLocked();
                    if (req != this.mForcedAppOrientation) {
                        this.mForcedAppOrientation = req;
                        this.mPolicy.setCurrentOrientationLw(req);
                        if (updateRotationUncheckedLocked(inTransaction)) {
                            return HIDE_STACK_CRAWLS;
                        }
                    }
                    Binder.restoreCallingIdentity(ident);
                    return SHOW_TRANSACTIONS;
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            }

            public void setNewConfiguration(Configuration config) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "setNewConfiguration()")) {
                    synchronized (this.mWindowMap) {
                        this.mCurConfiguration = new Configuration(config);
                        if (this.mWaitingForConfig) {
                            this.mWaitingForConfig = SHOW_TRANSACTIONS;
                            this.mLastFinishedFreezeSource = "new-config";
                        }
                        performLayoutAndPlaceSurfacesLocked();
                    }
                    return;
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public void setAppOrientation(IApplicationToken token, int requestedOrientation) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "setAppOrientation()")) {
                    synchronized (this.mWindowMap) {
                        AppWindowToken atoken = findAppWindowToken(token.asBinder());
                        if (atoken == null) {
                            Slog.w(TAG, "Attempted to set orientation of non-existing app token: " + token);
                            return;
                        }
                        atoken.requestedOrientation = requestedOrientation;
                        return;
                    }
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public int getAppOrientation(IApplicationToken token) {
                int i;
                synchronized (this.mWindowMap) {
                    AppWindowToken wtoken = findAppWindowToken(token.asBinder());
                    if (wtoken == null) {
                        i = -1;
                    } else {
                        i = wtoken.requestedOrientation;
                    }
                }
                return i;
            }

            void setFocusedStackLayer() {
                this.mFocusedStackLayer = WALLPAPER_DRAW_NORMAL;
                if (this.mFocusedApp != null) {
                    WindowList windows = this.mFocusedApp.allAppWindows;
                    for (int i = windows.size() - 1; i >= 0; i--) {
                        WindowState win = (WindowState) windows.get(i);
                        int animLayer = win.mWinAnimator.mAnimLayer;
                        if (win.mAttachedWindow == null && win.isVisibleLw() && animLayer > this.mFocusedStackLayer) {
                            this.mFocusedStackLayer = animLayer + WALLPAPER_DRAW_PENDING;
                        }
                    }
                }
                this.mFocusedStackFrame.setLayer(this.mFocusedStackLayer);
            }

            void setFocusedStackFrame() {
                TaskStack stack;
                boolean multipleStacks = SHOW_TRANSACTIONS;
                if (this.mFocusedApp != null) {
                    Task task = (Task) this.mTaskIdToTask.get(this.mFocusedApp.groupId);
                    stack = task.mStack;
                    DisplayContent displayContent = task.getDisplayContent();
                    if (displayContent != null) {
                        displayContent.setTouchExcludeRegion(stack);
                    }
                } else {
                    stack = null;
                }
                SurfaceControl.openTransaction();
                if (stack == null) {
                    try {
                        this.mFocusedStackFrame.setVisibility(SHOW_TRANSACTIONS);
                    } catch (Throwable th) {
                        SurfaceControl.closeTransaction();
                    }
                } else {
                    this.mFocusedStackFrame.setBounds(stack);
                    if (!stack.isFullscreen()) {
                        multipleStacks = HIDE_STACK_CRAWLS;
                    }
                    this.mFocusedStackFrame.setVisibility(multipleStacks);
                }
                SurfaceControl.closeTransaction();
            }

            public void setFocusedApp(IBinder token, boolean moveFocusNow) {
                boolean changed = HIDE_STACK_CRAWLS;
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "setFocusedApp()")) {
                    synchronized (this.mWindowMap) {
                        AppWindowToken newFocus;
                        if (token == null) {
                            newFocus = null;
                        } else {
                            newFocus = findAppWindowToken(token);
                            if (newFocus == null) {
                                Slog.w(TAG, "Attempted to set focus to non-existing app token: " + token);
                            }
                        }
                        if (this.mFocusedApp == newFocus) {
                            changed = SHOW_TRANSACTIONS;
                        }
                        if (changed) {
                            this.mFocusedApp = newFocus;
                            this.mInputMonitor.setFocusedAppLw(newFocus);
                            setFocusedStackFrame();
                            SurfaceControl.openTransaction();
                            try {
                                setFocusedStackLayer();
                            } finally {
                                SurfaceControl.closeTransaction();
                            }
                        }
                        if (moveFocusNow && changed) {
                            long origId = Binder.clearCallingIdentity();
                            updateFocusedWindowLocked(WALLPAPER_DRAW_NORMAL, HIDE_STACK_CRAWLS);
                            Binder.restoreCallingIdentity(origId);
                        }
                    }
                    return;
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public void prepareAppTransition(int transit, boolean alwaysKeepCurrent) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "prepareAppTransition()")) {
                    synchronized (this.mWindowMap) {
                        if (!this.mAppTransition.isTransitionSet() || this.mAppTransition.isTransitionNone()) {
                            this.mAppTransition.setAppTransition(transit);
                        } else if (!alwaysKeepCurrent) {
                            if (transit == 8 && this.mAppTransition.isTransitionEqual(9)) {
                                this.mAppTransition.setAppTransition(transit);
                            } else if (transit == 6) {
                                if (this.mAppTransition.isTransitionEqual(7)) {
                                    this.mAppTransition.setAppTransition(transit);
                                }
                            }
                        }
                        if (okToDisplay()) {
                            this.mAppTransition.prepare();
                            this.mStartingIconInTransition = SHOW_TRANSACTIONS;
                            this.mSkipAppTransitionAnimation = SHOW_TRANSACTIONS;
                        }
                        if (this.mAppTransition.isTransitionSet()) {
                            this.mH.removeMessages(13);
                            this.mH.sendEmptyMessageDelayed(13, 5000);
                        }
                    }
                    return;
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public int getPendingAppTransition() {
                return this.mAppTransition.getAppTransition();
            }

            public void overridePendingAppTransition(String packageName, int enterAnim, int exitAnim, IRemoteCallback startedCallback) {
                synchronized (this.mWindowMap) {
                    this.mAppTransition.overridePendingAppTransition(packageName, enterAnim, exitAnim, startedCallback);
                }
            }

            public void overridePendingAppTransitionScaleUp(int startX, int startY, int startWidth, int startHeight) {
                synchronized (this.mWindowMap) {
                    this.mAppTransition.overridePendingAppTransitionScaleUp(startX, startY, startWidth, startHeight);
                }
            }

            public void overridePendingAppTransitionThumb(Bitmap srcThumb, int startX, int startY, IRemoteCallback startedCallback, boolean scaleUp) {
                synchronized (this.mWindowMap) {
                    this.mAppTransition.overridePendingAppTransitionThumb(srcThumb, startX, startY, startedCallback, scaleUp);
                }
            }

            public void overridePendingAppTransitionAspectScaledThumb(Bitmap srcThumb, int startX, int startY, int targetWidth, int targetHeight, IRemoteCallback startedCallback, boolean scaleUp) {
                synchronized (this.mWindowMap) {
                    this.mAppTransition.overridePendingAppTransitionAspectScaledThumb(srcThumb, startX, startY, targetWidth, targetHeight, startedCallback, scaleUp);
                }
            }

            public void overridePendingAppTransitionInPlace(String packageName, int anim) {
                synchronized (this.mWindowMap) {
                    this.mAppTransition.overrideInPlaceAppTransition(packageName, anim);
                }
            }

            public void executeAppTransition() {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "executeAppTransition()")) {
                    synchronized (this.mWindowMap) {
                        if (this.mAppTransition.isTransitionSet()) {
                            this.mAppTransition.setReady();
                            long origId = Binder.clearCallingIdentity();
                            try {
                                performLayoutAndPlaceSurfacesLocked();
                                Binder.restoreCallingIdentity(origId);
                            } catch (Throwable th) {
                                Binder.restoreCallingIdentity(origId);
                            }
                        }
                    }
                    return;
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public void setAppStartingWindow(IBinder token, String pkg, int theme, CompatibilityInfo compatInfo, CharSequence nonLocalizedLabel, int labelRes, int icon, int logo, int windowFlags, IBinder transferFrom, boolean createIfNeeded) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "setAppStartingWindow()")) {
                    synchronized (this.mWindowMap) {
                        WindowToken wtoken = findAppWindowToken(token);
                        if (wtoken == null) {
                            Slog.w(TAG, "Attempted to set icon of non-existing app token: " + token);
                            return;
                        } else if (!okToDisplay()) {
                            return;
                        } else if (wtoken.startingData != null) {
                            return;
                        } else {
                            if (transferFrom != null) {
                                AppWindowToken ttoken = findAppWindowToken(transferFrom);
                                if (ttoken != null) {
                                    WindowState startingWindow = ttoken.startingWindow;
                                    AppWindowAnimator tAppAnimator;
                                    AppWindowAnimator wAppAnimator;
                                    if (startingWindow != null) {
                                        if (this.mStartingIconInTransition) {
                                            this.mSkipAppTransitionAnimation = HIDE_STACK_CRAWLS;
                                        }
                                        long origId = Binder.clearCallingIdentity();
                                        wtoken.startingData = ttoken.startingData;
                                        wtoken.startingView = ttoken.startingView;
                                        wtoken.startingDisplayed = ttoken.startingDisplayed;
                                        ttoken.startingDisplayed = SHOW_TRANSACTIONS;
                                        wtoken.startingWindow = startingWindow;
                                        wtoken.reportedVisible = ttoken.reportedVisible;
                                        ttoken.startingData = null;
                                        ttoken.startingView = null;
                                        ttoken.startingWindow = null;
                                        ttoken.startingMoved = HIDE_STACK_CRAWLS;
                                        startingWindow.mToken = wtoken;
                                        startingWindow.mRootToken = wtoken;
                                        startingWindow.mAppToken = wtoken;
                                        startingWindow.mWinAnimator.mAppAnimator = wtoken.mAppAnimator;
                                        startingWindow.getWindowList().remove(startingWindow);
                                        this.mWindowsChanged = HIDE_STACK_CRAWLS;
                                        ttoken.windows.remove(startingWindow);
                                        ttoken.allAppWindows.remove(startingWindow);
                                        addWindowToListInOrderLocked(startingWindow, HIDE_STACK_CRAWLS);
                                        if (ttoken.allDrawn) {
                                            wtoken.allDrawn = HIDE_STACK_CRAWLS;
                                            wtoken.deferClearAllDrawn = ttoken.deferClearAllDrawn;
                                        }
                                        if (ttoken.firstWindowDrawn) {
                                            wtoken.firstWindowDrawn = HIDE_STACK_CRAWLS;
                                        }
                                        if (!ttoken.hidden) {
                                            wtoken.hidden = SHOW_TRANSACTIONS;
                                            wtoken.hiddenRequested = SHOW_TRANSACTIONS;
                                            wtoken.willBeHidden = SHOW_TRANSACTIONS;
                                        }
                                        if (wtoken.clientHidden != ttoken.clientHidden) {
                                            wtoken.clientHidden = ttoken.clientHidden;
                                            wtoken.sendAppVisibilityToClients();
                                        }
                                        tAppAnimator = ttoken.mAppAnimator;
                                        wAppAnimator = wtoken.mAppAnimator;
                                        if (tAppAnimator.animation != null) {
                                            wAppAnimator.animation = tAppAnimator.animation;
                                            wAppAnimator.animating = tAppAnimator.animating;
                                            wAppAnimator.animLayerAdjustment = tAppAnimator.animLayerAdjustment;
                                            tAppAnimator.animation = null;
                                            tAppAnimator.animLayerAdjustment = WALLPAPER_DRAW_NORMAL;
                                            wAppAnimator.updateLayers();
                                            tAppAnimator.updateLayers();
                                        }
                                        updateFocusedWindowLocked(UPDATE_FOCUS_WILL_PLACE_SURFACES, HIDE_STACK_CRAWLS);
                                        getDefaultDisplayContentLocked().layoutNeeded = HIDE_STACK_CRAWLS;
                                        performLayoutAndPlaceSurfacesLocked();
                                        Binder.restoreCallingIdentity(origId);
                                        return;
                                    } else if (ttoken.startingData != null) {
                                        wtoken.startingData = ttoken.startingData;
                                        ttoken.startingData = null;
                                        ttoken.startingMoved = HIDE_STACK_CRAWLS;
                                        this.mH.sendMessageAtFrontOfQueue(this.mH.obtainMessage(WINDOW_LAYER_MULTIPLIER, wtoken));
                                        return;
                                    } else {
                                        tAppAnimator = ttoken.mAppAnimator;
                                        wAppAnimator = wtoken.mAppAnimator;
                                        if (tAppAnimator.thumbnail != null) {
                                            if (wAppAnimator.thumbnail != null) {
                                                wAppAnimator.thumbnail.destroy();
                                            }
                                            wAppAnimator.thumbnail = tAppAnimator.thumbnail;
                                            wAppAnimator.thumbnailX = tAppAnimator.thumbnailX;
                                            wAppAnimator.thumbnailY = tAppAnimator.thumbnailY;
                                            wAppAnimator.thumbnailLayer = tAppAnimator.thumbnailLayer;
                                            wAppAnimator.thumbnailAnimation = tAppAnimator.thumbnailAnimation;
                                            tAppAnimator.thumbnail = null;
                                        }
                                    }
                                }
                            }
                            if (createIfNeeded) {
                                if (theme != 0) {
                                    Entry ent = AttributeCache.instance().get(pkg, theme, R.styleable.Window, this.mCurrentUserId);
                                    if (ent == null) {
                                        return;
                                    } else if (ent.array.getBoolean(WINDOW_LAYER_MULTIPLIER, SHOW_TRANSACTIONS)) {
                                        return;
                                    } else if (ent.array.getBoolean(LAYOUT_REPEAT_THRESHOLD, SHOW_TRANSACTIONS)) {
                                        return;
                                    } else if (ent.array.getBoolean(14, SHOW_TRANSACTIONS)) {
                                        if (this.mWallpaperTarget == null) {
                                            windowFlags |= 1048576;
                                        } else {
                                            return;
                                        }
                                    }
                                }
                                this.mStartingIconInTransition = HIDE_STACK_CRAWLS;
                                wtoken.startingData = new StartingData(pkg, theme, compatInfo, nonLocalizedLabel, labelRes, icon, logo, windowFlags);
                                this.mH.sendMessageAtFrontOfQueue(this.mH.obtainMessage(WINDOW_LAYER_MULTIPLIER, wtoken));
                                return;
                            }
                            return;
                        }
                    }
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public void removeAppStartingWindow(IBinder token) {
                synchronized (this.mWindowMap) {
                    AppWindowToken wtoken = ((WindowToken) this.mTokenMap.get(token)).appWindowToken;
                    if (wtoken.startingWindow != null) {
                        scheduleRemoveStartingWindowLocked(wtoken);
                    }
                }
            }

            public void setAppWillBeHidden(IBinder token) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "setAppWillBeHidden()")) {
                    synchronized (this.mWindowMap) {
                        AppWindowToken wtoken = findAppWindowToken(token);
                        if (wtoken == null) {
                            Slog.w(TAG, "Attempted to set will be hidden of non-existing app token: " + token);
                            return;
                        }
                        wtoken.willBeHidden = HIDE_STACK_CRAWLS;
                        return;
                    }
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public void setAppFullscreen(IBinder token, boolean toOpaque) {
                synchronized (this.mWindowMap) {
                    AppWindowToken atoken = findAppWindowToken(token);
                    if (atoken != null) {
                        atoken.appFullscreen = toOpaque;
                        setWindowOpaqueLocked(token, toOpaque);
                        requestTraversalLocked();
                    }
                }
            }

            public void setWindowOpaque(IBinder token, boolean isOpaque) {
                synchronized (this.mWindowMap) {
                    setWindowOpaqueLocked(token, isOpaque);
                }
            }

            public void setWindowOpaqueLocked(IBinder token, boolean isOpaque) {
                AppWindowToken wtoken = findAppWindowToken(token);
                if (wtoken != null) {
                    WindowState win = wtoken.findMainWindow();
                    if (win != null) {
                        win.mWinAnimator.setOpaqueLocked(isOpaque);
                    }
                }
            }

            boolean setTokenVisibilityLocked(AppWindowToken wtoken, LayoutParams lp, boolean visible, int transit, boolean performLayout, boolean isVoiceInteraction) {
                int i;
                boolean z = SHOW_TRANSACTIONS;
                if (wtoken.clientHidden == visible) {
                    wtoken.clientHidden = !visible ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                    wtoken.sendAppVisibilityToClients();
                }
                wtoken.willBeHidden = SHOW_TRANSACTIONS;
                if (wtoken.hidden == visible) {
                    boolean changed = SHOW_TRANSACTIONS;
                    boolean runningAppAnimation = SHOW_TRANSACTIONS;
                    if (transit != -1) {
                        if (wtoken.mAppAnimator.animation == AppWindowAnimator.sDummyAnimation) {
                            wtoken.mAppAnimator.animation = null;
                        }
                        if (applyAnimationLocked(wtoken, lp, transit, visible, isVoiceInteraction)) {
                            runningAppAnimation = HIDE_STACK_CRAWLS;
                            z = HIDE_STACK_CRAWLS;
                        }
                        WindowState window = wtoken.findMainWindow();
                        if (!(window == null || this.mAccessibilityController == null || window.getDisplayId() != 0)) {
                            this.mAccessibilityController.onAppWindowTransitionLocked(window, transit);
                        }
                        changed = HIDE_STACK_CRAWLS;
                    }
                    int N = wtoken.allAppWindows.size();
                    for (i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                        WindowState win = (WindowState) wtoken.allAppWindows.get(i);
                        if (win != wtoken.startingWindow) {
                            DisplayContent displayContent;
                            if (visible) {
                                if (!win.isVisibleNow()) {
                                    if (!runningAppAnimation) {
                                        win.mWinAnimator.applyAnimationLocked(WALLPAPER_DRAW_PENDING, HIDE_STACK_CRAWLS);
                                        if (this.mAccessibilityController != null && win.getDisplayId() == 0) {
                                            this.mAccessibilityController.onWindowTransitionLocked(win, WALLPAPER_DRAW_PENDING);
                                        }
                                    }
                                    changed = HIDE_STACK_CRAWLS;
                                    displayContent = win.getDisplayContent();
                                    if (displayContent != null) {
                                        displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                                    }
                                }
                            } else if (win.isVisibleNow()) {
                                if (!runningAppAnimation) {
                                    win.mWinAnimator.applyAnimationLocked(WALLPAPER_DRAW_TIMEOUT, SHOW_TRANSACTIONS);
                                    if (this.mAccessibilityController != null && win.getDisplayId() == 0) {
                                        this.mAccessibilityController.onWindowTransitionLocked(win, WALLPAPER_DRAW_TIMEOUT);
                                    }
                                }
                                changed = HIDE_STACK_CRAWLS;
                                displayContent = win.getDisplayContent();
                                if (displayContent != null) {
                                    displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                                }
                            }
                        }
                    }
                    boolean z2 = !visible ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                    wtoken.hiddenRequested = z2;
                    wtoken.hidden = z2;
                    if (visible) {
                        WindowState swin = wtoken.startingWindow;
                        if (!(swin == null || swin.isDrawnLw())) {
                            swin.mPolicyVisibility = SHOW_TRANSACTIONS;
                            swin.mPolicyVisibilityAfterAnim = SHOW_TRANSACTIONS;
                        }
                    } else {
                        unsetAppFreezingScreenLocked(wtoken, HIDE_STACK_CRAWLS, HIDE_STACK_CRAWLS);
                    }
                    if (changed) {
                        this.mInputMonitor.setUpdateInputWindowsNeededLw();
                        if (performLayout) {
                            updateFocusedWindowLocked(UPDATE_FOCUS_WILL_PLACE_SURFACES, SHOW_TRANSACTIONS);
                            performLayoutAndPlaceSurfacesLocked();
                        }
                        this.mInputMonitor.updateInputWindowsLw(SHOW_TRANSACTIONS);
                    }
                }
                if (wtoken.mAppAnimator.animation != null) {
                    z = HIDE_STACK_CRAWLS;
                }
                for (i = wtoken.allAppWindows.size() - 1; i >= 0 && !z; i--) {
                    if (((WindowState) wtoken.allAppWindows.get(i)).mWinAnimator.isWindowAnimating()) {
                        z = HIDE_STACK_CRAWLS;
                    }
                }
                return z;
            }

            void updateTokenInPlaceLocked(AppWindowToken wtoken, int transit) {
                if (transit != -1) {
                    if (wtoken.mAppAnimator.animation == AppWindowAnimator.sDummyAnimation) {
                        wtoken.mAppAnimator.animation = null;
                    }
                    applyAnimationLocked(wtoken, null, transit, SHOW_TRANSACTIONS, SHOW_TRANSACTIONS);
                }
            }

            public void setAppVisibility(IBinder token, boolean visible) {
                boolean z = HIDE_STACK_CRAWLS;
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "setAppVisibility()")) {
                    synchronized (this.mWindowMap) {
                        AppWindowToken wtoken = findAppWindowToken(token);
                        if (wtoken == null) {
                            Slog.w(TAG, "Attempted to set visibility of non-existing app token: " + token);
                            return;
                        }
                        this.mOpeningApps.remove(wtoken);
                        this.mClosingApps.remove(wtoken);
                        wtoken.waitingToHide = SHOW_TRANSACTIONS;
                        wtoken.waitingToShow = SHOW_TRANSACTIONS;
                        if (visible) {
                            z = SHOW_TRANSACTIONS;
                        }
                        wtoken.hiddenRequested = z;
                        if (okToDisplay() && this.mAppTransition.isTransitionSet()) {
                            if (!wtoken.startingDisplayed) {
                                wtoken.mAppAnimator.setDummyAnimation();
                            }
                            wtoken.inPendingTransaction = HIDE_STACK_CRAWLS;
                            if (visible) {
                                this.mOpeningApps.add(wtoken);
                                wtoken.startingMoved = SHOW_TRANSACTIONS;
                                wtoken.mEnteringAnimation = HIDE_STACK_CRAWLS;
                                if (wtoken.hidden) {
                                    wtoken.allDrawn = SHOW_TRANSACTIONS;
                                    wtoken.deferClearAllDrawn = SHOW_TRANSACTIONS;
                                    wtoken.waitingToShow = HIDE_STACK_CRAWLS;
                                    if (wtoken.clientHidden) {
                                        wtoken.clientHidden = SHOW_TRANSACTIONS;
                                        wtoken.sendAppVisibilityToClients();
                                    }
                                }
                            } else {
                                this.mClosingApps.add(wtoken);
                                wtoken.mEnteringAnimation = SHOW_TRANSACTIONS;
                                if (!wtoken.hidden) {
                                    wtoken.waitingToHide = HIDE_STACK_CRAWLS;
                                }
                            }
                            if (this.mAppTransition.getAppTransition() == 16) {
                                WindowState win = findFocusedWindowLocked(getDefaultDisplayContentLocked());
                                if (win != null) {
                                    AppWindowToken focusedToken = win.mAppToken;
                                    if (focusedToken != null) {
                                        focusedToken.hidden = HIDE_STACK_CRAWLS;
                                        this.mOpeningApps.add(focusedToken);
                                    }
                                }
                            }
                            return;
                        }
                        long origId = Binder.clearCallingIdentity();
                        wtoken.inPendingTransaction = SHOW_TRANSACTIONS;
                        setTokenVisibilityLocked(wtoken, null, visible, -1, HIDE_STACK_CRAWLS, wtoken.voiceInteraction);
                        wtoken.updateReportedVisibilityLocked();
                        Binder.restoreCallingIdentity(origId);
                        return;
                    }
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            void unsetAppFreezingScreenLocked(AppWindowToken wtoken, boolean unfreezeSurfaceNow, boolean force) {
                if (wtoken.mAppAnimator.freezingScreen) {
                    int N = wtoken.allAppWindows.size();
                    boolean unfrozeWindows = SHOW_TRANSACTIONS;
                    for (int i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                        WindowState w = (WindowState) wtoken.allAppWindows.get(i);
                        if (w.mAppFreezing) {
                            w.mAppFreezing = SHOW_TRANSACTIONS;
                            if (w.mHasSurface && !w.mOrientationChanging) {
                                w.mOrientationChanging = HIDE_STACK_CRAWLS;
                                this.mInnerFields.mOrientationChangeComplete = SHOW_TRANSACTIONS;
                            }
                            w.mLastFreezeDuration = WALLPAPER_DRAW_NORMAL;
                            unfrozeWindows = HIDE_STACK_CRAWLS;
                            DisplayContent displayContent = w.getDisplayContent();
                            if (displayContent != null) {
                                displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                            }
                        }
                    }
                    if (force || unfrozeWindows) {
                        wtoken.mAppAnimator.freezingScreen = SHOW_TRANSACTIONS;
                        wtoken.mAppAnimator.lastFreezeDuration = (int) (SystemClock.elapsedRealtime() - this.mDisplayFreezeTime);
                        this.mAppsFreezingScreen--;
                        this.mLastFinishedFreezeSource = wtoken;
                    }
                    if (unfreezeSurfaceNow) {
                        if (unfrozeWindows) {
                            performLayoutAndPlaceSurfacesLocked();
                        }
                        stopFreezingDisplayLocked();
                    }
                }
            }

            private void startAppFreezingScreenLocked(AppWindowToken wtoken) {
                if (!wtoken.hiddenRequested) {
                    if (!wtoken.mAppAnimator.freezingScreen) {
                        wtoken.mAppAnimator.freezingScreen = HIDE_STACK_CRAWLS;
                        wtoken.mAppAnimator.lastFreezeDuration = WALLPAPER_DRAW_NORMAL;
                        this.mAppsFreezingScreen += WALLPAPER_DRAW_PENDING;
                        if (this.mAppsFreezingScreen == WALLPAPER_DRAW_PENDING) {
                            startFreezingDisplayLocked(SHOW_TRANSACTIONS, WALLPAPER_DRAW_NORMAL, WALLPAPER_DRAW_NORMAL);
                            this.mH.removeMessages(17);
                            this.mH.sendEmptyMessageDelayed(17, 5000);
                        }
                    }
                    int N = wtoken.allAppWindows.size();
                    for (int i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                        ((WindowState) wtoken.allAppWindows.get(i)).mAppFreezing = HIDE_STACK_CRAWLS;
                    }
                }
            }

            public void startAppFreezingScreen(IBinder token, int configChanges) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "setAppFreezingScreen()")) {
                    synchronized (this.mWindowMap) {
                        if (configChanges == 0) {
                            if (okToDisplay()) {
                                return;
                            }
                        }
                        AppWindowToken wtoken = findAppWindowToken(token);
                        if (wtoken == null || wtoken.appToken == null) {
                            Slog.w(TAG, "Attempted to freeze screen with non-existing app token: " + wtoken);
                            return;
                        }
                        long origId = Binder.clearCallingIdentity();
                        startAppFreezingScreenLocked(wtoken);
                        Binder.restoreCallingIdentity(origId);
                        return;
                    }
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public void stopAppFreezingScreen(IBinder token, boolean force) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "setAppFreezingScreen()")) {
                    synchronized (this.mWindowMap) {
                        AppWindowToken wtoken = findAppWindowToken(token);
                        if (wtoken == null || wtoken.appToken == null) {
                            return;
                        }
                        long origId = Binder.clearCallingIdentity();
                        unsetAppFreezingScreenLocked(wtoken, HIDE_STACK_CRAWLS, force);
                        Binder.restoreCallingIdentity(origId);
                        return;
                    }
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            void removeAppFromTaskLocked(AppWindowToken wtoken) {
                wtoken.removeAllWindows();
                Task task = (Task) this.mTaskIdToTask.get(wtoken.groupId);
                if (task != null && !task.removeAppToken(wtoken)) {
                    Slog.e(TAG, "removeAppFromTaskLocked: token=" + wtoken + " not found.");
                }
            }

            public void removeAppToken(IBinder token) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "removeAppToken()")) {
                    AppWindowToken wtoken = null;
                    AppWindowToken startingToken = null;
                    boolean delayed = SHOW_TRANSACTIONS;
                    long origId = Binder.clearCallingIdentity();
                    synchronized (this.mWindowMap) {
                        WindowToken basewtoken = (WindowToken) this.mTokenMap.remove(token);
                        if (basewtoken != null) {
                            wtoken = basewtoken.appWindowToken;
                            if (wtoken != null) {
                                delayed = setTokenVisibilityLocked(wtoken, null, SHOW_TRANSACTIONS, -1, HIDE_STACK_CRAWLS, wtoken.voiceInteraction);
                                wtoken.inPendingTransaction = SHOW_TRANSACTIONS;
                                this.mOpeningApps.remove(wtoken);
                                wtoken.waitingToShow = SHOW_TRANSACTIONS;
                                if (this.mClosingApps.contains(wtoken)) {
                                    delayed = HIDE_STACK_CRAWLS;
                                } else if (this.mAppTransition.isTransitionSet()) {
                                    this.mClosingApps.add(wtoken);
                                    wtoken.waitingToHide = HIDE_STACK_CRAWLS;
                                    delayed = HIDE_STACK_CRAWLS;
                                }
                                TaskStack stack = ((Task) this.mTaskIdToTask.get(wtoken.groupId)).mStack;
                                if (!delayed || wtoken.allAppWindows.isEmpty()) {
                                    wtoken.mAppAnimator.clearAnimation();
                                    wtoken.mAppAnimator.animating = SHOW_TRANSACTIONS;
                                    removeAppFromTaskLocked(wtoken);
                                } else {
                                    stack.mExitingAppTokens.add(wtoken);
                                    wtoken.mDeferRemoval = HIDE_STACK_CRAWLS;
                                }
                                wtoken.removed = HIDE_STACK_CRAWLS;
                                if (wtoken.startingData != null) {
                                    startingToken = wtoken;
                                }
                                unsetAppFreezingScreenLocked(wtoken, HIDE_STACK_CRAWLS, HIDE_STACK_CRAWLS);
                                if (this.mFocusedApp == wtoken) {
                                    this.mFocusedApp = null;
                                    updateFocusedWindowLocked(WALLPAPER_DRAW_NORMAL, HIDE_STACK_CRAWLS);
                                    this.mInputMonitor.setFocusedAppLw(null);
                                }
                                if (!(delayed || wtoken == null)) {
                                    wtoken.updateReportedVisibilityLocked();
                                }
                                scheduleRemoveStartingWindowLocked(startingToken);
                            }
                        }
                        Slog.w(TAG, "Attempted to remove non-existing app token: " + token);
                        wtoken.updateReportedVisibilityLocked();
                        scheduleRemoveStartingWindowLocked(startingToken);
                    }
                    Binder.restoreCallingIdentity(origId);
                    return;
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            void scheduleRemoveStartingWindowLocked(AppWindowToken wtoken) {
                if (!this.mH.hasMessages(6, wtoken) && wtoken != null && wtoken.startingWindow != null) {
                    this.mH.sendMessage(this.mH.obtainMessage(6, wtoken));
                }
            }

            private boolean tmpRemoveAppWindowsLocked(WindowToken token) {
                WindowList windows = token.windows;
                int NW = windows.size();
                if (NW > 0) {
                    this.mWindowsChanged = HIDE_STACK_CRAWLS;
                }
                int targetDisplayId = -1;
                Task targetTask = (Task) this.mTaskIdToTask.get(token.appWindowToken.groupId);
                if (targetTask != null) {
                    DisplayContent targetDisplayContent = targetTask.getDisplayContent();
                    if (targetDisplayContent != null) {
                        targetDisplayId = targetDisplayContent.getDisplayId();
                    }
                }
                for (int i = WALLPAPER_DRAW_NORMAL; i < NW; i += WALLPAPER_DRAW_PENDING) {
                    WindowState win = (WindowState) windows.get(i);
                    if (targetDisplayId == -1 || win.getDisplayId() == targetDisplayId) {
                        win.getWindowList().remove(win);
                        int j = win.mChildWindows.size();
                        while (j > 0) {
                            j--;
                            WindowState cwin = (WindowState) win.mChildWindows.get(j);
                            cwin.getWindowList().remove(cwin);
                        }
                    }
                }
                if (NW > 0) {
                    return HIDE_STACK_CRAWLS;
                }
                return SHOW_TRANSACTIONS;
            }

            void dumpAppTokensLocked() {
                int numStacks = this.mStackIdToStack.size();
                for (int stackNdx = WALLPAPER_DRAW_NORMAL; stackNdx < numStacks; stackNdx += WALLPAPER_DRAW_PENDING) {
                    TaskStack stack = (TaskStack) this.mStackIdToStack.valueAt(stackNdx);
                    Slog.v(TAG, "  Stack #" + stack.mStackId + " tasks from bottom to top:");
                    ArrayList<Task> tasks = stack.getTasks();
                    int numTasks = tasks.size();
                    for (int taskNdx = WALLPAPER_DRAW_NORMAL; taskNdx < numTasks; taskNdx += WALLPAPER_DRAW_PENDING) {
                        Task task = (Task) tasks.get(taskNdx);
                        Slog.v(TAG, "    Task #" + task.taskId + " activities from bottom to top:");
                        AppTokenList tokens = task.mAppTokens;
                        int numTokens = tokens.size();
                        for (int tokenNdx = WALLPAPER_DRAW_NORMAL; tokenNdx < numTokens; tokenNdx += WALLPAPER_DRAW_PENDING) {
                            Slog.v(TAG, "      activity #" + tokenNdx + ": " + ((AppWindowToken) tokens.get(tokenNdx)).token);
                        }
                    }
                }
            }

            void dumpWindowsLocked() {
                int numDisplays = this.mDisplayContents.size();
                for (int displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                    DisplayContent displayContent = (DisplayContent) this.mDisplayContents.valueAt(displayNdx);
                    Slog.v(TAG, " Display #" + displayContent.getDisplayId());
                    WindowList windows = displayContent.getWindowList();
                    for (int winNdx = windows.size() - 1; winNdx >= 0; winNdx--) {
                        Slog.v(TAG, "  #" + winNdx + ": " + windows.get(winNdx));
                    }
                }
            }

            private int findAppWindowInsertionPointLocked(AppWindowToken target) {
                int taskId = target.groupId;
                Task targetTask = (Task) this.mTaskIdToTask.get(taskId);
                if (targetTask == null) {
                    Slog.w(TAG, "findAppWindowInsertionPointLocked: no Task for " + target + " taskId=" + taskId);
                    return WALLPAPER_DRAW_NORMAL;
                }
                DisplayContent displayContent = targetTask.getDisplayContent();
                if (displayContent == null) {
                    Slog.w(TAG, "findAppWindowInsertionPointLocked: no DisplayContent for " + target);
                    return WALLPAPER_DRAW_NORMAL;
                }
                WindowList windows = displayContent.getWindowList();
                int NW = windows.size();
                boolean found = SHOW_TRANSACTIONS;
                ArrayList<Task> tasks = displayContent.getTasks();
                for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
                    Task task = (Task) tasks.get(taskNdx);
                    if (!found) {
                        int i = task.taskId;
                        if (r0 != taskId) {
                            continue;
                        }
                    }
                    AppTokenList tokens = task.mAppTokens;
                    for (int tokenNdx = tokens.size() - 1; tokenNdx >= 0; tokenNdx--) {
                        int pos;
                        AppWindowToken wtoken = (AppWindowToken) tokens.get(tokenNdx);
                        if (!found && wtoken == target) {
                            found = HIDE_STACK_CRAWLS;
                        }
                        if (found && !wtoken.sendingToBottom) {
                            for (int i2 = wtoken.windows.size() - 1; i2 >= 0; i2--) {
                                WindowState win = (WindowState) wtoken.windows.get(i2);
                                for (int j = win.mChildWindows.size() - 1; j >= 0; j--) {
                                    WindowState cwin = (WindowState) win.mChildWindows.get(j);
                                    if (cwin.mSubLayer >= 0) {
                                        for (pos = NW - 1; pos >= 0; pos--) {
                                            if (windows.get(pos) == cwin) {
                                                return pos + WALLPAPER_DRAW_PENDING;
                                            }
                                        }
                                        continue;
                                    }
                                }
                                for (pos = NW - 1; pos >= 0; pos--) {
                                    if (windows.get(pos) == win) {
                                        return pos + WALLPAPER_DRAW_PENDING;
                                    }
                                }
                            }
                            continue;
                        }
                    }
                    continue;
                }
                for (pos = NW - 1; pos >= 0; pos--) {
                    if (((WindowState) windows.get(pos)).mIsWallpaper) {
                        return pos + WALLPAPER_DRAW_PENDING;
                    }
                }
                return WALLPAPER_DRAW_NORMAL;
            }

            private final int reAddWindowLocked(int index, WindowState win) {
                WindowList windows = win.getWindowList();
                int NCW = win.mChildWindows.size();
                boolean added = SHOW_TRANSACTIONS;
                for (int j = WALLPAPER_DRAW_NORMAL; j < NCW; j += WALLPAPER_DRAW_PENDING) {
                    WindowState cwin = (WindowState) win.mChildWindows.get(j);
                    if (!added && cwin.mSubLayer >= 0) {
                        win.mRebuilding = SHOW_TRANSACTIONS;
                        windows.add(index, win);
                        index += WALLPAPER_DRAW_PENDING;
                        added = HIDE_STACK_CRAWLS;
                    }
                    cwin.mRebuilding = SHOW_TRANSACTIONS;
                    windows.add(index, cwin);
                    index += WALLPAPER_DRAW_PENDING;
                }
                if (!added) {
                    win.mRebuilding = SHOW_TRANSACTIONS;
                    windows.add(index, win);
                    index += WALLPAPER_DRAW_PENDING;
                }
                this.mWindowsChanged = HIDE_STACK_CRAWLS;
                return index;
            }

            private final int reAddAppWindowsLocked(DisplayContent displayContent, int index, WindowToken token) {
                int NW = token.windows.size();
                for (int i = WALLPAPER_DRAW_NORMAL; i < NW; i += WALLPAPER_DRAW_PENDING) {
                    WindowState win = (WindowState) token.windows.get(i);
                    DisplayContent winDisplayContent = win.getDisplayContent();
                    if (winDisplayContent == displayContent || winDisplayContent == null) {
                        win.mDisplayContent = displayContent;
                        index = reAddWindowLocked(index, win);
                    }
                }
                return index;
            }

            void tmpRemoveTaskWindowsLocked(Task task) {
                AppTokenList tokens = task.mAppTokens;
                for (int tokenNdx = tokens.size() - 1; tokenNdx >= 0; tokenNdx--) {
                    tmpRemoveAppWindowsLocked((WindowToken) tokens.get(tokenNdx));
                }
            }

            void moveStackWindowsLocked(DisplayContent displayContent) {
                int taskNdx;
                ArrayList<Task> tasks = displayContent.getTasks();
                int numTasks = tasks.size();
                for (taskNdx = WALLPAPER_DRAW_NORMAL; taskNdx < numTasks; taskNdx += WALLPAPER_DRAW_PENDING) {
                    tmpRemoveTaskWindowsLocked((Task) tasks.get(taskNdx));
                }
                for (taskNdx = WALLPAPER_DRAW_NORMAL; taskNdx < numTasks; taskNdx += WALLPAPER_DRAW_PENDING) {
                    AppTokenList tokens = ((Task) tasks.get(taskNdx)).mAppTokens;
                    int numTokens = tokens.size();
                    if (numTokens != 0) {
                        int pos = findAppWindowInsertionPointLocked((AppWindowToken) tokens.get(WALLPAPER_DRAW_NORMAL));
                        for (int tokenNdx = WALLPAPER_DRAW_NORMAL; tokenNdx < numTokens; tokenNdx += WALLPAPER_DRAW_PENDING) {
                            AppWindowToken wtoken = (AppWindowToken) tokens.get(tokenNdx);
                            if (wtoken != null) {
                                int newPos = reAddAppWindowsLocked(displayContent, pos, wtoken);
                                if (newPos != pos) {
                                    displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                                }
                                pos = newPos;
                            }
                        }
                    }
                }
                if (!updateFocusedWindowLocked(UPDATE_FOCUS_WILL_PLACE_SURFACES, SHOW_TRANSACTIONS)) {
                    assignLayersLocked(displayContent.getWindowList());
                }
                this.mInputMonitor.setUpdateInputWindowsNeededLw();
                performLayoutAndPlaceSurfacesLocked();
                this.mInputMonitor.updateInputWindowsLw(SHOW_TRANSACTIONS);
            }

            public void moveTaskToTop(int taskId) {
                long origId = Binder.clearCallingIdentity();
                try {
                    synchronized (this.mWindowMap) {
                        Task task = (Task) this.mTaskIdToTask.get(taskId);
                        if (task == null) {
                            return;
                        }
                        TaskStack stack = task.mStack;
                        DisplayContent displayContent = task.getDisplayContent();
                        displayContent.moveStack(stack, HIDE_STACK_CRAWLS);
                        if (displayContent.isDefaultDisplay) {
                            TaskStack homeStack = displayContent.getHomeStack();
                            if (homeStack != stack) {
                                displayContent.moveStack(homeStack, SHOW_TRANSACTIONS);
                            }
                        }
                        stack.moveTaskToTop(task);
                        if (this.mAppTransition.isTransitionSet()) {
                            task.setSendingToBottom(SHOW_TRANSACTIONS);
                        }
                        moveStackWindowsLocked(displayContent);
                        Binder.restoreCallingIdentity(origId);
                    }
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }

            public void moveTaskToBottom(int taskId) {
                long origId = Binder.clearCallingIdentity();
                try {
                    synchronized (this.mWindowMap) {
                        Task task = (Task) this.mTaskIdToTask.get(taskId);
                        if (task == null) {
                            Slog.e(TAG, "moveTaskToBottom: taskId=" + taskId + " not found in mTaskIdToTask");
                            return;
                        }
                        TaskStack stack = task.mStack;
                        stack.moveTaskToBottom(task);
                        if (this.mAppTransition.isTransitionSet()) {
                            task.setSendingToBottom(HIDE_STACK_CRAWLS);
                        }
                        moveStackWindowsLocked(stack.getDisplayContent());
                        Binder.restoreCallingIdentity(origId);
                    }
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }

            public void attachStack(int stackId, int displayId) {
                long origId = Binder.clearCallingIdentity();
                try {
                    synchronized (this.mWindowMap) {
                        DisplayContent displayContent = (DisplayContent) this.mDisplayContents.get(displayId);
                        if (displayContent != null) {
                            TaskStack stack = (TaskStack) this.mStackIdToStack.get(stackId);
                            if (stack == null) {
                                stack = new TaskStack(this, stackId);
                                this.mStackIdToStack.put(stackId, stack);
                            }
                            stack.attachDisplayContent(displayContent);
                            displayContent.attachStack(stack);
                            moveStackWindowsLocked(displayContent);
                            WindowList windows = displayContent.getWindowList();
                            for (int winNdx = windows.size() - 1; winNdx >= 0; winNdx--) {
                                ((WindowState) windows.get(winNdx)).reportResized();
                            }
                        }
                    }
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }

            void detachStackLocked(DisplayContent displayContent, TaskStack stack) {
                displayContent.detachStack(stack);
                stack.detachDisplay();
            }

            public void detachStack(int stackId) {
                synchronized (this.mWindowMap) {
                    TaskStack stack = (TaskStack) this.mStackIdToStack.get(stackId);
                    if (stack != null) {
                        DisplayContent displayContent = stack.getDisplayContent();
                        if (displayContent != null) {
                            if (stack.isAnimating()) {
                                stack.mDeferDetach = HIDE_STACK_CRAWLS;
                                return;
                            }
                            detachStackLocked(displayContent, stack);
                        }
                    }
                }
            }

            public void removeStack(int stackId) {
                this.mStackIdToStack.remove(stackId);
            }

            void removeTaskLocked(Task task) {
                int taskId = task.taskId;
                TaskStack stack = task.mStack;
                if (task.mAppTokens.isEmpty() || !stack.isAnimating()) {
                    Object[] objArr = new Object[WALLPAPER_DRAW_TIMEOUT];
                    objArr[WALLPAPER_DRAW_NORMAL] = Integer.valueOf(taskId);
                    objArr[WALLPAPER_DRAW_PENDING] = "removeTask";
                    EventLog.writeEvent(EventLogTags.WM_TASK_REMOVED, objArr);
                    task.mDeferRemoval = SHOW_TRANSACTIONS;
                    stack.removeTask(task);
                    this.mTaskIdToTask.delete(task.taskId);
                    ArrayList<AppWindowToken> exitingApps = stack.mExitingAppTokens;
                    for (int appNdx = exitingApps.size() - 1; appNdx >= 0; appNdx--) {
                        AppWindowToken wtoken = (AppWindowToken) exitingApps.get(appNdx);
                        if (wtoken.groupId == taskId) {
                            wtoken.mDeferRemoval = SHOW_TRANSACTIONS;
                            exitingApps.remove(appNdx);
                        }
                    }
                    return;
                }
                task.mDeferRemoval = HIDE_STACK_CRAWLS;
            }

            public void removeTask(int taskId) {
                synchronized (this.mWindowMap) {
                    Task task = (Task) this.mTaskIdToTask.get(taskId);
                    if (task == null) {
                        return;
                    }
                    removeTaskLocked(task);
                }
            }

            public void addTask(int taskId, int stackId, boolean toTop) {
                synchronized (this.mWindowMap) {
                    Task task = (Task) this.mTaskIdToTask.get(taskId);
                    if (task == null) {
                        return;
                    }
                    TaskStack stack = (TaskStack) this.mStackIdToStack.get(stackId);
                    stack.addTask(task, toTop);
                    stack.getDisplayContent().layoutNeeded = HIDE_STACK_CRAWLS;
                    performLayoutAndPlaceSurfacesLocked();
                }
            }

            public void resizeStack(int stackId, Rect bounds) {
                synchronized (this.mWindowMap) {
                    TaskStack stack = (TaskStack) this.mStackIdToStack.get(stackId);
                    if (stack == null) {
                        throw new IllegalArgumentException("resizeStack: stackId " + stackId + " not found.");
                    }
                    if (stack.setBounds(bounds)) {
                        stack.resizeWindows();
                        stack.getDisplayContent().layoutNeeded = HIDE_STACK_CRAWLS;
                        performLayoutAndPlaceSurfacesLocked();
                    }
                }
            }

            public void getStackBounds(int stackId, Rect bounds) {
                TaskStack stack = (TaskStack) this.mStackIdToStack.get(stackId);
                if (stack != null) {
                    stack.getBounds(bounds);
                } else {
                    bounds.setEmpty();
                }
            }

            public void startFreezingScreen(int exitAnim, int enterAnim) {
                if (checkCallingPermission("android.permission.FREEZE_SCREEN", "startFreezingScreen()")) {
                    synchronized (this.mWindowMap) {
                        if (!this.mClientFreezingScreen) {
                            this.mClientFreezingScreen = HIDE_STACK_CRAWLS;
                            long origId = Binder.clearCallingIdentity();
                            try {
                                startFreezingDisplayLocked(SHOW_TRANSACTIONS, exitAnim, enterAnim);
                                this.mH.removeMessages(30);
                                this.mH.sendEmptyMessageDelayed(30, 5000);
                                Binder.restoreCallingIdentity(origId);
                            } catch (Throwable th) {
                                Binder.restoreCallingIdentity(origId);
                            }
                        }
                    }
                    return;
                }
                throw new SecurityException("Requires FREEZE_SCREEN permission");
            }

            public void stopFreezingScreen() {
                if (checkCallingPermission("android.permission.FREEZE_SCREEN", "stopFreezingScreen()")) {
                    synchronized (this.mWindowMap) {
                        if (this.mClientFreezingScreen) {
                            this.mClientFreezingScreen = SHOW_TRANSACTIONS;
                            this.mLastFinishedFreezeSource = "client";
                            long origId = Binder.clearCallingIdentity();
                            try {
                                stopFreezingDisplayLocked();
                                Binder.restoreCallingIdentity(origId);
                            } catch (Throwable th) {
                                Binder.restoreCallingIdentity(origId);
                            }
                        }
                    }
                    return;
                }
                throw new SecurityException("Requires FREEZE_SCREEN permission");
            }

            public void disableKeyguard(IBinder token, String tag) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.DISABLE_KEYGUARD") != 0) {
                    throw new SecurityException("Requires DISABLE_KEYGUARD permission");
                } else if (token == null) {
                    throw new IllegalArgumentException("token == null");
                } else {
                    this.mKeyguardDisableHandler.sendMessage(this.mKeyguardDisableHandler.obtainMessage(WALLPAPER_DRAW_PENDING, new Pair(token, tag)));
                }
            }

            public void reenableKeyguard(IBinder token) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.DISABLE_KEYGUARD") != 0) {
                    throw new SecurityException("Requires DISABLE_KEYGUARD permission");
                } else if (token == null) {
                    throw new IllegalArgumentException("token == null");
                } else {
                    this.mKeyguardDisableHandler.sendMessage(this.mKeyguardDisableHandler.obtainMessage(WALLPAPER_DRAW_TIMEOUT, token));
                }
            }

            public void exitKeyguardSecurely(IOnKeyguardExitResult callback) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.DISABLE_KEYGUARD") != 0) {
                    throw new SecurityException("Requires DISABLE_KEYGUARD permission");
                } else if (callback == null) {
                    throw new IllegalArgumentException("callback == null");
                } else {
                    this.mPolicy.exitKeyguardSecurely(new C05676(callback));
                }
            }

            public boolean inKeyguardRestrictedInputMode() {
                return this.mPolicy.inKeyguardRestrictedKeyInputMode();
            }

            public boolean isKeyguardLocked() {
                return this.mPolicy.isKeyguardLocked();
            }

            public boolean isKeyguardSecure() {
                long origId = Binder.clearCallingIdentity();
                try {
                    boolean isKeyguardSecure = this.mPolicy.isKeyguardSecure();
                    return isKeyguardSecure;
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }

            public void dismissKeyguard() {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.DISABLE_KEYGUARD") != 0) {
                    throw new SecurityException("Requires DISABLE_KEYGUARD permission");
                }
                synchronized (this.mWindowMap) {
                    this.mPolicy.dismissKeyguardLw();
                }
            }

            public void keyguardGoingAway(boolean disableWindowAnimations, boolean keyguardGoingToNotificationShade) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.DISABLE_KEYGUARD") != 0) {
                    throw new SecurityException("Requires DISABLE_KEYGUARD permission");
                }
                synchronized (this.mWindowMap) {
                    this.mAnimator.mKeyguardGoingAway = HIDE_STACK_CRAWLS;
                    this.mAnimator.mKeyguardGoingAwayToNotificationShade = keyguardGoingToNotificationShade;
                    this.mAnimator.mKeyguardGoingAwayDisableWindowAnimations = disableWindowAnimations;
                    requestTraversalLocked();
                }
            }

            public void keyguardWaitingForActivityDrawn() {
                synchronized (this.mWindowMap) {
                    this.mKeyguardWaitingForActivityDrawn = HIDE_STACK_CRAWLS;
                }
            }

            public void notifyActivityDrawnForKeyguard() {
                synchronized (this.mWindowMap) {
                    if (this.mKeyguardWaitingForActivityDrawn) {
                        this.mPolicy.notifyActivityDrawnForKeyguardLw();
                        this.mKeyguardWaitingForActivityDrawn = SHOW_TRANSACTIONS;
                    }
                }
            }

            void showGlobalActions() {
                this.mPolicy.showGlobalActions();
            }

            public void closeSystemDialogs(String reason) {
                synchronized (this.mWindowMap) {
                    int numDisplays = this.mDisplayContents.size();
                    for (int displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                        WindowList windows = ((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).getWindowList();
                        int numWindows = windows.size();
                        for (int winNdx = WALLPAPER_DRAW_NORMAL; winNdx < numWindows; winNdx += WALLPAPER_DRAW_PENDING) {
                            WindowState w = (WindowState) windows.get(winNdx);
                            if (w.mHasSurface) {
                                try {
                                    w.mClient.closeSystemDialogs(reason);
                                } catch (RemoteException e) {
                                }
                            }
                        }
                    }
                }
            }

            static float fixScale(float scale) {
                if (scale < 0.0f) {
                    scale = 0.0f;
                } else if (scale > 20.0f) {
                    scale = 20.0f;
                }
                return Math.abs(scale);
            }

            public void setAnimationScale(int which, float scale) {
                if (checkCallingPermission("android.permission.SET_ANIMATION_SCALE", "setAnimationScale()")) {
                    scale = fixScale(scale);
                    switch (which) {
                        case WALLPAPER_DRAW_NORMAL /*0*/:
                            this.mWindowAnimationScaleSetting = scale;
                            break;
                        case WALLPAPER_DRAW_PENDING /*1*/:
                            this.mTransitionAnimationScaleSetting = scale;
                            break;
                        case WALLPAPER_DRAW_TIMEOUT /*2*/:
                            this.mAnimatorDurationScaleSetting = scale;
                            break;
                    }
                    this.mH.sendEmptyMessage(14);
                    return;
                }
                throw new SecurityException("Requires SET_ANIMATION_SCALE permission");
            }

            public void setAnimationScales(float[] scales) {
                if (checkCallingPermission("android.permission.SET_ANIMATION_SCALE", "setAnimationScale()")) {
                    if (scales != null) {
                        if (scales.length >= WALLPAPER_DRAW_PENDING) {
                            this.mWindowAnimationScaleSetting = fixScale(scales[WALLPAPER_DRAW_NORMAL]);
                        }
                        if (scales.length >= WALLPAPER_DRAW_TIMEOUT) {
                            this.mTransitionAnimationScaleSetting = fixScale(scales[WALLPAPER_DRAW_PENDING]);
                        }
                        if (scales.length >= UPDATE_FOCUS_WILL_PLACE_SURFACES) {
                            this.mAnimatorDurationScaleSetting = fixScale(scales[WALLPAPER_DRAW_TIMEOUT]);
                            dispatchNewAnimatorScaleLocked(null);
                        }
                    }
                    this.mH.sendEmptyMessage(14);
                    return;
                }
                throw new SecurityException("Requires SET_ANIMATION_SCALE permission");
            }

            private void setAnimatorDurationScale(float scale) {
                this.mAnimatorDurationScaleSetting = scale;
                ValueAnimator.setDurationScale(scale);
            }

            public float getWindowAnimationScaleLocked() {
                return this.mAnimationsDisabled ? 0.0f : this.mWindowAnimationScaleSetting;
            }

            public float getTransitionAnimationScaleLocked() {
                return this.mAnimationsDisabled ? 0.0f : this.mTransitionAnimationScaleSetting;
            }

            public float getAnimationScale(int which) {
                switch (which) {
                    case WALLPAPER_DRAW_NORMAL /*0*/:
                        return this.mWindowAnimationScaleSetting;
                    case WALLPAPER_DRAW_PENDING /*1*/:
                        return this.mTransitionAnimationScaleSetting;
                    case WALLPAPER_DRAW_TIMEOUT /*2*/:
                        return this.mAnimatorDurationScaleSetting;
                    default:
                        return 0.0f;
                }
            }

            public float[] getAnimationScales() {
                float[] fArr = new float[UPDATE_FOCUS_WILL_PLACE_SURFACES];
                fArr[WALLPAPER_DRAW_NORMAL] = this.mWindowAnimationScaleSetting;
                fArr[WALLPAPER_DRAW_PENDING] = this.mTransitionAnimationScaleSetting;
                fArr[WALLPAPER_DRAW_TIMEOUT] = this.mAnimatorDurationScaleSetting;
                return fArr;
            }

            public float getCurrentAnimatorScale() {
                float f;
                synchronized (this.mWindowMap) {
                    f = this.mAnimationsDisabled ? 0.0f : this.mAnimatorDurationScaleSetting;
                }
                return f;
            }

            void dispatchNewAnimatorScaleLocked(Session session) {
                this.mH.obtainMessage(34, session).sendToTarget();
            }

            public void registerPointerEventListener(PointerEventListener listener) {
                this.mPointerEventDispatcher.registerInputEventListener(listener);
            }

            public void unregisterPointerEventListener(PointerEventListener listener) {
                this.mPointerEventDispatcher.unregisterInputEventListener(listener);
            }

            public int getLidState() {
                int sw = this.mInputManager.getSwitchState(-1, -256, WALLPAPER_DRAW_NORMAL);
                if (sw > 0) {
                    return WALLPAPER_DRAW_NORMAL;
                }
                return sw == 0 ? WALLPAPER_DRAW_PENDING : -1;
            }

            public int getCameraLensCoverState() {
                int sw = this.mInputManager.getSwitchState(-1, -256, 9);
                if (sw > 0) {
                    return WALLPAPER_DRAW_PENDING;
                }
                if (sw == 0) {
                    return WALLPAPER_DRAW_NORMAL;
                }
                return -1;
            }

            public void switchKeyboardLayout(int deviceId, int direction) {
                this.mInputManager.switchKeyboardLayout(deviceId, direction);
            }

            public void shutdown(boolean confirm) {
                ShutdownThread.shutdown(this.mContext, confirm);
            }

            public void rebootSafeMode(boolean confirm) {
                ShutdownThread.rebootSafeMode(this.mContext, confirm);
            }

            public void setCurrentProfileIds(int[] currentProfileIds) {
                synchronized (this.mWindowMap) {
                    this.mCurrentProfileIds = currentProfileIds;
                }
            }

            public void setCurrentUser(int newUserId, int[] currentProfileIds) {
                synchronized (this.mWindowMap) {
                    this.mCurrentUserId = newUserId;
                    this.mCurrentProfileIds = currentProfileIds;
                    this.mAppTransition.setCurrentUser(newUserId);
                    this.mPolicy.setCurrentUserLw(newUserId);
                    int numDisplays = this.mDisplayContents.size();
                    for (int displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                        DisplayContent displayContent = (DisplayContent) this.mDisplayContents.valueAt(displayNdx);
                        displayContent.switchUserStacks(newUserId);
                        rebuildAppWindowListLocked(displayContent);
                    }
                    performLayoutAndPlaceSurfacesLocked();
                }
            }

            boolean isCurrentProfileLocked(int userId) {
                if (userId == this.mCurrentUserId) {
                    return HIDE_STACK_CRAWLS;
                }
                for (int i = WALLPAPER_DRAW_NORMAL; i < this.mCurrentProfileIds.length; i += WALLPAPER_DRAW_PENDING) {
                    if (this.mCurrentProfileIds[i] == userId) {
                        return HIDE_STACK_CRAWLS;
                    }
                }
                return SHOW_TRANSACTIONS;
            }

            public void enableScreenAfterBoot() {
                synchronized (this.mWindowMap) {
                    if (this.mSystemBooted) {
                        return;
                    }
                    this.mSystemBooted = HIDE_STACK_CRAWLS;
                    hideBootMessagesLocked();
                    this.mH.sendEmptyMessageDelayed(23, 30000);
                    this.mPolicy.systemBooted();
                    performEnableScreen();
                }
            }

            public void enableScreenIfNeeded() {
                synchronized (this.mWindowMap) {
                    enableScreenIfNeededLocked();
                }
            }

            void enableScreenIfNeededLocked() {
                if (!this.mDisplayEnabled) {
                    if (this.mSystemBooted || this.mShowingBootMessages) {
                        this.mH.sendEmptyMessage(16);
                    }
                }
            }

            public void performBootTimeout() {
                synchronized (this.mWindowMap) {
                    if (this.mDisplayEnabled) {
                        return;
                    }
                    Slog.w(TAG, "***** BOOT TIMEOUT: forcing display enabled");
                    this.mForceDisplayEnabled = HIDE_STACK_CRAWLS;
                    performEnableScreen();
                }
            }

            private boolean checkWaitingForWindowsLocked() {
                boolean wallpaperEnabled;
                boolean haveBootMsg = SHOW_TRANSACTIONS;
                boolean haveApp = SHOW_TRANSACTIONS;
                boolean haveWallpaper = SHOW_TRANSACTIONS;
                if (!this.mContext.getResources().getBoolean(17956935) || this.mOnlyCore) {
                    wallpaperEnabled = SHOW_TRANSACTIONS;
                } else {
                    wallpaperEnabled = HIDE_STACK_CRAWLS;
                }
                boolean haveKeyguard = SHOW_TRANSACTIONS;
                WindowList windows = getDefaultWindowListLocked();
                int N = windows.size();
                for (int i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                    WindowState w = (WindowState) windows.get(i);
                    if (w.isVisibleLw() && !w.mObscured && !w.isDrawnLw()) {
                        return HIDE_STACK_CRAWLS;
                    }
                    if (w.isDrawnLw()) {
                        if (w.mAttrs.type == 2021) {
                            haveBootMsg = HIDE_STACK_CRAWLS;
                        } else if (w.mAttrs.type == WALLPAPER_DRAW_TIMEOUT) {
                            haveApp = HIDE_STACK_CRAWLS;
                        } else if (w.mAttrs.type == 2013) {
                            haveWallpaper = HIDE_STACK_CRAWLS;
                        } else if (w.mAttrs.type == WINDOW_FREEZE_TIMEOUT_DURATION) {
                            haveKeyguard = this.mPolicy.isKeyguardDrawnLw();
                        }
                    }
                }
                if (!this.mSystemBooted && !haveBootMsg) {
                    return HIDE_STACK_CRAWLS;
                }
                if (this.mSystemBooted) {
                    if (!haveApp && !haveKeyguard) {
                        return HIDE_STACK_CRAWLS;
                    }
                    if (wallpaperEnabled && !haveWallpaper) {
                        return HIDE_STACK_CRAWLS;
                    }
                }
                return SHOW_TRANSACTIONS;
            }

            public void performEnableScreen() {
                synchronized (this.mWindowMap) {
                    if (this.mDisplayEnabled) {
                    } else if (!this.mSystemBooted && !this.mShowingBootMessages) {
                    } else if (this.mForceDisplayEnabled || !checkWaitingForWindowsLocked()) {
                        if (!this.mBootAnimationStopped) {
                            try {
                                IBinder surfaceFlinger = ServiceManager.getService("SurfaceFlinger");
                                if (surfaceFlinger != null) {
                                    Parcel data = Parcel.obtain();
                                    data.writeInterfaceToken("android.ui.ISurfaceComposer");
                                    surfaceFlinger.transact(WALLPAPER_DRAW_PENDING, data, null, WALLPAPER_DRAW_NORMAL);
                                    data.recycle();
                                }
                            } catch (RemoteException e) {
                                Slog.e(TAG, "Boot completed: SurfaceFlinger is dead!");
                            }
                            this.mBootAnimationStopped = HIDE_STACK_CRAWLS;
                        }
                        if (this.mForceDisplayEnabled || checkBootAnimationCompleteLocked()) {
                            this.mDisplayEnabled = HIDE_STACK_CRAWLS;
                            this.mInputMonitor.setEventDispatchingLw(this.mEventDispatchingEnabled);
                            try {
                                this.mActivityManager.bootAnimationComplete();
                            } catch (RemoteException e2) {
                            }
                            if (SystemProperties.getBoolean("persist.sys.quickboot_ongoing", SHOW_TRANSACTIONS)) {
                                checkQuickBootException();
                            }
                            this.mPolicy.enableScreenAfterBoot();
                            updateRotationUnchecked(SHOW_TRANSACTIONS, SHOW_TRANSACTIONS);
                            return;
                        }
                    }
                }
            }

            private boolean checkBootAnimationCompleteLocked() {
                if (!SystemService.isRunning(BOOT_ANIMATION_SERVICE)) {
                    return HIDE_STACK_CRAWLS;
                }
                this.mH.removeMessages(37);
                this.mH.sendEmptyMessageDelayed(37, 200);
                return SHOW_TRANSACTIONS;
            }

            private void checkQuickBootException() {
                Intent intent = new Intent("org.codeaurora.action.QUICKBOOT");
                intent.putExtra("mode", WALLPAPER_DRAW_TIMEOUT);
                try {
                    this.mContext.startActivityAsUser(intent, UserHandle.CURRENT);
                } catch (ActivityNotFoundException e) {
                }
            }

            public void showBootMessage(CharSequence msg, boolean always) {
                boolean first = SHOW_TRANSACTIONS;
                synchronized (this.mWindowMap) {
                    if (this.mAllowBootMessages) {
                        if (!this.mShowingBootMessages) {
                            if (always) {
                                first = HIDE_STACK_CRAWLS;
                            } else {
                                return;
                            }
                        }
                        if (this.mSystemBooted) {
                            return;
                        }
                        this.mShowingBootMessages = HIDE_STACK_CRAWLS;
                        this.mPolicy.showBootMessage(msg, always);
                        if (first) {
                            performEnableScreen();
                            return;
                        }
                        return;
                    }
                }
            }

            public void hideBootMessagesLocked() {
                if (this.mShowingBootMessages) {
                    this.mShowingBootMessages = SHOW_TRANSACTIONS;
                    this.mPolicy.hideBootMessages();
                }
            }

            public void setInTouchMode(boolean mode) {
                synchronized (this.mWindowMap) {
                    this.mInTouchMode = mode;
                }
            }

            public void updateCircularDisplayMaskIfNeeded() {
                int showMask = WALLPAPER_DRAW_NORMAL;
                if (this.mContext.getResources().getBoolean(17956989) && this.mContext.getResources().getBoolean(17956991)) {
                    if (Secure.getIntForUser(this.mContext.getContentResolver(), "accessibility_display_inversion_enabled", WALLPAPER_DRAW_NORMAL, this.mCurrentUserId) != WALLPAPER_DRAW_PENDING) {
                        showMask = WALLPAPER_DRAW_PENDING;
                    }
                    Message m = this.mH.obtainMessage(35);
                    m.arg1 = showMask;
                    this.mH.sendMessage(m);
                }
            }

            public void showEmulatorDisplayOverlayIfNeeded() {
                if (this.mContext.getResources().getBoolean(17956992) && SystemProperties.getBoolean(PROPERTY_EMULATOR_CIRCULAR, SHOW_TRANSACTIONS) && Build.HARDWARE.contains("goldfish")) {
                    this.mH.sendMessage(this.mH.obtainMessage(36));
                }
            }

            public void showCircularMask(boolean visible) {
                synchronized (this.mWindowMap) {
                    SurfaceControl.openTransaction();
                    if (visible) {
                        try {
                            if (this.mCircularDisplayMask == null) {
                                this.mCircularDisplayMask = new CircularDisplayMask(getDefaultDisplayContentLocked().getDisplay(), this.mFxSession, (this.mPolicy.windowTypeToLayerLw(2018) * TYPE_LAYER_MULTIPLIER) + 10, this.mContext.getResources().getDimensionPixelSize(17105055));
                            }
                            this.mCircularDisplayMask.setVisibility(HIDE_STACK_CRAWLS);
                        } catch (Throwable th) {
                            SurfaceControl.closeTransaction();
                        }
                    } else if (this.mCircularDisplayMask != null) {
                        this.mCircularDisplayMask.setVisibility(SHOW_TRANSACTIONS);
                        this.mCircularDisplayMask = null;
                    }
                    SurfaceControl.closeTransaction();
                }
            }

            public void showEmulatorDisplayOverlay() {
                synchronized (this.mWindowMap) {
                    SurfaceControl.openTransaction();
                    try {
                        if (this.mEmulatorDisplayOverlay == null) {
                            this.mEmulatorDisplayOverlay = new EmulatorDisplayOverlay(this.mContext, getDefaultDisplayContentLocked().getDisplay(), this.mFxSession, (this.mPolicy.windowTypeToLayerLw(2018) * TYPE_LAYER_MULTIPLIER) + 10);
                        }
                        this.mEmulatorDisplayOverlay.setVisibility(HIDE_STACK_CRAWLS);
                        SurfaceControl.closeTransaction();
                    } catch (Throwable th) {
                        SurfaceControl.closeTransaction();
                    }
                }
            }

            public void showStrictModeViolation(boolean on) {
                this.mH.sendMessage(this.mH.obtainMessage(25, on ? WALLPAPER_DRAW_PENDING : WALLPAPER_DRAW_NORMAL, Binder.getCallingPid()));
            }

            private void showStrictModeViolation(int arg, int pid) {
                boolean on = arg != 0 ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                synchronized (this.mWindowMap) {
                    if (on) {
                        boolean isVisible = SHOW_TRANSACTIONS;
                        int numDisplays = this.mDisplayContents.size();
                        for (int displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                            WindowList windows = ((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).getWindowList();
                            int numWindows = windows.size();
                            for (int winNdx = WALLPAPER_DRAW_NORMAL; winNdx < numWindows; winNdx += WALLPAPER_DRAW_PENDING) {
                                WindowState ws = (WindowState) windows.get(winNdx);
                                if (ws.mSession.mPid == pid && ws.isVisibleLw()) {
                                    isVisible = HIDE_STACK_CRAWLS;
                                    break;
                                }
                            }
                        }
                        if (!isVisible) {
                            return;
                        }
                    }
                    SurfaceControl.openTransaction();
                    try {
                        if (this.mStrictModeFlash == null) {
                            this.mStrictModeFlash = new StrictModeFlash(getDefaultDisplayContentLocked().getDisplay(), this.mFxSession);
                        }
                        this.mStrictModeFlash.setVisibility(on);
                    } finally {
                        SurfaceControl.closeTransaction();
                    }
                }
            }

            public void setStrictModeVisualIndicatorPreference(String value) {
                SystemProperties.set("persist.sys.strictmode.visual", value);
            }

            private static void convertCropForSurfaceFlinger(Rect crop, int rot, int dw, int dh) {
                int tmp;
                if (rot == WALLPAPER_DRAW_PENDING) {
                    tmp = crop.top;
                    crop.top = dw - crop.right;
                    crop.right = crop.bottom;
                    crop.bottom = dw - crop.left;
                    crop.left = tmp;
                } else if (rot == WALLPAPER_DRAW_TIMEOUT) {
                    tmp = crop.top;
                    crop.top = dh - crop.bottom;
                    crop.bottom = dh - tmp;
                    tmp = crop.right;
                    crop.right = dw - crop.left;
                    crop.left = dw - tmp;
                } else if (rot == UPDATE_FOCUS_WILL_PLACE_SURFACES) {
                    tmp = crop.top;
                    crop.top = crop.left;
                    crop.left = dh - crop.bottom;
                    crop.bottom = crop.right;
                    crop.right = dh - tmp;
                }
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public android.graphics.Bitmap screenshotApplications(android.os.IBinder r43, int r44, int r45, int r46, boolean r47) {
                /*
                r42 = this;
                r5 = "android.permission.READ_FRAME_BUFFER";
                r6 = "screenshotApplications()";
                r0 = r42;
                r5 = r0.checkCallingPermission(r5, r6);
                if (r5 != 0) goto L_0x0014;
            L_0x000c:
                r5 = new java.lang.SecurityException;
                r6 = "Requires READ_FRAME_BUFFER permission";
                r5.<init>(r6);
                throw r5;
            L_0x0014:
                r0 = r42;
                r1 = r44;
                r20 = r0.getDisplayContentLocked(r1);
                if (r20 != 0) goto L_0x0021;
            L_0x001e:
                r26 = 0;
            L_0x0020:
                return r26;
            L_0x0021:
                r21 = r20.getDisplayInfo();
                r0 = r21;
                r0 = r0.logicalWidth;
                r22 = r0;
                r0 = r21;
                r0 = r0.logicalHeight;
                r19 = r0;
                if (r22 == 0) goto L_0x0035;
            L_0x0033:
                if (r19 != 0) goto L_0x0038;
            L_0x0035:
                r26 = 0;
                goto L_0x0020;
            L_0x0038:
                r14 = 0;
                r8 = 0;
                r23 = new android.graphics.Rect;
                r23.<init>();
                r33 = new android.graphics.Rect;
                r33.<init>();
                r30 = 0;
                r10 = 0;
                if (r43 != 0) goto L_0x00bd;
            L_0x0049:
                r32 = 1;
                r7 = 0;
            L_0x004c:
                r27 = 0;
                r13 = 0;
                r0 = r42;
                r5 = r0.mInputMethodTarget;
                if (r5 == 0) goto L_0x00c3;
            L_0x0055:
                r0 = r42;
                r5 = r0.mInputMethodTarget;
                r5 = r5.mAppToken;
                if (r5 == 0) goto L_0x00c3;
            L_0x005d:
                r0 = r42;
                r5 = r0.mInputMethodTarget;
                r5 = r5.mAppToken;
                r5 = r5.appToken;
                if (r5 == 0) goto L_0x00c3;
            L_0x0067:
                r0 = r42;
                r5 = r0.mInputMethodTarget;
                r5 = r5.mAppToken;
                r5 = r5.appToken;
                r5 = r5.asBinder();
                r0 = r43;
                if (r5 != r0) goto L_0x00c3;
            L_0x0077:
                r12 = 1;
            L_0x0078:
                r0 = r42;
                r5 = r0.mPolicy;
                r6 = 2;
                r5 = r5.windowTypeToLayerLw(r6);
                r5 = r5 + 1;
                r5 = r5 * 10000;
                r11 = r5 + 1000;
                r28 = r27;
            L_0x0089:
                r27 = r28 + 1;
                if (r28 <= 0) goto L_0x0096;
            L_0x008d:
                r8 = 0;
                r7 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
                r40 = 100;
                java.lang.Thread.sleep(r40);	 Catch:{ InterruptedException -> 0x02f8 }
            L_0x0096:
                r0 = r42;
                r0 = r0.mWindowMap;
                r39 = r0;
                monitor-enter(r39);
                r13 = 0;
                r37 = r20.getWindowList();	 Catch:{ all -> 0x0179 }
                r5 = r37.size();	 Catch:{ all -> 0x0179 }
                r24 = r5 + -1;
            L_0x00a8:
                if (r24 < 0) goto L_0x0170;
            L_0x00aa:
                r0 = r37;
                r1 = r24;
                r38 = r0.get(r1);	 Catch:{ all -> 0x0179 }
                r38 = (com.android.server.wm.WindowState) r38;	 Catch:{ all -> 0x0179 }
                r0 = r38;
                r5 = r0.mHasSurface;	 Catch:{ all -> 0x0179 }
                if (r5 != 0) goto L_0x00c5;
            L_0x00ba:
                r24 = r24 + -1;
                goto L_0x00a8;
            L_0x00bd:
                r32 = 0;
                r7 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
                goto L_0x004c;
            L_0x00c3:
                r12 = 0;
                goto L_0x0078;
            L_0x00c5:
                r0 = r38;
                r5 = r0.mLayer;	 Catch:{ all -> 0x0179 }
                if (r5 >= r11) goto L_0x00ba;
            L_0x00cb:
                r0 = r38;
                r5 = r0.mIsImWindow;	 Catch:{ all -> 0x0179 }
                if (r5 == 0) goto L_0x017c;
            L_0x00d1:
                if (r12 == 0) goto L_0x00ba;
            L_0x00d3:
                r0 = r38;
                r0 = r0.mWinAnimator;	 Catch:{ all -> 0x0179 }
                r36 = r0;
                r0 = r36;
                r5 = r0.mSurfaceLayer;	 Catch:{ all -> 0x0179 }
                if (r8 >= r5) goto L_0x00e3;
            L_0x00df:
                r0 = r36;
                r8 = r0.mSurfaceLayer;	 Catch:{ all -> 0x0179 }
            L_0x00e3:
                r0 = r36;
                r5 = r0.mSurfaceLayer;	 Catch:{ all -> 0x0179 }
                if (r7 <= r5) goto L_0x00ed;
            L_0x00e9:
                r0 = r36;
                r7 = r0.mSurfaceLayer;	 Catch:{ all -> 0x0179 }
            L_0x00ed:
                r0 = r38;
                r5 = r0.mIsWallpaper;	 Catch:{ all -> 0x0179 }
                if (r5 != 0) goto L_0x0140;
            L_0x00f3:
                r0 = r38;
                r0 = r0.mFrame;	 Catch:{ all -> 0x0179 }
                r35 = r0;
                r0 = r38;
                r0 = r0.mContentInsets;	 Catch:{ all -> 0x0179 }
                r16 = r0;
                r0 = r35;
                r5 = r0.left;	 Catch:{ all -> 0x0179 }
                r0 = r16;
                r6 = r0.left;	 Catch:{ all -> 0x0179 }
                r25 = r5 + r6;
                r0 = r35;
                r5 = r0.top;	 Catch:{ all -> 0x0179 }
                r0 = r16;
                r6 = r0.top;	 Catch:{ all -> 0x0179 }
                r34 = r5 + r6;
                r0 = r35;
                r5 = r0.right;	 Catch:{ all -> 0x0179 }
                r0 = r16;
                r6 = r0.right;	 Catch:{ all -> 0x0179 }
                r29 = r5 - r6;
                r0 = r35;
                r5 = r0.bottom;	 Catch:{ all -> 0x0179 }
                r0 = r16;
                r6 = r0.bottom;	 Catch:{ all -> 0x0179 }
                r15 = r5 - r6;
                r0 = r23;
                r1 = r25;
                r2 = r34;
                r3 = r29;
                r0.union(r1, r2, r3, r15);	 Catch:{ all -> 0x0179 }
                r0 = r38;
                r1 = r33;
                r0.getStackBounds(r1);	 Catch:{ all -> 0x0179 }
                r0 = r23;
                r1 = r33;
                r0.intersect(r1);	 Catch:{ all -> 0x0179 }
            L_0x0140:
                r0 = r38;
                r5 = r0.mAppToken;	 Catch:{ all -> 0x0179 }
                if (r5 == 0) goto L_0x015e;
            L_0x0146:
                r0 = r38;
                r5 = r0.mAppToken;	 Catch:{ all -> 0x0179 }
                r5 = r5.token;	 Catch:{ all -> 0x0179 }
                r0 = r43;
                if (r5 != r0) goto L_0x015e;
            L_0x0150:
                r5 = r38.isDisplayedLw();	 Catch:{ all -> 0x0179 }
                if (r5 == 0) goto L_0x015e;
            L_0x0156:
                r0 = r36;
                r5 = r0.mSurfaceShown;	 Catch:{ all -> 0x0179 }
                if (r5 == 0) goto L_0x015e;
            L_0x015c:
                r32 = 1;
            L_0x015e:
                r0 = r38;
                r1 = r22;
                r2 = r19;
                r5 = r0.isFullscreen(r1, r2);	 Catch:{ all -> 0x0179 }
                if (r5 == 0) goto L_0x00ba;
            L_0x016a:
                r5 = r38.isOpaqueDrawn();	 Catch:{ all -> 0x0179 }
                if (r5 == 0) goto L_0x00ba;
            L_0x0170:
                if (r43 == 0) goto L_0x019c;
            L_0x0172:
                if (r13 != 0) goto L_0x019c;
            L_0x0174:
                r26 = 0;
                monitor-exit(r39);	 Catch:{ all -> 0x0179 }
                goto L_0x0020;
            L_0x0179:
                r5 = move-exception;
                monitor-exit(r39);	 Catch:{ all -> 0x0179 }
                throw r5;
            L_0x017c:
                r0 = r38;
                r5 = r0.mIsWallpaper;	 Catch:{ all -> 0x0179 }
                if (r5 == 0) goto L_0x0186;
            L_0x0182:
                if (r13 != 0) goto L_0x00d3;
            L_0x0184:
                goto L_0x00ba;
            L_0x0186:
                if (r43 == 0) goto L_0x00d3;
            L_0x0188:
                r0 = r38;
                r5 = r0.mAppToken;	 Catch:{ all -> 0x0179 }
                if (r5 == 0) goto L_0x00ba;
            L_0x018e:
                r0 = r38;
                r5 = r0.mAppToken;	 Catch:{ all -> 0x0179 }
                r5 = r5.token;	 Catch:{ all -> 0x0179 }
                r0 = r43;
                if (r5 != r0) goto L_0x00ba;
            L_0x0198:
                r13 = r38;
                goto L_0x00d3;
            L_0x019c:
                if (r32 != 0) goto L_0x020f;
            L_0x019e:
                r5 = 3;
                r0 = r27;
                if (r0 <= r5) goto L_0x020a;
            L_0x01a3:
                r6 = "WindowManager";
                r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0179 }
                r5.<init>();	 Catch:{ all -> 0x0179 }
                r40 = "Screenshot max retries ";
                r0 = r40;
                r5 = r5.append(r0);	 Catch:{ all -> 0x0179 }
                r0 = r27;
                r5 = r5.append(r0);	 Catch:{ all -> 0x0179 }
                r40 = " of ";
                r0 = r40;
                r5 = r5.append(r0);	 Catch:{ all -> 0x0179 }
                r0 = r43;
                r5 = r5.append(r0);	 Catch:{ all -> 0x0179 }
                r40 = " appWin=";
                r0 = r40;
                r40 = r5.append(r0);	 Catch:{ all -> 0x0179 }
                if (r13 != 0) goto L_0x01e4;
            L_0x01d0:
                r5 = "null";
            L_0x01d2:
                r0 = r40;
                r5 = r0.append(r5);	 Catch:{ all -> 0x0179 }
                r5 = r5.toString();	 Catch:{ all -> 0x0179 }
                android.util.Slog.i(r6, r5);	 Catch:{ all -> 0x0179 }
                r26 = 0;
                monitor-exit(r39);	 Catch:{ all -> 0x0179 }
                goto L_0x0020;
            L_0x01e4:
                r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0179 }
                r5.<init>();	 Catch:{ all -> 0x0179 }
                r5 = r5.append(r13);	 Catch:{ all -> 0x0179 }
                r41 = " drawState=";
                r0 = r41;
                r5 = r5.append(r0);	 Catch:{ all -> 0x0179 }
                r0 = r13.mWinAnimator;	 Catch:{ all -> 0x0179 }
                r41 = r0;
                r0 = r41;
                r0 = r0.mDrawState;	 Catch:{ all -> 0x0179 }
                r41 = r0;
                r0 = r41;
                r5 = r5.append(r0);	 Catch:{ all -> 0x0179 }
                r5 = r5.toString();	 Catch:{ all -> 0x0179 }
                goto L_0x01d2;
            L_0x020a:
                monitor-exit(r39);	 Catch:{ all -> 0x0179 }
                r28 = r27;
                goto L_0x0089;
            L_0x020f:
                if (r8 != 0) goto L_0x0216;
            L_0x0211:
                r26 = 0;
                monitor-exit(r39);	 Catch:{ all -> 0x0179 }
                goto L_0x0020;
            L_0x0216:
                r5 = 0;
                r6 = 0;
                r0 = r23;
                r1 = r22;
                r2 = r19;
                r0.intersect(r5, r6, r1, r2);	 Catch:{ all -> 0x0179 }
                r4 = new android.graphics.Rect;	 Catch:{ all -> 0x0179 }
                r0 = r23;
                r4.<init>(r0);	 Catch:{ all -> 0x0179 }
                r0 = r45;
                r5 = (float) r0;	 Catch:{ all -> 0x0179 }
                r6 = r23.width();	 Catch:{ all -> 0x0179 }
                r6 = (float) r6;	 Catch:{ all -> 0x0179 }
                r5 = r5 / r6;
                r0 = r46;
                r6 = (float) r0;	 Catch:{ all -> 0x0179 }
                r40 = r23.height();	 Catch:{ all -> 0x0179 }
                r0 = r40;
                r0 = (float) r0;	 Catch:{ all -> 0x0179 }
                r40 = r0;
                r6 = r6 / r40;
                r5 = (r5 > r6 ? 1 : (r5 == r6 ? 0 : -1));
                if (r5 >= 0) goto L_0x02cd;
            L_0x0243:
                r0 = r45;
                r5 = (float) r0;	 Catch:{ all -> 0x0179 }
                r0 = r46;
                r6 = (float) r0;	 Catch:{ all -> 0x0179 }
                r5 = r5 / r6;
                r6 = r23.height();	 Catch:{ all -> 0x0179 }
                r6 = (float) r6;	 Catch:{ all -> 0x0179 }
                r5 = r5 * r6;
                r0 = (int) r5;	 Catch:{ all -> 0x0179 }
                r18 = r0;
                r5 = r4.left;	 Catch:{ all -> 0x0179 }
                r5 = r5 + r18;
                r4.right = r5;	 Catch:{ all -> 0x0179 }
            L_0x0259:
                r5 = r42.getDefaultDisplayContentLocked();	 Catch:{ all -> 0x0179 }
                r5 = r5.getDisplay();	 Catch:{ all -> 0x0179 }
                r10 = r5.getRotation();	 Catch:{ all -> 0x0179 }
                r5 = 1;
                if (r10 == r5) goto L_0x026b;
            L_0x0268:
                r5 = 3;
                if (r10 != r5) goto L_0x026f;
            L_0x026b:
                r5 = 1;
                if (r10 != r5) goto L_0x02e5;
            L_0x026e:
                r10 = 3;
            L_0x026f:
                r0 = r22;
                r1 = r19;
                convertCropForSurfaceFlinger(r4, r10, r0, r1);	 Catch:{ all -> 0x0179 }
                r0 = r42;
                r5 = r0.mAnimator;	 Catch:{ all -> 0x0179 }
                r6 = 0;
                r31 = r5.getScreenRotationAnimationLocked(r6);	 Catch:{ all -> 0x0179 }
                if (r31 == 0) goto L_0x02e7;
            L_0x0281:
                r5 = r31.isAnimating();	 Catch:{ all -> 0x0179 }
                if (r5 == 0) goto L_0x02e7;
            L_0x0287:
                r9 = 1;
            L_0x0288:
                r5 = r45;
                r6 = r46;
                r14 = android.view.SurfaceControl.screenshot(r4, r5, r6, r7, r8, r9, r10);	 Catch:{ all -> 0x0179 }
                if (r14 != 0) goto L_0x02e9;
            L_0x0292:
                r5 = "WindowManager";
                r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0179 }
                r6.<init>();	 Catch:{ all -> 0x0179 }
                r40 = "Screenshot failure taking screenshot for (";
                r0 = r40;
                r6 = r6.append(r0);	 Catch:{ all -> 0x0179 }
                r0 = r22;
                r6 = r6.append(r0);	 Catch:{ all -> 0x0179 }
                r40 = "x";
                r0 = r40;
                r6 = r6.append(r0);	 Catch:{ all -> 0x0179 }
                r0 = r19;
                r6 = r6.append(r0);	 Catch:{ all -> 0x0179 }
                r40 = ") to layer ";
                r0 = r40;
                r6 = r6.append(r0);	 Catch:{ all -> 0x0179 }
                r6 = r6.append(r8);	 Catch:{ all -> 0x0179 }
                r6 = r6.toString();	 Catch:{ all -> 0x0179 }
                android.util.Slog.w(r5, r6);	 Catch:{ all -> 0x0179 }
                r26 = 0;
                monitor-exit(r39);	 Catch:{ all -> 0x0179 }
                goto L_0x0020;
            L_0x02cd:
                r0 = r46;
                r5 = (float) r0;	 Catch:{ all -> 0x0179 }
                r0 = r45;
                r6 = (float) r0;	 Catch:{ all -> 0x0179 }
                r5 = r5 / r6;
                r6 = r23.width();	 Catch:{ all -> 0x0179 }
                r6 = (float) r6;	 Catch:{ all -> 0x0179 }
                r5 = r5 * r6;
                r0 = (int) r5;	 Catch:{ all -> 0x0179 }
                r17 = r0;
                r5 = r4.top;	 Catch:{ all -> 0x0179 }
                r5 = r5 + r17;
                r4.bottom = r5;	 Catch:{ all -> 0x0179 }
                goto L_0x0259;
            L_0x02e5:
                r10 = 1;
                goto L_0x026f;
            L_0x02e7:
                r9 = 0;
                goto L_0x0288;
            L_0x02e9:
                monitor-exit(r39);	 Catch:{ all -> 0x0179 }
                r5 = r14.getConfig();
                r6 = 1;
                r26 = r14.copy(r5, r6);
                r14.recycle();
                goto L_0x0020;
            L_0x02f8:
                r5 = move-exception;
                goto L_0x0096;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.screenshotApplications(android.os.IBinder, int, int, int, boolean):android.graphics.Bitmap");
            }

            public void freezeRotation(int rotation) {
                if (!checkCallingPermission("android.permission.SET_ORIENTATION", "freezeRotation()")) {
                    throw new SecurityException("Requires SET_ORIENTATION permission");
                } else if (rotation < -1 || rotation > UPDATE_FOCUS_WILL_PLACE_SURFACES) {
                    throw new IllegalArgumentException("Rotation argument must be -1 or a valid rotation constant.");
                } else {
                    long origId = Binder.clearCallingIdentity();
                    try {
                        WindowManagerPolicy windowManagerPolicy = this.mPolicy;
                        if (rotation == -1) {
                            rotation = this.mRotation;
                        }
                        windowManagerPolicy.setUserRotationMode(WALLPAPER_DRAW_PENDING, rotation);
                        updateRotationUnchecked(SHOW_TRANSACTIONS, SHOW_TRANSACTIONS);
                    } finally {
                        Binder.restoreCallingIdentity(origId);
                    }
                }
            }

            public void thawRotation() {
                if (checkCallingPermission("android.permission.SET_ORIENTATION", "thawRotation()")) {
                    long origId = Binder.clearCallingIdentity();
                    try {
                        this.mPolicy.setUserRotationMode(WALLPAPER_DRAW_NORMAL, 777);
                        updateRotationUnchecked(SHOW_TRANSACTIONS, SHOW_TRANSACTIONS);
                    } finally {
                        Binder.restoreCallingIdentity(origId);
                    }
                } else {
                    throw new SecurityException("Requires SET_ORIENTATION permission");
                }
            }

            public void updateRotation(boolean alwaysSendConfiguration, boolean forceRelayout) {
                updateRotationUnchecked(alwaysSendConfiguration, forceRelayout);
            }

            void pauseRotationLocked() {
                this.mDeferredRotationPauseCount += WALLPAPER_DRAW_PENDING;
            }

            void resumeRotationLocked() {
                if (this.mDeferredRotationPauseCount > 0) {
                    this.mDeferredRotationPauseCount--;
                    if (this.mDeferredRotationPauseCount == 0 && updateRotationUncheckedLocked(SHOW_TRANSACTIONS)) {
                        this.mH.sendEmptyMessage(18);
                    }
                }
            }

            public void updateRotationUnchecked(boolean alwaysSendConfiguration, boolean forceRelayout) {
                long origId = Binder.clearCallingIdentity();
                synchronized (this.mWindowMap) {
                    boolean changed = updateRotationUncheckedLocked(SHOW_TRANSACTIONS);
                    if (!changed || forceRelayout) {
                        getDefaultDisplayContentLocked().layoutNeeded = HIDE_STACK_CRAWLS;
                        performLayoutAndPlaceSurfacesLocked();
                    }
                }
                if (changed || alwaysSendConfiguration) {
                    sendNewConfiguration();
                }
                Binder.restoreCallingIdentity(origId);
            }

            public boolean updateRotationUncheckedLocked(boolean inTransaction) {
                if (this.mDeferredRotationPauseCount > 0) {
                    return SHOW_TRANSACTIONS;
                }
                ScreenRotationAnimation screenRotationAnimation = this.mAnimator.getScreenRotationAnimationLocked(WALLPAPER_DRAW_NORMAL);
                if (screenRotationAnimation != null && screenRotationAnimation.isAnimating()) {
                    return SHOW_TRANSACTIONS;
                }
                if (!this.mDisplayEnabled) {
                    return SHOW_TRANSACTIONS;
                }
                int rotation = this.mPolicy.rotationForOrientationLw(this.mForcedAppOrientation, this.mRotation);
                boolean altOrientation = !this.mPolicy.rotationHasCompatibleMetricsLw(this.mForcedAppOrientation, rotation) ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                if (this.mRotation == rotation && this.mAltOrientation == altOrientation) {
                    return SHOW_TRANSACTIONS;
                }
                int i;
                this.mRotation = rotation;
                this.mAltOrientation = altOrientation;
                this.mPolicy.setRotationLw(this.mRotation);
                this.mWindowsFreezingScreen = HIDE_STACK_CRAWLS;
                this.mH.removeMessages(11);
                this.mH.sendEmptyMessageDelayed(11, 2000);
                this.mWaitingForConfig = HIDE_STACK_CRAWLS;
                DisplayContent displayContent = getDefaultDisplayContentLocked();
                displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                int[] anim = new int[WALLPAPER_DRAW_TIMEOUT];
                if (displayContent.isDimming()) {
                    anim[WALLPAPER_DRAW_PENDING] = WALLPAPER_DRAW_NORMAL;
                    anim[WALLPAPER_DRAW_NORMAL] = WALLPAPER_DRAW_NORMAL;
                } else {
                    this.mPolicy.selectRotationAnimationLw(anim);
                }
                startFreezingDisplayLocked(inTransaction, anim[WALLPAPER_DRAW_NORMAL], anim[WALLPAPER_DRAW_PENDING]);
                screenRotationAnimation = this.mAnimator.getScreenRotationAnimationLocked(WALLPAPER_DRAW_NORMAL);
                computeScreenConfigurationLocked(null);
                DisplayInfo displayInfo = displayContent.getDisplayInfo();
                if (!inTransaction) {
                    SurfaceControl.openTransaction();
                }
                if (screenRotationAnimation != null) {
                    try {
                        if (screenRotationAnimation.hasScreenshot() && screenRotationAnimation.setRotationInTransaction(rotation, this.mFxSession, WALLPAPER_TIMEOUT_RECOVERY, getTransitionAnimationScaleLocked(), displayInfo.logicalWidth, displayInfo.logicalHeight)) {
                            scheduleAnimationLocked();
                        }
                    } catch (Throwable th) {
                        if (!inTransaction) {
                            SurfaceControl.closeTransaction();
                        }
                    }
                }
                this.mDisplayManagerInternal.performTraversalInTransactionFromWindowManager();
                if (!inTransaction) {
                    SurfaceControl.closeTransaction();
                }
                WindowList windows = displayContent.getWindowList();
                for (i = windows.size() - 1; i >= 0; i--) {
                    WindowState w = (WindowState) windows.get(i);
                    if (w.mHasSurface) {
                        w.mOrientationChanging = HIDE_STACK_CRAWLS;
                        this.mInnerFields.mOrientationChangeComplete = SHOW_TRANSACTIONS;
                    }
                    w.mLastFreezeDuration = WALLPAPER_DRAW_NORMAL;
                }
                for (i = this.mRotationWatchers.size() - 1; i >= 0; i--) {
                    try {
                        ((RotationWatcher) this.mRotationWatchers.get(i)).watcher.onRotationChanged(rotation);
                    } catch (RemoteException e) {
                    }
                }
                if (screenRotationAnimation == null && this.mAccessibilityController != null && displayContent.getDisplayId() == 0) {
                    this.mAccessibilityController.onRotationChangedLocked(getDefaultDisplayContentLocked(), rotation);
                }
                return HIDE_STACK_CRAWLS;
            }

            public int getRotation() {
                return this.mRotation;
            }

            public boolean isRotationFrozen() {
                return this.mPolicy.getUserRotationMode() == WALLPAPER_DRAW_PENDING ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
            }

            public int watchRotation(IRotationWatcher watcher) {
                int i;
                DeathRecipient dr = new C05687(watcher.asBinder());
                synchronized (this.mWindowMap) {
                    try {
                        watcher.asBinder().linkToDeath(dr, WALLPAPER_DRAW_NORMAL);
                        this.mRotationWatchers.add(new RotationWatcher(watcher, dr));
                    } catch (RemoteException e) {
                    }
                    i = this.mRotation;
                }
                return i;
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public void removeRotationWatcher(android.view.IRotationWatcher r9) {
                /*
                r8 = this;
                r4 = r9.asBinder();
                r6 = r8.mWindowMap;
                monitor-enter(r6);
                r1 = 0;
            L_0x0008:
                r5 = r8.mRotationWatchers;	 Catch:{ all -> 0x003d }
                r5 = r5.size();	 Catch:{ all -> 0x003d }
                if (r1 >= r5) goto L_0x003b;
            L_0x0010:
                r5 = r8.mRotationWatchers;	 Catch:{ all -> 0x003d }
                r3 = r5.get(r1);	 Catch:{ all -> 0x003d }
                r3 = (com.android.server.wm.WindowManagerService.RotationWatcher) r3;	 Catch:{ all -> 0x003d }
                r5 = r3.watcher;	 Catch:{ all -> 0x003d }
                r5 = r5.asBinder();	 Catch:{ all -> 0x003d }
                if (r4 != r5) goto L_0x0038;
            L_0x0020:
                r5 = r8.mRotationWatchers;	 Catch:{ all -> 0x003d }
                r2 = r5.remove(r1);	 Catch:{ all -> 0x003d }
                r2 = (com.android.server.wm.WindowManagerService.RotationWatcher) r2;	 Catch:{ all -> 0x003d }
                r5 = r2.watcher;	 Catch:{ all -> 0x003d }
                r0 = r5.asBinder();	 Catch:{ all -> 0x003d }
                if (r0 == 0) goto L_0x0036;
            L_0x0030:
                r5 = r2.deathRecipient;	 Catch:{ all -> 0x003d }
                r7 = 0;
                r0.unlinkToDeath(r5, r7);	 Catch:{ all -> 0x003d }
            L_0x0036:
                r1 = r1 + -1;
            L_0x0038:
                r1 = r1 + 1;
                goto L_0x0008;
            L_0x003b:
                monitor-exit(r6);	 Catch:{ all -> 0x003d }
                return;
            L_0x003d:
                r5 = move-exception;
                monitor-exit(r6);	 Catch:{ all -> 0x003d }
                throw r5;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.removeRotationWatcher(android.view.IRotationWatcher):void");
            }

            public int getPreferredOptionsPanelGravity() {
                synchronized (this.mWindowMap) {
                    int rotation = getRotation();
                    DisplayContent displayContent = getDefaultDisplayContentLocked();
                    if (displayContent.mInitialDisplayWidth < displayContent.mInitialDisplayHeight) {
                        switch (rotation) {
                            case WALLPAPER_DRAW_PENDING /*1*/:
                                return 85;
                            case WALLPAPER_DRAW_TIMEOUT /*2*/:
                                return 81;
                            case UPDATE_FOCUS_WILL_PLACE_SURFACES /*3*/:
                                return 8388691;
                            default:
                                return 81;
                        }
                    } else {
                        switch (rotation) {
                            case WALLPAPER_DRAW_PENDING /*1*/:
                                return 81;
                            case WALLPAPER_DRAW_TIMEOUT /*2*/:
                                return 8388691;
                            case UPDATE_FOCUS_WILL_PLACE_SURFACES /*3*/:
                                return 81;
                            default:
                                return 85;
                        }
                    }
                }
            }

            public boolean startViewServer(int port) {
                boolean z = SHOW_TRANSACTIONS;
                if (!isSystemSecure() && checkCallingPermission("android.permission.DUMP", "startViewServer") && port >= DumpState.DUMP_PREFERRED_XML) {
                    if (this.mViewServer == null) {
                        try {
                            this.mViewServer = new ViewServer(this, port);
                            z = this.mViewServer.start();
                        } catch (IOException e) {
                            Slog.w(TAG, "View server did not start");
                        }
                    } else if (!this.mViewServer.isRunning()) {
                        try {
                            z = this.mViewServer.start();
                        } catch (IOException e2) {
                            Slog.w(TAG, "View server did not start");
                        }
                    }
                }
                return z;
            }

            private boolean isSystemSecure() {
                return ("1".equals(SystemProperties.get(SYSTEM_SECURE, "1")) && "0".equals(SystemProperties.get(SYSTEM_DEBUGGABLE, "0"))) ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
            }

            public boolean stopViewServer() {
                if (isSystemSecure() || !checkCallingPermission("android.permission.DUMP", "stopViewServer") || this.mViewServer == null) {
                    return SHOW_TRANSACTIONS;
                }
                return this.mViewServer.stop();
            }

            public boolean isViewServerRunning() {
                if (!isSystemSecure() && checkCallingPermission("android.permission.DUMP", "isViewServerRunning") && this.mViewServer != null && this.mViewServer.isRunning()) {
                    return HIDE_STACK_CRAWLS;
                }
                return SHOW_TRANSACTIONS;
            }

            boolean viewServerListWindows(Socket client) {
                Throwable th;
                if (isSystemSecure()) {
                    return SHOW_TRANSACTIONS;
                }
                WindowList windows = new WindowList();
                synchronized (this.mWindowMap) {
                    int numDisplays = this.mDisplayContents.size();
                    for (int displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                        windows.addAll(((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).getWindowList());
                    }
                }
                BufferedWriter out = null;
                try {
                    BufferedWriter out2 = new BufferedWriter(new OutputStreamWriter(client.getOutputStream()), DumpState.DUMP_INSTALLS);
                    try {
                        int count = windows.size();
                        for (int i = WALLPAPER_DRAW_NORMAL; i < count; i += WALLPAPER_DRAW_PENDING) {
                            WindowState w = (WindowState) windows.get(i);
                            out2.write(Integer.toHexString(System.identityHashCode(w)));
                            out2.write(32);
                            out2.append(w.mAttrs.getTitle());
                            out2.write(10);
                        }
                        out2.write("DONE.\n");
                        out2.flush();
                        if (out2 != null) {
                            try {
                                out2.close();
                                out = out2;
                                return HIDE_STACK_CRAWLS;
                            } catch (IOException e) {
                                out = out2;
                                return SHOW_TRANSACTIONS;
                            }
                        }
                        return HIDE_STACK_CRAWLS;
                    } catch (Exception e2) {
                        out = out2;
                        if (out != null) {
                            return SHOW_TRANSACTIONS;
                        }
                        try {
                            out.close();
                            return SHOW_TRANSACTIONS;
                        } catch (IOException e3) {
                            return SHOW_TRANSACTIONS;
                        }
                    } catch (Throwable th2) {
                        th = th2;
                        out = out2;
                        if (out != null) {
                            try {
                                out.close();
                            } catch (IOException e4) {
                            }
                        }
                        throw th;
                    }
                } catch (Exception e5) {
                    if (out != null) {
                        return SHOW_TRANSACTIONS;
                    }
                    out.close();
                    return SHOW_TRANSACTIONS;
                } catch (Throwable th3) {
                    th = th3;
                    if (out != null) {
                        out.close();
                    }
                    throw th;
                }
            }

            boolean viewServerGetFocusedWindow(Socket client) {
                Throwable th;
                if (isSystemSecure()) {
                    return SHOW_TRANSACTIONS;
                }
                WindowState focusedWindow = getFocusedWindow();
                BufferedWriter out = null;
                try {
                    BufferedWriter out2 = new BufferedWriter(new OutputStreamWriter(client.getOutputStream()), DumpState.DUMP_INSTALLS);
                    if (focusedWindow != null) {
                        try {
                            out2.write(Integer.toHexString(System.identityHashCode(focusedWindow)));
                            out2.write(32);
                            out2.append(focusedWindow.mAttrs.getTitle());
                        } catch (Exception e) {
                            out = out2;
                            if (out != null) {
                                return SHOW_TRANSACTIONS;
                            }
                            try {
                                out.close();
                                return SHOW_TRANSACTIONS;
                            } catch (IOException e2) {
                                return SHOW_TRANSACTIONS;
                            }
                        } catch (Throwable th2) {
                            th = th2;
                            out = out2;
                            if (out != null) {
                                try {
                                    out.close();
                                } catch (IOException e3) {
                                }
                            }
                            throw th;
                        }
                    }
                    out2.write(10);
                    out2.flush();
                    if (out2 != null) {
                        try {
                            out2.close();
                            out = out2;
                            return HIDE_STACK_CRAWLS;
                        } catch (IOException e4) {
                            out = out2;
                            return SHOW_TRANSACTIONS;
                        }
                    }
                    return HIDE_STACK_CRAWLS;
                } catch (Exception e5) {
                    if (out != null) {
                        return SHOW_TRANSACTIONS;
                    }
                    out.close();
                    return SHOW_TRANSACTIONS;
                } catch (Throwable th3) {
                    th = th3;
                    if (out != null) {
                        out.close();
                    }
                    throw th;
                }
            }

            boolean viewServerWindowCommand(Socket client, String command, String parameters) {
                Exception e;
                Throwable th;
                if (isSystemSecure()) {
                    return SHOW_TRANSACTIONS;
                }
                Parcel data = null;
                Parcel reply = null;
                BufferedWriter out = null;
                try {
                    int index = parameters.indexOf(32);
                    if (index == -1) {
                        index = parameters.length();
                    }
                    int hashCode = (int) Long.parseLong(parameters.substring(WALLPAPER_DRAW_NORMAL, index), 16);
                    if (index < parameters.length()) {
                        parameters = parameters.substring(index + WALLPAPER_DRAW_PENDING);
                    } else {
                        parameters = "";
                    }
                    WindowState window = findWindow(hashCode);
                    if (window == null) {
                        if (data != null) {
                            data.recycle();
                        }
                        if (reply != null) {
                            reply.recycle();
                        }
                        if (out == null) {
                            return SHOW_TRANSACTIONS;
                        }
                        try {
                            out.close();
                            return SHOW_TRANSACTIONS;
                        } catch (IOException e2) {
                            return SHOW_TRANSACTIONS;
                        }
                    }
                    data = Parcel.obtain();
                    data.writeInterfaceToken("android.view.IWindow");
                    data.writeString(command);
                    data.writeString(parameters);
                    data.writeInt(WALLPAPER_DRAW_PENDING);
                    ParcelFileDescriptor.fromSocket(client).writeToParcel(data, WALLPAPER_DRAW_NORMAL);
                    reply = Parcel.obtain();
                    window.mClient.asBinder().transact(WALLPAPER_DRAW_PENDING, data, reply, WALLPAPER_DRAW_NORMAL);
                    reply.readException();
                    if (!client.isOutputShutdown()) {
                        BufferedWriter out2 = new BufferedWriter(new OutputStreamWriter(client.getOutputStream()));
                        try {
                            out2.write("DONE\n");
                            out2.flush();
                            out = out2;
                        } catch (Exception e3) {
                            e = e3;
                            out = out2;
                            try {
                                Slog.w(TAG, "Could not send command " + command + " with parameters " + parameters, e);
                                if (data != null) {
                                    data.recycle();
                                }
                                if (reply != null) {
                                    reply.recycle();
                                }
                                if (out != null) {
                                    return SHOW_TRANSACTIONS;
                                }
                                try {
                                    out.close();
                                    return SHOW_TRANSACTIONS;
                                } catch (IOException e4) {
                                    return SHOW_TRANSACTIONS;
                                }
                            } catch (Throwable th2) {
                                th = th2;
                                if (data != null) {
                                    data.recycle();
                                }
                                if (reply != null) {
                                    reply.recycle();
                                }
                                if (out != null) {
                                    try {
                                        out.close();
                                    } catch (IOException e5) {
                                    }
                                }
                                throw th;
                            }
                        } catch (Throwable th3) {
                            th = th3;
                            out = out2;
                            if (data != null) {
                                data.recycle();
                            }
                            if (reply != null) {
                                reply.recycle();
                            }
                            if (out != null) {
                                out.close();
                            }
                            throw th;
                        }
                    }
                    if (data != null) {
                        data.recycle();
                    }
                    if (reply != null) {
                        reply.recycle();
                    }
                    if (out == null) {
                        return HIDE_STACK_CRAWLS;
                    }
                    try {
                        out.close();
                        return HIDE_STACK_CRAWLS;
                    } catch (IOException e6) {
                        return HIDE_STACK_CRAWLS;
                    }
                } catch (Exception e7) {
                    e = e7;
                    Slog.w(TAG, "Could not send command " + command + " with parameters " + parameters, e);
                    if (data != null) {
                        data.recycle();
                    }
                    if (reply != null) {
                        reply.recycle();
                    }
                    if (out != null) {
                        return SHOW_TRANSACTIONS;
                    }
                    out.close();
                    return SHOW_TRANSACTIONS;
                }
            }

            public void addWindowChangeListener(WindowChangeListener listener) {
                synchronized (this.mWindowMap) {
                    this.mWindowChangeListeners.add(listener);
                }
            }

            public void removeWindowChangeListener(WindowChangeListener listener) {
                synchronized (this.mWindowMap) {
                    this.mWindowChangeListeners.remove(listener);
                }
            }

            private void notifyWindowsChanged() {
                synchronized (this.mWindowMap) {
                    if (this.mWindowChangeListeners.isEmpty()) {
                        return;
                    }
                    WindowChangeListener[] windowChangeListeners = (WindowChangeListener[]) this.mWindowChangeListeners.toArray(new WindowChangeListener[this.mWindowChangeListeners.size()]);
                    int N = windowChangeListeners.length;
                    for (int i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                        windowChangeListeners[i].windowsChanged();
                    }
                }
            }

            private void notifyFocusChanged() {
                synchronized (this.mWindowMap) {
                    if (this.mWindowChangeListeners.isEmpty()) {
                        return;
                    }
                    WindowChangeListener[] windowChangeListeners = (WindowChangeListener[]) this.mWindowChangeListeners.toArray(new WindowChangeListener[this.mWindowChangeListeners.size()]);
                    int N = windowChangeListeners.length;
                    for (int i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                        windowChangeListeners[i].focusChanged();
                    }
                }
            }

            private WindowState findWindow(int hashCode) {
                if (hashCode == -1) {
                    return getFocusedWindow();
                }
                synchronized (this.mWindowMap) {
                    int numDisplays = this.mDisplayContents.size();
                    for (int displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                        WindowList windows = ((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).getWindowList();
                        int numWindows = windows.size();
                        for (int winNdx = WALLPAPER_DRAW_NORMAL; winNdx < numWindows; winNdx += WALLPAPER_DRAW_PENDING) {
                            WindowState w = (WindowState) windows.get(winNdx);
                            if (System.identityHashCode(w) == hashCode) {
                                return w;
                            }
                        }
                    }
                    return null;
                }
            }

            void sendNewConfiguration() {
                try {
                    this.mActivityManager.updateConfiguration(null);
                } catch (RemoteException e) {
                }
            }

            public Configuration computeNewConfiguration() {
                Configuration config;
                synchronized (this.mWindowMap) {
                    config = computeNewConfigurationLocked();
                    if (config == null && this.mWaitingForConfig) {
                        this.mWaitingForConfig = SHOW_TRANSACTIONS;
                        this.mLastFinishedFreezeSource = "new-config";
                        performLayoutAndPlaceSurfacesLocked();
                    }
                }
                return config;
            }

            Configuration computeNewConfigurationLocked() {
                Configuration config = new Configuration();
                config.fontScale = 0.0f;
                if (computeScreenConfigurationLocked(config)) {
                    return config;
                }
                return null;
            }

            private void adjustDisplaySizeRanges(DisplayInfo displayInfo, int rotation, int dw, int dh) {
                int width = this.mPolicy.getConfigDisplayWidth(dw, dh, rotation);
                if (width < displayInfo.smallestNominalAppWidth) {
                    displayInfo.smallestNominalAppWidth = width;
                }
                if (width > displayInfo.largestNominalAppWidth) {
                    displayInfo.largestNominalAppWidth = width;
                }
                int height = this.mPolicy.getConfigDisplayHeight(dw, dh, rotation);
                if (height < displayInfo.smallestNominalAppHeight) {
                    displayInfo.smallestNominalAppHeight = height;
                }
                if (height > displayInfo.largestNominalAppHeight) {
                    displayInfo.largestNominalAppHeight = height;
                }
            }

            private int reduceConfigLayout(int curLayout, int rotation, float density, int dw, int dh) {
                int longSize = this.mPolicy.getNonDecorDisplayWidth(dw, dh, rotation);
                int shortSize = this.mPolicy.getNonDecorDisplayHeight(dw, dh, rotation);
                if (longSize < shortSize) {
                    int tmp = longSize;
                    longSize = shortSize;
                    shortSize = tmp;
                }
                return Configuration.reduceScreenLayout(curLayout, (int) (((float) longSize) / density), (int) (((float) shortSize) / density));
            }

            private void computeSizeRangesAndScreenLayout(DisplayInfo displayInfo, boolean rotated, int dw, int dh, float density, Configuration outConfig) {
                int unrotDw;
                int unrotDh;
                if (rotated) {
                    unrotDw = dh;
                    unrotDh = dw;
                } else {
                    unrotDw = dw;
                    unrotDh = dh;
                }
                displayInfo.smallestNominalAppWidth = 1073741824;
                displayInfo.smallestNominalAppHeight = 1073741824;
                displayInfo.largestNominalAppWidth = WALLPAPER_DRAW_NORMAL;
                displayInfo.largestNominalAppHeight = WALLPAPER_DRAW_NORMAL;
                adjustDisplaySizeRanges(displayInfo, WALLPAPER_DRAW_NORMAL, unrotDw, unrotDh);
                adjustDisplaySizeRanges(displayInfo, WALLPAPER_DRAW_PENDING, unrotDh, unrotDw);
                adjustDisplaySizeRanges(displayInfo, WALLPAPER_DRAW_TIMEOUT, unrotDw, unrotDh);
                adjustDisplaySizeRanges(displayInfo, UPDATE_FOCUS_WILL_PLACE_SURFACES, unrotDh, unrotDw);
                int sl = reduceConfigLayout(reduceConfigLayout(reduceConfigLayout(reduceConfigLayout(Configuration.resetScreenLayout(outConfig.screenLayout), WALLPAPER_DRAW_NORMAL, density, unrotDw, unrotDh), WALLPAPER_DRAW_PENDING, density, unrotDh, unrotDw), WALLPAPER_DRAW_TIMEOUT, density, unrotDw, unrotDh), UPDATE_FOCUS_WILL_PLACE_SURFACES, density, unrotDh, unrotDw);
                outConfig.smallestScreenWidthDp = (int) (((float) displayInfo.smallestNominalAppWidth) / density);
                outConfig.screenLayout = sl;
            }

            private int reduceCompatConfigWidthSize(int curSize, int rotation, DisplayMetrics dm, int dw, int dh) {
                dm.noncompatWidthPixels = this.mPolicy.getNonDecorDisplayWidth(dw, dh, rotation);
                dm.noncompatHeightPixels = this.mPolicy.getNonDecorDisplayHeight(dw, dh, rotation);
                int size = (int) (((((float) dm.noncompatWidthPixels) / CompatibilityInfo.computeCompatibleScaling(dm, null)) / dm.density) + 0.5f);
                if (curSize == 0 || size < curSize) {
                    return size;
                }
                return curSize;
            }

            private int computeCompatSmallestWidth(boolean rotated, DisplayMetrics dm, int dw, int dh) {
                int unrotDw;
                int unrotDh;
                this.mTmpDisplayMetrics.setTo(dm);
                DisplayMetrics tmpDm = this.mTmpDisplayMetrics;
                if (rotated) {
                    unrotDw = dh;
                    unrotDh = dw;
                } else {
                    unrotDw = dw;
                    unrotDh = dh;
                }
                return reduceCompatConfigWidthSize(reduceCompatConfigWidthSize(reduceCompatConfigWidthSize(reduceCompatConfigWidthSize(WALLPAPER_DRAW_NORMAL, WALLPAPER_DRAW_NORMAL, tmpDm, unrotDw, unrotDh), WALLPAPER_DRAW_PENDING, tmpDm, unrotDh, unrotDw), WALLPAPER_DRAW_TIMEOUT, tmpDm, unrotDw, unrotDh), UPDATE_FOCUS_WILL_PLACE_SURFACES, tmpDm, unrotDh, unrotDw);
            }

            boolean computeScreenConfigurationLocked(Configuration config) {
                if (!this.mDisplayReady) {
                    return SHOW_TRANSACTIONS;
                }
                DisplayContent displayContent = getDefaultDisplayContentLocked();
                boolean rotated = (this.mRotation == WALLPAPER_DRAW_PENDING || this.mRotation == UPDATE_FOCUS_WILL_PLACE_SURFACES) ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                int realdw = rotated ? displayContent.mBaseDisplayHeight : displayContent.mBaseDisplayWidth;
                int realdh = rotated ? displayContent.mBaseDisplayWidth : displayContent.mBaseDisplayHeight;
                int dw = realdw;
                int dh = realdh;
                if (this.mAltOrientation) {
                    if (realdw > realdh) {
                        int maxw = (int) (((float) realdh) / 1.3f);
                        if (maxw < realdw) {
                            dw = maxw;
                        }
                    } else {
                        int maxh = (int) (((float) realdw) / 1.3f);
                        if (maxh < realdh) {
                            dh = maxh;
                        }
                    }
                }
                if (config != null) {
                    config.orientation = dw <= dh ? WALLPAPER_DRAW_PENDING : WALLPAPER_DRAW_TIMEOUT;
                }
                int appWidth = this.mPolicy.getNonDecorDisplayWidth(dw, dh, this.mRotation);
                int appHeight = this.mPolicy.getNonDecorDisplayHeight(dw, dh, this.mRotation);
                DisplayInfo displayInfo = displayContent.getDisplayInfo();
                synchronized (displayContent.mDisplaySizeLock) {
                    displayInfo.rotation = this.mRotation;
                    displayInfo.logicalWidth = dw;
                    displayInfo.logicalHeight = dh;
                    displayInfo.logicalDensityDpi = displayContent.mBaseDisplayDensity;
                    displayInfo.appWidth = appWidth;
                    displayInfo.appHeight = appHeight;
                    displayInfo.getLogicalMetrics(this.mRealDisplayMetrics, CompatibilityInfo.DEFAULT_COMPATIBILITY_INFO, null);
                    displayInfo.getAppMetrics(this.mDisplayMetrics);
                    this.mDisplayManagerInternal.setDisplayInfoOverrideFromWindowManager(displayContent.getDisplayId(), displayInfo);
                    displayContent.mBaseDisplayRect.set(WALLPAPER_DRAW_NORMAL, WALLPAPER_DRAW_NORMAL, dw, dh);
                }
                DisplayMetrics dm = this.mDisplayMetrics;
                this.mCompatibleScreenScale = CompatibilityInfo.computeCompatibleScaling(dm, this.mCompatDisplayMetrics);
                if (config != null) {
                    config.screenWidthDp = (int) (((float) this.mPolicy.getConfigDisplayWidth(dw, dh, this.mRotation)) / dm.density);
                    config.screenHeightDp = (int) (((float) this.mPolicy.getConfigDisplayHeight(dw, dh, this.mRotation)) / dm.density);
                    computeSizeRangesAndScreenLayout(displayInfo, rotated, dw, dh, dm.density, config);
                    config.compatScreenWidthDp = (int) (((float) config.screenWidthDp) / this.mCompatibleScreenScale);
                    config.compatScreenHeightDp = (int) (((float) config.screenHeightDp) / this.mCompatibleScreenScale);
                    config.compatSmallestScreenWidthDp = computeCompatSmallestWidth(rotated, dm, dw, dh);
                    config.densityDpi = displayContent.mBaseDisplayDensity;
                    config.touchscreen = WALLPAPER_DRAW_PENDING;
                    config.keyboard = WALLPAPER_DRAW_PENDING;
                    config.navigation = WALLPAPER_DRAW_PENDING;
                    int keyboardPresence = WALLPAPER_DRAW_NORMAL;
                    int navigationPresence = WALLPAPER_DRAW_NORMAL;
                    InputDevice[] devices = this.mInputManager.getInputDevices();
                    int len = devices.length;
                    for (int i = WALLPAPER_DRAW_NORMAL; i < len; i += WALLPAPER_DRAW_PENDING) {
                        InputDevice device = devices[i];
                        if (!device.isVirtual()) {
                            int sources = device.getSources();
                            int presenceFlag = device.isExternal() ? WALLPAPER_DRAW_TIMEOUT : WALLPAPER_DRAW_PENDING;
                            if (!this.mIsTouchDevice) {
                                config.touchscreen = WALLPAPER_DRAW_PENDING;
                            } else if ((sources & 4098) == 4098) {
                                config.touchscreen = UPDATE_FOCUS_WILL_PLACE_SURFACES;
                            }
                            if ((65540 & sources) == 65540) {
                                config.navigation = UPDATE_FOCUS_WILL_PLACE_SURFACES;
                                navigationPresence |= presenceFlag;
                            } else if ((sources & 513) == 513 && config.navigation == WALLPAPER_DRAW_PENDING) {
                                config.navigation = WALLPAPER_DRAW_TIMEOUT;
                                navigationPresence |= presenceFlag;
                            }
                            if (device.getKeyboardType() == WALLPAPER_DRAW_TIMEOUT) {
                                config.keyboard = WALLPAPER_DRAW_TIMEOUT;
                                keyboardPresence |= presenceFlag;
                            }
                        }
                    }
                    if (config.navigation == WALLPAPER_DRAW_PENDING && this.mHasPermanentDpad) {
                        config.navigation = WALLPAPER_DRAW_TIMEOUT;
                        navigationPresence |= WALLPAPER_DRAW_PENDING;
                    }
                    boolean hardKeyboardAvailable = config.keyboard != WALLPAPER_DRAW_PENDING ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                    if (hardKeyboardAvailable != this.mHardKeyboardAvailable) {
                        this.mHardKeyboardAvailable = hardKeyboardAvailable;
                        this.mH.removeMessages(22);
                        this.mH.sendEmptyMessage(22);
                    }
                    if (this.mShowImeWithHardKeyboard) {
                        config.keyboard = WALLPAPER_DRAW_PENDING;
                    }
                    config.keyboardHidden = WALLPAPER_DRAW_PENDING;
                    config.hardKeyboardHidden = WALLPAPER_DRAW_PENDING;
                    config.navigationHidden = WALLPAPER_DRAW_PENDING;
                    this.mPolicy.adjustConfigurationLw(config, keyboardPresence, navigationPresence);
                }
                return HIDE_STACK_CRAWLS;
            }

            public boolean isHardKeyboardAvailable() {
                boolean z;
                synchronized (this.mWindowMap) {
                    z = this.mHardKeyboardAvailable;
                }
                return z;
            }

            public void updateShowImeWithHardKeyboard() {
                boolean showImeWithHardKeyboard = HIDE_STACK_CRAWLS;
                if (Secure.getIntForUser(this.mContext.getContentResolver(), "show_ime_with_hard_keyboard", WALLPAPER_DRAW_NORMAL, this.mCurrentUserId) != WALLPAPER_DRAW_PENDING) {
                    showImeWithHardKeyboard = SHOW_TRANSACTIONS;
                }
                synchronized (this.mWindowMap) {
                    if (this.mShowImeWithHardKeyboard != showImeWithHardKeyboard) {
                        this.mShowImeWithHardKeyboard = showImeWithHardKeyboard;
                        this.mH.sendEmptyMessage(18);
                    }
                }
            }

            public void setOnHardKeyboardStatusChangeListener(OnHardKeyboardStatusChangeListener listener) {
                synchronized (this.mWindowMap) {
                    this.mHardKeyboardStatusChangeListener = listener;
                }
            }

            void notifyHardKeyboardStatusChange() {
                synchronized (this.mWindowMap) {
                    OnHardKeyboardStatusChangeListener listener = this.mHardKeyboardStatusChangeListener;
                    boolean available = this.mHardKeyboardAvailable;
                }
                if (listener != null) {
                    listener.onHardKeyboardStatusChange(available);
                }
            }

            IBinder prepareDragSurface(IWindow window, SurfaceSession session, int flags, int width, int height, Surface outSurface) {
                OutOfResourcesException e;
                Throwable th;
                int callerPid = Binder.getCallingPid();
                long origId = Binder.clearCallingIdentity();
                IBinder token = null;
                IBinder token2;
                try {
                    synchronized (this.mWindowMap) {
                        try {
                            if (this.mDragState == null) {
                                Display display = getDefaultDisplayContentLocked().getDisplay();
                                SurfaceControl surface = new SurfaceControl(session, "drag surface", width, height, -3, LAYOUT_REPEAT_THRESHOLD);
                                surface.setLayerStack(display.getLayerStack());
                                outSurface.copyFrom(surface);
                                IBinder winBinder = window.asBinder();
                                token2 = new Binder();
                                try {
                                    this.mDragState = new DragState(this, token2, surface, WALLPAPER_DRAW_NORMAL, winBinder);
                                    DragState dragState = this.mDragState;
                                    token = new Binder();
                                    dragState.mToken = token;
                                    this.mH.removeMessages(20, winBinder);
                                    this.mH.sendMessageDelayed(this.mH.obtainMessage(20, winBinder), 5000);
                                    token2 = token;
                                } catch (OutOfResourcesException e2) {
                                    e = e2;
                                    try {
                                        Slog.e(TAG, "Can't allocate drag surface w=" + width + " h=" + height, e);
                                        if (this.mDragState != null) {
                                            this.mDragState.reset();
                                            this.mDragState = null;
                                        }
                                        Binder.restoreCallingIdentity(origId);
                                        return token2;
                                    } catch (Throwable th2) {
                                        th = th2;
                                        try {
                                            throw th;
                                        } catch (Throwable th3) {
                                            th = th3;
                                        }
                                    }
                                }
                                Binder.restoreCallingIdentity(origId);
                                return token2;
                            }
                            Slog.w(TAG, "Drag already in progress");
                            token2 = null;
                            Binder.restoreCallingIdentity(origId);
                            return token2;
                        } catch (OutOfResourcesException e3) {
                            e = e3;
                            token2 = token;
                            Slog.e(TAG, "Can't allocate drag surface w=" + width + " h=" + height, e);
                            if (this.mDragState != null) {
                                this.mDragState.reset();
                                this.mDragState = null;
                            }
                            Binder.restoreCallingIdentity(origId);
                            return token2;
                        } catch (Throwable th4) {
                            th = th4;
                            token2 = token;
                            throw th;
                        }
                    }
                } catch (Throwable th5) {
                    th = th5;
                    token2 = null;
                    Binder.restoreCallingIdentity(origId);
                    throw th;
                }
            }

            public void pauseKeyDispatching(IBinder _token) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "pauseKeyDispatching()")) {
                    synchronized (this.mWindowMap) {
                        WindowToken token = (WindowToken) this.mTokenMap.get(_token);
                        if (token != null) {
                            this.mInputMonitor.pauseDispatchingLw(token);
                        }
                    }
                    return;
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public void resumeKeyDispatching(IBinder _token) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "resumeKeyDispatching()")) {
                    synchronized (this.mWindowMap) {
                        WindowToken token = (WindowToken) this.mTokenMap.get(_token);
                        if (token != null) {
                            this.mInputMonitor.resumeDispatchingLw(token);
                        }
                    }
                    return;
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            public void setEventDispatching(boolean enabled) {
                if (checkCallingPermission("android.permission.MANAGE_APP_TOKENS", "setEventDispatching()")) {
                    synchronized (this.mWindowMap) {
                        this.mEventDispatchingEnabled = enabled;
                        if (this.mDisplayEnabled) {
                            this.mInputMonitor.setEventDispatchingLw(enabled);
                        }
                    }
                    return;
                }
                throw new SecurityException("Requires MANAGE_APP_TOKENS permission");
            }

            private WindowState getFocusedWindow() {
                WindowState focusedWindowLocked;
                synchronized (this.mWindowMap) {
                    focusedWindowLocked = getFocusedWindowLocked();
                }
                return focusedWindowLocked;
            }

            private WindowState getFocusedWindowLocked() {
                return this.mCurrentFocus;
            }

            public boolean detectSafeMode() {
                boolean z = SHOW_TRANSACTIONS;
                if (!this.mInputMonitor.waitForInputDevicesReady(WALLPAPER_DRAW_PENDING_TIMEOUT_DURATION)) {
                    Slog.w(TAG, "Devices still not ready after waiting 1000 milliseconds before attempting to detect safe mode.");
                }
                int menuState = this.mInputManager.getKeyCodeState(-1, -256, 82);
                int sState = this.mInputManager.getKeyCodeState(-1, -256, 47);
                int dpadState = this.mInputManager.getKeyCodeState(-1, 513, 23);
                int trackballState = this.mInputManager.getScanCodeState(-1, 65540, InputManagerService.BTN_MOUSE);
                int volumeDownState = this.mInputManager.getKeyCodeState(-1, -256, 25);
                if (menuState > 0 || sState > 0 || dpadState > 0 || trackballState > 0 || volumeDownState > 0) {
                    z = HIDE_STACK_CRAWLS;
                }
                this.mSafeMode = z;
                try {
                    if (SystemProperties.getInt(ShutdownThread.REBOOT_SAFEMODE_PROPERTY, WALLPAPER_DRAW_NORMAL) != 0) {
                        this.mSafeMode = HIDE_STACK_CRAWLS;
                        SystemProperties.set(ShutdownThread.REBOOT_SAFEMODE_PROPERTY, "");
                    }
                } catch (IllegalArgumentException e) {
                }
                if (this.mSafeMode) {
                    Log.i(TAG, "SAFE MODE ENABLED (menu=" + menuState + " s=" + sState + " dpad=" + dpadState + " trackball=" + trackballState + ")");
                } else {
                    Log.i(TAG, "SAFE MODE not enabled");
                }
                this.mPolicy.setSafeMode(this.mSafeMode);
                return this.mSafeMode;
            }

            public void displayReady() {
                Display[] arr$ = this.mDisplays;
                int len$ = arr$.length;
                for (int i$ = WALLPAPER_DRAW_NORMAL; i$ < len$; i$ += WALLPAPER_DRAW_PENDING) {
                    displayReady(arr$[i$].getDisplayId());
                }
                synchronized (this.mWindowMap) {
                    readForcedDisplaySizeAndDensityLocked(getDefaultDisplayContentLocked());
                    this.mDisplayReady = HIDE_STACK_CRAWLS;
                }
                try {
                    this.mActivityManager.updateConfiguration(null);
                } catch (RemoteException e) {
                }
                synchronized (this.mWindowMap) {
                    this.mIsTouchDevice = this.mContext.getPackageManager().hasSystemFeature("android.hardware.touchscreen");
                    configureDisplayPolicyLocked(getDefaultDisplayContentLocked());
                }
                try {
                    this.mActivityManager.updateConfiguration(null);
                } catch (RemoteException e2) {
                }
            }

            private void displayReady(int displayId) {
                synchronized (this.mWindowMap) {
                    DisplayContent displayContent = getDisplayContentLocked(displayId);
                    if (displayContent != null) {
                        this.mAnimator.addDisplayLocked(displayId);
                        synchronized (displayContent.mDisplaySizeLock) {
                            DisplayInfo displayInfo = displayContent.getDisplayInfo();
                            DisplayInfo newDisplayInfo = this.mDisplayManagerInternal.getDisplayInfo(displayId);
                            if (newDisplayInfo != null) {
                                displayInfo.copyFrom(newDisplayInfo);
                            }
                            displayContent.mInitialDisplayWidth = displayInfo.logicalWidth;
                            displayContent.mInitialDisplayHeight = displayInfo.logicalHeight;
                            displayContent.mInitialDisplayDensity = displayInfo.logicalDensityDpi;
                            displayContent.mBaseDisplayWidth = displayContent.mInitialDisplayWidth;
                            displayContent.mBaseDisplayHeight = displayContent.mInitialDisplayHeight;
                            displayContent.mBaseDisplayDensity = displayContent.mInitialDisplayDensity;
                            displayContent.mBaseDisplayRect.set(WALLPAPER_DRAW_NORMAL, WALLPAPER_DRAW_NORMAL, displayContent.mBaseDisplayWidth, displayContent.mBaseDisplayHeight);
                        }
                    }
                }
            }

            public void systemReady() {
                this.mPolicy.systemReady();
            }

            public IWindowSession openSession(IWindowSessionCallback callback, IInputMethodClient client, IInputContext inputContext) {
                if (client == null) {
                    throw new IllegalArgumentException("null client");
                } else if (inputContext != null) {
                    return new Session(this, callback, client, inputContext);
                } else {
                    throw new IllegalArgumentException("null inputContext");
                }
            }

            public boolean inputMethodClientHasFocus(IInputMethodClient client) {
                synchronized (this.mWindowMap) {
                    int idx = findDesiredInputMethodWindowIndexLocked(SHOW_TRANSACTIONS);
                    if (idx > 0) {
                        WindowState imFocus = (WindowState) getDefaultWindowListLocked().get(idx - 1);
                        if (imFocus != null) {
                            if (imFocus.mAttrs.type == UPDATE_FOCUS_WILL_PLACE_SURFACES && imFocus.mAppToken != null) {
                                for (int i = WALLPAPER_DRAW_NORMAL; i < imFocus.mAppToken.windows.size(); i += WALLPAPER_DRAW_PENDING) {
                                    WindowState w = (WindowState) imFocus.mAppToken.windows.get(i);
                                    if (w != imFocus) {
                                        Log.i(TAG, "Switching to real app window: " + w);
                                        imFocus = w;
                                        break;
                                    }
                                }
                            }
                            if (imFocus.mSession.mClient != null && imFocus.mSession.mClient.asBinder() == client.asBinder()) {
                                return HIDE_STACK_CRAWLS;
                            }
                        }
                    }
                    if (this.mCurrentFocus == null || this.mCurrentFocus.mSession.mClient == null || this.mCurrentFocus.mSession.mClient.asBinder() != client.asBinder()) {
                        return SHOW_TRANSACTIONS;
                    }
                    return HIDE_STACK_CRAWLS;
                }
            }

            public void getInitialDisplaySize(int displayId, Point size) {
                synchronized (this.mWindowMap) {
                    DisplayContent displayContent = getDisplayContentLocked(displayId);
                    if (displayContent != null && displayContent.hasAccess(Binder.getCallingUid())) {
                        synchronized (displayContent.mDisplaySizeLock) {
                            size.x = displayContent.mInitialDisplayWidth;
                            size.y = displayContent.mInitialDisplayHeight;
                        }
                    }
                }
            }

            public void getBaseDisplaySize(int displayId, Point size) {
                synchronized (this.mWindowMap) {
                    DisplayContent displayContent = getDisplayContentLocked(displayId);
                    if (displayContent != null && displayContent.hasAccess(Binder.getCallingUid())) {
                        synchronized (displayContent.mDisplaySizeLock) {
                            size.x = displayContent.mBaseDisplayWidth;
                            size.y = displayContent.mBaseDisplayHeight;
                        }
                    }
                }
            }

            public void setForcedDisplaySize(int displayId, int width, int height) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS") != 0) {
                    throw new SecurityException("Must hold permission android.permission.WRITE_SECURE_SETTINGS");
                } else if (displayId != 0) {
                    throw new IllegalArgumentException("Can only set the default display");
                } else {
                    long ident = Binder.clearCallingIdentity();
                    try {
                        synchronized (this.mWindowMap) {
                            DisplayContent displayContent = getDisplayContentLocked(displayId);
                            if (displayContent != null) {
                                width = Math.min(Math.max(width, BOOT_ANIMATION_POLL_INTERVAL), displayContent.mInitialDisplayWidth * WALLPAPER_DRAW_TIMEOUT);
                                height = Math.min(Math.max(height, BOOT_ANIMATION_POLL_INTERVAL), displayContent.mInitialDisplayHeight * WALLPAPER_DRAW_TIMEOUT);
                                setForcedDisplaySizeLocked(displayContent, width, height);
                                Global.putString(this.mContext.getContentResolver(), "display_size_forced", width + "," + height);
                            }
                        }
                    } finally {
                        Binder.restoreCallingIdentity(ident);
                    }
                }
            }

            private void readForcedDisplaySizeAndDensityLocked(DisplayContent displayContent) {
                String sizeStr = Global.getString(this.mContext.getContentResolver(), "display_size_forced");
                if (sizeStr == null || sizeStr.length() == 0) {
                    sizeStr = SystemProperties.get(SIZE_OVERRIDE, null);
                }
                if (sizeStr != null && sizeStr.length() > 0) {
                    int pos = sizeStr.indexOf(44);
                    if (pos > 0 && sizeStr.lastIndexOf(44) == pos) {
                        try {
                            int width = Integer.parseInt(sizeStr.substring(WALLPAPER_DRAW_NORMAL, pos));
                            int height = Integer.parseInt(sizeStr.substring(pos + WALLPAPER_DRAW_PENDING));
                            synchronized (displayContent.mDisplaySizeLock) {
                                if (!(displayContent.mBaseDisplayWidth == width && displayContent.mBaseDisplayHeight == height)) {
                                    Slog.i(TAG, "FORCED DISPLAY SIZE: " + width + "x" + height);
                                    displayContent.mBaseDisplayWidth = width;
                                    displayContent.mBaseDisplayHeight = height;
                                }
                            }
                        } catch (NumberFormatException e) {
                        }
                    }
                }
                String densityStr = Global.getString(this.mContext.getContentResolver(), "display_density_forced");
                if (densityStr == null || densityStr.length() == 0) {
                    densityStr = SystemProperties.get(DENSITY_OVERRIDE, null);
                }
                if (densityStr != null && densityStr.length() > 0) {
                    try {
                        int density = Integer.parseInt(densityStr);
                        synchronized (displayContent.mDisplaySizeLock) {
                            if (displayContent.mBaseDisplayDensity != density) {
                                Slog.i(TAG, "FORCED DISPLAY DENSITY: " + density);
                                displayContent.mBaseDisplayDensity = density;
                            }
                        }
                    } catch (NumberFormatException e2) {
                    }
                }
            }

            private void setForcedDisplaySizeLocked(DisplayContent displayContent, int width, int height) {
                Slog.i(TAG, "Using new display size: " + width + "x" + height);
                synchronized (displayContent.mDisplaySizeLock) {
                    displayContent.mBaseDisplayWidth = width;
                    displayContent.mBaseDisplayHeight = height;
                }
                reconfigureDisplayLocked(displayContent);
            }

            public void clearForcedDisplaySize(int displayId) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS") != 0) {
                    throw new SecurityException("Must hold permission android.permission.WRITE_SECURE_SETTINGS");
                } else if (displayId != 0) {
                    throw new IllegalArgumentException("Can only set the default display");
                } else {
                    long ident = Binder.clearCallingIdentity();
                    try {
                        synchronized (this.mWindowMap) {
                            DisplayContent displayContent = getDisplayContentLocked(displayId);
                            if (displayContent != null) {
                                setForcedDisplaySizeLocked(displayContent, displayContent.mInitialDisplayWidth, displayContent.mInitialDisplayHeight);
                                Global.putString(this.mContext.getContentResolver(), "display_size_forced", "");
                            }
                        }
                    } finally {
                        Binder.restoreCallingIdentity(ident);
                    }
                }
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public int getInitialDisplayDensity(int r5) {
                /*
                r4 = this;
                r2 = r4.mWindowMap;
                monitor-enter(r2);
                r0 = r4.getDisplayContentLocked(r5);	 Catch:{ all -> 0x001e }
                if (r0 == 0) goto L_0x0021;
            L_0x0009:
                r1 = android.os.Binder.getCallingUid();	 Catch:{ all -> 0x001e }
                r1 = r0.hasAccess(r1);	 Catch:{ all -> 0x001e }
                if (r1 == 0) goto L_0x0021;
            L_0x0013:
                r3 = r0.mDisplaySizeLock;	 Catch:{ all -> 0x001e }
                monitor-enter(r3);	 Catch:{ all -> 0x001e }
                r1 = r0.mInitialDisplayDensity;	 Catch:{ all -> 0x001b }
                monitor-exit(r3);	 Catch:{ all -> 0x001b }
                monitor-exit(r2);	 Catch:{ all -> 0x001e }
            L_0x001a:
                return r1;
            L_0x001b:
                r1 = move-exception;
                monitor-exit(r3);	 Catch:{ all -> 0x001b }
                throw r1;	 Catch:{ all -> 0x001e }
            L_0x001e:
                r1 = move-exception;
                monitor-exit(r2);	 Catch:{ all -> 0x001e }
                throw r1;
            L_0x0021:
                monitor-exit(r2);	 Catch:{ all -> 0x001e }
                r1 = -1;
                goto L_0x001a;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.getInitialDisplayDensity(int):int");
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public int getBaseDisplayDensity(int r5) {
                /*
                r4 = this;
                r2 = r4.mWindowMap;
                monitor-enter(r2);
                r0 = r4.getDisplayContentLocked(r5);	 Catch:{ all -> 0x001e }
                if (r0 == 0) goto L_0x0021;
            L_0x0009:
                r1 = android.os.Binder.getCallingUid();	 Catch:{ all -> 0x001e }
                r1 = r0.hasAccess(r1);	 Catch:{ all -> 0x001e }
                if (r1 == 0) goto L_0x0021;
            L_0x0013:
                r3 = r0.mDisplaySizeLock;	 Catch:{ all -> 0x001e }
                monitor-enter(r3);	 Catch:{ all -> 0x001e }
                r1 = r0.mBaseDisplayDensity;	 Catch:{ all -> 0x001b }
                monitor-exit(r3);	 Catch:{ all -> 0x001b }
                monitor-exit(r2);	 Catch:{ all -> 0x001e }
            L_0x001a:
                return r1;
            L_0x001b:
                r1 = move-exception;
                monitor-exit(r3);	 Catch:{ all -> 0x001b }
                throw r1;	 Catch:{ all -> 0x001e }
            L_0x001e:
                r1 = move-exception;
                monitor-exit(r2);	 Catch:{ all -> 0x001e }
                throw r1;
            L_0x0021:
                monitor-exit(r2);	 Catch:{ all -> 0x001e }
                r1 = -1;
                goto L_0x001a;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.getBaseDisplayDensity(int):int");
            }

            public void setForcedDisplayDensity(int displayId, int density) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS") != 0) {
                    throw new SecurityException("Must hold permission android.permission.WRITE_SECURE_SETTINGS");
                } else if (displayId != 0) {
                    throw new IllegalArgumentException("Can only set the default display");
                } else {
                    long ident = Binder.clearCallingIdentity();
                    try {
                        synchronized (this.mWindowMap) {
                            DisplayContent displayContent = getDisplayContentLocked(displayId);
                            if (displayContent != null) {
                                setForcedDisplayDensityLocked(displayContent, density);
                                Global.putString(this.mContext.getContentResolver(), "display_density_forced", Integer.toString(density));
                            }
                        }
                    } finally {
                        Binder.restoreCallingIdentity(ident);
                    }
                }
            }

            private void setForcedDisplayDensityLocked(DisplayContent displayContent, int density) {
                Slog.i(TAG, "Using new display density: " + density);
                synchronized (displayContent.mDisplaySizeLock) {
                    displayContent.mBaseDisplayDensity = density;
                }
                reconfigureDisplayLocked(displayContent);
            }

            public void clearForcedDisplayDensity(int displayId) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS") != 0) {
                    throw new SecurityException("Must hold permission android.permission.WRITE_SECURE_SETTINGS");
                } else if (displayId != 0) {
                    throw new IllegalArgumentException("Can only set the default display");
                } else {
                    long ident = Binder.clearCallingIdentity();
                    try {
                        synchronized (this.mWindowMap) {
                            DisplayContent displayContent = getDisplayContentLocked(displayId);
                            if (displayContent != null) {
                                setForcedDisplayDensityLocked(displayContent, displayContent.mInitialDisplayDensity);
                                Global.putString(this.mContext.getContentResolver(), "display_density_forced", "");
                            }
                        }
                    } finally {
                        Binder.restoreCallingIdentity(ident);
                    }
                }
            }

            private void reconfigureDisplayLocked(DisplayContent displayContent) {
                configureDisplayPolicyLocked(displayContent);
                displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                boolean configChanged = updateOrientationFromAppTokensLocked(SHOW_TRANSACTIONS);
                this.mTempConfiguration.setToDefaults();
                this.mTempConfiguration.fontScale = this.mCurConfiguration.fontScale;
                if (computeScreenConfigurationLocked(this.mTempConfiguration) && this.mCurConfiguration.diff(this.mTempConfiguration) != 0) {
                    configChanged = HIDE_STACK_CRAWLS;
                }
                if (configChanged) {
                    this.mWaitingForConfig = HIDE_STACK_CRAWLS;
                    startFreezingDisplayLocked(SHOW_TRANSACTIONS, WALLPAPER_DRAW_NORMAL, WALLPAPER_DRAW_NORMAL);
                    this.mH.sendEmptyMessage(18);
                }
                performLayoutAndPlaceSurfacesLocked();
            }

            private void configureDisplayPolicyLocked(DisplayContent displayContent) {
                this.mPolicy.setInitialDisplaySize(displayContent.getDisplay(), displayContent.mBaseDisplayWidth, displayContent.mBaseDisplayHeight, displayContent.mBaseDisplayDensity);
                DisplayInfo displayInfo = displayContent.getDisplayInfo();
                this.mPolicy.setDisplayOverscan(displayContent.getDisplay(), displayInfo.overscanLeft, displayInfo.overscanTop, displayInfo.overscanRight, displayInfo.overscanBottom);
            }

            public void setOverscan(int displayId, int left, int top, int right, int bottom) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS") != 0) {
                    throw new SecurityException("Must hold permission android.permission.WRITE_SECURE_SETTINGS");
                }
                long ident = Binder.clearCallingIdentity();
                try {
                    synchronized (this.mWindowMap) {
                        DisplayContent displayContent = getDisplayContentLocked(displayId);
                        if (displayContent != null) {
                            setOverscanLocked(displayContent, left, top, right, bottom);
                        }
                    }
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            }

            private void setOverscanLocked(DisplayContent displayContent, int left, int top, int right, int bottom) {
                DisplayInfo displayInfo = displayContent.getDisplayInfo();
                synchronized (displayContent.mDisplaySizeLock) {
                    displayInfo.overscanLeft = left;
                    displayInfo.overscanTop = top;
                    displayInfo.overscanRight = right;
                    displayInfo.overscanBottom = bottom;
                }
                this.mDisplaySettings.setOverscanLocked(displayInfo.uniqueId, left, top, right, bottom);
                this.mDisplaySettings.writeSettingsLocked();
                reconfigureDisplayLocked(displayContent);
            }

            final WindowState windowForClientLocked(Session session, IWindow client, boolean throwOnError) {
                return windowForClientLocked(session, client.asBinder(), throwOnError);
            }

            final WindowState windowForClientLocked(Session session, IBinder client, boolean throwOnError) {
                WindowState win = (WindowState) this.mWindowMap.get(client);
                RuntimeException ex;
                if (win == null) {
                    ex = new IllegalArgumentException("Requested window " + client + " does not exist");
                    if (throwOnError) {
                        throw ex;
                    }
                    Slog.w(TAG, "Failed looking up window", ex);
                    return null;
                } else if (session == null || win.mSession == session) {
                    return win;
                } else {
                    ex = new IllegalArgumentException("Requested window " + client + " is in session " + win.mSession + ", not " + session);
                    if (throwOnError) {
                        throw ex;
                    }
                    Slog.w(TAG, "Failed looking up window", ex);
                    return null;
                }
            }

            final void rebuildAppWindowListLocked() {
                rebuildAppWindowListLocked(getDefaultDisplayContentLocked());
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            private void rebuildAppWindowListLocked(com.android.server.wm.DisplayContent r31) {
                /*
                r30 = this;
                r23 = r31.getWindowList();
                r4 = r23.size();
                r8 = -1;
                r9 = 0;
                r0 = r30;
                r0 = r0.mRebuildTmp;
                r26 = r0;
                r0 = r26;
                r0 = r0.length;
                r26 = r0;
                r0 = r26;
                if (r0 >= r4) goto L_0x0027;
            L_0x0019:
                r26 = r4 + 10;
                r0 = r26;
                r0 = new com.android.server.wm.WindowState[r0];
                r26 = r0;
                r0 = r26;
                r1 = r30;
                r1.mRebuildTmp = r0;
            L_0x0027:
                r6 = 0;
            L_0x0028:
                if (r6 >= r4) goto L_0x0091;
            L_0x002a:
                r0 = r23;
                r21 = r0.get(r6);
                r21 = (com.android.server.wm.WindowState) r21;
                r0 = r21;
                r0 = r0.mAppToken;
                r26 = r0;
                if (r26 == 0) goto L_0x005f;
            L_0x003a:
                r0 = r23;
                r22 = r0.remove(r6);
                r22 = (com.android.server.wm.WindowState) r22;
                r26 = 1;
                r0 = r26;
                r1 = r22;
                r1.mRebuilding = r0;
                r0 = r30;
                r0 = r0.mRebuildTmp;
                r26 = r0;
                r26[r9] = r22;
                r26 = 1;
                r0 = r26;
                r1 = r30;
                r1.mWindowsChanged = r0;
                r4 = r4 + -1;
                r9 = r9 + 1;
                goto L_0x0028;
            L_0x005f:
                r26 = r6 + -1;
                r0 = r26;
                if (r8 != r0) goto L_0x008e;
            L_0x0065:
                r0 = r21;
                r0 = r0.mAttrs;
                r26 = r0;
                r0 = r26;
                r0 = r0.type;
                r26 = r0;
                r27 = 2013; // 0x7dd float:2.821E-42 double:9.946E-321;
                r0 = r26;
                r1 = r27;
                if (r0 == r1) goto L_0x008d;
            L_0x0079:
                r0 = r21;
                r0 = r0.mAttrs;
                r26 = r0;
                r0 = r26;
                r0 = r0.type;
                r26 = r0;
                r27 = 2025; // 0x7e9 float:2.838E-42 double:1.0005E-320;
                r0 = r26;
                r1 = r27;
                if (r0 != r1) goto L_0x008e;
            L_0x008d:
                r8 = r6;
            L_0x008e:
                r6 = r6 + 1;
                goto L_0x0028;
            L_0x0091:
                r8 = r8 + 1;
                r6 = r8;
                r15 = r31.getStacks();
                r10 = r15.size();
                r14 = 0;
            L_0x009d:
                if (r14 >= r10) goto L_0x00c6;
            L_0x009f:
                r26 = r15.get(r14);
                r26 = (com.android.server.wm.TaskStack) r26;
                r0 = r26;
                r5 = r0.mExitingAppTokens;
                r3 = r5.size();
                r7 = 0;
            L_0x00ae:
                if (r7 >= r3) goto L_0x00c3;
            L_0x00b0:
                r26 = r5.get(r7);
                r26 = (com.android.server.wm.WindowToken) r26;
                r0 = r30;
                r1 = r31;
                r2 = r26;
                r6 = r0.reAddAppWindowsLocked(r1, r6, r2);
                r7 = r7 + 1;
                goto L_0x00ae;
            L_0x00c3:
                r14 = r14 + 1;
                goto L_0x009d;
            L_0x00c6:
                r14 = 0;
            L_0x00c7:
                if (r14 >= r10) goto L_0x011d;
            L_0x00c9:
                r26 = r15.get(r14);
                r26 = (com.android.server.wm.TaskStack) r26;
                r18 = r26.getTasks();
                r11 = r18.size();
                r17 = 0;
            L_0x00d9:
                r0 = r17;
                if (r0 >= r11) goto L_0x011a;
            L_0x00dd:
                r0 = r18;
                r1 = r17;
                r26 = r0.get(r1);
                r26 = (com.android.server.wm.Task) r26;
                r0 = r26;
                r0 = r0.mAppTokens;
                r20 = r0;
                r12 = r20.size();
                r19 = 0;
            L_0x00f3:
                r0 = r19;
                if (r0 >= r12) goto L_0x0117;
            L_0x00f7:
                r0 = r20;
                r1 = r19;
                r25 = r0.get(r1);
                r25 = (com.android.server.wm.AppWindowToken) r25;
                r0 = r25;
                r0 = r0.mDeferRemoval;
                r26 = r0;
                if (r26 == 0) goto L_0x010c;
            L_0x0109:
                r19 = r19 + 1;
                goto L_0x00f3;
            L_0x010c:
                r0 = r30;
                r1 = r31;
                r2 = r25;
                r6 = r0.reAddAppWindowsLocked(r1, r6, r2);
                goto L_0x0109;
            L_0x0117:
                r17 = r17 + 1;
                goto L_0x00d9;
            L_0x011a:
                r14 = r14 + 1;
                goto L_0x00c7;
            L_0x011d:
                r6 = r6 - r8;
                if (r6 == r9) goto L_0x01db;
            L_0x0120:
                r26 = "WindowManager";
                r27 = new java.lang.StringBuilder;
                r27.<init>();
                r28 = "On display=";
                r27 = r27.append(r28);
                r28 = r31.getDisplayId();
                r27 = r27.append(r28);
                r28 = " Rebuild removed ";
                r27 = r27.append(r28);
                r0 = r27;
                r27 = r0.append(r9);
                r28 = " windows but added ";
                r27 = r27.append(r28);
                r0 = r27;
                r27 = r0.append(r6);
                r27 = r27.toString();
                r28 = new java.lang.RuntimeException;
                r29 = "here";
                r28.<init>(r29);
                r28 = r28.fillInStackTrace();
                android.util.Slog.w(r26, r27, r28);
                r6 = 0;
            L_0x0160:
                if (r6 >= r9) goto L_0x01c7;
            L_0x0162:
                r0 = r30;
                r0 = r0.mRebuildTmp;
                r26 = r0;
                r24 = r26[r6];
                r0 = r24;
                r0 = r0.mRebuilding;
                r26 = r0;
                if (r26 == 0) goto L_0x01c4;
            L_0x0172:
                r16 = new java.io.StringWriter;
                r16.<init>();
                r13 = new com.android.internal.util.FastPrintWriter;
                r26 = 0;
                r27 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
                r0 = r16;
                r1 = r26;
                r2 = r27;
                r13.<init>(r0, r1, r2);
                r26 = "";
                r27 = 1;
                r0 = r24;
                r1 = r26;
                r2 = r27;
                r0.dump(r13, r1, r2);
                r13.flush();
                r26 = "WindowManager";
                r27 = new java.lang.StringBuilder;
                r27.<init>();
                r28 = "This window was lost: ";
                r27 = r27.append(r28);
                r0 = r27;
                r1 = r24;
                r27 = r0.append(r1);
                r27 = r27.toString();
                android.util.Slog.w(r26, r27);
                r26 = "WindowManager";
                r27 = r16.toString();
                android.util.Slog.w(r26, r27);
                r0 = r24;
                r0 = r0.mWinAnimator;
                r26 = r0;
                r26.destroySurfaceLocked();
            L_0x01c4:
                r6 = r6 + 1;
                goto L_0x0160;
            L_0x01c7:
                r26 = "WindowManager";
                r27 = "Current app token list:";
                android.util.Slog.w(r26, r27);
                r30.dumpAppTokensLocked();
                r26 = "WindowManager";
                r27 = "Final window list:";
                android.util.Slog.w(r26, r27);
                r30.dumpWindowsLocked();
            L_0x01db:
                return;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.rebuildAppWindowListLocked(com.android.server.wm.DisplayContent):void");
            }

            private final void assignLayersLocked(WindowList windows) {
                int N = windows.size();
                int curBaseLayer = WALLPAPER_DRAW_NORMAL;
                int curLayer = WALLPAPER_DRAW_NORMAL;
                boolean anyLayerChanged = SHOW_TRANSACTIONS;
                int i = WALLPAPER_DRAW_NORMAL;
                while (i < N) {
                    WindowState w = (WindowState) windows.get(i);
                    WindowStateAnimator winAnimator = w.mWinAnimator;
                    boolean layerChanged = SHOW_TRANSACTIONS;
                    int oldLayer = w.mLayer;
                    if (w.mBaseLayer == curBaseLayer || w.mIsImWindow || (i > 0 && w.mIsWallpaper)) {
                        curLayer += WINDOW_LAYER_MULTIPLIER;
                        w.mLayer = curLayer;
                    } else {
                        curLayer = w.mBaseLayer;
                        curBaseLayer = curLayer;
                        w.mLayer = curLayer;
                    }
                    if (w.mLayer != oldLayer) {
                        layerChanged = HIDE_STACK_CRAWLS;
                        anyLayerChanged = HIDE_STACK_CRAWLS;
                    }
                    AppWindowToken wtoken = w.mAppToken;
                    oldLayer = winAnimator.mAnimLayer;
                    if (w.mTargetAppToken != null) {
                        winAnimator.mAnimLayer = w.mLayer + w.mTargetAppToken.mAppAnimator.animLayerAdjustment;
                    } else if (wtoken != null) {
                        winAnimator.mAnimLayer = w.mLayer + wtoken.mAppAnimator.animLayerAdjustment;
                    } else {
                        winAnimator.mAnimLayer = w.mLayer;
                    }
                    if (w.mIsImWindow) {
                        winAnimator.mAnimLayer += this.mInputMethodAnimLayerAdjustment;
                    } else if (w.mIsWallpaper) {
                        winAnimator.mAnimLayer += this.mWallpaperAnimLayerAdjustment;
                    }
                    if (winAnimator.mAnimLayer != oldLayer) {
                        layerChanged = HIDE_STACK_CRAWLS;
                        anyLayerChanged = HIDE_STACK_CRAWLS;
                    }
                    TaskStack stack = w.getStack();
                    if (layerChanged && stack != null && stack.isDimming(winAnimator)) {
                        scheduleAnimationLocked();
                    }
                    i += WALLPAPER_DRAW_PENDING;
                }
                if (this.mAccessibilityController != null && anyLayerChanged && ((WindowState) windows.get(windows.size() - 1)).getDisplayId() == 0) {
                    this.mAccessibilityController.onWindowLayersChangedLocked();
                }
            }

            private final void performLayoutAndPlaceSurfacesLocked() {
                int loopCount = 6;
                do {
                    this.mTraversalScheduled = SHOW_TRANSACTIONS;
                    performLayoutAndPlaceSurfacesLockedLoop();
                    this.mH.removeMessages(LAYOUT_REPEAT_THRESHOLD);
                    loopCount--;
                    if (!this.mTraversalScheduled) {
                        break;
                    }
                } while (loopCount > 0);
                this.mInnerFields.mWallpaperActionPending = SHOW_TRANSACTIONS;
            }

            private final void performLayoutAndPlaceSurfacesLockedLoop() {
                if (this.mInLayout) {
                    Slog.w(TAG, "performLayoutAndPlaceSurfacesLocked called while in layout. Callers=" + Debug.getCallers(UPDATE_FOCUS_WILL_PLACE_SURFACES));
                } else if (!this.mWaitingForConfig && this.mDisplayReady) {
                    Trace.traceBegin(32, "wmLayout");
                    this.mInLayout = HIDE_STACK_CRAWLS;
                    boolean recoveringMemory = SHOW_TRANSACTIONS;
                    try {
                        if (this.mForceRemoves != null) {
                            recoveringMemory = HIDE_STACK_CRAWLS;
                            for (int i = WALLPAPER_DRAW_NORMAL; i < this.mForceRemoves.size(); i += WALLPAPER_DRAW_PENDING) {
                                WindowState ws = (WindowState) this.mForceRemoves.get(i);
                                Slog.i(TAG, "Force removing: " + ws);
                                removeWindowInnerLocked(ws.mSession, ws);
                            }
                            this.mForceRemoves = null;
                            Slog.w(TAG, "Due to memory failure, waiting a bit for next layout");
                            Object tmp = new Object();
                            synchronized (tmp) {
                                try {
                                    tmp.wait(250);
                                } catch (InterruptedException e) {
                                }
                            }
                        }
                    } catch (RuntimeException e2) {
                        Slog.wtf(TAG, "Unhandled exception while force removing for memory", e2);
                    }
                    try {
                        performLayoutAndPlaceSurfacesLockedInner(recoveringMemory);
                        this.mInLayout = SHOW_TRANSACTIONS;
                        if (needsLayout()) {
                            int i2 = this.mLayoutRepeatCount + WALLPAPER_DRAW_PENDING;
                            this.mLayoutRepeatCount = i2;
                            if (i2 < 6) {
                                requestTraversalLocked();
                            } else {
                                Slog.e(TAG, "Performed 6 layouts in a row. Skipping");
                                this.mLayoutRepeatCount = WALLPAPER_DRAW_NORMAL;
                            }
                        } else {
                            this.mLayoutRepeatCount = WALLPAPER_DRAW_NORMAL;
                        }
                        if (this.mWindowsChanged && !this.mWindowChangeListeners.isEmpty()) {
                            this.mH.removeMessages(19);
                            this.mH.sendEmptyMessage(19);
                        }
                    } catch (RuntimeException e22) {
                        this.mInLayout = SHOW_TRANSACTIONS;
                        Slog.wtf(TAG, "Unhandled exception while laying out windows", e22);
                    }
                    Trace.traceEnd(32);
                }
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            private final void performLayoutLockedInner(com.android.server.wm.DisplayContent r22, boolean r23, boolean r24) {
                /*
                r21 = this;
                r0 = r22;
                r0 = r0.layoutNeeded;
                r18 = r0;
                if (r18 != 0) goto L_0x0009;
            L_0x0008:
                return;
            L_0x0009:
                r18 = 0;
                r0 = r18;
                r1 = r22;
                r1.layoutNeeded = r0;
                r17 = r22.getWindowList();
                r0 = r22;
                r12 = r0.isDefaultDisplay;
                r8 = r22.getDisplayInfo();
                r9 = r8.logicalWidth;
                r7 = r8.logicalHeight;
                r0 = r21;
                r0 = r0.mFakeWindows;
                r18 = r0;
                r4 = r18.size();
                r11 = 0;
            L_0x002c:
                if (r11 >= r4) goto L_0x0044;
            L_0x002e:
                r0 = r21;
                r0 = r0.mFakeWindows;
                r18 = r0;
                r0 = r18;
                r18 = r0.get(r11);
                r18 = (com.android.server.wm.FakeWindowImpl) r18;
                r0 = r18;
                r0.layout(r9, r7);
                r11 = r11 + 1;
                goto L_0x002c;
            L_0x0044:
                r3 = r17.size();
                r15 = 0;
                r0 = r21;
                r0 = r0.mPolicy;
                r18 = r0;
                r0 = r21;
                r0 = r0.mRotation;
                r19 = r0;
                r0 = r18;
                r1 = r19;
                r0.beginLayoutLw(r12, r9, r7, r1);
                if (r12 == 0) goto L_0x0081;
            L_0x005e:
                r0 = r21;
                r0 = r0.mPolicy;
                r18 = r0;
                r18 = r18.getSystemDecorLayerLw();
                r0 = r18;
                r1 = r21;
                r1.mSystemDecorLayer = r0;
                r0 = r21;
                r0 = r0.mScreenRect;
                r18 = r0;
                r19 = 0;
                r20 = 0;
                r0 = r18;
                r1 = r19;
                r2 = r20;
                r0.set(r1, r2, r9, r7);
            L_0x0081:
                r0 = r21;
                r0 = r0.mPolicy;
                r18 = r0;
                r0 = r21;
                r0 = r0.mTmpContentRect;
                r19 = r0;
                r18.getContentRectLw(r19);
                r0 = r21;
                r0 = r0.mTmpContentRect;
                r18 = r0;
                r0 = r22;
                r1 = r18;
                r0.resize(r1);
                r0 = r21;
                r0 = r0.mLayoutSeq;
                r18 = r0;
                r13 = r18 + 1;
                if (r13 >= 0) goto L_0x00a8;
            L_0x00a7:
                r13 = 0;
            L_0x00a8:
                r0 = r21;
                r0.mLayoutSeq = r13;
                r6 = 0;
                r14 = -1;
                r11 = r3 + -1;
            L_0x00b0:
                if (r11 < 0) goto L_0x01b3;
            L_0x00b2:
                r0 = r17;
                r16 = r0.get(r11);
                r16 = (com.android.server.wm.WindowState) r16;
                if (r6 == 0) goto L_0x00d4;
            L_0x00bc:
                r0 = r21;
                r0 = r0.mPolicy;
                r18 = r0;
                r0 = r16;
                r0 = r0.mAttrs;
                r19 = r0;
                r0 = r18;
                r1 = r16;
                r2 = r19;
                r18 = r0.canBeForceHidden(r1, r2);
                if (r18 != 0) goto L_0x00da;
            L_0x00d4:
                r18 = r16.isGoneForLayoutLw();
                if (r18 == 0) goto L_0x01ac;
            L_0x00da:
                r10 = 1;
            L_0x00db:
                if (r10 == 0) goto L_0x013f;
            L_0x00dd:
                r0 = r16;
                r0 = r0.mHaveFrame;
                r18 = r0;
                if (r18 == 0) goto L_0x013f;
            L_0x00e5:
                r0 = r16;
                r0 = r0.mLayoutNeeded;
                r18 = r0;
                if (r18 != 0) goto L_0x013f;
            L_0x00ed:
                r18 = r16.isConfigChanged();
                if (r18 != 0) goto L_0x00f9;
            L_0x00f3:
                r18 = r16.setInsetsChanged();
                if (r18 == 0) goto L_0x012b;
            L_0x00f9:
                r0 = r16;
                r0 = r0.mAttrs;
                r18 = r0;
                r0 = r18;
                r0 = r0.privateFlags;
                r18 = r0;
                r0 = r18;
                r0 = r0 & 1024;
                r18 = r0;
                if (r18 != 0) goto L_0x013f;
            L_0x010d:
                r0 = r16;
                r0 = r0.mHasSurface;
                r18 = r0;
                if (r18 == 0) goto L_0x012b;
            L_0x0115:
                r0 = r16;
                r0 = r0.mAppToken;
                r18 = r0;
                if (r18 == 0) goto L_0x012b;
            L_0x011d:
                r0 = r16;
                r0 = r0.mAppToken;
                r18 = r0;
                r0 = r18;
                r0 = r0.layoutConfigChanges;
                r18 = r0;
                if (r18 != 0) goto L_0x013f;
            L_0x012b:
                r0 = r16;
                r0 = r0.mAttrs;
                r18 = r0;
                r0 = r18;
                r0 = r0.type;
                r18 = r0;
                r19 = 2025; // 0x7e9 float:2.838E-42 double:1.0005E-320;
                r0 = r18;
                r1 = r19;
                if (r0 != r1) goto L_0x0186;
            L_0x013f:
                r0 = r16;
                r0 = r0.mLayoutAttached;
                r18 = r0;
                if (r18 != 0) goto L_0x01af;
            L_0x0147:
                if (r23 == 0) goto L_0x0151;
            L_0x0149:
                r18 = 0;
                r0 = r18;
                r1 = r16;
                r1.mContentChanged = r0;
            L_0x0151:
                r0 = r16;
                r0 = r0.mAttrs;
                r18 = r0;
                r0 = r18;
                r0 = r0.type;
                r18 = r0;
                r19 = 2023; // 0x7e7 float:2.835E-42 double:9.995E-321;
                r0 = r18;
                r1 = r19;
                if (r0 != r1) goto L_0x0166;
            L_0x0165:
                r6 = 1;
            L_0x0166:
                r18 = 0;
                r0 = r18;
                r1 = r16;
                r1.mLayoutNeeded = r0;
                r16.prelayout();
                r0 = r21;
                r0 = r0.mPolicy;
                r18 = r0;
                r19 = 0;
                r0 = r18;
                r1 = r16;
                r2 = r19;
                r0.layoutWindowLw(r1, r2);
                r0 = r16;
                r0.mLayoutSeq = r13;
            L_0x0186:
                r0 = r16;
                r0 = r0.mViewVisibility;
                r18 = r0;
                if (r18 != 0) goto L_0x01a8;
            L_0x018e:
                r0 = r16;
                r0 = r0.mAttrs;
                r18 = r0;
                r0 = r18;
                r0 = r0.type;
                r18 = r0;
                r19 = 2025; // 0x7e9 float:2.838E-42 double:1.0005E-320;
                r0 = r18;
                r1 = r19;
                if (r0 != r1) goto L_0x01a8;
            L_0x01a2:
                if (r15 != 0) goto L_0x01a8;
            L_0x01a4:
                r0 = r16;
                r15 = r0.mWinAnimator;
            L_0x01a8:
                r11 = r11 + -1;
                goto L_0x00b0;
            L_0x01ac:
                r10 = 0;
                goto L_0x00db;
            L_0x01af:
                if (r14 >= 0) goto L_0x0186;
            L_0x01b1:
                r14 = r11;
                goto L_0x0186;
            L_0x01b3:
                r0 = r21;
                r0 = r0.mAnimator;
                r18 = r0;
                r0 = r18;
                r0 = r0.mUniverseBackground;
                r18 = r0;
                r0 = r18;
                if (r0 == r15) goto L_0x01d5;
            L_0x01c3:
                r18 = 1;
                r0 = r18;
                r1 = r21;
                r1.mFocusMayChange = r0;
                r0 = r21;
                r0 = r0.mAnimator;
                r18 = r0;
                r0 = r18;
                r0.mUniverseBackground = r15;
            L_0x01d5:
                r5 = 0;
                r11 = r14;
            L_0x01d7:
                if (r11 < 0) goto L_0x0271;
            L_0x01d9:
                r0 = r17;
                r16 = r0.get(r11);
                r16 = (com.android.server.wm.WindowState) r16;
                r0 = r16;
                r0 = r0.mLayoutAttached;
                r18 = r0;
                if (r18 == 0) goto L_0x025b;
            L_0x01e9:
                if (r5 == 0) goto L_0x0206;
            L_0x01eb:
                r0 = r21;
                r0 = r0.mPolicy;
                r18 = r0;
                r0 = r16;
                r0 = r0.mAttrs;
                r19 = r0;
                r0 = r18;
                r1 = r16;
                r2 = r19;
                r18 = r0.canBeForceHidden(r1, r2);
                if (r18 == 0) goto L_0x0206;
            L_0x0203:
                r11 = r11 + -1;
                goto L_0x01d7;
            L_0x0206:
                r0 = r16;
                r0 = r0.mViewVisibility;
                r18 = r0;
                r19 = 8;
                r0 = r18;
                r1 = r19;
                if (r0 == r1) goto L_0x021c;
            L_0x0214:
                r0 = r16;
                r0 = r0.mRelayoutCalled;
                r18 = r0;
                if (r18 != 0) goto L_0x022c;
            L_0x021c:
                r0 = r16;
                r0 = r0.mHaveFrame;
                r18 = r0;
                if (r18 == 0) goto L_0x022c;
            L_0x0224:
                r0 = r16;
                r0 = r0.mLayoutNeeded;
                r18 = r0;
                if (r18 == 0) goto L_0x0203;
            L_0x022c:
                if (r23 == 0) goto L_0x0236;
            L_0x022e:
                r18 = 0;
                r0 = r18;
                r1 = r16;
                r1.mContentChanged = r0;
            L_0x0236:
                r18 = 0;
                r0 = r18;
                r1 = r16;
                r1.mLayoutNeeded = r0;
                r16.prelayout();
                r0 = r21;
                r0 = r0.mPolicy;
                r18 = r0;
                r0 = r16;
                r0 = r0.mAttachedWindow;
                r19 = r0;
                r0 = r18;
                r1 = r16;
                r2 = r19;
                r0.layoutWindowLw(r1, r2);
                r0 = r16;
                r0.mLayoutSeq = r13;
                goto L_0x0203;
            L_0x025b:
                r0 = r16;
                r0 = r0.mAttrs;
                r18 = r0;
                r0 = r18;
                r0 = r0.type;
                r18 = r0;
                r19 = 2023; // 0x7e7 float:2.835E-42 double:9.995E-321;
                r0 = r18;
                r1 = r19;
                if (r0 != r1) goto L_0x0203;
            L_0x026f:
                r5 = r6;
                goto L_0x0203;
            L_0x0271:
                r0 = r21;
                r0 = r0.mInputMonitor;
                r18 = r0;
                r18.setUpdateInputWindowsNeededLw();
                if (r24 == 0) goto L_0x0287;
            L_0x027c:
                r0 = r21;
                r0 = r0.mInputMonitor;
                r18 = r0;
                r19 = 0;
                r18.updateInputWindowsLw(r19);
            L_0x0287:
                r0 = r21;
                r0 = r0.mPolicy;
                r18 = r0;
                r18.finishLayoutLw();
                goto L_0x0008;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.performLayoutLockedInner(com.android.server.wm.DisplayContent, boolean, boolean):void");
            }

            void makeWindowFreezingScreenIfNeededLocked(WindowState w) {
                if (!okToDisplay()) {
                    w.mOrientationChanging = HIDE_STACK_CRAWLS;
                    w.mLastFreezeDuration = WALLPAPER_DRAW_NORMAL;
                    this.mInnerFields.mOrientationChangeComplete = SHOW_TRANSACTIONS;
                    if (!this.mWindowsFreezingScreen) {
                        this.mWindowsFreezingScreen = HIDE_STACK_CRAWLS;
                        this.mH.removeMessages(11);
                        this.mH.sendEmptyMessageDelayed(11, 2000);
                    }
                }
            }

            public int handleAppTransitionReadyLocked(WindowList windows) {
                int i;
                AppWindowToken wtoken;
                int changes = WALLPAPER_DRAW_NORMAL;
                int NN = this.mOpeningApps.size();
                boolean goodToGo = HIDE_STACK_CRAWLS;
                if (!this.mAppTransition.isTimeout()) {
                    for (i = WALLPAPER_DRAW_NORMAL; i < NN && goodToGo; i += WALLPAPER_DRAW_PENDING) {
                        wtoken = (AppWindowToken) this.mOpeningApps.valueAt(i);
                        if (!(wtoken.allDrawn || wtoken.startingDisplayed || wtoken.startingMoved)) {
                            goodToGo = SHOW_TRANSACTIONS;
                        }
                    }
                    if (goodToGo) {
                        if (isWallpaperVisible(this.mWallpaperTarget)) {
                            boolean wallpaperGoodToGo = HIDE_STACK_CRAWLS;
                            for (int curTokenIndex = this.mWallpaperTokens.size() - 1; curTokenIndex >= 0 && wallpaperGoodToGo; curTokenIndex--) {
                                WindowToken token = (WindowToken) this.mWallpaperTokens.get(curTokenIndex);
                                int curWallpaperIndex = token.windows.size() - 1;
                                while (curWallpaperIndex >= 0) {
                                    WindowState wallpaper = (WindowState) token.windows.get(curWallpaperIndex);
                                    if (!wallpaper.mWallpaperVisible || wallpaper.isDrawnLw()) {
                                        curWallpaperIndex--;
                                    } else {
                                        wallpaperGoodToGo = SHOW_TRANSACTIONS;
                                        if (this.mWallpaperDrawState != WALLPAPER_DRAW_TIMEOUT) {
                                            goodToGo = SHOW_TRANSACTIONS;
                                        }
                                        if (this.mWallpaperDrawState == 0) {
                                            this.mWallpaperDrawState = WALLPAPER_DRAW_PENDING;
                                            this.mH.removeMessages(39);
                                            this.mH.sendEmptyMessageDelayed(39, WALLPAPER_DRAW_PENDING_TIMEOUT_DURATION);
                                        }
                                    }
                                }
                            }
                            if (wallpaperGoodToGo) {
                                this.mWallpaperDrawState = WALLPAPER_DRAW_NORMAL;
                                this.mH.removeMessages(39);
                            }
                        }
                    }
                }
                if (goodToGo) {
                    WindowState oldWallpaper;
                    AppWindowToken appWindowToken;
                    WindowState win;
                    AppWindowAnimator appAnimator;
                    int N;
                    int j;
                    WindowAnimator windowAnimator;
                    int layer;
                    int transit = this.mAppTransition.getAppTransition();
                    if (this.mSkipAppTransitionAnimation) {
                        transit = -1;
                    }
                    this.mAppTransition.goodToGo();
                    this.mStartingIconInTransition = SHOW_TRANSACTIONS;
                    this.mSkipAppTransitionAnimation = SHOW_TRANSACTIONS;
                    this.mH.removeMessages(13);
                    rebuildAppWindowListLocked();
                    if (this.mWallpaperTarget == null || !this.mWallpaperTarget.mWinAnimator.isAnimating() || this.mWallpaperTarget.mWinAnimator.isDummyAnimation()) {
                        oldWallpaper = this.mWallpaperTarget;
                    } else {
                        oldWallpaper = null;
                    }
                    this.mInnerFields.mWallpaperMayChange = SHOW_TRANSACTIONS;
                    LayoutParams animLp = null;
                    int bestAnimLayer = -1;
                    boolean fullscreenAnim = SHOW_TRANSACTIONS;
                    boolean voiceInteraction = SHOW_TRANSACTIONS;
                    boolean openingAppHasWallpaper = SHOW_TRANSACTIONS;
                    boolean closingAppHasWallpaper = SHOW_TRANSACTIONS;
                    AppWindowToken upperWallpaperAppToken;
                    if (this.mLowerWallpaperTarget == null) {
                        upperWallpaperAppToken = null;
                        appWindowToken = null;
                    } else {
                        appWindowToken = this.mLowerWallpaperTarget.mAppToken;
                        upperWallpaperAppToken = this.mUpperWallpaperTarget.mAppToken;
                    }
                    int NC = this.mClosingApps.size();
                    NN = NC + this.mOpeningApps.size();
                    for (i = WALLPAPER_DRAW_NORMAL; i < NN; i += WALLPAPER_DRAW_PENDING) {
                        if (i < NC) {
                            wtoken = (AppWindowToken) this.mClosingApps.valueAt(i);
                            if (wtoken == appWindowToken || wtoken == upperWallpaperAppToken) {
                                closingAppHasWallpaper = HIDE_STACK_CRAWLS;
                            }
                        } else {
                            wtoken = (AppWindowToken) this.mOpeningApps.valueAt(i - NC);
                            if (wtoken == appWindowToken || wtoken == upperWallpaperAppToken) {
                                openingAppHasWallpaper = HIDE_STACK_CRAWLS;
                            }
                        }
                        voiceInteraction |= wtoken.voiceInteraction;
                        WindowState ws;
                        if (wtoken.appFullscreen) {
                            ws = wtoken.findMainWindow();
                            if (ws != null) {
                                animLp = ws.mAttrs;
                                bestAnimLayer = ws.mLayer;
                                fullscreenAnim = HIDE_STACK_CRAWLS;
                            }
                        } else if (!fullscreenAnim) {
                            ws = wtoken.findMainWindow();
                            if (ws != null && ws.mLayer > bestAnimLayer) {
                                animLp = ws.mAttrs;
                                bestAnimLayer = ws.mLayer;
                            }
                        }
                    }
                    this.mAnimateWallpaperWithTarget = SHOW_TRANSACTIONS;
                    if (closingAppHasWallpaper && openingAppHasWallpaper) {
                        switch (transit) {
                            case C0569H.REMOVE_STARTING /*6*/:
                            case C0569H.REPORT_APPLICATION_TOKEN_WINDOWS /*8*/:
                            case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
                                transit = 14;
                                break;
                            case C0569H.FINISHED_STARTING /*7*/:
                            case C0569H.REPORT_APPLICATION_TOKEN_DRAWN /*9*/:
                            case C0569H.WINDOW_FREEZE_TIMEOUT /*11*/:
                                transit = 15;
                                break;
                        }
                    } else if (oldWallpaper != null && !this.mOpeningApps.isEmpty() && !this.mOpeningApps.contains(oldWallpaper.mAppToken)) {
                        transit = 12;
                    } else if (this.mWallpaperTarget == null || !this.mWallpaperTarget.isVisibleLw()) {
                        this.mAnimateWallpaperWithTarget = HIDE_STACK_CRAWLS;
                    } else {
                        transit = 13;
                    }
                    if (!this.mPolicy.allowAppAnimationsLw()) {
                        animLp = null;
                    }
                    AppWindowToken topOpeningApp = null;
                    AppWindowToken topClosingApp = null;
                    int topOpeningLayer = WALLPAPER_DRAW_NORMAL;
                    int topClosingLayer = WALLPAPER_DRAW_NORMAL;
                    if (transit == 17) {
                        win = findFocusedWindowLocked(getDefaultDisplayContentLocked());
                        if (win != null) {
                            wtoken = win.mAppToken;
                            appAnimator = wtoken.mAppAnimator;
                            appAnimator.clearThumbnail();
                            appAnimator.animation = null;
                            updateTokenInPlaceLocked(wtoken, transit);
                            wtoken.updateReportedVisibilityLocked();
                            appAnimator.mAllAppWinAnimators.clear();
                            N = wtoken.allAppWindows.size();
                            for (j = WALLPAPER_DRAW_NORMAL; j < N; j += WALLPAPER_DRAW_PENDING) {
                                appAnimator.mAllAppWinAnimators.add(((WindowState) wtoken.allAppWindows.get(j)).mWinAnimator);
                            }
                            windowAnimator = this.mAnimator;
                            windowAnimator.mAnimating |= appAnimator.showAllWindowsLocked();
                        }
                    }
                    NN = this.mOpeningApps.size();
                    for (i = WALLPAPER_DRAW_NORMAL; i < NN; i += WALLPAPER_DRAW_PENDING) {
                        wtoken = (AppWindowToken) this.mOpeningApps.valueAt(i);
                        appAnimator = wtoken.mAppAnimator;
                        appAnimator.clearThumbnail();
                        appAnimator.animation = null;
                        wtoken.inPendingTransaction = SHOW_TRANSACTIONS;
                        setTokenVisibilityLocked(wtoken, animLp, HIDE_STACK_CRAWLS, transit, SHOW_TRANSACTIONS, voiceInteraction);
                        wtoken.updateReportedVisibilityLocked();
                        wtoken.waitingToShow = SHOW_TRANSACTIONS;
                        appAnimator.mAllAppWinAnimators.clear();
                        N = wtoken.allAppWindows.size();
                        for (j = WALLPAPER_DRAW_NORMAL; j < N; j += WALLPAPER_DRAW_PENDING) {
                            appAnimator.mAllAppWinAnimators.add(((WindowState) wtoken.allAppWindows.get(j)).mWinAnimator);
                        }
                        windowAnimator = this.mAnimator;
                        windowAnimator.mAnimating |= appAnimator.showAllWindowsLocked();
                        if (animLp != null) {
                            layer = -1;
                            for (j = WALLPAPER_DRAW_NORMAL; j < wtoken.windows.size(); j += WALLPAPER_DRAW_PENDING) {
                                win = (WindowState) wtoken.windows.get(j);
                                if (win.mWinAnimator.mAnimLayer > layer) {
                                    layer = win.mWinAnimator.mAnimLayer;
                                }
                            }
                            if (topOpeningApp == null || layer > topOpeningLayer) {
                                topOpeningApp = wtoken;
                                topOpeningLayer = layer;
                            }
                        }
                    }
                    NN = this.mClosingApps.size();
                    for (i = WALLPAPER_DRAW_NORMAL; i < NN; i += WALLPAPER_DRAW_PENDING) {
                        wtoken = (AppWindowToken) this.mClosingApps.valueAt(i);
                        appAnimator = wtoken.mAppAnimator;
                        appAnimator.clearThumbnail();
                        appAnimator.animation = null;
                        wtoken.inPendingTransaction = SHOW_TRANSACTIONS;
                        setTokenVisibilityLocked(wtoken, animLp, SHOW_TRANSACTIONS, transit, SHOW_TRANSACTIONS, voiceInteraction);
                        wtoken.updateReportedVisibilityLocked();
                        wtoken.waitingToHide = SHOW_TRANSACTIONS;
                        wtoken.allDrawn = HIDE_STACK_CRAWLS;
                        wtoken.deferClearAllDrawn = SHOW_TRANSACTIONS;
                        if (!(wtoken.startingWindow == null || wtoken.startingWindow.mExiting)) {
                            scheduleRemoveStartingWindowLocked(wtoken);
                        }
                        if (animLp != null) {
                            layer = -1;
                            for (j = WALLPAPER_DRAW_NORMAL; j < wtoken.windows.size(); j += WALLPAPER_DRAW_PENDING) {
                                win = (WindowState) wtoken.windows.get(j);
                                if (win.mWinAnimator.mAnimLayer > layer) {
                                    layer = win.mWinAnimator.mAnimLayer;
                                }
                            }
                            if (topClosingApp == null || layer > topClosingLayer) {
                                topClosingApp = wtoken;
                                topClosingLayer = layer;
                            }
                        }
                    }
                    AppWindowAnimator openingAppAnimator = topOpeningApp == null ? null : topOpeningApp.mAppAnimator;
                    if (topClosingApp != null) {
                        AppWindowAnimator appWindowAnimator = topClosingApp.mAppAnimator;
                    }
                    Bitmap nextAppTransitionThumbnail = this.mAppTransition.getNextAppTransitionThumbnail();
                    if (!(nextAppTransitionThumbnail == null || openingAppAnimator == null || openingAppAnimator.animation == null || nextAppTransitionThumbnail.getConfig() == Config.ALPHA_8)) {
                        Rect rect = new Rect(WALLPAPER_DRAW_NORMAL, WALLPAPER_DRAW_NORMAL, nextAppTransitionThumbnail.getWidth(), nextAppTransitionThumbnail.getHeight());
                        try {
                            Animation anim;
                            DisplayContent displayContent = getDefaultDisplayContentLocked();
                            Display display = displayContent.getDisplay();
                            DisplayInfo displayInfo = displayContent.getDisplayInfo();
                            SurfaceControl surfaceControl = new SurfaceControl(this.mFxSession, "thumbnail anim", rect.width(), rect.height(), -3, LAYOUT_REPEAT_THRESHOLD);
                            surfaceControl.setLayerStack(display.getLayerStack());
                            Surface drawSurface = new Surface();
                            drawSurface.copyFrom(surfaceControl);
                            Canvas c = drawSurface.lockCanvas(rect);
                            c.drawBitmap(nextAppTransitionThumbnail, 0.0f, 0.0f, null);
                            drawSurface.unlockCanvasAndPost(c);
                            drawSurface.release();
                            if (this.mAppTransition.isNextThumbnailTransitionAspectScaled()) {
                                anim = this.mAppTransition.createThumbnailAspectScaleAnimationLocked(displayInfo.appWidth, displayInfo.appHeight, displayInfo.logicalWidth, transit);
                                openingAppAnimator.thumbnailForceAboveLayer = Math.max(topOpeningLayer, topClosingLayer);
                                openingAppAnimator.deferThumbnailDestruction = !this.mAppTransition.isNextThumbnailTransitionScaleUp() ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                            } else {
                                anim = this.mAppTransition.createThumbnailScaleAnimationLocked(displayInfo.appWidth, displayInfo.appHeight, transit);
                            }
                            anim.restrictDuration(WALLPAPER_TIMEOUT_RECOVERY);
                            anim.scaleCurrentDuration(getTransitionAnimationScaleLocked());
                            openingAppAnimator.thumbnail = surfaceControl;
                            openingAppAnimator.thumbnailLayer = topOpeningLayer;
                            openingAppAnimator.thumbnailAnimation = anim;
                            openingAppAnimator.thumbnailX = this.mAppTransition.getStartingX();
                            openingAppAnimator.thumbnailY = this.mAppTransition.getStartingY();
                        } catch (Throwable e) {
                            Slog.e(TAG, "Can't allocate thumbnail/Canvas surface w=" + rect.width() + " h=" + rect.height(), e);
                            openingAppAnimator.clearThumbnail();
                        }
                    }
                    this.mAppTransition.postAnimationCallback();
                    this.mAppTransition.clear();
                    this.mOpeningApps.clear();
                    this.mClosingApps.clear();
                    changes = WALLPAPER_DRAW_NORMAL | UPDATE_FOCUS_WILL_PLACE_SURFACES;
                    getDefaultDisplayContentLocked().layoutNeeded = HIDE_STACK_CRAWLS;
                    if (windows == getDefaultWindowListLocked() && !moveInputMethodWindowsIfNeededLocked(HIDE_STACK_CRAWLS)) {
                        assignLayersLocked(windows);
                    }
                    updateFocusedWindowLocked(WALLPAPER_DRAW_TIMEOUT, HIDE_STACK_CRAWLS);
                    this.mFocusMayChange = SHOW_TRANSACTIONS;
                    notifyActivityDrawnForKeyguard();
                }
                return changes;
            }

            private int handleAnimatingStoppedAndTransitionLocked() {
                this.mAppTransition.setIdle();
                ArrayList<TaskStack> stacks = getDefaultDisplayContentLocked().getStacks();
                for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                    ArrayList<Task> tasks = ((TaskStack) stacks.get(stackNdx)).getTasks();
                    for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
                        AppTokenList tokens = ((Task) tasks.get(taskNdx)).mAppTokens;
                        for (int tokenNdx = tokens.size() - 1; tokenNdx >= 0; tokenNdx--) {
                            ((AppWindowToken) tokens.get(tokenNdx)).sendingToBottom = SHOW_TRANSACTIONS;
                        }
                    }
                }
                rebuildAppWindowListLocked();
                int changes = WALLPAPER_DRAW_NORMAL | WALLPAPER_DRAW_PENDING;
                moveInputMethodWindowsIfNeededLocked(HIDE_STACK_CRAWLS);
                this.mInnerFields.mWallpaperMayChange = HIDE_STACK_CRAWLS;
                this.mFocusMayChange = HIDE_STACK_CRAWLS;
                return changes;
            }

            private void updateResizingWindows(WindowState w) {
                WindowStateAnimator winAnimator = w.mWinAnimator;
                if (w.mHasSurface && w.mLayoutSeq == this.mLayoutSeq) {
                    w.setInsetsChanged();
                    boolean configChanged = w.isConfigChanged();
                    w.mLastFrame.set(w.mFrame);
                    if (w.mContentInsetsChanged || w.mVisibleInsetsChanged || winAnimator.mSurfaceResized || configChanged) {
                        w.mLastOverscanInsets.set(w.mOverscanInsets);
                        w.mLastContentInsets.set(w.mContentInsets);
                        w.mLastVisibleInsets.set(w.mVisibleInsets);
                        w.mLastStableInsets.set(w.mStableInsets);
                        makeWindowFreezingScreenIfNeededLocked(w);
                        if (w.mOrientationChanging) {
                            winAnimator.mDrawState = WALLPAPER_DRAW_PENDING;
                            if (w.mAppToken != null) {
                                w.mAppToken.allDrawn = SHOW_TRANSACTIONS;
                                w.mAppToken.deferClearAllDrawn = SHOW_TRANSACTIONS;
                            }
                        }
                        if (!this.mResizingWindows.contains(w)) {
                            this.mResizingWindows.add(w);
                        }
                    } else if (w.mOrientationChanging && w.isDrawnLw()) {
                        w.mOrientationChanging = SHOW_TRANSACTIONS;
                        w.mLastFreezeDuration = (int) (SystemClock.elapsedRealtime() - this.mDisplayFreezeTime);
                    }
                }
            }

            private void handleNotObscuredLocked(WindowState w, long currentTime, int innerDw, int innerDh) {
                LayoutParams attrs = w.mAttrs;
                int attrFlags = attrs.flags;
                boolean canBeSeen = w.isDisplayedLw();
                boolean opaqueDrawn = (canBeSeen && w.isOpaqueDrawn()) ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                if (opaqueDrawn && w.isFullscreen(innerDw, innerDh)) {
                    this.mInnerFields.mObscured = HIDE_STACK_CRAWLS;
                }
                if (w.mHasSurface) {
                    if ((attrFlags & DumpState.DUMP_PROVIDERS) != 0) {
                        this.mInnerFields.mHoldScreen = w.mSession;
                    }
                    if (!this.mInnerFields.mSyswin && w.mAttrs.screenBrightness >= 0.0f && this.mInnerFields.mScreenBrightness < 0.0f) {
                        this.mInnerFields.mScreenBrightness = w.mAttrs.screenBrightness;
                    }
                    if (!this.mInnerFields.mSyswin && w.mAttrs.buttonBrightness >= 0.0f && this.mInnerFields.mButtonBrightness < 0.0f) {
                        this.mInnerFields.mButtonBrightness = w.mAttrs.buttonBrightness;
                    }
                    if (!this.mInnerFields.mSyswin && w.mAttrs.userActivityTimeout >= 0 && this.mInnerFields.mUserActivityTimeout < 0) {
                        this.mInnerFields.mUserActivityTimeout = w.mAttrs.userActivityTimeout;
                    }
                    int type = attrs.type;
                    if (canBeSeen && (type == 2008 || type == 2010 || (attrs.privateFlags & DumpState.DUMP_PREFERRED_XML) != 0)) {
                        this.mInnerFields.mSyswin = HIDE_STACK_CRAWLS;
                    }
                    if (canBeSeen) {
                        DisplayContent displayContent = w.getDisplayContent();
                        if (displayContent != null && displayContent.isDefaultDisplay) {
                            if (type == 2023 || (attrs.privateFlags & DumpState.DUMP_PREFERRED_XML) != 0) {
                                this.mInnerFields.mObscureApplicationContentOnSecondaryDisplays = HIDE_STACK_CRAWLS;
                            }
                            this.mInnerFields.mDisplayHasContent = HIDE_STACK_CRAWLS;
                        } else if (displayContent != null && (!this.mInnerFields.mObscureApplicationContentOnSecondaryDisplays || (this.mInnerFields.mObscured && type == 2009))) {
                            this.mInnerFields.mDisplayHasContent = HIDE_STACK_CRAWLS;
                        }
                        if (this.mInnerFields.mPreferredRefreshRate == 0.0f && w.mAttrs.preferredRefreshRate != 0.0f) {
                            this.mInnerFields.mPreferredRefreshRate = w.mAttrs.preferredRefreshRate;
                        }
                    }
                }
            }

            private void handleFlagDimBehind(WindowState w) {
                if ((w.mAttrs.flags & WALLPAPER_DRAW_TIMEOUT) != 0 && w.isDisplayedLw() && !w.mExiting) {
                    WindowStateAnimator winAnimator = w.mWinAnimator;
                    TaskStack stack = w.getStack();
                    if (stack != null) {
                        stack.setDimmingTag();
                        if (!stack.isDimming(winAnimator)) {
                            stack.startDimmingIfNeeded(winAnimator);
                        }
                    }
                }
            }

            private void handlePrivateFlagFullyTransparent(WindowState w) {
                w.mWinAnimator.updateFullyTransparent(w.mAttrs);
            }

            private void updateAllDrawnLocked(DisplayContent displayContent) {
                ArrayList<TaskStack> stacks = displayContent.getStacks();
                for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                    ArrayList<Task> tasks = ((TaskStack) stacks.get(stackNdx)).getTasks();
                    for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
                        AppTokenList tokens = ((Task) tasks.get(taskNdx)).mAppTokens;
                        for (int tokenNdx = tokens.size() - 1; tokenNdx >= 0; tokenNdx--) {
                            AppWindowToken wtoken = (AppWindowToken) tokens.get(tokenNdx);
                            if (!wtoken.allDrawn) {
                                int numInteresting = wtoken.numInterestingWindows;
                                if (numInteresting > 0 && wtoken.numDrawnWindows >= numInteresting) {
                                    wtoken.allDrawn = HIDE_STACK_CRAWLS;
                                    displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                                    this.mH.obtainMessage(32, wtoken.token).sendToTarget();
                                }
                            }
                        }
                    }
                }
            }

            private int toBrightnessOverride(float value) {
                return (int) (255.0f * value);
            }

            void checkDrawnWindowsLocked() {
                if (!this.mWaitingForDrawn.isEmpty() && this.mWaitingForDrawnCallback != null) {
                    for (int j = this.mWaitingForDrawn.size() - 1; j >= 0; j--) {
                        WindowState win = (WindowState) this.mWaitingForDrawn.get(j);
                        if (win.mRemoved || !win.mHasSurface) {
                            this.mWaitingForDrawn.remove(win);
                        } else if (win.hasDrawnLw()) {
                            this.mWaitingForDrawn.remove(win);
                        }
                    }
                    if (this.mWaitingForDrawn.isEmpty()) {
                        this.mH.removeMessages(24);
                        this.mH.sendEmptyMessage(33);
                    }
                }
            }

            void setHoldScreenLocked(Session newHoldScreen) {
                boolean hold = newHoldScreen != null ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
                if (hold && this.mHoldingScreenOn != newHoldScreen) {
                    this.mHoldingScreenWakeLock.setWorkSource(new WorkSource(newHoldScreen.mUid));
                }
                this.mHoldingScreenOn = newHoldScreen;
                if (hold == this.mHoldingScreenWakeLock.isHeld()) {
                    return;
                }
                if (hold) {
                    this.mHoldingScreenWakeLock.acquire();
                    this.mPolicy.keepScreenOnStartedLw();
                    return;
                }
                this.mPolicy.keepScreenOnStoppedLw();
                this.mHoldingScreenWakeLock.release();
            }

            void requestTraversal() {
                synchronized (this.mWindowMap) {
                    requestTraversalLocked();
                }
            }

            void requestTraversalLocked() {
                if (!this.mTraversalScheduled) {
                    this.mTraversalScheduled = HIDE_STACK_CRAWLS;
                    this.mH.sendEmptyMessage(LAYOUT_REPEAT_THRESHOLD);
                }
            }

            void scheduleAnimationLocked() {
                if (!this.mAnimationScheduled) {
                    this.mAnimationScheduled = HIDE_STACK_CRAWLS;
                    this.mChoreographer.postCallback(WALLPAPER_DRAW_PENDING, this.mAnimator.mAnimationRunnable, null);
                }
            }

            private boolean needsLayout() {
                int numDisplays = this.mDisplayContents.size();
                for (int displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                    if (((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).layoutNeeded) {
                        return HIDE_STACK_CRAWLS;
                    }
                }
                return SHOW_TRANSACTIONS;
            }

            boolean copyAnimToLayoutParamsLocked() {
                boolean doRequest = SHOW_TRANSACTIONS;
                int bulkUpdateParams = this.mAnimator.mBulkUpdateParams;
                if ((bulkUpdateParams & WALLPAPER_DRAW_PENDING) != 0) {
                    this.mInnerFields.mUpdateRotation = HIDE_STACK_CRAWLS;
                    doRequest = HIDE_STACK_CRAWLS;
                }
                if ((bulkUpdateParams & WALLPAPER_DRAW_TIMEOUT) != 0) {
                    this.mInnerFields.mWallpaperMayChange = HIDE_STACK_CRAWLS;
                    doRequest = HIDE_STACK_CRAWLS;
                }
                if ((bulkUpdateParams & LAYOUT_REPEAT_THRESHOLD) != 0) {
                    this.mInnerFields.mWallpaperForceHidingChanged = HIDE_STACK_CRAWLS;
                    doRequest = HIDE_STACK_CRAWLS;
                }
                if ((bulkUpdateParams & 8) == 0) {
                    this.mInnerFields.mOrientationChangeComplete = SHOW_TRANSACTIONS;
                } else {
                    this.mInnerFields.mOrientationChangeComplete = HIDE_STACK_CRAWLS;
                    this.mInnerFields.mLastWindowFreezeSource = this.mAnimator.mLastWindowFreezeSource;
                    if (this.mWindowsFreezingScreen) {
                        doRequest = HIDE_STACK_CRAWLS;
                    }
                }
                if ((bulkUpdateParams & 16) != 0) {
                    this.mTurnOnScreen = HIDE_STACK_CRAWLS;
                }
                if ((bulkUpdateParams & 32) != 0) {
                    this.mInnerFields.mWallpaperActionPending = HIDE_STACK_CRAWLS;
                }
                return doRequest;
            }

            int adjustAnimationBackground(WindowStateAnimator winAnimator) {
                WindowList windows = winAnimator.mWin.getWindowList();
                for (int i = windows.size() - 1; i >= 0; i--) {
                    WindowState testWin = (WindowState) windows.get(i);
                    if (testWin.mIsWallpaper && testWin.isVisibleNow()) {
                        return testWin.mWinAnimator.mAnimLayer;
                    }
                }
                return winAnimator.mAnimLayer;
            }

            boolean reclaimSomeSurfaceMemoryLocked(WindowStateAnimator winAnimator, String operation, boolean secure) {
                int displayNdx;
                SurfaceControl surface = winAnimator.mSurfaceControl;
                boolean leakedSurface = SHOW_TRANSACTIONS;
                boolean killedApps = SHOW_TRANSACTIONS;
                Object[] objArr = new Object[UPDATE_FOCUS_WILL_PLACE_SURFACES];
                objArr[WALLPAPER_DRAW_NORMAL] = winAnimator.mWin.toString();
                objArr[WALLPAPER_DRAW_PENDING] = Integer.valueOf(winAnimator.mSession.mPid);
                objArr[WALLPAPER_DRAW_TIMEOUT] = operation;
                EventLog.writeEvent(EventLogTags.WM_NO_SURFACE_MEMORY, objArr);
                if (this.mForceRemoves == null) {
                    this.mForceRemoves = new ArrayList();
                }
                long callingIdentity = Binder.clearCallingIdentity();
                Slog.i(TAG, "Out of memory for surface!  Looking for leaks...");
                int numDisplays = this.mDisplayContents.size();
                for (displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                    int winNdx;
                    WindowList windows = ((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).getWindowList();
                    int numWindows = windows.size();
                    for (winNdx = WALLPAPER_DRAW_NORMAL; winNdx < numWindows; winNdx += WALLPAPER_DRAW_PENDING) {
                        WindowState ws = (WindowState) windows.get(winNdx);
                        WindowStateAnimator wsa = ws.mWinAnimator;
                        if (wsa.mSurfaceControl != null) {
                            StringBuilder append;
                            if (!this.mSessions.contains(wsa.mSession)) {
                                append = new StringBuilder().append("LEAKED SURFACE (session doesn't exist): ");
                                SurfaceControl surfaceControl = wsa.mSurfaceControl;
                                WindowToken windowToken = ws.mToken;
                                Slog.w(TAG, r20.append(ws).append(" surface=").append(r0).append(" token=").append(r0).append(" pid=").append(ws.mSession.mPid).append(" uid=").append(ws.mSession.mUid).toString());
                                wsa.mSurfaceControl.destroy();
                                wsa.mSurfaceShown = SHOW_TRANSACTIONS;
                                wsa.mSurfaceControl = null;
                                ws.mHasSurface = SHOW_TRANSACTIONS;
                                this.mForceRemoves.add(ws);
                                leakedSurface = HIDE_STACK_CRAWLS;
                            } else if (ws.mAppToken != null) {
                                if (ws.mAppToken.clientHidden) {
                                    append = new StringBuilder().append("LEAKED SURFACE (app token hidden): ");
                                    Slog.w(TAG, r20.append(ws).append(" surface=").append(wsa.mSurfaceControl).append(" token=").append(ws.mAppToken).toString());
                                    wsa.mSurfaceControl.destroy();
                                    wsa.mSurfaceShown = SHOW_TRANSACTIONS;
                                    wsa.mSurfaceControl = null;
                                    ws.mHasSurface = SHOW_TRANSACTIONS;
                                    leakedSurface = HIDE_STACK_CRAWLS;
                                }
                            }
                        }
                    }
                }
                if (!leakedSurface) {
                    Slog.w(TAG, "No leaked surfaces; killing applicatons!");
                    SparseIntArray pidCandidates = new SparseIntArray();
                    displayNdx = WALLPAPER_DRAW_NORMAL;
                    while (displayNdx < numDisplays) {
                        windows = ((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).getWindowList();
                        numWindows = windows.size();
                        for (winNdx = WALLPAPER_DRAW_NORMAL; winNdx < numWindows; winNdx += WALLPAPER_DRAW_PENDING) {
                            ws = (WindowState) windows.get(winNdx);
                            if (!this.mForceRemoves.contains(ws)) {
                                wsa = ws.mWinAnimator;
                                if (wsa.mSurfaceControl != null) {
                                    pidCandidates.append(wsa.mSession.mPid, wsa.mSession.mPid);
                                }
                            }
                        }
                        try {
                            if (pidCandidates.size() > 0) {
                                int[] pids = new int[pidCandidates.size()];
                                int i = WALLPAPER_DRAW_NORMAL;
                                while (true) {
                                    int length = pids.length;
                                    if (i < r0) {
                                        pids[i] = pidCandidates.keyAt(i);
                                        i += WALLPAPER_DRAW_PENDING;
                                    } else {
                                        try {
                                            break;
                                        } catch (RemoteException e) {
                                        }
                                    }
                                }
                                if (this.mActivityManager.killPids(pids, "Free memory", secure)) {
                                    killedApps = HIDE_STACK_CRAWLS;
                                }
                            }
                            displayNdx += WALLPAPER_DRAW_PENDING;
                        } catch (Throwable th) {
                            Binder.restoreCallingIdentity(callingIdentity);
                        }
                    }
                }
                if (leakedSurface || killedApps) {
                    Slog.w(TAG, "Looks like we have reclaimed some memory, clearing surface for retry.");
                    if (surface != null) {
                        surface.destroy();
                        winAnimator.mSurfaceShown = SHOW_TRANSACTIONS;
                        winAnimator.mSurfaceControl = null;
                        winAnimator.mWin.mHasSurface = SHOW_TRANSACTIONS;
                        scheduleRemoveStartingWindowLocked(winAnimator.mWin.mAppToken);
                    }
                    try {
                        winAnimator.mWin.mClient.dispatchGetNewSurface();
                    } catch (RemoteException e2) {
                    }
                }
                Binder.restoreCallingIdentity(callingIdentity);
                return (leakedSurface || killedApps) ? HIDE_STACK_CRAWLS : SHOW_TRANSACTIONS;
            }

            private boolean updateFocusedWindowLocked(int mode, boolean updateInputWindows) {
                boolean z = SHOW_TRANSACTIONS;
                WindowState newFocus = computeFocusedWindowLocked();
                if (this.mCurrentFocus == newFocus) {
                    return SHOW_TRANSACTIONS;
                }
                Trace.traceBegin(32, "wmUpdateFocus");
                this.mH.removeMessages(WALLPAPER_DRAW_TIMEOUT);
                this.mH.sendEmptyMessage(WALLPAPER_DRAW_TIMEOUT);
                DisplayContent displayContent = getDefaultDisplayContentLocked();
                if (!(mode == WALLPAPER_DRAW_PENDING || mode == UPDATE_FOCUS_WILL_PLACE_SURFACES)) {
                    z = HIDE_STACK_CRAWLS;
                }
                boolean imWindowChanged = moveInputMethodWindowsIfNeededLocked(z);
                if (imWindowChanged) {
                    displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                    newFocus = computeFocusedWindowLocked();
                }
                WindowState oldFocus = this.mCurrentFocus;
                this.mCurrentFocus = newFocus;
                this.mLosingFocus.remove(newFocus);
                int focusChanged = this.mPolicy.focusChangedLw(oldFocus, newFocus);
                if (imWindowChanged && oldFocus != this.mInputMethodWindow) {
                    if (mode == WALLPAPER_DRAW_TIMEOUT) {
                        performLayoutLockedInner(displayContent, HIDE_STACK_CRAWLS, updateInputWindows);
                        focusChanged &= -2;
                    } else if (mode == UPDATE_FOCUS_WILL_PLACE_SURFACES) {
                        assignLayersLocked(displayContent.getWindowList());
                    }
                }
                if ((focusChanged & WALLPAPER_DRAW_PENDING) != 0) {
                    displayContent.layoutNeeded = HIDE_STACK_CRAWLS;
                    if (mode == WALLPAPER_DRAW_TIMEOUT) {
                        performLayoutLockedInner(displayContent, HIDE_STACK_CRAWLS, updateInputWindows);
                    }
                }
                if (mode != WALLPAPER_DRAW_PENDING) {
                    this.mInputMonitor.setInputFocusLw(this.mCurrentFocus, updateInputWindows);
                }
                Trace.traceEnd(32);
                return HIDE_STACK_CRAWLS;
            }

            private WindowState computeFocusedWindowLocked() {
                if (this.mAnimator.mUniverseBackground != null && this.mAnimator.mUniverseBackground.mWin.canReceiveKeys()) {
                    return this.mAnimator.mUniverseBackground.mWin;
                }
                int displayCount = this.mDisplayContents.size();
                for (int i = WALLPAPER_DRAW_NORMAL; i < displayCount; i += WALLPAPER_DRAW_PENDING) {
                    WindowState win = findFocusedWindowLocked((DisplayContent) this.mDisplayContents.valueAt(i));
                    if (win != null) {
                        return win;
                    }
                }
                return null;
            }

            private WindowState findFocusedWindowLocked(DisplayContent displayContent) {
                WindowList windows = displayContent.getWindowList();
                int i = windows.size() - 1;
                while (i >= 0) {
                    WindowState win = (WindowState) windows.get(i);
                    AppWindowToken wtoken = win.mAppToken;
                    if ((wtoken != null && (wtoken.removed || wtoken.sendingToBottom)) || !win.canReceiveKeys()) {
                        i--;
                    } else if (wtoken == null || win.mAttrs.type == UPDATE_FOCUS_WILL_PLACE_SURFACES || this.mFocusedApp == null) {
                        return win;
                    } else {
                        ArrayList<Task> tasks = displayContent.getTasks();
                        for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
                            AppTokenList tokens = ((Task) tasks.get(taskNdx)).mAppTokens;
                            int tokenNdx = tokens.size() - 1;
                            while (tokenNdx >= 0) {
                                AppWindowToken token = (AppWindowToken) tokens.get(tokenNdx);
                                if (wtoken == token) {
                                    break;
                                } else if (this.mFocusedApp == token) {
                                    return null;
                                } else {
                                    tokenNdx--;
                                }
                            }
                            if (tokenNdx >= 0) {
                                return win;
                            }
                        }
                        return win;
                    }
                }
                return null;
            }

            private void startFreezingDisplayLocked(boolean inTransaction, int exitAnim, int enterAnim) {
                if (!this.mDisplayFrozen && this.mDisplayReady && this.mPolicy.isScreenOn()) {
                    this.mScreenFrozenLock.acquire();
                    this.mDisplayFrozen = HIDE_STACK_CRAWLS;
                    this.mDisplayFreezeTime = SystemClock.elapsedRealtime();
                    this.mLastFinishedFreezeSource = null;
                    this.mInputMonitor.freezeInputDispatchingLw();
                    this.mPolicy.setLastInputMethodWindowLw(null, null);
                    if (this.mAppTransition.isTransitionSet()) {
                        this.mAppTransition.freeze();
                    }
                    this.mExitAnimId = exitAnim;
                    this.mEnterAnimId = enterAnim;
                    DisplayContent displayContent = getDefaultDisplayContentLocked();
                    int displayId = displayContent.getDisplayId();
                    ScreenRotationAnimation screenRotationAnimation = this.mAnimator.getScreenRotationAnimationLocked(displayId);
                    if (screenRotationAnimation != null) {
                        screenRotationAnimation.kill();
                    }
                    boolean isSecure = SHOW_TRANSACTIONS;
                    WindowList windows = getDefaultWindowListLocked();
                    int N = windows.size();
                    for (int i = WALLPAPER_DRAW_NORMAL; i < N; i += WALLPAPER_DRAW_PENDING) {
                        WindowState ws = (WindowState) windows.get(i);
                        if (ws.isOnScreen() && (ws.mAttrs.flags & DumpState.DUMP_INSTALLS) != 0) {
                            isSecure = HIDE_STACK_CRAWLS;
                            break;
                        }
                    }
                    displayContent.updateDisplayInfo();
                    this.mAnimator.setScreenRotationAnimationLocked(displayId, new ScreenRotationAnimation(this.mContext, displayContent, this.mFxSession, inTransaction, this.mPolicy.isDefaultOrientationForced(), isSecure));
                }
            }

            private void stopFreezingDisplayLocked() {
                if (this.mDisplayFrozen && !this.mWaitingForConfig && this.mAppsFreezingScreen <= 0 && !this.mWindowsFreezingScreen && !this.mClientFreezingScreen && this.mOpeningApps.isEmpty()) {
                    this.mDisplayFrozen = SHOW_TRANSACTIONS;
                    this.mLastDisplayFreezeDuration = (int) (SystemClock.elapsedRealtime() - this.mDisplayFreezeTime);
                    StringBuilder stringBuilder = new StringBuilder(DumpState.DUMP_PROVIDERS);
                    stringBuilder.append("Screen frozen for ");
                    TimeUtils.formatDuration((long) this.mLastDisplayFreezeDuration, stringBuilder);
                    if (this.mLastFinishedFreezeSource != null) {
                        stringBuilder.append(" due to ");
                        stringBuilder.append(this.mLastFinishedFreezeSource);
                    }
                    Slog.i(TAG, stringBuilder.toString());
                    this.mH.removeMessages(17);
                    this.mH.removeMessages(30);
                    boolean updateRotation = SHOW_TRANSACTIONS;
                    DisplayContent displayContent = getDefaultDisplayContentLocked();
                    int displayId = displayContent.getDisplayId();
                    ScreenRotationAnimation screenRotationAnimation = this.mAnimator.getScreenRotationAnimationLocked(displayId);
                    if (screenRotationAnimation == null || !screenRotationAnimation.hasScreenshot()) {
                        if (screenRotationAnimation != null) {
                            screenRotationAnimation.kill();
                            this.mAnimator.setScreenRotationAnimationLocked(displayId, null);
                        }
                        updateRotation = HIDE_STACK_CRAWLS;
                    } else {
                        DisplayInfo displayInfo = displayContent.getDisplayInfo();
                        if (!this.mPolicy.validateRotationAnimationLw(this.mExitAnimId, this.mEnterAnimId, displayContent.isDimming())) {
                            this.mEnterAnimId = WALLPAPER_DRAW_NORMAL;
                            this.mExitAnimId = WALLPAPER_DRAW_NORMAL;
                        }
                        if (screenRotationAnimation.dismiss(this.mFxSession, WALLPAPER_TIMEOUT_RECOVERY, getTransitionAnimationScaleLocked(), displayInfo.logicalWidth, displayInfo.logicalHeight, this.mExitAnimId, this.mEnterAnimId)) {
                            scheduleAnimationLocked();
                        } else {
                            screenRotationAnimation.kill();
                            this.mAnimator.setScreenRotationAnimationLocked(displayId, null);
                            updateRotation = HIDE_STACK_CRAWLS;
                        }
                    }
                    this.mInputMonitor.thawInputDispatchingLw();
                    boolean configChanged = updateOrientationFromAppTokensLocked(SHOW_TRANSACTIONS);
                    this.mH.removeMessages(15);
                    this.mH.sendEmptyMessageDelayed(15, 2000);
                    this.mScreenFrozenLock.release();
                    if (updateRotation) {
                        configChanged |= updateRotationUncheckedLocked(SHOW_TRANSACTIONS);
                    }
                    if (configChanged) {
                        this.mH.sendEmptyMessage(18);
                    }
                }
            }

            static int getPropertyInt(String[] tokens, int index, int defUnits, int defDps, DisplayMetrics dm) {
                if (index < tokens.length) {
                    String str = tokens[index];
                    if (str != null && str.length() > 0) {
                        try {
                            return Integer.parseInt(str);
                        } catch (Exception e) {
                        }
                    }
                }
                if (defUnits == 0) {
                    return defDps;
                }
                return (int) TypedValue.applyDimension(defUnits, (float) defDps, dm);
            }

            void createWatermarkInTransaction() {
                Throwable th;
                if (this.mWatermark == null) {
                    FileInputStream in = null;
                    DataInputStream ind = null;
                    try {
                        FileInputStream in2 = new FileInputStream(new File("/system/etc/setup.conf"));
                        try {
                            DataInputStream ind2 = new DataInputStream(in2);
                            try {
                                String line = ind2.readLine();
                                if (line != null) {
                                    String[] toks = line.split("%");
                                    if (toks != null && toks.length > 0) {
                                        this.mWatermark = new Watermark(getDefaultDisplayContentLocked().getDisplay(), this.mRealDisplayMetrics, this.mFxSession, toks);
                                    }
                                }
                                if (ind2 != null) {
                                    try {
                                        ind2.close();
                                        ind = ind2;
                                        in = in2;
                                    } catch (IOException e) {
                                        ind = ind2;
                                        in = in2;
                                    }
                                } else if (in2 != null) {
                                    try {
                                        in2.close();
                                        ind = ind2;
                                        in = in2;
                                    } catch (IOException e2) {
                                        ind = ind2;
                                        in = in2;
                                    }
                                } else {
                                    in = in2;
                                }
                            } catch (FileNotFoundException e3) {
                                ind = ind2;
                                in = in2;
                                if (ind == null) {
                                    try {
                                        ind.close();
                                    } catch (IOException e4) {
                                    }
                                } else if (in == null) {
                                    try {
                                        in.close();
                                    } catch (IOException e5) {
                                    }
                                }
                            } catch (IOException e6) {
                                ind = ind2;
                                in = in2;
                                if (ind == null) {
                                    try {
                                        ind.close();
                                    } catch (IOException e7) {
                                    }
                                } else if (in == null) {
                                    try {
                                        in.close();
                                    } catch (IOException e8) {
                                    }
                                }
                            } catch (Throwable th2) {
                                th = th2;
                                ind = ind2;
                                in = in2;
                                if (ind == null) {
                                    try {
                                        ind.close();
                                    } catch (IOException e9) {
                                    }
                                } else if (in != null) {
                                    try {
                                        in.close();
                                    } catch (IOException e10) {
                                    }
                                }
                                throw th;
                            }
                        } catch (FileNotFoundException e11) {
                            in = in2;
                            if (ind == null) {
                                ind.close();
                            } else if (in == null) {
                                in.close();
                            }
                        } catch (IOException e12) {
                            in = in2;
                            if (ind == null) {
                                ind.close();
                            } else if (in == null) {
                                in.close();
                            }
                        } catch (Throwable th3) {
                            th = th3;
                            in = in2;
                            if (ind == null) {
                                ind.close();
                            } else if (in != null) {
                                in.close();
                            }
                            throw th;
                        }
                    } catch (FileNotFoundException e13) {
                        if (ind == null) {
                            ind.close();
                        } else if (in == null) {
                            in.close();
                        }
                    } catch (IOException e14) {
                        if (ind == null) {
                            ind.close();
                        } else if (in == null) {
                            in.close();
                        }
                    } catch (Throwable th4) {
                        th = th4;
                        if (ind == null) {
                            ind.close();
                        } else if (in != null) {
                            in.close();
                        }
                        throw th;
                    }
                }
            }

            public void statusBarVisibilityChanged(int visibility) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.STATUS_BAR") != 0) {
                    throw new SecurityException("Caller does not hold permission android.permission.STATUS_BAR");
                }
                synchronized (this.mWindowMap) {
                    this.mLastStatusBarVisibility = visibility;
                    updateStatusBarVisibilityLocked(this.mPolicy.adjustSystemUiVisibilityLw(visibility));
                }
            }

            void updateStatusBarVisibilityLocked(int visibility) {
                this.mInputManager.setSystemUiVisibility(visibility);
                WindowList windows = getDefaultWindowListLocked();
                int N = windows.size();
                int i = WALLPAPER_DRAW_NORMAL;
                while (i < N) {
                    WindowState ws = (WindowState) windows.get(i);
                    try {
                        int curValue = ws.mSystemUiVisibility;
                        int diff = ((curValue ^ visibility) & 7) & (visibility ^ -1);
                        int newValue = ((diff ^ -1) & curValue) | (visibility & diff);
                        if (newValue != curValue) {
                            ws.mSeq += WALLPAPER_DRAW_PENDING;
                            ws.mSystemUiVisibility = newValue;
                        }
                        if (newValue != curValue || ws.mAttrs.hasSystemUiListeners) {
                            ws.mClient.dispatchSystemUiVisibilityChanged(ws.mSeq, visibility, newValue, diff);
                            i += WALLPAPER_DRAW_PENDING;
                        } else {
                            i += WALLPAPER_DRAW_PENDING;
                        }
                    } catch (RemoteException e) {
                    }
                }
            }

            public void reevaluateStatusBarVisibility() {
                synchronized (this.mWindowMap) {
                    updateStatusBarVisibilityLocked(this.mPolicy.adjustSystemUiVisibilityLw(this.mLastStatusBarVisibility));
                    performLayoutAndPlaceSurfacesLocked();
                }
            }

            public FakeWindow addFakeWindow(Looper looper, Factory inputEventReceiverFactory, String name, int windowType, int layoutParamsFlags, int layoutParamsPrivateFlags, boolean canReceiveKeys, boolean hasFocus, boolean touchFullscreen) {
                FakeWindowImpl fw;
                synchronized (this.mWindowMap) {
                    fw = new FakeWindowImpl(this, looper, inputEventReceiverFactory, name, windowType, layoutParamsFlags, canReceiveKeys, hasFocus, touchFullscreen);
                    while (WALLPAPER_DRAW_NORMAL < this.mFakeWindows.size()) {
                        if (((FakeWindowImpl) this.mFakeWindows.get(WALLPAPER_DRAW_NORMAL)).mWindowLayer <= fw.mWindowLayer) {
                            break;
                        }
                    }
                    this.mFakeWindows.add(WALLPAPER_DRAW_NORMAL, fw);
                    this.mInputMonitor.updateInputWindowsLw(HIDE_STACK_CRAWLS);
                }
                return fw;
            }

            boolean removeFakeWindowLocked(FakeWindow window) {
                boolean z = HIDE_STACK_CRAWLS;
                synchronized (this.mWindowMap) {
                    if (this.mFakeWindows.remove(window)) {
                        this.mInputMonitor.updateInputWindowsLw(HIDE_STACK_CRAWLS);
                    } else {
                        z = SHOW_TRANSACTIONS;
                    }
                }
                return z;
            }

            public void saveLastInputMethodWindowForTransition() {
                synchronized (this.mWindowMap) {
                    DisplayContent displayContent = getDefaultDisplayContentLocked();
                    if (this.mInputMethodWindow != null) {
                        this.mPolicy.setLastInputMethodWindowLw(this.mInputMethodWindow, this.mInputMethodTarget);
                    }
                }
            }

            public int getInputMethodWindowVisibleHeight() {
                int inputMethodWindowVisibleHeightLw;
                synchronized (this.mWindowMap) {
                    inputMethodWindowVisibleHeightLw = this.mPolicy.getInputMethodWindowVisibleHeightLw();
                }
                return inputMethodWindowVisibleHeightLw;
            }

            public boolean hasNavigationBar() {
                return this.mPolicy.hasNavigationBar();
            }

            public void lockNow(Bundle options) {
                this.mPolicy.lockNow(options);
            }

            public void showRecentApps() {
                this.mPolicy.showRecentApps();
            }

            public boolean isSafeModeEnabled() {
                return this.mSafeMode;
            }

            public boolean clearWindowContentFrameStats(IBinder token) {
                boolean z = SHOW_TRANSACTIONS;
                if (checkCallingPermission("android.permission.FRAME_STATS", "clearWindowContentFrameStats()")) {
                    synchronized (this.mWindowMap) {
                        WindowState windowState = (WindowState) this.mWindowMap.get(token);
                        if (windowState == null) {
                        } else {
                            SurfaceControl surfaceControl = windowState.mWinAnimator.mSurfaceControl;
                            if (surfaceControl == null) {
                            } else {
                                z = surfaceControl.clearContentFrameStats();
                            }
                        }
                    }
                    return z;
                }
                throw new SecurityException("Requires FRAME_STATS permission");
            }

            public WindowContentFrameStats getWindowContentFrameStats(IBinder token) {
                if (checkCallingPermission("android.permission.FRAME_STATS", "getWindowContentFrameStats()")) {
                    synchronized (this.mWindowMap) {
                        WindowState windowState = (WindowState) this.mWindowMap.get(token);
                        if (windowState == null) {
                            return null;
                        }
                        SurfaceControl surfaceControl = windowState.mWinAnimator.mSurfaceControl;
                        if (surfaceControl == null) {
                            return null;
                        }
                        if (this.mTempWindowRenderStats == null) {
                            this.mTempWindowRenderStats = new WindowContentFrameStats();
                        }
                        WindowContentFrameStats stats = this.mTempWindowRenderStats;
                        if (surfaceControl.getContentFrameStats(stats)) {
                            return stats;
                        }
                        return null;
                    }
                }
                throw new SecurityException("Requires FRAME_STATS permission");
            }

            void dumpPolicyLocked(PrintWriter pw, String[] args, boolean dumpAll) {
                pw.println("WINDOW MANAGER POLICY STATE (dumpsys window policy)");
                this.mPolicy.dump("    ", pw, args);
            }

            void dumpAnimatorLocked(PrintWriter pw, String[] args, boolean dumpAll) {
                pw.println("WINDOW MANAGER ANIMATOR STATE (dumpsys window animator)");
                this.mAnimator.dumpLocked(pw, "    ", dumpAll);
            }

            void dumpTokensLocked(PrintWriter pw, boolean dumpAll) {
                WindowToken token;
                int i;
                pw.println("WINDOW MANAGER TOKENS (dumpsys window tokens)");
                if (this.mTokenMap.size() > 0) {
                    pw.println("  All tokens:");
                    for (WindowToken token2 : this.mTokenMap.values()) {
                        pw.print("  ");
                        pw.print(token2);
                        if (dumpAll) {
                            pw.println(':');
                            token2.dump(pw, "    ");
                        } else {
                            pw.println();
                        }
                    }
                }
                if (this.mWallpaperTokens.size() > 0) {
                    pw.println();
                    pw.println("  Wallpaper tokens:");
                    for (i = this.mWallpaperTokens.size() - 1; i >= 0; i--) {
                        token2 = (WindowToken) this.mWallpaperTokens.get(i);
                        pw.print("  Wallpaper #");
                        pw.print(i);
                        pw.print(' ');
                        pw.print(token2);
                        if (dumpAll) {
                            pw.println(':');
                            token2.dump(pw, "    ");
                        } else {
                            pw.println();
                        }
                    }
                }
                if (this.mFinishedStarting.size() > 0) {
                    pw.println();
                    pw.println("  Finishing start of application tokens:");
                    for (i = this.mFinishedStarting.size() - 1; i >= 0; i--) {
                        token2 = (WindowToken) this.mFinishedStarting.get(i);
                        pw.print("  Finished Starting #");
                        pw.print(i);
                        pw.print(' ');
                        pw.print(token2);
                        if (dumpAll) {
                            pw.println(':');
                            token2.dump(pw, "    ");
                        } else {
                            pw.println();
                        }
                    }
                }
                if (this.mOpeningApps.size() > 0 || this.mClosingApps.size() > 0) {
                    pw.println();
                    if (this.mOpeningApps.size() > 0) {
                        pw.print("  mOpeningApps=");
                        pw.println(this.mOpeningApps);
                    }
                    if (this.mClosingApps.size() > 0) {
                        pw.print("  mClosingApps=");
                        pw.println(this.mClosingApps);
                    }
                }
            }

            void dumpSessionsLocked(PrintWriter pw, boolean dumpAll) {
                pw.println("WINDOW MANAGER SESSIONS (dumpsys window sessions)");
                for (int i = WALLPAPER_DRAW_NORMAL; i < this.mSessions.size(); i += WALLPAPER_DRAW_PENDING) {
                    Session s = (Session) this.mSessions.valueAt(i);
                    pw.print("  Session ");
                    pw.print(s);
                    pw.println(':');
                    s.dump(pw, "    ");
                }
            }

            void dumpDisplayContentsLocked(PrintWriter pw, boolean dumpAll) {
                pw.println("WINDOW MANAGER DISPLAY CONTENTS (dumpsys window displays)");
                if (this.mDisplayReady) {
                    int numDisplays = this.mDisplayContents.size();
                    for (int displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                        ((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).dump("  ", pw);
                    }
                    return;
                }
                pw.println("  NO DISPLAY");
            }

            void dumpWindowsLocked(PrintWriter pw, boolean dumpAll, ArrayList<WindowState> windows) {
                pw.println("WINDOW MANAGER WINDOWS (dumpsys window windows)");
                dumpWindowsNoHeaderLocked(pw, dumpAll, windows);
            }

            void dumpWindowsNoHeaderLocked(PrintWriter pw, boolean dumpAll, ArrayList<WindowState> windows) {
                int displayNdx;
                int i;
                int numDisplays = this.mDisplayContents.size();
                for (displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                    WindowList windowList = ((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).getWindowList();
                    for (int winNdx = windowList.size() - 1; winNdx >= 0; winNdx--) {
                        WindowState w = (WindowState) windowList.get(winNdx);
                        if (windows == null || windows.contains(w)) {
                            boolean z;
                            pw.print("  Window #");
                            pw.print(winNdx);
                            pw.print(' ');
                            pw.print(w);
                            pw.println(":");
                            String str = "    ";
                            if (dumpAll || windows != null) {
                                z = HIDE_STACK_CRAWLS;
                            } else {
                                z = SHOW_TRANSACTIONS;
                            }
                            w.dump(pw, str, z);
                        }
                    }
                }
                if (this.mInputMethodDialogs.size() > 0) {
                    pw.println();
                    pw.println("  Input method dialogs:");
                    for (i = this.mInputMethodDialogs.size() - 1; i >= 0; i--) {
                        w = (WindowState) this.mInputMethodDialogs.get(i);
                        if (windows == null || windows.contains(w)) {
                            pw.print("  IM Dialog #");
                            pw.print(i);
                            pw.print(": ");
                            pw.println(w);
                        }
                    }
                }
                if (this.mPendingRemove.size() > 0) {
                    pw.println();
                    pw.println("  Remove pending for:");
                    for (i = this.mPendingRemove.size() - 1; i >= 0; i--) {
                        w = (WindowState) this.mPendingRemove.get(i);
                        if (windows == null || windows.contains(w)) {
                            pw.print("  Remove #");
                            pw.print(i);
                            pw.print(' ');
                            pw.print(w);
                            if (dumpAll) {
                                pw.println(":");
                                w.dump(pw, "    ", HIDE_STACK_CRAWLS);
                            } else {
                                pw.println();
                            }
                        }
                    }
                }
                if (this.mForceRemoves != null && this.mForceRemoves.size() > 0) {
                    pw.println();
                    pw.println("  Windows force removing:");
                    for (i = this.mForceRemoves.size() - 1; i >= 0; i--) {
                        w = (WindowState) this.mForceRemoves.get(i);
                        pw.print("  Removing #");
                        pw.print(i);
                        pw.print(' ');
                        pw.print(w);
                        if (dumpAll) {
                            pw.println(":");
                            w.dump(pw, "    ", HIDE_STACK_CRAWLS);
                        } else {
                            pw.println();
                        }
                    }
                }
                if (this.mDestroySurface.size() > 0) {
                    pw.println();
                    pw.println("  Windows waiting to destroy their surface:");
                    for (i = this.mDestroySurface.size() - 1; i >= 0; i--) {
                        w = (WindowState) this.mDestroySurface.get(i);
                        if (windows == null || windows.contains(w)) {
                            pw.print("  Destroy #");
                            pw.print(i);
                            pw.print(' ');
                            pw.print(w);
                            if (dumpAll) {
                                pw.println(":");
                                w.dump(pw, "    ", HIDE_STACK_CRAWLS);
                            } else {
                                pw.println();
                            }
                        }
                    }
                }
                if (this.mLosingFocus.size() > 0) {
                    pw.println();
                    pw.println("  Windows losing focus:");
                    for (i = this.mLosingFocus.size() - 1; i >= 0; i--) {
                        w = (WindowState) this.mLosingFocus.get(i);
                        if (windows == null || windows.contains(w)) {
                            pw.print("  Losing #");
                            pw.print(i);
                            pw.print(' ');
                            pw.print(w);
                            if (dumpAll) {
                                pw.println(":");
                                w.dump(pw, "    ", HIDE_STACK_CRAWLS);
                            } else {
                                pw.println();
                            }
                        }
                    }
                }
                if (this.mResizingWindows.size() > 0) {
                    pw.println();
                    pw.println("  Windows waiting to resize:");
                    for (i = this.mResizingWindows.size() - 1; i >= 0; i--) {
                        w = (WindowState) this.mResizingWindows.get(i);
                        if (windows == null || windows.contains(w)) {
                            pw.print("  Resizing #");
                            pw.print(i);
                            pw.print(' ');
                            pw.print(w);
                            if (dumpAll) {
                                pw.println(":");
                                w.dump(pw, "    ", HIDE_STACK_CRAWLS);
                            } else {
                                pw.println();
                            }
                        }
                    }
                }
                if (this.mWaitingForDrawn.size() > 0) {
                    pw.println();
                    pw.println("  Clients waiting for these windows to be drawn:");
                    for (i = this.mWaitingForDrawn.size() - 1; i >= 0; i--) {
                        WindowState win = (WindowState) this.mWaitingForDrawn.get(i);
                        pw.print("  Waiting #");
                        pw.print(i);
                        pw.print(' ');
                        pw.print(win);
                    }
                }
                pw.println();
                pw.print("  mCurConfiguration=");
                pw.println(this.mCurConfiguration);
                pw.print("  mHasPermanentDpad=");
                pw.println(this.mHasPermanentDpad);
                pw.print("  mCurrentFocus=");
                pw.println(this.mCurrentFocus);
                if (this.mLastFocus != this.mCurrentFocus) {
                    pw.print("  mLastFocus=");
                    pw.println(this.mLastFocus);
                }
                pw.print("  mFocusedApp=");
                pw.println(this.mFocusedApp);
                if (this.mInputMethodTarget != null) {
                    pw.print("  mInputMethodTarget=");
                    pw.println(this.mInputMethodTarget);
                }
                pw.print("  mInTouchMode=");
                pw.print(this.mInTouchMode);
                pw.print(" mLayoutSeq=");
                pw.println(this.mLayoutSeq);
                pw.print("  mLastDisplayFreezeDuration=");
                TimeUtils.formatDuration((long) this.mLastDisplayFreezeDuration, pw);
                if (this.mLastFinishedFreezeSource != null) {
                    pw.print(" due to ");
                    pw.print(this.mLastFinishedFreezeSource);
                }
                pw.println();
                if (dumpAll) {
                    pw.print("  mSystemDecorLayer=");
                    pw.print(this.mSystemDecorLayer);
                    pw.print(" mScreenRect=");
                    pw.println(this.mScreenRect.toShortString());
                    if (this.mLastStatusBarVisibility != 0) {
                        pw.print("  mLastStatusBarVisibility=0x");
                        pw.println(Integer.toHexString(this.mLastStatusBarVisibility));
                    }
                    if (this.mInputMethodWindow != null) {
                        pw.print("  mInputMethodWindow=");
                        pw.println(this.mInputMethodWindow);
                    }
                    pw.print("  mWallpaperTarget=");
                    pw.println(this.mWallpaperTarget);
                    if (!(this.mLowerWallpaperTarget == null && this.mUpperWallpaperTarget == null)) {
                        pw.print("  mLowerWallpaperTarget=");
                        pw.println(this.mLowerWallpaperTarget);
                        pw.print("  mUpperWallpaperTarget=");
                        pw.println(this.mUpperWallpaperTarget);
                    }
                    pw.print("  mLastWallpaperX=");
                    pw.print(this.mLastWallpaperX);
                    pw.print(" mLastWallpaperY=");
                    pw.println(this.mLastWallpaperY);
                    if (!(this.mLastWallpaperDisplayOffsetX == SoundTriggerHelper.STATUS_ERROR && this.mLastWallpaperDisplayOffsetY == SoundTriggerHelper.STATUS_ERROR)) {
                        pw.print("  mLastWallpaperDisplayOffsetX=");
                        pw.print(this.mLastWallpaperDisplayOffsetX);
                        pw.print(" mLastWallpaperDisplayOffsetY=");
                        pw.println(this.mLastWallpaperDisplayOffsetY);
                    }
                    if (!(this.mInputMethodAnimLayerAdjustment == 0 && this.mWallpaperAnimLayerAdjustment == 0)) {
                        pw.print("  mInputMethodAnimLayerAdjustment=");
                        pw.print(this.mInputMethodAnimLayerAdjustment);
                        pw.print("  mWallpaperAnimLayerAdjustment=");
                        pw.println(this.mWallpaperAnimLayerAdjustment);
                    }
                    pw.print("  mSystemBooted=");
                    pw.print(this.mSystemBooted);
                    pw.print(" mDisplayEnabled=");
                    pw.println(this.mDisplayEnabled);
                    if (needsLayout()) {
                        pw.print("  layoutNeeded on displays=");
                        for (displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                            DisplayContent displayContent = (DisplayContent) this.mDisplayContents.valueAt(displayNdx);
                            if (displayContent.layoutNeeded) {
                                pw.print(displayContent.getDisplayId());
                            }
                        }
                        pw.println();
                    }
                    pw.print("  mTransactionSequence=");
                    pw.println(this.mTransactionSequence);
                    pw.print("  mDisplayFrozen=");
                    pw.print(this.mDisplayFrozen);
                    pw.print(" windows=");
                    pw.print(this.mWindowsFreezingScreen);
                    pw.print(" client=");
                    pw.print(this.mClientFreezingScreen);
                    pw.print(" apps=");
                    pw.print(this.mAppsFreezingScreen);
                    pw.print(" waitingForConfig=");
                    pw.println(this.mWaitingForConfig);
                    pw.print("  mRotation=");
                    pw.print(this.mRotation);
                    pw.print(" mAltOrientation=");
                    pw.println(this.mAltOrientation);
                    pw.print("  mLastWindowForcedOrientation=");
                    pw.print(this.mLastWindowForcedOrientation);
                    pw.print(" mForcedAppOrientation=");
                    pw.println(this.mForcedAppOrientation);
                    pw.print("  mDeferredRotationPauseCount=");
                    pw.println(this.mDeferredRotationPauseCount);
                    pw.print("  Animation settings: disabled=");
                    pw.print(this.mAnimationsDisabled);
                    pw.print(" window=");
                    pw.print(this.mWindowAnimationScaleSetting);
                    pw.print(" transition=");
                    pw.print(this.mTransitionAnimationScaleSetting);
                    pw.print(" animator=");
                    pw.println(this.mAnimatorDurationScaleSetting);
                    pw.print("  mTraversalScheduled=");
                    pw.println(this.mTraversalScheduled);
                    pw.print("  mStartingIconInTransition=");
                    pw.print(this.mStartingIconInTransition);
                    pw.print(" mSkipAppTransitionAnimation=");
                    pw.println(this.mSkipAppTransitionAnimation);
                    pw.println("  mLayoutToAnim:");
                    this.mAppTransition.dump(pw);
                }
            }

            boolean dumpWindows(PrintWriter pw, String name, String[] args, int opti, boolean dumpAll) {
                WindowList windows = new WindowList();
                int numDisplays;
                int displayNdx;
                WindowList windowList;
                int winNdx;
                WindowState w;
                if ("visible".equals(name)) {
                    synchronized (this.mWindowMap) {
                        numDisplays = this.mDisplayContents.size();
                        for (displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                            windowList = ((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).getWindowList();
                            for (winNdx = windowList.size() - 1; winNdx >= 0; winNdx--) {
                                w = (WindowState) windowList.get(winNdx);
                                if (w.mWinAnimator.mSurfaceShown) {
                                    windows.add(w);
                                }
                            }
                        }
                    }
                } else {
                    int objectId = WALLPAPER_DRAW_NORMAL;
                    try {
                        objectId = Integer.parseInt(name, 16);
                        name = null;
                    } catch (RuntimeException e) {
                    }
                    synchronized (this.mWindowMap) {
                        numDisplays = this.mDisplayContents.size();
                        for (displayNdx = WALLPAPER_DRAW_NORMAL; displayNdx < numDisplays; displayNdx += WALLPAPER_DRAW_PENDING) {
                            windowList = ((DisplayContent) this.mDisplayContents.valueAt(displayNdx)).getWindowList();
                            for (winNdx = windowList.size() - 1; winNdx >= 0; winNdx--) {
                                w = (WindowState) windowList.get(winNdx);
                                if (name != null) {
                                    if (w.mAttrs.getTitle().toString().contains(name)) {
                                        windows.add(w);
                                    }
                                } else if (System.identityHashCode(w) == objectId) {
                                    windows.add(w);
                                }
                            }
                        }
                    }
                }
                if (windows.size() <= 0) {
                    return SHOW_TRANSACTIONS;
                }
                synchronized (this.mWindowMap) {
                    dumpWindowsLocked(pw, dumpAll, windows);
                }
                return HIDE_STACK_CRAWLS;
            }

            void dumpLastANRLocked(PrintWriter pw) {
                pw.println("WINDOW MANAGER LAST ANR (dumpsys window lastanr)");
                if (this.mLastANRState == null) {
                    pw.println("  <no ANR has occurred since boot>");
                } else {
                    pw.println(this.mLastANRState);
                }
            }

            public void saveANRStateLocked(AppWindowToken appWindowToken, WindowState windowState, String reason) {
                StringWriter sw = new StringWriter();
                PrintWriter pw = new FastPrintWriter(sw, SHOW_TRANSACTIONS, DumpState.DUMP_PREFERRED_XML);
                pw.println("  ANR time: " + DateFormat.getInstance().format(new Date()));
                if (appWindowToken != null) {
                    pw.println("  Application at fault: " + appWindowToken.stringName);
                }
                if (windowState != null) {
                    pw.println("  Window at fault: " + windowState.mAttrs.getTitle());
                }
                if (reason != null) {
                    pw.println("  Reason: " + reason);
                }
                pw.println();
                dumpWindowsNoHeaderLocked(pw, HIDE_STACK_CRAWLS, null);
                pw.println();
                pw.println("Last ANR continued");
                dumpDisplayContentsLocked(pw, HIDE_STACK_CRAWLS);
                pw.close();
                this.mLastANRState = sw.toString();
                this.mH.removeMessages(38);
                this.mH.sendEmptyMessageDelayed(38, 7200000);
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public void dump(java.io.FileDescriptor r8, java.io.PrintWriter r9, java.lang.String[] r10) {
                /*
                r7 = this;
                r0 = 0;
                r1 = r7.mContext;
                r3 = "android.permission.DUMP";
                r1 = r1.checkCallingOrSelfPermission(r3);
                if (r1 == 0) goto L_0x0034;
            L_0x000b:
                r0 = new java.lang.StringBuilder;
                r0.<init>();
                r1 = "Permission Denial: can't dump WindowManager from from pid=";
                r0 = r0.append(r1);
                r1 = android.os.Binder.getCallingPid();
                r0 = r0.append(r1);
                r1 = ", uid=";
                r0 = r0.append(r1);
                r1 = android.os.Binder.getCallingUid();
                r0 = r0.append(r1);
                r0 = r0.toString();
                r9.println(r0);
            L_0x0033:
                return;
            L_0x0034:
                r5 = 0;
                r4 = 0;
            L_0x0036:
                r1 = r10.length;
                if (r4 >= r1) goto L_0x004c;
            L_0x0039:
                r6 = r10[r4];
                if (r6 == 0) goto L_0x004c;
            L_0x003d:
                r1 = r6.length();
                if (r1 <= 0) goto L_0x004c;
            L_0x0043:
                r1 = 0;
                r1 = r6.charAt(r1);
                r3 = 45;
                if (r1 == r3) goto L_0x006e;
            L_0x004c:
                r1 = r10.length;
                if (r4 >= r1) goto L_0x01ff;
            L_0x004f:
                r2 = r10[r4];
                r4 = r4 + 1;
                r0 = "lastanr";
                r0 = r0.equals(r2);
                if (r0 != 0) goto L_0x0063;
            L_0x005b:
                r0 = "l";
                r0 = r0.equals(r2);
                if (r0 == 0) goto L_0x00f7;
            L_0x0063:
                r1 = r7.mWindowMap;
                monitor-enter(r1);
                r7.dumpLastANRLocked(r9);	 Catch:{ all -> 0x006b }
                monitor-exit(r1);	 Catch:{ all -> 0x006b }
                goto L_0x0033;
            L_0x006b:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x006b }
                throw r0;
            L_0x006e:
                r4 = r4 + 1;
                r1 = "-a";
                r1 = r1.equals(r6);
                if (r1 == 0) goto L_0x007a;
            L_0x0078:
                r5 = 1;
                goto L_0x0036;
            L_0x007a:
                r1 = "-h";
                r1 = r1.equals(r6);
                if (r1 == 0) goto L_0x00d9;
            L_0x0082:
                r0 = "Window manager dump options:";
                r9.println(r0);
                r0 = "  [-a] [-h] [cmd] ...";
                r9.println(r0);
                r0 = "  cmd may be one of:";
                r9.println(r0);
                r0 = "    l[astanr]: last ANR information";
                r9.println(r0);
                r0 = "    p[policy]: policy state";
                r9.println(r0);
                r0 = "    a[animator]: animator state";
                r9.println(r0);
                r0 = "    s[essions]: active sessions";
                r9.println(r0);
                r0 = "    surfaces: active surfaces (debugging enabled only)";
                r9.println(r0);
                r0 = "    d[isplays]: active display contents";
                r9.println(r0);
                r0 = "    t[okens]: token list";
                r9.println(r0);
                r0 = "    w[indows]: window list";
                r9.println(r0);
                r0 = "  cmd may also be a NAME to dump windows.  NAME may";
                r9.println(r0);
                r0 = "    be a partial substring in a window name, a";
                r9.println(r0);
                r0 = "    Window hex object identifier, or";
                r9.println(r0);
                r0 = "    \"all\" for all windows, or";
                r9.println(r0);
                r0 = "    \"visible\" for the visible windows.";
                r9.println(r0);
                r0 = "  -a: include all available server state.";
                r9.println(r0);
                goto L_0x0033;
            L_0x00d9:
                r1 = new java.lang.StringBuilder;
                r1.<init>();
                r3 = "Unknown argument: ";
                r1 = r1.append(r3);
                r1 = r1.append(r6);
                r3 = "; use -h for help";
                r1 = r1.append(r3);
                r1 = r1.toString();
                r9.println(r1);
                goto L_0x0036;
            L_0x00f7:
                r0 = "policy";
                r0 = r0.equals(r2);
                if (r0 != 0) goto L_0x0107;
            L_0x00ff:
                r0 = "p";
                r0 = r0.equals(r2);
                if (r0 == 0) goto L_0x0114;
            L_0x0107:
                r1 = r7.mWindowMap;
                monitor-enter(r1);
                r0 = 1;
                r7.dumpPolicyLocked(r9, r10, r0);	 Catch:{ all -> 0x0111 }
                monitor-exit(r1);	 Catch:{ all -> 0x0111 }
                goto L_0x0033;
            L_0x0111:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x0111 }
                throw r0;
            L_0x0114:
                r0 = "animator";
                r0 = r0.equals(r2);
                if (r0 != 0) goto L_0x0124;
            L_0x011c:
                r0 = "a";
                r0 = r0.equals(r2);
                if (r0 == 0) goto L_0x0131;
            L_0x0124:
                r1 = r7.mWindowMap;
                monitor-enter(r1);
                r0 = 1;
                r7.dumpAnimatorLocked(r9, r10, r0);	 Catch:{ all -> 0x012e }
                monitor-exit(r1);	 Catch:{ all -> 0x012e }
                goto L_0x0033;
            L_0x012e:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x012e }
                throw r0;
            L_0x0131:
                r0 = "sessions";
                r0 = r0.equals(r2);
                if (r0 != 0) goto L_0x0141;
            L_0x0139:
                r0 = "s";
                r0 = r0.equals(r2);
                if (r0 == 0) goto L_0x014e;
            L_0x0141:
                r1 = r7.mWindowMap;
                monitor-enter(r1);
                r0 = 1;
                r7.dumpSessionsLocked(r9, r0);	 Catch:{ all -> 0x014b }
                monitor-exit(r1);	 Catch:{ all -> 0x014b }
                goto L_0x0033;
            L_0x014b:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x014b }
                throw r0;
            L_0x014e:
                r0 = "surfaces";
                r0 = r0.equals(r2);
                if (r0 == 0) goto L_0x0163;
            L_0x0156:
                r1 = r7.mWindowMap;
                monitor-enter(r1);
                r0 = 0;
                com.android.server.wm.WindowStateAnimator.SurfaceTrace.dumpAllSurfaces(r9, r0);	 Catch:{ all -> 0x0160 }
                monitor-exit(r1);	 Catch:{ all -> 0x0160 }
                goto L_0x0033;
            L_0x0160:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x0160 }
                throw r0;
            L_0x0163:
                r0 = "displays";
                r0 = r0.equals(r2);
                if (r0 != 0) goto L_0x0173;
            L_0x016b:
                r0 = "d";
                r0 = r0.equals(r2);
                if (r0 == 0) goto L_0x0180;
            L_0x0173:
                r1 = r7.mWindowMap;
                monitor-enter(r1);
                r0 = 1;
                r7.dumpDisplayContentsLocked(r9, r0);	 Catch:{ all -> 0x017d }
                monitor-exit(r1);	 Catch:{ all -> 0x017d }
                goto L_0x0033;
            L_0x017d:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x017d }
                throw r0;
            L_0x0180:
                r0 = "tokens";
                r0 = r0.equals(r2);
                if (r0 != 0) goto L_0x0190;
            L_0x0188:
                r0 = "t";
                r0 = r0.equals(r2);
                if (r0 == 0) goto L_0x019d;
            L_0x0190:
                r1 = r7.mWindowMap;
                monitor-enter(r1);
                r0 = 1;
                r7.dumpTokensLocked(r9, r0);	 Catch:{ all -> 0x019a }
                monitor-exit(r1);	 Catch:{ all -> 0x019a }
                goto L_0x0033;
            L_0x019a:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x019a }
                throw r0;
            L_0x019d:
                r0 = "windows";
                r0 = r0.equals(r2);
                if (r0 != 0) goto L_0x01ad;
            L_0x01a5:
                r0 = "w";
                r0 = r0.equals(r2);
                if (r0 == 0) goto L_0x01bb;
            L_0x01ad:
                r1 = r7.mWindowMap;
                monitor-enter(r1);
                r0 = 1;
                r3 = 0;
                r7.dumpWindowsLocked(r9, r0, r3);	 Catch:{ all -> 0x01b8 }
                monitor-exit(r1);	 Catch:{ all -> 0x01b8 }
                goto L_0x0033;
            L_0x01b8:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x01b8 }
                throw r0;
            L_0x01bb:
                r0 = "all";
                r0 = r0.equals(r2);
                if (r0 != 0) goto L_0x01cb;
            L_0x01c3:
                r0 = "a";
                r0 = r0.equals(r2);
                if (r0 == 0) goto L_0x01d9;
            L_0x01cb:
                r1 = r7.mWindowMap;
                monitor-enter(r1);
                r0 = 1;
                r3 = 0;
                r7.dumpWindowsLocked(r9, r0, r3);	 Catch:{ all -> 0x01d6 }
                monitor-exit(r1);	 Catch:{ all -> 0x01d6 }
                goto L_0x0033;
            L_0x01d6:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x01d6 }
                throw r0;
            L_0x01d9:
                r0 = r7;
                r1 = r9;
                r3 = r10;
                r0 = r0.dumpWindows(r1, r2, r3, r4, r5);
                if (r0 != 0) goto L_0x0033;
            L_0x01e2:
                r0 = new java.lang.StringBuilder;
                r0.<init>();
                r1 = "Bad window command, or no windows match: ";
                r0 = r0.append(r1);
                r0 = r0.append(r2);
                r0 = r0.toString();
                r9.println(r0);
                r0 = "Use -h for help.";
                r9.println(r0);
                goto L_0x0033;
            L_0x01ff:
                r1 = r7.mWindowMap;
                monitor-enter(r1);
                r9.println();	 Catch:{ all -> 0x0272 }
                if (r5 == 0) goto L_0x020c;
            L_0x0207:
                r3 = "-------------------------------------------------------------------------------";
                r9.println(r3);	 Catch:{ all -> 0x0272 }
            L_0x020c:
                r7.dumpLastANRLocked(r9);	 Catch:{ all -> 0x0272 }
                r9.println();	 Catch:{ all -> 0x0272 }
                if (r5 == 0) goto L_0x0219;
            L_0x0214:
                r3 = "-------------------------------------------------------------------------------";
                r9.println(r3);	 Catch:{ all -> 0x0272 }
            L_0x0219:
                r7.dumpPolicyLocked(r9, r10, r5);	 Catch:{ all -> 0x0272 }
                r9.println();	 Catch:{ all -> 0x0272 }
                if (r5 == 0) goto L_0x0226;
            L_0x0221:
                r3 = "-------------------------------------------------------------------------------";
                r9.println(r3);	 Catch:{ all -> 0x0272 }
            L_0x0226:
                r7.dumpAnimatorLocked(r9, r10, r5);	 Catch:{ all -> 0x0272 }
                r9.println();	 Catch:{ all -> 0x0272 }
                if (r5 == 0) goto L_0x0233;
            L_0x022e:
                r3 = "-------------------------------------------------------------------------------";
                r9.println(r3);	 Catch:{ all -> 0x0272 }
            L_0x0233:
                r7.dumpSessionsLocked(r9, r5);	 Catch:{ all -> 0x0272 }
                r9.println();	 Catch:{ all -> 0x0272 }
                if (r5 == 0) goto L_0x0240;
            L_0x023b:
                r3 = "-------------------------------------------------------------------------------";
                r9.println(r3);	 Catch:{ all -> 0x0272 }
            L_0x0240:
                if (r5 == 0) goto L_0x0244;
            L_0x0242:
                r0 = "-------------------------------------------------------------------------------";
            L_0x0244:
                com.android.server.wm.WindowStateAnimator.SurfaceTrace.dumpAllSurfaces(r9, r0);	 Catch:{ all -> 0x0272 }
                r9.println();	 Catch:{ all -> 0x0272 }
                if (r5 == 0) goto L_0x0251;
            L_0x024c:
                r0 = "-------------------------------------------------------------------------------";
                r9.println(r0);	 Catch:{ all -> 0x0272 }
            L_0x0251:
                r7.dumpDisplayContentsLocked(r9, r5);	 Catch:{ all -> 0x0272 }
                r9.println();	 Catch:{ all -> 0x0272 }
                if (r5 == 0) goto L_0x025e;
            L_0x0259:
                r0 = "-------------------------------------------------------------------------------";
                r9.println(r0);	 Catch:{ all -> 0x0272 }
            L_0x025e:
                r7.dumpTokensLocked(r9, r5);	 Catch:{ all -> 0x0272 }
                r9.println();	 Catch:{ all -> 0x0272 }
                if (r5 == 0) goto L_0x026b;
            L_0x0266:
                r0 = "-------------------------------------------------------------------------------";
                r9.println(r0);	 Catch:{ all -> 0x0272 }
            L_0x026b:
                r0 = 0;
                r7.dumpWindowsLocked(r9, r5, r0);	 Catch:{ all -> 0x0272 }
                monitor-exit(r1);	 Catch:{ all -> 0x0272 }
                goto L_0x0033;
            L_0x0272:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x0272 }
                throw r0;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.WindowManagerService.dump(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String[]):void");
            }

            public void monitor() {
                synchronized (this.mWindowMap) {
                }
            }

            void debugLayoutRepeats(String msg, int pendingLayoutChanges) {
                if (this.mLayoutRepeatCount >= LAYOUT_REPEAT_THRESHOLD) {
                    Slog.v(TAG, "Layouts looping: " + msg + ", mPendingLayoutChanges = 0x" + Integer.toHexString(pendingLayoutChanges));
                }
            }

            private DisplayContent newDisplayContentLocked(Display display) {
                DisplayContent displayContent = new DisplayContent(display, this);
                int displayId = display.getDisplayId();
                this.mDisplayContents.put(displayId, displayContent);
                DisplayInfo displayInfo = displayContent.getDisplayInfo();
                Rect rect = new Rect();
                this.mDisplaySettings.getOverscanLocked(displayInfo.name, displayInfo.uniqueId, rect);
                synchronized (displayContent.mDisplaySizeLock) {
                    displayInfo.overscanLeft = rect.left;
                    displayInfo.overscanTop = rect.top;
                    displayInfo.overscanRight = rect.right;
                    displayInfo.overscanBottom = rect.bottom;
                    this.mDisplayManagerInternal.setDisplayInfoOverrideFromWindowManager(displayId, displayInfo);
                }
                configureDisplayPolicyLocked(displayContent);
                if (displayId == 0) {
                    displayContent.mTapDetector = new StackTapPointerEventListener(this, displayContent);
                    registerPointerEventListener(displayContent.mTapDetector);
                }
                return displayContent;
            }

            public void createDisplayContentLocked(Display display) {
                if (display == null) {
                    throw new IllegalArgumentException("getDisplayContent: display must not be null");
                }
                getDisplayContentLocked(display.getDisplayId());
            }

            public DisplayContent getDisplayContentLocked(int displayId) {
                DisplayContent displayContent = (DisplayContent) this.mDisplayContents.get(displayId);
                if (displayContent != null) {
                    return displayContent;
                }
                Display display = this.mDisplayManager.getDisplay(displayId);
                if (display != null) {
                    return newDisplayContentLocked(display);
                }
                return displayContent;
            }

            public DisplayContent getDefaultDisplayContentLocked() {
                return getDisplayContentLocked(WALLPAPER_DRAW_NORMAL);
            }

            public WindowList getDefaultWindowListLocked() {
                return getDefaultDisplayContentLocked().getWindowList();
            }

            public DisplayInfo getDefaultDisplayInfoLocked() {
                return getDefaultDisplayContentLocked().getDisplayInfo();
            }

            public WindowList getWindowListLocked(Display display) {
                return getWindowListLocked(display.getDisplayId());
            }

            public WindowList getWindowListLocked(int displayId) {
                DisplayContent displayContent = getDisplayContentLocked(displayId);
                return displayContent != null ? displayContent.getWindowList() : null;
            }

            public void onDisplayAdded(int displayId) {
                this.mH.sendMessage(this.mH.obtainMessage(27, displayId, WALLPAPER_DRAW_NORMAL));
            }

            public void handleDisplayAdded(int displayId) {
                synchronized (this.mWindowMap) {
                    Display display = this.mDisplayManager.getDisplay(displayId);
                    if (display != null) {
                        createDisplayContentLocked(display);
                        displayReady(displayId);
                    }
                    requestTraversalLocked();
                }
            }

            public void onDisplayRemoved(int displayId) {
                this.mH.sendMessage(this.mH.obtainMessage(28, displayId, WALLPAPER_DRAW_NORMAL));
            }

            private void handleDisplayRemovedLocked(int displayId) {
                DisplayContent displayContent = getDisplayContentLocked(displayId);
                if (displayContent != null) {
                    if (displayContent.isAnimating()) {
                        displayContent.mDeferredRemoval = HIDE_STACK_CRAWLS;
                        return;
                    }
                    this.mDisplayContents.delete(displayId);
                    displayContent.close();
                    if (displayId == 0) {
                        unregisterPointerEventListener(displayContent.mTapDetector);
                    }
                }
                this.mAnimator.removeDisplayLocked(displayId);
                requestTraversalLocked();
            }

            public void onDisplayChanged(int displayId) {
                this.mH.sendMessage(this.mH.obtainMessage(29, displayId, WALLPAPER_DRAW_NORMAL));
            }

            private void handleDisplayChangedLocked(int displayId) {
                DisplayContent displayContent = getDisplayContentLocked(displayId);
                if (displayContent != null) {
                    displayContent.updateDisplayInfo();
                }
                requestTraversalLocked();
            }

            public Object getWindowManagerLock() {
                return this.mWindowMap;
            }
        }
