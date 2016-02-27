package com.android.server.connectivity;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Resources;
import android.content.res.Resources.NotFoundException;
import android.hardware.usb.UsbManager;
import android.net.ConnectivityManager;
import android.net.ConnectivityManager.NetworkCallback;
import android.net.INetworkStatsService;
import android.net.InterfaceConfiguration;
import android.net.LinkAddress;
import android.net.LinkProperties;
import android.net.Network;
import android.net.NetworkInfo;
import android.net.NetworkInfo.DetailedState;
import android.net.NetworkRequest;
import android.net.NetworkRequest.Builder;
import android.net.NetworkUtils;
import android.net.RouteInfo;
import android.net.wifi.WifiDevice;
import android.os.Binder;
import android.os.INetworkManagementService;
import android.os.INetworkManagementService.Stub;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.UserHandle;
import android.system.OsConstants;
import android.util.Log;
import com.android.internal.util.IState;
import com.android.internal.util.State;
import com.android.internal.util.StateMachine;
import com.android.server.IoThread;
import com.android.server.net.BaseNetworkObserver;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.net.Inet4Address;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class Tethering extends BaseNetworkObserver {
    private static final boolean DBG = true;
    private static final String[] DHCP_DEFAULT_RANGE;
    private static final int DNSMASQ_POLLING_INTERVAL = 1000;
    private static final int DNSMASQ_POLLING_MAX_TIMES = 10;
    private static final String DNS_DEFAULT_SERVER1 = "8.8.8.8";
    private static final String DNS_DEFAULT_SERVER2 = "8.8.4.4";
    private static final Integer DUN_TYPE;
    public static final String EXTRA_TETHERED_IFACE = "tetheredClientIface";
    public static final String EXTRA_UPSTREAM_IFACE = "tetheringUpstreamIface";
    public static final int EXTRA_UPSTREAM_INFO_DEFAULT = -1;
    public static final String EXTRA_UPSTREAM_IP_TYPE = "tetheringUpstreamIpType";
    public static final String EXTRA_UPSTREAM_UPDATE_TYPE = "tetheringUpstreamUpdateType";
    private static final Integer HIPRI_TYPE;
    private static final Integer MOBILE_TYPE;
    private static final String TAG = "Tethering";
    public static final String UPSTREAM_IFACE_CHANGED_ACTION = "com.android.server.connectivity.UPSTREAM_IFACE_CHANGED";
    private static final String USB_NEAR_IFACE_ADDR = "192.168.42.129";
    private static final int USB_PREFIX_LENGTH = 24;
    private static final boolean VDBG = false;
    private static final String dhcpLocation = "/data/misc/dhcp/dnsmasq.leases";
    private HashMap<String, WifiDevice> mConnectedDeviceMap;
    private Context mContext;
    private String[] mDefaultDnsServers;
    private String[] mDhcpRange;
    private HashMap<String, TetherInterfaceSM> mIfaces;
    private HashMap<String, WifiDevice> mL2ConnectedDeviceMap;
    private Looper mLooper;
    private final INetworkManagementService mNMService;
    private int mPreferredUpstreamMobileApn;
    private Object mPublicSync;
    private boolean mRndisEnabled;
    private BroadcastReceiver mStateReceiver;
    private final INetworkStatsService mStatsService;
    private StateMachine mTetherMasterSM;
    private String[] mTetherableBluetoothRegexs;
    private String[] mTetherableUsbRegexs;
    private String[] mTetherableWifiRegexs;
    private Notification mTetheredNotification;
    private Collection<Integer> mUpstreamIfaceTypes;
    private boolean mUsbTetherRequested;

    private static class DnsmasqThread extends Thread {
        private WifiDevice mDevice;
        private int mInterval;
        private int mMaxTimes;
        private final Tethering mTethering;

        public DnsmasqThread(Tethering tethering, WifiDevice device, int interval, int maxTimes) {
            super(Tethering.TAG);
            this.mTethering = tethering;
            this.mInterval = interval;
            this.mMaxTimes = maxTimes;
            this.mDevice = device;
        }

        public void run() {
            boolean result = Tethering.VDBG;
            while (this.mMaxTimes > 0) {
                try {
                    result = this.mTethering.readDeviceInfoFromDnsmasq(this.mDevice);
                    if (result) {
                        Log.d(Tethering.TAG, "Successfully poll device info for " + this.mDevice.deviceAddress);
                        break;
                    } else {
                        this.mMaxTimes += Tethering.EXTRA_UPSTREAM_INFO_DEFAULT;
                        Thread.sleep((long) this.mInterval);
                    }
                } catch (Exception ex) {
                    result = Tethering.VDBG;
                    Log.e(Tethering.TAG, "Pulling " + this.mDevice.deviceAddress + "error" + ex);
                }
            }
            if (!result) {
                Log.d(Tethering.TAG, "Pulling timeout, suppose STA uses static ip " + this.mDevice.deviceAddress);
            }
            WifiDevice other = (WifiDevice) this.mTethering.mL2ConnectedDeviceMap.get(this.mDevice.deviceAddress);
            if (other == null || other.deviceState != 1) {
                Log.d(Tethering.TAG, "Device " + this.mDevice.deviceAddress + "already disconnected, ignoring");
                return;
            }
            this.mTethering.mConnectedDeviceMap.put(this.mDevice.deviceAddress, this.mDevice);
            this.mTethering.sendTetherConnectStateChangedBroadcast();
        }
    }

    private class StateReceiver extends BroadcastReceiver {
        private StateReceiver() {
        }

        public void onReceive(Context content, Intent intent) {
            String action = intent.getAction();
            if (action != null) {
                if (action.equals("android.hardware.usb.action.USB_STATE")) {
                    synchronized (Tethering.this.mPublicSync) {
                        boolean usbConnected = intent.getBooleanExtra("connected", Tethering.VDBG);
                        Tethering.this.mRndisEnabled = intent.getBooleanExtra("rndis", Tethering.VDBG);
                        if (usbConnected && Tethering.this.mRndisEnabled && Tethering.this.mUsbTetherRequested) {
                            Tethering.this.tetherUsb(Tethering.DBG);
                        }
                        Tethering.this.mUsbTetherRequested = Tethering.VDBG;
                    }
                } else if (action.equals("android.net.conn.CONNECTIVITY_CHANGE_IMMEDIATE")) {
                    NetworkInfo networkInfo = (NetworkInfo) intent.getParcelableExtra("networkInfo");
                    if (networkInfo != null && networkInfo.getDetailedState() != DetailedState.FAILED) {
                        Tethering.this.mTetherMasterSM.sendMessage(3, networkInfo);
                    }
                } else if (action.equals("android.intent.action.CONFIGURATION_CHANGED")) {
                    Tethering.this.updateConfiguration();
                } else if (action.equals("android.net.wifi.WIFI_AP_STATE_CHANGED")) {
                    int wifiApState = intent.getIntExtra("wifi_state", 11);
                    Log.d(Tethering.TAG, "WIFI_AP_STATE_CHANGED: wifiApState=" + wifiApState);
                    if (wifiApState == 13 || wifiApState == 11) {
                        Tethering.this.mConnectedDeviceMap.clear();
                        Tethering.this.mL2ConnectedDeviceMap.clear();
                    }
                }
            }
        }
    }

    class TetherInterfaceSM extends StateMachine {
        static final int CMD_CELL_DUN_ERROR = 6;
        static final int CMD_INTERFACE_DOWN = 4;
        static final int CMD_INTERFACE_UP = 5;
        static final int CMD_IP_FORWARDING_DISABLE_ERROR = 8;
        static final int CMD_IP_FORWARDING_ENABLE_ERROR = 7;
        static final int CMD_SET_DNS_FORWARDERS_ERROR = 11;
        static final int CMD_START_TETHERING_ERROR = 9;
        static final int CMD_STOP_TETHERING_ERROR = 10;
        static final int CMD_TETHER_CONNECTION_CHANGED = 12;
        static final int CMD_TETHER_MODE_DEAD = 1;
        static final int CMD_TETHER_REQUESTED = 2;
        static final int CMD_TETHER_UNREQUESTED = 3;
        private boolean mAvailable;
        private State mDefaultState;
        String mIfaceName;
        private State mInitialState;
        int mLastError;
        String mMyUpstreamIfaceName;
        private State mStartingState;
        private boolean mTethered;
        private State mTetheredState;
        private State mUnavailableState;
        boolean mUsb;

        class InitialState extends State {
            InitialState() {
            }

            public void enter() {
                TetherInterfaceSM.this.setAvailable(Tethering.DBG);
                TetherInterfaceSM.this.setTethered(Tethering.VDBG);
                Tethering.this.sendTetherStateChangedBroadcast();
            }

            public boolean processMessage(Message message) {
                Log.d(Tethering.TAG, "InitialState.processMessage what=" + message.what);
                switch (message.what) {
                    case TetherInterfaceSM.CMD_TETHER_REQUESTED /*2*/:
                        TetherInterfaceSM.this.setLastError(0);
                        Tethering.this.mTetherMasterSM.sendMessage(TetherInterfaceSM.CMD_TETHER_MODE_DEAD, TetherInterfaceSM.this);
                        TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mStartingState);
                        return Tethering.DBG;
                    case TetherInterfaceSM.CMD_INTERFACE_DOWN /*4*/:
                        TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mUnavailableState);
                        return Tethering.DBG;
                    default:
                        return Tethering.VDBG;
                }
            }
        }

        class StartingState extends State {
            StartingState() {
            }

            public void enter() {
                TetherInterfaceSM.this.setAvailable(Tethering.VDBG);
                if (!TetherInterfaceSM.this.mUsb || Tethering.this.configureUsbIface(Tethering.DBG)) {
                    Tethering.this.sendTetherStateChangedBroadcast();
                    TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mTetheredState);
                    return;
                }
                Tethering.this.mTetherMasterSM.sendMessage(TetherInterfaceSM.CMD_TETHER_REQUESTED, TetherInterfaceSM.this);
                TetherInterfaceSM.this.setLastError(TetherInterfaceSM.CMD_STOP_TETHERING_ERROR);
                TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mInitialState);
            }

            public boolean processMessage(Message message) {
                Log.d(Tethering.TAG, "StartingState.processMessage what=" + message.what);
                switch (message.what) {
                    case TetherInterfaceSM.CMD_TETHER_UNREQUESTED /*3*/:
                        Tethering.this.mTetherMasterSM.sendMessage(TetherInterfaceSM.CMD_TETHER_REQUESTED, TetherInterfaceSM.this);
                        if (!TetherInterfaceSM.this.mUsb || Tethering.this.configureUsbIface(Tethering.VDBG)) {
                            TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mInitialState);
                            return Tethering.DBG;
                        }
                        TetherInterfaceSM.this.setLastErrorAndTransitionToInitialState(TetherInterfaceSM.CMD_STOP_TETHERING_ERROR);
                        return Tethering.DBG;
                    case TetherInterfaceSM.CMD_INTERFACE_DOWN /*4*/:
                        Tethering.this.mTetherMasterSM.sendMessage(TetherInterfaceSM.CMD_TETHER_REQUESTED, TetherInterfaceSM.this);
                        TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mUnavailableState);
                        return Tethering.DBG;
                    case TetherInterfaceSM.CMD_CELL_DUN_ERROR /*6*/:
                    case TetherInterfaceSM.CMD_IP_FORWARDING_ENABLE_ERROR /*7*/:
                    case TetherInterfaceSM.CMD_IP_FORWARDING_DISABLE_ERROR /*8*/:
                    case TetherInterfaceSM.CMD_START_TETHERING_ERROR /*9*/:
                    case TetherInterfaceSM.CMD_STOP_TETHERING_ERROR /*10*/:
                    case TetherInterfaceSM.CMD_SET_DNS_FORWARDERS_ERROR /*11*/:
                        TetherInterfaceSM.this.setLastErrorAndTransitionToInitialState(TetherInterfaceSM.CMD_INTERFACE_UP);
                        return Tethering.DBG;
                    default:
                        return Tethering.VDBG;
                }
            }
        }

        class TetheredState extends State {
            TetheredState() {
            }

            public void enter() {
                try {
                    Tethering.this.mNMService.tetherInterface(TetherInterfaceSM.this.mIfaceName);
                    Log.d(Tethering.TAG, "Tethered " + TetherInterfaceSM.this.mIfaceName);
                    TetherInterfaceSM.this.setAvailable(Tethering.VDBG);
                    TetherInterfaceSM.this.setTethered(Tethering.DBG);
                    Tethering.this.sendTetherStateChangedBroadcast();
                } catch (Exception e) {
                    Log.e(Tethering.TAG, "Error Tethering: " + e.toString());
                    TetherInterfaceSM.this.setLastError(TetherInterfaceSM.CMD_CELL_DUN_ERROR);
                    TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mInitialState);
                }
            }

            private void cleanupUpstream() {
                if (TetherInterfaceSM.this.mMyUpstreamIfaceName != null) {
                    try {
                        Tethering.this.mStatsService.forceUpdate();
                    } catch (Exception e) {
                    }
                    try {
                        Tethering.this.mNMService.disableNat(TetherInterfaceSM.this.mIfaceName, TetherInterfaceSM.this.mMyUpstreamIfaceName);
                        Tethering.this.sendUpstreamIfaceChangeBroadcast(TetherInterfaceSM.this.mMyUpstreamIfaceName, TetherInterfaceSM.this.mIfaceName, OsConstants.AF_INET, UpstreamInfoUpdateType.UPSTREAM_IFACE_REMOVED);
                    } catch (Exception e2) {
                    }
                    TetherInterfaceSM.this.mMyUpstreamIfaceName = null;
                }
            }

            public boolean processMessage(Message message) {
                Log.d(Tethering.TAG, "TetheredState.processMessage what=" + message.what);
                boolean retValue = Tethering.DBG;
                boolean error = Tethering.VDBG;
                switch (message.what) {
                    case TetherInterfaceSM.CMD_TETHER_MODE_DEAD /*1*/:
                        break;
                    case TetherInterfaceSM.CMD_TETHER_UNREQUESTED /*3*/:
                    case TetherInterfaceSM.CMD_INTERFACE_DOWN /*4*/:
                        cleanupUpstream();
                        try {
                            Tethering.this.mNMService.untetherInterface(TetherInterfaceSM.this.mIfaceName);
                            Tethering.this.mTetherMasterSM.sendMessage(TetherInterfaceSM.CMD_TETHER_REQUESTED, TetherInterfaceSM.this);
                            if (message.what == TetherInterfaceSM.CMD_TETHER_UNREQUESTED) {
                                if (TetherInterfaceSM.this.mUsb && !Tethering.this.configureUsbIface(Tethering.VDBG)) {
                                    TetherInterfaceSM.this.setLastError(TetherInterfaceSM.CMD_STOP_TETHERING_ERROR);
                                }
                                TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mInitialState);
                            } else if (message.what == TetherInterfaceSM.CMD_INTERFACE_DOWN) {
                                TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mUnavailableState);
                            }
                            Log.d(Tethering.TAG, "Untethered " + TetherInterfaceSM.this.mIfaceName);
                            break;
                        } catch (Exception e) {
                            TetherInterfaceSM.this.setLastErrorAndTransitionToInitialState(TetherInterfaceSM.CMD_IP_FORWARDING_ENABLE_ERROR);
                            break;
                        }
                    case TetherInterfaceSM.CMD_CELL_DUN_ERROR /*6*/:
                    case TetherInterfaceSM.CMD_IP_FORWARDING_ENABLE_ERROR /*7*/:
                    case TetherInterfaceSM.CMD_IP_FORWARDING_DISABLE_ERROR /*8*/:
                    case TetherInterfaceSM.CMD_START_TETHERING_ERROR /*9*/:
                    case TetherInterfaceSM.CMD_STOP_TETHERING_ERROR /*10*/:
                    case TetherInterfaceSM.CMD_SET_DNS_FORWARDERS_ERROR /*11*/:
                        error = Tethering.DBG;
                        break;
                    case TetherInterfaceSM.CMD_TETHER_CONNECTION_CHANGED /*12*/:
                        String newUpstreamIfaceName = (String) message.obj;
                        if (!(TetherInterfaceSM.this.mMyUpstreamIfaceName == null && newUpstreamIfaceName == null) && (TetherInterfaceSM.this.mMyUpstreamIfaceName == null || !TetherInterfaceSM.this.mMyUpstreamIfaceName.equals(newUpstreamIfaceName))) {
                            cleanupUpstream();
                            if (newUpstreamIfaceName != null) {
                                try {
                                    Tethering.this.mNMService.enableNat(TetherInterfaceSM.this.mIfaceName, newUpstreamIfaceName);
                                    Tethering.this.sendUpstreamIfaceChangeBroadcast(newUpstreamIfaceName, TetherInterfaceSM.this.mIfaceName, OsConstants.AF_INET, UpstreamInfoUpdateType.UPSTREAM_IFACE_ADDED);
                                } catch (Exception e2) {
                                    Log.e(Tethering.TAG, "Exception enabling Nat: " + e2.toString());
                                    try {
                                        Tethering.this.mNMService.untetherInterface(TetherInterfaceSM.this.mIfaceName);
                                    } catch (Exception e3) {
                                    }
                                    TetherInterfaceSM.this.setLastError(TetherInterfaceSM.CMD_IP_FORWARDING_DISABLE_ERROR);
                                    TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mInitialState);
                                    return Tethering.DBG;
                                }
                            }
                            TetherInterfaceSM.this.mMyUpstreamIfaceName = newUpstreamIfaceName;
                            break;
                        }
                    default:
                        retValue = Tethering.VDBG;
                        break;
                }
                cleanupUpstream();
                try {
                    Tethering.this.mNMService.untetherInterface(TetherInterfaceSM.this.mIfaceName);
                    if (error) {
                        TetherInterfaceSM.this.setLastErrorAndTransitionToInitialState(TetherInterfaceSM.CMD_INTERFACE_UP);
                    } else {
                        Log.d(Tethering.TAG, "Tether lost upstream connection " + TetherInterfaceSM.this.mIfaceName);
                        Tethering.this.sendTetherStateChangedBroadcast();
                        if (TetherInterfaceSM.this.mUsb && !Tethering.this.configureUsbIface(Tethering.VDBG)) {
                            TetherInterfaceSM.this.setLastError(TetherInterfaceSM.CMD_STOP_TETHERING_ERROR);
                        }
                        TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mInitialState);
                    }
                } catch (Exception e4) {
                    TetherInterfaceSM.this.setLastErrorAndTransitionToInitialState(TetherInterfaceSM.CMD_IP_FORWARDING_ENABLE_ERROR);
                }
                return retValue;
            }
        }

        class UnavailableState extends State {
            UnavailableState() {
            }

            public void enter() {
                TetherInterfaceSM.this.setAvailable(Tethering.VDBG);
                TetherInterfaceSM.this.setLastError(0);
                TetherInterfaceSM.this.setTethered(Tethering.VDBG);
                Tethering.this.sendTetherStateChangedBroadcast();
            }

            public boolean processMessage(Message message) {
                switch (message.what) {
                    case TetherInterfaceSM.CMD_INTERFACE_UP /*5*/:
                        TetherInterfaceSM.this.transitionTo(TetherInterfaceSM.this.mInitialState);
                        return Tethering.DBG;
                    default:
                        return Tethering.VDBG;
                }
            }
        }

        TetherInterfaceSM(String name, Looper looper, boolean usb) {
            super(name, looper);
            this.mIfaceName = name;
            this.mUsb = usb;
            setLastError(0);
            this.mInitialState = new InitialState();
            addState(this.mInitialState);
            this.mStartingState = new StartingState();
            addState(this.mStartingState);
            this.mTetheredState = new TetheredState();
            addState(this.mTetheredState);
            this.mUnavailableState = new UnavailableState();
            addState(this.mUnavailableState);
            setInitialState(this.mInitialState);
        }

        public String toString() {
            String res = new String() + this.mIfaceName + " - ";
            IState current = getCurrentState();
            if (current == this.mInitialState) {
                res = res + "InitialState";
            }
            if (current == this.mStartingState) {
                res = res + "StartingState";
            }
            if (current == this.mTetheredState) {
                res = res + "TetheredState";
            }
            if (current == this.mUnavailableState) {
                res = res + "UnavailableState";
            }
            if (this.mAvailable) {
                res = res + " - Available";
            }
            if (this.mTethered) {
                res = res + " - Tethered";
            }
            return res + " - lastError =" + this.mLastError;
        }

        public int getLastError() {
            int i;
            synchronized (Tethering.this.mPublicSync) {
                i = this.mLastError;
            }
            return i;
        }

        private void setLastError(int error) {
            synchronized (Tethering.this.mPublicSync) {
                this.mLastError = error;
                if (isErrored() && this.mUsb) {
                    Tethering.this.configureUsbIface(Tethering.VDBG);
                }
            }
        }

        public boolean isAvailable() {
            boolean z;
            synchronized (Tethering.this.mPublicSync) {
                z = this.mAvailable;
            }
            return z;
        }

        private void setAvailable(boolean available) {
            synchronized (Tethering.this.mPublicSync) {
                this.mAvailable = available;
            }
        }

        public boolean isTethered() {
            boolean z;
            synchronized (Tethering.this.mPublicSync) {
                z = this.mTethered;
            }
            return z;
        }

        public String getTethered() {
            String str;
            synchronized (Tethering.this.mPublicSync) {
                str = this.mIfaceName;
            }
            return str;
        }

        private void setTethered(boolean tethered) {
            synchronized (Tethering.this.mPublicSync) {
                this.mTethered = tethered;
            }
        }

        public boolean isErrored() {
            boolean z;
            synchronized (Tethering.this.mPublicSync) {
                z = this.mLastError != 0 ? Tethering.DBG : Tethering.VDBG;
            }
            return z;
        }

        void setLastErrorAndTransitionToInitialState(int error) {
            setLastError(error);
            transitionTo(this.mInitialState);
        }
    }

    class TetherMasterSM extends StateMachine {
        private static final int BLUETOOTH_TETHERING = 2;
        private static final int CELL_CONNECTION_RENEW_MS = 40000;
        static final int CMD_CELL_CONNECTION_RENEW = 4;
        static final int CMD_RETRY_UPSTREAM = 5;
        static final int CMD_TETHER_MODE_REQUESTED = 1;
        static final int CMD_TETHER_MODE_UNREQUESTED = 2;
        static final int CMD_UPSTREAM_CHANGED = 3;
        private static final String EXTRA_ADD_TETHER_TYPE = "extraAddTetherType";
        private static final String EXTRA_RUN_PROVISION = "extraRunProvision";
        private static final int UPSTREAM_SETTLE_TIME_MS = 10000;
        private static final int USB_TETHERING = 1;
        private static final int WIFI_TETHERING = 0;
        private SimChangeBroadcastReceiver mBroadcastReceiver;
        private int mCurrentConnectionSequence;
        private State mInitialState;
        private int mMobileApnReserved;
        private NetworkCallback mNetworkCallback;
        private ArrayList<TetherInterfaceSM> mNotifyList;
        private int mSequenceNumber;
        private State mSetDnsForwardersErrorState;
        private State mSetIpForwardingDisabledErrorState;
        private State mSetIpForwardingEnabledErrorState;
        private final AtomicInteger mSimBcastGenerationNumber;
        private State mStartTetheringErrorState;
        private State mStopTetheringErrorState;
        private State mTetherModeAliveState;
        private String mUpstreamIfaceName;
        boolean prevIPV6Connected;

        class ErrorState extends State {
            int mErrorNotification;

            ErrorState() {
            }

            public boolean processMessage(Message message) {
                switch (message.what) {
                    case TetherMasterSM.USB_TETHERING /*1*/:
                        message.obj.sendMessage(this.mErrorNotification);
                        return Tethering.DBG;
                    default:
                        return Tethering.VDBG;
                }
            }

            void notify(int msgType) {
                this.mErrorNotification = msgType;
                Iterator i$ = TetherMasterSM.this.mNotifyList.iterator();
                while (i$.hasNext()) {
                    ((TetherInterfaceSM) i$.next()).sendMessage(msgType);
                }
            }
        }

        class TetherMasterUtilState extends State {
            protected static final boolean TRY_TO_SETUP_MOBILE_CONNECTION = true;
            protected static final boolean WAIT_FOR_NETWORK_TO_SETTLE = false;

            /* renamed from: com.android.server.connectivity.Tethering.TetherMasterSM.TetherMasterUtilState.1 */
            class C01711 extends NetworkCallback {
                boolean currentIPV6Connected;
                String currentUpstreamIface;
                String lastUpstreamIface;

                C01711() {
                    this.lastUpstreamIface = null;
                    this.currentIPV6Connected = Tethering.VDBG;
                }

                public void onAvailable(Network network) {
                    Log.d(Tethering.TAG, "network available: " + network);
                    try {
                        LinkProperties lp = Tethering.this.getConnectivityManager().getLinkProperties(network);
                        this.currentIPV6Connected = TetherMasterUtilState.this.isIpv6Connected(lp);
                        this.currentUpstreamIface = lp.getInterfaceName();
                        this.lastUpstreamIface = this.currentUpstreamIface;
                        if (TetherMasterSM.this.prevIPV6Connected != this.currentIPV6Connected && this.currentIPV6Connected) {
                            TetherMasterUtilState.this.addUpstreamV6Interface(this.currentUpstreamIface);
                        }
                    } catch (Exception e) {
                        Log.e(Tethering.TAG, "Exception querying ConnectivityManager", e);
                    }
                    TetherMasterSM.this.prevIPV6Connected = this.currentIPV6Connected;
                }

                public void onLost(Network network) {
                    Log.d(Tethering.TAG, "network lost: " + network.toString());
                    if (TetherMasterSM.this.mNetworkCallback != null) {
                        TetherMasterUtilState.this.removeUpstreamV6Interface(this.lastUpstreamIface);
                        Log.d(Tethering.TAG, "Unregistering NetworkCallback()");
                        Tethering.this.getConnectivityManager().unregisterNetworkCallback(TetherMasterSM.this.mNetworkCallback);
                        TetherMasterSM.this.mNetworkCallback = null;
                        TetherMasterSM.this.prevIPV6Connected = Tethering.VDBG;
                        this.lastUpstreamIface = null;
                    }
                }

                public void onLinkPropertiesChanged(Network network, LinkProperties lp) {
                    this.currentIPV6Connected = TetherMasterUtilState.this.isIpv6Connected(lp);
                    this.currentUpstreamIface = lp.getInterfaceName();
                    this.lastUpstreamIface = this.currentUpstreamIface;
                    Collection<InetAddress> addresses = lp.getAddresses();
                    if (TetherMasterSM.this.prevIPV6Connected != this.currentIPV6Connected) {
                        if (this.currentIPV6Connected) {
                            TetherMasterUtilState.this.addUpstreamV6Interface(this.currentUpstreamIface);
                        } else {
                            TetherMasterUtilState.this.removeUpstreamV6Interface(this.currentUpstreamIface);
                        }
                        TetherMasterSM.this.prevIPV6Connected = this.currentIPV6Connected;
                    }
                }
            }

            TetherMasterUtilState() {
            }

            public boolean processMessage(Message m) {
                return Tethering.VDBG;
            }

            protected String enableString(int apnType) {
                switch (apnType) {
                    case AppTransition.TRANSIT_NONE /*0*/:
                    case TetherMasterSM.CMD_RETRY_UPSTREAM /*5*/:
                        return "enableHIPRI";
                    case TetherMasterSM.CMD_CELL_CONNECTION_RENEW /*4*/:
                        return "enableDUNAlways";
                    default:
                        return null;
                }
            }

            protected boolean turnOnUpstreamMobileConnection(int apnType) {
                boolean retValue = TRY_TO_SETUP_MOBILE_CONNECTION;
                if (apnType == Tethering.EXTRA_UPSTREAM_INFO_DEFAULT) {
                    return Tethering.VDBG;
                }
                if (apnType != TetherMasterSM.this.mMobileApnReserved) {
                    turnOffUpstreamMobileConnection();
                }
                String enableString = enableString(apnType);
                if (enableString == null) {
                    return Tethering.VDBG;
                }
                switch (Tethering.this.getConnectivityManager().startUsingNetworkFeature(0, enableString)) {
                    case AppTransition.TRANSIT_NONE /*0*/:
                    case TetherMasterSM.USB_TETHERING /*1*/:
                        TetherMasterSM.this.mMobileApnReserved = apnType;
                        Message m = TetherMasterSM.this.obtainMessage(TetherMasterSM.CMD_CELL_CONNECTION_RENEW);
                        m.arg1 = TetherMasterSM.access$3604(TetherMasterSM.this);
                        TetherMasterSM.this.sendMessageDelayed(m, 40000);
                        break;
                    default:
                        retValue = Tethering.VDBG;
                        break;
                }
                return retValue;
            }

            protected boolean turnOffUpstreamMobileConnection() {
                TetherMasterSM.access$3604(TetherMasterSM.this);
                if (TetherMasterSM.this.mMobileApnReserved != Tethering.EXTRA_UPSTREAM_INFO_DEFAULT) {
                    Tethering.this.getConnectivityManager().stopUsingNetworkFeature(0, enableString(TetherMasterSM.this.mMobileApnReserved));
                    TetherMasterSM.this.mMobileApnReserved = Tethering.EXTRA_UPSTREAM_INFO_DEFAULT;
                }
                return TRY_TO_SETUP_MOBILE_CONNECTION;
            }

            protected boolean turnOnMasterTetherSettings() {
                try {
                    Tethering.this.mNMService.setIpForwardingEnabled(TRY_TO_SETUP_MOBILE_CONNECTION);
                    try {
                        Tethering.this.mNMService.startTethering(Tethering.this.mDhcpRange);
                        return TRY_TO_SETUP_MOBILE_CONNECTION;
                    } catch (Exception e) {
                        try {
                            Tethering.this.mNMService.stopTethering();
                            Tethering.this.mNMService.startTethering(Tethering.this.mDhcpRange);
                            return TRY_TO_SETUP_MOBILE_CONNECTION;
                        } catch (Exception e2) {
                            TetherMasterSM.this.transitionTo(TetherMasterSM.this.mStartTetheringErrorState);
                            return Tethering.VDBG;
                        }
                    }
                } catch (Exception e3) {
                    TetherMasterSM.this.transitionTo(TetherMasterSM.this.mSetIpForwardingEnabledErrorState);
                    return Tethering.VDBG;
                }
            }

            protected boolean turnOffMasterTetherSettings() {
                try {
                    Tethering.this.mNMService.stopTethering();
                    try {
                        Tethering.this.mNMService.setIpForwardingEnabled(Tethering.VDBG);
                        TetherMasterSM.this.transitionTo(TetherMasterSM.this.mInitialState);
                        return TRY_TO_SETUP_MOBILE_CONNECTION;
                    } catch (Exception e) {
                        TetherMasterSM.this.transitionTo(TetherMasterSM.this.mSetIpForwardingDisabledErrorState);
                        return Tethering.VDBG;
                    }
                } catch (Exception e2) {
                    TetherMasterSM.this.transitionTo(TetherMasterSM.this.mStopTetheringErrorState);
                    return Tethering.VDBG;
                }
            }

            protected void addUpstreamV6Interface(String iface) {
                INetworkManagementService service = Stub.asInterface(ServiceManager.getService("network_management"));
                Log.d(Tethering.TAG, "adding v6 interface " + iface);
                try {
                    service.addUpstreamV6Interface(iface);
                    Iterator i$ = TetherMasterSM.this.mNotifyList.iterator();
                    while (i$.hasNext()) {
                        Tethering.this.sendUpstreamIfaceChangeBroadcast(iface, ((TetherInterfaceSM) i$.next()).getTethered(), OsConstants.AF_INET6, UpstreamInfoUpdateType.UPSTREAM_IFACE_ADDED);
                    }
                } catch (RemoteException e) {
                    Log.e(Tethering.TAG, "Unable to append v6 upstream interface");
                }
            }

            protected void removeUpstreamV6Interface(String iface) {
                INetworkManagementService service = Stub.asInterface(ServiceManager.getService("network_management"));
                Log.d(Tethering.TAG, "removing v6 interface " + iface);
                try {
                    service.removeUpstreamV6Interface(iface);
                    Iterator i$ = TetherMasterSM.this.mNotifyList.iterator();
                    while (i$.hasNext()) {
                        Tethering.this.sendUpstreamIfaceChangeBroadcast(iface, ((TetherInterfaceSM) i$.next()).getTethered(), OsConstants.AF_INET6, UpstreamInfoUpdateType.UPSTREAM_IFACE_REMOVED);
                    }
                } catch (RemoteException e) {
                    Log.e(Tethering.TAG, "Unable to remove v6 upstream interface");
                }
            }

            private boolean isIpv6Connected(LinkProperties lp) {
                boolean ret = Tethering.VDBG;
                if (lp == null) {
                    return Tethering.VDBG;
                }
                try {
                    for (InetAddress addr : lp.getAddresses()) {
                        if (addr instanceof Inet6Address) {
                            Inet6Address i6addr = (Inet6Address) addr;
                            if (!(i6addr.isAnyLocalAddress() || i6addr.isLinkLocalAddress() || i6addr.isLoopbackAddress() || i6addr.isMulticastAddress())) {
                                ret = TRY_TO_SETUP_MOBILE_CONNECTION;
                                break;
                            }
                        }
                    }
                } catch (Exception e) {
                    Log.e(Tethering.TAG, "Exception getting LinkProperties", e);
                }
                return ret;
            }

            private NetworkRequest getNetworkRequest(int upType) {
                int ncType;
                int transportType = Tethering.EXTRA_UPSTREAM_INFO_DEFAULT;
                switch (upType) {
                    case AppTransition.TRANSIT_NONE /*0*/:
                        ncType = 12;
                        transportType = 0;
                        break;
                    case TetherMasterSM.USB_TETHERING /*1*/:
                        ncType = 12;
                        transportType = TetherMasterSM.USB_TETHERING;
                        break;
                    case TetherMasterSM.CMD_TETHER_MODE_UNREQUESTED /*2*/:
                        ncType = 0;
                        transportType = 0;
                        break;
                    case TetherMasterSM.CMD_UPSTREAM_CHANGED /*3*/:
                        ncType = TetherMasterSM.USB_TETHERING;
                        transportType = 0;
                        break;
                    case TetherMasterSM.CMD_CELL_CONNECTION_RENEW /*4*/:
                        ncType = TetherMasterSM.CMD_TETHER_MODE_UNREQUESTED;
                        transportType = 0;
                        break;
                    case TetherMasterSM.CMD_RETRY_UPSTREAM /*5*/:
                        ncType = 12;
                        transportType = 0;
                        break;
                    case C0569H.FINISHED_STARTING /*7*/:
                        ncType = 12;
                        transportType = TetherMasterSM.CMD_TETHER_MODE_UNREQUESTED;
                        break;
                    case C0569H.REPORT_APPLICATION_TOKEN_DRAWN /*9*/:
                        ncType = 12;
                        transportType = TetherMasterSM.CMD_UPSTREAM_CHANGED;
                        break;
                    case Tethering.DNSMASQ_POLLING_MAX_TIMES /*10*/:
                        ncType = TetherMasterSM.CMD_UPSTREAM_CHANGED;
                        transportType = 0;
                        break;
                    case C0569H.WINDOW_FREEZE_TIMEOUT /*11*/:
                        ncType = TetherMasterSM.CMD_CELL_CONNECTION_RENEW;
                        transportType = 0;
                        break;
                    case AppTransition.TRANSIT_WALLPAPER_CLOSE /*12*/:
                        ncType = TetherMasterSM.CMD_RETRY_UPSTREAM;
                        transportType = 0;
                        break;
                    case C0569H.APP_TRANSITION_TIMEOUT /*13*/:
                        ncType = 6;
                        transportType = TetherMasterSM.USB_TETHERING;
                        break;
                    case C0569H.PERSIST_ANIMATION_SCALE /*14*/:
                        ncType = 7;
                        transportType = 0;
                        break;
                    case C0569H.FORCE_GC /*15*/:
                        ncType = Tethering.DNSMASQ_POLLING_MAX_TIMES;
                        transportType = 0;
                        break;
                    default:
                        ncType = Tethering.EXTRA_UPSTREAM_INFO_DEFAULT;
                        break;
                }
                return new Builder().addCapability(ncType).addTransportType(transportType).build();
            }

            private NetworkCallback getNetworkCallback() {
                return new C01711();
            }

            protected void chooseUpstreamType(boolean tryCell) {
                int upType = Tethering.EXTRA_UPSTREAM_INFO_DEFAULT;
                String iface = null;
                Tethering.this.updateConfiguration();
                synchronized (Tethering.this.mPublicSync) {
                    for (Integer netType : Tethering.this.mUpstreamIfaceTypes) {
                        NetworkInfo info = Tethering.this.getConnectivityManager().getNetworkInfo(netType.intValue());
                        if (info != null && info.isConnected()) {
                            upType = netType.intValue();
                            break;
                        }
                    }
                }
                Log.d(Tethering.TAG, "chooseUpstreamType(" + tryCell + "), preferredApn =" + Tethering.this.mPreferredUpstreamMobileApn + ", got type=" + upType);
                LinkProperties linkProperties = Tethering.this.getConnectivityManager().getLinkProperties(upType);
                if (upType == TetherMasterSM.CMD_CELL_CONNECTION_RENEW || upType == TetherMasterSM.CMD_RETRY_UPSTREAM) {
                    turnOnUpstreamMobileConnection(upType);
                } else if (upType != Tethering.EXTRA_UPSTREAM_INFO_DEFAULT) {
                    turnOffUpstreamMobileConnection();
                }
                if (upType == Tethering.EXTRA_UPSTREAM_INFO_DEFAULT) {
                    boolean tryAgainLater = TRY_TO_SETUP_MOBILE_CONNECTION;
                    if (tryCell == TetherMasterSM.USB_TETHERING) {
                        if (turnOnUpstreamMobileConnection(Tethering.this.mPreferredUpstreamMobileApn) == TetherMasterSM.USB_TETHERING) {
                            tryAgainLater = Tethering.VDBG;
                        }
                    }
                    if (tryAgainLater) {
                        TetherMasterSM.this.sendMessageDelayed(TetherMasterSM.CMD_RETRY_UPSTREAM, 10000);
                    }
                } else {
                    try {
                        info = Tethering.this.getConnectivityManager().getNetworkInfo(upType);
                        if (info != null && info.isConnected()) {
                            if (TetherMasterSM.this.mNetworkCallback == null) {
                                TetherMasterSM.this.mNetworkCallback = getNetworkCallback();
                                NetworkRequest networkRequest = getNetworkRequest(upType);
                                Log.d(Tethering.TAG, "Registering NetworkCallback");
                                Tethering.this.getConnectivityManager().registerNetworkCallback(networkRequest, TetherMasterSM.this.mNetworkCallback);
                            }
                        }
                    } catch (Exception e) {
                        Log.e(Tethering.TAG, "Exception querying ConnectivityManager", e);
                    }
                    if (linkProperties != null) {
                        Log.i(Tethering.TAG, "Finding IPv4 upstream interface on: " + linkProperties);
                        RouteInfo ipv4Default = RouteInfo.selectBestRoute(linkProperties.getAllRoutes(), Inet4Address.ANY);
                        if (ipv4Default != null) {
                            iface = ipv4Default.getInterface();
                            Log.i(Tethering.TAG, "Found interface " + ipv4Default.getInterface());
                        } else {
                            Log.i(Tethering.TAG, "No IPv4 upstream interface, giving up.");
                        }
                    }
                    if (iface != null) {
                        String[] dnsServers = Tethering.this.mDefaultDnsServers;
                        Collection<InetAddress> dnses = linkProperties.getDnsServers();
                        if (dnses != null) {
                            ArrayList<InetAddress> v4Dnses = new ArrayList(dnses.size());
                            for (InetAddress dnsAddress : dnses) {
                                if (dnsAddress instanceof Inet4Address) {
                                    v4Dnses.add(dnsAddress);
                                }
                            }
                            if (v4Dnses.size() > 0) {
                                dnsServers = NetworkUtils.makeStrings(v4Dnses);
                            }
                        }
                        try {
                            Network network = Tethering.this.getConnectivityManager().getNetworkForType(upType);
                            if (network == null) {
                                Log.e(Tethering.TAG, "No Network for upstream type " + upType + "!");
                            }
                            Tethering.this.mNMService.setDnsForwarders(network, dnsServers);
                        } catch (Exception e2) {
                            Log.e(Tethering.TAG, "Setting DNS forwarders failed!");
                            TetherMasterSM.this.transitionTo(TetherMasterSM.this.mSetDnsForwardersErrorState);
                        }
                    }
                }
                notifyTetheredOfNewUpstreamIface(iface);
            }

            protected void notifyTetheredOfNewUpstreamIface(String ifaceName) {
                Log.d(Tethering.TAG, "notifying tethered with iface =" + ifaceName);
                TetherMasterSM.this.mUpstreamIfaceName = ifaceName;
                Iterator i$ = TetherMasterSM.this.mNotifyList.iterator();
                while (i$.hasNext()) {
                    ((TetherInterfaceSM) i$.next()).sendMessage(12, ifaceName);
                }
            }
        }

        class InitialState extends TetherMasterUtilState {
            InitialState() {
                super();
            }

            public void enter() {
            }

            public boolean processMessage(Message message) {
                Log.d(Tethering.TAG, "MasterInitialState.processMessage what=" + message.what);
                switch (message.what) {
                    case TetherMasterSM.USB_TETHERING /*1*/:
                        TetherMasterSM.this.mNotifyList.add(message.obj);
                        TetherMasterSM.this.transitionTo(TetherMasterSM.this.mTetherModeAliveState);
                        return Tethering.DBG;
                    case TetherMasterSM.CMD_TETHER_MODE_UNREQUESTED /*2*/:
                        TetherInterfaceSM who = (TetherInterfaceSM) message.obj;
                        if (TetherMasterSM.this.mNotifyList.indexOf(who) == Tethering.EXTRA_UPSTREAM_INFO_DEFAULT) {
                            return Tethering.DBG;
                        }
                        TetherMasterSM.this.mNotifyList.remove(who);
                        return Tethering.DBG;
                    default:
                        return Tethering.VDBG;
                }
            }
        }

        class SetDnsForwardersErrorState extends ErrorState {
            SetDnsForwardersErrorState() {
                super();
            }

            public void enter() {
                Log.e(Tethering.TAG, "Error in setDnsForwarders");
                notify(11);
                try {
                    Tethering.this.mNMService.stopTethering();
                } catch (Exception e) {
                }
                try {
                    Tethering.this.mNMService.setIpForwardingEnabled(Tethering.VDBG);
                } catch (Exception e2) {
                }
            }
        }

        class SetIpForwardingDisabledErrorState extends ErrorState {
            SetIpForwardingDisabledErrorState() {
                super();
            }

            public void enter() {
                Log.e(Tethering.TAG, "Error in setIpForwardingDisabled");
                notify(8);
            }
        }

        class SetIpForwardingEnabledErrorState extends ErrorState {
            SetIpForwardingEnabledErrorState() {
                super();
            }

            public void enter() {
                Log.e(Tethering.TAG, "Error in setIpForwardingEnabled");
                notify(7);
            }
        }

        class SimChangeBroadcastReceiver extends BroadcastReceiver {
            private final int mGenerationNumber;
            private boolean mSimAbsentSeen;

            public SimChangeBroadcastReceiver(int generationNumber) {
                this.mSimAbsentSeen = Tethering.VDBG;
                this.mGenerationNumber = generationNumber;
            }

            public void onReceive(Context context, Intent intent) {
                Log.d(Tethering.TAG, "simchange mGenerationNumber=" + this.mGenerationNumber + ", current generationNumber=" + TetherMasterSM.this.mSimBcastGenerationNumber.get());
                if (this.mGenerationNumber == TetherMasterSM.this.mSimBcastGenerationNumber.get()) {
                    String state = intent.getStringExtra("ss");
                    Log.d(Tethering.TAG, "got Sim changed to state " + state + ", mSimAbsentSeen=" + this.mSimAbsentSeen);
                    if (!this.mSimAbsentSeen && "ABSENT".equals(state)) {
                        this.mSimAbsentSeen = Tethering.DBG;
                    }
                    if (this.mSimAbsentSeen && "LOADED".equals(state)) {
                        this.mSimAbsentSeen = Tethering.VDBG;
                        try {
                            if (Tethering.this.mContext.getResources().getString(17039385).isEmpty()) {
                                Log.d(Tethering.TAG, "no prov-check needed for new SIM");
                                return;
                            }
                            String tetherService = Tethering.this.mContext.getResources().getString(17039387);
                            ArrayList<Integer> tethered = new ArrayList();
                            synchronized (Tethering.this.mPublicSync) {
                                for (Object iface : Tethering.this.mIfaces.keySet()) {
                                    TetherInterfaceSM sm = (TetherInterfaceSM) Tethering.this.mIfaces.get(iface);
                                    if (sm != null && sm.isTethered()) {
                                        if (Tethering.this.isUsb((String) iface)) {
                                            tethered.add(new Integer(TetherMasterSM.USB_TETHERING));
                                        } else {
                                            if (Tethering.this.isWifi((String) iface)) {
                                                tethered.add(new Integer(0));
                                            } else if (Tethering.this.isBluetooth((String) iface)) {
                                                tethered.add(new Integer(TetherMasterSM.CMD_TETHER_MODE_UNREQUESTED));
                                            }
                                        }
                                    }
                                }
                            }
                            Iterator i$ = tethered.iterator();
                            while (i$.hasNext()) {
                                int tetherType = ((Integer) i$.next()).intValue();
                                Intent startProvIntent = new Intent();
                                startProvIntent.putExtra(TetherMasterSM.EXTRA_ADD_TETHER_TYPE, tetherType);
                                startProvIntent.putExtra(TetherMasterSM.EXTRA_RUN_PROVISION, Tethering.DBG);
                                startProvIntent.setComponent(ComponentName.unflattenFromString(tetherService));
                                Tethering.this.mContext.startServiceAsUser(startProvIntent, UserHandle.CURRENT);
                            }
                            Log.d(Tethering.TAG, "re-evaluate provisioning");
                        } catch (NotFoundException e) {
                            Log.d(Tethering.TAG, "no prov-check needed for new SIM");
                        }
                    }
                }
            }
        }

        class StartTetheringErrorState extends ErrorState {
            StartTetheringErrorState() {
                super();
            }

            public void enter() {
                Log.e(Tethering.TAG, "Error in startTethering");
                notify(9);
                try {
                    Tethering.this.mNMService.setIpForwardingEnabled(Tethering.VDBG);
                } catch (Exception e) {
                }
            }
        }

        class StopTetheringErrorState extends ErrorState {
            StopTetheringErrorState() {
                super();
            }

            public void enter() {
                Log.e(Tethering.TAG, "Error in stopTethering");
                notify(Tethering.DNSMASQ_POLLING_MAX_TIMES);
                try {
                    Tethering.this.mNMService.setIpForwardingEnabled(Tethering.VDBG);
                } catch (Exception e) {
                }
            }
        }

        class TetherModeAliveState extends TetherMasterUtilState {
            boolean mTryCell;

            TetherModeAliveState() {
                super();
                this.mTryCell = Tethering.DBG;
            }

            public void enter() {
                boolean z = Tethering.DBG;
                turnOnMasterTetherSettings();
                TetherMasterSM.this.startListeningForSimChanges();
                this.mTryCell = Tethering.DBG;
                chooseUpstreamType(this.mTryCell);
                if (this.mTryCell) {
                    z = Tethering.VDBG;
                }
                this.mTryCell = z;
            }

            public void exit() {
                turnOffUpstreamMobileConnection();
                TetherMasterSM.this.stopListeningForSimChanges();
                notifyTetheredOfNewUpstreamIface(null);
            }

            public boolean processMessage(Message message) {
                boolean z = Tethering.DBG;
                Log.d(Tethering.TAG, "TetherModeAliveState.processMessage what=" + message.what);
                TetherInterfaceSM who;
                switch (message.what) {
                    case TetherMasterSM.USB_TETHERING /*1*/:
                        who = message.obj;
                        TetherMasterSM.this.mNotifyList.add(who);
                        who.sendMessage(12, TetherMasterSM.this.mUpstreamIfaceName);
                        return Tethering.DBG;
                    case TetherMasterSM.CMD_TETHER_MODE_UNREQUESTED /*2*/:
                        who = (TetherInterfaceSM) message.obj;
                        int index = TetherMasterSM.this.mNotifyList.indexOf(who);
                        if (index != Tethering.EXTRA_UPSTREAM_INFO_DEFAULT) {
                            Log.d(Tethering.TAG, "TetherModeAlive removing notifyee " + who);
                            TetherMasterSM.this.mNotifyList.remove(index);
                            if (TetherMasterSM.this.mNotifyList.isEmpty()) {
                                turnOffMasterTetherSettings();
                                return Tethering.DBG;
                            }
                            Log.d(Tethering.TAG, "TetherModeAlive still has " + TetherMasterSM.this.mNotifyList.size() + " live requests:");
                            Iterator i$ = TetherMasterSM.this.mNotifyList.iterator();
                            while (i$.hasNext()) {
                                Log.d(Tethering.TAG, "  " + i$.next());
                            }
                            return Tethering.DBG;
                        }
                        Log.e(Tethering.TAG, "TetherModeAliveState UNREQUESTED has unknown who: " + who);
                        return Tethering.DBG;
                    case TetherMasterSM.CMD_UPSTREAM_CHANGED /*3*/:
                        this.mTryCell = Tethering.DBG;
                        chooseUpstreamType(this.mTryCell);
                        if (this.mTryCell) {
                            z = Tethering.VDBG;
                        }
                        this.mTryCell = z;
                        return Tethering.DBG;
                    case TetherMasterSM.CMD_CELL_CONNECTION_RENEW /*4*/:
                        if (TetherMasterSM.this.mCurrentConnectionSequence != message.arg1) {
                            return Tethering.DBG;
                        }
                        turnOnUpstreamMobileConnection(TetherMasterSM.this.mMobileApnReserved);
                        return Tethering.DBG;
                    case TetherMasterSM.CMD_RETRY_UPSTREAM /*5*/:
                        chooseUpstreamType(this.mTryCell);
                        if (this.mTryCell) {
                            z = Tethering.VDBG;
                        }
                        this.mTryCell = z;
                        return Tethering.DBG;
                    default:
                        return Tethering.VDBG;
                }
            }
        }

        static /* synthetic */ int access$3604(TetherMasterSM x0) {
            int i = x0.mCurrentConnectionSequence + USB_TETHERING;
            x0.mCurrentConnectionSequence = i;
            return i;
        }

        TetherMasterSM(String name, Looper looper) {
            super(name, looper);
            this.mMobileApnReserved = Tethering.EXTRA_UPSTREAM_INFO_DEFAULT;
            this.mUpstreamIfaceName = null;
            this.mNetworkCallback = null;
            this.prevIPV6Connected = Tethering.VDBG;
            this.mSimBcastGenerationNumber = new AtomicInteger(0);
            this.mBroadcastReceiver = null;
            this.mInitialState = new InitialState();
            addState(this.mInitialState);
            this.mTetherModeAliveState = new TetherModeAliveState();
            addState(this.mTetherModeAliveState);
            this.mSetIpForwardingEnabledErrorState = new SetIpForwardingEnabledErrorState();
            addState(this.mSetIpForwardingEnabledErrorState);
            this.mSetIpForwardingDisabledErrorState = new SetIpForwardingDisabledErrorState();
            addState(this.mSetIpForwardingDisabledErrorState);
            this.mStartTetheringErrorState = new StartTetheringErrorState();
            addState(this.mStartTetheringErrorState);
            this.mStopTetheringErrorState = new StopTetheringErrorState();
            addState(this.mStopTetheringErrorState);
            this.mSetDnsForwardersErrorState = new SetDnsForwardersErrorState();
            addState(this.mSetDnsForwardersErrorState);
            this.mNotifyList = new ArrayList();
            setInitialState(this.mInitialState);
        }

        private void startListeningForSimChanges() {
            Log.d(Tethering.TAG, "startListeningForSimChanges");
            if (this.mBroadcastReceiver == null) {
                this.mBroadcastReceiver = new SimChangeBroadcastReceiver(this.mSimBcastGenerationNumber.incrementAndGet());
                IntentFilter filter = new IntentFilter();
                filter.addAction("android.intent.action.SIM_STATE_CHANGED");
                Tethering.this.mContext.registerReceiver(this.mBroadcastReceiver, filter);
            }
        }

        private void stopListeningForSimChanges() {
            Log.d(Tethering.TAG, "stopListeningForSimChanges");
            if (this.mBroadcastReceiver != null) {
                this.mSimBcastGenerationNumber.incrementAndGet();
                Tethering.this.mContext.unregisterReceiver(this.mBroadcastReceiver);
                this.mBroadcastReceiver = null;
            }
        }
    }

    private enum UpstreamInfoUpdateType {
        UPSTREAM_IFACE_REMOVED,
        UPSTREAM_IFACE_ADDED
    }

    static {
        MOBILE_TYPE = new Integer(0);
        HIPRI_TYPE = new Integer(5);
        DUN_TYPE = new Integer(4);
        DHCP_DEFAULT_RANGE = new String[]{"192.168.42.2", "192.168.42.254", "192.168.43.2", "192.168.43.254", "192.168.44.2", "192.168.44.254", "192.168.45.2", "192.168.45.254", "192.168.46.2", "192.168.46.254", "192.168.47.2", "192.168.47.254", "192.168.48.2", "192.168.48.254", "192.168.49.2", "192.168.49.254"};
    }

    public Tethering(Context context, INetworkManagementService nmService, INetworkStatsService statsService, Looper looper) {
        this.mPreferredUpstreamMobileApn = EXTRA_UPSTREAM_INFO_DEFAULT;
        this.mL2ConnectedDeviceMap = new HashMap();
        this.mConnectedDeviceMap = new HashMap();
        this.mContext = context;
        this.mNMService = nmService;
        this.mStatsService = statsService;
        this.mLooper = looper;
        this.mPublicSync = new Object();
        this.mIfaces = new HashMap();
        this.mLooper = IoThread.get().getLooper();
        this.mTetherMasterSM = new TetherMasterSM("TetherMaster", this.mLooper);
        this.mTetherMasterSM.start();
        this.mStateReceiver = new StateReceiver();
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.hardware.usb.action.USB_STATE");
        filter.addAction("android.net.conn.CONNECTIVITY_CHANGE_IMMEDIATE");
        filter.addAction("android.intent.action.CONFIGURATION_CHANGED");
        filter.addAction("android.net.wifi.WIFI_AP_STATE_CHANGED");
        this.mContext.registerReceiver(this.mStateReceiver, filter);
        filter = new IntentFilter();
        filter.addAction("android.intent.action.MEDIA_SHARED");
        filter.addAction("android.intent.action.MEDIA_UNSHARED");
        filter.addDataScheme("file");
        this.mContext.registerReceiver(this.mStateReceiver, filter);
        this.mDhcpRange = context.getResources().getStringArray(17235989);
        if (this.mDhcpRange.length == 0 || this.mDhcpRange.length % 2 == 1) {
            this.mDhcpRange = DHCP_DEFAULT_RANGE;
        }
        updateConfiguration();
        this.mDefaultDnsServers = new String[2];
        this.mDefaultDnsServers[0] = DNS_DEFAULT_SERVER1;
        this.mDefaultDnsServers[1] = DNS_DEFAULT_SERVER2;
    }

    private ConnectivityManager getConnectivityManager() {
        return (ConnectivityManager) this.mContext.getSystemService("connectivity");
    }

    void updateConfiguration() {
        String[] tetherableUsbRegexs = this.mContext.getResources().getStringArray(17235985);
        String[] tetherableWifiRegexs = this.mContext.getResources().getStringArray(17235986);
        String[] tetherableBluetoothRegexs = this.mContext.getResources().getStringArray(17235988);
        int[] ifaceTypes = this.mContext.getResources().getIntArray(17235991);
        Collection<Integer> upstreamIfaceTypes = new ArrayList();
        for (int i : ifaceTypes) {
            upstreamIfaceTypes.add(new Integer(i));
        }
        synchronized (this.mPublicSync) {
            this.mTetherableUsbRegexs = tetherableUsbRegexs;
            this.mTetherableWifiRegexs = tetherableWifiRegexs;
            this.mTetherableBluetoothRegexs = tetherableBluetoothRegexs;
            this.mUpstreamIfaceTypes = upstreamIfaceTypes;
        }
        checkDunRequired();
    }

    public void interfaceStatusChanged(String iface, boolean up) {
        boolean found = VDBG;
        boolean usb = VDBG;
        synchronized (this.mPublicSync) {
            if (isWifi(iface)) {
                found = DBG;
            } else if (isUsb(iface)) {
                found = DBG;
                usb = DBG;
            } else if (isBluetooth(iface)) {
                found = DBG;
            }
            if (found) {
                TetherInterfaceSM sm = (TetherInterfaceSM) this.mIfaces.get(iface);
                if (up) {
                    if (sm == null) {
                        sm = new TetherInterfaceSM(iface, this.mLooper, usb);
                        this.mIfaces.put(iface, sm);
                        sm.start();
                    }
                } else if (!(isUsb(iface) || sm == null)) {
                    sm.sendMessage(4);
                    this.mIfaces.remove(iface);
                }
                return;
            }
        }
    }

    public void interfaceLinkStateChanged(String iface, boolean up) {
        interfaceStatusChanged(iface, up);
    }

    private boolean isUsb(String iface) {
        boolean z;
        synchronized (this.mPublicSync) {
            for (String regex : this.mTetherableUsbRegexs) {
                if (iface.matches(regex)) {
                    z = DBG;
                    break;
                }
            }
            z = VDBG;
        }
        return z;
    }

    public boolean isWifi(String iface) {
        boolean z;
        synchronized (this.mPublicSync) {
            for (String regex : this.mTetherableWifiRegexs) {
                if (iface.matches(regex)) {
                    z = DBG;
                    break;
                }
            }
            z = VDBG;
        }
        return z;
    }

    public boolean isBluetooth(String iface) {
        boolean z;
        synchronized (this.mPublicSync) {
            for (String regex : this.mTetherableBluetoothRegexs) {
                if (iface.matches(regex)) {
                    z = DBG;
                    break;
                }
            }
            z = VDBG;
        }
        return z;
    }

    public void interfaceAdded(String iface) {
        boolean found = VDBG;
        boolean usb = VDBG;
        synchronized (this.mPublicSync) {
            if (isWifi(iface)) {
                found = DBG;
            }
            if (isUsb(iface)) {
                found = DBG;
                usb = DBG;
            }
            if (isBluetooth(iface)) {
                found = DBG;
            }
            if (!found) {
            } else if (((TetherInterfaceSM) this.mIfaces.get(iface)) != null) {
            } else {
                TetherInterfaceSM sm = new TetherInterfaceSM(iface, this.mLooper, usb);
                this.mIfaces.put(iface, sm);
                sm.start();
            }
        }
    }

    public void interfaceRemoved(String iface) {
        synchronized (this.mPublicSync) {
            TetherInterfaceSM sm = (TetherInterfaceSM) this.mIfaces.get(iface);
            if (sm == null) {
                return;
            }
            sm.sendMessage(4);
            this.mIfaces.remove(iface);
        }
    }

    public List<WifiDevice> getTetherConnectedSta() {
        List<WifiDevice> TetherConnectedStaList = new ArrayList();
        if (this.mContext.getResources().getBoolean(17956874)) {
            for (String key : this.mConnectedDeviceMap.keySet()) {
                TetherConnectedStaList.add((WifiDevice) this.mConnectedDeviceMap.get(key));
            }
        }
        return TetherConnectedStaList;
    }

    private void sendTetherConnectStateChangedBroadcast() {
        if (getConnectivityManager().isTetheringSupported()) {
            Intent broadcast = new Intent("android.net.conn.TETHER_CONNECT_STATE_CHANGED");
            broadcast.addFlags(603979776);
            this.mContext.sendStickyBroadcastAsUser(broadcast, UserHandle.ALL);
            showTetheredNotification(17303200);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private boolean readDeviceInfoFromDnsmasq(android.net.wifi.WifiDevice r14) {
        /*
        r13 = this;
        r11 = 3;
        r9 = 0;
        r4 = 0;
        r5 = new java.io.FileInputStream;	 Catch:{ IOException -> 0x0049 }
        r10 = "/data/misc/dhcp/dnsmasq.leases";
        r5.<init>(r10);	 Catch:{ IOException -> 0x0049 }
        r6 = new java.io.DataInputStream;	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        r6.<init>(r5);	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        r1 = new java.io.BufferedReader;	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        r10 = new java.io.InputStreamReader;	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        r10.<init>(r6);	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        r1.<init>(r10);	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
    L_0x0019:
        r7 = r1.readLine();	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        if (r7 == 0) goto L_0x003f;
    L_0x001f:
        r10 = r7.length();	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        if (r10 == 0) goto L_0x003f;
    L_0x0025:
        r10 = " ";
        r3 = r7.split(r10);	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        r10 = r3.length;	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        if (r10 <= r11) goto L_0x0019;
    L_0x002e:
        r10 = 1;
        r0 = r3[r10];	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        r10 = 3;
        r8 = r3[r10];	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        r10 = r14.deviceAddress;	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        r10 = r0.equals(r10);	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        if (r10 == 0) goto L_0x0019;
    L_0x003c:
        r14.deviceName = r8;	 Catch:{ IOException -> 0x0076, all -> 0x0073 }
        r9 = 1;
    L_0x003f:
        if (r5 == 0) goto L_0x0079;
    L_0x0041:
        r5.close();	 Catch:{ IOException -> 0x0046 }
        r4 = r5;
    L_0x0045:
        return r9;
    L_0x0046:
        r10 = move-exception;
        r4 = r5;
        goto L_0x0045;
    L_0x0049:
        r2 = move-exception;
    L_0x004a:
        r10 = "Tethering";
        r11 = new java.lang.StringBuilder;	 Catch:{ all -> 0x006a }
        r11.<init>();	 Catch:{ all -> 0x006a }
        r12 = "readDeviceNameFromDnsmasq: ";
        r11 = r11.append(r12);	 Catch:{ all -> 0x006a }
        r11 = r11.append(r2);	 Catch:{ all -> 0x006a }
        r11 = r11.toString();	 Catch:{ all -> 0x006a }
        android.util.Log.e(r10, r11);	 Catch:{ all -> 0x006a }
        if (r4 == 0) goto L_0x0045;
    L_0x0064:
        r4.close();	 Catch:{ IOException -> 0x0068 }
        goto L_0x0045;
    L_0x0068:
        r10 = move-exception;
        goto L_0x0045;
    L_0x006a:
        r10 = move-exception;
    L_0x006b:
        if (r4 == 0) goto L_0x0070;
    L_0x006d:
        r4.close();	 Catch:{ IOException -> 0x0071 }
    L_0x0070:
        throw r10;
    L_0x0071:
        r11 = move-exception;
        goto L_0x0070;
    L_0x0073:
        r10 = move-exception;
        r4 = r5;
        goto L_0x006b;
    L_0x0076:
        r2 = move-exception;
        r4 = r5;
        goto L_0x004a;
    L_0x0079:
        r4 = r5;
        goto L_0x0045;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.connectivity.Tethering.readDeviceInfoFromDnsmasq(android.net.wifi.WifiDevice):boolean");
    }

    public void interfaceMessageRecevied(String message) {
        if (this.mContext.getResources().getBoolean(17956874)) {
            Log.d(TAG, "interfaceMessageRecevied: message=" + message);
            try {
                WifiDevice device = new WifiDevice(message);
                if (device.deviceState == 1) {
                    this.mL2ConnectedDeviceMap.put(device.deviceAddress, device);
                    if (readDeviceInfoFromDnsmasq(device)) {
                        this.mConnectedDeviceMap.put(device.deviceAddress, device);
                        sendTetherConnectStateChangedBroadcast();
                        return;
                    }
                    Log.d(TAG, "Starting poll device info for " + device.deviceAddress);
                    new DnsmasqThread(this, device, DNSMASQ_POLLING_INTERVAL, DNSMASQ_POLLING_MAX_TIMES).start();
                } else if (device.deviceState == 0) {
                    this.mL2ConnectedDeviceMap.remove(device.deviceAddress);
                    this.mConnectedDeviceMap.remove(device.deviceAddress);
                    sendTetherConnectStateChangedBroadcast();
                }
            } catch (IllegalArgumentException ex) {
                Log.e(TAG, "WifiDevice IllegalArgument: " + ex);
            }
        }
    }

    public int tether(String iface) {
        Log.d(TAG, "Tethering " + iface);
        synchronized (this.mPublicSync) {
            TetherInterfaceSM sm = (TetherInterfaceSM) this.mIfaces.get(iface);
        }
        if (sm == null) {
            Log.e(TAG, "Tried to Tether an unknown iface :" + iface + ", ignoring");
            return 1;
        } else if (sm.isAvailable() || sm.isErrored()) {
            sm.sendMessage(2);
            return 0;
        } else {
            Log.e(TAG, "Tried to Tether an unavailable iface :" + iface + ", ignoring");
            return 4;
        }
    }

    public int untether(String iface) {
        Log.d(TAG, "Untethering " + iface);
        synchronized (this.mPublicSync) {
            TetherInterfaceSM sm = (TetherInterfaceSM) this.mIfaces.get(iface);
        }
        if (sm == null) {
            Log.e(TAG, "Tried to Untether an unknown iface :" + iface + ", ignoring");
            return 1;
        } else if (sm.isErrored()) {
            Log.e(TAG, "Tried to Untethered an errored iface :" + iface + ", ignoring");
            return 4;
        } else {
            sm.sendMessage(3);
            return 0;
        }
    }

    public int getLastTetherError(String iface) {
        int i;
        synchronized (this.mPublicSync) {
            TetherInterfaceSM sm = (TetherInterfaceSM) this.mIfaces.get(iface);
            if (sm == null) {
                Log.e(TAG, "Tried to getLastTetherError on an unknown iface :" + iface + ", ignoring");
                i = 1;
            } else {
                i = sm.getLastError();
            }
        }
        return i;
    }

    private void sendTetherStateChangedBroadcast() {
        if (getConnectivityManager().isTetheringSupported()) {
            ArrayList<String> availableList = new ArrayList();
            ArrayList<String> activeList = new ArrayList();
            ArrayList<String> erroredList = new ArrayList();
            boolean wifiTethered = VDBG;
            boolean usbTethered = VDBG;
            boolean bluetoothTethered = VDBG;
            synchronized (this.mPublicSync) {
                for (Object iface : this.mIfaces.keySet()) {
                    TetherInterfaceSM sm = (TetherInterfaceSM) this.mIfaces.get(iface);
                    if (sm != null) {
                        if (sm.isErrored()) {
                            erroredList.add((String) iface);
                        } else if (sm.isAvailable()) {
                            availableList.add((String) iface);
                        } else if (sm.isTethered()) {
                            if (isUsb((String) iface)) {
                                usbTethered = DBG;
                            } else {
                                if (isWifi((String) iface)) {
                                    wifiTethered = DBG;
                                } else {
                                    if (isBluetooth((String) iface)) {
                                        bluetoothTethered = DBG;
                                    }
                                }
                            }
                            activeList.add((String) iface);
                        }
                    }
                }
            }
            Intent broadcast = new Intent("android.net.conn.TETHER_STATE_CHANGED");
            broadcast.addFlags(603979776);
            broadcast.putStringArrayListExtra("availableArray", availableList);
            broadcast.putStringArrayListExtra("activeArray", activeList);
            broadcast.putStringArrayListExtra("erroredArray", erroredList);
            this.mContext.sendStickyBroadcastAsUser(broadcast, UserHandle.ALL);
            Log.d(TAG, "sendTetherStateChangedBroadcast " + availableList.size() + ", " + activeList.size() + ", " + erroredList.size());
            if (usbTethered) {
                if (wifiTethered || bluetoothTethered) {
                    showTetheredNotification(17303198);
                } else {
                    showTetheredNotification(17303199);
                }
            } else if (wifiTethered) {
                if (bluetoothTethered) {
                    showTetheredNotification(17303198);
                } else {
                    clearTetheredNotification();
                }
            } else if (bluetoothTethered) {
                showTetheredNotification(17303197);
            } else {
                clearTetheredNotification();
            }
        }
    }

    private void sendUpstreamIfaceChangeBroadcast(String upstreamIface, String tetheredIface, int ip_type, UpstreamInfoUpdateType update_type) {
        Log.d(TAG, "sendUpstreamIfaceChangeBroadcast upstreamIface:" + upstreamIface + " tetheredIface:" + tetheredIface + " IP Type: " + ip_type + " update_type" + update_type);
        Intent intent = new Intent(UPSTREAM_IFACE_CHANGED_ACTION);
        intent.putExtra(EXTRA_UPSTREAM_IFACE, upstreamIface);
        intent.putExtra(EXTRA_TETHERED_IFACE, tetheredIface);
        intent.putExtra(EXTRA_UPSTREAM_IP_TYPE, ip_type);
        intent.putExtra(EXTRA_UPSTREAM_UPDATE_TYPE, update_type.ordinal());
        this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    private void showTetheredNotification(int icon) {
        NotificationManager notificationManager = (NotificationManager) this.mContext.getSystemService("notification");
        if (notificationManager != null) {
            CharSequence message;
            if (this.mTetheredNotification != null && this.mTetheredNotification.icon == icon) {
                if (this.mContext.getResources().getBoolean(17956874) && icon == 17303200) {
                    notificationManager.cancelAsUser(null, this.mTetheredNotification.icon, UserHandle.ALL);
                } else {
                    return;
                }
            }
            Intent intent = new Intent();
            intent.setClassName("com.android.settings", "com.android.settings.TetherSettings");
            intent.setFlags(1073741824);
            PendingIntent pi = PendingIntent.getActivityAsUser(this.mContext, 0, intent, 0, null, UserHandle.CURRENT);
            Resources r = Resources.getSystem();
            CharSequence title = r.getText(17040745);
            int size = this.mConnectedDeviceMap.size();
            if (!this.mContext.getResources().getBoolean(17956874) || icon != 17303200) {
                message = r.getText(17040746);
            } else if (size == 0) {
                message = r.getText(17040747);
            } else if (size == 1) {
                message = String.format(r.getText(17040748).toString(), new Object[]{Integer.valueOf(size)});
            } else {
                message = String.format(r.getText(17040749).toString(), new Object[]{Integer.valueOf(size)});
            }
            if (this.mTetheredNotification == null) {
                this.mTetheredNotification = new Notification();
                this.mTetheredNotification.when = 0;
            }
            this.mTetheredNotification.icon = icon;
            Notification notification = this.mTetheredNotification;
            notification.defaults &= -2;
            this.mTetheredNotification.flags = 2;
            if (this.mContext.getResources().getBoolean(17956874) && icon == 17303200 && size > 0) {
                this.mTetheredNotification.tickerText = message;
            } else {
                this.mTetheredNotification.tickerText = title;
            }
            this.mTetheredNotification.visibility = 1;
            this.mTetheredNotification.color = this.mContext.getResources().getColor(17170521);
            this.mTetheredNotification.setLatestEventInfo(this.mContext, title, message, pi);
            this.mTetheredNotification.category = "status";
            notificationManager.notifyAsUser(null, this.mTetheredNotification.icon, this.mTetheredNotification, UserHandle.ALL);
        }
    }

    private void clearTetheredNotification() {
        NotificationManager notificationManager = (NotificationManager) this.mContext.getSystemService("notification");
        if (notificationManager != null && this.mTetheredNotification != null) {
            notificationManager.cancelAsUser(null, this.mTetheredNotification.icon, UserHandle.ALL);
            this.mTetheredNotification = null;
        }
    }

    private void tetherUsb(boolean enable) {
        String[] ifaces = new String[0];
        try {
            for (String iface : this.mNMService.listInterfaces()) {
                if (isUsb(iface)) {
                    if ((enable ? tether(iface) : untether(iface)) == 0) {
                        return;
                    }
                }
            }
            Log.e(TAG, "unable start or stop USB tethering");
        } catch (Exception e) {
            Log.e(TAG, "Error listing Interfaces", e);
        }
    }

    private boolean configureUsbIface(boolean enabled) {
        String[] ifaces = new String[0];
        try {
            for (String iface : this.mNMService.listInterfaces()) {
                if (isUsb(iface)) {
                    try {
                        InterfaceConfiguration ifcg = this.mNMService.getInterfaceConfig(iface);
                        if (ifcg != null) {
                            ifcg.setLinkAddress(new LinkAddress(NetworkUtils.numericToInetAddress(USB_NEAR_IFACE_ADDR), USB_PREFIX_LENGTH));
                            if (enabled) {
                                ifcg.setInterfaceUp();
                            } else {
                                ifcg.setInterfaceDown();
                            }
                            ifcg.clearFlag("running");
                            this.mNMService.setInterfaceConfig(iface, ifcg);
                        } else {
                            continue;
                        }
                    } catch (Exception e) {
                        Log.e(TAG, "Error configuring interface " + iface, e);
                        return VDBG;
                    }
                }
            }
            return DBG;
        } catch (Exception e2) {
            Log.e(TAG, "Error listing Interfaces", e2);
            return VDBG;
        }
    }

    public String[] getTetherableUsbRegexs() {
        return this.mTetherableUsbRegexs;
    }

    public String[] getTetherableWifiRegexs() {
        return this.mTetherableWifiRegexs;
    }

    public String[] getTetherableBluetoothRegexs() {
        return this.mTetherableBluetoothRegexs;
    }

    public int setUsbTethering(boolean enable) {
        UsbManager usbManager = (UsbManager) this.mContext.getSystemService("usb");
        synchronized (this.mPublicSync) {
            if (!enable) {
                tetherUsb(VDBG);
                if (this.mRndisEnabled) {
                    usbManager.setCurrentFunction(null, VDBG);
                }
                this.mUsbTetherRequested = VDBG;
            } else if (this.mRndisEnabled) {
                tetherUsb(DBG);
            } else {
                this.mUsbTetherRequested = DBG;
                usbManager.setCurrentFunction("rndis", VDBG);
            }
        }
        return 0;
    }

    public int[] getUpstreamIfaceTypes() {
        int[] values;
        synchronized (this.mPublicSync) {
            updateConfiguration();
            values = new int[this.mUpstreamIfaceTypes.size()];
            Iterator<Integer> iterator = this.mUpstreamIfaceTypes.iterator();
            for (int i = 0; i < this.mUpstreamIfaceTypes.size(); i++) {
                values[i] = ((Integer) iterator.next()).intValue();
            }
        }
        return values;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void checkDunRequired() {
        /*
        r7 = this;
        r1 = 5;
        r4 = 4;
        r2 = 2;
        r5 = r7.mContext;
        r6 = "phone";
        r3 = r5.getSystemService(r6);
        r3 = (android.telephony.TelephonyManager) r3;
        if (r3 == 0) goto L_0x0013;
    L_0x000f:
        r2 = r3.getTetherApnRequired();
    L_0x0013:
        r5 = "persist.sys.dun.override";
        r6 = -1;
        r0 = android.os.SystemProperties.getInt(r5, r6);
        r5 = 3;
        if (r0 >= r5) goto L_0x0020;
    L_0x001d:
        if (r0 < 0) goto L_0x0020;
    L_0x001f:
        r2 = r0;
    L_0x0020:
        r5 = r7.mPublicSync;
        monitor-enter(r5);
        r6 = 2;
        if (r2 == r6) goto L_0x00ac;
    L_0x0026:
        r6 = 1;
        if (r2 != r6) goto L_0x002a;
    L_0x0029:
        r1 = r4;
    L_0x002a:
        if (r1 != r4) goto L_0x0073;
    L_0x002c:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = MOBILE_TYPE;	 Catch:{ all -> 0x003e }
        r4 = r4.contains(r6);	 Catch:{ all -> 0x003e }
        if (r4 == 0) goto L_0x0041;
    L_0x0036:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = MOBILE_TYPE;	 Catch:{ all -> 0x003e }
        r4.remove(r6);	 Catch:{ all -> 0x003e }
        goto L_0x002c;
    L_0x003e:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x003e }
        throw r4;
    L_0x0041:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = HIPRI_TYPE;	 Catch:{ all -> 0x003e }
        r4 = r4.contains(r6);	 Catch:{ all -> 0x003e }
        if (r4 == 0) goto L_0x0053;
    L_0x004b:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = HIPRI_TYPE;	 Catch:{ all -> 0x003e }
        r4.remove(r6);	 Catch:{ all -> 0x003e }
        goto L_0x0041;
    L_0x0053:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = DUN_TYPE;	 Catch:{ all -> 0x003e }
        r4 = r4.contains(r6);	 Catch:{ all -> 0x003e }
        if (r4 != 0) goto L_0x0064;
    L_0x005d:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = DUN_TYPE;	 Catch:{ all -> 0x003e }
        r4.add(r6);	 Catch:{ all -> 0x003e }
    L_0x0064:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = DUN_TYPE;	 Catch:{ all -> 0x003e }
        r4 = r4.contains(r6);	 Catch:{ all -> 0x003e }
        if (r4 == 0) goto L_0x00a8;
    L_0x006e:
        r4 = 4;
        r7.mPreferredUpstreamMobileApn = r4;	 Catch:{ all -> 0x003e }
    L_0x0071:
        monitor-exit(r5);	 Catch:{ all -> 0x003e }
        return;
    L_0x0073:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = DUN_TYPE;	 Catch:{ all -> 0x003e }
        r4 = r4.contains(r6);	 Catch:{ all -> 0x003e }
        if (r4 == 0) goto L_0x0085;
    L_0x007d:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = DUN_TYPE;	 Catch:{ all -> 0x003e }
        r4.remove(r6);	 Catch:{ all -> 0x003e }
        goto L_0x0073;
    L_0x0085:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = MOBILE_TYPE;	 Catch:{ all -> 0x003e }
        r4 = r4.contains(r6);	 Catch:{ all -> 0x003e }
        if (r4 != 0) goto L_0x0096;
    L_0x008f:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = MOBILE_TYPE;	 Catch:{ all -> 0x003e }
        r4.add(r6);	 Catch:{ all -> 0x003e }
    L_0x0096:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = HIPRI_TYPE;	 Catch:{ all -> 0x003e }
        r4 = r4.contains(r6);	 Catch:{ all -> 0x003e }
        if (r4 != 0) goto L_0x0064;
    L_0x00a0:
        r4 = r7.mUpstreamIfaceTypes;	 Catch:{ all -> 0x003e }
        r6 = HIPRI_TYPE;	 Catch:{ all -> 0x003e }
        r4.add(r6);	 Catch:{ all -> 0x003e }
        goto L_0x0064;
    L_0x00a8:
        r4 = 5;
        r7.mPreferredUpstreamMobileApn = r4;	 Catch:{ all -> 0x003e }
        goto L_0x0071;
    L_0x00ac:
        r4 = 5;
        r7.mPreferredUpstreamMobileApn = r4;	 Catch:{ all -> 0x003e }
        goto L_0x0071;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.connectivity.Tethering.checkDunRequired():void");
    }

    public String[] getTetheredIfaces() {
        ArrayList<String> list = new ArrayList();
        synchronized (this.mPublicSync) {
            for (Object key : this.mIfaces.keySet()) {
                if (((TetherInterfaceSM) this.mIfaces.get(key)).isTethered()) {
                    list.add((String) key);
                }
            }
        }
        String[] retVal = new String[list.size()];
        for (int i = 0; i < list.size(); i++) {
            retVal[i] = (String) list.get(i);
        }
        return retVal;
    }

    public String[] getTetherableIfaces() {
        ArrayList<String> list = new ArrayList();
        synchronized (this.mPublicSync) {
            for (Object key : this.mIfaces.keySet()) {
                if (((TetherInterfaceSM) this.mIfaces.get(key)).isAvailable()) {
                    list.add((String) key);
                }
            }
        }
        String[] retVal = new String[list.size()];
        for (int i = 0; i < list.size(); i++) {
            retVal[i] = (String) list.get(i);
        }
        return retVal;
    }

    public String[] getTetheredDhcpRanges() {
        return this.mDhcpRange;
    }

    public String[] getErroredIfaces() {
        ArrayList<String> list = new ArrayList();
        synchronized (this.mPublicSync) {
            for (Object key : this.mIfaces.keySet()) {
                if (((TetherInterfaceSM) this.mIfaces.get(key)).isErrored()) {
                    list.add((String) key);
                }
            }
        }
        String[] retVal = new String[list.size()];
        for (int i = 0; i < list.size(); i++) {
            retVal[i] = (String) list.get(i);
        }
        return retVal;
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump ConnectivityService.Tether from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            return;
        }
        synchronized (this.mPublicSync) {
            pw.println("mUpstreamIfaceTypes: ");
            for (Integer netType : this.mUpstreamIfaceTypes) {
                pw.println(" " + netType);
            }
            pw.println();
            pw.println("Tether state:");
            for (Object o : this.mIfaces.values()) {
                pw.println(" " + o);
            }
        }
        pw.println();
    }
}
