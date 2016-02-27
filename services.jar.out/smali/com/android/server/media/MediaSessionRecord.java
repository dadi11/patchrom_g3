package com.android.server.media;

import android.app.PendingIntent;
import android.content.Intent;
import android.content.pm.ParceledListSlice;
import android.media.AudioAttributes;
import android.media.AudioManager;
import android.media.AudioManagerInternal;
import android.media.AudioSystem;
import android.media.MediaMetadata;
import android.media.MediaMetadata.Builder;
import android.media.Rating;
import android.media.session.ISession;
import android.media.session.ISessionCallback;
import android.media.session.ISessionController;
import android.media.session.ISessionController.Stub;
import android.media.session.ISessionControllerCallback;
import android.media.session.MediaSession;
import android.media.session.ParcelableVolumeInfo;
import android.media.session.PlaybackState;
import android.os.Binder;
import android.os.Bundle;
import android.os.DeadObjectException;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.ResultReceiver;
import android.os.SystemClock;
import android.util.Log;
import android.util.Slog;
import android.view.KeyEvent;
import com.android.server.LocalServices;
import com.android.server.voiceinteraction.SoundTriggerHelper;
import java.io.PrintWriter;
import java.util.ArrayList;

public class MediaSessionRecord implements DeathRecipient {
    private static final int ACTIVE_BUFFER = 30000;
    private static final boolean DEBUG = false;
    private static final int OPTIMISTIC_VOLUME_TIMEOUT = 1000;
    private static final String TAG = "MediaSessionRecord";
    private AudioAttributes mAudioAttrs;
    private AudioManager mAudioManager;
    private AudioManagerInternal mAudioManagerInternal;
    private String mBrowsedPlayerURI;
    private final Runnable mClearOptimisticVolumeRunnable;
    private final ControllerStub mController;
    private final ArrayList<ISessionControllerCallback> mControllerCallbacks;
    private int mCurrentVolume;
    private boolean mDestroyed;
    private Bundle mExtras;
    private long mFlags;
    private final MessageHandler mHandler;
    private boolean mIsActive;
    private long mLastActiveTime;
    private PendingIntent mLaunchIntent;
    private final Object mLock;
    private int mMaxVolume;
    private PendingIntent mMediaButtonReceiver;
    private MediaMetadata mMetadata;
    private long[] mNowPlayingList;
    private int mOptimisticVolume;
    private final int mOwnerPid;
    private final int mOwnerUid;
    private final String mPackageName;
    private boolean mPlayItemStatus;
    private PlaybackState mPlaybackState;
    private ParceledListSlice mQueue;
    private CharSequence mQueueTitle;
    private int mRatingType;
    private final MediaSessionService mService;
    private final SessionStub mSession;
    private final SessionCb mSessionCb;
    private final String mTag;
    private final boolean mUseMasterVolume;
    private final int mUserId;
    private int mVolumeControlType;
    private int mVolumeType;

    /* renamed from: com.android.server.media.MediaSessionRecord.1 */
    class C03761 implements Runnable {
        C03761() {
        }

        public void run() {
            boolean needUpdate = MediaSessionRecord.this.mOptimisticVolume != MediaSessionRecord.this.mCurrentVolume ? true : MediaSessionRecord.DEBUG;
            MediaSessionRecord.this.mOptimisticVolume = -1;
            if (needUpdate) {
                MediaSessionRecord.this.pushVolumeUpdate();
            }
        }
    }

    class ControllerStub extends Stub {
        ControllerStub() {
        }

        public void sendCommand(String command, Bundle args, ResultReceiver cb) throws RemoteException {
            MediaSessionRecord.this.mSessionCb.sendCommand(command, args, cb);
        }

        public boolean sendMediaButton(KeyEvent mediaButtonIntent) {
            return MediaSessionRecord.this.mSessionCb.sendMediaButton(mediaButtonIntent, 0, null);
        }

        public void registerCallbackListener(ISessionControllerCallback cb) {
            synchronized (MediaSessionRecord.this.mLock) {
                if (MediaSessionRecord.this.mDestroyed) {
                    try {
                        cb.onSessionDestroyed();
                    } catch (Exception e) {
                    }
                    return;
                }
                if (MediaSessionRecord.this.getControllerCbIndexForCb(cb) < 0) {
                    MediaSessionRecord.this.mControllerCallbacks.add(cb);
                }
            }
        }

        public void unregisterCallbackListener(ISessionControllerCallback cb) throws RemoteException {
            synchronized (MediaSessionRecord.this.mLock) {
                int index = MediaSessionRecord.this.getControllerCbIndexForCb(cb);
                if (index != -1) {
                    MediaSessionRecord.this.mControllerCallbacks.remove(index);
                }
            }
        }

        public String getPackageName() {
            return MediaSessionRecord.this.mPackageName;
        }

        public String getTag() {
            return MediaSessionRecord.this.mTag;
        }

        public PendingIntent getLaunchPendingIntent() {
            return MediaSessionRecord.this.mLaunchIntent;
        }

        public long getFlags() {
            return MediaSessionRecord.this.mFlags;
        }

        public ParcelableVolumeInfo getVolumeAttributes() {
            ParcelableVolumeInfo parcelableVolumeInfo;
            synchronized (MediaSessionRecord.this.mLock) {
                int type;
                int max;
                int current;
                if (MediaSessionRecord.this.mVolumeType == 2) {
                    type = MediaSessionRecord.this.mVolumeControlType;
                    max = MediaSessionRecord.this.mMaxVolume;
                    current = MediaSessionRecord.this.mOptimisticVolume != -1 ? MediaSessionRecord.this.mOptimisticVolume : MediaSessionRecord.this.mCurrentVolume;
                } else {
                    int stream = AudioAttributes.toLegacyStreamType(MediaSessionRecord.this.mAudioAttrs);
                    type = 2;
                    max = MediaSessionRecord.this.mAudioManager.getStreamMaxVolume(stream);
                    current = MediaSessionRecord.this.mAudioManager.getStreamVolume(stream);
                }
                parcelableVolumeInfo = new ParcelableVolumeInfo(MediaSessionRecord.this.mVolumeType, MediaSessionRecord.this.mAudioAttrs, type, max, current);
            }
            return parcelableVolumeInfo;
        }

        public void adjustVolume(int direction, int flags, String packageName) {
            int uid = Binder.getCallingUid();
            long token = Binder.clearCallingIdentity();
            try {
                MediaSessionRecord.this.adjustVolume(direction, flags, packageName, uid, MediaSessionRecord.DEBUG);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void setVolumeTo(int value, int flags, String packageName) {
            int uid = Binder.getCallingUid();
            long token = Binder.clearCallingIdentity();
            try {
                MediaSessionRecord.this.setVolumeTo(value, flags, packageName, uid);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void play() throws RemoteException {
            MediaSessionRecord.this.mSessionCb.play();
        }

        public void playFromMediaId(String mediaId, Bundle extras) throws RemoteException {
            MediaSessionRecord.this.mSessionCb.playFromMediaId(mediaId, extras);
        }

        public void playFromSearch(String query, Bundle extras) throws RemoteException {
            MediaSessionRecord.this.mSessionCb.playFromSearch(query, extras);
        }

        public void skipToQueueItem(long id) {
            MediaSessionRecord.this.mSessionCb.skipToTrack(id);
        }

        public void pause() throws RemoteException {
            MediaSessionRecord.this.mSessionCb.pause();
        }

        public void stop() throws RemoteException {
            MediaSessionRecord.this.mSessionCb.stop();
        }

        public void next() throws RemoteException {
            MediaSessionRecord.this.mSessionCb.next();
        }

        public void previous() throws RemoteException {
            MediaSessionRecord.this.mSessionCb.previous();
        }

        public void fastForward() throws RemoteException {
            MediaSessionRecord.this.mSessionCb.fastForward();
        }

        public void rewind() throws RemoteException {
            MediaSessionRecord.this.mSessionCb.rewind();
        }

        public void seekTo(long pos) throws RemoteException {
            Log.d(MediaSessionRecord.TAG, "seekTo in ControllerStub");
            MediaSessionRecord.this.mSessionCb.seekTo(pos);
        }

        public void setRemoteControlClientBrowsedPlayer() throws RemoteException {
            Log.d(MediaSessionRecord.TAG, "setRemoteControlClientBrowsedPlayer in ControllerStub");
            MediaSessionRecord.this.mSessionCb.setRemoteControlClientBrowsedPlayer();
        }

        public void setRemoteControlClientPlayItem(long uid, int scope) throws RemoteException {
            Log.d(MediaSessionRecord.TAG, "setRemoteControlClientPlayItem in ControllerStub");
            MediaSessionRecord.this.mSessionCb.setRemoteControlClientPlayItem(uid, scope);
        }

        public void getRemoteControlClientNowPlayingEntries() throws RemoteException {
            Log.d(MediaSessionRecord.TAG, "getRemoteControlClientNowPlayingEntries in ControllerStub");
            MediaSessionRecord.this.mSessionCb.getRemoteControlClientNowPlayingEntries();
        }

        public void rate(Rating rating) throws RemoteException {
            MediaSessionRecord.this.mSessionCb.rate(rating);
        }

        public void sendCustomAction(String action, Bundle args) throws RemoteException {
            MediaSessionRecord.this.mSessionCb.sendCustomAction(action, args);
        }

        public MediaMetadata getMetadata() {
            MediaMetadata access$1300;
            synchronized (MediaSessionRecord.this.mLock) {
                access$1300 = MediaSessionRecord.this.mMetadata;
            }
            return access$1300;
        }

        public PlaybackState getPlaybackState() {
            return MediaSessionRecord.this.getStateWithUpdatedPosition();
        }

        public ParceledListSlice getQueue() {
            ParceledListSlice access$1600;
            synchronized (MediaSessionRecord.this.mLock) {
                access$1600 = MediaSessionRecord.this.mQueue;
            }
            return access$1600;
        }

        public CharSequence getQueueTitle() {
            return MediaSessionRecord.this.mQueueTitle;
        }

        public Bundle getExtras() {
            Bundle access$2100;
            synchronized (MediaSessionRecord.this.mLock) {
                access$2100 = MediaSessionRecord.this.mExtras;
            }
            return access$2100;
        }

        public int getRatingType() {
            return MediaSessionRecord.this.mRatingType;
        }

        public boolean isTransportControlEnabled() {
            return MediaSessionRecord.this.isTransportControlEnabled();
        }
    }

    private class MessageHandler extends Handler {
        private static final int MSG_DESTROYED = 13;
        private static final int MSG_FOLDER_INFO_BROWSED_PLAYER = 9;
        private static final int MSG_PLAY_ITEM_RESPONSE = 12;
        private static final int MSG_SEND_EVENT = 6;
        private static final int MSG_UPDATE_EXTRAS = 5;
        private static final int MSG_UPDATE_METADATA = 1;
        private static final int MSG_UPDATE_NOWPLAYING_CONTENT_CHANGE = 11;
        private static final int MSG_UPDATE_NOWPLAYING_ENTRIES = 10;
        private static final int MSG_UPDATE_PLAYBACK_STATE = 2;
        private static final int MSG_UPDATE_QUEUE = 3;
        private static final int MSG_UPDATE_QUEUE_TITLE = 4;
        private static final int MSG_UPDATE_SESSION_STATE = 7;
        private static final int MSG_UPDATE_VOLUME = 8;

        public MessageHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case MSG_UPDATE_METADATA /*1*/:
                    MediaSessionRecord.this.pushMetadataUpdate();
                case MSG_UPDATE_PLAYBACK_STATE /*2*/:
                    MediaSessionRecord.this.pushPlaybackStateUpdate();
                case MSG_UPDATE_QUEUE /*3*/:
                    MediaSessionRecord.this.pushQueueUpdate();
                case MSG_UPDATE_QUEUE_TITLE /*4*/:
                    MediaSessionRecord.this.pushQueueTitleUpdate();
                case MSG_UPDATE_EXTRAS /*5*/:
                    MediaSessionRecord.this.pushExtrasUpdate();
                case MSG_SEND_EVENT /*6*/:
                    MediaSessionRecord.this.pushEvent((String) msg.obj, msg.getData());
                case MSG_UPDATE_VOLUME /*8*/:
                    MediaSessionRecord.this.pushVolumeUpdate();
                case MSG_FOLDER_INFO_BROWSED_PLAYER /*9*/:
                    MediaSessionRecord.this.pushBrowsePlayerInfo();
                case MSG_UPDATE_NOWPLAYING_ENTRIES /*10*/:
                    MediaSessionRecord.this.pushNowPlayingEntries();
                case MSG_UPDATE_NOWPLAYING_CONTENT_CHANGE /*11*/:
                    MediaSessionRecord.this.pushNowPlayingContentChange();
                case MSG_PLAY_ITEM_RESPONSE /*12*/:
                    MediaSessionRecord.this.pushPlayItemResponse();
                case MSG_DESTROYED /*13*/:
                    MediaSessionRecord.this.pushSessionDestroyed();
                default:
            }
        }

        public void post(int what) {
            post(what, null);
        }

        public void post(int what, Object obj) {
            obtainMessage(what, obj).sendToTarget();
        }

        public void post(int what, Object obj, Bundle data) {
            Message msg = obtainMessage(what, obj);
            msg.setData(data);
            msg.sendToTarget();
        }
    }

    class SessionCb {
        private final ISessionCallback mCb;

        public SessionCb(ISessionCallback cb) {
            this.mCb = cb;
        }

        public boolean sendMediaButton(KeyEvent keyEvent, int sequenceId, ResultReceiver cb) {
            Intent mediaButtonIntent = new Intent("android.intent.action.MEDIA_BUTTON");
            mediaButtonIntent.putExtra("android.intent.extra.KEY_EVENT", keyEvent);
            try {
                this.mCb.onMediaButton(mediaButtonIntent, sequenceId, cb);
                return true;
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in sendMediaRequest.", e);
                return MediaSessionRecord.DEBUG;
            }
        }

        public void sendCommand(String command, Bundle args, ResultReceiver cb) {
            try {
                this.mCb.onCommand(command, args, cb);
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in sendCommand.", e);
            }
        }

        public void sendCustomAction(String action, Bundle args) {
            try {
                this.mCb.onCustomAction(action, args);
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in sendCustomAction.", e);
            }
        }

        public void play() {
            try {
                this.mCb.onPlay();
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in play.", e);
            }
        }

        public void playFromMediaId(String mediaId, Bundle extras) {
            try {
                this.mCb.onPlayFromMediaId(mediaId, extras);
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in playUri.", e);
            }
        }

        public void playFromSearch(String query, Bundle extras) {
            try {
                this.mCb.onPlayFromSearch(query, extras);
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in playFromSearch.", e);
            }
        }

        public void skipToTrack(long id) {
            try {
                this.mCb.onSkipToTrack(id);
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in skipToTrack", e);
            }
        }

        public void pause() {
            try {
                this.mCb.onPause();
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in pause.", e);
            }
        }

        public void stop() {
            try {
                this.mCb.onStop();
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in stop.", e);
            }
        }

        public void next() {
            try {
                this.mCb.onNext();
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in next.", e);
            }
        }

        public void previous() {
            try {
                this.mCb.onPrevious();
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in previous.", e);
            }
        }

        public void fastForward() {
            try {
                this.mCb.onFastForward();
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in fastForward.", e);
            }
        }

        public void rewind() {
            try {
                this.mCb.onRewind();
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in rewind.", e);
            }
        }

        public void seekTo(long pos) {
            Slog.d(MediaSessionRecord.TAG, "seekTo in SessionCb");
            try {
                this.mCb.onSeekTo(pos);
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in seekTo.", e);
            }
        }

        public void setRemoteControlClientBrowsedPlayer() {
            Slog.d(MediaSessionRecord.TAG, "setRemoteControlClientBrowsedPlayer in SessionCb");
            try {
                this.mCb.setRemoteControlClientBrowsedPlayer();
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in setRemoteControlClientBrowsedPlayer.", e);
            }
        }

        public void setRemoteControlClientPlayItem(long uid, int scope) throws RemoteException {
            Slog.d(MediaSessionRecord.TAG, "setRemoteControlClientPlayItem in SessionCb");
            try {
                this.mCb.setRemoteControlClientPlayItem(uid, scope);
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in setRemoteControlClientPlayItem.", e);
            }
        }

        public void getRemoteControlClientNowPlayingEntries() throws RemoteException {
            Slog.d(MediaSessionRecord.TAG, "getRemoteControlClientNowPlayingEntries in SessionCb");
            try {
                this.mCb.getRemoteControlClientNowPlayingEntries();
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in getRemoteControlClientNowPlayingEntries.", e);
            }
        }

        public void rate(Rating rating) {
            try {
                this.mCb.onRate(rating);
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in rate.", e);
            }
        }

        public void adjustVolume(int direction) {
            try {
                this.mCb.onAdjustVolume(direction);
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in adjustVolume.", e);
            }
        }

        public void setVolumeTo(int value) {
            try {
                this.mCb.onSetVolumeTo(value);
            } catch (RemoteException e) {
                Slog.e(MediaSessionRecord.TAG, "Remote failure in setVolumeTo.", e);
            }
        }
    }

    private final class SessionStub extends ISession.Stub {
        private SessionStub() {
        }

        public void destroy() {
            MediaSessionRecord.this.mService.destroySession(MediaSessionRecord.this);
        }

        public void sendEvent(String event, Bundle data) {
            MediaSessionRecord.this.mHandler.post(6, event, data == null ? null : new Bundle(data));
        }

        public ISessionController getController() {
            return MediaSessionRecord.this.mController;
        }

        public void setActive(boolean active) {
            MediaSessionRecord.this.mIsActive = active;
            MediaSessionRecord.this.mService.updateSession(MediaSessionRecord.this);
            MediaSessionRecord.this.mHandler.post(7);
        }

        public void setFlags(int flags) {
            if ((65536 & flags) != 0) {
                MediaSessionRecord.this.mService.enforcePhoneStatePermission(getCallingPid(), getCallingUid());
            }
            MediaSessionRecord.this.mFlags = (long) flags;
            MediaSessionRecord.this.mHandler.post(7);
        }

        public void setMediaButtonReceiver(PendingIntent pi) {
            MediaSessionRecord.this.mMediaButtonReceiver = pi;
        }

        public void setLaunchPendingIntent(PendingIntent pi) {
            MediaSessionRecord.this.mLaunchIntent = pi;
        }

        public void setMetadata(MediaMetadata metadata) {
            synchronized (MediaSessionRecord.this.mLock) {
                MediaMetadata temp = metadata == null ? null : new Builder(metadata).build();
                if (temp != null) {
                    temp.size();
                }
                MediaSessionRecord.this.mMetadata = temp;
            }
            MediaSessionRecord.this.mHandler.post(1);
        }

        public void setPlaybackState(PlaybackState state) {
            int newState = 0;
            int oldState = MediaSessionRecord.this.mPlaybackState == null ? 0 : MediaSessionRecord.this.mPlaybackState.getState();
            if (state != null) {
                newState = state.getState();
            }
            if (MediaSession.isActiveState(oldState) && newState == 2) {
                MediaSessionRecord.this.mLastActiveTime = SystemClock.elapsedRealtime();
            }
            synchronized (MediaSessionRecord.this.mLock) {
                MediaSessionRecord.this.mPlaybackState = state;
            }
            MediaSessionRecord.this.mService.onSessionPlaystateChange(MediaSessionRecord.this, oldState, newState);
            MediaSessionRecord.this.mHandler.post(2);
        }

        public void setQueue(ParceledListSlice queue) {
            synchronized (MediaSessionRecord.this.mLock) {
                MediaSessionRecord.this.mQueue = queue;
            }
            MediaSessionRecord.this.mHandler.post(3);
        }

        public void updateFolderInfoBrowsedPlayer(String stringUri) {
            Log.d(MediaSessionRecord.TAG, "SessionStub: updateFolderInfoBrowsedPlayer");
            MediaSessionRecord.this.mBrowsedPlayerURI = stringUri;
            MediaSessionRecord.this.mHandler.post(9);
        }

        public void updateNowPlayingEntries(long[] playList) {
            Log.d(MediaSessionRecord.TAG, "SessionStub: updateNowPlayingEntries");
            MediaSessionRecord.this.mNowPlayingList = playList;
            MediaSessionRecord.this.mHandler.post(10);
        }

        public void updateNowPlayingContentChange() {
            Log.d(MediaSessionRecord.TAG, "SessionStub: updateNowPlayingContentChange");
            MediaSessionRecord.this.mHandler.post(11);
        }

        public void playItemResponse(boolean success) {
            Log.d(MediaSessionRecord.TAG, "SessionStub: playItemResponse");
            MediaSessionRecord.this.mPlayItemStatus = success;
            MediaSessionRecord.this.mHandler.post(12);
        }

        public void setQueueTitle(CharSequence title) {
            MediaSessionRecord.this.mQueueTitle = title;
            MediaSessionRecord.this.mHandler.post(4);
        }

        public void setExtras(Bundle extras) {
            synchronized (MediaSessionRecord.this.mLock) {
                MediaSessionRecord.this.mExtras = extras == null ? null : new Bundle(extras);
            }
            MediaSessionRecord.this.mHandler.post(5);
        }

        public void setRatingType(int type) {
            MediaSessionRecord.this.mRatingType = type;
        }

        public void setCurrentVolume(int volume) {
            MediaSessionRecord.this.mCurrentVolume = volume;
            MediaSessionRecord.this.mHandler.post(8);
        }

        public void setPlaybackToLocal(AudioAttributes attributes) {
            boolean typeChanged = true;
            synchronized (MediaSessionRecord.this.mLock) {
                if (MediaSessionRecord.this.mVolumeType != 2) {
                    typeChanged = MediaSessionRecord.DEBUG;
                }
                MediaSessionRecord.this.mVolumeType = 1;
                if (attributes != null) {
                    MediaSessionRecord.this.mAudioAttrs = attributes;
                } else {
                    Log.e(MediaSessionRecord.TAG, "Received null audio attributes, using existing attributes");
                }
            }
            if (typeChanged) {
                MediaSessionRecord.this.mService.onSessionPlaybackTypeChanged(MediaSessionRecord.this);
            }
        }

        public void setPlaybackToRemote(int control, int max) {
            boolean typeChanged = true;
            synchronized (MediaSessionRecord.this.mLock) {
                if (MediaSessionRecord.this.mVolumeType != 1) {
                    typeChanged = MediaSessionRecord.DEBUG;
                }
                MediaSessionRecord.this.mVolumeType = 2;
                MediaSessionRecord.this.mVolumeControlType = control;
                MediaSessionRecord.this.mMaxVolume = max;
            }
            if (typeChanged) {
                MediaSessionRecord.this.mService.onSessionPlaybackTypeChanged(MediaSessionRecord.this);
            }
        }
    }

    public MediaSessionRecord(int ownerPid, int ownerUid, int userId, String ownerPackageName, ISessionCallback cb, String tag, MediaSessionService service, Handler handler) {
        this.mLock = new Object();
        this.mControllerCallbacks = new ArrayList();
        this.mVolumeType = 1;
        this.mVolumeControlType = 2;
        this.mMaxVolume = 0;
        this.mCurrentVolume = 0;
        this.mOptimisticVolume = -1;
        this.mIsActive = DEBUG;
        this.mDestroyed = DEBUG;
        this.mClearOptimisticVolumeRunnable = new C03761();
        this.mOwnerPid = ownerPid;
        this.mOwnerUid = ownerUid;
        this.mUserId = userId;
        this.mPackageName = ownerPackageName;
        this.mTag = tag;
        this.mController = new ControllerStub();
        this.mSession = new SessionStub();
        this.mSessionCb = new SessionCb(cb);
        this.mService = service;
        this.mHandler = new MessageHandler(handler.getLooper());
        this.mAudioManager = (AudioManager) service.getContext().getSystemService("audio");
        this.mAudioManagerInternal = (AudioManagerInternal) LocalServices.getService(AudioManagerInternal.class);
        this.mAudioAttrs = new AudioAttributes.Builder().setUsage(1).build();
        this.mUseMasterVolume = service.getContext().getResources().getBoolean(17956881);
    }

    public ISession getSessionBinder() {
        return this.mSession;
    }

    public ISessionController getControllerBinder() {
        return this.mController;
    }

    public String getPackageName() {
        return this.mPackageName;
    }

    public String getTag() {
        return this.mTag;
    }

    public PendingIntent getMediaButtonReceiver() {
        return this.mMediaButtonReceiver;
    }

    public long getFlags() {
        return this.mFlags;
    }

    public boolean hasFlag(int flag) {
        return (this.mFlags & ((long) flag)) != 0 ? true : DEBUG;
    }

    public int getUserId() {
        return this.mUserId;
    }

    public boolean isSystemPriority() {
        return (this.mFlags & 65536) != 0 ? true : DEBUG;
    }

    public void adjustVolume(int direction, int flags, String packageName, int uid, boolean useSuggested) {
        int previousFlagPlaySound = flags & 4;
        if (isPlaybackActive(DEBUG) || hasFlag(65536)) {
            flags &= -5;
        }
        boolean isMute = direction == -99 ? true : DEBUG;
        if (direction > 1) {
            direction = 1;
        } else if (direction < -1) {
            direction = -1;
        }
        if (this.mVolumeType == 1) {
            if (this.mUseMasterVolume) {
                boolean isMasterMute = this.mAudioManager.isMasterMute();
                if (isMute) {
                    boolean z;
                    AudioManagerInternal audioManagerInternal = this.mAudioManagerInternal;
                    if (isMasterMute) {
                        z = DEBUG;
                    } else {
                        z = true;
                    }
                    audioManagerInternal.setMasterMuteForUid(z, flags, packageName, this.mService.mICallback, uid);
                    return;
                }
                this.mAudioManagerInternal.adjustMasterVolumeForUid(direction, flags, packageName, uid);
                if (isMasterMute) {
                    this.mAudioManagerInternal.setMasterMuteForUid(DEBUG, flags, packageName, this.mService.mICallback, uid);
                    return;
                }
                return;
            }
            int stream = AudioAttributes.toLegacyStreamType(this.mAudioAttrs);
            boolean isStreamMute = this.mAudioManager.isStreamMute(stream);
            if (useSuggested) {
                if (!AudioSystem.isStreamActive(stream, 0)) {
                    flags |= previousFlagPlaySound;
                    isStreamMute = this.mAudioManager.isStreamMute(SoundTriggerHelper.STATUS_ERROR);
                    if (isMute) {
                        this.mAudioManager.setStreamMute(SoundTriggerHelper.STATUS_ERROR, !isStreamMute ? true : DEBUG);
                        return;
                    }
                    this.mAudioManagerInternal.adjustSuggestedStreamVolumeForUid(SoundTriggerHelper.STATUS_ERROR, direction, flags, packageName, uid);
                    if (isStreamMute && direction != 0) {
                        this.mAudioManager.setStreamMute(SoundTriggerHelper.STATUS_ERROR, DEBUG);
                    }
                } else if (isMute) {
                    this.mAudioManager.setStreamMute(stream, !isStreamMute ? true : DEBUG);
                } else {
                    this.mAudioManagerInternal.adjustSuggestedStreamVolumeForUid(stream, direction, flags, packageName, uid);
                    if (isStreamMute && direction != 0) {
                        this.mAudioManager.setStreamMute(stream, DEBUG);
                    }
                }
            } else if (isMute) {
                this.mAudioManager.setStreamMute(stream, !isStreamMute ? true : DEBUG);
            } else {
                this.mAudioManagerInternal.adjustStreamVolumeForUid(stream, direction, flags, packageName, uid);
                if (isStreamMute && direction != 0) {
                    this.mAudioManager.setStreamMute(stream, DEBUG);
                }
            }
        } else if (this.mVolumeControlType == 0) {
        } else {
            if (isMute) {
                Log.w(TAG, "Muting remote playback is not supported");
                return;
            }
            this.mSessionCb.adjustVolume(direction);
            int volumeBefore = this.mOptimisticVolume < 0 ? this.mCurrentVolume : this.mOptimisticVolume;
            this.mOptimisticVolume = volumeBefore + direction;
            this.mOptimisticVolume = Math.max(0, Math.min(this.mOptimisticVolume, this.mMaxVolume));
            this.mHandler.removeCallbacks(this.mClearOptimisticVolumeRunnable);
            this.mHandler.postDelayed(this.mClearOptimisticVolumeRunnable, 1000);
            if (volumeBefore != this.mOptimisticVolume) {
                pushVolumeUpdate();
            }
            this.mService.notifyRemoteVolumeChanged(flags, this);
        }
    }

    public void setVolumeTo(int value, int flags, String packageName, int uid) {
        if (this.mVolumeType == 1) {
            this.mAudioManagerInternal.setStreamVolumeForUid(AudioAttributes.toLegacyStreamType(this.mAudioAttrs), value, flags, packageName, uid);
        } else if (this.mVolumeControlType == 2) {
            value = Math.max(0, Math.min(value, this.mMaxVolume));
            this.mSessionCb.setVolumeTo(value);
            int volumeBefore = this.mOptimisticVolume < 0 ? this.mCurrentVolume : this.mOptimisticVolume;
            this.mOptimisticVolume = Math.max(0, Math.min(value, this.mMaxVolume));
            this.mHandler.removeCallbacks(this.mClearOptimisticVolumeRunnable);
            this.mHandler.postDelayed(this.mClearOptimisticVolumeRunnable, 1000);
            if (volumeBefore != this.mOptimisticVolume) {
                pushVolumeUpdate();
            }
            this.mService.notifyRemoteVolumeChanged(flags, this);
        }
    }

    public boolean isActive() {
        return (!this.mIsActive || this.mDestroyed) ? DEBUG : true;
    }

    public boolean isPlaybackActive(boolean includeRecentlyActive) {
        int state = this.mPlaybackState == null ? 0 : this.mPlaybackState.getState();
        if (MediaSession.isActiveState(state)) {
            return true;
        }
        if (!includeRecentlyActive) {
            return DEBUG;
        }
        PlaybackState playbackState = this.mPlaybackState;
        if (state != 2 || SystemClock.uptimeMillis() - this.mLastActiveTime >= 30000) {
            return DEBUG;
        }
        return true;
    }

    public int getPlaybackType() {
        return this.mVolumeType;
    }

    public AudioAttributes getAudioAttributes() {
        return this.mAudioAttrs;
    }

    public int getVolumeControl() {
        return this.mVolumeControlType;
    }

    public int getMaxVolume() {
        return this.mMaxVolume;
    }

    public int getCurrentVolume() {
        return this.mCurrentVolume;
    }

    public int getOptimisticVolume() {
        return this.mOptimisticVolume;
    }

    public boolean isTransportControlEnabled() {
        return hasFlag(2);
    }

    public void binderDied() {
        this.mService.sessionDied(this);
    }

    public void onDestroy() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            this.mDestroyed = true;
            this.mHandler.post(13);
        }
    }

    public ISessionCallback getCallback() {
        return this.mSessionCb.mCb;
    }

    public void sendMediaButton(KeyEvent ke, int sequenceId, ResultReceiver cb) {
        this.mSessionCb.sendMediaButton(ke, sequenceId, cb);
    }

    public void dump(PrintWriter pw, String prefix) {
        pw.println(prefix + this.mTag + " " + this);
        String indent = prefix + "  ";
        pw.println(indent + "ownerPid=" + this.mOwnerPid + ", ownerUid=" + this.mOwnerUid + ", userId=" + this.mUserId);
        pw.println(indent + "package=" + this.mPackageName);
        pw.println(indent + "launchIntent=" + this.mLaunchIntent);
        pw.println(indent + "mediaButtonReceiver=" + this.mMediaButtonReceiver);
        pw.println(indent + "active=" + this.mIsActive);
        pw.println(indent + "flags=" + this.mFlags);
        pw.println(indent + "rating type=" + this.mRatingType);
        pw.println(indent + "controllers: " + this.mControllerCallbacks.size());
        pw.println(indent + "state=" + (this.mPlaybackState == null ? null : this.mPlaybackState.toString()));
        pw.println(indent + "audioAttrs=" + this.mAudioAttrs);
        pw.println(indent + "volumeType=" + this.mVolumeType + ", controlType=" + this.mVolumeControlType + ", max=" + this.mMaxVolume + ", current=" + this.mCurrentVolume);
        pw.println(indent + "metadata:" + getShortMetadataString());
        pw.println(indent + "queueTitle=" + this.mQueueTitle + ", size=" + (this.mQueue == null ? 0 : this.mQueue.getList().size()));
    }

    public String toString() {
        return this.mPackageName + "/" + this.mTag;
    }

    private String getShortMetadataString() {
        return "size=" + (this.mMetadata == null ? 0 : this.mMetadata.size()) + ", description=" + (this.mMetadata == null ? null : this.mMetadata.getDescription());
    }

    private void pushPlaybackStateUpdate() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                try {
                    ((ISessionControllerCallback) this.mControllerCallbacks.get(i)).onPlaybackStateChanged(this.mPlaybackState);
                } catch (DeadObjectException e) {
                    this.mControllerCallbacks.remove(i);
                    Log.w(TAG, "Removed dead callback in pushPlaybackStateUpdate.", e);
                } catch (RemoteException e2) {
                    Log.w(TAG, "unexpected exception in pushPlaybackStateUpdate.", e2);
                }
            }
        }
    }

    private void pushMetadataUpdate() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                try {
                    ((ISessionControllerCallback) this.mControllerCallbacks.get(i)).onMetadataChanged(this.mMetadata);
                } catch (DeadObjectException e) {
                    Log.w(TAG, "Removing dead callback in pushMetadataUpdate. ", e);
                    this.mControllerCallbacks.remove(i);
                } catch (RemoteException e2) {
                    Log.w(TAG, "unexpected exception in pushMetadataUpdate. ", e2);
                }
            }
        }
    }

    private void pushBrowsePlayerInfo() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                ISessionControllerCallback cb = (ISessionControllerCallback) this.mControllerCallbacks.get(i);
                try {
                    Log.d(TAG, "pushBrowsePlayerInfo");
                    cb.onUpdateFolderInfoBrowsedPlayer(this.mBrowsedPlayerURI);
                } catch (DeadObjectException e) {
                    Log.w(TAG, "Removing dead callback in pushBrowsePlayerInfo. ", e);
                    this.mControllerCallbacks.remove(i);
                } catch (RemoteException e2) {
                    Log.w(TAG, "unexpected exception in pushBrowsePlayerInfo. ", e2);
                }
            }
        }
    }

    private void pushNowPlayingEntries() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                ISessionControllerCallback cb = (ISessionControllerCallback) this.mControllerCallbacks.get(i);
                try {
                    Log.d(TAG, "pushNowPlayingEntries");
                    cb.onUpdateNowPlayingEntries(this.mNowPlayingList);
                } catch (DeadObjectException e) {
                    Log.w(TAG, "Removing dead callback in pushNowPlayingEntries. ", e);
                    this.mControllerCallbacks.remove(i);
                } catch (RemoteException e2) {
                    Log.w(TAG, "unexpected exception in pushNowPlayingEntries. ", e2);
                }
            }
        }
    }

    private void pushNowPlayingContentChange() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                ISessionControllerCallback cb = (ISessionControllerCallback) this.mControllerCallbacks.get(i);
                try {
                    Log.d(TAG, "pushNowPlayingContentChange");
                    cb.onUpdateNowPlayingContentChange();
                } catch (DeadObjectException e) {
                    Log.w(TAG, "Removing dead callback in pushNowPlayingContentChange. ", e);
                    this.mControllerCallbacks.remove(i);
                } catch (RemoteException e2) {
                    Log.w(TAG, "unexpected exception in pushNowPlayingContentChange. ", e2);
                }
            }
        }
    }

    private void pushPlayItemResponse() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                ISessionControllerCallback cb = (ISessionControllerCallback) this.mControllerCallbacks.get(i);
                try {
                    Log.d(TAG, "pushPlayItemResponse");
                    cb.onPlayItemResponse(this.mPlayItemStatus);
                } catch (DeadObjectException e) {
                    Log.w(TAG, "Removing dead callback in pushPlayItemResponse. ", e);
                    this.mControllerCallbacks.remove(i);
                } catch (RemoteException e2) {
                    Log.w(TAG, "unexpected exception in pushPlayItemResponse. ", e2);
                }
            }
        }
    }

    private void pushQueueUpdate() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                try {
                    ((ISessionControllerCallback) this.mControllerCallbacks.get(i)).onQueueChanged(this.mQueue);
                } catch (DeadObjectException e) {
                    this.mControllerCallbacks.remove(i);
                    Log.w(TAG, "Removed dead callback in pushQueueUpdate.", e);
                } catch (RemoteException e2) {
                    Log.w(TAG, "unexpected exception in pushQueueUpdate.", e2);
                }
            }
        }
    }

    private void pushQueueTitleUpdate() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                try {
                    ((ISessionControllerCallback) this.mControllerCallbacks.get(i)).onQueueTitleChanged(this.mQueueTitle);
                } catch (DeadObjectException e) {
                    this.mControllerCallbacks.remove(i);
                    Log.w(TAG, "Removed dead callback in pushQueueTitleUpdate.", e);
                } catch (RemoteException e2) {
                    Log.w(TAG, "unexpected exception in pushQueueTitleUpdate.", e2);
                }
            }
        }
    }

    private void pushExtrasUpdate() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                try {
                    ((ISessionControllerCallback) this.mControllerCallbacks.get(i)).onExtrasChanged(this.mExtras);
                } catch (DeadObjectException e) {
                    this.mControllerCallbacks.remove(i);
                    Log.w(TAG, "Removed dead callback in pushExtrasUpdate.", e);
                } catch (RemoteException e2) {
                    Log.w(TAG, "unexpected exception in pushExtrasUpdate.", e2);
                }
            }
        }
    }

    private void pushVolumeUpdate() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            ParcelableVolumeInfo info = this.mController.getVolumeAttributes();
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                try {
                    ((ISessionControllerCallback) this.mControllerCallbacks.get(i)).onVolumeInfoChanged(info);
                } catch (DeadObjectException e) {
                    Log.w(TAG, "Removing dead callback in pushVolumeUpdate. ", e);
                } catch (RemoteException e2) {
                    Log.w(TAG, "Unexpected exception in pushVolumeUpdate. ", e2);
                }
            }
        }
    }

    private void pushEvent(String event, Bundle data) {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                return;
            }
            for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                try {
                    ((ISessionControllerCallback) this.mControllerCallbacks.get(i)).onEvent(event, data);
                } catch (DeadObjectException e) {
                    Log.w(TAG, "Removing dead callback in pushEvent.", e);
                    this.mControllerCallbacks.remove(i);
                } catch (RemoteException e2) {
                    Log.w(TAG, "unexpected exception in pushEvent.", e2);
                }
            }
        }
    }

    private void pushSessionDestroyed() {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
                    try {
                        ((ISessionControllerCallback) this.mControllerCallbacks.get(i)).onSessionDestroyed();
                    } catch (DeadObjectException e) {
                        Log.w(TAG, "Removing dead callback in pushEvent.", e);
                        this.mControllerCallbacks.remove(i);
                    } catch (RemoteException e2) {
                        Log.w(TAG, "unexpected exception in pushEvent.", e2);
                    }
                }
                this.mControllerCallbacks.clear();
                return;
            }
        }
    }

    private PlaybackState getStateWithUpdatedPosition() {
        long duration = -1;
        synchronized (this.mLock) {
            PlaybackState state = this.mPlaybackState;
            if (this.mMetadata != null && this.mMetadata.containsKey("android.media.metadata.DURATION")) {
                duration = this.mMetadata.getLong("android.media.metadata.DURATION");
            }
        }
        PlaybackState result = null;
        if (state != null && (state.getState() == 3 || state.getState() == 4 || state.getState() == 5)) {
            long updateTime = state.getLastPositionUpdateTime();
            long currentTime = SystemClock.elapsedRealtime();
            if (updateTime > 0) {
                long position = ((long) (state.getPlaybackSpeed() * ((float) (currentTime - updateTime)))) + state.getPosition();
                if (duration >= 0 && position > duration) {
                    position = duration;
                } else if (position < 0) {
                    position = 0;
                }
                PlaybackState.Builder builder = new PlaybackState.Builder(state);
                builder.setState(state.getState(), position, state.getPlaybackSpeed(), currentTime);
                result = builder.build();
            }
        }
        if (result == null) {
            return state;
        }
        return result;
    }

    private int getControllerCbIndexForCb(ISessionControllerCallback cb) {
        IBinder binder = cb.asBinder();
        for (int i = this.mControllerCallbacks.size() - 1; i >= 0; i--) {
            if (binder.equals(((ISessionControllerCallback) this.mControllerCallbacks.get(i)).asBinder())) {
                return i;
            }
        }
        return -1;
    }
}
