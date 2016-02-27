package com.android.server.print;

import android.app.ActivityManager;
import android.app.ActivityManagerNative;
import android.app.Notification.Builder;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.pm.UserInfo;
import android.database.ContentObserver;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.RemoteException;
import android.os.UserHandle;
import android.os.UserManager;
import android.print.IPrintDocumentAdapter;
import android.print.IPrintJobStateChangeListener;
import android.print.IPrintManager.Stub;
import android.print.IPrinterDiscoveryObserver;
import android.print.PrintAttributes;
import android.print.PrintJobId;
import android.print.PrintJobInfo;
import android.print.PrinterId;
import android.printservice.PrintServiceInfo;
import android.provider.Settings.Secure;
import android.text.TextUtils;
import android.util.SparseArray;
import com.android.internal.content.PackageMonitor;
import com.android.internal.os.BackgroundThread;
import com.android.server.SystemService;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public final class PrintManagerService extends SystemService {
    private final PrintManagerImpl mPrintManagerImpl;

    class PrintManagerImpl extends Stub {
        private static final int BACKGROUND_USER_ID = -10;
        private static final char COMPONENT_NAME_SEPARATOR = ':';
        private static final String EXTRA_PRINT_SERVICE_COMPONENT_NAME = "EXTRA_PRINT_SERVICE_COMPONENT_NAME";
        private final Context mContext;
        private final Object mLock;
        private final UserManager mUserManager;
        private final SparseArray<UserState> mUserStates;

        /* renamed from: com.android.server.print.PrintManagerService.PrintManagerImpl.1 */
        class C04811 extends ContentObserver {
            final /* synthetic */ Uri val$enabledPrintServicesUri;

            C04811(Handler x0, Uri uri) {
                this.val$enabledPrintServicesUri = uri;
                super(x0);
            }

            public void onChange(boolean selfChange, Uri uri, int userId) {
                if (this.val$enabledPrintServicesUri.equals(uri)) {
                    synchronized (PrintManagerImpl.this.mLock) {
                        if (userId != -1) {
                            PrintManagerImpl.this.getOrCreateUserStateLocked(userId).updateIfNeededLocked();
                        } else {
                            int userCount = PrintManagerImpl.this.mUserStates.size();
                            for (int i = 0; i < userCount; i++) {
                                ((UserState) PrintManagerImpl.this.mUserStates.valueAt(i)).updateIfNeededLocked();
                            }
                        }
                    }
                }
            }
        }

        /* renamed from: com.android.server.print.PrintManagerService.PrintManagerImpl.2 */
        class C04822 extends PackageMonitor {
            C04822() {
            }

            public void onPackageModified(String packageName) {
                synchronized (PrintManagerImpl.this.mLock) {
                    boolean servicesChanged = false;
                    UserState userState = PrintManagerImpl.this.getOrCreateUserStateLocked(getChangingUserId());
                    for (ComponentName componentName : userState.getEnabledServices()) {
                        if (packageName.equals(componentName.getPackageName())) {
                            servicesChanged = true;
                        }
                    }
                    if (servicesChanged) {
                        userState.updateIfNeededLocked();
                    }
                }
            }

            public void onPackageRemoved(String packageName, int uid) {
                synchronized (PrintManagerImpl.this.mLock) {
                    boolean servicesRemoved = false;
                    UserState userState = PrintManagerImpl.this.getOrCreateUserStateLocked(getChangingUserId());
                    Iterator<ComponentName> iterator = userState.getEnabledServices().iterator();
                    while (iterator.hasNext()) {
                        if (packageName.equals(((ComponentName) iterator.next()).getPackageName())) {
                            iterator.remove();
                            servicesRemoved = true;
                        }
                    }
                    if (servicesRemoved) {
                        persistComponentNamesToSettingLocked("enabled_print_services", userState.getEnabledServices(), getChangingUserId());
                        userState.updateIfNeededLocked();
                    }
                }
            }

            public boolean onHandleForceStop(Intent intent, String[] stoppedPackages, int uid, boolean doit) {
                boolean z;
                synchronized (PrintManagerImpl.this.mLock) {
                    UserState userState = PrintManagerImpl.this.getOrCreateUserStateLocked(getChangingUserId());
                    boolean stoppedSomePackages = false;
                    for (ComponentName componentName : userState.getEnabledServices()) {
                        String componentPackage = componentName.getPackageName();
                        String[] arr$ = stoppedPackages;
                        int len$ = arr$.length;
                        int i$ = 0;
                        while (i$ < len$) {
                            if (!componentPackage.equals(arr$[i$])) {
                                i$++;
                            } else if (!doit) {
                                z = true;
                                break;
                            } else {
                                stoppedSomePackages = true;
                            }
                        }
                    }
                    if (stoppedSomePackages) {
                        userState.updateIfNeededLocked();
                    }
                    z = false;
                }
                return z;
            }

            public void onPackageAdded(String packageName, int uid) {
                Intent intent = new Intent("android.printservice.PrintService");
                intent.setPackage(packageName);
                List<ResolveInfo> installedServices = PrintManagerImpl.this.mContext.getPackageManager().queryIntentServicesAsUser(intent, 4, getChangingUserId());
                if (installedServices != null) {
                    int installedServiceCount = installedServices.size();
                    for (int i = 0; i < installedServiceCount; i++) {
                        ServiceInfo serviceInfo = ((ResolveInfo) installedServices.get(i)).serviceInfo;
                        PrintManagerImpl.this.showEnableInstalledPrintServiceNotification(new ComponentName(serviceInfo.packageName, serviceInfo.name), serviceInfo.loadLabel(PrintManagerImpl.this.mContext.getPackageManager()).toString(), getChangingUserId());
                    }
                }
            }

            private void persistComponentNamesToSettingLocked(String settingName, Set<ComponentName> componentNames, int userId) {
                StringBuilder builder = new StringBuilder();
                for (ComponentName componentName : componentNames) {
                    if (builder.length() > 0) {
                        builder.append(PrintManagerImpl.COMPONENT_NAME_SEPARATOR);
                    }
                    builder.append(componentName.flattenToShortString());
                }
                Secure.putStringForUser(PrintManagerImpl.this.mContext.getContentResolver(), settingName, builder.toString(), userId);
            }
        }

        /* renamed from: com.android.server.print.PrintManagerService.PrintManagerImpl.3 */
        class C04833 implements Runnable {
            final /* synthetic */ int val$userId;

            C04833(int i) {
                this.val$userId = i;
            }

            public void run() {
                UserState userState;
                synchronized (PrintManagerImpl.this.mLock) {
                    userState = PrintManagerImpl.this.getOrCreateUserStateLocked(this.val$userId);
                    userState.updateIfNeededLocked();
                }
                userState.removeObsoletePrintJobs();
            }
        }

        /* renamed from: com.android.server.print.PrintManagerService.PrintManagerImpl.4 */
        class C04844 implements Runnable {
            final /* synthetic */ int val$userId;

            C04844(int i) {
                this.val$userId = i;
            }

            public void run() {
                synchronized (PrintManagerImpl.this.mLock) {
                    UserState userState = (UserState) PrintManagerImpl.this.mUserStates.get(this.val$userId);
                    if (userState != null) {
                        userState.destroyLocked();
                        PrintManagerImpl.this.mUserStates.remove(this.val$userId);
                    }
                }
            }
        }

        PrintManagerImpl(Context context) {
            this.mLock = new Object();
            this.mUserStates = new SparseArray();
            this.mContext = context;
            this.mUserManager = (UserManager) context.getSystemService("user");
            registerContentObservers();
            registerBroadcastReceivers();
        }

        public Bundle print(String printJobName, IPrintDocumentAdapter adapter, PrintAttributes attributes, String packageName, int appId, int userId) {
            Bundle bundle;
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    bundle = null;
                } else {
                    int resolvedAppId = resolveCallingAppEnforcingPermissions(appId);
                    String resolvedPackageName = resolveCallingPackageNameEnforcingSecurity(packageName);
                    UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                    long identity = Binder.clearCallingIdentity();
                    try {
                        bundle = userState.print(printJobName, adapter, attributes, resolvedPackageName, resolvedAppId);
                    } finally {
                        Binder.restoreCallingIdentity(identity);
                    }
                }
            }
            return bundle;
        }

        public List<PrintJobInfo> getPrintJobInfos(int appId, int userId) {
            List<PrintJobInfo> list;
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    list = null;
                } else {
                    int resolvedAppId = resolveCallingAppEnforcingPermissions(appId);
                    UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                    long identity = Binder.clearCallingIdentity();
                    try {
                        list = userState.getPrintJobInfos(resolvedAppId);
                    } finally {
                        Binder.restoreCallingIdentity(identity);
                    }
                }
            }
            return list;
        }

        public PrintJobInfo getPrintJobInfo(PrintJobId printJobId, int appId, int userId) {
            PrintJobInfo printJobInfo;
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    printJobInfo = null;
                } else {
                    int resolvedAppId = resolveCallingAppEnforcingPermissions(appId);
                    UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                    long identity = Binder.clearCallingIdentity();
                    try {
                        printJobInfo = userState.getPrintJobInfo(printJobId, resolvedAppId);
                    } finally {
                        Binder.restoreCallingIdentity(identity);
                    }
                }
            }
            return printJobInfo;
        }

        public void cancelPrintJob(PrintJobId printJobId, int appId, int userId) {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                int resolvedAppId = resolveCallingAppEnforcingPermissions(appId);
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.cancelPrintJob(printJobId, resolvedAppId);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void restartPrintJob(PrintJobId printJobId, int appId, int userId) {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                int resolvedAppId = resolveCallingAppEnforcingPermissions(appId);
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.restartPrintJob(printJobId, resolvedAppId);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public List<PrintServiceInfo> getEnabledPrintServices(int userId) {
            List<PrintServiceInfo> list;
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    list = null;
                } else {
                    UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                    long identity = Binder.clearCallingIdentity();
                    try {
                        list = userState.getEnabledPrintServices();
                    } finally {
                        Binder.restoreCallingIdentity(identity);
                    }
                }
            }
            return list;
        }

        public List<PrintServiceInfo> getInstalledPrintServices(int userId) {
            List<PrintServiceInfo> list;
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    list = null;
                } else {
                    UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                    long identity = Binder.clearCallingIdentity();
                    try {
                        list = userState.getInstalledPrintServices();
                    } finally {
                        Binder.restoreCallingIdentity(identity);
                    }
                }
            }
            return list;
        }

        public void createPrinterDiscoverySession(IPrinterDiscoveryObserver observer, int userId) {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.createPrinterDiscoverySession(observer);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void destroyPrinterDiscoverySession(IPrinterDiscoveryObserver observer, int userId) {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.destroyPrinterDiscoverySession(observer);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void startPrinterDiscovery(IPrinterDiscoveryObserver observer, List<PrinterId> priorityList, int userId) {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.startPrinterDiscovery(observer, priorityList);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void stopPrinterDiscovery(IPrinterDiscoveryObserver observer, int userId) {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.stopPrinterDiscovery(observer);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void validatePrinters(List<PrinterId> printerIds, int userId) {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.validatePrinters(printerIds);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void startPrinterStateTracking(PrinterId printerId, int userId) {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.startPrinterStateTracking(printerId);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void stopPrinterStateTracking(PrinterId printerId, int userId) {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.stopPrinterStateTracking(printerId);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void addPrintJobStateChangeListener(IPrintJobStateChangeListener listener, int appId, int userId) throws RemoteException {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                int resolvedAppId = resolveCallingAppEnforcingPermissions(appId);
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.addPrintJobStateChangeListener(listener, resolvedAppId);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void removePrintJobStateChangeListener(IPrintJobStateChangeListener listener, int userId) {
            int resolvedUserId = resolveCallingUserEnforcingPermissions(userId);
            synchronized (this.mLock) {
                if (resolveCallingProfileParentLocked(resolvedUserId) != getCurrentUserId()) {
                    return;
                }
                UserState userState = getOrCreateUserStateLocked(resolvedUserId);
                long identity = Binder.clearCallingIdentity();
                try {
                    userState.removePrintJobStateChangeListener(listener);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump PrintManager from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
                return;
            }
            synchronized (this.mLock) {
                long identity = Binder.clearCallingIdentity();
                try {
                    pw.println("PRINT MANAGER STATE (dumpsys print)");
                    int userStateCount = this.mUserStates.size();
                    for (int i = 0; i < userStateCount; i++) {
                        ((UserState) this.mUserStates.valueAt(i)).dump(fd, pw, "");
                        pw.println();
                    }
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        private void registerContentObservers() {
            Uri enabledPrintServicesUri = Secure.getUriFor("enabled_print_services");
            this.mContext.getContentResolver().registerContentObserver(enabledPrintServicesUri, false, new C04811(BackgroundThread.getHandler(), enabledPrintServicesUri), -1);
        }

        private void registerBroadcastReceivers() {
            new C04822().register(this.mContext, BackgroundThread.getHandler().getLooper(), UserHandle.ALL, true);
        }

        private UserState getOrCreateUserStateLocked(int userId) {
            UserState userState = (UserState) this.mUserStates.get(userId);
            if (userState != null) {
                return userState;
            }
            userState = new UserState(this.mContext, userId, this.mLock);
            this.mUserStates.put(userId, userState);
            return userState;
        }

        private void handleUserStarted(int userId) {
            BackgroundThread.getHandler().post(new C04833(userId));
        }

        private void handleUserStopped(int userId) {
            BackgroundThread.getHandler().post(new C04844(userId));
        }

        private int resolveCallingProfileParentLocked(int userId) {
            if (userId == getCurrentUserId()) {
                return userId;
            }
            long identity = Binder.clearCallingIdentity();
            try {
                UserInfo parent = this.mUserManager.getProfileParent(userId);
                if (parent != null) {
                    userId = parent.getUserHandle().getIdentifier();
                    return userId;
                }
                Binder.restoreCallingIdentity(identity);
                return BACKGROUND_USER_ID;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        private int resolveCallingAppEnforcingPermissions(int appId) {
            int callingUid = Binder.getCallingUid();
            if (!(callingUid == 0 || callingUid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || callingUid == 2000)) {
                int callingAppId = UserHandle.getAppId(callingUid);
                if (!(appId == callingAppId || this.mContext.checkCallingPermission("com.android.printspooler.permission.ACCESS_ALL_PRINT_JOBS") == 0)) {
                    throw new SecurityException("Call from app " + callingAppId + " as app " + appId + " without com.android.printspooler.permission" + ".ACCESS_ALL_PRINT_JOBS");
                }
            }
            return appId;
        }

        private int resolveCallingUserEnforcingPermissions(int userId) {
            try {
                userId = ActivityManagerNative.getDefault().handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, true, true, "", null);
            } catch (RemoteException e) {
            }
            return userId;
        }

        private String resolveCallingPackageNameEnforcingSecurity(String packageName) {
            if (TextUtils.isEmpty(packageName)) {
                return null;
            }
            for (Object equals : this.mContext.getPackageManager().getPackagesForUid(Binder.getCallingUid())) {
                if (packageName.equals(equals)) {
                    return packageName;
                }
            }
            return null;
        }

        private int getCurrentUserId() {
            long identity = Binder.clearCallingIdentity();
            try {
                int currentUser = ActivityManager.getCurrentUser();
                return currentUser;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        private void showEnableInstalledPrintServiceNotification(ComponentName component, String label, int userId) {
            UserHandle userHandle = new UserHandle(userId);
            Intent intent = new Intent("android.settings.ACTION_PRINT_SETTINGS");
            intent.putExtra(EXTRA_PRINT_SERVICE_COMPONENT_NAME, component.flattenToString());
            PendingIntent pendingIntent = PendingIntent.getActivityAsUser(this.mContext, 0, intent, 1342177280, null, userHandle);
            Context builderContext = this.mContext;
            try {
                builderContext = this.mContext.createPackageContextAsUser(this.mContext.getPackageName(), 0, userHandle);
            } catch (NameNotFoundException e) {
            }
            ((NotificationManager) this.mContext.getSystemService("notification")).notifyAsUser(getClass().getName() + ":" + component.flattenToString(), 0, new Builder(builderContext).setSmallIcon(17302573).setContentTitle(this.mContext.getString(17041017, new Object[]{label})).setContentText(this.mContext.getString(17041018)).setContentIntent(pendingIntent).setWhen(System.currentTimeMillis()).setAutoCancel(true).setShowWhen(true).setColor(this.mContext.getResources().getColor(17170521)).build(), userHandle);
        }
    }

    public PrintManagerService(Context context) {
        super(context);
        this.mPrintManagerImpl = new PrintManagerImpl(context);
    }

    public void onStart() {
        publishBinderService("print", this.mPrintManagerImpl);
    }

    public void onStartUser(int userHandle) {
        this.mPrintManagerImpl.handleUserStarted(userHandle);
    }

    public void onStopUser(int userHandle) {
        this.mPrintManagerImpl.handleUserStopped(userHandle);
    }
}
