package com.android.server.pm;

import android.app.ActivityManager;
import android.app.ActivityManagerNative;
import android.app.IStopUserCallback;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.UserInfo;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.BitmapFactory;
import android.os.Binder;
import android.os.Bundle;
import android.os.Environment;
import android.os.FileUtils;
import android.os.Handler;
import android.os.IUserManager.Stub;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.UserHandle;
import android.os.UserManager;
import android.util.AtomicFile;
import android.util.Log;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseBooleanArray;
import android.util.TimeUtils;
import android.util.Xml;
import com.android.internal.app.IAppOpsService;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.FastXmlSerializer;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class UserManagerService extends Stub {
    private static final String ATTR_CREATION_TIME = "created";
    private static final String ATTR_FAILED_ATTEMPTS = "failedAttempts";
    private static final String ATTR_FLAGS = "flags";
    private static final String ATTR_GUEST_TO_REMOVE = "guestToRemove";
    private static final String ATTR_ICON_PATH = "icon";
    private static final String ATTR_ID = "id";
    private static final String ATTR_KEY = "key";
    private static final String ATTR_LAST_LOGGED_IN_TIME = "lastLoggedIn";
    private static final String ATTR_LAST_RETRY_MS = "lastAttemptMs";
    private static final String ATTR_MULTIPLE = "m";
    private static final String ATTR_NEXT_SERIAL_NO = "nextSerialNumber";
    private static final String ATTR_PARTIAL = "partial";
    private static final String ATTR_PIN_HASH = "pinHash";
    private static final String ATTR_PROFILE_GROUP_ID = "profileGroupId";
    private static final String ATTR_SALT = "salt";
    private static final String ATTR_SERIAL_NO = "serialNumber";
    private static final String ATTR_TYPE_BOOLEAN = "b";
    private static final String ATTR_TYPE_INTEGER = "i";
    private static final String ATTR_TYPE_STRING = "s";
    private static final String ATTR_TYPE_STRING_ARRAY = "sa";
    private static final String ATTR_USER_VERSION = "version";
    private static final String ATTR_VALUE_TYPE = "type";
    private static final int BACKOFF_INC_INTERVAL = 5;
    private static final int[] BACKOFF_TIMES;
    private static final boolean DBG = false;
    private static final long EPOCH_PLUS_30_YEARS = 946080000000L;
    private static final String LOG_TAG = "UserManagerService";
    private static final int MAX_MANAGED_PROFILES = 1;
    private static final int MIN_USER_ID = 10;
    private static final String RESTRICTIONS_FILE_PREFIX = "res_";
    private static final String TAG_ENTRY = "entry";
    private static final String TAG_GUEST_RESTRICTIONS = "guestRestrictions";
    private static final String TAG_NAME = "name";
    private static final String TAG_RESTRICTIONS = "restrictions";
    private static final String TAG_USER = "user";
    private static final String TAG_USERS = "users";
    private static final String TAG_VALUE = "value";
    private static final String USER_INFO_DIR;
    private static final String USER_LIST_FILENAME = "userlist.xml";
    private static final String USER_PHOTO_FILENAME = "photo.png";
    private static final int USER_VERSION = 5;
    private static final String XML_SUFFIX = ".xml";
    private static UserManagerService sInstance;
    private IAppOpsService mAppOpsService;
    private final File mBaseUserPath;
    private final Context mContext;
    private final Bundle mGuestRestrictions;
    private final Handler mHandler;
    private final Object mInstallLock;
    private int mNextSerialNumber;
    private final Object mPackagesLock;
    private final PackageManagerService mPm;
    private final SparseBooleanArray mRemovingUserIds;
    private final SparseArray<RestrictionsPinState> mRestrictionsPinStates;
    private int[] mUserIds;
    private final File mUserListFile;
    private final SparseArray<Bundle> mUserRestrictions;
    private int mUserVersion;
    private final SparseArray<UserInfo> mUsers;
    private final File mUsersDir;

    /* renamed from: com.android.server.pm.UserManagerService.1 */
    class C04591 extends IStopUserCallback.Stub {
        C04591() {
        }

        public void userStopped(int userId) {
            UserManagerService.this.finishRemoveUser(userId);
        }

        public void userStopAborted(int userId) {
        }
    }

    /* renamed from: com.android.server.pm.UserManagerService.2 */
    class C04612 extends BroadcastReceiver {
        final /* synthetic */ int val$userHandle;

        /* renamed from: com.android.server.pm.UserManagerService.2.1 */
        class C04601 extends Thread {
            C04601() {
            }

            public void run() {
                synchronized (UserManagerService.this.mInstallLock) {
                    synchronized (UserManagerService.this.mPackagesLock) {
                        UserManagerService.this.removeUserStateLocked(C04612.this.val$userHandle);
                    }
                }
            }
        }

        C04612(int i) {
            this.val$userHandle = i;
        }

        public void onReceive(Context context, Intent intent) {
            new C04601().start();
        }
    }

    /* renamed from: com.android.server.pm.UserManagerService.3 */
    class C04623 implements Runnable {
        final /* synthetic */ int val$userHandle;

        C04623(int i) {
            this.val$userHandle = i;
        }

        public void run() {
            List<ApplicationInfo> apps = UserManagerService.this.mPm.getInstalledApplications(DumpState.DUMP_INSTALLS, this.val$userHandle).getList();
            long ident = Binder.clearCallingIdentity();
            try {
                for (ApplicationInfo appInfo : apps) {
                    if (!((appInfo.flags & 8388608) == 0 || (appInfo.flags & 134217728) == 0)) {
                        UserManagerService.this.mPm.setApplicationHiddenSettingAsUser(appInfo.packageName, UserManagerService.DBG, this.val$userHandle);
                    }
                }
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    class RestrictionsPinState {
        int failedAttempts;
        long lastAttemptTime;
        String pinHash;
        long salt;

        RestrictionsPinState() {
        }
    }

    static {
        USER_INFO_DIR = "system" + File.separator + TAG_USERS;
        BACKOFF_TIMES = new int[]{0, 30000, 60000, 300000, ProcessList.PSS_MAX_INTERVAL};
    }

    public static UserManagerService getInstance() {
        UserManagerService userManagerService;
        synchronized (UserManagerService.class) {
            userManagerService = sInstance;
        }
        return userManagerService;
    }

    UserManagerService(File dataDir, File baseUserPath) {
        this(null, null, new Object(), new Object(), dataDir, baseUserPath);
    }

    UserManagerService(Context context, PackageManagerService pm, Object installLock, Object packagesLock) {
        this(context, pm, installLock, packagesLock, Environment.getDataDirectory(), new File(Environment.getDataDirectory(), TAG_USER));
    }

    private UserManagerService(Context context, PackageManagerService pm, Object installLock, Object packagesLock, File dataDir, File baseUserPath) {
        this.mUsers = new SparseArray();
        this.mUserRestrictions = new SparseArray();
        this.mGuestRestrictions = new Bundle();
        this.mRestrictionsPinStates = new SparseArray();
        this.mRemovingUserIds = new SparseBooleanArray();
        this.mUserVersion = 0;
        this.mContext = context;
        this.mPm = pm;
        this.mInstallLock = installLock;
        this.mPackagesLock = packagesLock;
        this.mHandler = new Handler();
        synchronized (this.mInstallLock) {
            synchronized (this.mPackagesLock) {
                this.mUsersDir = new File(dataDir, USER_INFO_DIR);
                this.mUsersDir.mkdirs();
                new File(this.mUsersDir, "0").mkdirs();
                this.mBaseUserPath = baseUserPath;
                FileUtils.setPermissions(this.mUsersDir.toString(), 509, -1, -1);
                this.mUserListFile = new File(this.mUsersDir, USER_LIST_FILENAME);
                initDefaultGuestRestrictions();
                readUserListLocked();
                ArrayList<UserInfo> partials = new ArrayList();
                int i = 0;
                while (i < this.mUsers.size()) {
                    UserInfo ui = (UserInfo) this.mUsers.valueAt(i);
                    if ((ui.partial || ui.guestToRemove) && i != 0) {
                        partials.add(ui);
                    }
                    i += MAX_MANAGED_PROFILES;
                }
                for (i = 0; i < partials.size(); i += MAX_MANAGED_PROFILES) {
                    ui = (UserInfo) partials.get(i);
                    Slog.w(LOG_TAG, "Removing partially created user #" + i + " (name=" + ui.name + ")");
                    removeUserStateLocked(ui.id);
                }
                sInstance = this;
            }
        }
    }

    void systemReady() {
        userForeground(0);
        this.mAppOpsService = IAppOpsService.Stub.asInterface(ServiceManager.getService("appops"));
        for (int i = 0; i < this.mUserIds.length; i += MAX_MANAGED_PROFILES) {
            try {
                this.mAppOpsService.setUserRestrictions((Bundle) this.mUserRestrictions.get(this.mUserIds[i]), this.mUserIds[i]);
            } catch (RemoteException e) {
                Log.w(LOG_TAG, "Unable to notify AppOpsService of UserRestrictions");
            }
        }
    }

    public List<UserInfo> getUsers(boolean excludeDying) {
        ArrayList<UserInfo> users;
        checkManageUsersPermission("query users");
        synchronized (this.mPackagesLock) {
            users = new ArrayList(this.mUsers.size());
            for (int i = 0; i < this.mUsers.size(); i += MAX_MANAGED_PROFILES) {
                UserInfo ui = (UserInfo) this.mUsers.valueAt(i);
                if (!(ui.partial || (excludeDying && this.mRemovingUserIds.get(ui.id)))) {
                    users.add(ui);
                }
            }
        }
        return users;
    }

    public List<UserInfo> getProfiles(int userId, boolean enabledOnly) {
        if (userId != UserHandle.getCallingUserId()) {
            checkManageUsersPermission("getting profiles related to user " + userId);
        }
        long ident = Binder.clearCallingIdentity();
        try {
            List<UserInfo> profilesLocked;
            synchronized (this.mPackagesLock) {
                profilesLocked = getProfilesLocked(userId, enabledOnly);
            }
            return profilesLocked;
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private List<UserInfo> getProfilesLocked(int userId, boolean enabledOnly) {
        UserInfo user = getUserInfoLocked(userId);
        ArrayList<UserInfo> users = new ArrayList(this.mUsers.size());
        if (user != null) {
            for (int i = 0; i < this.mUsers.size(); i += MAX_MANAGED_PROFILES) {
                UserInfo profile = (UserInfo) this.mUsers.valueAt(i);
                if (isProfileOf(user, profile) && ((!enabledOnly || profile.isEnabled()) && !this.mRemovingUserIds.get(profile.id))) {
                    users.add(profile);
                }
            }
        }
        return users;
    }

    public UserInfo getProfileParent(int userHandle) {
        UserInfo userInfo = null;
        checkManageUsersPermission("get the profile parent");
        synchronized (this.mPackagesLock) {
            UserInfo profile = getUserInfoLocked(userHandle);
            if (profile == null) {
            } else {
                int parentUserId = profile.profileGroupId;
                if (parentUserId == -1) {
                } else {
                    userInfo = getUserInfoLocked(parentUserId);
                }
            }
        }
        return userInfo;
    }

    private boolean isProfileOf(UserInfo user, UserInfo profile) {
        return (user.id == profile.id || (user.profileGroupId != -1 && user.profileGroupId == profile.profileGroupId)) ? true : DBG;
    }

    public void setUserEnabled(int userId) {
        checkManageUsersPermission("enable user");
        synchronized (this.mPackagesLock) {
            UserInfo info = getUserInfoLocked(userId);
            if (!(info == null || info.isEnabled())) {
                info.flags ^= 64;
                writeUserLocked(info);
            }
        }
    }

    public UserInfo getUserInfo(int userId) {
        UserInfo userInfoLocked;
        checkManageUsersPermission("query user");
        synchronized (this.mPackagesLock) {
            userInfoLocked = getUserInfoLocked(userId);
        }
        return userInfoLocked;
    }

    public boolean isRestricted() {
        boolean isRestricted;
        synchronized (this.mPackagesLock) {
            isRestricted = getUserInfoLocked(UserHandle.getCallingUserId()).isRestricted();
        }
        return isRestricted;
    }

    private UserInfo getUserInfoLocked(int userId) {
        UserInfo ui = (UserInfo) this.mUsers.get(userId);
        if (ui == null || !ui.partial || this.mRemovingUserIds.get(userId)) {
            return ui;
        }
        Slog.w(LOG_TAG, "getUserInfo: unknown user #" + userId);
        return null;
    }

    public boolean exists(int userId) {
        boolean contains;
        synchronized (this.mPackagesLock) {
            contains = ArrayUtils.contains(this.mUserIds, userId);
        }
        return contains;
    }

    public void setUserName(int userId, String name) {
        checkManageUsersPermission("rename users");
        boolean changed = DBG;
        synchronized (this.mPackagesLock) {
            UserInfo info = (UserInfo) this.mUsers.get(userId);
            if (info == null || info.partial) {
                Slog.w(LOG_TAG, "setUserName: unknown user #" + userId);
                return;
            }
            if (!(name == null || name.equals(info.name))) {
                info.name = name;
                writeUserLocked(info);
                changed = true;
            }
            if (changed) {
                sendUserInfoChangedBroadcast(userId);
            }
        }
    }

    public void setUserIcon(int userId, Bitmap bitmap) {
        checkManageUsersPermission("update users");
        long ident = Binder.clearCallingIdentity();
        try {
            synchronized (this.mPackagesLock) {
                UserInfo info = (UserInfo) this.mUsers.get(userId);
                if (info == null || info.partial) {
                    Slog.w(LOG_TAG, "setUserIcon: unknown user #" + userId);
                    return;
                }
                writeBitmapLocked(info, bitmap);
                writeUserLocked(info);
                sendUserInfoChangedBroadcast(userId);
                Binder.restoreCallingIdentity(ident);
            }
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private void sendUserInfoChangedBroadcast(int userId) {
        Intent changedIntent = new Intent("android.intent.action.USER_INFO_CHANGED");
        changedIntent.putExtra("android.intent.extra.user_handle", userId);
        changedIntent.addFlags(1073741824);
        this.mContext.sendBroadcastAsUser(changedIntent, UserHandle.ALL);
    }

    public Bitmap getUserIcon(int userId) {
        synchronized (this.mPackagesLock) {
            UserInfo info = (UserInfo) this.mUsers.get(userId);
            if (info == null || info.partial) {
                Slog.w(LOG_TAG, "getUserIcon: unknown user #" + userId);
                return null;
            }
            int callingGroupId = ((UserInfo) this.mUsers.get(UserHandle.getCallingUserId())).profileGroupId;
            if (callingGroupId == -1 || callingGroupId != info.profileGroupId) {
                checkManageUsersPermission("get the icon of a user who is not related");
            }
            if (info.iconPath == null) {
                return null;
            }
            Bitmap decodeFile = BitmapFactory.decodeFile(info.iconPath);
            return decodeFile;
        }
    }

    public void makeInitialized(int userId) {
        checkManageUsersPermission("makeInitialized");
        synchronized (this.mPackagesLock) {
            UserInfo info = (UserInfo) this.mUsers.get(userId);
            if (info == null || info.partial) {
                Slog.w(LOG_TAG, "makeInitialized: unknown user #" + userId);
            }
            if ((info.flags & 16) == 0) {
                info.flags |= 16;
                writeUserLocked(info);
            }
        }
    }

    private void initDefaultGuestRestrictions() {
        if (this.mGuestRestrictions.isEmpty()) {
            this.mGuestRestrictions.putBoolean("no_outgoing_calls", true);
            this.mGuestRestrictions.putBoolean("no_sms", true);
        }
    }

    public Bundle getDefaultGuestRestrictions() {
        Bundle bundle;
        checkManageUsersPermission("getDefaultGuestRestrictions");
        synchronized (this.mPackagesLock) {
            bundle = new Bundle(this.mGuestRestrictions);
        }
        return bundle;
    }

    public void setDefaultGuestRestrictions(Bundle restrictions) {
        checkManageUsersPermission("setDefaultGuestRestrictions");
        synchronized (this.mPackagesLock) {
            this.mGuestRestrictions.clear();
            this.mGuestRestrictions.putAll(restrictions);
            writeUserListLocked();
        }
    }

    public boolean hasUserRestriction(String restrictionKey, int userId) {
        boolean z;
        synchronized (this.mPackagesLock) {
            Bundle restrictions = (Bundle) this.mUserRestrictions.get(userId);
            z = restrictions != null ? restrictions.getBoolean(restrictionKey) : DBG;
        }
        return z;
    }

    public Bundle getUserRestrictions(int userId) {
        Bundle bundle;
        synchronized (this.mPackagesLock) {
            Bundle restrictions = (Bundle) this.mUserRestrictions.get(userId);
            bundle = restrictions != null ? new Bundle(restrictions) : new Bundle();
        }
        return bundle;
    }

    public void setUserRestrictions(Bundle restrictions, int userId) {
        checkManageUsersPermission("setUserRestrictions");
        if (restrictions != null) {
            synchronized (this.mPackagesLock) {
                ((Bundle) this.mUserRestrictions.get(userId)).clear();
                ((Bundle) this.mUserRestrictions.get(userId)).putAll(restrictions);
                long token = Binder.clearCallingIdentity();
                try {
                    this.mAppOpsService.setUserRestrictions((Bundle) this.mUserRestrictions.get(userId), userId);
                } catch (RemoteException e) {
                    Log.w(LOG_TAG, "Unable to notify AppOpsService of UserRestrictions");
                } finally {
                    Binder.restoreCallingIdentity(token);
                }
                writeUserLocked((UserInfo) this.mUsers.get(userId));
            }
        }
    }

    private boolean isUserLimitReachedLocked() {
        int aliveUserCount = 0;
        int totalUserCount = this.mUsers.size();
        for (int i = 0; i < totalUserCount; i += MAX_MANAGED_PROFILES) {
            UserInfo user = (UserInfo) this.mUsers.valueAt(i);
            if (!(this.mRemovingUserIds.get(user.id) || user.isGuest() || user.partial)) {
                aliveUserCount += MAX_MANAGED_PROFILES;
            }
        }
        return aliveUserCount >= UserManager.getMaxSupportedUsers() ? true : DBG;
    }

    private static final void checkManageUsersPermission(String message) {
        int uid = Binder.getCallingUid();
        if (uid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && uid != 0 && ActivityManager.checkComponentPermission("android.permission.MANAGE_USERS", uid, -1, true) != 0) {
            throw new SecurityException("You need MANAGE_USERS permission to: " + message);
        }
    }

    private void writeBitmapLocked(UserInfo info, Bitmap bitmap) {
        try {
            File dir = new File(this.mUsersDir, Integer.toString(info.id));
            File file = new File(dir, USER_PHOTO_FILENAME);
            if (!dir.exists()) {
                dir.mkdir();
                FileUtils.setPermissions(dir.getPath(), 505, -1, -1);
            }
            CompressFormat compressFormat = CompressFormat.PNG;
            FileOutputStream os = new FileOutputStream(file);
            if (bitmap.compress(compressFormat, 100, os)) {
                info.iconPath = file.getAbsolutePath();
            }
            try {
                os.close();
            } catch (IOException e) {
            }
        } catch (FileNotFoundException e2) {
            Slog.w(LOG_TAG, "Error setting photo for user ", e2);
        }
    }

    public int[] getUserIds() {
        int[] iArr;
        synchronized (this.mPackagesLock) {
            iArr = this.mUserIds;
        }
        return iArr;
    }

    int[] getUserIdsLPr() {
        return this.mUserIds;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void readUserListLocked() {
        /*
        r15 = this;
        r14 = 1;
        r13 = 2;
        r11 = r15.mUserListFile;
        r11 = r11.exists();
        if (r11 != 0) goto L_0x000e;
    L_0x000a:
        r15.fallbackToSingleUserLocked();
    L_0x000d:
        return;
    L_0x000e:
        r0 = 0;
        r9 = new android.util.AtomicFile;
        r11 = r15.mUserListFile;
        r9.<init>(r11);
        r0 = r9.openRead();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r5 = android.util.Xml.newPullParser();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r11 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r11 = r11.name();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r5.setInput(r0, r11);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
    L_0x0027:
        r7 = r5.next();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r7 == r13) goto L_0x002f;
    L_0x002d:
        if (r7 != r14) goto L_0x0027;
    L_0x002f:
        if (r7 == r13) goto L_0x0043;
    L_0x0031:
        r11 = "UserManagerService";
        r12 = "Unable to read user list";
        android.util.Slog.e(r11, r12);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r15.fallbackToSingleUserLocked();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r0 == 0) goto L_0x000d;
    L_0x003d:
        r0.close();	 Catch:{ IOException -> 0x0041 }
        goto L_0x000d;
    L_0x0041:
        r11 = move-exception;
        goto L_0x000d;
    L_0x0043:
        r11 = -1;
        r15.mNextSerialNumber = r11;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r11 = r5.getName();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r12 = "users";
        r11 = r11.equals(r12);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r11 == 0) goto L_0x0070;
    L_0x0052:
        r11 = 0;
        r12 = "nextSerialNumber";
        r3 = r5.getAttributeValue(r11, r12);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r3 == 0) goto L_0x0061;
    L_0x005b:
        r11 = java.lang.Integer.parseInt(r3);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r15.mNextSerialNumber = r11;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
    L_0x0061:
        r11 = 0;
        r12 = "version";
        r10 = r5.getAttributeValue(r11, r12);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r10 == 0) goto L_0x0070;
    L_0x006a:
        r11 = java.lang.Integer.parseInt(r10);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r15.mUserVersion = r11;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
    L_0x0070:
        r7 = r5.next();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r7 == r14) goto L_0x00ee;
    L_0x0076:
        if (r7 != r13) goto L_0x0070;
    L_0x0078:
        r4 = r5.getName();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r11 = "user";
        r11 = r4.equals(r11);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r11 == 0) goto L_0x00bb;
    L_0x0084:
        r11 = 0;
        r12 = "id";
        r1 = r5.getAttributeValue(r11, r12);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r11 = java.lang.Integer.parseInt(r1);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r8 = r15.readUserLocked(r11);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r8 == 0) goto L_0x0070;
    L_0x0095:
        r11 = r15.mUsers;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r12 = r8.id;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r11.put(r12, r8);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r11 = r15.mNextSerialNumber;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r11 < 0) goto L_0x00a6;
    L_0x00a0:
        r11 = r15.mNextSerialNumber;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r12 = r8.id;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r11 > r12) goto L_0x0070;
    L_0x00a6:
        r11 = r8.id;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r11 = r11 + 1;
        r15.mNextSerialNumber = r11;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        goto L_0x0070;
    L_0x00ad:
        r2 = move-exception;
        r15.fallbackToSingleUserLocked();	 Catch:{ all -> 0x00fe }
        if (r0 == 0) goto L_0x000d;
    L_0x00b3:
        r0.close();	 Catch:{ IOException -> 0x00b8 }
        goto L_0x000d;
    L_0x00b8:
        r11 = move-exception;
        goto L_0x000d;
    L_0x00bb:
        r11 = "guestRestrictions";
        r11 = r4.equals(r11);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r11 == 0) goto L_0x0070;
    L_0x00c3:
        r7 = r5.next();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r7 == r14) goto L_0x0070;
    L_0x00c9:
        r11 = 3;
        if (r7 == r11) goto L_0x0070;
    L_0x00cc:
        if (r7 != r13) goto L_0x00c3;
    L_0x00ce:
        r11 = r5.getName();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r12 = "restrictions";
        r11 = r11.equals(r12);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r11 == 0) goto L_0x0070;
    L_0x00da:
        r11 = r15.mGuestRestrictions;	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r15.readRestrictionsLocked(r5, r11);	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        goto L_0x0070;
    L_0x00e0:
        r6 = move-exception;
        r15.fallbackToSingleUserLocked();	 Catch:{ all -> 0x00fe }
        if (r0 == 0) goto L_0x000d;
    L_0x00e6:
        r0.close();	 Catch:{ IOException -> 0x00eb }
        goto L_0x000d;
    L_0x00eb:
        r11 = move-exception;
        goto L_0x000d;
    L_0x00ee:
        r15.updateUserIdsLocked();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        r15.upgradeIfNecessaryLocked();	 Catch:{ IOException -> 0x00ad, XmlPullParserException -> 0x00e0 }
        if (r0 == 0) goto L_0x000d;
    L_0x00f6:
        r0.close();	 Catch:{ IOException -> 0x00fb }
        goto L_0x000d;
    L_0x00fb:
        r11 = move-exception;
        goto L_0x000d;
    L_0x00fe:
        r11 = move-exception;
        if (r0 == 0) goto L_0x0104;
    L_0x0101:
        r0.close();	 Catch:{ IOException -> 0x0105 }
    L_0x0104:
        throw r11;
    L_0x0105:
        r12 = move-exception;
        goto L_0x0104;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.UserManagerService.readUserListLocked():void");
    }

    private void upgradeIfNecessaryLocked() {
        UserInfo user;
        int userVersion = this.mUserVersion;
        if (userVersion < MAX_MANAGED_PROFILES) {
            user = (UserInfo) this.mUsers.get(0);
            if ("Primary".equals(user.name)) {
                user.name = this.mContext.getResources().getString(17040925);
                writeUserLocked(user);
            }
            userVersion = MAX_MANAGED_PROFILES;
        }
        if (userVersion < 2) {
            user = (UserInfo) this.mUsers.get(0);
            if ((user.flags & 16) == 0) {
                user.flags |= 16;
                writeUserLocked(user);
            }
            userVersion = 2;
        }
        if (userVersion < 4) {
            userVersion = 4;
        }
        if (userVersion < USER_VERSION) {
            initDefaultGuestRestrictions();
            userVersion = USER_VERSION;
        }
        if (userVersion < USER_VERSION) {
            Slog.w(LOG_TAG, "User version " + this.mUserVersion + " didn't upgrade as expected to " + USER_VERSION);
            return;
        }
        this.mUserVersion = userVersion;
        writeUserListLocked();
    }

    private void fallbackToSingleUserLocked() {
        UserInfo primary = new UserInfo(0, this.mContext.getResources().getString(17040925), null, 19);
        this.mUsers.put(0, primary);
        this.mNextSerialNumber = MIN_USER_ID;
        this.mUserVersion = USER_VERSION;
        this.mUserRestrictions.append(0, new Bundle());
        updateUserIdsLocked();
        initDefaultGuestRestrictions();
        writeUserListLocked();
        writeUserLocked(primary);
    }

    private void writeUserLocked(UserInfo userInfo) {
        AtomicFile userFile = new AtomicFile(new File(this.mUsersDir, userInfo.id + XML_SUFFIX));
        try {
            FileOutputStream fos = userFile.startWrite();
            BufferedOutputStream bos = new BufferedOutputStream(fos);
            XmlSerializer serializer = new FastXmlSerializer();
            serializer.setOutput(bos, StandardCharsets.UTF_8.name());
            serializer.startDocument(null, Boolean.valueOf(true));
            serializer.setFeature("http://xmlpull.org/v1/doc/features.html#indent-output", true);
            serializer.startTag(null, TAG_USER);
            serializer.attribute(null, ATTR_ID, Integer.toString(userInfo.id));
            serializer.attribute(null, ATTR_SERIAL_NO, Integer.toString(userInfo.serialNumber));
            serializer.attribute(null, ATTR_FLAGS, Integer.toString(userInfo.flags));
            serializer.attribute(null, ATTR_CREATION_TIME, Long.toString(userInfo.creationTime));
            serializer.attribute(null, ATTR_LAST_LOGGED_IN_TIME, Long.toString(userInfo.lastLoggedInTime));
            RestrictionsPinState pinState = (RestrictionsPinState) this.mRestrictionsPinStates.get(userInfo.id);
            if (pinState != null) {
                if (pinState.salt != 0) {
                    serializer.attribute(null, ATTR_SALT, Long.toString(pinState.salt));
                }
                if (pinState.pinHash != null) {
                    serializer.attribute(null, ATTR_PIN_HASH, pinState.pinHash);
                }
                if (pinState.failedAttempts != 0) {
                    serializer.attribute(null, ATTR_FAILED_ATTEMPTS, Integer.toString(pinState.failedAttempts));
                    serializer.attribute(null, ATTR_LAST_RETRY_MS, Long.toString(pinState.lastAttemptTime));
                }
            }
            if (userInfo.iconPath != null) {
                serializer.attribute(null, ATTR_ICON_PATH, userInfo.iconPath);
            }
            if (userInfo.partial) {
                serializer.attribute(null, ATTR_PARTIAL, "true");
            }
            if (userInfo.guestToRemove) {
                serializer.attribute(null, ATTR_GUEST_TO_REMOVE, "true");
            }
            if (userInfo.profileGroupId != -1) {
                serializer.attribute(null, ATTR_PROFILE_GROUP_ID, Integer.toString(userInfo.profileGroupId));
            }
            serializer.startTag(null, TAG_NAME);
            serializer.text(userInfo.name);
            serializer.endTag(null, TAG_NAME);
            Bundle restrictions = (Bundle) this.mUserRestrictions.get(userInfo.id);
            if (restrictions != null) {
                writeRestrictionsLocked(serializer, restrictions);
            }
            serializer.endTag(null, TAG_USER);
            serializer.endDocument();
            userFile.finishWrite(fos);
        } catch (Exception ioe) {
            Slog.e(LOG_TAG, "Error writing user info " + userInfo.id + "\n" + ioe);
            userFile.failWrite(null);
        }
    }

    private void writeUserListLocked() {
        AtomicFile userListFile = new AtomicFile(this.mUserListFile);
        try {
            FileOutputStream fos = userListFile.startWrite();
            BufferedOutputStream bos = new BufferedOutputStream(fos);
            XmlSerializer serializer = new FastXmlSerializer();
            serializer.setOutput(bos, StandardCharsets.UTF_8.name());
            serializer.startDocument(null, Boolean.valueOf(true));
            serializer.setFeature("http://xmlpull.org/v1/doc/features.html#indent-output", true);
            serializer.startTag(null, TAG_USERS);
            serializer.attribute(null, ATTR_NEXT_SERIAL_NO, Integer.toString(this.mNextSerialNumber));
            serializer.attribute(null, ATTR_USER_VERSION, Integer.toString(this.mUserVersion));
            serializer.startTag(null, TAG_GUEST_RESTRICTIONS);
            writeRestrictionsLocked(serializer, this.mGuestRestrictions);
            serializer.endTag(null, TAG_GUEST_RESTRICTIONS);
            for (int i = 0; i < this.mUsers.size(); i += MAX_MANAGED_PROFILES) {
                UserInfo user = (UserInfo) this.mUsers.valueAt(i);
                serializer.startTag(null, TAG_USER);
                serializer.attribute(null, ATTR_ID, Integer.toString(user.id));
                serializer.endTag(null, TAG_USER);
            }
            serializer.endTag(null, TAG_USERS);
            serializer.endDocument();
            userListFile.finishWrite(fos);
        } catch (Exception e) {
            userListFile.failWrite(null);
            Slog.e(LOG_TAG, "Error writing user list");
        }
    }

    private void writeRestrictionsLocked(XmlSerializer serializer, Bundle restrictions) throws IOException {
        serializer.startTag(null, TAG_RESTRICTIONS);
        writeBoolean(serializer, restrictions, "no_config_wifi");
        writeBoolean(serializer, restrictions, "no_modify_accounts");
        writeBoolean(serializer, restrictions, "no_install_apps");
        writeBoolean(serializer, restrictions, "no_uninstall_apps");
        writeBoolean(serializer, restrictions, "no_share_location");
        writeBoolean(serializer, restrictions, "no_install_unknown_sources");
        writeBoolean(serializer, restrictions, "no_config_bluetooth");
        writeBoolean(serializer, restrictions, "no_usb_file_transfer");
        writeBoolean(serializer, restrictions, "no_config_credentials");
        writeBoolean(serializer, restrictions, "no_remove_user");
        writeBoolean(serializer, restrictions, "no_debugging_features");
        writeBoolean(serializer, restrictions, "no_config_vpn");
        writeBoolean(serializer, restrictions, "no_config_tethering");
        writeBoolean(serializer, restrictions, "no_factory_reset");
        writeBoolean(serializer, restrictions, "no_add_user");
        writeBoolean(serializer, restrictions, "ensure_verify_apps");
        writeBoolean(serializer, restrictions, "no_config_cell_broadcasts");
        writeBoolean(serializer, restrictions, "no_config_mobile_networks");
        writeBoolean(serializer, restrictions, "no_control_apps");
        writeBoolean(serializer, restrictions, "no_physical_media");
        writeBoolean(serializer, restrictions, "no_unmute_microphone");
        writeBoolean(serializer, restrictions, "no_adjust_volume");
        writeBoolean(serializer, restrictions, "no_outgoing_calls");
        writeBoolean(serializer, restrictions, "no_sms");
        writeBoolean(serializer, restrictions, "no_create_windows");
        writeBoolean(serializer, restrictions, "no_cross_profile_copy_paste");
        writeBoolean(serializer, restrictions, "no_outgoing_beam");
        serializer.endTag(null, TAG_RESTRICTIONS);
    }

    private UserInfo readUserLocked(int id) {
        int flags = 0;
        int serialNumber = id;
        String name = null;
        String iconPath = null;
        long creationTime = 0;
        long lastLoggedInTime = 0;
        long salt = 0;
        String pinHash = null;
        int failedAttempts = 0;
        int profileGroupId = -1;
        long lastAttemptTime = 0;
        boolean partial = DBG;
        boolean guestToRemove = DBG;
        Bundle restrictions = new Bundle();
        FileInputStream fis = null;
        try {
            int type;
            fis = new AtomicFile(new File(this.mUsersDir, Integer.toString(id) + XML_SUFFIX)).openRead();
            XmlPullParser parser = Xml.newPullParser();
            parser.setInput(fis, StandardCharsets.UTF_8.name());
            do {
                type = parser.next();
                if (type == 2) {
                    break;
                }
            } while (type != MAX_MANAGED_PROFILES);
            if (type != 2) {
                Slog.e(LOG_TAG, "Unable to read user " + id);
                if (fis == null) {
                    return null;
                }
                try {
                    fis.close();
                    return null;
                } catch (IOException e) {
                    return null;
                }
            }
            UserInfo userInfo;
            RestrictionsPinState pinState;
            RestrictionsPinState restrictionsPinState;
            if (type == 2) {
                if (parser.getName().equals(TAG_USER)) {
                    if (readIntAttribute(parser, ATTR_ID, -1) != id) {
                        Slog.e(LOG_TAG, "User id does not match the file name");
                        if (fis == null) {
                            return null;
                        }
                        try {
                            fis.close();
                            return null;
                        } catch (IOException e2) {
                            return null;
                        }
                    }
                    serialNumber = readIntAttribute(parser, ATTR_SERIAL_NO, id);
                    flags = readIntAttribute(parser, ATTR_FLAGS, 0);
                    iconPath = parser.getAttributeValue(null, ATTR_ICON_PATH);
                    creationTime = readLongAttribute(parser, ATTR_CREATION_TIME, 0);
                    lastLoggedInTime = readLongAttribute(parser, ATTR_LAST_LOGGED_IN_TIME, 0);
                    salt = readLongAttribute(parser, ATTR_SALT, 0);
                    pinHash = parser.getAttributeValue(null, ATTR_PIN_HASH);
                    failedAttempts = readIntAttribute(parser, ATTR_FAILED_ATTEMPTS, 0);
                    lastAttemptTime = readLongAttribute(parser, ATTR_LAST_RETRY_MS, 0);
                    profileGroupId = readIntAttribute(parser, ATTR_PROFILE_GROUP_ID, -1);
                    if (profileGroupId == -1) {
                        profileGroupId = readIntAttribute(parser, "relatedGroupId", -1);
                    }
                    if ("true".equals(parser.getAttributeValue(null, ATTR_PARTIAL))) {
                        partial = true;
                    }
                    if ("true".equals(parser.getAttributeValue(null, ATTR_GUEST_TO_REMOVE))) {
                        guestToRemove = true;
                    }
                    int outerDepth = parser.getDepth();
                    while (true) {
                        type = parser.next();
                        if (type != MAX_MANAGED_PROFILES && (type != 3 || parser.getDepth() > outerDepth)) {
                            if (!(type == 3 || type == 4)) {
                                String tag = parser.getName();
                                if (!TAG_NAME.equals(tag)) {
                                    if (TAG_RESTRICTIONS.equals(tag)) {
                                        readRestrictionsLocked(parser, restrictions);
                                    }
                                } else if (parser.next() == 4) {
                                    name = parser.getText();
                                }
                            }
                        }
                    }
                    userInfo = new UserInfo(id, name, iconPath, flags);
                    userInfo.serialNumber = serialNumber;
                    userInfo.creationTime = creationTime;
                    userInfo.lastLoggedInTime = lastLoggedInTime;
                    userInfo.partial = partial;
                    userInfo.guestToRemove = guestToRemove;
                    userInfo.profileGroupId = profileGroupId;
                    this.mUserRestrictions.append(id, restrictions);
                    if (salt != 0) {
                        pinState = (RestrictionsPinState) this.mRestrictionsPinStates.get(id);
                        if (pinState == null) {
                            restrictionsPinState = new RestrictionsPinState();
                            this.mRestrictionsPinStates.put(id, restrictionsPinState);
                        }
                        pinState.salt = salt;
                        pinState.pinHash = pinHash;
                        pinState.failedAttempts = failedAttempts;
                        pinState.lastAttemptTime = lastAttemptTime;
                    }
                    if (fis != null) {
                        return userInfo;
                    }
                    try {
                        fis.close();
                        return userInfo;
                    } catch (IOException e3) {
                        return userInfo;
                    }
                }
            }
            break;
            userInfo = new UserInfo(id, name, iconPath, flags);
            userInfo.serialNumber = serialNumber;
            userInfo.creationTime = creationTime;
            userInfo.lastLoggedInTime = lastLoggedInTime;
            userInfo.partial = partial;
            userInfo.guestToRemove = guestToRemove;
            userInfo.profileGroupId = profileGroupId;
            this.mUserRestrictions.append(id, restrictions);
            if (salt != 0) {
                pinState = (RestrictionsPinState) this.mRestrictionsPinStates.get(id);
                if (pinState == null) {
                    restrictionsPinState = new RestrictionsPinState();
                    this.mRestrictionsPinStates.put(id, restrictionsPinState);
                }
                pinState.salt = salt;
                pinState.pinHash = pinHash;
                pinState.failedAttempts = failedAttempts;
                pinState.lastAttemptTime = lastAttemptTime;
            }
            if (fis != null) {
                return userInfo;
            }
            fis.close();
            return userInfo;
        } catch (IOException e4) {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e5) {
                }
            }
            return null;
        } catch (XmlPullParserException e6) {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e7) {
                }
            }
            return null;
        } catch (Throwable th) {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e8) {
                }
            }
        }
    }

    private void readRestrictionsLocked(XmlPullParser parser, Bundle restrictions) throws IOException {
        readBoolean(parser, restrictions, "no_config_wifi");
        readBoolean(parser, restrictions, "no_modify_accounts");
        readBoolean(parser, restrictions, "no_install_apps");
        readBoolean(parser, restrictions, "no_uninstall_apps");
        readBoolean(parser, restrictions, "no_share_location");
        readBoolean(parser, restrictions, "no_install_unknown_sources");
        readBoolean(parser, restrictions, "no_config_bluetooth");
        readBoolean(parser, restrictions, "no_usb_file_transfer");
        readBoolean(parser, restrictions, "no_config_credentials");
        readBoolean(parser, restrictions, "no_remove_user");
        readBoolean(parser, restrictions, "no_debugging_features");
        readBoolean(parser, restrictions, "no_config_vpn");
        readBoolean(parser, restrictions, "no_config_tethering");
        readBoolean(parser, restrictions, "no_factory_reset");
        readBoolean(parser, restrictions, "no_add_user");
        readBoolean(parser, restrictions, "ensure_verify_apps");
        readBoolean(parser, restrictions, "no_config_cell_broadcasts");
        readBoolean(parser, restrictions, "no_config_mobile_networks");
        readBoolean(parser, restrictions, "no_control_apps");
        readBoolean(parser, restrictions, "no_physical_media");
        readBoolean(parser, restrictions, "no_unmute_microphone");
        readBoolean(parser, restrictions, "no_adjust_volume");
        readBoolean(parser, restrictions, "no_outgoing_calls");
        readBoolean(parser, restrictions, "no_sms");
        readBoolean(parser, restrictions, "no_create_windows");
        readBoolean(parser, restrictions, "no_cross_profile_copy_paste");
        readBoolean(parser, restrictions, "no_outgoing_beam");
    }

    private void readBoolean(XmlPullParser parser, Bundle restrictions, String restrictionKey) {
        String value = parser.getAttributeValue(null, restrictionKey);
        if (value != null) {
            restrictions.putBoolean(restrictionKey, Boolean.parseBoolean(value));
        }
    }

    private void writeBoolean(XmlSerializer xml, Bundle restrictions, String restrictionKey) throws IOException {
        if (restrictions.containsKey(restrictionKey)) {
            xml.attribute(null, restrictionKey, Boolean.toString(restrictions.getBoolean(restrictionKey)));
        }
    }

    private int readIntAttribute(XmlPullParser parser, String attr, int defaultValue) {
        String valueString = parser.getAttributeValue(null, attr);
        if (valueString != null) {
            try {
                defaultValue = Integer.parseInt(valueString);
            } catch (NumberFormatException e) {
            }
        }
        return defaultValue;
    }

    private long readLongAttribute(XmlPullParser parser, String attr, long defaultValue) {
        String valueString = parser.getAttributeValue(null, attr);
        if (valueString != null) {
            try {
                defaultValue = Long.parseLong(valueString);
            } catch (NumberFormatException e) {
            }
        }
        return defaultValue;
    }

    private boolean isPackageInstalled(String pkg, int userId) {
        ApplicationInfo info = this.mPm.getApplicationInfo(pkg, DumpState.DUMP_INSTALLS, userId);
        if (info == null || (info.flags & 8388608) == 0) {
            return DBG;
        }
        return true;
    }

    private void cleanAppRestrictions(int userId) {
        synchronized (this.mPackagesLock) {
            File dir = Environment.getUserSystemDirectory(userId);
            String[] files = dir.list();
            if (files == null) {
                return;
            }
            String[] arr$ = files;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += MAX_MANAGED_PROFILES) {
                String fileName = arr$[i$];
                if (fileName.startsWith(RESTRICTIONS_FILE_PREFIX)) {
                    File resFile = new File(dir, fileName);
                    if (resFile.exists()) {
                        resFile.delete();
                    }
                }
            }
        }
    }

    private void cleanAppRestrictionsForPackage(String pkg, int userId) {
        synchronized (this.mPackagesLock) {
            File resFile = new File(Environment.getUserSystemDirectory(userId), packageToRestrictionsFileName(pkg));
            if (resFile.exists()) {
                resFile.delete();
            }
        }
    }

    public UserInfo createProfileForUser(String name, int flags, int userId) {
        checkManageUsersPermission("Only the system can create users");
        if (userId == 0) {
            return createUserInternal(name, flags, userId);
        }
        Slog.w(LOG_TAG, "Only user owner can have profiles");
        return null;
    }

    public UserInfo createUser(String name, int flags) {
        checkManageUsersPermission("Only the system can create users");
        return createUserInternal(name, flags, -10000);
    }

    private UserInfo createUserInternal(String name, int flags, int parentId) {
        Throwable th;
        UserInfo userInfo;
        if (getUserRestrictions(UserHandle.getCallingUserId()).getBoolean("no_add_user", DBG)) {
            Log.w(LOG_TAG, "Cannot add user. DISALLOW_ADD_USER is enabled.");
            return null;
        }
        boolean isGuest = (flags & 4) != 0 ? true : DBG;
        long ident = Binder.clearCallingIdentity();
        try {
            synchronized (this.mInstallLock) {
                try {
                    synchronized (this.mPackagesLock) {
                        UserInfo parent = null;
                        if (parentId != -10000) {
                            parent = getUserInfoLocked(parentId);
                            if (parent == null) {
                                Binder.restoreCallingIdentity(ident);
                                return null;
                            }
                        }
                        if (!isGuest) {
                            if (isUserLimitReachedLocked()) {
                                Binder.restoreCallingIdentity(ident);
                                return null;
                            }
                        }
                        if (isGuest) {
                            if (findCurrentGuestUserLocked() != null) {
                                Binder.restoreCallingIdentity(ident);
                                return null;
                            }
                        }
                        if ((flags & 32) != 0) {
                            if (numberOfUsersOfTypeLocked(32, true) >= MAX_MANAGED_PROFILES) {
                                Binder.restoreCallingIdentity(ident);
                                return null;
                            }
                        }
                        try {
                            int userId = getNextAvailableIdLocked();
                            UserInfo userInfo2 = new UserInfo(userId, name, null, flags);
                            try {
                                File userPath = new File(this.mBaseUserPath, Integer.toString(userId));
                                int i = this.mNextSerialNumber;
                                this.mNextSerialNumber = i + MAX_MANAGED_PROFILES;
                                userInfo2.serialNumber = i;
                                long now = System.currentTimeMillis();
                                if (now <= EPOCH_PLUS_30_YEARS) {
                                    now = 0;
                                }
                                userInfo2.creationTime = now;
                                userInfo2.partial = true;
                                Environment.getUserSystemDirectory(userInfo2.id).mkdirs();
                                this.mUsers.put(userId, userInfo2);
                                writeUserListLocked();
                                if (parent != null) {
                                    if (parent.profileGroupId == -1) {
                                        parent.profileGroupId = parent.id;
                                        writeUserLocked(parent);
                                    }
                                    userInfo2.profileGroupId = parent.profileGroupId;
                                }
                                writeUserLocked(userInfo2);
                                this.mPm.createNewUserLILPw(userId, userPath);
                                userInfo2.partial = DBG;
                                writeUserLocked(userInfo2);
                                updateUserIdsLocked();
                                this.mUserRestrictions.append(userId, new Bundle());
                            } catch (Throwable th2) {
                                th = th2;
                                userInfo = userInfo2;
                                throw th;
                            }
                            try {
                                if (userInfo2 != null) {
                                    try {
                                        Intent addedIntent = new Intent("android.intent.action.USER_ADDED");
                                        addedIntent.putExtra("android.intent.extra.user_handle", userInfo2.id);
                                        this.mContext.sendBroadcastAsUser(addedIntent, UserHandle.ALL, "android.permission.MANAGE_USERS");
                                    } catch (Throwable th3) {
                                        th = th3;
                                        userInfo = userInfo2;
                                        Binder.restoreCallingIdentity(ident);
                                        throw th;
                                    }
                                }
                                Binder.restoreCallingIdentity(ident);
                                return userInfo2;
                            } catch (Throwable th4) {
                                th = th4;
                                userInfo = userInfo2;
                                throw th;
                            }
                        } catch (Throwable th5) {
                            th = th5;
                            throw th;
                        }
                    }
                } catch (Throwable th6) {
                    th = th6;
                    throw th;
                }
            }
        } catch (Throwable th7) {
            th = th7;
        }
    }

    private int numberOfUsersOfTypeLocked(int flags, boolean excludeDying) {
        int count = 0;
        for (int i = this.mUsers.size() - 1; i >= 0; i--) {
            UserInfo user = (UserInfo) this.mUsers.valueAt(i);
            if (!((excludeDying && this.mRemovingUserIds.get(user.id)) || (user.flags & flags) == 0)) {
                count += MAX_MANAGED_PROFILES;
            }
        }
        return count;
    }

    private UserInfo findCurrentGuestUserLocked() {
        int size = this.mUsers.size();
        for (int i = 0; i < size; i += MAX_MANAGED_PROFILES) {
            UserInfo user = (UserInfo) this.mUsers.valueAt(i);
            if (user.isGuest() && !user.guestToRemove && !this.mRemovingUserIds.get(user.id)) {
                return user;
            }
        }
        return null;
    }

    public boolean markGuestForDeletion(int userHandle) {
        checkManageUsersPermission("Only the system can remove users");
        if (getUserRestrictions(UserHandle.getCallingUserId()).getBoolean("no_remove_user", DBG)) {
            Log.w(LOG_TAG, "Cannot remove user. DISALLOW_REMOVE_USER is enabled.");
            return DBG;
        }
        long ident = Binder.clearCallingIdentity();
        try {
            synchronized (this.mPackagesLock) {
                UserInfo user = (UserInfo) this.mUsers.get(userHandle);
                if (userHandle == 0 || user == null || this.mRemovingUserIds.get(userHandle)) {
                    return DBG;
                } else if (user.isGuest()) {
                    user.guestToRemove = true;
                    user.flags |= 64;
                    writeUserLocked(user);
                    Binder.restoreCallingIdentity(ident);
                    return true;
                } else {
                    Binder.restoreCallingIdentity(ident);
                    return DBG;
                }
            }
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public boolean removeUser(int userHandle) {
        boolean z = true;
        checkManageUsersPermission("Only the system can remove users");
        if (getUserRestrictions(UserHandle.getCallingUserId()).getBoolean("no_remove_user", DBG)) {
            Log.w(LOG_TAG, "Cannot remove user. DISALLOW_REMOVE_USER is enabled.");
            return DBG;
        }
        long ident = Binder.clearCallingIdentity();
        try {
            synchronized (this.mPackagesLock) {
                UserInfo user = (UserInfo) this.mUsers.get(userHandle);
                if (userHandle == 0 || user == null || this.mRemovingUserIds.get(userHandle)) {
                    return DBG;
                }
                this.mRemovingUserIds.put(userHandle, true);
                try {
                    this.mAppOpsService.removeUser(userHandle);
                } catch (RemoteException e) {
                    Log.w(LOG_TAG, "Unable to notify AppOpsService of removing user", e);
                }
                user.partial = true;
                user.flags |= 64;
                writeUserLocked(user);
                if (user.profileGroupId != -1 && user.isManagedProfile()) {
                    sendProfileRemovedBroadcast(user.profileGroupId, user.id);
                }
                try {
                    if (ActivityManagerNative.getDefault().stopUser(userHandle, new C04591()) != 0) {
                        z = DBG;
                    }
                    Binder.restoreCallingIdentity(ident);
                    return z;
                } catch (RemoteException e2) {
                    Binder.restoreCallingIdentity(ident);
                    return DBG;
                }
            }
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    void finishRemoveUser(int userHandle) {
        long ident = Binder.clearCallingIdentity();
        try {
            Intent addedIntent = new Intent("android.intent.action.USER_REMOVED");
            addedIntent.putExtra("android.intent.extra.user_handle", userHandle);
            this.mContext.sendOrderedBroadcastAsUser(addedIntent, UserHandle.ALL, "android.permission.MANAGE_USERS", new C04612(userHandle), null, -1, null, null);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private void removeUserStateLocked(int userHandle) {
        this.mPm.cleanUpUserLILPw(this, userHandle);
        this.mUsers.remove(userHandle);
        this.mRestrictionsPinStates.remove(userHandle);
        new AtomicFile(new File(this.mUsersDir, userHandle + XML_SUFFIX)).delete();
        writeUserListLocked();
        updateUserIdsLocked();
        removeDirectoryRecursive(Environment.getUserSystemDirectory(userHandle));
    }

    private void removeDirectoryRecursive(File parent) {
        if (parent.isDirectory()) {
            String[] arr$ = parent.list();
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += MAX_MANAGED_PROFILES) {
                removeDirectoryRecursive(new File(parent, arr$[i$]));
            }
        }
        parent.delete();
    }

    private void sendProfileRemovedBroadcast(int parentUserId, int removedUserId) {
        Intent managedProfileIntent = new Intent("android.intent.action.MANAGED_PROFILE_REMOVED");
        managedProfileIntent.addFlags(1342177280);
        managedProfileIntent.putExtra("android.intent.extra.USER", new UserHandle(removedUserId));
        this.mContext.sendBroadcastAsUser(managedProfileIntent, new UserHandle(parentUserId), null);
    }

    public Bundle getApplicationRestrictions(String packageName) {
        return getApplicationRestrictionsForUser(packageName, UserHandle.getCallingUserId());
    }

    public Bundle getApplicationRestrictionsForUser(String packageName, int userId) {
        Bundle readApplicationRestrictionsLocked;
        if (!(UserHandle.getCallingUserId() == userId && UserHandle.isSameApp(Binder.getCallingUid(), getUidForPackage(packageName)))) {
            checkManageUsersPermission("Only system can get restrictions for other users/apps");
        }
        synchronized (this.mPackagesLock) {
            readApplicationRestrictionsLocked = readApplicationRestrictionsLocked(packageName, userId);
        }
        return readApplicationRestrictionsLocked;
    }

    public void setApplicationRestrictions(String packageName, Bundle restrictions, int userId) {
        if (!(UserHandle.getCallingUserId() == userId && UserHandle.isSameApp(Binder.getCallingUid(), getUidForPackage(packageName)))) {
            checkManageUsersPermission("Only system can set restrictions for other users/apps");
        }
        synchronized (this.mPackagesLock) {
            if (restrictions != null) {
                if (!restrictions.isEmpty()) {
                    writeApplicationRestrictionsLocked(packageName, restrictions, userId);
                }
            }
            cleanAppRestrictionsForPackage(packageName, userId);
        }
        if (isPackageInstalled(packageName, userId)) {
            Intent changeIntent = new Intent("android.intent.action.APPLICATION_RESTRICTIONS_CHANGED");
            changeIntent.setPackage(packageName);
            changeIntent.addFlags(1073741824);
            this.mContext.sendBroadcastAsUser(changeIntent, new UserHandle(userId));
        }
    }

    public boolean setRestrictionsChallenge(String newPin) {
        checkManageUsersPermission("Only system can modify the restrictions pin");
        int userId = UserHandle.getCallingUserId();
        synchronized (this.mPackagesLock) {
            RestrictionsPinState pinState = (RestrictionsPinState) this.mRestrictionsPinStates.get(userId);
            if (pinState == null) {
                pinState = new RestrictionsPinState();
            }
            if (newPin == null) {
                pinState.salt = 0;
                pinState.pinHash = null;
            } else {
                try {
                    pinState.salt = SecureRandom.getInstance("SHA1PRNG").nextLong();
                } catch (NoSuchAlgorithmException e) {
                    pinState.salt = (long) (Math.random() * 9.223372036854776E18d);
                }
                pinState.pinHash = passwordToHash(newPin, pinState.salt);
                pinState.failedAttempts = 0;
            }
            this.mRestrictionsPinStates.put(userId, pinState);
            writeUserLocked((UserInfo) this.mUsers.get(userId));
        }
        return true;
    }

    public int checkRestrictionsChallenge(String pin) {
        int i;
        checkManageUsersPermission("Only system can verify the restrictions pin");
        int userId = UserHandle.getCallingUserId();
        synchronized (this.mPackagesLock) {
            RestrictionsPinState pinState = (RestrictionsPinState) this.mRestrictionsPinStates.get(userId);
            if (pinState == null || pinState.salt == 0 || pinState.pinHash == null) {
                i = -2;
            } else if (pin == null) {
                i = getRemainingTimeForPinAttempt(pinState);
                Slog.d(LOG_TAG, "Remaining waittime peek=" + i);
            } else {
                i = getRemainingTimeForPinAttempt(pinState);
                Slog.d(LOG_TAG, "Remaining waittime=" + i);
                if (i > 0) {
                } else if (passwordToHash(pin, pinState.salt).equals(pinState.pinHash)) {
                    pinState.failedAttempts = 0;
                    writeUserLocked((UserInfo) this.mUsers.get(userId));
                    i = -1;
                } else {
                    pinState.failedAttempts += MAX_MANAGED_PROFILES;
                    pinState.lastAttemptTime = System.currentTimeMillis();
                    writeUserLocked((UserInfo) this.mUsers.get(userId));
                }
            }
        }
        return i;
    }

    private int getRemainingTimeForPinAttempt(RestrictionsPinState pinState) {
        return (int) Math.max((((long) (pinState.failedAttempts % USER_VERSION == 0 ? BACKOFF_TIMES[Math.min(pinState.failedAttempts / USER_VERSION, BACKOFF_TIMES.length - 1)] : 0)) + pinState.lastAttemptTime) - System.currentTimeMillis(), 0);
    }

    public boolean hasRestrictionsChallenge() {
        boolean hasRestrictionsPinLocked;
        int userId = UserHandle.getCallingUserId();
        synchronized (this.mPackagesLock) {
            hasRestrictionsPinLocked = hasRestrictionsPinLocked(userId);
        }
        return hasRestrictionsPinLocked;
    }

    private boolean hasRestrictionsPinLocked(int userId) {
        RestrictionsPinState pinState = (RestrictionsPinState) this.mRestrictionsPinStates.get(userId);
        if (pinState == null || pinState.salt == 0 || pinState.pinHash == null) {
            return DBG;
        }
        return true;
    }

    public void removeRestrictions() {
        checkManageUsersPermission("Only system can remove restrictions");
        removeRestrictionsForUser(UserHandle.getCallingUserId(), true);
    }

    private void removeRestrictionsForUser(int userHandle, boolean unhideApps) {
        synchronized (this.mPackagesLock) {
            setUserRestrictions(new Bundle(), userHandle);
            setRestrictionsChallenge(null);
            cleanAppRestrictions(userHandle);
        }
        if (unhideApps) {
            unhideAllInstalledAppsForUser(userHandle);
        }
    }

    private void unhideAllInstalledAppsForUser(int userHandle) {
        this.mHandler.post(new C04623(userHandle));
    }

    private String passwordToHash(String password, long salt) {
        if (password == null) {
            return null;
        }
        String algo = null;
        String hashed = salt + password;
        try {
            byte[] saltedPassword = (password + salt).getBytes();
            algo = "MD5";
            return toHex(MessageDigest.getInstance("SHA-1").digest(saltedPassword)) + toHex(MessageDigest.getInstance(algo).digest(saltedPassword));
        } catch (NoSuchAlgorithmException e) {
            Log.w(LOG_TAG, "Failed to encode string because of missing algorithm: " + algo);
            return hashed;
        }
    }

    private static String toHex(byte[] ary) {
        String hex = "0123456789ABCDEF";
        String ret = "";
        for (int i = 0; i < ary.length; i += MAX_MANAGED_PROFILES) {
            ret = (ret + "0123456789ABCDEF".charAt((ary[i] >> 4) & 15)) + "0123456789ABCDEF".charAt(ary[i] & 15);
        }
        return ret;
    }

    private int getUidForPackage(String packageName) {
        int i;
        long ident = Binder.clearCallingIdentity();
        try {
            i = this.mContext.getPackageManager().getApplicationInfo(packageName, DumpState.DUMP_INSTALLS).uid;
        } catch (NameNotFoundException e) {
            i = -1;
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
        return i;
    }

    private Bundle readApplicationRestrictionsLocked(String packageName, int userId) {
        Bundle restrictions = new Bundle();
        ArrayList<String> values = new ArrayList();
        FileInputStream fis = null;
        try {
            int type;
            AtomicFile restrictionsFile = new AtomicFile(new File(Environment.getUserSystemDirectory(userId), packageToRestrictionsFileName(packageName)));
            fis = restrictionsFile.openRead();
            XmlPullParser parser = Xml.newPullParser();
            parser.setInput(fis, StandardCharsets.UTF_8.name());
            do {
                type = parser.next();
                if (type == 2) {
                    break;
                }
            } while (type != MAX_MANAGED_PROFILES);
            if (type != 2) {
                Slog.e(LOG_TAG, "Unable to read restrictions file " + restrictionsFile.getBaseFile());
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e) {
                    }
                }
            } else {
                while (true) {
                    type = parser.next();
                    if (type == MAX_MANAGED_PROFILES) {
                        break;
                    } else if (type == 2 && parser.getName().equals(TAG_ENTRY)) {
                        String key = parser.getAttributeValue(null, ATTR_KEY);
                        String valType = parser.getAttributeValue(null, ATTR_VALUE_TYPE);
                        String multiple = parser.getAttributeValue(null, ATTR_MULTIPLE);
                        if (multiple != null) {
                            values.clear();
                            int count = Integer.parseInt(multiple);
                            while (count > 0) {
                                type = parser.next();
                                if (type != MAX_MANAGED_PROFILES) {
                                    if (type == 2 && parser.getName().equals(TAG_VALUE)) {
                                        values.add(parser.nextText().trim());
                                        count--;
                                    }
                                }
                            }
                            break;
                            String[] valueStrings = new String[values.size()];
                            values.toArray(valueStrings);
                            restrictions.putStringArray(key, valueStrings);
                        } else {
                            String value = parser.nextText().trim();
                            if (ATTR_TYPE_BOOLEAN.equals(valType)) {
                                restrictions.putBoolean(key, Boolean.parseBoolean(value));
                            } else if (ATTR_TYPE_INTEGER.equals(valType)) {
                                restrictions.putInt(key, Integer.parseInt(value));
                            } else {
                                restrictions.putString(key, value);
                            }
                        }
                    }
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e2) {
                    }
                }
            }
        } catch (IOException e3) {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e4) {
                }
            }
        } catch (XmlPullParserException e5) {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e6) {
                }
            }
        } catch (Throwable th) {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e7) {
                }
            }
        }
        return restrictions;
    }

    private void writeApplicationRestrictionsLocked(String packageName, Bundle restrictions, int userId) {
        FileOutputStream fos = null;
        AtomicFile restrictionsFile = new AtomicFile(new File(Environment.getUserSystemDirectory(userId), packageToRestrictionsFileName(packageName)));
        try {
            fos = restrictionsFile.startWrite();
            BufferedOutputStream bos = new BufferedOutputStream(fos);
            XmlSerializer serializer = new FastXmlSerializer();
            serializer.setOutput(bos, StandardCharsets.UTF_8.name());
            serializer.startDocument(null, Boolean.valueOf(true));
            serializer.setFeature("http://xmlpull.org/v1/doc/features.html#indent-output", true);
            serializer.startTag(null, TAG_RESTRICTIONS);
            for (String key : restrictions.keySet()) {
                Object value = restrictions.get(key);
                serializer.startTag(null, TAG_ENTRY);
                serializer.attribute(null, ATTR_KEY, key);
                if (value instanceof Boolean) {
                    serializer.attribute(null, ATTR_VALUE_TYPE, ATTR_TYPE_BOOLEAN);
                    serializer.text(value.toString());
                } else if (value instanceof Integer) {
                    serializer.attribute(null, ATTR_VALUE_TYPE, ATTR_TYPE_INTEGER);
                    serializer.text(value.toString());
                } else if (value == null || (value instanceof String)) {
                    serializer.attribute(null, ATTR_VALUE_TYPE, ATTR_TYPE_STRING);
                    serializer.text(value != null ? (String) value : "");
                } else {
                    serializer.attribute(null, ATTR_VALUE_TYPE, ATTR_TYPE_STRING_ARRAY);
                    String[] values = (String[]) value;
                    serializer.attribute(null, ATTR_MULTIPLE, Integer.toString(values.length));
                    String[] arr$ = values;
                    int len$ = arr$.length;
                    for (int i$ = 0; i$ < len$; i$ += MAX_MANAGED_PROFILES) {
                        String choice = arr$[i$];
                        serializer.startTag(null, TAG_VALUE);
                        if (choice == null) {
                            choice = "";
                        }
                        serializer.text(choice);
                        serializer.endTag(null, TAG_VALUE);
                    }
                }
                serializer.endTag(null, TAG_ENTRY);
            }
            serializer.endTag(null, TAG_RESTRICTIONS);
            serializer.endDocument();
            restrictionsFile.finishWrite(fos);
        } catch (Exception e) {
            restrictionsFile.failWrite(fos);
            Slog.e(LOG_TAG, "Error writing application restrictions list");
        }
    }

    public int getUserSerialNumber(int userHandle) {
        int i;
        synchronized (this.mPackagesLock) {
            if (exists(userHandle)) {
                i = getUserInfoLocked(userHandle).serialNumber;
            } else {
                i = -1;
            }
        }
        return i;
    }

    public int getUserHandle(int userSerialNumber) {
        int userId;
        synchronized (this.mPackagesLock) {
            int[] arr$ = this.mUserIds;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += MAX_MANAGED_PROFILES) {
                userId = arr$[i$];
                if (getUserInfoLocked(userId).serialNumber == userSerialNumber) {
                    break;
                }
            }
            userId = -1;
        }
        return userId;
    }

    private void updateUserIdsLocked() {
        int i;
        int num = 0;
        for (i = 0; i < this.mUsers.size(); i += MAX_MANAGED_PROFILES) {
            if (!((UserInfo) this.mUsers.valueAt(i)).partial) {
                num += MAX_MANAGED_PROFILES;
            }
        }
        int[] newUsers = new int[num];
        int n = 0;
        for (i = 0; i < this.mUsers.size(); i += MAX_MANAGED_PROFILES) {
            if (!((UserInfo) this.mUsers.valueAt(i)).partial) {
                int n2 = n + MAX_MANAGED_PROFILES;
                newUsers[n] = this.mUsers.keyAt(i);
                n = n2;
            }
        }
        this.mUserIds = newUsers;
    }

    public void userForeground(int userId) {
        synchronized (this.mPackagesLock) {
            UserInfo user = (UserInfo) this.mUsers.get(userId);
            long now = System.currentTimeMillis();
            if (user == null || user.partial) {
                Slog.w(LOG_TAG, "userForeground: unknown user #" + userId);
                return;
            }
            if (now > EPOCH_PLUS_30_YEARS) {
                user.lastLoggedInTime = now;
                writeUserLocked(user);
            }
        }
    }

    private int getNextAvailableIdLocked() {
        int i;
        synchronized (this.mPackagesLock) {
            i = MIN_USER_ID;
            while (i < Integer.MAX_VALUE) {
                if (this.mUsers.indexOfKey(i) < 0 && !this.mRemovingUserIds.get(i)) {
                    break;
                }
                i += MAX_MANAGED_PROFILES;
            }
        }
        return i;
    }

    private String packageToRestrictionsFileName(String packageName) {
        return RESTRICTIONS_FILE_PREFIX + packageName + XML_SUFFIX;
    }

    private String restrictionsFileNameToPackage(String fileName) {
        return fileName.substring(RESTRICTIONS_FILE_PREFIX.length(), fileName.length() - XML_SUFFIX.length());
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump UserManager from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " without permission " + "android.permission.DUMP");
            return;
        }
        long now = System.currentTimeMillis();
        StringBuilder sb = new StringBuilder();
        synchronized (this.mPackagesLock) {
            pw.println("Users:");
            for (int i = 0; i < this.mUsers.size(); i += MAX_MANAGED_PROFILES) {
                UserInfo user = (UserInfo) this.mUsers.valueAt(i);
                if (user != null) {
                    pw.print("  ");
                    pw.print(user);
                    pw.print(" serialNo=");
                    pw.print(user.serialNumber);
                    if (this.mRemovingUserIds.get(this.mUsers.keyAt(i))) {
                        pw.print(" <removing> ");
                    }
                    if (user.partial) {
                        pw.print(" <partial>");
                    }
                    pw.println();
                    pw.print("    Created: ");
                    if (user.creationTime == 0) {
                        pw.println("<unknown>");
                    } else {
                        sb.setLength(0);
                        TimeUtils.formatDuration(now - user.creationTime, sb);
                        sb.append(" ago");
                        pw.println(sb);
                    }
                    pw.print("    Last logged in: ");
                    if (user.lastLoggedInTime == 0) {
                        pw.println("<unknown>");
                    } else {
                        sb.setLength(0);
                        TimeUtils.formatDuration(now - user.lastLoggedInTime, sb);
                        sb.append(" ago");
                        pw.println(sb);
                    }
                }
            }
        }
    }
}
