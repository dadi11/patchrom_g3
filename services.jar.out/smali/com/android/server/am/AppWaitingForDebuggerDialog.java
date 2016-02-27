package com.android.server.am;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.view.WindowManager.LayoutParams;

final class AppWaitingForDebuggerDialog extends BaseErrorDialog {
    private CharSequence mAppName;
    private final Handler mHandler;
    final ProcessRecord mProc;
    final ActivityManagerService mService;

    /* renamed from: com.android.server.am.AppWaitingForDebuggerDialog.1 */
    class C01361 extends Handler {
        C01361() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                    AppWaitingForDebuggerDialog.this.mService.killAppAtUsersRequest(AppWaitingForDebuggerDialog.this.mProc, AppWaitingForDebuggerDialog.this);
                default:
            }
        }
    }

    public AppWaitingForDebuggerDialog(ActivityManagerService service, Context context, ProcessRecord app) {
        super(context);
        this.mHandler = new C01361();
        this.mService = service;
        this.mProc = app;
        this.mAppName = context.getPackageManager().getApplicationLabel(app.info);
        setCancelable(false);
        StringBuilder text = new StringBuilder();
        if (this.mAppName == null || this.mAppName.length() <= 0) {
            text.append("Process ");
            text.append(app.processName);
        } else {
            text.append("Application ");
            text.append(this.mAppName);
            text.append(" (process ");
            text.append(app.processName);
            text.append(")");
        }
        text.append(" is waiting for the debugger to attach.");
        setMessage(text.toString());
        setButton(-1, "Force Close", this.mHandler.obtainMessage(1, app));
        setTitle("Waiting For Debugger");
        LayoutParams attrs = getWindow().getAttributes();
        attrs.setTitle("Waiting For Debugger: " + app.info.processName);
        getWindow().setAttributes(attrs);
    }

    public void onStop() {
    }
}
