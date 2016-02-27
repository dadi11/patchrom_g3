package android.media.session;

import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.RectF;
import android.media.MediaMetadata;
import android.media.MediaMetadataEditor;
import android.media.Rating;
import android.media.session.MediaSession.Callback;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Parcelable;
import android.util.ArrayMap;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.EditorInfo;

public class MediaSessionLegacyHelper {
    private static final boolean DEBUG;
    private static final String TAG = "MediaSessionHelper";
    private static MediaSessionLegacyHelper sInstance;
    private static final Object sLock;
    private Context mContext;
    private Handler mHandler;
    private MediaSessionManager mSessionManager;
    private ArrayMap<PendingIntent, SessionHolder> mSessions;

    private static final class MediaButtonListener extends Callback {
        private final Context mContext;
        private final PendingIntent mPendingIntent;

        public MediaButtonListener(PendingIntent pi, Context context) {
            this.mPendingIntent = pi;
            this.mContext = context;
        }

        public boolean onMediaButtonEvent(Intent mediaButtonIntent) {
            MediaSessionLegacyHelper.sendKeyEvent(this.mPendingIntent, this.mContext, mediaButtonIntent);
            return true;
        }

        public void onPlay() {
            sendKeyEvent(KeyEvent.KEYCODE_MEDIA_PLAY);
        }

        public void onPause() {
            sendKeyEvent(KeyEvent.KEYCODE_MEDIA_PAUSE);
        }

        public void onSkipToNext() {
            sendKeyEvent(87);
        }

        public void onSkipToPrevious() {
            sendKeyEvent(88);
        }

        public void onFastForward() {
            sendKeyEvent(90);
        }

        public void onRewind() {
            sendKeyEvent(89);
        }

        public void onStop() {
            sendKeyEvent(86);
        }

        private void sendKeyEvent(int keyCode) {
            Parcelable ke = new KeyEvent(0, keyCode);
            Intent intent = new Intent(Intent.ACTION_MEDIA_BUTTON);
            intent.addFlags(EditorInfo.IME_FLAG_NO_EXTRACT_UI);
            intent.putExtra(Intent.EXTRA_KEY_EVENT, ke);
            MediaSessionLegacyHelper.sendKeyEvent(this.mPendingIntent, this.mContext, intent);
            intent.putExtra(Intent.EXTRA_KEY_EVENT, new KeyEvent(1, keyCode));
            MediaSessionLegacyHelper.sendKeyEvent(this.mPendingIntent, this.mContext, intent);
            if (MediaSessionLegacyHelper.DEBUG) {
                Log.d(MediaSessionLegacyHelper.TAG, "Sent " + keyCode + " to pending intent " + this.mPendingIntent);
            }
        }
    }

    private class SessionHolder {
        public SessionCallback mCb;
        public int mFlags;
        public MediaButtonListener mMediaButtonListener;
        public final PendingIntent mPi;
        public Callback mRccListener;
        public final MediaSession mSession;

        private class SessionCallback extends Callback {
            private SessionCallback() {
            }

            public boolean onMediaButtonEvent(Intent mediaButtonIntent) {
                if (SessionHolder.this.mMediaButtonListener != null) {
                    SessionHolder.this.mMediaButtonListener.onMediaButtonEvent(mediaButtonIntent);
                }
                return true;
            }

            public void onPlay() {
                if (SessionHolder.this.mMediaButtonListener != null) {
                    SessionHolder.this.mMediaButtonListener.onPlay();
                }
            }

            public void onPause() {
                if (SessionHolder.this.mMediaButtonListener != null) {
                    SessionHolder.this.mMediaButtonListener.onPause();
                }
            }

            public void onSkipToNext() {
                if (SessionHolder.this.mMediaButtonListener != null) {
                    SessionHolder.this.mMediaButtonListener.onSkipToNext();
                }
            }

            public void onSkipToPrevious() {
                if (SessionHolder.this.mMediaButtonListener != null) {
                    SessionHolder.this.mMediaButtonListener.onSkipToPrevious();
                }
            }

            public void onFastForward() {
                if (SessionHolder.this.mMediaButtonListener != null) {
                    SessionHolder.this.mMediaButtonListener.onFastForward();
                }
            }

            public void onRewind() {
                if (SessionHolder.this.mMediaButtonListener != null) {
                    SessionHolder.this.mMediaButtonListener.onRewind();
                }
            }

            public void onStop() {
                if (SessionHolder.this.mMediaButtonListener != null) {
                    SessionHolder.this.mMediaButtonListener.onStop();
                }
            }

            public void onSeekTo(long pos) {
                if (SessionHolder.this.mRccListener != null) {
                    SessionHolder.this.mRccListener.onSeekTo(pos);
                }
            }

            public void onSetRating(Rating rating) {
                if (SessionHolder.this.mRccListener != null) {
                    SessionHolder.this.mRccListener.onSetRating(rating);
                }
            }

            public void setBrowsedPlayer() {
                if (SessionHolder.this.mRccListener != null) {
                    SessionHolder.this.mRccListener.setBrowsedPlayer();
                }
            }

            public void setPlayItem(int scope, long uid) {
                if (SessionHolder.this.mRccListener != null) {
                    SessionHolder.this.mRccListener.setPlayItem(scope, uid);
                }
            }

            public void getNowPlayingEntries() {
                if (SessionHolder.this.mRccListener != null) {
                    SessionHolder.this.mRccListener.getNowPlayingEntries();
                }
            }
        }

        public SessionHolder(MediaSession session, PendingIntent pi) {
            this.mSession = session;
            this.mPi = pi;
        }

        public void update() {
            if (this.mMediaButtonListener == null && this.mRccListener == null) {
                this.mSession.setCallback(null);
                this.mSession.release();
                this.mCb = null;
                MediaSessionLegacyHelper.this.mSessions.remove(this.mPi);
            } else if (this.mCb == null) {
                this.mCb = new SessionCallback();
                this.mSession.setCallback(this.mCb, new Handler(Looper.getMainLooper()));
            }
        }
    }

    static {
        DEBUG = Log.isLoggable(TAG, 3);
        sLock = new Object();
    }

    private MediaSessionLegacyHelper(Context context) {
        this.mHandler = new Handler(Looper.getMainLooper());
        this.mSessions = new ArrayMap();
        this.mContext = context;
        this.mSessionManager = (MediaSessionManager) context.getSystemService(Context.MEDIA_SESSION_SERVICE);
    }

    public static MediaSessionLegacyHelper getHelper(Context context) {
        synchronized (sLock) {
            if (sInstance == null) {
                sInstance = new MediaSessionLegacyHelper(context.getApplicationContext());
            }
        }
        return sInstance;
    }

    public static Bundle getOldMetadata(MediaMetadata metadata, int artworkWidth, int artworkHeight) {
        boolean includeArtwork;
        if (artworkWidth == -1 || artworkHeight == -1) {
            includeArtwork = DEBUG;
        } else {
            includeArtwork = true;
        }
        Bundle oldMetadata = new Bundle();
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_ALBUM)) {
            oldMetadata.putString(String.valueOf(1), metadata.getString(MediaMetadata.METADATA_KEY_ALBUM));
        }
        if (includeArtwork && metadata.containsKey(MediaMetadata.METADATA_KEY_ART)) {
            oldMetadata.putParcelable(String.valueOf(100), scaleBitmapIfTooBig(metadata.getBitmap(MediaMetadata.METADATA_KEY_ART), artworkWidth, artworkHeight));
        } else if (includeArtwork && metadata.containsKey(MediaMetadata.METADATA_KEY_ALBUM_ART)) {
            oldMetadata.putParcelable(String.valueOf(100), scaleBitmapIfTooBig(metadata.getBitmap(MediaMetadata.METADATA_KEY_ALBUM_ART), artworkWidth, artworkHeight));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_ALBUM_ARTIST)) {
            oldMetadata.putString(String.valueOf(13), metadata.getString(MediaMetadata.METADATA_KEY_ALBUM_ARTIST));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_ARTIST)) {
            oldMetadata.putString(String.valueOf(2), metadata.getString(MediaMetadata.METADATA_KEY_ARTIST));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_AUTHOR)) {
            oldMetadata.putString(String.valueOf(3), metadata.getString(MediaMetadata.METADATA_KEY_AUTHOR));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_COMPILATION)) {
            oldMetadata.putString(String.valueOf(15), metadata.getString(MediaMetadata.METADATA_KEY_COMPILATION));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_COMPOSER)) {
            oldMetadata.putString(String.valueOf(4), metadata.getString(MediaMetadata.METADATA_KEY_COMPOSER));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_DATE)) {
            oldMetadata.putString(String.valueOf(5), metadata.getString(MediaMetadata.METADATA_KEY_DATE));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_DISC_NUMBER)) {
            oldMetadata.putLong(String.valueOf(14), metadata.getLong(MediaMetadata.METADATA_KEY_DISC_NUMBER));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_DURATION)) {
            oldMetadata.putLong(String.valueOf(9), metadata.getLong(MediaMetadata.METADATA_KEY_DURATION));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_GENRE)) {
            oldMetadata.putString(String.valueOf(6), metadata.getString(MediaMetadata.METADATA_KEY_GENRE));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_NUM_TRACKS)) {
            oldMetadata.putLong(String.valueOf(10), metadata.getLong(MediaMetadata.METADATA_KEY_NUM_TRACKS));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_RATING)) {
            oldMetadata.putParcelable(String.valueOf(KeyEvent.KEYCODE_BUTTON_Z), metadata.getRating(MediaMetadata.METADATA_KEY_RATING));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_USER_RATING)) {
            oldMetadata.putParcelable(String.valueOf(MediaMetadataEditor.RATING_KEY_BY_USER), metadata.getRating(MediaMetadata.METADATA_KEY_USER_RATING));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_TITLE)) {
            oldMetadata.putString(String.valueOf(7), metadata.getString(MediaMetadata.METADATA_KEY_TITLE));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_TRACK_NUMBER)) {
            oldMetadata.putLong(String.valueOf(0), metadata.getLong(MediaMetadata.METADATA_KEY_TRACK_NUMBER));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_WRITER)) {
            oldMetadata.putString(String.valueOf(11), metadata.getString(MediaMetadata.METADATA_KEY_WRITER));
        }
        if (metadata.containsKey(MediaMetadata.METADATA_KEY_YEAR)) {
            oldMetadata.putString(String.valueOf(8), metadata.getString(MediaMetadata.METADATA_KEY_YEAR));
        }
        return oldMetadata;
    }

    public MediaSession getSession(PendingIntent pi) {
        SessionHolder holder = (SessionHolder) this.mSessions.get(pi);
        return holder == null ? null : holder.mSession;
    }

    public void sendMediaButtonEvent(KeyEvent keyEvent, boolean needWakeLock) {
        if (keyEvent == null) {
            Log.w(TAG, "Tried to send a null key event. Ignoring.");
            return;
        }
        this.mSessionManager.dispatchMediaKeyEvent(keyEvent, needWakeLock);
        if (DEBUG) {
            Log.d(TAG, "dispatched media key " + keyEvent);
        }
    }

    public void sendVolumeKeyEvent(KeyEvent keyEvent, boolean musicOnly) {
        if (keyEvent == null) {
            Log.w(TAG, "Tried to send a null key event. Ignoring.");
            return;
        }
        boolean down;
        boolean up;
        if (keyEvent.getAction() == 0) {
            down = true;
        } else {
            down = DEBUG;
        }
        if (keyEvent.getAction() == 1) {
            up = true;
        } else {
            up = DEBUG;
        }
        int direction = 0;
        boolean isMute = DEBUG;
        switch (keyEvent.getKeyCode()) {
            case MotionEvent.AXIS_DISTANCE /*24*/:
                direction = 1;
                break;
            case MotionEvent.AXIS_TILT /*25*/:
                direction = -1;
                break;
            case KeyEvent.KEYCODE_VOLUME_MUTE /*164*/:
                isMute = true;
                break;
        }
        if (down || up) {
            int flags;
            if (musicOnly) {
                flags = AccessibilityNodeInfo.ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY;
            } else if (up) {
                flags = 20;
            } else {
                flags = 17;
            }
            if (direction != 0) {
                if (up) {
                    direction = 0;
                }
                this.mSessionManager.dispatchAdjustVolume(RtlSpacingHelper.UNDEFINED, direction, flags);
            } else if (isMute) {
                if (down) {
                    this.mSessionManager.dispatchAdjustVolume(RtlSpacingHelper.UNDEFINED, -99, flags);
                }
                this.mSessionManager.dispatchAdjustVolume(RtlSpacingHelper.UNDEFINED, 0, flags);
            }
        }
    }

    public void sendAdjustVolumeBy(int suggestedStream, int delta, int flags) {
        this.mSessionManager.dispatchAdjustVolume(suggestedStream, delta, flags);
        if (DEBUG) {
            Log.d(TAG, "dispatched volume adjustment");
        }
    }

    public boolean isGlobalPriorityActive() {
        return this.mSessionManager.isGlobalPriorityActive();
    }

    public void addRccListener(PendingIntent pi, Callback listener) {
        if (pi == null) {
            Log.w(TAG, "Pending intent was null, can't add rcc listener.");
            return;
        }
        SessionHolder holder = getHolder(pi, true);
        if (holder == null) {
            return;
        }
        if (holder.mRccListener == null || holder.mRccListener != listener) {
            holder.mRccListener = listener;
            holder.mFlags |= 2;
            holder.mSession.setFlags(holder.mFlags);
            holder.update();
            if (DEBUG) {
                Log.d(TAG, "Added rcc listener for " + pi + ".");
            }
        } else if (DEBUG) {
            Log.d(TAG, "addRccListener listener already added.");
        }
    }

    public void removeRccListener(PendingIntent pi) {
        if (pi != null) {
            SessionHolder holder = getHolder(pi, DEBUG);
            if (holder != null && holder.mRccListener != null) {
                holder.mRccListener = null;
                holder.mFlags &= -3;
                holder.mSession.setFlags(holder.mFlags);
                holder.update();
                if (DEBUG) {
                    Log.d(TAG, "Removed rcc listener for " + pi + ".");
                }
            }
        }
    }

    public void addMediaButtonListener(PendingIntent pi, ComponentName mbrComponent, Context context) {
        if (pi == null) {
            Log.w(TAG, "Pending intent was null, can't addMediaButtonListener.");
            return;
        }
        SessionHolder holder = getHolder(pi, true);
        if (holder != null) {
            if (holder.mMediaButtonListener != null && DEBUG) {
                Log.d(TAG, "addMediaButtonListener already added " + pi);
            }
            holder.mMediaButtonListener = new MediaButtonListener(pi, context);
            holder.mFlags |= 1;
            holder.mSession.setFlags(holder.mFlags);
            holder.mSession.setMediaButtonReceiver(pi);
            holder.update();
            if (DEBUG) {
                Log.d(TAG, "addMediaButtonListener added " + pi);
            }
        }
    }

    public void removeMediaButtonListener(PendingIntent pi) {
        if (pi != null) {
            SessionHolder holder = getHolder(pi, DEBUG);
            if (holder != null && holder.mMediaButtonListener != null) {
                holder.mFlags &= -2;
                holder.mSession.setFlags(holder.mFlags);
                holder.mMediaButtonListener = null;
                holder.update();
                if (DEBUG) {
                    Log.d(TAG, "removeMediaButtonListener removed " + pi);
                }
            }
        }
    }

    private static Bitmap scaleBitmapIfTooBig(Bitmap bitmap, int maxWidth, int maxHeight) {
        if (bitmap == null) {
            return bitmap;
        }
        int width = bitmap.getWidth();
        int height = bitmap.getHeight();
        if (width <= maxWidth && height <= maxHeight) {
            return bitmap;
        }
        float scale = Math.min(((float) maxWidth) / ((float) width), ((float) maxHeight) / ((float) height));
        int newWidth = Math.round(((float) width) * scale);
        int newHeight = Math.round(((float) height) * scale);
        Config newConfig = bitmap.getConfig();
        if (newConfig == null) {
            newConfig = Config.ARGB_8888;
        }
        Bitmap outBitmap = Bitmap.createBitmap(newWidth, newHeight, newConfig);
        Canvas canvas = new Canvas(outBitmap);
        Paint paint = new Paint();
        paint.setAntiAlias(true);
        paint.setFilterBitmap(true);
        canvas.drawBitmap(bitmap, null, new RectF(0.0f, 0.0f, (float) outBitmap.getWidth(), (float) outBitmap.getHeight()), paint);
        return outBitmap;
    }

    private SessionHolder getHolder(PendingIntent pi, boolean createIfMissing) {
        SessionHolder holder = (SessionHolder) this.mSessions.get(pi);
        if (holder != null || !createIfMissing) {
            return holder;
        }
        MediaSession session = new MediaSession(this.mContext, "MediaSessionHelper-" + pi.getCreatorPackage());
        session.setActive(true);
        holder = new SessionHolder(session, pi);
        this.mSessions.put(pi, holder);
        return holder;
    }

    private static void sendKeyEvent(PendingIntent pi, Context context, Intent intent) {
        try {
            pi.send(context, 0, intent);
        } catch (CanceledException e) {
            Log.e(TAG, "Error sending media key down event:", e);
        }
    }
}
