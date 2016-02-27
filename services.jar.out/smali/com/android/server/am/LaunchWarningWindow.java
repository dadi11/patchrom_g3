package com.android.server.am;

import android.app.Dialog;
import android.content.Context;
import android.util.TypedValue;
import android.widget.ImageView;
import android.widget.TextView;

public final class LaunchWarningWindow extends Dialog {
    public LaunchWarningWindow(Context context, ActivityRecord cur, ActivityRecord next) {
        super(context, 16974981);
        requestWindowFeature(3);
        getWindow().setType(2003);
        getWindow().addFlags(24);
        setContentView(17367139);
        setTitle(context.getText(17040539));
        TypedValue out = new TypedValue();
        getContext().getTheme().resolveAttribute(16843605, out, true);
        getWindow().setFeatureDrawableResource(3, out.resourceId);
        ((ImageView) findViewById(16909079)).setImageDrawable(next.info.applicationInfo.loadIcon(context.getPackageManager()));
        ((TextView) findViewById(16909080)).setText(context.getResources().getString(17040540, new Object[]{next.info.applicationInfo.loadLabel(context.getPackageManager()).toString()}));
        ((ImageView) findViewById(16909081)).setImageDrawable(cur.info.applicationInfo.loadIcon(context.getPackageManager()));
        ((TextView) findViewById(16909082)).setText(context.getResources().getString(17040541, new Object[]{cur.info.applicationInfo.loadLabel(context.getPackageManager()).toString()}));
    }
}
