package com.android.server.display;

import android.content.Context;
import android.database.ContentObserver;
import android.graphics.SurfaceTexture;
import android.os.Handler;
import android.os.IBinder;
import android.provider.Settings.Global;
import android.util.Slog;
import android.view.Surface;
import android.view.SurfaceControl;
import com.android.internal.util.DumpUtils;
import com.android.internal.util.IndentingPrintWriter;
import com.android.server.SystemService;
import com.android.server.display.DisplayManagerService.SyncRoot;
import com.android.server.display.OverlayDisplayWindow.Listener;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

final class OverlayDisplayAdapter extends DisplayAdapter {
    static final boolean DEBUG = false;
    private static final int MAX_HEIGHT = 4096;
    private static final int MAX_WIDTH = 4096;
    private static final int MIN_HEIGHT = 100;
    private static final int MIN_WIDTH = 100;
    private static final Pattern SETTING_PATTERN;
    static final String TAG = "OverlayDisplayAdapter";
    private static final String UNIQUE_ID_PREFIX = "overlay:";
    private String mCurrentOverlaySetting;
    private final ArrayList<OverlayDisplayHandle> mOverlays;
    private final Handler mUiHandler;

    /* renamed from: com.android.server.display.OverlayDisplayAdapter.1 */
    class C02111 implements Runnable {

        /* renamed from: com.android.server.display.OverlayDisplayAdapter.1.1 */
        class C02101 extends ContentObserver {
            C02101(Handler x0) {
                super(x0);
            }

            public void onChange(boolean selfChange) {
                OverlayDisplayAdapter.this.updateOverlayDisplayDevices();
            }
        }

        C02111() {
        }

        public void run() {
            OverlayDisplayAdapter.this.getContext().getContentResolver().registerContentObserver(Global.getUriFor("overlay_display_devices"), true, new C02101(OverlayDisplayAdapter.this.getHandler()));
            OverlayDisplayAdapter.this.updateOverlayDisplayDevices();
        }
    }

    private final class OverlayDisplayDevice extends DisplayDevice {
        private final int mDensityDpi;
        private final long mDisplayPresentationDeadlineNanos;
        private final int mHeight;
        private DisplayDeviceInfo mInfo;
        private final String mName;
        private final float mRefreshRate;
        private final boolean mSecure;
        private int mState;
        private Surface mSurface;
        private SurfaceTexture mSurfaceTexture;
        private final int mWidth;

        public OverlayDisplayDevice(IBinder displayToken, String name, int width, int height, float refreshRate, long presentationDeadlineNanos, int densityDpi, boolean secure, int state, SurfaceTexture surfaceTexture, int number) {
            super(OverlayDisplayAdapter.this, displayToken, OverlayDisplayAdapter.UNIQUE_ID_PREFIX + number);
            this.mName = name;
            this.mWidth = width;
            this.mHeight = height;
            this.mRefreshRate = refreshRate;
            this.mDisplayPresentationDeadlineNanos = presentationDeadlineNanos;
            this.mDensityDpi = densityDpi;
            this.mSecure = secure;
            this.mState = state;
            this.mSurfaceTexture = surfaceTexture;
        }

        public void destroyLocked() {
            this.mSurfaceTexture = null;
            if (this.mSurface != null) {
                this.mSurface.release();
                this.mSurface = null;
            }
            SurfaceControl.destroyDisplay(getDisplayTokenLocked());
        }

        public void performTraversalInTransactionLocked() {
            if (this.mSurfaceTexture != null) {
                if (this.mSurface == null) {
                    this.mSurface = new Surface(this.mSurfaceTexture);
                }
                setSurfaceInTransactionLocked(this.mSurface);
            }
        }

        public void setStateLocked(int state) {
            this.mState = state;
            this.mInfo = null;
        }

        public DisplayDeviceInfo getDisplayDeviceInfoLocked() {
            if (this.mInfo == null) {
                this.mInfo = new DisplayDeviceInfo();
                this.mInfo.name = this.mName;
                this.mInfo.uniqueId = getUniqueId();
                this.mInfo.width = this.mWidth;
                this.mInfo.height = this.mHeight;
                this.mInfo.refreshRate = this.mRefreshRate;
                float[] fArr = new float[]{this.mRefreshRate};
                this.mInfo.supportedRefreshRates = fArr;
                this.mInfo.densityDpi = this.mDensityDpi;
                this.mInfo.xDpi = (float) this.mDensityDpi;
                this.mInfo.yDpi = (float) this.mDensityDpi;
                this.mInfo.presentationDeadlineNanos = this.mDisplayPresentationDeadlineNanos + (1000000000 / ((long) ((int) this.mRefreshRate)));
                this.mInfo.flags = 64;
                if (this.mSecure) {
                    DisplayDeviceInfo displayDeviceInfo = this.mInfo;
                    displayDeviceInfo.flags |= 4;
                }
                this.mInfo.type = 4;
                this.mInfo.touch = 0;
                this.mInfo.state = this.mState;
            }
            return this.mInfo;
        }
    }

    private final class OverlayDisplayHandle implements Listener {
        private final int mDensityDpi;
        private OverlayDisplayDevice mDevice;
        private final Runnable mDismissRunnable;
        private final int mGravity;
        private final int mHeight;
        private final String mName;
        private final int mNumber;
        private final boolean mSecure;
        private final Runnable mShowRunnable;
        private final int mWidth;
        private OverlayDisplayWindow mWindow;

        /* renamed from: com.android.server.display.OverlayDisplayAdapter.OverlayDisplayHandle.1 */
        class C02121 implements Runnable {
            C02121() {
            }

            public void run() {
                OverlayDisplayWindow window = new OverlayDisplayWindow(OverlayDisplayAdapter.this.getContext(), OverlayDisplayHandle.this.mName, OverlayDisplayHandle.this.mWidth, OverlayDisplayHandle.this.mHeight, OverlayDisplayHandle.this.mDensityDpi, OverlayDisplayHandle.this.mGravity, OverlayDisplayHandle.this.mSecure, OverlayDisplayHandle.this);
                window.show();
                synchronized (OverlayDisplayAdapter.this.getSyncRoot()) {
                    OverlayDisplayHandle.this.mWindow = window;
                }
            }
        }

        /* renamed from: com.android.server.display.OverlayDisplayAdapter.OverlayDisplayHandle.2 */
        class C02132 implements Runnable {
            C02132() {
            }

            public void run() {
                synchronized (OverlayDisplayAdapter.this.getSyncRoot()) {
                    OverlayDisplayWindow window = OverlayDisplayHandle.this.mWindow;
                    OverlayDisplayHandle.this.mWindow = null;
                }
                if (window != null) {
                    window.dismiss();
                }
            }
        }

        public OverlayDisplayHandle(String name, int width, int height, int densityDpi, int gravity, boolean secure, int number) {
            this.mShowRunnable = new C02121();
            this.mDismissRunnable = new C02132();
            this.mName = name;
            this.mWidth = width;
            this.mHeight = height;
            this.mDensityDpi = densityDpi;
            this.mGravity = gravity;
            this.mSecure = secure;
            this.mNumber = number;
            OverlayDisplayAdapter.this.mUiHandler.post(this.mShowRunnable);
        }

        public void dismissLocked() {
            OverlayDisplayAdapter.this.mUiHandler.removeCallbacks(this.mShowRunnable);
            OverlayDisplayAdapter.this.mUiHandler.post(this.mDismissRunnable);
        }

        public void onWindowCreated(SurfaceTexture surfaceTexture, float refreshRate, long presentationDeadlineNanos, int state) {
            synchronized (OverlayDisplayAdapter.this.getSyncRoot()) {
                float f = refreshRate;
                long j = presentationDeadlineNanos;
                int i = state;
                SurfaceTexture surfaceTexture2 = surfaceTexture;
                this.mDevice = new OverlayDisplayDevice(SurfaceControl.createDisplay(this.mName, this.mSecure), this.mName, this.mWidth, this.mHeight, f, j, this.mDensityDpi, this.mSecure, i, surfaceTexture2, this.mNumber);
                OverlayDisplayAdapter.this.sendDisplayDeviceEventLocked(this.mDevice, 1);
            }
        }

        public void onWindowDestroyed() {
            synchronized (OverlayDisplayAdapter.this.getSyncRoot()) {
                if (this.mDevice != null) {
                    this.mDevice.destroyLocked();
                    OverlayDisplayAdapter.this.sendDisplayDeviceEventLocked(this.mDevice, 3);
                }
            }
        }

        public void onStateChanged(int state) {
            synchronized (OverlayDisplayAdapter.this.getSyncRoot()) {
                if (this.mDevice != null) {
                    this.mDevice.setStateLocked(state);
                    OverlayDisplayAdapter.this.sendDisplayDeviceEventLocked(this.mDevice, 2);
                }
            }
        }

        public void dumpLocked(PrintWriter pw) {
            pw.println("  " + this.mName + ":");
            pw.println("    mWidth=" + this.mWidth);
            pw.println("    mHeight=" + this.mHeight);
            pw.println("    mDensityDpi=" + this.mDensityDpi);
            pw.println("    mGravity=" + this.mGravity);
            pw.println("    mSecure=" + this.mSecure);
            pw.println("    mNumber=" + this.mNumber);
            if (this.mWindow != null) {
                IndentingPrintWriter ipw = new IndentingPrintWriter(pw, "    ");
                ipw.increaseIndent();
                DumpUtils.dumpAsync(OverlayDisplayAdapter.this.mUiHandler, this.mWindow, ipw, 200);
            }
        }
    }

    static {
        SETTING_PATTERN = Pattern.compile("(\\d+)x(\\d+)/(\\d+)(,[a-z]+)*");
    }

    public OverlayDisplayAdapter(SyncRoot syncRoot, Context context, Handler handler, DisplayAdapter.Listener listener, Handler uiHandler) {
        super(syncRoot, context, handler, listener, TAG);
        this.mOverlays = new ArrayList();
        this.mCurrentOverlaySetting = "";
        this.mUiHandler = uiHandler;
    }

    public void dumpLocked(PrintWriter pw) {
        super.dumpLocked(pw);
        pw.println("mCurrentOverlaySetting=" + this.mCurrentOverlaySetting);
        pw.println("mOverlays: size=" + this.mOverlays.size());
        Iterator i$ = this.mOverlays.iterator();
        while (i$.hasNext()) {
            ((OverlayDisplayHandle) i$.next()).dumpLocked(pw);
        }
    }

    public void registerLocked() {
        super.registerLocked();
        getHandler().post(new C02111());
    }

    private void updateOverlayDisplayDevices() {
        synchronized (getSyncRoot()) {
            updateOverlayDisplayDevicesLocked();
        }
    }

    private void updateOverlayDisplayDevicesLocked() {
        String value = Global.getString(getContext().getContentResolver(), "overlay_display_devices");
        if (value == null) {
            value = "";
        }
        if (!value.equals(this.mCurrentOverlaySetting)) {
            this.mCurrentOverlaySetting = value;
            if (!this.mOverlays.isEmpty()) {
                Slog.i(TAG, "Dismissing all overlay display devices.");
                Iterator i$ = this.mOverlays.iterator();
                while (i$.hasNext()) {
                    ((OverlayDisplayHandle) i$.next()).dismissLocked();
                }
                this.mOverlays.clear();
            }
            int count = 0;
            for (String part : value.split(";")) {
                Matcher matcher = SETTING_PATTERN.matcher(part);
                if (!matcher.matches()) {
                    if (part.isEmpty()) {
                    }
                    Slog.w(TAG, "Malformed overlay display devices setting: " + value);
                } else if (count >= 4) {
                    Slog.w(TAG, "Too many overlay display devices specified: " + value);
                    return;
                } else {
                    try {
                        int width = Integer.parseInt(matcher.group(1), 10);
                        int height = Integer.parseInt(matcher.group(2), 10);
                        int densityDpi = Integer.parseInt(matcher.group(3), 10);
                        String flagString = matcher.group(4);
                        if (width >= MIN_WIDTH && width <= MAX_WIDTH && height >= MIN_WIDTH && height <= MAX_WIDTH && densityDpi >= 120 && densityDpi <= SystemService.PHASE_LOCK_SETTINGS_READY) {
                            count++;
                            int number = count;
                            String name = getContext().getResources().getString(17040881, new Object[]{Integer.valueOf(number)});
                            int gravity = chooseOverlayGravity(number);
                            boolean secure = (flagString == null || !flagString.contains(",secure")) ? DEBUG : true;
                            Slog.i(TAG, "Showing overlay display device #" + number + ": name=" + name + ", width=" + width + ", height=" + height + ", densityDpi=" + densityDpi + ", secure=" + secure);
                            this.mOverlays.add(new OverlayDisplayHandle(name, width, height, densityDpi, gravity, secure, number));
                        }
                    } catch (NumberFormatException e) {
                    }
                    Slog.w(TAG, "Malformed overlay display devices setting: " + value);
                }
            }
        }
    }

    private static int chooseOverlayGravity(int overlayNumber) {
        switch (overlayNumber) {
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                return 51;
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                return 85;
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
                return 53;
            default:
                return 83;
        }
    }
}
