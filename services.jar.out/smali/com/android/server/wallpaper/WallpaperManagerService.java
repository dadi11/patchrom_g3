package com.android.server.wallpaper;

import android.app.ActivityManagerNative;
import android.app.AppGlobals;
import android.app.IUserSwitchObserver;
import android.app.IWallpaperManager.Stub;
import android.app.IWallpaperManagerCallback;
import android.app.PendingIntent;
import android.app.WallpaperInfo;
import android.app.WallpaperManager;
import android.app.backup.BackupManager;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.IPackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.pm.UserInfo;
import android.content.res.Resources;
import android.content.res.Resources.NotFoundException;
import android.graphics.Point;
import android.graphics.Rect;
import android.os.Binder;
import android.os.Bundle;
import android.os.Environment;
import android.os.FileObserver;
import android.os.FileUtils;
import android.os.IBinder;
import android.os.IRemoteCallback;
import android.os.ParcelFileDescriptor;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.SELinux;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.UserManager;
import android.service.wallpaper.IWallpaperConnection;
import android.service.wallpaper.IWallpaperEngine;
import android.service.wallpaper.IWallpaperService;
import android.util.EventLog;
import android.util.Slog;
import android.util.SparseArray;
import android.util.Xml;
import android.view.IWindowManager;
import android.view.WindowManager;
import com.android.internal.content.PackageMonitor;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.util.JournaledFile;
import com.android.server.EventLogTags;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.List;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class WallpaperManagerService extends Stub {
    static final boolean DEBUG = false;
    static final int MAX_WALLPAPER_COMPONENT_LOG_LENGTH = 128;
    static final long MIN_WALLPAPER_CRASH_TIME = 10000;
    static final String TAG = "WallpaperManagerService";
    static final String WALLPAPER = "wallpaper";
    static final String WALLPAPER_INFO = "wallpaper_info.xml";
    final Context mContext;
    int mCurrentUserId;
    final IPackageManager mIPackageManager;
    final IWindowManager mIWindowManager;
    final ComponentName mImageWallpaper;
    WallpaperData mLastWallpaper;
    final Object mLock;
    final MyPackageMonitor mMonitor;
    SparseArray<WallpaperData> mWallpaperMap;

    /* renamed from: com.android.server.wallpaper.WallpaperManagerService.1 */
    class C05551 extends BroadcastReceiver {
        C05551() {
        }

        public void onReceive(Context context, Intent intent) {
            if ("android.intent.action.USER_REMOVED".equals(intent.getAction())) {
                WallpaperManagerService.this.onRemoveUser(intent.getIntExtra("android.intent.extra.user_handle", -10000));
            }
        }
    }

    /* renamed from: com.android.server.wallpaper.WallpaperManagerService.2 */
    class C05562 extends IUserSwitchObserver.Stub {
        C05562() {
        }

        public void onUserSwitching(int newUserId, IRemoteCallback reply) {
            WallpaperManagerService.this.switchUser(newUserId, reply);
        }

        public void onUserSwitchComplete(int newUserId) throws RemoteException {
        }
    }

    class MyPackageMonitor extends PackageMonitor {
        MyPackageMonitor() {
        }

        public void onPackageUpdateFinished(String packageName, int uid) {
            synchronized (WallpaperManagerService.this.mLock) {
                if (WallpaperManagerService.this.mCurrentUserId != getChangingUserId()) {
                    return;
                }
                WallpaperData wallpaper = (WallpaperData) WallpaperManagerService.this.mWallpaperMap.get(WallpaperManagerService.this.mCurrentUserId);
                if (!(wallpaper == null || wallpaper.wallpaperComponent == null || !wallpaper.wallpaperComponent.getPackageName().equals(packageName))) {
                    wallpaper.wallpaperUpdating = WallpaperManagerService.DEBUG;
                    ComponentName comp = wallpaper.wallpaperComponent;
                    WallpaperManagerService.this.clearWallpaperComponentLocked(wallpaper);
                    if (!WallpaperManagerService.this.bindWallpaperComponentLocked(comp, WallpaperManagerService.DEBUG, WallpaperManagerService.DEBUG, wallpaper, null)) {
                        Slog.w(WallpaperManagerService.TAG, "Wallpaper no longer available; reverting to default");
                        WallpaperManagerService.this.clearWallpaperLocked(WallpaperManagerService.DEBUG, wallpaper.userId, null);
                    }
                }
            }
        }

        public void onPackageModified(String packageName) {
            synchronized (WallpaperManagerService.this.mLock) {
                if (WallpaperManagerService.this.mCurrentUserId != getChangingUserId()) {
                    return;
                }
                WallpaperData wallpaper = (WallpaperData) WallpaperManagerService.this.mWallpaperMap.get(WallpaperManagerService.this.mCurrentUserId);
                if (wallpaper != null) {
                    if (wallpaper.wallpaperComponent == null || !wallpaper.wallpaperComponent.getPackageName().equals(packageName)) {
                        return;
                    }
                    doPackagesChangedLocked(true, wallpaper);
                }
            }
        }

        public void onPackageUpdateStarted(String packageName, int uid) {
            synchronized (WallpaperManagerService.this.mLock) {
                if (WallpaperManagerService.this.mCurrentUserId != getChangingUserId()) {
                    return;
                }
                WallpaperData wallpaper = (WallpaperData) WallpaperManagerService.this.mWallpaperMap.get(WallpaperManagerService.this.mCurrentUserId);
                if (!(wallpaper == null || wallpaper.wallpaperComponent == null || !wallpaper.wallpaperComponent.getPackageName().equals(packageName))) {
                    wallpaper.wallpaperUpdating = true;
                }
            }
        }

        public boolean onHandleForceStop(Intent intent, String[] packages, int uid, boolean doit) {
            synchronized (WallpaperManagerService.this.mLock) {
                boolean changed = WallpaperManagerService.DEBUG;
                if (WallpaperManagerService.this.mCurrentUserId != getChangingUserId()) {
                    return WallpaperManagerService.DEBUG;
                }
                WallpaperData wallpaper = (WallpaperData) WallpaperManagerService.this.mWallpaperMap.get(WallpaperManagerService.this.mCurrentUserId);
                if (wallpaper != null) {
                    changed = WallpaperManagerService.DEBUG | doPackagesChangedLocked(doit, wallpaper);
                }
                return changed;
            }
        }

        public void onSomePackagesChanged() {
            synchronized (WallpaperManagerService.this.mLock) {
                if (WallpaperManagerService.this.mCurrentUserId != getChangingUserId()) {
                    return;
                }
                WallpaperData wallpaper = (WallpaperData) WallpaperManagerService.this.mWallpaperMap.get(WallpaperManagerService.this.mCurrentUserId);
                if (wallpaper != null) {
                    doPackagesChangedLocked(true, wallpaper);
                }
            }
        }

        boolean doPackagesChangedLocked(boolean doit, WallpaperData wallpaper) {
            int change;
            boolean changed = WallpaperManagerService.DEBUG;
            if (wallpaper.wallpaperComponent != null) {
                change = isPackageDisappearing(wallpaper.wallpaperComponent.getPackageName());
                if (change == 3 || change == 2) {
                    changed = true;
                    if (doit) {
                        Slog.w(WallpaperManagerService.TAG, "Wallpaper uninstalled, removing: " + wallpaper.wallpaperComponent);
                        WallpaperManagerService.this.clearWallpaperLocked(WallpaperManagerService.DEBUG, wallpaper.userId, null);
                    }
                }
            }
            if (wallpaper.nextWallpaperComponent != null) {
                change = isPackageDisappearing(wallpaper.nextWallpaperComponent.getPackageName());
                if (change == 3 || change == 2) {
                    wallpaper.nextWallpaperComponent = null;
                }
            }
            if (wallpaper.wallpaperComponent != null && isPackageModified(wallpaper.wallpaperComponent.getPackageName())) {
                try {
                    WallpaperManagerService.this.mContext.getPackageManager().getServiceInfo(wallpaper.wallpaperComponent, 0);
                } catch (NameNotFoundException e) {
                    Slog.w(WallpaperManagerService.TAG, "Wallpaper component gone, removing: " + wallpaper.wallpaperComponent);
                    WallpaperManagerService.this.clearWallpaperLocked(WallpaperManagerService.DEBUG, wallpaper.userId, null);
                }
            }
            if (wallpaper.nextWallpaperComponent != null && isPackageModified(wallpaper.nextWallpaperComponent.getPackageName())) {
                try {
                    WallpaperManagerService.this.mContext.getPackageManager().getServiceInfo(wallpaper.nextWallpaperComponent, 0);
                } catch (NameNotFoundException e2) {
                    wallpaper.nextWallpaperComponent = null;
                }
            }
            return changed;
        }
    }

    class WallpaperConnection extends IWallpaperConnection.Stub implements ServiceConnection {
        boolean mDimensionsChanged;
        IWallpaperEngine mEngine;
        final WallpaperInfo mInfo;
        boolean mPaddingChanged;
        IRemoteCallback mReply;
        IWallpaperService mService;
        final Binder mToken;
        WallpaperData mWallpaper;

        public WallpaperConnection(WallpaperInfo info, WallpaperData wallpaper) {
            this.mToken = new Binder();
            this.mDimensionsChanged = WallpaperManagerService.DEBUG;
            this.mPaddingChanged = WallpaperManagerService.DEBUG;
            this.mInfo = info;
            this.mWallpaper = wallpaper;
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            synchronized (WallpaperManagerService.this.mLock) {
                if (this.mWallpaper.connection == this) {
                    this.mService = IWallpaperService.Stub.asInterface(service);
                    WallpaperManagerService.this.attachServiceLocked(this, this.mWallpaper);
                    WallpaperManagerService.this.saveSettingsLocked(this.mWallpaper);
                }
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            synchronized (WallpaperManagerService.this.mLock) {
                this.mService = null;
                this.mEngine = null;
                if (this.mWallpaper.connection == this) {
                    Slog.w(WallpaperManagerService.TAG, "Wallpaper service gone: " + this.mWallpaper.wallpaperComponent);
                    if (!this.mWallpaper.wallpaperUpdating && this.mWallpaper.userId == WallpaperManagerService.this.mCurrentUserId) {
                        if (this.mWallpaper.lastDiedTime == 0 || this.mWallpaper.lastDiedTime + WallpaperManagerService.MIN_WALLPAPER_CRASH_TIME <= SystemClock.uptimeMillis()) {
                            this.mWallpaper.lastDiedTime = SystemClock.uptimeMillis();
                        } else {
                            Slog.w(WallpaperManagerService.TAG, "Reverting to built-in wallpaper!");
                            WallpaperManagerService.this.clearWallpaperLocked(true, this.mWallpaper.userId, null);
                        }
                        String flattened = name.flattenToString();
                        EventLog.writeEvent(EventLogTags.WP_WALLPAPER_CRASHED, flattened.substring(0, Math.min(flattened.length(), WallpaperManagerService.MAX_WALLPAPER_COMPONENT_LOG_LENGTH)));
                    }
                }
            }
        }

        public void attachEngine(IWallpaperEngine engine) {
            synchronized (WallpaperManagerService.this.mLock) {
                this.mEngine = engine;
                if (this.mDimensionsChanged) {
                    try {
                        this.mEngine.setDesiredSize(this.mWallpaper.width, this.mWallpaper.height);
                    } catch (RemoteException e) {
                        Slog.w(WallpaperManagerService.TAG, "Failed to set wallpaper dimensions", e);
                    }
                    this.mDimensionsChanged = WallpaperManagerService.DEBUG;
                }
                if (this.mPaddingChanged) {
                    try {
                        this.mEngine.setDisplayPadding(this.mWallpaper.padding);
                    } catch (RemoteException e2) {
                        Slog.w(WallpaperManagerService.TAG, "Failed to set wallpaper padding", e2);
                    }
                    this.mPaddingChanged = WallpaperManagerService.DEBUG;
                }
            }
        }

        public void engineShown(IWallpaperEngine engine) {
            synchronized (WallpaperManagerService.this.mLock) {
                if (this.mReply != null) {
                    long ident = Binder.clearCallingIdentity();
                    try {
                        this.mReply.sendResult(null);
                    } catch (RemoteException e) {
                        Binder.restoreCallingIdentity(ident);
                    }
                    this.mReply = null;
                }
            }
        }

        public ParcelFileDescriptor setWallpaper(String name) {
            ParcelFileDescriptor updateWallpaperBitmapLocked;
            synchronized (WallpaperManagerService.this.mLock) {
                if (this.mWallpaper.connection == this) {
                    updateWallpaperBitmapLocked = WallpaperManagerService.this.updateWallpaperBitmapLocked(name, this.mWallpaper);
                } else {
                    updateWallpaperBitmapLocked = null;
                }
            }
            return updateWallpaperBitmapLocked;
        }
    }

    static class WallpaperData {
        private RemoteCallbackList<IWallpaperManagerCallback> callbacks;
        WallpaperConnection connection;
        int height;
        boolean imageWallpaperPending;
        long lastDiedTime;
        String name;
        ComponentName nextWallpaperComponent;
        final Rect padding;
        int userId;
        ComponentName wallpaperComponent;
        File wallpaperFile;
        WallpaperObserver wallpaperObserver;
        boolean wallpaperUpdating;
        int width;

        WallpaperData(int userId) {
            this.name = "";
            this.callbacks = new RemoteCallbackList();
            this.width = -1;
            this.height = -1;
            this.padding = new Rect(0, 0, 0, 0);
            this.userId = userId;
            this.wallpaperFile = new File(WallpaperManagerService.getWallpaperDir(userId), WallpaperManagerService.WALLPAPER);
        }
    }

    private class WallpaperObserver extends FileObserver {
        final WallpaperData mWallpaper;
        final File mWallpaperDir;
        final File mWallpaperFile;
        final File mWallpaperInfoFile;

        public WallpaperObserver(WallpaperData wallpaper) {
            super(WallpaperManagerService.getWallpaperDir(wallpaper.userId).getAbsolutePath(), 1672);
            this.mWallpaperDir = WallpaperManagerService.getWallpaperDir(wallpaper.userId);
            this.mWallpaper = wallpaper;
            this.mWallpaperFile = new File(this.mWallpaperDir, WallpaperManagerService.WALLPAPER);
            this.mWallpaperInfoFile = new File(this.mWallpaperDir, WallpaperManagerService.WALLPAPER_INFO);
        }

        public void onEvent(int event, String path) {
            boolean written = WallpaperManagerService.DEBUG;
            if (path != null) {
                synchronized (WallpaperManagerService.this.mLock) {
                    File changedFile = new File(this.mWallpaperDir, path);
                    if (this.mWallpaperFile.equals(changedFile) || this.mWallpaperInfoFile.equals(changedFile)) {
                        long origId = Binder.clearCallingIdentity();
                        new BackupManager(WallpaperManagerService.this.mContext).dataChanged();
                        Binder.restoreCallingIdentity(origId);
                    }
                    if (this.mWallpaperFile.equals(changedFile)) {
                        WallpaperManagerService.this.notifyCallbacksLocked(this.mWallpaper);
                        if (event == 8 || event == WallpaperManagerService.MAX_WALLPAPER_COMPONENT_LOG_LENGTH) {
                            written = true;
                        }
                        if (this.mWallpaper.wallpaperComponent == null || event != 8 || this.mWallpaper.imageWallpaperPending) {
                            if (written) {
                                this.mWallpaper.imageWallpaperPending = WallpaperManagerService.DEBUG;
                            }
                            WallpaperManagerService.this.bindWallpaperComponentLocked(WallpaperManagerService.this.mImageWallpaper, true, WallpaperManagerService.DEBUG, this.mWallpaper, null);
                            WallpaperManagerService.this.saveSettingsLocked(this.mWallpaper);
                        }
                    }
                }
            }
        }
    }

    public WallpaperManagerService(Context context) {
        this.mLock = new Object[0];
        this.mWallpaperMap = new SparseArray();
        this.mContext = context;
        this.mImageWallpaper = ComponentName.unflattenFromString(context.getResources().getString(17039393));
        this.mIWindowManager = IWindowManager.Stub.asInterface(ServiceManager.getService("window"));
        this.mIPackageManager = AppGlobals.getPackageManager();
        this.mMonitor = new MyPackageMonitor();
        this.mMonitor.register(context, null, UserHandle.ALL, true);
        getWallpaperDir(0).mkdirs();
        loadSettingsLocked(0);
    }

    private static File getWallpaperDir(int userId) {
        return Environment.getUserSystemDirectory(userId);
    }

    protected void finalize() throws Throwable {
        super.finalize();
        for (int i = 0; i < this.mWallpaperMap.size(); i++) {
            ((WallpaperData) this.mWallpaperMap.valueAt(i)).wallpaperObserver.stopWatching();
        }
    }

    public void systemRunning() {
        WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(0);
        switchWallpaper(wallpaper, null);
        wallpaper.wallpaperObserver = new WallpaperObserver(wallpaper);
        wallpaper.wallpaperObserver.startWatching();
        IntentFilter userFilter = new IntentFilter();
        userFilter.addAction("android.intent.action.USER_REMOVED");
        userFilter.addAction("android.intent.action.USER_STOPPING");
        this.mContext.registerReceiver(new C05551(), userFilter);
        try {
            ActivityManagerNative.getDefault().registerUserSwitchObserver(new C05562());
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    public String getName() {
        if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            throw new RuntimeException("getName() can only be called from the system process");
        }
        String str;
        synchronized (this.mLock) {
            str = ((WallpaperData) this.mWallpaperMap.get(0)).name;
        }
        return str;
    }

    void onStoppingUser(int userId) {
        if (userId >= 1) {
            synchronized (this.mLock) {
                WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(userId);
                if (wallpaper != null) {
                    if (wallpaper.wallpaperObserver != null) {
                        wallpaper.wallpaperObserver.stopWatching();
                        wallpaper.wallpaperObserver = null;
                    }
                    this.mWallpaperMap.remove(userId);
                }
            }
        }
    }

    void onRemoveUser(int userId) {
        if (userId >= 1) {
            synchronized (this.mLock) {
                onStoppingUser(userId);
                new File(getWallpaperDir(userId), WALLPAPER).delete();
                new File(getWallpaperDir(userId), WALLPAPER_INFO).delete();
            }
        }
    }

    void switchUser(int userId, IRemoteCallback reply) {
        synchronized (this.mLock) {
            this.mCurrentUserId = userId;
            WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(userId);
            if (wallpaper == null) {
                wallpaper = new WallpaperData(userId);
                this.mWallpaperMap.put(userId, wallpaper);
                loadSettingsLocked(userId);
            }
            if (wallpaper.wallpaperObserver == null) {
                wallpaper.wallpaperObserver = new WallpaperObserver(wallpaper);
                wallpaper.wallpaperObserver.startWatching();
            }
            switchWallpaper(wallpaper, reply);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void switchWallpaper(com.android.server.wallpaper.WallpaperManagerService.WallpaperData r10, android.os.IRemoteCallback r11) {
        /*
        r9 = this;
        r8 = r9.mLock;
        monitor-enter(r8);
        r6 = 0;
        r0 = r10.wallpaperComponent;	 Catch:{ RuntimeException -> 0x001a }
        if (r0 == 0) goto L_0x0017;
    L_0x0008:
        r1 = r10.wallpaperComponent;	 Catch:{ RuntimeException -> 0x001a }
    L_0x000a:
        r2 = 1;
        r3 = 0;
        r0 = r9;
        r4 = r10;
        r5 = r11;
        r0 = r0.bindWallpaperComponentLocked(r1, r2, r3, r4, r5);	 Catch:{ RuntimeException -> 0x001a }
        if (r0 == 0) goto L_0x001c;
    L_0x0015:
        monitor-exit(r8);	 Catch:{ all -> 0x002b }
    L_0x0016:
        return;
    L_0x0017:
        r1 = r10.nextWallpaperComponent;	 Catch:{ RuntimeException -> 0x001a }
        goto L_0x000a;
    L_0x001a:
        r7 = move-exception;
        r6 = r7;
    L_0x001c:
        r0 = "WallpaperManagerService";
        r2 = "Failure starting previous wallpaper";
        android.util.Slog.w(r0, r2, r6);	 Catch:{ all -> 0x002b }
        r0 = 0;
        r2 = r10.userId;	 Catch:{ all -> 0x002b }
        r9.clearWallpaperLocked(r0, r2, r11);	 Catch:{ all -> 0x002b }
        monitor-exit(r8);	 Catch:{ all -> 0x002b }
        goto L_0x0016;
    L_0x002b:
        r0 = move-exception;
        monitor-exit(r8);	 Catch:{ all -> 0x002b }
        throw r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.wallpaper.WallpaperManagerService.switchWallpaper(com.android.server.wallpaper.WallpaperManagerService$WallpaperData, android.os.IRemoteCallback):void");
    }

    public void clearWallpaper() {
        synchronized (this.mLock) {
            clearWallpaperLocked(DEBUG, UserHandle.getCallingUserId(), null);
        }
    }

    void clearWallpaperLocked(boolean defaultFailed, int userId, IRemoteCallback reply) {
        ComponentName componentName = null;
        WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(userId);
        File f = new File(getWallpaperDir(userId), WALLPAPER);
        if (f.exists()) {
            f.delete();
        }
        long ident = Binder.clearCallingIdentity();
        RuntimeException e = null;
        try {
            wallpaper.imageWallpaperPending = DEBUG;
            if (userId != this.mCurrentUserId) {
                Binder.restoreCallingIdentity(ident);
                return;
            }
            if (defaultFailed) {
                componentName = this.mImageWallpaper;
            }
            if (bindWallpaperComponentLocked(componentName, true, DEBUG, wallpaper, reply)) {
                Binder.restoreCallingIdentity(ident);
                return;
            }
            try {
                Slog.e(TAG, "Default wallpaper component not found!", e);
                clearWallpaperComponentLocked(wallpaper);
                if (reply != null) {
                    try {
                        reply.sendResult(null);
                    } catch (RemoteException e2) {
                    }
                }
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        } catch (RuntimeException e1) {
            e = e1;
        }
    }

    public boolean hasNamedWallpaper(String name) {
        synchronized (this.mLock) {
            long ident = Binder.clearCallingIdentity();
            try {
                List<UserInfo> users = ((UserManager) this.mContext.getSystemService("user")).getUsers();
                Binder.restoreCallingIdentity(ident);
                for (UserInfo user : users) {
                    WallpaperData wd = (WallpaperData) this.mWallpaperMap.get(user.id);
                    if (wd == null) {
                        loadSettingsLocked(user.id);
                        wd = (WallpaperData) this.mWallpaperMap.get(user.id);
                    }
                    if (wd != null && name.equals(wd.name)) {
                        return true;
                    }
                }
                return DEBUG;
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    private Point getDefaultDisplaySize() {
        Point p = new Point();
        ((WindowManager) this.mContext.getSystemService("window")).getDefaultDisplay().getRealSize(p);
        return p;
    }

    public void setDimensionHints(int width, int height) throws RemoteException {
        checkPermission("android.permission.SET_WALLPAPER_HINTS");
        synchronized (this.mLock) {
            int userId = UserHandle.getCallingUserId();
            WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(userId);
            if (wallpaper == null) {
                throw new IllegalStateException("Wallpaper not yet initialized for user " + userId);
            } else if (width <= 0 || height <= 0) {
                throw new IllegalArgumentException("width and height must be > 0");
            } else {
                Point displaySize = getDefaultDisplaySize();
                width = Math.max(width, displaySize.x);
                height = Math.max(height, displaySize.y);
                if (!(width == wallpaper.width && height == wallpaper.height)) {
                    wallpaper.width = width;
                    wallpaper.height = height;
                    saveSettingsLocked(wallpaper);
                    if (this.mCurrentUserId != userId) {
                        return;
                    } else if (wallpaper.connection != null) {
                        if (wallpaper.connection.mEngine != null) {
                            try {
                                wallpaper.connection.mEngine.setDesiredSize(width, height);
                            } catch (RemoteException e) {
                            }
                            notifyCallbacksLocked(wallpaper);
                        } else if (wallpaper.connection.mService != null) {
                            wallpaper.connection.mDimensionsChanged = true;
                        }
                    }
                }
            }
        }
    }

    public int getWidthHint() throws RemoteException {
        int i;
        synchronized (this.mLock) {
            i = ((WallpaperData) this.mWallpaperMap.get(UserHandle.getCallingUserId())).width;
        }
        return i;
    }

    public int getHeightHint() throws RemoteException {
        int i;
        synchronized (this.mLock) {
            i = ((WallpaperData) this.mWallpaperMap.get(UserHandle.getCallingUserId())).height;
        }
        return i;
    }

    public void setDisplayPadding(Rect padding) {
        checkPermission("android.permission.SET_WALLPAPER_HINTS");
        synchronized (this.mLock) {
            int userId = UserHandle.getCallingUserId();
            WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(userId);
            if (wallpaper == null) {
                throw new IllegalStateException("Wallpaper not yet initialized for user " + userId);
            } else if (padding.left < 0 || padding.top < 0 || padding.right < 0 || padding.bottom < 0) {
                throw new IllegalArgumentException("padding must be positive: " + padding);
            } else {
                if (!padding.equals(wallpaper.padding)) {
                    wallpaper.padding.set(padding);
                    saveSettingsLocked(wallpaper);
                    if (this.mCurrentUserId != userId) {
                        return;
                    } else if (wallpaper.connection != null) {
                        if (wallpaper.connection.mEngine != null) {
                            try {
                                wallpaper.connection.mEngine.setDisplayPadding(padding);
                            } catch (RemoteException e) {
                            }
                            notifyCallbacksLocked(wallpaper);
                        } else if (wallpaper.connection.mService != null) {
                            wallpaper.connection.mPaddingChanged = true;
                        }
                    }
                }
            }
        }
    }

    public ParcelFileDescriptor getWallpaper(IWallpaperManagerCallback cb, Bundle outParams) {
        ParcelFileDescriptor parcelFileDescriptor = null;
        synchronized (this.mLock) {
            int wallpaperUserId;
            int callingUid = Binder.getCallingUid();
            if (callingUid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                wallpaperUserId = this.mCurrentUserId;
            } else {
                wallpaperUserId = UserHandle.getUserId(callingUid);
            }
            WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(wallpaperUserId);
            if (outParams != null) {
                try {
                    outParams.putInt("width", wallpaper.width);
                    outParams.putInt("height", wallpaper.height);
                } catch (FileNotFoundException e) {
                    Slog.w(TAG, "Error getting wallpaper", e);
                }
            }
            wallpaper.callbacks.register(cb);
            File f = new File(getWallpaperDir(wallpaperUserId), WALLPAPER);
            if (f.exists()) {
                parcelFileDescriptor = ParcelFileDescriptor.open(f, 268435456);
            }
        }
        return parcelFileDescriptor;
    }

    public WallpaperInfo getWallpaperInfo() {
        WallpaperInfo wallpaperInfo;
        int userId = UserHandle.getCallingUserId();
        synchronized (this.mLock) {
            WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(userId);
            if (wallpaper.connection != null) {
                wallpaperInfo = wallpaper.connection.mInfo;
            } else {
                wallpaperInfo = null;
            }
        }
        return wallpaperInfo;
    }

    public ParcelFileDescriptor setWallpaper(String name) {
        ParcelFileDescriptor pfd;
        checkPermission("android.permission.SET_WALLPAPER");
        synchronized (this.mLock) {
            int userId = UserHandle.getCallingUserId();
            WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(userId);
            if (wallpaper == null) {
                throw new IllegalStateException("Wallpaper not yet initialized for user " + userId);
            }
            long ident = Binder.clearCallingIdentity();
            try {
                pfd = updateWallpaperBitmapLocked(name, wallpaper);
                if (pfd != null) {
                    wallpaper.imageWallpaperPending = true;
                }
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return pfd;
    }

    ParcelFileDescriptor updateWallpaperBitmapLocked(String name, WallpaperData wallpaper) {
        if (name == null) {
            name = "";
        }
        try {
            File dir = getWallpaperDir(wallpaper.userId);
            if (!dir.exists()) {
                dir.mkdir();
                FileUtils.setPermissions(dir.getPath(), 505, -1, -1);
            }
            File file = new File(dir, WALLPAPER);
            ParcelFileDescriptor fd = ParcelFileDescriptor.open(file, 1006632960);
            if (!SELinux.restorecon(file)) {
                return null;
            }
            wallpaper.name = name;
            return fd;
        } catch (FileNotFoundException e) {
            Slog.w(TAG, "Error setting wallpaper", e);
            return null;
        }
    }

    public void setWallpaperComponent(ComponentName name) {
        checkPermission("android.permission.SET_WALLPAPER_COMPONENT");
        synchronized (this.mLock) {
            int userId = UserHandle.getCallingUserId();
            WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(userId);
            if (wallpaper == null) {
                throw new IllegalStateException("Wallpaper not yet initialized for user " + userId);
            }
            long ident = Binder.clearCallingIdentity();
            try {
                wallpaper.imageWallpaperPending = DEBUG;
                bindWallpaperComponentLocked(name, DEBUG, true, wallpaper, null);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    boolean bindWallpaperComponentLocked(ComponentName componentName, boolean force, boolean fromUser, WallpaperData wallpaper, IRemoteCallback reply) {
        String msg;
        if (!(force || wallpaper.connection == null)) {
            if (wallpaper.wallpaperComponent == null) {
                if (componentName == null) {
                    return true;
                }
            } else if (wallpaper.wallpaperComponent.equals(componentName)) {
                return true;
            }
        }
        if (componentName == null) {
            try {
                componentName = WallpaperManager.getDefaultWallpaperComponent(this.mContext);
                if (componentName == null) {
                    componentName = this.mImageWallpaper;
                }
            } catch (XmlPullParserException e) {
                if (fromUser) {
                    throw new IllegalArgumentException(e);
                }
                Slog.w(TAG, e);
                return DEBUG;
            } catch (RemoteException e2) {
                if (fromUser) {
                    throw new IllegalArgumentException(e2);
                }
                Slog.w(TAG, e2);
                return DEBUG;
            } catch (RemoteException e22) {
                msg = "Remote exception for " + componentName + "\n" + e22;
                if (fromUser) {
                    throw new IllegalArgumentException(msg);
                }
                Slog.w(TAG, msg);
                return DEBUG;
            }
        }
        int serviceUserId = wallpaper.userId;
        ServiceInfo si = this.mIPackageManager.getServiceInfo(componentName, 4224, serviceUserId);
        if (si == null) {
            Slog.w(TAG, "Attempted wallpaper " + componentName + " is unavailable");
            return DEBUG;
        } else if ("android.permission.BIND_WALLPAPER".equals(si.permission)) {
            WallpaperInfo wi = null;
            Intent intent = new Intent("android.service.wallpaper.WallpaperService");
            if (componentName != null) {
                if (!componentName.equals(this.mImageWallpaper)) {
                    List<ResolveInfo> ris = this.mIPackageManager.queryIntentServices(intent, intent.resolveTypeIfNeeded(this.mContext.getContentResolver()), MAX_WALLPAPER_COMPONENT_LOG_LENGTH, serviceUserId);
                    for (int i = 0; i < ris.size(); i++) {
                        ServiceInfo rsi = ((ResolveInfo) ris.get(i)).serviceInfo;
                        if (rsi.name.equals(si.name) && rsi.packageName.equals(si.packageName)) {
                            WallpaperInfo wallpaperInfo = new WallpaperInfo(this.mContext, (ResolveInfo) ris.get(i));
                            break;
                        }
                    }
                    if (wi == null) {
                        msg = "Selected service is not a wallpaper: " + componentName;
                        if (fromUser) {
                            throw new SecurityException(msg);
                        }
                        Slog.w(TAG, msg);
                        return DEBUG;
                    }
                }
            }
            WallpaperConnection newConn = new WallpaperConnection(wi, wallpaper);
            intent.setComponent(componentName);
            intent.putExtra("android.intent.extra.client_label", 17040726);
            intent.putExtra("android.intent.extra.client_intent", PendingIntent.getActivityAsUser(this.mContext, 0, Intent.createChooser(new Intent("android.intent.action.SET_WALLPAPER"), this.mContext.getText(17040727)), 0, null, new UserHandle(serviceUserId)));
            if (this.mContext.bindServiceAsUser(intent, newConn, 536870913, new UserHandle(serviceUserId))) {
                if (wallpaper.userId == this.mCurrentUserId && this.mLastWallpaper != null) {
                    detachWallpaperLocked(this.mLastWallpaper);
                }
                wallpaper.wallpaperComponent = componentName;
                wallpaper.connection = newConn;
                newConn.mReply = reply;
                try {
                    if (wallpaper.userId == this.mCurrentUserId) {
                        this.mIWindowManager.addWindowToken(newConn.mToken, 2013);
                        this.mLastWallpaper = wallpaper;
                    }
                } catch (RemoteException e3) {
                }
                return true;
            }
            msg = "Unable to bind service: " + componentName;
            if (fromUser) {
                throw new IllegalArgumentException(msg);
            }
            Slog.w(TAG, msg);
            return DEBUG;
        } else {
            msg = "Selected service does not require android.permission.BIND_WALLPAPER: " + componentName;
            if (fromUser) {
                throw new SecurityException(msg);
            }
            Slog.w(TAG, msg);
            return DEBUG;
        }
    }

    void detachWallpaperLocked(WallpaperData wallpaper) {
        if (wallpaper.connection != null) {
            if (wallpaper.connection.mReply != null) {
                try {
                    wallpaper.connection.mReply.sendResult(null);
                } catch (RemoteException e) {
                }
                wallpaper.connection.mReply = null;
            }
            if (wallpaper.connection.mEngine != null) {
                try {
                    wallpaper.connection.mEngine.destroy();
                } catch (RemoteException e2) {
                }
            }
            this.mContext.unbindService(wallpaper.connection);
            try {
                this.mIWindowManager.removeWindowToken(wallpaper.connection.mToken);
            } catch (RemoteException e3) {
            }
            wallpaper.connection.mService = null;
            wallpaper.connection.mEngine = null;
            wallpaper.connection = null;
        }
    }

    void clearWallpaperComponentLocked(WallpaperData wallpaper) {
        wallpaper.wallpaperComponent = null;
        detachWallpaperLocked(wallpaper);
    }

    void attachServiceLocked(WallpaperConnection conn, WallpaperData wallpaper) {
        try {
            conn.mService.attach(conn, conn.mToken, 2013, DEBUG, wallpaper.width, wallpaper.height, wallpaper.padding);
        } catch (RemoteException e) {
            Slog.w(TAG, "Failed attaching wallpaper; clearing", e);
            if (!wallpaper.wallpaperUpdating) {
                bindWallpaperComponentLocked(null, DEBUG, DEBUG, wallpaper, null);
            }
        }
    }

    private void notifyCallbacksLocked(WallpaperData wallpaper) {
        int n = wallpaper.callbacks.beginBroadcast();
        for (int i = 0; i < n; i++) {
            try {
                ((IWallpaperManagerCallback) wallpaper.callbacks.getBroadcastItem(i)).onWallpaperChanged();
            } catch (RemoteException e) {
            }
        }
        wallpaper.callbacks.finishBroadcast();
        this.mContext.sendBroadcastAsUser(new Intent("android.intent.action.WALLPAPER_CHANGED"), new UserHandle(this.mCurrentUserId));
    }

    private void checkPermission(String permission) {
        if (this.mContext.checkCallingOrSelfPermission(permission) != 0) {
            throw new SecurityException("Access denied to process: " + Binder.getCallingPid() + ", must have permission " + permission);
        }
    }

    private static JournaledFile makeJournaledFile(int userId) {
        String base = new File(getWallpaperDir(userId), WALLPAPER_INFO).getAbsolutePath();
        return new JournaledFile(new File(base), new File(base + ".tmp"));
    }

    private void saveSettingsLocked(WallpaperData wallpaper) {
        JournaledFile journal = makeJournaledFile(wallpaper.userId);
        FileOutputStream stream = null;
        try {
            FileOutputStream stream2 = new FileOutputStream(journal.chooseForWrite(), DEBUG);
            try {
                XmlSerializer out = new FastXmlSerializer();
                out.setOutput(stream2, StandardCharsets.UTF_8.name());
                out.startDocument(null, Boolean.valueOf(true));
                out.startTag(null, "wp");
                out.attribute(null, "width", Integer.toString(wallpaper.width));
                out.attribute(null, "height", Integer.toString(wallpaper.height));
                if (wallpaper.padding.left != 0) {
                    out.attribute(null, "paddingLeft", Integer.toString(wallpaper.padding.left));
                }
                if (wallpaper.padding.top != 0) {
                    out.attribute(null, "paddingTop", Integer.toString(wallpaper.padding.top));
                }
                if (wallpaper.padding.right != 0) {
                    out.attribute(null, "paddingRight", Integer.toString(wallpaper.padding.right));
                }
                if (wallpaper.padding.bottom != 0) {
                    out.attribute(null, "paddingBottom", Integer.toString(wallpaper.padding.bottom));
                }
                out.attribute(null, "name", wallpaper.name);
                if (!(wallpaper.wallpaperComponent == null || wallpaper.wallpaperComponent.equals(this.mImageWallpaper))) {
                    out.attribute(null, "component", wallpaper.wallpaperComponent.flattenToShortString());
                }
                out.endTag(null, "wp");
                out.endDocument();
                stream2.close();
                journal.commit();
                stream = stream2;
            } catch (IOException e) {
                stream = stream2;
                if (stream != null) {
                    try {
                        stream.close();
                    } catch (IOException e2) {
                    }
                }
                journal.rollback();
            }
        } catch (IOException e3) {
            if (stream != null) {
                stream.close();
            }
            journal.rollback();
        }
    }

    private void migrateFromOld() {
        File oldWallpaper = new File("/data/data/com.android.settings/files/wallpaper");
        File oldInfo = new File("/data/system/wallpaper_info.xml");
        if (oldWallpaper.exists()) {
            oldWallpaper.renameTo(new File(getWallpaperDir(0), WALLPAPER));
        }
        if (oldInfo.exists()) {
            oldInfo.renameTo(new File(getWallpaperDir(0), WALLPAPER_INFO));
        }
    }

    private int getAttributeInt(XmlPullParser parser, String name, int defValue) {
        String value = parser.getAttributeValue(null, name);
        return value == null ? defValue : Integer.parseInt(value);
    }

    private void loadSettingsLocked(int userId) {
        int baseSize;
        NullPointerException e;
        NumberFormatException e2;
        XmlPullParserException e3;
        IOException e4;
        IndexOutOfBoundsException e5;
        FileInputStream stream = null;
        File file = makeJournaledFile(userId).chooseForRead();
        if (!file.exists()) {
            migrateFromOld();
        }
        WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(userId);
        if (wallpaper == null) {
            wallpaper = new WallpaperData(userId);
            this.mWallpaperMap.put(userId, wallpaper);
        }
        boolean success = DEBUG;
        try {
            FileInputStream stream2 = new FileInputStream(file);
            try {
                XmlPullParser parser = Xml.newPullParser();
                parser.setInput(stream2, StandardCharsets.UTF_8.name());
                int type;
                do {
                    type = parser.next();
                    if (type == 2) {
                        if ("wp".equals(parser.getName())) {
                            wallpaper.width = Integer.parseInt(parser.getAttributeValue(null, "width"));
                            wallpaper.height = Integer.parseInt(parser.getAttributeValue(null, "height"));
                            wallpaper.padding.left = getAttributeInt(parser, "paddingLeft", 0);
                            wallpaper.padding.top = getAttributeInt(parser, "paddingTop", 0);
                            wallpaper.padding.right = getAttributeInt(parser, "paddingRight", 0);
                            wallpaper.padding.bottom = getAttributeInt(parser, "paddingBottom", 0);
                            wallpaper.name = parser.getAttributeValue(null, "name");
                            String comp = parser.getAttributeValue(null, "component");
                            wallpaper.nextWallpaperComponent = comp != null ? ComponentName.unflattenFromString(comp) : null;
                            if (wallpaper.nextWallpaperComponent == null || "android".equals(wallpaper.nextWallpaperComponent.getPackageName())) {
                                wallpaper.nextWallpaperComponent = this.mImageWallpaper;
                            }
                        }
                    }
                } while (type != 1);
                success = true;
                stream = stream2;
            } catch (FileNotFoundException e6) {
                stream = stream2;
                Slog.w(TAG, "no current wallpaper -- first boot?");
                if (stream != null) {
                    try {
                        stream.close();
                    } catch (IOException e7) {
                    }
                }
                if (!success) {
                    wallpaper.width = -1;
                    wallpaper.height = -1;
                    wallpaper.padding.set(0, 0, 0, 0);
                    wallpaper.name = "";
                }
                baseSize = getMaximumSizeDimension();
                if (wallpaper.width < baseSize) {
                    wallpaper.width = baseSize;
                }
                if (wallpaper.height < baseSize) {
                    wallpaper.height = baseSize;
                }
            } catch (NullPointerException e8) {
                e = e8;
                stream = stream2;
                Slog.w(TAG, "failed parsing " + file + " " + e);
                if (stream != null) {
                    stream.close();
                }
                if (success) {
                    wallpaper.width = -1;
                    wallpaper.height = -1;
                    wallpaper.padding.set(0, 0, 0, 0);
                    wallpaper.name = "";
                }
                baseSize = getMaximumSizeDimension();
                if (wallpaper.width < baseSize) {
                    wallpaper.width = baseSize;
                }
                if (wallpaper.height < baseSize) {
                    wallpaper.height = baseSize;
                }
            } catch (NumberFormatException e9) {
                e2 = e9;
                stream = stream2;
                Slog.w(TAG, "failed parsing " + file + " " + e2);
                if (stream != null) {
                    stream.close();
                }
                if (success) {
                    wallpaper.width = -1;
                    wallpaper.height = -1;
                    wallpaper.padding.set(0, 0, 0, 0);
                    wallpaper.name = "";
                }
                baseSize = getMaximumSizeDimension();
                if (wallpaper.width < baseSize) {
                    wallpaper.width = baseSize;
                }
                if (wallpaper.height < baseSize) {
                    wallpaper.height = baseSize;
                }
            } catch (XmlPullParserException e10) {
                e3 = e10;
                stream = stream2;
                Slog.w(TAG, "failed parsing " + file + " " + e3);
                if (stream != null) {
                    stream.close();
                }
                if (success) {
                    wallpaper.width = -1;
                    wallpaper.height = -1;
                    wallpaper.padding.set(0, 0, 0, 0);
                    wallpaper.name = "";
                }
                baseSize = getMaximumSizeDimension();
                if (wallpaper.width < baseSize) {
                    wallpaper.width = baseSize;
                }
                if (wallpaper.height < baseSize) {
                    wallpaper.height = baseSize;
                }
            } catch (IOException e11) {
                e4 = e11;
                stream = stream2;
                Slog.w(TAG, "failed parsing " + file + " " + e4);
                if (stream != null) {
                    stream.close();
                }
                if (success) {
                    wallpaper.width = -1;
                    wallpaper.height = -1;
                    wallpaper.padding.set(0, 0, 0, 0);
                    wallpaper.name = "";
                }
                baseSize = getMaximumSizeDimension();
                if (wallpaper.width < baseSize) {
                    wallpaper.width = baseSize;
                }
                if (wallpaper.height < baseSize) {
                    wallpaper.height = baseSize;
                }
            } catch (IndexOutOfBoundsException e12) {
                e5 = e12;
                stream = stream2;
                Slog.w(TAG, "failed parsing " + file + " " + e5);
                if (stream != null) {
                    stream.close();
                }
                if (success) {
                    wallpaper.width = -1;
                    wallpaper.height = -1;
                    wallpaper.padding.set(0, 0, 0, 0);
                    wallpaper.name = "";
                }
                baseSize = getMaximumSizeDimension();
                if (wallpaper.width < baseSize) {
                    wallpaper.width = baseSize;
                }
                if (wallpaper.height < baseSize) {
                    wallpaper.height = baseSize;
                }
            }
        } catch (FileNotFoundException e13) {
            Slog.w(TAG, "no current wallpaper -- first boot?");
            if (stream != null) {
                stream.close();
            }
            if (success) {
                wallpaper.width = -1;
                wallpaper.height = -1;
                wallpaper.padding.set(0, 0, 0, 0);
                wallpaper.name = "";
            }
            baseSize = getMaximumSizeDimension();
            if (wallpaper.width < baseSize) {
                wallpaper.width = baseSize;
            }
            if (wallpaper.height < baseSize) {
                wallpaper.height = baseSize;
            }
        } catch (NullPointerException e14) {
            e = e14;
            Slog.w(TAG, "failed parsing " + file + " " + e);
            if (stream != null) {
                stream.close();
            }
            if (success) {
                wallpaper.width = -1;
                wallpaper.height = -1;
                wallpaper.padding.set(0, 0, 0, 0);
                wallpaper.name = "";
            }
            baseSize = getMaximumSizeDimension();
            if (wallpaper.width < baseSize) {
                wallpaper.width = baseSize;
            }
            if (wallpaper.height < baseSize) {
                wallpaper.height = baseSize;
            }
        } catch (NumberFormatException e15) {
            e2 = e15;
            Slog.w(TAG, "failed parsing " + file + " " + e2);
            if (stream != null) {
                stream.close();
            }
            if (success) {
                wallpaper.width = -1;
                wallpaper.height = -1;
                wallpaper.padding.set(0, 0, 0, 0);
                wallpaper.name = "";
            }
            baseSize = getMaximumSizeDimension();
            if (wallpaper.width < baseSize) {
                wallpaper.width = baseSize;
            }
            if (wallpaper.height < baseSize) {
                wallpaper.height = baseSize;
            }
        } catch (XmlPullParserException e16) {
            e3 = e16;
            Slog.w(TAG, "failed parsing " + file + " " + e3);
            if (stream != null) {
                stream.close();
            }
            if (success) {
                wallpaper.width = -1;
                wallpaper.height = -1;
                wallpaper.padding.set(0, 0, 0, 0);
                wallpaper.name = "";
            }
            baseSize = getMaximumSizeDimension();
            if (wallpaper.width < baseSize) {
                wallpaper.width = baseSize;
            }
            if (wallpaper.height < baseSize) {
                wallpaper.height = baseSize;
            }
        } catch (IOException e17) {
            e4 = e17;
            Slog.w(TAG, "failed parsing " + file + " " + e4);
            if (stream != null) {
                stream.close();
            }
            if (success) {
                wallpaper.width = -1;
                wallpaper.height = -1;
                wallpaper.padding.set(0, 0, 0, 0);
                wallpaper.name = "";
            }
            baseSize = getMaximumSizeDimension();
            if (wallpaper.width < baseSize) {
                wallpaper.width = baseSize;
            }
            if (wallpaper.height < baseSize) {
                wallpaper.height = baseSize;
            }
        } catch (IndexOutOfBoundsException e18) {
            e5 = e18;
            Slog.w(TAG, "failed parsing " + file + " " + e5);
            if (stream != null) {
                stream.close();
            }
            if (success) {
                wallpaper.width = -1;
                wallpaper.height = -1;
                wallpaper.padding.set(0, 0, 0, 0);
                wallpaper.name = "";
            }
            baseSize = getMaximumSizeDimension();
            if (wallpaper.width < baseSize) {
                wallpaper.width = baseSize;
            }
            if (wallpaper.height < baseSize) {
                wallpaper.height = baseSize;
            }
        }
        if (stream != null) {
            stream.close();
        }
        if (success) {
            wallpaper.width = -1;
            wallpaper.height = -1;
            wallpaper.padding.set(0, 0, 0, 0);
            wallpaper.name = "";
        }
        baseSize = getMaximumSizeDimension();
        if (wallpaper.width < baseSize) {
            wallpaper.width = baseSize;
        }
        if (wallpaper.height < baseSize) {
            wallpaper.height = baseSize;
        }
    }

    private int getMaximumSizeDimension() {
        return ((WindowManager) this.mContext.getSystemService("window")).getDefaultDisplay().getMaximumSizeDimension();
    }

    public void settingsRestored() {
        if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            throw new RuntimeException("settingsRestored() can only be called from the system process");
        }
        synchronized (this.mLock) {
            boolean success;
            loadSettingsLocked(0);
            WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.get(0);
            if (wallpaper.nextWallpaperComponent == null || wallpaper.nextWallpaperComponent.equals(this.mImageWallpaper)) {
                if ("".equals(wallpaper.name)) {
                    success = true;
                } else {
                    success = restoreNamedResourceLocked(wallpaper);
                }
                if (success) {
                    bindWallpaperComponentLocked(wallpaper.nextWallpaperComponent, DEBUG, DEBUG, wallpaper, null);
                }
            } else {
                if (!bindWallpaperComponentLocked(wallpaper.nextWallpaperComponent, DEBUG, DEBUG, wallpaper, null)) {
                    bindWallpaperComponentLocked(null, DEBUG, DEBUG, wallpaper, null);
                }
                success = true;
            }
        }
        if (!success) {
            Slog.e(TAG, "Failed to restore wallpaper: '" + wallpaper.name + "'");
            wallpaper.name = "";
            getWallpaperDir(0).delete();
        }
        synchronized (this.mLock) {
            saveSettingsLocked(wallpaper);
        }
    }

    boolean restoreNamedResourceLocked(WallpaperData wallpaper) {
        Throwable th;
        IOException e;
        if (wallpaper.name.length() > 4) {
            if ("res:".equals(wallpaper.name.substring(0, 4))) {
                String resName = wallpaper.name.substring(4);
                String pkg = null;
                int colon = resName.indexOf(58);
                if (colon > 0) {
                    pkg = resName.substring(0, colon);
                }
                String ident = null;
                int slash = resName.lastIndexOf(47);
                if (slash > 0) {
                    ident = resName.substring(slash + 1);
                }
                String type = null;
                if (colon > 0 && slash > 0 && slash - colon > 1) {
                    type = resName.substring(colon + 1, slash);
                }
                if (!(pkg == null || ident == null || type == null)) {
                    int i = -1;
                    InputStream res = null;
                    FileOutputStream fos = null;
                    try {
                        Resources r = this.mContext.createPackageContext(pkg, 4).getResources();
                        i = r.getIdentifier(resName, null, null);
                        if (i == 0) {
                            Slog.e(TAG, "couldn't resolve identifier pkg=" + pkg + " type=" + type + " ident=" + ident);
                            if (res != null) {
                                try {
                                    res.close();
                                } catch (IOException e2) {
                                }
                            }
                            if (fos == null) {
                                return DEBUG;
                            }
                            FileUtils.sync(fos);
                            try {
                                fos.close();
                                return DEBUG;
                            } catch (IOException e3) {
                                return DEBUG;
                            }
                        }
                        res = r.openRawResource(i);
                        if (wallpaper.wallpaperFile.exists()) {
                            wallpaper.wallpaperFile.delete();
                        }
                        FileOutputStream fos2 = new FileOutputStream(wallpaper.wallpaperFile);
                        try {
                            byte[] buffer = new byte[32768];
                            while (true) {
                                int amt = res.read(buffer);
                                if (amt <= 0) {
                                    break;
                                }
                                fos2.write(buffer, 0, amt);
                            }
                            Slog.v(TAG, "Restored wallpaper: " + resName);
                            if (res != null) {
                                try {
                                    res.close();
                                } catch (IOException e4) {
                                }
                            }
                            if (fos2 == null) {
                                return true;
                            }
                            FileUtils.sync(fos2);
                            try {
                                fos2.close();
                                return true;
                            } catch (IOException e5) {
                                return true;
                            }
                        } catch (NameNotFoundException e6) {
                            fos = fos2;
                            try {
                                Slog.e(TAG, "Package name " + pkg + " not found");
                                if (res != null) {
                                    try {
                                        res.close();
                                    } catch (IOException e7) {
                                    }
                                }
                                if (fos != null) {
                                    FileUtils.sync(fos);
                                    try {
                                        fos.close();
                                    } catch (IOException e8) {
                                    }
                                }
                                return DEBUG;
                            } catch (Throwable th2) {
                                th = th2;
                                if (res != null) {
                                    try {
                                        res.close();
                                    } catch (IOException e9) {
                                    }
                                }
                                if (fos != null) {
                                    FileUtils.sync(fos);
                                    try {
                                        fos.close();
                                    } catch (IOException e10) {
                                    }
                                }
                                throw th;
                            }
                        } catch (NotFoundException e11) {
                            fos = fos2;
                            Slog.e(TAG, "Resource not found: " + i);
                            if (res != null) {
                                try {
                                    res.close();
                                } catch (IOException e12) {
                                }
                            }
                            if (fos != null) {
                                FileUtils.sync(fos);
                                try {
                                    fos.close();
                                } catch (IOException e13) {
                                }
                            }
                            return DEBUG;
                        } catch (IOException e14) {
                            e = e14;
                            fos = fos2;
                            Slog.e(TAG, "IOException while restoring wallpaper ", e);
                            if (res != null) {
                                try {
                                    res.close();
                                } catch (IOException e15) {
                                }
                            }
                            if (fos != null) {
                                FileUtils.sync(fos);
                                try {
                                    fos.close();
                                } catch (IOException e16) {
                                }
                            }
                            return DEBUG;
                        } catch (Throwable th3) {
                            th = th3;
                            fos = fos2;
                            if (res != null) {
                                res.close();
                            }
                            if (fos != null) {
                                FileUtils.sync(fos);
                                fos.close();
                            }
                            throw th;
                        }
                    } catch (NameNotFoundException e17) {
                        Slog.e(TAG, "Package name " + pkg + " not found");
                        if (res != null) {
                            res.close();
                        }
                        if (fos != null) {
                            FileUtils.sync(fos);
                            fos.close();
                        }
                        return DEBUG;
                    } catch (NotFoundException e18) {
                        Slog.e(TAG, "Resource not found: " + i);
                        if (res != null) {
                            res.close();
                        }
                        if (fos != null) {
                            FileUtils.sync(fos);
                            fos.close();
                        }
                        return DEBUG;
                    } catch (IOException e19) {
                        e = e19;
                        Slog.e(TAG, "IOException while restoring wallpaper ", e);
                        if (res != null) {
                            res.close();
                        }
                        if (fos != null) {
                            FileUtils.sync(fos);
                            fos.close();
                        }
                        return DEBUG;
                    }
                }
            }
        }
        return DEBUG;
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump wallpaper service from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            return;
        }
        synchronized (this.mLock) {
            pw.println("Current Wallpaper Service state:");
            for (int i = 0; i < this.mWallpaperMap.size(); i++) {
                WallpaperData wallpaper = (WallpaperData) this.mWallpaperMap.valueAt(i);
                pw.println(" User " + wallpaper.userId + ":");
                pw.print("  mWidth=");
                pw.print(wallpaper.width);
                pw.print(" mHeight=");
                pw.println(wallpaper.height);
                pw.print("  mPadding=");
                pw.println(wallpaper.padding);
                pw.print("  mName=");
                pw.println(wallpaper.name);
                pw.print("  mWallpaperComponent=");
                pw.println(wallpaper.wallpaperComponent);
                if (wallpaper.connection != null) {
                    WallpaperConnection conn = wallpaper.connection;
                    pw.print("  Wallpaper connection ");
                    pw.print(conn);
                    pw.println(":");
                    if (conn.mInfo != null) {
                        pw.print("    mInfo.component=");
                        pw.println(conn.mInfo.getComponent());
                    }
                    pw.print("    mToken=");
                    pw.println(conn.mToken);
                    pw.print("    mService=");
                    pw.println(conn.mService);
                    pw.print("    mEngine=");
                    pw.println(conn.mEngine);
                    pw.print("    mLastDiedTime=");
                    pw.println(wallpaper.lastDiedTime - SystemClock.uptimeMillis());
                }
            }
        }
    }
}
