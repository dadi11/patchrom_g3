package com.android.server.am;

import android.content.Context;
import android.content.res.Resources;
import android.os.Handler;
import android.os.Message;

final class StrictModeViolationDialog extends BaseErrorDialog {
    static final int ACTION_OK = 0;
    static final int ACTION_OK_AND_REPORT = 1;
    static final long DISMISS_TIMEOUT = 60000;
    private static final String TAG = "StrictModeViolationDialog";
    private final Handler mHandler;
    private final ProcessRecord mProc;
    private final AppErrorResult mResult;
    private final ActivityManagerService mService;

    /* renamed from: com.android.server.am.StrictModeViolationDialog.1 */
    class C01501 extends Handler {
        C01501() {
        }

        public void handleMessage(Message msg) {
            synchronized (StrictModeViolationDialog.this.mService) {
                if (StrictModeViolationDialog.this.mProc != null && StrictModeViolationDialog.this.mProc.crashDialog == StrictModeViolationDialog.this) {
                    StrictModeViolationDialog.this.mProc.crashDialog = null;
                }
            }
            StrictModeViolationDialog.this.mResult.set(msg.what);
            StrictModeViolationDialog.this.dismiss();
        }
    }

    public StrictModeViolationDialog(Context context, ActivityManagerService service, AppErrorResult result, ProcessRecord app) {
        super(context);
        this.mHandler = new C01501();
        Resources res = context.getResources();
        this.mService = service;
        this.mProc = app;
        this.mResult = result;
        if (app.pkgList.size() != ACTION_OK_AND_REPORT || context.getPackageManager().getApplicationLabel(app.info) == null) {
            Object[] objArr = new Object[ACTION_OK_AND_REPORT];
            objArr[ACTION_OK] = app.processName.toString();
            setMessage(res.getString(17040546, objArr));
        } else {
            setMessage(res.getString(17040545, new Object[]{context.getPackageManager().getApplicationLabel(app.info).toString(), app.info.processName}));
        }
        setCancelable(false);
        setButton(-1, res.getText(17040645), this.mHandler.obtainMessage(ACTION_OK));
        if (app.errorReportReceiver != null) {
            setButton(-2, res.getText(17040536), this.mHandler.obtainMessage(ACTION_OK_AND_REPORT));
        }
        setTitle(res.getText(17040527));
        getWindow().addPrivateFlags(DumpState.DUMP_VERIFIERS);
        getWindow().setTitle("Strict Mode Violation: " + app.info.processName);
        this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(ACTION_OK), DISMISS_TIMEOUT);
    }
}
