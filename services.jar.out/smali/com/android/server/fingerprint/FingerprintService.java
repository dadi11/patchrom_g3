package com.android.server.fingerprint;

import android.content.Context;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Message;
import android.os.RemoteException;
import android.service.fingerprint.FingerprintUtils;
import android.service.fingerprint.IFingerprintService.Stub;
import android.service.fingerprint.IFingerprintServiceReceiver;
import android.util.ArrayMap;
import android.util.Slog;
import com.android.server.SystemService;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.lang.ref.WeakReference;

public class FingerprintService extends SystemService {
    private static final boolean DEBUG = false;
    public static final String ENROLL_FINGERPRINT = "android.permission.ENROLL_FINGERPRINT";
    private static final int MSG_NOTIFY = 10;
    private static final long MS_PER_SEC = 1000;
    private static final int STATE_ENROLLING = 2;
    private static final int STATE_IDLE = 0;
    private static final int STATE_LISTENING = 1;
    private static final int STATE_REMOVING = 3;
    public static final String USE_FINGERPRINT = "android.permission.USE_FINGERPRINT";
    private final String TAG;
    private ArrayMap<IBinder, ClientData> mClients;
    private Context mContext;
    Handler mHandler;

    /* renamed from: com.android.server.fingerprint.FingerprintService.1 */
    class C02501 extends Handler {
        C02501() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case FingerprintService.MSG_NOTIFY /*10*/:
                    FingerprintService.this.handleNotify(msg.arg1, msg.arg2, ((Integer) msg.obj).intValue());
                default:
                    Slog.w("FingerprintService", "Unknown message:" + msg.what);
            }
        }
    }

    private static final class ClientData {
        public IFingerprintServiceReceiver receiver;
        int state;
        public TokenWatcher tokenWatcher;
        int userId;

        private ClientData() {
        }

        IBinder getToken() {
            return this.tokenWatcher.getToken();
        }
    }

    private final class FingerprintServiceWrapper extends Stub {
        private FingerprintServiceWrapper() {
        }

        public void enroll(IBinder token, long timeout, int userId) {
            FingerprintService.this.checkPermission(FingerprintService.ENROLL_FINGERPRINT);
            FingerprintService.this.startEnroll(token, timeout, userId);
        }

        public void enrollCancel(IBinder token, int userId) {
            FingerprintService.this.checkPermission(FingerprintService.ENROLL_FINGERPRINT);
            FingerprintService.this.startEnrollCancel(token, userId);
        }

        public void remove(IBinder token, int fingerprintId, int userId) {
            FingerprintService.this.checkPermission(FingerprintService.ENROLL_FINGERPRINT);
            FingerprintService.this.startRemove(token, fingerprintId, userId);
        }

        public void startListening(IBinder token, IFingerprintServiceReceiver receiver, int userId) {
            FingerprintService.this.checkPermission(FingerprintService.USE_FINGERPRINT);
            FingerprintService.this.addListener(token, receiver, userId);
        }

        public void stopListening(IBinder token, int userId) {
            FingerprintService.this.checkPermission(FingerprintService.USE_FINGERPRINT);
            FingerprintService.this.removeListener(token, userId);
        }
    }

    private class TokenWatcher implements DeathRecipient {
        WeakReference<IBinder> token;

        TokenWatcher(IBinder token) {
            this.token = new WeakReference(token);
        }

        IBinder getToken() {
            return (IBinder) this.token.get();
        }

        public void binderDied() {
            FingerprintService.this.mClients.remove(this.token);
            this.token = null;
        }

        protected void finalize() throws Throwable {
            try {
                if (this.token != null) {
                    FingerprintService.this.mClients.remove(this.token);
                }
                super.finalize();
            } catch (Throwable th) {
                super.finalize();
            }
        }
    }

    native int nativeCloseHal();

    native int nativeEnroll(int i);

    native int nativeEnrollCancel();

    native void nativeInit(FingerprintService fingerprintService);

    native int nativeOpenHal();

    native int nativeRemove(int i);

    public FingerprintService(Context context) {
        super(context);
        this.TAG = "FingerprintService";
        this.mClients = new ArrayMap();
        this.mHandler = new C02501();
        this.mContext = context;
        nativeInit(this);
    }

    void notify(int msg, int arg1, int arg2) {
        this.mHandler.obtainMessage(MSG_NOTIFY, msg, arg1, Integer.valueOf(arg2)).sendToTarget();
    }

    void handleNotify(int msg, int arg1, int arg2) {
        Slog.v("FingerprintService", "handleNotify(msg=" + msg + ", arg1=" + arg1 + ", arg2=" + arg2 + ")");
        for (int i = STATE_IDLE; i < this.mClients.size(); i += STATE_LISTENING) {
            ClientData clientData = (ClientData) this.mClients.valueAt(i);
            if (!(clientData == null || clientData.receiver == null)) {
                int fingerId;
                switch (msg) {
                    case AppTransition.TRANSIT_UNSET /*-1*/:
                        try {
                            clientData.receiver.onError(arg1);
                            break;
                        } catch (RemoteException e) {
                            Slog.e("FingerprintService", "can't send message to client. Did it die?", e);
                            this.mClients.remove(this.mClients.keyAt(i));
                            break;
                        }
                    case STATE_LISTENING /*1*/:
                        try {
                            clientData.receiver.onAcquired(arg1);
                            break;
                        } catch (RemoteException e2) {
                            Slog.e("FingerprintService", "can't send message to client. Did it die?", e2);
                            this.mClients.remove(this.mClients.keyAt(i));
                            break;
                        }
                    case STATE_ENROLLING /*2*/:
                        try {
                            clientData.receiver.onProcessed(arg1);
                            break;
                        } catch (RemoteException e22) {
                            Slog.e("FingerprintService", "can't send message to client. Did it die?", e22);
                            this.mClients.remove(this.mClients.keyAt(i));
                            break;
                        }
                    case STATE_REMOVING /*3*/:
                        fingerId = arg1;
                        int remaining = arg2;
                        if (clientData.state != STATE_ENROLLING) {
                            break;
                        }
                        try {
                            clientData.receiver.onEnrollResult(fingerId, remaining);
                        } catch (RemoteException e222) {
                            Slog.e("FingerprintService", "can't send message to client. Did it die?", e222);
                            this.mClients.remove(this.mClients.keyAt(i));
                        }
                        if (remaining != 0) {
                            break;
                        }
                        FingerprintUtils.addFingerprintIdForUser(fingerId, this.mContext.getContentResolver(), clientData.userId);
                        clientData.state = STATE_IDLE;
                        break;
                    case C0569H.DO_TRAVERSAL /*4*/:
                        fingerId = arg1;
                        if (fingerId != 0) {
                            FingerprintUtils.removeFingerprintIdForUser(fingerId, this.mContext.getContentResolver(), clientData.userId);
                            if (clientData.receiver != null) {
                                try {
                                    clientData.receiver.onRemoved(fingerId);
                                } catch (RemoteException e2222) {
                                    Slog.e("FingerprintService", "can't send message to client. Did it die?", e2222);
                                    this.mClients.remove(this.mClients.keyAt(i));
                                }
                            }
                            clientData.state = STATE_LISTENING;
                            break;
                        }
                        throw new IllegalStateException("Got illegal id from HAL");
                    default:
                        break;
                }
            }
        }
    }

    void startEnroll(IBinder token, long timeout, int userId) {
        ClientData clientData = (ClientData) this.mClients.get(token);
        if (clientData == null) {
            Slog.w("FingerprintService", "enroll(): No listener registered");
        } else if (clientData.userId != userId) {
            throw new IllegalStateException("Bad user");
        } else {
            clientData.state = STATE_ENROLLING;
            nativeEnroll((int) (timeout / MS_PER_SEC));
        }
    }

    void startEnrollCancel(IBinder token, int userId) {
        ClientData clientData = (ClientData) this.mClients.get(token);
        if (clientData == null) {
            Slog.w("FingerprintService", "enrollCancel(): No listener registered");
        } else if (clientData.userId != userId) {
            throw new IllegalStateException("Bad user");
        } else {
            clientData.state = STATE_LISTENING;
            nativeEnrollCancel();
        }
    }

    void startRemove(IBinder token, int fingerId, int userId) {
        ClientData clientData = (ClientData) this.mClients.get(token);
        if (clientData == null) {
            Slog.w("FingerprintService", "remove(" + token + "): No listener registered");
        } else if (clientData.userId != userId) {
            throw new IllegalStateException("Bad user");
        } else {
            clientData.state = STATE_REMOVING;
            if (nativeRemove(fingerId) != 0) {
                Slog.w("FingerprintService", "Error removing fingerprint with id = " + fingerId);
            }
        }
    }

    void addListener(IBinder token, IFingerprintServiceReceiver receiver, int userId) {
        if (this.mClients.get(token) == null) {
            ClientData clientData = new ClientData();
            clientData.state = STATE_LISTENING;
            clientData.receiver = receiver;
            clientData.userId = userId;
            clientData.tokenWatcher = new TokenWatcher(token);
            try {
                token.linkToDeath(clientData.tokenWatcher, STATE_IDLE);
                this.mClients.put(token, clientData);
            } catch (RemoteException e) {
                Slog.w("FingerprintService", "caught remote exception in linkToDeath: ", e);
            }
        }
    }

    void removeListener(IBinder token, int userId) {
        ClientData clientData = (ClientData) this.mClients.get(token);
        if (clientData != null) {
            token.unlinkToDeath(clientData.tokenWatcher, STATE_IDLE);
            this.mClients.remove(token);
        }
        this.mClients.remove(token);
    }

    void checkPermission(String permisison) {
    }

    public void onStart() {
        publishBinderService("fingerprint", new FingerprintServiceWrapper());
        nativeOpenHal();
    }
}
