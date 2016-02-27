package android.media.tv;

import android.content.Context;
import android.graphics.Rect;
import android.media.tv.ITvInputSession.Stub;
import android.media.tv.TvInputService.Session;
import android.net.Uri;
import android.os.Bundle;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.util.Log;
import android.view.InputChannel;
import android.view.InputEvent;
import android.view.InputEventReceiver;
import android.view.Surface;
import com.android.internal.os.HandlerCaller;
import com.android.internal.os.HandlerCaller.Callback;
import com.android.internal.os.SomeArgs;

public class ITvInputSessionWrapper extends Stub implements Callback {
    private static final int DO_APP_PRIVATE_COMMAND = 9;
    private static final int DO_CREATE_OVERLAY_VIEW = 10;
    private static final int DO_DISPATCH_SURFACE_CHANGED = 4;
    private static final int DO_RELAYOUT_OVERLAY_VIEW = 11;
    private static final int DO_RELEASE = 1;
    private static final int DO_REMOVE_OVERLAY_VIEW = 12;
    private static final int DO_REQUEST_UNBLOCK_CONTENT = 13;
    private static final int DO_SELECT_TRACK = 8;
    private static final int DO_SET_CAPTION_ENABLED = 7;
    private static final int DO_SET_MAIN = 2;
    private static final int DO_SET_STREAM_VOLUME = 5;
    private static final int DO_SET_SURFACE = 3;
    private static final int DO_TUNE = 6;
    private static final int MESSAGE_HANDLING_DURATION_THRESHOLD_MILLIS = 50;
    private static final int MESSAGE_TUNE_DURATION_THRESHOLD_MILLIS = 2000;
    private static final String TAG = "TvInputSessionWrapper";
    private final HandlerCaller mCaller;
    private InputChannel mChannel;
    private TvInputEventReceiver mReceiver;
    private Session mTvInputSessionImpl;

    private final class TvInputEventReceiver extends InputEventReceiver {
        public TvInputEventReceiver(InputChannel inputChannel, Looper looper) {
            super(inputChannel, looper);
        }

        public void onInputEvent(InputEvent event) {
            boolean z = true;
            if (ITvInputSessionWrapper.this.mTvInputSessionImpl == null) {
                finishInputEvent(event, false);
                return;
            }
            int handled = ITvInputSessionWrapper.this.mTvInputSessionImpl.dispatchInputEvent(event, this);
            if (handled != -1) {
                if (handled != ITvInputSessionWrapper.DO_RELEASE) {
                    z = false;
                }
                finishInputEvent(event, z);
            }
        }
    }

    public ITvInputSessionWrapper(Context context, Session sessionImpl, InputChannel channel) {
        this.mCaller = new HandlerCaller(context, null, this, true);
        this.mTvInputSessionImpl = sessionImpl;
        this.mChannel = channel;
        if (channel != null) {
            this.mReceiver = new TvInputEventReceiver(channel, context.getMainLooper());
        }
    }

    public void executeMessage(Message msg) {
        if (this.mTvInputSessionImpl != null) {
            long startTime = System.currentTimeMillis();
            SomeArgs args;
            switch (msg.what) {
                case DO_RELEASE /*1*/:
                    this.mTvInputSessionImpl.release();
                    this.mTvInputSessionImpl = null;
                    if (this.mReceiver != null) {
                        this.mReceiver.dispose();
                        this.mReceiver = null;
                    }
                    if (this.mChannel != null) {
                        this.mChannel.dispose();
                        this.mChannel = null;
                        break;
                    }
                    break;
                case DO_SET_MAIN /*2*/:
                    this.mTvInputSessionImpl.setMain(((Boolean) msg.obj).booleanValue());
                    break;
                case DO_SET_SURFACE /*3*/:
                    this.mTvInputSessionImpl.setSurface((Surface) msg.obj);
                    break;
                case DO_DISPATCH_SURFACE_CHANGED /*4*/:
                    args = msg.obj;
                    this.mTvInputSessionImpl.dispatchSurfaceChanged(args.argi1, args.argi2, args.argi3);
                    args.recycle();
                    break;
                case DO_SET_STREAM_VOLUME /*5*/:
                    this.mTvInputSessionImpl.setStreamVolume(((Float) msg.obj).floatValue());
                    break;
                case DO_TUNE /*6*/:
                    args = (SomeArgs) msg.obj;
                    this.mTvInputSessionImpl.tune((Uri) args.arg1, (Bundle) args.arg2);
                    args.recycle();
                    break;
                case DO_SET_CAPTION_ENABLED /*7*/:
                    this.mTvInputSessionImpl.setCaptionEnabled(((Boolean) msg.obj).booleanValue());
                    break;
                case DO_SELECT_TRACK /*8*/:
                    args = (SomeArgs) msg.obj;
                    this.mTvInputSessionImpl.selectTrack(((Integer) args.arg1).intValue(), (String) args.arg2);
                    args.recycle();
                    break;
                case DO_APP_PRIVATE_COMMAND /*9*/:
                    args = (SomeArgs) msg.obj;
                    this.mTvInputSessionImpl.appPrivateCommand((String) args.arg1, (Bundle) args.arg2);
                    args.recycle();
                    break;
                case DO_CREATE_OVERLAY_VIEW /*10*/:
                    args = (SomeArgs) msg.obj;
                    this.mTvInputSessionImpl.createOverlayView((IBinder) args.arg1, (Rect) args.arg2);
                    args.recycle();
                    break;
                case DO_RELAYOUT_OVERLAY_VIEW /*11*/:
                    this.mTvInputSessionImpl.relayoutOverlayView((Rect) msg.obj);
                    break;
                case DO_REMOVE_OVERLAY_VIEW /*12*/:
                    this.mTvInputSessionImpl.removeOverlayView(true);
                    break;
                case DO_REQUEST_UNBLOCK_CONTENT /*13*/:
                    this.mTvInputSessionImpl.unblockContent((String) msg.obj);
                    break;
                default:
                    Log.w(TAG, "Unhandled message code: " + msg.what);
                    break;
            }
            long duration = System.currentTimeMillis() - startTime;
            if (duration > 50) {
                Log.w(TAG, "Handling message (" + msg.what + ") took too long time (duration=" + duration + "ms)");
                if (msg.what == DO_TUNE && duration > 2000) {
                    throw new RuntimeException("Too much time to handle tune request. (" + duration + "ms > " + MESSAGE_TUNE_DURATION_THRESHOLD_MILLIS + "ms) " + "Consider handling the tune request in a separate thread.");
                }
            }
        }
    }

    public void release() {
        this.mTvInputSessionImpl.scheduleOverlayViewCleanup();
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessage(DO_RELEASE));
    }

    public void setMain(boolean isMain) {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageO(DO_SET_MAIN, Boolean.valueOf(isMain)));
    }

    public void setSurface(Surface surface) {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageO(DO_SET_SURFACE, surface));
    }

    public void dispatchSurfaceChanged(int format, int width, int height) {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageIIII(DO_DISPATCH_SURFACE_CHANGED, format, width, height, 0));
    }

    public final void setVolume(float volume) {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageO(DO_SET_STREAM_VOLUME, Float.valueOf(volume)));
    }

    public void tune(Uri channelUri, Bundle params) {
        this.mCaller.removeMessages(DO_TUNE);
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageOO(DO_TUNE, channelUri, params));
    }

    public void setCaptionEnabled(boolean enabled) {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageO(DO_SET_CAPTION_ENABLED, Boolean.valueOf(enabled)));
    }

    public void selectTrack(int type, String trackId) {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageOO(DO_SELECT_TRACK, Integer.valueOf(type), trackId));
    }

    public void appPrivateCommand(String action, Bundle data) {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageOO(DO_APP_PRIVATE_COMMAND, action, data));
    }

    public void createOverlayView(IBinder windowToken, Rect frame) {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageOO(DO_CREATE_OVERLAY_VIEW, windowToken, frame));
    }

    public void relayoutOverlayView(Rect frame) {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageO(DO_RELAYOUT_OVERLAY_VIEW, frame));
    }

    public void removeOverlayView() {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessage(DO_REMOVE_OVERLAY_VIEW));
    }

    public void requestUnblockContent(String unblockedRating) {
        this.mCaller.executeOrSendMessage(this.mCaller.obtainMessageO(DO_REQUEST_UNBLOCK_CONTENT, unblockedRating));
    }
}
