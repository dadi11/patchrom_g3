package com.android.server;

import android.app.ActivityManagerNative;
import android.app.IUserSwitchObserver;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.pm.UserInfo;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.IRemoteCallback;
import android.os.RemoteException;
import android.os.UserHandle;
import android.os.UserManager;
import android.provider.Settings.Secure;
import android.text.TextUtils;
import android.util.Slog;
import android.view.inputmethod.InputMethodManager;
import android.view.inputmethod.InputMethodSubtype;
import android.view.textservice.SpellCheckerInfo;
import android.view.textservice.SpellCheckerSubtype;
import com.android.internal.annotations.GuardedBy;
import com.android.internal.content.PackageMonitor;
import com.android.internal.textservice.ISpellCheckerService;
import com.android.internal.textservice.ISpellCheckerSession;
import com.android.internal.textservice.ISpellCheckerSessionListener;
import com.android.internal.textservice.ITextServicesManager.Stub;
import com.android.internal.textservice.ITextServicesSessionListener;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.concurrent.CopyOnWriteArrayList;
import org.xmlpull.v1.XmlPullParserException;

public class TextServicesManagerService extends Stub {
    private static final boolean DBG = false;
    private static final String TAG;
    private final Context mContext;
    private final TextServicesMonitor mMonitor;
    private final TextServicesSettings mSettings;
    private final HashMap<String, SpellCheckerBindGroup> mSpellCheckerBindGroups;
    private final ArrayList<SpellCheckerInfo> mSpellCheckerList;
    private final HashMap<String, SpellCheckerInfo> mSpellCheckerMap;
    private boolean mSystemReady;

    /* renamed from: com.android.server.TextServicesManagerService.1 */
    class C00851 extends IUserSwitchObserver.Stub {
        C00851() {
        }

        public void onUserSwitching(int newUserId, IRemoteCallback reply) {
            synchronized (TextServicesManagerService.this.mSpellCheckerMap) {
                TextServicesManagerService.this.switchUserLocked(newUserId);
            }
            if (reply != null) {
                try {
                    reply.sendResult(null);
                } catch (RemoteException e) {
                }
            }
        }

        public void onUserSwitchComplete(int newUserId) throws RemoteException {
        }
    }

    private class InternalDeathRecipient implements DeathRecipient {
        public final Bundle mBundle;
        private final SpellCheckerBindGroup mGroup;
        public final ISpellCheckerSessionListener mScListener;
        public final String mScLocale;
        public final ITextServicesSessionListener mTsListener;
        public final int mUid;

        public InternalDeathRecipient(SpellCheckerBindGroup group, ITextServicesSessionListener tsListener, String scLocale, ISpellCheckerSessionListener scListener, int uid, Bundle bundle) {
            this.mTsListener = tsListener;
            this.mScListener = scListener;
            this.mScLocale = scLocale;
            this.mGroup = group;
            this.mUid = uid;
            this.mBundle = bundle;
        }

        public boolean hasSpellCheckerListener(ISpellCheckerSessionListener listener) {
            return listener.asBinder().equals(this.mScListener.asBinder());
        }

        public void binderDied() {
            this.mGroup.removeListener(this.mScListener);
        }
    }

    private class InternalServiceConnection implements ServiceConnection {
        private final Bundle mBundle;
        private final String mLocale;
        private final String mSciId;

        public InternalServiceConnection(String id, String locale, Bundle bundle) {
            this.mSciId = id;
            this.mLocale = locale;
            this.mBundle = bundle;
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            synchronized (TextServicesManagerService.this.mSpellCheckerMap) {
                onServiceConnectedInnerLocked(name, service);
            }
        }

        private void onServiceConnectedInnerLocked(ComponentName name, IBinder service) {
            ISpellCheckerService spellChecker = ISpellCheckerService.Stub.asInterface(service);
            SpellCheckerBindGroup group = (SpellCheckerBindGroup) TextServicesManagerService.this.mSpellCheckerBindGroups.get(this.mSciId);
            if (group != null && this == group.mInternalConnection) {
                group.onServiceConnected(spellChecker);
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            synchronized (TextServicesManagerService.this.mSpellCheckerMap) {
                SpellCheckerBindGroup group = (SpellCheckerBindGroup) TextServicesManagerService.this.mSpellCheckerBindGroups.get(this.mSciId);
                if (group != null && this == group.mInternalConnection) {
                    TextServicesManagerService.this.mSpellCheckerBindGroups.remove(this.mSciId);
                }
            }
        }
    }

    private class SpellCheckerBindGroup {
        private final String TAG;
        public boolean mBound;
        public boolean mConnected;
        private final InternalServiceConnection mInternalConnection;
        private final CopyOnWriteArrayList<InternalDeathRecipient> mListeners;
        public ISpellCheckerService mSpellChecker;

        public SpellCheckerBindGroup(InternalServiceConnection connection, ITextServicesSessionListener listener, String locale, ISpellCheckerSessionListener scListener, int uid, Bundle bundle) {
            this.TAG = SpellCheckerBindGroup.class.getSimpleName();
            this.mListeners = new CopyOnWriteArrayList();
            this.mInternalConnection = connection;
            this.mBound = true;
            this.mConnected = false;
            addListener(listener, locale, scListener, uid, bundle);
        }

        public void onServiceConnected(ISpellCheckerService spellChecker) {
            Iterator i$ = this.mListeners.iterator();
            while (i$.hasNext()) {
                InternalDeathRecipient listener = (InternalDeathRecipient) i$.next();
                try {
                    ISpellCheckerSession session = spellChecker.getISpellCheckerSession(listener.mScLocale, listener.mScListener, listener.mBundle);
                    synchronized (TextServicesManagerService.this.mSpellCheckerMap) {
                        if (this.mListeners.contains(listener)) {
                            listener.mTsListener.onServiceConnected(session);
                        }
                    }
                } catch (RemoteException e) {
                    Slog.e(this.TAG, "Exception in getting the spell checker session.Reconnect to the spellchecker. ", e);
                    removeAll();
                    return;
                }
            }
            synchronized (TextServicesManagerService.this.mSpellCheckerMap) {
                this.mSpellChecker = spellChecker;
                this.mConnected = true;
            }
        }

        public com.android.server.TextServicesManagerService.InternalDeathRecipient addListener(com.android.internal.textservice.ITextServicesSessionListener r13, java.lang.String r14, com.android.internal.textservice.ISpellCheckerSessionListener r15, int r16, android.os.Bundle r17) {
            /* JADX: method processing error */
/*
            Error: jadx.core.utils.exceptions.JadxRuntimeException: Exception block dominator not found, method:com.android.server.TextServicesManagerService.SpellCheckerBindGroup.addListener(com.android.internal.textservice.ITextServicesSessionListener, java.lang.String, com.android.internal.textservice.ISpellCheckerSessionListener, int, android.os.Bundle):com.android.server.TextServicesManagerService$InternalDeathRecipient. bs: [B:9:0x0020, B:17:0x0043]
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.searchTryCatchDominators(ProcessTryCatchRegions.java:86)
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.process(ProcessTryCatchRegions.java:45)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.postProcessRegions(RegionMakerVisitor.java:57)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:52)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:14)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
            /*
            r12 = this;
            r9 = 0;
            r1 = com.android.server.TextServicesManagerService.this;
            r11 = r1.mSpellCheckerMap;
            monitor-enter(r11);
            r1 = r12.mListeners;	 Catch:{ RemoteException -> 0x004f }
            r10 = r1.size();	 Catch:{ RemoteException -> 0x004f }
            r8 = 0;	 Catch:{ RemoteException -> 0x004f }
        L_0x000f:
            if (r8 >= r10) goto L_0x0027;	 Catch:{ RemoteException -> 0x004f }
        L_0x0011:
            r1 = r12.mListeners;	 Catch:{ RemoteException -> 0x004f }
            r1 = r1.get(r8);	 Catch:{ RemoteException -> 0x004f }
            r1 = (com.android.server.TextServicesManagerService.InternalDeathRecipient) r1;	 Catch:{ RemoteException -> 0x004f }
            r1 = r1.hasSpellCheckerListener(r15);	 Catch:{ RemoteException -> 0x004f }
            if (r1 == 0) goto L_0x0024;
        L_0x001f:
            r0 = 0;
            monitor-exit(r11);	 Catch:{ all -> 0x0049 }
            r1 = r0;
            r0 = r9;
        L_0x0023:
            return r1;
        L_0x0024:
            r8 = r8 + 1;
            goto L_0x000f;
        L_0x0027:
            r0 = new com.android.server.TextServicesManagerService$InternalDeathRecipient;	 Catch:{ RemoteException -> 0x004f }
            r1 = com.android.server.TextServicesManagerService.this;	 Catch:{ RemoteException -> 0x004f }
            r2 = r12;	 Catch:{ RemoteException -> 0x004f }
            r3 = r13;	 Catch:{ RemoteException -> 0x004f }
            r4 = r14;	 Catch:{ RemoteException -> 0x004f }
            r5 = r15;	 Catch:{ RemoteException -> 0x004f }
            r6 = r16;	 Catch:{ RemoteException -> 0x004f }
            r7 = r17;	 Catch:{ RemoteException -> 0x004f }
            r0.<init>(r2, r3, r4, r5, r6, r7);	 Catch:{ RemoteException -> 0x004f }
            r1 = r15.asBinder();	 Catch:{ RemoteException -> 0x0052 }
            r2 = 0;	 Catch:{ RemoteException -> 0x0052 }
            r1.linkToDeath(r0, r2);	 Catch:{ RemoteException -> 0x0052 }
            r1 = r12.mListeners;	 Catch:{ RemoteException -> 0x0052 }
            r1.add(r0);	 Catch:{ RemoteException -> 0x0052 }
        L_0x0043:
            r12.cleanLocked();	 Catch:{ all -> 0x004d }
            monitor-exit(r11);	 Catch:{ all -> 0x004d }
            r1 = r0;	 Catch:{ all -> 0x004d }
            goto L_0x0023;	 Catch:{ all -> 0x004d }
        L_0x0049:
            r1 = move-exception;	 Catch:{ all -> 0x004d }
            r0 = r9;	 Catch:{ all -> 0x004d }
        L_0x004b:
            monitor-exit(r11);	 Catch:{ all -> 0x004d }
            throw r1;
        L_0x004d:
            r1 = move-exception;
            goto L_0x004b;
        L_0x004f:
            r1 = move-exception;
            r0 = r9;
            goto L_0x0043;
        L_0x0052:
            r1 = move-exception;
            goto L_0x0043;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.TextServicesManagerService.SpellCheckerBindGroup.addListener(com.android.internal.textservice.ITextServicesSessionListener, java.lang.String, com.android.internal.textservice.ISpellCheckerSessionListener, int, android.os.Bundle):com.android.server.TextServicesManagerService$InternalDeathRecipient");
        }

        public void removeListener(ISpellCheckerSessionListener listener) {
            synchronized (TextServicesManagerService.this.mSpellCheckerMap) {
                int i;
                int size = this.mListeners.size();
                ArrayList<InternalDeathRecipient> removeList = new ArrayList();
                for (i = 0; i < size; i++) {
                    InternalDeathRecipient tempRecipient = (InternalDeathRecipient) this.mListeners.get(i);
                    if (tempRecipient.hasSpellCheckerListener(listener)) {
                        removeList.add(tempRecipient);
                    }
                }
                int removeSize = removeList.size();
                for (i = 0; i < removeSize; i++) {
                    InternalDeathRecipient idr = (InternalDeathRecipient) removeList.get(i);
                    idr.mScListener.asBinder().unlinkToDeath(idr, 0);
                    this.mListeners.remove(idr);
                }
                cleanLocked();
            }
        }

        private void cleanLocked() {
            if (this.mBound && this.mListeners.isEmpty()) {
                this.mBound = false;
                String sciId = this.mInternalConnection.mSciId;
                if (((SpellCheckerBindGroup) TextServicesManagerService.this.mSpellCheckerBindGroups.get(sciId)) == this) {
                    TextServicesManagerService.this.mSpellCheckerBindGroups.remove(sciId);
                }
                TextServicesManagerService.this.mContext.unbindService(this.mInternalConnection);
            }
        }

        public void removeAll() {
            Slog.e(this.TAG, "Remove the spell checker bind unexpectedly.");
            synchronized (TextServicesManagerService.this.mSpellCheckerMap) {
                int size = this.mListeners.size();
                for (int i = 0; i < size; i++) {
                    InternalDeathRecipient idr = (InternalDeathRecipient) this.mListeners.get(i);
                    idr.mScListener.asBinder().unlinkToDeath(idr, 0);
                }
                this.mListeners.clear();
                cleanLocked();
            }
        }
    }

    class TextServicesBroadcastReceiver extends BroadcastReceiver {
        TextServicesBroadcastReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if ("android.intent.action.USER_ADDED".equals(action) || "android.intent.action.USER_REMOVED".equals(action)) {
                TextServicesManagerService.this.updateCurrentProfileIds();
            } else {
                Slog.w(TextServicesManagerService.TAG, "Unexpected intent " + intent);
            }
        }
    }

    private class TextServicesMonitor extends PackageMonitor {
        private TextServicesMonitor() {
        }

        private boolean isChangingPackagesOfCurrentUser() {
            return getChangingUserId() == TextServicesManagerService.this.mSettings.getCurrentUserId();
        }

        public void onSomePackagesChanged() {
            if (isChangingPackagesOfCurrentUser()) {
                synchronized (TextServicesManagerService.this.mSpellCheckerMap) {
                    TextServicesManagerService.buildSpellCheckerMapLocked(TextServicesManagerService.this.mContext, TextServicesManagerService.this.mSpellCheckerList, TextServicesManagerService.this.mSpellCheckerMap, TextServicesManagerService.this.mSettings);
                    SpellCheckerInfo sci = TextServicesManagerService.this.getCurrentSpellChecker(null);
                    if (sci == null) {
                        return;
                    }
                    String packageName = sci.getPackageName();
                    int change = isPackageDisappearing(packageName);
                    if (change == 3 || change == 2 || isPackageModified(packageName)) {
                        sci = TextServicesManagerService.this.findAvailSpellCheckerLocked(null, packageName);
                        if (sci != null) {
                            TextServicesManagerService.this.setCurrentSpellCheckerLocked(sci.getId());
                        }
                    }
                }
            }
        }
    }

    private static class TextServicesSettings {
        @GuardedBy("mLock")
        private int[] mCurrentProfileIds;
        private int mCurrentUserId;
        private Object mLock;
        private final ContentResolver mResolver;

        public TextServicesSettings(ContentResolver resolver, int userId) {
            this.mCurrentProfileIds = new int[0];
            this.mLock = new Object();
            this.mResolver = resolver;
            this.mCurrentUserId = userId;
        }

        public void setCurrentUserId(int userId) {
            this.mCurrentUserId = userId;
        }

        public void setCurrentProfileIds(int[] currentProfileIds) {
            synchronized (this.mLock) {
                this.mCurrentProfileIds = currentProfileIds;
            }
        }

        public boolean isCurrentProfile(int userId) {
            boolean z = true;
            synchronized (this.mLock) {
                if (userId == this.mCurrentUserId) {
                } else {
                    for (int i : this.mCurrentProfileIds) {
                        if (userId == i) {
                            break;
                        }
                    }
                    z = false;
                }
            }
            return z;
        }

        public int getCurrentUserId() {
            return this.mCurrentUserId;
        }

        public void putSelectedSpellChecker(String sciId) {
            Secure.putStringForUser(this.mResolver, "selected_spell_checker", sciId, this.mCurrentUserId);
        }

        public void putSelectedSpellCheckerSubtype(int hashCode) {
            Secure.putStringForUser(this.mResolver, "selected_spell_checker_subtype", String.valueOf(hashCode), this.mCurrentUserId);
        }

        public void setSpellCheckerEnabled(boolean enabled) {
            Secure.putIntForUser(this.mResolver, "spell_checker_enabled", enabled ? 1 : 0, this.mCurrentUserId);
        }

        public String getSelectedSpellChecker() {
            return Secure.getStringForUser(this.mResolver, "selected_spell_checker", this.mCurrentUserId);
        }

        public String getSelectedSpellCheckerSubtype() {
            return Secure.getStringForUser(this.mResolver, "selected_spell_checker_subtype", this.mCurrentUserId);
        }

        public boolean isSpellCheckerEnabled() {
            return Secure.getIntForUser(this.mResolver, "spell_checker_enabled", 1, this.mCurrentUserId) == 1;
        }
    }

    static {
        TAG = TextServicesManagerService.class.getSimpleName();
    }

    public void systemRunning() {
        if (!this.mSystemReady) {
            this.mSystemReady = true;
        }
    }

    public TextServicesManagerService(Context context) {
        this.mSpellCheckerMap = new HashMap();
        this.mSpellCheckerList = new ArrayList();
        this.mSpellCheckerBindGroups = new HashMap();
        this.mSystemReady = false;
        this.mContext = context;
        IntentFilter broadcastFilter = new IntentFilter();
        broadcastFilter.addAction("android.intent.action.USER_ADDED");
        broadcastFilter.addAction("android.intent.action.USER_REMOVED");
        this.mContext.registerReceiver(new TextServicesBroadcastReceiver(), broadcastFilter);
        int userId = 0;
        try {
            ActivityManagerNative.getDefault().registerUserSwitchObserver(new C00851());
            userId = ActivityManagerNative.getDefault().getCurrentUser().id;
        } catch (RemoteException e) {
            Slog.w(TAG, "Couldn't get current user ID; guessing it's 0", e);
        }
        this.mMonitor = new TextServicesMonitor();
        this.mMonitor.register(context, null, true);
        this.mSettings = new TextServicesSettings(context.getContentResolver(), userId);
        switchUserLocked(userId);
    }

    private void switchUserLocked(int userId) {
        this.mSettings.setCurrentUserId(userId);
        updateCurrentProfileIds();
        unbindServiceLocked();
        buildSpellCheckerMapLocked(this.mContext, this.mSpellCheckerList, this.mSpellCheckerMap, this.mSettings);
        if (getCurrentSpellChecker(null) == null) {
            SpellCheckerInfo sci = findAvailSpellCheckerLocked(null, null);
            if (sci != null) {
                setCurrentSpellCheckerLocked(sci.getId());
            }
        }
    }

    void updateCurrentProfileIds() {
        List<UserInfo> profiles = UserManager.get(this.mContext).getProfiles(this.mSettings.getCurrentUserId());
        int[] currentProfileIds = new int[profiles.size()];
        for (int i = 0; i < currentProfileIds.length; i++) {
            currentProfileIds[i] = ((UserInfo) profiles.get(i)).id;
        }
        this.mSettings.setCurrentProfileIds(currentProfileIds);
    }

    private static void buildSpellCheckerMapLocked(Context context, ArrayList<SpellCheckerInfo> list, HashMap<String, SpellCheckerInfo> map, TextServicesSettings settings) {
        list.clear();
        map.clear();
        List<ResolveInfo> services = context.getPackageManager().queryIntentServicesAsUser(new Intent("android.service.textservice.SpellCheckerService"), DumpState.DUMP_PROVIDERS, settings.getCurrentUserId());
        int N = services.size();
        for (int i = 0; i < N; i++) {
            ResolveInfo ri = (ResolveInfo) services.get(i);
            ServiceInfo si = ri.serviceInfo;
            ComponentName compName = new ComponentName(si.packageName, si.name);
            if ("android.permission.BIND_TEXT_SERVICE".equals(si.permission)) {
                try {
                    SpellCheckerInfo sci = new SpellCheckerInfo(context, ri);
                    if (sci.getSubtypeCount() <= 0) {
                        Slog.w(TAG, "Skipping text service " + compName + ": it does not contain subtypes.");
                    } else {
                        list.add(sci);
                        map.put(sci.getId(), sci);
                    }
                } catch (XmlPullParserException e) {
                    Slog.w(TAG, "Unable to load the spell checker " + compName, e);
                } catch (IOException e2) {
                    Slog.w(TAG, "Unable to load the spell checker " + compName, e2);
                }
            } else {
                Slog.w(TAG, "Skipping text service " + compName + ": it does not require the permission " + "android.permission.BIND_TEXT_SERVICE");
            }
        }
    }

    private boolean calledFromValidUser() {
        int uid = Binder.getCallingUid();
        int userId = UserHandle.getUserId(uid);
        if (uid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || userId == this.mSettings.getCurrentUserId()) {
            return true;
        }
        boolean isCurrentProfile = this.mSettings.isCurrentProfile(userId);
        if (this.mSettings.isCurrentProfile(userId)) {
            SpellCheckerInfo spellCheckerInfo = getCurrentSpellCheckerWithoutVerification();
            if (spellCheckerInfo != null) {
                boolean isSystemSpellChecker;
                if ((spellCheckerInfo.getServiceInfo().applicationInfo.flags & 1) != 0) {
                    isSystemSpellChecker = true;
                } else {
                    isSystemSpellChecker = false;
                }
                if (isSystemSpellChecker) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean bindCurrentSpellCheckerService(Intent service, ServiceConnection conn, int flags) {
        if (service != null && conn != null) {
            return this.mContext.bindServiceAsUser(service, conn, flags, new UserHandle(this.mSettings.getCurrentUserId()));
        }
        Slog.e(TAG, "--- bind failed: service = " + service + ", conn = " + conn);
        return false;
    }

    private void unbindServiceLocked() {
        for (SpellCheckerBindGroup scbg : this.mSpellCheckerBindGroups.values()) {
            scbg.removeAll();
        }
        this.mSpellCheckerBindGroups.clear();
    }

    private SpellCheckerInfo findAvailSpellCheckerLocked(String locale, String prefPackage) {
        int spellCheckersCount = this.mSpellCheckerList.size();
        if (spellCheckersCount == 0) {
            Slog.w(TAG, "no available spell checker services found");
            return null;
        }
        if (prefPackage != null) {
            for (int i = 0; i < spellCheckersCount; i++) {
                SpellCheckerInfo sci = (SpellCheckerInfo) this.mSpellCheckerList.get(i);
                if (prefPackage.equals(sci.getPackageName())) {
                    return sci;
                }
            }
        }
        if (spellCheckersCount > 1) {
            Slog.w(TAG, "more than one spell checker service found, picking first");
        }
        return (SpellCheckerInfo) this.mSpellCheckerList.get(0);
    }

    public SpellCheckerInfo getCurrentSpellChecker(String locale) {
        if (calledFromValidUser()) {
            return getCurrentSpellCheckerWithoutVerification();
        }
        return null;
    }

    private SpellCheckerInfo getCurrentSpellCheckerWithoutVerification() {
        SpellCheckerInfo spellCheckerInfo;
        synchronized (this.mSpellCheckerMap) {
            String curSpellCheckerId = this.mSettings.getSelectedSpellChecker();
            if (TextUtils.isEmpty(curSpellCheckerId)) {
                spellCheckerInfo = null;
            } else {
                spellCheckerInfo = (SpellCheckerInfo) this.mSpellCheckerMap.get(curSpellCheckerId);
            }
        }
        return spellCheckerInfo;
    }

    public SpellCheckerSubtype getCurrentSpellCheckerSubtype(String locale, boolean allowImplicitlySelectedSubtype) {
        if (!calledFromValidUser()) {
            return null;
        }
        synchronized (this.mSpellCheckerMap) {
            String subtypeHashCodeStr = this.mSettings.getSelectedSpellCheckerSubtype();
            SpellCheckerInfo sci = getCurrentSpellChecker(null);
            if (sci == null || sci.getSubtypeCount() == 0) {
                return null;
            }
            int hashCode;
            if (TextUtils.isEmpty(subtypeHashCodeStr)) {
                hashCode = 0;
            } else {
                hashCode = Integer.valueOf(subtypeHashCodeStr).intValue();
            }
            if (hashCode != 0 || allowImplicitlySelectedSubtype) {
                String candidateLocale = null;
                if (hashCode == 0) {
                    InputMethodManager imm = (InputMethodManager) this.mContext.getSystemService("input_method");
                    if (imm != null) {
                        InputMethodSubtype currentInputMethodSubtype = imm.getCurrentInputMethodSubtype();
                        if (currentInputMethodSubtype != null) {
                            String localeString = currentInputMethodSubtype.getLocale();
                            if (!TextUtils.isEmpty(localeString)) {
                                candidateLocale = localeString;
                            }
                        }
                    }
                    if (candidateLocale == null) {
                        candidateLocale = this.mContext.getResources().getConfiguration().locale.toString();
                    }
                }
                SpellCheckerSubtype candidate = null;
                for (int i = 0; i < sci.getSubtypeCount(); i++) {
                    SpellCheckerSubtype scs = sci.getSubtypeAt(i);
                    if (hashCode == 0) {
                        String scsLocale = scs.getLocale();
                        if (candidateLocale.equals(scsLocale)) {
                            return scs;
                        } else if (candidate == null && candidateLocale.length() >= 2 && scsLocale.length() >= 2 && candidateLocale.startsWith(scsLocale)) {
                            candidate = scs;
                        }
                    } else if (scs.hashCode() == hashCode) {
                        return scs;
                    }
                }
                return candidate;
            }
            return null;
        }
    }

    public void getSpellCheckerService(String sciId, String locale, ITextServicesSessionListener tsListener, ISpellCheckerSessionListener scListener, Bundle bundle) {
        if (!calledFromValidUser() || !this.mSystemReady) {
            return;
        }
        if (TextUtils.isEmpty(sciId) || tsListener == null || scListener == null) {
            Slog.e(TAG, "getSpellCheckerService: Invalid input.");
            return;
        }
        synchronized (this.mSpellCheckerMap) {
            if (this.mSpellCheckerMap.containsKey(sciId)) {
                SpellCheckerInfo sci = (SpellCheckerInfo) this.mSpellCheckerMap.get(sciId);
                int uid = Binder.getCallingUid();
                if (this.mSpellCheckerBindGroups.containsKey(sciId)) {
                    SpellCheckerBindGroup bindGroup = (SpellCheckerBindGroup) this.mSpellCheckerBindGroups.get(sciId);
                    if (bindGroup != null) {
                        InternalDeathRecipient recipient = ((SpellCheckerBindGroup) this.mSpellCheckerBindGroups.get(sciId)).addListener(tsListener, locale, scListener, uid, bundle);
                        if (recipient == null) {
                            return;
                        }
                        if (((bindGroup.mSpellChecker == null ? 1 : 0) & bindGroup.mConnected) != 0) {
                            Slog.e(TAG, "The state of the spell checker bind group is illegal.");
                            bindGroup.removeAll();
                        } else if (bindGroup.mSpellChecker != null) {
                            try {
                                ISpellCheckerSession session = bindGroup.mSpellChecker.getISpellCheckerSession(recipient.mScLocale, recipient.mScListener, bundle);
                                if (session != null) {
                                    tsListener.onServiceConnected(session);
                                    return;
                                }
                                bindGroup.removeAll();
                            } catch (RemoteException e) {
                                Slog.e(TAG, "Exception in getting spell checker session: " + e);
                                bindGroup.removeAll();
                            } catch (Throwable th) {
                                Binder.restoreCallingIdentity(ident);
                            }
                        }
                    }
                }
                long ident = Binder.clearCallingIdentity();
                startSpellCheckerServiceInnerLocked(sci, locale, tsListener, scListener, uid, bundle);
                Binder.restoreCallingIdentity(ident);
                return;
            }
        }
    }

    public boolean isSpellCheckerEnabled() {
        if (!calledFromValidUser()) {
            return false;
        }
        boolean isSpellCheckerEnabledLocked;
        synchronized (this.mSpellCheckerMap) {
            isSpellCheckerEnabledLocked = isSpellCheckerEnabledLocked();
        }
        return isSpellCheckerEnabledLocked;
    }

    private void startSpellCheckerServiceInnerLocked(SpellCheckerInfo info, String locale, ITextServicesSessionListener tsListener, ISpellCheckerSessionListener scListener, int uid, Bundle bundle) {
        String sciId = info.getId();
        InternalServiceConnection connection = new InternalServiceConnection(sciId, locale, bundle);
        Intent serviceIntent = new Intent("android.service.textservice.SpellCheckerService");
        serviceIntent.setComponent(info.getComponent());
        if (bindCurrentSpellCheckerService(serviceIntent, connection, 1)) {
            this.mSpellCheckerBindGroups.put(sciId, new SpellCheckerBindGroup(connection, tsListener, locale, scListener, uid, bundle));
            return;
        }
        Slog.e(TAG, "Failed to get a spell checker service.");
    }

    public SpellCheckerInfo[] getEnabledSpellCheckers() {
        if (calledFromValidUser()) {
            return (SpellCheckerInfo[]) this.mSpellCheckerList.toArray(new SpellCheckerInfo[this.mSpellCheckerList.size()]);
        }
        return null;
    }

    public void finishSpellCheckerService(ISpellCheckerSessionListener listener) {
        if (calledFromValidUser()) {
            synchronized (this.mSpellCheckerMap) {
                ArrayList<SpellCheckerBindGroup> removeList = new ArrayList();
                for (SpellCheckerBindGroup group : this.mSpellCheckerBindGroups.values()) {
                    if (group != null) {
                        removeList.add(group);
                    }
                }
                int removeSize = removeList.size();
                for (int i = 0; i < removeSize; i++) {
                    ((SpellCheckerBindGroup) removeList.get(i)).removeListener(listener);
                }
            }
        }
    }

    public void setCurrentSpellChecker(String locale, String sciId) {
        if (calledFromValidUser()) {
            synchronized (this.mSpellCheckerMap) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS") != 0) {
                    throw new SecurityException("Requires permission android.permission.WRITE_SECURE_SETTINGS");
                }
                setCurrentSpellCheckerLocked(sciId);
            }
        }
    }

    public void setCurrentSpellCheckerSubtype(String locale, int hashCode) {
        if (calledFromValidUser()) {
            synchronized (this.mSpellCheckerMap) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS") != 0) {
                    throw new SecurityException("Requires permission android.permission.WRITE_SECURE_SETTINGS");
                }
                setCurrentSpellCheckerSubtypeLocked(hashCode);
            }
        }
    }

    public void setSpellCheckerEnabled(boolean enabled) {
        if (calledFromValidUser()) {
            synchronized (this.mSpellCheckerMap) {
                if (this.mContext.checkCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS") != 0) {
                    throw new SecurityException("Requires permission android.permission.WRITE_SECURE_SETTINGS");
                }
                setSpellCheckerEnabledLocked(enabled);
            }
        }
    }

    private void setCurrentSpellCheckerLocked(String sciId) {
        if (!TextUtils.isEmpty(sciId) && this.mSpellCheckerMap.containsKey(sciId)) {
            SpellCheckerInfo currentSci = getCurrentSpellChecker(null);
            if (currentSci == null || !currentSci.getId().equals(sciId)) {
                long ident = Binder.clearCallingIdentity();
                try {
                    this.mSettings.putSelectedSpellChecker(sciId);
                    setCurrentSpellCheckerSubtypeLocked(0);
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            }
        }
    }

    private void setCurrentSpellCheckerSubtypeLocked(int hashCode) {
        SpellCheckerInfo sci = getCurrentSpellChecker(null);
        int tempHashCode = 0;
        int i = 0;
        while (sci != null && i < sci.getSubtypeCount()) {
            if (sci.getSubtypeAt(i).hashCode() == hashCode) {
                tempHashCode = hashCode;
                break;
            }
            i++;
        }
        long ident = Binder.clearCallingIdentity();
        try {
            this.mSettings.putSelectedSpellCheckerSubtype(tempHashCode);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private void setSpellCheckerEnabledLocked(boolean enabled) {
        long ident = Binder.clearCallingIdentity();
        try {
            this.mSettings.setSpellCheckerEnabled(enabled);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private boolean isSpellCheckerEnabledLocked() {
        long ident = Binder.clearCallingIdentity();
        try {
            boolean retval = this.mSettings.isSpellCheckerEnabled();
            return retval;
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump TextServicesManagerService from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            return;
        }
        synchronized (this.mSpellCheckerMap) {
            pw.println("Current Text Services Manager state:");
            pw.println("  Spell Checker Map:");
            for (Entry<String, SpellCheckerInfo> ent : this.mSpellCheckerMap.entrySet()) {
                int i;
                pw.print("    ");
                pw.print((String) ent.getKey());
                pw.println(":");
                SpellCheckerInfo info = (SpellCheckerInfo) ent.getValue();
                pw.print("      ");
                pw.print("id=");
                pw.println(info.getId());
                pw.print("      ");
                pw.print("comp=");
                pw.println(info.getComponent().toShortString());
                int NS = info.getSubtypeCount();
                for (i = 0; i < NS; i++) {
                    SpellCheckerSubtype st = info.getSubtypeAt(i);
                    pw.print("      ");
                    pw.print("Subtype #");
                    pw.print(i);
                    pw.println(":");
                    pw.print("        ");
                    pw.print("locale=");
                    pw.println(st.getLocale());
                    pw.print("        ");
                    pw.print("extraValue=");
                    pw.println(st.getExtraValue());
                }
            }
            pw.println("");
            pw.println("  Spell Checker Bind Groups:");
            for (Entry<String, SpellCheckerBindGroup> ent2 : this.mSpellCheckerBindGroups.entrySet()) {
                SpellCheckerBindGroup grp = (SpellCheckerBindGroup) ent2.getValue();
                pw.print("    ");
                pw.print((String) ent2.getKey());
                pw.print(" ");
                pw.print(grp);
                pw.println(":");
                pw.print("      ");
                pw.print("mInternalConnection=");
                pw.println(grp.mInternalConnection);
                pw.print("      ");
                pw.print("mSpellChecker=");
                pw.println(grp.mSpellChecker);
                pw.print("      ");
                pw.print("mBound=");
                pw.print(grp.mBound);
                pw.print(" mConnected=");
                pw.println(grp.mConnected);
                int NL = grp.mListeners.size();
                for (i = 0; i < NL; i++) {
                    InternalDeathRecipient listener = (InternalDeathRecipient) grp.mListeners.get(i);
                    pw.print("      ");
                    pw.print("Listener #");
                    pw.print(i);
                    pw.println(":");
                    pw.print("        ");
                    pw.print("mTsListener=");
                    pw.println(listener.mTsListener);
                    pw.print("        ");
                    pw.print("mScListener=");
                    pw.println(listener.mScListener);
                    pw.print("        ");
                    pw.print("mGroup=");
                    pw.println(listener.mGroup);
                    pw.print("        ");
                    pw.print("mScLocale=");
                    pw.print(listener.mScLocale);
                    pw.print(" mUid=");
                    pw.println(listener.mUid);
                }
            }
        }
    }

    private static String getStackTrace() {
        StringBuilder sb = new StringBuilder();
        try {
            throw new RuntimeException();
        } catch (RuntimeException e) {
            StackTraceElement[] frames = e.getStackTrace();
            for (int j = 1; j < frames.length; j++) {
                sb.append(frames[j].toString() + "\n");
            }
            return sb.toString();
        }
    }
}
