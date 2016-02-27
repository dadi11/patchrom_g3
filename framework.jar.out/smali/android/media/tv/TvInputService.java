package android.media.tv;

import android.annotation.SuppressLint;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.graphics.Rect;
import android.hardware.hdmi.HdmiDeviceInfo;
import android.media.tv.ITvInputService.Stub;
import android.media.tv.TvInputManager.SessionCallback;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.Process;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.text.TextUtils;
import android.util.Log;
import android.view.InputChannel;
import android.view.InputEvent;
import android.view.InputEventReceiver;
import android.view.KeyEvent;
import android.view.KeyEvent.Callback;
import android.view.KeyEvent.DispatcherState;
import android.view.MotionEvent;
import android.view.Surface;
import android.view.View;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import com.android.internal.os.SomeArgs;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public abstract class TvInputService extends Service {
    private static final boolean DEBUG = false;
    public static final String SERVICE_INTERFACE = "android.media.tv.TvInputService";
    public static final String SERVICE_META_DATA = "android.media.tv.input";
    private static final String TAG = "TvInputService";
    private final RemoteCallbackList<ITvInputServiceCallback> mCallbacks;
    private final Handler mServiceHandler;
    private TvInputManager mTvInputManager;

    /* renamed from: android.media.tv.TvInputService.1 */
    class C04551 extends Stub {
        C04551() {
        }

        public void registerCallback(ITvInputServiceCallback cb) {
            if (cb != null) {
                TvInputService.this.mCallbacks.register(cb);
            }
        }

        public void unregisterCallback(ITvInputServiceCallback cb) {
            if (cb != null) {
                TvInputService.this.mCallbacks.unregister(cb);
            }
        }

        public void createSession(InputChannel channel, ITvInputSessionCallback cb, String inputId) {
            if (channel == null) {
                Log.w(TvInputService.TAG, "Creating session without input channel");
            }
            if (cb != null) {
                SomeArgs args = SomeArgs.obtain();
                args.arg1 = channel;
                args.arg2 = cb;
                args.arg3 = inputId;
                TvInputService.this.mServiceHandler.obtainMessage(1, args).sendToTarget();
            }
        }

        public void notifyHardwareAdded(TvInputHardwareInfo hardwareInfo) {
            TvInputService.this.mServiceHandler.obtainMessage(3, hardwareInfo).sendToTarget();
        }

        public void notifyHardwareRemoved(TvInputHardwareInfo hardwareInfo) {
            TvInputService.this.mServiceHandler.obtainMessage(4, hardwareInfo).sendToTarget();
        }

        public void notifyHdmiDeviceAdded(HdmiDeviceInfo deviceInfo) {
            TvInputService.this.mServiceHandler.obtainMessage(5, deviceInfo).sendToTarget();
        }

        public void notifyHdmiDeviceRemoved(HdmiDeviceInfo deviceInfo) {
            TvInputService.this.mServiceHandler.obtainMessage(6, deviceInfo).sendToTarget();
        }
    }

    public static abstract class Session implements Callback {
        private static final int DETACH_OVERLAY_VIEW_TIMEOUT = 5000;
        private Context mContext;
        private final DispatcherState mDispatcherState;
        final Handler mHandler;
        private Object mLock;
        private Rect mOverlayFrame;
        private View mOverlayView;
        private OverlayViewCleanUpTask mOverlayViewCleanUpTask;
        private FrameLayout mOverlayViewContainer;
        private boolean mOverlayViewEnabled;
        private List<Runnable> mPendingActions;
        private ITvInputSessionCallback mSessionCallback;
        private Surface mSurface;
        private final WindowManager mWindowManager;
        private LayoutParams mWindowParams;
        private IBinder mWindowToken;

        /* renamed from: android.media.tv.TvInputService.Session.10 */
        class AnonymousClass10 implements Runnable {
            final /* synthetic */ int val$bottom;
            final /* synthetic */ int val$left;
            final /* synthetic */ int val$right;
            final /* synthetic */ int val$top;

            AnonymousClass10(int i, int i2, int i3, int i4) {
                this.val$left = i;
                this.val$top = i2;
                this.val$right = i3;
                this.val$bottom = i4;
            }

            public void run() {
                try {
                    if (Session.this.mSessionCallback != null) {
                        Session.this.mSessionCallback.onLayoutSurface(this.val$left, this.val$top, this.val$right, this.val$bottom);
                    }
                } catch (RemoteException e) {
                    Log.w(TvInputService.TAG, "error in layoutSurface");
                }
            }
        }

        /* renamed from: android.media.tv.TvInputService.Session.1 */
        class C04571 implements Runnable {
            final /* synthetic */ boolean val$enable;

            C04571(boolean z) {
                this.val$enable = z;
            }

            public void run() {
                if (this.val$enable != Session.this.mOverlayViewEnabled) {
                    Session.this.mOverlayViewEnabled = this.val$enable;
                    if (!this.val$enable) {
                        Session.this.removeOverlayView(TvInputService.DEBUG);
                    } else if (Session.this.mWindowToken != null) {
                        Session.this.createOverlayView(Session.this.mWindowToken, Session.this.mOverlayFrame);
                    }
                }
            }
        }

        /* renamed from: android.media.tv.TvInputService.Session.2 */
        class C04582 implements Runnable {
            final /* synthetic */ Bundle val$eventArgs;
            final /* synthetic */ String val$eventType;

            C04582(String str, Bundle bundle) {
                this.val$eventType = str;
                this.val$eventArgs = bundle;
            }

            public void run() {
                try {
                    if (Session.this.mSessionCallback != null) {
                        Session.this.mSessionCallback.onSessionEvent(this.val$eventType, this.val$eventArgs);
                    }
                } catch (RemoteException e) {
                    Log.w(TvInputService.TAG, "error in sending event (event=" + this.val$eventType + ")");
                }
            }
        }

        /* renamed from: android.media.tv.TvInputService.Session.3 */
        class C04593 implements Runnable {
            final /* synthetic */ Uri val$channelUri;

            C04593(Uri uri) {
                this.val$channelUri = uri;
            }

            public void run() {
                try {
                    if (Session.this.mSessionCallback != null) {
                        Session.this.mSessionCallback.onChannelRetuned(this.val$channelUri);
                    }
                } catch (RemoteException e) {
                    Log.w(TvInputService.TAG, "error in notifyChannelRetuned");
                }
            }
        }

        /* renamed from: android.media.tv.TvInputService.Session.4 */
        class C04604 implements Runnable {
            final /* synthetic */ List val$tracks;

            C04604(List list) {
                this.val$tracks = list;
            }

            public void run() {
                try {
                    if (Session.this.mSessionCallback != null) {
                        Session.this.mSessionCallback.onTracksChanged(this.val$tracks);
                    }
                } catch (RemoteException e) {
                    Log.w(TvInputService.TAG, "error in notifyTracksChanged");
                }
            }
        }

        /* renamed from: android.media.tv.TvInputService.Session.5 */
        class C04615 implements Runnable {
            final /* synthetic */ String val$trackId;
            final /* synthetic */ int val$type;

            C04615(int i, String str) {
                this.val$type = i;
                this.val$trackId = str;
            }

            public void run() {
                try {
                    if (Session.this.mSessionCallback != null) {
                        Session.this.mSessionCallback.onTrackSelected(this.val$type, this.val$trackId);
                    }
                } catch (RemoteException e) {
                    Log.w(TvInputService.TAG, "error in notifyTrackSelected");
                }
            }
        }

        /* renamed from: android.media.tv.TvInputService.Session.6 */
        class C04626 implements Runnable {
            C04626() {
            }

            public void run() {
                try {
                    if (Session.this.mSessionCallback != null) {
                        Session.this.mSessionCallback.onVideoAvailable();
                    }
                } catch (RemoteException e) {
                    Log.w(TvInputService.TAG, "error in notifyVideoAvailable");
                }
            }
        }

        /* renamed from: android.media.tv.TvInputService.Session.7 */
        class C04637 implements Runnable {
            final /* synthetic */ int val$reason;

            C04637(int i) {
                this.val$reason = i;
            }

            public void run() {
                try {
                    if (Session.this.mSessionCallback != null) {
                        Session.this.mSessionCallback.onVideoUnavailable(this.val$reason);
                    }
                } catch (RemoteException e) {
                    Log.w(TvInputService.TAG, "error in notifyVideoUnavailable");
                }
            }
        }

        /* renamed from: android.media.tv.TvInputService.Session.8 */
        class C04648 implements Runnable {
            C04648() {
            }

            public void run() {
                try {
                    if (Session.this.mSessionCallback != null) {
                        Session.this.mSessionCallback.onContentAllowed();
                    }
                } catch (RemoteException e) {
                    Log.w(TvInputService.TAG, "error in notifyContentAllowed");
                }
            }
        }

        /* renamed from: android.media.tv.TvInputService.Session.9 */
        class C04659 implements Runnable {
            final /* synthetic */ TvContentRating val$rating;

            C04659(TvContentRating tvContentRating) {
                this.val$rating = tvContentRating;
            }

            public void run() {
                try {
                    if (Session.this.mSessionCallback != null) {
                        Session.this.mSessionCallback.onContentBlocked(this.val$rating.flattenToString());
                    }
                } catch (RemoteException e) {
                    Log.w(TvInputService.TAG, "error in notifyContentBlocked");
                }
            }
        }

        private final class OverlayViewCleanUpTask extends AsyncTask<View, Void, Void> {
            private OverlayViewCleanUpTask() {
            }

            protected Void doInBackground(View... views) {
                View overlayViewParent = views[0];
                try {
                    Thread.sleep(5000);
                    if (!isCancelled() && overlayViewParent.isAttachedToWindow()) {
                        Log.e(TvInputService.TAG, "Time out on releasing overlay view. Killing " + overlayViewParent.getContext().getPackageName());
                        Process.killProcess(Process.myPid());
                    }
                } catch (InterruptedException e) {
                }
                return null;
            }
        }

        public abstract void onRelease();

        public abstract void onSetCaptionEnabled(boolean z);

        public abstract void onSetStreamVolume(float f);

        public abstract boolean onSetSurface(Surface surface);

        public abstract boolean onTune(Uri uri);

        public Session(Context context) {
            this.mDispatcherState = new DispatcherState();
            this.mLock = new Object();
            this.mPendingActions = new ArrayList();
            this.mContext = context;
            this.mWindowManager = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
            this.mHandler = new Handler(context.getMainLooper());
        }

        public void setOverlayViewEnabled(boolean enable) {
            this.mHandler.post(new C04571(enable));
        }

        public void notifySessionEvent(String eventType, Bundle eventArgs) {
            if (eventType == null) {
                throw new IllegalArgumentException("eventType should not be null.");
            }
            executeOrPostRunnable(new C04582(eventType, eventArgs));
        }

        public void notifyChannelRetuned(Uri channelUri) {
            executeOrPostRunnable(new C04593(channelUri));
        }

        public void notifyTracksChanged(List<TvTrackInfo> tracks) {
            Set<String> trackIdSet = new HashSet();
            for (TvTrackInfo track : tracks) {
                String trackId = track.getId();
                if (trackIdSet.contains(trackId)) {
                    throw new IllegalArgumentException("redundant track ID: " + trackId);
                }
                trackIdSet.add(trackId);
            }
            trackIdSet.clear();
            executeOrPostRunnable(new C04604(tracks));
        }

        public void notifyTrackSelected(int type, String trackId) {
            executeOrPostRunnable(new C04615(type, trackId));
        }

        public void notifyVideoAvailable() {
            executeOrPostRunnable(new C04626());
        }

        public void notifyVideoUnavailable(int reason) {
            if (reason < 0 || reason > 3) {
                throw new IllegalArgumentException("Unknown reason: " + reason);
            }
            executeOrPostRunnable(new C04637(reason));
        }

        public void notifyContentAllowed() {
            executeOrPostRunnable(new C04648());
        }

        public void notifyContentBlocked(TvContentRating rating) {
            executeOrPostRunnable(new C04659(rating));
        }

        public void layoutSurface(int left, int top, int right, int bottom) {
            if (left > right || top > bottom) {
                throw new IllegalArgumentException("Invalid parameter");
            }
            executeOrPostRunnable(new AnonymousClass10(left, top, right, bottom));
        }

        public void onSetMain(boolean isMain) {
        }

        public void onSurfaceChanged(int format, int width, int height) {
        }

        public void onOverlayViewSizeChanged(int width, int height) {
        }

        public boolean onTune(Uri channelUri, Bundle params) {
            return onTune(channelUri);
        }

        public void onUnblockContent(TvContentRating unblockedRating) {
        }

        public boolean onSelectTrack(int type, String trackId) {
            return TvInputService.DEBUG;
        }

        public void onAppPrivateCommand(String action, Bundle data) {
        }

        public View onCreateOverlayView() {
            return null;
        }

        public boolean onKeyDown(int keyCode, KeyEvent event) {
            return TvInputService.DEBUG;
        }

        public boolean onKeyLongPress(int keyCode, KeyEvent event) {
            return TvInputService.DEBUG;
        }

        public boolean onKeyMultiple(int keyCode, int count, KeyEvent event) {
            return TvInputService.DEBUG;
        }

        public boolean onKeyUp(int keyCode, KeyEvent event) {
            return TvInputService.DEBUG;
        }

        public boolean onTouchEvent(MotionEvent event) {
            return TvInputService.DEBUG;
        }

        public boolean onTrackballEvent(MotionEvent event) {
            return TvInputService.DEBUG;
        }

        public boolean onGenericMotionEvent(MotionEvent event) {
            return TvInputService.DEBUG;
        }

        void release() {
            onRelease();
            if (this.mSurface != null) {
                this.mSurface.release();
                this.mSurface = null;
            }
            synchronized (this.mLock) {
                this.mSessionCallback = null;
                this.mPendingActions.clear();
            }
            removeOverlayView(true);
        }

        void setMain(boolean isMain) {
            onSetMain(isMain);
        }

        void setSurface(Surface surface) {
            onSetSurface(surface);
            if (this.mSurface != null) {
                this.mSurface.release();
            }
            this.mSurface = surface;
        }

        void dispatchSurfaceChanged(int format, int width, int height) {
            onSurfaceChanged(format, width, height);
        }

        void setStreamVolume(float volume) {
            onSetStreamVolume(volume);
        }

        void tune(Uri channelUri, Bundle params) {
            onTune(channelUri, params);
        }

        void setCaptionEnabled(boolean enabled) {
            onSetCaptionEnabled(enabled);
        }

        void selectTrack(int type, String trackId) {
            onSelectTrack(type, trackId);
        }

        void unblockContent(String unblockedRating) {
            onUnblockContent(TvContentRating.unflattenFromString(unblockedRating));
        }

        void appPrivateCommand(String action, Bundle data) {
            onAppPrivateCommand(action, data);
        }

        void createOverlayView(IBinder windowToken, Rect frame) {
            if (this.mOverlayViewContainer != null) {
                removeOverlayView(TvInputService.DEBUG);
            }
            this.mWindowToken = windowToken;
            this.mOverlayFrame = frame;
            onOverlayViewSizeChanged(frame.right - frame.left, frame.bottom - frame.top);
            if (this.mOverlayViewEnabled) {
                this.mOverlayView = onCreateOverlayView();
                if (this.mOverlayView != null) {
                    if (this.mOverlayViewCleanUpTask != null) {
                        this.mOverlayViewCleanUpTask.cancel(true);
                        this.mOverlayViewCleanUpTask = null;
                    }
                    this.mOverlayViewContainer = new FrameLayout(this.mContext);
                    this.mOverlayViewContainer.addView(this.mOverlayView);
                    this.mWindowParams = new LayoutParams(frame.right - frame.left, frame.bottom - frame.top, frame.left, frame.top, LayoutParams.TYPE_APPLICATION_MEDIA_OVERLAY, 536, -2);
                    LayoutParams layoutParams = this.mWindowParams;
                    layoutParams.privateFlags |= 64;
                    this.mWindowParams.gravity = 8388659;
                    this.mWindowParams.token = windowToken;
                    this.mWindowManager.addView(this.mOverlayViewContainer, this.mWindowParams);
                }
            }
        }

        void relayoutOverlayView(Rect frame) {
            if (!(this.mOverlayFrame != null && this.mOverlayFrame.width() == frame.width() && this.mOverlayFrame.height() == frame.height())) {
                onOverlayViewSizeChanged(frame.right - frame.left, frame.bottom - frame.top);
            }
            this.mOverlayFrame = frame;
            if (this.mOverlayViewEnabled && this.mOverlayViewContainer != null) {
                this.mWindowParams.f95x = frame.left;
                this.mWindowParams.f96y = frame.top;
                this.mWindowParams.width = frame.right - frame.left;
                this.mWindowParams.height = frame.bottom - frame.top;
                this.mWindowManager.updateViewLayout(this.mOverlayViewContainer, this.mWindowParams);
            }
        }

        void removeOverlayView(boolean clearWindowToken) {
            if (clearWindowToken) {
                this.mWindowToken = null;
                this.mOverlayFrame = null;
            }
            if (this.mOverlayViewContainer != null) {
                this.mOverlayViewContainer.removeView(this.mOverlayView);
                this.mOverlayView = null;
                this.mWindowManager.removeView(this.mOverlayViewContainer);
                this.mOverlayViewContainer = null;
                this.mWindowParams = null;
            }
        }

        void scheduleOverlayViewCleanup() {
            if (this.mOverlayViewContainer != null) {
                this.mOverlayViewCleanUpTask = new OverlayViewCleanUpTask();
                this.mOverlayViewCleanUpTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, overlayViewParent);
            }
        }

        int dispatchInputEvent(InputEvent event, InputEventReceiver receiver) {
            boolean isNavigationKey = TvInputService.DEBUG;
            if (event instanceof KeyEvent) {
                KeyEvent keyEvent = (KeyEvent) event;
                isNavigationKey = TvInputService.isNavigationKey(keyEvent.getKeyCode());
                if (keyEvent.dispatch(this, this.mDispatcherState, this)) {
                    return 1;
                }
            } else if (event instanceof MotionEvent) {
                MotionEvent motionEvent = (MotionEvent) event;
                int source = motionEvent.getSource();
                if (motionEvent.isTouchEvent()) {
                    if (onTouchEvent(motionEvent)) {
                        return 1;
                    }
                } else if ((source & 4) != 0) {
                    if (onTrackballEvent(motionEvent)) {
                        return 1;
                    }
                } else if (onGenericMotionEvent(motionEvent)) {
                    return 1;
                }
            }
            if (this.mOverlayViewContainer == null || !this.mOverlayViewContainer.isAttachedToWindow()) {
                return 0;
            }
            if (!this.mOverlayViewContainer.hasWindowFocus()) {
                this.mOverlayViewContainer.getViewRootImpl().windowFocusChanged(true, true);
            }
            if (isNavigationKey && this.mOverlayViewContainer.hasFocusable()) {
                this.mOverlayViewContainer.getViewRootImpl().dispatchInputEvent(event);
                return 1;
            }
            this.mOverlayViewContainer.getViewRootImpl().dispatchInputEvent(event, receiver);
            return -1;
        }

        private void initialize(ITvInputSessionCallback callback) {
            synchronized (this.mLock) {
                this.mSessionCallback = callback;
                for (Runnable runnable : this.mPendingActions) {
                    runnable.run();
                }
                this.mPendingActions.clear();
            }
        }

        private final void executeOrPostRunnable(Runnable action) {
            synchronized (this.mLock) {
                if (this.mSessionCallback == null) {
                    this.mPendingActions.add(action);
                } else if (this.mHandler.getLooper().isCurrentThread()) {
                    action.run();
                } else {
                    this.mHandler.post(action);
                }
            }
        }
    }

    public static abstract class HardwareSession extends Session {
        private android.media.tv.TvInputManager.Session mHardwareSession;
        private final SessionCallback mHardwareSessionCallback;
        private ITvInputSession mProxySession;
        private ITvInputSessionCallback mProxySessionCallback;
        private Handler mServiceHandler;

        /* renamed from: android.media.tv.TvInputService.HardwareSession.1 */
        class C04561 extends SessionCallback {
            C04561() {
            }

            public void onSessionCreated(android.media.tv.TvInputManager.Session session) {
                HardwareSession.this.mHardwareSession = session;
                SomeArgs args = SomeArgs.obtain();
                if (session != null) {
                    args.arg1 = HardwareSession.this;
                    args.arg2 = HardwareSession.this.mProxySession;
                    args.arg3 = HardwareSession.this.mProxySessionCallback;
                    args.arg4 = session.getToken();
                } else {
                    args.arg1 = null;
                    args.arg2 = null;
                    args.arg3 = HardwareSession.this.mProxySessionCallback;
                    args.arg4 = null;
                    HardwareSession.this.onRelease();
                }
                HardwareSession.this.mServiceHandler.obtainMessage(2, args).sendToTarget();
                session.tune(TvContract.buildChannelUriForPassthroughInput(HardwareSession.this.getHardwareInputId()));
            }

            public void onVideoAvailable(android.media.tv.TvInputManager.Session session) {
                if (HardwareSession.this.mHardwareSession == session) {
                    HardwareSession.this.onHardwareVideoAvailable();
                }
            }

            public void onVideoUnavailable(android.media.tv.TvInputManager.Session session, int reason) {
                if (HardwareSession.this.mHardwareSession == session) {
                    HardwareSession.this.onHardwareVideoUnavailable(reason);
                }
            }
        }

        public abstract String getHardwareInputId();

        public HardwareSession(Context context) {
            super(context);
            this.mHardwareSessionCallback = new C04561();
        }

        public final boolean onSetSurface(Surface surface) {
            Log.e(TvInputService.TAG, "onSetSurface() should not be called in HardwareProxySession.");
            return TvInputService.DEBUG;
        }

        public void onHardwareVideoAvailable() {
        }

        public void onHardwareVideoUnavailable(int reason) {
        }
    }

    @SuppressLint({"HandlerLeak"})
    private final class ServiceHandler extends Handler {
        private static final int DO_ADD_HARDWARE_TV_INPUT = 3;
        private static final int DO_ADD_HDMI_TV_INPUT = 5;
        private static final int DO_CREATE_SESSION = 1;
        private static final int DO_NOTIFY_SESSION_CREATED = 2;
        private static final int DO_REMOVE_HARDWARE_TV_INPUT = 4;
        private static final int DO_REMOVE_HDMI_TV_INPUT = 6;

        private ServiceHandler() {
        }

        private void broadcastAddHardwareTvInput(int deviceId, TvInputInfo inputInfo) {
            int n = TvInputService.this.mCallbacks.beginBroadcast();
            for (int i = 0; i < n; i += DO_CREATE_SESSION) {
                try {
                    ((ITvInputServiceCallback) TvInputService.this.mCallbacks.getBroadcastItem(i)).addHardwareTvInput(deviceId, inputInfo);
                } catch (RemoteException e) {
                    Log.e(TvInputService.TAG, "Error while broadcasting.", e);
                }
            }
            TvInputService.this.mCallbacks.finishBroadcast();
        }

        private void broadcastAddHdmiTvInput(int id, TvInputInfo inputInfo) {
            int n = TvInputService.this.mCallbacks.beginBroadcast();
            for (int i = 0; i < n; i += DO_CREATE_SESSION) {
                try {
                    ((ITvInputServiceCallback) TvInputService.this.mCallbacks.getBroadcastItem(i)).addHdmiTvInput(id, inputInfo);
                } catch (RemoteException e) {
                    Log.e(TvInputService.TAG, "Error while broadcasting.", e);
                }
            }
            TvInputService.this.mCallbacks.finishBroadcast();
        }

        private void broadcastRemoveTvInput(String inputId) {
            int n = TvInputService.this.mCallbacks.beginBroadcast();
            for (int i = 0; i < n; i += DO_CREATE_SESSION) {
                try {
                    ((ITvInputServiceCallback) TvInputService.this.mCallbacks.getBroadcastItem(i)).removeTvInput(inputId);
                } catch (RemoteException e) {
                    Log.e(TvInputService.TAG, "Error while broadcasting.", e);
                }
            }
            TvInputService.this.mCallbacks.finishBroadcast();
        }

        public final void handleMessage(Message msg) {
            SomeArgs args;
            ITvInputSessionCallback cb;
            String inputId;
            Session sessionImpl;
            TvInputHardwareInfo hardwareInfo;
            TvInputInfo inputInfo;
            HdmiDeviceInfo deviceInfo;
            switch (msg.what) {
                case DO_CREATE_SESSION /*1*/:
                    args = msg.obj;
                    InputChannel channel = args.arg1;
                    cb = args.arg2;
                    inputId = args.arg3;
                    args.recycle();
                    sessionImpl = TvInputService.this.onCreateSession(inputId);
                    if (sessionImpl == null) {
                        try {
                            cb.onSessionCreated(null, null);
                            return;
                        } catch (RemoteException e) {
                            Log.e(TvInputService.TAG, "error in onSessionCreated");
                            return;
                        }
                    }
                    ITvInputSession iTvInputSessionWrapper = new ITvInputSessionWrapper(TvInputService.this, sessionImpl, channel);
                    if (sessionImpl instanceof HardwareSession) {
                        HardwareSession proxySession = (HardwareSession) sessionImpl;
                        String harewareInputId = proxySession.getHardwareInputId();
                        if (!TextUtils.isEmpty(harewareInputId)) {
                            if (TvInputService.this.isPassthroughInput(harewareInputId)) {
                                proxySession.mProxySession = iTvInputSessionWrapper;
                                proxySession.mProxySessionCallback = cb;
                                proxySession.mServiceHandler = TvInputService.this.mServiceHandler;
                                ((TvInputManager) TvInputService.this.getSystemService(Context.TV_INPUT_SERVICE)).createSession(harewareInputId, proxySession.mHardwareSessionCallback, TvInputService.this.mServiceHandler);
                                return;
                            }
                        }
                        if (TextUtils.isEmpty(harewareInputId)) {
                            Log.w(TvInputService.TAG, "Hardware input id is not setup yet.");
                        } else {
                            Log.w(TvInputService.TAG, "Invalid hardware input id : " + harewareInputId);
                        }
                        sessionImpl.onRelease();
                        try {
                            cb.onSessionCreated(null, null);
                            return;
                        } catch (RemoteException e2) {
                            Log.e(TvInputService.TAG, "error in onSessionCreated");
                            return;
                        }
                    }
                    SomeArgs someArgs = SomeArgs.obtain();
                    someArgs.arg1 = sessionImpl;
                    someArgs.arg2 = iTvInputSessionWrapper;
                    someArgs.arg3 = cb;
                    someArgs.arg4 = null;
                    TvInputService.this.mServiceHandler.obtainMessage(DO_NOTIFY_SESSION_CREATED, someArgs).sendToTarget();
                case DO_NOTIFY_SESSION_CREATED /*2*/:
                    args = (SomeArgs) msg.obj;
                    sessionImpl = (Session) args.arg1;
                    cb = (ITvInputSessionCallback) args.arg3;
                    try {
                        cb.onSessionCreated((ITvInputSession) args.arg2, args.arg4);
                    } catch (RemoteException e3) {
                        Log.e(TvInputService.TAG, "error in onSessionCreated");
                    }
                    if (sessionImpl != null) {
                        sessionImpl.initialize(cb);
                    }
                    args.recycle();
                case DO_ADD_HARDWARE_TV_INPUT /*3*/:
                    hardwareInfo = msg.obj;
                    inputInfo = TvInputService.this.onHardwareAdded(hardwareInfo);
                    if (inputInfo != null) {
                        broadcastAddHardwareTvInput(hardwareInfo.getDeviceId(), inputInfo);
                    }
                case DO_REMOVE_HARDWARE_TV_INPUT /*4*/:
                    hardwareInfo = (TvInputHardwareInfo) msg.obj;
                    inputId = TvInputService.this.onHardwareRemoved(hardwareInfo);
                    if (inputId != null) {
                        broadcastRemoveTvInput(inputId);
                    }
                case DO_ADD_HDMI_TV_INPUT /*5*/:
                    deviceInfo = msg.obj;
                    inputInfo = TvInputService.this.onHdmiDeviceAdded(deviceInfo);
                    if (inputInfo != null) {
                        broadcastAddHdmiTvInput(deviceInfo.getId(), inputInfo);
                    }
                case DO_REMOVE_HDMI_TV_INPUT /*6*/:
                    deviceInfo = (HdmiDeviceInfo) msg.obj;
                    inputId = TvInputService.this.onHdmiDeviceRemoved(deviceInfo);
                    if (inputId != null) {
                        broadcastRemoveTvInput(inputId);
                    }
                default:
                    Log.w(TvInputService.TAG, "Unhandled message code: " + msg.what);
            }
        }
    }

    public abstract Session onCreateSession(String str);

    public TvInputService() {
        this.mServiceHandler = new ServiceHandler();
        this.mCallbacks = new RemoteCallbackList();
    }

    public final IBinder onBind(Intent intent) {
        return new C04551();
    }

    public TvInputInfo onHardwareAdded(TvInputHardwareInfo hardwareInfo) {
        return null;
    }

    public String onHardwareRemoved(TvInputHardwareInfo hardwareInfo) {
        return null;
    }

    public TvInputInfo onHdmiDeviceAdded(HdmiDeviceInfo deviceInfo) {
        return null;
    }

    public String onHdmiDeviceRemoved(HdmiDeviceInfo deviceInfo) {
        return null;
    }

    private boolean isPassthroughInput(String inputId) {
        if (this.mTvInputManager == null) {
            this.mTvInputManager = (TvInputManager) getSystemService(Context.TV_INPUT_SERVICE);
        }
        TvInputInfo info = this.mTvInputManager.getTvInputInfo(inputId);
        if (info == null || !info.isPassthroughInput()) {
            return DEBUG;
        }
        return true;
    }

    public static boolean isNavigationKey(int keyCode) {
        switch (keyCode) {
            case RelativeLayout.ALIGN_END /*19*/:
            case RelativeLayout.ALIGN_PARENT_START /*20*/:
            case RelativeLayout.ALIGN_PARENT_END /*21*/:
            case MotionEvent.AXIS_GAS /*22*/:
            case MotionEvent.AXIS_BRAKE /*23*/:
            case KeyEvent.KEYCODE_TAB /*61*/:
            case KeyEvent.KEYCODE_SPACE /*62*/:
            case KeyEvent.KEYCODE_ENTER /*66*/:
            case KeyEvent.KEYCODE_PAGE_UP /*92*/:
            case KeyEvent.KEYCODE_PAGE_DOWN /*93*/:
            case KeyEvent.KEYCODE_MOVE_HOME /*122*/:
            case KeyEvent.KEYCODE_MOVE_END /*123*/:
                return true;
            default:
                return DEBUG;
        }
    }
}
