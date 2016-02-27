package com.android.server.connectivity;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.net.ProxyInfo;
import android.net.Uri;
import android.os.Handler;
import android.os.IBinder;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.provider.Settings.Global;
import android.util.Log;
import com.android.internal.annotations.GuardedBy;
import com.android.net.IProxyCallback;
import com.android.net.IProxyPortListener;
import com.android.net.IProxyService;
import com.android.net.IProxyService.Stub;
import com.android.server.IoThread;
import java.io.IOException;
import java.net.Proxy;
import java.net.URL;
import libcore.io.Streams;

public class PacManager {
    private static final String ACTION_PAC_REFRESH = "android.net.proxy.PAC_REFRESH";
    private static final String DEFAULT_DELAYS = "8 32 120 14400 43200";
    private static final int DELAY_1 = 0;
    private static final int DELAY_4 = 3;
    private static final int DELAY_LONG = 4;
    public static final String KEY_PROXY = "keyProxy";
    public static final String PAC_PACKAGE = "com.android.pacprocessor";
    public static final String PAC_SERVICE = "com.android.pacprocessor.PacService";
    public static final String PAC_SERVICE_NAME = "com.android.net.IProxyService";
    public static final String PROXY_PACKAGE = "com.android.proxyhandler";
    public static final String PROXY_SERVICE = "com.android.proxyhandler.ProxyService";
    private static final String TAG = "PacManager";
    private AlarmManager mAlarmManager;
    private ServiceConnection mConnection;
    private Handler mConnectivityHandler;
    private Context mContext;
    private int mCurrentDelay;
    private String mCurrentPac;
    private boolean mHasDownloaded;
    private boolean mHasSentBroadcast;
    private int mLastPort;
    private Runnable mPacDownloader;
    private PendingIntent mPacRefreshIntent;
    @GuardedBy("mProxyLock")
    private Uri mPacUrl;
    private ServiceConnection mProxyConnection;
    private final Object mProxyLock;
    private int mProxyMessage;
    @GuardedBy("mProxyLock")
    private IProxyService mProxyService;

    /* renamed from: com.android.server.connectivity.PacManager.1 */
    class C01651 implements Runnable {
        C01651() {
        }

        public void run() {
            synchronized (PacManager.this.mProxyLock) {
                if (Uri.EMPTY.equals(PacManager.this.mPacUrl)) {
                    return;
                }
                try {
                    String file = PacManager.get(PacManager.this.mPacUrl);
                } catch (IOException ioe) {
                    file = null;
                    Log.w(PacManager.TAG, "Failed to load PAC file: " + ioe);
                }
                if (file != null) {
                    synchronized (PacManager.this.mProxyLock) {
                        if (!file.equals(PacManager.this.mCurrentPac)) {
                            PacManager.this.setCurrentProxyScript(file);
                        }
                    }
                    PacManager.this.mHasDownloaded = true;
                    PacManager.this.sendProxyIfNeeded();
                    PacManager.this.longSchedule();
                    return;
                }
                PacManager.this.reschedule();
            }
        }
    }

    /* renamed from: com.android.server.connectivity.PacManager.2 */
    class C01662 implements ServiceConnection {
        C01662() {
        }

        public void onServiceDisconnected(ComponentName component) {
            synchronized (PacManager.this.mProxyLock) {
                PacManager.this.mProxyService = null;
            }
        }

        public void onServiceConnected(ComponentName component, IBinder binder) {
            synchronized (PacManager.this.mProxyLock) {
                try {
                    Log.d(PacManager.TAG, "Adding service com.android.net.IProxyService " + binder.getInterfaceDescriptor());
                } catch (RemoteException e1) {
                    Log.e(PacManager.TAG, "Remote Exception", e1);
                }
                ServiceManager.addService(PacManager.PAC_SERVICE_NAME, binder);
                PacManager.this.mProxyService = Stub.asInterface(binder);
                if (PacManager.this.mProxyService == null) {
                    Log.e(PacManager.TAG, "No proxy service");
                } else {
                    try {
                        PacManager.this.mProxyService.startPacSystem();
                    } catch (RemoteException e) {
                        Log.e(PacManager.TAG, "Unable to reach ProxyService - PAC will not be started", e);
                    }
                    IoThread.getHandler().post(PacManager.this.mPacDownloader);
                }
            }
        }
    }

    /* renamed from: com.android.server.connectivity.PacManager.3 */
    class C01683 implements ServiceConnection {

        /* renamed from: com.android.server.connectivity.PacManager.3.1 */
        class C01671 extends IProxyPortListener.Stub {
            C01671() {
            }

            public void setProxyPort(int port) throws RemoteException {
                if (PacManager.this.mLastPort != -1) {
                    PacManager.this.mHasSentBroadcast = false;
                }
                PacManager.this.mLastPort = port;
                if (port != -1) {
                    Log.d(PacManager.TAG, "Local proxy is bound on " + port);
                    PacManager.this.sendProxyIfNeeded();
                    return;
                }
                Log.e(PacManager.TAG, "Received invalid port from Local Proxy, PAC will not be operational");
            }
        }

        C01683() {
        }

        public void onServiceDisconnected(ComponentName component) {
        }

        public void onServiceConnected(ComponentName component, IBinder binder) {
            IProxyCallback callbackService = IProxyCallback.Stub.asInterface(binder);
            if (callbackService != null) {
                try {
                    callbackService.getProxyPort(new C01671());
                } catch (RemoteException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    class PacRefreshIntentReceiver extends BroadcastReceiver {
        PacRefreshIntentReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            IoThread.getHandler().post(PacManager.this.mPacDownloader);
        }
    }

    public PacManager(Context context, Handler handler, int proxyMessage) {
        this.mPacUrl = Uri.EMPTY;
        this.mProxyLock = new Object();
        this.mPacDownloader = new C01651();
        this.mContext = context;
        this.mLastPort = -1;
        this.mPacRefreshIntent = PendingIntent.getBroadcast(context, DELAY_1, new Intent(ACTION_PAC_REFRESH), DELAY_1);
        context.registerReceiver(new PacRefreshIntentReceiver(), new IntentFilter(ACTION_PAC_REFRESH));
        this.mConnectivityHandler = handler;
        this.mProxyMessage = proxyMessage;
    }

    private AlarmManager getAlarmManager() {
        if (this.mAlarmManager == null) {
            this.mAlarmManager = (AlarmManager) this.mContext.getSystemService("alarm");
        }
        return this.mAlarmManager;
    }

    public synchronized boolean setCurrentProxyScriptUrl(ProxyInfo proxy) {
        boolean z = false;
        synchronized (this) {
            if (Uri.EMPTY.equals(proxy.getPacFileUrl())) {
                getAlarmManager().cancel(this.mPacRefreshIntent);
                synchronized (this.mProxyLock) {
                    this.mPacUrl = Uri.EMPTY;
                    this.mCurrentPac = null;
                    if (this.mProxyService != null) {
                        try {
                            this.mProxyService.stopPacSystem();
                        } catch (RemoteException e) {
                            Log.w(TAG, "Failed to stop PAC service", e);
                        } finally {
                            unbind();
                        }
                    }
                }
            } else if (!proxy.getPacFileUrl().equals(this.mPacUrl) || proxy.getPort() <= 0) {
                synchronized (this.mProxyLock) {
                    this.mPacUrl = proxy.getPacFileUrl();
                }
                this.mCurrentDelay = DELAY_1;
                this.mHasSentBroadcast = false;
                this.mHasDownloaded = false;
                getAlarmManager().cancel(this.mPacRefreshIntent);
                bind();
                z = true;
            }
        }
        return z;
    }

    private static String get(Uri pacUri) throws IOException {
        return new String(Streams.readFully(new URL(pacUri.toString()).openConnection(Proxy.NO_PROXY).getInputStream()));
    }

    private int getNextDelay(int currentDelay) {
        currentDelay++;
        if (currentDelay > DELAY_4) {
            return DELAY_4;
        }
        return currentDelay;
    }

    private void longSchedule() {
        this.mCurrentDelay = DELAY_1;
        setDownloadIn(DELAY_LONG);
    }

    private void reschedule() {
        this.mCurrentDelay = getNextDelay(this.mCurrentDelay);
        setDownloadIn(this.mCurrentDelay);
    }

    private String getPacChangeDelay() {
        ContentResolver cr = this.mContext.getContentResolver();
        String defaultDelay = SystemProperties.get("conn.pac_change_delay", DEFAULT_DELAYS);
        String val = Global.getString(cr, "pac_change_delay");
        return val == null ? defaultDelay : val;
    }

    private long getDownloadDelay(int delayIndex) {
        String[] list = getPacChangeDelay().split(" ");
        if (delayIndex < list.length) {
            return Long.parseLong(list[delayIndex]);
        }
        return 0;
    }

    private void setDownloadIn(int delayIndex) {
        getAlarmManager().set(DELAY_4, (1000 * getDownloadDelay(delayIndex)) + SystemClock.elapsedRealtime(), this.mPacRefreshIntent);
    }

    private boolean setCurrentProxyScript(String script) {
        if (this.mProxyService == null) {
            Log.e(TAG, "setCurrentProxyScript: no proxy service");
            return false;
        }
        try {
            this.mProxyService.setPacFile(script);
            this.mCurrentPac = script;
        } catch (RemoteException e) {
            Log.e(TAG, "Unable to set PAC file", e);
        }
        return true;
    }

    private void bind() {
        if (this.mContext == null) {
            Log.e(TAG, "No context for binding");
            return;
        }
        Intent intent = new Intent();
        intent.setClassName(PAC_PACKAGE, PAC_SERVICE);
        if (this.mProxyConnection == null || this.mConnection == null) {
            this.mConnection = new C01662();
            this.mContext.bindService(intent, this.mConnection, 1073741829);
            intent = new Intent();
            intent.setClassName(PROXY_PACKAGE, PROXY_SERVICE);
            this.mProxyConnection = new C01683();
            this.mContext.bindService(intent, this.mProxyConnection, 1073741829);
            return;
        }
        IoThread.getHandler().post(this.mPacDownloader);
    }

    private void unbind() {
        if (this.mConnection != null) {
            this.mContext.unbindService(this.mConnection);
            this.mConnection = null;
        }
        if (this.mProxyConnection != null) {
            this.mContext.unbindService(this.mProxyConnection);
            this.mProxyConnection = null;
        }
        this.mProxyService = null;
        this.mLastPort = -1;
    }

    private void sendPacBroadcast(ProxyInfo proxy) {
        this.mConnectivityHandler.sendMessage(this.mConnectivityHandler.obtainMessage(this.mProxyMessage, proxy));
    }

    private synchronized void sendProxyIfNeeded() {
        if (this.mHasDownloaded && this.mLastPort != -1) {
            if (!this.mHasSentBroadcast) {
                sendPacBroadcast(new ProxyInfo(this.mPacUrl, this.mLastPort));
                this.mHasSentBroadcast = true;
            }
        }
    }
}
