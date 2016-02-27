package com.android.server.am;

import android.app.AlertDialog;
import android.content.Context;
import android.content.res.Resources;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewTreeObserver.OnWindowShownListener;
import android.view.WindowManager.LayoutParams;
import android.widget.TextView;
import com.android.server.input.InputManagerService;

final class UserSwitchingDialog extends AlertDialog implements OnWindowShownListener {
    private static final String TAG = "ActivityManagerUserSwitchingDialog";
    private final ActivityManagerService mService;
    private final int mUserId;

    public UserSwitchingDialog(ActivityManagerService service, Context context, int userId, String userName, boolean aboveSystem) {
        super(context);
        this.mService = service;
        this.mUserId = userId;
        setCancelable(false);
        Resources res = getContext().getResources();
        View view = LayoutInflater.from(getContext()).inflate(17367273, null);
        ((TextView) view.findViewById(16908299)).setText(res.getString(17040924, new Object[]{userName}));
        setView(view);
        if (aboveSystem) {
            getWindow().setType(2010);
        }
        LayoutParams attrs = getWindow().getAttributes();
        attrs.privateFlags = InputManagerService.BTN_MOUSE;
        getWindow().setAttributes(attrs);
    }

    public void show() {
        super.show();
        View decorView = getWindow().getDecorView();
        if (decorView != null) {
            decorView.getViewTreeObserver().addOnWindowShownListener(this);
        }
    }

    public void onWindowShown() {
        this.mService.startUserInForeground(this.mUserId, this);
        View decorView = getWindow().getDecorView();
        if (decorView != null) {
            decorView.getViewTreeObserver().removeOnWindowShownListener(this);
        }
    }
}
