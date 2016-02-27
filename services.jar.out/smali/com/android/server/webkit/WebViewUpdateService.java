package com.android.server.webkit;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Binder;
import android.os.Process;
import android.util.Slog;
import android.webkit.IWebViewUpdateService.Stub;
import android.webkit.WebViewFactory;
import com.android.server.SystemService;

public class WebViewUpdateService extends SystemService {
    private static final String TAG = "WebViewUpdateService";
    private static final int WAIT_TIMEOUT_MS = 5000;
    private boolean mRelroReady32Bit;
    private boolean mRelroReady64Bit;
    private BroadcastReceiver mWebViewUpdatedReceiver;

    /* renamed from: com.android.server.webkit.WebViewUpdateService.1 */
    class C05571 extends BroadcastReceiver {
        C05571() {
        }

        public void onReceive(Context context, Intent intent) {
            if (("package:" + WebViewFactory.getWebViewPackageName()).equals(intent.getDataString())) {
                WebViewUpdateService.this.onWebViewUpdateInstalled();
            }
        }
    }

    private class BinderService extends Stub {
        private BinderService() {
        }

        public void notifyRelroCreationCompleted(boolean is64Bit, boolean success) {
            if (Binder.getCallingUid() == 1037 || Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                synchronized (WebViewUpdateService.this) {
                    if (is64Bit) {
                        WebViewUpdateService.this.mRelroReady64Bit = true;
                    } else {
                        WebViewUpdateService.this.mRelroReady32Bit = true;
                    }
                    WebViewUpdateService.this.notifyAll();
                }
            }
        }

        public void waitForRelroCreationCompleted(boolean is64Bit) {
            if (Binder.getCallingPid() == Process.myPid()) {
                throw new IllegalStateException("Cannot create a WebView from the SystemServer");
            }
            long timeoutTimeMs = (System.nanoTime() / 1000000) + 5000;
            boolean relroReady = is64Bit ? WebViewUpdateService.this.mRelroReady64Bit : WebViewUpdateService.this.mRelroReady32Bit;
            synchronized (WebViewUpdateService.this) {
                while (!relroReady) {
                    long timeNowMs = System.nanoTime() / 1000000;
                    if (timeNowMs >= timeoutTimeMs) {
                        break;
                    }
                    try {
                        WebViewUpdateService.this.wait(timeoutTimeMs - timeNowMs);
                    } catch (InterruptedException e) {
                    }
                    relroReady = is64Bit ? WebViewUpdateService.this.mRelroReady64Bit : WebViewUpdateService.this.mRelroReady32Bit;
                }
            }
            if (!relroReady) {
                Slog.w(WebViewUpdateService.TAG, "creating relro file timed out");
            }
        }
    }

    public WebViewUpdateService(Context context) {
        super(context);
        this.mRelroReady32Bit = false;
        this.mRelroReady64Bit = false;
    }

    public void onStart() {
        this.mWebViewUpdatedReceiver = new C05571();
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.PACKAGE_REPLACED");
        filter.addDataScheme("package");
        getContext().registerReceiver(this.mWebViewUpdatedReceiver, filter);
        publishBinderService("webviewupdate", new BinderService());
    }

    private void onWebViewUpdateInstalled() {
        Slog.d(TAG, "WebView Package updated!");
        synchronized (this) {
            this.mRelroReady32Bit = false;
            this.mRelroReady64Bit = false;
        }
        WebViewFactory.onWebViewUpdateInstalled();
    }
}
