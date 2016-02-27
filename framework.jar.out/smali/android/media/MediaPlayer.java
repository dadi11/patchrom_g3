package android.media;

import android.app.ActivityThread;
import android.content.ContentResolver;
import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.media.AudioAttributes.Builder;
import android.media.MediaTimeProvider.OnMediaTimeListener;
import android.media.SubtitleController.Anchor;
import android.media.SubtitleController.Listener;
import android.media.SubtitleTrack.RenderingWidget;
import android.net.Uri;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.Process;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.speech.tts.TextToSpeech.Engine;
import android.system.ErrnoException;
import android.util.Log;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.EditorInfo;
import com.android.internal.app.IAppOpsService;
import com.android.internal.app.IAppOpsService.Stub;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.lang.ref.WeakReference;
import java.net.InetSocketAddress;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Scanner;
import java.util.Set;
import java.util.Vector;
import libcore.io.Libcore;

public class MediaPlayer implements Listener {
    public static final boolean APPLY_METADATA_FILTER = true;
    public static final boolean BYPASS_METADATA_FILTER = false;
    private static final String IMEDIA_PLAYER = "android.media.IMediaPlayer";
    private static final int INVOKE_ID_ADD_EXTERNAL_SOURCE = 2;
    private static final int INVOKE_ID_ADD_EXTERNAL_SOURCE_FD = 3;
    private static final int INVOKE_ID_DESELECT_TRACK = 5;
    private static final int INVOKE_ID_GET_SELECTED_TRACK = 7;
    private static final int INVOKE_ID_GET_TRACK_INFO = 1;
    private static final int INVOKE_ID_SELECT_TRACK = 4;
    private static final int INVOKE_ID_SET_VIDEO_SCALE_MODE = 6;
    private static final int KEY_PARAMETER_AUDIO_ATTRIBUTES = 1400;
    private static final int MEDIA_BUFFERING_UPDATE = 3;
    private static final int MEDIA_ERROR = 100;
    public static final int MEDIA_ERROR_IO = -1004;
    public static final int MEDIA_ERROR_MALFORMED = -1007;
    public static final int MEDIA_ERROR_NOT_VALID_FOR_PROGRESSIVE_PLAYBACK = 200;
    public static final int MEDIA_ERROR_SERVER_DIED = 100;
    public static final int MEDIA_ERROR_TIMED_OUT = -110;
    public static final int MEDIA_ERROR_UNKNOWN = 1;
    public static final int MEDIA_ERROR_UNSUPPORTED = -1010;
    private static final int MEDIA_INFO = 200;
    public static final int MEDIA_INFO_BAD_INTERLEAVING = 800;
    public static final int MEDIA_INFO_BUFFERING_END = 702;
    public static final int MEDIA_INFO_BUFFERING_START = 701;
    public static final int MEDIA_INFO_EXTERNAL_METADATA_UPDATE = 803;
    public static final int MEDIA_INFO_METADATA_UPDATE = 802;
    public static final int MEDIA_INFO_NOT_SEEKABLE = 801;
    public static final int MEDIA_INFO_STARTED_AS_NEXT = 2;
    public static final int MEDIA_INFO_SUBTITLE_TIMED_OUT = 902;
    public static final int MEDIA_INFO_TIMED_TEXT_ERROR = 900;
    public static final int MEDIA_INFO_UNKNOWN = 1;
    public static final int MEDIA_INFO_UNSUPPORTED_SUBTITLE = 901;
    public static final int MEDIA_INFO_VIDEO_RENDERING_START = 3;
    public static final int MEDIA_INFO_VIDEO_TRACK_LAGGING = 700;
    public static final String MEDIA_MIMETYPE_TEXT_CEA_608 = "text/cea-608";
    public static final String MEDIA_MIMETYPE_TEXT_SUBRIP = "application/x-subrip";
    public static final String MEDIA_MIMETYPE_TEXT_VTT = "text/vtt";
    private static final int MEDIA_NOP = 0;
    private static final int MEDIA_PAUSED = 7;
    private static final int MEDIA_PLAYBACK_COMPLETE = 2;
    private static final int MEDIA_PREPARED = 1;
    private static final int MEDIA_SEEK_COMPLETE = 4;
    private static final int MEDIA_SET_VIDEO_SIZE = 5;
    private static final int MEDIA_SKIPPED = 9;
    private static final int MEDIA_STARTED = 6;
    private static final int MEDIA_STOPPED = 8;
    private static final int MEDIA_SUBTITLE_DATA = 201;
    private static final int MEDIA_TIMED_TEXT = 99;
    public static final boolean METADATA_ALL = false;
    public static final boolean METADATA_UPDATE_ONLY = true;
    private static final String TAG = "MediaPlayer";
    public static final int VIDEO_SCALING_MODE_SCALE_TO_FIT = 1;
    public static final int VIDEO_SCALING_MODE_SCALE_TO_FIT_WITH_CROPPING = 2;
    private final IAppOpsService mAppOps;
    private EventHandler mEventHandler;
    private final Object mInbandSubtitleLock;
    private SubtitleTrack[] mInbandSubtitleTracks;
    private int mListenerContext;
    private long mNativeContext;
    private long mNativeSurfaceTexture;
    private OnBufferingUpdateListener mOnBufferingUpdateListener;
    private OnCompletionListener mOnCompletionListener;
    private OnErrorListener mOnErrorListener;
    private OnInfoListener mOnInfoListener;
    private OnPreparedListener mOnPreparedListener;
    private OnSeekCompleteListener mOnSeekCompleteListener;
    private OnSubtitleDataListener mOnSubtitleDataListener;
    private OnTimedTextListener mOnTimedTextListener;
    private OnVideoSizeChangedListener mOnVideoSizeChangedListener;
    private Vector<InputStream> mOpenSubtitleSources;
    private Vector<SubtitleTrack> mOutOfBandSubtitleTracks;
    private boolean mScreenOnWhilePlaying;
    private int mSelectedSubtitleTrackIndex;
    private boolean mStayAwake;
    private int mStreamType;
    private SubtitleController mSubtitleController;
    private OnSubtitleDataListener mSubtitleDataListener;
    private SurfaceHolder mSurfaceHolder;
    private TimeProvider mTimeProvider;
    private int mUsage;
    private WakeLock mWakeLock;

    public interface OnCompletionListener {
        void onCompletion(MediaPlayer mediaPlayer);
    }

    public interface OnErrorListener {
        boolean onError(MediaPlayer mediaPlayer, int i, int i2);
    }

    public interface OnSubtitleDataListener {
        void onSubtitleData(MediaPlayer mediaPlayer, SubtitleData subtitleData);
    }

    /* renamed from: android.media.MediaPlayer.1 */
    class C03731 implements OnSubtitleDataListener {
        C03731() {
        }

        public void onSubtitleData(MediaPlayer mp, SubtitleData data) {
            int index = data.getTrackIndex();
            if (index < MediaPlayer.this.mInbandSubtitleTracks.length) {
                SubtitleTrack track = MediaPlayer.this.mInbandSubtitleTracks[index];
                if (track != null) {
                    track.onData(data);
                }
            }
        }
    }

    /* renamed from: android.media.MediaPlayer.2 */
    class C03742 implements Runnable {
        final /* synthetic */ MediaFormat val$fFormat;
        final /* synthetic */ InputStream val$fIs;
        final /* synthetic */ HandlerThread val$thread;

        C03742(InputStream inputStream, MediaFormat mediaFormat, HandlerThread handlerThread) {
            this.val$fIs = inputStream;
            this.val$fFormat = mediaFormat;
            this.val$thread = handlerThread;
        }

        private int addTrack() {
            if (this.val$fIs == null || MediaPlayer.this.mSubtitleController == null) {
                return MediaPlayer.MEDIA_INFO_UNSUPPORTED_SUBTITLE;
            }
            SubtitleTrack track = MediaPlayer.this.mSubtitleController.addTrack(this.val$fFormat);
            if (track == null) {
                return MediaPlayer.MEDIA_INFO_UNSUPPORTED_SUBTITLE;
            }
            Scanner scanner = new Scanner(this.val$fIs, "UTF-8");
            String contents = scanner.useDelimiter("\\A").next();
            synchronized (MediaPlayer.this.mOpenSubtitleSources) {
                MediaPlayer.this.mOpenSubtitleSources.remove(this.val$fIs);
            }
            scanner.close();
            MediaPlayer.this.mOutOfBandSubtitleTracks.add(track);
            track.onData(contents.getBytes(), MediaPlayer.METADATA_UPDATE_ONLY, -1);
            return MediaPlayer.MEDIA_INFO_EXTERNAL_METADATA_UPDATE;
        }

        public void run() {
            int res = addTrack();
            if (MediaPlayer.this.mEventHandler != null) {
                MediaPlayer.this.mEventHandler.sendMessage(MediaPlayer.this.mEventHandler.obtainMessage(MediaPlayer.MEDIA_INFO, res, MediaPlayer.MEDIA_NOP, null));
            }
            this.val$thread.getLooper().quitSafely();
        }
    }

    /* renamed from: android.media.MediaPlayer.3 */
    class C03753 implements Anchor {
        C03753() {
        }

        public void setSubtitleWidget(RenderingWidget subtitleWidget) {
        }

        public Looper getSubtitleLooper() {
            return Looper.getMainLooper();
        }
    }

    /* renamed from: android.media.MediaPlayer.4 */
    class C03764 implements Runnable {
        final /* synthetic */ FileDescriptor val$dupedFd;
        final /* synthetic */ long val$length2;
        final /* synthetic */ long val$offset2;
        final /* synthetic */ HandlerThread val$thread;
        final /* synthetic */ SubtitleTrack val$track;

        C03764(FileDescriptor fileDescriptor, long j, long j2, SubtitleTrack subtitleTrack, HandlerThread handlerThread) {
            this.val$dupedFd = fileDescriptor;
            this.val$offset2 = j;
            this.val$length2 = j2;
            this.val$track = subtitleTrack;
            this.val$thread = handlerThread;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private int addTrack() {
            /*
            r12 = this;
            r0 = new java.io.ByteArrayOutputStream;
            r0.<init>();
            r5 = libcore.io.Libcore.os;	 Catch:{ Exception -> 0x0057 }
            r8 = r12.val$dupedFd;	 Catch:{ Exception -> 0x0057 }
            r10 = r12.val$offset2;	 Catch:{ Exception -> 0x0057 }
            r9 = android.system.OsConstants.SEEK_SET;	 Catch:{ Exception -> 0x0057 }
            r5.lseek(r8, r10, r9);	 Catch:{ Exception -> 0x0057 }
            r5 = 4096; // 0x1000 float:5.74E-42 double:2.0237E-320;
            r1 = new byte[r5];	 Catch:{ Exception -> 0x0057 }
            r6 = 0;
        L_0x0016:
            r8 = r12.val$length2;	 Catch:{ Exception -> 0x0057 }
            r5 = (r6 > r8 ? 1 : (r6 == r8 ? 0 : -1));
            if (r5 >= 0) goto L_0x002f;
        L_0x001c:
            r5 = r1.length;	 Catch:{ Exception -> 0x0057 }
            r8 = (long) r5;	 Catch:{ Exception -> 0x0057 }
            r10 = r12.val$length2;	 Catch:{ Exception -> 0x0057 }
            r10 = r10 - r6;
            r8 = java.lang.Math.min(r8, r10);	 Catch:{ Exception -> 0x0057 }
            r3 = (int) r8;	 Catch:{ Exception -> 0x0057 }
            r5 = r12.val$dupedFd;	 Catch:{ Exception -> 0x0057 }
            r8 = 0;
            r2 = libcore.io.IoBridge.read(r5, r1, r8, r3);	 Catch:{ Exception -> 0x0057 }
            if (r2 >= 0) goto L_0x0045;
        L_0x002f:
            r5 = r12.val$track;	 Catch:{ Exception -> 0x0057 }
            r8 = r0.toByteArray();	 Catch:{ Exception -> 0x0057 }
            r9 = 1;
            r10 = -1;
            r5.onData(r8, r9, r10);	 Catch:{ Exception -> 0x0057 }
            r5 = 803; // 0x323 float:1.125E-42 double:3.967E-321;
            r8 = libcore.io.Libcore.os;	 Catch:{ ErrnoException -> 0x004c }
            r9 = r12.val$dupedFd;	 Catch:{ ErrnoException -> 0x004c }
            r8.close(r9);	 Catch:{ ErrnoException -> 0x004c }
        L_0x0044:
            return r5;
        L_0x0045:
            r5 = 0;
            r0.write(r1, r5, r2);	 Catch:{ Exception -> 0x0057 }
            r8 = (long) r2;
            r6 = r6 + r8;
            goto L_0x0016;
        L_0x004c:
            r4 = move-exception;
            r8 = "MediaPlayer";
            r9 = r4.getMessage();
            android.util.Log.e(r8, r9, r4);
            goto L_0x0044;
        L_0x0057:
            r4 = move-exception;
            r5 = "MediaPlayer";
            r8 = r4.getMessage();	 Catch:{ all -> 0x0076 }
            android.util.Log.e(r5, r8, r4);	 Catch:{ all -> 0x0076 }
            r5 = 900; // 0x384 float:1.261E-42 double:4.447E-321;
            r8 = libcore.io.Libcore.os;	 Catch:{ ErrnoException -> 0x006b }
            r9 = r12.val$dupedFd;	 Catch:{ ErrnoException -> 0x006b }
            r8.close(r9);	 Catch:{ ErrnoException -> 0x006b }
            goto L_0x0044;
        L_0x006b:
            r4 = move-exception;
            r8 = "MediaPlayer";
            r9 = r4.getMessage();
            android.util.Log.e(r8, r9, r4);
            goto L_0x0044;
        L_0x0076:
            r5 = move-exception;
            r8 = libcore.io.Libcore.os;	 Catch:{ ErrnoException -> 0x007f }
            r9 = r12.val$dupedFd;	 Catch:{ ErrnoException -> 0x007f }
            r8.close(r9);	 Catch:{ ErrnoException -> 0x007f }
        L_0x007e:
            throw r5;
        L_0x007f:
            r4 = move-exception;
            r8 = "MediaPlayer";
            r9 = r4.getMessage();
            android.util.Log.e(r8, r9, r4);
            goto L_0x007e;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.media.MediaPlayer.4.addTrack():int");
        }

        public void run() {
            int res = addTrack();
            if (MediaPlayer.this.mEventHandler != null) {
                MediaPlayer.this.mEventHandler.sendMessage(MediaPlayer.this.mEventHandler.obtainMessage(MediaPlayer.MEDIA_INFO, res, MediaPlayer.MEDIA_NOP, null));
            }
            this.val$thread.getLooper().quitSafely();
        }
    }

    private class EventHandler extends Handler {
        private MediaPlayer mMediaPlayer;

        public EventHandler(MediaPlayer mp, Looper looper) {
            super(looper);
            this.mMediaPlayer = mp;
        }

        public void handleMessage(Message msg) {
            boolean z = MediaPlayer.METADATA_ALL;
            if (this.mMediaPlayer.mNativeContext == 0) {
                Log.w(MediaPlayer.TAG, "mediaplayer went away with unhandled events");
                return;
            }
            Parcel parcel;
            switch (msg.what) {
                case MediaPlayer.MEDIA_NOP /*0*/:
                    return;
                case MediaPlayer.VIDEO_SCALING_MODE_SCALE_TO_FIT /*1*/:
                    MediaPlayer.this.scanInternalSubtitleTracks();
                    if (MediaPlayer.this.mOnPreparedListener != null) {
                        MediaPlayer.this.mOnPreparedListener.onPrepared(this.mMediaPlayer);
                        return;
                    }
                    return;
                case MediaPlayer.VIDEO_SCALING_MODE_SCALE_TO_FIT_WITH_CROPPING /*2*/:
                    if (MediaPlayer.this.mOnCompletionListener != null) {
                        MediaPlayer.this.mOnCompletionListener.onCompletion(this.mMediaPlayer);
                    }
                    MediaPlayer.this.stayAwake(MediaPlayer.METADATA_ALL);
                    return;
                case MediaPlayer.MEDIA_INFO_VIDEO_RENDERING_START /*3*/:
                    if (MediaPlayer.this.mOnBufferingUpdateListener != null) {
                        MediaPlayer.this.mOnBufferingUpdateListener.onBufferingUpdate(this.mMediaPlayer, msg.arg1);
                        return;
                    }
                    return;
                case MediaPlayer.MEDIA_SEEK_COMPLETE /*4*/:
                    if (MediaPlayer.this.mOnSeekCompleteListener != null) {
                        MediaPlayer.this.mOnSeekCompleteListener.onSeekComplete(this.mMediaPlayer);
                        break;
                    }
                    break;
                case MediaPlayer.MEDIA_SET_VIDEO_SIZE /*5*/:
                    if (MediaPlayer.this.mOnVideoSizeChangedListener != null) {
                        MediaPlayer.this.mOnVideoSizeChangedListener.onVideoSizeChanged(this.mMediaPlayer, msg.arg1, msg.arg2);
                        return;
                    }
                    return;
                case MediaPlayer.MEDIA_STARTED /*6*/:
                case MediaPlayer.MEDIA_PAUSED /*7*/:
                    if (MediaPlayer.this.mTimeProvider != null) {
                        TimeProvider access$1000 = MediaPlayer.this.mTimeProvider;
                        if (msg.what == MediaPlayer.MEDIA_PAUSED) {
                            z = MediaPlayer.METADATA_UPDATE_ONLY;
                        }
                        access$1000.onPaused(z);
                        return;
                    }
                    return;
                case MediaPlayer.MEDIA_STOPPED /*8*/:
                    if (MediaPlayer.this.mTimeProvider != null) {
                        MediaPlayer.this.mTimeProvider.onStopped();
                        return;
                    }
                    return;
                case MediaPlayer.MEDIA_SKIPPED /*9*/:
                    break;
                case MediaPlayer.MEDIA_TIMED_TEXT /*99*/:
                    if (MediaPlayer.this.mOnTimedTextListener == null) {
                        return;
                    }
                    if (msg.obj == null) {
                        MediaPlayer.this.mOnTimedTextListener.onTimedText(this.mMediaPlayer, null);
                        return;
                    } else if (msg.obj instanceof Parcel) {
                        parcel = msg.obj;
                        TimedText text = new TimedText(parcel);
                        parcel.recycle();
                        MediaPlayer.this.mOnTimedTextListener.onTimedText(this.mMediaPlayer, text);
                        return;
                    } else {
                        return;
                    }
                case MediaPlayer.MEDIA_ERROR_SERVER_DIED /*100*/:
                    Log.e(MediaPlayer.TAG, "Error (" + msg.arg1 + "," + msg.arg2 + ")");
                    boolean error_was_handled = MediaPlayer.METADATA_ALL;
                    if (MediaPlayer.this.mOnErrorListener != null) {
                        error_was_handled = MediaPlayer.this.mOnErrorListener.onError(this.mMediaPlayer, msg.arg1, msg.arg2);
                    }
                    if (!(MediaPlayer.this.mOnCompletionListener == null || error_was_handled)) {
                        MediaPlayer.this.mOnCompletionListener.onCompletion(this.mMediaPlayer);
                    }
                    MediaPlayer.this.stayAwake(MediaPlayer.METADATA_ALL);
                    return;
                case MediaPlayer.MEDIA_INFO /*200*/:
                    switch (msg.arg1) {
                        case MediaPlayer.MEDIA_INFO_VIDEO_TRACK_LAGGING /*700*/:
                            Log.i(MediaPlayer.TAG, "Info (" + msg.arg1 + "," + msg.arg2 + ")");
                            break;
                        case MediaPlayer.MEDIA_INFO_METADATA_UPDATE /*802*/:
                            MediaPlayer.this.scanInternalSubtitleTracks();
                            break;
                        case MediaPlayer.MEDIA_INFO_EXTERNAL_METADATA_UPDATE /*803*/:
                            break;
                    }
                    msg.arg1 = MediaPlayer.MEDIA_INFO_METADATA_UPDATE;
                    if (MediaPlayer.this.mSubtitleController != null) {
                        MediaPlayer.this.mSubtitleController.selectDefaultTrack();
                    }
                    if (MediaPlayer.this.mOnInfoListener != null) {
                        MediaPlayer.this.mOnInfoListener.onInfo(this.mMediaPlayer, msg.arg1, msg.arg2);
                        return;
                    }
                    return;
                case MediaPlayer.MEDIA_SUBTITLE_DATA /*201*/:
                    if (MediaPlayer.this.mOnSubtitleDataListener != null && (msg.obj instanceof Parcel)) {
                        parcel = (Parcel) msg.obj;
                        SubtitleData data = new SubtitleData(parcel);
                        parcel.recycle();
                        MediaPlayer.this.mOnSubtitleDataListener.onSubtitleData(this.mMediaPlayer, data);
                        return;
                    }
                    return;
                default:
                    Log.e(MediaPlayer.TAG, "Unknown message type " + msg.what);
                    return;
            }
            if (MediaPlayer.this.mTimeProvider != null) {
                MediaPlayer.this.mTimeProvider.onSeekComplete(this.mMediaPlayer);
            }
        }
    }

    public interface OnBufferingUpdateListener {
        void onBufferingUpdate(MediaPlayer mediaPlayer, int i);
    }

    public interface OnInfoListener {
        boolean onInfo(MediaPlayer mediaPlayer, int i, int i2);
    }

    public interface OnPreparedListener {
        void onPrepared(MediaPlayer mediaPlayer);
    }

    public interface OnSeekCompleteListener {
        void onSeekComplete(MediaPlayer mediaPlayer);
    }

    public interface OnTimedTextListener {
        void onTimedText(MediaPlayer mediaPlayer, TimedText timedText);
    }

    public interface OnVideoSizeChangedListener {
        void onVideoSizeChanged(MediaPlayer mediaPlayer, int i, int i2);
    }

    static class TimeProvider implements OnSeekCompleteListener, MediaTimeProvider {
        private static final long MAX_EARLY_CALLBACK_US = 1000;
        private static final long MAX_NS_WITHOUT_POSITION_CHECK = 5000000000L;
        private static final int NOTIFY = 1;
        private static final int NOTIFY_SEEK = 3;
        private static final int NOTIFY_STOP = 2;
        private static final int NOTIFY_TIME = 0;
        private static final int REFRESH_AND_NOTIFY_TIME = 1;
        private static final String TAG = "MTP";
        private static final long TIME_ADJUSTMENT_RATE = 2;
        public boolean DEBUG;
        private Handler mEventHandler;
        private HandlerThread mHandlerThread;
        private long mLastNanoTime;
        private long mLastReportedTime;
        private long mLastTimeUs;
        private OnMediaTimeListener[] mListeners;
        private boolean mPaused;
        private boolean mPausing;
        private MediaPlayer mPlayer;
        private boolean mRefresh;
        private boolean mSeeking;
        private boolean mStopped;
        private long mTimeAdjustment;
        private long[] mTimes;

        private class EventHandler extends Handler {
            public EventHandler(Looper looper) {
                super(looper);
            }

            public void handleMessage(Message msg) {
                if (msg.what == TimeProvider.REFRESH_AND_NOTIFY_TIME) {
                    switch (msg.arg1) {
                        case TimeProvider.NOTIFY_TIME /*0*/:
                            TimeProvider.this.notifyTimedEvent(MediaPlayer.METADATA_ALL);
                        case TimeProvider.REFRESH_AND_NOTIFY_TIME /*1*/:
                            TimeProvider.this.notifyTimedEvent(MediaPlayer.METADATA_UPDATE_ONLY);
                        case TimeProvider.NOTIFY_STOP /*2*/:
                            TimeProvider.this.notifyStop();
                        case TimeProvider.NOTIFY_SEEK /*3*/:
                            TimeProvider.this.notifySeek();
                        default:
                    }
                }
            }
        }

        public TimeProvider(MediaPlayer mp) {
            this.mLastTimeUs = 0;
            this.mPaused = MediaPlayer.METADATA_UPDATE_ONLY;
            this.mStopped = MediaPlayer.METADATA_UPDATE_ONLY;
            this.mRefresh = MediaPlayer.METADATA_ALL;
            this.mPausing = MediaPlayer.METADATA_ALL;
            this.mSeeking = MediaPlayer.METADATA_ALL;
            this.DEBUG = MediaPlayer.METADATA_ALL;
            this.mPlayer = mp;
            try {
                getCurrentTimeUs(MediaPlayer.METADATA_UPDATE_ONLY, MediaPlayer.METADATA_ALL);
            } catch (IllegalStateException e) {
                this.mRefresh = MediaPlayer.METADATA_UPDATE_ONLY;
            }
            Looper looper = Looper.myLooper();
            if (looper == null) {
                looper = Looper.getMainLooper();
                if (looper == null) {
                    this.mHandlerThread = new HandlerThread("MediaPlayerMTPEventThread", -2);
                    this.mHandlerThread.start();
                    looper = this.mHandlerThread.getLooper();
                }
            }
            this.mEventHandler = new EventHandler(looper);
            this.mListeners = new OnMediaTimeListener[NOTIFY_TIME];
            this.mTimes = new long[NOTIFY_TIME];
            this.mLastTimeUs = 0;
            this.mTimeAdjustment = 0;
        }

        private void scheduleNotification(int type, long delayUs) {
            if (!this.mSeeking || (type != 0 && type != REFRESH_AND_NOTIFY_TIME)) {
                if (this.DEBUG) {
                    Log.v(TAG, "scheduleNotification " + type + " in " + delayUs);
                }
                this.mEventHandler.removeMessages(REFRESH_AND_NOTIFY_TIME);
                this.mEventHandler.sendMessageDelayed(this.mEventHandler.obtainMessage(REFRESH_AND_NOTIFY_TIME, type, NOTIFY_TIME), (long) ((int) (delayUs / MAX_EARLY_CALLBACK_US)));
            }
        }

        public void close() {
            this.mEventHandler.removeMessages(REFRESH_AND_NOTIFY_TIME);
            if (this.mHandlerThread != null) {
                this.mHandlerThread.quitSafely();
                this.mHandlerThread = null;
            }
        }

        protected void finalize() {
            if (this.mHandlerThread != null) {
                this.mHandlerThread.quitSafely();
            }
        }

        public void onPaused(boolean paused) {
            synchronized (this) {
                if (this.DEBUG) {
                    Log.d(TAG, "onPaused: " + paused);
                }
                if (this.mStopped) {
                    this.mStopped = MediaPlayer.METADATA_ALL;
                    this.mSeeking = MediaPlayer.METADATA_UPDATE_ONLY;
                    scheduleNotification(NOTIFY_SEEK, 0);
                } else {
                    this.mPausing = paused;
                    this.mSeeking = MediaPlayer.METADATA_ALL;
                    scheduleNotification(REFRESH_AND_NOTIFY_TIME, 0);
                }
            }
        }

        public void onStopped() {
            synchronized (this) {
                if (this.DEBUG) {
                    Log.d(TAG, "onStopped");
                }
                this.mPaused = MediaPlayer.METADATA_UPDATE_ONLY;
                this.mStopped = MediaPlayer.METADATA_UPDATE_ONLY;
                this.mSeeking = MediaPlayer.METADATA_ALL;
                scheduleNotification(NOTIFY_STOP, 0);
            }
        }

        public void onSeekComplete(MediaPlayer mp) {
            synchronized (this) {
                this.mStopped = MediaPlayer.METADATA_ALL;
                this.mSeeking = MediaPlayer.METADATA_UPDATE_ONLY;
                scheduleNotification(NOTIFY_SEEK, 0);
            }
        }

        public void onNewPlayer() {
            if (this.mRefresh) {
                synchronized (this) {
                    this.mStopped = MediaPlayer.METADATA_ALL;
                    this.mSeeking = MediaPlayer.METADATA_UPDATE_ONLY;
                    scheduleNotification(NOTIFY_SEEK, 0);
                }
            }
        }

        private synchronized void notifySeek() {
            this.mSeeking = MediaPlayer.METADATA_ALL;
            try {
                long timeUs = getCurrentTimeUs(MediaPlayer.METADATA_UPDATE_ONLY, MediaPlayer.METADATA_ALL);
                if (this.DEBUG) {
                    Log.d(TAG, "onSeekComplete at " + timeUs);
                }
                OnMediaTimeListener[] arr$ = this.mListeners;
                int len$ = arr$.length;
                for (int i$ = NOTIFY_TIME; i$ < len$; i$ += REFRESH_AND_NOTIFY_TIME) {
                    OnMediaTimeListener listener = arr$[i$];
                    if (listener == null) {
                        break;
                    }
                    listener.onSeek(timeUs);
                }
            } catch (IllegalStateException e) {
                if (this.DEBUG) {
                    Log.d(TAG, "onSeekComplete but no player");
                }
                this.mPausing = MediaPlayer.METADATA_UPDATE_ONLY;
                notifyTimedEvent(MediaPlayer.METADATA_ALL);
            }
        }

        private synchronized void notifyStop() {
            OnMediaTimeListener[] arr$ = this.mListeners;
            int len$ = arr$.length;
            for (int i$ = NOTIFY_TIME; i$ < len$; i$ += REFRESH_AND_NOTIFY_TIME) {
                OnMediaTimeListener listener = arr$[i$];
                if (listener == null) {
                    break;
                }
                listener.onStop();
            }
        }

        private int registerListener(OnMediaTimeListener listener) {
            int i = NOTIFY_TIME;
            while (i < this.mListeners.length && this.mListeners[i] != listener && this.mListeners[i] != null) {
                i += REFRESH_AND_NOTIFY_TIME;
            }
            if (i >= this.mListeners.length) {
                OnMediaTimeListener[] newListeners = new OnMediaTimeListener[(i + REFRESH_AND_NOTIFY_TIME)];
                long[] newTimes = new long[(i + REFRESH_AND_NOTIFY_TIME)];
                System.arraycopy(this.mListeners, NOTIFY_TIME, newListeners, NOTIFY_TIME, this.mListeners.length);
                System.arraycopy(this.mTimes, NOTIFY_TIME, newTimes, NOTIFY_TIME, this.mTimes.length);
                this.mListeners = newListeners;
                this.mTimes = newTimes;
            }
            if (this.mListeners[i] == null) {
                this.mListeners[i] = listener;
                this.mTimes[i] = -1;
            }
            return i;
        }

        public void notifyAt(long timeUs, OnMediaTimeListener listener) {
            synchronized (this) {
                if (this.DEBUG) {
                    Log.d(TAG, "notifyAt " + timeUs);
                }
                this.mTimes[registerListener(listener)] = timeUs;
                scheduleNotification(NOTIFY_TIME, 0);
            }
        }

        public void scheduleUpdate(OnMediaTimeListener listener) {
            synchronized (this) {
                if (this.DEBUG) {
                    Log.d(TAG, "scheduleUpdate");
                }
                int i = registerListener(listener);
                if (!this.mStopped) {
                    this.mTimes[i] = 0;
                    scheduleNotification(NOTIFY_TIME, 0);
                }
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void cancelNotifications(android.media.MediaTimeProvider.OnMediaTimeListener r7) {
            /*
            r6 = this;
            monitor-enter(r6);
            r0 = 0;
        L_0x0002:
            r1 = r6.mListeners;	 Catch:{ all -> 0x0051 }
            r1 = r1.length;	 Catch:{ all -> 0x0051 }
            if (r0 >= r1) goto L_0x0040;
        L_0x0007:
            r1 = r6.mListeners;	 Catch:{ all -> 0x0051 }
            r1 = r1[r0];	 Catch:{ all -> 0x0051 }
            if (r1 != r7) goto L_0x0048;
        L_0x000d:
            r1 = r6.mListeners;	 Catch:{ all -> 0x0051 }
            r2 = r0 + 1;
            r3 = r6.mListeners;	 Catch:{ all -> 0x0051 }
            r4 = r6.mListeners;	 Catch:{ all -> 0x0051 }
            r4 = r4.length;	 Catch:{ all -> 0x0051 }
            r4 = r4 - r0;
            r4 = r4 + -1;
            java.lang.System.arraycopy(r1, r2, r3, r0, r4);	 Catch:{ all -> 0x0051 }
            r1 = r6.mTimes;	 Catch:{ all -> 0x0051 }
            r2 = r0 + 1;
            r3 = r6.mTimes;	 Catch:{ all -> 0x0051 }
            r4 = r6.mTimes;	 Catch:{ all -> 0x0051 }
            r4 = r4.length;	 Catch:{ all -> 0x0051 }
            r4 = r4 - r0;
            r4 = r4 + -1;
            java.lang.System.arraycopy(r1, r2, r3, r0, r4);	 Catch:{ all -> 0x0051 }
            r1 = r6.mListeners;	 Catch:{ all -> 0x0051 }
            r2 = r6.mListeners;	 Catch:{ all -> 0x0051 }
            r2 = r2.length;	 Catch:{ all -> 0x0051 }
            r2 = r2 + -1;
            r3 = 0;
            r1[r2] = r3;	 Catch:{ all -> 0x0051 }
            r1 = r6.mTimes;	 Catch:{ all -> 0x0051 }
            r2 = r6.mTimes;	 Catch:{ all -> 0x0051 }
            r2 = r2.length;	 Catch:{ all -> 0x0051 }
            r2 = r2 + -1;
            r4 = -1;
            r1[r2] = r4;	 Catch:{ all -> 0x0051 }
        L_0x0040:
            r1 = 0;
            r2 = 0;
            r6.scheduleNotification(r1, r2);	 Catch:{ all -> 0x0051 }
            monitor-exit(r6);	 Catch:{ all -> 0x0051 }
            return;
        L_0x0048:
            r1 = r6.mListeners;	 Catch:{ all -> 0x0051 }
            r1 = r1[r0];	 Catch:{ all -> 0x0051 }
            if (r1 == 0) goto L_0x0040;
        L_0x004e:
            r0 = r0 + 1;
            goto L_0x0002;
        L_0x0051:
            r1 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x0051 }
            throw r1;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.media.MediaPlayer.TimeProvider.cancelNotifications(android.media.MediaTimeProvider$OnMediaTimeListener):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private synchronized void notifyTimedEvent(boolean r25) {
            /*
            r24 = this;
            monitor-enter(r24);
            r17 = 1;
            r0 = r24;
            r1 = r25;
            r2 = r17;
            r14 = r0.getCurrentTimeUs(r1, r2);	 Catch:{ IllegalStateException -> 0x0018 }
        L_0x000d:
            r12 = r14;
            r0 = r24;
            r0 = r0.mSeeking;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            if (r17 == 0) goto L_0x0036;
        L_0x0016:
            monitor-exit(r24);
            return;
        L_0x0018:
            r6 = move-exception;
            r17 = 1;
            r0 = r17;
            r1 = r24;
            r1.mRefresh = r0;	 Catch:{ all -> 0x0127 }
            r17 = 1;
            r0 = r17;
            r1 = r24;
            r1.mPausing = r0;	 Catch:{ all -> 0x0127 }
            r17 = 1;
            r0 = r24;
            r1 = r25;
            r2 = r17;
            r14 = r0.getCurrentTimeUs(r1, r2);	 Catch:{ all -> 0x0127 }
            goto L_0x000d;
        L_0x0036:
            r0 = r24;
            r0 = r0.DEBUG;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            if (r17 == 0) goto L_0x00a8;
        L_0x003e:
            r16 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0127 }
            r16.<init>();	 Catch:{ all -> 0x0127 }
            r17 = "notifyTimedEvent(";
            r17 = r16.append(r17);	 Catch:{ all -> 0x0127 }
            r0 = r24;
            r0 = r0.mLastTimeUs;	 Catch:{ all -> 0x0127 }
            r20 = r0;
            r0 = r17;
            r1 = r20;
            r17 = r0.append(r1);	 Catch:{ all -> 0x0127 }
            r20 = " -> ";
            r0 = r17;
            r1 = r20;
            r17 = r0.append(r1);	 Catch:{ all -> 0x0127 }
            r0 = r17;
            r17 = r0.append(r14);	 Catch:{ all -> 0x0127 }
            r20 = ") from {";
            r0 = r17;
            r1 = r20;
            r0.append(r1);	 Catch:{ all -> 0x0127 }
            r7 = 1;
            r0 = r24;
            r5 = r0.mTimes;	 Catch:{ all -> 0x0127 }
            r10 = r5.length;	 Catch:{ all -> 0x0127 }
            r8 = 0;
        L_0x0078:
            if (r8 >= r10) goto L_0x0095;
        L_0x007a:
            r18 = r5[r8];	 Catch:{ all -> 0x0127 }
            r20 = -1;
            r17 = (r18 > r20 ? 1 : (r18 == r20 ? 0 : -1));
            if (r17 != 0) goto L_0x0085;
        L_0x0082:
            r8 = r8 + 1;
            goto L_0x0078;
        L_0x0085:
            if (r7 != 0) goto L_0x008c;
        L_0x0087:
            r17 = ", ";
            r16.append(r17);	 Catch:{ all -> 0x0127 }
        L_0x008c:
            r0 = r16;
            r1 = r18;
            r0.append(r1);	 Catch:{ all -> 0x0127 }
            r7 = 0;
            goto L_0x0082;
        L_0x0095:
            r17 = "}";
            r16.append(r17);	 Catch:{ all -> 0x0127 }
            r17 = "MTP";
            r20 = r16.toString();	 Catch:{ all -> 0x0127 }
            r0 = r17;
            r1 = r20;
            android.util.Log.d(r0, r1);	 Catch:{ all -> 0x0127 }
        L_0x00a8:
            r4 = new java.util.Vector;	 Catch:{ all -> 0x0127 }
            r4.<init>();	 Catch:{ all -> 0x0127 }
            r9 = 0;
        L_0x00ae:
            r0 = r24;
            r0 = r0.mTimes;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            r0 = r17;
            r0 = r0.length;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            r0 = r17;
            if (r9 >= r0) goto L_0x00c7;
        L_0x00bd:
            r0 = r24;
            r0 = r0.mListeners;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            r17 = r17[r9];	 Catch:{ all -> 0x0127 }
            if (r17 != 0) goto L_0x012a;
        L_0x00c7:
            r17 = (r12 > r14 ? 1 : (r12 == r14 ? 0 : -1));
            if (r17 <= 0) goto L_0x0191;
        L_0x00cb:
            r0 = r24;
            r0 = r0.mPaused;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            if (r17 != 0) goto L_0x0191;
        L_0x00d3:
            r0 = r24;
            r0 = r0.DEBUG;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            if (r17 == 0) goto L_0x0106;
        L_0x00db:
            r17 = "MTP";
            r20 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0127 }
            r20.<init>();	 Catch:{ all -> 0x0127 }
            r21 = "scheduling for ";
            r20 = r20.append(r21);	 Catch:{ all -> 0x0127 }
            r0 = r20;
            r20 = r0.append(r12);	 Catch:{ all -> 0x0127 }
            r21 = " and ";
            r20 = r20.append(r21);	 Catch:{ all -> 0x0127 }
            r0 = r20;
            r20 = r0.append(r14);	 Catch:{ all -> 0x0127 }
            r20 = r20.toString();	 Catch:{ all -> 0x0127 }
            r0 = r17;
            r1 = r20;
            android.util.Log.d(r0, r1);	 Catch:{ all -> 0x0127 }
        L_0x0106:
            r17 = 0;
            r20 = r12 - r14;
            r0 = r24;
            r1 = r17;
            r2 = r20;
            r0.scheduleNotification(r1, r2);	 Catch:{ all -> 0x0127 }
        L_0x0113:
            r8 = r4.iterator();	 Catch:{ all -> 0x0127 }
        L_0x0117:
            r17 = r8.hasNext();	 Catch:{ all -> 0x0127 }
            if (r17 == 0) goto L_0x0016;
        L_0x011d:
            r11 = r8.next();	 Catch:{ all -> 0x0127 }
            r11 = (android.media.MediaTimeProvider.OnMediaTimeListener) r11;	 Catch:{ all -> 0x0127 }
            r11.onTimedEvent(r14);	 Catch:{ all -> 0x0127 }
            goto L_0x0117;
        L_0x0127:
            r17 = move-exception;
            monitor-exit(r24);
            throw r17;
        L_0x012a:
            r0 = r24;
            r0 = r0.mTimes;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            r20 = r17[r9];	 Catch:{ all -> 0x0127 }
            r22 = -1;
            r17 = (r20 > r22 ? 1 : (r20 == r22 ? 0 : -1));
            if (r17 > 0) goto L_0x013c;
        L_0x0138:
            r9 = r9 + 1;
            goto L_0x00ae;
        L_0x013c:
            r0 = r24;
            r0 = r0.mTimes;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            r20 = r17[r9];	 Catch:{ all -> 0x0127 }
            r22 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
            r22 = r22 + r14;
            r17 = (r20 > r22 ? 1 : (r20 == r22 ? 0 : -1));
            if (r17 > 0) goto L_0x0178;
        L_0x014c:
            r0 = r24;
            r0 = r0.mListeners;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            r17 = r17[r9];	 Catch:{ all -> 0x0127 }
            r0 = r17;
            r4.add(r0);	 Catch:{ all -> 0x0127 }
            r0 = r24;
            r0 = r0.DEBUG;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            if (r17 == 0) goto L_0x016d;
        L_0x0161:
            r17 = "MTP";
            r20 = "removed";
            r0 = r17;
            r1 = r20;
            android.util.Log.d(r0, r1);	 Catch:{ all -> 0x0127 }
        L_0x016d:
            r0 = r24;
            r0 = r0.mTimes;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            r20 = -1;
            r17[r9] = r20;	 Catch:{ all -> 0x0127 }
            goto L_0x0138;
        L_0x0178:
            r17 = (r12 > r14 ? 1 : (r12 == r14 ? 0 : -1));
            if (r17 == 0) goto L_0x0188;
        L_0x017c:
            r0 = r24;
            r0 = r0.mTimes;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            r20 = r17[r9];	 Catch:{ all -> 0x0127 }
            r17 = (r20 > r12 ? 1 : (r20 == r12 ? 0 : -1));
            if (r17 >= 0) goto L_0x0138;
        L_0x0188:
            r0 = r24;
            r0 = r0.mTimes;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            r12 = r17[r9];	 Catch:{ all -> 0x0127 }
            goto L_0x0138;
        L_0x0191:
            r0 = r24;
            r0 = r0.mEventHandler;	 Catch:{ all -> 0x0127 }
            r17 = r0;
            r20 = 1;
            r0 = r17;
            r1 = r20;
            r0.removeMessages(r1);	 Catch:{ all -> 0x0127 }
            goto L_0x0113;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.media.MediaPlayer.TimeProvider.notifyTimedEvent(boolean):void");
        }

        private long getEstimatedTime(long nanoTime, boolean monotonic) {
            if (this.mPaused) {
                this.mLastReportedTime = this.mLastTimeUs + this.mTimeAdjustment;
            } else {
                long timeSinceRead = (nanoTime - this.mLastNanoTime) / MAX_EARLY_CALLBACK_US;
                this.mLastReportedTime = this.mLastTimeUs + timeSinceRead;
                if (this.mTimeAdjustment > 0) {
                    long adjustment = this.mTimeAdjustment - (timeSinceRead / TIME_ADJUSTMENT_RATE);
                    if (adjustment <= 0) {
                        this.mTimeAdjustment = 0;
                    } else {
                        this.mLastReportedTime += adjustment;
                    }
                }
            }
            return this.mLastReportedTime;
        }

        public long getCurrentTimeUs(boolean refreshTime, boolean monotonic) throws IllegalStateException {
            long j;
            boolean z = MediaPlayer.METADATA_UPDATE_ONLY;
            synchronized (this) {
                if (!this.mPaused || refreshTime) {
                    long nanoTime = System.nanoTime();
                    if (refreshTime || nanoTime >= this.mLastNanoTime + MAX_NS_WITHOUT_POSITION_CHECK) {
                        try {
                            this.mLastTimeUs = ((long) this.mPlayer.getCurrentPosition()) * MAX_EARLY_CALLBACK_US;
                            if (this.mPlayer.isPlaying()) {
                                z = MediaPlayer.METADATA_ALL;
                            }
                            this.mPaused = z;
                            if (this.DEBUG) {
                                String str;
                                String str2 = TAG;
                                StringBuilder stringBuilder = new StringBuilder();
                                if (this.mPaused) {
                                    str = "paused";
                                } else {
                                    str = "playing";
                                }
                                Log.v(str2, stringBuilder.append(str).append(" at ").append(this.mLastTimeUs).toString());
                            }
                            this.mLastNanoTime = nanoTime;
                            if (!monotonic || this.mLastTimeUs >= this.mLastReportedTime) {
                                this.mTimeAdjustment = 0;
                            } else {
                                this.mTimeAdjustment = this.mLastReportedTime - this.mLastTimeUs;
                                if (this.mTimeAdjustment > 1000000) {
                                    this.mStopped = MediaPlayer.METADATA_ALL;
                                    this.mSeeking = MediaPlayer.METADATA_UPDATE_ONLY;
                                    scheduleNotification(NOTIFY_SEEK, 0);
                                }
                            }
                        } catch (IllegalStateException e) {
                            if (this.mPausing) {
                                this.mPausing = MediaPlayer.METADATA_ALL;
                                getEstimatedTime(nanoTime, monotonic);
                                this.mPaused = MediaPlayer.METADATA_UPDATE_ONLY;
                                if (this.DEBUG) {
                                    Log.d(TAG, "illegal state, but pausing: estimating at " + this.mLastReportedTime);
                                }
                                j = this.mLastReportedTime;
                            } else {
                                throw e;
                            }
                        }
                    }
                    j = getEstimatedTime(nanoTime, monotonic);
                } else {
                    j = this.mLastReportedTime;
                }
            }
            return j;
        }
    }

    public static class TrackInfo implements Parcelable {
        static final Creator<TrackInfo> CREATOR;
        public static final int MEDIA_TRACK_TYPE_AUDIO = 2;
        public static final int MEDIA_TRACK_TYPE_SUBTITLE = 4;
        public static final int MEDIA_TRACK_TYPE_TIMEDTEXT = 3;
        public static final int MEDIA_TRACK_TYPE_UNKNOWN = 0;
        public static final int MEDIA_TRACK_TYPE_VIDEO = 1;
        final MediaFormat mFormat;
        final int mTrackType;

        /* renamed from: android.media.MediaPlayer.TrackInfo.1 */
        static class C03771 implements Creator<TrackInfo> {
            C03771() {
            }

            public TrackInfo createFromParcel(Parcel in) {
                return new TrackInfo(in);
            }

            public TrackInfo[] newArray(int size) {
                return new TrackInfo[size];
            }
        }

        public int getTrackType() {
            return this.mTrackType;
        }

        public String getLanguage() {
            String language = this.mFormat.getString(Engine.KEY_PARAM_LANGUAGE);
            return language == null ? "und" : language;
        }

        public MediaFormat getFormat() {
            if (this.mTrackType == MEDIA_TRACK_TYPE_TIMEDTEXT || this.mTrackType == MEDIA_TRACK_TYPE_SUBTITLE) {
                return this.mFormat;
            }
            return null;
        }

        TrackInfo(Parcel in) {
            this.mTrackType = in.readInt();
            String language = in.readString();
            if (this.mTrackType == MEDIA_TRACK_TYPE_TIMEDTEXT) {
                this.mFormat = MediaFormat.createSubtitleFormat(MediaPlayer.MEDIA_MIMETYPE_TEXT_SUBRIP, language);
            } else if (this.mTrackType == MEDIA_TRACK_TYPE_SUBTITLE) {
                this.mFormat = MediaFormat.createSubtitleFormat(in.readString(), language);
                this.mFormat.setInteger(MediaFormat.KEY_IS_AUTOSELECT, in.readInt());
                this.mFormat.setInteger(MediaFormat.KEY_IS_DEFAULT, in.readInt());
                this.mFormat.setInteger(MediaFormat.KEY_IS_FORCED_SUBTITLE, in.readInt());
            } else {
                this.mFormat = new MediaFormat();
                this.mFormat.setString(Engine.KEY_PARAM_LANGUAGE, language);
            }
        }

        TrackInfo(int type, MediaFormat format) {
            this.mTrackType = type;
            this.mFormat = format;
        }

        public int describeContents() {
            return MEDIA_TRACK_TYPE_UNKNOWN;
        }

        public void writeToParcel(Parcel dest, int flags) {
            dest.writeInt(this.mTrackType);
            dest.writeString(getLanguage());
            if (this.mTrackType == MEDIA_TRACK_TYPE_SUBTITLE) {
                dest.writeString(this.mFormat.getString(MediaFormat.KEY_MIME));
                dest.writeInt(this.mFormat.getInteger(MediaFormat.KEY_IS_AUTOSELECT));
                dest.writeInt(this.mFormat.getInteger(MediaFormat.KEY_IS_DEFAULT));
                dest.writeInt(this.mFormat.getInteger(MediaFormat.KEY_IS_FORCED_SUBTITLE));
            }
        }

        public String toString() {
            StringBuilder out = new StringBuilder(AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
            out.append(getClass().getName());
            out.append('{');
            switch (this.mTrackType) {
                case MEDIA_TRACK_TYPE_VIDEO /*1*/:
                    out.append("VIDEO");
                    break;
                case MEDIA_TRACK_TYPE_AUDIO /*2*/:
                    out.append("AUDIO");
                    break;
                case MEDIA_TRACK_TYPE_TIMEDTEXT /*3*/:
                    out.append("TIMEDTEXT");
                    break;
                case MEDIA_TRACK_TYPE_SUBTITLE /*4*/:
                    out.append("SUBTITLE");
                    break;
                default:
                    out.append("UNKNOWN");
                    break;
            }
            out.append(", " + this.mFormat.toString());
            out.append("}");
            return out.toString();
        }

        static {
            CREATOR = new C03771();
        }
    }

    private native int _getAudioStreamType() throws IllegalStateException;

    private native void _pause() throws IllegalStateException;

    private native void _prepare() throws IOException, IllegalStateException;

    private native void _release();

    private native void _reset();

    private native boolean _resume();

    private native void _setAudioStreamType(int i);

    private native void _setAuxEffectSendLevel(float f);

    private native void _setDataSource(FileDescriptor fileDescriptor, long j, long j2) throws IOException, IllegalArgumentException, IllegalStateException;

    private native void _setVideoSurface(Surface surface);

    private native void _setVolume(float f, float f2);

    private native void _start() throws IllegalStateException;

    private native void _stop() throws IllegalStateException;

    private native boolean _suspend();

    private native void nativeSetDataSource(IBinder iBinder, String str, String[] strArr, String[] strArr2) throws IOException, IllegalArgumentException, SecurityException, IllegalStateException;

    private final native void native_finalize();

    private final native boolean native_getMetadata(boolean z, boolean z2, Parcel parcel);

    private static final native void native_init();

    private final native int native_invoke(Parcel parcel, Parcel parcel2);

    public static native int native_pullBatteryData(Parcel parcel);

    private final native int native_setMetadataFilter(Parcel parcel);

    private final native int native_setRetransmitEndpoint(String str, int i);

    private final native void native_setup(Object obj);

    private native boolean setParameter(int i, Parcel parcel);

    public native void attachAuxEffect(int i);

    public native int getAudioSessionId();

    public native int getCurrentPosition();

    public native int getDuration();

    public native int getVideoHeight();

    public native int getVideoWidth();

    public native boolean isLooping();

    public native boolean isPlaying();

    public native void prepareAsync() throws IllegalStateException;

    public native void seekTo(int i) throws IllegalStateException;

    public native void setAudioSessionId(int i) throws IllegalArgumentException, IllegalStateException;

    public native void setLooping(boolean z);

    public native void setNextMediaPlayer(MediaPlayer mediaPlayer);

    static {
        System.loadLibrary("media_jni");
        native_init();
    }

    public MediaPlayer() {
        this.mWakeLock = null;
        this.mStreamType = RtlSpacingHelper.UNDEFINED;
        this.mUsage = -1;
        this.mInbandSubtitleLock = new Object();
        this.mSelectedSubtitleTrackIndex = -1;
        this.mSubtitleDataListener = new C03731();
        Looper looper = Looper.myLooper();
        if (looper != null) {
            this.mEventHandler = new EventHandler(this, looper);
        } else {
            looper = Looper.getMainLooper();
            if (looper != null) {
                this.mEventHandler = new EventHandler(this, looper);
            } else {
                this.mEventHandler = null;
            }
        }
        this.mTimeProvider = new TimeProvider(this);
        this.mOutOfBandSubtitleTracks = new Vector();
        this.mOpenSubtitleSources = new Vector();
        this.mInbandSubtitleTracks = new SubtitleTrack[MEDIA_NOP];
        this.mAppOps = Stub.asInterface(ServiceManager.getService(Context.APP_OPS_SERVICE));
        native_setup(new WeakReference(this));
    }

    public Parcel newRequest() {
        Parcel parcel = Parcel.obtain();
        parcel.writeInterfaceToken(IMEDIA_PLAYER);
        return parcel;
    }

    public void invoke(Parcel request, Parcel reply) {
        int retcode = native_invoke(request, reply);
        reply.setDataPosition(MEDIA_NOP);
        if (retcode != 0) {
            throw new RuntimeException("failure code: " + retcode);
        }
    }

    public void setDisplay(SurfaceHolder sh) {
        Surface surface;
        this.mSurfaceHolder = sh;
        if (sh != null) {
            surface = sh.getSurface();
        } else {
            surface = null;
        }
        _setVideoSurface(surface);
        updateSurfaceScreenOn();
    }

    public void setSurface(Surface surface) {
        if (this.mScreenOnWhilePlaying && surface != null) {
            Log.w(TAG, "setScreenOnWhilePlaying(true) is ineffective for Surface");
        }
        this.mSurfaceHolder = null;
        _setVideoSurface(surface);
        updateSurfaceScreenOn();
    }

    public void setVideoScalingMode(int mode) {
        if (isVideoScalingModeSupported(mode)) {
            Parcel request = Parcel.obtain();
            Parcel reply = Parcel.obtain();
            try {
                request.writeInterfaceToken(IMEDIA_PLAYER);
                request.writeInt(MEDIA_STARTED);
                request.writeInt(mode);
                invoke(request, reply);
            } finally {
                request.recycle();
                reply.recycle();
            }
        } else {
            throw new IllegalArgumentException("Scaling mode " + mode + " is not supported");
        }
    }

    public static MediaPlayer create(Context context, Uri uri) {
        return create(context, uri, null);
    }

    public static MediaPlayer create(Context context, Uri uri, SurfaceHolder holder) {
        int s = AudioSystem.newAudioSessionId();
        if (s <= 0) {
            s = MEDIA_NOP;
        }
        return create(context, uri, holder, null, s);
    }

    public static MediaPlayer create(Context context, Uri uri, SurfaceHolder holder, AudioAttributes audioAttributes, int audioSessionId) {
        try {
            MediaPlayer mp = new MediaPlayer();
            mp.setAudioAttributes(audioAttributes != null ? audioAttributes : new Builder().build());
            mp.setAudioSessionId(audioSessionId);
            mp.setDataSource(context, uri);
            if (holder != null) {
                mp.setDisplay(holder);
            }
            mp.prepare();
            return mp;
        } catch (IOException ex) {
            Log.d(TAG, "create failed:", ex);
            return null;
        } catch (IllegalArgumentException ex2) {
            Log.d(TAG, "create failed:", ex2);
            return null;
        } catch (SecurityException ex3) {
            Log.d(TAG, "create failed:", ex3);
            return null;
        }
    }

    public static MediaPlayer create(Context context, int resid) {
        int s = AudioSystem.newAudioSessionId();
        if (s <= 0) {
            s = MEDIA_NOP;
        }
        return create(context, resid, null, s);
    }

    public static MediaPlayer create(Context context, int resid, AudioAttributes audioAttributes, int audioSessionId) {
        try {
            AssetFileDescriptor afd = context.getResources().openRawResourceFd(resid);
            if (afd == null) {
                return null;
            }
            AudioAttributes aa;
            MediaPlayer mp = new MediaPlayer();
            if (audioAttributes != null) {
                aa = audioAttributes;
            } else {
                aa = new Builder().build();
            }
            mp.setAudioAttributes(aa);
            mp.setAudioSessionId(audioSessionId);
            mp.setDataSource(afd.getFileDescriptor(), afd.getStartOffset(), afd.getLength());
            afd.close();
            mp.prepare();
            return mp;
        } catch (IOException ex) {
            Log.d(TAG, "create failed:", ex);
            return null;
        } catch (IllegalArgumentException ex2) {
            Log.d(TAG, "create failed:", ex2);
            return null;
        } catch (SecurityException ex3) {
            Log.d(TAG, "create failed:", ex3);
            return null;
        }
    }

    public void setDataSource(Context context, Uri uri) throws IOException, IllegalArgumentException, SecurityException, IllegalStateException {
        setDataSource(context, uri, null);
    }

    public void setDataSource(Context context, Uri uri, Map<String, String> headers) throws IOException, IllegalArgumentException, SecurityException, IllegalStateException {
        String scheme = uri.getScheme();
        if (ContentResolver.SCHEME_FILE.equals(scheme)) {
            setDataSource(uri.getPath());
            return;
        }
        if (ContentResolver.SCHEME_CONTENT.equals(scheme) && "settings".equals(uri.getAuthority())) {
            uri = RingtoneManager.getActualDefaultRingtoneUri(context, RingtoneManager.getDefaultType(uri));
            if (uri == null) {
                throw new FileNotFoundException("Failed to resolve default ringtone");
            }
        }
        AssetFileDescriptor fd = null;
        try {
            fd = context.getContentResolver().openAssetFileDescriptor(uri, "r");
            if (fd != null) {
                if (fd.getDeclaredLength() < 0) {
                    setDataSource(fd.getFileDescriptor());
                } else {
                    setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getDeclaredLength());
                }
                if (fd != null) {
                    fd.close();
                }
            } else if (fd != null) {
                fd.close();
            }
        } catch (SecurityException e) {
            if (fd != null) {
                fd.close();
            }
            Log.d(TAG, "Couldn't open file on client side, trying server side");
            setDataSource(uri.toString(), (Map) headers);
        } catch (IOException e2) {
            if (fd != null) {
                fd.close();
            }
            Log.d(TAG, "Couldn't open file on client side, trying server side");
            setDataSource(uri.toString(), (Map) headers);
        } catch (Throwable th) {
            if (fd != null) {
                fd.close();
            }
        }
    }

    public void setDataSource(String path) throws IOException, IllegalArgumentException, SecurityException, IllegalStateException {
        setDataSource(path, null, null);
    }

    public void setDataSource(String path, Map<String, String> headers) throws IOException, IllegalArgumentException, SecurityException, IllegalStateException {
        String[] keys = null;
        String[] values = null;
        if (headers != null) {
            keys = new String[headers.size()];
            values = new String[headers.size()];
            int i = MEDIA_NOP;
            for (Entry<String, String> entry : headers.entrySet()) {
                keys[i] = (String) entry.getKey();
                values[i] = (String) entry.getValue();
                i += VIDEO_SCALING_MODE_SCALE_TO_FIT;
            }
        }
        setDataSource(path, keys, values);
    }

    private void setDataSource(String path, String[] keys, String[] values) throws IOException, IllegalArgumentException, SecurityException, IllegalStateException {
        Uri uri = Uri.parse(path);
        String scheme = uri.getScheme();
        if (ContentResolver.SCHEME_FILE.equals(scheme)) {
            path = uri.getPath();
        } else if (scheme != null) {
            nativeSetDataSource(MediaHTTPService.createHttpServiceBinderIfNecessary(path), path, keys, values);
            return;
        }
        File file = new File(path);
        if (file.exists()) {
            FileInputStream is = new FileInputStream(file);
            setDataSource(is.getFD());
            is.close();
            return;
        }
        throw new IOException("setDataSource failed.");
    }

    public void setDataSource(FileDescriptor fd) throws IOException, IllegalArgumentException, IllegalStateException {
        setDataSource(fd, 0, 576460752303423487L);
    }

    public void setDataSource(FileDescriptor fd, long offset, long length) throws IOException, IllegalArgumentException, IllegalStateException {
        _setDataSource(fd, offset, length);
    }

    public void prepare() throws IOException, IllegalStateException {
        _prepare();
        scanInternalSubtitleTracks();
    }

    public void start() throws IllegalStateException {
        if (isRestricted()) {
            _setVolume(0.0f, 0.0f);
        }
        stayAwake(METADATA_UPDATE_ONLY);
        _start();
    }

    private boolean isRestricted() {
        try {
            if (this.mAppOps.checkAudioOperation(28, this.mUsage != -1 ? this.mUsage : AudioAttributes.usageForLegacyStreamType(getAudioStreamType()), Process.myUid(), ActivityThread.currentPackageName()) != 0) {
                return METADATA_UPDATE_ONLY;
            }
            return METADATA_ALL;
        } catch (RemoteException e) {
            return METADATA_ALL;
        }
    }

    private int getAudioStreamType() {
        if (this.mStreamType == RtlSpacingHelper.UNDEFINED) {
            this.mStreamType = _getAudioStreamType();
        }
        return this.mStreamType;
    }

    public void stop() throws IllegalStateException {
        stayAwake(METADATA_ALL);
        _stop();
    }

    public void pause() throws IllegalStateException {
        stayAwake(METADATA_ALL);
        _pause();
    }

    public void setWakeMode(Context context, int mode) {
        boolean washeld = METADATA_ALL;
        if (this.mWakeLock != null) {
            if (this.mWakeLock.isHeld()) {
                washeld = METADATA_UPDATE_ONLY;
                this.mWakeLock.release();
            }
            this.mWakeLock = null;
        }
        this.mWakeLock = ((PowerManager) context.getSystemService(Context.POWER_SERVICE)).newWakeLock(EditorInfo.IME_FLAG_NO_ACCESSORY_ACTION | mode, MediaPlayer.class.getName());
        this.mWakeLock.setReferenceCounted(METADATA_ALL);
        if (washeld) {
            this.mWakeLock.acquire();
        }
    }

    public void setScreenOnWhilePlaying(boolean screenOn) {
        if (this.mScreenOnWhilePlaying != screenOn) {
            if (screenOn && this.mSurfaceHolder == null) {
                Log.w(TAG, "setScreenOnWhilePlaying(true) is ineffective without a SurfaceHolder");
            }
            this.mScreenOnWhilePlaying = screenOn;
            updateSurfaceScreenOn();
        }
    }

    private void stayAwake(boolean awake) {
        if (this.mWakeLock != null) {
            if (awake && !this.mWakeLock.isHeld()) {
                this.mWakeLock.acquire();
            } else if (!awake && this.mWakeLock.isHeld()) {
                this.mWakeLock.release();
            }
        }
        this.mStayAwake = awake;
        updateSurfaceScreenOn();
    }

    private void updateSurfaceScreenOn() {
        if (this.mSurfaceHolder != null) {
            SurfaceHolder surfaceHolder = this.mSurfaceHolder;
            boolean z = (this.mScreenOnWhilePlaying && this.mStayAwake) ? METADATA_UPDATE_ONLY : METADATA_ALL;
            surfaceHolder.setKeepScreenOn(z);
        }
    }

    public Metadata getMetadata(boolean update_only, boolean apply_filter) {
        Parcel reply = Parcel.obtain();
        Metadata data = new Metadata();
        if (!native_getMetadata(update_only, apply_filter, reply)) {
            reply.recycle();
            return null;
        } else if (data.parse(reply)) {
            return data;
        } else {
            reply.recycle();
            return null;
        }
    }

    public int setMetadataFilter(Set<Integer> allow, Set<Integer> block) {
        Parcel request = newRequest();
        int capacity = request.dataSize() + ((((allow.size() + VIDEO_SCALING_MODE_SCALE_TO_FIT) + VIDEO_SCALING_MODE_SCALE_TO_FIT) + block.size()) * MEDIA_SEEK_COMPLETE);
        if (request.dataCapacity() < capacity) {
            request.setDataCapacity(capacity);
        }
        request.writeInt(allow.size());
        for (Integer t : allow) {
            request.writeInt(t.intValue());
        }
        request.writeInt(block.size());
        for (Integer t2 : block) {
            request.writeInt(t2.intValue());
        }
        return native_setMetadataFilter(request);
    }

    public void release() {
        stayAwake(METADATA_ALL);
        updateSurfaceScreenOn();
        this.mOnPreparedListener = null;
        this.mOnBufferingUpdateListener = null;
        this.mOnCompletionListener = null;
        this.mOnSeekCompleteListener = null;
        this.mOnErrorListener = null;
        this.mOnInfoListener = null;
        this.mOnVideoSizeChangedListener = null;
        this.mOnTimedTextListener = null;
        if (this.mTimeProvider != null) {
            this.mTimeProvider.close();
            this.mTimeProvider = null;
        }
        this.mOnSubtitleDataListener = null;
        _release();
    }

    public void reset() {
        this.mSelectedSubtitleTrackIndex = -1;
        synchronized (this.mOpenSubtitleSources) {
            Iterator i$ = this.mOpenSubtitleSources.iterator();
            while (i$.hasNext()) {
                try {
                    ((InputStream) i$.next()).close();
                } catch (IOException e) {
                }
            }
            this.mOpenSubtitleSources.clear();
        }
        this.mOutOfBandSubtitleTracks.clear();
        this.mInbandSubtitleTracks = new SubtitleTrack[MEDIA_NOP];
        if (this.mSubtitleController != null) {
            this.mSubtitleController.reset();
        }
        if (this.mTimeProvider != null) {
            this.mTimeProvider.close();
            this.mTimeProvider = null;
        }
        stayAwake(METADATA_ALL);
        _reset();
        if (this.mEventHandler != null) {
            this.mEventHandler.removeCallbacksAndMessages(null);
        }
    }

    public void setAudioStreamType(int streamtype) {
        _setAudioStreamType(streamtype);
        this.mStreamType = streamtype;
    }

    public void setAudioAttributes(AudioAttributes attributes) throws IllegalArgumentException {
        if (attributes == null) {
            String msg = "Cannot set AudioAttributes to null";
            throw new IllegalArgumentException("Cannot set AudioAttributes to null");
        }
        this.mUsage = attributes.getUsage();
        Parcel pattributes = Parcel.obtain();
        attributes.writeToParcel(pattributes, VIDEO_SCALING_MODE_SCALE_TO_FIT);
        setParameter(KEY_PARAMETER_AUDIO_ATTRIBUTES, pattributes);
        pattributes.recycle();
    }

    public void setVolume(float leftVolume, float rightVolume) {
        if (!isRestricted()) {
            _setVolume(leftVolume, rightVolume);
        }
    }

    public void setVolume(float volume) {
        setVolume(volume, volume);
    }

    public void setAuxEffectSendLevel(float level) {
        if (!isRestricted()) {
            _setAuxEffectSendLevel(level);
        }
    }

    public TrackInfo[] getTrackInfo() throws IllegalStateException {
        TrackInfo[] trackInfo = getInbandTrackInfo();
        TrackInfo[] allTrackInfo = new TrackInfo[(trackInfo.length + this.mOutOfBandSubtitleTracks.size())];
        System.arraycopy(trackInfo, MEDIA_NOP, allTrackInfo, MEDIA_NOP, trackInfo.length);
        int i = trackInfo.length;
        Iterator i$ = this.mOutOfBandSubtitleTracks.iterator();
        while (i$.hasNext()) {
            SubtitleTrack track = (SubtitleTrack) i$.next();
            allTrackInfo[i] = new TrackInfo(track.isTimedText() ? MEDIA_INFO_VIDEO_RENDERING_START : MEDIA_SEEK_COMPLETE, track.getFormat());
            i += VIDEO_SCALING_MODE_SCALE_TO_FIT;
        }
        return allTrackInfo;
    }

    private TrackInfo[] getInbandTrackInfo() throws IllegalStateException {
        Parcel request = Parcel.obtain();
        Parcel reply = Parcel.obtain();
        try {
            request.writeInterfaceToken(IMEDIA_PLAYER);
            request.writeInt(VIDEO_SCALING_MODE_SCALE_TO_FIT);
            invoke(request, reply);
            TrackInfo[] trackInfo = (TrackInfo[]) reply.createTypedArray(TrackInfo.CREATOR);
            return trackInfo;
        } finally {
            request.recycle();
            reply.recycle();
        }
    }

    private static boolean availableMimeTypeForExternalSource(String mimeType) {
        if (MEDIA_MIMETYPE_TEXT_SUBRIP.equals(mimeType)) {
            return METADATA_UPDATE_ONLY;
        }
        return METADATA_ALL;
    }

    public void setSubtitleAnchor(SubtitleController controller, Anchor anchor) {
        this.mSubtitleController = controller;
        this.mSubtitleController.setAnchor(anchor);
    }

    public void onSubtitleTrackSelected(SubtitleTrack track) {
        if (this.mSelectedSubtitleTrackIndex >= 0) {
            try {
                selectOrDeselectInbandTrack(this.mSelectedSubtitleTrackIndex, METADATA_ALL);
            } catch (IllegalStateException e) {
            }
            this.mSelectedSubtitleTrackIndex = -1;
        }
        setOnSubtitleDataListener(null);
        if (track != null) {
            for (int i = MEDIA_NOP; i < this.mInbandSubtitleTracks.length; i += VIDEO_SCALING_MODE_SCALE_TO_FIT) {
                if (this.mInbandSubtitleTracks[i] == track) {
                    Log.v(TAG, "Selecting subtitle track " + i);
                    this.mSelectedSubtitleTrackIndex = i;
                    try {
                        selectOrDeselectInbandTrack(this.mSelectedSubtitleTrackIndex, METADATA_UPDATE_ONLY);
                    } catch (IllegalStateException e2) {
                    }
                    setOnSubtitleDataListener(this.mSubtitleDataListener);
                    return;
                }
            }
        }
    }

    public void addSubtitleSource(InputStream is, MediaFormat format) throws IllegalStateException {
        InputStream fIs = is;
        MediaFormat fFormat = format;
        synchronized (this.mOpenSubtitleSources) {
            this.mOpenSubtitleSources.add(is);
        }
        HandlerThread thread = new HandlerThread("SubtitleReadThread", MEDIA_SKIPPED);
        thread.start();
        new Handler(thread.getLooper()).post(new C03742(fIs, fFormat, thread));
    }

    private void scanInternalSubtitleTracks() {
        if (this.mSubtitleController == null) {
            Log.e(TAG, "Should have subtitle controller already set");
            return;
        }
        TrackInfo[] tracks = getInbandTrackInfo();
        synchronized (this.mInbandSubtitleLock) {
            SubtitleTrack[] inbandTracks = new SubtitleTrack[tracks.length];
            for (int i = MEDIA_NOP; i < tracks.length; i += VIDEO_SCALING_MODE_SCALE_TO_FIT) {
                if (tracks[i].getTrackType() == MEDIA_SEEK_COMPLETE) {
                    if (i < this.mInbandSubtitleTracks.length) {
                        inbandTracks[i] = this.mInbandSubtitleTracks[i];
                    } else {
                        inbandTracks[i] = this.mSubtitleController.addTrack(tracks[i].getFormat());
                    }
                }
            }
            this.mInbandSubtitleTracks = inbandTracks;
        }
        this.mSubtitleController.selectDefaultTrack();
    }

    public void addTimedTextSource(String path, String mimeType) throws IOException, IllegalArgumentException, IllegalStateException {
        if (availableMimeTypeForExternalSource(mimeType)) {
            File file = new File(path);
            if (file.exists()) {
                FileInputStream is = new FileInputStream(file);
                addTimedTextSource(is.getFD(), mimeType);
                is.close();
                return;
            }
            throw new IOException(path);
        }
        throw new IllegalArgumentException("Illegal mimeType for timed text source: " + mimeType);
    }

    public void addTimedTextSource(Context context, Uri uri, String mimeType) throws IOException, IllegalArgumentException, IllegalStateException {
        String scheme = uri.getScheme();
        if (scheme == null || scheme.equals(ContentResolver.SCHEME_FILE)) {
            addTimedTextSource(uri.getPath(), mimeType);
            return;
        }
        AssetFileDescriptor fd = null;
        try {
            fd = context.getContentResolver().openAssetFileDescriptor(uri, "r");
            if (fd != null) {
                addTimedTextSource(fd.getFileDescriptor(), mimeType);
                if (fd != null) {
                    fd.close();
                }
            } else if (fd != null) {
                fd.close();
            }
        } catch (SecurityException e) {
            if (fd != null) {
                fd.close();
            }
        } catch (IOException e2) {
            if (fd != null) {
                fd.close();
            }
        } catch (Throwable th) {
            if (fd != null) {
                fd.close();
            }
        }
    }

    public void addTimedTextSource(FileDescriptor fd, String mimeType) throws IllegalArgumentException, IllegalStateException {
        addTimedTextSource(fd, 0, 576460752303423487L, mimeType);
    }

    public void addTimedTextSource(FileDescriptor fd, long offset, long length, String mime) throws IllegalArgumentException, IllegalStateException {
        if (availableMimeTypeForExternalSource(mime)) {
            try {
                FileDescriptor dupedFd = Libcore.os.dup(fd);
                MediaFormat fFormat = new MediaFormat();
                fFormat.setString(MediaFormat.KEY_MIME, mime);
                fFormat.setInteger(MediaFormat.KEY_IS_TIMED_TEXT, VIDEO_SCALING_MODE_SCALE_TO_FIT);
                Context context = ActivityThread.currentApplication();
                if (this.mSubtitleController == null) {
                    this.mSubtitleController = new SubtitleController(context, this.mTimeProvider, this);
                    this.mSubtitleController.setAnchor(new C03753());
                }
                if (!this.mSubtitleController.hasRendererFor(fFormat)) {
                    this.mSubtitleController.registerRenderer(new SRTRenderer(context, this.mEventHandler));
                }
                SubtitleTrack track = this.mSubtitleController.addTrack(fFormat);
                this.mOutOfBandSubtitleTracks.add(track);
                long offset2 = offset;
                long length2 = length;
                HandlerThread thread = new HandlerThread("TimedTextReadThread", MEDIA_SKIPPED);
                thread.start();
                new Handler(thread.getLooper()).post(new C03764(dupedFd, offset2, length2, track, thread));
                return;
            } catch (ErrnoException ex) {
                Log.e(TAG, ex.getMessage(), ex);
                throw new RuntimeException(ex);
            }
        }
        throw new IllegalArgumentException("Illegal mimeType for timed text source: " + mime);
    }

    public int getSelectedTrack(int trackType) throws IllegalStateException {
        if (trackType == MEDIA_SEEK_COMPLETE && this.mSubtitleController != null) {
            SubtitleTrack subtitleTrack = this.mSubtitleController.getSelectedTrack();
            if (subtitleTrack != null) {
                int index = this.mOutOfBandSubtitleTracks.indexOf(subtitleTrack);
                if (index >= 0) {
                    return this.mInbandSubtitleTracks.length + index;
                }
            }
        }
        Parcel request = Parcel.obtain();
        Parcel reply = Parcel.obtain();
        try {
            request.writeInterfaceToken(IMEDIA_PLAYER);
            request.writeInt(MEDIA_PAUSED);
            request.writeInt(trackType);
            invoke(request, reply);
            int readInt = reply.readInt();
            return readInt;
        } finally {
            request.recycle();
            reply.recycle();
        }
    }

    public void selectTrack(int index) throws IllegalStateException {
        selectOrDeselectTrack(index, METADATA_UPDATE_ONLY);
    }

    public void deselectTrack(int index) throws IllegalStateException {
        selectOrDeselectTrack(index, METADATA_ALL);
    }

    private void selectOrDeselectTrack(int index, boolean select) throws IllegalStateException {
        SubtitleTrack track = null;
        synchronized (this.mInbandSubtitleLock) {
            if (this.mInbandSubtitleTracks.length == 0) {
                TrackInfo[] tracks = getInbandTrackInfo();
                this.mInbandSubtitleTracks = new SubtitleTrack[tracks.length];
                for (int i = MEDIA_NOP; i < tracks.length; i += VIDEO_SCALING_MODE_SCALE_TO_FIT) {
                    if (tracks[i].getTrackType() == MEDIA_SEEK_COMPLETE) {
                        this.mInbandSubtitleTracks[i] = this.mSubtitleController.addTrack(tracks[i].getFormat());
                    }
                }
            }
        }
        if (index < this.mInbandSubtitleTracks.length) {
            track = this.mInbandSubtitleTracks[index];
        } else if (index < this.mInbandSubtitleTracks.length + this.mOutOfBandSubtitleTracks.size()) {
            track = (SubtitleTrack) this.mOutOfBandSubtitleTracks.get(index - this.mInbandSubtitleTracks.length);
        }
        if (this.mSubtitleController == null || track == null) {
            selectOrDeselectInbandTrack(index, select);
        } else if (select) {
            if (track.isTimedText()) {
                int ttIndex = getSelectedTrack(MEDIA_INFO_VIDEO_RENDERING_START);
                if (ttIndex >= 0 && ttIndex < this.mInbandSubtitleTracks.length) {
                    selectOrDeselectInbandTrack(ttIndex, METADATA_ALL);
                }
            }
            this.mSubtitleController.selectTrack(track);
        } else if (this.mSubtitleController.getSelectedTrack() == track) {
            this.mSubtitleController.selectTrack(null);
        } else {
            Log.w(TAG, "trying to deselect track that was not selected");
        }
    }

    private void selectOrDeselectInbandTrack(int index, boolean select) throws IllegalStateException {
        Parcel request = Parcel.obtain();
        Parcel reply = Parcel.obtain();
        try {
            request.writeInterfaceToken(IMEDIA_PLAYER);
            request.writeInt(select ? MEDIA_SEEK_COMPLETE : MEDIA_SET_VIDEO_SIZE);
            request.writeInt(index);
            invoke(request, reply);
        } finally {
            request.recycle();
            reply.recycle();
        }
    }

    public void setRetransmitEndpoint(InetSocketAddress endpoint) throws IllegalStateException, IllegalArgumentException {
        String addrString = null;
        int port = MEDIA_NOP;
        if (endpoint != null) {
            addrString = endpoint.getAddress().getHostAddress();
            port = endpoint.getPort();
        }
        int ret = native_setRetransmitEndpoint(addrString, port);
        if (ret != 0) {
            throw new IllegalArgumentException("Illegal re-transmit endpoint; native ret " + ret);
        }
    }

    protected void finalize() {
        native_finalize();
    }

    public MediaTimeProvider getMediaTimeProvider() {
        if (this.mTimeProvider == null) {
            this.mTimeProvider = new TimeProvider(this);
        }
        return this.mTimeProvider;
    }

    private static void postEventFromNative(Object mediaplayer_ref, int what, int arg1, int arg2, Object obj) {
        MediaPlayer mp = (MediaPlayer) ((WeakReference) mediaplayer_ref).get();
        if (mp != null) {
            if (what == MEDIA_INFO && arg1 == VIDEO_SCALING_MODE_SCALE_TO_FIT_WITH_CROPPING) {
                mp.start();
            }
            if (mp.mEventHandler != null) {
                mp.mEventHandler.sendMessage(mp.mEventHandler.obtainMessage(what, arg1, arg2, obj));
            }
        }
    }

    public void setOnPreparedListener(OnPreparedListener listener) {
        this.mOnPreparedListener = listener;
    }

    public void setOnCompletionListener(OnCompletionListener listener) {
        this.mOnCompletionListener = listener;
    }

    public void setOnBufferingUpdateListener(OnBufferingUpdateListener listener) {
        this.mOnBufferingUpdateListener = listener;
    }

    public void setOnSeekCompleteListener(OnSeekCompleteListener listener) {
        this.mOnSeekCompleteListener = listener;
    }

    public void setOnVideoSizeChangedListener(OnVideoSizeChangedListener listener) {
        this.mOnVideoSizeChangedListener = listener;
    }

    public void setOnTimedTextListener(OnTimedTextListener listener) {
        this.mOnTimedTextListener = listener;
    }

    public void setOnSubtitleDataListener(OnSubtitleDataListener listener) {
        this.mOnSubtitleDataListener = listener;
    }

    public void setOnErrorListener(OnErrorListener listener) {
        this.mOnErrorListener = listener;
    }

    public void setOnInfoListener(OnInfoListener listener) {
        this.mOnInfoListener = listener;
    }

    private boolean isVideoScalingModeSupported(int mode) {
        return (mode == VIDEO_SCALING_MODE_SCALE_TO_FIT || mode == VIDEO_SCALING_MODE_SCALE_TO_FIT_WITH_CROPPING) ? METADATA_UPDATE_ONLY : METADATA_ALL;
    }

    public boolean suspend() {
        stayAwake(METADATA_ALL);
        return _suspend();
    }

    public boolean resume() {
        return _resume();
    }
}
