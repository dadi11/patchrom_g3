package android.media;

import android.app.ActivityManager;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.graphics.Bitmap;
import android.media.IRemoteControlDisplay.Stub;
import android.media.session.MediaController;
import android.media.session.MediaController.Callback;
import android.media.session.MediaSessionLegacyHelper;
import android.media.session.MediaSessionManager;
import android.media.session.MediaSessionManager.OnActiveSessionsChangedListener;
import android.media.session.PlaybackState;
import android.net.ProxyInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.SystemClock;
import android.os.UserHandle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.KeyEvent;
import java.lang.ref.WeakReference;
import java.util.List;

@Deprecated
public final class RemoteController {
    private static final boolean DEBUG = false;
    private static final int MAX_BITMAP_DIMENSION = 512;
    private static final int MSG_CLIENT_CHANGE = 4;
    private static final int MSG_DISPLAY_ENABLE = 5;
    private static final int MSG_NEW_MEDIA_METADATA = 7;
    private static final int MSG_NEW_METADATA = 3;
    private static final int MSG_NEW_PENDING_INTENT = 0;
    private static final int MSG_NEW_PLAYBACK_INFO = 1;
    private static final int MSG_NEW_PLAYBACK_STATE = 6;
    private static final int MSG_NEW_TRANSPORT_INFO = 2;
    public static final int POSITION_SYNCHRONIZATION_CHECK = 1;
    public static final int POSITION_SYNCHRONIZATION_NONE = 0;
    private static final int SENDMSG_NOOP = 1;
    private static final int SENDMSG_QUEUE = 2;
    private static final int SENDMSG_REPLACE = 0;
    private static final String TAG = "RemoteController";
    private static final int TRANSPORT_UNKNOWN = 0;
    private static final boolean USE_SESSIONS = true;
    private static final Object mGenLock;
    private static final Object mInfoLock;
    private int mArtworkHeight;
    private int mArtworkWidth;
    private final AudioManager mAudioManager;
    private int mClientGenerationIdCurrent;
    private PendingIntent mClientPendingIntentCurrent;
    private final Context mContext;
    private MediaController mCurrentSession;
    private boolean mEnabled;
    private final EventHandler mEventHandler;
    private boolean mIsRegistered;
    private PlaybackInfo mLastPlaybackInfo;
    private final int mMaxBitmapDimension;
    private MetadataEditor mMetadataEditor;
    private OnClientUpdateListener mOnClientUpdateListener;
    private final RcDisplay mRcd;
    private Callback mSessionCb;
    private OnActiveSessionsChangedListener mSessionListener;
    private MediaSessionManager mSessionManager;

    private class EventHandler extends Handler {
        public EventHandler(RemoteController rc, Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            boolean z = RemoteController.USE_SESSIONS;
            RemoteController remoteController;
            switch (msg.what) {
                case RemoteController.TRANSPORT_UNKNOWN /*0*/:
                    RemoteController.this.onNewPendingIntent(msg.arg1, (PendingIntent) msg.obj);
                case RemoteController.SENDMSG_NOOP /*1*/:
                    RemoteController.this.onNewPlaybackInfo(msg.arg1, (PlaybackInfo) msg.obj);
                case RemoteController.SENDMSG_QUEUE /*2*/:
                    RemoteController.this.onNewTransportInfo(msg.arg1, msg.arg2);
                case RemoteController.MSG_NEW_METADATA /*3*/:
                    RemoteController.this.onNewMetadata(msg.arg1, (Bundle) msg.obj);
                case RemoteController.MSG_CLIENT_CHANGE /*4*/:
                    remoteController = RemoteController.this;
                    int i = msg.arg1;
                    if (msg.arg2 != RemoteController.SENDMSG_NOOP) {
                        z = RemoteController.DEBUG;
                    }
                    remoteController.onClientChange(i, z);
                case RemoteController.MSG_DISPLAY_ENABLE /*5*/:
                    remoteController = RemoteController.this;
                    if (msg.arg1 != RemoteController.SENDMSG_NOOP) {
                        z = RemoteController.DEBUG;
                    }
                    remoteController.onDisplayEnable(z);
                case RemoteController.MSG_NEW_PLAYBACK_STATE /*6*/:
                    RemoteController.this.onNewPlaybackState((PlaybackState) msg.obj);
                case RemoteController.MSG_NEW_MEDIA_METADATA /*7*/:
                    RemoteController.this.onNewMediaMetadata((MediaMetadata) msg.obj);
                default:
                    Log.e(RemoteController.TAG, "unknown event " + msg.what);
            }
        }
    }

    private class MediaControllerCallback extends Callback {
        private MediaControllerCallback() {
        }

        public void onPlaybackStateChanged(PlaybackState state) {
            RemoteController.this.onNewPlaybackState(state);
        }

        public void onMetadataChanged(MediaMetadata metadata) {
            RemoteController.this.onNewMediaMetadata(metadata);
        }

        public void onUpdateFolderInfoBrowsedPlayer(String stringUri) {
            Log.d(RemoteController.TAG, "MediaControllerCallback: onUpdateFolderInfoBrowsedPlayer");
            RemoteController.this.onFolderInfoBrowsedPlayer(stringUri);
        }

        public void onUpdateNowPlayingEntries(long[] playList) {
            Log.d(RemoteController.TAG, "MediaControllerCallback: onUpdateNowPlayingEntries");
            RemoteController.this.onNowPlayingEntriesUpdate(playList);
        }

        public void onUpdateNowPlayingContentChange() {
            Log.d(RemoteController.TAG, "MediaControllerCallback: onUpdateNowPlayingContentChange");
            RemoteController.this.onNowPlayingContentChange();
        }

        public void onPlayItemResponse(boolean success) {
            Log.d(RemoteController.TAG, "MediaControllerCallback: onPlayItemResponse");
            RemoteController.this.onSetPlayItemResponse(success);
        }
    }

    public class MetadataEditor extends MediaMetadataEditor {
        protected MetadataEditor() {
        }

        protected MetadataEditor(Bundle metadata, long editableKeys) {
            this.mEditorMetadata = metadata;
            this.mEditableKeys = editableKeys;
            this.mEditorArtwork = (Bitmap) metadata.getParcelable(String.valueOf(100));
            if (this.mEditorArtwork != null) {
                cleanupBitmapFromBundle(100);
            }
            this.mMetadataChanged = RemoteController.USE_SESSIONS;
            this.mArtworkChanged = RemoteController.USE_SESSIONS;
            this.mApplied = RemoteController.DEBUG;
        }

        private void cleanupBitmapFromBundle(int key) {
            if (METADATA_KEYS_TYPE.get(key, -1) == RemoteController.SENDMSG_QUEUE) {
                this.mEditorMetadata.remove(String.valueOf(key));
            }
        }

        public synchronized void apply() {
            if (this.mMetadataChanged) {
                synchronized (RemoteController.mInfoLock) {
                    if (RemoteController.this.mCurrentSession != null && this.mEditorMetadata.containsKey(String.valueOf(MediaMetadataEditor.RATING_KEY_BY_USER))) {
                        Rating rating = (Rating) getObject(MediaMetadataEditor.RATING_KEY_BY_USER, null);
                        if (rating != null) {
                            RemoteController.this.mCurrentSession.getTransportControls().setRating(rating);
                        }
                    }
                }
                this.mApplied = RemoteController.DEBUG;
            }
        }
    }

    public interface OnClientUpdateListener {
        void onClientChange(boolean z);

        void onClientFolderInfoBrowsedPlayer(String str);

        void onClientMetadataUpdate(MetadataEditor metadataEditor);

        void onClientNowPlayingContentChange();

        void onClientPlayItemResponse(boolean z);

        void onClientPlaybackStateUpdate(int i);

        void onClientPlaybackStateUpdate(int i, long j, long j2, float f);

        void onClientTransportControlUpdate(int i);

        void onClientUpdateNowPlayingEntries(long[] jArr);
    }

    private static class PlaybackInfo {
        long mCurrentPosMs;
        float mSpeed;
        int mState;
        long mStateChangeTimeMs;

        PlaybackInfo(int state, long stateChangeTimeMs, long currentPosMs, float speed) {
            this.mState = state;
            this.mStateChangeTimeMs = stateChangeTimeMs;
            this.mCurrentPosMs = currentPosMs;
            this.mSpeed = speed;
        }
    }

    private static class RcDisplay extends Stub {
        private final WeakReference<RemoteController> mController;

        RcDisplay(RemoteController rc) {
            this.mController = new WeakReference(rc);
        }

        public void setCurrentClientId(int genId, PendingIntent clientMediaIntent, boolean clearing) {
            RemoteController rc = (RemoteController) this.mController.get();
            if (rc != null) {
                boolean isNew = RemoteController.DEBUG;
                synchronized (RemoteController.mGenLock) {
                    if (rc.mClientGenerationIdCurrent != genId) {
                        rc.mClientGenerationIdCurrent = genId;
                        isNew = RemoteController.USE_SESSIONS;
                    }
                }
                if (clientMediaIntent != null) {
                    RemoteController.sendMsg(rc.mEventHandler, RemoteController.TRANSPORT_UNKNOWN, RemoteController.TRANSPORT_UNKNOWN, genId, RemoteController.TRANSPORT_UNKNOWN, clientMediaIntent, RemoteController.TRANSPORT_UNKNOWN);
                }
                if (isNew || clearing) {
                    RemoteController.sendMsg(rc.mEventHandler, RemoteController.MSG_CLIENT_CHANGE, RemoteController.TRANSPORT_UNKNOWN, genId, clearing ? RemoteController.SENDMSG_NOOP : RemoteController.TRANSPORT_UNKNOWN, null, RemoteController.TRANSPORT_UNKNOWN);
                }
            }
        }

        public void setEnabled(boolean enabled) {
            RemoteController rc = (RemoteController) this.mController.get();
            if (rc != null) {
                RemoteController.sendMsg(rc.mEventHandler, RemoteController.MSG_DISPLAY_ENABLE, RemoteController.TRANSPORT_UNKNOWN, enabled ? RemoteController.SENDMSG_NOOP : RemoteController.TRANSPORT_UNKNOWN, RemoteController.TRANSPORT_UNKNOWN, null, RemoteController.TRANSPORT_UNKNOWN);
            }
        }

        public void setPlaybackState(int genId, int state, long stateChangeTimeMs, long currentPosMs, float speed) {
            RemoteController rc = (RemoteController) this.mController.get();
            if (rc != null) {
                synchronized (RemoteController.mGenLock) {
                    if (rc.mClientGenerationIdCurrent != genId) {
                        return;
                    }
                    RemoteController.sendMsg(rc.mEventHandler, RemoteController.SENDMSG_NOOP, RemoteController.TRANSPORT_UNKNOWN, genId, RemoteController.TRANSPORT_UNKNOWN, new PlaybackInfo(state, stateChangeTimeMs, currentPosMs, speed), RemoteController.TRANSPORT_UNKNOWN);
                }
            }
        }

        public void setTransportControlInfo(int genId, int transportControlFlags, int posCapabilities) {
            RemoteController rc = (RemoteController) this.mController.get();
            if (rc != null) {
                synchronized (RemoteController.mGenLock) {
                    if (rc.mClientGenerationIdCurrent != genId) {
                        return;
                    }
                    RemoteController.sendMsg(rc.mEventHandler, RemoteController.SENDMSG_QUEUE, RemoteController.TRANSPORT_UNKNOWN, genId, transportControlFlags, null, RemoteController.TRANSPORT_UNKNOWN);
                }
            }
        }

        public void setMetadata(int genId, Bundle metadata) {
            RemoteController rc = (RemoteController) this.mController.get();
            if (rc != null && metadata != null) {
                synchronized (RemoteController.mGenLock) {
                    if (rc.mClientGenerationIdCurrent != genId) {
                        return;
                    }
                    RemoteController.sendMsg(rc.mEventHandler, RemoteController.MSG_NEW_METADATA, RemoteController.SENDMSG_QUEUE, genId, RemoteController.TRANSPORT_UNKNOWN, metadata, RemoteController.TRANSPORT_UNKNOWN);
                }
            }
        }

        public void setArtwork(int genId, Bitmap artwork) {
            RemoteController rc = (RemoteController) this.mController.get();
            if (rc != null) {
                synchronized (RemoteController.mGenLock) {
                    if (rc.mClientGenerationIdCurrent != genId) {
                        return;
                    }
                    Bundle metadata = new Bundle((int) RemoteController.SENDMSG_NOOP);
                    metadata.putParcelable(String.valueOf(100), artwork);
                    RemoteController.sendMsg(rc.mEventHandler, RemoteController.MSG_NEW_METADATA, RemoteController.SENDMSG_QUEUE, genId, RemoteController.TRANSPORT_UNKNOWN, metadata, RemoteController.TRANSPORT_UNKNOWN);
                }
            }
        }

        public void setAllMetadata(int genId, Bundle metadata, Bitmap artwork) {
            RemoteController rc = (RemoteController) this.mController.get();
            if (rc != null) {
                if (metadata != null || artwork != null) {
                    synchronized (RemoteController.mGenLock) {
                        if (rc.mClientGenerationIdCurrent != genId) {
                            return;
                        }
                        if (metadata == null) {
                            metadata = new Bundle((int) RemoteController.SENDMSG_NOOP);
                        }
                        if (artwork != null) {
                            metadata.putParcelable(String.valueOf(100), artwork);
                        }
                        RemoteController.sendMsg(rc.mEventHandler, RemoteController.MSG_NEW_METADATA, RemoteController.SENDMSG_QUEUE, genId, RemoteController.TRANSPORT_UNKNOWN, metadata, RemoteController.TRANSPORT_UNKNOWN);
                    }
                }
            }
        }
    }

    private class TopTransportSessionListener implements OnActiveSessionsChangedListener {
        private TopTransportSessionListener() {
        }

        public void onActiveSessionsChanged(List<MediaController> controllers) {
            int size = controllers.size();
            for (int i = RemoteController.TRANSPORT_UNKNOWN; i < size; i += RemoteController.SENDMSG_NOOP) {
                MediaController controller = (MediaController) controllers.get(i);
                if ((2 & controller.getFlags()) != 0) {
                    RemoteController.this.updateController(controller);
                    return;
                }
            }
            RemoteController.this.updateController(null);
        }
    }

    static {
        mGenLock = new Object();
        mInfoLock = new Object();
    }

    public RemoteController(Context context, OnClientUpdateListener updateListener) throws IllegalArgumentException {
        this(context, updateListener, null);
    }

    public RemoteController(Context context, OnClientUpdateListener updateListener, Looper looper) throws IllegalArgumentException {
        this.mSessionCb = new MediaControllerCallback();
        this.mClientGenerationIdCurrent = TRANSPORT_UNKNOWN;
        this.mIsRegistered = DEBUG;
        this.mArtworkWidth = -1;
        this.mArtworkHeight = -1;
        this.mEnabled = USE_SESSIONS;
        if (context == null) {
            throw new IllegalArgumentException("Invalid null Context");
        } else if (updateListener == null) {
            throw new IllegalArgumentException("Invalid null OnClientUpdateListener");
        } else {
            if (looper != null) {
                this.mEventHandler = new EventHandler(this, looper);
            } else {
                Looper l = Looper.myLooper();
                if (l != null) {
                    this.mEventHandler = new EventHandler(this, l);
                } else {
                    throw new IllegalArgumentException("Calling thread not associated with a looper");
                }
            }
            this.mOnClientUpdateListener = updateListener;
            this.mContext = context;
            this.mRcd = new RcDisplay(this);
            this.mAudioManager = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
            this.mSessionManager = (MediaSessionManager) context.getSystemService(Context.MEDIA_SESSION_SERVICE);
            this.mSessionListener = new TopTransportSessionListener();
            if (ActivityManager.isLowRamDeviceStatic()) {
                this.mMaxBitmapDimension = MAX_BITMAP_DIMENSION;
                return;
            }
            DisplayMetrics dm = context.getResources().getDisplayMetrics();
            this.mMaxBitmapDimension = Math.max(dm.widthPixels, dm.heightPixels);
        }
    }

    public String getRemoteControlClientPackageName() {
        String packageName;
        synchronized (mInfoLock) {
            packageName = this.mCurrentSession != null ? this.mCurrentSession.getPackageName() : null;
        }
        return packageName;
    }

    public long getEstimatedMediaPosition() {
        synchronized (mInfoLock) {
            if (this.mCurrentSession != null) {
                PlaybackState state = this.mCurrentSession.getPlaybackState();
                if (state != null) {
                    long position = state.getPosition();
                    return position;
                }
            }
            return -1;
        }
    }

    public boolean sendMediaKeyEvent(KeyEvent keyEvent) throws IllegalArgumentException {
        if (KeyEvent.isMediaKey(keyEvent.getKeyCode())) {
            boolean dispatchMediaButtonEvent;
            synchronized (mInfoLock) {
                if (this.mCurrentSession != null) {
                    dispatchMediaButtonEvent = this.mCurrentSession.dispatchMediaButtonEvent(keyEvent);
                } else {
                    dispatchMediaButtonEvent = DEBUG;
                }
            }
            return dispatchMediaButtonEvent;
        }
        throw new IllegalArgumentException("not a media key event");
    }

    public boolean seekTo(long timeMs) throws IllegalArgumentException {
        Log.e(TAG, "seekTo() in RemoteController");
        if (!this.mEnabled) {
            Log.e(TAG, "Cannot use seekTo() from a disabled RemoteController");
            return DEBUG;
        } else if (timeMs < 0) {
            throw new IllegalArgumentException("illegal negative time value");
        } else {
            synchronized (mInfoLock) {
                if (this.mCurrentSession != null) {
                    this.mCurrentSession.getTransportControls().seekTo(timeMs);
                }
            }
            return USE_SESSIONS;
        }
    }

    public void setRemoteControlClientPlayItem(long uid, int scope) {
        Log.e(TAG, "setRemoteControlClientPlayItem()");
        if (this.mEnabled) {
            synchronized (mInfoLock) {
                if (this.mCurrentSession != null) {
                    this.mCurrentSession.getTransportControls().setRemoteControlClientPlayItem(uid, scope);
                }
            }
            return;
        }
        Log.e(TAG, "Cannot use setRemoteControlClientPlayItem() from a disabled RemoteController");
    }

    public void getRemoteControlClientNowPlayingEntries() {
        Log.e(TAG, "getRemoteControlClientNowPlayingEntries()");
        if (this.mEnabled) {
            synchronized (mInfoLock) {
                if (this.mCurrentSession != null) {
                    this.mCurrentSession.getTransportControls().getRemoteControlClientNowPlayingEntries();
                }
            }
            return;
        }
        Log.e(TAG, "Cannot use getRemoteControlClientNowPlayingEntries() from a disabled RemoteController");
    }

    public void setRemoteControlClientBrowsedPlayer() {
        Log.e(TAG, "setRemoteControlClientBrowsedPlayer()");
        if (this.mEnabled) {
            synchronized (mInfoLock) {
                if (this.mCurrentSession != null) {
                    this.mCurrentSession.getTransportControls().setRemoteControlClientBrowsedPlayer();
                }
            }
            return;
        }
        Log.e(TAG, "Cannot use setRemoteControlClientBrowsedPlayer() from a disabled RemoteController");
    }

    public boolean setArtworkConfiguration(boolean wantBitmap, int width, int height) throws IllegalArgumentException {
        synchronized (mInfoLock) {
            if (!wantBitmap) {
                this.mArtworkWidth = -1;
                this.mArtworkHeight = -1;
            } else if (width <= 0 || height <= 0) {
                throw new IllegalArgumentException("Invalid dimensions");
            } else {
                if (width > this.mMaxBitmapDimension) {
                    width = this.mMaxBitmapDimension;
                }
                if (height > this.mMaxBitmapDimension) {
                    height = this.mMaxBitmapDimension;
                }
                this.mArtworkWidth = width;
                this.mArtworkHeight = height;
            }
        }
        return USE_SESSIONS;
    }

    public boolean setArtworkConfiguration(int width, int height) throws IllegalArgumentException {
        return setArtworkConfiguration(USE_SESSIONS, width, height);
    }

    public boolean clearArtworkConfiguration() {
        return setArtworkConfiguration(DEBUG, -1, -1);
    }

    public boolean setSynchronizationMode(int sync) throws IllegalArgumentException {
        boolean z = DEBUG;
        if (sync != 0 && sync != SENDMSG_NOOP) {
            throw new IllegalArgumentException("Unknown synchronization mode " + sync);
        } else if (this.mIsRegistered) {
            AudioManager audioManager = this.mAudioManager;
            IRemoteControlDisplay iRemoteControlDisplay = this.mRcd;
            if (SENDMSG_NOOP == sync) {
                z = USE_SESSIONS;
            }
            audioManager.remoteControlDisplayWantsPlaybackPositionSync(iRemoteControlDisplay, z);
            return USE_SESSIONS;
        } else {
            Log.e(TAG, "Cannot set synchronization mode on an unregistered RemoteController");
            return DEBUG;
        }
    }

    public MetadataEditor editMetadata() {
        MetadataEditor editor = new MetadataEditor();
        editor.mEditorMetadata = new Bundle();
        editor.mEditorArtwork = null;
        editor.mMetadataChanged = USE_SESSIONS;
        editor.mArtworkChanged = USE_SESSIONS;
        editor.mEditableKeys = 0;
        return editor;
    }

    void startListeningToSessions() {
        ComponentName listenerComponent = new ComponentName(this.mContext, this.mOnClientUpdateListener.getClass());
        Handler handler = null;
        if (Looper.myLooper() == null) {
            handler = new Handler(Looper.getMainLooper());
        }
        this.mSessionManager.addOnActiveSessionsChangedListener(this.mSessionListener, listenerComponent, UserHandle.myUserId(), handler);
        this.mSessionListener.onActiveSessionsChanged(this.mSessionManager.getActiveSessions(listenerComponent));
    }

    void stopListeningToSessions() {
        this.mSessionManager.removeOnActiveSessionsChangedListener(this.mSessionListener);
    }

    private static void sendMsg(Handler handler, int msg, int existingMsgPolicy, int arg1, int arg2, Object obj, int delayMs) {
        if (handler == null) {
            Log.e(TAG, "null event handler, will not deliver message " + msg);
            return;
        }
        if (existingMsgPolicy == 0) {
            handler.removeMessages(msg);
        } else if (existingMsgPolicy == SENDMSG_NOOP && handler.hasMessages(msg)) {
            return;
        }
        handler.sendMessageDelayed(handler.obtainMessage(msg, arg1, arg2, obj), (long) delayMs);
    }

    private void onNewPendingIntent(int genId, PendingIntent pi) {
        synchronized (mGenLock) {
            if (this.mClientGenerationIdCurrent != genId) {
                return;
            }
            synchronized (mInfoLock) {
                this.mClientPendingIntentCurrent = pi;
            }
        }
    }

    private void onNewPlaybackInfo(int genId, PlaybackInfo pi) {
        synchronized (mGenLock) {
            if (this.mClientGenerationIdCurrent != genId) {
                return;
            }
            synchronized (mInfoLock) {
                OnClientUpdateListener l = this.mOnClientUpdateListener;
                this.mLastPlaybackInfo = pi;
            }
            if (l == null) {
                return;
            }
            if (pi.mCurrentPosMs == RemoteControlClient.PLAYBACK_POSITION_ALWAYS_UNKNOWN) {
                l.onClientPlaybackStateUpdate(pi.mState);
            } else {
                l.onClientPlaybackStateUpdate(pi.mState, pi.mStateChangeTimeMs, pi.mCurrentPosMs, pi.mSpeed);
            }
        }
    }

    private void onNewTransportInfo(int genId, int transportControlFlags) {
        synchronized (mGenLock) {
            if (this.mClientGenerationIdCurrent != genId) {
                return;
            }
            synchronized (mInfoLock) {
                OnClientUpdateListener l = this.mOnClientUpdateListener;
            }
            if (l != null) {
                l.onClientTransportControlUpdate(transportControlFlags);
            }
        }
    }

    private void onNewMetadata(int genId, Bundle metadata) {
        synchronized (mGenLock) {
            if (this.mClientGenerationIdCurrent != genId) {
                return;
            }
            long editableKeys = metadata.getLong(String.valueOf(MediaMetadataEditor.KEY_EDITABLE_MASK), 0);
            if (editableKeys != 0) {
                metadata.remove(String.valueOf(MediaMetadataEditor.KEY_EDITABLE_MASK));
            }
            synchronized (mInfoLock) {
                OnClientUpdateListener l = this.mOnClientUpdateListener;
                if (this.mMetadataEditor == null || this.mMetadataEditor.mEditorMetadata == null) {
                    this.mMetadataEditor = new MetadataEditor(metadata, editableKeys);
                } else {
                    if (this.mMetadataEditor.mEditorMetadata != metadata) {
                        this.mMetadataEditor.mEditorMetadata.putAll(metadata);
                    }
                    this.mMetadataEditor.putBitmap(100, (Bitmap) metadata.getParcelable(String.valueOf(100)));
                    this.mMetadataEditor.cleanupBitmapFromBundle(100);
                }
                MetadataEditor metadataEditor = this.mMetadataEditor;
            }
            if (l != null) {
                l.onClientMetadataUpdate(metadataEditor);
            }
        }
    }

    private void onClientChange(int genId, boolean clearing) {
        synchronized (mGenLock) {
            if (this.mClientGenerationIdCurrent != genId) {
                return;
            }
            synchronized (mInfoLock) {
                OnClientUpdateListener l = this.mOnClientUpdateListener;
                this.mMetadataEditor = null;
            }
            if (l != null) {
                l.onClientChange(clearing);
            }
        }
    }

    private void onDisplayEnable(boolean enabled) {
        synchronized (mInfoLock) {
            this.mEnabled = enabled;
            OnClientUpdateListener l = this.mOnClientUpdateListener;
        }
        if (!enabled) {
            int genId;
            synchronized (mGenLock) {
                genId = this.mClientGenerationIdCurrent;
            }
            sendMsg(this.mEventHandler, SENDMSG_NOOP, TRANSPORT_UNKNOWN, genId, TRANSPORT_UNKNOWN, new PlaybackInfo(SENDMSG_NOOP, SystemClock.elapsedRealtime(), 0, 0.0f), TRANSPORT_UNKNOWN);
            sendMsg(this.mEventHandler, SENDMSG_QUEUE, TRANSPORT_UNKNOWN, genId, TRANSPORT_UNKNOWN, null, TRANSPORT_UNKNOWN);
            Bundle metadata = new Bundle((int) MSG_NEW_METADATA);
            metadata.putString(String.valueOf(MSG_NEW_MEDIA_METADATA), ProxyInfo.LOCAL_EXCL_LIST);
            metadata.putString(String.valueOf(SENDMSG_QUEUE), ProxyInfo.LOCAL_EXCL_LIST);
            metadata.putLong(String.valueOf(9), 0);
            sendMsg(this.mEventHandler, MSG_NEW_METADATA, SENDMSG_QUEUE, genId, TRANSPORT_UNKNOWN, metadata, TRANSPORT_UNKNOWN);
        }
    }

    private void updateController(MediaController controller) {
        synchronized (mInfoLock) {
            if (controller == null) {
                if (this.mCurrentSession != null) {
                    Log.v(TAG, "Updating current controller as null");
                    this.mAudioManager.updateMediaPlayerList(this.mCurrentSession.getPackageName(), DEBUG);
                    this.mCurrentSession.unregisterCallback(this.mSessionCb);
                    this.mCurrentSession = null;
                    sendMsg(this.mEventHandler, MSG_CLIENT_CHANGE, TRANSPORT_UNKNOWN, TRANSPORT_UNKNOWN, SENDMSG_NOOP, null, TRANSPORT_UNKNOWN);
                }
            } else if (this.mCurrentSession == null || !controller.getSessionToken().equals(this.mCurrentSession.getSessionToken())) {
                if (this.mCurrentSession != null) {
                    Log.v(TAG, "Updating current controller package as " + controller.getPackageName() + " from " + this.mCurrentSession.getPackageName());
                    this.mCurrentSession.unregisterCallback(this.mSessionCb);
                } else {
                    Log.v(TAG, "Updating current controller package as " + controller.getPackageName() + " from null");
                }
                sendMsg(this.mEventHandler, MSG_CLIENT_CHANGE, TRANSPORT_UNKNOWN, TRANSPORT_UNKNOWN, TRANSPORT_UNKNOWN, null, TRANSPORT_UNKNOWN);
                this.mCurrentSession = controller;
                this.mCurrentSession.registerCallback(this.mSessionCb, this.mEventHandler);
                this.mAudioManager.updateMediaPlayerList(this.mCurrentSession.getPackageName(), USE_SESSIONS);
                sendMsg(this.mEventHandler, MSG_NEW_PLAYBACK_STATE, TRANSPORT_UNKNOWN, TRANSPORT_UNKNOWN, TRANSPORT_UNKNOWN, controller.getPlaybackState(), TRANSPORT_UNKNOWN);
                sendMsg(this.mEventHandler, MSG_NEW_MEDIA_METADATA, TRANSPORT_UNKNOWN, TRANSPORT_UNKNOWN, TRANSPORT_UNKNOWN, controller.getMetadata(), TRANSPORT_UNKNOWN);
            }
        }
    }

    private void onNewPlaybackState(PlaybackState state) {
        synchronized (mInfoLock) {
            OnClientUpdateListener l = this.mOnClientUpdateListener;
        }
        if (l != null) {
            int playstate = state == null ? TRANSPORT_UNKNOWN : PlaybackState.getRccStateFromState(state.getState());
            if (state == null || state.getPosition() == -1) {
                l.onClientPlaybackStateUpdate(playstate);
            } else {
                l.onClientPlaybackStateUpdate(playstate, state.getLastPositionUpdateTime(), state.getPosition(), state.getPlaybackSpeed());
            }
            if (state != null) {
                l.onClientTransportControlUpdate(PlaybackState.getRccControlFlagsFromActions(state.getActions()));
            }
        }
    }

    private void onNewMediaMetadata(MediaMetadata metadata) {
        if (metadata != null) {
            OnClientUpdateListener l;
            MetadataEditor metadataEditor;
            synchronized (mInfoLock) {
                l = this.mOnClientUpdateListener;
                boolean canRate = (this.mCurrentSession == null || this.mCurrentSession.getRatingType() == 0) ? DEBUG : USE_SESSIONS;
                this.mMetadataEditor = new MetadataEditor(MediaSessionLegacyHelper.getOldMetadata(metadata, this.mArtworkWidth, this.mArtworkHeight), canRate ? 268435457 : 0);
                metadataEditor = this.mMetadataEditor;
            }
            if (l != null) {
                l.onClientMetadataUpdate(metadataEditor);
            }
        }
    }

    public void onFolderInfoBrowsedPlayer(String stringUri) {
        Log.d(TAG, "RemoteController: onFolderInfoBrowsedPlayer");
        synchronized (mInfoLock) {
            OnClientUpdateListener l = this.mOnClientUpdateListener;
        }
        if (l != null) {
            l.onClientFolderInfoBrowsedPlayer(stringUri);
        }
    }

    public void onNowPlayingEntriesUpdate(long[] playList) {
        Log.d(TAG, "RemoteController: onUpdateNowPlayingEntries");
        synchronized (mInfoLock) {
            OnClientUpdateListener l = this.mOnClientUpdateListener;
        }
        if (l != null) {
            l.onClientUpdateNowPlayingEntries(playList);
        }
    }

    public void onNowPlayingContentChange() {
        Log.d(TAG, "RemoteController: onNowPlayingContentChange");
        synchronized (mInfoLock) {
            OnClientUpdateListener l = this.mOnClientUpdateListener;
        }
        if (l != null) {
            l.onClientNowPlayingContentChange();
        }
    }

    public void onSetPlayItemResponse(boolean success) {
        Log.d(TAG, "RemoteController: onPlayItemResponse");
        synchronized (mInfoLock) {
            OnClientUpdateListener l = this.mOnClientUpdateListener;
        }
        if (l != null) {
            l.onClientPlayItemResponse(success);
        }
    }

    void setIsRegistered(boolean registered) {
        synchronized (mInfoLock) {
            this.mIsRegistered = registered;
        }
    }

    RcDisplay getRcDisplay() {
        return this.mRcd;
    }

    int[] getArtworkSize() {
        int[] size;
        synchronized (mInfoLock) {
            size = new int[SENDMSG_QUEUE];
            size[TRANSPORT_UNKNOWN] = this.mArtworkWidth;
            size[SENDMSG_NOOP] = this.mArtworkHeight;
        }
        return size;
    }

    OnClientUpdateListener getUpdateListener() {
        return this.mOnClientUpdateListener;
    }
}
