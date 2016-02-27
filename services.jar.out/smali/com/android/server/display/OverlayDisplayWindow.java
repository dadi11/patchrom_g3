package com.android.server.display;

import android.content.Context;
import android.graphics.SurfaceTexture;
import android.hardware.display.DisplayManager;
import android.hardware.display.DisplayManager.DisplayListener;
import android.util.Slog;
import android.view.Display;
import android.view.DisplayInfo;
import android.view.GestureDetector;
import android.view.GestureDetector.OnGestureListener;
import android.view.GestureDetector.SimpleOnGestureListener;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import android.view.ScaleGestureDetector.OnScaleGestureListener;
import android.view.ScaleGestureDetector.SimpleOnScaleGestureListener;
import android.view.TextureView;
import android.view.TextureView.SurfaceTextureListener;
import android.view.View;
import android.view.View.OnTouchListener;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.widget.TextView;
import com.android.internal.util.DumpUtils.Dump;
import com.android.server.wm.WindowManagerService;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.PrintWriter;

final class OverlayDisplayWindow implements Dump {
    private static final boolean DEBUG = false;
    private static final String TAG = "OverlayDisplayWindow";
    private final boolean DISABLE_MOVE_AND_RESIZE;
    private final float INITIAL_SCALE;
    private final float MAX_SCALE;
    private final float MIN_SCALE;
    private final float WINDOW_ALPHA;
    private final Context mContext;
    private final Display mDefaultDisplay;
    private final DisplayInfo mDefaultDisplayInfo;
    private final int mDensityDpi;
    private final DisplayListener mDisplayListener;
    private final DisplayManager mDisplayManager;
    private GestureDetector mGestureDetector;
    private final int mGravity;
    private final int mHeight;
    private final Listener mListener;
    private float mLiveScale;
    private float mLiveTranslationX;
    private float mLiveTranslationY;
    private final String mName;
    private final OnGestureListener mOnGestureListener;
    private final OnScaleGestureListener mOnScaleGestureListener;
    private final OnTouchListener mOnTouchListener;
    private ScaleGestureDetector mScaleGestureDetector;
    private final boolean mSecure;
    private final SurfaceTextureListener mSurfaceTextureListener;
    private TextureView mTextureView;
    private String mTitle;
    private TextView mTitleTextView;
    private final int mWidth;
    private View mWindowContent;
    private final WindowManager mWindowManager;
    private LayoutParams mWindowParams;
    private float mWindowScale;
    private boolean mWindowVisible;
    private int mWindowX;
    private int mWindowY;

    public interface Listener {
        void onStateChanged(int i);

        void onWindowCreated(SurfaceTexture surfaceTexture, float f, long j, int i);

        void onWindowDestroyed();
    }

    /* renamed from: com.android.server.display.OverlayDisplayWindow.1 */
    class C02141 implements DisplayListener {
        C02141() {
        }

        public void onDisplayAdded(int displayId) {
        }

        public void onDisplayChanged(int displayId) {
            if (displayId != OverlayDisplayWindow.this.mDefaultDisplay.getDisplayId()) {
                return;
            }
            if (OverlayDisplayWindow.this.updateDefaultDisplayInfo()) {
                OverlayDisplayWindow.this.relayout();
                OverlayDisplayWindow.this.mListener.onStateChanged(OverlayDisplayWindow.this.mDefaultDisplayInfo.state);
                return;
            }
            OverlayDisplayWindow.this.dismiss();
        }

        public void onDisplayRemoved(int displayId) {
            if (displayId == OverlayDisplayWindow.this.mDefaultDisplay.getDisplayId()) {
                OverlayDisplayWindow.this.dismiss();
            }
        }
    }

    /* renamed from: com.android.server.display.OverlayDisplayWindow.2 */
    class C02152 implements SurfaceTextureListener {
        C02152() {
        }

        public void onSurfaceTextureAvailable(SurfaceTexture surfaceTexture, int width, int height) {
            OverlayDisplayWindow.this.mListener.onWindowCreated(surfaceTexture, OverlayDisplayWindow.this.mDefaultDisplayInfo.refreshRate, OverlayDisplayWindow.this.mDefaultDisplayInfo.presentationDeadlineNanos, OverlayDisplayWindow.this.mDefaultDisplayInfo.state);
        }

        public boolean onSurfaceTextureDestroyed(SurfaceTexture surfaceTexture) {
            OverlayDisplayWindow.this.mListener.onWindowDestroyed();
            return true;
        }

        public void onSurfaceTextureSizeChanged(SurfaceTexture surfaceTexture, int width, int height) {
        }

        public void onSurfaceTextureUpdated(SurfaceTexture surfaceTexture) {
        }
    }

    /* renamed from: com.android.server.display.OverlayDisplayWindow.3 */
    class C02163 implements OnTouchListener {
        C02163() {
        }

        public boolean onTouch(View view, MotionEvent event) {
            float oldX = event.getX();
            float oldY = event.getY();
            event.setLocation(event.getRawX(), event.getRawY());
            OverlayDisplayWindow.this.mGestureDetector.onTouchEvent(event);
            OverlayDisplayWindow.this.mScaleGestureDetector.onTouchEvent(event);
            switch (event.getActionMasked()) {
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                case C0569H.REPORT_LOSING_FOCUS /*3*/:
                    OverlayDisplayWindow.this.saveWindowParams();
                    break;
            }
            event.setLocation(oldX, oldY);
            return true;
        }
    }

    /* renamed from: com.android.server.display.OverlayDisplayWindow.4 */
    class C02174 extends SimpleOnGestureListener {
        C02174() {
        }

        public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
            OverlayDisplayWindow.access$724(OverlayDisplayWindow.this, distanceX);
            OverlayDisplayWindow.access$824(OverlayDisplayWindow.this, distanceY);
            OverlayDisplayWindow.this.relayout();
            return true;
        }
    }

    /* renamed from: com.android.server.display.OverlayDisplayWindow.5 */
    class C02185 extends SimpleOnScaleGestureListener {
        C02185() {
        }

        public boolean onScale(ScaleGestureDetector detector) {
            OverlayDisplayWindow.access$932(OverlayDisplayWindow.this, detector.getScaleFactor());
            OverlayDisplayWindow.this.relayout();
            return true;
        }
    }

    static /* synthetic */ float access$724(OverlayDisplayWindow x0, float x1) {
        float f = x0.mLiveTranslationX - x1;
        x0.mLiveTranslationX = f;
        return f;
    }

    static /* synthetic */ float access$824(OverlayDisplayWindow x0, float x1) {
        float f = x0.mLiveTranslationY - x1;
        x0.mLiveTranslationY = f;
        return f;
    }

    static /* synthetic */ float access$932(OverlayDisplayWindow x0, float x1) {
        float f = x0.mLiveScale * x1;
        x0.mLiveScale = f;
        return f;
    }

    public OverlayDisplayWindow(Context context, String name, int width, int height, int densityDpi, int gravity, boolean secure, Listener listener) {
        this.INITIAL_SCALE = 0.5f;
        this.MIN_SCALE = 0.3f;
        this.MAX_SCALE = 1.0f;
        this.WINDOW_ALPHA = WindowManagerService.STACK_WEIGHT_MAX;
        this.DISABLE_MOVE_AND_RESIZE = DEBUG;
        this.mDefaultDisplayInfo = new DisplayInfo();
        this.mLiveScale = 1.0f;
        this.mDisplayListener = new C02141();
        this.mSurfaceTextureListener = new C02152();
        this.mOnTouchListener = new C02163();
        this.mOnGestureListener = new C02174();
        this.mOnScaleGestureListener = new C02185();
        this.mContext = context;
        this.mName = name;
        this.mWidth = width;
        this.mHeight = height;
        this.mDensityDpi = densityDpi;
        this.mGravity = gravity;
        this.mSecure = secure;
        this.mListener = listener;
        this.mTitle = context.getResources().getString(17040882, new Object[]{this.mName, Integer.valueOf(this.mWidth), Integer.valueOf(this.mHeight), Integer.valueOf(this.mDensityDpi)});
        if (secure) {
            this.mTitle += context.getResources().getString(17040883);
        }
        this.mDisplayManager = (DisplayManager) context.getSystemService("display");
        this.mWindowManager = (WindowManager) context.getSystemService("window");
        this.mDefaultDisplay = this.mWindowManager.getDefaultDisplay();
        updateDefaultDisplayInfo();
        createWindow();
    }

    public void show() {
        if (!this.mWindowVisible) {
            this.mDisplayManager.registerDisplayListener(this.mDisplayListener, null);
            if (updateDefaultDisplayInfo()) {
                clearLiveState();
                updateWindowParams();
                this.mWindowManager.addView(this.mWindowContent, this.mWindowParams);
                this.mWindowVisible = true;
                return;
            }
            this.mDisplayManager.unregisterDisplayListener(this.mDisplayListener);
        }
    }

    public void dismiss() {
        if (this.mWindowVisible) {
            this.mDisplayManager.unregisterDisplayListener(this.mDisplayListener);
            this.mWindowManager.removeView(this.mWindowContent);
            this.mWindowVisible = DEBUG;
        }
    }

    public void relayout() {
        if (this.mWindowVisible) {
            updateWindowParams();
            this.mWindowManager.updateViewLayout(this.mWindowContent, this.mWindowParams);
        }
    }

    public void dump(PrintWriter pw) {
        pw.println("mWindowVisible=" + this.mWindowVisible);
        pw.println("mWindowX=" + this.mWindowX);
        pw.println("mWindowY=" + this.mWindowY);
        pw.println("mWindowScale=" + this.mWindowScale);
        pw.println("mWindowParams=" + this.mWindowParams);
        if (this.mTextureView != null) {
            pw.println("mTextureView.getScaleX()=" + this.mTextureView.getScaleX());
            pw.println("mTextureView.getScaleY()=" + this.mTextureView.getScaleY());
        }
        pw.println("mLiveTranslationX=" + this.mLiveTranslationX);
        pw.println("mLiveTranslationY=" + this.mLiveTranslationY);
        pw.println("mLiveScale=" + this.mLiveScale);
    }

    private boolean updateDefaultDisplayInfo() {
        if (this.mDefaultDisplay.getDisplayInfo(this.mDefaultDisplayInfo)) {
            return true;
        }
        Slog.w(TAG, "Cannot show overlay display because there is no default display upon which to show it.");
        return DEBUG;
    }

    private void createWindow() {
        int i = 0;
        this.mWindowContent = LayoutInflater.from(this.mContext).inflate(17367176, null);
        this.mWindowContent.setOnTouchListener(this.mOnTouchListener);
        this.mTextureView = (TextureView) this.mWindowContent.findViewById(16909133);
        this.mTextureView.setPivotX(0.0f);
        this.mTextureView.setPivotY(0.0f);
        this.mTextureView.getLayoutParams().width = this.mWidth;
        this.mTextureView.getLayoutParams().height = this.mHeight;
        this.mTextureView.setOpaque(DEBUG);
        this.mTextureView.setSurfaceTextureListener(this.mSurfaceTextureListener);
        this.mTitleTextView = (TextView) this.mWindowContent.findViewById(16909134);
        this.mTitleTextView.setText(this.mTitle);
        this.mWindowParams = new LayoutParams(2026);
        LayoutParams layoutParams = this.mWindowParams;
        layoutParams.flags |= 16778024;
        if (this.mSecure) {
            layoutParams = this.mWindowParams;
            layoutParams.flags |= DumpState.DUMP_INSTALLS;
        }
        layoutParams = this.mWindowParams;
        layoutParams.privateFlags |= 2;
        this.mWindowParams.alpha = WindowManagerService.STACK_WEIGHT_MAX;
        this.mWindowParams.gravity = 51;
        this.mWindowParams.setTitle(this.mTitle);
        this.mGestureDetector = new GestureDetector(this.mContext, this.mOnGestureListener);
        this.mScaleGestureDetector = new ScaleGestureDetector(this.mContext, this.mOnScaleGestureListener);
        this.mWindowX = (this.mGravity & 3) == 3 ? 0 : this.mDefaultDisplayInfo.logicalWidth;
        if ((this.mGravity & 48) != 48) {
            i = this.mDefaultDisplayInfo.logicalHeight;
        }
        this.mWindowY = i;
        this.mWindowScale = 0.5f;
    }

    private void updateWindowParams() {
        float scale = Math.max(0.3f, Math.min(1.0f, Math.min(Math.min(this.mWindowScale * this.mLiveScale, ((float) this.mDefaultDisplayInfo.logicalWidth) / ((float) this.mWidth)), ((float) this.mDefaultDisplayInfo.logicalHeight) / ((float) this.mHeight))));
        float offsetScale = ((scale / this.mWindowScale) - 1.0f) * 0.5f;
        int width = (int) (((float) this.mWidth) * scale);
        int height = (int) (((float) this.mHeight) * scale);
        int y = (int) ((((float) this.mWindowY) + this.mLiveTranslationY) - (((float) height) * offsetScale));
        int x = Math.max(0, Math.min((int) ((((float) this.mWindowX) + this.mLiveTranslationX) - (((float) width) * offsetScale)), this.mDefaultDisplayInfo.logicalWidth - width));
        y = Math.max(0, Math.min(y, this.mDefaultDisplayInfo.logicalHeight - height));
        this.mTextureView.setScaleX(scale);
        this.mTextureView.setScaleY(scale);
        this.mWindowParams.x = x;
        this.mWindowParams.y = y;
        this.mWindowParams.width = width;
        this.mWindowParams.height = height;
    }

    private void saveWindowParams() {
        this.mWindowX = this.mWindowParams.x;
        this.mWindowY = this.mWindowParams.y;
        this.mWindowScale = this.mTextureView.getScaleX();
        clearLiveState();
    }

    private void clearLiveState() {
        this.mLiveTranslationX = 0.0f;
        this.mLiveTranslationY = 0.0f;
        this.mLiveScale = 1.0f;
    }
}
