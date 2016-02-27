package com.android.server.search;

import android.app.ActivityManager;
import android.app.ActivityManagerNative;
import android.app.AppGlobals;
import android.app.ISearchManager.Stub;
import android.app.SearchableInfo;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.IPackageManager;
import android.content.pm.ResolveInfo;
import android.database.ContentObserver;
import android.os.Binder;
import android.os.Process;
import android.os.RemoteException;
import android.os.UserHandle;
import android.os.UserManager;
import android.provider.Settings.Secure;
import android.util.Log;
import android.util.SparseArray;
import com.android.internal.content.PackageMonitor;
import java.util.List;

public class SearchManagerService extends Stub {
    private static final String TAG = "SearchManagerService";
    private final Context mContext;
    private final SparseArray<Searchables> mSearchables;

    private final class BootCompletedReceiver extends BroadcastReceiver {

        /* renamed from: com.android.server.search.SearchManagerService.BootCompletedReceiver.1 */
        class C05061 extends Thread {
            C05061() {
            }

            public void run() {
                Process.setThreadPriority(10);
                SearchManagerService.this.mContext.unregisterReceiver(BootCompletedReceiver.this);
                SearchManagerService.this.getSearchables(0);
            }
        }

        private BootCompletedReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            new C05061().start();
        }
    }

    class GlobalSearchProviderObserver extends ContentObserver {
        private final ContentResolver mResolver;

        public GlobalSearchProviderObserver(ContentResolver resolver) {
            super(null);
            this.mResolver = resolver;
            this.mResolver.registerContentObserver(Secure.getUriFor("search_global_search_activity"), false, this);
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onChange(boolean r6) {
            /*
            r5 = this;
            r2 = com.android.server.search.SearchManagerService.this;
            r3 = r2.mSearchables;
            monitor-enter(r3);
            r0 = 0;
        L_0x0008:
            r2 = com.android.server.search.SearchManagerService.this;	 Catch:{ all -> 0x0043 }
            r2 = r2.mSearchables;	 Catch:{ all -> 0x0043 }
            r2 = r2.size();	 Catch:{ all -> 0x0043 }
            if (r0 >= r2) goto L_0x002a;
        L_0x0014:
            r2 = com.android.server.search.SearchManagerService.this;	 Catch:{ all -> 0x0043 }
            r4 = com.android.server.search.SearchManagerService.this;	 Catch:{ all -> 0x0043 }
            r4 = r4.mSearchables;	 Catch:{ all -> 0x0043 }
            r4 = r4.keyAt(r0);	 Catch:{ all -> 0x0043 }
            r2 = r2.getSearchables(r4);	 Catch:{ all -> 0x0043 }
            r2.buildSearchableList();	 Catch:{ all -> 0x0043 }
            r0 = r0 + 1;
            goto L_0x0008;
        L_0x002a:
            monitor-exit(r3);	 Catch:{ all -> 0x0043 }
            r1 = new android.content.Intent;
            r2 = "android.search.action.GLOBAL_SEARCH_ACTIVITY_CHANGED";
            r1.<init>(r2);
            r2 = 536870912; // 0x20000000 float:1.0842022E-19 double:2.652494739E-315;
            r1.addFlags(r2);
            r2 = com.android.server.search.SearchManagerService.this;
            r2 = r2.mContext;
            r3 = android.os.UserHandle.ALL;
            r2.sendBroadcastAsUser(r1, r3);
            return;
        L_0x0043:
            r2 = move-exception;
            monitor-exit(r3);	 Catch:{ all -> 0x0043 }
            throw r2;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.search.SearchManagerService.GlobalSearchProviderObserver.onChange(boolean):void");
        }
    }

    class MyPackageMonitor extends PackageMonitor {
        MyPackageMonitor() {
        }

        public void onSomePackagesChanged() {
            updateSearchables();
        }

        public void onPackageModified(String pkg) {
            updateSearchables();
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private void updateSearchables() {
            /*
            r6 = this;
            r0 = r6.getChangingUserId();
            r3 = com.android.server.search.SearchManagerService.this;
            r4 = r3.mSearchables;
            monitor-enter(r4);
            r1 = 0;
        L_0x000c:
            r3 = com.android.server.search.SearchManagerService.this;	 Catch:{ all -> 0x0056 }
            r3 = r3.mSearchables;	 Catch:{ all -> 0x0056 }
            r3 = r3.size();	 Catch:{ all -> 0x0056 }
            if (r1 >= r3) goto L_0x0037;
        L_0x0018:
            r3 = com.android.server.search.SearchManagerService.this;	 Catch:{ all -> 0x0056 }
            r3 = r3.mSearchables;	 Catch:{ all -> 0x0056 }
            r3 = r3.keyAt(r1);	 Catch:{ all -> 0x0056 }
            if (r0 != r3) goto L_0x0053;
        L_0x0024:
            r3 = com.android.server.search.SearchManagerService.this;	 Catch:{ all -> 0x0056 }
            r5 = com.android.server.search.SearchManagerService.this;	 Catch:{ all -> 0x0056 }
            r5 = r5.mSearchables;	 Catch:{ all -> 0x0056 }
            r5 = r5.keyAt(r1);	 Catch:{ all -> 0x0056 }
            r3 = r3.getSearchables(r5);	 Catch:{ all -> 0x0056 }
            r3.buildSearchableList();	 Catch:{ all -> 0x0056 }
        L_0x0037:
            monitor-exit(r4);	 Catch:{ all -> 0x0056 }
            r2 = new android.content.Intent;
            r3 = "android.search.action.SEARCHABLES_CHANGED";
            r2.<init>(r3);
            r3 = 603979776; // 0x24000000 float:2.7755576E-17 double:2.98405658E-315;
            r2.addFlags(r3);
            r3 = com.android.server.search.SearchManagerService.this;
            r3 = r3.mContext;
            r4 = new android.os.UserHandle;
            r4.<init>(r0);
            r3.sendBroadcastAsUser(r2, r4);
            return;
        L_0x0053:
            r1 = r1 + 1;
            goto L_0x000c;
        L_0x0056:
            r3 = move-exception;
            monitor-exit(r4);	 Catch:{ all -> 0x0056 }
            throw r3;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.search.SearchManagerService.MyPackageMonitor.updateSearchables():void");
        }
    }

    private final class UserReceiver extends BroadcastReceiver {
        private UserReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            SearchManagerService.this.onUserRemoved(intent.getIntExtra("android.intent.extra.user_handle", 0));
        }
    }

    public SearchManagerService(Context context) {
        this.mSearchables = new SparseArray();
        this.mContext = context;
        IntentFilter filter = new IntentFilter("android.intent.action.BOOT_COMPLETED");
        filter.setPriority(ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
        this.mContext.registerReceiver(new BootCompletedReceiver(), filter);
        this.mContext.registerReceiver(new UserReceiver(), new IntentFilter("android.intent.action.USER_REMOVED"));
        new MyPackageMonitor().register(context, null, UserHandle.ALL, true);
    }

    private Searchables getSearchables(int userId) {
        long origId = Binder.clearCallingIdentity();
        try {
            if (!(((UserManager) this.mContext.getSystemService("user")).getUserInfo(userId) != null)) {
                return null;
            }
            Searchables searchables;
            Binder.restoreCallingIdentity(origId);
            synchronized (this.mSearchables) {
                searchables = (Searchables) this.mSearchables.get(userId);
                if (searchables == null) {
                    searchables = new Searchables(this.mContext, userId);
                    searchables.buildSearchableList();
                    this.mSearchables.append(userId, searchables);
                }
            }
            return searchables;
        } finally {
            Binder.restoreCallingIdentity(origId);
        }
    }

    private void onUserRemoved(int userId) {
        if (userId != 0) {
            synchronized (this.mSearchables) {
                this.mSearchables.remove(userId);
            }
        }
    }

    public SearchableInfo getSearchableInfo(ComponentName launchActivity) {
        if (launchActivity != null) {
            return getSearchables(UserHandle.getCallingUserId()).getSearchableInfo(launchActivity);
        }
        Log.e(TAG, "getSearchableInfo(), activity == null");
        return null;
    }

    public List<SearchableInfo> getSearchablesInGlobalSearch() {
        return getSearchables(UserHandle.getCallingUserId()).getSearchablesInGlobalSearchList();
    }

    public List<ResolveInfo> getGlobalSearchActivities() {
        return getSearchables(UserHandle.getCallingUserId()).getGlobalSearchActivities();
    }

    public ComponentName getGlobalSearchActivity() {
        return getSearchables(UserHandle.getCallingUserId()).getGlobalSearchActivity();
    }

    public ComponentName getWebSearchActivity() {
        return getSearchables(UserHandle.getCallingUserId()).getWebSearchActivity();
    }

    public ComponentName getAssistIntent(int userHandle) {
        try {
            userHandle = ActivityManager.handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userHandle, true, false, "getAssistIntent", null);
            IPackageManager pm = AppGlobals.getPackageManager();
            Intent assistIntent = new Intent("android.intent.action.ASSIST");
            ResolveInfo info = pm.resolveIntent(assistIntent, assistIntent.resolveTypeIfNeeded(this.mContext.getContentResolver()), 65536, userHandle);
            if (info != null) {
                return new ComponentName(info.activityInfo.applicationInfo.packageName, info.activityInfo.name);
            }
        } catch (RemoteException re) {
            Log.e(TAG, "RemoteException in getAssistIntent: " + re);
        } catch (Exception e) {
            Log.e(TAG, "Exception in getAssistIntent: " + e);
        }
        return null;
    }

    public boolean launchAssistAction(int requestType, String hint, int userHandle) {
        ComponentName comp = getAssistIntent(userHandle);
        if (comp == null) {
            return false;
        }
        long ident = Binder.clearCallingIdentity();
        boolean launchAssistIntent;
        try {
            Intent intent = new Intent("android.intent.action.ASSIST");
            intent.setComponent(comp);
            launchAssistIntent = ActivityManagerNative.getDefault().launchAssistIntent(intent, requestType, hint, userHandle);
            return launchAssistIntent;
        } catch (RemoteException e) {
            launchAssistIntent = e;
            return true;
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void dump(java.io.FileDescriptor r6, java.io.PrintWriter r7, java.lang.String[] r8) {
        /*
        r5 = this;
        r2 = r5.mContext;
        r3 = "android.permission.DUMP";
        r4 = "SearchManagerService";
        r2.enforceCallingOrSelfPermission(r3, r4);
        r1 = new com.android.internal.util.IndentingPrintWriter;
        r2 = "  ";
        r1.<init>(r7, r2);
        r3 = r5.mSearchables;
        monitor-enter(r3);
        r0 = 0;
    L_0x0014:
        r2 = r5.mSearchables;	 Catch:{ all -> 0x0040 }
        r2 = r2.size();	 Catch:{ all -> 0x0040 }
        if (r0 >= r2) goto L_0x003e;
    L_0x001c:
        r2 = "\nUser: ";
        r1.print(r2);	 Catch:{ all -> 0x0040 }
        r2 = r5.mSearchables;	 Catch:{ all -> 0x0040 }
        r2 = r2.keyAt(r0);	 Catch:{ all -> 0x0040 }
        r1.println(r2);	 Catch:{ all -> 0x0040 }
        r1.increaseIndent();	 Catch:{ all -> 0x0040 }
        r2 = r5.mSearchables;	 Catch:{ all -> 0x0040 }
        r2 = r2.valueAt(r0);	 Catch:{ all -> 0x0040 }
        r2 = (com.android.server.search.Searchables) r2;	 Catch:{ all -> 0x0040 }
        r2.dump(r6, r1, r8);	 Catch:{ all -> 0x0040 }
        r1.decreaseIndent();	 Catch:{ all -> 0x0040 }
        r0 = r0 + 1;
        goto L_0x0014;
    L_0x003e:
        monitor-exit(r3);	 Catch:{ all -> 0x0040 }
        return;
    L_0x0040:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0040 }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.search.SearchManagerService.dump(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String[]):void");
    }
}
