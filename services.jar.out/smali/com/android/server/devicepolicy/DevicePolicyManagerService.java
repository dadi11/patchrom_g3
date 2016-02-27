package com.android.server.devicepolicy;

import android.accessibilityservice.AccessibilityServiceInfo;
import android.accounts.Account;
import android.accounts.AccountManager;
import android.app.ActivityManagerNative;
import android.app.AlarmManager;
import android.app.AppGlobals;
import android.app.IActivityManager;
import android.app.Notification.Builder;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.admin.DeviceAdminInfo;
import android.app.admin.DeviceAdminInfo.PolicyInfo;
import android.app.admin.DevicePolicyManagerInternal;
import android.app.admin.DevicePolicyManagerInternal.OnCrossProfileWidgetProvidersChangeListener;
import android.app.admin.IDevicePolicyManager.Stub;
import android.app.backup.IBackupManager;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.IPackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.UserInfo;
import android.database.ContentObserver;
import android.media.AudioManager;
import android.media.IAudioService;
import android.net.ConnectivityManager;
import android.net.ProxyInfo;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Binder;
import android.os.Bundle;
import android.os.Environment;
import android.os.FileUtils;
import android.os.Handler;
import android.os.IBinder;
import android.os.PersistableBundle;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.PowerManagerInternal;
import android.os.Process;
import android.os.RecoverySystem;
import android.os.RemoteCallback;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.os.UserManager;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.security.Credentials;
import android.security.KeyChain;
import android.security.KeyChain.KeyChainConnection;
import android.service.persistentdata.PersistentDataBlockManager;
import android.text.TextUtils;
import android.util.Log;
import android.util.PrintWriterPrinter;
import android.util.Printer;
import android.util.Slog;
import android.util.SparseArray;
import android.view.IWindowManager;
import android.view.accessibility.AccessibilityManager;
import android.view.accessibility.IAccessibilityManager;
import android.view.inputmethod.InputMethodInfo;
import android.view.inputmethod.InputMethodManager;
import com.android.internal.os.storage.ExternalStorageFormatter;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.util.JournaledFile;
import com.android.internal.util.XmlUtils;
import com.android.internal.widget.LockPatternUtils;
import com.android.server.LocalServices;
import com.android.server.SystemService;
import com.android.server.wm.AppTransition;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class DevicePolicyManagerService extends Stub {
    protected static final String ACTION_EXPIRED_PASSWORD_NOTIFICATION = "com.android.server.ACTION_EXPIRED_PASSWORD_NOTIFICATION";
    private static final String ATTR_PERMISSION_PROVIDER = "permission-provider";
    private static final String ATTR_SETUP_COMPLETE = "setup-complete";
    private static final boolean DBG = false;
    private static final Set<String> DEVICE_OWNER_USER_RESTRICTIONS;
    private static final String DEVICE_POLICIES_XML = "device_policies.xml";
    private static final long EXPIRATION_GRACE_PERIOD_MS = 432000000;
    private static final Set<String> GLOBAL_SETTINGS_WHITELIST;
    private static final String LOCK_TASK_COMPONENTS_XML = "lock-task-component";
    private static final String LOG_TAG = "DevicePolicyManagerService";
    private static final int MONITORING_CERT_NOTIFICATION_ID = 17039597;
    private static final long MS_PER_DAY = 86400000;
    private static final int REQUEST_EXPIRE_PASSWORD = 5571;
    private static final Set<String> SECURE_SETTINGS_DEVICEOWNER_WHITELIST;
    private static final Set<String> SECURE_SETTINGS_WHITELIST;
    public static final String SYSTEM_PROP_DISABLE_CAMERA = "sys.secpolicy.camera.disabled";
    final Context mContext;
    private DeviceOwner mDeviceOwner;
    Handler mHandler;
    private boolean mHasFeature;
    IWindowManager mIWindowManager;
    final LocalService mLocalService;
    NotificationManager mNotificationManager;
    final PowerManager mPowerManager;
    final PowerManagerInternal mPowerManagerInternal;
    BroadcastReceiver mReceiver;
    final SparseArray<DevicePolicyData> mUserData;
    final UserManager mUserManager;
    final WakeLock mWakeLock;

    /* renamed from: com.android.server.devicepolicy.DevicePolicyManagerService.1 */
    class C01871 extends BroadcastReceiver {

        /* renamed from: com.android.server.devicepolicy.DevicePolicyManagerService.1.1 */
        class C01861 implements Runnable {
            final /* synthetic */ int val$userHandle;

            C01861(int i) {
                this.val$userHandle = i;
            }

            public void run() {
                DevicePolicyManagerService.this.handlePasswordExpirationNotification(this.val$userHandle);
            }
        }

        C01871() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            int userHandle = intent.getIntExtra("android.intent.extra.user_handle", getSendingUserId());
            if ("android.intent.action.BOOT_COMPLETED".equals(action) || DevicePolicyManagerService.ACTION_EXPIRED_PASSWORD_NOTIFICATION.equals(action)) {
                DevicePolicyManagerService.this.mHandler.post(new C01861(userHandle));
            }
            if ("android.intent.action.BOOT_COMPLETED".equals(action) || "android.security.STORAGE_CHANGED".equals(action)) {
                new MonitoringCertNotificationTask(null).execute(new Intent[]{intent});
            }
            if ("android.intent.action.USER_REMOVED".equals(action)) {
                DevicePolicyManagerService.this.removeUserData(userHandle);
            } else if ("android.intent.action.USER_STARTED".equals(action) || "android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE".equals(action)) {
                if ("android.intent.action.USER_STARTED".equals(action)) {
                    synchronized (DevicePolicyManagerService.this) {
                        DevicePolicyManagerService.this.mUserData.remove(userHandle);
                    }
                }
                DevicePolicyManagerService.this.handlePackagesChanged(null, userHandle);
            } else if ("android.intent.action.PACKAGE_CHANGED".equals(action) || ("android.intent.action.PACKAGE_ADDED".equals(action) && intent.getBooleanExtra("android.intent.extra.REPLACING", DevicePolicyManagerService.DBG))) {
                DevicePolicyManagerService.this.handlePackagesChanged(intent.getData().getSchemeSpecificPart(), userHandle);
            } else if ("android.intent.action.PACKAGE_REMOVED".equals(action) && !intent.getBooleanExtra("android.intent.extra.REPLACING", DevicePolicyManagerService.DBG)) {
                DevicePolicyManagerService.this.handlePackagesChanged(intent.getData().getSchemeSpecificPart(), userHandle);
            }
        }
    }

    /* renamed from: com.android.server.devicepolicy.DevicePolicyManagerService.2 */
    class C01882 extends BroadcastReceiver {
        final /* synthetic */ ActiveAdmin val$admin;
        final /* synthetic */ ComponentName val$adminReceiver;

        C01882(ActiveAdmin activeAdmin, ComponentName componentName) {
            this.val$admin = activeAdmin;
            this.val$adminReceiver = componentName;
        }

        public void onReceive(Context context, Intent intent) {
            synchronized (DevicePolicyManagerService.this) {
                int userHandle = this.val$admin.getUserHandle().getIdentifier();
                DevicePolicyData policy = DevicePolicyManagerService.this.getUserData(userHandle);
                boolean doProxyCleanup = this.val$admin.info.usesPolicy(5);
                policy.mAdminList.remove(this.val$admin);
                policy.mAdminMap.remove(this.val$adminReceiver);
                DevicePolicyManagerService.this.validatePasswordOwnerLocked(policy);
                DevicePolicyManagerService.this.syncDeviceCapabilitiesLocked(policy);
                if (doProxyCleanup) {
                    DevicePolicyManagerService.this.resetGlobalProxyLocked(DevicePolicyManagerService.this.getUserData(userHandle));
                }
                DevicePolicyManagerService.this.saveSettingsLocked(userHandle);
                DevicePolicyManagerService.this.updateMaximumTimeToLockLocked(policy);
                policy.mRemovingAdmins.remove(this.val$adminReceiver);
            }
        }
    }

    /* renamed from: com.android.server.devicepolicy.DevicePolicyManagerService.3 */
    class C01893 implements Runnable {
        final /* synthetic */ int val$userHandle;

        C01893(int i) {
            this.val$userHandle = i;
        }

        public void run() {
            try {
                IActivityManager am = ActivityManagerNative.getDefault();
                if (am.getCurrentUser().id == this.val$userHandle) {
                    am.switchUser(0);
                }
                if (!DevicePolicyManagerService.this.mUserManager.removeUser(this.val$userHandle)) {
                    Slog.w(DevicePolicyManagerService.LOG_TAG, "Couldn't remove user " + this.val$userHandle);
                }
            } catch (RemoteException e) {
            }
        }
    }

    /* renamed from: com.android.server.devicepolicy.DevicePolicyManagerService.4 */
    class C01904 extends BroadcastReceiver {
        final /* synthetic */ RemoteCallback val$result;

        C01904(RemoteCallback remoteCallback) {
            this.val$result = remoteCallback;
        }

        public void onReceive(Context context, Intent intent) {
            try {
                this.val$result.sendResult(getResultExtras(DevicePolicyManagerService.DBG));
            } catch (RemoteException e) {
            }
        }
    }

    static class ActiveAdmin {
        private static final String ATTR_VALUE = "value";
        static final int DEF_KEYGUARD_FEATURES_DISABLED = 0;
        static final int DEF_MAXIMUM_FAILED_PASSWORDS_FOR_WIPE = 0;
        static final long DEF_MAXIMUM_TIME_TO_UNLOCK = 0;
        static final int DEF_MINIMUM_PASSWORD_LENGTH = 0;
        static final int DEF_MINIMUM_PASSWORD_LETTERS = 1;
        static final int DEF_MINIMUM_PASSWORD_LOWER_CASE = 0;
        static final int DEF_MINIMUM_PASSWORD_NON_LETTER = 0;
        static final int DEF_MINIMUM_PASSWORD_NUMERIC = 1;
        static final int DEF_MINIMUM_PASSWORD_SYMBOLS = 1;
        static final int DEF_MINIMUM_PASSWORD_UPPER_CASE = 0;
        static final long DEF_PASSWORD_EXPIRATION_DATE = 0;
        static final long DEF_PASSWORD_EXPIRATION_TIMEOUT = 0;
        static final int DEF_PASSWORD_HISTORY_LENGTH = 0;
        private static final String TAG_ACCOUNT_TYPE = "account-type";
        private static final String TAG_CROSS_PROFILE_WIDGET_PROVIDERS = "cross-profile-widget-providers";
        private static final String TAG_DISABLE_ACCOUNT_MANAGEMENT = "disable-account-management";
        private static final String TAG_DISABLE_CALLER_ID = "disable-caller-id";
        private static final String TAG_DISABLE_CAMERA = "disable-camera";
        private static final String TAG_DISABLE_KEYGUARD_FEATURES = "disable-keyguard-features";
        private static final String TAG_DISABLE_SCREEN_CAPTURE = "disable-screen-capture";
        private static final String TAG_ENCRYPTION_REQUESTED = "encryption-requested";
        private static final String TAG_GLOBAL_PROXY_EXCLUSION_LIST = "global-proxy-exclusion-list";
        private static final String TAG_GLOBAL_PROXY_SPEC = "global-proxy-spec";
        private static final String TAG_MANAGE_TRUST_AGENT_FEATURES = "manage-trust-agent-features";
        private static final String TAG_MAX_FAILED_PASSWORD_WIPE = "max-failed-password-wipe";
        private static final String TAG_MAX_TIME_TO_UNLOCK = "max-time-to-unlock";
        private static final String TAG_MIN_PASSWORD_LENGTH = "min-password-length";
        private static final String TAG_MIN_PASSWORD_LETTERS = "min-password-letters";
        private static final String TAG_MIN_PASSWORD_LOWERCASE = "min-password-lowercase";
        private static final String TAG_MIN_PASSWORD_NONLETTER = "min-password-nonletter";
        private static final String TAG_MIN_PASSWORD_NUMERIC = "min-password-numeric";
        private static final String TAG_MIN_PASSWORD_SYMBOLS = "min-password-symbols";
        private static final String TAG_MIN_PASSWORD_UPPERCASE = "min-password-uppercase";
        private static final String TAG_PACKAGE_LIST_ITEM = "item";
        private static final String TAG_PASSWORD_EXPIRATION_DATE = "password-expiration-date";
        private static final String TAG_PASSWORD_EXPIRATION_TIMEOUT = "password-expiration-timeout";
        private static final String TAG_PASSWORD_HISTORY_LENGTH = "password-history-length";
        private static final String TAG_PASSWORD_QUALITY = "password-quality";
        private static final String TAG_PERMITTED_ACCESSIBILITY_SERVICES = "permitted-accessiblity-services";
        private static final String TAG_PERMITTED_IMES = "permitted-imes";
        private static final String TAG_POLICIES = "policies";
        private static final String TAG_PROVIDER = "provider";
        private static final String TAG_REQUIRE_AUTO_TIME = "require_auto_time";
        private static final String TAG_SPECIFIES_GLOBAL_PROXY = "specifies-global-proxy";
        private static final String TAG_TRUST_AGENT_COMPONENT = "component";
        private static final String TAG_TRUST_AGENT_COMPONENT_OPTIONS = "trust-agent-component-options";
        Set<String> accountTypesWithManagementDisabled;
        List<String> crossProfileWidgetProviders;
        boolean disableCallerId;
        boolean disableCamera;
        boolean disableScreenCapture;
        int disabledKeyguardFeatures;
        boolean encryptionRequested;
        String globalProxyExclusionList;
        String globalProxySpec;
        final DeviceAdminInfo info;
        int maximumFailedPasswordsForWipe;
        long maximumTimeToUnlock;
        int minimumPasswordLength;
        int minimumPasswordLetters;
        int minimumPasswordLowerCase;
        int minimumPasswordNonLetter;
        int minimumPasswordNumeric;
        int minimumPasswordSymbols;
        int minimumPasswordUpperCase;
        long passwordExpirationDate;
        long passwordExpirationTimeout;
        int passwordHistoryLength;
        int passwordQuality;
        List<String> permittedAccessiblityServices;
        List<String> permittedInputMethods;
        boolean requireAutoTime;
        boolean specifiesGlobalProxy;
        HashMap<String, TrustAgentInfo> trustAgentInfos;

        static class TrustAgentInfo {
            public PersistableBundle options;

            TrustAgentInfo(PersistableBundle bundle) {
                this.options = bundle;
            }
        }

        ActiveAdmin(DeviceAdminInfo _info) {
            this.passwordQuality = DEF_PASSWORD_HISTORY_LENGTH;
            this.minimumPasswordLength = DEF_PASSWORD_HISTORY_LENGTH;
            this.passwordHistoryLength = DEF_PASSWORD_HISTORY_LENGTH;
            this.minimumPasswordUpperCase = DEF_PASSWORD_HISTORY_LENGTH;
            this.minimumPasswordLowerCase = DEF_PASSWORD_HISTORY_LENGTH;
            this.minimumPasswordLetters = DEF_MINIMUM_PASSWORD_SYMBOLS;
            this.minimumPasswordNumeric = DEF_MINIMUM_PASSWORD_SYMBOLS;
            this.minimumPasswordSymbols = DEF_MINIMUM_PASSWORD_SYMBOLS;
            this.minimumPasswordNonLetter = DEF_PASSWORD_HISTORY_LENGTH;
            this.maximumTimeToUnlock = DEF_PASSWORD_EXPIRATION_TIMEOUT;
            this.maximumFailedPasswordsForWipe = DEF_PASSWORD_HISTORY_LENGTH;
            this.passwordExpirationTimeout = DEF_PASSWORD_EXPIRATION_TIMEOUT;
            this.passwordExpirationDate = DEF_PASSWORD_EXPIRATION_TIMEOUT;
            this.disabledKeyguardFeatures = DEF_PASSWORD_HISTORY_LENGTH;
            this.encryptionRequested = DevicePolicyManagerService.DBG;
            this.disableCamera = DevicePolicyManagerService.DBG;
            this.disableCallerId = DevicePolicyManagerService.DBG;
            this.disableScreenCapture = DevicePolicyManagerService.DBG;
            this.requireAutoTime = DevicePolicyManagerService.DBG;
            this.accountTypesWithManagementDisabled = new HashSet();
            this.specifiesGlobalProxy = DevicePolicyManagerService.DBG;
            this.globalProxySpec = null;
            this.globalProxyExclusionList = null;
            this.trustAgentInfos = new HashMap();
            this.info = _info;
        }

        int getUid() {
            return this.info.getActivityInfo().applicationInfo.uid;
        }

        public UserHandle getUserHandle() {
            return new UserHandle(UserHandle.getUserId(this.info.getActivityInfo().applicationInfo.uid));
        }

        void writeToXml(XmlSerializer out) throws IllegalArgumentException, IllegalStateException, IOException {
            out.startTag(null, TAG_POLICIES);
            this.info.writePoliciesToXml(out);
            out.endTag(null, TAG_POLICIES);
            if (this.passwordQuality != 0) {
                out.startTag(null, TAG_PASSWORD_QUALITY);
                out.attribute(null, ATTR_VALUE, Integer.toString(this.passwordQuality));
                out.endTag(null, TAG_PASSWORD_QUALITY);
                if (this.minimumPasswordLength != 0) {
                    out.startTag(null, TAG_MIN_PASSWORD_LENGTH);
                    out.attribute(null, ATTR_VALUE, Integer.toString(this.minimumPasswordLength));
                    out.endTag(null, TAG_MIN_PASSWORD_LENGTH);
                }
                if (this.passwordHistoryLength != 0) {
                    out.startTag(null, TAG_PASSWORD_HISTORY_LENGTH);
                    out.attribute(null, ATTR_VALUE, Integer.toString(this.passwordHistoryLength));
                    out.endTag(null, TAG_PASSWORD_HISTORY_LENGTH);
                }
                if (this.minimumPasswordUpperCase != 0) {
                    out.startTag(null, TAG_MIN_PASSWORD_UPPERCASE);
                    out.attribute(null, ATTR_VALUE, Integer.toString(this.minimumPasswordUpperCase));
                    out.endTag(null, TAG_MIN_PASSWORD_UPPERCASE);
                }
                if (this.minimumPasswordLowerCase != 0) {
                    out.startTag(null, TAG_MIN_PASSWORD_LOWERCASE);
                    out.attribute(null, ATTR_VALUE, Integer.toString(this.minimumPasswordLowerCase));
                    out.endTag(null, TAG_MIN_PASSWORD_LOWERCASE);
                }
                if (this.minimumPasswordLetters != DEF_MINIMUM_PASSWORD_SYMBOLS) {
                    out.startTag(null, TAG_MIN_PASSWORD_LETTERS);
                    out.attribute(null, ATTR_VALUE, Integer.toString(this.minimumPasswordLetters));
                    out.endTag(null, TAG_MIN_PASSWORD_LETTERS);
                }
                if (this.minimumPasswordNumeric != DEF_MINIMUM_PASSWORD_SYMBOLS) {
                    out.startTag(null, TAG_MIN_PASSWORD_NUMERIC);
                    out.attribute(null, ATTR_VALUE, Integer.toString(this.minimumPasswordNumeric));
                    out.endTag(null, TAG_MIN_PASSWORD_NUMERIC);
                }
                if (this.minimumPasswordSymbols != DEF_MINIMUM_PASSWORD_SYMBOLS) {
                    out.startTag(null, TAG_MIN_PASSWORD_SYMBOLS);
                    out.attribute(null, ATTR_VALUE, Integer.toString(this.minimumPasswordSymbols));
                    out.endTag(null, TAG_MIN_PASSWORD_SYMBOLS);
                }
                if (this.minimumPasswordNonLetter > 0) {
                    out.startTag(null, TAG_MIN_PASSWORD_NONLETTER);
                    out.attribute(null, ATTR_VALUE, Integer.toString(this.minimumPasswordNonLetter));
                    out.endTag(null, TAG_MIN_PASSWORD_NONLETTER);
                }
            }
            if (this.maximumTimeToUnlock != DEF_PASSWORD_EXPIRATION_TIMEOUT) {
                out.startTag(null, TAG_MAX_TIME_TO_UNLOCK);
                out.attribute(null, ATTR_VALUE, Long.toString(this.maximumTimeToUnlock));
                out.endTag(null, TAG_MAX_TIME_TO_UNLOCK);
            }
            if (this.maximumFailedPasswordsForWipe != 0) {
                out.startTag(null, TAG_MAX_FAILED_PASSWORD_WIPE);
                out.attribute(null, ATTR_VALUE, Integer.toString(this.maximumFailedPasswordsForWipe));
                out.endTag(null, TAG_MAX_FAILED_PASSWORD_WIPE);
            }
            if (this.specifiesGlobalProxy) {
                out.startTag(null, TAG_SPECIFIES_GLOBAL_PROXY);
                out.attribute(null, ATTR_VALUE, Boolean.toString(this.specifiesGlobalProxy));
                out.endTag(null, TAG_SPECIFIES_GLOBAL_PROXY);
                if (this.globalProxySpec != null) {
                    out.startTag(null, TAG_GLOBAL_PROXY_SPEC);
                    out.attribute(null, ATTR_VALUE, this.globalProxySpec);
                    out.endTag(null, TAG_GLOBAL_PROXY_SPEC);
                }
                if (this.globalProxyExclusionList != null) {
                    out.startTag(null, TAG_GLOBAL_PROXY_EXCLUSION_LIST);
                    out.attribute(null, ATTR_VALUE, this.globalProxyExclusionList);
                    out.endTag(null, TAG_GLOBAL_PROXY_EXCLUSION_LIST);
                }
            }
            if (this.passwordExpirationTimeout != DEF_PASSWORD_EXPIRATION_TIMEOUT) {
                out.startTag(null, TAG_PASSWORD_EXPIRATION_TIMEOUT);
                out.attribute(null, ATTR_VALUE, Long.toString(this.passwordExpirationTimeout));
                out.endTag(null, TAG_PASSWORD_EXPIRATION_TIMEOUT);
            }
            if (this.passwordExpirationDate != DEF_PASSWORD_EXPIRATION_TIMEOUT) {
                out.startTag(null, TAG_PASSWORD_EXPIRATION_DATE);
                out.attribute(null, ATTR_VALUE, Long.toString(this.passwordExpirationDate));
                out.endTag(null, TAG_PASSWORD_EXPIRATION_DATE);
            }
            if (this.encryptionRequested) {
                out.startTag(null, TAG_ENCRYPTION_REQUESTED);
                out.attribute(null, ATTR_VALUE, Boolean.toString(this.encryptionRequested));
                out.endTag(null, TAG_ENCRYPTION_REQUESTED);
            }
            if (this.disableCamera) {
                out.startTag(null, TAG_DISABLE_CAMERA);
                out.attribute(null, ATTR_VALUE, Boolean.toString(this.disableCamera));
                out.endTag(null, TAG_DISABLE_CAMERA);
            }
            if (this.disableCallerId) {
                out.startTag(null, TAG_DISABLE_CALLER_ID);
                out.attribute(null, ATTR_VALUE, Boolean.toString(this.disableCallerId));
                out.endTag(null, TAG_DISABLE_CALLER_ID);
            }
            if (this.disableScreenCapture) {
                out.startTag(null, TAG_DISABLE_SCREEN_CAPTURE);
                out.attribute(null, ATTR_VALUE, Boolean.toString(this.disableScreenCapture));
                out.endTag(null, TAG_DISABLE_SCREEN_CAPTURE);
            }
            if (this.requireAutoTime) {
                out.startTag(null, TAG_REQUIRE_AUTO_TIME);
                out.attribute(null, ATTR_VALUE, Boolean.toString(this.requireAutoTime));
                out.endTag(null, TAG_REQUIRE_AUTO_TIME);
            }
            if (this.disabledKeyguardFeatures != 0) {
                out.startTag(null, TAG_DISABLE_KEYGUARD_FEATURES);
                out.attribute(null, ATTR_VALUE, Integer.toString(this.disabledKeyguardFeatures));
                out.endTag(null, TAG_DISABLE_KEYGUARD_FEATURES);
            }
            if (!this.accountTypesWithManagementDisabled.isEmpty()) {
                out.startTag(null, TAG_DISABLE_ACCOUNT_MANAGEMENT);
                for (String ac : this.accountTypesWithManagementDisabled) {
                    out.startTag(null, TAG_ACCOUNT_TYPE);
                    out.attribute(null, ATTR_VALUE, ac);
                    out.endTag(null, TAG_ACCOUNT_TYPE);
                }
                out.endTag(null, TAG_DISABLE_ACCOUNT_MANAGEMENT);
            }
            if (!this.trustAgentInfos.isEmpty()) {
                Set<Entry<String, TrustAgentInfo>> set = this.trustAgentInfos.entrySet();
                out.startTag(null, TAG_MANAGE_TRUST_AGENT_FEATURES);
                for (Entry<String, TrustAgentInfo> entry : set) {
                    TrustAgentInfo trustAgentInfo = (TrustAgentInfo) entry.getValue();
                    out.startTag(null, TAG_TRUST_AGENT_COMPONENT);
                    out.attribute(null, ATTR_VALUE, (String) entry.getKey());
                    if (trustAgentInfo.options != null) {
                        out.startTag(null, TAG_TRUST_AGENT_COMPONENT_OPTIONS);
                        try {
                            trustAgentInfo.options.saveToXml(out);
                        } catch (XmlPullParserException e) {
                            Log.e(DevicePolicyManagerService.LOG_TAG, "Failed to save TrustAgent options", e);
                        }
                        out.endTag(null, TAG_TRUST_AGENT_COMPONENT_OPTIONS);
                    }
                    out.endTag(null, TAG_TRUST_AGENT_COMPONENT);
                }
                out.endTag(null, TAG_MANAGE_TRUST_AGENT_FEATURES);
            }
            if (!(this.crossProfileWidgetProviders == null || this.crossProfileWidgetProviders.isEmpty())) {
                out.startTag(null, TAG_CROSS_PROFILE_WIDGET_PROVIDERS);
                int providerCount = this.crossProfileWidgetProviders.size();
                for (int i = DEF_PASSWORD_HISTORY_LENGTH; i < providerCount; i += DEF_MINIMUM_PASSWORD_SYMBOLS) {
                    String provider = (String) this.crossProfileWidgetProviders.get(i);
                    out.startTag(null, TAG_PROVIDER);
                    out.attribute(null, ATTR_VALUE, provider);
                    out.endTag(null, TAG_PROVIDER);
                }
                out.endTag(null, TAG_CROSS_PROFILE_WIDGET_PROVIDERS);
            }
            writePackageListToXml(out, TAG_PERMITTED_ACCESSIBILITY_SERVICES, this.permittedAccessiblityServices);
            writePackageListToXml(out, TAG_PERMITTED_IMES, this.permittedInputMethods);
        }

        void writePackageListToXml(XmlSerializer out, String outerTag, List<String> packageList) throws IllegalArgumentException, IllegalStateException, IOException {
            if (packageList != null) {
                out.startTag(null, outerTag);
                for (String packageName : packageList) {
                    out.startTag(null, TAG_PACKAGE_LIST_ITEM);
                    out.attribute(null, ATTR_VALUE, packageName);
                    out.endTag(null, TAG_PACKAGE_LIST_ITEM);
                }
                out.endTag(null, outerTag);
            }
        }

        void readFromXml(XmlPullParser parser) throws XmlPullParserException, IOException {
            int outerDepth = parser.getDepth();
            while (true) {
                int type = parser.next();
                if (type == DEF_MINIMUM_PASSWORD_SYMBOLS) {
                    return;
                }
                if (type == 3 && parser.getDepth() <= outerDepth) {
                    return;
                }
                if (!(type == 3 || type == 4)) {
                    String tag = parser.getName();
                    if (TAG_POLICIES.equals(tag)) {
                        this.info.readPoliciesFromXml(parser);
                    } else if (TAG_PASSWORD_QUALITY.equals(tag)) {
                        this.passwordQuality = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_MIN_PASSWORD_LENGTH.equals(tag)) {
                        this.minimumPasswordLength = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_PASSWORD_HISTORY_LENGTH.equals(tag)) {
                        this.passwordHistoryLength = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_MIN_PASSWORD_UPPERCASE.equals(tag)) {
                        this.minimumPasswordUpperCase = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_MIN_PASSWORD_LOWERCASE.equals(tag)) {
                        this.minimumPasswordLowerCase = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_MIN_PASSWORD_LETTERS.equals(tag)) {
                        this.minimumPasswordLetters = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_MIN_PASSWORD_NUMERIC.equals(tag)) {
                        this.minimumPasswordNumeric = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_MIN_PASSWORD_SYMBOLS.equals(tag)) {
                        this.minimumPasswordSymbols = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_MIN_PASSWORD_NONLETTER.equals(tag)) {
                        this.minimumPasswordNonLetter = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_MAX_TIME_TO_UNLOCK.equals(tag)) {
                        this.maximumTimeToUnlock = Long.parseLong(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_MAX_FAILED_PASSWORD_WIPE.equals(tag)) {
                        this.maximumFailedPasswordsForWipe = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_SPECIFIES_GLOBAL_PROXY.equals(tag)) {
                        this.specifiesGlobalProxy = Boolean.parseBoolean(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_GLOBAL_PROXY_SPEC.equals(tag)) {
                        this.globalProxySpec = parser.getAttributeValue(null, ATTR_VALUE);
                    } else if (TAG_GLOBAL_PROXY_EXCLUSION_LIST.equals(tag)) {
                        this.globalProxyExclusionList = parser.getAttributeValue(null, ATTR_VALUE);
                    } else if (TAG_PASSWORD_EXPIRATION_TIMEOUT.equals(tag)) {
                        this.passwordExpirationTimeout = Long.parseLong(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_PASSWORD_EXPIRATION_DATE.equals(tag)) {
                        this.passwordExpirationDate = Long.parseLong(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_ENCRYPTION_REQUESTED.equals(tag)) {
                        this.encryptionRequested = Boolean.parseBoolean(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_DISABLE_CAMERA.equals(tag)) {
                        this.disableCamera = Boolean.parseBoolean(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_DISABLE_CALLER_ID.equals(tag)) {
                        this.disableCallerId = Boolean.parseBoolean(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_DISABLE_SCREEN_CAPTURE.equals(tag)) {
                        this.disableScreenCapture = Boolean.parseBoolean(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_REQUIRE_AUTO_TIME.equals(tag)) {
                        this.requireAutoTime = Boolean.parseBoolean(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_DISABLE_KEYGUARD_FEATURES.equals(tag)) {
                        this.disabledKeyguardFeatures = Integer.parseInt(parser.getAttributeValue(null, ATTR_VALUE));
                    } else if (TAG_DISABLE_ACCOUNT_MANAGEMENT.equals(tag)) {
                        this.accountTypesWithManagementDisabled = readDisableAccountInfo(parser, tag);
                    } else if (TAG_MANAGE_TRUST_AGENT_FEATURES.equals(tag)) {
                        this.trustAgentInfos = getAllTrustAgentInfos(parser, tag);
                    } else if (TAG_CROSS_PROFILE_WIDGET_PROVIDERS.equals(tag)) {
                        this.crossProfileWidgetProviders = getCrossProfileWidgetProviders(parser, tag);
                    } else if (TAG_PERMITTED_ACCESSIBILITY_SERVICES.equals(tag)) {
                        this.permittedAccessiblityServices = readPackageList(parser, tag);
                    } else if (TAG_PERMITTED_IMES.equals(tag)) {
                        this.permittedInputMethods = readPackageList(parser, tag);
                    } else {
                        Slog.w(DevicePolicyManagerService.LOG_TAG, "Unknown admin tag: " + tag);
                    }
                    XmlUtils.skipCurrentTag(parser);
                }
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private java.util.List<java.lang.String> readPackageList(org.xmlpull.v1.XmlPullParser r10, java.lang.String r11) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
            /*
            r9 = this;
            r8 = 3;
            r4 = new java.util.ArrayList;
            r4.<init>();
            r0 = r10.getDepth();
        L_0x000a:
            r2 = r10.next();
            r5 = 1;
            if (r2 == r5) goto L_0x0073;
        L_0x0011:
            if (r2 != r8) goto L_0x0019;
        L_0x0013:
            r5 = r10.getDepth();
            if (r5 <= r0) goto L_0x0073;
        L_0x0019:
            if (r2 == r8) goto L_0x000a;
        L_0x001b:
            r5 = 4;
            if (r2 == r5) goto L_0x000a;
        L_0x001e:
            r1 = r10.getName();
            r5 = "item";
            r5 = r5.equals(r1);
            if (r5 == 0) goto L_0x0050;
        L_0x002a:
            r5 = 0;
            r6 = "value";
            r3 = r10.getAttributeValue(r5, r6);
            if (r3 == 0) goto L_0x0037;
        L_0x0033:
            r4.add(r3);
            goto L_0x000a;
        L_0x0037:
            r5 = "DevicePolicyManagerService";
            r6 = new java.lang.StringBuilder;
            r6.<init>();
            r7 = "Package name missing under ";
            r6 = r6.append(r7);
            r6 = r6.append(r1);
            r6 = r6.toString();
            android.util.Slog.w(r5, r6);
            goto L_0x000a;
        L_0x0050:
            r5 = "DevicePolicyManagerService";
            r6 = new java.lang.StringBuilder;
            r6.<init>();
            r7 = "Unknown tag under ";
            r6 = r6.append(r7);
            r6 = r6.append(r11);
            r7 = ": ";
            r6 = r6.append(r7);
            r6 = r6.append(r1);
            r6 = r6.toString();
            android.util.Slog.w(r5, r6);
            goto L_0x000a;
        L_0x0073:
            return r4;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.ActiveAdmin.readPackageList(org.xmlpull.v1.XmlPullParser, java.lang.String):java.util.List<java.lang.String>");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private java.util.Set<java.lang.String> readDisableAccountInfo(org.xmlpull.v1.XmlPullParser r9, java.lang.String r10) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
            /*
            r8 = this;
            r7 = 3;
            r0 = r9.getDepth();
            r1 = new java.util.HashSet;
            r1.<init>();
        L_0x000a:
            r3 = r9.next();
            r4 = 1;
            if (r3 == r4) goto L_0x0058;
        L_0x0011:
            if (r3 != r7) goto L_0x0019;
        L_0x0013:
            r4 = r9.getDepth();
            if (r4 <= r0) goto L_0x0058;
        L_0x0019:
            if (r3 == r7) goto L_0x000a;
        L_0x001b:
            r4 = 4;
            if (r3 == r4) goto L_0x000a;
        L_0x001e:
            r2 = r9.getName();
            r4 = "account-type";
            r4 = r4.equals(r2);
            if (r4 == 0) goto L_0x0035;
        L_0x002a:
            r4 = 0;
            r5 = "value";
            r4 = r9.getAttributeValue(r4, r5);
            r1.add(r4);
            goto L_0x000a;
        L_0x0035:
            r4 = "DevicePolicyManagerService";
            r5 = new java.lang.StringBuilder;
            r5.<init>();
            r6 = "Unknown tag under ";
            r5 = r5.append(r6);
            r5 = r5.append(r10);
            r6 = ": ";
            r5 = r5.append(r6);
            r5 = r5.append(r2);
            r5 = r5.toString();
            android.util.Slog.w(r4, r5);
            goto L_0x000a;
        L_0x0058:
            return r1;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.ActiveAdmin.readDisableAccountInfo(org.xmlpull.v1.XmlPullParser, java.lang.String):java.util.Set<java.lang.String>");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private java.util.HashMap<java.lang.String, com.android.server.devicepolicy.DevicePolicyManagerService.ActiveAdmin.TrustAgentInfo> getAllTrustAgentInfos(org.xmlpull.v1.XmlPullParser r11, java.lang.String r12) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
            /*
            r10 = this;
            r9 = 3;
            r1 = r11.getDepth();
            r2 = new java.util.HashMap;
            r2.<init>();
        L_0x000a:
            r5 = r11.next();
            r6 = 1;
            if (r5 == r6) goto L_0x005c;
        L_0x0011:
            if (r5 != r9) goto L_0x0019;
        L_0x0013:
            r6 = r11.getDepth();
            if (r6 <= r1) goto L_0x005c;
        L_0x0019:
            if (r5 == r9) goto L_0x000a;
        L_0x001b:
            r6 = 4;
            if (r5 == r6) goto L_0x000a;
        L_0x001e:
            r3 = r11.getName();
            r6 = "component";
            r6 = r6.equals(r3);
            if (r6 == 0) goto L_0x0039;
        L_0x002a:
            r6 = 0;
            r7 = "value";
            r0 = r11.getAttributeValue(r6, r7);
            r4 = r10.getTrustAgentInfo(r11, r12);
            r2.put(r0, r4);
            goto L_0x000a;
        L_0x0039:
            r6 = "DevicePolicyManagerService";
            r7 = new java.lang.StringBuilder;
            r7.<init>();
            r8 = "Unknown tag under ";
            r7 = r7.append(r8);
            r7 = r7.append(r12);
            r8 = ": ";
            r7 = r7.append(r8);
            r7 = r7.append(r3);
            r7 = r7.toString();
            android.util.Slog.w(r6, r7);
            goto L_0x000a;
        L_0x005c:
            return r2;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.ActiveAdmin.getAllTrustAgentInfos(org.xmlpull.v1.XmlPullParser, java.lang.String):java.util.HashMap<java.lang.String, com.android.server.devicepolicy.DevicePolicyManagerService$ActiveAdmin$TrustAgentInfo>");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private com.android.server.devicepolicy.DevicePolicyManagerService.ActiveAdmin.TrustAgentInfo getTrustAgentInfo(org.xmlpull.v1.XmlPullParser r10, java.lang.String r11) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
            /*
            r9 = this;
            r8 = 3;
            r1 = r10.getDepth();
            r2 = new com.android.server.devicepolicy.DevicePolicyManagerService$ActiveAdmin$TrustAgentInfo;
            r5 = 0;
            r2.<init>(r5);
        L_0x000b:
            r4 = r10.next();
            r5 = 1;
            if (r4 == r5) goto L_0x0059;
        L_0x0012:
            if (r4 != r8) goto L_0x001a;
        L_0x0014:
            r5 = r10.getDepth();
            if (r5 <= r1) goto L_0x0059;
        L_0x001a:
            if (r4 == r8) goto L_0x000b;
        L_0x001c:
            r5 = 4;
            if (r4 == r5) goto L_0x000b;
        L_0x001f:
            r3 = r10.getName();
            r5 = "trust-agent-component-options";
            r5 = r5.equals(r3);
            if (r5 == 0) goto L_0x0036;
        L_0x002b:
            r0 = new android.os.PersistableBundle;
            r0.<init>();
            android.os.PersistableBundle.restoreFromXml(r10);
            r2.options = r0;
            goto L_0x000b;
        L_0x0036:
            r5 = "DevicePolicyManagerService";
            r6 = new java.lang.StringBuilder;
            r6.<init>();
            r7 = "Unknown tag under ";
            r6 = r6.append(r7);
            r6 = r6.append(r11);
            r7 = ": ";
            r6 = r6.append(r7);
            r6 = r6.append(r3);
            r6 = r6.toString();
            android.util.Slog.w(r5, r6);
            goto L_0x000b;
        L_0x0059:
            return r2;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.ActiveAdmin.getTrustAgentInfo(org.xmlpull.v1.XmlPullParser, java.lang.String):com.android.server.devicepolicy.DevicePolicyManagerService$ActiveAdmin$TrustAgentInfo");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private java.util.List<java.lang.String> getCrossProfileWidgetProviders(org.xmlpull.v1.XmlPullParser r10, java.lang.String r11) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
            /*
            r9 = this;
            r8 = 3;
            r0 = r10.getDepth();
            r2 = 0;
        L_0x0006:
            r4 = r10.next();
            r5 = 1;
            if (r4 == r5) goto L_0x005b;
        L_0x000d:
            if (r4 != r8) goto L_0x0015;
        L_0x000f:
            r5 = r10.getDepth();
            if (r5 <= r0) goto L_0x005b;
        L_0x0015:
            if (r4 == r8) goto L_0x0006;
        L_0x0017:
            r5 = 4;
            if (r4 == r5) goto L_0x0006;
        L_0x001a:
            r3 = r10.getName();
            r5 = "provider";
            r5 = r5.equals(r3);
            if (r5 == 0) goto L_0x0038;
        L_0x0026:
            r5 = 0;
            r6 = "value";
            r1 = r10.getAttributeValue(r5, r6);
            if (r2 != 0) goto L_0x0034;
        L_0x002f:
            r2 = new java.util.ArrayList;
            r2.<init>();
        L_0x0034:
            r2.add(r1);
            goto L_0x0006;
        L_0x0038:
            r5 = "DevicePolicyManagerService";
            r6 = new java.lang.StringBuilder;
            r6.<init>();
            r7 = "Unknown tag under ";
            r6 = r6.append(r7);
            r6 = r6.append(r11);
            r7 = ": ";
            r6 = r6.append(r7);
            r6 = r6.append(r3);
            r6 = r6.toString();
            android.util.Slog.w(r5, r6);
            goto L_0x0006;
        L_0x005b:
            return r2;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.ActiveAdmin.getCrossProfileWidgetProviders(org.xmlpull.v1.XmlPullParser, java.lang.String):java.util.List<java.lang.String>");
        }

        void dump(String prefix, PrintWriter pw) {
            pw.print(prefix);
            pw.print("uid=");
            pw.println(getUid());
            pw.print(prefix);
            pw.println("policies:");
            ArrayList<PolicyInfo> pols = this.info.getUsedPolicies();
            if (pols != null) {
                for (int i = DEF_PASSWORD_HISTORY_LENGTH; i < pols.size(); i += DEF_MINIMUM_PASSWORD_SYMBOLS) {
                    pw.print(prefix);
                    pw.print("  ");
                    pw.println(((PolicyInfo) pols.get(i)).tag);
                }
            }
            pw.print(prefix);
            pw.print("passwordQuality=0x");
            pw.println(Integer.toHexString(this.passwordQuality));
            pw.print(prefix);
            pw.print("minimumPasswordLength=");
            pw.println(this.minimumPasswordLength);
            pw.print(prefix);
            pw.print("passwordHistoryLength=");
            pw.println(this.passwordHistoryLength);
            pw.print(prefix);
            pw.print("minimumPasswordUpperCase=");
            pw.println(this.minimumPasswordUpperCase);
            pw.print(prefix);
            pw.print("minimumPasswordLowerCase=");
            pw.println(this.minimumPasswordLowerCase);
            pw.print(prefix);
            pw.print("minimumPasswordLetters=");
            pw.println(this.minimumPasswordLetters);
            pw.print(prefix);
            pw.print("minimumPasswordNumeric=");
            pw.println(this.minimumPasswordNumeric);
            pw.print(prefix);
            pw.print("minimumPasswordSymbols=");
            pw.println(this.minimumPasswordSymbols);
            pw.print(prefix);
            pw.print("minimumPasswordNonLetter=");
            pw.println(this.minimumPasswordNonLetter);
            pw.print(prefix);
            pw.print("maximumTimeToUnlock=");
            pw.println(this.maximumTimeToUnlock);
            pw.print(prefix);
            pw.print("maximumFailedPasswordsForWipe=");
            pw.println(this.maximumFailedPasswordsForWipe);
            pw.print(prefix);
            pw.print("specifiesGlobalProxy=");
            pw.println(this.specifiesGlobalProxy);
            pw.print(prefix);
            pw.print("passwordExpirationTimeout=");
            pw.println(this.passwordExpirationTimeout);
            pw.print(prefix);
            pw.print("passwordExpirationDate=");
            pw.println(this.passwordExpirationDate);
            if (this.globalProxySpec != null) {
                pw.print(prefix);
                pw.print("globalProxySpec=");
                pw.println(this.globalProxySpec);
            }
            if (this.globalProxyExclusionList != null) {
                pw.print(prefix);
                pw.print("globalProxyEclusionList=");
                pw.println(this.globalProxyExclusionList);
            }
            pw.print(prefix);
            pw.print("encryptionRequested=");
            pw.println(this.encryptionRequested);
            pw.print(prefix);
            pw.print("disableCamera=");
            pw.println(this.disableCamera);
            pw.print(prefix);
            pw.print("disableCallerId=");
            pw.println(this.disableCallerId);
            pw.print(prefix);
            pw.print("disableScreenCapture=");
            pw.println(this.disableScreenCapture);
            pw.print(prefix);
            pw.print("requireAutoTime=");
            pw.println(this.requireAutoTime);
            pw.print(prefix);
            pw.print("disabledKeyguardFeatures=");
            pw.println(this.disabledKeyguardFeatures);
            pw.print(prefix);
            pw.print("crossProfileWidgetProviders=");
            pw.println(this.crossProfileWidgetProviders);
            if (this.permittedAccessiblityServices != null) {
                pw.print(prefix);
                pw.print("permittedAccessibilityServices=");
                pw.println(this.permittedAccessiblityServices.toString());
            }
            if (this.permittedInputMethods != null) {
                pw.print(prefix);
                pw.print("permittedInputMethods=");
                pw.println(this.permittedInputMethods.toString());
            }
        }
    }

    public static class DevicePolicyData {
        int mActivePasswordLength;
        int mActivePasswordLetters;
        int mActivePasswordLowerCase;
        int mActivePasswordNonLetter;
        int mActivePasswordNumeric;
        int mActivePasswordQuality;
        int mActivePasswordSymbols;
        int mActivePasswordUpperCase;
        final ArrayList<ActiveAdmin> mAdminList;
        final HashMap<ComponentName, ActiveAdmin> mAdminMap;
        int mFailedPasswordAttempts;
        long mLastMaximumTimeToLock;
        final List<String> mLockTaskPackages;
        int mPasswordOwner;
        final ArrayList<ComponentName> mRemovingAdmins;
        ComponentName mRestrictionsProvider;
        int mUserHandle;
        boolean mUserSetupComplete;

        public DevicePolicyData(int userHandle) {
            this.mActivePasswordQuality = 0;
            this.mActivePasswordLength = 0;
            this.mActivePasswordUpperCase = 0;
            this.mActivePasswordLowerCase = 0;
            this.mActivePasswordLetters = 0;
            this.mActivePasswordNumeric = 0;
            this.mActivePasswordSymbols = 0;
            this.mActivePasswordNonLetter = 0;
            this.mFailedPasswordAttempts = 0;
            this.mPasswordOwner = -1;
            this.mLastMaximumTimeToLock = -1;
            this.mUserSetupComplete = DevicePolicyManagerService.DBG;
            this.mAdminMap = new HashMap();
            this.mAdminList = new ArrayList();
            this.mRemovingAdmins = new ArrayList();
            this.mLockTaskPackages = new ArrayList();
            this.mUserHandle = userHandle;
        }
    }

    public static final class Lifecycle extends SystemService {
        private DevicePolicyManagerService mService;

        public Lifecycle(Context context) {
            super(context);
            this.mService = new DevicePolicyManagerService(context);
        }

        public void onStart() {
            publishBinderService("device_policy", this.mService);
        }

        public void onBootPhase(int phase) {
            if (phase == SystemService.PHASE_LOCK_SETTINGS_READY) {
                this.mService.systemReady();
            }
        }
    }

    private final class LocalService extends DevicePolicyManagerInternal {
        private List<OnCrossProfileWidgetProvidersChangeListener> mWidgetProviderListeners;

        private LocalService() {
        }

        public List<String> getCrossProfileWidgetProviders(int profileId) {
            List<String> emptyList;
            synchronized (DevicePolicyManagerService.this) {
                if (DevicePolicyManagerService.this.mDeviceOwner == null) {
                    emptyList = Collections.emptyList();
                } else {
                    ComponentName ownerComponent = DevicePolicyManagerService.this.mDeviceOwner.getProfileOwnerComponent(profileId);
                    if (ownerComponent == null) {
                        emptyList = Collections.emptyList();
                    } else {
                        ActiveAdmin admin = (ActiveAdmin) DevicePolicyManagerService.this.getUserDataUnchecked(profileId).mAdminMap.get(ownerComponent);
                        if (admin == null || admin.crossProfileWidgetProviders == null || admin.crossProfileWidgetProviders.isEmpty()) {
                            emptyList = Collections.emptyList();
                        } else {
                            emptyList = admin.crossProfileWidgetProviders;
                        }
                    }
                }
            }
            return emptyList;
        }

        public void addOnCrossProfileWidgetProvidersChangeListener(OnCrossProfileWidgetProvidersChangeListener listener) {
            synchronized (DevicePolicyManagerService.this) {
                if (this.mWidgetProviderListeners == null) {
                    this.mWidgetProviderListeners = new ArrayList();
                }
                if (!this.mWidgetProviderListeners.contains(listener)) {
                    this.mWidgetProviderListeners.add(listener);
                }
            }
        }

        private void notifyCrossProfileProvidersChanged(int userId, List<String> packages) {
            List<OnCrossProfileWidgetProvidersChangeListener> listeners;
            synchronized (DevicePolicyManagerService.this) {
                listeners = new ArrayList(this.mWidgetProviderListeners);
            }
            int listenerCount = listeners.size();
            for (int i = 0; i < listenerCount; i++) {
                ((OnCrossProfileWidgetProvidersChangeListener) listeners.get(i)).onCrossProfileWidgetProvidersChanged(userId, packages);
            }
        }
    }

    private class MonitoringCertNotificationTask extends AsyncTask<Intent, Void, Void> {
        private MonitoringCertNotificationTask() {
        }

        protected Void doInBackground(Intent... params) {
            int userHandle = params[0].getIntExtra("android.intent.extra.user_handle", -1);
            if (userHandle == -1) {
                for (UserInfo userInfo : DevicePolicyManagerService.this.mUserManager.getUsers()) {
                    manageNotification(userInfo.getUserHandle());
                }
            } else {
                manageNotification(new UserHandle(userHandle));
            }
            return null;
        }

        private void manageNotification(UserHandle userHandle) {
            Intent dialogIntent;
            if (DevicePolicyManagerService.this.mUserManager.isUserRunning(userHandle)) {
                String ownerName;
                String contentText;
                int smallIconId;
                boolean hasCert = DevicePolicyManagerService.DBG;
                try {
                    KeyChainConnection kcs = KeyChain.bindAsUser(DevicePolicyManagerService.this.mContext, userHandle);
                    try {
                        if (!kcs.getService().getUserCaAliases().getList().isEmpty()) {
                            hasCert = true;
                        }
                    } catch (RemoteException e) {
                        Log.e(DevicePolicyManagerService.LOG_TAG, "Could not connect to KeyChain service", e);
                        if (hasCert) {
                            ownerName = DevicePolicyManagerService.this.getDeviceOwnerName();
                            if (DevicePolicyManagerService.this.isManagedProfile(userHandle.getIdentifier())) {
                                contentText = DevicePolicyManagerService.this.mContext.getString(17039599);
                                smallIconId = 17303152;
                            } else if (ownerName == null) {
                                contentText = DevicePolicyManagerService.this.mContext.getString(17039598);
                                smallIconId = 17301642;
                            } else {
                                contentText = DevicePolicyManagerService.this.mContext.getString(17039600, new Object[]{ownerName});
                                smallIconId = 17303152;
                            }
                            dialogIntent = new Intent("com.android.settings.MONITORING_CERT_INFO");
                            dialogIntent.setFlags(268468224);
                            dialogIntent.setPackage("com.android.settings");
                            try {
                                DevicePolicyManagerService.this.getNotificationManager().notifyAsUser(null, DevicePolicyManagerService.MONITORING_CERT_NOTIFICATION_ID, new Builder(DevicePolicyManagerService.this.mContext.createPackageContextAsUser("android", 0, userHandle)).setSmallIcon(smallIconId).setContentTitle(DevicePolicyManagerService.this.mContext.getString(DevicePolicyManagerService.MONITORING_CERT_NOTIFICATION_ID)).setContentText(contentText).setContentIntent(PendingIntent.getActivityAsUser(DevicePolicyManagerService.this.mContext, 0, dialogIntent, 134217728, null, userHandle)).setPriority(1).setShowWhen(DevicePolicyManagerService.DBG).setColor(DevicePolicyManagerService.this.mContext.getResources().getColor(17170521)).build(), userHandle);
                            } catch (NameNotFoundException e2) {
                                Log.e(DevicePolicyManagerService.LOG_TAG, "Create context as " + userHandle + " failed", e2);
                                return;
                            }
                        }
                        DevicePolicyManagerService.this.getNotificationManager().cancelAsUser(null, DevicePolicyManagerService.MONITORING_CERT_NOTIFICATION_ID, userHandle);
                        return;
                    } finally {
                        kcs.close();
                    }
                } catch (InterruptedException e3) {
                    Thread.currentThread().interrupt();
                } catch (RuntimeException e4) {
                    Log.e(DevicePolicyManagerService.LOG_TAG, "Could not connect to KeyChain service", e4);
                }
                if (hasCert) {
                    DevicePolicyManagerService.this.getNotificationManager().cancelAsUser(null, DevicePolicyManagerService.MONITORING_CERT_NOTIFICATION_ID, userHandle);
                    return;
                }
                ownerName = DevicePolicyManagerService.this.getDeviceOwnerName();
                if (DevicePolicyManagerService.this.isManagedProfile(userHandle.getIdentifier())) {
                    contentText = DevicePolicyManagerService.this.mContext.getString(17039599);
                    smallIconId = 17303152;
                } else if (ownerName == null) {
                    contentText = DevicePolicyManagerService.this.mContext.getString(17039600, new Object[]{ownerName});
                    smallIconId = 17303152;
                } else {
                    contentText = DevicePolicyManagerService.this.mContext.getString(17039598);
                    smallIconId = 17301642;
                }
                dialogIntent = new Intent("com.android.settings.MONITORING_CERT_INFO");
                dialogIntent.setFlags(268468224);
                dialogIntent.setPackage("com.android.settings");
                DevicePolicyManagerService.this.getNotificationManager().notifyAsUser(null, DevicePolicyManagerService.MONITORING_CERT_NOTIFICATION_ID, new Builder(DevicePolicyManagerService.this.mContext.createPackageContextAsUser("android", 0, userHandle)).setSmallIcon(smallIconId).setContentTitle(DevicePolicyManagerService.this.mContext.getString(DevicePolicyManagerService.MONITORING_CERT_NOTIFICATION_ID)).setContentText(contentText).setContentIntent(PendingIntent.getActivityAsUser(DevicePolicyManagerService.this.mContext, 0, dialogIntent, 134217728, null, userHandle)).setPriority(1).setShowWhen(DevicePolicyManagerService.DBG).setColor(DevicePolicyManagerService.this.mContext.getResources().getColor(17170521)).build(), userHandle);
            }
        }
    }

    private class SetupContentObserver extends ContentObserver {
        private final Uri mUserSetupComplete;

        public SetupContentObserver(Handler handler) {
            super(handler);
            this.mUserSetupComplete = Secure.getUriFor("user_setup_complete");
        }

        void register(ContentResolver resolver) {
            resolver.registerContentObserver(this.mUserSetupComplete, DevicePolicyManagerService.DBG, this, -1);
        }

        public void onChange(boolean selfChange, Uri uri) {
            if (this.mUserSetupComplete.equals(uri)) {
                DevicePolicyManagerService.this.updateUserSetupComplete();
            }
        }
    }

    public boolean installKeyPair(android.content.ComponentName r9, byte[] r10, byte[] r11, java.lang.String r12) {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxRuntimeException: Can't find immediate dominator for block B:33:0x0032 in {2, 21, 24, 26, 30, 32, 34, 35, 36, 37, 38} preds:[]
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeDominators(BlockProcessor.java:129)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.processBlocksTree(BlockProcessor.java:48)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.rerun(BlockProcessor.java:44)
	at jadx.core.dex.visitors.blocksmaker.BlockFinallyExtract.visit(BlockFinallyExtract.java:57)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
        /*
        r8 = this;
        if (r9 != 0) goto L_0x000a;
    L_0x0002:
        r6 = new java.lang.NullPointerException;
        r7 = "ComponentName is null";
        r6.<init>(r7);
        throw r6;
    L_0x000a:
        monitor-enter(r8);
        r6 = -1;
        r8.getActiveAdminForCallerLocked(r9, r6);
        monitor-exit(r8);
        r5 = new android.os.UserHandle;
        r6 = android.os.UserHandle.getCallingUserId();
        r5.<init>(r6);
        r2 = android.os.Binder.clearCallingIdentity();
        r6 = r8.mContext;	 Catch:{ InterruptedException -> 0x004a }
        r4 = android.security.KeyChain.bindAsUser(r6, r5);	 Catch:{ InterruptedException -> 0x004a }
        r1 = r4.getService();	 Catch:{ RemoteException -> 0x0035, all -> 0x0045 }
        r6 = r1.installKeyPair(r10, r11, r12);	 Catch:{ RemoteException -> 0x0035, all -> 0x0045 }
        r4.close();
        android.os.Binder.restoreCallingIdentity(r2);
    L_0x0031:
        return r6;
    L_0x0032:
        r6 = move-exception;
        monitor-exit(r8);
        throw r6;
    L_0x0035:
        r0 = move-exception;
        r6 = "DevicePolicyManagerService";	 Catch:{ RemoteException -> 0x0035, all -> 0x0045 }
        r7 = "Installing certificate";	 Catch:{ RemoteException -> 0x0035, all -> 0x0045 }
        android.util.Log.e(r6, r7, r0);	 Catch:{ RemoteException -> 0x0035, all -> 0x0045 }
        r4.close();
        android.os.Binder.restoreCallingIdentity(r2);
    L_0x0043:
        r6 = 0;
        goto L_0x0031;
    L_0x0045:
        r6 = move-exception;
        r4.close();	 Catch:{ InterruptedException -> 0x004a }
        throw r6;	 Catch:{ InterruptedException -> 0x004a }
    L_0x004a:
        r0 = move-exception;
        r6 = "DevicePolicyManagerService";	 Catch:{ all -> 0x005d }
        r7 = "Interrupted while installing certificate";	 Catch:{ all -> 0x005d }
        android.util.Log.w(r6, r7, r0);	 Catch:{ all -> 0x005d }
        r6 = java.lang.Thread.currentThread();	 Catch:{ all -> 0x005d }
        r6.interrupt();	 Catch:{ all -> 0x005d }
        android.os.Binder.restoreCallingIdentity(r2);
        goto L_0x0043;
    L_0x005d:
        r6 = move-exception;
        android.os.Binder.restoreCallingIdentity(r2);
        throw r6;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.installKeyPair(android.content.ComponentName, byte[], byte[], java.lang.String):boolean");
    }

    static {
        DEVICE_OWNER_USER_RESTRICTIONS = new HashSet();
        DEVICE_OWNER_USER_RESTRICTIONS.add("no_usb_file_transfer");
        DEVICE_OWNER_USER_RESTRICTIONS.add("no_config_tethering");
        DEVICE_OWNER_USER_RESTRICTIONS.add("no_factory_reset");
        DEVICE_OWNER_USER_RESTRICTIONS.add("no_add_user");
        DEVICE_OWNER_USER_RESTRICTIONS.add("no_config_cell_broadcasts");
        DEVICE_OWNER_USER_RESTRICTIONS.add("no_config_mobile_networks");
        DEVICE_OWNER_USER_RESTRICTIONS.add("no_physical_media");
        DEVICE_OWNER_USER_RESTRICTIONS.add("no_unmute_microphone");
        DEVICE_OWNER_USER_RESTRICTIONS.add("no_adjust_volume");
        DEVICE_OWNER_USER_RESTRICTIONS.add("no_sms");
        SECURE_SETTINGS_WHITELIST = new HashSet();
        SECURE_SETTINGS_WHITELIST.add("default_input_method");
        SECURE_SETTINGS_WHITELIST.add("skip_first_use_hints");
        SECURE_SETTINGS_WHITELIST.add("install_non_market_apps");
        SECURE_SETTINGS_DEVICEOWNER_WHITELIST = new HashSet();
        SECURE_SETTINGS_DEVICEOWNER_WHITELIST.addAll(SECURE_SETTINGS_WHITELIST);
        SECURE_SETTINGS_DEVICEOWNER_WHITELIST.add("location_mode");
        GLOBAL_SETTINGS_WHITELIST = new HashSet();
        GLOBAL_SETTINGS_WHITELIST.add("adb_enabled");
        GLOBAL_SETTINGS_WHITELIST.add("auto_time");
        GLOBAL_SETTINGS_WHITELIST.add("auto_time_zone");
        GLOBAL_SETTINGS_WHITELIST.add("bluetooth_on");
        GLOBAL_SETTINGS_WHITELIST.add("data_roaming");
        GLOBAL_SETTINGS_WHITELIST.add("development_settings_enabled");
        GLOBAL_SETTINGS_WHITELIST.add("mode_ringer");
        GLOBAL_SETTINGS_WHITELIST.add("network_preference");
        GLOBAL_SETTINGS_WHITELIST.add("usb_mass_storage_enabled");
        GLOBAL_SETTINGS_WHITELIST.add("wifi_on");
        GLOBAL_SETTINGS_WHITELIST.add("wifi_sleep_policy");
    }

    private void handlePackagesChanged(String packageName, int userHandle) {
        boolean removed = DBG;
        DevicePolicyData policy = getUserData(userHandle);
        IPackageManager pm = AppGlobals.getPackageManager();
        synchronized (this) {
            for (int i = policy.mAdminList.size() - 1; i >= 0; i--) {
                ActiveAdmin aa = (ActiveAdmin) policy.mAdminList.get(i);
                try {
                    String adminPackage = aa.info.getPackageName();
                    if ((packageName == null || packageName.equals(adminPackage)) && (pm.getPackageInfo(adminPackage, 0, userHandle) == null || pm.getReceiverInfo(aa.info.getComponent(), 0, userHandle) == null)) {
                        removed = true;
                        policy.mAdminList.remove(i);
                        policy.mAdminMap.remove(aa.info.getComponent());
                    }
                } catch (RemoteException e) {
                }
            }
            if (removed) {
                validatePasswordOwnerLocked(policy);
                syncDeviceCapabilitiesLocked(policy);
                saveSettingsLocked(policy.mUserHandle);
            }
        }
    }

    public DevicePolicyManagerService(Context context) {
        this.mUserData = new SparseArray();
        this.mHandler = new Handler();
        this.mReceiver = new C01871();
        this.mContext = context;
        this.mUserManager = UserManager.get(this.mContext);
        this.mHasFeature = context.getPackageManager().hasSystemFeature("android.software.device_admin");
        this.mPowerManager = (PowerManager) context.getSystemService("power");
        this.mPowerManagerInternal = (PowerManagerInternal) LocalServices.getService(PowerManagerInternal.class);
        this.mWakeLock = this.mPowerManager.newWakeLock(1, "DPM");
        this.mLocalService = new LocalService();
        if (this.mHasFeature) {
            IntentFilter filter = new IntentFilter();
            filter.addAction("android.intent.action.BOOT_COMPLETED");
            filter.addAction(ACTION_EXPIRED_PASSWORD_NOTIFICATION);
            filter.addAction("android.intent.action.USER_REMOVED");
            filter.addAction("android.intent.action.USER_STARTED");
            filter.addAction("android.security.STORAGE_CHANGED");
            filter.setPriority(ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
            context.registerReceiverAsUser(this.mReceiver, UserHandle.ALL, filter, null, this.mHandler);
            filter = new IntentFilter();
            filter.addAction("android.intent.action.PACKAGE_CHANGED");
            filter.addAction("android.intent.action.PACKAGE_REMOVED");
            filter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE");
            filter.addAction("android.intent.action.PACKAGE_ADDED");
            filter.addDataScheme("package");
            context.registerReceiverAsUser(this.mReceiver, UserHandle.ALL, filter, null, this.mHandler);
            LocalServices.addService(DevicePolicyManagerInternal.class, this.mLocalService);
        }
    }

    DevicePolicyData getUserData(int userHandle) {
        DevicePolicyData policy;
        synchronized (this) {
            policy = (DevicePolicyData) this.mUserData.get(userHandle);
            if (policy == null) {
                policy = new DevicePolicyData(userHandle);
                this.mUserData.append(userHandle, policy);
                loadSettingsLocked(policy, userHandle);
            }
        }
        return policy;
    }

    DevicePolicyData getUserDataUnchecked(int userHandle) {
        long ident = Binder.clearCallingIdentity();
        try {
            DevicePolicyData userData = getUserData(userHandle);
            return userData;
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    void removeUserData(int userHandle) {
        synchronized (this) {
            if (userHandle == 0) {
                Slog.w(LOG_TAG, "Tried to remove device policy file for user 0! Ignoring.");
                return;
            }
            if (this.mDeviceOwner != null) {
                this.mDeviceOwner.removeProfileOwner(userHandle);
                this.mDeviceOwner.writeOwnerFile();
            }
            if (((DevicePolicyData) this.mUserData.get(userHandle)) != null) {
                this.mUserData.remove(userHandle);
            }
            File policyFile = new File(Environment.getUserSystemDirectory(userHandle), DEVICE_POLICIES_XML);
            policyFile.delete();
            Slog.i(LOG_TAG, "Removed device policy file " + policyFile.getAbsolutePath());
            updateScreenCaptureDisabledInWindowManager(userHandle, DBG);
        }
    }

    void loadDeviceOwner() {
        synchronized (this) {
            this.mDeviceOwner = DeviceOwner.load();
        }
    }

    protected void setExpirationAlarmCheckLocked(Context context, DevicePolicyData policy) {
        long alarmTime;
        long expiration = getPasswordExpirationLocked(null, policy.mUserHandle);
        long now = System.currentTimeMillis();
        long timeToExpire = expiration - now;
        if (expiration == 0) {
            alarmTime = 0;
        } else if (timeToExpire <= 0) {
            alarmTime = now + MS_PER_DAY;
        } else {
            long alarmInterval = timeToExpire % MS_PER_DAY;
            if (alarmInterval == 0) {
                alarmInterval = MS_PER_DAY;
            }
            alarmTime = now + alarmInterval;
        }
        long token = Binder.clearCallingIdentity();
        try {
            AlarmManager am = (AlarmManager) context.getSystemService("alarm");
            PendingIntent pi = PendingIntent.getBroadcastAsUser(context, REQUEST_EXPIRE_PASSWORD, new Intent(ACTION_EXPIRED_PASSWORD_NOTIFICATION), 1207959552, new UserHandle(policy.mUserHandle));
            am.cancel(pi);
            if (alarmTime != 0) {
                am.set(1, alarmTime, pi);
            }
            Binder.restoreCallingIdentity(token);
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(token);
        }
    }

    private IWindowManager getWindowManager() {
        if (this.mIWindowManager == null) {
            this.mIWindowManager = IWindowManager.Stub.asInterface(ServiceManager.getService("window"));
        }
        return this.mIWindowManager;
    }

    private NotificationManager getNotificationManager() {
        if (this.mNotificationManager == null) {
            this.mNotificationManager = (NotificationManager) this.mContext.getSystemService("notification");
        }
        return this.mNotificationManager;
    }

    ActiveAdmin getActiveAdminUncheckedLocked(ComponentName who, int userHandle) {
        ActiveAdmin admin = (ActiveAdmin) getUserData(userHandle).mAdminMap.get(who);
        return (admin != null && who.getPackageName().equals(admin.info.getActivityInfo().packageName) && who.getClassName().equals(admin.info.getActivityInfo().name)) ? admin : null;
    }

    ActiveAdmin getActiveAdminForCallerLocked(ComponentName who, int reqPolicy) throws SecurityException {
        ActiveAdmin admin;
        Iterator i$;
        int callingUid = Binder.getCallingUid();
        int userHandle = UserHandle.getUserId(callingUid);
        DevicePolicyData policy = getUserData(userHandle);
        List<ActiveAdmin> candidates = new ArrayList();
        if (who != null) {
            admin = (ActiveAdmin) policy.mAdminMap.get(who);
            if (admin == null) {
                throw new SecurityException("No active admin " + who);
            } else if (admin.getUid() != callingUid) {
                throw new SecurityException("Admin " + who + " is not owned by uid " + Binder.getCallingUid());
            } else {
                candidates.add(admin);
            }
        } else {
            i$ = policy.mAdminList.iterator();
            while (i$.hasNext()) {
                admin = (ActiveAdmin) i$.next();
                if (admin.getUid() == callingUid) {
                    candidates.add(admin);
                }
            }
        }
        for (ActiveAdmin admin2 : candidates) {
            boolean ownsProfile;
            boolean ownsDevice = isDeviceOwner(admin2.info.getPackageName());
            if (getProfileOwner(userHandle) == null || !getProfileOwner(userHandle).getPackageName().equals(admin2.info.getPackageName())) {
                ownsProfile = DBG;
            } else {
                ownsProfile = true;
            }
            if (reqPolicy == -2) {
                if (ownsDevice) {
                }
            } else if (reqPolicy == -1) {
                if (!ownsDevice) {
                    if (ownsProfile) {
                    }
                }
            } else if (admin2.info.usesPolicy(reqPolicy)) {
            }
            return admin2;
        }
        if (who == null) {
            throw new SecurityException("No active admin owned by uid " + Binder.getCallingUid() + " for policy #" + reqPolicy);
        } else if (reqPolicy == -2) {
            throw new SecurityException("Admin " + ((ActiveAdmin) candidates.get(0)).info.getComponent() + " does not own the device");
        } else if (reqPolicy == -1) {
            throw new SecurityException("Admin " + ((ActiveAdmin) candidates.get(0)).info.getComponent() + " does not own the profile");
        } else {
            throw new SecurityException("Admin " + ((ActiveAdmin) candidates.get(0)).info.getComponent() + " did not specify uses-policy for: " + ((ActiveAdmin) candidates.get(0)).info.getTagForPolicy(reqPolicy));
        }
    }

    void sendAdminCommandLocked(ActiveAdmin admin, String action) {
        sendAdminCommandLocked(admin, action, null);
    }

    void sendAdminCommandLocked(ActiveAdmin admin, String action, BroadcastReceiver result) {
        sendAdminCommandLocked(admin, action, null, result);
    }

    void sendAdminCommandLocked(ActiveAdmin admin, String action, Bundle adminExtras, BroadcastReceiver result) {
        Intent intent = new Intent(action);
        intent.setComponent(admin.info.getComponent());
        if (action.equals("android.app.action.ACTION_PASSWORD_EXPIRING")) {
            intent.putExtra("expiration", admin.passwordExpirationDate);
        }
        if (adminExtras != null) {
            intent.putExtras(adminExtras);
        }
        if (result != null) {
            this.mContext.sendOrderedBroadcastAsUser(intent, admin.getUserHandle(), null, result, this.mHandler, -1, null, null);
            return;
        }
        this.mContext.sendBroadcastAsUser(intent, admin.getUserHandle());
    }

    void sendAdminCommandLocked(String action, int reqPolicy, int userHandle) {
        DevicePolicyData policy = getUserData(userHandle);
        int count = policy.mAdminList.size();
        if (count > 0) {
            for (int i = 0; i < count; i++) {
                ActiveAdmin admin = (ActiveAdmin) policy.mAdminList.get(i);
                if (admin.info.usesPolicy(reqPolicy)) {
                    sendAdminCommandLocked(admin, action);
                }
            }
        }
    }

    private void sendAdminCommandToSelfAndProfilesLocked(String action, int reqPolicy, int userHandle) {
        for (UserInfo ui : this.mUserManager.getProfiles(userHandle)) {
            sendAdminCommandLocked(action, reqPolicy, ui.id);
        }
    }

    void removeActiveAdminLocked(ComponentName adminReceiver, int userHandle) {
        ActiveAdmin admin = getActiveAdminUncheckedLocked(adminReceiver, userHandle);
        if (admin != null) {
            synchronized (this) {
                getUserData(userHandle).mRemovingAdmins.add(adminReceiver);
            }
            sendAdminCommandLocked(admin, "android.app.action.DEVICE_ADMIN_DISABLED", new C01882(admin, adminReceiver));
        }
    }

    public DeviceAdminInfo findAdmin(ComponentName adminName, int userHandle) {
        if (!this.mHasFeature) {
            return null;
        }
        enforceCrossUserPermission(userHandle);
        Intent resolveIntent = new Intent();
        resolveIntent.setComponent(adminName);
        List<ResolveInfo> infos = this.mContext.getPackageManager().queryBroadcastReceivers(resolveIntent, 32896, userHandle);
        if (infos == null || infos.size() <= 0) {
            throw new IllegalArgumentException("Unknown admin: " + adminName);
        }
        try {
            return new DeviceAdminInfo(this.mContext, (ResolveInfo) infos.get(0));
        } catch (XmlPullParserException e) {
            Slog.w(LOG_TAG, "Bad device admin requested for user=" + userHandle + ": " + adminName, e);
            return null;
        } catch (IOException e2) {
            Slog.w(LOG_TAG, "Bad device admin requested for user=" + userHandle + ": " + adminName, e2);
            return null;
        }
    }

    private static JournaledFile makeJournaledFile(int userHandle) {
        String base = userHandle == 0 ? "/data/system/device_policies.xml" : new File(Environment.getUserSystemDirectory(userHandle), DEVICE_POLICIES_XML).getAbsolutePath();
        return new JournaledFile(new File(base), new File(base + ".tmp"));
    }

    private void saveSettingsLocked(int userHandle) {
        DevicePolicyData policy = getUserData(userHandle);
        JournaledFile journal = makeJournaledFile(userHandle);
        FileOutputStream stream = null;
        try {
            FileOutputStream stream2 = new FileOutputStream(journal.chooseForWrite(), DBG);
            try {
                int i;
                XmlSerializer out = new FastXmlSerializer();
                out.setOutput(stream2, StandardCharsets.UTF_8.name());
                out.startDocument(null, Boolean.valueOf(true));
                out.startTag(null, "policies");
                if (policy.mRestrictionsProvider != null) {
                    out.attribute(null, ATTR_PERMISSION_PROVIDER, policy.mRestrictionsProvider.flattenToString());
                }
                if (policy.mUserSetupComplete) {
                    out.attribute(null, ATTR_SETUP_COMPLETE, Boolean.toString(true));
                }
                int N = policy.mAdminList.size();
                for (i = 0; i < N; i++) {
                    ActiveAdmin ap = (ActiveAdmin) policy.mAdminList.get(i);
                    if (ap != null) {
                        out.startTag(null, "admin");
                        out.attribute(null, "name", ap.info.getComponent().flattenToString());
                        ap.writeToXml(out);
                        out.endTag(null, "admin");
                    }
                }
                if (policy.mPasswordOwner >= 0) {
                    out.startTag(null, "password-owner");
                    out.attribute(null, "value", Integer.toString(policy.mPasswordOwner));
                    out.endTag(null, "password-owner");
                }
                if (policy.mFailedPasswordAttempts != 0) {
                    out.startTag(null, "failed-password-attempts");
                    out.attribute(null, "value", Integer.toString(policy.mFailedPasswordAttempts));
                    out.endTag(null, "failed-password-attempts");
                }
                if (!(policy.mActivePasswordQuality == 0 && policy.mActivePasswordLength == 0 && policy.mActivePasswordUpperCase == 0 && policy.mActivePasswordLowerCase == 0 && policy.mActivePasswordLetters == 0 && policy.mActivePasswordNumeric == 0 && policy.mActivePasswordSymbols == 0 && policy.mActivePasswordNonLetter == 0)) {
                    out.startTag(null, "active-password");
                    out.attribute(null, "quality", Integer.toString(policy.mActivePasswordQuality));
                    out.attribute(null, "length", Integer.toString(policy.mActivePasswordLength));
                    out.attribute(null, "uppercase", Integer.toString(policy.mActivePasswordUpperCase));
                    out.attribute(null, "lowercase", Integer.toString(policy.mActivePasswordLowerCase));
                    out.attribute(null, "letters", Integer.toString(policy.mActivePasswordLetters));
                    out.attribute(null, "numeric", Integer.toString(policy.mActivePasswordNumeric));
                    out.attribute(null, "symbols", Integer.toString(policy.mActivePasswordSymbols));
                    out.attribute(null, "nonletter", Integer.toString(policy.mActivePasswordNonLetter));
                    out.endTag(null, "active-password");
                }
                for (i = 0; i < policy.mLockTaskPackages.size(); i++) {
                    String component = (String) policy.mLockTaskPackages.get(i);
                    out.startTag(null, LOCK_TASK_COMPONENTS_XML);
                    out.attribute(null, "name", component);
                    out.endTag(null, LOCK_TASK_COMPONENTS_XML);
                }
                out.endTag(null, "policies");
                out.endDocument();
                stream2.flush();
                FileUtils.sync(stream2);
                stream2.close();
                journal.commit();
                sendChangedNotification(userHandle);
                stream = stream2;
            } catch (IOException e) {
                stream = stream2;
                if (stream != null) {
                    try {
                        stream.close();
                    } catch (IOException e2) {
                    }
                }
                journal.rollback();
            }
        } catch (IOException e3) {
            if (stream != null) {
                stream.close();
            }
            journal.rollback();
        }
    }

    private void sendChangedNotification(int userHandle) {
        Intent intent = new Intent("android.app.action.DEVICE_POLICY_MANAGER_STATE_CHANGED");
        intent.setFlags(1073741824);
        long ident = Binder.clearCallingIdentity();
        try {
            this.mContext.sendBroadcastAsUser(intent, new UserHandle(userHandle));
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void loadSettingsLocked(com.android.server.devicepolicy.DevicePolicyManagerService.DevicePolicyData r22, int r23) {
        /*
        r21 = this;
        r7 = makeJournaledFile(r23);
        r12 = 0;
        r6 = r7.chooseForRead();
        r13 = new java.io.FileInputStream;	 Catch:{ NullPointerException -> 0x0429, NumberFormatException -> 0x0426, XmlPullParserException -> 0x0423, FileNotFoundException -> 0x0420, IOException -> 0x041d, IndexOutOfBoundsException -> 0x041b }
        r13.<init>(r6);	 Catch:{ NullPointerException -> 0x0429, NumberFormatException -> 0x0426, XmlPullParserException -> 0x0423, FileNotFoundException -> 0x0420, IOException -> 0x041d, IndexOutOfBoundsException -> 0x041b }
        r10 = android.util.Xml.newPullParser();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = r18.name();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r10.setInput(r13, r0);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
    L_0x001d:
        r15 = r10.next();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = 1;
        r0 = r18;
        if (r15 == r0) goto L_0x002d;
    L_0x0027:
        r18 = 2;
        r0 = r18;
        if (r15 != r0) goto L_0x001d;
    L_0x002d:
        r14 = r10.getName();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = "policies";
        r0 = r18;
        r18 = r0.equals(r14);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        if (r18 != 0) goto L_0x012f;
    L_0x003b:
        r18 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r19 = new java.lang.StringBuilder;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r19.<init>();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r20 = "Settings do not start with policies tag: found ";
        r19 = r19.append(r20);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r19;
        r19 = r0.append(r14);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r19 = r19.toString();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18.<init>(r19);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        throw r18;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
    L_0x0056:
        r5 = move-exception;
        r12 = r13;
    L_0x0058:
        r18 = "DevicePolicyManagerService";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "failed parsing ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r6);
        r20 = " ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r5);
        r19 = r19.toString();
        android.util.Slog.w(r18, r19);
    L_0x007e:
        if (r12 == 0) goto L_0x0083;
    L_0x0080:
        r12.close();	 Catch:{ IOException -> 0x0418 }
    L_0x0083:
        r0 = r22;
        r0 = r0.mAdminList;
        r18 = r0;
        r0 = r22;
        r0 = r0.mAdminMap;
        r19 = r0;
        r19 = r19.values();
        r18.addAll(r19);
        r17 = new com.android.internal.widget.LockPatternUtils;
        r0 = r21;
        r0 = r0.mContext;
        r18 = r0;
        r17.<init>(r18);
        r18 = r17.getActivePasswordQuality();
        r0 = r22;
        r0 = r0.mActivePasswordQuality;
        r19 = r0;
        r0 = r18;
        r1 = r19;
        if (r0 >= r1) goto L_0x0125;
    L_0x00b1:
        r18 = "DevicePolicyManagerService";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "Active password quality 0x";
        r19 = r19.append(r20);
        r0 = r22;
        r0 = r0.mActivePasswordQuality;
        r20 = r0;
        r20 = java.lang.Integer.toHexString(r20);
        r19 = r19.append(r20);
        r20 = " does not match actual quality 0x";
        r19 = r19.append(r20);
        r20 = r17.getActivePasswordQuality();
        r20 = java.lang.Integer.toHexString(r20);
        r19 = r19.append(r20);
        r19 = r19.toString();
        android.util.Slog.w(r18, r19);
        r18 = 0;
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordQuality = r0;
        r18 = 0;
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordLength = r0;
        r18 = 0;
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordUpperCase = r0;
        r18 = 0;
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordLowerCase = r0;
        r18 = 0;
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordLetters = r0;
        r18 = 0;
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordNumeric = r0;
        r18 = 0;
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordSymbols = r0;
        r18 = 0;
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordNonLetter = r0;
    L_0x0125:
        r21.validatePasswordOwnerLocked(r22);
        r21.syncDeviceCapabilitiesLocked(r22);
        r21.updateMaximumTimeToLockLocked(r22);
        return;
    L_0x012f:
        r18 = 0;
        r19 = "permission-provider";
        r0 = r18;
        r1 = r19;
        r11 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        if (r11 == 0) goto L_0x0147;
    L_0x013d:
        r18 = android.content.ComponentName.unflattenFromString(r11);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mRestrictionsProvider = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
    L_0x0147:
        r18 = 0;
        r19 = "setup-complete";
        r0 = r18;
        r1 = r19;
        r16 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        if (r16 == 0) goto L_0x016d;
    L_0x0155:
        r18 = 1;
        r18 = java.lang.Boolean.toString(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r16;
        r18 = r0.equals(r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        if (r18 == 0) goto L_0x016d;
    L_0x0165:
        r18 = 1;
        r0 = r18;
        r1 = r22;
        r1.mUserSetupComplete = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
    L_0x016d:
        r15 = r10.next();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r9 = r10.getDepth();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r22;
        r0 = r0.mLockTaskPackages;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = r0;
        r18.clear();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r22;
        r0 = r0.mAdminList;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = r0;
        r18.clear();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r22;
        r0 = r0.mAdminMap;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = r0;
        r18.clear();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
    L_0x0190:
        r15 = r10.next();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = 1;
        r0 = r18;
        if (r15 == r0) goto L_0x0415;
    L_0x019a:
        r18 = 3;
        r0 = r18;
        if (r15 != r0) goto L_0x01a8;
    L_0x01a0:
        r18 = r10.getDepth();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        if (r0 <= r9) goto L_0x0415;
    L_0x01a8:
        r18 = 3;
        r0 = r18;
        if (r15 == r0) goto L_0x0190;
    L_0x01ae:
        r18 = 4;
        r0 = r18;
        if (r15 == r0) goto L_0x0190;
    L_0x01b4:
        r14 = r10.getName();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = "admin";
        r0 = r18;
        r18 = r0.equals(r14);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        if (r18 == 0) goto L_0x0247;
    L_0x01c2:
        r18 = 0;
        r19 = "name";
        r0 = r18;
        r1 = r19;
        r8 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = android.content.ComponentName.unflattenFromString(r8);	 Catch:{ RuntimeException -> 0x01fc }
        r0 = r21;
        r1 = r18;
        r2 = r23;
        r4 = r0.findAdmin(r1, r2);	 Catch:{ RuntimeException -> 0x01fc }
        if (r4 == 0) goto L_0x0190;
    L_0x01de:
        r3 = new com.android.server.devicepolicy.DevicePolicyManagerService$ActiveAdmin;	 Catch:{ RuntimeException -> 0x01fc }
        r3.<init>(r4);	 Catch:{ RuntimeException -> 0x01fc }
        r3.readFromXml(r10);	 Catch:{ RuntimeException -> 0x01fc }
        r0 = r22;
        r0 = r0.mAdminMap;	 Catch:{ RuntimeException -> 0x01fc }
        r18 = r0;
        r0 = r3.info;	 Catch:{ RuntimeException -> 0x01fc }
        r19 = r0;
        r19 = r19.getComponent();	 Catch:{ RuntimeException -> 0x01fc }
        r0 = r18;
        r1 = r19;
        r0.put(r1, r3);	 Catch:{ RuntimeException -> 0x01fc }
        goto L_0x0190;
    L_0x01fc:
        r5 = move-exception;
        r18 = "DevicePolicyManagerService";
        r19 = new java.lang.StringBuilder;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r19.<init>();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r20 = "Failed loading admin ";
        r19 = r19.append(r20);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r19;
        r19 = r0.append(r8);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r19 = r19.toString();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r19;
        android.util.Slog.w(r0, r1, r5);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        goto L_0x0190;
    L_0x021d:
        r5 = move-exception;
        r12 = r13;
    L_0x021f:
        r18 = "DevicePolicyManagerService";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "failed parsing ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r6);
        r20 = " ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r5);
        r19 = r19.toString();
        android.util.Slog.w(r18, r19);
        goto L_0x007e;
    L_0x0247:
        r18 = "failed-password-attempts";
        r0 = r18;
        r18 = r0.equals(r14);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        if (r18 == 0) goto L_0x0296;
    L_0x0251:
        r18 = 0;
        r19 = "value";
        r0 = r18;
        r1 = r19;
        r18 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.lang.Integer.parseInt(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mFailedPasswordAttempts = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        goto L_0x0190;
    L_0x026c:
        r5 = move-exception;
        r12 = r13;
    L_0x026e:
        r18 = "DevicePolicyManagerService";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "failed parsing ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r6);
        r20 = " ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r5);
        r19 = r19.toString();
        android.util.Slog.w(r18, r19);
        goto L_0x007e;
    L_0x0296:
        r18 = "password-owner";
        r0 = r18;
        r18 = r0.equals(r14);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        if (r18 == 0) goto L_0x02bf;
    L_0x02a0:
        r18 = 0;
        r19 = "value";
        r0 = r18;
        r1 = r19;
        r18 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.lang.Integer.parseInt(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mPasswordOwner = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        goto L_0x0190;
    L_0x02bb:
        r18 = move-exception;
        r12 = r13;
        goto L_0x007e;
    L_0x02bf:
        r18 = "active-password";
        r0 = r18;
        r18 = r0.equals(r14);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        if (r18 == 0) goto L_0x03a8;
    L_0x02c9:
        r18 = 0;
        r19 = "quality";
        r0 = r18;
        r1 = r19;
        r18 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.lang.Integer.parseInt(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordQuality = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = 0;
        r19 = "length";
        r0 = r18;
        r1 = r19;
        r18 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.lang.Integer.parseInt(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordLength = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = 0;
        r19 = "uppercase";
        r0 = r18;
        r1 = r19;
        r18 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.lang.Integer.parseInt(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordUpperCase = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = 0;
        r19 = "lowercase";
        r0 = r18;
        r1 = r19;
        r18 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.lang.Integer.parseInt(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordLowerCase = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = 0;
        r19 = "letters";
        r0 = r18;
        r1 = r19;
        r18 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.lang.Integer.parseInt(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordLetters = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = 0;
        r19 = "numeric";
        r0 = r18;
        r1 = r19;
        r18 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.lang.Integer.parseInt(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordNumeric = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = 0;
        r19 = "symbols";
        r0 = r18;
        r1 = r19;
        r18 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.lang.Integer.parseInt(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordSymbols = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = 0;
        r19 = "nonletter";
        r0 = r18;
        r1 = r19;
        r18 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = java.lang.Integer.parseInt(r18);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r18;
        r1 = r22;
        r1.mActivePasswordNonLetter = r0;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        goto L_0x0190;
    L_0x037e:
        r5 = move-exception;
        r12 = r13;
    L_0x0380:
        r18 = "DevicePolicyManagerService";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "failed parsing ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r6);
        r20 = " ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r5);
        r19 = r19.toString();
        android.util.Slog.w(r18, r19);
        goto L_0x007e;
    L_0x03a8:
        r18 = "lock-task-component";
        r0 = r18;
        r18 = r0.equals(r14);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        if (r18 == 0) goto L_0x03f6;
    L_0x03b2:
        r0 = r22;
        r0 = r0.mLockTaskPackages;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18 = r0;
        r19 = 0;
        r20 = "name";
        r0 = r19;
        r1 = r20;
        r19 = r10.getAttributeValue(r0, r1);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r18.add(r19);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        goto L_0x0190;
    L_0x03cc:
        r5 = move-exception;
        r12 = r13;
    L_0x03ce:
        r18 = "DevicePolicyManagerService";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "failed parsing ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r6);
        r20 = " ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r5);
        r19 = r19.toString();
        android.util.Slog.w(r18, r19);
        goto L_0x007e;
    L_0x03f6:
        r18 = "DevicePolicyManagerService";
        r19 = new java.lang.StringBuilder;	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r19.<init>();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r20 = "Unknown tag: ";
        r19 = r19.append(r20);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r0 = r19;
        r19 = r0.append(r14);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        r19 = r19.toString();	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        android.util.Slog.w(r18, r19);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);	 Catch:{ NullPointerException -> 0x0056, NumberFormatException -> 0x021d, XmlPullParserException -> 0x026c, FileNotFoundException -> 0x02bb, IOException -> 0x037e, IndexOutOfBoundsException -> 0x03cc }
        goto L_0x0190;
    L_0x0415:
        r12 = r13;
        goto L_0x007e;
    L_0x0418:
        r18 = move-exception;
        goto L_0x0083;
    L_0x041b:
        r5 = move-exception;
        goto L_0x03ce;
    L_0x041d:
        r5 = move-exception;
        goto L_0x0380;
    L_0x0420:
        r18 = move-exception;
        goto L_0x007e;
    L_0x0423:
        r5 = move-exception;
        goto L_0x026e;
    L_0x0426:
        r5 = move-exception;
        goto L_0x021f;
    L_0x0429:
        r5 = move-exception;
        goto L_0x0058;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.loadSettingsLocked(com.android.server.devicepolicy.DevicePolicyManagerService$DevicePolicyData, int):void");
    }

    static void validateQualityConstant(int quality) {
        switch (quality) {
            case AppTransition.TRANSIT_NONE /*0*/:
            case 32768:
            case 65536:
            case 131072:
            case 196608:
            case 262144:
            case 327680:
            case 393216:
            default:
                throw new IllegalArgumentException("Invalid quality constant: 0x" + Integer.toHexString(quality));
        }
    }

    void validatePasswordOwnerLocked(DevicePolicyData policy) {
        if (policy.mPasswordOwner >= 0) {
            boolean haveOwner = DBG;
            for (int i = policy.mAdminList.size() - 1; i >= 0; i--) {
                if (((ActiveAdmin) policy.mAdminList.get(i)).getUid() == policy.mPasswordOwner) {
                    haveOwner = true;
                    break;
                }
            }
            if (!haveOwner) {
                Slog.w(LOG_TAG, "Previous password owner " + policy.mPasswordOwner + " no longer active; disabling");
                policy.mPasswordOwner = -1;
            }
        }
    }

    void syncDeviceCapabilitiesLocked(DevicePolicyData policy) {
        boolean systemState = SystemProperties.getBoolean(SYSTEM_PROP_DISABLE_CAMERA, DBG);
        boolean cameraDisabled = getCameraDisabled(null, policy.mUserHandle);
        if (cameraDisabled != systemState) {
            String value;
            long token = Binder.clearCallingIdentity();
            if (cameraDisabled) {
                try {
                    value = "1";
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(token);
                }
            } else {
                value = "0";
            }
            SystemProperties.set(SYSTEM_PROP_DISABLE_CAMERA, value);
            Binder.restoreCallingIdentity(token);
        }
    }

    public void systemReady() {
        if (this.mHasFeature) {
            getUserData(0);
            loadDeviceOwner();
            cleanUpOldUsers();
            new SetupContentObserver(this.mHandler).register(this.mContext.getContentResolver());
            updateUserSetupComplete();
            List<UserInfo> users = this.mUserManager.getUsers(true);
            int N = users.size();
            for (int i = 0; i < N; i++) {
                int userHandle = ((UserInfo) users.get(i)).id;
                updateScreenCaptureDisabledInWindowManager(userHandle, getScreenCaptureDisabled(null, userHandle));
            }
        }
    }

    private void cleanUpOldUsers() {
        Set<Integer> usersWithProfileOwners;
        Set<Integer> usersWithData;
        synchronized (this) {
            usersWithProfileOwners = this.mDeviceOwner != null ? this.mDeviceOwner.getProfileOwnerKeys() : new HashSet();
            usersWithData = new HashSet();
            for (int i = 0; i < this.mUserData.size(); i++) {
                usersWithData.add(Integer.valueOf(this.mUserData.keyAt(i)));
            }
        }
        List<UserInfo> allUsers = this.mUserManager.getUsers();
        Set<Integer> deletedUsers = new HashSet();
        deletedUsers.addAll(usersWithProfileOwners);
        deletedUsers.addAll(usersWithData);
        for (UserInfo userInfo : allUsers) {
            deletedUsers.remove(Integer.valueOf(userInfo.id));
        }
        for (Integer userId : deletedUsers) {
            removeUserData(userId.intValue());
        }
    }

    private void handlePasswordExpirationNotification(int userHandle) {
        synchronized (this) {
            long now = System.currentTimeMillis();
            for (UserInfo ui : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserData(ui.id);
                int count = policy.mAdminList.size();
                if (count > 0) {
                    for (int i = 0; i < count; i++) {
                        ActiveAdmin admin = (ActiveAdmin) policy.mAdminList.get(i);
                        if (admin.info.usesPolicy(6) && admin.passwordExpirationTimeout > 0 && now >= admin.passwordExpirationDate - EXPIRATION_GRACE_PERIOD_MS && admin.passwordExpirationDate > 0) {
                            sendAdminCommandLocked(admin, "android.app.action.ACTION_PASSWORD_EXPIRING");
                        }
                    }
                }
            }
            setExpirationAlarmCheckLocked(this.mContext, getUserData(userHandle));
        }
    }

    public void setActiveAdmin(ComponentName adminReceiver, boolean refreshing, int userHandle) {
        if (this.mHasFeature) {
            setActiveAdmin(adminReceiver, refreshing, userHandle, null);
        }
    }

    private void setActiveAdmin(ComponentName adminReceiver, boolean refreshing, int userHandle, Bundle onEnableData) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_DEVICE_ADMINS", null);
        enforceCrossUserPermission(userHandle);
        DevicePolicyData policy = getUserData(userHandle);
        DeviceAdminInfo info = findAdmin(adminReceiver, userHandle);
        if (info == null) {
            throw new IllegalArgumentException("Bad admin: " + adminReceiver);
        }
        synchronized (this) {
            long ident = Binder.clearCallingIdentity();
            if (!refreshing) {
                try {
                    if (getActiveAdminUncheckedLocked(adminReceiver, userHandle) != null) {
                        throw new IllegalArgumentException("Admin is already added");
                    }
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(ident);
                }
            }
            ActiveAdmin newAdmin = new ActiveAdmin(info);
            policy.mAdminMap.put(adminReceiver, newAdmin);
            int replaceIndex = -1;
            int N = policy.mAdminList.size();
            for (int i = 0; i < N; i++) {
                if (((ActiveAdmin) policy.mAdminList.get(i)).info.getComponent().equals(adminReceiver)) {
                    replaceIndex = i;
                    break;
                }
            }
            if (replaceIndex == -1) {
                policy.mAdminList.add(newAdmin);
                enableIfNecessary(info.getPackageName(), userHandle);
            } else {
                policy.mAdminList.set(replaceIndex, newAdmin);
            }
            saveSettingsLocked(userHandle);
            sendAdminCommandLocked(newAdmin, "android.app.action.DEVICE_ADMIN_ENABLED", onEnableData, null);
            Binder.restoreCallingIdentity(ident);
        }
    }

    public boolean isAdminActive(ComponentName adminReceiver, int userHandle) {
        boolean z = DBG;
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (getActiveAdminUncheckedLocked(adminReceiver, userHandle) != null) {
                    z = true;
                }
            }
        }
        return z;
    }

    public boolean isRemovingAdmin(ComponentName adminReceiver, int userHandle) {
        if (!this.mHasFeature) {
            return DBG;
        }
        boolean contains;
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            contains = getUserData(userHandle).mRemovingAdmins.contains(adminReceiver);
        }
        return contains;
    }

    public boolean hasGrantedPolicy(ComponentName adminReceiver, int policyId, int userHandle) {
        if (!this.mHasFeature) {
            return DBG;
        }
        boolean usesPolicy;
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            ActiveAdmin administrator = getActiveAdminUncheckedLocked(adminReceiver, userHandle);
            if (administrator == null) {
                throw new SecurityException("No active admin " + adminReceiver);
            }
            usesPolicy = administrator.info.usesPolicy(policyId);
        }
        return usesPolicy;
    }

    public List<ComponentName> getActiveAdmins(int userHandle) {
        if (!this.mHasFeature) {
            return Collections.EMPTY_LIST;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            DevicePolicyData policy = getUserData(userHandle);
            int N = policy.mAdminList.size();
            if (N <= 0) {
                return null;
            }
            List<ComponentName> res = new ArrayList(N);
            for (int i = 0; i < N; i++) {
                res.add(((ActiveAdmin) policy.mAdminList.get(i)).info.getComponent());
            }
            return res;
        }
    }

    public boolean packageHasActiveAdmins(String packageName, int userHandle) {
        if (!this.mHasFeature) {
            return DBG;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            DevicePolicyData policy = getUserData(userHandle);
            int N = policy.mAdminList.size();
            for (int i = 0; i < N; i++) {
                if (((ActiveAdmin) policy.mAdminList.get(i)).info.getPackageName().equals(packageName)) {
                    return true;
                }
            }
            return DBG;
        }
    }

    public void removeActiveAdmin(ComponentName adminReceiver, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(adminReceiver, userHandle);
                if (admin == null) {
                    return;
                }
                if (admin.getUid() != Binder.getCallingUid()) {
                    if (isDeviceOwner(adminReceiver.getPackageName())) {
                        return;
                    }
                    this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_DEVICE_ADMINS", null);
                }
                long ident = Binder.clearCallingIdentity();
                try {
                    removeActiveAdminLocked(adminReceiver, userHandle);
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            }
        }
    }

    public void setPasswordQuality(ComponentName who, int quality, int userHandle) {
        if (this.mHasFeature) {
            validateQualityConstant(quality);
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 0);
                if (ap.passwordQuality != quality) {
                    ap.passwordQuality = quality;
                    saveSettingsLocked(userHandle);
                }
            }
        }
    }

    public int getPasswordQuality(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            int mode = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                int i = admin != null ? admin.passwordQuality : 0;
                return i;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i2 = 0; i2 < N; i2++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i2);
                    if (mode < admin.passwordQuality) {
                        mode = admin.passwordQuality;
                    }
                }
            }
            return mode;
        }
    }

    public void setPasswordMinimumLength(ComponentName who, int length, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 0);
                if (ap.minimumPasswordLength != length) {
                    ap.minimumPasswordLength = length;
                    saveSettingsLocked(userHandle);
                }
            }
        }
    }

    public int getPasswordMinimumLength(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            int length = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                int i = admin != null ? admin.minimumPasswordLength : 0;
                return i;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i2 = 0; i2 < N; i2++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i2);
                    if (length < admin.minimumPasswordLength) {
                        length = admin.minimumPasswordLength;
                    }
                }
            }
            return length;
        }
    }

    public void setPasswordHistoryLength(ComponentName who, int length, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 0);
                if (ap.passwordHistoryLength != length) {
                    ap.passwordHistoryLength = length;
                    saveSettingsLocked(userHandle);
                }
            }
        }
    }

    public int getPasswordHistoryLength(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            int length = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                int i = admin != null ? admin.passwordHistoryLength : 0;
                return i;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i2 = 0; i2 < N; i2++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i2);
                    if (length < admin.passwordHistoryLength) {
                        length = admin.passwordHistoryLength;
                    }
                }
            }
            return length;
        }
    }

    public void setPasswordExpirationTimeout(ComponentName who, long timeout, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                } else if (timeout < 0) {
                    throw new IllegalArgumentException("Timeout must be >= 0 ms");
                } else {
                    long expiration;
                    ActiveAdmin ap = getActiveAdminForCallerLocked(who, 6);
                    if (timeout > 0) {
                        expiration = timeout + System.currentTimeMillis();
                    } else {
                        expiration = 0;
                    }
                    ap.passwordExpirationDate = expiration;
                    ap.passwordExpirationTimeout = timeout;
                    if (timeout > 0) {
                        Slog.w(LOG_TAG, "setPasswordExpiration(): password will expire on " + DateFormat.getDateTimeInstance(2, 2).format(new Date(expiration)));
                    }
                    saveSettingsLocked(userHandle);
                    setExpirationAlarmCheckLocked(this.mContext, getUserData(userHandle));
                }
            }
        }
    }

    public long getPasswordExpirationTimeout(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            long timeout = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                long j = admin != null ? admin.passwordExpirationTimeout : 0;
                return j;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i = 0; i < N; i++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i);
                    if (timeout == 0 || (admin.passwordExpirationTimeout != 0 && timeout > admin.passwordExpirationTimeout)) {
                        timeout = admin.passwordExpirationTimeout;
                    }
                }
            }
            return timeout;
        }
    }

    public boolean addCrossProfileWidgetProvider(ComponentName admin, String packageName) {
        int userId = UserHandle.getCallingUserId();
        List<String> changedProviders = null;
        synchronized (this) {
            ActiveAdmin activeAdmin = getActiveAdminForCallerLocked(admin, -1);
            if (activeAdmin.crossProfileWidgetProviders == null) {
                activeAdmin.crossProfileWidgetProviders = new ArrayList();
            }
            List<String> providers = activeAdmin.crossProfileWidgetProviders;
            if (!providers.contains(packageName)) {
                providers.add(packageName);
                List<String> changedProviders2 = new ArrayList(providers);
                try {
                    saveSettingsLocked(userId);
                    changedProviders = changedProviders2;
                } catch (Throwable th) {
                    Throwable th2 = th;
                    changedProviders = changedProviders2;
                    throw th2;
                }
            }
            try {
                if (changedProviders == null) {
                    return DBG;
                }
                this.mLocalService.notifyCrossProfileProvidersChanged(userId, changedProviders);
                return true;
            } catch (Throwable th3) {
                th2 = th3;
                throw th2;
            }
        }
    }

    public boolean removeCrossProfileWidgetProvider(ComponentName admin, String packageName) {
        int userId = UserHandle.getCallingUserId();
        List<String> changedProviders = null;
        synchronized (this) {
            ActiveAdmin activeAdmin = getActiveAdminForCallerLocked(admin, -1);
            if (activeAdmin.crossProfileWidgetProviders == null) {
                return DBG;
            }
            List<String> providers = activeAdmin.crossProfileWidgetProviders;
            if (providers.remove(packageName)) {
                List<String> changedProviders2 = new ArrayList(providers);
                try {
                    saveSettingsLocked(userId);
                    changedProviders = changedProviders2;
                } catch (Throwable th) {
                    Throwable th2 = th;
                    changedProviders = changedProviders2;
                    throw th2;
                }
            }
            try {
                if (changedProviders == null) {
                    return DBG;
                }
                this.mLocalService.notifyCrossProfileProvidersChanged(userId, changedProviders);
                return true;
            } catch (Throwable th3) {
                th2 = th3;
                throw th2;
            }
        }
    }

    public List<String> getCrossProfileWidgetProviders(ComponentName admin) {
        List<String> list;
        synchronized (this) {
            ActiveAdmin activeAdmin = getActiveAdminForCallerLocked(admin, -1);
            if (activeAdmin.crossProfileWidgetProviders == null || activeAdmin.crossProfileWidgetProviders.isEmpty()) {
                list = null;
            } else if (Binder.getCallingUid() == Process.myUid()) {
                list = new ArrayList(activeAdmin.crossProfileWidgetProviders);
            } else {
                list = activeAdmin.crossProfileWidgetProviders;
            }
        }
        return list;
    }

    private long getPasswordExpirationLocked(ComponentName who, int userHandle) {
        long timeout = 0;
        ActiveAdmin admin;
        if (who != null) {
            admin = getActiveAdminUncheckedLocked(who, userHandle);
            return admin != null ? admin.passwordExpirationDate : 0;
        } else {
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i = 0; i < N; i++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i);
                    if (timeout == 0 || (admin.passwordExpirationDate != 0 && timeout > admin.passwordExpirationDate)) {
                        timeout = admin.passwordExpirationDate;
                    }
                }
            }
            return timeout;
        }
    }

    public long getPasswordExpiration(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        long passwordExpirationLocked;
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            passwordExpirationLocked = getPasswordExpirationLocked(who, userHandle);
        }
        return passwordExpirationLocked;
    }

    public void setPasswordMinimumUpperCase(ComponentName who, int length, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 0);
                if (ap.minimumPasswordUpperCase != length) {
                    ap.minimumPasswordUpperCase = length;
                    saveSettingsLocked(userHandle);
                }
            }
        }
    }

    public int getPasswordMinimumUpperCase(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            int length = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                int i = admin != null ? admin.minimumPasswordUpperCase : 0;
                return i;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i2 = 0; i2 < N; i2++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i2);
                    if (length < admin.minimumPasswordUpperCase) {
                        length = admin.minimumPasswordUpperCase;
                    }
                }
            }
            return length;
        }
    }

    public void setPasswordMinimumLowerCase(ComponentName who, int length, int userHandle) {
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            ActiveAdmin ap = getActiveAdminForCallerLocked(who, 0);
            if (ap.minimumPasswordLowerCase != length) {
                ap.minimumPasswordLowerCase = length;
                saveSettingsLocked(userHandle);
            }
        }
    }

    public int getPasswordMinimumLowerCase(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            int length = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                int i = admin != null ? admin.minimumPasswordLowerCase : 0;
                return i;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i2 = 0; i2 < N; i2++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i2);
                    if (length < admin.minimumPasswordLowerCase) {
                        length = admin.minimumPasswordLowerCase;
                    }
                }
            }
            return length;
        }
    }

    public void setPasswordMinimumLetters(ComponentName who, int length, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 0);
                if (ap.minimumPasswordLetters != length) {
                    ap.minimumPasswordLetters = length;
                    saveSettingsLocked(userHandle);
                }
            }
        }
    }

    public int getPasswordMinimumLetters(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            int length = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                int i = admin != null ? admin.minimumPasswordLetters : 0;
                return i;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i2 = 0; i2 < N; i2++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i2);
                    if (length < admin.minimumPasswordLetters) {
                        length = admin.minimumPasswordLetters;
                    }
                }
            }
            return length;
        }
    }

    public void setPasswordMinimumNumeric(ComponentName who, int length, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 0);
                if (ap.minimumPasswordNumeric != length) {
                    ap.minimumPasswordNumeric = length;
                    saveSettingsLocked(userHandle);
                }
            }
        }
    }

    public int getPasswordMinimumNumeric(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            int length = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                int i = admin != null ? admin.minimumPasswordNumeric : 0;
                return i;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i2 = 0; i2 < N; i2++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i2);
                    if (length < admin.minimumPasswordNumeric) {
                        length = admin.minimumPasswordNumeric;
                    }
                }
            }
            return length;
        }
    }

    public void setPasswordMinimumSymbols(ComponentName who, int length, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 0);
                if (ap.minimumPasswordSymbols != length) {
                    ap.minimumPasswordSymbols = length;
                    saveSettingsLocked(userHandle);
                }
            }
        }
    }

    public int getPasswordMinimumSymbols(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            int length = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                int i = admin != null ? admin.minimumPasswordSymbols : 0;
                return i;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i2 = 0; i2 < N; i2++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i2);
                    if (length < admin.minimumPasswordSymbols) {
                        length = admin.minimumPasswordSymbols;
                    }
                }
            }
            return length;
        }
    }

    public void setPasswordMinimumNonLetter(ComponentName who, int length, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 0);
                if (ap.minimumPasswordNonLetter != length) {
                    ap.minimumPasswordNonLetter = length;
                    saveSettingsLocked(userHandle);
                }
            }
        }
    }

    public int getPasswordMinimumNonLetter(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            int length = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                int i = admin != null ? admin.minimumPasswordNonLetter : 0;
                return i;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i2 = 0; i2 < N; i2++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i2);
                    if (length < admin.minimumPasswordNonLetter) {
                        length = admin.minimumPasswordNonLetter;
                    }
                }
            }
            return length;
        }
    }

    public boolean isActivePasswordSufficient(int userHandle) {
        boolean z = true;
        if (!this.mHasFeature) {
            return true;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            UserInfo parent = getProfileParent(userHandle);
            DevicePolicyData policy = getUserDataUnchecked(parent == null ? userHandle : parent.id);
            getActiveAdminForCallerLocked(null, 0);
            if (policy.mActivePasswordQuality < getPasswordQuality(null, userHandle) || policy.mActivePasswordLength < getPasswordMinimumLength(null, userHandle)) {
                return DBG;
            } else if (policy.mActivePasswordQuality != 393216) {
                return true;
            } else {
                if (policy.mActivePasswordUpperCase < getPasswordMinimumUpperCase(null, userHandle) || policy.mActivePasswordLowerCase < getPasswordMinimumLowerCase(null, userHandle) || policy.mActivePasswordLetters < getPasswordMinimumLetters(null, userHandle) || policy.mActivePasswordNumeric < getPasswordMinimumNumeric(null, userHandle) || policy.mActivePasswordSymbols < getPasswordMinimumSymbols(null, userHandle) || policy.mActivePasswordNonLetter < getPasswordMinimumNonLetter(null, userHandle)) {
                    z = DBG;
                }
                return z;
            }
        }
    }

    public int getCurrentFailedPasswordAttempts(int userHandle) {
        int i;
        synchronized (this) {
            getActiveAdminForCallerLocked(null, 1);
            UserInfo parent = getProfileParent(userHandle);
            i = getUserDataUnchecked(parent == null ? userHandle : parent.id).mFailedPasswordAttempts;
        }
        return i;
    }

    public void setMaximumFailedPasswordsForWipe(ComponentName who, int num, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                getActiveAdminForCallerLocked(who, 4);
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 1);
                if (ap.maximumFailedPasswordsForWipe != num) {
                    ap.maximumFailedPasswordsForWipe = num;
                    saveSettingsLocked(userHandle);
                }
            }
        }
    }

    public int getMaximumFailedPasswordsForWipe(ComponentName who, int userHandle) {
        int i = 0;
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                ActiveAdmin admin = who != null ? getActiveAdminUncheckedLocked(who, userHandle) : getAdminWithMinimumFailedPasswordsForWipeLocked(userHandle);
                if (admin != null) {
                    i = admin.maximumFailedPasswordsForWipe;
                }
            }
        }
        return i;
    }

    public int getProfileWithMinimumFailedPasswordsForWipe(int userHandle) {
        int i = -10000;
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                ActiveAdmin admin = getAdminWithMinimumFailedPasswordsForWipeLocked(userHandle);
                if (admin != null) {
                    i = admin.getUserHandle().getIdentifier();
                }
            }
        }
        return i;
    }

    private ActiveAdmin getAdminWithMinimumFailedPasswordsForWipeLocked(int userHandle) {
        int count = 0;
        ActiveAdmin strictestAdmin = null;
        for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
            Iterator i$ = getUserDataUnchecked(userInfo.id).mAdminList.iterator();
            while (i$.hasNext()) {
                ActiveAdmin admin = (ActiveAdmin) i$.next();
                if (admin.maximumFailedPasswordsForWipe != 0 && (count == 0 || count > admin.maximumFailedPasswordsForWipe || (userInfo.isPrimary() && count >= admin.maximumFailedPasswordsForWipe))) {
                    count = admin.maximumFailedPasswordsForWipe;
                    strictestAdmin = admin;
                }
            }
        }
        return strictestAdmin;
    }

    public boolean resetPassword(String passwordOrNull, int flags, int userHandle) {
        if (!this.mHasFeature) {
            return DBG;
        }
        enforceCrossUserPermission(userHandle);
        enforceNotManagedProfile(userHandle, "reset the password");
        String password = passwordOrNull != null ? passwordOrNull : "";
        synchronized (this) {
            getActiveAdminForCallerLocked(null, 2);
            int quality = getPasswordQuality(null, userHandle);
            if (quality != 0) {
                int realQuality = LockPatternUtils.computePasswordQuality(password);
                if (realQuality >= quality || quality == 393216) {
                    quality = Math.max(realQuality, quality);
                } else {
                    Slog.w(LOG_TAG, "resetPassword: password quality 0x" + Integer.toHexString(realQuality) + " does not meet required quality 0x" + Integer.toHexString(quality));
                    return DBG;
                }
            }
            int length = getPasswordMinimumLength(null, userHandle);
            if (password.length() < length) {
                Slog.w(LOG_TAG, "resetPassword: password length " + password.length() + " does not meet required length " + length);
                return DBG;
            }
            if (quality == 393216) {
                int letters = 0;
                int uppercase = 0;
                int lowercase = 0;
                int numbers = 0;
                int symbols = 0;
                int nonletter = 0;
                for (int i = 0; i < password.length(); i++) {
                    char c = password.charAt(i);
                    if (c >= 'A' && c <= 'Z') {
                        letters++;
                        uppercase++;
                    } else if (c >= 'a' && c <= 'z') {
                        letters++;
                        lowercase++;
                    } else if (c < '0' || c > '9') {
                        symbols++;
                        nonletter++;
                    } else {
                        numbers++;
                        nonletter++;
                    }
                }
                int neededLetters = getPasswordMinimumLetters(null, userHandle);
                if (letters < neededLetters) {
                    Slog.w(LOG_TAG, "resetPassword: number of letters " + letters + " does not meet required number of letters " + neededLetters);
                    return DBG;
                }
                int neededNumbers = getPasswordMinimumNumeric(null, userHandle);
                if (numbers < neededNumbers) {
                    Slog.w(LOG_TAG, "resetPassword: number of numerical digits " + numbers + " does not meet required number of numerical digits " + neededNumbers);
                    return DBG;
                }
                int neededLowerCase = getPasswordMinimumLowerCase(null, userHandle);
                if (lowercase < neededLowerCase) {
                    Slog.w(LOG_TAG, "resetPassword: number of lowercase letters " + lowercase + " does not meet required number of lowercase letters " + neededLowerCase);
                    return DBG;
                }
                int neededUpperCase = getPasswordMinimumUpperCase(null, userHandle);
                if (uppercase < neededUpperCase) {
                    Slog.w(LOG_TAG, "resetPassword: number of uppercase letters " + uppercase + " does not meet required number of uppercase letters " + neededUpperCase);
                    return DBG;
                }
                int neededSymbols = getPasswordMinimumSymbols(null, userHandle);
                if (symbols < neededSymbols) {
                    Slog.w(LOG_TAG, "resetPassword: number of special symbols " + symbols + " does not meet required number of special symbols " + neededSymbols);
                    return DBG;
                }
                int neededNonLetter = getPasswordMinimumNonLetter(null, userHandle);
                if (nonletter < neededNonLetter) {
                    Slog.w(LOG_TAG, "resetPassword: number of non-letter characters " + nonletter + " does not meet required number of non-letter characters " + neededNonLetter);
                    return DBG;
                }
            }
            int callingUid = Binder.getCallingUid();
            DevicePolicyData policy = getUserData(userHandle);
            if (policy.mPasswordOwner >= 0) {
                int i2 = policy.mPasswordOwner;
                if (r0 != callingUid) {
                    Slog.w(LOG_TAG, "resetPassword: already set by another uid and not entered by user");
                    return DBG;
                }
            }
            long ident = Binder.clearCallingIdentity();
            try {
                LockPatternUtils utils = new LockPatternUtils(this.mContext);
                if (TextUtils.isEmpty(password)) {
                    utils.clearLock(DBG, userHandle);
                } else {
                    utils.saveLockPassword(password, quality, DBG, userHandle);
                }
                boolean requireEntry = (flags & 1) != 0 ? true : DBG;
                if (requireEntry) {
                    utils.requireCredentialEntry(-1);
                }
                synchronized (this) {
                    int newOwner = requireEntry ? callingUid : -1;
                    i2 = policy.mPasswordOwner;
                    if (r0 != newOwner) {
                        policy.mPasswordOwner = newOwner;
                        saveSettingsLocked(userHandle);
                    }
                }
                Binder.restoreCallingIdentity(ident);
                return true;
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    public void setMaximumTimeToLock(ComponentName who, long timeMs, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 3);
                if (ap.maximumTimeToUnlock != timeMs) {
                    ap.maximumTimeToUnlock = timeMs;
                    saveSettingsLocked(userHandle);
                    updateMaximumTimeToLockLocked(getUserData(userHandle));
                }
            }
        }
    }

    void updateMaximumTimeToLockLocked(DevicePolicyData policy) {
        long timeMs = getMaximumTimeToLock(null, policy.mUserHandle);
        if (policy.mLastMaximumTimeToLock != timeMs) {
            long ident = Binder.clearCallingIdentity();
            if (timeMs <= 0) {
                timeMs = 2147483647L;
            } else {
                Global.putInt(this.mContext.getContentResolver(), "stay_on_while_plugged_in", 0);
            }
            try {
                policy.mLastMaximumTimeToLock = timeMs;
                this.mPowerManagerInternal.setMaximumScreenOffTimeoutFromDeviceAdmin((int) timeMs);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    public long getMaximumTimeToLock(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return 0;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            long time = 0;
            if (who != null) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                long j = admin != null ? admin.maximumTimeToUnlock : 0;
                return j;
            }
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i = 0; i < N; i++) {
                    admin = (ActiveAdmin) policy.mAdminList.get(i);
                    if (time == 0) {
                        time = admin.maximumTimeToUnlock;
                    } else if (admin.maximumTimeToUnlock != 0 && time > admin.maximumTimeToUnlock) {
                        time = admin.maximumTimeToUnlock;
                    }
                }
            }
            return time;
        }
    }

    public void lockNow() {
        if (this.mHasFeature) {
            synchronized (this) {
                getActiveAdminForCallerLocked(null, 3);
                lockNowUnchecked();
            }
        }
    }

    private void lockNowUnchecked() {
        long ident = Binder.clearCallingIdentity();
        try {
            this.mPowerManager.goToSleep(SystemClock.uptimeMillis(), 1, 0);
            new LockPatternUtils(this.mContext).requireCredentialEntry(-1);
            getWindowManager().lockNow(null);
        } catch (RemoteException e) {
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private boolean isExtStorageEncrypted() {
        return !"".equals(SystemProperties.get("vold.decrypt")) ? true : DBG;
    }

    public void enforceCanManageCaCerts(ComponentName who) {
        if (who == null) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_CA_CERTIFICATES", null);
            return;
        }
        synchronized (this) {
            getActiveAdminForCallerLocked(who, -1);
        }
    }

    public boolean installCaCert(ComponentName admin, byte[] certBuffer) throws RemoteException {
        enforceCanManageCaCerts(admin);
        try {
            byte[] pemCert = Credentials.convertToPem(new Certificate[]{parseCert(certBuffer)});
            UserHandle userHandle = new UserHandle(UserHandle.getCallingUserId());
            long id = Binder.clearCallingIdentity();
            try {
                KeyChainConnection keyChainConnection = KeyChain.bindAsUser(this.mContext, userHandle);
                boolean z;
                try {
                    keyChainConnection.getService().installCaCertificate(pemCert);
                    z = true;
                    Binder.restoreCallingIdentity(id);
                    return z;
                } catch (RemoteException e) {
                    z = LOG_TAG;
                    Log.e(z, "installCaCertsToKeyChain(): ", e);
                    Binder.restoreCallingIdentity(id);
                    return DBG;
                } finally {
                    keyChainConnection.close();
                }
            } catch (InterruptedException e1) {
                try {
                    Log.w(LOG_TAG, "installCaCertsToKeyChain(): ", e1);
                    Thread.currentThread().interrupt();
                } finally {
                    Binder.restoreCallingIdentity(id);
                }
            }
        } catch (CertificateException ce) {
            Log.e(LOG_TAG, "Problem converting cert", ce);
            return DBG;
        } catch (IOException ioe) {
            Log.e(LOG_TAG, "Problem reading cert", ioe);
            return DBG;
        }
    }

    private static X509Certificate parseCert(byte[] certBuffer) throws CertificateException {
        return (X509Certificate) CertificateFactory.getInstance("X.509").generateCertificate(new ByteArrayInputStream(certBuffer));
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void uninstallCaCert(android.content.ComponentName r9, java.lang.String r10) {
        /*
        r8 = this;
        r8.enforceCanManageCaCerts(r9);
        r5 = new android.os.UserHandle;
        r6 = android.os.UserHandle.getCallingUserId();
        r5.<init>(r6);
        r2 = android.os.Binder.clearCallingIdentity();
        r6 = r8.mContext;	 Catch:{ InterruptedException -> 0x0030 }
        r4 = android.security.KeyChain.bindAsUser(r6, r5);	 Catch:{ InterruptedException -> 0x0030 }
        r6 = r4.getService();	 Catch:{ RemoteException -> 0x0024 }
        r6.deleteCaCertificate(r10);	 Catch:{ RemoteException -> 0x0024 }
        r4.close();	 Catch:{ InterruptedException -> 0x0030 }
    L_0x0020:
        android.os.Binder.restoreCallingIdentity(r2);
    L_0x0023:
        return;
    L_0x0024:
        r0 = move-exception;
        r6 = "DevicePolicyManagerService";
        r7 = "from CaCertUninstaller: ";
        android.util.Log.e(r6, r7, r0);	 Catch:{ all -> 0x0043 }
        r4.close();	 Catch:{ InterruptedException -> 0x0030 }
        goto L_0x0020;
    L_0x0030:
        r1 = move-exception;
        r6 = "DevicePolicyManagerService";
        r7 = "CaCertUninstaller: ";
        android.util.Log.w(r6, r7, r1);	 Catch:{ all -> 0x0048 }
        r6 = java.lang.Thread.currentThread();	 Catch:{ all -> 0x0048 }
        r6.interrupt();	 Catch:{ all -> 0x0048 }
        android.os.Binder.restoreCallingIdentity(r2);
        goto L_0x0023;
    L_0x0043:
        r6 = move-exception;
        r4.close();	 Catch:{ InterruptedException -> 0x0030 }
        throw r6;	 Catch:{ InterruptedException -> 0x0030 }
    L_0x0048:
        r6 = move-exception;
        android.os.Binder.restoreCallingIdentity(r2);
        throw r6;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.uninstallCaCert(android.content.ComponentName, java.lang.String):void");
    }

    private void wipeDataLocked(boolean wipeExtRequested, String reason) {
        Exception e;
        boolean forceExtWipe = (Environment.isExternalStorageRemovable() || !isExtStorageEncrypted()) ? DBG : true;
        if ((forceExtWipe || wipeExtRequested) && !Environment.isExternalStorageEmulated()) {
            Intent intent = new Intent("com.android.internal.os.storage.FORMAT_AND_FACTORY_RESET");
            intent.putExtra("always_reset", true);
            intent.putExtra("android.intent.extra.REASON", reason);
            intent.setComponent(ExternalStorageFormatter.COMPONENT_NAME);
            this.mWakeLock.acquire(10000);
            this.mContext.startService(intent);
            return;
        }
        try {
            RecoverySystem.rebootWipeUserData(this.mContext, reason);
        } catch (IOException e2) {
            e = e2;
            Slog.w(LOG_TAG, "Failed requesting data wipe", e);
        } catch (SecurityException e3) {
            e = e3;
            Slog.w(LOG_TAG, "Failed requesting data wipe", e);
        }
    }

    public void wipeData(int flags, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                String source;
                ActiveAdmin admin = getActiveAdminForCallerLocked(null, 4);
                ComponentName cname = admin.info.getComponent();
                if (cname != null) {
                    source = cname.flattenToShortString();
                } else {
                    source = admin.info.getPackageName();
                }
                long ident = Binder.clearCallingIdentity();
                if ((flags & 2) != 0) {
                    if (userHandle == 0) {
                        try {
                            if (isDeviceOwner(admin.info.getPackageName())) {
                                PersistentDataBlockManager manager = (PersistentDataBlockManager) this.mContext.getSystemService("persistent_data_block");
                                if (manager != null) {
                                    manager.wipe();
                                }
                            }
                        } catch (Throwable th) {
                            Binder.restoreCallingIdentity(ident);
                        }
                    }
                    throw new SecurityException("Only device owner admins can set WIPE_RESET_PROTECTION_DATA");
                }
                wipeDeviceOrUserLocked((flags & 1) != 0 ? true : DBG, userHandle, "DevicePolicyManager.wipeData() from " + source);
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    private void wipeDeviceOrUserLocked(boolean wipeExtRequested, int userHandle, String reason) {
        if (userHandle == 0) {
            wipeDataLocked(wipeExtRequested, reason);
        } else {
            this.mHandler.post(new C01893(userHandle));
        }
    }

    public void getRemoveWarning(ComponentName comp, RemoteCallback result, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            this.mContext.enforceCallingOrSelfPermission("android.permission.BIND_DEVICE_ADMIN", null);
            synchronized (this) {
                ActiveAdmin admin = getActiveAdminUncheckedLocked(comp, userHandle);
                if (admin == null) {
                    try {
                        result.sendResult(null);
                    } catch (RemoteException e) {
                    }
                    return;
                }
                Intent intent = new Intent("android.app.action.DEVICE_ADMIN_DISABLE_REQUESTED");
                intent.setFlags(268435456);
                intent.setComponent(admin.info.getComponent());
                this.mContext.sendOrderedBroadcastAsUser(intent, new UserHandle(userHandle), null, new C01904(result), null, -1, null, null);
                return;
            }
        }
    }

    public void setActivePasswordState(int quality, int length, int letters, int uppercase, int lowercase, int numbers, int symbols, int nonletter, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            enforceNotManagedProfile(userHandle, "set the active password");
            this.mContext.enforceCallingOrSelfPermission("android.permission.BIND_DEVICE_ADMIN", null);
            DevicePolicyData p = getUserData(userHandle);
            validateQualityConstant(quality);
            synchronized (this) {
                if (!(p.mActivePasswordQuality == quality && p.mActivePasswordLength == length && p.mFailedPasswordAttempts == 0 && p.mActivePasswordLetters == letters && p.mActivePasswordUpperCase == uppercase && p.mActivePasswordLowerCase == lowercase && p.mActivePasswordNumeric == numbers && p.mActivePasswordSymbols == symbols && p.mActivePasswordNonLetter == nonletter)) {
                    long ident = Binder.clearCallingIdentity();
                    try {
                        p.mActivePasswordQuality = quality;
                        p.mActivePasswordLength = length;
                        p.mActivePasswordLetters = letters;
                        p.mActivePasswordLowerCase = lowercase;
                        p.mActivePasswordUpperCase = uppercase;
                        p.mActivePasswordNumeric = numbers;
                        p.mActivePasswordSymbols = symbols;
                        p.mActivePasswordNonLetter = nonletter;
                        p.mFailedPasswordAttempts = 0;
                        saveSettingsLocked(userHandle);
                        updatePasswordExpirationsLocked(userHandle);
                        setExpirationAlarmCheckLocked(this.mContext, p);
                        sendAdminCommandToSelfAndProfilesLocked("android.app.action.ACTION_PASSWORD_CHANGED", 0, userHandle);
                    } finally {
                        Binder.restoreCallingIdentity(ident);
                    }
                }
            }
        }
    }

    private void updatePasswordExpirationsLocked(int userHandle) {
        for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
            int profileId = userInfo.id;
            DevicePolicyData policy = getUserDataUnchecked(profileId);
            int N = policy.mAdminList.size();
            if (N > 0) {
                for (int i = 0; i < N; i++) {
                    ActiveAdmin admin = (ActiveAdmin) policy.mAdminList.get(i);
                    if (admin.info.usesPolicy(6)) {
                        long timeout = admin.passwordExpirationTimeout;
                        admin.passwordExpirationDate = timeout > 0 ? timeout + System.currentTimeMillis() : 0;
                    }
                }
            }
            saveSettingsLocked(profileId);
        }
    }

    public void reportFailedPasswordAttempt(int userHandle) {
        int max = 0;
        enforceCrossUserPermission(userHandle);
        enforceNotManagedProfile(userHandle, "report failed password attempt");
        this.mContext.enforceCallingOrSelfPermission("android.permission.BIND_DEVICE_ADMIN", null);
        long ident = Binder.clearCallingIdentity();
        boolean wipeData = DBG;
        int identifier = 0;
        try {
            synchronized (this) {
                DevicePolicyData policy = getUserData(userHandle);
                policy.mFailedPasswordAttempts++;
                saveSettingsLocked(userHandle);
                if (this.mHasFeature) {
                    ActiveAdmin strictestAdmin = getAdminWithMinimumFailedPasswordsForWipeLocked(userHandle);
                    if (strictestAdmin != null) {
                        max = strictestAdmin.maximumFailedPasswordsForWipe;
                    }
                    if (max > 0 && policy.mFailedPasswordAttempts >= max) {
                        wipeData = true;
                        identifier = strictestAdmin.getUserHandle().getIdentifier();
                    }
                    sendAdminCommandToSelfAndProfilesLocked("android.app.action.ACTION_PASSWORD_FAILED", 1, userHandle);
                }
            }
            if (wipeData) {
                wipeDeviceOrUserLocked(DBG, identifier, "reportFailedPasswordAttempt()");
            }
            Binder.restoreCallingIdentity(ident);
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void reportSuccessfulPasswordAttempt(int userHandle) {
        enforceCrossUserPermission(userHandle);
        this.mContext.enforceCallingOrSelfPermission("android.permission.BIND_DEVICE_ADMIN", null);
        synchronized (this) {
            DevicePolicyData policy = getUserData(userHandle);
            if (policy.mFailedPasswordAttempts != 0 || policy.mPasswordOwner >= 0) {
                long ident = Binder.clearCallingIdentity();
                try {
                    policy.mFailedPasswordAttempts = 0;
                    policy.mPasswordOwner = -1;
                    saveSettingsLocked(userHandle);
                    if (this.mHasFeature) {
                        sendAdminCommandToSelfAndProfilesLocked("android.app.action.ACTION_PASSWORD_SUCCEEDED", 1, userHandle);
                    }
                    Binder.restoreCallingIdentity(ident);
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(ident);
                }
            }
        }
    }

    public ComponentName setGlobalProxy(ComponentName who, String proxySpec, String exclusionList, int userHandle) {
        if (!this.mHasFeature) {
            return null;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            DevicePolicyData policy = getUserData(0);
            ActiveAdmin admin = getActiveAdminForCallerLocked(who, 5);
            for (ComponentName component : policy.mAdminMap.keySet()) {
                if (((ActiveAdmin) policy.mAdminMap.get(component)).specifiesGlobalProxy && !component.equals(who)) {
                    return component;
                }
            }
            if (UserHandle.getCallingUserId() != 0) {
                Slog.w(LOG_TAG, "Only the owner is allowed to set the global proxy. User " + userHandle + " is not permitted.");
                return null;
            }
            if (proxySpec == null) {
                admin.specifiesGlobalProxy = DBG;
                admin.globalProxySpec = null;
                admin.globalProxyExclusionList = null;
            } else {
                admin.specifiesGlobalProxy = true;
                admin.globalProxySpec = proxySpec;
                admin.globalProxyExclusionList = exclusionList;
            }
            long origId = Binder.clearCallingIdentity();
            try {
                resetGlobalProxyLocked(policy);
                return null;
            } finally {
                Binder.restoreCallingIdentity(origId);
            }
        }
    }

    public ComponentName getGlobalProxyAdmin(int userHandle) {
        ComponentName componentName = null;
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                DevicePolicyData policy = getUserData(0);
                int N = policy.mAdminList.size();
                for (int i = 0; i < N; i++) {
                    ActiveAdmin ap = (ActiveAdmin) policy.mAdminList.get(i);
                    if (ap.specifiesGlobalProxy) {
                        componentName = ap.info.getComponent();
                        break;
                    }
                }
            }
        }
        return componentName;
    }

    public void setRecommendedGlobalProxy(ComponentName who, ProxyInfo proxyInfo) {
        synchronized (this) {
            getActiveAdminForCallerLocked(who, -2);
        }
        long token = Binder.clearCallingIdentity();
        try {
            ((ConnectivityManager) this.mContext.getSystemService("connectivity")).setGlobalProxy(proxyInfo);
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    private void resetGlobalProxyLocked(DevicePolicyData policy) {
        int N = policy.mAdminList.size();
        for (int i = 0; i < N; i++) {
            ActiveAdmin ap = (ActiveAdmin) policy.mAdminList.get(i);
            if (ap.specifiesGlobalProxy) {
                saveGlobalProxyLocked(ap.globalProxySpec, ap.globalProxyExclusionList);
                return;
            }
        }
        saveGlobalProxyLocked(null, null);
    }

    private void saveGlobalProxyLocked(String proxySpec, String exclusionList) {
        if (exclusionList == null) {
            exclusionList = "";
        }
        if (proxySpec == null) {
            proxySpec = "";
        }
        String[] data = proxySpec.trim().split(":");
        int proxyPort = 8080;
        if (data.length > 1) {
            try {
                proxyPort = Integer.parseInt(data[1]);
            } catch (NumberFormatException e) {
            }
        }
        exclusionList = exclusionList.trim();
        ContentResolver res = this.mContext.getContentResolver();
        ProxyInfo proxyProperties = new ProxyInfo(data[0], proxyPort, exclusionList);
        if (proxyProperties.isValid()) {
            Global.putString(res, "global_http_proxy_host", data[0]);
            Global.putInt(res, "global_http_proxy_port", proxyPort);
            Global.putString(res, "global_http_proxy_exclusion_list", exclusionList);
            return;
        }
        Slog.e(LOG_TAG, "Invalid proxy properties, ignoring: " + proxyProperties.toString());
    }

    public int setStorageEncryption(ComponentName who, boolean encrypt, int userHandle) {
        int i = 0;
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                if (userHandle == 0) {
                    if (UserHandle.getCallingUserId() == 0) {
                        ActiveAdmin ap = getActiveAdminForCallerLocked(who, 7);
                        if (isEncryptionSupported()) {
                            if (ap.encryptionRequested != encrypt) {
                                ap.encryptionRequested = encrypt;
                                saveSettingsLocked(userHandle);
                            }
                            DevicePolicyData policy = getUserData(0);
                            boolean newRequested = DBG;
                            for (int i2 = 0; i2 < policy.mAdminList.size(); i2++) {
                                newRequested |= ((ActiveAdmin) policy.mAdminList.get(i2)).encryptionRequested;
                            }
                            setEncryptionRequested(newRequested);
                            i = newRequested ? 3 : 1;
                        }
                    }
                }
                Slog.w(LOG_TAG, "Only owner is allowed to set storage encryption. User " + UserHandle.getCallingUserId() + " is not permitted.");
            }
        }
        return i;
    }

    public boolean getStorageEncryption(ComponentName who, int userHandle) {
        if (!this.mHasFeature) {
            return DBG;
        }
        enforceCrossUserPermission(userHandle);
        synchronized (this) {
            if (who != null) {
                ActiveAdmin ap = getActiveAdminUncheckedLocked(who, userHandle);
                boolean z = ap != null ? ap.encryptionRequested : DBG;
                return z;
            }
            DevicePolicyData policy = getUserData(userHandle);
            int N = policy.mAdminList.size();
            for (int i = 0; i < N; i++) {
                if (((ActiveAdmin) policy.mAdminList.get(i)).encryptionRequested) {
                    return true;
                }
            }
            return DBG;
        }
    }

    public int getStorageEncryptionStatus(int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
        } else {
            enforceCrossUserPermission(userHandle);
        }
        return getEncryptionStatus();
    }

    private boolean isEncryptionSupported() {
        return getEncryptionStatus() != 0 ? true : DBG;
    }

    private int getEncryptionStatus() {
        int i = 1;
        if ("activated".equalsIgnoreCase(SystemProperties.get("vold.pfe", ""))) {
            return 0;
        }
        String status = SystemProperties.get("ro.crypto.state", "unsupported");
        if ("encrypted".equalsIgnoreCase(status)) {
            long token = Binder.clearCallingIdentity();
            try {
                if (LockPatternUtils.isDeviceEncrypted()) {
                    i = 3;
                }
                Binder.restoreCallingIdentity(token);
                return i;
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(token);
            }
        } else if ("unencrypted".equalsIgnoreCase(status)) {
            return 1;
        } else {
            return 0;
        }
    }

    private void setEncryptionRequested(boolean encrypt) {
    }

    public void setScreenCaptureDisabled(ComponentName who, int userHandle, boolean disabled) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, -1);
                if (ap.disableScreenCapture != disabled) {
                    ap.disableScreenCapture = disabled;
                    saveSettingsLocked(userHandle);
                    updateScreenCaptureDisabledInWindowManager(userHandle, disabled);
                }
            }
        }
    }

    public boolean getScreenCaptureDisabled(ComponentName who, int userHandle) {
        boolean z = DBG;
        if (this.mHasFeature) {
            synchronized (this) {
                if (who != null) {
                    ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                    if (admin != null) {
                        z = admin.disableScreenCapture;
                    }
                } else {
                    DevicePolicyData policy = getUserData(userHandle);
                    int N = policy.mAdminList.size();
                    for (int i = 0; i < N; i++) {
                        if (((ActiveAdmin) policy.mAdminList.get(i)).disableScreenCapture) {
                            z = true;
                            break;
                        }
                    }
                }
            }
        }
        return z;
    }

    private void updateScreenCaptureDisabledInWindowManager(int userHandle, boolean disabled) {
        long ident = Binder.clearCallingIdentity();
        try {
            getWindowManager().setScreenCaptureDisabled(userHandle, disabled);
        } catch (RemoteException e) {
            Log.w(LOG_TAG, "Unable to notify WindowManager.", e);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void setAutoTimeRequired(ComponentName who, int userHandle, boolean required) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin admin = getActiveAdminForCallerLocked(who, -2);
                if (admin.requireAutoTime != required) {
                    admin.requireAutoTime = required;
                    saveSettingsLocked(userHandle);
                }
            }
            if (required) {
                long ident = Binder.clearCallingIdentity();
                try {
                    Global.putInt(this.mContext.getContentResolver(), "auto_time", 1);
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            }
        }
    }

    public boolean getAutoTimeRequired() {
        boolean z = DBG;
        if (this.mHasFeature) {
            synchronized (this) {
                ActiveAdmin deviceOwner = getDeviceOwnerAdmin();
                if (deviceOwner != null) {
                    z = deviceOwner.requireAutoTime;
                }
            }
        }
        return z;
    }

    public void setCameraDisabled(ComponentName who, boolean disabled, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 8);
                if (ap.disableCamera != disabled) {
                    ap.disableCamera = disabled;
                    saveSettingsLocked(userHandle);
                }
                syncDeviceCapabilitiesLocked(getUserData(userHandle));
            }
        }
    }

    public boolean getCameraDisabled(ComponentName who, int userHandle) {
        boolean z = DBG;
        if (this.mHasFeature) {
            synchronized (this) {
                if (who != null) {
                    ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                    if (admin != null) {
                        z = admin.disableCamera;
                    }
                } else {
                    DevicePolicyData policy = getUserData(userHandle);
                    int N = policy.mAdminList.size();
                    for (int i = 0; i < N; i++) {
                        if (((ActiveAdmin) policy.mAdminList.get(i)).disableCamera) {
                            z = true;
                            break;
                        }
                    }
                }
            }
        }
        return z;
    }

    public void setKeyguardDisabledFeatures(ComponentName who, int which, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            enforceNotManagedProfile(userHandle, "disable keyguard features");
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, 9);
                if (ap.disabledKeyguardFeatures != which) {
                    ap.disabledKeyguardFeatures = which;
                    saveSettingsLocked(userHandle);
                }
                syncDeviceCapabilitiesLocked(getUserData(userHandle));
            }
        }
    }

    public int getKeyguardDisabledFeatures(ComponentName who, int userHandle) {
        int i = 0;
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            synchronized (this) {
                if (who != null) {
                    ActiveAdmin admin = getActiveAdminUncheckedLocked(who, userHandle);
                    if (admin != null) {
                        i = admin.disabledKeyguardFeatures;
                    }
                } else {
                    DevicePolicyData policy = getUserData(userHandle);
                    i = 0;
                    for (int i2 = 0; i2 < policy.mAdminList.size(); i2++) {
                        i |= ((ActiveAdmin) policy.mAdminList.get(i2)).disabledKeyguardFeatures;
                    }
                }
            }
        }
        return i;
    }

    public boolean setDeviceOwner(String packageName, String ownerName) {
        if (!this.mHasFeature) {
            return DBG;
        }
        if (packageName == null || !DeviceOwner.isInstalled(packageName, this.mContext.getPackageManager())) {
            throw new IllegalArgumentException("Invalid package name " + packageName + " for device owner");
        }
        synchronized (this) {
            if (!allowedToSetDeviceOwnerOnDevice()) {
                throw new IllegalStateException("Trying to set device owner but device is already provisioned.");
            } else if (this.mDeviceOwner == null || !this.mDeviceOwner.hasDeviceOwner()) {
                long ident = Binder.clearCallingIdentity();
                try {
                    IBackupManager.Stub.asInterface(ServiceManager.getService("backup")).setBackupServiceActive(0, DBG);
                    Binder.restoreCallingIdentity(ident);
                    if (this.mDeviceOwner == null) {
                        this.mDeviceOwner = DeviceOwner.createWithDeviceOwner(packageName, ownerName);
                        this.mDeviceOwner.writeOwnerFile();
                        return true;
                    }
                    this.mDeviceOwner.setDeviceOwner(packageName, ownerName);
                    this.mDeviceOwner.writeOwnerFile();
                    return true;
                } catch (RemoteException e) {
                    throw new IllegalStateException("Failed deactivating backup service.", e);
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(ident);
                }
            } else {
                throw new IllegalStateException("Trying to set device owner but device owner is already set.");
            }
        }
    }

    public boolean isDeviceOwner(String packageName) {
        boolean z = DBG;
        if (this.mHasFeature) {
            synchronized (this) {
                if (this.mDeviceOwner != null && this.mDeviceOwner.hasDeviceOwner() && this.mDeviceOwner.getDeviceOwnerPackageName().equals(packageName)) {
                    z = true;
                }
            }
        }
        return z;
    }

    public String getDeviceOwner() {
        String str = null;
        if (this.mHasFeature) {
            synchronized (this) {
                if (this.mDeviceOwner == null || !this.mDeviceOwner.hasDeviceOwner()) {
                } else {
                    str = this.mDeviceOwner.getDeviceOwnerPackageName();
                }
            }
        }
        return str;
    }

    public String getDeviceOwnerName() {
        String str = null;
        if (this.mHasFeature) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USERS", null);
            synchronized (this) {
                if (this.mDeviceOwner != null) {
                    str = this.mDeviceOwner.getDeviceOwnerName();
                }
            }
        }
        return str;
    }

    private ActiveAdmin getDeviceOwnerAdmin() {
        String deviceOwnerPackageName = getDeviceOwner();
        if (deviceOwnerPackageName == null) {
            return null;
        }
        DevicePolicyData policy = getUserData(0);
        int n = policy.mAdminList.size();
        for (int i = 0; i < n; i++) {
            ActiveAdmin admin = (ActiveAdmin) policy.mAdminList.get(i);
            if (deviceOwnerPackageName.equals(admin.info.getPackageName())) {
                return admin;
            }
        }
        return null;
    }

    public void clearDeviceOwner(String packageName) {
        if (packageName == null) {
            throw new NullPointerException("packageName is null");
        }
        try {
            if (this.mContext.getPackageManager().getPackageUid(packageName, 0) != Binder.getCallingUid()) {
                throw new SecurityException("Invalid packageName");
            } else if (isDeviceOwner(packageName)) {
                synchronized (this) {
                    long ident = Binder.clearCallingIdentity();
                    try {
                        clearUserRestrictions(new UserHandle(0));
                        if (this.mDeviceOwner != null) {
                            this.mDeviceOwner.clearDeviceOwner();
                            this.mDeviceOwner.writeOwnerFile();
                        }
                        Binder.restoreCallingIdentity(ident);
                    } catch (Throwable th) {
                        Binder.restoreCallingIdentity(ident);
                    }
                }
            } else {
                throw new SecurityException("clearDeviceOwner can only be called by the device owner");
            }
        } catch (NameNotFoundException e) {
            throw new SecurityException(e);
        }
    }

    public boolean setProfileOwner(ComponentName who, String ownerName, int userHandle) {
        if (!this.mHasFeature) {
            return DBG;
        }
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USERS", null);
        UserInfo info = this.mUserManager.getUserInfo(userHandle);
        if (info == null) {
            throw new IllegalArgumentException("Attempted to set profile owner for invalid userId: " + userHandle);
        } else if (info.isGuest()) {
            throw new IllegalStateException("Cannot set a profile owner on a guest");
        } else if (who == null || !DeviceOwner.isInstalledForUser(who.getPackageName(), userHandle)) {
            throw new IllegalArgumentException("Component " + who + " not installed for userId:" + userHandle);
        } else {
            synchronized (this) {
                if (UserHandle.getAppId(Binder.getCallingUid()) != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && hasUserSetupCompleted(userHandle)) {
                    throw new IllegalStateException("Trying to set profile owner but user is already set-up.");
                } else if (this.mDeviceOwner == null) {
                    this.mDeviceOwner = DeviceOwner.createWithProfileOwner(who, ownerName, userHandle);
                    this.mDeviceOwner.writeOwnerFile();
                    return true;
                } else {
                    this.mDeviceOwner.setProfileOwner(who, ownerName, userHandle);
                    this.mDeviceOwner.writeOwnerFile();
                    return true;
                }
            }
        }
    }

    public void clearProfileOwner(ComponentName who) {
        if (this.mHasFeature) {
            UserHandle callingUser = Binder.getCallingUserHandle();
            getActiveAdminForCallerLocked(who, -1);
            synchronized (this) {
                long ident = Binder.clearCallingIdentity();
                try {
                    clearUserRestrictions(callingUser);
                    if (this.mDeviceOwner != null) {
                        this.mDeviceOwner.removeProfileOwner(callingUser.getIdentifier());
                        this.mDeviceOwner.writeOwnerFile();
                    }
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            }
        }
    }

    private void clearUserRestrictions(UserHandle userHandle) {
        AudioManager audioManager = (AudioManager) this.mContext.getSystemService("audio");
        Bundle userRestrictions = this.mUserManager.getUserRestrictions();
        this.mUserManager.setUserRestrictions(new Bundle(), userHandle);
        if (userRestrictions.getBoolean("no_adjust_volume")) {
            audioManager.setMasterMute(DBG);
        }
        if (userRestrictions.getBoolean("no_unmute_microphone")) {
            audioManager.setMicrophoneMute(DBG);
        }
    }

    public boolean hasUserSetupCompleted() {
        return hasUserSetupCompleted(UserHandle.getCallingUserId());
    }

    private boolean hasUserSetupCompleted(int userHandle) {
        if (!this.mHasFeature) {
            return true;
        }
        DevicePolicyData policy = getUserData(userHandle);
        if (policy == null || policy.mUserSetupComplete) {
            return true;
        }
        return DBG;
    }

    public void setProfileEnabled(ComponentName who) {
        if (this.mHasFeature) {
            int userHandle = UserHandle.getCallingUserId();
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                getActiveAdminForCallerLocked(who, -1);
                int userId = UserHandle.getCallingUserId();
                long id = Binder.clearCallingIdentity();
                try {
                    this.mUserManager.setUserEnabled(userId);
                    Intent intent = new Intent("android.intent.action.MANAGED_PROFILE_ADDED");
                    intent.putExtra("android.intent.extra.USER", new UserHandle(userHandle));
                    intent.addFlags(1342177280);
                    this.mContext.sendBroadcastAsUser(intent, UserHandle.OWNER);
                } finally {
                    restoreCallingIdentity(id);
                }
            }
        }
    }

    public void setProfileName(ComponentName who, String profileName) {
        int userId = UserHandle.getCallingUserId();
        if (who == null) {
            throw new NullPointerException("ComponentName is null");
        }
        getActiveAdminForCallerLocked(who, -1);
        long id = Binder.clearCallingIdentity();
        try {
            this.mUserManager.setUserName(userId, profileName);
        } finally {
            restoreCallingIdentity(id);
        }
    }

    public ComponentName getProfileOwner(int userHandle) {
        ComponentName componentName = null;
        if (this.mHasFeature) {
            synchronized (this) {
                if (this.mDeviceOwner != null) {
                    componentName = this.mDeviceOwner.getProfileOwnerComponent(userHandle);
                }
            }
        }
        return componentName;
    }

    private ActiveAdmin getProfileOwnerAdmin(int userHandle) {
        ComponentName profileOwner;
        if (this.mDeviceOwner != null) {
            profileOwner = this.mDeviceOwner.getProfileOwnerComponent(userHandle);
        } else {
            profileOwner = null;
        }
        if (profileOwner == null) {
            return null;
        }
        DevicePolicyData policy = getUserData(userHandle);
        int n = policy.mAdminList.size();
        for (int i = 0; i < n; i++) {
            ActiveAdmin admin = (ActiveAdmin) policy.mAdminList.get(i);
            if (profileOwner.equals(admin.info.getComponent())) {
                return admin;
            }
        }
        return null;
    }

    public String getProfileOwnerName(int userHandle) {
        String str = null;
        if (this.mHasFeature) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USERS", null);
            synchronized (this) {
                if (this.mDeviceOwner != null) {
                    str = this.mDeviceOwner.getProfileOwnerName(userHandle);
                }
            }
        }
        return str;
    }

    private boolean allowedToSetDeviceOwnerOnDevice() {
        int callingId = Binder.getCallingUid();
        if (callingId == 2000 || callingId == 0) {
            Account[] mAccounts = AccountManager.get(this.mContext).getAccounts();
            if (mAccounts.length == 0) {
                return true;
            }
            int i = mAccounts.length;
            for (Account account : mAccounts) {
                if (account.type.equals("com.qualcomm.qti.calendarlocalaccount") || account.type.equals("com.android.localphone") || account.type.equals("com.android.sim")) {
                    i--;
                }
            }
            if (i != 0) {
                return DBG;
            }
            return true;
        } else if (hasUserSetupCompleted(0)) {
            return DBG;
        } else {
            return true;
        }
    }

    private void enforceCrossUserPermission(int userHandle) {
        if (userHandle < 0) {
            throw new IllegalArgumentException("Invalid userId " + userHandle);
        }
        int callingUid = Binder.getCallingUid();
        if (userHandle != UserHandle.getUserId(callingUid) && callingUid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && callingUid != 0) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.INTERACT_ACROSS_USERS_FULL", "Must be system or have INTERACT_ACROSS_USERS_FULL permission");
        }
    }

    private void enforceSystemProcess(String message) {
        if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            throw new SecurityException(message);
        }
    }

    private void enforceNotManagedProfile(int userHandle, String message) {
        if (isManagedProfile(userHandle)) {
            throw new SecurityException("You can not " + message + " for a managed profile. ");
        }
    }

    private UserInfo getProfileParent(int userHandle) {
        long ident = Binder.clearCallingIdentity();
        try {
            UserInfo profileParent = this.mUserManager.getProfileParent(userHandle);
            return profileParent;
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private boolean isManagedProfile(int userHandle) {
        long ident = Binder.clearCallingIdentity();
        try {
            boolean isManagedProfile = this.mUserManager.getUserInfo(userHandle).isManagedProfile();
            return isManagedProfile;
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private void enableIfNecessary(String packageName, int userId) {
        try {
            IPackageManager ipm = AppGlobals.getPackageManager();
            if (ipm.getApplicationInfo(packageName, 32768, userId).enabledSetting == 4) {
                ipm.setApplicationEnabledSetting(packageName, 0, 1, userId, "DevicePolicyManager");
            }
        } catch (RemoteException e) {
        }
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump DevicePolicyManagerService from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            return;
        }
        Printer p = new PrintWriterPrinter(pw);
        synchronized (this) {
            p.println("Current Device Policy Manager state:");
            int userCount = this.mUserData.size();
            for (int u = 0; u < userCount; u++) {
                DevicePolicyData policy = getUserData(this.mUserData.keyAt(u));
                p.println("  Enabled Device Admins (User " + policy.mUserHandle + "):");
                int N = policy.mAdminList.size();
                for (int i = 0; i < N; i++) {
                    ActiveAdmin ap = (ActiveAdmin) policy.mAdminList.get(i);
                    if (ap != null) {
                        pw.print("  ");
                        pw.print(ap.info.getComponent().flattenToShortString());
                        pw.println(":");
                        ap.dump("    ", pw);
                    }
                }
                if (!policy.mRemovingAdmins.isEmpty()) {
                    p.println("  Removing Device Admins (User " + policy.mUserHandle + "): " + policy.mRemovingAdmins);
                }
                pw.println(" ");
                pw.print("  mPasswordOwner=");
                pw.println(policy.mPasswordOwner);
            }
        }
    }

    public void addPersistentPreferredActivity(ComponentName who, IntentFilter filter, ComponentName activity) {
        int userHandle = UserHandle.getCallingUserId();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            IPackageManager pm = AppGlobals.getPackageManager();
            long id = Binder.clearCallingIdentity();
            try {
                pm.addPersistentPreferredActivity(filter, activity, userHandle);
            } catch (RemoteException e) {
            } finally {
                restoreCallingIdentity(id);
            }
        }
    }

    public void clearPackagePersistentPreferredActivities(ComponentName who, String packageName) {
        int userHandle = UserHandle.getCallingUserId();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            IPackageManager pm = AppGlobals.getPackageManager();
            long id = Binder.clearCallingIdentity();
            try {
                pm.clearPackagePersistentPreferredActivities(packageName, userHandle);
            } catch (RemoteException e) {
            } finally {
                restoreCallingIdentity(id);
            }
        }
    }

    public void setApplicationRestrictions(ComponentName who, String packageName, Bundle settings) {
        UserHandle userHandle = new UserHandle(UserHandle.getCallingUserId());
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            long id = Binder.clearCallingIdentity();
            try {
                this.mUserManager.setApplicationRestrictions(packageName, settings, userHandle);
            } finally {
                restoreCallingIdentity(id);
            }
        }
    }

    public void setTrustAgentConfiguration(ComponentName admin, ComponentName agent, PersistableBundle args, int userHandle) {
        if (this.mHasFeature) {
            enforceCrossUserPermission(userHandle);
            enforceNotManagedProfile(userHandle, "set trust agent configuration");
            synchronized (this) {
                if (admin == null) {
                    throw new NullPointerException("admin is null");
                } else if (agent == null) {
                    throw new NullPointerException("agent is null");
                } else {
                    getActiveAdminForCallerLocked(admin, 9).trustAgentInfos.put(agent.flattenToString(), new TrustAgentInfo(args));
                    saveSettingsLocked(userHandle);
                    syncDeviceCapabilitiesLocked(getUserData(userHandle));
                }
            }
        }
    }

    public List<PersistableBundle> getTrustAgentConfiguration(ComponentName admin, ComponentName agent, int userHandle) {
        if (!this.mHasFeature) {
            return null;
        }
        enforceCrossUserPermission(userHandle);
        if (agent == null) {
            throw new NullPointerException("agent is null");
        }
        synchronized (this) {
            String componentName = agent.flattenToString();
            if (admin != null) {
                ActiveAdmin ap = getActiveAdminUncheckedLocked(admin, userHandle);
                if (ap == null) {
                    return null;
                }
                TrustAgentInfo trustAgentInfo = (TrustAgentInfo) ap.trustAgentInfos.get(componentName);
                if (trustAgentInfo == null || trustAgentInfo.options == null) {
                    return null;
                }
                List<PersistableBundle> result = new ArrayList();
                result.add(trustAgentInfo.options);
                return result;
            }
            result = null;
            boolean allAdminsHaveOptions = true;
            for (UserInfo userInfo : this.mUserManager.getProfiles(userHandle)) {
                DevicePolicyData policy = getUserDataUnchecked(userInfo.id);
                int N = policy.mAdminList.size();
                for (int i = 0; i < N; i++) {
                    ActiveAdmin active = (ActiveAdmin) policy.mAdminList.get(i);
                    boolean disablesTrust = (active.disabledKeyguardFeatures & 16) != 0 ? true : DBG;
                    TrustAgentInfo info = (TrustAgentInfo) active.trustAgentInfos.get(componentName);
                    if (!(info == null || info.options == null)) {
                        if (!info.options.isEmpty()) {
                            if (disablesTrust) {
                                if (result == null) {
                                    result = new ArrayList();
                                }
                                result.add(info.options);
                            } else {
                                Log.w(LOG_TAG, "Ignoring admin " + active.info + " because it has trust options but doesn't declare " + "KEYGUARD_DISABLE_TRUST_AGENTS");
                            }
                        }
                    }
                    if (disablesTrust) {
                        allAdminsHaveOptions = DBG;
                        break;
                    }
                }
            }
            if (!allAdminsHaveOptions) {
                result = null;
            }
            return result;
        }
    }

    public void setRestrictionsProvider(ComponentName who, ComponentName permissionProvider) {
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            int userHandle = UserHandle.getCallingUserId();
            getUserData(userHandle).mRestrictionsProvider = permissionProvider;
            saveSettingsLocked(userHandle);
        }
    }

    public ComponentName getRestrictionsProvider(int userHandle) {
        ComponentName componentName;
        synchronized (this) {
            if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                throw new SecurityException("Only the system can query the permission provider");
            }
            DevicePolicyData userData = getUserData(userHandle);
            componentName = userData != null ? userData.mRestrictionsProvider : null;
        }
        return componentName;
    }

    public void addCrossProfileIntentFilter(ComponentName who, IntentFilter filter, int flags) {
        int callingUserId = UserHandle.getCallingUserId();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            IPackageManager pm = AppGlobals.getPackageManager();
            long id = Binder.clearCallingIdentity();
            if ((flags & 1) != 0) {
                try {
                    pm.addCrossProfileIntentFilter(filter, who.getPackageName(), this.mContext.getUserId(), callingUserId, 0, 0);
                } catch (RemoteException e) {
                    restoreCallingIdentity(id);
                } catch (Throwable th) {
                    restoreCallingIdentity(id);
                }
            }
            if ((flags & 2) != 0) {
                pm.addCrossProfileIntentFilter(filter, who.getPackageName(), this.mContext.getUserId(), 0, callingUserId, 0);
            }
            restoreCallingIdentity(id);
        }
    }

    public void clearCrossProfileIntentFilters(ComponentName who) {
        int callingUserId = UserHandle.getCallingUserId();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            IPackageManager pm = AppGlobals.getPackageManager();
            long id = Binder.clearCallingIdentity();
            try {
                pm.clearCrossProfileIntentFilters(callingUserId, who.getPackageName(), callingUserId);
                pm.clearCrossProfileIntentFilters(0, who.getPackageName(), callingUserId);
            } catch (RemoteException e) {
            } finally {
                restoreCallingIdentity(id);
            }
        }
    }

    private boolean checkPackagesInPermittedListOrSystem(List<String> enabledPackages, List<String> permittedList) {
        int userIdToCheck = UserHandle.getCallingUserId();
        long id = Binder.clearCallingIdentity();
        UserInfo user = this.mUserManager.getUserInfo(userIdToCheck);
        if (user.isManagedProfile()) {
            userIdToCheck = user.profileGroupId;
        }
        IPackageManager pm = AppGlobals.getPackageManager();
        for (String enabledPackage : enabledPackages) {
            boolean systemService = DBG;
            try {
                systemService = (pm.getApplicationInfo(enabledPackage, DumpState.DUMP_INSTALLS, userIdToCheck).flags & 1) != 0 ? true : DBG;
            } catch (RemoteException e) {
                Log.i(LOG_TAG, "Can't talk to package managed", e);
            } catch (Throwable th) {
                restoreCallingIdentity(id);
            }
            if (!systemService) {
                if (!permittedList.contains(enabledPackage)) {
                    restoreCallingIdentity(id);
                    return DBG;
                }
            }
        }
        restoreCallingIdentity(id);
        return true;
    }

    private AccessibilityManager getAccessibilityManagerForUser(int userId) {
        IBinder iBinder = ServiceManager.getService("accessibility");
        return new AccessibilityManager(this.mContext, iBinder == null ? null : IAccessibilityManager.Stub.asInterface(iBinder), userId);
    }

    public boolean setPermittedAccessibilityServices(ComponentName who, List packageList) {
        if (!this.mHasFeature) {
            return DBG;
        }
        if (who == null) {
            throw new NullPointerException("ComponentName is null");
        }
        if (packageList != null) {
            int userId = UserHandle.getCallingUserId();
            List<AccessibilityServiceInfo> enabledServices = null;
            long id = Binder.clearCallingIdentity();
            try {
                UserInfo user = this.mUserManager.getUserInfo(userId);
                if (user.isManagedProfile()) {
                    userId = user.profileGroupId;
                }
                enabledServices = getAccessibilityManagerForUser(userId).getEnabledAccessibilityServiceList(-1);
                if (enabledServices != null) {
                    List<String> enabledPackages = new ArrayList();
                    for (AccessibilityServiceInfo service : enabledServices) {
                        enabledPackages.add(service.getResolveInfo().serviceInfo.packageName);
                    }
                    if (!checkPackagesInPermittedListOrSystem(enabledPackages, packageList)) {
                        Slog.e(LOG_TAG, "Cannot set permitted accessibility services, because it contains already enabled accesibility services.");
                        return DBG;
                    }
                }
            } finally {
                restoreCallingIdentity(id);
            }
        }
        synchronized (this) {
            getActiveAdminForCallerLocked(who, -1).permittedAccessiblityServices = packageList;
            saveSettingsLocked(UserHandle.getCallingUserId());
        }
        return true;
    }

    public List getPermittedAccessibilityServices(ComponentName who) {
        if (!this.mHasFeature) {
            return null;
        }
        if (who == null) {
            throw new NullPointerException("ComponentName is null");
        }
        List list;
        synchronized (this) {
            list = getActiveAdminForCallerLocked(who, -1).permittedAccessiblityServices;
        }
        return list;
    }

    public List getPermittedAccessibilityServicesForUser(int userId) {
        Throwable th;
        if (!this.mHasFeature) {
            return null;
        }
        synchronized (this) {
            List<String> result = null;
            try {
                List<UserInfo> profiles = this.mUserManager.getProfiles(userId);
                int PROFILES_SIZE = profiles.size();
                int i = 0;
                while (i < PROFILES_SIZE) {
                    DevicePolicyData policy = getUserDataUnchecked(((UserInfo) profiles.get(i)).id);
                    int N = policy.mAdminList.size();
                    int j = 0;
                    List<String> result2 = result;
                    while (j < N) {
                        try {
                            List<String> fromAdmin = ((ActiveAdmin) policy.mAdminList.get(j)).permittedAccessiblityServices;
                            if (fromAdmin != null) {
                                if (result2 == null) {
                                    List<String> arrayList = new ArrayList(fromAdmin);
                                    j++;
                                    result2 = result;
                                } else {
                                    result2.retainAll(fromAdmin);
                                }
                            }
                            result = result2;
                            j++;
                            result2 = result;
                        } catch (Throwable th2) {
                            th = th2;
                            result = result2;
                        }
                    }
                    i++;
                    result = result2;
                }
                if (result != null) {
                    long id = Binder.clearCallingIdentity();
                    try {
                        UserInfo user = this.mUserManager.getUserInfo(userId);
                        if (user.isManagedProfile()) {
                            userId = user.profileGroupId;
                        }
                        List<AccessibilityServiceInfo> installedServices = getAccessibilityManagerForUser(userId).getInstalledAccessibilityServiceList();
                        IPackageManager pm = AppGlobals.getPackageManager();
                        if (installedServices != null) {
                            for (AccessibilityServiceInfo service : installedServices) {
                                String packageName = service.getResolveInfo().serviceInfo.packageName;
                                if ((pm.getApplicationInfo(packageName, DumpState.DUMP_INSTALLS, userId).flags & 1) != 0) {
                                    result.add(packageName);
                                }
                            }
                        }
                        restoreCallingIdentity(id);
                    } catch (RemoteException e) {
                        Log.i(LOG_TAG, "Accessibility service in missing package", e);
                    } catch (Throwable th3) {
                        restoreCallingIdentity(id);
                    }
                }
                return result;
            } catch (Throwable th4) {
                th = th4;
                throw th;
            }
        }
    }

    private boolean checkCallerIsCurrentUserOrProfile() {
        int callingUserId = UserHandle.getCallingUserId();
        long token = Binder.clearCallingIdentity();
        try {
            UserInfo callingUser = this.mUserManager.getUserInfo(callingUserId);
            UserInfo currentUser = ActivityManagerNative.getDefault().getCurrentUser();
            if (callingUser.isManagedProfile() && callingUser.profileGroupId != currentUser.id) {
                Slog.e(LOG_TAG, "Cannot set permitted input methods for managed profile of a user that isn't the foreground user.");
                return DBG;
            } else if (callingUser.isManagedProfile() || callingUserId == currentUser.id) {
                Binder.restoreCallingIdentity(token);
                return true;
            } else {
                Slog.e(LOG_TAG, "Cannot set permitted input methods of a user that isn't the foreground user.");
                Binder.restoreCallingIdentity(token);
                return DBG;
            }
        } catch (RemoteException e) {
            Slog.e(LOG_TAG, "Failed to talk to activity managed.", e);
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public boolean setPermittedInputMethods(ComponentName who, List packageList) {
        if (!this.mHasFeature) {
            return DBG;
        }
        if (who == null) {
            throw new NullPointerException("ComponentName is null");
        } else if (!checkCallerIsCurrentUserOrProfile()) {
            return DBG;
        } else {
            if (packageList != null) {
                List<InputMethodInfo> enabledImes = ((InputMethodManager) this.mContext.getSystemService("input_method")).getEnabledInputMethodList();
                if (enabledImes != null) {
                    List<String> enabledPackages = new ArrayList();
                    for (InputMethodInfo ime : enabledImes) {
                        enabledPackages.add(ime.getPackageName());
                    }
                    if (!checkPackagesInPermittedListOrSystem(enabledPackages, packageList)) {
                        Slog.e(LOG_TAG, "Cannot set permitted input methods, because it contains already enabled input method.");
                        return DBG;
                    }
                }
            }
            synchronized (this) {
                getActiveAdminForCallerLocked(who, -1).permittedInputMethods = packageList;
                saveSettingsLocked(UserHandle.getCallingUserId());
            }
            return true;
        }
    }

    public List getPermittedInputMethods(ComponentName who) {
        if (!this.mHasFeature) {
            return null;
        }
        if (who == null) {
            throw new NullPointerException("ComponentName is null");
        }
        List list;
        synchronized (this) {
            list = getActiveAdminForCallerLocked(who, -1).permittedInputMethods;
        }
        return list;
    }

    public List getPermittedInputMethodsForCurrentUser() {
        Throwable th;
        try {
            int userId = ActivityManagerNative.getDefault().getCurrentUser().id;
            synchronized (this) {
                List<String> result = null;
                try {
                    List<UserInfo> profiles = this.mUserManager.getProfiles(userId);
                    int PROFILES_SIZE = profiles.size();
                    int i = 0;
                    while (i < PROFILES_SIZE) {
                        DevicePolicyData policy = getUserDataUnchecked(((UserInfo) profiles.get(i)).id);
                        int N = policy.mAdminList.size();
                        int j = 0;
                        List<String> result2 = result;
                        while (j < N) {
                            try {
                                List<String> fromAdmin = ((ActiveAdmin) policy.mAdminList.get(j)).permittedInputMethods;
                                if (fromAdmin != null) {
                                    if (result2 == null) {
                                        List<String> arrayList = new ArrayList(fromAdmin);
                                        j++;
                                        result2 = result;
                                    } else {
                                        result2.retainAll(fromAdmin);
                                    }
                                }
                                result = result2;
                                j++;
                                result2 = result;
                            } catch (Throwable th2) {
                                th = th2;
                                result = result2;
                            }
                        }
                        i++;
                        result = result2;
                    }
                    if (result != null) {
                        List<InputMethodInfo> imes = ((InputMethodManager) this.mContext.getSystemService("input_method")).getInputMethodList();
                        long id = Binder.clearCallingIdentity();
                        try {
                            IPackageManager pm = AppGlobals.getPackageManager();
                            if (imes != null) {
                                for (InputMethodInfo ime : imes) {
                                    String packageName = ime.getPackageName();
                                    if ((pm.getApplicationInfo(packageName, DumpState.DUMP_INSTALLS, userId).flags & 1) != 0) {
                                        result.add(packageName);
                                    }
                                }
                            }
                            restoreCallingIdentity(id);
                        } catch (RemoteException e) {
                            Log.i(LOG_TAG, "Input method for missing package", e);
                        } catch (Throwable th3) {
                            restoreCallingIdentity(id);
                        }
                    }
                    return result;
                } catch (Throwable th4) {
                    th = th4;
                    throw th;
                }
            }
        } catch (RemoteException e2) {
            Slog.e(LOG_TAG, "Failed to make remote calls to get current user", e2);
            return null;
        }
    }

    public UserHandle createUser(ComponentName who, String name) {
        UserHandle userHandle;
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -2);
            long id = Binder.clearCallingIdentity();
            try {
                UserInfo userInfo = this.mUserManager.createUser(name, 0);
                if (userInfo != null) {
                    userHandle = userInfo.getUserHandle();
                } else {
                    userHandle = null;
                    restoreCallingIdentity(id);
                }
            } finally {
                restoreCallingIdentity(id);
            }
        }
        return userHandle;
    }

    public UserHandle createAndInitializeUser(ComponentName who, String name, String ownerName, ComponentName profileOwnerComponent, Bundle adminExtras) {
        UserHandle user = createUser(who, name);
        if (user == null) {
            return null;
        }
        long id = Binder.clearCallingIdentity();
        try {
            String profileOwnerPkg = profileOwnerComponent.getPackageName();
            IPackageManager ipm = AppGlobals.getPackageManager();
            IActivityManager activityManager = ActivityManagerNative.getDefault();
            if (!ipm.isPackageAvailable(profileOwnerPkg, user.getIdentifier())) {
                ipm.installExistingPackageAsUser(profileOwnerPkg, user.getIdentifier());
            }
            activityManager.startUserInBackground(user.getIdentifier());
        } catch (RemoteException e) {
            Slog.e(LOG_TAG, "Failed to make remote calls for configureUser", e);
        } catch (Throwable th) {
            restoreCallingIdentity(id);
        }
        setActiveAdmin(profileOwnerComponent, true, user.getIdentifier(), adminExtras);
        setProfileOwner(profileOwnerComponent, ownerName, user.getIdentifier());
        restoreCallingIdentity(id);
        return user;
    }

    public boolean removeUser(ComponentName who, UserHandle userHandle) {
        boolean removeUser;
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -2);
            long id = Binder.clearCallingIdentity();
            try {
                removeUser = this.mUserManager.removeUser(userHandle.getIdentifier());
            } finally {
                restoreCallingIdentity(id);
            }
        }
        return removeUser;
    }

    public boolean switchUser(ComponentName who, UserHandle userHandle) {
        boolean z;
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -2);
            long id = Binder.clearCallingIdentity();
            int userId = 0;
            if (userHandle != null) {
                try {
                    userId = userHandle.getIdentifier();
                } catch (RemoteException e) {
                    Log.e(LOG_TAG, "Couldn't switch user", e);
                    z = DBG;
                } finally {
                    restoreCallingIdentity(id);
                }
            }
            z = ActivityManagerNative.getDefault().switchUser(userId);
            restoreCallingIdentity(id);
        }
        return z;
    }

    public Bundle getApplicationRestrictions(ComponentName who, String packageName) {
        Bundle applicationRestrictions;
        UserHandle userHandle = new UserHandle(UserHandle.getCallingUserId());
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            long id = Binder.clearCallingIdentity();
            try {
                applicationRestrictions = this.mUserManager.getApplicationRestrictions(packageName, userHandle);
            } finally {
                restoreCallingIdentity(id);
            }
        }
        return applicationRestrictions;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void setUserRestriction(android.content.ComponentName r25, java.lang.String r26, boolean r27) {
        /*
        r24 = this;
        r15 = new android.os.UserHandle;
        r17 = android.os.UserHandle.getCallingUserId();
        r0 = r17;
        r15.<init>(r0);
        r16 = r15.getIdentifier();
        monitor-enter(r24);
        if (r25 != 0) goto L_0x0021;
    L_0x0012:
        r17 = new java.lang.NullPointerException;	 Catch:{ all -> 0x001e }
        r20 = "ComponentName is null";
        r0 = r17;
        r1 = r20;
        r0.<init>(r1);	 Catch:{ all -> 0x001e }
        throw r17;	 Catch:{ all -> 0x001e }
    L_0x001e:
        r17 = move-exception;
        monitor-exit(r24);	 Catch:{ all -> 0x001e }
        throw r17;
    L_0x0021:
        r17 = -1;
        r0 = r24;
        r1 = r25;
        r2 = r17;
        r4 = r0.getActiveAdminForCallerLocked(r1, r2);	 Catch:{ all -> 0x001e }
        r0 = r4.info;	 Catch:{ all -> 0x001e }
        r17 = r0;
        r17 = r17.getPackageName();	 Catch:{ all -> 0x001e }
        r0 = r24;
        r1 = r17;
        r7 = r0.isDeviceOwner(r1);	 Catch:{ all -> 0x001e }
        if (r7 != 0) goto L_0x006e;
    L_0x003f:
        if (r16 == 0) goto L_0x006e;
    L_0x0041:
        r17 = DEVICE_OWNER_USER_RESTRICTIONS;	 Catch:{ all -> 0x001e }
        r0 = r17;
        r1 = r26;
        r17 = r0.contains(r1);	 Catch:{ all -> 0x001e }
        if (r17 == 0) goto L_0x006e;
    L_0x004d:
        r17 = new java.lang.SecurityException;	 Catch:{ all -> 0x001e }
        r20 = new java.lang.StringBuilder;	 Catch:{ all -> 0x001e }
        r20.<init>();	 Catch:{ all -> 0x001e }
        r21 = "Profile owners cannot set user restriction ";
        r20 = r20.append(r21);	 Catch:{ all -> 0x001e }
        r0 = r20;
        r1 = r26;
        r20 = r0.append(r1);	 Catch:{ all -> 0x001e }
        r20 = r20.toString();	 Catch:{ all -> 0x001e }
        r0 = r17;
        r1 = r20;
        r0.<init>(r1);	 Catch:{ all -> 0x001e }
        throw r17;	 Catch:{ all -> 0x001e }
    L_0x006e:
        r0 = r24;
        r0 = r0.mUserManager;	 Catch:{ all -> 0x001e }
        r17 = r0;
        r0 = r17;
        r1 = r26;
        r5 = r0.hasUserRestriction(r1, r15);	 Catch:{ all -> 0x001e }
        r6 = 0;
        r17 = "no_unmute_microphone";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ all -> 0x001e }
        if (r17 != 0) goto L_0x0095;
    L_0x0089:
        r17 = "no_adjust_volume";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ all -> 0x001e }
        if (r17 == 0) goto L_0x009f;
    L_0x0095:
        r17 = "audio";
        r17 = android.os.ServiceManager.getService(r17);	 Catch:{ all -> 0x001e }
        r6 = android.media.IAudioService.Stub.asInterface(r17);	 Catch:{ all -> 0x001e }
    L_0x009f:
        if (r27 == 0) goto L_0x00bc;
    L_0x00a1:
        if (r5 != 0) goto L_0x00bc;
    L_0x00a3:
        r17 = "no_unmute_microphone";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ RemoteException -> 0x019a }
        if (r17 == 0) goto L_0x0177;
    L_0x00af:
        r17 = 1;
        r20 = r25.getPackageName();	 Catch:{ RemoteException -> 0x019a }
        r0 = r17;
        r1 = r20;
        r6.setMicrophoneMute(r0, r1);	 Catch:{ RemoteException -> 0x019a }
    L_0x00bc:
        r8 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x001e }
        if (r27 == 0) goto L_0x00e9;
    L_0x00c2:
        if (r5 != 0) goto L_0x00e9;
    L_0x00c4:
        r17 = "no_config_wifi";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ all -> 0x01d3 }
        if (r17 == 0) goto L_0x01a8;
    L_0x00d0:
        r0 = r24;
        r0 = r0.mContext;	 Catch:{ all -> 0x01d3 }
        r17 = r0;
        r17 = r17.getContentResolver();	 Catch:{ all -> 0x01d3 }
        r20 = "wifi_networks_available_notification_on";
        r21 = 0;
        r0 = r17;
        r1 = r20;
        r2 = r21;
        r3 = r16;
        android.provider.Settings.Secure.putIntForUser(r0, r1, r2, r3);	 Catch:{ all -> 0x01d3 }
    L_0x00e9:
        r0 = r24;
        r0 = r0.mUserManager;	 Catch:{ all -> 0x01d3 }
        r17 = r0;
        r0 = r17;
        r1 = r26;
        r2 = r27;
        r0.setUserRestriction(r1, r2, r15);	 Catch:{ all -> 0x01d3 }
        r0 = r27;
        if (r0 == r5) goto L_0x014e;
    L_0x00fc:
        r17 = "no_share_location";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ all -> 0x01d3 }
        if (r17 == 0) goto L_0x014e;
    L_0x0108:
        r12 = "sys.settings_secure_version";
        r17 = "sys.settings_secure_version";
        r20 = 0;
        r0 = r17;
        r1 = r20;
        r20 = android.os.SystemProperties.getLong(r0, r1);	 Catch:{ all -> 0x01d3 }
        r22 = 1;
        r18 = r20 + r22;
        r17 = "sys.settings_secure_version";
        r20 = java.lang.Long.toString(r18);	 Catch:{ all -> 0x01d3 }
        r0 = r17;
        r1 = r20;
        android.os.SystemProperties.set(r0, r1);	 Catch:{ all -> 0x01d3 }
        r11 = "location_providers_allowed";
        r17 = android.provider.Settings.Secure.CONTENT_URI;	 Catch:{ all -> 0x01d3 }
        r20 = "location_providers_allowed";
        r0 = r17;
        r1 = r20;
        r14 = android.net.Uri.withAppendedPath(r0, r1);	 Catch:{ all -> 0x01d3 }
        r0 = r24;
        r0 = r0.mContext;	 Catch:{ all -> 0x01d3 }
        r17 = r0;
        r17 = r17.getContentResolver();	 Catch:{ all -> 0x01d3 }
        r20 = 0;
        r21 = 1;
        r0 = r17;
        r1 = r20;
        r2 = r21;
        r3 = r16;
        r0.notifyChange(r14, r1, r2, r3);	 Catch:{ all -> 0x01d3 }
    L_0x014e:
        restoreCallingIdentity(r8);	 Catch:{ all -> 0x001e }
        if (r27 != 0) goto L_0x016e;
    L_0x0153:
        if (r5 == 0) goto L_0x016e;
    L_0x0155:
        r17 = "no_unmute_microphone";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ RemoteException -> 0x02cb }
        if (r17 == 0) goto L_0x02a8;
    L_0x0161:
        r17 = 0;
        r20 = r25.getPackageName();	 Catch:{ RemoteException -> 0x02cb }
        r0 = r17;
        r1 = r20;
        r6.setMicrophoneMute(r0, r1);	 Catch:{ RemoteException -> 0x02cb }
    L_0x016e:
        r0 = r24;
        r1 = r16;
        r0.sendChangedNotification(r1);	 Catch:{ all -> 0x001e }
        monitor-exit(r24);	 Catch:{ all -> 0x001e }
        return;
    L_0x0177:
        r17 = "no_adjust_volume";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ RemoteException -> 0x019a }
        if (r17 == 0) goto L_0x00bc;
    L_0x0183:
        r17 = 1;
        r20 = 0;
        r21 = r25.getPackageName();	 Catch:{ RemoteException -> 0x019a }
        r22 = 0;
        r0 = r17;
        r1 = r20;
        r2 = r21;
        r3 = r22;
        r6.setMasterMute(r0, r1, r2, r3);	 Catch:{ RemoteException -> 0x019a }
        goto L_0x00bc;
    L_0x019a:
        r13 = move-exception;
        r17 = "DevicePolicyManagerService";
        r20 = "Failed to talk to AudioService.";
        r0 = r17;
        r1 = r20;
        android.util.Slog.e(r0, r1, r13);	 Catch:{ all -> 0x001e }
        goto L_0x00bc;
    L_0x01a8:
        r17 = "no_usb_file_transfer";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ all -> 0x01d3 }
        if (r17 == 0) goto L_0x01d8;
    L_0x01b4:
        r0 = r24;
        r0 = r0.mContext;	 Catch:{ all -> 0x01d3 }
        r17 = r0;
        r20 = "usb";
        r0 = r17;
        r1 = r20;
        r10 = r0.getSystemService(r1);	 Catch:{ all -> 0x01d3 }
        r10 = (android.hardware.usb.UsbManager) r10;	 Catch:{ all -> 0x01d3 }
        r17 = "none";
        r20 = 0;
        r0 = r17;
        r1 = r20;
        r10.setCurrentFunction(r0, r1);	 Catch:{ all -> 0x01d3 }
        goto L_0x00e9;
    L_0x01d3:
        r17 = move-exception;
        restoreCallingIdentity(r8);	 Catch:{ all -> 0x001e }
        throw r17;	 Catch:{ all -> 0x001e }
    L_0x01d8:
        r17 = "no_share_location";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ all -> 0x01d3 }
        if (r17 == 0) goto L_0x0218;
    L_0x01e4:
        r0 = r24;
        r0 = r0.mContext;	 Catch:{ all -> 0x01d3 }
        r17 = r0;
        r17 = r17.getContentResolver();	 Catch:{ all -> 0x01d3 }
        r20 = "location_mode";
        r21 = 0;
        r0 = r17;
        r1 = r20;
        r2 = r21;
        r3 = r16;
        android.provider.Settings.Secure.putIntForUser(r0, r1, r2, r3);	 Catch:{ all -> 0x01d3 }
        r0 = r24;
        r0 = r0.mContext;	 Catch:{ all -> 0x01d3 }
        r17 = r0;
        r17 = r17.getContentResolver();	 Catch:{ all -> 0x01d3 }
        r20 = "location_providers_allowed";
        r21 = "";
        r0 = r17;
        r1 = r20;
        r2 = r21;
        r3 = r16;
        android.provider.Settings.Secure.putStringForUser(r0, r1, r2, r3);	 Catch:{ all -> 0x01d3 }
        goto L_0x00e9;
    L_0x0218:
        r17 = "no_debugging_features";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ all -> 0x01d3 }
        if (r17 == 0) goto L_0x0241;
    L_0x0224:
        if (r16 != 0) goto L_0x00e9;
    L_0x0226:
        r0 = r24;
        r0 = r0.mContext;	 Catch:{ all -> 0x01d3 }
        r17 = r0;
        r17 = r17.getContentResolver();	 Catch:{ all -> 0x01d3 }
        r20 = "adb_enabled";
        r21 = "0";
        r0 = r17;
        r1 = r20;
        r2 = r21;
        r3 = r16;
        android.provider.Settings.Global.putStringForUser(r0, r1, r2, r3);	 Catch:{ all -> 0x01d3 }
        goto L_0x00e9;
    L_0x0241:
        r17 = "ensure_verify_apps";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ all -> 0x01d3 }
        if (r17 == 0) goto L_0x0281;
    L_0x024d:
        r0 = r24;
        r0 = r0.mContext;	 Catch:{ all -> 0x01d3 }
        r17 = r0;
        r17 = r17.getContentResolver();	 Catch:{ all -> 0x01d3 }
        r20 = "package_verifier_enable";
        r21 = "1";
        r0 = r17;
        r1 = r20;
        r2 = r21;
        r3 = r16;
        android.provider.Settings.Global.putStringForUser(r0, r1, r2, r3);	 Catch:{ all -> 0x01d3 }
        r0 = r24;
        r0 = r0.mContext;	 Catch:{ all -> 0x01d3 }
        r17 = r0;
        r17 = r17.getContentResolver();	 Catch:{ all -> 0x01d3 }
        r20 = "verifier_verify_adb_installs";
        r21 = "1";
        r0 = r17;
        r1 = r20;
        r2 = r21;
        r3 = r16;
        android.provider.Settings.Global.putStringForUser(r0, r1, r2, r3);	 Catch:{ all -> 0x01d3 }
        goto L_0x00e9;
    L_0x0281:
        r17 = "no_install_unknown_sources";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ all -> 0x01d3 }
        if (r17 == 0) goto L_0x00e9;
    L_0x028d:
        r0 = r24;
        r0 = r0.mContext;	 Catch:{ all -> 0x01d3 }
        r17 = r0;
        r17 = r17.getContentResolver();	 Catch:{ all -> 0x01d3 }
        r20 = "install_non_market_apps";
        r21 = 0;
        r0 = r17;
        r1 = r20;
        r2 = r21;
        r3 = r16;
        android.provider.Settings.Secure.putIntForUser(r0, r1, r2, r3);	 Catch:{ all -> 0x01d3 }
        goto L_0x00e9;
    L_0x02a8:
        r17 = "no_adjust_volume";
        r0 = r17;
        r1 = r26;
        r17 = r0.equals(r1);	 Catch:{ RemoteException -> 0x02cb }
        if (r17 == 0) goto L_0x016e;
    L_0x02b4:
        r17 = 0;
        r20 = 0;
        r21 = r25.getPackageName();	 Catch:{ RemoteException -> 0x02cb }
        r22 = 0;
        r0 = r17;
        r1 = r20;
        r2 = r21;
        r3 = r22;
        r6.setMasterMute(r0, r1, r2, r3);	 Catch:{ RemoteException -> 0x02cb }
        goto L_0x016e;
    L_0x02cb:
        r13 = move-exception;
        r17 = "DevicePolicyManagerService";
        r20 = "Failed to talk to AudioService.";
        r0 = r17;
        r1 = r20;
        android.util.Slog.e(r0, r1, r13);	 Catch:{ all -> 0x001e }
        goto L_0x016e;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.setUserRestriction(android.content.ComponentName, java.lang.String, boolean):void");
    }

    public boolean setApplicationHidden(ComponentName who, String packageName, boolean hidden) {
        boolean applicationHiddenSettingAsUser;
        int callingUserId = UserHandle.getCallingUserId();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            long id = Binder.clearCallingIdentity();
            try {
                applicationHiddenSettingAsUser = AppGlobals.getPackageManager().setApplicationHiddenSettingAsUser(packageName, hidden, callingUserId);
            } catch (RemoteException re) {
                applicationHiddenSettingAsUser = LOG_TAG;
                Slog.e(applicationHiddenSettingAsUser, "Failed to setApplicationHiddenSetting", re);
                applicationHiddenSettingAsUser = DBG;
                return applicationHiddenSettingAsUser;
            } finally {
                restoreCallingIdentity(id);
            }
        }
        return applicationHiddenSettingAsUser;
    }

    public boolean isApplicationHidden(ComponentName who, String packageName) {
        boolean applicationHiddenSettingAsUser;
        int callingUserId = UserHandle.getCallingUserId();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            long id = Binder.clearCallingIdentity();
            try {
                applicationHiddenSettingAsUser = AppGlobals.getPackageManager().getApplicationHiddenSettingAsUser(packageName, callingUserId);
            } catch (RemoteException re) {
                applicationHiddenSettingAsUser = LOG_TAG;
                Slog.e(applicationHiddenSettingAsUser, "Failed to getApplicationHiddenSettingAsUser", re);
                applicationHiddenSettingAsUser = DBG;
                return applicationHiddenSettingAsUser;
            } finally {
                restoreCallingIdentity(id);
            }
        }
        return applicationHiddenSettingAsUser;
    }

    public void enableSystemApp(ComponentName who, String packageName) {
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            int userId = UserHandle.getCallingUserId();
            long id = Binder.clearCallingIdentity();
            try {
                UserManager um = UserManager.get(this.mContext);
                UserInfo primaryUser = um.getProfileParent(userId);
                if (primaryUser == null) {
                    primaryUser = um.getUserInfo(userId);
                }
                IPackageManager pm = AppGlobals.getPackageManager();
                if (isSystemApp(pm, packageName, primaryUser.id)) {
                    pm.installExistingPackageAsUser(packageName, userId);
                } else {
                    throw new IllegalArgumentException("Only system apps can be enabled this way.");
                }
            } catch (RemoteException re) {
                Slog.wtf(LOG_TAG, "Failed to install " + packageName, re);
            } finally {
                restoreCallingIdentity(id);
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public int enableSystemAppWithIntent(android.content.ComponentName r17, android.content.Intent r18) {
        /*
        r16 = this;
        monitor-enter(r16);
        if (r17 != 0) goto L_0x000e;
    L_0x0003:
        r13 = new java.lang.NullPointerException;	 Catch:{ all -> 0x000b }
        r14 = "ComponentName is null";
        r13.<init>(r14);	 Catch:{ all -> 0x000b }
        throw r13;	 Catch:{ all -> 0x000b }
    L_0x000b:
        r13 = move-exception;
        monitor-exit(r16);	 Catch:{ all -> 0x000b }
        throw r13;
    L_0x000e:
        r13 = -1;
        r0 = r16;
        r1 = r17;
        r0.getActiveAdminForCallerLocked(r1, r13);	 Catch:{ all -> 0x000b }
        r12 = android.os.UserHandle.getCallingUserId();	 Catch:{ all -> 0x000b }
        r6 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x000b }
        r0 = r16;
        r13 = r0.mContext;	 Catch:{ RemoteException -> 0x0078 }
        r11 = android.os.UserManager.get(r13);	 Catch:{ RemoteException -> 0x0078 }
        r10 = r11.getProfileParent(r12);	 Catch:{ RemoteException -> 0x0078 }
        if (r10 != 0) goto L_0x0030;
    L_0x002c:
        r10 = r11.getUserInfo(r12);	 Catch:{ RemoteException -> 0x0078 }
    L_0x0030:
        r9 = android.app.AppGlobals.getPackageManager();	 Catch:{ RemoteException -> 0x0078 }
        r0 = r16;
        r13 = r0.mContext;	 Catch:{ RemoteException -> 0x0078 }
        r13 = r13.getContentResolver();	 Catch:{ RemoteException -> 0x0078 }
        r0 = r18;
        r13 = r0.resolveTypeIfNeeded(r13);	 Catch:{ RemoteException -> 0x0078 }
        r14 = 0;
        r15 = r10.id;	 Catch:{ RemoteException -> 0x0078 }
        r0 = r18;
        r2 = r9.queryIntentActivities(r0, r13, r14, r15);	 Catch:{ RemoteException -> 0x0078 }
        r8 = 0;
        if (r2 == 0) goto L_0x00a8;
    L_0x004e:
        r4 = r2.iterator();	 Catch:{ RemoteException -> 0x0078 }
    L_0x0052:
        r13 = r4.hasNext();	 Catch:{ RemoteException -> 0x0078 }
        if (r13 == 0) goto L_0x00a8;
    L_0x0058:
        r5 = r4.next();	 Catch:{ RemoteException -> 0x0078 }
        r5 = (android.content.pm.ResolveInfo) r5;	 Catch:{ RemoteException -> 0x0078 }
        r13 = r5.activityInfo;	 Catch:{ RemoteException -> 0x0078 }
        if (r13 == 0) goto L_0x0052;
    L_0x0062:
        r13 = r5.activityInfo;	 Catch:{ RemoteException -> 0x0078 }
        r13 = r13.packageName;	 Catch:{ RemoteException -> 0x0078 }
        r14 = r10.id;	 Catch:{ RemoteException -> 0x0078 }
        r0 = r16;
        r13 = r0.isSystemApp(r9, r13, r14);	 Catch:{ RemoteException -> 0x0078 }
        if (r13 != 0) goto L_0x0099;
    L_0x0070:
        r13 = new java.lang.IllegalArgumentException;	 Catch:{ RemoteException -> 0x0078 }
        r14 = "Only system apps can be enabled this way.";
        r13.<init>(r14);	 Catch:{ RemoteException -> 0x0078 }
        throw r13;	 Catch:{ RemoteException -> 0x0078 }
    L_0x0078:
        r3 = move-exception;
        r13 = "DevicePolicyManagerService";
        r14 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00a3 }
        r14.<init>();	 Catch:{ all -> 0x00a3 }
        r15 = "Failed to resolve intent for: ";
        r14 = r14.append(r15);	 Catch:{ all -> 0x00a3 }
        r0 = r18;
        r14 = r14.append(r0);	 Catch:{ all -> 0x00a3 }
        r14 = r14.toString();	 Catch:{ all -> 0x00a3 }
        android.util.Slog.wtf(r13, r14);	 Catch:{ all -> 0x00a3 }
        r8 = 0;
        restoreCallingIdentity(r6);	 Catch:{ all -> 0x000b }
        monitor-exit(r16);	 Catch:{ all -> 0x000b }
    L_0x0098:
        return r8;
    L_0x0099:
        r8 = r8 + 1;
        r13 = r5.activityInfo;	 Catch:{ RemoteException -> 0x0078 }
        r13 = r13.packageName;	 Catch:{ RemoteException -> 0x0078 }
        r9.installExistingPackageAsUser(r13, r12);	 Catch:{ RemoteException -> 0x0078 }
        goto L_0x0052;
    L_0x00a3:
        r13 = move-exception;
        restoreCallingIdentity(r6);	 Catch:{ all -> 0x000b }
        throw r13;	 Catch:{ all -> 0x000b }
    L_0x00a8:
        restoreCallingIdentity(r6);	 Catch:{ all -> 0x000b }
        monitor-exit(r16);	 Catch:{ all -> 0x000b }
        goto L_0x0098;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.enableSystemAppWithIntent(android.content.ComponentName, android.content.Intent):int");
    }

    private boolean isSystemApp(IPackageManager pm, String packageName, int userId) throws RemoteException {
        return (pm.getApplicationInfo(packageName, DumpState.DUMP_INSTALLS, userId).flags & 1) > 0 ? true : DBG;
    }

    public void setAccountManagementDisabled(ComponentName who, String accountType, boolean disabled) {
        if (this.mHasFeature) {
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin ap = getActiveAdminForCallerLocked(who, -1);
                if (disabled) {
                    ap.accountTypesWithManagementDisabled.add(accountType);
                } else {
                    ap.accountTypesWithManagementDisabled.remove(accountType);
                }
                saveSettingsLocked(UserHandle.getCallingUserId());
            }
        }
    }

    public String[] getAccountTypesWithManagementDisabled() {
        return getAccountTypesWithManagementDisabledAsUser(UserHandle.getCallingUserId());
    }

    public String[] getAccountTypesWithManagementDisabledAsUser(int userId) {
        enforceCrossUserPermission(userId);
        if (!this.mHasFeature) {
            return null;
        }
        String[] strArr;
        synchronized (this) {
            DevicePolicyData policy = getUserData(userId);
            int N = policy.mAdminList.size();
            HashSet<String> resultSet = new HashSet();
            for (int i = 0; i < N; i++) {
                resultSet.addAll(((ActiveAdmin) policy.mAdminList.get(i)).accountTypesWithManagementDisabled);
            }
            strArr = (String[]) resultSet.toArray(new String[resultSet.size()]);
        }
        return strArr;
    }

    public void setUninstallBlocked(ComponentName who, String packageName, boolean uninstallBlocked) {
        int userId = UserHandle.getCallingUserId();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            long id = Binder.clearCallingIdentity();
            try {
                AppGlobals.getPackageManager().setBlockUninstallForUser(packageName, uninstallBlocked, userId);
            } catch (RemoteException re) {
                Slog.e(LOG_TAG, "Failed to setBlockUninstallForUser", re);
            } finally {
                restoreCallingIdentity(id);
            }
        }
    }

    public boolean isUninstallBlocked(ComponentName who, String packageName) {
        boolean blockUninstallForUser;
        int userId = UserHandle.getCallingUserId();
        synchronized (this) {
            if (who != null) {
                getActiveAdminForCallerLocked(who, -1);
            }
            long id = Binder.clearCallingIdentity();
            try {
                blockUninstallForUser = AppGlobals.getPackageManager().getBlockUninstallForUser(packageName, userId);
                restoreCallingIdentity(id);
            } catch (RemoteException re) {
                Slog.e(LOG_TAG, "Failed to getBlockUninstallForUser", re);
                restoreCallingIdentity(id);
                return DBG;
            } catch (Throwable th) {
                restoreCallingIdentity(id);
            }
        }
        return blockUninstallForUser;
    }

    public void setCrossProfileCallerIdDisabled(ComponentName who, boolean disabled) {
        if (this.mHasFeature) {
            synchronized (this) {
                if (who == null) {
                    throw new NullPointerException("ComponentName is null");
                }
                ActiveAdmin admin = getActiveAdminForCallerLocked(who, -1);
                if (admin.disableCallerId != disabled) {
                    admin.disableCallerId = disabled;
                    saveSettingsLocked(UserHandle.getCallingUserId());
                }
            }
        }
    }

    public boolean getCrossProfileCallerIdDisabled(ComponentName who) {
        if (!this.mHasFeature) {
            return DBG;
        }
        boolean z;
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            z = getActiveAdminForCallerLocked(who, -1).disableCallerId;
        }
        return z;
    }

    public boolean getCrossProfileCallerIdDisabledForUser(int userId) {
        boolean z;
        synchronized (this) {
            ActiveAdmin admin = getProfileOwnerAdmin(userId);
            z = admin != null ? admin.disableCallerId : DBG;
        }
        return z;
    }

    public void setLockTaskPackages(ComponentName who, String[] packages) throws SecurityException {
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -2);
            int userHandle = Binder.getCallingUserHandle().getIdentifier();
            DevicePolicyData policy = getUserData(userHandle);
            policy.mLockTaskPackages.clear();
            if (packages != null) {
                for (String pkg : packages) {
                    policy.mLockTaskPackages.add(pkg);
                }
            }
            saveSettingsLocked(userHandle);
        }
    }

    public String[] getLockTaskPackages(ComponentName who) {
        String[] strArr;
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -2);
            strArr = (String[]) getUserData(Binder.getCallingUserHandle().getIdentifier()).mLockTaskPackages.toArray(new String[0]);
        }
        return strArr;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean isLockTaskPermitted(java.lang.String r7) {
        /*
        r6 = this;
        r3 = android.os.Binder.getCallingUid();
        r4 = android.os.UserHandle.getUserId(r3);
        r2 = r6.getUserData(r4);
        monitor-enter(r6);
        r0 = 0;
    L_0x000e:
        r5 = r2.mLockTaskPackages;	 Catch:{ all -> 0x002d }
        r5 = r5.size();	 Catch:{ all -> 0x002d }
        if (r0 >= r5) goto L_0x002a;
    L_0x0016:
        r5 = r2.mLockTaskPackages;	 Catch:{ all -> 0x002d }
        r1 = r5.get(r0);	 Catch:{ all -> 0x002d }
        r1 = (java.lang.String) r1;	 Catch:{ all -> 0x002d }
        r5 = r1.equals(r7);	 Catch:{ all -> 0x002d }
        if (r5 == 0) goto L_0x0027;
    L_0x0024:
        r5 = 1;
        monitor-exit(r6);	 Catch:{ all -> 0x002d }
    L_0x0026:
        return r5;
    L_0x0027:
        r0 = r0 + 1;
        goto L_0x000e;
    L_0x002a:
        monitor-exit(r6);	 Catch:{ all -> 0x002d }
        r5 = 0;
        goto L_0x0026;
    L_0x002d:
        r5 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x002d }
        throw r5;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.devicepolicy.DevicePolicyManagerService.isLockTaskPermitted(java.lang.String):boolean");
    }

    public void notifyLockTaskModeChanged(boolean isEnabled, String pkg, int userHandle) {
        if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            throw new SecurityException("notifyLockTaskModeChanged can only be called by system");
        }
        synchronized (this) {
            DevicePolicyData policy = getUserData(userHandle);
            Bundle adminExtras = new Bundle();
            adminExtras.putString("android.app.extra.LOCK_TASK_PACKAGE", pkg);
            Iterator i$ = policy.mAdminList.iterator();
            while (i$.hasNext()) {
                ActiveAdmin admin = (ActiveAdmin) i$.next();
                boolean ownsDevice = isDeviceOwner(admin.info.getPackageName());
                boolean ownsProfile = (getProfileOwner(userHandle) == null || !getProfileOwner(userHandle).equals(admin.info.getPackageName())) ? DBG : true;
                if (ownsDevice || ownsProfile) {
                    if (isEnabled) {
                        sendAdminCommandLocked(admin, "android.app.action.LOCK_TASK_ENTERING", adminExtras, null);
                    } else {
                        sendAdminCommandLocked(admin, "android.app.action.LOCK_TASK_EXITING");
                    }
                }
            }
        }
    }

    public void setGlobalSetting(ComponentName who, String setting, String value) {
        ContentResolver contentResolver = this.mContext.getContentResolver();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -2);
            if (GLOBAL_SETTINGS_WHITELIST.contains(setting)) {
                long id = Binder.clearCallingIdentity();
                try {
                    Global.putString(contentResolver, setting, value);
                } finally {
                    restoreCallingIdentity(id);
                }
            } else {
                throw new SecurityException(String.format("Permission denial: device owners cannot update %1$s", new Object[]{setting}));
            }
        }
    }

    public void setSecureSetting(ComponentName who, String setting, String value) {
        int callingUserId = UserHandle.getCallingUserId();
        ContentResolver contentResolver = this.mContext.getContentResolver();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            if (isDeviceOwner(getActiveAdminForCallerLocked(who, -1).info.getPackageName())) {
                if (!SECURE_SETTINGS_DEVICEOWNER_WHITELIST.contains(setting)) {
                    throw new SecurityException(String.format("Permission denial: Device owners cannot update %1$s", new Object[]{setting}));
                }
            } else if (!SECURE_SETTINGS_WHITELIST.contains(setting)) {
                throw new SecurityException(String.format("Permission denial: Profile owners cannot update %1$s", new Object[]{setting}));
            }
            long id = Binder.clearCallingIdentity();
            try {
                Secure.putStringForUser(contentResolver, setting, value, callingUserId);
            } finally {
                restoreCallingIdentity(id);
            }
        }
    }

    public void setMasterVolumeMuted(ComponentName who, boolean on) {
        ContentResolver contentResolver = this.mContext.getContentResolver();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            try {
                IAudioService.Stub.asInterface(ServiceManager.getService("audio")).setMasterMute(on, 0, who.getPackageName(), null);
            } catch (RemoteException re) {
                Slog.e(LOG_TAG, "Failed to setMasterMute", re);
            }
        }
    }

    public boolean isMasterVolumeMuted(ComponentName who) {
        boolean isMasterMute;
        ContentResolver contentResolver = this.mContext.getContentResolver();
        synchronized (this) {
            if (who == null) {
                throw new NullPointerException("ComponentName is null");
            }
            getActiveAdminForCallerLocked(who, -1);
            isMasterMute = ((AudioManager) this.mContext.getSystemService("audio")).isMasterMute();
        }
        return isMasterMute;
    }

    void updateUserSetupComplete() {
        List<UserInfo> users = this.mUserManager.getUsers(true);
        ContentResolver resolver = this.mContext.getContentResolver();
        int N = users.size();
        for (int i = 0; i < N; i++) {
            int userHandle = ((UserInfo) users.get(i)).id;
            if (Secure.getIntForUser(resolver, "user_setup_complete", 0, userHandle) != 0) {
                DevicePolicyData policy = getUserData(userHandle);
                if (policy.mUserSetupComplete) {
                    continue;
                } else {
                    policy.mUserSetupComplete = true;
                    synchronized (this) {
                        saveSettingsLocked(userHandle);
                    }
                }
            }
        }
    }
}
