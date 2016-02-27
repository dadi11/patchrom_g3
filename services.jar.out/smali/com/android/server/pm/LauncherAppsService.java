package com.android.server.pm;

import android.app.AppGlobals;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.ILauncherApps.Stub;
import android.content.pm.IOnAppsChangedListener;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.pm.UserInfo;
import android.graphics.Rect;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.IInterface;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.UserHandle;
import android.os.UserManager;
import android.util.Slog;
import com.android.internal.content.PackageMonitor;
import com.android.server.SystemService;
import java.util.ArrayList;
import java.util.List;

public class LauncherAppsService extends SystemService {
    private final LauncherAppsImpl mLauncherAppsImpl;

    class LauncherAppsImpl extends Stub {
        private static final boolean DEBUG = false;
        private static final String TAG = "LauncherAppsService";
        private final Context mContext;
        private final PackageCallbackList<IOnAppsChangedListener> mListeners;
        private MyPackageMonitor mPackageMonitor;
        private final PackageManager mPm;
        private final UserManager mUm;

        private class MyPackageMonitor extends PackageMonitor {
            private MyPackageMonitor() {
            }

            private boolean isEnabledProfileOf(UserHandle user, UserHandle listeningUser, String debugMsg) {
                if (user.getIdentifier() == listeningUser.getIdentifier()) {
                    return true;
                }
                long ident = Binder.clearCallingIdentity();
                try {
                    UserInfo userInfo = LauncherAppsImpl.this.mUm.getUserInfo(user.getIdentifier());
                    UserInfo listeningUserInfo = LauncherAppsImpl.this.mUm.getUserInfo(listeningUser.getIdentifier());
                    if (userInfo == null || listeningUserInfo == null || userInfo.profileGroupId == -1 || userInfo.profileGroupId != listeningUserInfo.profileGroupId || !userInfo.isEnabled()) {
                        Binder.restoreCallingIdentity(ident);
                        return LauncherAppsImpl.DEBUG;
                    }
                    Binder.restoreCallingIdentity(ident);
                    return true;
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(ident);
                }
            }

            public void onPackageAdded(String packageName, int uid) {
                UserHandle user = new UserHandle(getChangingUserId());
                int n = LauncherAppsImpl.this.mListeners.beginBroadcast();
                for (int i = 0; i < n; i++) {
                    IOnAppsChangedListener listener = (IOnAppsChangedListener) LauncherAppsImpl.this.mListeners.getBroadcastItem(i);
                    if (isEnabledProfileOf(user, (UserHandle) LauncherAppsImpl.this.mListeners.getBroadcastCookie(i), "onPackageAdded")) {
                        try {
                            listener.onPackageAdded(user, packageName);
                        } catch (RemoteException re) {
                            Slog.d(LauncherAppsImpl.TAG, "Callback failed ", re);
                        }
                    }
                }
                LauncherAppsImpl.this.mListeners.finishBroadcast();
                super.onPackageAdded(packageName, uid);
            }

            public void onPackageRemoved(String packageName, int uid) {
                UserHandle user = new UserHandle(getChangingUserId());
                int n = LauncherAppsImpl.this.mListeners.beginBroadcast();
                for (int i = 0; i < n; i++) {
                    IOnAppsChangedListener listener = (IOnAppsChangedListener) LauncherAppsImpl.this.mListeners.getBroadcastItem(i);
                    if (isEnabledProfileOf(user, (UserHandle) LauncherAppsImpl.this.mListeners.getBroadcastCookie(i), "onPackageRemoved")) {
                        try {
                            listener.onPackageRemoved(user, packageName);
                        } catch (RemoteException re) {
                            Slog.d(LauncherAppsImpl.TAG, "Callback failed ", re);
                        }
                    }
                }
                LauncherAppsImpl.this.mListeners.finishBroadcast();
                super.onPackageRemoved(packageName, uid);
            }

            public void onPackageModified(String packageName) {
                UserHandle user = new UserHandle(getChangingUserId());
                int n = LauncherAppsImpl.this.mListeners.beginBroadcast();
                for (int i = 0; i < n; i++) {
                    IOnAppsChangedListener listener = (IOnAppsChangedListener) LauncherAppsImpl.this.mListeners.getBroadcastItem(i);
                    if (isEnabledProfileOf(user, (UserHandle) LauncherAppsImpl.this.mListeners.getBroadcastCookie(i), "onPackageModified")) {
                        try {
                            listener.onPackageChanged(user, packageName);
                        } catch (RemoteException re) {
                            Slog.d(LauncherAppsImpl.TAG, "Callback failed ", re);
                        }
                    }
                }
                LauncherAppsImpl.this.mListeners.finishBroadcast();
                super.onPackageModified(packageName);
            }

            public void onPackagesAvailable(String[] packages) {
                UserHandle user = new UserHandle(getChangingUserId());
                int n = LauncherAppsImpl.this.mListeners.beginBroadcast();
                for (int i = 0; i < n; i++) {
                    IOnAppsChangedListener listener = (IOnAppsChangedListener) LauncherAppsImpl.this.mListeners.getBroadcastItem(i);
                    if (isEnabledProfileOf(user, (UserHandle) LauncherAppsImpl.this.mListeners.getBroadcastCookie(i), "onPackagesAvailable")) {
                        try {
                            listener.onPackagesAvailable(user, packages, isReplacing());
                        } catch (RemoteException re) {
                            Slog.d(LauncherAppsImpl.TAG, "Callback failed ", re);
                        }
                    }
                }
                LauncherAppsImpl.this.mListeners.finishBroadcast();
                super.onPackagesAvailable(packages);
            }

            public void onPackagesUnavailable(String[] packages) {
                UserHandle user = new UserHandle(getChangingUserId());
                int n = LauncherAppsImpl.this.mListeners.beginBroadcast();
                for (int i = 0; i < n; i++) {
                    IOnAppsChangedListener listener = (IOnAppsChangedListener) LauncherAppsImpl.this.mListeners.getBroadcastItem(i);
                    if (isEnabledProfileOf(user, (UserHandle) LauncherAppsImpl.this.mListeners.getBroadcastCookie(i), "onPackagesUnavailable")) {
                        try {
                            listener.onPackagesUnavailable(user, packages, isReplacing());
                        } catch (RemoteException re) {
                            Slog.d(LauncherAppsImpl.TAG, "Callback failed ", re);
                        }
                    }
                }
                LauncherAppsImpl.this.mListeners.finishBroadcast();
                super.onPackagesUnavailable(packages);
            }
        }

        class PackageCallbackList<T extends IInterface> extends RemoteCallbackList<T> {
            PackageCallbackList() {
            }

            public void onCallbackDied(T t, Object cookie) {
                LauncherAppsImpl.this.checkCallbackCount();
            }
        }

        public LauncherAppsImpl(Context context) {
            this.mListeners = new PackageCallbackList();
            this.mPackageMonitor = new MyPackageMonitor();
            this.mContext = context;
            this.mPm = this.mContext.getPackageManager();
            this.mUm = (UserManager) this.mContext.getSystemService("user");
        }

        public void addOnAppsChangedListener(IOnAppsChangedListener listener) throws RemoteException {
            synchronized (this.mListeners) {
                if (this.mListeners.getRegisteredCallbackCount() == 0) {
                    startWatchingPackageBroadcasts();
                }
                this.mListeners.unregister(listener);
                this.mListeners.register(listener, Binder.getCallingUserHandle());
            }
        }

        public void removeOnAppsChangedListener(IOnAppsChangedListener listener) throws RemoteException {
            synchronized (this.mListeners) {
                this.mListeners.unregister(listener);
                if (this.mListeners.getRegisteredCallbackCount() == 0) {
                    stopWatchingPackageBroadcasts();
                }
            }
        }

        private void startWatchingPackageBroadcasts() {
            this.mPackageMonitor.register(this.mContext, null, UserHandle.ALL, true);
        }

        private void stopWatchingPackageBroadcasts() {
            this.mPackageMonitor.unregister();
        }

        void checkCallbackCount() {
            synchronized (this.mListeners) {
                if (this.mListeners.getRegisteredCallbackCount() == 0) {
                    stopWatchingPackageBroadcasts();
                }
            }
        }

        private void ensureInUserProfiles(UserHandle userToCheck, String message) {
            int callingUserId = UserHandle.getCallingUserId();
            int targetUserId = userToCheck.getIdentifier();
            if (targetUserId != callingUserId) {
                long ident = Binder.clearCallingIdentity();
                try {
                    UserInfo callingUserInfo = this.mUm.getUserInfo(callingUserId);
                    UserInfo targetUserInfo = this.mUm.getUserInfo(targetUserId);
                    if (targetUserInfo == null || targetUserInfo.profileGroupId == -1 || targetUserInfo.profileGroupId != callingUserInfo.profileGroupId) {
                        throw new SecurityException(message);
                    }
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            }
        }

        private boolean isUserEnabled(UserHandle user) {
            long ident = Binder.clearCallingIdentity();
            try {
                UserInfo targetUserInfo = this.mUm.getUserInfo(user.getIdentifier());
                boolean z = (targetUserInfo == null || !targetUserInfo.isEnabled()) ? DEBUG : true;
                Binder.restoreCallingIdentity(ident);
                return z;
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public List<ResolveInfo> getLauncherActivities(String packageName, UserHandle user) throws RemoteException {
            ensureInUserProfiles(user, "Cannot retrieve activities for unrelated profile " + user);
            if (!isUserEnabled(user)) {
                return new ArrayList();
            }
            Intent mainIntent = new Intent("android.intent.action.MAIN", null);
            mainIntent.addCategory("android.intent.category.LAUNCHER");
            mainIntent.setPackage(packageName);
            long ident = Binder.clearCallingIdentity();
            try {
                List<ResolveInfo> queryIntentActivitiesAsUser = this.mPm.queryIntentActivitiesAsUser(mainIntent, 0, user.getIdentifier());
                return queryIntentActivitiesAsUser;
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public ResolveInfo resolveActivity(Intent intent, UserHandle user) throws RemoteException {
            ensureInUserProfiles(user, "Cannot resolve activity for unrelated profile " + user);
            if (!isUserEnabled(user)) {
                return null;
            }
            long ident = Binder.clearCallingIdentity();
            try {
                ResolveInfo resolveActivityAsUser = this.mPm.resolveActivityAsUser(intent, 0, user.getIdentifier());
                return resolveActivityAsUser;
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public boolean isPackageEnabled(String packageName, UserHandle user) throws RemoteException {
            boolean z = DEBUG;
            ensureInUserProfiles(user, "Cannot check package for unrelated profile " + user);
            if (isUserEnabled(user)) {
                long ident = Binder.clearCallingIdentity();
                try {
                    PackageInfo info = AppGlobals.getPackageManager().getPackageInfo(packageName, 0, user.getIdentifier());
                    if (info != null && info.applicationInfo.enabled) {
                        z = true;
                    }
                    Binder.restoreCallingIdentity(ident);
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(ident);
                }
            }
            return z;
        }

        public boolean isActivityEnabled(ComponentName component, UserHandle user) throws RemoteException {
            boolean z = DEBUG;
            ensureInUserProfiles(user, "Cannot check component for unrelated profile " + user);
            if (isUserEnabled(user)) {
                long ident = Binder.clearCallingIdentity();
                try {
                    if (AppGlobals.getPackageManager().getActivityInfo(component, 0, user.getIdentifier()) != null) {
                        z = true;
                    }
                    Binder.restoreCallingIdentity(ident);
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(ident);
                }
            }
            return z;
        }

        public void startActivityAsUser(ComponentName component, Rect sourceBounds, Bundle opts, UserHandle user) throws RemoteException {
            ensureInUserProfiles(user, "Cannot start activity for unrelated profile " + user);
            if (isUserEnabled(user)) {
                Intent launchIntent = new Intent("android.intent.action.MAIN");
                launchIntent.addCategory("android.intent.category.LAUNCHER");
                launchIntent.setSourceBounds(sourceBounds);
                launchIntent.addFlags(268435456);
                launchIntent.setPackage(component.getPackageName());
                long ident = Binder.clearCallingIdentity();
                try {
                    if (AppGlobals.getPackageManager().getActivityInfo(component, 0, user.getIdentifier()).exported) {
                        List<ResolveInfo> apps = this.mPm.queryIntentActivitiesAsUser(launchIntent, 0, user.getIdentifier());
                        int size = apps.size();
                        for (int i = 0; i < size; i++) {
                            ActivityInfo activityInfo = ((ResolveInfo) apps.get(i)).activityInfo;
                            if (activityInfo.packageName.equals(component.getPackageName()) && activityInfo.name.equals(component.getClassName())) {
                                launchIntent.setComponent(component);
                                this.mContext.startActivityAsUser(launchIntent, opts, user);
                                return;
                            }
                        }
                        throw new SecurityException("Attempt to launch activity without  category Intent.CATEGORY_LAUNCHER " + component);
                    }
                    throw new SecurityException("Cannot launch non-exported components " + component);
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            } else {
                throw new IllegalStateException("Cannot start activity for disabled profile " + user);
            }
        }

        public void showAppDetailsAsUser(ComponentName component, Rect sourceBounds, Bundle opts, UserHandle user) throws RemoteException {
            ensureInUserProfiles(user, "Cannot show app details for unrelated profile " + user);
            if (isUserEnabled(user)) {
                long ident = Binder.clearCallingIdentity();
                try {
                    Intent intent = new Intent("android.settings.APPLICATION_DETAILS_SETTINGS", Uri.fromParts("package", component.getPackageName(), null));
                    intent.setFlags(276856832);
                    intent.setSourceBounds(sourceBounds);
                    this.mContext.startActivityAsUser(intent, opts, user);
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            } else {
                throw new IllegalStateException("Cannot show app details for disabled profile " + user);
            }
        }
    }

    public LauncherAppsService(Context context) {
        super(context);
        this.mLauncherAppsImpl = new LauncherAppsImpl(context);
    }

    public void onStart() {
        publishBinderService("launcherapps", this.mLauncherAppsImpl);
    }
}
