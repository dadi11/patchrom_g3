package com.android.server.search;

import android.app.AppGlobals;
import android.app.SearchableInfo;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.IPackageManager;
import android.content.pm.ResolveInfo;
import android.os.Binder;
import android.os.Bundle;
import android.os.RemoteException;
import android.provider.Settings.Secure;
import android.text.TextUtils;
import android.util.Log;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

public class Searchables {
    public static String ENHANCED_GOOGLE_SEARCH_COMPONENT_NAME = null;
    private static final Comparator<ResolveInfo> GLOBAL_SEARCH_RANKER;
    public static String GOOGLE_SEARCH_COMPONENT_NAME = null;
    private static final String LOG_TAG = "Searchables";
    private static final String MD_LABEL_DEFAULT_SEARCHABLE = "android.app.default_searchable";
    private static final String MD_SEARCHABLE_SYSTEM_SEARCH = "*";
    private Context mContext;
    private ComponentName mCurrentGlobalSearchActivity;
    private List<ResolveInfo> mGlobalSearchActivities;
    private final IPackageManager mPm;
    private ArrayList<SearchableInfo> mSearchablesInGlobalSearchList;
    private ArrayList<SearchableInfo> mSearchablesList;
    private HashMap<ComponentName, SearchableInfo> mSearchablesMap;
    private int mUserId;
    private ComponentName mWebSearchActivity;

    /* renamed from: com.android.server.search.Searchables.1 */
    static class C05071 implements Comparator<ResolveInfo> {
        C05071() {
        }

        public int compare(ResolveInfo lhs, ResolveInfo rhs) {
            if (lhs == rhs) {
                return 0;
            }
            boolean lhsSystem = Searchables.isSystemApp(lhs);
            boolean rhsSystem = Searchables.isSystemApp(rhs);
            if (lhsSystem && !rhsSystem) {
                return -1;
            }
            if (!rhsSystem || lhsSystem) {
                return rhs.priority - lhs.priority;
            }
            return 1;
        }
    }

    static {
        GOOGLE_SEARCH_COMPONENT_NAME = "com.android.googlesearch/.GoogleSearch";
        ENHANCED_GOOGLE_SEARCH_COMPONENT_NAME = "com.google.android.providers.enhancedgooglesearch/.Launcher";
        GLOBAL_SEARCH_RANKER = new C05071();
    }

    public Searchables(Context context, int userId) {
        this.mSearchablesMap = null;
        this.mSearchablesList = null;
        this.mSearchablesInGlobalSearchList = null;
        this.mCurrentGlobalSearchActivity = null;
        this.mWebSearchActivity = null;
        this.mContext = context;
        this.mUserId = userId;
        this.mPm = AppGlobals.getPackageManager();
    }

    public SearchableInfo getSearchableInfo(ComponentName activity) {
        synchronized (this) {
            SearchableInfo result = (SearchableInfo) this.mSearchablesMap.get(activity);
            if (result != null) {
                return result;
            }
            try {
                ActivityInfo ai = this.mPm.getActivityInfo(activity, DumpState.DUMP_PROVIDERS, this.mUserId);
                String refActivityName = null;
                Bundle md = ai.metaData;
                if (md != null) {
                    refActivityName = md.getString(MD_LABEL_DEFAULT_SEARCHABLE);
                }
                if (refActivityName == null) {
                    md = ai.applicationInfo.metaData;
                    if (md != null) {
                        refActivityName = md.getString(MD_LABEL_DEFAULT_SEARCHABLE);
                    }
                }
                if (refActivityName != null) {
                    if (refActivityName.equals(MD_SEARCHABLE_SYSTEM_SEARCH)) {
                        return null;
                    }
                    ComponentName referredActivity;
                    String pkg = activity.getPackageName();
                    if (refActivityName.charAt(0) == '.') {
                        referredActivity = new ComponentName(pkg, pkg + refActivityName);
                    } else {
                        referredActivity = new ComponentName(pkg, refActivityName);
                    }
                    synchronized (this) {
                        result = (SearchableInfo) this.mSearchablesMap.get(referredActivity);
                        if (result != null) {
                            this.mSearchablesMap.put(activity, result);
                            return result;
                        }
                    }
                }
                return null;
            } catch (RemoteException re) {
                Log.e(LOG_TAG, "Error getting activity info " + re);
                return null;
            }
        }
    }

    public void buildSearchableList() {
        HashMap<ComponentName, SearchableInfo> newSearchablesMap = new HashMap();
        ArrayList<SearchableInfo> newSearchablesList = new ArrayList();
        ArrayList<SearchableInfo> newSearchablesInGlobalSearchList = new ArrayList();
        Intent intent = new Intent("android.intent.action.SEARCH");
        long ident = Binder.clearCallingIdentity();
        try {
            List<ResolveInfo> searchList = queryIntentActivities(intent, DumpState.DUMP_PROVIDERS);
            List<ResolveInfo> webSearchInfoList = queryIntentActivities(new Intent("android.intent.action.WEB_SEARCH"), DumpState.DUMP_PROVIDERS);
            if (!(searchList == null && webSearchInfoList == null)) {
                int search_count = searchList == null ? 0 : searchList.size();
                int count = search_count + (webSearchInfoList == null ? 0 : webSearchInfoList.size());
                for (int ii = 0; ii < count; ii++) {
                    ResolveInfo info;
                    if (ii < search_count) {
                        info = (ResolveInfo) searchList.get(ii);
                    } else {
                        info = (ResolveInfo) webSearchInfoList.get(ii - search_count);
                    }
                    ActivityInfo ai = info.activityInfo;
                    if (newSearchablesMap.get(new ComponentName(ai.packageName, ai.name)) == null) {
                        SearchableInfo searchable = SearchableInfo.getActivityMetaData(this.mContext, ai, this.mUserId);
                        if (searchable != null) {
                            newSearchablesList.add(searchable);
                            newSearchablesMap.put(searchable.getSearchActivity(), searchable);
                            if (searchable.shouldIncludeInGlobalSearch()) {
                                newSearchablesInGlobalSearchList.add(searchable);
                            }
                        }
                    }
                }
            }
            List<ResolveInfo> newGlobalSearchActivities = findGlobalSearchActivities();
            ComponentName newGlobalSearchActivity = findGlobalSearchActivity(newGlobalSearchActivities);
            ComponentName newWebSearchActivity = findWebSearchActivity(newGlobalSearchActivity);
            synchronized (this) {
                this.mSearchablesMap = newSearchablesMap;
                this.mSearchablesList = newSearchablesList;
                this.mSearchablesInGlobalSearchList = newSearchablesInGlobalSearchList;
                this.mGlobalSearchActivities = newGlobalSearchActivities;
                this.mCurrentGlobalSearchActivity = newGlobalSearchActivity;
                this.mWebSearchActivity = newWebSearchActivity;
            }
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private List<ResolveInfo> findGlobalSearchActivities() {
        List<ResolveInfo> activities = queryIntentActivities(new Intent("android.search.action.GLOBAL_SEARCH"), 65536);
        if (!(activities == null || activities.isEmpty())) {
            Collections.sort(activities, GLOBAL_SEARCH_RANKER);
        }
        return activities;
    }

    private ComponentName findGlobalSearchActivity(List<ResolveInfo> installed) {
        String searchProviderSetting = getGlobalSearchProviderSetting();
        if (!TextUtils.isEmpty(searchProviderSetting)) {
            ComponentName globalSearchComponent = ComponentName.unflattenFromString(searchProviderSetting);
            if (globalSearchComponent != null && isInstalled(globalSearchComponent)) {
                return globalSearchComponent;
            }
        }
        return getDefaultGlobalSearchProvider(installed);
    }

    private boolean isInstalled(ComponentName globalSearch) {
        Intent intent = new Intent("android.search.action.GLOBAL_SEARCH");
        intent.setComponent(globalSearch);
        List<ResolveInfo> activities = queryIntentActivities(intent, 65536);
        if (activities == null || activities.isEmpty()) {
            return false;
        }
        return true;
    }

    private static final boolean isSystemApp(ResolveInfo res) {
        return (res.activityInfo.applicationInfo.flags & 1) != 0;
    }

    private ComponentName getDefaultGlobalSearchProvider(List<ResolveInfo> providerList) {
        if (providerList == null || providerList.isEmpty()) {
            Log.w(LOG_TAG, "No global search activity found");
            return null;
        }
        ActivityInfo ai = ((ResolveInfo) providerList.get(0)).activityInfo;
        return new ComponentName(ai.packageName, ai.name);
    }

    private String getGlobalSearchProviderSetting() {
        return Secure.getString(this.mContext.getContentResolver(), "search_global_search_activity");
    }

    private ComponentName findWebSearchActivity(ComponentName globalSearchActivity) {
        if (globalSearchActivity == null) {
            return null;
        }
        Intent intent = new Intent("android.intent.action.WEB_SEARCH");
        intent.setPackage(globalSearchActivity.getPackageName());
        List<ResolveInfo> activities = queryIntentActivities(intent, 65536);
        if (activities == null || activities.isEmpty()) {
            Log.w(LOG_TAG, "No web search activity found");
            return null;
        }
        ActivityInfo ai = ((ResolveInfo) activities.get(0)).activityInfo;
        return new ComponentName(ai.packageName, ai.name);
    }

    private List<ResolveInfo> queryIntentActivities(Intent intent, int flags) {
        List<ResolveInfo> activities = null;
        try {
            activities = this.mPm.queryIntentActivities(intent, intent.resolveTypeIfNeeded(this.mContext.getContentResolver()), flags, this.mUserId);
        } catch (RemoteException e) {
        }
        return activities;
    }

    public synchronized ArrayList<SearchableInfo> getSearchablesList() {
        return new ArrayList(this.mSearchablesList);
    }

    public synchronized ArrayList<SearchableInfo> getSearchablesInGlobalSearchList() {
        return new ArrayList(this.mSearchablesInGlobalSearchList);
    }

    public synchronized ArrayList<ResolveInfo> getGlobalSearchActivities() {
        return new ArrayList(this.mGlobalSearchActivities);
    }

    public synchronized ComponentName getGlobalSearchActivity() {
        return this.mCurrentGlobalSearchActivity;
    }

    public synchronized ComponentName getWebSearchActivity() {
        return this.mWebSearchActivity;
    }

    void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("Searchable authorities:");
        synchronized (this) {
            if (this.mSearchablesList != null) {
                Iterator i$ = this.mSearchablesList.iterator();
                while (i$.hasNext()) {
                    SearchableInfo info = (SearchableInfo) i$.next();
                    pw.print("  ");
                    pw.println(info.getSuggestAuthority());
                }
            }
        }
    }
}
