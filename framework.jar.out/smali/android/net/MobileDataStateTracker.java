package android.net;

import android.bluetooth.BluetoothClass.Device;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.Camera.Parameters;
import android.net.NetworkInfo.DetailedState;
import android.net.NetworkInfo.State;
import android.net.SamplingDataTracker.SamplingSnapshot;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.os.Process;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.UserHandle;
import android.telephony.PhoneStateListener;
import android.telephony.SignalStrength;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Slog;
import android.view.KeyEvent;
import android.view.WindowManagerPolicy;
import android.view.inputmethod.InputMethodManager;
import android.widget.SpellChecker;
import android.widget.Toast;
import com.android.internal.telephony.ITelephony;
import com.android.internal.telephony.ITelephony.Stub;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.android.internal.util.AsyncChannel;
import java.io.CharArrayWriter;
import java.io.PrintWriter;
import java.util.concurrent.atomic.AtomicBoolean;

public class MobileDataStateTracker extends BaseNetworkStateTracker {
    private static final boolean DBG = false;
    private static final String TAG = "MobileDataStateTracker";
    private static final int UNKNOWN = Integer.MAX_VALUE;
    private static final boolean VDBG = false;
    private static NetworkDataEntry[] mTheoreticalBWTable;
    private String mApnType;
    private Context mContext;
    private AsyncChannel mDataConnectionTrackerAc;
    private boolean mDefaultRouteSet;
    private Handler mHandler;
    private AtomicBoolean mIsCaptivePortal;
    private LinkProperties mLinkProperties;
    private DataState mMobileDataState;
    private NetworkInfo mNetworkInfo;
    private ITelephony mPhoneService;
    private final PhoneStateListener mPhoneStateListener;
    protected boolean mPolicyDataEnabled;
    private boolean mPrivateDnsRouteSet;
    private SamplingDataTracker mSamplingDataTracker;
    private SignalStrength mSignalStrength;
    private Handler mTarget;
    private boolean mTeardownRequested;
    protected boolean mUserDataEnabled;

    /* renamed from: android.net.MobileDataStateTracker.1 */
    class C04861 extends PhoneStateListener {
        C04861() {
        }

        public void onSignalStrengthsChanged(SignalStrength signalStrength) {
            MobileDataStateTracker.this.mSignalStrength = signalStrength;
        }
    }

    /* renamed from: android.net.MobileDataStateTracker.2 */
    static /* synthetic */ class C04872 {
        static final /* synthetic */ int[] f20x67a69abf;

        static {
            f20x67a69abf = new int[DataState.values().length];
            try {
                f20x67a69abf[DataState.DISCONNECTED.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                f20x67a69abf[DataState.CONNECTING.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                f20x67a69abf[DataState.SUSPENDED.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                f20x67a69abf[DataState.CONNECTED.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
        }
    }

    static class MdstHandler extends Handler {
        private MobileDataStateTracker mMdst;

        MdstHandler(Looper looper, MobileDataStateTracker mdst) {
            super(looper);
            this.mMdst = mdst;
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 69632:
                    if (msg.arg1 == 0) {
                        this.mMdst.mDataConnectionTrackerAc = (AsyncChannel) msg.obj;
                    }
                case 69636:
                    this.mMdst.mDataConnectionTrackerAc = null;
                default:
            }
        }
    }

    private class MobileDataStateReceiver extends BroadcastReceiver {
        private MobileDataStateReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            boolean z = true;
            String apnName;
            if (intent.getAction().equals("android.intent.action.DATA_CONNECTION_CONNECTED_TO_PROVISIONING_APN")) {
                apnName = intent.getStringExtra(TelephonyManager.EXTRA_DATA_APN);
                if (TextUtils.equals(MobileDataStateTracker.this.mApnType, intent.getStringExtra(TelephonyManager.EXTRA_DATA_APN_TYPE))) {
                    MobileDataStateTracker.this.mMobileDataState = DataState.CONNECTING;
                    MobileDataStateTracker.this.updateLinkProperitesAndCapatilities(intent);
                    MobileDataStateTracker.this.mNetworkInfo.setIsConnectedToProvisioningNetwork(true);
                    MobileDataStateTracker.this.setDetailedState(DetailedState.SUSPENDED, ProxyInfo.LOCAL_EXCL_LIST, apnName);
                }
            } else if (intent.getAction().equals("android.intent.action.ANY_DATA_STATE")) {
                if (TextUtils.equals(intent.getStringExtra(TelephonyManager.EXTRA_DATA_APN_TYPE), MobileDataStateTracker.this.mApnType)) {
                    MobileDataStateTracker.this.mNetworkInfo.setIsConnectedToProvisioningNetwork(MobileDataStateTracker.DBG);
                    int oldSubtype = MobileDataStateTracker.this.mNetworkInfo.getSubtype();
                    int newSubType = TelephonyManager.getDefault().getNetworkType();
                    MobileDataStateTracker.this.mNetworkInfo.setSubtype(newSubType, TelephonyManager.getDefault().getNetworkTypeName());
                    if (newSubType != oldSubtype && MobileDataStateTracker.this.mNetworkInfo.isConnected()) {
                        MobileDataStateTracker.this.mTarget.obtainMessage(NetworkStateTracker.EVENT_NETWORK_SUBTYPE_CHANGED, oldSubtype, 0, MobileDataStateTracker.this.mNetworkInfo).sendToTarget();
                    }
                    DataState state = (DataState) Enum.valueOf(DataState.class, intent.getStringExtra(WindowManagerPolicy.EXTRA_HDMI_PLUGGED_STATE));
                    String reason = intent.getStringExtra(TelephonyManager.EXTRA_DATA_CHANGE_REASON);
                    apnName = intent.getStringExtra(TelephonyManager.EXTRA_DATA_APN);
                    MobileDataStateTracker.this.mNetworkInfo.setRoaming(intent.getBooleanExtra("networkRoaming", MobileDataStateTracker.DBG));
                    NetworkInfo access$600 = MobileDataStateTracker.this.mNetworkInfo;
                    if (intent.getBooleanExtra("networkUnvailable", MobileDataStateTracker.DBG)) {
                        z = MobileDataStateTracker.DBG;
                    }
                    access$600.setIsAvailable(z);
                    if (MobileDataStateTracker.this.mMobileDataState != state) {
                        MobileDataStateTracker.this.mMobileDataState = state;
                        switch (C04872.f20x67a69abf[state.ordinal()]) {
                            case Toast.LENGTH_LONG /*1*/:
                                if (MobileDataStateTracker.this.isTeardownRequested()) {
                                    MobileDataStateTracker.this.setTeardownRequested(MobileDataStateTracker.DBG);
                                }
                                MobileDataStateTracker.this.setDetailedState(DetailedState.DISCONNECTED, reason, apnName);
                                break;
                            case Action.MERGE_IGNORE /*2*/:
                                MobileDataStateTracker.this.setDetailedState(DetailedState.CONNECTING, reason, apnName);
                                break;
                            case SetDrawableParameters.TAG /*3*/:
                                MobileDataStateTracker.this.setDetailedState(DetailedState.SUSPENDED, reason, apnName);
                                break;
                            case ViewGroupAction.TAG /*4*/:
                                MobileDataStateTracker.this.updateLinkProperitesAndCapatilities(intent);
                                MobileDataStateTracker.this.setDetailedState(DetailedState.CONNECTED, reason, apnName);
                                break;
                        }
                        MobileDataStateTracker.this.mSamplingDataTracker.resetSamplingData();
                    } else if (TextUtils.equals(reason, "linkPropertiesChanged")) {
                        MobileDataStateTracker.this.mLinkProperties = (LinkProperties) intent.getParcelableExtra(TelephonyManager.EXTRA_DATA_LINK_PROPERTIES_KEY);
                        if (MobileDataStateTracker.this.mLinkProperties == null) {
                            MobileDataStateTracker.this.loge("No link property in LINK_PROPERTIES change event.");
                            MobileDataStateTracker.this.mLinkProperties = new LinkProperties();
                        }
                        MobileDataStateTracker.this.mNetworkInfo.setDetailedState(MobileDataStateTracker.this.mNetworkInfo.getDetailedState(), reason, MobileDataStateTracker.this.mNetworkInfo.getExtraInfo());
                        MobileDataStateTracker.this.mTarget.obtainMessage(NetworkStateTracker.EVENT_CONFIGURATION_CHANGED, MobileDataStateTracker.this.mNetworkInfo).sendToTarget();
                    }
                }
            } else if (intent.getAction().equals("android.intent.action.DATA_CONNECTION_FAILED") && TextUtils.equals(intent.getStringExtra(TelephonyManager.EXTRA_DATA_APN_TYPE), MobileDataStateTracker.this.mApnType)) {
                MobileDataStateTracker.this.mNetworkInfo.setIsConnectedToProvisioningNetwork(MobileDataStateTracker.DBG);
                MobileDataStateTracker.this.setDetailedState(DetailedState.FAILED, intent.getStringExtra(TelephonyManager.EXTRA_DATA_CHANGE_REASON), intent.getStringExtra(TelephonyManager.EXTRA_DATA_APN));
            }
        }
    }

    static class NetworkDataEntry {
        public int downloadBandwidth;
        public int latency;
        public int networkType;
        public int uploadBandwidth;

        NetworkDataEntry(int i1, int i2, int i3, int i4) {
            this.networkType = i1;
            this.downloadBandwidth = i2;
            this.uploadBandwidth = i3;
            this.latency = i4;
        }
    }

    public MobileDataStateTracker(int netType, String tag) {
        this.mTeardownRequested = DBG;
        this.mPrivateDnsRouteSet = DBG;
        this.mDefaultRouteSet = DBG;
        this.mUserDataEnabled = true;
        this.mPolicyDataEnabled = true;
        this.mIsCaptivePortal = new AtomicBoolean(DBG);
        this.mSamplingDataTracker = new SamplingDataTracker();
        this.mPhoneStateListener = new C04861();
        this.mNetworkInfo = new NetworkInfo(netType, TelephonyManager.getDefault().getNetworkType(), tag, TelephonyManager.getDefault().getNetworkTypeName());
        this.mApnType = networkTypeToApnType(netType);
    }

    public void startMonitoring(Context context, Handler target) {
        this.mTarget = target;
        this.mContext = context;
        this.mHandler = new MdstHandler(target.getLooper(), this);
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.ANY_DATA_STATE");
        filter.addAction("android.intent.action.DATA_CONNECTION_CONNECTED_TO_PROVISIONING_APN");
        filter.addAction("android.intent.action.DATA_CONNECTION_FAILED");
        this.mContext.registerReceiver(new MobileDataStateReceiver(), filter);
        this.mMobileDataState = DataState.DISCONNECTED;
        ((TelephonyManager) this.mContext.getSystemService(Context.TELEPHONY_SERVICE)).listen(this.mPhoneStateListener, InputMethodManager.CONTROL_START_INITIAL);
    }

    public boolean isPrivateDnsRouteSet() {
        return this.mPrivateDnsRouteSet;
    }

    public void privateDnsRouteSet(boolean enabled) {
        this.mPrivateDnsRouteSet = enabled;
    }

    public NetworkInfo getNetworkInfo() {
        return this.mNetworkInfo;
    }

    public boolean isDefaultRouteSet() {
        return this.mDefaultRouteSet;
    }

    public void defaultRouteSet(boolean enabled) {
        this.mDefaultRouteSet = enabled;
    }

    public void releaseWakeLock() {
    }

    private void updateLinkProperitesAndCapatilities(Intent intent) {
        this.mLinkProperties = (LinkProperties) intent.getParcelableExtra(TelephonyManager.EXTRA_DATA_LINK_PROPERTIES_KEY);
        if (this.mLinkProperties == null) {
            loge("CONNECTED event did not supply link properties.");
            this.mLinkProperties = new LinkProperties();
        }
        this.mLinkProperties.setMtu(this.mContext.getResources().getInteger(17694842));
        this.mNetworkCapabilities = (NetworkCapabilities) intent.getParcelableExtra(WifiManager.EXTRA_NETWORK_CAPABILITIES);
        if (this.mNetworkCapabilities == null) {
            loge("CONNECTED event did not supply network capabilities.");
            this.mNetworkCapabilities = new NetworkCapabilities();
        }
    }

    private void getPhoneService(boolean forceRefresh) {
        if (this.mPhoneService == null || forceRefresh) {
            this.mPhoneService = Stub.asInterface(ServiceManager.getService(Context.TELEPHONY_SERVICE));
        }
    }

    public boolean isAvailable() {
        return this.mNetworkInfo.isAvailable();
    }

    public String getTcpBufferSizesPropName() {
        String networkTypeStr = Environment.MEDIA_UNKNOWN;
        TelephonyManager tm = new TelephonyManager(this.mContext);
        switch (tm.getNetworkType()) {
            case Toast.LENGTH_LONG /*1*/:
                networkTypeStr = "gprs";
                break;
            case Action.MERGE_IGNORE /*2*/:
                networkTypeStr = "edge";
                break;
            case SetDrawableParameters.TAG /*3*/:
                networkTypeStr = "umts";
                break;
            case ViewGroupAction.TAG /*4*/:
                networkTypeStr = "cdma";
                break;
            case ReflectionActionWithoutParams.TAG /*5*/:
                networkTypeStr = "evdo";
                break;
            case SetEmptyView.TAG /*6*/:
                networkTypeStr = "evdo";
                break;
            case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
                networkTypeStr = "1xrtt";
                break;
            case SetPendingIntentTemplate.TAG /*8*/:
                networkTypeStr = "hsdpa";
                break;
            case SetOnClickFillInIntent.TAG /*9*/:
                networkTypeStr = "hsupa";
                break;
            case SetRemoteViewsAdapterIntent.TAG /*10*/:
                networkTypeStr = "hspa";
                break;
            case TextViewDrawableAction.TAG /*11*/:
                networkTypeStr = "iden";
                break;
            case BitmapReflectionAction.TAG /*12*/:
                networkTypeStr = "evdo";
                break;
            case TextViewSizeAction.TAG /*13*/:
                networkTypeStr = "lte";
                break;
            case ViewPaddingAction.TAG /*14*/:
                networkTypeStr = "ehrpd";
                break;
            case SetRemoteViewsAdapterList.TAG /*15*/:
                networkTypeStr = "hspap";
                break;
            default:
                loge("unknown network type: " + tm.getNetworkType());
                break;
        }
        return "net.tcp.buffersize." + networkTypeStr;
    }

    public boolean teardown() {
        setTeardownRequested(true);
        if (setEnableApn(this.mApnType, DBG) != 3) {
            return true;
        }
        return DBG;
    }

    public boolean isReady() {
        return this.mDataConnectionTrackerAc != null ? true : DBG;
    }

    public void captivePortalCheckCompleted(boolean isCaptivePortal) {
        if (this.mIsCaptivePortal.getAndSet(isCaptivePortal) != isCaptivePortal) {
            setEnableFailFastMobileData(isCaptivePortal ? 1 : 0);
        }
    }

    private void setDetailedState(DetailedState state, String reason, String extraInfo) {
        if (state != this.mNetworkInfo.getDetailedState()) {
            boolean wasConnecting = this.mNetworkInfo.getState() == State.CONNECTING ? true : DBG;
            String lastReason = this.mNetworkInfo.getReason();
            if (wasConnecting && state == DetailedState.CONNECTED && reason == null && lastReason != null) {
                reason = lastReason;
            }
            this.mNetworkInfo.setDetailedState(state, reason, extraInfo);
            this.mTarget.obtainMessage(KeyEvent.META_META_MASK, new NetworkInfo(this.mNetworkInfo)).sendToTarget();
        }
    }

    public void setTeardownRequested(boolean isRequested) {
        this.mTeardownRequested = isRequested;
    }

    public boolean isTeardownRequested() {
        return this.mTeardownRequested;
    }

    public boolean reconnect() {
        setTeardownRequested(DBG);
        switch (setEnableApn(this.mApnType, true)) {
            case Toast.LENGTH_SHORT /*0*/:
                return true;
            case Toast.LENGTH_LONG /*1*/:
                this.mNetworkInfo.setDetailedState(DetailedState.IDLE, null, null);
                return true;
            case Action.MERGE_IGNORE /*2*/:
            case SetDrawableParameters.TAG /*3*/:
                return DBG;
            default:
                loge("Error in reconnect - unexpected response.");
                return DBG;
        }
    }

    public boolean setRadio(boolean turnOn) {
        getPhoneService(DBG);
        int retry = 0;
        while (retry < 2) {
            if (this.mPhoneService == null) {
                loge("Ignoring mobile radio request because could not acquire PhoneService");
                break;
            }
            try {
                return this.mPhoneService.setRadio(turnOn);
            } catch (RemoteException e) {
                if (retry == 0) {
                    getPhoneService(true);
                }
                retry++;
            }
        }
        loge("Could not set radio power to " + (turnOn ? Parameters.ZSL_ON : Parameters.ZSL_OFF));
        return DBG;
    }

    public void setInternalDataEnable(boolean enabled) {
        AsyncChannel channel = this.mDataConnectionTrackerAc;
        if (channel != null) {
            channel.sendMessage(270363, enabled ? 1 : 0);
        }
    }

    public void setUserDataEnable(boolean enabled) {
        AsyncChannel channel = this.mDataConnectionTrackerAc;
        if (channel != null) {
            channel.sendMessage(270366, enabled ? 1 : 0);
            this.mUserDataEnabled = enabled;
        }
    }

    public void setPolicyDataEnable(boolean enabled) {
        AsyncChannel channel = this.mDataConnectionTrackerAc;
        if (channel != null) {
            channel.sendMessage(270368, enabled ? 1 : 0);
            this.mPolicyDataEnabled = enabled;
        }
    }

    public void setEnableFailFastMobileData(int enabled) {
        AsyncChannel channel = this.mDataConnectionTrackerAc;
        if (channel != null) {
            channel.sendMessage(270372, enabled);
        }
    }

    public void setDependencyMet(boolean met) {
        Bundle bundle = Bundle.forPair(TelephonyManager.EXTRA_DATA_APN_TYPE, this.mApnType);
        try {
            Message msg = Message.obtain();
            msg.what = 270367;
            msg.arg1 = met ? 1 : 0;
            msg.setData(bundle);
            this.mDataConnectionTrackerAc.sendMessage(msg);
        } catch (NullPointerException e) {
            loge("setDependencyMet: X mAc was null" + e);
        }
    }

    public void enableMobileProvisioning(String url) {
        AsyncChannel channel = this.mDataConnectionTrackerAc;
        if (channel != null) {
            Message msg = Message.obtain();
            msg.what = 270373;
            msg.setData(Bundle.forPair("provisioningUrl", url));
            channel.sendMessage(msg);
        }
    }

    public boolean isProvisioningNetwork() {
        try {
            Message msg = Message.obtain();
            msg.what = 270374;
            msg.setData(Bundle.forPair(TelephonyManager.EXTRA_DATA_APN_TYPE, this.mApnType));
            if (this.mDataConnectionTrackerAc.sendMessageSynchronously(msg).arg1 == 1) {
                return true;
            }
            return DBG;
        } catch (NullPointerException e) {
            loge("isProvisioningNetwork: X " + e);
            return DBG;
        }
    }

    public String toString() {
        CharArrayWriter writer = new CharArrayWriter();
        PrintWriter pw = new PrintWriter(writer);
        pw.print("Mobile data state: ");
        pw.println(this.mMobileDataState);
        pw.print("Data enabled: user=");
        pw.print(this.mUserDataEnabled);
        pw.print(", policy=");
        pw.println(this.mPolicyDataEnabled);
        return writer.toString();
    }

    private int setEnableApn(String apnType, boolean enable) {
        getPhoneService(DBG);
        for (int retry = 0; retry < 2; retry++) {
            if (this.mPhoneService == null) {
                loge("Ignoring feature request because could not acquire PhoneService");
                break;
            }
        }
        loge("Could not " + (enable ? Parameters.SKIN_TONE_ENHANCEMENT_ENABLE : Parameters.SKIN_TONE_ENHANCEMENT_DISABLE) + " APN type \"" + apnType + "\"");
        return 3;
    }

    public static String networkTypeToApnType(int netType) {
        switch (netType) {
            case Toast.LENGTH_SHORT /*0*/:
                return "default";
            case Action.MERGE_IGNORE /*2*/:
                return "mms";
            case SetDrawableParameters.TAG /*3*/:
                return "supl";
            case ViewGroupAction.TAG /*4*/:
                return "dun";
            case ReflectionActionWithoutParams.TAG /*5*/:
                return "hipri";
            case SetRemoteViewsAdapterIntent.TAG /*10*/:
                return "fota";
            case TextViewDrawableAction.TAG /*11*/:
                return "ims";
            case BitmapReflectionAction.TAG /*12*/:
                return "cbs";
            case ViewPaddingAction.TAG /*14*/:
                return "ia";
            case SetRemoteViewsAdapterList.TAG /*15*/:
                return "emergency";
            default:
                sloge("Error mapping networkType " + netType + " to apnType.");
                return null;
        }
    }

    public LinkProperties getLinkProperties() {
        return new LinkProperties(this.mLinkProperties);
    }

    public void supplyMessenger(Messenger messenger) {
        new AsyncChannel().connect(this.mContext, this.mHandler, messenger);
    }

    private void log(String s) {
        Slog.d(TAG, this.mApnType + ": " + s);
    }

    private void loge(String s) {
        Slog.e(TAG, this.mApnType + ": " + s);
    }

    private static void sloge(String s) {
        Slog.e(TAG, s);
    }

    public LinkQualityInfo getLinkQualityInfo() {
        if (this.mNetworkInfo == null || this.mNetworkInfo.getType() == -1) {
            return null;
        }
        LinkQualityInfo li = new MobileLinkQualityInfo();
        li.setNetworkType(this.mNetworkInfo.getType());
        this.mSamplingDataTracker.setCommonLinkQualityInfoFields(li);
        if (this.mNetworkInfo.getSubtype() != 0) {
            li.setMobileNetworkType(this.mNetworkInfo.getSubtype());
            NetworkDataEntry entry = getNetworkDataEntry(this.mNetworkInfo.getSubtype());
            if (entry != null) {
                li.setTheoreticalRxBandwidth(entry.downloadBandwidth);
                li.setTheoreticalRxBandwidth(entry.uploadBandwidth);
                li.setTheoreticalLatency(entry.latency);
            }
            if (this.mSignalStrength != null) {
                li.setNormalizedSignalStrength(getNormalizedSignalStrength(li.getMobileNetworkType(), this.mSignalStrength));
            }
        }
        SignalStrength ss = this.mSignalStrength;
        if (ss == null) {
            return li;
        }
        li.setRssi(ss.getGsmSignalStrength());
        li.setGsmErrorRate(ss.getGsmBitErrorRate());
        li.setCdmaDbm(ss.getCdmaDbm());
        li.setCdmaEcio(ss.getCdmaEcio());
        li.setEvdoDbm(ss.getEvdoDbm());
        li.setEvdoEcio(ss.getEvdoEcio());
        li.setEvdoSnr(ss.getEvdoSnr());
        li.setLteSignalStrength(ss.getLteSignalStrength());
        li.setLteRsrp(ss.getLteRsrp());
        li.setLteRsrq(ss.getLteRsrq());
        li.setLteRssnr(ss.getLteRssnr());
        li.setLteCqi(ss.getLteCqi());
        return li;
    }

    static {
        mTheoreticalBWTable = new NetworkDataEntry[]{new NetworkDataEntry(2, KeyEvent.KEYCODE_TV_SATELLITE, KeyEvent.KEYCODE_META_RIGHT, UNKNOWN), new NetworkDataEntry(1, 48, 40, UNKNOWN), new NetworkDataEntry(3, 384, 64, UNKNOWN), new NetworkDataEntry(8, 14400, UNKNOWN, UNKNOWN), new NetworkDataEntry(9, 14400, 5760, UNKNOWN), new NetworkDataEntry(10, 14400, 5760, UNKNOWN), new NetworkDataEntry(15, 21000, 5760, UNKNOWN), new NetworkDataEntry(4, UNKNOWN, UNKNOWN, UNKNOWN), new NetworkDataEntry(7, UNKNOWN, UNKNOWN, UNKNOWN), new NetworkDataEntry(5, 2468, KeyEvent.KEYCODE_NUMPAD_9, UNKNOWN), new NetworkDataEntry(6, 3072, Device.WEARABLE_PAGER, UNKNOWN), new NetworkDataEntry(12, 14700, Device.WEARABLE_PAGER, UNKNOWN), new NetworkDataEntry(11, UNKNOWN, UNKNOWN, UNKNOWN), new NetworkDataEntry(13, UserHandle.PER_USER_RANGE, Process.FIRST_SHARED_APPLICATION_GID, UNKNOWN), new NetworkDataEntry(14, UNKNOWN, UNKNOWN, UNKNOWN)};
    }

    private static NetworkDataEntry getNetworkDataEntry(int networkType) {
        for (NetworkDataEntry entry : mTheoreticalBWTable) {
            if (entry.networkType == networkType) {
                return entry;
            }
        }
        Slog.e(TAG, "Could not find Theoretical BW entry for " + String.valueOf(networkType));
        return null;
    }

    private static int getNormalizedSignalStrength(int networkType, SignalStrength ss) {
        int level;
        switch (networkType) {
            case Toast.LENGTH_LONG /*1*/:
            case Action.MERGE_IGNORE /*2*/:
            case SetDrawableParameters.TAG /*3*/:
            case SetPendingIntentTemplate.TAG /*8*/:
            case SetOnClickFillInIntent.TAG /*9*/:
            case SetRemoteViewsAdapterIntent.TAG /*10*/:
            case SetRemoteViewsAdapterList.TAG /*15*/:
                level = ss.getGsmLevel();
                break;
            case ViewGroupAction.TAG /*4*/:
            case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
                level = ss.getCdmaLevel();
                break;
            case ReflectionActionWithoutParams.TAG /*5*/:
            case SetEmptyView.TAG /*6*/:
            case BitmapReflectionAction.TAG /*12*/:
                level = ss.getEvdoLevel();
                break;
            case TextViewSizeAction.TAG /*13*/:
                level = ss.getLteLevel();
                break;
            default:
                return UNKNOWN;
        }
        return (level * 100) / 5;
    }

    public void startSampling(SamplingSnapshot s) {
        this.mSamplingDataTracker.startSampling(s);
    }

    public void stopSampling(SamplingSnapshot s) {
        this.mSamplingDataTracker.stopSampling(s);
    }
}
