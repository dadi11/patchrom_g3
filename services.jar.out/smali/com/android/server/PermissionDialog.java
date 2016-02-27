package com.android.server;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.Resources;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.WindowManager.LayoutParams;
import android.widget.CheckBox;
import android.widget.TextView;
import com.android.server.input.InputManagerService;

public class PermissionDialog extends BasePermissionDialog {
    static final int ACTION_ALLOWED = 2;
    static final int ACTION_IGNORED = 4;
    static final int ACTION_IGNORED_TIMEOUT = 8;
    static final long DISMISS_TIMEOUT = 15000;
    private static final String TAG = "PermissionDialog";
    private CheckBox mChoice;
    private final int mCode;
    private Context mContext;
    private final Handler mHandler;
    final CharSequence[] mOpLabels;
    private final String mPackageName;
    private final AppOpsService mService;
    private int mUid;
    private View mView;

    /* renamed from: com.android.server.PermissionDialog.1 */
    class C00761 extends Handler {
        C00761() {
        }

        public void handleMessage(Message msg) {
            int mode;
            boolean remember = PermissionDialog.this.mChoice.isChecked();
            switch (msg.what) {
                case PermissionDialog.ACTION_ALLOWED /*2*/:
                    mode = 0;
                    break;
                case PermissionDialog.ACTION_IGNORED /*4*/:
                    mode = 1;
                    break;
                default:
                    mode = 1;
                    remember = false;
                    break;
            }
            PermissionDialog.this.mService.notifyOperation(PermissionDialog.this.mCode, PermissionDialog.this.mUid, PermissionDialog.this.mPackageName, mode, remember);
            PermissionDialog.this.dismiss();
        }
    }

    public PermissionDialog(Context context, AppOpsService service, int code, int uid, String packageName) {
        super(context);
        this.mHandler = new C00761();
        this.mContext = context;
        Resources res = context.getResources();
        this.mService = service;
        this.mCode = code;
        this.mPackageName = packageName;
        this.mUid = uid;
        this.mOpLabels = res.getTextArray(17236034);
        setCancelable(false);
        setButton(-1, res.getString(17040717), this.mHandler.obtainMessage(ACTION_ALLOWED));
        setButton(-2, res.getString(17040718), this.mHandler.obtainMessage(ACTION_IGNORED));
        setTitle(res.getString(17041072));
        LayoutParams attrs = getWindow().getAttributes();
        attrs.setTitle("Permission info: " + getAppName(this.mPackageName));
        attrs.privateFlags |= InputManagerService.BTN_MOUSE;
        getWindow().setAttributes(attrs);
        this.mView = getLayoutInflater().inflate(17367177, null);
        TextView tv = (TextView) this.mView.findViewById(16909135);
        this.mChoice = (CheckBox) this.mView.findViewById(16909137);
        String name = getAppName(this.mPackageName);
        if (name == null) {
            name = this.mPackageName;
        }
        tv.setText(name + ": " + this.mOpLabels[this.mCode]);
        setView(this.mView);
        this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(ACTION_IGNORED_TIMEOUT), DISMISS_TIMEOUT);
    }

    private String getAppName(String packageName) {
        PackageManager pm = this.mContext.getPackageManager();
        try {
            ApplicationInfo appInfo = pm.getApplicationInfo(packageName, 8704);
            if (appInfo != null) {
                return (String) pm.getApplicationLabel(appInfo);
            }
            return null;
        } catch (NameNotFoundException e) {
            return null;
        }
    }
}
