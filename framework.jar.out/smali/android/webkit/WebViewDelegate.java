package android.webkit;

import android.app.ActivityThread;
import android.app.Application;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.net.http.ErrorStrings;
import android.os.SystemProperties;
import android.os.Trace;
import android.util.SparseArray;
import android.view.HardwareCanvas;
import android.view.View;
import android.view.ViewRootImpl;

public final class WebViewDelegate {

    /* renamed from: android.webkit.WebViewDelegate.1 */
    class C09121 implements Runnable {
        final /* synthetic */ OnTraceEnabledChangeListener val$listener;

        C09121(OnTraceEnabledChangeListener onTraceEnabledChangeListener) {
            this.val$listener = onTraceEnabledChangeListener;
        }

        public void run() {
            this.val$listener.onTraceEnabledChange(WebViewDelegate.this.isTraceTagEnabled());
        }
    }

    public interface OnTraceEnabledChangeListener {
        void onTraceEnabledChange(boolean z);
    }

    WebViewDelegate() {
    }

    public void setOnTraceEnabledChangeListener(OnTraceEnabledChangeListener listener) {
        SystemProperties.addChangeCallback(new C09121(listener));
    }

    public boolean isTraceTagEnabled() {
        return Trace.isTagEnabled(16);
    }

    public boolean canInvokeDrawGlFunctor(View containerView) {
        return containerView.getViewRootImpl() != null;
    }

    public void invokeDrawGlFunctor(View containerView, long nativeDrawGLFunctor, boolean waitForCompletion) {
        containerView.getViewRootImpl().invokeFunctor(nativeDrawGLFunctor, waitForCompletion);
    }

    public void callDrawGlFunction(Canvas canvas, long nativeDrawGLFunctor) {
        if (canvas instanceof HardwareCanvas) {
            ((HardwareCanvas) canvas).callDrawGLFunction2(nativeDrawGLFunctor);
            return;
        }
        throw new IllegalArgumentException(canvas.getClass().getName() + " is not hardware accelerated");
    }

    public void detachDrawGlFunctor(View containerView, long nativeDrawGLFunctor) {
        ViewRootImpl viewRootImpl = containerView.getViewRootImpl();
        if (nativeDrawGLFunctor != 0 && viewRootImpl != null) {
            viewRootImpl.detachFunctor(nativeDrawGLFunctor);
        }
    }

    public int getPackageId(Resources resources, String packageName) {
        SparseArray<String> packageIdentifiers = resources.getAssets().getAssignedPackageIdentifiers();
        for (int i = 0; i < packageIdentifiers.size(); i++) {
            if (packageName.equals((String) packageIdentifiers.valueAt(i))) {
                return packageIdentifiers.keyAt(i);
            }
        }
        throw new RuntimeException("Package not found: " + packageName);
    }

    public Application getApplication() {
        return ActivityThread.currentApplication();
    }

    public String getErrorString(Context context, int errorCode) {
        return ErrorStrings.getString(errorCode, context);
    }

    public void addWebViewAssetPath(Context context) {
        context.getAssets().addAssetPath(WebViewFactory.getLoadedPackageInfo().applicationInfo.sourceDir);
    }
}
