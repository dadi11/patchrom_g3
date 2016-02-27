package com.android.server.location;

import android.content.Context;
import android.hardware.location.ActivityRecognitionHardware;
import android.hardware.location.IActivityRecognitionHardwareWatcher;
import android.hardware.location.IActivityRecognitionHardwareWatcher.Stub;
import android.os.Handler;
import android.os.RemoteException;
import android.util.Log;
import com.android.server.ServiceWatcher;

public class ActivityRecognitionProxy {
    private static final String TAG = "ActivityRecognitionProxy";
    private final ActivityRecognitionHardware mActivityRecognitionHardware;
    private final ServiceWatcher mServiceWatcher;

    /* renamed from: com.android.server.location.ActivityRecognitionProxy.1 */
    class C03381 implements Runnable {
        C03381() {
        }

        public void run() {
            ActivityRecognitionProxy.this.bindProvider(ActivityRecognitionProxy.this.mActivityRecognitionHardware);
        }
    }

    private ActivityRecognitionProxy(Context context, Handler handler, ActivityRecognitionHardware activityRecognitionHardware, int overlaySwitchResId, int defaultServicePackageNameResId, int initialPackageNameResId) {
        this.mActivityRecognitionHardware = activityRecognitionHardware;
        Context context2 = context;
        this.mServiceWatcher = new ServiceWatcher(context2, TAG, "com.android.location.service.ActivityRecognitionProvider", overlaySwitchResId, defaultServicePackageNameResId, initialPackageNameResId, new C03381(), handler);
    }

    public static ActivityRecognitionProxy createAndBind(Context context, Handler handler, ActivityRecognitionHardware activityRecognitionHardware, int overlaySwitchResId, int defaultServicePackageNameResId, int initialPackageNameResId) {
        ActivityRecognitionProxy activityRecognitionProxy = new ActivityRecognitionProxy(context, handler, activityRecognitionHardware, overlaySwitchResId, defaultServicePackageNameResId, initialPackageNameResId);
        if (activityRecognitionProxy.mServiceWatcher.start()) {
            return activityRecognitionProxy;
        }
        Log.e(TAG, "ServiceWatcher could not start.");
        return null;
    }

    private void bindProvider(ActivityRecognitionHardware activityRecognitionHardware) {
        IActivityRecognitionHardwareWatcher watcher = Stub.asInterface(this.mServiceWatcher.getBinder());
        if (watcher == null) {
            Log.e(TAG, "No provider instance found on connection.");
            return;
        }
        try {
            watcher.onInstanceChanged(this.mActivityRecognitionHardware);
        } catch (RemoteException e) {
            Log.e(TAG, "Error delivering hardware interface.", e);
        }
    }
}
