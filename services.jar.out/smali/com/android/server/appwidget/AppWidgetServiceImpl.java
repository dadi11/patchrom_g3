package com.android.server.appwidget;

import android.app.AlarmManager;
import android.app.AppGlobals;
import android.app.AppOpsManager;
import android.app.PendingIntent;
import android.app.admin.DevicePolicyManagerInternal;
import android.app.admin.DevicePolicyManagerInternal.OnCrossProfileWidgetProvidersChangeListener;
import android.appwidget.AppWidgetProviderInfo;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.Intent.FilterComparison;
import android.content.IntentFilter;
import android.content.IntentSender;
import android.content.ServiceConnection;
import android.content.pm.ActivityInfo;
import android.content.pm.IPackageManager;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.pm.UserInfo;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.graphics.Point;
import android.os.Binder;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.Process;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.UserManager;
import android.util.ArraySet;
import android.util.AtomicFile;
import android.util.AttributeSet;
import android.util.Pair;
import android.util.Slog;
import android.util.SparseIntArray;
import android.util.TypedValue;
import android.util.Xml;
import android.view.Display;
import android.view.WindowManager;
import android.widget.RemoteViews;
import com.android.internal.R;
import com.android.internal.appwidget.IAppWidgetHost;
import com.android.internal.appwidget.IAppWidgetService.Stub;
import com.android.internal.os.BackgroundThread;
import com.android.internal.os.SomeArgs;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.widget.IRemoteViewsAdapterConnection;
import com.android.internal.widget.IRemoteViewsFactory;
import com.android.server.LocalServices;
import com.android.server.WidgetBackupProvider;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map.Entry;
import java.util.Set;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

class AppWidgetServiceImpl extends Stub implements WidgetBackupProvider, OnCrossProfileWidgetProvidersChangeListener {
    private static final int CURRENT_VERSION = 1;
    private static boolean DEBUG = false;
    private static final int KEYGUARD_HOST_ID = 1262836039;
    private static final int LOADED_PROFILE_ID = -1;
    private static final int MIN_UPDATE_PERIOD;
    private static final String NEW_KEYGUARD_HOST_PACKAGE = "com.android.keyguard";
    private static final String OLD_KEYGUARD_HOST_PACKAGE = "android";
    private static final String STATE_FILENAME = "appwidgets.xml";
    private static final String TAG = "AppWidgetServiceImpl";
    private static final int TAG_UNDEFINED = -1;
    private static final int UNKNOWN_UID = -1;
    private static final int UNKNOWN_USER_ID = -10;
    private final AlarmManager mAlarmManager;
    private final AppOpsManager mAppOpsManager;
    private final BackupRestoreController mBackupRestoreController;
    private final HashMap<Pair<Integer, FilterComparison>, ServiceConnection> mBoundRemoteViewsServices;
    private final BroadcastReceiver mBroadcastReceiver;
    private final Handler mCallbackHandler;
    private final Context mContext;
    private final ArrayList<Host> mHosts;
    private final SparseIntArray mLoadedUserIds;
    private Locale mLocale;
    private final Object mLock;
    private int mMaxWidgetBitmapMemory;
    private final SparseIntArray mNextAppWidgetIds;
    private final IPackageManager mPackageManager;
    private final ArraySet<Pair<Integer, String>> mPackagesWithBindWidgetPermission;
    private final ArrayList<Provider> mProviders;
    private final HashMap<Pair<Integer, FilterComparison>, HashSet<Integer>> mRemoteViewsServicesAppWidgets;
    private boolean mSafeMode;
    private final Handler mSaveStateHandler;
    private final SecurityPolicy mSecurityPolicy;
    private final UserManager mUserManager;
    private final ArrayList<Widget> mWidgets;

    /* renamed from: com.android.server.appwidget.AppWidgetServiceImpl.1 */
    class C01531 extends BroadcastReceiver {
        C01531() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (AppWidgetServiceImpl.DEBUG) {
                Slog.i(AppWidgetServiceImpl.TAG, "Received broadcast: " + action);
            }
            if ("android.intent.action.CONFIGURATION_CHANGED".equals(action)) {
                AppWidgetServiceImpl.this.onConfigurationChanged();
            } else if ("android.intent.action.USER_STARTED".equals(action)) {
                AppWidgetServiceImpl.this.onUserStarted(intent.getIntExtra("android.intent.extra.user_handle", -10000));
            } else if ("android.intent.action.USER_STOPPED".equals(action)) {
                AppWidgetServiceImpl.this.onUserStopped(intent.getIntExtra("android.intent.extra.user_handle", -10000));
            } else {
                AppWidgetServiceImpl.this.onPackageBroadcastReceived(intent, intent.getIntExtra("android.intent.extra.user_handle", -10000));
            }
        }
    }

    /* renamed from: com.android.server.appwidget.AppWidgetServiceImpl.2 */
    class C01542 implements ServiceConnection {
        final /* synthetic */ Intent val$intent;

        C01542(Intent intent) {
            this.val$intent = intent;
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            try {
                IRemoteViewsFactory.Stub.asInterface(service).onDestroy(this.val$intent);
            } catch (RemoteException re) {
                Slog.e(AppWidgetServiceImpl.TAG, "Error calling remove view factory", re);
            }
            AppWidgetServiceImpl.this.mContext.unbindService(this);
        }

        public void onServiceDisconnected(ComponentName name) {
        }
    }

    /* renamed from: com.android.server.appwidget.AppWidgetServiceImpl.3 */
    class C01553 implements ServiceConnection {
        C01553() {
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            try {
                IRemoteViewsFactory.Stub.asInterface(service).onDataSetChangedAsync();
            } catch (RemoteException e) {
                Slog.e(AppWidgetServiceImpl.TAG, "Error calling onDataSetChangedAsync()", e);
            }
            AppWidgetServiceImpl.this.mContext.unbindService(this);
        }

        public void onServiceDisconnected(ComponentName name) {
        }
    }

    private final class BackupRestoreController {
        private static final boolean DEBUG = true;
        private static final String TAG = "BackupRestoreController";
        private static final int WIDGET_STATE_VERSION = 2;
        private final HashSet<String> mPrunedApps;
        private final HashMap<Host, ArrayList<RestoreUpdateRecord>> mUpdatesByHost;
        private final HashMap<Provider, ArrayList<RestoreUpdateRecord>> mUpdatesByProvider;

        private class RestoreUpdateRecord {
            public int newId;
            public boolean notified;
            public int oldId;

            public RestoreUpdateRecord(int theOldId, int theNewId) {
                this.oldId = theOldId;
                this.newId = theNewId;
                this.notified = false;
            }
        }

        private BackupRestoreController() {
            this.mPrunedApps = new HashSet();
            this.mUpdatesByProvider = new HashMap();
            this.mUpdatesByHost = new HashMap();
        }

        public List<String> getWidgetParticipants(int userId) {
            Slog.i(TAG, "Getting widget participants for user: " + userId);
            HashSet<String> packages = new HashSet();
            synchronized (AppWidgetServiceImpl.this.mLock) {
                int N = AppWidgetServiceImpl.this.mWidgets.size();
                for (int i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                    Widget widget = (Widget) AppWidgetServiceImpl.this.mWidgets.get(i);
                    if (isProviderAndHostInUser(widget, userId)) {
                        packages.add(widget.host.id.packageName);
                        Provider provider = widget.provider;
                        if (provider != null) {
                            packages.add(provider.id.componentName.getPackageName());
                        }
                    }
                }
            }
            return new ArrayList(packages);
        }

        public byte[] getWidgetState(String backedupPackage, int userId) {
            Slog.i(TAG, "Getting widget state for user: " + userId);
            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            synchronized (AppWidgetServiceImpl.this.mLock) {
                if (packageNeedsWidgetBackupLocked(backedupPackage, userId)) {
                    try {
                        int i;
                        Provider provider;
                        XmlSerializer out = new FastXmlSerializer();
                        out.setOutput(stream, StandardCharsets.UTF_8.name());
                        out.startDocument(null, Boolean.valueOf(DEBUG));
                        out.startTag(null, "ws");
                        out.attribute(null, "version", String.valueOf(WIDGET_STATE_VERSION));
                        out.attribute(null, "pkg", backedupPackage);
                        int index = AppWidgetServiceImpl.MIN_UPDATE_PERIOD;
                        int N = AppWidgetServiceImpl.this.mProviders.size();
                        for (i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                            provider = (Provider) AppWidgetServiceImpl.this.mProviders.get(i);
                            if (!provider.widgets.isEmpty() && (provider.isInPackageForUser(backedupPackage, userId) || provider.hostedByPackageForUser(backedupPackage, userId))) {
                                provider.tag = index;
                                AppWidgetServiceImpl.serializeProvider(out, provider);
                                index += AppWidgetServiceImpl.CURRENT_VERSION;
                            }
                        }
                        N = AppWidgetServiceImpl.this.mHosts.size();
                        index = AppWidgetServiceImpl.MIN_UPDATE_PERIOD;
                        for (i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                            Host host = (Host) AppWidgetServiceImpl.this.mHosts.get(i);
                            if (!host.widgets.isEmpty() && (host.isInPackageForUser(backedupPackage, userId) || host.hostsPackageForUser(backedupPackage, userId))) {
                                host.tag = index;
                                AppWidgetServiceImpl.serializeHost(out, host);
                                index += AppWidgetServiceImpl.CURRENT_VERSION;
                            }
                        }
                        N = AppWidgetServiceImpl.this.mWidgets.size();
                        for (i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                            Widget widget = (Widget) AppWidgetServiceImpl.this.mWidgets.get(i);
                            provider = widget.provider;
                            if (widget.host.isInPackageForUser(backedupPackage, userId) || (provider != null && provider.isInPackageForUser(backedupPackage, userId))) {
                                AppWidgetServiceImpl.serializeAppWidget(out, widget);
                            }
                        }
                        out.endTag(null, "ws");
                        out.endDocument();
                        return stream.toByteArray();
                    } catch (IOException e) {
                        Slog.w(TAG, "Unable to save widget state for " + backedupPackage);
                        return null;
                    }
                }
                return null;
            }
        }

        public void restoreStarting(int userId) {
            Slog.i(TAG, "Restore starting for user: " + userId);
            synchronized (AppWidgetServiceImpl.this.mLock) {
                this.mPrunedApps.clear();
                this.mUpdatesByProvider.clear();
                this.mUpdatesByHost.clear();
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void restoreWidgetState(java.lang.String r31, byte[] r32, int r33) {
            /*
            r30 = this;
            r26 = "BackupRestoreController";
            r27 = new java.lang.StringBuilder;
            r27.<init>();
            r28 = "Restoring widget state for user:";
            r27 = r27.append(r28);
            r0 = r27;
            r1 = r33;
            r27 = r0.append(r1);
            r28 = " package: ";
            r27 = r27.append(r28);
            r0 = r27;
            r1 = r31;
            r27 = r0.append(r1);
            r27 = r27.toString();
            android.util.Slog.i(r26, r27);
            r19 = new java.io.ByteArrayInputStream;
            r0 = r19;
            r1 = r32;
            r0.<init>(r1);
            r18 = new java.util.ArrayList;	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
            r18.<init>();	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
            r16 = new java.util.ArrayList;	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
            r16.<init>();	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
            r13 = android.util.Xml.newPullParser();	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
            r26 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
            r26 = r26.name();	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
            r0 = r19;
            r1 = r26;
            r13.setInput(r0, r1);	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
            r26 = r0;
            r27 = r26.mLock;	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
            monitor-enter(r27);	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
        L_0x0059:
            r21 = r13.next();	 Catch:{ all -> 0x0226 }
            r26 = 2;
            r0 = r21;
            r1 = r26;
            if (r0 != r1) goto L_0x0184;
        L_0x0065:
            r20 = r13.getName();	 Catch:{ all -> 0x0226 }
            r26 = "ws";
            r0 = r26;
            r1 = r20;
            r26 = r0.equals(r1);	 Catch:{ all -> 0x0226 }
            if (r26 == 0) goto L_0x00ea;
        L_0x0075:
            r26 = 0;
            r28 = "version";
            r0 = r26;
            r1 = r28;
            r23 = r13.getAttributeValue(r0, r1);	 Catch:{ all -> 0x0226 }
            r24 = java.lang.Integer.parseInt(r23);	 Catch:{ all -> 0x0226 }
            r26 = 2;
            r0 = r24;
            r1 = r26;
            if (r0 <= r1) goto L_0x00bc;
        L_0x008d:
            r26 = "BackupRestoreController";
            r28 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0226 }
            r28.<init>();	 Catch:{ all -> 0x0226 }
            r29 = "Unable to process state version ";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r0 = r28;
            r1 = r23;
            r28 = r0.append(r1);	 Catch:{ all -> 0x0226 }
            r28 = r28.toString();	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r1 = r28;
            android.util.Slog.w(r0, r1);	 Catch:{ all -> 0x0226 }
            monitor-exit(r27);	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;
            r26 = r0;
            r0 = r26;
            r1 = r33;
            r0.saveGroupStateAsync(r1);
        L_0x00bb:
            return;
        L_0x00bc:
            r26 = 0;
            r28 = "pkg";
            r0 = r26;
            r1 = r28;
            r14 = r13.getAttributeValue(r0, r1);	 Catch:{ all -> 0x0226 }
            r0 = r31;
            r26 = r0.equals(r14);	 Catch:{ all -> 0x0226 }
            if (r26 != 0) goto L_0x0184;
        L_0x00d0:
            r26 = "BackupRestoreController";
            r28 = "Package mismatch in ws";
            r0 = r26;
            r1 = r28;
            android.util.Slog.w(r0, r1);	 Catch:{ all -> 0x0226 }
            monitor-exit(r27);	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;
            r26 = r0;
            r0 = r26;
            r1 = r33;
            r0.saveGroupStateAsync(r1);
            goto L_0x00bb;
        L_0x00ea:
            r26 = "p";
            r0 = r26;
            r1 = r20;
            r26 = r0.equals(r1);	 Catch:{ all -> 0x0226 }
            if (r26 == 0) goto L_0x019c;
        L_0x00f6:
            r26 = 0;
            r28 = "pkg";
            r0 = r26;
            r1 = r28;
            r14 = r13.getAttributeValue(r0, r1);	 Catch:{ all -> 0x0226 }
            r26 = 0;
            r28 = "cl";
            r0 = r26;
            r1 = r28;
            r4 = r13.getAttributeValue(r0, r1);	 Catch:{ all -> 0x0226 }
            r5 = new android.content.ComponentName;	 Catch:{ all -> 0x0226 }
            r5.<init>(r14, r4);	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r1 = r33;
            r12 = r0.findProviderLocked(r5, r1);	 Catch:{ all -> 0x0226 }
            if (r12 != 0) goto L_0x015f;
        L_0x011d:
            r12 = new com.android.server.appwidget.AppWidgetServiceImpl$Provider;	 Catch:{ all -> 0x0226 }
            r26 = 0;
            r0 = r26;
            r12.<init>();	 Catch:{ all -> 0x0226 }
            r26 = new com.android.server.appwidget.AppWidgetServiceImpl$ProviderId;	 Catch:{ all -> 0x0226 }
            r28 = -1;
            r29 = 0;
            r0 = r26;
            r1 = r28;
            r2 = r29;
            r0.<init>(r5, r2);	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r12.id = r0;	 Catch:{ all -> 0x0226 }
            r26 = new android.appwidget.AppWidgetProviderInfo;	 Catch:{ all -> 0x0226 }
            r26.<init>();	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r12.info = r0;	 Catch:{ all -> 0x0226 }
            r0 = r12.info;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r0.provider = r5;	 Catch:{ all -> 0x0226 }
            r26 = 1;
            r0 = r26;
            r12.zombie = r0;	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r26 = r26.mProviders;	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r0.add(r12);	 Catch:{ all -> 0x0226 }
        L_0x015f:
            r26 = "BackupRestoreController";
            r28 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0226 }
            r28.<init>();	 Catch:{ all -> 0x0226 }
            r29 = "   provider ";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r0 = r12.id;	 Catch:{ all -> 0x0226 }
            r29 = r0;
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r28 = r28.toString();	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r1 = r28;
            android.util.Slog.i(r0, r1);	 Catch:{ all -> 0x0226 }
            r0 = r18;
            r0.add(r12);	 Catch:{ all -> 0x0226 }
        L_0x0184:
            r26 = 1;
            r0 = r21;
            r1 = r26;
            if (r0 != r1) goto L_0x0059;
        L_0x018c:
            monitor-exit(r27);	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;
            r26 = r0;
            r0 = r26;
            r1 = r33;
            r0.saveGroupStateAsync(r1);
            goto L_0x00bb;
        L_0x019c:
            r26 = "h";
            r0 = r26;
            r1 = r20;
            r26 = r0.equals(r1);	 Catch:{ all -> 0x0226 }
            if (r26 == 0) goto L_0x0257;
        L_0x01a8:
            r26 = 0;
            r28 = "pkg";
            r0 = r26;
            r1 = r28;
            r14 = r13.getAttributeValue(r0, r1);	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r1 = r33;
            r22 = r0.getUidForPackage(r14, r1);	 Catch:{ all -> 0x0226 }
            r26 = 0;
            r28 = "id";
            r0 = r26;
            r1 = r28;
            r26 = r13.getAttributeValue(r0, r1);	 Catch:{ all -> 0x0226 }
            r28 = 16;
            r0 = r26;
            r1 = r28;
            r9 = java.lang.Integer.parseInt(r0, r1);	 Catch:{ all -> 0x0226 }
            r11 = new com.android.server.appwidget.AppWidgetServiceImpl$HostId;	 Catch:{ all -> 0x0226 }
            r0 = r22;
            r11.<init>(r0, r9, r14);	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r7 = r0.lookupOrAddHostLocked(r11);	 Catch:{ all -> 0x0226 }
            r0 = r16;
            r0.add(r7);	 Catch:{ all -> 0x0226 }
            r26 = "BackupRestoreController";
            r28 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0226 }
            r28.<init>();	 Catch:{ all -> 0x0226 }
            r29 = "   host[";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r29 = r16.size();	 Catch:{ all -> 0x0226 }
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r29 = "]: {";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r0 = r7.id;	 Catch:{ all -> 0x0226 }
            r29 = r0;
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r29 = "}";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r28 = r28.toString();	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r1 = r28;
            android.util.Slog.i(r0, r1);	 Catch:{ all -> 0x0226 }
            goto L_0x0184;
        L_0x0226:
            r26 = move-exception;
            monitor-exit(r27);	 Catch:{ all -> 0x0226 }
            throw r26;	 Catch:{ XmlPullParserException -> 0x0229, IOException -> 0x0418 }
        L_0x0229:
            r26 = move-exception;
            r6 = r26;
        L_0x022c:
            r26 = "BackupRestoreController";
            r27 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0409 }
            r27.<init>();	 Catch:{ all -> 0x0409 }
            r28 = "Unable to restore widget state for ";
            r27 = r27.append(r28);	 Catch:{ all -> 0x0409 }
            r0 = r27;
            r1 = r31;
            r27 = r0.append(r1);	 Catch:{ all -> 0x0409 }
            r27 = r27.toString();	 Catch:{ all -> 0x0409 }
            android.util.Slog.w(r26, r27);	 Catch:{ all -> 0x0409 }
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;
            r26 = r0;
            r0 = r26;
            r1 = r33;
            r0.saveGroupStateAsync(r1);
            goto L_0x00bb;
        L_0x0257:
            r26 = "g";
            r0 = r26;
            r1 = r20;
            r26 = r0.equals(r1);	 Catch:{ all -> 0x0226 }
            if (r26 == 0) goto L_0x0184;
        L_0x0263:
            r26 = 0;
            r28 = "id";
            r0 = r26;
            r1 = r28;
            r26 = r13.getAttributeValue(r0, r1);	 Catch:{ all -> 0x0226 }
            r28 = 16;
            r0 = r26;
            r1 = r28;
            r17 = java.lang.Integer.parseInt(r0, r1);	 Catch:{ all -> 0x0226 }
            r26 = 0;
            r28 = "h";
            r0 = r26;
            r1 = r28;
            r26 = r13.getAttributeValue(r0, r1);	 Catch:{ all -> 0x0226 }
            r28 = 16;
            r0 = r26;
            r1 = r28;
            r10 = java.lang.Integer.parseInt(r0, r1);	 Catch:{ all -> 0x0226 }
            r0 = r16;
            r8 = r0.get(r10);	 Catch:{ all -> 0x0226 }
            r8 = (com.android.server.appwidget.AppWidgetServiceImpl.Host) r8;	 Catch:{ all -> 0x0226 }
            r12 = 0;
            r26 = 0;
            r28 = "p";
            r0 = r26;
            r1 = r28;
            r15 = r13.getAttributeValue(r0, r1);	 Catch:{ all -> 0x0226 }
            if (r15 == 0) goto L_0x02b8;
        L_0x02a6:
            r26 = 16;
            r0 = r26;
            r25 = java.lang.Integer.parseInt(r15, r0);	 Catch:{ all -> 0x0226 }
            r0 = r18;
            r1 = r25;
            r12 = r0.get(r1);	 Catch:{ all -> 0x0226 }
            r12 = (com.android.server.appwidget.AppWidgetServiceImpl.Provider) r12;	 Catch:{ all -> 0x0226 }
        L_0x02b8:
            r0 = r8.id;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r0 = r0.packageName;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r30;
            r1 = r26;
            r2 = r33;
            r0.pruneWidgetStateLocked(r1, r2);	 Catch:{ all -> 0x0226 }
            if (r12 == 0) goto L_0x02e4;
        L_0x02cd:
            r0 = r12.id;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r0 = r0.componentName;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r26 = r26.getPackageName();	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r1 = r26;
            r2 = r33;
            r0.pruneWidgetStateLocked(r1, r2);	 Catch:{ all -> 0x0226 }
        L_0x02e4:
            r0 = r30;
            r1 = r17;
            r11 = r0.findRestoredWidgetLocked(r1, r8, r12);	 Catch:{ all -> 0x0226 }
            if (r11 != 0) goto L_0x037a;
        L_0x02ee:
            r11 = new com.android.server.appwidget.AppWidgetServiceImpl$Widget;	 Catch:{ all -> 0x0226 }
            r26 = 0;
            r0 = r26;
            r11.<init>();	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r1 = r33;
            r26 = r0.incrementAndGetAppWidgetIdLocked(r1);	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r11.appWidgetId = r0;	 Catch:{ all -> 0x0226 }
            r0 = r17;
            r11.restoredId = r0;	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r26 = r0.parseWidgetIdOptions(r13);	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r11.options = r0;	 Catch:{ all -> 0x0226 }
            r11.host = r8;	 Catch:{ all -> 0x0226 }
            r0 = r11.host;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r0 = r0.widgets;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r0.add(r11);	 Catch:{ all -> 0x0226 }
            r11.provider = r12;	 Catch:{ all -> 0x0226 }
            r0 = r11.provider;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            if (r26 == 0) goto L_0x033f;
        L_0x0330:
            r0 = r11.provider;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r0 = r0.widgets;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r0.add(r11);	 Catch:{ all -> 0x0226 }
        L_0x033f:
            r26 = "BackupRestoreController";
            r28 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0226 }
            r28.<init>();	 Catch:{ all -> 0x0226 }
            r29 = "New restored id ";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r0 = r28;
            r1 = r17;
            r28 = r0.append(r1);	 Catch:{ all -> 0x0226 }
            r29 = " now ";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r0 = r28;
            r28 = r0.append(r11);	 Catch:{ all -> 0x0226 }
            r28 = r28.toString();	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r1 = r28;
            android.util.Slog.i(r0, r1);	 Catch:{ all -> 0x0226 }
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r26 = r26.mWidgets;	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r0.add(r11);	 Catch:{ all -> 0x0226 }
        L_0x037a:
            r0 = r11.provider;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r26;
            r0 = r0.info;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            if (r26 == 0) goto L_0x03ea;
        L_0x0386:
            r0 = r11.provider;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r11.appWidgetId;	 Catch:{ all -> 0x0226 }
            r28 = r0;
            r0 = r30;
            r1 = r26;
            r2 = r17;
            r3 = r28;
            r0.stashProviderRestoreUpdateLocked(r1, r2, r3);	 Catch:{ all -> 0x0226 }
        L_0x0399:
            r0 = r11.host;	 Catch:{ all -> 0x0226 }
            r26 = r0;
            r0 = r11.appWidgetId;	 Catch:{ all -> 0x0226 }
            r28 = r0;
            r0 = r30;
            r1 = r26;
            r2 = r17;
            r3 = r28;
            r0.stashHostRestoreUpdateLocked(r1, r2, r3);	 Catch:{ all -> 0x0226 }
            r26 = "BackupRestoreController";
            r28 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0226 }
            r28.<init>();	 Catch:{ all -> 0x0226 }
            r29 = "   instance: ";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r0 = r28;
            r1 = r17;
            r28 = r0.append(r1);	 Catch:{ all -> 0x0226 }
            r29 = " -> ";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r0 = r11.appWidgetId;	 Catch:{ all -> 0x0226 }
            r29 = r0;
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r29 = " :: p=";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r0 = r11.provider;	 Catch:{ all -> 0x0226 }
            r29 = r0;
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r28 = r28.toString();	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r1 = r28;
            android.util.Slog.i(r0, r1);	 Catch:{ all -> 0x0226 }
            goto L_0x0184;
        L_0x03ea:
            r26 = "BackupRestoreController";
            r28 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0226 }
            r28.<init>();	 Catch:{ all -> 0x0226 }
            r29 = "Missing provider for restored widget ";
            r28 = r28.append(r29);	 Catch:{ all -> 0x0226 }
            r0 = r28;
            r28 = r0.append(r11);	 Catch:{ all -> 0x0226 }
            r28 = r28.toString();	 Catch:{ all -> 0x0226 }
            r0 = r26;
            r1 = r28;
            android.util.Slog.w(r0, r1);	 Catch:{ all -> 0x0226 }
            goto L_0x0399;
        L_0x0409:
            r26 = move-exception;
            r0 = r30;
            r0 = com.android.server.appwidget.AppWidgetServiceImpl.this;
            r27 = r0;
            r0 = r27;
            r1 = r33;
            r0.saveGroupStateAsync(r1);
            throw r26;
        L_0x0418:
            r26 = move-exception;
            r6 = r26;
            goto L_0x022c;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.appwidget.AppWidgetServiceImpl.BackupRestoreController.restoreWidgetState(java.lang.String, byte[], int):void");
        }

        public void restoreFinished(int userId) {
            Slog.i(TAG, "restoreFinished for " + userId);
            UserHandle userHandle = new UserHandle(userId);
            synchronized (AppWidgetServiceImpl.this.mLock) {
                int nextPending;
                int i;
                RestoreUpdateRecord r;
                for (Entry<Provider, ArrayList<RestoreUpdateRecord>> e : this.mUpdatesByProvider.entrySet()) {
                    int[] oldIds;
                    int[] newIds;
                    int N;
                    Provider provider = (Provider) e.getKey();
                    ArrayList<RestoreUpdateRecord> updates = (ArrayList) e.getValue();
                    int pending = countPendingUpdates(updates);
                    Slog.i(TAG, "Provider " + provider + " pending: " + pending);
                    if (pending > 0) {
                        oldIds = new int[pending];
                        newIds = new int[pending];
                        N = updates.size();
                        nextPending = AppWidgetServiceImpl.MIN_UPDATE_PERIOD;
                        for (i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                            r = (RestoreUpdateRecord) updates.get(i);
                            if (!r.notified) {
                                r.notified = DEBUG;
                                oldIds[nextPending] = r.oldId;
                                newIds[nextPending] = r.newId;
                                nextPending += AppWidgetServiceImpl.CURRENT_VERSION;
                                Slog.i(TAG, "   " + r.oldId + " => " + r.newId);
                            }
                        }
                        sendWidgetRestoreBroadcastLocked("android.appwidget.action.APPWIDGET_RESTORED", provider, null, oldIds, newIds, userHandle);
                    }
                }
                for (Entry<Host, ArrayList<RestoreUpdateRecord>> e2 : this.mUpdatesByHost.entrySet()) {
                    Host host = (Host) e2.getKey();
                    if (host.id.uid != AppWidgetServiceImpl.UNKNOWN_UID) {
                        updates = (ArrayList) e2.getValue();
                        pending = countPendingUpdates(updates);
                        Slog.i(TAG, "Host " + host + " pending: " + pending);
                        if (pending > 0) {
                            oldIds = new int[pending];
                            newIds = new int[pending];
                            N = updates.size();
                            nextPending = AppWidgetServiceImpl.MIN_UPDATE_PERIOD;
                            for (i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                                r = (RestoreUpdateRecord) updates.get(i);
                                if (!r.notified) {
                                    r.notified = DEBUG;
                                    oldIds[nextPending] = r.oldId;
                                    newIds[nextPending] = r.newId;
                                    nextPending += AppWidgetServiceImpl.CURRENT_VERSION;
                                    Slog.i(TAG, "   " + r.oldId + " => " + r.newId);
                                }
                            }
                            sendWidgetRestoreBroadcastLocked("android.appwidget.action.APPWIDGET_HOST_RESTORED", null, host, oldIds, newIds, userHandle);
                        }
                    }
                }
            }
        }

        private Provider findProviderLocked(ComponentName componentName, int userId) {
            int providerCount = AppWidgetServiceImpl.this.mProviders.size();
            for (int i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < providerCount; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                Provider provider = (Provider) AppWidgetServiceImpl.this.mProviders.get(i);
                if (provider.getUserId() == userId && provider.id.componentName.equals(componentName)) {
                    return provider;
                }
            }
            return null;
        }

        private Widget findRestoredWidgetLocked(int restoredId, Host host, Provider p) {
            Slog.i(TAG, "Find restored widget: id=" + restoredId + " host=" + host + " provider=" + p);
            if (p == null || host == null) {
                return null;
            }
            int N = AppWidgetServiceImpl.this.mWidgets.size();
            for (int i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                Widget widget = (Widget) AppWidgetServiceImpl.this.mWidgets.get(i);
                if (widget.restoredId == restoredId && widget.host.id.equals(host.id) && widget.provider.id.equals(p.id)) {
                    Slog.i(TAG, "   Found at " + i + " : " + widget);
                    return widget;
                }
            }
            return null;
        }

        private boolean packageNeedsWidgetBackupLocked(String packageName, int userId) {
            int N = AppWidgetServiceImpl.this.mWidgets.size();
            for (int i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                Widget widget = (Widget) AppWidgetServiceImpl.this.mWidgets.get(i);
                if (isProviderAndHostInUser(widget, userId)) {
                    if (widget.host.isInPackageForUser(packageName, userId)) {
                        return DEBUG;
                    }
                    Provider provider = widget.provider;
                    if (provider != null && provider.isInPackageForUser(packageName, userId)) {
                        return DEBUG;
                    }
                }
            }
            return false;
        }

        private void stashProviderRestoreUpdateLocked(Provider provider, int oldId, int newId) {
            ArrayList<RestoreUpdateRecord> r = (ArrayList) this.mUpdatesByProvider.get(provider);
            if (r == null) {
                r = new ArrayList();
                this.mUpdatesByProvider.put(provider, r);
            } else if (alreadyStashed(r, oldId, newId)) {
                Slog.i(TAG, "ID remap " + oldId + " -> " + newId + " already stashed for " + provider);
                return;
            }
            r.add(new RestoreUpdateRecord(oldId, newId));
        }

        private boolean alreadyStashed(ArrayList<RestoreUpdateRecord> stash, int oldId, int newId) {
            int N = stash.size();
            for (int i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                RestoreUpdateRecord r = (RestoreUpdateRecord) stash.get(i);
                if (r.oldId == oldId && r.newId == newId) {
                    return DEBUG;
                }
            }
            return false;
        }

        private void stashHostRestoreUpdateLocked(Host host, int oldId, int newId) {
            ArrayList<RestoreUpdateRecord> r = (ArrayList) this.mUpdatesByHost.get(host);
            if (r == null) {
                r = new ArrayList();
                this.mUpdatesByHost.put(host, r);
            } else if (alreadyStashed(r, oldId, newId)) {
                Slog.i(TAG, "ID remap " + oldId + " -> " + newId + " already stashed for " + host);
                return;
            }
            r.add(new RestoreUpdateRecord(oldId, newId));
        }

        private void sendWidgetRestoreBroadcastLocked(String action, Provider provider, Host host, int[] oldIds, int[] newIds, UserHandle userHandle) {
            Intent intent = new Intent(action);
            intent.putExtra("appWidgetOldIds", oldIds);
            intent.putExtra("appWidgetIds", newIds);
            if (provider != null) {
                intent.setComponent(provider.info.provider);
                AppWidgetServiceImpl.this.sendBroadcastAsUser(intent, userHandle);
            }
            if (host != null) {
                intent.setComponent(null);
                intent.setPackage(host.id.packageName);
                intent.putExtra("hostId", host.id.hostId);
                AppWidgetServiceImpl.this.sendBroadcastAsUser(intent, userHandle);
            }
        }

        private void pruneWidgetStateLocked(String pkg, int userId) {
            if (this.mPrunedApps.contains(pkg)) {
                Slog.i(TAG, "already pruned " + pkg + ", continuing normally");
                return;
            }
            Slog.i(TAG, "pruning widget state for restoring package " + pkg);
            for (int i = AppWidgetServiceImpl.this.mWidgets.size() + AppWidgetServiceImpl.UNKNOWN_UID; i >= 0; i += AppWidgetServiceImpl.UNKNOWN_UID) {
                Widget widget = (Widget) AppWidgetServiceImpl.this.mWidgets.get(i);
                Host host = widget.host;
                Provider provider = widget.provider;
                if (host.hostsPackageForUser(pkg, userId) || (provider != null && provider.isInPackageForUser(pkg, userId))) {
                    host.widgets.remove(widget);
                    provider.widgets.remove(widget);
                    AppWidgetServiceImpl.this.unbindAppWidgetRemoteViewsServicesLocked(widget);
                    AppWidgetServiceImpl.this.mWidgets.remove(i);
                }
            }
            this.mPrunedApps.add(pkg);
        }

        private boolean isProviderAndHostInUser(Widget widget, int userId) {
            return (widget.host.getUserId() == userId && (widget.provider == null || widget.provider.getUserId() == userId)) ? DEBUG : false;
        }

        private Bundle parseWidgetIdOptions(XmlPullParser parser) {
            Bundle options = new Bundle();
            String minWidthString = parser.getAttributeValue(null, "min_width");
            if (minWidthString != null) {
                options.putInt("appWidgetMinWidth", Integer.parseInt(minWidthString, 16));
            }
            String minHeightString = parser.getAttributeValue(null, "min_height");
            if (minHeightString != null) {
                options.putInt("appWidgetMinHeight", Integer.parseInt(minHeightString, 16));
            }
            String maxWidthString = parser.getAttributeValue(null, "max_width");
            if (maxWidthString != null) {
                options.putInt("appWidgetMaxWidth", Integer.parseInt(maxWidthString, 16));
            }
            String maxHeightString = parser.getAttributeValue(null, "max_height");
            if (maxHeightString != null) {
                options.putInt("appWidgetMaxHeight", Integer.parseInt(maxHeightString, 16));
            }
            String categoryString = parser.getAttributeValue(null, "host_category");
            if (categoryString != null) {
                options.putInt("appWidgetCategory", Integer.parseInt(categoryString, 16));
            }
            return options;
        }

        private int countPendingUpdates(ArrayList<RestoreUpdateRecord> updates) {
            int pending = AppWidgetServiceImpl.MIN_UPDATE_PERIOD;
            int N = updates.size();
            for (int i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                if (!((RestoreUpdateRecord) updates.get(i)).notified) {
                    pending += AppWidgetServiceImpl.CURRENT_VERSION;
                }
            }
            return pending;
        }
    }

    private final class CallbackHandler extends Handler {
        public static final int MSG_NOTIFY_PROVIDERS_CHANGED = 3;
        public static final int MSG_NOTIFY_PROVIDER_CHANGED = 2;
        public static final int MSG_NOTIFY_UPDATE_APP_WIDGET = 1;
        public static final int MSG_NOTIFY_VIEW_DATA_CHANGED = 4;

        public CallbackHandler(Looper looper) {
            super(looper, null, false);
        }

        public void handleMessage(Message message) {
            SomeArgs args;
            Host host;
            IAppWidgetHost callbacks;
            int appWidgetId;
            switch (message.what) {
                case MSG_NOTIFY_UPDATE_APP_WIDGET /*1*/:
                    args = message.obj;
                    host = args.arg1;
                    callbacks = args.arg2;
                    RemoteViews views = args.arg3;
                    appWidgetId = args.argi1;
                    args.recycle();
                    AppWidgetServiceImpl.this.handleNotifyUpdateAppWidget(host, callbacks, appWidgetId, views);
                case MSG_NOTIFY_PROVIDER_CHANGED /*2*/:
                    args = (SomeArgs) message.obj;
                    host = (Host) args.arg1;
                    callbacks = (IAppWidgetHost) args.arg2;
                    AppWidgetProviderInfo info = args.arg3;
                    appWidgetId = args.argi1;
                    args.recycle();
                    AppWidgetServiceImpl.this.handleNotifyProviderChanged(host, callbacks, appWidgetId, info);
                case MSG_NOTIFY_PROVIDERS_CHANGED /*3*/:
                    args = (SomeArgs) message.obj;
                    host = (Host) args.arg1;
                    callbacks = (IAppWidgetHost) args.arg2;
                    args.recycle();
                    AppWidgetServiceImpl.this.handleNotifyProvidersChanged(host, callbacks);
                case MSG_NOTIFY_VIEW_DATA_CHANGED /*4*/:
                    args = (SomeArgs) message.obj;
                    host = (Host) args.arg1;
                    callbacks = (IAppWidgetHost) args.arg2;
                    appWidgetId = args.argi1;
                    int viewId = args.argi2;
                    args.recycle();
                    AppWidgetServiceImpl.this.handleNotifyAppWidgetViewDataChanged(host, callbacks, appWidgetId, viewId);
                default:
            }
        }
    }

    private static final class Host {
        IAppWidgetHost callbacks;
        HostId id;
        int tag;
        ArrayList<Widget> widgets;
        boolean zombie;

        private Host() {
            this.widgets = new ArrayList();
            this.tag = AppWidgetServiceImpl.UNKNOWN_UID;
        }

        public int getUserId() {
            return UserHandle.getUserId(this.id.uid);
        }

        public boolean isInPackageForUser(String packageName, int userId) {
            return getUserId() == userId && this.id.packageName.equals(packageName);
        }

        private boolean hostsPackageForUser(String pkg, int userId) {
            int N = this.widgets.size();
            for (int i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                Provider provider = ((Widget) this.widgets.get(i)).provider;
                if (provider != null && provider.getUserId() == userId && provider.info != null && pkg.equals(provider.info.provider.getPackageName())) {
                    return true;
                }
            }
            return false;
        }

        public String toString() {
            return "Host{" + this.id + (this.zombie ? " Z" : "") + '}';
        }
    }

    private static final class HostId {
        final int hostId;
        final String packageName;
        final int uid;

        public HostId(int uid, int hostId, String packageName) {
            this.uid = uid;
            this.hostId = hostId;
            this.packageName = packageName;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null) {
                return false;
            }
            if (getClass() != obj.getClass()) {
                return false;
            }
            HostId other = (HostId) obj;
            if (this.uid != other.uid) {
                return false;
            }
            if (this.hostId != other.hostId) {
                return false;
            }
            if (this.packageName == null) {
                if (other.packageName != null) {
                    return false;
                }
                return true;
            } else if (this.packageName.equals(other.packageName)) {
                return true;
            } else {
                return false;
            }
        }

        public int hashCode() {
            return (((this.uid * 31) + this.hostId) * 31) + (this.packageName != null ? this.packageName.hashCode() : AppWidgetServiceImpl.MIN_UPDATE_PERIOD);
        }

        public String toString() {
            return "HostId{user:" + UserHandle.getUserId(this.uid) + ", app:" + UserHandle.getAppId(this.uid) + ", hostId:" + this.hostId + ", pkg:" + this.packageName + '}';
        }
    }

    private class LoadedWidgetState {
        final int hostTag;
        final int providerTag;
        final Widget widget;

        public LoadedWidgetState(Widget widget, int hostTag, int providerTag) {
            this.widget = widget;
            this.hostTag = hostTag;
            this.providerTag = providerTag;
        }
    }

    private static final class Provider {
        PendingIntent broadcast;
        ProviderId id;
        AppWidgetProviderInfo info;
        int tag;
        ArrayList<Widget> widgets;
        boolean zombie;

        private Provider() {
            this.widgets = new ArrayList();
            this.tag = AppWidgetServiceImpl.UNKNOWN_UID;
        }

        public int getUserId() {
            return UserHandle.getUserId(this.id.uid);
        }

        public boolean isInPackageForUser(String packageName, int userId) {
            return getUserId() == userId && this.id.componentName.getPackageName().equals(packageName);
        }

        public boolean hostedByPackageForUser(String packageName, int userId) {
            int N = this.widgets.size();
            for (int i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < N; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                Widget widget = (Widget) this.widgets.get(i);
                if (packageName.equals(widget.host.id.packageName) && widget.host.getUserId() == userId) {
                    return true;
                }
            }
            return false;
        }

        public String toString() {
            return "Provider{" + this.id + (this.zombie ? " Z" : "") + '}';
        }
    }

    private static final class ProviderId {
        final ComponentName componentName;
        final int uid;

        private ProviderId(int uid, ComponentName componentName) {
            this.uid = uid;
            this.componentName = componentName;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null) {
                return false;
            }
            if (getClass() != obj.getClass()) {
                return false;
            }
            ProviderId other = (ProviderId) obj;
            if (this.uid != other.uid) {
                return false;
            }
            if (this.componentName == null) {
                if (other.componentName != null) {
                    return false;
                }
                return true;
            } else if (this.componentName.equals(other.componentName)) {
                return true;
            } else {
                return false;
            }
        }

        public int hashCode() {
            return (this.uid * 31) + (this.componentName != null ? this.componentName.hashCode() : AppWidgetServiceImpl.MIN_UPDATE_PERIOD);
        }

        public String toString() {
            return "ProviderId{user:" + UserHandle.getUserId(this.uid) + ", app:" + UserHandle.getAppId(this.uid) + ", cmp:" + this.componentName + '}';
        }
    }

    private final class SaveStateRunnable implements Runnable {
        final int mUserId;

        public SaveStateRunnable(int userId) {
            this.mUserId = userId;
        }

        public void run() {
            synchronized (AppWidgetServiceImpl.this.mLock) {
                AppWidgetServiceImpl.this.ensureGroupStateLoadedLocked(this.mUserId);
                AppWidgetServiceImpl.this.saveStateLocked(this.mUserId);
            }
        }
    }

    private final class SecurityPolicy {
        private SecurityPolicy() {
        }

        public boolean isEnabledGroupProfile(int profileId) {
            return isParentOrProfile(UserHandle.getCallingUserId(), profileId) && isProfileEnabled(profileId);
        }

        public int[] getEnabledGroupProfileIds(int userId) {
            int parentId = getGroupParent(userId);
            long identity = Binder.clearCallingIdentity();
            try {
                int i;
                List<UserInfo> profiles = AppWidgetServiceImpl.this.mUserManager.getProfiles(parentId);
                int enabledProfileCount = AppWidgetServiceImpl.MIN_UPDATE_PERIOD;
                int profileCount = profiles.size();
                for (i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < profileCount; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                    if (((UserInfo) profiles.get(i)).isEnabled()) {
                        enabledProfileCount += AppWidgetServiceImpl.CURRENT_VERSION;
                    }
                }
                int enabledProfileIndex = AppWidgetServiceImpl.MIN_UPDATE_PERIOD;
                int[] profileIds = new int[enabledProfileCount];
                for (i = AppWidgetServiceImpl.MIN_UPDATE_PERIOD; i < profileCount; i += AppWidgetServiceImpl.CURRENT_VERSION) {
                    UserInfo profile = (UserInfo) profiles.get(i);
                    if (profile.isEnabled()) {
                        profileIds[enabledProfileIndex] = profile.getUserHandle().getIdentifier();
                        enabledProfileIndex += AppWidgetServiceImpl.CURRENT_VERSION;
                    }
                }
                return profileIds;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void enforceServiceExistsAndRequiresBindRemoteViewsPermission(ComponentName componentName, int userId) {
            long identity = Binder.clearCallingIdentity();
            try {
                ServiceInfo serviceInfo = AppWidgetServiceImpl.this.mPackageManager.getServiceInfo(componentName, DumpState.DUMP_VERSION, userId);
                if (serviceInfo == null) {
                    throw new SecurityException("Service " + componentName + " not installed for user " + userId);
                } else if (!"android.permission.BIND_REMOTEVIEWS".equals(serviceInfo.permission)) {
                    throw new SecurityException("Service " + componentName + " in user " + userId + "does not require " + "android.permission.BIND_REMOTEVIEWS");
                }
            } catch (RemoteException e) {
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void enforceModifyAppWidgetBindPermissions(String packageName) {
            AppWidgetServiceImpl.this.mContext.enforceCallingPermission("android.permission.MODIFY_APPWIDGET_BIND_PERMISSIONS", "hasBindAppWidgetPermission packageName=" + packageName);
        }

        public void enforceCallFromPackage(String packageName) {
            AppWidgetServiceImpl.this.mAppOpsManager.checkPackage(Binder.getCallingUid(), packageName);
        }

        public boolean hasCallerBindPermissionOrBindWhiteListedLocked(String packageName) {
            try {
                AppWidgetServiceImpl.this.mContext.enforceCallingOrSelfPermission("android.permission.BIND_APPWIDGET", null);
            } catch (SecurityException e) {
                if (!isCallerBindAppWidgetWhiteListedLocked(packageName)) {
                    return false;
                }
            }
            return true;
        }

        private boolean isCallerBindAppWidgetWhiteListedLocked(String packageName) {
            int userId = UserHandle.getCallingUserId();
            if (AppWidgetServiceImpl.this.getUidForPackage(packageName, userId) < 0) {
                throw new IllegalArgumentException("No package " + packageName + " for user " + userId);
            }
            synchronized (AppWidgetServiceImpl.this.mLock) {
                AppWidgetServiceImpl.this.ensureGroupStateLoadedLocked(userId);
                if (AppWidgetServiceImpl.this.mPackagesWithBindWidgetPermission.contains(Pair.create(Integer.valueOf(userId), packageName))) {
                    return true;
                }
                return false;
            }
        }

        public boolean canAccessAppWidget(Widget widget, int uid, String packageName) {
            if (isHostInPackageForUid(widget.host, uid, packageName) || isProviderInPackageForUid(widget.provider, uid, packageName) || isHostAccessingProvider(widget.host, widget.provider, uid, packageName)) {
                return true;
            }
            int userId = UserHandle.getUserId(uid);
            if ((widget.host.getUserId() == userId || (widget.provider != null && widget.provider.getUserId() == userId)) && AppWidgetServiceImpl.this.mContext.checkCallingPermission("android.permission.BIND_APPWIDGET") == 0) {
                return true;
            }
            return false;
        }

        private boolean isParentOrProfile(int parentId, int profileId) {
            if (parentId == profileId || getProfileParent(profileId) == parentId) {
                return true;
            }
            return false;
        }

        public boolean isProviderInCallerOrInProfileAndWhitelListed(String packageName, int profileId) {
            int callerId = UserHandle.getCallingUserId();
            if (profileId == callerId) {
                return true;
            }
            if (getProfileParent(profileId) != callerId) {
                return false;
            }
            return isProviderWhitelListed(packageName, profileId);
        }

        public boolean isProviderWhitelListed(String packageName, int profileId) {
            DevicePolicyManagerInternal devicePolicyManager = (DevicePolicyManagerInternal) LocalServices.getService(DevicePolicyManagerInternal.class);
            if (devicePolicyManager == null) {
                return false;
            }
            return devicePolicyManager.getCrossProfileWidgetProviders(profileId).contains(packageName);
        }

        public int getProfileParent(int profileId) {
            long identity = Binder.clearCallingIdentity();
            try {
                UserInfo parent = AppWidgetServiceImpl.this.mUserManager.getProfileParent(profileId);
                if (parent != null) {
                    int identifier = parent.getUserHandle().getIdentifier();
                    return identifier;
                }
                Binder.restoreCallingIdentity(identity);
                return AppWidgetServiceImpl.UNKNOWN_USER_ID;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public int getGroupParent(int profileId) {
            int parentId = AppWidgetServiceImpl.this.mSecurityPolicy.getProfileParent(profileId);
            return parentId != AppWidgetServiceImpl.UNKNOWN_USER_ID ? parentId : profileId;
        }

        public boolean isHostInPackageForUid(Host host, int uid, String packageName) {
            return host.id.uid == uid && host.id.packageName.equals(packageName);
        }

        public boolean isProviderInPackageForUid(Provider provider, int uid, String packageName) {
            return provider != null && provider.id.uid == uid && provider.id.componentName.getPackageName().equals(packageName);
        }

        public boolean isHostAccessingProvider(Host host, Provider provider, int uid, String packageName) {
            return host.id.uid == uid && provider != null && provider.id.componentName.getPackageName().equals(packageName);
        }

        private boolean isProfileEnabled(int profileId) {
            long identity = Binder.clearCallingIdentity();
            try {
                UserInfo userInfo = AppWidgetServiceImpl.this.mUserManager.getUserInfo(profileId);
                if (userInfo == null || !userInfo.isEnabled()) {
                    Binder.restoreCallingIdentity(identity);
                    return false;
                }
                Binder.restoreCallingIdentity(identity);
                return true;
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(identity);
            }
        }
    }

    private static final class ServiceConnectionProxy implements ServiceConnection {
        private final IRemoteViewsAdapterConnection mConnectionCb;

        ServiceConnectionProxy(IBinder connectionCb) {
            this.mConnectionCb = IRemoteViewsAdapterConnection.Stub.asInterface(connectionCb);
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            try {
                this.mConnectionCb.onServiceConnected(service);
            } catch (RemoteException re) {
                Slog.e(AppWidgetServiceImpl.TAG, "Error passing service interface", re);
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            disconnect();
        }

        public void disconnect() {
            try {
                this.mConnectionCb.onServiceDisconnected();
            } catch (RemoteException re) {
                Slog.e(AppWidgetServiceImpl.TAG, "Error clearing service interface", re);
            }
        }
    }

    private static final class Widget {
        int appWidgetId;
        Host host;
        Bundle options;
        Provider provider;
        int restoredId;
        RemoteViews views;

        private Widget() {
        }

        public String toString() {
            return "AppWidgetId{" + this.appWidgetId + ':' + this.host + ':' + this.provider + '}';
        }
    }

    static {
        int i = MIN_UPDATE_PERIOD;
        DEBUG = false;
        if (!DEBUG) {
            i = ProcessList.PSS_MAX_INTERVAL;
        }
        MIN_UPDATE_PERIOD = i;
    }

    AppWidgetServiceImpl(Context context) {
        this.mBroadcastReceiver = new C01531();
        this.mBoundRemoteViewsServices = new HashMap();
        this.mRemoteViewsServicesAppWidgets = new HashMap();
        this.mLock = new Object();
        this.mWidgets = new ArrayList();
        this.mHosts = new ArrayList();
        this.mProviders = new ArrayList();
        this.mPackagesWithBindWidgetPermission = new ArraySet();
        this.mLoadedUserIds = new SparseIntArray();
        this.mNextAppWidgetIds = new SparseIntArray();
        this.mContext = context;
        this.mPackageManager = AppGlobals.getPackageManager();
        this.mAlarmManager = (AlarmManager) this.mContext.getSystemService("alarm");
        this.mUserManager = (UserManager) this.mContext.getSystemService("user");
        this.mAppOpsManager = (AppOpsManager) this.mContext.getSystemService("appops");
        this.mSaveStateHandler = BackgroundThread.getHandler();
        this.mCallbackHandler = new CallbackHandler(this.mContext.getMainLooper());
        this.mBackupRestoreController = new BackupRestoreController();
        this.mSecurityPolicy = new SecurityPolicy();
        computeMaximumWidgetBitmapMemory();
        registerBroadcastReceiver();
        registerOnCrossProfileProvidersChangedListener();
    }

    private void computeMaximumWidgetBitmapMemory() {
        Display display = ((WindowManager) this.mContext.getSystemService("window")).getDefaultDisplay();
        Point size = new Point();
        display.getRealSize(size);
        this.mMaxWidgetBitmapMemory = (size.x * 6) * size.y;
    }

    private void registerBroadcastReceiver() {
        IntentFilter configFilter = new IntentFilter();
        configFilter.addAction("android.intent.action.CONFIGURATION_CHANGED");
        this.mContext.registerReceiverAsUser(this.mBroadcastReceiver, UserHandle.ALL, configFilter, null, null);
        IntentFilter packageFilter = new IntentFilter();
        packageFilter.addAction("android.intent.action.PACKAGE_ADDED");
        packageFilter.addAction("android.intent.action.PACKAGE_CHANGED");
        packageFilter.addAction("android.intent.action.PACKAGE_REMOVED");
        packageFilter.addDataScheme("package");
        this.mContext.registerReceiverAsUser(this.mBroadcastReceiver, UserHandle.ALL, packageFilter, null, null);
        IntentFilter sdFilter = new IntentFilter();
        sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE");
        sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE");
        this.mContext.registerReceiverAsUser(this.mBroadcastReceiver, UserHandle.ALL, sdFilter, null, null);
        IntentFilter userFilter = new IntentFilter();
        userFilter.addAction("android.intent.action.USER_STARTED");
        userFilter.addAction("android.intent.action.USER_STOPPED");
        this.mContext.registerReceiverAsUser(this.mBroadcastReceiver, UserHandle.ALL, userFilter, null, null);
    }

    private void registerOnCrossProfileProvidersChangedListener() {
        DevicePolicyManagerInternal devicePolicyManager = (DevicePolicyManagerInternal) LocalServices.getService(DevicePolicyManagerInternal.class);
        if (devicePolicyManager != null) {
            devicePolicyManager.addOnCrossProfileWidgetProvidersChangeListener(this);
        }
    }

    public void setSafeMode(boolean safeMode) {
        this.mSafeMode = safeMode;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void onConfigurationChanged() {
        /*
        r14 = this;
        r11 = DEBUG;
        if (r11 == 0) goto L_0x000b;
    L_0x0004:
        r11 = "AppWidgetServiceImpl";
        r12 = "onConfigurationChanged()";
        android.util.Slog.i(r11, r12);
    L_0x000b:
        r10 = java.util.Locale.getDefault();
        if (r10 == 0) goto L_0x001d;
    L_0x0011:
        r11 = r14.mLocale;
        if (r11 == 0) goto L_0x001d;
    L_0x0015:
        r11 = r14.mLocale;
        r11 = r10.equals(r11);
        if (r11 != 0) goto L_0x008b;
    L_0x001d:
        r14.mLocale = r10;
        r12 = r14.mLock;
        monitor-enter(r12);
        r2 = 0;
        r7 = new java.util.ArrayList;	 Catch:{ all -> 0x008c }
        r11 = r14.mProviders;	 Catch:{ all -> 0x008c }
        r7.<init>(r11);	 Catch:{ all -> 0x008c }
        r9 = new java.util.HashSet;	 Catch:{ all -> 0x008c }
        r9.<init>();	 Catch:{ all -> 0x008c }
        r0 = r7.size();	 Catch:{ all -> 0x008c }
        r6 = r0 + -1;
        r3 = r2;
    L_0x0036:
        if (r6 < 0) goto L_0x0077;
    L_0x0038:
        r8 = r7.get(r6);	 Catch:{ all -> 0x008f }
        r8 = (com.android.server.appwidget.AppWidgetServiceImpl.Provider) r8;	 Catch:{ all -> 0x008f }
        r11 = r8.getUserId();	 Catch:{ all -> 0x008f }
        r14.ensureGroupStateLoadedLocked(r11);	 Catch:{ all -> 0x008f }
        r11 = r8.id;	 Catch:{ all -> 0x008f }
        r11 = r9.contains(r11);	 Catch:{ all -> 0x008f }
        if (r11 != 0) goto L_0x0094;
    L_0x004d:
        r11 = r8.id;	 Catch:{ all -> 0x008f }
        r11 = r11.componentName;	 Catch:{ all -> 0x008f }
        r11 = r11.getPackageName();	 Catch:{ all -> 0x008f }
        r13 = r8.getUserId();	 Catch:{ all -> 0x008f }
        r1 = r14.updateProvidersForPackageLocked(r11, r13, r9);	 Catch:{ all -> 0x008f }
        if (r1 == 0) goto L_0x0094;
    L_0x005f:
        if (r3 != 0) goto L_0x0092;
    L_0x0061:
        r2 = new android.util.SparseIntArray;	 Catch:{ all -> 0x008f }
        r2.<init>();	 Catch:{ all -> 0x008f }
    L_0x0066:
        r11 = r14.mSecurityPolicy;	 Catch:{ all -> 0x008c }
        r13 = r8.getUserId();	 Catch:{ all -> 0x008c }
        r5 = r11.getGroupParent(r13);	 Catch:{ all -> 0x008c }
        r2.put(r5, r5);	 Catch:{ all -> 0x008c }
    L_0x0073:
        r6 = r6 + -1;
        r3 = r2;
        goto L_0x0036;
    L_0x0077:
        if (r3 == 0) goto L_0x008a;
    L_0x0079:
        r4 = r3.size();	 Catch:{ all -> 0x008f }
        r6 = 0;
    L_0x007e:
        if (r6 >= r4) goto L_0x008a;
    L_0x0080:
        r5 = r3.get(r6);	 Catch:{ all -> 0x008f }
        r14.saveGroupStateAsync(r5);	 Catch:{ all -> 0x008f }
        r6 = r6 + 1;
        goto L_0x007e;
    L_0x008a:
        monitor-exit(r12);	 Catch:{ all -> 0x008f }
    L_0x008b:
        return;
    L_0x008c:
        r11 = move-exception;
    L_0x008d:
        monitor-exit(r12);	 Catch:{ all -> 0x008c }
        throw r11;
    L_0x008f:
        r11 = move-exception;
        r2 = r3;
        goto L_0x008d;
    L_0x0092:
        r2 = r3;
        goto L_0x0066;
    L_0x0094:
        r2 = r3;
        goto L_0x0073;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.appwidget.AppWidgetServiceImpl.onConfigurationChanged():void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void onPackageBroadcastReceived(android.content.Intent r21, int r22) {
        /*
        r20 = this;
        r3 = r21.getAction();
        r4 = 0;
        r6 = 0;
        r7 = 0;
        r13 = 0;
        r17 = "android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE";
        r0 = r17;
        r17 = r0.equals(r3);
        if (r17 == 0) goto L_0x0025;
    L_0x0012:
        r17 = "android.intent.extra.changed_package_list";
        r0 = r21;
        r1 = r17;
        r13 = r0.getStringArrayExtra(r1);
        r4 = 1;
    L_0x001d:
        if (r13 == 0) goto L_0x0024;
    L_0x001f:
        r0 = r13.length;
        r17 = r0;
        if (r17 != 0) goto L_0x0062;
    L_0x0024:
        return;
    L_0x0025:
        r17 = "android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE";
        r0 = r17;
        r17 = r0.equals(r3);
        if (r17 == 0) goto L_0x003b;
    L_0x002f:
        r17 = "android.intent.extra.changed_package_list";
        r0 = r21;
        r1 = r17;
        r13 = r0.getStringArrayExtra(r1);
        r4 = 0;
        goto L_0x001d;
    L_0x003b:
        r16 = r21.getData();
        if (r16 == 0) goto L_0x0024;
    L_0x0041:
        r14 = r16.getSchemeSpecificPart();
        if (r14 == 0) goto L_0x0024;
    L_0x0047:
        r17 = 1;
        r0 = r17;
        r13 = new java.lang.String[r0];
        r17 = 0;
        r13[r17] = r14;
        r17 = "android.intent.action.PACKAGE_ADDED";
        r0 = r17;
        r4 = r0.equals(r3);
        r17 = "android.intent.action.PACKAGE_CHANGED";
        r0 = r17;
        r6 = r0.equals(r3);
        goto L_0x001d;
    L_0x0062:
        r0 = r20;
        r0 = r0.mLock;
        r18 = r0;
        monitor-enter(r18);
        r0 = r20;
        r1 = r22;
        r0.ensureGroupStateLoadedLocked(r1);	 Catch:{ all -> 0x00f4 }
        r8 = r21.getExtras();	 Catch:{ all -> 0x00f4 }
        if (r4 != 0) goto L_0x0078;
    L_0x0076:
        if (r6 == 0) goto L_0x00b8;
    L_0x0078:
        if (r4 == 0) goto L_0x00b6;
    L_0x007a:
        if (r8 == 0) goto L_0x008a;
    L_0x007c:
        r17 = "android.intent.extra.REPLACING";
        r19 = 0;
        r0 = r17;
        r1 = r19;
        r17 = r8.getBoolean(r0, r1);	 Catch:{ all -> 0x00f4 }
        if (r17 != 0) goto L_0x00b6;
    L_0x008a:
        r11 = 1;
    L_0x008b:
        r5 = r13;
        r10 = r5.length;	 Catch:{ all -> 0x00f4 }
        r9 = 0;
    L_0x008e:
        if (r9 >= r10) goto L_0x00e1;
    L_0x0090:
        r14 = r5[r9];	 Catch:{ all -> 0x00f4 }
        r17 = 0;
        r0 = r20;
        r1 = r22;
        r2 = r17;
        r17 = r0.updateProvidersForPackageLocked(r14, r1, r2);	 Catch:{ all -> 0x00f4 }
        r7 = r7 | r17;
        if (r11 == 0) goto L_0x00b3;
    L_0x00a2:
        if (r22 != 0) goto L_0x00b3;
    L_0x00a4:
        r0 = r20;
        r1 = r22;
        r15 = r0.getUidForPackage(r14, r1);	 Catch:{ all -> 0x00f4 }
        if (r15 < 0) goto L_0x00b3;
    L_0x00ae:
        r0 = r20;
        r0.resolveHostUidLocked(r14, r15);	 Catch:{ all -> 0x00f4 }
    L_0x00b3:
        r9 = r9 + 1;
        goto L_0x008e;
    L_0x00b6:
        r11 = 0;
        goto L_0x008b;
    L_0x00b8:
        if (r8 == 0) goto L_0x00c8;
    L_0x00ba:
        r17 = "android.intent.extra.REPLACING";
        r19 = 0;
        r0 = r17;
        r1 = r19;
        r17 = r8.getBoolean(r0, r1);	 Catch:{ all -> 0x00f4 }
        if (r17 != 0) goto L_0x00df;
    L_0x00c8:
        r12 = 1;
    L_0x00c9:
        if (r12 == 0) goto L_0x00e1;
    L_0x00cb:
        r5 = r13;
        r10 = r5.length;	 Catch:{ all -> 0x00f4 }
        r9 = 0;
    L_0x00ce:
        if (r9 >= r10) goto L_0x00e1;
    L_0x00d0:
        r14 = r5[r9];	 Catch:{ all -> 0x00f4 }
        r0 = r20;
        r1 = r22;
        r17 = r0.removeHostsAndProvidersForPackageLocked(r14, r1);	 Catch:{ all -> 0x00f4 }
        r7 = r7 | r17;
        r9 = r9 + 1;
        goto L_0x00ce;
    L_0x00df:
        r12 = 0;
        goto L_0x00c9;
    L_0x00e1:
        if (r7 == 0) goto L_0x00f1;
    L_0x00e3:
        r0 = r20;
        r1 = r22;
        r0.saveGroupStateAsync(r1);	 Catch:{ all -> 0x00f4 }
        r0 = r20;
        r1 = r22;
        r0.scheduleNotifyGroupHostsForProvidersChangedLocked(r1);	 Catch:{ all -> 0x00f4 }
    L_0x00f1:
        monitor-exit(r18);	 Catch:{ all -> 0x00f4 }
        goto L_0x0024;
    L_0x00f4:
        r17 = move-exception;
        monitor-exit(r18);	 Catch:{ all -> 0x00f4 }
        throw r17;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.appwidget.AppWidgetServiceImpl.onPackageBroadcastReceived(android.content.Intent, int):void");
    }

    private void resolveHostUidLocked(String pkg, int uid) {
        int N = this.mHosts.size();
        for (int i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
            Host host = (Host) this.mHosts.get(i);
            if (host.id.uid == UNKNOWN_UID && pkg.equals(host.id.packageName)) {
                if (DEBUG) {
                    Slog.i(TAG, "host " + host.id + " resolved to uid " + uid);
                }
                host.id = new HostId(uid, host.id.hostId, host.id.packageName);
                return;
            }
        }
    }

    private void ensureGroupStateLoadedLocked(int userId) {
        int i;
        int[] profileIds = this.mSecurityPolicy.getEnabledGroupProfileIds(userId);
        int newMemberCount = MIN_UPDATE_PERIOD;
        int profileIdCount = profileIds.length;
        for (i = MIN_UPDATE_PERIOD; i < profileIdCount; i += CURRENT_VERSION) {
            if (this.mLoadedUserIds.indexOfKey(profileIds[i]) >= 0) {
                profileIds[i] = UNKNOWN_UID;
            } else {
                newMemberCount += CURRENT_VERSION;
            }
        }
        if (newMemberCount > 0) {
            int newMemberIndex = MIN_UPDATE_PERIOD;
            int[] newProfileIds = new int[newMemberCount];
            for (i = MIN_UPDATE_PERIOD; i < profileIdCount; i += CURRENT_VERSION) {
                int profileId = profileIds[i];
                if (profileId != UNKNOWN_UID) {
                    this.mLoadedUserIds.put(profileId, profileId);
                    newProfileIds[newMemberIndex] = profileId;
                    newMemberIndex += CURRENT_VERSION;
                }
            }
            clearProvidersAndHostsTagsLocked();
            loadGroupWidgetProvidersLocked(newProfileIds);
            loadGroupStateLocked(newProfileIds);
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DUMP", "Permission Denial: can't dump from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
        synchronized (this.mLock) {
            int i;
            int N = this.mProviders.size();
            pw.println("Providers:");
            for (i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                dumpProvider((Provider) this.mProviders.get(i), i, pw);
            }
            N = this.mWidgets.size();
            pw.println(" ");
            pw.println("Widgets:");
            for (i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                dumpWidget((Widget) this.mWidgets.get(i), i, pw);
            }
            N = this.mHosts.size();
            pw.println(" ");
            pw.println("Hosts:");
            for (i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                dumpHost((Host) this.mHosts.get(i), i, pw);
            }
            N = this.mPackagesWithBindWidgetPermission.size();
            pw.println(" ");
            pw.println("Grants:");
            for (i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                dumpGrant((Pair) this.mPackagesWithBindWidgetPermission.valueAt(i), i, pw);
            }
        }
    }

    public int[] startListening(IAppWidgetHost callbacks, String callingPackage, int hostId, List<RemoteViews> updatedViews) {
        int[] updatedIds;
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "startListening() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Host host = lookupOrAddHostLocked(new HostId(Binder.getCallingUid(), hostId, callingPackage));
            host.callbacks = callbacks;
            updatedViews.clear();
            ArrayList<Widget> instances = host.widgets;
            int N = instances.size();
            updatedIds = new int[N];
            for (int i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                Widget widget = (Widget) instances.get(i);
                updatedIds[i] = widget.appWidgetId;
                updatedViews.add(cloneIfLocalBinder(widget.views));
            }
        }
        return updatedIds;
    }

    public void stopListening(String callingPackage, int hostId) {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "stopListening() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Host host = lookupHostLocked(new HostId(Binder.getCallingUid(), hostId, callingPackage));
            if (host != null) {
                host.callbacks = null;
                pruneHostLocked(host);
            }
        }
    }

    public int allocateAppWidgetId(String callingPackage, int hostId) {
        int appWidgetId;
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "allocateAppWidgetId() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            if (this.mNextAppWidgetIds.indexOfKey(userId) < 0) {
                this.mNextAppWidgetIds.put(userId, CURRENT_VERSION);
            }
            appWidgetId = incrementAndGetAppWidgetIdLocked(userId);
            Host host = lookupOrAddHostLocked(new HostId(Binder.getCallingUid(), hostId, callingPackage));
            Widget widget = new Widget();
            widget.appWidgetId = appWidgetId;
            widget.host = host;
            host.widgets.add(widget);
            this.mWidgets.add(widget);
            saveGroupStateAsync(userId);
            if (DEBUG) {
                Slog.i(TAG, "Allocated widget id " + appWidgetId + " for host " + host.id);
            }
        }
        return appWidgetId;
    }

    public void deleteAppWidgetId(String callingPackage, int appWidgetId) {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "deleteAppWidgetId() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Widget widget = lookupWidgetLocked(appWidgetId, Binder.getCallingUid(), callingPackage);
            if (widget == null) {
                return;
            }
            deleteAppWidgetLocked(widget);
            saveGroupStateAsync(userId);
            if (DEBUG) {
                Slog.i(TAG, "Deleted widget id " + appWidgetId + " for host " + widget.host.id);
            }
        }
    }

    public boolean hasBindAppWidgetPermission(String packageName, int grantId) {
        boolean z;
        if (DEBUG) {
            Slog.i(TAG, "hasBindAppWidgetPermission() " + UserHandle.getCallingUserId());
        }
        this.mSecurityPolicy.enforceModifyAppWidgetBindPermissions(packageName);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(grantId);
            if (getUidForPackage(packageName, grantId) < 0) {
                z = false;
            } else {
                z = this.mPackagesWithBindWidgetPermission.contains(Pair.create(Integer.valueOf(grantId), packageName));
            }
        }
        return z;
    }

    public void setBindAppWidgetPermission(String packageName, int grantId, boolean grantPermission) {
        if (DEBUG) {
            Slog.i(TAG, "setBindAppWidgetPermission() " + UserHandle.getCallingUserId());
        }
        this.mSecurityPolicy.enforceModifyAppWidgetBindPermissions(packageName);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(grantId);
            if (getUidForPackage(packageName, grantId) < 0) {
                return;
            }
            Pair<Integer, String> packageId = Pair.create(Integer.valueOf(grantId), packageName);
            if (grantPermission) {
                this.mPackagesWithBindWidgetPermission.add(packageId);
            } else {
                this.mPackagesWithBindWidgetPermission.remove(packageId);
            }
            saveGroupStateAsync(grantId);
        }
    }

    public IntentSender createAppWidgetConfigIntentSender(String callingPackage, int appWidgetId) {
        IntentSender intentSender;
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "createAppWidgetConfigIntentSender() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Widget widget = lookupWidgetLocked(appWidgetId, Binder.getCallingUid(), callingPackage);
            if (widget == null) {
                throw new IllegalArgumentException("Bad widget id " + appWidgetId);
            }
            Provider provider = widget.provider;
            if (provider == null) {
                throw new IllegalArgumentException("Widget not bound " + appWidgetId);
            }
            Intent intent = new Intent("android.appwidget.action.APPWIDGET_CONFIGURE");
            intent.putExtra("appWidgetId", appWidgetId);
            intent.setComponent(provider.info.configure);
            long identity = Binder.clearCallingIdentity();
            try {
                intentSender = PendingIntent.getActivityAsUser(this.mContext, MIN_UPDATE_PERIOD, intent, 1342177280, null, new UserHandle(provider.getUserId())).getIntentSender();
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }
        return intentSender;
    }

    public boolean bindAppWidgetId(String callingPackage, int appWidgetId, int providerProfileId, ComponentName providerComponent, Bundle options) {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "bindAppWidgetId() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        if (!this.mSecurityPolicy.isEnabledGroupProfile(providerProfileId)) {
            return false;
        }
        if (!this.mSecurityPolicy.isProviderInCallerOrInProfileAndWhitelListed(providerComponent.getPackageName(), providerProfileId)) {
            return false;
        }
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            if (this.mSecurityPolicy.hasCallerBindPermissionOrBindWhiteListedLocked(callingPackage)) {
                Widget widget = lookupWidgetLocked(appWidgetId, Binder.getCallingUid(), callingPackage);
                if (widget == null) {
                    Slog.e(TAG, "Bad widget id " + appWidgetId);
                    return false;
                } else if (widget.provider != null) {
                    Slog.e(TAG, "Widget id " + appWidgetId + " already bound to: " + widget.provider.id);
                    return false;
                } else {
                    int providerUid = getUidForPackage(providerComponent.getPackageName(), providerProfileId);
                    if (providerUid < 0) {
                        Slog.e(TAG, "Package " + providerComponent.getPackageName() + " not installed " + " for profile " + providerProfileId);
                        return false;
                    }
                    Provider provider = lookupProviderLocked(new ProviderId(providerComponent, null));
                    if (provider == null) {
                        Slog.e(TAG, "No widget provider " + providerComponent + " for profile " + providerProfileId);
                        return false;
                    } else if (provider.zombie) {
                        Slog.e(TAG, "Can't bind to a 3rd party provider in safe mode " + provider);
                        return false;
                    } else {
                        widget.provider = provider;
                        widget.options = options != null ? cloneIfLocalBinder(options) : new Bundle();
                        if (!widget.options.containsKey("appWidgetCategory")) {
                            widget.options.putInt("appWidgetCategory", CURRENT_VERSION);
                        }
                        provider.widgets.add(widget);
                        if (provider.widgets.size() == CURRENT_VERSION) {
                            sendEnableIntentLocked(provider);
                        }
                        int[] iArr = new int[CURRENT_VERSION];
                        iArr[MIN_UPDATE_PERIOD] = appWidgetId;
                        sendUpdateIntentLocked(provider, iArr);
                        registerForBroadcastsLocked(provider, getWidgetIds(provider.widgets));
                        saveGroupStateAsync(userId);
                        if (DEBUG) {
                            Slog.i(TAG, "Bound widget " + appWidgetId + " to provider " + provider.id);
                        }
                        return true;
                    }
                }
            }
            return false;
        }
    }

    public int[] getAppWidgetIds(ComponentName componentName) {
        int[] widgetIds;
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "getAppWidgetIds() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(componentName.getPackageName());
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Provider provider = lookupProviderLocked(new ProviderId(componentName, null));
            if (provider != null) {
                widgetIds = getWidgetIds(provider.widgets);
            } else {
                widgetIds = new int[MIN_UPDATE_PERIOD];
            }
        }
        return widgetIds;
    }

    public int[] getAppWidgetIdsForHost(String callingPackage, int hostId) {
        int[] widgetIds;
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "getAppWidgetIdsForHost() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Host host = lookupHostLocked(new HostId(Binder.getCallingUid(), hostId, callingPackage));
            if (host != null) {
                widgetIds = getWidgetIds(host.widgets);
            } else {
                widgetIds = new int[MIN_UPDATE_PERIOD];
            }
        }
        return widgetIds;
    }

    public void bindRemoteViewsService(String callingPackage, int appWidgetId, Intent intent, IBinder callbacks) {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "bindRemoteViewsService() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Widget widget = lookupWidgetLocked(appWidgetId, Binder.getCallingUid(), callingPackage);
            if (widget == null) {
                throw new IllegalArgumentException("Bad widget id");
            } else if (widget.provider == null) {
                throw new IllegalArgumentException("No provider for widget " + appWidgetId);
            } else {
                ComponentName componentName = intent.getComponent();
                if (componentName.getPackageName().equals(widget.provider.id.componentName.getPackageName())) {
                    ServiceConnectionProxy connection;
                    this.mSecurityPolicy.enforceServiceExistsAndRequiresBindRemoteViewsPermission(componentName, widget.provider.getUserId());
                    FilterComparison fc = new FilterComparison(intent);
                    Pair<Integer, FilterComparison> key = Pair.create(Integer.valueOf(appWidgetId), fc);
                    if (this.mBoundRemoteViewsServices.containsKey(key)) {
                        connection = (ServiceConnectionProxy) this.mBoundRemoteViewsServices.get(key);
                        connection.disconnect();
                        unbindService(connection);
                        this.mBoundRemoteViewsServices.remove(key);
                    }
                    connection = new ServiceConnectionProxy(callbacks);
                    bindService(intent, connection, widget.provider.info.getProfile());
                    this.mBoundRemoteViewsServices.put(key, connection);
                    incrementAppWidgetServiceRefCount(appWidgetId, Pair.create(Integer.valueOf(widget.provider.id.uid), fc));
                } else {
                    throw new SecurityException("The taget service not in the same package as the widget provider");
                }
            }
        }
    }

    public void unbindRemoteViewsService(String callingPackage, int appWidgetId, Intent intent) {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "unbindRemoteViewsService() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Pair<Integer, FilterComparison> key = Pair.create(Integer.valueOf(appWidgetId), new FilterComparison(intent));
            if (this.mBoundRemoteViewsServices.containsKey(key)) {
                if (lookupWidgetLocked(appWidgetId, Binder.getCallingUid(), callingPackage) == null) {
                    throw new IllegalArgumentException("Bad widget id " + appWidgetId);
                }
                ServiceConnectionProxy connection = (ServiceConnectionProxy) this.mBoundRemoteViewsServices.get(key);
                connection.disconnect();
                this.mContext.unbindService(connection);
                this.mBoundRemoteViewsServices.remove(key);
            }
        }
    }

    public void deleteHost(String callingPackage, int hostId) {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "deleteHost() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Host host = lookupHostLocked(new HostId(Binder.getCallingUid(), hostId, callingPackage));
            if (host == null) {
                return;
            }
            deleteHostLocked(host);
            saveGroupStateAsync(userId);
            if (DEBUG) {
                Slog.i(TAG, "Deleted host " + host.id);
            }
        }
    }

    public void deleteAllHosts() {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "deleteAllHosts() " + userId);
        }
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            boolean changed = false;
            for (int i = this.mHosts.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
                Host host = (Host) this.mHosts.get(i);
                if (host.id.uid == Binder.getCallingUid()) {
                    deleteHostLocked(host);
                    changed = true;
                    if (DEBUG) {
                        Slog.i(TAG, "Deleted host " + host.id);
                    }
                }
            }
            if (changed) {
                saveGroupStateAsync(userId);
            }
        }
    }

    public AppWidgetProviderInfo getAppWidgetInfo(String callingPackage, int appWidgetId) {
        AppWidgetProviderInfo appWidgetProviderInfo;
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "getAppWidgetInfo() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Widget widget = lookupWidgetLocked(appWidgetId, Binder.getCallingUid(), callingPackage);
            if (widget == null || widget.provider == null || widget.provider.zombie) {
                appWidgetProviderInfo = null;
            } else {
                appWidgetProviderInfo = cloneIfLocalBinder(widget.provider.info);
            }
        }
        return appWidgetProviderInfo;
    }

    public RemoteViews getAppWidgetViews(String callingPackage, int appWidgetId) {
        RemoteViews cloneIfLocalBinder;
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "getAppWidgetViews() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Widget widget = lookupWidgetLocked(appWidgetId, Binder.getCallingUid(), callingPackage);
            if (widget != null) {
                cloneIfLocalBinder = cloneIfLocalBinder(widget.views);
            } else {
                cloneIfLocalBinder = null;
            }
        }
        return cloneIfLocalBinder;
    }

    public void updateAppWidgetOptions(String callingPackage, int appWidgetId, Bundle options) {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "updateAppWidgetOptions() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Widget widget = lookupWidgetLocked(appWidgetId, Binder.getCallingUid(), callingPackage);
            if (widget == null) {
                return;
            }
            widget.options.putAll(options);
            sendOptionsChangedIntentLocked(widget);
            saveGroupStateAsync(userId);
        }
    }

    public Bundle getAppWidgetOptions(String callingPackage, int appWidgetId) {
        Bundle bundle;
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "getAppWidgetOptions() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            Widget widget = lookupWidgetLocked(appWidgetId, Binder.getCallingUid(), callingPackage);
            if (widget == null || widget.options == null) {
                bundle = Bundle.EMPTY;
            } else {
                bundle = cloneIfLocalBinder(widget.options);
            }
        }
        return bundle;
    }

    public void updateAppWidgetIds(String callingPackage, int[] appWidgetIds, RemoteViews views) {
        if (DEBUG) {
            Slog.i(TAG, "updateAppWidgetIds() " + UserHandle.getCallingUserId());
        }
        updateAppWidgetIds(callingPackage, appWidgetIds, views, false);
    }

    public void partiallyUpdateAppWidgetIds(String callingPackage, int[] appWidgetIds, RemoteViews views) {
        if (DEBUG) {
            Slog.i(TAG, "partiallyUpdateAppWidgetIds() " + UserHandle.getCallingUserId());
        }
        updateAppWidgetIds(callingPackage, appWidgetIds, views, true);
    }

    public void notifyAppWidgetViewDataChanged(String callingPackage, int[] appWidgetIds, int viewId) {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "notifyAppWidgetViewDataChanged() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
        if (appWidgetIds != null && appWidgetIds.length != 0) {
            synchronized (this.mLock) {
                ensureGroupStateLoadedLocked(userId);
                int N = appWidgetIds.length;
                for (int i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                    Widget widget = lookupWidgetLocked(appWidgetIds[i], Binder.getCallingUid(), callingPackage);
                    if (widget != null) {
                        scheduleNotifyAppWidgetViewDataChanged(widget, viewId);
                    }
                }
            }
        }
    }

    public void updateAppWidgetProvider(ComponentName componentName, RemoteViews views) {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "updateAppWidgetProvider() " + userId);
        }
        this.mSecurityPolicy.enforceCallFromPackage(componentName.getPackageName());
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            ProviderId providerId = new ProviderId(componentName, null);
            Provider provider = lookupProviderLocked(providerId);
            if (provider == null) {
                Slog.w(TAG, "Provider doesn't exist " + providerId);
                return;
            }
            ArrayList<Widget> instances = provider.widgets;
            int N = instances.size();
            for (int i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                updateAppWidgetInstanceLocked((Widget) instances.get(i), views, false);
            }
        }
    }

    public List<AppWidgetProviderInfo> getInstalledProvidersForProfile(int categoryFilter, int profileId) {
        int userId = UserHandle.getCallingUserId();
        if (DEBUG) {
            Slog.i(TAG, "getInstalledProvidersForProfiles() " + userId);
        }
        if (!this.mSecurityPolicy.isEnabledGroupProfile(profileId)) {
            return null;
        }
        List<AppWidgetProviderInfo> result;
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            result = null;
            int providerCount = this.mProviders.size();
            for (int i = MIN_UPDATE_PERIOD; i < providerCount; i += CURRENT_VERSION) {
                Provider provider = (Provider) this.mProviders.get(i);
                AppWidgetProviderInfo info = provider.info;
                if (!(provider.zombie || (info.widgetCategory & categoryFilter) == 0)) {
                    int providerProfileId = info.getProfile().getIdentifier();
                    if (providerProfileId == profileId && this.mSecurityPolicy.isProviderInCallerOrInProfileAndWhitelListed(provider.id.componentName.getPackageName(), providerProfileId)) {
                        if (result == null) {
                            result = new ArrayList();
                        }
                        result.add(cloneIfLocalBinder(info));
                    }
                }
            }
        }
        return result;
    }

    private void updateAppWidgetIds(String callingPackage, int[] appWidgetIds, RemoteViews views, boolean partially) {
        int userId = UserHandle.getCallingUserId();
        if (appWidgetIds != null && appWidgetIds.length != 0) {
            this.mSecurityPolicy.enforceCallFromPackage(callingPackage);
            int bitmapMemoryUsage = views != null ? views.estimateMemoryUsage() : MIN_UPDATE_PERIOD;
            if (bitmapMemoryUsage > this.mMaxWidgetBitmapMemory) {
                throw new IllegalArgumentException("RemoteViews for widget update exceeds maximum bitmap memory usage (used: " + bitmapMemoryUsage + ", max: " + this.mMaxWidgetBitmapMemory + ")");
            }
            synchronized (this.mLock) {
                ensureGroupStateLoadedLocked(userId);
                int N = appWidgetIds.length;
                for (int i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                    Widget widget = lookupWidgetLocked(appWidgetIds[i], Binder.getCallingUid(), callingPackage);
                    if (widget != null) {
                        updateAppWidgetInstanceLocked(widget, views, partially);
                    }
                }
            }
        }
    }

    private int incrementAndGetAppWidgetIdLocked(int userId) {
        int appWidgetId = peekNextAppWidgetIdLocked(userId) + CURRENT_VERSION;
        this.mNextAppWidgetIds.put(userId, appWidgetId);
        return appWidgetId;
    }

    private void setMinAppWidgetIdLocked(int userId, int minWidgetId) {
        if (peekNextAppWidgetIdLocked(userId) < minWidgetId) {
            this.mNextAppWidgetIds.put(userId, minWidgetId);
        }
    }

    private int peekNextAppWidgetIdLocked(int userId) {
        if (this.mNextAppWidgetIds.indexOfKey(userId) < 0) {
            return CURRENT_VERSION;
        }
        return this.mNextAppWidgetIds.get(userId);
    }

    private Host lookupOrAddHostLocked(HostId id) {
        Host host = lookupHostLocked(id);
        if (host != null) {
            return host;
        }
        host = new Host();
        host.id = id;
        this.mHosts.add(host);
        return host;
    }

    private void deleteHostLocked(Host host) {
        for (int i = host.widgets.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
            deleteAppWidgetLocked((Widget) host.widgets.remove(i));
        }
        this.mHosts.remove(host);
        host.callbacks = null;
    }

    private void deleteAppWidgetLocked(Widget widget) {
        unbindAppWidgetRemoteViewsServicesLocked(widget);
        Host host = widget.host;
        host.widgets.remove(widget);
        pruneHostLocked(host);
        this.mWidgets.remove(widget);
        Provider provider = widget.provider;
        if (provider != null) {
            provider.widgets.remove(widget);
            if (!provider.zombie) {
                sendDeletedIntentLocked(widget);
                if (provider.widgets.isEmpty()) {
                    cancelBroadcasts(provider);
                    sendDisabledIntentLocked(provider);
                }
            }
        }
    }

    private void cancelBroadcasts(Provider provider) {
        if (DEBUG) {
            Slog.i(TAG, "cancelBroadcasts() for " + provider);
        }
        if (provider.broadcast != null) {
            this.mAlarmManager.cancel(provider.broadcast);
            long token = Binder.clearCallingIdentity();
            try {
                provider.broadcast.cancel();
                provider.broadcast = null;
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }
    }

    private void unbindAppWidgetRemoteViewsServicesLocked(Widget widget) {
        int appWidgetId = widget.appWidgetId;
        Iterator<Pair<Integer, FilterComparison>> it = this.mBoundRemoteViewsServices.keySet().iterator();
        while (it.hasNext()) {
            Pair<Integer, FilterComparison> key = (Pair) it.next();
            if (((Integer) key.first).intValue() == appWidgetId) {
                ServiceConnectionProxy conn = (ServiceConnectionProxy) this.mBoundRemoteViewsServices.get(key);
                conn.disconnect();
                this.mContext.unbindService(conn);
                it.remove();
            }
        }
        decrementAppWidgetServiceRefCount(widget);
    }

    private void destroyRemoteViewsService(Intent intent, Widget widget) {
        ServiceConnection conn = new C01542(intent);
        long token = Binder.clearCallingIdentity();
        try {
            this.mContext.bindServiceAsUser(intent, conn, CURRENT_VERSION, widget.provider.info.getProfile());
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    private void incrementAppWidgetServiceRefCount(int appWidgetId, Pair<Integer, FilterComparison> serviceId) {
        HashSet<Integer> appWidgetIds;
        if (this.mRemoteViewsServicesAppWidgets.containsKey(serviceId)) {
            appWidgetIds = (HashSet) this.mRemoteViewsServicesAppWidgets.get(serviceId);
        } else {
            appWidgetIds = new HashSet();
            this.mRemoteViewsServicesAppWidgets.put(serviceId, appWidgetIds);
        }
        appWidgetIds.add(Integer.valueOf(appWidgetId));
    }

    private void decrementAppWidgetServiceRefCount(Widget widget) {
        Iterator<Pair<Integer, FilterComparison>> it = this.mRemoteViewsServicesAppWidgets.keySet().iterator();
        while (it.hasNext()) {
            Pair<Integer, FilterComparison> key = (Pair) it.next();
            HashSet<Integer> ids = (HashSet) this.mRemoteViewsServicesAppWidgets.get(key);
            if (ids.remove(Integer.valueOf(widget.appWidgetId)) && ids.isEmpty()) {
                destroyRemoteViewsService(((FilterComparison) key.second).getIntent(), widget);
                it.remove();
            }
        }
    }

    private void saveGroupStateAsync(int groupId) {
        this.mSaveStateHandler.post(new SaveStateRunnable(groupId));
    }

    private void updateAppWidgetInstanceLocked(Widget widget, RemoteViews views, boolean isPartialUpdate) {
        if (widget != null && widget.provider != null && !widget.provider.zombie && !widget.host.zombie) {
            if (!isPartialUpdate || widget.views == null) {
                widget.views = views;
            } else {
                widget.views.mergeRemoteViews(views);
            }
            scheduleNotifyUpdateAppWidgetLocked(widget, views);
        }
    }

    private void scheduleNotifyAppWidgetViewDataChanged(Widget widget, int viewId) {
        if (widget != null && widget.host != null && !widget.host.zombie && widget.host.callbacks != null && widget.provider != null && !widget.provider.zombie) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = widget.host;
            args.arg2 = widget.host.callbacks;
            args.argi1 = widget.appWidgetId;
            args.argi2 = viewId;
            this.mCallbackHandler.obtainMessage(4, args).sendToTarget();
        }
    }

    private void handleNotifyAppWidgetViewDataChanged(Host host, IAppWidgetHost callbacks, int appWidgetId, int viewId) {
        try {
            callbacks.viewDataChanged(appWidgetId, viewId);
        } catch (RemoteException e) {
            callbacks = null;
        }
        synchronized (this.mLock) {
            if (callbacks == null) {
                host.callbacks = null;
                for (Pair<Integer, FilterComparison> key : this.mRemoteViewsServicesAppWidgets.keySet()) {
                    if (((HashSet) this.mRemoteViewsServicesAppWidgets.get(key)).contains(Integer.valueOf(appWidgetId))) {
                        bindService(((FilterComparison) key.second).getIntent(), new C01553(), new UserHandle(UserHandle.getUserId(((Integer) key.first).intValue())));
                    }
                }
            }
        }
    }

    private void scheduleNotifyUpdateAppWidgetLocked(Widget widget, RemoteViews updateViews) {
        if (widget != null && widget.provider != null && !widget.provider.zombie && widget.host.callbacks != null && !widget.host.zombie) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = widget.host;
            args.arg2 = widget.host.callbacks;
            args.arg3 = updateViews;
            args.argi1 = widget.appWidgetId;
            this.mCallbackHandler.obtainMessage(CURRENT_VERSION, args).sendToTarget();
        }
    }

    private void handleNotifyUpdateAppWidget(Host host, IAppWidgetHost callbacks, int appWidgetId, RemoteViews views) {
        try {
            callbacks.updateAppWidget(appWidgetId, views);
        } catch (RemoteException re) {
            synchronized (this.mLock) {
            }
            Slog.e(TAG, "Widget host dead: " + host.id, re);
            host.callbacks = null;
        }
    }

    private void scheduleNotifyProviderChangedLocked(Widget widget) {
        if (widget != null && widget.provider != null && !widget.provider.zombie && widget.host.callbacks != null && !widget.host.zombie) {
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = widget.host;
            args.arg2 = widget.host.callbacks;
            args.arg3 = widget.provider.info;
            args.argi1 = widget.appWidgetId;
            this.mCallbackHandler.obtainMessage(2, args).sendToTarget();
        }
    }

    private void handleNotifyProviderChanged(Host host, IAppWidgetHost callbacks, int appWidgetId, AppWidgetProviderInfo info) {
        try {
            callbacks.providerChanged(appWidgetId, info);
        } catch (RemoteException re) {
            synchronized (this.mLock) {
            }
            Slog.e(TAG, "Widget host dead: " + host.id, re);
            host.callbacks = null;
        }
    }

    private void scheduleNotifyGroupHostsForProvidersChangedLocked(int userId) {
        int[] profileIds = this.mSecurityPolicy.getEnabledGroupProfileIds(userId);
        for (int i = this.mHosts.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
            Host host = (Host) this.mHosts.get(i);
            boolean hostInGroup = false;
            int M = profileIds.length;
            for (int j = MIN_UPDATE_PERIOD; j < M; j += CURRENT_VERSION) {
                if (host.getUserId() == profileIds[j]) {
                    hostInGroup = true;
                    break;
                }
            }
            if (!(!hostInGroup || host == null || host.zombie || host.callbacks == null)) {
                SomeArgs args = SomeArgs.obtain();
                args.arg1 = host;
                args.arg2 = host.callbacks;
                this.mCallbackHandler.obtainMessage(3, args).sendToTarget();
            }
        }
    }

    private void handleNotifyProvidersChanged(Host host, IAppWidgetHost callbacks) {
        try {
            callbacks.providersChanged();
        } catch (RemoteException re) {
            synchronized (this.mLock) {
            }
            Slog.e(TAG, "Widget host dead: " + host.id, re);
            host.callbacks = null;
        }
    }

    private static boolean isLocalBinder() {
        return Process.myPid() == Binder.getCallingPid();
    }

    private static RemoteViews cloneIfLocalBinder(RemoteViews rv) {
        if (!isLocalBinder() || rv == null) {
            return rv;
        }
        return rv.clone();
    }

    private static AppWidgetProviderInfo cloneIfLocalBinder(AppWidgetProviderInfo info) {
        if (!isLocalBinder() || info == null) {
            return info;
        }
        return info.clone();
    }

    private static Bundle cloneIfLocalBinder(Bundle bundle) {
        if (!isLocalBinder() || bundle == null) {
            return bundle;
        }
        return (Bundle) bundle.clone();
    }

    private Widget lookupWidgetLocked(int appWidgetId, int uid, String packageName) {
        int N = this.mWidgets.size();
        for (int i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
            Widget widget = (Widget) this.mWidgets.get(i);
            if (widget.appWidgetId == appWidgetId && this.mSecurityPolicy.canAccessAppWidget(widget, uid, packageName)) {
                return widget;
            }
        }
        return null;
    }

    private Provider lookupProviderLocked(ProviderId id) {
        int N = this.mProviders.size();
        for (int i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
            Provider provider = (Provider) this.mProviders.get(i);
            if (provider.id.equals(id)) {
                return provider;
            }
        }
        return null;
    }

    private Host lookupHostLocked(HostId hostId) {
        int N = this.mHosts.size();
        for (int i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
            Host host = (Host) this.mHosts.get(i);
            if (host.id.equals(hostId)) {
                return host;
            }
        }
        return null;
    }

    private void pruneHostLocked(Host host) {
        if (host.widgets.size() == 0 && host.callbacks == null) {
            if (DEBUG) {
                Slog.i(TAG, "Pruning host " + host.id);
            }
            this.mHosts.remove(host);
        }
    }

    private void loadGroupWidgetProvidersLocked(int[] profileIds) {
        int i;
        List<ResolveInfo> allReceivers = null;
        Intent intent = new Intent("android.appwidget.action.APPWIDGET_UPDATE");
        int profileCount = profileIds.length;
        for (i = MIN_UPDATE_PERIOD; i < profileCount; i += CURRENT_VERSION) {
            List<ResolveInfo> receivers = queryIntentReceivers(intent, profileIds[i]);
            if (!(receivers == null || receivers.isEmpty())) {
                if (allReceivers == null) {
                    allReceivers = new ArrayList();
                }
                allReceivers.addAll(receivers);
            }
        }
        int N = allReceivers == null ? MIN_UPDATE_PERIOD : allReceivers.size();
        for (i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
            addProviderLocked((ResolveInfo) allReceivers.get(i));
        }
    }

    private boolean addProviderLocked(ResolveInfo ri) {
        if ((ri.activityInfo.applicationInfo.flags & 262144) != 0 || !ri.activityInfo.isEnabled()) {
            return false;
        }
        ComponentName componentName = new ComponentName(ri.activityInfo.packageName, ri.activityInfo.name);
        ProviderId providerId = new ProviderId(componentName, null);
        Provider provider = parseProviderInfoXml(providerId, ri);
        if (provider == null) {
            return false;
        }
        Provider existing = lookupProviderLocked(providerId);
        if (existing == null) {
            existing = lookupProviderLocked(new ProviderId(componentName, null));
        }
        if (existing == null) {
            this.mProviders.add(provider);
        } else if (existing.zombie && !this.mSafeMode) {
            existing.id = providerId;
            existing.zombie = false;
            existing.info = provider.info;
            if (DEBUG) {
                Slog.i(TAG, "Provider placeholder now reified: " + existing);
            }
        }
        return true;
    }

    private void deleteProviderLocked(Provider provider) {
        for (int i = provider.widgets.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
            Widget widget = (Widget) provider.widgets.remove(i);
            updateAppWidgetInstanceLocked(widget, null, false);
            widget.host.widgets.remove(widget);
            this.mWidgets.remove(widget);
            widget.provider = null;
            pruneHostLocked(widget.host);
            widget.host = null;
        }
        this.mProviders.remove(provider);
        cancelBroadcasts(provider);
    }

    private void sendEnableIntentLocked(Provider p) {
        Intent intent = new Intent("android.appwidget.action.APPWIDGET_ENABLED");
        intent.setComponent(p.info.provider);
        sendBroadcastAsUser(intent, p.info.getProfile());
    }

    private void sendUpdateIntentLocked(Provider provider, int[] appWidgetIds) {
        Intent intent = new Intent("android.appwidget.action.APPWIDGET_UPDATE");
        intent.putExtra("appWidgetIds", appWidgetIds);
        intent.setComponent(provider.info.provider);
        sendBroadcastAsUser(intent, provider.info.getProfile());
    }

    private void sendDeletedIntentLocked(Widget widget) {
        Intent intent = new Intent("android.appwidget.action.APPWIDGET_DELETED");
        intent.setComponent(widget.provider.info.provider);
        intent.putExtra("appWidgetId", widget.appWidgetId);
        sendBroadcastAsUser(intent, widget.provider.info.getProfile());
    }

    private void sendDisabledIntentLocked(Provider provider) {
        Intent intent = new Intent("android.appwidget.action.APPWIDGET_DISABLED");
        intent.setComponent(provider.info.provider);
        sendBroadcastAsUser(intent, provider.info.getProfile());
    }

    public void sendOptionsChangedIntentLocked(Widget widget) {
        Intent intent = new Intent("android.appwidget.action.APPWIDGET_UPDATE_OPTIONS");
        intent.setComponent(widget.provider.info.provider);
        intent.putExtra("appWidgetId", widget.appWidgetId);
        intent.putExtra("appWidgetOptions", widget.options);
        sendBroadcastAsUser(intent, widget.provider.info.getProfile());
    }

    private void registerForBroadcastsLocked(Provider provider, int[] appWidgetIds) {
        boolean alreadyRegistered = true;
        if (provider.info.updatePeriodMillis > 0) {
            if (provider.broadcast == null) {
                alreadyRegistered = false;
            }
            Intent intent = new Intent("android.appwidget.action.APPWIDGET_UPDATE");
            intent.putExtra("appWidgetIds", appWidgetIds);
            intent.setComponent(provider.info.provider);
            long token = Binder.clearCallingIdentity();
            try {
                provider.broadcast = PendingIntent.getBroadcastAsUser(this.mContext, CURRENT_VERSION, intent, 134217728, provider.info.getProfile());
                if (!alreadyRegistered) {
                    long period = (long) provider.info.updatePeriodMillis;
                    if (period < ((long) MIN_UPDATE_PERIOD)) {
                        period = (long) MIN_UPDATE_PERIOD;
                    }
                    this.mAlarmManager.setInexactRepeating(2, SystemClock.elapsedRealtime() + period, period, provider.broadcast);
                }
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }
    }

    private static int[] getWidgetIds(ArrayList<Widget> widgets) {
        int instancesSize = widgets.size();
        int[] appWidgetIds = new int[instancesSize];
        for (int i = MIN_UPDATE_PERIOD; i < instancesSize; i += CURRENT_VERSION) {
            appWidgetIds[i] = ((Widget) widgets.get(i)).appWidgetId;
        }
        return appWidgetIds;
    }

    private static void dumpProvider(Provider provider, int index, PrintWriter pw) {
        AppWidgetProviderInfo info = provider.info;
        pw.print("  [");
        pw.print(index);
        pw.print("] provider ");
        pw.println(provider.id);
        pw.print("    min=(");
        pw.print(info.minWidth);
        pw.print("x");
        pw.print(info.minHeight);
        pw.print(")   minResize=(");
        pw.print(info.minResizeWidth);
        pw.print("x");
        pw.print(info.minResizeHeight);
        pw.print(") updatePeriodMillis=");
        pw.print(info.updatePeriodMillis);
        pw.print(" resizeMode=");
        pw.print(info.resizeMode);
        pw.print(info.widgetCategory);
        pw.print(" autoAdvanceViewId=");
        pw.print(info.autoAdvanceViewId);
        pw.print(" initialLayout=#");
        pw.print(Integer.toHexString(info.initialLayout));
        pw.print(" initialKeyguardLayout=#");
        pw.print(Integer.toHexString(info.initialKeyguardLayout));
        pw.print(" zombie=");
        pw.println(provider.zombie);
    }

    private static void dumpHost(Host host, int index, PrintWriter pw) {
        pw.print("  [");
        pw.print(index);
        pw.print("] hostId=");
        pw.println(host.id);
        pw.print("    callbacks=");
        pw.println(host.callbacks);
        pw.print("    widgets.size=");
        pw.print(host.widgets.size());
        pw.print(" zombie=");
        pw.println(host.zombie);
    }

    private static void dumpGrant(Pair<Integer, String> grant, int index, PrintWriter pw) {
        pw.print("  [");
        pw.print(index);
        pw.print(']');
        pw.print(" user=");
        pw.print(grant.first);
        pw.print(" package=");
        pw.println((String) grant.second);
    }

    private static void dumpWidget(Widget widget, int index, PrintWriter pw) {
        pw.print("  [");
        pw.print(index);
        pw.print("] id=");
        pw.println(widget.appWidgetId);
        pw.print("    host=");
        pw.println(widget.host.id);
        if (widget.provider != null) {
            pw.print("    provider=");
            pw.println(widget.provider.id);
        }
        if (widget.host != null) {
            pw.print("    host.callbacks=");
            pw.println(widget.host.callbacks);
        }
        if (widget.views != null) {
            pw.print("    views=");
            pw.println(widget.views);
        }
    }

    private static void serializeProvider(XmlSerializer out, Provider p) throws IOException {
        out.startTag(null, "p");
        out.attribute(null, "pkg", p.info.provider.getPackageName());
        out.attribute(null, "cl", p.info.provider.getClassName());
        out.attribute(null, "tag", Integer.toHexString(p.tag));
        out.endTag(null, "p");
    }

    private static void serializeHost(XmlSerializer out, Host host) throws IOException {
        out.startTag(null, "h");
        out.attribute(null, "pkg", host.id.packageName);
        out.attribute(null, "id", Integer.toHexString(host.id.hostId));
        out.attribute(null, "tag", Integer.toHexString(host.tag));
        out.endTag(null, "h");
    }

    private static void serializeAppWidget(XmlSerializer out, Widget widget) throws IOException {
        out.startTag(null, "g");
        out.attribute(null, "id", Integer.toHexString(widget.appWidgetId));
        out.attribute(null, "rid", Integer.toHexString(widget.restoredId));
        out.attribute(null, "h", Integer.toHexString(widget.host.tag));
        if (widget.provider != null) {
            out.attribute(null, "p", Integer.toHexString(widget.provider.tag));
        }
        if (widget.options != null) {
            out.attribute(null, "min_width", Integer.toHexString(widget.options.getInt("appWidgetMinWidth")));
            out.attribute(null, "min_height", Integer.toHexString(widget.options.getInt("appWidgetMinHeight")));
            out.attribute(null, "max_width", Integer.toHexString(widget.options.getInt("appWidgetMaxWidth")));
            out.attribute(null, "max_height", Integer.toHexString(widget.options.getInt("appWidgetMaxHeight")));
            out.attribute(null, "host_category", Integer.toHexString(widget.options.getInt("appWidgetCategory")));
        }
        out.endTag(null, "g");
    }

    public List<String> getWidgetParticipants(int userId) {
        return this.mBackupRestoreController.getWidgetParticipants(userId);
    }

    public byte[] getWidgetState(String packageName, int userId) {
        return this.mBackupRestoreController.getWidgetState(packageName, userId);
    }

    public void restoreStarting(int userId) {
        this.mBackupRestoreController.restoreStarting(userId);
    }

    public void restoreWidgetState(String packageName, byte[] restoredState, int userId) {
        this.mBackupRestoreController.restoreWidgetState(packageName, restoredState, userId);
    }

    public void restoreFinished(int userId) {
        this.mBackupRestoreController.restoreFinished(userId);
    }

    private Provider parseProviderInfoXml(ProviderId providerId, ResolveInfo ri) {
        Provider provider;
        long identity;
        Exception e;
        Exception e2;
        Throwable th;
        ActivityInfo activityInfo = ri.activityInfo;
        XmlResourceParser parser = null;
        try {
            parser = activityInfo.loadXmlMetaData(this.mContext.getPackageManager(), "android.appwidget.provider");
            if (parser == null) {
                Slog.w(TAG, "No android.appwidget.provider meta-data for AppWidget provider '" + providerId + '\'');
                provider = null;
                if (parser != null) {
                    parser.close();
                }
            } else {
                AttributeSet attrs = Xml.asAttributeSet(parser);
                int type;
                do {
                    type = parser.next();
                    if (type == CURRENT_VERSION) {
                        break;
                    }
                } while (type != 2);
                if ("appwidget-provider".equals(parser.getName())) {
                    provider = new Provider();
                    Provider provider2;
                    try {
                        provider.id = providerId;
                        AppWidgetProviderInfo info = new AppWidgetProviderInfo();
                        provider.info = info;
                        info.provider = providerId.componentName;
                        info.providerInfo = activityInfo;
                        identity = Binder.clearCallingIdentity();
                        Resources resources = this.mContext.getPackageManager().getResourcesForApplicationAsUser(activityInfo.packageName, UserHandle.getUserId(providerId.uid));
                        Binder.restoreCallingIdentity(identity);
                        TypedArray sa = resources.obtainAttributes(attrs, R.styleable.AppWidgetProviderInfo);
                        TypedValue value = sa.peekValue(MIN_UPDATE_PERIOD);
                        info.minWidth = value != null ? value.data : MIN_UPDATE_PERIOD;
                        value = sa.peekValue(CURRENT_VERSION);
                        info.minHeight = value != null ? value.data : MIN_UPDATE_PERIOD;
                        value = sa.peekValue(8);
                        info.minResizeWidth = value != null ? value.data : info.minWidth;
                        value = sa.peekValue(9);
                        info.minResizeHeight = value != null ? value.data : info.minHeight;
                        info.updatePeriodMillis = sa.getInt(2, MIN_UPDATE_PERIOD);
                        info.initialLayout = sa.getResourceId(3, MIN_UPDATE_PERIOD);
                        info.initialKeyguardLayout = sa.getResourceId(10, MIN_UPDATE_PERIOD);
                        String className = sa.getString(4);
                        if (className != null) {
                            info.configure = new ComponentName(providerId.componentName.getPackageName(), className);
                        }
                        info.label = activityInfo.loadLabel(this.mContext.getPackageManager()).toString();
                        info.icon = ri.getIconResource();
                        info.previewImage = sa.getResourceId(5, MIN_UPDATE_PERIOD);
                        info.autoAdvanceViewId = sa.getResourceId(6, UNKNOWN_UID);
                        info.resizeMode = sa.getInt(7, MIN_UPDATE_PERIOD);
                        info.widgetCategory = sa.getInt(11, CURRENT_VERSION);
                        sa.recycle();
                        if (parser != null) {
                            parser.close();
                        }
                        provider2 = provider;
                    } catch (IOException e3) {
                        e = e3;
                        provider2 = provider;
                        e2 = e;
                        try {
                            Slog.w(TAG, "XML parsing failed for AppWidget provider " + providerId.componentName + " for user " + providerId.uid, e2);
                            provider = null;
                            if (parser != null) {
                                parser.close();
                            }
                            return provider;
                        } catch (Throwable th2) {
                            th = th2;
                            if (parser != null) {
                                parser.close();
                            }
                            throw th;
                        }
                    } catch (NameNotFoundException e4) {
                        e = e4;
                        provider2 = provider;
                        e2 = e;
                        Slog.w(TAG, "XML parsing failed for AppWidget provider " + providerId.componentName + " for user " + providerId.uid, e2);
                        provider = null;
                        if (parser != null) {
                            parser.close();
                        }
                        return provider;
                    } catch (XmlPullParserException e5) {
                        e = e5;
                        provider2 = provider;
                        e2 = e;
                        Slog.w(TAG, "XML parsing failed for AppWidget provider " + providerId.componentName + " for user " + providerId.uid, e2);
                        provider = null;
                        if (parser != null) {
                            parser.close();
                        }
                        return provider;
                    } catch (Throwable th3) {
                        th = th3;
                        provider2 = provider;
                        if (parser != null) {
                            parser.close();
                        }
                        throw th;
                    }
                }
                Slog.w(TAG, "Meta-data does not start with appwidget-provider tag for AppWidget provider " + providerId.componentName + " for user " + providerId.uid);
                provider = null;
                if (parser != null) {
                    parser.close();
                }
            }
        } catch (IOException e6) {
            e = e6;
            e2 = e;
            Slog.w(TAG, "XML parsing failed for AppWidget provider " + providerId.componentName + " for user " + providerId.uid, e2);
            provider = null;
            if (parser != null) {
                parser.close();
            }
            return provider;
        } catch (NameNotFoundException e7) {
            e = e7;
            e2 = e;
            Slog.w(TAG, "XML parsing failed for AppWidget provider " + providerId.componentName + " for user " + providerId.uid, e2);
            provider = null;
            if (parser != null) {
                parser.close();
            }
            return provider;
        } catch (XmlPullParserException e8) {
            e = e8;
            e2 = e;
            Slog.w(TAG, "XML parsing failed for AppWidget provider " + providerId.componentName + " for user " + providerId.uid, e2);
            provider = null;
            if (parser != null) {
                parser.close();
            }
            return provider;
        }
        return provider;
    }

    private int getUidForPackage(String packageName, int userId) {
        PackageInfo pkgInfo = null;
        long identity = Binder.clearCallingIdentity();
        try {
            pkgInfo = this.mPackageManager.getPackageInfo(packageName, MIN_UPDATE_PERIOD, userId);
        } catch (RemoteException e) {
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
        if (pkgInfo == null || pkgInfo.applicationInfo == null) {
            return UNKNOWN_UID;
        }
        return pkgInfo.applicationInfo.uid;
    }

    private ActivityInfo getProviderInfo(ComponentName componentName, int userId) {
        Intent intent = new Intent("android.appwidget.action.APPWIDGET_UPDATE");
        intent.setComponent(componentName);
        List<ResolveInfo> receivers = queryIntentReceivers(intent, userId);
        if (receivers.isEmpty()) {
            return null;
        }
        return ((ResolveInfo) receivers.get(MIN_UPDATE_PERIOD)).activityInfo;
    }

    private List<ResolveInfo> queryIntentReceivers(Intent intent, int userId) {
        List<ResolveInfo> queryIntentReceivers;
        long identity = Binder.clearCallingIdentity();
        try {
            queryIntentReceivers = this.mPackageManager.queryIntentReceivers(intent, intent.resolveTypeIfNeeded(this.mContext.getContentResolver()), DumpState.DUMP_PROVIDERS | DumpState.DUMP_PREFERRED_XML, userId);
        } catch (RemoteException e) {
            queryIntentReceivers = Collections.emptyList();
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
        return queryIntentReceivers;
    }

    private void onUserStarted(int userId) {
        synchronized (this.mLock) {
            ensureGroupStateLoadedLocked(userId);
            int N = this.mProviders.size();
            for (int i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                Provider provider = (Provider) this.mProviders.get(i);
                if (provider.getUserId() == userId && provider.widgets.size() > 0) {
                    sendEnableIntentLocked(provider);
                    int[] appWidgetIds = getWidgetIds(provider.widgets);
                    sendUpdateIntentLocked(provider, appWidgetIds);
                    registerForBroadcastsLocked(provider, appWidgetIds);
                }
            }
        }
    }

    private void loadGroupStateLocked(int[] profileIds) {
        int i;
        List<LoadedWidgetState> loadedWidgets = new ArrayList();
        int version = MIN_UPDATE_PERIOD;
        int profileIdCount = profileIds.length;
        for (i = MIN_UPDATE_PERIOD; i < profileIdCount; i += CURRENT_VERSION) {
            int profileId = profileIds[i];
            try {
                FileInputStream stream = getSavedStateFile(profileId).openRead();
                version = readProfileStateFromFileLocked(stream, profileId, loadedWidgets);
                IoUtils.closeQuietly(stream);
            } catch (FileNotFoundException e) {
                Slog.w(TAG, "Failed to read state: " + e);
            }
        }
        if (version >= 0) {
            bindLoadedWidgets(loadedWidgets);
            performUpgradeLocked(version);
            return;
        }
        Slog.w(TAG, "Failed to read state, clearing widgets and hosts.");
        this.mWidgets.clear();
        this.mHosts.clear();
        int N = this.mProviders.size();
        for (i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
            ((Provider) this.mProviders.get(i)).widgets.clear();
        }
    }

    private void bindLoadedWidgets(List<LoadedWidgetState> loadedWidgets) {
        for (int i = loadedWidgets.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
            LoadedWidgetState loadedWidget = (LoadedWidgetState) loadedWidgets.remove(i);
            Widget widget = loadedWidget.widget;
            widget.provider = findProviderByTag(loadedWidget.providerTag);
            if (widget.provider != null) {
                widget.host = findHostByTag(loadedWidget.hostTag);
                if (widget.host != null) {
                    widget.provider.widgets.add(widget);
                    widget.host.widgets.add(widget);
                    this.mWidgets.add(widget);
                }
            }
        }
    }

    private Provider findProviderByTag(int tag) {
        if (tag < 0) {
            return null;
        }
        int providerCount = this.mProviders.size();
        for (int i = MIN_UPDATE_PERIOD; i < providerCount; i += CURRENT_VERSION) {
            Provider provider = (Provider) this.mProviders.get(i);
            if (provider.tag == tag) {
                return provider;
            }
        }
        return null;
    }

    private Host findHostByTag(int tag) {
        if (tag < 0) {
            return null;
        }
        int hostCount = this.mHosts.size();
        for (int i = MIN_UPDATE_PERIOD; i < hostCount; i += CURRENT_VERSION) {
            Host host = (Host) this.mHosts.get(i);
            if (host.tag == tag) {
                return host;
            }
        }
        return null;
    }

    private void saveStateLocked(int userId) {
        tagProvidersAndHosts();
        int[] profileIds = this.mSecurityPolicy.getEnabledGroupProfileIds(userId);
        int profileCount = profileIds.length;
        for (int i = MIN_UPDATE_PERIOD; i < profileCount; i += CURRENT_VERSION) {
            int profileId = profileIds[i];
            AtomicFile file = getSavedStateFile(profileId);
            try {
                FileOutputStream stream = file.startWrite();
                if (writeProfileStateToFileLocked(stream, profileId)) {
                    file.finishWrite(stream);
                } else {
                    file.failWrite(stream);
                    Slog.w(TAG, "Failed to save state, restoring backup.");
                }
            } catch (IOException e) {
                Slog.w(TAG, "Failed open state file for write: " + e);
            }
        }
    }

    private void tagProvidersAndHosts() {
        int i;
        int providerCount = this.mProviders.size();
        for (i = MIN_UPDATE_PERIOD; i < providerCount; i += CURRENT_VERSION) {
            ((Provider) this.mProviders.get(i)).tag = i;
        }
        int hostCount = this.mHosts.size();
        for (i = MIN_UPDATE_PERIOD; i < hostCount; i += CURRENT_VERSION) {
            ((Host) this.mHosts.get(i)).tag = i;
        }
    }

    private void clearProvidersAndHostsTagsLocked() {
        int i;
        int providerCount = this.mProviders.size();
        for (i = MIN_UPDATE_PERIOD; i < providerCount; i += CURRENT_VERSION) {
            ((Provider) this.mProviders.get(i)).tag = UNKNOWN_UID;
        }
        int hostCount = this.mHosts.size();
        for (i = MIN_UPDATE_PERIOD; i < hostCount; i += CURRENT_VERSION) {
            ((Host) this.mHosts.get(i)).tag = UNKNOWN_UID;
        }
    }

    private boolean writeProfileStateToFileLocked(FileOutputStream stream, int userId) {
        try {
            int i;
            XmlSerializer out = new FastXmlSerializer();
            out.setOutput(stream, StandardCharsets.UTF_8.name());
            out.startDocument(null, Boolean.valueOf(true));
            out.startTag(null, "gs");
            out.attribute(null, "version", String.valueOf(CURRENT_VERSION));
            int N = this.mProviders.size();
            for (i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                Provider provider = (Provider) this.mProviders.get(i);
                if (provider.getUserId() == userId && provider.widgets.size() > 0) {
                    serializeProvider(out, provider);
                }
            }
            N = this.mHosts.size();
            for (i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                Host host = (Host) this.mHosts.get(i);
                if (host.getUserId() == userId) {
                    serializeHost(out, host);
                }
            }
            N = this.mWidgets.size();
            for (i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
                Widget widget = (Widget) this.mWidgets.get(i);
                if (widget.host.getUserId() == userId) {
                    serializeAppWidget(out, widget);
                }
            }
            Iterator<Pair<Integer, String>> it = this.mPackagesWithBindWidgetPermission.iterator();
            while (it.hasNext()) {
                Pair<Integer, String> binding = (Pair) it.next();
                if (((Integer) binding.first).intValue() == userId) {
                    out.startTag(null, "b");
                    out.attribute(null, "packageName", (String) binding.second);
                    out.endTag(null, "b");
                }
            }
            out.endTag(null, "gs");
            out.endDocument();
            return true;
        } catch (IOException e) {
            Slog.w(TAG, "Failed to write state: " + e);
            return false;
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private int readProfileStateFromFileLocked(java.io.FileInputStream r39, int r40, java.util.List<com.android.server.appwidget.AppWidgetServiceImpl.LoadedWidgetState> r41) {
        /*
        r38 = this;
        r33 = -1;
        r21 = android.util.Xml.newPullParser();	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = r35.name();	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r21;
        r1 = r39;
        r2 = r35;
        r0.setInput(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r12 = -1;
        r11 = -1;
    L_0x0017:
        r31 = r21.next();	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 2;
        r0 = r31;
        r1 = r35;
        if (r0 != r1) goto L_0x0045;
    L_0x0023:
        r29 = r21.getName();	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = "gs";
        r0 = r35;
        r1 = r29;
        r35 = r0.equals(r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r35 == 0) goto L_0x0054;
    L_0x0033:
        r35 = 0;
        r36 = "version";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r3 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r33 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0050, NullPointerException -> 0x013b, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x0045:
        r35 = 1;
        r0 = r31;
        r1 = r35;
        if (r0 != r1) goto L_0x0017;
    L_0x004d:
        r35 = r33;
    L_0x004f:
        return r35;
    L_0x0050:
        r7 = move-exception;
        r33 = 0;
        goto L_0x0045;
    L_0x0054:
        r35 = "p";
        r0 = r35;
        r1 = r29;
        r35 = r0.equals(r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r35 == 0) goto L_0x015d;
    L_0x0060:
        r12 = r12 + 1;
        r35 = 0;
        r36 = "pkg";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r22 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r36 = "cl";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r5 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r38;
        r1 = r22;
        r2 = r40;
        r22 = r0.getCanonicalPackageName(r1, r5, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r22 == 0) goto L_0x0045;
    L_0x008a:
        r0 = r38;
        r1 = r22;
        r2 = r40;
        r32 = r0.getUidForPackage(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r32 < 0) goto L_0x0045;
    L_0x0096:
        r6 = new android.content.ComponentName;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r22;
        r6.<init>(r0, r5);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r38;
        r1 = r40;
        r25 = r0.getProviderInfo(r6, r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r25 == 0) goto L_0x0045;
    L_0x00a7:
        r24 = new com.android.server.appwidget.AppWidgetServiceImpl$ProviderId;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r0 = r24;
        r1 = r32;
        r2 = r35;
        r0.<init>(r6, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r38;
        r1 = r24;
        r23 = r0.lookupProviderLocked(r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r23 != 0) goto L_0x0115;
    L_0x00be:
        r0 = r38;
        r0 = r0.mSafeMode;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = r0;
        if (r35 == 0) goto L_0x0115;
    L_0x00c6:
        r23 = new com.android.server.appwidget.AppWidgetServiceImpl$Provider;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r0 = r23;
        r1 = r35;
        r0.<init>();	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = new android.appwidget.AppWidgetProviderInfo;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35.<init>();	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r35;
        r1 = r23;
        r1.info = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r23;
        r0 = r0.info;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = r0;
        r0 = r24;
        r0 = r0.componentName;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r36 = r0;
        r0 = r36;
        r1 = r35;
        r1.provider = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r23;
        r0 = r0.info;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = r0;
        r0 = r25;
        r1 = r35;
        r1.providerInfo = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 1;
        r0 = r35;
        r1 = r23;
        r1.zombie = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r24;
        r1 = r23;
        r1.id = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r38;
        r0 = r0.mProviders;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = r0;
        r0 = r35;
        r1 = r23;
        r0.add(r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x0115:
        r35 = 0;
        r36 = "tag";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r30 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = android.text.TextUtils.isEmpty(r30);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r35 != 0) goto L_0x015a;
    L_0x0129:
        r35 = 16;
        r0 = r30;
        r1 = r35;
        r27 = java.lang.Integer.parseInt(r0, r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x0133:
        r0 = r27;
        r1 = r23;
        r1.tag = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        goto L_0x0045;
    L_0x013b:
        r7 = move-exception;
    L_0x013c:
        r35 = "AppWidgetServiceImpl";
        r36 = new java.lang.StringBuilder;
        r36.<init>();
        r37 = "failed parsing ";
        r36 = r36.append(r37);
        r0 = r36;
        r36 = r0.append(r7);
        r36 = r36.toString();
        android.util.Slog.w(r35, r36);
        r35 = -1;
        goto L_0x004f;
    L_0x015a:
        r27 = r12;
        goto L_0x0133;
    L_0x015d:
        r35 = "h";
        r0 = r35;
        r1 = r29;
        r35 = r0.equals(r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r35 == 0) goto L_0x01f7;
    L_0x0169:
        r11 = r11 + 1;
        r8 = new com.android.server.appwidget.AppWidgetServiceImpl$Host;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r0 = r35;
        r8.<init>();	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r36 = "pkg";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r22 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r38;
        r1 = r22;
        r2 = r40;
        r32 = r0.getUidForPackage(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r32 >= 0) goto L_0x0194;
    L_0x018e:
        r35 = 1;
        r0 = r35;
        r8.zombie = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x0194:
        r0 = r8.zombie;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = r0;
        if (r35 == 0) goto L_0x01a2;
    L_0x019a:
        r0 = r38;
        r0 = r0.mSafeMode;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = r0;
        if (r35 == 0) goto L_0x0045;
    L_0x01a2:
        r35 = 0;
        r36 = "id";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r35 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r36 = 16;
        r9 = java.lang.Integer.parseInt(r35, r36);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r36 = "tag";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r30 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = android.text.TextUtils.isEmpty(r30);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r35 != 0) goto L_0x01f5;
    L_0x01ca:
        r35 = 16;
        r0 = r30;
        r1 = r35;
        r10 = java.lang.Integer.parseInt(r0, r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x01d4:
        r8.tag = r10;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = new com.android.server.appwidget.AppWidgetServiceImpl$HostId;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r35;
        r1 = r32;
        r2 = r22;
        r0.<init>(r1, r9, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r35;
        r8.id = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r38;
        r0 = r0.mHosts;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = r0;
        r0 = r35;
        r0.add(r8);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        goto L_0x0045;
    L_0x01f2:
        r7 = move-exception;
        goto L_0x013c;
    L_0x01f5:
        r10 = r11;
        goto L_0x01d4;
    L_0x01f7:
        r35 = "b";
        r0 = r35;
        r1 = r29;
        r35 = r0.equals(r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r35 == 0) goto L_0x023b;
    L_0x0203:
        r35 = 0;
        r36 = "packageName";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r20 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r38;
        r1 = r20;
        r2 = r40;
        r32 = r0.getUidForPackage(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r32 < 0) goto L_0x0045;
    L_0x021d:
        r35 = java.lang.Integer.valueOf(r40);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r35;
        r1 = r20;
        r19 = android.util.Pair.create(r0, r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r38;
        r0 = r0.mPackagesWithBindWidgetPermission;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = r0;
        r0 = r35;
        r1 = r19;
        r0.add(r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        goto L_0x0045;
    L_0x0238:
        r7 = move-exception;
        goto L_0x013c;
    L_0x023b:
        r35 = "g";
        r0 = r35;
        r1 = r29;
        r35 = r0.equals(r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r35 == 0) goto L_0x0045;
    L_0x0247:
        r34 = new com.android.server.appwidget.AppWidgetServiceImpl$Widget;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r34.<init>();	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r36 = "id";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r35 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r36 = 16;
        r35 = java.lang.Integer.parseInt(r35, r36);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r35;
        r1 = r34;
        r1.appWidgetId = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r34;
        r0 = r0.appWidgetId;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = r0;
        r35 = r35 + 1;
        r0 = r38;
        r1 = r40;
        r2 = r35;
        r0.setMinAppWidgetIdLocked(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r36 = "rid";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r28 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r28 != 0) goto L_0x039c;
    L_0x0289:
        r35 = 0;
    L_0x028b:
        r0 = r35;
        r1 = r34;
        r1.restoredId = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r18 = new android.os.Bundle;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r18.<init>();	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r36 = "min_width";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r17 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r17 == 0) goto L_0x02bb;
    L_0x02a6:
        r35 = "appWidgetMinWidth";
        r36 = 16;
        r0 = r17;
        r1 = r36;
        r36 = java.lang.Integer.parseInt(r0, r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r18;
        r1 = r35;
        r2 = r36;
        r0.putInt(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x02bb:
        r35 = 0;
        r36 = "min_height";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r16 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r16 == 0) goto L_0x02e0;
    L_0x02cb:
        r35 = "appWidgetMinHeight";
        r36 = 16;
        r0 = r16;
        r1 = r36;
        r36 = java.lang.Integer.parseInt(r0, r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r18;
        r1 = r35;
        r2 = r36;
        r0.putInt(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x02e0:
        r35 = 0;
        r36 = "max_width";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r15 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r15 == 0) goto L_0x0303;
    L_0x02f0:
        r35 = "appWidgetMaxWidth";
        r36 = 16;
        r0 = r36;
        r36 = java.lang.Integer.parseInt(r15, r0);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r18;
        r1 = r35;
        r2 = r36;
        r0.putInt(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x0303:
        r35 = 0;
        r36 = "max_height";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r14 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r14 == 0) goto L_0x0326;
    L_0x0313:
        r35 = "appWidgetMaxHeight";
        r36 = 16;
        r0 = r36;
        r36 = java.lang.Integer.parseInt(r14, r0);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r18;
        r1 = r35;
        r2 = r36;
        r0.putInt(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x0326:
        r35 = 0;
        r36 = "host_category";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r4 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r4 == 0) goto L_0x0349;
    L_0x0336:
        r35 = "appWidgetCategory";
        r36 = 16;
        r0 = r36;
        r36 = java.lang.Integer.parseInt(r4, r0);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r18;
        r1 = r35;
        r2 = r36;
        r0.putInt(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x0349:
        r0 = r18;
        r1 = r34;
        r1.options = r0;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r36 = "h";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r35 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r36 = 16;
        r10 = java.lang.Integer.parseInt(r35, r36);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r35 = 0;
        r36 = "p";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r26 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        if (r26 == 0) goto L_0x03a8;
    L_0x0373:
        r35 = 0;
        r36 = "p";
        r0 = r21;
        r1 = r35;
        r2 = r36;
        r35 = r0.getAttributeValue(r1, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r36 = 16;
        r27 = java.lang.Integer.parseInt(r35, r36);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
    L_0x0387:
        r13 = new com.android.server.appwidget.AppWidgetServiceImpl$LoadedWidgetState;	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r38;
        r1 = r34;
        r2 = r27;
        r13.<init>(r1, r10, r2);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        r0 = r41;
        r0.add(r13);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        goto L_0x0045;
    L_0x0399:
        r7 = move-exception;
        goto L_0x013c;
    L_0x039c:
        r35 = 16;
        r0 = r28;
        r1 = r35;
        r35 = java.lang.Integer.parseInt(r0, r1);	 Catch:{ NullPointerException -> 0x013b, NumberFormatException -> 0x01f2, XmlPullParserException -> 0x0238, IOException -> 0x0399, IndexOutOfBoundsException -> 0x03ab }
        goto L_0x028b;
    L_0x03a8:
        r27 = -1;
        goto L_0x0387;
    L_0x03ab:
        r7 = move-exception;
        goto L_0x013c;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.appwidget.AppWidgetServiceImpl.readProfileStateFromFileLocked(java.io.FileInputStream, int, java.util.List):int");
    }

    private void performUpgradeLocked(int fromVersion) {
        if (fromVersion < CURRENT_VERSION) {
            Slog.v(TAG, "Upgrading widget database from " + fromVersion + " to " + CURRENT_VERSION);
        }
        int version = fromVersion;
        if (version == 0) {
            Host host = lookupHostLocked(new HostId(Process.myUid(), KEYGUARD_HOST_ID, OLD_KEYGUARD_HOST_PACKAGE));
            if (host != null) {
                int uid = getUidForPackage(NEW_KEYGUARD_HOST_PACKAGE, MIN_UPDATE_PERIOD);
                if (uid >= 0) {
                    host.id = new HostId(uid, KEYGUARD_HOST_ID, NEW_KEYGUARD_HOST_PACKAGE);
                }
            }
            version = CURRENT_VERSION;
        }
        if (version != CURRENT_VERSION) {
            throw new IllegalStateException("Failed to upgrade widget database");
        }
    }

    private static File getStateFile(int userId) {
        return new File(Environment.getUserSystemDirectory(userId), STATE_FILENAME);
    }

    private static AtomicFile getSavedStateFile(int userId) {
        File dir = Environment.getUserSystemDirectory(userId);
        File settingsFile = getStateFile(userId);
        if (!settingsFile.exists() && userId == 0) {
            if (!dir.exists()) {
                dir.mkdirs();
            }
            new File("/data/system/appwidgets.xml").renameTo(settingsFile);
        }
        return new AtomicFile(settingsFile);
    }

    private void onUserStopped(int userId) {
        synchronized (this.mLock) {
            int i;
            boolean providersChanged = false;
            boolean crossProfileWidgetsChanged = false;
            for (i = this.mWidgets.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
                boolean providerInUser;
                Widget widget = (Widget) this.mWidgets.get(i);
                boolean hostInUser = widget.host.getUserId() == userId;
                boolean hasProvider = widget.provider != null;
                if (hasProvider) {
                    if (widget.provider.getUserId() == userId) {
                        providerInUser = true;
                        if (hostInUser && (!hasProvider || providerInUser)) {
                            this.mWidgets.remove(i);
                            widget.host.widgets.remove(widget);
                            widget.host = null;
                            if (hasProvider) {
                                widget.provider.widgets.remove(widget);
                                widget.provider = null;
                            }
                        }
                    }
                }
                providerInUser = false;
                this.mWidgets.remove(i);
                widget.host.widgets.remove(widget);
                widget.host = null;
                if (hasProvider) {
                    widget.provider.widgets.remove(widget);
                    widget.provider = null;
                }
            }
            for (i = this.mHosts.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
                Host host = (Host) this.mHosts.get(i);
                if (host.getUserId() == userId) {
                    crossProfileWidgetsChanged |= !host.widgets.isEmpty() ? CURRENT_VERSION : MIN_UPDATE_PERIOD;
                    deleteHostLocked(host);
                }
            }
            for (i = this.mProviders.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
                Provider provider = (Provider) this.mProviders.get(i);
                if (provider.getUserId() == userId) {
                    crossProfileWidgetsChanged |= !provider.widgets.isEmpty() ? CURRENT_VERSION : MIN_UPDATE_PERIOD;
                    providersChanged = true;
                    deleteProviderLocked(provider);
                }
            }
            for (i = this.mPackagesWithBindWidgetPermission.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
                if (((Integer) ((Pair) this.mPackagesWithBindWidgetPermission.valueAt(i)).first).intValue() == userId) {
                    this.mPackagesWithBindWidgetPermission.removeAt(i);
                }
            }
            int userIndex = this.mLoadedUserIds.indexOfKey(userId);
            if (userIndex >= 0) {
                this.mLoadedUserIds.removeAt(userIndex);
            }
            int nextIdIndex = this.mNextAppWidgetIds.indexOfKey(userId);
            if (nextIdIndex >= 0) {
                this.mNextAppWidgetIds.removeAt(nextIdIndex);
            }
            if (providersChanged) {
                scheduleNotifyGroupHostsForProvidersChangedLocked(userId);
            }
            if (crossProfileWidgetsChanged) {
                saveGroupStateAsync(userId);
            }
        }
    }

    private boolean updateProvidersForPackageLocked(String packageName, int userId, Set<ProviderId> removedProviders) {
        int i;
        Provider provider;
        boolean providersUpdated = false;
        HashSet<ProviderId> keep = new HashSet();
        Intent intent = new Intent("android.appwidget.action.APPWIDGET_UPDATE");
        intent.setPackage(packageName);
        List<ResolveInfo> broadcastReceivers = queryIntentReceivers(intent, userId);
        int N = broadcastReceivers == null ? MIN_UPDATE_PERIOD : broadcastReceivers.size();
        for (i = MIN_UPDATE_PERIOD; i < N; i += CURRENT_VERSION) {
            ResolveInfo ri = (ResolveInfo) broadcastReceivers.get(i);
            ActivityInfo ai = ri.activityInfo;
            if ((ai.applicationInfo.flags & 262144) == 0) {
                if (packageName.equals(ai.packageName)) {
                    ProviderId providerId = new ProviderId(new ComponentName(ai.packageName, ai.name), null);
                    provider = lookupProviderLocked(providerId);
                    if (provider != null) {
                        Provider parsed = parseProviderInfoXml(providerId, ri);
                        if (parsed != null) {
                            keep.add(providerId);
                            provider.info = parsed.info;
                            int M = provider.widgets.size();
                            if (M > 0) {
                                int[] appWidgetIds = getWidgetIds(provider.widgets);
                                cancelBroadcasts(provider);
                                registerForBroadcastsLocked(provider, appWidgetIds);
                                for (int j = MIN_UPDATE_PERIOD; j < M; j += CURRENT_VERSION) {
                                    Widget widget = (Widget) provider.widgets.get(j);
                                    widget.views = null;
                                    scheduleNotifyProviderChangedLocked(widget);
                                }
                                sendUpdateIntentLocked(provider, appWidgetIds);
                                providersUpdated = true;
                            }
                        }
                    } else if (addProviderLocked(ri)) {
                        keep.add(providerId);
                        providersUpdated = true;
                    }
                }
            }
        }
        for (i = this.mProviders.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
            provider = (Provider) this.mProviders.get(i);
            if (packageName.equals(provider.info.provider.getPackageName()) && provider.getUserId() == userId) {
                if (!keep.contains(provider.id)) {
                    if (removedProviders != null) {
                        removedProviders.add(provider.id);
                    }
                    deleteProviderLocked(provider);
                    providersUpdated = true;
                }
            }
        }
        return providersUpdated;
    }

    private boolean removeHostsAndProvidersForPackageLocked(String pkgName, int userId) {
        int i;
        boolean removed = false;
        for (i = this.mProviders.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
            Provider provider = (Provider) this.mProviders.get(i);
            if (pkgName.equals(provider.info.provider.getPackageName()) && provider.getUserId() == userId) {
                deleteProviderLocked(provider);
                removed = true;
            }
        }
        for (i = this.mHosts.size() + UNKNOWN_UID; i >= 0; i += UNKNOWN_UID) {
            Host host = (Host) this.mHosts.get(i);
            if (pkgName.equals(host.id.packageName) && host.getUserId() == userId) {
                deleteHostLocked(host);
                removed = true;
            }
        }
        return removed;
    }

    private String getCanonicalPackageName(String packageName, String className, int userId) {
        long identity = Binder.clearCallingIdentity();
        try {
            AppGlobals.getPackageManager().getReceiverInfo(new ComponentName(packageName, className), MIN_UPDATE_PERIOD, userId);
        } catch (RemoteException e) {
            PackageManager packageManager = this.mContext.getPackageManager();
            String[] strArr = new String[CURRENT_VERSION];
            strArr[MIN_UPDATE_PERIOD] = packageName;
            String[] packageNames = packageManager.currentToCanonicalPackageNames(strArr);
            if (packageNames == null || packageNames.length <= 0) {
                Binder.restoreCallingIdentity(identity);
                return null;
            }
            packageName = packageNames[MIN_UPDATE_PERIOD];
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
        return packageName;
    }

    private void sendBroadcastAsUser(Intent intent, UserHandle userHandle) {
        long identity = Binder.clearCallingIdentity();
        try {
            this.mContext.sendBroadcastAsUser(intent, userHandle);
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
    }

    private void bindService(Intent intent, ServiceConnection connection, UserHandle userHandle) {
        long token = Binder.clearCallingIdentity();
        try {
            this.mContext.bindServiceAsUser(intent, connection, CURRENT_VERSION, userHandle);
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    private void unbindService(ServiceConnection connection) {
        long token = Binder.clearCallingIdentity();
        try {
            this.mContext.unbindService(connection);
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public void onCrossProfileWidgetProvidersChanged(int userId, List<String> packages) {
        if (this.mSecurityPolicy.getProfileParent(userId) != userId) {
            synchronized (this.mLock) {
                boolean providersChanged = false;
                int packageCount = packages.size();
                for (int i = MIN_UPDATE_PERIOD; i < packageCount; i += CURRENT_VERSION) {
                    providersChanged |= updateProvidersForPackageLocked((String) packages.get(i), userId, null);
                }
                if (providersChanged) {
                    saveGroupStateAsync(userId);
                    scheduleNotifyGroupHostsForProvidersChangedLocked(userId);
                }
            }
        }
    }
}
