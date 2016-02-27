package com.android.server.display;

import android.content.Context;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.SystemProperties;
import android.os.Trace;
import android.util.Slog;
import android.util.SparseArray;
import android.view.Display;
import android.view.DisplayEventReceiver;
import android.view.SurfaceControl;
import android.view.SurfaceControl.PhysicalDisplayInfo;
import com.android.server.display.DisplayAdapter.Listener;
import com.android.server.display.DisplayManagerService.SyncRoot;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.PrintWriter;
import java.util.Arrays;

final class LocalDisplayAdapter extends DisplayAdapter {
    private static final int[] BUILT_IN_DISPLAY_IDS_TO_SCAN;
    private static final String TAG = "LocalDisplayAdapter";
    private static final String UNIQUE_ID_PREFIX = "local:";
    private final SparseArray<LocalDisplayDevice> mDevices;
    private HotplugDisplayEventReceiver mHotplugReceiver;

    private final class HotplugDisplayEventReceiver extends DisplayEventReceiver {
        public HotplugDisplayEventReceiver(Looper looper) {
            super(looper);
        }

        public void onHotplug(long timestampNanos, int builtInDisplayId, boolean connected) {
            synchronized (LocalDisplayAdapter.this.getSyncRoot()) {
                if (connected) {
                    LocalDisplayAdapter.this.tryConnectDisplayLocked(builtInDisplayId);
                } else {
                    LocalDisplayAdapter.this.tryDisconnectDisplayLocked(builtInDisplayId);
                }
            }
        }
    }

    private final class LocalDisplayDevice extends DisplayDevice {
        private final int mBuiltInDisplayId;
        private final int mDefaultPhysicalDisplayInfo;
        private boolean mHavePendingChanges;
        private DisplayDeviceInfo mInfo;
        private float mLastRequestedRefreshRate;
        private final PhysicalDisplayInfo mPhys;
        private int[] mRefreshRateConfigIndices;
        private int mState;
        private float[] mSupportedRefreshRates;

        /* renamed from: com.android.server.display.LocalDisplayAdapter.LocalDisplayDevice.1 */
        class C02091 implements Runnable {
            final /* synthetic */ int val$displayId;
            final /* synthetic */ int val$mode;
            final /* synthetic */ int val$state;
            final /* synthetic */ IBinder val$token;

            C02091(int i, int i2, IBinder iBinder, int i3) {
                this.val$state = i;
                this.val$displayId = i2;
                this.val$token = iBinder;
                this.val$mode = i3;
            }

            public void run() {
                Trace.traceBegin(131072, "requestDisplayState(" + Display.stateToString(this.val$state) + ", id=" + this.val$displayId + ")");
                try {
                    SurfaceControl.setDisplayPowerMode(this.val$token, this.val$mode);
                } finally {
                    Trace.traceEnd(131072);
                }
            }
        }

        public LocalDisplayDevice(IBinder displayToken, int builtInDisplayId, PhysicalDisplayInfo[] physicalDisplayInfos, int activeDisplayInfo) {
            super(LocalDisplayAdapter.this, displayToken, LocalDisplayAdapter.UNIQUE_ID_PREFIX + builtInDisplayId);
            this.mState = 0;
            this.mBuiltInDisplayId = builtInDisplayId;
            this.mPhys = new PhysicalDisplayInfo(physicalDisplayInfos[activeDisplayInfo]);
            this.mDefaultPhysicalDisplayInfo = activeDisplayInfo;
            updateSupportedRefreshRatesLocked(physicalDisplayInfos, this.mPhys);
        }

        public boolean updatePhysicalDisplayInfoLocked(PhysicalDisplayInfo[] physicalDisplayInfos, int activeDisplayInfo) {
            PhysicalDisplayInfo newPhys = physicalDisplayInfos[activeDisplayInfo];
            if (this.mPhys.equals(newPhys)) {
                return false;
            }
            this.mPhys.copyFrom(newPhys);
            updateSupportedRefreshRatesLocked(physicalDisplayInfos, this.mPhys);
            this.mHavePendingChanges = true;
            return true;
        }

        public void applyPendingDisplayDeviceInfoChangesLocked() {
            if (this.mHavePendingChanges) {
                this.mInfo = null;
                this.mHavePendingChanges = false;
            }
        }

        public DisplayDeviceInfo getDisplayDeviceInfoLocked() {
            if (this.mInfo == null) {
                this.mInfo = new DisplayDeviceInfo();
                this.mInfo.width = this.mPhys.width;
                this.mInfo.height = this.mPhys.height;
                this.mInfo.refreshRate = this.mPhys.refreshRate;
                this.mInfo.supportedRefreshRates = this.mSupportedRefreshRates;
                this.mInfo.appVsyncOffsetNanos = this.mPhys.appVsyncOffsetNanos;
                this.mInfo.presentationDeadlineNanos = this.mPhys.presentationDeadlineNanos;
                this.mInfo.state = this.mState;
                this.mInfo.uniqueId = getUniqueId();
                if (this.mPhys.secure) {
                    this.mInfo.flags = 12;
                }
                DisplayDeviceInfo displayDeviceInfo;
                if (this.mBuiltInDisplayId == 0) {
                    this.mInfo.name = LocalDisplayAdapter.this.getContext().getResources().getString(17040879);
                    displayDeviceInfo = this.mInfo;
                    displayDeviceInfo.flags |= 3;
                    this.mInfo.type = 1;
                    this.mInfo.densityDpi = (int) ((this.mPhys.density * 160.0f) + 0.5f);
                    this.mInfo.xDpi = this.mPhys.xDpi;
                    this.mInfo.yDpi = this.mPhys.yDpi;
                    this.mInfo.touch = 1;
                } else {
                    this.mInfo.type = 2;
                    displayDeviceInfo = this.mInfo;
                    displayDeviceInfo.flags |= 64;
                    this.mInfo.name = LocalDisplayAdapter.this.getContext().getResources().getString(17040880);
                    this.mInfo.touch = 2;
                    this.mInfo.setAssumedDensityForExternalDisplay(this.mPhys.width, this.mPhys.height);
                    if ("portrait".equals(SystemProperties.get("persist.demo.hdmirotation"))) {
                        this.mInfo.rotation = 3;
                    }
                    if (SystemProperties.getBoolean("persist.demo.hdmirotates", false)) {
                        displayDeviceInfo = this.mInfo;
                        displayDeviceInfo.flags |= 2;
                    }
                }
            }
            return this.mInfo;
        }

        public Runnable requestDisplayStateLocked(int state) {
            if (this.mState == state) {
                return null;
            }
            int displayId = this.mBuiltInDisplayId;
            IBinder token = getDisplayTokenLocked();
            int mode = LocalDisplayAdapter.getPowerModeForState(state);
            this.mState = state;
            updateDeviceInfoLocked();
            return new C02091(state, displayId, token, mode);
        }

        public void requestRefreshRateLocked(float refreshRate) {
            if (this.mLastRequestedRefreshRate != refreshRate) {
                this.mLastRequestedRefreshRate = refreshRate;
                if (refreshRate != 0.0f) {
                    int N = this.mSupportedRefreshRates.length;
                    for (int i = 0; i < N; i++) {
                        if (refreshRate == this.mSupportedRefreshRates[i]) {
                            SurfaceControl.setActiveConfig(getDisplayTokenLocked(), this.mRefreshRateConfigIndices[i]);
                            return;
                        }
                    }
                    Slog.w(LocalDisplayAdapter.TAG, "Requested refresh rate " + refreshRate + " is unsupported.");
                }
                SurfaceControl.setActiveConfig(getDisplayTokenLocked(), this.mDefaultPhysicalDisplayInfo);
            }
        }

        public void dumpLocked(PrintWriter pw) {
            super.dumpLocked(pw);
            pw.println("mBuiltInDisplayId=" + this.mBuiltInDisplayId);
            pw.println("mPhys=" + this.mPhys);
            pw.println("mState=" + Display.stateToString(this.mState));
        }

        private void updateDeviceInfoLocked() {
            this.mInfo = null;
            LocalDisplayAdapter.this.sendDisplayDeviceEventLocked(this, 2);
        }

        private void updateSupportedRefreshRatesLocked(PhysicalDisplayInfo[] physicalDisplayInfos, PhysicalDisplayInfo activePhys) {
            int N = physicalDisplayInfos.length;
            this.mSupportedRefreshRates = new float[N];
            this.mRefreshRateConfigIndices = new int[N];
            int i = 0;
            int idx = 0;
            while (i < N) {
                int idx2;
                PhysicalDisplayInfo phys = physicalDisplayInfos[i];
                if (activePhys.width == phys.width && activePhys.height == phys.height && activePhys.density == phys.density && activePhys.xDpi == phys.xDpi && activePhys.yDpi == phys.yDpi) {
                    this.mSupportedRefreshRates[idx] = phys.refreshRate;
                    idx2 = idx + 1;
                    this.mRefreshRateConfigIndices[idx] = i;
                } else {
                    idx2 = idx;
                }
                i++;
                idx = idx2;
            }
            if (idx != N) {
                this.mSupportedRefreshRates = Arrays.copyOfRange(this.mSupportedRefreshRates, 0, idx);
                this.mRefreshRateConfigIndices = Arrays.copyOfRange(this.mRefreshRateConfigIndices, 0, idx);
            }
        }
    }

    static {
        BUILT_IN_DISPLAY_IDS_TO_SCAN = new int[]{0, 1};
    }

    public LocalDisplayAdapter(SyncRoot syncRoot, Context context, Handler handler, Listener listener) {
        super(syncRoot, context, handler, listener, TAG);
        this.mDevices = new SparseArray();
    }

    public void registerLocked() {
        super.registerLocked();
        this.mHotplugReceiver = new HotplugDisplayEventReceiver(getHandler().getLooper());
        for (int builtInDisplayId : BUILT_IN_DISPLAY_IDS_TO_SCAN) {
            tryConnectDisplayLocked(builtInDisplayId);
        }
    }

    private void tryConnectDisplayLocked(int builtInDisplayId) {
        IBinder displayToken = SurfaceControl.getBuiltInDisplay(builtInDisplayId);
        if (displayToken != null) {
            PhysicalDisplayInfo[] configs = SurfaceControl.getDisplayConfigs(displayToken);
            if (configs == null) {
                Slog.w(TAG, "No valid configs found for display device " + builtInDisplayId);
                return;
            }
            int activeConfig = SurfaceControl.getActiveConfig(displayToken);
            if (activeConfig < 0) {
                Slog.w(TAG, "No active config found for display device " + builtInDisplayId);
                return;
            }
            LocalDisplayDevice device = (LocalDisplayDevice) this.mDevices.get(builtInDisplayId);
            if (device == null) {
                device = new LocalDisplayDevice(displayToken, builtInDisplayId, configs, activeConfig);
                this.mDevices.put(builtInDisplayId, device);
                sendDisplayDeviceEventLocked(device, 1);
            } else if (device.updatePhysicalDisplayInfoLocked(configs, activeConfig)) {
                sendDisplayDeviceEventLocked(device, 2);
            }
        }
    }

    private void tryDisconnectDisplayLocked(int builtInDisplayId) {
        LocalDisplayDevice device = (LocalDisplayDevice) this.mDevices.get(builtInDisplayId);
        if (device != null) {
            this.mDevices.remove(builtInDisplayId);
            sendDisplayDeviceEventLocked(device, 3);
        }
    }

    static int getPowerModeForState(int state) {
        switch (state) {
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                return 0;
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
                return 1;
            case C0569H.DO_TRAVERSAL /*4*/:
                return 3;
            default:
                return 2;
        }
    }
}
