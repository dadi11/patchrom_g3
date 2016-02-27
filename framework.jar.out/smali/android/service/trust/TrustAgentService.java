package android.service.trust;

import android.app.Service;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.PersistableBundle;
import android.os.RemoteException;
import android.service.trust.ITrustAgentService.Stub;
import android.util.Log;
import android.util.Slog;
import java.util.List;

public class TrustAgentService extends Service {
    private static final boolean DEBUG = false;
    private static final int MSG_CONFIGURE = 2;
    private static final int MSG_DEVICE_LOCKED = 4;
    private static final int MSG_DEVICE_UNLOCKED = 5;
    private static final int MSG_TRUST_TIMEOUT = 3;
    private static final int MSG_UNLOCK_ATTEMPT = 1;
    public static final String SERVICE_INTERFACE = "android.service.trust.TrustAgentService";
    public static final String TRUST_AGENT_META_DATA = "android.service.trust.trustagent";
    private final String TAG;
    private ITrustAgentServiceCallback mCallback;
    private Handler mHandler;
    private final Object mLock;
    private boolean mManagingTrust;
    private Runnable mPendingGrantTrustTask;

    /* renamed from: android.service.trust.TrustAgentService.1 */
    class C06921 extends Handler {
        C06921() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case TrustAgentService.MSG_UNLOCK_ATTEMPT /*1*/:
                    TrustAgentService.this.onUnlockAttempt(msg.arg1 != 0 ? true : TrustAgentService.DEBUG);
                case TrustAgentService.MSG_CONFIGURE /*2*/:
                    ConfigurationData data = msg.obj;
                    boolean result = TrustAgentService.this.onConfigure(data.options);
                    try {
                        synchronized (TrustAgentService.this.mLock) {
                            TrustAgentService.this.mCallback.onConfigureCompleted(result, data.token);
                            break;
                        }
                    } catch (RemoteException e) {
                        TrustAgentService.this.onError("calling onSetTrustAgentFeaturesEnabledCompleted()");
                    }
                case TrustAgentService.MSG_TRUST_TIMEOUT /*3*/:
                    TrustAgentService.this.onTrustTimeout();
                case TrustAgentService.MSG_DEVICE_LOCKED /*4*/:
                    TrustAgentService.this.onDeviceLocked();
                case TrustAgentService.MSG_DEVICE_UNLOCKED /*5*/:
                    TrustAgentService.this.onDeviceUnlocked();
                default:
            }
        }
    }

    /* renamed from: android.service.trust.TrustAgentService.2 */
    class C06932 implements Runnable {
        final /* synthetic */ long val$durationMs;
        final /* synthetic */ boolean val$initiatedByUser;
        final /* synthetic */ CharSequence val$message;

        C06932(CharSequence charSequence, long j, boolean z) {
            this.val$message = charSequence;
            this.val$durationMs = j;
            this.val$initiatedByUser = z;
        }

        public void run() {
            TrustAgentService.this.grantTrust(this.val$message, this.val$durationMs, this.val$initiatedByUser);
        }
    }

    private static final class ConfigurationData {
        final List<PersistableBundle> options;
        final IBinder token;

        ConfigurationData(List<PersistableBundle> opts, IBinder t) {
            this.options = opts;
            this.token = t;
        }
    }

    private final class TrustAgentServiceWrapper extends Stub {
        private TrustAgentServiceWrapper() {
        }

        public void onUnlockAttempt(boolean successful) {
            int i;
            Handler access$400 = TrustAgentService.this.mHandler;
            if (successful) {
                i = TrustAgentService.MSG_UNLOCK_ATTEMPT;
            } else {
                i = 0;
            }
            access$400.obtainMessage(TrustAgentService.MSG_UNLOCK_ATTEMPT, i, 0).sendToTarget();
        }

        public void onTrustTimeout() {
            TrustAgentService.this.mHandler.sendEmptyMessage(TrustAgentService.MSG_TRUST_TIMEOUT);
        }

        public void onConfigure(List<PersistableBundle> args, IBinder token) {
            TrustAgentService.this.mHandler.obtainMessage(TrustAgentService.MSG_CONFIGURE, new ConfigurationData(args, token)).sendToTarget();
        }

        public void onDeviceLocked() throws RemoteException {
            TrustAgentService.this.mHandler.obtainMessage(TrustAgentService.MSG_DEVICE_LOCKED).sendToTarget();
        }

        public void onDeviceUnlocked() throws RemoteException {
            TrustAgentService.this.mHandler.obtainMessage(TrustAgentService.MSG_DEVICE_UNLOCKED).sendToTarget();
        }

        public void setCallback(ITrustAgentServiceCallback callback) {
            synchronized (TrustAgentService.this.mLock) {
                TrustAgentService.this.mCallback = callback;
                if (TrustAgentService.this.mManagingTrust) {
                    try {
                        TrustAgentService.this.mCallback.setManagingTrust(TrustAgentService.this.mManagingTrust);
                    } catch (RemoteException e) {
                        TrustAgentService.this.onError("calling setManagingTrust()");
                    }
                }
                if (TrustAgentService.this.mPendingGrantTrustTask != null) {
                    TrustAgentService.this.mPendingGrantTrustTask.run();
                    TrustAgentService.this.mPendingGrantTrustTask = null;
                }
            }
        }
    }

    public TrustAgentService() {
        this.TAG = TrustAgentService.class.getSimpleName() + "[" + getClass().getSimpleName() + "]";
        this.mLock = new Object();
        this.mHandler = new C06921();
    }

    public void onCreate() {
        super.onCreate();
        ComponentName component = new ComponentName((Context) this, getClass());
        try {
            if (!"android.permission.BIND_TRUST_AGENT".equals(getPackageManager().getServiceInfo(component, 0).permission)) {
                throw new IllegalStateException(component.flattenToShortString() + " is not declared with the permission " + "\"" + "android.permission.BIND_TRUST_AGENT" + "\"");
            }
        } catch (NameNotFoundException e) {
            Log.e(this.TAG, "Can't get ServiceInfo for " + component.toShortString());
        }
    }

    public void onUnlockAttempt(boolean successful) {
    }

    public void onTrustTimeout() {
    }

    public void onDeviceLocked() {
    }

    public void onDeviceUnlocked() {
    }

    private void onError(String msg) {
        Slog.v(this.TAG, "Remote exception while " + msg);
    }

    public boolean onConfigure(List<PersistableBundle> list) {
        return DEBUG;
    }

    public final void grantTrust(CharSequence message, long durationMs, boolean initiatedByUser) {
        synchronized (this.mLock) {
            if (this.mManagingTrust) {
                if (this.mCallback != null) {
                    try {
                        this.mCallback.grantTrust(message.toString(), durationMs, initiatedByUser);
                    } catch (RemoteException e) {
                        onError("calling enableTrust()");
                    }
                } else {
                    this.mPendingGrantTrustTask = new C06932(message, durationMs, initiatedByUser);
                }
            } else {
                throw new IllegalStateException("Cannot grant trust if agent is not managing trust. Call setManagingTrust(true) first.");
            }
        }
    }

    public final void revokeTrust() {
        synchronized (this.mLock) {
            if (this.mPendingGrantTrustTask != null) {
                this.mPendingGrantTrustTask = null;
            }
            if (this.mCallback != null) {
                try {
                    this.mCallback.revokeTrust();
                } catch (RemoteException e) {
                    onError("calling revokeTrust()");
                }
            }
        }
    }

    public final void setManagingTrust(boolean managingTrust) {
        synchronized (this.mLock) {
            if (this.mManagingTrust != managingTrust) {
                this.mManagingTrust = managingTrust;
                if (this.mCallback != null) {
                    try {
                        this.mCallback.setManagingTrust(managingTrust);
                    } catch (RemoteException e) {
                        onError("calling setManagingTrust()");
                    }
                }
            }
        }
    }

    public final IBinder onBind(Intent intent) {
        return new TrustAgentServiceWrapper();
    }
}
