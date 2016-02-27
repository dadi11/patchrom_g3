package android.widget;

import android.C0000R;
import android.app.AlertDialog.Builder;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.media.AudioManager;
import android.media.ClosedCaptionRenderer;
import android.media.MediaFormat;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnBufferingUpdateListener;
import android.media.MediaPlayer.OnCompletionListener;
import android.media.MediaPlayer.OnErrorListener;
import android.media.MediaPlayer.OnInfoListener;
import android.media.MediaPlayer.OnPreparedListener;
import android.media.MediaPlayer.OnVideoSizeChangedListener;
import android.media.Metadata;
import android.media.SubtitleController;
import android.media.SubtitleController.Anchor;
import android.media.SubtitleTrack.RenderingWidget;
import android.media.SubtitleTrack.RenderingWidget.OnChangedListener;
import android.media.TtmlRenderer;
import android.media.WebVttRenderer;
import android.net.Uri;
import android.os.Looper;
import android.util.AttributeSet;
import android.util.Log;
import android.util.Pair;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceHolder.Callback;
import android.view.SurfaceView;
import android.view.View;
import android.view.View.MeasureSpec;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.EditorInfo;
import android.widget.MediaController.MediaPlayerControl;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

public class VideoView extends SurfaceView implements MediaPlayerControl, Anchor {
    private static final int STATE_ERROR = -1;
    private static final int STATE_IDLE = 0;
    private static final int STATE_PAUSED = 4;
    private static final int STATE_PLAYBACK_COMPLETED = 5;
    private static final int STATE_PLAYING = 3;
    private static final int STATE_PREPARED = 2;
    private static final int STATE_PREPARING = 1;
    private static final int STATE_SUSPENDED = 6;
    private String TAG;
    private int mAudioSession;
    private OnBufferingUpdateListener mBufferingUpdateListener;
    private boolean mCanPause;
    private boolean mCanSeekBack;
    private boolean mCanSeekForward;
    private OnCompletionListener mCompletionListener;
    private int mCurrentBufferPercentage;
    private int mCurrentState;
    private OnErrorListener mErrorListener;
    private Map<String, String> mHeaders;
    private OnInfoListener mInfoListener;
    private MediaController mMediaController;
    private MediaPlayer mMediaPlayer;
    private OnCompletionListener mOnCompletionListener;
    private OnErrorListener mOnErrorListener;
    private OnInfoListener mOnInfoListener;
    private OnPreparedListener mOnPreparedListener;
    private Vector<Pair<InputStream, MediaFormat>> mPendingSubtitleTracks;
    OnPreparedListener mPreparedListener;
    Callback mSHCallback;
    private int mSeekWhenPrepared;
    OnVideoSizeChangedListener mSizeChangedListener;
    private RenderingWidget mSubtitleWidget;
    private OnChangedListener mSubtitlesChangedListener;
    private int mSurfaceHeight;
    private SurfaceHolder mSurfaceHolder;
    private int mSurfaceWidth;
    private int mTargetState;
    private Uri mUri;
    private int mVideoHeight;
    private int mVideoWidth;

    /* renamed from: android.widget.VideoView.1 */
    class C10901 implements OnVideoSizeChangedListener {
        C10901() {
        }

        public void onVideoSizeChanged(MediaPlayer mp, int width, int height) {
            VideoView.this.mVideoWidth = mp.getVideoWidth();
            VideoView.this.mVideoHeight = mp.getVideoHeight();
            if (VideoView.this.mVideoWidth != 0 && VideoView.this.mVideoHeight != 0) {
                VideoView.this.getHolder().setFixedSize(VideoView.this.mVideoWidth, VideoView.this.mVideoHeight);
                VideoView.this.requestLayout();
            }
        }
    }

    /* renamed from: android.widget.VideoView.2 */
    class C10912 implements OnPreparedListener {
        C10912() {
        }

        public void onPrepared(MediaPlayer mp) {
            VideoView.this.mCurrentState = VideoView.STATE_PREPARED;
            Metadata data = mp.getMetadata(false, false);
            if (data != null) {
                boolean z;
                VideoView videoView = VideoView.this;
                if (!data.has(VideoView.STATE_PREPARING) || data.getBoolean(VideoView.STATE_PREPARING)) {
                    z = true;
                } else {
                    z = false;
                }
                videoView.mCanPause = z;
                videoView = VideoView.this;
                if (!data.has(VideoView.STATE_PREPARED) || data.getBoolean(VideoView.STATE_PREPARED)) {
                    z = true;
                } else {
                    z = false;
                }
                videoView.mCanSeekBack = z;
                videoView = VideoView.this;
                if (!data.has(VideoView.STATE_PLAYING) || data.getBoolean(VideoView.STATE_PLAYING)) {
                    z = true;
                } else {
                    z = false;
                }
                videoView.mCanSeekForward = z;
                data.recycleParcel();
            } else {
                VideoView.this.mCanPause = VideoView.this.mCanSeekBack = VideoView.this.mCanSeekForward = true;
            }
            if (VideoView.this.mOnPreparedListener != null) {
                VideoView.this.mOnPreparedListener.onPrepared(VideoView.this.mMediaPlayer);
            }
            if (VideoView.this.mMediaController != null) {
                VideoView.this.mMediaController.setEnabled(true);
            }
            VideoView.this.mVideoWidth = mp.getVideoWidth();
            VideoView.this.mVideoHeight = mp.getVideoHeight();
            int seekToPosition = VideoView.this.mSeekWhenPrepared;
            if (seekToPosition != 0) {
                VideoView.this.seekTo(seekToPosition);
            }
            if (VideoView.this.mVideoWidth != 0 && VideoView.this.mVideoHeight != 0) {
                VideoView.this.getHolder().setFixedSize(VideoView.this.mVideoWidth, VideoView.this.mVideoHeight);
                if (VideoView.this.mSurfaceWidth != VideoView.this.mVideoWidth || VideoView.this.mSurfaceHeight != VideoView.this.mVideoHeight) {
                    return;
                }
                if (VideoView.this.mTargetState == VideoView.STATE_PLAYING) {
                    VideoView.this.start();
                    if (VideoView.this.mMediaController != null) {
                        VideoView.this.mMediaController.show();
                    }
                } else if (!VideoView.this.isPlaying()) {
                    if ((seekToPosition != 0 || VideoView.this.getCurrentPosition() > 0) && VideoView.this.mMediaController != null) {
                        VideoView.this.mMediaController.show(VideoView.STATE_IDLE);
                    }
                }
            } else if (VideoView.this.mTargetState == VideoView.STATE_PLAYING) {
                VideoView.this.start();
            }
        }
    }

    /* renamed from: android.widget.VideoView.3 */
    class C10923 implements OnCompletionListener {
        C10923() {
        }

        public void onCompletion(MediaPlayer mp) {
            VideoView.this.mCurrentState = VideoView.STATE_PLAYBACK_COMPLETED;
            VideoView.this.mTargetState = VideoView.STATE_PLAYBACK_COMPLETED;
            if (VideoView.this.mMediaController != null) {
                VideoView.this.mMediaController.hide();
            }
            if (VideoView.this.mOnCompletionListener != null) {
                VideoView.this.mOnCompletionListener.onCompletion(VideoView.this.mMediaPlayer);
            }
        }
    }

    /* renamed from: android.widget.VideoView.4 */
    class C10934 implements OnInfoListener {
        C10934() {
        }

        public boolean onInfo(MediaPlayer mp, int arg1, int arg2) {
            if (VideoView.this.mOnInfoListener != null) {
                VideoView.this.mOnInfoListener.onInfo(mp, arg1, arg2);
            }
            return true;
        }
    }

    /* renamed from: android.widget.VideoView.5 */
    class C10955 implements OnErrorListener {

        /* renamed from: android.widget.VideoView.5.1 */
        class C10941 implements OnClickListener {
            C10941() {
            }

            public void onClick(DialogInterface dialog, int whichButton) {
                if (VideoView.this.mOnCompletionListener != null) {
                    VideoView.this.mOnCompletionListener.onCompletion(VideoView.this.mMediaPlayer);
                }
            }
        }

        C10955() {
        }

        public boolean onError(MediaPlayer mp, int framework_err, int impl_err) {
            Log.d(VideoView.this.TAG, "Error: " + framework_err + "," + impl_err);
            VideoView.this.mCurrentState = VideoView.STATE_ERROR;
            VideoView.this.mTargetState = VideoView.STATE_ERROR;
            if (VideoView.this.mMediaController != null) {
                VideoView.this.mMediaController.hide();
            }
            if ((VideoView.this.mOnErrorListener == null || !VideoView.this.mOnErrorListener.onError(VideoView.this.mMediaPlayer, framework_err, impl_err)) && VideoView.this.getWindowToken() != null) {
                int messageId;
                Resources r = VideoView.this.mContext.getResources();
                if (framework_err == KeyEvent.KEYCODE_BUTTON_13) {
                    messageId = C0000R.string.VideoView_error_text_invalid_progressive_playback;
                } else {
                    messageId = C0000R.string.VideoView_error_text_unknown;
                }
                new Builder(VideoView.this.mContext).setMessage(messageId).setPositiveButton(C0000R.string.VideoView_error_button, new C10941()).setCancelable(false).show();
            }
            return true;
        }
    }

    /* renamed from: android.widget.VideoView.6 */
    class C10966 implements OnBufferingUpdateListener {
        C10966() {
        }

        public void onBufferingUpdate(MediaPlayer mp, int percent) {
            VideoView.this.mCurrentBufferPercentage = percent;
        }
    }

    /* renamed from: android.widget.VideoView.7 */
    class C10977 implements Callback {
        C10977() {
        }

        public void surfaceChanged(SurfaceHolder holder, int format, int w, int h) {
            VideoView.this.mSurfaceWidth = w;
            VideoView.this.mSurfaceHeight = h;
            boolean isValidState;
            if (VideoView.this.mTargetState == VideoView.STATE_PLAYING) {
                isValidState = true;
            } else {
                isValidState = false;
            }
            boolean hasValidSize;
            if (VideoView.this.mVideoWidth == w && VideoView.this.mVideoHeight == h) {
                hasValidSize = true;
            } else {
                hasValidSize = false;
            }
            if (VideoView.this.mMediaPlayer != null && isValidState && hasValidSize) {
                if (VideoView.this.mSeekWhenPrepared != 0) {
                    VideoView.this.seekTo(VideoView.this.mSeekWhenPrepared);
                }
                VideoView.this.start();
            }
        }

        public void surfaceCreated(SurfaceHolder holder) {
            VideoView.this.mSurfaceHolder = holder;
            if (VideoView.this.mCurrentState == VideoView.STATE_SUSPENDED && VideoView.this.mMediaPlayer != null) {
                VideoView.this.mMediaPlayer.setDisplay(VideoView.this.mSurfaceHolder);
                if (VideoView.this.mMediaPlayer.resume()) {
                    VideoView.this.mCurrentState = VideoView.STATE_PREPARED;
                    if (VideoView.this.mSeekWhenPrepared != 0) {
                        VideoView.this.seekTo(VideoView.this.mSeekWhenPrepared);
                    }
                    if (VideoView.this.mTargetState == VideoView.STATE_PLAYING) {
                        VideoView.this.start();
                        return;
                    }
                    return;
                }
                VideoView.this.release(false);
            }
            VideoView.this.openVideo();
        }

        public void surfaceDestroyed(SurfaceHolder holder) {
            VideoView.this.mSurfaceHolder = null;
            if (VideoView.this.mMediaController != null) {
                VideoView.this.mMediaController.hide();
            }
            if (!VideoView.this.isHTTPStreaming(VideoView.this.mUri) || VideoView.this.mCurrentState != VideoView.STATE_SUSPENDED) {
                VideoView.this.release(true);
            }
        }
    }

    /* renamed from: android.widget.VideoView.8 */
    class C10988 implements OnChangedListener {
        C10988() {
        }

        public void onChanged(RenderingWidget renderingWidget) {
            VideoView.this.invalidate();
        }
    }

    public VideoView(Context context) {
        super(context);
        this.TAG = "VideoView";
        this.mCurrentState = STATE_IDLE;
        this.mTargetState = STATE_IDLE;
        this.mSurfaceHolder = null;
        this.mMediaPlayer = null;
        this.mSizeChangedListener = new C10901();
        this.mPreparedListener = new C10912();
        this.mCompletionListener = new C10923();
        this.mInfoListener = new C10934();
        this.mErrorListener = new C10955();
        this.mBufferingUpdateListener = new C10966();
        this.mSHCallback = new C10977();
        initVideoView();
    }

    public VideoView(Context context, AttributeSet attrs) {
        this(context, attrs, STATE_IDLE);
        initVideoView();
    }

    public VideoView(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, STATE_IDLE);
    }

    public VideoView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.TAG = "VideoView";
        this.mCurrentState = STATE_IDLE;
        this.mTargetState = STATE_IDLE;
        this.mSurfaceHolder = null;
        this.mMediaPlayer = null;
        this.mSizeChangedListener = new C10901();
        this.mPreparedListener = new C10912();
        this.mCompletionListener = new C10923();
        this.mInfoListener = new C10934();
        this.mErrorListener = new C10955();
        this.mBufferingUpdateListener = new C10966();
        this.mSHCallback = new C10977();
        initVideoView();
    }

    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int width = View.getDefaultSize(this.mVideoWidth, widthMeasureSpec);
        int height = View.getDefaultSize(this.mVideoHeight, heightMeasureSpec);
        if (this.mVideoWidth > 0 && this.mVideoHeight > 0) {
            int widthSpecMode = MeasureSpec.getMode(widthMeasureSpec);
            int widthSpecSize = MeasureSpec.getSize(widthMeasureSpec);
            int heightSpecMode = MeasureSpec.getMode(heightMeasureSpec);
            int heightSpecSize = MeasureSpec.getSize(heightMeasureSpec);
            if (widthSpecMode == EditorInfo.IME_FLAG_NO_ENTER_ACTION && heightSpecMode == EditorInfo.IME_FLAG_NO_ENTER_ACTION) {
                width = widthSpecSize;
                height = heightSpecSize;
                if (this.mVideoWidth * height < this.mVideoHeight * width) {
                    width = (this.mVideoWidth * height) / this.mVideoHeight;
                } else if (this.mVideoWidth * height > this.mVideoHeight * width) {
                    height = (this.mVideoHeight * width) / this.mVideoWidth;
                }
            } else if (widthSpecMode == EditorInfo.IME_FLAG_NO_ENTER_ACTION) {
                width = widthSpecSize;
                height = (this.mVideoHeight * width) / this.mVideoWidth;
                if (heightSpecMode == RtlSpacingHelper.UNDEFINED && height > heightSpecSize) {
                    height = heightSpecSize;
                }
            } else if (heightSpecMode == EditorInfo.IME_FLAG_NO_ENTER_ACTION) {
                height = heightSpecSize;
                width = (this.mVideoWidth * height) / this.mVideoHeight;
                if (widthSpecMode == RtlSpacingHelper.UNDEFINED && width > widthSpecSize) {
                    width = widthSpecSize;
                }
            } else {
                width = this.mVideoWidth;
                height = this.mVideoHeight;
                if (heightSpecMode == RtlSpacingHelper.UNDEFINED && height > heightSpecSize) {
                    height = heightSpecSize;
                    width = (this.mVideoWidth * height) / this.mVideoHeight;
                }
                if (widthSpecMode == RtlSpacingHelper.UNDEFINED && width > widthSpecSize) {
                    width = widthSpecSize;
                    height = (this.mVideoHeight * width) / this.mVideoWidth;
                }
            }
        }
        setMeasuredDimension(width, height);
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(VideoView.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(VideoView.class.getName());
    }

    public int resolveAdjustedSize(int desiredSize, int measureSpec) {
        return View.getDefaultSize(desiredSize, measureSpec);
    }

    private void initVideoView() {
        this.mVideoWidth = STATE_IDLE;
        this.mVideoHeight = STATE_IDLE;
        getHolder().addCallback(this.mSHCallback);
        getHolder().setType(STATE_PLAYING);
        setFocusable(true);
        setFocusableInTouchMode(true);
        requestFocus();
        this.mPendingSubtitleTracks = new Vector();
        this.mCurrentState = STATE_IDLE;
        this.mTargetState = STATE_IDLE;
    }

    public void setVideoPath(String path) {
        setVideoURI(Uri.parse(path));
    }

    public void setVideoURI(Uri uri) {
        setVideoURI(uri, null);
    }

    public void setVideoURI(Uri uri, Map<String, String> headers) {
        this.mUri = uri;
        this.mHeaders = headers;
        this.mSeekWhenPrepared = STATE_IDLE;
        openVideo();
        requestLayout();
        invalidate();
    }

    public void addSubtitleSource(InputStream is, MediaFormat format) {
        if (this.mMediaPlayer == null) {
            this.mPendingSubtitleTracks.add(Pair.create(is, format));
            return;
        }
        try {
            this.mMediaPlayer.addSubtitleSource(is, format);
        } catch (IllegalStateException e) {
            this.mInfoListener.onInfo(this.mMediaPlayer, MediaPlayer.MEDIA_INFO_UNSUPPORTED_SUBTITLE, STATE_IDLE);
        }
    }

    public void stopPlayback() {
        if (this.mMediaPlayer != null) {
            Log.i(this.TAG, "Playback Stop begin");
            this.mMediaPlayer.stop();
            this.mMediaPlayer.release();
            this.mMediaPlayer = null;
            this.mCurrentState = STATE_IDLE;
            this.mTargetState = STATE_IDLE;
            Log.i(this.TAG, "Playback Stop end");
        }
    }

    private void openVideo() {
        if (this.mUri != null && this.mSurfaceHolder != null) {
            Log.i(this.TAG, "Open Video");
            ((AudioManager) this.mContext.getSystemService(Context.AUDIO_SERVICE)).requestAudioFocus(null, STATE_PLAYING, STATE_PREPARING);
            release(false);
            try {
                this.mMediaPlayer = new MediaPlayer();
                Context context = getContext();
                SubtitleController controller = new SubtitleController(context, this.mMediaPlayer.getMediaTimeProvider(), this.mMediaPlayer);
                controller.registerRenderer(new WebVttRenderer(context));
                controller.registerRenderer(new TtmlRenderer(context));
                controller.registerRenderer(new ClosedCaptionRenderer(context));
                this.mMediaPlayer.setSubtitleAnchor(controller, this);
                if (this.mAudioSession != 0) {
                    this.mMediaPlayer.setAudioSessionId(this.mAudioSession);
                } else {
                    this.mAudioSession = this.mMediaPlayer.getAudioSessionId();
                }
                this.mMediaPlayer.setOnPreparedListener(this.mPreparedListener);
                this.mMediaPlayer.setOnVideoSizeChangedListener(this.mSizeChangedListener);
                this.mMediaPlayer.setOnCompletionListener(this.mCompletionListener);
                this.mMediaPlayer.setOnErrorListener(this.mErrorListener);
                this.mMediaPlayer.setOnInfoListener(this.mInfoListener);
                this.mMediaPlayer.setOnBufferingUpdateListener(this.mBufferingUpdateListener);
                this.mCurrentBufferPercentage = STATE_IDLE;
                Log.i(this.TAG, "SetDataSource");
                this.mMediaPlayer.setDataSource(this.mContext, this.mUri, this.mHeaders);
                this.mMediaPlayer.setDisplay(this.mSurfaceHolder);
                this.mMediaPlayer.setAudioStreamType(STATE_PLAYING);
                this.mMediaPlayer.setScreenOnWhilePlaying(true);
                this.mMediaPlayer.prepareAsync();
                Iterator i$ = this.mPendingSubtitleTracks.iterator();
                while (i$.hasNext()) {
                    Pair<InputStream, MediaFormat> pending = (Pair) i$.next();
                    try {
                        this.mMediaPlayer.addSubtitleSource((InputStream) pending.first, (MediaFormat) pending.second);
                    } catch (IllegalStateException e) {
                        this.mInfoListener.onInfo(this.mMediaPlayer, MediaPlayer.MEDIA_INFO_UNSUPPORTED_SUBTITLE, STATE_IDLE);
                    }
                }
                this.mCurrentState = STATE_PREPARING;
                attachMediaController();
            } catch (IOException ex) {
                Log.w(this.TAG, "Unable to open content: " + this.mUri, ex);
                this.mCurrentState = STATE_ERROR;
                this.mTargetState = STATE_ERROR;
                this.mErrorListener.onError(this.mMediaPlayer, STATE_PREPARING, STATE_IDLE);
            } catch (IllegalArgumentException ex2) {
                Log.w(this.TAG, "Unable to open content: " + this.mUri, ex2);
                this.mCurrentState = STATE_ERROR;
                this.mTargetState = STATE_ERROR;
                this.mErrorListener.onError(this.mMediaPlayer, STATE_PREPARING, STATE_IDLE);
            } finally {
                this.mPendingSubtitleTracks.clear();
            }
        }
    }

    public void setMediaController(MediaController controller) {
        if (this.mMediaController != null) {
            this.mMediaController.hide();
        }
        this.mMediaController = controller;
        attachMediaController();
    }

    private void attachMediaController() {
        if (this.mMediaPlayer != null && this.mMediaController != null) {
            this.mMediaController.setMediaPlayer(this);
            this.mMediaController.setAnchorView(getParent() instanceof View ? (View) getParent() : this);
            this.mMediaController.setEnabled(isInPlaybackState());
        }
    }

    private boolean isHTTPStreaming(Uri mUri) {
        if (mUri == null) {
            return false;
        }
        String scheme = mUri.getScheme();
        if (scheme == null) {
            return false;
        }
        if (!scheme.equals("http") && !scheme.equals("https")) {
            return false;
        }
        String path = mUri.getPath();
        if (path == null || path.endsWith(".m3u8") || path.endsWith(".m3u") || path.endsWith(".mpd")) {
            return false;
        }
        return true;
    }

    public void setOnPreparedListener(OnPreparedListener l) {
        this.mOnPreparedListener = l;
    }

    public void setOnCompletionListener(OnCompletionListener l) {
        this.mOnCompletionListener = l;
    }

    public void setOnErrorListener(OnErrorListener l) {
        this.mOnErrorListener = l;
    }

    public void setOnInfoListener(OnInfoListener l) {
        this.mOnInfoListener = l;
    }

    private void release(boolean cleartargetstate) {
        if (this.mMediaPlayer != null) {
            this.mMediaPlayer.reset();
            this.mMediaPlayer.release();
            this.mMediaPlayer = null;
            this.mPendingSubtitleTracks.clear();
            this.mCurrentState = STATE_IDLE;
            if (cleartargetstate) {
                this.mTargetState = STATE_IDLE;
            }
        }
    }

    public boolean onTouchEvent(MotionEvent ev) {
        if (isInPlaybackState() && this.mMediaController != null) {
            toggleMediaControlsVisiblity();
        }
        return false;
    }

    public boolean onTrackballEvent(MotionEvent ev) {
        if (isInPlaybackState() && this.mMediaController != null) {
            toggleMediaControlsVisiblity();
        }
        return false;
    }

    public boolean onKeyDown(int keyCode, KeyEvent event) {
        boolean isKeyCodeSupported = (keyCode == STATE_PAUSED || keyCode == 24 || keyCode == 25 || keyCode == KeyEvent.KEYCODE_VOLUME_MUTE || keyCode == 82 || keyCode == STATE_PLAYBACK_COMPLETED || keyCode == STATE_SUSPENDED) ? false : true;
        if (isInPlaybackState() && isKeyCodeSupported && this.mMediaController != null) {
            if (keyCode == 79 || keyCode == 85) {
                if (this.mMediaPlayer.isPlaying()) {
                    pause();
                    this.mMediaController.show();
                    return true;
                }
                start();
                this.mMediaController.hide();
                return true;
            } else if (keyCode == KeyEvent.KEYCODE_MEDIA_PLAY) {
                if (this.mMediaPlayer.isPlaying()) {
                    return true;
                }
                start();
                this.mMediaController.hide();
                return true;
            } else if (keyCode != 86 && keyCode != KeyEvent.KEYCODE_MEDIA_PAUSE) {
                toggleMediaControlsVisiblity();
            } else if (!this.mMediaPlayer.isPlaying()) {
                return true;
            } else {
                pause();
                this.mMediaController.show();
                return true;
            }
        }
        return super.onKeyDown(keyCode, event);
    }

    private void toggleMediaControlsVisiblity() {
        if (this.mMediaController.isShowing()) {
            this.mMediaController.hide();
        } else {
            this.mMediaController.show();
        }
    }

    public void start() {
        if (isInPlaybackState()) {
            Log.i(this.TAG, "Playback Start begin");
            this.mMediaPlayer.start();
            this.mCurrentState = STATE_PLAYING;
            Log.i(this.TAG, "Playback Start end");
        }
        this.mTargetState = STATE_PLAYING;
    }

    public void pause() {
        if (isInPlaybackState() && this.mMediaPlayer.isPlaying()) {
            this.mMediaPlayer.pause();
            this.mCurrentState = STATE_PAUSED;
        }
        this.mTargetState = STATE_PAUSED;
    }

    public void suspend() {
        Log.i(this.TAG, "Playback Suspend begin");
        if (!isHTTPStreaming(this.mUri) || this.mCurrentState <= STATE_PREPARING || this.mCurrentState >= STATE_PLAYBACK_COMPLETED || this.mMediaPlayer == null || !this.mMediaPlayer.suspend()) {
            release(false);
            Log.i(this.TAG, "Playback Suspend end");
            return;
        }
        this.mTargetState = this.mCurrentState;
        this.mCurrentState = STATE_SUSPENDED;
    }

    public void resume() {
        if (this.mCurrentState == STATE_SUSPENDED && this.mMediaPlayer != null) {
            if (this.mSurfaceHolder == null) {
                return;
            }
            if (this.mMediaPlayer.resume()) {
                this.mCurrentState = STATE_PREPARED;
                if (this.mSeekWhenPrepared != 0) {
                    seekTo(this.mSeekWhenPrepared);
                }
                if (this.mTargetState == STATE_PLAYING) {
                    start();
                    return;
                }
                return;
            }
            release(false);
        }
        openVideo();
    }

    public int getDuration() {
        if (isInPlaybackState()) {
            return this.mMediaPlayer.getDuration();
        }
        return STATE_ERROR;
    }

    public int getCurrentPosition() {
        if (isInPlaybackState()) {
            return this.mMediaPlayer.getCurrentPosition();
        }
        return STATE_IDLE;
    }

    public void seekTo(int msec) {
        if (isInPlaybackState()) {
            this.mMediaPlayer.seekTo(msec);
            this.mSeekWhenPrepared = STATE_IDLE;
            return;
        }
        this.mSeekWhenPrepared = msec;
    }

    public boolean isPlaying() {
        return isInPlaybackState() && this.mMediaPlayer.isPlaying();
    }

    public int getBufferPercentage() {
        if (this.mMediaPlayer != null) {
            return this.mCurrentBufferPercentage;
        }
        return STATE_IDLE;
    }

    private boolean isInPlaybackState() {
        return (this.mMediaPlayer == null || this.mCurrentState == STATE_ERROR || this.mCurrentState == 0 || this.mCurrentState == STATE_PREPARING || this.mCurrentState == STATE_SUSPENDED) ? false : true;
    }

    public boolean canPause() {
        return this.mCanPause;
    }

    public boolean canSeekBackward() {
        return this.mCanSeekBack;
    }

    public boolean canSeekForward() {
        return this.mCanSeekForward;
    }

    public int getAudioSessionId() {
        if (this.mAudioSession == 0) {
            MediaPlayer foo = new MediaPlayer();
            this.mAudioSession = foo.getAudioSessionId();
            foo.release();
        }
        return this.mAudioSession;
    }

    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        if (this.mSubtitleWidget != null) {
            this.mSubtitleWidget.onAttachedToWindow();
        }
    }

    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        if (this.mSubtitleWidget != null) {
            this.mSubtitleWidget.onDetachedFromWindow();
        }
    }

    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        if (this.mSubtitleWidget != null) {
            measureAndLayoutSubtitleWidget();
        }
    }

    public void draw(Canvas canvas) {
        super.draw(canvas);
        if (this.mSubtitleWidget != null) {
            int saveCount = canvas.save();
            canvas.translate((float) getPaddingLeft(), (float) getPaddingTop());
            this.mSubtitleWidget.draw(canvas);
            canvas.restoreToCount(saveCount);
        }
    }

    private void measureAndLayoutSubtitleWidget() {
        this.mSubtitleWidget.setSize((getWidth() - getPaddingLeft()) - getPaddingRight(), (getHeight() - getPaddingTop()) - getPaddingBottom());
    }

    public void setSubtitleWidget(RenderingWidget subtitleWidget) {
        if (this.mSubtitleWidget != subtitleWidget) {
            boolean attachedToWindow = isAttachedToWindow();
            if (this.mSubtitleWidget != null) {
                if (attachedToWindow) {
                    this.mSubtitleWidget.onDetachedFromWindow();
                }
                this.mSubtitleWidget.setOnChangedListener(null);
            }
            this.mSubtitleWidget = subtitleWidget;
            if (subtitleWidget != null) {
                if (this.mSubtitlesChangedListener == null) {
                    this.mSubtitlesChangedListener = new C10988();
                }
                setWillNotDraw(false);
                subtitleWidget.setOnChangedListener(this.mSubtitlesChangedListener);
                if (attachedToWindow) {
                    subtitleWidget.onAttachedToWindow();
                    requestLayout();
                }
            } else {
                setWillNotDraw(true);
            }
            invalidate();
        }
    }

    public Looper getSubtitleLooper() {
        return Looper.getMainLooper();
    }
}
