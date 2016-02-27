package com.android.server.notification;

import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.pm.UserInfo;
import android.database.ContentObserver;
import android.net.Uri;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.IInterface;
import android.os.RemoteException;
import android.os.UserHandle;
import android.provider.Settings.Secure;
import android.text.TextUtils;
import android.util.ArraySet;
import android.util.Log;
import android.util.Slog;
import android.util.SparseArray;
import com.android.server.notification.NotificationManagerService.DumpFilter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public abstract class ManagedServices {
    private static final String ENABLED_SERVICES_SEPARATOR = ":";
    protected final boolean DEBUG;
    protected final String TAG;
    private final Config mConfig;
    protected final Context mContext;
    private ArraySet<ComponentName> mEnabledServicesForCurrentProfiles;
    private ArraySet<String> mEnabledServicesPackageNames;
    private int[] mLastSeenProfileIds;
    protected final Object mMutex;
    protected final ArrayList<ManagedServiceInfo> mServices;
    private final ArrayList<String> mServicesBinding;
    private final SettingsObserver mSettingsObserver;
    private final UserProfiles mUserProfiles;

    /* renamed from: com.android.server.notification.ManagedServices.1 */
    class C04131 implements ServiceConnection {
        IInterface mService;
        final /* synthetic */ String val$servicesBindingTag;
        final /* synthetic */ int val$targetSdkVersion;
        final /* synthetic */ int val$userid;

        C04131(String str, int i, int i2) {
            this.val$servicesBindingTag = str;
            this.val$userid = i;
            this.val$targetSdkVersion = i2;
        }

        public void onServiceConnected(ComponentName name, IBinder binder) {
            boolean added = false;
            ManagedServiceInfo info = null;
            synchronized (ManagedServices.this.mMutex) {
                ManagedServices.this.mServicesBinding.remove(this.val$servicesBindingTag);
                try {
                    this.mService = ManagedServices.this.asInterface(binder);
                    info = ManagedServices.this.newServiceInfo(this.mService, name, this.val$userid, false, this, this.val$targetSdkVersion);
                    binder.linkToDeath(info, 0);
                    added = ManagedServices.this.mServices.add(info);
                } catch (RemoteException e) {
                }
            }
            if (added) {
                ManagedServices.this.onServiceAdded(info);
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            Slog.v(ManagedServices.this.TAG, ManagedServices.this.getCaption() + " connection lost: " + name);
        }
    }

    protected static class Config {
        String bindPermission;
        String caption;
        int clientLabel;
        String secureSettingName;
        String serviceInterface;
        String settingsAction;

        protected Config() {
        }
    }

    public class ManagedServiceInfo implements DeathRecipient {
        public ComponentName component;
        public ServiceConnection connection;
        public boolean isSystem;
        public IInterface service;
        public int targetSdkVersion;
        public int userid;

        public ManagedServiceInfo(IInterface service, ComponentName component, int userid, boolean isSystem, ServiceConnection connection, int targetSdkVersion) {
            this.service = service;
            this.component = component;
            this.userid = userid;
            this.isSystem = isSystem;
            this.connection = connection;
            this.targetSdkVersion = targetSdkVersion;
        }

        public String toString() {
            return "ManagedServiceInfo[" + "component=" + this.component + ",userid=" + this.userid + ",isSystem=" + this.isSystem + ",targetSdkVersion=" + this.targetSdkVersion + ",connection=" + (this.connection == null ? null : "<connection>") + ",service=" + this.service + ']';
        }

        public boolean enabledAndUserMatches(int nid) {
            if (!isEnabledForCurrentProfiles()) {
                return false;
            }
            if (this.userid == -1 || nid == -1 || nid == this.userid) {
                return true;
            }
            if (supportsProfiles() && ManagedServices.this.mUserProfiles.isCurrentProfile(nid)) {
                return true;
            }
            return false;
        }

        public boolean supportsProfiles() {
            return this.targetSdkVersion >= 21;
        }

        public void binderDied() {
            if (ManagedServices.this.DEBUG) {
                Slog.d(ManagedServices.this.TAG, "binderDied");
            }
            ManagedServices.this.removeServiceImpl(this.service, this.userid);
        }

        public boolean isEnabledForCurrentProfiles() {
            if (this.isSystem) {
                return true;
            }
            if (this.connection == null) {
                return false;
            }
            return ManagedServices.this.mEnabledServicesForCurrentProfiles.contains(this.component);
        }
    }

    private class SettingsObserver extends ContentObserver {
        private final Uri mSecureSettingsUri;

        private SettingsObserver(Handler handler) {
            super(handler);
            this.mSecureSettingsUri = Secure.getUriFor(ManagedServices.this.mConfig.secureSettingName);
        }

        private void observe() {
            ManagedServices.this.mContext.getContentResolver().registerContentObserver(this.mSecureSettingsUri, false, this, -1);
            update(null);
        }

        public void onChange(boolean selfChange, Uri uri) {
            update(uri);
        }

        private void update(Uri uri) {
            if (uri == null || this.mSecureSettingsUri.equals(uri)) {
                if (ManagedServices.this.DEBUG) {
                    Slog.d(ManagedServices.this.TAG, "Setting changed: mSecureSettingsUri=" + this.mSecureSettingsUri + " / uri=" + uri);
                }
                ManagedServices.this.rebindServices();
            }
        }
    }

    public static class UserProfiles {
        private final SparseArray<UserInfo> mCurrentProfiles;

        public UserProfiles() {
            this.mCurrentProfiles = new SparseArray();
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void updateCache(android.content.Context r9) {
            /*
            r8 = this;
            r5 = "user";
            r4 = r9.getSystemService(r5);
            r4 = (android.os.UserManager) r4;
            if (r4 == 0) goto L_0x0036;
        L_0x000a:
            r0 = android.app.ActivityManager.getCurrentUser();
            r2 = r4.getProfiles(r0);
            r6 = r8.mCurrentProfiles;
            monitor-enter(r6);
            r5 = r8.mCurrentProfiles;	 Catch:{ all -> 0x0032 }
            r5.clear();	 Catch:{ all -> 0x0032 }
            r1 = r2.iterator();	 Catch:{ all -> 0x0032 }
        L_0x001e:
            r5 = r1.hasNext();	 Catch:{ all -> 0x0032 }
            if (r5 == 0) goto L_0x0035;
        L_0x0024:
            r3 = r1.next();	 Catch:{ all -> 0x0032 }
            r3 = (android.content.pm.UserInfo) r3;	 Catch:{ all -> 0x0032 }
            r5 = r8.mCurrentProfiles;	 Catch:{ all -> 0x0032 }
            r7 = r3.id;	 Catch:{ all -> 0x0032 }
            r5.put(r7, r3);	 Catch:{ all -> 0x0032 }
            goto L_0x001e;
        L_0x0032:
            r5 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x0032 }
            throw r5;
        L_0x0035:
            monitor-exit(r6);	 Catch:{ all -> 0x0032 }
        L_0x0036:
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.notification.ManagedServices.UserProfiles.updateCache(android.content.Context):void");
        }

        public int[] getCurrentProfileIds() {
            int[] users;
            synchronized (this.mCurrentProfiles) {
                users = new int[this.mCurrentProfiles.size()];
                int N = this.mCurrentProfiles.size();
                for (int i = 0; i < N; i++) {
                    users[i] = this.mCurrentProfiles.keyAt(i);
                }
            }
            return users;
        }

        public boolean isCurrentProfile(int userId) {
            boolean z;
            synchronized (this.mCurrentProfiles) {
                z = this.mCurrentProfiles.get(userId) != null;
            }
            return z;
        }
    }

    protected abstract IInterface asInterface(IBinder iBinder);

    protected abstract Config getConfig();

    protected abstract void onServiceAdded(ManagedServiceInfo managedServiceInfo);

    public ManagedServices(Context context, Handler handler, Object mutex, UserProfiles userProfiles) {
        this.TAG = getClass().getSimpleName();
        this.DEBUG = Log.isLoggable(this.TAG, 3);
        this.mServices = new ArrayList();
        this.mServicesBinding = new ArrayList();
        this.mEnabledServicesForCurrentProfiles = new ArraySet();
        this.mEnabledServicesPackageNames = new ArraySet();
        this.mContext = context;
        this.mMutex = mutex;
        this.mUserProfiles = userProfiles;
        this.mConfig = getConfig();
        this.mSettingsObserver = new SettingsObserver(handler, null);
    }

    private String getCaption() {
        return this.mConfig.caption;
    }

    protected void onServiceRemovedLocked(ManagedServiceInfo removed) {
    }

    private ManagedServiceInfo newServiceInfo(IInterface service, ComponentName component, int userid, boolean isSystem, ServiceConnection connection, int targetSdkVersion) {
        return new ManagedServiceInfo(service, component, userid, isSystem, connection, targetSdkVersion);
    }

    public void onBootPhaseAppsCanStart() {
        this.mSettingsObserver.observe();
    }

    public void dump(PrintWriter pw, DumpFilter filter) {
        pw.println("    All " + getCaption() + "s (" + this.mEnabledServicesForCurrentProfiles.size() + ") enabled for current profiles:");
        Iterator i$ = this.mEnabledServicesForCurrentProfiles.iterator();
        while (i$.hasNext()) {
            ComponentName cmpt = (ComponentName) i$.next();
            if (filter == null || filter.matches(cmpt)) {
                pw.println("      " + cmpt);
            }
        }
        pw.println("    Live " + getCaption() + "s (" + this.mServices.size() + "):");
        i$ = this.mServices.iterator();
        while (i$.hasNext()) {
            ManagedServiceInfo info = (ManagedServiceInfo) i$.next();
            if (filter == null || filter.matches(info.component)) {
                pw.println("      " + info.component + " (user " + info.userid + "): " + info.service + (info.isSystem ? " SYSTEM" : ""));
            }
        }
    }

    public void onPackagesChanged(boolean queryReplace, String[] pkgList) {
        if (this.DEBUG) {
            Slog.d(this.TAG, "onPackagesChanged queryReplace=" + queryReplace + " pkgList=" + (pkgList == null ? null : Arrays.asList(pkgList)) + " mEnabledServicesPackageNames=" + this.mEnabledServicesPackageNames);
        }
        boolean anyServicesInvolved = false;
        if (pkgList != null && pkgList.length > 0) {
            for (String pkgName : pkgList) {
                if (this.mEnabledServicesPackageNames.contains(pkgName)) {
                    anyServicesInvolved = true;
                }
            }
        }
        if (anyServicesInvolved) {
            if (!queryReplace) {
                disableNonexistentServices();
            }
            rebindServices();
        }
    }

    public void onUserSwitched() {
        if (this.DEBUG) {
            Slog.d(this.TAG, "onUserSwitched");
        }
        if (!Arrays.equals(this.mLastSeenProfileIds, this.mUserProfiles.getCurrentProfileIds())) {
            rebindServices();
        } else if (this.DEBUG) {
            Slog.d(this.TAG, "Current profile IDs didn't change, skipping rebindServices().");
        }
    }

    public ManagedServiceInfo checkServiceTokenLocked(IInterface service) {
        checkNotNull(service);
        IBinder token = service.asBinder();
        int N = this.mServices.size();
        for (int i = 0; i < N; i++) {
            ManagedServiceInfo info = (ManagedServiceInfo) this.mServices.get(i);
            if (info.service.asBinder() == token) {
                return info;
            }
        }
        throw new SecurityException("Disallowed call from unknown " + getCaption() + ": " + service);
    }

    public void unregisterService(IInterface service, int userid) {
        checkNotNull(service);
        unregisterServiceImpl(service, userid);
    }

    public void registerService(IInterface service, ComponentName component, int userid) {
        checkNotNull(service);
        ManagedServiceInfo info = registerServiceImpl(service, component, userid);
        if (info != null) {
            onServiceAdded(info);
        }
    }

    private void disableNonexistentServices() {
        for (int disableNonexistentServices : this.mUserProfiles.getCurrentProfileIds()) {
            disableNonexistentServices(disableNonexistentServices);
        }
    }

    private void disableNonexistentServices(int userId) {
        String flatIn = Secure.getStringForUser(this.mContext.getContentResolver(), this.mConfig.secureSettingName, userId);
        if (!TextUtils.isEmpty(flatIn)) {
            int i;
            if (this.DEBUG) {
                Slog.v(this.TAG, "flat before: " + flatIn);
            }
            List<ResolveInfo> installedServices = this.mContext.getPackageManager().queryIntentServicesAsUser(new Intent(this.mConfig.serviceInterface), 132, userId);
            if (this.DEBUG) {
                Slog.v(this.TAG, this.mConfig.serviceInterface + " services: " + installedServices);
            }
            Set<ComponentName> installed = new ArraySet();
            int count = installedServices.size();
            for (i = 0; i < count; i++) {
                ServiceInfo info = ((ResolveInfo) installedServices.get(i)).serviceInfo;
                if (this.mConfig.bindPermission.equals(info.permission)) {
                    installed.add(new ComponentName(info.packageName, info.name));
                } else {
                    Slog.w(this.TAG, "Skipping " + getCaption() + " service " + info.packageName + "/" + info.name + ": it does not require the permission " + this.mConfig.bindPermission);
                }
            }
            String flatOut = "";
            if (!installed.isEmpty()) {
                String[] enabled = flatIn.split(ENABLED_SERVICES_SEPARATOR);
                ArrayList<String> remaining = new ArrayList(enabled.length);
                for (i = 0; i < enabled.length; i++) {
                    if (installed.contains(ComponentName.unflattenFromString(enabled[i]))) {
                        remaining.add(enabled[i]);
                    }
                }
                flatOut = TextUtils.join(ENABLED_SERVICES_SEPARATOR, remaining);
            }
            if (this.DEBUG) {
                Slog.v(this.TAG, "flat after: " + flatOut);
            }
            if (!flatIn.equals(flatOut)) {
                Secure.putStringForUser(this.mContext.getContentResolver(), this.mConfig.secureSettingName, flatOut, userId);
            }
        }
    }

    private void rebindServices() {
        int i;
        Iterator i$;
        if (this.DEBUG) {
            Slog.d(this.TAG, "rebindServices");
        }
        int[] userIds = this.mUserProfiles.getCurrentProfileIds();
        int nUserIds = userIds.length;
        SparseArray<String> flat = new SparseArray();
        for (i = 0; i < nUserIds; i++) {
            int i2 = userIds[i];
            Context context = this.mContext;
            flat.put(i2, Secure.getStringForUser(r0.getContentResolver(), this.mConfig.secureSettingName, userIds[i]));
        }
        ArrayList<ManagedServiceInfo> toRemove = new ArrayList();
        SparseArray<ArrayList<ComponentName>> toAdd = new SparseArray();
        synchronized (this.mMutex) {
            i$ = this.mServices.iterator();
            while (i$.hasNext()) {
                ManagedServiceInfo service = (ManagedServiceInfo) i$.next();
                if (!service.isSystem) {
                    toRemove.add(service);
                }
            }
            ArraySet<ComponentName> newEnabled = new ArraySet();
            ArraySet<String> newPackages = new ArraySet();
            for (i = 0; i < nUserIds; i++) {
                int j;
                ComponentName component;
                ArrayList<ComponentName> add = new ArrayList();
                toAdd.put(userIds[i], add);
                String toDecode = (String) flat.get(userIds[i]);
                if (toDecode != null) {
                    String[] components = toDecode.split(ENABLED_SERVICES_SEPARATOR);
                    j = 0;
                    while (true) {
                        i2 = components.length;
                        if (j >= r0) {
                            break;
                        }
                        component = ComponentName.unflattenFromString(components[j]);
                        if (component != null) {
                            newEnabled.add(component);
                            add.add(component);
                            newPackages.add(component.getPackageName());
                        }
                        j++;
                    }
                }
            }
            this.mEnabledServicesForCurrentProfiles = newEnabled;
            this.mEnabledServicesPackageNames = newPackages;
        }
        i$ = toRemove.iterator();
        while (i$.hasNext()) {
            ManagedServiceInfo info = (ManagedServiceInfo) i$.next();
            component = info.component;
            int oldUser = info.userid;
            Slog.v(this.TAG, "disabling " + getCaption() + " for user " + oldUser + ": " + component);
            unregisterService(component, info.userid);
        }
        for (i = 0; i < nUserIds; i++) {
            add = (ArrayList) toAdd.get(userIds[i]);
            int N = add.size();
            for (j = 0; j < N; j++) {
                component = (ComponentName) add.get(j);
                Slog.v(this.TAG, "enabling " + getCaption() + " for user " + userIds[i] + ": " + component);
                registerService(component, userIds[i]);
            }
        }
        this.mLastSeenProfileIds = this.mUserProfiles.getCurrentProfileIds();
    }

    private void registerService(ComponentName name, int userid) {
        if (this.DEBUG) {
            Slog.v(this.TAG, "registerService: " + name + " u=" + userid);
        }
        synchronized (this.mMutex) {
            String servicesBindingTag = name.toString() + "/" + userid;
            if (this.mServicesBinding.contains(servicesBindingTag)) {
                return;
            }
            this.mServicesBinding.add(servicesBindingTag);
            for (int i = this.mServices.size() - 1; i >= 0; i--) {
                ManagedServiceInfo info = (ManagedServiceInfo) this.mServices.get(i);
                if (name.equals(info.component) && info.userid == userid) {
                    if (this.DEBUG) {
                        Slog.v(this.TAG, "    disconnecting old " + getCaption() + ": " + info.service);
                    }
                    removeServiceLocked(i);
                    if (info.connection != null) {
                        this.mContext.unbindService(info.connection);
                    }
                }
            }
            Intent intent = new Intent(this.mConfig.serviceInterface);
            intent.setComponent(name);
            intent.putExtra("android.intent.extra.client_label", this.mConfig.clientLabel);
            intent.putExtra("android.intent.extra.client_intent", PendingIntent.getActivity(this.mContext, 0, new Intent(this.mConfig.settingsAction), 0));
            ApplicationInfo appInfo = null;
            try {
                appInfo = this.mContext.getPackageManager().getApplicationInfo(name.getPackageName(), 0);
            } catch (NameNotFoundException e) {
            }
            int targetSdkVersion = appInfo != null ? appInfo.targetSdkVersion : 1;
            try {
                if (this.DEBUG) {
                    Slog.v(this.TAG, "binding: " + intent);
                }
                if (this.mContext.bindServiceAsUser(intent, new C04131(servicesBindingTag, userid, targetSdkVersion), 1, new UserHandle(userid))) {
                    return;
                }
                this.mServicesBinding.remove(servicesBindingTag);
                Slog.w(this.TAG, "Unable to bind " + getCaption() + " service: " + intent);
            } catch (SecurityException ex) {
                Slog.e(this.TAG, "Unable to bind " + getCaption() + " service: " + intent, ex);
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void unregisterService(android.content.ComponentName r9, int r10) {
        /*
        r8 = this;
        r5 = r8.mMutex;
        monitor-enter(r5);
        r4 = r8.mServices;	 Catch:{ all -> 0x005e }
        r0 = r4.size();	 Catch:{ all -> 0x005e }
        r2 = r0 + -1;
    L_0x000b:
        if (r2 < 0) goto L_0x0061;
    L_0x000d:
        r4 = r8.mServices;	 Catch:{ all -> 0x005e }
        r3 = r4.get(r2);	 Catch:{ all -> 0x005e }
        r3 = (com.android.server.notification.ManagedServices.ManagedServiceInfo) r3;	 Catch:{ all -> 0x005e }
        r4 = r3.component;	 Catch:{ all -> 0x005e }
        r4 = r9.equals(r4);	 Catch:{ all -> 0x005e }
        if (r4 == 0) goto L_0x002f;
    L_0x001d:
        r4 = r3.userid;	 Catch:{ all -> 0x005e }
        if (r4 != r10) goto L_0x002f;
    L_0x0021:
        r8.removeServiceLocked(r2);	 Catch:{ all -> 0x005e }
        r4 = r3.connection;	 Catch:{ all -> 0x005e }
        if (r4 == 0) goto L_0x002f;
    L_0x0028:
        r4 = r8.mContext;	 Catch:{ IllegalArgumentException -> 0x0032 }
        r6 = r3.connection;	 Catch:{ IllegalArgumentException -> 0x0032 }
        r4.unbindService(r6);	 Catch:{ IllegalArgumentException -> 0x0032 }
    L_0x002f:
        r2 = r2 + -1;
        goto L_0x000b;
    L_0x0032:
        r1 = move-exception;
        r4 = r8.TAG;	 Catch:{ all -> 0x005e }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x005e }
        r6.<init>();	 Catch:{ all -> 0x005e }
        r7 = r8.getCaption();	 Catch:{ all -> 0x005e }
        r6 = r6.append(r7);	 Catch:{ all -> 0x005e }
        r7 = " ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x005e }
        r6 = r6.append(r9);	 Catch:{ all -> 0x005e }
        r7 = " could not be unbound: ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x005e }
        r6 = r6.append(r1);	 Catch:{ all -> 0x005e }
        r6 = r6.toString();	 Catch:{ all -> 0x005e }
        android.util.Slog.e(r4, r6);	 Catch:{ all -> 0x005e }
        goto L_0x002f;
    L_0x005e:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x005e }
        throw r4;
    L_0x0061:
        monitor-exit(r5);	 Catch:{ all -> 0x005e }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.notification.ManagedServices.unregisterService(android.content.ComponentName, int):void");
    }

    private ManagedServiceInfo removeServiceImpl(IInterface service, int userid) {
        if (this.DEBUG) {
            Slog.d(this.TAG, "removeServiceImpl service=" + service + " u=" + userid);
        }
        ManagedServiceInfo serviceInfo = null;
        synchronized (this.mMutex) {
            for (int i = this.mServices.size() - 1; i >= 0; i--) {
                ManagedServiceInfo info = (ManagedServiceInfo) this.mServices.get(i);
                if (info.service.asBinder() == service.asBinder() && info.userid == userid) {
                    if (this.DEBUG) {
                        Slog.d(this.TAG, "Removing active service " + info.component);
                    }
                    serviceInfo = removeServiceLocked(i);
                }
            }
        }
        return serviceInfo;
    }

    private ManagedServiceInfo removeServiceLocked(int i) {
        ManagedServiceInfo info = (ManagedServiceInfo) this.mServices.remove(i);
        onServiceRemovedLocked(info);
        return info;
    }

    private void checkNotNull(IInterface service) {
        if (service == null) {
            throw new IllegalArgumentException(getCaption() + " must not be null");
        }
    }

    private ManagedServiceInfo registerServiceImpl(IInterface service, ComponentName component, int userid) {
        ManagedServiceInfo info;
        synchronized (this.mMutex) {
            try {
                info = newServiceInfo(service, component, userid, true, null, 21);
                service.asBinder().linkToDeath(info, 0);
                this.mServices.add(info);
            } catch (RemoteException e) {
                return null;
            }
        }
        return info;
    }

    private void unregisterServiceImpl(IInterface service, int userid) {
        ManagedServiceInfo info = removeServiceImpl(service, userid);
        if (info != null && info.connection != null) {
            this.mContext.unbindService(info.connection);
        }
    }
}
