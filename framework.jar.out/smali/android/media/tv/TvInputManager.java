package android.media.tv;

import android.graphics.Rect;
import android.media.tv.ITvInputClient.Stub;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.util.ArrayMap;
import android.util.Log;
import android.util.Pools.Pool;
import android.util.Pools.SimplePool;
import android.util.SparseArray;
import android.view.InputChannel;
import android.view.InputEvent;
import android.view.InputEventSender;
import android.view.KeyEvent;
import android.view.Surface;
import android.view.View;
import android.view.WindowManager.LayoutParams;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public final class TvInputManager {
    public static final String ACTION_BLOCKED_RATINGS_CHANGED = "android.media.tv.action.BLOCKED_RATINGS_CHANGED";
    public static final String ACTION_PARENTAL_CONTROLS_ENABLED_CHANGED = "android.media.tv.action.PARENTAL_CONTROLS_ENABLED_CHANGED";
    public static final String ACTION_QUERY_CONTENT_RATING_SYSTEMS = "android.media.tv.action.QUERY_CONTENT_RATING_SYSTEMS";
    public static final int INPUT_STATE_CONNECTED = 0;
    public static final int INPUT_STATE_CONNECTED_STANDBY = 1;
    public static final int INPUT_STATE_DISCONNECTED = 2;
    public static final int INPUT_STATE_UNKNOWN = -1;
    public static final String META_DATA_CONTENT_RATING_SYSTEMS = "android.media.tv.metadata.CONTENT_RATING_SYSTEMS";
    private static final String TAG = "TvInputManager";
    public static final int VIDEO_UNAVAILABLE_REASON_BUFFERING = 3;
    static final int VIDEO_UNAVAILABLE_REASON_END = 3;
    static final int VIDEO_UNAVAILABLE_REASON_START = 0;
    public static final int VIDEO_UNAVAILABLE_REASON_TUNING = 1;
    public static final int VIDEO_UNAVAILABLE_REASON_UNKNOWN = 0;
    public static final int VIDEO_UNAVAILABLE_REASON_WEAK_SIGNAL = 2;
    private final List<TvInputCallbackRecord> mCallbackRecords;
    private final ITvInputClient mClient;
    private final Object mLock;
    private final ITvInputManagerCallback mManagerCallback;
    private int mNextSeq;
    private final ITvInputManager mService;
    private final SparseArray<SessionCallbackRecord> mSessionCallbackRecordMap;
    private final Map<String, Integer> mStateMap;
    private final int mUserId;

    /* renamed from: android.media.tv.TvInputManager.1 */
    class C04391 extends Stub {
        C04391() {
        }

        public void onSessionCreated(String inputId, IBinder token, InputChannel channel, int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for " + token);
                    return;
                }
                Session session = null;
                if (token != null) {
                    session = new Session(channel, TvInputManager.this.mService, TvInputManager.this.mUserId, seq, TvInputManager.this.mSessionCallbackRecordMap, null);
                }
                record.postSessionCreated(session);
            }
        }

        public void onSessionReleased(int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                TvInputManager.this.mSessionCallbackRecordMap.delete(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for seq:" + seq);
                    return;
                }
                record.mSession.releaseInternal();
                record.postSessionReleased();
            }
        }

        public void onChannelRetuned(Uri channelUri, int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for seq " + seq);
                    return;
                }
                record.postChannelRetuned(channelUri);
            }
        }

        public void onTracksChanged(List<TvTrackInfo> tracks, int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for seq " + seq);
                    return;
                }
                if (record.mSession.updateTracks(tracks)) {
                    record.postTracksChanged(tracks);
                    postVideoSizeChangedIfNeededLocked(record);
                }
            }
        }

        public void onTrackSelected(int type, String trackId, int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for seq " + seq);
                    return;
                }
                if (record.mSession.updateTrackSelection(type, trackId)) {
                    record.postTrackSelected(type, trackId);
                    postVideoSizeChangedIfNeededLocked(record);
                }
            }
        }

        private void postVideoSizeChangedIfNeededLocked(SessionCallbackRecord record) {
            TvTrackInfo track = record.mSession.getVideoTrackToNotify();
            if (track != null) {
                record.postVideoSizeChanged(track.getVideoWidth(), track.getVideoHeight());
            }
        }

        public void onVideoAvailable(int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for seq " + seq);
                    return;
                }
                record.postVideoAvailable();
            }
        }

        public void onVideoUnavailable(int reason, int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for seq " + seq);
                    return;
                }
                record.postVideoUnavailable(reason);
            }
        }

        public void onContentAllowed(int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for seq " + seq);
                    return;
                }
                record.postContentAllowed();
            }
        }

        public void onContentBlocked(String rating, int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for seq " + seq);
                    return;
                }
                record.postContentBlocked(TvContentRating.unflattenFromString(rating));
            }
        }

        public void onLayoutSurface(int left, int top, int right, int bottom, int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for seq " + seq);
                    return;
                }
                record.postLayoutSurface(left, top, right, bottom);
            }
        }

        public void onSessionEvent(String eventType, Bundle eventArgs, int seq) {
            synchronized (TvInputManager.this.mSessionCallbackRecordMap) {
                SessionCallbackRecord record = (SessionCallbackRecord) TvInputManager.this.mSessionCallbackRecordMap.get(seq);
                if (record == null) {
                    Log.e(TvInputManager.TAG, "Callback not found for seq " + seq);
                    return;
                }
                record.postSessionEvent(eventType, eventArgs);
            }
        }
    }

    /* renamed from: android.media.tv.TvInputManager.2 */
    class C04402 extends ITvInputManagerCallback.Stub {
        C04402() {
        }

        public void onInputStateChanged(String inputId, int state) {
            synchronized (TvInputManager.this.mLock) {
                TvInputManager.this.mStateMap.put(inputId, Integer.valueOf(state));
                for (TvInputCallbackRecord record : TvInputManager.this.mCallbackRecords) {
                    record.postInputStateChanged(inputId, state);
                }
            }
        }

        public void onInputAdded(String inputId) {
            synchronized (TvInputManager.this.mLock) {
                TvInputManager.this.mStateMap.put(inputId, Integer.valueOf(TvInputManager.VIDEO_UNAVAILABLE_REASON_UNKNOWN));
                for (TvInputCallbackRecord record : TvInputManager.this.mCallbackRecords) {
                    record.postInputAdded(inputId);
                }
            }
        }

        public void onInputRemoved(String inputId) {
            synchronized (TvInputManager.this.mLock) {
                TvInputManager.this.mStateMap.remove(inputId);
                for (TvInputCallbackRecord record : TvInputManager.this.mCallbackRecords) {
                    record.postInputRemoved(inputId);
                }
            }
        }

        public void onInputUpdated(String inputId) {
            synchronized (TvInputManager.this.mLock) {
                for (TvInputCallbackRecord record : TvInputManager.this.mCallbackRecords) {
                    record.postInputUpdated(inputId);
                }
            }
        }
    }

    /* renamed from: android.media.tv.TvInputManager.3 */
    class C04413 extends ITvInputHardwareCallback.Stub {
        final /* synthetic */ HardwareCallback val$callback;

        C04413(HardwareCallback hardwareCallback) {
            this.val$callback = hardwareCallback;
        }

        public void onReleased() {
            this.val$callback.onReleased();
        }

        public void onStreamConfigChanged(TvStreamConfig[] configs) {
            this.val$callback.onStreamConfigChanged(configs);
        }
    }

    public static final class Hardware {
        private final ITvInputHardware mInterface;

        private Hardware(ITvInputHardware hardwareInterface) {
            this.mInterface = hardwareInterface;
        }

        private ITvInputHardware getInterface() {
            return this.mInterface;
        }

        public boolean setSurface(Surface surface, TvStreamConfig config) {
            try {
                return this.mInterface.setSurface(surface, config);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }

        public void setStreamVolume(float volume) {
            try {
                this.mInterface.setStreamVolume(volume);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }

        public boolean dispatchKeyEventToHdmi(KeyEvent event) {
            try {
                return this.mInterface.dispatchKeyEventToHdmi(event);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }

        public void overrideAudioSink(int audioType, String audioAddress, int samplingRate, int channelMask, int format) {
            try {
                this.mInterface.overrideAudioSink(audioType, audioAddress, samplingRate, channelMask, format);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public static abstract class HardwareCallback {
        public abstract void onReleased();

        public abstract void onStreamConfigChanged(TvStreamConfig[] tvStreamConfigArr);
    }

    public static final class Session {
        static final int DISPATCH_HANDLED = 1;
        static final int DISPATCH_IN_PROGRESS = -1;
        static final int DISPATCH_NOT_HANDLED = 0;
        private static final long INPUT_SESSION_NOT_RESPONDING_TIMEOUT = 2500;
        private final List<TvTrackInfo> mAudioTracks;
        private InputChannel mChannel;
        private final InputEventHandler mHandler;
        private final Pool<PendingEvent> mPendingEventPool;
        private final SparseArray<PendingEvent> mPendingEvents;
        private String mSelectedAudioTrackId;
        private String mSelectedSubtitleTrackId;
        private String mSelectedVideoTrackId;
        private TvInputEventSender mSender;
        private final int mSeq;
        private final ITvInputManager mService;
        private final SparseArray<SessionCallbackRecord> mSessionCallbackRecordMap;
        private final List<TvTrackInfo> mSubtitleTracks;
        private IBinder mToken;
        private final Object mTrackLock;
        private final int mUserId;
        private int mVideoHeight;
        private final List<TvTrackInfo> mVideoTracks;
        private int mVideoWidth;

        public interface FinishedInputEventCallback {
            void onFinishedInputEvent(Object obj, boolean z);
        }

        private final class InputEventHandler extends Handler {
            public static final int MSG_FLUSH_INPUT_EVENT = 3;
            public static final int MSG_SEND_INPUT_EVENT = 1;
            public static final int MSG_TIMEOUT_INPUT_EVENT = 2;

            InputEventHandler(Looper looper) {
                super(looper, null, true);
            }

            public void handleMessage(Message msg) {
                switch (msg.what) {
                    case MSG_SEND_INPUT_EVENT /*1*/:
                        Session.this.sendInputEventAndReportResultOnMainLooper((PendingEvent) msg.obj);
                    case MSG_TIMEOUT_INPUT_EVENT /*2*/:
                        Session.this.finishedInputEvent(msg.arg1, false, true);
                    case MSG_FLUSH_INPUT_EVENT /*3*/:
                        Session.this.finishedInputEvent(msg.arg1, false, false);
                    default:
                }
            }
        }

        private final class PendingEvent implements Runnable {
            public FinishedInputEventCallback mCallback;
            public InputEvent mEvent;
            public Handler mEventHandler;
            public Object mEventToken;
            public boolean mHandled;

            private PendingEvent() {
            }

            public void recycle() {
                this.mEvent = null;
                this.mEventToken = null;
                this.mCallback = null;
                this.mEventHandler = null;
                this.mHandled = false;
            }

            public void run() {
                this.mCallback.onFinishedInputEvent(this.mEventToken, this.mHandled);
                synchronized (this.mEventHandler) {
                    Session.this.recyclePendingEventLocked(this);
                }
            }
        }

        private final class TvInputEventSender extends InputEventSender {
            public TvInputEventSender(InputChannel inputChannel, Looper looper) {
                super(inputChannel, looper);
            }

            public void onInputEventFinished(int seq, boolean handled) {
                Session.this.finishedInputEvent(seq, handled, false);
            }
        }

        private Session(IBinder token, InputChannel channel, ITvInputManager service, int userId, int seq, SparseArray<SessionCallbackRecord> sessionCallbackRecordMap) {
            this.mHandler = new InputEventHandler(Looper.getMainLooper());
            this.mPendingEventPool = new SimplePool(20);
            this.mPendingEvents = new SparseArray(20);
            this.mTrackLock = new Object();
            this.mAudioTracks = new ArrayList();
            this.mVideoTracks = new ArrayList();
            this.mSubtitleTracks = new ArrayList();
            this.mToken = token;
            this.mChannel = channel;
            this.mService = service;
            this.mUserId = userId;
            this.mSeq = seq;
            this.mSessionCallbackRecordMap = sessionCallbackRecordMap;
        }

        public void release() {
            if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
                return;
            }
            try {
                this.mService.releaseSession(this.mToken, this.mUserId);
                releaseInternal();
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }

        void setMain() {
            if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
                return;
            }
            try {
                this.mService.setMainSession(this.mToken, this.mUserId);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }

        public void setSurface(Surface surface) {
            if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
                return;
            }
            try {
                this.mService.setSurface(this.mToken, surface, this.mUserId);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }

        public void dispatchSurfaceChanged(int format, int width, int height) {
            if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
                return;
            }
            try {
                this.mService.dispatchSurfaceChanged(this.mToken, format, width, height, this.mUserId);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }

        public void setStreamVolume(float volume) {
            if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
            } else if (volume < 0.0f || volume > LayoutParams.BRIGHTNESS_OVERRIDE_FULL) {
                try {
                    throw new IllegalArgumentException("volume should be between 0.0f and 1.0f");
                } catch (RemoteException e) {
                    throw new RuntimeException(e);
                }
            } else {
                this.mService.setVolume(this.mToken, volume, this.mUserId);
            }
        }

        public void tune(Uri channelUri) {
            tune(channelUri, null);
        }

        public void tune(Uri channelUri, Bundle params) {
            if (channelUri == null) {
                throw new IllegalArgumentException("channelUri cannot be null");
            } else if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
            } else {
                synchronized (this.mTrackLock) {
                    this.mAudioTracks.clear();
                    this.mVideoTracks.clear();
                    this.mSubtitleTracks.clear();
                    this.mSelectedAudioTrackId = null;
                    this.mSelectedVideoTrackId = null;
                    this.mSelectedSubtitleTrackId = null;
                    this.mVideoWidth = DISPATCH_NOT_HANDLED;
                    this.mVideoHeight = DISPATCH_NOT_HANDLED;
                }
                try {
                    this.mService.tune(this.mToken, channelUri, params, this.mUserId);
                } catch (RemoteException e) {
                    throw new RuntimeException(e);
                }
            }
        }

        public void setCaptionEnabled(boolean enabled) {
            if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
                return;
            }
            try {
                this.mService.setCaptionEnabled(this.mToken, enabled, this.mUserId);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }

        public void selectTrack(int type, String trackId) {
            synchronized (this.mTrackLock) {
                if (type == 0) {
                    if (trackId != null) {
                        if (!containsTrack(this.mAudioTracks, trackId)) {
                            Log.w(TvInputManager.TAG, "Invalid audio trackId: " + trackId);
                            return;
                        }
                    }
                    if (this.mToken != null) {
                        Log.w(TvInputManager.TAG, "The session has been already released");
                        return;
                    }
                    try {
                        this.mService.selectTrack(this.mToken, type, trackId, this.mUserId);
                        return;
                    } catch (RemoteException e) {
                        throw new RuntimeException(e);
                    }
                }
                if (type == DISPATCH_HANDLED) {
                    if (!(trackId == null || containsTrack(this.mVideoTracks, trackId))) {
                        Log.w(TvInputManager.TAG, "Invalid video trackId: " + trackId);
                        return;
                    }
                } else if (type != TvInputManager.VIDEO_UNAVAILABLE_REASON_WEAK_SIGNAL) {
                    throw new IllegalArgumentException("invalid type: " + type);
                } else if (trackId != null) {
                    if (!containsTrack(this.mSubtitleTracks, trackId)) {
                        Log.w(TvInputManager.TAG, "Invalid subtitle trackId: " + trackId);
                        return;
                    }
                }
                if (this.mToken != null) {
                    this.mService.selectTrack(this.mToken, type, trackId, this.mUserId);
                    return;
                } else {
                    Log.w(TvInputManager.TAG, "The session has been already released");
                    return;
                }
            }
        }

        private boolean containsTrack(List<TvTrackInfo> tracks, String trackId) {
            for (TvTrackInfo track : tracks) {
                if (track.getId().equals(trackId)) {
                    return true;
                }
            }
            return false;
        }

        public List<TvTrackInfo> getTracks(int type) {
            List<TvTrackInfo> list = null;
            synchronized (this.mTrackLock) {
                if (type == 0) {
                    if (this.mAudioTracks == null) {
                    } else {
                        list = new ArrayList(this.mAudioTracks);
                    }
                } else if (type == DISPATCH_HANDLED) {
                    if (this.mVideoTracks == null) {
                    } else {
                        list = new ArrayList(this.mVideoTracks);
                    }
                } else if (type != TvInputManager.VIDEO_UNAVAILABLE_REASON_WEAK_SIGNAL) {
                    throw new IllegalArgumentException("invalid type: " + type);
                } else if (this.mSubtitleTracks == null) {
                } else {
                    list = new ArrayList(this.mSubtitleTracks);
                }
                return list;
            }
        }

        public String getSelectedTrack(int type) {
            synchronized (this.mTrackLock) {
                String str;
                if (type == 0) {
                    str = this.mSelectedAudioTrackId;
                } else if (type == DISPATCH_HANDLED) {
                    str = this.mSelectedVideoTrackId;
                } else if (type == TvInputManager.VIDEO_UNAVAILABLE_REASON_WEAK_SIGNAL) {
                    str = this.mSelectedSubtitleTrackId;
                } else {
                    throw new IllegalArgumentException("invalid type: " + type);
                }
                return str;
            }
        }

        boolean updateTracks(List<TvTrackInfo> tracks) {
            boolean z = true;
            synchronized (this.mTrackLock) {
                this.mAudioTracks.clear();
                this.mVideoTracks.clear();
                this.mSubtitleTracks.clear();
                for (TvTrackInfo track : tracks) {
                    if (track.getType() == 0) {
                        this.mAudioTracks.add(track);
                    } else if (track.getType() == DISPATCH_HANDLED) {
                        this.mVideoTracks.add(track);
                    } else if (track.getType() == TvInputManager.VIDEO_UNAVAILABLE_REASON_WEAK_SIGNAL) {
                        this.mSubtitleTracks.add(track);
                    }
                }
                if (this.mAudioTracks.isEmpty() && this.mVideoTracks.isEmpty() && this.mSubtitleTracks.isEmpty()) {
                    z = false;
                }
            }
            return z;
        }

        boolean updateTrackSelection(int type, String trackId) {
            synchronized (this.mTrackLock) {
                if (type == 0) {
                    if (trackId != this.mSelectedAudioTrackId) {
                        this.mSelectedAudioTrackId = trackId;
                        return true;
                    }
                }
                if (type != DISPATCH_HANDLED || trackId == this.mSelectedVideoTrackId) {
                    if (type == TvInputManager.VIDEO_UNAVAILABLE_REASON_WEAK_SIGNAL) {
                        if (trackId != this.mSelectedSubtitleTrackId) {
                            this.mSelectedSubtitleTrackId = trackId;
                            return true;
                        }
                    }
                    return false;
                }
                this.mSelectedVideoTrackId = trackId;
                return true;
            }
        }

        TvTrackInfo getVideoTrackToNotify() {
            synchronized (this.mTrackLock) {
                if (!(this.mVideoTracks.isEmpty() || this.mSelectedVideoTrackId == null)) {
                    for (TvTrackInfo track : this.mVideoTracks) {
                        if (track.getId().equals(this.mSelectedVideoTrackId)) {
                            int videoWidth = track.getVideoWidth();
                            int videoHeight = track.getVideoHeight();
                            if (this.mVideoWidth != videoWidth || this.mVideoHeight != videoHeight) {
                                this.mVideoWidth = videoWidth;
                                this.mVideoHeight = videoHeight;
                                return track;
                            }
                        }
                    }
                }
                return null;
            }
        }

        public void sendAppPrivateCommand(String action, Bundle data) {
            if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
                return;
            }
            try {
                this.mService.sendAppPrivateCommand(this.mToken, action, data, this.mUserId);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }

        void createOverlayView(View view, Rect frame) {
            if (view == null) {
                throw new IllegalArgumentException("view cannot be null");
            } else if (frame == null) {
                throw new IllegalArgumentException("frame cannot be null");
            } else if (view.getWindowToken() == null) {
                throw new IllegalStateException("view must be attached to a window");
            } else if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
            } else {
                try {
                    this.mService.createOverlayView(this.mToken, view.getWindowToken(), frame, this.mUserId);
                } catch (RemoteException e) {
                    throw new RuntimeException(e);
                }
            }
        }

        void relayoutOverlayView(Rect frame) {
            if (frame == null) {
                throw new IllegalArgumentException("frame cannot be null");
            } else if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
            } else {
                try {
                    this.mService.relayoutOverlayView(this.mToken, frame, this.mUserId);
                } catch (RemoteException e) {
                    throw new RuntimeException(e);
                }
            }
        }

        void removeOverlayView() {
            if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
                return;
            }
            try {
                this.mService.removeOverlayView(this.mToken, this.mUserId);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }

        void requestUnblockContent(TvContentRating unblockedRating) {
            if (this.mToken == null) {
                Log.w(TvInputManager.TAG, "The session has been already released");
            } else if (unblockedRating == null) {
                throw new IllegalArgumentException("unblockedRating cannot be null");
            } else {
                try {
                    this.mService.requestUnblockContent(this.mToken, unblockedRating.flattenToString(), this.mUserId);
                } catch (RemoteException e) {
                    throw new RuntimeException(e);
                }
            }
        }

        public int dispatchInputEvent(InputEvent event, Object token, FinishedInputEventCallback callback, Handler handler) {
            if (event == null) {
                throw new IllegalArgumentException("event cannot be null");
            } else if (callback == null || handler != null) {
                int i;
                synchronized (this.mHandler) {
                    if (this.mChannel == null) {
                        i = DISPATCH_NOT_HANDLED;
                    } else {
                        PendingEvent p = obtainPendingEventLocked(event, token, callback, handler);
                        if (Looper.myLooper() == Looper.getMainLooper()) {
                            i = sendInputEventOnMainLooperLocked(p);
                        } else {
                            Message msg = this.mHandler.obtainMessage(DISPATCH_HANDLED, p);
                            msg.setAsynchronous(true);
                            this.mHandler.sendMessage(msg);
                            i = DISPATCH_IN_PROGRESS;
                        }
                    }
                }
                return i;
            } else {
                throw new IllegalArgumentException("handler cannot be null");
            }
        }

        private void sendInputEventAndReportResultOnMainLooper(PendingEvent p) {
            synchronized (this.mHandler) {
                if (sendInputEventOnMainLooperLocked(p) == DISPATCH_IN_PROGRESS) {
                    return;
                }
                invokeFinishedInputEventCallback(p, false);
            }
        }

        private int sendInputEventOnMainLooperLocked(PendingEvent p) {
            if (this.mChannel != null) {
                if (this.mSender == null) {
                    this.mSender = new TvInputEventSender(this.mChannel, this.mHandler.getLooper());
                }
                InputEvent event = p.mEvent;
                int seq = event.getSequenceNumber();
                if (this.mSender.sendInputEvent(seq, event)) {
                    this.mPendingEvents.put(seq, p);
                    Message msg = this.mHandler.obtainMessage(TvInputManager.VIDEO_UNAVAILABLE_REASON_WEAK_SIGNAL, p);
                    msg.setAsynchronous(true);
                    this.mHandler.sendMessageDelayed(msg, INPUT_SESSION_NOT_RESPONDING_TIMEOUT);
                    return DISPATCH_IN_PROGRESS;
                }
                Log.w(TvInputManager.TAG, "Unable to send input event to session: " + this.mToken + " dropping:" + event);
            }
            return DISPATCH_NOT_HANDLED;
        }

        void finishedInputEvent(int seq, boolean handled, boolean timeout) {
            synchronized (this.mHandler) {
                int index = this.mPendingEvents.indexOfKey(seq);
                if (index < 0) {
                    return;
                }
                PendingEvent p = (PendingEvent) this.mPendingEvents.valueAt(index);
                this.mPendingEvents.removeAt(index);
                if (timeout) {
                    Log.w(TvInputManager.TAG, "Timeout waiting for seesion to handle input event after 2500 ms: " + this.mToken);
                } else {
                    this.mHandler.removeMessages(TvInputManager.VIDEO_UNAVAILABLE_REASON_WEAK_SIGNAL, p);
                }
                invokeFinishedInputEventCallback(p, handled);
            }
        }

        void invokeFinishedInputEventCallback(PendingEvent p, boolean handled) {
            p.mHandled = handled;
            if (p.mEventHandler.getLooper().isCurrentThread()) {
                p.run();
                return;
            }
            Message msg = Message.obtain(p.mEventHandler, (Runnable) p);
            msg.setAsynchronous(true);
            msg.sendToTarget();
        }

        private void flushPendingEventsLocked() {
            this.mHandler.removeMessages(TvInputManager.VIDEO_UNAVAILABLE_REASON_END);
            int count = this.mPendingEvents.size();
            for (int i = DISPATCH_NOT_HANDLED; i < count; i += DISPATCH_HANDLED) {
                Message msg = this.mHandler.obtainMessage(TvInputManager.VIDEO_UNAVAILABLE_REASON_END, this.mPendingEvents.keyAt(i), DISPATCH_NOT_HANDLED);
                msg.setAsynchronous(true);
                msg.sendToTarget();
            }
        }

        private PendingEvent obtainPendingEventLocked(InputEvent event, Object token, FinishedInputEventCallback callback, Handler handler) {
            PendingEvent p = (PendingEvent) this.mPendingEventPool.acquire();
            if (p == null) {
                p = new PendingEvent();
            }
            p.mEvent = event;
            p.mEventToken = token;
            p.mCallback = callback;
            p.mEventHandler = handler;
            return p;
        }

        private void recyclePendingEventLocked(PendingEvent p) {
            p.recycle();
            this.mPendingEventPool.release(p);
        }

        IBinder getToken() {
            return this.mToken;
        }

        private void releaseInternal() {
            this.mToken = null;
            synchronized (this.mHandler) {
                if (this.mChannel != null) {
                    if (this.mSender != null) {
                        flushPendingEventsLocked();
                        this.mSender.dispose();
                        this.mSender = null;
                    }
                    this.mChannel.dispose();
                    this.mChannel = null;
                }
            }
            synchronized (this.mSessionCallbackRecordMap) {
                this.mSessionCallbackRecordMap.remove(this.mSeq);
            }
        }
    }

    public static abstract class SessionCallback {
        public void onSessionCreated(Session session) {
        }

        public void onSessionReleased(Session session) {
        }

        public void onChannelRetuned(Session session, Uri channelUri) {
        }

        public void onTracksChanged(Session session, List<TvTrackInfo> list) {
        }

        public void onTrackSelected(Session session, int type, String trackId) {
        }

        public void onVideoSizeChanged(Session session, int width, int height) {
        }

        public void onVideoAvailable(Session session) {
        }

        public void onVideoUnavailable(Session session, int reason) {
        }

        public void onContentAllowed(Session session) {
        }

        public void onContentBlocked(Session session, TvContentRating rating) {
        }

        public void onLayoutSurface(Session session, int left, int top, int right, int bottom) {
        }

        public void onSessionEvent(Session session, String eventType, Bundle eventArgs) {
        }
    }

    private static final class SessionCallbackRecord {
        private final Handler mHandler;
        private Session mSession;
        private final SessionCallback mSessionCallback;

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.10 */
        class AnonymousClass10 implements Runnable {
            final /* synthetic */ TvContentRating val$rating;

            AnonymousClass10(TvContentRating tvContentRating) {
                this.val$rating = tvContentRating;
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onContentBlocked(SessionCallbackRecord.this.mSession, this.val$rating);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.11 */
        class AnonymousClass11 implements Runnable {
            final /* synthetic */ int val$bottom;
            final /* synthetic */ int val$left;
            final /* synthetic */ int val$right;
            final /* synthetic */ int val$top;

            AnonymousClass11(int i, int i2, int i3, int i4) {
                this.val$left = i;
                this.val$top = i2;
                this.val$right = i3;
                this.val$bottom = i4;
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onLayoutSurface(SessionCallbackRecord.this.mSession, this.val$left, this.val$top, this.val$right, this.val$bottom);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.12 */
        class AnonymousClass12 implements Runnable {
            final /* synthetic */ Bundle val$eventArgs;
            final /* synthetic */ String val$eventType;

            AnonymousClass12(String str, Bundle bundle) {
                this.val$eventType = str;
                this.val$eventArgs = bundle;
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onSessionEvent(SessionCallbackRecord.this.mSession, this.val$eventType, this.val$eventArgs);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.1 */
        class C04421 implements Runnable {
            final /* synthetic */ Session val$session;

            C04421(Session session) {
                this.val$session = session;
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onSessionCreated(this.val$session);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.2 */
        class C04432 implements Runnable {
            C04432() {
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onSessionReleased(SessionCallbackRecord.this.mSession);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.3 */
        class C04443 implements Runnable {
            final /* synthetic */ Uri val$channelUri;

            C04443(Uri uri) {
                this.val$channelUri = uri;
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onChannelRetuned(SessionCallbackRecord.this.mSession, this.val$channelUri);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.4 */
        class C04454 implements Runnable {
            final /* synthetic */ List val$tracks;

            C04454(List list) {
                this.val$tracks = list;
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onTracksChanged(SessionCallbackRecord.this.mSession, this.val$tracks);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.5 */
        class C04465 implements Runnable {
            final /* synthetic */ String val$trackId;
            final /* synthetic */ int val$type;

            C04465(int i, String str) {
                this.val$type = i;
                this.val$trackId = str;
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onTrackSelected(SessionCallbackRecord.this.mSession, this.val$type, this.val$trackId);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.6 */
        class C04476 implements Runnable {
            final /* synthetic */ int val$height;
            final /* synthetic */ int val$width;

            C04476(int i, int i2) {
                this.val$width = i;
                this.val$height = i2;
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onVideoSizeChanged(SessionCallbackRecord.this.mSession, this.val$width, this.val$height);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.7 */
        class C04487 implements Runnable {
            C04487() {
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onVideoAvailable(SessionCallbackRecord.this.mSession);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.8 */
        class C04498 implements Runnable {
            final /* synthetic */ int val$reason;

            C04498(int i) {
                this.val$reason = i;
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onVideoUnavailable(SessionCallbackRecord.this.mSession, this.val$reason);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.SessionCallbackRecord.9 */
        class C04509 implements Runnable {
            C04509() {
            }

            public void run() {
                SessionCallbackRecord.this.mSessionCallback.onContentAllowed(SessionCallbackRecord.this.mSession);
            }
        }

        SessionCallbackRecord(SessionCallback sessionCallback, Handler handler) {
            this.mSessionCallback = sessionCallback;
            this.mHandler = handler;
        }

        void postSessionCreated(Session session) {
            this.mSession = session;
            this.mHandler.post(new C04421(session));
        }

        void postSessionReleased() {
            this.mHandler.post(new C04432());
        }

        void postChannelRetuned(Uri channelUri) {
            this.mHandler.post(new C04443(channelUri));
        }

        void postTracksChanged(List<TvTrackInfo> tracks) {
            this.mHandler.post(new C04454(tracks));
        }

        void postTrackSelected(int type, String trackId) {
            this.mHandler.post(new C04465(type, trackId));
        }

        void postVideoSizeChanged(int width, int height) {
            this.mHandler.post(new C04476(width, height));
        }

        void postVideoAvailable() {
            this.mHandler.post(new C04487());
        }

        void postVideoUnavailable(int reason) {
            this.mHandler.post(new C04498(reason));
        }

        void postContentAllowed() {
            this.mHandler.post(new C04509());
        }

        void postContentBlocked(TvContentRating rating) {
            this.mHandler.post(new AnonymousClass10(rating));
        }

        void postLayoutSurface(int left, int top, int right, int bottom) {
            this.mHandler.post(new AnonymousClass11(left, top, right, bottom));
        }

        void postSessionEvent(String eventType, Bundle eventArgs) {
            this.mHandler.post(new AnonymousClass12(eventType, eventArgs));
        }
    }

    public static abstract class TvInputCallback {
        public void onInputStateChanged(String inputId, int state) {
        }

        public void onInputAdded(String inputId) {
        }

        public void onInputRemoved(String inputId) {
        }

        public void onInputUpdated(String inputId) {
        }
    }

    private static final class TvInputCallbackRecord {
        private final TvInputCallback mCallback;
        private final Handler mHandler;

        /* renamed from: android.media.tv.TvInputManager.TvInputCallbackRecord.1 */
        class C04511 implements Runnable {
            final /* synthetic */ String val$inputId;
            final /* synthetic */ int val$state;

            C04511(String str, int i) {
                this.val$inputId = str;
                this.val$state = i;
            }

            public void run() {
                TvInputCallbackRecord.this.mCallback.onInputStateChanged(this.val$inputId, this.val$state);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.TvInputCallbackRecord.2 */
        class C04522 implements Runnable {
            final /* synthetic */ String val$inputId;

            C04522(String str) {
                this.val$inputId = str;
            }

            public void run() {
                TvInputCallbackRecord.this.mCallback.onInputAdded(this.val$inputId);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.TvInputCallbackRecord.3 */
        class C04533 implements Runnable {
            final /* synthetic */ String val$inputId;

            C04533(String str) {
                this.val$inputId = str;
            }

            public void run() {
                TvInputCallbackRecord.this.mCallback.onInputRemoved(this.val$inputId);
            }
        }

        /* renamed from: android.media.tv.TvInputManager.TvInputCallbackRecord.4 */
        class C04544 implements Runnable {
            final /* synthetic */ String val$inputId;

            C04544(String str) {
                this.val$inputId = str;
            }

            public void run() {
                TvInputCallbackRecord.this.mCallback.onInputUpdated(this.val$inputId);
            }
        }

        public TvInputCallbackRecord(TvInputCallback callback, Handler handler) {
            this.mCallback = callback;
            this.mHandler = handler;
        }

        public TvInputCallback getCallback() {
            return this.mCallback;
        }

        public void postInputStateChanged(String inputId, int state) {
            this.mHandler.post(new C04511(inputId, state));
        }

        public void postInputAdded(String inputId) {
            this.mHandler.post(new C04522(inputId));
        }

        public void postInputRemoved(String inputId) {
            this.mHandler.post(new C04533(inputId));
        }

        public void postInputUpdated(String inputId) {
            this.mHandler.post(new C04544(inputId));
        }
    }

    public TvInputManager(ITvInputManager service, int userId) {
        this.mLock = new Object();
        this.mCallbackRecords = new LinkedList();
        this.mStateMap = new ArrayMap();
        this.mSessionCallbackRecordMap = new SparseArray();
        this.mService = service;
        this.mUserId = userId;
        this.mClient = new C04391();
        this.mManagerCallback = new C04402();
        try {
            if (this.mService != null) {
                this.mService.registerCallback(this.mManagerCallback, this.mUserId);
                List<TvInputInfo> infos = this.mService.getTvInputList(this.mUserId);
                synchronized (this.mLock) {
                    for (TvInputInfo info : infos) {
                        String inputId = info.getId();
                        int state = this.mService.getTvInputState(inputId, this.mUserId);
                        if (state != INPUT_STATE_UNKNOWN) {
                            this.mStateMap.put(inputId, Integer.valueOf(state));
                        }
                    }
                }
            }
        } catch (RemoteException e) {
            Log.e(TAG, "TvInputManager initialization failed: " + e);
        }
    }

    public List<TvInputInfo> getTvInputList() {
        try {
            return this.mService.getTvInputList(this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public TvInputInfo getTvInputInfo(String inputId) {
        if (inputId == null) {
            throw new IllegalArgumentException("inputId cannot be null");
        }
        try {
            return this.mService.getTvInputInfo(inputId, this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public int getInputState(String inputId) {
        if (inputId == null) {
            throw new IllegalArgumentException("inputId cannot be null");
        }
        int intValue;
        synchronized (this.mLock) {
            Integer state = (Integer) this.mStateMap.get(inputId);
            if (state == null) {
                throw new IllegalArgumentException("Unrecognized input ID: " + inputId);
            }
            intValue = state.intValue();
        }
        return intValue;
    }

    public void registerCallback(TvInputCallback callback, Handler handler) {
        if (callback == null) {
            throw new IllegalArgumentException("callback cannot be null");
        } else if (handler == null) {
            throw new IllegalArgumentException("handler cannot be null");
        } else {
            synchronized (this.mLock) {
                this.mCallbackRecords.add(new TvInputCallbackRecord(callback, handler));
            }
        }
    }

    public void unregisterCallback(TvInputCallback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("callback cannot be null");
        }
        synchronized (this.mLock) {
            Iterator<TvInputCallbackRecord> it = this.mCallbackRecords.iterator();
            while (it.hasNext()) {
                if (((TvInputCallbackRecord) it.next()).getCallback() == callback) {
                    it.remove();
                    break;
                }
            }
        }
    }

    public boolean isParentalControlsEnabled() {
        try {
            return this.mService.isParentalControlsEnabled(this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public void setParentalControlsEnabled(boolean enabled) {
        try {
            this.mService.setParentalControlsEnabled(enabled, this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean isRatingBlocked(TvContentRating rating) {
        if (rating == null) {
            throw new IllegalArgumentException("rating cannot be null");
        }
        try {
            return this.mService.isRatingBlocked(rating.flattenToString(), this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public List<TvContentRating> getBlockedRatings() {
        try {
            List<TvContentRating> ratings = new ArrayList();
            for (String rating : this.mService.getBlockedRatings(this.mUserId)) {
                ratings.add(TvContentRating.unflattenFromString(rating));
            }
            return ratings;
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public void addBlockedRating(TvContentRating rating) {
        if (rating == null) {
            throw new IllegalArgumentException("rating cannot be null");
        }
        try {
            this.mService.addBlockedRating(rating.flattenToString(), this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public void removeBlockedRating(TvContentRating rating) {
        if (rating == null) {
            throw new IllegalArgumentException("rating cannot be null");
        }
        try {
            this.mService.removeBlockedRating(rating.flattenToString(), this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public List<TvContentRatingSystemInfo> getTvContentRatingSystemList() {
        try {
            return this.mService.getTvContentRatingSystemList(this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public void createSession(String inputId, SessionCallback callback, Handler handler) {
        if (inputId == null) {
            throw new IllegalArgumentException("id cannot be null");
        } else if (callback == null) {
            throw new IllegalArgumentException("callback cannot be null");
        } else if (handler == null) {
            throw new IllegalArgumentException("handler cannot be null");
        } else {
            SessionCallbackRecord record = new SessionCallbackRecord(callback, handler);
            synchronized (this.mSessionCallbackRecordMap) {
                int seq = this.mNextSeq;
                this.mNextSeq = seq + VIDEO_UNAVAILABLE_REASON_TUNING;
                this.mSessionCallbackRecordMap.put(seq, record);
                try {
                    this.mService.createSession(this.mClient, inputId, seq, this.mUserId);
                } catch (RemoteException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }

    public List<TvStreamConfig> getAvailableTvStreamConfigList(String inputId) {
        try {
            return this.mService.getAvailableTvStreamConfigList(inputId, this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean captureFrame(String inputId, Surface surface, TvStreamConfig config) {
        try {
            return this.mService.captureFrame(inputId, surface, config, this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean isSingleSessionActive() {
        try {
            return this.mService.isSingleSessionActive(this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public List<TvInputHardwareInfo> getHardwareList() {
        try {
            return this.mService.getHardwareList();
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public Hardware acquireTvInputHardware(int deviceId, HardwareCallback callback, TvInputInfo info) {
        try {
            return new Hardware(null);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public void releaseTvInputHardware(int deviceId, Hardware hardware) {
        try {
            this.mService.releaseTvInputHardware(deviceId, hardware.getInterface(), this.mUserId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }
}
