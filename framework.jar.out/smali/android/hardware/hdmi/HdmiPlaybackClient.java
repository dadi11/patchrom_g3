package android.hardware.hdmi;

import android.hardware.hdmi.IHdmiControlCallback.Stub;
import android.os.RemoteException;
import android.util.Log;

public final class HdmiPlaybackClient extends HdmiClient {
    private static final String TAG = "HdmiPlaybackClient";

    /* renamed from: android.hardware.hdmi.HdmiPlaybackClient.1 */
    class C02851 extends Stub {
        final /* synthetic */ OneTouchPlayCallback val$callback;

        C02851(OneTouchPlayCallback oneTouchPlayCallback) {
            this.val$callback = oneTouchPlayCallback;
        }

        public void onComplete(int result) {
            this.val$callback.onComplete(result);
        }
    }

    /* renamed from: android.hardware.hdmi.HdmiPlaybackClient.2 */
    class C02862 extends Stub {
        final /* synthetic */ DisplayStatusCallback val$callback;

        C02862(DisplayStatusCallback displayStatusCallback) {
            this.val$callback = displayStatusCallback;
        }

        public void onComplete(int status) {
            this.val$callback.onComplete(status);
        }
    }

    public interface DisplayStatusCallback {
        void onComplete(int i);
    }

    public interface OneTouchPlayCallback {
        void onComplete(int i);
    }

    HdmiPlaybackClient(IHdmiControlService service) {
        super(service);
    }

    public void oneTouchPlay(OneTouchPlayCallback callback) {
        try {
            this.mService.oneTouchPlay(getCallbackWrapper(callback));
        } catch (RemoteException e) {
            Log.e(TAG, "oneTouchPlay threw exception ", e);
        }
    }

    public int getDeviceType() {
        return 4;
    }

    public void queryDisplayStatus(DisplayStatusCallback callback) {
        try {
            this.mService.queryDisplayStatus(getCallbackWrapper(callback));
        } catch (RemoteException e) {
            Log.e(TAG, "queryDisplayStatus threw exception ", e);
        }
    }

    private IHdmiControlCallback getCallbackWrapper(OneTouchPlayCallback callback) {
        return new C02851(callback);
    }

    private IHdmiControlCallback getCallbackWrapper(DisplayStatusCallback callback) {
        return new C02862(callback);
    }
}
