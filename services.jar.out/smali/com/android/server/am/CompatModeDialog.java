package com.android.server.am;

import android.app.Dialog;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.Switch;

public final class CompatModeDialog extends Dialog {
    final CheckBox mAlwaysShow;
    final ApplicationInfo mAppInfo;
    final Switch mCompatEnabled;
    final View mHint;
    final ActivityManagerService mService;

    /* renamed from: com.android.server.am.CompatModeDialog.1 */
    class C01391 implements OnCheckedChangeListener {
        C01391() {
        }

        public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
            synchronized (CompatModeDialog.this.mService) {
                CompatModeDialog.this.mService.mCompatModePackages.setPackageScreenCompatModeLocked(CompatModeDialog.this.mAppInfo.packageName, CompatModeDialog.this.mCompatEnabled.isChecked() ? 1 : 0);
                CompatModeDialog.this.updateControls();
            }
        }
    }

    /* renamed from: com.android.server.am.CompatModeDialog.2 */
    class C01402 implements OnCheckedChangeListener {
        C01402() {
        }

        public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
            synchronized (CompatModeDialog.this.mService) {
                CompatModeDialog.this.mService.mCompatModePackages.setPackageAskCompatModeLocked(CompatModeDialog.this.mAppInfo.packageName, CompatModeDialog.this.mAlwaysShow.isChecked());
                CompatModeDialog.this.updateControls();
            }
        }
    }

    public CompatModeDialog(ActivityManagerService service, Context context, ApplicationInfo appInfo) {
        super(context, 16973936);
        setCancelable(true);
        setCanceledOnTouchOutside(true);
        getWindow().requestFeature(1);
        getWindow().setType(2002);
        getWindow().setGravity(81);
        this.mService = service;
        this.mAppInfo = appInfo;
        setContentView(17367088);
        this.mCompatEnabled = (Switch) findViewById(16909010);
        this.mCompatEnabled.setOnCheckedChangeListener(new C01391());
        this.mAlwaysShow = (CheckBox) findViewById(16909011);
        this.mAlwaysShow.setOnCheckedChangeListener(new C01402());
        this.mHint = findViewById(16909012);
        updateControls();
    }

    void updateControls() {
        boolean z = true;
        int i = 0;
        synchronized (this.mService) {
            int mode = this.mService.mCompatModePackages.computeCompatModeLocked(this.mAppInfo);
            Switch switchR = this.mCompatEnabled;
            if (mode != 1) {
                z = false;
            }
            switchR.setChecked(z);
            boolean ask = this.mService.mCompatModePackages.getPackageAskCompatModeLocked(this.mAppInfo.packageName);
            this.mAlwaysShow.setChecked(ask);
            View view = this.mHint;
            if (ask) {
                i = 4;
            }
            view.setVisibility(i);
        }
    }
}
