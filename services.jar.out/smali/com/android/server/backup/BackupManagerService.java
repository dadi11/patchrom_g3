package com.android.server.backup;

import android.app.ActivityManagerNative;
import android.app.AlarmManager;
import android.app.AppGlobals;
import android.app.IActivityManager;
import android.app.IBackupAgent;
import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.app.backup.BackupDataInput;
import android.app.backup.BackupDataOutput;
import android.app.backup.FullBackup;
import android.app.backup.IBackupManager;
import android.app.backup.IFullBackupRestoreObserver;
import android.app.backup.IRestoreObserver;
import android.app.backup.IRestoreSession;
import android.app.backup.IRestoreSession.Stub;
import android.app.backup.RestoreDescription;
import android.app.backup.RestoreSet;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.ApplicationInfo;
import android.content.pm.IPackageDataObserver;
import android.content.pm.IPackageDeleteObserver;
import android.content.pm.IPackageInstallObserver;
import android.content.pm.IPackageManager;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.pm.Signature;
import android.database.ContentObserver;
import android.net.Uri;
import android.os.Binder;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.Environment;
import android.os.Environment.UserEnvironment;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.ParcelFileDescriptor;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.SELinux;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.WorkSource;
import android.os.storage.IMountService;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.system.ErrnoException;
import android.system.Os;
import android.util.ArrayMap;
import android.util.AtomicFile;
import android.util.EventLog;
import android.util.Slog;
import android.util.SparseArray;
import android.util.StringBuilderPrinter;
import com.android.internal.backup.IBackupTransport;
import com.android.internal.backup.IObbBackupService;
import com.android.server.AppWidgetBackupBridge;
import com.android.server.EventLogTags;
import com.android.server.SystemService;
import com.android.server.backup.PackageManagerBackupAgent.Metadata;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.EOFException;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Random;
import java.util.Set;
import java.util.TreeMap;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.zip.Deflater;
import java.util.zip.DeflaterOutputStream;
import java.util.zip.InflaterInputStream;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import libcore.io.IoUtils;

public class BackupManagerService {
    static final String BACKUP_FILE_HEADER_MAGIC = "ANDROID BACKUP\n";
    static final int BACKUP_FILE_VERSION = 3;
    private static final long BACKUP_INTERVAL = 3600000;
    static final String BACKUP_MANIFEST_FILENAME = "_manifest";
    static final int BACKUP_MANIFEST_VERSION = 1;
    static final String BACKUP_METADATA_FILENAME = "_meta";
    static final int BACKUP_METADATA_VERSION = 1;
    static final int BACKUP_PW_FILE_VERSION = 2;
    static final int BACKUP_WIDGET_METADATA_TOKEN = 33549569;
    static final boolean COMPRESS_FULL_BACKUPS = true;
    static final int CURRENT_ANCESTRAL_RECORD_VERSION = 1;
    private static final boolean DEBUG = true;
    static final boolean DEBUG_BACKUP_TRACE = true;
    private static final boolean DEBUG_SCHEDULING = true;
    static final String ENCRYPTION_ALGORITHM_NAME = "AES-256";
    private static final long FIRST_BACKUP_INTERVAL = 43200000;
    private static final int FUZZ_MILLIS = 300000;
    static final String INIT_SENTINEL_FILE_NAME = "_need_init_";
    static final String KEY_WIDGET_STATE = "\uffed\uffedwidget";
    static final long MIN_FULL_BACKUP_INTERVAL = 86400000;
    private static final boolean MORE_DEBUG = false;
    static final int MSG_BACKUP_RESTORE_STEP = 20;
    private static final int MSG_FULL_CONFIRMATION_TIMEOUT = 9;
    static final int MSG_OP_COMPLETE = 21;
    private static final int MSG_RESTORE_TIMEOUT = 8;
    private static final int MSG_RETRY_CLEAR = 12;
    private static final int MSG_RETRY_INIT = 11;
    private static final int MSG_RUN_ADB_BACKUP = 2;
    private static final int MSG_RUN_ADB_RESTORE = 10;
    private static final int MSG_RUN_BACKUP = 1;
    private static final int MSG_RUN_CLEAR = 4;
    private static final int MSG_RUN_FULL_TRANSPORT_BACKUP = 14;
    private static final int MSG_RUN_GET_RESTORE_SETS = 6;
    private static final int MSG_RUN_INITIALIZE = 5;
    private static final int MSG_RUN_RESTORE = 3;
    private static final int MSG_TIMEOUT = 7;
    private static final int MSG_WIDGET_BROADCAST = 13;
    static final int OP_ACKNOWLEDGED = 1;
    static final int OP_PENDING = 0;
    static final int OP_TIMEOUT = -1;
    static final String PACKAGE_MANAGER_SENTINEL = "@pm@";
    static final int PBKDF2_HASH_ROUNDS = 10000;
    static final int PBKDF2_KEY_SIZE = 256;
    static final int PBKDF2_SALT_SIZE = 512;
    static final String PBKDF_CURRENT = "PBKDF2WithHmacSHA1";
    static final String PBKDF_FALLBACK = "PBKDF2WithHmacSHA1And8bit";
    private static final String RUN_BACKUP_ACTION = "android.app.backup.intent.RUN";
    private static final String RUN_CLEAR_ACTION = "android.app.backup.intent.CLEAR";
    private static final String RUN_INITIALIZE_ACTION = "android.app.backup.intent.INIT";
    static final int SCHEDULE_FILE_VERSION = 1;
    static final String SERVICE_ACTION_TRANSPORT_HOST = "android.backup.TRANSPORT_HOST";
    static final String SETTINGS_PACKAGE = "com.android.providers.settings";
    static final String SHARED_BACKUP_AGENT_PACKAGE = "com.android.sharedstoragebackup";
    private static final String TAG = "BackupManagerService";
    static final long TIMEOUT_BACKUP_INTERVAL = 30000;
    static final long TIMEOUT_FULL_BACKUP_INTERVAL = 300000;
    static final long TIMEOUT_FULL_CONFIRMATION = 60000;
    static final long TIMEOUT_INTERVAL = 10000;
    static final long TIMEOUT_RESTORE_FINISHED_INTERVAL = 30000;
    static final long TIMEOUT_RESTORE_INTERVAL = 60000;
    static final long TIMEOUT_SHARED_BACKUP_INTERVAL = 1800000;
    private static final long TRANSPORT_RETRY_INTERVAL = 3600000;
    static Trampoline sInstance;
    ActiveRestoreSession mActiveRestoreSession;
    private IActivityManager mActivityManager;
    final Object mAgentConnectLock;
    private AlarmManager mAlarmManager;
    Set<String> mAncestralPackages;
    long mAncestralToken;
    boolean mAutoRestore;
    BackupHandler mBackupHandler;
    IBackupManager mBackupManagerBinder;
    final SparseArray<HashSet<String>> mBackupParticipants;
    volatile boolean mBackupRunning;
    final List<String> mBackupTrace;
    File mBaseStateDir;
    BroadcastReceiver mBroadcastReceiver;
    final Object mClearDataLock;
    volatile boolean mClearingData;
    IBackupAgent mConnectedAgent;
    volatile boolean mConnecting;
    Context mContext;
    final Object mCurrentOpLock;
    final SparseArray<Operation> mCurrentOperations;
    long mCurrentToken;
    String mCurrentTransport;
    File mDataDir;
    boolean mEnabled;
    private File mEverStored;
    HashSet<String> mEverStoredApps;
    ArrayList<FullBackupEntry> mFullBackupQueue;
    File mFullBackupScheduleFile;
    Runnable mFullBackupScheduleWriter;
    final SparseArray<FullParams> mFullConfirmations;
    HandlerThread mHandlerThread;
    File mJournal;
    File mJournalDir;
    volatile long mLastBackupPass;
    private IMountService mMountService;
    volatile long mNextBackupPass;
    private PackageManager mPackageManager;
    IPackageManager mPackageManagerBinder;
    private String mPasswordHash;
    private File mPasswordHashFile;
    private byte[] mPasswordSalt;
    private int mPasswordVersion;
    private File mPasswordVersionFile;
    HashMap<String, BackupRequest> mPendingBackups;
    HashSet<String> mPendingInits;
    private PowerManager mPowerManager;
    boolean mProvisioned;
    ContentObserver mProvisionedObserver;
    final Object mQueueLock;
    private final SecureRandom mRng;
    PendingIntent mRunBackupIntent;
    BroadcastReceiver mRunBackupReceiver;
    PendingIntent mRunInitIntent;
    BroadcastReceiver mRunInitReceiver;
    PerformFullTransportBackupTask mRunningFullBackupTask;
    File mTokenFile;
    final Random mTokenGenerator;
    final ArrayMap<String, TransportConnection> mTransportConnections;
    final ArrayMap<String, String> mTransportNames;
    final Intent mTransportServiceIntent;
    final ArrayMap<String, IBackupTransport> mTransports;
    WakeLock mWakelock;

    /* renamed from: com.android.server.backup.BackupManagerService.1 */
    class C01561 implements Runnable {
        C01561() {
        }

        public void run() {
            synchronized (BackupManagerService.this.mQueueLock) {
                try {
                    ByteArrayOutputStream bufStream = new ByteArrayOutputStream(DumpState.DUMP_VERSION);
                    DataOutputStream bufOut = new DataOutputStream(bufStream);
                    bufOut.writeInt(BackupManagerService.SCHEDULE_FILE_VERSION);
                    int N = BackupManagerService.this.mFullBackupQueue.size();
                    bufOut.writeInt(N);
                    for (int i = BackupManagerService.OP_PENDING; i < N; i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                        FullBackupEntry entry = (FullBackupEntry) BackupManagerService.this.mFullBackupQueue.get(i);
                        bufOut.writeUTF(entry.packageName);
                        bufOut.writeLong(entry.lastBackup);
                    }
                    bufOut.flush();
                    AtomicFile af = new AtomicFile(BackupManagerService.this.mFullBackupScheduleFile);
                    FileOutputStream out = af.startWrite();
                    out.write(bufStream.toByteArray());
                    af.finishWrite(out);
                } catch (Exception e) {
                    Slog.e(BackupManagerService.TAG, "Unable to write backup schedule!", e);
                }
            }
        }
    }

    /* renamed from: com.android.server.backup.BackupManagerService.2 */
    class C01572 extends BroadcastReceiver {
        C01572() {
        }

        public void onReceive(Context context, Intent intent) {
            PackageInfo app;
            TransportConnection conn;
            Slog.d(BackupManagerService.TAG, "Received broadcast " + intent);
            String action = intent.getAction();
            boolean replacing = BackupManagerService.MORE_DEBUG;
            boolean added = BackupManagerService.MORE_DEBUG;
            Bundle extras = intent.getExtras();
            String[] pkgList = null;
            if (!"android.intent.action.PACKAGE_ADDED".equals(action)) {
                if (!"android.intent.action.PACKAGE_REMOVED".equals(action)) {
                    if (!"android.intent.action.PACKAGE_CHANGED".equals(action)) {
                        if ("android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE".equals(action)) {
                            added = BackupManagerService.DEBUG_SCHEDULING;
                            pkgList = intent.getStringArrayExtra("android.intent.extra.changed_package_list");
                        } else {
                            if ("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE".equals(action)) {
                                added = BackupManagerService.MORE_DEBUG;
                                pkgList = intent.getStringArrayExtra("android.intent.extra.changed_package_list");
                            }
                        }
                        if (pkgList != null && pkgList.length != 0) {
                            int uid = extras.getInt("android.intent.extra.UID");
                            if (added) {
                                synchronized (BackupManagerService.this.mBackupParticipants) {
                                    if (replacing) {
                                        BackupManagerService.this.removePackageParticipantsLocked(pkgList, uid);
                                    }
                                    BackupManagerService.this.addPackageParticipantsLocked(pkgList);
                                }
                                String[] arr$ = pkgList;
                                int len$ = arr$.length;
                                for (int i$ = BackupManagerService.OP_PENDING; i$ < len$; i$ += BackupManagerService.SCHEDULE_FILE_VERSION) {
                                    String packageName = arr$[i$];
                                    try {
                                        app = BackupManagerService.this.mPackageManager.getPackageInfo(packageName, BackupManagerService.OP_PENDING);
                                        long now = System.currentTimeMillis();
                                        if (BackupManagerService.appGetsFullBackup(app)) {
                                            BackupManagerService.this.enqueueFullBackup(packageName, now);
                                            BackupManagerService.this.scheduleNextFullBackupJob();
                                        }
                                        synchronized (BackupManagerService.this.mTransports) {
                                            conn = (TransportConnection) BackupManagerService.this.mTransportConnections.get(packageName);
                                            if (conn != null) {
                                                BackupManagerService.this.bindTransport(conn.mTransport);
                                            } else {
                                                BackupManagerService.this.checkForTransportAndBind(app);
                                            }
                                        }
                                    } catch (NameNotFoundException e) {
                                        Slog.i(BackupManagerService.TAG, "Can't resolve new app " + packageName);
                                    }
                                }
                                return;
                            } else if (!replacing) {
                                synchronized (BackupManagerService.this.mBackupParticipants) {
                                    BackupManagerService.this.removePackageParticipantsLocked(pkgList, uid);
                                }
                                return;
                            } else {
                                return;
                            }
                        }
                    }
                }
            }
            Uri uri = intent.getData();
            if (uri != null) {
                String pkgName = uri.getSchemeSpecificPart();
                if (pkgName != null) {
                    pkgList = new String[BackupManagerService.SCHEDULE_FILE_VERSION];
                    pkgList[BackupManagerService.OP_PENDING] = pkgName;
                }
                if ("android.intent.action.PACKAGE_CHANGED".equals(action)) {
                    try {
                        synchronized (BackupManagerService.this.mTransports) {
                            conn = (TransportConnection) BackupManagerService.this.mTransportConnections.get(pkgName);
                            if (conn != null) {
                                ServiceInfo svc = conn.mTransport;
                                ComponentName componentName = new ComponentName(svc.packageName, svc.name);
                                String flatName = componentName.flattenToShortString();
                                Slog.i(BackupManagerService.TAG, "Unbinding " + componentName);
                                BackupManagerService.this.mContext.unbindService(conn);
                                BackupManagerService.this.mTransportConnections.remove(pkgName);
                                BackupManagerService.this.mTransports.remove(BackupManagerService.this.mTransportNames.get(flatName));
                                BackupManagerService.this.mTransportNames.remove(flatName);
                            }
                        }
                        app = BackupManagerService.this.mPackageManager.getPackageInfo(pkgName, BackupManagerService.OP_PENDING);
                        BackupManagerService.this.checkForTransportAndBind(app);
                        return;
                    } catch (NameNotFoundException e2) {
                        return;
                    }
                }
                added = "android.intent.action.PACKAGE_ADDED".equals(action);
                replacing = extras.getBoolean("android.intent.extra.REPLACING", BackupManagerService.MORE_DEBUG);
                if (pkgList != null) {
                }
            }
        }
    }

    /* renamed from: com.android.server.backup.BackupManagerService.3 */
    class C01583 implements Runnable {
        final /* synthetic */ long val$latency;

        C01583(long j) {
            this.val$latency = j;
        }

        public void run() {
            FullBackupJob.schedule(BackupManagerService.this.mContext, this.val$latency);
        }
    }

    /* renamed from: com.android.server.backup.BackupManagerService.4 */
    class C01594 implements Runnable {
        final /* synthetic */ long val$latency;

        C01594(long j) {
            this.val$latency = j;
        }

        public void run() {
            FullBackupJob.schedule(BackupManagerService.this.mContext, this.val$latency);
        }
    }

    /* renamed from: com.android.server.backup.BackupManagerService.5 */
    class C01605 implements Runnable {
        final /* synthetic */ String val$packageName;
        final /* synthetic */ HashSet val$targets;

        C01605(String str, HashSet hashSet) {
            this.val$packageName = str;
            this.val$targets = hashSet;
        }

        public void run() {
            BackupManagerService.this.dataChangedImpl(this.val$packageName, this.val$targets);
        }
    }

    /* renamed from: com.android.server.backup.BackupManagerService.6 */
    static /* synthetic */ class C01616 {
        static final /* synthetic */ int[] f3x2e34116e;
        static final /* synthetic */ int[] f4x2ef7c71f;
        static final /* synthetic */ int[] f5xf60b2fd4;

        static {
            f5xf60b2fd4 = new int[UnifiedRestoreState.values().length];
            try {
                f5xf60b2fd4[UnifiedRestoreState.INITIAL.ordinal()] = BackupManagerService.SCHEDULE_FILE_VERSION;
            } catch (NoSuchFieldError e) {
            }
            try {
                f5xf60b2fd4[UnifiedRestoreState.RUNNING_QUEUE.ordinal()] = BackupManagerService.MSG_RUN_ADB_BACKUP;
            } catch (NoSuchFieldError e2) {
            }
            try {
                f5xf60b2fd4[UnifiedRestoreState.RESTORE_KEYVALUE.ordinal()] = BackupManagerService.MSG_RUN_RESTORE;
            } catch (NoSuchFieldError e3) {
            }
            try {
                f5xf60b2fd4[UnifiedRestoreState.RESTORE_FULL.ordinal()] = BackupManagerService.MSG_RUN_CLEAR;
            } catch (NoSuchFieldError e4) {
            }
            try {
                f5xf60b2fd4[UnifiedRestoreState.RESTORE_FINISHED.ordinal()] = BackupManagerService.MSG_RUN_INITIALIZE;
            } catch (NoSuchFieldError e5) {
            }
            try {
                f5xf60b2fd4[UnifiedRestoreState.FINAL.ordinal()] = BackupManagerService.MSG_RUN_GET_RESTORE_SETS;
            } catch (NoSuchFieldError e6) {
            }
            f4x2ef7c71f = new int[RestorePolicy.values().length];
            try {
                f4x2ef7c71f[RestorePolicy.IGNORE.ordinal()] = BackupManagerService.SCHEDULE_FILE_VERSION;
            } catch (NoSuchFieldError e7) {
            }
            try {
                f4x2ef7c71f[RestorePolicy.ACCEPT_IF_APK.ordinal()] = BackupManagerService.MSG_RUN_ADB_BACKUP;
            } catch (NoSuchFieldError e8) {
            }
            try {
                f4x2ef7c71f[RestorePolicy.ACCEPT.ordinal()] = BackupManagerService.MSG_RUN_RESTORE;
            } catch (NoSuchFieldError e9) {
            }
            f3x2e34116e = new int[BackupState.values().length];
            try {
                f3x2e34116e[BackupState.INITIAL.ordinal()] = BackupManagerService.SCHEDULE_FILE_VERSION;
            } catch (NoSuchFieldError e10) {
            }
            try {
                f3x2e34116e[BackupState.RUNNING_QUEUE.ordinal()] = BackupManagerService.MSG_RUN_ADB_BACKUP;
            } catch (NoSuchFieldError e11) {
            }
            try {
                f3x2e34116e[BackupState.FINAL.ordinal()] = BackupManagerService.MSG_RUN_RESTORE;
            } catch (NoSuchFieldError e12) {
            }
        }
    }

    class ActiveRestoreSession extends Stub {
        private static final String TAG = "RestoreSession";
        boolean mEnded;
        private String mPackageName;
        RestoreSet[] mRestoreSets;
        private IBackupTransport mRestoreTransport;
        boolean mTimedOut;

        class EndRestoreRunnable implements Runnable {
            BackupManagerService mBackupManager;
            ActiveRestoreSession mSession;

            EndRestoreRunnable(BackupManagerService manager, ActiveRestoreSession session) {
                this.mBackupManager = manager;
                this.mSession = session;
            }

            public void run() {
                synchronized (this.mSession) {
                    try {
                        if (this.mSession.mRestoreTransport != null) {
                            this.mSession.mRestoreTransport.finishRestore();
                        }
                        this.mSession.mRestoreTransport = null;
                        this.mSession.mEnded = BackupManagerService.DEBUG_SCHEDULING;
                    } catch (Exception e) {
                        Slog.e(ActiveRestoreSession.TAG, "Error in finishRestore", e);
                        this.mSession.mRestoreTransport = null;
                        this.mSession.mEnded = BackupManagerService.DEBUG_SCHEDULING;
                    } catch (Throwable th) {
                        this.mSession.mRestoreTransport = null;
                        this.mSession.mEnded = BackupManagerService.DEBUG_SCHEDULING;
                    }
                }
                this.mBackupManager.clearRestoreSession(this.mSession);
            }
        }

        ActiveRestoreSession(String packageName, String transport) {
            this.mRestoreTransport = null;
            this.mRestoreSets = null;
            this.mEnded = BackupManagerService.MORE_DEBUG;
            this.mTimedOut = BackupManagerService.MORE_DEBUG;
            this.mPackageName = packageName;
            this.mRestoreTransport = BackupManagerService.this.getTransport(transport);
        }

        public void markTimedOut() {
            this.mTimedOut = BackupManagerService.DEBUG_SCHEDULING;
        }

        public synchronized int getAvailableRestoreSets(IRestoreObserver observer) {
            int i = BackupManagerService.OP_TIMEOUT;
            synchronized (this) {
                BackupManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "getAvailableRestoreSets");
                if (observer == null) {
                    throw new IllegalArgumentException("Observer must not be null");
                } else if (this.mEnded) {
                    throw new IllegalStateException("Restore session already ended");
                } else {
                    if (this.mTimedOut) {
                        Slog.i(TAG, "Session already timed out");
                    } else {
                        long oldId = Binder.clearCallingIdentity();
                        try {
                            if (this.mRestoreTransport == null) {
                                Slog.w(TAG, "Null transport getting restore sets");
                            } else {
                                BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_RESTORE_TIMEOUT);
                                BackupManagerService.this.mWakelock.acquire();
                                BackupManagerService.this.mBackupHandler.sendMessage(BackupManagerService.this.mBackupHandler.obtainMessage(BackupManagerService.MSG_RUN_GET_RESTORE_SETS, new RestoreGetSetsParams(this.mRestoreTransport, this, observer)));
                                i = BackupManagerService.OP_PENDING;
                                Binder.restoreCallingIdentity(oldId);
                            }
                        } catch (Exception e) {
                            Slog.e(TAG, "Error in getAvailableRestoreSets", e);
                        } finally {
                            Binder.restoreCallingIdentity(oldId);
                        }
                    }
                }
            }
            return i;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public synchronized int restoreAll(long r16, android.app.backup.IRestoreObserver r18) {
            /*
            r15 = this;
            monitor-enter(r15);
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x0040 }
            r3 = r3.mContext;	 Catch:{ all -> 0x0040 }
            r4 = "android.permission.BACKUP";
            r5 = "performRestore";
            r3.enforceCallingOrSelfPermission(r4, r5);	 Catch:{ all -> 0x0040 }
            r3 = "RestoreSession";
            r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0040 }
            r4.<init>();	 Catch:{ all -> 0x0040 }
            r5 = "restoreAll token=";
            r4 = r4.append(r5);	 Catch:{ all -> 0x0040 }
            r5 = java.lang.Long.toHexString(r16);	 Catch:{ all -> 0x0040 }
            r4 = r4.append(r5);	 Catch:{ all -> 0x0040 }
            r5 = " observer=";
            r4 = r4.append(r5);	 Catch:{ all -> 0x0040 }
            r0 = r18;
            r4 = r4.append(r0);	 Catch:{ all -> 0x0040 }
            r4 = r4.toString();	 Catch:{ all -> 0x0040 }
            android.util.Slog.d(r3, r4);	 Catch:{ all -> 0x0040 }
            r3 = r15.mEnded;	 Catch:{ all -> 0x0040 }
            if (r3 == 0) goto L_0x0043;
        L_0x0038:
            r3 = new java.lang.IllegalStateException;	 Catch:{ all -> 0x0040 }
            r4 = "Restore session already ended";
            r3.<init>(r4);	 Catch:{ all -> 0x0040 }
            throw r3;	 Catch:{ all -> 0x0040 }
        L_0x0040:
            r3 = move-exception;
            monitor-exit(r15);
            throw r3;
        L_0x0043:
            r3 = r15.mTimedOut;	 Catch:{ all -> 0x0040 }
            if (r3 == 0) goto L_0x0051;
        L_0x0047:
            r3 = "RestoreSession";
            r4 = "Session already timed out";
            android.util.Slog.i(r3, r4);	 Catch:{ all -> 0x0040 }
            r3 = -1;
        L_0x004f:
            monitor-exit(r15);
            return r3;
        L_0x0051:
            r3 = r15.mRestoreTransport;	 Catch:{ all -> 0x0040 }
            if (r3 == 0) goto L_0x0059;
        L_0x0055:
            r3 = r15.mRestoreSets;	 Catch:{ all -> 0x0040 }
            if (r3 != 0) goto L_0x0062;
        L_0x0059:
            r3 = "RestoreSession";
            r4 = "Ignoring restoreAll() with no restore set";
            android.util.Slog.e(r3, r4);	 Catch:{ all -> 0x0040 }
            r3 = -1;
            goto L_0x004f;
        L_0x0062:
            r3 = r15.mPackageName;	 Catch:{ all -> 0x0040 }
            if (r3 == 0) goto L_0x006f;
        L_0x0066:
            r3 = "RestoreSession";
            r4 = "Ignoring restoreAll() on single-package session";
            android.util.Slog.e(r3, r4);	 Catch:{ all -> 0x0040 }
            r3 = -1;
            goto L_0x004f;
        L_0x006f:
            r3 = r15.mRestoreTransport;	 Catch:{ RemoteException -> 0x00c6 }
            r6 = r3.transportDirName();	 Catch:{ RemoteException -> 0x00c6 }
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x0040 }
            r14 = r3.mQueueLock;	 Catch:{ all -> 0x0040 }
            monitor-enter(r14);	 Catch:{ all -> 0x0040 }
            r10 = 0;
        L_0x007b:
            r3 = r15.mRestoreSets;	 Catch:{ all -> 0x00c3 }
            r3 = r3.length;	 Catch:{ all -> 0x00c3 }
            if (r10 >= r3) goto L_0x00d3;
        L_0x0080:
            r3 = r15.mRestoreSets;	 Catch:{ all -> 0x00c3 }
            r3 = r3[r10];	 Catch:{ all -> 0x00c3 }
            r4 = r3.token;	 Catch:{ all -> 0x00c3 }
            r3 = (r16 > r4 ? 1 : (r16 == r4 ? 0 : -1));
            if (r3 != 0) goto L_0x00d0;
        L_0x008a:
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x00c3 }
            r3 = r3.mBackupHandler;	 Catch:{ all -> 0x00c3 }
            r4 = 8;
            r3.removeMessages(r4);	 Catch:{ all -> 0x00c3 }
            r12 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x00c3 }
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x00c3 }
            r3 = r3.mWakelock;	 Catch:{ all -> 0x00c3 }
            r3.acquire();	 Catch:{ all -> 0x00c3 }
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x00c3 }
            r3 = r3.mBackupHandler;	 Catch:{ all -> 0x00c3 }
            r4 = 3;
            r11 = r3.obtainMessage(r4);	 Catch:{ all -> 0x00c3 }
            r3 = new com.android.server.backup.BackupManagerService$RestoreParams;	 Catch:{ all -> 0x00c3 }
            r4 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x00c3 }
            r5 = r15.mRestoreTransport;	 Catch:{ all -> 0x00c3 }
            r7 = r18;
            r8 = r16;
            r3.<init>(r5, r6, r7, r8);	 Catch:{ all -> 0x00c3 }
            r11.obj = r3;	 Catch:{ all -> 0x00c3 }
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x00c3 }
            r3 = r3.mBackupHandler;	 Catch:{ all -> 0x00c3 }
            r3.sendMessage(r11);	 Catch:{ all -> 0x00c3 }
            android.os.Binder.restoreCallingIdentity(r12);	 Catch:{ all -> 0x00c3 }
            r3 = 0;
            monitor-exit(r14);	 Catch:{ all -> 0x00c3 }
            goto L_0x004f;
        L_0x00c3:
            r3 = move-exception;
            monitor-exit(r14);	 Catch:{ all -> 0x00c3 }
            throw r3;	 Catch:{ all -> 0x0040 }
        L_0x00c6:
            r2 = move-exception;
            r3 = "RestoreSession";
            r4 = "Unable to contact transport for restore";
            android.util.Slog.e(r3, r4);	 Catch:{ all -> 0x0040 }
            r3 = -1;
            goto L_0x004f;
        L_0x00d0:
            r10 = r10 + 1;
            goto L_0x007b;
        L_0x00d3:
            monitor-exit(r14);	 Catch:{ all -> 0x00c3 }
            r3 = "RestoreSession";
            r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0040 }
            r4.<init>();	 Catch:{ all -> 0x0040 }
            r5 = "Restore token ";
            r4 = r4.append(r5);	 Catch:{ all -> 0x0040 }
            r5 = java.lang.Long.toHexString(r16);	 Catch:{ all -> 0x0040 }
            r4 = r4.append(r5);	 Catch:{ all -> 0x0040 }
            r5 = " not found";
            r4 = r4.append(r5);	 Catch:{ all -> 0x0040 }
            r4 = r4.toString();	 Catch:{ all -> 0x0040 }
            android.util.Slog.w(r3, r4);	 Catch:{ all -> 0x0040 }
            r3 = -1;
            goto L_0x004f;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.ActiveRestoreSession.restoreAll(long, android.app.backup.IRestoreObserver):int");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public synchronized int restoreSome(long r24, android.app.backup.IRestoreObserver r26, java.lang.String[] r27) {
            /*
            r23 = this;
            monitor-enter(r23);
            r0 = r23;
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x0050 }
            r3 = r3.mContext;	 Catch:{ all -> 0x0050 }
            r4 = "android.permission.BACKUP";
            r5 = "performRestore";
            r3.enforceCallingOrSelfPermission(r4, r5);	 Catch:{ all -> 0x0050 }
            r12 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0050 }
            r3 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
            r12.<init>(r3);	 Catch:{ all -> 0x0050 }
            r3 = "restoreSome token=";
            r12.append(r3);	 Catch:{ all -> 0x0050 }
            r3 = java.lang.Long.toHexString(r24);	 Catch:{ all -> 0x0050 }
            r12.append(r3);	 Catch:{ all -> 0x0050 }
            r3 = " observer=";
            r12.append(r3);	 Catch:{ all -> 0x0050 }
            r3 = r26.toString();	 Catch:{ all -> 0x0050 }
            r12.append(r3);	 Catch:{ all -> 0x0050 }
            r3 = " packages=";
            r12.append(r3);	 Catch:{ all -> 0x0050 }
            if (r27 != 0) goto L_0x0053;
        L_0x0034:
            r3 = "null";
            r12.append(r3);	 Catch:{ all -> 0x0050 }
        L_0x0039:
            r3 = "RestoreSession";
            r4 = r12.toString();	 Catch:{ all -> 0x0050 }
            android.util.Slog.d(r3, r4);	 Catch:{ all -> 0x0050 }
            r0 = r23;
            r3 = r0.mEnded;	 Catch:{ all -> 0x0050 }
            if (r3 == 0) goto L_0x007f;
        L_0x0048:
            r3 = new java.lang.IllegalStateException;	 Catch:{ all -> 0x0050 }
            r4 = "Restore session already ended";
            r3.<init>(r4);	 Catch:{ all -> 0x0050 }
            throw r3;	 Catch:{ all -> 0x0050 }
        L_0x0050:
            r3 = move-exception;
            monitor-exit(r23);
            throw r3;
        L_0x0053:
            r3 = 123; // 0x7b float:1.72E-43 double:6.1E-322;
            r12.append(r3);	 Catch:{ all -> 0x0050 }
            r14 = 1;
            r2 = r27;
            r0 = r2.length;	 Catch:{ all -> 0x0050 }
            r17 = r0;
            r16 = 0;
        L_0x0060:
            r0 = r16;
            r1 = r17;
            if (r0 >= r1) goto L_0x0079;
        L_0x0066:
            r19 = r2[r16];	 Catch:{ all -> 0x0050 }
            if (r14 != 0) goto L_0x0077;
        L_0x006a:
            r3 = ", ";
            r12.append(r3);	 Catch:{ all -> 0x0050 }
        L_0x006f:
            r0 = r19;
            r12.append(r0);	 Catch:{ all -> 0x0050 }
            r16 = r16 + 1;
            goto L_0x0060;
        L_0x0077:
            r14 = 0;
            goto L_0x006f;
        L_0x0079:
            r3 = 125; // 0x7d float:1.75E-43 double:6.2E-322;
            r12.append(r3);	 Catch:{ all -> 0x0050 }
            goto L_0x0039;
        L_0x007f:
            r0 = r23;
            r3 = r0.mTimedOut;	 Catch:{ all -> 0x0050 }
            if (r3 == 0) goto L_0x008f;
        L_0x0085:
            r3 = "RestoreSession";
            r4 = "Session already timed out";
            android.util.Slog.i(r3, r4);	 Catch:{ all -> 0x0050 }
            r3 = -1;
        L_0x008d:
            monitor-exit(r23);
            return r3;
        L_0x008f:
            r0 = r23;
            r3 = r0.mRestoreTransport;	 Catch:{ all -> 0x0050 }
            if (r3 == 0) goto L_0x009b;
        L_0x0095:
            r0 = r23;
            r3 = r0.mRestoreSets;	 Catch:{ all -> 0x0050 }
            if (r3 != 0) goto L_0x00a4;
        L_0x009b:
            r3 = "RestoreSession";
            r4 = "Ignoring restoreAll() with no restore set";
            android.util.Slog.e(r3, r4);	 Catch:{ all -> 0x0050 }
            r3 = -1;
            goto L_0x008d;
        L_0x00a4:
            r0 = r23;
            r3 = r0.mPackageName;	 Catch:{ all -> 0x0050 }
            if (r3 == 0) goto L_0x00b3;
        L_0x00aa:
            r3 = "RestoreSession";
            r4 = "Ignoring restoreAll() on single-package session";
            android.util.Slog.e(r3, r4);	 Catch:{ all -> 0x0050 }
            r3 = -1;
            goto L_0x008d;
        L_0x00b3:
            r0 = r23;
            r3 = r0.mRestoreTransport;	 Catch:{ RemoteException -> 0x012e }
            r6 = r3.transportDirName();	 Catch:{ RemoteException -> 0x012e }
            r0 = r23;
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x0050 }
            r0 = r3.mQueueLock;	 Catch:{ all -> 0x0050 }
            r22 = r0;
            monitor-enter(r22);	 Catch:{ all -> 0x0050 }
            r15 = 0;
        L_0x00c5:
            r0 = r23;
            r3 = r0.mRestoreSets;	 Catch:{ all -> 0x012b }
            r3 = r3.length;	 Catch:{ all -> 0x012b }
            if (r15 >= r3) goto L_0x013e;
        L_0x00cc:
            r0 = r23;
            r3 = r0.mRestoreSets;	 Catch:{ all -> 0x012b }
            r3 = r3[r15];	 Catch:{ all -> 0x012b }
            r4 = r3.token;	 Catch:{ all -> 0x012b }
            r3 = (r24 > r4 ? 1 : (r24 == r4 ? 0 : -1));
            if (r3 != 0) goto L_0x013b;
        L_0x00d8:
            r0 = r23;
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x012b }
            r3 = r3.mBackupHandler;	 Catch:{ all -> 0x012b }
            r4 = 8;
            r3.removeMessages(r4);	 Catch:{ all -> 0x012b }
            r20 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x012b }
            r0 = r23;
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x012b }
            r3 = r3.mWakelock;	 Catch:{ all -> 0x012b }
            r3.acquire();	 Catch:{ all -> 0x012b }
            r0 = r23;
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x012b }
            r3 = r3.mBackupHandler;	 Catch:{ all -> 0x012b }
            r4 = 3;
            r18 = r3.obtainMessage(r4);	 Catch:{ all -> 0x012b }
            r3 = new com.android.server.backup.BackupManagerService$RestoreParams;	 Catch:{ all -> 0x012b }
            r0 = r23;
            r4 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x012b }
            r0 = r23;
            r5 = r0.mRestoreTransport;	 Catch:{ all -> 0x012b }
            r0 = r27;
            r7 = r0.length;	 Catch:{ all -> 0x012b }
            r8 = 1;
            if (r7 <= r8) goto L_0x0139;
        L_0x010b:
            r11 = 1;
        L_0x010c:
            r7 = r26;
            r8 = r24;
            r10 = r27;
            r3.<init>(r5, r6, r7, r8, r10, r11);	 Catch:{ all -> 0x012b }
            r0 = r18;
            r0.obj = r3;	 Catch:{ all -> 0x012b }
            r0 = r23;
            r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ all -> 0x012b }
            r3 = r3.mBackupHandler;	 Catch:{ all -> 0x012b }
            r0 = r18;
            r3.sendMessage(r0);	 Catch:{ all -> 0x012b }
            android.os.Binder.restoreCallingIdentity(r20);	 Catch:{ all -> 0x012b }
            r3 = 0;
            monitor-exit(r22);	 Catch:{ all -> 0x012b }
            goto L_0x008d;
        L_0x012b:
            r3 = move-exception;
            monitor-exit(r22);	 Catch:{ all -> 0x012b }
            throw r3;	 Catch:{ all -> 0x0050 }
        L_0x012e:
            r13 = move-exception;
            r3 = "RestoreSession";
            r4 = "Unable to contact transport for restore";
            android.util.Slog.e(r3, r4);	 Catch:{ all -> 0x0050 }
            r3 = -1;
            goto L_0x008d;
        L_0x0139:
            r11 = 0;
            goto L_0x010c;
        L_0x013b:
            r15 = r15 + 1;
            goto L_0x00c5;
        L_0x013e:
            monitor-exit(r22);	 Catch:{ all -> 0x012b }
            r3 = "RestoreSession";
            r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0050 }
            r4.<init>();	 Catch:{ all -> 0x0050 }
            r5 = "Restore token ";
            r4 = r4.append(r5);	 Catch:{ all -> 0x0050 }
            r5 = java.lang.Long.toHexString(r24);	 Catch:{ all -> 0x0050 }
            r4 = r4.append(r5);	 Catch:{ all -> 0x0050 }
            r5 = " not found";
            r4 = r4.append(r5);	 Catch:{ all -> 0x0050 }
            r4 = r4.toString();	 Catch:{ all -> 0x0050 }
            android.util.Slog.w(r3, r4);	 Catch:{ all -> 0x0050 }
            r3 = -1;
            goto L_0x008d;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.ActiveRestoreSession.restoreSome(long, android.app.backup.IRestoreObserver, java.lang.String[]):int");
        }

        public synchronized int restorePackage(String packageName, IRestoreObserver observer) {
            int i;
            Slog.v(TAG, "restorePackage pkg=" + packageName + " obs=" + observer);
            if (this.mEnded) {
                throw new IllegalStateException("Restore session already ended");
            } else if (this.mTimedOut) {
                Slog.i(TAG, "Session already timed out");
                i = BackupManagerService.OP_TIMEOUT;
            } else if (this.mPackageName == null || this.mPackageName.equals(packageName)) {
                try {
                    PackageInfo app = BackupManagerService.this.mPackageManager.getPackageInfo(packageName, BackupManagerService.OP_PENDING);
                    if (BackupManagerService.this.mContext.checkPermission("android.permission.BACKUP", Binder.getCallingPid(), Binder.getCallingUid()) != BackupManagerService.OP_TIMEOUT || app.applicationInfo.uid == Binder.getCallingUid()) {
                        long token = BackupManagerService.this.getAvailableRestoreToken(packageName);
                        if (token == 0) {
                            Slog.w(TAG, "No data available for this package; not restoring");
                            i = BackupManagerService.OP_TIMEOUT;
                        } else {
                            try {
                                String dirName = this.mRestoreTransport.transportDirName();
                                BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_RESTORE_TIMEOUT);
                                long oldId = Binder.clearCallingIdentity();
                                BackupManagerService.this.mWakelock.acquire();
                                Message msg = BackupManagerService.this.mBackupHandler.obtainMessage(BackupManagerService.MSG_RUN_RESTORE);
                                msg.obj = new RestoreParams(this.mRestoreTransport, dirName, observer, token, app, (int) BackupManagerService.OP_PENDING);
                                BackupManagerService.this.mBackupHandler.sendMessage(msg);
                                Binder.restoreCallingIdentity(oldId);
                                i = BackupManagerService.OP_PENDING;
                            } catch (RemoteException e) {
                                Slog.e(TAG, "Unable to contact transport for restore");
                                i = BackupManagerService.OP_TIMEOUT;
                            }
                        }
                    } else {
                        Slog.w(TAG, "restorePackage: bad packageName=" + packageName + " or calling uid=" + Binder.getCallingUid());
                        throw new SecurityException("No permission to restore other packages");
                    }
                } catch (NameNotFoundException e2) {
                    Slog.w(TAG, "Asked to restore nonexistent pkg " + packageName);
                    i = BackupManagerService.OP_TIMEOUT;
                }
            } else {
                Slog.e(TAG, "Ignoring attempt to restore pkg=" + packageName + " on session for package " + this.mPackageName);
                i = BackupManagerService.OP_TIMEOUT;
            }
            return i;
        }

        public synchronized void endRestoreSession() {
            Slog.d(TAG, "endRestoreSession");
            if (this.mTimedOut) {
                Slog.i(TAG, "Session already timed out");
            } else if (this.mEnded) {
                throw new IllegalStateException("Restore session already ended");
            } else {
                BackupManagerService.this.mBackupHandler.post(new EndRestoreRunnable(BackupManagerService.this, this));
            }
        }
    }

    private class BackupHandler extends Handler {
        public BackupHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case BackupManagerService.SCHEDULE_FILE_VERSION /*1*/:
                    BackupManagerService.this.mLastBackupPass = System.currentTimeMillis();
                    BackupManagerService.this.mNextBackupPass = BackupManagerService.this.mLastBackupPass + BackupManagerService.TRANSPORT_RETRY_INTERVAL;
                    IBackupTransport transport = BackupManagerService.this.getTransport(BackupManagerService.this.mCurrentTransport);
                    if (transport == null) {
                        Slog.v(BackupManagerService.TAG, "Backup requested but no transport available");
                        synchronized (BackupManagerService.this.mQueueLock) {
                            BackupManagerService.this.mBackupRunning = BackupManagerService.MORE_DEBUG;
                            break;
                        }
                        BackupManagerService.this.mWakelock.release();
                        return;
                    }
                    ArrayList<BackupRequest> queue = new ArrayList();
                    File oldJournal = BackupManagerService.this.mJournal;
                    synchronized (BackupManagerService.this.mQueueLock) {
                        if (BackupManagerService.this.mPendingBackups.size() > 0) {
                            for (BackupRequest add : BackupManagerService.this.mPendingBackups.values()) {
                                queue.add(add);
                            }
                            Slog.v(BackupManagerService.TAG, "clearing pending backups");
                            BackupManagerService.this.mPendingBackups.clear();
                            BackupManagerService.this.mJournal = null;
                            break;
                        }
                        break;
                    }
                    boolean staged = BackupManagerService.DEBUG_SCHEDULING;
                    if (queue.size() > 0) {
                        try {
                            sendMessage(obtainMessage(BackupManagerService.MSG_BACKUP_RESTORE_STEP, new PerformBackupTask(transport, transport.transportDirName(), queue, oldJournal)));
                        } catch (RemoteException e) {
                            Slog.e(BackupManagerService.TAG, "Transport became unavailable attempting backup");
                            staged = BackupManagerService.MORE_DEBUG;
                        }
                    } else {
                        Slog.v(BackupManagerService.TAG, "Backup requested but nothing pending");
                        staged = BackupManagerService.MORE_DEBUG;
                    }
                    if (!staged) {
                        synchronized (BackupManagerService.this.mQueueLock) {
                            BackupManagerService.this.mBackupRunning = BackupManagerService.MORE_DEBUG;
                            break;
                        }
                        BackupManagerService.this.mWakelock.release();
                    }
                case BackupManagerService.MSG_RUN_ADB_BACKUP /*2*/:
                    FullBackupParams params = msg.obj;
                    new Thread(new PerformAdbBackupTask(params.fd, params.observer, params.includeApks, params.includeObbs, params.includeShared, params.doWidgets, params.curPassword, params.encryptPassword, params.allApps, params.includeSystem, params.doCompress, params.packages, params.latch), "adb-backup").start();
                case BackupManagerService.MSG_RUN_RESTORE /*3*/:
                    RestoreParams params2 = msg.obj;
                    Slog.d(BackupManagerService.TAG, "MSG_RUN_RESTORE observer=" + params2.observer);
                    sendMessage(obtainMessage(BackupManagerService.MSG_BACKUP_RESTORE_STEP, new PerformUnifiedRestoreTask(params2.transport, params2.observer, params2.token, params2.pkgInfo, params2.pmToken, params2.isSystemRestore, params2.filterSet)));
                case BackupManagerService.MSG_RUN_CLEAR /*4*/:
                    ClearParams params3 = msg.obj;
                    new PerformClearTask(params3.transport, params3.packageInfo).run();
                case BackupManagerService.MSG_RUN_INITIALIZE /*5*/:
                    HashSet<String> hashSet;
                    synchronized (BackupManagerService.this.mQueueLock) {
                        hashSet = new HashSet(BackupManagerService.this.mPendingInits);
                        BackupManagerService.this.mPendingInits.clear();
                        break;
                    }
                    new PerformInitializeTask(hashSet).run();
                case BackupManagerService.MSG_RUN_GET_RESTORE_SETS /*6*/:
                    RestoreSet[] sets = null;
                    RestoreGetSetsParams params4 = msg.obj;
                    try {
                        sets = params4.transport.getAvailableRestoreSets();
                        synchronized (params4.session) {
                            params4.session.mRestoreSets = sets;
                            break;
                        }
                        if (sets == null) {
                            EventLog.writeEvent(EventLogTags.RESTORE_TRANSPORT_FAILURE, new Object[BackupManagerService.OP_PENDING]);
                        }
                        if (params4.observer != null) {
                            try {
                                params4.observer.restoreSetsAvailable(sets);
                            } catch (RemoteException e2) {
                                Slog.e(BackupManagerService.TAG, "Unable to report listing to observer");
                            } catch (Throwable e3) {
                                Slog.e(BackupManagerService.TAG, "Restore observer threw", e3);
                            }
                        }
                        removeMessages(BackupManagerService.MSG_RESTORE_TIMEOUT);
                        sendEmptyMessageDelayed(BackupManagerService.MSG_RESTORE_TIMEOUT, BackupManagerService.TIMEOUT_RESTORE_INTERVAL);
                        BackupManagerService.this.mWakelock.release();
                    } catch (Exception e4) {
                        try {
                            Slog.e(BackupManagerService.TAG, "Error from transport getting set list");
                            if (params4.observer != null) {
                                try {
                                    params4.observer.restoreSetsAvailable(sets);
                                } catch (RemoteException e5) {
                                    Slog.e(BackupManagerService.TAG, "Unable to report listing to observer");
                                } catch (Throwable e32) {
                                    Slog.e(BackupManagerService.TAG, "Restore observer threw", e32);
                                }
                            }
                            removeMessages(BackupManagerService.MSG_RESTORE_TIMEOUT);
                            sendEmptyMessageDelayed(BackupManagerService.MSG_RESTORE_TIMEOUT, BackupManagerService.TIMEOUT_RESTORE_INTERVAL);
                            BackupManagerService.this.mWakelock.release();
                        } catch (Throwable th) {
                            if (params4.observer != null) {
                                try {
                                    params4.observer.restoreSetsAvailable(sets);
                                } catch (RemoteException e6) {
                                    Slog.e(BackupManagerService.TAG, "Unable to report listing to observer");
                                } catch (Throwable e322) {
                                    Slog.e(BackupManagerService.TAG, "Restore observer threw", e322);
                                }
                            }
                            removeMessages(BackupManagerService.MSG_RESTORE_TIMEOUT);
                            sendEmptyMessageDelayed(BackupManagerService.MSG_RESTORE_TIMEOUT, BackupManagerService.TIMEOUT_RESTORE_INTERVAL);
                            BackupManagerService.this.mWakelock.release();
                        }
                    }
                case BackupManagerService.MSG_TIMEOUT /*7*/:
                    BackupManagerService.this.handleTimeout(msg.arg1, msg.obj);
                case BackupManagerService.MSG_RESTORE_TIMEOUT /*8*/:
                    synchronized (BackupManagerService.this) {
                        if (BackupManagerService.this.mActiveRestoreSession != null) {
                            Slog.w(BackupManagerService.TAG, "Restore session timed out; aborting");
                            BackupManagerService.this.mActiveRestoreSession.markTimedOut();
                            ActiveRestoreSession activeRestoreSession = BackupManagerService.this.mActiveRestoreSession;
                            activeRestoreSession.getClass();
                            post(new EndRestoreRunnable(BackupManagerService.this, BackupManagerService.this.mActiveRestoreSession));
                        }
                        break;
                    }
                case BackupManagerService.MSG_FULL_CONFIRMATION_TIMEOUT /*9*/:
                    synchronized (BackupManagerService.this.mFullConfirmations) {
                        FullParams params5 = (FullParams) BackupManagerService.this.mFullConfirmations.get(msg.arg1);
                        if (params5 == null) {
                            Slog.d(BackupManagerService.TAG, "couldn't find params for token " + msg.arg1);
                            break;
                        }
                        Slog.i(BackupManagerService.TAG, "Full backup/restore timed out waiting for user confirmation");
                        BackupManagerService.this.signalFullBackupRestoreCompletion(params5);
                        BackupManagerService.this.mFullConfirmations.delete(msg.arg1);
                        if (params5.observer != null) {
                            try {
                                params5.observer.onTimeout();
                            } catch (RemoteException e7) {
                            }
                        }
                        break;
                    }
                case BackupManagerService.MSG_RUN_ADB_RESTORE /*10*/:
                    FullRestoreParams params6 = msg.obj;
                    new Thread(new PerformAdbRestoreTask(params6.fd, params6.curPassword, params6.encryptPassword, params6.observer, params6.latch), "adb-restore").start();
                case BackupManagerService.MSG_RETRY_INIT /*11*/:
                    synchronized (BackupManagerService.this.mQueueLock) {
                        BackupManagerService.this.recordInitPendingLocked(msg.arg1 != 0 ? BackupManagerService.DEBUG_SCHEDULING : BackupManagerService.MORE_DEBUG, (String) msg.obj);
                        BackupManagerService.this.mAlarmManager.set(BackupManagerService.OP_PENDING, System.currentTimeMillis(), BackupManagerService.this.mRunInitIntent);
                        break;
                    }
                case BackupManagerService.MSG_RETRY_CLEAR /*12*/:
                    ClearRetryParams params7 = msg.obj;
                    BackupManagerService.this.clearBackupData(params7.transportName, params7.packageName);
                case BackupManagerService.MSG_WIDGET_BROADCAST /*13*/:
                    BackupManagerService.this.mContext.sendBroadcastAsUser(msg.obj, UserHandle.OWNER);
                case BackupManagerService.MSG_RUN_FULL_TRANSPORT_BACKUP /*14*/:
                    new Thread(msg.obj, "transport-backup").start();
                case BackupManagerService.MSG_BACKUP_RESTORE_STEP /*20*/:
                    try {
                        msg.obj.execute();
                    } catch (ClassCastException e8) {
                        Slog.e(BackupManagerService.TAG, "Invalid backup task in flight, obj=" + msg.obj);
                    }
                case BackupManagerService.MSG_OP_COMPLETE /*21*/:
                    try {
                        ((BackupRestoreTask) msg.obj).operationComplete();
                    } catch (ClassCastException e9) {
                        Slog.e(BackupManagerService.TAG, "Invalid completion in flight, obj=" + msg.obj);
                    }
                default:
            }
        }
    }

    class BackupRequest {
        public String packageName;

        BackupRequest(String pkgName) {
            this.packageName = pkgName;
        }

        public String toString() {
            return "BackupRequest{pkg=" + this.packageName + "}";
        }
    }

    interface BackupRestoreTask {
        void execute();

        void handleTimeout();

        void operationComplete();
    }

    enum BackupState {
        INITIAL,
        RUNNING_QUEUE,
        FINAL
    }

    class ClearDataObserver extends IPackageDataObserver.Stub {
        ClearDataObserver() {
        }

        public void onRemoveCompleted(String packageName, boolean succeeded) {
            synchronized (BackupManagerService.this.mClearDataLock) {
                BackupManagerService.this.mClearingData = BackupManagerService.MORE_DEBUG;
                BackupManagerService.this.mClearDataLock.notifyAll();
            }
        }
    }

    class ClearParams {
        public PackageInfo packageInfo;
        public IBackupTransport transport;

        ClearParams(IBackupTransport _transport, PackageInfo _info) {
            this.transport = _transport;
            this.packageInfo = _info;
        }
    }

    class ClearRetryParams {
        public String packageName;
        public String transportName;

        ClearRetryParams(String transport, String pkg) {
            this.transportName = transport;
            this.packageName = pkg;
        }
    }

    static class FileMetadata {
        String domain;
        String installerPackageName;
        long mode;
        long mtime;
        String packageName;
        String path;
        long size;
        int type;

        FileMetadata() {
        }

        public String toString() {
            StringBuilder sb = new StringBuilder(DumpState.DUMP_PROVIDERS);
            sb.append("FileMetadata{");
            sb.append(this.packageName);
            sb.append(',');
            sb.append(this.type);
            sb.append(',');
            sb.append(this.domain);
            sb.append(':');
            sb.append(this.path);
            sb.append(',');
            sb.append(this.size);
            sb.append('}');
            return sb.toString();
        }
    }

    class FullBackupEngine {
        File mFilesDir;
        boolean mIncludeApks;
        File mManifestFile;
        File mMetadataFile;
        IFullBackupRestoreObserver mObserver;
        OutputStream mOutput;

        class FullBackupRunner implements Runnable {
            IBackupAgent mAgent;
            PackageInfo mPackage;
            ParcelFileDescriptor mPipe;
            boolean mSendApk;
            int mToken;
            byte[] mWidgetData;
            boolean mWriteManifest;

            FullBackupRunner(PackageInfo pack, IBackupAgent agent, ParcelFileDescriptor pipe, int token, boolean sendApk, boolean writeManifest, byte[] widgetData) throws IOException {
                this.mPackage = pack;
                this.mWidgetData = widgetData;
                this.mAgent = agent;
                this.mPipe = ParcelFileDescriptor.dup(pipe.getFileDescriptor());
                this.mToken = token;
                this.mSendApk = sendApk;
                this.mWriteManifest = writeManifest;
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public void run() {
                /*
                r8 = this;
                r5 = new android.app.backup.BackupDataOutput;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r8.mPipe;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r0.getFileDescriptor();	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r5.<init>(r0);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r8.mWriteManifest;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                if (r0 == 0) goto L_0x0070;
            L_0x000f:
                r0 = r8.mWidgetData;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                if (r0 == 0) goto L_0x00b9;
            L_0x0013:
                r7 = 1;
            L_0x0014:
                r0 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r1 = r8.mPackage;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r2 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r2 = r2.mManifestFile;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r3 = r8.mSendApk;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0.writeAppManifest(r1, r2, r3, r7);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r8.mPackage;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r0.packageName;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r1 = 0;
                r2 = 0;
                r3 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r3 = r3.mFilesDir;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r3 = r3.getAbsolutePath();	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r4 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r4 = r4.mManifestFile;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r4 = r4.getAbsolutePath();	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                android.app.backup.FullBackup.backupToTar(r0, r1, r2, r3, r4, r5);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r0.mManifestFile;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0.delete();	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                if (r7 == 0) goto L_0x0070;
            L_0x0043:
                r0 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r1 = r8.mPackage;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r2 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r2 = r2.mMetadataFile;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r3 = r8.mWidgetData;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0.writeMetadata(r1, r2, r3);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r8.mPackage;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r0.packageName;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r1 = 0;
                r2 = 0;
                r3 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r3 = r3.mFilesDir;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r3 = r3.getAbsolutePath();	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r4 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r4 = r4.mMetadataFile;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r4 = r4.getAbsolutePath();	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                android.app.backup.FullBackup.backupToTar(r0, r1, r2, r3, r4, r5);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r0.mMetadataFile;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0.delete();	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
            L_0x0070:
                r0 = r8.mSendApk;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                if (r0 == 0) goto L_0x007b;
            L_0x0074:
                r0 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r1 = r8.mPackage;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0.writeApkToBackup(r1, r5);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
            L_0x007b:
                r0 = "BackupManagerService";
                r1 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r1.<init>();	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r2 = "Calling doFullBackup() on ";
                r1 = r1.append(r2);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r2 = r8.mPackage;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r2 = r2.packageName;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r1 = r1.append(r2);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r1 = r1.toString();	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                android.util.Slog.d(r0, r1);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = com.android.server.backup.BackupManagerService.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r1 = r8.mToken;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r2 = 300000; // 0x493e0 float:4.2039E-40 double:1.482197E-318;
                r4 = 0;
                r0.prepareOperationTimeout(r1, r2, r4);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r8.mAgent;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r1 = r8.mPipe;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r2 = r8.mToken;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r3 = com.android.server.backup.BackupManagerService.FullBackupEngine.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r3 = com.android.server.backup.BackupManagerService.this;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r3 = r3.mBackupManagerBinder;	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0.doFullBackup(r1, r2, r3);	 Catch:{ IOException -> 0x00bc, RemoteException -> 0x00e1 }
                r0 = r8.mPipe;	 Catch:{ IOException -> 0x010f }
                r0.close();	 Catch:{ IOException -> 0x010f }
            L_0x00b8:
                return;
            L_0x00b9:
                r7 = 0;
                goto L_0x0014;
            L_0x00bc:
                r6 = move-exception;
                r0 = "BackupManagerService";
                r1 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0106 }
                r1.<init>();	 Catch:{ all -> 0x0106 }
                r2 = "Error running full backup for ";
                r1 = r1.append(r2);	 Catch:{ all -> 0x0106 }
                r2 = r8.mPackage;	 Catch:{ all -> 0x0106 }
                r2 = r2.packageName;	 Catch:{ all -> 0x0106 }
                r1 = r1.append(r2);	 Catch:{ all -> 0x0106 }
                r1 = r1.toString();	 Catch:{ all -> 0x0106 }
                android.util.Slog.e(r0, r1);	 Catch:{ all -> 0x0106 }
                r0 = r8.mPipe;	 Catch:{ IOException -> 0x00df }
                r0.close();	 Catch:{ IOException -> 0x00df }
                goto L_0x00b8;
            L_0x00df:
                r0 = move-exception;
                goto L_0x00b8;
            L_0x00e1:
                r6 = move-exception;
                r0 = "BackupManagerService";
                r1 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0106 }
                r1.<init>();	 Catch:{ all -> 0x0106 }
                r2 = "Remote agent vanished during full backup of ";
                r1 = r1.append(r2);	 Catch:{ all -> 0x0106 }
                r2 = r8.mPackage;	 Catch:{ all -> 0x0106 }
                r2 = r2.packageName;	 Catch:{ all -> 0x0106 }
                r1 = r1.append(r2);	 Catch:{ all -> 0x0106 }
                r1 = r1.toString();	 Catch:{ all -> 0x0106 }
                android.util.Slog.e(r0, r1);	 Catch:{ all -> 0x0106 }
                r0 = r8.mPipe;	 Catch:{ IOException -> 0x0104 }
                r0.close();	 Catch:{ IOException -> 0x0104 }
                goto L_0x00b8;
            L_0x0104:
                r0 = move-exception;
                goto L_0x00b8;
            L_0x0106:
                r0 = move-exception;
                r1 = r8.mPipe;	 Catch:{ IOException -> 0x010d }
                r1.close();	 Catch:{ IOException -> 0x010d }
            L_0x010c:
                throw r0;
            L_0x010d:
                r1 = move-exception;
                goto L_0x010c;
            L_0x010f:
                r0 = move-exception;
                goto L_0x00b8;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.FullBackupEngine.FullBackupRunner.run():void");
            }
        }

        FullBackupEngine(OutputStream output, String packageName, boolean alsoApks) {
            this.mOutput = output;
            this.mIncludeApks = alsoApks;
            this.mFilesDir = new File("/data/system");
            this.mManifestFile = new File(this.mFilesDir, BackupManagerService.BACKUP_MANIFEST_FILENAME);
            this.mMetadataFile = new File(this.mFilesDir, BackupManagerService.BACKUP_METADATA_FILENAME);
        }

        public int backupOnePackage(PackageInfo pkg) throws RemoteException {
            int result = BackupManagerService.OP_PENDING;
            Slog.d(BackupManagerService.TAG, "Binding to full backup agent : " + pkg.packageName);
            IBackupAgent agent = BackupManagerService.this.bindToAgentSynchronous(pkg.applicationInfo, BackupManagerService.SCHEDULE_FILE_VERSION);
            if (agent != null) {
                ParcelFileDescriptor[] pipes = null;
                try {
                    pipes = ParcelFileDescriptor.createPipe();
                    ApplicationInfo app = pkg.applicationInfo;
                    boolean isSharedStorage = pkg.packageName.equals(BackupManagerService.SHARED_BACKUP_AGENT_PACKAGE);
                    boolean sendApk = (!this.mIncludeApks || isSharedStorage || (app.flags & 536870912) != 0 || ((app.flags & BackupManagerService.SCHEDULE_FILE_VERSION) != 0 && (app.flags & DumpState.DUMP_PROVIDERS) == 0)) ? BackupManagerService.MORE_DEBUG : BackupManagerService.DEBUG_SCHEDULING;
                    byte[] widgetBlob = AppWidgetBackupBridge.getWidgetState(pkg.packageName, BackupManagerService.OP_PENDING);
                    int token = BackupManagerService.this.generateToken();
                    FullBackupRunner runner = new FullBackupRunner(pkg, agent, pipes[BackupManagerService.SCHEDULE_FILE_VERSION], token, sendApk, !isSharedStorage ? BackupManagerService.DEBUG_SCHEDULING : BackupManagerService.MORE_DEBUG, widgetBlob);
                    pipes[BackupManagerService.SCHEDULE_FILE_VERSION].close();
                    pipes[BackupManagerService.SCHEDULE_FILE_VERSION] = null;
                    new Thread(runner, "app-data-runner").start();
                    try {
                        BackupManagerService.this.routeSocketDataToOutput(pipes[BackupManagerService.OP_PENDING], this.mOutput);
                    } catch (IOException e) {
                        Slog.i(BackupManagerService.TAG, "Caught exception reading from agent", e);
                        result = -1003;
                    }
                    if (BackupManagerService.this.waitUntilOperationComplete(token)) {
                        Slog.d(BackupManagerService.TAG, "Full package backup success: " + pkg.packageName);
                    } else {
                        Slog.e(BackupManagerService.TAG, "Full backup failed on package " + pkg.packageName);
                        result = -1003;
                    }
                    try {
                        this.mOutput.flush();
                        if (pipes != null) {
                            if (pipes[BackupManagerService.OP_PENDING] != null) {
                                pipes[BackupManagerService.OP_PENDING].close();
                            }
                            if (pipes[BackupManagerService.SCHEDULE_FILE_VERSION] != null) {
                                pipes[BackupManagerService.SCHEDULE_FILE_VERSION].close();
                            }
                        }
                    } catch (IOException e2) {
                        Slog.w(BackupManagerService.TAG, "Error bringing down backup stack");
                        result = -1000;
                    }
                } catch (IOException e3) {
                    Slog.e(BackupManagerService.TAG, "Error backing up " + pkg.packageName, e3);
                    result = -1003;
                    try {
                        this.mOutput.flush();
                        if (pipes != null) {
                            if (pipes[BackupManagerService.OP_PENDING] != null) {
                                pipes[BackupManagerService.OP_PENDING].close();
                            }
                            if (pipes[BackupManagerService.SCHEDULE_FILE_VERSION] != null) {
                                pipes[BackupManagerService.SCHEDULE_FILE_VERSION].close();
                            }
                        }
                    } catch (IOException e4) {
                        Slog.w(BackupManagerService.TAG, "Error bringing down backup stack");
                        result = -1000;
                    }
                } catch (Throwable th) {
                    try {
                        this.mOutput.flush();
                        if (pipes != null) {
                            if (pipes[BackupManagerService.OP_PENDING] != null) {
                                pipes[BackupManagerService.OP_PENDING].close();
                            }
                            if (pipes[BackupManagerService.SCHEDULE_FILE_VERSION] != null) {
                                pipes[BackupManagerService.SCHEDULE_FILE_VERSION].close();
                            }
                        }
                    } catch (IOException e5) {
                        Slog.w(BackupManagerService.TAG, "Error bringing down backup stack");
                    }
                }
            } else {
                Slog.w(BackupManagerService.TAG, "Unable to bind to full agent for " + pkg.packageName);
                result = -1003;
            }
            tearDown(pkg);
            return result;
        }

        private void writeApkToBackup(PackageInfo pkg, BackupDataOutput output) {
            String appSourceDir = pkg.applicationInfo.getBaseCodePath();
            FullBackup.backupToTar(pkg.packageName, "a", null, new File(appSourceDir).getParent(), appSourceDir, output);
            File obbDir = new UserEnvironment(BackupManagerService.OP_PENDING).buildExternalStorageAppObbDirs(pkg.packageName)[BackupManagerService.OP_PENDING];
            if (obbDir != null) {
                File[] obbFiles = obbDir.listFiles();
                if (obbFiles != null) {
                    String obbDirName = obbDir.getAbsolutePath();
                    File[] arr$ = obbFiles;
                    int len$ = arr$.length;
                    for (int i$ = BackupManagerService.OP_PENDING; i$ < len$; i$ += BackupManagerService.SCHEDULE_FILE_VERSION) {
                        FullBackup.backupToTar(pkg.packageName, "obb", null, obbDirName, arr$[i$].getAbsolutePath(), output);
                    }
                }
            }
        }

        private void writeAppManifest(PackageInfo pkg, File manifestFile, boolean withApk, boolean withWidgets) throws IOException {
            StringBuilder builder = new StringBuilder(DumpState.DUMP_VERSION);
            StringBuilderPrinter printer = new StringBuilderPrinter(builder);
            printer.println(Integer.toString(BackupManagerService.SCHEDULE_FILE_VERSION));
            printer.println(pkg.packageName);
            printer.println(Integer.toString(pkg.versionCode));
            printer.println(Integer.toString(VERSION.SDK_INT));
            String installerName = BackupManagerService.this.mPackageManager.getInstallerPackageName(pkg.packageName);
            if (installerName == null) {
                installerName = "";
            }
            printer.println(installerName);
            printer.println(withApk ? "1" : "0");
            if (pkg.signatures == null) {
                printer.println("0");
            } else {
                printer.println(Integer.toString(pkg.signatures.length));
                Signature[] arr$ = pkg.signatures;
                int len$ = arr$.length;
                for (int i$ = BackupManagerService.OP_PENDING; i$ < len$; i$ += BackupManagerService.SCHEDULE_FILE_VERSION) {
                    printer.println(arr$[i$].toCharsString());
                }
            }
            FileOutputStream outstream = new FileOutputStream(manifestFile);
            outstream.write(builder.toString().getBytes());
            outstream.close();
            manifestFile.setLastModified(0);
        }

        private void writeMetadata(PackageInfo pkg, File destination, byte[] widgetData) throws IOException {
            StringBuilder b = new StringBuilder(BackupManagerService.PBKDF2_SALT_SIZE);
            StringBuilderPrinter printer = new StringBuilderPrinter(b);
            printer.println(Integer.toString(BackupManagerService.SCHEDULE_FILE_VERSION));
            printer.println(pkg.packageName);
            BufferedOutputStream bout = new BufferedOutputStream(new FileOutputStream(destination));
            DataOutputStream out = new DataOutputStream(bout);
            bout.write(b.toString().getBytes());
            if (widgetData != null && widgetData.length > 0) {
                out.writeInt(BackupManagerService.BACKUP_WIDGET_METADATA_TOKEN);
                out.writeInt(widgetData.length);
                out.write(widgetData);
            }
            bout.flush();
            out.close();
            destination.setLastModified(0);
        }

        private void tearDown(PackageInfo pkg) {
            if (pkg != null) {
                ApplicationInfo app = pkg.applicationInfo;
                if (app != null) {
                    try {
                        BackupManagerService.this.mActivityManager.unbindBackupAgent(app);
                        if (app.uid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && app.uid != 1001) {
                            BackupManagerService.this.mActivityManager.killApplicationProcess(app.processName, app.uid);
                        }
                    } catch (RemoteException e) {
                        Slog.d(BackupManagerService.TAG, "Lost app trying to shut down");
                    }
                }
            }
        }
    }

    class FullBackupEntry implements Comparable<FullBackupEntry> {
        long lastBackup;
        String packageName;

        FullBackupEntry(String pkg, long when) {
            this.packageName = pkg;
            this.lastBackup = when;
        }

        public int compareTo(FullBackupEntry other) {
            if (this.lastBackup < other.lastBackup) {
                return BackupManagerService.OP_TIMEOUT;
            }
            if (this.lastBackup > other.lastBackup) {
                return BackupManagerService.SCHEDULE_FILE_VERSION;
            }
            return BackupManagerService.OP_PENDING;
        }
    }

    class FullBackupObbConnection implements ServiceConnection {
        volatile IObbBackupService mService;

        FullBackupObbConnection() {
            this.mService = null;
        }

        public void establish() {
            Slog.i(BackupManagerService.TAG, "Initiating bind of OBB service on " + this);
            BackupManagerService.this.mContext.bindService(new Intent().setComponent(new ComponentName(BackupManagerService.SHARED_BACKUP_AGENT_PACKAGE, "com.android.sharedstoragebackup.ObbBackupService")), this, BackupManagerService.SCHEDULE_FILE_VERSION);
        }

        public void tearDown() {
            BackupManagerService.this.mContext.unbindService(this);
        }

        public boolean backupObbs(PackageInfo pkg, OutputStream out) {
            boolean success = BackupManagerService.MORE_DEBUG;
            waitForConnection();
            ParcelFileDescriptor[] pipes = null;
            try {
                pipes = ParcelFileDescriptor.createPipe();
                int token = BackupManagerService.this.generateToken();
                BackupManagerService.this.prepareOperationTimeout(token, BackupManagerService.TIMEOUT_FULL_BACKUP_INTERVAL, null);
                this.mService.backupObbs(pkg.packageName, pipes[BackupManagerService.SCHEDULE_FILE_VERSION], token, BackupManagerService.this.mBackupManagerBinder);
                BackupManagerService.this.routeSocketDataToOutput(pipes[BackupManagerService.OP_PENDING], out);
                success = BackupManagerService.this.waitUntilOperationComplete(token);
                try {
                    out.flush();
                    if (pipes != null) {
                        if (pipes[BackupManagerService.OP_PENDING] != null) {
                            pipes[BackupManagerService.OP_PENDING].close();
                        }
                        if (pipes[BackupManagerService.SCHEDULE_FILE_VERSION] != null) {
                            pipes[BackupManagerService.SCHEDULE_FILE_VERSION].close();
                        }
                    }
                } catch (IOException e) {
                    Slog.w(BackupManagerService.TAG, "I/O error closing down OBB backup", e);
                }
            } catch (Exception e2) {
                Slog.w(BackupManagerService.TAG, "Unable to back up OBBs for " + pkg, e2);
                try {
                    out.flush();
                    if (pipes != null) {
                        if (pipes[BackupManagerService.OP_PENDING] != null) {
                            pipes[BackupManagerService.OP_PENDING].close();
                        }
                        if (pipes[BackupManagerService.SCHEDULE_FILE_VERSION] != null) {
                            pipes[BackupManagerService.SCHEDULE_FILE_VERSION].close();
                        }
                    }
                } catch (IOException e3) {
                    Slog.w(BackupManagerService.TAG, "I/O error closing down OBB backup", e3);
                }
            } catch (Throwable th) {
                try {
                    out.flush();
                    if (pipes != null) {
                        if (pipes[BackupManagerService.OP_PENDING] != null) {
                            pipes[BackupManagerService.OP_PENDING].close();
                        }
                        if (pipes[BackupManagerService.SCHEDULE_FILE_VERSION] != null) {
                            pipes[BackupManagerService.SCHEDULE_FILE_VERSION].close();
                        }
                    }
                } catch (IOException e32) {
                    Slog.w(BackupManagerService.TAG, "I/O error closing down OBB backup", e32);
                }
            }
            return success;
        }

        public void restoreObbFile(String pkgName, ParcelFileDescriptor data, long fileSize, int type, String path, long mode, long mtime, int token, IBackupManager callbackBinder) {
            waitForConnection();
            try {
                this.mService.restoreObbFile(pkgName, data, fileSize, type, path, mode, mtime, token, callbackBinder);
            } catch (Exception e) {
                Slog.w(BackupManagerService.TAG, "Unable to restore OBBs for " + pkgName, e);
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private void waitForConnection() {
            /*
            r2 = this;
            monitor-enter(r2);
        L_0x0001:
            r0 = r2.mService;	 Catch:{ all -> 0x001b }
            if (r0 != 0) goto L_0x0012;
        L_0x0005:
            r0 = "BackupManagerService";
            r1 = "...waiting for OBB service binding...";
            android.util.Slog.i(r0, r1);	 Catch:{ all -> 0x001b }
            r2.wait();	 Catch:{ InterruptedException -> 0x0010 }
            goto L_0x0001;
        L_0x0010:
            r0 = move-exception;
            goto L_0x0001;
        L_0x0012:
            r0 = "BackupManagerService";
            r1 = "Connected to OBB service; continuing";
            android.util.Slog.i(r0, r1);	 Catch:{ all -> 0x001b }
            monitor-exit(r2);	 Catch:{ all -> 0x001b }
            return;
        L_0x001b:
            r0 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x001b }
            throw r0;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.FullBackupObbConnection.waitForConnection():void");
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            synchronized (this) {
                this.mService = IObbBackupService.Stub.asInterface(service);
                Slog.i(BackupManagerService.TAG, "OBB service connection " + this.mService + " connected on " + this);
                notifyAll();
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            synchronized (this) {
                this.mService = null;
                Slog.i(BackupManagerService.TAG, "OBB service connection disconnected on " + this);
                notifyAll();
            }
        }
    }

    class FullParams {
        public String curPassword;
        public String encryptPassword;
        public ParcelFileDescriptor fd;
        public final AtomicBoolean latch;
        public IFullBackupRestoreObserver observer;

        FullParams() {
            this.latch = new AtomicBoolean(BackupManagerService.MORE_DEBUG);
        }
    }

    class FullBackupParams extends FullParams {
        public boolean allApps;
        public boolean doCompress;
        public boolean doWidgets;
        public boolean includeApks;
        public boolean includeObbs;
        public boolean includeShared;
        public boolean includeSystem;
        public String[] packages;

        FullBackupParams(ParcelFileDescriptor output, boolean saveApks, boolean saveObbs, boolean saveShared, boolean alsoWidgets, boolean doAllApps, boolean doSystem, boolean compress, String[] pkgList) {
            super();
            this.fd = output;
            this.includeApks = saveApks;
            this.includeObbs = saveObbs;
            this.includeShared = saveShared;
            this.doWidgets = alsoWidgets;
            this.allApps = doAllApps;
            this.includeSystem = doSystem;
            this.doCompress = compress;
            this.packages = pkgList;
        }
    }

    abstract class FullBackupTask implements Runnable {
        IFullBackupRestoreObserver mObserver;

        FullBackupTask(IFullBackupRestoreObserver observer) {
            this.mObserver = observer;
        }

        final void sendStartBackup() {
            if (this.mObserver != null) {
                try {
                    this.mObserver.onStartBackup();
                } catch (RemoteException e) {
                    Slog.w(BackupManagerService.TAG, "full backup observer went away: startBackup");
                    this.mObserver = null;
                }
            }
        }

        final void sendOnBackupPackage(String name) {
            if (this.mObserver != null) {
                try {
                    this.mObserver.onBackupPackage(name);
                } catch (RemoteException e) {
                    Slog.w(BackupManagerService.TAG, "full backup observer went away: backupPackage");
                    this.mObserver = null;
                }
            }
        }

        final void sendEndBackup() {
            if (this.mObserver != null) {
                try {
                    this.mObserver.onEndBackup();
                } catch (RemoteException e) {
                    Slog.w(BackupManagerService.TAG, "full backup observer went away: endBackup");
                    this.mObserver = null;
                }
            }
        }
    }

    abstract class RestoreEngine {
        public static final int SUCCESS = 0;
        static final String TAG = "RestoreEngine";
        public static final int TARGET_FAILURE = -2;
        public static final int TRANSPORT_FAILURE = -3;
        private AtomicInteger mResult;
        private AtomicBoolean mRunning;

        RestoreEngine() {
            this.mRunning = new AtomicBoolean(BackupManagerService.MORE_DEBUG);
            this.mResult = new AtomicInteger(SUCCESS);
        }

        public boolean isRunning() {
            return this.mRunning.get();
        }

        public void setRunning(boolean stillRunning) {
            synchronized (this.mRunning) {
                this.mRunning.set(stillRunning);
                this.mRunning.notifyAll();
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public int waitForResult() {
            /*
            r2 = this;
            r1 = r2.mRunning;
            monitor-enter(r1);
        L_0x0003:
            r0 = r2.isRunning();	 Catch:{ all -> 0x0017 }
            if (r0 == 0) goto L_0x0011;
        L_0x0009:
            r0 = r2.mRunning;	 Catch:{ InterruptedException -> 0x000f }
            r0.wait();	 Catch:{ InterruptedException -> 0x000f }
            goto L_0x0003;
        L_0x000f:
            r0 = move-exception;
            goto L_0x0003;
        L_0x0011:
            monitor-exit(r1);	 Catch:{ all -> 0x0017 }
            r0 = r2.getResult();
            return r0;
        L_0x0017:
            r0 = move-exception;
            monitor-exit(r1);	 Catch:{ all -> 0x0017 }
            throw r0;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.RestoreEngine.waitForResult():int");
        }

        public int getResult() {
            return this.mResult.get();
        }

        public void setResult(int result) {
            this.mResult.set(result);
        }
    }

    class FullRestoreEngine extends RestoreEngine {
        IBackupAgent mAgent;
        String mAgentPackage;
        boolean mAllowApks;
        boolean mAllowObbs;
        byte[] mBuffer;
        long mBytes;
        final HashSet<String> mClearedPackages;
        final RestoreDeleteObserver mDeleteObserver;
        final RestoreInstallObserver mInstallObserver;
        final HashMap<String, Signature[]> mManifestSignatures;
        FullBackupObbConnection mObbConnection;
        IFullBackupRestoreObserver mObserver;
        PackageInfo mOnlyPackage;
        final HashMap<String, String> mPackageInstallers;
        final HashMap<String, RestorePolicy> mPackagePolicies;
        ParcelFileDescriptor[] mPipes;
        ApplicationInfo mTargetApp;
        byte[] mWidgetData;

        class RestoreDeleteObserver extends IPackageDeleteObserver.Stub {
            final AtomicBoolean mDone;
            int mResult;

            RestoreDeleteObserver() {
                this.mDone = new AtomicBoolean();
            }

            public void reset() {
                synchronized (this.mDone) {
                    this.mDone.set(BackupManagerService.MORE_DEBUG);
                }
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public void waitForCompletion() {
                /*
                r2 = this;
                r1 = r2.mDone;
                monitor-enter(r1);
            L_0x0003:
                r0 = r2.mDone;	 Catch:{ all -> 0x0015 }
                r0 = r0.get();	 Catch:{ all -> 0x0015 }
                if (r0 != 0) goto L_0x0013;
            L_0x000b:
                r0 = r2.mDone;	 Catch:{ InterruptedException -> 0x0011 }
                r0.wait();	 Catch:{ InterruptedException -> 0x0011 }
                goto L_0x0003;
            L_0x0011:
                r0 = move-exception;
                goto L_0x0003;
            L_0x0013:
                monitor-exit(r1);	 Catch:{ all -> 0x0015 }
                return;
            L_0x0015:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x0015 }
                throw r0;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.FullRestoreEngine.RestoreDeleteObserver.waitForCompletion():void");
            }

            public void packageDeleted(String packageName, int returnCode) throws RemoteException {
                synchronized (this.mDone) {
                    this.mResult = returnCode;
                    this.mDone.set(BackupManagerService.DEBUG_SCHEDULING);
                    this.mDone.notifyAll();
                }
            }
        }

        class RestoreFileRunnable implements Runnable {
            IBackupAgent mAgent;
            FileMetadata mInfo;
            ParcelFileDescriptor mSocket;
            int mToken;

            RestoreFileRunnable(IBackupAgent agent, FileMetadata info, ParcelFileDescriptor socket, int token) throws IOException {
                this.mAgent = agent;
                this.mInfo = info;
                this.mToken = token;
                this.mSocket = ParcelFileDescriptor.dup(socket.getFileDescriptor());
            }

            public void run() {
                try {
                    this.mAgent.doRestoreFile(this.mSocket, this.mInfo.size, this.mInfo.type, this.mInfo.domain, this.mInfo.path, this.mInfo.mode, this.mInfo.mtime, this.mToken, BackupManagerService.this.mBackupManagerBinder);
                } catch (RemoteException e) {
                }
            }
        }

        class RestoreInstallObserver extends IPackageInstallObserver.Stub {
            final AtomicBoolean mDone;
            String mPackageName;
            int mResult;

            RestoreInstallObserver() {
                this.mDone = new AtomicBoolean();
            }

            public void reset() {
                synchronized (this.mDone) {
                    this.mDone.set(BackupManagerService.MORE_DEBUG);
                }
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public void waitForCompletion() {
                /*
                r2 = this;
                r1 = r2.mDone;
                monitor-enter(r1);
            L_0x0003:
                r0 = r2.mDone;	 Catch:{ all -> 0x0015 }
                r0 = r0.get();	 Catch:{ all -> 0x0015 }
                if (r0 != 0) goto L_0x0013;
            L_0x000b:
                r0 = r2.mDone;	 Catch:{ InterruptedException -> 0x0011 }
                r0.wait();	 Catch:{ InterruptedException -> 0x0011 }
                goto L_0x0003;
            L_0x0011:
                r0 = move-exception;
                goto L_0x0003;
            L_0x0013:
                monitor-exit(r1);	 Catch:{ all -> 0x0015 }
                return;
            L_0x0015:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x0015 }
                throw r0;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.FullRestoreEngine.RestoreInstallObserver.waitForCompletion():void");
            }

            int getResult() {
                return this.mResult;
            }

            public void packageInstalled(String packageName, int returnCode) throws RemoteException {
                synchronized (this.mDone) {
                    this.mResult = returnCode;
                    this.mPackageName = packageName;
                    this.mDone.set(BackupManagerService.DEBUG_SCHEDULING);
                    this.mDone.notifyAll();
                }
            }
        }

        public FullRestoreEngine(IFullBackupRestoreObserver observer, PackageInfo onlyPackage, boolean allowApks, boolean allowObbs) {
            super();
            this.mObbConnection = null;
            this.mPackagePolicies = new HashMap();
            this.mPackageInstallers = new HashMap();
            this.mManifestSignatures = new HashMap();
            this.mClearedPackages = new HashSet();
            this.mPipes = null;
            this.mWidgetData = null;
            this.mInstallObserver = new RestoreInstallObserver();
            this.mDeleteObserver = new RestoreDeleteObserver();
            this.mObserver = observer;
            this.mOnlyPackage = onlyPackage;
            this.mAllowApks = allowApks;
            this.mAllowObbs = allowObbs;
            this.mBuffer = new byte[32768];
            this.mBytes = 0;
        }

        public boolean restoreOneFile(InputStream instream) {
            if (isRunning()) {
                FileMetadata info = readTarHeaders(instream);
                if (info != null) {
                    String pkg = info.packageName;
                    if (!pkg.equals(this.mAgentPackage)) {
                        if (this.mOnlyPackage == null || pkg.equals(this.mOnlyPackage.packageName)) {
                            if (!this.mPackagePolicies.containsKey(pkg)) {
                                this.mPackagePolicies.put(pkg, RestorePolicy.IGNORE);
                            }
                            if (this.mAgent != null) {
                                Slog.d("RestoreEngine", "Saw new package; finalizing old one");
                                tearDownPipes();
                                tearDownAgent(this.mTargetApp);
                                this.mTargetApp = null;
                                this.mAgentPackage = null;
                            }
                        } else {
                            Slog.w("RestoreEngine", "Expected data for " + this.mOnlyPackage + " but saw " + pkg);
                            setResult(-3);
                            setRunning(BackupManagerService.MORE_DEBUG);
                            return BackupManagerService.MORE_DEBUG;
                        }
                    }
                    if (info.path.equals(BackupManagerService.BACKUP_MANIFEST_FILENAME)) {
                        this.mPackagePolicies.put(pkg, readAppManifest(info, instream));
                        this.mPackageInstallers.put(pkg, info.installerPackageName);
                        skipTarPadding(info.size, instream);
                        sendOnRestorePackage(pkg);
                    } else if (info.path.equals(BackupManagerService.BACKUP_METADATA_FILENAME)) {
                        readMetadata(info, instream);
                        skipTarPadding(info.size, instream);
                    } else {
                        boolean okay = BackupManagerService.DEBUG_SCHEDULING;
                        switch (C01616.f4x2ef7c71f[((RestorePolicy) this.mPackagePolicies.get(pkg)).ordinal()]) {
                            case BackupManagerService.SCHEDULE_FILE_VERSION /*1*/:
                                okay = BackupManagerService.MORE_DEBUG;
                                break;
                            case BackupManagerService.MSG_RUN_ADB_BACKUP /*2*/:
                                if (!info.domain.equals("a")) {
                                    this.mPackagePolicies.put(pkg, RestorePolicy.IGNORE);
                                    okay = BackupManagerService.MORE_DEBUG;
                                    break;
                                }
                                Slog.d("RestoreEngine", "APK file; installing");
                                this.mPackagePolicies.put(pkg, installApk(info, (String) this.mPackageInstallers.get(pkg), instream) ? RestorePolicy.ACCEPT : RestorePolicy.IGNORE);
                                skipTarPadding(info.size, instream);
                                return BackupManagerService.DEBUG_SCHEDULING;
                            case BackupManagerService.MSG_RUN_RESTORE /*3*/:
                                if (info.domain.equals("a")) {
                                    Slog.d("RestoreEngine", "apk present but ACCEPT");
                                    okay = BackupManagerService.MORE_DEBUG;
                                    break;
                                }
                                break;
                            default:
                                Slog.e("RestoreEngine", "Invalid policy from manifest");
                                okay = BackupManagerService.MORE_DEBUG;
                                this.mPackagePolicies.put(pkg, RestorePolicy.IGNORE);
                                break;
                        }
                        if (!isRestorableFile(info)) {
                            okay = BackupManagerService.MORE_DEBUG;
                        }
                        if (okay && this.mAgent != null) {
                            Slog.i("RestoreEngine", "Reusing existing agent instance");
                        }
                        if (okay && this.mAgent == null) {
                            Slog.d("RestoreEngine", "Need to launch agent for " + pkg);
                            try {
                                this.mTargetApp = BackupManagerService.this.mPackageManager.getApplicationInfo(pkg, BackupManagerService.OP_PENDING);
                                if (this.mClearedPackages.contains(pkg)) {
                                    Slog.d("RestoreEngine", "We've initialized this app already; no clear required");
                                } else {
                                    if (this.mTargetApp.backupAgentName == null) {
                                        Slog.d("RestoreEngine", "Clearing app data preparatory to full restore");
                                        BackupManagerService.this.clearApplicationDataSynchronous(pkg);
                                    } else {
                                        Slog.d("RestoreEngine", "backup agent (" + this.mTargetApp.backupAgentName + ") => no clear");
                                    }
                                    this.mClearedPackages.add(pkg);
                                }
                                setUpPipes();
                                this.mAgent = BackupManagerService.this.bindToAgentSynchronous(this.mTargetApp, BackupManagerService.MSG_RUN_RESTORE);
                                this.mAgentPackage = pkg;
                            } catch (IOException e) {
                            } catch (NameNotFoundException e2) {
                            }
                            try {
                                if (this.mAgent == null) {
                                    Slog.d("RestoreEngine", "Unable to create agent for " + pkg);
                                    okay = BackupManagerService.MORE_DEBUG;
                                    tearDownPipes();
                                    this.mPackagePolicies.put(pkg, RestorePolicy.IGNORE);
                                }
                            } catch (Throwable e3) {
                                Slog.w("RestoreEngine", "io exception on restore socket read", e3);
                                setResult(-3);
                                info = null;
                            }
                        }
                        if (okay && !pkg.equals(this.mAgentPackage)) {
                            Slog.e("RestoreEngine", "Restoring data for " + pkg + " but agent is for " + this.mAgentPackage);
                            okay = BackupManagerService.MORE_DEBUG;
                        }
                        if (okay) {
                            boolean agentSuccess = BackupManagerService.DEBUG_SCHEDULING;
                            long toCopy = info.size;
                            int token = BackupManagerService.this.generateToken();
                            try {
                                BackupManagerService.this.prepareOperationTimeout(token, BackupManagerService.TIMEOUT_FULL_BACKUP_INTERVAL, null);
                                if (info.domain.equals("obb")) {
                                    Slog.d("RestoreEngine", "Restoring OBB file for " + pkg + " : " + info.path);
                                    this.mObbConnection.restoreObbFile(pkg, this.mPipes[BackupManagerService.OP_PENDING], info.size, info.type, info.path, info.mode, info.mtime, token, BackupManagerService.this.mBackupManagerBinder);
                                } else {
                                    Slog.d("RestoreEngine", "Invoking agent to restore file " + info.path);
                                    if (this.mTargetApp.processName.equals("system")) {
                                        Slog.d("RestoreEngine", "system process agent - spinning a thread");
                                        new Thread(new RestoreFileRunnable(this.mAgent, info, this.mPipes[BackupManagerService.OP_PENDING], token), "restore-sys-runner").start();
                                    } else {
                                        this.mAgent.doRestoreFile(this.mPipes[BackupManagerService.OP_PENDING], info.size, info.type, info.domain, info.path, info.mode, info.mtime, token, BackupManagerService.this.mBackupManagerBinder);
                                    }
                                }
                            } catch (IOException e4) {
                                Slog.d("RestoreEngine", "Couldn't establish restore");
                                agentSuccess = BackupManagerService.MORE_DEBUG;
                                okay = BackupManagerService.MORE_DEBUG;
                            } catch (RemoteException e5) {
                                Slog.e("RestoreEngine", "Agent crashed during full restore");
                                agentSuccess = BackupManagerService.MORE_DEBUG;
                                okay = BackupManagerService.MORE_DEBUG;
                            }
                            if (okay) {
                                boolean pipeOkay = BackupManagerService.DEBUG_SCHEDULING;
                                FileOutputStream fileOutputStream = new FileOutputStream(this.mPipes[BackupManagerService.SCHEDULE_FILE_VERSION].getFileDescriptor());
                                while (toCopy > 0) {
                                    int nRead = instream.read(this.mBuffer, BackupManagerService.OP_PENDING, toCopy > ((long) this.mBuffer.length) ? this.mBuffer.length : (int) toCopy);
                                    if (nRead >= 0) {
                                        this.mBytes += (long) nRead;
                                    }
                                    if (nRead <= 0) {
                                        skipTarPadding(info.size, instream);
                                        agentSuccess = BackupManagerService.this.waitUntilOperationComplete(token);
                                    } else {
                                        toCopy -= (long) nRead;
                                        if (pipeOkay) {
                                            try {
                                                fileOutputStream.write(this.mBuffer, BackupManagerService.OP_PENDING, nRead);
                                            } catch (Throwable e32) {
                                                Slog.e("RestoreEngine", "Failed to write to restore pipe", e32);
                                                pipeOkay = BackupManagerService.MORE_DEBUG;
                                            }
                                        }
                                    }
                                }
                                skipTarPadding(info.size, instream);
                                agentSuccess = BackupManagerService.this.waitUntilOperationComplete(token);
                            }
                            if (!agentSuccess) {
                                Slog.i("RestoreEngine", "Agent failure; ending restore");
                                BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_TIMEOUT);
                                tearDownPipes();
                                tearDownAgent(this.mTargetApp);
                                this.mAgent = null;
                                this.mPackagePolicies.put(pkg, RestorePolicy.IGNORE);
                                if (this.mOnlyPackage != null) {
                                    setResult(-2);
                                    setRunning(BackupManagerService.MORE_DEBUG);
                                    return BackupManagerService.MORE_DEBUG;
                                }
                            }
                        }
                        if (!okay) {
                            Slog.d("RestoreEngine", "[discarding file content]");
                            long bytesToConsume = (info.size + 511) & -512;
                            while (bytesToConsume > 0) {
                                int toRead;
                                if (bytesToConsume > ((long) this.mBuffer.length)) {
                                    toRead = this.mBuffer.length;
                                } else {
                                    toRead = (int) bytesToConsume;
                                }
                                long nRead2 = (long) instream.read(this.mBuffer, BackupManagerService.OP_PENDING, toRead);
                                if (nRead2 >= 0) {
                                    this.mBytes += nRead2;
                                }
                                if (nRead2 > 0) {
                                    bytesToConsume -= nRead2;
                                }
                            }
                        }
                    }
                }
                if (info == null) {
                    tearDownPipes();
                    tearDownAgent(this.mTargetApp);
                    setRunning(BackupManagerService.MORE_DEBUG);
                }
                if (info != null) {
                    return BackupManagerService.DEBUG_SCHEDULING;
                }
                return BackupManagerService.MORE_DEBUG;
            }
            Slog.w("RestoreEngine", "Restore engine used after halting");
            return BackupManagerService.MORE_DEBUG;
        }

        void setUpPipes() throws IOException {
            this.mPipes = ParcelFileDescriptor.createPipe();
        }

        void tearDownPipes() {
            if (this.mPipes != null) {
                try {
                    this.mPipes[BackupManagerService.OP_PENDING].close();
                    this.mPipes[BackupManagerService.OP_PENDING] = null;
                    this.mPipes[BackupManagerService.SCHEDULE_FILE_VERSION].close();
                    this.mPipes[BackupManagerService.SCHEDULE_FILE_VERSION] = null;
                } catch (IOException e) {
                    Slog.w("RestoreEngine", "Couldn't close agent pipes", e);
                }
                this.mPipes = null;
            }
        }

        void tearDownAgent(ApplicationInfo app) {
            if (this.mAgent != null) {
                try {
                    BackupManagerService.this.mActivityManager.unbindBackupAgent(app);
                    if (app.uid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || app.packageName.equals("com.android.backupconfirm")) {
                        Slog.d("RestoreEngine", "Not killing after full restore");
                        this.mAgent = null;
                    }
                    Slog.d("RestoreEngine", "Killing host process");
                    BackupManagerService.this.mActivityManager.killApplicationProcess(app.processName, app.uid);
                    this.mAgent = null;
                } catch (RemoteException e) {
                    Slog.d("RestoreEngine", "Lost app trying to shut down");
                }
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        boolean installApk(com.android.server.backup.BackupManagerService.FileMetadata r23, java.lang.String r24, java.io.InputStream r25) {
            /*
            r22 = this;
            r9 = 1;
            r18 = "RestoreEngine";
            r19 = new java.lang.StringBuilder;
            r19.<init>();
            r20 = "Installing from backup: ";
            r19 = r19.append(r20);
            r0 = r23;
            r0 = r0.packageName;
            r20 = r0;
            r19 = r19.append(r20);
            r19 = r19.toString();
            android.util.Slog.d(r18, r19);
            r4 = new java.io.File;
            r0 = r22;
            r0 = com.android.server.backup.BackupManagerService.this;
            r18 = r0;
            r0 = r18;
            r0 = r0.mDataDir;
            r18 = r0;
            r0 = r23;
            r0 = r0.packageName;
            r19 = r0;
            r0 = r18;
            r1 = r19;
            r4.<init>(r0, r1);
            r5 = new java.io.FileOutputStream;	 Catch:{ IOException -> 0x018e }
            r5.<init>(r4);	 Catch:{ IOException -> 0x018e }
            r18 = 32768; // 0x8000 float:4.5918E-41 double:1.61895E-319;
            r0 = r18;
            r6 = new byte[r0];	 Catch:{ IOException -> 0x018e }
            r0 = r23;
            r14 = r0.size;	 Catch:{ IOException -> 0x018e }
        L_0x004a:
            r18 = 0;
            r18 = (r14 > r18 ? 1 : (r14 == r18 ? 0 : -1));
            if (r18 <= 0) goto L_0x0098;
        L_0x0050:
            r0 = r6.length;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = r18;
            r0 = (long) r0;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18 = (r18 > r14 ? 1 : (r18 == r14 ? 0 : -1));
            if (r18 >= 0) goto L_0x0095;
        L_0x005c:
            r0 = r6.length;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = r18;
            r0 = (long) r0;	 Catch:{ IOException -> 0x018e }
            r16 = r0;
        L_0x0064:
            r18 = 0;
            r0 = r16;
            r0 = (int) r0;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r0 = r25;
            r1 = r18;
            r2 = r19;
            r7 = r0.read(r6, r1, r2);	 Catch:{ IOException -> 0x018e }
            if (r7 < 0) goto L_0x0088;
        L_0x0077:
            r0 = r22;
            r0 = r0.mBytes;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = (long) r7;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r18 = r18 + r20;
            r0 = r18;
            r2 = r22;
            r2.mBytes = r0;	 Catch:{ IOException -> 0x018e }
        L_0x0088:
            r18 = 0;
            r0 = r18;
            r5.write(r6, r0, r7);	 Catch:{ IOException -> 0x018e }
            r0 = (long) r7;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r14 = r14 - r18;
            goto L_0x004a;
        L_0x0095:
            r16 = r14;
            goto L_0x0064;
        L_0x0098:
            r5.close();	 Catch:{ IOException -> 0x018e }
            r18 = 1;
            r19 = 0;
            r0 = r18;
            r1 = r19;
            r4.setReadable(r0, r1);	 Catch:{ IOException -> 0x018e }
            r10 = android.net.Uri.fromFile(r4);	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18.reset();	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = com.android.server.backup.BackupManagerService.this;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18 = r18.mPackageManager;	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r20 = 34;
            r0 = r18;
            r1 = r19;
            r2 = r20;
            r3 = r24;
            r0.installPackage(r10, r1, r2, r3);	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18.waitForCompletion();	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18 = r18.getResult();	 Catch:{ IOException -> 0x018e }
            r19 = 1;
            r0 = r18;
            r1 = r19;
            if (r0 == r1) goto L_0x0108;
        L_0x00eb:
            r0 = r22;
            r0 = r0.mPackagePolicies;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r18 = r18.get(r19);	 Catch:{ IOException -> 0x018e }
            r19 = com.android.server.backup.BackupManagerService.RestorePolicy.ACCEPT;	 Catch:{ IOException -> 0x018e }
            r0 = r18;
            r1 = r19;
            if (r0 == r1) goto L_0x0104;
        L_0x0103:
            r9 = 0;
        L_0x0104:
            r4.delete();
        L_0x0107:
            return r9;
        L_0x0108:
            r13 = 0;
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = r18;
            r0 = r0.mPackageName;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r18 = r18.equals(r19);	 Catch:{ IOException -> 0x018e }
            if (r18 != 0) goto L_0x019c;
        L_0x0121:
            r18 = "RestoreEngine";
            r19 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x018e }
            r19.<init>();	 Catch:{ IOException -> 0x018e }
            r20 = "Restore stream claimed to include apk for ";
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r20 = " but apk was really ";
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r0 = r20;
            r0 = r0.mPackageName;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r19 = r19.toString();	 Catch:{ IOException -> 0x018e }
            android.util.Slog.w(r18, r19);	 Catch:{ IOException -> 0x018e }
            r9 = 0;
            r13 = 1;
        L_0x0157:
            if (r13 == 0) goto L_0x0104;
        L_0x0159:
            r0 = r22;
            r0 = r0.mDeleteObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18.reset();	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = com.android.server.backup.BackupManagerService.this;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18 = r18.mPackageManager;	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r0 = r19;
            r0 = r0.mPackageName;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r0 = r22;
            r0 = r0.mDeleteObserver;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r21 = 0;
            r18.deletePackage(r19, r20, r21);	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mDeleteObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18.waitForCompletion();	 Catch:{ IOException -> 0x018e }
            goto L_0x0104;
        L_0x018e:
            r8 = move-exception;
            r18 = "RestoreEngine";
            r19 = "Unable to transcribe restored apk for install";
            android.util.Slog.e(r18, r19);	 Catch:{ all -> 0x0297 }
            r9 = 0;
            r4.delete();
            goto L_0x0107;
        L_0x019c:
            r0 = r22;
            r0 = com.android.server.backup.BackupManagerService.this;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r18 = r18.mPackageManager;	 Catch:{ NameNotFoundException -> 0x026f }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x026f }
            r19 = r0;
            r20 = 64;
            r11 = r18.getPackageInfo(r19, r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r0 = r11.applicationInfo;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r0 = r18;
            r0 = r0.flags;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r19 = 32768; // 0x8000 float:4.5918E-41 double:1.61895E-319;
            r18 = r18 & r19;
            if (r18 != 0) goto L_0x01ea;
        L_0x01c3:
            r18 = "RestoreEngine";
            r19 = new java.lang.StringBuilder;	 Catch:{ NameNotFoundException -> 0x026f }
            r19.<init>();	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = "Restore stream contains apk of package ";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = " but it disallows backup/restore";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r19 = r19.toString();	 Catch:{ NameNotFoundException -> 0x026f }
            android.util.Slog.w(r18, r19);	 Catch:{ NameNotFoundException -> 0x026f }
            r9 = 0;
            goto L_0x0157;
        L_0x01ea:
            r0 = r22;
            r0 = r0.mManifestSignatures;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x026f }
            r19 = r0;
            r12 = r18.get(r19);	 Catch:{ NameNotFoundException -> 0x026f }
            r12 = (android.content.pm.Signature[]) r12;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = com.android.server.backup.BackupManagerService.signaturesMatch(r12, r11);	 Catch:{ NameNotFoundException -> 0x026f }
            if (r18 == 0) goto L_0x0247;
        L_0x0202:
            r0 = r11.applicationInfo;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r0 = r18;
            r0 = r0.uid;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r19 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
            r0 = r18;
            r1 = r19;
            if (r0 >= r1) goto L_0x0157;
        L_0x0214:
            r0 = r11.applicationInfo;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r0 = r18;
            r0 = r0.backupAgentName;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            if (r18 != 0) goto L_0x0157;
        L_0x0220:
            r18 = "RestoreEngine";
            r19 = new java.lang.StringBuilder;	 Catch:{ NameNotFoundException -> 0x026f }
            r19.<init>();	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = "Installed app ";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = " has restricted uid and no agent";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r19 = r19.toString();	 Catch:{ NameNotFoundException -> 0x026f }
            android.util.Slog.w(r18, r19);	 Catch:{ NameNotFoundException -> 0x026f }
            r9 = 0;
            goto L_0x0157;
        L_0x0247:
            r18 = "RestoreEngine";
            r19 = new java.lang.StringBuilder;	 Catch:{ NameNotFoundException -> 0x026f }
            r19.<init>();	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = "Installed app ";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = " signatures do not match restore manifest";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r19 = r19.toString();	 Catch:{ NameNotFoundException -> 0x026f }
            android.util.Slog.w(r18, r19);	 Catch:{ NameNotFoundException -> 0x026f }
            r9 = 0;
            r13 = 1;
            goto L_0x0157;
        L_0x026f:
            r8 = move-exception;
            r18 = "RestoreEngine";
            r19 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x018e }
            r19.<init>();	 Catch:{ IOException -> 0x018e }
            r20 = "Install of package ";
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r20 = " succeeded but now not found";
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r19 = r19.toString();	 Catch:{ IOException -> 0x018e }
            android.util.Slog.w(r18, r19);	 Catch:{ IOException -> 0x018e }
            r9 = 0;
            goto L_0x0157;
        L_0x0297:
            r18 = move-exception;
            r4.delete();
            throw r18;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.FullRestoreEngine.installApk(com.android.server.backup.BackupManagerService$FileMetadata, java.lang.String, java.io.InputStream):boolean");
        }

        void skipTarPadding(long size, InputStream instream) throws IOException {
            long partial = (size + 512) % 512;
            if (partial > 0) {
                int needed = 512 - ((int) partial);
                if (readExactly(instream, new byte[needed], BackupManagerService.OP_PENDING, needed) == needed) {
                    this.mBytes += (long) needed;
                    return;
                }
                throw new IOException("Unexpected EOF in padding");
            }
        }

        void readMetadata(FileMetadata info, InputStream instream) throws IOException {
            if (info.size > 65536) {
                throw new IOException("Metadata too big; corrupt? size=" + info.size);
            }
            byte[] buffer = new byte[((int) info.size)];
            if (((long) readExactly(instream, buffer, BackupManagerService.OP_PENDING, (int) info.size)) == info.size) {
                this.mBytes += info.size;
                String[] str = new String[BackupManagerService.SCHEDULE_FILE_VERSION];
                int offset = extractLine(buffer, BackupManagerService.OP_PENDING, str);
                int version = Integer.parseInt(str[BackupManagerService.OP_PENDING]);
                if (version == BackupManagerService.SCHEDULE_FILE_VERSION) {
                    offset = extractLine(buffer, offset, str);
                    String pkg = str[BackupManagerService.OP_PENDING];
                    if (info.packageName.equals(pkg)) {
                        ByteArrayInputStream bin = new ByteArrayInputStream(buffer, offset, buffer.length - offset);
                        DataInputStream in = new DataInputStream(bin);
                        while (bin.available() > 0) {
                            int token = in.readInt();
                            int size = in.readInt();
                            if (size <= 65536) {
                                switch (token) {
                                    case BackupManagerService.BACKUP_WIDGET_METADATA_TOKEN /*33549569*/:
                                        this.mWidgetData = new byte[size];
                                        in.read(this.mWidgetData);
                                        break;
                                    default:
                                        Slog.i("RestoreEngine", "Ignoring metadata blob " + Integer.toHexString(token) + " for " + info.packageName);
                                        in.skipBytes(size);
                                        break;
                                }
                            }
                            throw new IOException("Datum " + Integer.toHexString(token) + " too big; corrupt? size=" + info.size);
                        }
                        return;
                    }
                    Slog.w("RestoreEngine", "Metadata mismatch: package " + info.packageName + " but widget data for " + pkg);
                    return;
                }
                Slog.w("RestoreEngine", "Unsupported metadata version " + version);
                return;
            }
            throw new IOException("Unexpected EOF in widget data");
        }

        RestorePolicy readAppManifest(FileMetadata info, InputStream instream) throws IOException {
            if (info.size > 65536) {
                throw new IOException("Restore manifest too big; corrupt? size=" + info.size);
            }
            byte[] buffer = new byte[((int) info.size)];
            if (((long) readExactly(instream, buffer, BackupManagerService.OP_PENDING, (int) info.size)) == info.size) {
                this.mBytes += info.size;
                RestorePolicy policy = RestorePolicy.IGNORE;
                String[] str = new String[BackupManagerService.SCHEDULE_FILE_VERSION];
                try {
                    int offset = extractLine(buffer, BackupManagerService.OP_PENDING, str);
                    int version = Integer.parseInt(str[BackupManagerService.OP_PENDING]);
                    if (version == BackupManagerService.SCHEDULE_FILE_VERSION) {
                        offset = extractLine(buffer, offset, str);
                        String manifestPackage = str[BackupManagerService.OP_PENDING];
                        if (manifestPackage.equals(info.packageName)) {
                            offset = extractLine(buffer, offset, str);
                            version = Integer.parseInt(str[BackupManagerService.OP_PENDING]);
                            offset = extractLine(buffer, offset, str);
                            int platformVersion = Integer.parseInt(str[BackupManagerService.OP_PENDING]);
                            offset = extractLine(buffer, offset, str);
                            info.installerPackageName = str[BackupManagerService.OP_PENDING].length() > 0 ? str[BackupManagerService.OP_PENDING] : null;
                            offset = extractLine(buffer, offset, str);
                            boolean hasApk = str[BackupManagerService.OP_PENDING].equals("1");
                            offset = extractLine(buffer, offset, str);
                            int numSigs = Integer.parseInt(str[BackupManagerService.OP_PENDING]);
                            if (numSigs > 0) {
                                Signature[] sigs = new Signature[numSigs];
                                for (int i = BackupManagerService.OP_PENDING; i < numSigs; i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                                    offset = extractLine(buffer, offset, str);
                                    sigs[i] = new Signature(str[BackupManagerService.OP_PENDING]);
                                }
                                this.mManifestSignatures.put(info.packageName, sigs);
                                try {
                                    PackageInfo pkgInfo = BackupManagerService.this.mPackageManager.getPackageInfo(info.packageName, 64);
                                    if ((32768 & pkgInfo.applicationInfo.flags) != 0) {
                                        int i2 = pkgInfo.applicationInfo.uid;
                                        if (r0 < BackupManagerService.PBKDF2_HASH_ROUNDS) {
                                            if (pkgInfo.applicationInfo.backupAgentName == null) {
                                                Slog.w("RestoreEngine", "Package " + info.packageName + " is system level with no agent");
                                                if (policy == RestorePolicy.ACCEPT_IF_APK && !hasApk) {
                                                    Slog.i("RestoreEngine", "Cannot restore package " + info.packageName + " without the matching .apk");
                                                }
                                            }
                                        }
                                        if (BackupManagerService.signaturesMatch(sigs, pkgInfo)) {
                                            i2 = pkgInfo.versionCode;
                                            if (r0 >= version) {
                                                Slog.i("RestoreEngine", "Sig + version match; taking data");
                                                policy = RestorePolicy.ACCEPT;
                                            } else if (this.mAllowApks) {
                                                Slog.i("RestoreEngine", "Data version " + version + " is newer than installed version " + pkgInfo.versionCode + " - requiring apk");
                                                policy = RestorePolicy.ACCEPT_IF_APK;
                                            } else {
                                                Slog.i("RestoreEngine", "Data requires newer version " + version + "; ignoring");
                                                policy = RestorePolicy.IGNORE;
                                            }
                                        } else {
                                            Slog.w("RestoreEngine", "Restore manifest signatures do not match installed application for " + info.packageName);
                                        }
                                        Slog.i("RestoreEngine", "Cannot restore package " + info.packageName + " without the matching .apk");
                                    } else {
                                        Slog.i("RestoreEngine", "Restore manifest from " + info.packageName + " but allowBackup=false");
                                        Slog.i("RestoreEngine", "Cannot restore package " + info.packageName + " without the matching .apk");
                                    }
                                } catch (NameNotFoundException e) {
                                    if (this.mAllowApks) {
                                        Slog.i("RestoreEngine", "Package " + info.packageName + " not installed; requiring apk in dataset");
                                        policy = RestorePolicy.ACCEPT_IF_APK;
                                    } else {
                                        policy = RestorePolicy.IGNORE;
                                    }
                                }
                            } else {
                                Slog.i("RestoreEngine", "Missing signature on backed-up package " + info.packageName);
                            }
                        } else {
                            Slog.i("RestoreEngine", "Expected package " + info.packageName + " but restore manifest claims " + manifestPackage);
                        }
                    } else {
                        Slog.i("RestoreEngine", "Unknown restore manifest version " + version + " for package " + info.packageName);
                    }
                } catch (NumberFormatException e2) {
                    Slog.w("RestoreEngine", "Corrupt restore manifest for package " + info.packageName);
                } catch (NameNotFoundException e3) {
                    Slog.w("RestoreEngine", e3.getMessage());
                }
                return policy;
            }
            throw new IOException("Unexpected EOF in manifest");
        }

        int extractLine(byte[] buffer, int offset, String[] outStr) throws IOException {
            int end = buffer.length;
            if (offset >= end) {
                throw new IOException("Incomplete data");
            }
            int pos = offset;
            while (pos < end && buffer[pos] != BackupManagerService.MSG_RUN_ADB_RESTORE) {
                pos += BackupManagerService.SCHEDULE_FILE_VERSION;
            }
            outStr[BackupManagerService.OP_PENDING] = new String(buffer, offset, pos - offset);
            return pos + BackupManagerService.SCHEDULE_FILE_VERSION;
        }

        void dumpFileMetadata(FileMetadata info) {
            char c;
            char c2 = 'x';
            char c3 = 'w';
            char c4 = 'r';
            StringBuilder b = new StringBuilder(DumpState.DUMP_PROVIDERS);
            if (info.type == BackupManagerService.MSG_RUN_ADB_BACKUP) {
                c = 'd';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 256) != 0) {
                c = 'r';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 128) != 0) {
                c = 'w';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 64) != 0) {
                c = 'x';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 32) != 0) {
                c = 'r';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 16) != 0) {
                c = 'w';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 8) != 0) {
                c = 'x';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 4) == 0) {
                c4 = '-';
            }
            b.append(c4);
            if ((info.mode & 2) == 0) {
                c3 = '-';
            }
            b.append(c3);
            if ((info.mode & 1) == 0) {
                c2 = '-';
            }
            b.append(c2);
            Object[] objArr = new Object[BackupManagerService.SCHEDULE_FILE_VERSION];
            objArr[BackupManagerService.OP_PENDING] = Long.valueOf(info.size);
            b.append(String.format(" %9d ", objArr));
            b.append(new SimpleDateFormat("MMM dd HH:mm:ss ").format(new Date(info.mtime)));
            b.append(info.packageName);
            b.append(" :: ");
            b.append(info.domain);
            b.append(" :: ");
            b.append(info.path);
            Slog.i("RestoreEngine", b.toString());
        }

        FileMetadata readTarHeaders(InputStream instream) throws IOException {
            IOException e;
            byte[] block = new byte[BackupManagerService.PBKDF2_SALT_SIZE];
            FileMetadata info = null;
            if (readTarHeader(instream, block)) {
                try {
                    FileMetadata info2 = new FileMetadata();
                    try {
                        info2.size = extractRadix(block, 124, BackupManagerService.MSG_RETRY_CLEAR, BackupManagerService.MSG_RESTORE_TIMEOUT);
                        info2.mtime = extractRadix(block, 136, BackupManagerService.MSG_RETRY_CLEAR, BackupManagerService.MSG_RESTORE_TIMEOUT);
                        info2.mode = extractRadix(block, 100, BackupManagerService.MSG_RESTORE_TIMEOUT, BackupManagerService.MSG_RESTORE_TIMEOUT);
                        info2.path = extractString(block, 345, 155);
                        String path = extractString(block, BackupManagerService.OP_PENDING, 100);
                        if (path.length() > 0) {
                            if (info2.path.length() > 0) {
                                info2.path += '/';
                            }
                            info2.path += path;
                        }
                        int typeChar = block[156];
                        if (typeChar == 120) {
                            boolean gotHeader = readPaxExtendedHeader(instream, info2);
                            if (gotHeader) {
                                gotHeader = readTarHeader(instream, block);
                            }
                            if (gotHeader) {
                                typeChar = block[156];
                            } else {
                                throw new IOException("Bad or missing pax header");
                            }
                        }
                        switch (typeChar) {
                            case BackupManagerService.OP_PENDING /*0*/:
                                Slog.w("RestoreEngine", "Saw type=0 in tar header block, info=" + info2);
                                info = info2;
                                return null;
                            case HdmiCecKeycode.UI_SOUND_PRESENTATION_SOUND_MIX_KARAOKE /*48*/:
                                info2.type = BackupManagerService.SCHEDULE_FILE_VERSION;
                                break;
                            case HdmiCecKeycode.CEC_KEYCODE_DISPLAY_INFORMATION /*53*/:
                                info2.type = BackupManagerService.MSG_RUN_ADB_BACKUP;
                                if (info2.size != 0) {
                                    Slog.w("RestoreEngine", "Directory entry with nonzero size in header");
                                    info2.size = 0;
                                    break;
                                }
                                break;
                            default:
                                Slog.e("RestoreEngine", "Unknown tar entity type: " + typeChar);
                                throw new IOException("Unknown entity type " + typeChar);
                        }
                        if ("shared/".regionMatches(BackupManagerService.OP_PENDING, info2.path, BackupManagerService.OP_PENDING, "shared/".length())) {
                            info2.path = info2.path.substring("shared/".length());
                            info2.packageName = BackupManagerService.SHARED_BACKUP_AGENT_PACKAGE;
                            info2.domain = "shared";
                            Slog.i("RestoreEngine", "File in shared storage: " + info2.path);
                        } else if ("apps/".regionMatches(BackupManagerService.OP_PENDING, info2.path, BackupManagerService.OP_PENDING, "apps/".length())) {
                            info2.path = info2.path.substring("apps/".length());
                            int slash = info2.path.indexOf(47);
                            if (slash < 0) {
                                throw new IOException("Illegal semantic path in " + info2.path);
                            }
                            info2.packageName = info2.path.substring(BackupManagerService.OP_PENDING, slash);
                            info2.path = info2.path.substring(slash + BackupManagerService.SCHEDULE_FILE_VERSION);
                            if (!(info2.path.equals(BackupManagerService.BACKUP_MANIFEST_FILENAME) || info2.path.equals(BackupManagerService.BACKUP_METADATA_FILENAME))) {
                                slash = info2.path.indexOf(47);
                                if (slash < 0) {
                                    throw new IOException("Illegal semantic path in non-manifest " + info2.path);
                                }
                                info2.domain = info2.path.substring(BackupManagerService.OP_PENDING, slash);
                                info2.path = info2.path.substring(slash + BackupManagerService.SCHEDULE_FILE_VERSION);
                            }
                        }
                        info = info2;
                    } catch (IOException e2) {
                        e = e2;
                        info = info2;
                        Slog.e("RestoreEngine", "Parse error in header: " + e.getMessage());
                        HEXLOG(block);
                        throw e;
                    }
                } catch (IOException e3) {
                    e = e3;
                    Slog.e("RestoreEngine", "Parse error in header: " + e.getMessage());
                    HEXLOG(block);
                    throw e;
                }
            }
            return info;
        }

        private boolean isRestorableFile(FileMetadata info) {
            if ("c".equals(info.domain)) {
                return BackupManagerService.MORE_DEBUG;
            }
            if (("r".equals(info.domain) && info.path.startsWith("no_backup/")) || info.path.contains("..") || info.path.contains("//")) {
                return BackupManagerService.MORE_DEBUG;
            }
            return BackupManagerService.DEBUG_SCHEDULING;
        }

        private void HEXLOG(byte[] block) {
            int offset = BackupManagerService.OP_PENDING;
            int todo = block.length;
            StringBuilder buf = new StringBuilder(64);
            while (todo > 0) {
                int numThisLine;
                Object[] objArr = new Object[BackupManagerService.SCHEDULE_FILE_VERSION];
                objArr[BackupManagerService.OP_PENDING] = Integer.valueOf(offset);
                buf.append(String.format("%04x   ", objArr));
                if (todo > 16) {
                    numThisLine = 16;
                } else {
                    numThisLine = todo;
                }
                for (int i = BackupManagerService.OP_PENDING; i < numThisLine; i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                    objArr = new Object[BackupManagerService.SCHEDULE_FILE_VERSION];
                    objArr[BackupManagerService.OP_PENDING] = Byte.valueOf(block[offset + i]);
                    buf.append(String.format("%02x ", objArr));
                }
                Slog.i("hexdump", buf.toString());
                buf.setLength(BackupManagerService.OP_PENDING);
                todo -= numThisLine;
                offset += numThisLine;
            }
        }

        int readExactly(InputStream in, byte[] buffer, int offset, int size) throws IOException {
            if (size <= 0) {
                throw new IllegalArgumentException("size must be > 0");
            }
            int soFar = BackupManagerService.OP_PENDING;
            while (soFar < size) {
                int nRead = in.read(buffer, offset + soFar, size - soFar);
                if (nRead <= 0) {
                    break;
                }
                soFar += nRead;
            }
            return soFar;
        }

        boolean readTarHeader(InputStream instream, byte[] block) throws IOException {
            int got = readExactly(instream, block, BackupManagerService.OP_PENDING, BackupManagerService.PBKDF2_SALT_SIZE);
            if (got == 0) {
                return BackupManagerService.MORE_DEBUG;
            }
            if (got < BackupManagerService.PBKDF2_SALT_SIZE) {
                throw new IOException("Unable to read full block header");
            }
            this.mBytes += 512;
            return BackupManagerService.DEBUG_SCHEDULING;
        }

        boolean readPaxExtendedHeader(InputStream instream, FileMetadata info) throws IOException {
            if (info.size > 32768) {
                Slog.w("RestoreEngine", "Suspiciously large pax header size " + info.size + " - aborting");
                throw new IOException("Sanity failure: pax header size " + info.size);
            }
            byte[] data = new byte[(((int) ((info.size + 511) >> BackupManagerService.MSG_FULL_CONFIRMATION_TIMEOUT)) * BackupManagerService.PBKDF2_SALT_SIZE)];
            if (readExactly(instream, data, BackupManagerService.OP_PENDING, data.length) < data.length) {
                throw new IOException("Unable to read full pax header");
            }
            this.mBytes += (long) data.length;
            int contentSize = (int) info.size;
            int offset = BackupManagerService.OP_PENDING;
            do {
                int eol = offset + BackupManagerService.SCHEDULE_FILE_VERSION;
                while (eol < contentSize && data[eol] != 32) {
                    eol += BackupManagerService.SCHEDULE_FILE_VERSION;
                }
                if (eol >= contentSize) {
                    throw new IOException("Invalid pax data");
                }
                int linelen = (int) extractRadix(data, offset, eol - offset, BackupManagerService.MSG_RUN_ADB_RESTORE);
                int key = eol + BackupManagerService.SCHEDULE_FILE_VERSION;
                eol = (offset + linelen) + BackupManagerService.OP_TIMEOUT;
                int value = key + BackupManagerService.SCHEDULE_FILE_VERSION;
                while (data[value] != 61 && value <= eol) {
                    value += BackupManagerService.SCHEDULE_FILE_VERSION;
                }
                if (value > eol) {
                    throw new IOException("Invalid pax declaration");
                }
                String keyStr = new String(data, key, value - key, "UTF-8");
                String valStr = new String(data, value + BackupManagerService.SCHEDULE_FILE_VERSION, (eol - value) + BackupManagerService.OP_TIMEOUT, "UTF-8");
                if ("path".equals(keyStr)) {
                    info.path = valStr;
                } else if ("size".equals(keyStr)) {
                    info.size = Long.parseLong(valStr);
                } else {
                    Slog.i("RestoreEngine", "Unhandled pax key: " + key);
                }
                offset += linelen;
            } while (offset < contentSize);
            return BackupManagerService.DEBUG_SCHEDULING;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        long extractRadix(byte[] r11, int r12, int r13, int r14) throws java.io.IOException {
            /*
            r10 = this;
            r4 = 0;
            r1 = r12 + r13;
            r2 = r12;
        L_0x0005:
            if (r2 >= r1) goto L_0x000f;
        L_0x0007:
            r0 = r11[r2];
            if (r0 == 0) goto L_0x000f;
        L_0x000b:
            r3 = 32;
            if (r0 != r3) goto L_0x0010;
        L_0x000f:
            return r4;
        L_0x0010:
            r3 = 48;
            if (r0 < r3) goto L_0x001a;
        L_0x0014:
            r3 = r14 + 48;
            r3 = r3 + -1;
            if (r0 <= r3) goto L_0x003e;
        L_0x001a:
            r3 = new java.io.IOException;
            r6 = new java.lang.StringBuilder;
            r6.<init>();
            r7 = "Invalid number in header: '";
            r6 = r6.append(r7);
            r7 = (char) r0;
            r6 = r6.append(r7);
            r7 = "' for radix ";
            r6 = r6.append(r7);
            r6 = r6.append(r14);
            r6 = r6.toString();
            r3.<init>(r6);
            throw r3;
        L_0x003e:
            r6 = (long) r14;
            r6 = r6 * r4;
            r3 = r0 + -48;
            r8 = (long) r3;
            r4 = r6 + r8;
            r2 = r2 + 1;
            goto L_0x0005;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.FullRestoreEngine.extractRadix(byte[], int, int, int):long");
        }

        String extractString(byte[] data, int offset, int maxChars) throws IOException {
            int end = offset + maxChars;
            int eos = offset;
            while (eos < end && data[eos] != null) {
                eos += BackupManagerService.SCHEDULE_FILE_VERSION;
            }
            return new String(data, offset, eos - offset, "US-ASCII");
        }

        void sendStartRestore() {
            if (this.mObserver != null) {
                try {
                    this.mObserver.onStartRestore();
                } catch (RemoteException e) {
                    Slog.w("RestoreEngine", "full restore observer went away: startRestore");
                    this.mObserver = null;
                }
            }
        }

        void sendOnRestorePackage(String name) {
            if (this.mObserver != null) {
                try {
                    this.mObserver.onRestorePackage(name);
                } catch (RemoteException e) {
                    Slog.w("RestoreEngine", "full restore observer went away: restorePackage");
                    this.mObserver = null;
                }
            }
        }

        void sendEndRestore() {
            if (this.mObserver != null) {
                try {
                    this.mObserver.onEndRestore();
                } catch (RemoteException e) {
                    Slog.w("RestoreEngine", "full restore observer went away: endRestore");
                    this.mObserver = null;
                }
            }
        }
    }

    class FullRestoreParams extends FullParams {
        FullRestoreParams(ParcelFileDescriptor input) {
            super();
            this.fd = input;
        }
    }

    public static final class Lifecycle extends SystemService {
        public Lifecycle(Context context) {
            super(context);
            BackupManagerService.sInstance = new Trampoline(context);
        }

        public void onStart() {
            publishBinderService("backup", BackupManagerService.sInstance);
        }

        public void onBootPhase(int phase) {
            boolean areEnabled = BackupManagerService.MORE_DEBUG;
            if (phase == SystemService.PHASE_SYSTEM_SERVICES_READY) {
                BackupManagerService.sInstance.initialize(BackupManagerService.OP_PENDING);
            } else if (phase == NetdResponseCode.InterfaceChange) {
                if (Secure.getInt(BackupManagerService.sInstance.mContext.getContentResolver(), "backup_enabled", BackupManagerService.OP_PENDING) != 0) {
                    areEnabled = BackupManagerService.DEBUG_SCHEDULING;
                }
                try {
                    BackupManagerService.sInstance.setBackupEnabled(areEnabled);
                } catch (RemoteException e) {
                }
            }
        }
    }

    class Operation {
        public BackupRestoreTask callback;
        public int state;

        Operation(int initialState, BackupRestoreTask callbackObj) {
            this.state = initialState;
            this.callback = callbackObj;
        }
    }

    class PerformAdbBackupTask extends FullBackupTask {
        boolean mAllApps;
        FullBackupEngine mBackupEngine;
        boolean mCompress;
        String mCurrentPassword;
        DeflaterOutputStream mDeflater;
        boolean mDoWidgets;
        String mEncryptPassword;
        boolean mIncludeApks;
        boolean mIncludeObbs;
        boolean mIncludeShared;
        boolean mIncludeSystem;
        final AtomicBoolean mLatch;
        ParcelFileDescriptor mOutputFile;
        ArrayList<String> mPackages;

        PerformAdbBackupTask(ParcelFileDescriptor fd, IFullBackupRestoreObserver observer, boolean includeApks, boolean includeObbs, boolean includeShared, boolean doWidgets, String curPassword, String encryptPassword, boolean doAllApps, boolean doSystem, boolean doCompress, String[] packages, AtomicBoolean latch) {
            ArrayList arrayList;
            super(observer);
            this.mLatch = latch;
            this.mOutputFile = fd;
            this.mIncludeApks = includeApks;
            this.mIncludeObbs = includeObbs;
            this.mIncludeShared = includeShared;
            this.mDoWidgets = doWidgets;
            this.mAllApps = doAllApps;
            this.mIncludeSystem = doSystem;
            if (packages == null) {
                arrayList = new ArrayList();
            } else {
                arrayList = new ArrayList(Arrays.asList(packages));
            }
            this.mPackages = arrayList;
            this.mCurrentPassword = curPassword;
            if (encryptPassword == null || "".equals(encryptPassword)) {
                this.mEncryptPassword = curPassword;
            } else {
                this.mEncryptPassword = encryptPassword;
            }
            this.mCompress = doCompress;
        }

        void addPackagesToSet(TreeMap<String, PackageInfo> set, List<String> pkgNames) {
            for (String pkgName : pkgNames) {
                if (!set.containsKey(pkgName)) {
                    try {
                        set.put(pkgName, BackupManagerService.this.mPackageManager.getPackageInfo(pkgName, 64));
                    } catch (NameNotFoundException e) {
                        Slog.w(BackupManagerService.TAG, "Unknown package " + pkgName + ", skipping");
                    }
                }
            }
        }

        private OutputStream emitAesBackupHeader(StringBuilder headerbuf, OutputStream ofstream) throws Exception {
            byte[] newUserSalt = BackupManagerService.this.randomBytes(BackupManagerService.PBKDF2_SALT_SIZE);
            SecretKey userKey = BackupManagerService.this.buildPasswordKey(BackupManagerService.PBKDF_CURRENT, this.mEncryptPassword, newUserSalt, BackupManagerService.PBKDF2_HASH_ROUNDS);
            byte[] masterPw = new byte[32];
            BackupManagerService.this.mRng.nextBytes(masterPw);
            byte[] checksumSalt = BackupManagerService.this.randomBytes(BackupManagerService.PBKDF2_SALT_SIZE);
            Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
            SecretKeySpec masterKeySpec = new SecretKeySpec(masterPw, "AES");
            c.init(BackupManagerService.SCHEDULE_FILE_VERSION, masterKeySpec);
            OutputStream finalOutput = new CipherOutputStream(ofstream, c);
            headerbuf.append(BackupManagerService.ENCRYPTION_ALGORITHM_NAME);
            headerbuf.append('\n');
            headerbuf.append(BackupManagerService.this.byteArrayToHex(newUserSalt));
            headerbuf.append('\n');
            headerbuf.append(BackupManagerService.this.byteArrayToHex(checksumSalt));
            headerbuf.append('\n');
            headerbuf.append(BackupManagerService.PBKDF2_HASH_ROUNDS);
            headerbuf.append('\n');
            Cipher mkC = Cipher.getInstance("AES/CBC/PKCS5Padding");
            mkC.init(BackupManagerService.SCHEDULE_FILE_VERSION, userKey);
            byte[] IV = mkC.getIV();
            headerbuf.append(BackupManagerService.this.byteArrayToHex(IV));
            headerbuf.append('\n');
            IV = c.getIV();
            byte[] mk = masterKeySpec.getEncoded();
            byte[] checksum = BackupManagerService.this.makeKeyChecksum(BackupManagerService.PBKDF_CURRENT, masterKeySpec.getEncoded(), checksumSalt, BackupManagerService.PBKDF2_HASH_ROUNDS);
            int length = IV.length;
            int length2 = mk.length;
            ByteArrayOutputStream blob = new ByteArrayOutputStream(((r0 + r0) + checksum.length) + BackupManagerService.MSG_RUN_RESTORE);
            DataOutputStream dataOutputStream = new DataOutputStream(blob);
            dataOutputStream.writeByte(IV.length);
            dataOutputStream.write(IV);
            dataOutputStream.writeByte(mk.length);
            dataOutputStream.write(mk);
            dataOutputStream.writeByte(checksum.length);
            dataOutputStream.write(checksum);
            dataOutputStream.flush();
            byte[] encryptedMk = mkC.doFinal(blob.toByteArray());
            headerbuf.append(BackupManagerService.this.byteArrayToHex(encryptedMk));
            headerbuf.append('\n');
            return finalOutput;
        }

        private void finalizeBackup(OutputStream out) {
            try {
                out.write(new byte[DumpState.DUMP_PREFERRED_XML]);
            } catch (IOException e) {
                Slog.w(BackupManagerService.TAG, "Error attempting to finalize backup stream");
            }
        }

        public void run() {
            int i;
            PackageInfo pkg;
            Exception e;
            Slog.i(BackupManagerService.TAG, "--- Performing full-dataset adb backup ---");
            TreeMap<String, PackageInfo> packagesToBackup = new TreeMap();
            FullBackupObbConnection fullBackupObbConnection = new FullBackupObbConnection();
            fullBackupObbConnection.establish();
            sendStartBackup();
            if (this.mAllApps) {
                List<PackageInfo> allPackages = BackupManagerService.this.mPackageManager.getInstalledPackages(64);
                for (i = BackupManagerService.OP_PENDING; i < allPackages.size(); i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                    pkg = (PackageInfo) allPackages.get(i);
                    boolean z = this.mIncludeSystem;
                    if (r0 != BackupManagerService.SCHEDULE_FILE_VERSION) {
                        if ((pkg.applicationInfo.flags & BackupManagerService.SCHEDULE_FILE_VERSION) != 0) {
                        }
                    }
                    packagesToBackup.put(pkg.packageName, pkg);
                }
            }
            if (this.mDoWidgets) {
                List<String> pkgs = AppWidgetBackupBridge.getWidgetParticipants(BackupManagerService.OP_PENDING);
                if (pkgs != null) {
                    addPackagesToSet(packagesToBackup, pkgs);
                }
            }
            if (this.mPackages != null) {
                addPackagesToSet(packagesToBackup, this.mPackages);
            }
            Iterator<Entry<String, PackageInfo>> iter = packagesToBackup.entrySet().iterator();
            while (iter.hasNext()) {
                if (!BackupManagerService.appIsEligibleForBackup(((PackageInfo) ((Entry) iter.next()).getValue()).applicationInfo)) {
                    iter.remove();
                }
            }
            ArrayList<PackageInfo> backupQueue = new ArrayList(packagesToBackup.values());
            OutputStream fileOutputStream = new FileOutputStream(this.mOutputFile.getFileDescriptor());
            OutputStream out = null;
            try {
                boolean encrypting;
                OutputStream finalOutput;
                StringBuilder headerbuf;
                OutputStream finalOutput2;
                int N;
                boolean isSharedStorage;
                String str;
                if (this.mEncryptPassword != null) {
                    if (this.mEncryptPassword.length() > 0) {
                        encrypting = BackupManagerService.DEBUG_SCHEDULING;
                        if (BackupManagerService.this.deviceIsEncrypted() || encrypting) {
                            finalOutput = fileOutputStream;
                            if (BackupManagerService.this.backupPasswordMatches(this.mCurrentPassword)) {
                                Slog.w(BackupManagerService.TAG, "Backup password mismatch; aborting");
                                if (out != null) {
                                    try {
                                        out.close();
                                    } catch (IOException e2) {
                                    }
                                }
                                this.mOutputFile.close();
                                synchronized (BackupManagerService.this.mCurrentOpLock) {
                                    BackupManagerService.this.mCurrentOperations.clear();
                                }
                                synchronized (this.mLatch) {
                                    this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                    this.mLatch.notifyAll();
                                }
                                sendEndBackup();
                                fullBackupObbConnection.tearDown();
                                Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                BackupManagerService.this.mWakelock.release();
                            }
                            headerbuf = new StringBuilder(DumpState.DUMP_PREFERRED_XML);
                            headerbuf.append(BackupManagerService.BACKUP_FILE_HEADER_MAGIC);
                            headerbuf.append(BackupManagerService.MSG_RUN_RESTORE);
                            headerbuf.append(this.mCompress ? "\n1\n" : "\n0\n");
                            if (encrypting) {
                                headerbuf.append("none\n");
                                finalOutput2 = finalOutput;
                            } else {
                                try {
                                    finalOutput2 = emitAesBackupHeader(headerbuf, finalOutput);
                                } catch (Exception e3) {
                                    e = e3;
                                    Slog.e(BackupManagerService.TAG, "Unable to emit archive header", e);
                                    if (out != null) {
                                        try {
                                            out.close();
                                        } catch (IOException e4) {
                                            synchronized (BackupManagerService.this.mCurrentOpLock) {
                                                BackupManagerService.this.mCurrentOperations.clear();
                                            }
                                            synchronized (this.mLatch) {
                                                this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                                this.mLatch.notifyAll();
                                            }
                                            sendEndBackup();
                                            fullBackupObbConnection.tearDown();
                                            Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                            BackupManagerService.this.mWakelock.release();
                                            return;
                                        }
                                    }
                                    this.mOutputFile.close();
                                    synchronized (BackupManagerService.this.mCurrentOpLock) {
                                        BackupManagerService.this.mCurrentOperations.clear();
                                    }
                                    synchronized (this.mLatch) {
                                        this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                        this.mLatch.notifyAll();
                                    }
                                    sendEndBackup();
                                    fullBackupObbConnection.tearDown();
                                    Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                    BackupManagerService.this.mWakelock.release();
                                    return;
                                } catch (RemoteException e5) {
                                    Slog.e(BackupManagerService.TAG, "App died during full backup");
                                    if (out != null) {
                                        try {
                                            out.close();
                                        } catch (IOException e6) {
                                            synchronized (BackupManagerService.this.mCurrentOpLock) {
                                            }
                                            BackupManagerService.this.mCurrentOperations.clear();
                                            synchronized (this.mLatch) {
                                            }
                                            this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                            this.mLatch.notifyAll();
                                            sendEndBackup();
                                            fullBackupObbConnection.tearDown();
                                            Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                            BackupManagerService.this.mWakelock.release();
                                        }
                                    }
                                    this.mOutputFile.close();
                                    synchronized (BackupManagerService.this.mCurrentOpLock) {
                                    }
                                    BackupManagerService.this.mCurrentOperations.clear();
                                    synchronized (this.mLatch) {
                                    }
                                    this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                    this.mLatch.notifyAll();
                                    sendEndBackup();
                                    fullBackupObbConnection.tearDown();
                                    Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                    BackupManagerService.this.mWakelock.release();
                                }
                            }
                            try {
                                fileOutputStream.write(headerbuf.toString().getBytes("UTF-8"));
                                if (this.mCompress) {
                                    finalOutput = finalOutput2;
                                } else {
                                    finalOutput = new DeflaterOutputStream(finalOutput2, new Deflater(BackupManagerService.MSG_FULL_CONFIRMATION_TIMEOUT), BackupManagerService.DEBUG_SCHEDULING);
                                }
                                out = finalOutput;
                                if (this.mIncludeShared) {
                                    try {
                                        backupQueue.add(BackupManagerService.this.mPackageManager.getPackageInfo(BackupManagerService.SHARED_BACKUP_AGENT_PACKAGE, BackupManagerService.OP_PENDING));
                                    } catch (NameNotFoundException e7) {
                                        Slog.e(BackupManagerService.TAG, "Unable to find shared-storage backup handler");
                                    }
                                }
                                N = backupQueue.size();
                                while (i < N) {
                                    pkg = (PackageInfo) backupQueue.get(i);
                                    isSharedStorage = pkg.packageName.equals(BackupManagerService.SHARED_BACKUP_AGENT_PACKAGE);
                                    this.mBackupEngine = new FullBackupEngine(out, pkg.packageName, this.mIncludeApks);
                                    if (isSharedStorage) {
                                        str = pkg.packageName;
                                    } else {
                                        str = "Shared storage";
                                    }
                                    sendOnBackupPackage(str);
                                    this.mBackupEngine.backupOnePackage(pkg);
                                    if (this.mIncludeObbs || fullBackupObbConnection.backupObbs(pkg, out)) {
                                    } else {
                                        throw new RuntimeException("Failure writing OBB stack for " + pkg);
                                    }
                                }
                                finalizeBackup(out);
                                if (out != null) {
                                    try {
                                        out.close();
                                    } catch (IOException e8) {
                                    }
                                }
                                this.mOutputFile.close();
                                synchronized (BackupManagerService.this.mCurrentOpLock) {
                                    BackupManagerService.this.mCurrentOperations.clear();
                                }
                                synchronized (this.mLatch) {
                                    this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                    this.mLatch.notifyAll();
                                }
                                sendEndBackup();
                                fullBackupObbConnection.tearDown();
                                Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                BackupManagerService.this.mWakelock.release();
                                return;
                            } catch (Exception e9) {
                                e = e9;
                                finalOutput = finalOutput2;
                                Slog.e(BackupManagerService.TAG, "Unable to emit archive header", e);
                                if (out != null) {
                                    out.close();
                                }
                                this.mOutputFile.close();
                                synchronized (BackupManagerService.this.mCurrentOpLock) {
                                    BackupManagerService.this.mCurrentOperations.clear();
                                }
                                synchronized (this.mLatch) {
                                    this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                    this.mLatch.notifyAll();
                                }
                                sendEndBackup();
                                fullBackupObbConnection.tearDown();
                                Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                BackupManagerService.this.mWakelock.release();
                                return;
                            } catch (RemoteException e52) {
                                Slog.e(BackupManagerService.TAG, "App died during full backup");
                                if (out != null) {
                                    try {
                                        out.close();
                                    } catch (IOException e62) {
                                        synchronized (BackupManagerService.this.mCurrentOpLock) {
                                        }
                                        BackupManagerService.this.mCurrentOperations.clear();
                                        synchronized (this.mLatch) {
                                        }
                                        this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                        this.mLatch.notifyAll();
                                        sendEndBackup();
                                        fullBackupObbConnection.tearDown();
                                        Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                        BackupManagerService.this.mWakelock.release();
                                    }
                                }
                                this.mOutputFile.close();
                                synchronized (BackupManagerService.this.mCurrentOpLock) {
                                }
                                BackupManagerService.this.mCurrentOperations.clear();
                                synchronized (this.mLatch) {
                                }
                                this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                this.mLatch.notifyAll();
                                sendEndBackup();
                                fullBackupObbConnection.tearDown();
                                Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                BackupManagerService.this.mWakelock.release();
                            } catch (Throwable th) {
                                if (out != null) {
                                    try {
                                        out.close();
                                    } catch (IOException e10) {
                                        synchronized (BackupManagerService.this.mCurrentOpLock) {
                                        }
                                        BackupManagerService.this.mCurrentOperations.clear();
                                        synchronized (this.mLatch) {
                                        }
                                        this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                        this.mLatch.notifyAll();
                                        sendEndBackup();
                                        fullBackupObbConnection.tearDown();
                                        Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                        BackupManagerService.this.mWakelock.release();
                                    }
                                }
                                this.mOutputFile.close();
                                synchronized (BackupManagerService.this.mCurrentOpLock) {
                                }
                                BackupManagerService.this.mCurrentOperations.clear();
                                synchronized (this.mLatch) {
                                }
                                this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                this.mLatch.notifyAll();
                                sendEndBackup();
                                fullBackupObbConnection.tearDown();
                                Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                                BackupManagerService.this.mWakelock.release();
                            }
                        } else {
                            Slog.e(BackupManagerService.TAG, "Unencrypted backup of encrypted device; aborting");
                            if (out != null) {
                                try {
                                    out.close();
                                } catch (IOException e11) {
                                }
                            }
                            this.mOutputFile.close();
                            synchronized (BackupManagerService.this.mCurrentOpLock) {
                                BackupManagerService.this.mCurrentOperations.clear();
                            }
                            synchronized (this.mLatch) {
                                this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                this.mLatch.notifyAll();
                            }
                            sendEndBackup();
                            fullBackupObbConnection.tearDown();
                            Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                            BackupManagerService.this.mWakelock.release();
                            return;
                        }
                    }
                }
                encrypting = BackupManagerService.MORE_DEBUG;
                if (BackupManagerService.this.deviceIsEncrypted()) {
                }
                finalOutput = fileOutputStream;
                if (BackupManagerService.this.backupPasswordMatches(this.mCurrentPassword)) {
                    headerbuf = new StringBuilder(DumpState.DUMP_PREFERRED_XML);
                    headerbuf.append(BackupManagerService.BACKUP_FILE_HEADER_MAGIC);
                    headerbuf.append(BackupManagerService.MSG_RUN_RESTORE);
                    if (this.mCompress) {
                    }
                    headerbuf.append(this.mCompress ? "\n1\n" : "\n0\n");
                    if (encrypting) {
                        headerbuf.append("none\n");
                        finalOutput2 = finalOutput;
                    } else {
                        finalOutput2 = emitAesBackupHeader(headerbuf, finalOutput);
                    }
                    fileOutputStream.write(headerbuf.toString().getBytes("UTF-8"));
                    if (this.mCompress) {
                        finalOutput = finalOutput2;
                    } else {
                        finalOutput = new DeflaterOutputStream(finalOutput2, new Deflater(BackupManagerService.MSG_FULL_CONFIRMATION_TIMEOUT), BackupManagerService.DEBUG_SCHEDULING);
                    }
                    out = finalOutput;
                    if (this.mIncludeShared) {
                        backupQueue.add(BackupManagerService.this.mPackageManager.getPackageInfo(BackupManagerService.SHARED_BACKUP_AGENT_PACKAGE, BackupManagerService.OP_PENDING));
                    }
                    N = backupQueue.size();
                    for (i = BackupManagerService.OP_PENDING; i < N; i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                        pkg = (PackageInfo) backupQueue.get(i);
                        isSharedStorage = pkg.packageName.equals(BackupManagerService.SHARED_BACKUP_AGENT_PACKAGE);
                        this.mBackupEngine = new FullBackupEngine(out, pkg.packageName, this.mIncludeApks);
                        if (isSharedStorage) {
                            str = pkg.packageName;
                        } else {
                            str = "Shared storage";
                        }
                        sendOnBackupPackage(str);
                        this.mBackupEngine.backupOnePackage(pkg);
                        if (this.mIncludeObbs) {
                        }
                    }
                    finalizeBackup(out);
                    if (out != null) {
                        out.close();
                    }
                    this.mOutputFile.close();
                    synchronized (BackupManagerService.this.mCurrentOpLock) {
                        BackupManagerService.this.mCurrentOperations.clear();
                    }
                    synchronized (this.mLatch) {
                        this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                        this.mLatch.notifyAll();
                    }
                    sendEndBackup();
                    fullBackupObbConnection.tearDown();
                    Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                    BackupManagerService.this.mWakelock.release();
                    return;
                }
                Slog.w(BackupManagerService.TAG, "Backup password mismatch; aborting");
                if (out != null) {
                    out.close();
                }
                this.mOutputFile.close();
                synchronized (BackupManagerService.this.mCurrentOpLock) {
                    BackupManagerService.this.mCurrentOperations.clear();
                }
                synchronized (this.mLatch) {
                    this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                    this.mLatch.notifyAll();
                }
                sendEndBackup();
                fullBackupObbConnection.tearDown();
                Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                BackupManagerService.this.mWakelock.release();
            } catch (RemoteException e522) {
                Slog.e(BackupManagerService.TAG, "App died during full backup");
                if (out != null) {
                    try {
                        out.close();
                    } catch (IOException e622) {
                        synchronized (BackupManagerService.this.mCurrentOpLock) {
                        }
                        BackupManagerService.this.mCurrentOperations.clear();
                        synchronized (this.mLatch) {
                        }
                        this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                        this.mLatch.notifyAll();
                        sendEndBackup();
                        fullBackupObbConnection.tearDown();
                        Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                        BackupManagerService.this.mWakelock.release();
                    }
                }
                this.mOutputFile.close();
                synchronized (BackupManagerService.this.mCurrentOpLock) {
                }
                BackupManagerService.this.mCurrentOperations.clear();
                synchronized (this.mLatch) {
                }
                this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                this.mLatch.notifyAll();
                sendEndBackup();
                fullBackupObbConnection.tearDown();
                Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                BackupManagerService.this.mWakelock.release();
            } catch (Exception e12) {
                Slog.e(BackupManagerService.TAG, "Internal exception during full backup", e12);
                if (out != null) {
                    try {
                        out.close();
                    } catch (IOException e13) {
                        synchronized (BackupManagerService.this.mCurrentOpLock) {
                        }
                        BackupManagerService.this.mCurrentOperations.clear();
                        synchronized (this.mLatch) {
                        }
                        this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                        this.mLatch.notifyAll();
                        sendEndBackup();
                        fullBackupObbConnection.tearDown();
                        Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                        BackupManagerService.this.mWakelock.release();
                    }
                }
                this.mOutputFile.close();
                synchronized (BackupManagerService.this.mCurrentOpLock) {
                }
                BackupManagerService.this.mCurrentOperations.clear();
                synchronized (this.mLatch) {
                }
                this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                this.mLatch.notifyAll();
                sendEndBackup();
                fullBackupObbConnection.tearDown();
                Slog.d(BackupManagerService.TAG, "Full backup pass complete.");
                BackupManagerService.this.mWakelock.release();
            }
        }
    }

    class PerformAdbRestoreTask implements Runnable {
        IBackupAgent mAgent;
        String mAgentPackage;
        long mBytes;
        final HashSet<String> mClearedPackages;
        String mCurrentPassword;
        String mDecryptPassword;
        final RestoreDeleteObserver mDeleteObserver;
        ParcelFileDescriptor mInputFile;
        final RestoreInstallObserver mInstallObserver;
        AtomicBoolean mLatchObject;
        final HashMap<String, Signature[]> mManifestSignatures;
        FullBackupObbConnection mObbConnection;
        IFullBackupRestoreObserver mObserver;
        final HashMap<String, String> mPackageInstallers;
        final HashMap<String, RestorePolicy> mPackagePolicies;
        ParcelFileDescriptor[] mPipes;
        ApplicationInfo mTargetApp;
        byte[] mWidgetData;

        class RestoreDeleteObserver extends IPackageDeleteObserver.Stub {
            final AtomicBoolean mDone;
            int mResult;

            RestoreDeleteObserver() {
                this.mDone = new AtomicBoolean();
            }

            public void reset() {
                synchronized (this.mDone) {
                    this.mDone.set(BackupManagerService.MORE_DEBUG);
                }
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public void waitForCompletion() {
                /*
                r2 = this;
                r1 = r2.mDone;
                monitor-enter(r1);
            L_0x0003:
                r0 = r2.mDone;	 Catch:{ all -> 0x0015 }
                r0 = r0.get();	 Catch:{ all -> 0x0015 }
                if (r0 != 0) goto L_0x0013;
            L_0x000b:
                r0 = r2.mDone;	 Catch:{ InterruptedException -> 0x0011 }
                r0.wait();	 Catch:{ InterruptedException -> 0x0011 }
                goto L_0x0003;
            L_0x0011:
                r0 = move-exception;
                goto L_0x0003;
            L_0x0013:
                monitor-exit(r1);	 Catch:{ all -> 0x0015 }
                return;
            L_0x0015:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x0015 }
                throw r0;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.PerformAdbRestoreTask.RestoreDeleteObserver.waitForCompletion():void");
            }

            public void packageDeleted(String packageName, int returnCode) throws RemoteException {
                synchronized (this.mDone) {
                    this.mResult = returnCode;
                    this.mDone.set(BackupManagerService.DEBUG_SCHEDULING);
                    this.mDone.notifyAll();
                }
            }
        }

        class RestoreFileRunnable implements Runnable {
            IBackupAgent mAgent;
            FileMetadata mInfo;
            ParcelFileDescriptor mSocket;
            int mToken;

            RestoreFileRunnable(IBackupAgent agent, FileMetadata info, ParcelFileDescriptor socket, int token) throws IOException {
                this.mAgent = agent;
                this.mInfo = info;
                this.mToken = token;
                this.mSocket = ParcelFileDescriptor.dup(socket.getFileDescriptor());
            }

            public void run() {
                try {
                    this.mAgent.doRestoreFile(this.mSocket, this.mInfo.size, this.mInfo.type, this.mInfo.domain, this.mInfo.path, this.mInfo.mode, this.mInfo.mtime, this.mToken, BackupManagerService.this.mBackupManagerBinder);
                } catch (RemoteException e) {
                }
            }
        }

        class RestoreInstallObserver extends IPackageInstallObserver.Stub {
            final AtomicBoolean mDone;
            String mPackageName;
            int mResult;

            RestoreInstallObserver() {
                this.mDone = new AtomicBoolean();
            }

            public void reset() {
                synchronized (this.mDone) {
                    this.mDone.set(BackupManagerService.MORE_DEBUG);
                }
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            public void waitForCompletion() {
                /*
                r2 = this;
                r1 = r2.mDone;
                monitor-enter(r1);
            L_0x0003:
                r0 = r2.mDone;	 Catch:{ all -> 0x0015 }
                r0 = r0.get();	 Catch:{ all -> 0x0015 }
                if (r0 != 0) goto L_0x0013;
            L_0x000b:
                r0 = r2.mDone;	 Catch:{ InterruptedException -> 0x0011 }
                r0.wait();	 Catch:{ InterruptedException -> 0x0011 }
                goto L_0x0003;
            L_0x0011:
                r0 = move-exception;
                goto L_0x0003;
            L_0x0013:
                monitor-exit(r1);	 Catch:{ all -> 0x0015 }
                return;
            L_0x0015:
                r0 = move-exception;
                monitor-exit(r1);	 Catch:{ all -> 0x0015 }
                throw r0;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.PerformAdbRestoreTask.RestoreInstallObserver.waitForCompletion():void");
            }

            int getResult() {
                return this.mResult;
            }

            public void packageInstalled(String packageName, int returnCode) throws RemoteException {
                synchronized (this.mDone) {
                    this.mResult = returnCode;
                    this.mPackageName = packageName;
                    this.mDone.set(BackupManagerService.DEBUG_SCHEDULING);
                    this.mDone.notifyAll();
                }
            }
        }

        PerformAdbRestoreTask(ParcelFileDescriptor fd, String curPassword, String decryptPassword, IFullBackupRestoreObserver observer, AtomicBoolean latch) {
            this.mObbConnection = null;
            this.mPipes = null;
            this.mWidgetData = null;
            this.mPackagePolicies = new HashMap();
            this.mPackageInstallers = new HashMap();
            this.mManifestSignatures = new HashMap();
            this.mClearedPackages = new HashSet();
            this.mInstallObserver = new RestoreInstallObserver();
            this.mDeleteObserver = new RestoreDeleteObserver();
            this.mInputFile = fd;
            this.mCurrentPassword = curPassword;
            this.mDecryptPassword = decryptPassword;
            this.mObserver = observer;
            this.mLatchObject = latch;
            this.mAgent = null;
            this.mAgentPackage = null;
            this.mTargetApp = null;
            this.mObbConnection = new FullBackupObbConnection();
            this.mClearedPackages.add("android");
            this.mClearedPackages.add(BackupManagerService.SETTINGS_PACKAGE);
        }

        public void run() {
            InputStream inputStream;
            Throwable th;
            Slog.i(BackupManagerService.TAG, "--- Performing full-dataset restore ---");
            this.mObbConnection.establish();
            sendStartRestore();
            if (Environment.getExternalStorageState().equals("mounted")) {
                this.mPackagePolicies.put(BackupManagerService.SHARED_BACKUP_AGENT_PACKAGE, RestorePolicy.ACCEPT);
            }
            FileInputStream rawInStream = null;
            DataInputStream rawDataIn = null;
            try {
                if (BackupManagerService.this.backupPasswordMatches(this.mCurrentPassword)) {
                    this.mBytes = 0;
                    byte[] buffer = new byte[32768];
                    InputStream fileInputStream = new FileInputStream(this.mInputFile.getFileDescriptor());
                    try {
                        DataInputStream dataInputStream = new DataInputStream(fileInputStream);
                        boolean compressed = BackupManagerService.MORE_DEBUG;
                        InputStream preCompressStream = fileInputStream;
                        boolean okay = BackupManagerService.MORE_DEBUG;
                        try {
                            byte[] streamHeader = new byte[BackupManagerService.BACKUP_FILE_HEADER_MAGIC.length()];
                            dataInputStream.readFully(streamHeader);
                            if (Arrays.equals(BackupManagerService.BACKUP_FILE_HEADER_MAGIC.getBytes("UTF-8"), streamHeader)) {
                                String s = readHeaderLine(fileInputStream);
                                int archiveVersion = Integer.parseInt(s);
                                if (archiveVersion <= BackupManagerService.MSG_RUN_RESTORE) {
                                    boolean pbkdf2Fallback = archiveVersion == BackupManagerService.SCHEDULE_FILE_VERSION ? BackupManagerService.DEBUG_SCHEDULING : BackupManagerService.MORE_DEBUG;
                                    compressed = Integer.parseInt(readHeaderLine(fileInputStream)) != 0 ? BackupManagerService.DEBUG_SCHEDULING : BackupManagerService.MORE_DEBUG;
                                    s = readHeaderLine(fileInputStream);
                                    if (s.equals("none")) {
                                        okay = BackupManagerService.DEBUG_SCHEDULING;
                                    } else {
                                        if (this.mDecryptPassword != null) {
                                            if (this.mDecryptPassword.length() > 0) {
                                                preCompressStream = decodeAesHeaderAndInitialize(s, pbkdf2Fallback, fileInputStream);
                                                if (preCompressStream != null) {
                                                    okay = BackupManagerService.DEBUG_SCHEDULING;
                                                }
                                            }
                                        }
                                        Slog.w(BackupManagerService.TAG, "Archive is encrypted but no password given");
                                    }
                                } else {
                                    Slog.w(BackupManagerService.TAG, "Wrong header version: " + s);
                                }
                            } else {
                                Slog.w(BackupManagerService.TAG, "Didn't read the right header magic");
                            }
                            if (okay) {
                                InputStream in;
                                if (compressed) {
                                    in = new InflaterInputStream(preCompressStream);
                                } else {
                                    in = preCompressStream;
                                }
                                do {
                                } while (restoreOneFile(in, buffer));
                                tearDownPipes();
                                tearDownAgent(this.mTargetApp);
                                if (dataInputStream != null) {
                                    try {
                                        dataInputStream.close();
                                    } catch (IOException e) {
                                        Slog.w(BackupManagerService.TAG, "Close of restore data pipe threw", e);
                                    }
                                }
                                if (fileInputStream != null) {
                                    fileInputStream.close();
                                }
                                this.mInputFile.close();
                                synchronized (BackupManagerService.this.mCurrentOpLock) {
                                    BackupManagerService.this.mCurrentOperations.clear();
                                }
                                synchronized (this.mLatchObject) {
                                    this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                                    this.mLatchObject.notifyAll();
                                }
                                this.mObbConnection.tearDown();
                                sendEndRestore();
                                Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                                BackupManagerService.this.mWakelock.release();
                                rawDataIn = dataInputStream;
                                inputStream = fileInputStream;
                                return;
                            }
                            Slog.w(BackupManagerService.TAG, "Invalid restore data; aborting.");
                            tearDownPipes();
                            tearDownAgent(this.mTargetApp);
                            if (dataInputStream != null) {
                                try {
                                    dataInputStream.close();
                                } catch (IOException e2) {
                                    Slog.w(BackupManagerService.TAG, "Close of restore data pipe threw", e2);
                                }
                            }
                            if (fileInputStream != null) {
                                fileInputStream.close();
                            }
                            this.mInputFile.close();
                            synchronized (BackupManagerService.this.mCurrentOpLock) {
                                BackupManagerService.this.mCurrentOperations.clear();
                            }
                            synchronized (this.mLatchObject) {
                                this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                                this.mLatchObject.notifyAll();
                            }
                            this.mObbConnection.tearDown();
                            sendEndRestore();
                            Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                            BackupManagerService.this.mWakelock.release();
                            rawDataIn = dataInputStream;
                            inputStream = fileInputStream;
                            return;
                        } catch (IOException e3) {
                            rawDataIn = dataInputStream;
                            rawInStream = fileInputStream;
                            try {
                                Slog.e(BackupManagerService.TAG, "Unable to read restore input");
                                tearDownPipes();
                                tearDownAgent(this.mTargetApp);
                                if (rawDataIn != null) {
                                    try {
                                        rawDataIn.close();
                                    } catch (IOException e22) {
                                        Slog.w(BackupManagerService.TAG, "Close of restore data pipe threw", e22);
                                        synchronized (BackupManagerService.this.mCurrentOpLock) {
                                            BackupManagerService.this.mCurrentOperations.clear();
                                        }
                                        synchronized (this.mLatchObject) {
                                            this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                                            this.mLatchObject.notifyAll();
                                        }
                                        this.mObbConnection.tearDown();
                                        sendEndRestore();
                                        Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                                        BackupManagerService.this.mWakelock.release();
                                    }
                                }
                                if (rawInStream != null) {
                                    rawInStream.close();
                                }
                                this.mInputFile.close();
                                synchronized (BackupManagerService.this.mCurrentOpLock) {
                                    BackupManagerService.this.mCurrentOperations.clear();
                                }
                                synchronized (this.mLatchObject) {
                                    this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                                    this.mLatchObject.notifyAll();
                                }
                                this.mObbConnection.tearDown();
                                sendEndRestore();
                                Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                                BackupManagerService.this.mWakelock.release();
                            } catch (Throwable th2) {
                                th = th2;
                                tearDownPipes();
                                tearDownAgent(this.mTargetApp);
                                if (rawDataIn != null) {
                                    try {
                                        rawDataIn.close();
                                    } catch (IOException e222) {
                                        Slog.w(BackupManagerService.TAG, "Close of restore data pipe threw", e222);
                                        synchronized (BackupManagerService.this.mCurrentOpLock) {
                                            BackupManagerService.this.mCurrentOperations.clear();
                                        }
                                        synchronized (this.mLatchObject) {
                                            this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                                            this.mLatchObject.notifyAll();
                                        }
                                        this.mObbConnection.tearDown();
                                        sendEndRestore();
                                        Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                                        BackupManagerService.this.mWakelock.release();
                                        throw th;
                                    }
                                }
                                if (rawInStream != null) {
                                    rawInStream.close();
                                }
                                this.mInputFile.close();
                                synchronized (BackupManagerService.this.mCurrentOpLock) {
                                    BackupManagerService.this.mCurrentOperations.clear();
                                }
                                synchronized (this.mLatchObject) {
                                    this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                                    this.mLatchObject.notifyAll();
                                }
                                this.mObbConnection.tearDown();
                                sendEndRestore();
                                Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                                BackupManagerService.this.mWakelock.release();
                                throw th;
                            }
                        } catch (Throwable th3) {
                            th = th3;
                            rawDataIn = dataInputStream;
                            rawInStream = fileInputStream;
                            tearDownPipes();
                            tearDownAgent(this.mTargetApp);
                            if (rawDataIn != null) {
                                rawDataIn.close();
                            }
                            if (rawInStream != null) {
                                rawInStream.close();
                            }
                            this.mInputFile.close();
                            synchronized (BackupManagerService.this.mCurrentOpLock) {
                                BackupManagerService.this.mCurrentOperations.clear();
                            }
                            synchronized (this.mLatchObject) {
                                this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                                this.mLatchObject.notifyAll();
                            }
                            this.mObbConnection.tearDown();
                            sendEndRestore();
                            Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                            BackupManagerService.this.mWakelock.release();
                            throw th;
                        }
                    } catch (IOException e4) {
                        inputStream = fileInputStream;
                        Slog.e(BackupManagerService.TAG, "Unable to read restore input");
                        tearDownPipes();
                        tearDownAgent(this.mTargetApp);
                        if (rawDataIn != null) {
                            rawDataIn.close();
                        }
                        if (rawInStream != null) {
                            rawInStream.close();
                        }
                        this.mInputFile.close();
                        synchronized (BackupManagerService.this.mCurrentOpLock) {
                            BackupManagerService.this.mCurrentOperations.clear();
                        }
                        synchronized (this.mLatchObject) {
                            this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                            this.mLatchObject.notifyAll();
                        }
                        this.mObbConnection.tearDown();
                        sendEndRestore();
                        Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                        BackupManagerService.this.mWakelock.release();
                    } catch (Throwable th4) {
                        th = th4;
                        inputStream = fileInputStream;
                        tearDownPipes();
                        tearDownAgent(this.mTargetApp);
                        if (rawDataIn != null) {
                            rawDataIn.close();
                        }
                        if (rawInStream != null) {
                            rawInStream.close();
                        }
                        this.mInputFile.close();
                        synchronized (BackupManagerService.this.mCurrentOpLock) {
                            BackupManagerService.this.mCurrentOperations.clear();
                        }
                        synchronized (this.mLatchObject) {
                            this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                            this.mLatchObject.notifyAll();
                        }
                        this.mObbConnection.tearDown();
                        sendEndRestore();
                        Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                        BackupManagerService.this.mWakelock.release();
                        throw th;
                    }
                }
                Slog.w(BackupManagerService.TAG, "Backup password mismatch; aborting");
                tearDownPipes();
                tearDownAgent(this.mTargetApp);
                if (rawDataIn != null) {
                    try {
                        rawDataIn.close();
                    } catch (IOException e2222) {
                        Slog.w(BackupManagerService.TAG, "Close of restore data pipe threw", e2222);
                    }
                }
                if (rawInStream != null) {
                    rawInStream.close();
                }
                this.mInputFile.close();
                synchronized (BackupManagerService.this.mCurrentOpLock) {
                    BackupManagerService.this.mCurrentOperations.clear();
                }
                synchronized (this.mLatchObject) {
                    this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                    this.mLatchObject.notifyAll();
                }
                this.mObbConnection.tearDown();
                sendEndRestore();
                Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                BackupManagerService.this.mWakelock.release();
            } catch (IOException e5) {
                Slog.e(BackupManagerService.TAG, "Unable to read restore input");
                tearDownPipes();
                tearDownAgent(this.mTargetApp);
                if (rawDataIn != null) {
                    rawDataIn.close();
                }
                if (rawInStream != null) {
                    rawInStream.close();
                }
                this.mInputFile.close();
                synchronized (BackupManagerService.this.mCurrentOpLock) {
                    BackupManagerService.this.mCurrentOperations.clear();
                }
                synchronized (this.mLatchObject) {
                    this.mLatchObject.set(BackupManagerService.DEBUG_SCHEDULING);
                    this.mLatchObject.notifyAll();
                }
                this.mObbConnection.tearDown();
                sendEndRestore();
                Slog.d(BackupManagerService.TAG, "Full restore pass complete.");
                BackupManagerService.this.mWakelock.release();
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        java.lang.String readHeaderLine(java.io.InputStream r4) throws java.io.IOException {
            /*
            r3 = this;
            r0 = new java.lang.StringBuilder;
            r2 = 80;
            r0.<init>(r2);
        L_0x0007:
            r1 = r4.read();
            if (r1 < 0) goto L_0x0011;
        L_0x000d:
            r2 = 10;
            if (r1 != r2) goto L_0x0016;
        L_0x0011:
            r2 = r0.toString();
            return r2;
        L_0x0016:
            r2 = (char) r1;
            r0.append(r2);
            goto L_0x0007;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.PerformAdbRestoreTask.readHeaderLine(java.io.InputStream):java.lang.String");
        }

        InputStream attemptMasterKeyDecryption(String algorithm, byte[] userSalt, byte[] ckSalt, int rounds, String userIvHex, String masterKeyBlobHex, InputStream rawInStream, boolean doLog) {
            try {
                Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
                SecretKey userKey = BackupManagerService.this.buildPasswordKey(algorithm, this.mDecryptPassword, userSalt, rounds);
                IvParameterSpec ivSpec = new IvParameterSpec(BackupManagerService.this.hexToByteArray(userIvHex));
                c.init(BackupManagerService.MSG_RUN_ADB_BACKUP, new SecretKeySpec(userKey.getEncoded(), "AES"), ivSpec);
                byte[] mkBlob = c.doFinal(BackupManagerService.this.hexToByteArray(masterKeyBlobHex));
                int offset = BackupManagerService.OP_PENDING + BackupManagerService.SCHEDULE_FILE_VERSION;
                int len = mkBlob[BackupManagerService.OP_PENDING];
                byte[] IV = Arrays.copyOfRange(mkBlob, offset, len + BackupManagerService.SCHEDULE_FILE_VERSION);
                int offset2 = len + BackupManagerService.SCHEDULE_FILE_VERSION;
                offset = offset2 + BackupManagerService.SCHEDULE_FILE_VERSION;
                len = mkBlob[offset2];
                byte[] mk = Arrays.copyOfRange(mkBlob, offset, offset + len);
                offset2 = offset + len;
                offset = offset2 + BackupManagerService.SCHEDULE_FILE_VERSION;
                if (Arrays.equals(BackupManagerService.this.makeKeyChecksum(algorithm, mk, ckSalt, rounds), Arrays.copyOfRange(mkBlob, offset, offset + mkBlob[offset2]))) {
                    ivSpec = new IvParameterSpec(IV);
                    c.init(BackupManagerService.MSG_RUN_ADB_BACKUP, new SecretKeySpec(mk, "AES"), ivSpec);
                    return new CipherInputStream(rawInStream, c);
                } else if (!doLog) {
                    return null;
                } else {
                    Slog.w(BackupManagerService.TAG, "Incorrect password");
                    return null;
                }
            } catch (InvalidAlgorithmParameterException e) {
                if (!doLog) {
                    return null;
                }
                Slog.e(BackupManagerService.TAG, "Needed parameter spec unavailable!", e);
                return null;
            } catch (BadPaddingException e2) {
                if (!doLog) {
                    return null;
                }
                Slog.w(BackupManagerService.TAG, "Incorrect password");
                return null;
            } catch (IllegalBlockSizeException e3) {
                if (!doLog) {
                    return null;
                }
                Slog.w(BackupManagerService.TAG, "Invalid block size in master key");
                return null;
            } catch (NoSuchAlgorithmException e4) {
                if (!doLog) {
                    return null;
                }
                Slog.e(BackupManagerService.TAG, "Needed decryption algorithm unavailable!");
                return null;
            } catch (NoSuchPaddingException e5) {
                if (!doLog) {
                    return null;
                }
                Slog.e(BackupManagerService.TAG, "Needed padding mechanism unavailable!");
                return null;
            } catch (InvalidKeyException e6) {
                if (!doLog) {
                    return null;
                }
                Slog.w(BackupManagerService.TAG, "Illegal password; aborting");
                return null;
            }
        }

        InputStream decodeAesHeaderAndInitialize(String encryptionName, boolean pbkdf2Fallback, InputStream rawInStream) {
            try {
                if (encryptionName.equals(BackupManagerService.ENCRYPTION_ALGORITHM_NAME)) {
                    byte[] userSalt = BackupManagerService.this.hexToByteArray(readHeaderLine(rawInStream));
                    byte[] ckSalt = BackupManagerService.this.hexToByteArray(readHeaderLine(rawInStream));
                    int rounds = Integer.parseInt(readHeaderLine(rawInStream));
                    String userIvHex = readHeaderLine(rawInStream);
                    String masterKeyBlobHex = readHeaderLine(rawInStream);
                    InputStream result = attemptMasterKeyDecryption(BackupManagerService.PBKDF_CURRENT, userSalt, ckSalt, rounds, userIvHex, masterKeyBlobHex, rawInStream, BackupManagerService.MORE_DEBUG);
                    if (result == null && pbkdf2Fallback) {
                        return attemptMasterKeyDecryption(BackupManagerService.PBKDF_FALLBACK, userSalt, ckSalt, rounds, userIvHex, masterKeyBlobHex, rawInStream, BackupManagerService.DEBUG_SCHEDULING);
                    }
                    return result;
                }
                Slog.w(BackupManagerService.TAG, "Unsupported encryption method: " + encryptionName);
                return null;
            } catch (NumberFormatException e) {
                Slog.w(BackupManagerService.TAG, "Can't parse restore data header");
                return null;
            } catch (IOException e2) {
                Slog.w(BackupManagerService.TAG, "Can't read input header");
                return null;
            }
        }

        boolean restoreOneFile(InputStream instream, byte[] buffer) {
            FileMetadata info;
            try {
                info = readTarHeaders(instream);
                if (info != null) {
                    String pkg = info.packageName;
                    if (!pkg.equals(this.mAgentPackage)) {
                        if (!this.mPackagePolicies.containsKey(pkg)) {
                            this.mPackagePolicies.put(pkg, RestorePolicy.IGNORE);
                        }
                        if (this.mAgent != null) {
                            Slog.d(BackupManagerService.TAG, "Saw new package; finalizing old one");
                            tearDownPipes();
                            tearDownAgent(this.mTargetApp);
                            this.mTargetApp = null;
                            this.mAgentPackage = null;
                        }
                    }
                    if (info.path.equals(BackupManagerService.BACKUP_MANIFEST_FILENAME)) {
                        this.mPackagePolicies.put(pkg, readAppManifest(info, instream));
                        this.mPackageInstallers.put(pkg, info.installerPackageName);
                        skipTarPadding(info.size, instream);
                        sendOnRestorePackage(pkg);
                    } else if (info.path.equals(BackupManagerService.BACKUP_METADATA_FILENAME)) {
                        readMetadata(info, instream);
                        skipTarPadding(info.size, instream);
                    } else {
                        int nRead;
                        boolean okay = BackupManagerService.DEBUG_SCHEDULING;
                        switch (C01616.f4x2ef7c71f[((RestorePolicy) this.mPackagePolicies.get(pkg)).ordinal()]) {
                            case BackupManagerService.SCHEDULE_FILE_VERSION /*1*/:
                                okay = BackupManagerService.MORE_DEBUG;
                                break;
                            case BackupManagerService.MSG_RUN_ADB_BACKUP /*2*/:
                                if (!info.domain.equals("a")) {
                                    this.mPackagePolicies.put(pkg, RestorePolicy.IGNORE);
                                    okay = BackupManagerService.MORE_DEBUG;
                                    break;
                                }
                                Slog.d(BackupManagerService.TAG, "APK file; installing");
                                this.mPackagePolicies.put(pkg, installApk(info, (String) this.mPackageInstallers.get(pkg), instream) ? RestorePolicy.ACCEPT : RestorePolicy.IGNORE);
                                skipTarPadding(info.size, instream);
                                return BackupManagerService.DEBUG_SCHEDULING;
                            case BackupManagerService.MSG_RUN_RESTORE /*3*/:
                                if (info.domain.equals("a")) {
                                    Slog.d(BackupManagerService.TAG, "apk present but ACCEPT");
                                    okay = BackupManagerService.MORE_DEBUG;
                                    break;
                                }
                                break;
                            default:
                                Slog.e(BackupManagerService.TAG, "Invalid policy from manifest");
                                okay = BackupManagerService.MORE_DEBUG;
                                this.mPackagePolicies.put(pkg, RestorePolicy.IGNORE);
                                break;
                        }
                        if (info.path.contains("..") || info.path.contains("//")) {
                            okay = BackupManagerService.MORE_DEBUG;
                        }
                        if (okay && this.mAgent != null) {
                            Slog.i(BackupManagerService.TAG, "Reusing existing agent instance");
                        }
                        if (okay && this.mAgent == null) {
                            Slog.d(BackupManagerService.TAG, "Need to launch agent for " + pkg);
                            try {
                                this.mTargetApp = BackupManagerService.this.mPackageManager.getApplicationInfo(pkg, BackupManagerService.OP_PENDING);
                                if (this.mClearedPackages.contains(pkg)) {
                                    Slog.d(BackupManagerService.TAG, "We've initialized this app already; no clear required");
                                } else {
                                    if (this.mTargetApp.backupAgentName == null) {
                                        Slog.d(BackupManagerService.TAG, "Clearing app data preparatory to full restore");
                                        BackupManagerService.this.clearApplicationDataSynchronous(pkg);
                                    } else {
                                        Slog.d(BackupManagerService.TAG, "backup agent (" + this.mTargetApp.backupAgentName + ") => no clear");
                                    }
                                    this.mClearedPackages.add(pkg);
                                }
                                setUpPipes();
                                this.mAgent = BackupManagerService.this.bindToAgentSynchronous(this.mTargetApp, BackupManagerService.MSG_RUN_RESTORE);
                                this.mAgentPackage = pkg;
                            } catch (IOException e) {
                            } catch (NameNotFoundException e2) {
                            }
                            if (this.mAgent == null) {
                                Slog.d(BackupManagerService.TAG, "Unable to create agent for " + pkg);
                                okay = BackupManagerService.MORE_DEBUG;
                                tearDownPipes();
                                this.mPackagePolicies.put(pkg, RestorePolicy.IGNORE);
                            }
                        }
                        if (okay && !pkg.equals(this.mAgentPackage)) {
                            Slog.e(BackupManagerService.TAG, "Restoring data for " + pkg + " but agent is for " + this.mAgentPackage);
                            okay = BackupManagerService.MORE_DEBUG;
                        }
                        if (okay) {
                            boolean agentSuccess = BackupManagerService.DEBUG_SCHEDULING;
                            long toCopy = info.size;
                            int token = BackupManagerService.this.generateToken();
                            try {
                                BackupManagerService.this.prepareOperationTimeout(token, BackupManagerService.TIMEOUT_FULL_BACKUP_INTERVAL, null);
                                if (info.domain.equals("obb")) {
                                    Slog.d(BackupManagerService.TAG, "Restoring OBB file for " + pkg + " : " + info.path);
                                    this.mObbConnection.restoreObbFile(pkg, this.mPipes[BackupManagerService.OP_PENDING], info.size, info.type, info.path, info.mode, info.mtime, token, BackupManagerService.this.mBackupManagerBinder);
                                } else {
                                    Slog.d(BackupManagerService.TAG, "Invoking agent to restore file " + info.path);
                                    if (this.mTargetApp.processName.equals("system")) {
                                        Slog.d(BackupManagerService.TAG, "system process agent - spinning a thread");
                                        new Thread(new RestoreFileRunnable(this.mAgent, info, this.mPipes[BackupManagerService.OP_PENDING], token), "restore-sys-runner").start();
                                    } else {
                                        this.mAgent.doRestoreFile(this.mPipes[BackupManagerService.OP_PENDING], info.size, info.type, info.domain, info.path, info.mode, info.mtime, token, BackupManagerService.this.mBackupManagerBinder);
                                    }
                                }
                            } catch (IOException e3) {
                                Slog.d(BackupManagerService.TAG, "Couldn't establish restore");
                                agentSuccess = BackupManagerService.MORE_DEBUG;
                                okay = BackupManagerService.MORE_DEBUG;
                            } catch (RemoteException e4) {
                                Slog.e(BackupManagerService.TAG, "Agent crashed during full restore");
                                agentSuccess = BackupManagerService.MORE_DEBUG;
                                okay = BackupManagerService.MORE_DEBUG;
                            }
                            if (okay) {
                                boolean pipeOkay = BackupManagerService.DEBUG_SCHEDULING;
                                FileOutputStream fileOutputStream = new FileOutputStream(this.mPipes[BackupManagerService.SCHEDULE_FILE_VERSION].getFileDescriptor());
                                while (toCopy > 0) {
                                    nRead = instream.read(buffer, BackupManagerService.OP_PENDING, toCopy > ((long) buffer.length) ? buffer.length : (int) toCopy);
                                    if (nRead >= 0) {
                                        this.mBytes += (long) nRead;
                                    }
                                    if (nRead <= 0) {
                                        skipTarPadding(info.size, instream);
                                        agentSuccess = BackupManagerService.this.waitUntilOperationComplete(token);
                                    } else {
                                        toCopy -= (long) nRead;
                                        if (pipeOkay) {
                                            try {
                                                fileOutputStream.write(buffer, BackupManagerService.OP_PENDING, nRead);
                                            } catch (Throwable e5) {
                                                Slog.e(BackupManagerService.TAG, "Failed to write to restore pipe", e5);
                                                pipeOkay = BackupManagerService.MORE_DEBUG;
                                            }
                                        }
                                    }
                                }
                                skipTarPadding(info.size, instream);
                                agentSuccess = BackupManagerService.this.waitUntilOperationComplete(token);
                            }
                            if (!agentSuccess) {
                                BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_TIMEOUT);
                                tearDownPipes();
                                tearDownAgent(this.mTargetApp);
                                this.mAgent = null;
                                this.mPackagePolicies.put(pkg, RestorePolicy.IGNORE);
                            }
                        }
                        if (!okay) {
                            Slog.d(BackupManagerService.TAG, "[discarding file content]");
                            long bytesToConsume = (info.size + 511) & -512;
                            while (bytesToConsume > 0) {
                                int toRead;
                                if (bytesToConsume > ((long) buffer.length)) {
                                    toRead = buffer.length;
                                } else {
                                    toRead = (int) bytesToConsume;
                                }
                                nRead = (long) instream.read(buffer, BackupManagerService.OP_PENDING, toRead);
                                if (nRead >= 0) {
                                    this.mBytes += nRead;
                                }
                                if (nRead > 0) {
                                    bytesToConsume -= nRead;
                                }
                            }
                        }
                    }
                }
            } catch (Throwable e52) {
                Slog.w(BackupManagerService.TAG, "io exception on restore socket read", e52);
                info = null;
            }
            if (info != null) {
                return BackupManagerService.DEBUG_SCHEDULING;
            }
            return BackupManagerService.MORE_DEBUG;
        }

        void setUpPipes() throws IOException {
            this.mPipes = ParcelFileDescriptor.createPipe();
        }

        void tearDownPipes() {
            if (this.mPipes != null) {
                try {
                    this.mPipes[BackupManagerService.OP_PENDING].close();
                    this.mPipes[BackupManagerService.OP_PENDING] = null;
                    this.mPipes[BackupManagerService.SCHEDULE_FILE_VERSION].close();
                    this.mPipes[BackupManagerService.SCHEDULE_FILE_VERSION] = null;
                } catch (IOException e) {
                    Slog.w(BackupManagerService.TAG, "Couldn't close agent pipes", e);
                }
                this.mPipes = null;
            }
        }

        void tearDownAgent(ApplicationInfo app) {
            if (this.mAgent != null) {
                try {
                    BackupManagerService.this.mActivityManager.unbindBackupAgent(app);
                    if (app.uid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || app.packageName.equals("com.android.backupconfirm")) {
                        Slog.d(BackupManagerService.TAG, "Not killing after full restore");
                        this.mAgent = null;
                    }
                    Slog.d(BackupManagerService.TAG, "Killing host process");
                    BackupManagerService.this.mActivityManager.killApplicationProcess(app.processName, app.uid);
                    this.mAgent = null;
                } catch (RemoteException e) {
                    Slog.d(BackupManagerService.TAG, "Lost app trying to shut down");
                }
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        boolean installApk(com.android.server.backup.BackupManagerService.FileMetadata r23, java.lang.String r24, java.io.InputStream r25) {
            /*
            r22 = this;
            r9 = 1;
            r18 = "BackupManagerService";
            r19 = new java.lang.StringBuilder;
            r19.<init>();
            r20 = "Installing from backup: ";
            r19 = r19.append(r20);
            r0 = r23;
            r0 = r0.packageName;
            r20 = r0;
            r19 = r19.append(r20);
            r19 = r19.toString();
            android.util.Slog.d(r18, r19);
            r4 = new java.io.File;
            r0 = r22;
            r0 = com.android.server.backup.BackupManagerService.this;
            r18 = r0;
            r0 = r18;
            r0 = r0.mDataDir;
            r18 = r0;
            r0 = r23;
            r0 = r0.packageName;
            r19 = r0;
            r0 = r18;
            r1 = r19;
            r4.<init>(r0, r1);
            r5 = new java.io.FileOutputStream;	 Catch:{ IOException -> 0x018e }
            r5.<init>(r4);	 Catch:{ IOException -> 0x018e }
            r18 = 32768; // 0x8000 float:4.5918E-41 double:1.61895E-319;
            r0 = r18;
            r6 = new byte[r0];	 Catch:{ IOException -> 0x018e }
            r0 = r23;
            r14 = r0.size;	 Catch:{ IOException -> 0x018e }
        L_0x004a:
            r18 = 0;
            r18 = (r14 > r18 ? 1 : (r14 == r18 ? 0 : -1));
            if (r18 <= 0) goto L_0x0098;
        L_0x0050:
            r0 = r6.length;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = r18;
            r0 = (long) r0;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18 = (r18 > r14 ? 1 : (r18 == r14 ? 0 : -1));
            if (r18 >= 0) goto L_0x0095;
        L_0x005c:
            r0 = r6.length;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = r18;
            r0 = (long) r0;	 Catch:{ IOException -> 0x018e }
            r16 = r0;
        L_0x0064:
            r18 = 0;
            r0 = r16;
            r0 = (int) r0;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r0 = r25;
            r1 = r18;
            r2 = r19;
            r7 = r0.read(r6, r1, r2);	 Catch:{ IOException -> 0x018e }
            if (r7 < 0) goto L_0x0088;
        L_0x0077:
            r0 = r22;
            r0 = r0.mBytes;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = (long) r7;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r18 = r18 + r20;
            r0 = r18;
            r2 = r22;
            r2.mBytes = r0;	 Catch:{ IOException -> 0x018e }
        L_0x0088:
            r18 = 0;
            r0 = r18;
            r5.write(r6, r0, r7);	 Catch:{ IOException -> 0x018e }
            r0 = (long) r7;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r14 = r14 - r18;
            goto L_0x004a;
        L_0x0095:
            r16 = r14;
            goto L_0x0064;
        L_0x0098:
            r5.close();	 Catch:{ IOException -> 0x018e }
            r18 = 1;
            r19 = 0;
            r0 = r18;
            r1 = r19;
            r4.setReadable(r0, r1);	 Catch:{ IOException -> 0x018e }
            r10 = android.net.Uri.fromFile(r4);	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18.reset();	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = com.android.server.backup.BackupManagerService.this;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18 = r18.mPackageManager;	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r20 = 34;
            r0 = r18;
            r1 = r19;
            r2 = r20;
            r3 = r24;
            r0.installPackage(r10, r1, r2, r3);	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18.waitForCompletion();	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18 = r18.getResult();	 Catch:{ IOException -> 0x018e }
            r19 = 1;
            r0 = r18;
            r1 = r19;
            if (r0 == r1) goto L_0x0108;
        L_0x00eb:
            r0 = r22;
            r0 = r0.mPackagePolicies;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r18 = r18.get(r19);	 Catch:{ IOException -> 0x018e }
            r19 = com.android.server.backup.BackupManagerService.RestorePolicy.ACCEPT;	 Catch:{ IOException -> 0x018e }
            r0 = r18;
            r1 = r19;
            if (r0 == r1) goto L_0x0104;
        L_0x0103:
            r9 = 0;
        L_0x0104:
            r4.delete();
        L_0x0107:
            return r9;
        L_0x0108:
            r13 = 0;
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = r18;
            r0 = r0.mPackageName;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r18 = r18.equals(r19);	 Catch:{ IOException -> 0x018e }
            if (r18 != 0) goto L_0x019c;
        L_0x0121:
            r18 = "BackupManagerService";
            r19 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x018e }
            r19.<init>();	 Catch:{ IOException -> 0x018e }
            r20 = "Restore stream claimed to include apk for ";
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r20 = " but apk was really ";
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r0 = r20;
            r0 = r0.mPackageName;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r19 = r19.toString();	 Catch:{ IOException -> 0x018e }
            android.util.Slog.w(r18, r19);	 Catch:{ IOException -> 0x018e }
            r9 = 0;
            r13 = 1;
        L_0x0157:
            if (r13 == 0) goto L_0x0104;
        L_0x0159:
            r0 = r22;
            r0 = r0.mDeleteObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18.reset();	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = com.android.server.backup.BackupManagerService.this;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18 = r18.mPackageManager;	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mInstallObserver;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r0 = r19;
            r0 = r0.mPackageName;	 Catch:{ IOException -> 0x018e }
            r19 = r0;
            r0 = r22;
            r0 = r0.mDeleteObserver;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r21 = 0;
            r18.deletePackage(r19, r20, r21);	 Catch:{ IOException -> 0x018e }
            r0 = r22;
            r0 = r0.mDeleteObserver;	 Catch:{ IOException -> 0x018e }
            r18 = r0;
            r18.waitForCompletion();	 Catch:{ IOException -> 0x018e }
            goto L_0x0104;
        L_0x018e:
            r8 = move-exception;
            r18 = "BackupManagerService";
            r19 = "Unable to transcribe restored apk for install";
            android.util.Slog.e(r18, r19);	 Catch:{ all -> 0x0297 }
            r9 = 0;
            r4.delete();
            goto L_0x0107;
        L_0x019c:
            r0 = r22;
            r0 = com.android.server.backup.BackupManagerService.this;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r18 = r18.mPackageManager;	 Catch:{ NameNotFoundException -> 0x026f }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x026f }
            r19 = r0;
            r20 = 64;
            r11 = r18.getPackageInfo(r19, r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r0 = r11.applicationInfo;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r0 = r18;
            r0 = r0.flags;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r19 = 32768; // 0x8000 float:4.5918E-41 double:1.61895E-319;
            r18 = r18 & r19;
            if (r18 != 0) goto L_0x01ea;
        L_0x01c3:
            r18 = "BackupManagerService";
            r19 = new java.lang.StringBuilder;	 Catch:{ NameNotFoundException -> 0x026f }
            r19.<init>();	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = "Restore stream contains apk of package ";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = " but it disallows backup/restore";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r19 = r19.toString();	 Catch:{ NameNotFoundException -> 0x026f }
            android.util.Slog.w(r18, r19);	 Catch:{ NameNotFoundException -> 0x026f }
            r9 = 0;
            goto L_0x0157;
        L_0x01ea:
            r0 = r22;
            r0 = r0.mManifestSignatures;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x026f }
            r19 = r0;
            r12 = r18.get(r19);	 Catch:{ NameNotFoundException -> 0x026f }
            r12 = (android.content.pm.Signature[]) r12;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = com.android.server.backup.BackupManagerService.signaturesMatch(r12, r11);	 Catch:{ NameNotFoundException -> 0x026f }
            if (r18 == 0) goto L_0x0247;
        L_0x0202:
            r0 = r11.applicationInfo;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r0 = r18;
            r0 = r0.uid;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r19 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
            r0 = r18;
            r1 = r19;
            if (r0 >= r1) goto L_0x0157;
        L_0x0214:
            r0 = r11.applicationInfo;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            r0 = r18;
            r0 = r0.backupAgentName;	 Catch:{ NameNotFoundException -> 0x026f }
            r18 = r0;
            if (r18 != 0) goto L_0x0157;
        L_0x0220:
            r18 = "BackupManagerService";
            r19 = new java.lang.StringBuilder;	 Catch:{ NameNotFoundException -> 0x026f }
            r19.<init>();	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = "Installed app ";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = " has restricted uid and no agent";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r19 = r19.toString();	 Catch:{ NameNotFoundException -> 0x026f }
            android.util.Slog.w(r18, r19);	 Catch:{ NameNotFoundException -> 0x026f }
            r9 = 0;
            goto L_0x0157;
        L_0x0247:
            r18 = "BackupManagerService";
            r19 = new java.lang.StringBuilder;	 Catch:{ NameNotFoundException -> 0x026f }
            r19.<init>();	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = "Installed app ";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r20 = " signatures do not match restore manifest";
            r19 = r19.append(r20);	 Catch:{ NameNotFoundException -> 0x026f }
            r19 = r19.toString();	 Catch:{ NameNotFoundException -> 0x026f }
            android.util.Slog.w(r18, r19);	 Catch:{ NameNotFoundException -> 0x026f }
            r9 = 0;
            r13 = 1;
            goto L_0x0157;
        L_0x026f:
            r8 = move-exception;
            r18 = "BackupManagerService";
            r19 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x018e }
            r19.<init>();	 Catch:{ IOException -> 0x018e }
            r20 = "Install of package ";
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r0 = r23;
            r0 = r0.packageName;	 Catch:{ IOException -> 0x018e }
            r20 = r0;
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r20 = " succeeded but now not found";
            r19 = r19.append(r20);	 Catch:{ IOException -> 0x018e }
            r19 = r19.toString();	 Catch:{ IOException -> 0x018e }
            android.util.Slog.w(r18, r19);	 Catch:{ IOException -> 0x018e }
            r9 = 0;
            goto L_0x0157;
        L_0x0297:
            r18 = move-exception;
            r4.delete();
            throw r18;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.PerformAdbRestoreTask.installApk(com.android.server.backup.BackupManagerService$FileMetadata, java.lang.String, java.io.InputStream):boolean");
        }

        void skipTarPadding(long size, InputStream instream) throws IOException {
            long partial = (size + 512) % 512;
            if (partial > 0) {
                int needed = 512 - ((int) partial);
                if (readExactly(instream, new byte[needed], BackupManagerService.OP_PENDING, needed) == needed) {
                    this.mBytes += (long) needed;
                    return;
                }
                throw new IOException("Unexpected EOF in padding");
            }
        }

        void readMetadata(FileMetadata info, InputStream instream) throws IOException {
            if (info.size > 65536) {
                throw new IOException("Metadata too big; corrupt? size=" + info.size);
            }
            byte[] buffer = new byte[((int) info.size)];
            if (((long) readExactly(instream, buffer, BackupManagerService.OP_PENDING, (int) info.size)) == info.size) {
                this.mBytes += info.size;
                String[] str = new String[BackupManagerService.SCHEDULE_FILE_VERSION];
                int offset = extractLine(buffer, BackupManagerService.OP_PENDING, str);
                int version = Integer.parseInt(str[BackupManagerService.OP_PENDING]);
                if (version == BackupManagerService.SCHEDULE_FILE_VERSION) {
                    offset = extractLine(buffer, offset, str);
                    String pkg = str[BackupManagerService.OP_PENDING];
                    if (info.packageName.equals(pkg)) {
                        ByteArrayInputStream bin = new ByteArrayInputStream(buffer, offset, buffer.length - offset);
                        DataInputStream in = new DataInputStream(bin);
                        while (bin.available() > 0) {
                            int token = in.readInt();
                            int size = in.readInt();
                            if (size <= 65536) {
                                switch (token) {
                                    case BackupManagerService.BACKUP_WIDGET_METADATA_TOKEN /*33549569*/:
                                        this.mWidgetData = new byte[size];
                                        in.read(this.mWidgetData);
                                        break;
                                    default:
                                        Slog.i(BackupManagerService.TAG, "Ignoring metadata blob " + Integer.toHexString(token) + " for " + info.packageName);
                                        in.skipBytes(size);
                                        break;
                                }
                            }
                            throw new IOException("Datum " + Integer.toHexString(token) + " too big; corrupt? size=" + info.size);
                        }
                        return;
                    }
                    Slog.w(BackupManagerService.TAG, "Metadata mismatch: package " + info.packageName + " but widget data for " + pkg);
                    return;
                }
                Slog.w(BackupManagerService.TAG, "Unsupported metadata version " + version);
                return;
            }
            throw new IOException("Unexpected EOF in widget data");
        }

        RestorePolicy readAppManifest(FileMetadata info, InputStream instream) throws IOException {
            if (info.size > 65536) {
                throw new IOException("Restore manifest too big; corrupt? size=" + info.size);
            }
            byte[] buffer = new byte[((int) info.size)];
            if (((long) readExactly(instream, buffer, BackupManagerService.OP_PENDING, (int) info.size)) == info.size) {
                this.mBytes += info.size;
                RestorePolicy policy = RestorePolicy.IGNORE;
                String[] str = new String[BackupManagerService.SCHEDULE_FILE_VERSION];
                try {
                    int offset = extractLine(buffer, BackupManagerService.OP_PENDING, str);
                    int version = Integer.parseInt(str[BackupManagerService.OP_PENDING]);
                    if (version == BackupManagerService.SCHEDULE_FILE_VERSION) {
                        offset = extractLine(buffer, offset, str);
                        String manifestPackage = str[BackupManagerService.OP_PENDING];
                        if (manifestPackage.equals(info.packageName)) {
                            offset = extractLine(buffer, offset, str);
                            version = Integer.parseInt(str[BackupManagerService.OP_PENDING]);
                            offset = extractLine(buffer, offset, str);
                            int platformVersion = Integer.parseInt(str[BackupManagerService.OP_PENDING]);
                            offset = extractLine(buffer, offset, str);
                            info.installerPackageName = str[BackupManagerService.OP_PENDING].length() > 0 ? str[BackupManagerService.OP_PENDING] : null;
                            offset = extractLine(buffer, offset, str);
                            boolean hasApk = str[BackupManagerService.OP_PENDING].equals("1");
                            offset = extractLine(buffer, offset, str);
                            int numSigs = Integer.parseInt(str[BackupManagerService.OP_PENDING]);
                            if (numSigs > 0) {
                                Signature[] sigs = new Signature[numSigs];
                                for (int i = BackupManagerService.OP_PENDING; i < numSigs; i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                                    offset = extractLine(buffer, offset, str);
                                    sigs[i] = new Signature(str[BackupManagerService.OP_PENDING]);
                                }
                                this.mManifestSignatures.put(info.packageName, sigs);
                                try {
                                    PackageInfo pkgInfo = BackupManagerService.this.mPackageManager.getPackageInfo(info.packageName, 64);
                                    if ((32768 & pkgInfo.applicationInfo.flags) != 0) {
                                        int i2 = pkgInfo.applicationInfo.uid;
                                        if (r0 < BackupManagerService.PBKDF2_HASH_ROUNDS) {
                                            if (pkgInfo.applicationInfo.backupAgentName == null) {
                                                Slog.w(BackupManagerService.TAG, "Package " + info.packageName + " is system level with no agent");
                                                if (policy == RestorePolicy.ACCEPT_IF_APK && !hasApk) {
                                                    Slog.i(BackupManagerService.TAG, "Cannot restore package " + info.packageName + " without the matching .apk");
                                                }
                                            }
                                        }
                                        if (BackupManagerService.signaturesMatch(sigs, pkgInfo)) {
                                            i2 = pkgInfo.versionCode;
                                            if (r0 >= version) {
                                                Slog.i(BackupManagerService.TAG, "Sig + version match; taking data");
                                                policy = RestorePolicy.ACCEPT;
                                            } else {
                                                Slog.d(BackupManagerService.TAG, "Data version " + version + " is newer than installed version " + pkgInfo.versionCode + " - requiring apk");
                                                policy = RestorePolicy.ACCEPT_IF_APK;
                                            }
                                        } else {
                                            Slog.w(BackupManagerService.TAG, "Restore manifest signatures do not match installed application for " + info.packageName);
                                        }
                                        Slog.i(BackupManagerService.TAG, "Cannot restore package " + info.packageName + " without the matching .apk");
                                    } else {
                                        Slog.i(BackupManagerService.TAG, "Restore manifest from " + info.packageName + " but allowBackup=false");
                                        Slog.i(BackupManagerService.TAG, "Cannot restore package " + info.packageName + " without the matching .apk");
                                    }
                                } catch (NameNotFoundException e) {
                                    Slog.i(BackupManagerService.TAG, "Package " + info.packageName + " not installed; requiring apk in dataset");
                                    policy = RestorePolicy.ACCEPT_IF_APK;
                                }
                            } else {
                                Slog.i(BackupManagerService.TAG, "Missing signature on backed-up package " + info.packageName);
                            }
                        } else {
                            Slog.i(BackupManagerService.TAG, "Expected package " + info.packageName + " but restore manifest claims " + manifestPackage);
                        }
                    } else {
                        Slog.i(BackupManagerService.TAG, "Unknown restore manifest version " + version + " for package " + info.packageName);
                    }
                } catch (NumberFormatException e2) {
                    Slog.w(BackupManagerService.TAG, "Corrupt restore manifest for package " + info.packageName);
                } catch (IllegalArgumentException e3) {
                    Slog.w(BackupManagerService.TAG, e3.getMessage());
                }
                return policy;
            }
            throw new IOException("Unexpected EOF in manifest");
        }

        int extractLine(byte[] buffer, int offset, String[] outStr) throws IOException {
            int end = buffer.length;
            if (offset >= end) {
                throw new IOException("Incomplete data");
            }
            int pos = offset;
            while (pos < end && buffer[pos] != BackupManagerService.MSG_RUN_ADB_RESTORE) {
                pos += BackupManagerService.SCHEDULE_FILE_VERSION;
            }
            outStr[BackupManagerService.OP_PENDING] = new String(buffer, offset, pos - offset);
            return pos + BackupManagerService.SCHEDULE_FILE_VERSION;
        }

        void dumpFileMetadata(FileMetadata info) {
            char c;
            char c2 = 'x';
            char c3 = 'w';
            char c4 = 'r';
            StringBuilder b = new StringBuilder(DumpState.DUMP_PROVIDERS);
            if (info.type == BackupManagerService.MSG_RUN_ADB_BACKUP) {
                c = 'd';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 256) != 0) {
                c = 'r';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 128) != 0) {
                c = 'w';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 64) != 0) {
                c = 'x';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 32) != 0) {
                c = 'r';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 16) != 0) {
                c = 'w';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 8) != 0) {
                c = 'x';
            } else {
                c = '-';
            }
            b.append(c);
            if ((info.mode & 4) == 0) {
                c4 = '-';
            }
            b.append(c4);
            if ((info.mode & 2) == 0) {
                c3 = '-';
            }
            b.append(c3);
            if ((info.mode & 1) == 0) {
                c2 = '-';
            }
            b.append(c2);
            Object[] objArr = new Object[BackupManagerService.SCHEDULE_FILE_VERSION];
            objArr[BackupManagerService.OP_PENDING] = Long.valueOf(info.size);
            b.append(String.format(" %9d ", objArr));
            b.append(new SimpleDateFormat("MMM dd HH:mm:ss ").format(new Date(info.mtime)));
            b.append(info.packageName);
            b.append(" :: ");
            b.append(info.domain);
            b.append(" :: ");
            b.append(info.path);
            Slog.i(BackupManagerService.TAG, b.toString());
        }

        FileMetadata readTarHeaders(InputStream instream) throws IOException {
            byte[] block = new byte[BackupManagerService.PBKDF2_SALT_SIZE];
            FileMetadata info = null;
            if (readTarHeader(instream, block)) {
                try {
                    FileMetadata info2 = new FileMetadata();
                    try {
                        info2.size = extractRadix(block, 124, BackupManagerService.MSG_RETRY_CLEAR, BackupManagerService.MSG_RESTORE_TIMEOUT);
                        info2.mtime = extractRadix(block, 136, BackupManagerService.MSG_RETRY_CLEAR, BackupManagerService.MSG_RESTORE_TIMEOUT);
                        info2.mode = extractRadix(block, 100, BackupManagerService.MSG_RESTORE_TIMEOUT, BackupManagerService.MSG_RESTORE_TIMEOUT);
                        info2.path = extractString(block, 345, 155);
                        String path = extractString(block, BackupManagerService.OP_PENDING, 100);
                        if (path.length() > 0) {
                            if (info2.path.length() > 0) {
                                info2.path += '/';
                            }
                            info2.path += path;
                        }
                        int typeChar = block[156];
                        if (typeChar == 120) {
                            boolean gotHeader = readPaxExtendedHeader(instream, info2);
                            if (gotHeader) {
                                gotHeader = readTarHeader(instream, block);
                            }
                            if (gotHeader) {
                                typeChar = block[156];
                            } else {
                                throw new IOException("Bad or missing pax header");
                            }
                        }
                        switch (typeChar) {
                            case BackupManagerService.OP_PENDING /*0*/:
                                Slog.w(BackupManagerService.TAG, "Saw type=0 in tar header block, info=" + info2);
                                info = info2;
                                return null;
                            case HdmiCecKeycode.UI_SOUND_PRESENTATION_SOUND_MIX_KARAOKE /*48*/:
                                info2.type = BackupManagerService.SCHEDULE_FILE_VERSION;
                                break;
                            case HdmiCecKeycode.CEC_KEYCODE_DISPLAY_INFORMATION /*53*/:
                                info2.type = BackupManagerService.MSG_RUN_ADB_BACKUP;
                                if (info2.size != 0) {
                                    Slog.w(BackupManagerService.TAG, "Directory entry with nonzero size in header");
                                    info2.size = 0;
                                    break;
                                }
                                break;
                            default:
                                Slog.e(BackupManagerService.TAG, "Unknown tar entity type: " + typeChar);
                                throw new IOException("Unknown entity type " + typeChar);
                        }
                        if ("shared/".regionMatches(BackupManagerService.OP_PENDING, info2.path, BackupManagerService.OP_PENDING, "shared/".length())) {
                            info2.path = info2.path.substring("shared/".length());
                            info2.packageName = BackupManagerService.SHARED_BACKUP_AGENT_PACKAGE;
                            info2.domain = "shared";
                            Slog.i(BackupManagerService.TAG, "File in shared storage: " + info2.path);
                        } else if ("apps/".regionMatches(BackupManagerService.OP_PENDING, info2.path, BackupManagerService.OP_PENDING, "apps/".length())) {
                            info2.path = info2.path.substring("apps/".length());
                            int slash = info2.path.indexOf(47);
                            if (slash < 0) {
                                throw new IOException("Illegal semantic path in " + info2.path);
                            }
                            info2.packageName = info2.path.substring(BackupManagerService.OP_PENDING, slash);
                            info2.path = info2.path.substring(slash + BackupManagerService.SCHEDULE_FILE_VERSION);
                            if (!(info2.path.equals(BackupManagerService.BACKUP_MANIFEST_FILENAME) || info2.path.equals(BackupManagerService.BACKUP_METADATA_FILENAME))) {
                                slash = info2.path.indexOf(47);
                                if (slash < 0) {
                                    throw new IOException("Illegal semantic path in non-manifest " + info2.path);
                                }
                                info2.domain = info2.path.substring(BackupManagerService.OP_PENDING, slash);
                                info2.path = info2.path.substring(slash + BackupManagerService.SCHEDULE_FILE_VERSION);
                            }
                        }
                        info = info2;
                    } catch (IOException e) {
                        e = e;
                        info = info2;
                        Slog.e(BackupManagerService.TAG, "Parse error in header: " + e.getMessage());
                        HEXLOG(block);
                        throw e;
                    }
                } catch (IOException e2) {
                    IOException e3;
                    e3 = e2;
                    Slog.e(BackupManagerService.TAG, "Parse error in header: " + e3.getMessage());
                    HEXLOG(block);
                    throw e3;
                }
            }
            return info;
        }

        private void HEXLOG(byte[] block) {
            int offset = BackupManagerService.OP_PENDING;
            int todo = block.length;
            StringBuilder buf = new StringBuilder(64);
            while (todo > 0) {
                int numThisLine;
                Object[] objArr = new Object[BackupManagerService.SCHEDULE_FILE_VERSION];
                objArr[BackupManagerService.OP_PENDING] = Integer.valueOf(offset);
                buf.append(String.format("%04x   ", objArr));
                if (todo > 16) {
                    numThisLine = 16;
                } else {
                    numThisLine = todo;
                }
                for (int i = BackupManagerService.OP_PENDING; i < numThisLine; i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                    objArr = new Object[BackupManagerService.SCHEDULE_FILE_VERSION];
                    objArr[BackupManagerService.OP_PENDING] = Byte.valueOf(block[offset + i]);
                    buf.append(String.format("%02x ", objArr));
                }
                Slog.i("hexdump", buf.toString());
                buf.setLength(BackupManagerService.OP_PENDING);
                todo -= numThisLine;
                offset += numThisLine;
            }
        }

        int readExactly(InputStream in, byte[] buffer, int offset, int size) throws IOException {
            if (size <= 0) {
                throw new IllegalArgumentException("size must be > 0");
            }
            int soFar = BackupManagerService.OP_PENDING;
            while (soFar < size) {
                int nRead = in.read(buffer, offset + soFar, size - soFar);
                if (nRead <= 0) {
                    break;
                }
                soFar += nRead;
            }
            return soFar;
        }

        boolean readTarHeader(InputStream instream, byte[] block) throws IOException {
            int got = readExactly(instream, block, BackupManagerService.OP_PENDING, BackupManagerService.PBKDF2_SALT_SIZE);
            if (got == 0) {
                return BackupManagerService.MORE_DEBUG;
            }
            if (got < BackupManagerService.PBKDF2_SALT_SIZE) {
                throw new IOException("Unable to read full block header");
            }
            this.mBytes += 512;
            return BackupManagerService.DEBUG_SCHEDULING;
        }

        boolean readPaxExtendedHeader(InputStream instream, FileMetadata info) throws IOException {
            if (info.size > 32768) {
                Slog.w(BackupManagerService.TAG, "Suspiciously large pax header size " + info.size + " - aborting");
                throw new IOException("Sanity failure: pax header size " + info.size);
            }
            byte[] data = new byte[(((int) ((info.size + 511) >> BackupManagerService.MSG_FULL_CONFIRMATION_TIMEOUT)) * BackupManagerService.PBKDF2_SALT_SIZE)];
            if (readExactly(instream, data, BackupManagerService.OP_PENDING, data.length) < data.length) {
                throw new IOException("Unable to read full pax header");
            }
            this.mBytes += (long) data.length;
            int contentSize = (int) info.size;
            int offset = BackupManagerService.OP_PENDING;
            do {
                int eol = offset + BackupManagerService.SCHEDULE_FILE_VERSION;
                while (eol < contentSize && data[eol] != 32) {
                    eol += BackupManagerService.SCHEDULE_FILE_VERSION;
                }
                if (eol >= contentSize) {
                    throw new IOException("Invalid pax data");
                }
                int linelen = (int) extractRadix(data, offset, eol - offset, BackupManagerService.MSG_RUN_ADB_RESTORE);
                int key = eol + BackupManagerService.SCHEDULE_FILE_VERSION;
                eol = (offset + linelen) + BackupManagerService.OP_TIMEOUT;
                int value = key + BackupManagerService.SCHEDULE_FILE_VERSION;
                while (data[value] != 61 && value <= eol) {
                    value += BackupManagerService.SCHEDULE_FILE_VERSION;
                }
                if (value > eol) {
                    throw new IOException("Invalid pax declaration");
                }
                String keyStr = new String(data, key, value - key, "UTF-8");
                String valStr = new String(data, value + BackupManagerService.SCHEDULE_FILE_VERSION, (eol - value) + BackupManagerService.OP_TIMEOUT, "UTF-8");
                if ("path".equals(keyStr)) {
                    info.path = valStr;
                } else if ("size".equals(keyStr)) {
                    info.size = Long.parseLong(valStr);
                } else {
                    Slog.i(BackupManagerService.TAG, "Unhandled pax key: " + key);
                }
                offset += linelen;
            } while (offset < contentSize);
            return BackupManagerService.DEBUG_SCHEDULING;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        long extractRadix(byte[] r11, int r12, int r13, int r14) throws java.io.IOException {
            /*
            r10 = this;
            r4 = 0;
            r1 = r12 + r13;
            r2 = r12;
        L_0x0005:
            if (r2 >= r1) goto L_0x000f;
        L_0x0007:
            r0 = r11[r2];
            if (r0 == 0) goto L_0x000f;
        L_0x000b:
            r3 = 32;
            if (r0 != r3) goto L_0x0010;
        L_0x000f:
            return r4;
        L_0x0010:
            r3 = 48;
            if (r0 < r3) goto L_0x001a;
        L_0x0014:
            r3 = r14 + 48;
            r3 = r3 + -1;
            if (r0 <= r3) goto L_0x003e;
        L_0x001a:
            r3 = new java.io.IOException;
            r6 = new java.lang.StringBuilder;
            r6.<init>();
            r7 = "Invalid number in header: '";
            r6 = r6.append(r7);
            r7 = (char) r0;
            r6 = r6.append(r7);
            r7 = "' for radix ";
            r6 = r6.append(r7);
            r6 = r6.append(r14);
            r6 = r6.toString();
            r3.<init>(r6);
            throw r3;
        L_0x003e:
            r6 = (long) r14;
            r6 = r6 * r4;
            r3 = r0 + -48;
            r8 = (long) r3;
            r4 = r6 + r8;
            r2 = r2 + 1;
            goto L_0x0005;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.PerformAdbRestoreTask.extractRadix(byte[], int, int, int):long");
        }

        String extractString(byte[] data, int offset, int maxChars) throws IOException {
            int end = offset + maxChars;
            int eos = offset;
            while (eos < end && data[eos] != null) {
                eos += BackupManagerService.SCHEDULE_FILE_VERSION;
            }
            return new String(data, offset, eos - offset, "US-ASCII");
        }

        void sendStartRestore() {
            if (this.mObserver != null) {
                try {
                    this.mObserver.onStartRestore();
                } catch (RemoteException e) {
                    Slog.w(BackupManagerService.TAG, "full restore observer went away: startRestore");
                    this.mObserver = null;
                }
            }
        }

        void sendOnRestorePackage(String name) {
            if (this.mObserver != null) {
                try {
                    this.mObserver.onRestorePackage(name);
                } catch (RemoteException e) {
                    Slog.w(BackupManagerService.TAG, "full restore observer went away: restorePackage");
                    this.mObserver = null;
                }
            }
        }

        void sendEndRestore() {
            if (this.mObserver != null) {
                try {
                    this.mObserver.onEndRestore();
                } catch (RemoteException e) {
                    Slog.w(BackupManagerService.TAG, "full restore observer went away: endRestore");
                    this.mObserver = null;
                }
            }
        }
    }

    class PerformBackupTask implements BackupRestoreTask {
        private static final String TAG = "PerformBackupTask";
        IBackupAgent mAgentBinder;
        ParcelFileDescriptor mBackupData;
        File mBackupDataName;
        PackageInfo mCurrentPackage;
        BackupState mCurrentState;
        boolean mFinished;
        File mJournal;
        ParcelFileDescriptor mNewState;
        File mNewStateName;
        ArrayList<BackupRequest> mOriginalQueue;
        ArrayList<BackupRequest> mQueue;
        ParcelFileDescriptor mSavedState;
        File mSavedStateName;
        File mStateDir;
        int mStatus;
        IBackupTransport mTransport;

        public PerformBackupTask(IBackupTransport transport, String dirName, ArrayList<BackupRequest> queue, File journal) {
            this.mTransport = transport;
            this.mOriginalQueue = queue;
            this.mJournal = journal;
            this.mStateDir = new File(BackupManagerService.this.mBaseStateDir, dirName);
            this.mCurrentState = BackupState.INITIAL;
            this.mFinished = BackupManagerService.MORE_DEBUG;
            BackupManagerService.this.addBackupTrace("STATE => INITIAL");
        }

        public void execute() {
            switch (C01616.f3x2e34116e[this.mCurrentState.ordinal()]) {
                case BackupManagerService.SCHEDULE_FILE_VERSION /*1*/:
                    beginBackup();
                case BackupManagerService.MSG_RUN_ADB_BACKUP /*2*/:
                    invokeNextAgent();
                case BackupManagerService.MSG_RUN_RESTORE /*3*/:
                    if (this.mFinished) {
                        Slog.e(TAG, "Duplicate finish");
                    } else {
                        finalizeBackup();
                    }
                    this.mFinished = BackupManagerService.DEBUG_SCHEDULING;
                default:
            }
        }

        void beginBackup() {
            BackupManagerService.this.clearBackupTrace();
            StringBuilder b = new StringBuilder(BackupManagerService.PBKDF2_KEY_SIZE);
            b.append("beginBackup: [");
            Iterator i$ = this.mOriginalQueue.iterator();
            while (i$.hasNext()) {
                BackupRequest req = (BackupRequest) i$.next();
                b.append(' ');
                b.append(req.packageName);
            }
            b.append(" ]");
            BackupManagerService.this.addBackupTrace(b.toString());
            this.mAgentBinder = null;
            this.mStatus = BackupManagerService.OP_PENDING;
            if (this.mOriginalQueue.isEmpty()) {
                Slog.w(TAG, "Backup begun with an empty queue - nothing to do.");
                BackupManagerService.this.addBackupTrace("queue empty at begin");
                executeNextState(BackupState.FINAL);
                return;
            }
            this.mQueue = (ArrayList) this.mOriginalQueue.clone();
            Slog.v(TAG, "Beginning backup of " + this.mQueue.size() + " targets");
            File pmState = new File(this.mStateDir, BackupManagerService.PACKAGE_MANAGER_SENTINEL);
            try {
                String transportName = this.mTransport.transportDirName();
                EventLog.writeEvent(EventLogTags.BACKUP_START, transportName);
                if (this.mStatus == 0 && pmState.length() <= 0) {
                    Slog.i(TAG, "Initializing (wiping) backup state and transport storage");
                    BackupManagerService.this.addBackupTrace("initializing transport " + transportName);
                    BackupManagerService.this.resetBackupState(this.mStateDir);
                    this.mStatus = this.mTransport.initializeDevice();
                    BackupManagerService.this.addBackupTrace("transport.initializeDevice() == " + this.mStatus);
                    if (this.mStatus == 0) {
                        EventLog.writeEvent(EventLogTags.BACKUP_INITIALIZE, new Object[BackupManagerService.OP_PENDING]);
                    } else {
                        EventLog.writeEvent(EventLogTags.BACKUP_TRANSPORT_FAILURE, "(initialize)");
                        Slog.e(TAG, "Transport error in initializeDevice()");
                    }
                }
                if (this.mStatus == 0) {
                    this.mStatus = invokeAgentForBackup(BackupManagerService.PACKAGE_MANAGER_SENTINEL, IBackupAgent.Stub.asInterface(new PackageManagerBackupAgent(BackupManagerService.this.mPackageManager).onBind()), this.mTransport);
                    BackupManagerService.this.addBackupTrace("PMBA invoke: " + this.mStatus);
                    BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_TIMEOUT);
                }
                if (this.mStatus == -1001) {
                    EventLog.writeEvent(EventLogTags.BACKUP_RESET, this.mTransport.transportDirName());
                }
                BackupManagerService.this.addBackupTrace("exiting prelim: " + this.mStatus);
                if (this.mStatus != 0) {
                    BackupManagerService.this.resetBackupState(this.mStateDir);
                    executeNextState(BackupState.FINAL);
                }
            } catch (Exception e) {
                Slog.e(TAG, "Error in backup thread", e);
                BackupManagerService.this.addBackupTrace("Exception in backup thread: " + e);
                this.mStatus = -1000;
                BackupManagerService.this.addBackupTrace("exiting prelim: " + this.mStatus);
                if (this.mStatus != 0) {
                    BackupManagerService.this.resetBackupState(this.mStateDir);
                    executeNextState(BackupState.FINAL);
                }
            } catch (Throwable th) {
                BackupManagerService.this.addBackupTrace("exiting prelim: " + this.mStatus);
                if (this.mStatus != 0) {
                    BackupManagerService.this.resetBackupState(this.mStateDir);
                    executeNextState(BackupState.FINAL);
                }
            }
        }

        void invokeNextAgent() {
            BackupState nextState;
            this.mStatus = BackupManagerService.OP_PENDING;
            BackupManagerService.this.addBackupTrace("invoke q=" + this.mQueue.size());
            if (this.mQueue.isEmpty()) {
                Slog.i(TAG, "queue now empty");
                executeNextState(BackupState.FINAL);
                return;
            }
            BackupRequest request = (BackupRequest) this.mQueue.get(BackupManagerService.OP_PENDING);
            this.mQueue.remove(BackupManagerService.OP_PENDING);
            Slog.d(TAG, "starting agent for backup of " + request);
            BackupManagerService.this.addBackupTrace("launch agent for " + request.packageName);
            try {
                this.mCurrentPackage = BackupManagerService.this.mPackageManager.getPackageInfo(request.packageName, 64);
                if (this.mCurrentPackage.applicationInfo.backupAgentName == null) {
                    Slog.i(TAG, "Package " + request.packageName + " no longer supports backup; skipping");
                    BackupManagerService.this.addBackupTrace("skipping - no agent, completion is noop");
                    executeNextState(BackupState.RUNNING_QUEUE);
                    BackupManagerService.this.mWakelock.setWorkSource(null);
                    if (this.mStatus != 0) {
                        nextState = BackupState.RUNNING_QUEUE;
                        this.mAgentBinder = null;
                        if (this.mStatus == -1003) {
                            BackupManagerService.this.dataChangedImpl(request.packageName);
                            this.mStatus = BackupManagerService.OP_PENDING;
                            if (this.mQueue.isEmpty()) {
                                nextState = BackupState.FINAL;
                            }
                        } else if (this.mStatus == -1004) {
                            this.mStatus = BackupManagerService.OP_PENDING;
                        } else {
                            revertAndEndBackup();
                            nextState = BackupState.FINAL;
                        }
                        executeNextState(nextState);
                        return;
                    }
                    BackupManagerService.this.addBackupTrace("expecting completion/timeout callback");
                } else if ((this.mCurrentPackage.applicationInfo.flags & 2097152) != 0) {
                    BackupManagerService.this.addBackupTrace("skipping - stopped");
                    executeNextState(BackupState.RUNNING_QUEUE);
                    BackupManagerService.this.mWakelock.setWorkSource(null);
                    if (this.mStatus != 0) {
                        nextState = BackupState.RUNNING_QUEUE;
                        this.mAgentBinder = null;
                        if (this.mStatus == -1003) {
                            BackupManagerService.this.dataChangedImpl(request.packageName);
                            this.mStatus = BackupManagerService.OP_PENDING;
                            if (this.mQueue.isEmpty()) {
                                nextState = BackupState.FINAL;
                            }
                        } else if (this.mStatus == -1004) {
                            this.mStatus = BackupManagerService.OP_PENDING;
                        } else {
                            revertAndEndBackup();
                            nextState = BackupState.FINAL;
                        }
                        executeNextState(nextState);
                        return;
                    }
                    BackupManagerService.this.addBackupTrace("expecting completion/timeout callback");
                } else {
                    try {
                        boolean z;
                        BackupManagerService.this.mWakelock.setWorkSource(new WorkSource(this.mCurrentPackage.applicationInfo.uid));
                        IBackupAgent agent = BackupManagerService.this.bindToAgentSynchronous(this.mCurrentPackage.applicationInfo, BackupManagerService.OP_PENDING);
                        BackupManagerService backupManagerService = BackupManagerService.this;
                        StringBuilder append = new StringBuilder().append("agent bound; a? = ");
                        if (agent != null) {
                            z = BackupManagerService.DEBUG_SCHEDULING;
                        } else {
                            z = BackupManagerService.MORE_DEBUG;
                        }
                        backupManagerService.addBackupTrace(append.append(z).toString());
                        if (agent != null) {
                            this.mAgentBinder = agent;
                            this.mStatus = invokeAgentForBackup(request.packageName, agent, this.mTransport);
                        } else {
                            this.mStatus = -1003;
                        }
                    } catch (SecurityException ex) {
                        Slog.d(TAG, "error in bind/backup", ex);
                        this.mStatus = -1003;
                        BackupManagerService.this.addBackupTrace("agent SE");
                    }
                    BackupManagerService.this.mWakelock.setWorkSource(null);
                    if (this.mStatus != 0) {
                        nextState = BackupState.RUNNING_QUEUE;
                        this.mAgentBinder = null;
                        if (this.mStatus == -1003) {
                            BackupManagerService.this.dataChangedImpl(request.packageName);
                            this.mStatus = BackupManagerService.OP_PENDING;
                            if (this.mQueue.isEmpty()) {
                                nextState = BackupState.FINAL;
                            }
                        } else if (this.mStatus == -1004) {
                            this.mStatus = BackupManagerService.OP_PENDING;
                        } else {
                            revertAndEndBackup();
                            nextState = BackupState.FINAL;
                        }
                        executeNextState(nextState);
                        return;
                    }
                    BackupManagerService.this.addBackupTrace("expecting completion/timeout callback");
                }
            } catch (NameNotFoundException e) {
                Slog.d(TAG, "Package does not exist; skipping");
                BackupManagerService.this.addBackupTrace("no such package");
                this.mStatus = -1004;
                BackupManagerService.this.mWakelock.setWorkSource(null);
                if (this.mStatus != 0) {
                    nextState = BackupState.RUNNING_QUEUE;
                    this.mAgentBinder = null;
                    if (this.mStatus == -1003) {
                        BackupManagerService.this.dataChangedImpl(request.packageName);
                        this.mStatus = BackupManagerService.OP_PENDING;
                        if (this.mQueue.isEmpty()) {
                            nextState = BackupState.FINAL;
                        }
                    } else if (this.mStatus == -1004) {
                        this.mStatus = BackupManagerService.OP_PENDING;
                    } else {
                        revertAndEndBackup();
                        nextState = BackupState.FINAL;
                    }
                    executeNextState(nextState);
                    return;
                }
                BackupManagerService.this.addBackupTrace("expecting completion/timeout callback");
            } catch (Throwable th) {
                BackupManagerService.this.mWakelock.setWorkSource(null);
                if (this.mStatus != 0) {
                    nextState = BackupState.RUNNING_QUEUE;
                    this.mAgentBinder = null;
                    if (this.mStatus == -1003) {
                        BackupManagerService.this.dataChangedImpl(request.packageName);
                        this.mStatus = BackupManagerService.OP_PENDING;
                        if (this.mQueue.isEmpty()) {
                            nextState = BackupState.FINAL;
                        }
                    } else if (this.mStatus == -1004) {
                        this.mStatus = BackupManagerService.OP_PENDING;
                    } else {
                        revertAndEndBackup();
                        nextState = BackupState.FINAL;
                    }
                    executeNextState(nextState);
                } else {
                    BackupManagerService.this.addBackupTrace("expecting completion/timeout callback");
                }
            }
        }

        void finalizeBackup() {
            BackupManagerService.this.addBackupTrace("finishing");
            if (!(this.mJournal == null || this.mJournal.delete())) {
                Slog.e(TAG, "Unable to remove backup journal file " + this.mJournal);
            }
            if (BackupManagerService.this.mCurrentToken == 0 && this.mStatus == 0) {
                BackupManagerService.this.addBackupTrace("success; recording token");
                try {
                    BackupManagerService.this.mCurrentToken = this.mTransport.getCurrentRestoreSet();
                    BackupManagerService.this.writeRestoreTokens();
                } catch (RemoteException e) {
                    BackupManagerService.this.addBackupTrace("transport threw returning token");
                }
            }
            synchronized (BackupManagerService.this.mQueueLock) {
                BackupManagerService.this.mBackupRunning = BackupManagerService.MORE_DEBUG;
                if (this.mStatus == -1001) {
                    clearMetadata();
                    Slog.d(TAG, "Server requires init; rerunning");
                    BackupManagerService.this.addBackupTrace("init required; rerunning");
                    BackupManagerService.this.backupNow();
                }
            }
            BackupManagerService.this.clearBackupTrace();
            Slog.i(BackupManagerService.TAG, "Backup pass finished.");
            BackupManagerService.this.mWakelock.release();
        }

        void clearMetadata() {
            File pmState = new File(this.mStateDir, BackupManagerService.PACKAGE_MANAGER_SENTINEL);
            if (pmState.exists()) {
                pmState.delete();
            }
        }

        int invokeAgentForBackup(String packageName, IBackupAgent agent, IBackupTransport transport) {
            Slog.d(TAG, "invokeAgentForBackup on " + packageName);
            BackupManagerService.this.addBackupTrace("invoking " + packageName);
            this.mSavedStateName = new File(this.mStateDir, packageName);
            this.mBackupDataName = new File(BackupManagerService.this.mDataDir, packageName + ".data");
            this.mNewStateName = new File(this.mStateDir, packageName + ".new");
            this.mSavedState = null;
            this.mBackupData = null;
            this.mNewState = null;
            int token = BackupManagerService.this.generateToken();
            try {
                if (packageName.equals(BackupManagerService.PACKAGE_MANAGER_SENTINEL)) {
                    this.mCurrentPackage = new PackageInfo();
                    this.mCurrentPackage.packageName = packageName;
                }
                this.mSavedState = ParcelFileDescriptor.open(this.mSavedStateName, 402653184);
                this.mBackupData = ParcelFileDescriptor.open(this.mBackupDataName, 1006632960);
                if (!SELinux.restorecon(this.mBackupDataName)) {
                    Slog.e(TAG, "SELinux restorecon failed on " + this.mBackupDataName);
                }
                this.mNewState = ParcelFileDescriptor.open(this.mNewStateName, 1006632960);
                BackupManagerService.this.addBackupTrace("setting timeout");
                BackupManagerService.this.prepareOperationTimeout(token, BackupManagerService.TIMEOUT_RESTORE_FINISHED_INTERVAL, this);
                BackupManagerService.this.addBackupTrace("calling agent doBackup()");
                agent.doBackup(this.mSavedState, this.mBackupData, this.mNewState, token, BackupManagerService.this.mBackupManagerBinder);
                BackupManagerService.this.addBackupTrace("invoke success");
                return BackupManagerService.OP_PENDING;
            } catch (Exception e) {
                Slog.e(TAG, "Error invoking for backup on " + packageName);
                BackupManagerService.this.addBackupTrace("exception: " + e);
                Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                objArr[BackupManagerService.OP_PENDING] = packageName;
                objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = e.toString();
                EventLog.writeEvent(EventLogTags.BACKUP_AGENT_FAILURE, objArr);
                agentErrorCleanup();
                return -1003;
            }
        }

        public void failAgent(IBackupAgent agent, String message) {
            try {
                agent.fail(message);
            } catch (Exception e) {
                Slog.w(TAG, "Error conveying failure to " + this.mCurrentPackage.packageName);
            }
        }

        private String SHA1Checksum(byte[] input) {
            try {
                byte[] checksum = MessageDigest.getInstance("SHA-1").digest(input);
                StringBuffer sb = new StringBuffer(checksum.length * BackupManagerService.MSG_RUN_ADB_BACKUP);
                for (int i = BackupManagerService.OP_PENDING; i < checksum.length; i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                    sb.append(Integer.toHexString(checksum[i]));
                }
                return sb.toString();
            } catch (NoSuchAlgorithmException e) {
                Slog.e(TAG, "Unable to use SHA-1!");
                return "00";
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private void writeWidgetPayloadIfAppropriate(java.io.FileDescriptor r17, java.lang.String r18) throws java.io.IOException {
            /*
            r16 = this;
            r12 = 0;
            r0 = r18;
            r10 = com.android.server.AppWidgetBackupBridge.getWidgetState(r0, r12);
            r9 = new java.io.File;
            r0 = r16;
            r12 = r0.mStateDir;
            r13 = new java.lang.StringBuilder;
            r13.<init>();
            r0 = r18;
            r13 = r13.append(r0);
            r14 = "_widget";
            r13 = r13.append(r14);
            r13 = r13.toString();
            r9.<init>(r12, r13);
            r7 = r9.exists();
            if (r7 != 0) goto L_0x002e;
        L_0x002b:
            if (r10 != 0) goto L_0x002e;
        L_0x002d:
            return;
        L_0x002e:
            r4 = 0;
            if (r10 == 0) goto L_0x005d;
        L_0x0031:
            r0 = r16;
            r4 = r0.SHA1Checksum(r10);
            if (r7 == 0) goto L_0x005d;
        L_0x0039:
            r1 = new java.io.FileInputStream;
            r1.<init>(r9);
            r14 = 0;
            r3 = new java.io.DataInputStream;	 Catch:{ Throwable -> 0x0093, all -> 0x00a5 }
            r3.<init>(r1);	 Catch:{ Throwable -> 0x0093, all -> 0x00a5 }
            r13 = 0;
            r6 = r3.readUTF();	 Catch:{ Throwable -> 0x00a8 }
            if (r3 == 0) goto L_0x0050;
        L_0x004b:
            if (r13 == 0) goto L_0x00a1;
        L_0x004d:
            r3.close();	 Catch:{ Throwable -> 0x008e, all -> 0x00a5 }
        L_0x0050:
            if (r1 == 0) goto L_0x0057;
        L_0x0052:
            if (r14 == 0) goto L_0x00c1;
        L_0x0054:
            r1.close();	 Catch:{ Throwable -> 0x00bc }
        L_0x0057:
            r12 = java.util.Objects.equals(r4, r6);
            if (r12 != 0) goto L_0x002d;
        L_0x005d:
            r5 = new android.app.backup.BackupDataOutput;
            r0 = r17;
            r5.<init>(r0);
            if (r10 == 0) goto L_0x010f;
        L_0x0066:
            r2 = new java.io.FileOutputStream;
            r2.<init>(r9);
            r14 = 0;
            r8 = new java.io.DataOutputStream;	 Catch:{ Throwable -> 0x00d3, all -> 0x00e5 }
            r8.<init>(r2);	 Catch:{ Throwable -> 0x00d3, all -> 0x00e5 }
            r13 = 0;
            r8.writeUTF(r4);	 Catch:{ Throwable -> 0x00e8 }
            if (r8 == 0) goto L_0x007c;
        L_0x0077:
            if (r13 == 0) goto L_0x00e1;
        L_0x0079:
            r8.close();	 Catch:{ Throwable -> 0x00ce, all -> 0x00e5 }
        L_0x007c:
            if (r2 == 0) goto L_0x0083;
        L_0x007e:
            if (r14 == 0) goto L_0x0101;
        L_0x0080:
            r2.close();	 Catch:{ Throwable -> 0x00fc }
        L_0x0083:
            r12 = "\uffed\uffedwidget";
            r13 = r10.length;
            r5.writeEntityHeader(r12, r13);
            r12 = r10.length;
            r5.writeEntityData(r10, r12);
            goto L_0x002d;
        L_0x008e:
            r11 = move-exception;
            r13.addSuppressed(r11);	 Catch:{ Throwable -> 0x0093, all -> 0x00a5 }
            goto L_0x0050;
        L_0x0093:
            r12 = move-exception;
            throw r12;	 Catch:{ all -> 0x0095 }
        L_0x0095:
            r13 = move-exception;
            r15 = r13;
            r13 = r12;
            r12 = r15;
        L_0x0099:
            if (r1 == 0) goto L_0x00a0;
        L_0x009b:
            if (r13 == 0) goto L_0x00ca;
        L_0x009d:
            r1.close();	 Catch:{ Throwable -> 0x00c5 }
        L_0x00a0:
            throw r12;
        L_0x00a1:
            r3.close();	 Catch:{ Throwable -> 0x0093, all -> 0x00a5 }
            goto L_0x0050;
        L_0x00a5:
            r12 = move-exception;
            r13 = r14;
            goto L_0x0099;
        L_0x00a8:
            r13 = move-exception;
            throw r13;	 Catch:{ all -> 0x00aa }
        L_0x00aa:
            r12 = move-exception;
            if (r3 == 0) goto L_0x00b2;
        L_0x00ad:
            if (r13 == 0) goto L_0x00b8;
        L_0x00af:
            r3.close();	 Catch:{ Throwable -> 0x00b3, all -> 0x00a5 }
        L_0x00b2:
            throw r12;	 Catch:{ Throwable -> 0x0093, all -> 0x00a5 }
        L_0x00b3:
            r11 = move-exception;
            r13.addSuppressed(r11);	 Catch:{ Throwable -> 0x0093, all -> 0x00a5 }
            goto L_0x00b2;
        L_0x00b8:
            r3.close();	 Catch:{ Throwable -> 0x0093, all -> 0x00a5 }
            goto L_0x00b2;
        L_0x00bc:
            r11 = move-exception;
            r14.addSuppressed(r11);
            goto L_0x0057;
        L_0x00c1:
            r1.close();
            goto L_0x0057;
        L_0x00c5:
            r11 = move-exception;
            r13.addSuppressed(r11);
            goto L_0x00a0;
        L_0x00ca:
            r1.close();
            goto L_0x00a0;
        L_0x00ce:
            r11 = move-exception;
            r13.addSuppressed(r11);	 Catch:{ Throwable -> 0x00d3, all -> 0x00e5 }
            goto L_0x007c;
        L_0x00d3:
            r12 = move-exception;
            throw r12;	 Catch:{ all -> 0x00d5 }
        L_0x00d5:
            r13 = move-exception;
            r15 = r13;
            r13 = r12;
            r12 = r15;
        L_0x00d9:
            if (r2 == 0) goto L_0x00e0;
        L_0x00db:
            if (r13 == 0) goto L_0x010b;
        L_0x00dd:
            r2.close();	 Catch:{ Throwable -> 0x0106 }
        L_0x00e0:
            throw r12;
        L_0x00e1:
            r8.close();	 Catch:{ Throwable -> 0x00d3, all -> 0x00e5 }
            goto L_0x007c;
        L_0x00e5:
            r12 = move-exception;
            r13 = r14;
            goto L_0x00d9;
        L_0x00e8:
            r13 = move-exception;
            throw r13;	 Catch:{ all -> 0x00ea }
        L_0x00ea:
            r12 = move-exception;
            if (r8 == 0) goto L_0x00f2;
        L_0x00ed:
            if (r13 == 0) goto L_0x00f8;
        L_0x00ef:
            r8.close();	 Catch:{ Throwable -> 0x00f3, all -> 0x00e5 }
        L_0x00f2:
            throw r12;	 Catch:{ Throwable -> 0x00d3, all -> 0x00e5 }
        L_0x00f3:
            r11 = move-exception;
            r13.addSuppressed(r11);	 Catch:{ Throwable -> 0x00d3, all -> 0x00e5 }
            goto L_0x00f2;
        L_0x00f8:
            r8.close();	 Catch:{ Throwable -> 0x00d3, all -> 0x00e5 }
            goto L_0x00f2;
        L_0x00fc:
            r11 = move-exception;
            r14.addSuppressed(r11);
            goto L_0x0083;
        L_0x0101:
            r2.close();
            goto L_0x0083;
        L_0x0106:
            r11 = move-exception;
            r13.addSuppressed(r11);
            goto L_0x00e0;
        L_0x010b:
            r2.close();
            goto L_0x00e0;
        L_0x010f:
            r12 = "\uffed\uffedwidget";
            r13 = -1;
            r5.writeEntityHeader(r12, r13);
            r9.delete();
            goto L_0x002d;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.PerformBackupTask.writeWidgetPayloadIfAppropriate(java.io.FileDescriptor, java.lang.String):void");
        }

        public void operationComplete() {
            String pkgName = this.mCurrentPackage.packageName;
            long filepos = this.mBackupDataName.length();
            if (this.mBackupData == null) {
                failAgent(this.mAgentBinder, "Backup data was null: " + this.mBackupDataName);
                BackupManagerService.this.addBackupTrace("backup data was null: " + this.mBackupDataName);
                agentErrorCleanup();
                return;
            }
            BackupState nextState;
            FileDescriptor fd = this.mBackupData.getFileDescriptor();
            ParcelFileDescriptor readFd;
            try {
                if (this.mCurrentPackage.applicationInfo != null && (this.mCurrentPackage.applicationInfo.flags & BackupManagerService.SCHEDULE_FILE_VERSION) == 0) {
                    readFd = ParcelFileDescriptor.open(this.mBackupDataName, 268435456);
                    BackupDataInput in = new BackupDataInput(readFd.getFileDescriptor());
                    while (in.readNextHeader()) {
                        String key = in.getKey();
                        if (key == null || key.charAt(BackupManagerService.OP_PENDING) < '\uff00') {
                            in.skipEntityData();
                        } else {
                            failAgent(this.mAgentBinder, "Illegal backup key: " + key);
                            BackupManagerService.this.addBackupTrace("illegal key " + key + " from " + pkgName);
                            Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                            objArr[BackupManagerService.OP_PENDING] = pkgName;
                            objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = "bad key";
                            EventLog.writeEvent(EventLogTags.BACKUP_AGENT_FAILURE, objArr);
                            BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_TIMEOUT);
                            agentErrorCleanup();
                            if (readFd != null) {
                                readFd.close();
                                return;
                            }
                            return;
                        }
                    }
                    if (readFd != null) {
                        readFd.close();
                    }
                }
                writeWidgetPayloadIfAppropriate(fd, pkgName);
            } catch (IOException e) {
                Slog.w(TAG, "Unable to save widget state for " + pkgName);
                try {
                    Os.ftruncate(fd, filepos);
                } catch (ErrnoException e2) {
                    Slog.w(TAG, "Unable to roll back!");
                }
            } catch (Throwable th) {
                if (readFd != null) {
                    readFd.close();
                }
            }
            BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_TIMEOUT);
            clearAgentState();
            BackupManagerService.this.addBackupTrace("operation complete");
            ParcelFileDescriptor backupData = null;
            this.mStatus = BackupManagerService.OP_PENDING;
            try {
                int size = (int) this.mBackupDataName.length();
                if (size > 0) {
                    if (this.mStatus == 0) {
                        backupData = ParcelFileDescriptor.open(this.mBackupDataName, 268435456);
                        BackupManagerService.this.addBackupTrace("sending data to transport");
                        this.mStatus = this.mTransport.performBackup(this.mCurrentPackage, backupData);
                    }
                    BackupManagerService.this.addBackupTrace("data delivered: " + this.mStatus);
                    if (this.mStatus == 0) {
                        BackupManagerService.this.addBackupTrace("finishing op on transport");
                        this.mStatus = this.mTransport.finishBackup();
                        BackupManagerService.this.addBackupTrace("finished: " + this.mStatus);
                    } else if (this.mStatus == -1002) {
                        BackupManagerService.this.addBackupTrace("transport rejected package");
                    }
                } else {
                    Slog.i(TAG, "no backup data written; not calling transport");
                    BackupManagerService.this.addBackupTrace("no data to send");
                }
                if (this.mStatus == 0) {
                    this.mBackupDataName.delete();
                    this.mNewStateName.renameTo(this.mSavedStateName);
                    objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                    objArr[BackupManagerService.OP_PENDING] = pkgName;
                    objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = Integer.valueOf(size);
                    EventLog.writeEvent(EventLogTags.BACKUP_PACKAGE, objArr);
                    BackupManagerService.this.logBackupComplete(pkgName);
                } else if (this.mStatus == -1002) {
                    this.mBackupDataName.delete();
                    this.mNewStateName.delete();
                    EventLogTags.writeBackupAgentFailure(pkgName, "Transport rejected");
                } else {
                    EventLog.writeEvent(EventLogTags.BACKUP_TRANSPORT_FAILURE, pkgName);
                }
                if (backupData != null) {
                    try {
                        backupData.close();
                    } catch (IOException e3) {
                    }
                }
            } catch (Exception e4) {
                Slog.e(TAG, "Transport error backing up " + pkgName, e4);
                EventLog.writeEvent(EventLogTags.BACKUP_TRANSPORT_FAILURE, pkgName);
                this.mStatus = -1000;
                if (backupData != null) {
                    try {
                        backupData.close();
                    } catch (IOException e5) {
                    }
                }
            } catch (Throwable th2) {
                if (backupData != null) {
                    try {
                        backupData.close();
                    } catch (IOException e6) {
                    }
                }
            }
            if (this.mStatus == 0 || this.mStatus == -1002) {
                nextState = this.mQueue.isEmpty() ? BackupState.FINAL : BackupState.RUNNING_QUEUE;
            } else {
                revertAndEndBackup();
                nextState = BackupState.FINAL;
            }
            executeNextState(nextState);
        }

        public void handleTimeout() {
            Slog.e(TAG, "Timeout backing up " + this.mCurrentPackage.packageName);
            Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
            objArr[BackupManagerService.OP_PENDING] = this.mCurrentPackage.packageName;
            objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = "timeout";
            EventLog.writeEvent(EventLogTags.BACKUP_AGENT_FAILURE, objArr);
            BackupManagerService.this.addBackupTrace("timeout of " + this.mCurrentPackage.packageName);
            agentErrorCleanup();
            BackupManagerService.this.dataChangedImpl(this.mCurrentPackage.packageName);
        }

        void revertAndEndBackup() {
            BackupManagerService.this.addBackupTrace("transport error; reverting");
            Iterator i$ = this.mOriginalQueue.iterator();
            while (i$.hasNext()) {
                BackupManagerService.this.dataChangedImpl(((BackupRequest) i$.next()).packageName);
            }
            restartBackupAlarm();
        }

        void agentErrorCleanup() {
            this.mBackupDataName.delete();
            this.mNewStateName.delete();
            clearAgentState();
            executeNextState(this.mQueue.isEmpty() ? BackupState.FINAL : BackupState.RUNNING_QUEUE);
        }

        void clearAgentState() {
            try {
                if (this.mSavedState != null) {
                    this.mSavedState.close();
                }
            } catch (IOException e) {
            }
            try {
                if (this.mBackupData != null) {
                    this.mBackupData.close();
                }
            } catch (IOException e2) {
            }
            try {
                if (this.mNewState != null) {
                    this.mNewState.close();
                }
            } catch (IOException e3) {
            }
            synchronized (BackupManagerService.this.mCurrentOpLock) {
                BackupManagerService.this.mCurrentOperations.clear();
                this.mNewState = null;
                this.mBackupData = null;
                this.mSavedState = null;
            }
            if (this.mCurrentPackage.applicationInfo != null) {
                BackupManagerService.this.addBackupTrace("unbinding " + this.mCurrentPackage.packageName);
                try {
                    BackupManagerService.this.mActivityManager.unbindBackupAgent(this.mCurrentPackage.applicationInfo);
                } catch (RemoteException e4) {
                }
            }
        }

        void restartBackupAlarm() {
            BackupManagerService.this.addBackupTrace("setting backup trigger");
            synchronized (BackupManagerService.this.mQueueLock) {
                try {
                    BackupManagerService.this.startBackupAlarmsLocked(this.mTransport.requestBackupTime());
                } catch (RemoteException e) {
                }
            }
        }

        void executeNextState(BackupState nextState) {
            BackupManagerService.this.addBackupTrace("executeNextState => " + nextState);
            this.mCurrentState = nextState;
            BackupManagerService.this.mBackupHandler.sendMessage(BackupManagerService.this.mBackupHandler.obtainMessage(BackupManagerService.MSG_BACKUP_RESTORE_STEP, this));
        }
    }

    class PerformClearTask implements Runnable {
        PackageInfo mPackage;
        IBackupTransport mTransport;

        PerformClearTask(IBackupTransport transport, PackageInfo packageInfo) {
            this.mTransport = transport;
            this.mPackage = packageInfo;
        }

        public void run() {
            try {
                new File(new File(BackupManagerService.this.mBaseStateDir, this.mTransport.transportDirName()), this.mPackage.packageName).delete();
                this.mTransport.clearBackupData(this.mPackage);
            } catch (RemoteException e) {
            } catch (Exception e2) {
                Slog.e(BackupManagerService.TAG, "Transport threw attempting to clear data for " + this.mPackage);
            } finally {
                try {
                    this.mTransport.finishBackup();
                } catch (RemoteException e3) {
                }
                BackupManagerService.this.mWakelock.release();
            }
        }
    }

    class PerformFullTransportBackupTask extends FullBackupTask {
        static final String TAG = "PFTBT";
        FullBackupJob mJob;
        AtomicBoolean mKeepRunning;
        AtomicBoolean mLatch;
        ArrayList<PackageInfo> mPackages;
        boolean mUpdateSchedule;

        class SinglePackageBackupRunner implements Runnable {
            final AtomicBoolean mLatch;
            final ParcelFileDescriptor mOutput;
            final PackageInfo mTarget;

            SinglePackageBackupRunner(ParcelFileDescriptor output, PackageInfo target, AtomicBoolean latch) throws IOException {
                int oldfd = output.getFd();
                this.mOutput = ParcelFileDescriptor.dup(output.getFileDescriptor());
                this.mTarget = target;
                this.mLatch = latch;
            }

            public void run() {
                try {
                    new FullBackupEngine(new FileOutputStream(this.mOutput.getFileDescriptor()), this.mTarget.packageName, BackupManagerService.MORE_DEBUG).backupOnePackage(this.mTarget);
                    synchronized (this.mLatch) {
                        this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                        this.mLatch.notifyAll();
                    }
                    try {
                        this.mOutput.close();
                    } catch (IOException e) {
                        Slog.w(PerformFullTransportBackupTask.TAG, "Error closing transport pipe in runner");
                    }
                } catch (Exception e2) {
                    Slog.e(PerformFullTransportBackupTask.TAG, "Exception during full package backup of " + this.mTarget);
                    synchronized (this.mLatch) {
                    }
                    this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                    this.mLatch.notifyAll();
                    try {
                        this.mOutput.close();
                    } catch (IOException e3) {
                        Slog.w(PerformFullTransportBackupTask.TAG, "Error closing transport pipe in runner");
                    }
                } catch (Throwable th) {
                    synchronized (this.mLatch) {
                    }
                    this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                    this.mLatch.notifyAll();
                    try {
                        this.mOutput.close();
                    } catch (IOException e4) {
                        Slog.w(PerformFullTransportBackupTask.TAG, "Error closing transport pipe in runner");
                    }
                }
            }
        }

        PerformFullTransportBackupTask(IFullBackupRestoreObserver observer, String[] whichPackages, boolean updateSchedule, FullBackupJob runningJob, AtomicBoolean latch) {
            super(observer);
            this.mUpdateSchedule = updateSchedule;
            this.mLatch = latch;
            this.mKeepRunning = new AtomicBoolean(BackupManagerService.DEBUG_SCHEDULING);
            this.mJob = runningJob;
            this.mPackages = new ArrayList(whichPackages.length);
            String[] arr$ = whichPackages;
            int len$ = arr$.length;
            for (int i$ = BackupManagerService.OP_PENDING; i$ < len$; i$ += BackupManagerService.SCHEDULE_FILE_VERSION) {
                String pkg = arr$[i$];
                try {
                    PackageInfo info = BackupManagerService.this.mPackageManager.getPackageInfo(pkg, 64);
                    if (!((info.applicationInfo.flags & 32768) == 0 || pkg.equals(BackupManagerService.SHARED_BACKUP_AGENT_PACKAGE) || (info.applicationInfo.uid < BackupManagerService.PBKDF2_HASH_ROUNDS && info.applicationInfo.backupAgentName == null))) {
                        this.mPackages.add(info);
                    }
                } catch (NameNotFoundException e) {
                    Slog.i(TAG, "Requested package " + pkg + " not found; ignoring");
                }
            }
        }

        public void setRunning(boolean running) {
            this.mKeepRunning.set(running);
        }

        public void run() {
            ParcelFileDescriptor[] enginePipes = null;
            ParcelFileDescriptor[] transportPipes = null;
            try {
                if (BackupManagerService.this.mEnabled) {
                    if (BackupManagerService.this.mProvisioned) {
                        IBackupTransport transport = BackupManagerService.this.getTransport(BackupManagerService.this.mCurrentTransport);
                        if (transport == null) {
                            Slog.w(TAG, "Transport not present; full data backup not performed");
                            cleanUpPipes(null);
                            cleanUpPipes(null);
                            if (this.mJob != null) {
                                this.mJob.finishBackupPass();
                            }
                            synchronized (BackupManagerService.this.mQueueLock) {
                                BackupManagerService.this.mRunningFullBackupTask = null;
                            }
                            synchronized (this.mLatch) {
                                this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                this.mLatch.notifyAll();
                            }
                            if (this.mUpdateSchedule) {
                                BackupManagerService.this.scheduleNextFullBackupJob();
                                return;
                            }
                            return;
                        }
                        int N = this.mPackages.size();
                        for (int i = BackupManagerService.OP_PENDING; i < N; i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                            PackageInfo currentPackage = (PackageInfo) this.mPackages.get(i);
                            Slog.i(TAG, "Initiating full-data transport backup of " + currentPackage.packageName);
                            EventLog.writeEvent(EventLogTags.FULL_BACKUP_PACKAGE, currentPackage.packageName);
                            transportPipes = ParcelFileDescriptor.createPipe();
                            int result = transport.performFullBackup(currentPackage, transportPipes[BackupManagerService.OP_PENDING]);
                            if (result == 0) {
                                transportPipes[BackupManagerService.OP_PENDING].close();
                                transportPipes[BackupManagerService.OP_PENDING] = null;
                                enginePipes = ParcelFileDescriptor.createPipe();
                                AtomicBoolean atomicBoolean = new AtomicBoolean(BackupManagerService.MORE_DEBUG);
                                SinglePackageBackupRunner backupRunner = new SinglePackageBackupRunner(enginePipes[BackupManagerService.SCHEDULE_FILE_VERSION], currentPackage, atomicBoolean);
                                enginePipes[BackupManagerService.SCHEDULE_FILE_VERSION].close();
                                enginePipes[BackupManagerService.SCHEDULE_FILE_VERSION] = null;
                                new Thread(backupRunner, "package-backup-bridge").start();
                                FileInputStream in = new FileInputStream(enginePipes[BackupManagerService.OP_PENDING].getFileDescriptor());
                                FileOutputStream out = new FileOutputStream(transportPipes[BackupManagerService.SCHEDULE_FILE_VERSION].getFileDescriptor());
                                byte[] buffer = new byte[DumpState.DUMP_INSTALLS];
                                do {
                                    if (!this.mKeepRunning.get()) {
                                        Slog.i(TAG, "Full backup task told to stop");
                                        break;
                                    }
                                    int nRead = in.read(buffer);
                                    if (nRead > 0) {
                                        out.write(buffer, BackupManagerService.OP_PENDING, nRead);
                                        result = transport.sendBackupData(nRead);
                                    }
                                    if (nRead <= 0) {
                                        break;
                                    }
                                } while (result == 0);
                                if (this.mKeepRunning.get()) {
                                    int finishResult = transport.finishBackup();
                                    if (result == 0) {
                                        result = finishResult;
                                    }
                                } else {
                                    result = -1000;
                                    transport.cancelFullBackup();
                                }
                                if (result != 0) {
                                    StringBuilder append = new StringBuilder().append("Error ");
                                    Slog.e(TAG, r20.append(result).append(" backing up ").append(currentPackage.packageName).toString());
                                }
                            }
                            if (this.mUpdateSchedule) {
                                BackupManagerService.this.enqueueFullBackup(currentPackage.packageName, System.currentTimeMillis());
                            }
                            if (result == -1002) {
                                Slog.i(TAG, "Transport rejected backup of " + currentPackage.packageName + ", skipping");
                                Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                                objArr[BackupManagerService.OP_PENDING] = currentPackage.packageName;
                                objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = "transport rejected";
                                EventLog.writeEvent(EventLogTags.FULL_BACKUP_AGENT_FAILURE, objArr);
                            } else if (result != 0) {
                                Slog.i(TAG, "Transport failed; aborting backup: " + result);
                                EventLog.writeEvent(EventLogTags.FULL_BACKUP_TRANSPORT_FAILURE, new Object[BackupManagerService.OP_PENDING]);
                                cleanUpPipes(transportPipes);
                                cleanUpPipes(enginePipes);
                                if (this.mJob != null) {
                                    this.mJob.finishBackupPass();
                                }
                                synchronized (BackupManagerService.this.mQueueLock) {
                                    BackupManagerService.this.mRunningFullBackupTask = null;
                                }
                                synchronized (this.mLatch) {
                                    this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                                    this.mLatch.notifyAll();
                                }
                                if (this.mUpdateSchedule) {
                                    BackupManagerService.this.scheduleNextFullBackupJob();
                                    return;
                                }
                                return;
                            } else {
                                EventLog.writeEvent(EventLogTags.FULL_BACKUP_SUCCESS, currentPackage.packageName);
                                BackupManagerService.this.logBackupComplete(currentPackage.packageName);
                            }
                            cleanUpPipes(transportPipes);
                            cleanUpPipes(enginePipes);
                        }
                        Slog.i(TAG, "Full backup completed.");
                        cleanUpPipes(transportPipes);
                        cleanUpPipes(enginePipes);
                        if (this.mJob != null) {
                            this.mJob.finishBackupPass();
                        }
                        synchronized (BackupManagerService.this.mQueueLock) {
                            BackupManagerService.this.mRunningFullBackupTask = null;
                        }
                        synchronized (this.mLatch) {
                            this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                            this.mLatch.notifyAll();
                        }
                        if (this.mUpdateSchedule) {
                            BackupManagerService.this.scheduleNextFullBackupJob();
                            return;
                        }
                        return;
                    }
                }
                boolean z = BackupManagerService.this.mEnabled;
                Slog.i(TAG, "full backup requested but e=" + r0 + " p=" + BackupManagerService.this.mProvisioned + "; ignoring");
                this.mUpdateSchedule = BackupManagerService.MORE_DEBUG;
                cleanUpPipes(null);
                cleanUpPipes(null);
                if (this.mJob != null) {
                    this.mJob.finishBackupPass();
                }
                synchronized (BackupManagerService.this.mQueueLock) {
                    BackupManagerService.this.mRunningFullBackupTask = null;
                }
                synchronized (this.mLatch) {
                    this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                    this.mLatch.notifyAll();
                }
                if (this.mUpdateSchedule) {
                    BackupManagerService.this.scheduleNextFullBackupJob();
                }
            } catch (Exception e) {
                Slog.w(TAG, "Exception trying full transport backup", e);
                cleanUpPipes(transportPipes);
                cleanUpPipes(enginePipes);
                if (this.mJob != null) {
                    this.mJob.finishBackupPass();
                }
                synchronized (BackupManagerService.this.mQueueLock) {
                }
                BackupManagerService.this.mRunningFullBackupTask = null;
                synchronized (this.mLatch) {
                }
                this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                this.mLatch.notifyAll();
                if (this.mUpdateSchedule) {
                    BackupManagerService.this.scheduleNextFullBackupJob();
                }
            } catch (Throwable th) {
                cleanUpPipes(transportPipes);
                cleanUpPipes(enginePipes);
                if (this.mJob != null) {
                    this.mJob.finishBackupPass();
                }
                synchronized (BackupManagerService.this.mQueueLock) {
                }
                BackupManagerService.this.mRunningFullBackupTask = null;
                synchronized (this.mLatch) {
                }
                this.mLatch.set(BackupManagerService.DEBUG_SCHEDULING);
                this.mLatch.notifyAll();
                if (this.mUpdateSchedule) {
                    BackupManagerService.this.scheduleNextFullBackupJob();
                }
            }
        }

        void cleanUpPipes(ParcelFileDescriptor[] pipes) {
            if (pipes != null) {
                ParcelFileDescriptor fd;
                if (pipes[BackupManagerService.OP_PENDING] != null) {
                    fd = pipes[BackupManagerService.OP_PENDING];
                    pipes[BackupManagerService.OP_PENDING] = null;
                    try {
                        fd.close();
                    } catch (IOException e) {
                        Slog.w(TAG, "Unable to close pipe!");
                    }
                }
                if (pipes[BackupManagerService.SCHEDULE_FILE_VERSION] != null) {
                    fd = pipes[BackupManagerService.SCHEDULE_FILE_VERSION];
                    pipes[BackupManagerService.SCHEDULE_FILE_VERSION] = null;
                    try {
                        fd.close();
                    } catch (IOException e2) {
                        Slog.w(TAG, "Unable to close pipe!");
                    }
                }
            }
        }
    }

    class PerformInitializeTask implements Runnable {
        HashSet<String> mQueue;

        PerformInitializeTask(HashSet<String> transportNames) {
            this.mQueue = transportNames;
        }

        public void run() {
            try {
                Iterator i$ = this.mQueue.iterator();
                while (i$.hasNext()) {
                    String transportName = (String) i$.next();
                    IBackupTransport transport = BackupManagerService.this.getTransport(transportName);
                    if (transport == null) {
                        Slog.e(BackupManagerService.TAG, "Requested init for " + transportName + " but not found");
                    } else {
                        Slog.i(BackupManagerService.TAG, "Initializing (wiping) backup transport storage: " + transportName);
                        EventLog.writeEvent(EventLogTags.BACKUP_START, transport.transportDirName());
                        long startRealtime = SystemClock.elapsedRealtime();
                        int status = transport.initializeDevice();
                        if (status == 0) {
                            status = transport.finishBackup();
                        }
                        if (status == 0) {
                            Slog.i(BackupManagerService.TAG, "Device init successful");
                            int millis = (int) (SystemClock.elapsedRealtime() - startRealtime);
                            EventLog.writeEvent(EventLogTags.BACKUP_INITIALIZE, new Object[BackupManagerService.OP_PENDING]);
                            BackupManagerService.this.resetBackupState(new File(BackupManagerService.this.mBaseStateDir, transport.transportDirName()));
                            Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                            objArr[BackupManagerService.OP_PENDING] = Integer.valueOf(BackupManagerService.OP_PENDING);
                            objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = Integer.valueOf(millis);
                            EventLog.writeEvent(EventLogTags.BACKUP_SUCCESS, objArr);
                            synchronized (BackupManagerService.this.mQueueLock) {
                                BackupManagerService.this.recordInitPendingLocked(BackupManagerService.MORE_DEBUG, transportName);
                            }
                        } else {
                            Slog.e(BackupManagerService.TAG, "Transport error in initializeDevice()");
                            EventLog.writeEvent(EventLogTags.BACKUP_TRANSPORT_FAILURE, "(initialize)");
                            synchronized (BackupManagerService.this.mQueueLock) {
                                BackupManagerService.this.recordInitPendingLocked(BackupManagerService.DEBUG_SCHEDULING, transportName);
                            }
                            long delay = transport.requestBackupTime();
                            Slog.w(BackupManagerService.TAG, "init failed on " + transportName + " resched in " + delay);
                            BackupManagerService.this.mAlarmManager.set(BackupManagerService.OP_PENDING, System.currentTimeMillis() + delay, BackupManagerService.this.mRunInitIntent);
                        }
                    }
                }
                BackupManagerService.this.mWakelock.release();
            } catch (RemoteException e) {
                BackupManagerService.this.mWakelock.release();
            } catch (Exception e2) {
                try {
                    Slog.e(BackupManagerService.TAG, "Unexpected error performing init", e2);
                } finally {
                    BackupManagerService.this.mWakelock.release();
                }
            }
        }
    }

    class PerformUnifiedRestoreTask implements BackupRestoreTask {
        private List<PackageInfo> mAcceptSet;
        private IBackupAgent mAgent;
        ParcelFileDescriptor mBackupData;
        private File mBackupDataName;
        private int mCount;
        private PackageInfo mCurrentPackage;
        private boolean mFinished;
        private boolean mIsSystemRestore;
        ParcelFileDescriptor mNewState;
        private File mNewStateName;
        private IRestoreObserver mObserver;
        private PackageManagerBackupAgent mPmAgent;
        private int mPmToken;
        private RestoreDescription mRestoreDescription;
        private File mSavedStateName;
        private File mStageName;
        private long mStartRealtime;
        private UnifiedRestoreState mState;
        File mStateDir;
        private int mStatus;
        private PackageInfo mTargetPackage;
        private long mToken;
        private IBackupTransport mTransport;
        private byte[] mWidgetData;

        class EngineThread implements Runnable {
            FullRestoreEngine mEngine;
            FileInputStream mEngineStream;

            EngineThread(FullRestoreEngine engine, ParcelFileDescriptor engineSocket) {
                this.mEngine = engine;
                engine.setRunning(BackupManagerService.DEBUG_SCHEDULING);
                this.mEngineStream = new FileInputStream(engineSocket.getFileDescriptor());
            }

            public boolean isRunning() {
                return this.mEngine.isRunning();
            }

            public int waitForResult() {
                return this.mEngine.waitForResult();
            }

            public void run() {
                while (this.mEngine.isRunning()) {
                    this.mEngine.restoreOneFile(this.mEngineStream);
                }
            }
        }

        class StreamFeederThread extends RestoreEngine implements Runnable {
            final String TAG;
            FullRestoreEngine mEngine;
            ParcelFileDescriptor[] mEnginePipes;
            ParcelFileDescriptor[] mTransportPipes;

            public StreamFeederThread() throws IOException {
                super();
                this.TAG = "StreamFeederThread";
                this.mTransportPipes = ParcelFileDescriptor.createPipe();
                this.mEnginePipes = ParcelFileDescriptor.createPipe();
                setRunning(BackupManagerService.DEBUG_SCHEDULING);
            }

            public void run() {
                UnifiedRestoreState nextState = UnifiedRestoreState.RUNNING_QUEUE;
                int status = BackupManagerService.OP_PENDING;
                EventLog.writeEvent(EventLogTags.FULL_RESTORE_PACKAGE, PerformUnifiedRestoreTask.this.mCurrentPackage.packageName);
                this.mEngine = new FullRestoreEngine(null, PerformUnifiedRestoreTask.this.mCurrentPackage, BackupManagerService.MORE_DEBUG, BackupManagerService.MORE_DEBUG);
                EngineThread eThread = new EngineThread(this.mEngine, this.mEnginePipes[BackupManagerService.OP_PENDING]);
                ParcelFileDescriptor eWriteEnd = this.mEnginePipes[BackupManagerService.SCHEDULE_FILE_VERSION];
                ParcelFileDescriptor tReadEnd = this.mTransportPipes[BackupManagerService.OP_PENDING];
                ParcelFileDescriptor tWriteEnd = this.mTransportPipes[BackupManagerService.SCHEDULE_FILE_VERSION];
                int bufferSize = 32768;
                byte[] buffer = new byte[32768];
                FileOutputStream engineOut = new FileOutputStream(eWriteEnd.getFileDescriptor());
                FileInputStream fileInputStream = new FileInputStream(tReadEnd.getFileDescriptor());
                new Thread(eThread, "unified-restore-engine").start();
                while (status == 0) {
                    try {
                        int result = PerformUnifiedRestoreTask.this.mTransport.getNextFullRestoreDataChunk(tWriteEnd);
                        if (result > 0) {
                            if (result > bufferSize) {
                                bufferSize = result;
                                buffer = new byte[bufferSize];
                            }
                            int toCopy = result;
                            while (toCopy > 0) {
                                int n = fileInputStream.read(buffer, BackupManagerService.OP_PENDING, toCopy);
                                engineOut.write(buffer, BackupManagerService.OP_PENDING, n);
                                toCopy -= n;
                            }
                        } else if (result == BackupManagerService.OP_TIMEOUT) {
                            status = BackupManagerService.OP_PENDING;
                            break;
                        } else {
                            Slog.e("StreamFeederThread", "Error " + result + " streaming restore for " + PerformUnifiedRestoreTask.this.mCurrentPackage.packageName);
                            EventLog.writeEvent(EventLogTags.RESTORE_TRANSPORT_FAILURE, new Object[BackupManagerService.OP_PENDING]);
                            status = result;
                        }
                    } catch (IOException e) {
                        Slog.e("StreamFeederThread", "Unable to route data for restore");
                        Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                        objArr[BackupManagerService.OP_PENDING] = PerformUnifiedRestoreTask.this.mCurrentPackage.packageName;
                        objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = "I/O error on pipes";
                        EventLog.writeEvent(EventLogTags.RESTORE_AGENT_FAILURE, objArr);
                        status = -1003;
                        IoUtils.closeQuietly(this.mEnginePipes[BackupManagerService.SCHEDULE_FILE_VERSION]);
                        IoUtils.closeQuietly(this.mTransportPipes[BackupManagerService.OP_PENDING]);
                        IoUtils.closeQuietly(this.mTransportPipes[BackupManagerService.SCHEDULE_FILE_VERSION]);
                        eThread.waitForResult();
                        IoUtils.closeQuietly(this.mEnginePipes[BackupManagerService.OP_PENDING]);
                        if (-1003 == null) {
                            nextState = UnifiedRestoreState.RUNNING_QUEUE;
                        } else {
                            try {
                                PerformUnifiedRestoreTask.this.mTransport.abortFullRestore();
                            } catch (RemoteException e2) {
                                status = -1000;
                            }
                            BackupManagerService.this.clearApplicationDataSynchronous(PerformUnifiedRestoreTask.this.mCurrentPackage.packageName);
                            if (status == -1000) {
                                nextState = UnifiedRestoreState.FINAL;
                            } else {
                                nextState = UnifiedRestoreState.RUNNING_QUEUE;
                            }
                        }
                        PerformUnifiedRestoreTask.this.executeNextState(nextState);
                        setRunning(BackupManagerService.MORE_DEBUG);
                        return;
                    } catch (RemoteException e3) {
                        Slog.e("StreamFeederThread", "Transport failed during restore");
                        EventLog.writeEvent(EventLogTags.RESTORE_TRANSPORT_FAILURE, new Object[BackupManagerService.OP_PENDING]);
                        status = -1000;
                        IoUtils.closeQuietly(this.mEnginePipes[BackupManagerService.SCHEDULE_FILE_VERSION]);
                        IoUtils.closeQuietly(this.mTransportPipes[BackupManagerService.OP_PENDING]);
                        IoUtils.closeQuietly(this.mTransportPipes[BackupManagerService.SCHEDULE_FILE_VERSION]);
                        eThread.waitForResult();
                        IoUtils.closeQuietly(this.mEnginePipes[BackupManagerService.OP_PENDING]);
                        if (-1000 == null) {
                            nextState = UnifiedRestoreState.RUNNING_QUEUE;
                        } else {
                            try {
                                PerformUnifiedRestoreTask.this.mTransport.abortFullRestore();
                            } catch (RemoteException e4) {
                                status = -1000;
                            }
                            BackupManagerService.this.clearApplicationDataSynchronous(PerformUnifiedRestoreTask.this.mCurrentPackage.packageName);
                            if (status == -1000) {
                                nextState = UnifiedRestoreState.FINAL;
                            } else {
                                nextState = UnifiedRestoreState.RUNNING_QUEUE;
                            }
                        }
                        PerformUnifiedRestoreTask.this.executeNextState(nextState);
                        setRunning(BackupManagerService.MORE_DEBUG);
                        return;
                    } catch (Throwable th) {
                        IoUtils.closeQuietly(this.mEnginePipes[BackupManagerService.SCHEDULE_FILE_VERSION]);
                        IoUtils.closeQuietly(this.mTransportPipes[BackupManagerService.OP_PENDING]);
                        IoUtils.closeQuietly(this.mTransportPipes[BackupManagerService.SCHEDULE_FILE_VERSION]);
                        eThread.waitForResult();
                        IoUtils.closeQuietly(this.mEnginePipes[BackupManagerService.OP_PENDING]);
                        if (status == 0) {
                            nextState = UnifiedRestoreState.RUNNING_QUEUE;
                        } else {
                            try {
                                PerformUnifiedRestoreTask.this.mTransport.abortFullRestore();
                            } catch (RemoteException e5) {
                                status = -1000;
                            }
                            BackupManagerService.this.clearApplicationDataSynchronous(PerformUnifiedRestoreTask.this.mCurrentPackage.packageName);
                            if (status == -1000) {
                                nextState = UnifiedRestoreState.FINAL;
                            } else {
                                nextState = UnifiedRestoreState.RUNNING_QUEUE;
                            }
                        }
                        PerformUnifiedRestoreTask.this.executeNextState(nextState);
                        setRunning(BackupManagerService.MORE_DEBUG);
                    }
                }
                IoUtils.closeQuietly(this.mEnginePipes[BackupManagerService.SCHEDULE_FILE_VERSION]);
                IoUtils.closeQuietly(this.mTransportPipes[BackupManagerService.OP_PENDING]);
                IoUtils.closeQuietly(this.mTransportPipes[BackupManagerService.SCHEDULE_FILE_VERSION]);
                eThread.waitForResult();
                IoUtils.closeQuietly(this.mEnginePipes[BackupManagerService.OP_PENDING]);
                if (status == 0) {
                    nextState = UnifiedRestoreState.RUNNING_QUEUE;
                } else {
                    try {
                        PerformUnifiedRestoreTask.this.mTransport.abortFullRestore();
                    } catch (RemoteException e6) {
                        status = -1000;
                    }
                    BackupManagerService.this.clearApplicationDataSynchronous(PerformUnifiedRestoreTask.this.mCurrentPackage.packageName);
                    if (status == -1000) {
                        nextState = UnifiedRestoreState.FINAL;
                    } else {
                        nextState = UnifiedRestoreState.RUNNING_QUEUE;
                    }
                }
                PerformUnifiedRestoreTask.this.executeNextState(nextState);
                setRunning(BackupManagerService.MORE_DEBUG);
            }
        }

        PerformUnifiedRestoreTask(IBackupTransport transport, IRestoreObserver observer, long restoreSetToken, PackageInfo targetPackage, int pmToken, boolean isFullSystemRestore, String[] filterSet) {
            this.mState = UnifiedRestoreState.INITIAL;
            this.mStartRealtime = SystemClock.elapsedRealtime();
            this.mTransport = transport;
            this.mObserver = observer;
            this.mToken = restoreSetToken;
            this.mPmToken = pmToken;
            this.mTargetPackage = targetPackage;
            this.mIsSystemRestore = isFullSystemRestore;
            this.mFinished = BackupManagerService.MORE_DEBUG;
            if (targetPackage != null) {
                this.mAcceptSet = new ArrayList();
                this.mAcceptSet.add(targetPackage);
                return;
            }
            if (filterSet == null) {
                filterSet = packagesToNames(PackageManagerBackupAgent.getStorableApplications(BackupManagerService.this.mPackageManager));
                Slog.i(BackupManagerService.TAG, "Full restore; asking for " + filterSet.length + " apps");
            }
            this.mAcceptSet = new ArrayList(filterSet.length);
            boolean hasSystem = BackupManagerService.MORE_DEBUG;
            boolean hasSettings = BackupManagerService.MORE_DEBUG;
            for (int i = BackupManagerService.OP_PENDING; i < filterSet.length; i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                try {
                    PackageInfo info = BackupManagerService.this.mPackageManager.getPackageInfo(filterSet[i], BackupManagerService.OP_PENDING);
                    if ("android".equals(info.packageName)) {
                        hasSystem = BackupManagerService.DEBUG_SCHEDULING;
                    } else if (BackupManagerService.SETTINGS_PACKAGE.equals(info.packageName)) {
                        hasSettings = BackupManagerService.DEBUG_SCHEDULING;
                    } else if (BackupManagerService.appIsEligibleForBackup(info.applicationInfo)) {
                        this.mAcceptSet.add(info);
                    }
                } catch (NameNotFoundException e) {
                }
            }
            if (hasSystem) {
                try {
                    this.mAcceptSet.add(BackupManagerService.OP_PENDING, BackupManagerService.this.mPackageManager.getPackageInfo("android", BackupManagerService.OP_PENDING));
                } catch (NameNotFoundException e2) {
                }
            }
            if (hasSettings) {
                try {
                    this.mAcceptSet.add(BackupManagerService.this.mPackageManager.getPackageInfo(BackupManagerService.SETTINGS_PACKAGE, BackupManagerService.OP_PENDING));
                } catch (NameNotFoundException e3) {
                }
            }
        }

        private String[] packagesToNames(List<PackageInfo> apps) {
            int N = apps.size();
            String[] names = new String[N];
            for (int i = BackupManagerService.OP_PENDING; i < N; i += BackupManagerService.SCHEDULE_FILE_VERSION) {
                names[i] = ((PackageInfo) apps.get(i)).packageName;
            }
            return names;
        }

        public void execute() {
            switch (C01616.f5xf60b2fd4[this.mState.ordinal()]) {
                case BackupManagerService.SCHEDULE_FILE_VERSION /*1*/:
                    startRestore();
                case BackupManagerService.MSG_RUN_ADB_BACKUP /*2*/:
                    dispatchNextRestore();
                case BackupManagerService.MSG_RUN_RESTORE /*3*/:
                    restoreKeyValue();
                case BackupManagerService.MSG_RUN_CLEAR /*4*/:
                    restoreFull();
                case BackupManagerService.MSG_RUN_INITIALIZE /*5*/:
                    restoreFinished();
                case BackupManagerService.MSG_RUN_GET_RESTORE_SETS /*6*/:
                    if (this.mFinished) {
                        Slog.e(BackupManagerService.TAG, "Duplicate finish");
                    } else {
                        finalizeRestore();
                    }
                    this.mFinished = BackupManagerService.DEBUG_SCHEDULING;
                default:
            }
        }

        private void startRestore() {
            sendStartRestore(this.mAcceptSet.size());
            if (this.mIsSystemRestore) {
                AppWidgetBackupBridge.restoreStarting(BackupManagerService.OP_PENDING);
            }
            try {
                this.mStateDir = new File(BackupManagerService.this.mBaseStateDir, this.mTransport.transportDirName());
                PackageInfo pmPackage = new PackageInfo();
                pmPackage.packageName = BackupManagerService.PACKAGE_MANAGER_SENTINEL;
                this.mAcceptSet.add(BackupManagerService.OP_PENDING, pmPackage);
                this.mStatus = this.mTransport.startRestore(this.mToken, (PackageInfo[]) this.mAcceptSet.toArray(new PackageInfo[BackupManagerService.OP_PENDING]));
                if (this.mStatus != 0) {
                    Slog.e(BackupManagerService.TAG, "Transport error " + this.mStatus + "; no restore possible");
                    this.mStatus = -1000;
                    executeNextState(UnifiedRestoreState.FINAL);
                    return;
                }
                RestoreDescription desc = this.mTransport.nextRestorePackage();
                if (desc == null) {
                    Slog.e(BackupManagerService.TAG, "No restore metadata available; halting");
                    this.mStatus = -1000;
                    executeNextState(UnifiedRestoreState.FINAL);
                } else if (BackupManagerService.PACKAGE_MANAGER_SENTINEL.equals(desc.getPackageName())) {
                    this.mCurrentPackage = new PackageInfo();
                    this.mCurrentPackage.packageName = BackupManagerService.PACKAGE_MANAGER_SENTINEL;
                    this.mPmAgent = new PackageManagerBackupAgent(BackupManagerService.this.mPackageManager, null);
                    this.mAgent = IBackupAgent.Stub.asInterface(this.mPmAgent.onBind());
                    initiateOneRestore(this.mCurrentPackage, BackupManagerService.OP_PENDING);
                    if (!this.mPmAgent.hasMetadata()) {
                        Slog.e(BackupManagerService.TAG, "No restore metadata available, so not restoring");
                        Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                        objArr[BackupManagerService.OP_PENDING] = BackupManagerService.PACKAGE_MANAGER_SENTINEL;
                        objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = "Package manager restore metadata missing";
                        EventLog.writeEvent(EventLogTags.RESTORE_AGENT_FAILURE, objArr);
                        this.mStatus = -1000;
                        BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_BACKUP_RESTORE_STEP, this);
                        executeNextState(UnifiedRestoreState.FINAL);
                    }
                } else {
                    Slog.e(BackupManagerService.TAG, "Required metadata but got " + desc.getPackageName());
                    this.mStatus = -1000;
                    executeNextState(UnifiedRestoreState.FINAL);
                }
            } catch (RemoteException e) {
                Slog.e(BackupManagerService.TAG, "Unable to contact transport for restore");
                this.mStatus = -1000;
                BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_BACKUP_RESTORE_STEP, this);
                executeNextState(UnifiedRestoreState.FINAL);
            }
        }

        private void dispatchNextRestore() {
            UnifiedRestoreState nextState = UnifiedRestoreState.FINAL;
            try {
                this.mRestoreDescription = this.mTransport.nextRestorePackage();
                String pkgName = this.mRestoreDescription != null ? this.mRestoreDescription.getPackageName() : null;
                if (pkgName == null) {
                    Slog.e(BackupManagerService.TAG, "Failure getting next package name");
                    EventLog.writeEvent(EventLogTags.RESTORE_TRANSPORT_FAILURE, new Object[BackupManagerService.OP_PENDING]);
                    nextState = UnifiedRestoreState.FINAL;
                } else if (this.mRestoreDescription == RestoreDescription.NO_MORE_PACKAGES) {
                    Slog.v(BackupManagerService.TAG, "No more packages; finishing restore");
                    int millis = (int) (SystemClock.elapsedRealtime() - this.mStartRealtime);
                    r8 = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                    r8[BackupManagerService.OP_PENDING] = Integer.valueOf(this.mCount);
                    r8[BackupManagerService.SCHEDULE_FILE_VERSION] = Integer.valueOf(millis);
                    EventLog.writeEvent(EventLogTags.RESTORE_SUCCESS, r8);
                    executeNextState(UnifiedRestoreState.FINAL);
                } else {
                    Slog.i(BackupManagerService.TAG, "Next restore package: " + this.mRestoreDescription);
                    sendOnRestorePackage(pkgName);
                    Metadata metaInfo = this.mPmAgent.getRestoredMetadata(pkgName);
                    if (metaInfo == null) {
                        Slog.e(BackupManagerService.TAG, "No metadata for " + pkgName);
                        r8 = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                        r8[BackupManagerService.OP_PENDING] = pkgName;
                        r8[BackupManagerService.SCHEDULE_FILE_VERSION] = "Package metadata missing";
                        EventLog.writeEvent(EventLogTags.RESTORE_AGENT_FAILURE, r8);
                        executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
                        return;
                    }
                    try {
                        this.mCurrentPackage = BackupManagerService.this.mPackageManager.getPackageInfo(pkgName, 64);
                        if (metaInfo.versionCode > this.mCurrentPackage.versionCode) {
                            if ((this.mCurrentPackage.applicationInfo.flags & 131072) == 0) {
                                String message = "Version " + metaInfo.versionCode + " > installed version " + this.mCurrentPackage.versionCode;
                                Slog.w(BackupManagerService.TAG, "Package " + pkgName + ": " + message);
                                r8 = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                                r8[BackupManagerService.OP_PENDING] = pkgName;
                                r8[BackupManagerService.SCHEDULE_FILE_VERSION] = message;
                                EventLog.writeEvent(EventLogTags.RESTORE_AGENT_FAILURE, r8);
                                executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
                                return;
                            }
                            Slog.v(BackupManagerService.TAG, "Version " + metaInfo.versionCode + " > installed " + this.mCurrentPackage.versionCode + " but restoreAnyVersion");
                        }
                        Slog.v(BackupManagerService.TAG, "Package " + pkgName + " restore version [" + metaInfo.versionCode + "] is compatible with installed version [" + this.mCurrentPackage.versionCode + "]");
                        this.mWidgetData = null;
                        int type = this.mRestoreDescription.getDataType();
                        if (type == BackupManagerService.SCHEDULE_FILE_VERSION) {
                            nextState = UnifiedRestoreState.RESTORE_KEYVALUE;
                        } else if (type == BackupManagerService.MSG_RUN_ADB_BACKUP) {
                            nextState = UnifiedRestoreState.RESTORE_FULL;
                        } else {
                            Slog.e(BackupManagerService.TAG, "Unrecognized restore type " + type);
                            executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
                            return;
                        }
                        executeNextState(nextState);
                    } catch (NameNotFoundException e) {
                        Slog.e(BackupManagerService.TAG, "Package not present: " + pkgName);
                        r8 = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                        r8[BackupManagerService.OP_PENDING] = pkgName;
                        r8[BackupManagerService.SCHEDULE_FILE_VERSION] = "Package missing on device";
                        EventLog.writeEvent(EventLogTags.RESTORE_AGENT_FAILURE, r8);
                        executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
                    }
                }
            } catch (RemoteException e2) {
                Slog.e(BackupManagerService.TAG, "Can't get next target from transport; ending restore");
                EventLog.writeEvent(EventLogTags.RESTORE_TRANSPORT_FAILURE, new Object[BackupManagerService.OP_PENDING]);
                nextState = UnifiedRestoreState.FINAL;
            } finally {
                executeNextState(nextState);
            }
        }

        private void restoreKeyValue() {
            String packageName = this.mCurrentPackage.packageName;
            if (this.mCurrentPackage.applicationInfo.backupAgentName == null || "".equals(this.mCurrentPackage.applicationInfo.backupAgentName)) {
                Slog.i(BackupManagerService.TAG, "Data exists for package " + packageName + " but app has no agent; skipping");
                Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                objArr[BackupManagerService.OP_PENDING] = packageName;
                objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = "Package has no agent";
                EventLog.writeEvent(EventLogTags.RESTORE_AGENT_FAILURE, objArr);
                executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
                return;
            }
            Metadata metaInfo = this.mPmAgent.getRestoredMetadata(packageName);
            if (BackupManagerService.signaturesMatch(metaInfo.sigHashes, this.mCurrentPackage)) {
                this.mAgent = BackupManagerService.this.bindToAgentSynchronous(this.mCurrentPackage.applicationInfo, BackupManagerService.OP_PENDING);
                if (this.mAgent == null) {
                    Slog.w(BackupManagerService.TAG, "Can't find backup agent for " + packageName);
                    objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                    objArr[BackupManagerService.OP_PENDING] = packageName;
                    objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = "Restore agent missing";
                    EventLog.writeEvent(EventLogTags.RESTORE_AGENT_FAILURE, objArr);
                    executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
                    return;
                }
                try {
                    initiateOneRestore(this.mCurrentPackage, metaInfo.versionCode);
                    this.mCount += BackupManagerService.SCHEDULE_FILE_VERSION;
                    return;
                } catch (Exception e) {
                    Slog.e(BackupManagerService.TAG, "Error when attempting restore: " + e.toString());
                    keyValueAgentErrorCleanup();
                    executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
                    return;
                }
            }
            Slog.w(BackupManagerService.TAG, "Signature mismatch restoring " + packageName);
            objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
            objArr[BackupManagerService.OP_PENDING] = packageName;
            objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = "Signature mismatch";
            EventLog.writeEvent(EventLogTags.RESTORE_AGENT_FAILURE, objArr);
            executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
        }

        void initiateOneRestore(PackageInfo app, int appVersionCode) {
            File downloadFile;
            String packageName = app.packageName;
            Slog.d(BackupManagerService.TAG, "initiateOneRestore packageName=" + packageName);
            this.mBackupDataName = new File(BackupManagerService.this.mDataDir, packageName + ".restore");
            this.mStageName = new File(BackupManagerService.this.mDataDir, packageName + ".stage");
            this.mNewStateName = new File(this.mStateDir, packageName + ".new");
            this.mSavedStateName = new File(this.mStateDir, packageName);
            boolean staging = !packageName.equals("android") ? BackupManagerService.DEBUG_SCHEDULING : BackupManagerService.MORE_DEBUG;
            if (staging) {
                downloadFile = this.mStageName;
            } else {
                downloadFile = this.mBackupDataName;
            }
            int token = BackupManagerService.this.generateToken();
            try {
                ParcelFileDescriptor stage = ParcelFileDescriptor.open(downloadFile, 1006632960);
                if (!SELinux.restorecon(this.mBackupDataName)) {
                    Slog.e(BackupManagerService.TAG, "SElinux restorecon failed for " + downloadFile);
                }
                if (this.mTransport.getRestoreData(stage) != 0) {
                    Slog.e(BackupManagerService.TAG, "Error getting restore data for " + packageName);
                    EventLog.writeEvent(EventLogTags.RESTORE_TRANSPORT_FAILURE, new Object[BackupManagerService.OP_PENDING]);
                    stage.close();
                    downloadFile.delete();
                    executeNextState(UnifiedRestoreState.FINAL);
                    return;
                }
                if (staging) {
                    stage.close();
                    stage = ParcelFileDescriptor.open(downloadFile, 268435456);
                    this.mBackupData = ParcelFileDescriptor.open(this.mBackupDataName, 1006632960);
                    BackupDataInput in = new BackupDataInput(stage.getFileDescriptor());
                    BackupDataOutput out = new BackupDataOutput(this.mBackupData.getFileDescriptor());
                    byte[] buffer = new byte[DumpState.DUMP_INSTALLS];
                    while (in.readNextHeader()) {
                        String key = in.getKey();
                        int size = in.getDataSize();
                        if (key.equals(BackupManagerService.KEY_WIDGET_STATE)) {
                            Slog.i(BackupManagerService.TAG, "Restoring widget state for " + packageName);
                            this.mWidgetData = new byte[size];
                            in.readEntityData(this.mWidgetData, BackupManagerService.OP_PENDING, size);
                        } else {
                            if (size > buffer.length) {
                                buffer = new byte[size];
                            }
                            in.readEntityData(buffer, BackupManagerService.OP_PENDING, size);
                            out.writeEntityHeader(key, size);
                            out.writeEntityData(buffer, size);
                        }
                    }
                    this.mBackupData.close();
                }
                stage.close();
                this.mBackupData = ParcelFileDescriptor.open(this.mBackupDataName, 268435456);
                this.mNewState = ParcelFileDescriptor.open(this.mNewStateName, 1006632960);
                BackupManagerService.this.prepareOperationTimeout(token, BackupManagerService.TIMEOUT_RESTORE_INTERVAL, this);
                this.mAgent.doRestore(this.mBackupData, appVersionCode, this.mNewState, token, BackupManagerService.this.mBackupManagerBinder);
            } catch (Exception e) {
                Slog.e(BackupManagerService.TAG, "Unable to call app for restore: " + packageName, e);
                Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                objArr[BackupManagerService.OP_PENDING] = packageName;
                objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = e.toString();
                EventLog.writeEvent(EventLogTags.RESTORE_AGENT_FAILURE, objArr);
                keyValueAgentErrorCleanup();
                executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
            }
        }

        private void restoreFull() {
            try {
                StreamFeederThread feeder = new StreamFeederThread();
                Slog.i(BackupManagerService.TAG, "Spinning threads for stream restore of " + this.mCurrentPackage.packageName);
                new Thread(feeder, "unified-stream-feeder").start();
            } catch (IOException e) {
                Slog.e(BackupManagerService.TAG, "Unable to construct pipes for stream restore!");
                executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
            }
        }

        private void restoreFinished() {
            try {
                int token = BackupManagerService.this.generateToken();
                BackupManagerService.this.prepareOperationTimeout(token, BackupManagerService.TIMEOUT_RESTORE_FINISHED_INTERVAL, this);
                this.mAgent.doRestoreFinished(token, BackupManagerService.this.mBackupManagerBinder);
            } catch (Exception e) {
                Slog.e(BackupManagerService.TAG, "Unable to finalize restore of " + this.mCurrentPackage.packageName);
                executeNextState(UnifiedRestoreState.FINAL);
            }
        }

        private void finalizeRestore() {
            try {
                this.mTransport.finishRestore();
            } catch (Exception e) {
                Slog.e(BackupManagerService.TAG, "Error finishing restore", e);
            }
            if (this.mObserver != null) {
                try {
                    this.mObserver.restoreFinished(this.mStatus);
                } catch (RemoteException e2) {
                    Slog.d(BackupManagerService.TAG, "Restore observer died at restoreFinished");
                }
            }
            BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_RESTORE_TIMEOUT);
            if (this.mPmToken > 0) {
                try {
                    BackupManagerService.this.mPackageManagerBinder.finishPackageInstall(this.mPmToken);
                } catch (RemoteException e3) {
                }
            } else {
                BackupManagerService.this.mBackupHandler.sendEmptyMessageDelayed(BackupManagerService.MSG_RESTORE_TIMEOUT, BackupManagerService.TIMEOUT_RESTORE_INTERVAL);
            }
            AppWidgetBackupBridge.restoreFinished(BackupManagerService.OP_PENDING);
            if (this.mIsSystemRestore && this.mPmAgent != null) {
                BackupManagerService.this.mAncestralPackages = this.mPmAgent.getRestoredPackages();
                BackupManagerService.this.mAncestralToken = this.mToken;
                BackupManagerService.this.writeRestoreTokens();
            }
            Slog.i(BackupManagerService.TAG, "Restore complete.");
            BackupManagerService.this.mWakelock.release();
        }

        void keyValueAgentErrorCleanup() {
            BackupManagerService.this.clearApplicationDataSynchronous(this.mCurrentPackage.packageName);
            keyValueAgentCleanup();
        }

        void keyValueAgentCleanup() {
            this.mBackupDataName.delete();
            this.mStageName.delete();
            try {
                if (this.mBackupData != null) {
                    this.mBackupData.close();
                }
            } catch (IOException e) {
            }
            try {
                if (this.mNewState != null) {
                    this.mNewState.close();
                }
            } catch (IOException e2) {
            }
            this.mNewState = null;
            this.mBackupData = null;
            this.mNewStateName.delete();
            if (this.mCurrentPackage.applicationInfo != null) {
                try {
                    BackupManagerService.this.mActivityManager.unbindBackupAgent(this.mCurrentPackage.applicationInfo);
                    if (this.mTargetPackage == null && (this.mCurrentPackage.applicationInfo.flags & 65536) != 0) {
                        Slog.d(BackupManagerService.TAG, "Restore complete, killing host process of " + this.mCurrentPackage.applicationInfo.processName);
                        BackupManagerService.this.mActivityManager.killApplicationProcess(this.mCurrentPackage.applicationInfo.processName, this.mCurrentPackage.applicationInfo.uid);
                    }
                } catch (RemoteException e3) {
                }
            }
            BackupManagerService.this.mBackupHandler.removeMessages(BackupManagerService.MSG_TIMEOUT, this);
            synchronized (BackupManagerService.this.mCurrentOpLock) {
                BackupManagerService.this.mCurrentOperations.clear();
            }
        }

        public void operationComplete() {
            UnifiedRestoreState nextState;
            switch (C01616.f5xf60b2fd4[this.mState.ordinal()]) {
                case BackupManagerService.SCHEDULE_FILE_VERSION /*1*/:
                    nextState = UnifiedRestoreState.RUNNING_QUEUE;
                    break;
                case BackupManagerService.MSG_RUN_RESTORE /*3*/:
                case BackupManagerService.MSG_RUN_CLEAR /*4*/:
                    nextState = UnifiedRestoreState.RESTORE_FINISHED;
                    break;
                case BackupManagerService.MSG_RUN_INITIALIZE /*5*/:
                    int size = (int) this.mBackupDataName.length();
                    Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                    objArr[BackupManagerService.OP_PENDING] = this.mCurrentPackage.packageName;
                    objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = Integer.valueOf(size);
                    EventLog.writeEvent(EventLogTags.RESTORE_PACKAGE, objArr);
                    keyValueAgentCleanup();
                    if (this.mWidgetData != null) {
                        BackupManagerService.this.restoreWidgetData(this.mCurrentPackage.packageName, this.mWidgetData);
                    }
                    nextState = UnifiedRestoreState.RUNNING_QUEUE;
                    break;
                default:
                    Slog.e(BackupManagerService.TAG, "Unexpected restore callback into state " + this.mState);
                    keyValueAgentErrorCleanup();
                    nextState = UnifiedRestoreState.FINAL;
                    break;
            }
            executeNextState(nextState);
        }

        public void handleTimeout() {
            Slog.e(BackupManagerService.TAG, "Timeout restoring application " + this.mCurrentPackage.packageName);
            Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
            objArr[BackupManagerService.OP_PENDING] = this.mCurrentPackage.packageName;
            objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = "restore timeout";
            EventLog.writeEvent(EventLogTags.RESTORE_AGENT_FAILURE, objArr);
            keyValueAgentErrorCleanup();
            executeNextState(UnifiedRestoreState.RUNNING_QUEUE);
        }

        void executeNextState(UnifiedRestoreState nextState) {
            this.mState = nextState;
            BackupManagerService.this.mBackupHandler.sendMessage(BackupManagerService.this.mBackupHandler.obtainMessage(BackupManagerService.MSG_BACKUP_RESTORE_STEP, this));
        }

        void sendStartRestore(int numPackages) {
            if (this.mObserver != null) {
                try {
                    this.mObserver.restoreStarting(numPackages);
                } catch (RemoteException e) {
                    Slog.w(BackupManagerService.TAG, "Restore observer went away: startRestore");
                    this.mObserver = null;
                }
            }
        }

        void sendOnRestorePackage(String name) {
            if (this.mObserver != null && this.mObserver != null) {
                try {
                    this.mObserver.onUpdate(this.mCount, name);
                } catch (RemoteException e) {
                    Slog.d(BackupManagerService.TAG, "Restore observer died in onUpdate");
                    this.mObserver = null;
                }
            }
        }

        void sendEndRestore() {
            if (this.mObserver != null) {
                try {
                    this.mObserver.restoreFinished(this.mStatus);
                } catch (RemoteException e) {
                    Slog.w(BackupManagerService.TAG, "Restore observer went away: endRestore");
                    this.mObserver = null;
                }
            }
        }
    }

    class ProvisionedObserver extends ContentObserver {
        public ProvisionedObserver(Handler handler) {
            super(handler);
        }

        public void onChange(boolean selfChange) {
            boolean wasProvisioned = BackupManagerService.this.mProvisioned;
            boolean isProvisioned = BackupManagerService.this.deviceIsProvisioned();
            BackupManagerService backupManagerService = BackupManagerService.this;
            boolean z = (wasProvisioned || isProvisioned) ? BackupManagerService.DEBUG_SCHEDULING : BackupManagerService.MORE_DEBUG;
            backupManagerService.mProvisioned = z;
            synchronized (BackupManagerService.this.mQueueLock) {
                if (BackupManagerService.this.mProvisioned && !wasProvisioned && BackupManagerService.this.mEnabled) {
                    BackupManagerService.this.startBackupAlarmsLocked(BackupManagerService.FIRST_BACKUP_INTERVAL);
                    BackupManagerService.this.scheduleNextFullBackupJob();
                }
            }
        }
    }

    class RestoreGetSetsParams {
        public IRestoreObserver observer;
        public ActiveRestoreSession session;
        public IBackupTransport transport;

        RestoreGetSetsParams(IBackupTransport _transport, ActiveRestoreSession _session, IRestoreObserver _observer) {
            this.transport = _transport;
            this.session = _session;
            this.observer = _observer;
        }
    }

    class RestoreParams {
        public String dirName;
        public String[] filterSet;
        public boolean isSystemRestore;
        public IRestoreObserver observer;
        public PackageInfo pkgInfo;
        public int pmToken;
        public long token;
        public IBackupTransport transport;

        RestoreParams(IBackupTransport _transport, String _dirName, IRestoreObserver _obs, long _token, PackageInfo _pkg, int _pmToken) {
            this.transport = _transport;
            this.dirName = _dirName;
            this.observer = _obs;
            this.token = _token;
            this.pkgInfo = _pkg;
            this.pmToken = _pmToken;
            this.isSystemRestore = BackupManagerService.MORE_DEBUG;
            this.filterSet = null;
        }

        RestoreParams(IBackupTransport _transport, String _dirName, IRestoreObserver _obs, long _token) {
            this.transport = _transport;
            this.dirName = _dirName;
            this.observer = _obs;
            this.token = _token;
            this.pkgInfo = null;
            this.pmToken = BackupManagerService.OP_PENDING;
            this.isSystemRestore = BackupManagerService.DEBUG_SCHEDULING;
            this.filterSet = null;
        }

        RestoreParams(IBackupTransport _transport, String _dirName, IRestoreObserver _obs, long _token, String[] _filterSet, boolean _isSystemRestore) {
            this.transport = _transport;
            this.dirName = _dirName;
            this.observer = _obs;
            this.token = _token;
            this.pkgInfo = null;
            this.pmToken = BackupManagerService.OP_PENDING;
            this.isSystemRestore = _isSystemRestore;
            this.filterSet = _filterSet;
        }
    }

    enum RestorePolicy {
        IGNORE,
        ACCEPT,
        ACCEPT_IF_APK
    }

    private class RunBackupReceiver extends BroadcastReceiver {
        private RunBackupReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            if (BackupManagerService.RUN_BACKUP_ACTION.equals(intent.getAction())) {
                synchronized (BackupManagerService.this.mQueueLock) {
                    if (BackupManagerService.this.mPendingInits.size() > 0) {
                        Slog.v(BackupManagerService.TAG, "Init pending at scheduled backup");
                        try {
                            BackupManagerService.this.mAlarmManager.cancel(BackupManagerService.this.mRunInitIntent);
                            BackupManagerService.this.mRunInitIntent.send();
                        } catch (CanceledException e) {
                            Slog.e(BackupManagerService.TAG, "Run init intent cancelled");
                        }
                    } else if (!BackupManagerService.this.mEnabled || !BackupManagerService.this.mProvisioned) {
                        Slog.w(BackupManagerService.TAG, "Backup pass but e=" + BackupManagerService.this.mEnabled + " p=" + BackupManagerService.this.mProvisioned);
                    } else if (BackupManagerService.this.mBackupRunning) {
                        Slog.i(BackupManagerService.TAG, "Backup time but one already running");
                    } else {
                        Slog.v(BackupManagerService.TAG, "Running a backup pass");
                        BackupManagerService.this.mBackupRunning = BackupManagerService.DEBUG_SCHEDULING;
                        BackupManagerService.this.mWakelock.acquire();
                        BackupManagerService.this.mBackupHandler.sendMessage(BackupManagerService.this.mBackupHandler.obtainMessage(BackupManagerService.SCHEDULE_FILE_VERSION));
                    }
                }
            }
        }
    }

    private class RunInitializeReceiver extends BroadcastReceiver {
        private RunInitializeReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            if (BackupManagerService.RUN_INITIALIZE_ACTION.equals(intent.getAction())) {
                synchronized (BackupManagerService.this.mQueueLock) {
                    Slog.v(BackupManagerService.TAG, "Running a device init");
                    BackupManagerService.this.mWakelock.acquire();
                    BackupManagerService.this.mBackupHandler.sendMessage(BackupManagerService.this.mBackupHandler.obtainMessage(BackupManagerService.MSG_RUN_INITIALIZE));
                }
            }
        }
    }

    class TransportConnection implements ServiceConnection {
        ServiceInfo mTransport;

        public TransportConnection(ServiceInfo transport) {
            this.mTransport = transport;
        }

        public void onServiceConnected(ComponentName component, IBinder service) {
            Slog.v(BackupManagerService.TAG, "Connected to transport " + component);
            String name = component.flattenToShortString();
            try {
                IBackupTransport transport = IBackupTransport.Stub.asInterface(service);
                BackupManagerService.this.registerTransport(transport.name(), name, transport);
                Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                objArr[BackupManagerService.OP_PENDING] = name;
                objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = Integer.valueOf(BackupManagerService.SCHEDULE_FILE_VERSION);
                EventLog.writeEvent(EventLogTags.BACKUP_TRANSPORT_LIFECYCLE, objArr);
            } catch (RemoteException e) {
                Slog.e(BackupManagerService.TAG, "Unable to register transport " + component);
                Object[] objArr2 = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
                objArr2[BackupManagerService.OP_PENDING] = name;
                objArr2[BackupManagerService.SCHEDULE_FILE_VERSION] = Integer.valueOf(BackupManagerService.OP_PENDING);
                EventLog.writeEvent(EventLogTags.BACKUP_TRANSPORT_LIFECYCLE, objArr2);
            }
        }

        public void onServiceDisconnected(ComponentName component) {
            Slog.v(BackupManagerService.TAG, "Disconnected from transport " + component);
            String name = component.flattenToShortString();
            Object[] objArr = new Object[BackupManagerService.MSG_RUN_ADB_BACKUP];
            objArr[BackupManagerService.OP_PENDING] = name;
            objArr[BackupManagerService.SCHEDULE_FILE_VERSION] = Integer.valueOf(BackupManagerService.OP_PENDING);
            EventLog.writeEvent(EventLogTags.BACKUP_TRANSPORT_LIFECYCLE, objArr);
            BackupManagerService.this.registerTransport(null, name, null);
        }
    }

    enum UnifiedRestoreState {
        INITIAL,
        RUNNING_QUEUE,
        RESTORE_KEYVALUE,
        RESTORE_FULL,
        RESTORE_FINISHED,
        FINAL
    }

    public void fullBackup(android.os.ParcelFileDescriptor r18, boolean r19, boolean r20, boolean r21, boolean r22, boolean r23, boolean r24, boolean r25, java.lang.String[] r26) {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxRuntimeException: Can't find immediate dominator for block B:46:0x0119 in {3, 8, 10, 28, 31, 32, 34, 38, 41, 43, 45, 47, 48, 49, 50} preds:[]
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeDominators(BlockProcessor.java:129)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.processBlocksTree(BlockProcessor.java:48)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.rerun(BlockProcessor.java:44)
	at jadx.core.dex.visitors.blocksmaker.BlockFinallyExtract.visit(BlockFinallyExtract.java:57)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
        /*
        r17 = this;
        r0 = r17;
        r3 = r0.mContext;
        r4 = "android.permission.BACKUP";
        r5 = "fullBackup";
        r3.enforceCallingPermission(r4, r5);
        r13 = android.os.UserHandle.getCallingUserId();
        if (r13 == 0) goto L_0x0019;
    L_0x0011:
        r3 = new java.lang.IllegalStateException;
        r4 = "Backup supported only for the device owner";
        r3.<init>(r4);
        throw r3;
    L_0x0019:
        if (r23 != 0) goto L_0x002c;
    L_0x001b:
        if (r21 != 0) goto L_0x002c;
    L_0x001d:
        if (r26 == 0) goto L_0x0024;
    L_0x001f:
        r0 = r26;
        r3 = r0.length;
        if (r3 != 0) goto L_0x002c;
    L_0x0024:
        r3 = new java.lang.IllegalArgumentException;
        r4 = "Backup requested but neither shared nor any apps named";
        r3.<init>(r4);
        throw r3;
    L_0x002c:
        r14 = android.os.Binder.clearCallingIdentity();
        r3 = r17.deviceIsProvisioned();	 Catch:{ all -> 0x011c }
        if (r3 != 0) goto L_0x004b;	 Catch:{ all -> 0x011c }
    L_0x0036:
        r3 = "BackupManagerService";	 Catch:{ all -> 0x011c }
        r4 = "Full backup not supported before setup";	 Catch:{ all -> 0x011c }
        android.util.Slog.i(r3, r4);	 Catch:{ all -> 0x011c }
        r18.close();
    L_0x0040:
        android.os.Binder.restoreCallingIdentity(r14);
        r3 = "BackupManagerService";
        r4 = "Full backup processing complete.";
        android.util.Slog.d(r3, r4);
    L_0x004a:
        return;
    L_0x004b:
        r3 = "BackupManagerService";	 Catch:{ all -> 0x011c }
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x011c }
        r4.<init>();	 Catch:{ all -> 0x011c }
        r5 = "Requesting full backup: apks=";	 Catch:{ all -> 0x011c }
        r4 = r4.append(r5);	 Catch:{ all -> 0x011c }
        r0 = r19;	 Catch:{ all -> 0x011c }
        r4 = r4.append(r0);	 Catch:{ all -> 0x011c }
        r5 = " obb=";	 Catch:{ all -> 0x011c }
        r4 = r4.append(r5);	 Catch:{ all -> 0x011c }
        r0 = r20;	 Catch:{ all -> 0x011c }
        r4 = r4.append(r0);	 Catch:{ all -> 0x011c }
        r5 = " shared=";	 Catch:{ all -> 0x011c }
        r4 = r4.append(r5);	 Catch:{ all -> 0x011c }
        r0 = r21;	 Catch:{ all -> 0x011c }
        r4 = r4.append(r0);	 Catch:{ all -> 0x011c }
        r5 = " all=";	 Catch:{ all -> 0x011c }
        r4 = r4.append(r5);	 Catch:{ all -> 0x011c }
        r0 = r23;	 Catch:{ all -> 0x011c }
        r4 = r4.append(r0);	 Catch:{ all -> 0x011c }
        r5 = " system=";	 Catch:{ all -> 0x011c }
        r4 = r4.append(r5);	 Catch:{ all -> 0x011c }
        r0 = r24;	 Catch:{ all -> 0x011c }
        r4 = r4.append(r0);	 Catch:{ all -> 0x011c }
        r5 = " pkgs=";	 Catch:{ all -> 0x011c }
        r4 = r4.append(r5);	 Catch:{ all -> 0x011c }
        r0 = r26;	 Catch:{ all -> 0x011c }
        r4 = r4.append(r0);	 Catch:{ all -> 0x011c }
        r4 = r4.toString();	 Catch:{ all -> 0x011c }
        android.util.Slog.v(r3, r4);	 Catch:{ all -> 0x011c }
        r3 = "BackupManagerService";	 Catch:{ all -> 0x011c }
        r4 = "Beginning full backup...";	 Catch:{ all -> 0x011c }
        android.util.Slog.i(r3, r4);	 Catch:{ all -> 0x011c }
        r2 = new com.android.server.backup.BackupManagerService$FullBackupParams;	 Catch:{ all -> 0x011c }
        r3 = r17;	 Catch:{ all -> 0x011c }
        r4 = r18;	 Catch:{ all -> 0x011c }
        r5 = r19;	 Catch:{ all -> 0x011c }
        r6 = r20;	 Catch:{ all -> 0x011c }
        r7 = r21;	 Catch:{ all -> 0x011c }
        r8 = r22;	 Catch:{ all -> 0x011c }
        r9 = r23;	 Catch:{ all -> 0x011c }
        r10 = r24;	 Catch:{ all -> 0x011c }
        r11 = r25;	 Catch:{ all -> 0x011c }
        r12 = r26;	 Catch:{ all -> 0x011c }
        r2.<init>(r4, r5, r6, r7, r8, r9, r10, r11, r12);	 Catch:{ all -> 0x011c }
        r16 = r17.generateToken();	 Catch:{ all -> 0x011c }
        r0 = r17;	 Catch:{ all -> 0x011c }
        r4 = r0.mFullConfirmations;	 Catch:{ all -> 0x011c }
        monitor-enter(r4);	 Catch:{ all -> 0x011c }
        r0 = r17;	 Catch:{ all -> 0x011c }
        r3 = r0.mFullConfirmations;	 Catch:{ all -> 0x011c }
        r0 = r16;	 Catch:{ all -> 0x011c }
        r3.put(r0, r2);	 Catch:{ all -> 0x011c }
        monitor-exit(r4);	 Catch:{ all -> 0x011c }
        r3 = "BackupManagerService";	 Catch:{ all -> 0x011c }
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x011c }
        r4.<init>();	 Catch:{ all -> 0x011c }
        r5 = "Starting backup confirmation UI, token=";	 Catch:{ all -> 0x011c }
        r4 = r4.append(r5);	 Catch:{ all -> 0x011c }
        r0 = r16;	 Catch:{ all -> 0x011c }
        r4 = r4.append(r0);	 Catch:{ all -> 0x011c }
        r4 = r4.toString();	 Catch:{ all -> 0x011c }
        android.util.Slog.d(r3, r4);	 Catch:{ all -> 0x011c }
        r3 = "fullback";	 Catch:{ all -> 0x011c }
        r0 = r17;	 Catch:{ all -> 0x011c }
        r1 = r16;	 Catch:{ all -> 0x011c }
        r3 = r0.startConfirmationUi(r1, r3);	 Catch:{ all -> 0x011c }
        if (r3 != 0) goto L_0x012b;	 Catch:{ all -> 0x011c }
    L_0x00fa:
        r3 = "BackupManagerService";	 Catch:{ all -> 0x011c }
        r4 = "Unable to launch full backup confirmation";	 Catch:{ all -> 0x011c }
        android.util.Slog.e(r3, r4);	 Catch:{ all -> 0x011c }
        r0 = r17;	 Catch:{ all -> 0x011c }
        r3 = r0.mFullConfirmations;	 Catch:{ all -> 0x011c }
        r0 = r16;	 Catch:{ all -> 0x011c }
        r3.delete(r0);	 Catch:{ all -> 0x011c }
        r18.close();	 Catch:{ IOException -> 0x015c }
    L_0x010d:
        android.os.Binder.restoreCallingIdentity(r14);
        r3 = "BackupManagerService";
        r4 = "Full backup processing complete.";
        android.util.Slog.d(r3, r4);
        goto L_0x004a;
    L_0x0119:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x011c }
        throw r3;	 Catch:{ all -> 0x011c }
    L_0x011c:
        r3 = move-exception;
        r18.close();	 Catch:{ IOException -> 0x0160 }
    L_0x0120:
        android.os.Binder.restoreCallingIdentity(r14);
        r4 = "BackupManagerService";
        r5 = "Full backup processing complete.";
        android.util.Slog.d(r4, r5);
        throw r3;
    L_0x012b:
        r0 = r17;	 Catch:{ all -> 0x011c }
        r3 = r0.mPowerManager;	 Catch:{ all -> 0x011c }
        r4 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x011c }
        r6 = 0;	 Catch:{ all -> 0x011c }
        r3.userActivity(r4, r6);	 Catch:{ all -> 0x011c }
        r0 = r17;	 Catch:{ all -> 0x011c }
        r1 = r16;	 Catch:{ all -> 0x011c }
        r0.startConfirmationTimeout(r1, r2);	 Catch:{ all -> 0x011c }
        r3 = "BackupManagerService";	 Catch:{ all -> 0x011c }
        r4 = "Waiting for full backup completion...";	 Catch:{ all -> 0x011c }
        android.util.Slog.d(r3, r4);	 Catch:{ all -> 0x011c }
        r0 = r17;	 Catch:{ all -> 0x011c }
        r0.waitForCompletion(r2);	 Catch:{ all -> 0x011c }
        r18.close();	 Catch:{ IOException -> 0x015e }
    L_0x014d:
        android.os.Binder.restoreCallingIdentity(r14);
        r3 = "BackupManagerService";
        r4 = "Full backup processing complete.";
        android.util.Slog.d(r3, r4);
        goto L_0x004a;
    L_0x0159:
        r3 = move-exception;
        goto L_0x0040;
    L_0x015c:
        r3 = move-exception;
        goto L_0x010d;
    L_0x015e:
        r3 = move-exception;
        goto L_0x014d;
    L_0x0160:
        r4 = move-exception;
        goto L_0x0120;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.fullBackup(android.os.ParcelFileDescriptor, boolean, boolean, boolean, boolean, boolean, boolean, boolean, java.lang.String[]):void");
    }

    public void fullRestore(android.os.ParcelFileDescriptor r11) {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxRuntimeException: Can't find immediate dominator for block B:39:0x00a3 in {3, 21, 24, 25, 27, 29, 33, 36, 38, 40, 41, 42, 43} preds:[]
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeDominators(BlockProcessor.java:129)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.processBlocksTree(BlockProcessor.java:48)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.rerun(BlockProcessor.java:44)
	at jadx.core.dex.visitors.blocksmaker.BlockFinallyExtract.visit(BlockFinallyExtract.java:57)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
        /*
        r10 = this;
        r6 = r10.mContext;
        r7 = "android.permission.BACKUP";
        r8 = "fullRestore";
        r6.enforceCallingPermission(r7, r8);
        r0 = android.os.UserHandle.getCallingUserId();
        if (r0 == 0) goto L_0x0017;
    L_0x000f:
        r6 = new java.lang.IllegalStateException;
        r7 = "Restore supported only for the device owner";
        r6.<init>(r7);
        throw r6;
    L_0x0017:
        r2 = android.os.Binder.clearCallingIdentity();
        r6 = r10.deviceIsProvisioned();	 Catch:{ all -> 0x00a6 }
        if (r6 != 0) goto L_0x0050;	 Catch:{ all -> 0x00a6 }
    L_0x0021:
        r6 = "BackupManagerService";	 Catch:{ all -> 0x00a6 }
        r7 = "Full restore not permitted before setup";	 Catch:{ all -> 0x00a6 }
        android.util.Slog.i(r6, r7);	 Catch:{ all -> 0x00a6 }
        r11.close();
    L_0x002b:
        android.os.Binder.restoreCallingIdentity(r2);
        r6 = "BackupManagerService";
        r7 = "Full restore processing complete.";
        android.util.Slog.i(r6, r7);
    L_0x0035:
        return;
    L_0x0036:
        r1 = move-exception;
        r6 = "BackupManagerService";
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "Error trying to close fd after full restore: ";
        r7 = r7.append(r8);
        r7 = r7.append(r1);
        r7 = r7.toString();
        android.util.Slog.w(r6, r7);
        goto L_0x002b;
    L_0x0050:
        r6 = "BackupManagerService";	 Catch:{ all -> 0x00a6 }
        r7 = "Beginning full restore...";	 Catch:{ all -> 0x00a6 }
        android.util.Slog.i(r6, r7);	 Catch:{ all -> 0x00a6 }
        r4 = new com.android.server.backup.BackupManagerService$FullRestoreParams;	 Catch:{ all -> 0x00a6 }
        r4.<init>(r11);	 Catch:{ all -> 0x00a6 }
        r5 = r10.generateToken();	 Catch:{ all -> 0x00a6 }
        r7 = r10.mFullConfirmations;	 Catch:{ all -> 0x00a6 }
        monitor-enter(r7);	 Catch:{ all -> 0x00a6 }
        r6 = r10.mFullConfirmations;	 Catch:{ all -> 0x00a6 }
        r6.put(r5, r4);	 Catch:{ all -> 0x00a6 }
        monitor-exit(r7);	 Catch:{ all -> 0x00a6 }
        r6 = "BackupManagerService";	 Catch:{ all -> 0x00a6 }
        r7 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00a6 }
        r7.<init>();	 Catch:{ all -> 0x00a6 }
        r8 = "Starting restore confirmation UI, token=";	 Catch:{ all -> 0x00a6 }
        r7 = r7.append(r8);	 Catch:{ all -> 0x00a6 }
        r7 = r7.append(r5);	 Catch:{ all -> 0x00a6 }
        r7 = r7.toString();	 Catch:{ all -> 0x00a6 }
        android.util.Slog.d(r6, r7);	 Catch:{ all -> 0x00a6 }
        r6 = "fullrest";	 Catch:{ all -> 0x00a6 }
        r6 = r10.startConfirmationUi(r5, r6);	 Catch:{ all -> 0x00a6 }
        if (r6 != 0) goto L_0x00cf;	 Catch:{ all -> 0x00a6 }
    L_0x0089:
        r6 = "BackupManagerService";	 Catch:{ all -> 0x00a6 }
        r7 = "Unable to launch full restore confirmation";	 Catch:{ all -> 0x00a6 }
        android.util.Slog.e(r6, r7);	 Catch:{ all -> 0x00a6 }
        r6 = r10.mFullConfirmations;	 Catch:{ all -> 0x00a6 }
        r6.delete(r5);	 Catch:{ all -> 0x00a6 }
        r11.close();	 Catch:{ IOException -> 0x00b5 }
    L_0x0098:
        android.os.Binder.restoreCallingIdentity(r2);
        r6 = "BackupManagerService";
        r7 = "Full restore processing complete.";
        android.util.Slog.i(r6, r7);
        goto L_0x0035;
    L_0x00a3:
        r6 = move-exception;
        monitor-exit(r7);	 Catch:{ all -> 0x00a6 }
        throw r6;	 Catch:{ all -> 0x00a6 }
    L_0x00a6:
        r6 = move-exception;
        r11.close();	 Catch:{ IOException -> 0x010f }
    L_0x00aa:
        android.os.Binder.restoreCallingIdentity(r2);
        r7 = "BackupManagerService";
        r8 = "Full restore processing complete.";
        android.util.Slog.i(r7, r8);
        throw r6;
    L_0x00b5:
        r1 = move-exception;
        r6 = "BackupManagerService";
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "Error trying to close fd after full restore: ";
        r7 = r7.append(r8);
        r7 = r7.append(r1);
        r7 = r7.toString();
        android.util.Slog.w(r6, r7);
        goto L_0x0098;
    L_0x00cf:
        r6 = r10.mPowerManager;	 Catch:{ all -> 0x00a6 }
        r8 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x00a6 }
        r7 = 0;	 Catch:{ all -> 0x00a6 }
        r6.userActivity(r8, r7);	 Catch:{ all -> 0x00a6 }
        r10.startConfirmationTimeout(r5, r4);	 Catch:{ all -> 0x00a6 }
        r6 = "BackupManagerService";	 Catch:{ all -> 0x00a6 }
        r7 = "Waiting for full restore completion...";	 Catch:{ all -> 0x00a6 }
        android.util.Slog.d(r6, r7);	 Catch:{ all -> 0x00a6 }
        r10.waitForCompletion(r4);	 Catch:{ all -> 0x00a6 }
        r11.close();	 Catch:{ IOException -> 0x00f5 }
    L_0x00e9:
        android.os.Binder.restoreCallingIdentity(r2);
        r6 = "BackupManagerService";
        r7 = "Full restore processing complete.";
        android.util.Slog.i(r6, r7);
        goto L_0x0035;
    L_0x00f5:
        r1 = move-exception;
        r6 = "BackupManagerService";
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "Error trying to close fd after full restore: ";
        r7 = r7.append(r8);
        r7 = r7.append(r1);
        r7 = r7.toString();
        android.util.Slog.w(r6, r7);
        goto L_0x00e9;
    L_0x010f:
        r1 = move-exception;
        r7 = "BackupManagerService";
        r8 = new java.lang.StringBuilder;
        r8.<init>();
        r9 = "Error trying to close fd after full restore: ";
        r8 = r8.append(r9);
        r8 = r8.append(r1);
        r8 = r8.toString();
        android.util.Slog.w(r7, r8);
        goto L_0x00aa;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.fullRestore(android.os.ParcelFileDescriptor):void");
    }

    static Trampoline getInstance() {
        return sInstance;
    }

    int generateToken() {
        int token;
        do {
            synchronized (this.mTokenGenerator) {
                token = this.mTokenGenerator.nextInt();
            }
        } while (token < 0);
        return token;
    }

    public static boolean appIsEligibleForBackup(ApplicationInfo app) {
        if ((app.flags & 32768) == 0) {
            return MORE_DEBUG;
        }
        if ((app.uid >= PBKDF2_HASH_ROUNDS || app.backupAgentName != null) && !app.packageName.equals(SHARED_BACKUP_AGENT_PACKAGE)) {
            return DEBUG_SCHEDULING;
        }
        return MORE_DEBUG;
    }

    public static boolean appGetsFullBackup(PackageInfo pkg) {
        if (pkg.applicationInfo.backupAgentName == null || (pkg.applicationInfo.flags & 67108864) != 0) {
            return DEBUG_SCHEDULING;
        }
        return MORE_DEBUG;
    }

    void addBackupTrace(String s) {
        synchronized (this.mBackupTrace) {
            this.mBackupTrace.add(s);
        }
    }

    void clearBackupTrace() {
        synchronized (this.mBackupTrace) {
            this.mBackupTrace.clear();
        }
    }

    public BackupManagerService(Context context, Trampoline parent) {
        FileInputStream fin;
        DataInputStream in;
        FileInputStream fin2;
        DataInputStream in2;
        IntentFilter filter;
        Intent backupIntent;
        Intent initIntent;
        List<ResolveInfo> hosts;
        String str;
        StringBuilder append;
        String valueOf;
        int i;
        Throwable th;
        byte[] salt;
        this.mBackupParticipants = new SparseArray();
        this.mPendingBackups = new HashMap();
        this.mQueueLock = new Object();
        this.mAgentConnectLock = new Object();
        this.mBackupTrace = new ArrayList();
        this.mClearDataLock = new Object();
        this.mTransportServiceIntent = new Intent(SERVICE_ACTION_TRANSPORT_HOST);
        this.mTransportNames = new ArrayMap();
        this.mTransports = new ArrayMap();
        this.mTransportConnections = new ArrayMap();
        this.mCurrentOperations = new SparseArray();
        this.mCurrentOpLock = new Object();
        this.mTokenGenerator = new Random();
        this.mFullConfirmations = new SparseArray();
        this.mRng = new SecureRandom();
        this.mEverStoredApps = new HashSet();
        this.mAncestralPackages = null;
        this.mAncestralToken = 0;
        this.mCurrentToken = 0;
        this.mPendingInits = new HashSet();
        this.mFullBackupScheduleWriter = new C01561();
        this.mBroadcastReceiver = new C01572();
        this.mContext = context;
        this.mPackageManager = context.getPackageManager();
        this.mPackageManagerBinder = AppGlobals.getPackageManager();
        this.mActivityManager = ActivityManagerNative.getDefault();
        this.mAlarmManager = (AlarmManager) context.getSystemService("alarm");
        this.mPowerManager = (PowerManager) context.getSystemService("power");
        this.mMountService = IMountService.Stub.asInterface(ServiceManager.getService("mount"));
        this.mBackupManagerBinder = Trampoline.asInterface(parent.asBinder());
        this.mHandlerThread = new HandlerThread("backup", MSG_RUN_ADB_RESTORE);
        this.mHandlerThread.start();
        this.mBackupHandler = new BackupHandler(this.mHandlerThread.getLooper());
        ContentResolver resolver = context.getContentResolver();
        this.mProvisioned = Global.getInt(resolver, "device_provisioned", OP_PENDING) != 0 ? DEBUG_SCHEDULING : MORE_DEBUG;
        this.mAutoRestore = Secure.getInt(resolver, "backup_auto_restore", SCHEDULE_FILE_VERSION) != 0 ? DEBUG_SCHEDULING : MORE_DEBUG;
        this.mProvisionedObserver = new ProvisionedObserver(this.mBackupHandler);
        resolver.registerContentObserver(Global.getUriFor("device_provisioned"), MORE_DEBUG, this.mProvisionedObserver);
        this.mBaseStateDir = new File(Environment.getSecureDataDirectory(), "backup");
        this.mBaseStateDir.mkdirs();
        if (!SELinux.restorecon(this.mBaseStateDir)) {
            Slog.e(TAG, "SELinux restorecon failed on " + this.mBaseStateDir);
        }
        this.mDataDir = Environment.getDownloadCacheDirectory();
        this.mPasswordVersion = SCHEDULE_FILE_VERSION;
        this.mPasswordVersionFile = new File(this.mBaseStateDir, "pwversion");
        if (this.mPasswordVersionFile.exists()) {
            fin = null;
            in = null;
            try {
                fin2 = new FileInputStream(this.mPasswordVersionFile);
                try {
                    in2 = new DataInputStream(fin2);
                    try {
                        this.mPasswordVersion = in2.readInt();
                        if (in2 != null) {
                            try {
                                in2.close();
                            } catch (IOException e) {
                                Slog.w(TAG, "Error closing pw version files");
                            }
                        }
                        if (fin2 != null) {
                            fin2.close();
                        }
                    } catch (IOException e2) {
                        in = in2;
                        fin = fin2;
                        try {
                            Slog.e(TAG, "Unable to read backup pw version");
                            if (in != null) {
                                try {
                                    in.close();
                                } catch (IOException e3) {
                                    Slog.w(TAG, "Error closing pw version files");
                                }
                            }
                            if (fin != null) {
                                fin.close();
                            }
                            this.mPasswordHashFile = new File(this.mBaseStateDir, "pwhash");
                            if (this.mPasswordHashFile.exists()) {
                                fin = null;
                                in = null;
                                try {
                                    fin2 = new FileInputStream(this.mPasswordHashFile);
                                    try {
                                        in2 = new DataInputStream(new BufferedInputStream(fin2));
                                    } catch (IOException e4) {
                                        fin = fin2;
                                        try {
                                            Slog.e(TAG, "Unable to read saved backup pw hash");
                                            if (in != null) {
                                                try {
                                                    in.close();
                                                } catch (IOException e5) {
                                                    Slog.w(TAG, "Unable to close streams");
                                                }
                                            }
                                            if (fin != null) {
                                                fin.close();
                                            }
                                            this.mRunBackupReceiver = new RunBackupReceiver(null);
                                            filter = new IntentFilter();
                                            filter.addAction(RUN_BACKUP_ACTION);
                                            context.registerReceiver(this.mRunBackupReceiver, filter, "android.permission.BACKUP", null);
                                            this.mRunInitReceiver = new RunInitializeReceiver(null);
                                            filter = new IntentFilter();
                                            filter.addAction(RUN_INITIALIZE_ACTION);
                                            context.registerReceiver(this.mRunInitReceiver, filter, "android.permission.BACKUP", null);
                                            backupIntent = new Intent(RUN_BACKUP_ACTION);
                                            backupIntent.addFlags(1073741824);
                                            this.mRunBackupIntent = PendingIntent.getBroadcast(context, SCHEDULE_FILE_VERSION, backupIntent, OP_PENDING);
                                            initIntent = new Intent(RUN_INITIALIZE_ACTION);
                                            backupIntent.addFlags(1073741824);
                                            this.mRunInitIntent = PendingIntent.getBroadcast(context, MSG_RUN_INITIALIZE, initIntent, OP_PENDING);
                                            this.mJournalDir = new File(this.mBaseStateDir, "pending");
                                            this.mJournalDir.mkdirs();
                                            this.mJournal = null;
                                            this.mFullBackupScheduleFile = new File(this.mBaseStateDir, "fb-schedule");
                                            initPackageTracking();
                                            synchronized (this.mBackupParticipants) {
                                                addPackageParticipantsLocked(null);
                                            }
                                            this.mCurrentTransport = Secure.getString(context.getContentResolver(), "backup_transport");
                                            if ("".equals(this.mCurrentTransport)) {
                                                this.mCurrentTransport = null;
                                            }
                                            Slog.v(TAG, "Starting with transport " + this.mCurrentTransport);
                                            hosts = this.mPackageManager.queryIntentServicesAsUser(this.mTransportServiceIntent, OP_PENDING, OP_PENDING);
                                            str = TAG;
                                            append = new StringBuilder().append("Found transports: ");
                                            if (hosts == null) {
                                                valueOf = Integer.valueOf(hosts.size());
                                            } else {
                                                valueOf = "null";
                                            }
                                            Slog.v(str, append.append(valueOf).toString());
                                            if (hosts != null) {
                                                for (i = OP_PENDING; i < hosts.size(); i += SCHEDULE_FILE_VERSION) {
                                                    tryBindTransport(((ResolveInfo) hosts.get(i)).serviceInfo);
                                                }
                                            }
                                            parseLeftoverJournals();
                                            this.mWakelock = this.mPowerManager.newWakeLock(SCHEDULE_FILE_VERSION, "*backup*");
                                        } catch (Throwable th2) {
                                            th = th2;
                                            if (in != null) {
                                                try {
                                                    in.close();
                                                } catch (IOException e6) {
                                                    Slog.w(TAG, "Unable to close streams");
                                                    throw th;
                                                }
                                            }
                                            if (fin != null) {
                                                fin.close();
                                            }
                                            throw th;
                                        }
                                    } catch (Throwable th3) {
                                        th = th3;
                                        fin = fin2;
                                        if (in != null) {
                                            in.close();
                                        }
                                        if (fin != null) {
                                            fin.close();
                                        }
                                        throw th;
                                    }
                                    try {
                                        salt = new byte[in2.readInt()];
                                        in2.readFully(salt);
                                        this.mPasswordHash = in2.readUTF();
                                        this.mPasswordSalt = salt;
                                        if (in2 != null) {
                                            try {
                                                in2.close();
                                            } catch (IOException e7) {
                                                Slog.w(TAG, "Unable to close streams");
                                            }
                                        }
                                        if (fin2 != null) {
                                            fin2.close();
                                        }
                                    } catch (IOException e8) {
                                        in = in2;
                                        fin = fin2;
                                        Slog.e(TAG, "Unable to read saved backup pw hash");
                                        if (in != null) {
                                            in.close();
                                        }
                                        if (fin != null) {
                                            fin.close();
                                        }
                                        this.mRunBackupReceiver = new RunBackupReceiver(null);
                                        filter = new IntentFilter();
                                        filter.addAction(RUN_BACKUP_ACTION);
                                        context.registerReceiver(this.mRunBackupReceiver, filter, "android.permission.BACKUP", null);
                                        this.mRunInitReceiver = new RunInitializeReceiver(null);
                                        filter = new IntentFilter();
                                        filter.addAction(RUN_INITIALIZE_ACTION);
                                        context.registerReceiver(this.mRunInitReceiver, filter, "android.permission.BACKUP", null);
                                        backupIntent = new Intent(RUN_BACKUP_ACTION);
                                        backupIntent.addFlags(1073741824);
                                        this.mRunBackupIntent = PendingIntent.getBroadcast(context, SCHEDULE_FILE_VERSION, backupIntent, OP_PENDING);
                                        initIntent = new Intent(RUN_INITIALIZE_ACTION);
                                        backupIntent.addFlags(1073741824);
                                        this.mRunInitIntent = PendingIntent.getBroadcast(context, MSG_RUN_INITIALIZE, initIntent, OP_PENDING);
                                        this.mJournalDir = new File(this.mBaseStateDir, "pending");
                                        this.mJournalDir.mkdirs();
                                        this.mJournal = null;
                                        this.mFullBackupScheduleFile = new File(this.mBaseStateDir, "fb-schedule");
                                        initPackageTracking();
                                        synchronized (this.mBackupParticipants) {
                                            addPackageParticipantsLocked(null);
                                        }
                                        this.mCurrentTransport = Secure.getString(context.getContentResolver(), "backup_transport");
                                        if ("".equals(this.mCurrentTransport)) {
                                            this.mCurrentTransport = null;
                                        }
                                        Slog.v(TAG, "Starting with transport " + this.mCurrentTransport);
                                        hosts = this.mPackageManager.queryIntentServicesAsUser(this.mTransportServiceIntent, OP_PENDING, OP_PENDING);
                                        str = TAG;
                                        append = new StringBuilder().append("Found transports: ");
                                        if (hosts == null) {
                                            valueOf = "null";
                                        } else {
                                            valueOf = Integer.valueOf(hosts.size());
                                        }
                                        Slog.v(str, append.append(valueOf).toString());
                                        if (hosts != null) {
                                            for (i = OP_PENDING; i < hosts.size(); i += SCHEDULE_FILE_VERSION) {
                                                tryBindTransport(((ResolveInfo) hosts.get(i)).serviceInfo);
                                            }
                                        }
                                        parseLeftoverJournals();
                                        this.mWakelock = this.mPowerManager.newWakeLock(SCHEDULE_FILE_VERSION, "*backup*");
                                    } catch (Throwable th4) {
                                        th = th4;
                                        in = in2;
                                        fin = fin2;
                                        if (in != null) {
                                            in.close();
                                        }
                                        if (fin != null) {
                                            fin.close();
                                        }
                                        throw th;
                                    }
                                } catch (IOException e9) {
                                    Slog.e(TAG, "Unable to read saved backup pw hash");
                                    if (in != null) {
                                        in.close();
                                    }
                                    if (fin != null) {
                                        fin.close();
                                    }
                                    this.mRunBackupReceiver = new RunBackupReceiver(null);
                                    filter = new IntentFilter();
                                    filter.addAction(RUN_BACKUP_ACTION);
                                    context.registerReceiver(this.mRunBackupReceiver, filter, "android.permission.BACKUP", null);
                                    this.mRunInitReceiver = new RunInitializeReceiver(null);
                                    filter = new IntentFilter();
                                    filter.addAction(RUN_INITIALIZE_ACTION);
                                    context.registerReceiver(this.mRunInitReceiver, filter, "android.permission.BACKUP", null);
                                    backupIntent = new Intent(RUN_BACKUP_ACTION);
                                    backupIntent.addFlags(1073741824);
                                    this.mRunBackupIntent = PendingIntent.getBroadcast(context, SCHEDULE_FILE_VERSION, backupIntent, OP_PENDING);
                                    initIntent = new Intent(RUN_INITIALIZE_ACTION);
                                    backupIntent.addFlags(1073741824);
                                    this.mRunInitIntent = PendingIntent.getBroadcast(context, MSG_RUN_INITIALIZE, initIntent, OP_PENDING);
                                    this.mJournalDir = new File(this.mBaseStateDir, "pending");
                                    this.mJournalDir.mkdirs();
                                    this.mJournal = null;
                                    this.mFullBackupScheduleFile = new File(this.mBaseStateDir, "fb-schedule");
                                    initPackageTracking();
                                    synchronized (this.mBackupParticipants) {
                                        addPackageParticipantsLocked(null);
                                    }
                                    this.mCurrentTransport = Secure.getString(context.getContentResolver(), "backup_transport");
                                    if ("".equals(this.mCurrentTransport)) {
                                        this.mCurrentTransport = null;
                                    }
                                    Slog.v(TAG, "Starting with transport " + this.mCurrentTransport);
                                    hosts = this.mPackageManager.queryIntentServicesAsUser(this.mTransportServiceIntent, OP_PENDING, OP_PENDING);
                                    str = TAG;
                                    append = new StringBuilder().append("Found transports: ");
                                    if (hosts == null) {
                                        valueOf = "null";
                                    } else {
                                        valueOf = Integer.valueOf(hosts.size());
                                    }
                                    Slog.v(str, append.append(valueOf).toString());
                                    if (hosts != null) {
                                        for (i = OP_PENDING; i < hosts.size(); i += SCHEDULE_FILE_VERSION) {
                                            tryBindTransport(((ResolveInfo) hosts.get(i)).serviceInfo);
                                        }
                                    }
                                    parseLeftoverJournals();
                                    this.mWakelock = this.mPowerManager.newWakeLock(SCHEDULE_FILE_VERSION, "*backup*");
                                }
                            }
                            this.mRunBackupReceiver = new RunBackupReceiver(null);
                            filter = new IntentFilter();
                            filter.addAction(RUN_BACKUP_ACTION);
                            context.registerReceiver(this.mRunBackupReceiver, filter, "android.permission.BACKUP", null);
                            this.mRunInitReceiver = new RunInitializeReceiver(null);
                            filter = new IntentFilter();
                            filter.addAction(RUN_INITIALIZE_ACTION);
                            context.registerReceiver(this.mRunInitReceiver, filter, "android.permission.BACKUP", null);
                            backupIntent = new Intent(RUN_BACKUP_ACTION);
                            backupIntent.addFlags(1073741824);
                            this.mRunBackupIntent = PendingIntent.getBroadcast(context, SCHEDULE_FILE_VERSION, backupIntent, OP_PENDING);
                            initIntent = new Intent(RUN_INITIALIZE_ACTION);
                            backupIntent.addFlags(1073741824);
                            this.mRunInitIntent = PendingIntent.getBroadcast(context, MSG_RUN_INITIALIZE, initIntent, OP_PENDING);
                            this.mJournalDir = new File(this.mBaseStateDir, "pending");
                            this.mJournalDir.mkdirs();
                            this.mJournal = null;
                            this.mFullBackupScheduleFile = new File(this.mBaseStateDir, "fb-schedule");
                            initPackageTracking();
                            synchronized (this.mBackupParticipants) {
                                addPackageParticipantsLocked(null);
                            }
                            this.mCurrentTransport = Secure.getString(context.getContentResolver(), "backup_transport");
                            if ("".equals(this.mCurrentTransport)) {
                                this.mCurrentTransport = null;
                            }
                            Slog.v(TAG, "Starting with transport " + this.mCurrentTransport);
                            hosts = this.mPackageManager.queryIntentServicesAsUser(this.mTransportServiceIntent, OP_PENDING, OP_PENDING);
                            str = TAG;
                            append = new StringBuilder().append("Found transports: ");
                            if (hosts == null) {
                                valueOf = "null";
                            } else {
                                valueOf = Integer.valueOf(hosts.size());
                            }
                            Slog.v(str, append.append(valueOf).toString());
                            if (hosts != null) {
                                for (i = OP_PENDING; i < hosts.size(); i += SCHEDULE_FILE_VERSION) {
                                    tryBindTransport(((ResolveInfo) hosts.get(i)).serviceInfo);
                                }
                            }
                            parseLeftoverJournals();
                            this.mWakelock = this.mPowerManager.newWakeLock(SCHEDULE_FILE_VERSION, "*backup*");
                        } catch (Throwable th5) {
                            th = th5;
                            if (in != null) {
                                try {
                                    in.close();
                                } catch (IOException e10) {
                                    Slog.w(TAG, "Error closing pw version files");
                                    throw th;
                                }
                            }
                            if (fin != null) {
                                fin.close();
                            }
                            throw th;
                        }
                    } catch (Throwable th6) {
                        th = th6;
                        in = in2;
                        fin = fin2;
                        if (in != null) {
                            in.close();
                        }
                        if (fin != null) {
                            fin.close();
                        }
                        throw th;
                    }
                } catch (IOException e11) {
                    fin = fin2;
                    Slog.e(TAG, "Unable to read backup pw version");
                    if (in != null) {
                        in.close();
                    }
                    if (fin != null) {
                        fin.close();
                    }
                    this.mPasswordHashFile = new File(this.mBaseStateDir, "pwhash");
                    if (this.mPasswordHashFile.exists()) {
                        fin = null;
                        in = null;
                        fin2 = new FileInputStream(this.mPasswordHashFile);
                        in2 = new DataInputStream(new BufferedInputStream(fin2));
                        salt = new byte[in2.readInt()];
                        in2.readFully(salt);
                        this.mPasswordHash = in2.readUTF();
                        this.mPasswordSalt = salt;
                        if (in2 != null) {
                            in2.close();
                        }
                        if (fin2 != null) {
                            fin2.close();
                        }
                    }
                    this.mRunBackupReceiver = new RunBackupReceiver(null);
                    filter = new IntentFilter();
                    filter.addAction(RUN_BACKUP_ACTION);
                    context.registerReceiver(this.mRunBackupReceiver, filter, "android.permission.BACKUP", null);
                    this.mRunInitReceiver = new RunInitializeReceiver(null);
                    filter = new IntentFilter();
                    filter.addAction(RUN_INITIALIZE_ACTION);
                    context.registerReceiver(this.mRunInitReceiver, filter, "android.permission.BACKUP", null);
                    backupIntent = new Intent(RUN_BACKUP_ACTION);
                    backupIntent.addFlags(1073741824);
                    this.mRunBackupIntent = PendingIntent.getBroadcast(context, SCHEDULE_FILE_VERSION, backupIntent, OP_PENDING);
                    initIntent = new Intent(RUN_INITIALIZE_ACTION);
                    backupIntent.addFlags(1073741824);
                    this.mRunInitIntent = PendingIntent.getBroadcast(context, MSG_RUN_INITIALIZE, initIntent, OP_PENDING);
                    this.mJournalDir = new File(this.mBaseStateDir, "pending");
                    this.mJournalDir.mkdirs();
                    this.mJournal = null;
                    this.mFullBackupScheduleFile = new File(this.mBaseStateDir, "fb-schedule");
                    initPackageTracking();
                    synchronized (this.mBackupParticipants) {
                        addPackageParticipantsLocked(null);
                    }
                    this.mCurrentTransport = Secure.getString(context.getContentResolver(), "backup_transport");
                    if ("".equals(this.mCurrentTransport)) {
                        this.mCurrentTransport = null;
                    }
                    Slog.v(TAG, "Starting with transport " + this.mCurrentTransport);
                    hosts = this.mPackageManager.queryIntentServicesAsUser(this.mTransportServiceIntent, OP_PENDING, OP_PENDING);
                    str = TAG;
                    append = new StringBuilder().append("Found transports: ");
                    if (hosts == null) {
                        valueOf = Integer.valueOf(hosts.size());
                    } else {
                        valueOf = "null";
                    }
                    Slog.v(str, append.append(valueOf).toString());
                    if (hosts != null) {
                        for (i = OP_PENDING; i < hosts.size(); i += SCHEDULE_FILE_VERSION) {
                            tryBindTransport(((ResolveInfo) hosts.get(i)).serviceInfo);
                        }
                    }
                    parseLeftoverJournals();
                    this.mWakelock = this.mPowerManager.newWakeLock(SCHEDULE_FILE_VERSION, "*backup*");
                } catch (Throwable th7) {
                    th = th7;
                    fin = fin2;
                    if (in != null) {
                        in.close();
                    }
                    if (fin != null) {
                        fin.close();
                    }
                    throw th;
                }
            } catch (IOException e12) {
                Slog.e(TAG, "Unable to read backup pw version");
                if (in != null) {
                    in.close();
                }
                if (fin != null) {
                    fin.close();
                }
                this.mPasswordHashFile = new File(this.mBaseStateDir, "pwhash");
                if (this.mPasswordHashFile.exists()) {
                    fin = null;
                    in = null;
                    fin2 = new FileInputStream(this.mPasswordHashFile);
                    in2 = new DataInputStream(new BufferedInputStream(fin2));
                    salt = new byte[in2.readInt()];
                    in2.readFully(salt);
                    this.mPasswordHash = in2.readUTF();
                    this.mPasswordSalt = salt;
                    if (in2 != null) {
                        in2.close();
                    }
                    if (fin2 != null) {
                        fin2.close();
                    }
                }
                this.mRunBackupReceiver = new RunBackupReceiver(null);
                filter = new IntentFilter();
                filter.addAction(RUN_BACKUP_ACTION);
                context.registerReceiver(this.mRunBackupReceiver, filter, "android.permission.BACKUP", null);
                this.mRunInitReceiver = new RunInitializeReceiver(null);
                filter = new IntentFilter();
                filter.addAction(RUN_INITIALIZE_ACTION);
                context.registerReceiver(this.mRunInitReceiver, filter, "android.permission.BACKUP", null);
                backupIntent = new Intent(RUN_BACKUP_ACTION);
                backupIntent.addFlags(1073741824);
                this.mRunBackupIntent = PendingIntent.getBroadcast(context, SCHEDULE_FILE_VERSION, backupIntent, OP_PENDING);
                initIntent = new Intent(RUN_INITIALIZE_ACTION);
                backupIntent.addFlags(1073741824);
                this.mRunInitIntent = PendingIntent.getBroadcast(context, MSG_RUN_INITIALIZE, initIntent, OP_PENDING);
                this.mJournalDir = new File(this.mBaseStateDir, "pending");
                this.mJournalDir.mkdirs();
                this.mJournal = null;
                this.mFullBackupScheduleFile = new File(this.mBaseStateDir, "fb-schedule");
                initPackageTracking();
                synchronized (this.mBackupParticipants) {
                    addPackageParticipantsLocked(null);
                }
                this.mCurrentTransport = Secure.getString(context.getContentResolver(), "backup_transport");
                if ("".equals(this.mCurrentTransport)) {
                    this.mCurrentTransport = null;
                }
                Slog.v(TAG, "Starting with transport " + this.mCurrentTransport);
                hosts = this.mPackageManager.queryIntentServicesAsUser(this.mTransportServiceIntent, OP_PENDING, OP_PENDING);
                str = TAG;
                append = new StringBuilder().append("Found transports: ");
                if (hosts == null) {
                    valueOf = Integer.valueOf(hosts.size());
                } else {
                    valueOf = "null";
                }
                Slog.v(str, append.append(valueOf).toString());
                if (hosts != null) {
                    for (i = OP_PENDING; i < hosts.size(); i += SCHEDULE_FILE_VERSION) {
                        tryBindTransport(((ResolveInfo) hosts.get(i)).serviceInfo);
                    }
                }
                parseLeftoverJournals();
                this.mWakelock = this.mPowerManager.newWakeLock(SCHEDULE_FILE_VERSION, "*backup*");
            }
        }
        this.mPasswordHashFile = new File(this.mBaseStateDir, "pwhash");
        if (this.mPasswordHashFile.exists()) {
            fin = null;
            in = null;
            fin2 = new FileInputStream(this.mPasswordHashFile);
            in2 = new DataInputStream(new BufferedInputStream(fin2));
            salt = new byte[in2.readInt()];
            in2.readFully(salt);
            this.mPasswordHash = in2.readUTF();
            this.mPasswordSalt = salt;
            if (in2 != null) {
                in2.close();
            }
            if (fin2 != null) {
                fin2.close();
            }
        }
        this.mRunBackupReceiver = new RunBackupReceiver(null);
        filter = new IntentFilter();
        filter.addAction(RUN_BACKUP_ACTION);
        context.registerReceiver(this.mRunBackupReceiver, filter, "android.permission.BACKUP", null);
        this.mRunInitReceiver = new RunInitializeReceiver(null);
        filter = new IntentFilter();
        filter.addAction(RUN_INITIALIZE_ACTION);
        context.registerReceiver(this.mRunInitReceiver, filter, "android.permission.BACKUP", null);
        backupIntent = new Intent(RUN_BACKUP_ACTION);
        backupIntent.addFlags(1073741824);
        this.mRunBackupIntent = PendingIntent.getBroadcast(context, SCHEDULE_FILE_VERSION, backupIntent, OP_PENDING);
        initIntent = new Intent(RUN_INITIALIZE_ACTION);
        backupIntent.addFlags(1073741824);
        this.mRunInitIntent = PendingIntent.getBroadcast(context, MSG_RUN_INITIALIZE, initIntent, OP_PENDING);
        this.mJournalDir = new File(this.mBaseStateDir, "pending");
        this.mJournalDir.mkdirs();
        this.mJournal = null;
        this.mFullBackupScheduleFile = new File(this.mBaseStateDir, "fb-schedule");
        initPackageTracking();
        synchronized (this.mBackupParticipants) {
            addPackageParticipantsLocked(null);
        }
        this.mCurrentTransport = Secure.getString(context.getContentResolver(), "backup_transport");
        if ("".equals(this.mCurrentTransport)) {
            this.mCurrentTransport = null;
        }
        Slog.v(TAG, "Starting with transport " + this.mCurrentTransport);
        hosts = this.mPackageManager.queryIntentServicesAsUser(this.mTransportServiceIntent, OP_PENDING, OP_PENDING);
        str = TAG;
        append = new StringBuilder().append("Found transports: ");
        if (hosts == null) {
            valueOf = "null";
        } else {
            valueOf = Integer.valueOf(hosts.size());
        }
        Slog.v(str, append.append(valueOf).toString());
        if (hosts != null) {
            for (i = OP_PENDING; i < hosts.size(); i += SCHEDULE_FILE_VERSION) {
                tryBindTransport(((ResolveInfo) hosts.get(i)).serviceInfo);
            }
        }
        parseLeftoverJournals();
        this.mWakelock = this.mPowerManager.newWakeLock(SCHEDULE_FILE_VERSION, "*backup*");
    }

    private void initPackageTracking() {
        RandomAccessFile randomAccessFile;
        IOException e;
        StringBuilder append;
        IntentFilter filter;
        IntentFilter sdFilter;
        Throwable th;
        this.mTokenFile = new File(this.mBaseStateDir, "ancestral");
        try {
            randomAccessFile = new RandomAccessFile(this.mTokenFile, "r");
            if (randomAccessFile.readInt() == SCHEDULE_FILE_VERSION) {
                this.mAncestralToken = randomAccessFile.readLong();
                this.mCurrentToken = randomAccessFile.readLong();
                int numPackages = randomAccessFile.readInt();
                if (numPackages >= 0) {
                    this.mAncestralPackages = new HashSet();
                    for (int i = OP_PENDING; i < numPackages; i += SCHEDULE_FILE_VERSION) {
                        String pkgName = randomAccessFile.readUTF();
                        this.mAncestralPackages.add(pkgName);
                    }
                }
            }
            randomAccessFile.close();
        } catch (FileNotFoundException e2) {
            Slog.v(TAG, "No ancestral data");
        } catch (IOException e3) {
            Slog.w(TAG, "Unable to read token file", e3);
        }
        this.mEverStored = new File(this.mBaseStateDir, "processed");
        File file = new File(this.mBaseStateDir, "processed.new");
        if (file.exists()) {
            file.delete();
        }
        if (this.mEverStored.exists()) {
            RandomAccessFile temp = null;
            RandomAccessFile in = null;
            try {
                randomAccessFile = new RandomAccessFile(file, "rws");
            } catch (EOFException e4) {
                try {
                    if (!file.renameTo(this.mEverStored)) {
                        append = new StringBuilder().append("Error renaming ");
                        Slog.e(TAG, r21.append(file).append(" to ").append(this.mEverStored).toString());
                    }
                    if (temp != null) {
                        try {
                            temp.close();
                        } catch (IOException e5) {
                        }
                    }
                    if (in != null) {
                        try {
                            in.close();
                        } catch (IOException e6) {
                        }
                    }
                    this.mFullBackupQueue = readFullBackupSchedule();
                    filter = new IntentFilter();
                    filter.addAction("android.intent.action.PACKAGE_ADDED");
                    filter.addAction("android.intent.action.PACKAGE_REMOVED");
                    filter.addAction("android.intent.action.PACKAGE_CHANGED");
                    filter.addDataScheme("package");
                    this.mContext.registerReceiver(this.mBroadcastReceiver, filter);
                    sdFilter = new IntentFilter();
                    sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE");
                    sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE");
                    this.mContext.registerReceiver(this.mBroadcastReceiver, sdFilter);
                } catch (Throwable th2) {
                    th = th2;
                    if (temp != null) {
                        try {
                            temp.close();
                        } catch (IOException e7) {
                        }
                    }
                    if (in != null) {
                        try {
                            in.close();
                        } catch (IOException e8) {
                        }
                    }
                    throw th;
                }
            } catch (IOException e9) {
                e3 = e9;
                Slog.e(TAG, "Error in processed file", e3);
                if (temp != null) {
                    try {
                        temp.close();
                    } catch (IOException e10) {
                    }
                }
                if (in != null) {
                    try {
                        in.close();
                    } catch (IOException e11) {
                    }
                }
                this.mFullBackupQueue = readFullBackupSchedule();
                filter = new IntentFilter();
                filter.addAction("android.intent.action.PACKAGE_ADDED");
                filter.addAction("android.intent.action.PACKAGE_REMOVED");
                filter.addAction("android.intent.action.PACKAGE_CHANGED");
                filter.addDataScheme("package");
                this.mContext.registerReceiver(this.mBroadcastReceiver, filter);
                sdFilter = new IntentFilter();
                sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE");
                sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE");
                this.mContext.registerReceiver(this.mBroadcastReceiver, sdFilter);
            }
            try {
                RandomAccessFile in2 = new RandomAccessFile(this.mEverStored, "r");
                while (true) {
                    try {
                        String pkg = in2.readUTF();
                        try {
                            PackageInfo info = this.mPackageManager.getPackageInfo(pkg, OP_PENDING);
                            this.mEverStoredApps.add(pkg);
                            randomAccessFile.writeUTF(pkg);
                        } catch (NameNotFoundException e12) {
                        }
                    } catch (EOFException e13) {
                        in = in2;
                        temp = randomAccessFile;
                    } catch (IOException e14) {
                        e3 = e14;
                        in = in2;
                        temp = randomAccessFile;
                    } catch (Throwable th3) {
                        th = th3;
                        in = in2;
                        temp = randomAccessFile;
                    }
                }
            } catch (EOFException e15) {
                temp = randomAccessFile;
                if (file.renameTo(this.mEverStored)) {
                    append = new StringBuilder().append("Error renaming ");
                    Slog.e(TAG, r21.append(file).append(" to ").append(this.mEverStored).toString());
                }
                if (temp != null) {
                    temp.close();
                }
                if (in != null) {
                    in.close();
                }
                this.mFullBackupQueue = readFullBackupSchedule();
                filter = new IntentFilter();
                filter.addAction("android.intent.action.PACKAGE_ADDED");
                filter.addAction("android.intent.action.PACKAGE_REMOVED");
                filter.addAction("android.intent.action.PACKAGE_CHANGED");
                filter.addDataScheme("package");
                this.mContext.registerReceiver(this.mBroadcastReceiver, filter);
                sdFilter = new IntentFilter();
                sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE");
                sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE");
                this.mContext.registerReceiver(this.mBroadcastReceiver, sdFilter);
            } catch (IOException e16) {
                e3 = e16;
                temp = randomAccessFile;
                Slog.e(TAG, "Error in processed file", e3);
                if (temp != null) {
                    temp.close();
                }
                if (in != null) {
                    in.close();
                }
                this.mFullBackupQueue = readFullBackupSchedule();
                filter = new IntentFilter();
                filter.addAction("android.intent.action.PACKAGE_ADDED");
                filter.addAction("android.intent.action.PACKAGE_REMOVED");
                filter.addAction("android.intent.action.PACKAGE_CHANGED");
                filter.addDataScheme("package");
                this.mContext.registerReceiver(this.mBroadcastReceiver, filter);
                sdFilter = new IntentFilter();
                sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE");
                sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE");
                this.mContext.registerReceiver(this.mBroadcastReceiver, sdFilter);
            } catch (Throwable th4) {
                th = th4;
                temp = randomAccessFile;
                if (temp != null) {
                    temp.close();
                }
                if (in != null) {
                    in.close();
                }
                throw th;
            }
        }
        this.mFullBackupQueue = readFullBackupSchedule();
        filter = new IntentFilter();
        filter.addAction("android.intent.action.PACKAGE_ADDED");
        filter.addAction("android.intent.action.PACKAGE_REMOVED");
        filter.addAction("android.intent.action.PACKAGE_CHANGED");
        filter.addDataScheme("package");
        this.mContext.registerReceiver(this.mBroadcastReceiver, filter);
        sdFilter = new IntentFilter();
        sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE");
        sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE");
        this.mContext.registerReceiver(this.mBroadcastReceiver, sdFilter);
    }

    private ArrayList<FullBackupEntry> readFullBackupSchedule() {
        int N;
        ArrayList<FullBackupEntry> arrayList;
        Exception e;
        ArrayList<FullBackupEntry> arrayList2;
        Throwable th;
        ArrayList<FullBackupEntry> schedule;
        PackageInfo info;
        synchronized (this.mQueueLock) {
            List<PackageInfo> apps;
            int i;
            if (this.mFullBackupScheduleFile.exists()) {
                FileInputStream fstream = null;
                BufferedInputStream bufStream = null;
                DataInputStream in = null;
                try {
                    FileInputStream fstream2 = new FileInputStream(this.mFullBackupScheduleFile);
                    try {
                        BufferedInputStream bufStream2 = new BufferedInputStream(fstream2);
                        try {
                            DataInputStream in2 = new DataInputStream(bufStream2);
                            try {
                                int version = in2.readInt();
                                if (version != SCHEDULE_FILE_VERSION) {
                                    Slog.e(TAG, "Unknown backup schedule version " + version);
                                    IoUtils.closeQuietly(in2);
                                    IoUtils.closeQuietly(bufStream2);
                                    IoUtils.closeQuietly(fstream2);
                                    return null;
                                }
                                N = in2.readInt();
                                arrayList = new ArrayList(N);
                                i = OP_PENDING;
                                while (i < N) {
                                    try {
                                        arrayList.add(new FullBackupEntry(in2.readUTF(), in2.readLong()));
                                        i += SCHEDULE_FILE_VERSION;
                                    } catch (Exception e2) {
                                        e = e2;
                                        in = in2;
                                        bufStream = bufStream2;
                                        fstream = fstream2;
                                        arrayList2 = arrayList;
                                    } catch (Throwable th2) {
                                        th = th2;
                                        in = in2;
                                        bufStream = bufStream2;
                                        fstream = fstream2;
                                        arrayList2 = arrayList;
                                    }
                                }
                                Collections.sort(arrayList);
                                try {
                                    IoUtils.closeQuietly(in2);
                                    IoUtils.closeQuietly(bufStream2);
                                    IoUtils.closeQuietly(fstream2);
                                } catch (Throwable th3) {
                                    th = th3;
                                    arrayList2 = arrayList;
                                    throw th;
                                }
                            } catch (Exception e3) {
                                e = e3;
                                in = in2;
                                bufStream = bufStream2;
                                fstream = fstream2;
                                try {
                                    Slog.e(TAG, "Unable to read backup schedule", e);
                                    this.mFullBackupScheduleFile.delete();
                                    IoUtils.closeQuietly(in);
                                    IoUtils.closeQuietly(bufStream);
                                    IoUtils.closeQuietly(fstream);
                                    schedule = null;
                                    if (schedule == null) {
                                        arrayList2 = schedule;
                                    } else {
                                        apps = PackageManagerBackupAgent.getStorableApplications(this.mPackageManager);
                                        N = apps.size();
                                        arrayList = new ArrayList(N);
                                        for (i = OP_PENDING; i < N; i += SCHEDULE_FILE_VERSION) {
                                            info = (PackageInfo) apps.get(i);
                                            if (appGetsFullBackup(info)) {
                                                arrayList.add(new FullBackupEntry(info.packageName, 0));
                                            }
                                        }
                                        writeFullBackupScheduleAsync();
                                    }
                                    return arrayList2;
                                } catch (Throwable th4) {
                                    th = th4;
                                }
                            } catch (Throwable th5) {
                                th = th5;
                                in = in2;
                                bufStream = bufStream2;
                                fstream = fstream2;
                                IoUtils.closeQuietly(in);
                                IoUtils.closeQuietly(bufStream);
                                IoUtils.closeQuietly(fstream);
                                throw th;
                            }
                        } catch (Exception e4) {
                            e = e4;
                            bufStream = bufStream2;
                            fstream = fstream2;
                            Slog.e(TAG, "Unable to read backup schedule", e);
                            this.mFullBackupScheduleFile.delete();
                            IoUtils.closeQuietly(in);
                            IoUtils.closeQuietly(bufStream);
                            IoUtils.closeQuietly(fstream);
                            schedule = null;
                            if (schedule == null) {
                                apps = PackageManagerBackupAgent.getStorableApplications(this.mPackageManager);
                                N = apps.size();
                                arrayList = new ArrayList(N);
                                for (i = OP_PENDING; i < N; i += SCHEDULE_FILE_VERSION) {
                                    info = (PackageInfo) apps.get(i);
                                    if (appGetsFullBackup(info)) {
                                        arrayList.add(new FullBackupEntry(info.packageName, 0));
                                    }
                                }
                                writeFullBackupScheduleAsync();
                            } else {
                                arrayList2 = schedule;
                            }
                            return arrayList2;
                        } catch (Throwable th6) {
                            th = th6;
                            bufStream = bufStream2;
                            fstream = fstream2;
                            IoUtils.closeQuietly(in);
                            IoUtils.closeQuietly(bufStream);
                            IoUtils.closeQuietly(fstream);
                            throw th;
                        }
                    } catch (Exception e5) {
                        e = e5;
                        fstream = fstream2;
                        Slog.e(TAG, "Unable to read backup schedule", e);
                        this.mFullBackupScheduleFile.delete();
                        IoUtils.closeQuietly(in);
                        IoUtils.closeQuietly(bufStream);
                        IoUtils.closeQuietly(fstream);
                        schedule = null;
                        if (schedule == null) {
                            arrayList2 = schedule;
                        } else {
                            apps = PackageManagerBackupAgent.getStorableApplications(this.mPackageManager);
                            N = apps.size();
                            arrayList = new ArrayList(N);
                            for (i = OP_PENDING; i < N; i += SCHEDULE_FILE_VERSION) {
                                info = (PackageInfo) apps.get(i);
                                if (appGetsFullBackup(info)) {
                                    arrayList.add(new FullBackupEntry(info.packageName, 0));
                                }
                            }
                            writeFullBackupScheduleAsync();
                        }
                        return arrayList2;
                    } catch (Throwable th7) {
                        th = th7;
                        fstream = fstream2;
                        IoUtils.closeQuietly(in);
                        IoUtils.closeQuietly(bufStream);
                        IoUtils.closeQuietly(fstream);
                        throw th;
                    }
                } catch (Exception e6) {
                    e = e6;
                    Slog.e(TAG, "Unable to read backup schedule", e);
                    this.mFullBackupScheduleFile.delete();
                    IoUtils.closeQuietly(in);
                    IoUtils.closeQuietly(bufStream);
                    IoUtils.closeQuietly(fstream);
                    schedule = null;
                    if (schedule == null) {
                        apps = PackageManagerBackupAgent.getStorableApplications(this.mPackageManager);
                        N = apps.size();
                        arrayList = new ArrayList(N);
                        for (i = OP_PENDING; i < N; i += SCHEDULE_FILE_VERSION) {
                            info = (PackageInfo) apps.get(i);
                            if (appGetsFullBackup(info)) {
                                arrayList.add(new FullBackupEntry(info.packageName, 0));
                            }
                        }
                        writeFullBackupScheduleAsync();
                    } else {
                        arrayList2 = schedule;
                    }
                    return arrayList2;
                }
            }
            schedule = null;
            if (schedule == null) {
                apps = PackageManagerBackupAgent.getStorableApplications(this.mPackageManager);
                N = apps.size();
                arrayList = new ArrayList(N);
                for (i = OP_PENDING; i < N; i += SCHEDULE_FILE_VERSION) {
                    info = (PackageInfo) apps.get(i);
                    if (appGetsFullBackup(info)) {
                        arrayList.add(new FullBackupEntry(info.packageName, 0));
                    }
                }
                writeFullBackupScheduleAsync();
            } else {
                arrayList2 = schedule;
            }
            return arrayList2;
        }
    }

    private void writeFullBackupScheduleAsync() {
        this.mBackupHandler.removeCallbacks(this.mFullBackupScheduleWriter);
        this.mBackupHandler.post(this.mFullBackupScheduleWriter);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void parseLeftoverJournals() {
        /*
        r11 = this;
        r8 = r11.mJournalDir;
        r0 = r8.listFiles();
        r6 = r0.length;
        r3 = 0;
    L_0x0008:
        if (r3 >= r6) goto L_0x006e;
    L_0x000a:
        r2 = r0[r3];
        r8 = r11.mJournal;
        if (r8 == 0) goto L_0x0018;
    L_0x0010:
        r8 = r11.mJournal;
        r8 = r2.compareTo(r8);
        if (r8 == 0) goto L_0x0039;
    L_0x0018:
        r4 = 0;
        r8 = "BackupManagerService";
        r9 = "Found stale backup journal, scheduling";
        android.util.Slog.i(r8, r9);	 Catch:{ EOFException -> 0x0075, Exception -> 0x003c }
        r5 = new java.io.RandomAccessFile;	 Catch:{ EOFException -> 0x0075, Exception -> 0x003c }
        r8 = "r";
        r5.<init>(r2, r8);	 Catch:{ EOFException -> 0x0075, Exception -> 0x003c }
    L_0x0027:
        r7 = r5.readUTF();	 Catch:{ EOFException -> 0x002f, Exception -> 0x0072, all -> 0x006f }
        r11.dataChangedImpl(r7);	 Catch:{ EOFException -> 0x002f, Exception -> 0x0072, all -> 0x006f }
        goto L_0x0027;
    L_0x002f:
        r8 = move-exception;
        r4 = r5;
    L_0x0031:
        if (r4 == 0) goto L_0x0036;
    L_0x0033:
        r4.close();	 Catch:{ IOException -> 0x0068 }
    L_0x0036:
        r2.delete();
    L_0x0039:
        r3 = r3 + 1;
        goto L_0x0008;
    L_0x003c:
        r1 = move-exception;
    L_0x003d:
        r8 = "BackupManagerService";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x005e }
        r9.<init>();	 Catch:{ all -> 0x005e }
        r10 = "Can't read ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x005e }
        r9 = r9.append(r2);	 Catch:{ all -> 0x005e }
        r9 = r9.toString();	 Catch:{ all -> 0x005e }
        android.util.Slog.e(r8, r9, r1);	 Catch:{ all -> 0x005e }
        if (r4 == 0) goto L_0x005a;
    L_0x0057:
        r4.close();	 Catch:{ IOException -> 0x006a }
    L_0x005a:
        r2.delete();
        goto L_0x0039;
    L_0x005e:
        r8 = move-exception;
    L_0x005f:
        if (r4 == 0) goto L_0x0064;
    L_0x0061:
        r4.close();	 Catch:{ IOException -> 0x006c }
    L_0x0064:
        r2.delete();
        throw r8;
    L_0x0068:
        r8 = move-exception;
        goto L_0x0036;
    L_0x006a:
        r8 = move-exception;
        goto L_0x005a;
    L_0x006c:
        r9 = move-exception;
        goto L_0x0064;
    L_0x006e:
        return;
    L_0x006f:
        r8 = move-exception;
        r4 = r5;
        goto L_0x005f;
    L_0x0072:
        r1 = move-exception;
        r4 = r5;
        goto L_0x003d;
    L_0x0075:
        r8 = move-exception;
        goto L_0x0031;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.parseLeftoverJournals():void");
    }

    private SecretKey buildPasswordKey(String algorithm, String pw, byte[] salt, int rounds) {
        return buildCharArrayKey(algorithm, pw.toCharArray(), salt, rounds);
    }

    private SecretKey buildCharArrayKey(String algorithm, char[] pwArray, byte[] salt, int rounds) {
        try {
            return SecretKeyFactory.getInstance(algorithm).generateSecret(new PBEKeySpec(pwArray, salt, rounds, PBKDF2_KEY_SIZE));
        } catch (InvalidKeySpecException e) {
            Slog.e(TAG, "Invalid key spec for PBKDF2!");
            return null;
        } catch (NoSuchAlgorithmException e2) {
            Slog.e(TAG, "PBKDF2 unavailable!");
            return null;
        }
    }

    private String buildPasswordHash(String algorithm, String pw, byte[] salt, int rounds) {
        SecretKey key = buildPasswordKey(algorithm, pw, salt, rounds);
        if (key != null) {
            return byteArrayToHex(key.getEncoded());
        }
        return null;
    }

    private String byteArrayToHex(byte[] data) {
        StringBuilder buf = new StringBuilder(data.length * MSG_RUN_ADB_BACKUP);
        for (int i = OP_PENDING; i < data.length; i += SCHEDULE_FILE_VERSION) {
            buf.append(Byte.toHexString(data[i], DEBUG_SCHEDULING));
        }
        return buf.toString();
    }

    private byte[] hexToByteArray(String digits) {
        int bytes = digits.length() / MSG_RUN_ADB_BACKUP;
        if (bytes * MSG_RUN_ADB_BACKUP != digits.length()) {
            throw new IllegalArgumentException("Hex string must have an even number of digits");
        }
        byte[] result = new byte[bytes];
        for (int i = OP_PENDING; i < digits.length(); i += MSG_RUN_ADB_BACKUP) {
            result[i / MSG_RUN_ADB_BACKUP] = (byte) Integer.parseInt(digits.substring(i, i + MSG_RUN_ADB_BACKUP), 16);
        }
        return result;
    }

    private byte[] makeKeyChecksum(String algorithm, byte[] pwBytes, byte[] salt, int rounds) {
        char[] mkAsChar = new char[pwBytes.length];
        for (int i = OP_PENDING; i < pwBytes.length; i += SCHEDULE_FILE_VERSION) {
            mkAsChar[i] = (char) pwBytes[i];
        }
        return buildCharArrayKey(algorithm, mkAsChar, salt, rounds).getEncoded();
    }

    private byte[] randomBytes(int bits) {
        byte[] array = new byte[(bits / MSG_RESTORE_TIMEOUT)];
        this.mRng.nextBytes(array);
        return array;
    }

    boolean passwordMatchesSaved(String algorithm, String candidatePw, int rounds) {
        if (this.mPasswordHash == null) {
            if (candidatePw == null || "".equals(candidatePw)) {
                return DEBUG_SCHEDULING;
            }
        } else if (candidatePw != null && candidatePw.length() > 0) {
            if (this.mPasswordHash.equalsIgnoreCase(buildPasswordHash(algorithm, candidatePw, this.mPasswordSalt, rounds))) {
                return DEBUG_SCHEDULING;
            }
        }
        return MORE_DEBUG;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean setBackupPassword(java.lang.String r23, java.lang.String r24) {
        /*
        r22 = this;
        r0 = r22;
        r0 = r0.mContext;
        r19 = r0;
        r20 = "android.permission.BACKUP";
        r21 = "setBackupPassword";
        r19.enforceCallingOrSelfPermission(r20, r21);
        r0 = r22;
        r0 = r0.mPasswordVersion;
        r19 = r0;
        r20 = 2;
        r0 = r19;
        r1 = r20;
        if (r0 >= r1) goto L_0x0045;
    L_0x001b:
        r11 = 1;
    L_0x001c:
        r19 = "PBKDF2WithHmacSHA1";
        r20 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r0 = r22;
        r1 = r19;
        r2 = r23;
        r3 = r20;
        r19 = r0.passwordMatchesSaved(r1, r2, r3);
        if (r19 != 0) goto L_0x0047;
    L_0x002e:
        if (r11 == 0) goto L_0x0042;
    L_0x0030:
        r19 = "PBKDF2WithHmacSHA1And8bit";
        r20 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r0 = r22;
        r1 = r19;
        r2 = r23;
        r3 = r20;
        r19 = r0.passwordMatchesSaved(r1, r2, r3);
        if (r19 != 0) goto L_0x0047;
    L_0x0042:
        r19 = 0;
    L_0x0044:
        return r19;
    L_0x0045:
        r11 = 0;
        goto L_0x001c;
    L_0x0047:
        r19 = 2;
        r0 = r19;
        r1 = r22;
        r1.mPasswordVersion = r0;
        r12 = 0;
        r14 = 0;
        r13 = new java.io.FileOutputStream;	 Catch:{ IOException -> 0x00ab }
        r0 = r22;
        r0 = r0.mPasswordVersionFile;	 Catch:{ IOException -> 0x00ab }
        r19 = r0;
        r0 = r19;
        r13.<init>(r0);	 Catch:{ IOException -> 0x00ab }
        r15 = new java.io.DataOutputStream;	 Catch:{ IOException -> 0x0195, all -> 0x018c }
        r15.<init>(r13);	 Catch:{ IOException -> 0x0195, all -> 0x018c }
        r0 = r22;
        r0 = r0.mPasswordVersion;	 Catch:{ IOException -> 0x0199, all -> 0x0190 }
        r19 = r0;
        r0 = r19;
        r15.writeInt(r0);	 Catch:{ IOException -> 0x0199, all -> 0x0190 }
        if (r15 == 0) goto L_0x0073;
    L_0x0070:
        r15.close();	 Catch:{ IOException -> 0x00a2 }
    L_0x0073:
        if (r13 == 0) goto L_0x0078;
    L_0x0075:
        r13.close();	 Catch:{ IOException -> 0x00a2 }
    L_0x0078:
        if (r24 == 0) goto L_0x0080;
    L_0x007a:
        r19 = r24.isEmpty();
        if (r19 == 0) goto L_0x00f3;
    L_0x0080:
        r0 = r22;
        r0 = r0.mPasswordHashFile;
        r19 = r0;
        r19 = r19.exists();
        if (r19 == 0) goto L_0x00df;
    L_0x008c:
        r0 = r22;
        r0 = r0.mPasswordHashFile;
        r19 = r0;
        r19 = r19.delete();
        if (r19 != 0) goto L_0x00df;
    L_0x0098:
        r19 = "BackupManagerService";
        r20 = "Unable to clear backup password";
        android.util.Slog.e(r19, r20);
        r19 = 0;
        goto L_0x0044;
    L_0x00a2:
        r7 = move-exception;
        r19 = "BackupManagerService";
        r20 = "Unable to close pw version record";
        android.util.Slog.w(r19, r20);
        goto L_0x0078;
    L_0x00ab:
        r7 = move-exception;
    L_0x00ac:
        r19 = "BackupManagerService";
        r20 = "Unable to write backup pw version; password not changed";
        android.util.Slog.e(r19, r20);	 Catch:{ all -> 0x00ca }
        r19 = 0;
        if (r14 == 0) goto L_0x00ba;
    L_0x00b7:
        r14.close();	 Catch:{ IOException -> 0x00c0 }
    L_0x00ba:
        if (r12 == 0) goto L_0x0044;
    L_0x00bc:
        r12.close();	 Catch:{ IOException -> 0x00c0 }
        goto L_0x0044;
    L_0x00c0:
        r7 = move-exception;
        r20 = "BackupManagerService";
        r21 = "Unable to close pw version record";
        android.util.Slog.w(r20, r21);
        goto L_0x0044;
    L_0x00ca:
        r19 = move-exception;
    L_0x00cb:
        if (r14 == 0) goto L_0x00d0;
    L_0x00cd:
        r14.close();	 Catch:{ IOException -> 0x00d6 }
    L_0x00d0:
        if (r12 == 0) goto L_0x00d5;
    L_0x00d2:
        r12.close();	 Catch:{ IOException -> 0x00d6 }
    L_0x00d5:
        throw r19;
    L_0x00d6:
        r7 = move-exception;
        r20 = "BackupManagerService";
        r21 = "Unable to close pw version record";
        android.util.Slog.w(r20, r21);
        goto L_0x00d5;
    L_0x00df:
        r19 = 0;
        r0 = r19;
        r1 = r22;
        r1.mPasswordHash = r0;
        r19 = 0;
        r0 = r19;
        r1 = r22;
        r1.mPasswordSalt = r0;
        r19 = 1;
        goto L_0x0044;
    L_0x00f3:
        r19 = 512; // 0x200 float:7.175E-43 double:2.53E-321;
        r0 = r22;
        r1 = r19;
        r18 = r0.randomBytes(r1);	 Catch:{ IOException -> 0x0160 }
        r19 = "PBKDF2WithHmacSHA1";
        r20 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r0 = r22;
        r1 = r19;
        r2 = r24;
        r3 = r18;
        r4 = r20;
        r8 = r0.buildPasswordHash(r1, r2, r3, r4);	 Catch:{ IOException -> 0x0160 }
        r16 = 0;
        r5 = 0;
        r9 = 0;
        r17 = new java.io.FileOutputStream;	 Catch:{ all -> 0x016c }
        r0 = r22;
        r0 = r0.mPasswordHashFile;	 Catch:{ all -> 0x016c }
        r19 = r0;
        r0 = r17;
        r1 = r19;
        r0.<init>(r1);	 Catch:{ all -> 0x016c }
        r6 = new java.io.BufferedOutputStream;	 Catch:{ all -> 0x017d }
        r0 = r17;
        r6.<init>(r0);	 Catch:{ all -> 0x017d }
        r10 = new java.io.DataOutputStream;	 Catch:{ all -> 0x0181 }
        r10.<init>(r6);	 Catch:{ all -> 0x0181 }
        r0 = r18;
        r0 = r0.length;	 Catch:{ all -> 0x0186 }
        r19 = r0;
        r0 = r19;
        r10.writeInt(r0);	 Catch:{ all -> 0x0186 }
        r0 = r18;
        r10.write(r0);	 Catch:{ all -> 0x0186 }
        r10.writeUTF(r8);	 Catch:{ all -> 0x0186 }
        r10.flush();	 Catch:{ all -> 0x0186 }
        r0 = r22;
        r0.mPasswordHash = r8;	 Catch:{ all -> 0x0186 }
        r0 = r18;
        r1 = r22;
        r1.mPasswordSalt = r0;	 Catch:{ all -> 0x0186 }
        r19 = 1;
        if (r10 == 0) goto L_0x0154;
    L_0x0151:
        r10.close();	 Catch:{ IOException -> 0x0160 }
    L_0x0154:
        if (r6 == 0) goto L_0x0159;
    L_0x0156:
        r6.close();	 Catch:{ IOException -> 0x0160 }
    L_0x0159:
        if (r17 == 0) goto L_0x0044;
    L_0x015b:
        r17.close();	 Catch:{ IOException -> 0x0160 }
        goto L_0x0044;
    L_0x0160:
        r7 = move-exception;
        r19 = "BackupManagerService";
        r20 = "Unable to set backup password";
        android.util.Slog.e(r19, r20);
        r19 = 0;
        goto L_0x0044;
    L_0x016c:
        r19 = move-exception;
    L_0x016d:
        if (r9 == 0) goto L_0x0172;
    L_0x016f:
        r9.close();	 Catch:{ IOException -> 0x0160 }
    L_0x0172:
        if (r5 == 0) goto L_0x0177;
    L_0x0174:
        r5.close();	 Catch:{ IOException -> 0x0160 }
    L_0x0177:
        if (r16 == 0) goto L_0x017c;
    L_0x0179:
        r16.close();	 Catch:{ IOException -> 0x0160 }
    L_0x017c:
        throw r19;	 Catch:{ IOException -> 0x0160 }
    L_0x017d:
        r19 = move-exception;
        r16 = r17;
        goto L_0x016d;
    L_0x0181:
        r19 = move-exception;
        r5 = r6;
        r16 = r17;
        goto L_0x016d;
    L_0x0186:
        r19 = move-exception;
        r9 = r10;
        r5 = r6;
        r16 = r17;
        goto L_0x016d;
    L_0x018c:
        r19 = move-exception;
        r12 = r13;
        goto L_0x00cb;
    L_0x0190:
        r19 = move-exception;
        r14 = r15;
        r12 = r13;
        goto L_0x00cb;
    L_0x0195:
        r7 = move-exception;
        r12 = r13;
        goto L_0x00ac;
    L_0x0199:
        r7 = move-exception;
        r14 = r15;
        r12 = r13;
        goto L_0x00ac;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.setBackupPassword(java.lang.String, java.lang.String):boolean");
    }

    public boolean hasBackupPassword() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "hasBackupPassword");
        return (this.mPasswordHash == null || this.mPasswordHash.length() <= 0) ? MORE_DEBUG : DEBUG_SCHEDULING;
    }

    private boolean backupPasswordMatches(String currentPw) {
        if (hasBackupPassword()) {
            boolean pbkdf2Fallback = this.mPasswordVersion < MSG_RUN_ADB_BACKUP ? DEBUG_SCHEDULING : MORE_DEBUG;
            if (!(passwordMatchesSaved(PBKDF_CURRENT, currentPw, PBKDF2_HASH_ROUNDS) || (pbkdf2Fallback && passwordMatchesSaved(PBKDF_FALLBACK, currentPw, PBKDF2_HASH_ROUNDS)))) {
                Slog.w(TAG, "Backup password mismatch; aborting");
                return MORE_DEBUG;
            }
        }
        return DEBUG_SCHEDULING;
    }

    void recordInitPendingLocked(boolean isPending, String transportName) {
        Slog.i(TAG, "recordInitPendingLocked: " + isPending + " on transport " + transportName);
        this.mBackupHandler.removeMessages(MSG_RETRY_INIT);
        try {
            IBackupTransport transport = getTransport(transportName);
            if (transport != null) {
                File initPendingFile = new File(new File(this.mBaseStateDir, transport.transportDirName()), INIT_SENTINEL_FILE_NAME);
                if (isPending) {
                    this.mPendingInits.add(transportName);
                    try {
                        new FileOutputStream(initPendingFile).close();
                        return;
                    } catch (IOException e) {
                        return;
                    }
                }
                initPendingFile.delete();
                this.mPendingInits.remove(transportName);
                return;
            }
        } catch (RemoteException e2) {
        }
        if (isPending) {
            this.mPendingInits.add(transportName);
            this.mBackupHandler.sendMessageDelayed(this.mBackupHandler.obtainMessage(MSG_RETRY_INIT, isPending ? SCHEDULE_FILE_VERSION : OP_PENDING, OP_PENDING, transportName), TRANSPORT_RETRY_INTERVAL);
        }
    }

    void resetBackupState(File stateFileDir) {
        synchronized (this.mQueueLock) {
            this.mEverStoredApps.clear();
            this.mEverStored.delete();
            this.mCurrentToken = 0;
            writeRestoreTokens();
            File[] arr$ = stateFileDir.listFiles();
            int len$ = arr$.length;
            for (int i$ = OP_PENDING; i$ < len$; i$ += SCHEDULE_FILE_VERSION) {
                File sf = arr$[i$];
                if (!sf.getName().equals(INIT_SENTINEL_FILE_NAME)) {
                    sf.delete();
                }
            }
        }
        synchronized (this.mBackupParticipants) {
            int N = this.mBackupParticipants.size();
            for (int i = OP_PENDING; i < N; i += SCHEDULE_FILE_VERSION) {
                HashSet<String> participants = (HashSet) this.mBackupParticipants.valueAt(i);
                if (participants != null) {
                    Iterator i$2 = participants.iterator();
                    while (i$2.hasNext()) {
                        dataChangedImpl((String) i$2.next());
                    }
                }
            }
        }
    }

    private void registerTransport(String name, String component, IBackupTransport transport) {
        synchronized (this.mTransports) {
            Slog.v(TAG, "Registering transport " + component + "::" + name + " = " + transport);
            if (transport != null) {
                this.mTransports.put(name, transport);
                this.mTransportNames.put(component, name);
                try {
                    String transportName = transport.transportDirName();
                    File stateDir = new File(this.mBaseStateDir, transportName);
                    stateDir.mkdirs();
                    if (new File(stateDir, INIT_SENTINEL_FILE_NAME).exists()) {
                        synchronized (this.mQueueLock) {
                            this.mPendingInits.add(transportName);
                            this.mAlarmManager.set(OP_PENDING, System.currentTimeMillis() + TIMEOUT_RESTORE_INTERVAL, this.mRunInitIntent);
                        }
                        return;
                    }
                    return;
                } catch (RemoteException e) {
                    Slog.e(TAG, "Unable to register transport as " + name);
                    this.mTransportNames.remove(component);
                    this.mTransports.remove(name);
                    return;
                }
            }
            this.mTransports.remove(this.mTransportNames.get(component));
            this.mTransportNames.remove(component);
        }
    }

    void checkForTransportAndBind(PackageInfo pkgInfo) {
        List<ResolveInfo> hosts = this.mPackageManager.queryIntentServicesAsUser(new Intent(this.mTransportServiceIntent).setPackage(pkgInfo.packageName), OP_PENDING, OP_PENDING);
        int N = hosts.size();
        for (int i = OP_PENDING; i < N; i += SCHEDULE_FILE_VERSION) {
            tryBindTransport(((ResolveInfo) hosts.get(i)).serviceInfo);
        }
    }

    boolean tryBindTransport(ServiceInfo info) {
        try {
            if ((this.mPackageManager.getPackageInfo(info.packageName, OP_PENDING).applicationInfo.flags & 1073741824) != 0) {
                return bindTransport(info);
            }
            Slog.w(TAG, "Transport package " + info.packageName + " not privileged");
            return MORE_DEBUG;
        } catch (NameNotFoundException e) {
            Slog.w(TAG, "Problem resolving transport package " + info.packageName);
            return MORE_DEBUG;
        }
    }

    boolean bindTransport(ServiceInfo transport) {
        TransportConnection connection;
        ComponentName svcName = new ComponentName(transport.packageName, transport.name);
        Slog.i(TAG, "Binding to transport host " + svcName);
        Intent intent = new Intent(this.mTransportServiceIntent);
        intent.setComponent(svcName);
        synchronized (this.mTransports) {
            connection = (TransportConnection) this.mTransportConnections.get(transport.packageName);
            if (connection == null) {
                connection = new TransportConnection(transport);
                this.mTransportConnections.put(transport.packageName, connection);
            } else {
                this.mContext.unbindService(connection);
            }
        }
        return this.mContext.bindServiceAsUser(intent, connection, SCHEDULE_FILE_VERSION, UserHandle.OWNER);
    }

    void addPackageParticipantsLocked(String[] packageNames) {
        List<PackageInfo> targetApps = allAgentPackages();
        if (packageNames != null) {
            String[] arr$ = packageNames;
            int len$ = arr$.length;
            for (int i$ = OP_PENDING; i$ < len$; i$ += SCHEDULE_FILE_VERSION) {
                addPackageParticipantsLockedInner(arr$[i$], targetApps);
            }
            return;
        }
        addPackageParticipantsLockedInner(null, targetApps);
    }

    private void addPackageParticipantsLockedInner(String packageName, List<PackageInfo> targetPkgs) {
        for (PackageInfo pkg : targetPkgs) {
            if (packageName == null || pkg.packageName.equals(packageName)) {
                int uid = pkg.applicationInfo.uid;
                HashSet<String> set = (HashSet) this.mBackupParticipants.get(uid);
                if (set == null) {
                    set = new HashSet();
                    this.mBackupParticipants.put(uid, set);
                }
                set.add(pkg.packageName);
                dataChangedImpl(pkg.packageName);
            }
        }
    }

    void removePackageParticipantsLocked(String[] packageNames, int oldUid) {
        if (packageNames == null) {
            Slog.w(TAG, "removePackageParticipants with null list");
            return;
        }
        String[] arr$ = packageNames;
        int len$ = arr$.length;
        for (int i$ = OP_PENDING; i$ < len$; i$ += SCHEDULE_FILE_VERSION) {
            String pkg = arr$[i$];
            HashSet<String> set = (HashSet) this.mBackupParticipants.get(oldUid);
            if (set != null && set.contains(pkg)) {
                removePackageFromSetLocked(set, pkg);
                if (set.isEmpty()) {
                    this.mBackupParticipants.remove(oldUid);
                }
            }
        }
    }

    private void removePackageFromSetLocked(HashSet<String> set, String packageName) {
        if (set.contains(packageName)) {
            set.remove(packageName);
            this.mPendingBackups.remove(packageName);
        }
    }

    List<PackageInfo> allAgentPackages() {
        List<PackageInfo> packages = this.mPackageManager.getInstalledPackages(64);
        int a = packages.size() + OP_TIMEOUT;
        while (a >= 0) {
            PackageInfo pkg = (PackageInfo) packages.get(a);
            try {
                ApplicationInfo app = pkg.applicationInfo;
                if ((app.flags & 32768) == 0 || app.backupAgentName == null) {
                    packages.remove(a);
                    a += OP_TIMEOUT;
                } else {
                    app = this.mPackageManager.getApplicationInfo(pkg.packageName, DumpState.DUMP_PREFERRED_XML);
                    pkg.applicationInfo.sharedLibraryFiles = app.sharedLibraryFiles;
                    a += OP_TIMEOUT;
                }
            } catch (NameNotFoundException e) {
                packages.remove(a);
            }
        }
        return packages;
    }

    void logBackupComplete(String packageName) {
        Throwable th;
        if (!packageName.equals(PACKAGE_MANAGER_SENTINEL)) {
            synchronized (this.mEverStoredApps) {
                if (this.mEverStoredApps.add(packageName)) {
                    RandomAccessFile out = null;
                    try {
                        RandomAccessFile out2 = new RandomAccessFile(this.mEverStored, "rws");
                        try {
                            out2.seek(out2.length());
                            out2.writeUTF(packageName);
                            if (out2 != null) {
                                try {
                                    out2.close();
                                } catch (IOException e) {
                                    out = out2;
                                }
                            }
                            out = out2;
                        } catch (IOException e2) {
                            out = out2;
                            try {
                                Slog.e(TAG, "Can't log backup of " + packageName + " to " + this.mEverStored);
                                if (out != null) {
                                    try {
                                        out.close();
                                    } catch (IOException e3) {
                                    }
                                }
                                return;
                            } catch (Throwable th2) {
                                th = th2;
                                if (out != null) {
                                    try {
                                        out.close();
                                    } catch (IOException e4) {
                                    }
                                }
                                throw th;
                            }
                        } catch (Throwable th3) {
                            th = th3;
                            out = out2;
                            if (out != null) {
                                out.close();
                            }
                            throw th;
                        }
                    } catch (IOException e5) {
                        Slog.e(TAG, "Can't log backup of " + packageName + " to " + this.mEverStored);
                        if (out != null) {
                            out.close();
                        }
                        return;
                    }
                    return;
                }
            }
        }
    }

    void removeEverBackedUp(String packageName) {
        IOException e;
        Throwable th;
        Slog.v(TAG, "Removing backed-up knowledge of " + packageName);
        synchronized (this.mEverStoredApps) {
            File tempKnownFile = new File(this.mBaseStateDir, "processed.new");
            RandomAccessFile randomAccessFile = null;
            try {
                RandomAccessFile known = new RandomAccessFile(tempKnownFile, "rws");
                try {
                    this.mEverStoredApps.remove(packageName);
                    Iterator i$ = this.mEverStoredApps.iterator();
                    while (i$.hasNext()) {
                        known.writeUTF((String) i$.next());
                    }
                    known.close();
                    randomAccessFile = null;
                    if (tempKnownFile.renameTo(this.mEverStored)) {
                        if (randomAccessFile != null) {
                            try {
                                randomAccessFile.close();
                            } catch (IOException e2) {
                            }
                        }
                    } else {
                        throw new IOException("Can't rename " + tempKnownFile + " to " + this.mEverStored);
                    }
                } catch (IOException e3) {
                    e = e3;
                    randomAccessFile = known;
                    try {
                        Slog.w(TAG, "Error rewriting " + this.mEverStored, e);
                        this.mEverStoredApps.clear();
                        tempKnownFile.delete();
                        this.mEverStored.delete();
                        if (randomAccessFile != null) {
                            try {
                                randomAccessFile.close();
                            } catch (IOException e4) {
                            }
                        }
                    } catch (Throwable th2) {
                        th = th2;
                        if (randomAccessFile != null) {
                            try {
                                randomAccessFile.close();
                            } catch (IOException e5) {
                            }
                        }
                        throw th;
                    }
                } catch (Throwable th3) {
                    th = th3;
                    randomAccessFile = known;
                    if (randomAccessFile != null) {
                        randomAccessFile.close();
                    }
                    throw th;
                }
            } catch (IOException e6) {
                e = e6;
                Slog.w(TAG, "Error rewriting " + this.mEverStored, e);
                this.mEverStoredApps.clear();
                tempKnownFile.delete();
                this.mEverStored.delete();
                if (randomAccessFile != null) {
                    randomAccessFile.close();
                }
            }
        }
    }

    void writeRestoreTokens() {
        try {
            RandomAccessFile af = new RandomAccessFile(this.mTokenFile, "rwd");
            af.writeInt(SCHEDULE_FILE_VERSION);
            af.writeLong(this.mAncestralToken);
            af.writeLong(this.mCurrentToken);
            if (this.mAncestralPackages == null) {
                af.writeInt(OP_TIMEOUT);
            } else {
                af.writeInt(this.mAncestralPackages.size());
                Slog.v(TAG, "Ancestral packages:  " + this.mAncestralPackages.size());
                for (String pkgName : this.mAncestralPackages) {
                    af.writeUTF(pkgName);
                }
            }
            af.close();
        } catch (IOException e) {
            Slog.w(TAG, "Unable to write token file:", e);
        }
    }

    private IBackupTransport getTransport(String transportName) {
        IBackupTransport transport;
        synchronized (this.mTransports) {
            transport = (IBackupTransport) this.mTransports.get(transportName);
            if (transport == null) {
                Slog.w(TAG, "Requested unavailable transport: " + transportName);
            }
        }
        return transport;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    android.app.IBackupAgent bindToAgentSynchronous(android.content.pm.ApplicationInfo r12, int r13) {
        /*
        r11 = this;
        r10 = 1;
        r4 = 0;
        r0 = 0;
        r5 = r11.mAgentConnectLock;
        monitor-enter(r5);
        r6 = 1;
        r11.mConnecting = r6;	 Catch:{ all -> 0x008f }
        r6 = 0;
        r11.mConnectedAgent = r6;	 Catch:{ all -> 0x008f }
        r6 = r11.mActivityManager;	 Catch:{ RemoteException -> 0x00b1 }
        r6 = r6.bindBackupAgent(r12, r13);	 Catch:{ RemoteException -> 0x00b1 }
        if (r6 == 0) goto L_0x00ae;
    L_0x0014:
        r6 = "BackupManagerService";
        r7 = new java.lang.StringBuilder;	 Catch:{ RemoteException -> 0x00b1 }
        r7.<init>();	 Catch:{ RemoteException -> 0x00b1 }
        r8 = "awaiting agent for ";
        r7 = r7.append(r8);	 Catch:{ RemoteException -> 0x00b1 }
        r7 = r7.append(r12);	 Catch:{ RemoteException -> 0x00b1 }
        r7 = r7.toString();	 Catch:{ RemoteException -> 0x00b1 }
        android.util.Slog.d(r6, r7);	 Catch:{ RemoteException -> 0x00b1 }
        r6 = java.lang.System.currentTimeMillis();	 Catch:{ RemoteException -> 0x00b1 }
        r8 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r2 = r6 + r8;
    L_0x0034:
        r6 = r11.mConnecting;	 Catch:{ RemoteException -> 0x00b1 }
        if (r6 == 0) goto L_0x006c;
    L_0x0038:
        r6 = r11.mConnectedAgent;	 Catch:{ RemoteException -> 0x00b1 }
        if (r6 != 0) goto L_0x006c;
    L_0x003c:
        r6 = java.lang.System.currentTimeMillis();	 Catch:{ RemoteException -> 0x00b1 }
        r6 = (r6 > r2 ? 1 : (r6 == r2 ? 0 : -1));
        if (r6 >= 0) goto L_0x006c;
    L_0x0044:
        r6 = r11.mAgentConnectLock;	 Catch:{ InterruptedException -> 0x004c }
        r8 = 5000; // 0x1388 float:7.006E-42 double:2.4703E-320;
        r6.wait(r8);	 Catch:{ InterruptedException -> 0x004c }
        goto L_0x0034;
    L_0x004c:
        r1 = move-exception;
        r6 = "BackupManagerService";
        r7 = new java.lang.StringBuilder;	 Catch:{ RemoteException -> 0x00b1 }
        r7.<init>();	 Catch:{ RemoteException -> 0x00b1 }
        r8 = "Interrupted: ";
        r7 = r7.append(r8);	 Catch:{ RemoteException -> 0x00b1 }
        r7 = r7.append(r1);	 Catch:{ RemoteException -> 0x00b1 }
        r7 = r7.toString();	 Catch:{ RemoteException -> 0x00b1 }
        android.util.Slog.w(r6, r7);	 Catch:{ RemoteException -> 0x00b1 }
        r6 = r11.mActivityManager;	 Catch:{ RemoteException -> 0x00b1 }
        r6.clearPendingBackup();	 Catch:{ RemoteException -> 0x00b1 }
        monitor-exit(r5);	 Catch:{ all -> 0x008f }
    L_0x006b:
        return r4;
    L_0x006c:
        r6 = r11.mConnecting;	 Catch:{ RemoteException -> 0x00b1 }
        if (r6 != r10) goto L_0x0092;
    L_0x0070:
        r6 = "BackupManagerService";
        r7 = new java.lang.StringBuilder;	 Catch:{ RemoteException -> 0x00b1 }
        r7.<init>();	 Catch:{ RemoteException -> 0x00b1 }
        r8 = "Timeout waiting for agent ";
        r7 = r7.append(r8);	 Catch:{ RemoteException -> 0x00b1 }
        r7 = r7.append(r12);	 Catch:{ RemoteException -> 0x00b1 }
        r7 = r7.toString();	 Catch:{ RemoteException -> 0x00b1 }
        android.util.Slog.w(r6, r7);	 Catch:{ RemoteException -> 0x00b1 }
        r6 = r11.mActivityManager;	 Catch:{ RemoteException -> 0x00b1 }
        r6.clearPendingBackup();	 Catch:{ RemoteException -> 0x00b1 }
        monitor-exit(r5);	 Catch:{ all -> 0x008f }
        goto L_0x006b;
    L_0x008f:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x008f }
        throw r4;
    L_0x0092:
        r4 = "BackupManagerService";
        r6 = new java.lang.StringBuilder;	 Catch:{ RemoteException -> 0x00b1 }
        r6.<init>();	 Catch:{ RemoteException -> 0x00b1 }
        r7 = "got agent ";
        r6 = r6.append(r7);	 Catch:{ RemoteException -> 0x00b1 }
        r7 = r11.mConnectedAgent;	 Catch:{ RemoteException -> 0x00b1 }
        r6 = r6.append(r7);	 Catch:{ RemoteException -> 0x00b1 }
        r6 = r6.toString();	 Catch:{ RemoteException -> 0x00b1 }
        android.util.Slog.i(r4, r6);	 Catch:{ RemoteException -> 0x00b1 }
        r0 = r11.mConnectedAgent;	 Catch:{ RemoteException -> 0x00b1 }
    L_0x00ae:
        monitor-exit(r5);	 Catch:{ all -> 0x008f }
        r4 = r0;
        goto L_0x006b;
    L_0x00b1:
        r4 = move-exception;
        goto L_0x00ae;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.bindToAgentSynchronous(android.content.pm.ApplicationInfo, int):android.app.IBackupAgent");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void clearApplicationDataSynchronous(java.lang.String r13) {
        /*
        r12 = this;
        r3 = r12.mPackageManager;	 Catch:{ NameNotFoundException -> 0x0010 }
        r6 = 0;
        r1 = r3.getPackageInfo(r13, r6);	 Catch:{ NameNotFoundException -> 0x0010 }
        r3 = r1.applicationInfo;	 Catch:{ NameNotFoundException -> 0x0010 }
        r3 = r3.flags;	 Catch:{ NameNotFoundException -> 0x0010 }
        r3 = r3 & 64;
        if (r3 != 0) goto L_0x0030;
    L_0x000f:
        return;
    L_0x0010:
        r0 = move-exception;
        r3 = "BackupManagerService";
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r7 = "Tried to clear data for ";
        r6 = r6.append(r7);
        r6 = r6.append(r13);
        r7 = " but not found";
        r6 = r6.append(r7);
        r6 = r6.toString();
        android.util.Slog.w(r3, r6);
        goto L_0x000f;
    L_0x0030:
        r2 = new com.android.server.backup.BackupManagerService$ClearDataObserver;
        r2.<init>();
        r6 = r12.mClearDataLock;
        monitor-enter(r6);
        r3 = 1;
        r12.mClearingData = r3;	 Catch:{ all -> 0x0062 }
        r3 = r12.mActivityManager;	 Catch:{ RemoteException -> 0x0067 }
        r7 = 0;
        r3.clearApplicationUserData(r13, r2, r7);	 Catch:{ RemoteException -> 0x0067 }
    L_0x0041:
        r8 = java.lang.System.currentTimeMillis();	 Catch:{ all -> 0x0062 }
        r10 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r4 = r8 + r10;
    L_0x0049:
        r3 = r12.mClearingData;	 Catch:{ all -> 0x0062 }
        if (r3 == 0) goto L_0x0065;
    L_0x004d:
        r8 = java.lang.System.currentTimeMillis();	 Catch:{ all -> 0x0062 }
        r3 = (r8 > r4 ? 1 : (r8 == r4 ? 0 : -1));
        if (r3 >= 0) goto L_0x0065;
    L_0x0055:
        r3 = r12.mClearDataLock;	 Catch:{ InterruptedException -> 0x005d }
        r8 = 5000; // 0x1388 float:7.006E-42 double:2.4703E-320;
        r3.wait(r8);	 Catch:{ InterruptedException -> 0x005d }
        goto L_0x0049;
    L_0x005d:
        r0 = move-exception;
        r3 = 0;
        r12.mClearingData = r3;	 Catch:{ all -> 0x0062 }
        goto L_0x0049;
    L_0x0062:
        r3 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x0062 }
        throw r3;
    L_0x0065:
        monitor-exit(r6);	 Catch:{ all -> 0x0062 }
        goto L_0x000f;
    L_0x0067:
        r3 = move-exception;
        goto L_0x0041;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.clearApplicationDataSynchronous(java.lang.String):void");
    }

    long getAvailableRestoreToken(String packageName) {
        long token = this.mAncestralToken;
        synchronized (this.mQueueLock) {
            if (this.mEverStoredApps.contains(packageName)) {
                token = this.mCurrentToken;
            }
        }
        return token;
    }

    void prepareOperationTimeout(int token, long interval, BackupRestoreTask callback) {
        synchronized (this.mCurrentOpLock) {
            this.mCurrentOperations.put(token, new Operation(OP_PENDING, callback));
            this.mBackupHandler.sendMessageDelayed(this.mBackupHandler.obtainMessage(MSG_TIMEOUT, token, OP_PENDING, callback), interval);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    boolean waitUntilOperationComplete(int r7) {
        /*
        r6 = this;
        r4 = 1;
        r1 = 0;
        r2 = 0;
        r5 = r6.mCurrentOpLock;
        monitor-enter(r5);
    L_0x0006:
        r3 = r6.mCurrentOperations;	 Catch:{ all -> 0x002c }
        r3 = r3.get(r7);	 Catch:{ all -> 0x002c }
        r0 = r3;
        r0 = (com.android.server.backup.BackupManagerService.Operation) r0;	 Catch:{ all -> 0x002c }
        r2 = r0;
        if (r2 != 0) goto L_0x001d;
    L_0x0012:
        monitor-exit(r5);	 Catch:{ all -> 0x002c }
        r3 = r6.mBackupHandler;
        r5 = 7;
        r3.removeMessages(r5);
        if (r1 != r4) goto L_0x002f;
    L_0x001b:
        r3 = r4;
    L_0x001c:
        return r3;
    L_0x001d:
        r3 = r2.state;	 Catch:{ all -> 0x002c }
        if (r3 != 0) goto L_0x0029;
    L_0x0021:
        r3 = r6.mCurrentOpLock;	 Catch:{ InterruptedException -> 0x0027 }
        r3.wait();	 Catch:{ InterruptedException -> 0x0027 }
        goto L_0x0006;
    L_0x0027:
        r3 = move-exception;
        goto L_0x0006;
    L_0x0029:
        r1 = r2.state;	 Catch:{ all -> 0x002c }
        goto L_0x0012;
    L_0x002c:
        r3 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x002c }
        throw r3;
    L_0x002f:
        r3 = 0;
        goto L_0x001c;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.waitUntilOperationComplete(int):boolean");
    }

    void handleTimeout(int token, Object obj) {
        int state = OP_TIMEOUT;
        synchronized (this.mCurrentOpLock) {
            Operation op = (Operation) this.mCurrentOperations.get(token);
            if (op != null) {
                state = op.state;
            }
            if (state == 0) {
                Slog.v(TAG, "TIMEOUT: token=" + Integer.toHexString(token));
                op.state = OP_TIMEOUT;
                this.mCurrentOperations.put(token, op);
            }
            this.mCurrentOpLock.notifyAll();
        }
        if (op != null && op.callback != null) {
            op.callback.handleTimeout();
        }
    }

    private void routeSocketDataToOutput(ParcelFileDescriptor inPipe, OutputStream out) throws IOException {
        DataInputStream in = new DataInputStream(new FileInputStream(inPipe.getFileDescriptor()));
        byte[] buffer = new byte[32768];
        while (true) {
            int chunkTotal = in.readInt();
            if (chunkTotal > 0) {
                while (chunkTotal > 0) {
                    int toRead;
                    if (chunkTotal > buffer.length) {
                        toRead = buffer.length;
                    } else {
                        toRead = chunkTotal;
                    }
                    int nRead = in.read(buffer, OP_PENDING, toRead);
                    out.write(buffer, OP_PENDING, nRead);
                    chunkTotal -= nRead;
                }
            } else {
                return;
            }
        }
    }

    boolean deviceIsEncrypted() {
        try {
            return (this.mMountService.getEncryptionState() == SCHEDULE_FILE_VERSION || this.mMountService.getPasswordType() == SCHEDULE_FILE_VERSION) ? MORE_DEBUG : DEBUG_SCHEDULING;
        } catch (Exception e) {
            Slog.e(TAG, "Unable to communicate with mount service: " + e.getMessage());
            return DEBUG_SCHEDULING;
        }
    }

    void scheduleNextFullBackupJob() {
        synchronized (this.mQueueLock) {
            if (this.mFullBackupQueue.size() > 0) {
                long timeSinceLast = System.currentTimeMillis() - ((FullBackupEntry) this.mFullBackupQueue.get(OP_PENDING)).lastBackup;
                this.mBackupHandler.postDelayed(new C01583(timeSinceLast < MIN_FULL_BACKUP_INTERVAL ? MIN_FULL_BACKUP_INTERVAL - timeSinceLast : 0), 2500);
            } else {
                Slog.i(TAG, "Full backup queue empty; not scheduling");
            }
        }
    }

    void enqueueFullBackup(String packageName, long lastBackedUp) {
        FullBackupEntry newEntry = new FullBackupEntry(packageName, lastBackedUp);
        synchronized (this.mQueueLock) {
            for (int i = this.mFullBackupQueue.size() + OP_TIMEOUT; i >= 0; i += OP_TIMEOUT) {
                if (packageName.equals(((FullBackupEntry) this.mFullBackupQueue.get(i)).packageName)) {
                    Slog.w(TAG, "Removing schedule queue dupe of " + packageName);
                    this.mFullBackupQueue.remove(i);
                }
            }
            int which = this.mFullBackupQueue.size() + OP_TIMEOUT;
            while (which >= 0) {
                if (((FullBackupEntry) this.mFullBackupQueue.get(which)).lastBackup <= lastBackedUp) {
                    this.mFullBackupQueue.add(which + SCHEDULE_FILE_VERSION, newEntry);
                    break;
                }
                which += OP_TIMEOUT;
            }
            if (which < 0) {
                this.mFullBackupQueue.add(OP_PENDING, newEntry);
            }
        }
        writeFullBackupScheduleAsync();
    }

    boolean beginFullBackup(FullBackupJob scheduledJob) {
        long now = System.currentTimeMillis();
        if (!this.mEnabled || !this.mProvisioned) {
            return MORE_DEBUG;
        }
        Slog.i(TAG, "Beginning scheduled full backup operation");
        synchronized (this.mQueueLock) {
            if (this.mRunningFullBackupTask != null) {
                Slog.e(TAG, "Backup triggered but one already/still running!");
                return MORE_DEBUG;
            } else if (this.mFullBackupQueue.size() == 0) {
                Slog.i(TAG, "Backup queue empty; doing nothing");
                return MORE_DEBUG;
            } else {
                FullBackupEntry entry = (FullBackupEntry) this.mFullBackupQueue.get(OP_PENDING);
                long timeSinceRun = now - entry.lastBackup;
                if (timeSinceRun < MIN_FULL_BACKUP_INTERVAL) {
                    this.mBackupHandler.post(new C01594(MIN_FULL_BACKUP_INTERVAL - timeSinceRun));
                    return MORE_DEBUG;
                }
                this.mFullBackupQueue.remove(OP_PENDING);
                AtomicBoolean latch = new AtomicBoolean(MORE_DEBUG);
                String[] pkg = new String[SCHEDULE_FILE_VERSION];
                pkg[OP_PENDING] = entry.packageName;
                this.mRunningFullBackupTask = new PerformFullTransportBackupTask(null, pkg, DEBUG_SCHEDULING, scheduledJob, latch);
                new Thread(this.mRunningFullBackupTask).start();
                return DEBUG_SCHEDULING;
            }
        }
    }

    void endFullBackup() {
        synchronized (this.mQueueLock) {
            if (this.mRunningFullBackupTask != null) {
                Slog.i(TAG, "Telling running backup to stop");
                this.mRunningFullBackupTask.setRunning(MORE_DEBUG);
            }
        }
    }

    static boolean signaturesMatch(ArrayList<byte[]> storedSigHashes, PackageInfo target) {
        if (target == null) {
            return MORE_DEBUG;
        }
        if ((target.applicationInfo.flags & SCHEDULE_FILE_VERSION) != 0) {
            Slog.v(TAG, "System app " + target.packageName + " - skipping sig check");
            return DEBUG_SCHEDULING;
        }
        Signature[] deviceSigs = target.signatures;
        if ((storedSigHashes == null || storedSigHashes.size() == 0) && (deviceSigs == null || deviceSigs.length == 0)) {
            return DEBUG_SCHEDULING;
        }
        if (storedSigHashes == null || deviceSigs == null) {
            return MORE_DEBUG;
        }
        int i;
        int nStored = storedSigHashes.size();
        int nDevice = deviceSigs.length;
        ArrayList<byte[]> deviceHashes = new ArrayList(nDevice);
        for (i = OP_PENDING; i < nDevice; i += SCHEDULE_FILE_VERSION) {
            deviceHashes.add(hashSignature(deviceSigs[i]));
        }
        for (int n = OP_PENDING; n < nStored; n += SCHEDULE_FILE_VERSION) {
            boolean match = MORE_DEBUG;
            byte[] storedHash = (byte[]) storedSigHashes.get(n);
            for (i = OP_PENDING; i < nDevice; i += SCHEDULE_FILE_VERSION) {
                if (Arrays.equals(storedHash, (byte[]) deviceHashes.get(i))) {
                    match = DEBUG_SCHEDULING;
                    break;
                }
            }
            if (!match) {
                return MORE_DEBUG;
            }
        }
        return DEBUG_SCHEDULING;
    }

    static byte[] hashSignature(Signature sig) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            digest.update(sig.toByteArray());
            return digest.digest();
        } catch (NoSuchAlgorithmException e) {
            Slog.w(TAG, "No SHA-256 algorithm found!");
            return null;
        }
    }

    static boolean signaturesMatch(Signature[] storedSigs, PackageInfo target) {
        if (target == null) {
            return MORE_DEBUG;
        }
        if ((target.applicationInfo.flags & SCHEDULE_FILE_VERSION) != 0) {
            Slog.v(TAG, "System app " + target.packageName + " - skipping sig check");
            return DEBUG_SCHEDULING;
        }
        Signature[] deviceSigs = target.signatures;
        if ((storedSigs == null || storedSigs.length == 0) && (deviceSigs == null || deviceSigs.length == 0)) {
            return DEBUG_SCHEDULING;
        }
        if (storedSigs == null || deviceSigs == null) {
            return MORE_DEBUG;
        }
        int nStored = storedSigs.length;
        int nDevice = deviceSigs.length;
        for (int i = OP_PENDING; i < nStored; i += SCHEDULE_FILE_VERSION) {
            boolean match = MORE_DEBUG;
            for (int j = OP_PENDING; j < nDevice; j += SCHEDULE_FILE_VERSION) {
                if (storedSigs[i].equals(deviceSigs[j])) {
                    match = DEBUG_SCHEDULING;
                    break;
                }
            }
            if (!match) {
                return MORE_DEBUG;
            }
        }
        return DEBUG_SCHEDULING;
    }

    void restoreWidgetData(String packageName, byte[] widgetData) {
        AppWidgetBackupBridge.restoreWidgetState(packageName, widgetData, OP_PENDING);
    }

    private void dataChangedImpl(String packageName) {
        dataChangedImpl(packageName, dataChangedTargets(packageName));
    }

    private void dataChangedImpl(String packageName, HashSet<String> targets) {
        if (targets == null) {
            Slog.w(TAG, "dataChanged but no participant pkg='" + packageName + "'" + " uid=" + Binder.getCallingUid());
            return;
        }
        synchronized (this.mQueueLock) {
            if (targets.contains(packageName)) {
                if (this.mPendingBackups.put(packageName, new BackupRequest(packageName)) == null) {
                    Slog.d(TAG, "Now staging backup of " + packageName);
                    writeToJournalLocked(packageName);
                }
            }
        }
    }

    private HashSet<String> dataChangedTargets(String packageName) {
        if (this.mContext.checkPermission("android.permission.BACKUP", Binder.getCallingPid(), Binder.getCallingUid()) == OP_TIMEOUT) {
            HashSet<String> hashSet;
            synchronized (this.mBackupParticipants) {
                hashSet = (HashSet) this.mBackupParticipants.get(Binder.getCallingUid());
            }
            return hashSet;
        }
        HashSet<String> targets = new HashSet();
        synchronized (this.mBackupParticipants) {
            int N = this.mBackupParticipants.size();
            for (int i = OP_PENDING; i < N; i += SCHEDULE_FILE_VERSION) {
                HashSet<String> s = (HashSet) this.mBackupParticipants.valueAt(i);
                if (s != null) {
                    targets.addAll(s);
                }
            }
        }
        return targets;
    }

    private void writeToJournalLocked(String str) {
        IOException e;
        Throwable th;
        RandomAccessFile out = null;
        try {
            if (this.mJournal == null) {
                this.mJournal = File.createTempFile("journal", null, this.mJournalDir);
            }
            RandomAccessFile out2 = new RandomAccessFile(this.mJournal, "rws");
            try {
                out2.seek(out2.length());
                out2.writeUTF(str);
                if (out2 != null) {
                    try {
                        out2.close();
                    } catch (IOException e2) {
                        out = out2;
                        return;
                    }
                }
                out = out2;
            } catch (IOException e3) {
                e = e3;
                out = out2;
                try {
                    Slog.e(TAG, "Can't write " + str + " to backup journal", e);
                    this.mJournal = null;
                    if (out != null) {
                        try {
                            out.close();
                        } catch (IOException e4) {
                        }
                    }
                } catch (Throwable th2) {
                    th = th2;
                    if (out != null) {
                        try {
                            out.close();
                        } catch (IOException e5) {
                        }
                    }
                    throw th;
                }
            } catch (Throwable th3) {
                th = th3;
                out = out2;
                if (out != null) {
                    out.close();
                }
                throw th;
            }
        } catch (IOException e6) {
            e = e6;
            Slog.e(TAG, "Can't write " + str + " to backup journal", e);
            this.mJournal = null;
            if (out != null) {
                out.close();
            }
        }
    }

    public void dataChanged(String packageName) {
        if (UserHandle.getCallingUserId() == 0) {
            HashSet<String> targets = dataChangedTargets(packageName);
            if (targets == null) {
                Slog.w(TAG, "dataChanged but no participant pkg='" + packageName + "'" + " uid=" + Binder.getCallingUid());
            } else {
                this.mBackupHandler.post(new C01605(packageName, targets));
            }
        }
    }

    public void clearBackupData(String transportName, String packageName) {
        Slog.v(TAG, "clearBackupData() of " + packageName + " on " + transportName);
        try {
            HashSet<String> apps;
            PackageInfo info = this.mPackageManager.getPackageInfo(packageName, 64);
            if (this.mContext.checkPermission("android.permission.BACKUP", Binder.getCallingPid(), Binder.getCallingUid()) == OP_TIMEOUT) {
                apps = (HashSet) this.mBackupParticipants.get(Binder.getCallingUid());
            } else {
                Slog.v(TAG, "Privileged caller, allowing clear of other apps");
                apps = new HashSet();
                int N = this.mBackupParticipants.size();
                for (int i = OP_PENDING; i < N; i += SCHEDULE_FILE_VERSION) {
                    HashSet<String> s = (HashSet) this.mBackupParticipants.valueAt(i);
                    if (s != null) {
                        apps.addAll(s);
                    }
                }
            }
            if (apps.contains(packageName)) {
                Slog.v(TAG, "Found the app - running clear process");
                this.mBackupHandler.removeMessages(MSG_RETRY_CLEAR);
                synchronized (this.mQueueLock) {
                    IBackupTransport transport = getTransport(transportName);
                    if (transport == null) {
                        this.mBackupHandler.sendMessageDelayed(this.mBackupHandler.obtainMessage(MSG_RETRY_CLEAR, new ClearRetryParams(transportName, packageName)), TRANSPORT_RETRY_INTERVAL);
                        return;
                    }
                    long oldId = Binder.clearCallingIdentity();
                    this.mWakelock.acquire();
                    this.mBackupHandler.sendMessage(this.mBackupHandler.obtainMessage(MSG_RUN_CLEAR, new ClearParams(transport, info)));
                    Binder.restoreCallingIdentity(oldId);
                }
            }
        } catch (NameNotFoundException e) {
            Slog.d(TAG, "No such package '" + packageName + "' - not clearing backup data");
        }
    }

    public void backupNow() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "backupNow");
        Slog.v(TAG, "Scheduling immediate backup pass");
        synchronized (this.mQueueLock) {
            startBackupAlarmsLocked(TRANSPORT_RETRY_INTERVAL);
            try {
                this.mRunBackupIntent.send();
            } catch (CanceledException e) {
                Slog.e(TAG, "run-backup intent cancelled!");
            }
        }
    }

    boolean deviceIsProvisioned() {
        if (Global.getInt(this.mContext.getContentResolver(), "device_provisioned", OP_PENDING) != 0) {
            return DEBUG_SCHEDULING;
        }
        return MORE_DEBUG;
    }

    public void fullTransportBackup(String[] pkgNames) {
        this.mContext.enforceCallingPermission("android.permission.BACKUP", "fullTransportBackup");
        if (UserHandle.getCallingUserId() != 0) {
            throw new IllegalStateException("Restore supported only for the device owner");
        }
        Slog.d(TAG, "fullTransportBackup()");
        AtomicBoolean latch = new AtomicBoolean(MORE_DEBUG);
        new Thread(new PerformFullTransportBackupTask(null, pkgNames, MORE_DEBUG, null, latch), "full-transport-master").start();
        synchronized (latch) {
            while (!latch.get()) {
                try {
                    latch.wait();
                } catch (InterruptedException e) {
                }
            }
        }
        Slog.d(TAG, "Done with full transport backup.");
    }

    boolean startConfirmationUi(int token, String action) {
        try {
            Intent confIntent = new Intent(action);
            confIntent.setClassName("com.android.backupconfirm", "com.android.backupconfirm.BackupRestoreConfirmation");
            confIntent.putExtra("conftoken", token);
            confIntent.addFlags(268435456);
            this.mContext.startActivity(confIntent);
            return DEBUG_SCHEDULING;
        } catch (ActivityNotFoundException e) {
            return MORE_DEBUG;
        }
    }

    void startConfirmationTimeout(int token, FullParams params) {
        this.mBackupHandler.sendMessageDelayed(this.mBackupHandler.obtainMessage(MSG_FULL_CONFIRMATION_TIMEOUT, token, OP_PENDING, params), TIMEOUT_RESTORE_INTERVAL);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void waitForCompletion(com.android.server.backup.BackupManagerService.FullParams r3) {
        /*
        r2 = this;
        r1 = r3.latch;
        monitor-enter(r1);
    L_0x0003:
        r0 = r3.latch;	 Catch:{ all -> 0x0015 }
        r0 = r0.get();	 Catch:{ all -> 0x0015 }
        if (r0 != 0) goto L_0x0013;
    L_0x000b:
        r0 = r3.latch;	 Catch:{ InterruptedException -> 0x0011 }
        r0.wait();	 Catch:{ InterruptedException -> 0x0011 }
        goto L_0x0003;
    L_0x0011:
        r0 = move-exception;
        goto L_0x0003;
    L_0x0013:
        monitor-exit(r1);	 Catch:{ all -> 0x0015 }
        return;
    L_0x0015:
        r0 = move-exception;
        monitor-exit(r1);	 Catch:{ all -> 0x0015 }
        throw r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.waitForCompletion(com.android.server.backup.BackupManagerService$FullParams):void");
    }

    void signalFullBackupRestoreCompletion(FullParams params) {
        synchronized (params.latch) {
            params.latch.set(DEBUG_SCHEDULING);
            params.latch.notifyAll();
        }
    }

    public void acknowledgeFullBackupOrRestore(int token, boolean allow, String curPassword, String encPpassword, IFullBackupRestoreObserver observer) {
        Slog.d(TAG, "acknowledgeFullBackupOrRestore : token=" + token + " allow=" + allow);
        this.mContext.enforceCallingPermission("android.permission.BACKUP", "acknowledgeFullBackupOrRestore");
        long oldId = Binder.clearCallingIdentity();
        try {
            synchronized (this.mFullConfirmations) {
                FullParams params = (FullParams) this.mFullConfirmations.get(token);
                if (params != null) {
                    this.mBackupHandler.removeMessages(MSG_FULL_CONFIRMATION_TIMEOUT, params);
                    this.mFullConfirmations.delete(token);
                    if (allow) {
                        int verb = params instanceof FullBackupParams ? MSG_RUN_ADB_BACKUP : MSG_RUN_ADB_RESTORE;
                        params.observer = observer;
                        params.curPassword = curPassword;
                        params.encryptPassword = encPpassword;
                        Slog.d(TAG, "Sending conf message with verb " + verb);
                        this.mWakelock.acquire();
                        this.mBackupHandler.sendMessage(this.mBackupHandler.obtainMessage(verb, params));
                    } else {
                        Slog.w(TAG, "User rejected full backup/restore operation");
                        signalFullBackupRestoreCompletion(params);
                    }
                } else {
                    Slog.w(TAG, "Attempted to ack full backup/restore with invalid token");
                }
            }
        } finally {
            Binder.restoreCallingIdentity(oldId);
        }
    }

    public void setBackupEnabled(boolean enable) {
        int i = SCHEDULE_FILE_VERSION;
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "setBackupEnabled");
        Slog.i(TAG, "Backup enabled => " + enable);
        long oldId = Binder.clearCallingIdentity();
        try {
            boolean wasEnabled = this.mEnabled;
            synchronized (this) {
                ContentResolver contentResolver = this.mContext.getContentResolver();
                String str = "backup_enabled";
                if (!enable) {
                    i = OP_PENDING;
                }
                Secure.putInt(contentResolver, str, i);
                this.mEnabled = enable;
            }
            synchronized (this.mQueueLock) {
                if (enable && !wasEnabled) {
                    if (this.mProvisioned) {
                        startBackupAlarmsLocked(TRANSPORT_RETRY_INTERVAL);
                        scheduleNextFullBackupJob();
                    }
                }
                if (!enable) {
                    Slog.i(TAG, "Opting out of backup");
                    this.mAlarmManager.cancel(this.mRunBackupIntent);
                    if (wasEnabled && this.mProvisioned) {
                        HashSet<String> allTransports;
                        synchronized (this.mTransports) {
                            allTransports = new HashSet(this.mTransports.keySet());
                        }
                        Iterator i$ = allTransports.iterator();
                        while (i$.hasNext()) {
                            recordInitPendingLocked(DEBUG_SCHEDULING, (String) i$.next());
                        }
                        this.mAlarmManager.set(OP_PENDING, System.currentTimeMillis(), this.mRunInitIntent);
                    }
                }
            }
            Binder.restoreCallingIdentity(oldId);
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(oldId);
        }
    }

    public void setAutoRestore(boolean doAutoRestore) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "setAutoRestore");
        Slog.i(TAG, "Auto restore => " + doAutoRestore);
        long oldId = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                Secure.putInt(this.mContext.getContentResolver(), "backup_auto_restore", doAutoRestore ? SCHEDULE_FILE_VERSION : OP_PENDING);
                this.mAutoRestore = doAutoRestore;
            }
        } finally {
            Binder.restoreCallingIdentity(oldId);
        }
    }

    public void setBackupProvisioned(boolean available) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "setBackupProvisioned");
    }

    private void startBackupAlarmsLocked(long delayBeforeFirstBackup) {
        Random random = new Random();
        long when = (System.currentTimeMillis() + delayBeforeFirstBackup) + ((long) random.nextInt(FUZZ_MILLIS));
        this.mAlarmManager.setRepeating(OP_PENDING, when, TRANSPORT_RETRY_INTERVAL + ((long) random.nextInt(FUZZ_MILLIS)), this.mRunBackupIntent);
        this.mNextBackupPass = when;
    }

    public boolean isBackupEnabled() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "isBackupEnabled");
        return this.mEnabled;
    }

    public String getCurrentTransport() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "getCurrentTransport");
        return this.mCurrentTransport;
    }

    public String[] listAllTransports() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "listAllTransports");
        ArrayList<String> known = new ArrayList();
        for (Entry<String, IBackupTransport> entry : this.mTransports.entrySet()) {
            if (entry.getValue() != null) {
                known.add(entry.getKey());
            }
        }
        if (known.size() <= 0) {
            return null;
        }
        String[] list = new String[known.size()];
        known.toArray(list);
        return list;
    }

    public String selectBackupTransport(String transport) {
        String prevTransport;
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "selectBackupTransport");
        synchronized (this.mTransports) {
            long oldId = Binder.clearCallingIdentity();
            try {
                prevTransport = this.mCurrentTransport;
                this.mCurrentTransport = transport;
                Secure.putString(this.mContext.getContentResolver(), "backup_transport", transport);
                Slog.v(TAG, "selectBackupTransport() set " + this.mCurrentTransport + " returning " + prevTransport);
                Binder.restoreCallingIdentity(oldId);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(oldId);
            }
        }
        return prevTransport;
    }

    public Intent getConfigurationIntent(String transportName) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "getConfigurationIntent");
        synchronized (this.mTransports) {
            IBackupTransport transport = (IBackupTransport) this.mTransports.get(transportName);
            if (transport != null) {
                try {
                    Intent intent = transport.configurationIntent();
                    return intent;
                } catch (RemoteException e) {
                }
            }
            return null;
        }
    }

    public String getDestinationString(String transportName) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "getDestinationString");
        synchronized (this.mTransports) {
            IBackupTransport transport = (IBackupTransport) this.mTransports.get(transportName);
            if (transport != null) {
                try {
                    String text = transport.currentDestinationString();
                    return text;
                } catch (RemoteException e) {
                }
            }
            return null;
        }
    }

    public Intent getDataManagementIntent(String transportName) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "getDataManagementIntent");
        synchronized (this.mTransports) {
            IBackupTransport transport = (IBackupTransport) this.mTransports.get(transportName);
            if (transport != null) {
                try {
                    Intent intent = transport.dataManagementIntent();
                    return intent;
                } catch (RemoteException e) {
                }
            }
            return null;
        }
    }

    public String getDataManagementLabel(String transportName) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "getDataManagementLabel");
        synchronized (this.mTransports) {
            IBackupTransport transport = (IBackupTransport) this.mTransports.get(transportName);
            if (transport != null) {
                try {
                    String text = transport.dataManagementLabel();
                    return text;
                } catch (RemoteException e) {
                }
            }
            return null;
        }
    }

    public void agentConnected(String packageName, IBinder agentBinder) {
        synchronized (this.mAgentConnectLock) {
            if (Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                Slog.d(TAG, "agentConnected pkg=" + packageName + " agent=" + agentBinder);
                this.mConnectedAgent = IBackupAgent.Stub.asInterface(agentBinder);
                this.mConnecting = MORE_DEBUG;
            } else {
                Slog.w(TAG, "Non-system process uid=" + Binder.getCallingUid() + " claiming agent connected");
            }
            this.mAgentConnectLock.notifyAll();
        }
    }

    public void agentDisconnected(String packageName) {
        synchronized (this.mAgentConnectLock) {
            if (Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                this.mConnectedAgent = null;
                this.mConnecting = MORE_DEBUG;
            } else {
                Slog.w(TAG, "Non-system process uid=" + Binder.getCallingUid() + " claiming agent disconnected");
            }
            this.mAgentConnectLock.notifyAll();
        }
    }

    public void restoreAtInstall(String packageName, int token) {
        if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            Slog.w(TAG, "Non-system process uid=" + Binder.getCallingUid() + " attemping install-time restore");
            return;
        }
        boolean skip = MORE_DEBUG;
        long restoreSet = getAvailableRestoreToken(packageName);
        Slog.v(TAG, "restoreAtInstall pkg=" + packageName + " token=" + Integer.toHexString(token) + " restoreSet=" + Long.toHexString(restoreSet));
        if (restoreSet == 0) {
            skip = DEBUG_SCHEDULING;
        }
        IBackupTransport transport = getTransport(this.mCurrentTransport);
        if (transport == null) {
            Slog.w(TAG, "No transport");
            skip = DEBUG_SCHEDULING;
        }
        if (!this.mAutoRestore) {
            Slog.w(TAG, "Non-restorable state: auto=" + this.mAutoRestore);
            skip = DEBUG_SCHEDULING;
        }
        if (!skip) {
            try {
                String dirName = transport.transportDirName();
                PackageInfo pkg = new PackageInfo();
                pkg.packageName = packageName;
                this.mWakelock.acquire();
                Message msg = this.mBackupHandler.obtainMessage(MSG_RUN_RESTORE);
                msg.obj = new RestoreParams(transport, dirName, null, restoreSet, pkg, token);
                this.mBackupHandler.sendMessage(msg);
            } catch (RemoteException e) {
                Slog.e(TAG, "Unable to contact transport");
                skip = DEBUG_SCHEDULING;
            }
        }
        if (skip) {
            Slog.v(TAG, "Finishing install immediately");
            try {
                this.mPackageManagerBinder.finishPackageInstall(token);
            } catch (RemoteException e2) {
            }
        }
    }

    public IRestoreSession beginRestoreSession(String packageName, String transport) {
        Slog.v(TAG, "beginRestoreSession: pkg=" + packageName + " transport=" + transport);
        boolean needPermission = DEBUG_SCHEDULING;
        if (transport == null) {
            transport = this.mCurrentTransport;
            if (packageName != null) {
                try {
                    if (this.mPackageManager.getPackageInfo(packageName, OP_PENDING).applicationInfo.uid == Binder.getCallingUid()) {
                        needPermission = MORE_DEBUG;
                    }
                } catch (NameNotFoundException e) {
                    Slog.w(TAG, "Asked to restore nonexistent pkg " + packageName);
                    throw new IllegalArgumentException("Package " + packageName + " not found");
                }
            }
        }
        if (needPermission) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.BACKUP", "beginRestoreSession");
        } else {
            Slog.d(TAG, "restoring self on current transport; no permission needed");
        }
        synchronized (this) {
            if (this.mActiveRestoreSession != null) {
                Slog.d(TAG, "Restore session requested but one already active");
                return null;
            }
            this.mActiveRestoreSession = new ActiveRestoreSession(packageName, transport);
            this.mBackupHandler.sendEmptyMessageDelayed(MSG_RESTORE_TIMEOUT, TIMEOUT_RESTORE_INTERVAL);
            return this.mActiveRestoreSession;
        }
    }

    void clearRestoreSession(ActiveRestoreSession currentSession) {
        synchronized (this) {
            if (currentSession != this.mActiveRestoreSession) {
                Slog.e(TAG, "ending non-current restore session");
            } else {
                Slog.v(TAG, "Clearing restore session and halting timeout");
                this.mActiveRestoreSession = null;
                this.mBackupHandler.removeMessages(MSG_RESTORE_TIMEOUT);
            }
        }
    }

    public void opComplete(int token) {
        synchronized (this.mCurrentOpLock) {
            Operation op = (Operation) this.mCurrentOperations.get(token);
            if (op != null) {
                op.state = SCHEDULE_FILE_VERSION;
            }
            this.mCurrentOpLock.notifyAll();
        }
        if (op != null && op.callback != null) {
            this.mBackupHandler.sendMessage(this.mBackupHandler.obtainMessage(MSG_OP_COMPLETE, op.callback));
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DUMP", TAG);
        long identityToken = Binder.clearCallingIdentity();
        if (args != null) {
            String[] arr$ = args;
            int len$ = arr$.length;
            int i$ = OP_PENDING;
            while (i$ < len$) {
                String arg = arr$[i$];
                if ("-h".equals(arg)) {
                    pw.println("'dumpsys backup' optional arguments:");
                    pw.println("  -h       : this help text");
                    pw.println("  a[gents] : dump information about defined backup agents");
                    Binder.restoreCallingIdentity(identityToken);
                    return;
                }
                try {
                    if ("agents".startsWith(arg)) {
                        dumpAgents(pw);
                        return;
                    }
                    i$ += SCHEDULE_FILE_VERSION;
                } finally {
                    Binder.restoreCallingIdentity(identityToken);
                }
            }
        }
        dumpInternal(pw);
        Binder.restoreCallingIdentity(identityToken);
    }

    private void dumpAgents(PrintWriter pw) {
        List<PackageInfo> agentPackages = allAgentPackages();
        pw.println("Defined backup agents:");
        for (PackageInfo pkg : agentPackages) {
            pw.print("  ");
            pw.print(pkg.packageName);
            pw.println(':');
            pw.print("      ");
            pw.println(pkg.applicationInfo.backupAgentName);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void dumpInternal(java.io.PrintWriter r31) {
        /*
        r30 = this;
        r0 = r30;
        r0 = r0.mQueueLock;
        r26 = r0;
        monitor-enter(r26);
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "Backup Manager is ";
        r0 = r25;
        r1 = r27;
        r27 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mEnabled;	 Catch:{ all -> 0x02da }
        r25 = r0;
        if (r25 == 0) goto L_0x0230;
    L_0x001e:
        r25 = "enabled";
    L_0x0020:
        r0 = r27;
        r1 = r25;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r27 = " / ";
        r0 = r25;
        r1 = r27;
        r27 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mProvisioned;	 Catch:{ all -> 0x02da }
        r25 = r0;
        if (r25 != 0) goto L_0x0234;
    L_0x003a:
        r25 = "not ";
    L_0x003c:
        r0 = r27;
        r1 = r25;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r27 = "provisioned / ";
        r0 = r25;
        r1 = r27;
        r27 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mPendingInits;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r25 = r25.size();	 Catch:{ all -> 0x02da }
        if (r25 != 0) goto L_0x0238;
    L_0x005a:
        r25 = "not ";
    L_0x005c:
        r0 = r27;
        r1 = r25;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r27 = "pending init";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "Auto-restore is ";
        r0 = r25;
        r1 = r27;
        r27 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mAutoRestore;	 Catch:{ all -> 0x02da }
        r25 = r0;
        if (r25 == 0) goto L_0x023c;
    L_0x0090:
        r25 = "enabled";
    L_0x0092:
        r0 = r27;
        r1 = r25;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mBackupRunning;	 Catch:{ all -> 0x02da }
        r25 = r0;
        if (r25 == 0) goto L_0x00b6;
    L_0x00ad:
        r25 = "Backup currently running";
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
    L_0x00b6:
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "Last backup pass started: ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mLastBackupPass;	 Catch:{ all -> 0x02da }
        r28 = r0;
        r0 = r25;
        r1 = r28;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r27 = " (now = ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r28 = java.lang.System.currentTimeMillis();	 Catch:{ all -> 0x02da }
        r0 = r25;
        r1 = r28;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r27 = 41;
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "  next scheduled: ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mNextBackupPass;	 Catch:{ all -> 0x02da }
        r28 = r0;
        r0 = r25;
        r1 = r28;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r25 = "Available transports:";
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r23 = r30.listAllTransports();	 Catch:{ all -> 0x02da }
        if (r23 == 0) goto L_0x0275;
    L_0x0135:
        r6 = r30.listAllTransports();	 Catch:{ all -> 0x02da }
        r15 = r6.length;	 Catch:{ all -> 0x02da }
        r13 = 0;
        r14 = r13;
    L_0x013c:
        if (r14 >= r15) goto L_0x0275;
    L_0x013e:
        r21 = r6[r14];	 Catch:{ all -> 0x02da }
        r27 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r27.<init>();	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mCurrentTransport;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r0 = r21;
        r1 = r25;
        r25 = r0.equals(r1);	 Catch:{ all -> 0x02da }
        if (r25 == 0) goto L_0x0240;
    L_0x0155:
        r25 = "  * ";
    L_0x0157:
        r0 = r27;
        r1 = r25;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r25;
        r1 = r21;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r1 = r21;
        r22 = r0.getTransport(r1);	 Catch:{ Exception -> 0x0244 }
        r8 = new java.io.File;	 Catch:{ Exception -> 0x0244 }
        r0 = r30;
        r0 = r0.mBaseStateDir;	 Catch:{ Exception -> 0x0244 }
        r25 = r0;
        r27 = r22.transportDirName();	 Catch:{ Exception -> 0x0244 }
        r0 = r25;
        r1 = r27;
        r8.<init>(r0, r1);	 Catch:{ Exception -> 0x0244 }
        r25 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x0244 }
        r25.<init>();	 Catch:{ Exception -> 0x0244 }
        r27 = "       destination: ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ Exception -> 0x0244 }
        r27 = r22.currentDestinationString();	 Catch:{ Exception -> 0x0244 }
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ Exception -> 0x0244 }
        r25 = r25.toString();	 Catch:{ Exception -> 0x0244 }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ Exception -> 0x0244 }
        r25 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x0244 }
        r25.<init>();	 Catch:{ Exception -> 0x0244 }
        r27 = "       intent: ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ Exception -> 0x0244 }
        r27 = r22.configurationIntent();	 Catch:{ Exception -> 0x0244 }
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ Exception -> 0x0244 }
        r25 = r25.toString();	 Catch:{ Exception -> 0x0244 }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ Exception -> 0x0244 }
        r7 = r8.listFiles();	 Catch:{ Exception -> 0x0244 }
        r0 = r7.length;	 Catch:{ Exception -> 0x0244 }
        r16 = r0;
        r13 = 0;
    L_0x01e1:
        r0 = r16;
        if (r13 >= r0) goto L_0x0270;
    L_0x01e5:
        r11 = r7[r13];	 Catch:{ Exception -> 0x0244 }
        r25 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x0244 }
        r25.<init>();	 Catch:{ Exception -> 0x0244 }
        r27 = "       ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ Exception -> 0x0244 }
        r27 = r11.getName();	 Catch:{ Exception -> 0x0244 }
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ Exception -> 0x0244 }
        r27 = " - ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ Exception -> 0x0244 }
        r28 = r11.length();	 Catch:{ Exception -> 0x0244 }
        r0 = r25;
        r1 = r28;
        r25 = r0.append(r1);	 Catch:{ Exception -> 0x0244 }
        r27 = " state bytes";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ Exception -> 0x0244 }
        r25 = r25.toString();	 Catch:{ Exception -> 0x0244 }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ Exception -> 0x0244 }
        r13 = r13 + 1;
        goto L_0x01e1;
    L_0x0230:
        r25 = "disabled";
        goto L_0x0020;
    L_0x0234:
        r25 = "";
        goto L_0x003c;
    L_0x0238:
        r25 = "";
        goto L_0x005c;
    L_0x023c:
        r25 = "disabled";
        goto L_0x0092;
    L_0x0240:
        r25 = "    ";
        goto L_0x0157;
    L_0x0244:
        r9 = move-exception;
        r25 = "BackupManagerService";
        r27 = "Error in transport";
        r0 = r25;
        r1 = r27;
        android.util.Slog.e(r0, r1, r9);	 Catch:{ all -> 0x02da }
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "        Error: ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r25;
        r25 = r0.append(r9);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
    L_0x0270:
        r13 = r14 + 1;
        r14 = r13;
        goto L_0x013c;
    L_0x0275:
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "Pending init: ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mPendingInits;	 Catch:{ all -> 0x02da }
        r27 = r0;
        r27 = r27.size();	 Catch:{ all -> 0x02da }
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mPendingInits;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r13 = r25.iterator();	 Catch:{ all -> 0x02da }
    L_0x02ab:
        r25 = r13.hasNext();	 Catch:{ all -> 0x02da }
        if (r25 == 0) goto L_0x02dd;
    L_0x02b1:
        r20 = r13.next();	 Catch:{ all -> 0x02da }
        r20 = (java.lang.String) r20;	 Catch:{ all -> 0x02da }
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "    ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r25;
        r1 = r20;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        goto L_0x02ab;
    L_0x02da:
        r25 = move-exception;
        monitor-exit(r26);	 Catch:{ all -> 0x02da }
        throw r25;
    L_0x02dd:
        r0 = r30;
        r0 = r0.mBackupTrace;	 Catch:{ all -> 0x02da }
        r27 = r0;
        monitor-enter(r27);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mBackupTrace;	 Catch:{ all -> 0x0332 }
        r25 = r0;
        r25 = r25.isEmpty();	 Catch:{ all -> 0x0332 }
        if (r25 != 0) goto L_0x0335;
    L_0x02f0:
        r25 = "Most recent backup trace:";
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x0332 }
        r0 = r30;
        r0 = r0.mBackupTrace;	 Catch:{ all -> 0x0332 }
        r25 = r0;
        r13 = r25.iterator();	 Catch:{ all -> 0x0332 }
    L_0x0303:
        r25 = r13.hasNext();	 Catch:{ all -> 0x0332 }
        if (r25 == 0) goto L_0x0335;
    L_0x0309:
        r20 = r13.next();	 Catch:{ all -> 0x0332 }
        r20 = (java.lang.String) r20;	 Catch:{ all -> 0x0332 }
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0332 }
        r25.<init>();	 Catch:{ all -> 0x0332 }
        r28 = "   ";
        r0 = r25;
        r1 = r28;
        r25 = r0.append(r1);	 Catch:{ all -> 0x0332 }
        r0 = r25;
        r1 = r20;
        r25 = r0.append(r1);	 Catch:{ all -> 0x0332 }
        r25 = r25.toString();	 Catch:{ all -> 0x0332 }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x0332 }
        goto L_0x0303;
    L_0x0332:
        r25 = move-exception;
        monitor-exit(r27);	 Catch:{ all -> 0x0332 }
        throw r25;	 Catch:{ all -> 0x02da }
    L_0x0335:
        monitor-exit(r27);	 Catch:{ all -> 0x0332 }
        r0 = r30;
        r0 = r0.mBackupParticipants;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r4 = r25.size();	 Catch:{ all -> 0x02da }
        r25 = "Participants:";
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r12 = 0;
    L_0x034a:
        if (r12 >= r4) goto L_0x03aa;
    L_0x034c:
        r0 = r30;
        r0 = r0.mBackupParticipants;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r0 = r25;
        r24 = r0.keyAt(r12);	 Catch:{ all -> 0x02da }
        r25 = "  uid: ";
        r0 = r31;
        r1 = r25;
        r0.print(r1);	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r24;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mBackupParticipants;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r0 = r25;
        r17 = r0.valueAt(r12);	 Catch:{ all -> 0x02da }
        r17 = (java.util.HashSet) r17;	 Catch:{ all -> 0x02da }
        r13 = r17.iterator();	 Catch:{ all -> 0x02da }
    L_0x037a:
        r25 = r13.hasNext();	 Catch:{ all -> 0x02da }
        if (r25 == 0) goto L_0x03a7;
    L_0x0380:
        r5 = r13.next();	 Catch:{ all -> 0x02da }
        r5 = (java.lang.String) r5;	 Catch:{ all -> 0x02da }
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "    ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r25;
        r25 = r0.append(r5);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        goto L_0x037a;
    L_0x03a7:
        r12 = r12 + 1;
        goto L_0x034a;
    L_0x03aa:
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "Ancestral packages: ";
        r0 = r25;
        r1 = r27;
        r27 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mAncestralPackages;	 Catch:{ all -> 0x02da }
        r25 = r0;
        if (r25 != 0) goto L_0x0417;
    L_0x03c1:
        r25 = "none";
    L_0x03c3:
        r0 = r27;
        r1 = r25;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mAncestralPackages;	 Catch:{ all -> 0x02da }
        r25 = r0;
        if (r25 == 0) goto L_0x0426;
    L_0x03de:
        r0 = r30;
        r0 = r0.mAncestralPackages;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r13 = r25.iterator();	 Catch:{ all -> 0x02da }
    L_0x03e8:
        r25 = r13.hasNext();	 Catch:{ all -> 0x02da }
        if (r25 == 0) goto L_0x0426;
    L_0x03ee:
        r18 = r13.next();	 Catch:{ all -> 0x02da }
        r18 = (java.lang.String) r18;	 Catch:{ all -> 0x02da }
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "    ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r25;
        r1 = r18;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        goto L_0x03e8;
    L_0x0417:
        r0 = r30;
        r0 = r0.mAncestralPackages;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r25 = r25.size();	 Catch:{ all -> 0x02da }
        r25 = java.lang.Integer.valueOf(r25);	 Catch:{ all -> 0x02da }
        goto L_0x03c3;
    L_0x0426:
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "Ever backed up: ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mEverStoredApps;	 Catch:{ all -> 0x02da }
        r27 = r0;
        r27 = r27.size();	 Catch:{ all -> 0x02da }
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mEverStoredApps;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r13 = r25.iterator();	 Catch:{ all -> 0x02da }
    L_0x045c:
        r25 = r13.hasNext();	 Catch:{ all -> 0x02da }
        if (r25 == 0) goto L_0x048b;
    L_0x0462:
        r18 = r13.next();	 Catch:{ all -> 0x02da }
        r18 = (java.lang.String) r18;	 Catch:{ all -> 0x02da }
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "    ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r25;
        r1 = r18;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        goto L_0x045c;
    L_0x048b:
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "Pending key/value backup: ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mPendingBackups;	 Catch:{ all -> 0x02da }
        r27 = r0;
        r27 = r27.size();	 Catch:{ all -> 0x02da }
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mPendingBackups;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r25 = r25.values();	 Catch:{ all -> 0x02da }
        r13 = r25.iterator();	 Catch:{ all -> 0x02da }
    L_0x04c5:
        r25 = r13.hasNext();	 Catch:{ all -> 0x02da }
        if (r25 == 0) goto L_0x04f4;
    L_0x04cb:
        r19 = r13.next();	 Catch:{ all -> 0x02da }
        r19 = (com.android.server.backup.BackupManagerService.BackupRequest) r19;	 Catch:{ all -> 0x02da }
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "    ";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r25;
        r1 = r19;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        goto L_0x04c5;
    L_0x04f4:
        r25 = new java.lang.StringBuilder;	 Catch:{ all -> 0x02da }
        r25.<init>();	 Catch:{ all -> 0x02da }
        r27 = "Full backup queue:";
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mFullBackupQueue;	 Catch:{ all -> 0x02da }
        r27 = r0;
        r27 = r27.size();	 Catch:{ all -> 0x02da }
        r0 = r25;
        r1 = r27;
        r25 = r0.append(r1);	 Catch:{ all -> 0x02da }
        r25 = r25.toString();	 Catch:{ all -> 0x02da }
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        r0 = r30;
        r0 = r0.mFullBackupQueue;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r13 = r25.iterator();	 Catch:{ all -> 0x02da }
    L_0x052a:
        r25 = r13.hasNext();	 Catch:{ all -> 0x02da }
        if (r25 == 0) goto L_0x055f;
    L_0x0530:
        r10 = r13.next();	 Catch:{ all -> 0x02da }
        r10 = (com.android.server.backup.BackupManagerService.FullBackupEntry) r10;	 Catch:{ all -> 0x02da }
        r25 = "    ";
        r0 = r31;
        r1 = r25;
        r0.print(r1);	 Catch:{ all -> 0x02da }
        r0 = r10.lastBackup;	 Catch:{ all -> 0x02da }
        r28 = r0;
        r0 = r31;
        r1 = r28;
        r0.print(r1);	 Catch:{ all -> 0x02da }
        r25 = " : ";
        r0 = r31;
        r1 = r25;
        r0.print(r1);	 Catch:{ all -> 0x02da }
        r0 = r10.packageName;	 Catch:{ all -> 0x02da }
        r25 = r0;
        r0 = r31;
        r1 = r25;
        r0.println(r1);	 Catch:{ all -> 0x02da }
        goto L_0x052a;
    L_0x055f:
        monitor-exit(r26);	 Catch:{ all -> 0x02da }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.backup.BackupManagerService.dumpInternal(java.io.PrintWriter):void");
    }
}
