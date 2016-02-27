package com.android.server;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.RecoverySystem;
import android.util.Log;
import android.util.Slog;
import java.io.IOException;

public class MasterClearReceiver extends BroadcastReceiver {
    private static final String TAG = "MasterClear";

    /* renamed from: com.android.server.MasterClearReceiver.1 */
    class C00571 extends Thread {
        final /* synthetic */ Context val$context;
        final /* synthetic */ String val$reason;
        final /* synthetic */ boolean val$shutdown;

        C00571(String x0, Context context, boolean z, String str) {
            this.val$context = context;
            this.val$shutdown = z;
            this.val$reason = str;
            super(x0);
        }

        public void run() {
            try {
                RecoverySystem.rebootWipeUserData(this.val$context, this.val$shutdown, this.val$reason);
                Log.wtf(MasterClearReceiver.TAG, "Still running after master clear?!");
            } catch (IOException e) {
                Slog.e(MasterClearReceiver.TAG, "Can't perform master clear/factory reset", e);
            } catch (SecurityException e2) {
                Slog.e(MasterClearReceiver.TAG, "Can't perform master clear/factory reset", e2);
            }
        }
    }

    public void onReceive(Context context, Intent intent) {
        if (!intent.getAction().equals("com.google.android.c2dm.intent.RECEIVE") || "google.com".equals(intent.getStringExtra("from"))) {
            boolean shutdown = intent.getBooleanExtra("shutdown", false);
            String reason = intent.getStringExtra("android.intent.extra.REASON");
            Slog.w(TAG, "!!! FACTORY RESET !!!");
            new C00571("Reboot", context, shutdown, reason).start();
            return;
        }
        Slog.w(TAG, "Ignoring master clear request -- not from trusted server.");
    }
}
