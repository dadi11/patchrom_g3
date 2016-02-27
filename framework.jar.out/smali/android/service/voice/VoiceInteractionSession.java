package android.service.voice;

import android.C0000R;
import android.app.Dialog;
import android.app.Instrumentation;
import android.content.Context;
import android.content.Intent;
import android.content.res.TypedArray;
import android.graphics.Rect;
import android.graphics.Region;
import android.inputmethodservice.SoftInputWindow;
import android.opengl.GLES20;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.RemoteException;
import android.util.ArrayMap;
import android.util.Log;
import android.view.KeyEvent;
import android.view.KeyEvent.Callback;
import android.view.KeyEvent.DispatcherState;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewTreeObserver.InternalInsetsInfo;
import android.view.ViewTreeObserver.OnComputeInternalInsetsListener;
import android.view.Window;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManagerPolicy;
import android.widget.FrameLayout;
import com.android.internal.app.IVoiceInteractionManagerService;
import com.android.internal.app.IVoiceInteractor;
import com.android.internal.app.IVoiceInteractor.Stub;
import com.android.internal.app.IVoiceInteractorCallback;
import com.android.internal.app.IVoiceInteractorRequest;
import com.android.internal.os.HandlerCaller;
import com.android.internal.os.SomeArgs;
import java.lang.ref.WeakReference;

public abstract class VoiceInteractionSession implements Callback {
    static final boolean DEBUG = true;
    static final int MSG_CANCEL = 6;
    static final int MSG_CLOSE_SYSTEM_DIALOGS = 102;
    static final int MSG_DESTROY = 103;
    static final int MSG_START_ABORT_VOICE = 3;
    static final int MSG_START_COMMAND = 4;
    static final int MSG_START_COMPLETE_VOICE = 2;
    static final int MSG_START_CONFIRMATION = 1;
    static final int MSG_SUPPORTS_COMMANDS = 5;
    static final int MSG_TASK_FINISHED = 101;
    static final int MSG_TASK_STARTED = 100;
    static final String TAG = "VoiceInteractionSession";
    final ArrayMap<IBinder, Request> mActiveRequests;
    final MyCallbacks mCallbacks;
    FrameLayout mContentFrame;
    final Context mContext;
    final DispatcherState mDispatcherState;
    final HandlerCaller mHandlerCaller;
    boolean mInShowWindow;
    LayoutInflater mInflater;
    boolean mInitialized;
    final OnComputeInternalInsetsListener mInsetsComputer;
    final IVoiceInteractor mInteractor;
    View mRootView;
    final IVoiceInteractionSession mSession;
    IVoiceInteractionManagerService mSystemService;
    int mTheme;
    TypedArray mThemeAttrs;
    final Insets mTmpInsets;
    final int[] mTmpLocation;
    IBinder mToken;
    final WeakReference<VoiceInteractionSession> mWeakRef;
    SoftInputWindow mWindow;
    boolean mWindowAdded;
    boolean mWindowVisible;
    boolean mWindowWasVisible;

    /* renamed from: android.service.voice.VoiceInteractionSession.1 */
    class C06961 extends Stub {
        C06961() {
        }

        public IVoiceInteractorRequest startConfirmation(String callingPackage, IVoiceInteractorCallback callback, CharSequence prompt, Bundle extras) {
            Request request = VoiceInteractionSession.this.newRequest(callback);
            VoiceInteractionSession.this.mHandlerCaller.sendMessage(VoiceInteractionSession.this.mHandlerCaller.obtainMessageOOOO(VoiceInteractionSession.MSG_START_CONFIRMATION, new Caller(callingPackage, Binder.getCallingUid()), request, prompt, extras));
            return request.mInterface;
        }

        public IVoiceInteractorRequest startCompleteVoice(String callingPackage, IVoiceInteractorCallback callback, CharSequence message, Bundle extras) {
            Request request = VoiceInteractionSession.this.newRequest(callback);
            VoiceInteractionSession.this.mHandlerCaller.sendMessage(VoiceInteractionSession.this.mHandlerCaller.obtainMessageOOOO(VoiceInteractionSession.MSG_START_COMPLETE_VOICE, new Caller(callingPackage, Binder.getCallingUid()), request, message, extras));
            return request.mInterface;
        }

        public IVoiceInteractorRequest startAbortVoice(String callingPackage, IVoiceInteractorCallback callback, CharSequence message, Bundle extras) {
            Request request = VoiceInteractionSession.this.newRequest(callback);
            VoiceInteractionSession.this.mHandlerCaller.sendMessage(VoiceInteractionSession.this.mHandlerCaller.obtainMessageOOOO(VoiceInteractionSession.MSG_START_ABORT_VOICE, new Caller(callingPackage, Binder.getCallingUid()), request, message, extras));
            return request.mInterface;
        }

        public IVoiceInteractorRequest startCommand(String callingPackage, IVoiceInteractorCallback callback, String command, Bundle extras) {
            Request request = VoiceInteractionSession.this.newRequest(callback);
            VoiceInteractionSession.this.mHandlerCaller.sendMessage(VoiceInteractionSession.this.mHandlerCaller.obtainMessageOOOO(VoiceInteractionSession.MSG_START_COMMAND, new Caller(callingPackage, Binder.getCallingUid()), request, command, extras));
            return request.mInterface;
        }

        public boolean[] supportsCommands(String callingPackage, String[] commands) {
            SomeArgs args = VoiceInteractionSession.this.mHandlerCaller.sendMessageAndWait(VoiceInteractionSession.this.mHandlerCaller.obtainMessageIOO(VoiceInteractionSession.MSG_SUPPORTS_COMMANDS, 0, new Caller(callingPackage, Binder.getCallingUid()), commands));
            if (args == null) {
                return new boolean[commands.length];
            }
            boolean[] res = (boolean[]) args.arg1;
            args.recycle();
            return res;
        }
    }

    /* renamed from: android.service.voice.VoiceInteractionSession.2 */
    class C06972 extends IVoiceInteractionSession.Stub {
        C06972() {
        }

        public void taskStarted(Intent intent, int taskId) {
            VoiceInteractionSession.this.mHandlerCaller.sendMessage(VoiceInteractionSession.this.mHandlerCaller.obtainMessageIO(VoiceInteractionSession.MSG_TASK_STARTED, taskId, intent));
        }

        public void taskFinished(Intent intent, int taskId) {
            VoiceInteractionSession.this.mHandlerCaller.sendMessage(VoiceInteractionSession.this.mHandlerCaller.obtainMessageIO(VoiceInteractionSession.MSG_TASK_FINISHED, taskId, intent));
        }

        public void closeSystemDialogs() {
            VoiceInteractionSession.this.mHandlerCaller.sendMessage(VoiceInteractionSession.this.mHandlerCaller.obtainMessage(VoiceInteractionSession.MSG_CLOSE_SYSTEM_DIALOGS));
        }

        public void destroy() {
            VoiceInteractionSession.this.mHandlerCaller.sendMessage(VoiceInteractionSession.this.mHandlerCaller.obtainMessage(VoiceInteractionSession.MSG_DESTROY));
        }
    }

    /* renamed from: android.service.voice.VoiceInteractionSession.3 */
    class C06983 implements OnComputeInternalInsetsListener {
        C06983() {
        }

        public void onComputeInternalInsets(InternalInsetsInfo info) {
            VoiceInteractionSession.this.onComputeInsets(VoiceInteractionSession.this.mTmpInsets);
            info.contentInsets.set(VoiceInteractionSession.this.mTmpInsets.contentInsets);
            info.visibleInsets.set(VoiceInteractionSession.this.mTmpInsets.contentInsets);
            info.touchableRegion.set(VoiceInteractionSession.this.mTmpInsets.touchableRegion);
            info.setTouchableInsets(VoiceInteractionSession.this.mTmpInsets.touchableInsets);
        }
    }

    public static class Caller {
        final String packageName;
        final int uid;

        Caller(String _packageName, int _uid) {
            this.packageName = _packageName;
            this.uid = _uid;
        }
    }

    public static final class Insets {
        public static final int TOUCHABLE_INSETS_CONTENT = 1;
        public static final int TOUCHABLE_INSETS_FRAME = 0;
        public static final int TOUCHABLE_INSETS_REGION = 3;
        public final Rect contentInsets;
        public int touchableInsets;
        public final Region touchableRegion;

        public Insets() {
            this.contentInsets = new Rect();
            this.touchableRegion = new Region();
        }
    }

    class MyCallbacks implements HandlerCaller.Callback, SoftInputWindow.Callback {
        MyCallbacks() {
        }

        public void executeMessage(Message msg) {
            SomeArgs args;
            switch (msg.what) {
                case VoiceInteractionSession.MSG_START_CONFIRMATION /*1*/:
                    args = msg.obj;
                    Log.d(VoiceInteractionSession.TAG, "onConfirm: req=" + ((Request) args.arg2).mInterface + " prompt=" + args.arg3 + " extras=" + args.arg4);
                    VoiceInteractionSession.this.onConfirm((Caller) args.arg1, (Request) args.arg2, (CharSequence) args.arg3, (Bundle) args.arg4);
                case VoiceInteractionSession.MSG_START_COMPLETE_VOICE /*2*/:
                    args = (SomeArgs) msg.obj;
                    Log.d(VoiceInteractionSession.TAG, "onCompleteVoice: req=" + ((Request) args.arg2).mInterface + " message=" + args.arg3 + " extras=" + args.arg4);
                    VoiceInteractionSession.this.onCompleteVoice((Caller) args.arg1, (Request) args.arg2, (CharSequence) args.arg3, (Bundle) args.arg4);
                case VoiceInteractionSession.MSG_START_ABORT_VOICE /*3*/:
                    args = (SomeArgs) msg.obj;
                    Log.d(VoiceInteractionSession.TAG, "onAbortVoice: req=" + ((Request) args.arg2).mInterface + " message=" + args.arg3 + " extras=" + args.arg4);
                    VoiceInteractionSession.this.onAbortVoice((Caller) args.arg1, (Request) args.arg2, (CharSequence) args.arg3, (Bundle) args.arg4);
                case VoiceInteractionSession.MSG_START_COMMAND /*4*/:
                    args = (SomeArgs) msg.obj;
                    Log.d(VoiceInteractionSession.TAG, "onCommand: req=" + ((Request) args.arg2).mInterface + " command=" + args.arg3 + " extras=" + args.arg4);
                    VoiceInteractionSession.this.onCommand((Caller) args.arg1, (Request) args.arg2, (String) args.arg3, (Bundle) args.arg4);
                case VoiceInteractionSession.MSG_SUPPORTS_COMMANDS /*5*/:
                    args = (SomeArgs) msg.obj;
                    Log.d(VoiceInteractionSession.TAG, "onGetSupportedCommands: cmds=" + args.arg2);
                    args.arg1 = VoiceInteractionSession.this.onGetSupportedCommands((Caller) args.arg1, (String[]) args.arg2);
                case VoiceInteractionSession.MSG_CANCEL /*6*/:
                    args = (SomeArgs) msg.obj;
                    Log.d(VoiceInteractionSession.TAG, "onCancel: req=" + ((Request) args.arg1).mInterface);
                    VoiceInteractionSession.this.onCancel((Request) args.arg1);
                case VoiceInteractionSession.MSG_TASK_STARTED /*100*/:
                    Log.d(VoiceInteractionSession.TAG, "onTaskStarted: intent=" + msg.obj + " taskId=" + msg.arg1);
                    VoiceInteractionSession.this.onTaskStarted((Intent) msg.obj, msg.arg1);
                case VoiceInteractionSession.MSG_TASK_FINISHED /*101*/:
                    Log.d(VoiceInteractionSession.TAG, "onTaskFinished: intent=" + msg.obj + " taskId=" + msg.arg1);
                    VoiceInteractionSession.this.onTaskFinished((Intent) msg.obj, msg.arg1);
                case VoiceInteractionSession.MSG_CLOSE_SYSTEM_DIALOGS /*102*/:
                    Log.d(VoiceInteractionSession.TAG, "onCloseSystemDialogs");
                    VoiceInteractionSession.this.onCloseSystemDialogs();
                case VoiceInteractionSession.MSG_DESTROY /*103*/:
                    Log.d(VoiceInteractionSession.TAG, "doDestroy");
                    VoiceInteractionSession.this.doDestroy();
                default:
            }
        }

        public void onBackPressed() {
            VoiceInteractionSession.this.onBackPressed();
        }
    }

    public static class Request {
        final IVoiceInteractorCallback mCallback;
        final IVoiceInteractorRequest mInterface;
        final WeakReference<VoiceInteractionSession> mSession;

        /* renamed from: android.service.voice.VoiceInteractionSession.Request.1 */
        class C06991 extends IVoiceInteractorRequest.Stub {
            C06991() {
            }

            public void cancel() throws RemoteException {
                VoiceInteractionSession session = (VoiceInteractionSession) Request.this.mSession.get();
                if (session != null) {
                    session.mHandlerCaller.sendMessage(session.mHandlerCaller.obtainMessageO(VoiceInteractionSession.MSG_CANCEL, Request.this));
                }
            }
        }

        Request(IVoiceInteractorCallback callback, VoiceInteractionSession session) {
            this.mInterface = new C06991();
            this.mCallback = callback;
            this.mSession = session.mWeakRef;
        }

        void finishRequest() {
            VoiceInteractionSession session = (VoiceInteractionSession) this.mSession.get();
            if (session == null) {
                throw new IllegalStateException("VoiceInteractionSession has been destroyed");
            }
            Request req = session.removeRequest(this.mInterface.asBinder());
            if (req == null) {
                throw new IllegalStateException("Request not active: " + this);
            } else if (req != this) {
                throw new IllegalStateException("Current active request " + req + " not same as calling request " + this);
            }
        }

        public void sendConfirmResult(boolean confirmed, Bundle result) {
            try {
                Log.d(VoiceInteractionSession.TAG, "sendConfirmResult: req=" + this.mInterface + " confirmed=" + confirmed + " result=" + result);
                finishRequest();
                this.mCallback.deliverConfirmationResult(this.mInterface, confirmed, result);
            } catch (RemoteException e) {
            }
        }

        public void sendCompleteVoiceResult(Bundle result) {
            try {
                Log.d(VoiceInteractionSession.TAG, "sendCompleteVoiceResult: req=" + this.mInterface + " result=" + result);
                finishRequest();
                this.mCallback.deliverCompleteVoiceResult(this.mInterface, result);
            } catch (RemoteException e) {
            }
        }

        public void sendAbortVoiceResult(Bundle result) {
            try {
                Log.d(VoiceInteractionSession.TAG, "sendConfirmResult: req=" + this.mInterface + " result=" + result);
                finishRequest();
                this.mCallback.deliverAbortVoiceResult(this.mInterface, result);
            } catch (RemoteException e) {
            }
        }

        public void sendCommandResult(boolean complete, Bundle result) {
            try {
                Log.d(VoiceInteractionSession.TAG, "sendCommandResult: req=" + this.mInterface + " result=" + result);
                finishRequest();
                this.mCallback.deliverCommandResult(this.mInterface, complete, result);
            } catch (RemoteException e) {
            }
        }

        public void sendCancelResult() {
            try {
                Log.d(VoiceInteractionSession.TAG, "sendCancelResult: req=" + this.mInterface);
                finishRequest();
                this.mCallback.deliverCancel(this.mInterface);
            } catch (RemoteException e) {
            }
        }
    }

    public abstract void onCancel(Request request);

    public abstract void onCommand(Caller caller, Request request, String str, Bundle bundle);

    public abstract void onConfirm(Caller caller, Request request, CharSequence charSequence, Bundle bundle);

    public VoiceInteractionSession(Context context) {
        this(context, new Handler());
    }

    public VoiceInteractionSession(Context context, Handler handler) {
        this.mDispatcherState = new DispatcherState();
        this.mTheme = 0;
        this.mActiveRequests = new ArrayMap();
        this.mTmpInsets = new Insets();
        this.mTmpLocation = new int[MSG_START_COMPLETE_VOICE];
        this.mWeakRef = new WeakReference(this);
        this.mInteractor = new C06961();
        this.mSession = new C06972();
        this.mCallbacks = new MyCallbacks();
        this.mInsetsComputer = new C06983();
        this.mContext = context;
        this.mHandlerCaller = new HandlerCaller(context, handler.getLooper(), this.mCallbacks, DEBUG);
    }

    Request newRequest(IVoiceInteractorCallback callback) {
        Request req;
        synchronized (this) {
            req = new Request(callback, this);
            this.mActiveRequests.put(req.mInterface.asBinder(), req);
        }
        return req;
    }

    Request removeRequest(IBinder reqInterface) {
        Request request;
        synchronized (this) {
            request = (Request) this.mActiveRequests.remove(reqInterface);
        }
        return request;
    }

    void doCreate(IVoiceInteractionManagerService service, IBinder token, Bundle args) {
        this.mSystemService = service;
        this.mToken = token;
        onCreate(args);
    }

    void doDestroy() {
        onDestroy();
        if (this.mInitialized) {
            this.mRootView.getViewTreeObserver().removeOnComputeInternalInsetsListener(this.mInsetsComputer);
            if (this.mWindowAdded) {
                this.mWindow.dismiss();
                this.mWindowAdded = false;
            }
            this.mInitialized = false;
        }
    }

    void initViews() {
        this.mInitialized = DEBUG;
        this.mThemeAttrs = this.mContext.obtainStyledAttributes(C0000R.styleable.VoiceInteractionSession);
        this.mRootView = this.mInflater.inflate(17367274, null);
        this.mRootView.setSystemUiVisibility(GLES20.GL_SRC_COLOR);
        this.mWindow.setContentView(this.mRootView);
        this.mRootView.getViewTreeObserver().addOnComputeInternalInsetsListener(this.mInsetsComputer);
        this.mContentFrame = (FrameLayout) this.mRootView.findViewById(Window.ID_ANDROID_CONTENT);
    }

    public void showWindow() {
        Log.v(TAG, "Showing window: mWindowAdded=" + this.mWindowAdded + " mWindowVisible=" + this.mWindowVisible);
        if (this.mInShowWindow) {
            Log.w(TAG, "Re-entrance in to showWindow");
            return;
        }
        try {
            this.mInShowWindow = DEBUG;
            if (!this.mWindowVisible) {
                this.mWindowVisible = DEBUG;
                if (!this.mWindowAdded) {
                    this.mWindowAdded = DEBUG;
                    View v = onCreateContentView();
                    if (v != null) {
                        setContentView(v);
                    }
                }
                this.mWindow.show();
            }
            this.mWindowWasVisible = DEBUG;
            this.mInShowWindow = false;
        } catch (Throwable th) {
            this.mWindowWasVisible = DEBUG;
            this.mInShowWindow = false;
        }
    }

    public void hideWindow() {
        if (this.mWindowVisible) {
            this.mWindow.hide();
            this.mWindowVisible = false;
        }
    }

    public void setTheme(int theme) {
        if (this.mWindow != null) {
            throw new IllegalStateException("Must be called before onCreate()");
        }
        this.mTheme = theme;
    }

    public void startVoiceActivity(Intent intent) {
        if (this.mToken == null) {
            throw new IllegalStateException("Can't call before onCreate()");
        }
        try {
            intent.migrateExtraStreamToClipData();
            intent.prepareToLeaveProcess();
            Instrumentation.checkStartActivityResult(this.mSystemService.startVoiceActivity(this.mToken, intent, intent.resolveType(this.mContext.getContentResolver())), intent);
        } catch (RemoteException e) {
        }
    }

    public LayoutInflater getLayoutInflater() {
        return this.mInflater;
    }

    public Dialog getWindow() {
        return this.mWindow;
    }

    public void finish() {
        if (this.mToken == null) {
            throw new IllegalStateException("Can't call before onCreate()");
        }
        hideWindow();
        try {
            this.mSystemService.finish(this.mToken);
        } catch (RemoteException e) {
        }
    }

    public void onCreate(Bundle args) {
        this.mTheme = this.mTheme != 0 ? this.mTheme : 16974989;
        this.mInflater = (LayoutInflater) this.mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.mWindow = new SoftInputWindow(this.mContext, TAG, this.mTheme, this.mCallbacks, this, this.mDispatcherState, LayoutParams.TYPE_VOICE_INTERACTION, 48, DEBUG);
        this.mWindow.getWindow().addFlags(WindowManagerPolicy.FLAG_INJECTED);
        initViews();
        this.mWindow.getWindow().setLayout(-1, -2);
        this.mWindow.setToken(this.mToken);
    }

    public void onDestroy() {
    }

    public View onCreateContentView() {
        return null;
    }

    public void setContentView(View view) {
        this.mContentFrame.removeAllViews();
        this.mContentFrame.addView(view, new FrameLayout.LayoutParams(-1, -2));
    }

    public boolean onKeyDown(int keyCode, KeyEvent event) {
        return false;
    }

    public boolean onKeyLongPress(int keyCode, KeyEvent event) {
        return false;
    }

    public boolean onKeyUp(int keyCode, KeyEvent event) {
        return false;
    }

    public boolean onKeyMultiple(int keyCode, int count, KeyEvent event) {
        return false;
    }

    public void onBackPressed() {
        finish();
    }

    public void onCloseSystemDialogs() {
        finish();
    }

    public void onComputeInsets(Insets outInsets) {
        getWindow().getWindow().getDecorView().getLocationInWindow(this.mTmpLocation);
        outInsets.contentInsets.top = 0;
        outInsets.contentInsets.left = 0;
        outInsets.contentInsets.right = 0;
        outInsets.contentInsets.bottom = 0;
        outInsets.touchableInsets = 0;
        outInsets.touchableRegion.setEmpty();
    }

    public void onTaskStarted(Intent intent, int taskId) {
    }

    public void onTaskFinished(Intent intent, int taskId) {
        finish();
    }

    public boolean[] onGetSupportedCommands(Caller caller, String[] commands) {
        return new boolean[commands.length];
    }

    public void onCompleteVoice(Caller caller, Request request, CharSequence message, Bundle extras) {
        request.sendCompleteVoiceResult(null);
    }

    public void onAbortVoice(Caller caller, Request request, CharSequence message, Bundle extras) {
        request.sendAbortVoiceResult(null);
    }
}
