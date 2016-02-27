package android.accounts;

import android.accounts.IAccountManagerResponse.Stub;
import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Resources;
import android.database.SQLException;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Parcelable;
import android.os.Process;
import android.os.RemoteException;
import android.os.UserHandle;
import android.text.TextUtils;
import android.util.Log;
import com.google.android.collect.Maps;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.concurrent.Callable;
import java.util.concurrent.CancellationException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

public class AccountManager {
    public static final String ACTION_AUTHENTICATOR_INTENT = "android.accounts.AccountAuthenticator";
    public static final String AUTHENTICATOR_ATTRIBUTES_NAME = "account-authenticator";
    public static final String AUTHENTICATOR_META_DATA_NAME = "android.accounts.AccountAuthenticator";
    public static final int ERROR_CODE_BAD_ARGUMENTS = 7;
    public static final int ERROR_CODE_BAD_AUTHENTICATION = 9;
    public static final int ERROR_CODE_BAD_REQUEST = 8;
    public static final int ERROR_CODE_CANCELED = 4;
    public static final int ERROR_CODE_INVALID_RESPONSE = 5;
    public static final int ERROR_CODE_MANAGEMENT_DISABLED_FOR_ACCOUNT_TYPE = 101;
    public static final int ERROR_CODE_NETWORK_ERROR = 3;
    public static final int ERROR_CODE_REMOTE_EXCEPTION = 1;
    public static final int ERROR_CODE_UNSUPPORTED_OPERATION = 6;
    public static final int ERROR_CODE_USER_RESTRICTED = 100;
    public static final String KEY_ACCOUNTS = "accounts";
    public static final String KEY_ACCOUNT_AUTHENTICATOR_RESPONSE = "accountAuthenticatorResponse";
    public static final String KEY_ACCOUNT_MANAGER_RESPONSE = "accountManagerResponse";
    public static final String KEY_ACCOUNT_NAME = "authAccount";
    public static final String KEY_ACCOUNT_TYPE = "accountType";
    public static final String KEY_ANDROID_PACKAGE_NAME = "androidPackageName";
    public static final String KEY_AUTHENTICATOR_TYPES = "authenticator_types";
    public static final String KEY_AUTHTOKEN = "authtoken";
    public static final String KEY_AUTH_FAILED_MESSAGE = "authFailedMessage";
    public static final String KEY_AUTH_TOKEN_LABEL = "authTokenLabelKey";
    public static final String KEY_BOOLEAN_RESULT = "booleanResult";
    public static final String KEY_CALLER_PID = "callerPid";
    public static final String KEY_CALLER_UID = "callerUid";
    public static final String KEY_ERROR_CODE = "errorCode";
    public static final String KEY_ERROR_MESSAGE = "errorMessage";
    public static final String KEY_INTENT = "intent";
    public static final String KEY_NOTIFY_ON_FAILURE = "notifyOnAuthFailure";
    public static final String KEY_PASSWORD = "password";
    public static final String KEY_USERDATA = "userdata";
    public static final String LOGIN_ACCOUNTS_CHANGED_ACTION = "android.accounts.LOGIN_ACCOUNTS_CHANGED";
    private static final String TAG = "AccountManager";
    private final BroadcastReceiver mAccountsChangedBroadcastReceiver;
    private final HashMap<OnAccountsUpdateListener, Handler> mAccountsUpdatedListeners;
    private final Context mContext;
    private final Handler mMainHandler;
    private final IAccountManager mService;

    private abstract class AmsTask extends FutureTask<Bundle> implements AccountManagerFuture<Bundle> {
        final Activity mActivity;
        final AccountManagerCallback<Bundle> mCallback;
        final Handler mHandler;
        final IAccountManagerResponse mResponse;

        /* renamed from: android.accounts.AccountManager.AmsTask.1 */
        class C00161 implements Callable<Bundle> {
            final /* synthetic */ AccountManager val$this$0;

            C00161(AccountManager accountManager) {
                this.val$this$0 = accountManager;
            }

            public Bundle call() throws Exception {
                throw new IllegalStateException("this should never be called");
            }
        }

        private class Response extends Stub {
            private Response() {
            }

            public void onResult(Bundle bundle) {
                Intent intent = (Intent) bundle.getParcelable(AccountManager.KEY_INTENT);
                if (intent != null && AmsTask.this.mActivity != null) {
                    AmsTask.this.mActivity.startActivity(intent);
                } else if (bundle.getBoolean("retry")) {
                    try {
                        AmsTask.this.doWork();
                    } catch (RemoteException e) {
                    }
                } else {
                    AmsTask.this.set(bundle);
                }
            }

            public void onError(int code, String message) {
                if (code == AccountManager.ERROR_CODE_CANCELED || code == AccountManager.ERROR_CODE_USER_RESTRICTED || code == AccountManager.ERROR_CODE_MANAGEMENT_DISABLED_FOR_ACCOUNT_TYPE) {
                    AmsTask.this.cancel(true);
                } else {
                    AmsTask.this.setException(AccountManager.this.convertErrorToException(code, message));
                }
            }
        }

        public abstract void doWork() throws RemoteException;

        public AmsTask(Activity activity, Handler handler, AccountManagerCallback<Bundle> callback) {
            super(new C00161(AccountManager.this));
            this.mHandler = handler;
            this.mCallback = callback;
            this.mActivity = activity;
            this.mResponse = new Response();
        }

        public final AccountManagerFuture<Bundle> start() {
            try {
                doWork();
            } catch (RemoteException e) {
                setException(e);
            }
            return this;
        }

        protected void set(Bundle bundle) {
            if (bundle == null) {
                Log.e(AccountManager.TAG, "the bundle must not be null", new Exception());
            }
            super.set(bundle);
        }

        private Bundle internalGetResult(Long timeout, TimeUnit unit) throws OperationCanceledException, IOException, AuthenticatorException {
            Bundle bundle;
            if (!isDone()) {
                AccountManager.this.ensureNotOnMainThread();
            }
            if (timeout == null) {
                try {
                    bundle = (Bundle) get();
                    cancel(true);
                } catch (CancellationException e) {
                    throw new OperationCanceledException();
                } catch (TimeoutException e2) {
                    cancel(true);
                    throw new OperationCanceledException();
                } catch (InterruptedException e3) {
                    cancel(true);
                    throw new OperationCanceledException();
                } catch (ExecutionException e4) {
                    Throwable cause = e4.getCause();
                    if (cause instanceof IOException) {
                        throw ((IOException) cause);
                    } else if (cause instanceof UnsupportedOperationException) {
                        throw new AuthenticatorException(cause);
                    } else if (cause instanceof AuthenticatorException) {
                        throw ((AuthenticatorException) cause);
                    } else if (cause instanceof RuntimeException) {
                        throw ((RuntimeException) cause);
                    } else if (cause instanceof Error) {
                        throw ((Error) cause);
                    } else {
                        throw new IllegalStateException(cause);
                    }
                } catch (Throwable th) {
                    cancel(true);
                }
            } else {
                bundle = (Bundle) get(timeout.longValue(), unit);
                cancel(true);
            }
            return bundle;
        }

        public Bundle getResult() throws OperationCanceledException, IOException, AuthenticatorException {
            return internalGetResult(null, null);
        }

        public Bundle getResult(long timeout, TimeUnit unit) throws OperationCanceledException, IOException, AuthenticatorException {
            return internalGetResult(Long.valueOf(timeout), unit);
        }

        protected void done() {
            if (this.mCallback != null) {
                AccountManager.this.postToHandler(this.mHandler, this.mCallback, (AccountManagerFuture) this);
            }
        }
    }

    /* renamed from: android.accounts.AccountManager.10 */
    class AnonymousClass10 extends AmsTask {
        final /* synthetic */ Account val$account;
        final /* synthetic */ String val$authTokenType;
        final /* synthetic */ boolean val$notifyAuthFailure;
        final /* synthetic */ Bundle val$optionsIn;

        AnonymousClass10(Activity x0, Handler x1, AccountManagerCallback x2, Account account, String str, boolean z, Bundle bundle) {
            this.val$account = account;
            this.val$authTokenType = str;
            this.val$notifyAuthFailure = z;
            this.val$optionsIn = bundle;
            super(x0, x1, x2);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.getAuthToken(this.mResponse, this.val$account, this.val$authTokenType, this.val$notifyAuthFailure, false, this.val$optionsIn);
        }
    }

    /* renamed from: android.accounts.AccountManager.11 */
    class AnonymousClass11 extends AmsTask {
        final /* synthetic */ String val$accountType;
        final /* synthetic */ Activity val$activity;
        final /* synthetic */ String val$authTokenType;
        final /* synthetic */ Bundle val$optionsIn;
        final /* synthetic */ String[] val$requiredFeatures;

        AnonymousClass11(Activity x0, Handler x1, AccountManagerCallback x2, String str, String str2, String[] strArr, Activity activity, Bundle bundle) {
            this.val$accountType = str;
            this.val$authTokenType = str2;
            this.val$requiredFeatures = strArr;
            this.val$activity = activity;
            this.val$optionsIn = bundle;
            super(x0, x1, x2);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.addAccount(this.mResponse, this.val$accountType, this.val$authTokenType, this.val$requiredFeatures, this.val$activity != null, this.val$optionsIn);
        }
    }

    /* renamed from: android.accounts.AccountManager.12 */
    class AnonymousClass12 extends AmsTask {
        final /* synthetic */ String val$accountType;
        final /* synthetic */ Activity val$activity;
        final /* synthetic */ String val$authTokenType;
        final /* synthetic */ Bundle val$optionsIn;
        final /* synthetic */ String[] val$requiredFeatures;
        final /* synthetic */ UserHandle val$userHandle;

        AnonymousClass12(Activity x0, Handler x1, AccountManagerCallback x2, String str, String str2, String[] strArr, Activity activity, Bundle bundle, UserHandle userHandle) {
            this.val$accountType = str;
            this.val$authTokenType = str2;
            this.val$requiredFeatures = strArr;
            this.val$activity = activity;
            this.val$optionsIn = bundle;
            this.val$userHandle = userHandle;
            super(x0, x1, x2);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.addAccountAsUser(this.mResponse, this.val$accountType, this.val$authTokenType, this.val$requiredFeatures, this.val$activity != null, this.val$optionsIn, this.val$userHandle.getIdentifier());
        }
    }

    private abstract class BaseFutureTask<T> extends FutureTask<T> {
        final Handler mHandler;
        public final IAccountManagerResponse mResponse;

        /* renamed from: android.accounts.AccountManager.BaseFutureTask.1 */
        class C00171 implements Callable<T> {
            final /* synthetic */ AccountManager val$this$0;

            C00171(AccountManager accountManager) {
                this.val$this$0 = accountManager;
            }

            public T call() throws Exception {
                throw new IllegalStateException("this should never be called");
            }
        }

        protected class Response extends Stub {
            protected Response() {
            }

            public void onResult(Bundle bundle) {
                try {
                    T result = BaseFutureTask.this.bundleToResult(bundle);
                    if (result != null) {
                        BaseFutureTask.this.set(result);
                    }
                } catch (ClassCastException e) {
                    onError(AccountManager.ERROR_CODE_INVALID_RESPONSE, "no result in response");
                } catch (AuthenticatorException e2) {
                    onError(AccountManager.ERROR_CODE_INVALID_RESPONSE, "no result in response");
                }
            }

            public void onError(int code, String message) {
                if (code == AccountManager.ERROR_CODE_CANCELED || code == AccountManager.ERROR_CODE_USER_RESTRICTED || code == AccountManager.ERROR_CODE_MANAGEMENT_DISABLED_FOR_ACCOUNT_TYPE) {
                    BaseFutureTask.this.cancel(true);
                } else {
                    BaseFutureTask.this.setException(AccountManager.this.convertErrorToException(code, message));
                }
            }
        }

        public abstract T bundleToResult(Bundle bundle) throws AuthenticatorException;

        public abstract void doWork() throws RemoteException;

        public BaseFutureTask(Handler handler) {
            super(new C00171(AccountManager.this));
            this.mHandler = handler;
            this.mResponse = new Response();
        }

        protected void postRunnableToHandler(Runnable runnable) {
            (this.mHandler == null ? AccountManager.this.mMainHandler : this.mHandler).post(runnable);
        }

        protected void startTask() {
            try {
                doWork();
            } catch (RemoteException e) {
                setException(e);
            }
        }
    }

    private abstract class Future2Task<T> extends BaseFutureTask<T> implements AccountManagerFuture<T> {
        final AccountManagerCallback<T> mCallback;

        /* renamed from: android.accounts.AccountManager.Future2Task.1 */
        class C00181 implements Runnable {
            C00181() {
            }

            public void run() {
                Future2Task.this.mCallback.run(Future2Task.this);
            }
        }

        public Future2Task(Handler handler, AccountManagerCallback<T> callback) {
            super(handler);
            this.mCallback = callback;
        }

        protected void done() {
            if (this.mCallback != null) {
                postRunnableToHandler(new C00181());
            }
        }

        public Future2Task<T> start() {
            startTask();
            return this;
        }

        private T internalGetResult(Long timeout, TimeUnit unit) throws OperationCanceledException, IOException, AuthenticatorException {
            T t;
            if (!isDone()) {
                AccountManager.this.ensureNotOnMainThread();
            }
            if (timeout == null) {
                try {
                    t = get();
                    cancel(true);
                } catch (InterruptedException e) {
                    cancel(true);
                    throw new OperationCanceledException();
                } catch (TimeoutException e2) {
                    cancel(true);
                    throw new OperationCanceledException();
                } catch (CancellationException e3) {
                    cancel(true);
                    throw new OperationCanceledException();
                } catch (ExecutionException e4) {
                    Throwable cause = e4.getCause();
                    if (cause instanceof IOException) {
                        throw ((IOException) cause);
                    } else if (cause instanceof UnsupportedOperationException) {
                        throw new AuthenticatorException(cause);
                    } else if (cause instanceof AuthenticatorException) {
                        throw ((AuthenticatorException) cause);
                    } else if (cause instanceof RuntimeException) {
                        throw ((RuntimeException) cause);
                    } else if (cause instanceof Error) {
                        throw ((Error) cause);
                    } else {
                        throw new IllegalStateException(cause);
                    }
                } catch (Throwable th) {
                    cancel(true);
                }
            } else {
                t = get(timeout.longValue(), unit);
                cancel(true);
            }
            return t;
        }

        public T getResult() throws OperationCanceledException, IOException, AuthenticatorException {
            return internalGetResult(null, null);
        }

        public T getResult(long timeout, TimeUnit unit) throws OperationCanceledException, IOException, AuthenticatorException {
            return internalGetResult(Long.valueOf(timeout), unit);
        }
    }

    /* renamed from: android.accounts.AccountManager.13 */
    class AnonymousClass13 extends Future2Task<Boolean> {
        final /* synthetic */ Account val$account;
        final /* synthetic */ UserHandle val$user;

        AnonymousClass13(Handler x0, AccountManagerCallback x1, Account account, UserHandle userHandle) {
            this.val$account = account;
            this.val$user = userHandle;
            super(x0, x1);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.copyAccountToUser(this.mResponse, this.val$account, 0, this.val$user.getIdentifier());
        }

        public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
            if (bundle.containsKey(AccountManager.KEY_BOOLEAN_RESULT)) {
                return Boolean.valueOf(bundle.getBoolean(AccountManager.KEY_BOOLEAN_RESULT));
            }
            throw new AuthenticatorException("no result in response");
        }
    }

    /* renamed from: android.accounts.AccountManager.14 */
    class AnonymousClass14 extends AmsTask {
        final /* synthetic */ Account val$account;
        final /* synthetic */ Activity val$activity;
        final /* synthetic */ Bundle val$options;
        final /* synthetic */ int val$userId;

        AnonymousClass14(Activity x0, Handler x1, AccountManagerCallback x2, Account account, Bundle bundle, Activity activity, int i) {
            this.val$account = account;
            this.val$options = bundle;
            this.val$activity = activity;
            this.val$userId = i;
            super(x0, x1, x2);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.confirmCredentialsAsUser(this.mResponse, this.val$account, this.val$options, this.val$activity != null, this.val$userId);
        }
    }

    /* renamed from: android.accounts.AccountManager.15 */
    class AnonymousClass15 extends AmsTask {
        final /* synthetic */ Account val$account;
        final /* synthetic */ Activity val$activity;
        final /* synthetic */ String val$authTokenType;
        final /* synthetic */ Bundle val$options;

        AnonymousClass15(Activity x0, Handler x1, AccountManagerCallback x2, Account account, String str, Activity activity, Bundle bundle) {
            this.val$account = account;
            this.val$authTokenType = str;
            this.val$activity = activity;
            this.val$options = bundle;
            super(x0, x1, x2);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.updateCredentials(this.mResponse, this.val$account, this.val$authTokenType, this.val$activity != null, this.val$options);
        }
    }

    /* renamed from: android.accounts.AccountManager.16 */
    class AnonymousClass16 extends AmsTask {
        final /* synthetic */ String val$accountType;
        final /* synthetic */ Activity val$activity;

        AnonymousClass16(Activity x0, Handler x1, AccountManagerCallback x2, String str, Activity activity) {
            this.val$accountType = str;
            this.val$activity = activity;
            super(x0, x1, x2);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.editProperties(this.mResponse, this.val$accountType, this.val$activity != null);
        }
    }

    /* renamed from: android.accounts.AccountManager.17 */
    class AnonymousClass17 implements Runnable {
        final /* synthetic */ AccountManagerCallback val$callback;
        final /* synthetic */ AccountManagerFuture val$future;

        AnonymousClass17(AccountManagerCallback accountManagerCallback, AccountManagerFuture accountManagerFuture) {
            this.val$callback = accountManagerCallback;
            this.val$future = accountManagerFuture;
        }

        public void run() {
            this.val$callback.run(this.val$future);
        }
    }

    /* renamed from: android.accounts.AccountManager.18 */
    class AnonymousClass18 implements Runnable {
        final /* synthetic */ Account[] val$accountsCopy;
        final /* synthetic */ OnAccountsUpdateListener val$listener;

        AnonymousClass18(OnAccountsUpdateListener onAccountsUpdateListener, Account[] accountArr) {
            this.val$listener = onAccountsUpdateListener;
            this.val$accountsCopy = accountArr;
        }

        public void run() {
            try {
                this.val$listener.onAccountsUpdated(this.val$accountsCopy);
            } catch (SQLException e) {
                Log.e(AccountManager.TAG, "Can't update accounts", e);
            }
        }
    }

    /* renamed from: android.accounts.AccountManager.1 */
    class C00071 extends Future2Task<String> {
        final /* synthetic */ String val$accountType;
        final /* synthetic */ String val$authTokenType;

        C00071(Handler x0, AccountManagerCallback x1, String str, String str2) {
            this.val$accountType = str;
            this.val$authTokenType = str2;
            super(x0, x1);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.getAuthTokenLabel(this.mResponse, this.val$accountType, this.val$authTokenType);
        }

        public String bundleToResult(Bundle bundle) throws AuthenticatorException {
            if (bundle.containsKey(AccountManager.KEY_AUTH_TOKEN_LABEL)) {
                return bundle.getString(AccountManager.KEY_AUTH_TOKEN_LABEL);
            }
            throw new AuthenticatorException("no result in response");
        }
    }

    /* renamed from: android.accounts.AccountManager.2 */
    class C00082 extends Future2Task<Boolean> {
        final /* synthetic */ Account val$account;
        final /* synthetic */ String[] val$features;

        C00082(Handler x0, AccountManagerCallback x1, Account account, String[] strArr) {
            this.val$account = account;
            this.val$features = strArr;
            super(x0, x1);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.hasFeatures(this.mResponse, this.val$account, this.val$features);
        }

        public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
            if (bundle.containsKey(AccountManager.KEY_BOOLEAN_RESULT)) {
                return Boolean.valueOf(bundle.getBoolean(AccountManager.KEY_BOOLEAN_RESULT));
            }
            throw new AuthenticatorException("no result in response");
        }
    }

    /* renamed from: android.accounts.AccountManager.3 */
    class C00093 extends Future2Task<Account[]> {
        final /* synthetic */ String[] val$features;
        final /* synthetic */ String val$type;

        C00093(Handler x0, AccountManagerCallback x1, String str, String[] strArr) {
            this.val$type = str;
            this.val$features = strArr;
            super(x0, x1);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.getAccountsByFeatures(this.mResponse, this.val$type, this.val$features);
        }

        public Account[] bundleToResult(Bundle bundle) throws AuthenticatorException {
            if (bundle.containsKey(AccountManager.KEY_ACCOUNTS)) {
                Parcelable[] parcelables = bundle.getParcelableArray(AccountManager.KEY_ACCOUNTS);
                Account[] descs = new Account[parcelables.length];
                for (int i = 0; i < parcelables.length; i += AccountManager.ERROR_CODE_REMOTE_EXCEPTION) {
                    descs[i] = (Account) parcelables[i];
                }
                return descs;
            }
            throw new AuthenticatorException("no result in response");
        }
    }

    /* renamed from: android.accounts.AccountManager.4 */
    class C00104 extends Future2Task<Account> {
        final /* synthetic */ Account val$account;
        final /* synthetic */ String val$newName;

        C00104(Handler x0, AccountManagerCallback x1, Account account, String str) {
            this.val$account = account;
            this.val$newName = str;
            super(x0, x1);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.renameAccount(this.mResponse, this.val$account, this.val$newName);
        }

        public Account bundleToResult(Bundle bundle) throws AuthenticatorException {
            return new Account(bundle.getString(AccountManager.KEY_ACCOUNT_NAME), bundle.getString(AccountManager.KEY_ACCOUNT_TYPE));
        }
    }

    /* renamed from: android.accounts.AccountManager.5 */
    class C00115 extends Future2Task<Boolean> {
        final /* synthetic */ Account val$account;

        C00115(Handler x0, AccountManagerCallback x1, Account account) {
            this.val$account = account;
            super(x0, x1);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.removeAccount(this.mResponse, this.val$account, false);
        }

        public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
            if (bundle.containsKey(AccountManager.KEY_BOOLEAN_RESULT)) {
                return Boolean.valueOf(bundle.getBoolean(AccountManager.KEY_BOOLEAN_RESULT));
            }
            throw new AuthenticatorException("no result in response");
        }
    }

    /* renamed from: android.accounts.AccountManager.6 */
    class C00126 extends AmsTask {
        final /* synthetic */ Account val$account;
        final /* synthetic */ Activity val$activity;

        C00126(Activity x0, Handler x1, AccountManagerCallback x2, Account account, Activity activity) {
            this.val$account = account;
            this.val$activity = activity;
            super(x0, x1, x2);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.removeAccount(this.mResponse, this.val$account, this.val$activity != null);
        }
    }

    /* renamed from: android.accounts.AccountManager.7 */
    class C00137 extends Future2Task<Boolean> {
        final /* synthetic */ Account val$account;
        final /* synthetic */ UserHandle val$userHandle;

        C00137(Handler x0, AccountManagerCallback x1, Account account, UserHandle userHandle) {
            this.val$account = account;
            this.val$userHandle = userHandle;
            super(x0, x1);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.removeAccountAsUser(this.mResponse, this.val$account, false, this.val$userHandle.getIdentifier());
        }

        public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
            if (bundle.containsKey(AccountManager.KEY_BOOLEAN_RESULT)) {
                return Boolean.valueOf(bundle.getBoolean(AccountManager.KEY_BOOLEAN_RESULT));
            }
            throw new AuthenticatorException("no result in response");
        }
    }

    /* renamed from: android.accounts.AccountManager.8 */
    class C00148 extends AmsTask {
        final /* synthetic */ Account val$account;
        final /* synthetic */ Activity val$activity;
        final /* synthetic */ UserHandle val$userHandle;

        C00148(Activity x0, Handler x1, AccountManagerCallback x2, Account account, Activity activity, UserHandle userHandle) {
            this.val$account = account;
            this.val$activity = activity;
            this.val$userHandle = userHandle;
            super(x0, x1, x2);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.removeAccountAsUser(this.mResponse, this.val$account, this.val$activity != null, this.val$userHandle.getIdentifier());
        }
    }

    /* renamed from: android.accounts.AccountManager.9 */
    class C00159 extends AmsTask {
        final /* synthetic */ Account val$account;
        final /* synthetic */ String val$authTokenType;
        final /* synthetic */ Bundle val$optionsIn;

        C00159(Activity x0, Handler x1, AccountManagerCallback x2, Account account, String str, Bundle bundle) {
            this.val$account = account;
            this.val$authTokenType = str;
            this.val$optionsIn = bundle;
            super(x0, x1, x2);
        }

        public void doWork() throws RemoteException {
            AccountManager.this.mService.getAuthToken(this.mResponse, this.val$account, this.val$authTokenType, false, true, this.val$optionsIn);
        }
    }

    private class GetAuthTokenByTypeAndFeaturesTask extends AmsTask implements AccountManagerCallback<Bundle> {
        final String mAccountType;
        final Bundle mAddAccountOptions;
        final String mAuthTokenType;
        final String[] mFeatures;
        volatile AccountManagerFuture<Bundle> mFuture;
        final Bundle mLoginOptions;
        final AccountManagerCallback<Bundle> mMyCallback;
        private volatile int mNumAccounts;

        /* renamed from: android.accounts.AccountManager.GetAuthTokenByTypeAndFeaturesTask.1 */
        class C00201 implements AccountManagerCallback<Account[]> {

            /* renamed from: android.accounts.AccountManager.GetAuthTokenByTypeAndFeaturesTask.1.1 */
            class C00191 extends Stub {
                C00191() {
                }

                public void onResult(Bundle value) throws RemoteException {
                    Account account = new Account(value.getString(AccountManager.KEY_ACCOUNT_NAME), value.getString(AccountManager.KEY_ACCOUNT_TYPE));
                    GetAuthTokenByTypeAndFeaturesTask.this.mFuture = AccountManager.this.getAuthToken(account, GetAuthTokenByTypeAndFeaturesTask.this.mAuthTokenType, GetAuthTokenByTypeAndFeaturesTask.this.mLoginOptions, GetAuthTokenByTypeAndFeaturesTask.this.mActivity, GetAuthTokenByTypeAndFeaturesTask.this.mMyCallback, GetAuthTokenByTypeAndFeaturesTask.this.mHandler);
                }

                public void onError(int errorCode, String errorMessage) throws RemoteException {
                    GetAuthTokenByTypeAndFeaturesTask.this.mResponse.onError(errorCode, errorMessage);
                }
            }

            C00201() {
            }

            public void run(AccountManagerFuture<Account[]> future) {
                try {
                    Parcelable[] accounts = (Account[]) future.getResult();
                    GetAuthTokenByTypeAndFeaturesTask.this.mNumAccounts = accounts.length;
                    Bundle result;
                    if (accounts.length == 0) {
                        if (GetAuthTokenByTypeAndFeaturesTask.this.mActivity != null) {
                            GetAuthTokenByTypeAndFeaturesTask.this.mFuture = AccountManager.this.addAccount(GetAuthTokenByTypeAndFeaturesTask.this.mAccountType, GetAuthTokenByTypeAndFeaturesTask.this.mAuthTokenType, GetAuthTokenByTypeAndFeaturesTask.this.mFeatures, GetAuthTokenByTypeAndFeaturesTask.this.mAddAccountOptions, GetAuthTokenByTypeAndFeaturesTask.this.mActivity, GetAuthTokenByTypeAndFeaturesTask.this.mMyCallback, GetAuthTokenByTypeAndFeaturesTask.this.mHandler);
                            return;
                        }
                        result = new Bundle();
                        result.putString(AccountManager.KEY_ACCOUNT_NAME, null);
                        result.putString(AccountManager.KEY_ACCOUNT_TYPE, null);
                        result.putString(AccountManager.KEY_AUTHTOKEN, null);
                        try {
                            GetAuthTokenByTypeAndFeaturesTask.this.mResponse.onResult(result);
                        } catch (RemoteException e) {
                        }
                    } else if (accounts.length == AccountManager.ERROR_CODE_REMOTE_EXCEPTION) {
                        if (GetAuthTokenByTypeAndFeaturesTask.this.mActivity == null) {
                            GetAuthTokenByTypeAndFeaturesTask.this.mFuture = AccountManager.this.getAuthToken(accounts[0], GetAuthTokenByTypeAndFeaturesTask.this.mAuthTokenType, false, GetAuthTokenByTypeAndFeaturesTask.this.mMyCallback, GetAuthTokenByTypeAndFeaturesTask.this.mHandler);
                            return;
                        }
                        GetAuthTokenByTypeAndFeaturesTask.this.mFuture = AccountManager.this.getAuthToken(accounts[0], GetAuthTokenByTypeAndFeaturesTask.this.mAuthTokenType, GetAuthTokenByTypeAndFeaturesTask.this.mLoginOptions, GetAuthTokenByTypeAndFeaturesTask.this.mActivity, GetAuthTokenByTypeAndFeaturesTask.this.mMyCallback, GetAuthTokenByTypeAndFeaturesTask.this.mHandler);
                    } else if (GetAuthTokenByTypeAndFeaturesTask.this.mActivity != null) {
                        IAccountManagerResponse chooseResponse = new C00191();
                        Intent intent = new Intent();
                        ComponentName componentName = ComponentName.unflattenFromString(Resources.getSystem().getString(17039426));
                        intent.setClassName(componentName.getPackageName(), componentName.getClassName());
                        intent.putExtra(AccountManager.KEY_ACCOUNTS, accounts);
                        intent.putExtra(AccountManager.KEY_ACCOUNT_MANAGER_RESPONSE, new AccountManagerResponse(chooseResponse));
                        GetAuthTokenByTypeAndFeaturesTask.this.mActivity.startActivity(intent);
                    } else {
                        result = new Bundle();
                        result.putString(AccountManager.KEY_ACCOUNTS, null);
                        try {
                            GetAuthTokenByTypeAndFeaturesTask.this.mResponse.onResult(result);
                        } catch (RemoteException e2) {
                        }
                    }
                } catch (OperationCanceledException e3) {
                    GetAuthTokenByTypeAndFeaturesTask.this.setException(e3);
                } catch (IOException e4) {
                    GetAuthTokenByTypeAndFeaturesTask.this.setException(e4);
                } catch (AuthenticatorException e5) {
                    GetAuthTokenByTypeAndFeaturesTask.this.setException(e5);
                }
            }
        }

        GetAuthTokenByTypeAndFeaturesTask(String accountType, String authTokenType, String[] features, Activity activityForPrompting, Bundle addAccountOptions, Bundle loginOptions, AccountManagerCallback<Bundle> callback, Handler handler) {
            super(activityForPrompting, handler, callback);
            this.mFuture = null;
            this.mNumAccounts = 0;
            if (accountType == null) {
                throw new IllegalArgumentException("account type is null");
            }
            this.mAccountType = accountType;
            this.mAuthTokenType = authTokenType;
            this.mFeatures = features;
            this.mAddAccountOptions = addAccountOptions;
            this.mLoginOptions = loginOptions;
            this.mMyCallback = this;
        }

        public void doWork() throws RemoteException {
            AccountManager.this.getAccountsByTypeAndFeatures(this.mAccountType, this.mFeatures, new C00201(), this.mHandler);
        }

        public void run(AccountManagerFuture<Bundle> future) {
            try {
                Bundle result = (Bundle) future.getResult();
                if (this.mNumAccounts == 0) {
                    String accountName = result.getString(AccountManager.KEY_ACCOUNT_NAME);
                    String accountType = result.getString(AccountManager.KEY_ACCOUNT_TYPE);
                    if (TextUtils.isEmpty(accountName) || TextUtils.isEmpty(accountType)) {
                        setException(new AuthenticatorException("account not in result"));
                        return;
                    }
                    Account account = new Account(accountName, accountType);
                    this.mNumAccounts = AccountManager.ERROR_CODE_REMOTE_EXCEPTION;
                    AccountManager.this.getAuthToken(account, this.mAuthTokenType, null, this.mActivity, this.mMyCallback, this.mHandler);
                    return;
                }
                set(result);
            } catch (OperationCanceledException e) {
                cancel(true);
            } catch (IOException e2) {
                setException(e2);
            } catch (AuthenticatorException e3) {
                setException(e3);
            }
        }
    }

    public AccountManager(Context context, IAccountManager service) {
        this.mAccountsUpdatedListeners = Maps.newHashMap();
        this.mAccountsChangedBroadcastReceiver = new BroadcastReceiver() {
            public void onReceive(Context context, Intent intent) {
                Account[] accounts = AccountManager.this.getAccounts();
                synchronized (AccountManager.this.mAccountsUpdatedListeners) {
                    for (Entry<OnAccountsUpdateListener, Handler> entry : AccountManager.this.mAccountsUpdatedListeners.entrySet()) {
                        AccountManager.this.postToHandler((Handler) entry.getValue(), (OnAccountsUpdateListener) entry.getKey(), accounts);
                    }
                }
            }
        };
        this.mContext = context;
        this.mService = service;
        this.mMainHandler = new Handler(this.mContext.getMainLooper());
    }

    public AccountManager(Context context, IAccountManager service, Handler handler) {
        this.mAccountsUpdatedListeners = Maps.newHashMap();
        this.mAccountsChangedBroadcastReceiver = new BroadcastReceiver() {
            public void onReceive(Context context, Intent intent) {
                Account[] accounts = AccountManager.this.getAccounts();
                synchronized (AccountManager.this.mAccountsUpdatedListeners) {
                    for (Entry<OnAccountsUpdateListener, Handler> entry : AccountManager.this.mAccountsUpdatedListeners.entrySet()) {
                        AccountManager.this.postToHandler((Handler) entry.getValue(), (OnAccountsUpdateListener) entry.getKey(), accounts);
                    }
                }
            }
        };
        this.mContext = context;
        this.mService = service;
        this.mMainHandler = handler;
    }

    public static Bundle sanitizeResult(Bundle result) {
        if (result == null || !result.containsKey(KEY_AUTHTOKEN) || TextUtils.isEmpty(result.getString(KEY_AUTHTOKEN))) {
            return result;
        }
        Bundle newResult = new Bundle(result);
        newResult.putString(KEY_AUTHTOKEN, "<omitted for logging purposes>");
        return newResult;
    }

    public static AccountManager get(Context context) {
        if (context != null) {
            return (AccountManager) context.getSystemService(Context.ACCOUNT_SERVICE);
        }
        throw new IllegalArgumentException("context is null");
    }

    public String getPassword(Account account) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        try {
            return this.mService.getPassword(account);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public String getUserData(Account account, String key) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (key == null) {
            throw new IllegalArgumentException("key is null");
        } else {
            try {
                return this.mService.getUserData(account, key);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public AuthenticatorDescription[] getAuthenticatorTypes() {
        try {
            return this.mService.getAuthenticatorTypes(UserHandle.getCallingUserId());
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public AuthenticatorDescription[] getAuthenticatorTypesAsUser(int userId) {
        try {
            return this.mService.getAuthenticatorTypes(userId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public Account[] getAccounts() {
        try {
            return this.mService.getAccounts(null);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public Account[] getAccountsAsUser(int userId) {
        try {
            return this.mService.getAccountsAsUser(null, userId);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public Account[] getAccountsForPackage(String packageName, int uid) {
        try {
            return this.mService.getAccountsForPackage(packageName, uid);
        } catch (RemoteException re) {
            throw new RuntimeException(re);
        }
    }

    public Account[] getAccountsByTypeForPackage(String type, String packageName) {
        try {
            return this.mService.getAccountsByTypeForPackage(type, packageName);
        } catch (RemoteException re) {
            throw new RuntimeException(re);
        }
    }

    public Account[] getAccountsByType(String type) {
        return getAccountsByTypeAsUser(type, Process.myUserHandle());
    }

    public Account[] getAccountsByTypeAsUser(String type, UserHandle userHandle) {
        try {
            return this.mService.getAccountsAsUser(type, userHandle.getIdentifier());
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateAppPermission(Account account, String authTokenType, int uid, boolean value) {
        try {
            this.mService.updateAppPermission(account, authTokenType, uid, value);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public AccountManagerFuture<String> getAuthTokenLabel(String accountType, String authTokenType, AccountManagerCallback<String> callback, Handler handler) {
        if (accountType == null) {
            throw new IllegalArgumentException("accountType is null");
        } else if (authTokenType != null) {
            return new C00071(handler, callback, accountType, authTokenType).start();
        } else {
            throw new IllegalArgumentException("authTokenType is null");
        }
    }

    public AccountManagerFuture<Boolean> hasFeatures(Account account, String[] features, AccountManagerCallback<Boolean> callback, Handler handler) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (features != null) {
            return new C00082(handler, callback, account, features).start();
        } else {
            throw new IllegalArgumentException("features is null");
        }
    }

    public AccountManagerFuture<Account[]> getAccountsByTypeAndFeatures(String type, String[] features, AccountManagerCallback<Account[]> callback, Handler handler) {
        if (type != null) {
            return new C00093(handler, callback, type, features).start();
        }
        throw new IllegalArgumentException("type is null");
    }

    public boolean addAccountExplicitly(Account account, String password, Bundle userdata) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        try {
            return this.mService.addAccountExplicitly(account, password, userdata);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public AccountManagerFuture<Account> renameAccount(Account account, String newName, AccountManagerCallback<Account> callback, Handler handler) {
        if (account == null) {
            throw new IllegalArgumentException("account is null.");
        } else if (!TextUtils.isEmpty(newName)) {
            return new C00104(handler, callback, account, newName).start();
        } else {
            throw new IllegalArgumentException("newName is empty or null.");
        }
    }

    public String getPreviousName(Account account) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        try {
            return this.mService.getPreviousName(account);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    @Deprecated
    public AccountManagerFuture<Boolean> removeAccount(Account account, AccountManagerCallback<Boolean> callback, Handler handler) {
        if (account != null) {
            return new C00115(handler, callback, account).start();
        }
        throw new IllegalArgumentException("account is null");
    }

    public AccountManagerFuture<Bundle> removeAccount(Account account, Activity activity, AccountManagerCallback<Bundle> callback, Handler handler) {
        if (account != null) {
            return new C00126(activity, handler, callback, account, activity).start();
        }
        throw new IllegalArgumentException("account is null");
    }

    @Deprecated
    public AccountManagerFuture<Boolean> removeAccountAsUser(Account account, AccountManagerCallback<Boolean> callback, Handler handler, UserHandle userHandle) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (userHandle != null) {
            return new C00137(handler, callback, account, userHandle).start();
        } else {
            throw new IllegalArgumentException("userHandle is null");
        }
    }

    public AccountManagerFuture<Bundle> removeAccountAsUser(Account account, Activity activity, AccountManagerCallback<Bundle> callback, Handler handler, UserHandle userHandle) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (userHandle != null) {
            return new C00148(activity, handler, callback, account, activity, userHandle).start();
        } else {
            throw new IllegalArgumentException("userHandle is null");
        }
    }

    public boolean removeAccountExplicitly(Account account) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        try {
            return this.mService.removeAccountExplicitly(account);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public void invalidateAuthToken(String accountType, String authToken) {
        if (accountType == null) {
            throw new IllegalArgumentException("accountType is null");
        } else if (authToken != null) {
            try {
                this.mService.invalidateAuthToken(accountType, authToken);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public String peekAuthToken(Account account, String authTokenType) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (authTokenType == null) {
            throw new IllegalArgumentException("authTokenType is null");
        } else {
            try {
                return this.mService.peekAuthToken(account, authTokenType);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void setPassword(Account account, String password) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        try {
            this.mService.setPassword(account, password);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public void clearPassword(Account account) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        try {
            this.mService.clearPassword(account);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public void setUserData(Account account, String key, String value) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (key == null) {
            throw new IllegalArgumentException("key is null");
        } else {
            try {
                this.mService.setUserData(account, key, value);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void setAuthToken(Account account, String authTokenType, String authToken) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (authTokenType == null) {
            throw new IllegalArgumentException("authTokenType is null");
        } else {
            try {
                this.mService.setAuthToken(account, authTokenType, authToken);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public String blockingGetAuthToken(Account account, String authTokenType, boolean notifyAuthFailure) throws OperationCanceledException, IOException, AuthenticatorException {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (authTokenType == null) {
            throw new IllegalArgumentException("authTokenType is null");
        } else {
            Bundle bundle = (Bundle) getAuthToken(account, authTokenType, notifyAuthFailure, null, null).getResult();
            if (bundle != null) {
                return bundle.getString(KEY_AUTHTOKEN);
            }
            Log.e(TAG, "blockingGetAuthToken: null was returned from getResult() for " + account + ", authTokenType " + authTokenType);
            return null;
        }
    }

    public AccountManagerFuture<Bundle> getAuthToken(Account account, String authTokenType, Bundle options, Activity activity, AccountManagerCallback<Bundle> callback, Handler handler) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (authTokenType == null) {
            throw new IllegalArgumentException("authTokenType is null");
        } else {
            Bundle optionsIn = new Bundle();
            if (options != null) {
                optionsIn.putAll(options);
            }
            optionsIn.putString(KEY_ANDROID_PACKAGE_NAME, this.mContext.getPackageName());
            return new C00159(activity, handler, callback, account, authTokenType, optionsIn).start();
        }
    }

    @Deprecated
    public AccountManagerFuture<Bundle> getAuthToken(Account account, String authTokenType, boolean notifyAuthFailure, AccountManagerCallback<Bundle> callback, Handler handler) {
        return getAuthToken(account, authTokenType, null, notifyAuthFailure, (AccountManagerCallback) callback, handler);
    }

    public AccountManagerFuture<Bundle> getAuthToken(Account account, String authTokenType, Bundle options, boolean notifyAuthFailure, AccountManagerCallback<Bundle> callback, Handler handler) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (authTokenType == null) {
            throw new IllegalArgumentException("authTokenType is null");
        } else {
            Bundle optionsIn = new Bundle();
            if (options != null) {
                optionsIn.putAll(options);
            }
            optionsIn.putString(KEY_ANDROID_PACKAGE_NAME, this.mContext.getPackageName());
            return new AnonymousClass10(null, handler, callback, account, authTokenType, notifyAuthFailure, optionsIn).start();
        }
    }

    public AccountManagerFuture<Bundle> addAccount(String accountType, String authTokenType, String[] requiredFeatures, Bundle addAccountOptions, Activity activity, AccountManagerCallback<Bundle> callback, Handler handler) {
        if (accountType == null) {
            throw new IllegalArgumentException("accountType is null");
        }
        Bundle optionsIn = new Bundle();
        if (addAccountOptions != null) {
            optionsIn.putAll(addAccountOptions);
        }
        optionsIn.putString(KEY_ANDROID_PACKAGE_NAME, this.mContext.getPackageName());
        return new AnonymousClass11(activity, handler, callback, accountType, authTokenType, requiredFeatures, activity, optionsIn).start();
    }

    public AccountManagerFuture<Bundle> addAccountAsUser(String accountType, String authTokenType, String[] requiredFeatures, Bundle addAccountOptions, Activity activity, AccountManagerCallback<Bundle> callback, Handler handler, UserHandle userHandle) {
        if (accountType == null) {
            throw new IllegalArgumentException("accountType is null");
        } else if (userHandle == null) {
            throw new IllegalArgumentException("userHandle is null");
        } else {
            Bundle optionsIn = new Bundle();
            if (addAccountOptions != null) {
                optionsIn.putAll(addAccountOptions);
            }
            optionsIn.putString(KEY_ANDROID_PACKAGE_NAME, this.mContext.getPackageName());
            return new AnonymousClass12(activity, handler, callback, accountType, authTokenType, requiredFeatures, activity, optionsIn, userHandle).start();
        }
    }

    public boolean addSharedAccount(Account account, UserHandle user) {
        try {
            return this.mService.addSharedAccountAsUser(account, user.getIdentifier());
        } catch (RemoteException re) {
            throw new RuntimeException(re);
        }
    }

    public AccountManagerFuture<Boolean> copyAccountToUser(Account account, UserHandle user, AccountManagerCallback<Boolean> callback, Handler handler) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        } else if (user != null) {
            return new AnonymousClass13(handler, callback, account, user).start();
        } else {
            throw new IllegalArgumentException("user is null");
        }
    }

    public boolean removeSharedAccount(Account account, UserHandle user) {
        try {
            return this.mService.removeSharedAccountAsUser(account, user.getIdentifier());
        } catch (RemoteException re) {
            throw new RuntimeException(re);
        }
    }

    public Account[] getSharedAccounts(UserHandle user) {
        try {
            return this.mService.getSharedAccountsAsUser(user.getIdentifier());
        } catch (RemoteException re) {
            throw new RuntimeException(re);
        }
    }

    public AccountManagerFuture<Bundle> confirmCredentials(Account account, Bundle options, Activity activity, AccountManagerCallback<Bundle> callback, Handler handler) {
        return confirmCredentialsAsUser(account, options, activity, callback, handler, Process.myUserHandle());
    }

    public AccountManagerFuture<Bundle> confirmCredentialsAsUser(Account account, Bundle options, Activity activity, AccountManagerCallback<Bundle> callback, Handler handler, UserHandle userHandle) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }
        return new AnonymousClass14(activity, handler, callback, account, options, activity, userHandle.getIdentifier()).start();
    }

    public AccountManagerFuture<Bundle> updateCredentials(Account account, String authTokenType, Bundle options, Activity activity, AccountManagerCallback<Bundle> callback, Handler handler) {
        if (account != null) {
            return new AnonymousClass15(activity, handler, callback, account, authTokenType, activity, options).start();
        }
        throw new IllegalArgumentException("account is null");
    }

    public AccountManagerFuture<Bundle> editProperties(String accountType, Activity activity, AccountManagerCallback<Bundle> callback, Handler handler) {
        if (accountType != null) {
            return new AnonymousClass16(activity, handler, callback, accountType, activity).start();
        }
        throw new IllegalArgumentException("accountType is null");
    }

    private void ensureNotOnMainThread() {
        Looper looper = Looper.myLooper();
        if (looper != null && looper == this.mContext.getMainLooper()) {
            IllegalStateException exception = new IllegalStateException("calling this from your main thread can lead to deadlock");
            Log.e(TAG, "calling this from your main thread can lead to deadlock and/or ANRs", exception);
            if (this.mContext.getApplicationInfo().targetSdkVersion >= ERROR_CODE_BAD_REQUEST) {
                throw exception;
            }
        }
    }

    private void postToHandler(Handler handler, AccountManagerCallback<Bundle> callback, AccountManagerFuture<Bundle> future) {
        if (handler == null) {
            handler = this.mMainHandler;
        }
        handler.post(new AnonymousClass17(callback, future));
    }

    private void postToHandler(Handler handler, OnAccountsUpdateListener listener, Account[] accounts) {
        Account[] accountsCopy = new Account[accounts.length];
        System.arraycopy(accounts, 0, accountsCopy, 0, accountsCopy.length);
        if (handler == null) {
            handler = this.mMainHandler;
        }
        handler.post(new AnonymousClass18(listener, accountsCopy));
    }

    private Exception convertErrorToException(int code, String message) {
        if (code == ERROR_CODE_NETWORK_ERROR) {
            return new IOException(message);
        }
        if (code == ERROR_CODE_UNSUPPORTED_OPERATION) {
            return new UnsupportedOperationException(message);
        }
        if (code == ERROR_CODE_INVALID_RESPONSE) {
            return new AuthenticatorException(message);
        }
        if (code == ERROR_CODE_BAD_ARGUMENTS) {
            return new IllegalArgumentException(message);
        }
        return new AuthenticatorException(message);
    }

    public AccountManagerFuture<Bundle> getAuthTokenByFeatures(String accountType, String authTokenType, String[] features, Activity activity, Bundle addAccountOptions, Bundle getAuthTokenOptions, AccountManagerCallback<Bundle> callback, Handler handler) {
        if (accountType == null) {
            throw new IllegalArgumentException("account type is null");
        } else if (authTokenType == null) {
            throw new IllegalArgumentException("authTokenType is null");
        } else {
            GetAuthTokenByTypeAndFeaturesTask task = new GetAuthTokenByTypeAndFeaturesTask(accountType, authTokenType, features, activity, addAccountOptions, getAuthTokenOptions, callback, handler);
            task.start();
            return task;
        }
    }

    public static Intent newChooseAccountIntent(Account selectedAccount, ArrayList<Account> allowableAccounts, String[] allowableAccountTypes, boolean alwaysPromptForAccount, String descriptionOverrideText, String addAccountAuthTokenType, String[] addAccountRequiredFeatures, Bundle addAccountOptions) {
        Intent intent = new Intent();
        ComponentName componentName = ComponentName.unflattenFromString(Resources.getSystem().getString(17039427));
        intent.setClassName(componentName.getPackageName(), componentName.getClassName());
        intent.putExtra(ChooseTypeAndAccountActivity.EXTRA_ALLOWABLE_ACCOUNTS_ARRAYLIST, (Serializable) allowableAccounts);
        intent.putExtra(ChooseTypeAndAccountActivity.EXTRA_ALLOWABLE_ACCOUNT_TYPES_STRING_ARRAY, allowableAccountTypes);
        intent.putExtra(ChooseTypeAndAccountActivity.EXTRA_ADD_ACCOUNT_OPTIONS_BUNDLE, addAccountOptions);
        intent.putExtra(ChooseTypeAndAccountActivity.EXTRA_SELECTED_ACCOUNT, (Parcelable) selectedAccount);
        intent.putExtra(ChooseTypeAndAccountActivity.EXTRA_ALWAYS_PROMPT_FOR_ACCOUNT, alwaysPromptForAccount);
        intent.putExtra(ChooseTypeAndAccountActivity.EXTRA_DESCRIPTION_TEXT_OVERRIDE, descriptionOverrideText);
        intent.putExtra(GrantCredentialsPermissionActivity.EXTRAS_AUTH_TOKEN_TYPE, addAccountAuthTokenType);
        intent.putExtra(ChooseTypeAndAccountActivity.EXTRA_ADD_ACCOUNT_REQUIRED_FEATURES_STRING_ARRAY, addAccountRequiredFeatures);
        return intent;
    }

    public void addOnAccountsUpdatedListener(OnAccountsUpdateListener listener, Handler handler, boolean updateImmediately) {
        if (listener == null) {
            throw new IllegalArgumentException("the listener is null");
        }
        synchronized (this.mAccountsUpdatedListeners) {
            if (this.mAccountsUpdatedListeners.containsKey(listener)) {
                throw new IllegalStateException("this listener is already added");
            }
            boolean wasEmpty = this.mAccountsUpdatedListeners.isEmpty();
            this.mAccountsUpdatedListeners.put(listener, handler);
            if (wasEmpty) {
                IntentFilter intentFilter = new IntentFilter();
                intentFilter.addAction(LOGIN_ACCOUNTS_CHANGED_ACTION);
                intentFilter.addAction(Intent.ACTION_DEVICE_STORAGE_OK);
                this.mContext.registerReceiver(this.mAccountsChangedBroadcastReceiver, intentFilter);
            }
        }
        if (updateImmediately) {
            postToHandler(handler, listener, getAccounts());
        }
    }

    public void removeOnAccountsUpdatedListener(OnAccountsUpdateListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener is null");
        }
        synchronized (this.mAccountsUpdatedListeners) {
            if (this.mAccountsUpdatedListeners.containsKey(listener)) {
                this.mAccountsUpdatedListeners.remove(listener);
                if (this.mAccountsUpdatedListeners.isEmpty()) {
                    this.mContext.unregisterReceiver(this.mAccountsChangedBroadcastReceiver);
                }
                return;
            }
            Log.e(TAG, "Listener was not previously added");
        }
    }
}
