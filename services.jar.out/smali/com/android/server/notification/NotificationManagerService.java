package com.android.server.notification;

import android.app.ActivityManager;
import android.app.ActivityManagerNative;
import android.app.AppGlobals;
import android.app.AppOpsManager;
import android.app.IActivityManager;
import android.app.INotificationManager.Stub;
import android.app.ITransientNotification;
import android.app.Notification;
import android.app.PendingIntent.CanceledException;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ParceledListSlice;
import android.content.res.Resources;
import android.content.res.Resources.NotFoundException;
import android.database.ContentObserver;
import android.media.AudioAttributes;
import android.media.AudioAttributes.Builder;
import android.media.AudioManager;
import android.media.AudioSystem;
import android.media.IRingtonePlayer;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Looper;
import android.os.Message;
import android.os.Process;
import android.os.RemoteException;
import android.os.UserHandle;
import android.os.Vibrator;
import android.provider.Settings.Global;
import android.provider.Settings.System;
import android.service.notification.Condition;
import android.service.notification.IConditionListener;
import android.service.notification.IConditionProvider;
import android.service.notification.INotificationListener;
import android.service.notification.IStatusBarNotificationHolder;
import android.service.notification.NotificationRankingUpdate;
import android.service.notification.StatusBarNotification;
import android.service.notification.ZenModeConfig;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.AtomicFile;
import android.util.Log;
import android.util.Slog;
import android.util.Xml;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityManager;
import com.android.internal.util.FastXmlSerializer;
import com.android.server.EventLogTags;
import com.android.server.SystemService;
import com.android.server.lights.Light;
import com.android.server.lights.LightsManager;
import com.android.server.notification.ManagedServices.ManagedServiceInfo;
import com.android.server.notification.ManagedServices.UserProfiles;
import com.android.server.notification.ZenModeHelper.Callback;
import com.android.server.statusbar.StatusBarManagerInternal;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.Objects;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class NotificationManagerService extends SystemService {
    private static final String ATTR_NAME = "name";
    private static final String ATTR_VERSION = "version";
    static final boolean DBG;
    private static final int DB_VERSION = 1;
    static final int DEFAULT_STREAM_TYPE = 5;
    static final long[] DEFAULT_VIBRATE_PATTERN;
    static final boolean ENABLE_BLOCKED_NOTIFICATIONS = true;
    static final boolean ENABLE_BLOCKED_TOASTS = true;
    private static final int EVENTLOG_ENQUEUE_STATUS_IGNORED = 2;
    private static final int EVENTLOG_ENQUEUE_STATUS_NEW = 0;
    private static final int EVENTLOG_ENQUEUE_STATUS_UPDATE = 1;
    static final int JUNK_SCORE = -1000;
    static final int LONG_DELAY = 3500;
    static final int MATCHES_CALL_FILTER_CONTACTS_TIMEOUT_MS = 3000;
    static final float MATCHES_CALL_FILTER_TIMEOUT_AFFINITY = 1.0f;
    static final int MAX_PACKAGE_NOTIFICATIONS = 50;
    static final int MESSAGE_LISTENER_HINTS_CHANGED = 7;
    static final int MESSAGE_LISTENER_NOTIFICATION_FILTER_CHANGED = 8;
    static final int MESSAGE_RANKING_CONFIG_CHANGE = 5;
    static final int MESSAGE_RECONSIDER_RANKING = 4;
    static final int MESSAGE_SAVE_POLICY_FILE = 3;
    static final int MESSAGE_SEND_RANKING_UPDATE = 6;
    static final int MESSAGE_TIMEOUT = 2;
    private static final int MY_PID;
    private static final int MY_UID;
    static final int NOTIFICATION_PRIORITY_MULTIPLIER = 10;
    private static final int REASON_DELEGATE_CANCEL = 2;
    private static final int REASON_DELEGATE_CANCEL_ALL = 3;
    private static final int REASON_DELEGATE_CLICK = 1;
    private static final int REASON_DELEGATE_ERROR = 4;
    private static final int REASON_GROUP_OPTIMIZATION = 13;
    private static final int REASON_GROUP_SUMMARY_CANCELED = 12;
    private static final int REASON_LISTENER_CANCEL = 10;
    private static final int REASON_LISTENER_CANCEL_ALL = 11;
    private static final int REASON_NOMAN_CANCEL = 8;
    private static final int REASON_NOMAN_CANCEL_ALL = 9;
    private static final int REASON_PACKAGE_BANNED = 7;
    private static final int REASON_PACKAGE_CHANGED = 5;
    private static final int REASON_USER_STOPPED = 6;
    static final int SCORE_DISPLAY_THRESHOLD = -20;
    static final int SCORE_INTERRUPTION_THRESHOLD = -10;
    static final boolean SCORE_ONGOING_HIGHER = false;
    static final int SHORT_DELAY = 2000;
    static final String TAG = "NotificationService";
    private static final String TAG_BLOCKED_PKGS = "blocked-packages";
    private static final String TAG_BODY = "notification-policy";
    private static final String TAG_PACKAGE = "package";
    static final int VIBRATE_PATTERN_MAXLEN = 17;
    private IActivityManager mAm;
    private AppOpsManager mAppOps;
    private Archive mArchive;
    Light mAttentionLight;
    AudioManager mAudioManager;
    private HashSet<String> mBlockedPackages;
    private final Runnable mBuzzBeepBlinked;
    private int mCallState;
    private ConditionProviders mConditionProviders;
    private int mDefaultNotificationColor;
    private int mDefaultNotificationLedOff;
    private int mDefaultNotificationLedOn;
    private long[] mDefaultVibrationPattern;
    private boolean mDisableNotificationEffects;
    private ComponentName mEffectsSuppressor;
    private long[] mFallbackVibrationPattern;
    final IBinder mForegroundToken;
    private WorkerHandler mHandler;
    private boolean mInCall;
    private final BroadcastReceiver mIntentReceiver;
    private final NotificationManagerInternal mInternalService;
    private int mInterruptionFilter;
    ArrayList<String> mLights;
    private int mListenerHints;
    private NotificationListeners mListeners;
    private final ArraySet<ManagedServiceInfo> mListenersDisablingEffects;
    private final NotificationDelegate mNotificationDelegate;
    private Light mNotificationLight;
    final ArrayList<NotificationRecord> mNotificationList;
    private boolean mNotificationPulseEnabled;
    final ArrayMap<String, NotificationRecord> mNotificationsByKey;
    private final BroadcastReceiver mPackageIntentReceiver;
    private AtomicFile mPolicyFile;
    private RankingHelper mRankingHelper;
    private final HandlerThread mRankingThread;
    private boolean mScreenOn;
    private final IBinder mService;
    private SettingsObserver mSettingsObserver;
    private String mSoundNotificationKey;
    StatusBarManagerInternal mStatusBar;
    final ArrayMap<String, NotificationRecord> mSummaryByGroupKey;
    boolean mSystemReady;
    final ArrayList<ToastRecord> mToastQueue;
    private NotificationUsageStats mUsageStats;
    private boolean mUseAttentionLight;
    private final UserProfiles mUserProfiles;
    private String mVibrateNotificationKey;
    Vibrator mVibrator;
    private ZenModeHelper mZenModeHelper;

    /* renamed from: com.android.server.notification.NotificationManagerService.1 */
    class C04181 implements NotificationDelegate {
        C04181() {
        }

        public void onSetDisabled(int status) {
            synchronized (NotificationManagerService.this.mNotificationList) {
                NotificationManagerService.this.mDisableNotificationEffects = (262144 & status) != 0 ? NotificationManagerService.ENABLE_BLOCKED_TOASTS : NotificationManagerService.SCORE_ONGOING_HIGHER;
                if (NotificationManagerService.this.disableNotificationEffects(null) != null) {
                    long identity = Binder.clearCallingIdentity();
                    try {
                        IRingtonePlayer player = NotificationManagerService.this.mAudioManager.getRingtonePlayer();
                        if (player != null) {
                            player.stopAsync();
                        }
                    } catch (RemoteException e) {
                    } catch (Throwable th) {
                    } finally {
                        Binder.restoreCallingIdentity(identity);
                    }
                    identity = Binder.clearCallingIdentity();
                    NotificationManagerService.this.mVibrator.cancel();
                }
            }
        }

        public void onClearAll(int callingUid, int callingPid, int userId) {
            synchronized (NotificationManagerService.this.mNotificationList) {
                NotificationManagerService.this.cancelAllLocked(callingUid, callingPid, userId, NotificationManagerService.REASON_DELEGATE_CANCEL_ALL, null, NotificationManagerService.ENABLE_BLOCKED_TOASTS);
            }
        }

        public void onNotificationClick(int callingUid, int callingPid, String key) {
            synchronized (NotificationManagerService.this.mNotificationList) {
                EventLogTags.writeNotificationClicked(key);
                NotificationRecord r = (NotificationRecord) NotificationManagerService.this.mNotificationsByKey.get(key);
                if (r == null) {
                    Log.w(NotificationManagerService.TAG, "No notification with key: " + key);
                    return;
                }
                StatusBarNotification sbn = r.sbn;
                NotificationManagerService.this.cancelNotification(callingUid, callingPid, sbn.getPackageName(), sbn.getTag(), sbn.getId(), 16, 64, NotificationManagerService.SCORE_ONGOING_HIGHER, r.getUserId(), NotificationManagerService.REASON_DELEGATE_CLICK, null);
            }
        }

        public void onNotificationActionClick(int callingUid, int callingPid, String key, int actionIndex) {
            synchronized (NotificationManagerService.this.mNotificationList) {
                EventLogTags.writeNotificationActionClicked(key, actionIndex);
                if (((NotificationRecord) NotificationManagerService.this.mNotificationsByKey.get(key)) == null) {
                    Log.w(NotificationManagerService.TAG, "No notification with key: " + key);
                    return;
                }
            }
        }

        public void onNotificationClear(int callingUid, int callingPid, String pkg, String tag, int id, int userId) {
            NotificationManagerService.this.cancelNotification(callingUid, callingPid, pkg, tag, id, NotificationManagerService.MY_UID, 66, NotificationManagerService.ENABLE_BLOCKED_TOASTS, userId, NotificationManagerService.REASON_DELEGATE_CANCEL, null);
        }

        public void onPanelRevealed(boolean clearEffects) {
            EventLogTags.writeNotificationPanelRevealed();
            if (clearEffects) {
                clearEffects();
            }
        }

        public void onPanelHidden() {
            EventLogTags.writeNotificationPanelHidden();
        }

        public void clearEffects() {
            synchronized (NotificationManagerService.this.mNotificationList) {
                if (NotificationManagerService.DBG) {
                    Slog.d(NotificationManagerService.TAG, "clearEffects");
                }
                NotificationManagerService.this.mSoundNotificationKey = null;
                long identity = Binder.clearCallingIdentity();
                try {
                    IRingtonePlayer player = NotificationManagerService.this.mAudioManager.getRingtonePlayer();
                    if (player != null) {
                        player.stopAsync();
                    }
                } catch (RemoteException e) {
                } catch (Throwable th) {
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
                NotificationManagerService.this.mVibrateNotificationKey = null;
                identity = Binder.clearCallingIdentity();
                NotificationManagerService.this.mVibrator.cancel();
                NotificationManagerService.this.mLights.clear();
                NotificationManagerService.this.updateLightsLocked();
            }
        }

        public void onNotificationError(int callingUid, int callingPid, String pkg, String tag, int id, int uid, int initialPid, String message, int userId) {
            Slog.d(NotificationManagerService.TAG, "onNotification error pkg=" + pkg + " tag=" + tag + " id=" + id + "; will crashApplication(uid=" + uid + ", pid=" + initialPid + ")");
            NotificationManagerService.this.cancelNotification(callingUid, callingPid, pkg, tag, id, NotificationManagerService.MY_UID, NotificationManagerService.MY_UID, NotificationManagerService.SCORE_ONGOING_HIGHER, userId, NotificationManagerService.REASON_DELEGATE_ERROR, null);
            long ident = Binder.clearCallingIdentity();
            try {
                ActivityManagerNative.getDefault().crashApplication(uid, initialPid, pkg, "Bad notification posted from package " + pkg + ": " + message);
            } catch (RemoteException e) {
            }
            Binder.restoreCallingIdentity(ident);
        }

        public void onNotificationVisibilityChanged(String[] newlyVisibleKeys, String[] noLongerVisibleKeys) {
            EventLogTags.writeNotificationVisibilityChanged(TextUtils.join(";", newlyVisibleKeys), TextUtils.join(";", noLongerVisibleKeys));
            synchronized (NotificationManagerService.this.mNotificationList) {
                int i$;
                String[] arr$ = newlyVisibleKeys;
                int len$ = arr$.length;
                for (i$ = NotificationManagerService.MY_UID; i$ < len$; i$ += NotificationManagerService.REASON_DELEGATE_CLICK) {
                    NotificationRecord r = (NotificationRecord) NotificationManagerService.this.mNotificationsByKey.get(arr$[i$]);
                    if (r != null) {
                        r.stats.onVisibilityChanged(NotificationManagerService.ENABLE_BLOCKED_TOASTS);
                    }
                }
                arr$ = noLongerVisibleKeys;
                len$ = arr$.length;
                for (i$ = NotificationManagerService.MY_UID; i$ < len$; i$ += NotificationManagerService.REASON_DELEGATE_CLICK) {
                    r = (NotificationRecord) NotificationManagerService.this.mNotificationsByKey.get(arr$[i$]);
                    if (r != null) {
                        r.stats.onVisibilityChanged(NotificationManagerService.SCORE_ONGOING_HIGHER);
                    }
                }
            }
        }

        public void onNotificationExpansionChanged(String key, boolean userAction, boolean expanded) {
            int i;
            int i2 = NotificationManagerService.REASON_DELEGATE_CLICK;
            if (userAction) {
                i = NotificationManagerService.REASON_DELEGATE_CLICK;
            } else {
                i = NotificationManagerService.MY_UID;
            }
            if (!expanded) {
                i2 = NotificationManagerService.MY_UID;
            }
            EventLogTags.writeNotificationExpansion(key, i, i2);
            synchronized (NotificationManagerService.this.mNotificationList) {
                NotificationRecord r = (NotificationRecord) NotificationManagerService.this.mNotificationsByKey.get(key);
                if (r != null) {
                    r.stats.onExpansionChanged(userAction, expanded);
                }
            }
        }
    }

    /* renamed from: com.android.server.notification.NotificationManagerService.2 */
    class C04192 extends BroadcastReceiver {
        C04192() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (action != null) {
                boolean queryReplace;
                String[] pkgList;
                Uri uri;
                String pkgName;
                int enabled;
                String[] arr$;
                int len$;
                int i$;
                boolean queryRestart = NotificationManagerService.SCORE_ONGOING_HIGHER;
                boolean queryRemove = NotificationManagerService.SCORE_ONGOING_HIGHER;
                boolean packageChanged = NotificationManagerService.SCORE_ONGOING_HIGHER;
                boolean cancelNotifications = NotificationManagerService.ENABLE_BLOCKED_TOASTS;
                if (!action.equals("android.intent.action.PACKAGE_ADDED")) {
                    queryRemove = action.equals("android.intent.action.PACKAGE_REMOVED");
                    if (!(queryRemove || action.equals("android.intent.action.PACKAGE_RESTARTED"))) {
                        packageChanged = action.equals("android.intent.action.PACKAGE_CHANGED");
                        if (!packageChanged) {
                            queryRestart = action.equals("android.intent.action.QUERY_PACKAGE_RESTART");
                            if (!(queryRestart || action.equals("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE"))) {
                                return;
                            }
                        }
                    }
                }
                int changeUserId = intent.getIntExtra("android.intent.extra.user_handle", -1);
                if (queryRemove) {
                    if (intent.getBooleanExtra("android.intent.extra.REPLACING", NotificationManagerService.SCORE_ONGOING_HIGHER)) {
                        queryReplace = NotificationManagerService.ENABLE_BLOCKED_TOASTS;
                        if (NotificationManagerService.DBG) {
                            Slog.i(NotificationManagerService.TAG, "action=" + action + " queryReplace=" + queryReplace);
                        }
                        if (action.equals("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE")) {
                            pkgList = intent.getStringArrayExtra("android.intent.extra.changed_package_list");
                        } else if (queryRestart) {
                            uri = intent.getData();
                            if (uri != null) {
                                pkgName = uri.getSchemeSpecificPart();
                                if (pkgName != null) {
                                    if (packageChanged) {
                                        try {
                                            enabled = AppGlobals.getPackageManager().getApplicationEnabledSetting(pkgName, changeUserId == -1 ? changeUserId : NotificationManagerService.MY_UID);
                                            if (enabled == NotificationManagerService.REASON_DELEGATE_CLICK || enabled == 0) {
                                                cancelNotifications = NotificationManagerService.SCORE_ONGOING_HIGHER;
                                            }
                                        } catch (IllegalArgumentException e) {
                                            if (NotificationManagerService.DBG) {
                                                Slog.i(NotificationManagerService.TAG, "Exception trying to look up app enabled setting", e);
                                            }
                                        } catch (RemoteException e2) {
                                        }
                                    }
                                    pkgList = new String[NotificationManagerService.REASON_DELEGATE_CLICK];
                                    pkgList[NotificationManagerService.MY_UID] = pkgName;
                                } else {
                                    return;
                                }
                            }
                            return;
                        } else {
                            pkgList = intent.getStringArrayExtra("android.intent.extra.PACKAGES");
                        }
                        if (pkgList != null && pkgList.length > 0) {
                            arr$ = pkgList;
                            len$ = arr$.length;
                            for (i$ = NotificationManagerService.MY_UID; i$ < len$; i$ += NotificationManagerService.REASON_DELEGATE_CLICK) {
                                pkgName = arr$[i$];
                                if (cancelNotifications) {
                                    NotificationManagerService.this.cancelAllNotificationsInt(NotificationManagerService.MY_UID, NotificationManagerService.MY_PID, pkgName, NotificationManagerService.MY_UID, NotificationManagerService.MY_UID, queryRestart ? NotificationManagerService.ENABLE_BLOCKED_TOASTS : NotificationManagerService.SCORE_ONGOING_HIGHER, changeUserId, NotificationManagerService.REASON_PACKAGE_CHANGED, null);
                                }
                            }
                        }
                        NotificationManagerService.this.mListeners.onPackagesChanged(queryReplace, pkgList);
                        NotificationManagerService.this.mConditionProviders.onPackagesChanged(queryReplace, pkgList);
                    }
                }
                queryReplace = NotificationManagerService.SCORE_ONGOING_HIGHER;
                if (NotificationManagerService.DBG) {
                    Slog.i(NotificationManagerService.TAG, "action=" + action + " queryReplace=" + queryReplace);
                }
                if (action.equals("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE")) {
                    pkgList = intent.getStringArrayExtra("android.intent.extra.changed_package_list");
                } else if (queryRestart) {
                    uri = intent.getData();
                    if (uri != null) {
                        pkgName = uri.getSchemeSpecificPart();
                        if (pkgName != null) {
                            if (packageChanged) {
                                if (changeUserId == -1) {
                                }
                                enabled = AppGlobals.getPackageManager().getApplicationEnabledSetting(pkgName, changeUserId == -1 ? changeUserId : NotificationManagerService.MY_UID);
                                cancelNotifications = NotificationManagerService.SCORE_ONGOING_HIGHER;
                            }
                            pkgList = new String[NotificationManagerService.REASON_DELEGATE_CLICK];
                            pkgList[NotificationManagerService.MY_UID] = pkgName;
                        } else {
                            return;
                        }
                    }
                    return;
                } else {
                    pkgList = intent.getStringArrayExtra("android.intent.extra.PACKAGES");
                }
                arr$ = pkgList;
                len$ = arr$.length;
                for (i$ = NotificationManagerService.MY_UID; i$ < len$; i$ += NotificationManagerService.REASON_DELEGATE_CLICK) {
                    pkgName = arr$[i$];
                    if (cancelNotifications) {
                        if (queryRestart) {
                        }
                        NotificationManagerService.this.cancelAllNotificationsInt(NotificationManagerService.MY_UID, NotificationManagerService.MY_PID, pkgName, NotificationManagerService.MY_UID, NotificationManagerService.MY_UID, queryRestart ? NotificationManagerService.ENABLE_BLOCKED_TOASTS : NotificationManagerService.SCORE_ONGOING_HIGHER, changeUserId, NotificationManagerService.REASON_PACKAGE_CHANGED, null);
                    }
                }
                NotificationManagerService.this.mListeners.onPackagesChanged(queryReplace, pkgList);
                NotificationManagerService.this.mConditionProviders.onPackagesChanged(queryReplace, pkgList);
            }
        }
    }

    /* renamed from: com.android.server.notification.NotificationManagerService.3 */
    class C04203 extends BroadcastReceiver {
        C04203() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (action.equals("android.intent.action.SCREEN_ON")) {
                NotificationManagerService.this.mScreenOn = NotificationManagerService.ENABLE_BLOCKED_TOASTS;
                NotificationManagerService.this.updateNotificationPulse();
            } else if (action.equals("android.intent.action.SCREEN_OFF")) {
                NotificationManagerService.this.mScreenOn = NotificationManagerService.SCORE_ONGOING_HIGHER;
                NotificationManagerService.this.updateNotificationPulse();
            } else if (action.equals("android.intent.action.PHONE_STATE")) {
                NotificationManagerService.this.mInCall = TelephonyManager.EXTRA_STATE_OFFHOOK.equals(intent.getStringExtra("state"));
                NotificationManagerService.this.updateNotificationPulse();
            } else if (action.equals("android.intent.action.USER_STOPPED")) {
                int userHandle = intent.getIntExtra("android.intent.extra.user_handle", -1);
                if (userHandle >= 0) {
                    NotificationManagerService.this.cancelAllNotificationsInt(NotificationManagerService.MY_UID, NotificationManagerService.MY_PID, null, NotificationManagerService.MY_UID, NotificationManagerService.MY_UID, NotificationManagerService.ENABLE_BLOCKED_TOASTS, userHandle, NotificationManagerService.REASON_USER_STOPPED, null);
                }
            } else if (action.equals("android.intent.action.USER_PRESENT")) {
                NotificationManagerService.this.mNotificationLight.turnOff();
                NotificationManagerService.this.mStatusBar.notificationLightOff();
            } else if (action.equals("android.intent.action.USER_SWITCHED")) {
                NotificationManagerService.this.mSettingsObserver.update(null);
                NotificationManagerService.this.mUserProfiles.updateCache(context);
                NotificationManagerService.this.mConditionProviders.onUserSwitched();
                NotificationManagerService.this.mListeners.onUserSwitched();
            } else if (action.equals("android.intent.action.USER_ADDED")) {
                NotificationManagerService.this.mUserProfiles.updateCache(context);
            }
        }
    }

    /* renamed from: com.android.server.notification.NotificationManagerService.4 */
    class C04214 implements Runnable {
        C04214() {
        }

        public void run() {
            NotificationManagerService.this.mStatusBar.buzzBeepBlinked();
        }
    }

    /* renamed from: com.android.server.notification.NotificationManagerService.5 */
    class C04225 extends Callback {
        C04225() {
        }

        public void onConfigChanged() {
            NotificationManagerService.this.savePolicyFile();
        }

        void onZenModeChanged() {
            synchronized (NotificationManagerService.this.mNotificationList) {
                NotificationManagerService.this.updateInterruptionFilterLocked();
            }
        }
    }

    /* renamed from: com.android.server.notification.NotificationManagerService.6 */
    class C04236 extends Stub {
        C04236() {
        }

        public void enqueueToast(String pkg, ITransientNotification callback, int duration) {
            if (NotificationManagerService.DBG) {
                Slog.i(NotificationManagerService.TAG, "enqueueToast pkg=" + pkg + " callback=" + callback + " duration=" + duration);
            }
            if (pkg == null || callback == null) {
                Slog.e(NotificationManagerService.TAG, "Not doing toast. pkg=" + pkg + " callback=" + callback);
                return;
            }
            boolean isSystemToast = (NotificationManagerService.isCallerSystem() || "android".equals(pkg)) ? NotificationManagerService.ENABLE_BLOCKED_TOASTS : NotificationManagerService.SCORE_ONGOING_HIGHER;
            if (NotificationManagerService.this.noteNotificationOp(pkg, Binder.getCallingUid()) || isSystemToast) {
                synchronized (NotificationManagerService.this.mToastQueue) {
                    int callingPid = Binder.getCallingPid();
                    long callingId = Binder.clearCallingIdentity();
                    try {
                        int index = NotificationManagerService.this.indexOfToastLocked(pkg, callback);
                        if (index >= 0) {
                            ((ToastRecord) NotificationManagerService.this.mToastQueue.get(index)).update(duration);
                        } else {
                            if (!isSystemToast) {
                                int count = NotificationManagerService.MY_UID;
                                int N = NotificationManagerService.this.mToastQueue.size();
                                for (int i = NotificationManagerService.MY_UID; i < N; i += NotificationManagerService.REASON_DELEGATE_CLICK) {
                                    if (((ToastRecord) NotificationManagerService.this.mToastQueue.get(i)).pkg.equals(pkg)) {
                                        count += NotificationManagerService.REASON_DELEGATE_CLICK;
                                        if (count >= NotificationManagerService.MAX_PACKAGE_NOTIFICATIONS) {
                                            Slog.e(NotificationManagerService.TAG, "Package has already posted " + count + " toasts. Not showing more. Package=" + pkg);
                                            Binder.restoreCallingIdentity(callingId);
                                            return;
                                        }
                                    }
                                }
                            }
                            NotificationManagerService.this.mToastQueue.add(new ToastRecord(callingPid, pkg, callback, duration));
                            index = NotificationManagerService.this.mToastQueue.size() - 1;
                            NotificationManagerService.this.keepProcessAliveLocked(callingPid);
                        }
                        if (index == 0) {
                            NotificationManagerService.this.showNextToastLocked();
                        }
                    } finally {
                        Binder.restoreCallingIdentity(callingId);
                    }
                }
            } else {
                Slog.e(NotificationManagerService.TAG, "Suppressing toast from package " + pkg + " by user request.");
            }
        }

        public void cancelToast(String pkg, ITransientNotification callback) {
            Slog.i(NotificationManagerService.TAG, "cancelToast pkg=" + pkg + " callback=" + callback);
            if (pkg == null || callback == null) {
                Slog.e(NotificationManagerService.TAG, "Not cancelling notification. pkg=" + pkg + " callback=" + callback);
                return;
            }
            synchronized (NotificationManagerService.this.mToastQueue) {
                long callingId = Binder.clearCallingIdentity();
                try {
                    int index = NotificationManagerService.this.indexOfToastLocked(pkg, callback);
                    if (index >= 0) {
                        NotificationManagerService.this.cancelToastLocked(index);
                    } else {
                        Slog.w(NotificationManagerService.TAG, "Toast already cancelled. pkg=" + pkg + " callback=" + callback);
                    }
                } finally {
                    Binder.restoreCallingIdentity(callingId);
                }
            }
        }

        public void enqueueNotificationWithTag(String pkg, String opPkg, String tag, int id, Notification notification, int[] idOut, int userId) throws RemoteException {
            NotificationManagerService.this.enqueueNotificationInternal(pkg, opPkg, Binder.getCallingUid(), Binder.getCallingPid(), tag, id, notification, idOut, userId);
        }

        public void cancelNotificationWithTag(String pkg, String tag, int id, int userId) {
            NotificationManagerService.checkCallerIsSystemOrSameApp(pkg);
            NotificationManagerService.this.cancelNotification(Binder.getCallingUid(), Binder.getCallingPid(), pkg, tag, id, NotificationManagerService.MY_UID, Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE ? NotificationManagerService.MY_UID : 64, NotificationManagerService.SCORE_ONGOING_HIGHER, ActivityManager.handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, NotificationManagerService.ENABLE_BLOCKED_TOASTS, NotificationManagerService.SCORE_ONGOING_HIGHER, "cancelNotificationWithTag", pkg), NotificationManagerService.REASON_NOMAN_CANCEL, null);
        }

        public void cancelAllNotifications(String pkg, int userId) {
            NotificationManagerService.checkCallerIsSystemOrSameApp(pkg);
            NotificationManagerService.this.cancelAllNotificationsInt(Binder.getCallingUid(), Binder.getCallingPid(), pkg, NotificationManagerService.MY_UID, 64, NotificationManagerService.ENABLE_BLOCKED_TOASTS, ActivityManager.handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, NotificationManagerService.ENABLE_BLOCKED_TOASTS, NotificationManagerService.SCORE_ONGOING_HIGHER, "cancelAllNotifications", pkg), NotificationManagerService.REASON_NOMAN_CANCEL_ALL, null);
        }

        public void setNotificationsEnabledForPackage(String pkg, int uid, boolean enabled) {
            NotificationManagerService.checkCallerIsSystem();
            NotificationManagerService.this.setNotificationsEnabledForPackageImpl(pkg, uid, enabled);
        }

        public boolean areNotificationsEnabledForPackage(String pkg, int uid) {
            NotificationManagerService.checkCallerIsSystem();
            return NotificationManagerService.this.mAppOps.checkOpNoThrow(NotificationManagerService.REASON_LISTENER_CANCEL_ALL, uid, pkg) == 0 ? NotificationManagerService.ENABLE_BLOCKED_TOASTS : NotificationManagerService.SCORE_ONGOING_HIGHER;
        }

        public void setPackagePriority(String pkg, int uid, int priority) {
            NotificationManagerService.checkCallerIsSystem();
            NotificationManagerService.this.mRankingHelper.setPackagePriority(pkg, uid, priority);
            NotificationManagerService.this.savePolicyFile();
        }

        public int getPackagePriority(String pkg, int uid) {
            NotificationManagerService.checkCallerIsSystem();
            return NotificationManagerService.this.mRankingHelper.getPackagePriority(pkg, uid);
        }

        public void setPackageVisibilityOverride(String pkg, int uid, int visibility) {
            NotificationManagerService.checkCallerIsSystem();
            NotificationManagerService.this.mRankingHelper.setPackageVisibilityOverride(pkg, uid, visibility);
            NotificationManagerService.this.savePolicyFile();
        }

        public int getPackageVisibilityOverride(String pkg, int uid) {
            NotificationManagerService.checkCallerIsSystem();
            return NotificationManagerService.this.mRankingHelper.getPackageVisibilityOverride(pkg, uid);
        }

        public StatusBarNotification[] getActiveNotifications(String callingPkg) {
            NotificationManagerService.this.getContext().enforceCallingOrSelfPermission("android.permission.ACCESS_NOTIFICATIONS", "NotificationManagerService.getActiveNotifications");
            StatusBarNotification[] tmp = null;
            if (NotificationManagerService.this.mAppOps.noteOpNoThrow(25, Binder.getCallingUid(), callingPkg) == 0) {
                synchronized (NotificationManagerService.this.mNotificationList) {
                    tmp = new StatusBarNotification[NotificationManagerService.this.mNotificationList.size()];
                    int N = NotificationManagerService.this.mNotificationList.size();
                    for (int i = NotificationManagerService.MY_UID; i < N; i += NotificationManagerService.REASON_DELEGATE_CLICK) {
                        tmp[i] = ((NotificationRecord) NotificationManagerService.this.mNotificationList.get(i)).sbn;
                    }
                }
            }
            return tmp;
        }

        public StatusBarNotification[] getHistoricalNotifications(String callingPkg, int count) {
            NotificationManagerService.this.getContext().enforceCallingOrSelfPermission("android.permission.ACCESS_NOTIFICATIONS", "NotificationManagerService.getHistoricalNotifications");
            StatusBarNotification[] tmp = null;
            if (NotificationManagerService.this.mAppOps.noteOpNoThrow(25, Binder.getCallingUid(), callingPkg) == 0) {
                synchronized (NotificationManagerService.this.mArchive) {
                    tmp = NotificationManagerService.this.mArchive.getArray(count);
                }
            }
            return tmp;
        }

        public void registerListener(INotificationListener listener, ComponentName component, int userid) {
            enforceSystemOrSystemUI("INotificationManager.registerListener");
            NotificationManagerService.this.mListeners.registerService(listener, component, userid);
        }

        public void unregisterListener(INotificationListener listener, int userid) {
            NotificationManagerService.this.mListeners.unregisterService((IInterface) listener, userid);
        }

        public void cancelNotificationsFromListener(INotificationListener token, String[] keys) {
            int callingUid = Binder.getCallingUid();
            int callingPid = Binder.getCallingPid();
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (NotificationManagerService.this.mNotificationList) {
                    ManagedServiceInfo info = NotificationManagerService.this.mListeners.checkServiceTokenLocked(token);
                    if (keys != null) {
                        int N = keys.length;
                        for (int i = NotificationManagerService.MY_UID; i < N; i += NotificationManagerService.REASON_DELEGATE_CLICK) {
                            NotificationRecord r = (NotificationRecord) NotificationManagerService.this.mNotificationsByKey.get(keys[i]);
                            if (r != null) {
                                int userId = r.sbn.getUserId();
                                if (userId == info.userid || userId == -1 || NotificationManagerService.this.mUserProfiles.isCurrentProfile(userId)) {
                                    cancelNotificationFromListenerLocked(info, callingUid, callingPid, r.sbn.getPackageName(), r.sbn.getTag(), r.sbn.getId(), userId);
                                } else {
                                    throw new SecurityException("Disallowed call from listener: " + info.service);
                                }
                            }
                        }
                    } else {
                        NotificationManagerService.this.cancelAllLocked(callingUid, callingPid, info.userid, NotificationManagerService.REASON_LISTENER_CANCEL_ALL, info, info.supportsProfiles());
                    }
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        private void cancelNotificationFromListenerLocked(ManagedServiceInfo info, int callingUid, int callingPid, String pkg, String tag, int id, int userId) {
            NotificationManagerService.this.cancelNotification(callingUid, callingPid, pkg, tag, id, NotificationManagerService.MY_UID, 66, NotificationManagerService.ENABLE_BLOCKED_TOASTS, userId, NotificationManagerService.REASON_LISTENER_CANCEL, info);
        }

        public void cancelNotificationFromListener(INotificationListener token, String pkg, String tag, int id) {
            int callingUid = Binder.getCallingUid();
            int callingPid = Binder.getCallingPid();
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (NotificationManagerService.this.mNotificationList) {
                    ManagedServiceInfo info = NotificationManagerService.this.mListeners.checkServiceTokenLocked(token);
                    if (info.supportsProfiles()) {
                        Log.e(NotificationManagerService.TAG, "Ignoring deprecated cancelNotification(pkg, tag, id) from " + info.component + " use cancelNotification(key) instead.");
                    } else {
                        cancelNotificationFromListenerLocked(info, callingUid, callingPid, pkg, tag, id, info.userid);
                    }
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public ParceledListSlice<StatusBarNotification> getActiveNotificationsFromListener(INotificationListener token, String[] keys, int trim) {
            ParceledListSlice<StatusBarNotification> parceledListSlice;
            synchronized (NotificationManagerService.this.mNotificationList) {
                ManagedServiceInfo info = NotificationManagerService.this.mListeners.checkServiceTokenLocked(token);
                boolean getKeys = keys != null ? NotificationManagerService.ENABLE_BLOCKED_TOASTS : NotificationManagerService.SCORE_ONGOING_HIGHER;
                int N = getKeys ? keys.length : NotificationManagerService.this.mNotificationList.size();
                ArrayList<StatusBarNotification> list = new ArrayList(N);
                for (int i = NotificationManagerService.MY_UID; i < N; i += NotificationManagerService.REASON_DELEGATE_CLICK) {
                    NotificationRecord r = getKeys ? (NotificationRecord) NotificationManagerService.this.mNotificationsByKey.get(keys[i]) : (NotificationRecord) NotificationManagerService.this.mNotificationList.get(i);
                    if (r != null) {
                        StatusBarNotification sbn = r.sbn;
                        if (NotificationManagerService.this.isVisibleToListener(sbn, info)) {
                            list.add(trim == 0 ? sbn : sbn.cloneLight());
                        } else {
                            continue;
                        }
                    }
                }
                parceledListSlice = new ParceledListSlice(list);
            }
            return parceledListSlice;
        }

        public void requestHintsFromListener(INotificationListener token, int hints) {
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (NotificationManagerService.this.mNotificationList) {
                    ManagedServiceInfo info = NotificationManagerService.this.mListeners.checkServiceTokenLocked(token);
                    if ((hints & NotificationManagerService.REASON_DELEGATE_CLICK) != 0 ? NotificationManagerService.ENABLE_BLOCKED_TOASTS : NotificationManagerService.SCORE_ONGOING_HIGHER) {
                        NotificationManagerService.this.mListenersDisablingEffects.add(info);
                    } else {
                        NotificationManagerService.this.mListenersDisablingEffects.remove(info);
                    }
                    NotificationManagerService.this.updateListenerHintsLocked();
                    NotificationManagerService.this.updateEffectsSuppressorLocked();
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public int getHintsFromListener(INotificationListener token) {
            int access$2800;
            synchronized (NotificationManagerService.this.mNotificationList) {
                access$2800 = NotificationManagerService.this.mListenerHints;
            }
            return access$2800;
        }

        public void requestInterruptionFilterFromListener(INotificationListener token, int interruptionFilter) throws RemoteException {
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (NotificationManagerService.this.mNotificationList) {
                    NotificationManagerService.this.mZenModeHelper.requestFromListener(NotificationManagerService.this.mListeners.checkServiceTokenLocked(token).component, interruptionFilter);
                    NotificationManagerService.this.updateInterruptionFilterLocked();
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public int getInterruptionFilterFromListener(INotificationListener token) throws RemoteException {
            int access$3000;
            synchronized (NotificationManagerService.this.mNotificationLight) {
                access$3000 = NotificationManagerService.this.mInterruptionFilter;
            }
            return access$3000;
        }

        public void setOnNotificationPostedTrimFromListener(INotificationListener token, int trim) throws RemoteException {
            synchronized (NotificationManagerService.this.mNotificationList) {
                ManagedServiceInfo info = NotificationManagerService.this.mListeners.checkServiceTokenLocked(token);
                if (info == null) {
                    return;
                }
                NotificationManagerService.this.mListeners.setOnNotificationPostedTrimLocked(info, trim);
            }
        }

        public ZenModeConfig getZenModeConfig() {
            enforceSystemOrSystemUI("INotificationManager.getZenModeConfig");
            return NotificationManagerService.this.mZenModeHelper.getConfig();
        }

        public boolean setZenModeConfig(ZenModeConfig config) {
            NotificationManagerService.checkCallerIsSystem();
            return NotificationManagerService.this.mZenModeHelper.setConfig(config);
        }

        public void notifyConditions(String pkg, IConditionProvider provider, Condition[] conditions) {
            ManagedServiceInfo info = NotificationManagerService.this.mConditionProviders.checkServiceToken(provider);
            NotificationManagerService.checkCallerIsSystemOrSameApp(pkg);
            long identity = Binder.clearCallingIdentity();
            try {
                NotificationManagerService.this.mConditionProviders.notifyConditions(pkg, info, conditions);
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void requestZenModeConditions(IConditionListener callback, int relevance) {
            enforceSystemOrSystemUI("INotificationManager.requestZenModeConditions");
            NotificationManagerService.this.mConditionProviders.requestZenModeConditions(callback, relevance);
        }

        public void setZenModeCondition(Condition condition) {
            enforceSystemOrSystemUI("INotificationManager.setZenModeCondition");
            long identity = Binder.clearCallingIdentity();
            try {
                NotificationManagerService.this.mConditionProviders.setZenModeCondition(condition, "binderCall");
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void setAutomaticZenModeConditions(Uri[] conditionIds) {
            enforceSystemOrSystemUI("INotificationManager.setAutomaticZenModeConditions");
            NotificationManagerService.this.mConditionProviders.setAutomaticZenModeConditions(conditionIds);
        }

        public Condition[] getAutomaticZenModeConditions() {
            enforceSystemOrSystemUI("INotificationManager.getAutomaticZenModeConditions");
            return NotificationManagerService.this.mConditionProviders.getAutomaticZenModeConditions();
        }

        private void enforceSystemOrSystemUI(String message) {
            if (!NotificationManagerService.isCallerSystem()) {
                NotificationManagerService.this.getContext().enforceCallingPermission("android.permission.STATUS_BAR_SERVICE", message);
            }
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (NotificationManagerService.this.getContext().checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump NotificationManager from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            } else {
                NotificationManagerService.this.dumpImpl(pw, DumpFilter.parseFromArguments(args));
            }
        }

        public ComponentName getEffectsSuppressor() {
            enforceSystemOrSystemUI("INotificationManager.getEffectsSuppressor");
            return NotificationManagerService.this.mEffectsSuppressor;
        }

        public boolean matchesCallFilter(Bundle extras) {
            enforceSystemOrSystemUI("INotificationManager.matchesCallFilter");
            return NotificationManagerService.this.mZenModeHelper.matchesCallFilter(UserHandle.getCallingUserHandle(), extras, (ValidateNotificationPeople) NotificationManagerService.this.mRankingHelper.findExtractor(ValidateNotificationPeople.class), NotificationManagerService.MATCHES_CALL_FILTER_CONTACTS_TIMEOUT_MS, NotificationManagerService.MATCHES_CALL_FILTER_TIMEOUT_AFFINITY);
        }

        public boolean isSystemConditionProviderEnabled(String path) {
            enforceSystemOrSystemUI("INotificationManager.isSystemConditionProviderEnabled");
            return NotificationManagerService.this.mConditionProviders.isSystemConditionProviderEnabled(path);
        }
    }

    /* renamed from: com.android.server.notification.NotificationManagerService.7 */
    class C04247 implements NotificationManagerInternal {
        C04247() {
        }

        public void enqueueNotification(String pkg, String opPkg, int callingUid, int callingPid, String tag, int id, Notification notification, int[] idReceived, int userId) {
            NotificationManagerService.this.enqueueNotificationInternal(pkg, opPkg, callingUid, callingPid, tag, id, notification, idReceived, userId);
        }

        public void removeForegroundServiceFlagFromNotification(String pkg, int notificationId, int userId) {
            NotificationManagerService.checkCallerIsSystem();
            synchronized (NotificationManagerService.this.mNotificationList) {
                int i = NotificationManagerService.this.indexOfNotificationLocked(pkg, null, notificationId, userId);
                if (i < 0) {
                    Log.d(NotificationManagerService.TAG, "stripForegroundServiceFlag: Could not find notification with pkg=" + pkg + " / id=" + notificationId + " / userId=" + userId);
                    return;
                }
                NotificationRecord r = (NotificationRecord) NotificationManagerService.this.mNotificationList.get(i);
                StatusBarNotification sbn = r.sbn;
                sbn.getNotification().flags = r.mOriginalFlags & -65;
                NotificationManagerService.this.mRankingHelper.sort(NotificationManagerService.this.mNotificationList);
                NotificationManagerService.this.mListeners.notifyPostedLocked(sbn, sbn);
            }
        }
    }

    /* renamed from: com.android.server.notification.NotificationManagerService.8 */
    class C04258 implements Runnable {
        final /* synthetic */ int val$callingPid;
        final /* synthetic */ int val$callingUid;
        final /* synthetic */ int val$id;
        final /* synthetic */ boolean val$isSystemNotification;
        final /* synthetic */ Notification val$notification;
        final /* synthetic */ String val$opPkg;
        final /* synthetic */ String val$pkg;
        final /* synthetic */ String val$tag;
        final /* synthetic */ UserHandle val$user;
        final /* synthetic */ int val$userId;

        C04258(Notification notification, String str, String str2, int i, String str3, int i2, int i3, UserHandle userHandle, int i4, boolean z) {
            this.val$notification = notification;
            this.val$pkg = str;
            this.val$opPkg = str2;
            this.val$id = i;
            this.val$tag = str3;
            this.val$callingUid = i2;
            this.val$callingPid = i3;
            this.val$user = userHandle;
            this.val$userId = i4;
            this.val$isSystemNotification = z;
        }

        public void run() {
            synchronized (NotificationManagerService.this.mNotificationList) {
                this.val$notification.priority = NotificationManagerService.clamp(this.val$notification.priority, -2, NotificationManagerService.REASON_DELEGATE_CANCEL);
                if ((this.val$notification.flags & DumpState.DUMP_PROVIDERS) != 0 && this.val$notification.priority < NotificationManagerService.REASON_DELEGATE_CANCEL) {
                    this.val$notification.priority = NotificationManagerService.REASON_DELEGATE_CANCEL;
                }
                int score = this.val$notification.priority * NotificationManagerService.REASON_LISTENER_CANCEL;
                StatusBarNotification n = new StatusBarNotification(this.val$pkg, this.val$opPkg, this.val$id, this.val$tag, this.val$callingUid, this.val$callingPid, score, this.val$notification, this.val$user);
                NotificationRecord notificationRecord = new NotificationRecord(n, score);
                NotificationRecord old = (NotificationRecord) NotificationManagerService.this.mNotificationsByKey.get(n.getKey());
                if (old != null) {
                    notificationRecord.copyRankingInformation(old);
                }
                NotificationManagerService.this.handleGroupedNotificationLocked(notificationRecord, old, this.val$callingUid, this.val$callingPid);
                boolean ignoreNotification = NotificationManagerService.this.removeUnusedGroupedNotificationLocked(notificationRecord, old, this.val$callingUid, this.val$callingPid);
                if (!this.val$pkg.equals("com.android.providers.downloads") || Log.isLoggable("DownloadManager", NotificationManagerService.REASON_DELEGATE_CANCEL)) {
                    int enqueueStatus = NotificationManagerService.MY_UID;
                    if (ignoreNotification) {
                        enqueueStatus = NotificationManagerService.REASON_DELEGATE_CANCEL;
                    } else if (old != null) {
                        enqueueStatus = NotificationManagerService.REASON_DELEGATE_CLICK;
                    }
                    EventLogTags.writeNotificationEnqueue(this.val$callingUid, this.val$callingPid, this.val$pkg, this.val$id, this.val$tag, this.val$userId, this.val$notification.toString(), enqueueStatus);
                }
                if (ignoreNotification) {
                    return;
                }
                NotificationManagerService.this.mRankingHelper.extractSignals(notificationRecord);
                if (!(NotificationManagerService.this.noteNotificationOp(this.val$pkg, this.val$callingUid) || this.val$isSystemNotification)) {
                    notificationRecord.score = NotificationManagerService.JUNK_SCORE;
                    Slog.e(NotificationManagerService.TAG, "Suppressing notification from package " + this.val$pkg + " by user request.");
                }
                if (notificationRecord.score < NotificationManagerService.SCORE_DISPLAY_THRESHOLD) {
                    return;
                }
                int index = NotificationManagerService.this.indexOfNotificationLocked(n.getKey());
                if (index < 0) {
                    NotificationManagerService.this.mNotificationList.add(notificationRecord);
                    NotificationManagerService.this.mUsageStats.registerPostedByApp(notificationRecord);
                } else {
                    old = (NotificationRecord) NotificationManagerService.this.mNotificationList.get(index);
                    NotificationManagerService.this.mNotificationList.set(index, notificationRecord);
                    NotificationManagerService.this.mUsageStats.registerUpdatedByApp(notificationRecord, old);
                    Notification notification = this.val$notification;
                    notification.flags |= old.getNotification().flags & 64;
                    notificationRecord.isUpdate = NotificationManagerService.ENABLE_BLOCKED_TOASTS;
                }
                NotificationManagerService.this.mNotificationsByKey.put(n.getKey(), notificationRecord);
                if ((this.val$notification.flags & 64) != 0) {
                    notification = this.val$notification;
                    notification.flags |= 34;
                }
                NotificationManagerService.this.applyZenModeLocked(notificationRecord);
                NotificationManagerService.this.mRankingHelper.sort(NotificationManagerService.this.mNotificationList);
                if (this.val$notification.icon != 0) {
                    NotificationManagerService.this.mListeners.notifyPostedLocked(n, old != null ? old.sbn : null);
                } else {
                    Slog.e(NotificationManagerService.TAG, "Not posting notification with icon==0: " + this.val$notification);
                    if (!(old == null || old.isCanceled)) {
                        NotificationManagerService.this.mListeners.notifyRemovedLocked(n);
                    }
                    Slog.e(NotificationManagerService.TAG, "WARNING: In a future release this will crash the app: " + n.getPackageName());
                }
                NotificationManagerService.this.buzzBeepBlinkLocked(notificationRecord);
            }
        }
    }

    /* renamed from: com.android.server.notification.NotificationManagerService.9 */
    class C04269 implements Runnable {
        final /* synthetic */ int val$callingPid;
        final /* synthetic */ int val$callingUid;
        final /* synthetic */ int val$id;
        final /* synthetic */ ManagedServiceInfo val$listener;
        final /* synthetic */ int val$mustHaveFlags;
        final /* synthetic */ int val$mustNotHaveFlags;
        final /* synthetic */ String val$pkg;
        final /* synthetic */ int val$reason;
        final /* synthetic */ boolean val$sendDelete;
        final /* synthetic */ String val$tag;
        final /* synthetic */ int val$userId;

        C04269(ManagedServiceInfo managedServiceInfo, int i, int i2, String str, int i3, String str2, int i4, int i5, int i6, int i7, boolean z) {
            this.val$listener = managedServiceInfo;
            this.val$callingUid = i;
            this.val$callingPid = i2;
            this.val$pkg = str;
            this.val$id = i3;
            this.val$tag = str2;
            this.val$userId = i4;
            this.val$mustHaveFlags = i5;
            this.val$mustNotHaveFlags = i6;
            this.val$reason = i7;
            this.val$sendDelete = z;
        }

        public void run() {
            String listenerName;
            if (this.val$listener == null) {
                listenerName = null;
            } else {
                listenerName = this.val$listener.component.toShortString();
            }
            EventLogTags.writeNotificationCancel(this.val$callingUid, this.val$callingPid, this.val$pkg, this.val$id, this.val$tag, this.val$userId, this.val$mustHaveFlags, this.val$mustNotHaveFlags, this.val$reason, listenerName);
            synchronized (NotificationManagerService.this.mNotificationList) {
                int index = NotificationManagerService.this.indexOfNotificationLocked(this.val$pkg, this.val$tag, this.val$id, this.val$userId);
                if (index >= 0) {
                    NotificationRecord r = (NotificationRecord) NotificationManagerService.this.mNotificationList.get(index);
                    if (this.val$reason == NotificationManagerService.REASON_DELEGATE_CLICK) {
                        NotificationManagerService.this.mUsageStats.registerClickedByUser(r);
                    }
                    if ((r.getNotification().flags & this.val$mustHaveFlags) != this.val$mustHaveFlags) {
                        return;
                    } else if ((r.getNotification().flags & this.val$mustNotHaveFlags) != 0) {
                        return;
                    } else {
                        NotificationManagerService.this.mNotificationList.remove(index);
                        NotificationManagerService.this.cancelNotificationLocked(r, this.val$sendDelete, this.val$reason);
                        NotificationManagerService.this.cancelGroupChildrenLocked(r, this.val$callingUid, this.val$callingPid, listenerName, NotificationManagerService.REASON_GROUP_SUMMARY_CANCELED);
                        NotificationManagerService.this.updateLightsLocked();
                    }
                }
            }
        }
    }

    private static class Archive {
        final ArrayDeque<StatusBarNotification> mBuffer;
        final int mBufferSize;

        /* renamed from: com.android.server.notification.NotificationManagerService.Archive.1 */
        class C04271 implements Iterator<StatusBarNotification> {
            StatusBarNotification mNext;
            final /* synthetic */ Iterator val$iter;
            final /* synthetic */ String val$pkg;
            final /* synthetic */ int val$userId;

            C04271(Iterator it, String str, int i) {
                this.val$iter = it;
                this.val$pkg = str;
                this.val$userId = i;
                this.mNext = findNext();
            }

            private StatusBarNotification findNext() {
                while (this.val$iter.hasNext()) {
                    StatusBarNotification nr = (StatusBarNotification) this.val$iter.next();
                    if ((this.val$pkg == null || nr.getPackageName() == this.val$pkg) && (this.val$userId == -1 || nr.getUserId() == this.val$userId)) {
                        return nr;
                    }
                }
                return null;
            }

            public boolean hasNext() {
                return this.mNext == null ? NotificationManagerService.ENABLE_BLOCKED_TOASTS : NotificationManagerService.SCORE_ONGOING_HIGHER;
            }

            public StatusBarNotification next() {
                StatusBarNotification next = this.mNext;
                if (next == null) {
                    throw new NoSuchElementException();
                }
                this.mNext = findNext();
                return next;
            }

            public void remove() {
                this.val$iter.remove();
            }
        }

        public Archive(int size) {
            this.mBufferSize = size;
            this.mBuffer = new ArrayDeque(this.mBufferSize);
        }

        public String toString() {
            StringBuilder sb = new StringBuilder();
            int N = this.mBuffer.size();
            sb.append("Archive (");
            sb.append(N);
            sb.append(" notification");
            sb.append(N == NotificationManagerService.REASON_DELEGATE_CLICK ? ")" : "s)");
            return sb.toString();
        }

        public void record(StatusBarNotification nr) {
            if (this.mBuffer.size() == this.mBufferSize) {
                this.mBuffer.removeFirst();
            }
            this.mBuffer.addLast(nr.cloneLight());
        }

        public void clear() {
            this.mBuffer.clear();
        }

        public Iterator<StatusBarNotification> descendingIterator() {
            return this.mBuffer.descendingIterator();
        }

        public Iterator<StatusBarNotification> ascendingIterator() {
            return this.mBuffer.iterator();
        }

        public Iterator<StatusBarNotification> filter(Iterator<StatusBarNotification> iter, String pkg, int userId) {
            return new C04271(iter, pkg, userId);
        }

        public StatusBarNotification[] getArray(int count) {
            if (count == 0) {
                count = this.mBufferSize;
            }
            StatusBarNotification[] a = new StatusBarNotification[Math.min(count, this.mBuffer.size())];
            Iterator<StatusBarNotification> iter = descendingIterator();
            int i = NotificationManagerService.MY_UID;
            while (iter.hasNext() && i < count) {
                int i2 = i + NotificationManagerService.REASON_DELEGATE_CLICK;
                a[i] = (StatusBarNotification) iter.next();
                i = i2;
            }
            return a;
        }

        public StatusBarNotification[] getArray(int count, String pkg, int userId) {
            if (count == 0) {
                count = this.mBufferSize;
            }
            StatusBarNotification[] a = new StatusBarNotification[Math.min(count, this.mBuffer.size())];
            Iterator<StatusBarNotification> iter = filter(descendingIterator(), pkg, userId);
            int i = NotificationManagerService.MY_UID;
            while (iter.hasNext() && i < count) {
                int i2 = i + NotificationManagerService.REASON_DELEGATE_CLICK;
                a[i] = (StatusBarNotification) iter.next();
                i = i2;
            }
            return a;
        }
    }

    public static final class DumpFilter {
        public String pkgFilter;
        public boolean zen;

        public static DumpFilter parseFromArguments(String[] args) {
            DumpFilter filter;
            if (args != null && args.length == NotificationManagerService.REASON_DELEGATE_CANCEL && "p".equals(args[NotificationManagerService.MY_UID]) && args[NotificationManagerService.REASON_DELEGATE_CLICK] != null && !args[NotificationManagerService.REASON_DELEGATE_CLICK].trim().isEmpty()) {
                filter = new DumpFilter();
                filter.pkgFilter = args[NotificationManagerService.REASON_DELEGATE_CLICK].trim().toLowerCase();
                return filter;
            } else if (args == null || args.length != NotificationManagerService.REASON_DELEGATE_CLICK || !"zen".equals(args[NotificationManagerService.MY_UID])) {
                return null;
            } else {
                filter = new DumpFilter();
                filter.zen = NotificationManagerService.ENABLE_BLOCKED_TOASTS;
                return filter;
            }
        }

        public boolean matches(StatusBarNotification sbn) {
            if (this.zen) {
                return NotificationManagerService.ENABLE_BLOCKED_TOASTS;
            }
            return (sbn == null || !(matches(sbn.getPackageName()) || matches(sbn.getOpPkg()))) ? NotificationManagerService.SCORE_ONGOING_HIGHER : NotificationManagerService.ENABLE_BLOCKED_TOASTS;
        }

        public boolean matches(ComponentName component) {
            if (this.zen) {
                return NotificationManagerService.ENABLE_BLOCKED_TOASTS;
            }
            return (component == null || !matches(component.getPackageName())) ? NotificationManagerService.SCORE_ONGOING_HIGHER : NotificationManagerService.ENABLE_BLOCKED_TOASTS;
        }

        public boolean matches(String pkg) {
            if (this.zen) {
                return NotificationManagerService.ENABLE_BLOCKED_TOASTS;
            }
            return (pkg == null || !pkg.toLowerCase().contains(this.pkgFilter)) ? NotificationManagerService.SCORE_ONGOING_HIGHER : NotificationManagerService.ENABLE_BLOCKED_TOASTS;
        }

        public String toString() {
            return this.zen ? "zen" : '\'' + this.pkgFilter + '\'';
        }
    }

    public class NotificationListeners extends ManagedServices {
        private final ArraySet<ManagedServiceInfo> mLightTrimListeners;
        private boolean mNotificationGroupsDesired;

        /* renamed from: com.android.server.notification.NotificationManagerService.NotificationListeners.1 */
        class C04281 implements Runnable {
            final /* synthetic */ ManagedServiceInfo val$info;
            final /* synthetic */ StatusBarNotification val$oldSbnLightClone;
            final /* synthetic */ NotificationRankingUpdate val$update;

            C04281(ManagedServiceInfo managedServiceInfo, StatusBarNotification statusBarNotification, NotificationRankingUpdate notificationRankingUpdate) {
                this.val$info = managedServiceInfo;
                this.val$oldSbnLightClone = statusBarNotification;
                this.val$update = notificationRankingUpdate;
            }

            public void run() {
                NotificationListeners.this.notifyRemoved(this.val$info, this.val$oldSbnLightClone, this.val$update);
            }
        }

        /* renamed from: com.android.server.notification.NotificationManagerService.NotificationListeners.2 */
        class C04292 implements Runnable {
            final /* synthetic */ ManagedServiceInfo val$info;
            final /* synthetic */ StatusBarNotification val$sbnToPost;
            final /* synthetic */ NotificationRankingUpdate val$update;

            C04292(ManagedServiceInfo managedServiceInfo, StatusBarNotification statusBarNotification, NotificationRankingUpdate notificationRankingUpdate) {
                this.val$info = managedServiceInfo;
                this.val$sbnToPost = statusBarNotification;
                this.val$update = notificationRankingUpdate;
            }

            public void run() {
                NotificationListeners.this.notifyPosted(this.val$info, this.val$sbnToPost, this.val$update);
            }
        }

        /* renamed from: com.android.server.notification.NotificationManagerService.NotificationListeners.3 */
        class C04303 implements Runnable {
            final /* synthetic */ ManagedServiceInfo val$info;
            final /* synthetic */ StatusBarNotification val$sbnLight;
            final /* synthetic */ NotificationRankingUpdate val$update;

            C04303(ManagedServiceInfo managedServiceInfo, StatusBarNotification statusBarNotification, NotificationRankingUpdate notificationRankingUpdate) {
                this.val$info = managedServiceInfo;
                this.val$sbnLight = statusBarNotification;
                this.val$update = notificationRankingUpdate;
            }

            public void run() {
                NotificationListeners.this.notifyRemoved(this.val$info, this.val$sbnLight, this.val$update);
            }
        }

        /* renamed from: com.android.server.notification.NotificationManagerService.NotificationListeners.4 */
        class C04314 implements Runnable {
            final /* synthetic */ ManagedServiceInfo val$serviceInfo;
            final /* synthetic */ NotificationRankingUpdate val$update;

            C04314(ManagedServiceInfo managedServiceInfo, NotificationRankingUpdate notificationRankingUpdate) {
                this.val$serviceInfo = managedServiceInfo;
                this.val$update = notificationRankingUpdate;
            }

            public void run() {
                NotificationListeners.this.notifyRankingUpdate(this.val$serviceInfo, this.val$update);
            }
        }

        /* renamed from: com.android.server.notification.NotificationManagerService.NotificationListeners.5 */
        class C04325 implements Runnable {
            final /* synthetic */ int val$hints;
            final /* synthetic */ ManagedServiceInfo val$serviceInfo;

            C04325(ManagedServiceInfo managedServiceInfo, int i) {
                this.val$serviceInfo = managedServiceInfo;
                this.val$hints = i;
            }

            public void run() {
                NotificationListeners.this.notifyListenerHintsChanged(this.val$serviceInfo, this.val$hints);
            }
        }

        /* renamed from: com.android.server.notification.NotificationManagerService.NotificationListeners.6 */
        class C04336 implements Runnable {
            final /* synthetic */ int val$interruptionFilter;
            final /* synthetic */ ManagedServiceInfo val$serviceInfo;

            C04336(ManagedServiceInfo managedServiceInfo, int i) {
                this.val$serviceInfo = managedServiceInfo;
                this.val$interruptionFilter = i;
            }

            public void run() {
                NotificationListeners.this.notifyInterruptionFilterChanged(this.val$serviceInfo, this.val$interruptionFilter);
            }
        }

        public NotificationListeners() {
            super(NotificationManagerService.this.getContext(), NotificationManagerService.this.mHandler, NotificationManagerService.this.mNotificationList, NotificationManagerService.this.mUserProfiles);
            this.mLightTrimListeners = new ArraySet();
        }

        protected Config getConfig() {
            Config c = new Config();
            c.caption = "notification listener";
            c.serviceInterface = "android.service.notification.NotificationListenerService";
            c.secureSettingName = "enabled_notification_listeners";
            c.bindPermission = "android.permission.BIND_NOTIFICATION_LISTENER_SERVICE";
            c.settingsAction = "android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS";
            c.clientLabel = 17040728;
            return c;
        }

        protected IInterface asInterface(IBinder binder) {
            return INotificationListener.Stub.asInterface(binder);
        }

        public void onServiceAdded(ManagedServiceInfo info) {
            INotificationListener listener = info.service;
            synchronized (NotificationManagerService.this.mNotificationList) {
                updateNotificationGroupsDesiredLocked();
                NotificationRankingUpdate update = NotificationManagerService.this.makeRankingUpdateLocked(info);
            }
            try {
                listener.onListenerConnected(update);
            } catch (RemoteException e) {
            }
        }

        protected void onServiceRemovedLocked(ManagedServiceInfo removed) {
            if (NotificationManagerService.this.mListenersDisablingEffects.remove(removed)) {
                NotificationManagerService.this.updateListenerHintsLocked();
                NotificationManagerService.this.updateEffectsSuppressorLocked();
            }
            this.mLightTrimListeners.remove(removed);
            updateNotificationGroupsDesiredLocked();
        }

        public void setOnNotificationPostedTrimLocked(ManagedServiceInfo info, int trim) {
            if (trim == NotificationManagerService.REASON_DELEGATE_CLICK) {
                this.mLightTrimListeners.add(info);
            } else {
                this.mLightTrimListeners.remove(info);
            }
        }

        public int getOnNotificationPostedTrim(ManagedServiceInfo info) {
            return this.mLightTrimListeners.contains(info) ? NotificationManagerService.REASON_DELEGATE_CLICK : NotificationManagerService.MY_UID;
        }

        public void notifyPostedLocked(StatusBarNotification sbn, StatusBarNotification oldSbn) {
            StatusBarNotification sbnClone = null;
            StatusBarNotification sbnCloneLight = null;
            Iterator i$ = this.mServices.iterator();
            while (i$.hasNext()) {
                ManagedServiceInfo info = (ManagedServiceInfo) i$.next();
                boolean sbnVisible = NotificationManagerService.this.isVisibleToListener(sbn, info);
                boolean oldSbnVisible = oldSbn != null ? NotificationManagerService.this.isVisibleToListener(oldSbn, info) : NotificationManagerService.SCORE_ONGOING_HIGHER;
                if (oldSbnVisible || sbnVisible) {
                    NotificationRankingUpdate update = NotificationManagerService.this.makeRankingUpdateLocked(info);
                    if (!oldSbnVisible || sbnVisible) {
                        StatusBarNotification sbnToPost;
                        int trim = NotificationManagerService.this.mListeners.getOnNotificationPostedTrim(info);
                        if (trim == NotificationManagerService.REASON_DELEGATE_CLICK && sbnCloneLight == null) {
                            sbnCloneLight = sbn.cloneLight();
                        } else if (trim == 0 && sbnClone == null) {
                            sbnClone = sbn.clone();
                        }
                        if (trim == 0) {
                            sbnToPost = sbnClone;
                        } else {
                            sbnToPost = sbnCloneLight;
                        }
                        NotificationManagerService.this.mHandler.post(new C04292(info, sbnToPost, update));
                    } else {
                        NotificationManagerService.this.mHandler.post(new C04281(info, oldSbn.cloneLight(), update));
                    }
                }
            }
        }

        public void notifyRemovedLocked(StatusBarNotification sbn) {
            StatusBarNotification sbnLight = sbn.cloneLight();
            Iterator i$ = this.mServices.iterator();
            while (i$.hasNext()) {
                ManagedServiceInfo info = (ManagedServiceInfo) i$.next();
                if (NotificationManagerService.this.isVisibleToListener(sbn, info)) {
                    NotificationManagerService.this.mHandler.post(new C04303(info, sbnLight, NotificationManagerService.this.makeRankingUpdateLocked(info)));
                }
            }
        }

        public void notifyRankingUpdateLocked() {
            Iterator i$ = this.mServices.iterator();
            while (i$.hasNext()) {
                ManagedServiceInfo serviceInfo = (ManagedServiceInfo) i$.next();
                if (serviceInfo.isEnabledForCurrentProfiles()) {
                    NotificationManagerService.this.mHandler.post(new C04314(serviceInfo, NotificationManagerService.this.makeRankingUpdateLocked(serviceInfo)));
                }
            }
        }

        public void notifyListenerHintsChangedLocked(int hints) {
            Iterator i$ = this.mServices.iterator();
            while (i$.hasNext()) {
                ManagedServiceInfo serviceInfo = (ManagedServiceInfo) i$.next();
                if (serviceInfo.isEnabledForCurrentProfiles()) {
                    NotificationManagerService.this.mHandler.post(new C04325(serviceInfo, hints));
                }
            }
        }

        public void notifyInterruptionFilterChanged(int interruptionFilter) {
            Iterator i$ = this.mServices.iterator();
            while (i$.hasNext()) {
                ManagedServiceInfo serviceInfo = (ManagedServiceInfo) i$.next();
                if (serviceInfo.isEnabledForCurrentProfiles()) {
                    NotificationManagerService.this.mHandler.post(new C04336(serviceInfo, interruptionFilter));
                }
            }
        }

        private void notifyPosted(ManagedServiceInfo info, StatusBarNotification sbn, NotificationRankingUpdate rankingUpdate) {
            INotificationListener listener = info.service;
            try {
                listener.onNotificationPosted(new StatusBarNotificationHolder(sbn), rankingUpdate);
            } catch (RemoteException ex) {
                Log.e(this.TAG, "unable to notify listener (posted): " + listener, ex);
            }
        }

        private void notifyRemoved(ManagedServiceInfo info, StatusBarNotification sbn, NotificationRankingUpdate rankingUpdate) {
            if (info.enabledAndUserMatches(sbn.getUserId())) {
                INotificationListener listener = info.service;
                try {
                    listener.onNotificationRemoved(new StatusBarNotificationHolder(sbn), rankingUpdate);
                } catch (RemoteException ex) {
                    Log.e(this.TAG, "unable to notify listener (removed): " + listener, ex);
                }
            }
        }

        private void notifyRankingUpdate(ManagedServiceInfo info, NotificationRankingUpdate rankingUpdate) {
            INotificationListener listener = info.service;
            try {
                listener.onNotificationRankingUpdate(rankingUpdate);
            } catch (RemoteException ex) {
                Log.e(this.TAG, "unable to notify listener (ranking update): " + listener, ex);
            }
        }

        private void notifyListenerHintsChanged(ManagedServiceInfo info, int hints) {
            INotificationListener listener = info.service;
            try {
                listener.onListenerHintsChanged(hints);
            } catch (RemoteException ex) {
                Log.e(this.TAG, "unable to notify listener (listener hints): " + listener, ex);
            }
        }

        private void notifyInterruptionFilterChanged(ManagedServiceInfo info, int interruptionFilter) {
            INotificationListener listener = info.service;
            try {
                listener.onInterruptionFilterChanged(interruptionFilter);
            } catch (RemoteException ex) {
                Log.e(this.TAG, "unable to notify listener (interruption filter): " + listener, ex);
            }
        }

        private boolean isListenerPackage(String packageName) {
            boolean z = NotificationManagerService.SCORE_ONGOING_HIGHER;
            if (packageName != null) {
                synchronized (NotificationManagerService.this.mNotificationList) {
                    Iterator i$ = this.mServices.iterator();
                    while (i$.hasNext()) {
                        if (packageName.equals(((ManagedServiceInfo) i$.next()).component.getPackageName())) {
                            z = NotificationManagerService.ENABLE_BLOCKED_TOASTS;
                            break;
                        }
                    }
                }
            }
            return z;
        }

        public boolean notificationGroupsDesired() {
            return this.mNotificationGroupsDesired;
        }

        private void updateNotificationGroupsDesiredLocked() {
            this.mNotificationGroupsDesired = NotificationManagerService.ENABLE_BLOCKED_TOASTS;
            if (this.mServices.isEmpty()) {
                this.mNotificationGroupsDesired = NotificationManagerService.SCORE_ONGOING_HIGHER;
            } else if (this.mServices.size() == NotificationManagerService.REASON_DELEGATE_CLICK && ((ManagedServiceInfo) this.mServices.get(NotificationManagerService.MY_UID)).component.getPackageName().equals("com.android.systemui")) {
                this.mNotificationGroupsDesired = NotificationManagerService.SCORE_ONGOING_HIGHER;
            }
        }
    }

    private final class RankingWorkerHandler extends Handler {
        public RankingWorkerHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case NotificationManagerService.REASON_DELEGATE_ERROR /*4*/:
                    NotificationManagerService.this.handleRankingReconsideration(msg);
                case NotificationManagerService.REASON_PACKAGE_CHANGED /*5*/:
                    NotificationManagerService.this.handleRankingConfigChange();
                default:
            }
        }
    }

    class SettingsObserver extends ContentObserver {
        private final Uri NOTIFICATION_LIGHT_PULSE_URI;

        SettingsObserver(Handler handler) {
            super(handler);
            this.NOTIFICATION_LIGHT_PULSE_URI = System.getUriFor("notification_light_pulse");
        }

        void observe() {
            NotificationManagerService.this.getContext().getContentResolver().registerContentObserver(this.NOTIFICATION_LIGHT_PULSE_URI, NotificationManagerService.SCORE_ONGOING_HIGHER, this, -1);
            update(null);
        }

        public void onChange(boolean selfChange, Uri uri) {
            update(uri);
        }

        public void update(Uri uri) {
            boolean pulseEnabled = NotificationManagerService.SCORE_ONGOING_HIGHER;
            ContentResolver resolver = NotificationManagerService.this.getContext().getContentResolver();
            if (uri == null || this.NOTIFICATION_LIGHT_PULSE_URI.equals(uri)) {
                if (System.getInt(resolver, "notification_light_pulse", NotificationManagerService.MY_UID) != 0) {
                    pulseEnabled = NotificationManagerService.ENABLE_BLOCKED_TOASTS;
                }
                if (NotificationManagerService.this.mNotificationPulseEnabled != pulseEnabled) {
                    NotificationManagerService.this.mNotificationPulseEnabled = pulseEnabled;
                    NotificationManagerService.this.updateNotificationPulse();
                }
            }
        }
    }

    private static final class StatusBarNotificationHolder extends IStatusBarNotificationHolder.Stub {
        private StatusBarNotification mValue;

        public StatusBarNotificationHolder(StatusBarNotification value) {
            this.mValue = value;
        }

        public StatusBarNotification get() {
            StatusBarNotification value = this.mValue;
            this.mValue = null;
            return value;
        }
    }

    private static final class ToastRecord {
        final ITransientNotification callback;
        int duration;
        final int pid;
        final String pkg;

        ToastRecord(int pid, String pkg, ITransientNotification callback, int duration) {
            this.pid = pid;
            this.pkg = pkg;
            this.callback = callback;
            this.duration = duration;
        }

        void update(int duration) {
            this.duration = duration;
        }

        void dump(PrintWriter pw, String prefix, DumpFilter filter) {
            if (filter == null || filter.matches(this.pkg)) {
                pw.println(prefix + this);
            }
        }

        public final String toString() {
            return "ToastRecord{" + Integer.toHexString(System.identityHashCode(this)) + " pkg=" + this.pkg + " callback=" + this.callback + " duration=" + this.duration;
        }
    }

    private final class WorkerHandler extends Handler {
        private WorkerHandler() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case NotificationManagerService.REASON_DELEGATE_CANCEL /*2*/:
                    NotificationManagerService.this.handleTimeout((ToastRecord) msg.obj);
                case NotificationManagerService.REASON_DELEGATE_CANCEL_ALL /*3*/:
                    NotificationManagerService.this.handleSavePolicyFile();
                case NotificationManagerService.REASON_USER_STOPPED /*6*/:
                    NotificationManagerService.this.handleSendRankingUpdate();
                case NotificationManagerService.REASON_PACKAGE_BANNED /*7*/:
                    NotificationManagerService.this.handleListenerHintsChanged(msg.arg1);
                case NotificationManagerService.REASON_NOMAN_CANCEL /*8*/:
                    NotificationManagerService.this.handleListenerInterruptionFilterChanged(msg.arg1);
                default:
            }
        }
    }

    static {
        DBG = Log.isLoggable(TAG, REASON_DELEGATE_CANCEL_ALL);
        DEFAULT_VIBRATE_PATTERN = new long[]{0, 250, 250, 250};
        MY_UID = Process.myUid();
        MY_PID = Process.myPid();
    }

    private void loadPolicyFile() {
        synchronized (this.mPolicyFile) {
            this.mBlockedPackages.clear();
            FileInputStream infile = null;
            try {
                infile = this.mPolicyFile.openRead();
                XmlPullParser parser = Xml.newPullParser();
                parser.setInput(infile, StandardCharsets.UTF_8.name());
                while (true) {
                    int type = parser.next();
                    if (type != REASON_DELEGATE_CLICK) {
                        String tag = parser.getName();
                        if (type == REASON_DELEGATE_CANCEL) {
                            if (!TAG_BODY.equals(tag)) {
                                if (TAG_BLOCKED_PKGS.equals(tag)) {
                                    while (true) {
                                        type = parser.next();
                                        if (type == REASON_DELEGATE_CLICK) {
                                            break;
                                        }
                                        tag = parser.getName();
                                        if (!TAG_PACKAGE.equals(tag)) {
                                            if (TAG_BLOCKED_PKGS.equals(tag) && type == REASON_DELEGATE_CANCEL_ALL) {
                                                break;
                                            }
                                        }
                                        this.mBlockedPackages.add(parser.getAttributeValue(null, ATTR_NAME));
                                    }
                                }
                            } else {
                                int version = Integer.parseInt(parser.getAttributeValue(null, ATTR_VERSION));
                            }
                        }
                        this.mZenModeHelper.readXml(parser);
                        this.mRankingHelper.readXml(parser);
                    } else {
                        IoUtils.closeQuietly(infile);
                    }
                }
            } catch (FileNotFoundException e) {
                IoUtils.closeQuietly(infile);
            } catch (IOException e2) {
                Log.wtf(TAG, "Unable to read notification policy", e2);
                IoUtils.closeQuietly(infile);
            } catch (NumberFormatException e3) {
                Log.wtf(TAG, "Unable to parse notification policy", e3);
                IoUtils.closeQuietly(infile);
            } catch (XmlPullParserException e4) {
                Log.wtf(TAG, "Unable to parse notification policy", e4);
                IoUtils.closeQuietly(infile);
            } catch (Throwable th) {
                IoUtils.closeQuietly(infile);
            }
        }
    }

    public void savePolicyFile() {
        this.mHandler.removeMessages(REASON_DELEGATE_CANCEL_ALL);
        this.mHandler.sendEmptyMessage(REASON_DELEGATE_CANCEL_ALL);
    }

    private void handleSavePolicyFile() {
        Slog.d(TAG, "handleSavePolicyFile");
        synchronized (this.mPolicyFile) {
            try {
                FileOutputStream stream = this.mPolicyFile.startWrite();
                try {
                    XmlSerializer out = new FastXmlSerializer();
                    out.setOutput(stream, StandardCharsets.UTF_8.name());
                    out.startDocument(null, Boolean.valueOf(ENABLE_BLOCKED_TOASTS));
                    out.startTag(null, TAG_BODY);
                    out.attribute(null, ATTR_VERSION, Integer.toString(REASON_DELEGATE_CLICK));
                    this.mZenModeHelper.writeXml(out);
                    this.mRankingHelper.writeXml(out);
                    out.endTag(null, TAG_BODY);
                    out.endDocument();
                    this.mPolicyFile.finishWrite(stream);
                } catch (IOException e) {
                    Slog.w(TAG, "Failed to save policy file, restoring backup", e);
                    this.mPolicyFile.failWrite(stream);
                }
            } catch (IOException e2) {
                Slog.w(TAG, "Failed to save policy file", e2);
            }
        }
    }

    private boolean noteNotificationOp(String pkg, int uid) {
        if (this.mAppOps.noteOpNoThrow(REASON_LISTENER_CANCEL_ALL, uid, pkg) == 0) {
            return ENABLE_BLOCKED_TOASTS;
        }
        Slog.v(TAG, "notifications are disabled by AppOps for " + pkg);
        return SCORE_ONGOING_HIGHER;
    }

    static long[] getLongArray(Resources r, int resid, int maxlen, long[] def) {
        int[] ar = r.getIntArray(resid);
        if (ar == null) {
            return def;
        }
        int len = ar.length > maxlen ? maxlen : ar.length;
        long[] out = new long[len];
        for (int i = MY_UID; i < len; i += REASON_DELEGATE_CLICK) {
            out[i] = (long) ar[i];
        }
        return out;
    }

    public NotificationManagerService(Context context) {
        super(context);
        this.mForegroundToken = new Binder();
        this.mRankingThread = new HandlerThread("ranker", REASON_LISTENER_CANCEL);
        this.mListenersDisablingEffects = new ArraySet();
        this.mScreenOn = ENABLE_BLOCKED_TOASTS;
        this.mInCall = SCORE_ONGOING_HIGHER;
        this.mNotificationList = new ArrayList();
        this.mNotificationsByKey = new ArrayMap();
        this.mToastQueue = new ArrayList();
        this.mSummaryByGroupKey = new ArrayMap();
        this.mLights = new ArrayList();
        this.mBlockedPackages = new HashSet();
        this.mUserProfiles = new UserProfiles();
        this.mNotificationDelegate = new C04181();
        this.mPackageIntentReceiver = new C04192();
        this.mIntentReceiver = new C04203();
        this.mBuzzBeepBlinked = new C04214();
        this.mService = new C04236();
        this.mInternalService = new C04247();
    }

    public void onStart() {
        String[] extractorNames;
        Resources resources = getContext().getResources();
        this.mAm = ActivityManagerNative.getDefault();
        this.mAppOps = (AppOpsManager) getContext().getSystemService("appops");
        this.mVibrator = (Vibrator) getContext().getSystemService("vibrator");
        NotificationManagerService notificationManagerService = this;
        this.mHandler = new WorkerHandler();
        this.mRankingThread.start();
        try {
            extractorNames = resources.getStringArray(17236019);
        } catch (NotFoundException e) {
            extractorNames = new String[MY_UID];
        }
        this.mRankingHelper = new RankingHelper(getContext(), new RankingWorkerHandler(this.mRankingThread.getLooper()), extractorNames);
        this.mZenModeHelper = new ZenModeHelper(getContext(), this.mHandler.getLooper());
        this.mZenModeHelper.addCallback(new C04225());
        this.mPolicyFile = new AtomicFile(new File(new File(Environment.getDataDirectory(), "system"), "notification_policy.xml"));
        this.mUsageStats = new NotificationUsageStats(getContext());
        importOldBlockDb();
        this.mListeners = new NotificationListeners();
        this.mConditionProviders = new ConditionProviders(getContext(), this.mHandler, this.mUserProfiles, this.mZenModeHelper);
        this.mStatusBar = (StatusBarManagerInternal) getLocalService(StatusBarManagerInternal.class);
        this.mStatusBar.setNotificationDelegate(this.mNotificationDelegate);
        LightsManager lights = (LightsManager) getLocalService(LightsManager.class);
        this.mNotificationLight = lights.getLight(REASON_DELEGATE_ERROR);
        this.mAttentionLight = lights.getLight(REASON_PACKAGE_CHANGED);
        this.mDefaultNotificationColor = resources.getColor(17170700);
        this.mDefaultNotificationLedOn = resources.getInteger(17694792);
        this.mDefaultNotificationLedOff = resources.getInteger(17694793);
        this.mDefaultVibrationPattern = getLongArray(resources, 17236016, VIBRATE_PATTERN_MAXLEN, DEFAULT_VIBRATE_PATTERN);
        this.mFallbackVibrationPattern = getLongArray(resources, 17236017, VIBRATE_PATTERN_MAXLEN, DEFAULT_VIBRATE_PATTERN);
        this.mUseAttentionLight = resources.getBoolean(17956900);
        if (Global.getInt(getContext().getContentResolver(), "device_provisioned", MY_UID) == 0) {
            this.mDisableNotificationEffects = ENABLE_BLOCKED_TOASTS;
        }
        this.mZenModeHelper.readZenModeFromSetting();
        this.mInterruptionFilter = this.mZenModeHelper.getZenModeListenerInterruptionFilter();
        this.mUserProfiles.updateCache(getContext());
        listenForCallState();
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.SCREEN_ON");
        filter.addAction("android.intent.action.SCREEN_OFF");
        filter.addAction("android.intent.action.PHONE_STATE");
        filter.addAction("android.intent.action.USER_PRESENT");
        filter.addAction("android.intent.action.USER_STOPPED");
        filter.addAction("android.intent.action.USER_SWITCHED");
        filter.addAction("android.intent.action.USER_ADDED");
        getContext().registerReceiver(this.mIntentReceiver, filter);
        IntentFilter pkgFilter = new IntentFilter();
        pkgFilter.addAction("android.intent.action.PACKAGE_ADDED");
        pkgFilter.addAction("android.intent.action.PACKAGE_REMOVED");
        pkgFilter.addAction("android.intent.action.PACKAGE_CHANGED");
        pkgFilter.addAction("android.intent.action.PACKAGE_RESTARTED");
        pkgFilter.addAction("android.intent.action.QUERY_PACKAGE_RESTART");
        pkgFilter.addDataScheme(TAG_PACKAGE);
        getContext().registerReceiverAsUser(this.mPackageIntentReceiver, UserHandle.ALL, pkgFilter, null, null);
        getContext().registerReceiverAsUser(this.mPackageIntentReceiver, UserHandle.ALL, new IntentFilter("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE"), null, null);
        this.mSettingsObserver = new SettingsObserver(this.mHandler);
        this.mArchive = new Archive(resources.getInteger(17694799));
        publishBinderService("notification", this.mService);
        publishLocalService(NotificationManagerInternal.class, this.mInternalService);
    }

    private void importOldBlockDb() {
        loadPolicyFile();
        PackageManager pm = getContext().getPackageManager();
        Iterator i$ = this.mBlockedPackages.iterator();
        while (i$.hasNext()) {
            String pkg = (String) i$.next();
            try {
                setNotificationsEnabledForPackageImpl(pkg, pm.getPackageInfo(pkg, MY_UID).applicationInfo.uid, SCORE_ONGOING_HIGHER);
            } catch (NameNotFoundException e) {
            }
        }
        this.mBlockedPackages.clear();
    }

    public void onBootPhase(int phase) {
        if (phase == SystemService.PHASE_SYSTEM_SERVICES_READY) {
            this.mSystemReady = ENABLE_BLOCKED_TOASTS;
            this.mAudioManager = (AudioManager) getContext().getSystemService("audio");
            this.mZenModeHelper.onSystemReady();
        } else if (phase == NetdResponseCode.InterfaceChange) {
            this.mSettingsObserver.observe();
            this.mListeners.onBootPhaseAppsCanStart();
            this.mConditionProviders.onBootPhaseAppsCanStart();
        }
    }

    void setNotificationsEnabledForPackageImpl(String pkg, int uid, boolean enabled) {
        int i;
        Slog.v(TAG, (enabled ? "en" : "dis") + "abling notifications for " + pkg);
        AppOpsManager appOpsManager = this.mAppOps;
        if (enabled) {
            i = MY_UID;
        } else {
            i = REASON_DELEGATE_CLICK;
        }
        appOpsManager.setMode(REASON_LISTENER_CANCEL_ALL, uid, pkg, i);
        if (!enabled) {
            cancelAllNotificationsInt(MY_UID, MY_PID, pkg, MY_UID, MY_UID, ENABLE_BLOCKED_TOASTS, UserHandle.getUserId(uid), REASON_PACKAGE_BANNED, null);
        }
    }

    private void updateListenerHintsLocked() {
        int hints = this.mListenersDisablingEffects.isEmpty() ? MY_UID : REASON_DELEGATE_CLICK;
        if (hints != this.mListenerHints) {
            this.mListenerHints = hints;
            scheduleListenerHintsChanged(hints);
        }
    }

    private void updateEffectsSuppressorLocked() {
        ComponentName suppressor = !this.mListenersDisablingEffects.isEmpty() ? ((ManagedServiceInfo) this.mListenersDisablingEffects.valueAt(MY_UID)).component : null;
        if (!Objects.equals(suppressor, this.mEffectsSuppressor)) {
            boolean z;
            this.mEffectsSuppressor = suppressor;
            ZenModeHelper zenModeHelper = this.mZenModeHelper;
            if (suppressor != null) {
                z = ENABLE_BLOCKED_TOASTS;
            } else {
                z = SCORE_ONGOING_HIGHER;
            }
            zenModeHelper.setEffectsSuppressed(z);
            getContext().sendBroadcast(new Intent("android.os.action.ACTION_EFFECTS_SUPPRESSOR_CHANGED").addFlags(1073741824));
        }
    }

    private void updateInterruptionFilterLocked() {
        int interruptionFilter = this.mZenModeHelper.getZenModeListenerInterruptionFilter();
        if (interruptionFilter != this.mInterruptionFilter) {
            this.mInterruptionFilter = interruptionFilter;
            scheduleInterruptionFilterChanged(interruptionFilter);
        }
    }

    private String[] getActiveNotificationKeys(INotificationListener token) {
        ManagedServiceInfo info = this.mListeners.checkServiceTokenLocked(token);
        ArrayList<String> keys = new ArrayList();
        if (info.isEnabledForCurrentProfiles()) {
            synchronized (this.mNotificationList) {
                int N = this.mNotificationList.size();
                for (int i = MY_UID; i < N; i += REASON_DELEGATE_CLICK) {
                    StatusBarNotification sbn = ((NotificationRecord) this.mNotificationList.get(i)).sbn;
                    if (info.enabledAndUserMatches(sbn.getUserId())) {
                        keys.add(sbn.getKey());
                    }
                }
            }
        }
        return (String[]) keys.toArray(new String[keys.size()]);
    }

    private String disableNotificationEffects(NotificationRecord record) {
        if (this.mDisableNotificationEffects) {
            return "booleanState";
        }
        if ((this.mListenerHints & REASON_DELEGATE_CLICK) != 0) {
            return "listenerHints";
        }
        if (this.mCallState == 0 || this.mZenModeHelper.isCall(record)) {
            return null;
        }
        return "callState";
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void dumpImpl(java.io.PrintWriter r14, com.android.server.notification.NotificationManagerService.DumpFilter r15) {
        /*
        r13 = this;
        r10 = "Current Notification Manager state";
        r14.print(r10);
        if (r15 == 0) goto L_0x0014;
    L_0x0007:
        r10 = " (filtered to ";
        r14.print(r10);
        r14.print(r15);
        r10 = ")";
        r14.print(r10);
    L_0x0014:
        r10 = 58;
        r14.println(r10);
        if (r15 == 0) goto L_0x0045;
    L_0x001b:
        r10 = r15.zen;
        if (r10 == 0) goto L_0x0045;
    L_0x001f:
        r9 = 1;
    L_0x0020:
        if (r9 != 0) goto L_0x004d;
    L_0x0022:
        r11 = r13.mToastQueue;
        monitor-enter(r11);
        r10 = r13.mToastQueue;	 Catch:{ all -> 0x0077 }
        r0 = r10.size();	 Catch:{ all -> 0x0077 }
        if (r0 <= 0) goto L_0x004c;
    L_0x002d:
        r10 = "  Toast Queue:";
        r14.println(r10);	 Catch:{ all -> 0x0077 }
        r2 = 0;
    L_0x0033:
        if (r2 >= r0) goto L_0x0047;
    L_0x0035:
        r10 = r13.mToastQueue;	 Catch:{ all -> 0x0077 }
        r10 = r10.get(r2);	 Catch:{ all -> 0x0077 }
        r10 = (com.android.server.notification.NotificationManagerService.ToastRecord) r10;	 Catch:{ all -> 0x0077 }
        r12 = "    ";
        r10.dump(r14, r12, r15);	 Catch:{ all -> 0x0077 }
        r2 = r2 + 1;
        goto L_0x0033;
    L_0x0045:
        r9 = 0;
        goto L_0x0020;
    L_0x0047:
        r10 = "  ";
        r14.println(r10);	 Catch:{ all -> 0x0077 }
    L_0x004c:
        monitor-exit(r11);	 Catch:{ all -> 0x0077 }
    L_0x004d:
        r11 = r13.mNotificationList;
        monitor-enter(r11);
        if (r9 != 0) goto L_0x01c9;
    L_0x0052:
        r10 = r13.mNotificationList;	 Catch:{ all -> 0x0084 }
        r0 = r10.size();	 Catch:{ all -> 0x0084 }
        if (r0 <= 0) goto L_0x008c;
    L_0x005a:
        r10 = "  Notification List:";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r2 = 0;
    L_0x0060:
        if (r2 >= r0) goto L_0x0087;
    L_0x0062:
        r10 = r13.mNotificationList;	 Catch:{ all -> 0x0084 }
        r6 = r10.get(r2);	 Catch:{ all -> 0x0084 }
        r6 = (com.android.server.notification.NotificationRecord) r6;	 Catch:{ all -> 0x0084 }
        if (r15 == 0) goto L_0x007a;
    L_0x006c:
        r10 = r6.sbn;	 Catch:{ all -> 0x0084 }
        r10 = r15.matches(r10);	 Catch:{ all -> 0x0084 }
        if (r10 != 0) goto L_0x007a;
    L_0x0074:
        r2 = r2 + 1;
        goto L_0x0060;
    L_0x0077:
        r10 = move-exception;
        monitor-exit(r11);	 Catch:{ all -> 0x0077 }
        throw r10;
    L_0x007a:
        r10 = "    ";
        r12 = r13.getContext();	 Catch:{ all -> 0x0084 }
        r6.dump(r14, r10, r12);	 Catch:{ all -> 0x0084 }
        goto L_0x0074;
    L_0x0084:
        r10 = move-exception;
        monitor-exit(r11);	 Catch:{ all -> 0x0084 }
        throw r10;
    L_0x0087:
        r10 = "  ";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
    L_0x008c:
        if (r15 != 0) goto L_0x016c;
    L_0x008e:
        r10 = r13.mLights;	 Catch:{ all -> 0x0084 }
        r0 = r10.size();	 Catch:{ all -> 0x0084 }
        if (r0 <= 0) goto L_0x00c0;
    L_0x0096:
        r10 = "  Lights List:";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r2 = 0;
    L_0x009c:
        if (r2 >= r0) goto L_0x00bb;
    L_0x009e:
        r10 = r0 + -1;
        if (r2 != r10) goto L_0x00b5;
    L_0x00a2:
        r10 = "  > ";
        r14.print(r10);	 Catch:{ all -> 0x0084 }
    L_0x00a7:
        r10 = r13.mLights;	 Catch:{ all -> 0x0084 }
        r10 = r10.get(r2);	 Catch:{ all -> 0x0084 }
        r10 = (java.lang.String) r10;	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r2 = r2 + 1;
        goto L_0x009c;
    L_0x00b5:
        r10 = "    ";
        r14.print(r10);	 Catch:{ all -> 0x0084 }
        goto L_0x00a7;
    L_0x00bb:
        r10 = "  ";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
    L_0x00c0:
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0084 }
        r10.<init>();	 Catch:{ all -> 0x0084 }
        r12 = "  mUseAttentionLight=";
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r12 = r13.mUseAttentionLight;	 Catch:{ all -> 0x0084 }
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.toString();	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0084 }
        r10.<init>();	 Catch:{ all -> 0x0084 }
        r12 = "  mNotificationPulseEnabled=";
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r12 = r13.mNotificationPulseEnabled;	 Catch:{ all -> 0x0084 }
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.toString();	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0084 }
        r10.<init>();	 Catch:{ all -> 0x0084 }
        r12 = "  mSoundNotificationKey=";
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r12 = r13.mSoundNotificationKey;	 Catch:{ all -> 0x0084 }
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.toString();	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0084 }
        r10.<init>();	 Catch:{ all -> 0x0084 }
        r12 = "  mVibrateNotificationKey=";
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r12 = r13.mVibrateNotificationKey;	 Catch:{ all -> 0x0084 }
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.toString();	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0084 }
        r10.<init>();	 Catch:{ all -> 0x0084 }
        r12 = "  mDisableNotificationEffects=";
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r12 = r13.mDisableNotificationEffects;	 Catch:{ all -> 0x0084 }
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.toString();	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0084 }
        r10.<init>();	 Catch:{ all -> 0x0084 }
        r12 = "  mCallState=";
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r12 = r13.mCallState;	 Catch:{ all -> 0x0084 }
        r12 = callStateToString(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.toString();	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0084 }
        r10.<init>();	 Catch:{ all -> 0x0084 }
        r12 = "  mSystemReady=";
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r12 = r13.mSystemReady;	 Catch:{ all -> 0x0084 }
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.toString();	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
    L_0x016c:
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0084 }
        r10.<init>();	 Catch:{ all -> 0x0084 }
        r12 = "  mArchive=";
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r12 = r13.mArchive;	 Catch:{ all -> 0x0084 }
        r12 = r12.toString();	 Catch:{ all -> 0x0084 }
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.toString();	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mArchive;	 Catch:{ all -> 0x0084 }
        r4 = r10.descendingIterator();	 Catch:{ all -> 0x0084 }
        r2 = 0;
    L_0x018f:
        r10 = r4.hasNext();	 Catch:{ all -> 0x0084 }
        if (r10 == 0) goto L_0x01c9;
    L_0x0195:
        r8 = r4.next();	 Catch:{ all -> 0x0084 }
        r8 = (android.service.notification.StatusBarNotification) r8;	 Catch:{ all -> 0x0084 }
        if (r15 == 0) goto L_0x01a3;
    L_0x019d:
        r10 = r15.matches(r8);	 Catch:{ all -> 0x0084 }
        if (r10 == 0) goto L_0x018f;
    L_0x01a3:
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0084 }
        r10.<init>();	 Catch:{ all -> 0x0084 }
        r12 = "    ";
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.append(r8);	 Catch:{ all -> 0x0084 }
        r10 = r10.toString();	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r2 = r2 + 1;
        r10 = 5;
        if (r2 < r10) goto L_0x018f;
    L_0x01be:
        r10 = r4.hasNext();	 Catch:{ all -> 0x0084 }
        if (r10 == 0) goto L_0x01c9;
    L_0x01c4:
        r10 = "    ...";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
    L_0x01c9:
        if (r9 != 0) goto L_0x01d7;
    L_0x01cb:
        r10 = "\n  Usage Stats:";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mUsageStats;	 Catch:{ all -> 0x0084 }
        r12 = "    ";
        r10.dump(r14, r12, r15);	 Catch:{ all -> 0x0084 }
    L_0x01d7:
        if (r15 == 0) goto L_0x01db;
    L_0x01d9:
        if (r9 == 0) goto L_0x01fb;
    L_0x01db:
        r10 = "\n  Zen Mode:";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = "    mInterruptionFilter=";
        r14.print(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mInterruptionFilter;	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mZenModeHelper;	 Catch:{ all -> 0x0084 }
        r12 = "    ";
        r10.dump(r14, r12);	 Catch:{ all -> 0x0084 }
        r10 = "\n  Zen Log:";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = "    ";
        com.android.server.notification.ZenLog.dump(r14, r10);	 Catch:{ all -> 0x0084 }
    L_0x01fb:
        if (r9 != 0) goto L_0x0247;
    L_0x01fd:
        r10 = "\n  Ranking Config:";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mRankingHelper;	 Catch:{ all -> 0x0084 }
        r12 = "    ";
        r10.dump(r14, r12, r15);	 Catch:{ all -> 0x0084 }
        r10 = "\n  Notification listeners:";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mListeners;	 Catch:{ all -> 0x0084 }
        r10.dump(r14, r15);	 Catch:{ all -> 0x0084 }
        r10 = "    mListenerHints: ";
        r14.print(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mListenerHints;	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = "    mListenersDisablingEffects: (";
        r14.print(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mListenersDisablingEffects;	 Catch:{ all -> 0x0084 }
        r0 = r10.size();	 Catch:{ all -> 0x0084 }
        r2 = 0;
    L_0x0229:
        if (r2 >= r0) goto L_0x0242;
    L_0x022b:
        r10 = r13.mListenersDisablingEffects;	 Catch:{ all -> 0x0084 }
        r5 = r10.valueAt(r2);	 Catch:{ all -> 0x0084 }
        r5 = (com.android.server.notification.ManagedServices.ManagedServiceInfo) r5;	 Catch:{ all -> 0x0084 }
        if (r2 <= 0) goto L_0x023a;
    L_0x0235:
        r10 = 44;
        r14.print(r10);	 Catch:{ all -> 0x0084 }
    L_0x023a:
        r10 = r5.component;	 Catch:{ all -> 0x0084 }
        r14.print(r10);	 Catch:{ all -> 0x0084 }
        r2 = r2 + 1;
        goto L_0x0229;
    L_0x0242:
        r10 = 41;
        r14.println(r10);	 Catch:{ all -> 0x0084 }
    L_0x0247:
        r10 = "\n  Condition providers:";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mConditionProviders;	 Catch:{ all -> 0x0084 }
        r10.dump(r14, r15);	 Catch:{ all -> 0x0084 }
        r10 = "\n  Group summaries:";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mSummaryByGroupKey;	 Catch:{ all -> 0x0084 }
        r10 = r10.entrySet();	 Catch:{ all -> 0x0084 }
        r3 = r10.iterator();	 Catch:{ all -> 0x0084 }
    L_0x0260:
        r10 = r3.hasNext();	 Catch:{ all -> 0x0084 }
        if (r10 == 0) goto L_0x02b7;
    L_0x0266:
        r1 = r3.next();	 Catch:{ all -> 0x0084 }
        r1 = (java.util.Map.Entry) r1;	 Catch:{ all -> 0x0084 }
        r7 = r1.getValue();	 Catch:{ all -> 0x0084 }
        r7 = (com.android.server.notification.NotificationRecord) r7;	 Catch:{ all -> 0x0084 }
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0084 }
        r10.<init>();	 Catch:{ all -> 0x0084 }
        r12 = "    ";
        r12 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r1.getKey();	 Catch:{ all -> 0x0084 }
        r10 = (java.lang.String) r10;	 Catch:{ all -> 0x0084 }
        r10 = r12.append(r10);	 Catch:{ all -> 0x0084 }
        r12 = " -> ";
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r12 = r7.getKey();	 Catch:{ all -> 0x0084 }
        r10 = r10.append(r12);	 Catch:{ all -> 0x0084 }
        r10 = r10.toString();	 Catch:{ all -> 0x0084 }
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = r13.mNotificationsByKey;	 Catch:{ all -> 0x0084 }
        r12 = r7.getKey();	 Catch:{ all -> 0x0084 }
        r10 = r10.get(r12);	 Catch:{ all -> 0x0084 }
        if (r10 == r7) goto L_0x0260;
    L_0x02a8:
        r10 = "!!!!!!LEAK: Record not found in mNotificationsByKey.";
        r14.println(r10);	 Catch:{ all -> 0x0084 }
        r10 = "      ";
        r12 = r13.getContext();	 Catch:{ all -> 0x0084 }
        r7.dump(r14, r10, r12);	 Catch:{ all -> 0x0084 }
        goto L_0x0260;
    L_0x02b7:
        monitor-exit(r11);	 Catch:{ all -> 0x0084 }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.notification.NotificationManagerService.dumpImpl(java.io.PrintWriter, com.android.server.notification.NotificationManagerService$DumpFilter):void");
    }

    void enqueueNotificationInternal(String pkg, String opPkg, int callingUid, int callingPid, String tag, int id, Notification notification, int[] idOut, int incomingUserId) {
        if (DBG) {
            Slog.v(TAG, "enqueueNotificationInternal: pkg=" + pkg + " id=" + id + " notification=" + notification);
        }
        checkCallerIsSystemOrSameApp(pkg);
        boolean isSystemNotification = (isUidSystem(callingUid) || "android".equals(pkg)) ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
        boolean isNotificationFromListener = this.mListeners.isListenerPackage(pkg);
        int userId = ActivityManager.handleIncomingUser(callingPid, callingUid, incomingUserId, ENABLE_BLOCKED_TOASTS, SCORE_ONGOING_HIGHER, "enqueueNotification", pkg);
        UserHandle user = new UserHandle(userId);
        if (!(isSystemNotification || isNotificationFromListener)) {
            synchronized (this.mNotificationList) {
                int count = MY_UID;
                int N = this.mNotificationList.size();
                for (int i = MY_UID; i < N; i += REASON_DELEGATE_CLICK) {
                    NotificationRecord r = (NotificationRecord) this.mNotificationList.get(i);
                    if (r.sbn.getPackageName().equals(pkg) && r.sbn.getUserId() == userId) {
                        count += REASON_DELEGATE_CLICK;
                        if (count >= MAX_PACKAGE_NOTIFICATIONS) {
                            Slog.e(TAG, "Package has already posted " + count + " notifications.  Not showing more.  package=" + pkg);
                            return;
                        }
                    }
                }
            }
        }
        if (pkg == null || notification == null) {
            throw new IllegalArgumentException("null not allowed: pkg=" + pkg + " id=" + id + " notification=" + notification);
        } else if (notification.icon == 0 || notification.isValid()) {
            this.mHandler.post(new C04258(notification, pkg, opPkg, id, tag, callingUid, callingPid, user, userId, isSystemNotification));
            idOut[MY_UID] = id;
        } else {
            throw new IllegalArgumentException("Invalid notification (): pkg=" + pkg + " id=" + id + " notification=" + notification);
        }
    }

    private void handleGroupedNotificationLocked(NotificationRecord r, NotificationRecord old, int callingUid, int callingPid) {
        StatusBarNotification sbn = r.sbn;
        Notification n = sbn.getNotification();
        String group = sbn.getGroupKey();
        boolean isSummary = n.isGroupSummary();
        Notification oldN = old != null ? old.sbn.getNotification() : null;
        String oldGroup = old != null ? old.sbn.getGroupKey() : null;
        boolean oldIsSummary = (old == null || !oldN.isGroupSummary()) ? SCORE_ONGOING_HIGHER : ENABLE_BLOCKED_TOASTS;
        if (oldIsSummary) {
            NotificationRecord removedSummary = (NotificationRecord) this.mSummaryByGroupKey.remove(oldGroup);
            if (removedSummary != old) {
                Slog.w(TAG, "Removed summary didn't match old notification: old=" + old.getKey() + ", removed=" + (removedSummary != null ? removedSummary.getKey() : "<null>"));
            }
        }
        if (isSummary) {
            this.mSummaryByGroupKey.put(group, r);
        }
        if (!oldIsSummary) {
            return;
        }
        if (!isSummary || !oldGroup.equals(group)) {
            cancelGroupChildrenLocked(old, callingUid, callingPid, null, REASON_GROUP_SUMMARY_CANCELED);
        }
    }

    private boolean removeUnusedGroupedNotificationLocked(NotificationRecord r, NotificationRecord old, int callingUid, int callingPid) {
        if (this.mListeners.notificationGroupsDesired()) {
            return SCORE_ONGOING_HIGHER;
        }
        StatusBarNotification sbn = r.sbn;
        String group = sbn.getGroupKey();
        boolean isSummary = sbn.getNotification().isGroupSummary();
        NotificationRecord summary = (NotificationRecord) this.mSummaryByGroupKey.get(group);
        if (!sbn.getNotification().isGroupChild() || summary == null) {
            if (isSummary) {
                cancelGroupChildrenLocked(r, callingUid, callingPid, null, REASON_GROUP_OPTIMIZATION);
            }
            return SCORE_ONGOING_HIGHER;
        }
        if (DBG) {
            Slog.d(TAG, "Ignoring group child " + sbn.getKey() + " due to existing summary " + summary.getKey());
        }
        if (old != null) {
            if (DBG) {
                Slog.d(TAG, "Canceling old version of ignored group child " + sbn.getKey());
            }
            cancelNotificationLocked(old, SCORE_ONGOING_HIGHER, REASON_GROUP_OPTIMIZATION);
        }
        return ENABLE_BLOCKED_TOASTS;
    }

    private void buzzBeepBlinkLocked(NotificationRecord record) {
        long identity;
        boolean buzzBeepBlinked = SCORE_ONGOING_HIGHER;
        Notification notification = record.sbn.getNotification();
        boolean aboveThreshold = record.score >= SCORE_INTERRUPTION_THRESHOLD ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
        boolean canInterrupt = (!aboveThreshold || record.isIntercepted()) ? SCORE_ONGOING_HIGHER : ENABLE_BLOCKED_TOASTS;
        if (DBG || record.isIntercepted()) {
            Slog.v(TAG, "pkg=" + record.sbn.getPackageName() + " canInterrupt=" + canInterrupt + " intercept=" + record.isIntercepted());
        }
        long token = Binder.clearCallingIdentity();
        try {
            int currentUser = ActivityManager.getCurrentUser();
            String disableEffects = disableNotificationEffects(record);
            if (disableEffects != null) {
                ZenLog.traceDisableEffects(record, disableEffects);
            }
            if (disableEffects == null && ((!record.isUpdate || (notification.flags & REASON_NOMAN_CANCEL) == 0) && ((record.getUserId() == -1 || record.getUserId() == currentUser || this.mUserProfiles.isCurrentProfile(record.getUserId())) && canInterrupt && this.mSystemReady && this.mAudioManager != null))) {
                if (DBG) {
                    Slog.v(TAG, "Interrupting!");
                }
                sendAccessibilityEvent(notification, record.sbn.getPackageName());
                boolean useDefaultSound = ((notification.defaults & REASON_DELEGATE_CLICK) != 0 || System.DEFAULT_NOTIFICATION_URI.equals(notification.sound)) ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
                Uri soundUri = null;
                boolean hasValidSound = SCORE_ONGOING_HIGHER;
                if (useDefaultSound) {
                    soundUri = System.DEFAULT_NOTIFICATION_URI;
                    hasValidSound = System.getString(getContext().getContentResolver(), "notification_sound") != null ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
                } else if (notification.sound != null) {
                    soundUri = notification.sound;
                    hasValidSound = soundUri != null ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
                }
                if (hasValidSound) {
                    boolean looping = (notification.flags & REASON_DELEGATE_ERROR) != 0 ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
                    AudioAttributes audioAttributes = audioAttributesForNotification(notification);
                    this.mSoundNotificationKey = record.getKey();
                    if (!(this.mAudioManager.getStreamVolume(AudioAttributes.toLegacyStreamType(audioAttributes)) == 0 || this.mAudioManager.isAudioFocusExclusive())) {
                        identity = Binder.clearCallingIdentity();
                        try {
                            IRingtonePlayer player = this.mAudioManager.getRingtonePlayer();
                            if (player != null) {
                                if (DBG) {
                                    Slog.v(TAG, "Playing sound " + soundUri + " with attributes " + audioAttributes);
                                }
                                player.playAsync(soundUri, record.sbn.getUser(), looping, audioAttributes);
                                buzzBeepBlinked = ENABLE_BLOCKED_TOASTS;
                            }
                            Binder.restoreCallingIdentity(identity);
                        } catch (RemoteException e) {
                        } catch (Throwable th) {
                            Binder.restoreCallingIdentity(identity);
                        }
                    }
                }
                boolean hasCustomVibrate = notification.vibrate != null ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
                boolean convertSoundToVibration = (!hasCustomVibrate && hasValidSound && this.mAudioManager.getRingerModeInternal() == REASON_DELEGATE_CLICK) ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
                boolean useDefaultVibrate = (notification.defaults & REASON_DELEGATE_CANCEL) != 0 ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
                if ((useDefaultVibrate || convertSoundToVibration || hasCustomVibrate) && this.mAudioManager.getRingerModeInternal() != 0) {
                    this.mVibrateNotificationKey = record.getKey();
                    if (useDefaultVibrate || convertSoundToVibration) {
                        identity = Binder.clearCallingIdentity();
                        try {
                            this.mVibrator.vibrate(record.sbn.getUid(), record.sbn.getOpPkg(), useDefaultVibrate ? this.mDefaultVibrationPattern : this.mFallbackVibrationPattern, (notification.flags & REASON_DELEGATE_ERROR) != 0 ? MY_UID : -1, audioAttributesForNotification(notification));
                            buzzBeepBlinked = ENABLE_BLOCKED_TOASTS;
                        } finally {
                            Binder.restoreCallingIdentity(identity);
                        }
                    } else if (notification.vibrate.length > REASON_DELEGATE_CLICK) {
                        this.mVibrator.vibrate(record.sbn.getUid(), record.sbn.getOpPkg(), notification.vibrate, (notification.flags & REASON_DELEGATE_ERROR) != 0 ? MY_UID : -1, audioAttributesForNotification(notification));
                        buzzBeepBlinked = ENABLE_BLOCKED_TOASTS;
                    }
                }
            }
            boolean wasShowLights = this.mLights.remove(record.getKey());
            if ((notification.flags & REASON_DELEGATE_CLICK) != 0 && aboveThreshold) {
                this.mLights.add(record.getKey());
                updateLightsLocked();
                if (this.mUseAttentionLight) {
                    this.mAttentionLight.pulse();
                }
                buzzBeepBlinked = ENABLE_BLOCKED_TOASTS;
            } else if (wasShowLights) {
                updateLightsLocked();
            }
            if (buzzBeepBlinked) {
                this.mHandler.post(this.mBuzzBeepBlinked);
            }
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    private static AudioAttributes audioAttributesForNotification(Notification n) {
        if (n.audioAttributes != null && !Notification.AUDIO_ATTRIBUTES_DEFAULT.equals(n.audioAttributes)) {
            return n.audioAttributes;
        }
        if (n.audioStreamType >= 0 && n.audioStreamType < AudioSystem.getNumStreamTypes()) {
            return new Builder().setInternalLegacyStreamType(n.audioStreamType).build();
        }
        if (n.audioStreamType == -1) {
            return Notification.AUDIO_ATTRIBUTES_DEFAULT;
        }
        String str = TAG;
        Object[] objArr = new Object[REASON_DELEGATE_CLICK];
        objArr[MY_UID] = Integer.valueOf(n.audioStreamType);
        Log.w(str, String.format("Invalid stream type: %d", objArr));
        return Notification.AUDIO_ATTRIBUTES_DEFAULT;
    }

    void showNextToastLocked() {
        ToastRecord record = (ToastRecord) this.mToastQueue.get(MY_UID);
        while (record != null) {
            if (DBG) {
                Slog.d(TAG, "Show pkg=" + record.pkg + " callback=" + record.callback);
            }
            try {
                record.callback.show();
                scheduleTimeoutLocked(record);
                return;
            } catch (RemoteException e) {
                Slog.w(TAG, "Object died trying to show notification " + record.callback + " in package " + record.pkg);
                int index = this.mToastQueue.indexOf(record);
                if (index >= 0) {
                    this.mToastQueue.remove(index);
                }
                keepProcessAliveLocked(record.pid);
                if (this.mToastQueue.size() > 0) {
                    record = (ToastRecord) this.mToastQueue.get(MY_UID);
                } else {
                    record = null;
                }
            }
        }
    }

    void cancelToastLocked(int index) {
        ToastRecord record = (ToastRecord) this.mToastQueue.get(index);
        try {
            record.callback.hide();
        } catch (RemoteException e) {
            Slog.w(TAG, "Object died trying to hide notification " + record.callback + " in package " + record.pkg);
        }
        this.mToastQueue.remove(index);
        keepProcessAliveLocked(record.pid);
        if (this.mToastQueue.size() > 0) {
            showNextToastLocked();
        }
    }

    private void scheduleTimeoutLocked(ToastRecord r) {
        this.mHandler.removeCallbacksAndMessages(r);
        this.mHandler.sendMessageDelayed(Message.obtain(this.mHandler, REASON_DELEGATE_CANCEL, r), r.duration == REASON_DELEGATE_CLICK ? 3500 : 2000);
    }

    private void handleTimeout(ToastRecord record) {
        if (DBG) {
            Slog.d(TAG, "Timeout pkg=" + record.pkg + " callback=" + record.callback);
        }
        synchronized (this.mToastQueue) {
            int index = indexOfToastLocked(record.pkg, record.callback);
            if (index >= 0) {
                cancelToastLocked(index);
            }
        }
    }

    int indexOfToastLocked(String pkg, ITransientNotification callback) {
        IBinder cbak = callback.asBinder();
        ArrayList<ToastRecord> list = this.mToastQueue;
        int len = list.size();
        for (int i = MY_UID; i < len; i += REASON_DELEGATE_CLICK) {
            ToastRecord r = (ToastRecord) list.get(i);
            if (r.pkg.equals(pkg) && r.callback.asBinder() == cbak) {
                return i;
            }
        }
        return -1;
    }

    void keepProcessAliveLocked(int pid) {
        int toastCount = MY_UID;
        ArrayList<ToastRecord> list = this.mToastQueue;
        int N = list.size();
        for (int i = MY_UID; i < N; i += REASON_DELEGATE_CLICK) {
            if (((ToastRecord) list.get(i)).pid == pid) {
                toastCount += REASON_DELEGATE_CLICK;
            }
        }
        try {
            this.mAm.setProcessForeground(this.mForegroundToken, pid, toastCount > 0 ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER);
        } catch (RemoteException e) {
        }
    }

    private void handleRankingReconsideration(Message message) {
        if (message.obj instanceof RankingReconsideration) {
            RankingReconsideration recon = message.obj;
            recon.run();
            synchronized (this.mNotificationList) {
                NotificationRecord record = (NotificationRecord) this.mNotificationsByKey.get(recon.getKey());
                if (record == null) {
                    return;
                }
                int indexBefore = findNotificationRecordIndexLocked(record);
                boolean interceptBefore = record.isIntercepted();
                int visibilityBefore = record.getPackageVisibilityOverride();
                recon.applyChangesLocked(record);
                applyZenModeLocked(record);
                this.mRankingHelper.sort(this.mNotificationList);
                int indexAfter = findNotificationRecordIndexLocked(record);
                boolean interceptAfter = record.isIntercepted();
                boolean changed = (indexBefore == indexAfter && interceptBefore == interceptAfter && visibilityBefore == record.getPackageVisibilityOverride()) ? SCORE_ONGOING_HIGHER : ENABLE_BLOCKED_TOASTS;
                if (interceptBefore && !interceptAfter) {
                    buzzBeepBlinkLocked(record);
                }
                if (changed) {
                    scheduleSendRankingUpdate();
                }
            }
        }
    }

    private void handleRankingConfigChange() {
        synchronized (this.mNotificationList) {
            int i;
            int N = this.mNotificationList.size();
            ArrayList<String> orderBefore = new ArrayList(N);
            int[] visibilities = new int[N];
            for (i = MY_UID; i < N; i += REASON_DELEGATE_CLICK) {
                NotificationRecord r = (NotificationRecord) this.mNotificationList.get(i);
                orderBefore.add(r.getKey());
                visibilities[i] = r.getPackageVisibilityOverride();
                this.mRankingHelper.extractSignals(r);
            }
            i = MY_UID;
            while (i < N) {
                this.mRankingHelper.sort(this.mNotificationList);
                r = (NotificationRecord) this.mNotificationList.get(i);
                if (((String) orderBefore.get(i)).equals(r.getKey()) && visibilities[i] == r.getPackageVisibilityOverride()) {
                    i += REASON_DELEGATE_CLICK;
                } else {
                    scheduleSendRankingUpdate();
                    return;
                }
            }
        }
    }

    private void applyZenModeLocked(NotificationRecord record) {
        record.setIntercepted(this.mZenModeHelper.shouldIntercept(record));
    }

    private int findNotificationRecordIndexLocked(NotificationRecord target) {
        return this.mRankingHelper.indexOf(this.mNotificationList, target);
    }

    private void scheduleSendRankingUpdate() {
        this.mHandler.removeMessages(REASON_USER_STOPPED);
        this.mHandler.sendMessage(Message.obtain(this.mHandler, REASON_USER_STOPPED));
    }

    private void handleSendRankingUpdate() {
        synchronized (this.mNotificationList) {
            this.mListeners.notifyRankingUpdateLocked();
        }
    }

    private void scheduleListenerHintsChanged(int state) {
        this.mHandler.removeMessages(REASON_PACKAGE_BANNED);
        this.mHandler.obtainMessage(REASON_PACKAGE_BANNED, state, MY_UID).sendToTarget();
    }

    private void scheduleInterruptionFilterChanged(int listenerInterruptionFilter) {
        this.mHandler.removeMessages(REASON_NOMAN_CANCEL);
        this.mHandler.obtainMessage(REASON_NOMAN_CANCEL, listenerInterruptionFilter, MY_UID).sendToTarget();
    }

    private void handleListenerHintsChanged(int hints) {
        synchronized (this.mNotificationList) {
            this.mListeners.notifyListenerHintsChangedLocked(hints);
        }
    }

    private void handleListenerInterruptionFilterChanged(int interruptionFilter) {
        synchronized (this.mNotificationList) {
            this.mListeners.notifyInterruptionFilterChanged(interruptionFilter);
        }
    }

    static int clamp(int x, int low, int high) {
        if (x < low) {
            return low;
        }
        return x > high ? high : x;
    }

    void sendAccessibilityEvent(Notification notification, CharSequence packageName) {
        AccessibilityManager manager = AccessibilityManager.getInstance(getContext());
        if (manager.isEnabled()) {
            AccessibilityEvent event = AccessibilityEvent.obtain(64);
            event.setPackageName(packageName);
            event.setClassName(Notification.class.getName());
            event.setParcelableData(notification);
            CharSequence tickerText = notification.tickerText;
            if (!TextUtils.isEmpty(tickerText)) {
                event.getText().add(tickerText);
            }
            manager.sendAccessibilityEvent(event);
        }
    }

    private void cancelNotificationLocked(NotificationRecord r, boolean sendDelete, int reason) {
        long identity;
        if (sendDelete && r.getNotification().deleteIntent != null) {
            try {
                r.getNotification().deleteIntent.send();
            } catch (CanceledException ex) {
                Slog.w(TAG, "canceled PendingIntent for " + r.sbn.getPackageName(), ex);
            }
        }
        if (r.getNotification().icon != 0) {
            r.isCanceled = ENABLE_BLOCKED_TOASTS;
            this.mListeners.notifyRemovedLocked(r.sbn);
        }
        String canceledKey = r.getKey();
        if (canceledKey.equals(this.mSoundNotificationKey)) {
            this.mSoundNotificationKey = null;
            identity = Binder.clearCallingIdentity();
            try {
                IRingtonePlayer player = this.mAudioManager.getRingtonePlayer();
                if (player != null) {
                    player.stopAsync();
                }
                Binder.restoreCallingIdentity(identity);
            } catch (RemoteException e) {
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(identity);
            }
        }
        if (canceledKey.equals(this.mVibrateNotificationKey)) {
            this.mVibrateNotificationKey = null;
            identity = Binder.clearCallingIdentity();
            try {
                this.mVibrator.cancel();
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }
        this.mLights.remove(canceledKey);
        switch (reason) {
            case REASON_DELEGATE_CLICK /*1*/:
                this.mUsageStats.registerCancelDueToClick(r);
                break;
            case REASON_DELEGATE_CANCEL /*2*/:
            case REASON_DELEGATE_CANCEL_ALL /*3*/:
            case REASON_LISTENER_CANCEL /*10*/:
            case REASON_LISTENER_CANCEL_ALL /*11*/:
                this.mUsageStats.registerDismissedByUser(r);
                break;
            case REASON_NOMAN_CANCEL /*8*/:
            case REASON_NOMAN_CANCEL_ALL /*9*/:
                this.mUsageStats.registerRemovedByApp(r);
                break;
            default:
                this.mUsageStats.registerCancelUnknown(r);
                break;
        }
        this.mNotificationsByKey.remove(r.sbn.getKey());
        String groupKey = r.getGroupKey();
        NotificationRecord groupSummary = (NotificationRecord) this.mSummaryByGroupKey.get(groupKey);
        if (groupSummary != null && groupSummary.getKey().equals(r.getKey())) {
            this.mSummaryByGroupKey.remove(groupKey);
        }
        this.mArchive.record(r.sbn);
        EventLogTags.writeNotificationCanceled(canceledKey, reason);
    }

    void cancelNotification(int callingUid, int callingPid, String pkg, String tag, int id, int mustHaveFlags, int mustNotHaveFlags, boolean sendDelete, int userId, int reason, ManagedServiceInfo listener) {
        this.mHandler.post(new C04269(listener, callingUid, callingPid, pkg, id, tag, userId, mustHaveFlags, mustNotHaveFlags, reason, sendDelete));
    }

    private boolean notificationMatchesUserId(NotificationRecord r, int userId) {
        return (userId == -1 || r.getUserId() == -1 || r.getUserId() == userId) ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
    }

    private boolean notificationMatchesCurrentProfiles(NotificationRecord r, int userId) {
        return (notificationMatchesUserId(r, userId) || this.mUserProfiles.isCurrentProfile(r.getUserId())) ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    boolean cancelAllNotificationsInt(int r16, int r17, java.lang.String r18, int r19, int r20, boolean r21, int r22, int r23, com.android.server.notification.ManagedServices.ManagedServiceInfo r24) {
        /*
        r15 = this;
        if (r24 != 0) goto L_0x0035;
    L_0x0002:
        r8 = 0;
    L_0x0003:
        r1 = r16;
        r2 = r17;
        r3 = r18;
        r4 = r22;
        r5 = r19;
        r6 = r20;
        r7 = r23;
        com.android.server.EventLogTags.writeNotificationCancelAll(r1, r2, r3, r4, r5, r6, r7, r8);
        r2 = r15.mNotificationList;
        monitor-enter(r2);
        r1 = r15.mNotificationList;	 Catch:{ all -> 0x0084 }
        r11 = r1.size();	 Catch:{ all -> 0x0084 }
        r12 = 0;
        r13 = r11 + -1;
    L_0x0020:
        if (r13 < 0) goto L_0x0087;
    L_0x0022:
        r1 = r15.mNotificationList;	 Catch:{ all -> 0x0084 }
        r14 = r1.get(r13);	 Catch:{ all -> 0x0084 }
        r14 = (com.android.server.notification.NotificationRecord) r14;	 Catch:{ all -> 0x0084 }
        r0 = r22;
        r1 = r15.notificationMatchesUserId(r14, r0);	 Catch:{ all -> 0x0084 }
        if (r1 != 0) goto L_0x003e;
    L_0x0032:
        r13 = r13 + -1;
        goto L_0x0020;
    L_0x0035:
        r0 = r24;
        r1 = r0.component;
        r8 = r1.toShortString();
        goto L_0x0003;
    L_0x003e:
        r1 = r14.getUserId();	 Catch:{ all -> 0x0084 }
        r3 = -1;
        if (r1 != r3) goto L_0x0047;
    L_0x0045:
        if (r18 == 0) goto L_0x0032;
    L_0x0047:
        r1 = r14.getFlags();	 Catch:{ all -> 0x0084 }
        r1 = r1 & r19;
        r0 = r19;
        if (r1 != r0) goto L_0x0032;
    L_0x0051:
        r1 = r14.getFlags();	 Catch:{ all -> 0x0084 }
        r1 = r1 & r20;
        if (r1 != 0) goto L_0x0032;
    L_0x0059:
        if (r18 == 0) goto L_0x0069;
    L_0x005b:
        r1 = r14.sbn;	 Catch:{ all -> 0x0084 }
        r1 = r1.getPackageName();	 Catch:{ all -> 0x0084 }
        r0 = r18;
        r1 = r1.equals(r0);	 Catch:{ all -> 0x0084 }
        if (r1 == 0) goto L_0x0032;
    L_0x0069:
        if (r12 != 0) goto L_0x0070;
    L_0x006b:
        r12 = new java.util.ArrayList;	 Catch:{ all -> 0x0084 }
        r12.<init>();	 Catch:{ all -> 0x0084 }
    L_0x0070:
        r12.add(r14);	 Catch:{ all -> 0x0084 }
        if (r21 != 0) goto L_0x0078;
    L_0x0075:
        r1 = 1;
        monitor-exit(r2);	 Catch:{ all -> 0x0084 }
    L_0x0077:
        return r1;
    L_0x0078:
        r1 = r15.mNotificationList;	 Catch:{ all -> 0x0084 }
        r1.remove(r13);	 Catch:{ all -> 0x0084 }
        r1 = 0;
        r0 = r23;
        r15.cancelNotificationLocked(r14, r1, r0);	 Catch:{ all -> 0x0084 }
        goto L_0x0032;
    L_0x0084:
        r1 = move-exception;
        monitor-exit(r2);	 Catch:{ all -> 0x0084 }
        throw r1;
    L_0x0087:
        if (r21 == 0) goto L_0x00a5;
    L_0x0089:
        if (r12 == 0) goto L_0x00a5;
    L_0x008b:
        r10 = r12.size();	 Catch:{ all -> 0x0084 }
        r13 = 0;
    L_0x0090:
        if (r13 >= r10) goto L_0x00a5;
    L_0x0092:
        r5 = r12.get(r13);	 Catch:{ all -> 0x0084 }
        r5 = (com.android.server.notification.NotificationRecord) r5;	 Catch:{ all -> 0x0084 }
        r9 = 12;
        r4 = r15;
        r6 = r16;
        r7 = r17;
        r4.cancelGroupChildrenLocked(r5, r6, r7, r8, r9);	 Catch:{ all -> 0x0084 }
        r13 = r13 + 1;
        goto L_0x0090;
    L_0x00a5:
        if (r12 == 0) goto L_0x00aa;
    L_0x00a7:
        r15.updateLightsLocked();	 Catch:{ all -> 0x0084 }
    L_0x00aa:
        if (r12 == 0) goto L_0x00af;
    L_0x00ac:
        r1 = 1;
    L_0x00ad:
        monitor-exit(r2);	 Catch:{ all -> 0x0084 }
        goto L_0x0077;
    L_0x00af:
        r1 = 0;
        goto L_0x00ad;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.notification.NotificationManagerService.cancelAllNotificationsInt(int, int, java.lang.String, int, int, boolean, int, int, com.android.server.notification.ManagedServices$ManagedServiceInfo):boolean");
    }

    void cancelAllLocked(int callingUid, int callingPid, int userId, int reason, ManagedServiceInfo listener, boolean includeCurrentProfiles) {
        String listenerName;
        int i;
        if (listener == null) {
            listenerName = null;
        } else {
            listenerName = listener.component.toShortString();
        }
        EventLogTags.writeNotificationCancelAll(callingUid, callingPid, null, userId, MY_UID, MY_UID, reason, listenerName);
        ArrayList<NotificationRecord> canceledNotifications = null;
        for (i = this.mNotificationList.size() - 1; i >= 0; i--) {
            NotificationRecord r = (NotificationRecord) this.mNotificationList.get(i);
            if (includeCurrentProfiles) {
                if (!notificationMatchesCurrentProfiles(r, userId)) {
                }
                if ((r.getFlags() & 34) == 0) {
                    this.mNotificationList.remove(i);
                    cancelNotificationLocked(r, ENABLE_BLOCKED_TOASTS, reason);
                    if (canceledNotifications == null) {
                        canceledNotifications = new ArrayList();
                    }
                    canceledNotifications.add(r);
                }
            } else {
                if (!notificationMatchesUserId(r, userId)) {
                }
                if ((r.getFlags() & 34) == 0) {
                    this.mNotificationList.remove(i);
                    cancelNotificationLocked(r, ENABLE_BLOCKED_TOASTS, reason);
                    if (canceledNotifications == null) {
                        canceledNotifications = new ArrayList();
                    }
                    canceledNotifications.add(r);
                }
            }
        }
        int M = canceledNotifications != null ? canceledNotifications.size() : MY_UID;
        for (i = MY_UID; i < M; i += REASON_DELEGATE_CLICK) {
            cancelGroupChildrenLocked((NotificationRecord) canceledNotifications.get(i), callingUid, callingPid, listenerName, REASON_GROUP_SUMMARY_CANCELED);
        }
        updateLightsLocked();
    }

    private void cancelGroupChildrenLocked(NotificationRecord r, int callingUid, int callingPid, String listenerName, int reason) {
        if (r.getNotification().isGroupSummary()) {
            String pkg = r.sbn.getPackageName();
            int userId = r.getUserId();
            if (pkg != null) {
                for (int i = this.mNotificationList.size() - 1; i >= 0; i--) {
                    NotificationRecord childR = (NotificationRecord) this.mNotificationList.get(i);
                    StatusBarNotification childSbn = childR.sbn;
                    if (childR.getNotification().isGroupChild() && childR.getGroupKey().equals(r.getGroupKey())) {
                        EventLogTags.writeNotificationCancel(callingUid, callingPid, pkg, childSbn.getId(), childSbn.getTag(), userId, MY_UID, MY_UID, reason, listenerName);
                        this.mNotificationList.remove(i);
                        cancelNotificationLocked(childR, SCORE_ONGOING_HIGHER, reason);
                    }
                }
            } else if (DBG) {
                Log.e(TAG, "No package for group summary: " + r.getKey());
            }
        }
    }

    void updateLightsLocked() {
        NotificationRecord ledNotification = null;
        while (ledNotification == null && !this.mLights.isEmpty()) {
            String owner = (String) this.mLights.get(this.mLights.size() - 1);
            ledNotification = (NotificationRecord) this.mNotificationsByKey.get(owner);
            if (ledNotification == null) {
                Slog.wtfStack(TAG, "LED Notification does not exist: " + owner);
                this.mLights.remove(owner);
            }
        }
        if (ledNotification == null || this.mInCall || this.mScreenOn) {
            this.mNotificationLight.turnOff();
            this.mStatusBar.notificationLightOff();
            return;
        }
        Notification ledno = ledNotification.sbn.getNotification();
        int ledARGB = ledno.ledARGB;
        int ledOnMS = ledno.ledOnMS;
        int ledOffMS = ledno.ledOffMS;
        if ((ledno.defaults & REASON_DELEGATE_ERROR) != 0) {
            ledARGB = this.mDefaultNotificationColor;
            ledOnMS = this.mDefaultNotificationLedOn;
            ledOffMS = this.mDefaultNotificationLedOff;
        }
        if (this.mNotificationPulseEnabled) {
            this.mNotificationLight.setFlashing(ledARGB, REASON_DELEGATE_CLICK, ledOnMS, ledOffMS);
        }
        this.mStatusBar.notificationLightPulse(ledARGB, ledOnMS, ledOffMS);
    }

    int indexOfNotificationLocked(String pkg, String tag, int id, int userId) {
        ArrayList<NotificationRecord> list = this.mNotificationList;
        int len = list.size();
        for (int i = MY_UID; i < len; i += REASON_DELEGATE_CLICK) {
            NotificationRecord r = (NotificationRecord) list.get(i);
            if (notificationMatchesUserId(r, userId) && r.sbn.getId() == id) {
                if (tag == null) {
                    if (r.sbn.getTag() != null) {
                        continue;
                    }
                } else if (!tag.equals(r.sbn.getTag())) {
                }
                if (r.sbn.getPackageName().equals(pkg)) {
                    return i;
                }
            }
        }
        return -1;
    }

    int indexOfNotificationLocked(String key) {
        int N = this.mNotificationList.size();
        for (int i = MY_UID; i < N; i += REASON_DELEGATE_CLICK) {
            if (key.equals(((NotificationRecord) this.mNotificationList.get(i)).getKey())) {
                return i;
            }
        }
        return -1;
    }

    private void updateNotificationPulse() {
        synchronized (this.mNotificationList) {
            updateLightsLocked();
        }
    }

    private static boolean isUidSystem(int uid) {
        int appid = UserHandle.getAppId(uid);
        return (appid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || appid == 1001 || uid == 0) ? ENABLE_BLOCKED_TOASTS : SCORE_ONGOING_HIGHER;
    }

    private static boolean isCallerSystem() {
        return isUidSystem(Binder.getCallingUid());
    }

    private static void checkCallerIsSystem() {
        if (!isCallerSystem()) {
            throw new SecurityException("Disallowed call for uid " + Binder.getCallingUid());
        }
    }

    private static void checkCallerIsSystemOrSameApp(String pkg) {
        if (!isCallerSystem()) {
            int uid = Binder.getCallingUid();
            try {
                ApplicationInfo ai = AppGlobals.getPackageManager().getApplicationInfo(pkg, MY_UID, UserHandle.getCallingUserId());
                if (ai == null) {
                    throw new SecurityException("Unknown package " + pkg);
                } else if (!UserHandle.isSameApp(ai.uid, uid)) {
                    throw new SecurityException("Calling uid " + uid + " gave package" + pkg + " which is owned by uid " + ai.uid);
                }
            } catch (RemoteException re) {
                throw new SecurityException("Unknown package " + pkg + "\n" + re);
            }
        }
    }

    private static String callStateToString(int state) {
        switch (state) {
            case MY_UID:
                return "CALL_STATE_IDLE";
            case REASON_DELEGATE_CLICK /*1*/:
                return "CALL_STATE_RINGING";
            case REASON_DELEGATE_CANCEL /*2*/:
                return "CALL_STATE_OFFHOOK";
            default:
                return "CALL_STATE_UNKNOWN_" + state;
        }
    }

    private void listenForCallState() {
        TelephonyManager.from(getContext()).listen(new PhoneStateListener() {
            public void onCallStateChanged(int state, String incomingNumber) {
                if (NotificationManagerService.this.mCallState != state) {
                    if (NotificationManagerService.DBG) {
                        Slog.d(NotificationManagerService.TAG, "Call state changed: " + NotificationManagerService.callStateToString(state));
                    }
                    NotificationManagerService.this.mCallState = state;
                }
            }
        }, 32);
    }

    private NotificationRankingUpdate makeRankingUpdateLocked(ManagedServiceInfo info) {
        int speedBumpIndex = -1;
        int N = this.mNotificationList.size();
        ArrayList<String> keys = new ArrayList(N);
        ArrayList<String> interceptedKeys = new ArrayList(N);
        Bundle visibilityOverrides = new Bundle();
        for (int i = MY_UID; i < N; i += REASON_DELEGATE_CLICK) {
            NotificationRecord record = (NotificationRecord) this.mNotificationList.get(i);
            if (isVisibleToListener(record.sbn, info)) {
                keys.add(record.sbn.getKey());
                if (record.isIntercepted()) {
                    interceptedKeys.add(record.sbn.getKey());
                }
                if (record.getPackageVisibilityOverride() != JUNK_SCORE) {
                    visibilityOverrides.putInt(record.sbn.getKey(), record.getPackageVisibilityOverride());
                }
                if (speedBumpIndex == -1 && !record.isRecentlyIntrusive() && record.getPackagePriority() <= 0 && record.sbn.getNotification().priority == -2) {
                    speedBumpIndex = keys.size() - 1;
                }
            }
        }
        return new NotificationRankingUpdate((String[]) keys.toArray(new String[keys.size()]), (String[]) interceptedKeys.toArray(new String[interceptedKeys.size()]), visibilityOverrides, speedBumpIndex);
    }

    private boolean isVisibleToListener(StatusBarNotification sbn, ManagedServiceInfo listener) {
        if (listener.enabledAndUserMatches(sbn.getUserId())) {
            return ENABLE_BLOCKED_TOASTS;
        }
        return SCORE_ONGOING_HIGHER;
    }
}
