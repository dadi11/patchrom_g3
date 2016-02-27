package com.android.server.connectivity;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.NetworkRequest;
import android.net.ProxyInfo;
import android.net.TrafficStats;
import android.net.Uri;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Handler;
import android.os.Message;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.provider.Settings.Global;
import android.telephony.CellInfo;
import android.telephony.CellInfoCdma;
import android.telephony.CellInfoGsm;
import android.telephony.CellInfoLte;
import android.telephony.CellInfoWcdma;
import android.telephony.TelephonyManager;
import android.util.Log;
import com.android.internal.util.State;
import com.android.internal.util.StateMachine;
import com.android.server.location.LocationFudger;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Random;

public class NetworkMonitor extends StateMachine {
    private static final String ACTION_CAPTIVE_PORTAL_LOGGED_IN = "android.net.netmon.captive_portal_logged_in";
    public static final String ACTION_NETWORK_CONDITIONS_MEASURED = "android.net.conn.NETWORK_CONDITIONS_MEASURED";
    private static final int BASE = 532480;
    public static final int CAPTIVE_PORTAL_APP_RETURN_APPEASED = 0;
    public static final int CAPTIVE_PORTAL_APP_RETURN_UNWANTED = 1;
    public static final int CAPTIVE_PORTAL_APP_RETURN_WANTED_AS_IS = 2;
    private static final int CMD_CAPTIVE_PORTAL_APP_FINISHED = 532489;
    public static final int CMD_FORCE_REEVALUATION = 532488;
    private static final int CMD_LINGER_EXPIRED = 532484;
    public static final int CMD_NETWORK_CONNECTED = 532481;
    public static final int CMD_NETWORK_DISCONNECTED = 532487;
    public static final int CMD_NETWORK_LINGER = 532483;
    private static final int CMD_REEVALUATE = 532486;
    private static final boolean DBG = true;
    private static final int DEFAULT_LINGER_DELAY_MS = 30000;
    private static final int DEFAULT_REEVALUATE_DELAY_MS = 5000;
    private static final String DEFAULT_SERVER = "connectivitycheck.android.com";
    private static final int EVENT_APP_BYPASSED_CAPTIVE_PORTAL = 532491;
    private static final int EVENT_APP_INDICATES_SIGN_IN_IMPOSSIBLE = 532493;
    public static final int EVENT_NETWORK_LINGER_COMPLETE = 532485;
    public static final int EVENT_NETWORK_TESTED = 532482;
    private static final int EVENT_NO_APP_RESPONSE = 532492;
    public static final int EVENT_PROVISIONING_NOTIFICATION = 532490;
    public static final String EXTRA_BSSID = "extra_bssid";
    public static final String EXTRA_CELL_ID = "extra_cellid";
    public static final String EXTRA_CONNECTIVITY_TYPE = "extra_connectivity_type";
    public static final String EXTRA_IS_CAPTIVE_PORTAL = "extra_is_captive_portal";
    public static final String EXTRA_NETWORK_TYPE = "extra_network_type";
    public static final String EXTRA_REQUEST_TIMESTAMP_MS = "extra_request_timestamp_ms";
    public static final String EXTRA_RESPONSE_RECEIVED = "extra_response_received";
    public static final String EXTRA_RESPONSE_TIMESTAMP_MS = "extra_response_timestamp_ms";
    public static final String EXTRA_SSID = "extra_ssid";
    private static final int INITIAL_ATTEMPTS = 3;
    private static final int INVALID_UID = -1;
    private static final String LINGER_DELAY_PROPERTY = "persist.netmon.linger";
    private static final String LOGGED_IN_RESULT = "result";
    public static final int NETWORK_TEST_RESULT_INVALID = 1;
    public static final int NETWORK_TEST_RESULT_VALID = 0;
    private static final int PERIODIC_ATTEMPTS = 1;
    private static final String PERMISSION_ACCESS_NETWORK_CONDITIONS = "android.permission.ACCESS_NETWORK_CONDITIONS";
    private static final int REEVALUATE_ATTEMPTS = 1;
    private static final String REEVALUATE_DELAY_PROPERTY = "persist.netmon.reeval_delay";
    private static final int REEVALUATE_PAUSE_MS = 600000;
    private static final String RESPONSE_TOKEN = "response_token";
    private static final int SOCKET_TIMEOUT_MS = 10000;
    private static final String TAG = "NetworkMonitor";
    private final AlarmManager mAlarmManager;
    private CaptivePortalLoggedInBroadcastReceiver mCaptivePortalLoggedInBroadcastReceiver;
    private String mCaptivePortalLoggedInResponseToken;
    private final State mCaptivePortalState;
    private final Handler mConnectivityServiceHandler;
    private final Context mContext;
    private final NetworkRequest mDefaultRequest;
    private final State mDefaultState;
    private final State mEvaluatingState;
    private boolean mIsCaptivePortalCheckEnabled;
    private final int mLingerDelayMs;
    private int mLingerToken;
    private final State mLingeringState;
    private int mMaxAttempts;
    private final State mMaybeNotifyState;
    private final NetworkAgentInfo mNetworkAgentInfo;
    private final State mOfflineState;
    private final int mReevaluateDelayMs;
    private int mReevaluateToken;
    private String mServer;
    private final TelephonyManager mTelephonyManager;
    private int mUidResponsibleForReeval;
    private boolean mUserDoesNotWant;
    private final State mValidatedState;
    private final WifiManager mWifiManager;
    public boolean systemReady;

    private class CaptivePortalLoggedInBroadcastReceiver extends BroadcastReceiver {
        private CaptivePortalLoggedInBroadcastReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            if (Integer.parseInt(intent.getStringExtra("android.intent.extra.TEXT")) == NetworkMonitor.this.mNetworkAgentInfo.network.netId && NetworkMonitor.this.mCaptivePortalLoggedInResponseToken.equals(intent.getStringExtra(NetworkMonitor.RESPONSE_TOKEN))) {
                NetworkMonitor.this.sendMessage(NetworkMonitor.this.obtainMessage(NetworkMonitor.CMD_CAPTIVE_PORTAL_APP_FINISHED, Integer.parseInt(intent.getStringExtra(NetworkMonitor.LOGGED_IN_RESULT)), NetworkMonitor.NETWORK_TEST_RESULT_VALID));
            }
        }
    }

    private class CaptivePortalState extends State {
        private CaptivePortalState() {
        }

        public void enter() {
            NetworkMonitor.this.mConnectivityServiceHandler.sendMessage(NetworkMonitor.this.obtainMessage(NetworkMonitor.EVENT_NETWORK_TESTED, NetworkMonitor.REEVALUATE_ATTEMPTS, NetworkMonitor.NETWORK_TEST_RESULT_VALID, NetworkMonitor.this.mNetworkAgentInfo));
            Intent intent = new Intent("android.intent.action.SEND");
            intent.setData(Uri.fromParts("netid", Integer.toString(NetworkMonitor.this.mNetworkAgentInfo.network.netId), NetworkMonitor.this.mCaptivePortalLoggedInResponseToken));
            intent.setComponent(new ComponentName("com.android.captiveportallogin", "com.android.captiveportallogin.CaptivePortalLoginActivity"));
            intent.setFlags(272629760);
            if (NetworkMonitor.this.mCaptivePortalLoggedInBroadcastReceiver == null) {
                NetworkMonitor.this.mCaptivePortalLoggedInBroadcastReceiver = new CaptivePortalLoggedInBroadcastReceiver(null);
                NetworkMonitor.this.mContext.registerReceiver(NetworkMonitor.this.mCaptivePortalLoggedInBroadcastReceiver, new IntentFilter(NetworkMonitor.ACTION_CAPTIVE_PORTAL_LOGGED_IN));
            }
            NetworkMonitor.this.mConnectivityServiceHandler.sendMessage(NetworkMonitor.this.obtainMessage(NetworkMonitor.EVENT_PROVISIONING_NOTIFICATION, NetworkMonitor.REEVALUATE_ATTEMPTS, NetworkMonitor.this.mNetworkAgentInfo.network.netId, PendingIntent.getActivity(NetworkMonitor.this.mContext, NetworkMonitor.NETWORK_TEST_RESULT_VALID, intent, NetworkMonitor.NETWORK_TEST_RESULT_VALID)));
        }

        public boolean processMessage(Message message) {
            NetworkMonitor.this.log(getName() + message.toString());
            return false;
        }
    }

    private class CustomIntentReceiver extends BroadcastReceiver {
        private final String mAction;
        private final int mToken;
        private final int mWhat;

        CustomIntentReceiver(String action, int token, int what) {
            this.mToken = token;
            this.mWhat = what;
            this.mAction = action + "_" + NetworkMonitor.this.mNetworkAgentInfo.network.netId + "_" + token;
            NetworkMonitor.this.mContext.registerReceiver(this, new IntentFilter(this.mAction));
        }

        public PendingIntent getPendingIntent() {
            return PendingIntent.getBroadcast(NetworkMonitor.this.mContext, NetworkMonitor.NETWORK_TEST_RESULT_VALID, new Intent(this.mAction), NetworkMonitor.NETWORK_TEST_RESULT_VALID);
        }

        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals(this.mAction)) {
                NetworkMonitor.this.sendMessage(NetworkMonitor.this.obtainMessage(this.mWhat, this.mToken));
            }
        }
    }

    private class DefaultState extends State {
        private DefaultState() {
        }

        public boolean processMessage(Message message) {
            NetworkMonitor.this.log(getName() + message.toString());
            switch (message.what) {
                case NetworkMonitor.CMD_NETWORK_CONNECTED /*532481*/:
                    NetworkMonitor.this.log("Connected");
                    NetworkMonitor.this.mMaxAttempts = NetworkMonitor.INITIAL_ATTEMPTS;
                    NetworkMonitor.this.transitionTo(NetworkMonitor.this.mEvaluatingState);
                    break;
                case NetworkMonitor.CMD_NETWORK_LINGER /*532483*/:
                    NetworkMonitor.this.log("Lingering");
                    NetworkMonitor.this.transitionTo(NetworkMonitor.this.mLingeringState);
                    break;
                case NetworkMonitor.CMD_NETWORK_DISCONNECTED /*532487*/:
                    NetworkMonitor.this.log("Disconnected - quitting");
                    if (NetworkMonitor.this.mCaptivePortalLoggedInBroadcastReceiver != null) {
                        NetworkMonitor.this.mContext.unregisterReceiver(NetworkMonitor.this.mCaptivePortalLoggedInBroadcastReceiver);
                        NetworkMonitor.this.mCaptivePortalLoggedInBroadcastReceiver = null;
                    }
                    NetworkMonitor.this.quit();
                    break;
                case NetworkMonitor.CMD_FORCE_REEVALUATION /*532488*/:
                    int i;
                    NetworkMonitor.this.log("Forcing reevaluation");
                    NetworkMonitor.this.mUidResponsibleForReeval = message.arg1;
                    NetworkMonitor networkMonitor = NetworkMonitor.this;
                    if (message.arg2 != 0) {
                        i = message.arg2;
                    } else {
                        i = NetworkMonitor.REEVALUATE_ATTEMPTS;
                    }
                    networkMonitor.mMaxAttempts = i;
                    NetworkMonitor.this.transitionTo(NetworkMonitor.this.mEvaluatingState);
                    break;
                case NetworkMonitor.CMD_CAPTIVE_PORTAL_APP_FINISHED /*532489*/:
                    NetworkMonitor.this.mCaptivePortalLoggedInResponseToken = String.valueOf(new Random().nextLong());
                    switch (message.arg1) {
                        case NetworkMonitor.NETWORK_TEST_RESULT_VALID /*0*/:
                        case NetworkMonitor.CAPTIVE_PORTAL_APP_RETURN_WANTED_AS_IS /*2*/:
                            NetworkMonitor.this.transitionTo(NetworkMonitor.this.mValidatedState);
                            break;
                        case NetworkMonitor.REEVALUATE_ATTEMPTS /*1*/:
                            NetworkMonitor.this.mUserDoesNotWant = NetworkMonitor.DBG;
                            NetworkMonitor.this.transitionTo(NetworkMonitor.this.mOfflineState);
                            break;
                        default:
                            break;
                    }
            }
            return NetworkMonitor.DBG;
        }
    }

    private class EvaluatingState extends State {
        private int mAttempt;

        private EvaluatingState() {
        }

        public void enter() {
            this.mAttempt = NetworkMonitor.REEVALUATE_ATTEMPTS;
            NetworkMonitor.this.sendMessage(NetworkMonitor.CMD_REEVALUATE, NetworkMonitor.access$2704(NetworkMonitor.this), NetworkMonitor.NETWORK_TEST_RESULT_VALID);
            if (NetworkMonitor.this.mUidResponsibleForReeval != NetworkMonitor.INVALID_UID) {
                TrafficStats.setThreadStatsUid(NetworkMonitor.this.mUidResponsibleForReeval);
                NetworkMonitor.this.mUidResponsibleForReeval = NetworkMonitor.INVALID_UID;
            }
        }

        public boolean processMessage(Message message) {
            NetworkMonitor.this.log(getName() + message.toString());
            switch (message.what) {
                case NetworkMonitor.CMD_REEVALUATE /*532486*/:
                    if (message.arg1 != NetworkMonitor.this.mReevaluateToken) {
                        return NetworkMonitor.DBG;
                    }
                    if (NetworkMonitor.this.mDefaultRequest.networkCapabilities.satisfiedByNetworkCapabilities(NetworkMonitor.this.mNetworkAgentInfo.networkCapabilities)) {
                        int httpResponseCode = NetworkMonitor.this.isCaptivePortal();
                        if (httpResponseCode == 204) {
                            NetworkMonitor.this.transitionTo(NetworkMonitor.this.mValidatedState);
                            return NetworkMonitor.DBG;
                        } else if (httpResponseCode < 200 || httpResponseCode > 399) {
                            int i = this.mAttempt + NetworkMonitor.REEVALUATE_ATTEMPTS;
                            this.mAttempt = i;
                            if (i > NetworkMonitor.this.mMaxAttempts) {
                                NetworkMonitor.this.transitionTo(NetworkMonitor.this.mOfflineState);
                                return NetworkMonitor.DBG;
                            } else if (NetworkMonitor.this.mReevaluateDelayMs < 0) {
                                return NetworkMonitor.DBG;
                            } else {
                                NetworkMonitor.this.sendMessageDelayed(NetworkMonitor.this.obtainMessage(NetworkMonitor.CMD_REEVALUATE, NetworkMonitor.access$2704(NetworkMonitor.this), NetworkMonitor.NETWORK_TEST_RESULT_VALID), (long) NetworkMonitor.this.mReevaluateDelayMs);
                                return NetworkMonitor.DBG;
                            }
                        } else {
                            NetworkMonitor.this.transitionTo(NetworkMonitor.this.mCaptivePortalState);
                            return NetworkMonitor.DBG;
                        }
                    }
                    NetworkMonitor.this.transitionTo(NetworkMonitor.this.mValidatedState);
                    return NetworkMonitor.DBG;
                case NetworkMonitor.CMD_FORCE_REEVALUATION /*532488*/:
                    return NetworkMonitor.DBG;
                default:
                    return false;
            }
        }

        public void exit() {
            TrafficStats.clearThreadStatsUid();
        }
    }

    private class LingeringState extends State {
        private static final String ACTION_LINGER_EXPIRED = "android.net.netmon.lingerExpired";
        private CustomIntentReceiver mBroadcastReceiver;
        private PendingIntent mIntent;

        private LingeringState() {
        }

        public void enter() {
            NetworkMonitor.this.mLingerToken = new Random().nextInt();
            this.mBroadcastReceiver = new CustomIntentReceiver(ACTION_LINGER_EXPIRED, NetworkMonitor.this.mLingerToken, NetworkMonitor.CMD_LINGER_EXPIRED);
            this.mIntent = this.mBroadcastReceiver.getPendingIntent();
            NetworkMonitor.this.mAlarmManager.setWindow(NetworkMonitor.CAPTIVE_PORTAL_APP_RETURN_WANTED_AS_IS, SystemClock.elapsedRealtime() + ((long) NetworkMonitor.this.mLingerDelayMs), (long) (NetworkMonitor.this.mLingerDelayMs / 6), this.mIntent);
        }

        public boolean processMessage(Message message) {
            NetworkMonitor.this.log(getName() + message.toString());
            switch (message.what) {
                case NetworkMonitor.CMD_NETWORK_CONNECTED /*532481*/:
                    NetworkMonitor.this.transitionTo(NetworkMonitor.this.mValidatedState);
                    return NetworkMonitor.DBG;
                case NetworkMonitor.CMD_LINGER_EXPIRED /*532484*/:
                    if (message.arg1 != NetworkMonitor.this.mLingerToken) {
                        return NetworkMonitor.DBG;
                    }
                    NetworkMonitor.this.mConnectivityServiceHandler.sendMessage(NetworkMonitor.this.obtainMessage(NetworkMonitor.EVENT_NETWORK_LINGER_COMPLETE, NetworkMonitor.this.mNetworkAgentInfo));
                    return NetworkMonitor.DBG;
                case NetworkMonitor.CMD_FORCE_REEVALUATION /*532488*/:
                case NetworkMonitor.CMD_CAPTIVE_PORTAL_APP_FINISHED /*532489*/:
                    return NetworkMonitor.DBG;
                default:
                    return false;
            }
        }

        public void exit() {
            NetworkMonitor.this.mAlarmManager.cancel(this.mIntent);
            NetworkMonitor.this.mContext.unregisterReceiver(this.mBroadcastReceiver);
        }
    }

    private class MaybeNotifyState extends State {
        private MaybeNotifyState() {
        }

        public void exit() {
            NetworkMonitor.this.mConnectivityServiceHandler.sendMessage(NetworkMonitor.this.obtainMessage(NetworkMonitor.EVENT_PROVISIONING_NOTIFICATION, NetworkMonitor.NETWORK_TEST_RESULT_VALID, NetworkMonitor.this.mNetworkAgentInfo.network.netId, null));
        }
    }

    private class OfflineState extends State {
        private OfflineState() {
        }

        public void enter() {
            NetworkMonitor.this.mConnectivityServiceHandler.sendMessage(NetworkMonitor.this.obtainMessage(NetworkMonitor.EVENT_NETWORK_TESTED, NetworkMonitor.REEVALUATE_ATTEMPTS, NetworkMonitor.NETWORK_TEST_RESULT_VALID, NetworkMonitor.this.mNetworkAgentInfo));
            if (!NetworkMonitor.this.mUserDoesNotWant) {
                NetworkMonitor.this.sendMessageDelayed(NetworkMonitor.CMD_FORCE_REEVALUATION, NetworkMonitor.NETWORK_TEST_RESULT_VALID, NetworkMonitor.REEVALUATE_ATTEMPTS, LocationFudger.FASTEST_INTERVAL_MS);
            }
        }

        public boolean processMessage(Message message) {
            NetworkMonitor.this.log(getName() + message.toString());
            switch (message.what) {
                case NetworkMonitor.CMD_FORCE_REEVALUATION /*532488*/:
                    if (NetworkMonitor.this.mUserDoesNotWant) {
                        return NetworkMonitor.DBG;
                    }
                    return false;
                default:
                    return false;
            }
        }

        public void exit() {
            NetworkMonitor.this.removeMessages(NetworkMonitor.CMD_FORCE_REEVALUATION);
        }
    }

    private class ValidatedState extends State {
        private ValidatedState() {
        }

        public void enter() {
            NetworkMonitor.this.log("Validated");
            NetworkMonitor.this.mConnectivityServiceHandler.sendMessage(NetworkMonitor.this.obtainMessage(NetworkMonitor.EVENT_NETWORK_TESTED, NetworkMonitor.NETWORK_TEST_RESULT_VALID, NetworkMonitor.NETWORK_TEST_RESULT_VALID, NetworkMonitor.this.mNetworkAgentInfo));
        }

        public boolean processMessage(Message message) {
            NetworkMonitor.this.log(getName() + message.toString());
            switch (message.what) {
                case NetworkMonitor.CMD_NETWORK_CONNECTED /*532481*/:
                    NetworkMonitor.this.transitionTo(NetworkMonitor.this.mValidatedState);
                    return NetworkMonitor.DBG;
                default:
                    return false;
            }
        }
    }

    static /* synthetic */ int access$2704(NetworkMonitor x0) {
        int i = x0.mReevaluateToken + REEVALUATE_ATTEMPTS;
        x0.mReevaluateToken = i;
        return i;
    }

    public NetworkMonitor(Context context, Handler handler, NetworkAgentInfo networkAgentInfo, NetworkRequest defaultRequest) {
        super(TAG + networkAgentInfo.name());
        this.mLingerToken = NETWORK_TEST_RESULT_VALID;
        this.mReevaluateToken = NETWORK_TEST_RESULT_VALID;
        this.mUidResponsibleForReeval = INVALID_UID;
        this.mIsCaptivePortalCheckEnabled = false;
        this.mUserDoesNotWant = false;
        this.systemReady = false;
        this.mDefaultState = new DefaultState();
        this.mOfflineState = new OfflineState();
        this.mValidatedState = new ValidatedState();
        this.mMaybeNotifyState = new MaybeNotifyState();
        this.mEvaluatingState = new EvaluatingState();
        this.mCaptivePortalState = new CaptivePortalState();
        this.mLingeringState = new LingeringState();
        this.mCaptivePortalLoggedInBroadcastReceiver = null;
        this.mCaptivePortalLoggedInResponseToken = null;
        this.mContext = context;
        this.mConnectivityServiceHandler = handler;
        this.mNetworkAgentInfo = networkAgentInfo;
        this.mTelephonyManager = (TelephonyManager) context.getSystemService("phone");
        this.mWifiManager = (WifiManager) context.getSystemService("wifi");
        this.mAlarmManager = (AlarmManager) context.getSystemService("alarm");
        this.mDefaultRequest = defaultRequest;
        addState(this.mDefaultState);
        addState(this.mOfflineState, this.mDefaultState);
        addState(this.mValidatedState, this.mDefaultState);
        addState(this.mMaybeNotifyState, this.mDefaultState);
        addState(this.mEvaluatingState, this.mMaybeNotifyState);
        addState(this.mCaptivePortalState, this.mMaybeNotifyState);
        addState(this.mLingeringState, this.mDefaultState);
        setInitialState(this.mDefaultState);
        this.mServer = Global.getString(this.mContext.getContentResolver(), "captive_portal_server");
        if (this.mServer == null) {
            this.mServer = DEFAULT_SERVER;
        }
        this.mLingerDelayMs = SystemProperties.getInt(LINGER_DELAY_PROPERTY, DEFAULT_LINGER_DELAY_MS);
        this.mReevaluateDelayMs = SystemProperties.getInt(REEVALUATE_DELAY_PROPERTY, DEFAULT_REEVALUATE_DELAY_MS);
        this.mIsCaptivePortalCheckEnabled = Global.getInt(this.mContext.getContentResolver(), "captive_portal_detection_enabled", REEVALUATE_ATTEMPTS) == REEVALUATE_ATTEMPTS ? DBG : false;
        this.mCaptivePortalLoggedInResponseToken = String.valueOf(new Random().nextLong());
        start();
    }

    protected void log(String s) {
        Log.d("NetworkMonitor/" + this.mNetworkAgentInfo.name(), s);
    }

    private int isCaptivePortal() {
        if (!this.mIsCaptivePortalCheckEnabled) {
            return 204;
        }
        HttpURLConnection urlConnection = null;
        try {
            URL url = new URL("http", this.mServer, "/generate_204");
            boolean fetchPac = false;
            ProxyInfo proxyInfo = this.mNetworkAgentInfo.linkProperties.getHttpProxy();
            if (!(proxyInfo == null || Uri.EMPTY.equals(proxyInfo.getPacFileUrl()))) {
                url = new URL(proxyInfo.getPacFileUrl().toString());
                fetchPac = DBG;
            }
            log("Checking " + url.toString() + " on " + this.mNetworkAgentInfo.networkInfo.getExtraInfo());
            urlConnection = (HttpURLConnection) this.mNetworkAgentInfo.network.openConnection(url);
            urlConnection.setInstanceFollowRedirects(fetchPac);
            urlConnection.setConnectTimeout(SOCKET_TIMEOUT_MS);
            urlConnection.setReadTimeout(SOCKET_TIMEOUT_MS);
            urlConnection.setUseCaches(false);
            long requestTimestamp = SystemClock.elapsedRealtime();
            urlConnection.getInputStream();
            long responseTimestamp = SystemClock.elapsedRealtime();
            int httpResponseCode = urlConnection.getResponseCode();
            log("isCaptivePortal: ret=" + httpResponseCode + " headers=" + urlConnection.getHeaderFields());
            if (httpResponseCode == 200 && urlConnection.getContentLength() == 0) {
                log("Empty 200 response interpreted as 204 response.");
                httpResponseCode = 204;
            }
            if (httpResponseCode == 200 && fetchPac) {
                log("PAC fetch 200 response interpreted as 204 response.");
                httpResponseCode = 204;
            }
            sendNetworkConditionsBroadcast(DBG, httpResponseCode != 204 ? DBG : false, requestTimestamp, responseTimestamp);
            if (urlConnection == null) {
                return httpResponseCode;
            }
            urlConnection.disconnect();
            return httpResponseCode;
        } catch (IOException e) {
            log("Probably not a portal: exception " + e);
            if (599 == 599) {
                if (urlConnection != null) {
                    return 599;
                }
                urlConnection.disconnect();
                return 599;
            } else if (urlConnection != null) {
                return 599;
            } else {
                urlConnection.disconnect();
                return 599;
            }
        } catch (Throwable th) {
            if (urlConnection != null) {
                urlConnection.disconnect();
            }
        }
    }

    private void sendNetworkConditionsBroadcast(boolean responseReceived, boolean isCaptivePortal, long requestTimestampMs, long responseTimestampMs) {
        if (Global.getInt(this.mContext.getContentResolver(), "wifi_scan_always_enabled", NETWORK_TEST_RESULT_VALID) == 0) {
            log("Don't send network conditions - lacking user consent.");
        } else if (this.systemReady) {
            Intent latencyBroadcast = new Intent(ACTION_NETWORK_CONDITIONS_MEASURED);
            switch (this.mNetworkAgentInfo.networkInfo.getType()) {
                case NETWORK_TEST_RESULT_VALID /*0*/:
                    latencyBroadcast.putExtra(EXTRA_NETWORK_TYPE, this.mTelephonyManager.getNetworkType());
                    List<CellInfo> info = this.mTelephonyManager.getAllCellInfo();
                    if (info != null) {
                        int numRegisteredCellInfo = NETWORK_TEST_RESULT_VALID;
                        for (CellInfo cellInfo : info) {
                            if (cellInfo.isRegistered()) {
                                numRegisteredCellInfo += REEVALUATE_ATTEMPTS;
                                if (numRegisteredCellInfo > REEVALUATE_ATTEMPTS) {
                                    log("more than one registered CellInfo.  Can't tell which is active.  Bailing.");
                                    return;
                                } else if (cellInfo instanceof CellInfoCdma) {
                                    latencyBroadcast.putExtra(EXTRA_CELL_ID, ((CellInfoCdma) cellInfo).getCellIdentity());
                                } else if (cellInfo instanceof CellInfoGsm) {
                                    latencyBroadcast.putExtra(EXTRA_CELL_ID, ((CellInfoGsm) cellInfo).getCellIdentity());
                                } else if (cellInfo instanceof CellInfoLte) {
                                    latencyBroadcast.putExtra(EXTRA_CELL_ID, ((CellInfoLte) cellInfo).getCellIdentity());
                                } else if (cellInfo instanceof CellInfoWcdma) {
                                    latencyBroadcast.putExtra(EXTRA_CELL_ID, ((CellInfoWcdma) cellInfo).getCellIdentity());
                                } else {
                                    logw("Registered cellinfo is unrecognized");
                                    return;
                                }
                            }
                        }
                        break;
                    }
                    return;
                case REEVALUATE_ATTEMPTS /*1*/:
                    WifiInfo currentWifiInfo = this.mWifiManager.getConnectionInfo();
                    if (currentWifiInfo != null) {
                        latencyBroadcast.putExtra(EXTRA_SSID, currentWifiInfo.getSSID());
                        latencyBroadcast.putExtra(EXTRA_BSSID, currentWifiInfo.getBSSID());
                        break;
                    }
                    logw("network info is TYPE_WIFI but no ConnectionInfo found");
                    return;
                default:
                    return;
            }
            latencyBroadcast.putExtra(EXTRA_CONNECTIVITY_TYPE, this.mNetworkAgentInfo.networkInfo.getType());
            latencyBroadcast.putExtra(EXTRA_RESPONSE_RECEIVED, responseReceived);
            latencyBroadcast.putExtra(EXTRA_REQUEST_TIMESTAMP_MS, requestTimestampMs);
            if (responseReceived) {
                latencyBroadcast.putExtra(EXTRA_IS_CAPTIVE_PORTAL, isCaptivePortal);
                latencyBroadcast.putExtra(EXTRA_RESPONSE_TIMESTAMP_MS, responseTimestampMs);
            }
            this.mContext.sendBroadcastAsUser(latencyBroadcast, UserHandle.CURRENT, PERMISSION_ACCESS_NETWORK_CONDITIONS);
        }
    }
}
