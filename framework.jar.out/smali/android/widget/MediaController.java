package android.widget;

import android.C0000R;
import android.content.Context;
import android.content.res.Resources;
import android.os.Handler;
import android.os.Message;
import android.util.AttributeSet;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.MeasureSpec;
import android.view.View.OnClickListener;
import android.view.View.OnLayoutChangeListener;
import android.view.View.OnTouchListener;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.SeekBar.OnSeekBarChangeListener;
import com.android.internal.policy.PolicyManager;
import java.util.Formatter;
import java.util.Locale;

public class MediaController extends FrameLayout {
    private static final int FADE_OUT = 1;
    private static final int SHOW_PROGRESS = 2;
    private static final int sDefaultTimeout = 3000;
    private View mAnchor;
    private Context mContext;
    private TextView mCurrentTime;
    private View mDecor;
    private LayoutParams mDecorLayoutParams;
    private boolean mDragging;
    private TextView mEndTime;
    private ImageButton mFfwdButton;
    private OnClickListener mFfwdListener;
    StringBuilder mFormatBuilder;
    Formatter mFormatter;
    private boolean mFromXml;
    private Handler mHandler;
    private OnLayoutChangeListener mLayoutChangeListener;
    private boolean mListenersSet;
    private ImageButton mNextButton;
    private OnClickListener mNextListener;
    private ImageButton mPauseButton;
    private CharSequence mPauseDescription;
    private OnClickListener mPauseListener;
    private CharSequence mPlayDescription;
    private MediaPlayerControl mPlayer;
    private ImageButton mPrevButton;
    private OnClickListener mPrevListener;
    private ProgressBar mProgress;
    private ImageButton mRewButton;
    private OnClickListener mRewListener;
    private View mRoot;
    private OnSeekBarChangeListener mSeekListener;
    private boolean mShowing;
    private OnTouchListener mTouchListener;
    private boolean mUseFastForward;
    private Window mWindow;
    private WindowManager mWindowManager;

    /* renamed from: android.widget.MediaController.1 */
    class C10021 implements OnLayoutChangeListener {
        C10021() {
        }

        public void onLayoutChange(View v, int left, int top, int right, int bottom, int oldLeft, int oldTop, int oldRight, int oldBottom) {
            MediaController.this.updateFloatingWindowLayout();
            if (MediaController.this.mShowing) {
                MediaController.this.mWindowManager.updateViewLayout(MediaController.this.mDecor, MediaController.this.mDecorLayoutParams);
            }
        }
    }

    /* renamed from: android.widget.MediaController.2 */
    class C10032 implements OnTouchListener {
        C10032() {
        }

        public boolean onTouch(View v, MotionEvent event) {
            if (event.getAction() == 0 && MediaController.this.mShowing) {
                MediaController.this.hide();
            }
            return false;
        }
    }

    /* renamed from: android.widget.MediaController.3 */
    class C10043 extends Handler {
        C10043() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case MediaController.FADE_OUT /*1*/:
                    MediaController.this.hide();
                case MediaController.SHOW_PROGRESS /*2*/:
                    int pos = MediaController.this.setProgress();
                    if (!MediaController.this.mDragging && MediaController.this.mShowing && MediaController.this.mPlayer.isPlaying()) {
                        sendMessageDelayed(obtainMessage(MediaController.SHOW_PROGRESS), (long) (1000 - (pos % LayoutParams.TYPE_APPLICATION_PANEL)));
                    }
                default:
            }
        }
    }

    /* renamed from: android.widget.MediaController.4 */
    class C10054 implements OnClickListener {
        C10054() {
        }

        public void onClick(View v) {
            MediaController.this.doPauseResume();
            MediaController.this.show(MediaController.sDefaultTimeout);
        }
    }

    /* renamed from: android.widget.MediaController.5 */
    class C10065 implements OnSeekBarChangeListener {
        C10065() {
        }

        public void onStartTrackingTouch(SeekBar bar) {
            MediaController.this.show(3600000);
            MediaController.this.mDragging = true;
            MediaController.this.mHandler.removeMessages(MediaController.SHOW_PROGRESS);
        }

        public void onProgressChanged(SeekBar bar, int progress, boolean fromuser) {
            if (fromuser) {
                long newposition = (((long) progress) * ((long) MediaController.this.mPlayer.getDuration())) / 1000;
                MediaController.this.mPlayer.seekTo((int) newposition);
                if (MediaController.this.mCurrentTime != null) {
                    MediaController.this.mCurrentTime.setText(MediaController.this.stringForTime((int) newposition));
                }
            }
        }

        public void onStopTrackingTouch(SeekBar bar) {
            MediaController.this.mDragging = false;
            MediaController.this.setProgress();
            MediaController.this.updatePausePlay();
            MediaController.this.show(MediaController.sDefaultTimeout);
            MediaController.this.mHandler.sendEmptyMessage(MediaController.SHOW_PROGRESS);
        }
    }

    /* renamed from: android.widget.MediaController.6 */
    class C10076 implements OnClickListener {
        C10076() {
        }

        public void onClick(View v) {
            MediaController.this.mPlayer.seekTo(MediaController.this.mPlayer.getCurrentPosition() - 5000);
            MediaController.this.setProgress();
            MediaController.this.show(MediaController.sDefaultTimeout);
        }
    }

    /* renamed from: android.widget.MediaController.7 */
    class C10087 implements OnClickListener {
        C10087() {
        }

        public void onClick(View v) {
            MediaController.this.mPlayer.seekTo(MediaController.this.mPlayer.getCurrentPosition() + 15000);
            MediaController.this.setProgress();
            MediaController.this.show(MediaController.sDefaultTimeout);
        }
    }

    public interface MediaPlayerControl {
        boolean canPause();

        boolean canSeekBackward();

        boolean canSeekForward();

        int getAudioSessionId();

        int getBufferPercentage();

        int getCurrentPosition();

        int getDuration();

        boolean isPlaying();

        void pause();

        void seekTo(int i);

        void start();
    }

    public MediaController(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.mLayoutChangeListener = new C10021();
        this.mTouchListener = new C10032();
        this.mHandler = new C10043();
        this.mPauseListener = new C10054();
        this.mSeekListener = new C10065();
        this.mRewListener = new C10076();
        this.mFfwdListener = new C10087();
        this.mRoot = this;
        this.mContext = context;
        this.mUseFastForward = true;
        this.mFromXml = true;
    }

    public void onFinishInflate() {
        if (this.mRoot != null) {
            initControllerView(this.mRoot);
        }
    }

    public MediaController(Context context, boolean useFastForward) {
        super(context);
        this.mLayoutChangeListener = new C10021();
        this.mTouchListener = new C10032();
        this.mHandler = new C10043();
        this.mPauseListener = new C10054();
        this.mSeekListener = new C10065();
        this.mRewListener = new C10076();
        this.mFfwdListener = new C10087();
        this.mContext = context;
        this.mUseFastForward = useFastForward;
        initFloatingWindowLayout();
        initFloatingWindow();
    }

    public MediaController(Context context) {
        this(context, true);
    }

    private void initFloatingWindow() {
        this.mWindowManager = (WindowManager) this.mContext.getSystemService(Context.WINDOW_SERVICE);
        this.mWindow = PolicyManager.makeNewWindow(this.mContext);
        this.mWindow.setWindowManager(this.mWindowManager, null, null);
        this.mWindow.requestFeature(FADE_OUT);
        this.mDecor = this.mWindow.getDecorView();
        this.mDecor.setOnTouchListener(this.mTouchListener);
        this.mWindow.setContentView((View) this);
        this.mWindow.setBackgroundDrawableResource(C0000R.color.transparent);
        this.mWindow.setVolumeControlStream(3);
        setFocusable(true);
        setFocusableInTouchMode(true);
        setDescendantFocusability(AccessibilityNodeInfo.ACTION_EXPAND);
        requestFocus();
    }

    private void initFloatingWindowLayout() {
        this.mDecorLayoutParams = new LayoutParams();
        LayoutParams p = this.mDecorLayoutParams;
        p.gravity = 51;
        p.height = -2;
        p.f95x = 0;
        p.format = -3;
        p.type = LayoutParams.TYPE_APPLICATION_PANEL;
        p.flags |= 8519712;
        p.token = null;
        p.windowAnimations = 0;
    }

    private void updateFloatingWindowLayout() {
        int[] anchorPos = new int[SHOW_PROGRESS];
        this.mAnchor.getLocationOnScreen(anchorPos);
        this.mDecor.measure(MeasureSpec.makeMeasureSpec(this.mAnchor.getWidth(), RtlSpacingHelper.UNDEFINED), MeasureSpec.makeMeasureSpec(this.mAnchor.getHeight(), RtlSpacingHelper.UNDEFINED));
        LayoutParams p = this.mDecorLayoutParams;
        p.width = this.mAnchor.getWidth();
        p.f95x = anchorPos[0] + ((this.mAnchor.getWidth() - p.width) / SHOW_PROGRESS);
        p.f96y = (anchorPos[FADE_OUT] + this.mAnchor.getHeight()) - this.mDecor.getMeasuredHeight();
    }

    public void setMediaPlayer(MediaPlayerControl player) {
        this.mPlayer = player;
        updatePausePlay();
    }

    public void setAnchorView(View view) {
        if (this.mAnchor != null) {
            this.mAnchor.removeOnLayoutChangeListener(this.mLayoutChangeListener);
        }
        this.mAnchor = view;
        if (this.mAnchor != null) {
            this.mAnchor.addOnLayoutChangeListener(this.mLayoutChangeListener);
        }
        FrameLayout.LayoutParams frameParams = new FrameLayout.LayoutParams(-1, -1);
        removeAllViews();
        addView(makeControllerView(), (ViewGroup.LayoutParams) frameParams);
    }

    protected View makeControllerView() {
        this.mRoot = ((LayoutInflater) this.mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(17367147, null);
        initControllerView(this.mRoot);
        return this.mRoot;
    }

    private void initControllerView(View v) {
        int i = 0;
        Resources res = this.mContext.getResources();
        this.mPlayDescription = res.getText(17040290);
        this.mPauseDescription = res.getText(17040289);
        this.mPauseButton = (ImageButton) v.findViewById(16909089);
        if (this.mPauseButton != null) {
            this.mPauseButton.requestFocus();
            this.mPauseButton.setOnClickListener(this.mPauseListener);
        }
        this.mFfwdButton = (ImageButton) v.findViewById(16909090);
        if (this.mFfwdButton != null) {
            this.mFfwdButton.setOnClickListener(this.mFfwdListener);
            if (!this.mFromXml) {
                this.mFfwdButton.setVisibility(this.mUseFastForward ? 0 : 8);
            }
        }
        this.mRewButton = (ImageButton) v.findViewById(16909088);
        if (this.mRewButton != null) {
            this.mRewButton.setOnClickListener(this.mRewListener);
            if (!this.mFromXml) {
                ImageButton imageButton = this.mRewButton;
                if (!this.mUseFastForward) {
                    i = 8;
                }
                imageButton.setVisibility(i);
            }
        }
        this.mNextButton = (ImageButton) v.findViewById(16909091);
        if (!(this.mNextButton == null || this.mFromXml || this.mListenersSet)) {
            this.mNextButton.setVisibility(8);
        }
        this.mPrevButton = (ImageButton) v.findViewById(16909087);
        if (!(this.mPrevButton == null || this.mFromXml || this.mListenersSet)) {
            this.mPrevButton.setVisibility(8);
        }
        this.mProgress = (ProgressBar) v.findViewById(16909093);
        if (this.mProgress != null) {
            if (this.mProgress instanceof SeekBar) {
                this.mProgress.setOnSeekBarChangeListener(this.mSeekListener);
            }
            this.mProgress.setMax(LayoutParams.TYPE_APPLICATION_PANEL);
        }
        this.mEndTime = (TextView) v.findViewById(16908415);
        this.mCurrentTime = (TextView) v.findViewById(16909092);
        this.mFormatBuilder = new StringBuilder();
        this.mFormatter = new Formatter(this.mFormatBuilder, Locale.getDefault());
        installPrevNextListeners();
    }

    public void show() {
        show(sDefaultTimeout);
    }

    private void disableUnsupportedButtons() {
        try {
            if (!(this.mPauseButton == null || this.mPlayer.canPause())) {
                this.mPauseButton.setEnabled(false);
            }
            if (!(this.mRewButton == null || this.mPlayer.canSeekBackward())) {
                this.mRewButton.setEnabled(false);
            }
            if (this.mFfwdButton != null && !this.mPlayer.canSeekForward()) {
                this.mFfwdButton.setEnabled(false);
            }
        } catch (IncompatibleClassChangeError e) {
        }
    }

    public void show(int timeout) {
        if (!(this.mShowing || this.mAnchor == null)) {
            setProgress();
            if (this.mPauseButton != null) {
                this.mPauseButton.requestFocus();
            }
            disableUnsupportedButtons();
            updateFloatingWindowLayout();
            this.mWindowManager.addView(this.mDecor, this.mDecorLayoutParams);
            this.mShowing = true;
        }
        updatePausePlay();
        this.mHandler.sendEmptyMessage(SHOW_PROGRESS);
        Message msg = this.mHandler.obtainMessage(FADE_OUT);
        if (timeout != 0) {
            this.mHandler.removeMessages(FADE_OUT);
            this.mHandler.sendMessageDelayed(msg, (long) timeout);
        }
    }

    public boolean isShowing() {
        return this.mShowing;
    }

    public void hide() {
        if (this.mAnchor != null && this.mShowing) {
            try {
                this.mHandler.removeMessages(SHOW_PROGRESS);
                this.mWindowManager.removeView(this.mDecor);
            } catch (IllegalArgumentException e) {
                Log.w("MediaController", "already removed");
            }
            this.mShowing = false;
        }
    }

    private String stringForTime(int timeMs) {
        int totalSeconds = timeMs / LayoutParams.TYPE_APPLICATION_PANEL;
        int seconds = totalSeconds % 60;
        int minutes = (totalSeconds / 60) % 60;
        int hours = totalSeconds / 3600;
        this.mFormatBuilder.setLength(0);
        if (hours > 0) {
            return this.mFormatter.format("%d:%02d:%02d", new Object[]{Integer.valueOf(hours), Integer.valueOf(minutes), Integer.valueOf(seconds)}).toString();
        }
        Object[] objArr = new Object[SHOW_PROGRESS];
        objArr[0] = Integer.valueOf(minutes);
        objArr[FADE_OUT] = Integer.valueOf(seconds);
        return this.mFormatter.format("%02d:%02d", objArr).toString();
    }

    private int setProgress() {
        if (this.mPlayer == null || this.mDragging) {
            return 0;
        }
        int position = this.mPlayer.getCurrentPosition();
        int duration = this.mPlayer.getDuration();
        if (this.mProgress != null) {
            if (duration > 0) {
                this.mProgress.setProgress((int) ((1000 * ((long) position)) / ((long) duration)));
            }
            this.mProgress.setSecondaryProgress(this.mPlayer.getBufferPercentage() * 10);
        }
        if (this.mEndTime != null) {
            this.mEndTime.setText(stringForTime(duration));
        }
        if (this.mCurrentTime == null) {
            return position;
        }
        this.mCurrentTime.setText(stringForTime(position));
        return position;
    }

    public boolean onTouchEvent(MotionEvent event) {
        switch (event.getAction()) {
            case Toast.LENGTH_SHORT /*0*/:
                show(0);
                break;
            case FADE_OUT /*1*/:
                show(sDefaultTimeout);
                break;
            case SetDrawableParameters.TAG /*3*/:
                hide();
                break;
        }
        return true;
    }

    public boolean onTrackballEvent(MotionEvent ev) {
        show(sDefaultTimeout);
        return false;
    }

    public boolean dispatchKeyEvent(KeyEvent event) {
        int keyCode = event.getKeyCode();
        boolean uniqueDown = event.getRepeatCount() == 0 && event.getAction() == 0;
        if (keyCode == 79 || keyCode == 85 || keyCode == 62) {
            if (!uniqueDown) {
                return true;
            }
            doPauseResume();
            show(sDefaultTimeout);
            if (this.mPauseButton == null) {
                return true;
            }
            this.mPauseButton.requestFocus();
            return true;
        } else if (keyCode == KeyEvent.KEYCODE_MEDIA_PLAY) {
            if (!uniqueDown || this.mPlayer.isPlaying()) {
                return true;
            }
            this.mPlayer.start();
            updatePausePlay();
            show(sDefaultTimeout);
            return true;
        } else if (keyCode == 86 || keyCode == KeyEvent.KEYCODE_MEDIA_PAUSE) {
            if (!uniqueDown || !this.mPlayer.isPlaying()) {
                return true;
            }
            this.mPlayer.pause();
            updatePausePlay();
            show(sDefaultTimeout);
            return true;
        } else if (keyCode == 25 || keyCode == 24 || keyCode == KeyEvent.KEYCODE_VOLUME_MUTE || keyCode == 27) {
            return super.dispatchKeyEvent(event);
        } else {
            if (keyCode != 4 && keyCode != 82) {
                show(sDefaultTimeout);
                return super.dispatchKeyEvent(event);
            } else if (!uniqueDown) {
                return true;
            } else {
                hide();
                return true;
            }
        }
    }

    private void updatePausePlay() {
        if (this.mRoot != null && this.mPauseButton != null) {
            if (this.mPlayer.isPlaying()) {
                this.mPauseButton.setImageResource(C0000R.drawable.ic_media_pause);
                this.mPauseButton.setContentDescription(this.mPauseDescription);
                return;
            }
            this.mPauseButton.setImageResource(C0000R.drawable.ic_media_play);
            this.mPauseButton.setContentDescription(this.mPlayDescription);
        }
    }

    private void doPauseResume() {
        if (this.mPlayer.isPlaying()) {
            this.mPlayer.pause();
        } else {
            this.mPlayer.start();
        }
        updatePausePlay();
    }

    public void setEnabled(boolean enabled) {
        boolean z = true;
        if (this.mPauseButton != null) {
            this.mPauseButton.setEnabled(enabled);
        }
        if (this.mFfwdButton != null) {
            this.mFfwdButton.setEnabled(enabled);
        }
        if (this.mRewButton != null) {
            this.mRewButton.setEnabled(enabled);
        }
        if (this.mNextButton != null) {
            ImageButton imageButton = this.mNextButton;
            boolean z2 = enabled && this.mNextListener != null;
            imageButton.setEnabled(z2);
        }
        if (this.mPrevButton != null) {
            ImageButton imageButton2 = this.mPrevButton;
            if (!enabled || this.mPrevListener == null) {
                z = false;
            }
            imageButton2.setEnabled(z);
        }
        if (this.mProgress != null) {
            this.mProgress.setEnabled(enabled);
        }
        disableUnsupportedButtons();
        super.setEnabled(enabled);
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(MediaController.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(MediaController.class.getName());
    }

    private void installPrevNextListeners() {
        boolean z = true;
        if (this.mNextButton != null) {
            this.mNextButton.setOnClickListener(this.mNextListener);
            this.mNextButton.setEnabled(this.mNextListener != null);
        }
        if (this.mPrevButton != null) {
            this.mPrevButton.setOnClickListener(this.mPrevListener);
            ImageButton imageButton = this.mPrevButton;
            if (this.mPrevListener == null) {
                z = false;
            }
            imageButton.setEnabled(z);
        }
    }

    public void setPrevNextListeners(OnClickListener next, OnClickListener prev) {
        this.mNextListener = next;
        this.mPrevListener = prev;
        this.mListenersSet = true;
        if (this.mRoot != null) {
            installPrevNextListeners();
            if (!(this.mNextButton == null || this.mFromXml)) {
                this.mNextButton.setVisibility(0);
            }
            if (this.mPrevButton != null && !this.mFromXml) {
                this.mPrevButton.setVisibility(0);
            }
        }
    }
}
