package com.android.server;

import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.UserInfo;
import android.database.sqlite.SQLiteDatabase;
import android.os.Binder;
import android.os.IBinder;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.os.UserManager;
import android.os.storage.IMountService;
import android.provider.Settings.Secure;
import android.provider.Settings.SettingNotFoundException;
import android.security.KeyStore;
import android.text.TextUtils;
import android.util.Slog;
import com.android.internal.widget.ILockSettings.Stub;
import com.android.internal.widget.LockPatternUtils;
import com.android.server.LockSettingsStorage.Callback;
import java.util.Arrays;
import java.util.List;

public class LockSettingsService extends Stub {
    private static final String PERMISSION = "android.permission.ACCESS_KEYGUARD_SECURE_STORAGE";
    private static final String[] READ_PROFILE_PROTECTED_SETTINGS;
    private static final String TAG = "LockSettingsService";
    private static final String[] VALID_SETTINGS;
    private final BroadcastReceiver mBroadcastReceiver;
    private final Context mContext;
    private boolean mFirstCallToVold;
    private LockPatternUtils mLockPatternUtils;
    private final LockSettingsStorage mStorage;

    /* renamed from: com.android.server.LockSettingsService.1 */
    class C00541 implements Callback {
        C00541() {
        }

        public void initialize(SQLiteDatabase db) {
            if (SystemProperties.getBoolean("ro.lockscreen.disable.default", false)) {
                LockSettingsService.this.mStorage.writeKeyValue(db, "lockscreen.disabled", "1", 0);
            }
        }
    }

    /* renamed from: com.android.server.LockSettingsService.2 */
    class C00552 extends BroadcastReceiver {
        C00552() {
        }

        public void onReceive(Context context, Intent intent) {
            if ("android.intent.action.USER_ADDED".equals(intent.getAction())) {
                int userHandle = intent.getIntExtra("android.intent.extra.user_handle", 0);
                int userSysUid = UserHandle.getUid(userHandle, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                KeyStore ks = KeyStore.getInstance();
                ks.resetUid(userSysUid);
                UserInfo parentInfo = ((UserManager) LockSettingsService.this.mContext.getSystemService("user")).getProfileParent(userHandle);
                if (parentInfo != null) {
                    ks.syncUid(UserHandle.getUid(parentInfo.id, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE), userSysUid);
                }
            } else if ("android.intent.action.USER_STARTING".equals(intent.getAction())) {
                LockSettingsService.this.mStorage.prefetchUser(intent.getIntExtra("android.intent.extra.user_handle", 0));
            }
        }
    }

    public LockSettingsService(Context context) {
        this.mBroadcastReceiver = new C00552();
        this.mContext = context;
        this.mLockPatternUtils = new LockPatternUtils(context);
        this.mFirstCallToVold = true;
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.USER_ADDED");
        filter.addAction("android.intent.action.USER_STARTING");
        this.mContext.registerReceiverAsUser(this.mBroadcastReceiver, UserHandle.ALL, filter, null, null);
        this.mStorage = new LockSettingsStorage(context, new C00541());
    }

    public void systemReady() {
        migrateOldData();
        this.mStorage.prefetchUser(0);
    }

    private void migrateOldData() {
        try {
            ContentResolver cr;
            if (getString("migrated", null, 0) == null) {
                cr = this.mContext.getContentResolver();
                for (String validSetting : VALID_SETTINGS) {
                    String value = Secure.getString(cr, validSetting);
                    if (value != null) {
                        setString(validSetting, value, 0);
                    }
                }
                setString("migrated", "true", 0);
                Slog.i(TAG, "Migrated lock settings to new location");
            }
            if (getString("migrated_user_specific", null, 0) == null) {
                UserManager um = (UserManager) this.mContext.getSystemService("user");
                cr = this.mContext.getContentResolver();
                List<UserInfo> users = um.getUsers();
                for (int user = 0; user < users.size(); user++) {
                    int userId = ((UserInfo) users.get(user)).id;
                    String OWNER_INFO = "lock_screen_owner_info";
                    String ownerInfo = Secure.getStringForUser(cr, "lock_screen_owner_info", userId);
                    if (ownerInfo != null) {
                        setString("lock_screen_owner_info", ownerInfo, userId);
                        Secure.putStringForUser(cr, ownerInfo, "", userId);
                    }
                    String OWNER_INFO_ENABLED = "lock_screen_owner_info_enabled";
                    try {
                        setLong("lock_screen_owner_info_enabled", Secure.getIntForUser(cr, "lock_screen_owner_info_enabled", userId) != 0 ? 1 : 0, userId);
                    } catch (SettingNotFoundException e) {
                        if (!TextUtils.isEmpty(ownerInfo)) {
                            setLong("lock_screen_owner_info_enabled", 1, userId);
                        }
                    }
                    Secure.putIntForUser(cr, "lock_screen_owner_info_enabled", 0, userId);
                }
                setString("migrated_user_specific", "true", 0);
                Slog.i(TAG, "Migrated per-user lock settings to new location");
            }
        } catch (Throwable re) {
            Slog.e(TAG, "Unable to migrate old data", re);
        }
    }

    private final void checkWritePermission(int userId) {
        this.mContext.enforceCallingOrSelfPermission(PERMISSION, "LockSettingsWrite");
    }

    private final void checkPasswordReadPermission(int userId) {
        this.mContext.enforceCallingOrSelfPermission(PERMISSION, "LockSettingsRead");
    }

    private final void checkReadPermission(String requestedKey, int userId) {
        int callingUid = Binder.getCallingUid();
        int i = 0;
        while (i < READ_PROFILE_PROTECTED_SETTINGS.length) {
            if (!READ_PROFILE_PROTECTED_SETTINGS[i].equals(requestedKey) || this.mContext.checkCallingOrSelfPermission("android.permission.READ_PROFILE") == 0) {
                i++;
            } else {
                throw new SecurityException("uid=" + callingUid + " needs permission " + "android.permission.READ_PROFILE" + " to read " + requestedKey + " for user " + userId);
            }
        }
    }

    public void setBoolean(String key, boolean value, int userId) throws RemoteException {
        checkWritePermission(userId);
        setStringUnchecked(key, userId, value ? "1" : "0");
    }

    public void setLong(String key, long value, int userId) throws RemoteException {
        checkWritePermission(userId);
        setStringUnchecked(key, userId, Long.toString(value));
    }

    public void setString(String key, String value, int userId) throws RemoteException {
        checkWritePermission(userId);
        setStringUnchecked(key, userId, value);
    }

    private void setStringUnchecked(String key, int userId, String value) {
        this.mStorage.writeKeyValue(key, value, userId);
    }

    public boolean getBoolean(String key, boolean defaultValue, int userId) throws RemoteException {
        checkReadPermission(key, userId);
        String value = this.mStorage.readKeyValue(key, null, userId);
        if (TextUtils.isEmpty(value)) {
            return defaultValue;
        }
        return value.equals("1") || value.equals("true");
    }

    public long getLong(String key, long defaultValue, int userId) throws RemoteException {
        checkReadPermission(key, userId);
        String value = this.mStorage.readKeyValue(key, null, userId);
        return TextUtils.isEmpty(value) ? defaultValue : Long.parseLong(value);
    }

    public String getString(String key, String defaultValue, int userId) throws RemoteException {
        checkReadPermission(key, userId);
        return this.mStorage.readKeyValue(key, defaultValue, userId);
    }

    public boolean havePassword(int userId) throws RemoteException {
        return this.mStorage.hasPassword(userId);
    }

    public boolean havePattern(int userId) throws RemoteException {
        return this.mStorage.hasPattern(userId);
    }

    private void maybeUpdateKeystore(String password, int userHandle) {
        UserManager um = (UserManager) this.mContext.getSystemService("user");
        KeyStore ks = KeyStore.getInstance();
        List<UserInfo> profiles = um.getProfiles(userHandle);
        boolean shouldReset = TextUtils.isEmpty(password);
        if (userHandle == 0 && profiles.size() == 1 && !ks.isEmpty()) {
            shouldReset = false;
        }
        for (UserInfo pi : profiles) {
            int profileUid = UserHandle.getUid(pi.id, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
            if (shouldReset) {
                ks.resetUid(profileUid);
            } else {
                ks.passwordUid(password, profileUid);
            }
        }
    }

    public void setLockPattern(String pattern, int userId) throws RemoteException {
        checkWritePermission(userId);
        maybeUpdateKeystore(pattern, userId);
        this.mStorage.writePatternHash(LockPatternUtils.patternToHash(LockPatternUtils.stringToPattern(pattern)), userId);
    }

    public void setLockPassword(String password, int userId) throws RemoteException {
        checkWritePermission(userId);
        maybeUpdateKeystore(password, userId);
        this.mStorage.writePasswordHash(this.mLockPatternUtils.passwordToHash(password, userId), userId);
    }

    public boolean checkPattern(String pattern, int userId) throws RemoteException {
        checkPasswordReadPermission(userId);
        byte[] hash = LockPatternUtils.patternToHash(LockPatternUtils.stringToPattern(pattern));
        byte[] storedHash = this.mStorage.readPatternHash(userId);
        if (storedHash == null) {
            return true;
        }
        boolean matched = Arrays.equals(hash, storedHash);
        if (!matched || TextUtils.isEmpty(pattern)) {
            return matched;
        }
        maybeUpdateKeystore(pattern, userId);
        return matched;
    }

    public boolean checkPassword(String password, int userId) throws RemoteException {
        checkPasswordReadPermission(userId);
        byte[] hash = this.mLockPatternUtils.passwordToHash(password, userId);
        byte[] storedHash = this.mStorage.readPasswordHash(userId);
        if (storedHash == null) {
            return true;
        }
        boolean matched = Arrays.equals(hash, storedHash);
        if (!matched || TextUtils.isEmpty(password)) {
            return matched;
        }
        maybeUpdateKeystore(password, userId);
        return matched;
    }

    public boolean checkVoldPassword(int userId) throws RemoteException {
        if (!this.mFirstCallToVold) {
            return false;
        }
        this.mFirstCallToVold = false;
        checkPasswordReadPermission(userId);
        IMountService service = getMountService();
        String password = service.getPassword();
        service.clearPassword();
        if (password == null) {
            return false;
        }
        try {
            if (this.mLockPatternUtils.isLockPatternEnabled() && checkPattern(password, userId)) {
                return true;
            }
        } catch (Exception e) {
        }
        try {
            if (this.mLockPatternUtils.isLockPasswordEnabled() && checkPassword(password, userId)) {
                return true;
            }
            return false;
        } catch (Exception e2) {
            return false;
        }
    }

    public void removeUser(int userId) {
        checkWritePermission(userId);
        this.mStorage.removeUser(userId);
        KeyStore.getInstance().resetUid(UserHandle.getUid(userId, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE));
    }

    static {
        VALID_SETTINGS = new String[]{"lockscreen.lockedoutpermanently", "lockscreen.lockoutattemptdeadline", "lockscreen.patterneverchosen", "lockscreen.password_type", "lockscreen.password_type_alternate", "lockscreen.password_salt", "lockscreen.disabled", "lockscreen.options", "lockscreen.biometric_weak_fallback", "lockscreen.biometricweakeverchosen", "lockscreen.power_button_instantly_locks", "lockscreen.passwordhistory", "lock_pattern_autolock", "lock_biometric_weak_flags", "lock_pattern_visible_pattern", "lock_pattern_tactile_feedback_enabled"};
        READ_PROFILE_PROTECTED_SETTINGS = new String[]{"lock_screen_owner_info_enabled", "lock_screen_owner_info"};
    }

    private IMountService getMountService() {
        IBinder service = ServiceManager.getService("mount");
        if (service != null) {
            return IMountService.Stub.asInterface(service);
        }
        return null;
    }
}
