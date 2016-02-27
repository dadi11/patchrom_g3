package com.android.server.pm;

import android.app.ActivityManager;
import android.app.ActivityManagerNative;
import android.app.AppGlobals;
import android.app.IActivityManager;
import android.app.admin.IDevicePolicyManager;
import android.app.backup.IBackupManager;
import android.app.usage.UsageStats;
import android.app.usage.UsageStatsManager;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.IIntentReceiver;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.IntentSender;
import android.content.IntentSender.SendIntentException;
import android.content.ServiceConnection;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.content.pm.FeatureInfo;
import android.content.pm.IPackageDataObserver;
import android.content.pm.IPackageDeleteObserver;
import android.content.pm.IPackageDeleteObserver2;
import android.content.pm.IPackageInstallObserver2;
import android.content.pm.IPackageInstaller;
import android.content.pm.IPackageManager.Stub;
import android.content.pm.IPackageMoveObserver;
import android.content.pm.IPackageStatsObserver;
import android.content.pm.InstrumentationInfo;
import android.content.pm.KeySet;
import android.content.pm.ManifestDigest;
import android.content.pm.PackageCleanItem;
import android.content.pm.PackageInfo;
import android.content.pm.PackageInfoLite;
import android.content.pm.PackageInstaller.SessionParams;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.LegacyPackageDeleteObserver;
import android.content.pm.PackageParser;
import android.content.pm.PackageParser.Activity;
import android.content.pm.PackageParser.ActivityIntentInfo;
import android.content.pm.PackageParser.Instrumentation;
import android.content.pm.PackageParser.NewPermissionInfo;
import android.content.pm.PackageParser.Package;
import android.content.pm.PackageParser.PackageParserException;
import android.content.pm.PackageParser.Permission;
import android.content.pm.PackageParser.PermissionGroup;
import android.content.pm.PackageParser.Provider;
import android.content.pm.PackageParser.ProviderIntentInfo;
import android.content.pm.PackageParser.Service;
import android.content.pm.PackageParser.ServiceIntentInfo;
import android.content.pm.PackageStats;
import android.content.pm.PackageUserState;
import android.content.pm.ParceledListSlice;
import android.content.pm.PermissionGroupInfo;
import android.content.pm.PermissionInfo;
import android.content.pm.ProviderInfo;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.pm.Signature;
import android.content.pm.UserInfo;
import android.content.pm.VerificationParams;
import android.content.pm.VerifierDeviceIdentity;
import android.content.pm.VerifierInfo;
import android.content.res.Resources;
import android.hardware.display.DisplayManager;
import android.net.Uri;
import android.os.Binder;
import android.os.Build;
import android.os.Bundle;
import android.os.Debug;
import android.os.Environment;
import android.os.Environment.UserEnvironment;
import android.os.FileUtils;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.Process;
import android.os.RemoteException;
import android.os.SELinux;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.os.storage.IMountService;
import android.os.storage.StorageManager;
import android.provider.Settings.Global;
import android.security.KeyStore;
import android.security.SystemKeyStore;
import android.system.ErrnoException;
import android.system.Os;
import android.system.OsConstants;
import android.text.TextUtils;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.AtomicFile;
import android.util.DisplayMetrics;
import android.util.EventLog;
import android.util.ExceptionUtils;
import android.util.Log;
import android.util.LogPrinter;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseBooleanArray;
import com.android.internal.app.IMediaContainerService;
import com.android.internal.app.IntentForwarderActivity;
import com.android.internal.content.NativeLibraryHelper;
import com.android.internal.content.PackageHelper;
import com.android.internal.os.IParcelFileDescriptorFactory;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.FastPrintWriter;
import com.android.server.EventLogTags;
import com.android.server.IntentResolver;
import com.android.server.LocalServices;
import com.android.server.ServiceThread;
import com.android.server.storage.DeviceStorageMonitorInternal;
import com.android.server.voiceinteraction.SoundTriggerHelper;
import com.android.services.SecurityBridge.api.PackageManagerMonitor;
import dalvik.system.DexFile;
import dalvik.system.StaleDexCacheError;
import dalvik.system.VMRuntime;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateEncodingException;
import java.security.cert.CertificateException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicLong;
import libcore.io.IoUtils;
import libcore.util.EmptyArray;

public class PackageManagerService extends Stub {
    private static final int BLUETOOTH_UID = 1002;
    static final int BROADCAST_DELAY = 10000;
    static final int CHECK_PENDING_VERIFICATION = 16;
    private static final boolean DEBUG_ABI_SELECTION = false;
    private static final boolean DEBUG_BROADCASTS = false;
    private static final boolean DEBUG_DEXOPT = false;
    private static final boolean DEBUG_INSTALL = false;
    private static final boolean DEBUG_INTENT_MATCHING = false;
    private static final boolean DEBUG_PACKAGE_INFO = false;
    private static final boolean DEBUG_PACKAGE_SCANNING = false;
    static final boolean DEBUG_PREFERRED = false;
    private static final boolean DEBUG_REMOVE = false;
    static final boolean DEBUG_SD_INSTALL = false;
    static final boolean DEBUG_SETTINGS = false;
    private static final boolean DEBUG_SHOW_INFO = false;
    static final boolean DEBUG_UPGRADE = false;
    private static final boolean DEBUG_VERIFY = false;
    static final ComponentName DEFAULT_CONTAINER_COMPONENT;
    static final String DEFAULT_CONTAINER_PACKAGE = "com.android.defcontainer";
    private static final long DEFAULT_MANDATORY_FSTRIM_INTERVAL = 259200000;
    private static final int DEFAULT_VERIFICATION_RESPONSE = 1;
    private static final long DEFAULT_VERIFICATION_TIMEOUT = 10000;
    private static final boolean DEFAULT_VERIFY_ENABLE = true;
    static final int DEX_OPT_DEFERRED = 2;
    static final int DEX_OPT_FAILED = -1;
    static final int DEX_OPT_PERFORMED = 1;
    static final int DEX_OPT_SKIPPED = 0;
    static final int END_COPY = 4;
    static final int FIND_INSTALL_LOC = 8;
    private static final String IDMAP_PREFIX = "/data/resource-cache/";
    private static final String IDMAP_SUFFIX = "@idmap";
    static final int INIT_COPY = 5;
    private static final String INSTALL_PACKAGE_SUFFIX = "-";
    private static final int LOG_UID = 1007;
    private static final int MAX_PERMISSION_TREE_FOOTPRINT = 32768;
    static final int MCS_BOUND = 3;
    static final int MCS_GIVE_UP = 11;
    static final int MCS_RECONNECT = 10;
    static final int MCS_UNBIND = 6;
    private static final int NFC_UID = 1027;
    private static final String PACKAGE_MIME_TYPE = "application/vnd.android.package-archive";
    static final int PACKAGE_VERIFIED = 15;
    static final int POST_INSTALL = 9;
    private static final int RADIO_UID = 1001;
    static final int REMOVE_CHATTY = 65536;
    static final int SCAN_BOOTING = 256;
    static final int SCAN_DEFER_DEX = 128;
    static final int SCAN_DELETE_DATA_ON_FAILURES = 1024;
    static final int SCAN_FORCE_DEX = 4;
    static final int SCAN_NEW_INSTALL = 16;
    static final int SCAN_NO_DEX = 2;
    static final int SCAN_NO_PATHS = 32;
    static final int SCAN_REPLACING = 2048;
    static final int SCAN_REQUIRE_KNOWN = 4096;
    static final int SCAN_TRUSTED_OVERLAY = 512;
    static final int SCAN_UPDATE_SIGNATURE = 8;
    static final int SCAN_UPDATE_TIME = 64;
    private static final String SD_ENCRYPTION_ALGORITHM = "AES";
    private static final String SD_ENCRYPTION_KEYSTORE_NAME = "AppsOnSD";
    private static final String SECURITY_BRIDGE_NAME = "com.android.services.SecurityBridge.core.PackageManagerSB";
    static final int SEND_PENDING_BROADCAST = 1;
    private static final int SHELL_UID = 2000;
    static final int START_CLEANING_PACKAGE = 7;
    static final String TAG = "PackageManager";
    static final int UPDATED_MEDIA_STATUS = 12;
    static final int UPDATE_PERMISSIONS_ALL = 1;
    static final int UPDATE_PERMISSIONS_REPLACE_ALL = 4;
    static final int UPDATE_PERMISSIONS_REPLACE_PKG = 2;
    private static final String VENDOR_OVERLAY_DIR = "/vendor/overlay";
    private static final long WATCHDOG_TIMEOUT = 600000;
    static final int WRITE_PACKAGE_RESTRICTIONS = 14;
    static final int WRITE_SETTINGS = 13;
    static final int WRITE_SETTINGS_DELAY = 10000;
    private static final Comparator<ProviderInfo> mProviderInitOrderSorter;
    private static final Comparator<ResolveInfo> mResolvePrioritySorter;
    private static String sPreferredInstructionSet;
    static UserManagerService sUserManager;
    final ActivityIntentResolver mActivities;
    ApplicationInfo mAndroidApplication;
    final File mAppDataDir;
    final File mAppInstallDir;
    private File mAppLib32InstallDir;
    final ArrayMap<String, ArraySet<String>> mAppOpPermissionPackages;
    final String mAsecInternalPath;
    final ArrayMap<String, FeatureInfo> mAvailableFeatures;
    private IMediaContainerService mContainerService;
    final Context mContext;
    ComponentName mCustomResolverComponentName;
    private final DefaultContainerConnection mDefContainerConn;
    final int mDefParseFlags;
    ArraySet<Package> mDeferredDexOpt;
    final long mDexOptLRUThresholdInMills;
    private ArraySet<Integer> mDirtyUsers;
    ArrayList<ComponentName> mDisabledComponentsList;
    final File mDrmAppPrivateInstallDir;
    final boolean mFactoryTest;
    boolean mFoundPolicyFile;
    final int[] mGlobalGids;
    final PackageHandler mHandler;
    final ServiceThread mHandlerThread;
    volatile boolean mHasSystemUidErrors;
    final Object mInstallLock;
    final Installer mInstaller;
    final PackageInstallerService mInstallerService;
    final ArrayMap<ComponentName, Instrumentation> mInstrumentation;
    final boolean mIsUpgrade;
    final boolean mLazyDexOpt;
    private boolean mMediaMounted;
    final DisplayMetrics mMetrics;
    int mNextInstallToken;
    final boolean mOnlyCore;
    final ArrayMap<String, ArrayMap<String, Package>> mOverlays;
    private final PackageUsage mPackageUsage;
    final ArrayMap<String, Package> mPackages;
    final PendingPackageBroadcasts mPendingBroadcasts;
    final SparseArray<PackageVerificationState> mPendingVerification;
    private int mPendingVerificationToken;
    final ArrayMap<String, PermissionGroup> mPermissionGroups;
    Package mPlatformPackage;
    private ArrayList<Message> mPostSystemReadyMessages;
    final ArraySet<String> mProtectedBroadcasts;
    final ProviderIntentResolver mProviders;
    final ArrayMap<String, Provider> mProvidersByAuthority;
    final ActivityIntentResolver mReceivers;
    private final String mRequiredVerifierPackage;
    final ActivityInfo mResolveActivity;
    ComponentName mResolveComponentName;
    final ResolveInfo mResolveInfo;
    boolean mResolverReplaced;
    boolean mRestoredSettings;
    final SparseArray<PostInstallData> mRunningInstalls;
    volatile boolean mSafeMode;
    final int mSdkVersion;
    private PackageManagerMonitor mSecurityBridge;
    final String[] mSeparateProcesses;
    final ServiceIntentResolver mServices;
    final Settings mSettings;
    final ArrayMap<String, SharedLibraryEntry> mSharedLibraries;
    private boolean mShouldRestoreconData;
    final SparseArray<ArraySet<String>> mSystemPermissions;
    volatile boolean mSystemReady;
    final ArraySet<String> mTransferedPackages;
    final File mUserAppDataDir;
    SparseBooleanArray mUserNeedsBadging;

    /* renamed from: com.android.server.pm.PackageManagerService.10 */
    class AnonymousClass10 implements Runnable {
        final /* synthetic */ IPackageDataObserver val$observer;
        final /* synthetic */ String val$packageName;
        final /* synthetic */ int val$userId;

        AnonymousClass10(String str, int i, IPackageDataObserver iPackageDataObserver) {
            this.val$packageName = str;
            this.val$userId = i;
            this.val$observer = iPackageDataObserver;
        }

        public void run() {
            PackageManagerService.this.mHandler.removeCallbacks(this);
            synchronized (PackageManagerService.this.mInstallLock) {
                boolean succeded = PackageManagerService.this.deleteApplicationCacheFilesLI(this.val$packageName, this.val$userId);
            }
            PackageManagerService.this.clearExternalStorageDataSync(this.val$packageName, this.val$userId, PackageManagerService.DEBUG_VERIFY);
            if (this.val$observer != null) {
                try {
                    this.val$observer.onRemoveCompleted(this.val$packageName, succeded);
                } catch (RemoteException e) {
                    Log.i(PackageManagerService.TAG, "Observer no longer exists.");
                }
            }
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.11 */
    class AnonymousClass11 implements Runnable {
        final /* synthetic */ boolean val$mediaStatus;
        final /* synthetic */ boolean val$reportStatus;

        AnonymousClass11(boolean z, boolean z2) {
            this.val$mediaStatus = z;
            this.val$reportStatus = z2;
        }

        public void run() {
            PackageManagerService.this.updateExternalMediaStatusInner(this.val$mediaStatus, this.val$reportStatus, PackageManagerService.DEFAULT_VERIFY_ENABLE);
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.12 */
    class AnonymousClass12 extends IIntentReceiver.Stub {
        final /* synthetic */ Set val$keys;
        final /* synthetic */ boolean val$reportStatus;

        AnonymousClass12(boolean z, Set set) {
            this.val$reportStatus = z;
            this.val$keys = set;
        }

        public void performReceive(Intent intent, int resultCode, String data, Bundle extras, boolean ordered, boolean sticky, int sendingUser) throws RemoteException {
            PackageManagerService.this.mHandler.sendMessage(PackageManagerService.this.mHandler.obtainMessage(PackageManagerService.UPDATED_MEDIA_STATUS, this.val$reportStatus ? PackageManagerService.UPDATE_PERMISSIONS_ALL : PackageManagerService.DEX_OPT_SKIPPED, PackageManagerService.UPDATE_PERMISSIONS_ALL, this.val$keys));
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.13 */
    class AnonymousClass13 extends IPackageInstallObserver2.Stub {
        final /* synthetic */ IPackageMoveObserver val$observer;
        final /* synthetic */ String val$packageName;

        AnonymousClass13(String str, IPackageMoveObserver iPackageMoveObserver) {
            this.val$packageName = str;
            this.val$observer = iPackageMoveObserver;
        }

        public void onUserActionRequired(Intent intent) throws RemoteException {
            throw new IllegalStateException();
        }

        public void onPackageInstalled(String basePackageName, int returnCode, String msg, Bundle extras) throws RemoteException {
            Slog.d(PackageManagerService.TAG, "Install result for move: " + PackageManager.installStatusToString(returnCode, msg));
            synchronized (PackageManagerService.this.mPackages) {
                Package pkg = (Package) PackageManagerService.this.mPackages.get(this.val$packageName);
                if (pkg != null) {
                    pkg.mOperationPending = PackageManagerService.DEBUG_VERIFY;
                }
            }
            switch (PackageManager.installStatusToPublicStatus(returnCode)) {
                case PackageManagerService.DEX_OPT_SKIPPED /*0*/:
                    this.val$observer.packageMoved(this.val$packageName, PackageManagerService.UPDATE_PERMISSIONS_ALL);
                case PackageManagerService.MCS_UNBIND /*6*/:
                    this.val$observer.packageMoved(this.val$packageName, PackageManagerService.DEX_OPT_FAILED);
                default:
                    this.val$observer.packageMoved(this.val$packageName, -6);
            }
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.14 */
    class AnonymousClass14 implements Runnable {
        final /* synthetic */ String val$packageName;
        final /* synthetic */ int val$userHandle;

        AnonymousClass14(String str, int i) {
            this.val$packageName = str;
            this.val$userHandle = i;
        }

        public void run() {
            PackageManagerService.this.deletePackageX(this.val$packageName, this.val$userHandle, PackageManagerService.DEX_OPT_SKIPPED);
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.1 */
    class C04471 implements Runnable {
        final /* synthetic */ long val$freeStorageSize;
        final /* synthetic */ IPackageDataObserver val$observer;

        C04471(long j, IPackageDataObserver iPackageDataObserver) {
            this.val$freeStorageSize = j;
            this.val$observer = iPackageDataObserver;
        }

        public void run() {
            PackageManagerService.this.mHandler.removeCallbacks(this);
            synchronized (PackageManagerService.this.mInstallLock) {
                int retCode = PackageManagerService.this.mInstaller.freeCache(this.val$freeStorageSize);
                if (retCode < 0) {
                    Slog.w(PackageManagerService.TAG, "Couldn't clear application caches");
                }
            }
            if (this.val$observer != null) {
                try {
                    this.val$observer.onRemoveCompleted(null, retCode >= 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY);
                } catch (RemoteException e) {
                    Slog.w(PackageManagerService.TAG, "RemoveException when invoking call back");
                }
            }
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.2 */
    class C04482 implements Runnable {
        final /* synthetic */ long val$freeStorageSize;
        final /* synthetic */ IntentSender val$pi;

        C04482(long j, IntentSender intentSender) {
            this.val$freeStorageSize = j;
            this.val$pi = intentSender;
        }

        public void run() {
            PackageManagerService.this.mHandler.removeCallbacks(this);
            synchronized (PackageManagerService.this.mInstallLock) {
                int retCode = PackageManagerService.this.mInstaller.freeCache(this.val$freeStorageSize);
                if (retCode < 0) {
                    Slog.w(PackageManagerService.TAG, "Couldn't clear application caches");
                }
            }
            if (this.val$pi != null) {
                try {
                    this.val$pi.sendIntent(null, retCode >= 0 ? PackageManagerService.UPDATE_PERMISSIONS_ALL : PackageManagerService.DEX_OPT_SKIPPED, null, null, null);
                } catch (SendIntentException e) {
                    Slog.i(PackageManagerService.TAG, "Failed to send pending intent");
                }
            }
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.3 */
    class C04493 implements Comparator<Package> {
        C04493() {
        }

        public int compare(Package p1, Package p2) {
            return p1.mOverlayPriority - p2.mOverlayPriority;
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.4 */
    static class C04504 implements Comparator<ResolveInfo> {
        C04504() {
        }

        public int compare(ResolveInfo r1, ResolveInfo r2) {
            int v1 = r1.priority;
            int v2 = r2.priority;
            if (v1 == v2) {
                v1 = r1.preferredOrder;
                v2 = r2.preferredOrder;
                if (v1 != v2) {
                    if (v1 <= v2) {
                        return PackageManagerService.UPDATE_PERMISSIONS_ALL;
                    }
                    return PackageManagerService.DEX_OPT_FAILED;
                } else if (r1.isDefault == r2.isDefault) {
                    v1 = r1.match;
                    v2 = r2.match;
                    if (v1 != v2) {
                        if (v1 <= v2) {
                            return PackageManagerService.UPDATE_PERMISSIONS_ALL;
                        }
                        return PackageManagerService.DEX_OPT_FAILED;
                    } else if (r1.system == r2.system) {
                        return PackageManagerService.DEX_OPT_SKIPPED;
                    } else {
                        if (r1.system) {
                            return PackageManagerService.DEX_OPT_FAILED;
                        }
                        return PackageManagerService.UPDATE_PERMISSIONS_ALL;
                    }
                } else if (r1.isDefault) {
                    return PackageManagerService.DEX_OPT_FAILED;
                } else {
                    return PackageManagerService.UPDATE_PERMISSIONS_ALL;
                }
            } else if (v1 > v2) {
                return PackageManagerService.DEX_OPT_FAILED;
            } else {
                return PackageManagerService.UPDATE_PERMISSIONS_ALL;
            }
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.5 */
    static class C04515 implements Comparator<ProviderInfo> {
        C04515() {
        }

        public int compare(ProviderInfo p1, ProviderInfo p2) {
            int v1 = p1.initOrder;
            int v2 = p2.initOrder;
            if (v1 > v2) {
                return PackageManagerService.DEX_OPT_FAILED;
            }
            return v1 < v2 ? PackageManagerService.UPDATE_PERMISSIONS_ALL : PackageManagerService.DEX_OPT_SKIPPED;
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.6 */
    class C04526 implements Runnable {
        final /* synthetic */ InstallArgs val$args;
        final /* synthetic */ int val$currentStatus;

        C04526(int i, InstallArgs installArgs) {
            this.val$currentStatus = i;
            this.val$args = installArgs;
        }

        public void run() {
            boolean update;
            boolean doRestore;
            PackageManagerService.this.mHandler.removeCallbacks(this);
            PackageInstalledInfo res = new PackageInstalledInfo();
            res.returnCode = this.val$currentStatus;
            res.uid = PackageManagerService.DEX_OPT_FAILED;
            res.pkg = null;
            res.removedInfo = new PackageRemovedInfo();
            if (res.returnCode == PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                this.val$args.doPreInstall(res.returnCode);
                synchronized (PackageManagerService.this.mInstallLock) {
                    PackageManagerService.this.installPackageLI(this.val$args, res);
                }
                this.val$args.doPostInstall(res.returnCode, res.uid);
            }
            if (res.removedInfo.removedPackage != null) {
                update = PackageManagerService.DEFAULT_VERIFY_ENABLE;
            } else {
                update = PackageManagerService.DEBUG_VERIFY;
            }
            int flags = res.pkg == null ? PackageManagerService.DEX_OPT_SKIPPED : res.pkg.applicationInfo.flags;
            if (update || (PackageManagerService.MAX_PERMISSION_TREE_FOOTPRINT & flags) == 0) {
                doRestore = PackageManagerService.DEBUG_VERIFY;
            } else {
                doRestore = PackageManagerService.DEFAULT_VERIFY_ENABLE;
            }
            if (PackageManagerService.this.mNextInstallToken < 0) {
                PackageManagerService.this.mNextInstallToken = PackageManagerService.UPDATE_PERMISSIONS_ALL;
            }
            PackageManagerService packageManagerService = PackageManagerService.this;
            int token = packageManagerService.mNextInstallToken;
            packageManagerService.mNextInstallToken = token + PackageManagerService.UPDATE_PERMISSIONS_ALL;
            PackageManagerService.this.mRunningInstalls.put(token, new PostInstallData(this.val$args, res));
            if (res.returnCode == PackageManagerService.UPDATE_PERMISSIONS_ALL && doRestore) {
                IBackupManager bm = IBackupManager.Stub.asInterface(ServiceManager.getService("backup"));
                if (bm != null) {
                    try {
                        if (bm.isBackupServiceActive(PackageManagerService.DEX_OPT_SKIPPED)) {
                            bm.restoreAtInstall(res.pkg.applicationInfo.packageName, token);
                        } else {
                            doRestore = PackageManagerService.DEBUG_VERIFY;
                        }
                    } catch (RemoteException e) {
                    } catch (Exception e2) {
                        Slog.e(PackageManagerService.TAG, "Exception trying to enqueue restore", e2);
                        doRestore = PackageManagerService.DEBUG_VERIFY;
                    }
                } else {
                    Slog.e(PackageManagerService.TAG, "Backup Manager not found!");
                    doRestore = PackageManagerService.DEBUG_VERIFY;
                }
            }
            if (!doRestore) {
                PackageManagerService.this.mHandler.sendMessage(PackageManagerService.this.mHandler.obtainMessage(PackageManagerService.POST_INSTALL, token, PackageManagerService.DEX_OPT_SKIPPED));
            }
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.7 */
    class C04537 implements FilenameFilter {
        C04537() {
        }

        public boolean accept(File dir, String name) {
            return (name.startsWith("vmdl") && name.endsWith(".tmp")) ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.8 */
    class C04548 implements Runnable {
        final /* synthetic */ int val$flags;
        final /* synthetic */ IPackageDeleteObserver2 val$observer;
        final /* synthetic */ String val$packageName;
        final /* synthetic */ int val$userId;

        C04548(String str, int i, int i2, IPackageDeleteObserver2 iPackageDeleteObserver2) {
            this.val$packageName = str;
            this.val$userId = i;
            this.val$flags = i2;
            this.val$observer = iPackageDeleteObserver2;
        }

        public void run() {
            PackageManagerService.this.mHandler.removeCallbacks(this);
            int returnCode = PackageManagerService.this.deletePackageX(this.val$packageName, this.val$userId, this.val$flags);
            if (this.val$observer != null) {
                try {
                    this.val$observer.onPackageDeleted(this.val$packageName, returnCode, null);
                } catch (RemoteException e) {
                    Log.i(PackageManagerService.TAG, "Observer no longer exists.");
                }
            }
        }
    }

    /* renamed from: com.android.server.pm.PackageManagerService.9 */
    class C04559 implements Runnable {
        final /* synthetic */ IPackageDataObserver val$observer;
        final /* synthetic */ String val$packageName;
        final /* synthetic */ int val$userId;

        C04559(String str, int i, IPackageDataObserver iPackageDataObserver) {
            this.val$packageName = str;
            this.val$userId = i;
            this.val$observer = iPackageDataObserver;
        }

        public void run() {
            PackageManagerService.this.mHandler.removeCallbacks(this);
            synchronized (PackageManagerService.this.mInstallLock) {
                boolean succeeded = PackageManagerService.this.clearApplicationUserDataLI(this.val$packageName, this.val$userId);
            }
            PackageManagerService.this.clearExternalStorageDataSync(this.val$packageName, this.val$userId, PackageManagerService.DEFAULT_VERIFY_ENABLE);
            if (succeeded) {
                DeviceStorageMonitorInternal dsm = (DeviceStorageMonitorInternal) LocalServices.getService(DeviceStorageMonitorInternal.class);
                if (dsm != null) {
                    dsm.checkMemory();
                }
            }
            if (this.val$observer != null) {
                try {
                    this.val$observer.onRemoveCompleted(this.val$packageName, succeeded);
                } catch (RemoteException e) {
                    Log.i(PackageManagerService.TAG, "Observer no longer exists.");
                }
            }
        }
    }

    final class ActivityIntentResolver extends IntentResolver<ActivityIntentInfo, ResolveInfo> {
        private final ArrayMap<ComponentName, Activity> mActivities;
        private int mFlags;

        ActivityIntentResolver() {
            this.mActivities = new ArrayMap();
        }

        public List<ResolveInfo> queryIntent(Intent intent, String resolvedType, boolean defaultOnly, int userId) {
            if (!PackageManagerService.sUserManager.exists(userId)) {
                return null;
            }
            this.mFlags = defaultOnly ? PackageManagerService.REMOVE_CHATTY : PackageManagerService.DEX_OPT_SKIPPED;
            return super.queryIntent(intent, resolvedType, defaultOnly, userId);
        }

        public List<ResolveInfo> queryIntent(Intent intent, String resolvedType, int flags, int userId) {
            if (!PackageManagerService.sUserManager.exists(userId)) {
                return null;
            }
            this.mFlags = flags;
            return super.queryIntent(intent, resolvedType, (PackageManagerService.REMOVE_CHATTY & flags) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY, userId);
        }

        public List<ResolveInfo> queryIntentForPackage(Intent intent, String resolvedType, int flags, ArrayList<Activity> packageActivities, int userId) {
            if (!PackageManagerService.sUserManager.exists(userId) || packageActivities == null) {
                return null;
            }
            this.mFlags = flags;
            boolean defaultOnly = (PackageManagerService.REMOVE_CHATTY & flags) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
            int N = packageActivities.size();
            ArrayList<ActivityIntentInfo[]> listCut = new ArrayList(N);
            for (int i = PackageManagerService.DEX_OPT_SKIPPED; i < N; i += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                ArrayList<ActivityIntentInfo> intentFilters = ((Activity) packageActivities.get(i)).intents;
                if (intentFilters != null && intentFilters.size() > 0) {
                    ActivityIntentInfo[] array = new ActivityIntentInfo[intentFilters.size()];
                    intentFilters.toArray(array);
                    listCut.add(array);
                }
            }
            return super.queryIntentFromList(intent, resolvedType, defaultOnly, listCut, userId);
        }

        public final void addActivity(Activity a, String type) {
            boolean systemApp = PackageManagerService.isSystemApp(a.info.applicationInfo);
            this.mActivities.put(a.getComponentName(), a);
            int NI = a.intents.size();
            for (int j = PackageManagerService.DEX_OPT_SKIPPED; j < NI; j += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                ActivityIntentInfo intent = (ActivityIntentInfo) a.intents.get(j);
                if (!systemApp && intent.getPriority() > 0 && "activity".equals(type)) {
                    intent.setPriority(PackageManagerService.DEX_OPT_SKIPPED);
                    Log.w(PackageManagerService.TAG, "Package " + a.info.applicationInfo.packageName + " has activity " + a.className + " with priority > 0, forcing to 0");
                }
                if (!intent.debugCheck()) {
                    Log.w(PackageManagerService.TAG, "==> For Activity " + a.info.name);
                }
                addFilter(intent);
            }
        }

        public final void removeActivity(Activity a, String type) {
            this.mActivities.remove(a.getComponentName());
            int NI = a.intents.size();
            for (int j = PackageManagerService.DEX_OPT_SKIPPED; j < NI; j += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                removeFilter((ActivityIntentInfo) a.intents.get(j));
            }
        }

        protected boolean allowFilterResult(ActivityIntentInfo filter, List<ResolveInfo> dest) {
            ActivityInfo filterAi = filter.activity.info;
            for (int i = dest.size() + PackageManagerService.DEX_OPT_FAILED; i >= 0; i += PackageManagerService.DEX_OPT_FAILED) {
                ActivityInfo destAi = ((ResolveInfo) dest.get(i)).activityInfo;
                if (destAi.name == filterAi.name && destAi.packageName == filterAi.packageName) {
                    return PackageManagerService.DEBUG_VERIFY;
                }
            }
            return PackageManagerService.DEFAULT_VERIFY_ENABLE;
        }

        protected ActivityIntentInfo[] newArray(int size) {
            return new ActivityIntentInfo[size];
        }

        protected boolean isFilterStopped(ActivityIntentInfo filter, int userId) {
            if (!PackageManagerService.sUserManager.exists(userId)) {
                return PackageManagerService.DEFAULT_VERIFY_ENABLE;
            }
            Package p = filter.activity.owner;
            if (p != null) {
                PackageSetting ps = p.mExtras;
                if (ps != null) {
                    if ((ps.pkgFlags & PackageManagerService.UPDATE_PERMISSIONS_ALL) == 0 && ps.getStopped(userId)) {
                        return PackageManagerService.DEFAULT_VERIFY_ENABLE;
                    }
                    return PackageManagerService.DEBUG_VERIFY;
                }
            }
            return PackageManagerService.DEBUG_VERIFY;
        }

        protected boolean isPackageForFilter(String packageName, ActivityIntentInfo info) {
            return packageName.equals(info.activity.owner.packageName);
        }

        protected ResolveInfo newResult(ActivityIntentInfo info, int match, int userId) {
            ResolveInfo resolveInfo = null;
            if (PackageManagerService.sUserManager.exists(userId) && PackageManagerService.this.mSettings.isEnabledLPr(info.activity.info, this.mFlags, userId)) {
                Activity activity = info.activity;
                if (!(PackageManagerService.this.mSafeMode && (activity.info.applicationInfo.flags & PackageManagerService.UPDATE_PERMISSIONS_ALL) == 0)) {
                    PackageSetting ps = activity.owner.mExtras;
                    if (ps != null) {
                        ActivityInfo ai = PackageParser.generateActivityInfo(activity, this.mFlags, ps.readUserState(userId), userId);
                        if (ai != null) {
                            resolveInfo = new ResolveInfo();
                            resolveInfo.activityInfo = ai;
                            if ((this.mFlags & PackageManagerService.SCAN_UPDATE_TIME) != 0) {
                                resolveInfo.filter = info;
                            }
                            resolveInfo.priority = info.getPriority();
                            resolveInfo.preferredOrder = activity.owner.mPreferredOrder;
                            resolveInfo.match = match;
                            resolveInfo.isDefault = info.hasDefault;
                            resolveInfo.labelRes = info.labelRes;
                            resolveInfo.nonLocalizedLabel = info.nonLocalizedLabel;
                            if (PackageManagerService.this.userNeedsBadging(userId)) {
                                resolveInfo.noResourceId = PackageManagerService.DEFAULT_VERIFY_ENABLE;
                            } else {
                                resolveInfo.icon = info.icon;
                            }
                            resolveInfo.system = PackageManagerService.isSystemApp(resolveInfo.activityInfo.applicationInfo);
                        }
                    }
                }
            }
            return resolveInfo;
        }

        protected void sortResults(List<ResolveInfo> results) {
            Collections.sort(results, PackageManagerService.mResolvePrioritySorter);
        }

        protected void dumpFilter(PrintWriter out, String prefix, ActivityIntentInfo filter) {
            out.print(prefix);
            out.print(Integer.toHexString(System.identityHashCode(filter.activity)));
            out.print(' ');
            filter.activity.printComponentShortName(out);
            out.print(" filter ");
            out.println(Integer.toHexString(System.identityHashCode(filter)));
        }

        protected Object filterToLabel(ActivityIntentInfo filter) {
            return filter.activity;
        }

        protected void dumpFilterLabel(PrintWriter out, String prefix, Object label, int count) {
            Activity activity = (Activity) label;
            out.print(prefix);
            out.print(Integer.toHexString(System.identityHashCode(activity)));
            out.print(' ');
            activity.printComponentShortName(out);
            if (count > PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                out.print(" (");
                out.print(count);
                out.print(" filters)");
            }
            out.println();
        }
    }

    static abstract class InstallArgs {
        final String abiOverride;
        final int installFlags;
        final String installerPackageName;
        String[] instructionSets;
        final ManifestDigest manifestDigest;
        final IPackageInstallObserver2 observer;
        final OriginInfo origin;
        final UserHandle user;

        abstract boolean checkFreeStorage(IMediaContainerService iMediaContainerService) throws RemoteException;

        abstract void cleanUpResourcesLI();

        abstract int copyApk(IMediaContainerService iMediaContainerService, boolean z) throws RemoteException;

        abstract boolean doPostDeleteLI(boolean z);

        abstract int doPostInstall(int i, int i2);

        abstract int doPreInstall(int i);

        abstract boolean doRename(int i, Package packageR, String str);

        abstract String getCodePath();

        abstract String getLegacyNativeLibraryPath();

        abstract String getResourcePath();

        InstallArgs(OriginInfo origin, IPackageInstallObserver2 observer, int installFlags, String installerPackageName, ManifestDigest manifestDigest, UserHandle user, String[] instructionSets, String abiOverride) {
            this.origin = origin;
            this.installFlags = installFlags;
            this.observer = observer;
            this.installerPackageName = installerPackageName;
            this.manifestDigest = manifestDigest;
            this.user = user;
            this.instructionSets = instructionSets;
            this.abiOverride = abiOverride;
        }

        int doPreCopy() {
            return PackageManagerService.UPDATE_PERMISSIONS_ALL;
        }

        int doPostCopy(int uid) {
            return PackageManagerService.UPDATE_PERMISSIONS_ALL;
        }

        protected boolean isFwdLocked() {
            return (this.installFlags & PackageManagerService.UPDATE_PERMISSIONS_ALL) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
        }

        protected boolean isExternal() {
            return (this.installFlags & PackageManagerService.SCAN_UPDATE_SIGNATURE) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
        }

        UserHandle getUser() {
            return this.user;
        }
    }

    class AsecInstallArgs extends InstallArgs {
        static final String PUBLIC_RES_FILE_NAME = "res.zip";
        static final String RES_FILE_NAME = "pkg.apk";
        String cid;
        String legacyNativeLibraryDir;
        String packagePath;
        String resourcePath;

        AsecInstallArgs(InstallParams params) {
            super(params.origin, params.observer, params.installFlags, params.installerPackageName, params.getManifestDigest(), params.getUser(), null, params.packageAbiOverride);
        }

        AsecInstallArgs(String fullCodePath, String[] instructionSets, boolean isExternal, boolean isForwardLocked) {
            super(OriginInfo.fromNothing(), null, (isExternal ? PackageManagerService.SCAN_UPDATE_SIGNATURE : PackageManagerService.DEX_OPT_SKIPPED) | (isForwardLocked ? PackageManagerService.UPDATE_PERMISSIONS_ALL : PackageManagerService.DEX_OPT_SKIPPED), null, null, null, instructionSets, null);
            if (!fullCodePath.endsWith(RES_FILE_NAME)) {
                fullCodePath = new File(fullCodePath, RES_FILE_NAME).getAbsolutePath();
            }
            int eidx = fullCodePath.lastIndexOf("/");
            String subStr1 = fullCodePath.substring(PackageManagerService.DEX_OPT_SKIPPED, eidx);
            this.cid = subStr1.substring(subStr1.lastIndexOf("/") + PackageManagerService.UPDATE_PERMISSIONS_ALL, eidx);
            setMountPath(subStr1);
        }

        AsecInstallArgs(PackageManagerService packageManagerService, String cid, String[] instructionSets, boolean isForwardLocked) {
            int i = PackageManagerService.DEX_OPT_SKIPPED;
            PackageManagerService.this = packageManagerService;
            OriginInfo fromNothing = OriginInfo.fromNothing();
            int i2 = packageManagerService.isAsecExternal(cid) ? PackageManagerService.SCAN_UPDATE_SIGNATURE : PackageManagerService.DEX_OPT_SKIPPED;
            if (isForwardLocked) {
                i = PackageManagerService.UPDATE_PERMISSIONS_ALL;
            }
            super(fromNothing, null, i2 | i, null, null, null, instructionSets, null);
            this.cid = cid;
            setMountPath(PackageHelper.getSdDir(cid));
        }

        void createCopyFile() {
            this.cid = PackageManagerService.this.mInstallerService.allocateExternalStageCidLegacy();
        }

        boolean checkFreeStorage(IMediaContainerService imcs) throws RemoteException {
            File target;
            long sizeBytes = imcs.calculateInstalledSize(this.packagePath, isFwdLocked(), this.abiOverride);
            if (isExternal()) {
                target = new UserEnvironment(PackageManagerService.DEX_OPT_SKIPPED).getExternalStorageDirectory();
            } else {
                target = Environment.getDataDirectory();
            }
            if (sizeBytes <= StorageManager.from(PackageManagerService.this.mContext).getStorageBytesUntilLow(target)) {
                return PackageManagerService.DEFAULT_VERIFY_ENABLE;
            }
            return PackageManagerService.DEBUG_VERIFY;
        }

        int copyApk(IMediaContainerService imcs, boolean temp) throws RemoteException {
            if (this.origin.staged) {
                Slog.d(PackageManagerService.TAG, this.origin.cid + " already staged; skipping copy");
                this.cid = this.origin.cid;
                setMountPath(PackageHelper.getSdDir(this.cid));
                return PackageManagerService.UPDATE_PERMISSIONS_ALL;
            }
            if (temp) {
                createCopyFile();
            } else {
                PackageHelper.destroySdDir(this.cid);
            }
            String newMountPath = imcs.copyPackageToContainer(this.origin.file.getAbsolutePath(), this.cid, PackageManagerService.getEncryptKey(), isExternal(), isFwdLocked(), PackageManagerService.deriveAbiOverride(this.abiOverride, null));
            if (newMountPath == null) {
                return -18;
            }
            setMountPath(newMountPath);
            return PackageManagerService.UPDATE_PERMISSIONS_ALL;
        }

        String getCodePath() {
            return this.packagePath;
        }

        String getResourcePath() {
            return this.resourcePath;
        }

        String getLegacyNativeLibraryPath() {
            return this.legacyNativeLibraryDir;
        }

        int doPreInstall(int status) {
            if (status != PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                PackageHelper.destroySdDir(this.cid);
                return status;
            } else if (PackageHelper.isContainerMounted(this.cid)) {
                return status;
            } else {
                String newMountPath = PackageHelper.mountSdDir(this.cid, PackageManagerService.getEncryptKey(), ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                if (newMountPath == null) {
                    return -18;
                }
                setMountPath(newMountPath);
                return status;
            }
        }

        boolean doRename(int status, Package pkg, String oldCodePath) {
            String newCacheId = PackageManagerService.getNextCodePath(oldCodePath, pkg.packageName, "/pkg.apk");
            if (!PackageHelper.isContainerMounted(this.cid) || PackageHelper.unMountSdDir(this.cid)) {
                String newMountPath;
                if (!PackageHelper.renameSdDir(this.cid, newCacheId)) {
                    Slog.e(PackageManagerService.TAG, "Failed to rename " + this.cid + " to " + newCacheId + " which might be stale. Will try to clean up.");
                    if (!PackageHelper.destroySdDir(newCacheId)) {
                        Slog.e(PackageManagerService.TAG, "Very strange. Cannot clean up stale container " + newCacheId);
                        return PackageManagerService.DEBUG_VERIFY;
                    } else if (!PackageHelper.renameSdDir(this.cid, newCacheId)) {
                        Slog.e(PackageManagerService.TAG, "Failed to rename " + this.cid + " to " + newCacheId + " inspite of cleaning it up.");
                        return PackageManagerService.DEBUG_VERIFY;
                    }
                }
                if (PackageHelper.isContainerMounted(newCacheId)) {
                    newMountPath = PackageHelper.getSdDir(newCacheId);
                } else {
                    Slog.w(PackageManagerService.TAG, "Mounting container " + newCacheId);
                    newMountPath = PackageHelper.mountSdDir(newCacheId, PackageManagerService.getEncryptKey(), ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                }
                if (newMountPath == null) {
                    Slog.w(PackageManagerService.TAG, "Failed to get cache path for  " + newCacheId);
                    return PackageManagerService.DEBUG_VERIFY;
                }
                Log.i(PackageManagerService.TAG, "Succesfully renamed " + this.cid + " to " + newCacheId + " at new path: " + newMountPath);
                this.cid = newCacheId;
                File beforeCodeFile = new File(this.packagePath);
                setMountPath(newMountPath);
                File afterCodeFile = new File(this.packagePath);
                pkg.codePath = afterCodeFile.getAbsolutePath();
                pkg.baseCodePath = FileUtils.rewriteAfterRename(beforeCodeFile, afterCodeFile, pkg.baseCodePath);
                pkg.splitCodePaths = FileUtils.rewriteAfterRename(beforeCodeFile, afterCodeFile, pkg.splitCodePaths);
                pkg.applicationInfo.setCodePath(pkg.codePath);
                pkg.applicationInfo.setBaseCodePath(pkg.baseCodePath);
                pkg.applicationInfo.setSplitCodePaths(pkg.splitCodePaths);
                pkg.applicationInfo.setResourcePath(pkg.codePath);
                pkg.applicationInfo.setBaseResourcePath(pkg.baseCodePath);
                pkg.applicationInfo.setSplitResourcePaths(pkg.splitCodePaths);
                return PackageManagerService.DEFAULT_VERIFY_ENABLE;
            }
            Slog.i(PackageManagerService.TAG, "Failed to unmount " + this.cid + " before renaming");
            return PackageManagerService.DEBUG_VERIFY;
        }

        private void setMountPath(String mountPath) {
            File mountFile = new File(mountPath);
            File monolithicFile = new File(mountFile, RES_FILE_NAME);
            if (monolithicFile.exists()) {
                this.packagePath = monolithicFile.getAbsolutePath();
                if (isFwdLocked()) {
                    this.resourcePath = new File(mountFile, PUBLIC_RES_FILE_NAME).getAbsolutePath();
                } else {
                    this.resourcePath = this.packagePath;
                }
            } else {
                this.packagePath = mountFile.getAbsolutePath();
                this.resourcePath = this.packagePath;
            }
            this.legacyNativeLibraryDir = new File(mountFile, "lib").getAbsolutePath();
        }

        int doPostInstall(int status, int uid) {
            if (status != PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                cleanUp();
                return status;
            }
            int groupOwner;
            String protectedFile;
            if (isFwdLocked()) {
                groupOwner = UserHandle.getSharedAppGid(uid);
                protectedFile = RES_FILE_NAME;
            } else {
                groupOwner = PackageManagerService.DEX_OPT_FAILED;
                protectedFile = null;
            }
            if (uid < PackageManagerService.WRITE_SETTINGS_DELAY || !PackageHelper.fixSdPermissions(this.cid, groupOwner, protectedFile)) {
                Slog.e(PackageManagerService.TAG, "Failed to finalize " + this.cid);
                PackageHelper.destroySdDir(this.cid);
                return -18;
            } else if (PackageHelper.isContainerMounted(this.cid)) {
                return status;
            } else {
                PackageHelper.mountSdDir(this.cid, PackageManagerService.getEncryptKey(), Process.myUid());
                return status;
            }
        }

        private void cleanUp() {
            PackageHelper.destroySdDir(this.cid);
        }

        private List<String> getAllCodePaths() {
            File codeFile = new File(getCodePath());
            if (codeFile != null && codeFile.exists()) {
                try {
                    return PackageParser.parsePackageLite(codeFile, PackageManagerService.DEX_OPT_SKIPPED).getAllCodePaths();
                } catch (PackageParserException e) {
                }
            }
            return Collections.EMPTY_LIST;
        }

        void cleanUpResourcesLI() {
            cleanUpResourcesLI(getAllCodePaths());
        }

        private void cleanUpResourcesLI(List<String> allCodePaths) {
            cleanUp();
            if (!allCodePaths.isEmpty()) {
                if (this.instructionSets == null) {
                    throw new IllegalStateException("instructionSet == null");
                }
                String[] dexCodeInstructionSets = PackageManagerService.getDexCodeInstructionSets(this.instructionSets);
                for (String codePath : allCodePaths) {
                    String[] arr$ = dexCodeInstructionSets;
                    int len$ = arr$.length;
                    for (int i$ = PackageManagerService.DEX_OPT_SKIPPED; i$ < len$; i$ += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                        int retCode = PackageManagerService.this.mInstaller.rmdex(codePath, arr$[i$]);
                        if (retCode < 0) {
                            Slog.w(PackageManagerService.TAG, "Couldn't remove dex file for package:  at location " + codePath + ", retcode=" + retCode);
                        }
                    }
                }
            }
        }

        boolean matchContainer(String app) {
            if (this.cid.startsWith(app)) {
                return PackageManagerService.DEFAULT_VERIFY_ENABLE;
            }
            return PackageManagerService.DEBUG_VERIFY;
        }

        String getPackageName() {
            return PackageManagerService.getAsecPackageName(this.cid);
        }

        boolean doPostDeleteLI(boolean delete) {
            List<String> allCodePaths = getAllCodePaths();
            boolean mounted = PackageHelper.isContainerMounted(this.cid);
            if (mounted && PackageHelper.unMountSdDir(this.cid)) {
                mounted = PackageManagerService.DEBUG_VERIFY;
            }
            if (!mounted && delete) {
                cleanUpResourcesLI(allCodePaths);
            }
            return !mounted ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
        }

        int doPreCopy() {
            if (!isFwdLocked() || PackageHelper.fixSdPermissions(this.cid, PackageManagerService.this.getPackageUid(PackageManagerService.DEFAULT_CONTAINER_PACKAGE, PackageManagerService.DEX_OPT_SKIPPED), RES_FILE_NAME)) {
                return PackageManagerService.UPDATE_PERMISSIONS_ALL;
            }
            return -18;
        }

        int doPostCopy(int uid) {
            if (!isFwdLocked() || (uid >= PackageManagerService.WRITE_SETTINGS_DELAY && PackageHelper.fixSdPermissions(this.cid, UserHandle.getSharedAppGid(uid), RES_FILE_NAME))) {
                return PackageManagerService.UPDATE_PERMISSIONS_ALL;
            }
            Slog.e(PackageManagerService.TAG, "Failed to finalize " + this.cid);
            PackageHelper.destroySdDir(this.cid);
            return -18;
        }
    }

    private final class ClearStorageConnection implements ServiceConnection {
        IMediaContainerService mContainerService;

        private ClearStorageConnection() {
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            synchronized (this) {
                this.mContainerService = IMediaContainerService.Stub.asInterface(service);
                notifyAll();
            }
        }

        public void onServiceDisconnected(ComponentName name) {
        }
    }

    class DefaultContainerConnection implements ServiceConnection {
        DefaultContainerConnection() {
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            PackageManagerService.this.mHandler.sendMessage(PackageManagerService.this.mHandler.obtainMessage(PackageManagerService.MCS_BOUND, IMediaContainerService.Stub.asInterface(service)));
        }

        public void onServiceDisconnected(ComponentName name) {
        }
    }

    static class DumpState {
        public static final int DUMP_FEATURES = 2;
        public static final int DUMP_INSTALLS = 8192;
        public static final int DUMP_KEYSETS = 2048;
        public static final int DUMP_LIBS = 1;
        public static final int DUMP_MESSAGES = 64;
        public static final int DUMP_PACKAGES = 16;
        public static final int DUMP_PERMISSIONS = 8;
        public static final int DUMP_PREFERRED = 512;
        public static final int DUMP_PREFERRED_XML = 1024;
        public static final int DUMP_PROVIDERS = 128;
        public static final int DUMP_RESOLVERS = 4;
        public static final int DUMP_SHARED_USERS = 32;
        public static final int DUMP_VERIFIERS = 256;
        public static final int DUMP_VERSION = 4096;
        public static final int OPTION_SHOW_FILTERS = 1;
        private int mOptions;
        private SharedUserSetting mSharedUser;
        private boolean mTitlePrinted;
        private int mTypes;

        DumpState() {
        }

        public boolean isDumping(int type) {
            if ((this.mTypes != 0 || type == DUMP_PREFERRED_XML) && (this.mTypes & type) == 0) {
                return PackageManagerService.DEBUG_VERIFY;
            }
            return PackageManagerService.DEFAULT_VERIFY_ENABLE;
        }

        public void setDump(int type) {
            this.mTypes |= type;
        }

        public boolean isOptionEnabled(int option) {
            return (this.mOptions & option) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
        }

        public void setOptionEnabled(int option) {
            this.mOptions |= option;
        }

        public boolean onTitlePrinted() {
            boolean printed = this.mTitlePrinted;
            this.mTitlePrinted = PackageManagerService.DEFAULT_VERIFY_ENABLE;
            return printed;
        }

        public boolean getTitlePrinted() {
            return this.mTitlePrinted;
        }

        public void setTitlePrinted(boolean enabled) {
            this.mTitlePrinted = enabled;
        }

        public SharedUserSetting getSharedUser() {
            return this.mSharedUser;
        }

        public void setSharedUser(SharedUserSetting user) {
            this.mSharedUser = user;
        }
    }

    class FileInstallArgs extends InstallArgs {
        private File codeFile;
        private File legacyNativeLibraryPath;
        private File resourceFile;

        /* renamed from: com.android.server.pm.PackageManagerService.FileInstallArgs.1 */
        class C04561 extends IParcelFileDescriptorFactory.Stub {
            C04561() {
            }

            public ParcelFileDescriptor open(String name, int mode) throws RemoteException {
                if (FileUtils.isValidExtFilename(name)) {
                    try {
                        File file = new File(FileInstallArgs.this.codeFile, name);
                        FileDescriptor fd = Os.open(file.getAbsolutePath(), OsConstants.O_RDWR | OsConstants.O_CREAT, 420);
                        Os.chmod(file.getAbsolutePath(), 420);
                        return new ParcelFileDescriptor(fd);
                    } catch (ErrnoException e) {
                        throw new RemoteException("Failed to open: " + e.getMessage());
                    }
                }
                throw new IllegalArgumentException("Invalid filename: " + name);
            }
        }

        int copyApk(com.android.internal.app.IMediaContainerService r11, boolean r12) throws android.os.RemoteException {
            /* JADX: method processing error */
/*
            Error: jadx.core.utils.exceptions.JadxRuntimeException: Can't find immediate dominator for block B:25:? in {17, 19, 20, 21, 22, 23, 24, 26, 27} preds:[]
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeDominators(BlockProcessor.java:129)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.processBlocksTree(BlockProcessor.java:48)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.rerun(BlockProcessor.java:44)
	at jadx.core.dex.visitors.blocksmaker.BlockFinallyExtract.visit(BlockFinallyExtract.java:57)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:14)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.core.ProcessClass.processDependencies(ProcessClass.java:59)
	at jadx.core.ProcessClass.process(ProcessClass.java:42)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
            /*
            r10 = this;
            r6 = 1;
            r7 = r10.origin;
            r7 = r7.staged;
            if (r7 == 0) goto L_0x0031;
        L_0x0007:
            r7 = "PackageManager";
            r8 = new java.lang.StringBuilder;
            r8.<init>();
            r9 = r10.origin;
            r9 = r9.file;
            r8 = r8.append(r9);
            r9 = " already staged; skipping copy";
            r8 = r8.append(r9);
            r8 = r8.toString();
            android.util.Slog.d(r7, r8);
            r7 = r10.origin;
            r7 = r7.file;
            r10.codeFile = r7;
            r7 = r10.origin;
            r7 = r7.file;
            r10.resourceFile = r7;
            r3 = r6;
        L_0x0030:
            return r3;
        L_0x0031:
            r7 = com.android.server.pm.PackageManagerService.this;	 Catch:{ IOException -> 0x0059 }
            r7 = r7.mInstallerService;	 Catch:{ IOException -> 0x0059 }
            r5 = r7.allocateInternalStageDirLegacy();	 Catch:{ IOException -> 0x0059 }
            r10.codeFile = r5;	 Catch:{ IOException -> 0x0059 }
            r10.resourceFile = r5;	 Catch:{ IOException -> 0x0059 }
            r4 = new com.android.server.pm.PackageManagerService$FileInstallArgs$1;
            r4.<init>();
            r3 = 1;
            r7 = r10.origin;
            r7 = r7.file;
            r7 = r7.getAbsolutePath();
            r3 = r11.copyPackage(r7, r4);
            if (r3 == r6) goto L_0x0074;
        L_0x0051:
            r6 = "PackageManager";
            r7 = "Failed to copy package";
            android.util.Slog.e(r6, r7);
            goto L_0x0030;
        L_0x0059:
            r0 = move-exception;
            r6 = "PackageManager";
            r7 = new java.lang.StringBuilder;
            r7.<init>();
            r8 = "Failed to create copy file: ";
            r7 = r7.append(r8);
            r7 = r7.append(r0);
            r7 = r7.toString();
            android.util.Slog.w(r6, r7);
            r3 = -4;
            goto L_0x0030;
        L_0x0074:
            r2 = new java.io.File;
            r6 = r10.codeFile;
            r7 = "lib";
            r2.<init>(r6, r7);
            r1 = 0;
            r6 = r10.codeFile;	 Catch:{ IOException -> 0x008e, all -> 0x009c }
            r1 = com.android.internal.content.NativeLibraryHelper.Handle.create(r6);	 Catch:{ IOException -> 0x008e, all -> 0x009c }
            r6 = r10.abiOverride;	 Catch:{ IOException -> 0x008e, all -> 0x009c }
            r3 = com.android.internal.content.NativeLibraryHelper.copyNativeBinariesWithOverride(r1, r2, r6);	 Catch:{ IOException -> 0x008e, all -> 0x009c }
            libcore.io.IoUtils.closeQuietly(r1);
            goto L_0x0030;
        L_0x008e:
            r0 = move-exception;
            r6 = "PackageManager";	 Catch:{ IOException -> 0x008e, all -> 0x009c }
            r7 = "Copying native libraries failed";	 Catch:{ IOException -> 0x008e, all -> 0x009c }
            android.util.Slog.e(r6, r7, r0);	 Catch:{ IOException -> 0x008e, all -> 0x009c }
            r3 = -110; // 0xffffffffffffff92 float:NaN double:NaN;
            libcore.io.IoUtils.closeQuietly(r1);
            goto L_0x0030;
        L_0x009c:
            r6 = move-exception;
            libcore.io.IoUtils.closeQuietly(r1);
            throw r6;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageManagerService.FileInstallArgs.copyApk(com.android.internal.app.IMediaContainerService, boolean):int");
        }

        FileInstallArgs(InstallParams params) {
            super(params.origin, params.observer, params.installFlags, params.installerPackageName, params.getManifestDigest(), params.getUser(), null, params.packageAbiOverride);
            if (isFwdLocked()) {
                throw new IllegalArgumentException("Forward locking only supported in ASEC");
            }
        }

        FileInstallArgs(PackageManagerService packageManagerService, String codePath, String resourcePath, String legacyNativeLibraryPath, String[] instructionSets) {
            File file;
            File file2 = null;
            PackageManagerService.this = packageManagerService;
            super(OriginInfo.fromNothing(), null, PackageManagerService.DEX_OPT_SKIPPED, null, null, null, instructionSets, null);
            if (codePath != null) {
                file = new File(codePath);
            } else {
                file = null;
            }
            this.codeFile = file;
            if (resourcePath != null) {
                file = new File(resourcePath);
            } else {
                file = null;
            }
            this.resourceFile = file;
            if (legacyNativeLibraryPath != null) {
                file2 = new File(legacyNativeLibraryPath);
            }
            this.legacyNativeLibraryPath = file2;
        }

        boolean checkFreeStorage(IMediaContainerService imcs) throws RemoteException {
            return imcs.calculateInstalledSize(this.origin.file.getAbsolutePath(), isFwdLocked(), this.abiOverride) <= StorageManager.from(PackageManagerService.this.mContext).getStorageBytesUntilLow(Environment.getDataDirectory()) ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
        }

        int doPreInstall(int status) {
            if (status != PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                cleanUp();
            }
            return status;
        }

        boolean doRename(int status, Package pkg, String oldCodePath) {
            if (status != PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                cleanUp();
                return PackageManagerService.DEBUG_VERIFY;
            }
            File beforeCodeFile = this.codeFile;
            File afterCodeFile = PackageManagerService.this.getNextCodePath(pkg.packageName);
            Slog.d(PackageManagerService.TAG, "Renaming " + beforeCodeFile + " to " + afterCodeFile);
            try {
                Os.rename(beforeCodeFile.getAbsolutePath(), afterCodeFile.getAbsolutePath());
                if (SELinux.restoreconRecursive(afterCodeFile)) {
                    this.codeFile = afterCodeFile;
                    this.resourceFile = afterCodeFile;
                    pkg.codePath = afterCodeFile.getAbsolutePath();
                    pkg.baseCodePath = FileUtils.rewriteAfterRename(beforeCodeFile, afterCodeFile, pkg.baseCodePath);
                    pkg.splitCodePaths = FileUtils.rewriteAfterRename(beforeCodeFile, afterCodeFile, pkg.splitCodePaths);
                    pkg.applicationInfo.setCodePath(pkg.codePath);
                    pkg.applicationInfo.setBaseCodePath(pkg.baseCodePath);
                    pkg.applicationInfo.setSplitCodePaths(pkg.splitCodePaths);
                    pkg.applicationInfo.setResourcePath(pkg.codePath);
                    pkg.applicationInfo.setBaseResourcePath(pkg.baseCodePath);
                    pkg.applicationInfo.setSplitResourcePaths(pkg.splitCodePaths);
                    return PackageManagerService.DEFAULT_VERIFY_ENABLE;
                }
                Slog.d(PackageManagerService.TAG, "Failed to restorecon");
                return PackageManagerService.DEBUG_VERIFY;
            } catch (ErrnoException e) {
                Slog.d(PackageManagerService.TAG, "Failed to rename", e);
                return PackageManagerService.DEBUG_VERIFY;
            }
        }

        int doPostInstall(int status, int uid) {
            if (status != PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                cleanUp();
            }
            return status;
        }

        String getCodePath() {
            return this.codeFile != null ? this.codeFile.getAbsolutePath() : null;
        }

        String getResourcePath() {
            return this.resourceFile != null ? this.resourceFile.getAbsolutePath() : null;
        }

        String getLegacyNativeLibraryPath() {
            return this.legacyNativeLibraryPath != null ? this.legacyNativeLibraryPath.getAbsolutePath() : null;
        }

        private boolean cleanUp() {
            if (this.codeFile == null || !this.codeFile.exists()) {
                return PackageManagerService.DEBUG_VERIFY;
            }
            if (this.codeFile.isDirectory()) {
                FileUtils.deleteContents(this.codeFile);
            }
            this.codeFile.delete();
            if (!(this.resourceFile == null || FileUtils.contains(this.codeFile, this.resourceFile))) {
                this.resourceFile.delete();
            }
            if (!(this.legacyNativeLibraryPath == null || FileUtils.contains(this.codeFile, this.legacyNativeLibraryPath))) {
                if (!FileUtils.deleteContents(this.legacyNativeLibraryPath)) {
                    Slog.w(PackageManagerService.TAG, "Couldn't delete native library directory " + this.legacyNativeLibraryPath);
                }
                this.legacyNativeLibraryPath.delete();
            }
            return PackageManagerService.DEFAULT_VERIFY_ENABLE;
        }

        void cleanUpResourcesLI() {
            List<String> allCodePaths = Collections.EMPTY_LIST;
            if (this.codeFile != null && this.codeFile.exists()) {
                try {
                    allCodePaths = PackageParser.parsePackageLite(this.codeFile, PackageManagerService.DEX_OPT_SKIPPED).getAllCodePaths();
                } catch (PackageParserException e) {
                }
            }
            cleanUp();
            if (!allCodePaths.isEmpty()) {
                if (this.instructionSets == null) {
                    throw new IllegalStateException("instructionSet == null");
                }
                String[] dexCodeInstructionSets = PackageManagerService.getDexCodeInstructionSets(this.instructionSets);
                for (String codePath : allCodePaths) {
                    String[] arr$ = dexCodeInstructionSets;
                    int len$ = arr$.length;
                    for (int i$ = PackageManagerService.DEX_OPT_SKIPPED; i$ < len$; i$ += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                        int retCode = PackageManagerService.this.mInstaller.rmdex(codePath, arr$[i$]);
                        if (retCode < 0) {
                            Slog.w(PackageManagerService.TAG, "Couldn't remove dex file for package:  at location " + codePath + ", retcode=" + retCode);
                        }
                    }
                }
            }
        }

        boolean doPostDeleteLI(boolean delete) {
            cleanUpResourcesLI();
            return PackageManagerService.DEFAULT_VERIFY_ENABLE;
        }
    }

    private abstract class HandlerParams {
        private static final int MAX_RETRIES = 4;
        private int mRetries;
        private final UserHandle mUser;

        abstract void handleReturnCode();

        abstract void handleServiceError();

        abstract void handleStartCopy() throws RemoteException;

        HandlerParams(UserHandle user) {
            this.mRetries = PackageManagerService.DEX_OPT_SKIPPED;
            this.mUser = user;
        }

        UserHandle getUser() {
            return this.mUser;
        }

        final boolean startCopy() {
            boolean res;
            try {
                int i = this.mRetries + PackageManagerService.UPDATE_PERMISSIONS_ALL;
                this.mRetries = i;
                if (i > MAX_RETRIES) {
                    Slog.w(PackageManagerService.TAG, "Failed to invoke remote methods on default container service. Giving up");
                    PackageManagerService.this.mHandler.sendEmptyMessage(PackageManagerService.MCS_GIVE_UP);
                    handleServiceError();
                    return PackageManagerService.DEBUG_VERIFY;
                }
                handleStartCopy();
                res = PackageManagerService.DEFAULT_VERIFY_ENABLE;
                handleReturnCode();
                return res;
            } catch (RemoteException e) {
                PackageManagerService.this.mHandler.sendEmptyMessage(PackageManagerService.MCS_RECONNECT);
                res = PackageManagerService.DEBUG_VERIFY;
            }
        }

        final void serviceError() {
            handleServiceError();
            handleReturnCode();
        }
    }

    class InstallParams extends HandlerParams {
        int installFlags;
        final String installerPackageName;
        private InstallArgs mArgs;
        private int mRet;
        final IPackageInstallObserver2 observer;
        final OriginInfo origin;
        final String packageAbiOverride;
        final VerificationParams verificationParams;

        /* renamed from: com.android.server.pm.PackageManagerService.InstallParams.1 */
        class C04571 extends BroadcastReceiver {
            final /* synthetic */ int val$verificationId;

            C04571(int i) {
                this.val$verificationId = i;
            }

            public void onReceive(Context context, Intent intent) {
                Message msg = PackageManagerService.this.mHandler.obtainMessage(PackageManagerService.SCAN_NEW_INSTALL);
                msg.arg1 = this.val$verificationId;
                PackageManagerService.this.mHandler.sendMessageDelayed(msg, PackageManagerService.this.getVerificationTimeout());
            }
        }

        InstallParams(OriginInfo origin, IPackageInstallObserver2 observer, int installFlags, String installerPackageName, VerificationParams verificationParams, UserHandle user, String packageAbiOverride) {
            super(user);
            this.origin = origin;
            this.observer = observer;
            this.installFlags = installFlags;
            this.installerPackageName = installerPackageName;
            this.verificationParams = verificationParams;
            this.packageAbiOverride = packageAbiOverride;
        }

        public String toString() {
            return "InstallParams{" + Integer.toHexString(System.identityHashCode(this)) + " file=" + this.origin.file + " cid=" + this.origin.cid + "}";
        }

        public ManifestDigest getManifestDigest() {
            if (this.verificationParams == null) {
                return null;
            }
            return this.verificationParams.getManifestDigest();
        }

        private int installLocationPolicy(PackageInfoLite pkgLite) {
            String packageName = pkgLite.packageName;
            int installLocation = pkgLite.installLocation;
            boolean onSd = (this.installFlags & PackageManagerService.SCAN_UPDATE_SIGNATURE) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
            synchronized (PackageManagerService.this.mPackages) {
                Package pkg = (Package) PackageManagerService.this.mPackages.get(packageName);
                if (pkg != null) {
                    if ((this.installFlags & PackageManagerService.UPDATE_PERMISSIONS_REPLACE_PKG) != 0) {
                        if ((this.installFlags & PackageManagerService.SCAN_DEFER_DEX) == 0) {
                            try {
                                PackageManagerService.checkDowngrade(pkg, pkgLite);
                            } catch (PackageManagerException e) {
                                Slog.w(PackageManagerService.TAG, "Downgrade detected: " + e.getMessage());
                                return -7;
                            }
                        }
                        if ((pkg.applicationInfo.flags & PackageManagerService.UPDATE_PERMISSIONS_ALL) != 0) {
                            if (onSd) {
                                Slog.w(PackageManagerService.TAG, "Cannot install update to system app on sdcard");
                                return -3;
                            }
                            return PackageManagerService.UPDATE_PERMISSIONS_ALL;
                        } else if (onSd) {
                            return PackageManagerService.UPDATE_PERMISSIONS_REPLACE_PKG;
                        } else if (installLocation == PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                            return PackageManagerService.UPDATE_PERMISSIONS_ALL;
                        } else if (installLocation != PackageManagerService.UPDATE_PERMISSIONS_REPLACE_PKG) {
                            if (PackageManagerService.isExternal(pkg)) {
                                return PackageManagerService.UPDATE_PERMISSIONS_REPLACE_PKG;
                            }
                            return PackageManagerService.UPDATE_PERMISSIONS_ALL;
                        }
                    }
                    return -4;
                }
                if (onSd) {
                    return PackageManagerService.UPDATE_PERMISSIONS_REPLACE_PKG;
                }
                return pkgLite.recommendedInstallLocation;
            }
        }

        public void handleStartCopy() throws RemoteException {
            int ret = PackageManagerService.UPDATE_PERMISSIONS_ALL;
            if (this.origin.staged) {
                if (this.origin.file != null) {
                    this.installFlags |= PackageManagerService.SCAN_NEW_INSTALL;
                    this.installFlags &= -9;
                } else if (this.origin.cid != null) {
                    this.installFlags |= PackageManagerService.SCAN_UPDATE_SIGNATURE;
                    this.installFlags &= -17;
                } else {
                    throw new IllegalStateException("Invalid stage location");
                }
            }
            boolean onSd = (this.installFlags & PackageManagerService.SCAN_UPDATE_SIGNATURE) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
            boolean onInt = (this.installFlags & PackageManagerService.SCAN_NEW_INSTALL) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
            PackageInfoLite pkgLite = null;
            if (onInt && onSd) {
                Slog.w(PackageManagerService.TAG, "Conflicting flags specified for installing on both internal and external");
                ret = -19;
            } else {
                pkgLite = PackageManagerService.this.mContainerService.getMinimalPackageInfo(this.origin.resolvedPath, this.installFlags, this.packageAbiOverride);
                if (!this.origin.staged && pkgLite.recommendedInstallLocation == PackageManagerService.DEX_OPT_FAILED) {
                    if (PackageManagerService.this.mInstaller.freeCache(PackageManagerService.this.mContainerService.calculateInstalledSize(this.origin.resolvedPath, isForwardLocked(), this.packageAbiOverride) + StorageManager.from(PackageManagerService.this.mContext).getStorageLowBytes(Environment.getDataDirectory())) >= 0) {
                        pkgLite = PackageManagerService.this.mContainerService.getMinimalPackageInfo(this.origin.resolvedPath, this.installFlags, this.packageAbiOverride);
                    }
                    if (pkgLite.recommendedInstallLocation == -6) {
                        pkgLite.recommendedInstallLocation = PackageManagerService.DEX_OPT_FAILED;
                    }
                }
            }
            if (ret == PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                int loc = pkgLite.recommendedInstallLocation;
                if (loc == -3) {
                    ret = -19;
                } else if (loc == -4) {
                    ret = PackageManagerService.DEX_OPT_FAILED;
                } else if (loc == PackageManagerService.DEX_OPT_FAILED) {
                    ret = -4;
                } else if (loc == -2) {
                    ret = -2;
                } else if (loc == -6) {
                    ret = -3;
                } else if (loc == -5) {
                    ret = -20;
                } else {
                    loc = installLocationPolicy(pkgLite);
                    if (loc == -7) {
                        ret = -25;
                    } else if (!(onSd || onInt)) {
                        if (loc == PackageManagerService.UPDATE_PERMISSIONS_REPLACE_PKG) {
                            this.installFlags |= PackageManagerService.SCAN_UPDATE_SIGNATURE;
                            this.installFlags &= -17;
                        } else {
                            this.installFlags |= PackageManagerService.SCAN_NEW_INSTALL;
                            this.installFlags &= -9;
                        }
                    }
                }
            }
            InstallArgs args = PackageManagerService.this.createInstallArgs(this);
            this.mArgs = args;
            if (ret == PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                int requiredUid;
                int userIdentifier = getUser().getIdentifier();
                if (userIdentifier == PackageManagerService.DEX_OPT_FAILED && (this.installFlags & PackageManagerService.SCAN_NO_PATHS) != 0) {
                    userIdentifier = PackageManagerService.DEX_OPT_SKIPPED;
                }
                if (PackageManagerService.this.mRequiredVerifierPackage == null) {
                    requiredUid = PackageManagerService.DEX_OPT_FAILED;
                } else {
                    requiredUid = PackageManagerService.this.getPackageUid(PackageManagerService.this.mRequiredVerifierPackage, userIdentifier);
                }
                if (!(this.origin.existing || requiredUid == PackageManagerService.DEX_OPT_FAILED)) {
                    if (PackageManagerService.this.isVerificationEnabled(userIdentifier, this.installFlags)) {
                        Intent verification = new Intent("android.intent.action.PACKAGE_NEEDS_VERIFICATION");
                        verification.addFlags(268435456);
                        verification.setDataAndType(Uri.fromFile(new File(this.origin.resolvedPath)), PackageManagerService.PACKAGE_MIME_TYPE);
                        verification.addFlags(PackageManagerService.UPDATE_PERMISSIONS_ALL);
                        List<ResolveInfo> receivers = PackageManagerService.this.queryIntentReceivers(verification, PackageManagerService.PACKAGE_MIME_TYPE, PackageManagerService.SCAN_TRUSTED_OVERLAY, PackageManagerService.DEX_OPT_SKIPPED);
                        int verificationId = PackageManagerService.this.mPendingVerificationToken = PackageManagerService.this.mPendingVerificationToken + PackageManagerService.UPDATE_PERMISSIONS_ALL;
                        verification.putExtra("android.content.pm.extra.VERIFICATION_ID", verificationId);
                        verification.putExtra("android.content.pm.extra.VERIFICATION_INSTALLER_PACKAGE", this.installerPackageName);
                        verification.putExtra("android.content.pm.extra.VERIFICATION_INSTALL_FLAGS", this.installFlags);
                        verification.putExtra("android.content.pm.extra.VERIFICATION_PACKAGE_NAME", pkgLite.packageName);
                        verification.putExtra("android.content.pm.extra.VERIFICATION_VERSION_CODE", pkgLite.versionCode);
                        if (this.verificationParams != null) {
                            if (this.verificationParams.getVerificationURI() != null) {
                                verification.putExtra("android.content.pm.extra.VERIFICATION_URI", this.verificationParams.getVerificationURI());
                            }
                            if (this.verificationParams.getOriginatingURI() != null) {
                                verification.putExtra("android.intent.extra.ORIGINATING_URI", this.verificationParams.getOriginatingURI());
                            }
                            if (this.verificationParams.getReferrer() != null) {
                                verification.putExtra("android.intent.extra.REFERRER", this.verificationParams.getReferrer());
                            }
                            if (this.verificationParams.getOriginatingUid() >= 0) {
                                verification.putExtra("android.intent.extra.ORIGINATING_UID", this.verificationParams.getOriginatingUid());
                            }
                            if (this.verificationParams.getInstallerUid() >= 0) {
                                verification.putExtra("android.content.pm.extra.VERIFICATION_INSTALLER_UID", this.verificationParams.getInstallerUid());
                            }
                        }
                        PackageVerificationState packageVerificationState = new PackageVerificationState(requiredUid, args);
                        PackageManagerService.this.mPendingVerification.append(verificationId, packageVerificationState);
                        List<ComponentName> sufficientVerifiers = PackageManagerService.this.matchVerifiers(pkgLite, receivers, packageVerificationState);
                        if (sufficientVerifiers != null) {
                            int N = sufficientVerifiers.size();
                            if (N == 0) {
                                Slog.i(PackageManagerService.TAG, "Additional verifiers required, but none installed.");
                                ret = -22;
                            } else {
                                for (int i = PackageManagerService.DEX_OPT_SKIPPED; i < N; i += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                                    ComponentName verifierComponent = (ComponentName) sufficientVerifiers.get(i);
                                    Intent intent = new Intent(verification);
                                    intent.setComponent(verifierComponent);
                                    PackageManagerService.this.mContext.sendBroadcastAsUser(intent, getUser());
                                }
                            }
                        }
                        ComponentName requiredVerifierComponent = PackageManagerService.this.matchComponentForVerifier(PackageManagerService.this.mRequiredVerifierPackage, receivers);
                        if (ret == PackageManagerService.UPDATE_PERMISSIONS_ALL && PackageManagerService.this.mRequiredVerifierPackage != null) {
                            verification.setComponent(requiredVerifierComponent);
                            PackageManagerService.this.mContext.sendOrderedBroadcastAsUser(verification, getUser(), "android.permission.PACKAGE_VERIFICATION_AGENT", new C04571(verificationId), null, PackageManagerService.DEX_OPT_SKIPPED, null, null);
                            this.mArgs = null;
                        }
                    }
                }
                ret = args.copyApk(PackageManagerService.this.mContainerService, PackageManagerService.DEFAULT_VERIFY_ENABLE);
            }
            this.mRet = ret;
        }

        void handleReturnCode() {
            if (this.mArgs != null) {
                PackageManagerService.this.processPendingInstall(this.mArgs, this.mRet);
            }
        }

        void handleServiceError() {
            this.mArgs = PackageManagerService.this.createInstallArgs(this);
            this.mRet = -110;
        }

        public boolean isForwardLocked() {
            return (this.installFlags & PackageManagerService.UPDATE_PERMISSIONS_ALL) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
        }
    }

    class MeasureParams extends HandlerParams {
        private final IPackageStatsObserver mObserver;
        private final PackageStats mStats;
        private boolean mSuccess;

        public MeasureParams(PackageStats stats, IPackageStatsObserver observer) {
            super(new UserHandle(stats.userHandle));
            this.mObserver = observer;
            this.mStats = stats;
        }

        public String toString() {
            return "MeasureParams{" + Integer.toHexString(System.identityHashCode(this)) + " " + this.mStats.packageName + "}";
        }

        void handleStartCopy() throws RemoteException {
            synchronized (PackageManagerService.this.mInstallLock) {
                this.mSuccess = PackageManagerService.this.getPackageSizeInfoLI(this.mStats.packageName, this.mStats.userHandle, this.mStats);
            }
            if (this.mSuccess) {
                boolean mounted;
                if (Environment.isExternalStorageEmulated()) {
                    mounted = PackageManagerService.DEFAULT_VERIFY_ENABLE;
                } else {
                    String status = Environment.getExternalStorageState();
                    mounted = ("mounted".equals(status) || "mounted_ro".equals(status)) ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
                }
                if (mounted) {
                    UserEnvironment userEnv = new UserEnvironment(this.mStats.userHandle);
                    this.mStats.externalCacheSize = PackageManagerService.calculateDirectorySize(PackageManagerService.this.mContainerService, userEnv.buildExternalStorageAppCacheDirs(this.mStats.packageName));
                    this.mStats.externalDataSize = PackageManagerService.calculateDirectorySize(PackageManagerService.this.mContainerService, userEnv.buildExternalStorageAppDataDirs(this.mStats.packageName));
                    PackageStats packageStats = this.mStats;
                    packageStats.externalDataSize -= this.mStats.externalCacheSize;
                    this.mStats.externalMediaSize = PackageManagerService.calculateDirectorySize(PackageManagerService.this.mContainerService, userEnv.buildExternalStorageAppMediaDirs(this.mStats.packageName));
                    this.mStats.externalObbSize = PackageManagerService.calculateDirectorySize(PackageManagerService.this.mContainerService, userEnv.buildExternalStorageAppObbDirs(this.mStats.packageName));
                }
            }
        }

        void handleReturnCode() {
            if (this.mObserver != null) {
                try {
                    this.mObserver.onGetStatsCompleted(this.mStats, this.mSuccess);
                } catch (RemoteException e) {
                    Slog.i(PackageManagerService.TAG, "Observer no longer exists.");
                }
            }
        }

        void handleServiceError() {
            Slog.e(PackageManagerService.TAG, "Could not measure application " + this.mStats.packageName + " external storage");
        }
    }

    static class OriginInfo {
        final String cid;
        final boolean existing;
        final File file;
        final File resolvedFile;
        final String resolvedPath;
        final boolean staged;

        static OriginInfo fromNothing() {
            return new OriginInfo(null, null, PackageManagerService.DEBUG_VERIFY, PackageManagerService.DEBUG_VERIFY);
        }

        static OriginInfo fromUntrustedFile(File file) {
            return new OriginInfo(file, null, PackageManagerService.DEBUG_VERIFY, PackageManagerService.DEBUG_VERIFY);
        }

        static OriginInfo fromExistingFile(File file) {
            return new OriginInfo(file, null, PackageManagerService.DEBUG_VERIFY, PackageManagerService.DEFAULT_VERIFY_ENABLE);
        }

        static OriginInfo fromStagedFile(File file) {
            return new OriginInfo(file, null, PackageManagerService.DEFAULT_VERIFY_ENABLE, PackageManagerService.DEBUG_VERIFY);
        }

        static OriginInfo fromStagedContainer(String cid) {
            return new OriginInfo(null, cid, PackageManagerService.DEFAULT_VERIFY_ENABLE, PackageManagerService.DEBUG_VERIFY);
        }

        private OriginInfo(File file, String cid, boolean staged, boolean existing) {
            this.file = file;
            this.cid = cid;
            this.staged = staged;
            this.existing = existing;
            if (cid != null) {
                this.resolvedPath = PackageHelper.getSdDir(cid);
                this.resolvedFile = new File(this.resolvedPath);
            } else if (file != null) {
                this.resolvedPath = file.getAbsolutePath();
                this.resolvedFile = file;
            } else {
                this.resolvedPath = null;
                this.resolvedFile = null;
            }
        }
    }

    class PackageHandler extends Handler {
        private boolean mBound;
        final ArrayList<HandlerParams> mPendingInstalls;

        private boolean connectToService() {
            Intent service = new Intent().setComponent(PackageManagerService.DEFAULT_CONTAINER_COMPONENT);
            Process.setThreadPriority(PackageManagerService.DEX_OPT_SKIPPED);
            if (PackageManagerService.this.mContext.bindServiceAsUser(service, PackageManagerService.this.mDefContainerConn, PackageManagerService.UPDATE_PERMISSIONS_ALL, UserHandle.OWNER)) {
                Process.setThreadPriority(PackageManagerService.MCS_RECONNECT);
                this.mBound = PackageManagerService.DEFAULT_VERIFY_ENABLE;
                return PackageManagerService.DEFAULT_VERIFY_ENABLE;
            }
            Process.setThreadPriority(PackageManagerService.MCS_RECONNECT);
            return PackageManagerService.DEBUG_VERIFY;
        }

        private void disconnectService() {
            PackageManagerService.this.mContainerService = null;
            this.mBound = PackageManagerService.DEBUG_VERIFY;
            Process.setThreadPriority(PackageManagerService.DEX_OPT_SKIPPED);
            PackageManagerService.this.mContext.unbindService(PackageManagerService.this.mDefContainerConn);
            Process.setThreadPriority(PackageManagerService.MCS_RECONNECT);
        }

        PackageHandler(Looper looper) {
            super(looper);
            this.mBound = PackageManagerService.DEBUG_VERIFY;
            this.mPendingInstalls = new ArrayList();
        }

        public void handleMessage(Message msg) {
            try {
                doHandleMessage(msg);
            } finally {
                Process.setThreadPriority(PackageManagerService.MCS_RECONNECT);
            }
        }

        void doHandleMessage(Message msg) {
            int i;
            Iterator i$;
            HandlerParams params;
            InstallArgs args;
            int verificationId;
            PackageVerificationState state;
            Uri originUri;
            int ret;
            switch (msg.what) {
                case PackageManagerService.UPDATE_PERMISSIONS_ALL /*1*/:
                    Process.setThreadPriority(PackageManagerService.DEX_OPT_SKIPPED);
                    synchronized (PackageManagerService.this.mPackages) {
                        if (PackageManagerService.this.mPendingBroadcasts == null) {
                            return;
                        }
                        int size = PackageManagerService.this.mPendingBroadcasts.size();
                        if (size <= 0) {
                            return;
                        }
                        String[] packages = new String[size];
                        ArrayList<String>[] components = new ArrayList[size];
                        int[] uids = new int[size];
                        i = PackageManagerService.DEX_OPT_SKIPPED;
                        for (int n = PackageManagerService.DEX_OPT_SKIPPED; n < PackageManagerService.this.mPendingBroadcasts.userIdCount(); n += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                            int packageUserId = PackageManagerService.this.mPendingBroadcasts.userIdAt(n);
                            Iterator<Entry<String, ArrayList<String>>> it = PackageManagerService.this.mPendingBroadcasts.packagesForUserId(packageUserId).entrySet().iterator();
                            while (it.hasNext() && i < size) {
                                Entry<String, ArrayList<String>> ent = (Entry) it.next();
                                packages[i] = (String) ent.getKey();
                                components[i] = (ArrayList) ent.getValue();
                                PackageSetting ps = (PackageSetting) PackageManagerService.this.mSettings.mPackages.get(ent.getKey());
                                uids[i] = ps != null ? UserHandle.getUid(packageUserId, ps.appId) : PackageManagerService.DEX_OPT_FAILED;
                                i += PackageManagerService.UPDATE_PERMISSIONS_ALL;
                            }
                        }
                        size = i;
                        PackageManagerService.this.mPendingBroadcasts.clear();
                        for (i = PackageManagerService.DEX_OPT_SKIPPED; i < size; i += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                            PackageManagerService.this.sendPackageChangedBroadcast(packages[i], PackageManagerService.DEFAULT_VERIFY_ENABLE, components[i], uids[i]);
                        }
                        Process.setThreadPriority(PackageManagerService.MCS_RECONNECT);
                    }
                case PackageManagerService.MCS_BOUND /*3*/:
                    if (msg.obj != null) {
                        PackageManagerService.this.mContainerService = (IMediaContainerService) msg.obj;
                    }
                    if (PackageManagerService.this.mContainerService == null) {
                        Slog.e(PackageManagerService.TAG, "Cannot bind to media container service");
                        i$ = this.mPendingInstalls.iterator();
                        while (i$.hasNext()) {
                            ((HandlerParams) i$.next()).serviceError();
                        }
                        this.mPendingInstalls.clear();
                    } else if (this.mPendingInstalls.size() > 0) {
                        params = (HandlerParams) this.mPendingInstalls.get(PackageManagerService.DEX_OPT_SKIPPED);
                        if (params != null && params.startCopy()) {
                            if (this.mPendingInstalls.size() > 0) {
                                this.mPendingInstalls.remove(PackageManagerService.DEX_OPT_SKIPPED);
                            }
                            if (this.mPendingInstalls.size() != 0) {
                                PackageManagerService.this.mHandler.sendEmptyMessage(PackageManagerService.MCS_BOUND);
                            } else if (this.mBound) {
                                removeMessages(PackageManagerService.MCS_UNBIND);
                                sendMessageDelayed(obtainMessage(PackageManagerService.MCS_UNBIND), PackageManagerService.DEFAULT_VERIFICATION_TIMEOUT);
                            }
                        }
                    } else {
                        Slog.w(PackageManagerService.TAG, "Empty queue");
                    }
                case PackageManagerService.INIT_COPY /*5*/:
                    params = msg.obj;
                    int idx = this.mPendingInstalls.size();
                    if (this.mBound) {
                        this.mPendingInstalls.add(idx, params);
                        if (idx == 0) {
                            PackageManagerService.this.mHandler.sendEmptyMessage(PackageManagerService.MCS_BOUND);
                        }
                    } else if (connectToService()) {
                        this.mPendingInstalls.add(idx, params);
                    } else {
                        Slog.e(PackageManagerService.TAG, "Failed to bind to media container service");
                        params.serviceError();
                    }
                case PackageManagerService.MCS_UNBIND /*6*/:
                    if (this.mPendingInstalls.size() == 0 && PackageManagerService.this.mPendingVerification.size() == 0) {
                        if (this.mBound) {
                            disconnectService();
                        }
                    } else if (this.mPendingInstalls.size() > 0) {
                        PackageManagerService.this.mHandler.sendEmptyMessage(PackageManagerService.MCS_BOUND);
                    }
                case PackageManagerService.START_CLEANING_PACKAGE /*7*/:
                    Process.setThreadPriority(PackageManagerService.DEX_OPT_SKIPPED);
                    String packageName = msg.obj;
                    int userId = msg.arg1;
                    boolean andCode = msg.arg2 != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
                    synchronized (PackageManagerService.this.mPackages) {
                        if (userId == PackageManagerService.DEX_OPT_FAILED) {
                            int[] arr$ = PackageManagerService.sUserManager.getUserIds();
                            int len$ = arr$.length;
                            for (int i$2 = PackageManagerService.DEX_OPT_SKIPPED; i$2 < len$; i$2 += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                                PackageManagerService.this.mSettings.addPackageToCleanLPw(new PackageCleanItem(arr$[i$2], packageName, andCode));
                            }
                            break;
                        }
                        PackageManagerService.this.mSettings.addPackageToCleanLPw(new PackageCleanItem(userId, packageName, andCode));
                    }
                    Process.setThreadPriority(PackageManagerService.MCS_RECONNECT);
                    PackageManagerService.this.startCleaningPackages();
                case PackageManagerService.POST_INSTALL /*9*/:
                    PostInstallData data = (PostInstallData) PackageManagerService.this.mRunningInstalls.get(msg.arg1);
                    PackageManagerService.this.mRunningInstalls.delete(msg.arg1);
                    boolean deleteOld = PackageManagerService.DEBUG_VERIFY;
                    if (data != null) {
                        args = data.args;
                        PackageInstalledInfo res = data.res;
                        if (res.returnCode == PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                            int[] firstUsers;
                            res.removedInfo.sendBroadcast(PackageManagerService.DEBUG_VERIFY, PackageManagerService.DEFAULT_VERIFY_ENABLE, PackageManagerService.DEBUG_VERIFY);
                            Bundle extras = new Bundle(PackageManagerService.UPDATE_PERMISSIONS_ALL);
                            extras.putInt("android.intent.extra.UID", res.uid);
                            int[] updateUsers = new int[PackageManagerService.DEX_OPT_SKIPPED];
                            if (res.origUsers == null || res.origUsers.length == 0) {
                                firstUsers = res.newUsers;
                            } else {
                                firstUsers = new int[PackageManagerService.DEX_OPT_SKIPPED];
                                for (i = PackageManagerService.DEX_OPT_SKIPPED; i < res.newUsers.length; i += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                                    int[] newUpdate;
                                    int[] newFirst;
                                    int user = res.newUsers[i];
                                    boolean isNew = PackageManagerService.DEFAULT_VERIFY_ENABLE;
                                    int j = PackageManagerService.DEX_OPT_SKIPPED;
                                    while (j < res.origUsers.length) {
                                        if (res.origUsers[j] == user) {
                                            isNew = PackageManagerService.DEBUG_VERIFY;
                                            if (isNew) {
                                                newUpdate = new int[(updateUsers.length + PackageManagerService.UPDATE_PERMISSIONS_ALL)];
                                                System.arraycopy(updateUsers, PackageManagerService.DEX_OPT_SKIPPED, newUpdate, PackageManagerService.DEX_OPT_SKIPPED, updateUsers.length);
                                                newUpdate[updateUsers.length] = user;
                                                updateUsers = newUpdate;
                                            } else {
                                                newFirst = new int[(firstUsers.length + PackageManagerService.UPDATE_PERMISSIONS_ALL)];
                                                System.arraycopy(firstUsers, PackageManagerService.DEX_OPT_SKIPPED, newFirst, PackageManagerService.DEX_OPT_SKIPPED, firstUsers.length);
                                                newFirst[firstUsers.length] = user;
                                                firstUsers = newFirst;
                                            }
                                        } else {
                                            j += PackageManagerService.UPDATE_PERMISSIONS_ALL;
                                        }
                                    }
                                    if (isNew) {
                                        newUpdate = new int[(updateUsers.length + PackageManagerService.UPDATE_PERMISSIONS_ALL)];
                                        System.arraycopy(updateUsers, PackageManagerService.DEX_OPT_SKIPPED, newUpdate, PackageManagerService.DEX_OPT_SKIPPED, updateUsers.length);
                                        newUpdate[updateUsers.length] = user;
                                        updateUsers = newUpdate;
                                    } else {
                                        newFirst = new int[(firstUsers.length + PackageManagerService.UPDATE_PERMISSIONS_ALL)];
                                        System.arraycopy(firstUsers, PackageManagerService.DEX_OPT_SKIPPED, newFirst, PackageManagerService.DEX_OPT_SKIPPED, firstUsers.length);
                                        newFirst[firstUsers.length] = user;
                                        firstUsers = newFirst;
                                    }
                                }
                            }
                            PackageManagerService.sendPackageBroadcast("android.intent.action.PACKAGE_ADDED", res.pkg.applicationInfo.packageName, extras, null, null, firstUsers);
                            boolean update = res.removedInfo.removedPackage != null ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
                            if (update) {
                                extras.putBoolean("android.intent.extra.REPLACING", PackageManagerService.DEFAULT_VERIFY_ENABLE);
                            }
                            PackageManagerService.sendPackageBroadcast("android.intent.action.PACKAGE_ADDED", res.pkg.applicationInfo.packageName, extras, null, null, updateUsers);
                            if (update) {
                                PackageManagerService.sendPackageBroadcast("android.intent.action.PACKAGE_REPLACED", res.pkg.applicationInfo.packageName, extras, null, null, updateUsers);
                                PackageManagerService.sendPackageBroadcast("android.intent.action.MY_PACKAGE_REPLACED", null, null, res.pkg.applicationInfo.packageName, null, updateUsers);
                                if (PackageManagerService.isForwardLocked(res.pkg) || PackageManagerService.isExternal(res.pkg)) {
                                    int[] uidArray = new int[PackageManagerService.UPDATE_PERMISSIONS_ALL];
                                    uidArray[PackageManagerService.DEX_OPT_SKIPPED] = res.pkg.applicationInfo.uid;
                                    ArrayList<String> arrayList = new ArrayList(PackageManagerService.UPDATE_PERMISSIONS_ALL);
                                    arrayList.add(res.pkg.applicationInfo.packageName);
                                    PackageManagerService.this.sendResourcesChangedBroadcast(PackageManagerService.DEFAULT_VERIFY_ENABLE, PackageManagerService.DEFAULT_VERIFY_ENABLE, arrayList, uidArray, null);
                                }
                            }
                            if (res.removedInfo.args != null) {
                                deleteOld = PackageManagerService.DEFAULT_VERIFY_ENABLE;
                            }
                            EventLog.writeEvent(EventLogTags.UNKNOWN_SOURCES_ENABLED, PackageManagerService.this.getUnknownSourcesSettings());
                        }
                        Runtime.getRuntime().gc();
                        if (deleteOld) {
                            synchronized (PackageManagerService.this.mInstallLock) {
                                res.removedInfo.args.doPostDeleteLI(PackageManagerService.DEFAULT_VERIFY_ENABLE);
                                break;
                            }
                        }
                        if (args.observer != null) {
                            try {
                                args.observer.onPackageInstalled(res.name, res.returnCode, res.returnMsg, PackageManagerService.this.extrasForInstallResult(res));
                                return;
                            } catch (RemoteException e) {
                                Slog.i(PackageManagerService.TAG, "Observer no longer exists.");
                                return;
                            }
                        }
                        return;
                    }
                    Slog.e(PackageManagerService.TAG, "Bogus post-install token " + msg.arg1);
                case PackageManagerService.MCS_RECONNECT /*10*/:
                    if (this.mPendingInstalls.size() > 0) {
                        if (this.mBound) {
                            disconnectService();
                        }
                        if (!connectToService()) {
                            Slog.e(PackageManagerService.TAG, "Failed to bind to media container service");
                            i$ = this.mPendingInstalls.iterator();
                            while (i$.hasNext()) {
                                ((HandlerParams) i$.next()).serviceError();
                            }
                            this.mPendingInstalls.clear();
                        }
                    }
                case PackageManagerService.MCS_GIVE_UP /*11*/:
                    this.mPendingInstalls.remove(PackageManagerService.DEX_OPT_SKIPPED);
                case PackageManagerService.UPDATED_MEDIA_STATUS /*12*/:
                    boolean reportStatus = msg.arg1 == PackageManagerService.UPDATE_PERMISSIONS_ALL ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
                    if (msg.arg2 == PackageManagerService.UPDATE_PERMISSIONS_ALL ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY) {
                        Runtime.getRuntime().gc();
                    }
                    if (msg.obj != null) {
                        PackageManagerService.this.unloadAllContainers(msg.obj);
                    }
                    if (reportStatus) {
                        try {
                            PackageHelper.getMountService().finishMediaUpdate();
                        } catch (RemoteException e2) {
                            Log.e(PackageManagerService.TAG, "MountService not running?");
                        }
                    }
                case PackageManagerService.WRITE_SETTINGS /*13*/:
                    Process.setThreadPriority(PackageManagerService.DEX_OPT_SKIPPED);
                    synchronized (PackageManagerService.this.mPackages) {
                        removeMessages(PackageManagerService.WRITE_SETTINGS);
                        removeMessages(PackageManagerService.WRITE_PACKAGE_RESTRICTIONS);
                        PackageManagerService.this.mSettings.writeLPr();
                        PackageManagerService.this.mDirtyUsers.clear();
                        break;
                    }
                    Process.setThreadPriority(PackageManagerService.MCS_RECONNECT);
                case PackageManagerService.WRITE_PACKAGE_RESTRICTIONS /*14*/:
                    Process.setThreadPriority(PackageManagerService.DEX_OPT_SKIPPED);
                    synchronized (PackageManagerService.this.mPackages) {
                        removeMessages(PackageManagerService.WRITE_PACKAGE_RESTRICTIONS);
                        i$ = PackageManagerService.this.mDirtyUsers.iterator();
                        while (i$.hasNext()) {
                            PackageManagerService.this.mSettings.writePackageRestrictionsLPr(((Integer) i$.next()).intValue());
                        }
                        PackageManagerService.this.mDirtyUsers.clear();
                        break;
                    }
                    Process.setThreadPriority(PackageManagerService.MCS_RECONNECT);
                case PackageManagerService.PACKAGE_VERIFIED /*15*/:
                    verificationId = msg.arg1;
                    state = (PackageVerificationState) PackageManagerService.this.mPendingVerification.get(verificationId);
                    if (state == null) {
                        Slog.w(PackageManagerService.TAG, "Invalid verification token " + verificationId + " received");
                        return;
                    }
                    PackageVerificationResponse response = msg.obj;
                    state.setVerifierResponse(response.callerUid, response.code);
                    if (state.isVerificationComplete()) {
                        PackageManagerService.this.mPendingVerification.remove(verificationId);
                        args = state.getInstallArgs();
                        originUri = Uri.fromFile(args.origin.resolvedFile);
                        if (state.isInstallAllowed()) {
                            ret = -110;
                            PackageManagerService.this.broadcastPackageVerified(verificationId, originUri, response.code, state.getInstallArgs().getUser());
                            try {
                                ret = args.copyApk(PackageManagerService.this.mContainerService, PackageManagerService.DEFAULT_VERIFY_ENABLE);
                            } catch (RemoteException e3) {
                                Slog.e(PackageManagerService.TAG, "Could not contact the ContainerService");
                            }
                        } else {
                            ret = -22;
                        }
                        PackageManagerService.this.processPendingInstall(args, ret);
                        PackageManagerService.this.mHandler.sendEmptyMessage(PackageManagerService.MCS_UNBIND);
                    }
                case PackageManagerService.SCAN_NEW_INSTALL /*16*/:
                    verificationId = msg.arg1;
                    state = (PackageVerificationState) PackageManagerService.this.mPendingVerification.get(verificationId);
                    if (state != null && !state.timeoutExtended()) {
                        args = state.getInstallArgs();
                        originUri = Uri.fromFile(args.origin.resolvedFile);
                        Slog.i(PackageManagerService.TAG, "Verification timed out for " + originUri);
                        PackageManagerService.this.mPendingVerification.remove(verificationId);
                        ret = -22;
                        if (PackageManagerService.this.getDefaultVerificationResponse() == PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                            Slog.i(PackageManagerService.TAG, "Continuing with installation of " + originUri);
                            state.setVerifierResponse(Binder.getCallingUid(), PackageManagerService.UPDATE_PERMISSIONS_REPLACE_PKG);
                            PackageManagerService.this.broadcastPackageVerified(verificationId, originUri, PackageManagerService.UPDATE_PERMISSIONS_ALL, state.getInstallArgs().getUser());
                            try {
                                ret = args.copyApk(PackageManagerService.this.mContainerService, PackageManagerService.DEFAULT_VERIFY_ENABLE);
                            } catch (RemoteException e4) {
                                Slog.e(PackageManagerService.TAG, "Could not contact the ContainerService");
                            }
                        } else {
                            PackageManagerService.this.broadcastPackageVerified(verificationId, originUri, PackageManagerService.DEX_OPT_FAILED, state.getInstallArgs().getUser());
                        }
                        PackageManagerService.this.processPendingInstall(args, ret);
                        PackageManagerService.this.mHandler.sendEmptyMessage(PackageManagerService.MCS_UNBIND);
                    }
                default:
            }
        }
    }

    class PackageInstalledInfo {
        String name;
        int[] newUsers;
        String origPackage;
        String origPermission;
        int[] origUsers;
        Package pkg;
        PackageRemovedInfo removedInfo;
        int returnCode;
        String returnMsg;
        int uid;

        PackageInstalledInfo() {
        }

        public void setError(int code, String msg) {
            this.returnCode = code;
            this.returnMsg = msg;
            Slog.w(PackageManagerService.TAG, msg);
        }

        public void setError(String msg, PackageParserException e) {
            this.returnCode = e.error;
            this.returnMsg = ExceptionUtils.getCompleteMessage(msg, e);
            Slog.w(PackageManagerService.TAG, msg, e);
        }

        public void setError(String msg, PackageManagerException e) {
            this.returnCode = e.error;
            this.returnMsg = ExceptionUtils.getCompleteMessage(msg, e);
            Slog.w(PackageManagerService.TAG, msg, e);
        }
    }

    static class PackageRemovedInfo {
        InstallArgs args;
        boolean isRemovedPackageSystemUpdate;
        int removedAppId;
        String removedPackage;
        int[] removedUsers;
        int uid;

        PackageRemovedInfo() {
            this.uid = PackageManagerService.DEX_OPT_FAILED;
            this.removedAppId = PackageManagerService.DEX_OPT_FAILED;
            this.removedUsers = null;
            this.isRemovedPackageSystemUpdate = PackageManagerService.DEBUG_VERIFY;
            this.args = null;
        }

        void sendBroadcast(boolean fullRemove, boolean replacing, boolean removedForAllUsers) {
            Bundle extras = new Bundle(PackageManagerService.UPDATE_PERMISSIONS_ALL);
            extras.putInt("android.intent.extra.UID", this.removedAppId >= 0 ? this.removedAppId : this.uid);
            extras.putBoolean("android.intent.extra.DATA_REMOVED", fullRemove);
            if (replacing) {
                extras.putBoolean("android.intent.extra.REPLACING", PackageManagerService.DEFAULT_VERIFY_ENABLE);
            }
            extras.putBoolean("android.intent.extra.REMOVED_FOR_ALL_USERS", removedForAllUsers);
            if (this.removedPackage != null) {
                PackageManagerService.sendPackageBroadcast("android.intent.action.PACKAGE_REMOVED", this.removedPackage, extras, null, null, this.removedUsers);
                if (fullRemove && !replacing) {
                    PackageManagerService.sendPackageBroadcast("android.intent.action.PACKAGE_FULLY_REMOVED", this.removedPackage, extras, null, null, this.removedUsers);
                }
            }
            if (this.removedAppId >= 0) {
                PackageManagerService.sendPackageBroadcast("android.intent.action.UID_REMOVED", null, extras, null, null, this.removedUsers);
            }
        }
    }

    private class PackageUsage {
        private static final int WRITE_INTERVAL = 1800000;
        private final AtomicBoolean mBackgroundWriteRunning;
        private final Object mFileLock;
        private boolean mIsHistoricalPackageUsageAvailable;
        private final AtomicLong mLastWritten;

        /* renamed from: com.android.server.pm.PackageManagerService.PackageUsage.1 */
        class C04581 extends Thread {
            C04581(String x0) {
                super(x0);
            }

            public void run() {
                try {
                    PackageUsage.this.writeInternal();
                } finally {
                    PackageUsage.this.mBackgroundWriteRunning.set(PackageManagerService.DEBUG_VERIFY);
                }
            }
        }

        private PackageUsage() {
            this.mFileLock = new Object();
            this.mLastWritten = new AtomicLong(0);
            this.mBackgroundWriteRunning = new AtomicBoolean(PackageManagerService.DEBUG_VERIFY);
            this.mIsHistoricalPackageUsageAvailable = PackageManagerService.DEFAULT_VERIFY_ENABLE;
        }

        boolean isHistoricalPackageUsageAvailable() {
            return this.mIsHistoricalPackageUsageAvailable;
        }

        void write(boolean force) {
            if (force) {
                writeInternal();
            } else if (SystemClock.elapsedRealtime() - this.mLastWritten.get() >= 1800000 && this.mBackgroundWriteRunning.compareAndSet(PackageManagerService.DEBUG_VERIFY, PackageManagerService.DEFAULT_VERIFY_ENABLE)) {
                new C04581("PackageUsage_DiskWriter").start();
            }
        }

        private void writeInternal() {
            synchronized (PackageManagerService.this.mPackages) {
                synchronized (this.mFileLock) {
                    AtomicFile file = getFile();
                    FileOutputStream f = null;
                    try {
                        f = file.startWrite();
                        BufferedOutputStream out = new BufferedOutputStream(f);
                        FileUtils.setPermissions(file.getBaseFile().getPath(), 416, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, 1032);
                        StringBuilder sb = new StringBuilder();
                        for (Package pkg : PackageManagerService.this.mPackages.values()) {
                            if (pkg.mLastPackageUsageTimeInMills != 0) {
                                sb.setLength(PackageManagerService.DEX_OPT_SKIPPED);
                                sb.append(pkg.packageName);
                                sb.append(' ');
                                sb.append(pkg.mLastPackageUsageTimeInMills);
                                sb.append('\n');
                                out.write(sb.toString().getBytes(StandardCharsets.US_ASCII));
                            }
                        }
                        out.flush();
                        file.finishWrite(f);
                    } catch (IOException e) {
                        if (f != null) {
                            file.failWrite(f);
                        }
                        Log.e(PackageManagerService.TAG, "Failed to write package usage times", e);
                    }
                }
            }
            this.mLastWritten.set(SystemClock.elapsedRealtime());
        }

        void readLP() {
            IOException e;
            Throwable th;
            synchronized (this.mFileLock) {
                BufferedInputStream bufferedInputStream = null;
                try {
                    BufferedInputStream in = new BufferedInputStream(getFile().openRead());
                    String timeInMillisString;
                    try {
                        String packageName;
                        StringBuffer sb = new StringBuffer();
                        while (true) {
                            packageName = readToken(in, sb, ' ');
                            if (packageName == null) {
                                IoUtils.closeQuietly(in);
                                bufferedInputStream = in;
                            } else {
                                timeInMillisString = readToken(in, sb, '\n');
                                if (timeInMillisString == null) {
                                    break;
                                }
                                Package pkg = (Package) PackageManagerService.this.mPackages.get(packageName);
                                if (pkg != null) {
                                    pkg.mLastPackageUsageTimeInMills = Long.parseLong(timeInMillisString.toString());
                                }
                            }
                        }
                        throw new IOException("Failed to find last usage time for package " + packageName);
                    } catch (NumberFormatException e2) {
                        throw new IOException("Failed to parse " + timeInMillisString + " as a long.", e2);
                    } catch (FileNotFoundException e3) {
                        bufferedInputStream = in;
                    } catch (IOException e4) {
                        e = e4;
                        bufferedInputStream = in;
                    } catch (Throwable th2) {
                        th = th2;
                        bufferedInputStream = in;
                    }
                } catch (FileNotFoundException e5) {
                    try {
                        this.mIsHistoricalPackageUsageAvailable = PackageManagerService.DEBUG_VERIFY;
                        IoUtils.closeQuietly(bufferedInputStream);
                        this.mLastWritten.set(SystemClock.elapsedRealtime());
                    } catch (Throwable th3) {
                        th = th3;
                        IoUtils.closeQuietly(bufferedInputStream);
                        throw th;
                    }
                } catch (IOException e6) {
                    e = e6;
                    Log.w(PackageManagerService.TAG, "Failed to read package usage times", e);
                    IoUtils.closeQuietly(bufferedInputStream);
                    this.mLastWritten.set(SystemClock.elapsedRealtime());
                }
            }
            this.mLastWritten.set(SystemClock.elapsedRealtime());
        }

        private String readToken(InputStream in, StringBuffer sb, char endOfToken) throws IOException {
            sb.setLength(PackageManagerService.DEX_OPT_SKIPPED);
            while (true) {
                char ch = in.read();
                if (ch == PackageManagerService.DEX_OPT_FAILED) {
                    break;
                } else if (ch == endOfToken) {
                    return sb.toString();
                } else {
                    sb.append((char) ch);
                }
            }
            if (sb.length() == 0) {
                return null;
            }
            throw new IOException("Unexpected EOF");
        }

        private AtomicFile getFile() {
            return new AtomicFile(new File(new File(Environment.getDataDirectory(), "system"), "package-usage.list"));
        }
    }

    static class PendingPackageBroadcasts {
        final SparseArray<ArrayMap<String, ArrayList<String>>> mUidMap;

        public PendingPackageBroadcasts() {
            this.mUidMap = new SparseArray(PackageManagerService.UPDATE_PERMISSIONS_REPLACE_PKG);
        }

        public ArrayList<String> get(int userId, String packageName) {
            return (ArrayList) getOrAllocate(userId).get(packageName);
        }

        public void put(int userId, String packageName, ArrayList<String> components) {
            getOrAllocate(userId).put(packageName, components);
        }

        public void remove(int userId, String packageName) {
            ArrayMap<String, ArrayList<String>> packages = (ArrayMap) this.mUidMap.get(userId);
            if (packages != null) {
                packages.remove(packageName);
            }
        }

        public void remove(int userId) {
            this.mUidMap.remove(userId);
        }

        public int userIdCount() {
            return this.mUidMap.size();
        }

        public int userIdAt(int n) {
            return this.mUidMap.keyAt(n);
        }

        public ArrayMap<String, ArrayList<String>> packagesForUserId(int userId) {
            return (ArrayMap) this.mUidMap.get(userId);
        }

        public int size() {
            int num = PackageManagerService.DEX_OPT_SKIPPED;
            for (int i = PackageManagerService.DEX_OPT_SKIPPED; i < this.mUidMap.size(); i += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                num += ((ArrayMap) this.mUidMap.valueAt(i)).size();
            }
            return num;
        }

        public void clear() {
            this.mUidMap.clear();
        }

        private ArrayMap<String, ArrayList<String>> getOrAllocate(int userId) {
            ArrayMap<String, ArrayList<String>> map = (ArrayMap) this.mUidMap.get(userId);
            if (map != null) {
                return map;
            }
            map = new ArrayMap();
            this.mUidMap.put(userId, map);
            return map;
        }
    }

    class PostInstallData {
        public InstallArgs args;
        public PackageInstalledInfo res;

        PostInstallData(InstallArgs _a, PackageInstalledInfo _r) {
            this.args = _a;
            this.res = _r;
        }
    }

    private final class ProviderIntentResolver extends IntentResolver<ProviderIntentInfo, ResolveInfo> {
        private int mFlags;
        private final ArrayMap<ComponentName, Provider> mProviders;

        private ProviderIntentResolver() {
            this.mProviders = new ArrayMap();
        }

        public List<ResolveInfo> queryIntent(Intent intent, String resolvedType, boolean defaultOnly, int userId) {
            this.mFlags = defaultOnly ? PackageManagerService.REMOVE_CHATTY : PackageManagerService.DEX_OPT_SKIPPED;
            return super.queryIntent(intent, resolvedType, defaultOnly, userId);
        }

        public List<ResolveInfo> queryIntent(Intent intent, String resolvedType, int flags, int userId) {
            if (!PackageManagerService.sUserManager.exists(userId)) {
                return null;
            }
            this.mFlags = flags;
            return super.queryIntent(intent, resolvedType, (PackageManagerService.REMOVE_CHATTY & flags) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY, userId);
        }

        public List<ResolveInfo> queryIntentForPackage(Intent intent, String resolvedType, int flags, ArrayList<Provider> packageProviders, int userId) {
            if (!PackageManagerService.sUserManager.exists(userId) || packageProviders == null) {
                return null;
            }
            this.mFlags = flags;
            boolean defaultOnly = (PackageManagerService.REMOVE_CHATTY & flags) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
            int N = packageProviders.size();
            ArrayList<ProviderIntentInfo[]> listCut = new ArrayList(N);
            for (int i = PackageManagerService.DEX_OPT_SKIPPED; i < N; i += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                ArrayList<ProviderIntentInfo> intentFilters = ((Provider) packageProviders.get(i)).intents;
                if (intentFilters != null && intentFilters.size() > 0) {
                    ProviderIntentInfo[] array = new ProviderIntentInfo[intentFilters.size()];
                    intentFilters.toArray(array);
                    listCut.add(array);
                }
            }
            return super.queryIntentFromList(intent, resolvedType, defaultOnly, listCut, userId);
        }

        public final void addProvider(Provider p) {
            if (this.mProviders.containsKey(p.getComponentName())) {
                Slog.w(PackageManagerService.TAG, "Provider " + p.getComponentName() + " already defined; ignoring");
                return;
            }
            this.mProviders.put(p.getComponentName(), p);
            int NI = p.intents.size();
            for (int j = PackageManagerService.DEX_OPT_SKIPPED; j < NI; j += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                ProviderIntentInfo intent = (ProviderIntentInfo) p.intents.get(j);
                if (!intent.debugCheck()) {
                    Log.w(PackageManagerService.TAG, "==> For Provider " + p.info.name);
                }
                addFilter(intent);
            }
        }

        public final void removeProvider(Provider p) {
            this.mProviders.remove(p.getComponentName());
            int NI = p.intents.size();
            for (int j = PackageManagerService.DEX_OPT_SKIPPED; j < NI; j += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                removeFilter((ProviderIntentInfo) p.intents.get(j));
            }
        }

        protected boolean allowFilterResult(ProviderIntentInfo filter, List<ResolveInfo> dest) {
            ProviderInfo filterPi = filter.provider.info;
            for (int i = dest.size() + PackageManagerService.DEX_OPT_FAILED; i >= 0; i += PackageManagerService.DEX_OPT_FAILED) {
                ProviderInfo destPi = ((ResolveInfo) dest.get(i)).providerInfo;
                if (destPi.name == filterPi.name && destPi.packageName == filterPi.packageName) {
                    return PackageManagerService.DEBUG_VERIFY;
                }
            }
            return PackageManagerService.DEFAULT_VERIFY_ENABLE;
        }

        protected ProviderIntentInfo[] newArray(int size) {
            return new ProviderIntentInfo[size];
        }

        protected boolean isFilterStopped(ProviderIntentInfo filter, int userId) {
            if (!PackageManagerService.sUserManager.exists(userId)) {
                return PackageManagerService.DEFAULT_VERIFY_ENABLE;
            }
            Package p = filter.provider.owner;
            if (p != null) {
                PackageSetting ps = p.mExtras;
                if (ps != null) {
                    if ((ps.pkgFlags & PackageManagerService.UPDATE_PERMISSIONS_ALL) == 0 && ps.getStopped(userId)) {
                        return PackageManagerService.DEFAULT_VERIFY_ENABLE;
                    }
                    return PackageManagerService.DEBUG_VERIFY;
                }
            }
            return PackageManagerService.DEBUG_VERIFY;
        }

        protected boolean isPackageForFilter(String packageName, ProviderIntentInfo info) {
            return packageName.equals(info.provider.owner.packageName);
        }

        protected ResolveInfo newResult(ProviderIntentInfo filter, int match, int userId) {
            ResolveInfo resolveInfo = null;
            if (PackageManagerService.sUserManager.exists(userId)) {
                ProviderIntentInfo info = filter;
                if (PackageManagerService.this.mSettings.isEnabledLPr(info.provider.info, this.mFlags, userId)) {
                    Provider provider = info.provider;
                    if (!(PackageManagerService.this.mSafeMode && (provider.info.applicationInfo.flags & PackageManagerService.UPDATE_PERMISSIONS_ALL) == 0)) {
                        PackageSetting ps = provider.owner.mExtras;
                        if (ps != null) {
                            ProviderInfo pi = PackageParser.generateProviderInfo(provider, this.mFlags, ps.readUserState(userId), userId);
                            if (pi != null) {
                                resolveInfo = new ResolveInfo();
                                resolveInfo.providerInfo = pi;
                                if ((this.mFlags & PackageManagerService.SCAN_UPDATE_TIME) != 0) {
                                    resolveInfo.filter = filter;
                                }
                                resolveInfo.priority = info.getPriority();
                                resolveInfo.preferredOrder = provider.owner.mPreferredOrder;
                                resolveInfo.match = match;
                                resolveInfo.isDefault = info.hasDefault;
                                resolveInfo.labelRes = info.labelRes;
                                resolveInfo.nonLocalizedLabel = info.nonLocalizedLabel;
                                resolveInfo.icon = info.icon;
                                resolveInfo.system = PackageManagerService.isSystemApp(resolveInfo.providerInfo.applicationInfo);
                            }
                        }
                    }
                }
            }
            return resolveInfo;
        }

        protected void sortResults(List<ResolveInfo> results) {
            Collections.sort(results, PackageManagerService.mResolvePrioritySorter);
        }

        protected void dumpFilter(PrintWriter out, String prefix, ProviderIntentInfo filter) {
            out.print(prefix);
            out.print(Integer.toHexString(System.identityHashCode(filter.provider)));
            out.print(' ');
            filter.provider.printComponentShortName(out);
            out.print(" filter ");
            out.println(Integer.toHexString(System.identityHashCode(filter)));
        }

        protected Object filterToLabel(ProviderIntentInfo filter) {
            return filter.provider;
        }

        protected void dumpFilterLabel(PrintWriter out, String prefix, Object label, int count) {
            Provider provider = (Provider) label;
            out.print(prefix);
            out.print(Integer.toHexString(System.identityHashCode(provider)));
            out.print(' ');
            provider.printComponentShortName(out);
            if (count > PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                out.print(" (");
                out.print(count);
                out.print(" filters)");
            }
            out.println();
        }
    }

    private final class ServiceIntentResolver extends IntentResolver<ServiceIntentInfo, ResolveInfo> {
        private int mFlags;
        private final ArrayMap<ComponentName, Service> mServices;

        private ServiceIntentResolver() {
            this.mServices = new ArrayMap();
        }

        public List<ResolveInfo> queryIntent(Intent intent, String resolvedType, boolean defaultOnly, int userId) {
            this.mFlags = defaultOnly ? PackageManagerService.REMOVE_CHATTY : PackageManagerService.DEX_OPT_SKIPPED;
            return super.queryIntent(intent, resolvedType, defaultOnly, userId);
        }

        public List<ResolveInfo> queryIntent(Intent intent, String resolvedType, int flags, int userId) {
            if (!PackageManagerService.sUserManager.exists(userId)) {
                return null;
            }
            this.mFlags = flags;
            return super.queryIntent(intent, resolvedType, (PackageManagerService.REMOVE_CHATTY & flags) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY, userId);
        }

        public List<ResolveInfo> queryIntentForPackage(Intent intent, String resolvedType, int flags, ArrayList<Service> packageServices, int userId) {
            if (!PackageManagerService.sUserManager.exists(userId) || packageServices == null) {
                return null;
            }
            this.mFlags = flags;
            boolean defaultOnly = (PackageManagerService.REMOVE_CHATTY & flags) != 0 ? PackageManagerService.DEFAULT_VERIFY_ENABLE : PackageManagerService.DEBUG_VERIFY;
            int N = packageServices.size();
            ArrayList<ServiceIntentInfo[]> listCut = new ArrayList(N);
            for (int i = PackageManagerService.DEX_OPT_SKIPPED; i < N; i += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                ArrayList<ServiceIntentInfo> intentFilters = ((Service) packageServices.get(i)).intents;
                if (intentFilters != null && intentFilters.size() > 0) {
                    ServiceIntentInfo[] array = new ServiceIntentInfo[intentFilters.size()];
                    intentFilters.toArray(array);
                    listCut.add(array);
                }
            }
            return super.queryIntentFromList(intent, resolvedType, defaultOnly, listCut, userId);
        }

        public final void addService(Service s) {
            this.mServices.put(s.getComponentName(), s);
            int NI = s.intents.size();
            for (int j = PackageManagerService.DEX_OPT_SKIPPED; j < NI; j += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                ServiceIntentInfo intent = (ServiceIntentInfo) s.intents.get(j);
                if (!intent.debugCheck()) {
                    Log.w(PackageManagerService.TAG, "==> For Service " + s.info.name);
                }
                addFilter(intent);
            }
        }

        public final void removeService(Service s) {
            this.mServices.remove(s.getComponentName());
            int NI = s.intents.size();
            for (int j = PackageManagerService.DEX_OPT_SKIPPED; j < NI; j += PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                removeFilter((ServiceIntentInfo) s.intents.get(j));
            }
        }

        protected boolean allowFilterResult(ServiceIntentInfo filter, List<ResolveInfo> dest) {
            ServiceInfo filterSi = filter.service.info;
            for (int i = dest.size() + PackageManagerService.DEX_OPT_FAILED; i >= 0; i += PackageManagerService.DEX_OPT_FAILED) {
                ServiceInfo destAi = ((ResolveInfo) dest.get(i)).serviceInfo;
                if (destAi.name == filterSi.name && destAi.packageName == filterSi.packageName) {
                    return PackageManagerService.DEBUG_VERIFY;
                }
            }
            return PackageManagerService.DEFAULT_VERIFY_ENABLE;
        }

        protected ServiceIntentInfo[] newArray(int size) {
            return new ServiceIntentInfo[size];
        }

        protected boolean isFilterStopped(ServiceIntentInfo filter, int userId) {
            if (!PackageManagerService.sUserManager.exists(userId)) {
                return PackageManagerService.DEFAULT_VERIFY_ENABLE;
            }
            Package p = filter.service.owner;
            if (p != null) {
                PackageSetting ps = p.mExtras;
                if (ps != null) {
                    if ((ps.pkgFlags & PackageManagerService.UPDATE_PERMISSIONS_ALL) == 0 && ps.getStopped(userId)) {
                        return PackageManagerService.DEFAULT_VERIFY_ENABLE;
                    }
                    return PackageManagerService.DEBUG_VERIFY;
                }
            }
            return PackageManagerService.DEBUG_VERIFY;
        }

        protected boolean isPackageForFilter(String packageName, ServiceIntentInfo info) {
            return packageName.equals(info.service.owner.packageName);
        }

        protected ResolveInfo newResult(ServiceIntentInfo filter, int match, int userId) {
            ResolveInfo resolveInfo = null;
            if (PackageManagerService.sUserManager.exists(userId)) {
                ServiceIntentInfo info = filter;
                if (PackageManagerService.this.mSettings.isEnabledLPr(info.service.info, this.mFlags, userId)) {
                    Service service = info.service;
                    if (!(PackageManagerService.this.mSafeMode && (service.info.applicationInfo.flags & PackageManagerService.UPDATE_PERMISSIONS_ALL) == 0)) {
                        PackageSetting ps = service.owner.mExtras;
                        if (ps != null) {
                            ServiceInfo si = PackageParser.generateServiceInfo(service, this.mFlags, ps.readUserState(userId), userId);
                            if (si != null) {
                                resolveInfo = new ResolveInfo();
                                resolveInfo.serviceInfo = si;
                                if ((this.mFlags & PackageManagerService.SCAN_UPDATE_TIME) != 0) {
                                    resolveInfo.filter = filter;
                                }
                                resolveInfo.priority = info.getPriority();
                                resolveInfo.preferredOrder = service.owner.mPreferredOrder;
                                resolveInfo.match = match;
                                resolveInfo.isDefault = info.hasDefault;
                                resolveInfo.labelRes = info.labelRes;
                                resolveInfo.nonLocalizedLabel = info.nonLocalizedLabel;
                                resolveInfo.icon = info.icon;
                                resolveInfo.system = PackageManagerService.isSystemApp(resolveInfo.serviceInfo.applicationInfo);
                            }
                        }
                    }
                }
            }
            return resolveInfo;
        }

        protected void sortResults(List<ResolveInfo> results) {
            Collections.sort(results, PackageManagerService.mResolvePrioritySorter);
        }

        protected void dumpFilter(PrintWriter out, String prefix, ServiceIntentInfo filter) {
            out.print(prefix);
            out.print(Integer.toHexString(System.identityHashCode(filter.service)));
            out.print(' ');
            filter.service.printComponentShortName(out);
            out.print(" filter ");
            out.println(Integer.toHexString(System.identityHashCode(filter)));
        }

        protected Object filterToLabel(ServiceIntentInfo filter) {
            return filter.service;
        }

        protected void dumpFilterLabel(PrintWriter out, String prefix, Object label, int count) {
            Service service = (Service) label;
            out.print(prefix);
            out.print(Integer.toHexString(System.identityHashCode(service)));
            out.print(' ');
            service.printComponentShortName(out);
            if (count > PackageManagerService.UPDATE_PERMISSIONS_ALL) {
                out.print(" (");
                out.print(count);
                out.print(" filters)");
            }
            out.println();
        }
    }

    public static final class SharedLibraryEntry {
        public final String apk;
        public final String path;

        SharedLibraryEntry(String _path, String _apk) {
            this.path = _path;
            this.apk = _apk;
        }
    }

    static {
        DEFAULT_CONTAINER_COMPONENT = new ComponentName(DEFAULT_CONTAINER_PACKAGE, "com.android.defcontainer.DefaultContainerService");
        mResolvePrioritySorter = new C04504();
        mProviderInitOrderSorter = new C04515();
    }

    Bundle extrasForInstallResult(PackageInstalledInfo res) {
        switch (res.returnCode) {
            case -112:
                Bundle extras = new Bundle();
                extras.putString("android.content.pm.extra.FAILURE_EXISTING_PERMISSION", res.origPermission);
                extras.putString("android.content.pm.extra.FAILURE_EXISTING_PACKAGE", res.origPackage);
                return extras;
            default:
                return null;
        }
    }

    void scheduleWriteSettingsLocked() {
        if (!this.mHandler.hasMessages(WRITE_SETTINGS)) {
            this.mHandler.sendEmptyMessageDelayed(WRITE_SETTINGS, DEFAULT_VERIFICATION_TIMEOUT);
        }
    }

    void scheduleWritePackageRestrictionsLocked(int userId) {
        if (sUserManager.exists(userId)) {
            this.mDirtyUsers.add(Integer.valueOf(userId));
            if (!this.mHandler.hasMessages(WRITE_PACKAGE_RESTRICTIONS)) {
                this.mHandler.sendEmptyMessageDelayed(WRITE_PACKAGE_RESTRICTIONS, DEFAULT_VERIFICATION_TIMEOUT);
            }
        }
    }

    public static final PackageManagerService main(Context context, Installer installer, boolean factoryTest, boolean onlyCore) {
        PackageManagerService m = new PackageManagerService(context, installer, factoryTest, onlyCore);
        ServiceManager.addService("package", m);
        return m;
    }

    static String[] splitString(String str, char sep) {
        int count = UPDATE_PERMISSIONS_ALL;
        int i = DEX_OPT_SKIPPED;
        while (true) {
            i = str.indexOf(sep, i);
            if (i < 0) {
                break;
            }
            count += UPDATE_PERMISSIONS_ALL;
            i += UPDATE_PERMISSIONS_ALL;
        }
        String[] res = new String[count];
        i = DEX_OPT_SKIPPED;
        count = DEX_OPT_SKIPPED;
        int lastI = DEX_OPT_SKIPPED;
        while (true) {
            i = str.indexOf(sep, i);
            if (i >= 0) {
                res[count] = str.substring(lastI, i);
                count += UPDATE_PERMISSIONS_ALL;
                i += UPDATE_PERMISSIONS_ALL;
                lastI = i;
            } else {
                res[count] = str.substring(lastI, str.length());
                return res;
            }
        }
    }

    private static void getDefaultDisplayMetrics(Context context, DisplayMetrics metrics) {
        ((DisplayManager) context.getSystemService("display")).getDisplay(DEX_OPT_SKIPPED).getMetrics(metrics);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public PackageManagerService(android.content.Context r79, com.android.server.pm.Installer r80, boolean r81, boolean r82) {
        /*
        r78 = this;
        r78.<init>();
        r4 = android.os.Build.VERSION.SDK_INT;
        r0 = r78;
        r0.mSdkVersion = r4;
        r4 = new java.lang.Object;
        r4.<init>();
        r0 = r78;
        r0.mInstallLock = r4;
        r4 = new android.util.ArrayMap;
        r4.<init>();
        r0 = r78;
        r0.mPackages = r4;
        r4 = new android.util.ArrayMap;
        r4.<init>();
        r0 = r78;
        r0.mOverlays = r4;
        r4 = com.android.server.pm.SELinuxMMAC.shouldRestorecon();
        r0 = r78;
        r0.mShouldRestoreconData = r4;
        r4 = new android.util.ArrayMap;
        r4.<init>();
        r0 = r78;
        r0.mSharedLibraries = r4;
        r4 = new com.android.server.pm.PackageManagerService$ActivityIntentResolver;
        r0 = r78;
        r4.<init>();
        r0 = r78;
        r0.mActivities = r4;
        r4 = new com.android.server.pm.PackageManagerService$ActivityIntentResolver;
        r0 = r78;
        r4.<init>();
        r0 = r78;
        r0.mReceivers = r4;
        r4 = new com.android.server.pm.PackageManagerService$ServiceIntentResolver;
        r6 = 0;
        r0 = r78;
        r4.<init>(r6);
        r0 = r78;
        r0.mServices = r4;
        r4 = new com.android.server.pm.PackageManagerService$ProviderIntentResolver;
        r6 = 0;
        r0 = r78;
        r4.<init>(r6);
        r0 = r78;
        r0.mProviders = r4;
        r4 = new android.util.ArrayMap;
        r4.<init>();
        r0 = r78;
        r0.mProvidersByAuthority = r4;
        r4 = new android.util.ArrayMap;
        r4.<init>();
        r0 = r78;
        r0.mInstrumentation = r4;
        r4 = new android.util.ArrayMap;
        r4.<init>();
        r0 = r78;
        r0.mPermissionGroups = r4;
        r4 = new android.util.ArraySet;
        r4.<init>();
        r0 = r78;
        r0.mTransferedPackages = r4;
        r4 = new android.util.ArraySet;
        r4.<init>();
        r0 = r78;
        r0.mProtectedBroadcasts = r4;
        r4 = new android.util.SparseArray;
        r4.<init>();
        r0 = r78;
        r0.mPendingVerification = r4;
        r4 = new android.util.ArrayMap;
        r4.<init>();
        r0 = r78;
        r0.mAppOpPermissionPackages = r4;
        r4 = 0;
        r0 = r78;
        r0.mDeferredDexOpt = r4;
        r4 = new android.util.SparseBooleanArray;
        r4.<init>();
        r0 = r78;
        r0.mUserNeedsBadging = r4;
        r4 = 0;
        r0 = r78;
        r0.mPendingVerificationToken = r4;
        r4 = new android.content.pm.ActivityInfo;
        r4.<init>();
        r0 = r78;
        r0.mResolveActivity = r4;
        r4 = new android.content.pm.ResolveInfo;
        r4.<init>();
        r0 = r78;
        r0.mResolveInfo = r4;
        r4 = 0;
        r0 = r78;
        r0.mResolverReplaced = r4;
        r4 = new com.android.server.pm.PackageManagerService$PendingPackageBroadcasts;
        r4.<init>();
        r0 = r78;
        r0.mPendingBroadcasts = r4;
        r4 = 0;
        r0 = r78;
        r0.mContainerService = r4;
        r4 = new android.util.ArraySet;
        r4.<init>();
        r0 = r78;
        r0.mDirtyUsers = r4;
        r4 = new com.android.server.pm.PackageManagerService$DefaultContainerConnection;
        r0 = r78;
        r4.<init>();
        r0 = r78;
        r0.mDefContainerConn = r4;
        r4 = new android.util.SparseArray;
        r4.<init>();
        r0 = r78;
        r0.mRunningInstalls = r4;
        r4 = 1;
        r0 = r78;
        r0.mNextInstallToken = r4;
        r4 = new com.android.server.pm.PackageManagerService$PackageUsage;
        r6 = 0;
        r0 = r78;
        r4.<init>(r6);
        r0 = r78;
        r0.mPackageUsage = r4;
        r4 = 0;
        r0 = r78;
        r0.mMediaMounted = r4;
        r4 = 3060; // 0xbf4 float:4.288E-42 double:1.512E-320;
        r18 = android.os.SystemClock.uptimeMillis();
        r0 = r18;
        android.util.EventLog.writeEvent(r4, r0);
        r0 = r78;
        r4 = r0.mSdkVersion;
        if (r4 > 0) goto L_0x0125;
    L_0x011e:
        r4 = "PackageManager";
        r6 = "**** ro.build.version.sdk not set!";
        android.util.Slog.w(r4, r6);
    L_0x0125:
        r4 = r78.getClass();	 Catch:{ Exception -> 0x0343 }
        r4 = r4.getClassLoader();	 Catch:{ Exception -> 0x0343 }
        r6 = "com.android.services.SecurityBridge.core.PackageManagerSB";
        r4 = r4.loadClass(r6);	 Catch:{ Exception -> 0x0343 }
        r27 = r4.newInstance();	 Catch:{ Exception -> 0x0343 }
        r27 = (com.android.services.SecurityBridge.api.PackageManagerMonitor) r27;	 Catch:{ Exception -> 0x0343 }
        r0 = r27;
        r1 = r78;
        r1.mSecurityBridge = r0;	 Catch:{ Exception -> 0x0343 }
    L_0x013f:
        r0 = r79;
        r1 = r78;
        r1.mContext = r0;
        r0 = r81;
        r1 = r78;
        r1.mFactoryTest = r0;
        r0 = r82;
        r1 = r78;
        r1.mOnlyCore = r0;
        r4 = "eng";
        r6 = "ro.build.type";
        r6 = android.os.SystemProperties.get(r6);
        r4 = r4.equals(r6);
        r0 = r78;
        r0.mLazyDexOpt = r4;
        r4 = new android.util.DisplayMetrics;
        r4.<init>();
        r0 = r78;
        r0.mMetrics = r4;
        r4 = new com.android.server.pm.Settings;
        r0 = r79;
        r4.<init>(r0);
        r0 = r78;
        r0.mSettings = r4;
        r0 = r78;
        r4 = r0.mSettings;
        r6 = "android.uid.system";
        r8 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r10 = 1073741825; // 0x40000001 float:2.0000002 double:5.30498948E-315;
        r4.addSharedUserLPw(r6, r8, r10);
        r0 = r78;
        r4 = r0.mSettings;
        r6 = "android.uid.phone";
        r8 = 1001; // 0x3e9 float:1.403E-42 double:4.946E-321;
        r10 = 1073741825; // 0x40000001 float:2.0000002 double:5.30498948E-315;
        r4.addSharedUserLPw(r6, r8, r10);
        r0 = r78;
        r4 = r0.mSettings;
        r6 = "android.uid.log";
        r8 = 1007; // 0x3ef float:1.411E-42 double:4.975E-321;
        r10 = 1073741825; // 0x40000001 float:2.0000002 double:5.30498948E-315;
        r4.addSharedUserLPw(r6, r8, r10);
        r0 = r78;
        r4 = r0.mSettings;
        r6 = "android.uid.nfc";
        r8 = 1027; // 0x403 float:1.439E-42 double:5.074E-321;
        r10 = 1073741825; // 0x40000001 float:2.0000002 double:5.30498948E-315;
        r4.addSharedUserLPw(r6, r8, r10);
        r0 = r78;
        r4 = r0.mSettings;
        r6 = "android.uid.bluetooth";
        r8 = 1002; // 0x3ea float:1.404E-42 double:4.95E-321;
        r10 = 1073741825; // 0x40000001 float:2.0000002 double:5.30498948E-315;
        r4.addSharedUserLPw(r6, r8, r10);
        r0 = r78;
        r4 = r0.mSettings;
        r6 = "android.uid.shell";
        r8 = 2000; // 0x7d0 float:2.803E-42 double:9.88E-321;
        r10 = 1073741825; // 0x40000001 float:2.0000002 double:5.30498948E-315;
        r4.addSharedUserLPw(r6, r8, r10);
        r0 = r78;
        r4 = r0.mLazyDexOpt;
        if (r4 == 0) goto L_0x0356;
    L_0x01cf:
        r38 = 30;
    L_0x01d1:
        r18 = 60;
        r18 = r18 * r38;
        r76 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r18 = r18 * r76;
        r0 = r18;
        r2 = r78;
        r2.mDexOptLRUThresholdInMills = r0;
        r4 = "debug.separate_processes";
        r69 = android.os.SystemProperties.get(r4);
        if (r69 == 0) goto L_0x0387;
    L_0x01e7:
        r4 = r69.length();
        if (r4 <= 0) goto L_0x0387;
    L_0x01ed:
        r4 = "*";
        r0 = r69;
        r4 = r4.equals(r0);
        if (r4 == 0) goto L_0x035a;
    L_0x01f7:
        r4 = 8;
        r0 = r78;
        r0.mDefParseFlags = r4;
        r4 = 0;
        r0 = r78;
        r0.mSeparateProcesses = r4;
        r4 = "PackageManager";
        r6 = "Running with debug.separate_processes: * (ALL)";
        android.util.Slog.w(r4, r6);
    L_0x0209:
        r0 = r80;
        r1 = r78;
        r1.mInstaller = r0;
        r0 = r78;
        r4 = r0.mMetrics;
        r0 = r79;
        getDefaultDisplayMetrics(r0, r4);
        r71 = com.android.server.SystemConfig.getInstance();
        r4 = r71.getGlobalGids();
        r0 = r78;
        r0.mGlobalGids = r4;
        r4 = r71.getSystemPermissions();
        r0 = r78;
        r0.mSystemPermissions = r4;
        r4 = r71.getAvailableFeatures();
        r0 = r78;
        r0.mAvailableFeatures = r4;
        r0 = r78;
        r0 = r0.mInstallLock;
        r76 = r0;
        monitor-enter(r76);
        r0 = r78;
        r0 = r0.mPackages;	 Catch:{ all -> 0x044a }
        r77 = r0;
        monitor-enter(r77);	 Catch:{ all -> 0x044a }
        r4 = new com.android.server.ServiceThread;	 Catch:{ all -> 0x0447 }
        r6 = "PackageManager";
        r8 = 10;
        r10 = 1;
        r4.<init>(r6, r8, r10);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mHandlerThread = r4;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mHandlerThread;	 Catch:{ all -> 0x0447 }
        r4.start();	 Catch:{ all -> 0x0447 }
        r4 = new com.android.server.pm.PackageManagerService$PackageHandler;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r6 = r0.mHandlerThread;	 Catch:{ all -> 0x0447 }
        r6 = r6.getLooper();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4.<init>(r6);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mHandler = r4;	 Catch:{ all -> 0x0447 }
        r4 = com.android.server.Watchdog.getInstance();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r6 = r0.mHandler;	 Catch:{ all -> 0x0447 }
        r18 = 600000; // 0x927c0 float:8.40779E-40 double:2.964394E-318;
        r0 = r18;
        r4.addThread(r6, r0);	 Catch:{ all -> 0x0447 }
        r31 = android.os.Environment.getDataDirectory();	 Catch:{ all -> 0x0447 }
        r4 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r6 = "data";
        r0 = r31;
        r4.<init>(r0, r6);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mAppDataDir = r4;	 Catch:{ all -> 0x0447 }
        r4 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r6 = "app";
        r0 = r31;
        r4.<init>(r0, r6);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mAppInstallDir = r4;	 Catch:{ all -> 0x0447 }
        r4 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r6 = "app-lib";
        r0 = r31;
        r4.<init>(r0, r6);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mAppLib32InstallDir = r4;	 Catch:{ all -> 0x0447 }
        r4 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r6 = "app-asec";
        r0 = r31;
        r4.<init>(r0, r6);	 Catch:{ all -> 0x0447 }
        r4 = r4.getPath();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mAsecInternalPath = r4;	 Catch:{ all -> 0x0447 }
        r4 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r6 = "user";
        r0 = r31;
        r4.<init>(r0, r6);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mUserAppDataDir = r4;	 Catch:{ all -> 0x0447 }
        r4 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r6 = "app-private";
        r0 = r31;
        r4.<init>(r0, r6);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mDrmAppPrivateInstallDir = r4;	 Catch:{ all -> 0x0447 }
        r4 = new com.android.server.pm.UserManagerService;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r6 = r0.mInstallLock;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r8 = r0.mPackages;	 Catch:{ all -> 0x0447 }
        r0 = r79;
        r1 = r78;
        r4.<init>(r0, r1, r6, r8);	 Catch:{ all -> 0x0447 }
        sUserManager = r4;	 Catch:{ all -> 0x0447 }
        r60 = r71.getPermissions();	 Catch:{ all -> 0x0447 }
        r47 = 0;
    L_0x02e9:
        r4 = r60.size();	 Catch:{ all -> 0x0447 }
        r0 = r47;
        if (r0 >= r4) goto L_0x0393;
    L_0x02f1:
        r0 = r60;
        r1 = r47;
        r59 = r0.valueAt(r1);	 Catch:{ all -> 0x0447 }
        r59 = (com.android.server.SystemConfig.PermissionEntry) r59;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4 = r4.mPermissions;	 Catch:{ all -> 0x0447 }
        r0 = r59;
        r6 = r0.name;	 Catch:{ all -> 0x0447 }
        r26 = r4.get(r6);	 Catch:{ all -> 0x0447 }
        r26 = (com.android.server.pm.BasePermission) r26;	 Catch:{ all -> 0x0447 }
        if (r26 != 0) goto L_0x032a;
    L_0x030d:
        r26 = new com.android.server.pm.BasePermission;	 Catch:{ all -> 0x0447 }
        r0 = r59;
        r4 = r0.name;	 Catch:{ all -> 0x0447 }
        r6 = "android";
        r8 = 1;
        r0 = r26;
        r0.<init>(r4, r6, r8);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4 = r4.mPermissions;	 Catch:{ all -> 0x0447 }
        r0 = r59;
        r6 = r0.name;	 Catch:{ all -> 0x0447 }
        r0 = r26;
        r4.put(r6, r0);	 Catch:{ all -> 0x0447 }
    L_0x032a:
        r0 = r59;
        r4 = r0.gids;	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x0340;
    L_0x0330:
        r0 = r26;
        r4 = r0.gids;	 Catch:{ all -> 0x0447 }
        r0 = r59;
        r6 = r0.gids;	 Catch:{ all -> 0x0447 }
        r4 = appendInts(r4, r6);	 Catch:{ all -> 0x0447 }
        r0 = r26;
        r0.gids = r4;	 Catch:{ all -> 0x0447 }
    L_0x0340:
        r47 = r47 + 1;
        goto L_0x02e9;
    L_0x0343:
        r42 = move-exception;
        r4 = "PackageManager";
        r6 = "No security bridge jar found, using default";
        android.util.Slog.w(r4, r6);
        r4 = new com.android.services.SecurityBridge.api.PackageManagerMonitor;
        r4.<init>();
        r0 = r78;
        r0.mSecurityBridge = r4;
        goto L_0x013f;
    L_0x0356:
        r38 = 10080; // 0x2760 float:1.4125E-41 double:4.98E-320;
        goto L_0x01d1;
    L_0x035a:
        r4 = 0;
        r0 = r78;
        r0.mDefParseFlags = r4;
        r4 = ",";
        r0 = r69;
        r4 = r0.split(r4);
        r0 = r78;
        r0.mSeparateProcesses = r4;
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r8 = "Running with debug.separate_processes: ";
        r6 = r6.append(r8);
        r0 = r69;
        r6 = r6.append(r0);
        r6 = r6.toString();
        android.util.Slog.w(r4, r6);
        goto L_0x0209;
    L_0x0387:
        r4 = 0;
        r0 = r78;
        r0.mDefParseFlags = r4;
        r4 = 0;
        r0 = r78;
        r0.mSeparateProcesses = r4;
        goto L_0x0209;
    L_0x0393:
        r52 = r71.getSharedLibraries();	 Catch:{ all -> 0x0447 }
        r47 = 0;
    L_0x0399:
        r4 = r52.size();	 Catch:{ all -> 0x0447 }
        r0 = r47;
        if (r0 >= r4) goto L_0x03c3;
    L_0x03a1:
        r0 = r78;
        r6 = r0.mSharedLibraries;	 Catch:{ all -> 0x0447 }
        r0 = r52;
        r1 = r47;
        r8 = r0.keyAt(r1);	 Catch:{ all -> 0x0447 }
        r10 = new com.android.server.pm.PackageManagerService$SharedLibraryEntry;	 Catch:{ all -> 0x0447 }
        r0 = r52;
        r1 = r47;
        r4 = r0.valueAt(r1);	 Catch:{ all -> 0x0447 }
        r4 = (java.lang.String) r4;	 Catch:{ all -> 0x0447 }
        r12 = 0;
        r10.<init>(r4, r12);	 Catch:{ all -> 0x0447 }
        r6.put(r8, r10);	 Catch:{ all -> 0x0447 }
        r47 = r47 + 1;
        goto L_0x0399;
    L_0x03c3:
        r4 = com.android.server.pm.SELinuxMMAC.readInstallPolicy();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mFoundPolicyFile = r4;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r6 = sUserManager;	 Catch:{ all -> 0x0447 }
        r8 = 0;
        r6 = r6.getUsers(r8);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r8 = r0.mSdkVersion;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r10 = r0.mOnlyCore;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r4.readLPw(r0, r6, r8, r10);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mRestoredSettings = r4;	 Catch:{ all -> 0x0447 }
        r4 = android.content.res.Resources.getSystem();	 Catch:{ all -> 0x0447 }
        r6 = 17039428; // 0x1040044 float:2.4244762E-38 double:8.418596E-317;
        r30 = r4.getString(r6);	 Catch:{ all -> 0x0447 }
        r4 = android.text.TextUtils.isEmpty(r30);	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x043e;
    L_0x03f9:
        r30 = 0;
    L_0x03fb:
        r72 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0447 }
        r4 = 3070; // 0xbfe float:4.302E-42 double:1.517E-320;
        r0 = r72;
        android.util.EventLog.writeEvent(r4, r0);	 Catch:{ all -> 0x0447 }
        r67 = 416; // 0x1a0 float:5.83E-43 double:2.055E-321;
        r22 = new android.util.ArraySet;	 Catch:{ all -> 0x0447 }
        r22.<init>();	 Catch:{ all -> 0x0447 }
        r4 = "BOOTCLASSPATH";
        r24 = java.lang.System.getenv(r4);	 Catch:{ all -> 0x0447 }
        r4 = "SYSTEMSERVERCLASSPATH";
        r74 = java.lang.System.getenv(r4);	 Catch:{ all -> 0x0447 }
        if (r24 == 0) goto L_0x044d;
    L_0x041b:
        r4 = 58;
        r0 = r24;
        r25 = splitString(r0, r4);	 Catch:{ all -> 0x0447 }
        r23 = r25;
        r0 = r23;
        r0 = r0.length;	 Catch:{ all -> 0x0447 }
        r50 = r0;
        r48 = 0;
    L_0x042c:
        r0 = r48;
        r1 = r50;
        if (r0 >= r1) goto L_0x0454;
    L_0x0432:
        r43 = r23[r48];	 Catch:{ all -> 0x0447 }
        r0 = r22;
        r1 = r43;
        r0.add(r1);	 Catch:{ all -> 0x0447 }
        r48 = r48 + 1;
        goto L_0x042c;
    L_0x043e:
        r4 = android.content.ComponentName.unflattenFromString(r30);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mCustomResolverComponentName = r4;	 Catch:{ all -> 0x0447 }
        goto L_0x03fb;
    L_0x0447:
        r4 = move-exception;
        monitor-exit(r77);	 Catch:{ all -> 0x0447 }
        throw r4;	 Catch:{ all -> 0x044a }
    L_0x044a:
        r4 = move-exception;
        monitor-exit(r76);	 Catch:{ all -> 0x044a }
        throw r4;
    L_0x044d:
        r4 = "PackageManager";
        r6 = "No BOOTCLASSPATH found!";
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0447 }
    L_0x0454:
        if (r74 == 0) goto L_0x0479;
    L_0x0456:
        r4 = 58;
        r0 = r74;
        r75 = splitString(r0, r4);	 Catch:{ all -> 0x0447 }
        r23 = r75;
        r0 = r23;
        r0 = r0.length;	 Catch:{ all -> 0x0447 }
        r50 = r0;
        r48 = 0;
    L_0x0467:
        r0 = r48;
        r1 = r50;
        if (r0 >= r1) goto L_0x0480;
    L_0x046d:
        r43 = r23[r48];	 Catch:{ all -> 0x0447 }
        r0 = r22;
        r1 = r43;
        r0.add(r1);	 Catch:{ all -> 0x0447 }
        r48 = r48 + 1;
        goto L_0x0467;
    L_0x0479:
        r4 = "PackageManager";
        r6 = "No SYSTEMSERVERCLASSPATH found!";
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0447 }
    L_0x0480:
        r21 = getAllInstructionSets();	 Catch:{ all -> 0x0447 }
        r4 = r21.size();	 Catch:{ all -> 0x0447 }
        r4 = new java.lang.String[r4];	 Catch:{ all -> 0x0447 }
        r0 = r21;
        r4 = r0.toArray(r4);	 Catch:{ all -> 0x0447 }
        r4 = (java.lang.String[]) r4;	 Catch:{ all -> 0x0447 }
        r37 = getDexCodeInstructionSets(r4);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSharedLibraries;	 Catch:{ all -> 0x0447 }
        r4 = r4.size();	 Catch:{ all -> 0x0447 }
        if (r4 <= 0) goto L_0x0556;
    L_0x04a0:
        r23 = r37;
        r0 = r23;
        r0 = r0.length;	 Catch:{ all -> 0x0447 }
        r50 = r0;
        r48 = 0;
        r49 = r48;
    L_0x04ab:
        r0 = r49;
        r1 = r50;
        if (r0 >= r1) goto L_0x0556;
    L_0x04b1:
        r36 = r23[r49];	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSharedLibraries;	 Catch:{ all -> 0x0447 }
        r4 = r4.values();	 Catch:{ all -> 0x0447 }
        r48 = r4.iterator();	 Catch:{ all -> 0x0447 }
    L_0x04bf:
        r4 = r48.hasNext();	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x0550;
    L_0x04c5:
        r53 = r48.next();	 Catch:{ all -> 0x0447 }
        r53 = (com.android.server.pm.PackageManagerService.SharedLibraryEntry) r53;	 Catch:{ all -> 0x0447 }
        r0 = r53;
        r0 = r0.path;	 Catch:{ all -> 0x0447 }
        r51 = r0;
        if (r51 == 0) goto L_0x04bf;
    L_0x04d3:
        r4 = 0;
        r6 = 0;
        r0 = r51;
        r1 = r36;
        r40 = dalvik.system.DexFile.isDexOptNeededInternal(r0, r4, r1, r6);	 Catch:{ FileNotFoundException -> 0x04fa, IOException -> 0x0525 }
        if (r40 == 0) goto L_0x04bf;
    L_0x04df:
        r0 = r22;
        r1 = r51;
        r0.add(r1);	 Catch:{ FileNotFoundException -> 0x04fa, IOException -> 0x0525 }
        r4 = 2;
        r0 = r40;
        if (r0 != r4) goto L_0x0516;
    L_0x04eb:
        r0 = r78;
        r4 = r0.mInstaller;	 Catch:{ FileNotFoundException -> 0x04fa, IOException -> 0x0525 }
        r6 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r8 = 1;
        r0 = r51;
        r1 = r36;
        r4.dexopt(r0, r6, r8, r1);	 Catch:{ FileNotFoundException -> 0x04fa, IOException -> 0x0525 }
        goto L_0x04bf;
    L_0x04fa:
        r42 = move-exception;
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Library not found: ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r51;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0447 }
        goto L_0x04bf;
    L_0x0516:
        r0 = r78;
        r4 = r0.mInstaller;	 Catch:{ FileNotFoundException -> 0x04fa, IOException -> 0x0525 }
        r6 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r8 = 1;
        r0 = r51;
        r1 = r36;
        r4.patchoat(r0, r6, r8, r1);	 Catch:{ FileNotFoundException -> 0x04fa, IOException -> 0x0525 }
        goto L_0x04bf;
    L_0x0525:
        r42 = move-exception;
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Cannot dexopt ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r51;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0447 }
        r8 = "; is it an APK or JAR? ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r8 = r42.getMessage();	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0447 }
        goto L_0x04bf;
    L_0x0550:
        r48 = r49 + 1;
        r49 = r48;
        goto L_0x04ab;
    L_0x0556:
        r45 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r4 = android.os.Environment.getRootDirectory();	 Catch:{ all -> 0x0447 }
        r6 = "framework";
        r0 = r45;
        r0.<init>(r4, r6);	 Catch:{ all -> 0x0447 }
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r4.<init>();	 Catch:{ all -> 0x0447 }
        r6 = r45.getPath();	 Catch:{ all -> 0x0447 }
        r4 = r4.append(r6);	 Catch:{ all -> 0x0447 }
        r6 = "/framework-res.apk";
        r4 = r4.append(r6);	 Catch:{ all -> 0x0447 }
        r4 = r4.toString();	 Catch:{ all -> 0x0447 }
        r0 = r22;
        r0.add(r4);	 Catch:{ all -> 0x0447 }
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r4.<init>();	 Catch:{ all -> 0x0447 }
        r6 = r45.getPath();	 Catch:{ all -> 0x0447 }
        r4 = r4.append(r6);	 Catch:{ all -> 0x0447 }
        r6 = "/core-libart.jar";
        r4 = r4.append(r6);	 Catch:{ all -> 0x0447 }
        r4 = r4.toString();	 Catch:{ all -> 0x0447 }
        r0 = r22;
        r0.add(r4);	 Catch:{ all -> 0x0447 }
        r46 = r45.list();	 Catch:{ all -> 0x0447 }
        if (r46 == 0) goto L_0x065c;
    L_0x05a1:
        r23 = r37;
        r0 = r23;
        r0 = r0.length;	 Catch:{ all -> 0x0447 }
        r50 = r0;
        r48 = 0;
    L_0x05aa:
        r0 = r48;
        r1 = r50;
        if (r0 >= r1) goto L_0x065c;
    L_0x05b0:
        r36 = r23[r48];	 Catch:{ all -> 0x0447 }
        r47 = 0;
    L_0x05b4:
        r0 = r46;
        r4 = r0.length;	 Catch:{ all -> 0x0447 }
        r0 = r47;
        if (r0 >= r4) goto L_0x0658;
    L_0x05bb:
        r54 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r4 = r46[r47];	 Catch:{ all -> 0x0447 }
        r0 = r54;
        r1 = r45;
        r0.<init>(r1, r4);	 Catch:{ all -> 0x0447 }
        r58 = r54.getPath();	 Catch:{ all -> 0x0447 }
        r0 = r22;
        r1 = r58;
        r4 = r0.contains(r1);	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x05d7;
    L_0x05d4:
        r47 = r47 + 1;
        goto L_0x05b4;
    L_0x05d7:
        r4 = ".apk";
        r0 = r58;
        r4 = r0.endsWith(r4);	 Catch:{ all -> 0x0447 }
        if (r4 != 0) goto L_0x05eb;
    L_0x05e1:
        r4 = ".jar";
        r0 = r58;
        r4 = r0.endsWith(r4);	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x05d4;
    L_0x05eb:
        r4 = 0;
        r6 = 0;
        r0 = r58;
        r1 = r36;
        r40 = dalvik.system.DexFile.isDexOptNeededInternal(r0, r4, r1, r6);	 Catch:{ FileNotFoundException -> 0x0609, IOException -> 0x0639 }
        r4 = 2;
        r0 = r40;
        if (r0 != r4) goto L_0x0625;
    L_0x05fa:
        r0 = r78;
        r4 = r0.mInstaller;	 Catch:{ FileNotFoundException -> 0x0609, IOException -> 0x0639 }
        r6 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r8 = 1;
        r0 = r58;
        r1 = r36;
        r4.dexopt(r0, r6, r8, r1);	 Catch:{ FileNotFoundException -> 0x0609, IOException -> 0x0639 }
        goto L_0x05d4;
    L_0x0609:
        r42 = move-exception;
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Jar not found: ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r58;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0447 }
        goto L_0x05d4;
    L_0x0625:
        r4 = 1;
        r0 = r40;
        if (r0 != r4) goto L_0x05d4;
    L_0x062a:
        r0 = r78;
        r4 = r0.mInstaller;	 Catch:{ FileNotFoundException -> 0x0609, IOException -> 0x0639 }
        r6 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r8 = 1;
        r0 = r58;
        r1 = r36;
        r4.patchoat(r0, r6, r8, r1);	 Catch:{ FileNotFoundException -> 0x0609, IOException -> 0x0639 }
        goto L_0x05d4;
    L_0x0639:
        r42 = move-exception;
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Exception reading jar: ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r58;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        r0 = r42;
        android.util.Slog.w(r4, r6, r0);	 Catch:{ all -> 0x0447 }
        goto L_0x05d4;
    L_0x0658:
        r48 = r48 + 1;
        goto L_0x05aa;
    L_0x065c:
        r5 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r4 = "/vendor/overlay";
        r5.<init>(r4);	 Catch:{ all -> 0x0447 }
        r6 = 65;
        r7 = 928; // 0x3a0 float:1.3E-42 double:4.585E-321;
        r8 = 0;
        r4 = r78;
        r4.scanDirLI(r5, r6, r7, r8);	 Catch:{ all -> 0x0447 }
        r8 = 193; // 0xc1 float:2.7E-43 double:9.54E-322;
        r9 = 418; // 0x1a2 float:5.86E-43 double:2.065E-321;
        r10 = 0;
        r6 = r78;
        r7 = r45;
        r6.scanDirLI(r7, r8, r9, r10);	 Catch:{ all -> 0x0447 }
        r7 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r4 = android.os.Environment.getRootDirectory();	 Catch:{ all -> 0x0447 }
        r6 = "priv-app";
        r7.<init>(r4, r6);	 Catch:{ all -> 0x0447 }
        r8 = 193; // 0xc1 float:2.7E-43 double:9.54E-322;
        r9 = 416; // 0x1a0 float:5.83E-43 double:2.055E-321;
        r10 = 0;
        r6 = r78;
        r6.scanDirLI(r7, r8, r9, r10);	 Catch:{ all -> 0x0447 }
        r9 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r4 = android.os.Environment.getRootDirectory();	 Catch:{ all -> 0x0447 }
        r6 = "app";
        r9.<init>(r4, r6);	 Catch:{ all -> 0x0447 }
        r10 = 65;
        r11 = 416; // 0x1a0 float:5.83E-43 double:2.055E-321;
        r12 = 0;
        r8 = r78;
        r8.scanDirLI(r9, r10, r11, r12);	 Catch:{ all -> 0x0447 }
        r11 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r4 = "/vendor/app";
        r11.<init>(r4);	 Catch:{ all -> 0x0447 }
        r11 = r11.getCanonicalFile();	 Catch:{ IOException -> 0x0c28 }
    L_0x06b2:
        r12 = 65;
        r13 = 416; // 0x1a0 float:5.83E-43 double:2.055E-321;
        r14 = 0;
        r10 = r78;
        r10.scanDirLI(r11, r12, r13, r14);	 Catch:{ all -> 0x0447 }
        r13 = new java.io.File;	 Catch:{ all -> 0x0447 }
        r4 = android.os.Environment.getOemDirectory();	 Catch:{ all -> 0x0447 }
        r6 = "app";
        r13.<init>(r4, r6);	 Catch:{ all -> 0x0447 }
        r14 = 65;
        r15 = 416; // 0x1a0 float:5.83E-43 double:2.055E-321;
        r16 = 0;
        r12 = r78;
        r12.scanDirLI(r13, r14, r15, r16);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mInstaller;	 Catch:{ all -> 0x0447 }
        r4.moveFiles();	 Catch:{ all -> 0x0447 }
        r63 = new java.util.ArrayList;	 Catch:{ all -> 0x0447 }
        r63.<init>();	 Catch:{ all -> 0x0447 }
        r44 = new android.util.ArrayMap;	 Catch:{ all -> 0x0447 }
        r44.<init>();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mOnlyCore;	 Catch:{ all -> 0x0447 }
        if (r4 != 0) goto L_0x07f8;
    L_0x06ea:
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4 = r4.mPackages;	 Catch:{ all -> 0x0447 }
        r4 = r4.values();	 Catch:{ all -> 0x0447 }
        r65 = r4.iterator();	 Catch:{ all -> 0x0447 }
    L_0x06f8:
        r4 = r65.hasNext();	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x07f8;
    L_0x06fe:
        r64 = r65.next();	 Catch:{ all -> 0x0447 }
        r64 = (com.android.server.pm.PackageSetting) r64;	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r4 = r0.pkgFlags;	 Catch:{ all -> 0x0447 }
        r4 = r4 & 1;
        if (r4 == 0) goto L_0x06f8;
    L_0x070c:
        r0 = r78;
        r4 = r0.mPackages;	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r6 = r0.name;	 Catch:{ all -> 0x0447 }
        r68 = r4.get(r6);	 Catch:{ all -> 0x0447 }
        r68 = (android.content.pm.PackageParser.Package) r68;	 Catch:{ all -> 0x0447 }
        if (r68 == 0) goto L_0x0794;
    L_0x071c:
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r6 = r0.name;	 Catch:{ all -> 0x0447 }
        r4 = r4.isDisabledSystemPackageLPr(r6);	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x06f8;
    L_0x072a:
        r4 = 5;
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Expecting better updated system app for ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r8 = r0.name;	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r8 = "; removing system app.  Last known codePath=";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r8 = r0.codePathString;	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r8 = ", installStatus=";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r8 = r0.installStatus;	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r8 = ", versionCode=";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r8 = r0.versionCode;	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r8 = "; scanned versionCode=";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r68;
        r8 = r0.mVersionCode;	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        logCriticalInfo(r4, r6);	 Catch:{ all -> 0x0447 }
        r4 = 1;
        r0 = r78;
        r1 = r64;
        r0.removePackageLI(r1, r4);	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r4 = r0.name;	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r6 = r0.codePath;	 Catch:{ all -> 0x0447 }
        r0 = r44;
        r0.put(r4, r6);	 Catch:{ all -> 0x0447 }
        goto L_0x06f8;
    L_0x0794:
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r6 = r0.name;	 Catch:{ all -> 0x0447 }
        r4 = r4.isDisabledSystemPackageLPr(r6);	 Catch:{ all -> 0x0447 }
        if (r4 != 0) goto L_0x07d1;
    L_0x07a2:
        r65.remove();	 Catch:{ all -> 0x0447 }
        r4 = 5;
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "System package ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r8 = r0.name;	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r8 = " no longer exists; wiping its data";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        logCriticalInfo(r4, r6);	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r4 = r0.name;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.removeDataDirsLI(r4);	 Catch:{ all -> 0x0447 }
        goto L_0x06f8;
    L_0x07d1:
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r0 = r64;
        r6 = r0.name;	 Catch:{ all -> 0x0447 }
        r41 = r4.getDisabledSystemPkgLPr(r6);	 Catch:{ all -> 0x0447 }
        r0 = r41;
        r4 = r0.codePath;	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x07ed;
    L_0x07e3:
        r0 = r41;
        r4 = r0.codePath;	 Catch:{ all -> 0x0447 }
        r4 = r4.exists();	 Catch:{ all -> 0x0447 }
        if (r4 != 0) goto L_0x06f8;
    L_0x07ed:
        r0 = r64;
        r4 = r0.name;	 Catch:{ all -> 0x0447 }
        r0 = r63;
        r0.add(r4);	 Catch:{ all -> 0x0447 }
        goto L_0x06f8;
    L_0x07f8:
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r32 = r4.getListOfIncompleteInstallPackagesLPr();	 Catch:{ all -> 0x0447 }
        r47 = 0;
    L_0x0802:
        r4 = r32.size();	 Catch:{ all -> 0x0447 }
        r0 = r47;
        if (r0 >= r4) goto L_0x081c;
    L_0x080a:
        r0 = r32;
        r1 = r47;
        r4 = r0.get(r1);	 Catch:{ all -> 0x0447 }
        r4 = (com.android.server.pm.PackageSetting) r4;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.cleanupInstallFailedPackage(r4);	 Catch:{ all -> 0x0447 }
        r47 = r47 + 1;
        goto L_0x0802;
    L_0x081c:
        r78.deleteTempPackageFiles();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4.pruneSharedUsersLPw();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mOnlyCore;	 Catch:{ all -> 0x0447 }
        if (r4 != 0) goto L_0x09a3;
    L_0x082c:
        r4 = 3080; // 0xc08 float:4.316E-42 double:1.5217E-320;
        r18 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0447 }
        r0 = r18;
        android.util.EventLog.writeEvent(r4, r0);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r15 = r0.mAppInstallDir;	 Catch:{ all -> 0x0447 }
        r16 = 0;
        r17 = 4512; // 0x11a0 float:6.323E-42 double:2.229E-320;
        r18 = 0;
        r14 = r78;
        r14.scanDirLI(r15, r16, r17, r18);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r15 = r0.mDrmAppPrivateInstallDir;	 Catch:{ all -> 0x0447 }
        r16 = 16;
        r17 = 4512; // 0x11a0 float:6.323E-42 double:2.229E-320;
        r18 = 0;
        r14 = r78;
        r14.scanDirLI(r15, r16, r17, r18);	 Catch:{ all -> 0x0447 }
        r48 = r63.iterator();	 Catch:{ all -> 0x0447 }
    L_0x0859:
        r4 = r48.hasNext();	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x08e9;
    L_0x085f:
        r33 = r48.next();	 Catch:{ all -> 0x0447 }
        r33 = (java.lang.String) r33;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mPackages;	 Catch:{ all -> 0x0447 }
        r0 = r33;
        r34 = r4.get(r0);	 Catch:{ all -> 0x0447 }
        r34 = (android.content.pm.PackageParser.Package) r34;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r0 = r33;
        r4.removeDisabledSystemPackageLPw(r0);	 Catch:{ all -> 0x0447 }
        if (r34 != 0) goto L_0x08a5;
    L_0x087c:
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r4.<init>();	 Catch:{ all -> 0x0447 }
        r6 = "Updated system package ";
        r4 = r4.append(r6);	 Catch:{ all -> 0x0447 }
        r0 = r33;
        r4 = r4.append(r0);	 Catch:{ all -> 0x0447 }
        r6 = " no longer exists; wiping its data";
        r4 = r4.append(r6);	 Catch:{ all -> 0x0447 }
        r55 = r4.toString();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r1 = r33;
        r0.removeDataDirsLI(r1);	 Catch:{ all -> 0x0447 }
    L_0x089e:
        r4 = 5;
        r0 = r55;
        logCriticalInfo(r4, r0);	 Catch:{ all -> 0x0447 }
        goto L_0x0859;
    L_0x08a5:
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r4.<init>();	 Catch:{ all -> 0x0447 }
        r6 = "Updated system app + ";
        r4 = r4.append(r6);	 Catch:{ all -> 0x0447 }
        r0 = r33;
        r4 = r4.append(r0);	 Catch:{ all -> 0x0447 }
        r6 = " no longer present; removing system privileges for ";
        r4 = r4.append(r6);	 Catch:{ all -> 0x0447 }
        r0 = r33;
        r4 = r4.append(r0);	 Catch:{ all -> 0x0447 }
        r55 = r4.toString();	 Catch:{ all -> 0x0447 }
        r0 = r34;
        r4 = r0.applicationInfo;	 Catch:{ all -> 0x0447 }
        r6 = r4.flags;	 Catch:{ all -> 0x0447 }
        r6 = r6 & -2;
        r4.flags = r6;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4 = r4.mPackages;	 Catch:{ all -> 0x0447 }
        r0 = r33;
        r35 = r4.get(r0);	 Catch:{ all -> 0x0447 }
        r35 = (com.android.server.pm.PackageSetting) r35;	 Catch:{ all -> 0x0447 }
        r0 = r35;
        r4 = r0.pkgFlags;	 Catch:{ all -> 0x0447 }
        r4 = r4 & -2;
        r0 = r35;
        r0.pkgFlags = r4;	 Catch:{ all -> 0x0447 }
        goto L_0x089e;
    L_0x08e9:
        r47 = 0;
    L_0x08eb:
        r4 = r44.size();	 Catch:{ all -> 0x0447 }
        r0 = r47;
        if (r0 >= r4) goto L_0x09a3;
    L_0x08f3:
        r0 = r44;
        r1 = r47;
        r57 = r0.keyAt(r1);	 Catch:{ all -> 0x0447 }
        r57 = (java.lang.String) r57;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mPackages;	 Catch:{ all -> 0x0447 }
        r0 = r57;
        r4 = r4.containsKey(r0);	 Catch:{ all -> 0x0447 }
        if (r4 != 0) goto L_0x094e;
    L_0x0909:
        r0 = r44;
        r1 = r47;
        r15 = r0.valueAt(r1);	 Catch:{ all -> 0x0447 }
        r15 = (java.io.File) r15;	 Catch:{ all -> 0x0447 }
        r4 = 5;
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Expected better ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r57;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0447 }
        r8 = " but never showed up; reverting to system";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        logCriticalInfo(r4, r6);	 Catch:{ all -> 0x0447 }
        r4 = android.os.FileUtils.contains(r7, r15);	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x0951;
    L_0x0938:
        r16 = 193; // 0xc1 float:2.7E-43 double:9.54E-322;
    L_0x093a:
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r0 = r57;
        r4.enableSystemPackageLPw(r0);	 Catch:{ all -> 0x0447 }
        r17 = 416; // 0x1a0 float:5.83E-43 double:2.055E-321;
        r18 = 0;
        r20 = 0;
        r14 = r78;
        r14.scanPackageLI(r15, r16, r17, r18, r20);	 Catch:{ PackageManagerException -> 0x0985 }
    L_0x094e:
        r47 = r47 + 1;
        goto L_0x08eb;
    L_0x0951:
        r4 = android.os.FileUtils.contains(r9, r15);	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x095a;
    L_0x0957:
        r16 = 65;
        goto L_0x093a;
    L_0x095a:
        r4 = android.os.FileUtils.contains(r11, r15);	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x0963;
    L_0x0960:
        r16 = 65;
        goto L_0x093a;
    L_0x0963:
        r4 = android.os.FileUtils.contains(r13, r15);	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x096c;
    L_0x0969:
        r16 = 65;
        goto L_0x093a;
    L_0x096c:
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Ignoring unexpected fallback path ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r15);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.e(r4, r6);	 Catch:{ all -> 0x0447 }
        goto L_0x094e;
    L_0x0985:
        r42 = move-exception;
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Failed to parse original system package: ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r8 = r42.getMessage();	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.e(r4, r6);	 Catch:{ all -> 0x0447 }
        goto L_0x094e;
    L_0x09a3:
        r78.updateAllSharedLibrariesLPw();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4 = r4.getAllSharedUsersLPw();	 Catch:{ all -> 0x0447 }
        r48 = r4.iterator();	 Catch:{ all -> 0x0447 }
    L_0x09b2:
        r4 = r48.hasNext();	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x09cb;
    L_0x09b8:
        r70 = r48.next();	 Catch:{ all -> 0x0447 }
        r70 = (com.android.server.pm.SharedUserSetting) r70;	 Catch:{ all -> 0x0447 }
        r0 = r70;
        r4 = r0.packages;	 Catch:{ all -> 0x0447 }
        r6 = 0;
        r8 = 0;
        r10 = 0;
        r0 = r78;
        r0.adjustCpuAbisForSharedUserLPw(r4, r6, r8, r10);	 Catch:{ all -> 0x0447 }
        goto L_0x09b2;
    L_0x09cb:
        r0 = r78;
        r4 = r0.mPackageUsage;	 Catch:{ all -> 0x0447 }
        r4.readLP();	 Catch:{ all -> 0x0447 }
        r4 = 3090; // 0xc12 float:4.33E-42 double:1.5267E-320;
        r18 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0447 }
        r0 = r18;
        android.util.EventLog.writeEvent(r4, r0);	 Catch:{ all -> 0x0447 }
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Time to scan packages: ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r18 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0447 }
        r18 = r18 - r72;
        r0 = r18;
        r8 = (float) r0;	 Catch:{ all -> 0x0447 }
        r10 = 1148846080; // 0x447a0000 float:1000.0 double:5.676053805E-315;
        r8 = r8 / r10;
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r8 = " seconds";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.i(r4, r6);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4 = r4.mInternalSdkPlatform;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r6 = r0.mSdkVersion;	 Catch:{ all -> 0x0447 }
        if (r4 == r6) goto L_0x0b04;
    L_0x0a13:
        r66 = 1;
    L_0x0a15:
        if (r66 == 0) goto L_0x0a49;
    L_0x0a17:
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Platform changed from ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r8 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r8 = r8.mInternalSdkPlatform;	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r8 = " to ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r8 = r0.mSdkVersion;	 Catch:{ all -> 0x0447 }
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r8 = "; regranting permissions for internal storage";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.i(r4, r6);	 Catch:{ all -> 0x0447 }
    L_0x0a49:
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r6 = r0.mSdkVersion;	 Catch:{ all -> 0x0447 }
        r4.mInternalSdkPlatform = r6;	 Catch:{ all -> 0x0447 }
        r6 = 0;
        r8 = 0;
        if (r66 == 0) goto L_0x0b08;
    L_0x0a57:
        r4 = 6;
    L_0x0a58:
        r4 = r4 | 1;
        r0 = r78;
        r0.updatePermissionsLPw(r6, r8, r4);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mRestoredSettings;	 Catch:{ all -> 0x0447 }
        if (r4 != 0) goto L_0x0a71;
    L_0x0a65:
        if (r82 != 0) goto L_0x0a71;
    L_0x0a67:
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r6 = 0;
        r0 = r78;
        r4.readDefaultPreferredAppsLPw(r0, r6);	 Catch:{ all -> 0x0447 }
    L_0x0a71:
        r4 = new java.util.ArrayList;	 Catch:{ all -> 0x0447 }
        r4.<init>();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mDisabledComponentsList = r4;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mContext;	 Catch:{ all -> 0x0447 }
        r4 = r4.getResources();	 Catch:{ all -> 0x0447 }
        r6 = 17236035; // 0x1070043 float:2.4795772E-38 double:8.515733E-317;
        r23 = r4.getStringArray(r6);	 Catch:{ all -> 0x0447 }
        r0 = r23;
        r0 = r0.length;	 Catch:{ all -> 0x0447 }
        r50 = r0;
        r48 = 0;
    L_0x0a90:
        r0 = r48;
        r1 = r50;
        if (r0 >= r1) goto L_0x0b14;
    L_0x0a96:
        r56 = r23[r48];	 Catch:{ all -> 0x0447 }
        r29 = android.content.ComponentName.unflattenFromString(r56);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mDisabledComponentsList;	 Catch:{ all -> 0x0447 }
        r0 = r29;
        r4.add(r0);	 Catch:{ all -> 0x0447 }
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Disabling ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r56;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.v(r4, r6);	 Catch:{ all -> 0x0447 }
        r28 = r29.getClassName();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4 = r4.mPackages;	 Catch:{ all -> 0x0447 }
        r6 = r29.getPackageName();	 Catch:{ all -> 0x0447 }
        r62 = r4.get(r6);	 Catch:{ all -> 0x0447 }
        r62 = (com.android.server.pm.PackageSetting) r62;	 Catch:{ all -> 0x0447 }
        if (r62 == 0) goto L_0x0ae7;
    L_0x0ad5:
        r0 = r62;
        r4 = r0.pkg;	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x0ae7;
    L_0x0adb:
        r0 = r62;
        r4 = r0.pkg;	 Catch:{ all -> 0x0447 }
        r0 = r28;
        r4 = r4.hasComponentClassName(r0);	 Catch:{ all -> 0x0447 }
        if (r4 != 0) goto L_0x0b0b;
    L_0x0ae7:
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Unable to disable ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r56;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0447 }
    L_0x0b01:
        r48 = r48 + 1;
        goto L_0x0a90;
    L_0x0b04:
        r66 = 0;
        goto L_0x0a15;
    L_0x0b08:
        r4 = 0;
        goto L_0x0a58;
    L_0x0b0b:
        r4 = 0;
        r0 = r62;
        r1 = r28;
        r0.disableComponentLPw(r1, r4);	 Catch:{ all -> 0x0447 }
        goto L_0x0b01;
    L_0x0b14:
        r0 = r78;
        r4 = r0.mContext;	 Catch:{ all -> 0x0447 }
        r4 = r4.getResources();	 Catch:{ all -> 0x0447 }
        r6 = 17236036; // 0x1070044 float:2.4795775E-38 double:8.5157333E-317;
        r23 = r4.getStringArray(r6);	 Catch:{ all -> 0x0447 }
        r0 = r23;
        r0 = r0.length;	 Catch:{ all -> 0x0447 }
        r50 = r0;
        r48 = 0;
    L_0x0b2a:
        r0 = r48;
        r1 = r50;
        if (r0 >= r1) goto L_0x0b9e;
    L_0x0b30:
        r56 = r23[r48];	 Catch:{ all -> 0x0447 }
        r29 = android.content.ComponentName.unflattenFromString(r56);	 Catch:{ all -> 0x0447 }
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Enabling ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r56;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.v(r4, r6);	 Catch:{ all -> 0x0447 }
        r28 = r29.getClassName();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4 = r4.mPackages;	 Catch:{ all -> 0x0447 }
        r6 = r29.getPackageName();	 Catch:{ all -> 0x0447 }
        r62 = r4.get(r6);	 Catch:{ all -> 0x0447 }
        r62 = (com.android.server.pm.PackageSetting) r62;	 Catch:{ all -> 0x0447 }
        if (r62 == 0) goto L_0x0b78;
    L_0x0b66:
        r0 = r62;
        r4 = r0.pkg;	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x0b78;
    L_0x0b6c:
        r0 = r62;
        r4 = r0.pkg;	 Catch:{ all -> 0x0447 }
        r0 = r28;
        r4 = r4.hasComponentClassName(r0);	 Catch:{ all -> 0x0447 }
        if (r4 != 0) goto L_0x0b95;
    L_0x0b78:
        r4 = "PackageManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0447 }
        r6.<init>();	 Catch:{ all -> 0x0447 }
        r8 = "Unable to enable ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x0447 }
        r0 = r56;
        r6 = r6.append(r0);	 Catch:{ all -> 0x0447 }
        r6 = r6.toString();	 Catch:{ all -> 0x0447 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0447 }
    L_0x0b92:
        r48 = r48 + 1;
        goto L_0x0b2a;
    L_0x0b95:
        r4 = 0;
        r0 = r62;
        r1 = r28;
        r0.enableComponentLPw(r1, r4);	 Catch:{ all -> 0x0447 }
        goto L_0x0b92;
    L_0x0b9e:
        r4 = android.os.Build.FINGERPRINT;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r6 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r6 = r6.mFingerprint;	 Catch:{ all -> 0x0447 }
        r4 = r4.equals(r6);	 Catch:{ all -> 0x0447 }
        if (r4 != 0) goto L_0x0be2;
    L_0x0bac:
        r4 = 1;
    L_0x0bad:
        r0 = r78;
        r0.mIsUpgrade = r4;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mIsUpgrade;	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x0bec;
    L_0x0bb7:
        if (r82 != 0) goto L_0x0bec;
    L_0x0bb9:
        r4 = "PackageManager";
        r6 = "Build fingerprint changed; clearing code caches";
        android.util.Slog.i(r4, r6);	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4 = r4.mPackages;	 Catch:{ all -> 0x0447 }
        r4 = r4.keySet();	 Catch:{ all -> 0x0447 }
        r48 = r4.iterator();	 Catch:{ all -> 0x0447 }
    L_0x0bce:
        r4 = r48.hasNext();	 Catch:{ all -> 0x0447 }
        if (r4 == 0) goto L_0x0be4;
    L_0x0bd4:
        r61 = r48.next();	 Catch:{ all -> 0x0447 }
        r61 = (java.lang.String) r61;	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r1 = r61;
        r0.deleteCodeCacheDirsLI(r1);	 Catch:{ all -> 0x0447 }
        goto L_0x0bce;
    L_0x0be2:
        r4 = 0;
        goto L_0x0bad;
    L_0x0be4:
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r6 = android.os.Build.FINGERPRINT;	 Catch:{ all -> 0x0447 }
        r4.mFingerprint = r6;	 Catch:{ all -> 0x0447 }
    L_0x0bec:
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4.updateInternalDatabaseVersion();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0447 }
        r4.writeLPr();	 Catch:{ all -> 0x0447 }
        r4 = 3100; // 0xc1c float:4.344E-42 double:1.5316E-320;
        r18 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0447 }
        r0 = r18;
        android.util.EventLog.writeEvent(r4, r0);	 Catch:{ all -> 0x0447 }
        r4 = r78.getRequiredVerifierLPr();	 Catch:{ all -> 0x0447 }
        r0 = r78;
        r0.mRequiredVerifierPackage = r4;	 Catch:{ all -> 0x0447 }
        monitor-exit(r77);	 Catch:{ all -> 0x0447 }
        monitor-exit(r76);	 Catch:{ all -> 0x044a }
        r4 = new com.android.server.pm.PackageInstallerService;
        r0 = r78;
        r6 = r0.mAppInstallDir;
        r0 = r79;
        r1 = r78;
        r4.<init>(r0, r1, r6);
        r0 = r78;
        r0.mInstallerService = r4;
        r4 = java.lang.Runtime.getRuntime();
        r4.gc();
        return;
    L_0x0c28:
        r4 = move-exception;
        goto L_0x06b2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageManagerService.<init>(android.content.Context, com.android.server.pm.Installer, boolean, boolean):void");
    }

    public boolean isFirstBoot() {
        return !this.mRestoredSettings ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    public boolean isOnlyCoreApps() {
        return this.mOnlyCore;
    }

    public boolean isUpgrade() {
        return this.mIsUpgrade;
    }

    private String getRequiredVerifierLPr() {
        List<ResolveInfo> receivers = queryIntentReceivers(new Intent("android.intent.action.PACKAGE_NEEDS_VERIFICATION"), PACKAGE_MIME_TYPE, SCAN_TRUSTED_OVERLAY, DEX_OPT_SKIPPED);
        String requiredVerifier = null;
        int N = receivers.size();
        for (int i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            ResolveInfo info = (ResolveInfo) receivers.get(i);
            if (info.activityInfo != null) {
                String packageName = info.activityInfo.packageName;
                GrantedPermissions ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
                if (ps == null) {
                    continue;
                } else {
                    GrantedPermissions gp;
                    if (ps.sharedUser != null) {
                        gp = ps.sharedUser;
                    } else {
                        gp = ps;
                    }
                    if (!gp.grantedPermissions.contains("android.permission.PACKAGE_VERIFICATION_AGENT")) {
                        continue;
                    } else if (requiredVerifier != null) {
                        throw new RuntimeException("There can be only one required verifier");
                    } else {
                        requiredVerifier = packageName;
                    }
                }
            }
        }
        return requiredVerifier;
    }

    public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
        try {
            return super.onTransact(code, data, reply, flags);
        } catch (RuntimeException e) {
            if (!((e instanceof SecurityException) || (e instanceof IllegalArgumentException))) {
                Slog.wtf(TAG, "Package Manager Crash", e);
            }
            throw e;
        }
    }

    void cleanupInstallFailedPackage(PackageSetting ps) {
        logCriticalInfo(INIT_COPY, "Cleaning up incompletely installed app: " + ps.name);
        removeDataDirsLI(ps.name);
        if (ps.codePath != null) {
            if (ps.codePath.isDirectory()) {
                FileUtils.deleteContents(ps.codePath);
            }
            ps.codePath.delete();
        }
        if (!(ps.resourcePath == null || ps.resourcePath.equals(ps.codePath))) {
            if (ps.resourcePath.isDirectory()) {
                FileUtils.deleteContents(ps.resourcePath);
            }
            ps.resourcePath.delete();
        }
        this.mSettings.removePackageLPw(ps.name);
    }

    static int[] appendInts(int[] cur, int[] add) {
        if (add == null) {
            return cur;
        }
        if (cur == null) {
            return add;
        }
        int N = add.length;
        for (int i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            cur = ArrayUtils.appendInt(cur, add[i]);
        }
        return cur;
    }

    static int[] removeInts(int[] cur, int[] rem) {
        if (!(rem == null || cur == null)) {
            int N = rem.length;
            for (int i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
                cur = ArrayUtils.removeInt(cur, rem[i]);
            }
        }
        return cur;
    }

    PackageInfo generatePackageInfo(Package p, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        GrantedPermissions ps = p.mExtras;
        if (ps == null) {
            return null;
        }
        GrantedPermissions gp;
        if (ps.sharedUser != null) {
            gp = ps.sharedUser;
        } else {
            gp = ps;
        }
        return PackageParser.generatePackageInfo(p, gp.gids, flags, ps.firstInstallTime, ps.lastUpdateTime, gp.grantedPermissions, ps.readUserState(userId), userId);
    }

    public boolean isPackageAvailable(String packageName, int userId) {
        boolean z = DEBUG_VERIFY;
        if (sUserManager.exists(userId)) {
            enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "is package available");
            synchronized (this.mPackages) {
                Package p = (Package) this.mPackages.get(packageName);
                if (p != null) {
                    PackageSetting ps = p.mExtras;
                    if (ps != null) {
                        PackageUserState state = ps.readUserState(userId);
                        if (state != null) {
                            z = PackageParser.isAvailable(state);
                        }
                    }
                }
            }
        }
        return z;
    }

    public PackageInfo getPackageInfo(String packageName, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "get package info");
        synchronized (this.mPackages) {
            Package p = (Package) this.mPackages.get(packageName);
            PackageInfo generatePackageInfo;
            if (p != null) {
                generatePackageInfo = generatePackageInfo(p, flags, userId);
                return generatePackageInfo;
            } else if ((flags & DumpState.DUMP_INSTALLS) != 0) {
                generatePackageInfo = generatePackageInfoFromSettingsLPw(packageName, flags, userId);
                return generatePackageInfo;
            } else {
                return null;
            }
        }
    }

    public String[] currentToCanonicalPackageNames(String[] names) {
        String[] out = new String[names.length];
        synchronized (this.mPackages) {
            int i = names.length + DEX_OPT_FAILED;
            while (i >= 0) {
                PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(names[i]);
                String str = (ps == null || ps.realName == null) ? names[i] : ps.realName;
                out[i] = str;
                i += DEX_OPT_FAILED;
            }
        }
        return out;
    }

    public String[] canonicalToCurrentPackageNames(String[] names) {
        String[] out = new String[names.length];
        synchronized (this.mPackages) {
            for (int i = names.length + DEX_OPT_FAILED; i >= 0; i += DEX_OPT_FAILED) {
                String cur = (String) this.mSettings.mRenamedPackages.get(names[i]);
                if (cur == null) {
                    cur = names[i];
                }
                out[i] = cur;
            }
        }
        return out;
    }

    public int getPackageUid(String packageName, int userId) {
        if (!sUserManager.exists(userId)) {
            return DEX_OPT_FAILED;
        }
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "get package uid");
        synchronized (this.mPackages) {
            Package p = (Package) this.mPackages.get(packageName);
            if (p != null) {
                int uid = UserHandle.getUid(userId, p.applicationInfo.uid);
                return uid;
            }
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
            if (ps == null || ps.pkg == null || ps.pkg.applicationInfo == null) {
                return DEX_OPT_FAILED;
            }
            p = ps.pkg;
            uid = p != null ? UserHandle.getUid(userId, p.applicationInfo.uid) : DEX_OPT_FAILED;
            return uid;
        }
    }

    public int[] getPackageGids(String packageName) {
        synchronized (this.mPackages) {
            Package p = (Package) this.mPackages.get(packageName);
            if (p != null) {
                int[] gids = p.mExtras.getGids();
                return gids;
            }
            return new int[DEX_OPT_SKIPPED];
        }
    }

    static final PermissionInfo generatePermissionInfo(BasePermission bp, int flags) {
        if (bp.perm != null) {
            return PackageParser.generatePermissionInfo(bp.perm, flags);
        }
        PermissionInfo pi = new PermissionInfo();
        pi.name = bp.name;
        pi.packageName = bp.sourcePackage;
        pi.nonLocalizedLabel = bp.name;
        pi.protectionLevel = bp.protectionLevel;
        return pi;
    }

    public PermissionInfo getPermissionInfo(String name, int flags) {
        PermissionInfo generatePermissionInfo;
        synchronized (this.mPackages) {
            BasePermission p = (BasePermission) this.mSettings.mPermissions.get(name);
            if (p != null) {
                generatePermissionInfo = generatePermissionInfo(p, flags);
            } else {
                generatePermissionInfo = null;
            }
        }
        return generatePermissionInfo;
    }

    public List<PermissionInfo> queryPermissionsByGroup(String group, int flags) {
        ArrayList<PermissionInfo> out;
        synchronized (this.mPackages) {
            out = new ArrayList(MCS_RECONNECT);
            for (BasePermission p : this.mSettings.mPermissions.values()) {
                if (group == null) {
                    if (p.perm == null || p.perm.info.group == null) {
                        out.add(generatePermissionInfo(p, flags));
                    }
                } else if (p.perm != null && group.equals(p.perm.info.group)) {
                    out.add(PackageParser.generatePermissionInfo(p.perm, flags));
                }
            }
            if (out.size() > 0) {
            } else {
                if (!this.mPermissionGroups.containsKey(group)) {
                    out = null;
                }
            }
        }
        return out;
    }

    public PermissionGroupInfo getPermissionGroupInfo(String name, int flags) {
        PermissionGroupInfo generatePermissionGroupInfo;
        synchronized (this.mPackages) {
            generatePermissionGroupInfo = PackageParser.generatePermissionGroupInfo((PermissionGroup) this.mPermissionGroups.get(name), flags);
        }
        return generatePermissionGroupInfo;
    }

    public List<PermissionGroupInfo> getAllPermissionGroups(int flags) {
        ArrayList<PermissionGroupInfo> out;
        synchronized (this.mPackages) {
            out = new ArrayList(this.mPermissionGroups.size());
            for (PermissionGroup pg : this.mPermissionGroups.values()) {
                out.add(PackageParser.generatePermissionGroupInfo(pg, flags));
            }
        }
        return out;
    }

    private ApplicationInfo generateApplicationInfoFromSettingsLPw(String packageName, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
        if (ps == null) {
            return null;
        }
        if (ps.pkg != null) {
            return PackageParser.generateApplicationInfo(ps.pkg, flags, ps.readUserState(userId), userId);
        }
        PackageInfo pInfo = generatePackageInfoFromSettingsLPw(packageName, flags, userId);
        if (pInfo != null) {
            return pInfo.applicationInfo;
        }
        return null;
    }

    private PackageInfo generatePackageInfoFromSettingsLPw(String packageName, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
        if (ps == null) {
            return null;
        }
        Package pkg = ps.pkg;
        if (pkg == null) {
            if ((flags & DumpState.DUMP_INSTALLS) == 0) {
                return null;
            }
            pkg = new Package(packageName);
            pkg.applicationInfo.packageName = packageName;
            pkg.applicationInfo.flags = ps.pkgFlags | 16777216;
            pkg.applicationInfo.dataDir = getDataPathForPackage(packageName, DEX_OPT_SKIPPED).getPath();
            pkg.applicationInfo.primaryCpuAbi = ps.primaryCpuAbiString;
            pkg.applicationInfo.secondaryCpuAbi = ps.secondaryCpuAbiString;
        }
        return generatePackageInfo(pkg, flags, userId);
    }

    public ApplicationInfo getApplicationInfo(String packageName, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "get application info");
        synchronized (this.mPackages) {
            Package p = (Package) this.mPackages.get(packageName);
            ApplicationInfo generateApplicationInfo;
            if (p != null) {
                PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
                if (ps == null) {
                    return null;
                }
                generateApplicationInfo = PackageParser.generateApplicationInfo(p, flags, ps.readUserState(userId), userId);
                return generateApplicationInfo;
            } else if ("android".equals(packageName) || "system".equals(packageName)) {
                generateApplicationInfo = this.mAndroidApplication;
                return generateApplicationInfo;
            } else if ((flags & DumpState.DUMP_INSTALLS) != 0) {
                generateApplicationInfo = generateApplicationInfoFromSettingsLPw(packageName, flags, userId);
                return generateApplicationInfo;
            } else {
                return null;
            }
        }
    }

    public void freeStorageAndNotify(long freeStorageSize, IPackageDataObserver observer) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CLEAR_APP_CACHE", null);
        this.mHandler.post(new C04471(freeStorageSize, observer));
    }

    public void freeStorage(long freeStorageSize, IntentSender pi) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CLEAR_APP_CACHE", null);
        this.mHandler.post(new C04482(freeStorageSize, pi));
    }

    void freeStorage(long freeStorageSize) throws IOException {
        synchronized (this.mInstallLock) {
            if (this.mInstaller.freeCache(freeStorageSize) < 0) {
                throw new IOException("Failed to free enough space");
            }
        }
    }

    public ActivityInfo getActivityInfo(ComponentName component, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "get activity info");
        synchronized (this.mPackages) {
            Activity a = (Activity) this.mActivities.mActivities.get(component);
            ActivityInfo generateActivityInfo;
            if (a != null && this.mSettings.isEnabledLPr(a.info, flags, userId)) {
                PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(component.getPackageName());
                if (ps == null) {
                    return null;
                }
                generateActivityInfo = PackageParser.generateActivityInfo(a, flags, ps.readUserState(userId), userId);
                return generateActivityInfo;
            } else if (this.mResolveComponentName.equals(component)) {
                generateActivityInfo = PackageParser.generateActivityInfo(this.mResolveActivity, flags, new PackageUserState(), userId);
                return generateActivityInfo;
            } else {
                return null;
            }
        }
    }

    public boolean activitySupportsIntent(ComponentName component, Intent intent, String resolvedType) {
        synchronized (this.mPackages) {
            Activity a = (Activity) this.mActivities.mActivities.get(component);
            if (a == null) {
                return DEBUG_VERIFY;
            }
            for (int i = DEX_OPT_SKIPPED; i < a.intents.size(); i += UPDATE_PERMISSIONS_ALL) {
                if (((ActivityIntentInfo) a.intents.get(i)).match(intent.getAction(), resolvedType, intent.getScheme(), intent.getData(), intent.getCategories(), TAG) >= 0) {
                    return DEFAULT_VERIFY_ENABLE;
                }
            }
            return DEBUG_VERIFY;
        }
    }

    public ActivityInfo getReceiverInfo(ComponentName component, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "get receiver info");
        synchronized (this.mPackages) {
            Activity a = (Activity) this.mReceivers.mActivities.get(component);
            if (a == null || !this.mSettings.isEnabledLPr(a.info, flags, userId)) {
                return null;
            }
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(component.getPackageName());
            if (ps == null) {
                return null;
            }
            ActivityInfo generateActivityInfo = PackageParser.generateActivityInfo(a, flags, ps.readUserState(userId), userId);
            return generateActivityInfo;
        }
    }

    public ServiceInfo getServiceInfo(ComponentName component, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "get service info");
        synchronized (this.mPackages) {
            Service s = (Service) this.mServices.mServices.get(component);
            if (s == null || !this.mSettings.isEnabledLPr(s.info, flags, userId)) {
                return null;
            }
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(component.getPackageName());
            if (ps == null) {
                return null;
            }
            ServiceInfo generateServiceInfo = PackageParser.generateServiceInfo(s, flags, ps.readUserState(userId), userId);
            return generateServiceInfo;
        }
    }

    public ProviderInfo getProviderInfo(ComponentName component, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "get provider info");
        synchronized (this.mPackages) {
            Provider p = (Provider) this.mProviders.mProviders.get(component);
            if (p == null || !this.mSettings.isEnabledLPr(p.info, flags, userId)) {
                return null;
            }
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(component.getPackageName());
            if (ps == null) {
                return null;
            }
            ProviderInfo generateProviderInfo = PackageParser.generateProviderInfo(p, flags, ps.readUserState(userId), userId);
            return generateProviderInfo;
        }
    }

    public String[] getSystemSharedLibraryNames() {
        synchronized (this.mPackages) {
            Set<String> libSet = this.mSharedLibraries.keySet();
            int size = libSet.size();
            if (size > 0) {
                String[] libs = new String[size];
                libSet.toArray(libs);
                return libs;
            }
            return null;
        }
    }

    public FeatureInfo[] getSystemAvailableFeatures() {
        synchronized (this.mPackages) {
            Collection<FeatureInfo> featSet = this.mAvailableFeatures.values();
            int size = featSet.size();
            if (size > 0) {
                FeatureInfo[] features = new FeatureInfo[(size + UPDATE_PERMISSIONS_ALL)];
                featSet.toArray(features);
                FeatureInfo fi = new FeatureInfo();
                fi.reqGlEsVersion = SystemProperties.getInt("ro.opengles.version", DEX_OPT_SKIPPED);
                features[size] = fi;
                return features;
            }
            return null;
        }
    }

    public boolean hasSystemFeature(String name) {
        boolean containsKey;
        synchronized (this.mPackages) {
            containsKey = this.mAvailableFeatures.containsKey(name);
        }
        return containsKey;
    }

    private void checkValidCaller(int uid, int userId) {
        if (UserHandle.getUserId(uid) != userId && uid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && uid != 0) {
            throw new SecurityException("Caller uid=" + uid + " is not privileged to communicate with user=" + userId);
        }
    }

    public int checkPermission(String permName, String pkgName) {
        synchronized (this.mPackages) {
            Package p = (Package) this.mPackages.get(pkgName);
            if (!(p == null || p.mExtras == null)) {
                PackageSetting ps = p.mExtras;
                if (ps.sharedUser != null) {
                    if (ps.sharedUser.grantedPermissions.contains(permName)) {
                        return DEX_OPT_SKIPPED;
                    }
                } else if (ps.grantedPermissions.contains(permName)) {
                    return DEX_OPT_SKIPPED;
                }
            }
            return DEX_OPT_FAILED;
        }
    }

    public int checkUidPermission(String permName, int uid) {
        synchronized (this.mPackages) {
            Object obj = this.mSettings.getUserIdLPr(UserHandle.getAppId(uid));
            if (obj != null) {
                if (((GrantedPermissions) obj).grantedPermissions.contains(permName)) {
                    return DEX_OPT_SKIPPED;
                }
            }
            ArraySet<String> perms = (ArraySet) this.mSystemPermissions.get(uid);
            if (perms != null && perms.contains(permName)) {
                return DEX_OPT_SKIPPED;
            }
            return DEX_OPT_FAILED;
        }
    }

    void enforceCrossUserPermission(int callingUid, int userId, boolean requireFullPermission, boolean checkShell, String message) {
        if (userId < 0) {
            throw new IllegalArgumentException("Invalid userId " + userId);
        }
        if (checkShell) {
            enforceShellRestriction("no_debugging_features", callingUid, userId);
        }
        if (userId != UserHandle.getUserId(callingUid) && callingUid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && callingUid != 0) {
            if (requireFullPermission) {
                this.mContext.enforceCallingOrSelfPermission("android.permission.INTERACT_ACROSS_USERS_FULL", message);
                return;
            }
            try {
                this.mContext.enforceCallingOrSelfPermission("android.permission.INTERACT_ACROSS_USERS_FULL", message);
            } catch (SecurityException e) {
                this.mContext.enforceCallingOrSelfPermission("android.permission.INTERACT_ACROSS_USERS", message);
            }
        }
    }

    void enforceShellRestriction(String restriction, int callingUid, int userHandle) {
        if (callingUid != SHELL_UID) {
            return;
        }
        if (userHandle >= 0 && sUserManager.hasUserRestriction(restriction, userHandle)) {
            throw new SecurityException("Shell does not have permission to access user " + userHandle);
        } else if (userHandle < 0) {
            Slog.e(TAG, "Unable to check shell permission for user " + userHandle + "\n\t" + Debug.getCallers(MCS_BOUND));
        }
    }

    private BasePermission findPermissionTreeLP(String permName) {
        for (BasePermission bp : this.mSettings.mPermissionTrees.values()) {
            if (permName.startsWith(bp.name) && permName.length() > bp.name.length() && permName.charAt(bp.name.length()) == '.') {
                return bp;
            }
        }
        return null;
    }

    private BasePermission checkPermissionTreeLP(String permName) {
        if (permName != null) {
            BasePermission bp = findPermissionTreeLP(permName);
            if (bp != null) {
                if (bp.uid == UserHandle.getAppId(Binder.getCallingUid())) {
                    return bp;
                }
                throw new SecurityException("Calling uid " + Binder.getCallingUid() + " is not allowed to add to permission tree " + bp.name + " owned by uid " + bp.uid);
            }
        }
        throw new SecurityException("No permission tree found for " + permName);
    }

    static boolean compareStrings(CharSequence s1, CharSequence s2) {
        if (s1 == null) {
            if (s2 == null) {
                return DEFAULT_VERIFY_ENABLE;
            }
            return DEBUG_VERIFY;
        } else if (s2 == null || s1.getClass() != s2.getClass()) {
            return DEBUG_VERIFY;
        } else {
            return s1.equals(s2);
        }
    }

    static boolean comparePermissionInfos(PermissionInfo pi1, PermissionInfo pi2) {
        if (pi1.icon == pi2.icon && pi1.logo == pi2.logo && pi1.protectionLevel == pi2.protectionLevel && compareStrings(pi1.name, pi2.name) && compareStrings(pi1.nonLocalizedLabel, pi2.nonLocalizedLabel) && compareStrings(pi1.packageName, pi2.packageName)) {
            return DEFAULT_VERIFY_ENABLE;
        }
        return DEBUG_VERIFY;
    }

    int permissionInfoFootprint(PermissionInfo info) {
        int size = info.name.length();
        if (info.nonLocalizedLabel != null) {
            size += info.nonLocalizedLabel.length();
        }
        if (info.nonLocalizedDescription != null) {
            return size + info.nonLocalizedDescription.length();
        }
        return size;
    }

    int calculateCurrentPermissionFootprintLocked(BasePermission tree) {
        int size = DEX_OPT_SKIPPED;
        for (BasePermission perm : this.mSettings.mPermissions.values()) {
            if (perm.uid == tree.uid) {
                size += perm.name.length() + permissionInfoFootprint(perm.perm.info);
            }
        }
        return size;
    }

    void enforcePermissionCapLocked(PermissionInfo info, BasePermission tree) {
        if (tree.uid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            if (permissionInfoFootprint(info) + calculateCurrentPermissionFootprintLocked(tree) > MAX_PERMISSION_TREE_FOOTPRINT) {
                throw new SecurityException("Permission tree size cap exceeded");
            }
        }
    }

    boolean addPermissionLocked(PermissionInfo info, boolean async) {
        if (info.labelRes == 0 && info.nonLocalizedLabel == null) {
            throw new SecurityException("Label must be specified in permission");
        }
        BasePermission tree = checkPermissionTreeLP(info.name);
        BasePermission bp = (BasePermission) this.mSettings.mPermissions.get(info.name);
        boolean added = bp == null ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
        boolean changed = DEFAULT_VERIFY_ENABLE;
        int fixedLevel = PermissionInfo.fixProtectionLevel(info.protectionLevel);
        if (added) {
            enforcePermissionCapLocked(info, tree);
            bp = new BasePermission(info.name, tree.sourcePackage, UPDATE_PERMISSIONS_REPLACE_PKG);
        } else if (bp.type != UPDATE_PERMISSIONS_REPLACE_PKG) {
            throw new SecurityException("Not allowed to modify non-dynamic permission " + info.name);
        } else if (bp.protectionLevel == fixedLevel && bp.perm.owner.equals(tree.perm.owner) && bp.uid == tree.uid && comparePermissionInfos(bp.perm.info, info)) {
            changed = DEBUG_VERIFY;
        }
        bp.protectionLevel = fixedLevel;
        PermissionInfo info2 = new PermissionInfo(info);
        info2.protectionLevel = fixedLevel;
        bp.perm = new Permission(tree.perm.owner, info2);
        bp.perm.info.packageName = tree.perm.info.packageName;
        bp.uid = tree.uid;
        if (added) {
            this.mSettings.mPermissions.put(info2.name, bp);
        }
        if (changed) {
            if (async) {
                scheduleWriteSettingsLocked();
            } else {
                this.mSettings.writeLPr();
            }
        }
        return added;
    }

    public boolean addPermission(PermissionInfo info) {
        boolean addPermissionLocked;
        synchronized (this.mPackages) {
            addPermissionLocked = addPermissionLocked(info, DEBUG_VERIFY);
        }
        return addPermissionLocked;
    }

    public boolean addPermissionAsync(PermissionInfo info) {
        boolean addPermissionLocked;
        synchronized (this.mPackages) {
            addPermissionLocked = addPermissionLocked(info, DEFAULT_VERIFY_ENABLE);
        }
        return addPermissionLocked;
    }

    public void removePermission(String name) {
        synchronized (this.mPackages) {
            checkPermissionTreeLP(name);
            BasePermission bp = (BasePermission) this.mSettings.mPermissions.get(name);
            if (bp != null) {
                if (bp.type != UPDATE_PERMISSIONS_REPLACE_PKG) {
                    throw new SecurityException("Not allowed to modify non-dynamic permission " + name);
                }
                this.mSettings.mPermissions.remove(name);
                this.mSettings.writeLPr();
            }
        }
    }

    private static void checkGrantRevokePermissions(Package pkg, BasePermission bp) {
        int index = pkg.requestedPermissions.indexOf(bp.name);
        if (index == DEX_OPT_FAILED) {
            throw new SecurityException("Package " + pkg.packageName + " has not requested permission " + bp.name);
        }
        boolean isNormal;
        if ((bp.protectionLevel & PACKAGE_VERIFIED) == 0) {
            isNormal = DEFAULT_VERIFY_ENABLE;
        } else {
            isNormal = DEBUG_VERIFY;
        }
        boolean isDangerous;
        if ((bp.protectionLevel & PACKAGE_VERIFIED) == UPDATE_PERMISSIONS_ALL) {
            isDangerous = DEFAULT_VERIFY_ENABLE;
        } else {
            isDangerous = DEBUG_VERIFY;
        }
        boolean isDevelopment;
        if ((bp.protectionLevel & SCAN_NO_PATHS) != 0) {
            isDevelopment = DEFAULT_VERIFY_ENABLE;
        } else {
            isDevelopment = DEBUG_VERIFY;
        }
        if (!isNormal && !isDangerous && !isDevelopment) {
            throw new SecurityException("Permission " + bp.name + " is not a changeable permission type");
        } else if ((isNormal || isDangerous) && ((Boolean) pkg.requestedPermissionsRequired.get(index)).booleanValue()) {
            throw new SecurityException("Can't change " + bp.name + ". It is required by the application");
        }
    }

    public void grantPermission(String packageName, String permissionName) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.GRANT_REVOKE_PERMISSIONS", null);
        synchronized (this.mPackages) {
            Package pkg = (Package) this.mPackages.get(packageName);
            if (pkg == null) {
                throw new IllegalArgumentException("Unknown package: " + packageName);
            }
            BasePermission bp = (BasePermission) this.mSettings.mPermissions.get(permissionName);
            if (bp == null) {
                throw new IllegalArgumentException("Unknown permission: " + permissionName);
            }
            checkGrantRevokePermissions(pkg, bp);
            GrantedPermissions ps = pkg.mExtras;
            if (ps == null) {
                return;
            }
            GrantedPermissions gp;
            if (ps.sharedUser != null) {
                gp = ps.sharedUser;
            } else {
                gp = ps;
            }
            if (gp.grantedPermissions.add(permissionName)) {
                if (ps.haveGids) {
                    gp.gids = appendInts(gp.gids, bp.gids);
                }
                this.mSettings.writeLPr();
            }
        }
    }

    public void revokePermission(String packageName, String permissionName) {
        int changedAppId = DEX_OPT_FAILED;
        synchronized (this.mPackages) {
            Package pkg = (Package) this.mPackages.get(packageName);
            if (pkg == null) {
                throw new IllegalArgumentException("Unknown package: " + packageName);
            }
            if (pkg.applicationInfo.uid != Binder.getCallingUid()) {
                this.mContext.enforceCallingOrSelfPermission("android.permission.GRANT_REVOKE_PERMISSIONS", null);
            }
            BasePermission bp = (BasePermission) this.mSettings.mPermissions.get(permissionName);
            if (bp == null) {
                throw new IllegalArgumentException("Unknown permission: " + permissionName);
            }
            checkGrantRevokePermissions(pkg, bp);
            GrantedPermissions ps = pkg.mExtras;
            if (ps == null) {
                return;
            }
            GrantedPermissions gp;
            if (ps.sharedUser != null) {
                gp = ps.sharedUser;
            } else {
                gp = ps;
            }
            if (gp.grantedPermissions.remove(permissionName)) {
                gp.grantedPermissions.remove(permissionName);
                if (ps.haveGids) {
                    gp.gids = removeInts(gp.gids, bp.gids);
                }
                this.mSettings.writeLPr();
                changedAppId = ps.appId;
            }
            if (changedAppId >= 0) {
                IActivityManager am = ActivityManagerNative.getDefault();
                if (am != null) {
                    int callingUserId = UserHandle.getCallingUserId();
                    long ident = Binder.clearCallingIdentity();
                    try {
                        int[] arr$ = sUserManager.getUserIds();
                        int len$ = arr$.length;
                        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
                            am.killUid(UserHandle.getUid(arr$[i$], changedAppId), "revoke " + permissionName);
                        }
                    } catch (RemoteException e) {
                    } finally {
                        Binder.restoreCallingIdentity(ident);
                    }
                }
            }
        }
    }

    public boolean isProtectedBroadcast(String actionName) {
        boolean contains;
        synchronized (this.mPackages) {
            contains = this.mProtectedBroadcasts.contains(actionName);
        }
        return contains;
    }

    public int checkSignatures(String pkg1, String pkg2) {
        int i;
        synchronized (this.mPackages) {
            Package p1 = (Package) this.mPackages.get(pkg1);
            Package p2 = (Package) this.mPackages.get(pkg2);
            if (p1 == null || p1.mExtras == null || p2 == null || p2.mExtras == null) {
                i = -4;
            } else {
                i = compareSignatures(p1.mSignatures, p2.mSignatures);
            }
        }
        return i;
    }

    public int checkUidSignatures(int uid1, int uid2) {
        int i = -4;
        uid1 = UserHandle.getAppId(uid1);
        uid2 = UserHandle.getAppId(uid2);
        synchronized (this.mPackages) {
            Object obj = this.mSettings.getUserIdLPr(uid1);
            if (obj != null) {
                Signature[] s1;
                if (obj instanceof SharedUserSetting) {
                    s1 = ((SharedUserSetting) obj).signatures.mSignatures;
                } else if (obj instanceof PackageSetting) {
                    s1 = ((PackageSetting) obj).signatures.mSignatures;
                }
                obj = this.mSettings.getUserIdLPr(uid2);
                if (obj != null) {
                    Signature[] s2;
                    if (obj instanceof SharedUserSetting) {
                        s2 = ((SharedUserSetting) obj).signatures.mSignatures;
                    } else if (obj instanceof PackageSetting) {
                        s2 = ((PackageSetting) obj).signatures.mSignatures;
                    }
                    i = compareSignatures(s1, s2);
                }
            }
        }
        return i;
    }

    static int compareSignatures(Signature[] s1, Signature[] s2) {
        if (s1 == null) {
            if (s2 == null) {
                return UPDATE_PERMISSIONS_ALL;
            }
            return DEX_OPT_FAILED;
        } else if (s2 == null) {
            return -2;
        } else {
            if (s1.length != s2.length) {
                return -3;
            }
            if (s1.length == UPDATE_PERMISSIONS_ALL) {
                return s1[DEX_OPT_SKIPPED].equals(s2[DEX_OPT_SKIPPED]) ? DEX_OPT_SKIPPED : -3;
            } else {
                int i$;
                ArraySet<Signature> set1 = new ArraySet();
                Signature[] arr$ = s1;
                int len$ = arr$.length;
                for (i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
                    set1.add(arr$[i$]);
                }
                ArraySet<Signature> set2 = new ArraySet();
                arr$ = s2;
                len$ = arr$.length;
                for (i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
                    set2.add(arr$[i$]);
                }
                if (set1.equals(set2)) {
                    return DEX_OPT_SKIPPED;
                }
                return -3;
            }
        }
    }

    private boolean isCompatSignatureUpdateNeeded(Package scannedPkg) {
        return (!(isExternal(scannedPkg) && this.mSettings.isExternalDatabaseVersionOlderThan(UPDATE_PERMISSIONS_REPLACE_PKG)) && (isExternal(scannedPkg) || !this.mSettings.isInternalDatabaseVersionOlderThan(UPDATE_PERMISSIONS_REPLACE_PKG))) ? DEBUG_VERIFY : DEFAULT_VERIFY_ENABLE;
    }

    private int compareSignaturesCompat(PackageSignatures existingSigs, Package scannedPkg) {
        if (!isCompatSignatureUpdateNeeded(scannedPkg)) {
            return -3;
        }
        int i$;
        ArraySet<Signature> existingSet = new ArraySet();
        Signature[] arr$ = existingSigs.mSignatures;
        int len$ = arr$.length;
        for (i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            existingSet.add(arr$[i$]);
        }
        ArraySet<Signature> scannedCompatSet = new ArraySet();
        arr$ = scannedPkg.mSignatures;
        len$ = arr$.length;
        for (int i = DEX_OPT_SKIPPED; i < len$; i += UPDATE_PERMISSIONS_ALL) {
            Signature sig = arr$[i];
            try {
                Signature[] arr$2 = sig.getChainSignatures();
                int len$2 = arr$2.length;
                for (i$ = DEX_OPT_SKIPPED; i$ < len$2; i$ += UPDATE_PERMISSIONS_ALL) {
                    scannedCompatSet.add(arr$2[i$]);
                }
            } catch (CertificateEncodingException e) {
                scannedCompatSet.add(sig);
            }
        }
        if (!scannedCompatSet.equals(existingSet)) {
            return -3;
        }
        existingSigs.assignSignatures(scannedPkg.mSignatures);
        synchronized (this.mPackages) {
            this.mSettings.mKeySetManagerService.removeAppKeySetDataLPw(scannedPkg.packageName);
        }
        return DEX_OPT_SKIPPED;
    }

    private boolean isRecoverSignatureUpdateNeeded(Package scannedPkg) {
        if (isExternal(scannedPkg)) {
            return this.mSettings.isExternalDatabaseVersionOlderThan(MCS_BOUND);
        }
        return this.mSettings.isInternalDatabaseVersionOlderThan(MCS_BOUND);
    }

    private int compareSignaturesRecover(PackageSignatures existingSigs, Package scannedPkg) {
        if (!isRecoverSignatureUpdateNeeded(scannedPkg)) {
            return -3;
        }
        String msg = null;
        try {
            if (Signature.areEffectiveMatch(existingSigs.mSignatures, scannedPkg.mSignatures)) {
                logCriticalInfo(UPDATE_PERMISSIONS_REPLACE_ALL, "Recovered effectively matching certificates for " + scannedPkg.packageName);
                return DEX_OPT_SKIPPED;
            }
        } catch (CertificateException e) {
            msg = e.getMessage();
        }
        logCriticalInfo(UPDATE_PERMISSIONS_REPLACE_ALL, "Failed to recover certificates for " + scannedPkg.packageName + ": " + msg);
        return -3;
    }

    public String[] getPackagesForUid(int uid) {
        uid = UserHandle.getAppId(uid);
        synchronized (this.mPackages) {
            Object obj = this.mSettings.getUserIdLPr(uid);
            String[] res;
            if (obj instanceof SharedUserSetting) {
                SharedUserSetting sus = (SharedUserSetting) obj;
                res = new String[sus.packages.size()];
                Iterator<PackageSetting> it = sus.packages.iterator();
                int i = DEX_OPT_SKIPPED;
                while (it.hasNext()) {
                    int i2 = i + UPDATE_PERMISSIONS_ALL;
                    res[i] = ((PackageSetting) it.next()).name;
                    i = i2;
                }
                return res;
            } else if (obj instanceof PackageSetting) {
                res = new String[UPDATE_PERMISSIONS_ALL];
                res[DEX_OPT_SKIPPED] = ((PackageSetting) obj).name;
                return res;
            } else {
                return null;
            }
        }
    }

    public String getNameForUid(int uid) {
        synchronized (this.mPackages) {
            Object obj = this.mSettings.getUserIdLPr(UserHandle.getAppId(uid));
            String str;
            if (obj instanceof SharedUserSetting) {
                SharedUserSetting sus = (SharedUserSetting) obj;
                str = sus.name + ":" + sus.userId;
                return str;
            } else if (obj instanceof PackageSetting) {
                str = ((PackageSetting) obj).name;
                return str;
            } else {
                return null;
            }
        }
    }

    public int getUidForSharedUser(String sharedUserName) {
        int i = DEX_OPT_FAILED;
        if (sharedUserName != null) {
            synchronized (this.mPackages) {
                SharedUserSetting suid = this.mSettings.getSharedUserLPw(sharedUserName, DEX_OPT_SKIPPED, DEBUG_VERIFY);
                if (suid == null) {
                } else {
                    i = suid.userId;
                }
            }
        }
        return i;
    }

    public int getFlagsForUid(int uid) {
        synchronized (this.mPackages) {
            Object obj = this.mSettings.getUserIdLPr(UserHandle.getAppId(uid));
            int i;
            if (obj instanceof SharedUserSetting) {
                i = ((SharedUserSetting) obj).pkgFlags;
                return i;
            } else if (obj instanceof PackageSetting) {
                i = ((PackageSetting) obj).pkgFlags;
                return i;
            } else {
                return DEX_OPT_SKIPPED;
            }
        }
    }

    public boolean isUidPrivileged(int uid) {
        uid = UserHandle.getAppId(uid);
        synchronized (this.mPackages) {
            Object obj = this.mSettings.getUserIdLPr(uid);
            if (obj instanceof SharedUserSetting) {
                Iterator<PackageSetting> it = ((SharedUserSetting) obj).packages.iterator();
                while (it.hasNext()) {
                    if (((PackageSetting) it.next()).isPrivileged()) {
                        return DEFAULT_VERIFY_ENABLE;
                    }
                }
            } else if (obj instanceof PackageSetting) {
                boolean isPrivileged = ((PackageSetting) obj).isPrivileged();
                return isPrivileged;
            }
            return DEBUG_VERIFY;
        }
    }

    public String[] getAppOpPermissionPackages(String permissionName) {
        String[] strArr;
        synchronized (this.mPackages) {
            ArraySet<String> pkgs = (ArraySet) this.mAppOpPermissionPackages.get(permissionName);
            if (pkgs == null) {
                strArr = null;
            } else {
                strArr = (String[]) pkgs.toArray(new String[pkgs.size()]);
            }
        }
        return strArr;
    }

    public ResolveInfo resolveIntent(Intent intent, String resolvedType, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "resolve intent");
        return chooseBestActivity(intent, resolvedType, flags, queryIntentActivities(intent, resolvedType, flags, userId), userId);
    }

    public void setLastChosenActivity(Intent intent, String resolvedType, int flags, IntentFilter filter, int match, ComponentName activity) {
        int userId = UserHandle.getCallingUserId();
        intent.setComponent(null);
        findPreferredActivity(intent, resolvedType, flags, queryIntentActivities(intent, resolvedType, flags, userId), DEX_OPT_SKIPPED, DEBUG_VERIFY, DEFAULT_VERIFY_ENABLE, DEBUG_VERIFY, userId);
        addPreferredActivityInternal(filter, match, null, activity, DEBUG_VERIFY, userId, "Setting last chosen");
    }

    public ResolveInfo getLastChosenActivity(Intent intent, String resolvedType, int flags) {
        int userId = UserHandle.getCallingUserId();
        return findPreferredActivity(intent, resolvedType, flags, queryIntentActivities(intent, resolvedType, flags, userId), DEX_OPT_SKIPPED, DEBUG_VERIFY, DEBUG_VERIFY, DEBUG_VERIFY, userId);
    }

    private ResolveInfo chooseBestActivity(Intent intent, String resolvedType, int flags, List<ResolveInfo> query, int userId) {
        if (query != null) {
            int N = query.size();
            if (N == UPDATE_PERMISSIONS_ALL) {
                return (ResolveInfo) query.get(DEX_OPT_SKIPPED);
            }
            if (N > UPDATE_PERMISSIONS_ALL) {
                boolean debug = (intent.getFlags() & SCAN_UPDATE_SIGNATURE) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
                ResolveInfo r0 = (ResolveInfo) query.get(DEX_OPT_SKIPPED);
                ResolveInfo r1 = (ResolveInfo) query.get(UPDATE_PERMISSIONS_ALL);
                if (debug) {
                    Slog.v(TAG, r0.activityInfo.name + "=" + r0.priority + " vs " + r1.activityInfo.name + "=" + r1.priority);
                }
                if (r0.priority != r1.priority || r0.preferredOrder != r1.preferredOrder || r0.isDefault != r1.isDefault) {
                    return (ResolveInfo) query.get(DEX_OPT_SKIPPED);
                }
                ResolveInfo ri = findPreferredActivity(intent, resolvedType, flags, query, r0.priority, DEFAULT_VERIFY_ENABLE, DEBUG_VERIFY, debug, userId);
                if (ri != null) {
                    return ri;
                }
                if (userId == 0) {
                    return this.mResolveInfo;
                }
                ri = new ResolveInfo(this.mResolveInfo);
                ri.activityInfo = new ActivityInfo(ri.activityInfo);
                ri.activityInfo.applicationInfo = new ApplicationInfo(ri.activityInfo.applicationInfo);
                ri.activityInfo.applicationInfo.uid = UserHandle.getUid(userId, UserHandle.getAppId(ri.activityInfo.applicationInfo.uid));
                return ri;
            }
        }
        return null;
    }

    private ResolveInfo findPersistentPreferredActivityLP(Intent intent, String resolvedType, int flags, List<ResolveInfo> query, boolean debug, int userId) {
        List<PersistentPreferredActivity> pprefs;
        int N = query.size();
        PersistentPreferredIntentResolver ppir = (PersistentPreferredIntentResolver) this.mSettings.mPersistentPreferredActivities.get(userId);
        if (debug) {
            Slog.v(TAG, "Looking for presistent preferred activities...");
        }
        if (ppir != null) {
            pprefs = ppir.queryIntent(intent, resolvedType, (REMOVE_CHATTY & flags) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY, userId);
        } else {
            pprefs = null;
        }
        if (pprefs != null && pprefs.size() > 0) {
            int M = pprefs.size();
            for (int i = DEX_OPT_SKIPPED; i < M; i += UPDATE_PERMISSIONS_ALL) {
                PersistentPreferredActivity ppa = (PersistentPreferredActivity) pprefs.get(i);
                if (debug) {
                    Slog.v(TAG, "Checking PersistentPreferredActivity ds=" + (ppa.countDataSchemes() > 0 ? ppa.getDataScheme(DEX_OPT_SKIPPED) : "<none>") + "\n  component=" + ppa.mComponent);
                    ppa.dump(new LogPrinter(UPDATE_PERMISSIONS_REPLACE_PKG, TAG, MCS_BOUND), "  ");
                }
                ActivityInfo ai = getActivityInfo(ppa.mComponent, flags | SCAN_TRUSTED_OVERLAY, userId);
                if (debug) {
                    Slog.v(TAG, "Found persistent preferred activity:");
                    if (ai != null) {
                        ai.dump(new LogPrinter(UPDATE_PERMISSIONS_REPLACE_PKG, TAG, MCS_BOUND), "  ");
                    } else {
                        Slog.v(TAG, "  null");
                    }
                }
                if (ai != null) {
                    int j = DEX_OPT_SKIPPED;
                    while (j < N) {
                        ResolveInfo ri = (ResolveInfo) query.get(j);
                        if (!ri.activityInfo.applicationInfo.packageName.equals(ai.applicationInfo.packageName) || !ri.activityInfo.name.equals(ai.name)) {
                            j += UPDATE_PERMISSIONS_ALL;
                        } else if (!debug) {
                            return ri;
                        } else {
                            Slog.v(TAG, "Returning persistent preferred activity: " + ri.activityInfo.packageName + "/" + ri.activityInfo.name);
                            return ri;
                        }
                    }
                    continue;
                }
            }
        }
        return null;
    }

    ResolveInfo findPreferredActivity(Intent intent, String resolvedType, int flags, List<ResolveInfo> query, int priority, boolean always, boolean removeMatches, boolean debug, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        synchronized (this.mPackages) {
            if (intent.getSelector() != null) {
                intent = intent.getSelector();
            }
            ResolveInfo pri = findPersistentPreferredActivityLP(intent, resolvedType, flags, query, debug, userId);
            if (pri != null) {
                return pri;
            }
            List<PreferredActivity> prefs;
            PreferredIntentResolver pir = (PreferredIntentResolver) this.mSettings.mPreferredActivities.get(userId);
            if (debug) {
                Slog.v(TAG, "Looking for preferred activities...");
            }
            if (pir != null) {
                prefs = pir.queryIntent(intent, resolvedType, (REMOVE_CHATTY & flags) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY, userId);
            } else {
                prefs = null;
            }
            if (prefs != null && prefs.size() > 0) {
                int j;
                ResolveInfo ri;
                changed = DEBUG_VERIFY;
                int match = DEX_OPT_SKIPPED;
                if (debug) {
                    try {
                        Slog.v(TAG, "Figuring out best match...");
                    } catch (Throwable th) {
                        boolean changed;
                        if (changed) {
                            scheduleWritePackageRestrictionsLocked(userId);
                        }
                    }
                }
                int N = query.size();
                for (j = DEX_OPT_SKIPPED; j < N; j += UPDATE_PERMISSIONS_ALL) {
                    ri = (ResolveInfo) query.get(j);
                    if (debug) {
                        Slog.v(TAG, "Match for " + ri.activityInfo + ": 0x" + Integer.toHexString(match));
                    }
                    if (ri.match > match) {
                        match = ri.match;
                    }
                }
                if (debug) {
                    Slog.v(TAG, "Best match: 0x" + Integer.toHexString(match));
                }
                match &= 268369920;
                int M = prefs.size();
                for (int i = DEX_OPT_SKIPPED; i < M; i += UPDATE_PERMISSIONS_ALL) {
                    PreferredActivity pa = (PreferredActivity) prefs.get(i);
                    if (debug) {
                        Slog.v(TAG, "Checking PreferredActivity ds=" + (pa.countDataSchemes() > 0 ? pa.getDataScheme(DEX_OPT_SKIPPED) : "<none>") + "\n  component=" + pa.mPref.mComponent);
                        pa.dump(new LogPrinter(UPDATE_PERMISSIONS_REPLACE_PKG, TAG, MCS_BOUND), "  ");
                    }
                    if (pa.mPref.mMatch != match) {
                        if (debug) {
                            Slog.v(TAG, "Skipping bad match " + Integer.toHexString(pa.mPref.mMatch));
                        }
                    } else if (!always || pa.mPref.mAlways) {
                        ActivityInfo ai = getActivityInfo(pa.mPref.mComponent, flags | SCAN_TRUSTED_OVERLAY, userId);
                        if (debug) {
                            Slog.v(TAG, "Found preferred activity:");
                            if (ai != null) {
                                ai.dump(new LogPrinter(UPDATE_PERMISSIONS_REPLACE_PKG, TAG, MCS_BOUND), "  ");
                            } else {
                                Slog.v(TAG, "  null");
                            }
                        }
                        if (ai == null) {
                            Slog.w(TAG, "Removing dangling preferred activity: " + pa.mPref.mComponent);
                            pir.removeFilter(pa);
                            changed = DEFAULT_VERIFY_ENABLE;
                        } else {
                            j = DEX_OPT_SKIPPED;
                            while (j < N) {
                                ri = (ResolveInfo) query.get(j);
                                if (!ri.activityInfo.applicationInfo.packageName.equals(ai.applicationInfo.packageName) || !ri.activityInfo.name.equals(ai.name)) {
                                    j += UPDATE_PERMISSIONS_ALL;
                                } else if (removeMatches) {
                                    pir.removeFilter(pa);
                                    changed = DEFAULT_VERIFY_ENABLE;
                                } else if (!always || pa.mPref.sameSet((List) query)) {
                                    if (debug) {
                                        Slog.v(TAG, "Returning preferred activity: " + ri.activityInfo.packageName + "/" + ri.activityInfo.name);
                                    }
                                    if (changed) {
                                        scheduleWritePackageRestrictionsLocked(userId);
                                    }
                                    return ri;
                                } else {
                                    Slog.i(TAG, "Result set changed, dropping preferred activity for " + intent + " type " + resolvedType);
                                    pir.removeFilter(pa);
                                    pir.addFilter(new PreferredActivity(pa, pa.mPref.mMatch, null, pa.mPref.mComponent, DEBUG_VERIFY));
                                    if (DEFAULT_VERIFY_ENABLE) {
                                        scheduleWritePackageRestrictionsLocked(userId);
                                    }
                                    return null;
                                }
                            }
                            continue;
                        }
                    } else if (debug) {
                        Slog.v(TAG, "Skipping mAlways=false entry");
                    }
                }
                if (changed) {
                    scheduleWritePackageRestrictionsLocked(userId);
                }
            }
            if (debug) {
                Slog.v(TAG, "No preferred activity to return");
            }
            return null;
        }
    }

    public boolean canForwardTo(Intent intent, String resolvedType, int sourceUserId, int targetUserId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.INTERACT_ACROSS_USERS_FULL", null);
        List<CrossProfileIntentFilter> matches = getMatchingCrossProfileIntentFilters(intent, resolvedType, sourceUserId);
        if (matches != null) {
            int size = matches.size();
            for (int i = DEX_OPT_SKIPPED; i < size; i += UPDATE_PERMISSIONS_ALL) {
                if (((CrossProfileIntentFilter) matches.get(i)).getTargetUserId() == targetUserId) {
                    return DEFAULT_VERIFY_ENABLE;
                }
            }
        }
        return DEBUG_VERIFY;
    }

    private List<CrossProfileIntentFilter> getMatchingCrossProfileIntentFilters(Intent intent, String resolvedType, int userId) {
        CrossProfileIntentResolver resolver = (CrossProfileIntentResolver) this.mSettings.mCrossProfileIntentResolvers.get(userId);
        if (resolver != null) {
            return resolver.queryIntent(intent, resolvedType, DEBUG_VERIFY, userId);
        }
        return null;
    }

    public List<ResolveInfo> queryIntentActivities(Intent intent, String resolvedType, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return Collections.emptyList();
        }
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "query intent activities");
        ComponentName comp = intent.getComponent();
        if (comp == null && intent.getSelector() != null) {
            intent = intent.getSelector();
            comp = intent.getComponent();
        }
        if (comp != null) {
            List<ResolveInfo> list = new ArrayList(UPDATE_PERMISSIONS_ALL);
            ActivityInfo ai = getActivityInfo(comp, flags, userId);
            if (ai != null) {
                ResolveInfo ri = new ResolveInfo();
                ri.activityInfo = ai;
                list.add(ri);
            }
            return list;
        }
        synchronized (this.mPackages) {
            String pkgName = intent.getPackage();
            List<ResolveInfo> result;
            if (pkgName == null) {
                List<CrossProfileIntentFilter> matchingFilters = getMatchingCrossProfileIntentFilters(intent, resolvedType, userId);
                ResolveInfo resolveInfo = querySkipCurrentProfileIntents(matchingFilters, intent, resolvedType, flags, userId);
                if (resolveInfo != null) {
                    List<ResolveInfo> arrayList = new ArrayList(UPDATE_PERMISSIONS_ALL);
                    arrayList.add(resolveInfo);
                    return arrayList;
                }
                resolveInfo = queryCrossProfileIntents(matchingFilters, intent, resolvedType, flags, userId);
                result = this.mActivities.queryIntent(intent, resolvedType, flags, userId);
                if (resolveInfo != null) {
                    result.add(resolveInfo);
                    Collections.sort(result, mResolvePrioritySorter);
                }
                return result;
            }
            Package pkg = (Package) this.mPackages.get(pkgName);
            if (pkg != null) {
                result = this.mActivities.queryIntentForPackage(intent, resolvedType, flags, pkg.activities, userId);
                return result;
            }
            result = new ArrayList();
            return result;
        }
    }

    private ResolveInfo querySkipCurrentProfileIntents(List<CrossProfileIntentFilter> matchingFilters, Intent intent, String resolvedType, int flags, int sourceUserId) {
        if (matchingFilters != null) {
            int size = matchingFilters.size();
            for (int i = DEX_OPT_SKIPPED; i < size; i += UPDATE_PERMISSIONS_ALL) {
                CrossProfileIntentFilter filter = (CrossProfileIntentFilter) matchingFilters.get(i);
                if ((filter.getFlags() & UPDATE_PERMISSIONS_REPLACE_PKG) != 0) {
                    ResolveInfo resolveInfo = checkTargetCanHandle(filter, intent, resolvedType, flags, sourceUserId);
                    if (resolveInfo != null) {
                        return resolveInfo;
                    }
                }
            }
        }
        return null;
    }

    private ResolveInfo queryCrossProfileIntents(List<CrossProfileIntentFilter> matchingFilters, Intent intent, String resolvedType, int flags, int sourceUserId) {
        if (matchingFilters != null) {
            SparseBooleanArray alreadyTriedUserIds = new SparseBooleanArray();
            int size = matchingFilters.size();
            for (int i = DEX_OPT_SKIPPED; i < size; i += UPDATE_PERMISSIONS_ALL) {
                CrossProfileIntentFilter filter = (CrossProfileIntentFilter) matchingFilters.get(i);
                int targetUserId = filter.getTargetUserId();
                if ((filter.getFlags() & UPDATE_PERMISSIONS_REPLACE_PKG) == 0 && !alreadyTriedUserIds.get(targetUserId)) {
                    ResolveInfo resolveInfo = checkTargetCanHandle(filter, intent, resolvedType, flags, sourceUserId);
                    if (resolveInfo != null) {
                        return resolveInfo;
                    }
                    alreadyTriedUserIds.put(targetUserId, DEFAULT_VERIFY_ENABLE);
                }
            }
        }
        return null;
    }

    private ResolveInfo checkTargetCanHandle(CrossProfileIntentFilter filter, Intent intent, String resolvedType, int flags, int sourceUserId) {
        List<ResolveInfo> resultTargetUser = this.mActivities.queryIntent(intent, resolvedType, flags, filter.getTargetUserId());
        if (resultTargetUser == null || resultTargetUser.isEmpty()) {
            return null;
        }
        return createForwardingResolveInfo(filter, sourceUserId, filter.getTargetUserId());
    }

    private ResolveInfo createForwardingResolveInfo(IntentFilter filter, int sourceUserId, int targetUserId) {
        String className;
        ResolveInfo forwardingResolveInfo = new ResolveInfo();
        if (targetUserId == 0) {
            className = IntentForwarderActivity.FORWARD_INTENT_TO_USER_OWNER;
        } else {
            className = IntentForwarderActivity.FORWARD_INTENT_TO_MANAGED_PROFILE;
        }
        ActivityInfo forwardingActivityInfo = getActivityInfo(new ComponentName(this.mAndroidApplication.packageName, className), DEX_OPT_SKIPPED, sourceUserId);
        if (targetUserId == 0) {
            forwardingActivityInfo.showUserIcon = DEX_OPT_SKIPPED;
            forwardingResolveInfo.noResourceId = DEFAULT_VERIFY_ENABLE;
        }
        forwardingResolveInfo.activityInfo = forwardingActivityInfo;
        forwardingResolveInfo.priority = DEX_OPT_SKIPPED;
        forwardingResolveInfo.preferredOrder = DEX_OPT_SKIPPED;
        forwardingResolveInfo.match = DEX_OPT_SKIPPED;
        forwardingResolveInfo.isDefault = DEFAULT_VERIFY_ENABLE;
        forwardingResolveInfo.filter = filter;
        forwardingResolveInfo.targetUserId = targetUserId;
        return forwardingResolveInfo;
    }

    public List<ResolveInfo> queryIntentActivityOptions(ComponentName caller, Intent[] specifics, String[] specificTypes, Intent intent, String resolvedType, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return Collections.emptyList();
        }
        int i;
        String action;
        int N;
        int j;
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "query intent activity options");
        String resultsAction = intent.getAction();
        List<ResolveInfo> results = queryIntentActivities(intent, resolvedType, flags | SCAN_UPDATE_TIME, userId);
        int specificsPos = DEX_OPT_SKIPPED;
        if (specifics != null) {
            i = DEX_OPT_SKIPPED;
            while (i < specifics.length) {
                Intent sintent = specifics[i];
                if (sintent != null) {
                    ActivityInfo ai;
                    action = sintent.getAction();
                    if (resultsAction != null && resultsAction.equals(action)) {
                        action = null;
                    }
                    ResolveInfo ri = null;
                    ComponentName comp = sintent.getComponent();
                    if (comp == null) {
                        ri = resolveIntent(sintent, specificTypes != null ? specificTypes[i] : null, flags, userId);
                        if (ri != null) {
                            if (ri == this.mResolveInfo) {
                                ai = ri.activityInfo;
                                comp = new ComponentName(ai.applicationInfo.packageName, ai.name);
                            } else {
                                ai = ri.activityInfo;
                                comp = new ComponentName(ai.applicationInfo.packageName, ai.name);
                            }
                        }
                    } else {
                        ai = getActivityInfo(comp, flags, userId);
                        if (ai == null) {
                        }
                    }
                    N = results.size();
                    j = specificsPos;
                    while (j < N) {
                        ResolveInfo sri = (ResolveInfo) results.get(j);
                        if ((sri.activityInfo.name.equals(comp.getClassName()) && sri.activityInfo.applicationInfo.packageName.equals(comp.getPackageName())) || (action != null && sri.filter.matchAction(action))) {
                            results.remove(j);
                            if (ri == null) {
                                ri = sri;
                            }
                            j += DEX_OPT_FAILED;
                            N += DEX_OPT_FAILED;
                        }
                        j += UPDATE_PERMISSIONS_ALL;
                    }
                    if (ri == null) {
                        ri = new ResolveInfo();
                        ri.activityInfo = ai;
                    }
                    results.add(specificsPos, ri);
                    ri.specificIndex = i;
                    specificsPos += UPDATE_PERMISSIONS_ALL;
                }
                i += UPDATE_PERMISSIONS_ALL;
            }
        }
        N = results.size();
        for (i = specificsPos; i < N + DEX_OPT_FAILED; i += UPDATE_PERMISSIONS_ALL) {
            ResolveInfo rii = (ResolveInfo) results.get(i);
            if (rii.filter != null) {
                Iterator<String> it = rii.filter.actionsIterator();
                if (it != null) {
                    while (it.hasNext()) {
                        action = (String) it.next();
                        if (resultsAction == null || !resultsAction.equals(action)) {
                            j = i + UPDATE_PERMISSIONS_ALL;
                            while (j < N) {
                                ResolveInfo rij = (ResolveInfo) results.get(j);
                                if (rij.filter != null && rij.filter.hasAction(action)) {
                                    results.remove(j);
                                    j += DEX_OPT_FAILED;
                                    N += DEX_OPT_FAILED;
                                }
                                j += UPDATE_PERMISSIONS_ALL;
                            }
                        }
                    }
                    if ((flags & SCAN_UPDATE_TIME) == 0) {
                        rii.filter = null;
                    }
                }
            }
        }
        if (caller != null) {
            N = results.size();
            for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
                ActivityInfo ainfo = ((ResolveInfo) results.get(i)).activityInfo;
                if (caller.getPackageName().equals(ainfo.applicationInfo.packageName) && caller.getClassName().equals(ainfo.name)) {
                    results.remove(i);
                    break;
                }
            }
        }
        if ((flags & SCAN_UPDATE_TIME) != 0) {
            return results;
        }
        N = results.size();
        for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            ((ResolveInfo) results.get(i)).filter = null;
        }
        return results;
    }

    public List<ResolveInfo> queryIntentReceivers(Intent intent, String resolvedType, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return Collections.emptyList();
        }
        ComponentName comp = intent.getComponent();
        if (comp == null && intent.getSelector() != null) {
            intent = intent.getSelector();
            comp = intent.getComponent();
        }
        List<ResolveInfo> list;
        if (comp != null) {
            list = new ArrayList(UPDATE_PERMISSIONS_ALL);
            ActivityInfo ai = getReceiverInfo(comp, flags, userId);
            if (ai == null) {
                return list;
            }
            ResolveInfo ri = new ResolveInfo();
            ri.activityInfo = ai;
            list.add(ri);
            return list;
        }
        synchronized (this.mPackages) {
            String pkgName = intent.getPackage();
            if (pkgName == null) {
                list = this.mReceivers.queryIntent(intent, resolvedType, flags, userId);
                return list;
            }
            Package pkg = (Package) this.mPackages.get(pkgName);
            if (pkg != null) {
                list = this.mReceivers.queryIntentForPackage(intent, resolvedType, flags, pkg.receivers, userId);
                return list;
            }
            return null;
        }
    }

    public ResolveInfo resolveService(Intent intent, String resolvedType, int flags, int userId) {
        List<ResolveInfo> query = queryIntentServices(intent, resolvedType, flags, userId);
        if (sUserManager.exists(userId) && query != null && query.size() >= UPDATE_PERMISSIONS_ALL) {
            return (ResolveInfo) query.get(DEX_OPT_SKIPPED);
        }
        return null;
    }

    public List<ResolveInfo> queryIntentServices(Intent intent, String resolvedType, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return Collections.emptyList();
        }
        ComponentName comp = intent.getComponent();
        if (comp == null && intent.getSelector() != null) {
            intent = intent.getSelector();
            comp = intent.getComponent();
        }
        List<ResolveInfo> list;
        if (comp != null) {
            list = new ArrayList(UPDATE_PERMISSIONS_ALL);
            ServiceInfo si = getServiceInfo(comp, flags, userId);
            if (si == null) {
                return list;
            }
            ResolveInfo ri = new ResolveInfo();
            ri.serviceInfo = si;
            list.add(ri);
            return list;
        }
        synchronized (this.mPackages) {
            String pkgName = intent.getPackage();
            if (pkgName == null) {
                list = this.mServices.queryIntent(intent, resolvedType, flags, userId);
                return list;
            }
            Package pkg = (Package) this.mPackages.get(pkgName);
            if (pkg != null) {
                list = this.mServices.queryIntentForPackage(intent, resolvedType, flags, pkg.services, userId);
                return list;
            }
            return null;
        }
    }

    public List<ResolveInfo> queryIntentContentProviders(Intent intent, String resolvedType, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return Collections.emptyList();
        }
        ComponentName comp = intent.getComponent();
        if (comp == null && intent.getSelector() != null) {
            intent = intent.getSelector();
            comp = intent.getComponent();
        }
        List<ResolveInfo> list;
        if (comp != null) {
            list = new ArrayList(UPDATE_PERMISSIONS_ALL);
            ProviderInfo pi = getProviderInfo(comp, flags, userId);
            if (pi == null) {
                return list;
            }
            ResolveInfo ri = new ResolveInfo();
            ri.providerInfo = pi;
            list.add(ri);
            return list;
        }
        synchronized (this.mPackages) {
            String pkgName = intent.getPackage();
            if (pkgName == null) {
                list = this.mProviders.queryIntent(intent, resolvedType, flags, userId);
                return list;
            }
            Package pkg = (Package) this.mPackages.get(pkgName);
            if (pkg != null) {
                list = this.mProviders.queryIntentForPackage(intent, resolvedType, flags, pkg.providers, userId);
                return list;
            }
            return null;
        }
    }

    public ParceledListSlice<PackageInfo> getInstalledPackages(int flags, int userId) {
        boolean listUninstalled;
        ParceledListSlice<PackageInfo> parceledListSlice;
        if ((flags & DumpState.DUMP_INSTALLS) != 0) {
            listUninstalled = DEFAULT_VERIFY_ENABLE;
        } else {
            listUninstalled = DEBUG_VERIFY;
        }
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEFAULT_VERIFY_ENABLE, DEBUG_VERIFY, "get installed packages");
        synchronized (this.mPackages) {
            ArrayList<PackageInfo> list;
            PackageInfo pi;
            if (listUninstalled) {
                list = new ArrayList(this.mSettings.mPackages.size());
                for (PackageSetting ps : this.mSettings.mPackages.values()) {
                    if (ps.pkg != null) {
                        pi = generatePackageInfo(ps.pkg, flags, userId);
                    } else {
                        pi = generatePackageInfoFromSettingsLPw(ps.name, flags, userId);
                    }
                    if (pi != null) {
                        list.add(pi);
                    }
                }
            } else {
                list = new ArrayList(this.mPackages.size());
                for (Package p : this.mPackages.values()) {
                    pi = generatePackageInfo(p, flags, userId);
                    if (pi != null) {
                        list.add(pi);
                    }
                }
            }
            parceledListSlice = new ParceledListSlice(list);
        }
        return parceledListSlice;
    }

    private void addPackageHoldingPermissions(ArrayList<PackageInfo> list, PackageSetting ps, String[] permissions, boolean[] tmp, int flags, int userId) {
        GrantedPermissions gp;
        int i;
        int numMatch = DEX_OPT_SKIPPED;
        if (ps.sharedUser != null) {
            gp = ps.sharedUser;
        } else {
            gp = ps;
        }
        for (i = DEX_OPT_SKIPPED; i < permissions.length; i += UPDATE_PERMISSIONS_ALL) {
            if (gp.grantedPermissions.contains(permissions[i])) {
                tmp[i] = DEFAULT_VERIFY_ENABLE;
                numMatch += UPDATE_PERMISSIONS_ALL;
            } else {
                tmp[i] = DEBUG_VERIFY;
            }
        }
        if (numMatch != 0) {
            PackageInfo pi;
            if (ps.pkg != null) {
                pi = generatePackageInfo(ps.pkg, flags, userId);
            } else {
                pi = generatePackageInfoFromSettingsLPw(ps.name, flags, userId);
            }
            if (pi != null) {
                if ((flags & SCAN_REQUIRE_KNOWN) == 0) {
                    if (numMatch == permissions.length) {
                        pi.requestedPermissions = permissions;
                    } else {
                        pi.requestedPermissions = new String[numMatch];
                        numMatch = DEX_OPT_SKIPPED;
                        for (i = DEX_OPT_SKIPPED; i < permissions.length; i += UPDATE_PERMISSIONS_ALL) {
                            if (tmp[i]) {
                                pi.requestedPermissions[numMatch] = permissions[i];
                                numMatch += UPDATE_PERMISSIONS_ALL;
                            }
                        }
                    }
                }
                list.add(pi);
            }
        }
    }

    public ParceledListSlice<PackageInfo> getPackagesHoldingPermissions(String[] permissions, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        ParceledListSlice<PackageInfo> parceledListSlice;
        boolean listUninstalled = (flags & DumpState.DUMP_INSTALLS) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
        synchronized (this.mPackages) {
            ArrayList<PackageInfo> list = new ArrayList();
            boolean[] tmpBools = new boolean[permissions.length];
            PackageSetting ps;
            if (listUninstalled) {
                for (PackageSetting ps2 : this.mSettings.mPackages.values()) {
                    addPackageHoldingPermissions(list, ps2, permissions, tmpBools, flags, userId);
                }
            } else {
                for (Package pkg : this.mPackages.values()) {
                    ps2 = (PackageSetting) pkg.mExtras;
                    if (ps2 != null) {
                        addPackageHoldingPermissions(list, ps2, permissions, tmpBools, flags, userId);
                    }
                }
            }
            parceledListSlice = new ParceledListSlice(list);
        }
        return parceledListSlice;
    }

    public ParceledListSlice<ApplicationInfo> getInstalledApplications(int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        ParceledListSlice<ApplicationInfo> parceledListSlice;
        boolean listUninstalled = (flags & DumpState.DUMP_INSTALLS) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
        synchronized (this.mPackages) {
            ArrayList<ApplicationInfo> list;
            ApplicationInfo ai;
            if (listUninstalled) {
                list = new ArrayList(this.mSettings.mPackages.size());
                for (PackageSetting ps : this.mSettings.mPackages.values()) {
                    if (ps.pkg != null) {
                        ai = PackageParser.generateApplicationInfo(ps.pkg, flags, ps.readUserState(userId), userId);
                    } else {
                        ai = generateApplicationInfoFromSettingsLPw(ps.name, flags, userId);
                    }
                    if (ai != null) {
                        list.add(ai);
                    }
                }
            } else {
                list = new ArrayList(this.mPackages.size());
                for (Package p : this.mPackages.values()) {
                    if (p.mExtras != null) {
                        ai = PackageParser.generateApplicationInfo(p, flags, ((PackageSetting) p.mExtras).readUserState(userId), userId);
                        if (ai != null) {
                            list.add(ai);
                        }
                    }
                }
            }
            parceledListSlice = new ParceledListSlice(list);
        }
        return parceledListSlice;
    }

    public List<ApplicationInfo> getPersistentApplications(int flags) {
        ArrayList<ApplicationInfo> finalList = new ArrayList();
        synchronized (this.mPackages) {
            int userId = UserHandle.getCallingUserId();
            for (Package p : this.mPackages.values()) {
                if (!(p.applicationInfo == null || (p.applicationInfo.flags & SCAN_UPDATE_SIGNATURE) == 0)) {
                    if (!this.mSafeMode || isSystemApp(p)) {
                        PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(p.packageName);
                        if (ps != null) {
                            ApplicationInfo ai = PackageParser.generateApplicationInfo(p, flags, ps.readUserState(userId), userId);
                            if (ai != null) {
                                finalList.add(ai);
                            }
                        }
                    }
                }
            }
        }
        return finalList;
    }

    public ProviderInfo resolveContentProvider(String name, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return null;
        }
        ProviderInfo providerInfo;
        synchronized (this.mPackages) {
            PackageSetting ps;
            Provider provider = (Provider) this.mProvidersByAuthority.get(name);
            if (provider != null) {
                ps = (PackageSetting) this.mSettings.mPackages.get(provider.owner.packageName);
            } else {
                ps = null;
            }
            if (ps == null || !this.mSettings.isEnabledLPr(provider.info, flags, userId) || (this.mSafeMode && (provider.info.applicationInfo.flags & UPDATE_PERMISSIONS_ALL) == 0)) {
                providerInfo = null;
            } else {
                providerInfo = PackageParser.generateProviderInfo(provider, flags, ps.readUserState(userId), userId);
            }
        }
        return providerInfo;
    }

    @Deprecated
    public void querySyncProviders(List<String> outNames, List<ProviderInfo> outInfo) {
        synchronized (this.mPackages) {
            int userId = UserHandle.getCallingUserId();
            for (Entry<String, Provider> entry : this.mProvidersByAuthority.entrySet()) {
                Provider p = (Provider) entry.getValue();
                PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(p.owner.packageName);
                if (ps != null && p.syncable) {
                    if (!this.mSafeMode || (p.info.applicationInfo.flags & UPDATE_PERMISSIONS_ALL) != 0) {
                        ProviderInfo info = PackageParser.generateProviderInfo(p, DEX_OPT_SKIPPED, ps.readUserState(userId), userId);
                        if (info != null) {
                            outNames.add(entry.getKey());
                            outInfo.add(info);
                        }
                    }
                }
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public java.util.List<android.content.pm.ProviderInfo> queryContentProviders(java.lang.String r11, int r12, int r13) {
        /*
        r10 = this;
        r0 = 0;
        r8 = r10.mPackages;
        monitor-enter(r8);
        r7 = r10.mProviders;	 Catch:{ all -> 0x0090 }
        r7 = r7.mProviders;	 Catch:{ all -> 0x0090 }
        r7 = r7.values();	 Catch:{ all -> 0x0090 }
        r2 = r7.iterator();	 Catch:{ all -> 0x0090 }
        if (r11 == 0) goto L_0x0082;
    L_0x0014:
        r6 = android.os.UserHandle.getUserId(r12);	 Catch:{ all -> 0x0090 }
    L_0x0018:
        r1 = r0;
    L_0x0019:
        r7 = r2.hasNext();	 Catch:{ all -> 0x0093 }
        if (r7 == 0) goto L_0x0087;
    L_0x001f:
        r4 = r2.next();	 Catch:{ all -> 0x0093 }
        r4 = (android.content.pm.PackageParser.Provider) r4;	 Catch:{ all -> 0x0093 }
        r7 = r10.mSettings;	 Catch:{ all -> 0x0093 }
        r7 = r7.mPackages;	 Catch:{ all -> 0x0093 }
        r9 = r4.owner;	 Catch:{ all -> 0x0093 }
        r9 = r9.packageName;	 Catch:{ all -> 0x0093 }
        r5 = r7.get(r9);	 Catch:{ all -> 0x0093 }
        r5 = (com.android.server.pm.PackageSetting) r5;	 Catch:{ all -> 0x0093 }
        if (r5 == 0) goto L_0x0098;
    L_0x0035:
        r7 = r4.info;	 Catch:{ all -> 0x0093 }
        r7 = r7.authority;	 Catch:{ all -> 0x0093 }
        if (r7 == 0) goto L_0x0098;
    L_0x003b:
        if (r11 == 0) goto L_0x0053;
    L_0x003d:
        r7 = r4.info;	 Catch:{ all -> 0x0093 }
        r7 = r7.processName;	 Catch:{ all -> 0x0093 }
        r7 = r7.equals(r11);	 Catch:{ all -> 0x0093 }
        if (r7 == 0) goto L_0x0098;
    L_0x0047:
        r7 = r4.info;	 Catch:{ all -> 0x0093 }
        r7 = r7.applicationInfo;	 Catch:{ all -> 0x0093 }
        r7 = r7.uid;	 Catch:{ all -> 0x0093 }
        r7 = android.os.UserHandle.isSameApp(r7, r12);	 Catch:{ all -> 0x0093 }
        if (r7 == 0) goto L_0x0098;
    L_0x0053:
        r7 = r10.mSettings;	 Catch:{ all -> 0x0093 }
        r9 = r4.info;	 Catch:{ all -> 0x0093 }
        r7 = r7.isEnabledLPr(r9, r13, r6);	 Catch:{ all -> 0x0093 }
        if (r7 == 0) goto L_0x0098;
    L_0x005d:
        r7 = r10.mSafeMode;	 Catch:{ all -> 0x0093 }
        if (r7 == 0) goto L_0x006b;
    L_0x0061:
        r7 = r4.info;	 Catch:{ all -> 0x0093 }
        r7 = r7.applicationInfo;	 Catch:{ all -> 0x0093 }
        r7 = r7.flags;	 Catch:{ all -> 0x0093 }
        r7 = r7 & 1;
        if (r7 == 0) goto L_0x0098;
    L_0x006b:
        if (r1 != 0) goto L_0x0096;
    L_0x006d:
        r0 = new java.util.ArrayList;	 Catch:{ all -> 0x0093 }
        r7 = 3;
        r0.<init>(r7);	 Catch:{ all -> 0x0093 }
    L_0x0073:
        r7 = r5.readUserState(r6);	 Catch:{ all -> 0x0090 }
        r3 = android.content.pm.PackageParser.generateProviderInfo(r4, r13, r7, r6);	 Catch:{ all -> 0x0090 }
        if (r3 == 0) goto L_0x0080;
    L_0x007d:
        r0.add(r3);	 Catch:{ all -> 0x0090 }
    L_0x0080:
        r1 = r0;
        goto L_0x0019;
    L_0x0082:
        r6 = android.os.UserHandle.getCallingUserId();	 Catch:{ all -> 0x0090 }
        goto L_0x0018;
    L_0x0087:
        monitor-exit(r8);	 Catch:{ all -> 0x0093 }
        if (r1 == 0) goto L_0x008f;
    L_0x008a:
        r7 = mProviderInitOrderSorter;
        java.util.Collections.sort(r1, r7);
    L_0x008f:
        return r1;
    L_0x0090:
        r7 = move-exception;
    L_0x0091:
        monitor-exit(r8);	 Catch:{ all -> 0x0090 }
        throw r7;
    L_0x0093:
        r7 = move-exception;
        r0 = r1;
        goto L_0x0091;
    L_0x0096:
        r0 = r1;
        goto L_0x0073;
    L_0x0098:
        r0 = r1;
        goto L_0x0080;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageManagerService.queryContentProviders(java.lang.String, int, int):java.util.List<android.content.pm.ProviderInfo>");
    }

    public InstrumentationInfo getInstrumentationInfo(ComponentName name, int flags) {
        InstrumentationInfo generateInstrumentationInfo;
        synchronized (this.mPackages) {
            generateInstrumentationInfo = PackageParser.generateInstrumentationInfo((Instrumentation) this.mInstrumentation.get(name), flags);
        }
        return generateInstrumentationInfo;
    }

    public List<InstrumentationInfo> queryInstrumentation(String targetPackage, int flags) {
        ArrayList<InstrumentationInfo> finalList = new ArrayList();
        synchronized (this.mPackages) {
            for (Instrumentation p : this.mInstrumentation.values()) {
                if (targetPackage == null || targetPackage.equals(p.info.targetPackage)) {
                    InstrumentationInfo ii = PackageParser.generateInstrumentationInfo(p, flags);
                    if (ii != null) {
                        finalList.add(ii);
                    }
                }
            }
        }
        return finalList;
    }

    private void createIdmapsForPackageLI(Package pkg) {
        ArrayMap<String, Package> overlays = (ArrayMap) this.mOverlays.get(pkg.packageName);
        if (overlays == null) {
            Slog.w(TAG, "Unable to create idmap for " + pkg.packageName + ": no overlay packages");
            return;
        }
        for (Package opkg : overlays.values()) {
            createIdmapForPackagePairLI(pkg, opkg);
        }
    }

    private boolean createIdmapForPackagePairLI(Package pkg, Package opkg) {
        if (opkg.mTrustedOverlay) {
            ArrayMap<String, Package> overlaySet = (ArrayMap) this.mOverlays.get(pkg.packageName);
            if (overlaySet == null) {
                Slog.e(TAG, "was about to create idmap for " + pkg.baseCodePath + " and " + opkg.baseCodePath + " but target package has no known overlays");
                return DEBUG_VERIFY;
            }
            if (this.mInstaller.idmap(pkg.baseCodePath, opkg.baseCodePath, UserHandle.getSharedAppGid(pkg.applicationInfo.uid)) != 0) {
                Slog.e(TAG, "Failed to generate idmap for " + pkg.baseCodePath + " and " + opkg.baseCodePath);
                return DEBUG_VERIFY;
            }
            Package[] overlayArray = (Package[]) overlaySet.values().toArray(new Package[DEX_OPT_SKIPPED]);
            Arrays.sort(overlayArray, new C04493());
            pkg.applicationInfo.resourceDirs = new String[overlayArray.length];
            Package[] arr$ = overlayArray;
            int len$ = arr$.length;
            int i$ = DEX_OPT_SKIPPED;
            int i = DEX_OPT_SKIPPED;
            while (i$ < len$) {
                int i2 = i + UPDATE_PERMISSIONS_ALL;
                pkg.applicationInfo.resourceDirs[i] = arr$[i$].baseCodePath;
                i$ += UPDATE_PERMISSIONS_ALL;
                i = i2;
            }
            return DEFAULT_VERIFY_ENABLE;
        }
        Slog.w(TAG, "Skipping target and overlay pair " + pkg.baseCodePath + " and " + opkg.baseCodePath + ": overlay not trusted");
        return DEBUG_VERIFY;
    }

    private void scanDirLI(File dir, int parseFlags, int scanFlags, long currentTime) {
        File[] files = dir.listFiles();
        if (ArrayUtils.isEmpty(files)) {
            Log.d(TAG, "No files in app dir " + dir);
            return;
        }
        File[] arr$ = files;
        int len$ = arr$.length;
        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            File file = arr$[i$];
            boolean isPackage = ((PackageParser.isApkFile(file) || file.isDirectory()) && !PackageInstallerService.isStageName(file.getName())) ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
            if (isPackage) {
                try {
                    scanPackageLI(file, parseFlags | UPDATE_PERMISSIONS_REPLACE_ALL, scanFlags, currentTime, null);
                } catch (PackageManagerException e) {
                    Slog.w(TAG, "Failed to parse " + file + ": " + e.getMessage());
                    if ((parseFlags & UPDATE_PERMISSIONS_ALL) == 0 && e.error == -2) {
                        logCriticalInfo(INIT_COPY, "Deleting invalid package at " + file);
                        if (file.isDirectory()) {
                            FileUtils.deleteContents(file);
                        }
                        file.delete();
                    }
                }
            }
        }
    }

    private static File getSettingsProblemFile() {
        return new File(new File(Environment.getDataDirectory(), "system"), "uiderrors.txt");
    }

    static void reportSettingsProblem(int priority, String msg) {
        logCriticalInfo(priority, msg);
    }

    static void logCriticalInfo(int priority, String msg) {
        Slog.println(priority, TAG, msg);
        EventLogTags.writePmCriticalInfo(msg);
        try {
            File fname = getSettingsProblemFile();
            PrintWriter pw = new FastPrintWriter(new FileOutputStream(fname, DEFAULT_VERIFY_ENABLE));
            pw.println(new SimpleDateFormat().format(new Date(System.currentTimeMillis())) + ": " + msg);
            pw.close();
            FileUtils.setPermissions(fname.toString(), 508, DEX_OPT_FAILED, DEX_OPT_FAILED);
        } catch (IOException e) {
        }
    }

    private void collectCertificatesLI(PackageParser pp, PackageSetting ps, Package pkg, File srcFile, int parseFlags) throws PackageManagerException {
        if (ps == null || !ps.codePath.equals(srcFile) || ps.timeStamp != srcFile.lastModified() || isCompatSignatureUpdateNeeded(pkg) || isRecoverSignatureUpdateNeeded(pkg)) {
            Log.i(TAG, srcFile.toString() + " changed; collecting certs");
        } else {
            long mSigningKeySetId = ps.keySetData.getProperSigningKeySet();
            if (ps.signatures.mSignatures == null || ps.signatures.mSignatures.length == 0 || mSigningKeySetId == -1) {
                Slog.w(TAG, "PackageSetting for " + ps.name + " is missing signatures.  Collecting certs again to recover them.");
            } else {
                pkg.mSignatures = ps.signatures.mSignatures;
                KeySetManagerService ksms = this.mSettings.mKeySetManagerService;
                synchronized (this.mPackages) {
                    pkg.mSigningKeys = ksms.getPublicKeysFromKeySetLPr(mSigningKeySetId);
                }
                return;
            }
        }
        try {
            pp.collectCertificates(pkg, parseFlags);
            pp.collectManifestDigest(pkg);
        } catch (PackageParserException e) {
            throw PackageManagerException.from(e);
        }
    }

    private Package scanPackageLI(File scanFile, int parseFlags, int scanFlags, long currentTime, UserHandle user) throws PackageManagerException {
        parseFlags |= this.mDefParseFlags;
        PackageParser pp = new PackageParser();
        pp.setSeparateProcesses(this.mSeparateProcesses);
        pp.setOnlyCoreApps(this.mOnlyCore);
        pp.setDisplayMetrics(this.mMetrics);
        if ((scanFlags & SCAN_TRUSTED_OVERLAY) != 0) {
            parseFlags |= SCAN_TRUSTED_OVERLAY;
        }
        try {
            PackageSetting updatedPkg;
            InstallArgs args;
            Package pkg = pp.parsePackage(scanFile, parseFlags);
            PackageSetting ps = null;
            synchronized (this.mPackages) {
                String oldName = (String) this.mSettings.mRenamedPackages.get(pkg.packageName);
                if (pkg.mOriginalPackages != null && pkg.mOriginalPackages.contains(oldName)) {
                    ps = this.mSettings.peekPackageLPr(oldName);
                }
                if (ps == null) {
                    ps = this.mSettings.peekPackageLPr(pkg.packageName);
                }
                updatedPkg = this.mSettings.getDisabledSystemPkgLPr(ps != null ? ps.name : pkg.packageName);
            }
            boolean updatedPkgBetter = DEBUG_VERIFY;
            if (!(updatedPkg == null || (parseFlags & UPDATE_PERMISSIONS_ALL) == 0)) {
                if (locationIsPrivileged(scanFile)) {
                    updatedPkg.pkgFlags |= 1073741824;
                } else {
                    updatedPkg.pkgFlags &= -1073741825;
                }
                if (!(ps == null || ps.codePath.equals(scanFile))) {
                    if (pkg.mVersionCode <= ps.versionCode) {
                        Slog.i(TAG, "Package " + ps.name + " at " + scanFile + " ignored: updated version " + ps.versionCode + " better than this " + pkg.mVersionCode);
                        if (!updatedPkg.codePath.equals(scanFile)) {
                            Slog.w(TAG, "Code path for hidden system pkg : " + ps.name + " changing from " + updatedPkg.codePathString + " to " + scanFile);
                            updatedPkg.codePath = scanFile;
                            updatedPkg.codePathString = scanFile.toString();
                            updatedPkg.resourcePath = scanFile;
                            updatedPkg.resourcePathString = scanFile.toString();
                        }
                        updatedPkg.pkg = pkg;
                        throw new PackageManagerException(-5, null);
                    }
                    synchronized (this.mPackages) {
                        this.mPackages.remove(ps.name);
                    }
                    logCriticalInfo(INIT_COPY, "Package " + ps.name + " at " + scanFile + " reverting from " + ps.codePathString + ": new version " + pkg.mVersionCode + " better than installed " + ps.versionCode);
                    args = createInstallArgsForExisting(packageFlagsToInstallFlags(ps), ps.codePathString, ps.resourcePathString, ps.legacyNativeLibraryPathString, getAppDexInstructionSets(ps));
                    synchronized (this.mInstallLock) {
                        args.cleanUpResourcesLI();
                    }
                    synchronized (this.mPackages) {
                        this.mSettings.enableSystemPackageLPw(ps.name);
                    }
                    updatedPkgBetter = DEFAULT_VERIFY_ENABLE;
                }
            }
            if (updatedPkg != null) {
                parseFlags |= UPDATE_PERMISSIONS_ALL;
                if ((updatedPkg.pkgFlags & 1073741824) != 0) {
                    parseFlags |= SCAN_DEFER_DEX;
                }
            }
            collectCertificatesLI(pp, ps, pkg, scanFile, parseFlags);
            boolean shouldHideSystemApp = DEBUG_VERIFY;
            if (!(updatedPkg != null || ps == null || (parseFlags & SCAN_UPDATE_TIME) == 0 || isSystemApp(ps))) {
                if (compareSignatures(ps.signatures.mSignatures, pkg.mSignatures) != 0) {
                    logCriticalInfo(INIT_COPY, "Package " + ps.name + " appeared on system, but" + " signatures don't match existing userdata copy; removing");
                    deletePackageLI(pkg.packageName, null, DEFAULT_VERIFY_ENABLE, null, null, DEX_OPT_SKIPPED, null, DEBUG_VERIFY);
                    ps = null;
                } else if (pkg.mVersionCode <= ps.versionCode) {
                    shouldHideSystemApp = DEFAULT_VERIFY_ENABLE;
                    logCriticalInfo(UPDATE_PERMISSIONS_REPLACE_ALL, "Package " + ps.name + " appeared at " + scanFile + " but new version " + pkg.mVersionCode + " better than installed " + ps.versionCode + "; hiding system");
                } else {
                    logCriticalInfo(INIT_COPY, "Package " + ps.name + " at " + scanFile + " reverting from " + ps.codePathString + ": new version " + pkg.mVersionCode + " better than installed " + ps.versionCode);
                    args = createInstallArgsForExisting(packageFlagsToInstallFlags(ps), ps.codePathString, ps.resourcePathString, ps.legacyNativeLibraryPathString, getAppDexInstructionSets(ps));
                    synchronized (this.mInstallLock) {
                        args.cleanUpResourcesLI();
                    }
                }
            }
            if (!((parseFlags & SCAN_UPDATE_TIME) != 0 || ps == null || ps.codePath.equals(ps.resourcePath))) {
                parseFlags |= SCAN_NEW_INSTALL;
            }
            String resourcePath = null;
            String baseResourcePath = null;
            if ((parseFlags & SCAN_NEW_INSTALL) == 0 || updatedPkgBetter) {
                resourcePath = pkg.codePath;
                baseResourcePath = pkg.baseCodePath;
            } else if (ps == null || ps.resourcePathString == null) {
                Slog.e(TAG, "Resource path not set for pkg : " + pkg.packageName);
            } else {
                resourcePath = ps.resourcePathString;
                baseResourcePath = ps.resourcePathString;
            }
            pkg.applicationInfo.setCodePath(pkg.codePath);
            pkg.applicationInfo.setBaseCodePath(pkg.baseCodePath);
            pkg.applicationInfo.setSplitCodePaths(pkg.splitCodePaths);
            pkg.applicationInfo.setResourcePath(resourcePath);
            pkg.applicationInfo.setBaseResourcePath(baseResourcePath);
            pkg.applicationInfo.setSplitResourcePaths(pkg.splitCodePaths);
            Package scannedPkg = scanPackageLI(pkg, parseFlags, scanFlags | SCAN_UPDATE_SIGNATURE, currentTime, user);
            if (shouldHideSystemApp) {
                synchronized (this.mPackages) {
                    grantPermissionsLPw(pkg, DEFAULT_VERIFY_ENABLE, pkg.packageName);
                    this.mSettings.disableSystemPackageLPw(pkg.packageName);
                }
            }
            return scannedPkg;
        } catch (PackageParserException e) {
            throw PackageManagerException.from(e);
        }
    }

    private static String fixProcessName(String defProcessName, String processName, int uid) {
        return processName == null ? defProcessName : processName;
    }

    private void verifySignaturesLP(PackageSetting pkgSetting, Package pkg) throws PackageManagerException {
        boolean match;
        if (pkgSetting.signatures.mSignatures != null) {
            if (compareSignatures(pkgSetting.signatures.mSignatures, pkg.mSignatures) == 0) {
                match = DEFAULT_VERIFY_ENABLE;
            } else {
                match = DEBUG_VERIFY;
            }
            if (!match) {
                if (compareSignaturesCompat(pkgSetting.signatures, pkg) == 0) {
                    match = DEFAULT_VERIFY_ENABLE;
                } else {
                    match = DEBUG_VERIFY;
                }
            }
            if (!match) {
                if (compareSignaturesRecover(pkgSetting.signatures, pkg) == 0) {
                    match = DEFAULT_VERIFY_ENABLE;
                } else {
                    match = DEBUG_VERIFY;
                }
            }
            if (!match) {
                throw new PackageManagerException(-7, "Package " + pkg.packageName + " signatures do not match the " + "previously installed version; ignoring!");
            }
        }
        if (pkgSetting.sharedUser != null && pkgSetting.sharedUser.signatures.mSignatures != null) {
            if (compareSignatures(pkgSetting.sharedUser.signatures.mSignatures, pkg.mSignatures) == 0) {
                match = DEFAULT_VERIFY_ENABLE;
            } else {
                match = DEBUG_VERIFY;
            }
            if (!match) {
                if (compareSignaturesCompat(pkgSetting.sharedUser.signatures, pkg) == 0) {
                    match = DEFAULT_VERIFY_ENABLE;
                } else {
                    match = DEBUG_VERIFY;
                }
            }
            if (!match) {
                if (compareSignaturesRecover(pkgSetting.sharedUser.signatures, pkg) == 0) {
                    match = DEFAULT_VERIFY_ENABLE;
                } else {
                    match = DEBUG_VERIFY;
                }
            }
            if (!match) {
                throw new PackageManagerException(-8, "Package " + pkg.packageName + " has no signatures that match those in shared user " + pkgSetting.sharedUser.name + "; ignoring!");
            }
        }
    }

    private static final void enforceSystemOrRoot(String message) {
        int uid = Binder.getCallingUid();
        if (uid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && uid != 0) {
            throw new SecurityException(message);
        }
    }

    public void performBootDexOpt() {
        enforceSystemOrRoot("Only the system can request dexopt be performed");
        try {
            IMountService ms = PackageHelper.getMountService();
            if (ms != null) {
                boolean doTrim = isUpgrade();
                if (doTrim) {
                    Slog.w(TAG, "Running disk maintenance immediately due to system update");
                } else {
                    long interval = Global.getLong(this.mContext.getContentResolver(), "fstrim_mandatory_interval", DEFAULT_MANDATORY_FSTRIM_INTERVAL);
                    if (interval > 0) {
                        long timeSinceLast = System.currentTimeMillis() - ms.lastMaintenance();
                        if (timeSinceLast > interval) {
                            doTrim = DEFAULT_VERIFY_ENABLE;
                            Slog.w(TAG, "No disk maintenance in " + timeSinceLast + "; running immediately");
                        }
                    }
                }
                if (doTrim) {
                    if (!isFirstBoot()) {
                        try {
                            ActivityManagerNative.getDefault().showBootMessage(this.mContext.getResources().getString(17040549), DEFAULT_VERIFY_ENABLE);
                        } catch (RemoteException e) {
                        }
                    }
                    ms.runMaintenance();
                }
            } else {
                Slog.e(TAG, "Mount service unavailable!");
            }
        } catch (RemoteException e2) {
        }
        synchronized (this.mPackages) {
            ArraySet<Package> pkgs = this.mDeferredDexOpt;
            this.mDeferredDexOpt = null;
        }
        if (pkgs != null) {
            Package pkg;
            ArrayList<Package> sortedPkgs = new ArrayList();
            Iterator<Package> it = pkgs.iterator();
            while (it.hasNext()) {
                pkg = (Package) it.next();
                if (pkg.coreApp) {
                    sortedPkgs.add(pkg);
                    it.remove();
                }
            }
            ArraySet<String> pkgNames = getPackageNamesForIntent(new Intent("android.intent.action.PRE_BOOT_COMPLETED"));
            it = pkgs.iterator();
            while (it.hasNext()) {
                pkg = (Package) it.next();
                if (pkgNames.contains(pkg.packageName)) {
                    sortedPkgs.add(pkg);
                    it.remove();
                }
            }
            it = pkgs.iterator();
            while (it.hasNext()) {
                pkg = (Package) it.next();
                if (isSystemApp(pkg) && !isUpdatedSystemApp(pkg)) {
                    sortedPkgs.add(pkg);
                    it.remove();
                }
            }
            it = pkgs.iterator();
            while (it.hasNext()) {
                pkg = (Package) it.next();
                if (isUpdatedSystemApp(pkg)) {
                    sortedPkgs.add(pkg);
                    it.remove();
                }
            }
            pkgNames = getPackageNamesForIntent(new Intent("android.intent.action.BOOT_COMPLETED"));
            it = pkgs.iterator();
            while (it.hasNext()) {
                pkg = (Package) it.next();
                if (pkgNames.contains(pkg.packageName)) {
                    sortedPkgs.add(pkg);
                    it.remove();
                }
            }
            filterRecentlyUsedApps(pkgs);
            Iterator i$ = pkgs.iterator();
            while (i$.hasNext()) {
                sortedPkgs.add((Package) i$.next());
            }
            if (this.mLazyDexOpt) {
                filterRecentlyUsedApps(sortedPkgs);
            }
            int i = DEX_OPT_SKIPPED;
            int total = sortedPkgs.size();
            File dataDir = Environment.getDataDirectory();
            long lowThreshold = StorageManager.from(this.mContext).getStorageLowBytes(dataDir);
            if (lowThreshold == 0) {
                throw new IllegalStateException("Invalid low memory threshold");
            }
            i$ = sortedPkgs.iterator();
            while (i$.hasNext()) {
                pkg = (Package) i$.next();
                long usableSpace = dataDir.getUsableSpace();
                if (usableSpace < lowThreshold) {
                    Log.w(TAG, "Not running dexopt on remaining apps due to low memory: " + usableSpace);
                    return;
                }
                i += UPDATE_PERMISSIONS_ALL;
                performBootDexOpt(pkg, i, total);
            }
        }
    }

    private void filterRecentlyUsedApps(Collection<Package> pkgs) {
        if (this.mLazyDexOpt || (!isFirstBoot() && this.mPackageUsage.isHistoricalPackageUsageAvailable())) {
            int total = pkgs.size();
            int skipped = DEX_OPT_SKIPPED;
            long now = System.currentTimeMillis();
            Iterator<Package> i = pkgs.iterator();
            while (i.hasNext()) {
                if (this.mDexOptLRUThresholdInMills + ((Package) i.next()).mLastPackageUsageTimeInMills < now) {
                    i.remove();
                    skipped += UPDATE_PERMISSIONS_ALL;
                }
            }
        }
    }

    private ArraySet<String> getPackageNamesForIntent(Intent intent) {
        List<ResolveInfo> ris = null;
        try {
            ris = AppGlobals.getPackageManager().queryIntentReceivers(intent, null, DEX_OPT_SKIPPED, DEX_OPT_SKIPPED);
        } catch (RemoteException e) {
        }
        ArraySet<String> pkgNames = new ArraySet();
        if (ris != null) {
            for (ResolveInfo ri : ris) {
                pkgNames.add(ri.activityInfo.packageName);
            }
        }
        return pkgNames;
    }

    private void performBootDexOpt(Package pkg, int curr, int total) {
        if (!isFirstBoot()) {
            try {
                IActivityManager iActivityManager = ActivityManagerNative.getDefault();
                Resources resources = this.mContext.getResources();
                Object[] objArr = new Object[UPDATE_PERMISSIONS_REPLACE_PKG];
                objArr[DEX_OPT_SKIPPED] = Integer.valueOf(curr);
                objArr[UPDATE_PERMISSIONS_ALL] = Integer.valueOf(total);
                iActivityManager.showBootMessage(resources.getString(17040550, objArr), DEFAULT_VERIFY_ENABLE);
            } catch (RemoteException e) {
            }
        }
        Package p = pkg;
        synchronized (this.mInstallLock) {
            performDexOptLI(p, null, (boolean) DEBUG_VERIFY, (boolean) DEBUG_VERIFY, (boolean) DEFAULT_VERIFY_ENABLE);
        }
    }

    public boolean performDexOptIfNeeded(String packageName, String instructionSet) {
        return performDexOpt(packageName, instructionSet, DEBUG_VERIFY);
    }

    private static String getPrimaryInstructionSet(ApplicationInfo info) {
        if (info.primaryCpuAbi == null) {
            return getPreferredInstructionSet();
        }
        return VMRuntime.getInstructionSet(info.primaryCpuAbi);
    }

    public boolean performDexOpt(String packageName, String instructionSet, boolean backgroundDexopt) {
        boolean dexopt;
        boolean updateUsage;
        if (this.mLazyDexOpt || backgroundDexopt) {
            dexopt = DEFAULT_VERIFY_ENABLE;
        } else {
            dexopt = DEBUG_VERIFY;
        }
        if (backgroundDexopt) {
            updateUsage = DEBUG_VERIFY;
        } else {
            updateUsage = DEFAULT_VERIFY_ENABLE;
        }
        if (!dexopt && !updateUsage) {
            return DEBUG_VERIFY;
        }
        synchronized (this.mPackages) {
            Package p = (Package) this.mPackages.get(packageName);
            if (p == null) {
                return DEBUG_VERIFY;
            }
            if (updateUsage) {
                p.mLastPackageUsageTimeInMills = System.currentTimeMillis();
            }
            this.mPackageUsage.write(DEBUG_VERIFY);
            if (dexopt) {
                String targetInstructionSet = instructionSet != null ? instructionSet : getPrimaryInstructionSet(p.applicationInfo);
                if (p.mDexOptPerformed.contains(targetInstructionSet)) {
                    return DEBUG_VERIFY;
                }
                boolean z;
                synchronized (this.mInstallLock) {
                    String[] instructionSets = new String[UPDATE_PERMISSIONS_ALL];
                    instructionSets[DEX_OPT_SKIPPED] = targetInstructionSet;
                    if (performDexOptLI(p, instructionSets, (boolean) DEBUG_VERIFY, (boolean) DEBUG_VERIFY, (boolean) DEFAULT_VERIFY_ENABLE) == UPDATE_PERMISSIONS_ALL) {
                        z = DEFAULT_VERIFY_ENABLE;
                    } else {
                        z = DEBUG_VERIFY;
                    }
                }
                return z;
            }
            return DEBUG_VERIFY;
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.util.ArraySet<java.lang.String> getPackagesThatNeedDexOpt() {
        /*
        r6 = this;
        r2 = 0;
        r5 = r6.mPackages;
        monitor-enter(r5);
        r4 = r6.mPackages;	 Catch:{ all -> 0x0033 }
        r4 = r4.values();	 Catch:{ all -> 0x0033 }
        r0 = r4.iterator();	 Catch:{ all -> 0x0033 }
        r3 = r2;
    L_0x000f:
        r4 = r0.hasNext();	 Catch:{ all -> 0x0036 }
        if (r4 == 0) goto L_0x0031;
    L_0x0015:
        r1 = r0.next();	 Catch:{ all -> 0x0036 }
        r1 = (android.content.pm.PackageParser.Package) r1;	 Catch:{ all -> 0x0036 }
        r4 = r1.mDexOptPerformed;	 Catch:{ all -> 0x0036 }
        r4 = r4.isEmpty();	 Catch:{ all -> 0x0036 }
        if (r4 == 0) goto L_0x000f;
    L_0x0023:
        if (r3 != 0) goto L_0x0039;
    L_0x0025:
        r2 = new android.util.ArraySet;	 Catch:{ all -> 0x0036 }
        r2.<init>();	 Catch:{ all -> 0x0036 }
    L_0x002a:
        r4 = r1.packageName;	 Catch:{ all -> 0x0033 }
        r2.add(r4);	 Catch:{ all -> 0x0033 }
        r3 = r2;
        goto L_0x000f;
    L_0x0031:
        monitor-exit(r5);	 Catch:{ all -> 0x0036 }
        return r3;
    L_0x0033:
        r4 = move-exception;
    L_0x0034:
        monitor-exit(r5);	 Catch:{ all -> 0x0033 }
        throw r4;
    L_0x0036:
        r4 = move-exception;
        r2 = r3;
        goto L_0x0034;
    L_0x0039:
        r2 = r3;
        goto L_0x002a;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageManagerService.getPackagesThatNeedDexOpt():android.util.ArraySet<java.lang.String>");
    }

    public void shutdown() {
        this.mPackageUsage.write(DEFAULT_VERIFY_ENABLE);
    }

    private void performDexOptLibsLI(ArrayList<String> libs, String[] instructionSets, boolean forceDex, boolean defer, ArraySet<String> done) {
        for (int i = DEX_OPT_SKIPPED; i < libs.size(); i += UPDATE_PERMISSIONS_ALL) {
            Package libPkg;
            synchronized (this.mPackages) {
                String libName = (String) libs.get(i);
                SharedLibraryEntry lib = (SharedLibraryEntry) this.mSharedLibraries.get(libName);
                if (lib == null || lib.apk == null) {
                    libPkg = null;
                } else {
                    libPkg = (Package) this.mPackages.get(lib.apk);
                }
            }
            if (!(libPkg == null || done.contains(libName))) {
                performDexOptLI(libPkg, instructionSets, forceDex, defer, (ArraySet) done);
            }
        }
    }

    private int performDexOptLI(Package pkg, String[] targetInstructionSets, boolean forceDex, boolean defer, ArraySet<String> done) {
        String[] instructionSets;
        if (targetInstructionSets != null) {
            instructionSets = targetInstructionSets;
        } else {
            instructionSets = getAppDexInstructionSets(pkg.applicationInfo);
        }
        if (done != null) {
            done.add(pkg.packageName);
            if (pkg.usesLibraries != null) {
                performDexOptLibsLI(pkg.usesLibraries, instructionSets, forceDex, defer, done);
            }
            if (pkg.usesOptionalLibraries != null) {
                performDexOptLibsLI(pkg.usesOptionalLibraries, instructionSets, forceDex, defer, done);
            }
        }
        if ((pkg.applicationInfo.flags & UPDATE_PERMISSIONS_REPLACE_ALL) == 0) {
            return DEX_OPT_SKIPPED;
        }
        boolean vmSafeMode = (pkg.applicationInfo.flags & 16384) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
        List<String> paths = pkg.getAllCodePathsExcludingResourceOnly();
        boolean performedDexOpt = DEBUG_VERIFY;
        String[] arr$ = getDexCodeInstructionSets(instructionSets);
        int len$ = arr$.length;
        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            String dexCodeInstructionSet = arr$[i$];
            if (forceDex || !pkg.mDexOptPerformed.contains(dexCodeInstructionSet)) {
                for (String path : paths) {
                    try {
                        byte isDexOptNeeded = DexFile.isDexOptNeededInternal(path, pkg.packageName, dexCodeInstructionSet, defer);
                        if (forceDex || (!defer && isDexOptNeeded == UPDATE_PERMISSIONS_REPLACE_PKG)) {
                            Log.i(TAG, "Running dexopt on: " + path + " pkg=" + pkg.applicationInfo.packageName + " isa=" + dexCodeInstructionSet + " vmSafeMode=" + vmSafeMode);
                            if (this.mInstaller.dexopt(path, UserHandle.getSharedAppGid(pkg.applicationInfo.uid), !isForwardLocked(pkg) ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY, pkg.packageName, dexCodeInstructionSet, vmSafeMode) < 0) {
                                return DEX_OPT_FAILED;
                            }
                            performedDexOpt = DEFAULT_VERIFY_ENABLE;
                        } else if (!defer && isDexOptNeeded == UPDATE_PERMISSIONS_ALL) {
                            Log.i(TAG, "Running patchoat on: " + pkg.applicationInfo.packageName);
                            if (this.mInstaller.patchoat(path, UserHandle.getSharedAppGid(pkg.applicationInfo.uid), !isForwardLocked(pkg) ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY, pkg.packageName, dexCodeInstructionSet) < 0) {
                                return DEX_OPT_FAILED;
                            }
                            performedDexOpt = DEFAULT_VERIFY_ENABLE;
                        }
                        if (defer && isDexOptNeeded != null) {
                            if (this.mDeferredDexOpt == null) {
                                this.mDeferredDexOpt = new ArraySet();
                            }
                            this.mDeferredDexOpt.add(pkg);
                            return UPDATE_PERMISSIONS_REPLACE_PKG;
                        }
                    } catch (FileNotFoundException e) {
                        Slog.w(TAG, "Apk not found for dexopt: " + path);
                        return DEX_OPT_FAILED;
                    } catch (IOException e2) {
                        Slog.w(TAG, "IOException reading apk: " + path, e2);
                        return DEX_OPT_FAILED;
                    } catch (StaleDexCacheError e3) {
                        Slog.w(TAG, "StaleDexCacheError when reading apk: " + path, e3);
                        return DEX_OPT_FAILED;
                    } catch (Exception e4) {
                        Slog.w(TAG, "Exception when doing dexopt : ", e4);
                        return DEX_OPT_FAILED;
                    }
                }
                pkg.mDexOptPerformed.add(dexCodeInstructionSet);
            }
        }
        return performedDexOpt ? UPDATE_PERMISSIONS_ALL : DEX_OPT_SKIPPED;
    }

    private static String[] getAppDexInstructionSets(ApplicationInfo info) {
        String[] strArr;
        if (info.primaryCpuAbi == null) {
            strArr = new String[UPDATE_PERMISSIONS_ALL];
            strArr[DEX_OPT_SKIPPED] = getPreferredInstructionSet();
            return strArr;
        } else if (info.secondaryCpuAbi != null) {
            strArr = new String[UPDATE_PERMISSIONS_REPLACE_PKG];
            strArr[DEX_OPT_SKIPPED] = VMRuntime.getInstructionSet(info.primaryCpuAbi);
            strArr[UPDATE_PERMISSIONS_ALL] = VMRuntime.getInstructionSet(info.secondaryCpuAbi);
            return strArr;
        } else {
            strArr = new String[UPDATE_PERMISSIONS_ALL];
            strArr[DEX_OPT_SKIPPED] = VMRuntime.getInstructionSet(info.primaryCpuAbi);
            return strArr;
        }
    }

    private static String[] getAppDexInstructionSets(PackageSetting ps) {
        String[] strArr;
        if (ps.primaryCpuAbiString == null) {
            strArr = new String[UPDATE_PERMISSIONS_ALL];
            strArr[DEX_OPT_SKIPPED] = getPreferredInstructionSet();
            return strArr;
        } else if (ps.secondaryCpuAbiString != null) {
            strArr = new String[UPDATE_PERMISSIONS_REPLACE_PKG];
            strArr[DEX_OPT_SKIPPED] = VMRuntime.getInstructionSet(ps.primaryCpuAbiString);
            strArr[UPDATE_PERMISSIONS_ALL] = VMRuntime.getInstructionSet(ps.secondaryCpuAbiString);
            return strArr;
        } else {
            strArr = new String[UPDATE_PERMISSIONS_ALL];
            strArr[DEX_OPT_SKIPPED] = VMRuntime.getInstructionSet(ps.primaryCpuAbiString);
            return strArr;
        }
    }

    private static String getPreferredInstructionSet() {
        if (sPreferredInstructionSet == null) {
            sPreferredInstructionSet = VMRuntime.getInstructionSet(Build.SUPPORTED_ABIS[DEX_OPT_SKIPPED]);
        }
        return sPreferredInstructionSet;
    }

    private static List<String> getAllInstructionSets() {
        String[] allAbis = Build.SUPPORTED_ABIS;
        List<String> allInstructionSets = new ArrayList(allAbis.length);
        String[] arr$ = allAbis;
        int len$ = arr$.length;
        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            String instructionSet = VMRuntime.getInstructionSet(arr$[i$]);
            if (!allInstructionSets.contains(instructionSet)) {
                allInstructionSets.add(instructionSet);
            }
        }
        return allInstructionSets;
    }

    private static String getDexCodeInstructionSet(String sharedLibraryIsa) {
        String dexCodeIsa = SystemProperties.get("ro.dalvik.vm.isa." + sharedLibraryIsa);
        return dexCodeIsa.isEmpty() ? sharedLibraryIsa : dexCodeIsa;
    }

    private static String[] getDexCodeInstructionSets(String[] instructionSets) {
        ArraySet<String> dexCodeInstructionSets = new ArraySet(instructionSets.length);
        String[] arr$ = instructionSets;
        int len$ = arr$.length;
        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            dexCodeInstructionSets.add(getDexCodeInstructionSet(arr$[i$]));
        }
        return (String[]) dexCodeInstructionSets.toArray(new String[dexCodeInstructionSets.size()]);
    }

    public static String[] getAllDexCodeInstructionSets() {
        String[] supportedInstructionSets = new String[Build.SUPPORTED_ABIS.length];
        for (int i = DEX_OPT_SKIPPED; i < supportedInstructionSets.length; i += UPDATE_PERMISSIONS_ALL) {
            supportedInstructionSets[i] = VMRuntime.getInstructionSet(Build.SUPPORTED_ABIS[i]);
        }
        return getDexCodeInstructionSets(supportedInstructionSets);
    }

    public void forceDexOpt(String packageName) {
        enforceSystemOrRoot("forceDexOpt");
        synchronized (this.mPackages) {
            Package pkg = (Package) this.mPackages.get(packageName);
            if (pkg == null) {
                throw new IllegalArgumentException("Missing package: " + packageName);
            }
        }
        synchronized (this.mInstallLock) {
            String[] instructionSets = new String[UPDATE_PERMISSIONS_ALL];
            instructionSets[DEX_OPT_SKIPPED] = getPrimaryInstructionSet(pkg.applicationInfo);
            int res = performDexOptLI(pkg, instructionSets, (boolean) DEFAULT_VERIFY_ENABLE, (boolean) DEBUG_VERIFY, (boolean) DEFAULT_VERIFY_ENABLE);
            if (res != UPDATE_PERMISSIONS_ALL) {
                throw new IllegalStateException("Failed to dexopt: " + res);
            }
        }
    }

    private int performDexOptLI(Package pkg, String[] instructionSets, boolean forceDex, boolean defer, boolean inclDependencies) {
        ArraySet done;
        if (!inclDependencies || (pkg.usesLibraries == null && pkg.usesOptionalLibraries == null)) {
            done = null;
        } else {
            done = new ArraySet();
            done.add(pkg.packageName);
        }
        return performDexOptLI(pkg, instructionSets, forceDex, defer, done);
    }

    private boolean verifyPackageUpdateLPr(PackageSetting oldPkg, Package newPkg) {
        if ((oldPkg.pkgFlags & UPDATE_PERMISSIONS_ALL) == 0) {
            Slog.w(TAG, "Unable to update from " + oldPkg.name + " to " + newPkg.packageName + ": old package not in system partition");
            return DEBUG_VERIFY;
        } else if (this.mPackages.get(oldPkg.name) == null) {
            return DEFAULT_VERIFY_ENABLE;
        } else {
            Slog.w(TAG, "Unable to update from " + oldPkg.name + " to " + newPkg.packageName + ": old package still exists");
            return DEBUG_VERIFY;
        }
    }

    File getDataPathForUser(int userId) {
        return new File(this.mUserAppDataDir.getAbsolutePath() + File.separator + userId);
    }

    private File getDataPathForPackage(String packageName, int userId) {
        if (userId == 0) {
            return new File(this.mAppDataDir, packageName);
        }
        return new File(this.mUserAppDataDir.getAbsolutePath() + File.separator + userId + File.separator + packageName);
    }

    private int createDataDirsLI(String packageName, int uid, String seinfo) {
        int[] users = sUserManager.getUserIds();
        int res = this.mInstaller.install(packageName, uid, uid, seinfo);
        if (res < 0) {
            return res;
        }
        int[] arr$ = users;
        int len$ = arr$.length;
        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            int user = arr$[i$];
            if (user != 0) {
                res = this.mInstaller.createUserData(packageName, UserHandle.getUid(user, uid), user, seinfo);
                if (res < 0) {
                    return res;
                }
            }
        }
        return res;
    }

    private int removeDataDirsLI(String packageName) {
        int[] users = sUserManager.getUserIds();
        int res = DEX_OPT_SKIPPED;
        int[] arr$ = users;
        int len$ = arr$.length;
        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            int resInner = this.mInstaller.remove(packageName, arr$[i$]);
            if (resInner < 0) {
                res = resInner;
            }
        }
        return res;
    }

    private int deleteCodeCacheDirsLI(String packageName) {
        int[] users = sUserManager.getUserIds();
        int res = DEX_OPT_SKIPPED;
        int[] arr$ = users;
        int len$ = arr$.length;
        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            int resInner = this.mInstaller.deleteCodeCacheFiles(packageName, arr$[i$]);
            if (resInner < 0) {
                res = resInner;
            }
        }
        return res;
    }

    private void addSharedLibraryLPw(ArraySet<String> usesLibraryFiles, SharedLibraryEntry file, Package changingLib) {
        if (file.path != null) {
            usesLibraryFiles.add(file.path);
            return;
        }
        Package p = (Package) this.mPackages.get(file.apk);
        if (changingLib != null && changingLib.packageName.equals(file.apk) && (p == null || p.packageName.equals(changingLib.packageName))) {
            p = changingLib;
        }
        if (p != null) {
            usesLibraryFiles.addAll(p.getAllCodePaths());
        }
    }

    private void updateSharedLibrariesLPw(Package pkg, Package changingLib) throws PackageManagerException {
        if (pkg.usesLibraries != null || pkg.usesOptionalLibraries != null) {
            int N;
            int i;
            SharedLibraryEntry file;
            ArraySet<String> usesLibraryFiles = new ArraySet();
            if (pkg.usesLibraries != null) {
                N = pkg.usesLibraries.size();
            } else {
                N = DEX_OPT_SKIPPED;
            }
            for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
                file = (SharedLibraryEntry) this.mSharedLibraries.get(pkg.usesLibraries.get(i));
                if (file == null) {
                    throw new PackageManagerException(-9, "Package " + pkg.packageName + " requires unavailable shared library " + ((String) pkg.usesLibraries.get(i)) + "; failing!");
                }
                addSharedLibraryLPw(usesLibraryFiles, file, changingLib);
            }
            if (pkg.usesOptionalLibraries != null) {
                N = pkg.usesOptionalLibraries.size();
            } else {
                N = DEX_OPT_SKIPPED;
            }
            for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
                file = (SharedLibraryEntry) this.mSharedLibraries.get(pkg.usesOptionalLibraries.get(i));
                if (file == null) {
                    Slog.w(TAG, "Package " + pkg.packageName + " desires unavailable shared library " + ((String) pkg.usesOptionalLibraries.get(i)) + "; ignoring!");
                } else {
                    addSharedLibraryLPw(usesLibraryFiles, file, changingLib);
                }
            }
            N = usesLibraryFiles.size();
            if (N > 0) {
                pkg.usesLibraryFiles = (String[]) usesLibraryFiles.toArray(new String[N]);
            } else {
                pkg.usesLibraryFiles = null;
            }
        }
    }

    private static boolean hasString(List<String> list, List<String> which) {
        if (list == null) {
            return DEBUG_VERIFY;
        }
        for (int i = list.size() + DEX_OPT_FAILED; i >= 0; i += DEX_OPT_FAILED) {
            for (int j = which.size() + DEX_OPT_FAILED; j >= 0; j += DEX_OPT_FAILED) {
                if (((String) which.get(j)).equals(list.get(i))) {
                    return DEFAULT_VERIFY_ENABLE;
                }
            }
        }
        return DEBUG_VERIFY;
    }

    private void updateAllSharedLibrariesLPw() {
        for (Package pkg : this.mPackages.values()) {
            try {
                updateSharedLibrariesLPw(pkg, null);
            } catch (PackageManagerException e) {
                Slog.e(TAG, "updateAllSharedLibrariesLPw failed: " + e.getMessage());
            }
        }
    }

    private ArrayList<Package> updateAllSharedLibrariesLPw(Package changingPkg) {
        ArrayList<Package> res = null;
        for (Package pkg : this.mPackages.values()) {
            if (hasString(pkg.usesLibraries, changingPkg.libraryNames) || hasString(pkg.usesOptionalLibraries, changingPkg.libraryNames)) {
                if (res == null) {
                    res = new ArrayList();
                }
                res.add(pkg);
                try {
                    updateSharedLibrariesLPw(pkg, changingPkg);
                } catch (PackageManagerException e) {
                    Slog.e(TAG, "updateAllSharedLibrariesLPw failed: " + e.getMessage());
                }
            }
        }
        return res;
    }

    private static String deriveAbiOverride(String abiOverride, PackageSetting settings) {
        if (INSTALL_PACKAGE_SUFFIX.equals(abiOverride)) {
            return null;
        }
        if (abiOverride != null) {
            return abiOverride;
        }
        if (settings != null) {
            return settings.cpuAbiOverrideString;
        }
        return null;
    }

    private Package scanPackageLI(Package pkg, int parseFlags, int scanFlags, long currentTime, UserHandle user) throws PackageManagerException {
        boolean success = DEBUG_VERIFY;
        try {
            Package res = scanPackageDirtyLI(pkg, parseFlags, scanFlags, currentTime, user);
            success = DEFAULT_VERIFY_ENABLE;
            return res;
        } finally {
            if (!(success || (scanFlags & SCAN_DELETE_DATA_ON_FAILURES) == 0)) {
                removeDataDirsLI(pkg.packageName);
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private android.content.pm.PackageParser.Package scanPackageDirtyLI(android.content.pm.PackageParser.Package r93, int r94, int r95, long r96, android.os.UserHandle r98) throws com.android.server.pm.PackageManagerException {
        /*
        r92 = this;
        r79 = new java.io.File;
        r0 = r93;
        r4 = r0.codePath;
        r0 = r79;
        r0.<init>(r4);
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.getCodePath();
        if (r4 == 0) goto L_0x001f;
    L_0x0015:
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.getResourcePath();
        if (r4 != 0) goto L_0x0028;
    L_0x001f:
        r4 = new com.android.server.pm.PackageManagerException;
        r5 = -2;
        r11 = "Code and resource paths haven't been set correctly";
        r4.<init>(r5, r11);
        throw r4;
    L_0x0028:
        r4 = r94 & 1;
        if (r4 == 0) goto L_0x00b4;
    L_0x002c:
        r0 = r93;
        r4 = r0.applicationInfo;
        r5 = r4.flags;
        r5 = r5 | 1;
        r4.flags = r5;
    L_0x0036:
        r0 = r94;
        r4 = r0 & 128;
        if (r4 == 0) goto L_0x0047;
    L_0x003c:
        r0 = r93;
        r4 = r0.applicationInfo;
        r5 = r4.flags;
        r11 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r5 = r5 | r11;
        r4.flags = r5;
    L_0x0047:
        r0 = r92;
        r4 = r0.mCustomResolverComponentName;
        if (r4 == 0) goto L_0x0062;
    L_0x004d:
        r0 = r92;
        r4 = r0.mCustomResolverComponentName;
        r4 = r4.getPackageName();
        r0 = r93;
        r5 = r0.packageName;
        r4 = r4.equals(r5);
        if (r4 == 0) goto L_0x0062;
    L_0x005f:
        r92.setUpCustomResolverActivity(r93);
    L_0x0062:
        r0 = r93;
        r4 = r0.packageName;
        r5 = "android";
        r4 = r4.equals(r5);
        if (r4 == 0) goto L_0x0163;
    L_0x006e:
        r0 = r92;
        r5 = r0.mPackages;
        monitor-enter(r5);
        r0 = r92;
        r4 = r0.mAndroidApplication;	 Catch:{ all -> 0x00b1 }
        if (r4 == 0) goto L_0x00bb;
    L_0x0079:
        r4 = "PackageManager";
        r11 = "*************************************************";
        android.util.Slog.w(r4, r11);	 Catch:{ all -> 0x00b1 }
        r4 = "PackageManager";
        r11 = "Core android package being redefined.  Skipping.";
        android.util.Slog.w(r4, r11);	 Catch:{ all -> 0x00b1 }
        r4 = "PackageManager";
        r11 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00b1 }
        r11.<init>();	 Catch:{ all -> 0x00b1 }
        r13 = " file=";
        r11 = r11.append(r13);	 Catch:{ all -> 0x00b1 }
        r0 = r79;
        r11 = r11.append(r0);	 Catch:{ all -> 0x00b1 }
        r11 = r11.toString();	 Catch:{ all -> 0x00b1 }
        android.util.Slog.w(r4, r11);	 Catch:{ all -> 0x00b1 }
        r4 = "PackageManager";
        r11 = "*************************************************";
        android.util.Slog.w(r4, r11);	 Catch:{ all -> 0x00b1 }
        r4 = new com.android.server.pm.PackageManagerException;	 Catch:{ all -> 0x00b1 }
        r11 = -5;
        r13 = "Core android package being redefined.  Skipping.";
        r4.<init>(r11, r13);	 Catch:{ all -> 0x00b1 }
        throw r4;	 Catch:{ all -> 0x00b1 }
    L_0x00b1:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x00b1 }
        throw r4;
    L_0x00b4:
        r4 = 0;
        r0 = r93;
        r0.coreApp = r4;
        goto L_0x0036;
    L_0x00bb:
        r0 = r93;
        r1 = r92;
        r1.mPlatformPackage = r0;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mSdkVersion;	 Catch:{ all -> 0x00b1 }
        r0 = r93;
        r0.mVersionCode = r4;	 Catch:{ all -> 0x00b1 }
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r0.mAndroidApplication = r4;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolverReplaced;	 Catch:{ all -> 0x00b1 }
        if (r4 != 0) goto L_0x0162;
    L_0x00d7:
        r0 = r92;
        r4 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r11 = r0.mAndroidApplication;	 Catch:{ all -> 0x00b1 }
        r4.applicationInfo = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r11 = com.android.internal.app.ResolverActivity.class;
        r11 = r11.getName();	 Catch:{ all -> 0x00b1 }
        r4.name = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r11 = r0.mAndroidApplication;	 Catch:{ all -> 0x00b1 }
        r11 = r11.packageName;	 Catch:{ all -> 0x00b1 }
        r4.packageName = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r11 = "system:ui";
        r4.processName = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r11 = 0;
        r4.launchMode = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r11 = 3;
        r4.documentLaunchMode = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r11 = 32;
        r4.flags = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r11 = 16974982; // 0x1030486 float:2.4064145E-38 double:8.3867554E-317;
        r4.theme = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r11 = 1;
        r4.exported = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r11 = 1;
        r4.enabled = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveInfo;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r11 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r4.activityInfo = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveInfo;	 Catch:{ all -> 0x00b1 }
        r11 = 0;
        r4.priority = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveInfo;	 Catch:{ all -> 0x00b1 }
        r11 = 0;
        r4.preferredOrder = r11;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r4 = r0.mResolveInfo;	 Catch:{ all -> 0x00b1 }
        r11 = 0;
        r4.match = r11;	 Catch:{ all -> 0x00b1 }
        r4 = new android.content.ComponentName;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r11 = r0.mAndroidApplication;	 Catch:{ all -> 0x00b1 }
        r11 = r11.packageName;	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r13 = r0.mResolveActivity;	 Catch:{ all -> 0x00b1 }
        r13 = r13.name;	 Catch:{ all -> 0x00b1 }
        r4.<init>(r11, r13);	 Catch:{ all -> 0x00b1 }
        r0 = r92;
        r0.mResolveComponentName = r4;	 Catch:{ all -> 0x00b1 }
    L_0x0162:
        monitor-exit(r5);	 Catch:{ all -> 0x00b1 }
    L_0x0163:
        r0 = r92;
        r4 = r0.mPackages;
        r0 = r93;
        r5 = r0.packageName;
        r4 = r4.containsKey(r5);
        if (r4 != 0) goto L_0x017f;
    L_0x0171:
        r0 = r92;
        r4 = r0.mSharedLibraries;
        r0 = r93;
        r5 = r0.packageName;
        r4 = r4.containsKey(r5);
        if (r4 == 0) goto L_0x01a3;
    L_0x017f:
        r4 = new com.android.server.pm.PackageManagerException;
        r5 = -5;
        r11 = new java.lang.StringBuilder;
        r11.<init>();
        r13 = "Application package ";
        r11 = r11.append(r13);
        r0 = r93;
        r13 = r0.packageName;
        r11 = r11.append(r13);
        r13 = " already installed.  Skipping duplicate.";
        r11 = r11.append(r13);
        r11 = r11.toString();
        r4.<init>(r5, r11);
        throw r4;
    L_0x01a3:
        r0 = r95;
        r4 = r0 & 4096;
        if (r4 == 0) goto L_0x0220;
    L_0x01a9:
        r0 = r92;
        r4 = r0.mSettings;
        r0 = r93;
        r5 = r0.packageName;
        r49 = r4.peekPackageLPr(r5);
        if (r49 == 0) goto L_0x0220;
    L_0x01b7:
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.getCodePath();
        r0 = r49;
        r5 = r0.codePathString;
        r4 = r4.equals(r5);
        if (r4 == 0) goto L_0x01db;
    L_0x01c9:
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.getResourcePath();
        r0 = r49;
        r5 = r0.resourcePathString;
        r4 = r4.equals(r5);
        if (r4 != 0) goto L_0x0220;
    L_0x01db:
        r4 = new com.android.server.pm.PackageManagerException;
        r5 = -23;
        r11 = new java.lang.StringBuilder;
        r11.<init>();
        r13 = "Application package ";
        r11 = r11.append(r13);
        r0 = r93;
        r13 = r0.packageName;
        r11 = r11.append(r13);
        r13 = " found at ";
        r11 = r11.append(r13);
        r0 = r93;
        r13 = r0.applicationInfo;
        r13 = r13.getCodePath();
        r11 = r11.append(r13);
        r13 = " but expected at ";
        r11 = r11.append(r13);
        r0 = r49;
        r13 = r0.codePathString;
        r11 = r11.append(r13);
        r13 = "; ignoring.";
        r11 = r11.append(r13);
        r11 = r11.toString();
        r4.<init>(r5, r11);
        throw r4;
    L_0x0220:
        r9 = new java.io.File;
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.getCodePath();
        r9.<init>(r4);
        r10 = new java.io.File;
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.getResourcePath();
        r10.<init>(r4);
        r8 = 0;
        r70 = 0;
        r4 = isSystemApp(r93);
        if (r4 != 0) goto L_0x0252;
    L_0x0243:
        r4 = 0;
        r0 = r93;
        r0.mOriginalPackages = r4;
        r4 = 0;
        r0 = r93;
        r0.mRealPackage = r4;
        r4 = 0;
        r0 = r93;
        r0.mAdoptPermissions = r4;
    L_0x0252:
        r0 = r92;
        r0 = r0.mPackages;
        r90 = r0;
        monitor-enter(r90);
        r0 = r93;
        r4 = r0.mSharedUserId;	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x0296;
    L_0x025f:
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.mSharedUserId;	 Catch:{ all -> 0x0293 }
        r11 = 0;
        r13 = 1;
        r8 = r4.getSharedUserLPw(r5, r11, r13);	 Catch:{ all -> 0x0293 }
        if (r8 != 0) goto L_0x0296;
    L_0x026f:
        r4 = new com.android.server.pm.PackageManagerException;	 Catch:{ all -> 0x0293 }
        r5 = -4;
        r11 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0293 }
        r11.<init>();	 Catch:{ all -> 0x0293 }
        r13 = "Creating application package ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r13 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r13 = " for shared user failed";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r11 = r11.toString();	 Catch:{ all -> 0x0293 }
        r4.<init>(r5, r11);	 Catch:{ all -> 0x0293 }
        throw r4;	 Catch:{ all -> 0x0293 }
    L_0x0293:
        r4 = move-exception;
        monitor-exit(r90);	 Catch:{ all -> 0x0293 }
        throw r4;
    L_0x0296:
        r6 = 0;
        r7 = 0;
        r0 = r93;
        r4 = r0.mOriginalPackages;	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x02d1;
    L_0x029e:
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0293 }
        r4 = r4.mRenamedPackages;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.mRealPackage;	 Catch:{ all -> 0x0293 }
        r76 = r4.get(r5);	 Catch:{ all -> 0x0293 }
        r76 = (java.lang.String) r76;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r4 = r0.mOriginalPackages;	 Catch:{ all -> 0x0293 }
        r0 = r76;
        r4 = r4.contains(r0);	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x034d;
    L_0x02ba:
        r0 = r93;
        r7 = r0.mRealPackage;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r4 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r0 = r76;
        r4 = r4.equals(r0);	 Catch:{ all -> 0x0293 }
        if (r4 != 0) goto L_0x02d1;
    L_0x02ca:
        r0 = r93;
        r1 = r76;
        r0.setPackageName(r1);	 Catch:{ all -> 0x0293 }
    L_0x02d1:
        r0 = r92;
        r4 = r0.mTransferedPackages;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r4 = r4.contains(r5);	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x0301;
    L_0x02df:
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0293 }
        r5.<init>();	 Catch:{ all -> 0x0293 }
        r11 = "Package ";
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r11 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r11 = " was transferred to another, but its .apk remains";
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r5 = r5.toString();	 Catch:{ all -> 0x0293 }
        android.util.Slog.w(r4, r5);	 Catch:{ all -> 0x0293 }
    L_0x0301:
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0293 }
        r11 = r5.nativeLibraryRootDir;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0293 }
        r12 = r5.primaryCpuAbi;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0293 }
        r13 = r5.secondaryCpuAbi;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0293 }
        r14 = r5.flags;	 Catch:{ all -> 0x0293 }
        r16 = 0;
        r5 = r93;
        r15 = r98;
        r70 = r4.getPackageLPw(r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16);	 Catch:{ all -> 0x0293 }
        if (r70 != 0) goto L_0x03d5;
    L_0x0329:
        r4 = new com.android.server.pm.PackageManagerException;	 Catch:{ all -> 0x0293 }
        r5 = -4;
        r11 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0293 }
        r11.<init>();	 Catch:{ all -> 0x0293 }
        r13 = "Creating application package ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r13 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r13 = " failed";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r11 = r11.toString();	 Catch:{ all -> 0x0293 }
        r4.<init>(r5, r11);	 Catch:{ all -> 0x0293 }
        throw r4;	 Catch:{ all -> 0x0293 }
    L_0x034d:
        r0 = r93;
        r4 = r0.mOriginalPackages;	 Catch:{ all -> 0x0293 }
        r4 = r4.size();	 Catch:{ all -> 0x0293 }
        r39 = r4 + -1;
    L_0x0357:
        if (r39 < 0) goto L_0x02d1;
    L_0x0359:
        r0 = r92;
        r5 = r0.mSettings;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r4 = r0.mOriginalPackages;	 Catch:{ all -> 0x0293 }
        r0 = r39;
        r4 = r4.get(r0);	 Catch:{ all -> 0x0293 }
        r4 = (java.lang.String) r4;	 Catch:{ all -> 0x0293 }
        r6 = r5.peekPackageLPr(r4);	 Catch:{ all -> 0x0293 }
        if (r6 == 0) goto L_0x037a;
    L_0x036f:
        r0 = r92;
        r1 = r93;
        r4 = r0.verifyPackageUpdateLPr(r6, r1);	 Catch:{ all -> 0x0293 }
        if (r4 != 0) goto L_0x037d;
    L_0x0379:
        r6 = 0;
    L_0x037a:
        r39 = r39 + -1;
        goto L_0x0357;
    L_0x037d:
        r4 = r6.sharedUser;	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x02d1;
    L_0x0381:
        r4 = r6.sharedUser;	 Catch:{ all -> 0x0293 }
        r4 = r4.name;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.mSharedUserId;	 Catch:{ all -> 0x0293 }
        r4 = r4.equals(r5);	 Catch:{ all -> 0x0293 }
        if (r4 != 0) goto L_0x02d1;
    L_0x038f:
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0293 }
        r5.<init>();	 Catch:{ all -> 0x0293 }
        r11 = "Unable to migrate data from ";
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r11 = r6.name;	 Catch:{ all -> 0x0293 }
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r11 = " to ";
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r11 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r11 = ": old uid ";
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r11 = r6.sharedUser;	 Catch:{ all -> 0x0293 }
        r11 = r11.name;	 Catch:{ all -> 0x0293 }
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r11 = " differs from ";
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r11 = r0.mSharedUserId;	 Catch:{ all -> 0x0293 }
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r5 = r5.toString();	 Catch:{ all -> 0x0293 }
        android.util.Slog.w(r4, r5);	 Catch:{ all -> 0x0293 }
        r6 = 0;
        goto L_0x037a;
    L_0x03d5:
        r0 = r70;
        r4 = r0.origPackage;	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x041b;
    L_0x03db:
        r4 = r6.name;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r0.setPackageName(r4);	 Catch:{ all -> 0x0293 }
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0293 }
        r4.<init>();	 Catch:{ all -> 0x0293 }
        r5 = "New package ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0293 }
        r0 = r70;
        r5 = r0.realName;	 Catch:{ all -> 0x0293 }
        r4 = r4.append(r5);	 Catch:{ all -> 0x0293 }
        r5 = " renamed to replace old package ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0293 }
        r0 = r70;
        r5 = r0.name;	 Catch:{ all -> 0x0293 }
        r4 = r4.append(r5);	 Catch:{ all -> 0x0293 }
        r53 = r4.toString();	 Catch:{ all -> 0x0293 }
        r4 = 5;
        r0 = r53;
        reportSettingsProblem(r4, r0);	 Catch:{ all -> 0x0293 }
        r0 = r92;
        r4 = r0.mTransferedPackages;	 Catch:{ all -> 0x0293 }
        r5 = r6.name;	 Catch:{ all -> 0x0293 }
        r4.add(r5);	 Catch:{ all -> 0x0293 }
        r4 = 0;
        r0 = r70;
        r0.origPackage = r4;	 Catch:{ all -> 0x0293 }
    L_0x041b:
        if (r7 == 0) goto L_0x0428;
    L_0x041d:
        r0 = r92;
        r4 = r0.mTransferedPackages;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r4.add(r5);	 Catch:{ all -> 0x0293 }
    L_0x0428:
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r4 = r4.isDisabledSystemPackageLPr(r5);	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x0440;
    L_0x0436:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ all -> 0x0293 }
        r5 = r4.flags;	 Catch:{ all -> 0x0293 }
        r5 = r5 | 128;
        r4.flags = r5;	 Catch:{ all -> 0x0293 }
    L_0x0440:
        r4 = r94 & 64;
        if (r4 != 0) goto L_0x044c;
    L_0x0444:
        r4 = 0;
        r0 = r92;
        r1 = r93;
        r0.updateSharedLibrariesLPw(r1, r4);	 Catch:{ all -> 0x0293 }
    L_0x044c:
        r0 = r92;
        r4 = r0.mFoundPolicyFile;	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x0455;
    L_0x0452:
        com.android.server.pm.SELinuxMMAC.assignSeinfoValue(r93);	 Catch:{ all -> 0x0293 }
    L_0x0455:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ all -> 0x0293 }
        r0 = r70;
        r5 = r0.appId;	 Catch:{ all -> 0x0293 }
        r4.uid = r5;	 Catch:{ all -> 0x0293 }
        r0 = r70;
        r1 = r93;
        r1.mExtras = r0;	 Catch:{ all -> 0x0293 }
        r0 = r70;
        r4 = r0.keySetData;	 Catch:{ all -> 0x0293 }
        r4 = r4.isUsingUpgradeKeySets();	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x0475;
    L_0x046f:
        r0 = r70;
        r4 = r0.sharedUser;	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x0592;
    L_0x0475:
        r0 = r92;
        r1 = r70;
        r2 = r93;
        r0.verifySignaturesLP(r1, r2);	 Catch:{ PackageManagerException -> 0x0526 }
        r0 = r70;
        r4 = r0.signatures;	 Catch:{ PackageManagerException -> 0x0526 }
        r0 = r93;
        r5 = r0.mSignatures;	 Catch:{ PackageManagerException -> 0x0526 }
        r4.mSignatures = r5;	 Catch:{ PackageManagerException -> 0x0526 }
    L_0x0488:
        r4 = r95 & 16;
        if (r4 == 0) goto L_0x05e0;
    L_0x048c:
        r0 = r93;
        r4 = r0.providers;	 Catch:{ all -> 0x0293 }
        r17 = r4.size();	 Catch:{ all -> 0x0293 }
        r39 = 0;
    L_0x0496:
        r0 = r39;
        r1 = r17;
        if (r0 >= r1) goto L_0x05e0;
    L_0x049c:
        r0 = r93;
        r4 = r0.providers;	 Catch:{ all -> 0x0293 }
        r0 = r39;
        r64 = r4.get(r0);	 Catch:{ all -> 0x0293 }
        r64 = (android.content.pm.PackageParser.Provider) r64;	 Catch:{ all -> 0x0293 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0293 }
        r4 = r4.authority;	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x05dc;
    L_0x04b0:
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0293 }
        r4 = r4.authority;	 Catch:{ all -> 0x0293 }
        r5 = ";";
        r55 = r4.split(r5);	 Catch:{ all -> 0x0293 }
        r48 = 0;
    L_0x04be:
        r0 = r55;
        r4 = r0.length;	 Catch:{ all -> 0x0293 }
        r0 = r48;
        if (r0 >= r4) goto L_0x05dc;
    L_0x04c5:
        r0 = r92;
        r4 = r0.mProvidersByAuthority;	 Catch:{ all -> 0x0293 }
        r5 = r55[r48];	 Catch:{ all -> 0x0293 }
        r4 = r4.containsKey(r5);	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x05d8;
    L_0x04d1:
        r0 = r92;
        r4 = r0.mProvidersByAuthority;	 Catch:{ all -> 0x0293 }
        r5 = r55[r48];	 Catch:{ all -> 0x0293 }
        r62 = r4.get(r5);	 Catch:{ all -> 0x0293 }
        r62 = (android.content.pm.PackageParser.Provider) r62;	 Catch:{ all -> 0x0293 }
        if (r62 == 0) goto L_0x05d4;
    L_0x04df:
        r4 = r62.getComponentName();	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x05d4;
    L_0x04e5:
        r4 = r62.getComponentName();	 Catch:{ all -> 0x0293 }
        r63 = r4.getPackageName();	 Catch:{ all -> 0x0293 }
    L_0x04ed:
        r4 = new com.android.server.pm.PackageManagerException;	 Catch:{ all -> 0x0293 }
        r5 = -13;
        r11 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0293 }
        r11.<init>();	 Catch:{ all -> 0x0293 }
        r13 = "Can't install because provider name ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r13 = r55[r48];	 Catch:{ all -> 0x0293 }
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r13 = " (in package ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r13 = r0.applicationInfo;	 Catch:{ all -> 0x0293 }
        r13 = r13.packageName;	 Catch:{ all -> 0x0293 }
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r13 = ") is already used by ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r0 = r63;
        r11 = r11.append(r0);	 Catch:{ all -> 0x0293 }
        r11 = r11.toString();	 Catch:{ all -> 0x0293 }
        r4.<init>(r5, r11);	 Catch:{ all -> 0x0293 }
        throw r4;	 Catch:{ all -> 0x0293 }
    L_0x0526:
        r36 = move-exception;
        r4 = r94 & 64;
        if (r4 != 0) goto L_0x052c;
    L_0x052b:
        throw r36;	 Catch:{ all -> 0x0293 }
    L_0x052c:
        r0 = r70;
        r4 = r0.signatures;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.mSignatures;	 Catch:{ all -> 0x0293 }
        r4.mSignatures = r5;	 Catch:{ all -> 0x0293 }
        r0 = r70;
        r4 = r0.sharedUser;	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x056d;
    L_0x053c:
        r0 = r70;
        r4 = r0.sharedUser;	 Catch:{ all -> 0x0293 }
        r4 = r4.signatures;	 Catch:{ all -> 0x0293 }
        r4 = r4.mSignatures;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.mSignatures;	 Catch:{ all -> 0x0293 }
        r4 = compareSignatures(r4, r5);	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x056d;
    L_0x054e:
        r4 = new com.android.server.pm.PackageManagerException;	 Catch:{ all -> 0x0293 }
        r5 = -104; // 0xffffffffffffff98 float:NaN double:NaN;
        r11 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0293 }
        r11.<init>();	 Catch:{ all -> 0x0293 }
        r13 = "Signature mismatch for shared user : ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r0 = r70;
        r13 = r0.sharedUser;	 Catch:{ all -> 0x0293 }
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r11 = r11.toString();	 Catch:{ all -> 0x0293 }
        r4.<init>(r5, r11);	 Catch:{ all -> 0x0293 }
        throw r4;	 Catch:{ all -> 0x0293 }
    L_0x056d:
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0293 }
        r4.<init>();	 Catch:{ all -> 0x0293 }
        r5 = "System package ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r4 = r4.append(r5);	 Catch:{ all -> 0x0293 }
        r5 = " signature changed; retaining data.";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0293 }
        r53 = r4.toString();	 Catch:{ all -> 0x0293 }
        r4 = 5;
        r0 = r53;
        reportSettingsProblem(r4, r0);	 Catch:{ all -> 0x0293 }
        goto L_0x0488;
    L_0x0592:
        r0 = r92;
        r1 = r70;
        r2 = r93;
        r4 = r0.checkUpgradeKeySetLP(r1, r2);	 Catch:{ all -> 0x0293 }
        if (r4 != 0) goto L_0x05c8;
    L_0x059e:
        r4 = new com.android.server.pm.PackageManagerException;	 Catch:{ all -> 0x0293 }
        r5 = -7;
        r11 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0293 }
        r11.<init>();	 Catch:{ all -> 0x0293 }
        r13 = "Package ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r13 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r13 = " upgrade keys do not match the ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r13 = "previously installed version";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0293 }
        r11 = r11.toString();	 Catch:{ all -> 0x0293 }
        r4.<init>(r5, r11);	 Catch:{ all -> 0x0293 }
        throw r4;	 Catch:{ all -> 0x0293 }
    L_0x05c8:
        r0 = r70;
        r4 = r0.signatures;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.mSignatures;	 Catch:{ all -> 0x0293 }
        r4.mSignatures = r5;	 Catch:{ all -> 0x0293 }
        goto L_0x0488;
    L_0x05d4:
        r63 = "?";
        goto L_0x04ed;
    L_0x05d8:
        r48 = r48 + 1;
        goto L_0x04be;
    L_0x05dc:
        r39 = r39 + 1;
        goto L_0x0496;
    L_0x05e0:
        r0 = r93;
        r4 = r0.mAdoptPermissions;	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x064e;
    L_0x05e6:
        r0 = r93;
        r4 = r0.mAdoptPermissions;	 Catch:{ all -> 0x0293 }
        r4 = r4.size();	 Catch:{ all -> 0x0293 }
        r39 = r4 + -1;
    L_0x05f0:
        if (r39 < 0) goto L_0x064e;
    L_0x05f2:
        r0 = r93;
        r4 = r0.mAdoptPermissions;	 Catch:{ all -> 0x0293 }
        r0 = r39;
        r61 = r4.get(r0);	 Catch:{ all -> 0x0293 }
        r61 = (java.lang.String) r61;	 Catch:{ all -> 0x0293 }
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0293 }
        r0 = r61;
        r60 = r4.peekPackageLPr(r0);	 Catch:{ all -> 0x0293 }
        if (r60 == 0) goto L_0x064b;
    L_0x060a:
        r0 = r92;
        r1 = r60;
        r2 = r93;
        r4 = r0.verifyPackageUpdateLPr(r1, r2);	 Catch:{ all -> 0x0293 }
        if (r4 == 0) goto L_0x064b;
    L_0x0616:
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0293 }
        r5.<init>();	 Catch:{ all -> 0x0293 }
        r11 = "Adopting permissions from ";
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r0 = r61;
        r5 = r5.append(r0);	 Catch:{ all -> 0x0293 }
        r11 = " to ";
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r11 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r5 = r5.append(r11);	 Catch:{ all -> 0x0293 }
        r5 = r5.toString();	 Catch:{ all -> 0x0293 }
        android.util.Slog.i(r4, r5);	 Catch:{ all -> 0x0293 }
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r5 = r0.packageName;	 Catch:{ all -> 0x0293 }
        r0 = r61;
        r4.transferPermissionsLPw(r0, r5);	 Catch:{ all -> 0x0293 }
    L_0x064b:
        r39 = r39 + -1;
        goto L_0x05f0;
    L_0x064e:
        monitor-exit(r90);	 Catch:{ all -> 0x0293 }
        r0 = r93;
        r0 = r0.packageName;
        r69 = r0;
        r80 = r79.lastModified();
        r4 = r95 & 4;
        if (r4 == 0) goto L_0x0780;
    L_0x065d:
        r14 = 1;
    L_0x065e:
        r0 = r93;
        r4 = r0.applicationInfo;
        r0 = r93;
        r5 = r0.applicationInfo;
        r5 = r5.packageName;
        r0 = r93;
        r11 = r0.applicationInfo;
        r11 = r11.processName;
        r0 = r93;
        r13 = r0.applicationInfo;
        r13 = r13.uid;
        r5 = fixProcessName(r5, r11, r13);
        r4.processName = r5;
        r0 = r92;
        r4 = r0.mPlatformPackage;
        r0 = r93;
        if (r4 != r0) goto L_0x0783;
    L_0x0682:
        r33 = new java.io.File;
        r4 = android.os.Environment.getDataDirectory();
        r5 = "system";
        r0 = r33;
        r0.<init>(r4, r5);
        r0 = r93;
        r4 = r0.applicationInfo;
        r5 = r33.getPath();
        r4.dataDir = r5;
    L_0x0699:
        r66 = r79.getPath();
        r0 = r93;
        r4 = r0.applicationInfo;
        r27 = r4.getCodePath();
        r0 = r93;
        r4 = r0.cpuAbiOverride;
        r0 = r70;
        r29 = deriveAbiOverride(r4, r0);
        r4 = isSystemApp(r93);
        if (r4 == 0) goto L_0x0a62;
    L_0x06b5:
        r4 = isUpdatedSystemApp(r93);
        if (r4 != 0) goto L_0x0a62;
    L_0x06bb:
        r0 = r92;
        r1 = r93;
        r2 = r70;
        r0.setBundledAppAbisAndRoots(r1, r2);
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.primaryCpuAbi;
        if (r4 != 0) goto L_0x06f3;
    L_0x06cc:
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.secondaryCpuAbi;
        if (r4 != 0) goto L_0x06f3;
    L_0x06d4:
        r4 = android.os.Build.SUPPORTED_64_BIT_ABIS;
        r4 = r4.length;
        if (r4 <= 0) goto L_0x06f3;
    L_0x06d9:
        r38 = 0;
        r38 = com.android.internal.content.NativeLibraryHelper.Handle.create(r79);	 Catch:{ IOException -> 0x0a3d }
        r4 = com.android.internal.content.NativeLibraryHelper.hasRenderscriptBitcode(r38);	 Catch:{ IOException -> 0x0a3d }
        if (r4 == 0) goto L_0x06f0;
    L_0x06e5:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ IOException -> 0x0a3d }
        r5 = android.os.Build.SUPPORTED_32_BIT_ABIS;	 Catch:{ IOException -> 0x0a3d }
        r11 = 0;
        r5 = r5[r11];	 Catch:{ IOException -> 0x0a3d }
        r4.primaryCpuAbi = r5;	 Catch:{ IOException -> 0x0a3d }
    L_0x06f0:
        libcore.io.IoUtils.closeQuietly(r38);
    L_0x06f3:
        r92.setNativeLibraryPaths(r93);
    L_0x06f6:
        r0 = r92;
        r4 = r0.mPlatformPackage;
        r0 = r93;
        if (r4 != r0) goto L_0x0713;
    L_0x06fe:
        r0 = r93;
        r5 = r0.applicationInfo;
        r4 = dalvik.system.VMRuntime.getRuntime();
        r4 = r4.is64Bit();
        if (r4 == 0) goto L_0x0cc7;
    L_0x070c:
        r4 = android.os.Build.SUPPORTED_64_BIT_ABIS;
        r11 = 0;
        r4 = r4[r11];
    L_0x0711:
        r5.primaryCpuAbi = r4;
    L_0x0713:
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.primaryCpuAbi;
        r0 = r70;
        r0.primaryCpuAbiString = r4;
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.secondaryCpuAbi;
        r0 = r70;
        r0.secondaryCpuAbiString = r4;
        r0 = r29;
        r1 = r70;
        r1.cpuAbiOverrideString = r0;
        r0 = r29;
        r1 = r93;
        r1.cpuAbiOverride = r0;
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.nativeLibraryRootDir;
        r0 = r70;
        r0.legacyNativeLibraryPathString = r4;
        r0 = r95;
        r4 = r0 & 256;
        if (r4 != 0) goto L_0x075d;
    L_0x0743:
        r0 = r70;
        r4 = r0.sharedUser;
        if (r4 == 0) goto L_0x075d;
    L_0x0749:
        r0 = r70;
        r4 = r0.sharedUser;
        r5 = r4.packages;
        r0 = r95;
        r4 = r0 & 128;
        if (r4 == 0) goto L_0x0cce;
    L_0x0755:
        r4 = 1;
    L_0x0756:
        r0 = r92;
        r1 = r93;
        r0.adjustCpuAbisForSharedUserLPw(r5, r1, r14, r4);
    L_0x075d:
        r4 = r95 & 2;
        if (r4 != 0) goto L_0x0cd4;
    L_0x0761:
        r13 = 0;
        r0 = r95;
        r4 = r0 & 128;
        if (r4 == 0) goto L_0x0cd1;
    L_0x0768:
        r15 = 1;
    L_0x0769:
        r16 = 0;
        r11 = r92;
        r12 = r93;
        r4 = r11.performDexOptLI(r12, r13, r14, r15, r16);
        r5 = -1;
        if (r4 != r5) goto L_0x0cd4;
    L_0x0776:
        r4 = new com.android.server.pm.PackageManagerException;
        r5 = -11;
        r11 = "scanPackageLI";
        r4.<init>(r5, r11);
        throw r4;
    L_0x0780:
        r14 = 0;
        goto L_0x065e;
    L_0x0783:
        r0 = r93;
        r4 = r0.packageName;
        r5 = 0;
        r0 = r92;
        r33 = r0.getDataPathForPackage(r4, r5);
        r85 = 0;
        r4 = r33.exists();
        if (r4 == 0) goto L_0x09d1;
    L_0x0796:
        r32 = 0;
        r4 = r33.getPath();	 Catch:{ ErrnoException -> 0x089d }
        r82 = android.system.Os.stat(r4);	 Catch:{ ErrnoException -> 0x089d }
        r0 = r82;
        r0 = r0.st_uid;	 Catch:{ ErrnoException -> 0x089d }
        r32 = r0;
    L_0x07a6:
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.uid;
        r0 = r32;
        if (r0 == r4) goto L_0x0971;
    L_0x07b0:
        r75 = 0;
        if (r32 != 0) goto L_0x07fb;
    L_0x07b4:
        r0 = r92;
        r4 = r0.mInstaller;
        r0 = r93;
        r5 = r0.applicationInfo;
        r5 = r5.uid;
        r0 = r93;
        r11 = r0.applicationInfo;
        r11 = r11.uid;
        r0 = r69;
        r77 = r4.fixUid(r0, r5, r11);
        if (r77 < 0) goto L_0x07fb;
    L_0x07cc:
        r75 = 1;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Package ";
        r4 = r4.append(r5);
        r0 = r93;
        r5 = r0.packageName;
        r4 = r4.append(r5);
        r5 = " unexpectedly changed to uid 0; recovered to ";
        r4 = r4.append(r5);
        r0 = r93;
        r5 = r0.applicationInfo;
        r5 = r5.uid;
        r4 = r4.append(r5);
        r53 = r4.toString();
        r4 = 5;
        r0 = r53;
        reportSettingsProblem(r4, r0);
    L_0x07fb:
        if (r75 != 0) goto L_0x09c2;
    L_0x07fd:
        r4 = r94 & 1;
        if (r4 != 0) goto L_0x0807;
    L_0x0801:
        r0 = r95;
        r4 = r0 & 256;
        if (r4 == 0) goto L_0x09c2;
    L_0x0807:
        r0 = r92;
        r1 = r69;
        r77 = r0.removeDataDirsLI(r1);
        if (r77 < 0) goto L_0x08c2;
    L_0x0811:
        r4 = r94 & 1;
        if (r4 == 0) goto L_0x08be;
    L_0x0815:
        r72 = "System package ";
    L_0x0817:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r0 = r72;
        r4 = r4.append(r0);
        r0 = r93;
        r5 = r0.packageName;
        r4 = r4.append(r5);
        r5 = " has changed from uid: ";
        r4 = r4.append(r5);
        r0 = r32;
        r4 = r4.append(r0);
        r5 = " to ";
        r4 = r4.append(r5);
        r0 = r93;
        r5 = r0.applicationInfo;
        r5 = r5.uid;
        r4 = r4.append(r5);
        r5 = "; old data erased";
        r4 = r4.append(r5);
        r53 = r4.toString();
        r4 = 5;
        r0 = r53;
        reportSettingsProblem(r4, r0);
        r75 = 1;
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.uid;
        r0 = r93;
        r5 = r0.applicationInfo;
        r5 = r5.seinfo;
        r0 = r92;
        r1 = r69;
        r77 = r0.createDataDirsLI(r1, r4, r5);
        r4 = -1;
        r0 = r77;
        if (r0 != r4) goto L_0x08c2;
    L_0x0871:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r0 = r72;
        r4 = r4.append(r0);
        r0 = r93;
        r5 = r0.packageName;
        r4 = r4.append(r5);
        r5 = " could not have data directory re-created after delete.";
        r4 = r4.append(r5);
        r53 = r4.toString();
        r4 = 5;
        r0 = r53;
        reportSettingsProblem(r4, r0);
        r4 = new com.android.server.pm.PackageManagerException;
        r5 = -4;
        r0 = r53;
        r4.<init>(r5, r0);
        throw r4;
    L_0x089d:
        r36 = move-exception;
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r11 = "Couldn't stat path ";
        r5 = r5.append(r11);
        r11 = r33.getPath();
        r5 = r5.append(r11);
        r5 = r5.toString();
        r0 = r36;
        android.util.Slog.e(r4, r5, r0);
        goto L_0x07a6;
    L_0x08be:
        r72 = "Third party package ";
        goto L_0x0817;
    L_0x08c2:
        if (r75 != 0) goto L_0x08c9;
    L_0x08c4:
        r4 = 1;
        r0 = r92;
        r0.mHasSystemUidErrors = r4;
    L_0x08c9:
        if (r75 != 0) goto L_0x0971;
    L_0x08cb:
        r0 = r93;
        r4 = r0.applicationInfo;
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r11 = "/mismatched_uid/settings_";
        r5 = r5.append(r11);
        r0 = r93;
        r11 = r0.applicationInfo;
        r11 = r11.uid;
        r5 = r5.append(r11);
        r11 = "/fs_";
        r5 = r5.append(r11);
        r0 = r32;
        r5 = r5.append(r0);
        r5 = r5.toString();
        r4.dataDir = r5;
        r0 = r93;
        r4 = r0.applicationInfo;
        r0 = r93;
        r5 = r0.applicationInfo;
        r5 = r5.dataDir;
        r4.nativeLibraryDir = r5;
        r0 = r93;
        r4 = r0.applicationInfo;
        r0 = r93;
        r5 = r0.applicationInfo;
        r5 = r5.dataDir;
        r4.nativeLibraryRootDir = r5;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Package ";
        r4 = r4.append(r5);
        r0 = r93;
        r5 = r0.packageName;
        r4 = r4.append(r5);
        r5 = " has mismatched uid: ";
        r4 = r4.append(r5);
        r0 = r32;
        r4 = r4.append(r0);
        r5 = " on disk, ";
        r4 = r4.append(r5);
        r0 = r93;
        r5 = r0.applicationInfo;
        r5 = r5.uid;
        r4 = r4.append(r5);
        r5 = " in settings";
        r4 = r4.append(r5);
        r53 = r4.toString();
        r0 = r92;
        r5 = r0.mPackages;
        monitor-enter(r5);
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x09ce }
        r4 = r4.mReadMessages;	 Catch:{ all -> 0x09ce }
        r0 = r53;
        r4.append(r0);	 Catch:{ all -> 0x09ce }
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x09ce }
        r4 = r4.mReadMessages;	 Catch:{ all -> 0x09ce }
        r11 = 10;
        r4.append(r11);	 Catch:{ all -> 0x09ce }
        r85 = 1;
        r0 = r70;
        r4 = r0.uidError;	 Catch:{ all -> 0x09ce }
        if (r4 != 0) goto L_0x0970;
    L_0x096a:
        r4 = 6;
        r0 = r53;
        reportSettingsProblem(r4, r0);	 Catch:{ all -> 0x09ce }
    L_0x0970:
        monitor-exit(r5);	 Catch:{ all -> 0x09ce }
    L_0x0971:
        r0 = r93;
        r4 = r0.applicationInfo;
        r5 = r33.getPath();
        r4.dataDir = r5;
        r0 = r92;
        r4 = r0.mShouldRestoreconData;
        if (r4 == 0) goto L_0x09ba;
    L_0x0981:
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r11 = "SELinux relabeling of ";
        r5 = r5.append(r11);
        r0 = r93;
        r11 = r0.packageName;
        r5 = r5.append(r11);
        r11 = " issued.";
        r5 = r5.append(r11);
        r5 = r5.toString();
        android.util.Slog.i(r4, r5);
        r0 = r92;
        r4 = r0.mInstaller;
        r0 = r93;
        r5 = r0.packageName;
        r0 = r93;
        r11 = r0.applicationInfo;
        r11 = r11.seinfo;
        r0 = r93;
        r13 = r0.applicationInfo;
        r13 = r13.uid;
        r4.restoreconData(r5, r11, r13);
    L_0x09ba:
        r0 = r85;
        r1 = r70;
        r1.uidError = r0;
        goto L_0x0699;
    L_0x09c2:
        if (r75 != 0) goto L_0x08c9;
    L_0x09c4:
        r4 = new com.android.server.pm.PackageManagerException;
        r5 = -24;
        r11 = "scanPackageLI";
        r4.<init>(r5, r11);
        throw r4;
    L_0x09ce:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x09ce }
        throw r4;
    L_0x09d1:
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.uid;
        r0 = r93;
        r5 = r0.applicationInfo;
        r5 = r5.seinfo;
        r0 = r92;
        r1 = r69;
        r77 = r0.createDataDirsLI(r1, r4, r5);
        if (r77 >= 0) goto L_0x0a09;
    L_0x09e7:
        r4 = new com.android.server.pm.PackageManagerException;
        r5 = -4;
        r11 = new java.lang.StringBuilder;
        r11.<init>();
        r13 = "Unable to create data dirs [errorCode=";
        r11 = r11.append(r13);
        r0 = r77;
        r11 = r11.append(r0);
        r13 = "]";
        r11 = r11.append(r13);
        r11 = r11.toString();
        r4.<init>(r5, r11);
        throw r4;
    L_0x0a09:
        r4 = r33.exists();
        if (r4 == 0) goto L_0x0a1a;
    L_0x0a0f:
        r0 = r93;
        r4 = r0.applicationInfo;
        r5 = r33.getPath();
        r4.dataDir = r5;
        goto L_0x09ba;
    L_0x0a1a:
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r11 = "Unable to create data directory: ";
        r5 = r5.append(r11);
        r0 = r33;
        r5 = r5.append(r0);
        r5 = r5.toString();
        android.util.Slog.w(r4, r5);
        r0 = r93;
        r4 = r0.applicationInfo;
        r5 = 0;
        r4.dataDir = r5;
        goto L_0x09ba;
    L_0x0a3d:
        r42 = move-exception;
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0a5d }
        r5.<init>();	 Catch:{ all -> 0x0a5d }
        r11 = "Error scanning system app : ";
        r5 = r5.append(r11);	 Catch:{ all -> 0x0a5d }
        r0 = r42;
        r5 = r5.append(r0);	 Catch:{ all -> 0x0a5d }
        r5 = r5.toString();	 Catch:{ all -> 0x0a5d }
        android.util.Slog.w(r4, r5);	 Catch:{ all -> 0x0a5d }
        libcore.io.IoUtils.closeQuietly(r38);
        goto L_0x06f3;
    L_0x0a5d:
        r4 = move-exception;
        libcore.io.IoUtils.closeQuietly(r38);
        throw r4;
    L_0x0a62:
        r92.setNativeLibraryPaths(r93);
        r4 = isForwardLocked(r93);
        if (r4 != 0) goto L_0x0a71;
    L_0x0a6b:
        r4 = isExternal(r93);
        if (r4 == 0) goto L_0x0b81;
    L_0x0a71:
        r43 = 1;
    L_0x0a73:
        r0 = r93;
        r4 = r0.applicationInfo;
        r0 = r4.nativeLibraryRootDir;
        r58 = r0;
        r0 = r93;
        r4 = r0.applicationInfo;
        r0 = r4.nativeLibraryRootRequiresIsa;
        r87 = r0;
        r38 = 0;
        r38 = com.android.internal.content.NativeLibraryHelper.Handle.create(r79);	 Catch:{ IOException -> 0x0bab }
        r57 = new java.io.File;	 Catch:{ IOException -> 0x0bab }
        r57.<init>(r58);	 Catch:{ IOException -> 0x0bab }
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ IOException -> 0x0bab }
        r5 = 0;
        r4.primaryCpuAbi = r5;	 Catch:{ IOException -> 0x0bab }
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ IOException -> 0x0bab }
        r5 = 0;
        r4.secondaryCpuAbi = r5;	 Catch:{ IOException -> 0x0bab }
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ IOException -> 0x0bab }
        r4 = isMultiArch(r4);	 Catch:{ IOException -> 0x0bab }
        if (r4 == 0) goto L_0x0bcd;
    L_0x0aa6:
        r0 = r93;
        r4 = r0.cpuAbiOverride;	 Catch:{ IOException -> 0x0bab }
        if (r4 == 0) goto L_0x0abf;
    L_0x0aac:
        r4 = "-";
        r0 = r93;
        r5 = r0.cpuAbiOverride;	 Catch:{ IOException -> 0x0bab }
        r4 = r4.equals(r5);	 Catch:{ IOException -> 0x0bab }
        if (r4 != 0) goto L_0x0abf;
    L_0x0ab8:
        r4 = "PackageManager";
        r5 = "Ignoring abiOverride for multi arch application.";
        android.util.Slog.w(r4, r5);	 Catch:{ IOException -> 0x0bab }
    L_0x0abf:
        r20 = -114; // 0xffffffffffffff8e float:NaN double:NaN;
        r21 = -114; // 0xffffffffffffff8e float:NaN double:NaN;
        r4 = android.os.Build.SUPPORTED_32_BIT_ABIS;	 Catch:{ IOException -> 0x0bab }
        r4 = r4.length;	 Catch:{ IOException -> 0x0bab }
        if (r4 <= 0) goto L_0x0ad2;
    L_0x0ac8:
        if (r43 == 0) goto L_0x0b85;
    L_0x0aca:
        r4 = android.os.Build.SUPPORTED_32_BIT_ABIS;	 Catch:{ IOException -> 0x0bab }
        r0 = r38;
        r20 = com.android.internal.content.NativeLibraryHelper.findSupportedAbi(r0, r4);	 Catch:{ IOException -> 0x0bab }
    L_0x0ad2:
        r4 = "Error unpackaging 32 bit native libs for multiarch app.";
        r0 = r20;
        maybeThrowExceptionForMultiArchCopy(r4, r0);	 Catch:{ IOException -> 0x0bab }
        r4 = android.os.Build.SUPPORTED_64_BIT_ABIS;	 Catch:{ IOException -> 0x0bab }
        r4 = r4.length;	 Catch:{ IOException -> 0x0bab }
        if (r4 <= 0) goto L_0x0ae8;
    L_0x0ade:
        if (r43 == 0) goto L_0x0b93;
    L_0x0ae0:
        r4 = android.os.Build.SUPPORTED_64_BIT_ABIS;	 Catch:{ IOException -> 0x0bab }
        r0 = r38;
        r21 = com.android.internal.content.NativeLibraryHelper.findSupportedAbi(r0, r4);	 Catch:{ IOException -> 0x0bab }
    L_0x0ae8:
        r4 = "Error unpackaging 64 bit native libs for multiarch app.";
        r0 = r21;
        maybeThrowExceptionForMultiArchCopy(r4, r0);	 Catch:{ IOException -> 0x0bab }
        if (r21 < 0) goto L_0x0afb;
    L_0x0af1:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ IOException -> 0x0bab }
        r5 = android.os.Build.SUPPORTED_64_BIT_ABIS;	 Catch:{ IOException -> 0x0bab }
        r5 = r5[r21];	 Catch:{ IOException -> 0x0bab }
        r4.primaryCpuAbi = r5;	 Catch:{ IOException -> 0x0bab }
    L_0x0afb:
        if (r20 < 0) goto L_0x0b0b;
    L_0x0afd:
        r4 = android.os.Build.SUPPORTED_32_BIT_ABIS;	 Catch:{ IOException -> 0x0bab }
        r19 = r4[r20];	 Catch:{ IOException -> 0x0bab }
        if (r21 < 0) goto L_0x0ba1;
    L_0x0b03:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ IOException -> 0x0bab }
        r0 = r19;
        r4.secondaryCpuAbi = r0;	 Catch:{ IOException -> 0x0bab }
    L_0x0b0b:
        libcore.io.IoUtils.closeQuietly(r38);
    L_0x0b0e:
        r92.setNativeLibraryPaths(r93);
        r4 = sUserManager;
        r89 = r4.getUserIds();
        r0 = r92;
        r5 = r0.mInstallLock;
        monitor-enter(r5);
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ all -> 0x0b7e }
        r4 = r4.primaryCpuAbi;	 Catch:{ all -> 0x0b7e }
        if (r4 == 0) goto L_0x0cc4;
    L_0x0b24:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ all -> 0x0b7e }
        r4 = r4.primaryCpuAbi;	 Catch:{ all -> 0x0b7e }
        r4 = dalvik.system.VMRuntime.is64BitAbi(r4);	 Catch:{ all -> 0x0b7e }
        if (r4 != 0) goto L_0x0cc4;
    L_0x0b30:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ all -> 0x0b7e }
        r0 = r4.nativeLibraryDir;	 Catch:{ all -> 0x0b7e }
        r56 = r0;
        r24 = r89;
        r0 = r24;
        r0 = r0.length;	 Catch:{ all -> 0x0b7e }
        r51 = r0;
        r40 = 0;
    L_0x0b41:
        r0 = r40;
        r1 = r51;
        if (r0 >= r1) goto L_0x0cc4;
    L_0x0b47:
        r88 = r24[r40];	 Catch:{ all -> 0x0b7e }
        r0 = r92;
        r4 = r0.mInstaller;	 Catch:{ all -> 0x0b7e }
        r0 = r93;
        r11 = r0.packageName;	 Catch:{ all -> 0x0b7e }
        r0 = r56;
        r1 = r88;
        r4 = r4.linkNativeLibraryDirectory(r11, r0, r1);	 Catch:{ all -> 0x0b7e }
        if (r4 >= 0) goto L_0x0cc0;
    L_0x0b5b:
        r4 = new com.android.server.pm.PackageManagerException;	 Catch:{ all -> 0x0b7e }
        r11 = -110; // 0xffffffffffffff92 float:NaN double:NaN;
        r13 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0b7e }
        r13.<init>();	 Catch:{ all -> 0x0b7e }
        r15 = "Failed linking native library dir (user=";
        r13 = r13.append(r15);	 Catch:{ all -> 0x0b7e }
        r0 = r88;
        r13 = r13.append(r0);	 Catch:{ all -> 0x0b7e }
        r15 = ")";
        r13 = r13.append(r15);	 Catch:{ all -> 0x0b7e }
        r13 = r13.toString();	 Catch:{ all -> 0x0b7e }
        r4.<init>(r11, r13);	 Catch:{ all -> 0x0b7e }
        throw r4;	 Catch:{ all -> 0x0b7e }
    L_0x0b7e:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0b7e }
        throw r4;
    L_0x0b81:
        r43 = 0;
        goto L_0x0a73;
    L_0x0b85:
        r4 = android.os.Build.SUPPORTED_32_BIT_ABIS;	 Catch:{ IOException -> 0x0bab }
        r0 = r38;
        r1 = r57;
        r2 = r87;
        r20 = com.android.internal.content.NativeLibraryHelper.copyNativeBinariesForSupportedAbi(r0, r1, r4, r2);	 Catch:{ IOException -> 0x0bab }
        goto L_0x0ad2;
    L_0x0b93:
        r4 = android.os.Build.SUPPORTED_64_BIT_ABIS;	 Catch:{ IOException -> 0x0bab }
        r0 = r38;
        r1 = r57;
        r2 = r87;
        r21 = com.android.internal.content.NativeLibraryHelper.copyNativeBinariesForSupportedAbi(r0, r1, r4, r2);	 Catch:{ IOException -> 0x0bab }
        goto L_0x0ae8;
    L_0x0ba1:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ IOException -> 0x0bab }
        r0 = r19;
        r4.primaryCpuAbi = r0;	 Catch:{ IOException -> 0x0bab }
        goto L_0x0b0b;
    L_0x0bab:
        r42 = move-exception;
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0c19 }
        r5.<init>();	 Catch:{ all -> 0x0c19 }
        r11 = "Unable to get canonical file ";
        r5 = r5.append(r11);	 Catch:{ all -> 0x0c19 }
        r11 = r42.toString();	 Catch:{ all -> 0x0c19 }
        r5 = r5.append(r11);	 Catch:{ all -> 0x0c19 }
        r5 = r5.toString();	 Catch:{ all -> 0x0c19 }
        android.util.Slog.e(r4, r5);	 Catch:{ all -> 0x0c19 }
        libcore.io.IoUtils.closeQuietly(r38);
        goto L_0x0b0e;
    L_0x0bcd:
        if (r29 == 0) goto L_0x0c1e;
    L_0x0bcf:
        r4 = 1;
        r0 = new java.lang.String[r4];	 Catch:{ IOException -> 0x0bab }
        r22 = r0;
        r4 = 0;
        r22[r4] = r29;	 Catch:{ IOException -> 0x0bab }
    L_0x0bd7:
        r59 = 0;
        r4 = android.os.Build.SUPPORTED_64_BIT_ABIS;	 Catch:{ IOException -> 0x0bab }
        r4 = r4.length;	 Catch:{ IOException -> 0x0bab }
        if (r4 <= 0) goto L_0x0bea;
    L_0x0bde:
        if (r29 != 0) goto L_0x0bea;
    L_0x0be0:
        r4 = com.android.internal.content.NativeLibraryHelper.hasRenderscriptBitcode(r38);	 Catch:{ IOException -> 0x0bab }
        if (r4 == 0) goto L_0x0bea;
    L_0x0be6:
        r22 = android.os.Build.SUPPORTED_32_BIT_ABIS;	 Catch:{ IOException -> 0x0bab }
        r59 = 1;
    L_0x0bea:
        if (r43 == 0) goto L_0x0c21;
    L_0x0bec:
        r0 = r38;
        r1 = r22;
        r28 = com.android.internal.content.NativeLibraryHelper.findSupportedAbi(r0, r1);	 Catch:{ IOException -> 0x0bab }
    L_0x0bf4:
        if (r28 >= 0) goto L_0x0c95;
    L_0x0bf6:
        r4 = -114; // 0xffffffffffffff8e float:NaN double:NaN;
        r0 = r28;
        if (r0 == r4) goto L_0x0c95;
    L_0x0bfc:
        r4 = new com.android.server.pm.PackageManagerException;	 Catch:{ IOException -> 0x0bab }
        r5 = -110; // 0xffffffffffffff92 float:NaN double:NaN;
        r11 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x0bab }
        r11.<init>();	 Catch:{ IOException -> 0x0bab }
        r13 = "Error unpackaging native libs for app, errorCode=";
        r11 = r11.append(r13);	 Catch:{ IOException -> 0x0bab }
        r0 = r28;
        r11 = r11.append(r0);	 Catch:{ IOException -> 0x0bab }
        r11 = r11.toString();	 Catch:{ IOException -> 0x0bab }
        r4.<init>(r5, r11);	 Catch:{ IOException -> 0x0bab }
        throw r4;	 Catch:{ IOException -> 0x0bab }
    L_0x0c19:
        r4 = move-exception;
        libcore.io.IoUtils.closeQuietly(r38);
        throw r4;
    L_0x0c1e:
        r22 = android.os.Build.SUPPORTED_ABIS;	 Catch:{ IOException -> 0x0bab }
        goto L_0x0bd7;
    L_0x0c21:
        r0 = r38;
        r1 = r22;
        r71 = com.android.internal.content.NativeLibraryHelper.findSupportedAbi(r0, r1);	 Catch:{ IOException -> 0x0bab }
        if (r71 >= 0) goto L_0x0c4e;
    L_0x0c2b:
        r4 = -114; // 0xffffffffffffff8e float:NaN double:NaN;
        r0 = r71;
        if (r0 == r4) goto L_0x0c4e;
    L_0x0c31:
        r4 = new com.android.server.pm.PackageManagerException;	 Catch:{ IOException -> 0x0bab }
        r5 = -110; // 0xffffffffffffff92 float:NaN double:NaN;
        r11 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x0bab }
        r11.<init>();	 Catch:{ IOException -> 0x0bab }
        r13 = "Error unpackaging native libs for app, errorCode=";
        r11 = r11.append(r13);	 Catch:{ IOException -> 0x0bab }
        r0 = r71;
        r11 = r11.append(r0);	 Catch:{ IOException -> 0x0bab }
        r11 = r11.toString();	 Catch:{ IOException -> 0x0bab }
        r4.<init>(r5, r11);	 Catch:{ IOException -> 0x0bab }
        throw r4;	 Catch:{ IOException -> 0x0bab }
    L_0x0c4e:
        if (r71 < 0) goto L_0x0c87;
    L_0x0c50:
        r73 = r22[r71];	 Catch:{ IOException -> 0x0bab }
    L_0x0c52:
        r41 = dalvik.system.VMRuntime.getInstructionSet(r73);	 Catch:{ IOException -> 0x0bab }
        r34 = getDexCodeInstructionSet(r41);	 Catch:{ IOException -> 0x0bab }
        r0 = r93;
        r4 = r0.baseCodePath;	 Catch:{ IOException -> 0x0bab }
        r0 = r93;
        r5 = r0.packageName;	 Catch:{ IOException -> 0x0bab }
        r11 = 0;
        r0 = r34;
        r35 = dalvik.system.DexFile.isDexOptNeededInternal(r4, r5, r0, r11);	 Catch:{ IOException -> 0x0bab }
        if (r35 == 0) goto L_0x0c8b;
    L_0x0c6b:
        r45 = 1;
    L_0x0c6d:
        if (r45 != 0) goto L_0x0c75;
    L_0x0c6f:
        r4 = isUpdatedSystemApp(r93);	 Catch:{ IOException -> 0x0bab }
        if (r4 == 0) goto L_0x0c8e;
    L_0x0c75:
        r44 = 1;
    L_0x0c77:
        if (r44 == 0) goto L_0x0c91;
    L_0x0c79:
        r0 = r38;
        r1 = r57;
        r2 = r22;
        r3 = r87;
        r28 = com.android.internal.content.NativeLibraryHelper.copyNativeBinariesForSupportedAbi(r0, r1, r2, r3);	 Catch:{ IOException -> 0x0bab }
        goto L_0x0bf4;
    L_0x0c87:
        r4 = 0;
        r73 = r22[r4];	 Catch:{ IOException -> 0x0bab }
        goto L_0x0c52;
    L_0x0c8b:
        r45 = 0;
        goto L_0x0c6d;
    L_0x0c8e:
        r44 = 0;
        goto L_0x0c77;
    L_0x0c91:
        r28 = r71;
        goto L_0x0bf4;
    L_0x0c95:
        if (r28 < 0) goto L_0x0ca1;
    L_0x0c97:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ IOException -> 0x0bab }
        r5 = r22[r28];	 Catch:{ IOException -> 0x0bab }
        r4.primaryCpuAbi = r5;	 Catch:{ IOException -> 0x0bab }
        goto L_0x0b0b;
    L_0x0ca1:
        r4 = -114; // 0xffffffffffffff8e float:NaN double:NaN;
        r0 = r28;
        if (r0 != r4) goto L_0x0cb3;
    L_0x0ca7:
        if (r29 == 0) goto L_0x0cb3;
    L_0x0ca9:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ IOException -> 0x0bab }
        r0 = r29;
        r4.primaryCpuAbi = r0;	 Catch:{ IOException -> 0x0bab }
        goto L_0x0b0b;
    L_0x0cb3:
        if (r59 == 0) goto L_0x0b0b;
    L_0x0cb5:
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ IOException -> 0x0bab }
        r5 = 0;
        r5 = r22[r5];	 Catch:{ IOException -> 0x0bab }
        r4.primaryCpuAbi = r5;	 Catch:{ IOException -> 0x0bab }
        goto L_0x0b0b;
    L_0x0cc0:
        r40 = r40 + 1;
        goto L_0x0b41;
    L_0x0cc4:
        monitor-exit(r5);	 Catch:{ all -> 0x0b7e }
        goto L_0x06f6;
    L_0x0cc7:
        r4 = android.os.Build.SUPPORTED_32_BIT_ABIS;
        r11 = 0;
        r4 = r4[r11];
        goto L_0x0711;
    L_0x0cce:
        r4 = 0;
        goto L_0x0756;
    L_0x0cd1:
        r15 = 0;
        goto L_0x0769;
    L_0x0cd4:
        r0 = r92;
        r4 = r0.mFactoryTest;
        if (r4 == 0) goto L_0x0cf0;
    L_0x0cda:
        r0 = r93;
        r4 = r0.requestedPermissions;
        r5 = "android.permission.FACTORY_TEST";
        r4 = r4.contains(r5);
        if (r4 == 0) goto L_0x0cf0;
    L_0x0ce6:
        r0 = r93;
        r4 = r0.applicationInfo;
        r5 = r4.flags;
        r5 = r5 | 16;
        r4.flags = r5;
    L_0x0cf0:
        r26 = 0;
        r0 = r92;
        r5 = r0.mPackages;
        monitor-enter(r5);
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ all -> 0x0dd1 }
        r4 = r4.flags;	 Catch:{ all -> 0x0dd1 }
        r4 = r4 & 1;
        if (r4 == 0) goto L_0x0e0d;
    L_0x0d01:
        r0 = r93;
        r4 = r0.libraryNames;	 Catch:{ all -> 0x0dd1 }
        if (r4 == 0) goto L_0x0e0d;
    L_0x0d07:
        r39 = 0;
    L_0x0d09:
        r0 = r93;
        r4 = r0.libraryNames;	 Catch:{ all -> 0x0dd1 }
        r4 = r4.size();	 Catch:{ all -> 0x0dd1 }
        r0 = r39;
        if (r0 >= r4) goto L_0x0e03;
    L_0x0d15:
        r0 = r93;
        r4 = r0.libraryNames;	 Catch:{ all -> 0x0dd1 }
        r0 = r39;
        r54 = r4.get(r0);	 Catch:{ all -> 0x0dd1 }
        r54 = (java.lang.String) r54;	 Catch:{ all -> 0x0dd1 }
        r23 = 0;
        r4 = isUpdatedSystemApp(r93);	 Catch:{ all -> 0x0dd1 }
        if (r4 == 0) goto L_0x0d93;
    L_0x0d29:
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0dd1 }
        r0 = r93;
        r11 = r0.packageName;	 Catch:{ all -> 0x0dd1 }
        r83 = r4.getDisabledSystemPkgLPr(r11);	 Catch:{ all -> 0x0dd1 }
        r0 = r83;
        r4 = r0.pkg;	 Catch:{ all -> 0x0dd1 }
        if (r4 == 0) goto L_0x0d6b;
    L_0x0d3b:
        r0 = r83;
        r4 = r0.pkg;	 Catch:{ all -> 0x0dd1 }
        r4 = r4.libraryNames;	 Catch:{ all -> 0x0dd1 }
        if (r4 == 0) goto L_0x0d6b;
    L_0x0d43:
        r48 = 0;
    L_0x0d45:
        r0 = r83;
        r4 = r0.pkg;	 Catch:{ all -> 0x0dd1 }
        r4 = r4.libraryNames;	 Catch:{ all -> 0x0dd1 }
        r4 = r4.size();	 Catch:{ all -> 0x0dd1 }
        r0 = r48;
        if (r0 >= r4) goto L_0x0d6b;
    L_0x0d53:
        r0 = r83;
        r4 = r0.pkg;	 Catch:{ all -> 0x0dd1 }
        r4 = r4.libraryNames;	 Catch:{ all -> 0x0dd1 }
        r0 = r48;
        r4 = r4.get(r0);	 Catch:{ all -> 0x0dd1 }
        r0 = r54;
        r4 = r0.equals(r4);	 Catch:{ all -> 0x0dd1 }
        if (r4 == 0) goto L_0x0d90;
    L_0x0d67:
        r23 = 1;
        r23 = 1;
    L_0x0d6b:
        if (r23 == 0) goto L_0x0dd4;
    L_0x0d6d:
        r0 = r92;
        r4 = r0.mSharedLibraries;	 Catch:{ all -> 0x0dd1 }
        r0 = r54;
        r4 = r4.containsKey(r0);	 Catch:{ all -> 0x0dd1 }
        if (r4 != 0) goto L_0x0d96;
    L_0x0d79:
        r0 = r92;
        r4 = r0.mSharedLibraries;	 Catch:{ all -> 0x0dd1 }
        r11 = new com.android.server.pm.PackageManagerService$SharedLibraryEntry;	 Catch:{ all -> 0x0dd1 }
        r13 = 0;
        r0 = r93;
        r15 = r0.packageName;	 Catch:{ all -> 0x0dd1 }
        r11.<init>(r13, r15);	 Catch:{ all -> 0x0dd1 }
        r0 = r54;
        r4.put(r0, r11);	 Catch:{ all -> 0x0dd1 }
    L_0x0d8c:
        r39 = r39 + 1;
        goto L_0x0d09;
    L_0x0d90:
        r48 = r48 + 1;
        goto L_0x0d45;
    L_0x0d93:
        r23 = 1;
        goto L_0x0d6b;
    L_0x0d96:
        r0 = r93;
        r4 = r0.packageName;	 Catch:{ all -> 0x0dd1 }
        r0 = r54;
        r4 = r0.equals(r4);	 Catch:{ all -> 0x0dd1 }
        if (r4 != 0) goto L_0x0d8c;
    L_0x0da2:
        r4 = "PackageManager";
        r11 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0dd1 }
        r11.<init>();	 Catch:{ all -> 0x0dd1 }
        r13 = "Package ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0dd1 }
        r0 = r93;
        r13 = r0.packageName;	 Catch:{ all -> 0x0dd1 }
        r11 = r11.append(r13);	 Catch:{ all -> 0x0dd1 }
        r13 = " library ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0dd1 }
        r0 = r54;
        r11 = r11.append(r0);	 Catch:{ all -> 0x0dd1 }
        r13 = " already exists; skipping";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0dd1 }
        r11 = r11.toString();	 Catch:{ all -> 0x0dd1 }
        android.util.Slog.w(r4, r11);	 Catch:{ all -> 0x0dd1 }
        goto L_0x0d8c;
    L_0x0dd1:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0dd1 }
        throw r4;
    L_0x0dd4:
        r4 = "PackageManager";
        r11 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0dd1 }
        r11.<init>();	 Catch:{ all -> 0x0dd1 }
        r13 = "Package ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0dd1 }
        r0 = r93;
        r13 = r0.packageName;	 Catch:{ all -> 0x0dd1 }
        r11 = r11.append(r13);	 Catch:{ all -> 0x0dd1 }
        r13 = " declares lib ";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0dd1 }
        r0 = r54;
        r11 = r11.append(r0);	 Catch:{ all -> 0x0dd1 }
        r13 = " that is not declared on system image; skipping";
        r11 = r11.append(r13);	 Catch:{ all -> 0x0dd1 }
        r11 = r11.toString();	 Catch:{ all -> 0x0dd1 }
        android.util.Slog.w(r4, r11);	 Catch:{ all -> 0x0dd1 }
        goto L_0x0d8c;
    L_0x0e03:
        r0 = r95;
        r4 = r0 & 256;
        if (r4 != 0) goto L_0x0e0d;
    L_0x0e09:
        r26 = r92.updateAllSharedLibrariesLPw(r93);	 Catch:{ all -> 0x0dd1 }
    L_0x0e0d:
        monitor-exit(r5);	 Catch:{ all -> 0x0dd1 }
        if (r26 == 0) goto L_0x0e4a;
    L_0x0e10:
        r4 = r95 & 2;
        if (r4 != 0) goto L_0x0e4a;
    L_0x0e14:
        r39 = 0;
    L_0x0e16:
        r4 = r26.size();
        r0 = r39;
        if (r0 >= r4) goto L_0x0e4a;
    L_0x0e1e:
        r0 = r26;
        r1 = r39;
        r12 = r0.get(r1);
        r12 = (android.content.pm.PackageParser.Package) r12;
        r13 = 0;
        r0 = r95;
        r4 = r0 & 128;
        if (r4 == 0) goto L_0x0e45;
    L_0x0e2f:
        r15 = 1;
    L_0x0e30:
        r16 = 0;
        r11 = r92;
        r4 = r11.performDexOptLI(r12, r13, r14, r15, r16);
        r5 = -1;
        if (r4 != r5) goto L_0x0e47;
    L_0x0e3b:
        r4 = new com.android.server.pm.PackageManagerException;
        r5 = -11;
        r11 = "scanPackageLI failed to dexopt clientLibPkgs";
        r4.<init>(r5, r11);
        throw r4;
    L_0x0e45:
        r15 = 0;
        goto L_0x0e30;
    L_0x0e47:
        r39 = r39 + 1;
        goto L_0x0e16;
    L_0x0e4a:
        r0 = r95;
        r4 = r0 & 2048;
        if (r4 == 0) goto L_0x0e63;
    L_0x0e50:
        r0 = r93;
        r4 = r0.applicationInfo;
        r4 = r4.packageName;
        r0 = r93;
        r5 = r0.applicationInfo;
        r5 = r5.uid;
        r11 = "update pkg";
        r0 = r92;
        r0.killApplication(r4, r5, r11);
    L_0x0e63:
        if (r26 == 0) goto L_0x0e8b;
    L_0x0e65:
        r39 = 0;
    L_0x0e67:
        r4 = r26.size();
        r0 = r39;
        if (r0 >= r4) goto L_0x0e8b;
    L_0x0e6f:
        r0 = r26;
        r1 = r39;
        r12 = r0.get(r1);
        r12 = (android.content.pm.PackageParser.Package) r12;
        r4 = r12.applicationInfo;
        r4 = r4.packageName;
        r5 = r12.applicationInfo;
        r5 = r5.uid;
        r11 = "update lib";
        r0 = r92;
        r0.killApplication(r4, r5, r11);
        r39 = r39 + 1;
        goto L_0x0e67;
    L_0x0e8b:
        r0 = r92;
        r11 = r0.mPackages;
        monitor-enter(r11);
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0ed0 }
        r0 = r70;
        r1 = r93;
        r4.insertPackageSettingLPw(r0, r1);	 Catch:{ all -> 0x0ed0 }
        r0 = r92;
        r4 = r0.mPackages;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.packageName;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r4.put(r5, r0);	 Catch:{ all -> 0x0ed0 }
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.mPackagesToBeCleaned;	 Catch:{ all -> 0x0ed0 }
        r47 = r4.iterator();	 Catch:{ all -> 0x0ed0 }
    L_0x0eb4:
        r4 = r47.hasNext();	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x0ed3;
    L_0x0eba:
        r46 = r47.next();	 Catch:{ all -> 0x0ed0 }
        r46 = (android.content.pm.PackageCleanItem) r46;	 Catch:{ all -> 0x0ed0 }
        r0 = r46;
        r4 = r0.packageName;	 Catch:{ all -> 0x0ed0 }
        r0 = r69;
        r4 = r0.equals(r4);	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x0eb4;
    L_0x0ecc:
        r47.remove();	 Catch:{ all -> 0x0ed0 }
        goto L_0x0eb4;
    L_0x0ed0:
        r4 = move-exception;
        monitor-exit(r11);	 Catch:{ all -> 0x0ed0 }
        throw r4;
    L_0x0ed3:
        r4 = 0;
        r4 = (r96 > r4 ? 1 : (r96 == r4 ? 0 : -1));
        if (r4 == 0) goto L_0x1026;
    L_0x0ed9:
        r0 = r70;
        r4 = r0.firstInstallTime;	 Catch:{ all -> 0x0ed0 }
        r90 = 0;
        r4 = (r4 > r90 ? 1 : (r4 == r90 ? 0 : -1));
        if (r4 != 0) goto L_0x101a;
    L_0x0ee3:
        r0 = r96;
        r2 = r70;
        r2.lastUpdateTime = r0;	 Catch:{ all -> 0x0ed0 }
        r0 = r96;
        r2 = r70;
        r2.firstInstallTime = r0;	 Catch:{ all -> 0x0ed0 }
    L_0x0eef:
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0ed0 }
        r0 = r4.mKeySetManagerService;	 Catch:{ all -> 0x0ed0 }
        r50 = r0;
        r0 = r93;
        r4 = r0.packageName;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r0 = r50;
        r0.removeAppKeySetDataLPw(r4);	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r0 = r93;
        r4 = r0.packageName;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r0 = r93;
        r5 = r0.mSigningKeys;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r0 = r50;
        r0.addSigningKeySetToPackageLPw(r4, r5);	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r0 = r93;
        r4 = r0.mKeySetMapping;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        if (r4 == 0) goto L_0x0f66;
    L_0x0f13:
        r0 = r93;
        r4 = r0.mKeySetMapping;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r4 = r4.entrySet();	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r40 = r4.iterator();	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
    L_0x0f1f:
        r4 = r40.hasNext();	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        if (r4 == 0) goto L_0x1052;
    L_0x0f25:
        r37 = r40.next();	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r37 = (java.util.Map.Entry) r37;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r4 = r37.getValue();	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        if (r4 == 0) goto L_0x0f1f;
    L_0x0f31:
        r0 = r93;
        r13 = r0.packageName;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r4 = r37.getValue();	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r4 = (android.util.ArraySet) r4;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r5 = r37.getKey();	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r5 = (java.lang.String) r5;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r0 = r50;
        r0.addDefinedKeySetToPackageLPw(r13, r4, r5);	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        goto L_0x0f1f;
    L_0x0f47:
        r36 = move-exception;
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r5.<init>();	 Catch:{ all -> 0x0ed0 }
        r13 = "Could not add KeySet to ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r13 = r0.packageName;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r5 = r5.toString();	 Catch:{ all -> 0x0ed0 }
        r0 = r36;
        android.util.Slog.e(r4, r5, r0);	 Catch:{ all -> 0x0ed0 }
    L_0x0f66:
        r0 = r93;
        r4 = r0.providers;	 Catch:{ all -> 0x0ed0 }
        r17 = r4.size();	 Catch:{ all -> 0x0ed0 }
        r74 = 0;
        r39 = 0;
    L_0x0f72:
        r0 = r39;
        r1 = r17;
        if (r0 >= r1) goto L_0x113d;
    L_0x0f78:
        r0 = r93;
        r4 = r0.providers;	 Catch:{ all -> 0x0ed0 }
        r0 = r39;
        r64 = r4.get(r0);	 Catch:{ all -> 0x0ed0 }
        r64 = (android.content.pm.PackageParser.Provider) r64;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.processName;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.processName;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r15 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r15 = r15.uid;	 Catch:{ all -> 0x0ed0 }
        r5 = fixProcessName(r5, r13, r15);	 Catch:{ all -> 0x0ed0 }
        r4.processName = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r92;
        r4 = r0.mProviders;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4.addProvider(r0);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.isSyncable;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r0.syncable = r4;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.authority;	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x1117;
    L_0x0fbb:
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.authority;	 Catch:{ all -> 0x0ed0 }
        r5 = ";";
        r55 = r4.split(r5);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = 0;
        r4.authority = r5;	 Catch:{ all -> 0x0ed0 }
        r48 = 0;
        r65 = r64;
    L_0x0fd2:
        r0 = r55;
        r4 = r0.length;	 Catch:{ all -> 0x0ed0 }
        r0 = r48;
        if (r0 >= r4) goto L_0x1115;
    L_0x0fd9:
        r4 = 1;
        r0 = r48;
        if (r0 != r4) goto L_0x176c;
    L_0x0fde:
        r0 = r65;
        r4 = r0.syncable;	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x176c;
    L_0x0fe4:
        r64 = new android.content.pm.PackageParser$Provider;	 Catch:{ all -> 0x0ed0 }
        r64.<init>(r65);	 Catch:{ all -> 0x0ed0 }
        r4 = 0;
        r0 = r64;
        r0.syncable = r4;	 Catch:{ all -> 0x0ed0 }
    L_0x0fee:
        r0 = r92;
        r4 = r0.mProvidersByAuthority;	 Catch:{ all -> 0x0ed0 }
        r5 = r55[r48];	 Catch:{ all -> 0x0ed0 }
        r4 = r4.containsKey(r5);	 Catch:{ all -> 0x0ed0 }
        if (r4 != 0) goto L_0x10c0;
    L_0x0ffa:
        r0 = r92;
        r4 = r0.mProvidersByAuthority;	 Catch:{ all -> 0x0ed0 }
        r5 = r55[r48];	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4.put(r5, r0);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.authority;	 Catch:{ all -> 0x0ed0 }
        if (r4 != 0) goto L_0x1099;
    L_0x100d:
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = r55[r48];	 Catch:{ all -> 0x0ed0 }
        r4.authority = r5;	 Catch:{ all -> 0x0ed0 }
    L_0x1015:
        r48 = r48 + 1;
        r65 = r64;
        goto L_0x0fd2;
    L_0x101a:
        r4 = r95 & 64;
        if (r4 == 0) goto L_0x0eef;
    L_0x101e:
        r0 = r96;
        r2 = r70;
        r2.lastUpdateTime = r0;	 Catch:{ all -> 0x0ed0 }
        goto L_0x0eef;
    L_0x1026:
        r0 = r70;
        r4 = r0.firstInstallTime;	 Catch:{ all -> 0x0ed0 }
        r90 = 0;
        r4 = (r4 > r90 ? 1 : (r4 == r90 ? 0 : -1));
        if (r4 != 0) goto L_0x103e;
    L_0x1030:
        r0 = r80;
        r2 = r70;
        r2.lastUpdateTime = r0;	 Catch:{ all -> 0x0ed0 }
        r0 = r80;
        r2 = r70;
        r2.firstInstallTime = r0;	 Catch:{ all -> 0x0ed0 }
        goto L_0x0eef;
    L_0x103e:
        r4 = r94 & 64;
        if (r4 == 0) goto L_0x0eef;
    L_0x1042:
        r0 = r70;
        r4 = r0.timeStamp;	 Catch:{ all -> 0x0ed0 }
        r4 = (r80 > r4 ? 1 : (r80 == r4 ? 0 : -1));
        if (r4 == 0) goto L_0x0eef;
    L_0x104a:
        r0 = r80;
        r2 = r70;
        r2.lastUpdateTime = r0;	 Catch:{ all -> 0x0ed0 }
        goto L_0x0eef;
    L_0x1052:
        r0 = r93;
        r4 = r0.mUpgradeKeySets;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        if (r4 == 0) goto L_0x0f66;
    L_0x1058:
        r0 = r93;
        r4 = r0.mUpgradeKeySets;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r40 = r4.iterator();	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
    L_0x1060:
        r4 = r40.hasNext();	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        if (r4 == 0) goto L_0x0f66;
    L_0x1066:
        r86 = r40.next();	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r86 = (java.lang.String) r86;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r0 = r93;
        r4 = r0.packageName;	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        r0 = r50;
        r1 = r86;
        r0.addUpgradeKeySetToPackageLPw(r4, r1);	 Catch:{ NullPointerException -> 0x0f47, IllegalArgumentException -> 0x1078 }
        goto L_0x1060;
    L_0x1078:
        r36 = move-exception;
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r5.<init>();	 Catch:{ all -> 0x0ed0 }
        r13 = "Could not add KeySet to malformed package";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r13 = r0.packageName;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r5 = r5.toString();	 Catch:{ all -> 0x0ed0 }
        r0 = r36;
        android.util.Slog.e(r4, r5, r0);	 Catch:{ all -> 0x0ed0 }
        goto L_0x0f66;
    L_0x1099:
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r5.<init>();	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.authority;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = ";";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = r55[r48];	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r5 = r5.toString();	 Catch:{ all -> 0x0ed0 }
        r4.authority = r5;	 Catch:{ all -> 0x0ed0 }
        goto L_0x1015;
    L_0x10c0:
        r0 = r92;
        r4 = r0.mProvidersByAuthority;	 Catch:{ all -> 0x0ed0 }
        r5 = r55[r48];	 Catch:{ all -> 0x0ed0 }
        r62 = r4.get(r5);	 Catch:{ all -> 0x0ed0 }
        r62 = (android.content.pm.PackageParser.Provider) r62;	 Catch:{ all -> 0x0ed0 }
        r5 = "PackageManager";
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4.<init>();	 Catch:{ all -> 0x0ed0 }
        r13 = "Skipping provider name ";
        r4 = r4.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = r55[r48];	 Catch:{ all -> 0x0ed0 }
        r4 = r4.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = " (in package ";
        r4 = r4.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r13 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.packageName;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = "): name already used by ";
        r13 = r4.append(r13);	 Catch:{ all -> 0x0ed0 }
        if (r62 == 0) goto L_0x1112;
    L_0x10f7:
        r4 = r62.getComponentName();	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x1112;
    L_0x10fd:
        r4 = r62.getComponentName();	 Catch:{ all -> 0x0ed0 }
        r4 = r4.getPackageName();	 Catch:{ all -> 0x0ed0 }
    L_0x1105:
        r4 = r13.append(r4);	 Catch:{ all -> 0x0ed0 }
        r4 = r4.toString();	 Catch:{ all -> 0x0ed0 }
        android.util.Slog.w(r5, r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x1015;
    L_0x1112:
        r4 = "?";
        goto L_0x1105;
    L_0x1115:
        r64 = r65;
    L_0x1117:
        r4 = r94 & 2;
        if (r4 == 0) goto L_0x1131;
    L_0x111b:
        if (r74 != 0) goto L_0x1135;
    L_0x111d:
        r74 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r0 = r74;
        r0.<init>(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x1126:
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x1131:
        r39 = r39 + 1;
        goto L_0x0f72;
    L_0x1135:
        r4 = 32;
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x1126;
    L_0x113d:
        if (r74 == 0) goto L_0x113f;
    L_0x113f:
        r0 = r93;
        r4 = r0.services;	 Catch:{ all -> 0x0ed0 }
        r17 = r4.size();	 Catch:{ all -> 0x0ed0 }
        r74 = 0;
        r39 = 0;
    L_0x114b:
        r0 = r39;
        r1 = r17;
        if (r0 >= r1) goto L_0x11a7;
    L_0x1151:
        r0 = r93;
        r4 = r0.services;	 Catch:{ all -> 0x0ed0 }
        r0 = r39;
        r78 = r4.get(r0);	 Catch:{ all -> 0x0ed0 }
        r78 = (android.content.pm.PackageParser.Service) r78;	 Catch:{ all -> 0x0ed0 }
        r0 = r78;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.processName;	 Catch:{ all -> 0x0ed0 }
        r0 = r78;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.processName;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r15 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r15 = r15.uid;	 Catch:{ all -> 0x0ed0 }
        r5 = fixProcessName(r5, r13, r15);	 Catch:{ all -> 0x0ed0 }
        r4.processName = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r92;
        r4 = r0.mServices;	 Catch:{ all -> 0x0ed0 }
        r0 = r78;
        r4.addService(r0);	 Catch:{ all -> 0x0ed0 }
        r4 = r94 & 2;
        if (r4 == 0) goto L_0x119c;
    L_0x1186:
        if (r74 != 0) goto L_0x119f;
    L_0x1188:
        r74 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r0 = r74;
        r0.<init>(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x1191:
        r0 = r78;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x119c:
        r39 = r39 + 1;
        goto L_0x114b;
    L_0x119f:
        r4 = 32;
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x1191;
    L_0x11a7:
        if (r74 == 0) goto L_0x11a9;
    L_0x11a9:
        r0 = r93;
        r4 = r0.receivers;	 Catch:{ all -> 0x0ed0 }
        r17 = r4.size();	 Catch:{ all -> 0x0ed0 }
        r74 = 0;
        r39 = 0;
    L_0x11b5:
        r0 = r39;
        r1 = r17;
        if (r0 >= r1) goto L_0x1213;
    L_0x11bb:
        r0 = r93;
        r4 = r0.receivers;	 Catch:{ all -> 0x0ed0 }
        r0 = r39;
        r18 = r4.get(r0);	 Catch:{ all -> 0x0ed0 }
        r18 = (android.content.pm.PackageParser.Activity) r18;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.processName;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.processName;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r15 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r15 = r15.uid;	 Catch:{ all -> 0x0ed0 }
        r5 = fixProcessName(r5, r13, r15);	 Catch:{ all -> 0x0ed0 }
        r4.processName = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r92;
        r4 = r0.mReceivers;	 Catch:{ all -> 0x0ed0 }
        r5 = "receiver";
        r0 = r18;
        r4.addActivity(r0, r5);	 Catch:{ all -> 0x0ed0 }
        r4 = r94 & 2;
        if (r4 == 0) goto L_0x1208;
    L_0x11f2:
        if (r74 != 0) goto L_0x120b;
    L_0x11f4:
        r74 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r0 = r74;
        r0.<init>(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x11fd:
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x1208:
        r39 = r39 + 1;
        goto L_0x11b5;
    L_0x120b:
        r4 = 32;
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x11fd;
    L_0x1213:
        if (r74 == 0) goto L_0x1215;
    L_0x1215:
        r0 = r93;
        r4 = r0.activities;	 Catch:{ all -> 0x0ed0 }
        r17 = r4.size();	 Catch:{ all -> 0x0ed0 }
        r74 = 0;
        r39 = 0;
    L_0x1221:
        r0 = r39;
        r1 = r17;
        if (r0 >= r1) goto L_0x127f;
    L_0x1227:
        r0 = r93;
        r4 = r0.activities;	 Catch:{ all -> 0x0ed0 }
        r0 = r39;
        r18 = r4.get(r0);	 Catch:{ all -> 0x0ed0 }
        r18 = (android.content.pm.PackageParser.Activity) r18;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.processName;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.processName;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r15 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r15 = r15.uid;	 Catch:{ all -> 0x0ed0 }
        r5 = fixProcessName(r5, r13, r15);	 Catch:{ all -> 0x0ed0 }
        r4.processName = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r92;
        r4 = r0.mActivities;	 Catch:{ all -> 0x0ed0 }
        r5 = "activity";
        r0 = r18;
        r4.addActivity(r0, r5);	 Catch:{ all -> 0x0ed0 }
        r4 = r94 & 2;
        if (r4 == 0) goto L_0x1274;
    L_0x125e:
        if (r74 != 0) goto L_0x1277;
    L_0x1260:
        r74 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r0 = r74;
        r0.<init>(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x1269:
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x1274:
        r39 = r39 + 1;
        goto L_0x1221;
    L_0x1277:
        r4 = 32;
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x1269;
    L_0x127f:
        if (r74 == 0) goto L_0x1281;
    L_0x1281:
        r0 = r93;
        r4 = r0.permissionGroups;	 Catch:{ all -> 0x0ed0 }
        r17 = r4.size();	 Catch:{ all -> 0x0ed0 }
        r74 = 0;
        r39 = 0;
    L_0x128d:
        r0 = r39;
        r1 = r17;
        if (r0 >= r1) goto L_0x134d;
    L_0x1293:
        r0 = r93;
        r4 = r0.permissionGroups;	 Catch:{ all -> 0x0ed0 }
        r0 = r39;
        r68 = r4.get(r0);	 Catch:{ all -> 0x0ed0 }
        r68 = (android.content.pm.PackageParser.PermissionGroup) r68;	 Catch:{ all -> 0x0ed0 }
        r0 = r92;
        r4 = r0.mPermissionGroups;	 Catch:{ all -> 0x0ed0 }
        r0 = r68;
        r5 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.name;	 Catch:{ all -> 0x0ed0 }
        r30 = r4.get(r5);	 Catch:{ all -> 0x0ed0 }
        r30 = (android.content.pm.PackageParser.PermissionGroup) r30;	 Catch:{ all -> 0x0ed0 }
        if (r30 != 0) goto L_0x12e5;
    L_0x12b1:
        r0 = r92;
        r4 = r0.mPermissionGroups;	 Catch:{ all -> 0x0ed0 }
        r0 = r68;
        r5 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r68;
        r4.put(r5, r0);	 Catch:{ all -> 0x0ed0 }
        r4 = r94 & 2;
        if (r4 == 0) goto L_0x12da;
    L_0x12c4:
        if (r74 != 0) goto L_0x12dd;
    L_0x12c6:
        r74 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r0 = r74;
        r0.<init>(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x12cf:
        r0 = r68;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x12da:
        r39 = r39 + 1;
        goto L_0x128d;
    L_0x12dd:
        r4 = 32;
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x12cf;
    L_0x12e5:
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r5.<init>();	 Catch:{ all -> 0x0ed0 }
        r13 = "Permission group ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r68;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.name;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = " from package ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r68;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.packageName;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = " ignored: original from ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r30;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.packageName;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r5 = r5.toString();	 Catch:{ all -> 0x0ed0 }
        android.util.Slog.w(r4, r5);	 Catch:{ all -> 0x0ed0 }
        r4 = r94 & 2;
        if (r4 == 0) goto L_0x12da;
    L_0x1327:
        if (r74 != 0) goto L_0x1345;
    L_0x1329:
        r74 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r0 = r74;
        r0.<init>(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x1332:
        r4 = "DUP:";
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        r0 = r68;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x12da;
    L_0x1345:
        r4 = 32;
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x1332;
    L_0x134d:
        if (r74 == 0) goto L_0x134f;
    L_0x134f:
        r0 = r93;
        r4 = r0.permissions;	 Catch:{ all -> 0x0ed0 }
        r17 = r4.size();	 Catch:{ all -> 0x0ed0 }
        r74 = 0;
        r39 = 0;
    L_0x135b:
        r0 = r39;
        r1 = r17;
        if (r0 >= r1) goto L_0x15ff;
    L_0x1361:
        r0 = r93;
        r4 = r0.permissions;	 Catch:{ all -> 0x0ed0 }
        r0 = r39;
        r64 = r4.get(r0);	 Catch:{ all -> 0x0ed0 }
        r64 = (android.content.pm.PackageParser.Permission) r64;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.tree;	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x14b5;
    L_0x1373:
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0ed0 }
        r0 = r4.mPermissionTrees;	 Catch:{ all -> 0x0ed0 }
        r67 = r0;
    L_0x137b:
        r0 = r92;
        r4 = r0.mPermissionGroups;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r5 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.group;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.get(r5);	 Catch:{ all -> 0x0ed0 }
        r4 = (android.content.pm.PackageParser.PermissionGroup) r4;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r0.group = r4;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.group;	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x139d;
    L_0x1397:
        r0 = r64;
        r4 = r0.group;	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x15c1;
    L_0x139d:
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r67;
        r25 = r0.get(r4);	 Catch:{ all -> 0x0ed0 }
        r25 = (com.android.server.pm.BasePermission) r25;	 Catch:{ all -> 0x0ed0 }
        if (r25 == 0) goto L_0x1408;
    L_0x13ad:
        r0 = r25;
        r4 = r0.sourcePackage;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r5 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.packageName;	 Catch:{ all -> 0x0ed0 }
        r4 = java.util.Objects.equals(r4, r5);	 Catch:{ all -> 0x0ed0 }
        if (r4 != 0) goto L_0x1408;
    L_0x13bd:
        r0 = r25;
        r4 = r0.perm;	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x14bf;
    L_0x13c3:
        r0 = r25;
        r4 = r0.perm;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.owner;	 Catch:{ all -> 0x0ed0 }
        r4 = isSystemApp(r4);	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x14bf;
    L_0x13cf:
        r31 = 1;
    L_0x13d1:
        r0 = r64;
        r4 = r0.owner;	 Catch:{ all -> 0x0ed0 }
        r4 = isSystemApp(r4);	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x1408;
    L_0x13db:
        r0 = r25;
        r4 = r0.type;	 Catch:{ all -> 0x0ed0 }
        r5 = 1;
        if (r4 != r5) goto L_0x14c3;
    L_0x13e2:
        r0 = r25;
        r4 = r0.perm;	 Catch:{ all -> 0x0ed0 }
        if (r4 != 0) goto L_0x14c3;
    L_0x13e8:
        r0 = r70;
        r1 = r25;
        r1.packageSetting = r0;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r1 = r25;
        r1.perm = r0;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.uid;	 Catch:{ all -> 0x0ed0 }
        r0 = r25;
        r0.uid = r4;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.packageName;	 Catch:{ all -> 0x0ed0 }
        r0 = r25;
        r0.sourcePackage = r4;	 Catch:{ all -> 0x0ed0 }
    L_0x1408:
        if (r25 != 0) goto L_0x142b;
    L_0x140a:
        r25 = new com.android.server.pm.BasePermission;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r5 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.packageName;	 Catch:{ all -> 0x0ed0 }
        r13 = 0;
        r0 = r25;
        r0.<init>(r4, r5, r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r67;
        r1 = r25;
        r0.put(r4, r1);	 Catch:{ all -> 0x0ed0 }
    L_0x142b:
        r0 = r25;
        r4 = r0.perm;	 Catch:{ all -> 0x0ed0 }
        if (r4 != 0) goto L_0x1596;
    L_0x1431:
        r0 = r25;
        r4 = r0.sourcePackage;	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x1447;
    L_0x1437:
        r0 = r25;
        r4 = r0.sourcePackage;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r5 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.packageName;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.equals(r5);	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x1558;
    L_0x1447:
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r92;
        r84 = r0.findPermissionTreeLP(r4);	 Catch:{ all -> 0x0ed0 }
        if (r84 == 0) goto L_0x1465;
    L_0x1455:
        r0 = r84;
        r4 = r0.sourcePackage;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r5 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.packageName;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.equals(r5);	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x150c;
    L_0x1465:
        r0 = r70;
        r1 = r25;
        r1.packageSetting = r0;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r1 = r25;
        r1.perm = r0;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r4 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.uid;	 Catch:{ all -> 0x0ed0 }
        r0 = r25;
        r0.uid = r4;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.packageName;	 Catch:{ all -> 0x0ed0 }
        r0 = r25;
        r0.sourcePackage = r4;	 Catch:{ all -> 0x0ed0 }
        r4 = r94 & 2;
        if (r4 == 0) goto L_0x149f;
    L_0x1489:
        if (r74 != 0) goto L_0x1504;
    L_0x148b:
        r74 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r0 = r74;
        r0.<init>(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x1494:
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x149f:
        r0 = r25;
        r4 = r0.perm;	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        if (r4 != r0) goto L_0x14b1;
    L_0x14a7:
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.protectionLevel;	 Catch:{ all -> 0x0ed0 }
        r0 = r25;
        r0.protectionLevel = r4;	 Catch:{ all -> 0x0ed0 }
    L_0x14b1:
        r39 = r39 + 1;
        goto L_0x135b;
    L_0x14b5:
        r0 = r92;
        r4 = r0.mSettings;	 Catch:{ all -> 0x0ed0 }
        r0 = r4.mPermissions;	 Catch:{ all -> 0x0ed0 }
        r67 = r0;
        goto L_0x137b;
    L_0x14bf:
        r31 = 0;
        goto L_0x13d1;
    L_0x14c3:
        if (r31 != 0) goto L_0x1408;
    L_0x14c5:
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4.<init>();	 Catch:{ all -> 0x0ed0 }
        r5 = "New decl ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r5 = r0.owner;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.append(r5);	 Catch:{ all -> 0x0ed0 }
        r5 = " of permission  ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r5 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.name;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.append(r5);	 Catch:{ all -> 0x0ed0 }
        r5 = " is system; overriding ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0ed0 }
        r0 = r25;
        r5 = r0.sourcePackage;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.append(r5);	 Catch:{ all -> 0x0ed0 }
        r53 = r4.toString();	 Catch:{ all -> 0x0ed0 }
        r4 = 5;
        r0 = r53;
        reportSettingsProblem(r4, r0);	 Catch:{ all -> 0x0ed0 }
        r25 = 0;
        goto L_0x1408;
    L_0x1504:
        r4 = 32;
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x1494;
    L_0x150c:
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r5.<init>();	 Catch:{ all -> 0x0ed0 }
        r13 = "Permission ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.name;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = " from package ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.packageName;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = " ignored: base tree ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r84;
        r13 = r0.name;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = " is from package ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r84;
        r13 = r0.sourcePackage;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r5 = r5.toString();	 Catch:{ all -> 0x0ed0 }
        android.util.Slog.w(r4, r5);	 Catch:{ all -> 0x0ed0 }
        goto L_0x149f;
    L_0x1558:
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r5.<init>();	 Catch:{ all -> 0x0ed0 }
        r13 = "Permission ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.name;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = " from package ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.packageName;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = " ignored: original from ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r25;
        r13 = r0.sourcePackage;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r5 = r5.toString();	 Catch:{ all -> 0x0ed0 }
        android.util.Slog.w(r4, r5);	 Catch:{ all -> 0x0ed0 }
        goto L_0x149f;
    L_0x1596:
        r4 = r94 & 2;
        if (r4 == 0) goto L_0x149f;
    L_0x159a:
        if (r74 != 0) goto L_0x15b9;
    L_0x159c:
        r74 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r0 = r74;
        r0.<init>(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x15a5:
        r4 = "DUP:";
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x149f;
    L_0x15b9:
        r4 = 32;
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x15a5;
    L_0x15c1:
        r4 = "PackageManager";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r5.<init>();	 Catch:{ all -> 0x0ed0 }
        r13 = "Permission ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.name;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = " from package ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r13 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r13 = r13.packageName;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r13 = " ignored: no group ";
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r0 = r64;
        r13 = r0.group;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.append(r13);	 Catch:{ all -> 0x0ed0 }
        r5 = r5.toString();	 Catch:{ all -> 0x0ed0 }
        android.util.Slog.w(r4, r5);	 Catch:{ all -> 0x0ed0 }
        goto L_0x14b1;
    L_0x15ff:
        if (r74 == 0) goto L_0x1601;
    L_0x1601:
        r0 = r93;
        r4 = r0.instrumentation;	 Catch:{ all -> 0x0ed0 }
        r17 = r4.size();	 Catch:{ all -> 0x0ed0 }
        r74 = 0;
        r39 = 0;
    L_0x160d:
        r0 = r39;
        r1 = r17;
        if (r0 >= r1) goto L_0x16a6;
    L_0x1613:
        r0 = r93;
        r4 = r0.instrumentation;	 Catch:{ all -> 0x0ed0 }
        r0 = r39;
        r18 = r4.get(r0);	 Catch:{ all -> 0x0ed0 }
        r18 = (android.content.pm.PackageParser.Instrumentation) r18;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.packageName;	 Catch:{ all -> 0x0ed0 }
        r4.packageName = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.sourceDir;	 Catch:{ all -> 0x0ed0 }
        r4.sourceDir = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.publicSourceDir;	 Catch:{ all -> 0x0ed0 }
        r4.publicSourceDir = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.splitSourceDirs;	 Catch:{ all -> 0x0ed0 }
        r4.splitSourceDirs = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.splitPublicSourceDirs;	 Catch:{ all -> 0x0ed0 }
        r4.splitPublicSourceDirs = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.dataDir;	 Catch:{ all -> 0x0ed0 }
        r4.dataDir = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.applicationInfo;	 Catch:{ all -> 0x0ed0 }
        r5 = r5.nativeLibraryDir;	 Catch:{ all -> 0x0ed0 }
        r4.nativeLibraryDir = r5;	 Catch:{ all -> 0x0ed0 }
        r0 = r92;
        r4 = r0.mInstrumentation;	 Catch:{ all -> 0x0ed0 }
        r5 = r18.getComponentName();	 Catch:{ all -> 0x0ed0 }
        r0 = r18;
        r4.put(r5, r0);	 Catch:{ all -> 0x0ed0 }
        r4 = r94 & 2;
        if (r4 == 0) goto L_0x169a;
    L_0x1684:
        if (r74 != 0) goto L_0x169e;
    L_0x1686:
        r74 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0ed0 }
        r4 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r0 = r74;
        r0.<init>(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x168f:
        r0 = r18;
        r4 = r0.info;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.name;	 Catch:{ all -> 0x0ed0 }
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
    L_0x169a:
        r39 = r39 + 1;
        goto L_0x160d;
    L_0x169e:
        r4 = 32;
        r0 = r74;
        r0.append(r4);	 Catch:{ all -> 0x0ed0 }
        goto L_0x168f;
    L_0x16a6:
        if (r74 == 0) goto L_0x16a8;
    L_0x16a8:
        r0 = r93;
        r4 = r0.protectedBroadcasts;	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x16d2;
    L_0x16ae:
        r0 = r93;
        r4 = r0.protectedBroadcasts;	 Catch:{ all -> 0x0ed0 }
        r17 = r4.size();	 Catch:{ all -> 0x0ed0 }
        r39 = 0;
    L_0x16b8:
        r0 = r39;
        r1 = r17;
        if (r0 >= r1) goto L_0x16d2;
    L_0x16be:
        r0 = r92;
        r4 = r0.mProtectedBroadcasts;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.protectedBroadcasts;	 Catch:{ all -> 0x0ed0 }
        r0 = r39;
        r5 = r5.get(r0);	 Catch:{ all -> 0x0ed0 }
        r4.add(r5);	 Catch:{ all -> 0x0ed0 }
        r39 = r39 + 1;
        goto L_0x16b8;
    L_0x16d2:
        r0 = r70;
        r1 = r80;
        r0.setTimeStamp(r1);	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r4 = r0.mOverlayTarget;	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x174d;
    L_0x16df:
        r0 = r93;
        r4 = r0.mOverlayTarget;	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x176a;
    L_0x16e5:
        r0 = r93;
        r4 = r0.mOverlayTarget;	 Catch:{ all -> 0x0ed0 }
        r5 = "android";
        r4 = r4.equals(r5);	 Catch:{ all -> 0x0ed0 }
        if (r4 != 0) goto L_0x176a;
    L_0x16f1:
        r0 = r92;
        r4 = r0.mOverlays;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.mOverlayTarget;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.containsKey(r5);	 Catch:{ all -> 0x0ed0 }
        if (r4 != 0) goto L_0x170f;
    L_0x16ff:
        r0 = r92;
        r4 = r0.mOverlays;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.mOverlayTarget;	 Catch:{ all -> 0x0ed0 }
        r13 = new android.util.ArrayMap;	 Catch:{ all -> 0x0ed0 }
        r13.<init>();	 Catch:{ all -> 0x0ed0 }
        r4.put(r5, r13);	 Catch:{ all -> 0x0ed0 }
    L_0x170f:
        r0 = r92;
        r4 = r0.mOverlays;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.mOverlayTarget;	 Catch:{ all -> 0x0ed0 }
        r52 = r4.get(r5);	 Catch:{ all -> 0x0ed0 }
        r52 = (android.util.ArrayMap) r52;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r4 = r0.packageName;	 Catch:{ all -> 0x0ed0 }
        r0 = r52;
        r1 = r93;
        r0.put(r4, r1);	 Catch:{ all -> 0x0ed0 }
        r0 = r92;
        r4 = r0.mPackages;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.mOverlayTarget;	 Catch:{ all -> 0x0ed0 }
        r60 = r4.get(r5);	 Catch:{ all -> 0x0ed0 }
        r60 = (android.content.pm.PackageParser.Package) r60;	 Catch:{ all -> 0x0ed0 }
        if (r60 == 0) goto L_0x176a;
    L_0x1738:
        r0 = r92;
        r1 = r60;
        r2 = r93;
        r4 = r0.createIdmapForPackagePairLI(r1, r2);	 Catch:{ all -> 0x0ed0 }
        if (r4 != 0) goto L_0x176a;
    L_0x1744:
        r4 = new com.android.server.pm.PackageManagerException;	 Catch:{ all -> 0x0ed0 }
        r5 = -7;
        r13 = "scanPackageLI failed to createIdmap";
        r4.<init>(r5, r13);	 Catch:{ all -> 0x0ed0 }
        throw r4;	 Catch:{ all -> 0x0ed0 }
    L_0x174d:
        r0 = r92;
        r4 = r0.mOverlays;	 Catch:{ all -> 0x0ed0 }
        r0 = r93;
        r5 = r0.packageName;	 Catch:{ all -> 0x0ed0 }
        r4 = r4.containsKey(r5);	 Catch:{ all -> 0x0ed0 }
        if (r4 == 0) goto L_0x176a;
    L_0x175b:
        r0 = r93;
        r4 = r0.packageName;	 Catch:{ all -> 0x0ed0 }
        r5 = "android";
        r4 = r4.equals(r5);	 Catch:{ all -> 0x0ed0 }
        if (r4 != 0) goto L_0x176a;
    L_0x1767:
        r92.createIdmapsForPackageLI(r93);	 Catch:{ all -> 0x0ed0 }
    L_0x176a:
        monitor-exit(r11);	 Catch:{ all -> 0x0ed0 }
        return r93;
    L_0x176c:
        r64 = r65;
        goto L_0x0fee;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageManagerService.scanPackageDirtyLI(android.content.pm.PackageParser$Package, int, int, long, android.os.UserHandle):android.content.pm.PackageParser$Package");
    }

    private void adjustCpuAbisForSharedUserLPw(Set<PackageSetting> packagesForUser, Package scannedPackage, boolean forceDexOpt, boolean deferDexOpt) {
        String requiredInstructionSet = null;
        if (!(scannedPackage == null || scannedPackage.applicationInfo.primaryCpuAbi == null)) {
            requiredInstructionSet = VMRuntime.getInstructionSet(scannedPackage.applicationInfo.primaryCpuAbi);
        }
        PackageSetting requirer = null;
        for (PackageSetting ps : packagesForUser) {
            if ((scannedPackage == null || !scannedPackage.packageName.equals(ps.name)) && ps.primaryCpuAbiString != null) {
                String instructionSet = VMRuntime.getInstructionSet(ps.primaryCpuAbiString);
                if (!(requiredInstructionSet == null || instructionSet.equals(requiredInstructionSet))) {
                    Object obj;
                    StringBuilder append = new StringBuilder().append("Instruction set mismatch, ");
                    if (requirer == null) {
                        obj = "[caller]";
                    } else {
                        PackageSetting packageSetting = requirer;
                    }
                    Slog.w(TAG, append.append(obj).append(" requires ").append(requiredInstructionSet).append(" whereas ").append(ps).append(" requires ").append(instructionSet).toString());
                }
                if (requiredInstructionSet == null) {
                    requiredInstructionSet = instructionSet;
                    requirer = ps;
                }
            }
        }
        if (requiredInstructionSet != null) {
            String adjustedAbi;
            if (requirer != null) {
                adjustedAbi = requirer.primaryCpuAbiString;
                if (scannedPackage != null) {
                    scannedPackage.applicationInfo.primaryCpuAbi = adjustedAbi;
                }
            } else {
                adjustedAbi = scannedPackage.applicationInfo.primaryCpuAbi;
            }
            for (PackageSetting ps2 : packagesForUser) {
                if ((scannedPackage == null || !scannedPackage.packageName.equals(ps2.name)) && ps2.primaryCpuAbiString == null) {
                    ps2.primaryCpuAbiString = adjustedAbi;
                    if (!(ps2.pkg == null || ps2.pkg.applicationInfo == null)) {
                        ps2.pkg.applicationInfo.primaryCpuAbi = adjustedAbi;
                        Slog.i(TAG, "Adjusting ABI for : " + ps2.name + " to " + adjustedAbi);
                        if (performDexOptLI(ps2.pkg, null, forceDexOpt, deferDexOpt, (boolean) DEFAULT_VERIFY_ENABLE) == DEX_OPT_FAILED) {
                            ps2.primaryCpuAbiString = null;
                            ps2.pkg.applicationInfo.primaryCpuAbi = null;
                            return;
                        }
                        this.mInstaller.rmdex(ps2.codePathString, getDexCodeInstructionSet(getPreferredInstructionSet()));
                    }
                }
            }
        }
    }

    private void setUpCustomResolverActivity(Package pkg) {
        synchronized (this.mPackages) {
            this.mResolverReplaced = DEFAULT_VERIFY_ENABLE;
            this.mResolveActivity.applicationInfo = pkg.applicationInfo;
            this.mResolveActivity.name = this.mCustomResolverComponentName.getClassName();
            this.mResolveActivity.packageName = pkg.applicationInfo.packageName;
            this.mResolveActivity.processName = pkg.applicationInfo.packageName;
            this.mResolveActivity.launchMode = DEX_OPT_SKIPPED;
            this.mResolveActivity.flags = 288;
            this.mResolveActivity.theme = DEX_OPT_SKIPPED;
            this.mResolveActivity.exported = DEFAULT_VERIFY_ENABLE;
            this.mResolveActivity.enabled = DEFAULT_VERIFY_ENABLE;
            this.mResolveInfo.activityInfo = this.mResolveActivity;
            this.mResolveInfo.priority = DEX_OPT_SKIPPED;
            this.mResolveInfo.preferredOrder = DEX_OPT_SKIPPED;
            this.mResolveInfo.match = DEX_OPT_SKIPPED;
            this.mResolveComponentName = this.mCustomResolverComponentName;
            Slog.i(TAG, "Replacing default ResolverActivity with custom activity: " + this.mResolveComponentName);
        }
    }

    private static String calculateBundledApkRoot(String codePathString) {
        File codeRoot;
        File codePath = new File(codePathString);
        if (FileUtils.contains(Environment.getRootDirectory(), codePath)) {
            codeRoot = Environment.getRootDirectory();
        } else if (FileUtils.contains(Environment.getOemDirectory(), codePath)) {
            codeRoot = Environment.getOemDirectory();
        } else if (FileUtils.contains(Environment.getVendorDirectory(), codePath)) {
            codeRoot = Environment.getVendorDirectory();
        } else {
            try {
                File f = codePath.getCanonicalFile();
                File parent = f.getParentFile();
                while (true) {
                    File tmp = parent.getParentFile();
                    if (tmp == null) {
                        break;
                    }
                    f = parent;
                    parent = tmp;
                }
                codeRoot = f;
                Slog.w(TAG, "Unrecognized code path " + codePath + " - using " + codeRoot);
            } catch (IOException e) {
                Slog.w(TAG, "Can't canonicalize code path " + codePath);
                return Environment.getRootDirectory().getPath();
            }
        }
        return codeRoot.getPath();
    }

    private void setNativeLibraryPaths(Package pkg) {
        ApplicationInfo info = pkg.applicationInfo;
        String codePath = pkg.codePath;
        File codeFile = new File(codePath);
        boolean bundledApp = (!isSystemApp(info) || isUpdatedSystemApp(info)) ? DEBUG_VERIFY : DEFAULT_VERIFY_ENABLE;
        boolean asecApp = (isForwardLocked(info) || isExternal(info)) ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
        info.nativeLibraryRootDir = null;
        info.nativeLibraryRootRequiresIsa = DEBUG_VERIFY;
        info.nativeLibraryDir = null;
        info.secondaryNativeLibraryDir = null;
        if (PackageParser.isApkFile(codeFile)) {
            if (bundledApp) {
                String apkRoot = calculateBundledApkRoot(info.sourceDir);
                boolean is64Bit = VMRuntime.is64BitInstructionSet(getPrimaryInstructionSet(info));
                String apkName = deriveCodePathName(codePath);
                String libDir = is64Bit ? "lib64" : "lib";
                File file = new File(apkRoot);
                String[] strArr = new String[UPDATE_PERMISSIONS_REPLACE_PKG];
                strArr[DEX_OPT_SKIPPED] = libDir;
                strArr[UPDATE_PERMISSIONS_ALL] = apkName;
                info.nativeLibraryRootDir = Environment.buildPath(file, strArr).getAbsolutePath();
                if (info.secondaryCpuAbi != null) {
                    String secondaryLibDir = is64Bit ? "lib" : "lib64";
                    file = new File(apkRoot);
                    strArr = new String[UPDATE_PERMISSIONS_REPLACE_PKG];
                    strArr[DEX_OPT_SKIPPED] = secondaryLibDir;
                    strArr[UPDATE_PERMISSIONS_ALL] = apkName;
                    info.secondaryNativeLibraryDir = Environment.buildPath(file, strArr).getAbsolutePath();
                }
            } else if (asecApp) {
                info.nativeLibraryRootDir = new File(codeFile.getParentFile(), "lib").getAbsolutePath();
            } else {
                info.nativeLibraryRootDir = new File(this.mAppLib32InstallDir, deriveCodePathName(codePath)).getAbsolutePath();
            }
            info.nativeLibraryRootRequiresIsa = DEBUG_VERIFY;
            info.nativeLibraryDir = info.nativeLibraryRootDir;
            return;
        }
        info.nativeLibraryRootDir = new File(codeFile, "lib").getAbsolutePath();
        info.nativeLibraryRootRequiresIsa = DEFAULT_VERIFY_ENABLE;
        info.nativeLibraryDir = new File(info.nativeLibraryRootDir, getPrimaryInstructionSet(info)).getAbsolutePath();
        if (info.secondaryCpuAbi != null) {
            info.secondaryNativeLibraryDir = new File(info.nativeLibraryRootDir, VMRuntime.getInstructionSet(info.secondaryCpuAbi)).getAbsolutePath();
        }
    }

    private void setBundledAppAbisAndRoots(Package pkg, PackageSetting pkgSetting) {
        setBundledAppAbi(pkg, calculateBundledApkRoot(pkg.applicationInfo.sourceDir), deriveCodePathName(pkg.applicationInfo.getCodePath()));
        if (pkgSetting != null) {
            pkgSetting.primaryCpuAbiString = pkg.applicationInfo.primaryCpuAbi;
            pkgSetting.secondaryCpuAbiString = pkg.applicationInfo.secondaryCpuAbi;
        }
    }

    private static void setBundledAppAbi(Package pkg, String apkRoot, String apkName) {
        boolean has64BitLibs;
        boolean has32BitLibs;
        File codeFile = new File(pkg.codePath);
        if (PackageParser.isApkFile(codeFile)) {
            has64BitLibs = new File(apkRoot, new File("lib64", apkName).getPath()).exists();
            has32BitLibs = new File(apkRoot, new File("lib", apkName).getPath()).exists();
        } else {
            File rootDir = new File(codeFile, "lib");
            if (ArrayUtils.isEmpty(Build.SUPPORTED_64_BIT_ABIS) || TextUtils.isEmpty(Build.SUPPORTED_64_BIT_ABIS[DEX_OPT_SKIPPED])) {
                has64BitLibs = DEBUG_VERIFY;
            } else {
                has64BitLibs = new File(rootDir, VMRuntime.getInstructionSet(Build.SUPPORTED_64_BIT_ABIS[DEX_OPT_SKIPPED])).exists();
            }
            if (ArrayUtils.isEmpty(Build.SUPPORTED_32_BIT_ABIS) || TextUtils.isEmpty(Build.SUPPORTED_32_BIT_ABIS[DEX_OPT_SKIPPED])) {
                has32BitLibs = DEBUG_VERIFY;
            } else {
                has32BitLibs = new File(rootDir, VMRuntime.getInstructionSet(Build.SUPPORTED_32_BIT_ABIS[DEX_OPT_SKIPPED])).exists();
            }
        }
        if (has64BitLibs && !has32BitLibs) {
            pkg.applicationInfo.primaryCpuAbi = Build.SUPPORTED_64_BIT_ABIS[DEX_OPT_SKIPPED];
            pkg.applicationInfo.secondaryCpuAbi = null;
        } else if (has32BitLibs && !has64BitLibs) {
            pkg.applicationInfo.primaryCpuAbi = Build.SUPPORTED_32_BIT_ABIS[DEX_OPT_SKIPPED];
            pkg.applicationInfo.secondaryCpuAbi = null;
        } else if (has32BitLibs && has64BitLibs) {
            if ((pkg.applicationInfo.flags & SoundTriggerHelper.STATUS_ERROR) == 0) {
                Slog.e(TAG, "Package: " + pkg + " has multiple bundled libs, but is not multiarch.");
            }
            if (VMRuntime.is64BitInstructionSet(getPreferredInstructionSet())) {
                pkg.applicationInfo.primaryCpuAbi = Build.SUPPORTED_64_BIT_ABIS[DEX_OPT_SKIPPED];
                pkg.applicationInfo.secondaryCpuAbi = Build.SUPPORTED_32_BIT_ABIS[DEX_OPT_SKIPPED];
                return;
            }
            pkg.applicationInfo.primaryCpuAbi = Build.SUPPORTED_32_BIT_ABIS[DEX_OPT_SKIPPED];
            pkg.applicationInfo.secondaryCpuAbi = Build.SUPPORTED_64_BIT_ABIS[DEX_OPT_SKIPPED];
        } else {
            pkg.applicationInfo.primaryCpuAbi = null;
            pkg.applicationInfo.secondaryCpuAbi = null;
        }
    }

    private void killApplication(String pkgName, int appId, String reason) {
        IActivityManager am = ActivityManagerNative.getDefault();
        if (am != null) {
            try {
                am.killApplicationWithAppId(pkgName, appId, reason);
            } catch (RemoteException e) {
            }
        }
    }

    void removePackageLI(PackageSetting ps, boolean chatty) {
        synchronized (this.mPackages) {
            this.mPackages.remove(ps.name);
            Package pkg = ps.pkg;
            if (pkg != null) {
                cleanPackageDataStructuresLILPw(pkg, chatty);
            }
        }
    }

    void removeInstalledPackageLI(Package pkg, boolean chatty) {
        synchronized (this.mPackages) {
            this.mPackages.remove(pkg.applicationInfo.packageName);
            cleanPackageDataStructuresLILPw(pkg, chatty);
        }
    }

    void cleanPackageDataStructuresLILPw(Package pkg, boolean chatty) {
        int i;
        StringBuilder r;
        int N = pkg.providers.size();
        for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            Provider p = (Provider) pkg.providers.get(i);
            this.mProviders.removeProvider(p);
            if (p.info.authority != null) {
                String[] names = p.info.authority.split(";");
                for (int j = DEX_OPT_SKIPPED; j < names.length; j += UPDATE_PERMISSIONS_ALL) {
                    if (this.mProvidersByAuthority.get(names[j]) == p) {
                        this.mProvidersByAuthority.remove(names[j]);
                    }
                }
            }
        }
        if (null != null) {
            N = pkg.services.size();
            r = null;
        } else {
            N = pkg.services.size();
            r = null;
        }
        for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            Service s = (Service) pkg.services.get(i);
            this.mServices.removeService(s);
            if (chatty) {
                if (r == null) {
                    r = new StringBuilder(SCAN_BOOTING);
                } else {
                    r.append(' ');
                }
                r.append(s.info.name);
            }
        }
        if (r != null) {
            N = pkg.receivers.size();
        } else {
            N = pkg.receivers.size();
        }
        for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            this.mReceivers.removeActivity((Activity) pkg.receivers.get(i), "receiver");
        }
        if (null != null) {
            N = pkg.activities.size();
        } else {
            N = pkg.activities.size();
        }
        for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            this.mActivities.removeActivity((Activity) pkg.activities.get(i), "activity");
        }
        if (null != null) {
            N = pkg.permissions.size();
        } else {
            N = pkg.permissions.size();
        }
        for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            ArraySet<String> appOpPerms;
            Permission p2 = (Permission) pkg.permissions.get(i);
            BasePermission bp = (BasePermission) this.mSettings.mPermissions.get(p2.info.name);
            if (bp == null) {
                bp = (BasePermission) this.mSettings.mPermissionTrees.get(p2.info.name);
            }
            if (bp != null && bp.perm == p2) {
                bp.perm = null;
            }
            if ((p2.info.protectionLevel & SCAN_UPDATE_TIME) != 0) {
                appOpPerms = (ArraySet) this.mAppOpPermissionPackages.get(p2.info.name);
                if (appOpPerms != null) {
                    appOpPerms.remove(pkg.packageName);
                }
            }
        }
        if (null != null) {
            N = pkg.requestedPermissions.size();
        } else {
            N = pkg.requestedPermissions.size();
        }
        for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            String perm = (String) pkg.requestedPermissions.get(i);
            bp = (BasePermission) this.mSettings.mPermissions.get(perm);
            if (!(bp == null || (bp.protectionLevel & SCAN_UPDATE_TIME) == 0)) {
                appOpPerms = (ArraySet) this.mAppOpPermissionPackages.get(perm);
                if (appOpPerms != null) {
                    appOpPerms.remove(pkg.packageName);
                    if (appOpPerms.isEmpty()) {
                        this.mAppOpPermissionPackages.remove(perm);
                    }
                }
            }
        }
        if (null != null) {
            N = pkg.instrumentation.size();
        } else {
            N = pkg.instrumentation.size();
        }
        for (i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            this.mInstrumentation.remove(((Instrumentation) pkg.instrumentation.get(i)).getComponentName());
        }
        if (null != null) {
        }
        if (!((pkg.applicationInfo.flags & UPDATE_PERMISSIONS_ALL) == 0 || pkg.libraryNames == null)) {
            for (i = DEX_OPT_SKIPPED; i < pkg.libraryNames.size(); i += UPDATE_PERMISSIONS_ALL) {
                String name = (String) pkg.libraryNames.get(i);
                SharedLibraryEntry cur = (SharedLibraryEntry) this.mSharedLibraries.get(name);
                if (!(cur == null || cur.apk == null || !cur.apk.equals(pkg.packageName))) {
                    this.mSharedLibraries.remove(name);
                }
            }
        }
        if (null == null) {
        }
    }

    private static boolean hasPermission(Package pkgInfo, String perm) {
        for (int i = pkgInfo.permissions.size() + DEX_OPT_FAILED; i >= 0; i += DEX_OPT_FAILED) {
            if (((Permission) pkgInfo.permissions.get(i)).info.name.equals(perm)) {
                return DEFAULT_VERIFY_ENABLE;
            }
        }
        return DEBUG_VERIFY;
    }

    private void updatePermissionsLPw(String changingPkg, Package pkgInfo, int flags) {
        boolean z = DEFAULT_VERIFY_ENABLE;
        Iterator<BasePermission> it = this.mSettings.mPermissionTrees.values().iterator();
        while (it.hasNext()) {
            BasePermission bp = (BasePermission) it.next();
            if (bp.packageSetting == null) {
                bp.packageSetting = (PackageSettingBase) this.mSettings.mPackages.get(bp.sourcePackage);
            }
            if (bp.packageSetting == null) {
                Slog.w(TAG, "Removing dangling permission tree: " + bp.name + " from package " + bp.sourcePackage);
                it.remove();
            } else if (changingPkg != null && changingPkg.equals(bp.sourcePackage)) {
                if (pkgInfo == null || !hasPermission(pkgInfo, bp.name)) {
                    Slog.i(TAG, "Removing old permission tree: " + bp.name + " from package " + bp.sourcePackage);
                    flags |= UPDATE_PERMISSIONS_ALL;
                    it.remove();
                }
            }
        }
        it = this.mSettings.mPermissions.values().iterator();
        while (it.hasNext()) {
            bp = (BasePermission) it.next();
            if (bp.type == UPDATE_PERMISSIONS_REPLACE_PKG && bp.packageSetting == null && bp.pendingInfo != null) {
                BasePermission tree = findPermissionTreeLP(bp.name);
                if (!(tree == null || tree.perm == null)) {
                    bp.packageSetting = tree.packageSetting;
                    bp.perm = new Permission(tree.perm.owner, new PermissionInfo(bp.pendingInfo));
                    bp.perm.info.packageName = tree.perm.info.packageName;
                    bp.perm.info.name = bp.name;
                    bp.uid = tree.uid;
                }
            }
            if (bp.packageSetting == null) {
                bp.packageSetting = (PackageSettingBase) this.mSettings.mPackages.get(bp.sourcePackage);
            }
            if (bp.packageSetting == null) {
                Slog.w(TAG, "Removing dangling permission: " + bp.name + " from package " + bp.sourcePackage);
                it.remove();
            } else if (changingPkg != null && changingPkg.equals(bp.sourcePackage)) {
                if (pkgInfo == null || !hasPermission(pkgInfo, bp.name)) {
                    Slog.i(TAG, "Removing old permission: " + bp.name + " from package " + bp.sourcePackage);
                    flags |= UPDATE_PERMISSIONS_ALL;
                    it.remove();
                }
            }
        }
        if ((flags & UPDATE_PERMISSIONS_ALL) != 0) {
            for (Package pkg : this.mPackages.values()) {
                if (pkg != pkgInfo) {
                    grantPermissionsLPw(pkg, (flags & UPDATE_PERMISSIONS_REPLACE_ALL) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY, changingPkg);
                }
            }
        }
        if (pkgInfo != null) {
            if ((flags & UPDATE_PERMISSIONS_REPLACE_PKG) == 0) {
                z = DEBUG_VERIFY;
            }
            grantPermissionsLPw(pkgInfo, z, changingPkg);
        }
    }

    private void grantPermissionsLPw(Package pkg, boolean replace, String packageOfInterest) {
        PackageSetting ps = pkg.mExtras;
        if (ps != null) {
            GrantedPermissions gp;
            if (ps.sharedUser != null) {
                gp = ps.sharedUser;
            } else {
                gp = ps;
            }
            ArraySet<String> origPermissions = gp.grantedPermissions;
            boolean changedPermission = DEBUG_VERIFY;
            if (replace) {
                ps.permissionsFixed = DEBUG_VERIFY;
                if (gp == ps) {
                    origPermissions = new ArraySet(gp.grantedPermissions);
                    gp.grantedPermissions.clear();
                    gp.gids = this.mGlobalGids;
                }
            }
            if (gp.gids == null) {
                gp.gids = this.mGlobalGids;
            }
            int N = pkg.requestedPermissions.size();
            for (int i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
                String name = (String) pkg.requestedPermissions.get(i);
                boolean required = ((Boolean) pkg.requestedPermissionsRequired.get(i)).booleanValue();
                BasePermission bp = (BasePermission) this.mSettings.mPermissions.get(name);
                if (bp == null || bp.packageSetting == null) {
                    if (packageOfInterest != null) {
                        if (!packageOfInterest.equals(pkg.packageName)) {
                        }
                    }
                    Slog.w(TAG, "Unknown permission " + name + " in package " + pkg.packageName);
                } else {
                    boolean allowed;
                    String perm = bp.name;
                    boolean allowedSig = DEBUG_VERIFY;
                    if ((bp.protectionLevel & SCAN_UPDATE_TIME) != 0) {
                        ArraySet<String> pkgs = (ArraySet) this.mAppOpPermissionPackages.get(bp.name);
                        if (pkgs == null) {
                            pkgs = new ArraySet();
                            this.mAppOpPermissionPackages.put(bp.name, pkgs);
                        }
                        pkgs.add(pkg.packageName);
                    }
                    int level = bp.protectionLevel & PACKAGE_VERIFIED;
                    if (level == 0 || level == UPDATE_PERMISSIONS_ALL) {
                        allowed = (required || origPermissions.contains(perm) || (isSystemApp(ps) && !isUpdatedSystemApp(ps))) ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
                    } else if (bp.packageSetting == null) {
                        allowed = DEBUG_VERIFY;
                    } else if (level == UPDATE_PERMISSIONS_REPLACE_PKG) {
                        allowed = grantSignaturePermission(perm, pkg, bp, origPermissions);
                        if (allowed) {
                            allowedSig = DEFAULT_VERIFY_ENABLE;
                        }
                    } else {
                        allowed = DEBUG_VERIFY;
                    }
                    if (allowed) {
                        if (!(isSystemApp(ps) || !ps.permissionsFixed || allowedSig)) {
                            if (!gp.grantedPermissions.contains(perm)) {
                                allowed = isNewPlatformPermissionForPackage(perm, pkg);
                            }
                        }
                        if (allowed) {
                            if (!gp.grantedPermissions.contains(perm)) {
                                changedPermission = DEFAULT_VERIFY_ENABLE;
                                gp.grantedPermissions.add(perm);
                                gp.gids = appendInts(gp.gids, bp.gids);
                            } else if (!ps.haveGids) {
                                gp.gids = appendInts(gp.gids, bp.gids);
                            }
                        } else {
                            if (packageOfInterest != null) {
                                if (!packageOfInterest.equals(pkg.packageName)) {
                                }
                            }
                            Slog.w(TAG, "Not granting permission " + perm + " to package " + pkg.packageName + " because it was previously installed without");
                        }
                    } else {
                        StringBuilder append;
                        if (gp.grantedPermissions.remove(perm)) {
                            changedPermission = DEFAULT_VERIFY_ENABLE;
                            gp.gids = removeInts(gp.gids, bp.gids);
                            append = new StringBuilder().append("Un-granting permission ");
                            Slog.i(TAG, r17.append(perm).append(" from package ").append(pkg.packageName).append(" (protectionLevel=").append(bp.protectionLevel).append(" flags=0x").append(Integer.toHexString(pkg.applicationInfo.flags)).append(")").toString());
                        } else {
                            if ((bp.protectionLevel & SCAN_UPDATE_TIME) == 0) {
                                if (packageOfInterest != null) {
                                    if (!packageOfInterest.equals(pkg.packageName)) {
                                    }
                                }
                                append = new StringBuilder().append("Not granting permission ");
                                Slog.w(TAG, r17.append(perm).append(" to package ").append(pkg.packageName).append(" (protectionLevel=").append(bp.protectionLevel).append(" flags=0x").append(Integer.toHexString(pkg.applicationInfo.flags)).append(")").toString());
                            }
                        }
                    }
                }
            }
            if (!((!changedPermission && !replace) || ps.permissionsFixed || isSystemApp(ps)) || isUpdatedSystemApp(ps)) {
                ps.permissionsFixed = DEFAULT_VERIFY_ENABLE;
            }
            ps.haveGids = DEFAULT_VERIFY_ENABLE;
        }
    }

    private boolean isNewPlatformPermissionForPackage(String perm, Package pkg) {
        int NP = PackageParser.NEW_PERMISSIONS.length;
        int ip = DEX_OPT_SKIPPED;
        while (ip < NP) {
            NewPermissionInfo npi = PackageParser.NEW_PERMISSIONS[ip];
            if (!npi.name.equals(perm) || pkg.applicationInfo.targetSdkVersion >= npi.sdkVersion) {
                ip += UPDATE_PERMISSIONS_ALL;
            } else {
                Log.i(TAG, "Auto-granting " + perm + " to old pkg " + pkg.packageName);
                return DEFAULT_VERIFY_ENABLE;
            }
        }
        return DEBUG_VERIFY;
    }

    private boolean grantSignaturePermission(String perm, Package pkg, BasePermission bp, ArraySet<String> origPermissions) {
        boolean allowed = (compareSignatures(bp.packageSetting.signatures.mSignatures, pkg.mSignatures) == 0 || compareSignatures(this.mPlatformPackage.mSignatures, pkg.mSignatures) == 0) ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
        if (!(allowed || (bp.protectionLevel & SCAN_NEW_INSTALL) == 0 || !isSystemApp(pkg))) {
            if (isUpdatedSystemApp(pkg)) {
                GrantedPermissions origGp;
                GrantedPermissions sysPs = this.mSettings.getDisabledSystemPkgLPr(pkg.packageName);
                if (sysPs.sharedUser != null) {
                    origGp = sysPs.sharedUser;
                } else {
                    origGp = sysPs;
                }
                if (origGp.grantedPermissions.contains(perm)) {
                    if (sysPs.isPrivileged()) {
                        allowed = DEFAULT_VERIFY_ENABLE;
                    }
                } else if (sysPs.pkg != null && sysPs.isPrivileged()) {
                    for (int j = DEX_OPT_SKIPPED; j < sysPs.pkg.requestedPermissions.size(); j += UPDATE_PERMISSIONS_ALL) {
                        if (perm.equals(sysPs.pkg.requestedPermissions.get(j))) {
                            allowed = DEFAULT_VERIFY_ENABLE;
                            break;
                        }
                    }
                }
            } else {
                allowed = isPrivilegedApp(pkg);
            }
        }
        if (allowed || (bp.protectionLevel & SCAN_NO_PATHS) == 0) {
            return allowed;
        }
        return origPermissions.contains(perm);
    }

    static final void sendPackageBroadcast(String action, String pkg, Bundle extras, String targetPkg, IIntentReceiver finishedReceiver, int[] userIds) {
        IActivityManager am = ActivityManagerNative.getDefault();
        if (am != null) {
            if (userIds == null) {
                try {
                    userIds = am.getRunningUserIds();
                } catch (RemoteException e) {
                    return;
                }
            }
            int[] arr$ = userIds;
            int len$ = arr$.length;
            for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
                boolean z;
                int id = arr$[i$];
                Intent intent = new Intent(action, pkg != null ? Uri.fromParts("package", pkg, null) : null);
                if (extras != null) {
                    intent.putExtras(extras);
                }
                if (targetPkg != null) {
                    intent.setPackage(targetPkg);
                }
                int uid = intent.getIntExtra("android.intent.extra.UID", DEX_OPT_FAILED);
                if (uid > 0 && UserHandle.getUserId(uid) != id) {
                    intent.putExtra("android.intent.extra.UID", UserHandle.getUid(id, UserHandle.getAppId(uid)));
                }
                intent.putExtra("android.intent.extra.user_handle", id);
                intent.addFlags(67108864);
                if (finishedReceiver != null) {
                    z = DEFAULT_VERIFY_ENABLE;
                } else {
                    z = DEBUG_VERIFY;
                }
                am.broadcastIntent(null, intent, null, finishedReceiver, DEX_OPT_SKIPPED, null, null, null, DEX_OPT_FAILED, z, DEBUG_VERIFY, id);
            }
        }
    }

    private boolean isExternalMediaAvailable() {
        return (this.mMediaMounted || Environment.isExternalStorageEmulated()) ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    public PackageCleanItem nextPackageToClean(PackageCleanItem lastPackage) {
        PackageCleanItem packageCleanItem = null;
        synchronized (this.mPackages) {
            if (isExternalMediaAvailable()) {
                ArrayList<PackageCleanItem> pkgs = this.mSettings.mPackagesToBeCleaned;
                if (lastPackage != null) {
                    pkgs.remove(lastPackage);
                }
                if (pkgs.size() > 0) {
                    packageCleanItem = (PackageCleanItem) pkgs.get(DEX_OPT_SKIPPED);
                }
            }
        }
        return packageCleanItem;
    }

    void schedulePackageCleaning(String packageName, int userId, boolean andCode) {
        Message msg = this.mHandler.obtainMessage(START_CLEANING_PACKAGE, userId, andCode ? UPDATE_PERMISSIONS_ALL : DEX_OPT_SKIPPED, packageName);
        if (this.mSystemReady) {
            msg.sendToTarget();
            return;
        }
        if (this.mPostSystemReadyMessages == null) {
            this.mPostSystemReadyMessages = new ArrayList();
        }
        this.mPostSystemReadyMessages.add(msg);
    }

    void startCleaningPackages() {
        synchronized (this.mPackages) {
            if (!isExternalMediaAvailable()) {
            } else if (this.mSettings.mPackagesToBeCleaned.isEmpty()) {
            } else {
                Intent intent = new Intent("android.content.pm.CLEAN_EXTERNAL_STORAGE");
                intent.setComponent(DEFAULT_CONTAINER_COMPONENT);
                IActivityManager am = ActivityManagerNative.getDefault();
                if (am != null) {
                    try {
                        am.startService(null, intent, null, DEX_OPT_SKIPPED);
                    } catch (RemoteException e) {
                    }
                }
            }
        }
    }

    public void installPackage(String originPath, IPackageInstallObserver2 observer, int installFlags, String installerPackageName, VerificationParams verificationParams, String packageAbiOverride) {
        installPackageAsUser(originPath, observer, installFlags, installerPackageName, verificationParams, packageAbiOverride, UserHandle.getCallingUserId());
    }

    public void installPackageAsUser(String originPath, IPackageInstallObserver2 observer, int installFlags, String installerPackageName, VerificationParams verificationParams, String packageAbiOverride, int userId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.INSTALL_PACKAGES", null);
        int callingUid = Binder.getCallingUid();
        enforceCrossUserPermission(callingUid, userId, DEFAULT_VERIFY_ENABLE, DEFAULT_VERIFY_ENABLE, "installPackageAsUser");
        if (!isUserRestricted(userId, "no_install_apps")) {
            UserHandle user;
            if (callingUid == SHELL_UID || callingUid == 0) {
                installFlags |= SCAN_NO_PATHS;
            } else {
                installFlags = (installFlags & -33) & -65;
            }
            if ((installFlags & SCAN_UPDATE_TIME) != 0) {
                user = UserHandle.ALL;
            } else {
                user = new UserHandle(userId);
            }
            verificationParams.setInstallerUid(callingUid);
            OriginInfo origin = OriginInfo.fromUntrustedFile(new File(originPath));
            Message msg = this.mHandler.obtainMessage(INIT_COPY);
            msg.obj = new InstallParams(origin, observer, installFlags, installerPackageName, verificationParams, user, packageAbiOverride);
            this.mHandler.sendMessage(msg);
        } else if (observer != null) {
            try {
                observer.onPackageInstalled("", -111, null, null);
            } catch (RemoteException e) {
            }
        }
    }

    void installStage(String packageName, File stagedDir, String stagedCid, IPackageInstallObserver2 observer, SessionParams params, String installerPackageName, int installerUid, UserHandle user) {
        OriginInfo origin;
        VerificationParams verifParams = new VerificationParams(null, params.originatingUri, params.referrerUri, installerUid, null);
        if (stagedDir != null) {
            origin = OriginInfo.fromStagedFile(stagedDir);
        } else {
            origin = OriginInfo.fromStagedContainer(stagedCid);
        }
        Message msg = this.mHandler.obtainMessage(INIT_COPY);
        msg.obj = new InstallParams(origin, observer, params.installFlags, installerPackageName, verifParams, user, params.abiOverride);
        this.mHandler.sendMessage(msg);
    }

    private void sendPackageAddedForUser(String packageName, PackageSetting pkgSetting, int userId) {
        Bundle extras = new Bundle(UPDATE_PERMISSIONS_ALL);
        extras.putInt("android.intent.extra.UID", UserHandle.getUid(userId, pkgSetting.appId));
        int[] iArr = new int[UPDATE_PERMISSIONS_ALL];
        iArr[DEX_OPT_SKIPPED] = userId;
        sendPackageBroadcast("android.intent.action.PACKAGE_ADDED", packageName, extras, null, null, iArr);
        try {
            IActivityManager am = ActivityManagerNative.getDefault();
            boolean isSystem = (isSystemApp(pkgSetting) || isUpdatedSystemApp(pkgSetting)) ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
            if (isSystem && am.isUserRunning(userId, DEBUG_VERIFY)) {
                am.broadcastIntent(null, new Intent("android.intent.action.BOOT_COMPLETED").addFlags(SCAN_NO_PATHS).setPackage(packageName), null, null, DEX_OPT_SKIPPED, null, null, null, DEX_OPT_FAILED, DEBUG_VERIFY, DEBUG_VERIFY, userId);
            }
        } catch (Throwable e) {
            Slog.w(TAG, "Unable to bootstrap installed package", e);
        }
    }

    public boolean setApplicationHiddenSettingAsUser(String packageName, boolean hidden, int userId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USERS", null);
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEFAULT_VERIFY_ENABLE, DEFAULT_VERIFY_ENABLE, "setApplicationHiddenSetting for user " + userId);
        if (hidden && isPackageDeviceAdmin(packageName, userId)) {
            Slog.w(TAG, "Not hiding package " + packageName + ": has active device admin");
            return DEBUG_VERIFY;
        }
        long callingId = Binder.clearCallingIdentity();
        boolean sendAdded = DEBUG_VERIFY;
        boolean sendRemoved = DEBUG_VERIFY;
        try {
            synchronized (this.mPackages) {
                PackageSetting pkgSetting = (PackageSetting) this.mSettings.mPackages.get(packageName);
                if (pkgSetting == null) {
                    return DEBUG_VERIFY;
                }
                if (pkgSetting.getHidden(userId) != hidden) {
                    pkgSetting.setHidden(hidden, userId);
                    this.mSettings.writePackageRestrictionsLPr(userId);
                    if (hidden) {
                        sendRemoved = DEFAULT_VERIFY_ENABLE;
                    } else {
                        sendAdded = DEFAULT_VERIFY_ENABLE;
                    }
                }
                if (sendAdded) {
                    sendPackageAddedForUser(packageName, pkgSetting, userId);
                    Binder.restoreCallingIdentity(callingId);
                    return DEFAULT_VERIFY_ENABLE;
                }
                if (sendRemoved) {
                    killApplication(packageName, UserHandle.getUid(userId, pkgSetting.appId), "hiding pkg");
                    sendApplicationHiddenForUser(packageName, pkgSetting, userId);
                }
                Binder.restoreCallingIdentity(callingId);
                return DEBUG_VERIFY;
            }
        } finally {
            Binder.restoreCallingIdentity(callingId);
        }
    }

    private void sendApplicationHiddenForUser(String packageName, PackageSetting pkgSetting, int userId) {
        PackageRemovedInfo info = new PackageRemovedInfo();
        info.removedPackage = packageName;
        int[] iArr = new int[UPDATE_PERMISSIONS_ALL];
        iArr[DEX_OPT_SKIPPED] = userId;
        info.removedUsers = iArr;
        info.uid = UserHandle.getUid(userId, pkgSetting.appId);
        info.sendBroadcast(DEBUG_VERIFY, DEBUG_VERIFY, DEBUG_VERIFY);
    }

    public boolean getApplicationHiddenSettingAsUser(String packageName, int userId) {
        boolean z = DEFAULT_VERIFY_ENABLE;
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USERS", null);
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEFAULT_VERIFY_ENABLE, DEBUG_VERIFY, "getApplicationHidden for user " + userId);
        long callingId = Binder.clearCallingIdentity();
        try {
            synchronized (this.mPackages) {
                PackageSetting pkgSetting = (PackageSetting) this.mSettings.mPackages.get(packageName);
                if (pkgSetting == null) {
                } else {
                    z = pkgSetting.getHidden(userId);
                    Binder.restoreCallingIdentity(callingId);
                }
            }
            return z;
        } finally {
            Binder.restoreCallingIdentity(callingId);
        }
    }

    public int installExistingPackageAsUser(String packageName, int userId) {
        int i = UPDATE_PERMISSIONS_ALL;
        this.mContext.enforceCallingOrSelfPermission("android.permission.INSTALL_PACKAGES", null);
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEFAULT_VERIFY_ENABLE, DEFAULT_VERIFY_ENABLE, "installExistingPackage for user " + userId);
        if (isUserRestricted(userId, "no_install_apps")) {
            return -111;
        }
        long callingId = Binder.clearCallingIdentity();
        boolean sendAdded = DEBUG_VERIFY;
        try {
            Bundle extras = new Bundle(UPDATE_PERMISSIONS_ALL);
            synchronized (this.mPackages) {
                PackageSetting pkgSetting = (PackageSetting) this.mSettings.mPackages.get(packageName);
                if (pkgSetting == null) {
                    i = -3;
                    return i;
                }
                if (!pkgSetting.getInstalled(userId)) {
                    pkgSetting.setInstalled(DEFAULT_VERIFY_ENABLE, userId);
                    pkgSetting.setHidden(DEBUG_VERIFY, userId);
                    this.mSettings.writePackageRestrictionsLPr(userId);
                    sendAdded = DEFAULT_VERIFY_ENABLE;
                }
                if (sendAdded) {
                    sendPackageAddedForUser(packageName, pkgSetting, userId);
                }
                Binder.restoreCallingIdentity(callingId);
                return UPDATE_PERMISSIONS_ALL;
            }
        } finally {
            Binder.restoreCallingIdentity(callingId);
        }
    }

    boolean isUserRestricted(int userId, String restrictionKey) {
        if (!sUserManager.getUserRestrictions(userId).getBoolean(restrictionKey, DEBUG_VERIFY)) {
            return DEBUG_VERIFY;
        }
        Log.w(TAG, "User is restricted: " + restrictionKey);
        return DEFAULT_VERIFY_ENABLE;
    }

    public void verifyPendingInstall(int id, int verificationCode) throws RemoteException {
        this.mContext.enforceCallingOrSelfPermission("android.permission.PACKAGE_VERIFICATION_AGENT", "Only package verification agents can verify applications");
        Message msg = this.mHandler.obtainMessage(PACKAGE_VERIFIED);
        PackageVerificationResponse response = new PackageVerificationResponse(verificationCode, Binder.getCallingUid());
        msg.arg1 = id;
        msg.obj = response;
        this.mHandler.sendMessage(msg);
    }

    public void extendVerificationTimeout(int id, int verificationCodeAtTimeout, long millisecondsToDelay) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.PACKAGE_VERIFICATION_AGENT", "Only package verification agents can extend verification timeouts");
        PackageVerificationState state = (PackageVerificationState) this.mPendingVerification.get(id);
        PackageVerificationResponse response = new PackageVerificationResponse(verificationCodeAtTimeout, Binder.getCallingUid());
        if (millisecondsToDelay > 3600000) {
            millisecondsToDelay = 3600000;
        }
        if (millisecondsToDelay < 0) {
            millisecondsToDelay = 0;
        }
        if (!(verificationCodeAtTimeout == UPDATE_PERMISSIONS_ALL || verificationCodeAtTimeout == DEX_OPT_FAILED)) {
        }
        if (state != null && !state.timeoutExtended()) {
            state.extendTimeout();
            Message msg = this.mHandler.obtainMessage(PACKAGE_VERIFIED);
            msg.arg1 = id;
            msg.obj = response;
            this.mHandler.sendMessageDelayed(msg, millisecondsToDelay);
        }
    }

    private void broadcastPackageVerified(int verificationId, Uri packageUri, int verificationCode, UserHandle user) {
        Intent intent = new Intent("android.intent.action.PACKAGE_VERIFIED");
        intent.setDataAndType(packageUri, PACKAGE_MIME_TYPE);
        intent.addFlags(UPDATE_PERMISSIONS_ALL);
        intent.putExtra("android.content.pm.extra.VERIFICATION_ID", verificationId);
        intent.putExtra("android.content.pm.extra.VERIFICATION_RESULT", verificationCode);
        this.mContext.sendBroadcastAsUser(intent, user, "android.permission.PACKAGE_VERIFICATION_AGENT");
    }

    private ComponentName matchComponentForVerifier(String packageName, List<ResolveInfo> receivers) {
        ActivityInfo targetReceiver = null;
        int NR = receivers.size();
        for (int i = DEX_OPT_SKIPPED; i < NR; i += UPDATE_PERMISSIONS_ALL) {
            ResolveInfo info = (ResolveInfo) receivers.get(i);
            if (info.activityInfo != null && packageName.equals(info.activityInfo.packageName)) {
                targetReceiver = info.activityInfo;
                break;
            }
        }
        if (targetReceiver == null) {
            return null;
        }
        return new ComponentName(targetReceiver.packageName, targetReceiver.name);
    }

    private List<ComponentName> matchVerifiers(PackageInfoLite pkgInfo, List<ResolveInfo> receivers, PackageVerificationState verificationState) {
        if (pkgInfo.verifiers.length == 0) {
            return null;
        }
        int N = pkgInfo.verifiers.length;
        List<ComponentName> sufficientVerifiers = new ArrayList(N + UPDATE_PERMISSIONS_ALL);
        for (int i = DEX_OPT_SKIPPED; i < N; i += UPDATE_PERMISSIONS_ALL) {
            VerifierInfo verifierInfo = pkgInfo.verifiers[i];
            ComponentName comp = matchComponentForVerifier(verifierInfo.packageName, receivers);
            if (comp != null) {
                int verifierUid = getUidForVerifier(verifierInfo);
                if (verifierUid != DEX_OPT_FAILED) {
                    sufficientVerifiers.add(comp);
                    verificationState.addSufficientVerifier(verifierUid);
                }
            }
        }
        return sufficientVerifiers;
    }

    private int getUidForVerifier(VerifierInfo verifierInfo) {
        int i = DEX_OPT_FAILED;
        synchronized (this.mPackages) {
            Package pkg = (Package) this.mPackages.get(verifierInfo.packageName);
            if (pkg == null) {
            } else if (pkg.mSignatures.length != UPDATE_PERMISSIONS_ALL) {
                Slog.i(TAG, "Verifier package " + verifierInfo.packageName + " has more than one signature; ignoring");
            } else {
                try {
                    if (Arrays.equals(verifierInfo.publicKey.getEncoded(), pkg.mSignatures[DEX_OPT_SKIPPED].getPublicKey().getEncoded())) {
                        i = pkg.applicationInfo.uid;
                    } else {
                        Slog.i(TAG, "Verifier package " + verifierInfo.packageName + " does not have the expected public key; ignoring");
                    }
                } catch (CertificateException e) {
                }
            }
        }
        return i;
    }

    public void finishPackageInstall(int token) {
        enforceSystemOrRoot("Only the system is allowed to finish installs");
        this.mHandler.sendMessage(this.mHandler.obtainMessage(POST_INSTALL, token, DEX_OPT_SKIPPED));
    }

    private long getVerificationTimeout() {
        return Global.getLong(this.mContext.getContentResolver(), "verifier_timeout", DEFAULT_VERIFICATION_TIMEOUT);
    }

    private int getDefaultVerificationResponse() {
        return Global.getInt(this.mContext.getContentResolver(), "verifier_default_response", UPDATE_PERMISSIONS_ALL);
    }

    private boolean isVerificationEnabled(int userId, int installFlags) {
        boolean ensureVerifyAppsEnabled = isUserRestricted(userId, "ensure_verify_apps");
        if ((installFlags & SCAN_NO_PATHS) != 0) {
            if (ActivityManager.isRunningInTestHarness()) {
                return DEBUG_VERIFY;
            }
            if (ensureVerifyAppsEnabled) {
                return DEFAULT_VERIFY_ENABLE;
            }
            if (Global.getInt(this.mContext.getContentResolver(), "verifier_verify_adb_installs", UPDATE_PERMISSIONS_ALL) == 0) {
                return DEBUG_VERIFY;
            }
        }
        if (ensureVerifyAppsEnabled || Global.getInt(this.mContext.getContentResolver(), "package_verifier_enable", UPDATE_PERMISSIONS_ALL) == UPDATE_PERMISSIONS_ALL) {
            return DEFAULT_VERIFY_ENABLE;
        }
        return DEBUG_VERIFY;
    }

    private int getUnknownSourcesSettings() {
        return Global.getInt(this.mContext.getContentResolver(), "install_non_market_apps", DEX_OPT_FAILED);
    }

    public void setInstallerPackageName(String targetPackage, String installerPackageName) {
        int uid = Binder.getCallingUid();
        synchronized (this.mPackages) {
            PackageSetting targetPackageSetting = (PackageSetting) this.mSettings.mPackages.get(targetPackage);
            if (targetPackageSetting == null) {
                throw new IllegalArgumentException("Unknown target package: " + targetPackage);
            }
            PackageSetting installerPackageSetting;
            if (installerPackageName != null) {
                installerPackageSetting = (PackageSetting) this.mSettings.mPackages.get(installerPackageName);
                if (installerPackageSetting == null) {
                    throw new IllegalArgumentException("Unknown installer package: " + installerPackageName);
                }
            }
            installerPackageSetting = null;
            Object obj = this.mSettings.getUserIdLPr(uid);
            if (obj != null) {
                Signature[] callerSignature;
                if (obj instanceof SharedUserSetting) {
                    callerSignature = ((SharedUserSetting) obj).signatures.mSignatures;
                } else if (obj instanceof PackageSetting) {
                    callerSignature = ((PackageSetting) obj).signatures.mSignatures;
                } else {
                    throw new SecurityException("Bad object " + obj + " for uid " + uid);
                }
                if (installerPackageSetting == null || compareSignatures(callerSignature, installerPackageSetting.signatures.mSignatures) == 0) {
                    if (targetPackageSetting.installerPackageName != null) {
                        PackageSetting setting = (PackageSetting) this.mSettings.mPackages.get(targetPackageSetting.installerPackageName);
                        if (!(setting == null || compareSignatures(callerSignature, setting.signatures.mSignatures) == 0)) {
                            throw new SecurityException("Caller does not have same cert as old installer package " + targetPackageSetting.installerPackageName);
                        }
                    }
                    targetPackageSetting.installerPackageName = installerPackageName;
                    scheduleWriteSettingsLocked();
                } else {
                    throw new SecurityException("Caller does not have same cert as new installer package " + installerPackageName);
                }
            }
            throw new SecurityException("Unknown calling uid " + uid);
        }
    }

    private void processPendingInstall(InstallArgs args, int currentStatus) {
        this.mHandler.post(new C04526(currentStatus, args));
    }

    private static long calculateDirectorySize(IMediaContainerService mcs, File[] paths) throws RemoteException {
        long result = 0;
        File[] arr$ = paths;
        int len$ = arr$.length;
        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            result += mcs.calculateDirectorySize(arr$[i$].getAbsolutePath());
        }
        return result;
    }

    private static void clearDirectory(IMediaContainerService mcs, File[] paths) {
        File[] arr$ = paths;
        int len$ = arr$.length;
        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            try {
                mcs.clearDirectory(arr$[i$].getAbsolutePath());
            } catch (RemoteException e) {
            }
        }
    }

    private static boolean installOnSd(int installFlags) {
        if ((installFlags & SCAN_NEW_INSTALL) == 0 && (installFlags & SCAN_UPDATE_SIGNATURE) != 0) {
            return DEFAULT_VERIFY_ENABLE;
        }
        return DEBUG_VERIFY;
    }

    private static boolean installForwardLocked(int installFlags) {
        return (installFlags & UPDATE_PERMISSIONS_ALL) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private InstallArgs createInstallArgs(InstallParams params) {
        if (installOnSd(params.installFlags) || params.isForwardLocked()) {
            return new AsecInstallArgs(params);
        }
        return new FileInstallArgs(params);
    }

    private InstallArgs createInstallArgsForExisting(int installFlags, String codePath, String resourcePath, String nativeLibraryRoot, String[] instructionSets) {
        boolean isInAsec;
        if (installOnSd(installFlags)) {
            isInAsec = DEFAULT_VERIFY_ENABLE;
        } else if (!installForwardLocked(installFlags) || codePath.startsWith(this.mDrmAppPrivateInstallDir.getAbsolutePath())) {
            isInAsec = DEBUG_VERIFY;
        } else {
            isInAsec = DEFAULT_VERIFY_ENABLE;
        }
        if (!isInAsec) {
            return new FileInstallArgs(this, codePath, resourcePath, nativeLibraryRoot, instructionSets);
        }
        return new AsecInstallArgs(codePath, instructionSets, installOnSd(installFlags), installForwardLocked(installFlags));
    }

    private boolean isAsecExternal(String cid) {
        return !PackageHelper.getSdFilesystem(cid).startsWith(this.mAsecInternalPath) ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static void maybeThrowExceptionForMultiArchCopy(String message, int copyRet) throws PackageManagerException {
        if (copyRet < 0 && copyRet != -114 && copyRet != -113) {
            throw new PackageManagerException(copyRet, message);
        }
    }

    static String cidFromCodePath(String fullCodePath) {
        int eidx = fullCodePath.lastIndexOf("/");
        String subStr1 = fullCodePath.substring(DEX_OPT_SKIPPED, eidx);
        return subStr1.substring(subStr1.lastIndexOf("/") + UPDATE_PERMISSIONS_ALL, eidx);
    }

    static String getAsecPackageName(String packageCid) {
        int idx = packageCid.lastIndexOf(INSTALL_PACKAGE_SUFFIX);
        return idx == DEX_OPT_FAILED ? packageCid : packageCid.substring(DEX_OPT_SKIPPED, idx);
    }

    private static String getNextCodePath(String oldCodePath, String prefix, String suffix) {
        String idxStr = "";
        int idx = UPDATE_PERMISSIONS_ALL;
        if (oldCodePath != null) {
            String subStr = oldCodePath;
            if (suffix != null && subStr.endsWith(suffix)) {
                subStr = subStr.substring(DEX_OPT_SKIPPED, subStr.length() - suffix.length());
            }
            int sidx = subStr.lastIndexOf(prefix);
            if (sidx != DEX_OPT_FAILED) {
                subStr = subStr.substring(prefix.length() + sidx);
                if (subStr != null) {
                    if (subStr.startsWith(INSTALL_PACKAGE_SUFFIX)) {
                        subStr = subStr.substring(INSTALL_PACKAGE_SUFFIX.length());
                    }
                    try {
                        idx = Integer.parseInt(subStr);
                        idx = idx <= UPDATE_PERMISSIONS_ALL ? idx + UPDATE_PERMISSIONS_ALL : idx + DEX_OPT_FAILED;
                    } catch (NumberFormatException e) {
                    }
                }
            }
        }
        return prefix + (INSTALL_PACKAGE_SUFFIX + Integer.toString(idx));
    }

    private File getNextCodePath(String packageName) {
        File result;
        int suffix = UPDATE_PERMISSIONS_ALL;
        do {
            result = new File(this.mAppInstallDir, packageName + INSTALL_PACKAGE_SUFFIX + suffix);
            suffix += UPDATE_PERMISSIONS_ALL;
        } while (result.exists());
        return result;
    }

    private static boolean ignoreCodePath(String fullPathStr) {
        String apkName = deriveCodePathName(fullPathStr);
        int idx = apkName.lastIndexOf(INSTALL_PACKAGE_SUFFIX);
        if (idx != DEX_OPT_FAILED && idx + UPDATE_PERMISSIONS_ALL < apkName.length()) {
            try {
                Integer.parseInt(apkName.substring(idx + UPDATE_PERMISSIONS_ALL));
                return DEFAULT_VERIFY_ENABLE;
            } catch (NumberFormatException e) {
            }
        }
        return DEBUG_VERIFY;
    }

    static String deriveCodePathName(String codePath) {
        if (codePath == null) {
            return null;
        }
        File codeFile = new File(codePath);
        String name = codeFile.getName();
        if (codeFile.isDirectory()) {
            return name;
        }
        if (name.endsWith(".apk") || name.endsWith(".tmp")) {
            return name.substring(DEX_OPT_SKIPPED, name.lastIndexOf(46));
        }
        Slog.w(TAG, "Odd, " + codePath + " doesn't look like an APK");
        return null;
    }

    private void installNewPackageLI(Package pkg, int parseFlags, int scanFlags, UserHandle user, String installerPackageName, PackageInstalledInfo res) {
        String pkgName = pkg.packageName;
        boolean dataDirExists = getDataPathForPackage(pkg.packageName, DEX_OPT_SKIPPED).exists();
        synchronized (this.mPackages) {
            if (this.mSettings.mRenamedPackages.containsKey(pkgName)) {
                res.setError((int) DEX_OPT_FAILED, "Attempt to re-install " + pkgName + " without first uninstalling package running as " + ((String) this.mSettings.mRenamedPackages.get(pkgName)));
            } else if (this.mPackages.containsKey(pkgName)) {
                res.setError((int) DEX_OPT_FAILED, "Attempt to re-install " + pkgName + " without first uninstalling.");
            } else {
                try {
                    updateSettingsLI(scanPackageLI(pkg, parseFlags, scanFlags, System.currentTimeMillis(), user), installerPackageName, null, null, res);
                    if (res.returnCode != UPDATE_PERMISSIONS_ALL) {
                        deletePackageLI(pkgName, UserHandle.ALL, DEBUG_VERIFY, null, null, dataDirExists ? UPDATE_PERMISSIONS_ALL : DEX_OPT_SKIPPED, res.removedInfo, DEFAULT_VERIFY_ENABLE);
                    }
                } catch (PackageManagerException e) {
                    res.setError("Package couldn't be installed in " + pkg.codePath, e);
                }
            }
        }
    }

    private boolean checkUpgradeKeySetLP(PackageSetting oldPS, Package newPkg) {
        long[] upgradeKeySets = oldPS.keySetData.getUpgradeKeySets();
        KeySetManagerService ksms = this.mSettings.mKeySetManagerService;
        for (int i = DEX_OPT_SKIPPED; i < upgradeKeySets.length; i += UPDATE_PERMISSIONS_ALL) {
            if (newPkg.mSigningKeys.containsAll(ksms.getPublicKeysFromKeySetLPr(upgradeKeySets[i]))) {
                return DEFAULT_VERIFY_ENABLE;
            }
        }
        return DEBUG_VERIFY;
    }

    private void replacePackageLI(Package pkg, int parseFlags, int scanFlags, UserHandle user, String installerPackageName, PackageInstalledInfo res) {
        String pkgName = pkg.packageName;
        synchronized (this.mPackages) {
            Package oldPackage = (Package) this.mPackages.get(pkgName);
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(pkgName);
            if (ps != null && ps.keySetData.isUsingUpgradeKeySets() && ps.sharedUser == null) {
                if (!checkUpgradeKeySetLP(ps, pkg)) {
                    res.setError(-7, "New package not signed by keys specified by upgrade-keysets: " + pkgName);
                    return;
                }
            } else if (compareSignatures(oldPackage.mSignatures, pkg.mSignatures) != 0) {
                res.setError(-7, "New package has a different signature: " + pkgName);
                return;
            }
            int[] allUsers = sUserManager.getUserIds();
            boolean[] perUserInstalled = new boolean[allUsers.length];
            for (int i = DEX_OPT_SKIPPED; i < allUsers.length; i += UPDATE_PERMISSIONS_ALL) {
                perUserInstalled[i] = ps != null ? ps.getInstalled(allUsers[i]) : DEBUG_VERIFY;
            }
            if (isSystemApp(oldPackage)) {
                replaceSystemPackageLI(oldPackage, pkg, parseFlags, scanFlags, user, allUsers, perUserInstalled, installerPackageName, res);
            } else {
                replaceNonSystemPackageLI(oldPackage, pkg, parseFlags, scanFlags, user, allUsers, perUserInstalled, installerPackageName, res);
            }
        }
    }

    private void replaceNonSystemPackageLI(Package deletedPackage, Package pkg, int parseFlags, int scanFlags, UserHandle user, int[] allUsers, boolean[] perUserInstalled, String installerPackageName, PackageInstalledInfo res) {
        long origUpdateTime;
        String pkgName = deletedPackage.packageName;
        boolean deletedPkg = DEFAULT_VERIFY_ENABLE;
        boolean updatedSettings = DEBUG_VERIFY;
        if (pkg.mExtras != null) {
            origUpdateTime = ((PackageSetting) pkg.mExtras).lastUpdateTime;
        } else {
            origUpdateTime = 0;
        }
        if (deletePackageLI(pkgName, null, DEFAULT_VERIFY_ENABLE, null, null, UPDATE_PERMISSIONS_ALL, res.removedInfo, DEFAULT_VERIFY_ENABLE)) {
            if (isForwardLocked(deletedPackage) || isExternal(deletedPackage)) {
                int[] uidArray = new int[UPDATE_PERMISSIONS_ALL];
                uidArray[DEX_OPT_SKIPPED] = deletedPackage.applicationInfo.uid;
                ArrayList<String> pkgList = new ArrayList(UPDATE_PERMISSIONS_ALL);
                pkgList.add(deletedPackage.applicationInfo.packageName);
                sendResourcesChangedBroadcast(DEBUG_VERIFY, DEFAULT_VERIFY_ENABLE, pkgList, uidArray, null);
            }
            deleteCodeCacheDirsLI(pkgName);
            try {
                updateSettingsLI(scanPackageLI(pkg, parseFlags, scanFlags | SCAN_UPDATE_TIME, System.currentTimeMillis(), user), installerPackageName, allUsers, perUserInstalled, res);
                updatedSettings = DEFAULT_VERIFY_ENABLE;
            } catch (PackageManagerException e) {
                res.setError("Package couldn't be installed in " + pkg.codePath, e);
            }
        } else {
            res.setError(-10, "replaceNonSystemPackageLI");
            deletedPkg = DEBUG_VERIFY;
        }
        if (res.returnCode != UPDATE_PERMISSIONS_ALL) {
            if (updatedSettings) {
                deletePackageLI(pkgName, null, DEFAULT_VERIFY_ENABLE, allUsers, perUserInstalled, UPDATE_PERMISSIONS_ALL, res.removedInfo, DEFAULT_VERIFY_ENABLE);
            }
            if (deletedPkg) {
                try {
                    scanPackageLI(new File(deletedPackage.codePath), ((this.mDefParseFlags | UPDATE_PERMISSIONS_REPLACE_PKG) | (isForwardLocked(deletedPackage) ? SCAN_NEW_INSTALL : DEX_OPT_SKIPPED)) | (isExternal(deletedPackage) ? SCAN_NO_PATHS : DEX_OPT_SKIPPED), 72, origUpdateTime, null);
                    synchronized (this.mPackages) {
                        updatePermissionsLPw(deletedPackage.packageName, deletedPackage, UPDATE_PERMISSIONS_ALL);
                        this.mSettings.writeLPr();
                    }
                    Slog.i(TAG, "Successfully restored package : " + pkgName + " after failed upgrade");
                } catch (PackageManagerException e2) {
                    Slog.e(TAG, "Failed to restore package : " + pkgName + " after failed upgrade: " + e2.getMessage());
                }
            }
        }
    }

    private void replaceSystemPackageLI(Package deletedPackage, Package pkg, int parseFlags, int scanFlags, UserHandle user, int[] allUsers, boolean[] perUserInstalled, String installerPackageName, PackageInstalledInfo res) {
        Package newPackage;
        PackageManagerException e;
        boolean updatedSettings = DEBUG_VERIFY;
        parseFlags |= UPDATE_PERMISSIONS_ALL;
        if ((deletedPackage.applicationInfo.flags & 1073741824) != 0) {
            parseFlags |= SCAN_DEFER_DEX;
        }
        String packageName = deletedPackage.packageName;
        if (packageName == null) {
            res.setError(-10, "Attempt to delete null packageName.");
            return;
        }
        synchronized (this.mPackages) {
            Package oldPkg = (Package) this.mPackages.get(packageName);
            PackageSetting oldPkgSetting = (PackageSetting) this.mSettings.mPackages.get(packageName);
            if (oldPkg == null || oldPkg.applicationInfo == null || oldPkgSetting == null) {
                res.setError(-10, "Couldn't find package:" + packageName + " information");
                return;
            }
            killApplication(packageName, oldPkg.applicationInfo.uid, "replace sys pkg");
            res.removedInfo.uid = oldPkg.applicationInfo.uid;
            res.removedInfo.removedPackage = packageName;
            removePackageLI(oldPkgSetting, DEFAULT_VERIFY_ENABLE);
            synchronized (this.mPackages) {
                boolean disabledSystem = this.mSettings.disableSystemPackageLPw(packageName);
                if (disabledSystem || deletedPackage == null) {
                    res.removedInfo.args = null;
                } else {
                    res.removedInfo.args = createInstallArgsForExisting(DEX_OPT_SKIPPED, deletedPackage.applicationInfo.getCodePath(), deletedPackage.applicationInfo.getResourcePath(), deletedPackage.applicationInfo.nativeLibraryRootDir, getAppDexInstructionSets(deletedPackage.applicationInfo));
                }
            }
            deleteCodeCacheDirsLI(packageName);
            res.returnCode = UPDATE_PERMISSIONS_ALL;
            ApplicationInfo applicationInfo = pkg.applicationInfo;
            applicationInfo.flags |= SCAN_DEFER_DEX;
            try {
                newPackage = scanPackageLI(pkg, parseFlags, scanFlags, 0, user);
                try {
                    if (newPackage.mExtras != null) {
                        PackageSetting newPkgSetting = newPackage.mExtras;
                        newPkgSetting.firstInstallTime = oldPkgSetting.firstInstallTime;
                        newPkgSetting.lastUpdateTime = System.currentTimeMillis();
                        if (oldPkgSetting.sharedUser != newPkgSetting.sharedUser) {
                            res.setError(-8, "Forbidding shared user change from " + oldPkgSetting.sharedUser + " to " + newPkgSetting.sharedUser);
                            updatedSettings = DEFAULT_VERIFY_ENABLE;
                        }
                    }
                    if (res.returnCode == UPDATE_PERMISSIONS_ALL) {
                        updateSettingsLI(newPackage, installerPackageName, allUsers, perUserInstalled, res);
                        updatedSettings = DEFAULT_VERIFY_ENABLE;
                    }
                } catch (PackageManagerException e2) {
                    e = e2;
                    res.setError("Package couldn't be installed in " + pkg.codePath, e);
                    if (res.returnCode == UPDATE_PERMISSIONS_ALL) {
                        if (newPackage != null) {
                            removeInstalledPackageLI(newPackage, DEFAULT_VERIFY_ENABLE);
                        }
                        try {
                            scanPackageLI(oldPkg, parseFlags, (int) SCAN_UPDATE_SIGNATURE, 0, user);
                        } catch (PackageManagerException e3) {
                            Slog.e(TAG, "Failed to restore original package: " + e3.getMessage());
                        }
                        synchronized (this.mPackages) {
                            if (disabledSystem) {
                                this.mSettings.enableSystemPackageLPw(packageName);
                            }
                            if (updatedSettings) {
                                this.mSettings.setInstallerPackageName(packageName, oldPkgSetting.installerPackageName);
                            }
                            this.mSettings.writeLPr();
                        }
                    }
                }
            } catch (PackageManagerException e4) {
                e3 = e4;
                newPackage = null;
                res.setError("Package couldn't be installed in " + pkg.codePath, e3);
                if (res.returnCode == UPDATE_PERMISSIONS_ALL) {
                    if (newPackage != null) {
                        removeInstalledPackageLI(newPackage, DEFAULT_VERIFY_ENABLE);
                    }
                    scanPackageLI(oldPkg, parseFlags, (int) SCAN_UPDATE_SIGNATURE, 0, user);
                    synchronized (this.mPackages) {
                        if (disabledSystem) {
                            this.mSettings.enableSystemPackageLPw(packageName);
                        }
                        if (updatedSettings) {
                            this.mSettings.setInstallerPackageName(packageName, oldPkgSetting.installerPackageName);
                        }
                        this.mSettings.writeLPr();
                    }
                }
            }
            if (res.returnCode == UPDATE_PERMISSIONS_ALL) {
                if (newPackage != null) {
                    removeInstalledPackageLI(newPackage, DEFAULT_VERIFY_ENABLE);
                }
                scanPackageLI(oldPkg, parseFlags, (int) SCAN_UPDATE_SIGNATURE, 0, user);
                synchronized (this.mPackages) {
                    if (disabledSystem) {
                        this.mSettings.enableSystemPackageLPw(packageName);
                    }
                    if (updatedSettings) {
                        this.mSettings.setInstallerPackageName(packageName, oldPkgSetting.installerPackageName);
                    }
                    this.mSettings.writeLPr();
                }
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void updateSettingsLI(android.content.pm.PackageParser.Package r11, java.lang.String r12, int[] r13, boolean[] r14, com.android.server.pm.PackageManagerService.PackageInstalledInfo r15) {
        /*
        r10 = this;
        r4 = r11.packageName;
        r8 = r10.mPackages;
        monitor-enter(r8);
        r7 = r10.mSettings;	 Catch:{ all -> 0x0049 }
        r9 = 0;
        r7.setInstallStatus(r4, r9);	 Catch:{ all -> 0x0049 }
        r7 = r10.mSettings;	 Catch:{ all -> 0x0049 }
        r7.writeLPr();	 Catch:{ all -> 0x0049 }
        monitor-exit(r8);	 Catch:{ all -> 0x0049 }
        r8 = r10.mPackages;
        monitor-enter(r8);
        r9 = r11.packageName;	 Catch:{ all -> 0x007f }
        r7 = r11.permissions;	 Catch:{ all -> 0x007f }
        r7 = r7.size();	 Catch:{ all -> 0x007f }
        if (r7 <= 0) goto L_0x004c;
    L_0x001e:
        r7 = 1;
    L_0x001f:
        r7 = r7 | 2;
        r10.updatePermissionsLPw(r9, r11, r7);	 Catch:{ all -> 0x007f }
        r7 = isSystemApp(r11);	 Catch:{ all -> 0x007f }
        if (r7 == 0) goto L_0x0060;
    L_0x002a:
        r7 = r10.mSettings;	 Catch:{ all -> 0x007f }
        r7 = r7.mPackages;	 Catch:{ all -> 0x007f }
        r5 = r7.get(r4);	 Catch:{ all -> 0x007f }
        r5 = (com.android.server.pm.PackageSetting) r5;	 Catch:{ all -> 0x007f }
        if (r5 == 0) goto L_0x0060;
    L_0x0036:
        r7 = r15.origUsers;	 Catch:{ all -> 0x007f }
        if (r7 == 0) goto L_0x004e;
    L_0x003a:
        r0 = r15.origUsers;	 Catch:{ all -> 0x007f }
        r3 = r0.length;	 Catch:{ all -> 0x007f }
        r2 = 0;
    L_0x003e:
        if (r2 >= r3) goto L_0x004e;
    L_0x0040:
        r6 = r0[r2];	 Catch:{ all -> 0x007f }
        r7 = 0;
        r5.setEnabled(r7, r6, r12);	 Catch:{ all -> 0x007f }
        r2 = r2 + 1;
        goto L_0x003e;
    L_0x0049:
        r7 = move-exception;
        monitor-exit(r8);	 Catch:{ all -> 0x0049 }
        throw r7;
    L_0x004c:
        r7 = 0;
        goto L_0x001f;
    L_0x004e:
        if (r13 == 0) goto L_0x0060;
    L_0x0050:
        if (r14 == 0) goto L_0x0060;
    L_0x0052:
        r1 = 0;
    L_0x0053:
        r7 = r13.length;	 Catch:{ all -> 0x007f }
        if (r1 >= r7) goto L_0x0060;
    L_0x0056:
        r7 = r14[r1];	 Catch:{ all -> 0x007f }
        r9 = r13[r1];	 Catch:{ all -> 0x007f }
        r5.setInstalled(r7, r9);	 Catch:{ all -> 0x007f }
        r1 = r1 + 1;
        goto L_0x0053;
    L_0x0060:
        r15.name = r4;	 Catch:{ all -> 0x007f }
        r7 = r11.applicationInfo;	 Catch:{ all -> 0x007f }
        r7 = r7.uid;	 Catch:{ all -> 0x007f }
        r15.uid = r7;	 Catch:{ all -> 0x007f }
        r15.pkg = r11;	 Catch:{ all -> 0x007f }
        r7 = r10.mSettings;	 Catch:{ all -> 0x007f }
        r9 = 1;
        r7.setInstallStatus(r4, r9);	 Catch:{ all -> 0x007f }
        r7 = r10.mSettings;	 Catch:{ all -> 0x007f }
        r7.setInstallerPackageName(r4, r12);	 Catch:{ all -> 0x007f }
        r7 = 1;
        r15.returnCode = r7;	 Catch:{ all -> 0x007f }
        r7 = r10.mSettings;	 Catch:{ all -> 0x007f }
        r7.writeLPr();	 Catch:{ all -> 0x007f }
        monitor-exit(r8);	 Catch:{ all -> 0x007f }
        return;
    L_0x007f:
        r7 = move-exception;
        monitor-exit(r8);	 Catch:{ all -> 0x007f }
        throw r7;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageManagerService.updateSettingsLI(android.content.pm.PackageParser$Package, java.lang.String, int[], boolean[], com.android.server.pm.PackageManagerService$PackageInstalledInfo):void");
    }

    private void installPackageLI(InstallArgs args, PackageInstalledInfo res) {
        int installFlags = args.installFlags;
        String installerPackageName = args.installerPackageName;
        File file = new File(args.getCodePath());
        boolean forwardLocked = (installFlags & UPDATE_PERMISSIONS_ALL) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
        boolean onSd = (installFlags & SCAN_UPDATE_SIGNATURE) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
        boolean replace = DEBUG_VERIFY;
        res.returnCode = UPDATE_PERMISSIONS_ALL;
        if (DEFAULT_VERIFY_ENABLE != this.mSecurityBridge.approveAppInstallRequest(args.getResourcePath(), Uri.fromFile(args.origin.file).toSafeString())) {
            res.returnCode = -22;
            return;
        }
        int parseFlags = ((this.mDefParseFlags | UPDATE_PERMISSIONS_REPLACE_PKG) | (forwardLocked ? SCAN_NEW_INSTALL : DEX_OPT_SKIPPED)) | (onSd ? SCAN_NO_PATHS : DEX_OPT_SKIPPED);
        PackageParser pp = new PackageParser();
        pp.setSeparateProcesses(this.mSeparateProcesses);
        pp.setDisplayMetrics(this.mMetrics);
        try {
            Package pkg = pp.parsePackage(file, parseFlags);
            pkg.cpuAbiOverride = args.abiOverride;
            String pkgName = pkg.packageName;
            res.name = pkgName;
            if ((pkg.applicationInfo.flags & SCAN_BOOTING) == 0 || (installFlags & UPDATE_PERMISSIONS_REPLACE_ALL) != 0) {
                try {
                    pp.collectCertificates(pkg, parseFlags);
                    pp.collectManifestDigest(pkg);
                    if (args.manifestDigest == null || args.manifestDigest.equals(pkg.manifestDigest)) {
                        String oldCodePath = null;
                        boolean systemApp = DEBUG_VERIFY;
                        synchronized (this.mPackages) {
                            if ((installFlags & UPDATE_PERMISSIONS_REPLACE_PKG) != 0) {
                                String oldName = (String) this.mSettings.mRenamedPackages.get(pkgName);
                                if (pkg.mOriginalPackages != null && pkg.mOriginalPackages.contains(oldName) && this.mPackages.containsKey(oldName)) {
                                    pkg.setPackageName(oldName);
                                    pkgName = pkg.packageName;
                                    replace = DEFAULT_VERIFY_ENABLE;
                                } else if (this.mPackages.containsKey(pkgName)) {
                                    replace = DEFAULT_VERIFY_ENABLE;
                                }
                            }
                            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(pkgName);
                            if (ps != null) {
                                if (!ps.keySetData.isUsingUpgradeKeySets() || ps.sharedUser != null) {
                                    try {
                                        verifySignaturesLP(ps, pkg);
                                    } catch (PackageManagerException e) {
                                        res.setError(e.error, e.getMessage());
                                        return;
                                    }
                                } else if (!checkUpgradeKeySetLP(ps, pkg)) {
                                    res.setError(-7, "Package " + pkg.packageName + " upgrade keys do not match the " + "previously installed version");
                                    return;
                                }
                                oldCodePath = ((PackageSetting) this.mSettings.mPackages.get(pkgName)).codePathString;
                                if (!(ps.pkg == null || ps.pkg.applicationInfo == null)) {
                                    systemApp = (ps.pkg.applicationInfo.flags & UPDATE_PERMISSIONS_ALL) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
                                }
                                res.origUsers = ps.queryInstalledUsers(sUserManager.getUserIds(), DEFAULT_VERIFY_ENABLE);
                            }
                            for (int i = pkg.permissions.size() + DEX_OPT_FAILED; i >= 0; i += DEX_OPT_FAILED) {
                                Permission perm = (Permission) pkg.permissions.get(i);
                                BasePermission bp = (BasePermission) this.mSettings.mPermissions.get(perm.info.name);
                                if (bp != null) {
                                    boolean sigsOk = (bp.sourcePackage.equals(pkg.packageName) && (bp.packageSetting instanceof PackageSetting) && bp.packageSetting.keySetData.isUsingUpgradeKeySets() && ((PackageSetting) bp.packageSetting).sharedUser == null) ? checkUpgradeKeySetLP((PackageSetting) bp.packageSetting, pkg) : compareSignatures(bp.packageSetting.signatures.mSignatures, pkg.mSignatures) == 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
                                    if (sigsOk) {
                                        continue;
                                    } else if (bp.sourcePackage.equals("android")) {
                                        Slog.w(TAG, "Package " + pkg.packageName + " attempting to redeclare system permission " + perm.info.name + "; ignoring new declaration");
                                        pkg.permissions.remove(i);
                                    } else {
                                        res.setError(-112, "Package " + pkg.packageName + " attempting to redeclare permission " + perm.info.name + " already owned by " + bp.sourcePackage);
                                        res.origPermission = perm.info.name;
                                        res.origPackage = bp.sourcePackage;
                                        return;
                                    }
                                }
                            }
                            if (systemApp && onSd) {
                                res.setError(-19, "Cannot install updates to system apps on sdcard");
                                return;
                            }
                            if (args.doRename(res.returnCode, pkg, oldCodePath)) {
                                if (replace) {
                                    replacePackageLI(pkg, parseFlags, 2076, args.user, installerPackageName, res);
                                } else {
                                    installNewPackageLI(pkg, parseFlags, 1052, args.user, installerPackageName, res);
                                }
                                synchronized (this.mPackages) {
                                    ps = (PackageSetting) this.mSettings.mPackages.get(pkgName);
                                    if (ps != null) {
                                        res.newUsers = ps.queryInstalledUsers(sUserManager.getUserIds(), DEFAULT_VERIFY_ENABLE);
                                    }
                                }
                                return;
                            }
                            res.setError(-4, "Failed rename");
                            return;
                        }
                    }
                    res.setError(-23, "Manifest digest changed");
                    return;
                } catch (PackageParserException e2) {
                    res.setError("Failed collect during installPackageLI", e2);
                    return;
                }
            }
            res.setError(-15, "installPackageLI");
        } catch (PackageParserException e22) {
            res.setError("Failed parse during installPackageLI", e22);
        }
    }

    private static boolean isForwardLocked(Package pkg) {
        return (pkg.applicationInfo.flags & 536870912) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isForwardLocked(ApplicationInfo info) {
        return (info.flags & 536870912) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private boolean isForwardLocked(PackageSetting ps) {
        return (ps.pkgFlags & 536870912) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isMultiArch(PackageSetting ps) {
        return (ps.pkgFlags & SoundTriggerHelper.STATUS_ERROR) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isMultiArch(ApplicationInfo info) {
        return (info.flags & SoundTriggerHelper.STATUS_ERROR) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isExternal(Package pkg) {
        return (pkg.applicationInfo.flags & 262144) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isExternal(PackageSetting ps) {
        return (ps.pkgFlags & 262144) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isExternal(ApplicationInfo info) {
        return (info.flags & 262144) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isSystemApp(Package pkg) {
        return (pkg.applicationInfo.flags & UPDATE_PERMISSIONS_ALL) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isPrivilegedApp(Package pkg) {
        return (pkg.applicationInfo.flags & 1073741824) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isSystemApp(ApplicationInfo info) {
        return (info.flags & UPDATE_PERMISSIONS_ALL) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isSystemApp(PackageSetting ps) {
        return (ps.pkgFlags & UPDATE_PERMISSIONS_ALL) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isUpdatedSystemApp(PackageSetting ps) {
        return (ps.pkgFlags & SCAN_DEFER_DEX) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isUpdatedSystemApp(Package pkg) {
        return (pkg.applicationInfo.flags & SCAN_DEFER_DEX) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private static boolean isUpdatedSystemApp(ApplicationInfo info) {
        return (info.flags & SCAN_DEFER_DEX) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
    }

    private int packageFlagsToInstallFlags(PackageSetting ps) {
        int installFlags = DEX_OPT_SKIPPED;
        if (isExternal(ps)) {
            installFlags = DEX_OPT_SKIPPED | SCAN_UPDATE_SIGNATURE;
        }
        if (isForwardLocked(ps)) {
            return installFlags | UPDATE_PERMISSIONS_ALL;
        }
        return installFlags;
    }

    private void deleteTempPackageFiles() {
        File[] arr$ = this.mDrmAppPrivateInstallDir.listFiles(new C04537());
        int len$ = arr$.length;
        for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
            arr$[i$].delete();
        }
    }

    public void deletePackageAsUser(String packageName, IPackageDeleteObserver observer, int userId, int flags) {
        deletePackage(packageName, new LegacyPackageDeleteObserver(observer).getBinder(), userId, flags);
    }

    public void deletePackage(String packageName, IPackageDeleteObserver2 observer, int userId, int flags) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DELETE_PACKAGES", null);
        if (UserHandle.getUserId(Binder.getCallingUid()) != userId) {
            this.mContext.enforceCallingPermission("android.permission.INTERACT_ACROSS_USERS_FULL", "deletePackage for user " + userId);
        }
        if (isUserRestricted(userId, "no_uninstall_apps")) {
            try {
                observer.onPackageDeleted(packageName, -3, null);
                return;
            } catch (RemoteException e) {
                return;
            }
        }
        boolean uninstallBlocked = DEBUG_VERIFY;
        if ((flags & UPDATE_PERMISSIONS_REPLACE_PKG) != 0) {
            int[] users = sUserManager.getUserIds();
            for (int i = DEX_OPT_SKIPPED; i < users.length; i += UPDATE_PERMISSIONS_ALL) {
                if (getBlockUninstallForUser(packageName, users[i])) {
                    uninstallBlocked = DEFAULT_VERIFY_ENABLE;
                    break;
                }
            }
        } else {
            uninstallBlocked = getBlockUninstallForUser(packageName, userId);
        }
        if (uninstallBlocked) {
            try {
                observer.onPackageDeleted(packageName, -4, null);
                return;
            } catch (RemoteException e2) {
                return;
            }
        }
        this.mHandler.post(new C04548(packageName, userId, flags, observer));
    }

    private boolean isPackageDeviceAdmin(String packageName, int userId) {
        IDevicePolicyManager dpm = IDevicePolicyManager.Stub.asInterface(ServiceManager.getService("device_policy"));
        if (dpm != null) {
            try {
                if (dpm.isDeviceOwner(packageName)) {
                    return DEFAULT_VERIFY_ENABLE;
                }
                int[] users;
                if (userId == DEX_OPT_FAILED) {
                    users = sUserManager.getUserIds();
                } else {
                    users = new int[UPDATE_PERMISSIONS_ALL];
                    users[DEX_OPT_SKIPPED] = userId;
                }
                for (int i = DEX_OPT_SKIPPED; i < users.length; i += UPDATE_PERMISSIONS_ALL) {
                    if (dpm.packageHasActiveAdmins(packageName, users[i])) {
                        return DEFAULT_VERIFY_ENABLE;
                    }
                }
            } catch (RemoteException e) {
            }
        }
        return DEBUG_VERIFY;
    }

    private int deletePackageX(String packageName, int userId, int flags) {
        PackageRemovedInfo info = new PackageRemovedInfo();
        UserHandle removeForUser = (flags & UPDATE_PERMISSIONS_REPLACE_PKG) != 0 ? UserHandle.ALL : new UserHandle(userId);
        if (isPackageDeviceAdmin(packageName, removeForUser.getIdentifier())) {
            Slog.w(TAG, "Not removing package " + packageName + ": has active device admin");
            return -2;
        }
        boolean removedForAllUsers = DEBUG_VERIFY;
        synchronized (this.mPackages) {
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
            int[] allUsers = sUserManager.getUserIds();
            boolean[] perUserInstalled = new boolean[allUsers.length];
            for (int i = DEX_OPT_SKIPPED; i < allUsers.length; i += UPDATE_PERMISSIONS_ALL) {
                perUserInstalled[i] = ps != null ? ps.getInstalled(allUsers[i]) : DEBUG_VERIFY;
            }
        }
        synchronized (this.mInstallLock) {
            boolean res = deletePackageLI(packageName, removeForUser, DEFAULT_VERIFY_ENABLE, allUsers, perUserInstalled, flags | REMOVE_CHATTY, info, DEFAULT_VERIFY_ENABLE);
            boolean systemUpdate = info.isRemovedPackageSystemUpdate;
            if (res && !systemUpdate && this.mPackages.get(packageName) == null) {
                removedForAllUsers = DEFAULT_VERIFY_ENABLE;
            }
        }
        if (res) {
            info.sendBroadcast(DEFAULT_VERIFY_ENABLE, systemUpdate, removedForAllUsers);
            if (systemUpdate) {
                Bundle extras = new Bundle(UPDATE_PERMISSIONS_ALL);
                extras.putInt("android.intent.extra.UID", info.removedAppId >= 0 ? info.removedAppId : info.uid);
                extras.putBoolean("android.intent.extra.REPLACING", DEFAULT_VERIFY_ENABLE);
                sendPackageBroadcast("android.intent.action.PACKAGE_ADDED", packageName, extras, null, null, null);
                sendPackageBroadcast("android.intent.action.PACKAGE_REPLACED", packageName, extras, null, null, null);
                sendPackageBroadcast("android.intent.action.MY_PACKAGE_REPLACED", null, null, packageName, null, null);
            }
        }
        Runtime.getRuntime().gc();
        if (info.args != null) {
            synchronized (this.mInstallLock) {
                info.args.doPostDeleteLI(DEFAULT_VERIFY_ENABLE);
            }
        }
        if (res) {
            return UPDATE_PERMISSIONS_ALL;
        }
        return DEX_OPT_FAILED;
    }

    private void removePackageDataLI(PackageSetting ps, int[] allUserHandles, boolean[] perUserInstalled, PackageRemovedInfo outInfo, int flags, boolean writeSettings) {
        boolean z = DEBUG_VERIFY;
        String packageName = ps.name;
        if ((REMOVE_CHATTY & flags) != 0) {
            z = DEFAULT_VERIFY_ENABLE;
        }
        removePackageLI(ps, z);
        synchronized (this.mPackages) {
            PackageSetting deletedPs = (PackageSetting) this.mSettings.mPackages.get(packageName);
            if (outInfo != null) {
                int[] queryInstalledUsers;
                outInfo.removedPackage = packageName;
                if (deletedPs != null) {
                    queryInstalledUsers = deletedPs.queryInstalledUsers(sUserManager.getUserIds(), DEFAULT_VERIFY_ENABLE);
                } else {
                    queryInstalledUsers = null;
                }
                outInfo.removedUsers = queryInstalledUsers;
            }
        }
        if ((flags & UPDATE_PERMISSIONS_ALL) == 0) {
            removeDataDirsLI(packageName);
            schedulePackageCleaning(packageName, DEX_OPT_FAILED, DEFAULT_VERIFY_ENABLE);
        }
        synchronized (this.mPackages) {
            if (deletedPs != null) {
                if ((flags & UPDATE_PERMISSIONS_ALL) == 0) {
                    if (outInfo != null) {
                        this.mSettings.mKeySetManagerService.removeAppKeySetDataLPw(packageName);
                        outInfo.removedAppId = this.mSettings.removePackageLPw(packageName);
                    }
                    if (deletedPs != null) {
                        updatePermissionsLPw(deletedPs.name, null, DEX_OPT_SKIPPED);
                        if (deletedPs.sharedUser != null) {
                            this.mSettings.updateSharedUserPermsLPw(deletedPs, this.mGlobalGids);
                        }
                    }
                    clearPackagePreferredActivitiesLPw(deletedPs.name, DEX_OPT_FAILED);
                }
                if (!(allUserHandles == null || perUserInstalled == null)) {
                    for (int i = DEX_OPT_SKIPPED; i < allUserHandles.length; i += UPDATE_PERMISSIONS_ALL) {
                        ps.setInstalled(perUserInstalled[i], allUserHandles[i]);
                    }
                }
            }
            if (writeSettings) {
                this.mSettings.writeLPr();
            }
        }
        if (outInfo != null) {
            removeKeystoreDataIfNeeded(DEX_OPT_FAILED, outInfo.removedAppId);
        }
    }

    static boolean locationIsPrivileged(File path) {
        try {
            return path.getCanonicalPath().startsWith(new File(Environment.getRootDirectory(), "priv-app").getCanonicalPath());
        } catch (IOException e) {
            Slog.e(TAG, "Unable to access code path " + path);
            return DEBUG_VERIFY;
        }
    }

    private boolean deleteSystemPackageLI(PackageSetting newPs, int[] allUserHandles, boolean[] perUserInstalled, int flags, PackageRemovedInfo outInfo, boolean writeSettings) {
        boolean applyUserRestrictions = (allUserHandles == null || perUserInstalled == null) ? DEBUG_VERIFY : DEFAULT_VERIFY_ENABLE;
        synchronized (this.mPackages) {
            PackageSetting disabledPs = this.mSettings.getDisabledSystemPkgLPr(newPs.name);
        }
        if (disabledPs == null) {
            Slog.w(TAG, "Attempt to delete unknown system package " + newPs.name);
            return DEBUG_VERIFY;
        }
        outInfo.isRemovedPackageSystemUpdate = DEFAULT_VERIFY_ENABLE;
        if (disabledPs.versionCode < newPs.versionCode) {
            flags &= -2;
        } else {
            flags |= UPDATE_PERMISSIONS_ALL;
        }
        if (!deleteInstalledPackageLI(newPs, DEFAULT_VERIFY_ENABLE, flags, allUserHandles, perUserInstalled, outInfo, writeSettings)) {
            return DEBUG_VERIFY;
        }
        synchronized (this.mPackages) {
            this.mSettings.enableSystemPackageLPw(newPs.name);
            NativeLibraryHelper.removeNativeBinariesLI(newPs.legacyNativeLibraryPathString);
        }
        int parseFlags = INIT_COPY;
        if (locationIsPrivileged(disabledPs.codePath)) {
            parseFlags = INIT_COPY | SCAN_DEFER_DEX;
        }
        try {
            Package newPkg = scanPackageLI(disabledPs.codePath, parseFlags, (int) SCAN_NO_PATHS, 0, null);
            synchronized (this.mPackages) {
                PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(newPkg.packageName);
                updatePermissionsLPw(newPkg.packageName, newPkg, MCS_BOUND);
                if (applyUserRestrictions) {
                    for (int i = DEX_OPT_SKIPPED; i < allUserHandles.length; i += UPDATE_PERMISSIONS_ALL) {
                        ps.setInstalled(perUserInstalled[i], allUserHandles[i]);
                    }
                    this.mSettings.writeAllUsersPackageRestrictionsLPr();
                }
                if (writeSettings) {
                    this.mSettings.writeLPr();
                }
            }
            return DEFAULT_VERIFY_ENABLE;
        } catch (PackageManagerException e) {
            Slog.w(TAG, "Failed to restore system package:" + newPs.name + ": " + e.getMessage());
            return DEBUG_VERIFY;
        }
    }

    private boolean deleteInstalledPackageLI(PackageSetting ps, boolean deleteCodeAndResources, int flags, int[] allUserHandles, boolean[] perUserInstalled, PackageRemovedInfo outInfo, boolean writeSettings) {
        if (outInfo != null) {
            outInfo.uid = ps.appId;
        }
        removePackageDataLI(ps, allUserHandles, perUserInstalled, outInfo, flags, writeSettings);
        if (deleteCodeAndResources && outInfo != null) {
            outInfo.args = createInstallArgsForExisting(packageFlagsToInstallFlags(ps), ps.codePathString, ps.resourcePathString, ps.legacyNativeLibraryPathString, getAppDexInstructionSets(ps));
        }
        return DEFAULT_VERIFY_ENABLE;
    }

    public boolean setBlockUninstallForUser(String packageName, boolean blockUninstall, int userId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DELETE_PACKAGES", null);
        synchronized (this.mPackages) {
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
            if (ps == null) {
                Log.i(TAG, "Package doesn't exist in set block uninstall " + packageName);
                return DEBUG_VERIFY;
            } else if (ps.getInstalled(userId)) {
                ps.setBlockUninstall(blockUninstall, userId);
                this.mSettings.writePackageRestrictionsLPr(userId);
                return DEFAULT_VERIFY_ENABLE;
            } else {
                Log.i(TAG, "Package not installed in set block uninstall " + packageName);
                return DEBUG_VERIFY;
            }
        }
    }

    public boolean getBlockUninstallForUser(String packageName, int userId) {
        boolean z;
        synchronized (this.mPackages) {
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
            if (ps == null) {
                Log.i(TAG, "Package doesn't exist in get block uninstall " + packageName);
                z = DEBUG_VERIFY;
            } else {
                z = ps.getBlockUninstall(userId);
            }
        }
        return z;
    }

    private boolean deletePackageLI(String packageName, UserHandle user, boolean deleteCodeAndResources, int[] allUserHandles, boolean[] perUserInstalled, int flags, PackageRemovedInfo outInfo, boolean writeSettings) {
        if (packageName == null) {
            Slog.w(TAG, "Attempt to delete null packageName.");
            return DEBUG_VERIFY;
        }
        int removeUser = DEX_OPT_FAILED;
        int appId = DEX_OPT_FAILED;
        synchronized (this.mPackages) {
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
            if (ps == null) {
                Slog.w(TAG, "Package named '" + packageName + "' doesn't exist.");
                return DEBUG_VERIFY;
            }
            if (!((isSystemApp(ps) && (flags & UPDATE_PERMISSIONS_REPLACE_ALL) == 0) || user == null || user.getIdentifier() == DEX_OPT_FAILED)) {
                ps.setUserState(user.getIdentifier(), DEX_OPT_SKIPPED, DEBUG_VERIFY, DEFAULT_VERIFY_ENABLE, DEFAULT_VERIFY_ENABLE, DEBUG_VERIFY, null, null, null, DEBUG_VERIFY);
                if (isSystemApp(ps)) {
                    removeUser = user.getIdentifier();
                    appId = ps.appId;
                    this.mSettings.writePackageRestrictionsLPr(removeUser);
                } else if (ps.isAnyInstalled(sUserManager.getUserIds())) {
                    removeUser = user.getIdentifier();
                    appId = ps.appId;
                    this.mSettings.writePackageRestrictionsLPr(removeUser);
                } else {
                    ps.setInstalled(DEFAULT_VERIFY_ENABLE, user.getIdentifier());
                }
            }
            if (removeUser >= 0) {
                if (outInfo != null) {
                    outInfo.removedPackage = packageName;
                    outInfo.removedAppId = appId;
                    int[] iArr = new int[UPDATE_PERMISSIONS_ALL];
                    iArr[DEX_OPT_SKIPPED] = removeUser;
                    outInfo.removedUsers = iArr;
                }
                this.mInstaller.clearUserData(packageName, removeUser);
                removeKeystoreDataIfNeeded(removeUser, appId);
                schedulePackageCleaning(packageName, removeUser, DEBUG_VERIFY);
                return DEFAULT_VERIFY_ENABLE;
            } else if (DEBUG_VERIFY) {
                removePackageDataLI(ps, null, null, outInfo, flags, writeSettings);
                return DEFAULT_VERIFY_ENABLE;
            } else if (isSystemApp(ps)) {
                return deleteSystemPackageLI(ps, allUserHandles, perUserInstalled, flags, outInfo, writeSettings);
            } else {
                killApplication(packageName, ps.appId, "uninstall pkg");
                return deleteInstalledPackageLI(ps, deleteCodeAndResources, flags, allUserHandles, perUserInstalled, outInfo, writeSettings);
            }
        }
    }

    private void clearExternalStorageDataSync(String packageName, int userId, boolean allData) {
        boolean mounted;
        if (Environment.isExternalStorageEmulated()) {
            mounted = DEFAULT_VERIFY_ENABLE;
        } else {
            String status = Environment.getExternalStorageState();
            if (!status.equals("mounted")) {
                if (!status.equals("mounted_ro")) {
                    mounted = DEBUG_VERIFY;
                }
            }
            mounted = DEFAULT_VERIFY_ENABLE;
        }
        if (mounted) {
            int[] users;
            Intent containerIntent = new Intent().setComponent(DEFAULT_CONTAINER_COMPONENT);
            if (userId == DEX_OPT_FAILED) {
                users = sUserManager.getUserIds();
            } else {
                users = new int[UPDATE_PERMISSIONS_ALL];
                users[DEX_OPT_SKIPPED] = userId;
            }
            ClearStorageConnection conn = new ClearStorageConnection(null);
            if (this.mContext.bindServiceAsUser(containerIntent, conn, UPDATE_PERMISSIONS_ALL, UserHandle.OWNER)) {
                int[] arr$ = users;
                int len$ = arr$.length;
                int i$ = DEX_OPT_SKIPPED;
                while (i$ < len$) {
                    int curUser = arr$[i$];
                    long timeout = SystemClock.uptimeMillis() + 5000;
                    synchronized (conn) {
                        long now = SystemClock.uptimeMillis();
                        while (conn.mContainerService == null && now < timeout) {
                            try {
                                conn.wait(timeout - now);
                            } catch (InterruptedException e) {
                            }
                        }
                    }
                    try {
                        if (conn.mContainerService != null) {
                            UserEnvironment userEnvironment = new UserEnvironment(curUser);
                            clearDirectory(conn.mContainerService, userEnvironment.buildExternalStorageAppCacheDirs(packageName));
                            if (allData) {
                                clearDirectory(conn.mContainerService, userEnvironment.buildExternalStorageAppDataDirs(packageName));
                                clearDirectory(conn.mContainerService, userEnvironment.buildExternalStorageAppMediaDirs(packageName));
                            }
                            i$ += UPDATE_PERMISSIONS_ALL;
                        } else {
                            return;
                        }
                    } finally {
                        this.mContext.unbindService(conn);
                    }
                }
                this.mContext.unbindService(conn);
            }
        }
    }

    public void clearApplicationUserData(String packageName, IPackageDataObserver observer, int userId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CLEAR_APP_USER_DATA", null);
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEFAULT_VERIFY_ENABLE, DEBUG_VERIFY, "clear application data");
        this.mHandler.post(new C04559(packageName, userId, observer));
    }

    private boolean clearApplicationUserDataLI(String packageName, int userId) {
        if (packageName == null) {
            Slog.w(TAG, "Attempt to delete null packageName.");
            return DEBUG_VERIFY;
        }
        synchronized (this.mPackages) {
            Package pkg = (Package) this.mPackages.get(packageName);
            if (pkg == null) {
                PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
                if (ps != null) {
                    pkg = ps.pkg;
                }
            }
        }
        if (pkg == null) {
            Slog.w(TAG, "Package named '" + packageName + "' doesn't exist.");
        }
        if (this.mInstaller.clearUserData(packageName, userId) < 0) {
            Slog.w(TAG, "Couldn't remove cache files for package: " + packageName);
            return DEBUG_VERIFY;
        } else if (pkg == null) {
            return DEBUG_VERIFY;
        } else {
            if (!(pkg == null || pkg.applicationInfo == null)) {
                removeKeystoreDataIfNeeded(userId, pkg.applicationInfo.uid);
            }
            if (!(pkg == null || pkg.applicationInfo.primaryCpuAbi == null || VMRuntime.is64BitAbi(pkg.applicationInfo.primaryCpuAbi))) {
                if (this.mInstaller.linkNativeLibraryDirectory(pkg.packageName, pkg.applicationInfo.nativeLibraryDir, userId) < 0) {
                    Slog.w(TAG, "Failed linking native library dir");
                    return DEBUG_VERIFY;
                }
            }
            return DEFAULT_VERIFY_ENABLE;
        }
    }

    private static void removeKeystoreDataIfNeeded(int userId, int appId) {
        if (appId >= 0) {
            KeyStore keyStore = KeyStore.getInstance();
            if (keyStore == null) {
                Slog.w(TAG, "Could not contact keystore to clear entries for app id " + appId);
            } else if (userId == DEX_OPT_FAILED) {
                int[] arr$ = sUserManager.getUserIds();
                int len$ = arr$.length;
                for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
                    keyStore.clearUid(UserHandle.getUid(arr$[i$], appId));
                }
            } else {
                keyStore.clearUid(UserHandle.getUid(userId, appId));
            }
        }
    }

    public void deleteApplicationCacheFiles(String packageName, IPackageDataObserver observer) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DELETE_CACHE_FILES", null);
        this.mHandler.post(new AnonymousClass10(packageName, UserHandle.getCallingUserId(), observer));
    }

    private boolean deleteApplicationCacheFilesLI(String packageName, int userId) {
        if (packageName == null) {
            Slog.w(TAG, "Attempt to delete null packageName.");
            return DEBUG_VERIFY;
        }
        synchronized (this.mPackages) {
            Package p = (Package) this.mPackages.get(packageName);
        }
        if (p == null) {
            Slog.w(TAG, "Package named '" + packageName + "' doesn't exist.");
            return DEBUG_VERIFY;
        } else if (p.applicationInfo == null) {
            Slog.w(TAG, "Package " + packageName + " has no applicationInfo.");
            return DEBUG_VERIFY;
        } else if (this.mInstaller.deleteCacheFiles(packageName, userId) >= 0) {
            return DEFAULT_VERIFY_ENABLE;
        } else {
            Slog.w(TAG, "Couldn't remove cache files for package: " + packageName + " u" + userId);
            return DEBUG_VERIFY;
        }
    }

    public void getPackageSizeInfo(String packageName, int userHandle, IPackageStatsObserver observer) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.GET_PACKAGE_SIZE", null);
        if (packageName == null) {
            throw new IllegalArgumentException("Attempt to get size of null packageName");
        }
        PackageStats stats = new PackageStats(packageName, userHandle);
        Message msg = this.mHandler.obtainMessage(INIT_COPY);
        msg.obj = new MeasureParams(stats, observer);
        this.mHandler.sendMessage(msg);
    }

    private boolean getPackageSizeInfoLI(String packageName, int userHandle, PackageStats pStats) {
        if (packageName == null) {
            Slog.w(TAG, "Attempt to get size of null packageName.");
            return DEBUG_VERIFY;
        }
        boolean dataOnly = DEBUG_VERIFY;
        String libDirRoot = null;
        String asecPath = null;
        synchronized (this.mPackages) {
            Package p = (Package) this.mPackages.get(packageName);
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
            if (p == null) {
                dataOnly = DEFAULT_VERIFY_ENABLE;
                if (ps == null || ps.pkg == null) {
                    Slog.w(TAG, "Package named '" + packageName + "' doesn't exist.");
                    return DEBUG_VERIFY;
                }
                p = ps.pkg;
            }
            if (ps != null) {
                libDirRoot = ps.legacyNativeLibraryPathString;
            }
            if (p != null && (isExternal(p) || isForwardLocked(p))) {
                String secureContainerId = cidFromCodePath(p.applicationInfo.getBaseCodePath());
                if (secureContainerId != null) {
                    asecPath = PackageHelper.getSdFilesystem(secureContainerId);
                }
            }
            String publicSrcDir = null;
            if (!dataOnly) {
                ApplicationInfo applicationInfo = p.applicationInfo;
                if (applicationInfo == null) {
                    Slog.w(TAG, "Package " + packageName + " has no applicationInfo.");
                    return DEBUG_VERIFY;
                } else if (isForwardLocked(p)) {
                    publicSrcDir = applicationInfo.getBaseResourcePath();
                }
            }
            if (this.mInstaller.getSizeInfo(packageName, userHandle, p.baseCodePath, libDirRoot, publicSrcDir, asecPath, getDexCodeInstructionSets(getAppDexInstructionSets(ps)), pStats) < 0) {
                return DEBUG_VERIFY;
            }
            if (!isExternal(p)) {
                pStats.codeSize += pStats.externalCodeSize;
                pStats.externalCodeSize = 0;
            }
            return DEFAULT_VERIFY_ENABLE;
        }
    }

    public void addPackageToPreferred(String packageName) {
        Slog.w(TAG, "addPackageToPreferred: this is now a no-op");
    }

    public void removePackageFromPreferred(String packageName) {
        Slog.w(TAG, "removePackageFromPreferred: this is now a no-op");
    }

    public List<PackageInfo> getPreferredPackages(int flags) {
        return new ArrayList();
    }

    private int getUidTargetSdkVersionLockedLPr(int uid) {
        SharedUserSetting obj = this.mSettings.getUserIdLPr(uid);
        PackageSetting ps;
        if (obj instanceof SharedUserSetting) {
            SharedUserSetting sus = obj;
            int vers = WRITE_SETTINGS_DELAY;
            Iterator<PackageSetting> it = sus.packages.iterator();
            while (it.hasNext()) {
                ps = (PackageSetting) it.next();
                if (ps.pkg != null) {
                    int v = ps.pkg.applicationInfo.targetSdkVersion;
                    if (v < vers) {
                        vers = v;
                    }
                }
            }
            return vers;
        }
        if (obj instanceof PackageSetting) {
            ps = (PackageSetting) obj;
            if (ps.pkg != null) {
                return ps.pkg.applicationInfo.targetSdkVersion;
            }
        }
        return WRITE_SETTINGS_DELAY;
    }

    public void addPreferredActivity(IntentFilter filter, int match, ComponentName[] set, ComponentName activity, int userId) {
        addPreferredActivityInternal(filter, match, set, activity, DEFAULT_VERIFY_ENABLE, userId, "Adding preferred");
    }

    private void addPreferredActivityInternal(IntentFilter filter, int match, ComponentName[] set, ComponentName activity, boolean always, int userId, String opname) {
        int callingUid = Binder.getCallingUid();
        enforceCrossUserPermission(callingUid, userId, DEFAULT_VERIFY_ENABLE, DEBUG_VERIFY, "add preferred activity");
        if (filter.countActions() == 0) {
            Slog.w(TAG, "Cannot set a preferred activity with no filter actions");
            return;
        }
        synchronized (this.mPackages) {
            if (this.mContext.checkCallingOrSelfPermission("android.permission.SET_PREFERRED_APPLICATIONS") != 0) {
                if (getUidTargetSdkVersionLockedLPr(callingUid) < SCAN_UPDATE_SIGNATURE) {
                    Slog.w(TAG, "Ignoring addPreferredActivity() from uid " + callingUid);
                    return;
                }
                this.mContext.enforceCallingOrSelfPermission("android.permission.SET_PREFERRED_APPLICATIONS", null);
            }
            PreferredIntentResolver pir = this.mSettings.editPreferredActivitiesLPw(userId);
            Slog.i(TAG, opname + " activity " + activity.flattenToShortString() + " for user " + userId + ":");
            filter.dump(new LogPrinter(UPDATE_PERMISSIONS_REPLACE_ALL, TAG), "  ");
            pir.addFilter(new PreferredActivity(filter, match, set, activity, always));
            scheduleWritePackageRestrictionsLocked(userId);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void replacePreferredActivity(android.content.IntentFilter r18, int r19, android.content.ComponentName[] r20, android.content.ComponentName r21, int r22) {
        /*
        r17 = this;
        r1 = r18.countActions();
        r3 = 1;
        if (r1 == r3) goto L_0x000f;
    L_0x0007:
        r1 = new java.lang.IllegalArgumentException;
        r3 = "replacePreferredActivity expects filter to have only 1 action.";
        r1.<init>(r3);
        throw r1;
    L_0x000f:
        r1 = r18.countDataAuthorities();
        if (r1 != 0) goto L_0x0028;
    L_0x0015:
        r1 = r18.countDataPaths();
        if (r1 != 0) goto L_0x0028;
    L_0x001b:
        r1 = r18.countDataSchemes();
        r3 = 1;
        if (r1 > r3) goto L_0x0028;
    L_0x0022:
        r1 = r18.countDataTypes();
        if (r1 == 0) goto L_0x0030;
    L_0x0028:
        r1 = new java.lang.IllegalArgumentException;
        r3 = "replacePreferredActivity expects filter to have no data authorities, paths, or types; and at most one scheme.";
        r1.<init>(r3);
        throw r1;
    L_0x0030:
        r2 = android.os.Binder.getCallingUid();
        r4 = 1;
        r5 = 0;
        r6 = "replace preferred activity";
        r1 = r17;
        r3 = r22;
        r1.enforceCrossUserPermission(r2, r3, r4, r5, r6);
        r0 = r17;
        r0 = r0.mPackages;
        r16 = r0;
        monitor-enter(r16);
        r0 = r17;
        r1 = r0.mContext;	 Catch:{ all -> 0x00d2 }
        r3 = "android.permission.SET_PREFERRED_APPLICATIONS";
        r1 = r1.checkCallingOrSelfPermission(r3);	 Catch:{ all -> 0x00d2 }
        if (r1 == 0) goto L_0x0084;
    L_0x0052:
        r0 = r17;
        r1 = r0.getUidTargetSdkVersionLockedLPr(r2);	 Catch:{ all -> 0x00d2 }
        r3 = 8;
        if (r1 >= r3) goto L_0x007a;
    L_0x005c:
        r1 = "PackageManager";
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00d2 }
        r3.<init>();	 Catch:{ all -> 0x00d2 }
        r4 = "Ignoring replacePreferredActivity() from uid ";
        r3 = r3.append(r4);	 Catch:{ all -> 0x00d2 }
        r4 = android.os.Binder.getCallingUid();	 Catch:{ all -> 0x00d2 }
        r3 = r3.append(r4);	 Catch:{ all -> 0x00d2 }
        r3 = r3.toString();	 Catch:{ all -> 0x00d2 }
        android.util.Slog.w(r1, r3);	 Catch:{ all -> 0x00d2 }
        monitor-exit(r16);	 Catch:{ all -> 0x00d2 }
    L_0x0079:
        return;
    L_0x007a:
        r0 = r17;
        r1 = r0.mContext;	 Catch:{ all -> 0x00d2 }
        r3 = "android.permission.SET_PREFERRED_APPLICATIONS";
        r4 = 0;
        r1.enforceCallingOrSelfPermission(r3, r4);	 Catch:{ all -> 0x00d2 }
    L_0x0084:
        r0 = r17;
        r1 = r0.mSettings;	 Catch:{ all -> 0x00d2 }
        r1 = r1.mPreferredActivities;	 Catch:{ all -> 0x00d2 }
        r0 = r22;
        r15 = r1.get(r0);	 Catch:{ all -> 0x00d2 }
        r15 = (com.android.server.pm.PreferredIntentResolver) r15;	 Catch:{ all -> 0x00d2 }
        if (r15 == 0) goto L_0x00ea;
    L_0x0094:
        r0 = r18;
        r12 = r15.findFilters(r0);	 Catch:{ all -> 0x00d2 }
        if (r12 == 0) goto L_0x00d5;
    L_0x009c:
        r1 = r12.size();	 Catch:{ all -> 0x00d2 }
        r3 = 1;
        if (r1 != r3) goto L_0x00d5;
    L_0x00a3:
        r1 = 0;
        r11 = r12.get(r1);	 Catch:{ all -> 0x00d2 }
        r11 = (com.android.server.pm.PreferredActivity) r11;	 Catch:{ all -> 0x00d2 }
        r1 = r11.mPref;	 Catch:{ all -> 0x00d2 }
        r1 = r1.mAlways;	 Catch:{ all -> 0x00d2 }
        if (r1 == 0) goto L_0x00d5;
    L_0x00b0:
        r1 = r11.mPref;	 Catch:{ all -> 0x00d2 }
        r1 = r1.mComponent;	 Catch:{ all -> 0x00d2 }
        r0 = r21;
        r1 = r1.equals(r0);	 Catch:{ all -> 0x00d2 }
        if (r1 == 0) goto L_0x00d5;
    L_0x00bc:
        r1 = r11.mPref;	 Catch:{ all -> 0x00d2 }
        r1 = r1.mMatch;	 Catch:{ all -> 0x00d2 }
        r3 = 268369920; // 0xfff0000 float:2.5144941E-29 double:1.32592358E-315;
        r3 = r3 & r19;
        if (r1 != r3) goto L_0x00d5;
    L_0x00c6:
        r1 = r11.mPref;	 Catch:{ all -> 0x00d2 }
        r0 = r20;
        r1 = r1.sameSet(r0);	 Catch:{ all -> 0x00d2 }
        if (r1 == 0) goto L_0x00d5;
    L_0x00d0:
        monitor-exit(r16);	 Catch:{ all -> 0x00d2 }
        goto L_0x0079;
    L_0x00d2:
        r1 = move-exception;
        monitor-exit(r16);	 Catch:{ all -> 0x00d2 }
        throw r1;
    L_0x00d5:
        if (r12 == 0) goto L_0x00ea;
    L_0x00d7:
        r13 = 0;
    L_0x00d8:
        r1 = r12.size();	 Catch:{ all -> 0x00d2 }
        if (r13 >= r1) goto L_0x00ea;
    L_0x00de:
        r14 = r12.get(r13);	 Catch:{ all -> 0x00d2 }
        r14 = (com.android.server.pm.PreferredActivity) r14;	 Catch:{ all -> 0x00d2 }
        r15.removeFilter(r14);	 Catch:{ all -> 0x00d2 }
        r13 = r13 + 1;
        goto L_0x00d8;
    L_0x00ea:
        r8 = 1;
        r10 = "Replacing preferred";
        r3 = r17;
        r4 = r18;
        r5 = r19;
        r6 = r20;
        r7 = r21;
        r9 = r22;
        r3.addPreferredActivityInternal(r4, r5, r6, r7, r8, r9, r10);	 Catch:{ all -> 0x00d2 }
        monitor-exit(r16);	 Catch:{ all -> 0x00d2 }
        goto L_0x0079;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageManagerService.replacePreferredActivity(android.content.IntentFilter, int, android.content.ComponentName[], android.content.ComponentName, int):void");
    }

    public void clearPackagePreferredActivities(String packageName) {
        int uid = Binder.getCallingUid();
        synchronized (this.mPackages) {
            Package pkg = (Package) this.mPackages.get(packageName);
            if ((pkg == null || pkg.applicationInfo.uid != uid) && this.mContext.checkCallingOrSelfPermission("android.permission.SET_PREFERRED_APPLICATIONS") != 0) {
                if (getUidTargetSdkVersionLockedLPr(Binder.getCallingUid()) < SCAN_UPDATE_SIGNATURE) {
                    Slog.w(TAG, "Ignoring clearPackagePreferredActivities() from uid " + Binder.getCallingUid());
                    return;
                }
                this.mContext.enforceCallingOrSelfPermission("android.permission.SET_PREFERRED_APPLICATIONS", null);
            }
            int user = UserHandle.getCallingUserId();
            if (clearPackagePreferredActivitiesLPw(packageName, user)) {
                scheduleWritePackageRestrictionsLocked(user);
            }
        }
    }

    boolean clearPackagePreferredActivitiesLPw(String packageName, int userId) {
        ArrayList<PreferredActivity> removed = null;
        boolean changed = DEBUG_VERIFY;
        for (int i = DEX_OPT_SKIPPED; i < this.mSettings.mPreferredActivities.size(); i += UPDATE_PERMISSIONS_ALL) {
            int thisUserId = this.mSettings.mPreferredActivities.keyAt(i);
            PreferredIntentResolver pir = (PreferredIntentResolver) this.mSettings.mPreferredActivities.valueAt(i);
            if (userId == DEX_OPT_FAILED || userId == thisUserId) {
                Iterator<PreferredActivity> it = pir.filterIterator();
                while (it.hasNext()) {
                    PreferredActivity pa = (PreferredActivity) it.next();
                    if (packageName == null || (pa.mPref.mComponent.getPackageName().equals(packageName) && pa.mPref.mAlways)) {
                        if (removed == null) {
                            removed = new ArrayList();
                        }
                        removed.add(pa);
                    }
                }
                if (removed != null) {
                    for (int j = DEX_OPT_SKIPPED; j < removed.size(); j += UPDATE_PERMISSIONS_ALL) {
                        pir.removeFilter((PreferredActivity) removed.get(j));
                    }
                    changed = DEFAULT_VERIFY_ENABLE;
                }
            }
        }
        return changed;
    }

    public void resetPreferredActivities(int userId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.SET_PREFERRED_APPLICATIONS", null);
        synchronized (this.mPackages) {
            int user = UserHandle.getCallingUserId();
            clearPackagePreferredActivitiesLPw(null, user);
            this.mSettings.readDefaultPreferredAppsLPw(this, user);
            scheduleWritePackageRestrictionsLocked(user);
        }
    }

    public int getPreferredActivities(List<IntentFilter> outFilters, List<ComponentName> outActivities, String packageName) {
        int userId = UserHandle.getCallingUserId();
        synchronized (this.mPackages) {
            PreferredIntentResolver pir = (PreferredIntentResolver) this.mSettings.mPreferredActivities.get(userId);
            if (pir != null) {
                Iterator<PreferredActivity> it = pir.filterIterator();
                while (it.hasNext()) {
                    PreferredActivity pa = (PreferredActivity) it.next();
                    if (packageName == null || (pa.mPref.mComponent.getPackageName().equals(packageName) && pa.mPref.mAlways)) {
                        if (outFilters != null) {
                            outFilters.add(new IntentFilter(pa));
                        }
                        if (outActivities != null) {
                            outActivities.add(pa.mPref.mComponent);
                        }
                    }
                }
            }
        }
        return DEX_OPT_SKIPPED;
    }

    public void addPersistentPreferredActivity(IntentFilter filter, ComponentName activity, int userId) {
        if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            throw new SecurityException("addPersistentPreferredActivity can only be run by the system");
        } else if (filter.countActions() == 0) {
            Slog.w(TAG, "Cannot set a preferred activity with no filter actions");
        } else {
            synchronized (this.mPackages) {
                Slog.i(TAG, "Adding persistent preferred activity " + activity + " for user " + userId + " :");
                filter.dump(new LogPrinter(UPDATE_PERMISSIONS_REPLACE_ALL, TAG), "  ");
                this.mSettings.editPersistentPreferredActivitiesLPw(userId).addFilter(new PersistentPreferredActivity(filter, activity));
                scheduleWritePackageRestrictionsLocked(userId);
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void clearPackagePersistentPreferredActivities(java.lang.String r13, int r14) {
        /*
        r12 = this;
        r0 = android.os.Binder.getCallingUid();
        r10 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        if (r0 == r10) goto L_0x0010;
    L_0x0008:
        r10 = new java.lang.SecurityException;
        r11 = "clearPackagePersistentPreferredActivities can only be run by the system";
        r10.<init>(r11);
        throw r10;
    L_0x0010:
        r7 = 0;
        r1 = 0;
        r11 = r12.mPackages;
        monitor-enter(r11);
        r2 = 0;
    L_0x0016:
        r10 = r12.mSettings;	 Catch:{ all -> 0x007f }
        r10 = r10.mPersistentPreferredActivities;	 Catch:{ all -> 0x007f }
        r10 = r10.size();	 Catch:{ all -> 0x007f }
        if (r2 >= r10) goto L_0x0078;
    L_0x0020:
        r10 = r12.mSettings;	 Catch:{ all -> 0x007f }
        r10 = r10.mPersistentPreferredActivities;	 Catch:{ all -> 0x007f }
        r9 = r10.keyAt(r2);	 Catch:{ all -> 0x007f }
        r10 = r12.mSettings;	 Catch:{ all -> 0x007f }
        r10 = r10.mPersistentPreferredActivities;	 Catch:{ all -> 0x007f }
        r6 = r10.valueAt(r2);	 Catch:{ all -> 0x007f }
        r6 = (com.android.server.pm.PersistentPreferredIntentResolver) r6;	 Catch:{ all -> 0x007f }
        if (r14 == r9) goto L_0x0037;
    L_0x0034:
        r2 = r2 + 1;
        goto L_0x0016;
    L_0x0037:
        r3 = r6.filterIterator();	 Catch:{ all -> 0x007f }
        r8 = r7;
    L_0x003c:
        r10 = r3.hasNext();	 Catch:{ all -> 0x0082 }
        if (r10 == 0) goto L_0x0060;
    L_0x0042:
        r5 = r3.next();	 Catch:{ all -> 0x0082 }
        r5 = (com.android.server.pm.PersistentPreferredActivity) r5;	 Catch:{ all -> 0x0082 }
        r10 = r5.mComponent;	 Catch:{ all -> 0x0082 }
        r10 = r10.getPackageName();	 Catch:{ all -> 0x0082 }
        r10 = r10.equals(r13);	 Catch:{ all -> 0x0082 }
        if (r10 == 0) goto L_0x0089;
    L_0x0054:
        if (r8 != 0) goto L_0x0087;
    L_0x0056:
        r7 = new java.util.ArrayList;	 Catch:{ all -> 0x0082 }
        r7.<init>();	 Catch:{ all -> 0x0082 }
    L_0x005b:
        r7.add(r5);	 Catch:{ all -> 0x007f }
    L_0x005e:
        r8 = r7;
        goto L_0x003c;
    L_0x0060:
        if (r8 == 0) goto L_0x0085;
    L_0x0062:
        r4 = 0;
    L_0x0063:
        r10 = r8.size();	 Catch:{ all -> 0x0082 }
        if (r4 >= r10) goto L_0x0075;
    L_0x0069:
        r5 = r8.get(r4);	 Catch:{ all -> 0x0082 }
        r5 = (com.android.server.pm.PersistentPreferredActivity) r5;	 Catch:{ all -> 0x0082 }
        r6.removeFilter(r5);	 Catch:{ all -> 0x0082 }
        r4 = r4 + 1;
        goto L_0x0063;
    L_0x0075:
        r1 = 1;
        r7 = r8;
        goto L_0x0034;
    L_0x0078:
        if (r1 == 0) goto L_0x007d;
    L_0x007a:
        r12.scheduleWritePackageRestrictionsLocked(r14);	 Catch:{ all -> 0x007f }
    L_0x007d:
        monitor-exit(r11);	 Catch:{ all -> 0x007f }
        return;
    L_0x007f:
        r10 = move-exception;
    L_0x0080:
        monitor-exit(r11);	 Catch:{ all -> 0x007f }
        throw r10;
    L_0x0082:
        r10 = move-exception;
        r7 = r8;
        goto L_0x0080;
    L_0x0085:
        r7 = r8;
        goto L_0x0034;
    L_0x0087:
        r7 = r8;
        goto L_0x005b;
    L_0x0089:
        r7 = r8;
        goto L_0x005e;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageManagerService.clearPackagePersistentPreferredActivities(java.lang.String, int):void");
    }

    public void addCrossProfileIntentFilter(IntentFilter intentFilter, String ownerPackage, int ownerUserId, int sourceUserId, int targetUserId, int flags) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.INTERACT_ACROSS_USERS_FULL", null);
        int callingUid = Binder.getCallingUid();
        enforceOwnerRights(ownerPackage, ownerUserId, callingUid);
        enforceShellRestriction("no_debugging_features", callingUid, sourceUserId);
        if (intentFilter.countActions() == 0) {
            Slog.w(TAG, "Cannot set a crossProfile intent filter with no filter actions");
            return;
        }
        synchronized (this.mPackages) {
            CrossProfileIntentFilter newFilter = new CrossProfileIntentFilter(intentFilter, ownerPackage, UserHandle.getUserId(callingUid), targetUserId, flags);
            CrossProfileIntentResolver resolver = this.mSettings.editCrossProfileIntentResolverLPw(sourceUserId);
            ArrayList<CrossProfileIntentFilter> existing = resolver.findFilters(intentFilter);
            if (existing != null) {
                int size = existing.size();
                for (int i = DEX_OPT_SKIPPED; i < size; i += UPDATE_PERMISSIONS_ALL) {
                    if (newFilter.equalsIgnoreFilter((CrossProfileIntentFilter) existing.get(i))) {
                        return;
                    }
                }
            }
            resolver.addFilter(newFilter);
            scheduleWritePackageRestrictionsLocked(sourceUserId);
        }
    }

    public void clearCrossProfileIntentFilters(int sourceUserId, String ownerPackage, int ownerUserId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.INTERACT_ACROSS_USERS_FULL", null);
        int callingUid = Binder.getCallingUid();
        enforceOwnerRights(ownerPackage, ownerUserId, callingUid);
        enforceShellRestriction("no_debugging_features", callingUid, sourceUserId);
        int callingUserId = UserHandle.getUserId(callingUid);
        synchronized (this.mPackages) {
            CrossProfileIntentResolver resolver = this.mSettings.editCrossProfileIntentResolverLPw(sourceUserId);
            Iterator i$ = new ArraySet(resolver.filterSet()).iterator();
            while (i$.hasNext()) {
                CrossProfileIntentFilter filter = (CrossProfileIntentFilter) i$.next();
                if (filter.getOwnerPackage().equals(ownerPackage) && filter.getOwnerUserId() == callingUserId) {
                    resolver.removeFilter(filter);
                }
            }
            scheduleWritePackageRestrictionsLocked(sourceUserId);
        }
    }

    private void enforceOwnerRights(String pkg, int userId, int callingUid) {
        if (UserHandle.getAppId(callingUid) != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            int callingUserId = UserHandle.getUserId(callingUid);
            if (callingUserId != userId) {
                throw new SecurityException("calling uid " + callingUid + " pretends to own " + pkg + " on user " + userId + " but belongs to user " + callingUserId);
            }
            PackageInfo pi = getPackageInfo(pkg, DEX_OPT_SKIPPED, callingUserId);
            if (pi == null) {
                throw new IllegalArgumentException("Unknown package " + pkg + " on user " + callingUserId);
            } else if (!UserHandle.isSameApp(pi.applicationInfo.uid, callingUid)) {
                throw new SecurityException("Calling uid " + callingUid + " does not own package " + pkg);
            }
        }
    }

    public ComponentName getHomeActivities(List<ResolveInfo> allHomeCandidates) {
        Intent intent = new Intent("android.intent.action.MAIN");
        intent.addCategory("android.intent.category.HOME");
        int callingUserId = UserHandle.getCallingUserId();
        List<ResolveInfo> list = queryIntentActivities(intent, null, SCAN_DEFER_DEX, callingUserId);
        ResolveInfo preferred = findPreferredActivity(intent, null, DEX_OPT_SKIPPED, list, DEX_OPT_SKIPPED, DEFAULT_VERIFY_ENABLE, DEBUG_VERIFY, DEBUG_VERIFY, callingUserId);
        allHomeCandidates.clear();
        if (list != null) {
            for (ResolveInfo ri : list) {
                allHomeCandidates.add(ri);
            }
        }
        if (preferred == null || preferred.activityInfo == null) {
            return null;
        }
        return new ComponentName(preferred.activityInfo.packageName, preferred.activityInfo.name);
    }

    public void setApplicationEnabledSetting(String appPackageName, int newState, int flags, int userId, String callingPackage) {
        if (sUserManager.exists(userId)) {
            if (callingPackage == null) {
                callingPackage = Integer.toString(Binder.getCallingUid());
            }
            setEnabledSetting(appPackageName, null, newState, flags, userId, callingPackage);
        }
    }

    public void setComponentEnabledSetting(ComponentName componentName, int newState, int flags, int userId) {
        if (!sUserManager.exists(userId)) {
            return;
        }
        if (this.mDisabledComponentsList.contains(componentName)) {
            Slog.d(TAG, "Ignoring attempt to set enabled state of disabled component " + componentName.flattenToString());
        } else {
            setEnabledSetting(componentName.getPackageName(), componentName.getClassName(), newState, flags, userId, null);
        }
    }

    private void setEnabledSetting(String packageName, String className, int newState, int flags, int userId, String callingPackage) {
        if (newState == 0 || newState == UPDATE_PERMISSIONS_ALL || newState == UPDATE_PERMISSIONS_REPLACE_PKG || newState == MCS_BOUND || newState == UPDATE_PERMISSIONS_REPLACE_ALL) {
            String componentName;
            int uid = Binder.getCallingUid();
            int permission = this.mContext.checkCallingOrSelfPermission("android.permission.CHANGE_COMPONENT_ENABLED_STATE");
            enforceCrossUserPermission(uid, userId, DEBUG_VERIFY, DEFAULT_VERIFY_ENABLE, "set enabled");
            boolean allowedByPermission = permission == 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
            boolean sendNow = DEBUG_VERIFY;
            if (className == null ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY) {
                componentName = packageName;
            } else {
                componentName = className;
            }
            synchronized (this.mPackages) {
                PackageSetting pkgSetting = (PackageSetting) this.mSettings.mPackages.get(packageName);
                if (pkgSetting == null) {
                    if (className == null) {
                        throw new IllegalArgumentException("Unknown package: " + packageName);
                    }
                    throw new IllegalArgumentException("Unknown component: " + packageName + "/" + className);
                } else if (allowedByPermission || UserHandle.isSameApp(uid, pkgSetting.appId)) {
                    if (className != null) {
                        Package pkg = pkgSetting.pkg;
                        if (pkg == null || !pkg.hasComponentClassName(className)) {
                            if (pkg.applicationInfo.targetSdkVersion >= SCAN_NEW_INSTALL) {
                                throw new IllegalArgumentException("Component class " + className + " does not exist in " + packageName);
                            }
                            Slog.w(TAG, "Failed setComponentEnabledSetting: component class " + className + " does not exist in " + packageName);
                        }
                        switch (newState) {
                            case DEX_OPT_SKIPPED /*0*/:
                                if (!pkgSetting.restoreComponentLPw(className, userId)) {
                                    return;
                                }
                                break;
                            case UPDATE_PERMISSIONS_ALL /*1*/:
                                if (!pkgSetting.enableComponentLPw(className, userId)) {
                                    return;
                                }
                                break;
                            case UPDATE_PERMISSIONS_REPLACE_PKG /*2*/:
                                if (!pkgSetting.disableComponentLPw(className, userId)) {
                                    return;
                                }
                                break;
                            default:
                                Slog.e(TAG, "Invalid new component state: " + newState);
                                return;
                        }
                    } else if (pkgSetting.getEnabled(userId) == newState) {
                        return;
                    } else {
                        if (newState == 0 || newState == UPDATE_PERMISSIONS_ALL) {
                            callingPackage = null;
                        }
                        pkgSetting.setEnabled(newState, userId, callingPackage);
                    }
                    this.mSettings.writePackageRestrictionsLPr(userId);
                    ArrayList<String> components = this.mPendingBroadcasts.get(userId, packageName);
                    boolean newPackage = components == null ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
                    if (newPackage) {
                        components = new ArrayList();
                    }
                    if (!components.contains(componentName)) {
                        components.add(componentName);
                    }
                    if ((flags & UPDATE_PERMISSIONS_ALL) == 0) {
                        sendNow = DEFAULT_VERIFY_ENABLE;
                        this.mPendingBroadcasts.remove(userId, packageName);
                    } else {
                        if (newPackage) {
                            this.mPendingBroadcasts.put(userId, packageName, components);
                        }
                        if (!this.mHandler.hasMessages(UPDATE_PERMISSIONS_ALL)) {
                            this.mHandler.sendEmptyMessageDelayed(UPDATE_PERMISSIONS_ALL, DEFAULT_VERIFICATION_TIMEOUT);
                        }
                    }
                    long callingId = Binder.clearCallingIdentity();
                    if (sendNow) {
                        try {
                            sendPackageChangedBroadcast(packageName, (flags & UPDATE_PERMISSIONS_ALL) != 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY, components, UserHandle.getUid(userId, pkgSetting.appId));
                        } catch (Throwable th) {
                            Binder.restoreCallingIdentity(callingId);
                        }
                    }
                    Binder.restoreCallingIdentity(callingId);
                    return;
                } else {
                    throw new SecurityException("Permission Denial: attempt to change component state from pid=" + Binder.getCallingPid() + ", uid=" + uid + ", package uid=" + pkgSetting.appId);
                }
            }
        } else {
            throw new IllegalArgumentException("Invalid new component state: " + newState);
        }
    }

    private void sendPackageChangedBroadcast(String packageName, boolean killFlag, ArrayList<String> componentNames, int packageUid) {
        Bundle extras = new Bundle(UPDATE_PERMISSIONS_REPLACE_ALL);
        extras.putString("android.intent.extra.changed_component_name", (String) componentNames.get(DEX_OPT_SKIPPED));
        String[] nameList = new String[componentNames.size()];
        componentNames.toArray(nameList);
        extras.putStringArray("android.intent.extra.changed_component_name_list", nameList);
        extras.putBoolean("android.intent.extra.DONT_KILL_APP", killFlag);
        extras.putInt("android.intent.extra.UID", packageUid);
        int[] iArr = new int[UPDATE_PERMISSIONS_ALL];
        iArr[DEX_OPT_SKIPPED] = UserHandle.getUserId(packageUid);
        sendPackageBroadcast("android.intent.action.PACKAGE_CHANGED", packageName, extras, null, null, iArr);
    }

    public void setPackageStoppedState(String packageName, boolean stopped, int userId) {
        if (sUserManager.exists(userId)) {
            int uid = Binder.getCallingUid();
            boolean allowedByPermission = this.mContext.checkCallingOrSelfPermission("android.permission.CHANGE_COMPONENT_ENABLED_STATE") == 0 ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
            enforceCrossUserPermission(uid, userId, DEFAULT_VERIFY_ENABLE, DEFAULT_VERIFY_ENABLE, "stop package");
            synchronized (this.mPackages) {
                if (this.mSettings.setPackageStoppedStateLPw(packageName, stopped, allowedByPermission, uid, userId)) {
                    scheduleWritePackageRestrictionsLocked(userId);
                }
            }
        }
    }

    public String getInstallerPackageName(String packageName) {
        String installerPackageNameLPr;
        synchronized (this.mPackages) {
            installerPackageNameLPr = this.mSettings.getInstallerPackageNameLPr(packageName);
        }
        return installerPackageNameLPr;
    }

    public int getApplicationEnabledSetting(String packageName, int userId) {
        if (!sUserManager.exists(userId)) {
            return UPDATE_PERMISSIONS_REPLACE_PKG;
        }
        int applicationEnabledSettingLPr;
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "get enabled");
        synchronized (this.mPackages) {
            applicationEnabledSettingLPr = this.mSettings.getApplicationEnabledSettingLPr(packageName, userId);
        }
        return applicationEnabledSettingLPr;
    }

    public int getComponentEnabledSetting(ComponentName componentName, int userId) {
        if (!sUserManager.exists(userId)) {
            return UPDATE_PERMISSIONS_REPLACE_PKG;
        }
        int componentEnabledSettingLPr;
        enforceCrossUserPermission(Binder.getCallingUid(), userId, DEBUG_VERIFY, DEBUG_VERIFY, "get component enabled");
        synchronized (this.mPackages) {
            componentEnabledSettingLPr = this.mSettings.getComponentEnabledSettingLPr(componentName, userId);
        }
        return componentEnabledSettingLPr;
    }

    public void enterSafeMode() {
        enforceSystemOrRoot("Only the system can request entering safe mode");
        if (!this.mSystemReady) {
            this.mSafeMode = DEFAULT_VERIFY_ENABLE;
        }
    }

    public void systemReady() {
        boolean compatibilityModeEnabled = DEFAULT_VERIFY_ENABLE;
        this.mSystemReady = DEFAULT_VERIFY_ENABLE;
        if (Global.getInt(this.mContext.getContentResolver(), "compatibility_mode", UPDATE_PERMISSIONS_ALL) != UPDATE_PERMISSIONS_ALL) {
            compatibilityModeEnabled = DEBUG_VERIFY;
        }
        PackageParser.setCompatibilityModeEnabled(compatibilityModeEnabled);
        synchronized (this.mPackages) {
            ArrayList<PreferredActivity> removed = new ArrayList();
            for (int i = DEX_OPT_SKIPPED; i < this.mSettings.mPreferredActivities.size(); i += UPDATE_PERMISSIONS_ALL) {
                Iterator i$;
                PreferredActivity pa;
                PreferredIntentResolver pir = (PreferredIntentResolver) this.mSettings.mPreferredActivities.valueAt(i);
                removed.clear();
                for (PreferredActivity pa2 : pir.filterSet()) {
                    if (this.mActivities.mActivities.get(pa2.mPref.mComponent) == null) {
                        removed.add(pa2);
                    }
                }
                if (removed.size() > 0) {
                    for (int r = DEX_OPT_SKIPPED; r < removed.size(); r += UPDATE_PERMISSIONS_ALL) {
                        pa2 = (PreferredActivity) removed.get(r);
                        Slog.w(TAG, "Removing dangling preferred activity: " + pa2.mPref.mComponent);
                        pir.removeFilter(pa2);
                    }
                    this.mSettings.writePackageRestrictionsLPr(this.mSettings.mPreferredActivities.keyAt(i));
                }
            }
        }
        sUserManager.systemReady();
        if (this.mPostSystemReadyMessages != null) {
            i$ = this.mPostSystemReadyMessages.iterator();
            while (i$.hasNext()) {
                ((Message) i$.next()).sendToTarget();
            }
            this.mPostSystemReadyMessages = null;
        }
    }

    public boolean isSafeMode() {
        return this.mSafeMode;
    }

    public boolean hasSystemUidErrors() {
        return this.mHasSystemUidErrors;
    }

    static String arrayToString(int[] array) {
        StringBuffer buf = new StringBuffer(SCAN_DEFER_DEX);
        buf.append('[');
        if (array != null) {
            for (int i = DEX_OPT_SKIPPED; i < array.length; i += UPDATE_PERMISSIONS_ALL) {
                if (i > 0) {
                    buf.append(", ");
                }
                buf.append(array[i]);
            }
        }
        buf.append(']');
        return buf.toString();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    protected void dump(java.io.FileDescriptor r38, java.io.PrintWriter r39, java.lang.String[] r40) {
        /*
        r37 = this;
        r0 = r37;
        r3 = r0.mContext;
        r4 = "android.permission.DUMP";
        r3 = r3.checkCallingOrSelfPermission(r4);
        if (r3 == 0) goto L_0x0043;
    L_0x000c:
        r3 = new java.lang.StringBuilder;
        r3.<init>();
        r4 = "Permission Denial: can't dump ActivityManager from from pid=";
        r3 = r3.append(r4);
        r4 = android.os.Binder.getCallingPid();
        r3 = r3.append(r4);
        r4 = ", uid=";
        r3 = r3.append(r4);
        r4 = android.os.Binder.getCallingUid();
        r3 = r3.append(r4);
        r4 = " without permission ";
        r3 = r3.append(r4);
        r4 = "android.permission.DUMP";
        r3 = r3.append(r4);
        r3 = r3.toString();
        r0 = r39;
        r0.println(r3);
    L_0x0042:
        return;
    L_0x0043:
        r12 = new com.android.server.pm.PackageManagerService$DumpState;
        r12.<init>();
        r17 = 0;
        r10 = 0;
        r6 = 0;
        r28 = 0;
    L_0x004e:
        r0 = r40;
        r3 = r0.length;
        r0 = r28;
        if (r0 >= r3) goto L_0x006a;
    L_0x0055:
        r27 = r40[r28];
        if (r27 == 0) goto L_0x006a;
    L_0x0059:
        r3 = r27.length();
        if (r3 <= 0) goto L_0x006a;
    L_0x005f:
        r3 = 0;
        r0 = r27;
        r3 = r0.charAt(r3);
        r4 = 45;
        if (r3 == r4) goto L_0x01cd;
    L_0x006a:
        r0 = r40;
        r3 = r0.length;
        r0 = r28;
        if (r0 >= r3) goto L_0x008a;
    L_0x0071:
        r11 = r40[r28];
        r28 = r28 + 1;
        r3 = "android";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x0085;
    L_0x007d:
        r3 = ".";
        r3 = r11.contains(r3);
        if (r3 == 0) goto L_0x02be;
    L_0x0085:
        r6 = r11;
        r3 = 1;
        r12.setOptionEnabled(r3);
    L_0x008a:
        if (r10 == 0) goto L_0x0093;
    L_0x008c:
        r3 = "vers,1";
        r0 = r39;
        r0.println(r3);
    L_0x0093:
        r0 = r37;
        r0 = r0.mPackages;
        r36 = r0;
        monitor-enter(r36);
        r3 = 4096; // 0x1000 float:5.74E-42 double:2.0237E-320;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x010c;
    L_0x00a2:
        if (r6 != 0) goto L_0x010c;
    L_0x00a4:
        if (r10 != 0) goto L_0x010c;
    L_0x00a6:
        r3 = r12.onTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x00af;
    L_0x00ac:
        r39.println();	 Catch:{ all -> 0x01ca }
    L_0x00af:
        r3 = "Database versions:";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r3 = "  SDK Version:";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = " internal=";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r3 = r3.mInternalSdkPlatform;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = " external=";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r3 = r3.mExternalSdkPlatform;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r3 = "  DB Version:";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = " internal=";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r3 = r3.mInternalDatabaseVersion;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = " external=";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r3 = r3.mExternalDatabaseVersion;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
    L_0x010c:
        r3 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0156;
    L_0x0114:
        if (r6 != 0) goto L_0x0156;
    L_0x0116:
        if (r10 != 0) goto L_0x041b;
    L_0x0118:
        r3 = r12.onTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0121;
    L_0x011e:
        r39.println();	 Catch:{ all -> 0x01ca }
    L_0x0121:
        r3 = "Verifiers:";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r3 = "  Required: ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mRequiredVerifierPackage;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = " (uid=";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mRequiredVerifierPackage;	 Catch:{ all -> 0x01ca }
        r4 = 0;
        r0 = r37;
        r3 = r0.getPackageUid(r3, r4);	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = ")";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
    L_0x0156:
        r3 = 1;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0485;
    L_0x015d:
        if (r6 != 0) goto L_0x0485;
    L_0x015f:
        r31 = 0;
        r0 = r37;
        r3 = r0.mSharedLibraries;	 Catch:{ all -> 0x01ca }
        r3 = r3.keySet();	 Catch:{ all -> 0x01ca }
        r24 = r3.iterator();	 Catch:{ all -> 0x01ca }
    L_0x016d:
        r3 = r24.hasNext();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0485;
    L_0x0173:
        r26 = r24.next();	 Catch:{ all -> 0x01ca }
        r26 = (java.lang.String) r26;	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mSharedLibraries;	 Catch:{ all -> 0x01ca }
        r0 = r26;
        r14 = r3.get(r0);	 Catch:{ all -> 0x01ca }
        r14 = (com.android.server.pm.PackageManagerService.SharedLibraryEntry) r14;	 Catch:{ all -> 0x01ca }
        if (r10 != 0) goto L_0x044a;
    L_0x0187:
        if (r31 != 0) goto L_0x019b;
    L_0x0189:
        r3 = r12.onTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0192;
    L_0x018f:
        r39.println();	 Catch:{ all -> 0x01ca }
    L_0x0192:
        r3 = "Libraries:";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r31 = 1;
    L_0x019b:
        r3 = "  ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
    L_0x01a2:
        r0 = r39;
        r1 = r26;
        r0.print(r1);	 Catch:{ all -> 0x01ca }
        if (r10 != 0) goto L_0x01b2;
    L_0x01ab:
        r3 = " -> ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
    L_0x01b2:
        r3 = r14.path;	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0463;
    L_0x01b6:
        if (r10 != 0) goto L_0x0453;
    L_0x01b8:
        r3 = "(jar) ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = r14.path;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
    L_0x01c6:
        r39.println();	 Catch:{ all -> 0x01ca }
        goto L_0x016d;
    L_0x01ca:
        r3 = move-exception;
        monitor-exit(r36);	 Catch:{ all -> 0x01ca }
        throw r3;
    L_0x01cd:
        r28 = r28 + 1;
        r3 = "-a";
        r0 = r27;
        r3 = r3.equals(r0);
        if (r3 != 0) goto L_0x004e;
    L_0x01d9:
        r3 = "-h";
        r0 = r27;
        r3 = r3.equals(r0);
        if (r3 == 0) goto L_0x027f;
    L_0x01e3:
        r3 = "Package manager dump options:";
        r0 = r39;
        r0.println(r3);
        r3 = "  [-h] [-f] [--checkin] [cmd] ...";
        r0 = r39;
        r0.println(r3);
        r3 = "    --checkin: dump for a checkin";
        r0 = r39;
        r0.println(r3);
        r3 = "    -f: print details of intent filters";
        r0 = r39;
        r0.println(r3);
        r3 = "    -h: print this help";
        r0 = r39;
        r0.println(r3);
        r3 = "  cmd may be one of:";
        r0 = r39;
        r0.println(r3);
        r3 = "    l[ibraries]: list known shared libraries";
        r0 = r39;
        r0.println(r3);
        r3 = "    f[ibraries]: list device features";
        r0 = r39;
        r0.println(r3);
        r3 = "    k[eysets]: print known keysets";
        r0 = r39;
        r0.println(r3);
        r3 = "    r[esolvers]: dump intent resolvers";
        r0 = r39;
        r0.println(r3);
        r3 = "    perm[issions]: dump permissions";
        r0 = r39;
        r0.println(r3);
        r3 = "    pref[erred]: print preferred package settings";
        r0 = r39;
        r0.println(r3);
        r3 = "    preferred-xml [--full]: print preferred package settings as xml";
        r0 = r39;
        r0.println(r3);
        r3 = "    prov[iders]: dump content providers";
        r0 = r39;
        r0.println(r3);
        r3 = "    p[ackages]: dump installed packages";
        r0 = r39;
        r0.println(r3);
        r3 = "    s[hared-users]: dump shared user IDs";
        r0 = r39;
        r0.println(r3);
        r3 = "    m[essages]: print collected runtime messages";
        r0 = r39;
        r0.println(r3);
        r3 = "    v[erifiers]: print package verifier info";
        r0 = r39;
        r0.println(r3);
        r3 = "    version: print database version info";
        r0 = r39;
        r0.println(r3);
        r3 = "    write: write current settings now";
        r0 = r39;
        r0.println(r3);
        r3 = "    <package.name>: info about given package";
        r0 = r39;
        r0.println(r3);
        r3 = "    installs: details about install sessions";
        r0 = r39;
        r0.println(r3);
        goto L_0x0042;
    L_0x027f:
        r3 = "--checkin";
        r0 = r27;
        r3 = r3.equals(r0);
        if (r3 == 0) goto L_0x028c;
    L_0x0289:
        r10 = 1;
        goto L_0x004e;
    L_0x028c:
        r3 = "-f";
        r0 = r27;
        r3 = r3.equals(r0);
        if (r3 == 0) goto L_0x029c;
    L_0x0296:
        r3 = 1;
        r12.setOptionEnabled(r3);
        goto L_0x004e;
    L_0x029c:
        r3 = new java.lang.StringBuilder;
        r3.<init>();
        r4 = "Unknown argument: ";
        r3 = r3.append(r4);
        r0 = r27;
        r3 = r3.append(r0);
        r4 = "; use -h for help";
        r3 = r3.append(r4);
        r3 = r3.toString();
        r0 = r39;
        r0.println(r3);
        goto L_0x004e;
    L_0x02be:
        r3 = "l";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x02ce;
    L_0x02c6:
        r3 = "libraries";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x02d4;
    L_0x02ce:
        r3 = 1;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x02d4:
        r3 = "f";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x02e4;
    L_0x02dc:
        r3 = "features";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x02ea;
    L_0x02e4:
        r3 = 2;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x02ea:
        r3 = "r";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x02fa;
    L_0x02f2:
        r3 = "resolvers";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x0300;
    L_0x02fa:
        r3 = 4;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x0300:
        r3 = "perm";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x0310;
    L_0x0308:
        r3 = "permissions";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x0317;
    L_0x0310:
        r3 = 8;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x0317:
        r3 = "pref";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x0327;
    L_0x031f:
        r3 = "preferred";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x032e;
    L_0x0327:
        r3 = 512; // 0x200 float:7.175E-43 double:2.53E-321;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x032e:
        r3 = "preferred-xml";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x0352;
    L_0x0336:
        r3 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r12.setDump(r3);
        r0 = r40;
        r3 = r0.length;
        r0 = r28;
        if (r0 >= r3) goto L_0x008a;
    L_0x0342:
        r3 = "--full";
        r4 = r40[r28];
        r3 = r3.equals(r4);
        if (r3 == 0) goto L_0x008a;
    L_0x034c:
        r17 = 1;
        r28 = r28 + 1;
        goto L_0x008a;
    L_0x0352:
        r3 = "p";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x0362;
    L_0x035a:
        r3 = "packages";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x0369;
    L_0x0362:
        r3 = 16;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x0369:
        r3 = "s";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x0379;
    L_0x0371:
        r3 = "shared-users";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x0380;
    L_0x0379:
        r3 = 32;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x0380:
        r3 = "prov";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x0390;
    L_0x0388:
        r3 = "providers";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x0397;
    L_0x0390:
        r3 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x0397:
        r3 = "m";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x03a7;
    L_0x039f:
        r3 = "messages";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x03ae;
    L_0x03a7:
        r3 = 64;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x03ae:
        r3 = "v";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x03be;
    L_0x03b6:
        r3 = "verifiers";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x03c5;
    L_0x03be:
        r3 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x03c5:
        r3 = "version";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x03d4;
    L_0x03cd:
        r3 = 4096; // 0x1000 float:5.74E-42 double:2.0237E-320;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x03d4:
        r3 = "k";
        r3 = r3.equals(r11);
        if (r3 != 0) goto L_0x03e4;
    L_0x03dc:
        r3 = "keysets";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x03eb;
    L_0x03e4:
        r3 = 2048; // 0x800 float:2.87E-42 double:1.0118E-320;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x03eb:
        r3 = "installs";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x03fa;
    L_0x03f3:
        r3 = 8192; // 0x2000 float:1.14794E-41 double:4.0474E-320;
        r12.setDump(r3);
        goto L_0x008a;
    L_0x03fa:
        r3 = "write";
        r3 = r3.equals(r11);
        if (r3 == 0) goto L_0x008a;
    L_0x0402:
        r0 = r37;
        r4 = r0.mPackages;
        monitor-enter(r4);
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x0418 }
        r3.writeLPr();	 Catch:{ all -> 0x0418 }
        r3 = "Settings written.";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x0418 }
        monitor-exit(r4);	 Catch:{ all -> 0x0418 }
        goto L_0x0042;
    L_0x0418:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0418 }
        throw r3;
    L_0x041b:
        r0 = r37;
        r3 = r0.mRequiredVerifierPackage;	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0156;
    L_0x0421:
        r3 = "vrfy,";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mRequiredVerifierPackage;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = ",";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mRequiredVerifierPackage;	 Catch:{ all -> 0x01ca }
        r4 = 0;
        r0 = r37;
        r3 = r0.getPackageUid(r3, r4);	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        goto L_0x0156;
    L_0x044a:
        r3 = "lib,";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        goto L_0x01a2;
    L_0x0453:
        r3 = ",jar,";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = r14.path;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        goto L_0x01c6;
    L_0x0463:
        if (r10 != 0) goto L_0x0475;
    L_0x0465:
        r3 = "(apk) ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = r14.apk;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        goto L_0x01c6;
    L_0x0475:
        r3 = ",apk,";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = r14.apk;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        goto L_0x01c6;
    L_0x0485:
        r3 = 2;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x04d1;
    L_0x048c:
        if (r6 != 0) goto L_0x04d1;
    L_0x048e:
        r3 = r12.onTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0497;
    L_0x0494:
        r39.println();	 Catch:{ all -> 0x01ca }
    L_0x0497:
        if (r10 != 0) goto L_0x04a0;
    L_0x0499:
        r3 = "Features:";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
    L_0x04a0:
        r0 = r37;
        r3 = r0.mAvailableFeatures;	 Catch:{ all -> 0x01ca }
        r3 = r3.keySet();	 Catch:{ all -> 0x01ca }
        r24 = r3.iterator();	 Catch:{ all -> 0x01ca }
    L_0x04ac:
        r3 = r24.hasNext();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x04d1;
    L_0x04b2:
        r26 = r24.next();	 Catch:{ all -> 0x01ca }
        r26 = (java.lang.String) r26;	 Catch:{ all -> 0x01ca }
        if (r10 != 0) goto L_0x04c9;
    L_0x04ba:
        r3 = "  ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
    L_0x04c1:
        r0 = r39;
        r1 = r26;
        r0.println(r1);	 Catch:{ all -> 0x01ca }
        goto L_0x04ac;
    L_0x04c9:
        r3 = "feat,";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        goto L_0x04c1;
    L_0x04d1:
        if (r10 != 0) goto L_0x055a;
    L_0x04d3:
        r3 = 4;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x055a;
    L_0x04da:
        r0 = r37;
        r2 = r0.mActivities;	 Catch:{ all -> 0x01ca }
        r3 = r12.getTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x05c2;
    L_0x04e4:
        r4 = "\nActivity Resolver Table:";
    L_0x04e6:
        r5 = "  ";
        r3 = 1;
        r7 = r12.isOptionEnabled(r3);	 Catch:{ all -> 0x01ca }
        r8 = 1;
        r3 = r39;
        r3 = r2.dump(r3, r4, r5, r6, r7, r8);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x04fa;
    L_0x04f6:
        r3 = 1;
        r12.setTitlePrinted(r3);	 Catch:{ all -> 0x01ca }
    L_0x04fa:
        r0 = r37;
        r2 = r0.mReceivers;	 Catch:{ all -> 0x01ca }
        r3 = r12.getTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x05c6;
    L_0x0504:
        r4 = "\nReceiver Resolver Table:";
    L_0x0506:
        r5 = "  ";
        r3 = 1;
        r7 = r12.isOptionEnabled(r3);	 Catch:{ all -> 0x01ca }
        r8 = 1;
        r3 = r39;
        r3 = r2.dump(r3, r4, r5, r6, r7, r8);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x051a;
    L_0x0516:
        r3 = 1;
        r12.setTitlePrinted(r3);	 Catch:{ all -> 0x01ca }
    L_0x051a:
        r0 = r37;
        r2 = r0.mServices;	 Catch:{ all -> 0x01ca }
        r3 = r12.getTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x05ca;
    L_0x0524:
        r4 = "\nService Resolver Table:";
    L_0x0526:
        r5 = "  ";
        r3 = 1;
        r7 = r12.isOptionEnabled(r3);	 Catch:{ all -> 0x01ca }
        r8 = 1;
        r3 = r39;
        r3 = r2.dump(r3, r4, r5, r6, r7, r8);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x053a;
    L_0x0536:
        r3 = 1;
        r12.setTitlePrinted(r3);	 Catch:{ all -> 0x01ca }
    L_0x053a:
        r0 = r37;
        r2 = r0.mProviders;	 Catch:{ all -> 0x01ca }
        r3 = r12.getTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x05ce;
    L_0x0544:
        r4 = "\nProvider Resolver Table:";
    L_0x0546:
        r5 = "  ";
        r3 = 1;
        r7 = r12.isOptionEnabled(r3);	 Catch:{ all -> 0x01ca }
        r8 = 1;
        r3 = r39;
        r3 = r2.dump(r3, r4, r5, r6, r7, r8);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x055a;
    L_0x0556:
        r3 = 1;
        r12.setTitlePrinted(r3);	 Catch:{ all -> 0x01ca }
    L_0x055a:
        if (r10 != 0) goto L_0x05ee;
    L_0x055c:
        r3 = 512; // 0x200 float:7.175E-43 double:2.53E-321;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x05ee;
    L_0x0564:
        r18 = 0;
    L_0x0566:
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r3 = r3.mPreferredActivities;	 Catch:{ all -> 0x01ca }
        r3 = r3.size();	 Catch:{ all -> 0x01ca }
        r0 = r18;
        if (r0 >= r3) goto L_0x05ee;
    L_0x0574:
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r3 = r3.mPreferredActivities;	 Catch:{ all -> 0x01ca }
        r0 = r18;
        r2 = r3.valueAt(r0);	 Catch:{ all -> 0x01ca }
        r2 = (com.android.server.pm.PreferredIntentResolver) r2;	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r3 = r3.mPreferredActivities;	 Catch:{ all -> 0x01ca }
        r0 = r18;
        r35 = r3.keyAt(r0);	 Catch:{ all -> 0x01ca }
        r3 = r12.getTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x05d2;
    L_0x0594:
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01ca }
        r3.<init>();	 Catch:{ all -> 0x01ca }
        r4 = "\nPreferred Activities User ";
        r3 = r3.append(r4);	 Catch:{ all -> 0x01ca }
        r0 = r35;
        r3 = r3.append(r0);	 Catch:{ all -> 0x01ca }
        r4 = ":";
        r3 = r3.append(r4);	 Catch:{ all -> 0x01ca }
        r4 = r3.toString();	 Catch:{ all -> 0x01ca }
    L_0x05af:
        r5 = "  ";
        r7 = 1;
        r8 = 0;
        r3 = r39;
        r3 = r2.dump(r3, r4, r5, r6, r7, r8);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x05bf;
    L_0x05bb:
        r3 = 1;
        r12.setTitlePrinted(r3);	 Catch:{ all -> 0x01ca }
    L_0x05bf:
        r18 = r18 + 1;
        goto L_0x0566;
    L_0x05c2:
        r4 = "Activity Resolver Table:";
        goto L_0x04e6;
    L_0x05c6:
        r4 = "Receiver Resolver Table:";
        goto L_0x0506;
    L_0x05ca:
        r4 = "Service Resolver Table:";
        goto L_0x0526;
    L_0x05ce:
        r4 = "Provider Resolver Table:";
        goto L_0x0546;
    L_0x05d2:
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01ca }
        r3.<init>();	 Catch:{ all -> 0x01ca }
        r4 = "Preferred Activities User ";
        r3 = r3.append(r4);	 Catch:{ all -> 0x01ca }
        r0 = r35;
        r3 = r3.append(r0);	 Catch:{ all -> 0x01ca }
        r4 = ":";
        r3 = r3.append(r4);	 Catch:{ all -> 0x01ca }
        r4 = r3.toString();	 Catch:{ all -> 0x01ca }
        goto L_0x05af;
    L_0x05ee:
        if (r10 != 0) goto L_0x0644;
    L_0x05f0:
        r3 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0644;
    L_0x05f8:
        r39.flush();	 Catch:{ all -> 0x01ca }
        r16 = new java.io.FileOutputStream;	 Catch:{ all -> 0x01ca }
        r0 = r16;
        r1 = r38;
        r0.<init>(r1);	 Catch:{ all -> 0x01ca }
        r34 = new java.io.BufferedOutputStream;	 Catch:{ all -> 0x01ca }
        r0 = r34;
        r1 = r16;
        r0.<init>(r1);	 Catch:{ all -> 0x01ca }
        r33 = new com.android.internal.util.FastXmlSerializer;	 Catch:{ all -> 0x01ca }
        r33.<init>();	 Catch:{ all -> 0x01ca }
        r3 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ IllegalArgumentException -> 0x06c7, IllegalStateException -> 0x06e2, IOException -> 0x06fd }
        r3 = r3.name();	 Catch:{ IllegalArgumentException -> 0x06c7, IllegalStateException -> 0x06e2, IOException -> 0x06fd }
        r0 = r33;
        r1 = r34;
        r0.setOutput(r1, r3);	 Catch:{ IllegalArgumentException -> 0x06c7, IllegalStateException -> 0x06e2, IOException -> 0x06fd }
        r3 = 0;
        r4 = 1;
        r4 = java.lang.Boolean.valueOf(r4);	 Catch:{ IllegalArgumentException -> 0x06c7, IllegalStateException -> 0x06e2, IOException -> 0x06fd }
        r0 = r33;
        r0.startDocument(r3, r4);	 Catch:{ IllegalArgumentException -> 0x06c7, IllegalStateException -> 0x06e2, IOException -> 0x06fd }
        r3 = "http://xmlpull.org/v1/doc/features.html#indent-output";
        r4 = 1;
        r0 = r33;
        r0.setFeature(r3, r4);	 Catch:{ IllegalArgumentException -> 0x06c7, IllegalStateException -> 0x06e2, IOException -> 0x06fd }
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ IllegalArgumentException -> 0x06c7, IllegalStateException -> 0x06e2, IOException -> 0x06fd }
        r4 = 0;
        r0 = r33;
        r1 = r17;
        r3.writePreferredActivitiesLPr(r0, r4, r1);	 Catch:{ IllegalArgumentException -> 0x06c7, IllegalStateException -> 0x06e2, IOException -> 0x06fd }
        r33.endDocument();	 Catch:{ IllegalArgumentException -> 0x06c7, IllegalStateException -> 0x06e2, IOException -> 0x06fd }
        r33.flush();	 Catch:{ IllegalArgumentException -> 0x06c7, IllegalStateException -> 0x06e2, IOException -> 0x06fd }
    L_0x0644:
        if (r10 != 0) goto L_0x071c;
    L_0x0646:
        r3 = 8;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x071c;
    L_0x064e:
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r3.dumpPermissionsLPr(r0, r6, r12);	 Catch:{ all -> 0x01ca }
        if (r6 != 0) goto L_0x071c;
    L_0x0659:
        r22 = 0;
    L_0x065b:
        r0 = r37;
        r3 = r0.mAppOpPermissionPackages;	 Catch:{ all -> 0x01ca }
        r3 = r3.size();	 Catch:{ all -> 0x01ca }
        r0 = r22;
        if (r0 >= r3) goto L_0x071c;
    L_0x0667:
        if (r22 != 0) goto L_0x0679;
    L_0x0669:
        r3 = r12.onTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0672;
    L_0x066f:
        r39.println();	 Catch:{ all -> 0x01ca }
    L_0x0672:
        r3 = "AppOp Permissions:";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
    L_0x0679:
        r3 = "  AppOp Permission ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mAppOpPermissionPackages;	 Catch:{ all -> 0x01ca }
        r0 = r22;
        r3 = r3.keyAt(r0);	 Catch:{ all -> 0x01ca }
        r3 = (java.lang.String) r3;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = ":";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r0 = r37;
        r3 = r0.mAppOpPermissionPackages;	 Catch:{ all -> 0x01ca }
        r0 = r22;
        r30 = r3.valueAt(r0);	 Catch:{ all -> 0x01ca }
        r30 = (android.util.ArraySet) r30;	 Catch:{ all -> 0x01ca }
        r23 = 0;
    L_0x06a6:
        r3 = r30.size();	 Catch:{ all -> 0x01ca }
        r0 = r23;
        if (r0 >= r3) goto L_0x0718;
    L_0x06ae:
        r3 = "    ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r30;
        r1 = r23;
        r3 = r0.valueAt(r1);	 Catch:{ all -> 0x01ca }
        r3 = (java.lang.String) r3;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r23 = r23 + 1;
        goto L_0x06a6;
    L_0x06c7:
        r13 = move-exception;
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01ca }
        r3.<init>();	 Catch:{ all -> 0x01ca }
        r4 = "Failed writing: ";
        r3 = r3.append(r4);	 Catch:{ all -> 0x01ca }
        r3 = r3.append(r13);	 Catch:{ all -> 0x01ca }
        r3 = r3.toString();	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        goto L_0x0644;
    L_0x06e2:
        r13 = move-exception;
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01ca }
        r3.<init>();	 Catch:{ all -> 0x01ca }
        r4 = "Failed writing: ";
        r3 = r3.append(r4);	 Catch:{ all -> 0x01ca }
        r3 = r3.append(r13);	 Catch:{ all -> 0x01ca }
        r3 = r3.toString();	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        goto L_0x0644;
    L_0x06fd:
        r13 = move-exception;
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01ca }
        r3.<init>();	 Catch:{ all -> 0x01ca }
        r4 = "Failed writing: ";
        r3 = r3.append(r4);	 Catch:{ all -> 0x01ca }
        r3 = r3.append(r13);	 Catch:{ all -> 0x01ca }
        r3 = r3.toString();	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        goto L_0x0644;
    L_0x0718:
        r22 = r22 + 1;
        goto L_0x065b;
    L_0x071c:
        if (r10 != 0) goto L_0x081d;
    L_0x071e:
        r3 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x081d;
    L_0x0726:
        r32 = 0;
        r0 = r37;
        r3 = r0.mProviders;	 Catch:{ all -> 0x01ca }
        r3 = r3.mProviders;	 Catch:{ all -> 0x01ca }
        r3 = r3.values();	 Catch:{ all -> 0x01ca }
        r19 = r3.iterator();	 Catch:{ all -> 0x01ca }
    L_0x0738:
        r3 = r19.hasNext();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x078c;
    L_0x073e:
        r29 = r19.next();	 Catch:{ all -> 0x01ca }
        r29 = (android.content.pm.PackageParser.Provider) r29;	 Catch:{ all -> 0x01ca }
        if (r6 == 0) goto L_0x0752;
    L_0x0746:
        r0 = r29;
        r3 = r0.info;	 Catch:{ all -> 0x01ca }
        r3 = r3.packageName;	 Catch:{ all -> 0x01ca }
        r3 = r6.equals(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0738;
    L_0x0752:
        if (r32 != 0) goto L_0x0766;
    L_0x0754:
        r3 = r12.onTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x075d;
    L_0x075a:
        r39.println();	 Catch:{ all -> 0x01ca }
    L_0x075d:
        r3 = "Registered ContentProviders:";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r32 = 1;
    L_0x0766:
        r3 = "  ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r29;
        r1 = r39;
        r0.printComponentShortName(r1);	 Catch:{ all -> 0x01ca }
        r3 = ":";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r3 = "    ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = r29.toString();	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        goto L_0x0738;
    L_0x078c:
        r32 = 0;
        r0 = r37;
        r3 = r0.mProvidersByAuthority;	 Catch:{ all -> 0x01ca }
        r3 = r3.entrySet();	 Catch:{ all -> 0x01ca }
        r19 = r3.iterator();	 Catch:{ all -> 0x01ca }
    L_0x079a:
        r3 = r19.hasNext();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x081d;
    L_0x07a0:
        r15 = r19.next();	 Catch:{ all -> 0x01ca }
        r15 = (java.util.Map.Entry) r15;	 Catch:{ all -> 0x01ca }
        r29 = r15.getValue();	 Catch:{ all -> 0x01ca }
        r29 = (android.content.pm.PackageParser.Provider) r29;	 Catch:{ all -> 0x01ca }
        if (r6 == 0) goto L_0x07ba;
    L_0x07ae:
        r0 = r29;
        r3 = r0.info;	 Catch:{ all -> 0x01ca }
        r3 = r3.packageName;	 Catch:{ all -> 0x01ca }
        r3 = r6.equals(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x079a;
    L_0x07ba:
        if (r32 != 0) goto L_0x07ce;
    L_0x07bc:
        r3 = r12.onTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x07c5;
    L_0x07c2:
        r39.println();	 Catch:{ all -> 0x01ca }
    L_0x07c5:
        r3 = "ContentProvider Authorities:";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r32 = 1;
    L_0x07ce:
        r3 = "  [";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = r15.getKey();	 Catch:{ all -> 0x01ca }
        r3 = (java.lang.String) r3;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = "]:";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r3 = "    ";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r3 = r29.toString();	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r0 = r29;
        r3 = r0.info;	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x079a;
    L_0x07fd:
        r0 = r29;
        r3 = r0.info;	 Catch:{ all -> 0x01ca }
        r3 = r3.applicationInfo;	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x079a;
    L_0x0805:
        r0 = r29;
        r3 = r0.info;	 Catch:{ all -> 0x01ca }
        r3 = r3.applicationInfo;	 Catch:{ all -> 0x01ca }
        r9 = r3.toString();	 Catch:{ all -> 0x01ca }
        r3 = "      applicationInfo=";
        r0 = r39;
        r0.print(r3);	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r0.println(r9);	 Catch:{ all -> 0x01ca }
        goto L_0x079a;
    L_0x081d:
        if (r10 != 0) goto L_0x0832;
    L_0x081f:
        r3 = 2048; // 0x800 float:2.87E-42 double:1.0118E-320;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0832;
    L_0x0827:
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r3 = r3.mKeySetManagerService;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r3.dumpLPr(r0, r6, r12);	 Catch:{ all -> 0x01ca }
    L_0x0832:
        r3 = 16;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0843;
    L_0x083a:
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r3.dumpPackagesLPr(r0, r6, r12, r10);	 Catch:{ all -> 0x01ca }
    L_0x0843:
        r3 = 32;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0854;
    L_0x084b:
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r3.dumpSharedUsersLPr(r0, r6, r12, r10);	 Catch:{ all -> 0x01ca }
    L_0x0854:
        if (r10 != 0) goto L_0x087b;
    L_0x0856:
        r3 = 8192; // 0x2000 float:1.14794E-41 double:4.0474E-320;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x087b;
    L_0x085e:
        if (r6 != 0) goto L_0x087b;
    L_0x0860:
        r3 = r12.onTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0869;
    L_0x0866:
        r39.println();	 Catch:{ all -> 0x01ca }
    L_0x0869:
        r0 = r37;
        r3 = r0.mInstallerService;	 Catch:{ all -> 0x01ca }
        r4 = new com.android.internal.util.IndentingPrintWriter;	 Catch:{ all -> 0x01ca }
        r5 = "  ";
        r7 = 120; // 0x78 float:1.68E-43 double:5.93E-322;
        r0 = r39;
        r4.<init>(r0, r5, r7);	 Catch:{ all -> 0x01ca }
        r3.dump(r4);	 Catch:{ all -> 0x01ca }
    L_0x087b:
        if (r10 != 0) goto L_0x08d5;
    L_0x087d:
        r3 = 64;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x08d5;
    L_0x0885:
        if (r6 != 0) goto L_0x08d5;
    L_0x0887:
        r3 = r12.onTitlePrinted();	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0890;
    L_0x088d:
        r39.println();	 Catch:{ all -> 0x01ca }
    L_0x0890:
        r0 = r37;
        r3 = r0.mSettings;	 Catch:{ all -> 0x01ca }
        r0 = r39;
        r3.dumpReadMessagesLPr(r0, r12);	 Catch:{ all -> 0x01ca }
        r39.println();	 Catch:{ all -> 0x01ca }
        r3 = "Package warning messages:";
        r0 = r39;
        r0.println(r3);	 Catch:{ all -> 0x01ca }
        r20 = 0;
        r25 = 0;
        r21 = new java.io.BufferedReader;	 Catch:{ IOException -> 0x0937, all -> 0x091f }
        r3 = new java.io.FileReader;	 Catch:{ IOException -> 0x0937, all -> 0x091f }
        r4 = getSettingsProblemFile();	 Catch:{ IOException -> 0x0937, all -> 0x091f }
        r3.<init>(r4);	 Catch:{ IOException -> 0x0937, all -> 0x091f }
        r0 = r21;
        r0.<init>(r3);	 Catch:{ IOException -> 0x0937, all -> 0x091f }
    L_0x08b7:
        r25 = r21.readLine();	 Catch:{ IOException -> 0x08cf, all -> 0x0933 }
        if (r25 == 0) goto L_0x091b;
    L_0x08bd:
        r3 = "ignored: updated version";
        r0 = r25;
        r3 = r0.contains(r3);	 Catch:{ IOException -> 0x08cf, all -> 0x0933 }
        if (r3 != 0) goto L_0x08b7;
    L_0x08c7:
        r0 = r39;
        r1 = r25;
        r0.println(r1);	 Catch:{ IOException -> 0x08cf, all -> 0x0933 }
        goto L_0x08b7;
    L_0x08cf:
        r3 = move-exception;
        r20 = r21;
    L_0x08d2:
        libcore.io.IoUtils.closeQuietly(r20);	 Catch:{ all -> 0x01ca }
    L_0x08d5:
        if (r10 == 0) goto L_0x0918;
    L_0x08d7:
        r3 = 64;
        r3 = r12.isDumping(r3);	 Catch:{ all -> 0x01ca }
        if (r3 == 0) goto L_0x0918;
    L_0x08df:
        r20 = 0;
        r25 = 0;
        r21 = new java.io.BufferedReader;	 Catch:{ IOException -> 0x0931, all -> 0x0928 }
        r3 = new java.io.FileReader;	 Catch:{ IOException -> 0x0931, all -> 0x0928 }
        r4 = getSettingsProblemFile();	 Catch:{ IOException -> 0x0931, all -> 0x0928 }
        r3.<init>(r4);	 Catch:{ IOException -> 0x0931, all -> 0x0928 }
        r0 = r21;
        r0.<init>(r3);	 Catch:{ IOException -> 0x0931, all -> 0x0928 }
    L_0x08f3:
        r25 = r21.readLine();	 Catch:{ IOException -> 0x0912, all -> 0x092d }
        if (r25 == 0) goto L_0x0924;
    L_0x08f9:
        r3 = "ignored: updated version";
        r0 = r25;
        r3 = r0.contains(r3);	 Catch:{ IOException -> 0x0912, all -> 0x092d }
        if (r3 != 0) goto L_0x08f3;
    L_0x0903:
        r3 = "msg,";
        r0 = r39;
        r0.print(r3);	 Catch:{ IOException -> 0x0912, all -> 0x092d }
        r0 = r39;
        r1 = r25;
        r0.println(r1);	 Catch:{ IOException -> 0x0912, all -> 0x092d }
        goto L_0x08f3;
    L_0x0912:
        r3 = move-exception;
        r20 = r21;
    L_0x0915:
        libcore.io.IoUtils.closeQuietly(r20);	 Catch:{ all -> 0x01ca }
    L_0x0918:
        monitor-exit(r36);	 Catch:{ all -> 0x01ca }
        goto L_0x0042;
    L_0x091b:
        libcore.io.IoUtils.closeQuietly(r21);	 Catch:{ all -> 0x01ca }
        goto L_0x08d5;
    L_0x091f:
        r3 = move-exception;
    L_0x0920:
        libcore.io.IoUtils.closeQuietly(r20);	 Catch:{ all -> 0x01ca }
        throw r3;	 Catch:{ all -> 0x01ca }
    L_0x0924:
        libcore.io.IoUtils.closeQuietly(r21);	 Catch:{ all -> 0x01ca }
        goto L_0x0918;
    L_0x0928:
        r3 = move-exception;
    L_0x0929:
        libcore.io.IoUtils.closeQuietly(r20);	 Catch:{ all -> 0x01ca }
        throw r3;	 Catch:{ all -> 0x01ca }
    L_0x092d:
        r3 = move-exception;
        r20 = r21;
        goto L_0x0929;
    L_0x0931:
        r3 = move-exception;
        goto L_0x0915;
    L_0x0933:
        r3 = move-exception;
        r20 = r21;
        goto L_0x0920;
    L_0x0937:
        r3 = move-exception;
        goto L_0x08d2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageManagerService.dump(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String[]):void");
    }

    static String getEncryptKey() {
        try {
            String sdEncKey = SystemKeyStore.getInstance().retrieveKeyHexString(SD_ENCRYPTION_KEYSTORE_NAME);
            if (sdEncKey != null) {
                return sdEncKey;
            }
            sdEncKey = SystemKeyStore.getInstance().generateNewKeyHexString(SCAN_DEFER_DEX, SD_ENCRYPTION_ALGORITHM, SD_ENCRYPTION_KEYSTORE_NAME);
            if (sdEncKey != null) {
                return sdEncKey;
            }
            Slog.e(TAG, "Failed to create encryption keys");
            return null;
        } catch (NoSuchAlgorithmException nsae) {
            Slog.e(TAG, "Failed to create encryption keys with exception: " + nsae);
            return null;
        } catch (IOException ioe) {
            Slog.e(TAG, "Failed to retrieve encryption keys with exception: " + ioe);
            return null;
        }
    }

    public void updateExternalMediaStatus(boolean mediaStatus, boolean reportStatus) {
        int callingUid = Binder.getCallingUid();
        if (callingUid == 0 || callingUid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            synchronized (this.mPackages) {
                Log.i(TAG, "Updating external media status from " + (this.mMediaMounted ? "mounted" : "unmounted") + " to " + (mediaStatus ? "mounted" : "unmounted"));
                if (mediaStatus == this.mMediaMounted) {
                    this.mHandler.sendMessage(this.mHandler.obtainMessage(UPDATED_MEDIA_STATUS, reportStatus ? UPDATE_PERMISSIONS_ALL : DEX_OPT_SKIPPED, DEX_OPT_FAILED));
                    return;
                }
                this.mMediaMounted = mediaStatus;
                this.mHandler.post(new AnonymousClass11(mediaStatus, reportStatus));
                return;
            }
        }
        throw new SecurityException("Media status can only be updated by the system");
    }

    public void scanAvailableAsecs() {
        updateExternalMediaStatusInner(DEFAULT_VERIFY_ENABLE, DEBUG_VERIFY, DEBUG_VERIFY);
        if (this.mShouldRestoreconData) {
            SELinuxMMAC.setRestoreconDone();
            this.mShouldRestoreconData = DEBUG_VERIFY;
        }
    }

    private void updateExternalMediaStatusInner(boolean isMounted, boolean reportStatus, boolean externalStorage) {
        ArrayMap<AsecInstallArgs, String> processCids = new ArrayMap();
        int[] uidArr = EmptyArray.INT;
        String[] list = PackageHelper.getSecureContainerList();
        if (ArrayUtils.isEmpty(list)) {
            Log.i(TAG, "No secure containers found");
        } else {
            synchronized (this.mPackages) {
                String[] arr$ = list;
                int len$ = arr$.length;
                for (int i$ = DEX_OPT_SKIPPED; i$ < len$; i$ += UPDATE_PERMISSIONS_ALL) {
                    String cid = arr$[i$];
                    if (!PackageInstallerService.isStageName(cid)) {
                        String pkgName = getAsecPackageName(cid);
                        if (pkgName == null) {
                            Slog.i(TAG, "Found stale container " + cid + " with no package name");
                        } else {
                            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(pkgName);
                            if (ps == null) {
                                Slog.i(TAG, "Found stale container " + cid + " with no matching settings");
                            } else if (!externalStorage || isMounted || isExternal(ps)) {
                                AsecInstallArgs args = new AsecInstallArgs(this, cid, getAppDexInstructionSets(ps), isForwardLocked(ps));
                                if (ps.codePathString == null || !ps.codePathString.startsWith(args.getCodePath())) {
                                    Slog.i(TAG, "Found stale container " + cid + ": expected codePath=" + ps.codePathString);
                                } else {
                                    processCids.put(args, ps.codePathString);
                                    int uid = ps.appId;
                                    if (uid != DEX_OPT_FAILED) {
                                        uidArr = ArrayUtils.appendInt(uidArr, uid);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Arrays.sort(uidArr);
        }
        if (isMounted) {
            loadMediaPackages(processCids, uidArr);
            startCleaningPackages();
            this.mInstallerService.onSecureContainersAvailable();
            return;
        }
        unloadMediaPackages(processCids, uidArr, reportStatus);
    }

    private void sendResourcesChangedBroadcast(boolean mediaStatus, boolean replacing, ArrayList<String> pkgList, int[] uidArr, IIntentReceiver finishedReceiver) {
        int size = pkgList.size();
        if (size > 0) {
            Bundle extras = new Bundle();
            extras.putStringArray("android.intent.extra.changed_package_list", (String[]) pkgList.toArray(new String[size]));
            if (uidArr != null) {
                extras.putIntArray("android.intent.extra.changed_uid_list", uidArr);
            }
            if (replacing) {
                extras.putBoolean("android.intent.extra.REPLACING", replacing);
            }
            sendPackageBroadcast(mediaStatus ? "android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE" : "android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE", null, extras, null, finishedReceiver, null);
        }
    }

    private void loadMediaPackages(ArrayMap<AsecInstallArgs, String> processCids, int[] uidArr) {
        ArrayList<String> pkgList = new ArrayList();
        for (AsecInstallArgs args : processCids.keySet()) {
            String codePath = (String) processCids.get(args);
            int retCode = -18;
            if (args.doPreInstall(UPDATE_PERMISSIONS_ALL) != UPDATE_PERMISSIONS_ALL) {
                Slog.e(TAG, "Failed to mount cid : " + args.cid + " when installing from sdcard");
                if (-18 != UPDATE_PERMISSIONS_ALL) {
                    Log.w(TAG, "Container " + args.cid + " is stale, retCode=" + -18);
                }
            } else {
                if (codePath != null) {
                    if (codePath.startsWith(args.getCodePath())) {
                        try {
                            int parseFlags = this.mDefParseFlags;
                            if (args.isExternal()) {
                                parseFlags |= SCAN_NO_PATHS;
                            }
                            if (args.isFwdLocked()) {
                                parseFlags |= SCAN_NEW_INSTALL;
                            }
                            synchronized (this.mInstallLock) {
                                Package pkg = null;
                                try {
                                    pkg = scanPackageLI(new File(codePath), parseFlags, (int) DEX_OPT_SKIPPED, 0, null);
                                } catch (PackageManagerException e) {
                                    Slog.w(TAG, "Failed to scan " + codePath + ": " + e.getMessage());
                                }
                                if (pkg != null) {
                                    synchronized (this.mPackages) {
                                        retCode = UPDATE_PERMISSIONS_ALL;
                                        pkgList.add(pkg.packageName);
                                        args.doPostInstall(UPDATE_PERMISSIONS_ALL, pkg.applicationInfo.uid);
                                    }
                                } else {
                                    Slog.i(TAG, "Failed to install pkg from  " + codePath + " from sdcard");
                                }
                            }
                            if (retCode != UPDATE_PERMISSIONS_ALL) {
                                Log.w(TAG, "Container " + args.cid + " is stale, retCode=" + retCode);
                            }
                        } catch (Throwable th) {
                            if (retCode != UPDATE_PERMISSIONS_ALL) {
                                Log.w(TAG, "Container " + args.cid + " is stale, retCode=" + retCode);
                            }
                        }
                    }
                }
                Slog.e(TAG, "Container " + args.cid + " cachepath " + args.getCodePath() + " does not match one in settings " + codePath);
                if (-18 != UPDATE_PERMISSIONS_ALL) {
                    Log.w(TAG, "Container " + args.cid + " is stale, retCode=" + -18);
                }
            }
        }
        synchronized (this.mPackages) {
            boolean regrantPermissions = this.mSettings.mExternalSdkPlatform != this.mSdkVersion ? DEFAULT_VERIFY_ENABLE : DEBUG_VERIFY;
            if (regrantPermissions) {
                Slog.i(TAG, "Platform changed from " + this.mSettings.mExternalSdkPlatform + " to " + this.mSdkVersion + "; regranting permissions for external storage");
            }
            this.mSettings.mExternalSdkPlatform = this.mSdkVersion;
            updatePermissionsLPw(null, null, (regrantPermissions ? MCS_UNBIND : DEX_OPT_SKIPPED) | UPDATE_PERMISSIONS_ALL);
            this.mSettings.updateExternalDatabaseVersion();
            this.mSettings.writeLPr();
        }
        if (pkgList.size() > 0) {
            sendResourcesChangedBroadcast(DEFAULT_VERIFY_ENABLE, DEBUG_VERIFY, pkgList, uidArr, null);
        }
    }

    private void unloadAllContainers(Set<AsecInstallArgs> cidArgs) {
        for (AsecInstallArgs arg : cidArgs) {
            synchronized (this.mInstallLock) {
                arg.doPostDeleteLI(DEBUG_VERIFY);
            }
        }
    }

    private void unloadMediaPackages(ArrayMap<AsecInstallArgs, String> processCids, int[] uidArr, boolean reportStatus) {
        ArrayList<String> pkgList = new ArrayList();
        ArrayList<AsecInstallArgs> failedList = new ArrayList();
        Set<AsecInstallArgs> keys = processCids.keySet();
        for (AsecInstallArgs args : keys) {
            String pkgName = args.getPackageName();
            PackageRemovedInfo outInfo = new PackageRemovedInfo();
            synchronized (this.mInstallLock) {
                if (deletePackageLI(pkgName, null, DEBUG_VERIFY, null, null, UPDATE_PERMISSIONS_ALL, outInfo, DEBUG_VERIFY)) {
                    pkgList.add(pkgName);
                } else {
                    Slog.e(TAG, "Failed to delete pkg from sdcard : " + pkgName);
                    failedList.add(args);
                }
            }
        }
        synchronized (this.mPackages) {
            this.mSettings.writeLPr();
        }
        if (pkgList.size() > 0) {
            sendResourcesChangedBroadcast(DEBUG_VERIFY, DEBUG_VERIFY, pkgList, uidArr, new AnonymousClass12(reportStatus, keys));
        } else {
            this.mHandler.sendMessage(this.mHandler.obtainMessage(UPDATED_MEDIA_STATUS, reportStatus ? UPDATE_PERMISSIONS_ALL : DEX_OPT_SKIPPED, DEX_OPT_FAILED, keys));
        }
    }

    public void movePackage(String packageName, IPackageMoveObserver observer, int flags) {
        Throwable th;
        this.mContext.enforceCallingOrSelfPermission("android.permission.MOVE_PACKAGE", null);
        UserHandle user = new UserHandle(UserHandle.getCallingUserId());
        int returnCode = UPDATE_PERMISSIONS_ALL;
        int newInstallFlags = DEX_OPT_SKIPPED;
        File codeFile = null;
        String installerPackageName = null;
        String packageAbiOverride = null;
        synchronized (this.mPackages) {
            Package pkg = (Package) this.mPackages.get(packageName);
            PackageSetting ps = (PackageSetting) this.mSettings.mPackages.get(packageName);
            if (pkg == null || ps == null) {
                returnCode = -2;
            } else {
                if (pkg.applicationInfo == null || !isSystemApp(pkg)) {
                    try {
                        if (pkg.mOperationPending) {
                            Slog.w(TAG, "Attempt to move package which has pending operations");
                            returnCode = -7;
                        } else {
                            if ((flags & UPDATE_PERMISSIONS_REPLACE_PKG) == 0 || (flags & UPDATE_PERMISSIONS_ALL) == 0) {
                                newInstallFlags = (flags & UPDATE_PERMISSIONS_REPLACE_PKG) != 0 ? SCAN_UPDATE_SIGNATURE : SCAN_NEW_INSTALL;
                                int currInstallFlags = isExternal(pkg) ? SCAN_UPDATE_SIGNATURE : SCAN_NEW_INSTALL;
                                if (newInstallFlags == currInstallFlags) {
                                    Slog.w(TAG, "No move required. Trying to move to same location");
                                    returnCode = -5;
                                } else if (isForwardLocked(pkg)) {
                                    currInstallFlags |= UPDATE_PERMISSIONS_ALL;
                                    newInstallFlags |= UPDATE_PERMISSIONS_ALL;
                                }
                            } else {
                                Slog.w(TAG, "Ambigous flags specified for move location.");
                                returnCode = -5;
                            }
                            if (returnCode == UPDATE_PERMISSIONS_ALL) {
                                pkg.mOperationPending = DEFAULT_VERIFY_ENABLE;
                            }
                        }
                    } catch (Throwable th2) {
                        th = th2;
                        throw th;
                    }
                }
                Slog.w(TAG, "Cannot move system application");
                returnCode = -3;
                File codeFile2 = new File(pkg.codePath);
                try {
                    installerPackageName = ps.installerPackageName;
                    packageAbiOverride = ps.cpuAbiOverrideString;
                    codeFile = codeFile2;
                } catch (Throwable th3) {
                    th = th3;
                    codeFile = codeFile2;
                    throw th;
                }
            }
            if (returnCode != UPDATE_PERMISSIONS_ALL) {
                try {
                    observer.packageMoved(packageName, returnCode);
                    return;
                } catch (RemoteException e) {
                    return;
                }
            }
            IPackageInstallObserver2 installObserver = new AnonymousClass13(packageName, observer);
            newInstallFlags |= UPDATE_PERMISSIONS_REPLACE_PKG;
            Message msg = this.mHandler.obtainMessage(INIT_COPY);
            msg.obj = new InstallParams(OriginInfo.fromExistingFile(codeFile), installObserver, newInstallFlags, installerPackageName, null, user, packageAbiOverride);
            this.mHandler.sendMessage(msg);
        }
    }

    public boolean setInstallLocation(int loc) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS", null);
        if (getInstallLocation() == loc) {
            return DEFAULT_VERIFY_ENABLE;
        }
        if (loc != 0 && loc != UPDATE_PERMISSIONS_ALL && loc != UPDATE_PERMISSIONS_REPLACE_PKG) {
            return DEBUG_VERIFY;
        }
        Global.putInt(this.mContext.getContentResolver(), "default_install_location", loc);
        return DEFAULT_VERIFY_ENABLE;
    }

    public int getInstallLocation() {
        return Global.getInt(this.mContext.getContentResolver(), "default_install_location", DEX_OPT_SKIPPED);
    }

    void cleanUpUserLILPw(UserManagerService userManager, int userHandle) {
        this.mDirtyUsers.remove(Integer.valueOf(userHandle));
        this.mSettings.removeUserLPw(userHandle);
        this.mPendingBroadcasts.remove(userHandle);
        if (this.mInstaller != null) {
            this.mInstaller.removeUserDataDirs(userHandle);
        }
        this.mUserNeedsBadging.delete(userHandle);
        removeUnusedPackagesLILPw(userManager, userHandle);
    }

    private void removeUnusedPackagesLILPw(UserManagerService userManager, int userHandle) {
        int[] users = userManager.getUserIdsLPr();
        for (PackageSetting ps : this.mSettings.mPackages.values()) {
            if (ps.pkg != null) {
                String packageName = ps.pkg.packageName;
                if ((ps.pkgFlags & UPDATE_PERMISSIONS_ALL) == 0) {
                    boolean keep = DEBUG_VERIFY;
                    int i = DEX_OPT_SKIPPED;
                    while (i < users.length) {
                        if (users[i] != userHandle && ps.getInstalled(users[i])) {
                            keep = DEFAULT_VERIFY_ENABLE;
                            break;
                        }
                        i += UPDATE_PERMISSIONS_ALL;
                    }
                    if (!keep) {
                        this.mHandler.post(new AnonymousClass14(packageName, userHandle));
                    }
                }
            }
        }
    }

    void createNewUserLILPw(int userHandle, File path) {
        if (this.mInstaller != null) {
            this.mInstaller.createUserConfig(userHandle);
            this.mSettings.createNewUserLILPw(this, this.mInstaller, userHandle, path);
        }
    }

    public VerifierDeviceIdentity getVerifierDeviceIdentity() throws RemoteException {
        VerifierDeviceIdentity verifierDeviceIdentityLPw;
        this.mContext.enforceCallingOrSelfPermission("android.permission.PACKAGE_VERIFICATION_AGENT", "Only package verification agents can read the verifier device identity");
        synchronized (this.mPackages) {
            verifierDeviceIdentityLPw = this.mSettings.getVerifierDeviceIdentityLPw();
        }
        return verifierDeviceIdentityLPw;
    }

    public void setPermissionEnforced(String permission, boolean enforced) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.GRANT_REVOKE_PERMISSIONS", null);
        if ("android.permission.READ_EXTERNAL_STORAGE".equals(permission)) {
            synchronized (this.mPackages) {
                if (this.mSettings.mReadExternalStorageEnforced == null || this.mSettings.mReadExternalStorageEnforced.booleanValue() != enforced) {
                    this.mSettings.mReadExternalStorageEnforced = Boolean.valueOf(enforced);
                    this.mSettings.writeLPr();
                }
            }
            IActivityManager am = ActivityManagerNative.getDefault();
            if (am != null) {
                long token = Binder.clearCallingIdentity();
                try {
                    am.killProcessesBelowForeground("setPermissionEnforcement");
                } catch (RemoteException e) {
                } finally {
                    Binder.restoreCallingIdentity(token);
                }
                return;
            }
            return;
        }
        throw new IllegalArgumentException("No selective enforcement for " + permission);
    }

    @Deprecated
    public boolean isPermissionEnforced(String permission) {
        return DEFAULT_VERIFY_ENABLE;
    }

    public boolean isStorageLow() {
        long token = Binder.clearCallingIdentity();
        try {
            DeviceStorageMonitorInternal dsm = (DeviceStorageMonitorInternal) LocalServices.getService(DeviceStorageMonitorInternal.class);
            if (dsm != null) {
                boolean isMemoryLow = dsm.isMemoryLow();
                return isMemoryLow;
            }
            Binder.restoreCallingIdentity(token);
            return DEBUG_VERIFY;
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public IPackageInstaller getPackageInstaller() {
        return this.mInstallerService;
    }

    private boolean userNeedsBadging(int userId) {
        int index = this.mUserNeedsBadging.indexOfKey(userId);
        if (index >= 0) {
            return this.mUserNeedsBadging.valueAt(index);
        }
        long token = Binder.clearCallingIdentity();
        try {
            boolean b;
            UserInfo userInfo = sUserManager.getUserInfo(userId);
            if (userInfo == null || !userInfo.isManagedProfile()) {
                b = DEBUG_VERIFY;
            } else {
                b = DEFAULT_VERIFY_ENABLE;
            }
            this.mUserNeedsBadging.put(userId, b);
            return b;
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public KeySet getKeySetByAlias(String packageName, String alias) {
        if (packageName == null || alias == null) {
            return null;
        }
        KeySet keySet;
        synchronized (this.mPackages) {
            if (((Package) this.mPackages.get(packageName)) == null) {
                Slog.w(TAG, "KeySet requested for unknown package:" + packageName);
                throw new IllegalArgumentException("Unknown package: " + packageName);
            }
            keySet = new KeySet(this.mSettings.mKeySetManagerService.getKeySetByAliasAndPackageNameLPr(packageName, alias));
        }
        return keySet;
    }

    public KeySet getSigningKeySet(String packageName) {
        if (packageName == null) {
            return null;
        }
        KeySet keySet;
        synchronized (this.mPackages) {
            Package pkg = (Package) this.mPackages.get(packageName);
            if (pkg == null) {
                Slog.w(TAG, "KeySet requested for unknown package:" + packageName);
                throw new IllegalArgumentException("Unknown package: " + packageName);
            } else if (pkg.applicationInfo.uid == Binder.getCallingUid() || ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE == Binder.getCallingUid()) {
                keySet = new KeySet(this.mSettings.mKeySetManagerService.getSigningKeySetByPackageNameLPr(packageName));
            } else {
                throw new SecurityException("May not access signing KeySet of other apps.");
            }
        }
        return keySet;
    }

    public boolean isPackageSignedByKeySet(String packageName, KeySet ks) {
        boolean z = DEBUG_VERIFY;
        if (!(packageName == null || ks == null)) {
            synchronized (this.mPackages) {
                if (((Package) this.mPackages.get(packageName)) == null) {
                    Slog.w(TAG, "KeySet requested for unknown package:" + packageName);
                    throw new IllegalArgumentException("Unknown package: " + packageName);
                }
                IBinder ksh = ks.getToken();
                if (ksh instanceof KeySetHandle) {
                    z = this.mSettings.mKeySetManagerService.packageIsSignedByLPr(packageName, (KeySetHandle) ksh);
                }
            }
        }
        return z;
    }

    public boolean isPackageSignedByKeySetExactly(String packageName, KeySet ks) {
        boolean z = DEBUG_VERIFY;
        if (!(packageName == null || ks == null)) {
            synchronized (this.mPackages) {
                if (((Package) this.mPackages.get(packageName)) == null) {
                    Slog.w(TAG, "KeySet requested for unknown package:" + packageName);
                    throw new IllegalArgumentException("Unknown package: " + packageName);
                }
                IBinder ksh = ks.getToken();
                if (ksh instanceof KeySetHandle) {
                    z = this.mSettings.mKeySetManagerService.packageIsSignedByExactlyLPr(packageName, (KeySetHandle) ksh);
                }
            }
        }
        return z;
    }

    public void getUsageStatsIfNoPackageUsageInfo() {
        if (!this.mPackageUsage.isHistoricalPackageUsageAvailable()) {
            UsageStatsManager usm = (UsageStatsManager) this.mContext.getSystemService("usagestats");
            if (usm == null) {
                throw new IllegalStateException("UsageStatsManager must be initialized");
            }
            long now = System.currentTimeMillis();
            for (Entry<String, UsageStats> entry : usm.queryAndAggregateUsageStats(now - this.mDexOptLRUThresholdInMills, now).entrySet()) {
                Package pkg = (Package) this.mPackages.get((String) entry.getKey());
                if (pkg != null) {
                    pkg.mLastPackageUsageTimeInMills = ((UsageStats) entry.getValue()).getLastTimeUsed();
                    this.mPackageUsage.mIsHistoricalPackageUsageAvailable = DEFAULT_VERIFY_ENABLE;
                }
            }
        }
    }

    private static void checkDowngrade(Package before, PackageInfoLite after) throws PackageManagerException {
        if (after.versionCode < before.mVersionCode) {
            throw new PackageManagerException(-25, "Update version code " + after.versionCode + " is older than current " + before.mVersionCode);
        } else if (after.versionCode != before.mVersionCode) {
        } else {
            if (after.baseRevisionCode < before.baseRevisionCode) {
                throw new PackageManagerException(-25, "Update base revision code " + after.baseRevisionCode + " is older than current " + before.baseRevisionCode);
            } else if (!ArrayUtils.isEmpty(after.splitNames)) {
                int i = DEX_OPT_SKIPPED;
                while (i < after.splitNames.length) {
                    String splitName = after.splitNames[i];
                    int j = ArrayUtils.indexOf(before.splitNames, splitName);
                    if (j == DEX_OPT_FAILED || after.splitRevisionCodes[i] >= before.splitRevisionCodes[j]) {
                        i += UPDATE_PERMISSIONS_ALL;
                    } else {
                        throw new PackageManagerException(-25, "Update split " + splitName + " revision code " + after.splitRevisionCodes[i] + " is older than current " + before.splitRevisionCodes[j]);
                    }
                }
            }
        }
    }
}
