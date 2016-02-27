package com.android.server.am;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityManager;
import android.widget.Toast;

public class LockTaskNotify {
    private static final String TAG = "LockTaskNotify";
    private AccessibilityManager mAccessibilityManager;
    private final Context mContext;
    private final C0143H mHandler;
    private Toast mLastToast;

    /* renamed from: com.android.server.am.LockTaskNotify.H */
    private final class C0143H extends Handler {
        private static final int SHOW_TOAST = 3;

        private C0143H() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case SHOW_TOAST /*3*/:
                    LockTaskNotify.this.handleShowToast(msg.arg1 != 0);
                default:
            }
        }
    }

    public LockTaskNotify(Context context) {
        this.mContext = context;
        this.mAccessibilityManager = (AccessibilityManager) this.mContext.getSystemService("accessibility");
        this.mHandler = new C0143H();
    }

    public void showToast(boolean isLocked) {
        int i;
        C0143H c0143h = this.mHandler;
        if (isLocked) {
            i = 1;
        } else {
            i = 0;
        }
        c0143h.obtainMessage(3, i, 0).sendToTarget();
    }

    public void handleShowToast(boolean isLocked) {
        String text = this.mContext.getString(isLocked ? 17041048 : 17041046);
        if (!isLocked && this.mAccessibilityManager.isEnabled()) {
            text = this.mContext.getString(17041047);
        }
        if (this.mLastToast != null) {
            this.mLastToast.cancel();
        }
        this.mLastToast = makeAllUserToastAndShow(text);
    }

    public void show(boolean starting) {
        int showString = 17041050;
        if (starting) {
            showString = 17041049;
        }
        makeAllUserToastAndShow(this.mContext.getString(showString));
    }

    private Toast makeAllUserToastAndShow(String text) {
        Toast toast = Toast.makeText(this.mContext, text, 1);
        LayoutParams windowParams = toast.getWindowParams();
        windowParams.privateFlags |= 16;
        toast.show();
        return toast;
    }
}
