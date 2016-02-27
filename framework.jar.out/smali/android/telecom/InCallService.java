package android.telecom;

import android.app.Service;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.view.Surface;
import com.android.internal.os.SomeArgs;
import com.android.internal.telecom.IInCallAdapter;
import com.android.internal.telecom.IInCallService.Stub;

public abstract class InCallService extends Service {
    private static final int MSG_ADD_CALL = 2;
    private static final int MSG_BRING_TO_FOREGROUND = 6;
    private static final int MSG_ON_AUDIO_STATE_CHANGED = 5;
    private static final int MSG_ON_CAN_ADD_CALL_CHANGED = 7;
    private static final int MSG_SET_IN_CALL_ADAPTER = 1;
    private static final int MSG_SET_POST_DIAL_WAIT = 4;
    private static final int MSG_UPDATE_CALL = 3;
    public static final String SERVICE_INTERFACE = "android.telecom.InCallService";
    private final Handler mHandler;
    private Phone mPhone;

    /* renamed from: android.telecom.InCallService.1 */
    class C07471 extends Handler {
        C07471(Looper x0) {
            super(x0);
        }

        public void handleMessage(Message msg) {
            boolean z = true;
            if (InCallService.this.mPhone != null || msg.what == InCallService.MSG_SET_IN_CALL_ADAPTER) {
                Phone access$000;
                switch (msg.what) {
                    case InCallService.MSG_SET_IN_CALL_ADAPTER /*1*/:
                        InCallService.this.mPhone = new Phone(new InCallAdapter((IInCallAdapter) msg.obj));
                        InCallService.this.onPhoneCreated(InCallService.this.mPhone);
                    case InCallService.MSG_ADD_CALL /*2*/:
                        InCallService.this.mPhone.internalAddCall((ParcelableCall) msg.obj);
                    case InCallService.MSG_UPDATE_CALL /*3*/:
                        InCallService.this.mPhone.internalUpdateCall((ParcelableCall) msg.obj);
                    case InCallService.MSG_SET_POST_DIAL_WAIT /*4*/:
                        SomeArgs args = msg.obj;
                        try {
                            InCallService.this.mPhone.internalSetPostDialWait(args.arg1, args.arg2);
                        } finally {
                            args.recycle();
                        }
                    case InCallService.MSG_ON_AUDIO_STATE_CHANGED /*5*/:
                        InCallService.this.mPhone.internalAudioStateChanged((AudioState) msg.obj);
                    case InCallService.MSG_BRING_TO_FOREGROUND /*6*/:
                        access$000 = InCallService.this.mPhone;
                        if (msg.arg1 != InCallService.MSG_SET_IN_CALL_ADAPTER) {
                            z = false;
                        }
                        access$000.internalBringToForeground(z);
                    case InCallService.MSG_ON_CAN_ADD_CALL_CHANGED /*7*/:
                        access$000 = InCallService.this.mPhone;
                        if (msg.arg1 != InCallService.MSG_SET_IN_CALL_ADAPTER) {
                            z = false;
                        }
                        access$000.internalSetCanAddCall(z);
                    default:
                }
            }
        }
    }

    private final class InCallServiceBinder extends Stub {
        private InCallServiceBinder() {
        }

        public void setInCallAdapter(IInCallAdapter inCallAdapter) {
            InCallService.this.mHandler.obtainMessage(InCallService.MSG_SET_IN_CALL_ADAPTER, inCallAdapter).sendToTarget();
        }

        public void addCall(ParcelableCall call) {
            InCallService.this.mHandler.obtainMessage(InCallService.MSG_ADD_CALL, call).sendToTarget();
        }

        public void updateCall(ParcelableCall call) {
            InCallService.this.mHandler.obtainMessage(InCallService.MSG_UPDATE_CALL, call).sendToTarget();
        }

        public void setPostDial(String callId, String remaining) {
        }

        public void setPostDialWait(String callId, String remaining) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = callId;
            args.arg2 = remaining;
            InCallService.this.mHandler.obtainMessage(InCallService.MSG_SET_POST_DIAL_WAIT, args).sendToTarget();
        }

        public void onAudioStateChanged(AudioState audioState) {
            InCallService.this.mHandler.obtainMessage(InCallService.MSG_ON_AUDIO_STATE_CHANGED, audioState).sendToTarget();
        }

        public void bringToForeground(boolean showDialpad) {
            int i;
            Handler access$100 = InCallService.this.mHandler;
            if (showDialpad) {
                i = InCallService.MSG_SET_IN_CALL_ADAPTER;
            } else {
                i = 0;
            }
            access$100.obtainMessage(InCallService.MSG_BRING_TO_FOREGROUND, i, 0).sendToTarget();
        }

        public void onCanAddCallChanged(boolean canAddCall) {
            int i;
            Handler access$100 = InCallService.this.mHandler;
            if (canAddCall) {
                i = InCallService.MSG_SET_IN_CALL_ADAPTER;
            } else {
                i = 0;
            }
            access$100.obtainMessage(InCallService.MSG_ON_CAN_ADD_CALL_CHANGED, i, 0).sendToTarget();
        }
    }

    public static abstract class VideoCall {

        public static abstract class Listener {
            public abstract void onCallDataUsageChanged(int i);

            public abstract void onCallSessionEvent(int i);

            public abstract void onCameraCapabilitiesChanged(CameraCapabilities cameraCapabilities);

            public abstract void onPeerDimensionsChanged(int i, int i2);

            public abstract void onSessionModifyRequestReceived(VideoProfile videoProfile);

            public abstract void onSessionModifyResponseReceived(int i, VideoProfile videoProfile, VideoProfile videoProfile2);
        }

        public abstract void requestCallDataUsage();

        public abstract void requestCameraCapabilities();

        public abstract void sendSessionModifyRequest(VideoProfile videoProfile);

        public abstract void sendSessionModifyResponse(VideoProfile videoProfile);

        public abstract void setCamera(String str);

        public abstract void setDeviceOrientation(int i);

        public abstract void setDisplaySurface(Surface surface);

        public abstract void setPauseImage(String str);

        public abstract void setPreviewSurface(Surface surface);

        public abstract void setVideoCallListener(Listener listener);

        public abstract void setZoom(float f);
    }

    public InCallService() {
        this.mHandler = new C07471(Looper.getMainLooper());
    }

    public IBinder onBind(Intent intent) {
        return new InCallServiceBinder();
    }

    public boolean onUnbind(Intent intent) {
        if (this.mPhone != null) {
            Phone oldPhone = this.mPhone;
            this.mPhone = null;
            oldPhone.destroy();
            onPhoneDestroyed(oldPhone);
        }
        return false;
    }

    public Phone getPhone() {
        return this.mPhone;
    }

    public void onPhoneCreated(Phone phone) {
    }

    public void onPhoneDestroyed(Phone phone) {
    }
}
