package android.telecom;

import android.os.Handler;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.telecom.InCallService.VideoCall;
import android.telecom.InCallService.VideoCall.Listener;
import android.view.Surface;
import com.android.internal.os.SomeArgs;
import com.android.internal.telecom.IVideoCallback.Stub;
import com.android.internal.telecom.IVideoProvider;

public class VideoCallImpl extends VideoCall {
    private static final int MSG_CHANGE_CALL_DATA_USAGE = 5;
    private static final int MSG_CHANGE_CAMERA_CAPABILITIES = 6;
    private static final int MSG_CHANGE_PEER_DIMENSIONS = 4;
    private static final int MSG_HANDLE_CALL_SESSION_EVENT = 3;
    private static final int MSG_RECEIVE_SESSION_MODIFY_REQUEST = 1;
    private static final int MSG_RECEIVE_SESSION_MODIFY_RESPONSE = 2;
    private final VideoCallListenerBinder mBinder;
    private DeathRecipient mDeathRecipient;
    private final Handler mHandler;
    private Listener mVideoCallListener;
    private final IVideoProvider mVideoProvider;

    /* renamed from: android.telecom.VideoCallImpl.1 */
    class C07591 implements DeathRecipient {
        C07591() {
        }

        public void binderDied() {
            VideoCallImpl.this.mVideoProvider.asBinder().unlinkToDeath(this, 0);
        }
    }

    /* renamed from: android.telecom.VideoCallImpl.2 */
    class C07602 extends Handler {
        C07602(Looper x0) {
            super(x0);
        }

        public void handleMessage(Message msg) {
            SomeArgs args;
            if (VideoCallImpl.this.mVideoCallListener != null) {
                switch (msg.what) {
                    case VideoCallImpl.MSG_RECEIVE_SESSION_MODIFY_REQUEST /*1*/:
                        VideoCallImpl.this.mVideoCallListener.onSessionModifyRequestReceived((VideoProfile) msg.obj);
                    case VideoCallImpl.MSG_RECEIVE_SESSION_MODIFY_RESPONSE /*2*/:
                        args = msg.obj;
                        try {
                            VideoCallImpl.this.mVideoCallListener.onSessionModifyResponseReceived(((Integer) args.arg1).intValue(), args.arg2, args.arg3);
                        } finally {
                            args.recycle();
                        }
                    case VideoCallImpl.MSG_HANDLE_CALL_SESSION_EVENT /*3*/:
                        VideoCallImpl.this.mVideoCallListener.onCallSessionEvent(((Integer) msg.obj).intValue());
                    case VideoCallImpl.MSG_CHANGE_PEER_DIMENSIONS /*4*/:
                        args = (SomeArgs) msg.obj;
                        try {
                            VideoCallImpl.this.mVideoCallListener.onPeerDimensionsChanged(((Integer) args.arg1).intValue(), ((Integer) args.arg2).intValue());
                        } finally {
                            args.recycle();
                        }
                    case VideoCallImpl.MSG_CHANGE_CALL_DATA_USAGE /*5*/:
                        VideoCallImpl.this.mVideoCallListener.onCallDataUsageChanged(msg.arg1);
                    case VideoCallImpl.MSG_CHANGE_CAMERA_CAPABILITIES /*6*/:
                        VideoCallImpl.this.mVideoCallListener.onCameraCapabilitiesChanged((CameraCapabilities) msg.obj);
                    default:
                }
            }
        }
    }

    private final class VideoCallListenerBinder extends Stub {
        private VideoCallListenerBinder() {
        }

        public void receiveSessionModifyRequest(VideoProfile videoProfile) {
            VideoCallImpl.this.mHandler.obtainMessage(VideoCallImpl.MSG_RECEIVE_SESSION_MODIFY_REQUEST, videoProfile).sendToTarget();
        }

        public void receiveSessionModifyResponse(int status, VideoProfile requestProfile, VideoProfile responseProfile) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = Integer.valueOf(status);
            args.arg2 = requestProfile;
            args.arg3 = responseProfile;
            VideoCallImpl.this.mHandler.obtainMessage(VideoCallImpl.MSG_RECEIVE_SESSION_MODIFY_RESPONSE, args).sendToTarget();
        }

        public void handleCallSessionEvent(int event) {
            VideoCallImpl.this.mHandler.obtainMessage(VideoCallImpl.MSG_HANDLE_CALL_SESSION_EVENT, Integer.valueOf(event)).sendToTarget();
        }

        public void changePeerDimensions(int width, int height) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = Integer.valueOf(width);
            args.arg2 = Integer.valueOf(height);
            VideoCallImpl.this.mHandler.obtainMessage(VideoCallImpl.MSG_CHANGE_PEER_DIMENSIONS, args).sendToTarget();
        }

        public void changeCallDataUsage(int dataUsage) {
            VideoCallImpl.this.mHandler.obtainMessage(VideoCallImpl.MSG_CHANGE_CALL_DATA_USAGE, Integer.valueOf(dataUsage)).sendToTarget();
        }

        public void changeCameraCapabilities(CameraCapabilities cameraCapabilities) {
            VideoCallImpl.this.mHandler.obtainMessage(VideoCallImpl.MSG_CHANGE_CAMERA_CAPABILITIES, cameraCapabilities).sendToTarget();
        }
    }

    VideoCallImpl(IVideoProvider videoProvider) throws RemoteException {
        this.mDeathRecipient = new C07591();
        this.mHandler = new C07602(Looper.getMainLooper());
        this.mVideoProvider = videoProvider;
        this.mVideoProvider.asBinder().linkToDeath(this.mDeathRecipient, 0);
        this.mBinder = new VideoCallListenerBinder();
        this.mVideoProvider.setVideoCallback(this.mBinder);
    }

    public void setVideoCallListener(Listener videoCallListener) {
        this.mVideoCallListener = videoCallListener;
    }

    public void setCamera(String cameraId) {
        try {
            this.mVideoProvider.setCamera(cameraId);
        } catch (RemoteException e) {
        }
    }

    public void setPreviewSurface(Surface surface) {
        try {
            this.mVideoProvider.setPreviewSurface(surface);
        } catch (RemoteException e) {
        }
    }

    public void setDisplaySurface(Surface surface) {
        try {
            this.mVideoProvider.setDisplaySurface(surface);
        } catch (RemoteException e) {
        }
    }

    public void setDeviceOrientation(int rotation) {
        try {
            this.mVideoProvider.setDeviceOrientation(rotation);
        } catch (RemoteException e) {
        }
    }

    public void setZoom(float value) {
        try {
            this.mVideoProvider.setZoom(value);
        } catch (RemoteException e) {
        }
    }

    public void sendSessionModifyRequest(VideoProfile requestProfile) {
        try {
            this.mVideoProvider.sendSessionModifyRequest(requestProfile);
        } catch (RemoteException e) {
        }
    }

    public void sendSessionModifyResponse(VideoProfile responseProfile) {
        try {
            this.mVideoProvider.sendSessionModifyResponse(responseProfile);
        } catch (RemoteException e) {
        }
    }

    public void requestCameraCapabilities() {
        try {
            this.mVideoProvider.requestCameraCapabilities();
        } catch (RemoteException e) {
        }
    }

    public void requestCallDataUsage() {
        try {
            this.mVideoProvider.requestCallDataUsage();
        } catch (RemoteException e) {
        }
    }

    public void setPauseImage(String uri) {
        try {
            this.mVideoProvider.setPauseImage(uri);
        } catch (RemoteException e) {
        }
    }
}
