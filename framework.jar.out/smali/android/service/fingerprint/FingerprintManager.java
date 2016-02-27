package android.service.fingerprint;

import android.app.ActivityManagerNative;
import android.content.ContentResolver;
import android.content.Context;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.RemoteException;
import android.os.UserHandle;
import android.provider.Settings.Secure;
import android.service.fingerprint.IFingerprintServiceReceiver.Stub;
import android.util.Log;
import android.util.Slog;

public class FingerprintManager {
    private static final boolean DEBUG = false;
    public static final int FINGERPRINT_ACQUIRED = 1;
    public static final int FINGERPRINT_ACQUIRED_GOOD = 0;
    public static final int FINGERPRINT_ACQUIRED_IMAGER_DIRTY = 4;
    public static final int FINGERPRINT_ACQUIRED_INSUFFICIENT = 2;
    public static final int FINGERPRINT_ACQUIRED_PARTIAL = 1;
    public static final int FINGERPRINT_ACQUIRED_TOO_FAST = 16;
    public static final int FINGERPRINT_ACQUIRED_TOO_SLOW = 8;
    public static final int FINGERPRINT_ERROR = -1;
    public static final int FINGERPRINT_ERROR_HW_UNAVAILABLE = 1;
    public static final int FINGERPRINT_ERROR_NO_RECEIVER = -10;
    public static final int FINGERPRINT_ERROR_NO_SPACE = 4;
    public static final int FINGERPRINT_ERROR_TIMEOUT = 3;
    public static final int FINGERPRINT_ERROR_UNABLE_TO_PROCESS = 2;
    public static final int FINGERPRINT_PROCESSED = 2;
    public static final int FINGERPRINT_TEMPLATE_ENROLLING = 3;
    public static final int FINGERPRINT_TEMPLATE_REMOVED = 4;
    private static final int MSG_ACQUIRED = 101;
    private static final int MSG_ENROLL_RESULT = 100;
    private static final int MSG_ERROR = 103;
    private static final int MSG_PROCESSED = 102;
    private static final int MSG_REMOVED = 104;
    private static final String TAG = "FingerprintManager";
    private FingerprintManagerReceiver mClientReceiver;
    private Context mContext;
    private Handler mHandler;
    private IFingerprintService mService;
    private IFingerprintServiceReceiver mServiceReceiver;
    private IBinder mToken;

    /* renamed from: android.service.fingerprint.FingerprintManager.1 */
    class C06751 extends Handler {
        C06751() {
        }

        public void handleMessage(Message msg) {
            if (FingerprintManager.this.mClientReceiver != null) {
                switch (msg.what) {
                    case FingerprintManager.MSG_ENROLL_RESULT /*100*/:
                        FingerprintManager.this.mClientReceiver.onEnrollResult(msg.arg1, msg.arg2);
                    case FingerprintManager.MSG_ACQUIRED /*101*/:
                        FingerprintManager.this.mClientReceiver.onAcquired(msg.arg1);
                    case FingerprintManager.MSG_PROCESSED /*102*/:
                        FingerprintManager.this.mClientReceiver.onProcessed(msg.arg1);
                    case FingerprintManager.MSG_ERROR /*103*/:
                        FingerprintManager.this.mClientReceiver.onError(msg.arg1);
                    case FingerprintManager.MSG_REMOVED /*104*/:
                        FingerprintManager.this.mClientReceiver.onRemoved(msg.arg1);
                    default:
                }
            }
        }
    }

    /* renamed from: android.service.fingerprint.FingerprintManager.2 */
    class C06762 extends Stub {
        C06762() {
        }

        public void onEnrollResult(int fingerprintId, int remaining) {
            FingerprintManager.this.mHandler.obtainMessage(FingerprintManager.MSG_ENROLL_RESULT, fingerprintId, remaining).sendToTarget();
        }

        public void onAcquired(int acquireInfo) {
            FingerprintManager.this.mHandler.obtainMessage(FingerprintManager.MSG_ACQUIRED, acquireInfo, FingerprintManager.FINGERPRINT_ACQUIRED_GOOD).sendToTarget();
        }

        public void onProcessed(int fingerprintId) {
            FingerprintManager.this.mHandler.obtainMessage(FingerprintManager.MSG_PROCESSED, fingerprintId, FingerprintManager.FINGERPRINT_ACQUIRED_GOOD).sendToTarget();
        }

        public void onError(int error) {
            FingerprintManager.this.mHandler.obtainMessage(FingerprintManager.MSG_ERROR, error, FingerprintManager.FINGERPRINT_ACQUIRED_GOOD).sendToTarget();
        }

        public void onRemoved(int fingerprintId) {
            FingerprintManager.this.mHandler.obtainMessage(FingerprintManager.MSG_REMOVED, fingerprintId, FingerprintManager.FINGERPRINT_ACQUIRED_GOOD).sendToTarget();
        }
    }

    public FingerprintManager(Context context, IFingerprintService service) {
        this.mToken = new Binder();
        this.mHandler = new C06751();
        this.mServiceReceiver = new C06762();
        this.mContext = context;
        this.mService = service;
        if (this.mService == null) {
            Slog.v(TAG, "FingerprintManagerService was null");
        }
    }

    public boolean enrolledAndEnabled() {
        ContentResolver res = this.mContext.getContentResolver();
        if (Secure.getInt(res, "fingerprint_enabled", FINGERPRINT_ACQUIRED_GOOD) == 0 || FingerprintUtils.getFingerprintIdsForUser(res, getCurrentUserId()).length <= 0) {
            return DEBUG;
        }
        return true;
    }

    public void enroll(long timeout) {
        if (this.mServiceReceiver == null) {
            sendError(FINGERPRINT_ERROR_NO_RECEIVER, FINGERPRINT_ACQUIRED_GOOD, FINGERPRINT_ACQUIRED_GOOD);
        } else if (this.mService != null) {
            try {
                this.mService.enroll(this.mToken, timeout, getCurrentUserId());
            } catch (RemoteException e) {
                Log.v(TAG, "Remote exception while enrolling: ", e);
                sendError(FINGERPRINT_ERROR_HW_UNAVAILABLE, FINGERPRINT_ACQUIRED_GOOD, FINGERPRINT_ACQUIRED_GOOD);
            }
        }
    }

    public void remove(int fingerprintId) {
        if (this.mServiceReceiver == null) {
            sendError(FINGERPRINT_ERROR_NO_RECEIVER, FINGERPRINT_ACQUIRED_GOOD, FINGERPRINT_ACQUIRED_GOOD);
        } else if (this.mService != null) {
            try {
                this.mService.remove(this.mToken, fingerprintId, getCurrentUserId());
            } catch (RemoteException e) {
                Log.v(TAG, "Remote exception during remove of fingerprintId: " + fingerprintId, e);
            }
        } else {
            Log.w(TAG, "remove(): Service not connected!");
            sendError(FINGERPRINT_ERROR_HW_UNAVAILABLE, FINGERPRINT_ACQUIRED_GOOD, FINGERPRINT_ACQUIRED_GOOD);
        }
    }

    public void startListening(FingerprintManagerReceiver receiver) {
        this.mClientReceiver = receiver;
        if (this.mService != null) {
            try {
                this.mService.startListening(this.mToken, this.mServiceReceiver, getCurrentUserId());
                return;
            } catch (RemoteException e) {
                Log.v(TAG, "Remote exception in startListening(): ", e);
                return;
            }
        }
        Log.w(TAG, "startListening(): Service not connected!");
        sendError(FINGERPRINT_ERROR_HW_UNAVAILABLE, FINGERPRINT_ACQUIRED_GOOD, FINGERPRINT_ACQUIRED_GOOD);
    }

    private int getCurrentUserId() {
        try {
            return ActivityManagerNative.getDefault().getCurrentUser().id;
        } catch (RemoteException e) {
            Log.w(TAG, "Failed to get current user id\n");
            return UserHandle.USER_NULL;
        }
    }

    public void stopListening() {
        if (this.mService != null) {
            try {
                this.mService.stopListening(this.mToken, getCurrentUserId());
                this.mClientReceiver = null;
                return;
            } catch (RemoteException e) {
                Log.v(TAG, "Remote exception in stopListening(): ", e);
                return;
            }
        }
        Log.w(TAG, "stopListening(): Service not connected!");
        sendError(FINGERPRINT_ERROR_HW_UNAVAILABLE, FINGERPRINT_ACQUIRED_GOOD, FINGERPRINT_ACQUIRED_GOOD);
    }

    public void enrollCancel() {
        if (this.mServiceReceiver == null) {
            sendError(FINGERPRINT_ERROR_NO_RECEIVER, FINGERPRINT_ACQUIRED_GOOD, FINGERPRINT_ACQUIRED_GOOD);
        } else if (this.mService != null) {
            try {
                this.mService.enrollCancel(this.mToken, getCurrentUserId());
                this.mClientReceiver = null;
            } catch (RemoteException e) {
                Log.v(TAG, "Remote exception in enrollCancel(): ", e);
                sendError(FINGERPRINT_ERROR_HW_UNAVAILABLE, FINGERPRINT_ACQUIRED_GOOD, FINGERPRINT_ACQUIRED_GOOD);
            }
        } else {
            Log.w(TAG, "enrollCancel(): Service not connected!");
        }
    }

    private void sendError(int msg, int arg1, int arg2) {
        this.mHandler.obtainMessage(msg, arg1, arg2);
    }
}
