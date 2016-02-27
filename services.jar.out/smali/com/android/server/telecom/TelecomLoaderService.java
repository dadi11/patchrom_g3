package com.android.server.telecom;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.UserHandle;
import android.util.Slog;
import com.android.server.SystemService;

public class TelecomLoaderService extends SystemService {
    private static final String SERVICE_ACTION = "com.android.ITelecomService";
    private static final ComponentName SERVICE_COMPONENT;
    private static final String TAG = "TelecomLoaderService";
    private final Context mContext;
    private TelecomServiceConnection mServiceConnection;

    private class TelecomServiceConnection implements ServiceConnection {

        /* renamed from: com.android.server.telecom.TelecomLoaderService.TelecomServiceConnection.1 */
        class C05171 implements DeathRecipient {
            C05171() {
            }

            public void binderDied() {
                TelecomLoaderService.this.connectToTelecom();
            }
        }

        private TelecomServiceConnection() {
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            try {
                service.linkToDeath(new C05171(), 0);
                ServiceManager.addService("telecom", service);
            } catch (RemoteException e) {
                Slog.w(TelecomLoaderService.TAG, "Failed linking to death.");
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            TelecomLoaderService.this.connectToTelecom();
        }
    }

    static {
        SERVICE_COMPONENT = new ComponentName("com.android.server.telecom", "com.android.server.telecom.TelecomService");
    }

    public TelecomLoaderService(Context context) {
        super(context);
        this.mContext = context;
    }

    public void onStart() {
    }

    public void onBootPhase(int phase) {
        if (phase == SystemService.PHASE_ACTIVITY_MANAGER_READY) {
            connectToTelecom();
        }
    }

    private void connectToTelecom() {
        if (this.mServiceConnection != null) {
            this.mContext.unbindService(this.mServiceConnection);
            this.mServiceConnection = null;
        }
        TelecomServiceConnection serviceConnection = new TelecomServiceConnection();
        Intent intent = new Intent(SERVICE_ACTION);
        intent.setComponent(SERVICE_COMPONENT);
        if (this.mContext.bindServiceAsUser(intent, serviceConnection, 65, UserHandle.OWNER)) {
            this.mServiceConnection = serviceConnection;
        }
    }
}
