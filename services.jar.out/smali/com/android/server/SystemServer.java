package com.android.server;

import android.app.ActivityManagerNative;
import android.app.ActivityThread;
import android.app.IAlarmManager;
import android.app.INotificationManager.Stub;
import android.app.usage.UsageStatsManagerInternal;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.media.AudioService;
import android.os.Build;
import android.os.Environment;
import android.os.FactoryTest;
import android.os.IBinder;
import android.os.IPowerManager;
import android.os.Looper;
import android.os.Process;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.StrictMode;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.util.DisplayMetrics;
import android.util.EventLog;
import android.util.Slog;
import android.view.WindowManager;
import android.webkit.WebViewFactory;
import com.android.internal.os.BinderInternal;
import com.android.internal.os.SamplingProfilerIntegration;
import com.android.server.accessibility.AccessibilityManagerService;
import com.android.server.accounts.AccountManagerService;
import com.android.server.am.ActivityManagerService;
import com.android.server.am.ActivityManagerService.Lifecycle;
import com.android.server.clipboard.ClipboardService;
import com.android.server.content.ContentService;
import com.android.server.devicepolicy.DevicePolicyManagerService;
import com.android.server.display.DisplayManagerService;
import com.android.server.dreams.DreamManagerService;
import com.android.server.fingerprint.FingerprintService;
import com.android.server.hdmi.HdmiControlService;
import com.android.server.input.InputManagerService;
import com.android.server.job.JobSchedulerService;
import com.android.server.lights.LightsService;
import com.android.server.media.MediaRouterService;
import com.android.server.media.MediaSessionService;
import com.android.server.media.projection.MediaProjectionManagerService;
import com.android.server.net.NetworkPolicyManagerService;
import com.android.server.net.NetworkStatsService;
import com.android.server.notification.NotificationManagerService;
import com.android.server.os.SchedulingPolicyService;
import com.android.server.pm.BackgroundDexOptService;
import com.android.server.pm.Installer;
import com.android.server.pm.LauncherAppsService;
import com.android.server.pm.PackageManagerService;
import com.android.server.pm.UserManagerService;
import com.android.server.power.PowerManagerService;
import com.android.server.power.ShutdownThread;
import com.android.server.restrictions.RestrictionsManagerService;
import com.android.server.search.SearchManagerService;
import com.android.server.statusbar.StatusBarManagerService;
import com.android.server.storage.DeviceStorageMonitorService;
import com.android.server.telecom.TelecomLoaderService;
import com.android.server.trust.TrustManagerService;
import com.android.server.tv.TvInputManagerService;
import com.android.server.twilight.TwilightService;
import com.android.server.usage.UsageStatsService;
import com.android.server.wallpaper.WallpaperManagerService;
import com.android.server.webkit.WebViewUpdateService;
import com.android.server.wm.WindowManagerService;
import dalvik.system.PathClassLoader;
import dalvik.system.VMRuntime;
import java.io.File;
import java.util.Timer;
import java.util.TimerTask;

public final class SystemServer {
    private static final String APPWIDGET_SERVICE_CLASS = "com.android.server.appwidget.AppWidgetService";
    private static final String BACKUP_MANAGER_SERVICE_CLASS = "com.android.server.backup.BackupManagerService$Lifecycle";
    private static final long EARLIEST_SUPPORTED_TIME = 86400000;
    private static final String ENCRYPTED_STATE = "1";
    private static final String ENCRYPTING_STATE = "trigger_restart_min_framework";
    private static final String ETHERNET_SERVICE_CLASS = "com.android.server.ethernet.EthernetService";
    private static final String JOB_SCHEDULER_SERVICE_CLASS = "com.android.server.job.JobSchedulerService";
    private static final String PERSISTENT_DATA_BLOCK_PROP = "ro.frp.pst";
    private static final String PRINT_MANAGER_SERVICE_CLASS = "com.android.server.print.PrintManagerService";
    private static final long SNAPSHOT_INTERVAL = 3600000;
    private static final String TAG = "SystemServer";
    private static final String USB_SERVICE_CLASS = "com.android.server.usb.UsbService$Lifecycle";
    private static final String VOICE_RECOGNITION_MANAGER_SERVICE_CLASS = "com.android.server.voiceinteraction.VoiceInteractionManagerService";
    private static final String WIFI_P2P_SERVICE_CLASS = "com.android.server.wifi.p2p.WifiP2pService";
    private static final String WIFI_SERVICE_CLASS = "com.android.server.wifi.WifiService";
    private ActivityManagerService mActivityManagerService;
    private AlarmManagerService mAlarmManagerService;
    private ContentResolver mContentResolver;
    private DisplayManagerService mDisplayManagerService;
    private final int mFactoryTestMode;
    private boolean mFirstBoot;
    private boolean mOnlyCore;
    private PackageManager mPackageManager;
    private PackageManagerService mPackageManagerService;
    private PowerManagerService mPowerManagerService;
    private Timer mProfilerSnapshotTimer;
    private Context mSystemContext;
    private SystemServiceManager mSystemServiceManager;

    /* renamed from: com.android.server.SystemServer.1 */
    class C00811 extends TimerTask {
        C00811() {
        }

        public void run() {
            SamplingProfilerIntegration.writeSnapshot("system_server", null);
        }
    }

    /* renamed from: com.android.server.SystemServer.2 */
    class C00822 implements Runnable {
        final /* synthetic */ AssetAtlasService val$atlasF;
        final /* synthetic */ AudioService val$audioServiceF;
        final /* synthetic */ CommonTimeManagementService val$commonTimeMgmtServiceF;
        final /* synthetic */ ConnectivityService val$connectivityF;
        final /* synthetic */ Context val$context;
        final /* synthetic */ CountryDetectorService val$countryDetectorF;
        final /* synthetic */ InputMethodManagerService val$immF;
        final /* synthetic */ InputManagerService val$inputManagerF;
        final /* synthetic */ LocationManagerService val$locationF;
        final /* synthetic */ MediaRouterService val$mediaRouterF;
        final /* synthetic */ MmsServiceBroker val$mmsServiceF;
        final /* synthetic */ MountService val$mountServiceF;
        final /* synthetic */ NetworkManagementService val$networkManagementF;
        final /* synthetic */ NetworkPolicyManagerService val$networkPolicyF;
        final /* synthetic */ NetworkScoreService val$networkScoreF;
        final /* synthetic */ NetworkStatsService val$networkStatsF;
        final /* synthetic */ NetworkTimeUpdateService val$networkTimeUpdaterF;
        final /* synthetic */ StatusBarManagerService val$statusBarF;
        final /* synthetic */ TelephonyRegistry val$telephonyRegistryF;
        final /* synthetic */ TextServicesManagerService val$textServiceManagerServiceF;
        final /* synthetic */ WallpaperManagerService val$wallpaperF;

        C00822(Context context, MountService mountService, NetworkScoreService networkScoreService, NetworkManagementService networkManagementService, NetworkStatsService networkStatsService, NetworkPolicyManagerService networkPolicyManagerService, ConnectivityService connectivityService, AudioService audioService, WallpaperManagerService wallpaperManagerService, InputMethodManagerService inputMethodManagerService, StatusBarManagerService statusBarManagerService, LocationManagerService locationManagerService, CountryDetectorService countryDetectorService, NetworkTimeUpdateService networkTimeUpdateService, CommonTimeManagementService commonTimeManagementService, TextServicesManagerService textServicesManagerService, AssetAtlasService assetAtlasService, InputManagerService inputManagerService, TelephonyRegistry telephonyRegistry, MediaRouterService mediaRouterService, MmsServiceBroker mmsServiceBroker) {
            this.val$context = context;
            this.val$mountServiceF = mountService;
            this.val$networkScoreF = networkScoreService;
            this.val$networkManagementF = networkManagementService;
            this.val$networkStatsF = networkStatsService;
            this.val$networkPolicyF = networkPolicyManagerService;
            this.val$connectivityF = connectivityService;
            this.val$audioServiceF = audioService;
            this.val$wallpaperF = wallpaperManagerService;
            this.val$immF = inputMethodManagerService;
            this.val$statusBarF = statusBarManagerService;
            this.val$locationF = locationManagerService;
            this.val$countryDetectorF = countryDetectorService;
            this.val$networkTimeUpdaterF = networkTimeUpdateService;
            this.val$commonTimeMgmtServiceF = commonTimeManagementService;
            this.val$textServiceManagerServiceF = textServicesManagerService;
            this.val$atlasF = assetAtlasService;
            this.val$inputManagerF = inputManagerService;
            this.val$telephonyRegistryF = telephonyRegistry;
            this.val$mediaRouterF = mediaRouterService;
            this.val$mmsServiceF = mmsServiceBroker;
        }

        public void run() {
            Slog.i(SystemServer.TAG, "Making services ready");
            SystemServer.this.mSystemServiceManager.startBootPhase(SystemService.PHASE_ACTIVITY_MANAGER_READY);
            try {
                SystemServer.this.mActivityManagerService.startObservingNativeCrashes();
            } catch (Throwable e) {
                SystemServer.this.reportWtf("observing native crashes", e);
            }
            Slog.i(SystemServer.TAG, "WebViewFactory preparation");
            WebViewFactory.prepareWebViewInSystemServer();
            try {
                SystemServer.startSystemUi(this.val$context);
            } catch (Throwable e2) {
                SystemServer.this.reportWtf("starting System UI", e2);
            }
            try {
                if (this.val$mountServiceF != null) {
                    this.val$mountServiceF.systemReady();
                }
            } catch (Throwable e22) {
                SystemServer.this.reportWtf("making Mount Service ready", e22);
            }
            try {
                if (this.val$networkScoreF != null) {
                    this.val$networkScoreF.systemReady();
                }
            } catch (Throwable e222) {
                SystemServer.this.reportWtf("making Network Score Service ready", e222);
            }
            try {
                if (this.val$networkManagementF != null) {
                    this.val$networkManagementF.systemReady();
                }
            } catch (Throwable e2222) {
                SystemServer.this.reportWtf("making Network Managment Service ready", e2222);
            }
            try {
                if (this.val$networkStatsF != null) {
                    this.val$networkStatsF.systemReady();
                }
            } catch (Throwable e22222) {
                SystemServer.this.reportWtf("making Network Stats Service ready", e22222);
            }
            try {
                if (this.val$networkPolicyF != null) {
                    this.val$networkPolicyF.systemReady();
                }
            } catch (Throwable e222222) {
                SystemServer.this.reportWtf("making Network Policy Service ready", e222222);
            }
            try {
                if (this.val$connectivityF != null) {
                    this.val$connectivityF.systemReady();
                }
            } catch (Throwable e2222222) {
                SystemServer.this.reportWtf("making Connectivity Service ready", e2222222);
            }
            try {
                if (this.val$audioServiceF != null) {
                    this.val$audioServiceF.systemReady();
                }
            } catch (Throwable e22222222) {
                SystemServer.this.reportWtf("Notifying AudioService running", e22222222);
            }
            Watchdog.getInstance().start();
            SystemServer.this.mSystemServiceManager.startBootPhase(NetdResponseCode.InterfaceChange);
            try {
                if (this.val$wallpaperF != null) {
                    this.val$wallpaperF.systemRunning();
                }
            } catch (Throwable e222222222) {
                SystemServer.this.reportWtf("Notifying WallpaperService running", e222222222);
            }
            try {
                if (this.val$immF != null) {
                    this.val$immF.systemRunning(this.val$statusBarF);
                }
            } catch (Throwable e2222222222) {
                SystemServer.this.reportWtf("Notifying InputMethodService running", e2222222222);
            }
            try {
                if (this.val$locationF != null) {
                    this.val$locationF.systemRunning();
                }
            } catch (Throwable e22222222222) {
                SystemServer.this.reportWtf("Notifying Location Service running", e22222222222);
            }
            try {
                if (this.val$countryDetectorF != null) {
                    this.val$countryDetectorF.systemRunning();
                }
            } catch (Throwable e222222222222) {
                SystemServer.this.reportWtf("Notifying CountryDetectorService running", e222222222222);
            }
            try {
                if (this.val$networkTimeUpdaterF != null) {
                    this.val$networkTimeUpdaterF.systemRunning();
                }
            } catch (Throwable e2222222222222) {
                SystemServer.this.reportWtf("Notifying NetworkTimeService running", e2222222222222);
            }
            try {
                if (this.val$commonTimeMgmtServiceF != null) {
                    this.val$commonTimeMgmtServiceF.systemRunning();
                }
            } catch (Throwable e22222222222222) {
                SystemServer.this.reportWtf("Notifying CommonTimeManagementService running", e22222222222222);
            }
            try {
                if (this.val$textServiceManagerServiceF != null) {
                    this.val$textServiceManagerServiceF.systemRunning();
                }
            } catch (Throwable e222222222222222) {
                SystemServer.this.reportWtf("Notifying TextServicesManagerService running", e222222222222222);
            }
            try {
                if (this.val$atlasF != null) {
                    this.val$atlasF.systemRunning();
                }
            } catch (Throwable e2222222222222222) {
                SystemServer.this.reportWtf("Notifying AssetAtlasService running", e2222222222222222);
            }
            try {
                if (this.val$inputManagerF != null) {
                    this.val$inputManagerF.systemRunning();
                }
            } catch (Throwable e22222222222222222) {
                SystemServer.this.reportWtf("Notifying InputManagerService running", e22222222222222222);
            }
            try {
                if (this.val$telephonyRegistryF != null) {
                    this.val$telephonyRegistryF.systemRunning();
                }
            } catch (Throwable e222222222222222222) {
                SystemServer.this.reportWtf("Notifying TelephonyRegistry running", e222222222222222222);
            }
            try {
                if (this.val$mediaRouterF != null) {
                    this.val$mediaRouterF.systemRunning();
                }
            } catch (Throwable e2222222222222222222) {
                SystemServer.this.reportWtf("Notifying MediaRouterService running", e2222222222222222222);
            }
            try {
                if (this.val$mmsServiceF != null) {
                    this.val$mmsServiceF.systemRunning();
                }
            } catch (Throwable e22222222222222222222) {
                SystemServer.this.reportWtf("Notifying MmsService running", e22222222222222222222);
            }
        }
    }

    private static native void nativeInit();

    public static void main(String[] args) {
        new SystemServer().run();
    }

    public SystemServer() {
        this.mFactoryTestMode = FactoryTest.getMode();
    }

    private void run() {
        if (System.currentTimeMillis() < EARLIEST_SUPPORTED_TIME) {
            Slog.w(TAG, "System clock is before 1970; setting to 1970.");
            SystemClock.setCurrentTimeMillis(EARLIEST_SUPPORTED_TIME);
        }
        Slog.i(TAG, "Entered the Android system server!");
        EventLog.writeEvent(EventLogTags.BOOT_PROGRESS_SYSTEM_RUN, SystemClock.uptimeMillis());
        SystemProperties.set("persist.sys.dalvik.vm.lib.2", VMRuntime.getRuntime().vmLibrary());
        if (SamplingProfilerIntegration.isEnabled()) {
            SamplingProfilerIntegration.start();
            this.mProfilerSnapshotTimer = new Timer();
            this.mProfilerSnapshotTimer.schedule(new C00811(), SNAPSHOT_INTERVAL, SNAPSHOT_INTERVAL);
        }
        VMRuntime.getRuntime().clearGrowthLimit();
        VMRuntime.getRuntime().setTargetHeapUtilization(WindowManagerService.STACK_WEIGHT_MAX);
        Build.ensureFingerprintProperty();
        Environment.setUserRequired(true);
        BinderInternal.disableBackgroundScheduling(true);
        Process.setThreadPriority(-2);
        Process.setCanSelfBackground(false);
        Looper.prepareMainLooper();
        System.loadLibrary("android_servers");
        nativeInit();
        performPendingShutdown();
        createSystemContext();
        this.mSystemServiceManager = new SystemServiceManager(this.mSystemContext);
        LocalServices.addService(SystemServiceManager.class, this.mSystemServiceManager);
        try {
            startBootstrapServices();
            startCoreServices();
            startOtherServices();
            if (StrictMode.conditionallyEnableDebugLogging()) {
                Slog.i(TAG, "Enabled StrictMode for system server main thread.");
            }
            Looper.loop();
            throw new RuntimeException("Main thread loop unexpectedly exited");
        } catch (Throwable ex) {
            Slog.e("System", "******************************************");
            Slog.e("System", "************ Failure starting system services", ex);
        }
    }

    private void reportWtf(String msg, Throwable e) {
        Slog.w(TAG, "***********************************************");
        Slog.wtf(TAG, "BOOT FAILURE " + msg, e);
    }

    private void performPendingShutdown() {
        boolean reboot = false;
        String shutdownAction = SystemProperties.get(ShutdownThread.SHUTDOWN_ACTION_PROPERTY, "");
        if (shutdownAction != null && shutdownAction.length() > 0) {
            String reason;
            if (shutdownAction.charAt(0) == '1') {
                reboot = true;
            }
            if (shutdownAction.length() > 1) {
                reason = shutdownAction.substring(1, shutdownAction.length());
            } else {
                reason = null;
            }
            ShutdownThread.rebootOrShutdown(null, reboot, reason);
        }
    }

    private void createSystemContext() {
        this.mSystemContext = ActivityThread.systemMain().getSystemContext();
        this.mSystemContext.setTheme(16974143);
    }

    private void startBootstrapServices() {
        Installer installer = (Installer) this.mSystemServiceManager.startService(Installer.class);
        this.mActivityManagerService = ((Lifecycle) this.mSystemServiceManager.startService(Lifecycle.class)).getService();
        this.mActivityManagerService.setSystemServiceManager(this.mSystemServiceManager);
        this.mActivityManagerService.setInstaller(installer);
        this.mPowerManagerService = (PowerManagerService) this.mSystemServiceManager.startService(PowerManagerService.class);
        this.mActivityManagerService.initPowerManagement();
        this.mDisplayManagerService = (DisplayManagerService) this.mSystemServiceManager.startService(DisplayManagerService.class);
        this.mSystemServiceManager.startBootPhase(100);
        String cryptState = SystemProperties.get("vold.decrypt");
        if (ENCRYPTING_STATE.equals(cryptState)) {
            Slog.w(TAG, "Detected encryption in progress - only parsing core apps");
            this.mOnlyCore = true;
        } else if (ENCRYPTED_STATE.equals(cryptState)) {
            Slog.w(TAG, "Device encrypted - only parsing core apps");
            this.mOnlyCore = true;
        }
        Slog.i(TAG, "Package Manager");
        this.mPackageManagerService = PackageManagerService.main(this.mSystemContext, installer, this.mFactoryTestMode != 0, this.mOnlyCore);
        this.mFirstBoot = this.mPackageManagerService.isFirstBoot();
        this.mPackageManager = this.mSystemContext.getPackageManager();
        Slog.i(TAG, "User Service");
        ServiceManager.addService("user", UserManagerService.getInstance());
        AttributeCache.init(this.mSystemContext);
        this.mActivityManagerService.setSystemProcess();
    }

    private void startCoreServices() {
        this.mSystemServiceManager.startService(LightsService.class);
        this.mSystemServiceManager.startService(BatteryService.class);
        this.mSystemServiceManager.startService(UsageStatsService.class);
        this.mActivityManagerService.setUsageStatsManager((UsageStatsManagerInternal) LocalServices.getService(UsageStatsManagerInternal.class));
        this.mPackageManagerService.getUsageStatsIfNoPackageUsageInfo();
        this.mSystemServiceManager.startService(WebViewUpdateService.class);
    }

    private void startOtherServices() {
        Throwable e;
        VibratorService vibratorService;
        ConsumerIrService consumerIrService;
        InputManagerService inputManagerService;
        boolean z;
        boolean z2;
        BluetoothManagerService bluetoothManagerService;
        BluetoothManagerService bluetoothManagerService2;
        ConsumerIrService consumerIrService2;
        StatusBarManagerService statusBar;
        InputMethodManagerService imm;
        WallpaperManagerService wallpaper;
        LocationManagerService location;
        CountryDetectorService countryDetector;
        TextServicesManagerService tsms;
        LockSettingsService lockSettings;
        AssetAtlasService atlas;
        MediaRouterService mediaRouter;
        InputMethodManagerService inputMethodManagerService;
        MountService mountService;
        NetworkPolicyManagerService networkPolicy;
        LockSettingsService lockSettingsService;
        StatusBarManagerService statusBarManagerService;
        TextServicesManagerService textServicesManagerService;
        NetworkScoreService networkScoreService;
        NetworkStatsService networkStatsService;
        ConnectivityService connectivityService;
        LocationManagerService locationManagerService;
        CountryDetectorService countryDetectorService;
        WallpaperManagerService wallpaperManagerService;
        AudioService audioService;
        SerialService serialService;
        SerialService serialService2;
        CommonTimeManagementService commonTimeManagementService;
        CertBlacklister certBlacklister;
        AssetAtlasService assetAtlasService;
        MediaRouterService mediaRouterService;
        String WBC_SERVICE_NAME;
        Object wbcObject;
        boolean safeMode;
        MmsServiceBroker mmsService;
        Configuration config;
        DisplayMetrics metrics;
        AudioService audioServiceF;
        Context context = this.mSystemContext;
        AccountManagerService accountManagerService = null;
        ContentService contentService = null;
        VibratorService vibrator = null;
        IAlarmManager alarm = null;
        MountService mountService2 = null;
        NetworkManagementService networkManagement = null;
        NetworkStatsService networkStats = null;
        ConnectivityService connectivity = null;
        NetworkScoreService networkScore = null;
        WindowManagerService wm = null;
        NetworkTimeUpdateService networkTimeUpdater = null;
        CommonTimeManagementService commonTimeMgmtService = null;
        InputManagerService inputManager = null;
        TelephonyRegistry telephonyRegistry = null;
        AudioService audioService2 = null;
        boolean disableStorage = SystemProperties.getBoolean("config.disable_storage", false);
        boolean disableMedia = SystemProperties.getBoolean("config.disable_media", false);
        boolean disableBluetooth = SystemProperties.getBoolean("config.disable_bluetooth", false);
        boolean disableTelephony = SystemProperties.getBoolean("config.disable_telephony", false);
        boolean disableLocation = SystemProperties.getBoolean("config.disable_location", false);
        boolean disableSystemUI = SystemProperties.getBoolean("config.disable_systemui", false);
        boolean disableNonCoreServices = SystemProperties.getBoolean("config.disable_noncore", false);
        boolean disableNetwork = SystemProperties.getBoolean("config.disable_network", false);
        boolean disableNetworkTime = SystemProperties.getBoolean("config.disable_networktime", false);
        boolean isEmulator = SystemProperties.get("ro.kernel.qemu").equals(ENCRYPTED_STATE);
        boolean disableAtlas = SystemProperties.getBoolean("config.disable_atlas", false);
        try {
            Slog.i(TAG, "Reading configuration...");
            SystemConfig.getInstance();
            Slog.i(TAG, "Scheduling Policy");
            ServiceManager.addService("scheduling_policy", new SchedulingPolicyService());
            this.mSystemServiceManager.startService(TelecomLoaderService.class);
            Slog.i(TAG, "Telephony Registry");
            TelephonyRegistry telephonyRegistry2 = new TelephonyRegistry(context);
            ServiceManager.addService("telephony.registry", telephonyRegistry2);
            Slog.i(TAG, "Entropy Mixer");
            ServiceManager.addService("entropy", new EntropyMixer(context));
            this.mContentResolver = context.getContentResolver();
            try {
                Slog.i(TAG, "Account Manager");
                AccountManagerService accountManagerService2 = new AccountManagerService(context);
                try {
                    ServiceManager.addService("account", accountManagerService2);
                    accountManagerService = accountManagerService2;
                } catch (RuntimeException e2) {
                    e = e2;
                    telephonyRegistry = telephonyRegistry2;
                    accountManagerService = accountManagerService2;
                    Slog.e("System", "******************************************");
                    Slog.e("System", "************ Failure starting core service", e);
                    statusBar = null;
                    imm = null;
                    wallpaper = null;
                    location = null;
                    countryDetector = null;
                    tsms = null;
                    lockSettings = null;
                    atlas = null;
                    mediaRouter = null;
                    if (this.mFactoryTestMode != 1) {
                        Slog.i(TAG, "Input Method Service");
                        inputMethodManagerService = new InputMethodManagerService(context, wm);
                        ServiceManager.addService("input_method", inputMethodManagerService);
                        imm = inputMethodManagerService;
                        Slog.i(TAG, "Accessibility Manager");
                        ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
                    }
                    wm.displayReady();
                    Slog.i(TAG, "Mount Service");
                    mountService = new MountService(context);
                    ServiceManager.addService("mount", mountService);
                    mountService2 = mountService;
                    this.mPackageManagerService.performBootDexOpt();
                    ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                    if (this.mFactoryTestMode == 1) {
                        networkPolicy = null;
                    } else {
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "LockSettingsService");
                            lockSettingsService = new LockSettingsService(context);
                            ServiceManager.addService("lock_settings", lockSettingsService);
                            lockSettings = lockSettingsService;
                            if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                            }
                            this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                        }
                        if (disableSystemUI) {
                            Slog.i(TAG, "Status Bar");
                            statusBarManagerService = new StatusBarManagerService(context, wm);
                            ServiceManager.addService("statusbar", statusBarManagerService);
                            statusBar = statusBarManagerService;
                        }
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "Clipboard Service");
                            ServiceManager.addService("clipboard", new ClipboardService(context));
                        }
                        if (disableNetwork) {
                            Slog.i(TAG, "NetworkManagement Service");
                            networkManagement = NetworkManagementService.create(context);
                            ServiceManager.addService("network_management", networkManagement);
                        }
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "Text Service Manager Service");
                            textServicesManagerService = new TextServicesManagerService(context);
                            ServiceManager.addService("textservices", textServicesManagerService);
                            tsms = textServicesManagerService;
                        }
                        if (disableNetwork) {
                            Slog.i(TAG, "Network Score Service");
                            networkScoreService = new NetworkScoreService(context);
                            ServiceManager.addService("network_score", networkScoreService);
                            networkScore = networkScoreService;
                            Slog.i(TAG, "NetworkStats Service");
                            networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                            ServiceManager.addService("netstats", networkStatsService);
                            networkStats = networkStatsService;
                            Slog.i(TAG, "NetworkPolicy Service");
                            networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                            ServiceManager.addService("netpolicy", networkPolicy);
                            this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                            this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                            this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                            this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                            if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                            }
                            Slog.i(TAG, "Connectivity Service");
                            connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                            ServiceManager.addService("connectivity", connectivityService);
                            networkStats.bindConnectivityManager(connectivityService);
                            networkPolicy.bindConnectivityManager(connectivityService);
                            connectivity = connectivityService;
                            Slog.i(TAG, "Network Service Discovery Service");
                            ServiceManager.addService("servicediscovery", NsdService.create(context));
                            Slog.i(TAG, "DPM Service");
                            startDpmService(context);
                        } else {
                            networkPolicy = null;
                        }
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "UpdateLock Service");
                            ServiceManager.addService("updatelock", new UpdateLockService(context));
                        }
                        mountService2.waitForAsecScan();
                        if (accountManagerService != null) {
                            accountManagerService.systemReady();
                        }
                        if (contentService != null) {
                            contentService.systemReady();
                        }
                        this.mSystemServiceManager.startService(NotificationManagerService.class);
                        networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                        this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                        if (disableLocation) {
                            Slog.i(TAG, "Location Manager");
                            locationManagerService = new LocationManagerService(context);
                            ServiceManager.addService("location", locationManagerService);
                            location = locationManagerService;
                            Slog.i(TAG, "Country Detector");
                            countryDetectorService = new CountryDetectorService(context);
                            ServiceManager.addService("country_detector", countryDetectorService);
                            countryDetector = countryDetectorService;
                        }
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "Search Service");
                            ServiceManager.addService("search", new SearchManagerService(context));
                        }
                        Slog.i(TAG, "DropBox Service");
                        ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                        Slog.i(TAG, "Wallpaper Service");
                        wallpaperManagerService = new WallpaperManagerService(context);
                        ServiceManager.addService("wallpaper", wallpaperManagerService);
                        wallpaper = wallpaperManagerService;
                        Slog.i(TAG, "Audio Service");
                        audioService = new AudioService(context);
                        ServiceManager.addService("audio", audioService);
                        audioService2 = audioService;
                        if (disableNonCoreServices) {
                            this.mSystemServiceManager.startService(DockObserver.class);
                        }
                        if (disableMedia) {
                            Slog.i(TAG, "Wired Accessory Manager");
                            inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                        }
                        if (disableNonCoreServices) {
                            this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                            Slog.i(TAG, "Serial Service");
                            serialService = new SerialService(context);
                            ServiceManager.addService("serial", serialService);
                            serialService2 = serialService;
                        }
                        this.mSystemServiceManager.startService(TwilightService.class);
                        this.mSystemServiceManager.startService(UiModeManagerService.class);
                        this.mSystemServiceManager.startService(JobSchedulerService.class);
                        if (disableNonCoreServices) {
                            if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                            }
                            if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                            }
                            if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                            }
                        }
                        Slog.i(TAG, "DiskStats Service");
                        ServiceManager.addService("diskstats", new DiskStatsService(context));
                        Slog.i(TAG, "SamplingProfiler Service");
                        ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                        Slog.i(TAG, "NetworkTimeUpdateService");
                        networkTimeUpdater = new NetworkTimeUpdateService(context);
                        if (disableMedia) {
                            Slog.i(TAG, "CommonTimeManagementService");
                            commonTimeManagementService = new CommonTimeManagementService(context);
                            ServiceManager.addService("commontime_management", commonTimeManagementService);
                            commonTimeMgmtService = commonTimeManagementService;
                        }
                        if (disableNetwork) {
                            Slog.i(TAG, "CertBlacklister");
                            certBlacklister = new CertBlacklister(context);
                        }
                        if (disableNonCoreServices) {
                            this.mSystemServiceManager.startService(DreamManagerService.class);
                        }
                        Slog.i(TAG, "Assets Atlas Service");
                        assetAtlasService = new AssetAtlasService(context);
                        ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                        atlas = assetAtlasService;
                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                        }
                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                        this.mSystemServiceManager.startService(MediaSessionService.class);
                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                            this.mSystemServiceManager.startService(HdmiControlService.class);
                        }
                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                        }
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "Media Router Service");
                            mediaRouterService = new MediaRouterService(context);
                            ServiceManager.addService("media_router", mediaRouterService);
                            mediaRouter = mediaRouterService;
                            this.mSystemServiceManager.startService(TrustManagerService.class);
                            this.mSystemServiceManager.startService(FingerprintService.class);
                            Slog.i(TAG, "BackgroundDexOptService");
                            BackgroundDexOptService.schedule(context);
                        }
                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                            WBC_SERVICE_NAME = "wbc_service";
                            Slog.i(TAG, "WipowerBatteryControl Service");
                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                            Slog.d(TAG, "Successfully loaded WbcService class");
                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                        } else {
                            Slog.d(TAG, "Wipower not supported");
                        }
                    }
                    if (disableNonCoreServices) {
                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                    }
                    safeMode = wm.detectSafeMode();
                    if (safeMode) {
                        this.mActivityManagerService.enterSafeMode();
                        VMRuntime.getRuntime().disableJitCompilation();
                    } else {
                        VMRuntime.getRuntime().startJitCompilation();
                    }
                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                    vibrator.systemReady();
                    if (lockSettings != null) {
                        lockSettings.systemReady();
                    }
                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                    wm.systemReady();
                    if (safeMode) {
                        this.mActivityManagerService.showSafeModeOverlay();
                    }
                    config = wm.computeNewConfiguration();
                    metrics = new DisplayMetrics();
                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                    context.getResources().updateConfiguration(config, metrics);
                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                    this.mPackageManagerService.systemReady();
                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                    audioServiceF = audioService2;
                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                } catch (Throwable th) {
                    e = th;
                    accountManagerService = accountManagerService2;
                    try {
                        Slog.e(TAG, "Failure starting Account Manager", e);
                        Slog.i(TAG, "Content Manager");
                        contentService = ContentService.main(context, this.mFactoryTestMode == 1);
                        Slog.i(TAG, "System Content Providers");
                        this.mActivityManagerService.installSystemProviders();
                        Slog.i(TAG, "Vibrator Service");
                        vibratorService = new VibratorService(context);
                        ServiceManager.addService("vibrator", vibratorService);
                        Slog.i(TAG, "Consumer IR Service");
                        consumerIrService = new ConsumerIrService(context);
                        try {
                            ServiceManager.addService("consumer_ir", consumerIrService);
                            this.mAlarmManagerService = (AlarmManagerService) this.mSystemServiceManager.startService(AlarmManagerService.class);
                            alarm = IAlarmManager.Stub.asInterface(ServiceManager.getService("alarm"));
                            Slog.i(TAG, "Init Watchdog");
                            Watchdog.getInstance().init(context, this.mActivityManagerService);
                            Slog.i(TAG, "Input Manager");
                            inputManagerService = new InputManagerService(context);
                            try {
                                Slog.i(TAG, "Window Manager");
                                if (this.mFactoryTestMode != 1) {
                                    z = true;
                                } else {
                                    z = false;
                                }
                                if (this.mFirstBoot) {
                                    z2 = false;
                                } else {
                                    z2 = true;
                                }
                                wm = WindowManagerService.main(context, inputManagerService, z, z2, this.mOnlyCore);
                                ServiceManager.addService("window", wm);
                                ServiceManager.addService("input", inputManagerService);
                                this.mActivityManagerService.setWindowManager(wm);
                                inputManagerService.setWindowManagerCallbacks(wm.getInputMonitor());
                                inputManagerService.start();
                                this.mDisplayManagerService.windowManagerAndInputReady();
                                if (!isEmulator) {
                                    Slog.i(TAG, "No Bluetooth Service (emulator)");
                                } else if (this.mFactoryTestMode != 1) {
                                    Slog.i(TAG, "No Bluetooth Service (factory test)");
                                } else if (context.getPackageManager().hasSystemFeature("android.hardware.bluetooth")) {
                                    Slog.i(TAG, "No Bluetooth Service (Bluetooth Hardware Not Present)");
                                } else if (disableBluetooth) {
                                    Slog.i(TAG, "Bluetooth Service disabled by config");
                                } else {
                                    Slog.i(TAG, "Bluetooth Manager Service");
                                    bluetoothManagerService = new BluetoothManagerService(context);
                                    try {
                                        ServiceManager.addService("bluetooth_manager", bluetoothManagerService);
                                        bluetoothManagerService2 = bluetoothManagerService;
                                    } catch (RuntimeException e3) {
                                        e = e3;
                                        consumerIrService2 = consumerIrService;
                                        telephonyRegistry = telephonyRegistry2;
                                        inputManager = inputManagerService;
                                        bluetoothManagerService2 = bluetoothManagerService;
                                        vibrator = vibratorService;
                                        Slog.e("System", "******************************************");
                                        Slog.e("System", "************ Failure starting core service", e);
                                        statusBar = null;
                                        imm = null;
                                        wallpaper = null;
                                        location = null;
                                        countryDetector = null;
                                        tsms = null;
                                        lockSettings = null;
                                        atlas = null;
                                        mediaRouter = null;
                                        if (this.mFactoryTestMode != 1) {
                                            try {
                                                Slog.i(TAG, "Input Method Service");
                                                inputMethodManagerService = new InputMethodManagerService(context, wm);
                                                try {
                                                    ServiceManager.addService("input_method", inputMethodManagerService);
                                                    imm = inputMethodManagerService;
                                                } catch (Throwable th2) {
                                                    e = th2;
                                                    imm = inputMethodManagerService;
                                                    reportWtf("starting Input Manager Service", e);
                                                    Slog.i(TAG, "Accessibility Manager");
                                                    ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
                                                    wm.displayReady();
                                                    Slog.i(TAG, "Mount Service");
                                                    mountService = new MountService(context);
                                                    ServiceManager.addService("mount", mountService);
                                                    mountService2 = mountService;
                                                    this.mPackageManagerService.performBootDexOpt();
                                                    ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                                                    if (this.mFactoryTestMode == 1) {
                                                        networkPolicy = null;
                                                    } else {
                                                        if (!disableNonCoreServices) {
                                                            try {
                                                                Slog.i(TAG, "LockSettingsService");
                                                                lockSettingsService = new LockSettingsService(context);
                                                                try {
                                                                    ServiceManager.addService("lock_settings", lockSettingsService);
                                                                    lockSettings = lockSettingsService;
                                                                } catch (Throwable th3) {
                                                                    e = th3;
                                                                    lockSettings = lockSettingsService;
                                                                    reportWtf("starting LockSettingsService service", e);
                                                                    if (!SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                                                        this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                                                                    }
                                                                    this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                                                                    if (!disableSystemUI) {
                                                                        try {
                                                                            Slog.i(TAG, "Status Bar");
                                                                            statusBarManagerService = new StatusBarManagerService(context, wm);
                                                                            try {
                                                                                ServiceManager.addService("statusbar", statusBarManagerService);
                                                                                statusBar = statusBarManagerService;
                                                                            } catch (Throwable th4) {
                                                                                e = th4;
                                                                                statusBar = statusBarManagerService;
                                                                                reportWtf("starting StatusBarManagerService", e);
                                                                                if (!disableNonCoreServices) {
                                                                                    try {
                                                                                        Slog.i(TAG, "Clipboard Service");
                                                                                        ServiceManager.addService("clipboard", new ClipboardService(context));
                                                                                    } catch (Throwable e4) {
                                                                                        reportWtf("starting Clipboard Service", e4);
                                                                                    }
                                                                                }
                                                                                if (!disableNetwork) {
                                                                                    try {
                                                                                        Slog.i(TAG, "NetworkManagement Service");
                                                                                        networkManagement = NetworkManagementService.create(context);
                                                                                        ServiceManager.addService("network_management", networkManagement);
                                                                                    } catch (Throwable e42) {
                                                                                        reportWtf("starting NetworkManagement Service", e42);
                                                                                    }
                                                                                }
                                                                                if (!disableNonCoreServices) {
                                                                                    try {
                                                                                        Slog.i(TAG, "Text Service Manager Service");
                                                                                        textServicesManagerService = new TextServicesManagerService(context);
                                                                                        try {
                                                                                            ServiceManager.addService("textservices", textServicesManagerService);
                                                                                            tsms = textServicesManagerService;
                                                                                        } catch (Throwable th5) {
                                                                                            e42 = th5;
                                                                                            tsms = textServicesManagerService;
                                                                                            reportWtf("starting Text Service Manager Service", e42);
                                                                                            if (disableNetwork) {
                                                                                                networkPolicy = null;
                                                                                            } else {
                                                                                                try {
                                                                                                    Slog.i(TAG, "Network Score Service");
                                                                                                    networkScoreService = new NetworkScoreService(context);
                                                                                                    try {
                                                                                                        ServiceManager.addService("network_score", networkScoreService);
                                                                                                        networkScore = networkScoreService;
                                                                                                    } catch (Throwable th6) {
                                                                                                        e42 = th6;
                                                                                                        networkScore = networkScoreService;
                                                                                                        reportWtf("starting Network Score Service", e42);
                                                                                                        Slog.i(TAG, "NetworkStats Service");
                                                                                                        networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                                                                        try {
                                                                                                            ServiceManager.addService("netstats", networkStatsService);
                                                                                                            networkStats = networkStatsService;
                                                                                                        } catch (Throwable th7) {
                                                                                                            e42 = th7;
                                                                                                            networkStats = networkStatsService;
                                                                                                            reportWtf("starting NetworkStats Service", e42);
                                                                                                            Slog.i(TAG, "NetworkPolicy Service");
                                                                                                            networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                                                                            ServiceManager.addService("netpolicy", networkPolicy);
                                                                                                            this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                                                            this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                                                            this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                                                            this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                                                                this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                                                            }
                                                                                                            Slog.i(TAG, "Connectivity Service");
                                                                                                            connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                                                            ServiceManager.addService("connectivity", connectivityService);
                                                                                                            networkStats.bindConnectivityManager(connectivityService);
                                                                                                            networkPolicy.bindConnectivityManager(connectivityService);
                                                                                                            connectivity = connectivityService;
                                                                                                            Slog.i(TAG, "Network Service Discovery Service");
                                                                                                            ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                                            Slog.i(TAG, "DPM Service");
                                                                                                            startDpmService(context);
                                                                                                            if (!disableNonCoreServices) {
                                                                                                                try {
                                                                                                                    Slog.i(TAG, "UpdateLock Service");
                                                                                                                    ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                                                } catch (Throwable e422) {
                                                                                                                    reportWtf("starting UpdateLockService", e422);
                                                                                                                }
                                                                                                            }
                                                                                                            mountService2.waitForAsecScan();
                                                                                                            if (accountManagerService != null) {
                                                                                                                try {
                                                                                                                    accountManagerService.systemReady();
                                                                                                                } catch (Throwable e4222) {
                                                                                                                    reportWtf("making Account Manager Service ready", e4222);
                                                                                                                }
                                                                                                            }
                                                                                                            if (contentService != null) {
                                                                                                                try {
                                                                                                                    contentService.systemReady();
                                                                                                                } catch (Throwable e42222) {
                                                                                                                    reportWtf("making Content Service ready", e42222);
                                                                                                                }
                                                                                                            }
                                                                                                            this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                                            networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                                            this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                                            if (!disableLocation) {
                                                                                                                try {
                                                                                                                    Slog.i(TAG, "Location Manager");
                                                                                                                    locationManagerService = new LocationManagerService(context);
                                                                                                                    try {
                                                                                                                        ServiceManager.addService("location", locationManagerService);
                                                                                                                        location = locationManagerService;
                                                                                                                    } catch (Throwable th8) {
                                                                                                                        e42222 = th8;
                                                                                                                        location = locationManagerService;
                                                                                                                        reportWtf("starting Location Manager", e42222);
                                                                                                                        Slog.i(TAG, "Country Detector");
                                                                                                                        countryDetectorService = new CountryDetectorService(context);
                                                                                                                        try {
                                                                                                                            ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                                            countryDetector = countryDetectorService;
                                                                                                                        } catch (Throwable th9) {
                                                                                                                            e42222 = th9;
                                                                                                                            countryDetector = countryDetectorService;
                                                                                                                            reportWtf("starting Country Detector", e42222);
                                                                                                                            if (!disableNonCoreServices) {
                                                                                                                                try {
                                                                                                                                    Slog.i(TAG, "Search Service");
                                                                                                                                    ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                                                } catch (Throwable e422222) {
                                                                                                                                    reportWtf("starting Search Service", e422222);
                                                                                                                                }
                                                                                                                            }
                                                                                                                            Slog.i(TAG, "DropBox Service");
                                                                                                                            ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                                            Slog.i(TAG, "Wallpaper Service");
                                                                                                                            wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                                            ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                                            wallpaper = wallpaperManagerService;
                                                                                                                            Slog.i(TAG, "Audio Service");
                                                                                                                            audioService = new AudioService(context);
                                                                                                                            ServiceManager.addService("audio", audioService);
                                                                                                                            audioService2 = audioService;
                                                                                                                            if (!disableNonCoreServices) {
                                                                                                                                this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                                            }
                                                                                                                            if (!disableMedia) {
                                                                                                                                try {
                                                                                                                                    Slog.i(TAG, "Wired Accessory Manager");
                                                                                                                                    inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                                                } catch (Throwable e4222222) {
                                                                                                                                    reportWtf("starting WiredAccessoryManager", e4222222);
                                                                                                                                }
                                                                                                                            }
                                                                                                                            if (!disableNonCoreServices) {
                                                                                                                                this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                                                try {
                                                                                                                                    Slog.i(TAG, "Serial Service");
                                                                                                                                    serialService = new SerialService(context);
                                                                                                                                    try {
                                                                                                                                        ServiceManager.addService("serial", serialService);
                                                                                                                                        serialService2 = serialService;
                                                                                                                                    } catch (Throwable th10) {
                                                                                                                                        e4222222 = th10;
                                                                                                                                        serialService2 = serialService;
                                                                                                                                        Slog.e(TAG, "Failure starting SerialService", e4222222);
                                                                                                                                        this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                                                        this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                                                        this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                                                        if (!disableNonCoreServices) {
                                                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                                                                this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                                                            }
                                                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                                                                this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                                                            }
                                                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                                                                this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                        Slog.i(TAG, "DiskStats Service");
                                                                                                                                        ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                                                        Slog.i(TAG, "SamplingProfiler Service");
                                                                                                                                        ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                                                        Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                                                        networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                                                        if (!disableMedia) {
                                                                                                                                            try {
                                                                                                                                                Slog.i(TAG, "CommonTimeManagementService");
                                                                                                                                                commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                                                                try {
                                                                                                                                                    ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                                                                    commonTimeMgmtService = commonTimeManagementService;
                                                                                                                                                } catch (Throwable th11) {
                                                                                                                                                    e4222222 = th11;
                                                                                                                                                    commonTimeMgmtService = commonTimeManagementService;
                                                                                                                                                    reportWtf("starting CommonTimeManagementService service", e4222222);
                                                                                                                                                    if (!disableNetwork) {
                                                                                                                                                        try {
                                                                                                                                                            Slog.i(TAG, "CertBlacklister");
                                                                                                                                                            certBlacklister = new CertBlacklister(context);
                                                                                                                                                        } catch (Throwable e42222222) {
                                                                                                                                                            reportWtf("starting CertBlacklister", e42222222);
                                                                                                                                                        }
                                                                                                                                                    }
                                                                                                                                                    if (!disableNonCoreServices) {
                                                                                                                                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                                                                    }
                                                                                                                                                    Slog.i(TAG, "Assets Atlas Service");
                                                                                                                                                    assetAtlasService = new AssetAtlasService(context);
                                                                                                                                                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                                                                    atlas = assetAtlasService;
                                                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                                                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                                                                    }
                                                                                                                                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                                                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                                                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                                                                    }
                                                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                                                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                                                                    }
                                                                                                                                                    if (!disableNonCoreServices) {
                                                                                                                                                        try {
                                                                                                                                                            Slog.i(TAG, "Media Router Service");
                                                                                                                                                            mediaRouterService = new MediaRouterService(context);
                                                                                                                                                            try {
                                                                                                                                                                ServiceManager.addService("media_router", mediaRouterService);
                                                                                                                                                                mediaRouter = mediaRouterService;
                                                                                                                                                            } catch (Throwable th12) {
                                                                                                                                                                e42222222 = th12;
                                                                                                                                                                mediaRouter = mediaRouterService;
                                                                                                                                                                reportWtf("starting MediaRouterService", e42222222);
                                                                                                                                                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                                                                this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                                                                Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                                                                BackgroundDexOptService.schedule(context);
                                                                                                                                                                this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                                                                                if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                                                                    try {
                                                                                                                                                                        WBC_SERVICE_NAME = "wbc_service";
                                                                                                                                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                                                                                    } catch (Throwable e422222222) {
                                                                                                                                                                        reportWtf("starting WipowerBatteryControl Service", e422222222);
                                                                                                                                                                    }
                                                                                                                                                                } else {
                                                                                                                                                                    Slog.d(TAG, "Wipower not supported");
                                                                                                                                                                }
                                                                                                                                                                if (!disableNonCoreServices) {
                                                                                                                                                                    this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                                                                                }
                                                                                                                                                                safeMode = wm.detectSafeMode();
                                                                                                                                                                if (safeMode) {
                                                                                                                                                                    this.mActivityManagerService.enterSafeMode();
                                                                                                                                                                    VMRuntime.getRuntime().disableJitCompilation();
                                                                                                                                                                } else {
                                                                                                                                                                    VMRuntime.getRuntime().startJitCompilation();
                                                                                                                                                                }
                                                                                                                                                                mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                                                                                vibrator.systemReady();
                                                                                                                                                                if (lockSettings != null) {
                                                                                                                                                                    try {
                                                                                                                                                                        lockSettings.systemReady();
                                                                                                                                                                    } catch (Throwable e4222222222) {
                                                                                                                                                                        reportWtf("making Lock Settings Service ready", e4222222222);
                                                                                                                                                                    }
                                                                                                                                                                }
                                                                                                                                                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                                                                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                                                                                wm.systemReady();
                                                                                                                                                                if (safeMode) {
                                                                                                                                                                    this.mActivityManagerService.showSafeModeOverlay();
                                                                                                                                                                }
                                                                                                                                                                config = wm.computeNewConfiguration();
                                                                                                                                                                metrics = new DisplayMetrics();
                                                                                                                                                                ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                                                                                context.getResources().updateConfiguration(config, metrics);
                                                                                                                                                                this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                                                                                this.mPackageManagerService.systemReady();
                                                                                                                                                                this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                                                                                audioServiceF = audioService2;
                                                                                                                                                                this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                                                                            }
                                                                                                                                                        } catch (Throwable th13) {
                                                                                                                                                            e4222222222 = th13;
                                                                                                                                                            reportWtf("starting MediaRouterService", e4222222222);
                                                                                                                                                            this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                                                            this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                                                            BackgroundDexOptService.schedule(context);
                                                                                                                                                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                                                                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                                                                Slog.d(TAG, "Wipower not supported");
                                                                                                                                                            } else {
                                                                                                                                                                WBC_SERVICE_NAME = "wbc_service";
                                                                                                                                                                Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                                                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                                                                Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                                                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                                                                            }
                                                                                                                                                            if (disableNonCoreServices) {
                                                                                                                                                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                                                                            }
                                                                                                                                                            safeMode = wm.detectSafeMode();
                                                                                                                                                            if (safeMode) {
                                                                                                                                                                VMRuntime.getRuntime().startJitCompilation();
                                                                                                                                                            } else {
                                                                                                                                                                this.mActivityManagerService.enterSafeMode();
                                                                                                                                                                VMRuntime.getRuntime().disableJitCompilation();
                                                                                                                                                            }
                                                                                                                                                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                                                                            vibrator.systemReady();
                                                                                                                                                            if (lockSettings != null) {
                                                                                                                                                                lockSettings.systemReady();
                                                                                                                                                            }
                                                                                                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                                                                            wm.systemReady();
                                                                                                                                                            if (safeMode) {
                                                                                                                                                                this.mActivityManagerService.showSafeModeOverlay();
                                                                                                                                                            }
                                                                                                                                                            config = wm.computeNewConfiguration();
                                                                                                                                                            metrics = new DisplayMetrics();
                                                                                                                                                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                                                                            context.getResources().updateConfiguration(config, metrics);
                                                                                                                                                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                                                                            this.mPackageManagerService.systemReady();
                                                                                                                                                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                                                                            audioServiceF = audioService2;
                                                                                                                                                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                                                                        }
                                                                                                                                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                                                        try {
                                                                                                                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                                                            BackgroundDexOptService.schedule(context);
                                                                                                                                                        } catch (Throwable e42222222222) {
                                                                                                                                                            reportWtf("starting BackgroundDexOptService", e42222222222);
                                                                                                                                                        }
                                                                                                                                                    }
                                                                                                                                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                                                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                                                        Slog.d(TAG, "Wipower not supported");
                                                                                                                                                    } else {
                                                                                                                                                        WBC_SERVICE_NAME = "wbc_service";
                                                                                                                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                                                                    }
                                                                                                                                                    if (disableNonCoreServices) {
                                                                                                                                                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                                                                    }
                                                                                                                                                    safeMode = wm.detectSafeMode();
                                                                                                                                                    if (safeMode) {
                                                                                                                                                        VMRuntime.getRuntime().startJitCompilation();
                                                                                                                                                    } else {
                                                                                                                                                        this.mActivityManagerService.enterSafeMode();
                                                                                                                                                        VMRuntime.getRuntime().disableJitCompilation();
                                                                                                                                                    }
                                                                                                                                                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                                                                    vibrator.systemReady();
                                                                                                                                                    if (lockSettings != null) {
                                                                                                                                                        lockSettings.systemReady();
                                                                                                                                                    }
                                                                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                                                                    wm.systemReady();
                                                                                                                                                    if (safeMode) {
                                                                                                                                                        this.mActivityManagerService.showSafeModeOverlay();
                                                                                                                                                    }
                                                                                                                                                    config = wm.computeNewConfiguration();
                                                                                                                                                    metrics = new DisplayMetrics();
                                                                                                                                                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                                                                    context.getResources().updateConfiguration(config, metrics);
                                                                                                                                                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                                                                    this.mPackageManagerService.systemReady();
                                                                                                                                                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                                                                    audioServiceF = audioService2;
                                                                                                                                                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                                                                }
                                                                                                                                            } catch (Throwable th14) {
                                                                                                                                                e42222222222 = th14;
                                                                                                                                                reportWtf("starting CommonTimeManagementService service", e42222222222);
                                                                                                                                                if (disableNetwork) {
                                                                                                                                                    Slog.i(TAG, "CertBlacklister");
                                                                                                                                                    certBlacklister = new CertBlacklister(context);
                                                                                                                                                }
                                                                                                                                                if (disableNonCoreServices) {
                                                                                                                                                    this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                                                                }
                                                                                                                                                Slog.i(TAG, "Assets Atlas Service");
                                                                                                                                                assetAtlasService = new AssetAtlasService(context);
                                                                                                                                                ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                                                                atlas = assetAtlasService;
                                                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                                                                    this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                                                                }
                                                                                                                                                this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                                                                this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                                                                if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                                                                    this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                                                                }
                                                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                                                                    this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                                                                }
                                                                                                                                                if (disableNonCoreServices) {
                                                                                                                                                    Slog.i(TAG, "Media Router Service");
                                                                                                                                                    mediaRouterService = new MediaRouterService(context);
                                                                                                                                                    ServiceManager.addService("media_router", mediaRouterService);
                                                                                                                                                    mediaRouter = mediaRouterService;
                                                                                                                                                    this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                                                    this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                                                    Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                                                    BackgroundDexOptService.schedule(context);
                                                                                                                                                }
                                                                                                                                                this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                                                                if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                                                    WBC_SERVICE_NAME = "wbc_service";
                                                                                                                                                    Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                                                    wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                                                    Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                                                    ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                                                                } else {
                                                                                                                                                    Slog.d(TAG, "Wipower not supported");
                                                                                                                                                }
                                                                                                                                                if (disableNonCoreServices) {
                                                                                                                                                    this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                                                                }
                                                                                                                                                safeMode = wm.detectSafeMode();
                                                                                                                                                if (safeMode) {
                                                                                                                                                    this.mActivityManagerService.enterSafeMode();
                                                                                                                                                    VMRuntime.getRuntime().disableJitCompilation();
                                                                                                                                                } else {
                                                                                                                                                    VMRuntime.getRuntime().startJitCompilation();
                                                                                                                                                }
                                                                                                                                                mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                                                                vibrator.systemReady();
                                                                                                                                                if (lockSettings != null) {
                                                                                                                                                    lockSettings.systemReady();
                                                                                                                                                }
                                                                                                                                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                                                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                                                                wm.systemReady();
                                                                                                                                                if (safeMode) {
                                                                                                                                                    this.mActivityManagerService.showSafeModeOverlay();
                                                                                                                                                }
                                                                                                                                                config = wm.computeNewConfiguration();
                                                                                                                                                metrics = new DisplayMetrics();
                                                                                                                                                ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                                                                context.getResources().updateConfiguration(config, metrics);
                                                                                                                                                this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                                                                this.mPackageManagerService.systemReady();
                                                                                                                                                this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                                                                audioServiceF = audioService2;
                                                                                                                                                this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                        if (disableNetwork) {
                                                                                                                                            Slog.i(TAG, "CertBlacklister");
                                                                                                                                            certBlacklister = new CertBlacklister(context);
                                                                                                                                        }
                                                                                                                                        if (disableNonCoreServices) {
                                                                                                                                            this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                                                        }
                                                                                                                                        Slog.i(TAG, "Assets Atlas Service");
                                                                                                                                        assetAtlasService = new AssetAtlasService(context);
                                                                                                                                        ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                                                        atlas = assetAtlasService;
                                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                                                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                                                        }
                                                                                                                                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                                                        this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                                                            this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                                                        }
                                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                                                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                                                        }
                                                                                                                                        if (disableNonCoreServices) {
                                                                                                                                            Slog.i(TAG, "Media Router Service");
                                                                                                                                            mediaRouterService = new MediaRouterService(context);
                                                                                                                                            ServiceManager.addService("media_router", mediaRouterService);
                                                                                                                                            mediaRouter = mediaRouterService;
                                                                                                                                            this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                                            this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                                            BackgroundDexOptService.schedule(context);
                                                                                                                                        }
                                                                                                                                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                                                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                                            WBC_SERVICE_NAME = "wbc_service";
                                                                                                                                            Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                                            Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                                                        } else {
                                                                                                                                            Slog.d(TAG, "Wipower not supported");
                                                                                                                                        }
                                                                                                                                        if (disableNonCoreServices) {
                                                                                                                                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                                                        }
                                                                                                                                        safeMode = wm.detectSafeMode();
                                                                                                                                        if (safeMode) {
                                                                                                                                            this.mActivityManagerService.enterSafeMode();
                                                                                                                                            VMRuntime.getRuntime().disableJitCompilation();
                                                                                                                                        } else {
                                                                                                                                            VMRuntime.getRuntime().startJitCompilation();
                                                                                                                                        }
                                                                                                                                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                                                        vibrator.systemReady();
                                                                                                                                        if (lockSettings != null) {
                                                                                                                                            lockSettings.systemReady();
                                                                                                                                        }
                                                                                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                                                        wm.systemReady();
                                                                                                                                        if (safeMode) {
                                                                                                                                            this.mActivityManagerService.showSafeModeOverlay();
                                                                                                                                        }
                                                                                                                                        config = wm.computeNewConfiguration();
                                                                                                                                        metrics = new DisplayMetrics();
                                                                                                                                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                                                        context.getResources().updateConfiguration(config, metrics);
                                                                                                                                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                                                        this.mPackageManagerService.systemReady();
                                                                                                                                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                                                        audioServiceF = audioService2;
                                                                                                                                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                                                    }
                                                                                                                                } catch (Throwable th15) {
                                                                                                                                    e42222222222 = th15;
                                                                                                                                    Slog.e(TAG, "Failure starting SerialService", e42222222222);
                                                                                                                                    this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                                                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                                                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                                                    if (disableNonCoreServices) {
                                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                                                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                                                        }
                                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                                                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                                                        }
                                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                                                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                    Slog.i(TAG, "DiskStats Service");
                                                                                                                                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                                                    Slog.i(TAG, "SamplingProfiler Service");
                                                                                                                                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                                                    Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                                                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                                                    if (disableMedia) {
                                                                                                                                        Slog.i(TAG, "CommonTimeManagementService");
                                                                                                                                        commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                                                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                                                        commonTimeMgmtService = commonTimeManagementService;
                                                                                                                                    }
                                                                                                                                    if (disableNetwork) {
                                                                                                                                        Slog.i(TAG, "CertBlacklister");
                                                                                                                                        certBlacklister = new CertBlacklister(context);
                                                                                                                                    }
                                                                                                                                    if (disableNonCoreServices) {
                                                                                                                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                                                    }
                                                                                                                                    Slog.i(TAG, "Assets Atlas Service");
                                                                                                                                    assetAtlasService = new AssetAtlasService(context);
                                                                                                                                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                                                    atlas = assetAtlasService;
                                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                                                    }
                                                                                                                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                                                    }
                                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                                                    }
                                                                                                                                    if (disableNonCoreServices) {
                                                                                                                                        Slog.i(TAG, "Media Router Service");
                                                                                                                                        mediaRouterService = new MediaRouterService(context);
                                                                                                                                        ServiceManager.addService("media_router", mediaRouterService);
                                                                                                                                        mediaRouter = mediaRouterService;
                                                                                                                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                                        Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                                        BackgroundDexOptService.schedule(context);
                                                                                                                                    }
                                                                                                                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                                        WBC_SERVICE_NAME = "wbc_service";
                                                                                                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                                                    } else {
                                                                                                                                        Slog.d(TAG, "Wipower not supported");
                                                                                                                                    }
                                                                                                                                    if (disableNonCoreServices) {
                                                                                                                                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                                                    }
                                                                                                                                    safeMode = wm.detectSafeMode();
                                                                                                                                    if (safeMode) {
                                                                                                                                        this.mActivityManagerService.enterSafeMode();
                                                                                                                                        VMRuntime.getRuntime().disableJitCompilation();
                                                                                                                                    } else {
                                                                                                                                        VMRuntime.getRuntime().startJitCompilation();
                                                                                                                                    }
                                                                                                                                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                                                    vibrator.systemReady();
                                                                                                                                    if (lockSettings != null) {
                                                                                                                                        lockSettings.systemReady();
                                                                                                                                    }
                                                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                                                    wm.systemReady();
                                                                                                                                    if (safeMode) {
                                                                                                                                        this.mActivityManagerService.showSafeModeOverlay();
                                                                                                                                    }
                                                                                                                                    config = wm.computeNewConfiguration();
                                                                                                                                    metrics = new DisplayMetrics();
                                                                                                                                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                                                    context.getResources().updateConfiguration(config, metrics);
                                                                                                                                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                                                    this.mPackageManagerService.systemReady();
                                                                                                                                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                                                    audioServiceF = audioService2;
                                                                                                                                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                                                }
                                                                                                                            }
                                                                                                                            this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                                            this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                                            this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                                            if (disableNonCoreServices) {
                                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                                                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                                                }
                                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                                                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                                                }
                                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                                                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                                                }
                                                                                                                            }
                                                                                                                            Slog.i(TAG, "DiskStats Service");
                                                                                                                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                                            Slog.i(TAG, "SamplingProfiler Service");
                                                                                                                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                                            Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                                            if (disableMedia) {
                                                                                                                                Slog.i(TAG, "CommonTimeManagementService");
                                                                                                                                commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                                                ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                                                commonTimeMgmtService = commonTimeManagementService;
                                                                                                                            }
                                                                                                                            if (disableNetwork) {
                                                                                                                                Slog.i(TAG, "CertBlacklister");
                                                                                                                                certBlacklister = new CertBlacklister(context);
                                                                                                                            }
                                                                                                                            if (disableNonCoreServices) {
                                                                                                                                this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                                            }
                                                                                                                            Slog.i(TAG, "Assets Atlas Service");
                                                                                                                            assetAtlasService = new AssetAtlasService(context);
                                                                                                                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                                            atlas = assetAtlasService;
                                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                                            }
                                                                                                                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                                            this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                                                this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                                            }
                                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                                            }
                                                                                                                            if (disableNonCoreServices) {
                                                                                                                                Slog.i(TAG, "Media Router Service");
                                                                                                                                mediaRouterService = new MediaRouterService(context);
                                                                                                                                ServiceManager.addService("media_router", mediaRouterService);
                                                                                                                                mediaRouter = mediaRouterService;
                                                                                                                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                                this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                                Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                                BackgroundDexOptService.schedule(context);
                                                                                                                            }
                                                                                                                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                                WBC_SERVICE_NAME = "wbc_service";
                                                                                                                                Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                                Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                                            } else {
                                                                                                                                Slog.d(TAG, "Wipower not supported");
                                                                                                                            }
                                                                                                                            if (disableNonCoreServices) {
                                                                                                                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                                            }
                                                                                                                            safeMode = wm.detectSafeMode();
                                                                                                                            if (safeMode) {
                                                                                                                                this.mActivityManagerService.enterSafeMode();
                                                                                                                                VMRuntime.getRuntime().disableJitCompilation();
                                                                                                                            } else {
                                                                                                                                VMRuntime.getRuntime().startJitCompilation();
                                                                                                                            }
                                                                                                                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                                            vibrator.systemReady();
                                                                                                                            if (lockSettings != null) {
                                                                                                                                lockSettings.systemReady();
                                                                                                                            }
                                                                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                                            wm.systemReady();
                                                                                                                            if (safeMode) {
                                                                                                                                this.mActivityManagerService.showSafeModeOverlay();
                                                                                                                            }
                                                                                                                            config = wm.computeNewConfiguration();
                                                                                                                            metrics = new DisplayMetrics();
                                                                                                                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                                            context.getResources().updateConfiguration(config, metrics);
                                                                                                                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                                            this.mPackageManagerService.systemReady();
                                                                                                                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                                            audioServiceF = audioService2;
                                                                                                                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                                        }
                                                                                                                        if (disableNonCoreServices) {
                                                                                                                            Slog.i(TAG, "Search Service");
                                                                                                                            ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                                        }
                                                                                                                        Slog.i(TAG, "DropBox Service");
                                                                                                                        ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                                        Slog.i(TAG, "Wallpaper Service");
                                                                                                                        wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                                        ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                                        wallpaper = wallpaperManagerService;
                                                                                                                        Slog.i(TAG, "Audio Service");
                                                                                                                        audioService = new AudioService(context);
                                                                                                                        ServiceManager.addService("audio", audioService);
                                                                                                                        audioService2 = audioService;
                                                                                                                        if (disableNonCoreServices) {
                                                                                                                            this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                                        }
                                                                                                                        if (disableMedia) {
                                                                                                                            Slog.i(TAG, "Wired Accessory Manager");
                                                                                                                            inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                                        }
                                                                                                                        if (disableNonCoreServices) {
                                                                                                                            this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                                            Slog.i(TAG, "Serial Service");
                                                                                                                            serialService = new SerialService(context);
                                                                                                                            ServiceManager.addService("serial", serialService);
                                                                                                                            serialService2 = serialService;
                                                                                                                        }
                                                                                                                        this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                                        this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                                        this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                                        if (disableNonCoreServices) {
                                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                                                this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                                            }
                                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                                                this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                                            }
                                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                                                this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                                            }
                                                                                                                        }
                                                                                                                        Slog.i(TAG, "DiskStats Service");
                                                                                                                        ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                                        Slog.i(TAG, "SamplingProfiler Service");
                                                                                                                        ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                                        Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                                        networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                                        if (disableMedia) {
                                                                                                                            Slog.i(TAG, "CommonTimeManagementService");
                                                                                                                            commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                                            ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                                            commonTimeMgmtService = commonTimeManagementService;
                                                                                                                        }
                                                                                                                        if (disableNetwork) {
                                                                                                                            Slog.i(TAG, "CertBlacklister");
                                                                                                                            certBlacklister = new CertBlacklister(context);
                                                                                                                        }
                                                                                                                        if (disableNonCoreServices) {
                                                                                                                            this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                                        }
                                                                                                                        Slog.i(TAG, "Assets Atlas Service");
                                                                                                                        assetAtlasService = new AssetAtlasService(context);
                                                                                                                        ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                                        atlas = assetAtlasService;
                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                                        }
                                                                                                                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                                        this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                                            this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                                        }
                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                                        }
                                                                                                                        if (disableNonCoreServices) {
                                                                                                                            Slog.i(TAG, "Media Router Service");
                                                                                                                            mediaRouterService = new MediaRouterService(context);
                                                                                                                            ServiceManager.addService("media_router", mediaRouterService);
                                                                                                                            mediaRouter = mediaRouterService;
                                                                                                                            this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                            this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                            BackgroundDexOptService.schedule(context);
                                                                                                                        }
                                                                                                                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                            Slog.d(TAG, "Wipower not supported");
                                                                                                                        } else {
                                                                                                                            WBC_SERVICE_NAME = "wbc_service";
                                                                                                                            Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                            Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                                        }
                                                                                                                        if (disableNonCoreServices) {
                                                                                                                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                                        }
                                                                                                                        safeMode = wm.detectSafeMode();
                                                                                                                        if (safeMode) {
                                                                                                                            VMRuntime.getRuntime().startJitCompilation();
                                                                                                                        } else {
                                                                                                                            this.mActivityManagerService.enterSafeMode();
                                                                                                                            VMRuntime.getRuntime().disableJitCompilation();
                                                                                                                        }
                                                                                                                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                                        vibrator.systemReady();
                                                                                                                        if (lockSettings != null) {
                                                                                                                            lockSettings.systemReady();
                                                                                                                        }
                                                                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                                        wm.systemReady();
                                                                                                                        if (safeMode) {
                                                                                                                            this.mActivityManagerService.showSafeModeOverlay();
                                                                                                                        }
                                                                                                                        config = wm.computeNewConfiguration();
                                                                                                                        metrics = new DisplayMetrics();
                                                                                                                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                                        context.getResources().updateConfiguration(config, metrics);
                                                                                                                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                                        this.mPackageManagerService.systemReady();
                                                                                                                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                                        audioServiceF = audioService2;
                                                                                                                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                                    }
                                                                                                                } catch (Throwable th16) {
                                                                                                                    e42222222222 = th16;
                                                                                                                    reportWtf("starting Location Manager", e42222222222);
                                                                                                                    Slog.i(TAG, "Country Detector");
                                                                                                                    countryDetectorService = new CountryDetectorService(context);
                                                                                                                    ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                                    countryDetector = countryDetectorService;
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        Slog.i(TAG, "Search Service");
                                                                                                                        ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                                    }
                                                                                                                    Slog.i(TAG, "DropBox Service");
                                                                                                                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                                    Slog.i(TAG, "Wallpaper Service");
                                                                                                                    wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                                    ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                                    wallpaper = wallpaperManagerService;
                                                                                                                    Slog.i(TAG, "Audio Service");
                                                                                                                    audioService = new AudioService(context);
                                                                                                                    ServiceManager.addService("audio", audioService);
                                                                                                                    audioService2 = audioService;
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                                    }
                                                                                                                    if (disableMedia) {
                                                                                                                        Slog.i(TAG, "Wired Accessory Manager");
                                                                                                                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                                    }
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                                        Slog.i(TAG, "Serial Service");
                                                                                                                        serialService = new SerialService(context);
                                                                                                                        ServiceManager.addService("serial", serialService);
                                                                                                                        serialService2 = serialService;
                                                                                                                    }
                                                                                                                    this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                                        }
                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                                        }
                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                                        }
                                                                                                                    }
                                                                                                                    Slog.i(TAG, "DiskStats Service");
                                                                                                                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                                    Slog.i(TAG, "SamplingProfiler Service");
                                                                                                                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                                    Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                                    if (disableMedia) {
                                                                                                                        Slog.i(TAG, "CommonTimeManagementService");
                                                                                                                        commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                                        commonTimeMgmtService = commonTimeManagementService;
                                                                                                                    }
                                                                                                                    if (disableNetwork) {
                                                                                                                        Slog.i(TAG, "CertBlacklister");
                                                                                                                        certBlacklister = new CertBlacklister(context);
                                                                                                                    }
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                                    }
                                                                                                                    Slog.i(TAG, "Assets Atlas Service");
                                                                                                                    assetAtlasService = new AssetAtlasService(context);
                                                                                                                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                                    atlas = assetAtlasService;
                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                                    }
                                                                                                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                                    }
                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                                    }
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        Slog.i(TAG, "Media Router Service");
                                                                                                                        mediaRouterService = new MediaRouterService(context);
                                                                                                                        ServiceManager.addService("media_router", mediaRouterService);
                                                                                                                        mediaRouter = mediaRouterService;
                                                                                                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                        Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                        BackgroundDexOptService.schedule(context);
                                                                                                                    }
                                                                                                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                        Slog.d(TAG, "Wipower not supported");
                                                                                                                    } else {
                                                                                                                        WBC_SERVICE_NAME = "wbc_service";
                                                                                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                                    }
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                                    }
                                                                                                                    safeMode = wm.detectSafeMode();
                                                                                                                    if (safeMode) {
                                                                                                                        VMRuntime.getRuntime().startJitCompilation();
                                                                                                                    } else {
                                                                                                                        this.mActivityManagerService.enterSafeMode();
                                                                                                                        VMRuntime.getRuntime().disableJitCompilation();
                                                                                                                    }
                                                                                                                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                                    vibrator.systemReady();
                                                                                                                    if (lockSettings != null) {
                                                                                                                        lockSettings.systemReady();
                                                                                                                    }
                                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                                    wm.systemReady();
                                                                                                                    if (safeMode) {
                                                                                                                        this.mActivityManagerService.showSafeModeOverlay();
                                                                                                                    }
                                                                                                                    config = wm.computeNewConfiguration();
                                                                                                                    metrics = new DisplayMetrics();
                                                                                                                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                                    context.getResources().updateConfiguration(config, metrics);
                                                                                                                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                                    this.mPackageManagerService.systemReady();
                                                                                                                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                                    audioServiceF = audioService2;
                                                                                                                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                                }
                                                                                                                try {
                                                                                                                    Slog.i(TAG, "Country Detector");
                                                                                                                    countryDetectorService = new CountryDetectorService(context);
                                                                                                                    ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                                    countryDetector = countryDetectorService;
                                                                                                                } catch (Throwable th17) {
                                                                                                                    e42222222222 = th17;
                                                                                                                    reportWtf("starting Country Detector", e42222222222);
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        Slog.i(TAG, "Search Service");
                                                                                                                        ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                                    }
                                                                                                                    Slog.i(TAG, "DropBox Service");
                                                                                                                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                                    Slog.i(TAG, "Wallpaper Service");
                                                                                                                    wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                                    ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                                    wallpaper = wallpaperManagerService;
                                                                                                                    Slog.i(TAG, "Audio Service");
                                                                                                                    audioService = new AudioService(context);
                                                                                                                    ServiceManager.addService("audio", audioService);
                                                                                                                    audioService2 = audioService;
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                                    }
                                                                                                                    if (disableMedia) {
                                                                                                                        Slog.i(TAG, "Wired Accessory Manager");
                                                                                                                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                                    }
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                                        Slog.i(TAG, "Serial Service");
                                                                                                                        serialService = new SerialService(context);
                                                                                                                        ServiceManager.addService("serial", serialService);
                                                                                                                        serialService2 = serialService;
                                                                                                                    }
                                                                                                                    this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                                        }
                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                                        }
                                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                                        }
                                                                                                                    }
                                                                                                                    Slog.i(TAG, "DiskStats Service");
                                                                                                                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                                    Slog.i(TAG, "SamplingProfiler Service");
                                                                                                                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                                    Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                                    if (disableMedia) {
                                                                                                                        Slog.i(TAG, "CommonTimeManagementService");
                                                                                                                        commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                                        commonTimeMgmtService = commonTimeManagementService;
                                                                                                                    }
                                                                                                                    if (disableNetwork) {
                                                                                                                        Slog.i(TAG, "CertBlacklister");
                                                                                                                        certBlacklister = new CertBlacklister(context);
                                                                                                                    }
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                                    }
                                                                                                                    Slog.i(TAG, "Assets Atlas Service");
                                                                                                                    assetAtlasService = new AssetAtlasService(context);
                                                                                                                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                                    atlas = assetAtlasService;
                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                                    }
                                                                                                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                                    }
                                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                                    }
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        Slog.i(TAG, "Media Router Service");
                                                                                                                        mediaRouterService = new MediaRouterService(context);
                                                                                                                        ServiceManager.addService("media_router", mediaRouterService);
                                                                                                                        mediaRouter = mediaRouterService;
                                                                                                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                        Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                        BackgroundDexOptService.schedule(context);
                                                                                                                    }
                                                                                                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                        Slog.d(TAG, "Wipower not supported");
                                                                                                                    } else {
                                                                                                                        WBC_SERVICE_NAME = "wbc_service";
                                                                                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                                    }
                                                                                                                    if (disableNonCoreServices) {
                                                                                                                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                                    }
                                                                                                                    safeMode = wm.detectSafeMode();
                                                                                                                    if (safeMode) {
                                                                                                                        VMRuntime.getRuntime().startJitCompilation();
                                                                                                                    } else {
                                                                                                                        this.mActivityManagerService.enterSafeMode();
                                                                                                                        VMRuntime.getRuntime().disableJitCompilation();
                                                                                                                    }
                                                                                                                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                                    vibrator.systemReady();
                                                                                                                    if (lockSettings != null) {
                                                                                                                        lockSettings.systemReady();
                                                                                                                    }
                                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                                    wm.systemReady();
                                                                                                                    if (safeMode) {
                                                                                                                        this.mActivityManagerService.showSafeModeOverlay();
                                                                                                                    }
                                                                                                                    config = wm.computeNewConfiguration();
                                                                                                                    metrics = new DisplayMetrics();
                                                                                                                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                                    context.getResources().updateConfiguration(config, metrics);
                                                                                                                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                                    this.mPackageManagerService.systemReady();
                                                                                                                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                                    audioServiceF = audioService2;
                                                                                                                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                                }
                                                                                                            }
                                                                                                            if (disableNonCoreServices) {
                                                                                                                Slog.i(TAG, "Search Service");
                                                                                                                ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                            }
                                                                                                            Slog.i(TAG, "DropBox Service");
                                                                                                            ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                            Slog.i(TAG, "Wallpaper Service");
                                                                                                            wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                            ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                            wallpaper = wallpaperManagerService;
                                                                                                            Slog.i(TAG, "Audio Service");
                                                                                                            audioService = new AudioService(context);
                                                                                                            ServiceManager.addService("audio", audioService);
                                                                                                            audioService2 = audioService;
                                                                                                            if (disableNonCoreServices) {
                                                                                                                this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                            }
                                                                                                            if (disableMedia) {
                                                                                                                Slog.i(TAG, "Wired Accessory Manager");
                                                                                                                inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                            }
                                                                                                            if (disableNonCoreServices) {
                                                                                                                this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                                Slog.i(TAG, "Serial Service");
                                                                                                                serialService = new SerialService(context);
                                                                                                                ServiceManager.addService("serial", serialService);
                                                                                                                serialService2 = serialService;
                                                                                                            }
                                                                                                            this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                            this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                            this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                            if (disableNonCoreServices) {
                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                                }
                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                                }
                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                                }
                                                                                                            }
                                                                                                            Slog.i(TAG, "DiskStats Service");
                                                                                                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                            Slog.i(TAG, "SamplingProfiler Service");
                                                                                                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                            Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                            if (disableMedia) {
                                                                                                                Slog.i(TAG, "CommonTimeManagementService");
                                                                                                                commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                                ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                                commonTimeMgmtService = commonTimeManagementService;
                                                                                                            }
                                                                                                            if (disableNetwork) {
                                                                                                                Slog.i(TAG, "CertBlacklister");
                                                                                                                certBlacklister = new CertBlacklister(context);
                                                                                                            }
                                                                                                            if (disableNonCoreServices) {
                                                                                                                this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                            }
                                                                                                            Slog.i(TAG, "Assets Atlas Service");
                                                                                                            assetAtlasService = new AssetAtlasService(context);
                                                                                                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                            atlas = assetAtlasService;
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                            }
                                                                                                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                            this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                                this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                            }
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                            }
                                                                                                            if (disableNonCoreServices) {
                                                                                                                Slog.i(TAG, "Media Router Service");
                                                                                                                mediaRouterService = new MediaRouterService(context);
                                                                                                                ServiceManager.addService("media_router", mediaRouterService);
                                                                                                                mediaRouter = mediaRouterService;
                                                                                                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                BackgroundDexOptService.schedule(context);
                                                                                                            }
                                                                                                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                WBC_SERVICE_NAME = "wbc_service";
                                                                                                                Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                            } else {
                                                                                                                Slog.d(TAG, "Wipower not supported");
                                                                                                            }
                                                                                                            if (disableNonCoreServices) {
                                                                                                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                            }
                                                                                                            safeMode = wm.detectSafeMode();
                                                                                                            if (safeMode) {
                                                                                                                this.mActivityManagerService.enterSafeMode();
                                                                                                                VMRuntime.getRuntime().disableJitCompilation();
                                                                                                            } else {
                                                                                                                VMRuntime.getRuntime().startJitCompilation();
                                                                                                            }
                                                                                                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                            vibrator.systemReady();
                                                                                                            if (lockSettings != null) {
                                                                                                                lockSettings.systemReady();
                                                                                                            }
                                                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                            wm.systemReady();
                                                                                                            if (safeMode) {
                                                                                                                this.mActivityManagerService.showSafeModeOverlay();
                                                                                                            }
                                                                                                            config = wm.computeNewConfiguration();
                                                                                                            metrics = new DisplayMetrics();
                                                                                                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                            context.getResources().updateConfiguration(config, metrics);
                                                                                                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                            this.mPackageManagerService.systemReady();
                                                                                                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                            audioServiceF = audioService2;
                                                                                                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                        }
                                                                                                        Slog.i(TAG, "NetworkPolicy Service");
                                                                                                        networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                                                                        try {
                                                                                                            ServiceManager.addService("netpolicy", networkPolicy);
                                                                                                        } catch (Throwable th18) {
                                                                                                            e42222222222 = th18;
                                                                                                            reportWtf("starting NetworkPolicy Service", e42222222222);
                                                                                                            this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                                                            this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                                                            this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                                                            this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                                                                this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                                                            }
                                                                                                            Slog.i(TAG, "Connectivity Service");
                                                                                                            connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                                                            ServiceManager.addService("connectivity", connectivityService);
                                                                                                            networkStats.bindConnectivityManager(connectivityService);
                                                                                                            networkPolicy.bindConnectivityManager(connectivityService);
                                                                                                            connectivity = connectivityService;
                                                                                                            Slog.i(TAG, "Network Service Discovery Service");
                                                                                                            ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                                            Slog.i(TAG, "DPM Service");
                                                                                                            startDpmService(context);
                                                                                                            if (disableNonCoreServices) {
                                                                                                                Slog.i(TAG, "UpdateLock Service");
                                                                                                                ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                                            }
                                                                                                            mountService2.waitForAsecScan();
                                                                                                            if (accountManagerService != null) {
                                                                                                                accountManagerService.systemReady();
                                                                                                            }
                                                                                                            if (contentService != null) {
                                                                                                                contentService.systemReady();
                                                                                                            }
                                                                                                            this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                                            networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                                            this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                                            if (disableLocation) {
                                                                                                                Slog.i(TAG, "Location Manager");
                                                                                                                locationManagerService = new LocationManagerService(context);
                                                                                                                ServiceManager.addService("location", locationManagerService);
                                                                                                                location = locationManagerService;
                                                                                                                Slog.i(TAG, "Country Detector");
                                                                                                                countryDetectorService = new CountryDetectorService(context);
                                                                                                                ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                                countryDetector = countryDetectorService;
                                                                                                            }
                                                                                                            if (disableNonCoreServices) {
                                                                                                                Slog.i(TAG, "Search Service");
                                                                                                                ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                            }
                                                                                                            Slog.i(TAG, "DropBox Service");
                                                                                                            ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                            Slog.i(TAG, "Wallpaper Service");
                                                                                                            wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                            ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                            wallpaper = wallpaperManagerService;
                                                                                                            Slog.i(TAG, "Audio Service");
                                                                                                            audioService = new AudioService(context);
                                                                                                            ServiceManager.addService("audio", audioService);
                                                                                                            audioService2 = audioService;
                                                                                                            if (disableNonCoreServices) {
                                                                                                                this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                            }
                                                                                                            if (disableMedia) {
                                                                                                                Slog.i(TAG, "Wired Accessory Manager");
                                                                                                                inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                            }
                                                                                                            if (disableNonCoreServices) {
                                                                                                                this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                                Slog.i(TAG, "Serial Service");
                                                                                                                serialService = new SerialService(context);
                                                                                                                ServiceManager.addService("serial", serialService);
                                                                                                                serialService2 = serialService;
                                                                                                            }
                                                                                                            this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                            this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                            this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                            if (disableNonCoreServices) {
                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                                }
                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                                }
                                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                                }
                                                                                                            }
                                                                                                            Slog.i(TAG, "DiskStats Service");
                                                                                                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                            Slog.i(TAG, "SamplingProfiler Service");
                                                                                                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                            Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                            if (disableMedia) {
                                                                                                                Slog.i(TAG, "CommonTimeManagementService");
                                                                                                                commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                                ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                                commonTimeMgmtService = commonTimeManagementService;
                                                                                                            }
                                                                                                            if (disableNetwork) {
                                                                                                                Slog.i(TAG, "CertBlacklister");
                                                                                                                certBlacklister = new CertBlacklister(context);
                                                                                                            }
                                                                                                            if (disableNonCoreServices) {
                                                                                                                this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                            }
                                                                                                            Slog.i(TAG, "Assets Atlas Service");
                                                                                                            assetAtlasService = new AssetAtlasService(context);
                                                                                                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                            atlas = assetAtlasService;
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                            }
                                                                                                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                            this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                                this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                            }
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                            }
                                                                                                            if (disableNonCoreServices) {
                                                                                                                Slog.i(TAG, "Media Router Service");
                                                                                                                mediaRouterService = new MediaRouterService(context);
                                                                                                                ServiceManager.addService("media_router", mediaRouterService);
                                                                                                                mediaRouter = mediaRouterService;
                                                                                                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                                this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                                Slog.i(TAG, "BackgroundDexOptService");
                                                                                                                BackgroundDexOptService.schedule(context);
                                                                                                            }
                                                                                                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                                Slog.d(TAG, "Wipower not supported");
                                                                                                            } else {
                                                                                                                WBC_SERVICE_NAME = "wbc_service";
                                                                                                                Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                                Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                            }
                                                                                                            if (disableNonCoreServices) {
                                                                                                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                            }
                                                                                                            safeMode = wm.detectSafeMode();
                                                                                                            if (safeMode) {
                                                                                                                VMRuntime.getRuntime().startJitCompilation();
                                                                                                            } else {
                                                                                                                this.mActivityManagerService.enterSafeMode();
                                                                                                                VMRuntime.getRuntime().disableJitCompilation();
                                                                                                            }
                                                                                                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                            vibrator.systemReady();
                                                                                                            if (lockSettings != null) {
                                                                                                                lockSettings.systemReady();
                                                                                                            }
                                                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                            wm.systemReady();
                                                                                                            if (safeMode) {
                                                                                                                this.mActivityManagerService.showSafeModeOverlay();
                                                                                                            }
                                                                                                            config = wm.computeNewConfiguration();
                                                                                                            metrics = new DisplayMetrics();
                                                                                                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                            context.getResources().updateConfiguration(config, metrics);
                                                                                                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                            this.mPackageManagerService.systemReady();
                                                                                                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                            audioServiceF = audioService2;
                                                                                                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                                                        this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                                                        this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                                                        this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                                                            this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                                                        }
                                                                                                        Slog.i(TAG, "Connectivity Service");
                                                                                                        connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                                                        ServiceManager.addService("connectivity", connectivityService);
                                                                                                        networkStats.bindConnectivityManager(connectivityService);
                                                                                                        networkPolicy.bindConnectivityManager(connectivityService);
                                                                                                        connectivity = connectivityService;
                                                                                                        Slog.i(TAG, "Network Service Discovery Service");
                                                                                                        ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                                        Slog.i(TAG, "DPM Service");
                                                                                                        startDpmService(context);
                                                                                                        if (disableNonCoreServices) {
                                                                                                            Slog.i(TAG, "UpdateLock Service");
                                                                                                            ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                                        }
                                                                                                        mountService2.waitForAsecScan();
                                                                                                        if (accountManagerService != null) {
                                                                                                            accountManagerService.systemReady();
                                                                                                        }
                                                                                                        if (contentService != null) {
                                                                                                            contentService.systemReady();
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                                        networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                                        this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                                        if (disableLocation) {
                                                                                                            Slog.i(TAG, "Location Manager");
                                                                                                            locationManagerService = new LocationManagerService(context);
                                                                                                            ServiceManager.addService("location", locationManagerService);
                                                                                                            location = locationManagerService;
                                                                                                            Slog.i(TAG, "Country Detector");
                                                                                                            countryDetectorService = new CountryDetectorService(context);
                                                                                                            ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                            countryDetector = countryDetectorService;
                                                                                                        }
                                                                                                        if (disableNonCoreServices) {
                                                                                                            Slog.i(TAG, "Search Service");
                                                                                                            ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                        }
                                                                                                        Slog.i(TAG, "DropBox Service");
                                                                                                        ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                        Slog.i(TAG, "Wallpaper Service");
                                                                                                        wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                        ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                        wallpaper = wallpaperManagerService;
                                                                                                        Slog.i(TAG, "Audio Service");
                                                                                                        audioService = new AudioService(context);
                                                                                                        ServiceManager.addService("audio", audioService);
                                                                                                        audioService2 = audioService;
                                                                                                        if (disableNonCoreServices) {
                                                                                                            this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                        }
                                                                                                        if (disableMedia) {
                                                                                                            Slog.i(TAG, "Wired Accessory Manager");
                                                                                                            inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                        }
                                                                                                        if (disableNonCoreServices) {
                                                                                                            this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                            Slog.i(TAG, "Serial Service");
                                                                                                            serialService = new SerialService(context);
                                                                                                            ServiceManager.addService("serial", serialService);
                                                                                                            serialService2 = serialService;
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                        this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                        this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                        if (disableNonCoreServices) {
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                                this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                            }
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                                this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                            }
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                                this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                            }
                                                                                                        }
                                                                                                        Slog.i(TAG, "DiskStats Service");
                                                                                                        ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                        Slog.i(TAG, "SamplingProfiler Service");
                                                                                                        ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                        Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                        networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                        if (disableMedia) {
                                                                                                            Slog.i(TAG, "CommonTimeManagementService");
                                                                                                            commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                            ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                            commonTimeMgmtService = commonTimeManagementService;
                                                                                                        }
                                                                                                        if (disableNetwork) {
                                                                                                            Slog.i(TAG, "CertBlacklister");
                                                                                                            certBlacklister = new CertBlacklister(context);
                                                                                                        }
                                                                                                        if (disableNonCoreServices) {
                                                                                                            this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                        }
                                                                                                        Slog.i(TAG, "Assets Atlas Service");
                                                                                                        assetAtlasService = new AssetAtlasService(context);
                                                                                                        ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                        atlas = assetAtlasService;
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                        this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                            this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                        }
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                        }
                                                                                                        if (disableNonCoreServices) {
                                                                                                            Slog.i(TAG, "Media Router Service");
                                                                                                            mediaRouterService = new MediaRouterService(context);
                                                                                                            ServiceManager.addService("media_router", mediaRouterService);
                                                                                                            mediaRouter = mediaRouterService;
                                                                                                            this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                            this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                                                                            BackgroundDexOptService.schedule(context);
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                            WBC_SERVICE_NAME = "wbc_service";
                                                                                                            Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                            Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                        } else {
                                                                                                            Slog.d(TAG, "Wipower not supported");
                                                                                                        }
                                                                                                        if (disableNonCoreServices) {
                                                                                                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                        }
                                                                                                        safeMode = wm.detectSafeMode();
                                                                                                        if (safeMode) {
                                                                                                            this.mActivityManagerService.enterSafeMode();
                                                                                                            VMRuntime.getRuntime().disableJitCompilation();
                                                                                                        } else {
                                                                                                            VMRuntime.getRuntime().startJitCompilation();
                                                                                                        }
                                                                                                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                        vibrator.systemReady();
                                                                                                        if (lockSettings != null) {
                                                                                                            lockSettings.systemReady();
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                        wm.systemReady();
                                                                                                        if (safeMode) {
                                                                                                            this.mActivityManagerService.showSafeModeOverlay();
                                                                                                        }
                                                                                                        config = wm.computeNewConfiguration();
                                                                                                        metrics = new DisplayMetrics();
                                                                                                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                        context.getResources().updateConfiguration(config, metrics);
                                                                                                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                        this.mPackageManagerService.systemReady();
                                                                                                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                        audioServiceF = audioService2;
                                                                                                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                    }
                                                                                                } catch (Throwable th19) {
                                                                                                    e42222222222 = th19;
                                                                                                    reportWtf("starting Network Score Service", e42222222222);
                                                                                                    Slog.i(TAG, "NetworkStats Service");
                                                                                                    networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                                                                    ServiceManager.addService("netstats", networkStatsService);
                                                                                                    networkStats = networkStatsService;
                                                                                                    Slog.i(TAG, "NetworkPolicy Service");
                                                                                                    networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                                                                    ServiceManager.addService("netpolicy", networkPolicy);
                                                                                                    this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                                                    this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                                                    this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                                                    this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                                                        this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                                                    }
                                                                                                    Slog.i(TAG, "Connectivity Service");
                                                                                                    connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                                                    ServiceManager.addService("connectivity", connectivityService);
                                                                                                    networkStats.bindConnectivityManager(connectivityService);
                                                                                                    networkPolicy.bindConnectivityManager(connectivityService);
                                                                                                    connectivity = connectivityService;
                                                                                                    Slog.i(TAG, "Network Service Discovery Service");
                                                                                                    ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                                    Slog.i(TAG, "DPM Service");
                                                                                                    startDpmService(context);
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "UpdateLock Service");
                                                                                                        ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                                    }
                                                                                                    mountService2.waitForAsecScan();
                                                                                                    if (accountManagerService != null) {
                                                                                                        accountManagerService.systemReady();
                                                                                                    }
                                                                                                    if (contentService != null) {
                                                                                                        contentService.systemReady();
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                                    networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                                    this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                                    if (disableLocation) {
                                                                                                        Slog.i(TAG, "Location Manager");
                                                                                                        locationManagerService = new LocationManagerService(context);
                                                                                                        ServiceManager.addService("location", locationManagerService);
                                                                                                        location = locationManagerService;
                                                                                                        Slog.i(TAG, "Country Detector");
                                                                                                        countryDetectorService = new CountryDetectorService(context);
                                                                                                        ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                        countryDetector = countryDetectorService;
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "Search Service");
                                                                                                        ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                    }
                                                                                                    Slog.i(TAG, "DropBox Service");
                                                                                                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                    Slog.i(TAG, "Wallpaper Service");
                                                                                                    wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                    ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                    wallpaper = wallpaperManagerService;
                                                                                                    Slog.i(TAG, "Audio Service");
                                                                                                    audioService = new AudioService(context);
                                                                                                    ServiceManager.addService("audio", audioService);
                                                                                                    audioService2 = audioService;
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                    }
                                                                                                    if (disableMedia) {
                                                                                                        Slog.i(TAG, "Wired Accessory Manager");
                                                                                                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                        Slog.i(TAG, "Serial Service");
                                                                                                        serialService = new SerialService(context);
                                                                                                        ServiceManager.addService("serial", serialService);
                                                                                                        serialService2 = serialService;
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                    if (disableNonCoreServices) {
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                        }
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                        }
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                        }
                                                                                                    }
                                                                                                    Slog.i(TAG, "DiskStats Service");
                                                                                                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                    Slog.i(TAG, "SamplingProfiler Service");
                                                                                                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                    Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                    if (disableMedia) {
                                                                                                        Slog.i(TAG, "CommonTimeManagementService");
                                                                                                        commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                        commonTimeMgmtService = commonTimeManagementService;
                                                                                                    }
                                                                                                    if (disableNetwork) {
                                                                                                        Slog.i(TAG, "CertBlacklister");
                                                                                                        certBlacklister = new CertBlacklister(context);
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                    }
                                                                                                    Slog.i(TAG, "Assets Atlas Service");
                                                                                                    assetAtlasService = new AssetAtlasService(context);
                                                                                                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                    atlas = assetAtlasService;
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                    }
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "Media Router Service");
                                                                                                        mediaRouterService = new MediaRouterService(context);
                                                                                                        ServiceManager.addService("media_router", mediaRouterService);
                                                                                                        mediaRouter = mediaRouterService;
                                                                                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                        Slog.i(TAG, "BackgroundDexOptService");
                                                                                                        BackgroundDexOptService.schedule(context);
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                        WBC_SERVICE_NAME = "wbc_service";
                                                                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                    } else {
                                                                                                        Slog.d(TAG, "Wipower not supported");
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                    }
                                                                                                    safeMode = wm.detectSafeMode();
                                                                                                    if (safeMode) {
                                                                                                        this.mActivityManagerService.enterSafeMode();
                                                                                                        VMRuntime.getRuntime().disableJitCompilation();
                                                                                                    } else {
                                                                                                        VMRuntime.getRuntime().startJitCompilation();
                                                                                                    }
                                                                                                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                    vibrator.systemReady();
                                                                                                    if (lockSettings != null) {
                                                                                                        lockSettings.systemReady();
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                    wm.systemReady();
                                                                                                    if (safeMode) {
                                                                                                        this.mActivityManagerService.showSafeModeOverlay();
                                                                                                    }
                                                                                                    config = wm.computeNewConfiguration();
                                                                                                    metrics = new DisplayMetrics();
                                                                                                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                    context.getResources().updateConfiguration(config, metrics);
                                                                                                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                    this.mPackageManagerService.systemReady();
                                                                                                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                    audioServiceF = audioService2;
                                                                                                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                }
                                                                                                try {
                                                                                                    Slog.i(TAG, "NetworkStats Service");
                                                                                                    networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                                                                    ServiceManager.addService("netstats", networkStatsService);
                                                                                                    networkStats = networkStatsService;
                                                                                                } catch (Throwable th20) {
                                                                                                    e42222222222 = th20;
                                                                                                    reportWtf("starting NetworkStats Service", e42222222222);
                                                                                                    Slog.i(TAG, "NetworkPolicy Service");
                                                                                                    networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                                                                    ServiceManager.addService("netpolicy", networkPolicy);
                                                                                                    this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                                                    this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                                                    this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                                                    this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                                                        this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                                                    }
                                                                                                    Slog.i(TAG, "Connectivity Service");
                                                                                                    connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                                                    ServiceManager.addService("connectivity", connectivityService);
                                                                                                    networkStats.bindConnectivityManager(connectivityService);
                                                                                                    networkPolicy.bindConnectivityManager(connectivityService);
                                                                                                    connectivity = connectivityService;
                                                                                                    Slog.i(TAG, "Network Service Discovery Service");
                                                                                                    ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                                    Slog.i(TAG, "DPM Service");
                                                                                                    startDpmService(context);
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "UpdateLock Service");
                                                                                                        ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                                    }
                                                                                                    mountService2.waitForAsecScan();
                                                                                                    if (accountManagerService != null) {
                                                                                                        accountManagerService.systemReady();
                                                                                                    }
                                                                                                    if (contentService != null) {
                                                                                                        contentService.systemReady();
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                                    networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                                    this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                                    if (disableLocation) {
                                                                                                        Slog.i(TAG, "Location Manager");
                                                                                                        locationManagerService = new LocationManagerService(context);
                                                                                                        ServiceManager.addService("location", locationManagerService);
                                                                                                        location = locationManagerService;
                                                                                                        Slog.i(TAG, "Country Detector");
                                                                                                        countryDetectorService = new CountryDetectorService(context);
                                                                                                        ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                        countryDetector = countryDetectorService;
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "Search Service");
                                                                                                        ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                    }
                                                                                                    Slog.i(TAG, "DropBox Service");
                                                                                                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                    Slog.i(TAG, "Wallpaper Service");
                                                                                                    wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                    ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                    wallpaper = wallpaperManagerService;
                                                                                                    Slog.i(TAG, "Audio Service");
                                                                                                    audioService = new AudioService(context);
                                                                                                    ServiceManager.addService("audio", audioService);
                                                                                                    audioService2 = audioService;
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                    }
                                                                                                    if (disableMedia) {
                                                                                                        Slog.i(TAG, "Wired Accessory Manager");
                                                                                                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                        Slog.i(TAG, "Serial Service");
                                                                                                        serialService = new SerialService(context);
                                                                                                        ServiceManager.addService("serial", serialService);
                                                                                                        serialService2 = serialService;
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                    if (disableNonCoreServices) {
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                        }
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                        }
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                        }
                                                                                                    }
                                                                                                    Slog.i(TAG, "DiskStats Service");
                                                                                                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                    Slog.i(TAG, "SamplingProfiler Service");
                                                                                                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                    Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                    if (disableMedia) {
                                                                                                        Slog.i(TAG, "CommonTimeManagementService");
                                                                                                        commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                        commonTimeMgmtService = commonTimeManagementService;
                                                                                                    }
                                                                                                    if (disableNetwork) {
                                                                                                        Slog.i(TAG, "CertBlacklister");
                                                                                                        certBlacklister = new CertBlacklister(context);
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                    }
                                                                                                    Slog.i(TAG, "Assets Atlas Service");
                                                                                                    assetAtlasService = new AssetAtlasService(context);
                                                                                                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                    atlas = assetAtlasService;
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                    }
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "Media Router Service");
                                                                                                        mediaRouterService = new MediaRouterService(context);
                                                                                                        ServiceManager.addService("media_router", mediaRouterService);
                                                                                                        mediaRouter = mediaRouterService;
                                                                                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                        Slog.i(TAG, "BackgroundDexOptService");
                                                                                                        BackgroundDexOptService.schedule(context);
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                        WBC_SERVICE_NAME = "wbc_service";
                                                                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                    } else {
                                                                                                        Slog.d(TAG, "Wipower not supported");
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                    }
                                                                                                    safeMode = wm.detectSafeMode();
                                                                                                    if (safeMode) {
                                                                                                        this.mActivityManagerService.enterSafeMode();
                                                                                                        VMRuntime.getRuntime().disableJitCompilation();
                                                                                                    } else {
                                                                                                        VMRuntime.getRuntime().startJitCompilation();
                                                                                                    }
                                                                                                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                    vibrator.systemReady();
                                                                                                    if (lockSettings != null) {
                                                                                                        lockSettings.systemReady();
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                    wm.systemReady();
                                                                                                    if (safeMode) {
                                                                                                        this.mActivityManagerService.showSafeModeOverlay();
                                                                                                    }
                                                                                                    config = wm.computeNewConfiguration();
                                                                                                    metrics = new DisplayMetrics();
                                                                                                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                    context.getResources().updateConfiguration(config, metrics);
                                                                                                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                    this.mPackageManagerService.systemReady();
                                                                                                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                    audioServiceF = audioService2;
                                                                                                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                }
                                                                                                try {
                                                                                                    Slog.i(TAG, "NetworkPolicy Service");
                                                                                                    networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                                                                    ServiceManager.addService("netpolicy", networkPolicy);
                                                                                                } catch (Throwable th21) {
                                                                                                    e42222222222 = th21;
                                                                                                    networkPolicy = null;
                                                                                                    reportWtf("starting NetworkPolicy Service", e42222222222);
                                                                                                    this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                                                    this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                                                    this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                                                    this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                                                        this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                                                    }
                                                                                                    Slog.i(TAG, "Connectivity Service");
                                                                                                    connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                                                    ServiceManager.addService("connectivity", connectivityService);
                                                                                                    networkStats.bindConnectivityManager(connectivityService);
                                                                                                    networkPolicy.bindConnectivityManager(connectivityService);
                                                                                                    connectivity = connectivityService;
                                                                                                    Slog.i(TAG, "Network Service Discovery Service");
                                                                                                    ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                                    Slog.i(TAG, "DPM Service");
                                                                                                    startDpmService(context);
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "UpdateLock Service");
                                                                                                        ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                                    }
                                                                                                    mountService2.waitForAsecScan();
                                                                                                    if (accountManagerService != null) {
                                                                                                        accountManagerService.systemReady();
                                                                                                    }
                                                                                                    if (contentService != null) {
                                                                                                        contentService.systemReady();
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                                    networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                                    this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                                    if (disableLocation) {
                                                                                                        Slog.i(TAG, "Location Manager");
                                                                                                        locationManagerService = new LocationManagerService(context);
                                                                                                        ServiceManager.addService("location", locationManagerService);
                                                                                                        location = locationManagerService;
                                                                                                        Slog.i(TAG, "Country Detector");
                                                                                                        countryDetectorService = new CountryDetectorService(context);
                                                                                                        ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                        countryDetector = countryDetectorService;
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "Search Service");
                                                                                                        ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                    }
                                                                                                    Slog.i(TAG, "DropBox Service");
                                                                                                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                    Slog.i(TAG, "Wallpaper Service");
                                                                                                    wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                    ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                    wallpaper = wallpaperManagerService;
                                                                                                    Slog.i(TAG, "Audio Service");
                                                                                                    audioService = new AudioService(context);
                                                                                                    ServiceManager.addService("audio", audioService);
                                                                                                    audioService2 = audioService;
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                    }
                                                                                                    if (disableMedia) {
                                                                                                        Slog.i(TAG, "Wired Accessory Manager");
                                                                                                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                        Slog.i(TAG, "Serial Service");
                                                                                                        serialService = new SerialService(context);
                                                                                                        ServiceManager.addService("serial", serialService);
                                                                                                        serialService2 = serialService;
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                    if (disableNonCoreServices) {
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                        }
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                        }
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                        }
                                                                                                    }
                                                                                                    Slog.i(TAG, "DiskStats Service");
                                                                                                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                    Slog.i(TAG, "SamplingProfiler Service");
                                                                                                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                    Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                    if (disableMedia) {
                                                                                                        Slog.i(TAG, "CommonTimeManagementService");
                                                                                                        commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                        commonTimeMgmtService = commonTimeManagementService;
                                                                                                    }
                                                                                                    if (disableNetwork) {
                                                                                                        Slog.i(TAG, "CertBlacklister");
                                                                                                        certBlacklister = new CertBlacklister(context);
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                    }
                                                                                                    Slog.i(TAG, "Assets Atlas Service");
                                                                                                    assetAtlasService = new AssetAtlasService(context);
                                                                                                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                    atlas = assetAtlasService;
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                    }
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "Media Router Service");
                                                                                                        mediaRouterService = new MediaRouterService(context);
                                                                                                        ServiceManager.addService("media_router", mediaRouterService);
                                                                                                        mediaRouter = mediaRouterService;
                                                                                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                        Slog.i(TAG, "BackgroundDexOptService");
                                                                                                        BackgroundDexOptService.schedule(context);
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                        WBC_SERVICE_NAME = "wbc_service";
                                                                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                    } else {
                                                                                                        Slog.d(TAG, "Wipower not supported");
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                    }
                                                                                                    safeMode = wm.detectSafeMode();
                                                                                                    if (safeMode) {
                                                                                                        this.mActivityManagerService.enterSafeMode();
                                                                                                        VMRuntime.getRuntime().disableJitCompilation();
                                                                                                    } else {
                                                                                                        VMRuntime.getRuntime().startJitCompilation();
                                                                                                    }
                                                                                                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                    vibrator.systemReady();
                                                                                                    if (lockSettings != null) {
                                                                                                        lockSettings.systemReady();
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                    wm.systemReady();
                                                                                                    if (safeMode) {
                                                                                                        this.mActivityManagerService.showSafeModeOverlay();
                                                                                                    }
                                                                                                    config = wm.computeNewConfiguration();
                                                                                                    metrics = new DisplayMetrics();
                                                                                                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                    context.getResources().updateConfiguration(config, metrics);
                                                                                                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                    this.mPackageManagerService.systemReady();
                                                                                                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                    audioServiceF = audioService2;
                                                                                                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                }
                                                                                                this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                                                this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                                                this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                                                this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                                                if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                                                    this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                                                }
                                                                                                try {
                                                                                                    Slog.i(TAG, "Connectivity Service");
                                                                                                    connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                                                    try {
                                                                                                        ServiceManager.addService("connectivity", connectivityService);
                                                                                                        networkStats.bindConnectivityManager(connectivityService);
                                                                                                        networkPolicy.bindConnectivityManager(connectivityService);
                                                                                                        connectivity = connectivityService;
                                                                                                    } catch (Throwable th22) {
                                                                                                        e42222222222 = th22;
                                                                                                        connectivity = connectivityService;
                                                                                                        reportWtf("starting Connectivity Service", e42222222222);
                                                                                                        Slog.i(TAG, "Network Service Discovery Service");
                                                                                                        ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                                        Slog.i(TAG, "DPM Service");
                                                                                                        startDpmService(context);
                                                                                                        if (disableNonCoreServices) {
                                                                                                            Slog.i(TAG, "UpdateLock Service");
                                                                                                            ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                                        }
                                                                                                        mountService2.waitForAsecScan();
                                                                                                        if (accountManagerService != null) {
                                                                                                            accountManagerService.systemReady();
                                                                                                        }
                                                                                                        if (contentService != null) {
                                                                                                            contentService.systemReady();
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                                        networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                                        this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                                        if (disableLocation) {
                                                                                                            Slog.i(TAG, "Location Manager");
                                                                                                            locationManagerService = new LocationManagerService(context);
                                                                                                            ServiceManager.addService("location", locationManagerService);
                                                                                                            location = locationManagerService;
                                                                                                            Slog.i(TAG, "Country Detector");
                                                                                                            countryDetectorService = new CountryDetectorService(context);
                                                                                                            ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                            countryDetector = countryDetectorService;
                                                                                                        }
                                                                                                        if (disableNonCoreServices) {
                                                                                                            Slog.i(TAG, "Search Service");
                                                                                                            ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                        }
                                                                                                        Slog.i(TAG, "DropBox Service");
                                                                                                        ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                        Slog.i(TAG, "Wallpaper Service");
                                                                                                        wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                        ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                        wallpaper = wallpaperManagerService;
                                                                                                        Slog.i(TAG, "Audio Service");
                                                                                                        audioService = new AudioService(context);
                                                                                                        ServiceManager.addService("audio", audioService);
                                                                                                        audioService2 = audioService;
                                                                                                        if (disableNonCoreServices) {
                                                                                                            this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                        }
                                                                                                        if (disableMedia) {
                                                                                                            Slog.i(TAG, "Wired Accessory Manager");
                                                                                                            inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                        }
                                                                                                        if (disableNonCoreServices) {
                                                                                                            this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                            Slog.i(TAG, "Serial Service");
                                                                                                            serialService = new SerialService(context);
                                                                                                            ServiceManager.addService("serial", serialService);
                                                                                                            serialService2 = serialService;
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                        this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                        this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                        if (disableNonCoreServices) {
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                                this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                            }
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                                this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                            }
                                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                                this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                            }
                                                                                                        }
                                                                                                        Slog.i(TAG, "DiskStats Service");
                                                                                                        ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                        Slog.i(TAG, "SamplingProfiler Service");
                                                                                                        ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                        Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                        networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                        if (disableMedia) {
                                                                                                            Slog.i(TAG, "CommonTimeManagementService");
                                                                                                            commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                            ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                            commonTimeMgmtService = commonTimeManagementService;
                                                                                                        }
                                                                                                        if (disableNetwork) {
                                                                                                            Slog.i(TAG, "CertBlacklister");
                                                                                                            certBlacklister = new CertBlacklister(context);
                                                                                                        }
                                                                                                        if (disableNonCoreServices) {
                                                                                                            this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                        }
                                                                                                        Slog.i(TAG, "Assets Atlas Service");
                                                                                                        assetAtlasService = new AssetAtlasService(context);
                                                                                                        ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                        atlas = assetAtlasService;
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                        this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                            this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                        }
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                        }
                                                                                                        if (disableNonCoreServices) {
                                                                                                            Slog.i(TAG, "Media Router Service");
                                                                                                            mediaRouterService = new MediaRouterService(context);
                                                                                                            ServiceManager.addService("media_router", mediaRouterService);
                                                                                                            mediaRouter = mediaRouterService;
                                                                                                            this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                            this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                                                                            BackgroundDexOptService.schedule(context);
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                            Slog.d(TAG, "Wipower not supported");
                                                                                                        } else {
                                                                                                            WBC_SERVICE_NAME = "wbc_service";
                                                                                                            Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                            Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                        }
                                                                                                        if (disableNonCoreServices) {
                                                                                                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                        }
                                                                                                        safeMode = wm.detectSafeMode();
                                                                                                        if (safeMode) {
                                                                                                            VMRuntime.getRuntime().startJitCompilation();
                                                                                                        } else {
                                                                                                            this.mActivityManagerService.enterSafeMode();
                                                                                                            VMRuntime.getRuntime().disableJitCompilation();
                                                                                                        }
                                                                                                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                        vibrator.systemReady();
                                                                                                        if (lockSettings != null) {
                                                                                                            lockSettings.systemReady();
                                                                                                        }
                                                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                        wm.systemReady();
                                                                                                        if (safeMode) {
                                                                                                            this.mActivityManagerService.showSafeModeOverlay();
                                                                                                        }
                                                                                                        config = wm.computeNewConfiguration();
                                                                                                        metrics = new DisplayMetrics();
                                                                                                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                        context.getResources().updateConfiguration(config, metrics);
                                                                                                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                        this.mPackageManagerService.systemReady();
                                                                                                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                        audioServiceF = audioService2;
                                                                                                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                    }
                                                                                                } catch (Throwable th23) {
                                                                                                    e42222222222 = th23;
                                                                                                    reportWtf("starting Connectivity Service", e42222222222);
                                                                                                    Slog.i(TAG, "Network Service Discovery Service");
                                                                                                    ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                                    Slog.i(TAG, "DPM Service");
                                                                                                    startDpmService(context);
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "UpdateLock Service");
                                                                                                        ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                                    }
                                                                                                    mountService2.waitForAsecScan();
                                                                                                    if (accountManagerService != null) {
                                                                                                        accountManagerService.systemReady();
                                                                                                    }
                                                                                                    if (contentService != null) {
                                                                                                        contentService.systemReady();
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                                    networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                                    this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                                    if (disableLocation) {
                                                                                                        Slog.i(TAG, "Location Manager");
                                                                                                        locationManagerService = new LocationManagerService(context);
                                                                                                        ServiceManager.addService("location", locationManagerService);
                                                                                                        location = locationManagerService;
                                                                                                        Slog.i(TAG, "Country Detector");
                                                                                                        countryDetectorService = new CountryDetectorService(context);
                                                                                                        ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                        countryDetector = countryDetectorService;
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "Search Service");
                                                                                                        ServiceManager.addService("search", new SearchManagerService(context));
                                                                                                    }
                                                                                                    Slog.i(TAG, "DropBox Service");
                                                                                                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                                    Slog.i(TAG, "Wallpaper Service");
                                                                                                    wallpaperManagerService = new WallpaperManagerService(context);
                                                                                                    ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                                    wallpaper = wallpaperManagerService;
                                                                                                    Slog.i(TAG, "Audio Service");
                                                                                                    audioService = new AudioService(context);
                                                                                                    ServiceManager.addService("audio", audioService);
                                                                                                    audioService2 = audioService;
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(DockObserver.class);
                                                                                                    }
                                                                                                    if (disableMedia) {
                                                                                                        Slog.i(TAG, "Wired Accessory Manager");
                                                                                                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                        Slog.i(TAG, "Serial Service");
                                                                                                        serialService = new SerialService(context);
                                                                                                        ServiceManager.addService("serial", serialService);
                                                                                                        serialService2 = serialService;
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(TwilightService.class);
                                                                                                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                                    if (disableNonCoreServices) {
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                        }
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                        }
                                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                        }
                                                                                                    }
                                                                                                    Slog.i(TAG, "DiskStats Service");
                                                                                                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                                    Slog.i(TAG, "SamplingProfiler Service");
                                                                                                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                                    Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                                    if (disableMedia) {
                                                                                                        Slog.i(TAG, "CommonTimeManagementService");
                                                                                                        commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                        commonTimeMgmtService = commonTimeManagementService;
                                                                                                    }
                                                                                                    if (disableNetwork) {
                                                                                                        Slog.i(TAG, "CertBlacklister");
                                                                                                        certBlacklister = new CertBlacklister(context);
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                                    }
                                                                                                    Slog.i(TAG, "Assets Atlas Service");
                                                                                                    assetAtlasService = new AssetAtlasService(context);
                                                                                                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                                    atlas = assetAtlasService;
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                                    }
                                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        Slog.i(TAG, "Media Router Service");
                                                                                                        mediaRouterService = new MediaRouterService(context);
                                                                                                        ServiceManager.addService("media_router", mediaRouterService);
                                                                                                        mediaRouter = mediaRouterService;
                                                                                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                        Slog.i(TAG, "BackgroundDexOptService");
                                                                                                        BackgroundDexOptService.schedule(context);
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                        Slog.d(TAG, "Wipower not supported");
                                                                                                    } else {
                                                                                                        WBC_SERVICE_NAME = "wbc_service";
                                                                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                                    }
                                                                                                    if (disableNonCoreServices) {
                                                                                                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                                    }
                                                                                                    safeMode = wm.detectSafeMode();
                                                                                                    if (safeMode) {
                                                                                                        VMRuntime.getRuntime().startJitCompilation();
                                                                                                    } else {
                                                                                                        this.mActivityManagerService.enterSafeMode();
                                                                                                        VMRuntime.getRuntime().disableJitCompilation();
                                                                                                    }
                                                                                                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                                    vibrator.systemReady();
                                                                                                    if (lockSettings != null) {
                                                                                                        lockSettings.systemReady();
                                                                                                    }
                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                                    wm.systemReady();
                                                                                                    if (safeMode) {
                                                                                                        this.mActivityManagerService.showSafeModeOverlay();
                                                                                                    }
                                                                                                    config = wm.computeNewConfiguration();
                                                                                                    metrics = new DisplayMetrics();
                                                                                                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                                    context.getResources().updateConfiguration(config, metrics);
                                                                                                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                                    this.mPackageManagerService.systemReady();
                                                                                                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                                    audioServiceF = audioService2;
                                                                                                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                                }
                                                                                                try {
                                                                                                    Slog.i(TAG, "Network Service Discovery Service");
                                                                                                    ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                                } catch (Throwable e422222222222) {
                                                                                                    reportWtf("starting Service Discovery Service", e422222222222);
                                                                                                }
                                                                                                try {
                                                                                                    Slog.i(TAG, "DPM Service");
                                                                                                    startDpmService(context);
                                                                                                } catch (Throwable e4222222222222) {
                                                                                                    reportWtf("starting DpmService", e4222222222222);
                                                                                                }
                                                                                            }
                                                                                            if (disableNonCoreServices) {
                                                                                                Slog.i(TAG, "UpdateLock Service");
                                                                                                ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                            }
                                                                                            mountService2.waitForAsecScan();
                                                                                            if (accountManagerService != null) {
                                                                                                accountManagerService.systemReady();
                                                                                            }
                                                                                            if (contentService != null) {
                                                                                                contentService.systemReady();
                                                                                            }
                                                                                            this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                            networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                            this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                            if (disableLocation) {
                                                                                                Slog.i(TAG, "Location Manager");
                                                                                                locationManagerService = new LocationManagerService(context);
                                                                                                ServiceManager.addService("location", locationManagerService);
                                                                                                location = locationManagerService;
                                                                                                Slog.i(TAG, "Country Detector");
                                                                                                countryDetectorService = new CountryDetectorService(context);
                                                                                                ServiceManager.addService("country_detector", countryDetectorService);
                                                                                                countryDetector = countryDetectorService;
                                                                                            }
                                                                                            if (disableNonCoreServices) {
                                                                                                Slog.i(TAG, "Search Service");
                                                                                                ServiceManager.addService("search", new SearchManagerService(context));
                                                                                            }
                                                                                            Slog.i(TAG, "DropBox Service");
                                                                                            ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                            Slog.i(TAG, "Wallpaper Service");
                                                                                            wallpaperManagerService = new WallpaperManagerService(context);
                                                                                            ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                            wallpaper = wallpaperManagerService;
                                                                                            Slog.i(TAG, "Audio Service");
                                                                                            audioService = new AudioService(context);
                                                                                            ServiceManager.addService("audio", audioService);
                                                                                            audioService2 = audioService;
                                                                                            if (disableNonCoreServices) {
                                                                                                this.mSystemServiceManager.startService(DockObserver.class);
                                                                                            }
                                                                                            if (disableMedia) {
                                                                                                Slog.i(TAG, "Wired Accessory Manager");
                                                                                                inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                            }
                                                                                            if (disableNonCoreServices) {
                                                                                                this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                                Slog.i(TAG, "Serial Service");
                                                                                                serialService = new SerialService(context);
                                                                                                ServiceManager.addService("serial", serialService);
                                                                                                serialService2 = serialService;
                                                                                            }
                                                                                            this.mSystemServiceManager.startService(TwilightService.class);
                                                                                            this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                            this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                            if (disableNonCoreServices) {
                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                                }
                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                                }
                                                                                                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                                }
                                                                                            }
                                                                                            Slog.i(TAG, "DiskStats Service");
                                                                                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                            Slog.i(TAG, "SamplingProfiler Service");
                                                                                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                            Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                            if (disableMedia) {
                                                                                                Slog.i(TAG, "CommonTimeManagementService");
                                                                                                commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                                ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                                commonTimeMgmtService = commonTimeManagementService;
                                                                                            }
                                                                                            if (disableNetwork) {
                                                                                                Slog.i(TAG, "CertBlacklister");
                                                                                                certBlacklister = new CertBlacklister(context);
                                                                                            }
                                                                                            if (disableNonCoreServices) {
                                                                                                this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                            }
                                                                                            Slog.i(TAG, "Assets Atlas Service");
                                                                                            assetAtlasService = new AssetAtlasService(context);
                                                                                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                            atlas = assetAtlasService;
                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                            }
                                                                                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                            this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                                this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                            }
                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                            }
                                                                                            if (disableNonCoreServices) {
                                                                                                Slog.i(TAG, "Media Router Service");
                                                                                                mediaRouterService = new MediaRouterService(context);
                                                                                                ServiceManager.addService("media_router", mediaRouterService);
                                                                                                mediaRouter = mediaRouterService;
                                                                                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                                this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                                Slog.i(TAG, "BackgroundDexOptService");
                                                                                                BackgroundDexOptService.schedule(context);
                                                                                            }
                                                                                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                                Slog.d(TAG, "Wipower not supported");
                                                                                            } else {
                                                                                                WBC_SERVICE_NAME = "wbc_service";
                                                                                                Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                                Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                            }
                                                                                            if (disableNonCoreServices) {
                                                                                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                            }
                                                                                            safeMode = wm.detectSafeMode();
                                                                                            if (safeMode) {
                                                                                                VMRuntime.getRuntime().startJitCompilation();
                                                                                            } else {
                                                                                                this.mActivityManagerService.enterSafeMode();
                                                                                                VMRuntime.getRuntime().disableJitCompilation();
                                                                                            }
                                                                                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                            vibrator.systemReady();
                                                                                            if (lockSettings != null) {
                                                                                                lockSettings.systemReady();
                                                                                            }
                                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                            wm.systemReady();
                                                                                            if (safeMode) {
                                                                                                this.mActivityManagerService.showSafeModeOverlay();
                                                                                            }
                                                                                            config = wm.computeNewConfiguration();
                                                                                            metrics = new DisplayMetrics();
                                                                                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                            context.getResources().updateConfiguration(config, metrics);
                                                                                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                            this.mPackageManagerService.systemReady();
                                                                                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                            audioServiceF = audioService2;
                                                                                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                        }
                                                                                    } catch (Throwable th24) {
                                                                                        e4222222222222 = th24;
                                                                                        reportWtf("starting Text Service Manager Service", e4222222222222);
                                                                                        if (disableNetwork) {
                                                                                            Slog.i(TAG, "Network Score Service");
                                                                                            networkScoreService = new NetworkScoreService(context);
                                                                                            ServiceManager.addService("network_score", networkScoreService);
                                                                                            networkScore = networkScoreService;
                                                                                            Slog.i(TAG, "NetworkStats Service");
                                                                                            networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                                                            ServiceManager.addService("netstats", networkStatsService);
                                                                                            networkStats = networkStatsService;
                                                                                            Slog.i(TAG, "NetworkPolicy Service");
                                                                                            networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                                                            ServiceManager.addService("netpolicy", networkPolicy);
                                                                                            this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                                            this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                                            this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                                            this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                                                this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                                            }
                                                                                            Slog.i(TAG, "Connectivity Service");
                                                                                            connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                                            ServiceManager.addService("connectivity", connectivityService);
                                                                                            networkStats.bindConnectivityManager(connectivityService);
                                                                                            networkPolicy.bindConnectivityManager(connectivityService);
                                                                                            connectivity = connectivityService;
                                                                                            Slog.i(TAG, "Network Service Discovery Service");
                                                                                            ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                            Slog.i(TAG, "DPM Service");
                                                                                            startDpmService(context);
                                                                                        } else {
                                                                                            networkPolicy = null;
                                                                                        }
                                                                                        if (disableNonCoreServices) {
                                                                                            Slog.i(TAG, "UpdateLock Service");
                                                                                            ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                        }
                                                                                        mountService2.waitForAsecScan();
                                                                                        if (accountManagerService != null) {
                                                                                            accountManagerService.systemReady();
                                                                                        }
                                                                                        if (contentService != null) {
                                                                                            contentService.systemReady();
                                                                                        }
                                                                                        this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                        networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                        this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                        if (disableLocation) {
                                                                                            Slog.i(TAG, "Location Manager");
                                                                                            locationManagerService = new LocationManagerService(context);
                                                                                            ServiceManager.addService("location", locationManagerService);
                                                                                            location = locationManagerService;
                                                                                            Slog.i(TAG, "Country Detector");
                                                                                            countryDetectorService = new CountryDetectorService(context);
                                                                                            ServiceManager.addService("country_detector", countryDetectorService);
                                                                                            countryDetector = countryDetectorService;
                                                                                        }
                                                                                        if (disableNonCoreServices) {
                                                                                            Slog.i(TAG, "Search Service");
                                                                                            ServiceManager.addService("search", new SearchManagerService(context));
                                                                                        }
                                                                                        Slog.i(TAG, "DropBox Service");
                                                                                        ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                        Slog.i(TAG, "Wallpaper Service");
                                                                                        wallpaperManagerService = new WallpaperManagerService(context);
                                                                                        ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                        wallpaper = wallpaperManagerService;
                                                                                        Slog.i(TAG, "Audio Service");
                                                                                        audioService = new AudioService(context);
                                                                                        ServiceManager.addService("audio", audioService);
                                                                                        audioService2 = audioService;
                                                                                        if (disableNonCoreServices) {
                                                                                            this.mSystemServiceManager.startService(DockObserver.class);
                                                                                        }
                                                                                        if (disableMedia) {
                                                                                            Slog.i(TAG, "Wired Accessory Manager");
                                                                                            inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                        }
                                                                                        if (disableNonCoreServices) {
                                                                                            this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                            Slog.i(TAG, "Serial Service");
                                                                                            serialService = new SerialService(context);
                                                                                            ServiceManager.addService("serial", serialService);
                                                                                            serialService2 = serialService;
                                                                                        }
                                                                                        this.mSystemServiceManager.startService(TwilightService.class);
                                                                                        this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                        this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                        if (disableNonCoreServices) {
                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                                this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                            }
                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                                this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                            }
                                                                                            if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                                this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                            }
                                                                                        }
                                                                                        Slog.i(TAG, "DiskStats Service");
                                                                                        ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                        Slog.i(TAG, "SamplingProfiler Service");
                                                                                        ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                        Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                        networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                        if (disableMedia) {
                                                                                            Slog.i(TAG, "CommonTimeManagementService");
                                                                                            commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                            ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                            commonTimeMgmtService = commonTimeManagementService;
                                                                                        }
                                                                                        if (disableNetwork) {
                                                                                            Slog.i(TAG, "CertBlacklister");
                                                                                            certBlacklister = new CertBlacklister(context);
                                                                                        }
                                                                                        if (disableNonCoreServices) {
                                                                                            this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                        }
                                                                                        Slog.i(TAG, "Assets Atlas Service");
                                                                                        assetAtlasService = new AssetAtlasService(context);
                                                                                        ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                        atlas = assetAtlasService;
                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                        }
                                                                                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                        this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                            this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                        }
                                                                                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                        }
                                                                                        if (disableNonCoreServices) {
                                                                                            Slog.i(TAG, "Media Router Service");
                                                                                            mediaRouterService = new MediaRouterService(context);
                                                                                            ServiceManager.addService("media_router", mediaRouterService);
                                                                                            mediaRouter = mediaRouterService;
                                                                                            this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                            this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                                                            BackgroundDexOptService.schedule(context);
                                                                                        }
                                                                                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                            Slog.d(TAG, "Wipower not supported");
                                                                                        } else {
                                                                                            WBC_SERVICE_NAME = "wbc_service";
                                                                                            Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                            Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                        }
                                                                                        if (disableNonCoreServices) {
                                                                                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                        }
                                                                                        safeMode = wm.detectSafeMode();
                                                                                        if (safeMode) {
                                                                                            VMRuntime.getRuntime().startJitCompilation();
                                                                                        } else {
                                                                                            this.mActivityManagerService.enterSafeMode();
                                                                                            VMRuntime.getRuntime().disableJitCompilation();
                                                                                        }
                                                                                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                        vibrator.systemReady();
                                                                                        if (lockSettings != null) {
                                                                                            lockSettings.systemReady();
                                                                                        }
                                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                        wm.systemReady();
                                                                                        if (safeMode) {
                                                                                            this.mActivityManagerService.showSafeModeOverlay();
                                                                                        }
                                                                                        config = wm.computeNewConfiguration();
                                                                                        metrics = new DisplayMetrics();
                                                                                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                        context.getResources().updateConfiguration(config, metrics);
                                                                                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                        this.mPackageManagerService.systemReady();
                                                                                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                        audioServiceF = audioService2;
                                                                                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                                    }
                                                                                }
                                                                                if (disableNetwork) {
                                                                                    networkPolicy = null;
                                                                                } else {
                                                                                    Slog.i(TAG, "Network Score Service");
                                                                                    networkScoreService = new NetworkScoreService(context);
                                                                                    ServiceManager.addService("network_score", networkScoreService);
                                                                                    networkScore = networkScoreService;
                                                                                    Slog.i(TAG, "NetworkStats Service");
                                                                                    networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                                                    ServiceManager.addService("netstats", networkStatsService);
                                                                                    networkStats = networkStatsService;
                                                                                    Slog.i(TAG, "NetworkPolicy Service");
                                                                                    networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                                                    ServiceManager.addService("netpolicy", networkPolicy);
                                                                                    this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                                    this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                                    this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                                    this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                                        this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                                    }
                                                                                    Slog.i(TAG, "Connectivity Service");
                                                                                    connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                                    ServiceManager.addService("connectivity", connectivityService);
                                                                                    networkStats.bindConnectivityManager(connectivityService);
                                                                                    networkPolicy.bindConnectivityManager(connectivityService);
                                                                                    connectivity = connectivityService;
                                                                                    Slog.i(TAG, "Network Service Discovery Service");
                                                                                    ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                    Slog.i(TAG, "DPM Service");
                                                                                    startDpmService(context);
                                                                                }
                                                                                if (disableNonCoreServices) {
                                                                                    Slog.i(TAG, "UpdateLock Service");
                                                                                    ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                                }
                                                                                mountService2.waitForAsecScan();
                                                                                if (accountManagerService != null) {
                                                                                    accountManagerService.systemReady();
                                                                                }
                                                                                if (contentService != null) {
                                                                                    contentService.systemReady();
                                                                                }
                                                                                this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                                networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                                this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                                if (disableLocation) {
                                                                                    Slog.i(TAG, "Location Manager");
                                                                                    locationManagerService = new LocationManagerService(context);
                                                                                    ServiceManager.addService("location", locationManagerService);
                                                                                    location = locationManagerService;
                                                                                    Slog.i(TAG, "Country Detector");
                                                                                    countryDetectorService = new CountryDetectorService(context);
                                                                                    ServiceManager.addService("country_detector", countryDetectorService);
                                                                                    countryDetector = countryDetectorService;
                                                                                }
                                                                                if (disableNonCoreServices) {
                                                                                    Slog.i(TAG, "Search Service");
                                                                                    ServiceManager.addService("search", new SearchManagerService(context));
                                                                                }
                                                                                Slog.i(TAG, "DropBox Service");
                                                                                ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                                Slog.i(TAG, "Wallpaper Service");
                                                                                wallpaperManagerService = new WallpaperManagerService(context);
                                                                                ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                                wallpaper = wallpaperManagerService;
                                                                                Slog.i(TAG, "Audio Service");
                                                                                audioService = new AudioService(context);
                                                                                ServiceManager.addService("audio", audioService);
                                                                                audioService2 = audioService;
                                                                                if (disableNonCoreServices) {
                                                                                    this.mSystemServiceManager.startService(DockObserver.class);
                                                                                }
                                                                                if (disableMedia) {
                                                                                    Slog.i(TAG, "Wired Accessory Manager");
                                                                                    inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                                }
                                                                                if (disableNonCoreServices) {
                                                                                    this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                    Slog.i(TAG, "Serial Service");
                                                                                    serialService = new SerialService(context);
                                                                                    ServiceManager.addService("serial", serialService);
                                                                                    serialService2 = serialService;
                                                                                }
                                                                                this.mSystemServiceManager.startService(TwilightService.class);
                                                                                this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                                this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                                if (disableNonCoreServices) {
                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                        this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                    }
                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                        this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                    }
                                                                                    if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                        this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                    }
                                                                                }
                                                                                Slog.i(TAG, "DiskStats Service");
                                                                                ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                                Slog.i(TAG, "SamplingProfiler Service");
                                                                                ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                                Slog.i(TAG, "NetworkTimeUpdateService");
                                                                                networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                                if (disableMedia) {
                                                                                    Slog.i(TAG, "CommonTimeManagementService");
                                                                                    commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                    ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                    commonTimeMgmtService = commonTimeManagementService;
                                                                                }
                                                                                if (disableNetwork) {
                                                                                    Slog.i(TAG, "CertBlacklister");
                                                                                    certBlacklister = new CertBlacklister(context);
                                                                                }
                                                                                if (disableNonCoreServices) {
                                                                                    this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                                }
                                                                                Slog.i(TAG, "Assets Atlas Service");
                                                                                assetAtlasService = new AssetAtlasService(context);
                                                                                ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                                atlas = assetAtlasService;
                                                                                if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                    this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                                }
                                                                                this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                                this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                                if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                    this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                                }
                                                                                if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                    this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                                }
                                                                                if (disableNonCoreServices) {
                                                                                    Slog.i(TAG, "Media Router Service");
                                                                                    mediaRouterService = new MediaRouterService(context);
                                                                                    ServiceManager.addService("media_router", mediaRouterService);
                                                                                    mediaRouter = mediaRouterService;
                                                                                    this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                    this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                    Slog.i(TAG, "BackgroundDexOptService");
                                                                                    BackgroundDexOptService.schedule(context);
                                                                                }
                                                                                this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                                if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                    Slog.d(TAG, "Wipower not supported");
                                                                                } else {
                                                                                    WBC_SERVICE_NAME = "wbc_service";
                                                                                    Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                    wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                    Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                    ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                                }
                                                                                if (disableNonCoreServices) {
                                                                                    this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                                }
                                                                                safeMode = wm.detectSafeMode();
                                                                                if (safeMode) {
                                                                                    VMRuntime.getRuntime().startJitCompilation();
                                                                                } else {
                                                                                    this.mActivityManagerService.enterSafeMode();
                                                                                    VMRuntime.getRuntime().disableJitCompilation();
                                                                                }
                                                                                mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                                vibrator.systemReady();
                                                                                if (lockSettings != null) {
                                                                                    lockSettings.systemReady();
                                                                                }
                                                                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                                wm.systemReady();
                                                                                if (safeMode) {
                                                                                    this.mActivityManagerService.showSafeModeOverlay();
                                                                                }
                                                                                config = wm.computeNewConfiguration();
                                                                                metrics = new DisplayMetrics();
                                                                                ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                                context.getResources().updateConfiguration(config, metrics);
                                                                                this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                                this.mPackageManagerService.systemReady();
                                                                                this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                                audioServiceF = audioService2;
                                                                                this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                            }
                                                                        } catch (Throwable th25) {
                                                                            e4222222222222 = th25;
                                                                            reportWtf("starting StatusBarManagerService", e4222222222222);
                                                                            if (disableNonCoreServices) {
                                                                                Slog.i(TAG, "Clipboard Service");
                                                                                ServiceManager.addService("clipboard", new ClipboardService(context));
                                                                            }
                                                                            if (disableNetwork) {
                                                                                Slog.i(TAG, "NetworkManagement Service");
                                                                                networkManagement = NetworkManagementService.create(context);
                                                                                ServiceManager.addService("network_management", networkManagement);
                                                                            }
                                                                            if (disableNonCoreServices) {
                                                                                Slog.i(TAG, "Text Service Manager Service");
                                                                                textServicesManagerService = new TextServicesManagerService(context);
                                                                                ServiceManager.addService("textservices", textServicesManagerService);
                                                                                tsms = textServicesManagerService;
                                                                            }
                                                                            if (disableNetwork) {
                                                                                Slog.i(TAG, "Network Score Service");
                                                                                networkScoreService = new NetworkScoreService(context);
                                                                                ServiceManager.addService("network_score", networkScoreService);
                                                                                networkScore = networkScoreService;
                                                                                Slog.i(TAG, "NetworkStats Service");
                                                                                networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                                                ServiceManager.addService("netstats", networkStatsService);
                                                                                networkStats = networkStatsService;
                                                                                Slog.i(TAG, "NetworkPolicy Service");
                                                                                networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                                                ServiceManager.addService("netpolicy", networkPolicy);
                                                                                this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                                this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                                this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                                this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                                if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                                    this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                                }
                                                                                Slog.i(TAG, "Connectivity Service");
                                                                                connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                                ServiceManager.addService("connectivity", connectivityService);
                                                                                networkStats.bindConnectivityManager(connectivityService);
                                                                                networkPolicy.bindConnectivityManager(connectivityService);
                                                                                connectivity = connectivityService;
                                                                                Slog.i(TAG, "Network Service Discovery Service");
                                                                                ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                                Slog.i(TAG, "DPM Service");
                                                                                startDpmService(context);
                                                                            } else {
                                                                                networkPolicy = null;
                                                                            }
                                                                            if (disableNonCoreServices) {
                                                                                Slog.i(TAG, "UpdateLock Service");
                                                                                ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                            }
                                                                            mountService2.waitForAsecScan();
                                                                            if (accountManagerService != null) {
                                                                                accountManagerService.systemReady();
                                                                            }
                                                                            if (contentService != null) {
                                                                                contentService.systemReady();
                                                                            }
                                                                            this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                            networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                            this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                            if (disableLocation) {
                                                                                Slog.i(TAG, "Location Manager");
                                                                                locationManagerService = new LocationManagerService(context);
                                                                                ServiceManager.addService("location", locationManagerService);
                                                                                location = locationManagerService;
                                                                                Slog.i(TAG, "Country Detector");
                                                                                countryDetectorService = new CountryDetectorService(context);
                                                                                ServiceManager.addService("country_detector", countryDetectorService);
                                                                                countryDetector = countryDetectorService;
                                                                            }
                                                                            if (disableNonCoreServices) {
                                                                                Slog.i(TAG, "Search Service");
                                                                                ServiceManager.addService("search", new SearchManagerService(context));
                                                                            }
                                                                            Slog.i(TAG, "DropBox Service");
                                                                            ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                            Slog.i(TAG, "Wallpaper Service");
                                                                            wallpaperManagerService = new WallpaperManagerService(context);
                                                                            ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                            wallpaper = wallpaperManagerService;
                                                                            Slog.i(TAG, "Audio Service");
                                                                            audioService = new AudioService(context);
                                                                            ServiceManager.addService("audio", audioService);
                                                                            audioService2 = audioService;
                                                                            if (disableNonCoreServices) {
                                                                                this.mSystemServiceManager.startService(DockObserver.class);
                                                                            }
                                                                            if (disableMedia) {
                                                                                Slog.i(TAG, "Wired Accessory Manager");
                                                                                inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                            }
                                                                            if (disableNonCoreServices) {
                                                                                this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                                Slog.i(TAG, "Serial Service");
                                                                                serialService = new SerialService(context);
                                                                                ServiceManager.addService("serial", serialService);
                                                                                serialService2 = serialService;
                                                                            }
                                                                            this.mSystemServiceManager.startService(TwilightService.class);
                                                                            this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                            this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                            if (disableNonCoreServices) {
                                                                                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                                }
                                                                                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                                }
                                                                                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                                }
                                                                            }
                                                                            Slog.i(TAG, "DiskStats Service");
                                                                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                            Slog.i(TAG, "SamplingProfiler Service");
                                                                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                            Slog.i(TAG, "NetworkTimeUpdateService");
                                                                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                            if (disableMedia) {
                                                                                Slog.i(TAG, "CommonTimeManagementService");
                                                                                commonTimeManagementService = new CommonTimeManagementService(context);
                                                                                ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                                commonTimeMgmtService = commonTimeManagementService;
                                                                            }
                                                                            if (disableNetwork) {
                                                                                Slog.i(TAG, "CertBlacklister");
                                                                                certBlacklister = new CertBlacklister(context);
                                                                            }
                                                                            if (disableNonCoreServices) {
                                                                                this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                            }
                                                                            Slog.i(TAG, "Assets Atlas Service");
                                                                            assetAtlasService = new AssetAtlasService(context);
                                                                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                            atlas = assetAtlasService;
                                                                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                            }
                                                                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                            this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                                this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                            }
                                                                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                            }
                                                                            if (disableNonCoreServices) {
                                                                                Slog.i(TAG, "Media Router Service");
                                                                                mediaRouterService = new MediaRouterService(context);
                                                                                ServiceManager.addService("media_router", mediaRouterService);
                                                                                mediaRouter = mediaRouterService;
                                                                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                                this.mSystemServiceManager.startService(FingerprintService.class);
                                                                                Slog.i(TAG, "BackgroundDexOptService");
                                                                                BackgroundDexOptService.schedule(context);
                                                                            }
                                                                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                                WBC_SERVICE_NAME = "wbc_service";
                                                                                Slog.i(TAG, "WipowerBatteryControl Service");
                                                                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                                Slog.d(TAG, "Successfully loaded WbcService class");
                                                                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                            } else {
                                                                                Slog.d(TAG, "Wipower not supported");
                                                                            }
                                                                            if (disableNonCoreServices) {
                                                                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                            }
                                                                            safeMode = wm.detectSafeMode();
                                                                            if (safeMode) {
                                                                                this.mActivityManagerService.enterSafeMode();
                                                                                VMRuntime.getRuntime().disableJitCompilation();
                                                                            } else {
                                                                                VMRuntime.getRuntime().startJitCompilation();
                                                                            }
                                                                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                            vibrator.systemReady();
                                                                            if (lockSettings != null) {
                                                                                lockSettings.systemReady();
                                                                            }
                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                            wm.systemReady();
                                                                            if (safeMode) {
                                                                                this.mActivityManagerService.showSafeModeOverlay();
                                                                            }
                                                                            config = wm.computeNewConfiguration();
                                                                            metrics = new DisplayMetrics();
                                                                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                            context.getResources().updateConfiguration(config, metrics);
                                                                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                            this.mPackageManagerService.systemReady();
                                                                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                            audioServiceF = audioService2;
                                                                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                        }
                                                                    }
                                                                    if (disableNonCoreServices) {
                                                                        Slog.i(TAG, "Clipboard Service");
                                                                        ServiceManager.addService("clipboard", new ClipboardService(context));
                                                                    }
                                                                    if (disableNetwork) {
                                                                        Slog.i(TAG, "NetworkManagement Service");
                                                                        networkManagement = NetworkManagementService.create(context);
                                                                        ServiceManager.addService("network_management", networkManagement);
                                                                    }
                                                                    if (disableNonCoreServices) {
                                                                        Slog.i(TAG, "Text Service Manager Service");
                                                                        textServicesManagerService = new TextServicesManagerService(context);
                                                                        ServiceManager.addService("textservices", textServicesManagerService);
                                                                        tsms = textServicesManagerService;
                                                                    }
                                                                    if (disableNetwork) {
                                                                        networkPolicy = null;
                                                                    } else {
                                                                        Slog.i(TAG, "Network Score Service");
                                                                        networkScoreService = new NetworkScoreService(context);
                                                                        ServiceManager.addService("network_score", networkScoreService);
                                                                        networkScore = networkScoreService;
                                                                        Slog.i(TAG, "NetworkStats Service");
                                                                        networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                                        ServiceManager.addService("netstats", networkStatsService);
                                                                        networkStats = networkStatsService;
                                                                        Slog.i(TAG, "NetworkPolicy Service");
                                                                        networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                                        ServiceManager.addService("netpolicy", networkPolicy);
                                                                        this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                        this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                        this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                        this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                            this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                        }
                                                                        Slog.i(TAG, "Connectivity Service");
                                                                        connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                        ServiceManager.addService("connectivity", connectivityService);
                                                                        networkStats.bindConnectivityManager(connectivityService);
                                                                        networkPolicy.bindConnectivityManager(connectivityService);
                                                                        connectivity = connectivityService;
                                                                        Slog.i(TAG, "Network Service Discovery Service");
                                                                        ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                        Slog.i(TAG, "DPM Service");
                                                                        startDpmService(context);
                                                                    }
                                                                    if (disableNonCoreServices) {
                                                                        Slog.i(TAG, "UpdateLock Service");
                                                                        ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                    }
                                                                    mountService2.waitForAsecScan();
                                                                    if (accountManagerService != null) {
                                                                        accountManagerService.systemReady();
                                                                    }
                                                                    if (contentService != null) {
                                                                        contentService.systemReady();
                                                                    }
                                                                    this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                    networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                    this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                    if (disableLocation) {
                                                                        Slog.i(TAG, "Location Manager");
                                                                        locationManagerService = new LocationManagerService(context);
                                                                        ServiceManager.addService("location", locationManagerService);
                                                                        location = locationManagerService;
                                                                        Slog.i(TAG, "Country Detector");
                                                                        countryDetectorService = new CountryDetectorService(context);
                                                                        ServiceManager.addService("country_detector", countryDetectorService);
                                                                        countryDetector = countryDetectorService;
                                                                    }
                                                                    if (disableNonCoreServices) {
                                                                        Slog.i(TAG, "Search Service");
                                                                        ServiceManager.addService("search", new SearchManagerService(context));
                                                                    }
                                                                    Slog.i(TAG, "DropBox Service");
                                                                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                    Slog.i(TAG, "Wallpaper Service");
                                                                    wallpaperManagerService = new WallpaperManagerService(context);
                                                                    try {
                                                                        ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                        wallpaper = wallpaperManagerService;
                                                                    } catch (Throwable th26) {
                                                                        e4222222222222 = th26;
                                                                        wallpaper = wallpaperManagerService;
                                                                        reportWtf("starting Wallpaper Service", e4222222222222);
                                                                        Slog.i(TAG, "Audio Service");
                                                                        audioService = new AudioService(context);
                                                                        ServiceManager.addService("audio", audioService);
                                                                        audioService2 = audioService;
                                                                        if (disableNonCoreServices) {
                                                                            this.mSystemServiceManager.startService(DockObserver.class);
                                                                        }
                                                                        if (disableMedia) {
                                                                            Slog.i(TAG, "Wired Accessory Manager");
                                                                            inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                        }
                                                                        if (disableNonCoreServices) {
                                                                            this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                            Slog.i(TAG, "Serial Service");
                                                                            serialService = new SerialService(context);
                                                                            ServiceManager.addService("serial", serialService);
                                                                            serialService2 = serialService;
                                                                        }
                                                                        this.mSystemServiceManager.startService(TwilightService.class);
                                                                        this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                        this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                        if (disableNonCoreServices) {
                                                                            if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                            }
                                                                            if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                            }
                                                                            if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                            }
                                                                        }
                                                                        Slog.i(TAG, "DiskStats Service");
                                                                        ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                        Slog.i(TAG, "SamplingProfiler Service");
                                                                        ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                        Slog.i(TAG, "NetworkTimeUpdateService");
                                                                        networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                        if (disableMedia) {
                                                                            Slog.i(TAG, "CommonTimeManagementService");
                                                                            commonTimeManagementService = new CommonTimeManagementService(context);
                                                                            ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                            commonTimeMgmtService = commonTimeManagementService;
                                                                        }
                                                                        if (disableNetwork) {
                                                                            Slog.i(TAG, "CertBlacklister");
                                                                            certBlacklister = new CertBlacklister(context);
                                                                        }
                                                                        if (disableNonCoreServices) {
                                                                            this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                        }
                                                                        Slog.i(TAG, "Assets Atlas Service");
                                                                        assetAtlasService = new AssetAtlasService(context);
                                                                        ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                        atlas = assetAtlasService;
                                                                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                        }
                                                                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                        this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                            this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                        }
                                                                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                        }
                                                                        if (disableNonCoreServices) {
                                                                            Slog.i(TAG, "Media Router Service");
                                                                            mediaRouterService = new MediaRouterService(context);
                                                                            ServiceManager.addService("media_router", mediaRouterService);
                                                                            mediaRouter = mediaRouterService;
                                                                            this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                            this.mSystemServiceManager.startService(FingerprintService.class);
                                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                                            BackgroundDexOptService.schedule(context);
                                                                        }
                                                                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                            WBC_SERVICE_NAME = "wbc_service";
                                                                            Slog.i(TAG, "WipowerBatteryControl Service");
                                                                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                            Slog.d(TAG, "Successfully loaded WbcService class");
                                                                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                        } else {
                                                                            Slog.d(TAG, "Wipower not supported");
                                                                        }
                                                                        if (disableNonCoreServices) {
                                                                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                        }
                                                                        safeMode = wm.detectSafeMode();
                                                                        if (safeMode) {
                                                                            this.mActivityManagerService.enterSafeMode();
                                                                            VMRuntime.getRuntime().disableJitCompilation();
                                                                        } else {
                                                                            VMRuntime.getRuntime().startJitCompilation();
                                                                        }
                                                                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                        vibrator.systemReady();
                                                                        if (lockSettings != null) {
                                                                            lockSettings.systemReady();
                                                                        }
                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                        wm.systemReady();
                                                                        if (safeMode) {
                                                                            this.mActivityManagerService.showSafeModeOverlay();
                                                                        }
                                                                        config = wm.computeNewConfiguration();
                                                                        metrics = new DisplayMetrics();
                                                                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                        context.getResources().updateConfiguration(config, metrics);
                                                                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                        this.mPackageManagerService.systemReady();
                                                                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                        audioServiceF = audioService2;
                                                                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                    }
                                                                    Slog.i(TAG, "Audio Service");
                                                                    audioService = new AudioService(context);
                                                                    try {
                                                                        ServiceManager.addService("audio", audioService);
                                                                        audioService2 = audioService;
                                                                    } catch (Throwable th27) {
                                                                        e4222222222222 = th27;
                                                                        audioService2 = audioService;
                                                                        reportWtf("starting Audio Service", e4222222222222);
                                                                        if (disableNonCoreServices) {
                                                                            this.mSystemServiceManager.startService(DockObserver.class);
                                                                        }
                                                                        if (disableMedia) {
                                                                            Slog.i(TAG, "Wired Accessory Manager");
                                                                            inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                        }
                                                                        if (disableNonCoreServices) {
                                                                            this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                            Slog.i(TAG, "Serial Service");
                                                                            serialService = new SerialService(context);
                                                                            ServiceManager.addService("serial", serialService);
                                                                            serialService2 = serialService;
                                                                        }
                                                                        this.mSystemServiceManager.startService(TwilightService.class);
                                                                        this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                        this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                        if (disableNonCoreServices) {
                                                                            if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                                this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                            }
                                                                            if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                                this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                            }
                                                                            if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                                this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                            }
                                                                        }
                                                                        Slog.i(TAG, "DiskStats Service");
                                                                        ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                        Slog.i(TAG, "SamplingProfiler Service");
                                                                        ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                        Slog.i(TAG, "NetworkTimeUpdateService");
                                                                        networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                        if (disableMedia) {
                                                                            Slog.i(TAG, "CommonTimeManagementService");
                                                                            commonTimeManagementService = new CommonTimeManagementService(context);
                                                                            ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                            commonTimeMgmtService = commonTimeManagementService;
                                                                        }
                                                                        if (disableNetwork) {
                                                                            Slog.i(TAG, "CertBlacklister");
                                                                            certBlacklister = new CertBlacklister(context);
                                                                        }
                                                                        if (disableNonCoreServices) {
                                                                            this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                        }
                                                                        Slog.i(TAG, "Assets Atlas Service");
                                                                        assetAtlasService = new AssetAtlasService(context);
                                                                        ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                        atlas = assetAtlasService;
                                                                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                        }
                                                                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                        this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                            this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                        }
                                                                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                        }
                                                                        if (disableNonCoreServices) {
                                                                            Slog.i(TAG, "Media Router Service");
                                                                            mediaRouterService = new MediaRouterService(context);
                                                                            ServiceManager.addService("media_router", mediaRouterService);
                                                                            mediaRouter = mediaRouterService;
                                                                            this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                            this.mSystemServiceManager.startService(FingerprintService.class);
                                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                                            BackgroundDexOptService.schedule(context);
                                                                        }
                                                                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                            Slog.d(TAG, "Wipower not supported");
                                                                        } else {
                                                                            WBC_SERVICE_NAME = "wbc_service";
                                                                            Slog.i(TAG, "WipowerBatteryControl Service");
                                                                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                            Slog.d(TAG, "Successfully loaded WbcService class");
                                                                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                        }
                                                                        if (disableNonCoreServices) {
                                                                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                        }
                                                                        safeMode = wm.detectSafeMode();
                                                                        if (safeMode) {
                                                                            VMRuntime.getRuntime().startJitCompilation();
                                                                        } else {
                                                                            this.mActivityManagerService.enterSafeMode();
                                                                            VMRuntime.getRuntime().disableJitCompilation();
                                                                        }
                                                                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                        vibrator.systemReady();
                                                                        if (lockSettings != null) {
                                                                            lockSettings.systemReady();
                                                                        }
                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                        wm.systemReady();
                                                                        if (safeMode) {
                                                                            this.mActivityManagerService.showSafeModeOverlay();
                                                                        }
                                                                        config = wm.computeNewConfiguration();
                                                                        metrics = new DisplayMetrics();
                                                                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                        context.getResources().updateConfiguration(config, metrics);
                                                                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                        this.mPackageManagerService.systemReady();
                                                                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                        audioServiceF = audioService2;
                                                                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                    }
                                                                    if (disableNonCoreServices) {
                                                                        this.mSystemServiceManager.startService(DockObserver.class);
                                                                    }
                                                                    if (disableMedia) {
                                                                        Slog.i(TAG, "Wired Accessory Manager");
                                                                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                    }
                                                                    if (disableNonCoreServices) {
                                                                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                        Slog.i(TAG, "Serial Service");
                                                                        serialService = new SerialService(context);
                                                                        ServiceManager.addService("serial", serialService);
                                                                        serialService2 = serialService;
                                                                    }
                                                                    this.mSystemServiceManager.startService(TwilightService.class);
                                                                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                    if (disableNonCoreServices) {
                                                                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                        }
                                                                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                        }
                                                                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                        }
                                                                    }
                                                                    Slog.i(TAG, "DiskStats Service");
                                                                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                    Slog.i(TAG, "SamplingProfiler Service");
                                                                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                    Slog.i(TAG, "NetworkTimeUpdateService");
                                                                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                    if (disableMedia) {
                                                                        Slog.i(TAG, "CommonTimeManagementService");
                                                                        commonTimeManagementService = new CommonTimeManagementService(context);
                                                                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                        commonTimeMgmtService = commonTimeManagementService;
                                                                    }
                                                                    if (disableNetwork) {
                                                                        Slog.i(TAG, "CertBlacklister");
                                                                        certBlacklister = new CertBlacklister(context);
                                                                    }
                                                                    if (disableNonCoreServices) {
                                                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                    }
                                                                    Slog.i(TAG, "Assets Atlas Service");
                                                                    assetAtlasService = new AssetAtlasService(context);
                                                                    try {
                                                                        ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                        atlas = assetAtlasService;
                                                                    } catch (Throwable th28) {
                                                                        e4222222222222 = th28;
                                                                        atlas = assetAtlasService;
                                                                        reportWtf("starting AssetAtlasService", e4222222222222);
                                                                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                        }
                                                                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                        this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                            this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                        }
                                                                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                        }
                                                                        if (disableNonCoreServices) {
                                                                            Slog.i(TAG, "Media Router Service");
                                                                            mediaRouterService = new MediaRouterService(context);
                                                                            ServiceManager.addService("media_router", mediaRouterService);
                                                                            mediaRouter = mediaRouterService;
                                                                            this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                            this.mSystemServiceManager.startService(FingerprintService.class);
                                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                                            BackgroundDexOptService.schedule(context);
                                                                        }
                                                                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                            Slog.d(TAG, "Wipower not supported");
                                                                        } else {
                                                                            WBC_SERVICE_NAME = "wbc_service";
                                                                            Slog.i(TAG, "WipowerBatteryControl Service");
                                                                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                            Slog.d(TAG, "Successfully loaded WbcService class");
                                                                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                        }
                                                                        if (disableNonCoreServices) {
                                                                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                        }
                                                                        safeMode = wm.detectSafeMode();
                                                                        if (safeMode) {
                                                                            VMRuntime.getRuntime().startJitCompilation();
                                                                        } else {
                                                                            this.mActivityManagerService.enterSafeMode();
                                                                            VMRuntime.getRuntime().disableJitCompilation();
                                                                        }
                                                                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                        vibrator.systemReady();
                                                                        if (lockSettings != null) {
                                                                            lockSettings.systemReady();
                                                                        }
                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                        wm.systemReady();
                                                                        if (safeMode) {
                                                                            this.mActivityManagerService.showSafeModeOverlay();
                                                                        }
                                                                        config = wm.computeNewConfiguration();
                                                                        metrics = new DisplayMetrics();
                                                                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                        context.getResources().updateConfiguration(config, metrics);
                                                                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                        this.mPackageManagerService.systemReady();
                                                                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                        audioServiceF = audioService2;
                                                                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                    }
                                                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                    }
                                                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                    }
                                                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                    }
                                                                    if (disableNonCoreServices) {
                                                                        Slog.i(TAG, "Media Router Service");
                                                                        mediaRouterService = new MediaRouterService(context);
                                                                        ServiceManager.addService("media_router", mediaRouterService);
                                                                        mediaRouter = mediaRouterService;
                                                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                                                        Slog.i(TAG, "BackgroundDexOptService");
                                                                        BackgroundDexOptService.schedule(context);
                                                                    }
                                                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                        WBC_SERVICE_NAME = "wbc_service";
                                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                    } else {
                                                                        Slog.d(TAG, "Wipower not supported");
                                                                    }
                                                                    if (disableNonCoreServices) {
                                                                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                    }
                                                                    safeMode = wm.detectSafeMode();
                                                                    if (safeMode) {
                                                                        this.mActivityManagerService.enterSafeMode();
                                                                        VMRuntime.getRuntime().disableJitCompilation();
                                                                    } else {
                                                                        VMRuntime.getRuntime().startJitCompilation();
                                                                    }
                                                                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                    vibrator.systemReady();
                                                                    if (lockSettings != null) {
                                                                        lockSettings.systemReady();
                                                                    }
                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                    wm.systemReady();
                                                                    if (safeMode) {
                                                                        this.mActivityManagerService.showSafeModeOverlay();
                                                                    }
                                                                    config = wm.computeNewConfiguration();
                                                                    metrics = new DisplayMetrics();
                                                                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                    context.getResources().updateConfiguration(config, metrics);
                                                                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                    this.mPackageManagerService.systemReady();
                                                                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                    audioServiceF = audioService2;
                                                                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                                }
                                                            } catch (Throwable th29) {
                                                                e4222222222222 = th29;
                                                                reportWtf("starting LockSettingsService service", e4222222222222);
                                                                if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                                                    this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                                                                }
                                                                this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                                                                if (disableSystemUI) {
                                                                    Slog.i(TAG, "Status Bar");
                                                                    statusBarManagerService = new StatusBarManagerService(context, wm);
                                                                    ServiceManager.addService("statusbar", statusBarManagerService);
                                                                    statusBar = statusBarManagerService;
                                                                }
                                                                if (disableNonCoreServices) {
                                                                    Slog.i(TAG, "Clipboard Service");
                                                                    ServiceManager.addService("clipboard", new ClipboardService(context));
                                                                }
                                                                if (disableNetwork) {
                                                                    Slog.i(TAG, "NetworkManagement Service");
                                                                    networkManagement = NetworkManagementService.create(context);
                                                                    ServiceManager.addService("network_management", networkManagement);
                                                                }
                                                                if (disableNonCoreServices) {
                                                                    Slog.i(TAG, "Text Service Manager Service");
                                                                    textServicesManagerService = new TextServicesManagerService(context);
                                                                    ServiceManager.addService("textservices", textServicesManagerService);
                                                                    tsms = textServicesManagerService;
                                                                }
                                                                if (disableNetwork) {
                                                                    networkPolicy = null;
                                                                } else {
                                                                    Slog.i(TAG, "Network Score Service");
                                                                    networkScoreService = new NetworkScoreService(context);
                                                                    ServiceManager.addService("network_score", networkScoreService);
                                                                    networkScore = networkScoreService;
                                                                    Slog.i(TAG, "NetworkStats Service");
                                                                    networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                                    ServiceManager.addService("netstats", networkStatsService);
                                                                    networkStats = networkStatsService;
                                                                    Slog.i(TAG, "NetworkPolicy Service");
                                                                    networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                                    ServiceManager.addService("netpolicy", networkPolicy);
                                                                    this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                                    this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                                    this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                                    this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                        this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                                    }
                                                                    Slog.i(TAG, "Connectivity Service");
                                                                    connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                                    ServiceManager.addService("connectivity", connectivityService);
                                                                    networkStats.bindConnectivityManager(connectivityService);
                                                                    networkPolicy.bindConnectivityManager(connectivityService);
                                                                    connectivity = connectivityService;
                                                                    Slog.i(TAG, "Network Service Discovery Service");
                                                                    ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                                    Slog.i(TAG, "DPM Service");
                                                                    startDpmService(context);
                                                                }
                                                                if (disableNonCoreServices) {
                                                                    Slog.i(TAG, "UpdateLock Service");
                                                                    ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                                }
                                                                mountService2.waitForAsecScan();
                                                                if (accountManagerService != null) {
                                                                    accountManagerService.systemReady();
                                                                }
                                                                if (contentService != null) {
                                                                    contentService.systemReady();
                                                                }
                                                                this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                                networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                                this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                                if (disableLocation) {
                                                                    Slog.i(TAG, "Location Manager");
                                                                    locationManagerService = new LocationManagerService(context);
                                                                    ServiceManager.addService("location", locationManagerService);
                                                                    location = locationManagerService;
                                                                    Slog.i(TAG, "Country Detector");
                                                                    countryDetectorService = new CountryDetectorService(context);
                                                                    ServiceManager.addService("country_detector", countryDetectorService);
                                                                    countryDetector = countryDetectorService;
                                                                }
                                                                if (disableNonCoreServices) {
                                                                    Slog.i(TAG, "Search Service");
                                                                    ServiceManager.addService("search", new SearchManagerService(context));
                                                                }
                                                                Slog.i(TAG, "DropBox Service");
                                                                ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                                Slog.i(TAG, "Wallpaper Service");
                                                                wallpaperManagerService = new WallpaperManagerService(context);
                                                                ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                                wallpaper = wallpaperManagerService;
                                                                Slog.i(TAG, "Audio Service");
                                                                audioService = new AudioService(context);
                                                                ServiceManager.addService("audio", audioService);
                                                                audioService2 = audioService;
                                                                if (disableNonCoreServices) {
                                                                    this.mSystemServiceManager.startService(DockObserver.class);
                                                                }
                                                                if (disableMedia) {
                                                                    Slog.i(TAG, "Wired Accessory Manager");
                                                                    inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                                }
                                                                if (disableNonCoreServices) {
                                                                    this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                    Slog.i(TAG, "Serial Service");
                                                                    serialService = new SerialService(context);
                                                                    ServiceManager.addService("serial", serialService);
                                                                    serialService2 = serialService;
                                                                }
                                                                this.mSystemServiceManager.startService(TwilightService.class);
                                                                this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                                this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                                if (disableNonCoreServices) {
                                                                    if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                        this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                    }
                                                                    if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                        this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                    }
                                                                    if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                        this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                    }
                                                                }
                                                                Slog.i(TAG, "DiskStats Service");
                                                                ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                                Slog.i(TAG, "SamplingProfiler Service");
                                                                ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                                Slog.i(TAG, "NetworkTimeUpdateService");
                                                                networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                                if (disableMedia) {
                                                                    Slog.i(TAG, "CommonTimeManagementService");
                                                                    commonTimeManagementService = new CommonTimeManagementService(context);
                                                                    ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                    commonTimeMgmtService = commonTimeManagementService;
                                                                }
                                                                if (disableNetwork) {
                                                                    Slog.i(TAG, "CertBlacklister");
                                                                    certBlacklister = new CertBlacklister(context);
                                                                }
                                                                if (disableNonCoreServices) {
                                                                    this.mSystemServiceManager.startService(DreamManagerService.class);
                                                                }
                                                                Slog.i(TAG, "Assets Atlas Service");
                                                                assetAtlasService = new AssetAtlasService(context);
                                                                ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                                atlas = assetAtlasService;
                                                                if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                    this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                                }
                                                                this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                                this.mSystemServiceManager.startService(MediaSessionService.class);
                                                                if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                    this.mSystemServiceManager.startService(HdmiControlService.class);
                                                                }
                                                                if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                    this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                                }
                                                                if (disableNonCoreServices) {
                                                                    Slog.i(TAG, "Media Router Service");
                                                                    mediaRouterService = new MediaRouterService(context);
                                                                    ServiceManager.addService("media_router", mediaRouterService);
                                                                    mediaRouter = mediaRouterService;
                                                                    this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                    this.mSystemServiceManager.startService(FingerprintService.class);
                                                                    Slog.i(TAG, "BackgroundDexOptService");
                                                                    BackgroundDexOptService.schedule(context);
                                                                }
                                                                this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                                if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                    Slog.d(TAG, "Wipower not supported");
                                                                } else {
                                                                    WBC_SERVICE_NAME = "wbc_service";
                                                                    Slog.i(TAG, "WipowerBatteryControl Service");
                                                                    wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                    Slog.d(TAG, "Successfully loaded WbcService class");
                                                                    ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                                }
                                                                if (disableNonCoreServices) {
                                                                    this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                                }
                                                                safeMode = wm.detectSafeMode();
                                                                if (safeMode) {
                                                                    VMRuntime.getRuntime().startJitCompilation();
                                                                } else {
                                                                    this.mActivityManagerService.enterSafeMode();
                                                                    VMRuntime.getRuntime().disableJitCompilation();
                                                                }
                                                                mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                                vibrator.systemReady();
                                                                if (lockSettings != null) {
                                                                    lockSettings.systemReady();
                                                                }
                                                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                                wm.systemReady();
                                                                if (safeMode) {
                                                                    this.mActivityManagerService.showSafeModeOverlay();
                                                                }
                                                                config = wm.computeNewConfiguration();
                                                                metrics = new DisplayMetrics();
                                                                ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                                context.getResources().updateConfiguration(config, metrics);
                                                                this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                                this.mPackageManagerService.systemReady();
                                                                this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                                audioServiceF = audioService2;
                                                                this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                            }
                                                            if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                                                this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                                                            }
                                                            this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                                                        }
                                                        if (disableSystemUI) {
                                                            Slog.i(TAG, "Status Bar");
                                                            statusBarManagerService = new StatusBarManagerService(context, wm);
                                                            ServiceManager.addService("statusbar", statusBarManagerService);
                                                            statusBar = statusBarManagerService;
                                                        }
                                                        if (disableNonCoreServices) {
                                                            Slog.i(TAG, "Clipboard Service");
                                                            ServiceManager.addService("clipboard", new ClipboardService(context));
                                                        }
                                                        if (disableNetwork) {
                                                            Slog.i(TAG, "NetworkManagement Service");
                                                            networkManagement = NetworkManagementService.create(context);
                                                            ServiceManager.addService("network_management", networkManagement);
                                                        }
                                                        if (disableNonCoreServices) {
                                                            Slog.i(TAG, "Text Service Manager Service");
                                                            textServicesManagerService = new TextServicesManagerService(context);
                                                            ServiceManager.addService("textservices", textServicesManagerService);
                                                            tsms = textServicesManagerService;
                                                        }
                                                        if (disableNetwork) {
                                                            Slog.i(TAG, "Network Score Service");
                                                            networkScoreService = new NetworkScoreService(context);
                                                            ServiceManager.addService("network_score", networkScoreService);
                                                            networkScore = networkScoreService;
                                                            Slog.i(TAG, "NetworkStats Service");
                                                            networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                            ServiceManager.addService("netstats", networkStatsService);
                                                            networkStats = networkStatsService;
                                                            Slog.i(TAG, "NetworkPolicy Service");
                                                            networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                            ServiceManager.addService("netpolicy", networkPolicy);
                                                            this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                            this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                            this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                            this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                                this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                            }
                                                            Slog.i(TAG, "Connectivity Service");
                                                            connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                            ServiceManager.addService("connectivity", connectivityService);
                                                            networkStats.bindConnectivityManager(connectivityService);
                                                            networkPolicy.bindConnectivityManager(connectivityService);
                                                            connectivity = connectivityService;
                                                            Slog.i(TAG, "Network Service Discovery Service");
                                                            ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                            Slog.i(TAG, "DPM Service");
                                                            startDpmService(context);
                                                        } else {
                                                            networkPolicy = null;
                                                        }
                                                        if (disableNonCoreServices) {
                                                            Slog.i(TAG, "UpdateLock Service");
                                                            ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                        }
                                                        mountService2.waitForAsecScan();
                                                        if (accountManagerService != null) {
                                                            accountManagerService.systemReady();
                                                        }
                                                        if (contentService != null) {
                                                            contentService.systemReady();
                                                        }
                                                        this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                        networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                        this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                        if (disableLocation) {
                                                            Slog.i(TAG, "Location Manager");
                                                            locationManagerService = new LocationManagerService(context);
                                                            ServiceManager.addService("location", locationManagerService);
                                                            location = locationManagerService;
                                                            Slog.i(TAG, "Country Detector");
                                                            countryDetectorService = new CountryDetectorService(context);
                                                            ServiceManager.addService("country_detector", countryDetectorService);
                                                            countryDetector = countryDetectorService;
                                                        }
                                                        if (disableNonCoreServices) {
                                                            Slog.i(TAG, "Search Service");
                                                            ServiceManager.addService("search", new SearchManagerService(context));
                                                        }
                                                        try {
                                                            Slog.i(TAG, "DropBox Service");
                                                            ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                        } catch (Throwable e42222222222222) {
                                                            reportWtf("starting DropBoxManagerService", e42222222222222);
                                                        }
                                                        try {
                                                            Slog.i(TAG, "Wallpaper Service");
                                                            wallpaperManagerService = new WallpaperManagerService(context);
                                                            ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                            wallpaper = wallpaperManagerService;
                                                        } catch (Throwable th30) {
                                                            e42222222222222 = th30;
                                                            reportWtf("starting Wallpaper Service", e42222222222222);
                                                            Slog.i(TAG, "Audio Service");
                                                            audioService = new AudioService(context);
                                                            ServiceManager.addService("audio", audioService);
                                                            audioService2 = audioService;
                                                            if (disableNonCoreServices) {
                                                                this.mSystemServiceManager.startService(DockObserver.class);
                                                            }
                                                            if (disableMedia) {
                                                                Slog.i(TAG, "Wired Accessory Manager");
                                                                inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                            }
                                                            if (disableNonCoreServices) {
                                                                this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                Slog.i(TAG, "Serial Service");
                                                                serialService = new SerialService(context);
                                                                ServiceManager.addService("serial", serialService);
                                                                serialService2 = serialService;
                                                            }
                                                            this.mSystemServiceManager.startService(TwilightService.class);
                                                            this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                            this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                            if (disableNonCoreServices) {
                                                                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                }
                                                                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                }
                                                                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                }
                                                            }
                                                            Slog.i(TAG, "DiskStats Service");
                                                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                            Slog.i(TAG, "SamplingProfiler Service");
                                                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                            Slog.i(TAG, "NetworkTimeUpdateService");
                                                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                            if (disableMedia) {
                                                                Slog.i(TAG, "CommonTimeManagementService");
                                                                commonTimeManagementService = new CommonTimeManagementService(context);
                                                                ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                commonTimeMgmtService = commonTimeManagementService;
                                                            }
                                                            if (disableNetwork) {
                                                                Slog.i(TAG, "CertBlacklister");
                                                                certBlacklister = new CertBlacklister(context);
                                                            }
                                                            if (disableNonCoreServices) {
                                                                this.mSystemServiceManager.startService(DreamManagerService.class);
                                                            }
                                                            Slog.i(TAG, "Assets Atlas Service");
                                                            assetAtlasService = new AssetAtlasService(context);
                                                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                            atlas = assetAtlasService;
                                                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                            }
                                                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                            this.mSystemServiceManager.startService(MediaSessionService.class);
                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                this.mSystemServiceManager.startService(HdmiControlService.class);
                                                            }
                                                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                            }
                                                            if (disableNonCoreServices) {
                                                                Slog.i(TAG, "Media Router Service");
                                                                mediaRouterService = new MediaRouterService(context);
                                                                ServiceManager.addService("media_router", mediaRouterService);
                                                                mediaRouter = mediaRouterService;
                                                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                this.mSystemServiceManager.startService(FingerprintService.class);
                                                                Slog.i(TAG, "BackgroundDexOptService");
                                                                BackgroundDexOptService.schedule(context);
                                                            }
                                                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                WBC_SERVICE_NAME = "wbc_service";
                                                                Slog.i(TAG, "WipowerBatteryControl Service");
                                                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                Slog.d(TAG, "Successfully loaded WbcService class");
                                                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                            } else {
                                                                Slog.d(TAG, "Wipower not supported");
                                                            }
                                                            if (disableNonCoreServices) {
                                                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                            }
                                                            safeMode = wm.detectSafeMode();
                                                            if (safeMode) {
                                                                this.mActivityManagerService.enterSafeMode();
                                                                VMRuntime.getRuntime().disableJitCompilation();
                                                            } else {
                                                                VMRuntime.getRuntime().startJitCompilation();
                                                            }
                                                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                            vibrator.systemReady();
                                                            if (lockSettings != null) {
                                                                lockSettings.systemReady();
                                                            }
                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                            wm.systemReady();
                                                            if (safeMode) {
                                                                this.mActivityManagerService.showSafeModeOverlay();
                                                            }
                                                            config = wm.computeNewConfiguration();
                                                            metrics = new DisplayMetrics();
                                                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                            context.getResources().updateConfiguration(config, metrics);
                                                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                            this.mPackageManagerService.systemReady();
                                                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                            audioServiceF = audioService2;
                                                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                        }
                                                        try {
                                                            Slog.i(TAG, "Audio Service");
                                                            audioService = new AudioService(context);
                                                            ServiceManager.addService("audio", audioService);
                                                            audioService2 = audioService;
                                                        } catch (Throwable th31) {
                                                            e42222222222222 = th31;
                                                            reportWtf("starting Audio Service", e42222222222222);
                                                            if (disableNonCoreServices) {
                                                                this.mSystemServiceManager.startService(DockObserver.class);
                                                            }
                                                            if (disableMedia) {
                                                                Slog.i(TAG, "Wired Accessory Manager");
                                                                inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                            }
                                                            if (disableNonCoreServices) {
                                                                this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                                Slog.i(TAG, "Serial Service");
                                                                serialService = new SerialService(context);
                                                                ServiceManager.addService("serial", serialService);
                                                                serialService2 = serialService;
                                                            }
                                                            this.mSystemServiceManager.startService(TwilightService.class);
                                                            this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                            this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                            if (disableNonCoreServices) {
                                                                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                                }
                                                                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                                }
                                                                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                                }
                                                            }
                                                            Slog.i(TAG, "DiskStats Service");
                                                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                            Slog.i(TAG, "SamplingProfiler Service");
                                                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                            Slog.i(TAG, "NetworkTimeUpdateService");
                                                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                            if (disableMedia) {
                                                                Slog.i(TAG, "CommonTimeManagementService");
                                                                commonTimeManagementService = new CommonTimeManagementService(context);
                                                                ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                                commonTimeMgmtService = commonTimeManagementService;
                                                            }
                                                            if (disableNetwork) {
                                                                Slog.i(TAG, "CertBlacklister");
                                                                certBlacklister = new CertBlacklister(context);
                                                            }
                                                            if (disableNonCoreServices) {
                                                                this.mSystemServiceManager.startService(DreamManagerService.class);
                                                            }
                                                            Slog.i(TAG, "Assets Atlas Service");
                                                            assetAtlasService = new AssetAtlasService(context);
                                                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                            atlas = assetAtlasService;
                                                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                            }
                                                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                            this.mSystemServiceManager.startService(MediaSessionService.class);
                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                this.mSystemServiceManager.startService(HdmiControlService.class);
                                                            }
                                                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                            }
                                                            if (disableNonCoreServices) {
                                                                Slog.i(TAG, "Media Router Service");
                                                                mediaRouterService = new MediaRouterService(context);
                                                                ServiceManager.addService("media_router", mediaRouterService);
                                                                mediaRouter = mediaRouterService;
                                                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                this.mSystemServiceManager.startService(FingerprintService.class);
                                                                Slog.i(TAG, "BackgroundDexOptService");
                                                                BackgroundDexOptService.schedule(context);
                                                            }
                                                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                WBC_SERVICE_NAME = "wbc_service";
                                                                Slog.i(TAG, "WipowerBatteryControl Service");
                                                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                Slog.d(TAG, "Successfully loaded WbcService class");
                                                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                            } else {
                                                                Slog.d(TAG, "Wipower not supported");
                                                            }
                                                            if (disableNonCoreServices) {
                                                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                            }
                                                            safeMode = wm.detectSafeMode();
                                                            if (safeMode) {
                                                                this.mActivityManagerService.enterSafeMode();
                                                                VMRuntime.getRuntime().disableJitCompilation();
                                                            } else {
                                                                VMRuntime.getRuntime().startJitCompilation();
                                                            }
                                                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                            vibrator.systemReady();
                                                            if (lockSettings != null) {
                                                                lockSettings.systemReady();
                                                            }
                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                            wm.systemReady();
                                                            if (safeMode) {
                                                                this.mActivityManagerService.showSafeModeOverlay();
                                                            }
                                                            config = wm.computeNewConfiguration();
                                                            metrics = new DisplayMetrics();
                                                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                            context.getResources().updateConfiguration(config, metrics);
                                                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                            this.mPackageManagerService.systemReady();
                                                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                            audioServiceF = audioService2;
                                                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                        }
                                                        if (disableNonCoreServices) {
                                                            this.mSystemServiceManager.startService(DockObserver.class);
                                                        }
                                                        if (disableMedia) {
                                                            Slog.i(TAG, "Wired Accessory Manager");
                                                            inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                        }
                                                        if (disableNonCoreServices) {
                                                            this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                            Slog.i(TAG, "Serial Service");
                                                            serialService = new SerialService(context);
                                                            ServiceManager.addService("serial", serialService);
                                                            serialService2 = serialService;
                                                        }
                                                        this.mSystemServiceManager.startService(TwilightService.class);
                                                        this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                        this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                        if (disableNonCoreServices) {
                                                            if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                                this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                            }
                                                            if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                                this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                            }
                                                            if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                                this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                            }
                                                        }
                                                        try {
                                                            Slog.i(TAG, "DiskStats Service");
                                                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                        } catch (Throwable e422222222222222) {
                                                            reportWtf("starting DiskStats Service", e422222222222222);
                                                        }
                                                        try {
                                                            Slog.i(TAG, "SamplingProfiler Service");
                                                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                        } catch (Throwable e4222222222222222) {
                                                            reportWtf("starting SamplingProfiler Service", e4222222222222222);
                                                        }
                                                        try {
                                                            Slog.i(TAG, "NetworkTimeUpdateService");
                                                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                        } catch (Throwable e42222222222222222) {
                                                            reportWtf("starting NetworkTimeUpdate service", e42222222222222222);
                                                        }
                                                        if (disableMedia) {
                                                            Slog.i(TAG, "CommonTimeManagementService");
                                                            commonTimeManagementService = new CommonTimeManagementService(context);
                                                            ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                            commonTimeMgmtService = commonTimeManagementService;
                                                        }
                                                        if (disableNetwork) {
                                                            Slog.i(TAG, "CertBlacklister");
                                                            certBlacklister = new CertBlacklister(context);
                                                        }
                                                        if (disableNonCoreServices) {
                                                            this.mSystemServiceManager.startService(DreamManagerService.class);
                                                        }
                                                        try {
                                                            Slog.i(TAG, "Assets Atlas Service");
                                                            assetAtlasService = new AssetAtlasService(context);
                                                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                            atlas = assetAtlasService;
                                                        } catch (Throwable th32) {
                                                            e42222222222222222 = th32;
                                                            reportWtf("starting AssetAtlasService", e42222222222222222);
                                                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                            }
                                                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                            this.mSystemServiceManager.startService(MediaSessionService.class);
                                                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                                this.mSystemServiceManager.startService(HdmiControlService.class);
                                                            }
                                                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                            }
                                                            if (disableNonCoreServices) {
                                                                Slog.i(TAG, "Media Router Service");
                                                                mediaRouterService = new MediaRouterService(context);
                                                                ServiceManager.addService("media_router", mediaRouterService);
                                                                mediaRouter = mediaRouterService;
                                                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                                                this.mSystemServiceManager.startService(FingerprintService.class);
                                                                Slog.i(TAG, "BackgroundDexOptService");
                                                                BackgroundDexOptService.schedule(context);
                                                            }
                                                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                                Slog.d(TAG, "Wipower not supported");
                                                            } else {
                                                                WBC_SERVICE_NAME = "wbc_service";
                                                                Slog.i(TAG, "WipowerBatteryControl Service");
                                                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                                Slog.d(TAG, "Successfully loaded WbcService class");
                                                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                            }
                                                            if (disableNonCoreServices) {
                                                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                            }
                                                            safeMode = wm.detectSafeMode();
                                                            if (safeMode) {
                                                                VMRuntime.getRuntime().startJitCompilation();
                                                            } else {
                                                                this.mActivityManagerService.enterSafeMode();
                                                                VMRuntime.getRuntime().disableJitCompilation();
                                                            }
                                                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                            vibrator.systemReady();
                                                            if (lockSettings != null) {
                                                                lockSettings.systemReady();
                                                            }
                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                            wm.systemReady();
                                                            if (safeMode) {
                                                                this.mActivityManagerService.showSafeModeOverlay();
                                                            }
                                                            config = wm.computeNewConfiguration();
                                                            metrics = new DisplayMetrics();
                                                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                            context.getResources().updateConfiguration(config, metrics);
                                                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                            this.mPackageManagerService.systemReady();
                                                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                            audioServiceF = audioService2;
                                                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                        }
                                                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                        }
                                                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                        this.mSystemServiceManager.startService(MediaSessionService.class);
                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                            this.mSystemServiceManager.startService(HdmiControlService.class);
                                                        }
                                                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                        }
                                                        if (disableNonCoreServices) {
                                                            Slog.i(TAG, "Media Router Service");
                                                            mediaRouterService = new MediaRouterService(context);
                                                            ServiceManager.addService("media_router", mediaRouterService);
                                                            mediaRouter = mediaRouterService;
                                                            this.mSystemServiceManager.startService(TrustManagerService.class);
                                                            this.mSystemServiceManager.startService(FingerprintService.class);
                                                            Slog.i(TAG, "BackgroundDexOptService");
                                                            BackgroundDexOptService.schedule(context);
                                                        }
                                                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                            Slog.d(TAG, "Wipower not supported");
                                                        } else {
                                                            WBC_SERVICE_NAME = "wbc_service";
                                                            Slog.i(TAG, "WipowerBatteryControl Service");
                                                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                            Slog.d(TAG, "Successfully loaded WbcService class");
                                                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                        }
                                                    }
                                                    if (disableNonCoreServices) {
                                                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                    }
                                                    safeMode = wm.detectSafeMode();
                                                    if (safeMode) {
                                                        VMRuntime.getRuntime().startJitCompilation();
                                                    } else {
                                                        this.mActivityManagerService.enterSafeMode();
                                                        VMRuntime.getRuntime().disableJitCompilation();
                                                    }
                                                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                    vibrator.systemReady();
                                                    if (lockSettings != null) {
                                                        lockSettings.systemReady();
                                                    }
                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                    wm.systemReady();
                                                    if (safeMode) {
                                                        this.mActivityManagerService.showSafeModeOverlay();
                                                    }
                                                    config = wm.computeNewConfiguration();
                                                    metrics = new DisplayMetrics();
                                                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                    context.getResources().updateConfiguration(config, metrics);
                                                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                    this.mPackageManagerService.systemReady();
                                                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                    audioServiceF = audioService2;
                                                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                                }
                                            } catch (Throwable th33) {
                                                e42222222222222222 = th33;
                                                reportWtf("starting Input Manager Service", e42222222222222222);
                                                Slog.i(TAG, "Accessibility Manager");
                                                ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
                                                wm.displayReady();
                                                Slog.i(TAG, "Mount Service");
                                                mountService = new MountService(context);
                                                ServiceManager.addService("mount", mountService);
                                                mountService2 = mountService;
                                                this.mPackageManagerService.performBootDexOpt();
                                                ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                                                if (this.mFactoryTestMode == 1) {
                                                    if (disableNonCoreServices) {
                                                        Slog.i(TAG, "LockSettingsService");
                                                        lockSettingsService = new LockSettingsService(context);
                                                        ServiceManager.addService("lock_settings", lockSettingsService);
                                                        lockSettings = lockSettingsService;
                                                        if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                                            this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                                                        }
                                                        this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                                                    }
                                                    if (disableSystemUI) {
                                                        Slog.i(TAG, "Status Bar");
                                                        statusBarManagerService = new StatusBarManagerService(context, wm);
                                                        ServiceManager.addService("statusbar", statusBarManagerService);
                                                        statusBar = statusBarManagerService;
                                                    }
                                                    if (disableNonCoreServices) {
                                                        Slog.i(TAG, "Clipboard Service");
                                                        ServiceManager.addService("clipboard", new ClipboardService(context));
                                                    }
                                                    if (disableNetwork) {
                                                        Slog.i(TAG, "NetworkManagement Service");
                                                        networkManagement = NetworkManagementService.create(context);
                                                        ServiceManager.addService("network_management", networkManagement);
                                                    }
                                                    if (disableNonCoreServices) {
                                                        Slog.i(TAG, "Text Service Manager Service");
                                                        textServicesManagerService = new TextServicesManagerService(context);
                                                        ServiceManager.addService("textservices", textServicesManagerService);
                                                        tsms = textServicesManagerService;
                                                    }
                                                    if (disableNetwork) {
                                                        networkPolicy = null;
                                                    } else {
                                                        Slog.i(TAG, "Network Score Service");
                                                        networkScoreService = new NetworkScoreService(context);
                                                        ServiceManager.addService("network_score", networkScoreService);
                                                        networkScore = networkScoreService;
                                                        Slog.i(TAG, "NetworkStats Service");
                                                        networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                        ServiceManager.addService("netstats", networkStatsService);
                                                        networkStats = networkStatsService;
                                                        Slog.i(TAG, "NetworkPolicy Service");
                                                        networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                        ServiceManager.addService("netpolicy", networkPolicy);
                                                        this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                        this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                        this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                        this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                        if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                            this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                        }
                                                        Slog.i(TAG, "Connectivity Service");
                                                        connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                        ServiceManager.addService("connectivity", connectivityService);
                                                        networkStats.bindConnectivityManager(connectivityService);
                                                        networkPolicy.bindConnectivityManager(connectivityService);
                                                        connectivity = connectivityService;
                                                        Slog.i(TAG, "Network Service Discovery Service");
                                                        ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                        Slog.i(TAG, "DPM Service");
                                                        startDpmService(context);
                                                    }
                                                    if (disableNonCoreServices) {
                                                        Slog.i(TAG, "UpdateLock Service");
                                                        ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                    }
                                                    mountService2.waitForAsecScan();
                                                    if (accountManagerService != null) {
                                                        accountManagerService.systemReady();
                                                    }
                                                    if (contentService != null) {
                                                        contentService.systemReady();
                                                    }
                                                    this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                    networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                    this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                    if (disableLocation) {
                                                        Slog.i(TAG, "Location Manager");
                                                        locationManagerService = new LocationManagerService(context);
                                                        ServiceManager.addService("location", locationManagerService);
                                                        location = locationManagerService;
                                                        Slog.i(TAG, "Country Detector");
                                                        countryDetectorService = new CountryDetectorService(context);
                                                        ServiceManager.addService("country_detector", countryDetectorService);
                                                        countryDetector = countryDetectorService;
                                                    }
                                                    if (disableNonCoreServices) {
                                                        Slog.i(TAG, "Search Service");
                                                        ServiceManager.addService("search", new SearchManagerService(context));
                                                    }
                                                    Slog.i(TAG, "DropBox Service");
                                                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                    Slog.i(TAG, "Wallpaper Service");
                                                    wallpaperManagerService = new WallpaperManagerService(context);
                                                    ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                    wallpaper = wallpaperManagerService;
                                                    Slog.i(TAG, "Audio Service");
                                                    audioService = new AudioService(context);
                                                    ServiceManager.addService("audio", audioService);
                                                    audioService2 = audioService;
                                                    if (disableNonCoreServices) {
                                                        this.mSystemServiceManager.startService(DockObserver.class);
                                                    }
                                                    if (disableMedia) {
                                                        Slog.i(TAG, "Wired Accessory Manager");
                                                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                    }
                                                    if (disableNonCoreServices) {
                                                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                        Slog.i(TAG, "Serial Service");
                                                        serialService = new SerialService(context);
                                                        ServiceManager.addService("serial", serialService);
                                                        serialService2 = serialService;
                                                    }
                                                    this.mSystemServiceManager.startService(TwilightService.class);
                                                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                    if (disableNonCoreServices) {
                                                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                        }
                                                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                        }
                                                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                        }
                                                    }
                                                    Slog.i(TAG, "DiskStats Service");
                                                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                    Slog.i(TAG, "SamplingProfiler Service");
                                                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                    Slog.i(TAG, "NetworkTimeUpdateService");
                                                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                    if (disableMedia) {
                                                        Slog.i(TAG, "CommonTimeManagementService");
                                                        commonTimeManagementService = new CommonTimeManagementService(context);
                                                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                        commonTimeMgmtService = commonTimeManagementService;
                                                    }
                                                    if (disableNetwork) {
                                                        Slog.i(TAG, "CertBlacklister");
                                                        certBlacklister = new CertBlacklister(context);
                                                    }
                                                    if (disableNonCoreServices) {
                                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                                    }
                                                    Slog.i(TAG, "Assets Atlas Service");
                                                    assetAtlasService = new AssetAtlasService(context);
                                                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                    atlas = assetAtlasService;
                                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                    }
                                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                                    }
                                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                    }
                                                    if (disableNonCoreServices) {
                                                        Slog.i(TAG, "Media Router Service");
                                                        mediaRouterService = new MediaRouterService(context);
                                                        ServiceManager.addService("media_router", mediaRouterService);
                                                        mediaRouter = mediaRouterService;
                                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                                        Slog.i(TAG, "BackgroundDexOptService");
                                                        BackgroundDexOptService.schedule(context);
                                                    }
                                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                        Slog.d(TAG, "Wipower not supported");
                                                    } else {
                                                        WBC_SERVICE_NAME = "wbc_service";
                                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                    }
                                                } else {
                                                    networkPolicy = null;
                                                }
                                                if (disableNonCoreServices) {
                                                    this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                                }
                                                safeMode = wm.detectSafeMode();
                                                if (safeMode) {
                                                    VMRuntime.getRuntime().startJitCompilation();
                                                } else {
                                                    this.mActivityManagerService.enterSafeMode();
                                                    VMRuntime.getRuntime().disableJitCompilation();
                                                }
                                                mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                                vibrator.systemReady();
                                                if (lockSettings != null) {
                                                    lockSettings.systemReady();
                                                }
                                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                                wm.systemReady();
                                                if (safeMode) {
                                                    this.mActivityManagerService.showSafeModeOverlay();
                                                }
                                                config = wm.computeNewConfiguration();
                                                metrics = new DisplayMetrics();
                                                ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                                context.getResources().updateConfiguration(config, metrics);
                                                this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                                this.mPackageManagerService.systemReady();
                                                this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                                audioServiceF = audioService2;
                                                this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                            }
                                            try {
                                                Slog.i(TAG, "Accessibility Manager");
                                                ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
                                            } catch (Throwable e422222222222222222) {
                                                reportWtf("starting Accessibility Manager", e422222222222222222);
                                            }
                                        }
                                        wm.displayReady();
                                        Slog.i(TAG, "Mount Service");
                                        mountService = new MountService(context);
                                        try {
                                            ServiceManager.addService("mount", mountService);
                                            mountService2 = mountService;
                                        } catch (Throwable th34) {
                                            e422222222222222222 = th34;
                                            mountService2 = mountService;
                                            reportWtf("starting Mount Service", e422222222222222222);
                                            this.mPackageManagerService.performBootDexOpt();
                                            ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                                            if (this.mFactoryTestMode == 1) {
                                                networkPolicy = null;
                                            } else {
                                                if (disableNonCoreServices) {
                                                    Slog.i(TAG, "LockSettingsService");
                                                    lockSettingsService = new LockSettingsService(context);
                                                    ServiceManager.addService("lock_settings", lockSettingsService);
                                                    lockSettings = lockSettingsService;
                                                    if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                                        this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                                                    }
                                                    this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                                                }
                                                if (disableSystemUI) {
                                                    Slog.i(TAG, "Status Bar");
                                                    statusBarManagerService = new StatusBarManagerService(context, wm);
                                                    ServiceManager.addService("statusbar", statusBarManagerService);
                                                    statusBar = statusBarManagerService;
                                                }
                                                if (disableNonCoreServices) {
                                                    Slog.i(TAG, "Clipboard Service");
                                                    ServiceManager.addService("clipboard", new ClipboardService(context));
                                                }
                                                if (disableNetwork) {
                                                    Slog.i(TAG, "NetworkManagement Service");
                                                    networkManagement = NetworkManagementService.create(context);
                                                    ServiceManager.addService("network_management", networkManagement);
                                                }
                                                if (disableNonCoreServices) {
                                                    Slog.i(TAG, "Text Service Manager Service");
                                                    textServicesManagerService = new TextServicesManagerService(context);
                                                    ServiceManager.addService("textservices", textServicesManagerService);
                                                    tsms = textServicesManagerService;
                                                }
                                                if (disableNetwork) {
                                                    Slog.i(TAG, "Network Score Service");
                                                    networkScoreService = new NetworkScoreService(context);
                                                    ServiceManager.addService("network_score", networkScoreService);
                                                    networkScore = networkScoreService;
                                                    Slog.i(TAG, "NetworkStats Service");
                                                    networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                    ServiceManager.addService("netstats", networkStatsService);
                                                    networkStats = networkStatsService;
                                                    Slog.i(TAG, "NetworkPolicy Service");
                                                    networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                    ServiceManager.addService("netpolicy", networkPolicy);
                                                    this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                    this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                    this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                    this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                    if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                        this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                    }
                                                    Slog.i(TAG, "Connectivity Service");
                                                    connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                    ServiceManager.addService("connectivity", connectivityService);
                                                    networkStats.bindConnectivityManager(connectivityService);
                                                    networkPolicy.bindConnectivityManager(connectivityService);
                                                    connectivity = connectivityService;
                                                    Slog.i(TAG, "Network Service Discovery Service");
                                                    ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                    Slog.i(TAG, "DPM Service");
                                                    startDpmService(context);
                                                } else {
                                                    networkPolicy = null;
                                                }
                                                if (disableNonCoreServices) {
                                                    Slog.i(TAG, "UpdateLock Service");
                                                    ServiceManager.addService("updatelock", new UpdateLockService(context));
                                                }
                                                mountService2.waitForAsecScan();
                                                if (accountManagerService != null) {
                                                    accountManagerService.systemReady();
                                                }
                                                if (contentService != null) {
                                                    contentService.systemReady();
                                                }
                                                this.mSystemServiceManager.startService(NotificationManagerService.class);
                                                networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                                this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                                if (disableLocation) {
                                                    Slog.i(TAG, "Location Manager");
                                                    locationManagerService = new LocationManagerService(context);
                                                    ServiceManager.addService("location", locationManagerService);
                                                    location = locationManagerService;
                                                    Slog.i(TAG, "Country Detector");
                                                    countryDetectorService = new CountryDetectorService(context);
                                                    ServiceManager.addService("country_detector", countryDetectorService);
                                                    countryDetector = countryDetectorService;
                                                }
                                                if (disableNonCoreServices) {
                                                    Slog.i(TAG, "Search Service");
                                                    ServiceManager.addService("search", new SearchManagerService(context));
                                                }
                                                Slog.i(TAG, "DropBox Service");
                                                ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                                Slog.i(TAG, "Wallpaper Service");
                                                wallpaperManagerService = new WallpaperManagerService(context);
                                                ServiceManager.addService("wallpaper", wallpaperManagerService);
                                                wallpaper = wallpaperManagerService;
                                                Slog.i(TAG, "Audio Service");
                                                audioService = new AudioService(context);
                                                ServiceManager.addService("audio", audioService);
                                                audioService2 = audioService;
                                                if (disableNonCoreServices) {
                                                    this.mSystemServiceManager.startService(DockObserver.class);
                                                }
                                                if (disableMedia) {
                                                    Slog.i(TAG, "Wired Accessory Manager");
                                                    inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                                }
                                                if (disableNonCoreServices) {
                                                    this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                    Slog.i(TAG, "Serial Service");
                                                    serialService = new SerialService(context);
                                                    ServiceManager.addService("serial", serialService);
                                                    serialService2 = serialService;
                                                }
                                                this.mSystemServiceManager.startService(TwilightService.class);
                                                this.mSystemServiceManager.startService(UiModeManagerService.class);
                                                this.mSystemServiceManager.startService(JobSchedulerService.class);
                                                if (disableNonCoreServices) {
                                                    if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                        this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                    }
                                                    if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                        this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                    }
                                                    if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                        this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                    }
                                                }
                                                Slog.i(TAG, "DiskStats Service");
                                                ServiceManager.addService("diskstats", new DiskStatsService(context));
                                                Slog.i(TAG, "SamplingProfiler Service");
                                                ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                                Slog.i(TAG, "NetworkTimeUpdateService");
                                                networkTimeUpdater = new NetworkTimeUpdateService(context);
                                                if (disableMedia) {
                                                    Slog.i(TAG, "CommonTimeManagementService");
                                                    commonTimeManagementService = new CommonTimeManagementService(context);
                                                    ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                    commonTimeMgmtService = commonTimeManagementService;
                                                }
                                                if (disableNetwork) {
                                                    Slog.i(TAG, "CertBlacklister");
                                                    certBlacklister = new CertBlacklister(context);
                                                }
                                                if (disableNonCoreServices) {
                                                    this.mSystemServiceManager.startService(DreamManagerService.class);
                                                }
                                                Slog.i(TAG, "Assets Atlas Service");
                                                assetAtlasService = new AssetAtlasService(context);
                                                ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                                atlas = assetAtlasService;
                                                if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                    this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                                }
                                                this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                                this.mSystemServiceManager.startService(MediaSessionService.class);
                                                if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                    this.mSystemServiceManager.startService(HdmiControlService.class);
                                                }
                                                if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                    this.mSystemServiceManager.startService(TvInputManagerService.class);
                                                }
                                                if (disableNonCoreServices) {
                                                    Slog.i(TAG, "Media Router Service");
                                                    mediaRouterService = new MediaRouterService(context);
                                                    ServiceManager.addService("media_router", mediaRouterService);
                                                    mediaRouter = mediaRouterService;
                                                    this.mSystemServiceManager.startService(TrustManagerService.class);
                                                    this.mSystemServiceManager.startService(FingerprintService.class);
                                                    Slog.i(TAG, "BackgroundDexOptService");
                                                    BackgroundDexOptService.schedule(context);
                                                }
                                                this.mSystemServiceManager.startService(LauncherAppsService.class);
                                                if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                    Slog.d(TAG, "Wipower not supported");
                                                } else {
                                                    WBC_SERVICE_NAME = "wbc_service";
                                                    Slog.i(TAG, "WipowerBatteryControl Service");
                                                    wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                    Slog.d(TAG, "Successfully loaded WbcService class");
                                                    ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                                }
                                            }
                                            if (disableNonCoreServices) {
                                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                            }
                                            safeMode = wm.detectSafeMode();
                                            if (safeMode) {
                                                VMRuntime.getRuntime().startJitCompilation();
                                            } else {
                                                this.mActivityManagerService.enterSafeMode();
                                                VMRuntime.getRuntime().disableJitCompilation();
                                            }
                                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                            vibrator.systemReady();
                                            if (lockSettings != null) {
                                                lockSettings.systemReady();
                                            }
                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                            wm.systemReady();
                                            if (safeMode) {
                                                this.mActivityManagerService.showSafeModeOverlay();
                                            }
                                            config = wm.computeNewConfiguration();
                                            metrics = new DisplayMetrics();
                                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                            context.getResources().updateConfiguration(config, metrics);
                                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                            this.mPackageManagerService.systemReady();
                                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                            audioServiceF = audioService2;
                                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                        }
                                        this.mPackageManagerService.performBootDexOpt();
                                        ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                                        if (this.mFactoryTestMode == 1) {
                                            networkPolicy = null;
                                        } else {
                                            if (disableNonCoreServices) {
                                                Slog.i(TAG, "LockSettingsService");
                                                lockSettingsService = new LockSettingsService(context);
                                                ServiceManager.addService("lock_settings", lockSettingsService);
                                                lockSettings = lockSettingsService;
                                                if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                                    this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                                                }
                                                this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                                            }
                                            if (disableSystemUI) {
                                                Slog.i(TAG, "Status Bar");
                                                statusBarManagerService = new StatusBarManagerService(context, wm);
                                                ServiceManager.addService("statusbar", statusBarManagerService);
                                                statusBar = statusBarManagerService;
                                            }
                                            if (disableNonCoreServices) {
                                                Slog.i(TAG, "Clipboard Service");
                                                ServiceManager.addService("clipboard", new ClipboardService(context));
                                            }
                                            if (disableNetwork) {
                                                Slog.i(TAG, "NetworkManagement Service");
                                                networkManagement = NetworkManagementService.create(context);
                                                ServiceManager.addService("network_management", networkManagement);
                                            }
                                            if (disableNonCoreServices) {
                                                Slog.i(TAG, "Text Service Manager Service");
                                                textServicesManagerService = new TextServicesManagerService(context);
                                                ServiceManager.addService("textservices", textServicesManagerService);
                                                tsms = textServicesManagerService;
                                            }
                                            if (disableNetwork) {
                                                Slog.i(TAG, "Network Score Service");
                                                networkScoreService = new NetworkScoreService(context);
                                                ServiceManager.addService("network_score", networkScoreService);
                                                networkScore = networkScoreService;
                                                Slog.i(TAG, "NetworkStats Service");
                                                networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                                ServiceManager.addService("netstats", networkStatsService);
                                                networkStats = networkStatsService;
                                                Slog.i(TAG, "NetworkPolicy Service");
                                                networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                                ServiceManager.addService("netpolicy", networkPolicy);
                                                this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                                this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                                this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                                this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                                if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                                    this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                                }
                                                Slog.i(TAG, "Connectivity Service");
                                                connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                                ServiceManager.addService("connectivity", connectivityService);
                                                networkStats.bindConnectivityManager(connectivityService);
                                                networkPolicy.bindConnectivityManager(connectivityService);
                                                connectivity = connectivityService;
                                                Slog.i(TAG, "Network Service Discovery Service");
                                                ServiceManager.addService("servicediscovery", NsdService.create(context));
                                                Slog.i(TAG, "DPM Service");
                                                startDpmService(context);
                                            } else {
                                                networkPolicy = null;
                                            }
                                            if (disableNonCoreServices) {
                                                Slog.i(TAG, "UpdateLock Service");
                                                ServiceManager.addService("updatelock", new UpdateLockService(context));
                                            }
                                            mountService2.waitForAsecScan();
                                            if (accountManagerService != null) {
                                                accountManagerService.systemReady();
                                            }
                                            if (contentService != null) {
                                                contentService.systemReady();
                                            }
                                            this.mSystemServiceManager.startService(NotificationManagerService.class);
                                            networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                            this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                            if (disableLocation) {
                                                Slog.i(TAG, "Location Manager");
                                                locationManagerService = new LocationManagerService(context);
                                                ServiceManager.addService("location", locationManagerService);
                                                location = locationManagerService;
                                                Slog.i(TAG, "Country Detector");
                                                countryDetectorService = new CountryDetectorService(context);
                                                ServiceManager.addService("country_detector", countryDetectorService);
                                                countryDetector = countryDetectorService;
                                            }
                                            if (disableNonCoreServices) {
                                                Slog.i(TAG, "Search Service");
                                                ServiceManager.addService("search", new SearchManagerService(context));
                                            }
                                            Slog.i(TAG, "DropBox Service");
                                            ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                            Slog.i(TAG, "Wallpaper Service");
                                            wallpaperManagerService = new WallpaperManagerService(context);
                                            ServiceManager.addService("wallpaper", wallpaperManagerService);
                                            wallpaper = wallpaperManagerService;
                                            Slog.i(TAG, "Audio Service");
                                            audioService = new AudioService(context);
                                            ServiceManager.addService("audio", audioService);
                                            audioService2 = audioService;
                                            if (disableNonCoreServices) {
                                                this.mSystemServiceManager.startService(DockObserver.class);
                                            }
                                            if (disableMedia) {
                                                Slog.i(TAG, "Wired Accessory Manager");
                                                inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                            }
                                            if (disableNonCoreServices) {
                                                this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                                Slog.i(TAG, "Serial Service");
                                                serialService = new SerialService(context);
                                                ServiceManager.addService("serial", serialService);
                                                serialService2 = serialService;
                                            }
                                            this.mSystemServiceManager.startService(TwilightService.class);
                                            this.mSystemServiceManager.startService(UiModeManagerService.class);
                                            this.mSystemServiceManager.startService(JobSchedulerService.class);
                                            if (disableNonCoreServices) {
                                                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                                }
                                                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                                }
                                                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                                }
                                            }
                                            Slog.i(TAG, "DiskStats Service");
                                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                                            Slog.i(TAG, "SamplingProfiler Service");
                                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                            Slog.i(TAG, "NetworkTimeUpdateService");
                                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                                            if (disableMedia) {
                                                Slog.i(TAG, "CommonTimeManagementService");
                                                commonTimeManagementService = new CommonTimeManagementService(context);
                                                ServiceManager.addService("commontime_management", commonTimeManagementService);
                                                commonTimeMgmtService = commonTimeManagementService;
                                            }
                                            if (disableNetwork) {
                                                Slog.i(TAG, "CertBlacklister");
                                                certBlacklister = new CertBlacklister(context);
                                            }
                                            if (disableNonCoreServices) {
                                                this.mSystemServiceManager.startService(DreamManagerService.class);
                                            }
                                            Slog.i(TAG, "Assets Atlas Service");
                                            assetAtlasService = new AssetAtlasService(context);
                                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                            atlas = assetAtlasService;
                                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                            }
                                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                            this.mSystemServiceManager.startService(MediaSessionService.class);
                                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                                this.mSystemServiceManager.startService(HdmiControlService.class);
                                            }
                                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                                            }
                                            if (disableNonCoreServices) {
                                                Slog.i(TAG, "Media Router Service");
                                                mediaRouterService = new MediaRouterService(context);
                                                ServiceManager.addService("media_router", mediaRouterService);
                                                mediaRouter = mediaRouterService;
                                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                                this.mSystemServiceManager.startService(FingerprintService.class);
                                                Slog.i(TAG, "BackgroundDexOptService");
                                                BackgroundDexOptService.schedule(context);
                                            }
                                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                                WBC_SERVICE_NAME = "wbc_service";
                                                Slog.i(TAG, "WipowerBatteryControl Service");
                                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                                Slog.d(TAG, "Successfully loaded WbcService class");
                                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                            } else {
                                                Slog.d(TAG, "Wipower not supported");
                                            }
                                        }
                                        if (disableNonCoreServices) {
                                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                        }
                                        safeMode = wm.detectSafeMode();
                                        if (safeMode) {
                                            this.mActivityManagerService.enterSafeMode();
                                            VMRuntime.getRuntime().disableJitCompilation();
                                        } else {
                                            VMRuntime.getRuntime().startJitCompilation();
                                        }
                                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                        vibrator.systemReady();
                                        if (lockSettings != null) {
                                            lockSettings.systemReady();
                                        }
                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                        wm.systemReady();
                                        if (safeMode) {
                                            this.mActivityManagerService.showSafeModeOverlay();
                                        }
                                        config = wm.computeNewConfiguration();
                                        metrics = new DisplayMetrics();
                                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                        context.getResources().updateConfiguration(config, metrics);
                                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                        this.mPackageManagerService.systemReady();
                                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                        audioServiceF = audioService2;
                                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                                    }
                                }
                                consumerIrService2 = consumerIrService;
                                telephonyRegistry = telephonyRegistry2;
                                inputManager = inputManagerService;
                                vibrator = vibratorService;
                            } catch (RuntimeException e5) {
                                e422222222222222222 = e5;
                                consumerIrService2 = consumerIrService;
                                telephonyRegistry = telephonyRegistry2;
                                inputManager = inputManagerService;
                                vibrator = vibratorService;
                                Slog.e("System", "******************************************");
                                Slog.e("System", "************ Failure starting core service", e422222222222222222);
                                statusBar = null;
                                imm = null;
                                wallpaper = null;
                                location = null;
                                countryDetector = null;
                                tsms = null;
                                lockSettings = null;
                                atlas = null;
                                mediaRouter = null;
                                if (this.mFactoryTestMode != 1) {
                                    Slog.i(TAG, "Input Method Service");
                                    inputMethodManagerService = new InputMethodManagerService(context, wm);
                                    ServiceManager.addService("input_method", inputMethodManagerService);
                                    imm = inputMethodManagerService;
                                    Slog.i(TAG, "Accessibility Manager");
                                    ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
                                }
                                wm.displayReady();
                                Slog.i(TAG, "Mount Service");
                                mountService = new MountService(context);
                                ServiceManager.addService("mount", mountService);
                                mountService2 = mountService;
                                this.mPackageManagerService.performBootDexOpt();
                                ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                                if (this.mFactoryTestMode == 1) {
                                    if (disableNonCoreServices) {
                                        Slog.i(TAG, "LockSettingsService");
                                        lockSettingsService = new LockSettingsService(context);
                                        ServiceManager.addService("lock_settings", lockSettingsService);
                                        lockSettings = lockSettingsService;
                                        if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                            this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                                        }
                                        this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                                    }
                                    if (disableSystemUI) {
                                        Slog.i(TAG, "Status Bar");
                                        statusBarManagerService = new StatusBarManagerService(context, wm);
                                        ServiceManager.addService("statusbar", statusBarManagerService);
                                        statusBar = statusBarManagerService;
                                    }
                                    if (disableNonCoreServices) {
                                        Slog.i(TAG, "Clipboard Service");
                                        ServiceManager.addService("clipboard", new ClipboardService(context));
                                    }
                                    if (disableNetwork) {
                                        Slog.i(TAG, "NetworkManagement Service");
                                        networkManagement = NetworkManagementService.create(context);
                                        ServiceManager.addService("network_management", networkManagement);
                                    }
                                    if (disableNonCoreServices) {
                                        Slog.i(TAG, "Text Service Manager Service");
                                        textServicesManagerService = new TextServicesManagerService(context);
                                        ServiceManager.addService("textservices", textServicesManagerService);
                                        tsms = textServicesManagerService;
                                    }
                                    if (disableNetwork) {
                                        networkPolicy = null;
                                    } else {
                                        Slog.i(TAG, "Network Score Service");
                                        networkScoreService = new NetworkScoreService(context);
                                        ServiceManager.addService("network_score", networkScoreService);
                                        networkScore = networkScoreService;
                                        Slog.i(TAG, "NetworkStats Service");
                                        networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                        ServiceManager.addService("netstats", networkStatsService);
                                        networkStats = networkStatsService;
                                        Slog.i(TAG, "NetworkPolicy Service");
                                        networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                        ServiceManager.addService("netpolicy", networkPolicy);
                                        this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                        this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                        this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                        this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                        if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                            this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                        }
                                        Slog.i(TAG, "Connectivity Service");
                                        connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                        ServiceManager.addService("connectivity", connectivityService);
                                        networkStats.bindConnectivityManager(connectivityService);
                                        networkPolicy.bindConnectivityManager(connectivityService);
                                        connectivity = connectivityService;
                                        Slog.i(TAG, "Network Service Discovery Service");
                                        ServiceManager.addService("servicediscovery", NsdService.create(context));
                                        Slog.i(TAG, "DPM Service");
                                        startDpmService(context);
                                    }
                                    if (disableNonCoreServices) {
                                        Slog.i(TAG, "UpdateLock Service");
                                        ServiceManager.addService("updatelock", new UpdateLockService(context));
                                    }
                                    mountService2.waitForAsecScan();
                                    if (accountManagerService != null) {
                                        accountManagerService.systemReady();
                                    }
                                    if (contentService != null) {
                                        contentService.systemReady();
                                    }
                                    this.mSystemServiceManager.startService(NotificationManagerService.class);
                                    networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                    this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                    if (disableLocation) {
                                        Slog.i(TAG, "Location Manager");
                                        locationManagerService = new LocationManagerService(context);
                                        ServiceManager.addService("location", locationManagerService);
                                        location = locationManagerService;
                                        Slog.i(TAG, "Country Detector");
                                        countryDetectorService = new CountryDetectorService(context);
                                        ServiceManager.addService("country_detector", countryDetectorService);
                                        countryDetector = countryDetectorService;
                                    }
                                    if (disableNonCoreServices) {
                                        Slog.i(TAG, "Search Service");
                                        ServiceManager.addService("search", new SearchManagerService(context));
                                    }
                                    Slog.i(TAG, "DropBox Service");
                                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                    Slog.i(TAG, "Wallpaper Service");
                                    wallpaperManagerService = new WallpaperManagerService(context);
                                    ServiceManager.addService("wallpaper", wallpaperManagerService);
                                    wallpaper = wallpaperManagerService;
                                    Slog.i(TAG, "Audio Service");
                                    audioService = new AudioService(context);
                                    ServiceManager.addService("audio", audioService);
                                    audioService2 = audioService;
                                    if (disableNonCoreServices) {
                                        this.mSystemServiceManager.startService(DockObserver.class);
                                    }
                                    if (disableMedia) {
                                        Slog.i(TAG, "Wired Accessory Manager");
                                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                    }
                                    if (disableNonCoreServices) {
                                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                        Slog.i(TAG, "Serial Service");
                                        serialService = new SerialService(context);
                                        ServiceManager.addService("serial", serialService);
                                        serialService2 = serialService;
                                    }
                                    this.mSystemServiceManager.startService(TwilightService.class);
                                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                                    if (disableNonCoreServices) {
                                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                        }
                                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                        }
                                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                        }
                                    }
                                    Slog.i(TAG, "DiskStats Service");
                                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                                    Slog.i(TAG, "SamplingProfiler Service");
                                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                    Slog.i(TAG, "NetworkTimeUpdateService");
                                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                                    if (disableMedia) {
                                        Slog.i(TAG, "CommonTimeManagementService");
                                        commonTimeManagementService = new CommonTimeManagementService(context);
                                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                                        commonTimeMgmtService = commonTimeManagementService;
                                    }
                                    if (disableNetwork) {
                                        Slog.i(TAG, "CertBlacklister");
                                        certBlacklister = new CertBlacklister(context);
                                    }
                                    if (disableNonCoreServices) {
                                        this.mSystemServiceManager.startService(DreamManagerService.class);
                                    }
                                    Slog.i(TAG, "Assets Atlas Service");
                                    assetAtlasService = new AssetAtlasService(context);
                                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                    atlas = assetAtlasService;
                                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                    }
                                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                    this.mSystemServiceManager.startService(MediaSessionService.class);
                                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                        this.mSystemServiceManager.startService(HdmiControlService.class);
                                    }
                                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                                    }
                                    if (disableNonCoreServices) {
                                        Slog.i(TAG, "Media Router Service");
                                        mediaRouterService = new MediaRouterService(context);
                                        ServiceManager.addService("media_router", mediaRouterService);
                                        mediaRouter = mediaRouterService;
                                        this.mSystemServiceManager.startService(TrustManagerService.class);
                                        this.mSystemServiceManager.startService(FingerprintService.class);
                                        Slog.i(TAG, "BackgroundDexOptService");
                                        BackgroundDexOptService.schedule(context);
                                    }
                                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                        WBC_SERVICE_NAME = "wbc_service";
                                        Slog.i(TAG, "WipowerBatteryControl Service");
                                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                        Slog.d(TAG, "Successfully loaded WbcService class");
                                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                    } else {
                                        Slog.d(TAG, "Wipower not supported");
                                    }
                                } else {
                                    networkPolicy = null;
                                }
                                if (disableNonCoreServices) {
                                    this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                                }
                                safeMode = wm.detectSafeMode();
                                if (safeMode) {
                                    this.mActivityManagerService.enterSafeMode();
                                    VMRuntime.getRuntime().disableJitCompilation();
                                } else {
                                    VMRuntime.getRuntime().startJitCompilation();
                                }
                                mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                                vibrator.systemReady();
                                if (lockSettings != null) {
                                    lockSettings.systemReady();
                                }
                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                                wm.systemReady();
                                if (safeMode) {
                                    this.mActivityManagerService.showSafeModeOverlay();
                                }
                                config = wm.computeNewConfiguration();
                                metrics = new DisplayMetrics();
                                ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                                context.getResources().updateConfiguration(config, metrics);
                                this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                                this.mPackageManagerService.systemReady();
                                this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                                audioServiceF = audioService2;
                                this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                            }
                        } catch (RuntimeException e6) {
                            e422222222222222222 = e6;
                            consumerIrService2 = consumerIrService;
                            telephonyRegistry = telephonyRegistry2;
                            vibrator = vibratorService;
                            Slog.e("System", "******************************************");
                            Slog.e("System", "************ Failure starting core service", e422222222222222222);
                            statusBar = null;
                            imm = null;
                            wallpaper = null;
                            location = null;
                            countryDetector = null;
                            tsms = null;
                            lockSettings = null;
                            atlas = null;
                            mediaRouter = null;
                            if (this.mFactoryTestMode != 1) {
                                Slog.i(TAG, "Input Method Service");
                                inputMethodManagerService = new InputMethodManagerService(context, wm);
                                ServiceManager.addService("input_method", inputMethodManagerService);
                                imm = inputMethodManagerService;
                                Slog.i(TAG, "Accessibility Manager");
                                ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
                            }
                            wm.displayReady();
                            Slog.i(TAG, "Mount Service");
                            mountService = new MountService(context);
                            ServiceManager.addService("mount", mountService);
                            mountService2 = mountService;
                            this.mPackageManagerService.performBootDexOpt();
                            ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                            if (this.mFactoryTestMode == 1) {
                                networkPolicy = null;
                            } else {
                                if (disableNonCoreServices) {
                                    Slog.i(TAG, "LockSettingsService");
                                    lockSettingsService = new LockSettingsService(context);
                                    ServiceManager.addService("lock_settings", lockSettingsService);
                                    lockSettings = lockSettingsService;
                                    if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                        this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                                    }
                                    this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                                }
                                if (disableSystemUI) {
                                    Slog.i(TAG, "Status Bar");
                                    statusBarManagerService = new StatusBarManagerService(context, wm);
                                    ServiceManager.addService("statusbar", statusBarManagerService);
                                    statusBar = statusBarManagerService;
                                }
                                if (disableNonCoreServices) {
                                    Slog.i(TAG, "Clipboard Service");
                                    ServiceManager.addService("clipboard", new ClipboardService(context));
                                }
                                if (disableNetwork) {
                                    Slog.i(TAG, "NetworkManagement Service");
                                    networkManagement = NetworkManagementService.create(context);
                                    ServiceManager.addService("network_management", networkManagement);
                                }
                                if (disableNonCoreServices) {
                                    Slog.i(TAG, "Text Service Manager Service");
                                    textServicesManagerService = new TextServicesManagerService(context);
                                    ServiceManager.addService("textservices", textServicesManagerService);
                                    tsms = textServicesManagerService;
                                }
                                if (disableNetwork) {
                                    Slog.i(TAG, "Network Score Service");
                                    networkScoreService = new NetworkScoreService(context);
                                    ServiceManager.addService("network_score", networkScoreService);
                                    networkScore = networkScoreService;
                                    Slog.i(TAG, "NetworkStats Service");
                                    networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                    ServiceManager.addService("netstats", networkStatsService);
                                    networkStats = networkStatsService;
                                    Slog.i(TAG, "NetworkPolicy Service");
                                    networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                    ServiceManager.addService("netpolicy", networkPolicy);
                                    this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                    this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                    this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                    this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                    if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                        this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                    }
                                    Slog.i(TAG, "Connectivity Service");
                                    connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                    ServiceManager.addService("connectivity", connectivityService);
                                    networkStats.bindConnectivityManager(connectivityService);
                                    networkPolicy.bindConnectivityManager(connectivityService);
                                    connectivity = connectivityService;
                                    Slog.i(TAG, "Network Service Discovery Service");
                                    ServiceManager.addService("servicediscovery", NsdService.create(context));
                                    Slog.i(TAG, "DPM Service");
                                    startDpmService(context);
                                } else {
                                    networkPolicy = null;
                                }
                                if (disableNonCoreServices) {
                                    Slog.i(TAG, "UpdateLock Service");
                                    ServiceManager.addService("updatelock", new UpdateLockService(context));
                                }
                                mountService2.waitForAsecScan();
                                if (accountManagerService != null) {
                                    accountManagerService.systemReady();
                                }
                                if (contentService != null) {
                                    contentService.systemReady();
                                }
                                this.mSystemServiceManager.startService(NotificationManagerService.class);
                                networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                                this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                                if (disableLocation) {
                                    Slog.i(TAG, "Location Manager");
                                    locationManagerService = new LocationManagerService(context);
                                    ServiceManager.addService("location", locationManagerService);
                                    location = locationManagerService;
                                    Slog.i(TAG, "Country Detector");
                                    countryDetectorService = new CountryDetectorService(context);
                                    ServiceManager.addService("country_detector", countryDetectorService);
                                    countryDetector = countryDetectorService;
                                }
                                if (disableNonCoreServices) {
                                    Slog.i(TAG, "Search Service");
                                    ServiceManager.addService("search", new SearchManagerService(context));
                                }
                                Slog.i(TAG, "DropBox Service");
                                ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                                Slog.i(TAG, "Wallpaper Service");
                                wallpaperManagerService = new WallpaperManagerService(context);
                                ServiceManager.addService("wallpaper", wallpaperManagerService);
                                wallpaper = wallpaperManagerService;
                                Slog.i(TAG, "Audio Service");
                                audioService = new AudioService(context);
                                ServiceManager.addService("audio", audioService);
                                audioService2 = audioService;
                                if (disableNonCoreServices) {
                                    this.mSystemServiceManager.startService(DockObserver.class);
                                }
                                if (disableMedia) {
                                    Slog.i(TAG, "Wired Accessory Manager");
                                    inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                                }
                                if (disableNonCoreServices) {
                                    this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                    Slog.i(TAG, "Serial Service");
                                    serialService = new SerialService(context);
                                    ServiceManager.addService("serial", serialService);
                                    serialService2 = serialService;
                                }
                                this.mSystemServiceManager.startService(TwilightService.class);
                                this.mSystemServiceManager.startService(UiModeManagerService.class);
                                this.mSystemServiceManager.startService(JobSchedulerService.class);
                                if (disableNonCoreServices) {
                                    if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                        this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                    }
                                    if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                        this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                    }
                                    if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                        this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                    }
                                }
                                Slog.i(TAG, "DiskStats Service");
                                ServiceManager.addService("diskstats", new DiskStatsService(context));
                                Slog.i(TAG, "SamplingProfiler Service");
                                ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                                Slog.i(TAG, "NetworkTimeUpdateService");
                                networkTimeUpdater = new NetworkTimeUpdateService(context);
                                if (disableMedia) {
                                    Slog.i(TAG, "CommonTimeManagementService");
                                    commonTimeManagementService = new CommonTimeManagementService(context);
                                    ServiceManager.addService("commontime_management", commonTimeManagementService);
                                    commonTimeMgmtService = commonTimeManagementService;
                                }
                                if (disableNetwork) {
                                    Slog.i(TAG, "CertBlacklister");
                                    certBlacklister = new CertBlacklister(context);
                                }
                                if (disableNonCoreServices) {
                                    this.mSystemServiceManager.startService(DreamManagerService.class);
                                }
                                Slog.i(TAG, "Assets Atlas Service");
                                assetAtlasService = new AssetAtlasService(context);
                                ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                                atlas = assetAtlasService;
                                if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                    this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                                }
                                this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                                this.mSystemServiceManager.startService(MediaSessionService.class);
                                if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                    this.mSystemServiceManager.startService(HdmiControlService.class);
                                }
                                if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                    this.mSystemServiceManager.startService(TvInputManagerService.class);
                                }
                                if (disableNonCoreServices) {
                                    Slog.i(TAG, "Media Router Service");
                                    mediaRouterService = new MediaRouterService(context);
                                    ServiceManager.addService("media_router", mediaRouterService);
                                    mediaRouter = mediaRouterService;
                                    this.mSystemServiceManager.startService(TrustManagerService.class);
                                    this.mSystemServiceManager.startService(FingerprintService.class);
                                    Slog.i(TAG, "BackgroundDexOptService");
                                    BackgroundDexOptService.schedule(context);
                                }
                                this.mSystemServiceManager.startService(LauncherAppsService.class);
                                if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                    Slog.d(TAG, "Wipower not supported");
                                } else {
                                    WBC_SERVICE_NAME = "wbc_service";
                                    Slog.i(TAG, "WipowerBatteryControl Service");
                                    wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                    Slog.d(TAG, "Successfully loaded WbcService class");
                                    ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                                }
                            }
                            if (disableNonCoreServices) {
                                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                            }
                            safeMode = wm.detectSafeMode();
                            if (safeMode) {
                                VMRuntime.getRuntime().startJitCompilation();
                            } else {
                                this.mActivityManagerService.enterSafeMode();
                                VMRuntime.getRuntime().disableJitCompilation();
                            }
                            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                            vibrator.systemReady();
                            if (lockSettings != null) {
                                lockSettings.systemReady();
                            }
                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                            wm.systemReady();
                            if (safeMode) {
                                this.mActivityManagerService.showSafeModeOverlay();
                            }
                            config = wm.computeNewConfiguration();
                            metrics = new DisplayMetrics();
                            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                            context.getResources().updateConfiguration(config, metrics);
                            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                            this.mPackageManagerService.systemReady();
                            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                            audioServiceF = audioService2;
                            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                        }
                    } catch (RuntimeException e7) {
                        e422222222222222222 = e7;
                        telephonyRegistry = telephonyRegistry2;
                        Slog.e("System", "******************************************");
                        Slog.e("System", "************ Failure starting core service", e422222222222222222);
                        statusBar = null;
                        imm = null;
                        wallpaper = null;
                        location = null;
                        countryDetector = null;
                        tsms = null;
                        lockSettings = null;
                        atlas = null;
                        mediaRouter = null;
                        if (this.mFactoryTestMode != 1) {
                            Slog.i(TAG, "Input Method Service");
                            inputMethodManagerService = new InputMethodManagerService(context, wm);
                            ServiceManager.addService("input_method", inputMethodManagerService);
                            imm = inputMethodManagerService;
                            Slog.i(TAG, "Accessibility Manager");
                            ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
                        }
                        wm.displayReady();
                        Slog.i(TAG, "Mount Service");
                        mountService = new MountService(context);
                        ServiceManager.addService("mount", mountService);
                        mountService2 = mountService;
                        this.mPackageManagerService.performBootDexOpt();
                        ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                        if (this.mFactoryTestMode == 1) {
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "LockSettingsService");
                                lockSettingsService = new LockSettingsService(context);
                                ServiceManager.addService("lock_settings", lockSettingsService);
                                lockSettings = lockSettingsService;
                                if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                    this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                                }
                                this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                            }
                            if (disableSystemUI) {
                                Slog.i(TAG, "Status Bar");
                                statusBarManagerService = new StatusBarManagerService(context, wm);
                                ServiceManager.addService("statusbar", statusBarManagerService);
                                statusBar = statusBarManagerService;
                            }
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "Clipboard Service");
                                ServiceManager.addService("clipboard", new ClipboardService(context));
                            }
                            if (disableNetwork) {
                                Slog.i(TAG, "NetworkManagement Service");
                                networkManagement = NetworkManagementService.create(context);
                                ServiceManager.addService("network_management", networkManagement);
                            }
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "Text Service Manager Service");
                                textServicesManagerService = new TextServicesManagerService(context);
                                ServiceManager.addService("textservices", textServicesManagerService);
                                tsms = textServicesManagerService;
                            }
                            if (disableNetwork) {
                                networkPolicy = null;
                            } else {
                                Slog.i(TAG, "Network Score Service");
                                networkScoreService = new NetworkScoreService(context);
                                ServiceManager.addService("network_score", networkScoreService);
                                networkScore = networkScoreService;
                                Slog.i(TAG, "NetworkStats Service");
                                networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                ServiceManager.addService("netstats", networkStatsService);
                                networkStats = networkStatsService;
                                Slog.i(TAG, "NetworkPolicy Service");
                                networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                ServiceManager.addService("netpolicy", networkPolicy);
                                this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                    this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                }
                                Slog.i(TAG, "Connectivity Service");
                                connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                ServiceManager.addService("connectivity", connectivityService);
                                networkStats.bindConnectivityManager(connectivityService);
                                networkPolicy.bindConnectivityManager(connectivityService);
                                connectivity = connectivityService;
                                Slog.i(TAG, "Network Service Discovery Service");
                                ServiceManager.addService("servicediscovery", NsdService.create(context));
                                Slog.i(TAG, "DPM Service");
                                startDpmService(context);
                            }
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "UpdateLock Service");
                                ServiceManager.addService("updatelock", new UpdateLockService(context));
                            }
                            mountService2.waitForAsecScan();
                            if (accountManagerService != null) {
                                accountManagerService.systemReady();
                            }
                            if (contentService != null) {
                                contentService.systemReady();
                            }
                            this.mSystemServiceManager.startService(NotificationManagerService.class);
                            networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                            this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                            if (disableLocation) {
                                Slog.i(TAG, "Location Manager");
                                locationManagerService = new LocationManagerService(context);
                                ServiceManager.addService("location", locationManagerService);
                                location = locationManagerService;
                                Slog.i(TAG, "Country Detector");
                                countryDetectorService = new CountryDetectorService(context);
                                ServiceManager.addService("country_detector", countryDetectorService);
                                countryDetector = countryDetectorService;
                            }
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "Search Service");
                                ServiceManager.addService("search", new SearchManagerService(context));
                            }
                            Slog.i(TAG, "DropBox Service");
                            ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                            Slog.i(TAG, "Wallpaper Service");
                            wallpaperManagerService = new WallpaperManagerService(context);
                            ServiceManager.addService("wallpaper", wallpaperManagerService);
                            wallpaper = wallpaperManagerService;
                            Slog.i(TAG, "Audio Service");
                            audioService = new AudioService(context);
                            ServiceManager.addService("audio", audioService);
                            audioService2 = audioService;
                            if (disableNonCoreServices) {
                                this.mSystemServiceManager.startService(DockObserver.class);
                            }
                            if (disableMedia) {
                                Slog.i(TAG, "Wired Accessory Manager");
                                inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                            }
                            if (disableNonCoreServices) {
                                this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                Slog.i(TAG, "Serial Service");
                                serialService = new SerialService(context);
                                ServiceManager.addService("serial", serialService);
                                serialService2 = serialService;
                            }
                            this.mSystemServiceManager.startService(TwilightService.class);
                            this.mSystemServiceManager.startService(UiModeManagerService.class);
                            this.mSystemServiceManager.startService(JobSchedulerService.class);
                            if (disableNonCoreServices) {
                                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                }
                                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                }
                                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                }
                            }
                            Slog.i(TAG, "DiskStats Service");
                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                            Slog.i(TAG, "SamplingProfiler Service");
                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                            Slog.i(TAG, "NetworkTimeUpdateService");
                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                            if (disableMedia) {
                                Slog.i(TAG, "CommonTimeManagementService");
                                commonTimeManagementService = new CommonTimeManagementService(context);
                                ServiceManager.addService("commontime_management", commonTimeManagementService);
                                commonTimeMgmtService = commonTimeManagementService;
                            }
                            if (disableNetwork) {
                                Slog.i(TAG, "CertBlacklister");
                                certBlacklister = new CertBlacklister(context);
                            }
                            if (disableNonCoreServices) {
                                this.mSystemServiceManager.startService(DreamManagerService.class);
                            }
                            Slog.i(TAG, "Assets Atlas Service");
                            assetAtlasService = new AssetAtlasService(context);
                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                            atlas = assetAtlasService;
                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                            }
                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                            this.mSystemServiceManager.startService(MediaSessionService.class);
                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                this.mSystemServiceManager.startService(HdmiControlService.class);
                            }
                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                            }
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "Media Router Service");
                                mediaRouterService = new MediaRouterService(context);
                                ServiceManager.addService("media_router", mediaRouterService);
                                mediaRouter = mediaRouterService;
                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                this.mSystemServiceManager.startService(FingerprintService.class);
                                Slog.i(TAG, "BackgroundDexOptService");
                                BackgroundDexOptService.schedule(context);
                            }
                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                WBC_SERVICE_NAME = "wbc_service";
                                Slog.i(TAG, "WipowerBatteryControl Service");
                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                Slog.d(TAG, "Successfully loaded WbcService class");
                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                            } else {
                                Slog.d(TAG, "Wipower not supported");
                            }
                        } else {
                            networkPolicy = null;
                        }
                        if (disableNonCoreServices) {
                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                        }
                        safeMode = wm.detectSafeMode();
                        if (safeMode) {
                            this.mActivityManagerService.enterSafeMode();
                            VMRuntime.getRuntime().disableJitCompilation();
                        } else {
                            VMRuntime.getRuntime().startJitCompilation();
                        }
                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                        vibrator.systemReady();
                        if (lockSettings != null) {
                            lockSettings.systemReady();
                        }
                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                        wm.systemReady();
                        if (safeMode) {
                            this.mActivityManagerService.showSafeModeOverlay();
                        }
                        config = wm.computeNewConfiguration();
                        metrics = new DisplayMetrics();
                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                        context.getResources().updateConfiguration(config, metrics);
                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                        this.mPackageManagerService.systemReady();
                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                        audioServiceF = audioService2;
                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                    }
                    statusBar = null;
                    imm = null;
                    wallpaper = null;
                    location = null;
                    countryDetector = null;
                    tsms = null;
                    lockSettings = null;
                    atlas = null;
                    mediaRouter = null;
                    if (this.mFactoryTestMode != 1) {
                        Slog.i(TAG, "Input Method Service");
                        inputMethodManagerService = new InputMethodManagerService(context, wm);
                        ServiceManager.addService("input_method", inputMethodManagerService);
                        imm = inputMethodManagerService;
                        Slog.i(TAG, "Accessibility Manager");
                        ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
                    }
                    wm.displayReady();
                    try {
                        Slog.i(TAG, "Mount Service");
                        mountService = new MountService(context);
                        ServiceManager.addService("mount", mountService);
                        mountService2 = mountService;
                    } catch (Throwable th35) {
                        e422222222222222222 = th35;
                        reportWtf("starting Mount Service", e422222222222222222);
                        this.mPackageManagerService.performBootDexOpt();
                        ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                        if (this.mFactoryTestMode == 1) {
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "LockSettingsService");
                                lockSettingsService = new LockSettingsService(context);
                                ServiceManager.addService("lock_settings", lockSettingsService);
                                lockSettings = lockSettingsService;
                                if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                    this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                                }
                                this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                            }
                            if (disableSystemUI) {
                                Slog.i(TAG, "Status Bar");
                                statusBarManagerService = new StatusBarManagerService(context, wm);
                                ServiceManager.addService("statusbar", statusBarManagerService);
                                statusBar = statusBarManagerService;
                            }
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "Clipboard Service");
                                ServiceManager.addService("clipboard", new ClipboardService(context));
                            }
                            if (disableNetwork) {
                                Slog.i(TAG, "NetworkManagement Service");
                                networkManagement = NetworkManagementService.create(context);
                                ServiceManager.addService("network_management", networkManagement);
                            }
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "Text Service Manager Service");
                                textServicesManagerService = new TextServicesManagerService(context);
                                ServiceManager.addService("textservices", textServicesManagerService);
                                tsms = textServicesManagerService;
                            }
                            if (disableNetwork) {
                                networkPolicy = null;
                            } else {
                                Slog.i(TAG, "Network Score Service");
                                networkScoreService = new NetworkScoreService(context);
                                ServiceManager.addService("network_score", networkScoreService);
                                networkScore = networkScoreService;
                                Slog.i(TAG, "NetworkStats Service");
                                networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                                ServiceManager.addService("netstats", networkStatsService);
                                networkStats = networkStatsService;
                                Slog.i(TAG, "NetworkPolicy Service");
                                networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                                ServiceManager.addService("netpolicy", networkPolicy);
                                this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                                this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                                this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                                this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                                if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                    this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                                }
                                Slog.i(TAG, "Connectivity Service");
                                connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                                ServiceManager.addService("connectivity", connectivityService);
                                networkStats.bindConnectivityManager(connectivityService);
                                networkPolicy.bindConnectivityManager(connectivityService);
                                connectivity = connectivityService;
                                Slog.i(TAG, "Network Service Discovery Service");
                                ServiceManager.addService("servicediscovery", NsdService.create(context));
                                Slog.i(TAG, "DPM Service");
                                startDpmService(context);
                            }
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "UpdateLock Service");
                                ServiceManager.addService("updatelock", new UpdateLockService(context));
                            }
                            mountService2.waitForAsecScan();
                            if (accountManagerService != null) {
                                accountManagerService.systemReady();
                            }
                            if (contentService != null) {
                                contentService.systemReady();
                            }
                            this.mSystemServiceManager.startService(NotificationManagerService.class);
                            networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                            this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                            if (disableLocation) {
                                Slog.i(TAG, "Location Manager");
                                locationManagerService = new LocationManagerService(context);
                                ServiceManager.addService("location", locationManagerService);
                                location = locationManagerService;
                                Slog.i(TAG, "Country Detector");
                                countryDetectorService = new CountryDetectorService(context);
                                ServiceManager.addService("country_detector", countryDetectorService);
                                countryDetector = countryDetectorService;
                            }
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "Search Service");
                                ServiceManager.addService("search", new SearchManagerService(context));
                            }
                            Slog.i(TAG, "DropBox Service");
                            ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                            Slog.i(TAG, "Wallpaper Service");
                            wallpaperManagerService = new WallpaperManagerService(context);
                            ServiceManager.addService("wallpaper", wallpaperManagerService);
                            wallpaper = wallpaperManagerService;
                            Slog.i(TAG, "Audio Service");
                            audioService = new AudioService(context);
                            ServiceManager.addService("audio", audioService);
                            audioService2 = audioService;
                            if (disableNonCoreServices) {
                                this.mSystemServiceManager.startService(DockObserver.class);
                            }
                            if (disableMedia) {
                                Slog.i(TAG, "Wired Accessory Manager");
                                inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                            }
                            if (disableNonCoreServices) {
                                this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                                Slog.i(TAG, "Serial Service");
                                serialService = new SerialService(context);
                                ServiceManager.addService("serial", serialService);
                                serialService2 = serialService;
                            }
                            this.mSystemServiceManager.startService(TwilightService.class);
                            this.mSystemServiceManager.startService(UiModeManagerService.class);
                            this.mSystemServiceManager.startService(JobSchedulerService.class);
                            if (disableNonCoreServices) {
                                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                                }
                                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                                }
                                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                                }
                            }
                            Slog.i(TAG, "DiskStats Service");
                            ServiceManager.addService("diskstats", new DiskStatsService(context));
                            Slog.i(TAG, "SamplingProfiler Service");
                            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                            Slog.i(TAG, "NetworkTimeUpdateService");
                            networkTimeUpdater = new NetworkTimeUpdateService(context);
                            if (disableMedia) {
                                Slog.i(TAG, "CommonTimeManagementService");
                                commonTimeManagementService = new CommonTimeManagementService(context);
                                ServiceManager.addService("commontime_management", commonTimeManagementService);
                                commonTimeMgmtService = commonTimeManagementService;
                            }
                            if (disableNetwork) {
                                Slog.i(TAG, "CertBlacklister");
                                certBlacklister = new CertBlacklister(context);
                            }
                            if (disableNonCoreServices) {
                                this.mSystemServiceManager.startService(DreamManagerService.class);
                            }
                            Slog.i(TAG, "Assets Atlas Service");
                            assetAtlasService = new AssetAtlasService(context);
                            ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                            atlas = assetAtlasService;
                            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                            }
                            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                            this.mSystemServiceManager.startService(MediaSessionService.class);
                            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                                this.mSystemServiceManager.startService(HdmiControlService.class);
                            }
                            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                                this.mSystemServiceManager.startService(TvInputManagerService.class);
                            }
                            if (disableNonCoreServices) {
                                Slog.i(TAG, "Media Router Service");
                                mediaRouterService = new MediaRouterService(context);
                                ServiceManager.addService("media_router", mediaRouterService);
                                mediaRouter = mediaRouterService;
                                this.mSystemServiceManager.startService(TrustManagerService.class);
                                this.mSystemServiceManager.startService(FingerprintService.class);
                                Slog.i(TAG, "BackgroundDexOptService");
                                BackgroundDexOptService.schedule(context);
                            }
                            this.mSystemServiceManager.startService(LauncherAppsService.class);
                            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                                Slog.d(TAG, "Wipower not supported");
                            } else {
                                WBC_SERVICE_NAME = "wbc_service";
                                Slog.i(TAG, "WipowerBatteryControl Service");
                                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                                Slog.d(TAG, "Successfully loaded WbcService class");
                                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                            }
                        } else {
                            networkPolicy = null;
                        }
                        if (disableNonCoreServices) {
                            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                        }
                        safeMode = wm.detectSafeMode();
                        if (safeMode) {
                            VMRuntime.getRuntime().startJitCompilation();
                        } else {
                            this.mActivityManagerService.enterSafeMode();
                            VMRuntime.getRuntime().disableJitCompilation();
                        }
                        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                        vibrator.systemReady();
                        if (lockSettings != null) {
                            lockSettings.systemReady();
                        }
                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                        wm.systemReady();
                        if (safeMode) {
                            this.mActivityManagerService.showSafeModeOverlay();
                        }
                        config = wm.computeNewConfiguration();
                        metrics = new DisplayMetrics();
                        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                        context.getResources().updateConfiguration(config, metrics);
                        this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                        this.mPackageManagerService.systemReady();
                        this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                        audioServiceF = audioService2;
                        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                    }
                    this.mPackageManagerService.performBootDexOpt();
                    ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                    if (this.mFactoryTestMode == 1) {
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "LockSettingsService");
                            lockSettingsService = new LockSettingsService(context);
                            ServiceManager.addService("lock_settings", lockSettingsService);
                            lockSettings = lockSettingsService;
                            if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                                this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                            }
                            this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                        }
                        if (disableSystemUI) {
                            Slog.i(TAG, "Status Bar");
                            statusBarManagerService = new StatusBarManagerService(context, wm);
                            ServiceManager.addService("statusbar", statusBarManagerService);
                            statusBar = statusBarManagerService;
                        }
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "Clipboard Service");
                            ServiceManager.addService("clipboard", new ClipboardService(context));
                        }
                        if (disableNetwork) {
                            Slog.i(TAG, "NetworkManagement Service");
                            networkManagement = NetworkManagementService.create(context);
                            ServiceManager.addService("network_management", networkManagement);
                        }
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "Text Service Manager Service");
                            textServicesManagerService = new TextServicesManagerService(context);
                            ServiceManager.addService("textservices", textServicesManagerService);
                            tsms = textServicesManagerService;
                        }
                        if (disableNetwork) {
                            networkPolicy = null;
                        } else {
                            Slog.i(TAG, "Network Score Service");
                            networkScoreService = new NetworkScoreService(context);
                            ServiceManager.addService("network_score", networkScoreService);
                            networkScore = networkScoreService;
                            Slog.i(TAG, "NetworkStats Service");
                            networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                            ServiceManager.addService("netstats", networkStatsService);
                            networkStats = networkStatsService;
                            Slog.i(TAG, "NetworkPolicy Service");
                            networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                            ServiceManager.addService("netpolicy", networkPolicy);
                            this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                            this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                            this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                            this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                            if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                                this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                            }
                            Slog.i(TAG, "Connectivity Service");
                            connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                            ServiceManager.addService("connectivity", connectivityService);
                            networkStats.bindConnectivityManager(connectivityService);
                            networkPolicy.bindConnectivityManager(connectivityService);
                            connectivity = connectivityService;
                            Slog.i(TAG, "Network Service Discovery Service");
                            ServiceManager.addService("servicediscovery", NsdService.create(context));
                            Slog.i(TAG, "DPM Service");
                            startDpmService(context);
                        }
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "UpdateLock Service");
                            ServiceManager.addService("updatelock", new UpdateLockService(context));
                        }
                        mountService2.waitForAsecScan();
                        if (accountManagerService != null) {
                            accountManagerService.systemReady();
                        }
                        if (contentService != null) {
                            contentService.systemReady();
                        }
                        this.mSystemServiceManager.startService(NotificationManagerService.class);
                        networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                        this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                        if (disableLocation) {
                            Slog.i(TAG, "Location Manager");
                            locationManagerService = new LocationManagerService(context);
                            ServiceManager.addService("location", locationManagerService);
                            location = locationManagerService;
                            Slog.i(TAG, "Country Detector");
                            countryDetectorService = new CountryDetectorService(context);
                            ServiceManager.addService("country_detector", countryDetectorService);
                            countryDetector = countryDetectorService;
                        }
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "Search Service");
                            ServiceManager.addService("search", new SearchManagerService(context));
                        }
                        Slog.i(TAG, "DropBox Service");
                        ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                        Slog.i(TAG, "Wallpaper Service");
                        wallpaperManagerService = new WallpaperManagerService(context);
                        ServiceManager.addService("wallpaper", wallpaperManagerService);
                        wallpaper = wallpaperManagerService;
                        Slog.i(TAG, "Audio Service");
                        audioService = new AudioService(context);
                        ServiceManager.addService("audio", audioService);
                        audioService2 = audioService;
                        if (disableNonCoreServices) {
                            this.mSystemServiceManager.startService(DockObserver.class);
                        }
                        if (disableMedia) {
                            Slog.i(TAG, "Wired Accessory Manager");
                            inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                        }
                        if (disableNonCoreServices) {
                            this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                            Slog.i(TAG, "Serial Service");
                            serialService = new SerialService(context);
                            ServiceManager.addService("serial", serialService);
                            serialService2 = serialService;
                        }
                        this.mSystemServiceManager.startService(TwilightService.class);
                        this.mSystemServiceManager.startService(UiModeManagerService.class);
                        this.mSystemServiceManager.startService(JobSchedulerService.class);
                        if (disableNonCoreServices) {
                            if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                                this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                            }
                            if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                                this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                            }
                            if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                                this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                            }
                        }
                        Slog.i(TAG, "DiskStats Service");
                        ServiceManager.addService("diskstats", new DiskStatsService(context));
                        Slog.i(TAG, "SamplingProfiler Service");
                        ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                        Slog.i(TAG, "NetworkTimeUpdateService");
                        networkTimeUpdater = new NetworkTimeUpdateService(context);
                        if (disableMedia) {
                            Slog.i(TAG, "CommonTimeManagementService");
                            commonTimeManagementService = new CommonTimeManagementService(context);
                            ServiceManager.addService("commontime_management", commonTimeManagementService);
                            commonTimeMgmtService = commonTimeManagementService;
                        }
                        if (disableNetwork) {
                            Slog.i(TAG, "CertBlacklister");
                            certBlacklister = new CertBlacklister(context);
                        }
                        if (disableNonCoreServices) {
                            this.mSystemServiceManager.startService(DreamManagerService.class);
                        }
                        Slog.i(TAG, "Assets Atlas Service");
                        assetAtlasService = new AssetAtlasService(context);
                        ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                        atlas = assetAtlasService;
                        if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                            this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                        }
                        this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                        this.mSystemServiceManager.startService(MediaSessionService.class);
                        if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                            this.mSystemServiceManager.startService(HdmiControlService.class);
                        }
                        if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                            this.mSystemServiceManager.startService(TvInputManagerService.class);
                        }
                        if (disableNonCoreServices) {
                            Slog.i(TAG, "Media Router Service");
                            mediaRouterService = new MediaRouterService(context);
                            ServiceManager.addService("media_router", mediaRouterService);
                            mediaRouter = mediaRouterService;
                            this.mSystemServiceManager.startService(TrustManagerService.class);
                            this.mSystemServiceManager.startService(FingerprintService.class);
                            Slog.i(TAG, "BackgroundDexOptService");
                            BackgroundDexOptService.schedule(context);
                        }
                        this.mSystemServiceManager.startService(LauncherAppsService.class);
                        if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                            Slog.d(TAG, "Wipower not supported");
                        } else {
                            WBC_SERVICE_NAME = "wbc_service";
                            Slog.i(TAG, "WipowerBatteryControl Service");
                            wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                            Slog.d(TAG, "Successfully loaded WbcService class");
                            ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                        }
                    } else {
                        networkPolicy = null;
                    }
                    if (disableNonCoreServices) {
                        this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                    }
                    safeMode = wm.detectSafeMode();
                    if (safeMode) {
                        VMRuntime.getRuntime().startJitCompilation();
                    } else {
                        this.mActivityManagerService.enterSafeMode();
                        VMRuntime.getRuntime().disableJitCompilation();
                    }
                    mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                    vibrator.systemReady();
                    if (lockSettings != null) {
                        lockSettings.systemReady();
                    }
                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                    this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                    wm.systemReady();
                    if (safeMode) {
                        this.mActivityManagerService.showSafeModeOverlay();
                    }
                    config = wm.computeNewConfiguration();
                    metrics = new DisplayMetrics();
                    ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                    context.getResources().updateConfiguration(config, metrics);
                    this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                    this.mPackageManagerService.systemReady();
                    this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                    audioServiceF = audioService2;
                    this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
                }
            } catch (Throwable th36) {
                e422222222222222222 = th36;
                Slog.e(TAG, "Failure starting Account Manager", e422222222222222222);
                Slog.i(TAG, "Content Manager");
                if (this.mFactoryTestMode == 1) {
                }
                contentService = ContentService.main(context, this.mFactoryTestMode == 1);
                Slog.i(TAG, "System Content Providers");
                this.mActivityManagerService.installSystemProviders();
                Slog.i(TAG, "Vibrator Service");
                vibratorService = new VibratorService(context);
                ServiceManager.addService("vibrator", vibratorService);
                Slog.i(TAG, "Consumer IR Service");
                consumerIrService = new ConsumerIrService(context);
                ServiceManager.addService("consumer_ir", consumerIrService);
                this.mAlarmManagerService = (AlarmManagerService) this.mSystemServiceManager.startService(AlarmManagerService.class);
                alarm = IAlarmManager.Stub.asInterface(ServiceManager.getService("alarm"));
                Slog.i(TAG, "Init Watchdog");
                Watchdog.getInstance().init(context, this.mActivityManagerService);
                Slog.i(TAG, "Input Manager");
                inputManagerService = new InputManagerService(context);
                Slog.i(TAG, "Window Manager");
                if (this.mFactoryTestMode != 1) {
                    z = false;
                } else {
                    z = true;
                }
                if (this.mFirstBoot) {
                    z2 = false;
                } else {
                    z2 = true;
                }
                wm = WindowManagerService.main(context, inputManagerService, z, z2, this.mOnlyCore);
                ServiceManager.addService("window", wm);
                ServiceManager.addService("input", inputManagerService);
                this.mActivityManagerService.setWindowManager(wm);
                inputManagerService.setWindowManagerCallbacks(wm.getInputMonitor());
                inputManagerService.start();
                this.mDisplayManagerService.windowManagerAndInputReady();
                if (!isEmulator) {
                    Slog.i(TAG, "No Bluetooth Service (emulator)");
                } else if (this.mFactoryTestMode != 1) {
                    Slog.i(TAG, "No Bluetooth Service (factory test)");
                } else if (context.getPackageManager().hasSystemFeature("android.hardware.bluetooth")) {
                    Slog.i(TAG, "No Bluetooth Service (Bluetooth Hardware Not Present)");
                } else if (disableBluetooth) {
                    Slog.i(TAG, "Bluetooth Manager Service");
                    bluetoothManagerService = new BluetoothManagerService(context);
                    ServiceManager.addService("bluetooth_manager", bluetoothManagerService);
                    bluetoothManagerService2 = bluetoothManagerService;
                } else {
                    Slog.i(TAG, "Bluetooth Service disabled by config");
                }
                consumerIrService2 = consumerIrService;
                telephonyRegistry = telephonyRegistry2;
                inputManager = inputManagerService;
                vibrator = vibratorService;
                statusBar = null;
                imm = null;
                wallpaper = null;
                location = null;
                countryDetector = null;
                tsms = null;
                lockSettings = null;
                atlas = null;
                mediaRouter = null;
                if (this.mFactoryTestMode != 1) {
                    Slog.i(TAG, "Input Method Service");
                    inputMethodManagerService = new InputMethodManagerService(context, wm);
                    ServiceManager.addService("input_method", inputMethodManagerService);
                    imm = inputMethodManagerService;
                    Slog.i(TAG, "Accessibility Manager");
                    ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
                }
                wm.displayReady();
                Slog.i(TAG, "Mount Service");
                mountService = new MountService(context);
                ServiceManager.addService("mount", mountService);
                mountService2 = mountService;
                this.mPackageManagerService.performBootDexOpt();
                ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                if (this.mFactoryTestMode == 1) {
                    networkPolicy = null;
                } else {
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "LockSettingsService");
                        lockSettingsService = new LockSettingsService(context);
                        ServiceManager.addService("lock_settings", lockSettingsService);
                        lockSettings = lockSettingsService;
                        if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                            this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                        }
                        this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                    }
                    if (disableSystemUI) {
                        Slog.i(TAG, "Status Bar");
                        statusBarManagerService = new StatusBarManagerService(context, wm);
                        ServiceManager.addService("statusbar", statusBarManagerService);
                        statusBar = statusBarManagerService;
                    }
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "Clipboard Service");
                        ServiceManager.addService("clipboard", new ClipboardService(context));
                    }
                    if (disableNetwork) {
                        Slog.i(TAG, "NetworkManagement Service");
                        networkManagement = NetworkManagementService.create(context);
                        ServiceManager.addService("network_management", networkManagement);
                    }
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "Text Service Manager Service");
                        textServicesManagerService = new TextServicesManagerService(context);
                        ServiceManager.addService("textservices", textServicesManagerService);
                        tsms = textServicesManagerService;
                    }
                    if (disableNetwork) {
                        Slog.i(TAG, "Network Score Service");
                        networkScoreService = new NetworkScoreService(context);
                        ServiceManager.addService("network_score", networkScoreService);
                        networkScore = networkScoreService;
                        Slog.i(TAG, "NetworkStats Service");
                        networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                        ServiceManager.addService("netstats", networkStatsService);
                        networkStats = networkStatsService;
                        Slog.i(TAG, "NetworkPolicy Service");
                        networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                        ServiceManager.addService("netpolicy", networkPolicy);
                        this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                        this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                        this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                        this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                        if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                            this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                        }
                        Slog.i(TAG, "Connectivity Service");
                        connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                        ServiceManager.addService("connectivity", connectivityService);
                        networkStats.bindConnectivityManager(connectivityService);
                        networkPolicy.bindConnectivityManager(connectivityService);
                        connectivity = connectivityService;
                        Slog.i(TAG, "Network Service Discovery Service");
                        ServiceManager.addService("servicediscovery", NsdService.create(context));
                        Slog.i(TAG, "DPM Service");
                        startDpmService(context);
                    } else {
                        networkPolicy = null;
                    }
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "UpdateLock Service");
                        ServiceManager.addService("updatelock", new UpdateLockService(context));
                    }
                    mountService2.waitForAsecScan();
                    if (accountManagerService != null) {
                        accountManagerService.systemReady();
                    }
                    if (contentService != null) {
                        contentService.systemReady();
                    }
                    this.mSystemServiceManager.startService(NotificationManagerService.class);
                    networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                    this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                    if (disableLocation) {
                        Slog.i(TAG, "Location Manager");
                        locationManagerService = new LocationManagerService(context);
                        ServiceManager.addService("location", locationManagerService);
                        location = locationManagerService;
                        Slog.i(TAG, "Country Detector");
                        countryDetectorService = new CountryDetectorService(context);
                        ServiceManager.addService("country_detector", countryDetectorService);
                        countryDetector = countryDetectorService;
                    }
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "Search Service");
                        ServiceManager.addService("search", new SearchManagerService(context));
                    }
                    Slog.i(TAG, "DropBox Service");
                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                    Slog.i(TAG, "Wallpaper Service");
                    wallpaperManagerService = new WallpaperManagerService(context);
                    ServiceManager.addService("wallpaper", wallpaperManagerService);
                    wallpaper = wallpaperManagerService;
                    Slog.i(TAG, "Audio Service");
                    audioService = new AudioService(context);
                    ServiceManager.addService("audio", audioService);
                    audioService2 = audioService;
                    if (disableNonCoreServices) {
                        this.mSystemServiceManager.startService(DockObserver.class);
                    }
                    if (disableMedia) {
                        Slog.i(TAG, "Wired Accessory Manager");
                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                    }
                    if (disableNonCoreServices) {
                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                        Slog.i(TAG, "Serial Service");
                        serialService = new SerialService(context);
                        ServiceManager.addService("serial", serialService);
                        serialService2 = serialService;
                    }
                    this.mSystemServiceManager.startService(TwilightService.class);
                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                    if (disableNonCoreServices) {
                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                        }
                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                        }
                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                        }
                    }
                    Slog.i(TAG, "DiskStats Service");
                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                    Slog.i(TAG, "SamplingProfiler Service");
                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                    Slog.i(TAG, "NetworkTimeUpdateService");
                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                    if (disableMedia) {
                        Slog.i(TAG, "CommonTimeManagementService");
                        commonTimeManagementService = new CommonTimeManagementService(context);
                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                        commonTimeMgmtService = commonTimeManagementService;
                    }
                    if (disableNetwork) {
                        Slog.i(TAG, "CertBlacklister");
                        certBlacklister = new CertBlacklister(context);
                    }
                    if (disableNonCoreServices) {
                        this.mSystemServiceManager.startService(DreamManagerService.class);
                    }
                    Slog.i(TAG, "Assets Atlas Service");
                    assetAtlasService = new AssetAtlasService(context);
                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                    atlas = assetAtlasService;
                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                    }
                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                    this.mSystemServiceManager.startService(MediaSessionService.class);
                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                        this.mSystemServiceManager.startService(HdmiControlService.class);
                    }
                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                    }
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "Media Router Service");
                        mediaRouterService = new MediaRouterService(context);
                        ServiceManager.addService("media_router", mediaRouterService);
                        mediaRouter = mediaRouterService;
                        this.mSystemServiceManager.startService(TrustManagerService.class);
                        this.mSystemServiceManager.startService(FingerprintService.class);
                        Slog.i(TAG, "BackgroundDexOptService");
                        BackgroundDexOptService.schedule(context);
                    }
                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                        WBC_SERVICE_NAME = "wbc_service";
                        Slog.i(TAG, "WipowerBatteryControl Service");
                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                        Slog.d(TAG, "Successfully loaded WbcService class");
                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                    } else {
                        Slog.d(TAG, "Wipower not supported");
                    }
                }
                if (disableNonCoreServices) {
                    this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                }
                safeMode = wm.detectSafeMode();
                if (safeMode) {
                    this.mActivityManagerService.enterSafeMode();
                    VMRuntime.getRuntime().disableJitCompilation();
                } else {
                    VMRuntime.getRuntime().startJitCompilation();
                }
                mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                vibrator.systemReady();
                if (lockSettings != null) {
                    lockSettings.systemReady();
                }
                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                wm.systemReady();
                if (safeMode) {
                    this.mActivityManagerService.showSafeModeOverlay();
                }
                config = wm.computeNewConfiguration();
                metrics = new DisplayMetrics();
                ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                context.getResources().updateConfiguration(config, metrics);
                this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                this.mPackageManagerService.systemReady();
                this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                audioServiceF = audioService2;
                this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
            }
            Slog.i(TAG, "Content Manager");
            if (this.mFactoryTestMode == 1) {
            }
            contentService = ContentService.main(context, this.mFactoryTestMode == 1);
            Slog.i(TAG, "System Content Providers");
            this.mActivityManagerService.installSystemProviders();
            Slog.i(TAG, "Vibrator Service");
            vibratorService = new VibratorService(context);
            try {
                ServiceManager.addService("vibrator", vibratorService);
                Slog.i(TAG, "Consumer IR Service");
                consumerIrService = new ConsumerIrService(context);
                ServiceManager.addService("consumer_ir", consumerIrService);
                this.mAlarmManagerService = (AlarmManagerService) this.mSystemServiceManager.startService(AlarmManagerService.class);
                alarm = IAlarmManager.Stub.asInterface(ServiceManager.getService("alarm"));
                Slog.i(TAG, "Init Watchdog");
                Watchdog.getInstance().init(context, this.mActivityManagerService);
                Slog.i(TAG, "Input Manager");
                inputManagerService = new InputManagerService(context);
                Slog.i(TAG, "Window Manager");
                if (this.mFactoryTestMode != 1) {
                    z = true;
                } else {
                    z = false;
                }
                if (this.mFirstBoot) {
                    z2 = true;
                } else {
                    z2 = false;
                }
                wm = WindowManagerService.main(context, inputManagerService, z, z2, this.mOnlyCore);
                ServiceManager.addService("window", wm);
                ServiceManager.addService("input", inputManagerService);
                this.mActivityManagerService.setWindowManager(wm);
                inputManagerService.setWindowManagerCallbacks(wm.getInputMonitor());
                inputManagerService.start();
                this.mDisplayManagerService.windowManagerAndInputReady();
                if (!isEmulator) {
                    Slog.i(TAG, "No Bluetooth Service (emulator)");
                } else if (this.mFactoryTestMode != 1) {
                    Slog.i(TAG, "No Bluetooth Service (factory test)");
                } else if (context.getPackageManager().hasSystemFeature("android.hardware.bluetooth")) {
                    Slog.i(TAG, "No Bluetooth Service (Bluetooth Hardware Not Present)");
                } else if (disableBluetooth) {
                    Slog.i(TAG, "Bluetooth Service disabled by config");
                } else {
                    Slog.i(TAG, "Bluetooth Manager Service");
                    bluetoothManagerService = new BluetoothManagerService(context);
                    ServiceManager.addService("bluetooth_manager", bluetoothManagerService);
                    bluetoothManagerService2 = bluetoothManagerService;
                }
                consumerIrService2 = consumerIrService;
                telephonyRegistry = telephonyRegistry2;
                inputManager = inputManagerService;
                vibrator = vibratorService;
            } catch (RuntimeException e8) {
                e422222222222222222 = e8;
                telephonyRegistry = telephonyRegistry2;
                vibrator = vibratorService;
                Slog.e("System", "******************************************");
                Slog.e("System", "************ Failure starting core service", e422222222222222222);
                statusBar = null;
                imm = null;
                wallpaper = null;
                location = null;
                countryDetector = null;
                tsms = null;
                lockSettings = null;
                atlas = null;
                mediaRouter = null;
                if (this.mFactoryTestMode != 1) {
                    Slog.i(TAG, "Input Method Service");
                    inputMethodManagerService = new InputMethodManagerService(context, wm);
                    ServiceManager.addService("input_method", inputMethodManagerService);
                    imm = inputMethodManagerService;
                    Slog.i(TAG, "Accessibility Manager");
                    ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
                }
                wm.displayReady();
                Slog.i(TAG, "Mount Service");
                mountService = new MountService(context);
                ServiceManager.addService("mount", mountService);
                mountService2 = mountService;
                this.mPackageManagerService.performBootDexOpt();
                ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
                if (this.mFactoryTestMode == 1) {
                    networkPolicy = null;
                } else {
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "LockSettingsService");
                        lockSettingsService = new LockSettingsService(context);
                        ServiceManager.addService("lock_settings", lockSettingsService);
                        lockSettings = lockSettingsService;
                        if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                            this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                        }
                        this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                    }
                    if (disableSystemUI) {
                        Slog.i(TAG, "Status Bar");
                        statusBarManagerService = new StatusBarManagerService(context, wm);
                        ServiceManager.addService("statusbar", statusBarManagerService);
                        statusBar = statusBarManagerService;
                    }
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "Clipboard Service");
                        ServiceManager.addService("clipboard", new ClipboardService(context));
                    }
                    if (disableNetwork) {
                        Slog.i(TAG, "NetworkManagement Service");
                        networkManagement = NetworkManagementService.create(context);
                        ServiceManager.addService("network_management", networkManagement);
                    }
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "Text Service Manager Service");
                        textServicesManagerService = new TextServicesManagerService(context);
                        ServiceManager.addService("textservices", textServicesManagerService);
                        tsms = textServicesManagerService;
                    }
                    if (disableNetwork) {
                        networkPolicy = null;
                    } else {
                        Slog.i(TAG, "Network Score Service");
                        networkScoreService = new NetworkScoreService(context);
                        ServiceManager.addService("network_score", networkScoreService);
                        networkScore = networkScoreService;
                        Slog.i(TAG, "NetworkStats Service");
                        networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                        ServiceManager.addService("netstats", networkStatsService);
                        networkStats = networkStatsService;
                        Slog.i(TAG, "NetworkPolicy Service");
                        networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                        ServiceManager.addService("netpolicy", networkPolicy);
                        this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                        this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                        this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                        this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                        if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                            this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                        }
                        Slog.i(TAG, "Connectivity Service");
                        connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                        ServiceManager.addService("connectivity", connectivityService);
                        networkStats.bindConnectivityManager(connectivityService);
                        networkPolicy.bindConnectivityManager(connectivityService);
                        connectivity = connectivityService;
                        Slog.i(TAG, "Network Service Discovery Service");
                        ServiceManager.addService("servicediscovery", NsdService.create(context));
                        Slog.i(TAG, "DPM Service");
                        startDpmService(context);
                    }
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "UpdateLock Service");
                        ServiceManager.addService("updatelock", new UpdateLockService(context));
                    }
                    mountService2.waitForAsecScan();
                    if (accountManagerService != null) {
                        accountManagerService.systemReady();
                    }
                    if (contentService != null) {
                        contentService.systemReady();
                    }
                    this.mSystemServiceManager.startService(NotificationManagerService.class);
                    networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                    this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                    if (disableLocation) {
                        Slog.i(TAG, "Location Manager");
                        locationManagerService = new LocationManagerService(context);
                        ServiceManager.addService("location", locationManagerService);
                        location = locationManagerService;
                        Slog.i(TAG, "Country Detector");
                        countryDetectorService = new CountryDetectorService(context);
                        ServiceManager.addService("country_detector", countryDetectorService);
                        countryDetector = countryDetectorService;
                    }
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "Search Service");
                        ServiceManager.addService("search", new SearchManagerService(context));
                    }
                    Slog.i(TAG, "DropBox Service");
                    ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                    Slog.i(TAG, "Wallpaper Service");
                    wallpaperManagerService = new WallpaperManagerService(context);
                    ServiceManager.addService("wallpaper", wallpaperManagerService);
                    wallpaper = wallpaperManagerService;
                    Slog.i(TAG, "Audio Service");
                    audioService = new AudioService(context);
                    ServiceManager.addService("audio", audioService);
                    audioService2 = audioService;
                    if (disableNonCoreServices) {
                        this.mSystemServiceManager.startService(DockObserver.class);
                    }
                    if (disableMedia) {
                        Slog.i(TAG, "Wired Accessory Manager");
                        inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                    }
                    if (disableNonCoreServices) {
                        this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                        Slog.i(TAG, "Serial Service");
                        serialService = new SerialService(context);
                        ServiceManager.addService("serial", serialService);
                        serialService2 = serialService;
                    }
                    this.mSystemServiceManager.startService(TwilightService.class);
                    this.mSystemServiceManager.startService(UiModeManagerService.class);
                    this.mSystemServiceManager.startService(JobSchedulerService.class);
                    if (disableNonCoreServices) {
                        if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                            this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                        }
                        if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                            this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                        }
                        if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                            this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                        }
                    }
                    Slog.i(TAG, "DiskStats Service");
                    ServiceManager.addService("diskstats", new DiskStatsService(context));
                    Slog.i(TAG, "SamplingProfiler Service");
                    ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                    Slog.i(TAG, "NetworkTimeUpdateService");
                    networkTimeUpdater = new NetworkTimeUpdateService(context);
                    if (disableMedia) {
                        Slog.i(TAG, "CommonTimeManagementService");
                        commonTimeManagementService = new CommonTimeManagementService(context);
                        ServiceManager.addService("commontime_management", commonTimeManagementService);
                        commonTimeMgmtService = commonTimeManagementService;
                    }
                    if (disableNetwork) {
                        Slog.i(TAG, "CertBlacklister");
                        certBlacklister = new CertBlacklister(context);
                    }
                    if (disableNonCoreServices) {
                        this.mSystemServiceManager.startService(DreamManagerService.class);
                    }
                    Slog.i(TAG, "Assets Atlas Service");
                    assetAtlasService = new AssetAtlasService(context);
                    ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                    atlas = assetAtlasService;
                    if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                        this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                    }
                    this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                    this.mSystemServiceManager.startService(MediaSessionService.class);
                    if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                        this.mSystemServiceManager.startService(HdmiControlService.class);
                    }
                    if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                        this.mSystemServiceManager.startService(TvInputManagerService.class);
                    }
                    if (disableNonCoreServices) {
                        Slog.i(TAG, "Media Router Service");
                        mediaRouterService = new MediaRouterService(context);
                        ServiceManager.addService("media_router", mediaRouterService);
                        mediaRouter = mediaRouterService;
                        this.mSystemServiceManager.startService(TrustManagerService.class);
                        this.mSystemServiceManager.startService(FingerprintService.class);
                        Slog.i(TAG, "BackgroundDexOptService");
                        BackgroundDexOptService.schedule(context);
                    }
                    this.mSystemServiceManager.startService(LauncherAppsService.class);
                    if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                        WBC_SERVICE_NAME = "wbc_service";
                        Slog.i(TAG, "WipowerBatteryControl Service");
                        wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                        Slog.d(TAG, "Successfully loaded WbcService class");
                        ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                    } else {
                        Slog.d(TAG, "Wipower not supported");
                    }
                }
                if (disableNonCoreServices) {
                    this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
                }
                safeMode = wm.detectSafeMode();
                if (safeMode) {
                    this.mActivityManagerService.enterSafeMode();
                    VMRuntime.getRuntime().disableJitCompilation();
                } else {
                    VMRuntime.getRuntime().startJitCompilation();
                }
                mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
                vibrator.systemReady();
                if (lockSettings != null) {
                    lockSettings.systemReady();
                }
                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
                this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
                wm.systemReady();
                if (safeMode) {
                    this.mActivityManagerService.showSafeModeOverlay();
                }
                config = wm.computeNewConfiguration();
                metrics = new DisplayMetrics();
                ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
                context.getResources().updateConfiguration(config, metrics);
                this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
                this.mPackageManagerService.systemReady();
                this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
                audioServiceF = audioService2;
                this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
            }
        } catch (RuntimeException e9) {
            e422222222222222222 = e9;
            Slog.e("System", "******************************************");
            Slog.e("System", "************ Failure starting core service", e422222222222222222);
            statusBar = null;
            imm = null;
            wallpaper = null;
            location = null;
            countryDetector = null;
            tsms = null;
            lockSettings = null;
            atlas = null;
            mediaRouter = null;
            if (this.mFactoryTestMode != 1) {
                Slog.i(TAG, "Input Method Service");
                inputMethodManagerService = new InputMethodManagerService(context, wm);
                ServiceManager.addService("input_method", inputMethodManagerService);
                imm = inputMethodManagerService;
                Slog.i(TAG, "Accessibility Manager");
                ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
            }
            wm.displayReady();
            Slog.i(TAG, "Mount Service");
            mountService = new MountService(context);
            ServiceManager.addService("mount", mountService);
            mountService2 = mountService;
            this.mPackageManagerService.performBootDexOpt();
            ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
            if (this.mFactoryTestMode == 1) {
                if (disableNonCoreServices) {
                    Slog.i(TAG, "LockSettingsService");
                    lockSettingsService = new LockSettingsService(context);
                    ServiceManager.addService("lock_settings", lockSettingsService);
                    lockSettings = lockSettingsService;
                    if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                        this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                    }
                    this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
                }
                if (disableSystemUI) {
                    Slog.i(TAG, "Status Bar");
                    statusBarManagerService = new StatusBarManagerService(context, wm);
                    ServiceManager.addService("statusbar", statusBarManagerService);
                    statusBar = statusBarManagerService;
                }
                if (disableNonCoreServices) {
                    Slog.i(TAG, "Clipboard Service");
                    ServiceManager.addService("clipboard", new ClipboardService(context));
                }
                if (disableNetwork) {
                    Slog.i(TAG, "NetworkManagement Service");
                    networkManagement = NetworkManagementService.create(context);
                    ServiceManager.addService("network_management", networkManagement);
                }
                if (disableNonCoreServices) {
                    Slog.i(TAG, "Text Service Manager Service");
                    textServicesManagerService = new TextServicesManagerService(context);
                    ServiceManager.addService("textservices", textServicesManagerService);
                    tsms = textServicesManagerService;
                }
                if (disableNetwork) {
                    Slog.i(TAG, "Network Score Service");
                    networkScoreService = new NetworkScoreService(context);
                    ServiceManager.addService("network_score", networkScoreService);
                    networkScore = networkScoreService;
                    Slog.i(TAG, "NetworkStats Service");
                    networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                    ServiceManager.addService("netstats", networkStatsService);
                    networkStats = networkStatsService;
                    Slog.i(TAG, "NetworkPolicy Service");
                    networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                    ServiceManager.addService("netpolicy", networkPolicy);
                    this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                    this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                    this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                    this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                    if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                        this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                    }
                    Slog.i(TAG, "Connectivity Service");
                    connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                    ServiceManager.addService("connectivity", connectivityService);
                    networkStats.bindConnectivityManager(connectivityService);
                    networkPolicy.bindConnectivityManager(connectivityService);
                    connectivity = connectivityService;
                    Slog.i(TAG, "Network Service Discovery Service");
                    ServiceManager.addService("servicediscovery", NsdService.create(context));
                    Slog.i(TAG, "DPM Service");
                    startDpmService(context);
                } else {
                    networkPolicy = null;
                }
                if (disableNonCoreServices) {
                    Slog.i(TAG, "UpdateLock Service");
                    ServiceManager.addService("updatelock", new UpdateLockService(context));
                }
                mountService2.waitForAsecScan();
                if (accountManagerService != null) {
                    accountManagerService.systemReady();
                }
                if (contentService != null) {
                    contentService.systemReady();
                }
                this.mSystemServiceManager.startService(NotificationManagerService.class);
                networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
                this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
                if (disableLocation) {
                    Slog.i(TAG, "Location Manager");
                    locationManagerService = new LocationManagerService(context);
                    ServiceManager.addService("location", locationManagerService);
                    location = locationManagerService;
                    Slog.i(TAG, "Country Detector");
                    countryDetectorService = new CountryDetectorService(context);
                    ServiceManager.addService("country_detector", countryDetectorService);
                    countryDetector = countryDetectorService;
                }
                if (disableNonCoreServices) {
                    Slog.i(TAG, "Search Service");
                    ServiceManager.addService("search", new SearchManagerService(context));
                }
                Slog.i(TAG, "DropBox Service");
                ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
                Slog.i(TAG, "Wallpaper Service");
                wallpaperManagerService = new WallpaperManagerService(context);
                ServiceManager.addService("wallpaper", wallpaperManagerService);
                wallpaper = wallpaperManagerService;
                Slog.i(TAG, "Audio Service");
                audioService = new AudioService(context);
                ServiceManager.addService("audio", audioService);
                audioService2 = audioService;
                if (disableNonCoreServices) {
                    this.mSystemServiceManager.startService(DockObserver.class);
                }
                if (disableMedia) {
                    Slog.i(TAG, "Wired Accessory Manager");
                    inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
                }
                if (disableNonCoreServices) {
                    this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                    Slog.i(TAG, "Serial Service");
                    serialService = new SerialService(context);
                    ServiceManager.addService("serial", serialService);
                    serialService2 = serialService;
                }
                this.mSystemServiceManager.startService(TwilightService.class);
                this.mSystemServiceManager.startService(UiModeManagerService.class);
                this.mSystemServiceManager.startService(JobSchedulerService.class);
                if (disableNonCoreServices) {
                    if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                        this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                    }
                    if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                        this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                    }
                    if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                        this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                    }
                }
                Slog.i(TAG, "DiskStats Service");
                ServiceManager.addService("diskstats", new DiskStatsService(context));
                Slog.i(TAG, "SamplingProfiler Service");
                ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
                Slog.i(TAG, "NetworkTimeUpdateService");
                networkTimeUpdater = new NetworkTimeUpdateService(context);
                if (disableMedia) {
                    Slog.i(TAG, "CommonTimeManagementService");
                    commonTimeManagementService = new CommonTimeManagementService(context);
                    ServiceManager.addService("commontime_management", commonTimeManagementService);
                    commonTimeMgmtService = commonTimeManagementService;
                }
                if (disableNetwork) {
                    Slog.i(TAG, "CertBlacklister");
                    certBlacklister = new CertBlacklister(context);
                }
                if (disableNonCoreServices) {
                    this.mSystemServiceManager.startService(DreamManagerService.class);
                }
                Slog.i(TAG, "Assets Atlas Service");
                assetAtlasService = new AssetAtlasService(context);
                ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                atlas = assetAtlasService;
                if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                    this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
                }
                this.mSystemServiceManager.startService(RestrictionsManagerService.class);
                this.mSystemServiceManager.startService(MediaSessionService.class);
                if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                    this.mSystemServiceManager.startService(HdmiControlService.class);
                }
                if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                    this.mSystemServiceManager.startService(TvInputManagerService.class);
                }
                if (disableNonCoreServices) {
                    Slog.i(TAG, "Media Router Service");
                    mediaRouterService = new MediaRouterService(context);
                    ServiceManager.addService("media_router", mediaRouterService);
                    mediaRouter = mediaRouterService;
                    this.mSystemServiceManager.startService(TrustManagerService.class);
                    this.mSystemServiceManager.startService(FingerprintService.class);
                    Slog.i(TAG, "BackgroundDexOptService");
                    BackgroundDexOptService.schedule(context);
                }
                this.mSystemServiceManager.startService(LauncherAppsService.class);
                if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                    WBC_SERVICE_NAME = "wbc_service";
                    Slog.i(TAG, "WipowerBatteryControl Service");
                    wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                    Slog.d(TAG, "Successfully loaded WbcService class");
                    ServiceManager.addService("wbc_service", (IBinder) wbcObject);
                } else {
                    Slog.d(TAG, "Wipower not supported");
                }
            } else {
                networkPolicy = null;
            }
            if (disableNonCoreServices) {
                this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
            }
            safeMode = wm.detectSafeMode();
            if (safeMode) {
                this.mActivityManagerService.enterSafeMode();
                VMRuntime.getRuntime().disableJitCompilation();
            } else {
                VMRuntime.getRuntime().startJitCompilation();
            }
            mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
            vibrator.systemReady();
            if (lockSettings != null) {
                lockSettings.systemReady();
            }
            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
            this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
            wm.systemReady();
            if (safeMode) {
                this.mActivityManagerService.showSafeModeOverlay();
            }
            config = wm.computeNewConfiguration();
            metrics = new DisplayMetrics();
            ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
            context.getResources().updateConfiguration(config, metrics);
            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
            this.mPackageManagerService.systemReady();
            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
            audioServiceF = audioService2;
            this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
        }
        statusBar = null;
        imm = null;
        wallpaper = null;
        location = null;
        countryDetector = null;
        tsms = null;
        lockSettings = null;
        atlas = null;
        mediaRouter = null;
        if (this.mFactoryTestMode != 1) {
            Slog.i(TAG, "Input Method Service");
            inputMethodManagerService = new InputMethodManagerService(context, wm);
            ServiceManager.addService("input_method", inputMethodManagerService);
            imm = inputMethodManagerService;
            Slog.i(TAG, "Accessibility Manager");
            ServiceManager.addService("accessibility", new AccessibilityManagerService(context));
        }
        try {
            wm.displayReady();
        } catch (Throwable e4222222222222222222) {
            reportWtf("making display ready", e4222222222222222222);
        }
        if (!(this.mFactoryTestMode == 1 || disableStorage || "0".equals(SystemProperties.get("system_init.startmountservice")))) {
            Slog.i(TAG, "Mount Service");
            mountService = new MountService(context);
            ServiceManager.addService("mount", mountService);
            mountService2 = mountService;
        }
        try {
            this.mPackageManagerService.performBootDexOpt();
        } catch (Throwable e42222222222222222222) {
            reportWtf("performing boot dexopt", e42222222222222222222);
        }
        try {
            ActivityManagerNative.getDefault().showBootMessage(context.getResources().getText(17040551), false);
        } catch (RemoteException e10) {
        }
        if (this.mFactoryTestMode == 1) {
            if (disableNonCoreServices) {
                Slog.i(TAG, "LockSettingsService");
                lockSettingsService = new LockSettingsService(context);
                ServiceManager.addService("lock_settings", lockSettingsService);
                lockSettings = lockSettingsService;
                if (SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP).equals("")) {
                    this.mSystemServiceManager.startService(PersistentDataBlockService.class);
                }
                this.mSystemServiceManager.startService(DevicePolicyManagerService.Lifecycle.class);
            }
            if (disableSystemUI) {
                Slog.i(TAG, "Status Bar");
                statusBarManagerService = new StatusBarManagerService(context, wm);
                ServiceManager.addService("statusbar", statusBarManagerService);
                statusBar = statusBarManagerService;
            }
            if (disableNonCoreServices) {
                Slog.i(TAG, "Clipboard Service");
                ServiceManager.addService("clipboard", new ClipboardService(context));
            }
            if (disableNetwork) {
                Slog.i(TAG, "NetworkManagement Service");
                networkManagement = NetworkManagementService.create(context);
                ServiceManager.addService("network_management", networkManagement);
            }
            if (disableNonCoreServices) {
                Slog.i(TAG, "Text Service Manager Service");
                textServicesManagerService = new TextServicesManagerService(context);
                ServiceManager.addService("textservices", textServicesManagerService);
                tsms = textServicesManagerService;
            }
            if (disableNetwork) {
                Slog.i(TAG, "Network Score Service");
                networkScoreService = new NetworkScoreService(context);
                ServiceManager.addService("network_score", networkScoreService);
                networkScore = networkScoreService;
                Slog.i(TAG, "NetworkStats Service");
                networkStatsService = new NetworkStatsService(context, networkManagement, alarm);
                ServiceManager.addService("netstats", networkStatsService);
                networkStats = networkStatsService;
                Slog.i(TAG, "NetworkPolicy Service");
                networkPolicy = new NetworkPolicyManagerService(context, this.mActivityManagerService, (IPowerManager) ServiceManager.getService("power"), networkStats, networkManagement);
                ServiceManager.addService("netpolicy", networkPolicy);
                this.mSystemServiceManager.startService(WIFI_P2P_SERVICE_CLASS);
                this.mSystemServiceManager.startService(WIFI_SERVICE_CLASS);
                this.mSystemServiceManager.startService("com.android.server.wifi.WifiScanningService");
                this.mSystemServiceManager.startService("com.android.server.wifi.RttService");
                if (this.mPackageManager.hasSystemFeature("android.hardware.ethernet")) {
                    this.mSystemServiceManager.startService(ETHERNET_SERVICE_CLASS);
                }
                Slog.i(TAG, "Connectivity Service");
                connectivityService = new ConnectivityService(context, networkManagement, networkStats, networkPolicy);
                ServiceManager.addService("connectivity", connectivityService);
                networkStats.bindConnectivityManager(connectivityService);
                networkPolicy.bindConnectivityManager(connectivityService);
                connectivity = connectivityService;
                Slog.i(TAG, "Network Service Discovery Service");
                ServiceManager.addService("servicediscovery", NsdService.create(context));
                Slog.i(TAG, "DPM Service");
                startDpmService(context);
            } else {
                networkPolicy = null;
            }
            if (disableNonCoreServices) {
                Slog.i(TAG, "UpdateLock Service");
                ServiceManager.addService("updatelock", new UpdateLockService(context));
            }
            if (!(mountService2 == null || this.mOnlyCore)) {
                mountService2.waitForAsecScan();
            }
            if (accountManagerService != null) {
                accountManagerService.systemReady();
            }
            if (contentService != null) {
                contentService.systemReady();
            }
            this.mSystemServiceManager.startService(NotificationManagerService.class);
            networkPolicy.bindNotificationManager(Stub.asInterface(ServiceManager.getService("notification")));
            this.mSystemServiceManager.startService(DeviceStorageMonitorService.class);
            if (disableLocation) {
                Slog.i(TAG, "Location Manager");
                locationManagerService = new LocationManagerService(context);
                ServiceManager.addService("location", locationManagerService);
                location = locationManagerService;
                Slog.i(TAG, "Country Detector");
                countryDetectorService = new CountryDetectorService(context);
                ServiceManager.addService("country_detector", countryDetectorService);
                countryDetector = countryDetectorService;
            }
            if (disableNonCoreServices) {
                Slog.i(TAG, "Search Service");
                ServiceManager.addService("search", new SearchManagerService(context));
            }
            Slog.i(TAG, "DropBox Service");
            ServiceManager.addService("dropbox", new DropBoxManagerService(context, new File("/data/system/dropbox")));
            if (!disableNonCoreServices && context.getResources().getBoolean(17956935)) {
                Slog.i(TAG, "Wallpaper Service");
                wallpaperManagerService = new WallpaperManagerService(context);
                ServiceManager.addService("wallpaper", wallpaperManagerService);
                wallpaper = wallpaperManagerService;
            }
            if (!(disableMedia || "0".equals(SystemProperties.get("system_init.startaudioservice")))) {
                Slog.i(TAG, "Audio Service");
                audioService = new AudioService(context);
                ServiceManager.addService("audio", audioService);
                audioService2 = audioService;
            }
            if (disableNonCoreServices) {
                this.mSystemServiceManager.startService(DockObserver.class);
            }
            if (disableMedia) {
                Slog.i(TAG, "Wired Accessory Manager");
                inputManager.setWiredAccessoryCallbacks(new WiredAccessoryManager(context, inputManager));
            }
            if (disableNonCoreServices) {
                if (this.mPackageManager.hasSystemFeature("android.hardware.usb.host") || this.mPackageManager.hasSystemFeature("android.hardware.usb.accessory")) {
                    this.mSystemServiceManager.startService(USB_SERVICE_CLASS);
                }
                Slog.i(TAG, "Serial Service");
                serialService = new SerialService(context);
                ServiceManager.addService("serial", serialService);
                serialService2 = serialService;
            }
            this.mSystemServiceManager.startService(TwilightService.class);
            this.mSystemServiceManager.startService(UiModeManagerService.class);
            this.mSystemServiceManager.startService(JobSchedulerService.class);
            if (disableNonCoreServices) {
                if (this.mPackageManager.hasSystemFeature("android.software.backup")) {
                    this.mSystemServiceManager.startService(BACKUP_MANAGER_SERVICE_CLASS);
                }
                if (this.mPackageManager.hasSystemFeature("android.software.app_widgets")) {
                    this.mSystemServiceManager.startService(APPWIDGET_SERVICE_CLASS);
                }
                if (this.mPackageManager.hasSystemFeature("android.software.voice_recognizers")) {
                    this.mSystemServiceManager.startService(VOICE_RECOGNITION_MANAGER_SERVICE_CLASS);
                }
            }
            Slog.i(TAG, "DiskStats Service");
            ServiceManager.addService("diskstats", new DiskStatsService(context));
            Slog.i(TAG, "SamplingProfiler Service");
            ServiceManager.addService("samplingprofiler", new SamplingProfilerService(context));
            if (!(disableNetwork || disableNetworkTime)) {
                Slog.i(TAG, "NetworkTimeUpdateService");
                networkTimeUpdater = new NetworkTimeUpdateService(context);
            }
            if (disableMedia) {
                Slog.i(TAG, "CommonTimeManagementService");
                commonTimeManagementService = new CommonTimeManagementService(context);
                ServiceManager.addService("commontime_management", commonTimeManagementService);
                commonTimeMgmtService = commonTimeManagementService;
            }
            if (disableNetwork) {
                Slog.i(TAG, "CertBlacklister");
                certBlacklister = new CertBlacklister(context);
            }
            if (disableNonCoreServices) {
                this.mSystemServiceManager.startService(DreamManagerService.class);
            }
            if (!(disableNonCoreServices || disableAtlas)) {
                Slog.i(TAG, "Assets Atlas Service");
                assetAtlasService = new AssetAtlasService(context);
                ServiceManager.addService(AssetAtlasService.ASSET_ATLAS_SERVICE, assetAtlasService);
                atlas = assetAtlasService;
            }
            if (this.mPackageManager.hasSystemFeature("android.software.print")) {
                this.mSystemServiceManager.startService(PRINT_MANAGER_SERVICE_CLASS);
            }
            this.mSystemServiceManager.startService(RestrictionsManagerService.class);
            this.mSystemServiceManager.startService(MediaSessionService.class);
            if (this.mPackageManager.hasSystemFeature("android.hardware.hdmi.cec")) {
                this.mSystemServiceManager.startService(HdmiControlService.class);
            }
            if (this.mPackageManager.hasSystemFeature("android.software.live_tv")) {
                this.mSystemServiceManager.startService(TvInputManagerService.class);
            }
            if (disableNonCoreServices) {
                Slog.i(TAG, "Media Router Service");
                mediaRouterService = new MediaRouterService(context);
                ServiceManager.addService("media_router", mediaRouterService);
                mediaRouter = mediaRouterService;
                this.mSystemServiceManager.startService(TrustManagerService.class);
                this.mSystemServiceManager.startService(FingerprintService.class);
                Slog.i(TAG, "BackgroundDexOptService");
                BackgroundDexOptService.schedule(context);
            }
            this.mSystemServiceManager.startService(LauncherAppsService.class);
            if (SystemProperties.getBoolean("ro.bluetooth.wipower", false)) {
                WBC_SERVICE_NAME = "wbc_service";
                Slog.i(TAG, "WipowerBatteryControl Service");
                wbcObject = new PathClassLoader("/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar", ClassLoader.getSystemClassLoader()).loadClass("com.quicinc.wbcservice.WbcService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                Slog.d(TAG, "Successfully loaded WbcService class");
                ServiceManager.addService("wbc_service", (IBinder) wbcObject);
            } else {
                Slog.d(TAG, "Wipower not supported");
            }
        } else {
            networkPolicy = null;
        }
        if (disableNonCoreServices) {
            this.mSystemServiceManager.startService(MediaProjectionManagerService.class);
        }
        safeMode = wm.detectSafeMode();
        if (safeMode) {
            this.mActivityManagerService.enterSafeMode();
            VMRuntime.getRuntime().disableJitCompilation();
        } else {
            VMRuntime.getRuntime().startJitCompilation();
        }
        mmsService = (MmsServiceBroker) this.mSystemServiceManager.startService(MmsServiceBroker.class);
        try {
            vibrator.systemReady();
        } catch (Throwable e422222222222222222222) {
            reportWtf("making Vibrator Service ready", e422222222222222222222);
        }
        if (lockSettings != null) {
            lockSettings.systemReady();
        }
        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_LOCK_SETTINGS_READY);
        this.mSystemServiceManager.startBootPhase(SystemService.PHASE_SYSTEM_SERVICES_READY);
        try {
            wm.systemReady();
        } catch (Throwable e4222222222222222222222) {
            reportWtf("making Window Manager Service ready", e4222222222222222222222);
        }
        if (safeMode) {
            this.mActivityManagerService.showSafeModeOverlay();
        }
        config = wm.computeNewConfiguration();
        metrics = new DisplayMetrics();
        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(metrics);
        context.getResources().updateConfiguration(config, metrics);
        try {
            this.mPowerManagerService.systemReady(this.mActivityManagerService.getAppOpsService());
        } catch (Throwable e42222222222222222222222) {
            reportWtf("making Power Manager Service ready", e42222222222222222222222);
        }
        try {
            this.mPackageManagerService.systemReady();
        } catch (Throwable e422222222222222222222222) {
            reportWtf("making Package Manager Service ready", e422222222222222222222222);
        }
        try {
            this.mDisplayManagerService.systemReady(safeMode, this.mOnlyCore);
        } catch (Throwable e4222222222222222222222222) {
            reportWtf("making Display Manager Service ready", e4222222222222222222222222);
        }
        audioServiceF = audioService2;
        this.mActivityManagerService.systemReady(new C00822(context, mountService2, networkScore, networkManagement, networkStats, networkPolicy, connectivity, audioServiceF, wallpaper, imm, statusBar, location, countryDetector, networkTimeUpdater, commonTimeMgmtService, tsms, atlas, inputManager, telephonyRegistry, mediaRouter, mmsService));
    }

    static final void startSystemUi(Context context) {
        Intent intent = new Intent();
        intent.setComponent(new ComponentName("com.android.systemui", "com.android.systemui.SystemUIService"));
        context.startServiceAsUser(intent, UserHandle.OWNER);
    }

    private static final void startDpmService(Context context) {
        try {
            int dpmFeature = SystemProperties.getInt("persist.dpm.feature", 0);
            Slog.i(TAG, "DPM configuration set to " + dpmFeature);
            if (dpmFeature > 0 && dpmFeature < 8) {
                Object dpmObj = new PathClassLoader("/system/framework/com.qti.dpmframework.jar", ClassLoader.getSystemClassLoader()).loadClass("com.qti.dpm.DpmService").getConstructor(new Class[]{Context.class}).newInstance(new Object[]{context});
                if (dpmObj == null) {
                    return;
                }
                if (dpmObj instanceof IBinder) {
                    ServiceManager.addService("dpmservice", (IBinder) dpmObj);
                    Slog.i(TAG, "Created DPM Service");
                }
            }
        } catch (Exception e) {
            Slog.i(TAG, "starting DPM Service", e);
        } catch (Throwable e2) {
            Slog.i(TAG, "starting DPM Service", e2);
        }
    }
}
