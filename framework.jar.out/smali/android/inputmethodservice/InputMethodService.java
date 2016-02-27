package android.inputmethodservice;

import android.C0000R;
import android.app.ActivityManager;
import android.app.Dialog;
import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Rect;
import android.graphics.Region;
import android.inputmethodservice.AbstractInputMethodService.AbstractInputMethodImpl;
import android.inputmethodservice.AbstractInputMethodService.AbstractInputMethodSessionImpl;
import android.net.ProxyInfo;
import android.opengl.GLES20;
import android.os.Bundle;
import android.os.IBinder;
import android.os.ResultReceiver;
import android.os.SystemClock;
import android.provider.Settings.Global;
import android.text.Layout;
import android.text.Spannable;
import android.text.method.MovementMethod;
import android.util.Log;
import android.util.PrintWriterPrinter;
import android.util.Printer;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.ViewTreeObserver.InternalInsetsInfo;
import android.view.ViewTreeObserver.OnComputeInternalInsetsListener;
import android.view.Window;
import android.view.WindowManager;
import android.view.WindowManager.BadTokenException;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManagerPolicy;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.animation.AnimationUtils;
import android.view.inputmethod.CompletionInfo;
import android.view.inputmethod.CursorAnchorInfo;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.ExtractedText;
import android.view.inputmethod.ExtractedTextRequest;
import android.view.inputmethod.InputBinding;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.InputMethodManager;
import android.view.inputmethod.InputMethodSubtype;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.SpellChecker;
import java.io.FileDescriptor;
import java.io.PrintWriter;

public class InputMethodService extends AbstractInputMethodService {
    public static final int BACK_DISPOSITION_DEFAULT = 0;
    public static final int BACK_DISPOSITION_WILL_DISMISS = 2;
    public static final int BACK_DISPOSITION_WILL_NOT_DISMISS = 1;
    static final boolean DEBUG = false;
    public static final int IME_ACTIVE = 1;
    public static final int IME_VISIBLE = 2;
    static final int MOVEMENT_DOWN = -1;
    static final int MOVEMENT_UP = -2;
    static final String TAG = "InputMethodService";
    final OnClickListener mActionClickListener;
    int mBackDisposition;
    FrameLayout mCandidatesFrame;
    boolean mCandidatesViewStarted;
    int mCandidatesVisibility;
    CompletionInfo[] mCurCompletions;
    ViewGroup mExtractAccessories;
    Button mExtractAction;
    ExtractEditText mExtractEditText;
    FrameLayout mExtractFrame;
    View mExtractView;
    boolean mExtractViewHidden;
    ExtractedText mExtractedText;
    int mExtractedToken;
    boolean mFullscreenApplied;
    ViewGroup mFullscreenArea;
    boolean mHardwareAccelerated;
    InputMethodManager mImm;
    boolean mInShowWindow;
    LayoutInflater mInflater;
    boolean mInitialized;
    InputBinding mInputBinding;
    InputConnection mInputConnection;
    EditorInfo mInputEditorInfo;
    FrameLayout mInputFrame;
    boolean mInputStarted;
    View mInputView;
    boolean mInputViewStarted;
    final OnComputeInternalInsetsListener mInsetsComputer;
    boolean mIsFullscreen;
    boolean mIsInputViewShown;
    boolean mLastShowInputRequested;
    View mRootView;
    int mShowInputFlags;
    boolean mShowInputForced;
    boolean mShowInputRequested;
    InputConnection mStartedInputConnection;
    int mStatusIcon;
    int mTheme;
    TypedArray mThemeAttrs;
    final Insets mTmpInsets;
    final int[] mTmpLocation;
    IBinder mToken;
    SoftInputWindow mWindow;
    boolean mWindowAdded;
    boolean mWindowCreated;
    boolean mWindowVisible;
    boolean mWindowWasVisible;

    /* renamed from: android.inputmethodservice.InputMethodService.1 */
    class C03221 implements OnComputeInternalInsetsListener {
        C03221() {
        }

        public void onComputeInternalInsets(InternalInsetsInfo info) {
            if (InputMethodService.this.isExtractViewShown()) {
                View decor = InputMethodService.this.getWindow().getWindow().getDecorView();
                Rect rect = info.contentInsets;
                Rect rect2 = info.visibleInsets;
                int height = decor.getHeight();
                rect2.top = height;
                rect.top = height;
                info.touchableRegion.setEmpty();
                info.setTouchableInsets(InputMethodService.BACK_DISPOSITION_DEFAULT);
                return;
            }
            InputMethodService.this.onComputeInsets(InputMethodService.this.mTmpInsets);
            info.contentInsets.top = InputMethodService.this.mTmpInsets.contentTopInsets;
            info.visibleInsets.top = InputMethodService.this.mTmpInsets.visibleTopInsets;
            info.touchableRegion.set(InputMethodService.this.mTmpInsets.touchableRegion);
            info.setTouchableInsets(InputMethodService.this.mTmpInsets.touchableInsets);
        }
    }

    /* renamed from: android.inputmethodservice.InputMethodService.2 */
    class C03232 implements OnClickListener {
        C03232() {
        }

        public void onClick(View v) {
            EditorInfo ei = InputMethodService.this.getCurrentInputEditorInfo();
            InputConnection ic = InputMethodService.this.getCurrentInputConnection();
            if (ei != null && ic != null) {
                if (ei.actionId != 0) {
                    ic.performEditorAction(ei.actionId);
                } else if ((ei.imeOptions & EditorInfo.IME_MASK_ACTION) != InputMethodService.IME_ACTIVE) {
                    ic.performEditorAction(ei.imeOptions & EditorInfo.IME_MASK_ACTION);
                }
            }
        }
    }

    public class InputMethodImpl extends AbstractInputMethodImpl {
        public InputMethodImpl() {
            super();
        }

        public void attachToken(IBinder token) {
            if (InputMethodService.this.mToken == null) {
                InputMethodService.this.mToken = token;
                InputMethodService.this.mWindow.setToken(token);
            }
        }

        public void bindInput(InputBinding binding) {
            InputMethodService.this.mInputBinding = binding;
            InputMethodService.this.mInputConnection = binding.getConnection();
            InputConnection ic = InputMethodService.this.getCurrentInputConnection();
            if (ic != null) {
                ic.reportFullscreenMode(InputMethodService.this.mIsFullscreen);
            }
            InputMethodService.this.initialize();
            InputMethodService.this.onBindInput();
        }

        public void unbindInput() {
            InputMethodService.this.onUnbindInput();
            InputMethodService.this.mInputBinding = null;
            InputMethodService.this.mInputConnection = null;
        }

        public void startInput(InputConnection ic, EditorInfo attribute) {
            InputMethodService.this.doStartInput(ic, attribute, InputMethodService.DEBUG);
        }

        public void restartInput(InputConnection ic, EditorInfo attribute) {
            InputMethodService.this.doStartInput(ic, attribute, true);
        }

        public void hideSoftInput(int flags, ResultReceiver resultReceiver) {
            int i = InputMethodService.BACK_DISPOSITION_DEFAULT;
            boolean wasVis = InputMethodService.this.isInputViewShown();
            InputMethodService.this.mShowInputFlags = InputMethodService.BACK_DISPOSITION_DEFAULT;
            InputMethodService.this.mShowInputRequested = InputMethodService.DEBUG;
            InputMethodService.this.mShowInputForced = InputMethodService.DEBUG;
            InputMethodService.this.doHideWindow();
            if (resultReceiver != null) {
                if (wasVis != InputMethodService.this.isInputViewShown()) {
                    i = 3;
                } else if (!wasVis) {
                    i = InputMethodService.IME_ACTIVE;
                }
                resultReceiver.send(i, null);
            }
        }

        public void showSoftInput(int flags, ResultReceiver resultReceiver) {
            int i;
            int i2 = InputMethodService.IME_VISIBLE;
            boolean wasVis = InputMethodService.this.isInputViewShown();
            InputMethodService.this.mShowInputFlags = InputMethodService.BACK_DISPOSITION_DEFAULT;
            if (InputMethodService.this.onShowInputRequested(flags, InputMethodService.DEBUG)) {
                try {
                    InputMethodService.this.showWindow(true);
                } catch (BadTokenException e) {
                    InputMethodService.this.mWindowVisible = InputMethodService.DEBUG;
                    InputMethodService.this.mWindowAdded = InputMethodService.DEBUG;
                }
            }
            boolean showing = InputMethodService.this.isInputViewShown();
            InputMethodManager inputMethodManager = InputMethodService.this.mImm;
            IBinder iBinder = InputMethodService.this.mToken;
            if (showing) {
                i = InputMethodService.IME_VISIBLE;
            } else {
                i = InputMethodService.BACK_DISPOSITION_DEFAULT;
            }
            inputMethodManager.setImeWindowStatus(iBinder, i | InputMethodService.IME_ACTIVE, InputMethodService.this.mBackDisposition);
            if (resultReceiver != null) {
                if (wasVis == InputMethodService.this.isInputViewShown()) {
                    i2 = wasVis ? InputMethodService.BACK_DISPOSITION_DEFAULT : InputMethodService.IME_ACTIVE;
                }
                resultReceiver.send(i2, null);
            }
        }

        public void changeInputMethodSubtype(InputMethodSubtype subtype) {
            InputMethodService.this.onCurrentInputMethodSubtypeChanged(subtype);
        }
    }

    public class InputMethodSessionImpl extends AbstractInputMethodSessionImpl {
        public InputMethodSessionImpl() {
            super();
        }

        public void finishInput() {
            if (isEnabled()) {
                InputMethodService.this.doFinishInput();
            }
        }

        public void displayCompletions(CompletionInfo[] completions) {
            if (isEnabled()) {
                InputMethodService.this.mCurCompletions = completions;
                InputMethodService.this.onDisplayCompletions(completions);
            }
        }

        public void updateExtractedText(int token, ExtractedText text) {
            if (isEnabled()) {
                InputMethodService.this.onUpdateExtractedText(token, text);
            }
        }

        public void updateSelection(int oldSelStart, int oldSelEnd, int newSelStart, int newSelEnd, int candidatesStart, int candidatesEnd) {
            if (isEnabled()) {
                InputMethodService.this.onUpdateSelection(oldSelStart, oldSelEnd, newSelStart, newSelEnd, candidatesStart, candidatesEnd);
            }
        }

        public void viewClicked(boolean focusChanged) {
            if (isEnabled()) {
                InputMethodService.this.onViewClicked(focusChanged);
            }
        }

        public void updateCursor(Rect newCursor) {
            if (isEnabled()) {
                InputMethodService.this.onUpdateCursor(newCursor);
            }
        }

        public void appPrivateCommand(String action, Bundle data) {
            if (isEnabled()) {
                InputMethodService.this.onAppPrivateCommand(action, data);
            }
        }

        public void toggleSoftInput(int showFlags, int hideFlags) {
            InputMethodService.this.onToggleSoftInput(showFlags, hideFlags);
        }

        public void updateCursorAnchorInfo(CursorAnchorInfo info) {
            if (isEnabled()) {
                InputMethodService.this.onUpdateCursorAnchorInfo(info);
            }
        }
    }

    public static final class Insets {
        public static final int TOUCHABLE_INSETS_CONTENT = 1;
        public static final int TOUCHABLE_INSETS_FRAME = 0;
        public static final int TOUCHABLE_INSETS_REGION = 3;
        public static final int TOUCHABLE_INSETS_VISIBLE = 2;
        public int contentTopInsets;
        public int touchableInsets;
        public final Region touchableRegion;
        public int visibleTopInsets;

        public Insets() {
            this.touchableRegion = new Region();
        }
    }

    public InputMethodService() {
        this.mTheme = BACK_DISPOSITION_DEFAULT;
        this.mHardwareAccelerated = DEBUG;
        this.mTmpInsets = new Insets();
        this.mTmpLocation = new int[IME_VISIBLE];
        this.mInsetsComputer = new C03221();
        this.mActionClickListener = new C03232();
    }

    public void setTheme(int theme) {
        if (this.mWindow != null) {
            throw new IllegalStateException("Must be called before onCreate()");
        }
        this.mTheme = theme;
    }

    public boolean enableHardwareAcceleration() {
        if (this.mWindow != null) {
            throw new IllegalStateException("Must be called before onCreate()");
        } else if (!ActivityManager.isHighEndGfx()) {
            return DEBUG;
        } else {
            this.mHardwareAccelerated = true;
            return true;
        }
    }

    public void onCreate() {
        this.mTheme = Resources.selectSystemTheme(this.mTheme, getApplicationInfo().targetSdkVersion, 16973908, 16973951, 16974142, 16974142);
        super.setTheme(this.mTheme);
        super.onCreate();
        this.mImm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        this.mInflater = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.mWindow = new SoftInputWindow(this, "InputMethod", this.mTheme, null, null, this.mDispatcherState, LayoutParams.TYPE_INPUT_METHOD, 80, DEBUG);
        if (this.mHardwareAccelerated) {
            this.mWindow.getWindow().addFlags(WindowManagerPolicy.FLAG_INJECTED);
        }
        initViews();
        this.mWindow.getWindow().setLayout(MOVEMENT_DOWN, MOVEMENT_UP);
    }

    public void onInitializeInterface() {
    }

    void initialize() {
        if (!this.mInitialized) {
            this.mInitialized = true;
            onInitializeInterface();
        }
    }

    void initViews() {
        this.mInitialized = DEBUG;
        this.mWindowCreated = DEBUG;
        this.mShowInputRequested = DEBUG;
        this.mShowInputForced = DEBUG;
        this.mThemeAttrs = obtainStyledAttributes(C0000R.styleable.InputMethodService);
        this.mRootView = this.mInflater.inflate(17367131, null);
        this.mRootView.setSystemUiVisibility(GLES20.GL_SRC_COLOR);
        this.mWindow.setContentView(this.mRootView);
        this.mRootView.getViewTreeObserver().addOnComputeInternalInsetsListener(this.mInsetsComputer);
        if (Global.getInt(getContentResolver(), "fancy_ime_animations", BACK_DISPOSITION_DEFAULT) != 0) {
            this.mWindow.getWindow().setWindowAnimations(16974562);
        }
        this.mFullscreenArea = (ViewGroup) this.mRootView.findViewById(16909070);
        this.mExtractViewHidden = DEBUG;
        this.mExtractFrame = (FrameLayout) this.mRootView.findViewById(C0000R.id.extractArea);
        this.mExtractView = null;
        this.mExtractEditText = null;
        this.mExtractAccessories = null;
        this.mExtractAction = null;
        this.mFullscreenApplied = DEBUG;
        this.mCandidatesFrame = (FrameLayout) this.mRootView.findViewById(C0000R.id.candidatesArea);
        this.mInputFrame = (FrameLayout) this.mRootView.findViewById(C0000R.id.inputArea);
        this.mInputView = null;
        this.mIsInputViewShown = DEBUG;
        this.mExtractFrame.setVisibility(8);
        this.mCandidatesVisibility = getCandidatesHiddenVisibility();
        this.mCandidatesFrame.setVisibility(this.mCandidatesVisibility);
        this.mInputFrame.setVisibility(8);
    }

    public void onDestroy() {
        super.onDestroy();
        this.mRootView.getViewTreeObserver().removeOnComputeInternalInsetsListener(this.mInsetsComputer);
        doFinishInput();
        if (this.mWindowAdded) {
            this.mWindow.getWindow().setWindowAnimations(BACK_DISPOSITION_DEFAULT);
            this.mWindow.dismiss();
        }
    }

    public void onConfigurationChanged(Configuration newConfig) {
        int i = BACK_DISPOSITION_DEFAULT;
        super.onConfigurationChanged(newConfig);
        boolean visible = this.mWindowVisible;
        int showFlags = this.mShowInputFlags;
        boolean showingInput = this.mShowInputRequested;
        CompletionInfo[] completions = this.mCurCompletions;
        initViews();
        this.mInputViewStarted = DEBUG;
        this.mCandidatesViewStarted = DEBUG;
        if (this.mInputStarted) {
            doStartInput(getCurrentInputConnection(), getCurrentInputEditorInfo(), true);
        }
        if (visible) {
            if (showingInput) {
                if (onShowInputRequested(showFlags, true)) {
                    showWindow(true);
                    if (completions != null) {
                        this.mCurCompletions = completions;
                        onDisplayCompletions(completions);
                    }
                } else {
                    doHideWindow();
                }
            } else if (this.mCandidatesVisibility == 0) {
                showWindow(DEBUG);
            } else {
                doHideWindow();
            }
            boolean showing = onEvaluateInputViewShown();
            InputMethodManager inputMethodManager = this.mImm;
            IBinder iBinder = this.mToken;
            if (showing) {
                i = IME_VISIBLE;
            }
            inputMethodManager.setImeWindowStatus(iBinder, i | IME_ACTIVE, this.mBackDisposition);
        }
    }

    public AbstractInputMethodImpl onCreateInputMethodInterface() {
        return new InputMethodImpl();
    }

    public AbstractInputMethodSessionImpl onCreateInputMethodSessionInterface() {
        return new InputMethodSessionImpl();
    }

    public LayoutInflater getLayoutInflater() {
        return this.mInflater;
    }

    public Dialog getWindow() {
        return this.mWindow;
    }

    public void setBackDisposition(int disposition) {
        this.mBackDisposition = disposition;
    }

    public int getBackDisposition() {
        return this.mBackDisposition;
    }

    public int getMaxWidth() {
        return ((WindowManager) getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay().getWidth();
    }

    public InputBinding getCurrentInputBinding() {
        return this.mInputBinding;
    }

    public InputConnection getCurrentInputConnection() {
        InputConnection ic = this.mStartedInputConnection;
        return ic != null ? ic : this.mInputConnection;
    }

    public boolean getCurrentInputStarted() {
        return this.mInputStarted;
    }

    public EditorInfo getCurrentInputEditorInfo() {
        return this.mInputEditorInfo;
    }

    public void updateFullscreenMode() {
        boolean isFullscreen;
        boolean changed;
        boolean z = true;
        if (this.mShowInputRequested && onEvaluateFullscreenMode()) {
            isFullscreen = true;
        } else {
            isFullscreen = DEBUG;
        }
        if (this.mLastShowInputRequested != this.mShowInputRequested) {
            changed = true;
        } else {
            changed = DEBUG;
        }
        if (!(this.mIsFullscreen == isFullscreen && this.mFullscreenApplied)) {
            changed = true;
            this.mIsFullscreen = isFullscreen;
            InputConnection ic = getCurrentInputConnection();
            if (ic != null) {
                ic.reportFullscreenMode(isFullscreen);
            }
            this.mFullscreenApplied = true;
            initialize();
            LinearLayout.LayoutParams lp = (LinearLayout.LayoutParams) this.mFullscreenArea.getLayoutParams();
            if (isFullscreen) {
                this.mFullscreenArea.setBackgroundDrawable(this.mThemeAttrs.getDrawable(BACK_DISPOSITION_DEFAULT));
                lp.height = BACK_DISPOSITION_DEFAULT;
                lp.weight = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
            } else {
                this.mFullscreenArea.setBackgroundDrawable(null);
                lp.height = MOVEMENT_UP;
                lp.weight = 0.0f;
            }
            ((ViewGroup) this.mFullscreenArea.getParent()).updateViewLayout(this.mFullscreenArea, lp);
            if (isFullscreen) {
                if (this.mExtractView == null) {
                    View v = onCreateExtractTextView();
                    if (v != null) {
                        setExtractView(v);
                    }
                }
                startExtractingText(DEBUG);
            }
            updateExtractFrameVisibility();
        }
        if (changed) {
            Window window = this.mWindow.getWindow();
            if (this.mShowInputRequested) {
                z = DEBUG;
            }
            onConfigureWindow(window, isFullscreen, z);
            this.mLastShowInputRequested = this.mShowInputRequested;
        }
    }

    public void onConfigureWindow(Window win, boolean isFullscreen, boolean isCandidatesOnly) {
        int currentHeight = this.mWindow.getWindow().getAttributes().height;
        int newHeight = isFullscreen ? MOVEMENT_DOWN : MOVEMENT_UP;
        if (this.mIsInputViewShown && currentHeight != newHeight) {
            Log.w(TAG, "Window size has been changed. This may cause jankiness of resizing window: " + currentHeight + " -> " + newHeight);
        }
        this.mWindow.getWindow().setLayout(MOVEMENT_DOWN, newHeight);
    }

    public boolean isFullscreenMode() {
        return this.mIsFullscreen;
    }

    public boolean onEvaluateFullscreenMode() {
        if (getResources().getConfiguration().orientation != IME_VISIBLE) {
            return DEBUG;
        }
        if (this.mInputEditorInfo == null || (this.mInputEditorInfo.imeOptions & EditorInfo.IME_FLAG_NO_FULLSCREEN) == 0) {
            return true;
        }
        return DEBUG;
    }

    public void setExtractViewShown(boolean shown) {
        if (this.mExtractViewHidden == shown) {
            this.mExtractViewHidden = !shown ? true : DEBUG;
            updateExtractFrameVisibility();
        }
    }

    public boolean isExtractViewShown() {
        return (!this.mIsFullscreen || this.mExtractViewHidden) ? DEBUG : true;
    }

    void updateExtractFrameVisibility() {
        int vis;
        boolean z;
        int i = IME_ACTIVE;
        if (isFullscreenMode()) {
            if (this.mExtractViewHidden) {
                vis = 4;
            } else {
                vis = BACK_DISPOSITION_DEFAULT;
            }
            this.mExtractFrame.setVisibility(vis);
        } else {
            vis = BACK_DISPOSITION_DEFAULT;
            this.mExtractFrame.setVisibility(8);
        }
        if (this.mCandidatesVisibility == 0) {
            z = true;
        } else {
            z = DEBUG;
        }
        updateCandidatesVisibility(z);
        if (this.mWindowWasVisible && this.mFullscreenArea.getVisibility() != vis) {
            TypedArray typedArray = this.mThemeAttrs;
            if (vis != 0) {
                i = IME_VISIBLE;
            }
            int animRes = typedArray.getResourceId(i, BACK_DISPOSITION_DEFAULT);
            if (animRes != 0) {
                this.mFullscreenArea.startAnimation(AnimationUtils.loadAnimation(this, animRes));
            }
        }
        this.mFullscreenArea.setVisibility(vis);
    }

    public void onComputeInsets(Insets outInsets) {
        int[] loc = this.mTmpLocation;
        if (this.mInputFrame.getVisibility() == 0) {
            this.mInputFrame.getLocationInWindow(loc);
        } else {
            loc[IME_ACTIVE] = getWindow().getWindow().getDecorView().getHeight();
        }
        if (isFullscreenMode()) {
            outInsets.contentTopInsets = getWindow().getWindow().getDecorView().getHeight();
        } else {
            outInsets.contentTopInsets = loc[IME_ACTIVE];
        }
        if (this.mCandidatesFrame.getVisibility() == 0) {
            this.mCandidatesFrame.getLocationInWindow(loc);
        }
        outInsets.visibleTopInsets = loc[IME_ACTIVE];
        outInsets.touchableInsets = IME_VISIBLE;
        outInsets.touchableRegion.setEmpty();
    }

    public void updateInputViewShown() {
        boolean isShown;
        int i = BACK_DISPOSITION_DEFAULT;
        if (this.mShowInputRequested && onEvaluateInputViewShown()) {
            isShown = true;
        } else {
            isShown = DEBUG;
        }
        if (this.mIsInputViewShown != isShown && this.mWindowVisible) {
            this.mIsInputViewShown = isShown;
            FrameLayout frameLayout = this.mInputFrame;
            if (!isShown) {
                i = 8;
            }
            frameLayout.setVisibility(i);
            if (this.mInputView == null) {
                initialize();
                View v = onCreateInputView();
                if (v != null) {
                    setInputView(v);
                }
            }
        }
    }

    public boolean isShowInputRequested() {
        return this.mShowInputRequested;
    }

    public boolean isInputViewShown() {
        return (this.mIsInputViewShown && this.mWindowVisible) ? true : DEBUG;
    }

    public boolean onEvaluateInputViewShown() {
        Configuration config = getResources().getConfiguration();
        if (config.keyboard == IME_ACTIVE || config.hardKeyboardHidden == IME_VISIBLE) {
            return true;
        }
        return DEBUG;
    }

    public void setCandidatesViewShown(boolean shown) {
        updateCandidatesVisibility(shown);
        if (!this.mShowInputRequested && this.mWindowVisible != shown) {
            if (shown) {
                showWindow(DEBUG);
            } else {
                doHideWindow();
            }
        }
    }

    void updateCandidatesVisibility(boolean shown) {
        int vis = shown ? BACK_DISPOSITION_DEFAULT : getCandidatesHiddenVisibility();
        if (this.mCandidatesVisibility != vis) {
            this.mCandidatesFrame.setVisibility(vis);
            this.mCandidatesVisibility = vis;
        }
    }

    public int getCandidatesHiddenVisibility() {
        return isExtractViewShown() ? 8 : 4;
    }

    public void showStatusIcon(int iconResId) {
        this.mStatusIcon = iconResId;
        this.mImm.showStatusIcon(this.mToken, getPackageName(), iconResId);
    }

    public void hideStatusIcon() {
        this.mStatusIcon = BACK_DISPOSITION_DEFAULT;
        this.mImm.hideStatusIcon(this.mToken);
    }

    public void switchInputMethod(String id) {
        this.mImm.setInputMethod(this.mToken, id);
    }

    public void setExtractView(View view) {
        this.mExtractFrame.removeAllViews();
        this.mExtractFrame.addView(view, new FrameLayout.LayoutParams((int) MOVEMENT_DOWN, (int) MOVEMENT_DOWN));
        this.mExtractView = view;
        if (view != null) {
            this.mExtractEditText = (ExtractEditText) view.findViewById(C0000R.id.inputExtractEditText);
            this.mExtractEditText.setIME(this);
            this.mExtractAction = (Button) view.findViewById(16909072);
            if (this.mExtractAction != null) {
                this.mExtractAccessories = (ViewGroup) view.findViewById(16909071);
            }
            startExtractingText(DEBUG);
            return;
        }
        this.mExtractEditText = null;
        this.mExtractAccessories = null;
        this.mExtractAction = null;
    }

    public void setCandidatesView(View view) {
        this.mCandidatesFrame.removeAllViews();
        this.mCandidatesFrame.addView(view, new FrameLayout.LayoutParams((int) MOVEMENT_DOWN, (int) MOVEMENT_UP));
    }

    public void setInputView(View view) {
        this.mInputFrame.removeAllViews();
        this.mInputFrame.addView(view, new FrameLayout.LayoutParams((int) MOVEMENT_DOWN, (int) MOVEMENT_UP));
        this.mInputView = view;
    }

    public View onCreateExtractTextView() {
        return this.mInflater.inflate(17367132, null);
    }

    public View onCreateCandidatesView() {
        return null;
    }

    public View onCreateInputView() {
        return null;
    }

    public void onStartInputView(EditorInfo info, boolean restarting) {
    }

    public void onFinishInputView(boolean finishingInput) {
        if (!finishingInput) {
            InputConnection ic = getCurrentInputConnection();
            if (ic != null) {
                ic.finishComposingText();
            }
        }
    }

    public void onStartCandidatesView(EditorInfo info, boolean restarting) {
    }

    public void onFinishCandidatesView(boolean finishingInput) {
        if (!finishingInput) {
            InputConnection ic = getCurrentInputConnection();
            if (ic != null) {
                ic.finishComposingText();
            }
        }
    }

    public boolean onShowInputRequested(int flags, boolean configChange) {
        if (!onEvaluateInputViewShown()) {
            return DEBUG;
        }
        if ((flags & IME_ACTIVE) == 0 && ((!configChange && onEvaluateFullscreenMode()) || getResources().getConfiguration().keyboard != IME_ACTIVE)) {
            return DEBUG;
        }
        if ((flags & IME_VISIBLE) != 0) {
            this.mShowInputForced = true;
        }
        return true;
    }

    public void showWindow(boolean showInput) {
        if (this.mInShowWindow) {
            Log.w(TAG, "Re-entrance in to showWindow");
            return;
        }
        try {
            this.mWindowWasVisible = this.mWindowVisible;
            this.mInShowWindow = true;
            showWindowInner(showInput);
        } finally {
            this.mWindowWasVisible = true;
            this.mInShowWindow = DEBUG;
        }
    }

    void showWindowInner(boolean showInput) {
        boolean doShowInput = DEBUG;
        boolean wasVisible = this.mWindowVisible;
        this.mWindowVisible = true;
        if (!this.mShowInputRequested) {
            if (this.mInputStarted && showInput) {
                doShowInput = true;
                this.mShowInputRequested = true;
            }
        }
        initialize();
        updateFullscreenMode();
        updateInputViewShown();
        if (!(this.mWindowAdded && this.mWindowCreated)) {
            this.mWindowAdded = true;
            this.mWindowCreated = true;
            initialize();
            View v = onCreateCandidatesView();
            if (v != null) {
                setCandidatesView(v);
            }
        }
        if (this.mShowInputRequested) {
            if (!this.mInputViewStarted) {
                this.mInputViewStarted = true;
                onStartInputView(this.mInputEditorInfo, DEBUG);
            }
        } else if (!this.mCandidatesViewStarted) {
            this.mCandidatesViewStarted = true;
            onStartCandidatesView(this.mInputEditorInfo, DEBUG);
        }
        if (doShowInput) {
            startExtractingText(DEBUG);
        }
        if (!wasVisible) {
            this.mImm.setImeWindowStatus(this.mToken, IME_ACTIVE, this.mBackDisposition);
            onWindowShown();
            this.mWindow.show();
        }
    }

    private void finishViews() {
        if (this.mInputViewStarted) {
            onFinishInputView(DEBUG);
        } else if (this.mCandidatesViewStarted) {
            onFinishCandidatesView(DEBUG);
        }
        this.mInputViewStarted = DEBUG;
        this.mCandidatesViewStarted = DEBUG;
    }

    private void doHideWindow() {
        this.mImm.setImeWindowStatus(this.mToken, BACK_DISPOSITION_DEFAULT, this.mBackDisposition);
        hideWindow();
    }

    public void hideWindow() {
        finishViews();
        if (this.mWindowVisible) {
            this.mWindow.hide();
            this.mWindowVisible = DEBUG;
            onWindowHidden();
            this.mWindowWasVisible = DEBUG;
        }
    }

    public void onWindowShown() {
    }

    public void onWindowHidden() {
    }

    public void onBindInput() {
    }

    public void onUnbindInput() {
    }

    public void onStartInput(EditorInfo attribute, boolean restarting) {
    }

    void doFinishInput() {
        if (this.mInputViewStarted) {
            onFinishInputView(true);
        } else if (this.mCandidatesViewStarted) {
            onFinishCandidatesView(true);
        }
        this.mInputViewStarted = DEBUG;
        this.mCandidatesViewStarted = DEBUG;
        if (this.mInputStarted) {
            onFinishInput();
        }
        this.mInputStarted = DEBUG;
        this.mStartedInputConnection = null;
        this.mCurCompletions = null;
    }

    void doStartInput(InputConnection ic, EditorInfo attribute, boolean restarting) {
        if (!restarting) {
            doFinishInput();
        }
        this.mInputStarted = true;
        this.mStartedInputConnection = ic;
        this.mInputEditorInfo = attribute;
        initialize();
        onStartInput(attribute, restarting);
        if (!this.mWindowVisible) {
            return;
        }
        if (this.mShowInputRequested) {
            this.mInputViewStarted = true;
            onStartInputView(this.mInputEditorInfo, restarting);
            startExtractingText(true);
        } else if (this.mCandidatesVisibility == 0) {
            this.mCandidatesViewStarted = true;
            onStartCandidatesView(this.mInputEditorInfo, restarting);
        }
    }

    public void onFinishInput() {
        InputConnection ic = getCurrentInputConnection();
        if (ic != null) {
            ic.finishComposingText();
        }
    }

    public void onDisplayCompletions(CompletionInfo[] completions) {
    }

    public void onUpdateExtractedText(int token, ExtractedText text) {
        if (this.mExtractedToken == token && text != null && this.mExtractEditText != null) {
            this.mExtractedText = text;
            this.mExtractEditText.setExtractedText(text);
        }
    }

    public void onUpdateSelection(int oldSelStart, int oldSelEnd, int newSelStart, int newSelEnd, int candidatesStart, int candidatesEnd) {
        ExtractEditText eet = this.mExtractEditText;
        if (eet != null && isFullscreenMode() && this.mExtractedText != null) {
            int off = this.mExtractedText.startOffset;
            eet.startInternalChanges();
            newSelStart -= off;
            newSelEnd -= off;
            int len = eet.getText().length();
            if (newSelStart < 0) {
                newSelStart = BACK_DISPOSITION_DEFAULT;
            } else if (newSelStart > len) {
                newSelStart = len;
            }
            if (newSelEnd < 0) {
                newSelEnd = BACK_DISPOSITION_DEFAULT;
            } else if (newSelEnd > len) {
                newSelEnd = len;
            }
            eet.setSelection(newSelStart, newSelEnd);
            eet.finishInternalChanges();
        }
    }

    public void onViewClicked(boolean focusChanged) {
    }

    @Deprecated
    public void onUpdateCursor(Rect newCursor) {
    }

    public void onUpdateCursorAnchorInfo(CursorAnchorInfo cursorAnchorInfo) {
    }

    public void requestHideSelf(int flags) {
        this.mImm.hideSoftInputFromInputMethod(this.mToken, flags);
    }

    private void requestShowSelf(int flags) {
        this.mImm.showSoftInputFromInputMethod(this.mToken, flags);
    }

    private boolean handleBack(boolean doIt) {
        if (this.mShowInputRequested) {
            if (isExtractViewShown() && (this.mExtractView instanceof ExtractEditLayout)) {
                ExtractEditLayout extractEditLayout = this.mExtractView;
                if (extractEditLayout.isActionModeStarted()) {
                    if (!doIt) {
                        return true;
                    }
                    extractEditLayout.finishActionMode();
                    return true;
                }
            }
            if (!doIt) {
                return true;
            }
            requestHideSelf(BACK_DISPOSITION_DEFAULT);
            return true;
        } else if (!this.mWindowVisible) {
            return DEBUG;
        } else {
            if (this.mCandidatesVisibility == 0) {
                if (!doIt) {
                    return true;
                }
                setCandidatesViewShown(DEBUG);
                return true;
            } else if (!doIt) {
                return true;
            } else {
                doHideWindow();
                return true;
            }
        }
    }

    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (event.getKeyCode() != 4) {
            return doMovementKey(keyCode, event, MOVEMENT_DOWN);
        }
        if (!handleBack(DEBUG)) {
            return DEBUG;
        }
        event.startTracking();
        return true;
    }

    public boolean onKeyLongPress(int keyCode, KeyEvent event) {
        return DEBUG;
    }

    public boolean onKeyMultiple(int keyCode, int count, KeyEvent event) {
        return doMovementKey(keyCode, event, count);
    }

    public boolean onKeyUp(int keyCode, KeyEvent event) {
        if (event.getKeyCode() == 4 && event.isTracking() && !event.isCanceled()) {
            return handleBack(true);
        }
        return doMovementKey(keyCode, event, MOVEMENT_UP);
    }

    public boolean onTrackballEvent(MotionEvent event) {
        return DEBUG;
    }

    public boolean onGenericMotionEvent(MotionEvent event) {
        return DEBUG;
    }

    public void onAppPrivateCommand(String action, Bundle data) {
    }

    private void onToggleSoftInput(int showFlags, int hideFlags) {
        if (isInputViewShown()) {
            requestHideSelf(hideFlags);
        } else {
            requestShowSelf(showFlags);
        }
    }

    void reportExtractedMovement(int keyCode, int count) {
        int dx = BACK_DISPOSITION_DEFAULT;
        int dy = BACK_DISPOSITION_DEFAULT;
        switch (keyCode) {
            case RelativeLayout.ALIGN_END /*19*/:
                dy = -count;
                break;
            case RelativeLayout.ALIGN_PARENT_START /*20*/:
                dy = count;
                break;
            case RelativeLayout.ALIGN_PARENT_END /*21*/:
                dx = -count;
                break;
            case MotionEvent.AXIS_GAS /*22*/:
                dx = count;
                break;
        }
        onExtractedCursorMovement(dx, dy);
    }

    boolean doMovementKey(int keyCode, KeyEvent event, int count) {
        ExtractEditText eet = this.mExtractEditText;
        if (isExtractViewShown() && isInputViewShown() && eet != null) {
            MovementMethod movement = eet.getMovementMethod();
            Layout layout = eet.getLayout();
            if (!(movement == null || layout == null)) {
                if (count == MOVEMENT_DOWN) {
                    if (movement.onKeyDown(eet, eet.getText(), keyCode, event)) {
                        reportExtractedMovement(keyCode, IME_ACTIVE);
                        return true;
                    }
                } else if (count == MOVEMENT_UP) {
                    if (movement.onKeyUp(eet, eet.getText(), keyCode, event)) {
                        return true;
                    }
                } else if (movement.onKeyOther(eet, eet.getText(), event)) {
                    reportExtractedMovement(keyCode, count);
                } else {
                    KeyEvent down = KeyEvent.changeAction(event, BACK_DISPOSITION_DEFAULT);
                    if (movement.onKeyDown(eet, eet.getText(), keyCode, down)) {
                        KeyEvent up = KeyEvent.changeAction(event, IME_ACTIVE);
                        movement.onKeyUp(eet, eet.getText(), keyCode, up);
                        while (true) {
                            count += MOVEMENT_DOWN;
                            if (count <= 0) {
                                break;
                            }
                            movement.onKeyDown(eet, eet.getText(), keyCode, down);
                            movement.onKeyUp(eet, eet.getText(), keyCode, up);
                        }
                        reportExtractedMovement(keyCode, count);
                    }
                }
            }
            switch (keyCode) {
                case RelativeLayout.ALIGN_END /*19*/:
                case RelativeLayout.ALIGN_PARENT_START /*20*/:
                case RelativeLayout.ALIGN_PARENT_END /*21*/:
                case MotionEvent.AXIS_GAS /*22*/:
                    return true;
            }
        }
        return DEBUG;
    }

    public void sendDownUpKeyEvents(int keyEventCode) {
        InputConnection ic = getCurrentInputConnection();
        if (ic != null) {
            long eventTime = SystemClock.uptimeMillis();
            ic.sendKeyEvent(new KeyEvent(eventTime, eventTime, BACK_DISPOSITION_DEFAULT, keyEventCode, BACK_DISPOSITION_DEFAULT, BACK_DISPOSITION_DEFAULT, MOVEMENT_DOWN, BACK_DISPOSITION_DEFAULT, 6));
            ic.sendKeyEvent(new KeyEvent(eventTime, SystemClock.uptimeMillis(), IME_ACTIVE, keyEventCode, BACK_DISPOSITION_DEFAULT, BACK_DISPOSITION_DEFAULT, MOVEMENT_DOWN, BACK_DISPOSITION_DEFAULT, 6));
        }
    }

    public boolean sendDefaultEditorAction(boolean fromEnterKey) {
        EditorInfo ei = getCurrentInputEditorInfo();
        if (ei == null || ((fromEnterKey && (ei.imeOptions & EditorInfo.IME_FLAG_NO_ENTER_ACTION) != 0) || (ei.imeOptions & EditorInfo.IME_MASK_ACTION) == IME_ACTIVE)) {
            return DEBUG;
        }
        InputConnection ic = getCurrentInputConnection();
        if (ic == null) {
            return true;
        }
        ic.performEditorAction(ei.imeOptions & EditorInfo.IME_MASK_ACTION);
        return true;
    }

    public void sendKeyChar(char charCode) {
        switch (charCode) {
            case SetRemoteViewsAdapterIntent.TAG /*10*/:
                if (!sendDefaultEditorAction(true)) {
                    sendDownUpKeyEvents(66);
                }
            default:
                if (charCode < '0' || charCode > '9') {
                    InputConnection ic = getCurrentInputConnection();
                    if (ic != null) {
                        ic.commitText(String.valueOf(charCode), IME_ACTIVE);
                        return;
                    }
                    return;
                }
                sendDownUpKeyEvents((charCode - 48) + 7);
        }
    }

    public void onExtractedSelectionChanged(int start, int end) {
        InputConnection conn = getCurrentInputConnection();
        if (conn != null) {
            conn.setSelection(start, end);
        }
    }

    public void onExtractedDeleteText(int start, int end) {
        InputConnection conn = getCurrentInputConnection();
        if (conn != null) {
            conn.setSelection(start, start);
            conn.deleteSurroundingText(BACK_DISPOSITION_DEFAULT, end - start);
        }
    }

    public void onExtractedReplaceText(int start, int end, CharSequence text) {
        InputConnection conn = getCurrentInputConnection();
        if (conn != null) {
            conn.setComposingRegion(start, end);
            conn.commitText(text, IME_ACTIVE);
        }
    }

    public void onExtractedSetSpan(Object span, int start, int end, int flags) {
        InputConnection conn = getCurrentInputConnection();
        if (conn != null && conn.setSelection(start, end)) {
            CharSequence text = conn.getSelectedText(IME_ACTIVE);
            if (text instanceof Spannable) {
                ((Spannable) text).setSpan(span, BACK_DISPOSITION_DEFAULT, text.length(), flags);
                conn.setComposingRegion(start, end);
                conn.commitText(text, IME_ACTIVE);
            }
        }
    }

    public void onExtractedTextClicked() {
        if (this.mExtractEditText != null && this.mExtractEditText.hasVerticalScrollBar()) {
            setCandidatesViewShown(DEBUG);
        }
    }

    public void onExtractedCursorMovement(int dx, int dy) {
        if (this.mExtractEditText != null && dy != 0 && this.mExtractEditText.hasVerticalScrollBar()) {
            setCandidatesViewShown(DEBUG);
        }
    }

    public boolean onExtractTextContextMenuItem(int id) {
        InputConnection ic = getCurrentInputConnection();
        if (ic != null) {
            ic.performContextMenuAction(id);
        }
        return true;
    }

    public CharSequence getTextForImeAction(int imeOptions) {
        switch (imeOptions & EditorInfo.IME_MASK_ACTION) {
            case IME_ACTIVE /*1*/:
                return null;
            case IME_VISIBLE /*2*/:
                return getText(17040705);
            case SetDrawableParameters.TAG /*3*/:
                return getText(17040706);
            case ViewGroupAction.TAG /*4*/:
                return getText(17040707);
            case ReflectionActionWithoutParams.TAG /*5*/:
                return getText(17040708);
            case SetEmptyView.TAG /*6*/:
                return getText(17040709);
            case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
                return getText(17040710);
            default:
                return getText(17040711);
        }
    }

    public void onUpdateExtractingVisibility(EditorInfo ei) {
        if (ei.inputType == 0 || (ei.imeOptions & EditorInfo.IME_FLAG_NO_EXTRACT_UI) != 0) {
            setExtractViewShown(DEBUG);
        } else {
            setExtractViewShown(true);
        }
    }

    public void onUpdateExtractingViews(EditorInfo ei) {
        boolean hasAction = true;
        if (isExtractViewShown() && this.mExtractAccessories != null) {
            if (ei.actionLabel == null && ((ei.imeOptions & EditorInfo.IME_MASK_ACTION) == IME_ACTIVE || (ei.imeOptions & EditorInfo.IME_FLAG_NO_ACCESSORY_ACTION) != 0 || ei.inputType == 0)) {
                hasAction = DEBUG;
            }
            if (hasAction) {
                this.mExtractAccessories.setVisibility(BACK_DISPOSITION_DEFAULT);
                if (this.mExtractAction != null) {
                    if (ei.actionLabel != null) {
                        this.mExtractAction.setText(ei.actionLabel);
                    } else {
                        this.mExtractAction.setText(getTextForImeAction(ei.imeOptions));
                    }
                    this.mExtractAction.setOnClickListener(this.mActionClickListener);
                    return;
                }
                return;
            }
            this.mExtractAccessories.setVisibility(8);
            if (this.mExtractAction != null) {
                this.mExtractAction.setOnClickListener(null);
            }
        }
    }

    public void onExtractingInputChanged(EditorInfo ei) {
        if (ei.inputType == 0) {
            requestHideSelf(IME_VISIBLE);
        }
    }

    void startExtractingText(boolean inputChanged) {
        ExtractEditText eet = this.mExtractEditText;
        if (eet != null && getCurrentInputStarted() && isFullscreenMode()) {
            this.mExtractedToken += IME_ACTIVE;
            ExtractedTextRequest req = new ExtractedTextRequest();
            req.token = this.mExtractedToken;
            req.flags = IME_ACTIVE;
            req.hintMaxLines = 10;
            req.hintMaxChars = Window.PROGRESS_END;
            InputConnection ic = getCurrentInputConnection();
            this.mExtractedText = ic == null ? null : ic.getExtractedText(req, IME_ACTIVE);
            if (this.mExtractedText == null || ic == null) {
                Log.e(TAG, "Unexpected null in startExtractingText : mExtractedText = " + this.mExtractedText + ", input connection = " + ic);
            }
            EditorInfo ei = getCurrentInputEditorInfo();
            try {
                eet.startInternalChanges();
                onUpdateExtractingVisibility(ei);
                onUpdateExtractingViews(ei);
                int inputType = ei.inputType;
                if ((inputType & 15) == IME_ACTIVE && (AccessibilityNodeInfo.ACTION_EXPAND & inputType) != 0) {
                    inputType |= AccessibilityNodeInfo.ACTION_SET_SELECTION;
                }
                eet.setInputType(inputType);
                eet.setHint(ei.hintText);
                if (this.mExtractedText != null) {
                    eet.setEnabled(true);
                    eet.setExtractedText(this.mExtractedText);
                } else {
                    eet.setEnabled(DEBUG);
                    eet.setText(ProxyInfo.LOCAL_EXCL_LIST);
                }
                eet.finishInternalChanges();
                if (inputChanged) {
                    onExtractingInputChanged(ei);
                }
            } catch (Throwable th) {
                eet.finishInternalChanges();
            }
        }
    }

    protected void onCurrentInputMethodSubtypeChanged(InputMethodSubtype newSubtype) {
    }

    public int getInputMethodWindowRecommendedHeight() {
        return this.mImm.getInputMethodWindowVisibleHeight();
    }

    protected void dump(FileDescriptor fd, PrintWriter fout, String[] args) {
        Printer p = new PrintWriterPrinter(fout);
        p.println("Input method service state for " + this + ":");
        p.println("  mWindowCreated=" + this.mWindowCreated + " mWindowAdded=" + this.mWindowAdded);
        p.println("  mWindowVisible=" + this.mWindowVisible + " mWindowWasVisible=" + this.mWindowWasVisible + " mInShowWindow=" + this.mInShowWindow);
        p.println("  Configuration=" + getResources().getConfiguration());
        p.println("  mToken=" + this.mToken);
        p.println("  mInputBinding=" + this.mInputBinding);
        p.println("  mInputConnection=" + this.mInputConnection);
        p.println("  mStartedInputConnection=" + this.mStartedInputConnection);
        p.println("  mInputStarted=" + this.mInputStarted + " mInputViewStarted=" + this.mInputViewStarted + " mCandidatesViewStarted=" + this.mCandidatesViewStarted);
        if (this.mInputEditorInfo != null) {
            p.println("  mInputEditorInfo:");
            this.mInputEditorInfo.dump(p, "    ");
        } else {
            p.println("  mInputEditorInfo: null");
        }
        p.println("  mShowInputRequested=" + this.mShowInputRequested + " mLastShowInputRequested=" + this.mLastShowInputRequested + " mShowInputForced=" + this.mShowInputForced + " mShowInputFlags=0x" + Integer.toHexString(this.mShowInputFlags));
        p.println("  mCandidatesVisibility=" + this.mCandidatesVisibility + " mFullscreenApplied=" + this.mFullscreenApplied + " mIsFullscreen=" + this.mIsFullscreen + " mExtractViewHidden=" + this.mExtractViewHidden);
        if (this.mExtractedText != null) {
            p.println("  mExtractedText:");
            p.println("    text=" + this.mExtractedText.text.length() + " chars" + " startOffset=" + this.mExtractedText.startOffset);
            p.println("    selectionStart=" + this.mExtractedText.selectionStart + " selectionEnd=" + this.mExtractedText.selectionEnd + " flags=0x" + Integer.toHexString(this.mExtractedText.flags));
        } else {
            p.println("  mExtractedText: null");
        }
        p.println("  mExtractedToken=" + this.mExtractedToken);
        p.println("  mIsInputViewShown=" + this.mIsInputViewShown + " mStatusIcon=" + this.mStatusIcon);
        p.println("Last computed insets:");
        p.println("  contentTopInsets=" + this.mTmpInsets.contentTopInsets + " visibleTopInsets=" + this.mTmpInsets.visibleTopInsets + " touchableInsets=" + this.mTmpInsets.touchableInsets + " touchableRegion=" + this.mTmpInsets.touchableRegion);
    }
}
