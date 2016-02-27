package com.android.server.am;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Handler;
import android.os.Message;
import android.util.Slog;
import android.view.WindowManager.LayoutParams;
import com.android.server.input.InputManagerService;

final class AppNotRespondingDialog extends BaseErrorDialog {
    static final int FORCE_CLOSE = 1;
    private static final String TAG = "AppNotRespondingDialog";
    static final int WAIT = 2;
    static final int WAIT_AND_REPORT = 3;
    private final Handler mHandler;
    private final ProcessRecord mProc;
    private final ActivityManagerService mService;

    /* renamed from: com.android.server.am.AppNotRespondingDialog.1 */
    class C01351 extends Handler {
        C01351() {
        }

        public void handleMessage(Message msg) {
            Intent appErrorIntent = null;
            switch (msg.what) {
                case AppNotRespondingDialog.FORCE_CLOSE /*1*/:
                    AppNotRespondingDialog.this.mService.killAppAtUsersRequest(AppNotRespondingDialog.this.mProc, AppNotRespondingDialog.this);
                    break;
                case AppNotRespondingDialog.WAIT /*2*/:
                case AppNotRespondingDialog.WAIT_AND_REPORT /*3*/:
                    synchronized (AppNotRespondingDialog.this.mService) {
                        ProcessRecord app = AppNotRespondingDialog.this.mProc;
                        if (msg.what == AppNotRespondingDialog.WAIT_AND_REPORT) {
                            appErrorIntent = AppNotRespondingDialog.this.mService.createAppErrorIntentLocked(app, System.currentTimeMillis(), null);
                        }
                        app.notResponding = false;
                        app.notRespondingReport = null;
                        if (app.anrDialog == AppNotRespondingDialog.this) {
                            app.anrDialog = null;
                        }
                        AppNotRespondingDialog.this.mService.mServices.scheduleServiceTimeoutLocked(app);
                        break;
                    }
                    break;
            }
            if (appErrorIntent != null) {
                try {
                    AppNotRespondingDialog.this.getContext().startActivity(appErrorIntent);
                } catch (ActivityNotFoundException e) {
                    Slog.w(AppNotRespondingDialog.TAG, "bug report receiver dissappeared", e);
                }
            }
        }
    }

    public AppNotRespondingDialog(ActivityManagerService service, Context context, ProcessRecord app, ActivityRecord activity, boolean aboveSystem) {
        int resid;
        Object[] objArr;
        CharSequence string;
        LayoutParams attrs;
        super(context);
        this.mHandler = new C01351();
        this.mService = service;
        this.mProc = app;
        Resources res = context.getResources();
        setCancelable(false);
        CharSequence name1 = activity != null ? activity.info.loadLabel(context.getPackageManager()) : null;
        CharSequence charSequence = null;
        if (app.pkgList.size() == FORCE_CLOSE) {
            charSequence = context.getPackageManager().getApplicationLabel(app.info);
            if (charSequence != null) {
                if (name1 != null) {
                    resid = 17040531;
                } else {
                    name1 = charSequence;
                    charSequence = app.processName;
                    resid = 17040533;
                }
                if (charSequence == null) {
                    objArr = new Object[WAIT];
                    objArr[0] = name1.toString();
                    objArr[FORCE_CLOSE] = charSequence.toString();
                    string = res.getString(resid, objArr);
                } else {
                    objArr = new Object[FORCE_CLOSE];
                    objArr[0] = name1.toString();
                    string = res.getString(resid, objArr);
                }
                setMessage(string);
                setButton(-1, res.getText(17040535), this.mHandler.obtainMessage(FORCE_CLOSE));
                setButton(-2, res.getText(17040537), this.mHandler.obtainMessage(WAIT));
                if (app.errorReportReceiver != null) {
                    setButton(-3, res.getText(17040536), this.mHandler.obtainMessage(WAIT_AND_REPORT));
                }
                setTitle(res.getText(17040530));
                if (aboveSystem) {
                    getWindow().setType(2010);
                }
                attrs = getWindow().getAttributes();
                attrs.setTitle("Application Not Responding: " + app.info.processName);
                attrs.privateFlags = InputManagerService.BTN_MOUSE;
                getWindow().setAttributes(attrs);
            }
        }
        if (name1 != null) {
            charSequence = app.processName;
            resid = 17040532;
        } else {
            name1 = app.processName;
            resid = 17040534;
        }
        if (charSequence == null) {
            objArr = new Object[FORCE_CLOSE];
            objArr[0] = name1.toString();
            string = res.getString(resid, objArr);
        } else {
            objArr = new Object[WAIT];
            objArr[0] = name1.toString();
            objArr[FORCE_CLOSE] = charSequence.toString();
            string = res.getString(resid, objArr);
        }
        setMessage(string);
        setButton(-1, res.getText(17040535), this.mHandler.obtainMessage(FORCE_CLOSE));
        setButton(-2, res.getText(17040537), this.mHandler.obtainMessage(WAIT));
        if (app.errorReportReceiver != null) {
            setButton(-3, res.getText(17040536), this.mHandler.obtainMessage(WAIT_AND_REPORT));
        }
        setTitle(res.getText(17040530));
        if (aboveSystem) {
            getWindow().setType(2010);
        }
        attrs = getWindow().getAttributes();
        attrs.setTitle("Application Not Responding: " + app.info.processName);
        attrs.privateFlags = InputManagerService.BTN_MOUSE;
        getWindow().setAttributes(attrs);
    }

    public void onStop() {
    }
}
