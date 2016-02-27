package com.android.server.display;

import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.ContentObserver;
import android.hardware.display.WifiDisplay;
import android.hardware.display.WifiDisplaySessionInfo;
import android.media.RemoteDisplay;
import android.net.NetworkInfo;
import android.net.Uri;
import android.net.wifi.WpsInfo;
import android.net.wifi.p2p.WifiP2pConfig;
import android.net.wifi.p2p.WifiP2pDevice;
import android.net.wifi.p2p.WifiP2pDeviceList;
import android.net.wifi.p2p.WifiP2pGroup;
import android.net.wifi.p2p.WifiP2pManager;
import android.net.wifi.p2p.WifiP2pManager.ActionListener;
import android.net.wifi.p2p.WifiP2pManager.Channel;
import android.net.wifi.p2p.WifiP2pManager.GroupInfoListener;
import android.net.wifi.p2p.WifiP2pManager.PeerListListener;
import android.net.wifi.p2p.WifiP2pWfdInfo;
import android.os.Handler;
import android.provider.Settings.Global;
import android.util.Slog;
import android.view.Surface;
import com.android.internal.util.DumpUtils.Dump;
import java.io.PrintWriter;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import libcore.util.Objects;

final class WifiDisplayController implements Dump {
    private static final int CONNECTION_TIMEOUT_SECONDS = 30;
    private static final int CONNECT_MAX_RETRIES = 3;
    private static final int CONNECT_RETRY_DELAY_MILLIS = 500;
    private static final boolean DEBUG = false;
    private static final int DEFAULT_CONTROL_PORT = 7236;
    private static final int DISCOVER_PEERS_INTERVAL_MILLIS = 10000;
    private static final int MAX_THROUGHPUT = 50;
    private static final int RTSP_TIMEOUT_SECONDS = 30;
    private static final int RTSP_TIMEOUT_SECONDS_CERT_MODE = 120;
    private static final String TAG = "WifiDisplayController";
    private WifiDisplay mAdvertisedDisplay;
    private int mAdvertisedDisplayFlags;
    private int mAdvertisedDisplayHeight;
    private Surface mAdvertisedDisplaySurface;
    private int mAdvertisedDisplayWidth;
    private final ArrayList<WifiP2pDevice> mAvailableWifiDisplayPeers;
    private WifiP2pDevice mCancelingDevice;
    private WifiP2pDevice mConnectedDevice;
    private WifiP2pGroup mConnectedDeviceGroupInfo;
    private WifiP2pDevice mConnectingDevice;
    private int mConnectionRetriesLeft;
    private final Runnable mConnectionTimeout;
    private final Context mContext;
    private WifiP2pDevice mDesiredDevice;
    private WifiP2pDevice mDisconnectingDevice;
    private final Runnable mDiscoverPeers;
    private boolean mDiscoverPeersInProgress;
    private Object mExtRemoteDisplay;
    private final Handler mHandler;
    private final Listener mListener;
    private NetworkInfo mNetworkInfo;
    private RemoteDisplay mRemoteDisplay;
    private boolean mRemoteDisplayConnected;
    private String mRemoteDisplayInterface;
    private final Runnable mRtspTimeout;
    private boolean mScanRequested;
    private WifiP2pDevice mThisDevice;
    private boolean mWfdEnabled;
    private boolean mWfdEnabling;
    private boolean mWifiDisplayCertMode;
    private boolean mWifiDisplayOnSetting;
    private int mWifiDisplayWpsConfig;
    private final Channel mWifiP2pChannel;
    private boolean mWifiP2pEnabled;
    private final WifiP2pManager mWifiP2pManager;
    private final BroadcastReceiver mWifiP2pReceiver;

    public interface Listener {
        void onDisplayChanged(WifiDisplay wifiDisplay);

        void onDisplayConnected(WifiDisplay wifiDisplay, Surface surface, int i, int i2, int i3);

        void onDisplayConnecting(WifiDisplay wifiDisplay);

        void onDisplayConnectionFailed();

        void onDisplayDisconnected();

        void onDisplaySessionInfo(WifiDisplaySessionInfo wifiDisplaySessionInfo);

        void onFeatureStateChanged(int i);

        void onScanFinished();

        void onScanResults(WifiDisplay[] wifiDisplayArr);

        void onScanStarted();
    }

    /* renamed from: com.android.server.display.WifiDisplayController.11 */
    class AnonymousClass11 implements ActionListener {
        final /* synthetic */ WifiP2pDevice val$oldDevice;

        AnonymousClass11(WifiP2pDevice wifiP2pDevice) {
            this.val$oldDevice = wifiP2pDevice;
        }

        public void onSuccess() {
            Slog.i(WifiDisplayController.TAG, "Disconnected from Wifi display: " + this.val$oldDevice.deviceName);
            next();
        }

        public void onFailure(int reason) {
            Slog.i(WifiDisplayController.TAG, "Failed to disconnect from Wifi display: " + this.val$oldDevice.deviceName + ", reason=" + reason);
            next();
        }

        private void next() {
            if (WifiDisplayController.this.mDisconnectingDevice == this.val$oldDevice) {
                WifiDisplayController.this.mDisconnectingDevice = null;
                WifiDisplayController.this.updateConnection();
            }
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.12 */
    class AnonymousClass12 implements ActionListener {
        final /* synthetic */ WifiP2pDevice val$oldDevice;

        AnonymousClass12(WifiP2pDevice wifiP2pDevice) {
            this.val$oldDevice = wifiP2pDevice;
        }

        public void onSuccess() {
            Slog.i(WifiDisplayController.TAG, "Canceled connection to Wifi display: " + this.val$oldDevice.deviceName);
            next();
        }

        public void onFailure(int reason) {
            Slog.i(WifiDisplayController.TAG, "Failed to cancel connection to Wifi display: " + this.val$oldDevice.deviceName + ", reason=" + reason);
            next();
        }

        private void next() {
            if (WifiDisplayController.this.mCancelingDevice == this.val$oldDevice) {
                WifiDisplayController.this.mCancelingDevice = null;
                WifiDisplayController.this.updateConnection();
            }
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.13 */
    class AnonymousClass13 implements ActionListener {
        final /* synthetic */ WifiP2pDevice val$newDevice;

        AnonymousClass13(WifiP2pDevice wifiP2pDevice) {
            this.val$newDevice = wifiP2pDevice;
        }

        public void onSuccess() {
            Slog.i(WifiDisplayController.TAG, "Initiated connection to Wifi display: " + this.val$newDevice.deviceName);
            WifiDisplayController.this.mHandler.postDelayed(WifiDisplayController.this.mConnectionTimeout, 30000);
        }

        public void onFailure(int reason) {
            if (WifiDisplayController.this.mConnectingDevice == this.val$newDevice) {
                Slog.i(WifiDisplayController.TAG, "Failed to initiate connection to Wifi display: " + this.val$newDevice.deviceName + ", reason=" + reason);
                WifiDisplayController.this.mConnectingDevice = null;
                WifiDisplayController.this.handleConnectionFailure(WifiDisplayController.DEBUG);
            }
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.14 */
    class AnonymousClass14 implements android.media.RemoteDisplay.Listener {
        final /* synthetic */ WifiP2pDevice val$oldDevice;

        AnonymousClass14(WifiP2pDevice wifiP2pDevice) {
            this.val$oldDevice = wifiP2pDevice;
        }

        public void onDisplayConnected(Surface surface, int width, int height, int flags, int session) {
            if (WifiDisplayController.this.mConnectedDevice == this.val$oldDevice && !WifiDisplayController.this.mRemoteDisplayConnected) {
                Slog.i(WifiDisplayController.TAG, "Opened RTSP connection with Wifi display: " + WifiDisplayController.this.mConnectedDevice.deviceName);
                WifiDisplayController.this.mRemoteDisplayConnected = true;
                WifiDisplayController.this.mHandler.removeCallbacks(WifiDisplayController.this.mRtspTimeout);
                if (WifiDisplayController.this.mWifiDisplayCertMode) {
                    WifiDisplayController.this.mListener.onDisplaySessionInfo(WifiDisplayController.this.getSessionInfo(WifiDisplayController.this.mConnectedDeviceGroupInfo, session));
                }
                WifiDisplayController.this.advertiseDisplay(WifiDisplayController.createWifiDisplay(WifiDisplayController.this.mConnectedDevice), surface, width, height, flags);
            }
        }

        public void onDisplayDisconnected() {
            if (WifiDisplayController.this.mConnectedDevice == this.val$oldDevice) {
                Slog.i(WifiDisplayController.TAG, "Closed RTSP connection with Wifi display: " + WifiDisplayController.this.mConnectedDevice.deviceName);
                WifiDisplayController.this.mHandler.removeCallbacks(WifiDisplayController.this.mRtspTimeout);
                WifiDisplayController.this.disconnect();
            }
        }

        public void onDisplayError(int error) {
            if (WifiDisplayController.this.mConnectedDevice == this.val$oldDevice) {
                Slog.i(WifiDisplayController.TAG, "Lost RTSP connection with Wifi display due to error " + error + ": " + WifiDisplayController.this.mConnectedDevice.deviceName);
                WifiDisplayController.this.mHandler.removeCallbacks(WifiDisplayController.this.mRtspTimeout);
                WifiDisplayController.this.handleConnectionFailure(WifiDisplayController.DEBUG);
            }
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.19 */
    class AnonymousClass19 implements Runnable {
        final /* synthetic */ WifiP2pDevice val$oldDevice;

        AnonymousClass19(WifiP2pDevice wifiP2pDevice) {
            this.val$oldDevice = wifiP2pDevice;
        }

        public void run() {
            if (WifiDisplayController.this.mDesiredDevice == this.val$oldDevice && WifiDisplayController.this.mConnectionRetriesLeft > 0) {
                WifiDisplayController.access$3320(WifiDisplayController.this, 1);
                Slog.i(WifiDisplayController.TAG, "Retrying Wifi display connection.  Retries left: " + WifiDisplayController.this.mConnectionRetriesLeft);
                WifiDisplayController.this.retryConnection();
            }
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.1 */
    class C02291 extends ContentObserver {
        C02291(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange, Uri uri) {
            WifiDisplayController.this.updateSettings();
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.20 */
    class AnonymousClass20 implements Runnable {
        final /* synthetic */ WifiDisplay val$display;
        final /* synthetic */ int val$flags;
        final /* synthetic */ int val$height;
        final /* synthetic */ WifiDisplay val$oldDisplay;
        final /* synthetic */ Surface val$oldSurface;
        final /* synthetic */ Surface val$surface;
        final /* synthetic */ int val$width;

        AnonymousClass20(Surface surface, Surface surface2, WifiDisplay wifiDisplay, WifiDisplay wifiDisplay2, int i, int i2, int i3) {
            this.val$oldSurface = surface;
            this.val$surface = surface2;
            this.val$oldDisplay = wifiDisplay;
            this.val$display = wifiDisplay2;
            this.val$width = i;
            this.val$height = i2;
            this.val$flags = i3;
        }

        public void run() {
            if (this.val$oldSurface != null && this.val$surface != this.val$oldSurface) {
                WifiDisplayController.this.mListener.onDisplayDisconnected();
            } else if (!(this.val$oldDisplay == null || this.val$oldDisplay.hasSameAddress(this.val$display))) {
                WifiDisplayController.this.mListener.onDisplayConnectionFailed();
            }
            if (this.val$display != null) {
                if (!this.val$display.hasSameAddress(this.val$oldDisplay)) {
                    WifiDisplayController.this.mListener.onDisplayConnecting(this.val$display);
                } else if (!this.val$display.equals(this.val$oldDisplay)) {
                    WifiDisplayController.this.mListener.onDisplayChanged(this.val$display);
                }
                if (this.val$surface != null && this.val$surface != this.val$oldSurface) {
                    WifiDisplayController.this.mListener.onDisplayConnected(this.val$display, this.val$surface, this.val$width, this.val$height, this.val$flags);
                }
            }
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.2 */
    class C02302 implements ActionListener {
        C02302() {
        }

        public void onSuccess() {
            if (WifiDisplayController.this.mWfdEnabling) {
                WifiDisplayController.this.mWfdEnabling = WifiDisplayController.DEBUG;
                WifiDisplayController.this.mWfdEnabled = true;
                WifiDisplayController.this.reportFeatureState();
                WifiDisplayController.this.updateScanState();
            }
        }

        public void onFailure(int reason) {
            WifiDisplayController.this.mWfdEnabling = WifiDisplayController.DEBUG;
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.3 */
    class C02313 implements ActionListener {
        C02313() {
        }

        public void onSuccess() {
        }

        public void onFailure(int reason) {
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.4 */
    class C02324 implements Runnable {
        final /* synthetic */ int val$featureState;

        C02324(int i) {
            this.val$featureState = i;
        }

        public void run() {
            WifiDisplayController.this.mListener.onFeatureStateChanged(this.val$featureState);
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.5 */
    class C02335 implements ActionListener {
        C02335() {
        }

        public void onSuccess() {
            if (WifiDisplayController.this.mDiscoverPeersInProgress) {
                WifiDisplayController.this.requestPeers();
            }
        }

        public void onFailure(int reason) {
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.6 */
    class C02346 implements ActionListener {
        C02346() {
        }

        public void onSuccess() {
        }

        public void onFailure(int reason) {
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.7 */
    class C02357 implements PeerListListener {
        C02357() {
        }

        public void onPeersAvailable(WifiP2pDeviceList peers) {
            WifiDisplayController.this.mAvailableWifiDisplayPeers.clear();
            for (WifiP2pDevice device : peers.getDeviceList()) {
                if (WifiDisplayController.isWifiDisplay(device)) {
                    WifiDisplayController.this.mAvailableWifiDisplayPeers.add(device);
                }
            }
            if (WifiDisplayController.this.mDiscoverPeersInProgress) {
                WifiDisplayController.this.handleScanResults();
            }
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.8 */
    class C02368 implements Runnable {
        C02368() {
        }

        public void run() {
            WifiDisplayController.this.mListener.onScanStarted();
        }
    }

    /* renamed from: com.android.server.display.WifiDisplayController.9 */
    class C02379 implements Runnable {
        final /* synthetic */ WifiDisplay[] val$displays;

        C02379(WifiDisplay[] wifiDisplayArr) {
            this.val$displays = wifiDisplayArr;
        }

        public void run() {
            WifiDisplayController.this.mListener.onScanResults(this.val$displays);
        }
    }

    static /* synthetic */ int access$3320(WifiDisplayController x0, int x1) {
        int i = x0.mConnectionRetriesLeft - x1;
        x0.mConnectionRetriesLeft = i;
        return i;
    }

    public WifiDisplayController(Context context, Handler handler, Listener listener) {
        this.mAvailableWifiDisplayPeers = new ArrayList();
        this.mWifiDisplayWpsConfig = 4;
        this.mDiscoverPeers = new Runnable() {
            public void run() {
                WifiDisplayController.this.tryDiscoverPeers();
            }
        };
        this.mConnectionTimeout = new Runnable() {
            public void run() {
                if (WifiDisplayController.this.mConnectingDevice != null && WifiDisplayController.this.mConnectingDevice == WifiDisplayController.this.mDesiredDevice) {
                    Slog.i(WifiDisplayController.TAG, "Timed out waiting for Wifi display connection after 30 seconds: " + WifiDisplayController.this.mConnectingDevice.deviceName);
                    WifiDisplayController.this.handleConnectionFailure(true);
                }
            }
        };
        this.mRtspTimeout = new Runnable() {
            public void run() {
                if (WifiDisplayController.this.mConnectedDevice == null) {
                    return;
                }
                if ((WifiDisplayController.this.mRemoteDisplay != null || WifiDisplayController.this.mExtRemoteDisplay != null) && !WifiDisplayController.this.mRemoteDisplayConnected) {
                    Slog.i(WifiDisplayController.TAG, "Timed out waiting for Wifi display RTSP connection after 30 seconds: " + WifiDisplayController.this.mConnectedDevice.deviceName);
                    WifiDisplayController.this.handleConnectionFailure(true);
                }
            }
        };
        this.mWifiP2pReceiver = new BroadcastReceiver() {
            public void onReceive(Context context, Intent intent) {
                boolean enabled = true;
                String action = intent.getAction();
                if (action.equals("android.net.wifi.p2p.STATE_CHANGED")) {
                    if (intent.getIntExtra("wifi_p2p_state", 1) != 2) {
                        enabled = WifiDisplayController.DEBUG;
                    }
                    WifiDisplayController.this.handleStateChanged(enabled);
                } else if (action.equals("android.net.wifi.p2p.PEERS_CHANGED")) {
                    WifiDisplayController.this.handlePeersChanged();
                } else if (action.equals("android.net.wifi.p2p.CONNECTION_STATE_CHANGE")) {
                    WifiDisplayController.this.handleConnectionChanged((NetworkInfo) intent.getParcelableExtra("networkInfo"));
                } else if (action.equals("android.net.wifi.p2p.THIS_DEVICE_CHANGED")) {
                    WifiDisplayController.this.mThisDevice = (WifiP2pDevice) intent.getParcelableExtra("wifiP2pDevice");
                }
            }
        };
        this.mContext = context;
        this.mHandler = handler;
        this.mListener = listener;
        this.mWifiP2pManager = (WifiP2pManager) context.getSystemService("wifip2p");
        this.mWifiP2pChannel = this.mWifiP2pManager.initialize(context, handler.getLooper(), null);
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.net.wifi.p2p.STATE_CHANGED");
        intentFilter.addAction("android.net.wifi.p2p.PEERS_CHANGED");
        intentFilter.addAction("android.net.wifi.p2p.CONNECTION_STATE_CHANGE");
        intentFilter.addAction("android.net.wifi.p2p.THIS_DEVICE_CHANGED");
        context.registerReceiver(this.mWifiP2pReceiver, intentFilter, null, this.mHandler);
        ContentObserver settingsObserver = new C02291(this.mHandler);
        ContentResolver resolver = this.mContext.getContentResolver();
        resolver.registerContentObserver(Global.getUriFor("wifi_display_on"), DEBUG, settingsObserver);
        resolver.registerContentObserver(Global.getUriFor("wifi_display_certification_on"), DEBUG, settingsObserver);
        resolver.registerContentObserver(Global.getUriFor("wifi_display_wps_config"), DEBUG, settingsObserver);
        updateSettings();
    }

    private void updateSettings() {
        boolean z = true;
        ContentResolver resolver = this.mContext.getContentResolver();
        this.mWifiDisplayOnSetting = Global.getInt(resolver, "wifi_display_on", 0) != 0 ? true : DEBUG;
        if (Global.getInt(resolver, "wifi_display_certification_on", 0) == 0) {
            z = DEBUG;
        }
        this.mWifiDisplayCertMode = z;
        this.mWifiDisplayWpsConfig = 4;
        if (this.mWifiDisplayCertMode) {
            this.mWifiDisplayWpsConfig = Global.getInt(resolver, "wifi_display_wps_config", 4);
        }
        updateWfdEnableState();
    }

    public void dump(PrintWriter pw) {
        pw.println("mWifiDisplayOnSetting=" + this.mWifiDisplayOnSetting);
        pw.println("mWifiP2pEnabled=" + this.mWifiP2pEnabled);
        pw.println("mWfdEnabled=" + this.mWfdEnabled);
        pw.println("mWfdEnabling=" + this.mWfdEnabling);
        pw.println("mNetworkInfo=" + this.mNetworkInfo);
        pw.println("mScanRequested=" + this.mScanRequested);
        pw.println("mDiscoverPeersInProgress=" + this.mDiscoverPeersInProgress);
        pw.println("mDesiredDevice=" + describeWifiP2pDevice(this.mDesiredDevice));
        pw.println("mConnectingDisplay=" + describeWifiP2pDevice(this.mConnectingDevice));
        pw.println("mDisconnectingDisplay=" + describeWifiP2pDevice(this.mDisconnectingDevice));
        pw.println("mCancelingDisplay=" + describeWifiP2pDevice(this.mCancelingDevice));
        pw.println("mConnectedDevice=" + describeWifiP2pDevice(this.mConnectedDevice));
        pw.println("mConnectionRetriesLeft=" + this.mConnectionRetriesLeft);
        pw.println("mRemoteDisplay=" + this.mRemoteDisplay);
        pw.println("mRemoteDisplayInterface=" + this.mRemoteDisplayInterface);
        pw.println("mRemoteDisplayConnected=" + this.mRemoteDisplayConnected);
        pw.println("mAdvertisedDisplay=" + this.mAdvertisedDisplay);
        pw.println("mAdvertisedDisplaySurface=" + this.mAdvertisedDisplaySurface);
        pw.println("mAdvertisedDisplayWidth=" + this.mAdvertisedDisplayWidth);
        pw.println("mAdvertisedDisplayHeight=" + this.mAdvertisedDisplayHeight);
        pw.println("mAdvertisedDisplayFlags=" + this.mAdvertisedDisplayFlags);
        pw.println("mAvailableWifiDisplayPeers: size=" + this.mAvailableWifiDisplayPeers.size());
        Iterator i$ = this.mAvailableWifiDisplayPeers.iterator();
        while (i$.hasNext()) {
            pw.println("  " + describeWifiP2pDevice((WifiP2pDevice) i$.next()));
        }
    }

    public void requestStartScan() {
        if (!this.mScanRequested) {
            this.mScanRequested = true;
            updateScanState();
        }
    }

    public void requestStopScan() {
        if (this.mScanRequested) {
            this.mScanRequested = DEBUG;
            updateScanState();
        }
    }

    public void requestConnect(String address) {
        Iterator i$ = this.mAvailableWifiDisplayPeers.iterator();
        while (i$.hasNext()) {
            WifiP2pDevice device = (WifiP2pDevice) i$.next();
            if (device.deviceAddress.equals(address)) {
                connect(device);
            }
        }
    }

    public void requestPause() {
        if (this.mRemoteDisplay != null) {
            this.mRemoteDisplay.pause();
        }
    }

    public void requestResume() {
        if (this.mRemoteDisplay != null) {
            this.mRemoteDisplay.resume();
        }
    }

    public void requestDisconnect() {
        disconnect();
    }

    private void updateWfdEnableState() {
        WifiP2pWfdInfo wfdInfo;
        if (!this.mWifiDisplayOnSetting || !this.mWifiP2pEnabled) {
            if (this.mWfdEnabled || this.mWfdEnabling) {
                wfdInfo = new WifiP2pWfdInfo();
                wfdInfo.setWfdEnabled(DEBUG);
                this.mWifiP2pManager.setWFDInfo(this.mWifiP2pChannel, wfdInfo, new C02313());
            }
            this.mWfdEnabling = DEBUG;
            this.mWfdEnabled = DEBUG;
            reportFeatureState();
            updateScanState();
            disconnect();
        } else if (!this.mWfdEnabled && !this.mWfdEnabling) {
            this.mWfdEnabling = true;
            wfdInfo = new WifiP2pWfdInfo();
            wfdInfo.setWfdEnabled(true);
            wfdInfo.setDeviceType(0);
            wfdInfo.setSessionAvailable(true);
            wfdInfo.setControlPort(DEFAULT_CONTROL_PORT);
            wfdInfo.setMaxThroughput(MAX_THROUGHPUT);
            this.mWifiP2pManager.setWFDInfo(this.mWifiP2pChannel, wfdInfo, new C02302());
        }
    }

    private void reportFeatureState() {
        this.mHandler.post(new C02324(computeFeatureState()));
    }

    private int computeFeatureState() {
        if (this.mWifiP2pEnabled) {
            return this.mWifiDisplayOnSetting ? CONNECT_MAX_RETRIES : 2;
        } else {
            return 1;
        }
    }

    private void updateScanState() {
        if (this.mScanRequested && this.mWfdEnabled && this.mDesiredDevice == null) {
            if (!this.mDiscoverPeersInProgress) {
                Slog.i(TAG, "Starting Wifi display scan.");
                this.mDiscoverPeersInProgress = true;
                handleScanStarted();
                tryDiscoverPeers();
            }
        } else if (this.mDiscoverPeersInProgress) {
            this.mHandler.removeCallbacks(this.mDiscoverPeers);
            if (this.mDesiredDevice == null || this.mDesiredDevice == this.mConnectedDevice) {
                Slog.i(TAG, "Stopping Wifi display scan.");
                this.mDiscoverPeersInProgress = DEBUG;
                stopPeerDiscovery();
                handleScanFinished();
            }
        }
    }

    private void tryDiscoverPeers() {
        this.mWifiP2pManager.discoverPeers(this.mWifiP2pChannel, new C02335());
        this.mHandler.postDelayed(this.mDiscoverPeers, 10000);
    }

    private void stopPeerDiscovery() {
        this.mWifiP2pManager.stopPeerDiscovery(this.mWifiP2pChannel, new C02346());
    }

    private void requestPeers() {
        this.mWifiP2pManager.requestPeers(this.mWifiP2pChannel, new C02357());
    }

    private void handleScanStarted() {
        this.mHandler.post(new C02368());
    }

    private void handleScanResults() {
        int count = this.mAvailableWifiDisplayPeers.size();
        WifiDisplay[] displays = (WifiDisplay[]) WifiDisplay.CREATOR.newArray(count);
        for (int i = 0; i < count; i++) {
            WifiP2pDevice device = (WifiP2pDevice) this.mAvailableWifiDisplayPeers.get(i);
            displays[i] = createWifiDisplay(device);
            updateDesiredDevice(device);
        }
        this.mHandler.post(new C02379(displays));
    }

    private void handleScanFinished() {
        this.mHandler.post(new Runnable() {
            public void run() {
                WifiDisplayController.this.mListener.onScanFinished();
            }
        });
    }

    private void updateDesiredDevice(WifiP2pDevice device) {
        String address = device.deviceAddress;
        if (this.mDesiredDevice != null && this.mDesiredDevice.deviceAddress.equals(address)) {
            this.mDesiredDevice.update(device);
            if (this.mAdvertisedDisplay != null && this.mAdvertisedDisplay.getDeviceAddress().equals(address)) {
                readvertiseDisplay(createWifiDisplay(this.mDesiredDevice));
            }
        }
    }

    private void connect(WifiP2pDevice device) {
        if (this.mDesiredDevice != null && !this.mDesiredDevice.deviceAddress.equals(device.deviceAddress)) {
            return;
        }
        if (this.mConnectedDevice != null && !this.mConnectedDevice.deviceAddress.equals(device.deviceAddress) && this.mDesiredDevice == null) {
            return;
        }
        if (this.mWfdEnabled) {
            this.mDesiredDevice = device;
            this.mConnectionRetriesLeft = CONNECT_MAX_RETRIES;
            updateConnection();
            return;
        }
        Slog.i(TAG, "Ignoring request to connect to Wifi display because the  feature is currently disabled: " + device.deviceName);
    }

    private void disconnect() {
        this.mDesiredDevice = null;
        updateConnection();
    }

    private void retryConnection() {
        this.mDesiredDevice = new WifiP2pDevice(this.mDesiredDevice);
        updateConnection();
    }

    private void updateConnection() {
        updateScanState();
        if (!((this.mRemoteDisplay == null && this.mExtRemoteDisplay == null) || this.mConnectedDevice == this.mDesiredDevice)) {
            Slog.i(TAG, "Stopped listening for RTSP connection on " + this.mRemoteDisplayInterface + " from Wifi display: " + this.mConnectedDevice.deviceName);
            if (this.mRemoteDisplay != null) {
                this.mRemoteDisplay.dispose();
            } else if (this.mExtRemoteDisplay != null) {
                ExtendedRemoteDisplayHelper.dispose(this.mExtRemoteDisplay);
            }
            this.mExtRemoteDisplay = null;
            this.mRemoteDisplay = null;
            this.mRemoteDisplayInterface = null;
            this.mRemoteDisplayConnected = DEBUG;
            this.mHandler.removeCallbacks(this.mRtspTimeout);
            this.mWifiP2pManager.setMiracastMode(0);
            unadvertiseDisplay();
        }
        if (this.mDisconnectingDevice == null) {
            if (this.mConnectedDevice != null && this.mConnectedDevice != this.mDesiredDevice) {
                Slog.i(TAG, "Disconnecting from Wifi display: " + this.mConnectedDevice.deviceName);
                this.mDisconnectingDevice = this.mConnectedDevice;
                this.mConnectedDevice = null;
                this.mConnectedDeviceGroupInfo = null;
                unadvertiseDisplay();
                this.mWifiP2pManager.removeGroup(this.mWifiP2pChannel, new AnonymousClass11(this.mDisconnectingDevice));
            } else if (this.mCancelingDevice != null) {
            } else {
                if (this.mConnectingDevice != null && this.mConnectingDevice != this.mDesiredDevice) {
                    Slog.i(TAG, "Canceling connection to Wifi display: " + this.mConnectingDevice.deviceName);
                    this.mCancelingDevice = this.mConnectingDevice;
                    this.mConnectingDevice = null;
                    unadvertiseDisplay();
                    this.mHandler.removeCallbacks(this.mConnectionTimeout);
                    this.mWifiP2pManager.cancelConnect(this.mWifiP2pChannel, new AnonymousClass12(this.mCancelingDevice));
                } else if (this.mDesiredDevice == null) {
                    if (this.mWifiDisplayCertMode) {
                        this.mListener.onDisplaySessionInfo(getSessionInfo(this.mConnectedDeviceGroupInfo, 0));
                    }
                    unadvertiseDisplay();
                } else if (this.mConnectedDevice == null && this.mConnectingDevice == null) {
                    Slog.i(TAG, "Connecting to Wifi display: " + this.mDesiredDevice.deviceName);
                    this.mConnectingDevice = this.mDesiredDevice;
                    WifiP2pConfig config = new WifiP2pConfig();
                    WpsInfo wps = new WpsInfo();
                    if (this.mWifiDisplayWpsConfig != 4) {
                        wps.setup = this.mWifiDisplayWpsConfig;
                    } else if (this.mConnectingDevice.wpsPbcSupported()) {
                        wps.setup = 0;
                    } else if (this.mConnectingDevice.wpsDisplaySupported()) {
                        wps.setup = 2;
                    } else {
                        wps.setup = 1;
                    }
                    config.wps = wps;
                    config.deviceAddress = this.mConnectingDevice.deviceAddress;
                    config.groupOwnerIntent = 0;
                    advertiseDisplay(createWifiDisplay(this.mConnectingDevice), null, 0, 0, 0);
                    this.mWifiP2pManager.connect(this.mWifiP2pChannel, config, new AnonymousClass13(this.mDesiredDevice));
                } else if (this.mConnectedDevice != null && this.mRemoteDisplay == null && this.mExtRemoteDisplay == null) {
                    Inet4Address addr = getInterfaceAddress(this.mConnectedDeviceGroupInfo);
                    if (addr == null) {
                        Slog.i(TAG, "Failed to get local interface address for communicating with Wifi display: " + this.mConnectedDevice.deviceName);
                        handleConnectionFailure(DEBUG);
                        return;
                    }
                    this.mWifiP2pManager.setMiracastMode(1);
                    WifiP2pDevice oldDevice = this.mConnectedDevice;
                    String iface = addr.getHostAddress() + ":" + getPortNumber(this.mConnectedDevice);
                    this.mRemoteDisplayInterface = iface;
                    Slog.i(TAG, "Listening for RTSP connection on " + iface + " from Wifi display: " + this.mConnectedDevice.deviceName);
                    android.media.RemoteDisplay.Listener listener = new AnonymousClass14(oldDevice);
                    if (ExtendedRemoteDisplayHelper.isAvailable()) {
                        this.mExtRemoteDisplay = ExtendedRemoteDisplayHelper.listen(iface, listener, this.mHandler, this.mContext);
                    } else {
                        this.mRemoteDisplay = RemoteDisplay.listen(iface, listener, this.mHandler);
                    }
                    this.mHandler.postDelayed(this.mRtspTimeout, (long) ((this.mWifiDisplayCertMode ? RTSP_TIMEOUT_SECONDS_CERT_MODE : RTSP_TIMEOUT_SECONDS) * ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE));
                }
            }
        }
    }

    private WifiDisplaySessionInfo getSessionInfo(WifiP2pGroup info, int session) {
        if (info == null) {
            return null;
        }
        Inet4Address addr = getInterfaceAddress(info);
        return new WifiDisplaySessionInfo(!info.getOwner().deviceAddress.equals(this.mThisDevice.deviceAddress) ? true : DEBUG, session, info.getOwner().deviceAddress + " " + info.getNetworkName(), info.getPassphrase(), addr != null ? addr.getHostAddress() : "");
    }

    private void handleStateChanged(boolean enabled) {
        this.mWifiP2pEnabled = enabled;
        updateWfdEnableState();
    }

    private void handlePeersChanged() {
        requestPeers();
    }

    private void handleConnectionChanged(NetworkInfo networkInfo) {
        this.mNetworkInfo = networkInfo;
        if (!this.mWfdEnabled || !networkInfo.isConnected()) {
            this.mConnectedDeviceGroupInfo = null;
            if (!(this.mConnectingDevice == null && this.mConnectedDevice == null)) {
                disconnect();
            }
            if (this.mWfdEnabled) {
                requestPeers();
            }
        } else if (this.mDesiredDevice != null || this.mWifiDisplayCertMode) {
            this.mWifiP2pManager.requestGroupInfo(this.mWifiP2pChannel, new GroupInfoListener() {
                public void onGroupInfoAvailable(WifiP2pGroup info) {
                    if (WifiDisplayController.this.mConnectingDevice != null && !info.contains(WifiDisplayController.this.mConnectingDevice)) {
                        Slog.i(WifiDisplayController.TAG, "Aborting connection to Wifi display because the current P2P group does not contain the device we expected to find: " + WifiDisplayController.this.mConnectingDevice.deviceName + ", group info was: " + WifiDisplayController.describeWifiP2pGroup(info));
                        WifiDisplayController.this.handleConnectionFailure(WifiDisplayController.DEBUG);
                    } else if (WifiDisplayController.this.mDesiredDevice == null || info.contains(WifiDisplayController.this.mDesiredDevice)) {
                        if (WifiDisplayController.this.mWifiDisplayCertMode) {
                            boolean owner = info.getOwner().deviceAddress.equals(WifiDisplayController.this.mThisDevice.deviceAddress);
                            if (owner && info.getClientList().isEmpty()) {
                                WifiDisplayController.this.mConnectingDevice = WifiDisplayController.this.mDesiredDevice = null;
                                WifiDisplayController.this.mConnectedDeviceGroupInfo = info;
                                WifiDisplayController.this.updateConnection();
                            } else if (WifiDisplayController.this.mConnectingDevice == null && WifiDisplayController.this.mDesiredDevice == null) {
                                WifiDisplayController.this.mConnectingDevice = WifiDisplayController.this.mDesiredDevice = owner ? (WifiP2pDevice) info.getClientList().iterator().next() : info.getOwner();
                            }
                        }
                        if (WifiDisplayController.this.mConnectingDevice != null && WifiDisplayController.this.mConnectingDevice == WifiDisplayController.this.mDesiredDevice) {
                            Slog.i(WifiDisplayController.TAG, "Connected to Wifi display: " + WifiDisplayController.this.mConnectingDevice.deviceName);
                            WifiDisplayController.this.mHandler.removeCallbacks(WifiDisplayController.this.mConnectionTimeout);
                            WifiDisplayController.this.mConnectedDeviceGroupInfo = info;
                            WifiDisplayController.this.mConnectedDevice = WifiDisplayController.this.mConnectingDevice;
                            WifiDisplayController.this.mConnectingDevice = null;
                            WifiDisplayController.this.updateConnection();
                        }
                    } else {
                        WifiDisplayController.this.disconnect();
                    }
                }
            });
        }
    }

    private void handleConnectionFailure(boolean timeoutOccurred) {
        Slog.i(TAG, "Wifi display connection failed!");
        if (this.mDesiredDevice == null) {
            return;
        }
        if (this.mConnectionRetriesLeft > 0) {
            long j;
            WifiP2pDevice oldDevice = this.mDesiredDevice;
            Handler handler = this.mHandler;
            Runnable anonymousClass19 = new AnonymousClass19(oldDevice);
            if (timeoutOccurred) {
                j = 0;
            } else {
                j = 500;
            }
            handler.postDelayed(anonymousClass19, j);
            return;
        }
        disconnect();
    }

    private void advertiseDisplay(WifiDisplay display, Surface surface, int width, int height, int flags) {
        if (!Objects.equal(this.mAdvertisedDisplay, display) || this.mAdvertisedDisplaySurface != surface || this.mAdvertisedDisplayWidth != width || this.mAdvertisedDisplayHeight != height || this.mAdvertisedDisplayFlags != flags) {
            WifiDisplay oldDisplay = this.mAdvertisedDisplay;
            Surface oldSurface = this.mAdvertisedDisplaySurface;
            this.mAdvertisedDisplay = display;
            this.mAdvertisedDisplaySurface = surface;
            this.mAdvertisedDisplayWidth = width;
            this.mAdvertisedDisplayHeight = height;
            this.mAdvertisedDisplayFlags = flags;
            this.mHandler.post(new AnonymousClass20(oldSurface, surface, oldDisplay, display, width, height, flags));
        }
    }

    private void unadvertiseDisplay() {
        advertiseDisplay(null, null, 0, 0, 0);
    }

    private void readvertiseDisplay(WifiDisplay display) {
        advertiseDisplay(display, this.mAdvertisedDisplaySurface, this.mAdvertisedDisplayWidth, this.mAdvertisedDisplayHeight, this.mAdvertisedDisplayFlags);
    }

    private static Inet4Address getInterfaceAddress(WifiP2pGroup info) {
        try {
            Enumeration<InetAddress> addrs = NetworkInterface.getByName(info.getInterface()).getInetAddresses();
            while (addrs.hasMoreElements()) {
                InetAddress addr = (InetAddress) addrs.nextElement();
                if (addr instanceof Inet4Address) {
                    return (Inet4Address) addr;
                }
            }
            Slog.w(TAG, "Could not obtain address of network interface " + info.getInterface() + " because it had no IPv4 addresses.");
            return null;
        } catch (SocketException ex) {
            Slog.w(TAG, "Could not obtain address of network interface " + info.getInterface(), ex);
            return null;
        }
    }

    private static int getPortNumber(WifiP2pDevice device) {
        if (device.deviceName.startsWith("DIRECT-") && device.deviceName.endsWith("Broadcom")) {
            return 8554;
        }
        return DEFAULT_CONTROL_PORT;
    }

    private static boolean isWifiDisplay(WifiP2pDevice device) {
        return (device.wfdInfo != null && device.wfdInfo.isWfdEnabled() && isPrimarySinkDeviceType(device.wfdInfo.getDeviceType())) ? true : DEBUG;
    }

    private static boolean isPrimarySinkDeviceType(int deviceType) {
        return (deviceType == 1 || deviceType == CONNECT_MAX_RETRIES) ? true : DEBUG;
    }

    private static String describeWifiP2pDevice(WifiP2pDevice device) {
        return device != null ? device.toString().replace('\n', ',') : "null";
    }

    private static String describeWifiP2pGroup(WifiP2pGroup group) {
        return group != null ? group.toString().replace('\n', ',') : "null";
    }

    private static WifiDisplay createWifiDisplay(WifiP2pDevice device) {
        return new WifiDisplay(device.deviceAddress, device.deviceName, null, true, device.wfdInfo.isSessionAvailable(), DEBUG);
    }
}
