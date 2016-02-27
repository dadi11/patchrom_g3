package com.android.server.accounts;

import android.accounts.Account;
import android.accounts.AccountAndUser;
import android.accounts.AccountAuthenticatorResponse;
import android.accounts.AuthenticatorDescription;
import android.accounts.CantAddAccountActivity;
import android.accounts.GrantCredentialsPermissionActivity;
import android.accounts.IAccountAuthenticator;
import android.accounts.IAccountAuthenticatorResponse;
import android.accounts.IAccountManager.Stub;
import android.accounts.IAccountManagerResponse;
import android.app.ActivityManager;
import android.app.ActivityManagerNative;
import android.app.AppGlobals;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.admin.DevicePolicyManager;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.RegisteredServicesCache.ServiceInfo;
import android.content.pm.RegisteredServicesCacheListener;
import android.content.pm.UserInfo;
import android.database.Cursor;
import android.database.DatabaseUtils;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Binder;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.Parcel;
import android.os.Process;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.UserManager;
import android.text.TextUtils;
import android.util.Log;
import android.util.Pair;
import android.util.Slog;
import android.util.SparseArray;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.IndentingPrintWriter;
import com.android.server.FgThread;
import com.google.android.collect.Lists;
import com.google.android.collect.Sets;
import java.io.File;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map.Entry;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

public class AccountManagerService extends Stub implements RegisteredServicesCacheListener<AuthenticatorDescription> {
    private static final Intent ACCOUNTS_CHANGED_INTENT;
    private static final String ACCOUNTS_ID = "_id";
    private static final String ACCOUNTS_NAME = "name";
    private static final String ACCOUNTS_PASSWORD = "password";
    private static final String ACCOUNTS_PREVIOUS_NAME = "previous_name";
    private static final String ACCOUNTS_TYPE = "type";
    private static final String ACCOUNTS_TYPE_COUNT = "count(type)";
    private static final String[] ACCOUNT_TYPE_COUNT_PROJECTION;
    private static final String AUTHTOKENS_ACCOUNTS_ID = "accounts_id";
    private static final String AUTHTOKENS_AUTHTOKEN = "authtoken";
    private static final String AUTHTOKENS_ID = "_id";
    private static final String AUTHTOKENS_TYPE = "type";
    private static final String[] COLUMNS_AUTHTOKENS_TYPE_AND_AUTHTOKEN;
    private static final String[] COLUMNS_EXTRAS_KEY_AND_VALUE;
    private static final String COUNT_OF_MATCHING_GRANTS = "SELECT COUNT(*) FROM grants, accounts WHERE accounts_id=_id AND uid=? AND auth_token_type=? AND name=? AND type=?";
    private static final String DATABASE_NAME = "accounts.db";
    private static final int DATABASE_VERSION = 6;
    private static final Account[] EMPTY_ACCOUNT_ARRAY;
    private static final String EXTRAS_ACCOUNTS_ID = "accounts_id";
    private static final String EXTRAS_ID = "_id";
    private static final String EXTRAS_KEY = "key";
    private static final String EXTRAS_VALUE = "value";
    private static final String GRANTS_ACCOUNTS_ID = "accounts_id";
    private static final String GRANTS_AUTH_TOKEN_TYPE = "auth_token_type";
    private static final String GRANTS_GRANTEE_UID = "uid";
    private static final int MESSAGE_COPY_SHARED_ACCOUNT = 4;
    private static final int MESSAGE_TIMED_OUT = 3;
    private static final String META_KEY = "key";
    private static final String META_VALUE = "value";
    private static final String SELECTION_AUTHTOKENS_BY_ACCOUNT = "accounts_id=(select _id FROM accounts WHERE name=? AND type=?)";
    private static final String SELECTION_USERDATA_BY_ACCOUNT = "accounts_id=(select _id FROM accounts WHERE name=? AND type=?)";
    private static final String TABLE_ACCOUNTS = "accounts";
    private static final String TABLE_AUTHTOKENS = "authtokens";
    private static final String TABLE_EXTRAS = "extras";
    private static final String TABLE_GRANTS = "grants";
    private static final String TABLE_META = "meta";
    private static final String TABLE_SHARED_ACCOUNTS = "shared_accounts";
    private static final String TAG = "AccountManagerService";
    private static final int TIMEOUT_DELAY_MS = 60000;
    private static AtomicReference<AccountManagerService> sThis;
    private final IAccountAuthenticatorCache mAuthenticatorCache;
    private final Context mContext;
    private final MessageHandler mMessageHandler;
    private final AtomicInteger mNotificationIds;
    private final PackageManager mPackageManager;
    private final LinkedHashMap<String, Session> mSessions;
    private UserManager mUserManager;
    private final SparseArray<UserAccounts> mUsers;

    private abstract class Session extends IAccountAuthenticatorResponse.Stub implements DeathRecipient, ServiceConnection {
        final String mAccountType;
        protected final UserAccounts mAccounts;
        IAccountAuthenticator mAuthenticator;
        final long mCreationTime;
        final boolean mExpectActivityLaunch;
        private int mNumErrors;
        private int mNumRequestContinued;
        public int mNumResults;
        IAccountManagerResponse mResponse;
        private final boolean mStripAuthTokenFromResult;

        public abstract void run() throws RemoteException;

        public Session(UserAccounts accounts, IAccountManagerResponse response, String accountType, boolean expectActivityLaunch, boolean stripAuthTokenFromResult) {
            this.mNumResults = 0;
            this.mNumRequestContinued = 0;
            this.mNumErrors = 0;
            this.mAuthenticator = null;
            if (accountType == null) {
                throw new IllegalArgumentException("accountType is null");
            }
            this.mAccounts = accounts;
            this.mStripAuthTokenFromResult = stripAuthTokenFromResult;
            this.mResponse = response;
            this.mAccountType = accountType;
            this.mExpectActivityLaunch = expectActivityLaunch;
            this.mCreationTime = SystemClock.elapsedRealtime();
            synchronized (AccountManagerService.this.mSessions) {
                AccountManagerService.this.mSessions.put(toString(), this);
            }
            if (response != null) {
                try {
                    response.asBinder().linkToDeath(this, 0);
                } catch (RemoteException e) {
                    this.mResponse = null;
                    binderDied();
                }
            }
        }

        IAccountManagerResponse getResponseAndClose() {
            if (this.mResponse == null) {
                return null;
            }
            IAccountManagerResponse response = this.mResponse;
            close();
            return response;
        }

        private void close() {
            synchronized (AccountManagerService.this.mSessions) {
                if (AccountManagerService.this.mSessions.remove(toString()) == null) {
                    return;
                }
                if (this.mResponse != null) {
                    this.mResponse.asBinder().unlinkToDeath(this, 0);
                    this.mResponse = null;
                }
                cancelTimeout();
                unbind();
            }
        }

        public void binderDied() {
            this.mResponse = null;
            close();
        }

        protected String toDebugString() {
            return toDebugString(SystemClock.elapsedRealtime());
        }

        protected String toDebugString(long now) {
            return "Session: expectLaunch " + this.mExpectActivityLaunch + ", connected " + (this.mAuthenticator != null) + ", stats (" + this.mNumResults + "/" + this.mNumRequestContinued + "/" + this.mNumErrors + ")" + ", lifetime " + (((double) (now - this.mCreationTime)) / 1000.0d);
        }

        void bind() {
            if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                Log.v(AccountManagerService.TAG, "initiating bind to authenticator type " + this.mAccountType);
            }
            if (!bindToAuthenticator(this.mAccountType)) {
                Log.d(AccountManagerService.TAG, "bind attempt failed for " + toDebugString());
                onError(1, "bind failure");
            }
        }

        private void unbind() {
            if (this.mAuthenticator != null) {
                this.mAuthenticator = null;
                AccountManagerService.this.mContext.unbindService(this);
            }
        }

        public void scheduleTimeout() {
            AccountManagerService.this.mMessageHandler.sendMessageDelayed(AccountManagerService.this.mMessageHandler.obtainMessage(AccountManagerService.MESSAGE_TIMED_OUT, this), 60000);
        }

        public void cancelTimeout() {
            AccountManagerService.this.mMessageHandler.removeMessages(AccountManagerService.MESSAGE_TIMED_OUT, this);
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            this.mAuthenticator = IAccountAuthenticator.Stub.asInterface(service);
            try {
                run();
            } catch (RemoteException e) {
                onError(1, "remote exception");
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            this.mAuthenticator = null;
            IAccountManagerResponse response = getResponseAndClose();
            if (response != null) {
                try {
                    response.onError(1, "disconnected");
                } catch (RemoteException e) {
                    if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                        Log.v(AccountManagerService.TAG, "Session.onServiceDisconnected: caught RemoteException while responding", e);
                    }
                }
            }
        }

        public void onTimedOut() {
            IAccountManagerResponse response = getResponseAndClose();
            if (response != null) {
                try {
                    response.onError(1, "timeout");
                } catch (RemoteException e) {
                    if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                        Log.v(AccountManagerService.TAG, "Session.onTimedOut: caught RemoteException while responding", e);
                    }
                }
            }
        }

        public void onResult(Bundle result) {
            IAccountManagerResponse response;
            this.mNumResults++;
            Intent intent = null;
            if (result != null) {
                intent = (Intent) result.getParcelable("intent");
                if (intent != null) {
                    int authenticatorUid = Binder.getCallingUid();
                    long bid = Binder.clearCallingIdentity();
                    try {
                        PackageManager pm = AccountManagerService.this.mContext.getPackageManager();
                        if (pm.checkSignatures(authenticatorUid, pm.resolveActivityAsUser(intent, 0, this.mAccounts.userId).activityInfo.applicationInfo.uid) != 0) {
                            throw new SecurityException("Activity to be started with KEY_INTENT must share Authenticator's signatures");
                        }
                    } finally {
                        Binder.restoreCallingIdentity(bid);
                    }
                }
            }
            if (result != null) {
                if (!TextUtils.isEmpty(result.getString(AccountManagerService.AUTHTOKENS_AUTHTOKEN))) {
                    String accountName = result.getString("authAccount");
                    String accountType = result.getString("accountType");
                    if (!(TextUtils.isEmpty(accountName) || TextUtils.isEmpty(accountType))) {
                        Account account = new Account(accountName, accountType);
                        AccountManagerService.this.cancelNotification(AccountManagerService.this.getSigninRequiredNotificationId(this.mAccounts, account).intValue(), new UserHandle(this.mAccounts.userId));
                    }
                }
            }
            if (this.mExpectActivityLaunch && result != null) {
                if (result.containsKey("intent")) {
                    response = this.mResponse;
                    if (response == null) {
                    }
                    if (result != null) {
                        try {
                            if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                                Log.v(AccountManagerService.TAG, getClass().getSimpleName() + " calling onError() on response " + response);
                            }
                            response.onError(5, "null bundle returned");
                        } catch (RemoteException e) {
                            if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                                Log.v(AccountManagerService.TAG, "failure while notifying response", e);
                                return;
                            }
                            return;
                        }
                    }
                    if (this.mStripAuthTokenFromResult) {
                        result.remove(AccountManagerService.AUTHTOKENS_AUTHTOKEN);
                    }
                    if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                        Log.v(AccountManagerService.TAG, getClass().getSimpleName() + " calling onResult() on response " + response);
                    }
                    if (result.getInt("errorCode", -1) > 0 || intent != null) {
                        response.onResult(result);
                        return;
                    }
                    response.onError(result.getInt("errorCode"), result.getString("errorMessage"));
                    return;
                }
            }
            response = getResponseAndClose();
            if (response == null) {
                if (result != null) {
                    if (this.mStripAuthTokenFromResult) {
                        result.remove(AccountManagerService.AUTHTOKENS_AUTHTOKEN);
                    }
                    if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                        Log.v(AccountManagerService.TAG, getClass().getSimpleName() + " calling onResult() on response " + response);
                    }
                    if (result.getInt("errorCode", -1) > 0) {
                    }
                    response.onResult(result);
                    return;
                }
                if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                    Log.v(AccountManagerService.TAG, getClass().getSimpleName() + " calling onError() on response " + response);
                }
                response.onError(5, "null bundle returned");
            }
        }

        public void onRequestContinued() {
            this.mNumRequestContinued++;
        }

        public void onError(int errorCode, String errorMessage) {
            this.mNumErrors++;
            IAccountManagerResponse response = getResponseAndClose();
            if (response != null) {
                if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                    Log.v(AccountManagerService.TAG, getClass().getSimpleName() + " calling onError() on response " + response);
                }
                try {
                    response.onError(errorCode, errorMessage);
                } catch (RemoteException e) {
                    if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                        Log.v(AccountManagerService.TAG, "Session.onError: caught RemoteException while responding", e);
                    }
                }
            } else if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                Log.v(AccountManagerService.TAG, "Session.onError: already closed");
            }
        }

        private boolean bindToAuthenticator(String authenticatorType) {
            ServiceInfo<AuthenticatorDescription> authenticatorInfo = AccountManagerService.this.mAuthenticatorCache.getServiceInfo(AuthenticatorDescription.newKey(authenticatorType), this.mAccounts.userId);
            if (authenticatorInfo != null) {
                Intent intent = new Intent();
                intent.setAction("android.accounts.AccountAuthenticator");
                intent.setComponent(authenticatorInfo.componentName);
                if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                    Log.v(AccountManagerService.TAG, "performing bindService to " + authenticatorInfo.componentName);
                }
                if (AccountManagerService.this.mContext.bindServiceAsUser(intent, this, 1, new UserHandle(this.mAccounts.userId))) {
                    return true;
                }
                if (!Log.isLoggable(AccountManagerService.TAG, 2)) {
                    return false;
                }
                Log.v(AccountManagerService.TAG, "bindService to " + authenticatorInfo.componentName + " failed");
                return false;
            } else if (!Log.isLoggable(AccountManagerService.TAG, 2)) {
                return false;
            } else {
                Log.v(AccountManagerService.TAG, "there is no authenticator for " + authenticatorType + ", bailing out");
                return false;
            }
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.10 */
    class AnonymousClass10 extends Session {
        final /* synthetic */ Account val$account;
        final /* synthetic */ String val$authTokenType;
        final /* synthetic */ Bundle val$loginOptions;

        AnonymousClass10(UserAccounts x0, IAccountManagerResponse x1, String x2, boolean x3, boolean x4, Account account, String str, Bundle bundle) {
            this.val$account = account;
            this.val$authTokenType = str;
            this.val$loginOptions = bundle;
            super(x0, x1, x2, x3, x4);
        }

        public void run() throws RemoteException {
            this.mAuthenticator.updateCredentials(this, this.val$account, this.val$authTokenType, this.val$loginOptions);
        }

        protected String toDebugString(long now) {
            if (this.val$loginOptions != null) {
                this.val$loginOptions.keySet();
            }
            return super.toDebugString(now) + ", updateCredentials" + ", " + this.val$account + ", authTokenType " + this.val$authTokenType + ", loginOptions " + this.val$loginOptions;
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.11 */
    class AnonymousClass11 extends Session {
        final /* synthetic */ String val$accountType;

        AnonymousClass11(UserAccounts x0, IAccountManagerResponse x1, String x2, boolean x3, boolean x4, String str) {
            this.val$accountType = str;
            super(x0, x1, x2, x3, x4);
        }

        public void run() throws RemoteException {
            this.mAuthenticator.editProperties(this, this.mAccountType);
        }

        protected String toDebugString(long now) {
            return super.toDebugString(now) + ", editProperties" + ", accountType " + this.val$accountType;
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.1 */
    class C01121 extends BroadcastReceiver {
        C01121() {
        }

        public void onReceive(Context context1, Intent intent) {
            if (!intent.getBooleanExtra("android.intent.extra.REPLACING", false)) {
                AccountManagerService.this.purgeOldGrantsAll();
            }
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.2 */
    class C01132 extends BroadcastReceiver {
        C01132() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if ("android.intent.action.USER_REMOVED".equals(action)) {
                AccountManagerService.this.onUserRemoved(intent);
            } else if ("android.intent.action.USER_STARTED".equals(action)) {
                AccountManagerService.this.onUserStarted(intent);
            }
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.3 */
    class C01143 extends Session {
        final /* synthetic */ Account val$account;
        final /* synthetic */ IAccountManagerResponse val$response;
        final /* synthetic */ UserAccounts val$toAccounts;

        C01143(UserAccounts x0, IAccountManagerResponse x1, String x2, boolean x3, boolean x4, Account account, IAccountManagerResponse iAccountManagerResponse, UserAccounts userAccounts) {
            this.val$account = account;
            this.val$response = iAccountManagerResponse;
            this.val$toAccounts = userAccounts;
            super(x0, x1, x2, x3, x4);
        }

        protected String toDebugString(long now) {
            return super.toDebugString(now) + ", getAccountCredentialsForClone" + ", " + this.val$account.type;
        }

        public void run() throws RemoteException {
            this.mAuthenticator.getAccountCredentialsForCloning(this, this.val$account);
        }

        public void onResult(Bundle result) {
            if (result == null || !result.getBoolean("booleanResult", false)) {
                super.onResult(result);
            } else {
                AccountManagerService.this.completeCloningAccount(this.val$response, result, this.val$account, this.val$toAccounts);
            }
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.4 */
    class C01154 extends Session {
        final /* synthetic */ Account val$account;
        final /* synthetic */ Bundle val$accountCredentials;

        C01154(UserAccounts x0, IAccountManagerResponse x1, String x2, boolean x3, boolean x4, Account account, Bundle bundle) {
            this.val$account = account;
            this.val$accountCredentials = bundle;
            super(x0, x1, x2, x3, x4);
        }

        protected String toDebugString(long now) {
            return super.toDebugString(now) + ", getAccountCredentialsForClone" + ", " + this.val$account.type;
        }

        public void run() throws RemoteException {
            synchronized (AccountManagerService.this.getUserAccounts(0).cacheLock) {
                for (Account acc : AccountManagerService.this.getAccounts(0)) {
                    if (acc.equals(this.val$account)) {
                        this.mAuthenticator.addAccountFromCredentials(this, this.val$account, this.val$accountCredentials);
                        break;
                    }
                }
            }
        }

        public void onResult(Bundle result) {
            super.onResult(result);
        }

        public void onError(int errorCode, String errorMessage) {
            super.onError(errorCode, errorMessage);
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.5 */
    class C01165 extends Session {
        final /* synthetic */ String val$accountType;
        final /* synthetic */ String val$authTokenType;

        C01165(UserAccounts x0, IAccountManagerResponse x1, String x2, boolean x3, boolean x4, String str, String str2) {
            this.val$accountType = str;
            this.val$authTokenType = str2;
            super(x0, x1, x2, x3, x4);
        }

        protected String toDebugString(long now) {
            return super.toDebugString(now) + ", getAuthTokenLabel" + ", " + this.val$accountType + ", authTokenType " + this.val$authTokenType;
        }

        public void run() throws RemoteException {
            this.mAuthenticator.getAuthTokenLabel(this, this.val$authTokenType);
        }

        public void onResult(Bundle result) {
            if (result != null) {
                String label = result.getString("authTokenLabelKey");
                Bundle bundle = new Bundle();
                bundle.putString("authTokenLabelKey", label);
                super.onResult(bundle);
                return;
            }
            super.onResult(result);
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.6 */
    class C01176 extends Session {
        final /* synthetic */ Account val$account;
        final /* synthetic */ UserAccounts val$accounts;
        final /* synthetic */ String val$authTokenType;
        final /* synthetic */ int val$callerUid;
        final /* synthetic */ boolean val$customTokens;
        final /* synthetic */ Bundle val$loginOptions;
        final /* synthetic */ boolean val$notifyOnAuthFailure;
        final /* synthetic */ boolean val$permissionGranted;

        C01176(UserAccounts x0, IAccountManagerResponse x1, String x2, boolean x3, boolean x4, Bundle bundle, Account account, String str, boolean z, boolean z2, int i, boolean z3, UserAccounts userAccounts) {
            this.val$loginOptions = bundle;
            this.val$account = account;
            this.val$authTokenType = str;
            this.val$notifyOnAuthFailure = z;
            this.val$permissionGranted = z2;
            this.val$callerUid = i;
            this.val$customTokens = z3;
            this.val$accounts = userAccounts;
            super(x0, x1, x2, x3, x4);
        }

        protected String toDebugString(long now) {
            if (this.val$loginOptions != null) {
                this.val$loginOptions.keySet();
            }
            return super.toDebugString(now) + ", getAuthToken" + ", " + this.val$account + ", authTokenType " + this.val$authTokenType + ", loginOptions " + this.val$loginOptions + ", notifyOnAuthFailure " + this.val$notifyOnAuthFailure;
        }

        public void run() throws RemoteException {
            if (this.val$permissionGranted) {
                this.mAuthenticator.getAuthToken(this, this.val$account, this.val$authTokenType, this.val$loginOptions);
            } else {
                this.mAuthenticator.getAuthTokenLabel(this, this.val$authTokenType);
            }
        }

        public void onResult(Bundle result) {
            if (result != null) {
                Intent intent;
                if (result.containsKey("authTokenLabelKey")) {
                    intent = AccountManagerService.this.newGrantCredentialsPermissionIntent(this.val$account, this.val$callerUid, new AccountAuthenticatorResponse(this), this.val$authTokenType, result.getString("authTokenLabelKey"));
                    Bundle bundle = new Bundle();
                    bundle.putParcelable("intent", intent);
                    onResult(bundle);
                    return;
                }
                String authToken = result.getString(AccountManagerService.AUTHTOKENS_AUTHTOKEN);
                if (authToken != null) {
                    String name = result.getString("authAccount");
                    String type = result.getString("accountType");
                    if (TextUtils.isEmpty(type) || TextUtils.isEmpty(name)) {
                        onError(5, "the type and name should not be empty");
                        return;
                    } else if (!this.val$customTokens) {
                        AccountManagerService.this.saveAuthTokenToDatabase(this.mAccounts, new Account(name, type), this.val$authTokenType, authToken);
                    }
                }
                intent = (Intent) result.getParcelable("intent");
                if (!(intent == null || !this.val$notifyOnAuthFailure || this.val$customTokens)) {
                    AccountManagerService.this.doNotification(this.mAccounts, this.val$account, result.getString("authFailedMessage"), intent, this.val$accounts.userId);
                }
            }
            super.onResult(result);
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.7 */
    class C01187 extends Session {
        final /* synthetic */ String val$accountType;
        final /* synthetic */ String val$authTokenType;
        final /* synthetic */ Bundle val$options;
        final /* synthetic */ String[] val$requiredFeatures;

        C01187(UserAccounts x0, IAccountManagerResponse x1, String x2, boolean x3, boolean x4, String str, String[] strArr, Bundle bundle, String str2) {
            this.val$authTokenType = str;
            this.val$requiredFeatures = strArr;
            this.val$options = bundle;
            this.val$accountType = str2;
            super(x0, x1, x2, x3, x4);
        }

        public void run() throws RemoteException {
            this.mAuthenticator.addAccount(this, this.mAccountType, this.val$authTokenType, this.val$requiredFeatures, this.val$options);
        }

        protected String toDebugString(long now) {
            return super.toDebugString(now) + ", addAccount" + ", accountType " + this.val$accountType + ", requiredFeatures " + (this.val$requiredFeatures != null ? TextUtils.join(",", this.val$requiredFeatures) : null);
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.8 */
    class C01198 extends Session {
        final /* synthetic */ String val$accountType;
        final /* synthetic */ String val$authTokenType;
        final /* synthetic */ Bundle val$options;
        final /* synthetic */ String[] val$requiredFeatures;

        C01198(UserAccounts x0, IAccountManagerResponse x1, String x2, boolean x3, boolean x4, String str, String[] strArr, Bundle bundle, String str2) {
            this.val$authTokenType = str;
            this.val$requiredFeatures = strArr;
            this.val$options = bundle;
            this.val$accountType = str2;
            super(x0, x1, x2, x3, x4);
        }

        public void run() throws RemoteException {
            this.mAuthenticator.addAccount(this, this.mAccountType, this.val$authTokenType, this.val$requiredFeatures, this.val$options);
        }

        protected String toDebugString(long now) {
            return super.toDebugString(now) + ", addAccount" + ", accountType " + this.val$accountType + ", requiredFeatures " + (this.val$requiredFeatures != null ? TextUtils.join(",", this.val$requiredFeatures) : null);
        }
    }

    /* renamed from: com.android.server.accounts.AccountManagerService.9 */
    class C01209 extends Session {
        final /* synthetic */ Account val$account;
        final /* synthetic */ Bundle val$options;

        C01209(UserAccounts x0, IAccountManagerResponse x1, String x2, boolean x3, boolean x4, Account account, Bundle bundle) {
            this.val$account = account;
            this.val$options = bundle;
            super(x0, x1, x2, x3, x4);
        }

        public void run() throws RemoteException {
            this.mAuthenticator.confirmCredentials(this, this.val$account, this.val$options);
        }

        protected String toDebugString(long now) {
            return super.toDebugString(now) + ", confirmCredentials" + ", " + this.val$account;
        }
    }

    static class DatabaseHelper extends SQLiteOpenHelper {
        public DatabaseHelper(Context context, int userId) {
            super(context, AccountManagerService.getDatabaseName(userId), null, AccountManagerService.DATABASE_VERSION);
        }

        public void onCreate(SQLiteDatabase db) {
            db.execSQL("CREATE TABLE accounts ( _id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, type TEXT NOT NULL, password TEXT, previous_name TEXT, UNIQUE(name,type))");
            db.execSQL("CREATE TABLE authtokens (  _id INTEGER PRIMARY KEY AUTOINCREMENT,  accounts_id INTEGER NOT NULL, type TEXT NOT NULL,  authtoken TEXT,  UNIQUE (accounts_id,type))");
            createGrantsTable(db);
            db.execSQL("CREATE TABLE extras ( _id INTEGER PRIMARY KEY AUTOINCREMENT, accounts_id INTEGER, key TEXT NOT NULL, value TEXT, UNIQUE(accounts_id,key))");
            db.execSQL("CREATE TABLE meta ( key TEXT PRIMARY KEY NOT NULL, value TEXT)");
            createSharedAccountsTable(db);
            createAccountsDeletionTrigger(db);
        }

        private void createSharedAccountsTable(SQLiteDatabase db) {
            db.execSQL("CREATE TABLE shared_accounts ( _id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, type TEXT NOT NULL, UNIQUE(name,type))");
        }

        private void addOldAccountNameColumn(SQLiteDatabase db) {
            db.execSQL("ALTER TABLE accounts ADD COLUMN previous_name");
        }

        private void createAccountsDeletionTrigger(SQLiteDatabase db) {
            db.execSQL(" CREATE TRIGGER accountsDelete DELETE ON accounts BEGIN   DELETE FROM authtokens     WHERE accounts_id=OLD._id ;   DELETE FROM extras     WHERE accounts_id=OLD._id ;   DELETE FROM grants     WHERE accounts_id=OLD._id ; END");
        }

        private void createGrantsTable(SQLiteDatabase db) {
            db.execSQL("CREATE TABLE grants (  accounts_id INTEGER NOT NULL, auth_token_type STRING NOT NULL,  uid INTEGER NOT NULL,  UNIQUE (accounts_id,auth_token_type,uid))");
        }

        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            Log.e(AccountManagerService.TAG, "upgrade from version " + oldVersion + " to version " + newVersion);
            if (oldVersion == 1) {
                oldVersion++;
            }
            if (oldVersion == 2) {
                createGrantsTable(db);
                db.execSQL("DROP TRIGGER accountsDelete");
                createAccountsDeletionTrigger(db);
                oldVersion++;
            }
            if (oldVersion == AccountManagerService.MESSAGE_TIMED_OUT) {
                db.execSQL("UPDATE accounts SET type = 'com.google' WHERE type == 'com.google.GAIA'");
                oldVersion++;
            }
            if (oldVersion == AccountManagerService.MESSAGE_COPY_SHARED_ACCOUNT) {
                createSharedAccountsTable(db);
                oldVersion++;
            }
            if (oldVersion == 5) {
                addOldAccountNameColumn(db);
                oldVersion++;
            }
            if (oldVersion != newVersion) {
                Log.e(AccountManagerService.TAG, "failed to upgrade version " + oldVersion + " to version " + newVersion);
            }
        }

        public void onOpen(SQLiteDatabase db) {
            if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                Log.v(AccountManagerService.TAG, "opened database accounts.db");
            }
        }
    }

    private class GetAccountsByTypeAndFeatureSession extends Session {
        private volatile Account[] mAccountsOfType;
        private volatile ArrayList<Account> mAccountsWithFeatures;
        private final int mCallingUid;
        private volatile int mCurrentAccount;
        private final String[] mFeatures;

        public GetAccountsByTypeAndFeatureSession(UserAccounts accounts, IAccountManagerResponse response, String type, String[] features, int callingUid) {
            super(accounts, response, type, false, true);
            this.mAccountsOfType = null;
            this.mAccountsWithFeatures = null;
            this.mCurrentAccount = 0;
            this.mCallingUid = callingUid;
            this.mFeatures = features;
        }

        public void run() throws RemoteException {
            synchronized (this.mAccounts.cacheLock) {
                this.mAccountsOfType = AccountManagerService.this.getAccountsFromCacheLocked(this.mAccounts, this.mAccountType, this.mCallingUid, null);
            }
            this.mAccountsWithFeatures = new ArrayList(this.mAccountsOfType.length);
            this.mCurrentAccount = 0;
            checkAccount();
        }

        public void checkAccount() {
            if (this.mCurrentAccount >= this.mAccountsOfType.length) {
                sendResult();
                return;
            }
            IAccountAuthenticator accountAuthenticator = this.mAuthenticator;
            if (accountAuthenticator != null) {
                try {
                    accountAuthenticator.hasFeatures(this, this.mAccountsOfType[this.mCurrentAccount], this.mFeatures);
                } catch (RemoteException e) {
                    onError(1, "remote exception");
                }
            } else if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                Log.v(AccountManagerService.TAG, "checkAccount: aborting session since we are no longer connected to the authenticator, " + toDebugString());
            }
        }

        public void onResult(Bundle result) {
            this.mNumResults++;
            if (result == null) {
                onError(5, "null bundle");
                return;
            }
            if (result.getBoolean("booleanResult", false)) {
                this.mAccountsWithFeatures.add(this.mAccountsOfType[this.mCurrentAccount]);
            }
            this.mCurrentAccount++;
            checkAccount();
        }

        public void sendResult() {
            IAccountManagerResponse response = getResponseAndClose();
            if (response != null) {
                try {
                    Account[] accounts = new Account[this.mAccountsWithFeatures.size()];
                    for (int i = 0; i < accounts.length; i++) {
                        accounts[i] = (Account) this.mAccountsWithFeatures.get(i);
                    }
                    if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                        Log.v(AccountManagerService.TAG, getClass().getSimpleName() + " calling onResult() on response " + response);
                    }
                    Bundle result = new Bundle();
                    result.putParcelableArray(AccountManagerService.TABLE_ACCOUNTS, accounts);
                    response.onResult(result);
                } catch (RemoteException e) {
                    if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                        Log.v(AccountManagerService.TAG, "failure while notifying response", e);
                    }
                }
            }
        }

        protected String toDebugString(long now) {
            return super.toDebugString(now) + ", getAccountsByTypeAndFeatures" + ", " + (this.mFeatures != null ? TextUtils.join(",", this.mFeatures) : null);
        }
    }

    private class MessageHandler extends Handler {
        MessageHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case AccountManagerService.MESSAGE_TIMED_OUT /*3*/:
                    msg.obj.onTimedOut();
                case AccountManagerService.MESSAGE_COPY_SHARED_ACCOUNT /*4*/:
                    AccountManagerService.this.copyAccountToUser(null, (Account) msg.obj, msg.arg1, msg.arg2);
                default:
                    throw new IllegalStateException("unhandled message: " + msg.what);
            }
        }
    }

    private class RemoveAccountSession extends Session {
        final Account mAccount;

        public RemoveAccountSession(UserAccounts accounts, IAccountManagerResponse response, Account account, boolean expectActivityLaunch) {
            super(accounts, response, account.type, expectActivityLaunch, true);
            this.mAccount = account;
        }

        protected String toDebugString(long now) {
            return super.toDebugString(now) + ", removeAccount" + ", account " + this.mAccount;
        }

        public void run() throws RemoteException {
            this.mAuthenticator.getAccountRemovalAllowed(this, this.mAccount);
        }

        public void onResult(Bundle result) {
            if (!(result == null || !result.containsKey("booleanResult") || result.containsKey("intent"))) {
                boolean removalAllowed = result.getBoolean("booleanResult");
                if (removalAllowed) {
                    AccountManagerService.this.removeAccountInternal(this.mAccounts, this.mAccount);
                }
                IAccountManagerResponse response = getResponseAndClose();
                if (response != null) {
                    if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                        Log.v(AccountManagerService.TAG, getClass().getSimpleName() + " calling onResult() on response " + response);
                    }
                    Bundle result2 = new Bundle();
                    result2.putBoolean("booleanResult", removalAllowed);
                    try {
                        response.onResult(result2);
                    } catch (RemoteException e) {
                    }
                }
            }
            super.onResult(result);
        }
    }

    private class TestFeaturesSession extends Session {
        private final Account mAccount;
        private final String[] mFeatures;

        public TestFeaturesSession(UserAccounts accounts, IAccountManagerResponse response, Account account, String[] features) {
            super(accounts, response, account.type, false, true);
            this.mFeatures = features;
            this.mAccount = account;
        }

        public void run() throws RemoteException {
            try {
                this.mAuthenticator.hasFeatures(this, this.mAccount, this.mFeatures);
            } catch (RemoteException e) {
                onError(1, "remote exception");
            }
        }

        public void onResult(Bundle result) {
            IAccountManagerResponse response = getResponseAndClose();
            if (response == null) {
                return;
            }
            if (result == null) {
                try {
                    response.onError(5, "null bundle");
                    return;
                } catch (RemoteException e) {
                    if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                        Log.v(AccountManagerService.TAG, "failure while notifying response", e);
                        return;
                    }
                    return;
                }
            }
            if (Log.isLoggable(AccountManagerService.TAG, 2)) {
                Log.v(AccountManagerService.TAG, getClass().getSimpleName() + " calling onResult() on response " + response);
            }
            Bundle newResult = new Bundle();
            newResult.putBoolean("booleanResult", result.getBoolean("booleanResult", false));
            response.onResult(newResult);
        }

        protected String toDebugString(long now) {
            return super.toDebugString(now) + ", hasFeatures" + ", " + this.mAccount + ", " + (this.mFeatures != null ? TextUtils.join(",", this.mFeatures) : null);
        }
    }

    static class UserAccounts {
        private final HashMap<String, Account[]> accountCache;
        private final HashMap<Account, HashMap<String, String>> authTokenCache;
        private final Object cacheLock;
        private final HashMap<Pair<Pair<Account, String>, Integer>, Integer> credentialsPermissionNotificationIds;
        private final DatabaseHelper openHelper;
        private final HashMap<Account, AtomicReference<String>> previousNameCache;
        private final HashMap<Account, Integer> signinRequiredNotificationIds;
        private final HashMap<Account, HashMap<String, String>> userDataCache;
        private final int userId;

        UserAccounts(Context context, int userId) {
            this.credentialsPermissionNotificationIds = new HashMap();
            this.signinRequiredNotificationIds = new HashMap();
            this.cacheLock = new Object();
            this.accountCache = new LinkedHashMap();
            this.userDataCache = new HashMap();
            this.authTokenCache = new HashMap();
            this.previousNameCache = new HashMap();
            this.userId = userId;
            synchronized (this.cacheLock) {
                this.openHelper = new DatabaseHelper(context, userId);
            }
        }
    }

    static {
        ACCOUNT_TYPE_COUNT_PROJECTION = new String[]{AUTHTOKENS_TYPE, ACCOUNTS_TYPE_COUNT};
        COLUMNS_AUTHTOKENS_TYPE_AND_AUTHTOKEN = new String[]{AUTHTOKENS_TYPE, AUTHTOKENS_AUTHTOKEN};
        COLUMNS_EXTRAS_KEY_AND_VALUE = new String[]{META_KEY, META_VALUE};
        sThis = new AtomicReference();
        EMPTY_ACCOUNT_ARRAY = new Account[0];
        ACCOUNTS_CHANGED_INTENT = new Intent("android.accounts.LOGIN_ACCOUNTS_CHANGED");
        ACCOUNTS_CHANGED_INTENT.setFlags(67108864);
    }

    public static AccountManagerService getSingleton() {
        return (AccountManagerService) sThis.get();
    }

    public AccountManagerService(Context context) {
        this(context, context.getPackageManager(), new AccountAuthenticatorCache(context));
    }

    public AccountManagerService(Context context, PackageManager packageManager, IAccountAuthenticatorCache authenticatorCache) {
        this.mSessions = new LinkedHashMap();
        this.mNotificationIds = new AtomicInteger(1);
        this.mUsers = new SparseArray();
        this.mContext = context;
        this.mPackageManager = packageManager;
        this.mMessageHandler = new MessageHandler(FgThread.get().getLooper());
        this.mAuthenticatorCache = authenticatorCache;
        this.mAuthenticatorCache.setListener(this, null);
        sThis.set(this);
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.PACKAGE_REMOVED");
        intentFilter.addDataScheme("package");
        this.mContext.registerReceiver(new C01121(), intentFilter);
        IntentFilter userFilter = new IntentFilter();
        userFilter.addAction("android.intent.action.USER_REMOVED");
        userFilter.addAction("android.intent.action.USER_STARTED");
        this.mContext.registerReceiverAsUser(new C01132(), UserHandle.ALL, userFilter, null, null);
    }

    public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
        try {
            return super.onTransact(code, data, reply, flags);
        } catch (RuntimeException e) {
            if (!(e instanceof SecurityException)) {
                Slog.wtf(TAG, "Account Manager Crash", e);
            }
            throw e;
        }
    }

    public void systemReady() {
    }

    private UserManager getUserManager() {
        if (this.mUserManager == null) {
            this.mUserManager = UserManager.get(this.mContext);
        }
        return this.mUserManager;
    }

    private UserAccounts initUserLocked(int userId) {
        UserAccounts accounts = (UserAccounts) this.mUsers.get(userId);
        if (accounts != null) {
            return accounts;
        }
        accounts = new UserAccounts(this.mContext, userId);
        this.mUsers.append(userId, accounts);
        purgeOldGrants(accounts);
        validateAccountsInternal(accounts, true);
        return accounts;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void purgeOldGrantsAll() {
        /*
        r3 = this;
        r2 = r3.mUsers;
        monitor-enter(r2);
        r0 = 0;
    L_0x0004:
        r1 = r3.mUsers;	 Catch:{ all -> 0x001c }
        r1 = r1.size();	 Catch:{ all -> 0x001c }
        if (r0 >= r1) goto L_0x001a;
    L_0x000c:
        r1 = r3.mUsers;	 Catch:{ all -> 0x001c }
        r1 = r1.valueAt(r0);	 Catch:{ all -> 0x001c }
        r1 = (com.android.server.accounts.AccountManagerService.UserAccounts) r1;	 Catch:{ all -> 0x001c }
        r3.purgeOldGrants(r1);	 Catch:{ all -> 0x001c }
        r0 = r0 + 1;
        goto L_0x0004;
    L_0x001a:
        monitor-exit(r2);	 Catch:{ all -> 0x001c }
        return;
    L_0x001c:
        r1 = move-exception;
        monitor-exit(r2);	 Catch:{ all -> 0x001c }
        throw r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.accounts.AccountManagerService.purgeOldGrantsAll():void");
    }

    private void purgeOldGrants(UserAccounts accounts) {
        synchronized (accounts.cacheLock) {
            SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
            Cursor cursor = db.query(TABLE_GRANTS, new String[]{GRANTS_GRANTEE_UID}, null, null, GRANTS_GRANTEE_UID, null, null);
            while (cursor.moveToNext()) {
                try {
                    boolean packageExists;
                    int uid = cursor.getInt(0);
                    if (this.mPackageManager.getPackagesForUid(uid) != null) {
                        packageExists = true;
                    } else {
                        packageExists = false;
                    }
                    if (!packageExists) {
                        Log.d(TAG, "deleting grants for UID " + uid + " because its package is no longer installed");
                        db.delete(TABLE_GRANTS, "uid=?", new String[]{Integer.toString(uid)});
                    }
                } catch (Throwable th) {
                    cursor.close();
                }
            }
            cursor.close();
        }
    }

    public void validateAccounts(int userId) {
        validateAccountsInternal(getUserAccounts(userId), true);
    }

    private void validateAccountsInternal(UserAccounts accounts, boolean invalidateAuthenticatorCache) {
        if (invalidateAuthenticatorCache) {
            this.mAuthenticatorCache.invalidateCache(accounts.userId);
        }
        HashSet<AuthenticatorDescription> knownAuth = Sets.newHashSet();
        for (ServiceInfo<AuthenticatorDescription> serviceInfo : this.mAuthenticatorCache.getAllServices(accounts.userId)) {
            knownAuth.add(serviceInfo.type);
        }
        synchronized (accounts.cacheLock) {
            SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
            boolean accountDeleted = false;
            String str = TABLE_ACCOUNTS;
            String[] strArr = new String[MESSAGE_TIMED_OUT];
            strArr[0] = EXTRAS_ID;
            strArr[1] = AUTHTOKENS_TYPE;
            strArr[2] = ACCOUNTS_NAME;
            Cursor cursor = db.query(str, strArr, null, null, null, null, EXTRAS_ID);
            try {
                String accountType;
                ArrayList<String> accountNames;
                accounts.accountCache.clear();
                HashMap<String, ArrayList<String>> accountNamesByType = new LinkedHashMap();
                while (cursor.moveToNext()) {
                    long accountId = cursor.getLong(0);
                    accountType = cursor.getString(1);
                    String accountName = cursor.getString(2);
                    if (knownAuth.contains(AuthenticatorDescription.newKey(accountType))) {
                        accountNames = (ArrayList) accountNamesByType.get(accountType);
                        if (accountNames == null) {
                            accountNames = new ArrayList();
                            accountNamesByType.put(accountType, accountNames);
                        }
                        accountNames.add(accountName);
                    } else {
                        Slog.w(TAG, "deleting account " + accountName + " because type " + accountType + " no longer has a registered authenticator");
                        db.delete(TABLE_ACCOUNTS, "_id=" + accountId, null);
                        accountDeleted = true;
                        Account account = new Account(accountName, accountType);
                        accounts.userDataCache.remove(account);
                        accounts.authTokenCache.remove(account);
                    }
                }
                for (Entry<String, ArrayList<String>> cur : accountNamesByType.entrySet()) {
                    accountType = (String) cur.getKey();
                    accountNames = (ArrayList) cur.getValue();
                    Object accountsForType = new Account[accountNames.size()];
                    int i = 0;
                    Iterator i$ = accountNames.iterator();
                    while (i$.hasNext()) {
                        accountsForType[i] = new Account((String) i$.next(), accountType);
                        i++;
                    }
                    accounts.accountCache.put(accountType, accountsForType);
                }
                cursor.close();
                if (accountDeleted) {
                    sendAccountsChangedBroadcast(accounts.userId);
                }
            } catch (Throwable th) {
                cursor.close();
                if (accountDeleted) {
                    sendAccountsChangedBroadcast(accounts.userId);
                }
            }
        }
    }

    private UserAccounts getUserAccountsForCaller() {
        return getUserAccounts(UserHandle.getCallingUserId());
    }

    protected UserAccounts getUserAccounts(int userId) {
        UserAccounts accounts;
        synchronized (this.mUsers) {
            accounts = (UserAccounts) this.mUsers.get(userId);
            if (accounts == null) {
                accounts = initUserLocked(userId);
                this.mUsers.append(userId, accounts);
            }
        }
        return accounts;
    }

    private void onUserRemoved(Intent intent) {
        int userId = intent.getIntExtra("android.intent.extra.user_handle", -1);
        if (userId >= 1) {
            UserAccounts accounts;
            synchronized (this.mUsers) {
                accounts = (UserAccounts) this.mUsers.get(userId);
                this.mUsers.remove(userId);
            }
            if (accounts == null) {
                new File(getDatabaseName(userId)).delete();
                return;
            }
            synchronized (accounts.cacheLock) {
                accounts.openHelper.close();
                new File(getDatabaseName(userId)).delete();
            }
        }
    }

    private void onUserStarted(Intent intent) {
        int userId = intent.getIntExtra("android.intent.extra.user_handle", -1);
        if (userId >= 1) {
            Account[] sharedAccounts = getSharedAccountsAsUser(userId);
            if (sharedAccounts != null && sharedAccounts.length != 0) {
                Account[] accounts = getAccountsAsUser(null, userId);
                for (Account sa : sharedAccounts) {
                    if (!ArrayUtils.contains(accounts, sa)) {
                        copyAccountToUser(null, sa, 0, userId);
                    }
                }
            }
        }
    }

    public void onServiceChanged(AuthenticatorDescription desc, int userId, boolean removed) {
        validateAccountsInternal(getUserAccounts(userId), false);
    }

    public String getPassword(Account account) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "getPassword: " + account + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        checkAuthenticateAccountsPermission(account);
        UserAccounts accounts = getUserAccountsForCaller();
        long identityToken = clearCallingIdentity();
        try {
            String readPasswordInternal = readPasswordInternal(accounts, account);
            return readPasswordInternal;
        } finally {
            restoreCallingIdentity(identityToken);
        }
    }

    private String readPasswordInternal(UserAccounts accounts, Account account) {
        if (account == null) {
            return null;
        }
        synchronized (accounts.cacheLock) {
            Cursor cursor = accounts.openHelper.getReadableDatabase().query(TABLE_ACCOUNTS, new String[]{ACCOUNTS_PASSWORD}, "name=? AND type=?", new String[]{account.name, account.type}, null, null, null);
            try {
                if (cursor.moveToNext()) {
                    String string = cursor.getString(0);
                    return string;
                }
                cursor.close();
                return null;
            } finally {
                cursor.close();
            }
        }
    }

    public String getPreviousName(Account account) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "getPreviousName: " + account + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        UserAccounts accounts = getUserAccountsForCaller();
        long identityToken = clearCallingIdentity();
        try {
            String readPreviousNameInternal = readPreviousNameInternal(accounts, account);
            return readPreviousNameInternal;
        } finally {
            restoreCallingIdentity(identityToken);
        }
    }

    private String readPreviousNameInternal(UserAccounts accounts, Account account) {
        if (account == null) {
            return null;
        }
        synchronized (accounts.cacheLock) {
            AtomicReference<String> previousNameRef = (AtomicReference) accounts.previousNameCache.get(account);
            if (previousNameRef == null) {
                Cursor cursor = accounts.openHelper.getReadableDatabase().query(TABLE_ACCOUNTS, new String[]{ACCOUNTS_PREVIOUS_NAME}, "name=? AND type=?", new String[]{account.name, account.type}, null, null, null);
                try {
                    if (cursor.moveToNext()) {
                        String previousName = cursor.getString(0);
                        AtomicReference<String> previousNameRef2 = new AtomicReference(previousName);
                        try {
                            accounts.previousNameCache.put(account, previousNameRef2);
                            cursor.close();
                            return previousName;
                        } catch (Throwable th) {
                            Throwable th2 = th;
                            previousNameRef = previousNameRef2;
                            cursor.close();
                            throw th2;
                        }
                    }
                    cursor.close();
                    return null;
                } catch (Throwable th3) {
                    th2 = th3;
                    cursor.close();
                    throw th2;
                }
            }
            String str = (String) previousNameRef.get();
            return str;
        }
    }

    public String getUserData(Account account, String key) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "getUserData: " + account + ", key " + key + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (key == null) {
            throw new IllegalArgumentException("key is null");
        } else {
            checkAuthenticateAccountsPermission(account);
            UserAccounts accounts = getUserAccountsForCaller();
            long identityToken = clearCallingIdentity();
            try {
                String readUserDataInternal = readUserDataInternal(accounts, account, key);
                return readUserDataInternal;
            } finally {
                restoreCallingIdentity(identityToken);
            }
        }
    }

    public AuthenticatorDescription[] getAuthenticatorTypes(int userId) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "getAuthenticatorTypes: for user id " + userId + "caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        enforceCrossUserPermission(userId, "User " + UserHandle.getCallingUserId() + " trying get authenticator types for " + userId);
        long identityToken = clearCallingIdentity();
        try {
            Collection<ServiceInfo<AuthenticatorDescription>> authenticatorCollection = this.mAuthenticatorCache.getAllServices(userId);
            AuthenticatorDescription[] types = new AuthenticatorDescription[authenticatorCollection.size()];
            int i = 0;
            for (ServiceInfo<AuthenticatorDescription> authenticator : authenticatorCollection) {
                types[i] = (AuthenticatorDescription) authenticator.type;
                i++;
            }
            return types;
        } finally {
            restoreCallingIdentity(identityToken);
        }
    }

    private void enforceCrossUserPermission(int userId, String errorMessage) {
        if (userId != UserHandle.getCallingUserId() && Binder.getCallingUid() != Process.myUid() && this.mContext.checkCallingOrSelfPermission("android.permission.INTERACT_ACROSS_USERS_FULL") != 0) {
            throw new SecurityException(errorMessage);
        }
    }

    public boolean addAccountExplicitly(Account account, String password, Bundle extras) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "addAccountExplicitly: " + account + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        checkAuthenticateAccountsPermission(account);
        UserAccounts accounts = getUserAccountsForCaller();
        long identityToken = clearCallingIdentity();
        try {
            boolean addAccountInternal = addAccountInternal(accounts, account, password, extras, false);
            return addAccountInternal;
        } finally {
            restoreCallingIdentity(identityToken);
        }
    }

    public void copyAccountToUser(IAccountManagerResponse response, Account account, int userFrom, int userTo) {
        enforceCrossUserPermission(-1, "Calling copyAccountToUser requires android.permission.INTERACT_ACROSS_USERS_FULL");
        UserAccounts fromAccounts = getUserAccounts(userFrom);
        UserAccounts toAccounts = getUserAccounts(userTo);
        if (fromAccounts != null && toAccounts != null) {
            Slog.d(TAG, "Copying account " + account.name + " from user " + userFrom + " to user " + userTo);
            long identityToken = clearCallingIdentity();
            try {
                new C01143(fromAccounts, response, account.type, false, false, account, response, toAccounts).bind();
            } finally {
                restoreCallingIdentity(identityToken);
            }
        } else if (response != null) {
            Bundle result = new Bundle();
            result.putBoolean("booleanResult", false);
            try {
                response.onResult(result);
            } catch (RemoteException e) {
                Slog.w(TAG, "Failed to report error back to the client." + e);
            }
        }
    }

    private void completeCloningAccount(IAccountManagerResponse response, Bundle accountCredentials, Account account, UserAccounts targetUser) {
        long id = clearCallingIdentity();
        try {
            new C01154(targetUser, response, account.type, false, false, account, accountCredentials).bind();
        } finally {
            restoreCallingIdentity(id);
        }
    }

    private boolean addAccountInternal(UserAccounts accounts, Account account, String password, Bundle extras, boolean restricted) {
        if (account == null) {
            return false;
        }
        synchronized (accounts.cacheLock) {
            SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
            db.beginTransaction();
            try {
                if (DatabaseUtils.longForQuery(db, "select count(*) from accounts WHERE name=? AND type=?", new String[]{account.name, account.type}) > 0) {
                    Log.w(TAG, "insertAccountIntoDatabase: " + account + ", skipping since the account already exists");
                    return false;
                }
                ContentValues values = new ContentValues();
                values.put(ACCOUNTS_NAME, account.name);
                values.put(AUTHTOKENS_TYPE, account.type);
                values.put(ACCOUNTS_PASSWORD, password);
                long accountId = db.insert(TABLE_ACCOUNTS, ACCOUNTS_NAME, values);
                if (accountId < 0) {
                    Log.w(TAG, "insertAccountIntoDatabase: " + account + ", skipping the DB insert failed");
                    db.endTransaction();
                    return false;
                }
                if (extras != null) {
                    for (String key : extras.keySet()) {
                        if (insertExtraLocked(db, accountId, key, extras.getString(key)) < 0) {
                            Log.w(TAG, "insertAccountIntoDatabase: " + account + ", skipping since insertExtra failed for key " + key);
                            db.endTransaction();
                            return false;
                        }
                    }
                }
                db.setTransactionSuccessful();
                insertAccountIntoCacheLocked(accounts, account);
                db.endTransaction();
                sendAccountsChangedBroadcast(accounts.userId);
                if (accounts.userId == 0) {
                    addAccountToLimitedUsers(account);
                }
                return true;
            } finally {
                db.endTransaction();
            }
        }
    }

    private void addAccountToLimitedUsers(Account account) {
        for (UserInfo user : getUserManager().getUsers()) {
            if (user.isRestricted()) {
                addSharedAccountAsUser(account, user.id);
                try {
                    if (ActivityManagerNative.getDefault().isUserRunning(user.id, false)) {
                        this.mMessageHandler.sendMessage(this.mMessageHandler.obtainMessage(MESSAGE_COPY_SHARED_ACCOUNT, 0, user.id, account));
                    }
                } catch (RemoteException e) {
                }
            }
        }
    }

    private long insertExtraLocked(SQLiteDatabase db, long accountId, String key, String value) {
        ContentValues values = new ContentValues();
        values.put(META_KEY, key);
        values.put(GRANTS_ACCOUNTS_ID, Long.valueOf(accountId));
        values.put(META_VALUE, value);
        return db.insert(TABLE_EXTRAS, META_KEY, values);
    }

    public void hasFeatures(IAccountManagerResponse response, Account account, String[] features) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "hasFeatures: " + account + ", response " + response + ", features " + stringArrayToString(features) + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (response == null) {
            throw new IllegalArgumentException("response is null");
        } else if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (features == null) {
            throw new IllegalArgumentException("features is null");
        } else {
            checkReadAccountsPermission();
            UserAccounts accounts = getUserAccountsForCaller();
            long identityToken = clearCallingIdentity();
            try {
                new TestFeaturesSession(accounts, response, account, features).bind();
            } finally {
                restoreCallingIdentity(identityToken);
            }
        }
    }

    public void renameAccount(IAccountManagerResponse response, Account accountToRename, String newName) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "renameAccount: " + accountToRename + " -> " + newName + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (accountToRename == null) {
            throw new IllegalArgumentException("account is null");
        }
        checkAuthenticateAccountsPermission(accountToRename);
        UserAccounts accounts = getUserAccountsForCaller();
        long identityToken = clearCallingIdentity();
        try {
            Account resultingAccount = renameAccountInternal(accounts, accountToRename, newName);
            Bundle result = new Bundle();
            result.putString("authAccount", resultingAccount.name);
            result.putString("accountType", resultingAccount.type);
            response.onResult(result);
        } catch (RemoteException e) {
            Log.w(TAG, e.getMessage());
        } catch (Throwable th) {
            restoreCallingIdentity(identityToken);
        }
        restoreCallingIdentity(identityToken);
    }

    private Account renameAccountInternal(UserAccounts accounts, Account accountToRename, String newName) {
        Account resultAccount = null;
        cancelNotification(getSigninRequiredNotificationId(accounts, accountToRename).intValue(), new UserHandle(accounts.userId));
        synchronized (accounts.credentialsPermissionNotificationIds) {
            for (Pair<Pair<Account, String>, Integer> pair : accounts.credentialsPermissionNotificationIds.keySet()) {
                if (accountToRename.equals(((Pair) pair.first).first)) {
                    cancelNotification(((Integer) accounts.credentialsPermissionNotificationIds.get(pair)).intValue(), new UserHandle(accounts.userId));
                }
            }
        }
        synchronized (accounts.cacheLock) {
            SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
            db.beginTransaction();
            boolean isSuccessful = false;
            Account renamedAccount = new Account(newName, accountToRename.type);
            HashMap<String, String> tmpData;
            HashMap<String, String> tmpTokens;
            try {
                ContentValues values = new ContentValues();
                values.put(ACCOUNTS_NAME, newName);
                values.put(ACCOUNTS_PREVIOUS_NAME, accountToRename.name);
                if (getAccountIdLocked(db, accountToRename) >= 0) {
                    String[] argsAccountId = new String[]{String.valueOf(getAccountIdLocked(db, accountToRename))};
                    db.update(TABLE_ACCOUNTS, values, "_id=?", argsAccountId);
                    db.setTransactionSuccessful();
                    isSuccessful = true;
                }
                db.endTransaction();
                if (isSuccessful) {
                    insertAccountIntoCacheLocked(accounts, renamedAccount);
                    tmpData = (HashMap) accounts.userDataCache.get(accountToRename);
                    tmpTokens = (HashMap) accounts.authTokenCache.get(accountToRename);
                    removeAccountFromCacheLocked(accounts, accountToRename);
                    accounts.userDataCache.put(renamedAccount, tmpData);
                    accounts.authTokenCache.put(renamedAccount, tmpTokens);
                    accounts.previousNameCache.put(renamedAccount, new AtomicReference(accountToRename.name));
                    resultAccount = renamedAccount;
                    if (accounts.userId == 0) {
                        for (UserInfo user : this.mUserManager.getUsers(true)) {
                            if (!user.isPrimary() && user.isRestricted()) {
                                renameSharedAccountAsUser(accountToRename, newName, user.id);
                            }
                        }
                    }
                    sendAccountsChangedBroadcast(accounts.userId);
                }
            } catch (Throwable th) {
                db.endTransaction();
                if (null != null) {
                    insertAccountIntoCacheLocked(accounts, renamedAccount);
                    tmpData = (HashMap) accounts.userDataCache.get(accountToRename);
                    tmpTokens = (HashMap) accounts.authTokenCache.get(accountToRename);
                    removeAccountFromCacheLocked(accounts, accountToRename);
                    accounts.userDataCache.put(renamedAccount, tmpData);
                    accounts.authTokenCache.put(renamedAccount, tmpTokens);
                    accounts.previousNameCache.put(renamedAccount, new AtomicReference(accountToRename.name));
                    resultAccount = renamedAccount;
                    if (accounts.userId == 0) {
                        for (UserInfo user2 : this.mUserManager.getUsers(true)) {
                            if (!user2.isPrimary() && user2.isRestricted()) {
                                renameSharedAccountAsUser(accountToRename, newName, user2.id);
                            }
                        }
                    }
                    sendAccountsChangedBroadcast(accounts.userId);
                }
            }
        }
        return resultAccount;
    }

    public void removeAccount(IAccountManagerResponse response, Account account, boolean expectActivityLaunch) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "removeAccount: " + account + ", response " + response + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (response == null) {
            throw new IllegalArgumentException("response is null");
        } else if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else {
            checkManageAccountsPermission();
            UserHandle user = Binder.getCallingUserHandle();
            UserAccounts accounts = getUserAccountsForCaller();
            int userId = Binder.getCallingUserHandle().getIdentifier();
            if (!canUserModifyAccounts(userId)) {
                try {
                    response.onError(DATABASE_VERSION, "User cannot modify accounts");
                } catch (RemoteException e) {
                }
            } else if (canUserModifyAccountsForType(userId, account.type)) {
                long identityToken = clearCallingIdentity();
                cancelNotification(getSigninRequiredNotificationId(accounts, account).intValue(), user);
                synchronized (accounts.credentialsPermissionNotificationIds) {
                    for (Pair<Pair<Account, String>, Integer> pair : accounts.credentialsPermissionNotificationIds.keySet()) {
                        if (account.equals(((Pair) pair.first).first)) {
                            cancelNotification(((Integer) accounts.credentialsPermissionNotificationIds.get(pair)).intValue(), user);
                        }
                    }
                }
                try {
                    new RemoveAccountSession(accounts, response, account, expectActivityLaunch).bind();
                } finally {
                    restoreCallingIdentity(identityToken);
                }
            } else {
                try {
                    response.onError(HdmiCecKeycode.CEC_KEYCODE_MUTE_FUNCTION, "User cannot modify accounts of this type (policy).");
                } catch (RemoteException e2) {
                }
            }
        }
    }

    public void removeAccountAsUser(IAccountManagerResponse response, Account account, boolean expectActivityLaunch, int userId) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "removeAccount: " + account + ", response " + response + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid() + ", for user id " + userId);
        }
        if (response == null) {
            throw new IllegalArgumentException("response is null");
        } else if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else {
            enforceCrossUserPermission(userId, "User " + UserHandle.getCallingUserId() + " trying to remove account for " + userId);
            checkManageAccountsPermission();
            UserAccounts accounts = getUserAccounts(userId);
            if (canUserModifyAccounts(userId)) {
                if (canUserModifyAccountsForType(userId, account.type)) {
                    UserHandle user = new UserHandle(userId);
                    long identityToken = clearCallingIdentity();
                    cancelNotification(getSigninRequiredNotificationId(accounts, account).intValue(), user);
                    synchronized (accounts.credentialsPermissionNotificationIds) {
                        for (Pair<Pair<Account, String>, Integer> pair : accounts.credentialsPermissionNotificationIds.keySet()) {
                            if (account.equals(((Pair) pair.first).first)) {
                                cancelNotification(((Integer) accounts.credentialsPermissionNotificationIds.get(pair)).intValue(), user);
                            }
                        }
                    }
                    try {
                        new RemoveAccountSession(accounts, response, account, expectActivityLaunch).bind();
                        return;
                    } finally {
                        restoreCallingIdentity(identityToken);
                    }
                } else {
                    try {
                        response.onError(HdmiCecKeycode.CEC_KEYCODE_MUTE_FUNCTION, "User cannot modify accounts of this type (policy).");
                        return;
                    } catch (RemoteException e) {
                        return;
                    }
                }
            }
            try {
                response.onError(100, "User cannot modify accounts");
            } catch (RemoteException e2) {
            }
        }
    }

    public boolean removeAccountExplicitly(Account account) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "removeAccountExplicitly: " + account + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        checkAuthenticateAccountsPermission(account);
        UserAccounts accounts = getUserAccountsForCaller();
        int userId = Binder.getCallingUserHandle().getIdentifier();
        if (!canUserModifyAccounts(userId) || !canUserModifyAccountsForType(userId, account.type)) {
            return false;
        }
        long identityToken = clearCallingIdentity();
        try {
            boolean removeAccountInternal = removeAccountInternal(accounts, account);
            return removeAccountInternal;
        } finally {
            restoreCallingIdentity(identityToken);
        }
    }

    protected void removeAccountInternal(Account account) {
        removeAccountInternal(getUserAccountsForCaller(), account);
    }

    private boolean removeAccountInternal(UserAccounts accounts, Account account) {
        int deleted;
        synchronized (accounts.cacheLock) {
            deleted = accounts.openHelper.getWritableDatabase().delete(TABLE_ACCOUNTS, "name=? AND type=?", new String[]{account.name, account.type});
            removeAccountFromCacheLocked(accounts, account);
            sendAccountsChangedBroadcast(accounts.userId);
        }
        if (accounts.userId == 0) {
            long id = Binder.clearCallingIdentity();
            try {
                for (UserInfo user : this.mUserManager.getUsers(true)) {
                    if (!user.isPrimary() && user.isRestricted()) {
                        removeSharedAccountAsUser(account, user.id);
                    }
                }
            } finally {
                Binder.restoreCallingIdentity(id);
            }
        }
        return deleted > 0;
    }

    public void invalidateAuthToken(String accountType, String authToken) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "invalidateAuthToken: accountType " + accountType + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (accountType == null) {
            throw new IllegalArgumentException("accountType is null");
        } else if (authToken == null) {
            throw new IllegalArgumentException("authToken is null");
        } else {
            checkManageAccountsOrUseCredentialsPermissions();
            UserAccounts accounts = getUserAccountsForCaller();
            long identityToken = clearCallingIdentity();
            try {
                synchronized (accounts.cacheLock) {
                    SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
                    db.beginTransaction();
                    try {
                        invalidateAuthTokenLocked(accounts, db, accountType, authToken);
                        db.setTransactionSuccessful();
                        db.endTransaction();
                    } catch (Throwable th) {
                        db.endTransaction();
                    }
                }
            } finally {
                restoreCallingIdentity(identityToken);
            }
        }
    }

    private void invalidateAuthTokenLocked(UserAccounts accounts, SQLiteDatabase db, String accountType, String authToken) {
        if (authToken != null && accountType != null) {
            Cursor cursor = db.rawQuery("SELECT authtokens._id, accounts.name, authtokens.type FROM accounts JOIN authtokens ON accounts._id = accounts_id WHERE authtoken = ? AND accounts.type = ?", new String[]{authToken, accountType});
            while (cursor.moveToNext()) {
                try {
                    long authTokenId = cursor.getLong(0);
                    String accountName = cursor.getString(1);
                    String authTokenType = cursor.getString(2);
                    db.delete(TABLE_AUTHTOKENS, "_id=" + authTokenId, null);
                    writeAuthTokenIntoCacheLocked(accounts, db, new Account(accountName, accountType), authTokenType, null);
                } finally {
                    cursor.close();
                }
            }
        }
    }

    private boolean saveAuthTokenToDatabase(UserAccounts accounts, Account account, String type, String authToken) {
        if (account == null || type == null) {
            return false;
        }
        cancelNotification(getSigninRequiredNotificationId(accounts, account).intValue(), new UserHandle(accounts.userId));
        synchronized (accounts.cacheLock) {
            SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
            db.beginTransaction();
            try {
                long accountId = getAccountIdLocked(db, account);
                if (accountId < 0) {
                    return false;
                }
                db.delete(TABLE_AUTHTOKENS, "accounts_id=" + accountId + " AND " + AUTHTOKENS_TYPE + "=?", new String[]{type});
                ContentValues values = new ContentValues();
                values.put(GRANTS_ACCOUNTS_ID, Long.valueOf(accountId));
                values.put(AUTHTOKENS_TYPE, type);
                values.put(AUTHTOKENS_AUTHTOKEN, authToken);
                if (db.insert(TABLE_AUTHTOKENS, AUTHTOKENS_AUTHTOKEN, values) >= 0) {
                    db.setTransactionSuccessful();
                    writeAuthTokenIntoCacheLocked(accounts, db, account, type, authToken);
                    db.endTransaction();
                    return true;
                }
                db.endTransaction();
                return false;
            } finally {
                db.endTransaction();
            }
        }
    }

    public String peekAuthToken(Account account, String authTokenType) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "peekAuthToken: " + account + ", authTokenType " + authTokenType + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (authTokenType == null) {
            throw new IllegalArgumentException("authTokenType is null");
        } else {
            checkAuthenticateAccountsPermission(account);
            UserAccounts accounts = getUserAccountsForCaller();
            long identityToken = clearCallingIdentity();
            try {
                String readAuthTokenInternal = readAuthTokenInternal(accounts, account, authTokenType);
                return readAuthTokenInternal;
            } finally {
                restoreCallingIdentity(identityToken);
            }
        }
    }

    public void setAuthToken(Account account, String authTokenType, String authToken) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "setAuthToken: " + account + ", authTokenType " + authTokenType + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (authTokenType == null) {
            throw new IllegalArgumentException("authTokenType is null");
        } else {
            checkAuthenticateAccountsPermission(account);
            UserAccounts accounts = getUserAccountsForCaller();
            long identityToken = clearCallingIdentity();
            try {
                saveAuthTokenToDatabase(accounts, account, authTokenType, authToken);
            } finally {
                restoreCallingIdentity(identityToken);
            }
        }
    }

    public void setPassword(Account account, String password) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "setAuthToken: " + account + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        checkAuthenticateAccountsPermission(account);
        UserAccounts accounts = getUserAccountsForCaller();
        long identityToken = clearCallingIdentity();
        try {
            setPasswordInternal(accounts, account, password);
        } finally {
            restoreCallingIdentity(identityToken);
        }
    }

    private void setPasswordInternal(UserAccounts accounts, Account account, String password) {
        if (account != null) {
            synchronized (accounts.cacheLock) {
                SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
                db.beginTransaction();
                try {
                    ContentValues values = new ContentValues();
                    values.put(ACCOUNTS_PASSWORD, password);
                    if (getAccountIdLocked(db, account) >= 0) {
                        String[] argsAccountId = new String[]{String.valueOf(getAccountIdLocked(db, account))};
                        db.update(TABLE_ACCOUNTS, values, "_id=?", argsAccountId);
                        db.delete(TABLE_AUTHTOKENS, "accounts_id=?", argsAccountId);
                        accounts.authTokenCache.remove(account);
                        db.setTransactionSuccessful();
                    }
                    sendAccountsChangedBroadcast(accounts.userId);
                } finally {
                    db.endTransaction();
                }
            }
        }
    }

    private void sendAccountsChangedBroadcast(int userId) {
        Log.i(TAG, "the accounts changed, sending broadcast of " + ACCOUNTS_CHANGED_INTENT.getAction());
        this.mContext.sendBroadcastAsUser(ACCOUNTS_CHANGED_INTENT, new UserHandle(userId));
    }

    public void clearPassword(Account account) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "clearPassword: " + account + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        checkManageAccountsPermission();
        UserAccounts accounts = getUserAccountsForCaller();
        long identityToken = clearCallingIdentity();
        try {
            setPasswordInternal(accounts, account, null);
        } finally {
            restoreCallingIdentity(identityToken);
        }
    }

    public void setUserData(Account account, String key, String value) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "setUserData: " + account + ", key " + key + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (key == null) {
            throw new IllegalArgumentException("key is null");
        } else if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else {
            checkAuthenticateAccountsPermission(account);
            UserAccounts accounts = getUserAccountsForCaller();
            long identityToken = clearCallingIdentity();
            try {
                setUserdataInternal(accounts, account, key, value);
            } finally {
                restoreCallingIdentity(identityToken);
            }
        }
    }

    private void setUserdataInternal(UserAccounts accounts, Account account, String key, String value) {
        if (account != null && key != null) {
            synchronized (accounts.cacheLock) {
                SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
                db.beginTransaction();
                try {
                    long accountId = getAccountIdLocked(db, account);
                    if (accountId < 0) {
                        return;
                    }
                    long extrasId = getExtrasIdLocked(db, accountId, key);
                    if (extrasId >= 0) {
                        ContentValues values = new ContentValues();
                        values.put(META_VALUE, value);
                        if (1 != db.update(TABLE_EXTRAS, values, "_id=" + extrasId, null)) {
                            db.endTransaction();
                            return;
                        }
                    } else if (insertExtraLocked(db, accountId, key, value) < 0) {
                        db.endTransaction();
                        return;
                    }
                    writeUserDataIntoCacheLocked(accounts, db, account, key, value);
                    db.setTransactionSuccessful();
                    db.endTransaction();
                } finally {
                    db.endTransaction();
                }
            }
        }
    }

    private void onResult(IAccountManagerResponse response, Bundle result) {
        if (result == null) {
            Log.e(TAG, "the result is unexpectedly null", new Exception());
        }
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, getClass().getSimpleName() + " calling onResult() on response " + response);
        }
        try {
            response.onResult(result);
        } catch (RemoteException e) {
            if (Log.isLoggable(TAG, 2)) {
                Log.v(TAG, "failure while notifying response", e);
            }
        }
    }

    public void getAuthTokenLabel(IAccountManagerResponse response, String accountType, String authTokenType) throws RemoteException {
        if (accountType == null) {
            throw new IllegalArgumentException("accountType is null");
        } else if (authTokenType == null) {
            throw new IllegalArgumentException("authTokenType is null");
        } else {
            int callingUid = getCallingUid();
            clearCallingIdentity();
            if (callingUid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                throw new SecurityException("can only call from system");
            }
            UserAccounts accounts = getUserAccounts(UserHandle.getUserId(callingUid));
            long identityToken = clearCallingIdentity();
            try {
                new C01165(accounts, response, accountType, false, false, accountType, authTokenType).bind();
            } finally {
                restoreCallingIdentity(identityToken);
            }
        }
    }

    public void getAuthToken(IAccountManagerResponse response, Account account, String authTokenType, boolean notifyOnAuthFailure, boolean expectActivityLaunch, Bundle loginOptionsIn) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "getAuthToken: " + account + ", response " + response + ", authTokenType " + authTokenType + ", notifyOnAuthFailure " + notifyOnAuthFailure + ", expectActivityLaunch " + expectActivityLaunch + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (response == null) {
            throw new IllegalArgumentException("response is null");
        } else if (account == null) {
            try {
                Slog.w(TAG, "getAuthToken called with null account");
                response.onError(7, "account is null");
            } catch (RemoteException e) {
                Slog.w(TAG, "Failed to report error back to the client." + e);
            }
        } else if (authTokenType == null) {
            Slog.w(TAG, "getAuthToken called with null authTokenType");
            response.onError(7, "authTokenType is null");
        } else {
            Bundle loginOptions;
            checkBinderPermission("android.permission.USE_CREDENTIALS");
            UserAccounts accounts = getUserAccountsForCaller();
            ServiceInfo<AuthenticatorDescription> authenticatorInfo = this.mAuthenticatorCache.getServiceInfo(AuthenticatorDescription.newKey(account.type), accounts.userId);
            boolean customTokens = authenticatorInfo != null && ((AuthenticatorDescription) authenticatorInfo.type).customTokens;
            int callerUid = Binder.getCallingUid();
            boolean permissionGranted = customTokens || permissionIsGranted(account, authTokenType, callerUid);
            if (loginOptionsIn == null) {
                loginOptions = new Bundle();
            } else {
                loginOptions = loginOptionsIn;
            }
            loginOptions.putInt("callerUid", callerUid);
            loginOptions.putInt("callerPid", Binder.getCallingPid());
            if (notifyOnAuthFailure) {
                loginOptions.putBoolean("notifyOnAuthFailure", true);
            }
            long identityToken = clearCallingIdentity();
            if (!customTokens && permissionGranted) {
                try {
                    String authToken = readAuthTokenInternal(accounts, account, authTokenType);
                    if (authToken != null) {
                        Bundle result = new Bundle();
                        result.putString(AUTHTOKENS_AUTHTOKEN, authToken);
                        result.putString("authAccount", account.name);
                        result.putString("accountType", account.type);
                        onResult(response, result);
                        return;
                    }
                } finally {
                    restoreCallingIdentity(identityToken);
                }
            }
            new C01176(accounts, response, account.type, expectActivityLaunch, false, loginOptions, account, authTokenType, notifyOnAuthFailure, permissionGranted, callerUid, customTokens, accounts).bind();
            restoreCallingIdentity(identityToken);
        }
    }

    private void createNoCredentialsPermissionNotification(Account account, Intent intent, int userId) {
        int uid = intent.getIntExtra(GRANTS_GRANTEE_UID, -1);
        String authTokenType = intent.getStringExtra("authTokenType");
        String authTokenLabel = intent.getStringExtra("authTokenLabel");
        Notification n = new Notification(17301642, null, 0);
        String titleAndSubtitle = this.mContext.getString(17040720, new Object[]{account.name});
        int index = titleAndSubtitle.indexOf(10);
        String title = titleAndSubtitle;
        String subtitle = "";
        if (index > 0) {
            title = titleAndSubtitle.substring(0, index);
            subtitle = titleAndSubtitle.substring(index + 1);
        }
        UserHandle user = new UserHandle(userId);
        Context contextForUser = getContextForUser(user);
        n.color = contextForUser.getResources().getColor(17170521);
        n.setLatestEventInfo(contextForUser, title, subtitle, PendingIntent.getActivityAsUser(this.mContext, 0, intent, 268435456, null, user));
        installNotification(getCredentialPermissionNotificationId(account, authTokenType, uid).intValue(), n, user);
    }

    private Intent newGrantCredentialsPermissionIntent(Account account, int uid, AccountAuthenticatorResponse response, String authTokenType, String authTokenLabel) {
        Intent intent = new Intent(this.mContext, GrantCredentialsPermissionActivity.class);
        intent.setFlags(268435456);
        intent.addCategory(String.valueOf(getCredentialPermissionNotificationId(account, authTokenType, uid)));
        intent.putExtra("account", account);
        intent.putExtra("authTokenType", authTokenType);
        intent.putExtra("response", response);
        intent.putExtra(GRANTS_GRANTEE_UID, uid);
        return intent;
    }

    private Integer getCredentialPermissionNotificationId(Account account, String authTokenType, int uid) {
        Integer id;
        UserAccounts accounts = getUserAccounts(UserHandle.getUserId(uid));
        synchronized (accounts.credentialsPermissionNotificationIds) {
            Pair<Pair<Account, String>, Integer> key = new Pair(new Pair(account, authTokenType), Integer.valueOf(uid));
            id = (Integer) accounts.credentialsPermissionNotificationIds.get(key);
            if (id == null) {
                id = Integer.valueOf(this.mNotificationIds.incrementAndGet());
                accounts.credentialsPermissionNotificationIds.put(key, id);
            }
        }
        return id;
    }

    private Integer getSigninRequiredNotificationId(UserAccounts accounts, Account account) {
        Integer id;
        synchronized (accounts.signinRequiredNotificationIds) {
            id = (Integer) accounts.signinRequiredNotificationIds.get(account);
            if (id == null) {
                id = Integer.valueOf(this.mNotificationIds.incrementAndGet());
                accounts.signinRequiredNotificationIds.put(account, id);
            }
        }
        return id;
    }

    public void addAccount(IAccountManagerResponse response, String accountType, String authTokenType, String[] requiredFeatures, boolean expectActivityLaunch, Bundle optionsIn) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "addAccount: accountType " + accountType + ", response " + response + ", authTokenType " + authTokenType + ", requiredFeatures " + stringArrayToString(requiredFeatures) + ", expectActivityLaunch " + expectActivityLaunch + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (response == null) {
            throw new IllegalArgumentException("response is null");
        } else if (accountType == null) {
            throw new IllegalArgumentException("accountType is null");
        } else {
            checkManageAccountsPermission();
            int userId = Binder.getCallingUserHandle().getIdentifier();
            if (!canUserModifyAccounts(userId)) {
                try {
                    response.onError(100, "User is not allowed to add an account!");
                } catch (RemoteException e) {
                }
                showCantAddAccount(100, userId);
            } else if (canUserModifyAccountsForType(userId, accountType)) {
                Bundle options;
                UserAccounts accounts = getUserAccountsForCaller();
                int pid = Binder.getCallingPid();
                int uid = Binder.getCallingUid();
                if (optionsIn == null) {
                    options = new Bundle();
                } else {
                    options = optionsIn;
                }
                options.putInt("callerUid", uid);
                options.putInt("callerPid", pid);
                long identityToken = clearCallingIdentity();
                try {
                    new C01187(accounts, response, accountType, expectActivityLaunch, true, authTokenType, requiredFeatures, options, accountType).bind();
                } finally {
                    restoreCallingIdentity(identityToken);
                }
            } else {
                try {
                    response.onError(HdmiCecKeycode.CEC_KEYCODE_MUTE_FUNCTION, "User cannot modify accounts of this type (policy).");
                } catch (RemoteException e2) {
                }
                showCantAddAccount(HdmiCecKeycode.CEC_KEYCODE_MUTE_FUNCTION, userId);
            }
        }
    }

    public void addAccountAsUser(IAccountManagerResponse response, String accountType, String authTokenType, String[] requiredFeatures, boolean expectActivityLaunch, Bundle optionsIn, int userId) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "addAccount: accountType " + accountType + ", response " + response + ", authTokenType " + authTokenType + ", requiredFeatures " + stringArrayToString(requiredFeatures) + ", expectActivityLaunch " + expectActivityLaunch + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid() + ", for user id " + userId);
        }
        if (response == null) {
            throw new IllegalArgumentException("response is null");
        } else if (accountType == null) {
            throw new IllegalArgumentException("accountType is null");
        } else {
            checkManageAccountsPermission();
            enforceCrossUserPermission(userId, "User " + UserHandle.getCallingUserId() + " trying to add account for " + userId);
            if (!canUserModifyAccounts(userId)) {
                try {
                    response.onError(100, "User is not allowed to add an account!");
                } catch (RemoteException e) {
                }
                showCantAddAccount(100, userId);
            } else if (canUserModifyAccountsForType(userId, accountType)) {
                Bundle options;
                UserAccounts accounts = getUserAccounts(userId);
                int pid = Binder.getCallingPid();
                int uid = Binder.getCallingUid();
                if (optionsIn == null) {
                    options = new Bundle();
                } else {
                    options = optionsIn;
                }
                options.putInt("callerUid", uid);
                options.putInt("callerPid", pid);
                long identityToken = clearCallingIdentity();
                try {
                    new C01198(accounts, response, accountType, expectActivityLaunch, true, authTokenType, requiredFeatures, options, accountType).bind();
                } finally {
                    restoreCallingIdentity(identityToken);
                }
            } else {
                try {
                    response.onError(HdmiCecKeycode.CEC_KEYCODE_MUTE_FUNCTION, "User cannot modify accounts of this type (policy).");
                } catch (RemoteException e2) {
                }
                showCantAddAccount(HdmiCecKeycode.CEC_KEYCODE_MUTE_FUNCTION, userId);
            }
        }
    }

    private void showCantAddAccount(int errorCode, int userId) {
        Intent cantAddAccount = new Intent(this.mContext, CantAddAccountActivity.class);
        cantAddAccount.putExtra("android.accounts.extra.ERROR_CODE", errorCode);
        cantAddAccount.addFlags(268435456);
        long identityToken = clearCallingIdentity();
        try {
            this.mContext.startActivityAsUser(cantAddAccount, new UserHandle(userId));
        } finally {
            restoreCallingIdentity(identityToken);
        }
    }

    public void confirmCredentialsAsUser(IAccountManagerResponse response, Account account, Bundle options, boolean expectActivityLaunch, int userId) {
        enforceCrossUserPermission(userId, "User " + UserHandle.getCallingUserId() + " trying to confirm account credentials for " + userId);
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "confirmCredentials: " + account + ", response " + response + ", expectActivityLaunch " + expectActivityLaunch + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (response == null) {
            throw new IllegalArgumentException("response is null");
        } else if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else {
            checkManageAccountsPermission();
            UserAccounts accounts = getUserAccounts(userId);
            long identityToken = clearCallingIdentity();
            try {
                new C01209(accounts, response, account.type, expectActivityLaunch, true, account, options).bind();
            } finally {
                restoreCallingIdentity(identityToken);
            }
        }
    }

    public void updateCredentials(IAccountManagerResponse response, Account account, String authTokenType, boolean expectActivityLaunch, Bundle loginOptions) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "updateCredentials: " + account + ", response " + response + ", authTokenType " + authTokenType + ", expectActivityLaunch " + expectActivityLaunch + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (response == null) {
            throw new IllegalArgumentException("response is null");
        } else if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (authTokenType == null) {
            throw new IllegalArgumentException("authTokenType is null");
        } else {
            checkManageAccountsPermission();
            UserAccounts accounts = getUserAccountsForCaller();
            long identityToken = clearCallingIdentity();
            try {
                new AnonymousClass10(accounts, response, account.type, expectActivityLaunch, true, account, authTokenType, loginOptions).bind();
            } finally {
                restoreCallingIdentity(identityToken);
            }
        }
    }

    public void editProperties(IAccountManagerResponse response, String accountType, boolean expectActivityLaunch) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "editProperties: accountType " + accountType + ", response " + response + ", expectActivityLaunch " + expectActivityLaunch + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (response == null) {
            throw new IllegalArgumentException("response is null");
        } else if (accountType == null) {
            throw new IllegalArgumentException("accountType is null");
        } else {
            checkManageAccountsPermission();
            UserAccounts accounts = getUserAccountsForCaller();
            long identityToken = clearCallingIdentity();
            try {
                new AnonymousClass11(accounts, response, accountType, expectActivityLaunch, true, accountType).bind();
            } finally {
                restoreCallingIdentity(identityToken);
            }
        }
    }

    public Account[] getAccounts(int userId) {
        checkReadAccountsPermission();
        UserAccounts accounts = getUserAccounts(userId);
        int callingUid = Binder.getCallingUid();
        long identityToken = clearCallingIdentity();
        try {
            Account[] accountsFromCacheLocked;
            synchronized (accounts.cacheLock) {
                accountsFromCacheLocked = getAccountsFromCacheLocked(accounts, null, callingUid, null);
            }
            return accountsFromCacheLocked;
        } finally {
            restoreCallingIdentity(identityToken);
        }
    }

    public AccountAndUser[] getRunningAccounts() {
        try {
            return getAccounts(ActivityManagerNative.getDefault().getRunningUserIds());
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public AccountAndUser[] getAllAccounts() {
        List<UserInfo> users = getUserManager().getUsers();
        int[] userIds = new int[users.size()];
        for (int i = 0; i < userIds.length; i++) {
            userIds[i] = ((UserInfo) users.get(i)).id;
        }
        return getAccounts(userIds);
    }

    private AccountAndUser[] getAccounts(int[] userIds) {
        ArrayList<AccountAndUser> runningAccounts = Lists.newArrayList();
        for (int userId : userIds) {
            UserAccounts userAccounts = getUserAccounts(userId);
            if (userAccounts != null) {
                synchronized (userAccounts.cacheLock) {
                    Account[] accounts = getAccountsFromCacheLocked(userAccounts, null, Binder.getCallingUid(), null);
                    for (Account accountAndUser : accounts) {
                        runningAccounts.add(new AccountAndUser(accountAndUser, userId));
                    }
                }
            }
        }
        return (AccountAndUser[]) runningAccounts.toArray(new AccountAndUser[runningAccounts.size()]);
    }

    public Account[] getAccountsAsUser(String type, int userId) {
        return getAccountsAsUser(type, userId, null, -1);
    }

    private Account[] getAccountsAsUser(String type, int userId, String callingPackage, int packageUid) {
        int callingUid = Binder.getCallingUid();
        if (userId == UserHandle.getCallingUserId() || callingUid == Process.myUid() || this.mContext.checkCallingOrSelfPermission("android.permission.INTERACT_ACROSS_USERS_FULL") == 0) {
            if (Log.isLoggable(TAG, 2)) {
                Log.v(TAG, "getAccounts: accountType " + type + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
            }
            if (packageUid != -1 && UserHandle.isSameApp(callingUid, Process.myUid())) {
                callingUid = packageUid;
            }
            checkReadAccountsPermission();
            UserAccounts accounts = getUserAccounts(userId);
            long identityToken = clearCallingIdentity();
            try {
                Account[] accountsFromCacheLocked;
                synchronized (accounts.cacheLock) {
                    accountsFromCacheLocked = getAccountsFromCacheLocked(accounts, type, callingUid, callingPackage);
                }
                return accountsFromCacheLocked;
            } finally {
                restoreCallingIdentity(identityToken);
            }
        } else {
            throw new SecurityException("User " + UserHandle.getCallingUserId() + " trying to get account for " + userId);
        }
    }

    public boolean addSharedAccountAsUser(Account account, int userId) {
        SQLiteDatabase db = getUserAccounts(handleIncomingUser(userId)).openHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(ACCOUNTS_NAME, account.name);
        values.put(AUTHTOKENS_TYPE, account.type);
        db.delete(TABLE_SHARED_ACCOUNTS, "name=? AND type=?", new String[]{account.name, account.type});
        if (db.insert(TABLE_SHARED_ACCOUNTS, ACCOUNTS_NAME, values) >= 0) {
            return true;
        }
        Log.w(TAG, "insertAccountIntoDatabase: " + account + ", skipping the DB insert failed");
        return false;
    }

    public boolean renameSharedAccountAsUser(Account account, String newName, int userId) {
        UserAccounts accounts = getUserAccounts(handleIncomingUser(userId));
        SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(ACCOUNTS_NAME, newName);
        values.put(ACCOUNTS_PREVIOUS_NAME, account.name);
        int r = db.update(TABLE_SHARED_ACCOUNTS, values, "name=? AND type=?", new String[]{account.name, account.type});
        if (r > 0) {
            renameAccountInternal(accounts, account, newName);
        }
        if (r > 0) {
            return true;
        }
        return false;
    }

    public boolean removeSharedAccountAsUser(Account account, int userId) {
        UserAccounts accounts = getUserAccounts(handleIncomingUser(userId));
        int r = accounts.openHelper.getWritableDatabase().delete(TABLE_SHARED_ACCOUNTS, "name=? AND type=?", new String[]{account.name, account.type});
        if (r > 0) {
            removeAccountInternal(accounts, account);
        }
        if (r > 0) {
            return true;
        }
        return false;
    }

    public Account[] getSharedAccountsAsUser(int userId) {
        UserAccounts accounts = getUserAccounts(handleIncomingUser(userId));
        ArrayList<Account> accountList = new ArrayList();
        Cursor cursor = null;
        try {
            cursor = accounts.openHelper.getReadableDatabase().query(TABLE_SHARED_ACCOUNTS, new String[]{ACCOUNTS_NAME, AUTHTOKENS_TYPE}, null, null, null, null, null);
            Account[] accountArray;
            if (cursor == null || !cursor.moveToFirst()) {
                if (cursor != null) {
                    cursor.close();
                }
                accountArray = new Account[accountList.size()];
                accountList.toArray(accountArray);
                return accountArray;
            }
            int nameIndex = cursor.getColumnIndex(ACCOUNTS_NAME);
            int typeIndex = cursor.getColumnIndex(AUTHTOKENS_TYPE);
            do {
                accountList.add(new Account(cursor.getString(nameIndex), cursor.getString(typeIndex)));
            } while (cursor.moveToNext());
            if (cursor != null) {
                cursor.close();
            }
            accountArray = new Account[accountList.size()];
            accountList.toArray(accountArray);
            return accountArray;
        } catch (Throwable th) {
            if (cursor != null) {
                cursor.close();
            }
        }
    }

    public Account[] getAccounts(String type) {
        return getAccountsAsUser(type, UserHandle.getCallingUserId());
    }

    public Account[] getAccountsForPackage(String packageName, int uid) {
        int callingUid = Binder.getCallingUid();
        if (UserHandle.isSameApp(callingUid, Process.myUid())) {
            return getAccountsAsUser(null, UserHandle.getCallingUserId(), packageName, uid);
        }
        throw new SecurityException("getAccountsForPackage() called from unauthorized uid " + callingUid + " with uid=" + uid);
    }

    public Account[] getAccountsByTypeForPackage(String type, String packageName) {
        checkBinderPermission("android.permission.INTERACT_ACROSS_USERS");
        try {
            return getAccountsAsUser(type, UserHandle.getCallingUserId(), packageName, AppGlobals.getPackageManager().getPackageUid(packageName, UserHandle.getCallingUserId()));
        } catch (RemoteException re) {
            Slog.e(TAG, "Couldn't determine the packageUid for " + packageName + re);
            return new Account[0];
        }
    }

    public void getAccountsByFeatures(IAccountManagerResponse response, String type, String[] features) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "getAccounts: accountType " + type + ", response " + response + ", features " + stringArrayToString(features) + ", caller's uid " + Binder.getCallingUid() + ", pid " + Binder.getCallingPid());
        }
        if (response == null) {
            throw new IllegalArgumentException("response is null");
        } else if (type == null) {
            throw new IllegalArgumentException("accountType is null");
        } else {
            Account[] accounts;
            checkReadAccountsPermission();
            UserAccounts userAccounts = getUserAccountsForCaller();
            int callingUid = Binder.getCallingUid();
            long identityToken = clearCallingIdentity();
            if (features != null) {
                try {
                    if (features.length != 0) {
                        new GetAccountsByTypeAndFeatureSession(userAccounts, response, type, features, callingUid).bind();
                        return;
                    }
                } finally {
                    restoreCallingIdentity(identityToken);
                }
            }
            synchronized (userAccounts.cacheLock) {
                accounts = getAccountsFromCacheLocked(userAccounts, type, callingUid, null);
            }
            Bundle result = new Bundle();
            result.putParcelableArray(TABLE_ACCOUNTS, accounts);
            onResult(response, result);
            restoreCallingIdentity(identityToken);
        }
    }

    private long getAccountIdLocked(SQLiteDatabase db, Account account) {
        SQLiteDatabase sQLiteDatabase = db;
        Cursor cursor = sQLiteDatabase.query(TABLE_ACCOUNTS, new String[]{EXTRAS_ID}, "name=? AND type=?", new String[]{account.name, account.type}, null, null, null);
        try {
            if (cursor.moveToNext()) {
                long j = cursor.getLong(0);
                return j;
            }
            cursor.close();
            return -1;
        } finally {
            cursor.close();
        }
    }

    private long getExtrasIdLocked(SQLiteDatabase db, long accountId, String key) {
        Cursor cursor = db.query(TABLE_EXTRAS, new String[]{EXTRAS_ID}, "accounts_id=" + accountId + " AND " + META_KEY + "=?", new String[]{key}, null, null, null);
        try {
            if (cursor.moveToNext()) {
                long j = cursor.getLong(0);
                return j;
            }
            cursor.close();
            return -1;
        } finally {
            cursor.close();
        }
    }

    private static String getDatabaseName(int userId) {
        File systemDir = Environment.getSystemSecureDirectory();
        File databaseFile = new File(Environment.getUserSystemDirectory(userId), DATABASE_NAME);
        if (userId == 0) {
            File oldFile = new File(systemDir, DATABASE_NAME);
            if (oldFile.exists() && !databaseFile.exists()) {
                File userDir = Environment.getUserSystemDirectory(userId);
                if (!userDir.exists() && !userDir.mkdirs()) {
                    throw new IllegalStateException("User dir cannot be created: " + userDir);
                } else if (!oldFile.renameTo(databaseFile)) {
                    throw new IllegalStateException("User dir cannot be migrated: " + databaseFile);
                }
            }
        }
        return databaseFile.getPath();
    }

    public IBinder onBind(Intent intent) {
        return asBinder();
    }

    private static boolean scanArgs(String[] args, String value) {
        if (args != null) {
            for (String arg : args) {
                if (value.equals(arg)) {
                    return true;
                }
            }
        }
        return false;
    }

    protected void dump(FileDescriptor fd, PrintWriter fout, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            fout.println("Permission Denial: can't dump AccountsManager from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " without permission " + "android.permission.DUMP");
            return;
        }
        boolean isCheckinRequest = scanArgs(args, "--checkin") || scanArgs(args, "-c");
        IndentingPrintWriter ipw = new IndentingPrintWriter(fout, "  ");
        for (UserInfo user : getUserManager().getUsers()) {
            ipw.println("User " + user + ":");
            ipw.increaseIndent();
            dumpUser(getUserAccounts(user.id), fd, ipw, args, isCheckinRequest);
            ipw.println();
            ipw.decreaseIndent();
        }
    }

    private void dumpUser(UserAccounts userAccounts, FileDescriptor fd, PrintWriter fout, String[] args, boolean isCheckinRequest) {
        synchronized (userAccounts.cacheLock) {
            SQLiteDatabase db = userAccounts.openHelper.getReadableDatabase();
            if (isCheckinRequest) {
                cursor = db.query(TABLE_ACCOUNTS, ACCOUNT_TYPE_COUNT_PROJECTION, null, null, AUTHTOKENS_TYPE, null, null);
                while (cursor.moveToNext()) {
                    try {
                        fout.println(cursor.getString(0) + "," + cursor.getString(1));
                    } catch (Throwable th) {
                        Cursor cursor;
                        if (cursor != null) {
                            cursor.close();
                        }
                    }
                }
                if (cursor != null) {
                    cursor.close();
                }
            } else {
                Account[] accounts = getAccountsFromCacheLocked(userAccounts, null, Process.myUid(), null);
                fout.println("Accounts: " + accounts.length);
                for (Account account : accounts) {
                    fout.println("  " + account);
                }
                fout.println();
                synchronized (this.mSessions) {
                    long now = SystemClock.elapsedRealtime();
                    fout.println("Active Sessions: " + this.mSessions.size());
                    for (Session session : this.mSessions.values()) {
                        fout.println("  " + session.toDebugString(now));
                    }
                }
                fout.println();
                this.mAuthenticatorCache.dump(fd, fout, args, userAccounts.userId);
            }
        }
    }

    private void doNotification(UserAccounts accounts, Account account, CharSequence message, Intent intent, int userId) {
        long identityToken = clearCallingIdentity();
        try {
            if (Log.isLoggable(TAG, 2)) {
                Log.v(TAG, "doNotification: " + message + " intent:" + intent);
            }
            if (intent.getComponent() == null || !GrantCredentialsPermissionActivity.class.getName().equals(intent.getComponent().getClassName())) {
                Integer notificationId = getSigninRequiredNotificationId(accounts, account);
                intent.addCategory(String.valueOf(notificationId));
                Notification n = new Notification(17301642, null, 0);
                UserHandle user = new UserHandle(userId);
                Context contextForUser = getContextForUser(user);
                String notificationTitleFormat = contextForUser.getText(17039592).toString();
                n.color = contextForUser.getResources().getColor(17170521);
                String format = String.format(notificationTitleFormat, new Object[]{account.name});
                n.setLatestEventInfo(contextForUser, r16, message, PendingIntent.getActivityAsUser(this.mContext, 0, intent, 268435456, null, user));
                installNotification(notificationId.intValue(), n, user);
            } else {
                createNoCredentialsPermissionNotification(account, intent, userId);
            }
            restoreCallingIdentity(identityToken);
        } catch (Throwable th) {
            restoreCallingIdentity(identityToken);
        }
    }

    protected void installNotification(int notificationId, Notification n, UserHandle user) {
        ((NotificationManager) this.mContext.getSystemService("notification")).notifyAsUser(null, notificationId, n, user);
    }

    protected void cancelNotification(int id, UserHandle user) {
        long identityToken = clearCallingIdentity();
        try {
            ((NotificationManager) this.mContext.getSystemService("notification")).cancelAsUser(null, id, user);
        } finally {
            restoreCallingIdentity(identityToken);
        }
    }

    private void checkBinderPermission(String... permissions) {
        int uid = Binder.getCallingUid();
        String[] arr$ = permissions;
        int len$ = arr$.length;
        int i$ = 0;
        while (i$ < len$) {
            String perm = arr$[i$];
            if (this.mContext.checkCallingOrSelfPermission(perm) != 0) {
                i$++;
            } else if (Log.isLoggable(TAG, 2)) {
                Log.v(TAG, "  caller uid " + uid + " has " + perm);
                return;
            } else {
                return;
            }
        }
        String msg = "caller uid " + uid + " lacks any of " + TextUtils.join(",", permissions);
        Log.w(TAG, "  " + msg);
        throw new SecurityException(msg);
    }

    private int handleIncomingUser(int userId) {
        try {
            userId = ActivityManagerNative.getDefault().handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, true, true, "", null);
        } catch (RemoteException e) {
        }
        return userId;
    }

    private boolean isPrivileged(int callingUid) {
        try {
            PackageManager userPackageManager = this.mContext.createPackageContextAsUser("android", 0, new UserHandle(UserHandle.getUserId(callingUid))).getPackageManager();
            String[] arr$ = userPackageManager.getPackagesForUid(callingUid);
            int len$ = arr$.length;
            int i$ = 0;
            while (i$ < len$) {
                try {
                    PackageInfo packageInfo = userPackageManager.getPackageInfo(arr$[i$], 0);
                    if (packageInfo != null && (packageInfo.applicationInfo.flags & 1073741824) != 0) {
                        return true;
                    }
                    i$++;
                } catch (NameNotFoundException e) {
                    return false;
                }
            }
            return false;
        } catch (NameNotFoundException e2) {
            return false;
        }
    }

    private boolean permissionIsGranted(Account account, String authTokenType, int callerUid) {
        boolean fromAuthenticator;
        boolean hasExplicitGrants;
        boolean isPrivileged = isPrivileged(callerUid);
        if (account == null || !hasAuthenticatorUid(account.type, callerUid)) {
            fromAuthenticator = false;
        } else {
            fromAuthenticator = true;
        }
        if (account == null || !hasExplicitlyGrantedPermission(account, authTokenType, callerUid)) {
            hasExplicitGrants = false;
        } else {
            hasExplicitGrants = true;
        }
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "checkGrantsOrCallingUidAgainstAuthenticator: caller uid " + callerUid + ", " + account + ": is authenticator? " + fromAuthenticator + ", has explicit permission? " + hasExplicitGrants);
        }
        if (fromAuthenticator || hasExplicitGrants || isPrivileged) {
            return true;
        }
        return false;
    }

    private boolean hasAuthenticatorUid(String accountType, int callingUid) {
        for (ServiceInfo<AuthenticatorDescription> serviceInfo : this.mAuthenticatorCache.getAllServices(UserHandle.getUserId(callingUid))) {
            if (((AuthenticatorDescription) serviceInfo.type).type.equals(accountType)) {
                if (serviceInfo.uid == callingUid || this.mPackageManager.checkSignatures(serviceInfo.uid, callingUid) == 0) {
                    return true;
                }
                return false;
            }
        }
        return false;
    }

    private boolean hasExplicitlyGrantedPermission(Account account, String authTokenType, int callerUid) {
        boolean permissionGranted = false;
        if (callerUid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            return true;
        }
        UserAccounts accounts = getUserAccountsForCaller();
        synchronized (accounts.cacheLock) {
            SQLiteDatabase db = accounts.openHelper.getReadableDatabase();
            String[] args = new String[MESSAGE_COPY_SHARED_ACCOUNT];
            args[0] = String.valueOf(callerUid);
            args[1] = authTokenType;
            args[2] = account.name;
            args[MESSAGE_TIMED_OUT] = account.type;
            if (DatabaseUtils.longForQuery(db, COUNT_OF_MATCHING_GRANTS, args) != 0) {
                permissionGranted = true;
            }
            if (permissionGranted || !ActivityManager.isRunningInTestHarness()) {
                return permissionGranted;
            }
            Log.d(TAG, "no credentials permission for usage of " + account + ", " + authTokenType + " by uid " + callerUid + " but ignoring since device is in test harness.");
            return true;
        }
    }

    private void checkCallingUidAgainstAuthenticator(Account account) {
        int uid = Binder.getCallingUid();
        if (account == null || !hasAuthenticatorUid(account.type, uid)) {
            String msg = "caller uid " + uid + " is different than the authenticator's uid";
            Log.w(TAG, msg);
            throw new SecurityException(msg);
        } else if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "caller uid " + uid + " is the same as the authenticator's uid");
        }
    }

    private void checkAuthenticateAccountsPermission(Account account) {
        checkBinderPermission("android.permission.AUTHENTICATE_ACCOUNTS");
        checkCallingUidAgainstAuthenticator(account);
    }

    private void checkReadAccountsPermission() {
        checkBinderPermission("android.permission.GET_ACCOUNTS");
    }

    private void checkManageAccountsPermission() {
        checkBinderPermission("android.permission.MANAGE_ACCOUNTS");
    }

    private void checkManageAccountsOrUseCredentialsPermissions() {
        checkBinderPermission("android.permission.MANAGE_ACCOUNTS", "android.permission.USE_CREDENTIALS");
    }

    private boolean canUserModifyAccounts(int userId) {
        if (getUserManager().getUserRestrictions(new UserHandle(userId)).getBoolean("no_modify_accounts")) {
            return false;
        }
        return true;
    }

    private boolean canUserModifyAccountsForType(int userId, String accountType) {
        String[] typesArray = ((DevicePolicyManager) this.mContext.getSystemService("device_policy")).getAccountTypesWithManagementDisabledAsUser(userId);
        if (typesArray == null) {
            return true;
        }
        for (String forbiddenType : typesArray) {
            if (forbiddenType.equals(accountType)) {
                return false;
            }
        }
        return true;
    }

    public void updateAppPermission(Account account, String authTokenType, int uid, boolean value) throws RemoteException {
        if (getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            throw new SecurityException();
        } else if (value) {
            grantAppPermission(account, authTokenType, uid);
        } else {
            revokeAppPermission(account, authTokenType, uid);
        }
    }

    private void grantAppPermission(Account account, String authTokenType, int uid) {
        if (account == null || authTokenType == null) {
            Log.e(TAG, "grantAppPermission: called with invalid arguments", new Exception());
            return;
        }
        UserAccounts accounts = getUserAccounts(UserHandle.getUserId(uid));
        synchronized (accounts.cacheLock) {
            SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
            db.beginTransaction();
            try {
                long accountId = getAccountIdLocked(db, account);
                if (accountId >= 0) {
                    ContentValues values = new ContentValues();
                    values.put(GRANTS_ACCOUNTS_ID, Long.valueOf(accountId));
                    values.put(GRANTS_AUTH_TOKEN_TYPE, authTokenType);
                    values.put(GRANTS_GRANTEE_UID, Integer.valueOf(uid));
                    db.insert(TABLE_GRANTS, GRANTS_ACCOUNTS_ID, values);
                    db.setTransactionSuccessful();
                }
                cancelNotification(getCredentialPermissionNotificationId(account, authTokenType, uid).intValue(), new UserHandle(accounts.userId));
            } finally {
                db.endTransaction();
            }
        }
    }

    private void revokeAppPermission(Account account, String authTokenType, int uid) {
        if (account == null || authTokenType == null) {
            Log.e(TAG, "revokeAppPermission: called with invalid arguments", new Exception());
            return;
        }
        UserAccounts accounts = getUserAccounts(UserHandle.getUserId(uid));
        synchronized (accounts.cacheLock) {
            SQLiteDatabase db = accounts.openHelper.getWritableDatabase();
            db.beginTransaction();
            try {
                long accountId = getAccountIdLocked(db, account);
                if (accountId >= 0) {
                    String[] strArr = new String[MESSAGE_TIMED_OUT];
                    strArr[0] = String.valueOf(accountId);
                    strArr[1] = authTokenType;
                    strArr[2] = String.valueOf(uid);
                    db.delete(TABLE_GRANTS, "accounts_id=? AND auth_token_type=? AND uid=?", strArr);
                    db.setTransactionSuccessful();
                }
                cancelNotification(getCredentialPermissionNotificationId(account, authTokenType, uid).intValue(), new UserHandle(accounts.userId));
            } finally {
                db.endTransaction();
            }
        }
    }

    private static final String stringArrayToString(String[] value) {
        return value != null ? "[" + TextUtils.join(",", value) + "]" : null;
    }

    private void removeAccountFromCacheLocked(UserAccounts accounts, Account account) {
        Account[] oldAccountsForType = (Account[]) accounts.accountCache.get(account.type);
        if (oldAccountsForType != null) {
            ArrayList<Account> newAccountsList = new ArrayList();
            for (Account curAccount : oldAccountsForType) {
                if (!curAccount.equals(account)) {
                    newAccountsList.add(curAccount);
                }
            }
            if (newAccountsList.isEmpty()) {
                accounts.accountCache.remove(account.type);
            } else {
                accounts.accountCache.put(account.type, (Account[]) newAccountsList.toArray(new Account[newAccountsList.size()]));
            }
        }
        accounts.userDataCache.remove(account);
        accounts.authTokenCache.remove(account);
        accounts.previousNameCache.remove(account);
    }

    private void insertAccountIntoCacheLocked(UserAccounts accounts, Account account) {
        int oldLength;
        Account[] accountsForType = (Account[]) accounts.accountCache.get(account.type);
        if (accountsForType != null) {
            oldLength = accountsForType.length;
        } else {
            oldLength = 0;
        }
        Account[] newAccountsForType = new Account[(oldLength + 1)];
        if (accountsForType != null) {
            System.arraycopy(accountsForType, 0, newAccountsForType, 0, oldLength);
        }
        newAccountsForType[oldLength] = account;
        accounts.accountCache.put(account.type, newAccountsForType);
    }

    private Account[] filterSharedAccounts(UserAccounts userAccounts, Account[] unfiltered, int callingUid, String callingPackage) {
        if (getUserManager() == null || userAccounts == null || userAccounts.userId < 0 || callingUid == Process.myUid()) {
            return unfiltered;
        }
        UserInfo user = this.mUserManager.getUserInfo(userAccounts.userId);
        if (user == null || !user.isRestricted()) {
            return unfiltered;
        }
        String[] packages = this.mPackageManager.getPackagesForUid(callingUid);
        String whiteList = this.mContext.getResources().getString(17039431);
        for (String packageName : packages) {
            if (whiteList.contains(";" + packageName + ";")) {
                return unfiltered;
            }
        }
        ArrayList<Account> allowed = new ArrayList();
        Account[] sharedAccounts = getSharedAccountsAsUser(userAccounts.userId);
        if (sharedAccounts == null || sharedAccounts.length == 0) {
            return unfiltered;
        }
        String requiredAccountType = "";
        PackageInfo pi;
        if (callingPackage == null) {
            for (String packageName2 : packages) {
                pi = this.mPackageManager.getPackageInfo(packageName2, 0);
                if (pi != null && pi.restrictedAccountType != null) {
                    requiredAccountType = pi.restrictedAccountType;
                    break;
                }
            }
        } else {
            try {
                pi = this.mPackageManager.getPackageInfo(callingPackage, 0);
                if (!(pi == null || pi.restrictedAccountType == null)) {
                    requiredAccountType = pi.restrictedAccountType;
                }
            } catch (NameNotFoundException e) {
            }
        }
        for (Account account : unfiltered) {
            if (account.type.equals(requiredAccountType)) {
                allowed.add(account);
            } else {
                boolean found = false;
                for (Account equals : sharedAccounts) {
                    if (equals.equals(account)) {
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    allowed.add(account);
                }
            }
        }
        Account[] filtered = new Account[allowed.size()];
        allowed.toArray(filtered);
        return filtered;
    }

    protected Account[] getAccountsFromCacheLocked(UserAccounts userAccounts, String accountType, int callingUid, String callingPackage) {
        Account[] accounts;
        if (accountType != null) {
            accounts = (Account[]) userAccounts.accountCache.get(accountType);
            if (accounts == null) {
                return EMPTY_ACCOUNT_ARRAY;
            }
            return filterSharedAccounts(userAccounts, (Account[]) Arrays.copyOf(accounts, accounts.length), callingUid, callingPackage);
        }
        int totalLength = 0;
        for (Account[] accounts2 : userAccounts.accountCache.values()) {
            totalLength += accounts2.length;
        }
        if (totalLength == 0) {
            return EMPTY_ACCOUNT_ARRAY;
        }
        accounts2 = new Account[totalLength];
        totalLength = 0;
        for (Account[] accountsOfType : userAccounts.accountCache.values()) {
            System.arraycopy(accountsOfType, 0, accounts2, totalLength, accountsOfType.length);
            totalLength += accountsOfType.length;
        }
        return filterSharedAccounts(userAccounts, accounts2, callingUid, callingPackage);
    }

    protected void writeUserDataIntoCacheLocked(UserAccounts accounts, SQLiteDatabase db, Account account, String key, String value) {
        HashMap<String, String> userDataForAccount = (HashMap) accounts.userDataCache.get(account);
        if (userDataForAccount == null) {
            userDataForAccount = readUserDataForAccountFromDatabaseLocked(db, account);
            accounts.userDataCache.put(account, userDataForAccount);
        }
        if (value == null) {
            userDataForAccount.remove(key);
        } else {
            userDataForAccount.put(key, value);
        }
    }

    protected void writeAuthTokenIntoCacheLocked(UserAccounts accounts, SQLiteDatabase db, Account account, String key, String value) {
        HashMap<String, String> authTokensForAccount = (HashMap) accounts.authTokenCache.get(account);
        if (authTokensForAccount == null) {
            authTokensForAccount = readAuthTokensForAccountFromDatabaseLocked(db, account);
            accounts.authTokenCache.put(account, authTokensForAccount);
        }
        if (value == null) {
            authTokensForAccount.remove(key);
        } else {
            authTokensForAccount.put(key, value);
        }
    }

    protected String readAuthTokenInternal(UserAccounts accounts, Account account, String authTokenType) {
        String str;
        synchronized (accounts.cacheLock) {
            HashMap<String, String> authTokensForAccount = (HashMap) accounts.authTokenCache.get(account);
            if (authTokensForAccount == null) {
                authTokensForAccount = readAuthTokensForAccountFromDatabaseLocked(accounts.openHelper.getReadableDatabase(), account);
                accounts.authTokenCache.put(account, authTokensForAccount);
            }
            str = (String) authTokensForAccount.get(authTokenType);
        }
        return str;
    }

    protected String readUserDataInternal(UserAccounts accounts, Account account, String key) {
        String str;
        synchronized (accounts.cacheLock) {
            HashMap<String, String> userDataForAccount = (HashMap) accounts.userDataCache.get(account);
            if (userDataForAccount == null) {
                userDataForAccount = readUserDataForAccountFromDatabaseLocked(accounts.openHelper.getReadableDatabase(), account);
                accounts.userDataCache.put(account, userDataForAccount);
            }
            str = (String) userDataForAccount.get(key);
        }
        return str;
    }

    protected HashMap<String, String> readUserDataForAccountFromDatabaseLocked(SQLiteDatabase db, Account account) {
        HashMap<String, String> userDataForAccount = new HashMap();
        Cursor cursor = db.query(TABLE_EXTRAS, COLUMNS_EXTRAS_KEY_AND_VALUE, SELECTION_USERDATA_BY_ACCOUNT, new String[]{account.name, account.type}, null, null, null);
        while (cursor.moveToNext()) {
            try {
                userDataForAccount.put(cursor.getString(0), cursor.getString(1));
            } finally {
                cursor.close();
            }
        }
        return userDataForAccount;
    }

    protected HashMap<String, String> readAuthTokensForAccountFromDatabaseLocked(SQLiteDatabase db, Account account) {
        HashMap<String, String> authTokensForAccount = new HashMap();
        Cursor cursor = db.query(TABLE_AUTHTOKENS, COLUMNS_AUTHTOKENS_TYPE_AND_AUTHTOKEN, SELECTION_USERDATA_BY_ACCOUNT, new String[]{account.name, account.type}, null, null, null);
        while (cursor.moveToNext()) {
            try {
                authTokensForAccount.put(cursor.getString(0), cursor.getString(1));
            } finally {
                cursor.close();
            }
        }
        return authTokensForAccount;
    }

    private Context getContextForUser(UserHandle user) {
        try {
            return this.mContext.createPackageContextAsUser(this.mContext.getPackageName(), 0, user);
        } catch (NameNotFoundException e) {
            return this.mContext;
        }
    }
}
