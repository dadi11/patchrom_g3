package com.android.internal.policy.impl.keyguard;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;
import android.os.UserHandle;
import android.util.Log;
import android.util.Slog;
import android.view.View;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManagerPolicy.OnKeyguardExitResult;
import com.android.internal.policy.IKeyguardExitCallback;
import com.android.internal.policy.IKeyguardService.Stub;
import com.android.internal.policy.IKeyguardShowCallback;

public class KeyguardServiceDelegate {
    private static final boolean DEBUG = false;
    public static final String KEYGUARD_CLASS = "com.android.systemui.keyguard.KeyguardService";
    public static final String KEYGUARD_PACKAGE = "com.android.systemui";
    private static final String TAG = "KeyguardServiceDelegate";
    private final Context mContext;
    private final ServiceConnection mKeyguardConnection;
    protected KeyguardServiceWrapper mKeyguardService;
    private final KeyguardState mKeyguardState;
    private final View mScrim;
    private ShowListener mShowListenerWhenConnect;

    public interface ShowListener {
        void onShown(IBinder iBinder);
    }

    /* renamed from: com.android.internal.policy.impl.keyguard.KeyguardServiceDelegate.1 */
    class C00421 implements ServiceConnection {
        C00421() {
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            KeyguardServiceDelegate.this.mKeyguardService = new KeyguardServiceWrapper(KeyguardServiceDelegate.this.mContext, Stub.asInterface(service));
            if (KeyguardServiceDelegate.this.mKeyguardState.systemIsReady) {
                KeyguardServiceDelegate.this.mKeyguardService.onSystemReady();
                KeyguardServiceDelegate.this.mKeyguardService.onScreenTurnedOn(new KeyguardShowDelegate(KeyguardServiceDelegate.this.mShowListenerWhenConnect));
                KeyguardServiceDelegate.this.mShowListenerWhenConnect = null;
            }
            if (KeyguardServiceDelegate.this.mKeyguardState.bootCompleted) {
                KeyguardServiceDelegate.this.mKeyguardService.onBootCompleted();
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            KeyguardServiceDelegate.this.mKeyguardService = null;
        }
    }

    /* renamed from: com.android.internal.policy.impl.keyguard.KeyguardServiceDelegate.2 */
    class C00432 implements Runnable {
        C00432() {
        }

        public void run() {
            KeyguardServiceDelegate.this.mScrim.setVisibility(0);
        }
    }

    /* renamed from: com.android.internal.policy.impl.keyguard.KeyguardServiceDelegate.3 */
    class C00443 implements Runnable {
        C00443() {
        }

        public void run() {
            KeyguardServiceDelegate.this.mScrim.setVisibility(8);
        }
    }

    private final class KeyguardExitDelegate extends IKeyguardExitCallback.Stub {
        private OnKeyguardExitResult mOnKeyguardExitResult;

        KeyguardExitDelegate(OnKeyguardExitResult onKeyguardExitResult) {
            this.mOnKeyguardExitResult = onKeyguardExitResult;
        }

        public void onKeyguardExitResult(boolean success) throws RemoteException {
            if (this.mOnKeyguardExitResult != null) {
                this.mOnKeyguardExitResult.onKeyguardExitResult(success);
            }
        }
    }

    private final class KeyguardShowDelegate extends IKeyguardShowCallback.Stub {
        private ShowListener mShowListener;

        KeyguardShowDelegate(ShowListener showListener) {
            this.mShowListener = showListener;
        }

        public void onShown(IBinder windowToken) throws RemoteException {
            if (this.mShowListener != null) {
                this.mShowListener.onShown(windowToken);
            }
            KeyguardServiceDelegate.this.hideScrim();
        }
    }

    static final class KeyguardState {
        public boolean bootCompleted;
        public int currentUser;
        boolean deviceHasKeyguard;
        public boolean dismissable;
        boolean dreaming;
        public boolean enabled;
        boolean inputRestricted;
        boolean occluded;
        public int offReason;
        public boolean screenIsOn;
        boolean secure;
        boolean showing;
        boolean showingAndNotOccluded;
        boolean systemIsReady;

        KeyguardState() {
            this.showing = true;
            this.showingAndNotOccluded = true;
            this.secure = true;
            this.deviceHasKeyguard = true;
        }
    }

    public KeyguardServiceDelegate(Context context) {
        this.mKeyguardState = new KeyguardState();
        this.mKeyguardConnection = new C00421();
        this.mContext = context;
        this.mScrim = createScrim(context);
    }

    public void bindService(Context context) {
        Intent intent = new Intent();
        intent.setClassName(KEYGUARD_PACKAGE, KEYGUARD_CLASS);
        if (!context.bindServiceAsUser(intent, this.mKeyguardConnection, 1, UserHandle.OWNER)) {
            Log.v(TAG, "*** Keyguard: can't bind to com.android.systemui.keyguard.KeyguardService");
            this.mKeyguardState.showing = DEBUG;
            this.mKeyguardState.showingAndNotOccluded = DEBUG;
            this.mKeyguardState.secure = DEBUG;
            this.mKeyguardState.deviceHasKeyguard = DEBUG;
            hideScrim();
        }
    }

    public boolean isShowing() {
        if (this.mKeyguardService != null) {
            this.mKeyguardState.showing = this.mKeyguardService.isShowing();
        }
        return this.mKeyguardState.showing;
    }

    public boolean isInputRestricted() {
        if (this.mKeyguardService != null) {
            this.mKeyguardState.inputRestricted = this.mKeyguardService.isInputRestricted();
        }
        return this.mKeyguardState.inputRestricted;
    }

    public void verifyUnlock(OnKeyguardExitResult onKeyguardExitResult) {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.verifyUnlock(new KeyguardExitDelegate(onKeyguardExitResult));
        }
    }

    public void keyguardDone(boolean authenticated, boolean wakeup) {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.keyguardDone(authenticated, wakeup);
        }
    }

    public void setOccluded(boolean isOccluded) {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.setOccluded(isOccluded);
        }
        this.mKeyguardState.occluded = isOccluded;
    }

    public void dismiss() {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.dismiss();
        }
    }

    public boolean isSecure() {
        if (this.mKeyguardService != null) {
            this.mKeyguardState.secure = this.mKeyguardService.isSecure();
        }
        return this.mKeyguardState.secure;
    }

    public void onDreamingStarted() {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.onDreamingStarted();
        }
        this.mKeyguardState.dreaming = true;
    }

    public void onDreamingStopped() {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.onDreamingStopped();
        }
        this.mKeyguardState.dreaming = DEBUG;
    }

    public void onScreenTurnedOn(ShowListener showListener) {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.onScreenTurnedOn(new KeyguardShowDelegate(showListener));
        } else {
            Slog.w(TAG, "onScreenTurnedOn(): no keyguard service!");
            this.mShowListenerWhenConnect = showListener;
            showScrim();
        }
        this.mKeyguardState.screenIsOn = true;
    }

    public void onScreenTurnedOff(int why) {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.onScreenTurnedOff(why);
        }
        this.mKeyguardState.offReason = why;
        this.mKeyguardState.screenIsOn = DEBUG;
    }

    public void setKeyguardEnabled(boolean enabled) {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.setKeyguardEnabled(enabled);
        }
        this.mKeyguardState.enabled = enabled;
    }

    public void onSystemReady() {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.onSystemReady();
        } else {
            this.mKeyguardState.systemIsReady = true;
        }
    }

    public void doKeyguardTimeout(Bundle options) {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.doKeyguardTimeout(options);
        }
    }

    public void setCurrentUser(int newUserId) {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.setCurrentUser(newUserId);
        }
        this.mKeyguardState.currentUser = newUserId;
    }

    public void startKeyguardExitAnimation(long startTime, long fadeoutDuration) {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.startKeyguardExitAnimation(startTime, fadeoutDuration);
        }
    }

    private static final View createScrim(Context context) {
        View view = new View(context);
        LayoutParams lp = new LayoutParams(-1, -1, 2029, 1116416, -3);
        lp.softInputMode = 16;
        lp.screenOrientation = 5;
        lp.privateFlags |= 1;
        lp.setTitle("KeyguardScrim");
        ((WindowManager) context.getSystemService("window")).addView(view, lp);
        view.setSystemUiVisibility(56688640);
        return view;
    }

    public void showScrim() {
        if (this.mKeyguardState.deviceHasKeyguard) {
            this.mScrim.post(new C00432());
        }
    }

    public void hideScrim() {
        this.mScrim.post(new C00443());
    }

    public void onBootCompleted() {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.onBootCompleted();
        }
        this.mKeyguardState.bootCompleted = true;
    }

    public void onActivityDrawn() {
        if (this.mKeyguardService != null) {
            this.mKeyguardService.onActivityDrawn();
        }
    }
}
