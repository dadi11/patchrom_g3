package android.net;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.NetworkInfo.DetailedState;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;
import android.util.Log;
import android.view.KeyEvent;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

public class ProxyDataTracker extends BaseNetworkStateTracker {
    private static final String ACTION_PROXY_STATUS_CHANGE = "com.android.net.PROXY_STATUS_CHANGE";
    private static final String DNS1 = "8.8.8.8";
    private static final String DNS2 = "8.8.4.4";
    private static final String INTERFACE_NAME = "ifb0";
    private static final String KEY_IS_PROXY_AVAILABLE = "is_proxy_available";
    private static final String KEY_REPLY_TO_MESSENGER_BINDER = "reply_to_messenger_binder";
    private static final String KEY_REPLY_TO_MESSENGER_BINDER_BUNDLE = "reply_to_messenger_binder_bundle";
    private static final int MSG_SETUP_REQUEST = 2;
    private static final int MSG_TEAR_DOWN_REQUEST = 1;
    private static final String NETWORK_TYPE = "PROXY";
    private static final String PERMISSION_PROXY_STATUS_SENDER = "android.permission.ACCESS_NETWORK_CONDITIONS";
    private static final String REASON_DISABLED = "disabled";
    private static final String REASON_ENABLED = "enabled";
    private static final String REASON_PROXY_DOWN = "proxy_down";
    private static final String TAG = "ProxyDataTracker";
    private final AtomicInteger mDefaultGatewayAddr;
    private AtomicBoolean mIsProxyAvailable;
    private Messenger mProxyStatusService;
    private final BroadcastReceiver mProxyStatusServiceListener;
    private AtomicBoolean mReconnectRequested;
    private Handler mTarget;

    /* renamed from: android.net.ProxyDataTracker.1 */
    class C05011 extends BroadcastReceiver {
        C05011() {
        }

        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals(ProxyDataTracker.ACTION_PROXY_STATUS_CHANGE)) {
                ProxyDataTracker.this.mIsProxyAvailable.set(intent.getBooleanExtra(ProxyDataTracker.KEY_IS_PROXY_AVAILABLE, false));
                if (ProxyDataTracker.this.mIsProxyAvailable.get()) {
                    Bundle bundle = intent.getBundleExtra(ProxyDataTracker.KEY_REPLY_TO_MESSENGER_BINDER_BUNDLE);
                    if (bundle == null || bundle.getBinder(ProxyDataTracker.KEY_REPLY_TO_MESSENGER_BINDER) == null) {
                        Log.e(ProxyDataTracker.TAG, "no messenger binder in the intent to send future requests");
                        ProxyDataTracker.this.mIsProxyAvailable.set(false);
                        return;
                    }
                    ProxyDataTracker.this.mProxyStatusService = new Messenger(bundle.getBinder(ProxyDataTracker.KEY_REPLY_TO_MESSENGER_BINDER));
                    if (ProxyDataTracker.this.mReconnectRequested.get()) {
                        ProxyDataTracker.this.reconnect();
                        return;
                    }
                    return;
                }
                ProxyDataTracker.this.setDetailedState(DetailedState.DISCONNECTED, ProxyDataTracker.REASON_PROXY_DOWN, null);
                return;
            }
            Log.d(ProxyDataTracker.TAG, "Unrecognized broadcast intent");
        }
    }

    public ProxyDataTracker() {
        this.mReconnectRequested = new AtomicBoolean(false);
        this.mIsProxyAvailable = new AtomicBoolean(false);
        this.mDefaultGatewayAddr = new AtomicInteger(0);
        this.mProxyStatusServiceListener = new C05011();
        this.mNetworkInfo = new NetworkInfo(16, 0, NETWORK_TYPE, ProxyInfo.LOCAL_EXCL_LIST);
        this.mLinkProperties = new LinkProperties();
        this.mNetworkCapabilities = new NetworkCapabilities();
        this.mNetworkInfo.setIsAvailable(true);
        try {
            this.mLinkProperties.addDnsServer(InetAddress.getByName(DNS1));
            this.mLinkProperties.addDnsServer(InetAddress.getByName(DNS2));
            this.mLinkProperties.setInterfaceName(INTERFACE_NAME);
        } catch (UnknownHostException e) {
            Log.e(TAG, "Could not add DNS address", e);
        }
    }

    public Object clone() throws CloneNotSupportedException {
        throw new CloneNotSupportedException();
    }

    public void startMonitoring(Context context, Handler target) {
        this.mContext = context;
        this.mTarget = target;
        this.mContext.registerReceiver(this.mProxyStatusServiceListener, new IntentFilter(ACTION_PROXY_STATUS_CHANGE), PERMISSION_PROXY_STATUS_SENDER, null);
    }

    public boolean teardown() {
        setTeardownRequested(true);
        this.mReconnectRequested.set(false);
        try {
            if (this.mIsProxyAvailable.get() && this.mProxyStatusService != null) {
                this.mProxyStatusService.send(Message.obtain(null, (int) MSG_TEAR_DOWN_REQUEST));
            }
            setDetailedState(DetailedState.DISCONNECTED, REASON_DISABLED, null);
            return true;
        } catch (RemoteException e) {
            Log.e(TAG, "Unable to connect to proxy status service", e);
            return false;
        }
    }

    public boolean reconnect() {
        this.mReconnectRequested.set(true);
        setTeardownRequested(false);
        if (this.mIsProxyAvailable.get()) {
            setDetailedState(DetailedState.CONNECTING, REASON_ENABLED, null);
            try {
                this.mProxyStatusService.send(Message.obtain(null, (int) MSG_SETUP_REQUEST));
                setDetailedState(DetailedState.CONNECTED, REASON_ENABLED, null);
                return true;
            } catch (RemoteException e) {
                Log.e(TAG, "Unable to connect to proxy status service", e);
                setDetailedState(DetailedState.DISCONNECTED, REASON_PROXY_DOWN, null);
                return false;
            }
        }
        Log.w(TAG, "Reconnect requested even though proxy service is not up. Bailing.");
        return false;
    }

    public int getDefaultGatewayAddr() {
        return this.mDefaultGatewayAddr.get();
    }

    public String getTcpBufferSizesPropName() {
        return BaseNetworkStateTracker.PROP_TCP_BUFFER_WIFI;
    }

    private void setDetailedState(DetailedState state, String reason, String extraInfo) {
        this.mNetworkInfo.setDetailedState(state, reason, extraInfo);
        this.mTarget.obtainMessage(KeyEvent.META_META_MASK, this.mNetworkInfo).sendToTarget();
    }
}
