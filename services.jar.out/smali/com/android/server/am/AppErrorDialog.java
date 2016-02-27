package com.android.server.am;

import android.content.Context;
import android.content.res.Resources;
import android.os.Handler;
import android.os.Message;
import android.view.WindowManager.LayoutParams;
import com.android.server.input.InputManagerService;

final class AppErrorDialog extends BaseErrorDialog {
    static final long DISMISS_TIMEOUT = 300000;
    static final int FORCE_QUIT = 0;
    static final int FORCE_QUIT_AND_REPORT = 1;
    private final Handler mHandler;
    private final ProcessRecord mProc;
    private final AppErrorResult mResult;
    private final ActivityManagerService mService;

    /* renamed from: com.android.server.am.AppErrorDialog.1 */
    class C01341 extends Handler {
        C01341() {
        }

        public void handleMessage(Message msg) {
            synchronized (AppErrorDialog.this.mService) {
                if (AppErrorDialog.this.mProc != null && AppErrorDialog.this.mProc.crashDialog == AppErrorDialog.this) {
                    AppErrorDialog.this.mProc.crashDialog = null;
                }
            }
            AppErrorDialog.this.mResult.set(msg.what);
            removeMessages(AppErrorDialog.FORCE_QUIT);
            AppErrorDialog.this.dismiss();
        }
    }

    public AppErrorDialog(Context context, ActivityManagerService service, AppErrorResult result, ProcessRecord app) {
        super(context);
        this.mHandler = new C01341();
        Resources res = context.getResources();
        this.mService = service;
        this.mProc = app;
        this.mResult = result;
        if (app.pkgList.size() != FORCE_QUIT_AND_REPORT || context.getPackageManager().getApplicationLabel(app.info) == null) {
            Object[] objArr = new Object[FORCE_QUIT_AND_REPORT];
            objArr[FORCE_QUIT] = app.processName.toString();
            setMessage(res.getString(17040529, objArr));
        } else {
            setMessage(res.getString(17040528, new Object[]{context.getPackageManager().getApplicationLabel(app.info).toString(), app.info.processName}));
        }
        setCancelable(false);
        setButton(-1, res.getText(17040535), this.mHandler.obtainMessage(FORCE_QUIT));
        if (app.errorReportReceiver != null) {
            setButton(-2, res.getText(17040536), this.mHandler.obtainMessage(FORCE_QUIT_AND_REPORT));
        }
        setTitle(res.getText(17040527));
        LayoutParams attrs = getWindow().getAttributes();
        attrs.setTitle("Application Error: " + app.info.processName);
        attrs.privateFlags |= InputManagerService.BTN_MOUSE;
        getWindow().setAttributes(attrs);
        if (app.persistent) {
            getWindow().setType(2010);
        }
        this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(FORCE_QUIT), DISMISS_TIMEOUT);
    }
}
