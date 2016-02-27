package android.net.wifi;

import android.app.AppOpsManager;
import android.content.Context;
import android.net.DhcpInfo;
import android.net.ProxyInfo;
import android.os.Binder;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;
import android.os.WorkSource;
import android.util.Log;
import android.util.SparseArray;
import com.android.internal.util.AsyncChannel;
import java.net.InetAddress;
import java.util.List;
import java.util.concurrent.CountDownLatch;

public class WifiManager {
    public static final String ACTION_PICK_WIFI_NETWORK = "android.net.wifi.PICK_WIFI_NETWORK";
    public static final String ACTION_REQUEST_SCAN_ALWAYS_AVAILABLE = "android.net.wifi.action.REQUEST_SCAN_ALWAYS_AVAILABLE";
    private static final int BASE = 151552;
    public static final String BATCHED_SCAN_RESULTS_AVAILABLE_ACTION = "android.net.wifi.BATCHED_RESULTS";
    public static final int BUSY = 2;
    public static final int CANCEL_WPS = 151566;
    public static final int CANCEL_WPS_FAILED = 151567;
    public static final int CANCEL_WPS_SUCCEDED = 151568;
    public static final int CHANGE_REASON_ADDED = 0;
    public static final int CHANGE_REASON_CONFIG_CHANGE = 2;
    public static final int CHANGE_REASON_REMOVED = 1;
    public static final String CONFIGURED_NETWORKS_CHANGED_ACTION = "android.net.wifi.CONFIGURED_NETWORKS_CHANGE";
    public static final int CONNECT_NETWORK = 151553;
    public static final int CONNECT_NETWORK_FAILED = 151554;
    public static final int CONNECT_NETWORK_SUCCEEDED = 151555;
    public static final int DATA_ACTIVITY_IN = 1;
    public static final int DATA_ACTIVITY_INOUT = 3;
    public static final int DATA_ACTIVITY_NONE = 0;
    public static final int DATA_ACTIVITY_NOTIFICATION = 1;
    public static final int DATA_ACTIVITY_OUT = 2;
    public static final boolean DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED = false;
    public static final int DISABLE_NETWORK = 151569;
    public static final int DISABLE_NETWORK_FAILED = 151570;
    public static final int DISABLE_NETWORK_SUCCEEDED = 151571;
    public static final int ERROR = 0;
    public static final int ERROR_AUTHENTICATING = 1;
    public static final String EXTRA_BSSID = "bssid";
    public static final String EXTRA_CHANGE_REASON = "changeReason";
    public static final String EXTRA_LINK_PROPERTIES = "linkProperties";
    public static final String EXTRA_MULTIPLE_NETWORKS_CHANGED = "multipleChanges";
    public static final String EXTRA_NETWORK_CAPABILITIES = "networkCapabilities";
    public static final String EXTRA_NETWORK_INFO = "networkInfo";
    public static final String EXTRA_NEW_RSSI = "newRssi";
    public static final String EXTRA_NEW_STATE = "newState";
    public static final String EXTRA_PREVIOUS_WIFI_AP_STATE = "previous_wifi_state";
    public static final String EXTRA_PREVIOUS_WIFI_STATE = "previous_wifi_state";
    public static final String EXTRA_SCAN_AVAILABLE = "scan_enabled";
    public static final String EXTRA_SUPPLICANT_CONNECTED = "connected";
    public static final String EXTRA_SUPPLICANT_ERROR = "supplicantError";
    public static final String EXTRA_WIFI_AP_STATE = "wifi_state";
    public static final String EXTRA_WIFI_CONFIGURATION = "wifiConfiguration";
    public static final String EXTRA_WIFI_INFO = "wifiInfo";
    public static final String EXTRA_WIFI_STATE = "wifi_state";
    public static final int FORGET_NETWORK = 151556;
    public static final int FORGET_NETWORK_FAILED = 151557;
    public static final int FORGET_NETWORK_SUCCEEDED = 151558;
    public static final int INVALID_ARGS = 8;
    private static final int INVALID_KEY = 0;
    public static final int IN_PROGRESS = 1;
    public static final String LINK_CONFIGURATION_CHANGED_ACTION = "android.net.wifi.LINK_CONFIGURATION_CHANGED";
    private static final int MAX_ACTIVE_LOCKS = 50;
    private static final int MAX_RSSI = -55;
    private static final int MIN_RSSI = -100;
    public static final String NETWORK_IDS_CHANGED_ACTION = "android.net.wifi.NETWORK_IDS_CHANGED";
    public static final String NETWORK_STATE_CHANGED_ACTION = "android.net.wifi.STATE_CHANGE";
    public static final int NOT_AUTHORIZED = 9;
    public static final String RSSI_CHANGED_ACTION = "android.net.wifi.RSSI_CHANGED";
    public static final int RSSI_LEVELS = 5;
    public static final int RSSI_PKTCNT_FETCH = 151572;
    public static final int RSSI_PKTCNT_FETCH_FAILED = 151574;
    public static final int RSSI_PKTCNT_FETCH_SUCCEEDED = 151573;
    public static final int SAVE_NETWORK = 151559;
    public static final int SAVE_NETWORK_FAILED = 151560;
    public static final int SAVE_NETWORK_SUCCEEDED = 151561;
    public static final String SCAN_RESULTS_AVAILABLE_ACTION = "android.net.wifi.SCAN_RESULTS";
    public static final int START_WPS = 151562;
    public static final int START_WPS_SUCCEEDED = 151563;
    public static final String SUPPLICANT_CONNECTION_CHANGE_ACTION = "android.net.wifi.supplicant.CONNECTION_CHANGE";
    public static final String SUPPLICANT_STATE_CHANGED_ACTION = "android.net.wifi.supplicant.STATE_CHANGE";
    private static final String TAG = "WifiManager";
    public static final String WIFI_AP_STATE_CHANGED_ACTION = "android.net.wifi.WIFI_AP_STATE_CHANGED";
    public static final int WIFI_AP_STATE_DISABLED = 11;
    public static final int WIFI_AP_STATE_DISABLING = 10;
    public static final int WIFI_AP_STATE_ENABLED = 13;
    public static final int WIFI_AP_STATE_ENABLING = 12;
    public static final int WIFI_AP_STATE_FAILED = 14;
    public static final int WIFI_FEATURE_ADDITIONAL_STA = 2048;
    public static final int WIFI_FEATURE_BATCH_SCAN = 512;
    public static final int WIFI_FEATURE_D2AP_RTT = 256;
    public static final int WIFI_FEATURE_D2D_RTT = 128;
    public static final int WIFI_FEATURE_EPR = 16384;
    public static final int WIFI_FEATURE_INFRA = 1;
    public static final int WIFI_FEATURE_INFRA_5G = 2;
    public static final int WIFI_FEATURE_MOBILE_HOTSPOT = 16;
    public static final int WIFI_FEATURE_NAN = 64;
    public static final int WIFI_FEATURE_P2P = 8;
    public static final int WIFI_FEATURE_PASSPOINT = 4;
    public static final int WIFI_FEATURE_PNO = 1024;
    public static final int WIFI_FEATURE_SCANNER = 32;
    public static final int WIFI_FEATURE_TDLS = 4096;
    public static final int WIFI_FEATURE_TDLS_OFFCHANNEL = 8192;
    public static final int WIFI_FREQUENCY_BAND_2GHZ = 2;
    public static final int WIFI_FREQUENCY_BAND_5GHZ = 1;
    public static final int WIFI_FREQUENCY_BAND_AUTO = 0;
    public static final int WIFI_MODE_FULL = 1;
    public static final int WIFI_MODE_FULL_HIGH_PERF = 3;
    public static final int WIFI_MODE_SCAN_ONLY = 2;
    public static final String WIFI_SCAN_AVAILABLE = "wifi_scan_available";
    public static final String WIFI_STATE_CHANGED_ACTION = "android.net.wifi.WIFI_STATE_CHANGED";
    public static final int WIFI_STATE_DISABLED = 1;
    public static final int WIFI_STATE_DISABLING = 0;
    public static final int WIFI_STATE_ENABLED = 3;
    public static final int WIFI_STATE_ENABLING = 2;
    public static final int WIFI_STATE_UNKNOWN = 4;
    public static final int WPS_AUTH_FAILURE = 6;
    public static final int WPS_COMPLETED = 151565;
    public static final int WPS_FAILED = 151564;
    public static final int WPS_OVERLAP_ERROR = 3;
    public static final int WPS_TIMED_OUT = 7;
    public static final int WPS_TKIP_ONLY_PROHIBITED = 5;
    public static final int WPS_WEP_PROHIBITED = 4;
    private static AsyncChannel sAsyncChannel;
    private static CountDownLatch sConnected;
    private static HandlerThread sHandlerThread;
    private static int sListenerKey;
    private static final SparseArray sListenerMap;
    private static final Object sListenerMapLock;
    private static int sThreadRefCount;
    private static final Object sThreadRefLock;
    private int mActiveLockCount;
    private final AppOpsManager mAppOps;
    private Context mContext;
    IWifiManager mService;

    public interface ActionListener {
        void onFailure(int i);

        void onSuccess();
    }

    public class MulticastLock {
        private final IBinder mBinder;
        private boolean mHeld;
        private int mRefCount;
        private boolean mRefCounted;
        private String mTag;

        private MulticastLock(String tag) {
            this.mTag = tag;
            this.mBinder = new Binder();
            this.mRefCount = WifiManager.WIFI_STATE_DISABLING;
            this.mRefCounted = true;
            this.mHeld = WifiManager.DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void acquire() {
            /*
            r4 = this;
            r2 = 1;
            r1 = r4.mBinder;
            monitor-enter(r1);
            r0 = r4.mRefCounted;	 Catch:{ all -> 0x004c }
            if (r0 == 0) goto L_0x0040;
        L_0x0008:
            r0 = r4.mRefCount;	 Catch:{ all -> 0x004c }
            r0 = r0 + 1;
            r4.mRefCount = r0;	 Catch:{ all -> 0x004c }
            if (r0 != r2) goto L_0x003e;
        L_0x0010:
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ RemoteException -> 0x003a }
            r0 = r0.mService;	 Catch:{ RemoteException -> 0x003a }
            r2 = r4.mBinder;	 Catch:{ RemoteException -> 0x003a }
            r3 = r4.mTag;	 Catch:{ RemoteException -> 0x003a }
            r0.acquireMulticastLock(r2, r3);	 Catch:{ RemoteException -> 0x003a }
            r2 = android.net.wifi.WifiManager.this;	 Catch:{ RemoteException -> 0x003a }
            monitor-enter(r2);	 Catch:{ RemoteException -> 0x003a }
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ all -> 0x0037 }
            r0 = r0.mActiveLockCount;	 Catch:{ all -> 0x0037 }
            r3 = 50;
            if (r0 < r3) goto L_0x0045;
        L_0x0028:
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ all -> 0x0037 }
            r0 = r0.mService;	 Catch:{ all -> 0x0037 }
            r0.releaseMulticastLock();	 Catch:{ all -> 0x0037 }
            r0 = new java.lang.UnsupportedOperationException;	 Catch:{ all -> 0x0037 }
            r3 = "Exceeded maximum number of wifi locks";
            r0.<init>(r3);	 Catch:{ all -> 0x0037 }
            throw r0;	 Catch:{ all -> 0x0037 }
        L_0x0037:
            r0 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x0037 }
            throw r0;	 Catch:{ RemoteException -> 0x003a }
        L_0x003a:
            r0 = move-exception;
        L_0x003b:
            r0 = 1;
            r4.mHeld = r0;	 Catch:{ all -> 0x004c }
        L_0x003e:
            monitor-exit(r1);	 Catch:{ all -> 0x004c }
            return;
        L_0x0040:
            r0 = r4.mHeld;	 Catch:{ all -> 0x004c }
            if (r0 != 0) goto L_0x003e;
        L_0x0044:
            goto L_0x0010;
        L_0x0045:
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ all -> 0x0037 }
            r0.mActiveLockCount = r0.mActiveLockCount + android.net.wifi.WifiManager.WIFI_STATE_DISABLED;	 Catch:{ all -> 0x0037 }
            monitor-exit(r2);	 Catch:{ all -> 0x0037 }
            goto L_0x003b;
        L_0x004c:
            r0 = move-exception;
            monitor-exit(r1);	 Catch:{ all -> 0x004c }
            throw r0;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.net.wifi.WifiManager.MulticastLock.acquire():void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void release() {
            /*
            r4 = this;
            r1 = r4.mBinder;
            monitor-enter(r1);
            r0 = r4.mRefCounted;	 Catch:{ all -> 0x0041 }
            if (r0 == 0) goto L_0x0044;
        L_0x0007:
            r0 = r4.mRefCount;	 Catch:{ all -> 0x0041 }
            r0 = r0 + -1;
            r4.mRefCount = r0;	 Catch:{ all -> 0x0041 }
            if (r0 != 0) goto L_0x0022;
        L_0x000f:
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ RemoteException -> 0x004c }
            r0 = r0.mService;	 Catch:{ RemoteException -> 0x004c }
            r0.releaseMulticastLock();	 Catch:{ RemoteException -> 0x004c }
            r2 = android.net.wifi.WifiManager.this;	 Catch:{ RemoteException -> 0x004c }
            monitor-enter(r2);	 Catch:{ RemoteException -> 0x004c }
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ all -> 0x0049 }
            r0.mActiveLockCount = r0.mActiveLockCount - 1;	 Catch:{ all -> 0x0049 }
            monitor-exit(r2);	 Catch:{ all -> 0x0049 }
        L_0x001f:
            r0 = 0;
            r4.mHeld = r0;	 Catch:{ all -> 0x0041 }
        L_0x0022:
            r0 = r4.mRefCount;	 Catch:{ all -> 0x0041 }
            if (r0 >= 0) goto L_0x004e;
        L_0x0026:
            r0 = new java.lang.RuntimeException;	 Catch:{ all -> 0x0041 }
            r2 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0041 }
            r2.<init>();	 Catch:{ all -> 0x0041 }
            r3 = "MulticastLock under-locked ";
            r2 = r2.append(r3);	 Catch:{ all -> 0x0041 }
            r3 = r4.mTag;	 Catch:{ all -> 0x0041 }
            r2 = r2.append(r3);	 Catch:{ all -> 0x0041 }
            r2 = r2.toString();	 Catch:{ all -> 0x0041 }
            r0.<init>(r2);	 Catch:{ all -> 0x0041 }
            throw r0;	 Catch:{ all -> 0x0041 }
        L_0x0041:
            r0 = move-exception;
            monitor-exit(r1);	 Catch:{ all -> 0x0041 }
            throw r0;
        L_0x0044:
            r0 = r4.mHeld;	 Catch:{ all -> 0x0041 }
            if (r0 == 0) goto L_0x0022;
        L_0x0048:
            goto L_0x000f;
        L_0x0049:
            r0 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x0049 }
            throw r0;	 Catch:{ RemoteException -> 0x004c }
        L_0x004c:
            r0 = move-exception;
            goto L_0x001f;
        L_0x004e:
            monitor-exit(r1);	 Catch:{ all -> 0x0041 }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.net.wifi.WifiManager.MulticastLock.release():void");
        }

        public void setReferenceCounted(boolean refCounted) {
            this.mRefCounted = refCounted;
        }

        public boolean isHeld() {
            boolean z;
            synchronized (this.mBinder) {
                z = this.mHeld;
            }
            return z;
        }

        public String toString() {
            String str;
            synchronized (this.mBinder) {
                String s3;
                String s1 = Integer.toHexString(System.identityHashCode(this));
                String s2 = this.mHeld ? "held; " : ProxyInfo.LOCAL_EXCL_LIST;
                if (this.mRefCounted) {
                    s3 = "refcounted: refcount = " + this.mRefCount;
                } else {
                    s3 = "not refcounted";
                }
                str = "MulticastLock{ " + s1 + "; " + s2 + s3 + " }";
            }
            return str;
        }

        protected void finalize() throws Throwable {
            super.finalize();
            setReferenceCounted(WifiManager.DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED);
            release();
        }
    }

    private static class ServiceHandler extends Handler {
        ServiceHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message message) {
            Object listener = WifiManager.removeListener(message.arg2);
            switch (message.what) {
                case 69632:
                    if (message.arg1 == 0) {
                        WifiManager.sAsyncChannel.sendMessage(69633);
                    } else {
                        Log.e(WifiManager.TAG, "Failed to set up channel connection");
                        WifiManager.sAsyncChannel = null;
                    }
                    WifiManager.sConnected.countDown();
                case 69636:
                    Log.e(WifiManager.TAG, "Channel connection lost");
                    WifiManager.sAsyncChannel = null;
                    getLooper().quit();
                case WifiManager.CONNECT_NETWORK_FAILED /*151554*/:
                case WifiManager.FORGET_NETWORK_FAILED /*151557*/:
                case WifiManager.SAVE_NETWORK_FAILED /*151560*/:
                case WifiManager.DISABLE_NETWORK_FAILED /*151570*/:
                    if (listener != null) {
                        ((ActionListener) listener).onFailure(message.arg1);
                    }
                case WifiManager.CONNECT_NETWORK_SUCCEEDED /*151555*/:
                case WifiManager.FORGET_NETWORK_SUCCEEDED /*151558*/:
                case WifiManager.SAVE_NETWORK_SUCCEEDED /*151561*/:
                case WifiManager.DISABLE_NETWORK_SUCCEEDED /*151571*/:
                    if (listener != null) {
                        ((ActionListener) listener).onSuccess();
                    }
                case WifiManager.START_WPS_SUCCEEDED /*151563*/:
                    if (listener != null) {
                        ((WpsCallback) listener).onStarted(message.obj.pin);
                        synchronized (WifiManager.sListenerMapLock) {
                            WifiManager.sListenerMap.put(message.arg2, listener);
                            break;
                        }
                    }
                case WifiManager.WPS_FAILED /*151564*/:
                    if (listener != null) {
                        ((WpsCallback) listener).onFailed(message.arg1);
                    }
                case WifiManager.WPS_COMPLETED /*151565*/:
                    if (listener != null) {
                        ((WpsCallback) listener).onSucceeded();
                    }
                case WifiManager.CANCEL_WPS_FAILED /*151567*/:
                    if (listener != null) {
                        ((WpsCallback) listener).onFailed(message.arg1);
                    }
                case WifiManager.CANCEL_WPS_SUCCEDED /*151568*/:
                    if (listener != null) {
                        ((WpsCallback) listener).onSucceeded();
                    }
                case WifiManager.RSSI_PKTCNT_FETCH_SUCCEEDED /*151573*/:
                    if (listener != null) {
                        RssiPacketCountInfo info = message.obj;
                        if (info != null) {
                            ((TxPacketCountListener) listener).onSuccess(info.txgood + info.txbad);
                        } else {
                            ((TxPacketCountListener) listener).onFailure(WifiManager.WIFI_STATE_DISABLING);
                        }
                    }
                case WifiManager.RSSI_PKTCNT_FETCH_FAILED /*151574*/:
                    if (listener != null) {
                        ((TxPacketCountListener) listener).onFailure(message.arg1);
                    }
                default:
            }
        }
    }

    public interface TxPacketCountListener {
        void onFailure(int i);

        void onSuccess(int i);
    }

    public class WifiLock {
        private final IBinder mBinder;
        private boolean mHeld;
        int mLockType;
        private int mRefCount;
        private boolean mRefCounted;
        private String mTag;
        private WorkSource mWorkSource;

        private WifiLock(int lockType, String tag) {
            this.mTag = tag;
            this.mLockType = lockType;
            this.mBinder = new Binder();
            this.mRefCount = WifiManager.WIFI_STATE_DISABLING;
            this.mRefCounted = true;
            this.mHeld = WifiManager.DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void acquire() {
            /*
            r6 = this;
            r2 = 1;
            r1 = r6.mBinder;
            monitor-enter(r1);
            r0 = r6.mRefCounted;	 Catch:{ all -> 0x0052 }
            if (r0 == 0) goto L_0x0046;
        L_0x0008:
            r0 = r6.mRefCount;	 Catch:{ all -> 0x0052 }
            r0 = r0 + 1;
            r6.mRefCount = r0;	 Catch:{ all -> 0x0052 }
            if (r0 != r2) goto L_0x0044;
        L_0x0010:
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ RemoteException -> 0x0040 }
            r0 = r0.mService;	 Catch:{ RemoteException -> 0x0040 }
            r2 = r6.mBinder;	 Catch:{ RemoteException -> 0x0040 }
            r3 = r6.mLockType;	 Catch:{ RemoteException -> 0x0040 }
            r4 = r6.mTag;	 Catch:{ RemoteException -> 0x0040 }
            r5 = r6.mWorkSource;	 Catch:{ RemoteException -> 0x0040 }
            r0.acquireWifiLock(r2, r3, r4, r5);	 Catch:{ RemoteException -> 0x0040 }
            r2 = android.net.wifi.WifiManager.this;	 Catch:{ RemoteException -> 0x0040 }
            monitor-enter(r2);	 Catch:{ RemoteException -> 0x0040 }
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ all -> 0x003d }
            r0 = r0.mActiveLockCount;	 Catch:{ all -> 0x003d }
            r3 = 50;
            if (r0 < r3) goto L_0x004b;
        L_0x002c:
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ all -> 0x003d }
            r0 = r0.mService;	 Catch:{ all -> 0x003d }
            r3 = r6.mBinder;	 Catch:{ all -> 0x003d }
            r0.releaseWifiLock(r3);	 Catch:{ all -> 0x003d }
            r0 = new java.lang.UnsupportedOperationException;	 Catch:{ all -> 0x003d }
            r3 = "Exceeded maximum number of wifi locks";
            r0.<init>(r3);	 Catch:{ all -> 0x003d }
            throw r0;	 Catch:{ all -> 0x003d }
        L_0x003d:
            r0 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x003d }
            throw r0;	 Catch:{ RemoteException -> 0x0040 }
        L_0x0040:
            r0 = move-exception;
        L_0x0041:
            r0 = 1;
            r6.mHeld = r0;	 Catch:{ all -> 0x0052 }
        L_0x0044:
            monitor-exit(r1);	 Catch:{ all -> 0x0052 }
            return;
        L_0x0046:
            r0 = r6.mHeld;	 Catch:{ all -> 0x0052 }
            if (r0 != 0) goto L_0x0044;
        L_0x004a:
            goto L_0x0010;
        L_0x004b:
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ all -> 0x003d }
            r0.mActiveLockCount = r0.mActiveLockCount + android.net.wifi.WifiManager.WIFI_STATE_DISABLED;	 Catch:{ all -> 0x003d }
            monitor-exit(r2);	 Catch:{ all -> 0x003d }
            goto L_0x0041;
        L_0x0052:
            r0 = move-exception;
            monitor-exit(r1);	 Catch:{ all -> 0x0052 }
            throw r0;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.net.wifi.WifiManager.WifiLock.acquire():void");
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void release() {
            /*
            r4 = this;
            r1 = r4.mBinder;
            monitor-enter(r1);
            r0 = r4.mRefCounted;	 Catch:{ all -> 0x0043 }
            if (r0 == 0) goto L_0x0046;
        L_0x0007:
            r0 = r4.mRefCount;	 Catch:{ all -> 0x0043 }
            r0 = r0 + -1;
            r4.mRefCount = r0;	 Catch:{ all -> 0x0043 }
            if (r0 != 0) goto L_0x0024;
        L_0x000f:
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ RemoteException -> 0x004e }
            r0 = r0.mService;	 Catch:{ RemoteException -> 0x004e }
            r2 = r4.mBinder;	 Catch:{ RemoteException -> 0x004e }
            r0.releaseWifiLock(r2);	 Catch:{ RemoteException -> 0x004e }
            r2 = android.net.wifi.WifiManager.this;	 Catch:{ RemoteException -> 0x004e }
            monitor-enter(r2);	 Catch:{ RemoteException -> 0x004e }
            r0 = android.net.wifi.WifiManager.this;	 Catch:{ all -> 0x004b }
            r0.mActiveLockCount = r0.mActiveLockCount - 1;	 Catch:{ all -> 0x004b }
            monitor-exit(r2);	 Catch:{ all -> 0x004b }
        L_0x0021:
            r0 = 0;
            r4.mHeld = r0;	 Catch:{ all -> 0x0043 }
        L_0x0024:
            r0 = r4.mRefCount;	 Catch:{ all -> 0x0043 }
            if (r0 >= 0) goto L_0x0050;
        L_0x0028:
            r0 = new java.lang.RuntimeException;	 Catch:{ all -> 0x0043 }
            r2 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0043 }
            r2.<init>();	 Catch:{ all -> 0x0043 }
            r3 = "WifiLock under-locked ";
            r2 = r2.append(r3);	 Catch:{ all -> 0x0043 }
            r3 = r4.mTag;	 Catch:{ all -> 0x0043 }
            r2 = r2.append(r3);	 Catch:{ all -> 0x0043 }
            r2 = r2.toString();	 Catch:{ all -> 0x0043 }
            r0.<init>(r2);	 Catch:{ all -> 0x0043 }
            throw r0;	 Catch:{ all -> 0x0043 }
        L_0x0043:
            r0 = move-exception;
            monitor-exit(r1);	 Catch:{ all -> 0x0043 }
            throw r0;
        L_0x0046:
            r0 = r4.mHeld;	 Catch:{ all -> 0x0043 }
            if (r0 == 0) goto L_0x0024;
        L_0x004a:
            goto L_0x000f;
        L_0x004b:
            r0 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x004b }
            throw r0;	 Catch:{ RemoteException -> 0x004e }
        L_0x004e:
            r0 = move-exception;
            goto L_0x0021;
        L_0x0050:
            monitor-exit(r1);	 Catch:{ all -> 0x0043 }
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.net.wifi.WifiManager.WifiLock.release():void");
        }

        public void setReferenceCounted(boolean refCounted) {
            this.mRefCounted = refCounted;
        }

        public boolean isHeld() {
            boolean z;
            synchronized (this.mBinder) {
                z = this.mHeld;
            }
            return z;
        }

        public void setWorkSource(WorkSource ws) {
            synchronized (this.mBinder) {
                if (ws != null) {
                    if (ws.size() == 0) {
                        ws = null;
                    }
                }
                boolean changed = true;
                if (ws == null) {
                    this.mWorkSource = null;
                } else {
                    ws.clearNames();
                    if (this.mWorkSource == null) {
                        changed = this.mWorkSource != null ? true : WifiManager.DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
                        this.mWorkSource = new WorkSource(ws);
                    } else {
                        changed = this.mWorkSource.diff(ws);
                        if (changed) {
                            this.mWorkSource.set(ws);
                        }
                    }
                }
                if (changed && this.mHeld) {
                    try {
                        WifiManager.this.mService.updateWifiLockWorkSource(this.mBinder, this.mWorkSource);
                    } catch (RemoteException e) {
                    }
                }
            }
        }

        public String toString() {
            String str;
            synchronized (this.mBinder) {
                String s3;
                String s1 = Integer.toHexString(System.identityHashCode(this));
                String s2 = this.mHeld ? "held; " : ProxyInfo.LOCAL_EXCL_LIST;
                if (this.mRefCounted) {
                    s3 = "refcounted: refcount = " + this.mRefCount;
                } else {
                    s3 = "not refcounted";
                }
                str = "WifiLock{ " + s1 + "; " + s2 + s3 + " }";
            }
            return str;
        }

        protected void finalize() throws Throwable {
            super.finalize();
            synchronized (this.mBinder) {
                if (this.mHeld) {
                    try {
                        WifiManager.this.mService.releaseWifiLock(this.mBinder);
                        synchronized (WifiManager.this) {
                            r0.mActiveLockCount = WifiManager.this.mActiveLockCount - 1;
                        }
                    } catch (RemoteException e) {
                    }
                }
            }
        }
    }

    public static abstract class WpsCallback {
        public abstract void onFailed(int i);

        public abstract void onStarted(String str);

        public abstract void onSucceeded();
    }

    static {
        sListenerKey = WIFI_STATE_DISABLED;
        sListenerMap = new SparseArray();
        sListenerMapLock = new Object();
        sThreadRefLock = new Object();
    }

    public WifiManager(Context context, IWifiManager service) {
        this.mContext = context;
        this.mService = service;
        init();
        this.mAppOps = (AppOpsManager) context.getSystemService(Context.APP_OPS_SERVICE);
    }

    public List<WifiConfiguration> getConfiguredNetworks() {
        try {
            return this.mService.getConfiguredNetworks();
        } catch (RemoteException e) {
            return null;
        }
    }

    public List<WifiConfiguration> getPrivilegedConfiguredNetworks() {
        try {
            return this.mService.getPrivilegedConfiguredNetworks();
        } catch (RemoteException e) {
            return null;
        }
    }

    public WifiConnectionStatistics getConnectionStatistics() {
        try {
            return this.mService.getConnectionStatistics();
        } catch (RemoteException e) {
            return null;
        }
    }

    public int addNetwork(WifiConfiguration config) {
        if (config == null) {
            return -1;
        }
        config.networkId = -1;
        return addOrUpdateNetwork(config);
    }

    public int updateNetwork(WifiConfiguration config) {
        if (config == null || config.networkId < 0) {
            return -1;
        }
        return addOrUpdateNetwork(config);
    }

    private int addOrUpdateNetwork(WifiConfiguration config) {
        try {
            return this.mService.addOrUpdateNetwork(config);
        } catch (RemoteException e) {
            return -1;
        }
    }

    public boolean removeNetwork(int netId) {
        try {
            return this.mService.removeNetwork(netId);
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean enableNetwork(int netId, boolean disableOthers) {
        try {
            return this.mService.enableNetwork(netId, disableOthers);
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean disableNetwork(int netId) {
        try {
            return this.mService.disableNetwork(netId);
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean disconnect() {
        try {
            this.mService.disconnect();
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean reconnect() {
        try {
            this.mService.reconnect();
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean reassociate() {
        try {
            this.mService.reassociate();
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean pingSupplicant() {
        boolean z = DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        if (this.mService != null) {
            try {
                z = this.mService.pingSupplicant();
            } catch (RemoteException e) {
            }
        }
        return z;
    }

    public List<WifiChannel> getChannelList() {
        try {
            return this.mService.getChannelList();
        } catch (RemoteException e) {
            return null;
        }
    }

    private int getSupportedFeatures() {
        try {
            return this.mService.getSupportedFeatures();
        } catch (RemoteException e) {
            return WIFI_STATE_DISABLING;
        }
    }

    private boolean isFeatureSupported(int feature) {
        return (getSupportedFeatures() & feature) == feature ? true : DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
    }

    public boolean is5GHzBandSupported() {
        return isFeatureSupported(WIFI_STATE_ENABLING);
    }

    public boolean isPasspointSupported() {
        return isFeatureSupported(WPS_WEP_PROHIBITED);
    }

    public boolean isP2pSupported() {
        return isFeatureSupported(WIFI_FEATURE_P2P);
    }

    public boolean isPortableHotspotSupported() {
        return isFeatureSupported(WIFI_FEATURE_MOBILE_HOTSPOT);
    }

    public boolean isWifiScannerSupported() {
        return isFeatureSupported(WIFI_FEATURE_SCANNER);
    }

    public boolean isNanSupported() {
        return isFeatureSupported(WIFI_FEATURE_NAN);
    }

    public boolean isDeviceToDeviceRttSupported() {
        return isFeatureSupported(WIFI_FEATURE_D2D_RTT);
    }

    public boolean isDeviceToApRttSupported() {
        return isFeatureSupported(WIFI_FEATURE_D2AP_RTT);
    }

    public boolean isPreferredNetworkOffloadSupported() {
        return isFeatureSupported(WIFI_FEATURE_PNO);
    }

    public boolean isAdditionalStaSupported() {
        return isFeatureSupported(WIFI_FEATURE_ADDITIONAL_STA);
    }

    public boolean isTdlsSupported() {
        return isFeatureSupported(WIFI_FEATURE_TDLS);
    }

    public boolean isOffChannelTdlsSupported() {
        return isFeatureSupported(WIFI_FEATURE_TDLS_OFFCHANNEL);
    }

    public boolean isEnhancedPowerReportingSupported() {
        return isFeatureSupported(WIFI_FEATURE_EPR);
    }

    public WifiActivityEnergyInfo getControllerActivityEnergyInfo(int updateType) {
        if (this.mService == null) {
            return null;
        }
        try {
            if (!isEnhancedPowerReportingSupported()) {
                return null;
            }
            synchronized (this) {
                WifiActivityEnergyInfo record = this.mService.reportActivityInfo();
                if (record.isValid()) {
                    return record;
                }
                return null;
            }
        } catch (RemoteException e) {
            Log.e(TAG, "getControllerActivityEnergyInfo: " + e);
            return null;
        }
    }

    public boolean startScan() {
        try {
            this.mService.startScan(null, null);
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean startScan(WorkSource workSource) {
        try {
            this.mService.startScan(null, workSource);
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean startLocationRestrictedScan(WorkSource workSource) {
        try {
            this.mService.startLocationRestrictedScan(workSource);
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean startCustomizedScan(ScanSettings requested) {
        try {
            this.mService.startScan(requested, null);
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean startCustomizedScan(ScanSettings requested, WorkSource workSource) {
        try {
            this.mService.startScan(requested, workSource);
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean requestBatchedScan(BatchedScanSettings requested) {
        try {
            return this.mService.requestBatchedScan(requested, new Binder(), null);
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean requestBatchedScan(BatchedScanSettings requested, WorkSource workSource) {
        try {
            return this.mService.requestBatchedScan(requested, new Binder(), workSource);
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean isBatchedScanSupported() {
        try {
            return this.mService.isBatchedScanSupported();
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public void stopBatchedScan(BatchedScanSettings requested) {
        try {
            this.mService.stopBatchedScan(requested);
        } catch (RemoteException e) {
        }
    }

    public List<BatchedScanResult> getBatchedScanResults() {
        try {
            return this.mService.getBatchedScanResults(this.mContext.getOpPackageName());
        } catch (RemoteException e) {
            return null;
        }
    }

    public void pollBatchedScan() {
        try {
            this.mService.pollBatchedScan();
        } catch (RemoteException e) {
        }
    }

    public String getWpsNfcConfigurationToken(int netId) {
        try {
            return this.mService.getWpsNfcConfigurationToken(netId);
        } catch (RemoteException e) {
            return null;
        }
    }

    public WifiInfo getConnectionInfo() {
        try {
            return this.mService.getConnectionInfo();
        } catch (RemoteException e) {
            return null;
        }
    }

    public List<ScanResult> getScanResults() {
        try {
            return this.mService.getScanResults(this.mContext.getOpPackageName());
        } catch (RemoteException e) {
            return null;
        }
    }

    public boolean isScanAlwaysAvailable() {
        try {
            return this.mService.isScanAlwaysAvailable();
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean saveConfiguration() {
        try {
            return this.mService.saveConfiguration();
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public void setCountryCode(String country, boolean persist) {
        try {
            this.mService.setCountryCode(country, persist);
        } catch (RemoteException e) {
        }
    }

    public void setFrequencyBand(int band, boolean persist) {
        try {
            this.mService.setFrequencyBand(band, persist);
        } catch (RemoteException e) {
        }
    }

    public WifiEapSimInfo getSimInfo() {
        try {
            return this.mService.getSimInfo();
        } catch (RemoteException e) {
            return null;
        }
    }

    public int getFrequencyBand() {
        try {
            return this.mService.getFrequencyBand();
        } catch (RemoteException e) {
            return -1;
        }
    }

    public boolean isDualBandSupported() {
        try {
            return this.mService.isDualBandSupported();
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean isIbssSupported() {
        try {
            return this.mService.isIbssSupported();
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public DhcpInfo getDhcpInfo() {
        try {
            return this.mService.getDhcpInfo();
        } catch (RemoteException e) {
            return null;
        }
    }

    public boolean setWifiEnabled(boolean enabled) {
        boolean z = DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        if (this.mAppOps.noteOp(48) == 0) {
            try {
                z = this.mService.setWifiEnabled(enabled);
            } catch (RemoteException e) {
            }
        }
        return z;
    }

    public int getWifiState() {
        try {
            return this.mService.getWifiEnabledState();
        } catch (RemoteException e) {
            return WPS_WEP_PROHIBITED;
        }
    }

    public boolean isWifiEnabled() {
        return getWifiState() == WPS_OVERLAP_ERROR ? true : DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
    }

    public void getTxPacketCount(TxPacketCountListener listener) {
        validateChannel();
        sAsyncChannel.sendMessage(RSSI_PKTCNT_FETCH, WIFI_STATE_DISABLING, putListener(listener));
    }

    public static int calculateSignalLevel(int rssi, int numLevels) {
        if (rssi <= MIN_RSSI) {
            return WIFI_STATE_DISABLING;
        }
        if (rssi >= MAX_RSSI) {
            return numLevels - 1;
        }
        return (int) ((((float) (rssi + 100)) * ((float) (numLevels - 1))) / 45.0f);
    }

    public static int compareSignalLevel(int rssiA, int rssiB) {
        return rssiA - rssiB;
    }

    public boolean setWifiApEnabled(WifiConfiguration wifiConfig, boolean enabled) {
        try {
            this.mService.setWifiApEnabled(wifiConfig, enabled);
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public int getWifiApState() {
        try {
            return this.mService.getWifiApEnabledState();
        } catch (RemoteException e) {
            return WIFI_AP_STATE_FAILED;
        }
    }

    public boolean isWifiApEnabled() {
        return getWifiApState() == WIFI_AP_STATE_ENABLED ? true : DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
    }

    public WifiConfiguration getWifiApConfiguration() {
        try {
            return this.mService.getWifiApConfiguration();
        } catch (RemoteException e) {
            return null;
        }
    }

    public boolean setWifiApConfiguration(WifiConfiguration wifiConfig) {
        try {
            this.mService.setWifiApConfiguration(wifiConfig);
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean startWifi() {
        try {
            this.mService.startWifi();
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean stopWifi() {
        try {
            this.mService.stopWifi();
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean addToBlacklist(String bssid) {
        try {
            this.mService.addToBlacklist(bssid);
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean clearBlacklist() {
        try {
            this.mService.clearBlacklist();
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public void setTdlsEnabled(InetAddress remoteIPAddress, boolean enable) {
        try {
            this.mService.enableTdls(remoteIPAddress.getHostAddress(), enable);
        } catch (RemoteException e) {
        }
    }

    public void setTdlsEnabledWithMacAddress(String remoteMacAddress, boolean enable) {
        try {
            this.mService.enableTdlsWithMacAddress(remoteMacAddress, enable);
        } catch (RemoteException e) {
        }
    }

    private static int putListener(Object listener) {
        if (listener == null) {
            return WIFI_STATE_DISABLING;
        }
        int key;
        synchronized (sListenerMapLock) {
            do {
                key = sListenerKey;
                sListenerKey = key + WIFI_STATE_DISABLED;
            } while (key == 0);
            sListenerMap.put(key, listener);
        }
        return key;
    }

    private static Object removeListener(int key) {
        if (key == 0) {
            return null;
        }
        Object listener;
        synchronized (sListenerMapLock) {
            listener = sListenerMap.get(key);
            sListenerMap.remove(key);
        }
        return listener;
    }

    private void init() {
        synchronized (sThreadRefLock) {
            int i = sThreadRefCount + WIFI_STATE_DISABLED;
            sThreadRefCount = i;
            if (i == WIFI_STATE_DISABLED) {
                Messenger messenger = getWifiServiceMessenger();
                if (messenger == null) {
                    sAsyncChannel = null;
                    return;
                }
                sHandlerThread = new HandlerThread(TAG);
                sAsyncChannel = new AsyncChannel();
                sConnected = new CountDownLatch(WIFI_STATE_DISABLED);
                sHandlerThread.start();
                sAsyncChannel.connect(this.mContext, new ServiceHandler(sHandlerThread.getLooper()), messenger);
                try {
                    sConnected.await();
                } catch (InterruptedException e) {
                    Log.e(TAG, "interrupted wait at init");
                }
            }
        }
    }

    private void validateChannel() {
        if (sAsyncChannel == null) {
            throw new IllegalStateException("No permission to access and change wifi or a bad initialization");
        }
    }

    public void connect(WifiConfiguration config, ActionListener listener) {
        if (config == null) {
            throw new IllegalArgumentException("config cannot be null");
        }
        validateChannel();
        sAsyncChannel.sendMessage(CONNECT_NETWORK, -1, putListener(listener), config);
    }

    public void connect(int networkId, ActionListener listener) {
        if (networkId < 0) {
            throw new IllegalArgumentException("Network id cannot be negative");
        }
        validateChannel();
        sAsyncChannel.sendMessage(CONNECT_NETWORK, networkId, putListener(listener));
    }

    public void save(WifiConfiguration config, ActionListener listener) {
        if (config == null) {
            throw new IllegalArgumentException("config cannot be null");
        }
        validateChannel();
        sAsyncChannel.sendMessage(SAVE_NETWORK, WIFI_STATE_DISABLING, putListener(listener), config);
    }

    public void forget(int netId, ActionListener listener) {
        if (netId < 0) {
            throw new IllegalArgumentException("Network id cannot be negative");
        }
        validateChannel();
        sAsyncChannel.sendMessage(FORGET_NETWORK, netId, putListener(listener));
    }

    public void disable(int netId, ActionListener listener) {
        if (netId < 0) {
            throw new IllegalArgumentException("Network id cannot be negative");
        }
        validateChannel();
        sAsyncChannel.sendMessage(DISABLE_NETWORK, netId, putListener(listener));
    }

    public void disableEphemeralNetwork(String SSID) {
        if (SSID == null) {
            throw new IllegalArgumentException("SSID cannot be null");
        }
        try {
            this.mService.disableEphemeralNetwork(SSID);
        } catch (RemoteException e) {
        }
    }

    public void startWps(WpsInfo config, WpsCallback listener) {
        if (config == null) {
            throw new IllegalArgumentException("config cannot be null");
        }
        validateChannel();
        sAsyncChannel.sendMessage(START_WPS, WIFI_STATE_DISABLING, putListener(listener), config);
    }

    public void cancelWps(WpsCallback listener) {
        validateChannel();
        sAsyncChannel.sendMessage(CANCEL_WPS, WIFI_STATE_DISABLING, putListener(listener));
    }

    public Messenger getWifiServiceMessenger() {
        Messenger messenger = null;
        try {
            messenger = this.mService.getWifiServiceMessenger();
        } catch (RemoteException e) {
        } catch (SecurityException e2) {
        }
        return messenger;
    }

    public String getConfigFile() {
        try {
            return this.mService.getConfigFile();
        } catch (RemoteException e) {
            return null;
        }
    }

    public WifiLock createWifiLock(int lockType, String tag) {
        return new WifiLock(lockType, tag, null);
    }

    public WifiLock createWifiLock(String tag) {
        return new WifiLock(WIFI_STATE_DISABLED, tag, null);
    }

    public MulticastLock createMulticastLock(String tag) {
        return new MulticastLock(tag, null);
    }

    public boolean isMulticastEnabled() {
        try {
            return this.mService.isMulticastEnabled();
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    public boolean initializeMulticastFiltering() {
        try {
            this.mService.initializeMulticastFiltering();
            return true;
        } catch (RemoteException e) {
            return DEFAULT_POOR_NETWORK_AVOIDANCE_ENABLED;
        }
    }

    protected void finalize() throws Throwable {
        try {
            synchronized (sThreadRefLock) {
                int i = sThreadRefCount - 1;
                sThreadRefCount = i;
                if (i == 0 && sAsyncChannel != null) {
                    sAsyncChannel.disconnect();
                }
            }
        } finally {
            super.finalize();
        }
    }

    public void enableVerboseLogging(int verbose) {
        try {
            this.mService.enableVerboseLogging(verbose);
        } catch (Exception e) {
            Log.e(TAG, "enableVerboseLogging " + e.toString());
        }
    }

    public int getVerboseLoggingLevel() {
        try {
            return this.mService.getVerboseLoggingLevel();
        } catch (RemoteException e) {
            return WIFI_STATE_DISABLING;
        }
    }

    public void enableAggressiveHandover(int enabled) {
        try {
            this.mService.enableAggressiveHandover(enabled);
        } catch (RemoteException e) {
        }
    }

    public int getAggressiveHandover() {
        try {
            return this.mService.getAggressiveHandover();
        } catch (RemoteException e) {
            return WIFI_STATE_DISABLING;
        }
    }

    public void setAllowScansWithTraffic(int enabled) {
        try {
            this.mService.setAllowScansWithTraffic(enabled);
        } catch (RemoteException e) {
        }
    }

    public int getAllowScansWithTraffic() {
        try {
            return this.mService.getAllowScansWithTraffic();
        } catch (RemoteException e) {
            return WIFI_STATE_DISABLING;
        }
    }
}
