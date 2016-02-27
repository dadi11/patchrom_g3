package android.media.session;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ParceledListSlice;
import android.media.AudioAttributes;
import android.media.MediaDescription;
import android.media.MediaMetadata;
import android.media.MediaMetadata.Builder;
import android.media.Rating;
import android.media.VolumeProvider;
import android.media.session.ISessionCallback.Stub;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.RemoteException;
import android.os.ResultReceiver;
import android.os.UserHandle;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import java.lang.ref.WeakReference;
import java.util.List;

public final class MediaSession {
    public static final int FLAG_EXCLUSIVE_GLOBAL_PRIORITY = 65536;
    public static final int FLAG_HANDLES_MEDIA_BUTTONS = 1;
    public static final int FLAG_HANDLES_TRANSPORT_CONTROLS = 2;
    private static final String TAG = "MediaSession";
    private boolean mActive;
    private final ISession mBinder;
    private CallbackMessageHandler mCallback;
    private final CallbackStub mCbStub;
    private final MediaController mController;
    private final Object mLock;
    private final int mMaxBitmapSize;
    private PlaybackState mPlaybackState;
    private final Token mSessionToken;
    private VolumeProvider mVolumeProvider;

    public static abstract class Callback {
        private MediaSession mSession;

        public void onCommand(String command, Bundle args, ResultReceiver cb) {
        }

        public boolean onMediaButtonEvent(Intent mediaButtonIntent) {
            if (this.mSession != null && Intent.ACTION_MEDIA_BUTTON.equals(mediaButtonIntent.getAction())) {
                KeyEvent ke = (KeyEvent) mediaButtonIntent.getParcelableExtra(Intent.EXTRA_KEY_EVENT);
                if (ke != null && ke.getAction() == 0) {
                    PlaybackState state = this.mSession.mPlaybackState;
                    long validActions = state == null ? 0 : state.getActions();
                    switch (ke.getKeyCode()) {
                        case KeyEvent.KEYCODE_HEADSETHOOK /*79*/:
                        case KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE /*85*/:
                            boolean isPlaying = state == null ? false : state.getState() == 3;
                            boolean canPlay;
                            if ((516 & validActions) != 0) {
                                canPlay = true;
                            } else {
                                canPlay = false;
                            }
                            boolean canPause;
                            if ((514 & validActions) != 0) {
                                canPause = true;
                            } else {
                                canPause = false;
                            }
                            if (isPlaying && canPause) {
                                onPause();
                                return true;
                            } else if (!isPlaying && canPlay) {
                                onPlay();
                                return true;
                            }
                            break;
                        case KeyEvent.KEYCODE_MEDIA_STOP /*86*/:
                            if ((1 & validActions) != 0) {
                                onStop();
                                return true;
                            }
                            break;
                        case KeyEvent.KEYCODE_MEDIA_NEXT /*87*/:
                            if ((32 & validActions) != 0) {
                                onSkipToNext();
                                return true;
                            }
                            break;
                        case KeyEvent.KEYCODE_MEDIA_PREVIOUS /*88*/:
                            if ((16 & validActions) != 0) {
                                onSkipToPrevious();
                                return true;
                            }
                            break;
                        case KeyEvent.KEYCODE_MEDIA_REWIND /*89*/:
                            if ((8 & validActions) != 0) {
                                onRewind();
                                return true;
                            }
                            break;
                        case KeyEvent.KEYCODE_MEDIA_FAST_FORWARD /*90*/:
                            if ((64 & validActions) != 0) {
                                onFastForward();
                                return true;
                            }
                            break;
                        case KeyEvent.KEYCODE_MEDIA_PLAY /*126*/:
                            if ((4 & validActions) != 0) {
                                onPlay();
                                return true;
                            }
                            break;
                        case KeyEvent.KEYCODE_MEDIA_PAUSE /*127*/:
                            if ((2 & validActions) != 0) {
                                onPause();
                                return true;
                            }
                            break;
                    }
                }
            }
            return false;
        }

        public void onPlay() {
        }

        public void onPlayFromMediaId(String mediaId, Bundle extras) {
        }

        public void onPlayFromSearch(String query, Bundle extras) {
        }

        public void onSkipToQueueItem(long id) {
        }

        public void onPause() {
        }

        public void onSkipToNext() {
        }

        public void onSkipToPrevious() {
        }

        public void onFastForward() {
        }

        public void onRewind() {
        }

        public void onStop() {
        }

        public void onSeekTo(long pos) {
        }

        public void onSetRating(Rating rating) {
        }

        public void onCustomAction(String action, Bundle extras) {
        }

        public void setBrowsedPlayer() {
        }

        public void setPlayItem(int scope, long uid) {
        }

        public void getNowPlayingEntries() {
        }
    }

    /* renamed from: android.media.session.MediaSession.1 */
    class C04271 extends android.media.VolumeProvider.Callback {
        C04271() {
        }

        public void onVolumeChanged(VolumeProvider volumeProvider) {
            MediaSession.this.notifyRemoteVolumeChanged(volumeProvider);
        }
    }

    private class CallbackMessageHandler extends Handler {
        private static final int MSG_ADJUST_VOLUME = 16;
        private static final int MSG_COMMAND = 15;
        private static final int MSG_CUSTOM_ACTION = 13;
        private static final int MSG_FAST_FORWARD = 9;
        private static final int MSG_GET_NOW_PLAYING_ITEMS = 20;
        private static final int MSG_MEDIA_BUTTON = 14;
        private static final int MSG_NEXT = 7;
        private static final int MSG_PAUSE = 5;
        private static final int MSG_PLAY = 1;
        private static final int MSG_PLAY_MEDIA_ID = 2;
        private static final int MSG_PLAY_SEARCH = 3;
        private static final int MSG_PREVIOUS = 8;
        private static final int MSG_RATE = 12;
        private static final int MSG_REWIND = 10;
        private static final int MSG_SEEK_TO = 11;
        private static final int MSG_SET_BROWSED_PLAYER = 18;
        private static final int MSG_SET_PLAY_ITEM = 19;
        private static final int MSG_SET_VOLUME = 17;
        private static final int MSG_SKIP_TO_ITEM = 4;
        private static final int MSG_STOP = 6;
        private Callback mCallback;

        public CallbackMessageHandler(Looper looper, Callback callback) {
            super(looper, null, true);
            this.mCallback = callback;
        }

        public void post(int what, Object obj, Bundle bundle) {
            Message msg = obtainMessage(what, obj);
            msg.setData(bundle);
            msg.sendToTarget();
        }

        public void post(int what, Object obj) {
            obtainMessage(what, obj).sendToTarget();
        }

        public void post(int what) {
            post(what, null);
        }

        public void post(int what, Object obj, int arg1) {
            obtainMessage(what, arg1, 0, obj).sendToTarget();
        }

        public void handleMessage(Message msg) {
            VolumeProvider vp;
            switch (msg.what) {
                case MSG_PLAY /*1*/:
                    this.mCallback.onPlay();
                    return;
                case MSG_PLAY_MEDIA_ID /*2*/:
                    this.mCallback.onPlayFromMediaId((String) msg.obj, msg.getData());
                    return;
                case MSG_PLAY_SEARCH /*3*/:
                    this.mCallback.onPlayFromSearch((String) msg.obj, msg.getData());
                    return;
                case MSG_SKIP_TO_ITEM /*4*/:
                    this.mCallback.onSkipToQueueItem(((Long) msg.obj).longValue());
                    return;
                case MSG_PAUSE /*5*/:
                    this.mCallback.onPause();
                    return;
                case MSG_STOP /*6*/:
                    this.mCallback.onStop();
                    return;
                case MSG_NEXT /*7*/:
                    this.mCallback.onSkipToNext();
                    return;
                case MSG_PREVIOUS /*8*/:
                    this.mCallback.onSkipToPrevious();
                    return;
                case MSG_FAST_FORWARD /*9*/:
                    this.mCallback.onFastForward();
                    return;
                case MSG_REWIND /*10*/:
                    this.mCallback.onRewind();
                    return;
                case MSG_SEEK_TO /*11*/:
                    this.mCallback.onSeekTo(((Long) msg.obj).longValue());
                    return;
                case MSG_RATE /*12*/:
                    this.mCallback.onSetRating((Rating) msg.obj);
                    return;
                case MSG_CUSTOM_ACTION /*13*/:
                    this.mCallback.onCustomAction((String) msg.obj, msg.getData());
                    return;
                case MSG_MEDIA_BUTTON /*14*/:
                    this.mCallback.onMediaButtonEvent((Intent) msg.obj);
                    return;
                case MSG_COMMAND /*15*/:
                    Command cmd = msg.obj;
                    this.mCallback.onCommand(cmd.command, cmd.extras, cmd.stub);
                    return;
                case MSG_ADJUST_VOLUME /*16*/:
                    synchronized (MediaSession.this.mLock) {
                        vp = MediaSession.this.mVolumeProvider;
                        break;
                    }
                    if (vp != null) {
                        vp.onAdjustVolume(((Integer) msg.obj).intValue());
                        return;
                    }
                    return;
                case MSG_SET_VOLUME /*17*/:
                    synchronized (MediaSession.this.mLock) {
                        vp = MediaSession.this.mVolumeProvider;
                        break;
                    }
                    if (vp != null) {
                        vp.onSetVolumeTo(((Integer) msg.obj).intValue());
                        break;
                    }
                    break;
                case MSG_SET_BROWSED_PLAYER /*18*/:
                    break;
                case MSG_SET_PLAY_ITEM /*19*/:
                    Log.d(MediaSession.TAG, "MSG_SET_PLAY_ITEM received in CallbackMessageHandler");
                    PlayItemToken playItemToken = msg.obj;
                    this.mCallback.setPlayItem(playItemToken.getScope(), playItemToken.getUid());
                    return;
                case MSG_GET_NOW_PLAYING_ITEMS /*20*/:
                    Log.d(MediaSession.TAG, "MSG_GET_NOW_PLAYING_ITEMS received in CallbackMessageHandler");
                    this.mCallback.getNowPlayingEntries();
                    return;
                default:
                    return;
            }
            Log.d(MediaSession.TAG, "MSG_SET_BROWSED_PLAYER received in CallbackMessageHandler");
            this.mCallback.setBrowsedPlayer();
        }
    }

    public static class CallbackStub extends Stub {
        private WeakReference<MediaSession> mMediaSession;

        public CallbackStub(MediaSession session) {
            this.mMediaSession = new WeakReference(session);
        }

        public void onCommand(String command, Bundle args, ResultReceiver cb) {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.postCommand(command, args, cb);
            }
        }

        public void onMediaButton(Intent mediaButtonIntent, int sequenceNumber, ResultReceiver cb) {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                try {
                    session.dispatchMediaButton(mediaButtonIntent);
                } catch (Throwable th) {
                    if (cb != null) {
                        cb.send(sequenceNumber, null);
                    }
                }
            }
            if (cb != null) {
                cb.send(sequenceNumber, null);
            }
        }

        public void onPlay() {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchPlay();
            }
        }

        public void onPlayFromMediaId(String mediaId, Bundle extras) {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchPlayFromMediaId(mediaId, extras);
            }
        }

        public void onPlayFromSearch(String query, Bundle extras) {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchPlayFromSearch(query, extras);
            }
        }

        public void onSkipToTrack(long id) {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchSkipToItem(id);
            }
        }

        public void onPause() {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchPause();
            }
        }

        public void onStop() {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchStop();
            }
        }

        public void onNext() {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchNext();
            }
        }

        public void onPrevious() {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchPrevious();
            }
        }

        public void onFastForward() {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchFastForward();
            }
        }

        public void onRewind() {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchRewind();
            }
        }

        public void onSeekTo(long pos) {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchSeekTo(pos);
            }
        }

        public void onRate(Rating rating) {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchRate(rating);
            }
        }

        public void setRemoteControlClientBrowsedPlayer() throws RemoteException {
            Log.d(MediaSession.TAG, "setRemoteControlClientBrowsedPlayer in CallbackStub");
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchSetBrowsedPlayerCommand();
            }
        }

        public void setRemoteControlClientPlayItem(long uid, int scope) throws RemoteException {
            Log.d(MediaSession.TAG, "setRemoteControlClientPlayItem in CallbackStub");
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchSetPlayItemCommand(uid, scope);
            }
        }

        public void getRemoteControlClientNowPlayingEntries() throws RemoteException {
            Log.d(MediaSession.TAG, "getRemoteControlClientNowPlayingEntries in CallbackStub");
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchGetNowPlayingItemsCommand();
            }
        }

        public void onCustomAction(String action, Bundle args) {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchCustomAction(action, args);
            }
        }

        public void onAdjustVolume(int direction) {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchAdjustVolume(direction);
            }
        }

        public void onSetVolumeTo(int value) {
            MediaSession session = (MediaSession) this.mMediaSession.get();
            if (session != null) {
                session.dispatchSetVolumeTo(value);
            }
        }
    }

    private static final class Command {
        public final String command;
        public final Bundle extras;
        public final ResultReceiver stub;

        public Command(String command, Bundle extras, ResultReceiver stub) {
            this.command = command;
            this.extras = extras;
            this.stub = stub;
        }
    }

    private class PlayItemToken {
        private int mScope;
        private long mUid;

        public PlayItemToken(long uid, int scope) {
            this.mUid = uid;
            this.mScope = scope;
        }

        public int getScope() {
            return this.mScope;
        }

        public long getUid() {
            return this.mUid;
        }
    }

    public static final class QueueItem implements Parcelable {
        public static final Creator<QueueItem> CREATOR;
        public static final int UNKNOWN_ID = -1;
        private final MediaDescription mDescription;
        private final long mId;

        /* renamed from: android.media.session.MediaSession.QueueItem.1 */
        static class C04281 implements Creator<QueueItem> {
            C04281() {
            }

            public QueueItem createFromParcel(Parcel p) {
                return new QueueItem(null);
            }

            public QueueItem[] newArray(int size) {
                return new QueueItem[size];
            }
        }

        public QueueItem(MediaDescription description, long id) {
            if (description == null) {
                throw new IllegalArgumentException("Description cannot be null.");
            } else if (id == -1) {
                throw new IllegalArgumentException("Id cannot be QueueItem.UNKNOWN_ID");
            } else {
                this.mDescription = description;
                this.mId = id;
            }
        }

        private QueueItem(Parcel in) {
            this.mDescription = (MediaDescription) MediaDescription.CREATOR.createFromParcel(in);
            this.mId = in.readLong();
        }

        public MediaDescription getDescription() {
            return this.mDescription;
        }

        public long getQueueId() {
            return this.mId;
        }

        public void writeToParcel(Parcel dest, int flags) {
            this.mDescription.writeToParcel(dest, flags);
            dest.writeLong(this.mId);
        }

        public int describeContents() {
            return 0;
        }

        static {
            CREATOR = new C04281();
        }

        public String toString() {
            return "MediaSession.QueueItem {Description=" + this.mDescription + ", Id=" + this.mId + " }";
        }
    }

    public static final class Token implements Parcelable {
        public static final Creator<Token> CREATOR;
        private ISessionController mBinder;

        /* renamed from: android.media.session.MediaSession.Token.1 */
        static class C04291 implements Creator<Token> {
            C04291() {
            }

            public Token createFromParcel(Parcel in) {
                return new Token(ISessionController.Stub.asInterface(in.readStrongBinder()));
            }

            public Token[] newArray(int size) {
                return new Token[size];
            }
        }

        public Token(ISessionController binder) {
            this.mBinder = binder;
        }

        public int describeContents() {
            return 0;
        }

        public void writeToParcel(Parcel dest, int flags) {
            dest.writeStrongBinder(this.mBinder.asBinder());
        }

        public int hashCode() {
            return (this.mBinder == null ? 0 : this.mBinder.asBinder().hashCode()) + 31;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null) {
                return false;
            }
            if (getClass() != obj.getClass()) {
                return false;
            }
            Token other = (Token) obj;
            if (this.mBinder == null) {
                if (other.mBinder != null) {
                    return false;
                }
                return true;
            } else if (this.mBinder.asBinder().equals(other.mBinder.asBinder())) {
                return true;
            } else {
                return false;
            }
        }

        ISessionController getBinder() {
            return this.mBinder;
        }

        static {
            CREATOR = new C04291();
        }
    }

    public MediaSession(Context context, String tag) {
        this(context, tag, UserHandle.myUserId());
    }

    public MediaSession(Context context, String tag, int userId) {
        this.mLock = new Object();
        this.mActive = false;
        if (context == null) {
            throw new IllegalArgumentException("context cannot be null.");
        } else if (TextUtils.isEmpty(tag)) {
            throw new IllegalArgumentException("tag cannot be null or empty");
        } else {
            this.mMaxBitmapSize = context.getResources().getDimensionPixelSize(17104911);
            this.mCbStub = new CallbackStub(this);
            try {
                this.mBinder = ((MediaSessionManager) context.getSystemService(Context.MEDIA_SESSION_SERVICE)).createSession(this.mCbStub, tag, userId);
                this.mSessionToken = new Token(this.mBinder.getController());
                this.mController = new MediaController(context, this.mSessionToken);
            } catch (RemoteException e) {
                throw new RuntimeException("Remote error creating session.", e);
            }
        }
    }

    public void setCallback(Callback callback) {
        setCallback(callback, null);
    }

    public void setCallback(Callback callback, Handler handler) {
        synchronized (this.mLock) {
            if (callback == null) {
                if (this.mCallback != null) {
                    this.mCallback.mCallback.mSession = null;
                }
                this.mCallback = null;
                return;
            }
            if (this.mCallback != null) {
                this.mCallback.mCallback.mSession = null;
            }
            if (handler == null) {
                handler = new Handler();
            }
            callback.mSession = this;
            this.mCallback = new CallbackMessageHandler(handler.getLooper(), callback);
        }
    }

    public void setSessionActivity(PendingIntent pi) {
        try {
            this.mBinder.setLaunchPendingIntent(pi);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Failure in setLaunchPendingIntent.", e);
        }
    }

    public void setMediaButtonReceiver(PendingIntent mbr) {
        try {
            this.mBinder.setMediaButtonReceiver(mbr);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Failure in setMediaButtonReceiver.", e);
        }
    }

    public void setFlags(int flags) {
        try {
            this.mBinder.setFlags(flags);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Failure in setFlags.", e);
        }
    }

    public void setPlaybackToLocal(AudioAttributes attributes) {
        if (attributes == null) {
            throw new IllegalArgumentException("Attributes cannot be null for local playback.");
        }
        try {
            this.mBinder.setPlaybackToLocal(attributes);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Failure in setPlaybackToLocal.", e);
        }
    }

    public void setPlaybackToRemote(VolumeProvider volumeProvider) {
        if (volumeProvider == null) {
            throw new IllegalArgumentException("volumeProvider may not be null!");
        }
        synchronized (this.mLock) {
            this.mVolumeProvider = volumeProvider;
        }
        volumeProvider.setCallback(new C04271());
        try {
            this.mBinder.setPlaybackToRemote(volumeProvider.getVolumeControl(), volumeProvider.getMaxVolume());
            this.mBinder.setCurrentVolume(volumeProvider.getCurrentVolume());
        } catch (RemoteException e) {
            Log.wtf(TAG, "Failure in setPlaybackToRemote.", e);
        }
    }

    public void setActive(boolean active) {
        if (this.mActive != active) {
            try {
                this.mBinder.setActive(active);
                this.mActive = active;
            } catch (RemoteException e) {
                Log.wtf(TAG, "Failure in setActive.", e);
            }
        }
    }

    public boolean isActive() {
        return this.mActive;
    }

    public void sendSessionEvent(String event, Bundle extras) {
        if (TextUtils.isEmpty(event)) {
            throw new IllegalArgumentException("event cannot be null or empty");
        }
        try {
            this.mBinder.sendEvent(event, extras);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Error sending event", e);
        }
    }

    public void release() {
        try {
            this.mBinder.destroy();
        } catch (RemoteException e) {
            Log.wtf(TAG, "Error releasing session: ", e);
        }
    }

    public Token getSessionToken() {
        return this.mSessionToken;
    }

    public MediaController getController() {
        return this.mController;
    }

    public void setPlaybackState(PlaybackState state) {
        this.mPlaybackState = state;
        try {
            this.mBinder.setPlaybackState(state);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Dead object in setPlaybackState.", e);
        }
    }

    public void setMetadata(MediaMetadata metadata) {
        if (metadata != null) {
            metadata = new Builder(metadata, this.mMaxBitmapSize).build();
        }
        try {
            this.mBinder.setMetadata(metadata);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Dead object in setPlaybackState.", e);
        }
    }

    public void setQueue(List<QueueItem> queue) {
        try {
            this.mBinder.setQueue(queue == null ? null : new ParceledListSlice(queue));
        } catch (RemoteException e) {
            Log.wtf("Dead object in setQueue.", e);
        }
    }

    public void setQueueTitle(CharSequence title) {
        try {
            this.mBinder.setQueueTitle(title);
        } catch (RemoteException e) {
            Log.wtf("Dead object in setQueueTitle.", e);
        }
    }

    public void setRatingType(int type) {
        try {
            this.mBinder.setRatingType(type);
        } catch (RemoteException e) {
            Log.e(TAG, "Error in setRatingType.", e);
        }
    }

    public void setExtras(Bundle extras) {
        try {
            this.mBinder.setExtras(extras);
        } catch (RemoteException e) {
            Log.wtf("Dead object in setExtras.", e);
        }
    }

    public void playItemResponse(boolean success) {
        Log.d(TAG, "MediaSession: playItemResponse");
        try {
            this.mBinder.playItemResponse(success);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Dead object in playItemResponse.", e);
        }
    }

    public void updateNowPlayingEntries(long[] playList) {
        Log.d(TAG, "MediaSession: updateNowPlayingEntries");
        try {
            this.mBinder.updateNowPlayingEntries(playList);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Dead object in updateNowPlayingEntries.", e);
        }
    }

    public void updateFolderInfoBrowsedPlayer(String stringUri) {
        Log.d(TAG, "MediaSession: updateFolderInfoBrowsedPlayer");
        try {
            this.mBinder.updateFolderInfoBrowsedPlayer(stringUri);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Dead object in updateFolderInfoBrowsedPlayer.", e);
        }
    }

    public void updateNowPlayingContentChange() {
        Log.d(TAG, "MediaSession: updateNowPlayingContentChange");
        try {
            this.mBinder.updateNowPlayingContentChange();
        } catch (RemoteException e) {
            Log.wtf(TAG, "Dead object in updateNowPlayingContentChange.", e);
        }
    }

    public void notifyRemoteVolumeChanged(VolumeProvider provider) {
        synchronized (this.mLock) {
            if (provider != null) {
                if (provider == this.mVolumeProvider) {
                    try {
                        this.mBinder.setCurrentVolume(provider.getCurrentVolume());
                        return;
                    } catch (RemoteException e) {
                        Log.e(TAG, "Error in notifyVolumeChanged", e);
                        return;
                    }
                }
            }
            Log.w(TAG, "Received update from stale volume provider");
        }
    }

    private void dispatchPlay() {
        postToCallback(FLAG_HANDLES_MEDIA_BUTTONS);
    }

    private void dispatchPlayFromMediaId(String mediaId, Bundle extras) {
        postToCallback(FLAG_HANDLES_TRANSPORT_CONTROLS, mediaId, extras);
    }

    private void dispatchPlayFromSearch(String query, Bundle extras) {
        postToCallback(3, query, extras);
    }

    private void dispatchSkipToItem(long id) {
        postToCallback(4, Long.valueOf(id));
    }

    private void dispatchPause() {
        postToCallback(5);
    }

    private void dispatchStop() {
        postToCallback(6);
    }

    private void dispatchNext() {
        postToCallback(7);
    }

    private void dispatchPrevious() {
        postToCallback(8);
    }

    private void dispatchFastForward() {
        postToCallback(9);
    }

    private void dispatchRewind() {
        postToCallback(10);
    }

    private void dispatchSeekTo(long pos) {
        postToCallback(11, Long.valueOf(pos));
    }

    private void dispatchRate(Rating rating) {
        postToCallback(12, rating);
    }

    private void dispatchCustomAction(String action, Bundle args) {
        postToCallback(13, action, args);
    }

    private void dispatchSetBrowsedPlayerCommand() {
        postToCallback(18);
    }

    private void dispatchSetPlayItemCommand(long uid, int scope) {
        postToCallback(19, new PlayItemToken(uid, scope));
    }

    private void dispatchGetNowPlayingItemsCommand() {
        postToCallback(20);
    }

    private void dispatchMediaButton(Intent mediaButtonIntent) {
        postToCallback(14, mediaButtonIntent);
    }

    private void dispatchAdjustVolume(int direction) {
        postToCallback(16, Integer.valueOf(direction));
    }

    private void dispatchSetVolumeTo(int volume) {
        postToCallback(17, Integer.valueOf(volume));
    }

    private void postToCallback(int what) {
        postToCallback(what, null);
    }

    private void postCommand(String command, Bundle args, ResultReceiver resultCb) {
        postToCallback(15, new Command(command, args, resultCb));
    }

    private void postToCallback(int what, Object obj) {
        postToCallback(what, obj, null);
    }

    private void postToCallback(int what, Object obj, Bundle extras) {
        synchronized (this.mLock) {
            if (this.mCallback != null) {
                this.mCallback.post(what, obj, extras);
            }
        }
    }

    public static boolean isActiveState(int state) {
        switch (state) {
            case SetDrawableParameters.TAG /*3*/:
            case ViewGroupAction.TAG /*4*/:
            case ReflectionActionWithoutParams.TAG /*5*/:
            case SetEmptyView.TAG /*6*/:
            case SetPendingIntentTemplate.TAG /*8*/:
            case SetOnClickFillInIntent.TAG /*9*/:
            case SetRemoteViewsAdapterIntent.TAG /*10*/:
                return true;
            default:
                return false;
        }
    }
}
