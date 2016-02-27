package com.android.server;

import android.app.AlertDialog;
import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.view.KeyEvent;
import android.view.WindowManager.LayoutParams;
import android.widget.Button;

public class BasePermissionDialog extends AlertDialog {
    private boolean mConsuming;
    private Handler mHandler;

    /* renamed from: com.android.server.BasePermissionDialog.1 */
    class C00071 extends Handler {
        C00071() {
        }

        public void handleMessage(Message msg) {
            if (msg.what == 0) {
                BasePermissionDialog.this.mConsuming = false;
                BasePermissionDialog.this.setEnabled(true);
            }
        }
    }

    public BasePermissionDialog(Context context) {
        super(context, 16974979);
        this.mHandler = new C00071();
        this.mConsuming = true;
        getWindow().setType(2003);
        getWindow().setFlags(131072, 131072);
        LayoutParams attrs = getWindow().getAttributes();
        attrs.setTitle("Permission Dialog");
        getWindow().setAttributes(attrs);
        setIconAttribute(16843605);
    }

    public void onStart() {
        super.onStart();
        setEnabled(false);
        this.mHandler.sendMessage(this.mHandler.obtainMessage(0));
    }

    public boolean dispatchKeyEvent(KeyEvent event) {
        if (this.mConsuming) {
            return true;
        }
        return super.dispatchKeyEvent(event);
    }

    private void setEnabled(boolean enabled) {
        Button b = (Button) findViewById(16908313);
        if (b != null) {
            b.setEnabled(enabled);
        }
        b = (Button) findViewById(16908314);
        if (b != null) {
            b.setEnabled(enabled);
        }
        b = (Button) findViewById(16908315);
        if (b != null) {
            b.setEnabled(enabled);
        }
    }
}
