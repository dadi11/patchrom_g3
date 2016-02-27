package com.android.server.display;

import android.content.Context;
import android.hardware.SensorManager;
import android.hardware.display.DisplayManagerInternal;
import android.hardware.display.DisplayManagerInternal.DisplayPowerCallbacks;
import android.hardware.display.DisplayManagerInternal.DisplayPowerRequest;
import android.hardware.display.DisplayManagerInternal.DisplayTransactionListener;
import android.hardware.display.DisplayViewport;
import android.hardware.display.IDisplayManager.Stub;
import android.hardware.display.IDisplayManagerCallback;
import android.hardware.display.IVirtualDisplayCallback;
import android.hardware.display.WifiDisplayStatus;
import android.hardware.input.InputManagerInternal;
import android.media.projection.IMediaProjection;
import android.media.projection.IMediaProjectionManager;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.Process;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemProperties;
import android.text.TextUtils;
import android.util.Slog;
import android.util.SparseArray;
import android.view.Display;
import android.view.DisplayInfo;
import android.view.Surface;
import android.view.WindowManagerInternal;
import com.android.internal.util.IndentingPrintWriter;
import com.android.server.DisplayThread;
import com.android.server.LocalServices;
import com.android.server.SystemService;
import com.android.server.UiThread;
import com.android.server.display.DisplayAdapter.Listener;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public final class DisplayManagerService extends SystemService {
    private static final boolean DEBUG = false;
    private static final String FORCE_WIFI_DISPLAY_ENABLE = "persist.debug.wfd.enable";
    private static final int MSG_DELIVER_DISPLAY_EVENT = 3;
    private static final int MSG_REGISTER_ADDITIONAL_DISPLAY_ADAPTERS = 2;
    private static final int MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER = 1;
    private static final int MSG_REQUEST_TRAVERSAL = 4;
    private static final int MSG_UPDATE_VIEWPORT = 5;
    private static final String TAG = "DisplayManagerService";
    private static final long WAIT_FOR_DEFAULT_DISPLAY_TIMEOUT = 10000;
    public final SparseArray<CallbackRecord> mCallbacks;
    private final Context mContext;
    private final DisplayViewport mDefaultViewport;
    private final DisplayAdapterListener mDisplayAdapterListener;
    private final ArrayList<DisplayAdapter> mDisplayAdapters;
    private final ArrayList<DisplayDevice> mDisplayDevices;
    private DisplayPowerController mDisplayPowerController;
    private final CopyOnWriteArrayList<DisplayTransactionListener> mDisplayTransactionListeners;
    private final DisplayViewport mExternalTouchViewport;
    private int mGlobalDisplayState;
    private final DisplayManagerHandler mHandler;
    private InputManagerInternal mInputManagerInternal;
    private final SparseArray<LogicalDisplay> mLogicalDisplays;
    private int mNextNonDefaultDisplayId;
    public boolean mOnlyCore;
    private boolean mPendingTraversal;
    private final PersistentDataStore mPersistentDataStore;
    private IMediaProjectionManager mProjectionService;
    public boolean mSafeMode;
    private final boolean mSingleDisplayDemoMode;
    private final SyncRoot mSyncRoot;
    private final ArrayList<CallbackRecord> mTempCallbacks;
    private final DisplayViewport mTempDefaultViewport;
    private final DisplayInfo mTempDisplayInfo;
    private final ArrayList<Runnable> mTempDisplayStateWorkQueue;
    private final DisplayViewport mTempExternalTouchViewport;
    private final Handler mUiHandler;
    private VirtualDisplayAdapter mVirtualDisplayAdapter;
    private WifiDisplayAdapter mWifiDisplayAdapter;
    private int mWifiDisplayScanRequestCount;
    private WindowManagerInternal mWindowManagerInternal;

    private final class BinderService extends Stub {
        private BinderService() {
        }

        public DisplayInfo getDisplayInfo(int displayId) {
            int callingUid = Binder.getCallingUid();
            long token = Binder.clearCallingIdentity();
            try {
                DisplayInfo access$1800 = DisplayManagerService.this.getDisplayInfoInternal(displayId, callingUid);
                return access$1800;
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public int[] getDisplayIds() {
            int callingUid = Binder.getCallingUid();
            long token = Binder.clearCallingIdentity();
            try {
                int[] access$1900 = DisplayManagerService.this.getDisplayIdsInternal(callingUid);
                return access$1900;
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void registerCallback(IDisplayManagerCallback callback) {
            if (callback == null) {
                throw new IllegalArgumentException("listener must not be null");
            }
            int callingPid = Binder.getCallingPid();
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.registerCallbackInternal(callback, callingPid);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void startWifiDisplayScan() {
            DisplayManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.CONFIGURE_WIFI_DISPLAY", "Permission required to start wifi display scans");
            int callingPid = Binder.getCallingPid();
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.startWifiDisplayScanInternal(callingPid);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void stopWifiDisplayScan() {
            DisplayManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.CONFIGURE_WIFI_DISPLAY", "Permission required to stop wifi display scans");
            int callingPid = Binder.getCallingPid();
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.stopWifiDisplayScanInternal(callingPid);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void connectWifiDisplay(String address) {
            if (address == null) {
                throw new IllegalArgumentException("address must not be null");
            }
            DisplayManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.CONFIGURE_WIFI_DISPLAY", "Permission required to connect to a wifi display");
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.connectWifiDisplayInternal(address);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void disconnectWifiDisplay() {
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.disconnectWifiDisplayInternal();
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void renameWifiDisplay(String address, String alias) {
            if (address == null) {
                throw new IllegalArgumentException("address must not be null");
            }
            DisplayManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.CONFIGURE_WIFI_DISPLAY", "Permission required to rename to a wifi display");
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.renameWifiDisplayInternal(address, alias);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void forgetWifiDisplay(String address) {
            if (address == null) {
                throw new IllegalArgumentException("address must not be null");
            }
            DisplayManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.CONFIGURE_WIFI_DISPLAY", "Permission required to forget to a wifi display");
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.forgetWifiDisplayInternal(address);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void pauseWifiDisplay() {
            DisplayManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.CONFIGURE_WIFI_DISPLAY", "Permission required to pause a wifi display session");
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.pauseWifiDisplayInternal();
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void resumeWifiDisplay() {
            DisplayManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.CONFIGURE_WIFI_DISPLAY", "Permission required to resume a wifi display session");
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.resumeWifiDisplayInternal();
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public WifiDisplayStatus getWifiDisplayStatus() {
            long token = Binder.clearCallingIdentity();
            try {
                WifiDisplayStatus access$3000 = DisplayManagerService.this.getWifiDisplayStatusInternal();
                return access$3000;
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public int createVirtualDisplay(IVirtualDisplayCallback callback, IMediaProjection projection, String packageName, String name, int width, int height, int densityDpi, Surface surface, int flags) {
            int callingUid = Binder.getCallingUid();
            if (!validatePackageName(callingUid, packageName)) {
                throw new SecurityException("packageName must match the calling uid");
            } else if (callback == null) {
                throw new IllegalArgumentException("appToken must not be null");
            } else if (TextUtils.isEmpty(name)) {
                throw new IllegalArgumentException("name must be non-null and non-empty");
            } else if (width <= 0 || height <= 0 || densityDpi <= 0) {
                throw new IllegalArgumentException("width, height, and densityDpi must be greater than 0");
            } else {
                if ((flags & DisplayManagerService.MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) != 0) {
                    flags |= 16;
                }
                if ((flags & 8) != 0) {
                    flags &= -17;
                }
                if (projection != null) {
                    try {
                        if (DisplayManagerService.this.getProjectionService().isValidMediaProjection(projection)) {
                            flags = projection.applyVirtualDisplayFlags(flags);
                        } else {
                            throw new SecurityException("Invalid media projection");
                        }
                    } catch (RemoteException e) {
                        throw new SecurityException("unable to validate media projection or flags");
                    }
                }
                if (callingUid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && (flags & 16) != 0 && !canProjectVideo(projection)) {
                    throw new SecurityException("Requires CAPTURE_VIDEO_OUTPUT or CAPTURE_SECURE_VIDEO_OUTPUT permission, or an appropriate MediaProjection token in order to create a screen sharing virtual display.");
                } else if ((flags & DisplayManagerService.MSG_REQUEST_TRAVERSAL) == 0 || canProjectSecureVideo(projection)) {
                    long token = Binder.clearCallingIdentity();
                    try {
                        int access$3200 = DisplayManagerService.this.createVirtualDisplayInternal(callback, projection, callingUid, packageName, name, width, height, densityDpi, surface, flags);
                        return access$3200;
                    } finally {
                        Binder.restoreCallingIdentity(token);
                    }
                } else {
                    throw new SecurityException("Requires CAPTURE_SECURE_VIDEO_OUTPUT or an appropriate MediaProjection token to create a secure virtual display.");
                }
            }
        }

        public void resizeVirtualDisplay(IVirtualDisplayCallback callback, int width, int height, int densityDpi) {
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.resizeVirtualDisplayInternal(callback.asBinder(), width, height, densityDpi);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void setVirtualDisplaySurface(IVirtualDisplayCallback callback, Surface surface) {
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.setVirtualDisplaySurfaceInternal(callback.asBinder(), surface);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void releaseVirtualDisplay(IVirtualDisplayCallback callback) {
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.releaseVirtualDisplayInternal(callback.asBinder());
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (DisplayManagerService.this.mContext == null || DisplayManagerService.this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump DisplayManager from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
                return;
            }
            long token = Binder.clearCallingIdentity();
            try {
                DisplayManagerService.this.dumpInternal(pw);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        private boolean validatePackageName(int uid, String packageName) {
            if (packageName != null) {
                String[] packageNames = DisplayManagerService.this.mContext.getPackageManager().getPackagesForUid(uid);
                if (packageNames != null) {
                    String[] arr$ = packageNames;
                    int len$ = arr$.length;
                    for (int i$ = 0; i$ < len$; i$ += DisplayManagerService.MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
                        if (arr$[i$].equals(packageName)) {
                            return true;
                        }
                    }
                }
            }
            return DisplayManagerService.DEBUG;
        }

        private boolean canProjectVideo(IMediaProjection projection) {
            if (projection != null) {
                try {
                    if (projection.canProjectVideo()) {
                        return true;
                    }
                } catch (RemoteException e) {
                    Slog.e(DisplayManagerService.TAG, "Unable to query projection service for permissions", e);
                }
            }
            if (DisplayManagerService.this.mContext.checkCallingPermission("android.permission.CAPTURE_VIDEO_OUTPUT") != 0) {
                return canProjectSecureVideo(projection);
            }
            return true;
        }

        private boolean canProjectSecureVideo(IMediaProjection projection) {
            if (projection != null) {
                try {
                    if (projection.canProjectSecureVideo()) {
                        return true;
                    }
                } catch (RemoteException e) {
                    Slog.e(DisplayManagerService.TAG, "Unable to query projection service for permissions", e);
                }
            }
            if (DisplayManagerService.this.mContext.checkCallingPermission("android.permission.CAPTURE_SECURE_VIDEO_OUTPUT") != 0) {
                return DisplayManagerService.DEBUG;
            }
            return true;
        }
    }

    private final class CallbackRecord implements DeathRecipient {
        private final IDisplayManagerCallback mCallback;
        public final int mPid;
        public boolean mWifiDisplayScanRequested;

        public CallbackRecord(int pid, IDisplayManagerCallback callback) {
            this.mPid = pid;
            this.mCallback = callback;
        }

        public void binderDied() {
            DisplayManagerService.this.onCallbackDied(this);
        }

        public void notifyDisplayEventAsync(int displayId, int event) {
            try {
                this.mCallback.onDisplayEvent(displayId, event);
            } catch (RemoteException ex) {
                Slog.w(DisplayManagerService.TAG, "Failed to notify process " + this.mPid + " that displays changed, assuming it died.", ex);
                binderDied();
            }
        }
    }

    private final class DisplayAdapterListener implements Listener {
        private DisplayAdapterListener() {
        }

        public void onDisplayDeviceEvent(DisplayDevice device, int event) {
            switch (event) {
                case DisplayManagerService.MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER /*1*/:
                    DisplayManagerService.this.handleDisplayDeviceAdded(device);
                case DisplayManagerService.MSG_REGISTER_ADDITIONAL_DISPLAY_ADAPTERS /*2*/:
                    DisplayManagerService.this.handleDisplayDeviceChanged(device);
                case DisplayManagerService.MSG_DELIVER_DISPLAY_EVENT /*3*/:
                    DisplayManagerService.this.handleDisplayDeviceRemoved(device);
                default:
            }
        }

        public void onTraversalRequested() {
            synchronized (DisplayManagerService.this.mSyncRoot) {
                DisplayManagerService.this.scheduleTraversalLocked(DisplayManagerService.DEBUG);
            }
        }
    }

    private final class DisplayManagerHandler extends Handler {
        public DisplayManagerHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case DisplayManagerService.MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER /*1*/:
                    DisplayManagerService.this.registerDefaultDisplayAdapter();
                case DisplayManagerService.MSG_REGISTER_ADDITIONAL_DISPLAY_ADAPTERS /*2*/:
                    DisplayManagerService.this.registerAdditionalDisplayAdapters();
                case DisplayManagerService.MSG_DELIVER_DISPLAY_EVENT /*3*/:
                    DisplayManagerService.this.deliverDisplayEvent(msg.arg1, msg.arg2);
                case DisplayManagerService.MSG_REQUEST_TRAVERSAL /*4*/:
                    DisplayManagerService.this.mWindowManagerInternal.requestTraversalFromDisplayManager();
                case DisplayManagerService.MSG_UPDATE_VIEWPORT /*5*/:
                    synchronized (DisplayManagerService.this.mSyncRoot) {
                        DisplayManagerService.this.mTempDefaultViewport.copyFrom(DisplayManagerService.this.mDefaultViewport);
                        DisplayManagerService.this.mTempExternalTouchViewport.copyFrom(DisplayManagerService.this.mExternalTouchViewport);
                        break;
                    }
                    DisplayManagerService.this.mInputManagerInternal.setDisplayViewports(DisplayManagerService.this.mTempDefaultViewport, DisplayManagerService.this.mTempExternalTouchViewport);
                default:
            }
        }
    }

    private final class LocalService extends DisplayManagerInternal {

        /* renamed from: com.android.server.display.DisplayManagerService.LocalService.1 */
        class C01961 implements DisplayBlanker {
            final /* synthetic */ DisplayPowerCallbacks val$callbacks;

            C01961(DisplayPowerCallbacks displayPowerCallbacks) {
                this.val$callbacks = displayPowerCallbacks;
            }

            public void requestDisplayState(int state) {
                if (state == DisplayManagerService.MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
                    DisplayManagerService.this.requestGlobalDisplayStateInternal(state);
                }
                this.val$callbacks.onDisplayStateChange(state);
                if (state != DisplayManagerService.MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
                    DisplayManagerService.this.requestGlobalDisplayStateInternal(state);
                }
            }
        }

        private LocalService() {
        }

        public void initPowerManagement(DisplayPowerCallbacks callbacks, Handler handler, SensorManager sensorManager) {
            synchronized (DisplayManagerService.this.mSyncRoot) {
                DisplayManagerService.this.mDisplayPowerController = new DisplayPowerController(DisplayManagerService.this.mContext, callbacks, handler, sensorManager, new C01961(callbacks));
            }
        }

        public boolean requestPowerState(DisplayPowerRequest request, boolean waitForNegativeProximity) {
            return DisplayManagerService.this.mDisplayPowerController.requestPowerState(request, waitForNegativeProximity);
        }

        public boolean isProximitySensorAvailable() {
            return DisplayManagerService.this.mDisplayPowerController.isProximitySensorAvailable();
        }

        public DisplayInfo getDisplayInfo(int displayId) {
            return DisplayManagerService.this.getDisplayInfoInternal(displayId, Process.myUid());
        }

        public void registerDisplayTransactionListener(DisplayTransactionListener listener) {
            if (listener == null) {
                throw new IllegalArgumentException("listener must not be null");
            }
            DisplayManagerService.this.registerDisplayTransactionListenerInternal(listener);
        }

        public void unregisterDisplayTransactionListener(DisplayTransactionListener listener) {
            if (listener == null) {
                throw new IllegalArgumentException("listener must not be null");
            }
            DisplayManagerService.this.unregisterDisplayTransactionListenerInternal(listener);
        }

        public void setDisplayInfoOverrideFromWindowManager(int displayId, DisplayInfo info) {
            DisplayManagerService.this.setDisplayInfoOverrideFromWindowManagerInternal(displayId, info);
        }

        public void performTraversalInTransactionFromWindowManager() {
            DisplayManagerService.this.performTraversalInTransactionFromWindowManagerInternal();
        }

        public void setDisplayProperties(int displayId, boolean hasContent, float requestedRefreshRate, boolean inTraversal) {
            DisplayManagerService.this.setDisplayPropertiesInternal(displayId, hasContent, requestedRefreshRate, inTraversal);
        }
    }

    public static final class SyncRoot {
    }

    private void requestGlobalDisplayStateInternal(int r5) {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxRuntimeException: Can't find immediate dominator for block B:27:0x002d in {8, 15, 17, 19, 22, 25, 26, 28} preds:[]
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeDominators(BlockProcessor.java:129)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.processBlocksTree(BlockProcessor.java:48)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.rerun(BlockProcessor.java:44)
	at jadx.core.dex.visitors.blocksmaker.BlockFinallyExtract.visit(BlockFinallyExtract.java:57)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.core.ProcessClass.processDependencies(ProcessClass.java:59)
	at jadx.core.ProcessClass.process(ProcessClass.java:42)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
        /*
        r4 = this;
        r2 = r4.mTempDisplayStateWorkQueue;
        monitor-enter(r2);
        r3 = r4.mSyncRoot;	 Catch:{ all -> 0x0030 }
        monitor-enter(r3);	 Catch:{ all -> 0x0030 }
        r1 = r4.mGlobalDisplayState;	 Catch:{ all -> 0x0030 }
        if (r1 == r5) goto L_0x0015;	 Catch:{ all -> 0x0030 }
    L_0x000a:
        r4.mGlobalDisplayState = r5;	 Catch:{ all -> 0x0030 }
        r1 = r4.mTempDisplayStateWorkQueue;	 Catch:{ all -> 0x0030 }
        r4.updateGlobalDisplayStateLocked(r1);	 Catch:{ all -> 0x0030 }
        r1 = 0;	 Catch:{ all -> 0x0030 }
        r4.scheduleTraversalLocked(r1);	 Catch:{ all -> 0x0030 }
    L_0x0015:
        monitor-exit(r3);	 Catch:{ all -> 0x0030 }
        r0 = 0;
    L_0x0017:
        r1 = r4.mTempDisplayStateWorkQueue;	 Catch:{ all -> 0x0030 }
        r1 = r1.size();	 Catch:{ all -> 0x0030 }
        if (r0 >= r1) goto L_0x003a;	 Catch:{ all -> 0x0030 }
    L_0x001f:
        r1 = r4.mTempDisplayStateWorkQueue;	 Catch:{ all -> 0x0030 }
        r1 = r1.get(r0);	 Catch:{ all -> 0x0030 }
        r1 = (java.lang.Runnable) r1;	 Catch:{ all -> 0x0030 }
        r1.run();	 Catch:{ all -> 0x0030 }
        r0 = r0 + 1;
        goto L_0x0017;
    L_0x002d:
        r1 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0030 }
        throw r1;	 Catch:{ all -> 0x0030 }
    L_0x0030:
        r1 = move-exception;
        r3 = r4.mTempDisplayStateWorkQueue;
        r3.clear();
        throw r1;
    L_0x0037:
        r1 = move-exception;
        monitor-exit(r2);
        throw r1;
    L_0x003a:
        r1 = r4.mTempDisplayStateWorkQueue;
        r1.clear();
        monitor-exit(r2);
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.display.DisplayManagerService.requestGlobalDisplayStateInternal(int):void");
    }

    public DisplayManagerService(Context context) {
        super(context);
        this.mSyncRoot = new SyncRoot();
        this.mCallbacks = new SparseArray();
        this.mDisplayAdapters = new ArrayList();
        this.mDisplayDevices = new ArrayList();
        this.mLogicalDisplays = new SparseArray();
        this.mNextNonDefaultDisplayId = MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER;
        this.mDisplayTransactionListeners = new CopyOnWriteArrayList();
        this.mGlobalDisplayState = 0;
        this.mDefaultViewport = new DisplayViewport();
        this.mExternalTouchViewport = new DisplayViewport();
        this.mPersistentDataStore = new PersistentDataStore();
        this.mTempCallbacks = new ArrayList();
        this.mTempDisplayInfo = new DisplayInfo();
        this.mTempDefaultViewport = new DisplayViewport();
        this.mTempExternalTouchViewport = new DisplayViewport();
        this.mTempDisplayStateWorkQueue = new ArrayList();
        this.mContext = context;
        this.mHandler = new DisplayManagerHandler(DisplayThread.get().getLooper());
        this.mUiHandler = UiThread.getHandler();
        this.mDisplayAdapterListener = new DisplayAdapterListener();
        this.mSingleDisplayDemoMode = SystemProperties.getBoolean("persist.demo.singledisplay", DEBUG);
    }

    public void onStart() {
        this.mHandler.sendEmptyMessage(MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER);
        publishBinderService("display", new BinderService(), true);
        publishLocalService(DisplayManagerInternal.class, new LocalService());
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void onBootPhase(int r11) {
        /*
        r10 = this;
        r4 = 100;
        if (r11 != r4) goto L_0x0038;
    L_0x0004:
        r5 = r10.mSyncRoot;
        monitor-enter(r5);
        r6 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x002c }
        r8 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r2 = r6 + r8;
    L_0x000f:
        r4 = r10.mLogicalDisplays;	 Catch:{ all -> 0x002c }
        r6 = 0;
        r4 = r4.get(r6);	 Catch:{ all -> 0x002c }
        if (r4 != 0) goto L_0x0037;
    L_0x0018:
        r6 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x002c }
        r0 = r2 - r6;
        r6 = 0;
        r4 = (r0 > r6 ? 1 : (r0 == r6 ? 0 : -1));
        if (r4 > 0) goto L_0x002f;
    L_0x0024:
        r4 = new java.lang.RuntimeException;	 Catch:{ all -> 0x002c }
        r6 = "Timeout waiting for default display to be initialized.";
        r4.<init>(r6);	 Catch:{ all -> 0x002c }
        throw r4;	 Catch:{ all -> 0x002c }
    L_0x002c:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x002c }
        throw r4;
    L_0x002f:
        r4 = r10.mSyncRoot;	 Catch:{ InterruptedException -> 0x0035 }
        r4.wait(r0);	 Catch:{ InterruptedException -> 0x0035 }
        goto L_0x000f;
    L_0x0035:
        r4 = move-exception;
        goto L_0x000f;
    L_0x0037:
        monitor-exit(r5);	 Catch:{ all -> 0x002c }
    L_0x0038:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.display.DisplayManagerService.onBootPhase(int):void");
    }

    public void windowManagerAndInputReady() {
        synchronized (this.mSyncRoot) {
            this.mWindowManagerInternal = (WindowManagerInternal) LocalServices.getService(WindowManagerInternal.class);
            this.mInputManagerInternal = (InputManagerInternal) LocalServices.getService(InputManagerInternal.class);
            scheduleTraversalLocked(DEBUG);
        }
    }

    public void systemReady(boolean safeMode, boolean onlyCore) {
        synchronized (this.mSyncRoot) {
            this.mSafeMode = safeMode;
            this.mOnlyCore = onlyCore;
        }
        this.mHandler.sendEmptyMessage(MSG_REGISTER_ADDITIONAL_DISPLAY_ADAPTERS);
    }

    private void registerDisplayTransactionListenerInternal(DisplayTransactionListener listener) {
        this.mDisplayTransactionListeners.add(listener);
    }

    private void unregisterDisplayTransactionListenerInternal(DisplayTransactionListener listener) {
        this.mDisplayTransactionListeners.remove(listener);
    }

    private void setDisplayInfoOverrideFromWindowManagerInternal(int displayId, DisplayInfo info) {
        synchronized (this.mSyncRoot) {
            LogicalDisplay display = (LogicalDisplay) this.mLogicalDisplays.get(displayId);
            if (display != null && display.setDisplayInfoOverrideFromWindowManagerLocked(info)) {
                sendDisplayEventLocked(displayId, MSG_REGISTER_ADDITIONAL_DISPLAY_ADAPTERS);
                scheduleTraversalLocked(DEBUG);
            }
        }
    }

    private void performTraversalInTransactionFromWindowManagerInternal() {
        synchronized (this.mSyncRoot) {
            if (this.mPendingTraversal) {
                this.mPendingTraversal = DEBUG;
                performTraversalInTransactionLocked();
                Iterator i$ = this.mDisplayTransactionListeners.iterator();
                while (i$.hasNext()) {
                    ((DisplayTransactionListener) i$.next()).onDisplayTransaction();
                }
                return;
            }
        }
    }

    private DisplayInfo getDisplayInfoInternal(int displayId, int callingUid) {
        DisplayInfo info;
        synchronized (this.mSyncRoot) {
            LogicalDisplay display = (LogicalDisplay) this.mLogicalDisplays.get(displayId);
            if (display != null) {
                info = display.getDisplayInfoLocked();
                if (info.hasAccess(callingUid)) {
                }
            }
            info = null;
        }
        return info;
    }

    private int[] getDisplayIdsInternal(int callingUid) {
        int[] displayIds;
        synchronized (this.mSyncRoot) {
            int count = this.mLogicalDisplays.size();
            displayIds = new int[count];
            int i = 0;
            int n = 0;
            while (i < count) {
                int n2;
                if (((LogicalDisplay) this.mLogicalDisplays.valueAt(i)).getDisplayInfoLocked().hasAccess(callingUid)) {
                    n2 = n + MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER;
                    displayIds[n] = this.mLogicalDisplays.keyAt(i);
                } else {
                    n2 = n;
                }
                i += MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER;
                n = n2;
            }
            if (n != count) {
                displayIds = Arrays.copyOfRange(displayIds, 0, n);
            }
        }
        return displayIds;
    }

    private void registerCallbackInternal(IDisplayManagerCallback callback, int callingPid) {
        synchronized (this.mSyncRoot) {
            if (this.mCallbacks.get(callingPid) != null) {
                throw new SecurityException("The calling process has already registered an IDisplayManagerCallback.");
            }
            CallbackRecord record = new CallbackRecord(callingPid, callback);
            try {
                callback.asBinder().linkToDeath(record, 0);
                this.mCallbacks.put(callingPid, record);
            } catch (RemoteException ex) {
                throw new RuntimeException(ex);
            }
        }
    }

    private void onCallbackDied(CallbackRecord record) {
        synchronized (this.mSyncRoot) {
            this.mCallbacks.remove(record.mPid);
            stopWifiDisplayScanLocked(record);
        }
    }

    private void startWifiDisplayScanInternal(int callingPid) {
        synchronized (this.mSyncRoot) {
            CallbackRecord record = (CallbackRecord) this.mCallbacks.get(callingPid);
            if (record == null) {
                throw new IllegalStateException("The calling process has not registered an IDisplayManagerCallback.");
            }
            startWifiDisplayScanLocked(record);
        }
    }

    private void startWifiDisplayScanLocked(CallbackRecord record) {
        if (!record.mWifiDisplayScanRequested) {
            record.mWifiDisplayScanRequested = true;
            int i = this.mWifiDisplayScanRequestCount;
            this.mWifiDisplayScanRequestCount = i + MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER;
            if (i == 0 && this.mWifiDisplayAdapter != null) {
                this.mWifiDisplayAdapter.requestStartScanLocked();
            }
        }
    }

    private void stopWifiDisplayScanInternal(int callingPid) {
        synchronized (this.mSyncRoot) {
            CallbackRecord record = (CallbackRecord) this.mCallbacks.get(callingPid);
            if (record == null) {
                throw new IllegalStateException("The calling process has not registered an IDisplayManagerCallback.");
            }
            stopWifiDisplayScanLocked(record);
        }
    }

    private void stopWifiDisplayScanLocked(CallbackRecord record) {
        if (record.mWifiDisplayScanRequested) {
            record.mWifiDisplayScanRequested = DEBUG;
            int i = this.mWifiDisplayScanRequestCount - 1;
            this.mWifiDisplayScanRequestCount = i;
            if (i == 0) {
                if (this.mWifiDisplayAdapter != null) {
                    this.mWifiDisplayAdapter.requestStopScanLocked();
                }
            } else if (this.mWifiDisplayScanRequestCount < 0) {
                Slog.wtf(TAG, "mWifiDisplayScanRequestCount became negative: " + this.mWifiDisplayScanRequestCount);
                this.mWifiDisplayScanRequestCount = 0;
            }
        }
    }

    private void connectWifiDisplayInternal(String address) {
        synchronized (this.mSyncRoot) {
            if (this.mWifiDisplayAdapter != null) {
                this.mWifiDisplayAdapter.requestConnectLocked(address);
            }
        }
    }

    private void pauseWifiDisplayInternal() {
        synchronized (this.mSyncRoot) {
            if (this.mWifiDisplayAdapter != null) {
                this.mWifiDisplayAdapter.requestPauseLocked();
            }
        }
    }

    private void resumeWifiDisplayInternal() {
        synchronized (this.mSyncRoot) {
            if (this.mWifiDisplayAdapter != null) {
                this.mWifiDisplayAdapter.requestResumeLocked();
            }
        }
    }

    private void disconnectWifiDisplayInternal() {
        synchronized (this.mSyncRoot) {
            if (this.mWifiDisplayAdapter != null) {
                this.mWifiDisplayAdapter.requestDisconnectLocked();
            }
        }
    }

    private void renameWifiDisplayInternal(String address, String alias) {
        synchronized (this.mSyncRoot) {
            if (this.mWifiDisplayAdapter != null) {
                this.mWifiDisplayAdapter.requestRenameLocked(address, alias);
            }
        }
    }

    private void forgetWifiDisplayInternal(String address) {
        synchronized (this.mSyncRoot) {
            if (this.mWifiDisplayAdapter != null) {
                this.mWifiDisplayAdapter.requestForgetLocked(address);
            }
        }
    }

    private WifiDisplayStatus getWifiDisplayStatusInternal() {
        WifiDisplayStatus wifiDisplayStatusLocked;
        synchronized (this.mSyncRoot) {
            if (this.mWifiDisplayAdapter != null) {
                wifiDisplayStatusLocked = this.mWifiDisplayAdapter.getWifiDisplayStatusLocked();
            } else {
                wifiDisplayStatusLocked = new WifiDisplayStatus();
            }
        }
        return wifiDisplayStatusLocked;
    }

    private int createVirtualDisplayInternal(IVirtualDisplayCallback callback, IMediaProjection projection, int callingUid, String packageName, String name, int width, int height, int densityDpi, Surface surface, int flags) {
        synchronized (this.mSyncRoot) {
            if (this.mVirtualDisplayAdapter == null) {
                Slog.w(TAG, "Rejecting request to create private virtual display because the virtual display adapter is not available.");
                return -1;
            }
            DisplayDevice device = this.mVirtualDisplayAdapter.createVirtualDisplayLocked(callback, projection, callingUid, packageName, name, width, height, densityDpi, surface, flags);
            if (device == null) {
                return -1;
            }
            handleDisplayDeviceAddedLocked(device);
            LogicalDisplay display = findLogicalDisplayForDeviceLocked(device);
            if (display != null) {
                int displayIdLocked = display.getDisplayIdLocked();
                return displayIdLocked;
            }
            Slog.w(TAG, "Rejecting request to create virtual display because the logical display was not created.");
            this.mVirtualDisplayAdapter.releaseVirtualDisplayLocked(callback.asBinder());
            handleDisplayDeviceRemovedLocked(device);
            return -1;
        }
    }

    private void resizeVirtualDisplayInternal(IBinder appToken, int width, int height, int densityDpi) {
        synchronized (this.mSyncRoot) {
            if (this.mVirtualDisplayAdapter == null) {
                return;
            }
            this.mVirtualDisplayAdapter.resizeVirtualDisplayLocked(appToken, width, height, densityDpi);
        }
    }

    private void setVirtualDisplaySurfaceInternal(IBinder appToken, Surface surface) {
        synchronized (this.mSyncRoot) {
            if (this.mVirtualDisplayAdapter == null) {
                return;
            }
            this.mVirtualDisplayAdapter.setVirtualDisplaySurfaceLocked(appToken, surface);
        }
    }

    private void releaseVirtualDisplayInternal(IBinder appToken) {
        synchronized (this.mSyncRoot) {
            if (this.mVirtualDisplayAdapter == null) {
                return;
            }
            DisplayDevice device = this.mVirtualDisplayAdapter.releaseVirtualDisplayLocked(appToken);
            if (device != null) {
                handleDisplayDeviceRemovedLocked(device);
            }
        }
    }

    private void registerDefaultDisplayAdapter() {
        synchronized (this.mSyncRoot) {
            registerDisplayAdapterLocked(new LocalDisplayAdapter(this.mSyncRoot, this.mContext, this.mHandler, this.mDisplayAdapterListener));
        }
    }

    private void registerAdditionalDisplayAdapters() {
        synchronized (this.mSyncRoot) {
            if (shouldRegisterNonEssentialDisplayAdaptersLocked()) {
                registerOverlayDisplayAdapterLocked();
                registerWifiDisplayAdapterLocked();
                registerVirtualDisplayAdapterLocked();
            }
        }
    }

    private void registerOverlayDisplayAdapterLocked() {
        registerDisplayAdapterLocked(new OverlayDisplayAdapter(this.mSyncRoot, this.mContext, this.mHandler, this.mDisplayAdapterListener, this.mUiHandler));
    }

    private void registerWifiDisplayAdapterLocked() {
        if (this.mContext.getResources().getBoolean(17956976) || SystemProperties.getInt(FORCE_WIFI_DISPLAY_ENABLE, -1) == MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
            this.mWifiDisplayAdapter = new WifiDisplayAdapter(this.mSyncRoot, this.mContext, this.mHandler, this.mDisplayAdapterListener, this.mPersistentDataStore);
            registerDisplayAdapterLocked(this.mWifiDisplayAdapter);
        }
    }

    private void registerVirtualDisplayAdapterLocked() {
        this.mVirtualDisplayAdapter = new VirtualDisplayAdapter(this.mSyncRoot, this.mContext, this.mHandler, this.mDisplayAdapterListener);
        registerDisplayAdapterLocked(this.mVirtualDisplayAdapter);
    }

    private boolean shouldRegisterNonEssentialDisplayAdaptersLocked() {
        return (this.mSafeMode || this.mOnlyCore) ? DEBUG : true;
    }

    private void registerDisplayAdapterLocked(DisplayAdapter adapter) {
        this.mDisplayAdapters.add(adapter);
        adapter.registerLocked();
    }

    private void handleDisplayDeviceAdded(DisplayDevice device) {
        synchronized (this.mSyncRoot) {
            handleDisplayDeviceAddedLocked(device);
        }
    }

    private void handleDisplayDeviceAddedLocked(DisplayDevice device) {
        if (this.mDisplayDevices.contains(device)) {
            Slog.w(TAG, "Attempted to add already added display device: " + device.getDisplayDeviceInfoLocked());
            return;
        }
        Slog.i(TAG, "Display device added: " + device.getDisplayDeviceInfoLocked());
        this.mDisplayDevices.add(device);
        addLogicalDisplayLocked(device);
        Runnable work = updateDisplayStateLocked(device);
        if (work != null) {
            work.run();
        }
        scheduleTraversalLocked(DEBUG);
    }

    private void handleDisplayDeviceChanged(DisplayDevice device) {
        synchronized (this.mSyncRoot) {
            if (this.mDisplayDevices.contains(device)) {
                Slog.i(TAG, "Display device changed: " + device.getDisplayDeviceInfoLocked());
                device.applyPendingDisplayDeviceInfoChangesLocked();
                if (updateLogicalDisplaysLocked()) {
                    scheduleTraversalLocked(DEBUG);
                }
                return;
            }
            Slog.w(TAG, "Attempted to change non-existent display device: " + device.getDisplayDeviceInfoLocked());
        }
    }

    private void handleDisplayDeviceRemoved(DisplayDevice device) {
        synchronized (this.mSyncRoot) {
            handleDisplayDeviceRemovedLocked(device);
        }
    }

    private void handleDisplayDeviceRemovedLocked(DisplayDevice device) {
        if (this.mDisplayDevices.remove(device)) {
            Slog.i(TAG, "Display device removed: " + device.getDisplayDeviceInfoLocked());
            updateLogicalDisplaysLocked();
            scheduleTraversalLocked(DEBUG);
            return;
        }
        Slog.w(TAG, "Attempted to remove non-existent display device: " + device.getDisplayDeviceInfoLocked());
    }

    private void updateGlobalDisplayStateLocked(List<Runnable> workQueue) {
        int count = this.mDisplayDevices.size();
        for (int i = 0; i < count; i += MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
            Runnable runnable = updateDisplayStateLocked((DisplayDevice) this.mDisplayDevices.get(i));
            if (runnable != null) {
                workQueue.add(runnable);
            }
        }
    }

    private Runnable updateDisplayStateLocked(DisplayDevice device) {
        if ((device.getDisplayDeviceInfoLocked().flags & 32) == 0) {
            return device.requestDisplayStateLocked(this.mGlobalDisplayState);
        }
        return null;
    }

    private void addLogicalDisplayLocked(DisplayDevice device) {
        boolean isDefault;
        DisplayDeviceInfo deviceInfo = device.getDisplayDeviceInfoLocked();
        if ((deviceInfo.flags & MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) != 0) {
            isDefault = true;
        } else {
            isDefault = DEBUG;
        }
        if (isDefault && this.mLogicalDisplays.get(0) != null) {
            Slog.w(TAG, "Ignoring attempt to add a second default display: " + deviceInfo);
            isDefault = DEBUG;
        }
        if (isDefault || !this.mSingleDisplayDemoMode) {
            int displayId = assignDisplayIdLocked(isDefault);
            LogicalDisplay display = new LogicalDisplay(displayId, assignLayerStackLocked(displayId), device);
            display.updateLocked(this.mDisplayDevices);
            if (display.isValidLocked()) {
                this.mLogicalDisplays.put(displayId, display);
                if (isDefault) {
                    this.mSyncRoot.notifyAll();
                }
                sendDisplayEventLocked(displayId, MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER);
                return;
            }
            Slog.w(TAG, "Ignoring display device because the logical display created from it was not considered valid: " + deviceInfo);
            return;
        }
        Slog.i(TAG, "Not creating a logical display for a secondary display  because single display demo mode is enabled: " + deviceInfo);
    }

    private int assignDisplayIdLocked(boolean isDefault) {
        if (isDefault) {
            return 0;
        }
        int i = this.mNextNonDefaultDisplayId;
        this.mNextNonDefaultDisplayId = i + MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER;
        return i;
    }

    private int assignLayerStackLocked(int displayId) {
        return displayId;
    }

    private boolean updateLogicalDisplaysLocked() {
        boolean changed = DEBUG;
        int i = this.mLogicalDisplays.size();
        while (true) {
            int i2 = i - 1;
            if (i <= 0) {
                return changed;
            }
            int displayId = this.mLogicalDisplays.keyAt(i2);
            LogicalDisplay display = (LogicalDisplay) this.mLogicalDisplays.valueAt(i2);
            this.mTempDisplayInfo.copyFrom(display.getDisplayInfoLocked());
            display.updateLocked(this.mDisplayDevices);
            if (!display.isValidLocked()) {
                this.mLogicalDisplays.removeAt(i2);
                sendDisplayEventLocked(displayId, MSG_DELIVER_DISPLAY_EVENT);
                changed = true;
            } else if (!this.mTempDisplayInfo.equals(display.getDisplayInfoLocked())) {
                sendDisplayEventLocked(displayId, MSG_REGISTER_ADDITIONAL_DISPLAY_ADAPTERS);
                changed = true;
            }
            i = i2;
        }
    }

    private void performTraversalInTransactionLocked() {
        clearViewportsLocked();
        int count = this.mDisplayDevices.size();
        for (int i = 0; i < count; i += MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
            DisplayDevice device = (DisplayDevice) this.mDisplayDevices.get(i);
            configureDisplayInTransactionLocked(device);
            device.performTraversalInTransactionLocked();
        }
        if (this.mInputManagerInternal != null) {
            this.mHandler.sendEmptyMessage(MSG_UPDATE_VIEWPORT);
        }
    }

    private void setDisplayPropertiesInternal(int displayId, boolean hasContent, float requestedRefreshRate, boolean inTraversal) {
        synchronized (this.mSyncRoot) {
            LogicalDisplay display = (LogicalDisplay) this.mLogicalDisplays.get(displayId);
            if (display == null) {
                return;
            }
            if (display.hasContentLocked() != hasContent) {
                display.setHasContentLocked(hasContent);
                scheduleTraversalLocked(inTraversal);
            }
            if (display.getRequestedRefreshRateLocked() != requestedRefreshRate) {
                display.setRequestedRefreshRateLocked(requestedRefreshRate);
                scheduleTraversalLocked(inTraversal);
            }
        }
    }

    private void clearViewportsLocked() {
        this.mDefaultViewport.valid = DEBUG;
        this.mExternalTouchViewport.valid = DEBUG;
    }

    private void configureDisplayInTransactionLocked(DisplayDevice device) {
        boolean ownContent;
        boolean z = true;
        DisplayDeviceInfo info = device.getDisplayDeviceInfoLocked();
        if ((info.flags & DumpState.DUMP_PROVIDERS) != 0) {
            ownContent = true;
        } else {
            ownContent = DEBUG;
        }
        LogicalDisplay display = findLogicalDisplayForDeviceLocked(device);
        if (!ownContent) {
            if (!(display == null || display.hasContentLocked())) {
                display = null;
            }
            if (display == null) {
                display = (LogicalDisplay) this.mLogicalDisplays.get(0);
            }
        }
        if (display == null) {
            Slog.w(TAG, "Missing logical display to use for physical display device: " + device.getDisplayDeviceInfoLocked());
            return;
        }
        if (info.state != MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
            z = DEBUG;
        }
        display.configureDisplayInTransactionLocked(device, z);
        if (!(this.mDefaultViewport.valid || (info.flags & MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) == 0)) {
            setViewportLocked(this.mDefaultViewport, display, device);
        }
        if (!this.mExternalTouchViewport.valid && info.touch == MSG_REGISTER_ADDITIONAL_DISPLAY_ADAPTERS) {
            setViewportLocked(this.mExternalTouchViewport, display, device);
        }
    }

    private static void setViewportLocked(DisplayViewport viewport, LogicalDisplay display, DisplayDevice device) {
        viewport.valid = true;
        viewport.displayId = display.getDisplayIdLocked();
        device.populateViewportLocked(viewport);
    }

    private LogicalDisplay findLogicalDisplayForDeviceLocked(DisplayDevice device) {
        int count = this.mLogicalDisplays.size();
        for (int i = 0; i < count; i += MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
            LogicalDisplay display = (LogicalDisplay) this.mLogicalDisplays.valueAt(i);
            if (display.getPrimaryDisplayDeviceLocked() == device) {
                return display;
            }
        }
        return null;
    }

    private void sendDisplayEventLocked(int displayId, int event) {
        this.mHandler.sendMessage(this.mHandler.obtainMessage(MSG_DELIVER_DISPLAY_EVENT, displayId, event));
    }

    private void scheduleTraversalLocked(boolean inTraversal) {
        if (!this.mPendingTraversal && this.mWindowManagerInternal != null) {
            this.mPendingTraversal = true;
            if (!inTraversal) {
                this.mHandler.sendEmptyMessage(MSG_REQUEST_TRAVERSAL);
            }
        }
    }

    private void deliverDisplayEvent(int displayId, int event) {
        int i;
        synchronized (this.mSyncRoot) {
            int count = this.mCallbacks.size();
            this.mTempCallbacks.clear();
            for (i = 0; i < count; i += MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
                this.mTempCallbacks.add(this.mCallbacks.valueAt(i));
            }
        }
        for (i = 0; i < count; i += MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
            ((CallbackRecord) this.mTempCallbacks.get(i)).notifyDisplayEventAsync(displayId, event);
        }
        this.mTempCallbacks.clear();
    }

    private IMediaProjectionManager getProjectionService() {
        if (this.mProjectionService == null) {
            this.mProjectionService = IMediaProjectionManager.Stub.asInterface(ServiceManager.getService("media_projection"));
        }
        return this.mProjectionService;
    }

    private void dumpInternal(PrintWriter pw) {
        pw.println("DISPLAY MANAGER (dumpsys display)");
        synchronized (this.mSyncRoot) {
            int i;
            pw.println("  mOnlyCode=" + this.mOnlyCore);
            pw.println("  mSafeMode=" + this.mSafeMode);
            pw.println("  mPendingTraversal=" + this.mPendingTraversal);
            pw.println("  mGlobalDisplayState=" + Display.stateToString(this.mGlobalDisplayState));
            pw.println("  mNextNonDefaultDisplayId=" + this.mNextNonDefaultDisplayId);
            pw.println("  mDefaultViewport=" + this.mDefaultViewport);
            pw.println("  mExternalTouchViewport=" + this.mExternalTouchViewport);
            pw.println("  mSingleDisplayDemoMode=" + this.mSingleDisplayDemoMode);
            pw.println("  mWifiDisplayScanRequestCount=" + this.mWifiDisplayScanRequestCount);
            IndentingPrintWriter ipw = new IndentingPrintWriter(pw, "    ");
            ipw.increaseIndent();
            pw.println();
            pw.println("Display Adapters: size=" + this.mDisplayAdapters.size());
            Iterator i$ = this.mDisplayAdapters.iterator();
            while (i$.hasNext()) {
                DisplayAdapter adapter = (DisplayAdapter) i$.next();
                pw.println("  " + adapter.getName());
                adapter.dumpLocked(ipw);
            }
            pw.println();
            pw.println("Display Devices: size=" + this.mDisplayDevices.size());
            i$ = this.mDisplayDevices.iterator();
            while (i$.hasNext()) {
                DisplayDevice device = (DisplayDevice) i$.next();
                pw.println("  " + device.getDisplayDeviceInfoLocked());
                device.dumpLocked(ipw);
            }
            int logicalDisplayCount = this.mLogicalDisplays.size();
            pw.println();
            pw.println("Logical Displays: size=" + logicalDisplayCount);
            for (i = 0; i < logicalDisplayCount; i += MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
                LogicalDisplay display = (LogicalDisplay) this.mLogicalDisplays.valueAt(i);
                pw.println("  Display " + this.mLogicalDisplays.keyAt(i) + ":");
                display.dumpLocked(ipw);
            }
            int callbackCount = this.mCallbacks.size();
            pw.println();
            pw.println("Callbacks: size=" + callbackCount);
            for (i = 0; i < callbackCount; i += MSG_REGISTER_DEFAULT_DISPLAY_ADAPTER) {
                CallbackRecord callback = (CallbackRecord) this.mCallbacks.valueAt(i);
                pw.println("  " + i + ": mPid=" + callback.mPid + ", mWifiDisplayScanRequested=" + callback.mWifiDisplayScanRequested);
            }
            if (this.mDisplayPowerController != null) {
                this.mDisplayPowerController.dump(pw);
            }
        }
    }
}
