package android.net;

import android.app.PendingIntent;
import android.content.Context;
import android.net.wifi.WifiDevice;
import android.os.Binder;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.INetworkActivityListener;
import android.os.INetworkActivityListener.Stub;
import android.os.INetworkManagementService;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.telephony.SubscriptionManager;
import android.util.ArrayMap;
import android.util.Log;
import com.android.internal.telephony.ITelephony;
import com.android.internal.util.Preconditions;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import libcore.net.event.NetworkEventDispatcher;

public class ConnectivityManager {
    @Deprecated
    public static final String ACTION_BACKGROUND_DATA_SETTING_CHANGED = "android.net.conn.BACKGROUND_DATA_SETTING_CHANGED";
    public static final String ACTION_CAPTIVE_PORTAL_TEST_COMPLETED = "android.net.conn.CAPTIVE_PORTAL_TEST_COMPLETED";
    public static final String ACTION_DATA_ACTIVITY_CHANGE = "android.net.conn.DATA_ACTIVITY_CHANGE";
    public static final String ACTION_TETHER_STATE_CHANGED = "android.net.conn.TETHER_STATE_CHANGED";
    private static final int BASE = 524288;
    public static final int CALLBACK_AVAILABLE = 524290;
    public static final int CALLBACK_CAP_CHANGED = 524294;
    public static final int CALLBACK_EXIT = 524297;
    public static final int CALLBACK_IP_CHANGED = 524295;
    public static final int CALLBACK_LOSING = 524291;
    public static final int CALLBACK_LOST = 524292;
    public static final int CALLBACK_PRECHECK = 524289;
    public static final int CALLBACK_RELEASED = 524296;
    public static final int CALLBACK_UNAVAIL = 524293;
    public static final String CONNECTIVITY_ACTION = "android.net.conn.CONNECTIVITY_CHANGE";
    public static final String CONNECTIVITY_ACTION_IMMEDIATE = "android.net.conn.CONNECTIVITY_CHANGE_IMMEDIATE";
    @Deprecated
    public static final int DEFAULT_NETWORK_PREFERENCE = 1;
    private static final int EXPIRE_LEGACY_REQUEST = 524298;
    public static final String EXTRA_ACTIVE_TETHER = "activeArray";
    public static final String EXTRA_AVAILABLE_TETHER = "availableArray";
    public static final String EXTRA_DEVICE_TYPE = "deviceType";
    public static final String EXTRA_ERRORED_TETHER = "erroredArray";
    public static final String EXTRA_EXTRA_INFO = "extraInfo";
    public static final String EXTRA_INET_CONDITION = "inetCondition";
    public static final String EXTRA_IS_ACTIVE = "isActive";
    public static final String EXTRA_IS_CAPTIVE_PORTAL = "captivePortal";
    public static final String EXTRA_IS_FAILOVER = "isFailover";
    public static final String EXTRA_NETWORK = "android.net.extra.NETWORK";
    @Deprecated
    public static final String EXTRA_NETWORK_INFO = "networkInfo";
    public static final String EXTRA_NETWORK_REQUEST = "android.net.extra.NETWORK_REQUEST";
    public static final String EXTRA_NETWORK_TYPE = "networkType";
    public static final String EXTRA_NO_CONNECTIVITY = "noConnectivity";
    public static final String EXTRA_OTHER_NETWORK_INFO = "otherNetwork";
    public static final String EXTRA_REALTIME_NS = "tsNanos";
    public static final String EXTRA_REASON = "reason";
    public static final String INET_CONDITION_ACTION = "android.net.conn.INET_CONDITION_ACTION";
    private static final int LISTEN = 1;
    public static final int MAX_NETWORK_REQUEST_TIMEOUT_MS = 6000000;
    public static final int MAX_NETWORK_TYPE = 17;
    public static final int MAX_RADIO_TYPE = 17;
    public static final int NETID_UNSET = 0;
    private static final int REQUEST = 2;
    public static final int REQUEST_ID_UNSET = 0;
    private static final String TAG = "ConnectivityManager";
    public static final String TETHER_CONNECT_STATE_CHANGED = "android.net.conn.TETHER_CONNECT_STATE_CHANGED";
    public static final int TETHER_ERROR_DISABLE_NAT_ERROR = 9;
    public static final int TETHER_ERROR_ENABLE_NAT_ERROR = 8;
    public static final int TETHER_ERROR_IFACE_CFG_ERROR = 10;
    public static final int TETHER_ERROR_MASTER_ERROR = 5;
    public static final int TETHER_ERROR_NO_ERROR = 0;
    public static final int TETHER_ERROR_SERVICE_UNAVAIL = 2;
    public static final int TETHER_ERROR_TETHER_IFACE_ERROR = 6;
    public static final int TETHER_ERROR_UNAVAIL_IFACE = 4;
    public static final int TETHER_ERROR_UNKNOWN_IFACE = 1;
    public static final int TETHER_ERROR_UNSUPPORTED = 3;
    public static final int TETHER_ERROR_UNTETHER_IFACE_ERROR = 7;
    public static final int TYPE_BLUETOOTH = 7;
    public static final int TYPE_DUMMY = 8;
    public static final int TYPE_ETHERNET = 9;
    public static final int TYPE_MOBILE = 0;
    public static final int TYPE_MOBILE_CBS = 12;
    public static final int TYPE_MOBILE_DUN = 4;
    public static final int TYPE_MOBILE_EMERGENCY = 15;
    public static final int TYPE_MOBILE_FOTA = 10;
    public static final int TYPE_MOBILE_HIPRI = 5;
    public static final int TYPE_MOBILE_IA = 14;
    public static final int TYPE_MOBILE_IMS = 11;
    public static final int TYPE_MOBILE_MMS = 2;
    public static final int TYPE_MOBILE_SUPL = 3;
    public static final int TYPE_NONE = -1;
    public static final int TYPE_PROXY = 16;
    public static final int TYPE_VPN = 17;
    public static final int TYPE_WIFI = 1;
    public static final int TYPE_WIFI_P2P = 13;
    public static final int TYPE_WIMAX = 6;
    static CallbackHandler sCallbackHandler;
    static final AtomicInteger sCallbackRefCount;
    private static ConnectivityManager sInstance;
    private static HashMap<NetworkCapabilities, LegacyRequest> sLegacyRequests;
    static final HashMap<NetworkRequest, NetworkCallback> sNetworkCallback;
    private INetworkManagementService mNMService;
    private final ArrayMap<OnNetworkActiveListener, INetworkActivityListener> mNetworkActivityListeners;
    private final IConnectivityManager mService;

    /* renamed from: android.net.ConnectivityManager.1 */
    class C04721 extends Stub {
        final /* synthetic */ OnNetworkActiveListener val$l;

        C04721(OnNetworkActiveListener onNetworkActiveListener) {
            this.val$l = onNetworkActiveListener;
        }

        public void onNetworkActive() throws RemoteException {
            this.val$l.onNetworkActive();
        }
    }

    private class CallbackHandler extends Handler {
        private static final String TAG = "ConnectivityManager.CallbackHandler";
        private final HashMap<NetworkRequest, NetworkCallback> mCallbackMap;
        private final ConnectivityManager mCm;
        private final AtomicInteger mRefCount;

        CallbackHandler(Looper looper, HashMap<NetworkRequest, NetworkCallback> callbackMap, AtomicInteger refCount, ConnectivityManager cm) {
            super(looper);
            this.mCallbackMap = callbackMap;
            this.mRefCount = refCount;
            this.mCm = cm;
        }

        public void handleMessage(Message message) {
            Log.d(TAG, "CM callback handler got msg " + message.what);
            NetworkCallback callbacks;
            switch (message.what) {
                case ConnectivityManager.CALLBACK_PRECHECK /*524289*/:
                    callbacks = getCallbacks((NetworkRequest) getObject(message, NetworkRequest.class));
                    if (callbacks != null) {
                        callbacks.onPreCheck((Network) getObject(message, Network.class));
                    } else {
                        Log.e(TAG, "callback not found for PRECHECK message");
                    }
                case ConnectivityManager.CALLBACK_AVAILABLE /*524290*/:
                    callbacks = getCallbacks((NetworkRequest) getObject(message, NetworkRequest.class));
                    if (callbacks != null) {
                        callbacks.onAvailable((Network) getObject(message, Network.class));
                    } else {
                        Log.e(TAG, "callback not found for AVAILABLE message");
                    }
                case ConnectivityManager.CALLBACK_LOSING /*524291*/:
                    callbacks = getCallbacks((NetworkRequest) getObject(message, NetworkRequest.class));
                    if (callbacks != null) {
                        callbacks.onLosing((Network) getObject(message, Network.class), message.arg1);
                    } else {
                        Log.e(TAG, "callback not found for LOSING message");
                    }
                case ConnectivityManager.CALLBACK_LOST /*524292*/:
                    callbacks = getCallbacks((NetworkRequest) getObject(message, NetworkRequest.class));
                    if (callbacks != null) {
                        callbacks.onLost((Network) getObject(message, Network.class));
                    } else {
                        Log.e(TAG, "callback not found for LOST message");
                    }
                case ConnectivityManager.CALLBACK_UNAVAIL /*524293*/:
                    NetworkRequest request = (NetworkRequest) getObject(message, NetworkRequest.class);
                    synchronized (this.mCallbackMap) {
                        callbacks = (NetworkCallback) this.mCallbackMap.get(request);
                        break;
                    }
                    if (callbacks != null) {
                        callbacks.onUnavailable();
                    } else {
                        Log.e(TAG, "callback not found for UNAVAIL message");
                    }
                case ConnectivityManager.CALLBACK_CAP_CHANGED /*524294*/:
                    callbacks = getCallbacks((NetworkRequest) getObject(message, NetworkRequest.class));
                    if (callbacks != null) {
                        callbacks.onCapabilitiesChanged((Network) getObject(message, Network.class), (NetworkCapabilities) getObject(message, NetworkCapabilities.class));
                    } else {
                        Log.e(TAG, "callback not found for CAP_CHANGED message");
                    }
                case ConnectivityManager.CALLBACK_IP_CHANGED /*524295*/:
                    callbacks = getCallbacks((NetworkRequest) getObject(message, NetworkRequest.class));
                    if (callbacks != null) {
                        callbacks.onLinkPropertiesChanged((Network) getObject(message, Network.class), (LinkProperties) getObject(message, LinkProperties.class));
                    } else {
                        Log.e(TAG, "callback not found for IP_CHANGED message");
                    }
                case ConnectivityManager.CALLBACK_RELEASED /*524296*/:
                    NetworkRequest req = (NetworkRequest) getObject(message, NetworkRequest.class);
                    synchronized (this.mCallbackMap) {
                        callbacks = (NetworkCallback) this.mCallbackMap.remove(req);
                        break;
                    }
                    if (callbacks != null) {
                        synchronized (this.mRefCount) {
                            if (this.mRefCount.decrementAndGet() == 0) {
                                getLooper().quit();
                            }
                            break;
                        }
                        return;
                    }
                    Log.e(TAG, "callback not found for CANCELED message");
                case ConnectivityManager.CALLBACK_EXIT /*524297*/:
                    Log.d(TAG, "Listener quiting");
                    getLooper().quit();
                case ConnectivityManager.EXPIRE_LEGACY_REQUEST /*524298*/:
                    ConnectivityManager.this.expireRequest((NetworkCapabilities) message.obj, message.arg1);
                default:
            }
        }

        private Object getObject(Message msg, Class c) {
            return msg.getData().getParcelable(c.getSimpleName());
        }

        private NetworkCallback getCallbacks(NetworkRequest req) {
            NetworkCallback networkCallback;
            synchronized (this.mCallbackMap) {
                networkCallback = (NetworkCallback) this.mCallbackMap.get(req);
            }
            return networkCallback;
        }
    }

    public static class NetworkCallback {
        public static final int AVAILABLE = 2;
        public static final int CANCELED = 8;
        public static final int CAP_CHANGED = 6;
        public static final int LOSING = 3;
        public static final int LOST = 4;
        public static final int PRECHECK = 1;
        public static final int PROP_CHANGED = 7;
        public static final int UNAVAIL = 5;
        private NetworkRequest networkRequest;

        public void onPreCheck(Network network) {
        }

        public void onAvailable(Network network) {
        }

        public void onLosing(Network network, int maxMsToLive) {
        }

        public void onLost(Network network) {
        }

        public void onUnavailable() {
        }

        public void onCapabilitiesChanged(Network network, NetworkCapabilities networkCapabilities) {
        }

        public void onLinkPropertiesChanged(Network network, LinkProperties linkProperties) {
        }
    }

    private static class LegacyRequest {
        Network currentNetwork;
        int delay;
        int expireSequenceNumber;
        NetworkCallback networkCallback;
        NetworkCapabilities networkCapabilities;
        NetworkRequest networkRequest;

        /* renamed from: android.net.ConnectivityManager.LegacyRequest.1 */
        class C04731 extends NetworkCallback {
            C04731() {
            }

            public void onAvailable(Network network) {
                LegacyRequest.this.currentNetwork = network;
                Log.d(ConnectivityManager.TAG, "startUsingNetworkFeature got Network:" + network);
                ConnectivityManager.setProcessDefaultNetworkForHostResolution(network);
            }

            public void onLost(Network network) {
                if (network.equals(LegacyRequest.this.currentNetwork)) {
                    LegacyRequest.this.clearDnsBinding();
                }
                Log.d(ConnectivityManager.TAG, "startUsingNetworkFeature lost Network:" + network);
            }
        }

        private LegacyRequest() {
            this.delay = ConnectivityManager.TYPE_NONE;
            this.networkCallback = new C04731();
        }

        private void clearDnsBinding() {
            if (this.currentNetwork != null) {
                this.currentNetwork = null;
                ConnectivityManager.setProcessDefaultNetworkForHostResolution(null);
            }
        }
    }

    public interface OnNetworkActiveListener {
        void onNetworkActive();
    }

    public static boolean isNetworkTypeValid(int networkType) {
        return networkType >= 0 && networkType <= TYPE_VPN;
    }

    public static String getNetworkTypeName(int type) {
        switch (type) {
            case TYPE_MOBILE /*0*/:
                return "MOBILE";
            case TYPE_WIFI /*1*/:
                return "WIFI";
            case TYPE_MOBILE_MMS /*2*/:
                return "MOBILE_MMS";
            case TYPE_MOBILE_SUPL /*3*/:
                return "MOBILE_SUPL";
            case TYPE_MOBILE_DUN /*4*/:
                return "MOBILE_DUN";
            case TYPE_MOBILE_HIPRI /*5*/:
                return "MOBILE_HIPRI";
            case TYPE_WIMAX /*6*/:
                return "WIMAX";
            case TYPE_BLUETOOTH /*7*/:
                return "BLUETOOTH";
            case TYPE_DUMMY /*8*/:
                return "DUMMY";
            case TYPE_ETHERNET /*9*/:
                return "ETHERNET";
            case TYPE_MOBILE_FOTA /*10*/:
                return "MOBILE_FOTA";
            case TYPE_MOBILE_IMS /*11*/:
                return "MOBILE_IMS";
            case TYPE_MOBILE_CBS /*12*/:
                return "MOBILE_CBS";
            case TYPE_WIFI_P2P /*13*/:
                return "WIFI_P2P";
            case TYPE_MOBILE_IA /*14*/:
                return "MOBILE_IA";
            case TYPE_MOBILE_EMERGENCY /*15*/:
                return "MOBILE_EMERGENCY";
            case TYPE_PROXY /*16*/:
                return "PROXY";
            default:
                return Integer.toString(type);
        }
    }

    public static boolean isNetworkTypeMobile(int networkType) {
        switch (networkType) {
            case TYPE_MOBILE /*0*/:
            case TYPE_MOBILE_MMS /*2*/:
            case TYPE_MOBILE_SUPL /*3*/:
            case TYPE_MOBILE_DUN /*4*/:
            case TYPE_MOBILE_HIPRI /*5*/:
            case TYPE_MOBILE_FOTA /*10*/:
            case TYPE_MOBILE_IMS /*11*/:
            case TYPE_MOBILE_CBS /*12*/:
            case TYPE_MOBILE_IA /*14*/:
            case TYPE_MOBILE_EMERGENCY /*15*/:
                return true;
            default:
                return false;
        }
    }

    public static boolean isNetworkTypeWifi(int networkType) {
        switch (networkType) {
            case TYPE_WIFI /*1*/:
            case TYPE_WIFI_P2P /*13*/:
                return true;
            default:
                return false;
        }
    }

    public void setNetworkPreference(int preference) {
    }

    public int getNetworkPreference() {
        return TYPE_NONE;
    }

    public NetworkInfo getActiveNetworkInfo() {
        try {
            return this.mService.getActiveNetworkInfo();
        } catch (RemoteException e) {
            return null;
        }
    }

    public NetworkInfo getActiveNetworkInfoForUid(int uid) {
        try {
            return this.mService.getActiveNetworkInfoForUid(uid);
        } catch (RemoteException e) {
            return null;
        }
    }

    public NetworkInfo getNetworkInfo(int networkType) {
        try {
            return this.mService.getNetworkInfo(networkType);
        } catch (RemoteException e) {
            return null;
        }
    }

    public NetworkInfo getNetworkInfo(Network network) {
        try {
            return this.mService.getNetworkInfoForNetwork(network);
        } catch (RemoteException e) {
            return null;
        }
    }

    public NetworkInfo[] getAllNetworkInfo() {
        try {
            return this.mService.getAllNetworkInfo();
        } catch (RemoteException e) {
            return null;
        }
    }

    public Network getNetworkForType(int networkType) {
        try {
            return this.mService.getNetworkForType(networkType);
        } catch (RemoteException e) {
            return null;
        }
    }

    public Network[] getAllNetworks() {
        try {
            return this.mService.getAllNetworks();
        } catch (RemoteException e) {
            return null;
        }
    }

    public NetworkCapabilities[] getDefaultNetworkCapabilitiesForUser(int userId) {
        try {
            return this.mService.getDefaultNetworkCapabilitiesForUser(userId);
        } catch (RemoteException e) {
            return null;
        }
    }

    public NetworkInfo getProvisioningOrActiveNetworkInfo() {
        try {
            return this.mService.getProvisioningOrActiveNetworkInfo();
        } catch (RemoteException e) {
            return null;
        }
    }

    public LinkProperties getActiveLinkProperties() {
        try {
            return this.mService.getActiveLinkProperties();
        } catch (RemoteException e) {
            return null;
        }
    }

    public LinkProperties getLinkProperties(int networkType) {
        try {
            return this.mService.getLinkPropertiesForType(networkType);
        } catch (RemoteException e) {
            return null;
        }
    }

    public LinkProperties getLinkProperties(Network network) {
        try {
            return this.mService.getLinkProperties(network);
        } catch (RemoteException e) {
            return null;
        }
    }

    public NetworkCapabilities getNetworkCapabilities(Network network) {
        try {
            return this.mService.getNetworkCapabilities(network);
        } catch (RemoteException e) {
            return null;
        }
    }

    public int startUsingNetworkFeature(int networkType, String feature) {
        NetworkCapabilities netCap = networkCapabilitiesForFeature(networkType, feature);
        if (netCap == null) {
            Log.d(TAG, "Can't satisfy startUsingNetworkFeature for " + networkType + ", " + feature);
            return TYPE_MOBILE_SUPL;
        }
        synchronized (sLegacyRequests) {
            LegacyRequest l = (LegacyRequest) sLegacyRequests.get(netCap);
            if (l != null) {
                Log.d(TAG, "renewing startUsingNetworkFeature request " + l.networkRequest);
                renewRequestLocked(l);
                if (l.currentNetwork != null) {
                    return TYPE_MOBILE;
                }
                return TYPE_WIFI;
            }
            NetworkRequest request = requestNetworkForFeatureLocked(netCap);
            if (request != null) {
                Log.d(TAG, "starting startUsingNetworkFeature for request " + request);
                return TYPE_WIFI;
            }
            Log.d(TAG, " request Failed");
            return TYPE_MOBILE_SUPL;
        }
    }

    public int stopUsingNetworkFeature(int networkType, String feature) {
        NetworkCapabilities netCap = networkCapabilitiesForFeature(networkType, feature);
        if (netCap == null) {
            Log.d(TAG, "Can't satisfy stopUsingNetworkFeature for " + networkType + ", " + feature);
            return TYPE_NONE;
        }
        if (removeRequestForFeature(netCap)) {
            Log.d(TAG, "stopUsingNetworkFeature for " + networkType + ", " + feature);
        }
        return TYPE_WIFI;
    }

    public static void maybeMarkCapabilitiesRestricted(NetworkCapabilities nc) {
        int[] arr$ = nc.getCapabilities();
        int len$ = arr$.length;
        int i$ = TYPE_MOBILE;
        while (i$ < len$) {
            switch (arr$[i$]) {
                case TYPE_MOBILE_MMS /*2*/:
                case TYPE_MOBILE_SUPL /*3*/:
                case TYPE_MOBILE_DUN /*4*/:
                case TYPE_MOBILE_HIPRI /*5*/:
                case TYPE_BLUETOOTH /*7*/:
                case TYPE_DUMMY /*8*/:
                case TYPE_ETHERNET /*9*/:
                case TYPE_MOBILE_FOTA /*10*/:
                case TYPE_WIFI_P2P /*13*/:
                    i$ += TYPE_WIFI;
                default:
                    return;
            }
        }
        nc.removeCapability(TYPE_WIFI_P2P);
    }

    private NetworkCapabilities networkCapabilitiesForFeature(int networkType, String feature) {
        NetworkCapabilities netCap;
        if (networkType == 0) {
            int cap;
            if ("enableMMS".equals(feature)) {
                cap = TYPE_MOBILE;
            } else if ("enableSUPL".equals(feature)) {
                cap = TYPE_WIFI;
            } else if ("enableDUN".equals(feature) || "enableDUNAlways".equals(feature)) {
                cap = TYPE_MOBILE_MMS;
            } else if ("enableHIPRI".equals(feature)) {
                cap = TYPE_MOBILE_CBS;
            } else if ("enableFOTA".equals(feature)) {
                cap = TYPE_MOBILE_SUPL;
            } else if ("enableIMS".equals(feature)) {
                cap = TYPE_MOBILE_DUN;
            } else if (!"enableCBS".equals(feature)) {
                return null;
            } else {
                cap = TYPE_MOBILE_HIPRI;
            }
            netCap = new NetworkCapabilities();
            netCap.addTransportType(TYPE_MOBILE).addCapability(cap);
            maybeMarkCapabilitiesRestricted(netCap);
            return netCap;
        } else if (networkType != TYPE_WIFI || !"p2p".equals(feature)) {
            return null;
        } else {
            netCap = new NetworkCapabilities();
            netCap.addTransportType(TYPE_WIFI);
            netCap.addCapability(TYPE_WIMAX);
            maybeMarkCapabilitiesRestricted(netCap);
            return netCap;
        }
    }

    private int inferLegacyTypeForNetworkCapabilities(NetworkCapabilities netCap) {
        if (netCap == null) {
            return TYPE_NONE;
        }
        if (!netCap.hasTransport(TYPE_MOBILE)) {
            return TYPE_NONE;
        }
        String type = null;
        int result = TYPE_NONE;
        if (netCap.hasCapability(TYPE_MOBILE_HIPRI)) {
            type = "enableCBS";
            result = TYPE_MOBILE_CBS;
        } else if (netCap.hasCapability(TYPE_MOBILE_DUN)) {
            type = "enableIMS";
            result = TYPE_MOBILE_IMS;
        } else if (netCap.hasCapability(TYPE_MOBILE_SUPL)) {
            type = "enableFOTA";
            result = TYPE_MOBILE_FOTA;
        } else if (netCap.hasCapability(TYPE_MOBILE_MMS)) {
            type = "enableDUN";
            result = TYPE_MOBILE_DUN;
        } else if (netCap.hasCapability(TYPE_WIFI)) {
            type = "enableSUPL";
            result = TYPE_MOBILE_SUPL;
        } else if (netCap.hasCapability(TYPE_MOBILE)) {
            type = "enableMMS";
            result = TYPE_MOBILE_MMS;
        } else if (netCap.hasCapability(TYPE_MOBILE_CBS)) {
            type = "enableHIPRI";
            result = TYPE_MOBILE_HIPRI;
        }
        if (type != null) {
            NetworkCapabilities testCap = networkCapabilitiesForFeature(TYPE_MOBILE, type);
            if (testCap.equalsNetCapabilities(netCap) && testCap.equalsTransportTypes(netCap)) {
                return result;
            }
        }
        return TYPE_NONE;
    }

    private int legacyTypeForNetworkCapabilities(NetworkCapabilities netCap) {
        if (netCap == null) {
            return TYPE_NONE;
        }
        if (netCap.hasCapability(TYPE_MOBILE_HIPRI)) {
            return TYPE_MOBILE_CBS;
        }
        if (netCap.hasCapability(TYPE_MOBILE_DUN)) {
            return TYPE_MOBILE_IMS;
        }
        if (netCap.hasCapability(TYPE_MOBILE_SUPL)) {
            return TYPE_MOBILE_FOTA;
        }
        if (netCap.hasCapability(TYPE_MOBILE_MMS)) {
            return TYPE_MOBILE_DUN;
        }
        if (netCap.hasCapability(TYPE_WIFI)) {
            return TYPE_MOBILE_SUPL;
        }
        if (netCap.hasCapability(TYPE_MOBILE)) {
            return TYPE_MOBILE_MMS;
        }
        if (netCap.hasCapability(TYPE_MOBILE_CBS)) {
            return TYPE_MOBILE_HIPRI;
        }
        if (netCap.hasCapability(TYPE_WIMAX)) {
            return TYPE_WIFI_P2P;
        }
        return TYPE_NONE;
    }

    static {
        sLegacyRequests = new HashMap();
        sNetworkCallback = new HashMap();
        sCallbackRefCount = new AtomicInteger(TYPE_MOBILE);
        sCallbackHandler = null;
    }

    private NetworkRequest findRequestForFeature(NetworkCapabilities netCap) {
        synchronized (sLegacyRequests) {
            LegacyRequest l = (LegacyRequest) sLegacyRequests.get(netCap);
            if (l != null) {
                NetworkRequest networkRequest = l.networkRequest;
                return networkRequest;
            }
            return null;
        }
    }

    private void renewRequestLocked(LegacyRequest l) {
        l.expireSequenceNumber += TYPE_WIFI;
        Log.d(TAG, "renewing request to seqNum " + l.expireSequenceNumber);
        sendExpireMsgForFeature(l.networkCapabilities, l.expireSequenceNumber, l.delay);
    }

    private void expireRequest(NetworkCapabilities netCap, int sequenceNum) {
        synchronized (sLegacyRequests) {
            LegacyRequest l = (LegacyRequest) sLegacyRequests.get(netCap);
            if (l == null) {
                return;
            }
            int ourSeqNum = l.expireSequenceNumber;
            if (l.expireSequenceNumber == sequenceNum) {
                removeRequestForFeature(netCap);
            }
            Log.d(TAG, "expireRequest with " + ourSeqNum + ", " + sequenceNum);
        }
    }

    private NetworkRequest requestNetworkForFeatureLocked(NetworkCapabilities netCap) {
        int delay = TYPE_NONE;
        int type = legacyTypeForNetworkCapabilities(netCap);
        try {
            delay = this.mService.getRestoreDefaultNetworkDelay(type);
        } catch (RemoteException e) {
        }
        LegacyRequest l = new LegacyRequest();
        l.networkCapabilities = netCap;
        l.delay = delay;
        l.expireSequenceNumber = TYPE_MOBILE;
        l.networkRequest = sendRequestForNetwork(netCap, l.networkCallback, TYPE_MOBILE, TYPE_MOBILE_MMS, type);
        if (l.networkRequest == null) {
            return null;
        }
        sLegacyRequests.put(netCap, l);
        sendExpireMsgForFeature(netCap, l.expireSequenceNumber, delay);
        return l.networkRequest;
    }

    private void sendExpireMsgForFeature(NetworkCapabilities netCap, int seqNum, int delay) {
        if (delay >= 0) {
            Log.d(TAG, "sending expire msg with seqNum " + seqNum + " and delay " + delay);
            sCallbackHandler.sendMessageDelayed(sCallbackHandler.obtainMessage(EXPIRE_LEGACY_REQUEST, seqNum, TYPE_MOBILE, netCap), (long) delay);
        }
    }

    private boolean removeRequestForFeature(NetworkCapabilities netCap) {
        synchronized (sLegacyRequests) {
            LegacyRequest l = (LegacyRequest) sLegacyRequests.remove(netCap);
        }
        if (l == null) {
            return false;
        }
        unregisterNetworkCallback(l.networkCallback);
        l.clearDnsBinding();
        return true;
    }

    public boolean requestRouteToHost(int networkType, int hostAddress) {
        return requestRouteToHostAddress(networkType, NetworkUtils.intToInetAddress(hostAddress));
    }

    public boolean requestRouteToHostAddress(int networkType, InetAddress hostAddress) {
        try {
            return this.mService.requestRouteToHostAddress(networkType, hostAddress.getAddress());
        } catch (RemoteException e) {
            return false;
        }
    }

    @Deprecated
    public boolean getBackgroundDataSetting() {
        return true;
    }

    @Deprecated
    public void setBackgroundDataSetting(boolean allowBackgroundData) {
    }

    public NetworkQuotaInfo getActiveNetworkQuotaInfo() {
        try {
            return this.mService.getActiveNetworkQuotaInfo();
        } catch (RemoteException e) {
            return null;
        }
    }

    public boolean getMobileDataEnabled() {
        IBinder b = ServiceManager.getService(Context.TELEPHONY_SERVICE);
        if (b != null) {
            try {
                ITelephony it = ITelephony.Stub.asInterface(b);
                int subId = SubscriptionManager.getDefaultDataSubId();
                Log.d(TAG, "getMobileDataEnabled()+ subId=" + subId);
                boolean retVal = it.getDataEnabled(subId);
                Log.d(TAG, "getMobileDataEnabled()- subId=" + subId + " retVal=" + retVal);
                return retVal;
            } catch (RemoteException e) {
            }
        }
        Log.d(TAG, "getMobileDataEnabled()- remote exception retVal=false");
        return false;
    }

    private INetworkManagementService getNetworkManagementService() {
        INetworkManagementService iNetworkManagementService;
        synchronized (this) {
            if (this.mNMService != null) {
                iNetworkManagementService = this.mNMService;
            } else {
                this.mNMService = INetworkManagementService.Stub.asInterface(ServiceManager.getService(Context.NETWORKMANAGEMENT_SERVICE));
                iNetworkManagementService = this.mNMService;
            }
        }
        return iNetworkManagementService;
    }

    public void addDefaultNetworkActiveListener(OnNetworkActiveListener l) {
        INetworkActivityListener rl = new C04721(l);
        try {
            getNetworkManagementService().registerNetworkActivityListener(rl);
            this.mNetworkActivityListeners.put(l, rl);
        } catch (RemoteException e) {
        }
    }

    public void removeDefaultNetworkActiveListener(OnNetworkActiveListener l) {
        INetworkActivityListener rl = (INetworkActivityListener) this.mNetworkActivityListeners.get(l);
        if (rl == null) {
            throw new IllegalArgumentException("Listener not registered: " + l);
        }
        try {
            getNetworkManagementService().unregisterNetworkActivityListener(rl);
        } catch (RemoteException e) {
        }
    }

    public boolean isDefaultNetworkActive() {
        try {
            return getNetworkManagementService().isNetworkActive();
        } catch (RemoteException e) {
            return false;
        }
    }

    public ConnectivityManager(IConnectivityManager service) {
        this.mNetworkActivityListeners = new ArrayMap();
        this.mService = (IConnectivityManager) Preconditions.checkNotNull(service, "missing IConnectivityManager");
        sInstance = this;
    }

    public static ConnectivityManager from(Context context) {
        return (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
    }

    public static final void enforceTetherChangePermission(Context context) {
        if (context.getResources().getStringArray(17235990).length == TYPE_MOBILE_MMS) {
            context.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", "ConnectivityService");
        } else {
            context.enforceCallingOrSelfPermission("android.permission.CHANGE_NETWORK_STATE", "ConnectivityService");
        }
    }

    public static ConnectivityManager getInstance() {
        if (sInstance != null) {
            return sInstance;
        }
        throw new IllegalStateException("No ConnectivityManager yet constructed");
    }

    public String[] getTetherableIfaces() {
        try {
            return this.mService.getTetherableIfaces();
        } catch (RemoteException e) {
            return new String[TYPE_MOBILE];
        }
    }

    public String[] getTetheredIfaces() {
        try {
            return this.mService.getTetheredIfaces();
        } catch (RemoteException e) {
            return new String[TYPE_MOBILE];
        }
    }

    public String[] getTetheringErroredIfaces() {
        try {
            return this.mService.getTetheringErroredIfaces();
        } catch (RemoteException e) {
            return new String[TYPE_MOBILE];
        }
    }

    public String[] getTetheredDhcpRanges() {
        try {
            return this.mService.getTetheredDhcpRanges();
        } catch (RemoteException e) {
            return new String[TYPE_MOBILE];
        }
    }

    public int tether(String iface) {
        try {
            return this.mService.tether(iface);
        } catch (RemoteException e) {
            return TYPE_MOBILE_MMS;
        }
    }

    public int untether(String iface) {
        try {
            return this.mService.untether(iface);
        } catch (RemoteException e) {
            return TYPE_MOBILE_MMS;
        }
    }

    public boolean isTetheringSupported() {
        try {
            return this.mService.isTetheringSupported();
        } catch (RemoteException e) {
            return false;
        }
    }

    public String[] getTetherableUsbRegexs() {
        try {
            return this.mService.getTetherableUsbRegexs();
        } catch (RemoteException e) {
            return new String[TYPE_MOBILE];
        }
    }

    public String[] getTetherableWifiRegexs() {
        try {
            return this.mService.getTetherableWifiRegexs();
        } catch (RemoteException e) {
            return new String[TYPE_MOBILE];
        }
    }

    public String[] getTetherableBluetoothRegexs() {
        try {
            return this.mService.getTetherableBluetoothRegexs();
        } catch (RemoteException e) {
            return new String[TYPE_MOBILE];
        }
    }

    public int setUsbTethering(boolean enable) {
        try {
            return this.mService.setUsbTethering(enable);
        } catch (RemoteException e) {
            return TYPE_MOBILE_MMS;
        }
    }

    public List<WifiDevice> getTetherConnectedSta() {
        try {
            return this.mService.getTetherConnectedSta();
        } catch (RemoteException e) {
            return null;
        }
    }

    public int getLastTetherError(String iface) {
        try {
            return this.mService.getLastTetherError(iface);
        } catch (RemoteException e) {
            return TYPE_MOBILE_MMS;
        }
    }

    public void reportInetCondition(int networkType, int percentage) {
        try {
            this.mService.reportInetCondition(networkType, percentage);
        } catch (RemoteException e) {
        }
    }

    public void reportBadNetwork(Network network) {
        try {
            this.mService.reportBadNetwork(network);
        } catch (RemoteException e) {
        }
    }

    public void setGlobalProxy(ProxyInfo p) {
        try {
            this.mService.setGlobalProxy(p);
        } catch (RemoteException e) {
        }
    }

    public ProxyInfo getGlobalProxy() {
        try {
            return this.mService.getGlobalProxy();
        } catch (RemoteException e) {
            return null;
        }
    }

    public ProxyInfo getDefaultProxy() {
        Network network = getProcessDefaultNetwork();
        if (network != null) {
            ProxyInfo globalProxy = getGlobalProxy();
            if (globalProxy != null) {
                return globalProxy;
            }
            LinkProperties lp = getLinkProperties(network);
            return lp != null ? lp.getHttpProxy() : null;
        } else {
            try {
                return this.mService.getDefaultProxy();
            } catch (RemoteException e) {
                return null;
            }
        }
    }

    public void setDataDependency(int networkType, boolean met) {
        try {
            this.mService.setDataDependency(networkType, met);
        } catch (RemoteException e) {
        }
    }

    public boolean isNetworkSupported(int networkType) {
        try {
            return this.mService.isNetworkSupported(networkType);
        } catch (RemoteException e) {
            return false;
        }
    }

    public boolean isActiveNetworkMetered() {
        try {
            return this.mService.isActiveNetworkMetered();
        } catch (RemoteException e) {
            return false;
        }
    }

    public boolean updateLockdownVpn() {
        try {
            return this.mService.updateLockdownVpn();
        } catch (RemoteException e) {
            return false;
        }
    }

    public void captivePortalCheckCompleted(NetworkInfo info, boolean isCaptivePortal) {
        try {
            this.mService.captivePortalCheckCompleted(info, isCaptivePortal);
        } catch (RemoteException e) {
        }
    }

    public void supplyMessenger(int networkType, Messenger messenger) {
        try {
            this.mService.supplyMessenger(networkType, messenger);
        } catch (RemoteException e) {
        }
    }

    public int checkMobileProvisioning(int suggestedTimeOutMs) {
        int timeOutMs = TYPE_NONE;
        try {
            timeOutMs = this.mService.checkMobileProvisioning(suggestedTimeOutMs);
        } catch (RemoteException e) {
        }
        return timeOutMs;
    }

    public String getMobileProvisioningUrl() {
        try {
            return this.mService.getMobileProvisioningUrl();
        } catch (RemoteException e) {
            return null;
        }
    }

    public String getMobileRedirectedProvisioningUrl() {
        try {
            return this.mService.getMobileRedirectedProvisioningUrl();
        } catch (RemoteException e) {
            return null;
        }
    }

    public void setProvisioningNotificationVisible(boolean visible, int networkType, String action) {
        try {
            this.mService.setProvisioningNotificationVisible(visible, networkType, action);
        } catch (RemoteException e) {
        }
    }

    public void setAirplaneMode(boolean enable) {
        try {
            this.mService.setAirplaneMode(enable);
        } catch (RemoteException e) {
        }
    }

    public void registerNetworkFactory(Messenger messenger, String name) {
        try {
            this.mService.registerNetworkFactory(messenger, name);
        } catch (RemoteException e) {
        }
    }

    public void unregisterNetworkFactory(Messenger messenger) {
        try {
            this.mService.unregisterNetworkFactory(messenger);
        } catch (RemoteException e) {
        }
    }

    public void registerNetworkAgent(Messenger messenger, NetworkInfo ni, LinkProperties lp, NetworkCapabilities nc, int score, NetworkMisc misc) {
        try {
            this.mService.registerNetworkAgent(messenger, ni, lp, nc, score, misc);
        } catch (RemoteException e) {
        }
    }

    private void incCallbackHandlerRefCount() {
        synchronized (sCallbackRefCount) {
            if (sCallbackRefCount.incrementAndGet() == TYPE_WIFI) {
                HandlerThread callbackThread = new HandlerThread(TAG);
                callbackThread.start();
                sCallbackHandler = new CallbackHandler(callbackThread.getLooper(), sNetworkCallback, sCallbackRefCount, this);
            }
        }
    }

    private void decCallbackHandlerRefCount() {
        synchronized (sCallbackRefCount) {
            if (sCallbackRefCount.decrementAndGet() == 0) {
                sCallbackHandler.obtainMessage(CALLBACK_EXIT).sendToTarget();
                sCallbackHandler = null;
            }
        }
    }

    private NetworkRequest sendRequestForNetwork(NetworkCapabilities need, NetworkCallback networkCallback, int timeoutSec, int action, int legacyType) {
        if (networkCallback == null) {
            throw new IllegalArgumentException("null NetworkCallback");
        } else if (need == null) {
            throw new IllegalArgumentException("null NetworkCapabilities");
        } else {
            try {
                incCallbackHandlerRefCount();
                synchronized (sNetworkCallback) {
                    if (action == TYPE_WIFI) {
                        networkCallback.networkRequest = this.mService.listenForNetwork(need, new Messenger(sCallbackHandler), new Binder());
                    } else {
                        networkCallback.networkRequest = this.mService.requestNetwork(need, new Messenger(sCallbackHandler), timeoutSec, new Binder(), legacyType);
                    }
                    if (networkCallback.networkRequest != null) {
                        sNetworkCallback.put(networkCallback.networkRequest, networkCallback);
                    }
                }
            } catch (RemoteException e) {
            }
            if (networkCallback.networkRequest == null) {
                decCallbackHandlerRefCount();
            }
            return networkCallback.networkRequest;
        }
    }

    public void requestNetwork(NetworkRequest request, NetworkCallback networkCallback) {
        sendRequestForNetwork(request.networkCapabilities, networkCallback, TYPE_MOBILE, TYPE_MOBILE_MMS, inferLegacyTypeForNetworkCapabilities(request.networkCapabilities));
    }

    public void requestNetwork(NetworkRequest request, NetworkCallback networkCallback, int timeoutMs) {
        sendRequestForNetwork(request.networkCapabilities, networkCallback, timeoutMs, TYPE_MOBILE_MMS, inferLegacyTypeForNetworkCapabilities(request.networkCapabilities));
    }

    public void requestNetwork(NetworkRequest request, PendingIntent operation) {
        checkPendingIntent(operation);
        try {
            this.mService.pendingRequestForNetwork(request.networkCapabilities, operation);
        } catch (RemoteException e) {
        }
    }

    public void releaseNetworkRequest(PendingIntent operation) {
        checkPendingIntent(operation);
        try {
            this.mService.releasePendingNetworkRequest(operation);
        } catch (RemoteException e) {
        }
    }

    private void checkPendingIntent(PendingIntent intent) {
        if (intent == null) {
            throw new IllegalArgumentException("PendingIntent cannot be null.");
        }
    }

    public void registerNetworkCallback(NetworkRequest request, NetworkCallback networkCallback) {
        sendRequestForNetwork(request.networkCapabilities, networkCallback, TYPE_MOBILE, TYPE_WIFI, TYPE_NONE);
    }

    public void unregisterNetworkCallback(NetworkCallback networkCallback) {
        if (networkCallback == null || networkCallback.networkRequest == null || networkCallback.networkRequest.requestId == 0) {
            throw new IllegalArgumentException("Invalid NetworkCallback");
        }
        try {
            this.mService.releaseNetworkRequest(networkCallback.networkRequest);
        } catch (RemoteException e) {
        }
    }

    public static boolean setProcessDefaultNetwork(Network network) {
        int netId = network == null ? TYPE_MOBILE : network.netId;
        if (netId == NetworkUtils.getNetworkBoundToProcess()) {
            return true;
        }
        if (!NetworkUtils.bindProcessToNetwork(netId)) {
            return false;
        }
        Proxy.setHttpProxySystemProperty(getInstance().getDefaultProxy());
        InetAddress.clearDnsCache();
        NetworkEventDispatcher.getInstance().onNetworkConfigurationChanged();
        return true;
    }

    public static Network getProcessDefaultNetwork() {
        int netId = NetworkUtils.getNetworkBoundToProcess();
        if (netId == 0) {
            return null;
        }
        return new Network(netId);
    }

    public static boolean setProcessDefaultNetworkForHostResolution(Network network) {
        return NetworkUtils.bindProcessToNetworkForHostResolution(network == null ? TYPE_MOBILE : network.netId);
    }
}
