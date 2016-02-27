package com.android.server.tv;

import android.app.ActivityManager;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentProviderOperation;
import android.content.ContentProviderResult;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.OperationApplicationException;
import android.content.ServiceConnection;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.hardware.hdmi.HdmiDeviceInfo;
import android.media.tv.ITvInputClient;
import android.media.tv.ITvInputHardware;
import android.media.tv.ITvInputHardwareCallback;
import android.media.tv.ITvInputManager.Stub;
import android.media.tv.ITvInputManagerCallback;
import android.media.tv.ITvInputService;
import android.media.tv.ITvInputServiceCallback;
import android.media.tv.ITvInputSession;
import android.media.tv.ITvInputSessionCallback;
import android.media.tv.TvContentRating;
import android.media.tv.TvContentRatingSystemInfo;
import android.media.tv.TvContract.Channels;
import android.media.tv.TvContract.Programs;
import android.media.tv.TvContract.WatchedPrograms;
import android.media.tv.TvInputHardwareInfo;
import android.media.tv.TvInputInfo;
import android.media.tv.TvStreamConfig;
import android.media.tv.TvTrackInfo;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.UserHandle;
import android.util.Slog;
import android.util.SparseArray;
import android.view.InputChannel;
import android.view.Surface;
import com.android.internal.content.PackageMonitor;
import com.android.internal.os.SomeArgs;
import com.android.server.IoThread;
import com.android.server.SystemService;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.xmlpull.v1.XmlPullParserException;

public final class TvInputManagerService extends SystemService {
    private static final boolean DEBUG = false;
    private static final String TAG = "TvInputManagerService";
    private final ContentResolver mContentResolver;
    private final Context mContext;
    private int mCurrentUserId;
    private final Object mLock;
    private final TvInputHardwareManager mTvInputHardwareManager;
    private final SparseArray<UserState> mUserStates;
    private final WatchLogHandler mWatchLogHandler;

    /* renamed from: com.android.server.tv.TvInputManagerService.1 */
    class C05311 extends PackageMonitor {
        C05311() {
        }

        private void buildTvInputList(String[] packages) {
            synchronized (TvInputManagerService.this.mLock) {
                TvInputManagerService.this.buildTvInputListLocked(getChangingUserId(), packages);
                TvInputManagerService.this.buildTvContentRatingSystemListLocked(getChangingUserId());
            }
        }

        public void onPackageUpdateFinished(String packageName, int uid) {
            buildTvInputList(new String[]{packageName});
        }

        public void onPackagesAvailable(String[] packages) {
            if (isReplacing()) {
                buildTvInputList(packages);
            }
        }

        public void onPackagesUnavailable(String[] packages) {
            if (isReplacing()) {
                buildTvInputList(packages);
            }
        }

        public void onSomePackagesChanged() {
            if (!isReplacing()) {
                buildTvInputList(null);
            }
        }

        public void onPackageRemoved(String packageName, int uid) {
            Exception e;
            synchronized (TvInputManagerService.this.mLock) {
                if (TvInputManagerService.this.getUserStateLocked(getChangingUserId()).packageSet.contains(packageName)) {
                    ArrayList<ContentProviderOperation> operations = new ArrayList();
                    String selection = "package_name=?";
                    String[] selectionArgs = new String[]{packageName};
                    operations.add(ContentProviderOperation.newDelete(Channels.CONTENT_URI).withSelection(selection, selectionArgs).build());
                    operations.add(ContentProviderOperation.newDelete(Programs.CONTENT_URI).withSelection(selection, selectionArgs).build());
                    operations.add(ContentProviderOperation.newDelete(WatchedPrograms.CONTENT_URI).withSelection(selection, selectionArgs).build());
                    try {
                        ContentProviderResult[] results = TvInputManagerService.this.mContentResolver.applyBatch("android.media.tv", operations);
                        return;
                    } catch (RemoteException e2) {
                        e = e2;
                        Slog.e(TvInputManagerService.TAG, "error in applyBatch", e);
                        return;
                    } catch (OperationApplicationException e3) {
                        e = e3;
                        Slog.e(TvInputManagerService.TAG, "error in applyBatch", e);
                        return;
                    }
                }
            }
        }
    }

    /* renamed from: com.android.server.tv.TvInputManagerService.2 */
    class C05322 extends BroadcastReceiver {
        C05322() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if ("android.intent.action.USER_SWITCHED".equals(action)) {
                TvInputManagerService.this.switchUser(intent.getIntExtra("android.intent.extra.user_handle", 0));
            } else if ("android.intent.action.USER_REMOVED".equals(action)) {
                TvInputManagerService.this.removeUser(intent.getIntExtra("android.intent.extra.user_handle", 0));
            }
        }
    }

    private final class BinderService extends Stub {

        /* renamed from: com.android.server.tv.TvInputManagerService.BinderService.1 */
        class C05331 implements DeathRecipient {
            final /* synthetic */ ITvInputManagerCallback val$callback;
            final /* synthetic */ UserState val$userState;

            C05331(UserState userState, ITvInputManagerCallback iTvInputManagerCallback) {
                this.val$userState = userState;
                this.val$callback = iTvInputManagerCallback;
            }

            public void binderDied() {
                synchronized (TvInputManagerService.this.mLock) {
                    if (this.val$userState.callbackSet != null) {
                        this.val$userState.callbackSet.remove(this.val$callback);
                    }
                }
            }
        }

        private BinderService() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public java.util.List<android.media.tv.TvInputInfo> getTvInputList(int r12) {
            /*
            r11 = this;
            r7 = com.android.server.tv.TvInputManagerService.this;
            r8 = android.os.Binder.getCallingPid();
            r9 = android.os.Binder.getCallingUid();
            r10 = "getTvInputList";
            r4 = r7.resolveCallingUserId(r8, r9, r12, r10);
            r2 = android.os.Binder.clearCallingIdentity();
            r7 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0049 }
            r8 = r7.mLock;	 Catch:{ all -> 0x0049 }
            monitor-enter(r8);	 Catch:{ all -> 0x0049 }
            r7 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0046 }
            r6 = r7.getUserStateLocked(r4);	 Catch:{ all -> 0x0046 }
            r1 = new java.util.ArrayList;	 Catch:{ all -> 0x0046 }
            r1.<init>();	 Catch:{ all -> 0x0046 }
            r7 = r6.inputMap;	 Catch:{ all -> 0x0046 }
            r7 = r7.values();	 Catch:{ all -> 0x0046 }
            r0 = r7.iterator();	 Catch:{ all -> 0x0046 }
        L_0x0032:
            r7 = r0.hasNext();	 Catch:{ all -> 0x0046 }
            if (r7 == 0) goto L_0x004e;
        L_0x0038:
            r5 = r0.next();	 Catch:{ all -> 0x0046 }
            r5 = (com.android.server.tv.TvInputManagerService.TvInputState) r5;	 Catch:{ all -> 0x0046 }
            r7 = r5.info;	 Catch:{ all -> 0x0046 }
            r1.add(r7);	 Catch:{ all -> 0x0046 }
            goto L_0x0032;
        L_0x0046:
            r7 = move-exception;
            monitor-exit(r8);	 Catch:{ all -> 0x0046 }
            throw r7;	 Catch:{ all -> 0x0049 }
        L_0x0049:
            r7 = move-exception;
            android.os.Binder.restoreCallingIdentity(r2);
            throw r7;
        L_0x004e:
            monitor-exit(r8);	 Catch:{ all -> 0x0046 }
            android.os.Binder.restoreCallingIdentity(r2);
            return r1;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.getTvInputList(int):java.util.List<android.media.tv.TvInputInfo>");
        }

        public TvInputInfo getTvInputInfo(String inputId, int userId) {
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "getTvInputInfo");
            long identity = Binder.clearCallingIdentity();
            try {
                TvInputInfo access$1600;
                synchronized (TvInputManagerService.this.mLock) {
                    TvInputState state = (TvInputState) TvInputManagerService.this.getUserStateLocked(resolvedUserId).inputMap.get(inputId);
                    access$1600 = state == null ? null : state.info;
                }
                return access$1600;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public int getTvInputState(String inputId, int userId) {
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "getTvInputState");
            long identity = Binder.clearCallingIdentity();
            try {
                int access$3900;
                synchronized (TvInputManagerService.this.mLock) {
                    TvInputState state = (TvInputState) TvInputManagerService.this.getUserStateLocked(resolvedUserId).inputMap.get(inputId);
                    access$3900 = state == null ? -1 : state.state;
                }
                return access$3900;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public List<TvContentRatingSystemInfo> getTvContentRatingSystemList(int userId) {
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "getTvContentRatingSystemList");
            long identity = Binder.clearCallingIdentity();
            try {
                List<TvContentRatingSystemInfo> access$1700;
                synchronized (TvInputManagerService.this.mLock) {
                    access$1700 = TvInputManagerService.this.getUserStateLocked(resolvedUserId).contentRatingSystemList;
                }
                return access$1700;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void registerCallback(android.media.tv.ITvInputManagerCallback r10, int r11) {
            /*
            r9 = this;
            r5 = com.android.server.tv.TvInputManagerService.this;
            r6 = android.os.Binder.getCallingPid();
            r7 = android.os.Binder.getCallingUid();
            r8 = "registerCallback";
            r1 = r5.resolveCallingUserId(r6, r7, r11, r8);
            r2 = android.os.Binder.clearCallingIdentity();
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0046 }
            r6 = r5.mLock;	 Catch:{ all -> 0x0046 }
            monitor-enter(r6);	 Catch:{ all -> 0x0046 }
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0043 }
            r4 = r5.getUserStateLocked(r1);	 Catch:{ all -> 0x0043 }
            r5 = r4.callbackSet;	 Catch:{ all -> 0x0043 }
            r5.add(r10);	 Catch:{ all -> 0x0043 }
            r5 = r10.asBinder();	 Catch:{ RemoteException -> 0x003a }
            r7 = new com.android.server.tv.TvInputManagerService$BinderService$1;	 Catch:{ RemoteException -> 0x003a }
            r7.<init>(r4, r10);	 Catch:{ RemoteException -> 0x003a }
            r8 = 0;
            r5.linkToDeath(r7, r8);	 Catch:{ RemoteException -> 0x003a }
        L_0x0035:
            monitor-exit(r6);	 Catch:{ all -> 0x0043 }
            android.os.Binder.restoreCallingIdentity(r2);
            return;
        L_0x003a:
            r0 = move-exception;
            r5 = "TvInputManagerService";
            r7 = "client process has already died";
            android.util.Slog.e(r5, r7, r0);	 Catch:{ all -> 0x0043 }
            goto L_0x0035;
        L_0x0043:
            r5 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x0043 }
            throw r5;	 Catch:{ all -> 0x0046 }
        L_0x0046:
            r5 = move-exception;
            android.os.Binder.restoreCallingIdentity(r2);
            throw r5;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.registerCallback(android.media.tv.ITvInputManagerCallback, int):void");
        }

        public void unregisterCallback(ITvInputManagerCallback callback, int userId) {
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "unregisterCallback");
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (TvInputManagerService.this.mLock) {
                    TvInputManagerService.this.getUserStateLocked(resolvedUserId).callbackSet.remove(callback);
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public boolean isParentalControlsEnabled(int userId) {
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "isParentalControlsEnabled");
            long identity = Binder.clearCallingIdentity();
            try {
                boolean isParentalControlsEnabled;
                synchronized (TvInputManagerService.this.mLock) {
                    isParentalControlsEnabled = TvInputManagerService.this.getUserStateLocked(resolvedUserId).persistentDataStore.isParentalControlsEnabled();
                }
                return isParentalControlsEnabled;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void setParentalControlsEnabled(boolean enabled, int userId) {
            ensureParentalControlsPermission();
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "setParentalControlsEnabled");
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (TvInputManagerService.this.mLock) {
                    TvInputManagerService.this.getUserStateLocked(resolvedUserId).persistentDataStore.setParentalControlsEnabled(enabled);
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public boolean isRatingBlocked(String rating, int userId) {
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "isRatingBlocked");
            long identity = Binder.clearCallingIdentity();
            try {
                boolean isRatingBlocked;
                synchronized (TvInputManagerService.this.mLock) {
                    isRatingBlocked = TvInputManagerService.this.getUserStateLocked(resolvedUserId).persistentDataStore.isRatingBlocked(TvContentRating.unflattenFromString(rating));
                }
                return isRatingBlocked;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public List<String> getBlockedRatings(int userId) {
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "getBlockedRatings");
            long identity = Binder.clearCallingIdentity();
            try {
                List<String> ratings;
                synchronized (TvInputManagerService.this.mLock) {
                    UserState userState = TvInputManagerService.this.getUserStateLocked(resolvedUserId);
                    ratings = new ArrayList();
                    for (TvContentRating rating : userState.persistentDataStore.getBlockedRatings()) {
                        ratings.add(rating.flattenToString());
                    }
                }
                return ratings;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void addBlockedRating(String rating, int userId) {
            ensureParentalControlsPermission();
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "addBlockedRating");
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (TvInputManagerService.this.mLock) {
                    TvInputManagerService.this.getUserStateLocked(resolvedUserId).persistentDataStore.addBlockedRating(TvContentRating.unflattenFromString(rating));
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void removeBlockedRating(String rating, int userId) {
            ensureParentalControlsPermission();
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "removeBlockedRating");
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (TvInputManagerService.this.mLock) {
                    TvInputManagerService.this.getUserStateLocked(resolvedUserId).persistentDataStore.removeBlockedRating(TvContentRating.unflattenFromString(rating));
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        private void ensureParentalControlsPermission() {
            if (TvInputManagerService.this.mContext.checkCallingPermission("android.permission.MODIFY_PARENTAL_CONTROLS") != 0) {
                throw new SecurityException("The caller does not have parental controls permission");
            }
        }

        public void createSession(ITvInputClient client, String inputId, int seq, int userId) {
            int callingUid = Binder.getCallingUid();
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), callingUid, userId, "createSession");
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (TvInputManagerService.this.mLock) {
                    UserState userState = TvInputManagerService.this.getUserStateLocked(resolvedUserId);
                    TvInputState inputState = (TvInputState) userState.inputMap.get(inputId);
                    if (inputState == null) {
                        Slog.w(TvInputManagerService.TAG, "Failed to find input state for inputId=" + inputId);
                        TvInputManagerService.this.sendSessionTokenToClientLocked(client, inputId, null, null, seq);
                        return;
                    }
                    TvInputInfo info = inputState.info;
                    ServiceState serviceState = (ServiceState) userState.serviceStateMap.get(info.getComponent());
                    if (serviceState == null) {
                        serviceState = new ServiceState(info.getComponent(), resolvedUserId, null);
                        userState.serviceStateMap.put(info.getComponent(), serviceState);
                    }
                    if (serviceState.reconnecting) {
                        TvInputManagerService.this.sendSessionTokenToClientLocked(client, inputId, null, null, seq);
                        Binder.restoreCallingIdentity(identity);
                        return;
                    }
                    IBinder sessionToken = new Binder();
                    userState.sessionStateMap.put(sessionToken, new SessionState(sessionToken, info, client, seq, callingUid, resolvedUserId, null));
                    serviceState.sessionTokens.add(sessionToken);
                    if (serviceState.service != null) {
                        TvInputManagerService.this.createSessionInternalLocked(serviceState.service, sessionToken, resolvedUserId);
                    } else {
                        TvInputManagerService.this.updateServiceConnectionLocked(info.getComponent(), resolvedUserId);
                    }
                    Binder.restoreCallingIdentity(identity);
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void releaseSession(IBinder sessionToken, int userId) {
            int callingUid = Binder.getCallingUid();
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), callingUid, userId, "releaseSession");
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (TvInputManagerService.this.mLock) {
                    TvInputManagerService.this.releaseSessionLocked(sessionToken, callingUid, resolvedUserId);
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void setMainSession(IBinder sessionToken, int userId) {
            int callingUid = Binder.getCallingUid();
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), callingUid, userId, "setMainSession");
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (TvInputManagerService.this.mLock) {
                    UserState userState = TvInputManagerService.this.getUserStateLocked(resolvedUserId);
                    if (userState.mainSessionToken == sessionToken) {
                        return;
                    }
                    IBinder oldMainSessionToken = userState.mainSessionToken;
                    userState.mainSessionToken = sessionToken;
                    if (sessionToken != null) {
                        TvInputManagerService.this.setMainLocked(sessionToken, true, callingUid, userId);
                    }
                    if (oldMainSessionToken != null) {
                        TvInputManagerService.this.setMainLocked(oldMainSessionToken, TvInputManagerService.DEBUG, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, userId);
                    }
                    Binder.restoreCallingIdentity(identity);
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void setSurface(android.os.IBinder r11, android.view.Surface r12, int r13) {
            /*
            r10 = this;
            r0 = android.os.Binder.getCallingUid();
            r6 = com.android.server.tv.TvInputManagerService.this;
            r7 = android.os.Binder.getCallingPid();
            r8 = "setSurface";
            r4 = r6.resolveCallingUserId(r7, r0, r13, r8);
            r2 = android.os.Binder.clearCallingIdentity();
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0057 }
            r7 = r6.mLock;	 Catch:{ all -> 0x0057 }
            monitor-enter(r7);	 Catch:{ all -> 0x0057 }
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x004a, SessionNotFoundException -> 0x0061 }
            r5 = r6.getSessionStateLocked(r11, r0, r4);	 Catch:{ RemoteException -> 0x004a, SessionNotFoundException -> 0x0061 }
            r6 = r5.hardwareSessionToken;	 Catch:{ RemoteException -> 0x004a, SessionNotFoundException -> 0x0061 }
            if (r6 != 0) goto L_0x003a;
        L_0x0027:
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x004a, SessionNotFoundException -> 0x0061 }
            r6 = r6.getSessionLocked(r5);	 Catch:{ RemoteException -> 0x004a, SessionNotFoundException -> 0x0061 }
            r6.setSurface(r12);	 Catch:{ RemoteException -> 0x004a, SessionNotFoundException -> 0x0061 }
        L_0x0030:
            monitor-exit(r7);	 Catch:{ all -> 0x0054 }
            if (r12 == 0) goto L_0x0036;
        L_0x0033:
            r12.release();
        L_0x0036:
            android.os.Binder.restoreCallingIdentity(r2);
            return;
        L_0x003a:
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x004a, SessionNotFoundException -> 0x0061 }
            r8 = r5.hardwareSessionToken;	 Catch:{ RemoteException -> 0x004a, SessionNotFoundException -> 0x0061 }
            r9 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
            r6 = r6.getSessionLocked(r8, r9, r4);	 Catch:{ RemoteException -> 0x004a, SessionNotFoundException -> 0x0061 }
            r6.setSurface(r12);	 Catch:{ RemoteException -> 0x004a, SessionNotFoundException -> 0x0061 }
            goto L_0x0030;
        L_0x004a:
            r6 = move-exception;
            r1 = r6;
        L_0x004c:
            r6 = "TvInputManagerService";
            r8 = "error in setSurface";
            android.util.Slog.e(r6, r8, r1);	 Catch:{ all -> 0x0054 }
            goto L_0x0030;
        L_0x0054:
            r6 = move-exception;
            monitor-exit(r7);	 Catch:{ all -> 0x0054 }
            throw r6;	 Catch:{ all -> 0x0057 }
        L_0x0057:
            r6 = move-exception;
            if (r12 == 0) goto L_0x005d;
        L_0x005a:
            r12.release();
        L_0x005d:
            android.os.Binder.restoreCallingIdentity(r2);
            throw r6;
        L_0x0061:
            r6 = move-exception;
            r1 = r6;
            goto L_0x004c;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.setSurface(android.os.IBinder, android.view.Surface, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void dispatchSurfaceChanged(android.os.IBinder r11, int r12, int r13, int r14, int r15) {
            /*
            r10 = this;
            r0 = android.os.Binder.getCallingUid();
            r6 = com.android.server.tv.TvInputManagerService.this;
            r7 = android.os.Binder.getCallingPid();
            r8 = "dispatchSurfaceChanged";
            r4 = r6.resolveCallingUserId(r7, r0, r15, r8);
            r2 = android.os.Binder.clearCallingIdentity();
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0051 }
            r7 = r6.mLock;	 Catch:{ all -> 0x0051 }
            monitor-enter(r7);	 Catch:{ all -> 0x0051 }
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0044, SessionNotFoundException -> 0x0056 }
            r5 = r6.getSessionStateLocked(r11, r0, r4);	 Catch:{ RemoteException -> 0x0044, SessionNotFoundException -> 0x0056 }
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0044, SessionNotFoundException -> 0x0056 }
            r6 = r6.getSessionLocked(r5);	 Catch:{ RemoteException -> 0x0044, SessionNotFoundException -> 0x0056 }
            r6.dispatchSurfaceChanged(r12, r13, r14);	 Catch:{ RemoteException -> 0x0044, SessionNotFoundException -> 0x0056 }
            r6 = r5.hardwareSessionToken;	 Catch:{ RemoteException -> 0x0044, SessionNotFoundException -> 0x0056 }
            if (r6 == 0) goto L_0x003f;
        L_0x0030:
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0044, SessionNotFoundException -> 0x0056 }
            r8 = r5.hardwareSessionToken;	 Catch:{ RemoteException -> 0x0044, SessionNotFoundException -> 0x0056 }
            r9 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
            r6 = r6.getSessionLocked(r8, r9, r4);	 Catch:{ RemoteException -> 0x0044, SessionNotFoundException -> 0x0056 }
            r6.dispatchSurfaceChanged(r12, r13, r14);	 Catch:{ RemoteException -> 0x0044, SessionNotFoundException -> 0x0056 }
        L_0x003f:
            monitor-exit(r7);	 Catch:{ all -> 0x004e }
            android.os.Binder.restoreCallingIdentity(r2);
            return;
        L_0x0044:
            r6 = move-exception;
            r1 = r6;
        L_0x0046:
            r6 = "TvInputManagerService";
            r8 = "error in dispatchSurfaceChanged";
            android.util.Slog.e(r6, r8, r1);	 Catch:{ all -> 0x004e }
            goto L_0x003f;
        L_0x004e:
            r6 = move-exception;
            monitor-exit(r7);	 Catch:{ all -> 0x004e }
            throw r6;	 Catch:{ all -> 0x0051 }
        L_0x0051:
            r6 = move-exception;
            android.os.Binder.restoreCallingIdentity(r2);
            throw r6;
        L_0x0056:
            r6 = move-exception;
            r1 = r6;
            goto L_0x0046;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.dispatchSurfaceChanged(android.os.IBinder, int, int, int, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void setVolume(android.os.IBinder r13, float r14, int r15) {
            /*
            r12 = this;
            r1 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
            r0 = 0;
            r2 = android.os.Binder.getCallingUid();
            r8 = com.android.server.tv.TvInputManagerService.this;
            r9 = android.os.Binder.getCallingPid();
            r10 = "setVolume";
            r6 = r8.resolveCallingUserId(r9, r2, r15, r10);
            r4 = android.os.Binder.clearCallingIdentity();
            r8 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x005d }
            r9 = r8.mLock;	 Catch:{ all -> 0x005d }
            monitor-enter(r9);	 Catch:{ all -> 0x005d }
            r8 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0050, SessionNotFoundException -> 0x0062 }
            r7 = r8.getSessionStateLocked(r13, r2, r6);	 Catch:{ RemoteException -> 0x0050, SessionNotFoundException -> 0x0062 }
            r8 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0050, SessionNotFoundException -> 0x0062 }
            r8 = r8.getSessionLocked(r7);	 Catch:{ RemoteException -> 0x0050, SessionNotFoundException -> 0x0062 }
            r8.setVolume(r14);	 Catch:{ RemoteException -> 0x0050, SessionNotFoundException -> 0x0062 }
            r8 = r7.hardwareSessionToken;	 Catch:{ RemoteException -> 0x0050, SessionNotFoundException -> 0x0062 }
            if (r8 == 0) goto L_0x0049;
        L_0x0033:
            r8 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0050, SessionNotFoundException -> 0x0062 }
            r10 = r7.hardwareSessionToken;	 Catch:{ RemoteException -> 0x0050, SessionNotFoundException -> 0x0062 }
            r11 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
            r10 = r8.getSessionLocked(r10, r11, r6);	 Catch:{ RemoteException -> 0x0050, SessionNotFoundException -> 0x0062 }
            r8 = 0;
            r8 = (r14 > r8 ? 1 : (r14 == r8 ? 0 : -1));
            if (r8 <= 0) goto L_0x004e;
        L_0x0044:
            r8 = 1065353216; // 0x3f800000 float:1.0 double:5.263544247E-315;
        L_0x0046:
            r10.setVolume(r8);	 Catch:{ RemoteException -> 0x0050, SessionNotFoundException -> 0x0062 }
        L_0x0049:
            monitor-exit(r9);	 Catch:{ all -> 0x005a }
            android.os.Binder.restoreCallingIdentity(r4);
            return;
        L_0x004e:
            r8 = 0;
            goto L_0x0046;
        L_0x0050:
            r8 = move-exception;
            r3 = r8;
        L_0x0052:
            r8 = "TvInputManagerService";
            r10 = "error in setVolume";
            android.util.Slog.e(r8, r10, r3);	 Catch:{ all -> 0x005a }
            goto L_0x0049;
        L_0x005a:
            r8 = move-exception;
            monitor-exit(r9);	 Catch:{ all -> 0x005a }
            throw r8;	 Catch:{ all -> 0x005d }
        L_0x005d:
            r8 = move-exception;
            android.os.Binder.restoreCallingIdentity(r4);
            throw r8;
        L_0x0062:
            r8 = move-exception;
            r3 = r8;
            goto L_0x0052;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.setVolume(android.os.IBinder, float, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void tune(android.os.IBinder r15, android.net.Uri r16, android.os.Bundle r17, int r18) {
            /*
            r14 = this;
            r3 = android.os.Binder.getCallingUid();
            r10 = com.android.server.tv.TvInputManagerService.this;
            r11 = android.os.Binder.getCallingPid();
            r12 = "tune";
            r0 = r18;
            r5 = r10.resolveCallingUserId(r11, r3, r0, r12);
            r6 = android.os.Binder.clearCallingIdentity();
            r10 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0095 }
            r11 = r10.mLock;	 Catch:{ all -> 0x0095 }
            monitor-enter(r11);	 Catch:{ all -> 0x0095 }
            r10 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10 = r10.getSessionLocked(r15, r3, r5);	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r0 = r16;
            r1 = r17;
            r10.tune(r0, r1);	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10 = android.media.tv.TvContract.isChannelUriForPassthroughInput(r16);	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            if (r10 == 0) goto L_0x0035;
        L_0x0030:
            monitor-exit(r11);	 Catch:{ all -> 0x0092 }
            android.os.Binder.restoreCallingIdentity(r6);
        L_0x0034:
            return;
        L_0x0035:
            r10 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r9 = r10.getUserStateLocked(r5);	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10 = r9.sessionStateMap;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r8 = r10.get(r15);	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r8 = (com.android.server.tv.TvInputManagerService.SessionState) r8;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r2 = com.android.internal.os.SomeArgs.obtain();	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10 = r8.info;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10 = r10.getComponent();	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10 = r10.getPackageName();	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r2.arg1 = r10;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r12 = java.lang.System.currentTimeMillis();	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10 = java.lang.Long.valueOf(r12);	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r2.arg2 = r10;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r12 = android.content.ContentUris.parseId(r16);	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10 = java.lang.Long.valueOf(r12);	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r2.arg3 = r10;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r0 = r17;
            r2.arg4 = r0;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r2.arg5 = r15;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10 = r10.mWatchLogHandler;	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r12 = 1;
            r10 = r10.obtainMessage(r12, r2);	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            r10.sendToTarget();	 Catch:{ RemoteException -> 0x0084, SessionNotFoundException -> 0x009a }
            monitor-exit(r11);	 Catch:{ all -> 0x0092 }
            android.os.Binder.restoreCallingIdentity(r6);
            goto L_0x0034;
        L_0x0084:
            r10 = move-exception;
            r4 = r10;
        L_0x0086:
            r10 = "TvInputManagerService";
            r12 = "error in tune";
            android.util.Slog.e(r10, r12, r4);	 Catch:{ all -> 0x0092 }
            monitor-exit(r11);	 Catch:{ all -> 0x0092 }
            android.os.Binder.restoreCallingIdentity(r6);
            goto L_0x0034;
        L_0x0092:
            r10 = move-exception;
            monitor-exit(r11);	 Catch:{ all -> 0x0092 }
            throw r10;	 Catch:{ all -> 0x0095 }
        L_0x0095:
            r10 = move-exception;
            android.os.Binder.restoreCallingIdentity(r6);
            throw r10;
        L_0x009a:
            r10 = move-exception;
            r4 = r10;
            goto L_0x0086;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.tune(android.os.IBinder, android.net.Uri, android.os.Bundle, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void requestUnblockContent(android.os.IBinder r9, java.lang.String r10, int r11) {
            /*
            r8 = this;
            r0 = android.os.Binder.getCallingUid();
            r5 = com.android.server.tv.TvInputManagerService.this;
            r6 = android.os.Binder.getCallingPid();
            r7 = "unblockContent";
            r4 = r5.resolveCallingUserId(r6, r0, r11, r7);
            r2 = android.os.Binder.clearCallingIdentity();
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0036 }
            r6 = r5.mLock;	 Catch:{ all -> 0x0036 }
            monitor-enter(r6);	 Catch:{ all -> 0x0036 }
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5 = r5.getSessionLocked(r9, r0, r4);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5.requestUnblockContent(r10);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
        L_0x0024:
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            android.os.Binder.restoreCallingIdentity(r2);
            return;
        L_0x0029:
            r5 = move-exception;
            r1 = r5;
        L_0x002b:
            r5 = "TvInputManagerService";
            r7 = "error in requestUnblockContent";
            android.util.Slog.e(r5, r7, r1);	 Catch:{ all -> 0x0033 }
            goto L_0x0024;
        L_0x0033:
            r5 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            throw r5;	 Catch:{ all -> 0x0036 }
        L_0x0036:
            r5 = move-exception;
            android.os.Binder.restoreCallingIdentity(r2);
            throw r5;
        L_0x003b:
            r5 = move-exception;
            r1 = r5;
            goto L_0x002b;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.requestUnblockContent(android.os.IBinder, java.lang.String, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void setCaptionEnabled(android.os.IBinder r9, boolean r10, int r11) {
            /*
            r8 = this;
            r0 = android.os.Binder.getCallingUid();
            r5 = com.android.server.tv.TvInputManagerService.this;
            r6 = android.os.Binder.getCallingPid();
            r7 = "setCaptionEnabled";
            r4 = r5.resolveCallingUserId(r6, r0, r11, r7);
            r2 = android.os.Binder.clearCallingIdentity();
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0036 }
            r6 = r5.mLock;	 Catch:{ all -> 0x0036 }
            monitor-enter(r6);	 Catch:{ all -> 0x0036 }
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5 = r5.getSessionLocked(r9, r0, r4);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5.setCaptionEnabled(r10);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
        L_0x0024:
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            android.os.Binder.restoreCallingIdentity(r2);
            return;
        L_0x0029:
            r5 = move-exception;
            r1 = r5;
        L_0x002b:
            r5 = "TvInputManagerService";
            r7 = "error in setCaptionEnabled";
            android.util.Slog.e(r5, r7, r1);	 Catch:{ all -> 0x0033 }
            goto L_0x0024;
        L_0x0033:
            r5 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            throw r5;	 Catch:{ all -> 0x0036 }
        L_0x0036:
            r5 = move-exception;
            android.os.Binder.restoreCallingIdentity(r2);
            throw r5;
        L_0x003b:
            r5 = move-exception;
            r1 = r5;
            goto L_0x002b;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.setCaptionEnabled(android.os.IBinder, boolean, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void selectTrack(android.os.IBinder r9, int r10, java.lang.String r11, int r12) {
            /*
            r8 = this;
            r0 = android.os.Binder.getCallingUid();
            r5 = com.android.server.tv.TvInputManagerService.this;
            r6 = android.os.Binder.getCallingPid();
            r7 = "selectTrack";
            r4 = r5.resolveCallingUserId(r6, r0, r12, r7);
            r2 = android.os.Binder.clearCallingIdentity();
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0036 }
            r6 = r5.mLock;	 Catch:{ all -> 0x0036 }
            monitor-enter(r6);	 Catch:{ all -> 0x0036 }
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5 = r5.getSessionLocked(r9, r0, r4);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5.selectTrack(r10, r11);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
        L_0x0024:
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            android.os.Binder.restoreCallingIdentity(r2);
            return;
        L_0x0029:
            r5 = move-exception;
            r1 = r5;
        L_0x002b:
            r5 = "TvInputManagerService";
            r7 = "error in selectTrack";
            android.util.Slog.e(r5, r7, r1);	 Catch:{ all -> 0x0033 }
            goto L_0x0024;
        L_0x0033:
            r5 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            throw r5;	 Catch:{ all -> 0x0036 }
        L_0x0036:
            r5 = move-exception;
            android.os.Binder.restoreCallingIdentity(r2);
            throw r5;
        L_0x003b:
            r5 = move-exception;
            r1 = r5;
            goto L_0x002b;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.selectTrack(android.os.IBinder, int, java.lang.String, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void sendAppPrivateCommand(android.os.IBinder r9, java.lang.String r10, android.os.Bundle r11, int r12) {
            /*
            r8 = this;
            r0 = android.os.Binder.getCallingUid();
            r5 = com.android.server.tv.TvInputManagerService.this;
            r6 = android.os.Binder.getCallingPid();
            r7 = "sendAppPrivateCommand";
            r4 = r5.resolveCallingUserId(r6, r0, r12, r7);
            r2 = android.os.Binder.clearCallingIdentity();
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0036 }
            r6 = r5.mLock;	 Catch:{ all -> 0x0036 }
            monitor-enter(r6);	 Catch:{ all -> 0x0036 }
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5 = r5.getSessionLocked(r9, r0, r4);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5.appPrivateCommand(r10, r11);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
        L_0x0024:
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            android.os.Binder.restoreCallingIdentity(r2);
            return;
        L_0x0029:
            r5 = move-exception;
            r1 = r5;
        L_0x002b:
            r5 = "TvInputManagerService";
            r7 = "error in appPrivateCommand";
            android.util.Slog.e(r5, r7, r1);	 Catch:{ all -> 0x0033 }
            goto L_0x0024;
        L_0x0033:
            r5 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            throw r5;	 Catch:{ all -> 0x0036 }
        L_0x0036:
            r5 = move-exception;
            android.os.Binder.restoreCallingIdentity(r2);
            throw r5;
        L_0x003b:
            r5 = move-exception;
            r1 = r5;
            goto L_0x002b;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.sendAppPrivateCommand(android.os.IBinder, java.lang.String, android.os.Bundle, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void createOverlayView(android.os.IBinder r9, android.os.IBinder r10, android.graphics.Rect r11, int r12) {
            /*
            r8 = this;
            r0 = android.os.Binder.getCallingUid();
            r5 = com.android.server.tv.TvInputManagerService.this;
            r6 = android.os.Binder.getCallingPid();
            r7 = "createOverlayView";
            r4 = r5.resolveCallingUserId(r6, r0, r12, r7);
            r2 = android.os.Binder.clearCallingIdentity();
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0036 }
            r6 = r5.mLock;	 Catch:{ all -> 0x0036 }
            monitor-enter(r6);	 Catch:{ all -> 0x0036 }
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5 = r5.getSessionLocked(r9, r0, r4);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5.createOverlayView(r10, r11);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
        L_0x0024:
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            android.os.Binder.restoreCallingIdentity(r2);
            return;
        L_0x0029:
            r5 = move-exception;
            r1 = r5;
        L_0x002b:
            r5 = "TvInputManagerService";
            r7 = "error in createOverlayView";
            android.util.Slog.e(r5, r7, r1);	 Catch:{ all -> 0x0033 }
            goto L_0x0024;
        L_0x0033:
            r5 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            throw r5;	 Catch:{ all -> 0x0036 }
        L_0x0036:
            r5 = move-exception;
            android.os.Binder.restoreCallingIdentity(r2);
            throw r5;
        L_0x003b:
            r5 = move-exception;
            r1 = r5;
            goto L_0x002b;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.createOverlayView(android.os.IBinder, android.os.IBinder, android.graphics.Rect, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void relayoutOverlayView(android.os.IBinder r9, android.graphics.Rect r10, int r11) {
            /*
            r8 = this;
            r0 = android.os.Binder.getCallingUid();
            r5 = com.android.server.tv.TvInputManagerService.this;
            r6 = android.os.Binder.getCallingPid();
            r7 = "relayoutOverlayView";
            r4 = r5.resolveCallingUserId(r6, r0, r11, r7);
            r2 = android.os.Binder.clearCallingIdentity();
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0036 }
            r6 = r5.mLock;	 Catch:{ all -> 0x0036 }
            monitor-enter(r6);	 Catch:{ all -> 0x0036 }
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5 = r5.getSessionLocked(r9, r0, r4);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5.relayoutOverlayView(r10);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
        L_0x0024:
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            android.os.Binder.restoreCallingIdentity(r2);
            return;
        L_0x0029:
            r5 = move-exception;
            r1 = r5;
        L_0x002b:
            r5 = "TvInputManagerService";
            r7 = "error in relayoutOverlayView";
            android.util.Slog.e(r5, r7, r1);	 Catch:{ all -> 0x0033 }
            goto L_0x0024;
        L_0x0033:
            r5 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            throw r5;	 Catch:{ all -> 0x0036 }
        L_0x0036:
            r5 = move-exception;
            android.os.Binder.restoreCallingIdentity(r2);
            throw r5;
        L_0x003b:
            r5 = move-exception;
            r1 = r5;
            goto L_0x002b;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.relayoutOverlayView(android.os.IBinder, android.graphics.Rect, int):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void removeOverlayView(android.os.IBinder r9, int r10) {
            /*
            r8 = this;
            r0 = android.os.Binder.getCallingUid();
            r5 = com.android.server.tv.TvInputManagerService.this;
            r6 = android.os.Binder.getCallingPid();
            r7 = "removeOverlayView";
            r4 = r5.resolveCallingUserId(r6, r0, r10, r7);
            r2 = android.os.Binder.clearCallingIdentity();
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0036 }
            r6 = r5.mLock;	 Catch:{ all -> 0x0036 }
            monitor-enter(r6);	 Catch:{ all -> 0x0036 }
            r5 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5 = r5.getSessionLocked(r9, r0, r4);	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
            r5.removeOverlayView();	 Catch:{ RemoteException -> 0x0029, SessionNotFoundException -> 0x003b }
        L_0x0024:
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            android.os.Binder.restoreCallingIdentity(r2);
            return;
        L_0x0029:
            r5 = move-exception;
            r1 = r5;
        L_0x002b:
            r5 = "TvInputManagerService";
            r7 = "error in removeOverlayView";
            android.util.Slog.e(r5, r7, r1);	 Catch:{ all -> 0x0033 }
            goto L_0x0024;
        L_0x0033:
            r5 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x0033 }
            throw r5;	 Catch:{ all -> 0x0036 }
        L_0x0036:
            r5 = move-exception;
            android.os.Binder.restoreCallingIdentity(r2);
            throw r5;
        L_0x003b:
            r5 = move-exception;
            r1 = r5;
            goto L_0x002b;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.removeOverlayView(android.os.IBinder, int):void");
        }

        public List<TvInputHardwareInfo> getHardwareList() throws RemoteException {
            if (TvInputManagerService.this.mContext.checkCallingPermission("android.permission.TV_INPUT_HARDWARE") != 0) {
                return null;
            }
            long identity = Binder.clearCallingIdentity();
            try {
                List<TvInputHardwareInfo> hardwareList = TvInputManagerService.this.mTvInputHardwareManager.getHardwareList();
                return hardwareList;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public ITvInputHardware acquireTvInputHardware(int deviceId, ITvInputHardwareCallback callback, TvInputInfo info, int userId) throws RemoteException {
            if (TvInputManagerService.this.mContext.checkCallingPermission("android.permission.TV_INPUT_HARDWARE") != 0) {
                return null;
            }
            long identity = Binder.clearCallingIdentity();
            int callingUid = Binder.getCallingUid();
            try {
                ITvInputHardware acquireHardware = TvInputManagerService.this.mTvInputHardwareManager.acquireHardware(deviceId, callback, info, callingUid, TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), callingUid, userId, "acquireTvInputHardware"));
                return acquireHardware;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void releaseTvInputHardware(int deviceId, ITvInputHardware hardware, int userId) throws RemoteException {
            if (TvInputManagerService.this.mContext.checkCallingPermission("android.permission.TV_INPUT_HARDWARE") == 0) {
                long identity = Binder.clearCallingIdentity();
                int callingUid = Binder.getCallingUid();
                try {
                    TvInputManagerService.this.mTvInputHardwareManager.releaseHardware(deviceId, hardware, callingUid, TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), callingUid, userId, "releaseTvInputHardware"));
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public List<TvStreamConfig> getAvailableTvStreamConfigList(String inputId, int userId) throws RemoteException {
            if (TvInputManagerService.this.mContext.checkCallingPermission("android.permission.CAPTURE_TV_INPUT") != 0) {
                throw new SecurityException("Requires CAPTURE_TV_INPUT permission");
            }
            long identity = Binder.clearCallingIdentity();
            int callingUid = Binder.getCallingUid();
            try {
                List<TvStreamConfig> availableTvStreamConfigList = TvInputManagerService.this.mTvInputHardwareManager.getAvailableTvStreamConfigList(inputId, callingUid, TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), callingUid, userId, "getAvailableTvStreamConfigList"));
                return availableTvStreamConfigList;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public boolean captureFrame(String inputId, Surface surface, TvStreamConfig config, int userId) throws RemoteException {
            if (TvInputManagerService.this.mContext.checkCallingPermission("android.permission.CAPTURE_TV_INPUT") != 0) {
                throw new SecurityException("Requires CAPTURE_TV_INPUT permission");
            }
            long identity = Binder.clearCallingIdentity();
            int callingUid = Binder.getCallingUid();
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), callingUid, userId, "captureFrame");
            String hardwareInputId = null;
            try {
                boolean z;
                synchronized (TvInputManagerService.this.mLock) {
                    UserState userState = TvInputManagerService.this.getUserStateLocked(resolvedUserId);
                    if (userState.inputMap.get(inputId) == null) {
                        Slog.e(TvInputManagerService.TAG, "input not found for " + inputId);
                        z = TvInputManagerService.DEBUG;
                    } else {
                        String str;
                        for (SessionState sessionState : userState.sessionStateMap.values()) {
                            if (sessionState.info.getId().equals(inputId) && sessionState.hardwareSessionToken != null) {
                                hardwareInputId = ((SessionState) userState.sessionStateMap.get(sessionState.hardwareSessionToken)).info.getId();
                                break;
                            }
                        }
                        TvInputHardwareManager access$5300 = TvInputManagerService.this.mTvInputHardwareManager;
                        if (hardwareInputId != null) {
                            str = hardwareInputId;
                        } else {
                            str = inputId;
                        }
                        z = access$5300.captureFrame(str, surface, config, callingUid, resolvedUserId);
                        Binder.restoreCallingIdentity(identity);
                    }
                }
                return z;
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public boolean isSingleSessionActive(int userId) throws RemoteException {
            long identity = Binder.clearCallingIdentity();
            int resolvedUserId = TvInputManagerService.this.resolveCallingUserId(Binder.getCallingPid(), Binder.getCallingUid(), userId, "isSingleSessionActive");
            try {
                synchronized (TvInputManagerService.this.mLock) {
                    UserState userState = TvInputManagerService.this.getUserStateLocked(resolvedUserId);
                    if (userState.sessionStateMap.size() == 1) {
                        return true;
                    }
                    if (userState.sessionStateMap.size() == 2) {
                        SessionState[] sessionStates = (SessionState[]) userState.sessionStateMap.values().toArray(new SessionState[0]);
                        if (!(sessionStates[0].hardwareSessionToken == null && sessionStates[1].hardwareSessionToken == null)) {
                            Binder.restoreCallingIdentity(identity);
                            return true;
                        }
                    }
                    Binder.restoreCallingIdentity(identity);
                    return TvInputManagerService.DEBUG;
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        protected void dump(java.io.FileDescriptor r22, java.io.PrintWriter r23, java.lang.String[] r24) {
            /*
            r21 = this;
            r12 = new com.android.internal.util.IndentingPrintWriter;
            r18 = "  ";
            r0 = r23;
            r1 = r18;
            r12.<init>(r0, r1);
            r0 = r21;
            r0 = com.android.server.tv.TvInputManagerService.this;
            r18 = r0;
            r18 = r18.mContext;
            r19 = "android.permission.DUMP";
            r18 = r18.checkCallingOrSelfPermission(r19);
            if (r18 == 0) goto L_0x0048;
        L_0x001d:
            r18 = new java.lang.StringBuilder;
            r18.<init>();
            r19 = "Permission Denial: can't dump TvInputManager from pid=";
            r18 = r18.append(r19);
            r19 = android.os.Binder.getCallingPid();
            r18 = r18.append(r19);
            r19 = ", uid=";
            r18 = r18.append(r19);
            r19 = android.os.Binder.getCallingUid();
            r18 = r18.append(r19);
            r18 = r18.toString();
            r0 = r18;
            r12.println(r0);
        L_0x0047:
            return;
        L_0x0048:
            r0 = r21;
            r0 = com.android.server.tv.TvInputManagerService.this;
            r18 = r0;
            r19 = r18.mLock;
            monitor-enter(r19);
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "User Ids (Current user: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r0 = r21;
            r0 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x016f }
            r20 = r0;
            r20 = r20.mCurrentUserId;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = "):";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r8 = 0;
        L_0x008b:
            r0 = r21;
            r0 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x016f }
            r18 = r0;
            r18 = r18.mUserStates;	 Catch:{ all -> 0x016f }
            r18 = r18.size();	 Catch:{ all -> 0x016f }
            r0 = r18;
            if (r8 >= r0) goto L_0x00b9;
        L_0x009d:
            r0 = r21;
            r0 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x016f }
            r18 = r0;
            r18 = r18.mUserStates;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r16 = r0.keyAt(r8);	 Catch:{ all -> 0x016f }
            r18 = java.lang.Integer.valueOf(r16);	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r8 = r8 + 1;
            goto L_0x008b;
        L_0x00b9:
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            r8 = 0;
        L_0x00bd:
            r0 = r21;
            r0 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x016f }
            r18 = r0;
            r18 = r18.mUserStates;	 Catch:{ all -> 0x016f }
            r18 = r18.size();	 Catch:{ all -> 0x016f }
            r0 = r18;
            if (r8 >= r0) goto L_0x05a3;
        L_0x00cf:
            r0 = r21;
            r0 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x016f }
            r18 = r0;
            r18 = r18.mUserStates;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r16 = r0.keyAt(r8);	 Catch:{ all -> 0x016f }
            r0 = r21;
            r0 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x016f }
            r18 = r0;
            r0 = r18;
            r1 = r16;
            r17 = r0.getUserStateLocked(r1);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "UserState (";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r16;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = "):";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = "inputMap: inputId -> TvInputState";
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = r17.inputMap;	 Catch:{ all -> 0x016f }
            r18 = r18.entrySet();	 Catch:{ all -> 0x016f }
            r9 = r18.iterator();	 Catch:{ all -> 0x016f }
        L_0x0130:
            r18 = r9.hasNext();	 Catch:{ all -> 0x016f }
            if (r18 == 0) goto L_0x0172;
        L_0x0136:
            r7 = r9.next();	 Catch:{ all -> 0x016f }
            r7 = (java.util.Map.Entry) r7;	 Catch:{ all -> 0x016f }
            r20 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r20.<init>();	 Catch:{ all -> 0x016f }
            r18 = r7.getKey();	 Catch:{ all -> 0x016f }
            r18 = (java.lang.String) r18;	 Catch:{ all -> 0x016f }
            r0 = r20;
            r1 = r18;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = ": ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r7.getValue();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            goto L_0x0130;
        L_0x016f:
            r18 = move-exception;
            monitor-exit(r19);	 Catch:{ all -> 0x016f }
            throw r18;
        L_0x0172:
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            r18 = "packageSet:";
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = r17.packageSet;	 Catch:{ all -> 0x016f }
            r9 = r18.iterator();	 Catch:{ all -> 0x016f }
        L_0x0187:
            r18 = r9.hasNext();	 Catch:{ all -> 0x016f }
            if (r18 == 0) goto L_0x0197;
        L_0x018d:
            r11 = r9.next();	 Catch:{ all -> 0x016f }
            r11 = (java.lang.String) r11;	 Catch:{ all -> 0x016f }
            r12.println(r11);	 Catch:{ all -> 0x016f }
            goto L_0x0187;
        L_0x0197:
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            r18 = "clientStateMap: ITvInputClient -> ClientState";
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = r17.clientStateMap;	 Catch:{ all -> 0x016f }
            r18 = r18.entrySet();	 Catch:{ all -> 0x016f }
            r9 = r18.iterator();	 Catch:{ all -> 0x016f }
        L_0x01b0:
            r18 = r9.hasNext();	 Catch:{ all -> 0x016f }
            if (r18 == 0) goto L_0x027c;
        L_0x01b6:
            r5 = r9.next();	 Catch:{ all -> 0x016f }
            r5 = (java.util.Map.Entry) r5;	 Catch:{ all -> 0x016f }
            r3 = r5.getValue();	 Catch:{ all -> 0x016f }
            r3 = (com.android.server.tv.TvInputManagerService.ClientState) r3;	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = r5.getKey();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = ": ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r0 = r18;
            r18 = r0.append(r3);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = "sessionTokens:";
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = r3.sessionTokens;	 Catch:{ all -> 0x016f }
            r10 = r18.iterator();	 Catch:{ all -> 0x016f }
        L_0x0201:
            r18 = r10.hasNext();	 Catch:{ all -> 0x016f }
            if (r18 == 0) goto L_0x022c;
        L_0x0207:
            r15 = r10.next();	 Catch:{ all -> 0x016f }
            r15 = (android.os.IBinder) r15;	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r0 = r18;
            r18 = r0.append(r15);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            goto L_0x0201;
        L_0x022c:
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "clientTokens: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r3.clientToken;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "userId: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r3.userId;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            goto L_0x01b0;
        L_0x027c:
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            r18 = "serviceStateMap: ComponentName -> ServiceState";
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = r17.serviceStateMap;	 Catch:{ all -> 0x016f }
            r18 = r18.entrySet();	 Catch:{ all -> 0x016f }
            r9 = r18.iterator();	 Catch:{ all -> 0x016f }
        L_0x0295:
            r18 = r9.hasNext();	 Catch:{ all -> 0x016f }
            if (r18 == 0) goto L_0x03a9;
        L_0x029b:
            r4 = r9.next();	 Catch:{ all -> 0x016f }
            r4 = (java.util.Map.Entry) r4;	 Catch:{ all -> 0x016f }
            r13 = r4.getValue();	 Catch:{ all -> 0x016f }
            r13 = (com.android.server.tv.TvInputManagerService.ServiceState) r13;	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = r4.getKey();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = ": ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r0 = r18;
            r18 = r0.append(r13);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = "sessionTokens:";
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = r13.sessionTokens;	 Catch:{ all -> 0x016f }
            r10 = r18.iterator();	 Catch:{ all -> 0x016f }
        L_0x02e6:
            r18 = r10.hasNext();	 Catch:{ all -> 0x016f }
            if (r18 == 0) goto L_0x0311;
        L_0x02ec:
            r15 = r10.next();	 Catch:{ all -> 0x016f }
            r15 = (android.os.IBinder) r15;	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r0 = r18;
            r18 = r0.append(r15);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            goto L_0x02e6;
        L_0x0311:
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "service: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r13.service;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "callback: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r13.callback;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "bound: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r13.bound;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "reconnecting: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r13.reconnecting;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            goto L_0x0295;
        L_0x03a9:
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            r18 = "sessionStateMap: ITvInputSession -> SessionState";
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = r17.sessionStateMap;	 Catch:{ all -> 0x016f }
            r18 = r18.entrySet();	 Catch:{ all -> 0x016f }
            r9 = r18.iterator();	 Catch:{ all -> 0x016f }
        L_0x03c2:
            r18 = r9.hasNext();	 Catch:{ all -> 0x016f }
            if (r18 == 0) goto L_0x054a;
        L_0x03c8:
            r6 = r9.next();	 Catch:{ all -> 0x016f }
            r6 = (java.util.Map.Entry) r6;	 Catch:{ all -> 0x016f }
            r14 = r6.getValue();	 Catch:{ all -> 0x016f }
            r14 = (com.android.server.tv.TvInputManagerService.SessionState) r14;	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = r6.getKey();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = ": ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r0 = r18;
            r18 = r0.append(r14);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "info: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r14.info;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "client: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r14.client;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "seq: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r14.seq;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "callingUid: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r14.callingUid;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "userId: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r14.userId;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "sessionToken: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r14.sessionToken;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "session: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r14.session;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "logUri: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r14.logUri;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "hardwareSessionToken: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r14.hardwareSessionToken;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            goto L_0x03c2;
        L_0x054a:
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            r18 = "callbackSet:";
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.increaseIndent();	 Catch:{ all -> 0x016f }
            r18 = r17.callbackSet;	 Catch:{ all -> 0x016f }
            r9 = r18.iterator();	 Catch:{ all -> 0x016f }
        L_0x055f:
            r18 = r9.hasNext();	 Catch:{ all -> 0x016f }
            if (r18 == 0) goto L_0x0575;
        L_0x0565:
            r2 = r9.next();	 Catch:{ all -> 0x016f }
            r2 = (android.media.tv.ITvInputManagerCallback) r2;	 Catch:{ all -> 0x016f }
            r18 = r2.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            goto L_0x055f;
        L_0x0575:
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x016f }
            r18.<init>();	 Catch:{ all -> 0x016f }
            r20 = "mainSessionToken: ";
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r20 = r17.mainSessionToken;	 Catch:{ all -> 0x016f }
            r0 = r18;
            r1 = r20;
            r18 = r0.append(r1);	 Catch:{ all -> 0x016f }
            r18 = r18.toString();	 Catch:{ all -> 0x016f }
            r0 = r18;
            r12.println(r0);	 Catch:{ all -> 0x016f }
            r12.decreaseIndent();	 Catch:{ all -> 0x016f }
            r8 = r8 + 1;
            goto L_0x00bd;
        L_0x05a3:
            monitor-exit(r19);	 Catch:{ all -> 0x016f }
            goto L_0x0047;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.BinderService.dump(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String[]):void");
        }
    }

    private final class ClientState implements DeathRecipient {
        private IBinder clientToken;
        private final List<IBinder> sessionTokens;
        private final int userId;

        ClientState(IBinder clientToken, int userId) {
            this.sessionTokens = new ArrayList();
            this.clientToken = clientToken;
            this.userId = userId;
        }

        public boolean isEmpty() {
            return this.sessionTokens.isEmpty();
        }

        public void binderDied() {
            synchronized (TvInputManagerService.this.mLock) {
                ClientState clientState = (ClientState) TvInputManagerService.this.getUserStateLocked(this.userId).clientStateMap.get(this.clientToken);
                if (clientState != null) {
                    while (clientState.sessionTokens.size() > 0) {
                        TvInputManagerService.this.releaseSessionLocked((IBinder) clientState.sessionTokens.get(0), ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, this.userId);
                    }
                }
                this.clientToken = null;
            }
        }
    }

    private final class HardwareListener implements Listener {
        private HardwareListener() {
        }

        public void onStateChanged(String inputId, int state) {
            synchronized (TvInputManagerService.this.mLock) {
                TvInputManagerService.this.setStateLocked(inputId, state, TvInputManagerService.this.mCurrentUserId);
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onHardwareDeviceAdded(android.media.tv.TvInputHardwareInfo r8) {
            /*
            r7 = this;
            r4 = com.android.server.tv.TvInputManagerService.this;
            r5 = r4.mLock;
            monitor-enter(r5);
            r4 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0048 }
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0048 }
            r6 = r6.mCurrentUserId;	 Catch:{ all -> 0x0048 }
            r3 = r4.getUserStateLocked(r6);	 Catch:{ all -> 0x0048 }
            r4 = r3.serviceStateMap;	 Catch:{ all -> 0x0048 }
            r4 = r4.values();	 Catch:{ all -> 0x0048 }
            r1 = r4.iterator();	 Catch:{ all -> 0x0048 }
        L_0x001f:
            r4 = r1.hasNext();	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x004b;
        L_0x0025:
            r2 = r1.next();	 Catch:{ all -> 0x0048 }
            r2 = (com.android.server.tv.TvInputManagerService.ServiceState) r2;	 Catch:{ all -> 0x0048 }
            r4 = r2.isHardware;	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x001f;
        L_0x0031:
            r4 = r2.service;	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x001f;
        L_0x0037:
            r4 = r2.service;	 Catch:{ RemoteException -> 0x003f }
            r4.notifyHardwareAdded(r8);	 Catch:{ RemoteException -> 0x003f }
            goto L_0x001f;
        L_0x003f:
            r0 = move-exception;
            r4 = "TvInputManagerService";
            r6 = "error in notifyHardwareAdded";
            android.util.Slog.e(r4, r6, r0);	 Catch:{ all -> 0x0048 }
            goto L_0x001f;
        L_0x0048:
            r4 = move-exception;
            monitor-exit(r5);	 Catch:{ all -> 0x0048 }
            throw r4;
        L_0x004b:
            monitor-exit(r5);	 Catch:{ all -> 0x0048 }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.HardwareListener.onHardwareDeviceAdded(android.media.tv.TvInputHardwareInfo):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onHardwareDeviceRemoved(android.media.tv.TvInputHardwareInfo r8) {
            /*
            r7 = this;
            r4 = com.android.server.tv.TvInputManagerService.this;
            r5 = r4.mLock;
            monitor-enter(r5);
            r4 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0048 }
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0048 }
            r6 = r6.mCurrentUserId;	 Catch:{ all -> 0x0048 }
            r3 = r4.getUserStateLocked(r6);	 Catch:{ all -> 0x0048 }
            r4 = r3.serviceStateMap;	 Catch:{ all -> 0x0048 }
            r4 = r4.values();	 Catch:{ all -> 0x0048 }
            r1 = r4.iterator();	 Catch:{ all -> 0x0048 }
        L_0x001f:
            r4 = r1.hasNext();	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x004b;
        L_0x0025:
            r2 = r1.next();	 Catch:{ all -> 0x0048 }
            r2 = (com.android.server.tv.TvInputManagerService.ServiceState) r2;	 Catch:{ all -> 0x0048 }
            r4 = r2.isHardware;	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x001f;
        L_0x0031:
            r4 = r2.service;	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x001f;
        L_0x0037:
            r4 = r2.service;	 Catch:{ RemoteException -> 0x003f }
            r4.notifyHardwareRemoved(r8);	 Catch:{ RemoteException -> 0x003f }
            goto L_0x001f;
        L_0x003f:
            r0 = move-exception;
            r4 = "TvInputManagerService";
            r6 = "error in notifyHardwareRemoved";
            android.util.Slog.e(r4, r6, r0);	 Catch:{ all -> 0x0048 }
            goto L_0x001f;
        L_0x0048:
            r4 = move-exception;
            monitor-exit(r5);	 Catch:{ all -> 0x0048 }
            throw r4;
        L_0x004b:
            monitor-exit(r5);	 Catch:{ all -> 0x0048 }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.HardwareListener.onHardwareDeviceRemoved(android.media.tv.TvInputHardwareInfo):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onHdmiDeviceAdded(android.hardware.hdmi.HdmiDeviceInfo r8) {
            /*
            r7 = this;
            r4 = com.android.server.tv.TvInputManagerService.this;
            r5 = r4.mLock;
            monitor-enter(r5);
            r4 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0048 }
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0048 }
            r6 = r6.mCurrentUserId;	 Catch:{ all -> 0x0048 }
            r3 = r4.getUserStateLocked(r6);	 Catch:{ all -> 0x0048 }
            r4 = r3.serviceStateMap;	 Catch:{ all -> 0x0048 }
            r4 = r4.values();	 Catch:{ all -> 0x0048 }
            r1 = r4.iterator();	 Catch:{ all -> 0x0048 }
        L_0x001f:
            r4 = r1.hasNext();	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x004b;
        L_0x0025:
            r2 = r1.next();	 Catch:{ all -> 0x0048 }
            r2 = (com.android.server.tv.TvInputManagerService.ServiceState) r2;	 Catch:{ all -> 0x0048 }
            r4 = r2.isHardware;	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x001f;
        L_0x0031:
            r4 = r2.service;	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x001f;
        L_0x0037:
            r4 = r2.service;	 Catch:{ RemoteException -> 0x003f }
            r4.notifyHdmiDeviceAdded(r8);	 Catch:{ RemoteException -> 0x003f }
            goto L_0x001f;
        L_0x003f:
            r0 = move-exception;
            r4 = "TvInputManagerService";
            r6 = "error in notifyHdmiDeviceAdded";
            android.util.Slog.e(r4, r6, r0);	 Catch:{ all -> 0x0048 }
            goto L_0x001f;
        L_0x0048:
            r4 = move-exception;
            monitor-exit(r5);	 Catch:{ all -> 0x0048 }
            throw r4;
        L_0x004b:
            monitor-exit(r5);	 Catch:{ all -> 0x0048 }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.HardwareListener.onHdmiDeviceAdded(android.hardware.hdmi.HdmiDeviceInfo):void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onHdmiDeviceRemoved(android.hardware.hdmi.HdmiDeviceInfo r8) {
            /*
            r7 = this;
            r4 = com.android.server.tv.TvInputManagerService.this;
            r5 = r4.mLock;
            monitor-enter(r5);
            r4 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0048 }
            r6 = com.android.server.tv.TvInputManagerService.this;	 Catch:{ all -> 0x0048 }
            r6 = r6.mCurrentUserId;	 Catch:{ all -> 0x0048 }
            r3 = r4.getUserStateLocked(r6);	 Catch:{ all -> 0x0048 }
            r4 = r3.serviceStateMap;	 Catch:{ all -> 0x0048 }
            r4 = r4.values();	 Catch:{ all -> 0x0048 }
            r1 = r4.iterator();	 Catch:{ all -> 0x0048 }
        L_0x001f:
            r4 = r1.hasNext();	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x004b;
        L_0x0025:
            r2 = r1.next();	 Catch:{ all -> 0x0048 }
            r2 = (com.android.server.tv.TvInputManagerService.ServiceState) r2;	 Catch:{ all -> 0x0048 }
            r4 = r2.isHardware;	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x001f;
        L_0x0031:
            r4 = r2.service;	 Catch:{ all -> 0x0048 }
            if (r4 == 0) goto L_0x001f;
        L_0x0037:
            r4 = r2.service;	 Catch:{ RemoteException -> 0x003f }
            r4.notifyHdmiDeviceRemoved(r8);	 Catch:{ RemoteException -> 0x003f }
            goto L_0x001f;
        L_0x003f:
            r0 = move-exception;
            r4 = "TvInputManagerService";
            r6 = "error in notifyHdmiDeviceRemoved";
            android.util.Slog.e(r4, r6, r0);	 Catch:{ all -> 0x0048 }
            goto L_0x001f;
        L_0x0048:
            r4 = move-exception;
            monitor-exit(r5);	 Catch:{ all -> 0x0048 }
            throw r4;
        L_0x004b:
            monitor-exit(r5);	 Catch:{ all -> 0x0048 }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.HardwareListener.onHdmiDeviceRemoved(android.hardware.hdmi.HdmiDeviceInfo):void");
        }

        public void onHdmiDeviceUpdated(String inputId, HdmiDeviceInfo deviceInfo) {
            synchronized (TvInputManagerService.this.mLock) {
                Integer state;
                switch (deviceInfo.getDevicePowerStatus()) {
                    case AppTransition.TRANSIT_NONE /*0*/:
                        state = Integer.valueOf(0);
                        break;
                    case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                    case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                    case C0569H.REPORT_LOSING_FOCUS /*3*/:
                        state = Integer.valueOf(1);
                        break;
                    default:
                        state = null;
                        break;
                }
                if (state != null) {
                    TvInputManagerService.this.setStateLocked(inputId, state.intValue(), TvInputManagerService.this.mCurrentUserId);
                }
            }
        }
    }

    private final class InputServiceConnection implements ServiceConnection {
        private final ComponentName mComponent;
        private final int mUserId;

        private InputServiceConnection(ComponentName component, int userId) {
            this.mComponent = component;
            this.mUserId = userId;
        }

        public void onServiceConnected(ComponentName component, IBinder service) {
            synchronized (TvInputManagerService.this.mLock) {
                UserState userState = TvInputManagerService.this.getUserStateLocked(this.mUserId);
                ServiceState serviceState = (ServiceState) userState.serviceStateMap.get(this.mComponent);
                serviceState.service = ITvInputService.Stub.asInterface(service);
                if (serviceState.isHardware && serviceState.callback == null) {
                    serviceState.callback = new ServiceCallback(this.mComponent, this.mUserId);
                    try {
                        serviceState.service.registerCallback(serviceState.callback);
                    } catch (RemoteException e) {
                        Slog.e(TvInputManagerService.TAG, "error in registerCallback", e);
                    }
                }
                for (IBinder sessionToken : serviceState.sessionTokens) {
                    TvInputManagerService.this.createSessionInternalLocked(serviceState.service, sessionToken, this.mUserId);
                }
                for (TvInputState inputState : userState.inputMap.values()) {
                    if (inputState.info.getComponent().equals(component) && inputState.state != 2) {
                        TvInputManagerService.this.notifyInputStateChangedLocked(userState, inputState.info.getId(), inputState.state, null);
                    }
                }
                if (serviceState.isHardware) {
                    for (TvInputHardwareInfo hardwareInfo : TvInputManagerService.this.mTvInputHardwareManager.getHardwareList()) {
                        try {
                            serviceState.service.notifyHardwareAdded(hardwareInfo);
                        } catch (RemoteException e2) {
                            Slog.e(TvInputManagerService.TAG, "error in notifyHardwareAdded", e2);
                        }
                    }
                    for (HdmiDeviceInfo deviceInfo : TvInputManagerService.this.mTvInputHardwareManager.getHdmiDeviceList()) {
                        try {
                            serviceState.service.notifyHdmiDeviceAdded(deviceInfo);
                        } catch (RemoteException e22) {
                            Slog.e(TvInputManagerService.TAG, "error in notifyHdmiDeviceAdded", e22);
                        }
                    }
                }
            }
        }

        public void onServiceDisconnected(ComponentName component) {
            if (this.mComponent.equals(component)) {
                synchronized (TvInputManagerService.this.mLock) {
                    UserState userState = TvInputManagerService.this.getUserStateLocked(this.mUserId);
                    ServiceState serviceState = (ServiceState) userState.serviceStateMap.get(this.mComponent);
                    if (serviceState != null) {
                        serviceState.reconnecting = true;
                        serviceState.bound = TvInputManagerService.DEBUG;
                        serviceState.service = null;
                        serviceState.callback = null;
                        TvInputManagerService.this.abortPendingCreateSessionRequestsLocked(serviceState, null, this.mUserId);
                        for (TvInputState inputState : userState.inputMap.values()) {
                            if (inputState.info.getComponent().equals(component)) {
                                TvInputManagerService.this.notifyInputStateChangedLocked(userState, inputState.info.getId(), 2, null);
                            }
                        }
                    }
                }
                return;
            }
            throw new IllegalArgumentException("Mismatched ComponentName: " + this.mComponent + " (expected), " + component + " (actual).");
        }
    }

    private final class ServiceCallback extends ITvInputServiceCallback.Stub {
        private final ComponentName mComponent;
        private final int mUserId;

        ServiceCallback(ComponentName component, int userId) {
            this.mComponent = component;
            this.mUserId = userId;
        }

        private void ensureHardwarePermission() {
            if (TvInputManagerService.this.mContext.checkCallingPermission("android.permission.TV_INPUT_HARDWARE") != 0) {
                throw new SecurityException("The caller does not have hardware permission");
            }
        }

        private void ensureValidInput(TvInputInfo inputInfo) {
            if (inputInfo.getId() == null || !this.mComponent.equals(inputInfo.getComponent())) {
                throw new IllegalArgumentException("Invalid TvInputInfo");
            }
        }

        private void addTvInputLocked(TvInputInfo inputInfo) {
            TvInputManagerService.this.getServiceStateLocked(this.mComponent, this.mUserId).inputList.add(inputInfo);
            TvInputManagerService.this.buildTvInputListLocked(this.mUserId, null);
        }

        public void addHardwareTvInput(int deviceId, TvInputInfo inputInfo) {
            ensureHardwarePermission();
            ensureValidInput(inputInfo);
            synchronized (TvInputManagerService.this.mLock) {
                TvInputManagerService.this.mTvInputHardwareManager.addHardwareTvInput(deviceId, inputInfo);
                addTvInputLocked(inputInfo);
            }
        }

        public void addHdmiTvInput(int id, TvInputInfo inputInfo) {
            ensureHardwarePermission();
            ensureValidInput(inputInfo);
            synchronized (TvInputManagerService.this.mLock) {
                TvInputManagerService.this.mTvInputHardwareManager.addHdmiTvInput(id, inputInfo);
                addTvInputLocked(inputInfo);
            }
        }

        public void removeTvInput(String inputId) {
            ensureHardwarePermission();
            synchronized (TvInputManagerService.this.mLock) {
                ServiceState serviceState = TvInputManagerService.this.getServiceStateLocked(this.mComponent, this.mUserId);
                boolean removed = TvInputManagerService.DEBUG;
                Iterator<TvInputInfo> it = serviceState.inputList.iterator();
                while (it.hasNext()) {
                    if (((TvInputInfo) it.next()).getId().equals(inputId)) {
                        it.remove();
                        removed = true;
                        break;
                    }
                }
                if (removed) {
                    TvInputManagerService.this.buildTvInputListLocked(this.mUserId, null);
                    TvInputManagerService.this.mTvInputHardwareManager.removeTvInput(inputId);
                } else {
                    Slog.e(TvInputManagerService.TAG, "failed to remove input " + inputId);
                }
            }
        }
    }

    private final class ServiceState {
        private boolean bound;
        private ServiceCallback callback;
        private final ComponentName component;
        private final ServiceConnection connection;
        private final List<TvInputInfo> inputList;
        private final boolean isHardware;
        private boolean reconnecting;
        private ITvInputService service;
        private final List<IBinder> sessionTokens;

        private ServiceState(ComponentName component, int userId) {
            this.sessionTokens = new ArrayList();
            this.inputList = new ArrayList();
            this.component = component;
            this.connection = new InputServiceConnection(component, userId, null);
            this.isHardware = TvInputManagerService.hasHardwarePermission(TvInputManagerService.this.mContext.getPackageManager(), component);
        }
    }

    private final class SessionCallback extends ITvInputSessionCallback.Stub {
        private final InputChannel[] mChannels;
        private final SessionState mSessionState;

        SessionCallback(SessionState sessionState, InputChannel[] channels) {
            this.mSessionState = sessionState;
            this.mChannels = channels;
        }

        public void onSessionCreated(ITvInputSession session, IBinder harewareSessionToken) {
            synchronized (TvInputManagerService.this.mLock) {
                this.mSessionState.session = session;
                this.mSessionState.hardwareSessionToken = harewareSessionToken;
                if (session == null || !addSessionTokenToClientStateLocked(session)) {
                    TvInputManagerService.this.removeSessionStateLocked(this.mSessionState.sessionToken, this.mSessionState.userId);
                    TvInputManagerService.this.sendSessionTokenToClientLocked(this.mSessionState.client, this.mSessionState.info.getId(), null, null, this.mSessionState.seq);
                } else {
                    TvInputManagerService.this.sendSessionTokenToClientLocked(this.mSessionState.client, this.mSessionState.info.getId(), this.mSessionState.sessionToken, this.mChannels[0], this.mSessionState.seq);
                }
                this.mChannels[0].dispose();
            }
        }

        private boolean addSessionTokenToClientStateLocked(ITvInputSession session) {
            try {
                session.asBinder().linkToDeath(this.mSessionState, 0);
                IBinder clientToken = this.mSessionState.client.asBinder();
                UserState userState = TvInputManagerService.this.getUserStateLocked(this.mSessionState.userId);
                ClientState clientState = (ClientState) userState.clientStateMap.get(clientToken);
                if (clientState == null) {
                    clientState = new ClientState(clientToken, this.mSessionState.userId);
                    try {
                        clientToken.linkToDeath(clientState, 0);
                        userState.clientStateMap.put(clientToken, clientState);
                    } catch (RemoteException e) {
                        Slog.e(TvInputManagerService.TAG, "client process has already died", e);
                        return TvInputManagerService.DEBUG;
                    }
                }
                clientState.sessionTokens.add(this.mSessionState.sessionToken);
                return true;
            } catch (RemoteException e2) {
                Slog.e(TvInputManagerService.TAG, "session process has already died", e2);
                return TvInputManagerService.DEBUG;
            }
        }

        public void onChannelRetuned(Uri channelUri) {
            synchronized (TvInputManagerService.this.mLock) {
                if (this.mSessionState.session == null || this.mSessionState.client == null) {
                    return;
                }
                try {
                    this.mSessionState.client.onChannelRetuned(channelUri, this.mSessionState.seq);
                } catch (RemoteException e) {
                    Slog.e(TvInputManagerService.TAG, "error in onChannelRetuned", e);
                }
            }
        }

        public void onTracksChanged(List<TvTrackInfo> tracks) {
            synchronized (TvInputManagerService.this.mLock) {
                if (this.mSessionState.session == null || this.mSessionState.client == null) {
                    return;
                }
                try {
                    this.mSessionState.client.onTracksChanged(tracks, this.mSessionState.seq);
                } catch (RemoteException e) {
                    Slog.e(TvInputManagerService.TAG, "error in onTracksChanged", e);
                }
            }
        }

        public void onTrackSelected(int type, String trackId) {
            synchronized (TvInputManagerService.this.mLock) {
                if (this.mSessionState.session == null || this.mSessionState.client == null) {
                    return;
                }
                try {
                    this.mSessionState.client.onTrackSelected(type, trackId, this.mSessionState.seq);
                } catch (RemoteException e) {
                    Slog.e(TvInputManagerService.TAG, "error in onTrackSelected", e);
                }
            }
        }

        public void onVideoAvailable() {
            synchronized (TvInputManagerService.this.mLock) {
                if (this.mSessionState.session == null || this.mSessionState.client == null) {
                    return;
                }
                try {
                    this.mSessionState.client.onVideoAvailable(this.mSessionState.seq);
                } catch (RemoteException e) {
                    Slog.e(TvInputManagerService.TAG, "error in onVideoAvailable", e);
                }
            }
        }

        public void onVideoUnavailable(int reason) {
            synchronized (TvInputManagerService.this.mLock) {
                if (this.mSessionState.session == null || this.mSessionState.client == null) {
                    return;
                }
                try {
                    this.mSessionState.client.onVideoUnavailable(reason, this.mSessionState.seq);
                } catch (RemoteException e) {
                    Slog.e(TvInputManagerService.TAG, "error in onVideoUnavailable", e);
                }
            }
        }

        public void onContentAllowed() {
            synchronized (TvInputManagerService.this.mLock) {
                if (this.mSessionState.session == null || this.mSessionState.client == null) {
                    return;
                }
                try {
                    this.mSessionState.client.onContentAllowed(this.mSessionState.seq);
                } catch (RemoteException e) {
                    Slog.e(TvInputManagerService.TAG, "error in onContentAllowed", e);
                }
            }
        }

        public void onContentBlocked(String rating) {
            synchronized (TvInputManagerService.this.mLock) {
                if (this.mSessionState.session == null || this.mSessionState.client == null) {
                    return;
                }
                try {
                    this.mSessionState.client.onContentBlocked(rating, this.mSessionState.seq);
                } catch (RemoteException e) {
                    Slog.e(TvInputManagerService.TAG, "error in onContentBlocked", e);
                }
            }
        }

        public void onLayoutSurface(int left, int top, int right, int bottom) {
            synchronized (TvInputManagerService.this.mLock) {
                if (this.mSessionState.session == null || this.mSessionState.client == null) {
                    return;
                }
                try {
                    this.mSessionState.client.onLayoutSurface(left, top, right, bottom, this.mSessionState.seq);
                } catch (RemoteException e) {
                    Slog.e(TvInputManagerService.TAG, "error in onLayoutSurface", e);
                }
            }
        }

        public void onSessionEvent(String eventType, Bundle eventArgs) {
            synchronized (TvInputManagerService.this.mLock) {
                if (this.mSessionState.session == null || this.mSessionState.client == null) {
                    return;
                }
                try {
                    this.mSessionState.client.onSessionEvent(eventType, eventArgs, this.mSessionState.seq);
                } catch (RemoteException e) {
                    Slog.e(TvInputManagerService.TAG, "error in onSessionEvent", e);
                }
            }
        }
    }

    private static class SessionNotFoundException extends IllegalArgumentException {
        public SessionNotFoundException(String name) {
            super(name);
        }
    }

    private final class SessionState implements DeathRecipient {
        private final int callingUid;
        private final ITvInputClient client;
        private IBinder hardwareSessionToken;
        private final TvInputInfo info;
        private Uri logUri;
        private final int seq;
        private ITvInputSession session;
        private final IBinder sessionToken;
        private final int userId;

        private SessionState(IBinder sessionToken, TvInputInfo info, ITvInputClient client, int seq, int callingUid, int userId) {
            this.sessionToken = sessionToken;
            this.info = info;
            this.client = client;
            this.seq = seq;
            this.callingUid = callingUid;
            this.userId = userId;
        }

        public void binderDied() {
            synchronized (TvInputManagerService.this.mLock) {
                this.session = null;
                if (this.client != null) {
                    try {
                        this.client.onSessionReleased(this.seq);
                    } catch (RemoteException e) {
                        Slog.e(TvInputManagerService.TAG, "error in onSessionReleased", e);
                    }
                }
                for (SessionState sessionState : TvInputManagerService.this.getUserStateLocked(this.userId).sessionStateMap.values()) {
                    if (this.sessionToken == sessionState.hardwareSessionToken) {
                        TvInputManagerService.this.releaseSessionLocked(sessionState.sessionToken, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, this.userId);
                        try {
                            sessionState.client.onSessionReleased(sessionState.seq);
                        } catch (RemoteException e2) {
                            Slog.e(TvInputManagerService.TAG, "error in onSessionReleased", e2);
                        }
                    }
                }
                TvInputManagerService.this.removeSessionStateLocked(this.sessionToken, this.userId);
            }
        }
    }

    private static final class TvInputState {
        private TvInputInfo info;
        private int state;

        private TvInputState() {
            this.state = 0;
        }

        public String toString() {
            return "info: " + this.info + "; state: " + this.state;
        }
    }

    private static final class UserState {
        private final Set<ITvInputManagerCallback> callbackSet;
        private final Map<IBinder, ClientState> clientStateMap;
        private final List<TvContentRatingSystemInfo> contentRatingSystemList;
        private Map<String, TvInputState> inputMap;
        private IBinder mainSessionToken;
        private final Set<String> packageSet;
        private final PersistentDataStore persistentDataStore;
        private final Map<ComponentName, ServiceState> serviceStateMap;
        private final Map<IBinder, SessionState> sessionStateMap;

        private UserState(Context context, int userId) {
            this.inputMap = new HashMap();
            this.packageSet = new HashSet();
            this.contentRatingSystemList = new ArrayList();
            this.clientStateMap = new HashMap();
            this.serviceStateMap = new HashMap();
            this.sessionStateMap = new HashMap();
            this.callbackSet = new HashSet();
            this.mainSessionToken = null;
            this.persistentDataStore = new PersistentDataStore(context, userId);
        }
    }

    private static final class WatchLogHandler extends Handler {
        private static final int MSG_LOG_WATCH_END = 2;
        private static final int MSG_LOG_WATCH_START = 1;
        private final ContentResolver mContentResolver;

        public WatchLogHandler(ContentResolver contentResolver, Looper looper) {
            super(looper);
            this.mContentResolver = contentResolver;
        }

        public void handleMessage(Message msg) {
            SomeArgs args;
            IBinder sessionToken;
            ContentValues values;
            switch (msg.what) {
                case MSG_LOG_WATCH_START /*1*/:
                    args = msg.obj;
                    String packageName = args.arg1;
                    long watchStartTime = ((Long) args.arg2).longValue();
                    long channelId = ((Long) args.arg3).longValue();
                    Bundle tuneParams = args.arg4;
                    sessionToken = args.arg5;
                    values = new ContentValues();
                    values.put("package_name", packageName);
                    values.put("watch_start_time_utc_millis", Long.valueOf(watchStartTime));
                    values.put("channel_id", Long.valueOf(channelId));
                    if (tuneParams != null) {
                        values.put("tune_params", encodeTuneParams(tuneParams));
                    }
                    values.put("session_token", sessionToken.toString());
                    this.mContentResolver.insert(WatchedPrograms.CONTENT_URI, values);
                    args.recycle();
                case MSG_LOG_WATCH_END /*2*/:
                    args = (SomeArgs) msg.obj;
                    sessionToken = (IBinder) args.arg1;
                    long watchEndTime = ((Long) args.arg2).longValue();
                    values = new ContentValues();
                    values.put("watch_end_time_utc_millis", Long.valueOf(watchEndTime));
                    values.put("session_token", sessionToken.toString());
                    this.mContentResolver.insert(WatchedPrograms.CONTENT_URI, values);
                    args.recycle();
                default:
                    Slog.w(TvInputManagerService.TAG, "Unhandled message code: " + msg.what);
            }
        }

        private String encodeTuneParams(Bundle tuneParams) {
            StringBuilder builder = new StringBuilder();
            Iterator<String> it = tuneParams.keySet().iterator();
            while (it.hasNext()) {
                String key = (String) it.next();
                Object value = tuneParams.get(key);
                if (value != null) {
                    builder.append(replaceEscapeCharacters(key));
                    builder.append("=");
                    builder.append(replaceEscapeCharacters(value.toString()));
                    if (it.hasNext()) {
                        builder.append(", ");
                    }
                }
            }
            return builder.toString();
        }

        private String replaceEscapeCharacters(String src) {
            String ENCODING_TARGET_CHARACTERS = "%=,";
            StringBuilder builder = new StringBuilder();
            char[] arr$ = src.toCharArray();
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += MSG_LOG_WATCH_START) {
                char ch = arr$[i$];
                if ("%=,".indexOf(ch) >= 0) {
                    builder.append('%');
                }
                builder.append(ch);
            }
            return builder.toString();
        }
    }

    public TvInputManagerService(Context context) {
        super(context);
        this.mLock = new Object();
        this.mCurrentUserId = 0;
        this.mUserStates = new SparseArray();
        this.mContext = context;
        this.mContentResolver = context.getContentResolver();
        this.mWatchLogHandler = new WatchLogHandler(this.mContentResolver, IoThread.get().getLooper());
        this.mTvInputHardwareManager = new TvInputHardwareManager(context, new HardwareListener());
        synchronized (this.mLock) {
            this.mUserStates.put(this.mCurrentUserId, new UserState(this.mCurrentUserId, null));
        }
    }

    public void onStart() {
        publishBinderService("tv_input", new BinderService());
    }

    public void onBootPhase(int phase) {
        if (phase == SystemService.PHASE_SYSTEM_SERVICES_READY) {
            registerBroadcastReceivers();
        } else if (phase == NetdResponseCode.InterfaceChange) {
            synchronized (this.mLock) {
                buildTvInputListLocked(this.mCurrentUserId, null);
                buildTvContentRatingSystemListLocked(this.mCurrentUserId);
            }
        }
        this.mTvInputHardwareManager.onBootPhase(phase);
    }

    private void registerBroadcastReceivers() {
        new C05311().register(this.mContext, null, UserHandle.ALL, true);
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.USER_SWITCHED");
        intentFilter.addAction("android.intent.action.USER_REMOVED");
        this.mContext.registerReceiverAsUser(new C05322(), UserHandle.ALL, intentFilter, null, null);
    }

    private static boolean hasHardwarePermission(PackageManager pm, ComponentName component) {
        return pm.checkPermission("android.permission.TV_INPUT_HARDWARE", component.getPackageName()) == 0 ? true : DEBUG;
    }

    private void buildTvInputListLocked(int userId, String[] updatedPackages) {
        Exception e;
        UserState userState = getUserStateLocked(userId);
        userState.packageSet.clear();
        PackageManager pm = this.mContext.getPackageManager();
        List<ResolveInfo> services = pm.queryIntentServices(new Intent("android.media.tv.TvInputService"), 132);
        List<TvInputInfo> inputList = new ArrayList();
        for (ResolveInfo ri : services) {
            ComponentName component;
            ServiceState serviceState;
            ServiceInfo si = ri.serviceInfo;
            if ("android.permission.BIND_TV_INPUT".equals(si.permission)) {
                component = new ComponentName(si.packageName, si.name);
                if (hasHardwarePermission(pm, component)) {
                    serviceState = (ServiceState) userState.serviceStateMap.get(component);
                    if (serviceState == null) {
                        userState.serviceStateMap.put(component, new ServiceState(component, userId, null));
                        updateServiceConnectionLocked(component, userId);
                    } else {
                        inputList.addAll(serviceState.inputList);
                    }
                } else {
                    try {
                        inputList.add(TvInputInfo.createTvInputInfo(this.mContext, ri));
                    } catch (XmlPullParserException e2) {
                        e = e2;
                        Slog.e(TAG, "failed to load TV input " + si.name, e);
                    } catch (IOException e3) {
                        e = e3;
                        Slog.e(TAG, "failed to load TV input " + si.name, e);
                    }
                }
                userState.packageSet.add(si.packageName);
            } else {
                Slog.w(TAG, "Skipping TV input " + si.name + ": it does not require the permission " + "android.permission.BIND_TV_INPUT");
            }
        }
        Map<String, TvInputState> inputMap = new HashMap();
        for (TvInputInfo info : inputList) {
            TvInputState state = (TvInputState) userState.inputMap.get(info.getId());
            if (state == null) {
                TvInputState tvInputState = new TvInputState();
            }
            state.info = info;
            inputMap.put(info.getId(), state);
        }
        for (String inputId : inputMap.keySet()) {
            if (!userState.inputMap.containsKey(inputId)) {
                notifyInputAddedLocked(userState, inputId);
            } else if (updatedPackages != null) {
                component = ((TvInputState) inputMap.get(inputId)).info.getComponent();
                for (String updatedPackage : updatedPackages) {
                    if (component.getPackageName().equals(updatedPackage)) {
                        updateServiceConnectionLocked(component, userId);
                        notifyInputUpdatedLocked(userState, inputId);
                        break;
                    }
                }
            }
        }
        for (String inputId2 : userState.inputMap.keySet()) {
            if (!inputMap.containsKey(inputId2)) {
                serviceState = (ServiceState) userState.serviceStateMap.get(((TvInputState) userState.inputMap.get(inputId2)).info.getComponent());
                if (serviceState != null) {
                    abortPendingCreateSessionRequestsLocked(serviceState, inputId2, userId);
                }
                notifyInputRemovedLocked(userState, inputId2);
            }
        }
        userState.inputMap.clear();
        userState.inputMap = inputMap;
    }

    private void buildTvContentRatingSystemListLocked(int userId) {
        UserState userState = getUserStateLocked(userId);
        userState.contentRatingSystemList.clear();
        for (ResolveInfo resolveInfo : this.mContext.getPackageManager().queryBroadcastReceivers(new Intent("android.media.tv.action.QUERY_CONTENT_RATING_SYSTEMS"), DumpState.DUMP_PROVIDERS)) {
            ActivityInfo receiver = resolveInfo.activityInfo;
            Bundle metaData = receiver.metaData;
            if (metaData != null) {
                int xmlResId = metaData.getInt("android.media.tv.metadata.CONTENT_RATING_SYSTEMS");
                if (xmlResId == 0) {
                    Slog.w(TAG, "Missing meta-data 'android.media.tv.metadata.CONTENT_RATING_SYSTEMS' on receiver " + receiver.packageName + "/" + receiver.name);
                } else {
                    userState.contentRatingSystemList.add(TvContentRatingSystemInfo.createTvContentRatingSystemInfo(xmlResId, receiver.applicationInfo));
                }
            }
        }
    }

    private void switchUser(int userId) {
        synchronized (this.mLock) {
            if (this.mCurrentUserId == userId) {
                return;
            }
            this.mCurrentUserId = userId;
            UserState userState = (UserState) this.mUserStates.get(userId);
            if (userState == null) {
                userState = new UserState(userId, null);
            }
            this.mUserStates.put(userId, userState);
            buildTvInputListLocked(userId, null);
            buildTvContentRatingSystemListLocked(userId);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void removeUser(int r9) {
        /*
        r8 = this;
        r6 = r8.mLock;
        monitor-enter(r6);
        r5 = r8.mUserStates;	 Catch:{ all -> 0x003e }
        r4 = r5.get(r9);	 Catch:{ all -> 0x003e }
        r4 = (com.android.server.tv.TvInputManagerService.UserState) r4;	 Catch:{ all -> 0x003e }
        if (r4 != 0) goto L_0x000f;
    L_0x000d:
        monitor-exit(r6);	 Catch:{ all -> 0x003e }
    L_0x000e:
        return;
    L_0x000f:
        r5 = r4.sessionStateMap;	 Catch:{ all -> 0x003e }
        r5 = r5.values();	 Catch:{ all -> 0x003e }
        r1 = r5.iterator();	 Catch:{ all -> 0x003e }
    L_0x001b:
        r5 = r1.hasNext();	 Catch:{ all -> 0x003e }
        if (r5 == 0) goto L_0x0041;
    L_0x0021:
        r3 = r1.next();	 Catch:{ all -> 0x003e }
        r3 = (com.android.server.tv.TvInputManagerService.SessionState) r3;	 Catch:{ all -> 0x003e }
        r5 = r3.session;	 Catch:{ all -> 0x003e }
        if (r5 == 0) goto L_0x001b;
    L_0x002d:
        r5 = r3.session;	 Catch:{ RemoteException -> 0x0035 }
        r5.release();	 Catch:{ RemoteException -> 0x0035 }
        goto L_0x001b;
    L_0x0035:
        r0 = move-exception;
        r5 = "TvInputManagerService";
        r7 = "error in release";
        android.util.Slog.e(r5, r7, r0);	 Catch:{ all -> 0x003e }
        goto L_0x001b;
    L_0x003e:
        r5 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x003e }
        throw r5;
    L_0x0041:
        r5 = r4.sessionStateMap;	 Catch:{ all -> 0x003e }
        r5.clear();	 Catch:{ all -> 0x003e }
        r5 = r4.serviceStateMap;	 Catch:{ all -> 0x003e }
        r5 = r5.values();	 Catch:{ all -> 0x003e }
        r1 = r5.iterator();	 Catch:{ all -> 0x003e }
    L_0x0054:
        r5 = r1.hasNext();	 Catch:{ all -> 0x003e }
        if (r5 == 0) goto L_0x0084;
    L_0x005a:
        r2 = r1.next();	 Catch:{ all -> 0x003e }
        r2 = (com.android.server.tv.TvInputManagerService.ServiceState) r2;	 Catch:{ all -> 0x003e }
        r5 = r2.callback;	 Catch:{ all -> 0x003e }
        if (r5 == 0) goto L_0x0071;
    L_0x0066:
        r5 = r2.service;	 Catch:{ RemoteException -> 0x007b }
        r7 = r2.callback;	 Catch:{ RemoteException -> 0x007b }
        r5.unregisterCallback(r7);	 Catch:{ RemoteException -> 0x007b }
    L_0x0071:
        r5 = r8.mContext;	 Catch:{ all -> 0x003e }
        r7 = r2.connection;	 Catch:{ all -> 0x003e }
        r5.unbindService(r7);	 Catch:{ all -> 0x003e }
        goto L_0x0054;
    L_0x007b:
        r0 = move-exception;
        r5 = "TvInputManagerService";
        r7 = "error in unregisterCallback";
        android.util.Slog.e(r5, r7, r0);	 Catch:{ all -> 0x003e }
        goto L_0x0071;
    L_0x0084:
        r5 = r4.serviceStateMap;	 Catch:{ all -> 0x003e }
        r5.clear();	 Catch:{ all -> 0x003e }
        r5 = r4.inputMap;	 Catch:{ all -> 0x003e }
        r5.clear();	 Catch:{ all -> 0x003e }
        r5 = r4.packageSet;	 Catch:{ all -> 0x003e }
        r5.clear();	 Catch:{ all -> 0x003e }
        r5 = r4.contentRatingSystemList;	 Catch:{ all -> 0x003e }
        r5.clear();	 Catch:{ all -> 0x003e }
        r5 = r4.clientStateMap;	 Catch:{ all -> 0x003e }
        r5.clear();	 Catch:{ all -> 0x003e }
        r5 = r4.callbackSet;	 Catch:{ all -> 0x003e }
        r5.clear();	 Catch:{ all -> 0x003e }
        r5 = 0;
        r4.mainSessionToken = r5;	 Catch:{ all -> 0x003e }
        r5 = r8.mUserStates;	 Catch:{ all -> 0x003e }
        r5.remove(r9);	 Catch:{ all -> 0x003e }
        monitor-exit(r6);	 Catch:{ all -> 0x003e }
        goto L_0x000e;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputManagerService.removeUser(int):void");
    }

    private UserState getUserStateLocked(int userId) {
        UserState userState = (UserState) this.mUserStates.get(userId);
        if (userState != null) {
            return userState;
        }
        throw new IllegalStateException("User state not found for user ID " + userId);
    }

    private ServiceState getServiceStateLocked(ComponentName component, int userId) {
        ServiceState serviceState = (ServiceState) getUserStateLocked(userId).serviceStateMap.get(component);
        if (serviceState != null) {
            return serviceState;
        }
        throw new IllegalStateException("Service state not found for " + component + " (userId=" + userId + ")");
    }

    private SessionState getSessionStateLocked(IBinder sessionToken, int callingUid, int userId) {
        SessionState sessionState = (SessionState) getUserStateLocked(userId).sessionStateMap.get(sessionToken);
        if (sessionState == null) {
            throw new SessionNotFoundException("Session state not found for token " + sessionToken);
        } else if (callingUid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || callingUid == sessionState.callingUid) {
            return sessionState;
        } else {
            throw new SecurityException("Illegal access to the session with token " + sessionToken + " from uid " + callingUid);
        }
    }

    private ITvInputSession getSessionLocked(IBinder sessionToken, int callingUid, int userId) {
        return getSessionLocked(getSessionStateLocked(sessionToken, callingUid, userId));
    }

    private ITvInputSession getSessionLocked(SessionState sessionState) {
        ITvInputSession session = sessionState.session;
        if (session != null) {
            return session;
        }
        throw new IllegalStateException("Session not yet created for token " + sessionState.sessionToken);
    }

    private int resolveCallingUserId(int callingPid, int callingUid, int requestedUserId, String methodName) {
        return ActivityManager.handleIncomingUser(callingPid, callingUid, requestedUserId, DEBUG, DEBUG, methodName, null);
    }

    private static boolean shouldMaintainConnection(ServiceState serviceState) {
        return (!serviceState.sessionTokens.isEmpty() || serviceState.isHardware) ? true : DEBUG;
    }

    private void updateServiceConnectionLocked(ComponentName component, int userId) {
        UserState userState = getUserStateLocked(userId);
        ServiceState serviceState = (ServiceState) userState.serviceStateMap.get(component);
        if (serviceState != null) {
            if (serviceState.reconnecting) {
                if (serviceState.sessionTokens.isEmpty()) {
                    serviceState.reconnecting = DEBUG;
                } else {
                    return;
                }
            }
            boolean maintainConnection = shouldMaintainConnection(serviceState);
            if (serviceState.service == null && maintainConnection && userId == this.mCurrentUserId) {
                if (!serviceState.bound) {
                    serviceState.bound = this.mContext.bindServiceAsUser(new Intent("android.media.tv.TvInputService").setComponent(component), serviceState.connection, 1, new UserHandle(userId));
                }
            } else if (serviceState.service != null && !maintainConnection) {
                this.mContext.unbindService(serviceState.connection);
                userState.serviceStateMap.remove(component);
            }
        }
    }

    private void abortPendingCreateSessionRequestsLocked(ServiceState serviceState, String inputId, int userId) {
        UserState userState = getUserStateLocked(userId);
        List<SessionState> sessionsToAbort = new ArrayList();
        for (IBinder sessionToken : serviceState.sessionTokens) {
            SessionState sessionState = (SessionState) userState.sessionStateMap.get(sessionToken);
            if (sessionState.session == null && (inputId == null || sessionState.info.getId().equals(inputId))) {
                sessionsToAbort.add(sessionState);
            }
        }
        for (SessionState sessionState2 : sessionsToAbort) {
            removeSessionStateLocked(sessionState2.sessionToken, sessionState2.userId);
            sendSessionTokenToClientLocked(sessionState2.client, sessionState2.info.getId(), null, null, sessionState2.seq);
        }
        updateServiceConnectionLocked(serviceState.component, userId);
    }

    private void createSessionInternalLocked(ITvInputService service, IBinder sessionToken, int userId) {
        SessionState sessionState = (SessionState) getUserStateLocked(userId).sessionStateMap.get(sessionToken);
        InputChannel[] channels = InputChannel.openInputChannelPair(sessionToken.toString());
        try {
            service.createSession(channels[1], new SessionCallback(sessionState, channels), sessionState.info.getId());
        } catch (RemoteException e) {
            Slog.e(TAG, "error in createSession", e);
            removeSessionStateLocked(sessionToken, userId);
            sendSessionTokenToClientLocked(sessionState.client, sessionState.info.getId(), null, null, sessionState.seq);
        }
        channels[1].dispose();
    }

    private void sendSessionTokenToClientLocked(ITvInputClient client, String inputId, IBinder sessionToken, InputChannel channel, int seq) {
        try {
            client.onSessionCreated(inputId, sessionToken, channel, seq);
        } catch (RemoteException e) {
            Slog.e(TAG, "error in onSessionCreated", e);
        }
    }

    private void releaseSessionLocked(IBinder sessionToken, int callingUid, int userId) {
        Exception e;
        try {
            SessionState sessionState = getSessionStateLocked(sessionToken, callingUid, userId);
            if (sessionState.session != null) {
                if (sessionToken == getUserStateLocked(userId).mainSessionToken) {
                    setMainLocked(sessionToken, DEBUG, callingUid, userId);
                }
                sessionState.session.release();
            }
            if (sessionState != null) {
                sessionState.session = null;
            }
        } catch (Exception e2) {
            e = e2;
            try {
                Slog.e(TAG, "error in releaseSession", e);
                if (null != null) {
                    null.session = null;
                }
                removeSessionStateLocked(sessionToken, userId);
            } catch (Throwable th) {
                if (null != null) {
                    null.session = null;
                }
            }
        } catch (Exception e22) {
            e = e22;
            Slog.e(TAG, "error in releaseSession", e);
            if (null != null) {
                null.session = null;
            }
            removeSessionStateLocked(sessionToken, userId);
        }
        removeSessionStateLocked(sessionToken, userId);
    }

    private void removeSessionStateLocked(IBinder sessionToken, int userId) {
        UserState userState = getUserStateLocked(userId);
        if (sessionToken == userState.mainSessionToken) {
            userState.mainSessionToken = null;
        }
        SessionState sessionState = (SessionState) userState.sessionStateMap.remove(sessionToken);
        if (sessionState != null) {
            ClientState clientState = (ClientState) userState.clientStateMap.get(sessionState.client.asBinder());
            if (clientState != null) {
                clientState.sessionTokens.remove(sessionToken);
                if (clientState.isEmpty()) {
                    userState.clientStateMap.remove(sessionState.client.asBinder());
                }
            }
            TvInputInfo info = sessionState.info;
            if (info != null) {
                ServiceState serviceState = (ServiceState) userState.serviceStateMap.get(info.getComponent());
                if (serviceState != null) {
                    serviceState.sessionTokens.remove(sessionToken);
                }
            }
            updateServiceConnectionLocked(sessionState.info.getComponent(), userId);
            SomeArgs args = SomeArgs.obtain();
            args.arg1 = sessionToken;
            args.arg2 = Long.valueOf(System.currentTimeMillis());
            this.mWatchLogHandler.obtainMessage(2, args).sendToTarget();
        }
    }

    private void setMainLocked(IBinder sessionToken, boolean isMain, int callingUid, int userId) {
        Exception e;
        try {
            SessionState sessionState = getSessionStateLocked(sessionToken, callingUid, userId);
            if (sessionState.hardwareSessionToken != null) {
                sessionState = getSessionStateLocked(sessionState.hardwareSessionToken, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, userId);
            }
            if (getServiceStateLocked(sessionState.info.getComponent(), userId).isHardware) {
                getSessionLocked(sessionState).setMain(isMain);
            }
        } catch (RemoteException e2) {
            e = e2;
            Slog.e(TAG, "error in setMain", e);
        } catch (SessionNotFoundException e3) {
            e = e3;
            Slog.e(TAG, "error in setMain", e);
        }
    }

    private void notifyInputAddedLocked(UserState userState, String inputId) {
        for (ITvInputManagerCallback callback : userState.callbackSet) {
            try {
                callback.onInputAdded(inputId);
            } catch (RemoteException e) {
                Slog.e(TAG, "failed to report added input to callback", e);
            }
        }
    }

    private void notifyInputRemovedLocked(UserState userState, String inputId) {
        for (ITvInputManagerCallback callback : userState.callbackSet) {
            try {
                callback.onInputRemoved(inputId);
            } catch (RemoteException e) {
                Slog.e(TAG, "failed to report removed input to callback", e);
            }
        }
    }

    private void notifyInputUpdatedLocked(UserState userState, String inputId) {
        for (ITvInputManagerCallback callback : userState.callbackSet) {
            try {
                callback.onInputUpdated(inputId);
            } catch (RemoteException e) {
                Slog.e(TAG, "failed to report updated input to callback", e);
            }
        }
    }

    private void notifyInputStateChangedLocked(UserState userState, String inputId, int state, ITvInputManagerCallback targetCallback) {
        if (targetCallback == null) {
            for (ITvInputManagerCallback callback : userState.callbackSet) {
                try {
                    callback.onInputStateChanged(inputId, state);
                } catch (RemoteException e) {
                    Slog.e(TAG, "failed to report state change to callback", e);
                }
            }
            return;
        }
        try {
            targetCallback.onInputStateChanged(inputId, state);
        } catch (RemoteException e2) {
            Slog.e(TAG, "failed to report state change to callback", e2);
        }
    }

    private void setStateLocked(String inputId, int state, int userId) {
        UserState userState = getUserStateLocked(userId);
        TvInputState inputState = (TvInputState) userState.inputMap.get(inputId);
        ServiceState serviceState = (ServiceState) userState.serviceStateMap.get(inputState.info.getComponent());
        int oldState = inputState.state;
        inputState.state = state;
        if ((serviceState == null || serviceState.service != null || !shouldMaintainConnection(serviceState)) && oldState != state) {
            notifyInputStateChangedLocked(userState, inputId, state, null);
        }
    }
}
