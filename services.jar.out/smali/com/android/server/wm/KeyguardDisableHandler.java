package com.android.server.wm;

import android.app.ActivityManagerNative;
import android.app.admin.DevicePolicyManager;
import android.content.Context;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.RemoteException;
import android.os.TokenWatcher;
import android.util.Log;
import android.util.Pair;
import android.view.WindowManagerPolicy;

public class KeyguardDisableHandler extends Handler {
    private static final int ALLOW_DISABLE_NO = 0;
    private static final int ALLOW_DISABLE_UNKNOWN = -1;
    private static final int ALLOW_DISABLE_YES = 1;
    static final int KEYGUARD_DISABLE = 1;
    static final int KEYGUARD_POLICY_CHANGED = 3;
    static final int KEYGUARD_REENABLE = 2;
    private static final String TAG = "KeyguardDisableHandler";
    private int mAllowDisableKeyguard;
    final Context mContext;
    KeyguardTokenWatcher mKeyguardTokenWatcher;
    final WindowManagerPolicy mPolicy;

    class KeyguardTokenWatcher extends TokenWatcher {
        public KeyguardTokenWatcher(Handler handler) {
            super(handler, KeyguardDisableHandler.TAG);
        }

        public void updateAllowState() {
            DevicePolicyManager dpm = (DevicePolicyManager) KeyguardDisableHandler.this.mContext.getSystemService("device_policy");
            if (dpm != null) {
                try {
                    KeyguardDisableHandler.this.mAllowDisableKeyguard = dpm.getPasswordQuality(null, ActivityManagerNative.getDefault().getCurrentUser().id) == 0 ? KeyguardDisableHandler.KEYGUARD_DISABLE : KeyguardDisableHandler.ALLOW_DISABLE_NO;
                } catch (RemoteException e) {
                }
            }
        }

        public void acquired() {
            if (KeyguardDisableHandler.this.mAllowDisableKeyguard == KeyguardDisableHandler.ALLOW_DISABLE_UNKNOWN) {
                updateAllowState();
            }
            if (KeyguardDisableHandler.this.mAllowDisableKeyguard == KeyguardDisableHandler.KEYGUARD_DISABLE) {
                KeyguardDisableHandler.this.mPolicy.enableKeyguard(false);
            } else {
                Log.v(KeyguardDisableHandler.TAG, "Not disabling keyguard since device policy is enforced");
            }
        }

        public void released() {
            KeyguardDisableHandler.this.mPolicy.enableKeyguard(true);
        }
    }

    public KeyguardDisableHandler(Context context, WindowManagerPolicy policy) {
        this.mAllowDisableKeyguard = ALLOW_DISABLE_UNKNOWN;
        this.mContext = context;
        this.mPolicy = policy;
    }

    public void handleMessage(Message msg) {
        if (this.mKeyguardTokenWatcher == null) {
            this.mKeyguardTokenWatcher = new KeyguardTokenWatcher(this);
        }
        switch (msg.what) {
            case KEYGUARD_DISABLE /*1*/:
                Pair<IBinder, String> pair = msg.obj;
                this.mKeyguardTokenWatcher.acquire((IBinder) pair.first, (String) pair.second);
            case KEYGUARD_REENABLE /*2*/:
                this.mKeyguardTokenWatcher.release((IBinder) msg.obj);
            case KEYGUARD_POLICY_CHANGED /*3*/:
                this.mAllowDisableKeyguard = ALLOW_DISABLE_UNKNOWN;
                if (this.mKeyguardTokenWatcher.isAcquired()) {
                    this.mKeyguardTokenWatcher.updateAllowState();
                    if (this.mAllowDisableKeyguard != KEYGUARD_DISABLE) {
                        this.mPolicy.enableKeyguard(true);
                        return;
                    }
                    return;
                }
                this.mPolicy.enableKeyguard(true);
            default:
        }
    }
}
